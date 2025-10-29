Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A42283129;
	Wed, 29 Oct 2025 02:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761705805; cv=none; b=RaWX7XtEkUpuXRZ2V9Nix61N1v8L4lemEBGXzC8j5JZ1X9nGXdc+08Cx82/UlHhjXQG2VnsBLFEDqHkARklu26HAhHCDfsg5sI1TmUs7migPpGb9hYRLJzo0tHSww0OxN/atXoembwB0Kf+w7vAyLeBxhQ5gmqxj+6NlYHvJvLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761705805; c=relaxed/simple;
	bh=Km83RPcsFyOOaHMC0IXrd8w/TKJKJjJESuj/zLlhIeY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=L5jHV1QfkAXxFGpqAJDDqAVDLvSUSDnR7gqwVVYv0//WVYwxlhVo709xV8QuVZz8+T+Fqybiprx6sXgzeXNYnWy/a+Sj9C0z2bAUOY/L9uF6yNe+mm2PZKHYe1dmEAA4XqOA9Q4NLaUps65RnnKWvuij93Tfpjt5kshsHv6Qyjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUez+F0C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUez+F0C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C86C4CEFD;
	Wed, 29 Oct 2025 02:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761705804;
	bh=Km83RPcsFyOOaHMC0IXrd8w/TKJKJjJESuj/zLlhIeY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bUez+F0C+mbjixIPs6/hVqz+YUV9Qv8Ide9LxpNZCNtWbDQEsiBKA62iBhXhbzk0g
	 ODpTKlZqPCDwcv/xiA7X8ZJ0fMnsRlopbFUvy4vq7kNFdqHYPkfuJhy3EmguhCfi6F
	 XCT04x95a5UA4+NLvTN+Cf8LK9Gc5jkmdsH+GBkHIFuvz8j1KOnBVkwD11+CUTipqC
	 FsvJFlX6jT/D7ahOc48XZxT6tUKBIhJ/AhPqyr9gPBI/o8LFlQVls1C1YJewS+Gr4P
	 oadJoD3Fjf/B93KcYjVDaw+vOpMA25ElW1/Hu1mO8bfhnpY5LoHMpuu6gIOhKYhI61
	 avwMqaX3fP4rg==
Date: Wed, 29 Oct 2025 11:43:17 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Mark Brown <broonie@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, x86@kernel.org, Jinchao Wang
 <wangjinchao600@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v5 6/8] selftests: tracing: Add a basic testcase for
 wprobe
Message-Id: <20251029114317.167b7d908533385c1c9e6782@kernel.org>
In-Reply-To: <20251029004219.dc9cda0eb56ae46c55855844@kernel.org>
References: <175859019940.374439.7398451124225791618.stgit@devnote2>
	<175859026716.374439.14852239332989324292.stgit@devnote2>
	<aPvwGhMBJqMKcC9D@finisterre.sirena.org.uk>
	<20251027224347.4c887cc956df63602f377550@kernel.org>
	<20251028084222.a3c1ae97d125d9bd88fc565b@kernel.org>
	<20251028105549.ae94e8eeb42f4efc183d2807@kernel.org>
	<20251029004219.dc9cda0eb56ae46c55855844@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 00:42:19 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Tue, 28 Oct 2025 10:55:49 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > On Tue, 28 Oct 2025 08:42:22 +0900
> > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > 
> > > ~ # cd /sys/kernel/tracing/
> > > /sys/kernel/tracing # echo 'w:my_wprobe w@jiffies' >> dynamic_events 
> > > /sys/kernel/tracing # echo 1 > events/wprobes/my_wprobe/enable 
> > > [   54.942288] trace_wprobe: enable_trace_wprobe called
> > > [   54.945306] trace_wprobe: trying to register wprobes
> > > [   54.947367] trace_wprobe: __register_trace_wprobe called
> > > [   54.949586] trace_wprobe: registering wprobe at addr: 0xffffb6ce429fb200, len: 4, type: 2
> > > [   54.951639] Creating wide hw breakpoint on CPU 0
> > > [   54.966390] Creating kernel counter on CPU 0 for event type 5
> > > [   54.967758] perf_install_in_context: event 00000000736da1d9 ctx 000000005d4db900 cpu 0
> > > [   54.972015] perf_install_in_context2: event 00000000736da1d9 ctx set to 000000005d4db900
> > > [   54.976697] cpu_function_call: calling function on CPU 0, func: __perf_install_in_context+0x0/0x2c8
> > > 
> > > What happen if the cpu calls function on itself by
> > > smp_call_function_single() on arm64?
> > > 
> > >   smp_call_function_single(this_cpu, remote_function, &data, 1);
> > 
> > Sorry, that was printk buffering issue. I used trace_printk() instead
> > and persistent ring buffer[1] to trace it.
> > 
> > [1] https://docs.kernel.org/trace/debugging.html#persistent-buffers-across-boots
> > 
> > ~ # echo 1 > /sys/kernel/tracing/instances/boot_map/options/trace_printk_dest
> > ~ # echo 'w:my_wprobe w@jiffies' >> /sys/kernel/tracing/dynamic_events 
> > ~ # echo 1 > /sys/kernel/tracing/events/wprobes/my_wprobe/enable 
> > QEMU 8.2.2 monitor - type 'help' for more information
> > (qemu) system_reset
> > ...
> > 
> > ~ # cat /sys/kernel/tracing/instances/boot_map/trace 
> > # tracer: nop
> > #
> > # entries-in-buffer/entries-written: 16/16   #P:1
> > #
> > #                                _-----=> irqs-off/BH-disabled
> > #                               / _----=> need-resched
> > #                              | / _---=> hardirq/softirq
> > #                              || / _--=> preempt-depth
> > #                              ||| / _-=> migrate-disable
> > #                              |||| /     delay
> > #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> > #              | |         |   |||||     |         |
> >            <...>-63      [000] .....    21.065038: register_wide_hw_breakpoint: Creating wide hw breakpoint on CPU 0
> >            <...>-63      [000] .....    21.079678: perf_event_create_kernel_counter: Creating kernel counter on CPU 0 for event type 5
> >            <...>-63      [000] .....    21.080051: perf_install_in_context: perf_install_in_context: event 000000000b3ac4d3 ctx 00000000097d6337 cpu 0
> >            <...>-63      [000] .....    21.080140: perf_install_in_context: perf_install_in_context2: event 000000000b3ac4d3 ctx set to 00000000097d6337
> >            <...>-63      [000] .....    21.080939: cpu_function_call: cpu_function_call: calling function on CPU 0, func: __perf_install_in_context+0x0/0x2f0
> >            <...>-63      [000] .....    21.080966: smp_call_function_single: smp_call_function_single: calling function on CPU 0, func: remote_function+0x0/0x78, wait=1
> >            <...>-63      [000] ...1.    21.080973: smp_call_function_single: smp_call_function_single: running on CPU 0, call CPU 0
> >            <...>-63      [000] ...1.    21.081099: smp_call_function_single: smp_call_function_single: checking for potential deadlock conditions
> >            <...>-63      [000] ...1.    21.081259: generic_exec_single: generic_exec_single: preparing to call function on CPU 0, func: remote_function+0x0/0x78
> >            <...>-63      [000] ...1.    21.081269: generic_exec_single: Executing smp_call_function_single on self CPU 0, func: remote_function+0x0/0x78
> >            <...>-63      [000] d..1.    21.081289: csd_do_func: csd_do_func: CPU 0 executing func remote_function+0x0/0x78
> >            <...>-63      [000] d..1.    21.081429: __perf_install_in_context: __perf_install_in_context: event 000000000b3ac4d3 ctx 00000000097d6337
> >            <...>-63      [000] d..2.    21.083211: hw_breakpoint_control: hw_breakpoint_control: ops=0
> >            <...>-63      [000] d..1.    21.084191: __perf_install_in_context: __perf_install_in_context: event 000000000b3ac4d3 done, ret=0
> >            <...>-63      [000] d..1.    21.084237: csd_do_func: csd_do_func: CPU 0 finished func remote_function+0x0/0x78
> >            <...>-63      [000] d..1.    21.084243: generic_exec_single: Finished csd_lock_record(NULL)
> > ~ # 
> > 
> > 
> > So the last message is right before the local_irq_restore() in
> > generic_exec_single().
> > 
> > static int generic_exec_single(int cpu, call_single_data_t *csd)
> > {
> > 	...
> > 		csd_lock_record(csd);
> > 		csd_unlock(csd);
> > 		local_irq_save(flags);
> > 		csd_do_func(func, info, NULL);
> > 		csd_lock_record(NULL);
> > 		trace_printk("Finished csd_lock_record(NULL)\n"); <- 
> > 		local_irq_restore(flags);
> > 		return 0;
> > 
> > Actually, I added another trace_printk() right after generic_exec_single().
> > 
> > 	err = generic_exec_single(cpu, csd);
> > 	trace_printk("generic_exec_single returned %d for CPU %d, func: %pS\n",
> > 		err, cpu, func);
> > 
> > This means after setting the hw_breakpoint, when enabing the IRQ,
> > the machine is frozen - but qemu is running busy.
> > 
> > Can we specify the kernel memory address to HW breakpoint on arm64?
> 
> Hmm, it seems that jiffies related things are updated frequently
> and it may cause interrupt storm or infinit recursive call.

I added another trace_printk() in el1_watchpt(). It seems el1_watchpt()
takes too long and there is no time to do any other things.
(Note the interval shown below is only within the el1_watchpt function,
 and in reality various processes (save/restore registers etc) for
 exception handling will be inserted before and after.)

   kworker/u32:3-75      [001] d.h2.    43.216706: el1_watchpt: FAR=0xjiffies+0x0/0x40, ESR=0xd6000062, WP index=0, n
est=0
   kworker/u32:3-75      [001] d.h2.    43.216750: el1_watchpt: returning to EL1: nest=0
   kworker/u32:3-75      [001] d.h2.    43.216816: el1_watchpt: FAR=0xjiffies+0x0/0x40, ESR=0xd6000062, WP index=0, n
est=0
   kworker/u32:3-75      [001] d.h2.    43.216860: el1_watchpt: returning to EL1: nest=0
   kworker/u32:3-75      [001] d.h2.    43.216927: el1_watchpt: FAR=0xjiffies+0x0/0x40, ESR=0xd6000062, WP index=0, n
est=0
   kworker/u32:3-75      [001] d.h2.    43.216971: el1_watchpt: returning to EL1: nest=0
   kworker/u32:3-75      [001] d.h2.    43.217058: el1_watchpt: FAR=0xjiffies+0x0/0x40, ESR=0xd6000062, WP index=0, n
est=0
   kworker/u32:3-75      [001] d.h2.    43.217106: el1_watchpt: returning to EL1: nest=0
   kworker/u32:3-75      [001] d.h2.    43.217175: el1_watchpt: FAR=0xjiffies+0x0/0x40, ESR=0xd6000062, WP index=0, n
est=0
   kworker/u32:3-75      [001] d.h2.    43.217219: el1_watchpt: returning to EL1: nest=0

So watching any variables which is frequently updated will
almost freeze the system. Hmmm, the handler should check the
interval and if it is too frequently, it should disable the
wprobe.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
