Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096006;
	b=obA6jjrzz2SYdvoFgoWJrD7F0+re1v0qVF/7cXj8GOzrFxiw/+PPc+XqaR7OEbhu1CNv
	 rmg8JhcMQb8727OaijvGvk+X7qwrl0SPX4wVZSrK/itqoQqgGobRgZ4b68go/O/ibmbc9
	 imSaA8VD/UA4TRYrYow5/hkIhr9m1qfZYga/fWIP9AfEEIdrV77dRN5rnz/qCTZsEyeD5
	 144EHGX0Ma/uV8eko+0NTWkXn2emWaQ2eJ3onHVXZR5vK+muggMdArNmpZqCYiVnP+aw+
	 TPp56kTZSMIWApEuA47a8Ym9Blpczp715wfijR4Q5xgHdyAvjkRHwsaSLCckI0+xUfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096006;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=aFjgMZT4ij3QgwOV3LfQIHaT7HzWZzkda031aoTFEzs=;
	b=g6HD1bX1EOwZ+zLaRehgf5kwmaFJUXAXmmggQK/g3MRpe6UyCOMTHX1QMRc71fpj4Z1o
	 QJo0K0wjF/lW+l0zm8aoQMYbvBM4VfeR5OloZX1q+LH2hVS8GYLkXemX1CKOeVqd3sPiQ
	 62PbrKQaprKSGB6sYhgXl9IgS3OvXerqrXz4wFVQTwCwrmosIMAsJ4eknEGkRBqXc4BJK
	 Q17RTroKiJNsT8s0Wv5Qze+paz7IDQsKN0NKbA8ktFiII7pNRE11KAPDuCp4d3RXjT92h
	 laQH2dzTEWyIPrdDUMTCgWtBH+RyIKpDW7cai/GHhirZCx7+NjfR3+pR5edomji0aRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BFFu1MCk;
	arc=none smtp.remote-ip=95.215.58.100
Received: from mta1.migadu.com (out-100.mta1.migadu.com [95.215.58.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABB460A2600
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 13:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4ABB460A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BFFu1MCk
X-Envelope-To: linux-perf-users@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=++jxRWVPeWHHNOse9hUX9VVHA8pC7zSS/WWi8a/OqNw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795096004; v=1; x=1795700804;
 b=BFFu1MCkYDNvS1QBOd5lfM7XsW1mMv06+SULHYpVMq7qtH+10lOdRlpTXISGV6TiSnMuBcFc
 skn6vs9IegdwLkYMZuuYzEpnRnLF9NLyjRQnhIp78mxyGtNgCkxdl38pbXyb4fbcbk6/wca4zUS
 e9MVHuQ3frEjO2yzdIuht1cM=
X-Envelope-To: linux-perf-users@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 799fbb2e29e87772;
	Thu, 19 Nov 2026 13:46:44 +0000
X-Mizu-Trace-ID: 799fbb2e29e87772
X-Migadu-Flow: FLOW_OUT
Message-ID: <69a099c3-082e-43b8-82f5-122d32df5eff@linux.dev>
Date: Thu, 19 Nov 2026 14:46:39 +0100
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 06/11] riscv: enable NMI-safe lockdep irqflags
 tracking
To: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 himanshu.chauhan@oss.qualcomm.com, conor@kernel.org,
 anup.patel@oss.qualcomm.com
Cc: cuiyunhui@bytedance.com, atish.patra@linux.dev, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
 will@kernel.org, tglx@kernel.org, corbet@lwn.net, rdunlap@infradead.org,
 shuah@kernel.org, yuanzhu@bytedance.com, yang.susheng@zte.com.cn,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20261119120824.13969-13-zhangzhanpeng.jasper@bytedance.com>
 <20261119120824.13969-19-zhangzhanpeng.jasper@bytedance.com>
Content-Language: en-US
From: Clement Leger <clement.leger@linux.dev>
In-Reply-To: <20261119120824.13969-19-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/19/26 13:08, Zhanpeng Zhang wrote:
> An SSE handler runs with interrupts masked, but can interrupt code whose
> lockdep hardirq state is enabled. Bare nmi_enter()/nmi_exit() do not
> update that state. Consequently, lockdep_assert_irqs_disabled() in the
> perf overflow path can report a warning despite interrupts being masked.
> 
> Select TRACE_IRQFLAGS_NMI_SUPPORT so lockdep can update its hardirq state
> inside an NMI. Pair this with irqentry_nmi_enter()/irqentry_nmi_exit() in
> the SSE wrapper: these helpers save the previous tracked state, mark
> interrupts disabled on entry and restore the tracked state on exit.
> Selecting the configuration option alone does not perform those updates.
> This follows the entry helpers used by the other RISC-V NMI-like traps.
> 
> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> ---
>   arch/riscv/Kconfig          | 1 +
>   arch/riscv/kernel/sbi_sse.c | 7 ++++---
>   2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d2db8f40c616..5501c02a07eb 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -225,6 +225,7 @@ config RISCV
>   	select SYSCTL_EXCEPTION_TRACE
>   	select THREAD_INFO_IN_TASK
>   	select TRACE_IRQFLAGS_SUPPORT
> +	select TRACE_IRQFLAGS_NMI_SUPPORT
>   	select UACCESS_MEMCPY if !MMU
>   	select VDSO_DATASTORE if MMU
>   	select VDSO_GETRANDOM if MMU && 64BIT
> diff --git a/arch/riscv/kernel/sbi_sse.c b/arch/riscv/kernel/sbi_sse.c
> index 032fcc07abcf..59e47a39589d 100644
> --- a/arch/riscv/kernel/sbi_sse.c
> +++ b/arch/riscv/kernel/sbi_sse.c
> @@ -2,7 +2,7 @@
>   /*
>    * Copyright (C) 2025 Rivos Inc.
>    */
> -#include <linux/nmi.h>
> +#include <linux/entry-common.h>
>   #include <linux/sched.h>
>   #include <linux/scs.h>
>   #include <linux/bitfield.h>
> @@ -36,9 +36,10 @@ void noinstr do_sse(struct sse_event_arch_data *arch_evt,
>   {
>   	struct riscv_sse_interrupted_context context = { regs, hstatus };
>   	struct riscv_sse_interrupted_context *previous;
> +	irqentry_state_t state;
>   	struct sbiret sret;
>   
> -	nmi_enter();
> +	state = irqentry_nmi_enter(regs);
>   	instrumentation_begin();
>   
>   	/* Retrieve missing GPRs from SBI */
> @@ -84,7 +85,7 @@ void noinstr do_sse(struct sse_event_arch_data *arch_evt,
>   
>   out:
>   	instrumentation_end();
> -	nmi_exit();
> +	irqentry_nmi_exit(regs, state);
>   }
>   
>   static void *alloc_to_stack_pointer(void *alloc)

Hi Zhanpeng,

Not sure if it was already suggested but I would fold that in the commit 
adding SSE itself.

Thanks,

Clément
