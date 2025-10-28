Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36211662E7;
	Tue, 28 Oct 2025 01:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761616556; cv=none; b=YFa57RKFoTdmsyeBaMFZOqqRsULOrFrESuPDVb32seFtv6X3Bl1aFIohRelljloBpNW/zRZD62+NB9CPHuARB7v1x3QYJuU29iXEt/6hihZs8+EVIAGfm73sQA1C5mCYkublunJf9/U0eEZtapp65lsEclqSwThhBVwYFTKjNoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761616556; c=relaxed/simple;
	bh=6IlL0RD/b1cmQ2o28E1LFzW/+KMUWhpSmqh1P0RR74k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sHEf8SKDY4L/8SrYQ164Ic25dapc1c0U/+29Xc+fM0EP7bt5L1QLlUzVNPRX35hZrU6dr7+0fd5jtTGPTNbfFFwWDaLkfrRFvb4l/gNvvYnT4urhSZnhK/yj384cZEMCrvLRncPW78gyZ5qFITbdf2UBZeWX3CuRmPiNX23Z+Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdza6PTp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdza6PTp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62A1C4CEF1;
	Tue, 28 Oct 2025 01:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761616556;
	bh=6IlL0RD/b1cmQ2o28E1LFzW/+KMUWhpSmqh1P0RR74k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jdza6PTpVIv54MadO3APb4bau5qFddYhcpvXjSTnjv2TfyE08Z4O4glutGY6oaVhu
	 nYR75QQXC3SO8VyxMdcwoAVaMYw8Xy0BUdy3xJCg64/2eBMukdCrYKZS6TtEKR2ChL
	 vK6A0SuB/mo+5xJJ3XLIYsS+pZRZJ0Abcr6Ni1a6iO1CXyo7+YarkUnsfxILXhESBQ
	 qxbWXagybJU32oddPCU3AnViWYCTgv6gDWtsfwN0AqpXQwRHEO+9YyEUqA2nDm/xxy
	 Vfju0PPjbRwyhvg21/4c5JIrFUZoBKyycNEa44C5NEQq7MuSbeO1+/2kWuELXZDfVL
	 TJcr1Hh5zEHlA==
Date: Tue, 28 Oct 2025 10:55:49 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, Jinchao Wang <wangjinchao600@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v5 6/8] selftests: tracing: Add a basic testcase for
 wprobe
Message-Id: <20251028105549.ae94e8eeb42f4efc183d2807@kernel.org>
In-Reply-To: <20251028084222.a3c1ae97d125d9bd88fc565b@kernel.org>
References: <175859019940.374439.7398451124225791618.stgit@devnote2>
	<175859026716.374439.14852239332989324292.stgit@devnote2>
	<aPvwGhMBJqMKcC9D@finisterre.sirena.org.uk>
	<20251027224347.4c887cc956df63602f377550@kernel.org>
	<20251028084222.a3c1ae97d125d9bd88fc565b@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Oct 2025 08:42:22 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> ~ # cd /sys/kernel/tracing/
> /sys/kernel/tracing # echo 'w:my_wprobe w@jiffies' >> dynamic_events 
> /sys/kernel/tracing # echo 1 > events/wprobes/my_wprobe/enable 
> [   54.942288] trace_wprobe: enable_trace_wprobe called
> [   54.945306] trace_wprobe: trying to register wprobes
> [   54.947367] trace_wprobe: __register_trace_wprobe called
> [   54.949586] trace_wprobe: registering wprobe at addr: 0xffffb6ce429fb200, len: 4, type: 2
> [   54.951639] Creating wide hw breakpoint on CPU 0
> [   54.966390] Creating kernel counter on CPU 0 for event type 5
> [   54.967758] perf_install_in_context: event 00000000736da1d9 ctx 000000005d4db900 cpu 0
> [   54.972015] perf_install_in_context2: event 00000000736da1d9 ctx set to 000000005d4db900
> [   54.976697] cpu_function_call: calling function on CPU 0, func: __perf_install_in_context+0x0/0x2c8
> 
> What happen if the cpu calls function on itself by
> smp_call_function_single() on arm64?
> 
>   smp_call_function_single(this_cpu, remote_function, &data, 1);

Sorry, that was printk buffering issue. I used trace_printk() instead
and persistent ring buffer[1] to trace it.

[1] https://docs.kernel.org/trace/debugging.html#persistent-buffers-across-boots

~ # echo 1 > /sys/kernel/tracing/instances/boot_map/options/trace_printk_dest
~ # echo 'w:my_wprobe w@jiffies' >> /sys/kernel/tracing/dynamic_events 
~ # echo 1 > /sys/kernel/tracing/events/wprobes/my_wprobe/enable 
QEMU 8.2.2 monitor - type 'help' for more information
(qemu) system_reset
...

~ # cat /sys/kernel/tracing/instances/boot_map/trace 
# tracer: nop
#
# entries-in-buffer/entries-written: 16/16   #P:1
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
           <...>-63      [000] .....    21.065038: register_wide_hw_breakpoint: Creating wide hw breakpoint on CPU 0
           <...>-63      [000] .....    21.079678: perf_event_create_kernel_counter: Creating kernel counter on CPU 0 for event type 5
           <...>-63      [000] .....    21.080051: perf_install_in_context: perf_install_in_context: event 000000000b3ac4d3 ctx 00000000097d6337 cpu 0
           <...>-63      [000] .....    21.080140: perf_install_in_context: perf_install_in_context2: event 000000000b3ac4d3 ctx set to 00000000097d6337
           <...>-63      [000] .....    21.080939: cpu_function_call: cpu_function_call: calling function on CPU 0, func: __perf_install_in_context+0x0/0x2f0
           <...>-63      [000] .....    21.080966: smp_call_function_single: smp_call_function_single: calling function on CPU 0, func: remote_function+0x0/0x78, wait=1
           <...>-63      [000] ...1.    21.080973: smp_call_function_single: smp_call_function_single: running on CPU 0, call CPU 0
           <...>-63      [000] ...1.    21.081099: smp_call_function_single: smp_call_function_single: checking for potential deadlock conditions
           <...>-63      [000] ...1.    21.081259: generic_exec_single: generic_exec_single: preparing to call function on CPU 0, func: remote_function+0x0/0x78
           <...>-63      [000] ...1.    21.081269: generic_exec_single: Executing smp_call_function_single on self CPU 0, func: remote_function+0x0/0x78
           <...>-63      [000] d..1.    21.081289: csd_do_func: csd_do_func: CPU 0 executing func remote_function+0x0/0x78
           <...>-63      [000] d..1.    21.081429: __perf_install_in_context: __perf_install_in_context: event 000000000b3ac4d3 ctx 00000000097d6337
           <...>-63      [000] d..2.    21.083211: hw_breakpoint_control: hw_breakpoint_control: ops=0
           <...>-63      [000] d..1.    21.084191: __perf_install_in_context: __perf_install_in_context: event 000000000b3ac4d3 done, ret=0
           <...>-63      [000] d..1.    21.084237: csd_do_func: csd_do_func: CPU 0 finished func remote_function+0x0/0x78
           <...>-63      [000] d..1.    21.084243: generic_exec_single: Finished csd_lock_record(NULL)
~ # 


So the last message is right before the local_irq_restore() in
generic_exec_single().

static int generic_exec_single(int cpu, call_single_data_t *csd)
{
	...
		csd_lock_record(csd);
		csd_unlock(csd);
		local_irq_save(flags);
		csd_do_func(func, info, NULL);
		csd_lock_record(NULL);
		trace_printk("Finished csd_lock_record(NULL)\n"); <- 
		local_irq_restore(flags);
		return 0;

Actually, I added another trace_printk() right after generic_exec_single().

	err = generic_exec_single(cpu, csd);
	trace_printk("generic_exec_single returned %d for CPU %d, func: %pS\n",
		err, cpu, func);

This means after setting the hw_breakpoint, when enabing the IRQ,
the machine is frozen - but qemu is running busy.

Can we specify the kernel memory address to HW breakpoint on arm64?

Thank you,
-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
