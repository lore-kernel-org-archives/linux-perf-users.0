Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FA125783A
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 20:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765572883; cv=none; b=crvMHZ+RVwhef3PhHhh/SoUsSVlP4epMEezWzkVrzmi1FHF5/y3os61YUNuEauskb+Ft7aQBkoy3q0kQuYiGzPRlGFoT7D3z6Dk3H3W9DyQS7kVH/DdnswGYCMjOi0gzsB/mWPgMWwF3TVp6dKPvS5VevEtDi67+Wu7J3o6sCws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765572883; c=relaxed/simple;
	bh=KRrYXDgotZ3hkrFWqT2Xxzs4T7VsdVUIUvNsM4Tt2CA=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=dAICdscbVal45+DDwjB63Ro1IdWSkonPrFCWUIeyWXe6rxjiQM21tSgSoicYYrKe3eHFUqo/G9zHW6vMbkdjHmqic0xXjPfCrMWklRrFLbnkAMcV5qNu90fy1Nfmze4lMiXoj7o89yDRDreTfwgLcCCSyHyReucyH24qh8J4BOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QLwvmh3F; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QLwvmh3F"
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-45396d397e0so1335672b6e.3
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 12:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765572879; x=1766177679; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3FXn5oKHBMgqIJsfuynoMoNzKyF0I0AGnsGa5FlNVAQ=;
        b=QLwvmh3FMzVzPlJlBo6h9byVXnkQN6fm/+YA1AXbW0/raH/EuS+E9RC8QAizpGKaMQ
         YGmchoXUt/2Rlh4XWuxPmyuaRPyy0lgHI8fLA6oiR8oBCFUmtb2aPaXAPMeJnEZXooJu
         7ZVcEbzjRYGJwTMATEFOgnsjhZKqbgoCcrb2sNyKKvVyumEqOzA8XR+QEyeSr9ICASGt
         pJ+De79oxbKWGytN8+33JF706rM9pXVuznSoezpYw2T7RQBN+m9tDTGqRCxMYOeBETln
         /e/3R9yhBcioToy5iRTaNnPJDjcsQbfx2u3Z0hTFA/ckskNliVg9jMRASN+HFVbXddRk
         Nyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765572879; x=1766177679;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3FXn5oKHBMgqIJsfuynoMoNzKyF0I0AGnsGa5FlNVAQ=;
        b=TWDF6P0I26AVQjti/KJjYMV3Tp/ojFnkx6fBi4zLV2b40FcKoUJKV4Hx0Pic8fvbr5
         w6GcIgoPBP1CDKRxLr18Xti7NFwpy//cjs05OTqYmBynC452PgVJFw7IqYIcpipu+2sc
         u7HPIt5P9dXQXrS74aoDhAO0s8fMBJww1B1RqsdRG1f6fsiR3JhU8sv+XmeRiM2abzwr
         kZ85X4P8UCDGxh4BKVQTBsd45NJuKmmohob25OJ+GEMT3tQ5V1TWhzeeEru/Nx3R059W
         IijOzqL0pi2QXXK7XLn1t7iBuEXHYeVe5rA5MA5E5m1Wc4/fzyx3eeZPh56I3tfg8NjZ
         7WZA==
X-Forwarded-Encrypted: i=1; AJvYcCX165oLR408hK3XMA1rvVXbVNjf9m/tfJwjWhUukv0tOiIm0dkTrGgm5GNKLY51kB7nFWZ9swGWhWPoq+pnAoVt@vger.kernel.org
X-Gm-Message-State: AOJu0Ywim/chMeZQ4ls5z3wKMvGq4GqLswgcviBan5LwBXzwY9VyJveA
	EUyInhdbLwSPem2YhumbatPJ93c6jt/K2btRbkvzAtzxWPbx5klcybyXFgIGTKcqcwNeDUCF7ZT
	izcEHzZrUBpdU7d0aoQDVW5AzDA==
X-Google-Smtp-Source: AGHT+IH6fb4UumzYsfcjXdyetsttD/1JFDYI7F758xyq6M3c7XHveoyP9rAiScoRQhR1KR8axHNUmY6AiGo2XvKjTQ==
X-Received: from oaeh14.prod.google.com ([2002:a05:6870:170e:b0:3f5:b0db:411a])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1814:b0:450:d504:9295 with SMTP id 5614622812f47-455ac957f68mr1619808b6e.44.1765572879590;
 Fri, 12 Dec 2025 12:54:39 -0800 (PST)
Date: Fri, 12 Dec 2025 20:54:38 +0000
In-Reply-To: <aTiRG0I1FZzntHtH@kernel.org> (message from Oliver Upton on Tue,
 9 Dec 2025 13:14:03 -0800)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntv7ib2zg1.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v5 12/24] KVM: arm64: Use physical PMSELR for PMXEVTYPER
 if partitioned
From: Colton Lewis <coltonlewis@google.com>
To: Oliver Upton <oupton@kernel.org>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	maz@kernel.org, oliver.upton@linux.dev, mizhang@google.com, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	mark.rutland@arm.com, shuah@kernel.org, gankulkarni@os.amperecomputing.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Oliver Upton <oupton@kernel.org> writes:

> On Tue, Dec 09, 2025 at 08:51:09PM +0000, Colton Lewis wrote:
>> Because PMXEVTYPER is trapped and PMSELR is not, it is not appropriate
>> to use the virtual PMSELR register when it could be outdated and lead
>> to an invalid write. Use the physical register when partitioned.

>> Signed-off-by: Colton Lewis <coltonlewis@google.com>
>> ---
>>   arch/arm64/include/asm/arm_pmuv3.h | 7 ++++++-
>>   arch/arm64/kvm/sys_regs.c          | 9 +++++++--
>>   2 files changed, 13 insertions(+), 3 deletions(-)

>> diff --git a/arch/arm64/include/asm/arm_pmuv3.h  
>> b/arch/arm64/include/asm/arm_pmuv3.h
>> index 27c4d6d47da31..60600f04b5902 100644
>> --- a/arch/arm64/include/asm/arm_pmuv3.h
>> +++ b/arch/arm64/include/asm/arm_pmuv3.h
>> @@ -70,11 +70,16 @@ static inline u64 read_pmcr(void)
>>   	return read_sysreg(pmcr_el0);
>>   }

>> -static inline void write_pmselr(u32 val)
>> +static inline void write_pmselr(u64 val)
>>   {
>>   	write_sysreg(val, pmselr_el0);
>>   }

>> +static inline u64 read_pmselr(void)
>> +{
>> +	return read_sysreg(pmselr_el0);
>> +}
>> +
>>   static inline void write_pmccntr(u64 val)
>>   {
>>   	write_sysreg(val, pmccntr_el0);
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index 0c9596325519b..2e6d907fa8af2 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -1199,14 +1199,19 @@ static bool writethrough_pmevtyper(struct  
>> kvm_vcpu *vcpu, struct sys_reg_params
>>   static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct  
>> sys_reg_params *p,
>>   			       const struct sys_reg_desc *r)
>>   {
>> -	u64 idx, reg;
>> +	u64 idx, reg, pmselr;

>>   	if (pmu_access_el0_disabled(vcpu))
>>   		return false;

>>   	if (r->CRn == 9 && r->CRm == 13 && r->Op2 == 1) {
>>   		/* PMXEVTYPER_EL0 */
>> -		idx = SYS_FIELD_GET(PMSELR_EL0, SEL, __vcpu_sys_reg(vcpu,  
>> PMSELR_EL0));
>> +		if (kvm_vcpu_pmu_is_partitioned(vcpu))
>> +			pmselr = read_pmselr();
>> +		else
>> +			pmselr = __vcpu_sys_reg(vcpu, PMSELR_EL0);

> This isn't preemption safe. Nor should the "if (partitioned) do X else do  
> Y" get
> open-coded throughout the shop.

Okay. I had not known the register access stuff wasn't. I'll fix that.


> I would rather this be handled with a prepatory patch that provides
> generic PMU register accessors to the rest of KVM (e.g.
> vcpu_read_pmu_reg() / vcpu_write_pmu_reg()). Internally those helpers
> can locate the vCPU's PMU registers (emulated, partitioned in-memory,
> partitioned in-CPU).

That seems like a good idea.

> Thanks,
> Oliver
