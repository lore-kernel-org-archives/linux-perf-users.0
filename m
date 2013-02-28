From: David Ahern <dsahern@gmail.com>
Subject: Re: Tracing kvm: kvm_entry and kvm_exit
Date: Wed, 27 Feb 2013 21:49:24 -0700
Message-ID: <512EE1D4.6080808@gmail.com>
References: <1361550867.51279e13338a7@www.imp.polymtl.ca> <20130225101804.GC2790@stefanha-thinkpad.redhat.com> <512E36B2.5090100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-da0-f44.google.com ([209.85.210.44]:56655 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956Ab3B1Et1 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 27 Feb 2013 23:49:27 -0500
In-Reply-To: <512E36B2.5090100@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Mohamad Gebai <mohamad.gebai@polymtl.ca>, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org

On 2/27/13 9:39 AM, David Ahern wrote:
> I have been playing with the live mode a bit lately. I'll add a debug to
> note 2 consecutive entry events without an exit -- see if it sheds some
> light on it.

If you feel game take this for a spin:
   https://github.com/dsahern/linux/commits/perf-kvm-live-3.8

I pushed a few more commits that add debugs to show consecutive events 
(2 entries or 2 exits), max and min times for various exit reasons and 
an option to dump events that take longer than some threshold. If you 
dump the output to a file or run screen with logging you should be able 
to find when the 'long' event happens and which VMEXIT reason was the cause.

Example screen dump:

21:47:37.935302

Analyze events for all VMs, all VCPUs:

              VM-EXIT    Samples  Samples%     Time%   Min Time   Max 
Time         Avg time

          APIC_ACCESS        978    61.51%     0.02%        1us 
113us      7.81us ( +-   3.67% )
       IO_INSTRUCTION        212    13.33%     0.00%        2us 
85us      9.20us ( +-   7.57% )
            CR_ACCESS         93     5.85%     0.00%        2us 
66us      3.49us ( +-  19.73% )
   EXTERNAL_INTERRUPT         53     3.33%     0.01%        3us 
135us     57.02us ( +-   6.59% )
        EXCEPTION_NMI         26     1.64%     0.00%        2us 
3us      2.57us ( +-   1.74% )
    PENDING_INTERRUPT          3     0.19%     0.00%        1us 
1us      1.85us ( +-   4.18% )

Total Samples:1590, Total events handled time:39942741.62us.

295170818723592 VM 11854, vcpu 3: APIC_ACCESS event took 113usec
295170819686668 VM 11854, vcpu 0: EXTERNAL_INTERRUPT event took 112usec
295172155051688 VM 11854, vcpu 0: EXTERNAL_INTERRUPT event took 119usec
295172841724899 VM 11854, vcpu 0: APIC_ACCESS event took 129usec
295172999633325 VM 11854, vcpu 0: EXTERNAL_INTERRUPT event took 111usec

David
