From: Elena Talkova <e.talkova@zoho.eu>
Subject: QEMU-KVM metrics collection | Calculation of instructions performed
 from perf events
Date: Tue, 04 Jul 2017 12:38:15 +0300
Message-ID: <15d0cf6ed40.ad8fdbd059031.2271426277329799808@zoho.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sender21-mail.zoho.eu ([31.186.226.21]:21208 "EHLO
        sender21-mail.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752040AbdGDJxY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 4 Jul 2017 05:53:24 -0400
In-Reply-To: 
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users <linux-perf-users@vger.kernel.org>

Hi everyone,


I'm trying to gather metrics about the number of integer & floating point operations and instructions performed on different CPUs. In particular, I run perf from the host machine for regular processes and for qemu-kvm virtual machine processes.

I see that perf has multiple events related to this topic on each type of CPU I try it on. But I'm not sure of how to make sense of this data.

I have 2 problems so far:

1) I'm not sure how to use all available events to calculate number of instructions performed (integer and floating-points)

2) I get totally different results when running perf for a process on host machine and for a virtual machine process (with VM values often being just zeros)


So, my questions are:

1) Could you please specify any reliable sources of info on how to process these events in order to get number of instructions actually performed? I'm sure I'm not the only one interested in this and I want to learn how do other people do it instead of inventing my own bicycle.

2) Where should I look for differences in perf results for VM processes? Is there any workaround for that? Again, I'm talking here about qemu-kvm VMs in particular.


Here are the events I'm trying to work with for 2 CPU groups I'm using.

Sandy bridge:

FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE

FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE

FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE

FP_COMP_OPS_EXE.SSE_PACKED_SINGLE

SIMD_FP_256.PACKED_DOUBLE

SIMD_FP_256.PACKED_SINGLE

Broadwell, Skylake:

FP_ARITH_INST_RETIRED.SCALAR_SINGLE

FP_ARITH_INST_RETIRED.SCALAR_DOUBLE

FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE

FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE

FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE

FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE


Thanks!
Best regards, Elena
