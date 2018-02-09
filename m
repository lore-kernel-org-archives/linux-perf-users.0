From: Kim Phillips <kim.phillips@arm.com>
Subject: Re: Recording memory addresses on ARM
Date: Thu, 8 Feb 2018 21:20:21 -0600
Message-ID: <20180208212021.3bc3adc85abdcfb2cd4fd2e7@arm.com>
References: <42BDBD72-87FE-4DFA-8A5D-6CEB2DAF1262@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42582 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752201AbeBIDUX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 8 Feb 2018 22:20:23 -0500
In-Reply-To: <42BDBD72-87FE-4DFA-8A5D-6CEB2DAF1262@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Christian Hansen (chansen3)" <chansen3@cisco.com>, coresight@lists.linaro.org
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Thu, 8 Feb 2018 15:17:33 +0000
"Christian Hansen (chansen3)" <chansen3@cisco.com> wrote:

> Is is possible to capture the address of memory accesses using perf on
> ARM?  Initially, I thought perf-mem would do the trick, but apparently
> its functionality is entirely dependent on Intel CPUs with PEBS.

Right.

> Then I noticed that perf-record takes a -d flag (used by perf-mem).
> Although the description of that flag is vague (capture what addresses?
> ), when used as such "perf record -e armv8_cortex_a72/mem_access/u -d
> -p 16963 sleep 5” and then dumping the trace via “perf report —
> mem-mode” I get 0s in the data symbol column.  So this also appears to
> have no effect on my hardware.  As the command used reveals, I’m using
> perf on a Cortex A72 and on Linux 4.4.

I see ./perf report --help says:

       --mem-mode
           Use the data addresses of samples in addition to instruction addresses to build the histograms. To generate meaningful output,
           the perf.data file must have been obtained using perf record -d -W and using a special event -e cpu/mem-loads/ or -e
           cpu/mem-stores/. See perf mem for simpler access.

yet perf record's -W switch isn't on record's manpage, and trying the
invocation sequence on x86 using a perf built from today's acme's
perf/urgent branch:

$ ./perf version
perf version 4.13.rc5.g59410f5
$ ./perf record -e cpu/mem-loads/u -d -W -p 3722 sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 8.978 MB perf.data ]
$ ./perf report --mem-mode --stdio
Error:
The perf.data file has no samples!
# To display the perf.data header info, please use --header/--header-only options.
#
$ 

A 'perf mem record sleep 1; perf mem report' sequence produces samples
in its output, but 'mem record' doesn't take a -p switch for the PID,
rather, -p means --phys-data, "Record/Report sample physical
addresses", which also doesn't seem to work:

$ perf mem -p record sleep 1
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cpu/mem-loads,ldlat=30/P).
/bin/dmesg may provide additional information.
No CONFIG_PERF_EVENTS=y kernel support configured?

Nevertheless, on Arm, the armv8_cortex_a72/mem_access/ is a counting
PMU, so it doesn't record the address of the memory access, just
where in the code the access came from.

> I’m aware that for ARM there’s a Statistical Profiling Extension for
> which support went into the kernel recently and which could potentially
> support this information, but that requires ARMv8.2.  There’s an

Ack.

> Embedded Trace Macrocell on my CPU and perf support is also in the
> kernel, but my understanding is that capturing a data trace is not
> available for A profile CPUs, which is what I have.

No, Cortex-As should be supported by the Coresight driver no problem.
Try acme's perf/core tree, where support for linking with decode 

> Am I overlooking some software support for this in perf or am I simply asking the impossible?

You're on the right track: Coresight trace h/w is able to record memory
accesses, but I don't know its enablement status, so I'm adding the
coresight mailing list to cc in case anyone there can chime in and help.

Thanks,

Kim
