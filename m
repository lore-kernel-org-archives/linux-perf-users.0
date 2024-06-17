Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8403228FA;
	Mon, 17 Jun 2024 01:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718588186; cv=none; b=bJeGzo9f6fg86Ptor96sjN0e9M7WYVZpvdq6gqc2NPisUWsoKti0/+3KaGKc67deQhxnwOmJmHplBHHXNJQFpTHZri3Z44ohRm6LvP+s6kZSIxlJldrsJVMf5JLMGtQTV9hTEcqqiEJ1EOTy6sm3cwPb07bRndgvDt0mVleg8+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718588186; c=relaxed/simple;
	bh=9H1/J8OKKqVwu2xDiBQTLiXvt6EywQ1255mf6P8udi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KGPgEKyrYpz8LXyUbtxUTEF83zFYEPs+s0ZDztDZCZ1PpXZG11DC7ehk031R/HFbu+fLDY7LeCNT365MUbZ6GfavBxJZUoIYv881KLfM8Xt0XNZ8nZTBKKzSzChenb+LuE5yuCM6ZBaO/aKaI1aEgSllFtx24N+N4W7ksTW0rOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W2XVs1DvKzdbN5;
	Mon, 17 Jun 2024 09:34:45 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id AAB32140258;
	Mon, 17 Jun 2024 09:36:14 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 09:36:13 +0800
Message-ID: <c5b6aca7-4673-f529-45ec-edbacca7a2ac@huawei.com>
Date: Mon, 17 Jun 2024 09:36:12 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] riscv: stacktrace: Add USER_STACKTRACE support
Content-Language: en-US
To: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<dev.mbstr@gmail.com>, <samuel.holland@sifive.com>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>
References: <20240604034729.841930-1-ruanjinjie@huawei.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240604034729.841930-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi100008.china.huawei.com (7.221.188.57)

 Gentle ping.

On 2024/6/4 11:47, Jinjie Ruan wrote:
> Currently, userstacktrace is unsupported for riscv. So use the
> perf_callchain_user() code as blueprint to implement the
> arch_stack_walk_user() which add userstacktrace support on riscv.
> Meanwhile, we can use arch_stack_walk_user() to simplify the implementation
> of perf_callchain_user().
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406012109.PDAjXm2i-lkp@intel.com/
> ---
> v2:
> - Fix the cocci warning, !A || A && B is equivalent to !A || B.
> ---
>  arch/riscv/Kconfig                 |  1 +
>  arch/riscv/kernel/perf_callchain.c | 46 ++----------------------------
>  arch/riscv/kernel/stacktrace.c     | 43 ++++++++++++++++++++++++++++
>  3 files changed, 47 insertions(+), 43 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0525ee2d63c7..6ed96d935b8f 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -193,6 +193,7 @@ config RISCV
>  	select THREAD_INFO_IN_TASK
>  	select TRACE_IRQFLAGS_SUPPORT
>  	select UACCESS_MEMCPY if !MMU
> +	select USER_STACKTRACE_SUPPORT
>  	select ZONE_DMA32 if 64BIT
>  
>  config CLANG_SUPPORTS_DYNAMIC_FTRACE
> diff --git a/arch/riscv/kernel/perf_callchain.c b/arch/riscv/kernel/perf_callchain.c
> index 3348a61de7d9..c7468af77c66 100644
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
> -	while (fp && !(fp & 0x3) && entry->nr < entry->max_stack)
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
> index 528ec7cc9a62..9685a2baa5d9 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -161,3 +161,46 @@ noinline void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie
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
> +	while (fp && !(fp & 0x3))
> +		fp = unwind_user_frame(consume_entry, cookie, fp, 0);
> +}
