// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT license.

//////////////////////////////////////////////////////////////////
// This file is a back end for the tasks in Deutsch-Jozsa algorithm tutorial.
// We strongly recommend to use the Notebook version of the tutorial
// to enjoy the full experience.
//////////////////////////////////////////////////////////////////

namespace Quantum.Kata.DeutschJozsaAlgorithm {
    
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Math;
    
    
    //////////////////////////////////////////////////////////////////
    // Part I. Classical algorithm
    //////////////////////////////////////////////////////////////////

    // Exercise 1.
    function Function_MostSignificantBit (x : Int, N : Int) : Int {
        // ( X )( Y )...( Y )
        // (n-1)(n-2)...( 0 )
        mutable msb = x;
        mutable nBits = N;
        while(nBits > 1) {
            set msb /= 2;
            set nBits -= 1;
        }
        return msb;
    }

    // Exercise 2. 
    function IsFunctionConstant_Classical (N : Int, f : (Int -> Int)) : Bool {
        mutable zeroesAndOnes = new Int[2]; 
        for (i in 0 .. (2 ^ (N - 1)) + 1) {
            let n = f(i);
            set zeroesAndOnes w/= n <- zeroesAndOnes[n] + 1;
        }
        return AbsI(zeroesAndOnes[0] - zeroesAndOnes[1]) > 1;
    }

    //////////////////////////////////////////////////////////////////
    // Part II. Quantum oracles
    //////////////////////////////////////////////////////////////////
    
    // Exercise 3.
    operation PhaseOracle_MostSignificantBit (x : Qubit[]) : Unit {
        Z(x[0]);
    }

    operation MeasureIfAllQubitsAreZero(qubits : Qubit[], pauli : Pauli) : Bool {
        mutable value = true;
        for (qubit in qubits) {
            if (M(qubit) == One) {
                set value = false;
                X(qubit);
            }
        }
        return value;
    }

    //////////////////////////////////////////////////////////////////
    // Part III. Quantum algorithm
    //////////////////////////////////////////////////////////////////
    
    // Exercise 4.
    operation DeutschJozsaAlgorithm (N : Int, oracle : (Qubit[] => Unit)) : Bool {
        using (qs = Qubit[N]) {
            ApplyToEach(H, qs);
            oracle(qs);
            ApplyToEach(H, qs);
            return MeasureIfAllQubitsAreZero(qs, PauliZ);
        }
    }
}