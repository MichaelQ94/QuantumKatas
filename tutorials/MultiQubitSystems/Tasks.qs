// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT license.

//////////////////////////////////////////////////////////////////
// This file is a back end for the tasks in the tutorial.
// We strongly recommend to use the Notebook version of the tutorial
// to enjoy the full experience.
//////////////////////////////////////////////////////////////////

namespace Quantum.Kata.MultiQubitSystems {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation PrepareState1 (qs : Qubit[]) : Unit is Adj+Ctl {
        X(qs[0]); X(qs[1]);
    }

    operation PrepareState2 (qs : Qubit[]) : Unit is Adj+Ctl {
        X(qs[1]); H(qs[1]);
    }

    operation PrepareState3 (qs : Qubit[]) : Unit is Adj+Ctl {
        PrepareState2(qs); H(qs[0]);
    }

    operation PrepareState4 (qs : Qubit[]) : Unit is Adj+Ctl {
        H(qs[0]); H(qs[1]); T(qs[1]); S(qs[0]);
    }
}