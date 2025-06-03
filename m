Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74685214A74
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Jun 2025 20:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748983832; cv=none; b=hjxykRkWuhwtHqSklXfi9eg9sNE7ABGVdPYgBvgzNjkbBcZF4135yZV3QxOKC51K9CunPnU7M4Fy9+a4AdvqFqzP4/n3VvOAQDKEO85THWrkArS4SKZtox4Yh2pjRs5h2XM7RRhaZe/pHGGZyft3/jelV6xOEi+NAEWTzorwM+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748983832; c=relaxed/simple;
	bh=1ORI/LqUz7dCfdMO8958T7FDJ2un7M0ICUmDzX9c648=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=eAlf6treq9nahgWB8lIgx7C5O0pQQNQlUZBsYzVQF6+vsNUvYDbVfLFlQ1V892cd7TNz3S4OwLnhkfqd7zMppS4/U4Kwv4QfJSxEQ6nk/urqhkTDN45reAIJ3MFP/iCMlToqfcJ2kTfPxVabPLM/WU/BraxfA3M9sQ+BuRn5paA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YcuM4k25; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YcuM4k25"
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3ddba1b53e8so14457405ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Jun 2025 13:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748983829; x=1749588629; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3lsZMwRkh1UP98Tqde8+akeySm6v1iX6h0YAqQdmB3c=;
        b=YcuM4k258VOoTUTtX3F6tKlcsHIW3zUABRKNQ1wIuT2QVJraLplTNEhb1+2gwLsYWW
         X1damSvVhKSOfVO85yIyumHXXgLaqL+dRaDl6eOsbIYq0e/zonT3mlEM7PKu/H0CxV45
         BnwjzD1RfURGe9gvZJfpwHKO5OdlODjRRHbp/uvMP664pZYzcNcznWmUN4gUxxkeFeXO
         MAkx80NesSRyHSyWkJtCCQboiQjBo+lz1qR+cAr4wrQD9aHGGwgqt53qox8NcU3F955e
         DM7jYbRx9wBlwK5DHo7ZY16vE8VaknazUbE4Y+ibI+yLXEkw7DcYwUxMyAq3OcBMoHlQ
         rI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748983829; x=1749588629;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3lsZMwRkh1UP98Tqde8+akeySm6v1iX6h0YAqQdmB3c=;
        b=A4skd+6Ztke444ubRXZmBI1obABflxg77i5kCou7HTzDnC7MzJLrGRjHKYrMh8zjo1
         Ol1Tz1peeKPdvv54ofQXCEzxpV/eA1cl9+KqIGfyMjXPTmt+ZPHBPINH5A7w5JUG9uYd
         jQuGzj9PAD8mvMniNRRuJhDrwdofGIQhHru1bbKeLuYPe2SPZcSTv+q3wc8f7i9vokmT
         Uhnb8fF3nIrW9jCepjYwbvVuHSjMn3g8ftj14Lz2mZlrEHLduQjhYxMnuIRQ9mUX/RyU
         Pv5q275KJk07LFfaL0qK1jqyRiX50I+MZ1ATGQgmjOpYtZuHsZEBvPOBYExI+/jC03fJ
         ji2g==
X-Forwarded-Encrypted: i=1; AJvYcCXeciiuhbtSOpKZdBeJBh8J180eeJvZu1GG6wPghl/fsiwxWwPwLHJ+q/OfZ39OX5BUxmpWwWuQBzjUUC1CA9z8@vger.kernel.org
X-Gm-Message-State: AOJu0YwFV4VihQ0S5Q7CasBl+xW19IhPvAA9GqF2pLMbWob8UTCNrm6t
	xpSMFM6swxb8hU6/xR4sf5cVzfAX2euMPzifgCRcnWBi18ZGDjQfOT5afryfxWuVgfsqT8Fufnv
	NAoirLvcTC7cE8lAt9Qkh93q1zA==
X-Google-Smtp-Source: AGHT+IE8lcweOrXzv1dJ7JnXQujzAi86ZbFeivqiLkC8HSJs78PXh7Mwa8lRBkCmnRTpW9aZv5V6w/tu2G1Ilng5MA==
X-Received: from ilbbf2.prod.google.com ([2002:a05:6e02:3082:b0:3dd:a279:72c1])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:1807:b0:3dc:8b29:30bc with SMTP id e9e14a558f8ab-3ddbedbef4cmr5429525ab.21.1748983829547;
 Tue, 03 Jun 2025 13:50:29 -0700 (PDT)
Date: Tue, 03 Jun 2025 20:50:28 +0000
In-Reply-To: <aD4ijUaSGm9b2g5H@linux.dev> (message from Oliver Upton on Mon, 2
 Jun 2025 15:15:41 -0700)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnt7c1s35yj.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH 01/17] arm64: cpufeature: Add cpucap for HPMN0
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

Hi Oliver. Thanks for the speedy response.

Oliver Upton <oliver.upton@linux.dev> writes:

> Hi Colton,

> On Mon, Jun 02, 2025 at 07:26:46PM +0000, Colton Lewis wrote:
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
>> index a3da020f1d1c..578eea321a60 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -541,6 +541,7 @@ static const struct arm64_ftr_bits ftr_id_mmfr0[] = {
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
>> @@ -2884,6 +2885,13 @@ static const struct arm64_cpu_capabilities  
>> arm64_features[] = {
>>   		.matches = has_cpuid_feature,
>>   		ARM64_CPUID_FIELDS(ID_AA64MMFR0_EL1, FGT, FGT2)
>>   	},
>> +	{
>> +		.desc = "Hypervisor PMU Partitioning 0 Guest Counters",

> nit: just use the the FEAT_xxx name for the description (i.e. "HPMN0").

Okay
