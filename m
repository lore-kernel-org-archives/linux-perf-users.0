Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB76290BB0;
	Wed,  4 Jun 2025 14:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749045955; cv=none; b=SM+lBIIPvuLMTvFZ/kwxeIfJI2Zn1HWJ+lbUi2EL8I7mcJbGnrEX5zdCfevYVbhpnsad6Y/l+8aImx2Vio+m7RBwYHATSWy/GtYZcPTA4+PEr3wrIQZmvmuLM3OPUcdFdhCJlOBRdBi75J0TM7t7vq/BfPRlIx4FLObpZV3MtgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749045955; c=relaxed/simple;
	bh=Ak2W+o8IxIKSA2WZaZODaZ0/CBGDnqt8Ha3K2Qh6peE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6yTRjsuYSPtdNZ048f8gzE+yHoIplqUN86WdXHVZ4JPk5+/wUX9cX8YR2k3UsXQ4aIAdbIOogzG1Wu1zLMnl39BoVeVpVnCeJ/t/z3XqGQj0Aelih74RRMBrwJXLbVBHUzdcaR5nlBpxckWWFweZXxRX8r1z5toKnhud6ykyRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7F781758;
	Wed,  4 Jun 2025 07:05:34 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 562883F5A1;
	Wed,  4 Jun 2025 07:05:49 -0700 (PDT)
Date: Wed, 4 Jun 2025 15:05:43 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Baisheng Gao <baisheng.gao@unisoc.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"reviewer:PERFORMANCE EVENTS SUBSYSTEM" <kan.liang@linux.intel.com>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>,
	cixi.geng@linux.dev, hao_hao.wang@unisoc.com
Subject: Re: [PATCH] perf/core: Handling the race between exit_mmap and perf
 sample
Message-ID: <aEBSt2LN7YhxYX7N@J2N7QTR9R3>
References: <20250424025429.10942-1-baisheng.gao@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250424025429.10942-1-baisheng.gao@unisoc.com>

On Thu, Apr 24, 2025 at 10:54:29AM +0800, Baisheng Gao wrote:
> In order to fix the race condition between exit_mmap and
> perf_output_sample below, forbidding to copy the user stack
> of an exiting process.
> 
>  Internal error: synchronous external abort: ffffffff96000010 [#1]
>   PREEMPT SMP

That ESR value (0x96000010, which got sign-extended somewhere), is a
synchronous external abort, not on translation table walk.

That means that some memory access was translated to some PA where the
endpoint responded with an error (and it strongly implies you're poking
MMIO or a PA terminated early by the interconnect).

>  CPU: 3 PID: 2651 Comm: binder:2649_1 Tainted: G        W  OE
>   5.15.149-android13-8-00008-gbe074b05e5af-ab12096863 #1
>  Hardware name: Spreadtrum UMS9230 1H10 SoC (DT)
>  pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : __arch_copy_from_user+0x180/0x218
>  lr : arch_perf_out_copy_user+0xb0/0x17c
>  sp : ffffffc00801baf0
>  x29: ffffffc00801baf0 x28: ffffffc00801bbf8 x27: ffffffc00801bbe8
>  x26: 0000000000000000 x25: 0000000000001000 x24: 000000000000feb8
>  x23: 00000000000005f0 x22: ffffff80613c8000 x21: ffffff8143102a10
>  x20: 0000007c239643c0 x19: 00000000000005f0 x18: ffffffc00801d058
>  x17: ffffffc16e677000 x16: ffffffc008018000 x15: 0000007c239643c0
>  x14: 0000000000000002 x13: 0000000000000003 x12: ffffffc008000000
>  x11: ffffff8000090000 x10: ffffffc008090000 x9 : 0000007fffffffff
>  x8 : 0000007c239643c0 x7 : 000000000000feb8 x6 : ffffff8143102a10
>  x5 : ffffff8143103000 x4 : 0000000000000000 x3 : ffffff8093cad140
>  x2 : 0000000000000570 x1 : 0000007c239643c0 x0 : ffffff8143102a10
>  Call trace:
>   __arch_copy_from_user+0x180/0x218
>   perf_output_sample+0x14e4/0x1904
>   perf_event_output_forward+0x90/0x130
>   __perf_event_overflow+0xc8/0x17c
>   perf_swevent_hrtimer+0x124/0x290
>   __run_hrtimer+0x134/0x4a0
>   hrtimer_interrupt+0x2e4/0x560
>   arch_timer_handler_phys+0x5c/0xa0
>   handle_percpu_devid_irq+0xc0/0x374
>   handle_domain_irq+0xd8/0x160
>   gic_handle_irq.34215+0x58/0x26c
>   call_on_irq_stack+0x3c/0x70
>   do_interrupt_handler+0x44/0xa0
>   el1_interrupt+0x34/0x64
>   el1h_64_irq_handler+0x1c/0x2c
>   el1h_64_irq+0x7c/0x80
>   release_pages+0xac/0x9b4
>   tlb_finish_mmu+0xb0/0x238
>   exit_mmap+0x1b8/0x538
>   __mmput+0x40/0x274
>   mmput+0x40/0x134
>   exit_mm+0x3bc/0x72c

The mmput() here happens after current->mm was set to NULL and the task
entered lazy TLB mode.

AFAICT, either:

* Something has gone wrong such that the CPU is still using the
  translation tables of the exiting task, and those are in some
  inconsistent state.

* Due to lazymm, the active_mm belongs to some other tas, and perf is
  sampling from that other task's VA space (which does not correlate at
  all with the pt_regs). That other task happens to have some MMIO
  mapped.

... either of which is a pretty horrid bug.

Loooking at 5.15.149 and current HEAD (5abc7438f1e9), do_exit() calls
exit_mm() before perf_event_exit_task(), so it looks
like perf could sample from another task's mm.

Yuck.

Peter, does the above sound plausible to you?

Mark.

>   do_exit+0x294/0x1160
>   do_group_exit+0xc8/0x174
>   get_signal+0x830/0x95c
>   do_signal+0x9c/0x2a8
>   do_notify_resume+0x98/0x1ac
>   el0_svc+0x5c/0x84
>   el0t_64_sync_handler+0x88/0xec
>   el0t_64_sync+0x1b8/0x1bc
> 
> Signed-off-by: Baisheng Gao <baisheng.gao@unisoc.com>
> ---
>  kernel/events/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index e93c19565914..9c9b571b812d 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7867,7 +7867,8 @@ void perf_output_sample(struct perf_output_handle *handle,
>                 }
>         }
> 
> -       if (sample_type & PERF_SAMPLE_STACK_USER) {
> +       if (sample_type & PERF_SAMPLE_STACK_USER &&
> +                       !(current->flags & PF_EXITING)) {
>                 perf_output_sample_ustack(handle,
>                                           data->stack_user_size,
>                                           data->regs_user.regs);
> --
> 2.34.1
> 
> ________________________________
>  This email (including its attachments) is intended only for the person or entity to which it is addressed and may contain information that is privileged, confidential or otherwise protected from disclosure. Unauthorized use, dissemination, distribution or copying of this email or the information herein or taking any action in reliance on the contents of this email or the information herein, by anyone other than the intended recipient, or an employee or agent responsible for delivering the message to the intended recipient, is strictly prohibited. If you are not the intended recipient, please do not read, copy, use or disclose any part of this e-mail to others. Please notify the sender immediately and permanently delete this e-mail and any attachments if you received it in error. Internet communications cannot be guaranteed to be timely, secure, error-free or virus-free. The sender does not accept liability for any errors or omissions.
> 本邮件及其附件具有保密性质，受法律保护不得泄露，仅发送给本邮件所指特定收件人。严禁非经授权使用、宣传、发布或复制本邮件或其内容。若非该特定收件人，请勿阅读、复制、 使用或披露本邮件的任何内容。若误收本邮件，请从系统中永久性删除本邮件及所有附件，并以回复邮件的方式即刻告知发件人。无法保证互联网通信及时、安全、无误或防毒。发件人对任何错漏均不承担责任。
