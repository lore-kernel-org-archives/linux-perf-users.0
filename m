Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25905278767
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Jun 2025 18:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750703141; cv=none; b=QPQoKgswgVGuE4uuKaFyy2FkkLwHFy5ukVc/+7BEA6/Fxv4dgp+oOfOg14nj6/QGn30aolUC+p9WprVJAQWRS99Nf16FvjT02xKBryugBxFX+mhyg97WGzQWcPA6T9XCFPkdQZCg9xV9bnD6XijxvKiREUjnthrM0BvWVMmpyDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750703141; c=relaxed/simple;
	bh=2JKqhfr5wu8jd5BKk3NpO7rpJrVsAeJ0qnUtDbuCOi4=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Lx/FKm+y4EAQ1RJFIMDa4cQbEkRCCBpA35sair+9D4qzU6iXmMygmEaJ2kfvLA68V36pkHxnvDtzZLkVrRKeKAUM8NuUu/8ZmWXSfqt4y5Ju8xrYu5Mo891LnRVY9Ah8PDafWxaegnY+f0y31ZHIukYEmp2nYhrPPiTGlwJUfsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M/Vy+IGk; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M/Vy+IGk"
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3ddd02c8bffso80768405ab.3
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Jun 2025 11:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750703139; x=1751307939; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x/yRTajGyCYDVao/uBe3yoYTQK0CCPZeD6lCEoWPGDQ=;
        b=M/Vy+IGkrwrnN27cG6bMS6xRuUM2zr9GfJj9EkwEkSVYvypD0v5XbaAkF/lN3Lc5+g
         vKn1b4Z/n8SaPuK2ZEkZU52cNoIS/Eg4Xq1ReqJDwgeBlW3O6IZhMFmSfNZLiikaoDEJ
         36rvZLJkFBl8H4UUJJTOsSpmiphtii+aZOJaRbSYE7YTEDaaCz1/ssr8v1LDaBN35aRi
         u1JhQ0NW8943ysLWJhgywiLiheGj8llLQUH+IqqIvlb+ginpZOzEaZw7os+wfx6m/POc
         hHv+TiVenoH9Px8HEf1fi7qrPYHFbuCKjwGxx4IymY4a35JtMUFQwQtu0TtIixters6W
         o3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750703139; x=1751307939;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x/yRTajGyCYDVao/uBe3yoYTQK0CCPZeD6lCEoWPGDQ=;
        b=DwFhcWY3eVe668nnfvwIoqQPxRtMAdS5vqwfQ+SF7WanGUTKMVU22ODppwtNSvqXIX
         /cYfSAZw8WPTgT5ttwkSxCANyutBaBp8BD3z7dbXXfepdw0sN+bugD4QDldtYBZ4oW1v
         sNcx05JG9hJEtYyRr4tXx8bXpxXHvUQV0qV9Yo6fUJYWkjGWD7Z+eHe83Rr7W22FGFP+
         tr0HTx2nWct8Mk3VN59AI0h2wUcXE4oYwaCv2JDfGcajJuU7zIUfzWtMUFixzDV8P8+h
         eLvUuo8j6ZTNwpzkIQItSsEzkMRlvZ9hRLC+KLm30bg1FTsAbnY33cPCgWL2XcshcyD1
         y4pA==
X-Forwarded-Encrypted: i=1; AJvYcCVWZ9yCI9XuTycJSRzN022WpY6Eau+3RmimxnoKC9qD9IbjkwlKswp3F/ql4NpvKMtRAeEvy0DaRu7XbKOX8Bm7@vger.kernel.org
X-Gm-Message-State: AOJu0YyK70GZbGQB2L3QYH0a8aApAa4SgO0Rd6O/YnETsJBlszur/czJ
	bsDEnSyM3PsESPebWHKRnTzW5/86bnSya3+6+rmE5TyXuvp9rCU1qFDJbljDkdoqsqnNKeuWZdN
	nEvEMpV8V2tv4Q77ZiSGuJ0Aa/A==
X-Google-Smtp-Source: AGHT+IGB4/D8wn12ZeTFWeXtrV3NuVvtA1SOelvWAjyyu6UmZAX76nv7r6P9O4AsImXh2Otv+muKbiEPiY/O85sZZA==
X-Received: from ilbbr10.prod.google.com ([2002:a05:6e02:23ca:b0:3dd:7629:ec3a])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:170d:b0:3dd:e7d6:18bb with SMTP id e9e14a558f8ab-3de38cbfd28mr144801735ab.17.1750703139323;
 Mon, 23 Jun 2025 11:25:39 -0700 (PDT)
Date: Mon, 23 Jun 2025 18:25:38 +0000
In-Reply-To: <aFYAXjzICzgmSyLI@linux.dev> (message from Oliver Upton on Fri,
 20 Jun 2025 17:44:14 -0700)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntqzza9uxp.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v2 01/23] arm64: cpufeature: Add cpucap for HPMN0
From: Colton Lewis <coltonlewis@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	maz@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, mark.rutland@arm.com, shuah@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Oliver Upton <oliver.upton@linux.dev> writes:

> On Fri, Jun 20, 2025 at 10:13:01PM +0000, Colton Lewis wrote:
>> Add a capability for FEAT_HPMN0, whether MDCR_EL2.HPMN can specify 0
>> counters reserved for the guest.

>> This required changing HPMN0 to an UnsignedEnum in tools/sysreg
>> because otherwise not all the appropriate macros are generated to add
>> it to arm64_cpu_capabilities_arm64_features.

>> Signed-off-by: Colton Lewis <coltonlewis@google.com>
>> ---
>>   arch/arm64/kernel/cpufeature.c | 8 ++++++++
>>   arch/arm64/tools/cpucaps       | 1 +
>>   arch/arm64/tools/sysreg        | 6 +++---
>>   3 files changed, 12 insertions(+), 3 deletions(-)

>> diff --git a/arch/arm64/kernel/cpufeature.c  
>> b/arch/arm64/kernel/cpufeature.c
>> index b34044e20128..278294fdc97d 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -548,6 +548,7 @@ static const struct arm64_ftr_bits ftr_id_mmfr0[] = {
>>   };

>>   static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
>> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE,  
>> ID_AA64DFR0_EL1_HPMN0_SHIFT, 4, 0),
>>   	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE,  
>> ID_AA64DFR0_EL1_DoubleLock_SHIFT, 4, 0),
>>   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE,  
>> ID_AA64DFR0_EL1_PMSVer_SHIFT, 4, 0),
>>   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE,  
>> ID_AA64DFR0_EL1_CTX_CMPs_SHIFT, 4, 0),
>> @@ -2896,6 +2897,13 @@ static const struct arm64_cpu_capabilities  
>> arm64_features[] = {
>>   		.matches = has_cpuid_feature,
>>   		ARM64_CPUID_FIELDS(ID_AA64MMFR0_EL1, FGT, FGT2)
>>   	},
>> +	{
>> +		.desc = "Allow MDCR_EL2.HPMN = 0",

> This feedback still stands...

> 		.desc = "HPMN0",

> [*] https://lore.kernel.org/kvm/aD4ijUaSGm9b2g5H@linux.dev/

Sorry for ignoring your previous feedback. I looked at the other .desc
fields and they had more descriptive English, so I think this one should
be more than "FEAT_HPMN0" for consistency.

If you insist I'll change it.

>> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
>> +		.capability = ARM64_HAS_HPMN0,
>> +		.matches = has_cpuid_feature,
>> +		ARM64_CPUID_FIELDS(ID_AA64DFR0_EL1, HPMN0, IMP)
>> +	},
>>   #ifdef CONFIG_ARM64_SME
>>   	{
>>   		.desc = "Scalable Matrix Extension",

Here's one example.

>> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
>> index 10effd4cff6b..5b196ba21629 100644
>> --- a/arch/arm64/tools/cpucaps
>> +++ b/arch/arm64/tools/cpucaps
>> @@ -39,6 +39,7 @@ HAS_GIC_CPUIF_SYSREGS
>>   HAS_GIC_PRIO_MASKING
>>   HAS_GIC_PRIO_RELAXED_SYNC
>>   HAS_HCR_NV1
>> +HAS_HPMN0
>>   HAS_HCX
>>   HAS_LDAPR
>>   HAS_LPA2
>> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
>> index 8a8cf6874298..d29742481754 100644
>> --- a/arch/arm64/tools/sysreg
>> +++ b/arch/arm64/tools/sysreg
>> @@ -1531,9 +1531,9 @@ EndEnum
>>   EndSysreg

>>   Sysreg	ID_AA64DFR0_EL1	3	0	0	5	0
>> -Enum	63:60	HPMN0
>> -	0b0000	UNPREDICTABLE
>> -	0b0001	DEF
>> +UnsignedEnum	63:60	HPMN0
>> +	0b0000	NI
>> +	0b0001	IMP
>>   EndEnum
>>   UnsignedEnum	59:56	ExtTrcBuff
>>   	0b0000	NI
>> --
>> 2.50.0.714.g196bf9f422-goog

