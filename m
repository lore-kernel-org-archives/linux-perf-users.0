Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A702144D7
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Jun 2025 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749119607; cv=none; b=UycAM9wy8OCNdxAdcrMedX179wVQOYdZwkx2kPZois6Y3gPPngd4LuO/zmTv2SLlZz/iTIjld63u2KFL+8nvRDKy+/ifC2tZLuaJKCh55CKlxFa+SgUgXmNbAmlGE+oVFexp4CsaSVJXaJn6fhw2/FtjnQ84AatloZHqC1aVuUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749119607; c=relaxed/simple;
	bh=a22MTugVqXJqn2rVeTYu08Ru3J9spYEy5/2EYGhxPUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g4ziBbiT5J7QsrKbvfEbXiyj3Zmgb/uJCdg79rp+zquHfxG2W9ZhpgDXYQHZlTkD9TfpeVSVzWQ8L0l2BfUp6hsya/KeGxpEBtAmXxheJ0RbXVqOyPbn81GbB/XGNDxgH8/YC671rLlZM7xBFijPUmJ31Je2wWNlwq33ezdJ/2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rg9LwBi9; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rg9LwBi9"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so8617885e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Jun 2025 03:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749119603; x=1749724403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CcvdK+kUqsSYXK1dvlLkx29YE1Y4FdRzYsL+M29q+YQ=;
        b=Rg9LwBi97TjfLJ/j2rkXiV7RqDLcR1pT1E7ovvAhi73iXulx7wbdfRPm5fDAJ3tPV6
         knOtXVMhwX+shg2RQ8vtmLnEjxG4lMjkGZLtzE+J/h3LhreFQdTXOivrOixT9clH6zIR
         pi4QM2e1eZwsykiVR/QYlD4AzkwCUvnSP55v0Cw9WcLRA0+OQYd62IpfskkvhxIH1GzN
         5l5EFuYcvMqIQKur+caIKOs/P+u1ohNuusOiXT0Ooa5mR/kRjKxOkwq6jO8yQPNZ/U+g
         a1SEd6LiyAViU9kMKzXBhHmffFK+55CWiB3EADYlb/5ZHwKGfjCBmmqJyHjayjPBDwet
         oDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749119603; x=1749724403;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CcvdK+kUqsSYXK1dvlLkx29YE1Y4FdRzYsL+M29q+YQ=;
        b=u5nsV5n3CBQzyt8HEZZ8BkcH6M7KDFk3cOvq4d1uK4QqNgI2yYuBqLS/mz0hgS09Ac
         n3wZZG0Tu2itKNNKF5g4BPohUT+Nhw2zzPZ+0P8vrQ/cLA2O0vhVgbhmUKiPIDs4Be/z
         jIhSVTwMEXzVyUNs0YD941/wSw0Trm1l8NrM73hy+QjaSMs1P1rOilP2Gu7EN5naxeI+
         x6Ve3BIvpr3rI+XcUjr0mMljLNgIEBKpfbjJ31dojsB/NuUfhqUUo1+d/SXW8nQO5Vpb
         KObaWfEaFoejZzhohY+Os7AwEtdpVNG9O1H2ZhgTpZtOvCh8uTcUVH8Jyi5dxtZwF3+7
         yqrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZQfI5UoiIWClVwlhUSGKwnJOUpXXtg+NUqWp3XYCKHkqFnPosnx1Ocsd7hmuByFHgaae4D8iYClgh2gFqzCK8@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1y+dweb8WDXyGEFy38zYO4/iuoo35p08hsZElDmlEETa7hWla
	M97UCHe0GcUYPczCb2cIR6U7rY3nej7qih+rIXpFYY1zPRsnxlrmdnAnfjcM6HZdAMo=
X-Gm-Gg: ASbGncvy15RhoKuu0/g/rhZATKXxFMgmJ0RvpUmIgakgmKpE+/hwlM0uK/473teoL+w
	QMaHho9j2Gp8UxTZvFO1BqDenoggHCa5wOSfn/sXK+P7KC+gzOG8h7cAvi5GKdObBTWa4V1PCp6
	Ol2zQuVkBtKEMGl0xdCOLUAg4nCFuVrBa1QcRUUQF6ayTRpEw32rTVhIn3onna9FX9knbQfF+d/
	QKvEwpRTqsQ11wPFw607NtR6eE/w/4pGOarcmJLA7cGU5wi1zmdRzeH+s1AxG8CHRNa1hlrcaR2
	RKbdGieNmnOehde0tGzbJbpXOFaDHgFnVq3V6jb/1XNE3zjFW9T32LtP
X-Google-Smtp-Source: AGHT+IG/pYQASQpxqALpdTzyKn6tGv+QxqdbmbGFod1wFV2dwtYmyNkB99H/KuhQnFWYsX9U2WTL4A==
X-Received: by 2002:a05:600c:8112:b0:43d:1b95:6d0e with SMTP id 5b1f17b1804b1-451f0b3ce3fmr54377325e9.23.1749119603114;
        Thu, 05 Jun 2025 03:33:23 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe6ca08sm24967656f8f.33.2025.06.05.03.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 03:33:22 -0700 (PDT)
Message-ID: <632eadac-e5fd-4e50-9ced-cd4f2b9e6c82@linaro.org>
Date: Thu, 5 Jun 2025 11:33:21 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] KVM: arm64: Add trap configs for PMSDSFR_EL1
To: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
 kvmarm@lists.linux.dev
References: <20250529-james-perf-feat_spe_eft-v2-0-a01a9baad06a@linaro.org>
 <20250529-james-perf-feat_spe_eft-v2-6-a01a9baad06a@linaro.org>
 <867c1ze4pg.wl-maz@kernel.org>
 <2fb1965b-bef9-4a8e-a1c7-c8a77d957b23@linaro.org>
 <87a56ned6r.wl-maz@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <87a56ned6r.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/06/2025 4:31 pm, Marc Zyngier wrote:
> On Tue, 03 Jun 2025 10:50:23 +0100,
> James Clark <james.clark@linaro.org> wrote:
>>
>>
>>
>> On 29/05/2025 5:56 pm, Marc Zyngier wrote:
>>> On Thu, 29 May 2025 12:30:27 +0100,
>>> James Clark <james.clark@linaro.org> wrote:
>>>>
>>>> SPE data source filtering (SPE_FEAT_FDS) adds a new register
>>>> PMSDSFR_EL1, add the trap configs for it.
>>>>
>>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>>> ---
>>>>    arch/arm64/kvm/emulate-nested.c | 1 +
>>>>    arch/arm64/kvm/sys_regs.c       | 1 +
>>>>    2 files changed, 2 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
>>>> index 0fcfcc0478f9..05d3e6b93ae9 100644
>>>> --- a/arch/arm64/kvm/emulate-nested.c
>>>> +++ b/arch/arm64/kvm/emulate-nested.c
>>>> @@ -1169,6 +1169,7 @@ static const struct encoding_to_trap_config encoding_to_cgt[] __initconst = {
>>>>    	SR_TRAP(SYS_PMSIRR_EL1,		CGT_MDCR_TPMS),
>>>>    	SR_TRAP(SYS_PMSLATFR_EL1,	CGT_MDCR_TPMS),
>>>>    	SR_TRAP(SYS_PMSNEVFR_EL1,	CGT_MDCR_TPMS),
>>>> +	SR_TRAP(SYS_PMSDSFR_EL1,	CGT_MDCR_TPMS),
>>>>    	SR_TRAP(SYS_TRFCR_EL1,		CGT_MDCR_TTRF),
>>>>    	SR_TRAP(SYS_TRBBASER_EL1,	CGT_MDCR_E2TB),
>>>>    	SR_TRAP(SYS_TRBLIMITR_EL1,	CGT_MDCR_E2TB),
>>>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>>>> index 5dde9285afc8..9f544ac7b5a6 100644
>>>> --- a/arch/arm64/kvm/sys_regs.c
>>>> +++ b/arch/arm64/kvm/sys_regs.c
>>>> @@ -2956,6 +2956,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>>>>    	{ SYS_DESC(SYS_PMBLIMITR_EL1), undef_access },
>>>>    	{ SYS_DESC(SYS_PMBPTR_EL1), undef_access },
>>>>    	{ SYS_DESC(SYS_PMBSR_EL1), undef_access },
>>>> +	{ SYS_DESC(SYS_PMSDSFR_EL1), undef_access },
>>>
>>> PMSDSFR_EL1 has an offset in the VNCR page (0x858), and must be
>>> described as such. This is equally true for a bunch of other
>>> SPE-related registers, so you might as well fix those while you're at
>>> it.
>>>
>>> Thanks,
>>>
>>> 	M.
>>>
>>
>> I got a bit stuck with what that would look like with registers that
>> are only undef in case there was something that I missed, but do I
>> just document the offsets?
>>
>> +++ b/arch/arm64/include/asm/vncr_mapping.h
>> @@ -87,6 +87,8 @@
>>   #define VNCR_PMSICR_EL1         0x838
>>   #define VNCR_PMSIRR_EL1         0x840
>>   #define VNCR_PMSLATFR_EL1       0x848
>> +#define VNCR_PMSNEVFR_EL1       0x850
>> +#define VNCR_PMSDSFR_EL1        0x858
>>
> 
> This should be enough.
> 

Thanks, I'll resend with these added.

>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -596,6 +596,16 @@ enum vcpu_sysreg {
>>          VNCR(ICH_HCR_EL2),
>>          VNCR(ICH_VMCR_EL2),
>>
>> +       /* SPE Registers */
>> +       VNCR(PMBLIMITR_EL1),
>> +       VNCR(PMBPTR_EL1),
>> +       VNCR(PMBSR_EL1),
>> +       VNCR(PMSCR_EL1),
>> +       VNCR(PMSEVFR_EL1),
>> +       VNCR(PMSICR_EL1),
>> +       VNCR(PMSIRR_EL1),
>> +       VNCR(PMSLATFR_EL1),
> 
> I don't see a point in having those until we actually have SPE support
> for guests, if ever, as these will potentially increase the size of
> the vcpu sysreg array for no good reason.
> 
>> And then sys_reg_descs[] remain as "{ SYS_DESC(SYS_PMBLIMITR_EL1),
>> undef_access }," rather than EL2_REG_VNCR() because we don't actually
>> want to change to bad_vncr_trap()?
> 
> This seem OK for now. We may want to refine this in the future though,
> as these registers cannot trap when NV is enabled. Yes, this is a bug
> in the architecture.
> 
>> There are some other parts about fine grained traps and res0 bits for
>> NV, but they all already look to be setup correctly. Except
>> HDFGRTR2_EL2.nPMSDSFR_EL1, but it's inverted, none of the FGT2 traps
>> are configured currently and PMSDSFR_EL1 is already trapped by
>> MDCR_EL2 anyway.
> 
> Can you elaborate on that? We have:
> 
> 	SR_FGT(SYS_PMSDSFR_EL1,		HDFGRTR2, nPMSDSFR_EL1, 0),
> 
> which seems to match the spec.
> 
> We also have full support for FEAT_FGT2 already (even if we have no
> support for the stuff they trap).

Oh I think that was misleading, the version I was poking around on 
didn't have the FEAT_FGT2 stuff applied yet but I see it now. And yes, 
as you say, what's there matches the spec.

> 
> Thanks,
> 
> 	M.
> 

