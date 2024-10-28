Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEEA191F84;
	Mon, 28 Oct 2024 08:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730104287; cv=none; b=hc/nnlhBNvNBIfZ3gnhu6hDOYDQbW19+JKp+X26tCnh4Jnn9/fYh8rOP4UMpPloZenT4V+4H2k468mwfJc6s/t56w26Lx21uRFWMP0gnnS5E4sLwuPAsrDr7Ah7nAcnrlOEHezirLVEHnMe1Bo1iv+FRtSkwe0V3JtcxoCMMS70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730104287; c=relaxed/simple;
	bh=hv7SqZQ+e/tN6SGz4vmruaOYoEU3s2i2fEJqfWOD2eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Si3SHEIxGLdWQx2WLfpNymDpkTW2Uocuk4SHPP85aXcdg5S31tkcancFyb12tbaOazLzs8Ce6c/bTN58hnEmEGQg3p6v/msG9L0ntx4e2FKikTJrP4tb7mvoZR0qy9kB6iCwNwdY3YZRZfxOgeYwAqahsT0MZ/1KrE+4V4MVp5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iq8XfIuU; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iq8XfIuU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730104285; x=1761640285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hv7SqZQ+e/tN6SGz4vmruaOYoEU3s2i2fEJqfWOD2eM=;
  b=Iq8XfIuUgF4UIGSzYipyEJOq4VlKcX3Zmv1popPcCLaJg6DgMeCR73LY
   TpHBIKFfm4+bIwNKpQzgRoULeyWNaDVgr9SSJeK0cVDXVoB8x9sG71Yn6
   d5UGHJTeqTG7qKYQV2g0ZrKesZYaRgwsdk9dVHKBd9qGi/ir/3Gg4LKTG
   HMpOZVSh7hFZ8H2HZP6G5HtUQEw31ZF60PuYshXZscnk3dl1GMp7lWDmD
   Lk9BoVrBFC/ZSHZBRC5szqvvwhNYXoNV49x1f1ITHXkn2ajc9cGTalPtd
   1D1004B1s2vUlC+Bn4kjnQfSZ4Ec9TIbC+5dFIXlmZi/qohCfZxcZdmNn
   g==;
X-CSE-ConnectionGUID: 7FIx2S7pRzuF246+c3tWgw==
X-CSE-MsgGUID: 2eaOdoF7ToeENMBXaBVTQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29902405"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="29902405"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 01:31:24 -0700
X-CSE-ConnectionGUID: aM4IiusnQ5yZIVV0+MmVhA==
X-CSE-MsgGUID: TYXmU4meQQ+3fQ6GLvTh+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="81138369"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.161.23])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 01:31:17 -0700
Date: Mon, 28 Oct 2024 16:30:26 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>, yi1.lai@intel.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v4 2/6] perf: Enqueue SIGTRAP always via task_work.
Message-ID: <Zx9Losv4YcJowaP/@ly-workstation>
References: <20240624152732.1231678-1-bigeasy@linutronix.de>
 <20240624152732.1231678-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624152732.1231678-3-bigeasy@linutronix.de>

Hi Sebastian Andrzej Siewior,

Greetings!

I used Syzkaller and found that there is INFO: task hung in in _free_event in v6.12-rc4.

After bisection and the first bad commit is:
"
c5d93d23a260 perf: Enqueue SIGTRAP always via task_work.
"

All detailed into can be found at:
https://github.com/laifryiee/syzkaller_logs/tree/main/241027_012744__free_event
Syzkaller repro code:
https://github.com/laifryiee/syzkaller_logs/tree/main/241027_012744__free_event/repro.c
Syzkaller repro syscall steps:
https://github.com/laifryiee/syzkaller_logs/tree/main/241027_012744__free_event/repro.prog
Syzkaller report:
https://github.com/laifryiee/syzkaller_logs/tree/main/241027_012744__free_event/repro.report
Kconfig(make olddefconfig):
https://github.com/laifryiee/syzkaller_logs/tree/main/241027_012744__free_event/kconfig_origin
Bisect info:
https://github.com/laifryiee/syzkaller_logs/tree/main/241027_012744__free_event/bisect_info.log
bzImage:
https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/241027_012744__free_event/bzImage_42f7652d3eb527d03665b09edac47f85fb600924
Issue dmesg:
https://github.com/laifryiee/syzkaller_logs/blob/main/241027_012744__free_event/42f7652d3eb527d03665b09edac47f85fb600924_dmesg.log

"
[  300.651268] INFO: task repro:671 blocked for more than 147 seconds.
[  300.651706]       Not tainted 6.12.0-rc4-42f7652d3eb5+ #1
[  300.652006] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  300.652430] task:repro           state:D stack:0     pid:671   tgid:671   ppid:670    flags:0x00004002
[  300.652939] Call Trace:
[  300.653088]  <TASK>
[  300.653221]  __schedule+0xe13/0x33a0
[  300.653474]  ? __pfx___schedule+0x10/0x10
[  300.653704]  ? lock_release+0x441/0x870
[  300.653946]  ? __pfx_lock_release+0x10/0x10
[  300.654184]  ? trace_lock_acquire+0x139/0x1b0
[  300.654439]  ? lock_acquire+0x80/0xb0
[  300.654651]  ? schedule+0x216/0x3f0
[  300.654859]  schedule+0xf6/0x3f0
[  300.655083]  _free_event+0x531/0x14c0
[  300.655317]  perf_event_release_kernel+0x648/0x870
[  300.655597]  ? __pfx_perf_event_release_kernel+0x10/0x10
[  300.655899]  ? trace_hardirqs_on+0x51/0x60
[  300.656176]  ? __sanitizer_cov_trace_const_cmp2+0x1c/0x30
[  300.656474]  ? __pfx_perf_release+0x10/0x10
[  300.656697]  perf_release+0x3a/0x50
[  300.656916]  __fput+0x414/0xb60
[  300.657163]  ____fput+0x22/0x30
[  300.657335]  task_work_run+0x19c/0x2b0
[  300.657548]  ? __pfx_task_work_run+0x10/0x10
[  300.657780]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[  300.658101]  ? switch_task_namespaces+0xc6/0x110
[  300.658390]  do_exit+0xb19/0x2a30
[  300.658577]  ? lockdep_hardirqs_on+0x89/0x110
[  300.658822]  ? __pfx_do_exit+0x10/0x10
[  300.659088]  do_group_exit+0xe4/0x2c0
[  300.659338]  get_signal+0x2279/0x24c0
[  300.659554]  ? __pfx_get_signal+0x10/0x10
[  300.659767]  ? __might_fault+0xf1/0x1b0
[  300.659984]  arch_do_signal_or_restart+0x8e/0x7d0
[  300.660239]  ? __pfx_arch_do_signal_or_restart+0x10/0x10
[  300.660524]  ? __this_cpu_preempt_check+0x21/0x30
[  300.660772]  ? syscall_exit_to_user_mode+0x10f/0x200
[  300.661035]  syscall_exit_to_user_mode+0x144/0x200
[  300.661288]  do_syscall_64+0x79/0x140
[  300.661489]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  300.661760] RIP: 0033:0x7f374dc3ee5d
[  300.661953] RSP: 002b:00007ffd55371398 EFLAGS: 00000206 ORIG_RAX: 000000000000012a
[  300.662341] RAX: 0000000000000003 RBX: 0000000000000000 RCX: 00007f374dc3ee5d
[  300.662702] RDX: 00000000ffffffff RSI: 0000000000000000 RDI: 0000000020000240
[  300.663087] RBP: 00007ffd553713a0 R08: 0000000000000008 R09: 00007ffd553713d0
[  300.663455] R10: 00000000ffffffff R11: 0000000000000206 R12: 00007ffd553714f8
[  300.663827] R13: 0000000000401b49 R14: 0000000000403e08 R15: 00007f374de9e000
[  300.664212]  </TASK>
[  300.664338]
[  300.664338] Showing all locks held in the system:
[  300.664670] 1 lock held by khungtaskd/33:
[  300.664887]  #0: ffffffff8705ca00 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x73/0x3c0
[  300.665390]
[  300.665481] =============================================
"

I hope you find it useful.

Regards,
Yi Lai

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install 

On Mon, Jun 24, 2024 at 05:15:15PM +0200, Sebastian Andrzej Siewior wrote:
> A signal is delivered by raising irq_work() which works from any context
> including NMI. irq_work() can be delayed if the architecture does not
> provide an interrupt vector. In order not to lose a signal, the signal
> is injected via task_work during event_sched_out().
> 
> Instead going via irq_work, the signal could be added directly via
> task_work. The signal is sent to current and can be enqueued on its
> return path to userland instead of triggering irq_work. A dummy IRQ is
> required in the NMI case to ensure the task_work is handled before
> returning to user land. For this irq_work is used. An alternative would
> be just raising an interrupt like arch_send_call_function_single_ipi().
> 
> During testing with `remove_on_exec' it become visible that the event
> can be enqueued via NMI during execve(). The task_work must not be kept
> because free_event() will complain later. Also the new task will not
> have a sighandler installed.
> 
> Queue signal via task_work. Remove perf_event::pending_sigtrap and
> and use perf_event::pending_work instead. Raise irq_work in the NMI case
> for a dummy interrupt. Remove the task_work if the event is freed.
> 
> Tested-by: Marco Elver <elver@google.com>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/perf_event.h |  3 +--
>  kernel/events/core.c       | 36 +++++++++++++++---------------------
>  2 files changed, 16 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 393fb13733b02..ea0d82418d854 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -781,7 +781,6 @@ struct perf_event {
>  	unsigned int			pending_wakeup;
>  	unsigned int			pending_kill;
>  	unsigned int			pending_disable;
> -	unsigned int			pending_sigtrap;
>  	unsigned long			pending_addr;	/* SIGTRAP */
>  	struct irq_work			pending_irq;
>  	struct callback_head		pending_task;
> @@ -963,7 +962,7 @@ struct perf_event_context {
>  	struct rcu_head			rcu_head;
>  
>  	/*
> -	 * Sum (event->pending_sigtrap + event->pending_work)
> +	 * Sum (event->pending_work + event->pending_work)
>  	 *
>  	 * The SIGTRAP is targeted at ctx->task, as such it won't do changing
>  	 * that until the signal is delivered.
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 647abeeaeeb02..6256a9593c3da 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2283,17 +2283,6 @@ event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
>  		state = PERF_EVENT_STATE_OFF;
>  	}
>  
> -	if (event->pending_sigtrap) {
> -		event->pending_sigtrap = 0;
> -		if (state != PERF_EVENT_STATE_OFF &&
> -		    !event->pending_work &&
> -		    !task_work_add(current, &event->pending_task, TWA_RESUME)) {
> -			event->pending_work = 1;
> -		} else {
> -			local_dec(&event->ctx->nr_pending);
> -		}
> -	}
> -
>  	perf_event_set_state(event, state);
>  
>  	if (!is_software_event(event))
> @@ -6787,11 +6776,6 @@ static void __perf_pending_irq(struct perf_event *event)
>  	 * Yay, we hit home and are in the context of the event.
>  	 */
>  	if (cpu == smp_processor_id()) {
> -		if (event->pending_sigtrap) {
> -			event->pending_sigtrap = 0;
> -			perf_sigtrap(event);
> -			local_dec(&event->ctx->nr_pending);
> -		}
>  		if (event->pending_disable) {
>  			event->pending_disable = 0;
>  			perf_event_disable_local(event);
> @@ -9735,18 +9719,28 @@ static int __perf_event_overflow(struct perf_event *event,
>  
>  		if (regs)
>  			pending_id = hash32_ptr((void *)instruction_pointer(regs)) ?: 1;
> -		if (!event->pending_sigtrap) {
> -			event->pending_sigtrap = pending_id;
> +
> +		if (!event->pending_work &&
> +		    !task_work_add(current, &event->pending_task, TWA_RESUME)) {
> +			event->pending_work = pending_id;
>  			local_inc(&event->ctx->nr_pending);
>  
>  			event->pending_addr = 0;
>  			if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
>  				event->pending_addr = data->addr;
> -			irq_work_queue(&event->pending_irq);
> +			/*
> +			 * The NMI path returns directly to userland. The
> +			 * irq_work is raised as a dummy interrupt to ensure
> +			 * regular return path to user is taken and task_work
> +			 * is processed.
> +			 */
> +			if (in_nmi())
> +				irq_work_queue(&event->pending_irq);
> +
>  		} else if (event->attr.exclude_kernel && valid_sample) {
>  			/*
>  			 * Should not be able to return to user space without
> -			 * consuming pending_sigtrap; with exceptions:
> +			 * consuming pending_work; with exceptions:
>  			 *
>  			 *  1. Where !exclude_kernel, events can overflow again
>  			 *     in the kernel without returning to user space.
> @@ -9756,7 +9750,7 @@ static int __perf_event_overflow(struct perf_event *event,
>  			 *     To approximate progress (with false negatives),
>  			 *     check 32-bit hash of the current IP.
>  			 */
> -			WARN_ON_ONCE(event->pending_sigtrap != pending_id);
> +			WARN_ON_ONCE(event->pending_work != pending_id);
>  		}
>  	}
>  
> -- 
> 2.45.2
> 
