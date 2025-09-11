Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3DB35948
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Sep 2025 01:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757552530; cv=none; b=cGtoNAPQlVAelYTfWXTuAFzZMhtqpE6DU6YrvWYPL5oyaq2T1LaiRdBB59hJY797mI7QDjn3Imq3ff1ktgqyhaJDuCZkh1OikUTmDC4RdVpxBuko3txx6HSa6j6rviytLI9tvcXi4vsR44yFnwNEzjgfAIj4rXSYdVBIw05+uH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757552530; c=relaxed/simple;
	bh=5VBENt6A2Kmu9jGrmuhcVeNNjnb+1k9AjSplBpQiApo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bW7bgpJlUJWQgL1U/myKqd1jcEOcN/akL1ECOiSwEdPAj9Z/4yhQPEtyo0ExaAUZyc9RPtdtMI13hWHMJeNMEkU3PTI6ejxjnuJX7eHXLYmjbXyyPLqNSx/vTWMFBM3+Kny+GtIHlbGA7Vw7zTXjQrm3FTSUfw6WWUNjZr+CSc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlHfvm4/; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlHfvm4/"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e4f2e4c40so149066b3a.2
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Sep 2025 18:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757552528; x=1758157328; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c6RyKxrXBphbUIxCwH62JzKN1u04ZKF0pThPVVL+cJk=;
        b=AlHfvm4/1BbBv6RsZr79XTSPdZvbg0wNCU+iGFXaCMrjkor1QovGUftbE6fYELjsTw
         Ff8PVTuMAleN+WofHSO2JIEzJ8PAb67lMpHTKgF1sEvAimcwr7glpfAYxUiTumDjxAuo
         nA4xqIj6hJifw1zBoYodfrTZgBN1VQirCl6Fsq8nCfkrvnSZ2fS4GilWT4LZNsvDPPXN
         NyO9gNBa7fyAyX9F0jQDCplThw8mWw7yFafloPGrWpoG8zTvWPHG4oNwAgjtYSJNwjFr
         IbOiPsyaJgZKTPvQo3UctjfU4Nq2Q80a94IjE8rtUQZ9LddITgasqvROxv7/EFoF96tD
         246Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757552528; x=1758157328;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c6RyKxrXBphbUIxCwH62JzKN1u04ZKF0pThPVVL+cJk=;
        b=fLehO5e+mPzO17OWgozDmk725cY6bX9bCOJhs9bFtBN4orjSlHrqt45IpCcDwT5kyC
         Lhnrpofj33zEPbf9r5z6wcS1C5MyoUTb+Pse+07ef9gtfiQkfVGuece8W0ejVRPUf+9U
         y67Wkd5k+JAoT3Y+TkJHQZmV+5ZXKcugJR3elUPXp2DHrOeN2xXtsiW3wAv84kwenWMU
         uCGlI66Gdgih0b2jkIHQbW0n2HGrvMNxbaL2op+wNYwjgJpR7U0/pgh+qMObuQA0IJe+
         cnMJg4QHFbDUq1YcNe004mdy3VzsncG5Q23mEaGXDrPgW15yY9+xj05ftyR6MHtzdjyM
         lhjA==
X-Forwarded-Encrypted: i=1; AJvYcCX58T7KMX456eudtUGZS8o2xUJFIQSnp6BgxBNlukhmLTjHzL2xHD//0XFREkXIT6eeURFXaVp4HOoUnOOG3QIU@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn4J3Vedx1Gq5UdlcsYIKg4vHx+tYbkYsw9OudOTtxCNnFbBFt
	0FOzVcq4gYHSfPaQrBAFYIB1Ho2zB9ZjOypHhs4RYCHAeoFf3TCP9AWG
X-Gm-Gg: ASbGncupY48oNf1p/yDFfN+OkoN9EJ2U4m8leEPQf8hBpwTj4XbsxehIHTwJ4bDbDXL
	jaCIOnX5Eev3Ge+HEgoZpmPrjJiMTddDtortTsWImGnr3/bGfp6PKnCoZgMckAbyp2wgwJyEYrl
	7m4oi98dl1l6RKWE0YMDa7p2OWphDcuhOhj9vqKlcosdcN+bvqxGHgJQtghJKr9y0HRCG0RGDox
	0z3YOrp+CLeknVNgRqpy+Pm8kD8D99Gxd8u3ujuNs1pKJn6UJpV/1MJQZXI+X+S/HC7qv4Fko5P
	5rJ/L4WvW3P7VEbqCoYOQeE8l/MAXZmtmsUuSv6HxLhkhjnkApIfrTBFxiunyoH4SkSs+uw1QjM
	HG+ZVX5R4jwWfrfEYgWpUPGc+gts=
X-Google-Smtp-Source: AGHT+IHWKYeBfZHFw5wp0lGo2/j/+43qoXRd/Q4Cw1fK4Uyl50WB09aLvc51pAjyyTCeRnBJqpSTow==
X-Received: by 2002:a05:6a00:4652:b0:772:5ba4:d75 with SMTP id d2e1a72fcca58-7742dd1270emr21626263b3a.4.1757552527499;
        Wed, 10 Sep 2025 18:02:07 -0700 (PDT)
Received: from [127.0.0.1] ([2a11:3:200::20f3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b34254sm122807b3a.75.2025.09.10.18.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 18:02:06 -0700 (PDT)
Message-ID: <5ed43490-6894-4780-8faf-52d5f25bf3cc@gmail.com>
Date: Thu, 11 Sep 2025 09:01:49 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/19] x86/hw_breakpoint: introduce
 arch_reinstall_hw_breakpoint() for atomic context
Content-Language: en-US
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 "Naveen N . Rao" <naveen@kernel.org>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, kasan-dev@googlegroups.com,
 "David S. Miller" <davem@davemloft.net>, Steven Rostedt
 <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250910052335.1151048-1-wangjinchao600@gmail.com>
 <20250910052335.1151048-2-wangjinchao600@gmail.com>
 <20250911094609.5f30e9767ffc3040068ed052@kernel.org>
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <20250911094609.5f30e9767ffc3040068ed052@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/11/25 08:46, Masami Hiramatsu (Google) wrote:
> Hi Jinchao,
>
> On Wed, 10 Sep 2025 13:23:10 +0800
> Jinchao Wang <wangjinchao600@gmail.com> wrote:
>
>> Introduce arch_reinstall_hw_breakpoint() to update hardware breakpoint
>> parameters (address, length, type) without freeing and reallocating the
>> debug register slot.
>>
>> This allows atomic updates in contexts where memory allocation is not
>> permitted, such as kprobe handlers.
>>
>> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
>> ---
>>   arch/x86/include/asm/hw_breakpoint.h |  1 +
>>   arch/x86/kernel/hw_breakpoint.c      | 50 ++++++++++++++++++++++++++++
>>   2 files changed, 51 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
>> index 0bc931cd0698..bb7c70ad22fe 100644
>> --- a/arch/x86/include/asm/hw_breakpoint.h
>> +++ b/arch/x86/include/asm/hw_breakpoint.h
>> @@ -59,6 +59,7 @@ extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
>>   
>>   
>>   int arch_install_hw_breakpoint(struct perf_event *bp);
>> +int arch_reinstall_hw_breakpoint(struct perf_event *bp);
>>   void arch_uninstall_hw_breakpoint(struct perf_event *bp);
>>   void hw_breakpoint_pmu_read(struct perf_event *bp);
>>   void hw_breakpoint_pmu_unthrottle(struct perf_event *bp);
>> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
>> index b01644c949b2..89135229ed21 100644
>> --- a/arch/x86/kernel/hw_breakpoint.c
>> +++ b/arch/x86/kernel/hw_breakpoint.c
>> @@ -132,6 +132,56 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
>>   	return 0;
>>   }
>>   
>> +/*
>> + * Reinstall a hardware breakpoint on the current CPU.
>> + *
>> + * This function is used to re-establish a perf counter hardware breakpoint.
>> + * It finds the debug address register slot previously allocated for the
>> + * breakpoint and re-enables it by writing the address to the debug register
>> + * and setting the corresponding bits in the debug control register (DR7).
>> + *
>> + * It is expected that the breakpoint's event context lock is already held
>> + * and interrupts are disabled, ensuring atomicity and safety from other
>> + * event handlers.
>> + */
>> +int arch_reinstall_hw_breakpoint(struct perf_event *bp)
>> +{
>> +	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
>> +	unsigned long *dr7;
>> +	int i;
>> +
>> +	lockdep_assert_irqs_disabled();
>> +
>> +	for (i = 0; i < HBP_NUM; i++) {
>> +		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
>> +
>> +		if (*slot == bp)
>> +			break;
>> +	}
>> +
>> +	if (WARN_ONCE(i == HBP_NUM, "Can't find a matching breakpoint slot"))
>> +		return -EINVAL;
>> +
>> +	set_debugreg(info->address, i);
>> +	__this_cpu_write(cpu_debugreg[i], info->address);
>> +
>> +	dr7 = this_cpu_ptr(&cpu_dr7);
>> +	*dr7 |= encode_dr7(i, info->len, info->type);
>> +
>> +	/*
>> +	 * Ensure we first write cpu_dr7 before we set the DR7 register.
>> +	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
>> +	 */
>> +	barrier();
>> +
>> +	set_debugreg(*dr7, 7);
>> +	if (info->mask)
>> +		amd_set_dr_addr_mask(info->mask, i);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(arch_reinstall_hw_breakpoint);
> Please do not expose the arch dependent symbol. Instead, you should
> expose an arch independent wrapper.
>
> Anyway, you also need to share the same code with arch_install_hw_breakpoint()
> like below;
>
> Thanks,

You are right. The arch-dependent symbol has been removed and the code 
is shared

with arch_install_hw_breakpoint() in the next version of the patch.

https://lore.kernel.org/lkml/20250910093951.1330637-1-wangjinchao600@gmail.com


>
> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
> index 89135229ed21..2f3c5406999e 100644
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c
> @@ -84,6 +84,28 @@ int decode_dr7(unsigned long dr7, int bpnum, unsigned *len, unsigned *type)
>   	return (dr7 >> (bpnum * DR_ENABLE_SIZE)) & 0x3;
>   }
>   
> +static void __arch_install_hw_breakpoint(struct perf_event *bp, int regno)
> +{
> +	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> +	unsigned long *dr7;
> +
> +	set_debugreg(info->address, regno);
> +	__this_cpu_write(cpu_debugreg[i], info->address);
> +
> +	dr7 = this_cpu_ptr(&cpu_dr7);
> +	*dr7 |= encode_dr7(i, info->len, info->type);
> +
> +	/*
> +	 * Ensure we first write cpu_dr7 before we set the DR7 register.
> +	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
> +	 */
> +	barrier();
> +
> +	set_debugreg(*dr7, 7);
> +	if (info->mask)
> +		amd_set_dr_addr_mask(info->mask, i);
> +}
> +
>   /*
>    * Install a perf counter breakpoint.
>    *
> @@ -95,8 +117,6 @@ int decode_dr7(unsigned long dr7, int bpnum, unsigned *len, unsigned *type)
>    */
>   int arch_install_hw_breakpoint(struct perf_event *bp)
>   {
> -	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> -	unsigned long *dr7;
>   	int i;
>   
>   	lockdep_assert_irqs_disabled();
> @@ -113,22 +133,7 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
>   	if (WARN_ONCE(i == HBP_NUM, "Can't find any breakpoint slot"))
>   		return -EBUSY;
>   
> -	set_debugreg(info->address, i);
> -	__this_cpu_write(cpu_debugreg[i], info->address);
> -
> -	dr7 = this_cpu_ptr(&cpu_dr7);
> -	*dr7 |= encode_dr7(i, info->len, info->type);
> -
> -	/*
> -	 * Ensure we first write cpu_dr7 before we set the DR7 register.
> -	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
> -	 */
> -	barrier();
> -
> -	set_debugreg(*dr7, 7);
> -	if (info->mask)
> -		amd_set_dr_addr_mask(info->mask, i);
> -
> +	__arch_install_hw_breakpoint(bp, i);
>   	return 0;
>   }
>   
> @@ -146,8 +151,6 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
>    */
>   int arch_reinstall_hw_breakpoint(struct perf_event *bp)
>   {
> -	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> -	unsigned long *dr7;
>   	int i;
>   
>   	lockdep_assert_irqs_disabled();
> @@ -162,22 +165,7 @@ int arch_reinstall_hw_breakpoint(struct perf_event *bp)
>   	if (WARN_ONCE(i == HBP_NUM, "Can't find a matching breakpoint slot"))
>   		return -EINVAL;
>   
> -	set_debugreg(info->address, i);
> -	__this_cpu_write(cpu_debugreg[i], info->address);
> -
> -	dr7 = this_cpu_ptr(&cpu_dr7);
> -	*dr7 |= encode_dr7(i, info->len, info->type);
> -
> -	/*
> -	 * Ensure we first write cpu_dr7 before we set the DR7 register.
> -	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
> -	 */
> -	barrier();
> -
> -	set_debugreg(*dr7, 7);
> -	if (info->mask)
> -		amd_set_dr_addr_mask(info->mask, i);
> -
> +	__arch_install_hw_breakpoint(bp, i);
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(arch_reinstall_hw_breakpoint);
>
-- 
Thanks,
Jinchao

