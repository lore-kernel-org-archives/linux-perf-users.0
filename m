Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793285186;
	b=GKE5QA7Uc6uRqXY2K+R7puqiLglmlAvjqKu0eC6YvcZB6tiSVsbd/TxX5CvHR/82TzFJ
	 ROGf7DLeRTdrV/uxQI17G4dFJpjAh8r9v/dcmpIFiCrr8eB3JhTpRa4KgsQDRfqK6cXgm
	 Wqr4jtsxZ2t2EjCsCUtS39jyL7e/INlA8R1Ja10tiemjALzl0CwOAdr/MMoBWZwpSTs6x
	 zw2yA676OFr1fqMf2yXqNELP49Gx5eBRjS5bp6ItCrpP8dMHm01Mci+rqZKpQCYvaw1P6
	 IeOSCmCYc0GPOkqS8OiE2ej6xLskzdf9nPxCMauYQSnawJ5dMRf5y2Y/q7Z+1m/Uw3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285186;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:In-Reply-To:User-Agent:From:References:X-Original-From:
	 Mime-Version:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=h2unH/KWXHOOKEcsRl7AiS4RPP1kGzJaZEEy3NWnszY=;
	b=ZWbxa6fZL1UTsZihyuOqBiE+3BdfDzC3QDTk46tmIV7A3iEBWuhOw8TDu2M+n7xWl7l0
	 YWhXXW2CCNrRMIpkqe/PWvsz9TitypyDIEs6X86417jsUuJgIv4eOxSUHEtorNOUhTTc8
	 y7OPArhOZnFRsXUoaPpxuiF2EjJJiyMeOWSIvYgSBQXDHz1rFWH3Lig+JjN5VrxALIZWB
	 B2Tv2LSBWt6QHMTk0nV49LuiJOnSYZYv0lJiIhebxJteGlySbs7G3sVui6WbOsFNHD5CC
	 GCPdvqFBTYsZgVswi5QMuuh+YCMqiK9JcMScHN5zE0xFjxZTwIdLlxjFifWwlnALG5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=dQat6ono;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.48
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0621606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 14:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0621606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=dQat6ono
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5bfc346401aso1552252e87.0
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 07:46:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793285184; cv=none;
        d=google.com; s=arc-20260327;
        b=DAy71XTRUQq4ppgMfp0J6SQiPjBGhMt6GKB0rGqP05mwUMidefX6nBdHS12A9jQuqC
         aDhETnocAQ0d540PlGj2h9VR+rfxTujzU0fGwjMjBUdVvKj/qrrL1wZ+aX0ZvBlGJing
         btbrT3eyvd/oJvOoTB0TnO6AEU2FJ+DdDz6Jlt+pI7DP8866QxqdnU2V2Dn4JhYyAvzG
         Iag43/EGbCcZMEmu8+0pqmpIQiXWSiu5m1cfJ6CLOC9QDySR2azLUbmMe5GyPNhdJ0dV
         MrphySW8s4N8hT55EZL379/lX8nSkkRHGfo59c7uIydCMpJgNektwk3Q1mYKk6MDV3u/
         TR6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:from:user-agent:in-reply-to:dkim-signature;
        bh=h2unH/KWXHOOKEcsRl7AiS4RPP1kGzJaZEEy3NWnszY=;
        fh=5xqvgiMG5QGslDz3ahtfox7BCUxpyp9KW5JnLSXDDOA=;
        b=UxeSmwzJTsx5gV+SacHLEKavxbYM1G46Js6X46dmd95f+wmKYNua1GypfupFfaPxXj
         CTEG/QjFzdTF8PmdYwAvA9a15Hqz2pNdyE4LjZLY8z8pllwtCqlcl7qGhh5sWqqLaQ6D
         JjGqA1rHgYWIoG6Is8gmgvIThesXRrBzT9WNHNtCYI+7SsoqLIJZmhy89GDVWl/+bL25
         peHaxHysOgwfOIuHyRD8hsXHXXaEeWCPNPNczPhii9GJ6NlNfdJYw/E8yYKrzLsCDd/m
         tbtIn36+5hi6/3dmrgWVNM6CF07QwYFQd0qFwi7O6hyGwYSbqQSmyDNu1YhyyZSZXOQt
         qrUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793285184; x=1793889984; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:from:user-agent:in-reply-to:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h2unH/KWXHOOKEcsRl7AiS4RPP1kGzJaZEEy3NWnszY=;
        b=dQat6onoWTNZ8G11vfnas91jE7qHYesxdxZ8lEnhtKMnXWQDdK/6HGs4mQmEK+DUSn
         DSOrCfzH81SGqvNrDIS4vS4exXIlL5DnLh9dEN2pYIm/1SxAG9o9RFX7QaCA/xScLtM3
         3KyfzZZpTy+1isaZDiIezANylB5eraZfliKVFssR21Kdc1/uSgRrlTGT4geNJTCFKpuM
         8XrjPW/5BmtQxiPcrVEatHBpgakVCxvGzxGqpruhMBsohV5ZeHbwAaqziUoNuz3c7/ai
         1fpowm1oIQF9mobL2U7KwvXUzRn07HlG6b2P31xbnLkv+vciY6xrXDw/lnnF0lf0bVgw
         Wizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793285184; x=1793889984;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:from:user-agent:in-reply-to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h2unH/KWXHOOKEcsRl7AiS4RPP1kGzJaZEEy3NWnszY=;
        b=1c27X85hiSOQa+7/zTch40AEhldfu4p0rujQ8sP0Re6SK6KNfU4FU9q/OaXg+FPzeL
         jsP9fmmOkwr7YN8lVyy0lxOO9RyU4xelH+v/EtBF7oGgzm/ZrRtsoc/1j+DSsDun3VJJ
         IubPiIlfpSz4IWJ4dcbi6qmSH8QsNrqx+y3yjvD5jP7qqfO60sNILCHCz2fg7+YvticW
         Xh2bJ8slMMOQQVRICIbOGgObRyTtYoXmsrB0LZGyRWDikFJGtrWTAcB1rXtXDyUzz3N8
         jKg4JTqzWwcxReOfgWVmixksugmgggoQkdVLgdsbFbnJbngTO4ob78UCH2F3zqXcca5Y
         HdoA==
X-Forwarded-Encrypted: i=1; AKwUvBwDU4SMdPhVbIO9t/hWwmqu+V0OazjXsUStH6rirMa20tpHllOMYfbSGLg2PrGcFrflvcLgT6IXMIl3VOHt9ILg@vger.kernel.org
X-Gm-Message-State: AFq9FYIa4ZuTgqhhicchiy6irSSRMprkiwOROsUcSRthsUFhku5p62I1
	5iBBa6yg2BXlbALPGkJ4ozBBTTE6Z7DyMT4PdP/M9+y7P/sTjGFlF9EdA/99P/0xe/0qHbn0n0x
	9+DhrIskMwjO1eQPaAyiVlpd0xISAkmeF63bfs4GFgQ==
X-Gm-Gg: AYBFou1UWuC8GPLF9XTYjBrZVH+FeNWcu7J8SzqOP/ERCG8bNofVbz0WOT+MY3sk6Pw
	NMyG253MhSRiLdhsXzNYUiG1iNVRA9JPtXTj2PKH/D8SGZMO6MSLwd2it1O+XvqzIe/fGxDjap0
	KyXJw5GC/cXfx4ymZazxtD2Vn7aC/XKcSyMf/N5tD8c6zQiefiDmHJQjZH/14u1QEH8c4oWpQa6
	/j9UcPvRZFlXQB1pfN7I6zEi9mOn1LnUoznB1RY/2vsRIo4BGq/KnM+gh0fbhxVSN0jtQv5+kD2
	+nnBe8M5AZCRcgyyfnAIMsF7M7NJw+BTwT5izHB2x6hZQVnzEXLUdCv+gGHPF6owIky+nwFein7
	DjPqFPe4u4Jp2hxQtj5LPBY2A41xU0bAeOLMZ
X-Received: by 2002:a05:6512:39d1:b0:5be:5394:162d with SMTP id
 2adb3069b0e04-5bfcad0187bmr2218416e87.3.1793285183781; Thu, 29 Oct 2026
 07:46:23 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 29 Oct 2026 07:46:22 -0700
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 29 Oct 2026 07:46:22 -0700
In-Reply-To: <auNOqR9xm3XMJcFN@hu-himchau-blr.qualcomm.com>
User-Agent: Mozilla Thunderbird
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
References: <20261029074853.35467-1-zhangzhanpeng.jasper@bytedance.com>
 <20261029074853.35467-3-zhangzhanpeng.jasper@bytedance.com> <auNOqR9xm3XMJcFN@hu-himchau-blr.qualcomm.com>
X-Original-From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Date: Thu, 29 Oct 2026 07:46:22 -0700
X-Gm-Features: AclHuK-zJlvKOh1yAp6a7dQAN71cSzK9kF4Z01Nrh3d3tl8aCmmywHrd8FEXpMA
Message-ID: <CACnXVnc6QgXfGjNWHGD_5_zNH9hjZ-Fartj8ZCwmtHDV4zt7cA@mail.gmail.com>
Subject: Re: [PATCH v12 02/11] riscv: add support for SBI Supervisor Software
 Events extension
To: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor@kernel.org>, 
	Anup Patel <anup.patel@oss.qualcomm.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Yunhui Cui <cuiyunhui@bytedance.com>, Atish Patra <atish.patra@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
	Shuah Khan <shuah@kernel.org>, yuanzhu@bytedance.com, yang.yicong@picoheart.com, 
	yang.susheng@zte.com.cn, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 10/29/26 9:48 PM, Himanshu Chauhan wrote:
> Hi,
>
> On Thu, Oct 29, 2026 at 03:48:44PM +0800, Zhanpeng Zhang wrote:
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
>> On RV64 with an MMU, early trap entry also uses thread_info.a0/a1/a2
>> as scratch slots before saving the full register frame. An SSE handler
>> can interrupt that window and take a nested fault which overwrites the
>> same slots. Preserve them in already-saved callee-saved registers and
>> restore them before resuming the interrupted entry path.
>>
>> Disable preemption while initializing the per-CPU entry-task slot.
>> CPU hotplug callbacks run in a preemptible thread, and this write
>> happens before the guards around the local SBI operations.
>>
>> Compile the stack TLB helper only for VMAP_STACK or SHADOW_CALL_STACK,
>> its only users, to avoid an unused-function warning in other builds.
>>
>> Keep an explicit EVENT_REGISTER not-supported result distinct from other
>> firmware failures. This lets clients select another delivery mechanism
>> only when firmware has positively rejected the requested event.
>>
>> Link: https://lore.kernel.org/r/as79MHtNYd-VbUug@hu-himchau-blr.qualcomm=
.com/
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202610020009.P3ILnDi1-lkp@=
intel.com/
>> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
>> Co-developed-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
>> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
>> Co-developed-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
>> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
>> ---
>>   arch/riscv/include/asm/asm.h         |  14 +-
>>   arch/riscv/include/asm/scs.h         |   7 +
>>   arch/riscv/include/asm/sse.h         |  82 +++++++++
>>   arch/riscv/include/asm/thread_info.h |   1 +
>>   arch/riscv/kernel/Makefile           |   1 +
>>   arch/riscv/kernel/asm-offsets.c      |  14 ++
>>   arch/riscv/kernel/entry.S            |  14 ++
>>   arch/riscv/kernel/sbi_sse.c          | 251 +++++++++++++++++++++++++++
>>   arch/riscv/kernel/sbi_sse_entry.S    | 237 +++++++++++++++++++++++++
>>   9 files changed, 618 insertions(+), 3 deletions(-)
>>   create mode 100644 arch/riscv/include/asm/sse.h
>>   create mode 100644 arch/riscv/kernel/sbi_sse.c
>>   create mode 100644 arch/riscv/kernel/sbi_sse_entry.S
>>
>> diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
>> index b8bf842d4c1..e1196caea02 100644
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
>> index 023a412fe38..0d70a35bc01 100644
>> --- a/arch/riscv/include/asm/scs.h
>> +++ b/arch/riscv/include/asm/scs.h
>
> This patch doesn't apply on v7.3-rc7. Did you rebase on it?
> b4 shazam failed at this patch in scs.h file.
>
> Please check.
>
> Regards
> Himanshu
>

V12 uses a5ae1bf65cee, the same base as Anup's v11 and still the current
riscv/for-next tip, as Paul requested.

rc7 has an additional scs.h change that causes this conflict. Could you
please apply the series on a5ae1bf65cee instead?

>> [...]
Thanks,
Zhanpeng
