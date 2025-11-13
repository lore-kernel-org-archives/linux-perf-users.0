Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA30C141
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763003480; cv=none; b=tSoL6Hkd1L+hJs2zJKPuh5F3JWOeBL80YyFTG9TVV4Gto/bINtScN1CuvjQfhS871L9QXRh2RAU45CJkgFatKjP2w5baDzdMInS4+DnuC/+OxCJszPyprg7FYkAkX66WBV2uBbG/PyVvVGZj71nVlfd7k78eAt7g04B9c9NKY2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763003480; c=relaxed/simple;
	bh=H2WlfLCxO73sCx/ZOEJ25oXT3PFkhl1ePWLeyZhccnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c567vDGjNv5lmjQumoMKaqO5LjLVhdThrE5RW0Nw7hYBboqkDYnQkC4waJHZ9mhj0JTER6yJimik8QU/aRM5+cAJKqSMYpA7U7lrQVnj4p8p/13nY/ev13+AuomLCoFLUEsbRcKgIZba52bIM8HfDzhpYyRcRmhWd6xITtgnmrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiHZwTRj; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiHZwTRj"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-298039e00c2so3714865ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763003478; x=1763608278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4KZ0oeASZwWSSvSCq+YfQi2si3kqrcChzlXmxW4wtzM=;
        b=LiHZwTRjF3Ia080gAEG83MudFZVB/PUjESMKNYhbWItUw9ojdOV0PwQoGKMxuLVYw+
         S3jaQooAXrx1xaCtcWP8uaBtaupaI15fLzj8vLssjVXqh9C6TsXGZvugtCBB2vZAKtp2
         8uo70FmfViWMrN/ctGUB4pHuP1P9k7YXabNBNDr8/tX0QLgMA+pPa+a2JBHBDy6M6Ct/
         VYn3cGHP9/dRGP3QST7sIPYYduXYpJcTfOhG2twEUoCSgKVh6hnrznfzLJyT2ZpgecOV
         sYpjY4QoXAyrDz5bh3gGAWTPucXYpXWoNMVl9oToOL9lD/QYmZgjsFwBVt5rZCPRcqnz
         T2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763003478; x=1763608278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4KZ0oeASZwWSSvSCq+YfQi2si3kqrcChzlXmxW4wtzM=;
        b=Dgp7NhWqtQD9ecsBIY44FXhRvbr1reTDfZW0wEqoDpjAX2Kfm30ZG7oxp2o2Cz4Sb9
         Jl5VnOW3gb4og5DNfclnfTXGxVrzn2XC2pDFhAVbIYDp094f2mt9TLa/co2Drs+bgeh9
         MI5HBWB2tb2RysKG5ldIJYoVPrydKtv8v8dmhScioiBjbuUMYL5OUkoUsmUwncY36e1w
         5ShLq4Wb0keqJl6iUu9Bz0V9LW8CZYzuoVCvoh8heiWM7YO/l7Xh/IvU2uMv7N8Xa2IJ
         AoXjHZy9gBIAlzAJr3WJ5IWP5DPENomzOREgJgzef+xFk9wOEzBCHx+k6Q0DngYpMAnh
         U+Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWFwH0Opgy5glyg1QwcOkqdlp9TVVFFAqCc0DVsoeFYw1tIJndRBUEnpZ/7/8HnsERMMwOxTP8vmuR1Qgojm5E3@vger.kernel.org
X-Gm-Message-State: AOJu0YzgDOIONYDdgQh+BoGSJbu7mNCmc1J2CIcJ4dpwLYUyHk4ZkQ47
	BWq6EQ0WaJLEfgJcgSwopqKzlf6WWOUsYL0fe9qIeHOgMTwdBjMDHKOO
X-Gm-Gg: ASbGncv0LMgPJi6xlD74Shr21d5NdJS4jS6cjBLu1h7JBmPe/O2vgEkK/p8Lp4AcFBc
	Jpqer8numIVU2lkPcvBLyGhIsVgwWusJborL6FjNJ3ysE7t7gi4jKSzplLXTyOmdlsls/nxUpUS
	lLkeUiWEiS2tO4kZggpbzmsK0MRRtqOmoyi/qx8LEgilKl7wWckJ9nMNUWKGAbtEh8qpwTv8xXu
	r9AUJne3KqOT8Rpzc74gvmSv7HIM3Wa69udBXTCT9iWcoTNSCjyL7W5d7asUPNLYX59gsyo7FBY
	vB8GkrKcPlyhIQ/moit1BbzSiqJfXlyBWvlFFxCQuUmIUGrDyrAS/Pl0mi+Cj4QrHhqxyOpKzfm
	Nj4cSc9EIbsYGSgFSMLEMMWrr55xp0kTx5edSXExYMmg6WjJlo9UvpBDV1H2dvmGlMafzL3a9yD
	DpQ6lnD6MbRdi0
X-Google-Smtp-Source: AGHT+IG45iOKAFDdr0Vq/FDT8VkTjoUwIBaFEHKu1Co7b8n4k7rpCGU1+s4BlFqMp9RzYifhMdIRIA==
X-Received: by 2002:a17:902:e948:b0:298:2e7a:3c47 with SMTP id d9443c01a7336-2984ee01fb9mr61127905ad.42.1763003477930;
        Wed, 12 Nov 2025 19:11:17 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c23487esm6700275ad.20.2025.11.12.19.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 19:11:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 12 Nov 2025 19:11:15 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RESEND][PATCH 3/5] perf: Use current->flags &
 PF_KTHREAD|PF_USER_WORKER instead of current->mm == NULL
Message-ID: <0d877e6f-41a7-4724-875d-0b0a27b8a545@roeck-us.net>
References: <20250820180338.701352023@kernel.org>
 <20250820180428.592367294@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820180428.592367294@kernel.org>

Hi Steven,

On Wed, Aug 20, 2025 at 02:03:41PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> To determine if a task is a kernel thread or not, it is more reliable to
> use (current->flags & (PF_KTHREAD|PF_USER_WORKERi)) than to rely on
> current->mm being NULL.  That is because some kernel tasks (io_uring
> helpers) may have a mm field.
> 
> Link: https://lore.kernel.org/linux-trace-kernel/20250424163607.GE18306@noisy.programming.kicks-ass.net/
> Link: https://lore.kernel.org/all/20250624130744.602c5b5f@batman.local.home/
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/events/callchain.c | 6 +++---
>  kernel/events/core.c      | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> index cd0e3fc7ed05..5982d18f169b 100644
> --- a/kernel/events/callchain.c
> +++ b/kernel/events/callchain.c
> @@ -246,10 +246,10 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
>  
>  	if (user && !crosstask) {
>  		if (!user_mode(regs)) {
> -			if  (current->mm)
> -				regs = task_pt_regs(current);
> -			else
> +			if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
>  				regs = NULL;
> +			else
> +				regs = task_pt_regs(current);
>  		}
>  
>  		if (regs) {
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index bade8e0fced7..f880cec0c980 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7446,7 +7446,7 @@ static void perf_sample_regs_user(struct perf_regs *regs_user,
>  	if (user_mode(regs)) {
>  		regs_user->abi = perf_reg_abi(current);
>  		regs_user->regs = regs;
> -	} else if (!(current->flags & PF_KTHREAD)) {
> +	} else if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER))) {
>  		perf_get_regs_user(regs_user, regs);
>  	} else {
>  		regs_user->abi = PERF_SAMPLE_REGS_ABI_NONE;
> @@ -8086,7 +8086,7 @@ static u64 perf_virt_to_phys(u64 virt)
>  		 * Try IRQ-safe get_user_page_fast_only first.
>  		 * If failed, leave phys_addr as 0.
>  		 */
> -		if (current->mm != NULL) {
> +		if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER))) {

Subsequent code uses current->mm. This triggers a crash when running a page
table stress test. See below for details. I have seen the crash in 6.12.57
and 6.18-rc5.

Guenter

---

[  120.334908] BUG: kernel NULL pointer dereference, address: 0000000000000078
[  120.341901] #PF: supervisor read access in kernel mode
[  120.347055] #PF: error_code(0x0000) - not-present page
[  120.352208] PGD 0 P4D 0
[  120.354750] Oops: Oops: 0000 [#1] SMP NOPTI
[  120.358946] CPU: 36 UID: 0 PID: 14127 Comm: page_table_stre Tainted: G S         O        6.18.0-smp-DEV #2 NONE
[  120.369242] Tainted: [S]=CPU_OUT_OF_SPEC, [O]=OOT_MODULE
[  120.374568] Hardware name: Google LLC Indus/Indus_QC_03, BIOS 30.116.4 08/29/2025
[  120.382075] RIP: 0010:gup_fast_fallback+0x150/0xb60
[  120.386977] Code: d0 c9 8b 48 89 84 24 a0 00 00 00 48 8b 80 30 05 00 00 0f b6 0d 0d 6b 1a 01 49 89 f8 49 d3 e8 41 81 e0 ff 01 00 00 41 c1 e0
 03 <4c> 03 40 78 4c 8d 5b ff 44 89 c8 83 e0 01 48 8d 04 45 05 00 00 00
[  120.405809] RSP: 0018:ffffa32be5f9b7a0 EFLAGS: 00010006
[  120.411051] RAX: 0000000000000000 RBX: 00007f0f57dfd000 RCX: 0000000000000027
[  120.418210] RDX: 0000000000000046 RSI: 0000000000000001 RDI: 00007f0f57dfc000
[  120.425368] RBP: 0000000000000000 R08: 00000000000007f0 R09: 0000000000100002
[  120.432526] R10: ffffa32be5f9b8c8 R11: 0000000000000000 R12: 00007f0f57dfc6c0
[  120.439683] R13: ffff99b44dd7c800 R14: 00000000fffffff2 R15: 00000000000800c3
[  120.446842] FS:  0000000000000000(0000) GS:ffff9a127357b000(0000) knlGS:0000000000000000
[  120.454956] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  120.460721] CR2: 0000000000000078 CR3: 000000512d03e006 CR4: 00000000007706f0
[  120.467879] PKRU: 55555554
[  120.470592] Call Trace:
[  120.473045]  <TASK>
[  120.475152]  perf_prepare_sample+0x77b/0x910
[  120.479445]  perf_event_output+0x35/0x100
[  120.483467]  intel_pmu_drain_pebs_nhm+0x570/0x750
[  120.488198]  intel_pmu_pebs_sched_task+0x74/0x80
[  120.492839]  ? __put_partials+0xd6/0x130
[  120.496775]  ? __mt_destroy+0x3f/0x80
[  120.500451]  ? put_cpu_partial+0x9b/0xc0
[  120.504384]  ? __slab_free+0x249/0x320
[  120.508144]  ? refill_obj_stock+0x120/0x1a0
[  120.512341]  ? __mt_destroy+0x3f/0x80
[  120.516013]  ? kfree+0x2ca/0x390
[  120.519254]  ? update_load_avg+0x1c8/0x7d0
[  120.523364]  ? update_entity_lag+0xf6/0x110
[  120.527560]  intel_pmu_sched_task+0x1d/0x30
[  120.531755]  perf_pmu_sched_task+0xf2/0x1a0
[  120.535952]  __perf_event_task_sched_out+0x3f/0x1f0
[  120.540844]  ? pick_next_task_fair+0x3e/0x2a0
[  120.545214]  __schedule+0xad0/0xb40
[  120.548715]  do_task_dead+0x48/0xa0
[  120.552215]  do_exit+0x734/0x920
[  120.555463]  ? do_exit+0x9/0x920
[  120.558699]  do_group_exit+0x85/0x90
[  120.562284]  __x64_sys_exit_group+0x17/0x20
[  120.566478]  x64_sys_call+0x21f7/0x2200
[  120.570327]  do_syscall_64+0x6f/0x940
[  120.574001]  ? clear_bhb_loop+0x50/0xa0
[  120.577849]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  120.582915] RIP: 0033:0x7f0f5a0d2c48
[  120.586501] Code: Unable to access opcode bytes at 0x7f0f5a0d2c1e.
[  120.592700] RSP: 002b:00007f0f57dfcec8 EFLAGS: 00000207 ORIG_RAX: 00000000000000e7
[  120.600294] RAX: ffffffffffffffda RBX: 00007f0f57dfd700 RCX: 00007f0f5a0d2c48
[  120.607452] RDX: 00007f0f57dfd660 RSI: 0000000000000000 RDI: 0000000000000000
[  120.614607] RBP: 00007f0f57dfcef0 R08: 00007f0f57dfd700 R09: 00007f0f57dfd700
[  120.621765] R10: 00007f0f5a17a6c0 R11: 0000000000000207 R12: 00007f0f57dfd9d0
[  120.628923] R13: 00007ffc64840aa6 R14: 00007f0f57dfdd1c R15: 00007f0f57dfcfc0
[  120.636081]  </TASK>
[  120.638272] Modules linked in: vfat fat i2c_mux_pca954x i2c_mux spidev cdc_acm xhci_pci xhci_hcd gq(O) sha3_generic
[  120.649976] gsmi: Log Shutdown Reason 0x03
[  120.654086] CR2: 0000000000000078
[  120.657409] ---[ end trace 0000000000000000 ]---

Stack decode:

[  120.334908] BUG: kernel NULL pointer dereference, address: 0000000000000078
[  120.341901] #PF: supervisor read access in kernel mode
[  120.347055] #PF: error_code(0x0000) - not-present page
[  120.352208] PGD 0 P4D 0
[  120.354750] Oops: Oops: 0000 [#1] SMP NOPTI
[  120.358946] CPU: 36 UID: 0 PID: 14127 Comm: page_table_stre Tainted: G S         O        6.18.0-smp-DEV #2 NONE
[  120.369242] Tainted: [S]=CPU_OUT_OF_SPEC, [O]=OOT_MODULE
[  120.374568] Hardware name: Google LLC Indus/Indus_QC_03, BIOS 30.116.4 08/29/2025
[  120.382075] RIP: 0010:gup_fast_fallback (./include/linux/pgtable.h:140 mm/gup.c:3795 mm/gup.c:3899 mm/gup.c:3946)
[ 120.386977] Code: d0 c9 8b 48 89 84 24 a0 00 00 00 48 8b 80 30 05 00 00 0f b6 0d 0d 6b 1a 01 49 89 f8 49 d3 e8 41 81 e0 ff 01 00 00 41 c1 e0
03 <4c> 03 40 78 4c 8d 5b ff 44 89 c8 83 e0 01 48 8d 04 45 05 00 00 00
All code
========
   0:   d0 c9                   ror    $1,%cl
   2:   8b 48 89                mov    -0x77(%rax),%ecx
   5:   84 24 a0                test   %ah,(%rax,%riz,4)
   8:   00 00                   add    %al,(%rax)
   a:   00 48 8b                add    %cl,-0x75(%rax)
   d:   80 30 05                xorb   $0x5,(%rax)
  10:   00 00                   add    %al,(%rax)
  12:   0f b6 0d 0d 6b 1a 01    movzbl 0x11a6b0d(%rip),%ecx        # 0x11a6b26
  19:   49 89 f8                mov    %rdi,%r8
  1c:   49 d3 e8                shr    %cl,%r8
  1f:   41 81 e0 ff 01 00 00    and    $0x1ff,%r8d
  26:   41 c1 e0 03             shl    $0x3,%r8d
  2a:*  4c 03 40 78             add    0x78(%rax),%r8           <-- trapping instruction
  2e:   4c 8d 5b ff             lea    -0x1(%rbx),%r11
  32:   44 89 c8                mov    %r9d,%eax
  35:   83 e0 01                and    $0x1,%eax
  38:   48 8d 04 45 05 00 00    lea    0x5(,%rax,2),%rax
  3f:   00

Code starting with the faulting instruction
===========================================
   0:   4c 03 40 78             add    0x78(%rax),%r8
   4:   4c 8d 5b ff             lea    -0x1(%rbx),%r11
   8:   44 89 c8                mov    %r9d,%eax
   b:   83 e0 01                and    $0x1,%eax
   e:   48 8d 04 45 05 00 00    lea    0x5(,%rax,2),%rax
  15:   00
[  120.405809] RSP: 0018:ffffa32be5f9b7a0 EFLAGS: 00010006
[  120.411051] RAX: 0000000000000000 RBX: 00007f0f57dfd000 RCX: 0000000000000027
[  120.418210] RDX: 0000000000000046 RSI: 0000000000000001 RDI: 00007f0f57dfc000
[  120.425368] RBP: 0000000000000000 R08: 00000000000007f0 R09: 0000000000100002
[  120.432526] R10: ffffa32be5f9b8c8 R11: 0000000000000000 R12: 00007f0f57dfc6c0
[  120.439683] R13: ffff99b44dd7c800 R14: 00000000fffffff2 R15: 00000000000800c3
[  120.446842] FS:  0000000000000000(0000) GS:ffff9a127357b000(0000) knlGS:0000000000000000
[  120.454956] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  120.460721] CR2: 0000000000000078 CR3: 000000512d03e006 CR4: 00000000007706f0
[  120.467879] PKRU: 55555554
[  120.470592] Call Trace:
[  120.473045]  <TASK>
[  120.475152] perf_prepare_sample (kernel/events/core.c:7490 kernel/events/core.c:8302)
[  120.479445] perf_event_output (kernel/events/core.c:8389 kernel/events/core.c:8426)
[  120.483467] intel_pmu_drain_pebs_nhm (arch/x86/events/intel/ds.c:? arch/x86/events/intel/ds.c:2182 arch/x86/events/intel/ds.c:2372)
[  120.488198] intel_pmu_pebs_sched_task (arch/x86/events/intel/ds.c:939 arch/x86/events/intel/ds.c:1248)
[  120.492839] ? __put_partials (mm/slub.c:3195)
[  120.496775] ? __mt_destroy (lib/maple_tree.c:? lib/maple_tree.c:6883)
[  120.500451] ? put_cpu_partial (mm/slub.c:3278)
[  120.504384] ? __slab_free (mm/slub.c:4521)
[  120.508144] ? refill_obj_stock (./include/linux/percpu-refcount.h:335 ./include/linux/percpu-refcount.h:351 ./include/linux/memcontrol.h:988
 mm/memcontrol.c:3732)
[  120.512341] ? __mt_destroy (lib/maple_tree.c:? lib/maple_tree.c:6883)
[  120.516013] ? kfree (mm/slab.h:681 mm/slub.c:4649 mm/slub.c:4797)
[  120.519254] ? update_load_avg (kernel/sched/fair.c:5376 kernel/sched/fair.c:5601 kernel/sched/fair.c:5720)
[  120.523364] ? update_entity_lag (kernel/sched/fair.c:?)
[  120.527560] intel_pmu_sched_task (arch/x86/events/intel/core.c:5231)
[  120.531755] perf_pmu_sched_task (kernel/events/core.c:1219 kernel/events/core.c:1231 kernel/events/core.c:3739 kernel/events/core.c:3755)
[  120.535952] __perf_event_task_sched_out (kernel/events/core.c:3776)
[  120.540844] ? pick_next_task_fair (kernel/sched/sched.h:4660 kernel/sched/sched.h:4666 kernel/sched/fair.c:9593 kernel/sched/fair.c:15504)
[  120.545214] __schedule (kernel/sched/core.c:7405 kernel/sched/core.c:8080)
[  120.548715] do_task_dead (??:?)
[  120.552215] do_exit (./include/linux/list.h:364 kernel/exit.c:810 kernel/exit.c:1030)
[  120.555463] ? do_exit (kernel/exit.c:934)
[  120.558699] do_group_exit (kernel/exit.c:1161)
[  120.562284] __x64_sys_exit_group (kernel/exit.c:1172)
[  120.566478] x64_sys_call (arch/x86/entry/syscall_64.c:32)
[  120.570327] do_syscall_64 (arch/x86/entry/common.c:57 arch/x86/entry/common.c:100)
[  120.574001] ? clear_bhb_loop (arch/x86/entry/entry_64.S:1598)
