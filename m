Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EDF130499;
	Tue, 23 Jul 2024 01:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721698828; cv=none; b=ltNGnAa/3dOSqps7pwl50g4wiz3hNnVz1lOwcnaeyg8vLN2GKXduCUZV5JnwU2hSOuZkZ5F+7gNy0AaDCbaeydp63J5qX8Q6WPEcKPsmPC60SqpLqYLz7l6tye6ukqbcQR4ra0QnEBW5KNFQGqQcseTJc5gm/cSqDu/3/fmm8O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721698828; c=relaxed/simple;
	bh=sVjvHNuUXm641spj6PIypEZZtH0+lkWxhOlwvo3ea5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dHlGaQ9Cui0a7EpawvUTOki9AdF5Uq9tNNl7KoLPWiTu63On7IWufa+MyZ9XX9qrFTPUE0I6lH/XlJEf6BFFHF3qnO9PDw3j20dJH5UueGtWBTk6gKnCJUYn/3AGyRr64ajrDchw6GOF0zIK3j3nB8M4jvUcRWriXqxG6Ong1i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WSfth5z5rzdjqy;
	Tue, 23 Jul 2024 09:38:36 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 46DA818005F;
	Tue, 23 Jul 2024 09:40:23 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 23 Jul 2024 09:40:22 +0800
Message-ID: <cff7274d-e423-9ac9-7d15-cedad7d85701@huawei.com>
Date: Tue, 23 Jul 2024 09:40:21 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 2/2] riscv: stacktrace: Add USER_STACKTRACE support
Content-Language: en-US
To: <bjorn@kernel.org>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<dev.mbstr@gmail.com>, <samuel.holland@sifive.com>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>
References: <20240708032847.2998158-1-ruanjinjie@huawei.com>
 <20240708032847.2998158-3-ruanjinjie@huawei.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240708032847.2998158-3-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/7/8 11:28, Jinjie Ruan wrote:
> Currently, userstacktrace is unsupported for riscv. So use the
> perf_callchain_user() code as blueprint to implement the
> arch_stack_walk_user() which add userstacktrace support on riscv.
> Meanwhile, we can use arch_stack_walk_user() to simplify the implementation
> of perf_callchain_user().
> 
> A ftrace test case is shown as below:
> 
> 	# cd /sys/kernel/debug/tracing
> 	# echo 1 > options/userstacktrace
> 	# echo 1 > options/sym-userobj
> 	# echo 1 > events/sched/sched_process_fork/enable
> 	# cat trace
> 	......
> 	            bash-178     [000] ...1.    97.968395: sched_process_fork: comm=bash pid=178 child_comm=bash child_pid=231
> 	            bash-178     [000] ...1.    97.970075: <user stack trace>
> 	 => /lib/libc.so.6[+0xb5090]
> 
> Also a simple perf test is ok as below:
> 
> 	# perf record -e cpu-clock --call-graph fp top
> 	# perf report --call-graph
> 
> 	.....
> 	[[31m  66.54%[[m     0.00%  top      [kernel.kallsyms]            [k] ret_from_exception
>             |
>             ---ret_from_exception
>                |
>                |--[[31m58.97%[[m--do_trap_ecall_u
>                |          |
>                |          |--[[31m17.34%[[m--__riscv_sys_read
>                |          |          ksys_read
>                |          |          |
>                |          |           --[[31m16.88%[[m--vfs_read
>                |          |                     |
>                |          |                     |--[[31m10.90%[[m--seq_read

Gentle ping.

> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Tested-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Cc: Björn Töpel <bjorn@kernel.org>
> ---
> v3:
> - Remove the LTP message as Björn suggested.
> - Keep fp 16-bytes aligned in arch_stack_walk_user().
> - Add the test info.
> v2:
> - Fix the cocci warning, !A || A && B is equivalent to !A || B.
> ---
> ---
>  arch/riscv/Kconfig                 |  1 +
>  arch/riscv/kernel/perf_callchain.c | 46 ++----------------------------
>  arch/riscv/kernel/stacktrace.c     | 43 ++++++++++++++++++++++++++++
>  3 files changed, 47 insertions(+), 43 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 3b44e7b51436..46121dbcf750 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -194,6 +194,7 @@ config RISCV
>  	select THREAD_INFO_IN_TASK
>  	select TRACE_IRQFLAGS_SUPPORT
>  	select UACCESS_MEMCPY if !MMU
> +	select USER_STACKTRACE_SUPPORT
>  	select ZONE_DMA32 if 64BIT
>  
>  config CLANG_SUPPORTS_DYNAMIC_FTRACE
> diff --git a/arch/riscv/kernel/perf_callchain.c b/arch/riscv/kernel/perf_callchain.c
> index 2932791e9388..c7468af77c66 100644
> --- a/arch/riscv/kernel/perf_callchain.c
> +++ b/arch/riscv/kernel/perf_callchain.c
> @@ -6,37 +6,9 @@
>  
>  #include <asm/stacktrace.h>
>  
> -/*
> - * Get the return address for a single stackframe and return a pointer to the
> - * next frame tail.
> - */
> -static unsigned long user_backtrace(struct perf_callchain_entry_ctx *entry,
> -				    unsigned long fp, unsigned long reg_ra)
> +static bool fill_callchain(void *entry, unsigned long pc)
>  {
> -	struct stackframe buftail;
> -	unsigned long ra = 0;
> -	unsigned long __user *user_frame_tail =
> -		(unsigned long __user *)(fp - sizeof(struct stackframe));
> -
> -	/* Check accessibility of one struct frame_tail beyond */
> -	if (!access_ok(user_frame_tail, sizeof(buftail)))
> -		return 0;
> -	if (__copy_from_user_inatomic(&buftail, user_frame_tail,
> -				      sizeof(buftail)))
> -		return 0;
> -
> -	if (reg_ra != 0)
> -		ra = reg_ra;
> -	else
> -		ra = buftail.ra;
> -
> -	fp = buftail.fp;
> -	if (ra != 0)
> -		perf_callchain_store(entry, ra);
> -	else
> -		return 0;
> -
> -	return fp;
> +	return perf_callchain_store(entry, pc) == 0;
>  }
>  
>  /*
> @@ -56,19 +28,7 @@ static unsigned long user_backtrace(struct perf_callchain_entry_ctx *entry,
>  void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
>  			 struct pt_regs *regs)
>  {
> -	unsigned long fp = 0;
> -
> -	fp = regs->s0;
> -	perf_callchain_store(entry, regs->epc);
> -
> -	fp = user_backtrace(entry, fp, regs->ra);
> -	while (fp && !(fp & 0x7) && entry->nr < entry->max_stack)
> -		fp = user_backtrace(entry, fp, 0);
> -}
> -
> -static bool fill_callchain(void *entry, unsigned long pc)
> -{
> -	return perf_callchain_store(entry, pc) == 0;
> +	arch_stack_walk_user(fill_callchain, entry, regs);
>  }
>  
>  void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
> index 0d3f00eb0bae..5480cc11b523 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -161,3 +161,46 @@ noinline noinstr void arch_stack_walk(stack_trace_consume_fn consume_entry, void
>  {
>  	walk_stackframe(task, regs, consume_entry, cookie);
>  }
> +
> +/*
> + * Get the return address for a single stackframe and return a pointer to the
> + * next frame tail.
> + */
> +static unsigned long unwind_user_frame(stack_trace_consume_fn consume_entry,
> +				       void *cookie, unsigned long fp,
> +				       unsigned long reg_ra)
> +{
> +	struct stackframe buftail;
> +	unsigned long ra = 0;
> +	unsigned long __user *user_frame_tail =
> +		(unsigned long __user *)(fp - sizeof(struct stackframe));
> +
> +	/* Check accessibility of one struct frame_tail beyond */
> +	if (!access_ok(user_frame_tail, sizeof(buftail)))
> +		return 0;
> +	if (__copy_from_user_inatomic(&buftail, user_frame_tail,
> +				      sizeof(buftail)))
> +		return 0;
> +
> +	ra = reg_ra ? : buftail.ra;
> +
> +	fp = buftail.fp;
> +	if (!ra || !consume_entry(cookie, ra))
> +		return 0;
> +
> +	return fp;
> +}
> +
> +void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
> +			  const struct pt_regs *regs)
> +{
> +	unsigned long fp = 0;
> +
> +	fp = regs->s0;
> +	if (!consume_entry(cookie, regs->epc))
> +		return;
> +
> +	fp = unwind_user_frame(consume_entry, cookie, fp, regs->ra);
> +	while (fp && !(fp & 0x7))
> +		fp = unwind_user_frame(consume_entry, cookie, fp, 0);
> +}
