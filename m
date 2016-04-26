From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: Misleading hint to select CONFIG_PERF_EVENTS if driver sets
 PERF_PMU_CAP_NO_INTERRUPT
Date: Tue, 26 Apr 2016 12:42:19 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F4E9F42D@us01wembx1.internal.synopsys.com>
References: <1461331523.3403.11.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:57633 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbcDZMmW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 26 Apr 2016 08:42:22 -0400
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Lada Trimasova <Lada.Trimasova@synopsys.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Cc: "peterz@infradead.org" <peterz@infradead.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Friday 22 April 2016 06:56 PM, Lada Trimasova wrote:
> I have a question about user-space perf handling error numbers.
> The problem is that PMU interrupts are not supported in arc700
> architecture and it is impossible to evaluate `perf record` command.
> In our perf implementation we set PERF_PMU_CAP_NO_INTERRUPT flag so
> core perf infrastructure knows we don't have interrupts.
>
> Kernel `sys_perf_event_open` handler checks if PMU interrupts are
> supported and returns ENOTSUPP (524) error code.
> I'd expect that perf implementation checks the return value of syscalls
> and gives the user understandable error message.
> But now I see:
> --------------------------------->8-----------------------------------
> # perf record ls
> The sys_perf_event_open() syscall returned with 524 (Unknown error 524)
> for event (cycles:ppp).

I think what we have now is sufficient - but u seem to want a prettier failure output.

Anyhow, this print is coming from util/evsel.c: perf_evsel__open_strerror()
At the very least you want another entry in switch case for ENOTSUPP and then
check if event was sampling one (
evsel->attr.sample_period) - use that as a hint for saying sampling events not
supported.

But this will print the same even if CONFIG_PERF_EVENTS=n. To really fix this you
would want to change the error code returned by SYSCALL_DEFINE5(perf_event_open
for PERF_PMU_CAP_NO_INTERRUPT to say -EOPNOTSUPP and use the sample_period to say
this was for samplign events! However this is an ABI change and might not be
acceptable as some existing scripts etc might break.

> /bin/dmesg may provide additional information.
> No CONFIG_PERF_EVENTS=y kernel support configured?
> --------------------------------->8-----------------------------------
>
> As you can see the root cause of this error message is not obvious.
> CONFIG_PERF_EVENTS is selected but still there's a problem while
> existing suggestion barely makes any sense.
> So probably there could be a way to determine if CONFIG_PERF_EVENTS was
> selected or not.
>
> I am not sure about the correct way of solving this problem. Maybe I
> should add some checks of syscalls return values and give user
> a warning when not PMU interrupts are available. 
> Any suggestions are appreciated.
>
> Regards,
> Lada Trimasova.
> _______________________________________________
> linux-snps-arc mailing list
> linux-snps-arc@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-snps-arc
