From: Andi Kleen <andi@firstfloor.org>
Subject: Re: QEMU-KVM metrics collection | Calculation of instructions performed from perf events
Date: Wed, 05 Jul 2017 10:20:02 -0700
Message-ID: <874luq7qd9.fsf@firstfloor.org>
References: <15d0cf6ed40.ad8fdbd059031.2271426277329799808@zoho.eu>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:54507 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751745AbdGERUH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Jul 2017 13:20:07 -0400
In-Reply-To: <15d0cf6ed40.ad8fdbd059031.2271426277329799808@zoho.eu> (Elena
        Talkova's message of "Tue, 04 Jul 2017 12:38:15 +0300")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Elena Talkova <e.talkova@zoho.eu>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>

Elena Talkova <e.talkova@zoho.eu> writes:
>
> I have 2 problems so far:
>
> 1) I'm not sure how to use all available events to calculate number of instructions performed (integer and floating-points)

You would need a better definition. There's no way
to count "all integer" instructions. Just all instructions,
or some specific classes of instructions.

If you need an exact instruction histogram the only
way is to use special instrumentation tools like pin.

> 2) I get totally different results when running perf for a process on
> host machine and for a virtual machine process (with VM values often
> being just zeros)

Measuring the counts from the host should work, except for
PEBS events.

> Sandy bridge:
>
> FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE

These events are difficult to use because they include speculative and
re-issued execution, which can be high. Typically you need a significant
workload specific correction factor.

The retired Broadwell, Skylake events below don't have this problem. But it's
still not "all floating point" instructions, just all floating point
arithmetic.

-Andi
