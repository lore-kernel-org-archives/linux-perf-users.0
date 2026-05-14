Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D4F386C3C
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 17:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778780946; cv=none; b=TZyoJDA3V5hpLmQ15UI4F3fwi3R689WNKTN8p7sdpD45Yi2Fs3sycz/PEV3/VLANeAhEs4FCmobf8xzDGZlDk239PRX3nyPuuW/zJa9IPEXBNH9IkBTup08FRxQ6KEXbTNpADfu63sdl4DbECD2qBoUmJsbHNnbliPbRsPR63MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778780946; c=relaxed/simple;
	bh=GoRDUmjwts98H2GxjEyrtGopYG2FlUX43PGMqIqINsM=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=F/R5XcEPjfij4Wz38tOCHkdlZ6pTsx/oYZfQV361ImjPHnSYPZqZptwC1dek08aA0My/u8C2jKg6q0nsJr4XWQvc2ERyaHJ7buUqEguS0LfeF0viOq+vrp8zpzurFem7Sw+n9ZT3zQLe8At+EkvhxRyaWT7iG241sURLtvVCceg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fyhzYkEA; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fyhzYkEA"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-40ee506cf49so10689820fac.2
        for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 10:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778780944; x=1779385744; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lvf58REysbafuiio+PHgzYPPOXJAU2S7yZkdP1X1Ak4=;
        b=fyhzYkEAbiuipPqf7gx5+RdaCXwMfqmpjczIhbMY7cBnUFd+IALqIrwDlL+CkfOy8R
         POeCtYJ2bwwX21dIaWHEIoGEC7/PqWd/riNRFOHYVtq6YMSjTzRC3Tk2Fn765Y945gVa
         rvuJ+BzJH9Zml+P0kNSQYCFbq5ELx6g/fPtmJOd6y1MpZxuoA+oSsdBKBv7jOT7weB5K
         wUzPs2RbvNHqK8/Ip8vQY1twzb1P7xV8fVyqGMC3pZRMqYQ3e9YxWW5XxlHL0aZhcq6B
         88+ZKGsu1+ejYtPjxrj6uLGDISrx4Bvy4E6ZAc5I44MpgeuTxoFepMV8Fn1DofCbarXq
         nqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778780944; x=1779385744;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lvf58REysbafuiio+PHgzYPPOXJAU2S7yZkdP1X1Ak4=;
        b=aTm0lLnuAX6s2nbeCp8fJJ+TpFoeodj87ZBtT3VwWR8C6GMcR3l5q8J0IO6J+6B32k
         IbYjn4KWWcpPv4rahDNj9EQt7g6ffq5DqpG2Rdpe9Ht6h1Dy6UaXARwBdtsoTXrwQt2F
         /CKs8nuO0sdMIebwMrfQaYKVaf51GnleyzOit1/xzK7vF91vjKTr6C59LreI11a+otWa
         4TGDgTDUMVOXtBb++UBVpR1bcWhvCBYKBA56n/fuNoP5gAqeeNx5j4PiZTRggsjOjuV/
         uJE6Zjb7ptQUrttsBZ4o8setDNhH93JA/nPoOrsM6O9TfYLbFRyw+INF7SryasHXHx0e
         WT6w==
X-Forwarded-Encrypted: i=1; AFNElJ/mELGaQyt0m4uUJ4KGArJaznHs7Al9ZyXU65iMIc1TlR/eYDB/uv06cJVNEi/inpsXN03RmUB6UVackWcT+j8x@vger.kernel.org
X-Gm-Message-State: AOJu0YxKimVrNI8vNkmCekFXCMoRV0pYFfy7Z/cfenfhwBu+HrRS7zZm
	4Aq3t6zoiGqeB2O2p4bpIehnm1DctbIzhm5NuQ/8UF7GOR+qLtL/Nup+pELMgWLrWzpxkxn+mF0
	baylz5HNx3wRa4u6SrrST3+gwvA==
X-Received: from oaao19.prod.google.com ([2002:a05:6870:f013:b0:43a:1a0e:c45b])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:a793:b0:434:efa3:9bd5 with SMTP id 586e51a60fabf-43a2ddcfbbamr377060fac.27.1778780943565;
 Thu, 14 May 2026 10:49:03 -0700 (PDT)
Date: Thu, 14 May 2026 17:49:02 +0000
In-Reply-To: <agQpbiD8Fi6fzomf@kernel.org> (message from Oliver Upton on Wed,
 13 May 2026 00:34:06 -0700)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntwlx5c25t.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v7 07/20] KVM: arm64: Set up FGT for Partitioned PMU
From: Colton Lewis <coltonlewis@google.com>
To: Oliver Upton <oupton@kernel.org>
Cc: kvm@vger.kernel.org, alexandru.elisei@arm.com, pbonzini@redhat.com, 
	corbet@lwn.net, linux@armlinux.org.uk, catalin.marinas@arm.com, 
	will@kernel.org, maz@kernel.org, oliver.upton@linux.dev, mizhang@google.com, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	mark.rutland@arm.com, shuah@kernel.org, gankulkarni@os.amperecomputing.com, 
	james.clark@linaro.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Hi Oliver. Thanks for the review.

Oliver Upton <oupton@kernel.org> writes:

> On Mon, May 04, 2026 at 09:18:00PM +0000, Colton Lewis wrote:
>> +static void __compute_hdfgrtr(struct kvm_vcpu *vcpu)
>> +{
>> +	__compute_fgt(vcpu, HDFGRTR_EL2);
>> +
>> +	*vcpu_fgt(vcpu, HDFGRTR_EL2) |=
>> +		HDFGRTR_EL2_PMOVS
>> +		| HDFGRTR_EL2_PMCCFILTR_EL0
>> +		| HDFGRTR_EL2_PMEVTYPERn_EL0
>> +		| HDFGRTR_EL2_PMCEIDn_EL0
>> +		| HDFGRTR_EL2_PMMIR_EL1;
>> +}
>> +

> I've given this feedback at least twice already...

> Operators go on the preceding line in the case of line continuations.

I apologize for letting that slip through again.

>> +
>> +/**
>> + * kvm_pmu_is_partitioned() - Determine if given PMU is partitioned
>> + * @pmu: Pointer to arm_pmu struct
>> + *
>> + * Determine if given PMU is partitioned by looking at hpmn field. The
>> + * PMU is partitioned if this field is less than the number of
>> + * counters in the system.
>> + *
>> + * Return: True if the PMU is partitioned, false otherwise
>> + */
>> +bool kvm_pmu_is_partitioned(struct arm_pmu *pmu)
>> +{
>> +	if (!pmu)
>> +		return false;
>> +
>> +	return pmu->max_guest_counters >= 0 &&
>> +		pmu->max_guest_counters <= *host_data_ptr(nr_event_counters);
>> +}
>> +
>> +/**
>> + * kvm_vcpu_pmu_is_partitioned() - Determine if given VCPU has a  
>> partitioned PMU
>> + * @vcpu: Pointer to kvm_vcpu struct
>> + *
>> + * Determine if given VCPU has a partitioned PMU by extracting that
>> + * field and passing it to :c:func:`kvm_pmu_is_partitioned`
>> + *
>> + * Return: True if the VCPU PMU is partitioned, false otherwise
>> + */
>> +bool kvm_vcpu_pmu_is_partitioned(struct kvm_vcpu *vcpu)
>> +{
>> +	return kvm_pmu_is_partitioned(vcpu->kvm->arch.arm_pmu) &&
>> +		false;
>> +}

> Ok, I'm thoroughly confused about these predicates.

> Whether or not a vCPU is using a partitioned PMU is a per-VM property.
> This is separate from whether or not the backing arm_pmu has a range of
> available counters for the guest to use.

> It is entirely possible that a VM *isn't* using the partitioned PMU
> feature (i.e. backed with perf events) yet the supporting arm_pmu has a
> guest counter range.

Yes and I add that to this predicate in a later patch when I introduce
the flag. I can always reorder to introduce the flag before (or along
with) this predicate.

>> +#if !defined(__KVM_NVHE_HYPERVISOR__)
>> +bool kvm_vcpu_pmu_is_partitioned(struct kvm_vcpu *vcpu);
>> +bool kvm_vcpu_pmu_use_fgt(struct kvm_vcpu *vcpu);
>> +#else
>> +static inline bool kvm_vcpu_pmu_is_partitioned(struct kvm_vcpu *vcpu)
>> +{
>> +	return false;
>> +}
>> +
>> +static inline bool kvm_vcpu_pmu_use_fgt(struct kvm_vcpu *vcpu)
>> +{
>> +	return false;
>> +}
>> +#endif
>> +

> Don't use ifdeffery for this. Aim to have a single definition and rely
> on has_vhe() to do the rest of the work.

Will do.


> Thanks,
> Oliver
