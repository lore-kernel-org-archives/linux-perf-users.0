Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B0349EC46
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 07:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791964052; cv=pass; b=c1thFOTH9GhTU0iStPC2bbckmD0CD05FUDmk8fDjW28RXJlIzDv5q1PEVDvSfgksWbGe23EZkXSKZk31oYY9/sBxuGi98CEBLrVa/PtXiv46eV+V+Is3o++3+7PDvefCqAGOcFiAQZfmKsbYahyE+WHs+qApGFQ3d0/IDReHSH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791964052; c=relaxed/simple;
	bh=szULTSiZCToMfXUC0sW6DGVWrok2K+AherkLP5GkncM=;
	h=Mime-Version:In-Reply-To:From:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L2jKxn/pHyFIOqymiZWt/UCe3MbxsZTQ1A0YEFV6k1OV33I0qEEpfVL/N7HNVwQuVxVFlGEyNGJLPMj3ILCiJYpjKGY2fBzu0a4HeHnd1HNXR1XM5n+4PDjsfp23z1YMW3koCyezHw/1CC4vV9OB+iYYmEgqsCglokW+ontKiEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kvajUy6x; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kvajUy6x"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5bcdab9a82bso4333826e87.3
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 00:47:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791964046; cv=none;
        d=google.com; s=arc-20260327;
        b=lkxWTubkJFP7IvzfMi8+ukJUyzo4Wmu7U3rN2E7H4mZTKQrEekLFEM8SeP3JsGSef+
         jz/EPkank+Kza3u0P3F1u5cPoJMh3iprDU18sH0HSHB21URX5vWvSuraLbqYblNftEs0
         EPu+UvYZNTtDCpyj6UOmiVnTqlwt/11SuSqpYUY8Nhja/neG/uLQAaachAd40ZiQ13IP
         A5zXFt6Zo4FSHFdrNcWq1h5uZ7hvyHff1xkq34KJ10hq24H+kbwjVHwzqnpKHdl9Wxbx
         Gwn63v+cEprKaJN+jndmqACQiM4WTZmvWFxfFCAT8sAXjrslkqamYQNJq7Gkqw991TZD
         cg5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :from:in-reply-to:user-agent:mime-version:dkim-signature;
        bh=uQU/nIYkeb2qYgioxX+4QEtoGgs62CovQ4j6LxDg9bQ=;
        fh=IeNNNzWmmc1A9cV6To0i8ONyZBRV33bT2j4XHLsLDjU=;
        b=WcfAbhmCyuVAG3PAaLsn1Q4M3o2eZjI6XyVJ/vXjmxHpvOQHwto93wTGL0gz/5Liu4
         vU1jhhdkgXw5E5o2UuDvqf/ukedUs8dVlFzgjsTOiKUAxHP/5ERQN8npnXYIEK2ZuyyZ
         ma3ea0hB4DaLZK7fR+EQ0J+gWhBtrQ0QGgq2IMoH3tH80N0U/MC5w845dz9kaV8j4tuQ
         n6awRjOsJczFr4P82gr3LD5cP2bv99R6zWuZKcxe+ZFQ1zPK5Zg0iWCHia0BAsU069Iw
         foVUsbcUj2h5AP+aHWfpZOPC+xzz8SGsyunwKtFbjrod2emhsmR9qvGsUxqcjGk2dpKN
         njdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1791964046; x=1792568846; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:references:from:in-reply-to:user-agent:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uQU/nIYkeb2qYgioxX+4QEtoGgs62CovQ4j6LxDg9bQ=;
        b=kvajUy6x8NqiCJ0YA0tXjCD8KtgLAXbYKuBlMsAKyoMDW2xbBb2mwIwl0/V8va1z1E
         0pUyAZ2mmRAlMneT2GW/sLkey6hzZK+BdPY5641HlUW5Dirtg60AuZsPt6uFd/BJdY3v
         Xmj8rg4x0rALWLzLN3TkxNujgaR6Z/0p/UjQfhC/V/mzceWTLvmFFl/W8JVJI9UR73JW
         QXRybyACFuj8URXz+lqUAdrsFNgRyowwamT35Irqbq8NsES7AdJoUTQ5QxNzze3F9M7D
         aglGOSQrL230Qt2nP0nOlu9fp1ZN9KXTFNpTKJ42trs8+DWGwvi4RiKWoZpRv5xNv0hH
         YINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791964046; x=1792568846;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:references:from:in-reply-to:user-agent:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uQU/nIYkeb2qYgioxX+4QEtoGgs62CovQ4j6LxDg9bQ=;
        b=d2gbTCMv8NAjvo1tEsTnH8QxwkAE+cy9S6LLI9Bv80dHHbo7Ay2pYbG8/MhM1zoApD
         tVEz3Dla9LvlhufyvODembHNjPj/Moy9/4ELo3s72bzX3sqUy/Rigllnmljigg0KYdXT
         DYX/Cne/yoOfko9T0n/X91u3zjWq/uyT6D74USlqXtc4mh5T4yfUWuqldbToYhaM9Zh5
         kXkdZVCdIWneo/ASt6IfE7ZjlZjOUaSzC9OrDykDVRss27eJpzvZHUyHjKRV+GyySImz
         GQh80flXzHNOOBadPfbdsxMtPE9F2aq6Kbo9a6hVICaoSaKivVZmq8lLbAqRZx7IW9+q
         buyg==
X-Forwarded-Encrypted: i=1; AKwUvByW7X+ABOpoI5RqEUqj5EA/PJ8BHYxuwbGsiYpaDMgBdJ5w2zfZbBI9jTCG4qEoBw4RYNWpkeImp8qHv1np7DIk@vger.kernel.org
X-Gm-Message-State: AFq9FYJZ1oBA2w/rTkpFqqXT1AQOyF5VG8hkMzo+GLxblsTWoy2h3PMj
	I9uvsvgglf4ebPNLqTG/Ei+wB28ssvIvVxUKXMN+I+SVDSpaYNtRajRRzVTzC927SIwEtyd8qRi
	liGzM0ZpHHeM6iolccgAj/KjyCEmVLNBC/FjsKccNDg==
X-Gm-Gg: AYBFou2kHCaMdMt9+IGiQw1ZDInlE5KOg3hxJ/FtxhZWjTl/PVX1HK86lHcZzm/SGym
	uzWA2dkcd2APk/z3M74tx3fgBWBDnfC5fLBqc6/jmBu/+1eTwnRwKVZj/XmuBtO59N1TEecYjUe
	qMoYrzN5E8/C/VHizzEqF20S0+Ut4Bn81po9HFFPYU+wFeRsSZtEqvC6PFMaUMs26KjdLs6GEds
	AZdjLCgMgFQYkBdenq2AHxBDwnGpNAWZ9gK9oqCJC9Tl6gVcMcN5PPjCA4PoMo8nu1SsaMU93Rm
	7sH4QWs9ttnfmOp746yK5zpIJbWHNrwJ0gZkEQMGwWIZ1wXEMR4Ai2pSR78mNEhSXA==
X-Received: by 2002:a05:6512:3a82:b0:5b5:e7a8:9b1d with SMTP id
 2adb3069b0e04-5bcde6becffmr5561631e87.13.1791964045419; Wed, 14 Oct 2026
 00:47:25 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 14 Oct 2026 00:47:23 -0700
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 14 Oct 2026 00:47:23 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
In-Reply-To: <as79MHtNYd-VbUug@hu-himchau-blr.qualcomm.com>
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
X-Original-From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
References: <cover.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
 <d067d9d2a8f33d480ebdcce276328a336aa26073.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
 <as79MHtNYd-VbUug@hu-himchau-blr.qualcomm.com>
Date: Wed, 14 Oct 2026 00:47:23 -0700
X-Gm-Features: AclHuK9p5ukO5nMBwIO0IVWu8-DV4By1_-ZwiIQepUJM_tZO8g7IWHxV0TjuMGI
Message-ID: <CACnXVncx=eh=HcQHJisc7Odu3cxue3edMT4ig3JQ6FHKq_3cmw@mail.gmail.com>
Subject: Re: [PATCH v10 RESEND 2/9] riscv: add support for SBI Supervisor
 Software Events extension
To: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor@kernel.org>, 
	Anup Patel <anup@brainfault.org>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Yunhui Cui <cuiyunhui@bytedance.com>, Atish Patra <atish.patra@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Yuanzhu <yuanzhu@bytedance.com>, Yicong Yang <yang.yicong@picoheart.com>, 
	Susheng Yang <yang.susheng@zte.com.cn>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Himanshu,

On 10/14/26 11:55 AM, Himanshu Chauhan wrote:
> Hi Zhanpeng,
>
> On Mon, Sep 21, 2026 at 07:14:59PM +0800, Zhanpeng Zhang wrote:
>> From: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
>>
>> The SBI SSE extension allows firmware to notify supervisor software of
>> events that must be delivered independently of normal S-mode interrupts.
>> Firmware saves the minimal state required to enter the supervisor handle=
r,
>> and Linux builds the synthetic handler context around it.
>>
>> SSE can arrive while Linux is already in an exception entry path. At tha=
t
>> point sscratch and tp may be in the middle of the normal trap-entry
>> exchange, so they cannot always identify current. Store current in a
>> per-CPU slot and use the hart ID passed by firmware to recover it.
>>
>> Give each event, including each CPU instance of a local event, a dedicat=
ed
>> stack and shadow call stack. Synchronize vmapped stack ranges before
>> unmasking events so that the handler cannot take a vmalloc fault while
>> running in an NMI-like context.
>>
>> The handler is a synthetic supervisor episode, but completion must resum=
e
>> the context interrupted by the SSE. Preserve stvec and, when the hypervi=
sor
>> extension is present, hstatus across the handler. Read the interrupted a=
6
>> and a7 values from the SSE attributes, construct pt_regs for the
>> interrupted context, and write back any changes made by the handler.
>>
>> Nested exceptions on the SSE event stack temporarily replace both
>> TASK_TI_KERNEL_SP and TASK_TI_USER_SP. Preserve their original values
>> across the handler and restore them before completing the event, so a
>> nested exception cannot leave the interrupted task referring to the even=
t
>> stack.
>>
>> Keep an explicit EVENT_REGISTER not-supported result distinct from other
>> firmware failures. This lets clients select another delivery mechanism
>> only when firmware has positively rejected the requested event.
>>
>> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
>> Co-developed-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
>> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
>> Co-developed-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
>> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
>> ---
>>   MAINTAINERS                          |  12 ++
>>   arch/riscv/include/asm/asm.h         |  14 +-
>>   arch/riscv/include/asm/scs.h         |   7 +
>>   arch/riscv/include/asm/sse.h         |  82 +++++++++
>>   arch/riscv/include/asm/thread_info.h |   1 +
>>   arch/riscv/kernel/Makefile           |   1 +
>>   arch/riscv/kernel/asm-offsets.c      |  14 ++
>>   arch/riscv/kernel/entry.S            |  14 ++
>>   arch/riscv/kernel/sbi_sse.c          | 246 +++++++++++++++++++++++++++
>>   arch/riscv/kernel/sbi_sse_entry.S    | 226 ++++++++++++++++++++++++
>>   10 files changed, 614 insertions(+), 3 deletions(-)
>>   create mode 100644 arch/riscv/include/asm/sse.h
>>   create mode 100644 arch/riscv/kernel/sbi_sse.c
>>   create mode 100644 arch/riscv/kernel/sbi_sse_entry.S
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index cc3cae2e378b..7a6af19f7e30 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -23595,6 +23595,18 @@ F:	arch/riscv/boot/dts/spacemit/
>>   N:	spacemit
>>   K:	spacemit
>>
>> +RISC-V SUPERVISOR SOFTWARE EVENTS
>> +M:	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
>> +M:	Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
>> +R:	Yunhui Cui <cuiyunhui@bytedance.com>
>> +L:	linux-riscv@lists.infradead.org
>> +S:	Maintained
>> +F:	arch/riscv/include/asm/sse.h
>> +F:	arch/riscv/kernel/sbi_sse.c
>> +F:	arch/riscv/kernel/sbi_sse_entry.S
>> +F:	drivers/firmware/riscv/riscv_sbi_sse.c
>> +F:	include/linux/riscv_sbi_sse.h
>> +
> I would suggest that you make changes in maintainers as a separate patch.
>
Agreed. I'll move the MAINTAINERS changes into a separate patch in v11.

>>   RISC-V TENSTORRENT SoC SUPPORT
>>   M:	Drew Fustini <dfustini@oss.tenstorrent.com>
>>   M:	Joel Stanley <jms@oss.tenstorrent.com>
>> diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
>> index b8bf842d4c13..e1196caea02d 100644
>> --- a/arch/riscv/include/asm/asm.h
>> +++ b/arch/riscv/include/asm/asm.h
>> @@ -91,16 +91,24 @@
>>   .endm
>>
>>   #ifdef CONFIG_SMP
>> -.macro asm_per_cpu dst sym tmp
>> -	lw    \tmp, TASK_TI_CPU_NUM(tp)
>> -	slli  \tmp, \tmp, RISCV_LGPTR
>> +.macro asm_per_cpu_with_cpu dst sym tmp cpu
>> +	slli  \tmp, \cpu, RISCV_LGPTR
>>   	la    \dst, __per_cpu_offset
>>   	add   \dst, \dst, \tmp
>>   	REG_L \tmp, 0(\dst)
>>   	la    \dst, \sym
>>   	add   \dst, \dst, \tmp
>>   .endm
>> +
>> +.macro asm_per_cpu dst sym tmp
>> +	lw \tmp, TASK_TI_CPU_NUM(tp)
>> +	asm_per_cpu_with_cpu \dst \sym \tmp \tmp
>> +.endm
>>   #else /* CONFIG_SMP */
>> +.macro asm_per_cpu_with_cpu dst sym tmp cpu
>> +	la    \dst, \sym
>> +.endm
>> +
>>   .macro asm_per_cpu dst sym tmp
>>   	la    \dst, \sym
>>   .endm
>> diff --git a/arch/riscv/include/asm/scs.h b/arch/riscv/include/asm/scs.h
>> index 023a412fe38d..0d70a35bc01a 100644
>> --- a/arch/riscv/include/asm/scs.h
>> +++ b/arch/riscv/include/asm/scs.h
>> @@ -17,6 +17,11 @@
>>   	load_per_cpu gp, irq_shadow_call_stack_ptr, \tmp
>>   .endm
>>
>> +/* Load the per-CPU IRQ shadow call stack to gp. */
>> +.macro scs_load_sse_stack reg_evt
>> +	REG_L gp, SSE_REG_EVT_SHADOW_STACK(\reg_evt)
>> +.endm
>> +
>>   /* Load task_scs_sp(current) to gp. */
>>   .macro scs_load_current
>>   	REG_L	gp, TASK_TI_SCS_SP(tp)
>> @@ -40,6 +45,8 @@
>>   .endm
>>   .macro scs_load_irq_stack tmp
>>   .endm
>> +.macro scs_load_sse_stack reg_evt
>> +.endm
>>   .macro scs_load_current
>>   .endm
>>   .macro scs_load_current_if_task_changed prev
>> diff --git a/arch/riscv/include/asm/sse.h b/arch/riscv/include/asm/sse.h
>> new file mode 100644
>> index 000000000000..cbd8618c6e00
>> --- /dev/null
>> +++ b/arch/riscv/include/asm/sse.h
>> @@ -0,0 +1,82 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (C) 2024 Rivos Inc.
>> + */
>> +#ifndef __ASM_SSE_H
>> +#define __ASM_SSE_H
>> +
>> +#include <linux/printk.h>
>> +#include <linux/types.h>
>> +
>> +#include <asm/sbi.h>
>> +
>> +static inline bool riscv_sse_available(void)
>> +{
>> +#ifdef CONFIG_RISCV_SBI
>> +	return sbi_probe_extension(SBI_EXT_SSE) > 0;
>> +#else
>> +	return false;
>> +#endif
>> +}
>> +
>> +static inline void riscv_sse_mask_current_hart(void)
>> +{
>> +#ifdef CONFIG_RISCV_SBI
>> +	struct sbiret ret;
>> +
>> +	if (!riscv_sse_available())
>> +		return;
>> +
>> +	ret =3D sbi_ecall(SBI_EXT_SSE, SBI_SSE_HART_MASK, 0, 0, 0, 0, 0, 0);
>> +	if (ret.error && ret.error !=3D SBI_ERR_ALREADY_STOPPED)
>> +		pr_emerg("SSE hart mask failed: %ld\n", ret.error);
>> +#endif
>> +}
>> +
>> +#ifdef CONFIG_RISCV_SBI_SSE
>> +
>> +struct sse_event_interrupted_state {
>> +	unsigned long a6;
>> +	unsigned long a7;
>> +};
>> +
>> +struct sse_event_arch_data {
>> +	void *stack;
>> +	void *shadow_stack;
>> +	unsigned long tmp;
>> +	struct sse_event_interrupted_state *interrupted;
>> +	phys_addr_t interrupted_phys;
>> +	u32 evt_id;
>> +	unsigned long hart_id;
>> +	unsigned int cpu_id;
>> +};
>> +
>> +struct riscv_sse_interrupted_context {
>> +	struct pt_regs *regs;
>> +	unsigned long hstatus;
>> +};
>> +
>> +static inline bool sse_event_is_global(u32 evt)
>> +{
>> +	return !!(evt & SBI_SSE_EVENT_GLOBAL);
>> +}
>> +
>> +void arch_sse_event_update_cpu(struct sse_event_arch_data *arch_evt, in=
t cpu);
>> +int arch_sse_init_event(struct sse_event_arch_data *arch_evt, u32 evt_i=
d,
>> +			int cpu);
>> +void arch_sse_free_event(struct sse_event_arch_data *arch_evt);
>> +int arch_sse_register_event(struct sse_event_arch_data *arch_evt);
>> +void arch_sse_init_cpu(void);
>> +
>> +void sse_handle_event(struct sse_event_arch_data *arch_evt,
>> +		      struct pt_regs *regs);
>> +asmlinkage void handle_sse(void);
>> +asmlinkage void noinstr do_sse(struct sse_event_arch_data *arch_evt,
>> +			       struct pt_regs *regs, unsigned long hstatus);
>> +
>> +const struct riscv_sse_interrupted_context *
>> +riscv_sse_get_interrupted_context(void);
>> +
>> +#endif
>> +
>> +#endif
>> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/a=
sm/thread_info.h
>> index 55019fdfa9ec..d14b45610c73 100644
>> --- a/arch/riscv/include/asm/thread_info.h
>> +++ b/arch/riscv/include/asm/thread_info.h
>> @@ -36,6 +36,7 @@
>>   #define OVERFLOW_STACK_SIZE     SZ_4K
>>
>>   #define IRQ_STACK_SIZE		THREAD_SIZE
>> +#define SSE_STACK_SIZE		THREAD_SIZE
>>
>>   #ifndef __ASSEMBLER__
>>
>> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
>> index ebe1c3588177..1e34f87e97c0 100644
>> --- a/arch/riscv/kernel/Makefile
>> +++ b/arch/riscv/kernel/Makefile
>> @@ -101,6 +101,7 @@ obj-$(CONFIG_DYNAMIC_FTRACE)	+=3D mcount-dyn.o
>>   obj-$(CONFIG_PERF_EVENTS)	+=3D perf_callchain.o
>>   obj-$(CONFIG_HAVE_PERF_REGS)	+=3D perf_regs.o
>>   obj-$(CONFIG_RISCV_SBI)		+=3D sbi.o sbi_ecall.o
>> +obj-$(CONFIG_RISCV_SBI_SSE)	+=3D sbi_sse.o sbi_sse_entry.o
>>   ifeq ($(CONFIG_RISCV_SBI), y)
>>   obj-$(CONFIG_SMP)		+=3D sbi-ipi.o
>>   obj-$(CONFIG_SMP) +=3D cpu_ops_sbi.o
>> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-off=
sets.c
>> index a75f0cfea1e9..15363703cdd6 100644
>> --- a/arch/riscv/kernel/asm-offsets.c
>> +++ b/arch/riscv/kernel/asm-offsets.c
>> @@ -15,6 +15,8 @@
>>   #include <asm/ptrace.h>
>>   #include <asm/cpu_ops_sbi.h>
>>   #include <asm/stacktrace.h>
>> +#include <asm/sbi.h>
>> +#include <asm/sse.h>
>>   #include <asm/suspend.h>
>>
>>   void asm_offsets(void);
>> @@ -533,6 +535,18 @@ void asm_offsets(void)
>>   	DEFINE(FREGS_A6,	    offsetof(struct __arch_ftrace_regs, a6));
>>   	DEFINE(FREGS_A7,	    offsetof(struct __arch_ftrace_regs, a7));
>>   #endif
>> +
>> +#ifdef CONFIG_RISCV_SBI_SSE
>> +	OFFSET(SSE_REG_EVT_STACK, sse_event_arch_data, stack);
>> +	OFFSET(SSE_REG_EVT_SHADOW_STACK, sse_event_arch_data, shadow_stack);
>> +	OFFSET(SSE_REG_EVT_TMP, sse_event_arch_data, tmp);
>> +	OFFSET(SSE_REG_HART_ID, sse_event_arch_data, hart_id);
>> +	OFFSET(SSE_REG_CPU_ID, sse_event_arch_data, cpu_id);
>> +
>> +	DEFINE(SBI_EXT_SSE, SBI_EXT_SSE);
>> +	DEFINE(SBI_SSE_EVENT_COMPLETE, SBI_SSE_EVENT_COMPLETE);
>> +	DEFINE(ASM_NR_CPUS, CONFIG_NR_CPUS);
>> +#endif
>>   #ifdef CONFIG_RISCV_SBI
>>   	DEFINE(SBI_EXT_FWFT, SBI_EXT_FWFT);
>>   	DEFINE(SBI_EXT_FWFT_SET, SBI_EXT_FWFT_SET);
>> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>> index d799c4e56f80..0b79fa7241ea 100644
>> --- a/arch/riscv/kernel/entry.S
>> +++ b/arch/riscv/kernel/entry.S
>> @@ -424,6 +424,15 @@ SYM_FUNC_END(call_on_irq_stack)
>>    * arguments are passed to schedule_tail.
>>    */
>>   SYM_FUNC_START(__switch_to)
>> +#ifdef CONFIG_RISCV_SBI_SSE
>> +	/*
>> +	 * Mark the interval where tp changes from prev to next. SSE entry use=
s
>> +	 * the interrupted tp while this per-CPU pointer is NULL.
>> +	 */
>> +	asm_per_cpu t0, __sbi_sse_entry_task, t1
>> +	REG_S zero, 0(t0)
>> +#endif
>> +
>>   	/* Save context into prev->thread */
>>   	li    a4,  TASK_THREAD_RA
>>   	add   a3, a0, a4
>> @@ -470,6 +479,11 @@ SYM_FUNC_START(__switch_to)
>>   	REG_L s11, TASK_THREAD_S11_RA(a4)
>>   	/* The offset of thread_info in task_struct is zero. */
>>   	move tp, a1
>> +#ifdef CONFIG_RISCV_SBI_SSE
>> +	/* Publish next only after tp contains its task_struct pointer. */
>> +	asm_per_cpu t0, __sbi_sse_entry_task, t1
>> +	REG_S tp, 0(t0)
>> +#endif
>>   	/* Switch to the next shadow call stack */
>>   	scs_load_current
>>   	ret
>> diff --git a/arch/riscv/kernel/sbi_sse.c b/arch/riscv/kernel/sbi_sse.c
>> new file mode 100644
>> index 000000000000..7dd496e2bdb0
>> --- /dev/null
>> +++ b/arch/riscv/kernel/sbi_sse.c
>> @@ -0,0 +1,246 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2025 Rivos Inc.
>> + */
>> +#include <linux/nmi.h>
>> +#include <linux/sched.h>
>> +#include <linux/scs.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/percpu-defs.h>
>> +#include <linux/string.h>
>> +
>> +#include <asm/asm-prototypes.h>
>> +#include <asm/switch_to.h>
>> +#include <asm/irq_stack.h>
>> +#include <asm/sbi.h>
>> +#include <asm/sse.h>
>> +#include <asm/tlbflush.h>
>> +
>> +DEFINE_PER_CPU(struct task_struct *, __sbi_sse_entry_task);
>> +static DEFINE_PER_CPU(struct riscv_sse_interrupted_context *,
>> +			      riscv_sse_interrupted_context);
>> +
>> +const struct riscv_sse_interrupted_context *
>> +riscv_sse_get_interrupted_context(void)
>> +{
>> +	return this_cpu_read(riscv_sse_interrupted_context);
>> +}
>> +
>> +void __weak sse_handle_event(struct sse_event_arch_data *arch_evt, stru=
ct pt_regs *regs)
>> +{
>> +}
>> +
>> +void noinstr do_sse(struct sse_event_arch_data *arch_evt,
>> +		    struct pt_regs *regs, unsigned long hstatus)
>> +{
>> +	struct riscv_sse_interrupted_context context =3D { regs, hstatus };
>> +	struct riscv_sse_interrupted_context *previous;
>> +	struct sbiret sret;
>> +
>> +	nmi_enter();
>> +	instrumentation_begin();
>> +
>> +	/* Retrieve missing GPRs from SBI */
>> +	sret =3D sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_ATTR_READ, arch_evt->evt=
_id,
>> +			 SBI_SSE_ATTR_INTERRUPTED_A6,
>> +			 (SBI_SSE_ATTR_INTERRUPTED_A7 -
>> +			  SBI_SSE_ATTR_INTERRUPTED_A6) + 1,
>> +			 (unsigned long)arch_evt->interrupted_phys, 0, 0);
>> +	if (sret.error) {
>> +		pr_warn("Failed to read interrupted registers for event %x: %ld\n",
>> +			arch_evt->evt_id, sret.error);
>> +		/* Let the client quiesce its source without using incomplete regs. *=
/
>> +		sse_handle_event(arch_evt, NULL);
>> +		goto out;
>> +	}
>> +
>> +	memcpy(&regs->a6, arch_evt->interrupted,
>> +	       sizeof(*arch_evt->interrupted));
>> +
>> +	/* Make the interrupted frame visible while clients handle this event.=
 */
>> +	previous =3D this_cpu_read(riscv_sse_interrupted_context);
>> +	this_cpu_write(riscv_sse_interrupted_context, &context);
>> +	sse_handle_event(arch_evt, regs);
>> +	this_cpu_write(riscv_sse_interrupted_context, previous);
>> +
>> +	if (memcmp(&regs->a6, arch_evt->interrupted,
>> +		   sizeof(*arch_evt->interrupted))) {
>> +		memcpy(arch_evt->interrupted, &regs->a6,
>> +		       sizeof(*arch_evt->interrupted));
>> +		sret =3D sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_ATTR_WRITE,
>> +				 arch_evt->evt_id, SBI_SSE_ATTR_INTERRUPTED_A6,
>> +				 (SBI_SSE_ATTR_INTERRUPTED_A7 -
>> +				  SBI_SSE_ATTR_INTERRUPTED_A6) + 1,
>> +				 (unsigned long)arch_evt->interrupted_phys, 0, 0);
>> +		/*
>> +		 * If writeback fails, COMPLETE resumes with firmware's original
>> +		 * a6/a7 rather than treating the shared buffer as committed.
>> +		 */
>> +		if (sret.error)
>> +			pr_warn("Failed to write interrupted registers for event %x: %ld\n",
>> +				arch_evt->evt_id, sret.error);
>> +	}
>> +
>> +out:
>> +	instrumentation_end();
>> +	nmi_exit();
>> +}
>> +
>> +static void *alloc_to_stack_pointer(void *alloc)
>> +{
>> +	return alloc ? alloc + SSE_STACK_SIZE : NULL;
>> +}
>> +
>> +static void *stack_pointer_to_alloc(void *stack)
>> +{
>> +	return stack ? stack - SSE_STACK_SIZE : NULL;
>> +}
>> +
>> +static void arch_sse_flush_tlb_range(struct sse_event_arch_data *arch_e=
vt,
>> +				     unsigned long start, unsigned long size)
>> +{
>> +	unsigned long end =3D start + size;
>> +
>> +	if (sse_event_is_global(arch_evt->evt_id))
>> +		flush_tlb_kernel_range(start, end);
>> +	else
>> +		local_flush_tlb_kernel_range(start, end);
>> +}
>> +
>> +static void arch_sse_shadow_stack_cpu_sync(struct sse_event_arch_data *=
arch_evt)
>> +{
>> +#ifdef CONFIG_SHADOW_CALL_STACK
>> +	if (arch_evt->shadow_stack)
>> +		arch_sse_flush_tlb_range(arch_evt,
>> +					 (unsigned long)arch_evt->shadow_stack,
>> +					 SCS_SIZE);
>> +#endif
>> +}
>> +
>> +#ifdef CONFIG_VMAP_STACK
>> +static void *sse_stack_alloc(unsigned int cpu)
>> +{
>> +	void *stack =3D arch_alloc_vmap_stack(SSE_STACK_SIZE, cpu_to_node(cpu)=
);
>> +
>> +	return alloc_to_stack_pointer(stack);
>> +}
>> +
>> +static void sse_stack_free(void *stack)
>> +{
>> +	vfree(stack_pointer_to_alloc(stack));
>> +}
>> +
>> +static void arch_sse_stack_cpu_sync(struct sse_event_arch_data *arch_ev=
t)
>> +{
>> +	void *p_stack =3D arch_evt->stack;
>> +	unsigned long stack =3D (unsigned long)stack_pointer_to_alloc(p_stack)=
;
>> +
>> +	/*
>> +	 * Flush the tlb to avoid taking any exception when accessing the
>> +	 * vmapped stack inside the SSE handler
>> +	 */
>> +	arch_sse_flush_tlb_range(arch_evt, stack, SSE_STACK_SIZE);
>> +
>> +	arch_sse_shadow_stack_cpu_sync(arch_evt);
>> +}
>> +#else /* CONFIG_VMAP_STACK */
>> +static void *sse_stack_alloc(unsigned int cpu)
>> +{
>> +	void *stack =3D kmalloc(SSE_STACK_SIZE, GFP_KERNEL);
>> +
>> +	return alloc_to_stack_pointer(stack);
>> +}
>> +
>> +static void sse_stack_free(void *stack)
>> +{
>> +	kfree(stack_pointer_to_alloc(stack));
>> +}
>> +
>> +static void arch_sse_stack_cpu_sync(struct sse_event_arch_data *arch_ev=
t)
>> +{
>> +	arch_sse_shadow_stack_cpu_sync(arch_evt);
>> +}
>> +#endif /* CONFIG_VMAP_STACK */
>> +
>> +static int sse_init_scs(int cpu, struct sse_event_arch_data *arch_evt)
>> +{
>> +	void *stack;
>> +
>> +	if (!scs_is_enabled())
>> +		return 0;
>> +
>> +	stack =3D scs_alloc(cpu_to_node(cpu));
>> +	if (!stack)
>> +		return -ENOMEM;
>> +
>> +	arch_evt->shadow_stack =3D stack;
>> +
>> +	return 0;
>> +}
>> +
>> +void arch_sse_event_update_cpu(struct sse_event_arch_data *arch_evt, in=
t cpu)
>> +{
>> +	arch_evt->cpu_id =3D cpu;
>> +	arch_evt->hart_id =3D cpuid_to_hartid_map(cpu);
>> +}
>> +
>> +void arch_sse_init_cpu(void)
>> +{
>> +	__this_cpu_write(__sbi_sse_entry_task, current);
>> +}
>> +
> This is called from sse_cpu_online() in the cpuhp callback, which runs pr=
eemptible, and the
> boot CPU instance runs from an initcall. With DEBUG_PREEMPT you can get a=
 __this_cpu_write() in
> preemptible warning. Can you check? Moreover, if the task migrates betwee=
n computing the per-CPU
> address and the store, the wrong CPU's slot is written. I would suggest u=
se this_cpu_write()
> under preempt_disable().
>
Agreed. The existing preemption guards do not cover arch_sse_init_cpu().
I'll add preemption protection around the per-CPU update.

>> +int arch_sse_init_event(struct sse_event_arch_data *arch_evt, u32 evt_i=
d,
>> +			int cpu)
>> +{
>> +	void *stack;
>> +
>> +	arch_evt->interrupted =3D kmalloc_obj(*arch_evt->interrupted, GFP_KERN=
EL);
>> +	if (!arch_evt->interrupted)
>> +		return -ENOMEM;
>> +
>> +	arch_evt->evt_id =3D evt_id;
>> +	stack =3D sse_stack_alloc(cpu);
>> +	if (!stack)
>> +		goto err_free_interrupted;
>> +
>> +	arch_evt->stack =3D stack;
>> +
>> +	if (sse_init_scs(cpu, arch_evt)) {
>> +		sse_stack_free(arch_evt->stack);
>> +		goto err_free_interrupted;
>> +	}
>> +
>> +	/* kmalloc keeps the two adjacent SBI attribute words contiguous. */
>> +	arch_evt->interrupted_phys =3D virt_to_phys(arch_evt->interrupted);
>> +
>> +	arch_sse_event_update_cpu(arch_evt, cpu);
>> +
>> +	return 0;
>> +
>> +err_free_interrupted:
>> +	kfree(arch_evt->interrupted);
>> +	arch_evt->interrupted =3D NULL;
>> +	return -ENOMEM;
>> +}
>> +
>> +void arch_sse_free_event(struct sse_event_arch_data *arch_evt)
>> +{
>> +	scs_free(arch_evt->shadow_stack);
>> +	sse_stack_free(arch_evt->stack);
>> +	kfree(arch_evt->interrupted);
>> +}
>> +
>> +int arch_sse_register_event(struct sse_event_arch_data *arch_evt)
>> +{
>> +	struct sbiret sret;
>> +
>> +	arch_sse_stack_cpu_sync(arch_evt);
>> +
>> +	sret =3D sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_REGISTER, arch_evt->evt_=
id,
>> +			 (unsigned long)handle_sse, (unsigned long)arch_evt, 0,
>> +			 0, 0);
>> +	if (sret.error =3D=3D SBI_ERR_NOT_SUPPORTED)
>> +		return -EOPNOTSUPP;
>> +
>> +	return sbi_err_map_linux_errno(sret.error);
>> +}
>> diff --git a/arch/riscv/kernel/sbi_sse_entry.S b/arch/riscv/kernel/sbi_s=
se_entry.S
>> new file mode 100644
>> index 000000000000..e0e8efba12dd
>> --- /dev/null
>> +++ b/arch/riscv/kernel/sbi_sse_entry.S
>> @@ -0,0 +1,226 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * Copyright (C) 2025 Rivos Inc.
>> + */
>> +
>> +#include <linux/init.h>
>> +#include <linux/linkage.h>
>> +
>> +#include <asm/alternative-macros.h>
>> +#include <asm/asm.h>
>> +#include <asm/csr.h>
>> +#include <asm/hwcap.h>
>> +#include <asm/scs.h>
>> +
>> +/* When entering handle_sse, the following registers are set:
>> + * a6: contains the hartid
>> + * a7: contains a sse_event_arch_data struct pointer
>> + */
>> +SYM_CODE_START(handle_sse)
>> +	/* Save stack temporarily */
>> +	REG_S sp, SSE_REG_EVT_TMP(a7)
>> +	/* Set entry stack */
>> +	REG_L sp, SSE_REG_EVT_STACK(a7)
>> +
>> +	addi sp, sp, -(PT_SIZE_ON_STACK)
>> +	REG_S ra, PT_RA(sp)
>> +	REG_S s0, PT_S0(sp)
>> +	REG_S s1, PT_S1(sp)
>> +	REG_S s2, PT_S2(sp)
>> +	REG_S s3, PT_S3(sp)
>> +	REG_S s4, PT_S4(sp)
>> +	REG_S s5, PT_S5(sp)
>> +	REG_S s6, PT_S6(sp)
>> +	REG_S s7, PT_S7(sp)
>> +	REG_S s8, PT_S8(sp)
>> +	REG_S s9, PT_S9(sp)
>> +	REG_S s10, PT_S10(sp)
>> +	REG_S s11, PT_S11(sp)
>> +	REG_S tp, PT_TP(sp)
>> +	REG_S t0, PT_T0(sp)
>> +	REG_S t1, PT_T1(sp)
>> +	REG_S t2, PT_T2(sp)
>> +	REG_S t3, PT_T3(sp)
>> +	REG_S t4, PT_T4(sp)
>> +	REG_S t5, PT_T5(sp)
>> +	REG_S t6, PT_T6(sp)
>> +	REG_S gp, PT_GP(sp)
>> +	REG_S a0, PT_A0(sp)
>> +	REG_S a1, PT_A1(sp)
>> +	REG_S a2, PT_A2(sp)
>> +	REG_S a3, PT_A3(sp)
>> +	REG_S a4, PT_A4(sp)
>> +	REG_S a5, PT_A5(sp)
>> +
>> +	/* Retrieve entry sp */
>> +	REG_L a4, SSE_REG_EVT_TMP(a7)
>> +	/* Save CSRs */
>> +	csrr a0, CSR_EPC
>> +	csrr a1, CSR_SSTATUS
>> +	csrr a2, CSR_STVAL
>> +	csrr a3, CSR_SCAUSE
>> +
>> +	REG_S a0, PT_EPC(sp)
>> +	REG_S a1, PT_STATUS(sp)
>> +	REG_S a2, PT_BADADDR(sp)
>> +	REG_S a3, PT_CAUSE(sp)
>> +	REG_S a4, PT_SP(sp)
>> +
>> +	/* Disable user memory access and floating/vector computing */
>> +	li t0, SR_SUM | SR_FS_VS
>> +	csrc CSR_STATUS, t0
>> +
>> +	load_global_pointer
>> +	scs_load_sse_stack a7
>> +
>> +#ifdef CONFIG_SMP
>> +	REG_L t4, SSE_REG_HART_ID(a7)
>> +	lw t3, SSE_REG_CPU_ID(a7)
>> +
>> +	bne t4, a6, .Lfind_hart_id_slowpath
>> +
>> +.Lcpu_id_found:
>> +#else
>> +	mv t3, zero
>> +#endif
>> +
>> +	asm_per_cpu_with_cpu t2 __sbi_sse_entry_task t1 t3
>> +	REG_L tp, 0(t2)
>> +	bnez tp, .Lcurrent_task_found
>> +
>> +	/* __switch_to() marks its transition window with a NULL entry task. *=
/
>> +	REG_L tp, PT_TP(sp)
>> +
>> +.Lcurrent_task_found:
>> +	/* Nested exceptions temporarily replace these with the SSE stack. */
>> +	REG_L s6, TASK_TI_KERNEL_SP(tp)
>> +	REG_L s7, TASK_TI_USER_SP(tp)
>
> Only KERNEL_SP and USER_SP are preserved. handle_exception's new_valid_ma=
p_cpus_check macro
> parks a0/a1/a2 in TASK_TI_A0/A1/A2(tp) and reloads them a few instruction=
s later, for any
> page fault on a kernel address on 64-bit MMU. If an SSE arrives inside th=
at window and the
> handler takes a vmalloc/kfence fault of its own, the nested handle_except=
ion runs the same
> macro on the same tp and overwrites those three slots. When the SSE compl=
etes, the interrupted
> macro reloads a0/a1/a2 with the handler's values and they end up in the s=
aved context,
> i.e. a corrupted syscall argument / user a0-a2. The window is small, but =
"nested exceptions
> are transparent" is then false. Please save and restore those three slots=
 the same way as
> s6/s7.

Good catch! I independently noticed this omission as well and have added
save/restore of TASK_TI_A0/A1/A2 in my local v11 tree, using s8=E2=80=93s10=
,
which are already saved in the SSE register frame.
>
> I am wondering if this is the reason for the "repeated nested faults corr=
upt the interrupted context"
> that your 6/9 patch refers to;

It could explain context corruption in that window, but I cannot yet
confirm that it caused the earlier crashes. I'm still testing this and
will avoid attributing those failures to this omission without further
evidence. The fix belongs in the SSE entry code, as you pointed out.

> if so it should be fixed here, not worked around in perf. Check if its
> indeed true.
>

Sure, as mentioned in the resend cover letter, the perf GUP approach was
an interim workaround. v11 will replace it with an x86 way:
pagefault-disabled inatomic copy using exception-table fixup.

>> +
>> +	mv a1, sp /* pt_regs on stack */
>> +
>> +	/*
>> +	 * Run the SSE handler with the normal exception vector, but restore t=
he
>> +	 * interrupted stvec before completing the event. SSE can arrive while
>> +	 * the kernel is using a temporary trap vector in a sensitive entry pa=
th.
>> +	 */
>> +	csrr s3, CSR_STVEC
>> +	la t0, handle_exception
>> +	csrw CSR_STVEC, t0
>> +
>> +	/*
>> +	 * Preserve the full HS-mode virtualization state across the handler.
>> +	 * hstatus is live supervisor state rather than an SSE interrupted
>> +	 * attribute, and OpenSBI consumes hstatus.SPV during event completion=
.
>> +	 * Saving the whole CSR keeps the handler episode transparent to KVM a=
nd
>> +	 * avoids having to infer which hstatus bits may matter to a guest res=
ume.
>> +	 */
>> +	li s5, 0
>> +	ALTERNATIVE("nop", "csrr s5, hstatus", 0, RISCV_ISA_EXT_H, 1)
>> +
>> +	/*
>> +	 * Save sscratch for restoration since we might have interrupted the
>> +	 * kernel in early exception path and thus, we don't know the content =
of
>> +	 * sscratch.
>> +	 */
>> +	csrrw s4, CSR_SSCRATCH, x0
>> +
>> +	mv a0, a7
>> +	mv a2, s5
>> +
>> +	call do_sse
>> +
>> +	/* Leave no reference to the event stack in the interrupted task. */
>> +	REG_S s7, TASK_TI_USER_SP(tp)
>> +	REG_S s6, TASK_TI_KERNEL_SP(tp)
>> +
>> +	csrw CSR_SSCRATCH, s4
>> +	ALTERNATIVE("nop", "csrw hstatus, s5", 0, RISCV_ISA_EXT_H, 1)
>> +	csrw CSR_STVEC, s3
>> +
>> +	REG_L a0, PT_STATUS(sp)
>> +	REG_L a1, PT_EPC(sp)
>> +	REG_L a2, PT_BADADDR(sp)
>> +	REG_L a3, PT_CAUSE(sp)
>> +	csrw CSR_SSTATUS, a0
>> +	csrw CSR_EPC, a1
>> +	csrw CSR_STVAL, a2
>> +	csrw CSR_SCAUSE, a3
>> +
>> +	REG_L ra, PT_RA(sp)
>> +	REG_L s0, PT_S0(sp)
>> +	REG_L s1, PT_S1(sp)
>> +	REG_L s2, PT_S2(sp)
>> +	REG_L s3, PT_S3(sp)
>> +	REG_L s4, PT_S4(sp)
>> +	REG_L s5, PT_S5(sp)
>> +	REG_L s6, PT_S6(sp)
>> +	REG_L s7, PT_S7(sp)
>> +	REG_L s8, PT_S8(sp)
>> +	REG_L s9, PT_S9(sp)
>> +	REG_L s10, PT_S10(sp)
>> +	REG_L s11, PT_S11(sp)
>> +	REG_L tp, PT_TP(sp)
>> +	REG_L t0, PT_T0(sp)
>> +	REG_L t1, PT_T1(sp)
>> +	REG_L t2, PT_T2(sp)
>> +	REG_L t3, PT_T3(sp)
>> +	REG_L t4, PT_T4(sp)
>> +	REG_L t5, PT_T5(sp)
>> +	REG_L t6, PT_T6(sp)
>> +	REG_L gp, PT_GP(sp)
>> +	REG_L a0, PT_A0(sp)
>> +	REG_L a1, PT_A1(sp)
>> +	REG_L a2, PT_A2(sp)
>> +	REG_L a3, PT_A3(sp)
>> +	REG_L a4, PT_A4(sp)
>> +	REG_L a5, PT_A5(sp)
>> +
>> +	REG_L sp, PT_SP(sp)
>> +
>> +	li a7, SBI_EXT_SSE
>> +	li a6, SBI_SSE_EVENT_COMPLETE
>> +	ecall
>> +
>> +	/*
>> +	 * COMPLETE must resume the interrupted context and never return. Trap
>> +	 * through the normal vector instead of falling into adjacent assembly=
.
>> +	 */
>> +	la t0, handle_exception
>> +	csrw CSR_STVEC, t0
>> +	ebreak
>> +	/* The fatal trap must not return; execution should never reach here. =
*/
>> +
>> +#ifdef CONFIG_SMP
>> +.Lfind_hart_id_slowpath:
>> +
>> +	/* Restore current task struct from __sbi_sse_entry_task */
>> +	li t1, ASM_NR_CPUS
>> +	/* Slowpath to find the CPU id associated to the hart id */
>> +	la t0, __cpuid_to_hartid_map
>> +	li t3, 0
>> +
>> +.Lhart_id_loop:
>> +	REG_L t2, 0(t0)
>> +	beq t2, a6, .Lcpu_id_found
>> +
>> +	/* Increment pointer and CPU number */
>> +	addi t3, t3, 1
>> +	addi t0, t0, RISCV_SZPTR
>> +	bltu t3, t1, .Lhart_id_loop
>> +
>> +	/*
>> +	 * This should never happen since we expect the hart_id to match one
>> +	 * of our CPU, but better be safe than sorry
>> +	 */
>> +	la tp, init_task
>> +	la a0, sse_hart_id_panic_string
>> +	la t0, panic
>> +	jalr t0
>> +#endif
>> +
>> +SYM_CODE_END(handle_sse)
>> +ASM_NOKPROBE(handle_sse)
>> +
>> +SYM_DATA_START_LOCAL(sse_hart_id_panic_string)
>> +    .ascii "Unable to match hart_id with cpu\0"
>> +SYM_DATA_END(sse_hart_id_panic_string)
>> --
>> 2.50.1 (Apple Git-155)
>>

Thanks again for your detailed review!

Regards,
Zhanpeng
