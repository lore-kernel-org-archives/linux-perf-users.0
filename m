Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206385;
	b=pE/yIvHiDZYirvSoduB9vJKznylD0shB/nc0N/exRXW3Oq5k/iZgyNkWp+RS0deGXdwK
	 NHJsM39sK+qlkTrLIhtYJm3yB5KoN+mDM25j/Z1HMhpguXI6otH534ZhBlcobMzkRUd4i
	 4PbqwgudLuj/HDec0j8RQG1xh/urKAH2O/kHu6d3rYrs5cG6pk6EYTkzsuEumpI87a4cl
	 srnQ0q1GtwiFJLc86mJu5GsuG0QsKedDd8ZelcmMjIcYH0phei2ynAzx+NVN0B8vW9Faa
	 dpMVNdfHR1lyThdyhFKGWJBNC2fgDEx3/s6s5Qjc5Umo2DKjmdUJUVAcoXW9UCi0/XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206385;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=YSDSgjpQLJHyewcbdkRbRSJusGm4cUM3Dgl9o9009Ec=;
	b=tKq+68ch4MKAUlnh/5fbDK1kdIIUrrEZNzA41pIAL59EUQY1+lLWhokweCT5lDTeuJBl
	 kl2ZxIz5wv4sdVeObPDCGPSNvi5dIBhlTkdZVPbBPl5ofGyPV6vM99sd9pmrBpIcZksR0
	 ZqBd7QL9fB2R2g16FM1RYULS3vKaH7AY5SjLyOkm2uYKMtMCw/RF8OnK7SC2F7WeAZtdp
	 1kP1VppVxoFg2Xfy8bxOe5hUuFnl5fo9NnQtj3IbrJA1hfsWTU1lfCOuv6ykf0QCMQX+j
	 /KKaWFqqsO+iwWSIEQWDymjq+CZSvX98Wh4mKz64ZHpIrGBbSMqZmbX/4VVgvUKGLzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Jet83GLP;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67AB606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Oct 2026 16:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C67AB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Jet83GLP
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 049651756;
	Wed, 28 Oct 2026 09:52:54 -0700 (PDT)
Received: from [10.57.16.117] (unknown [10.57.16.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A7D13F59E;
	Wed, 28 Oct 2026 09:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793206377; bh=vJ+LPeiA2zykY87kypyN7HwDrT7gAk57eYzbxdUxVq4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Jet83GLPCj8+yixKuGbe68KlDg4d2iybThkNYU9F6Ea5jitw0eidM9kZcZqQi/3CI
	 wH8bTu5nposSzApqJwqyOjNNTxMt89rNL8giOw0LyOem6IL6V38coDJrAtDRYej3Vj
	 cEYZJPrASJc4Y8RsPiHVO6F6RpxaKrrqmcgFFO1U=
Message-ID: <69288872-2576-4697-a62d-87ab2bcedd49@arm.com>
Date: Wed, 28 Oct 2026 16:52:53 +0000
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
Subject: Re: [RFC PATCH v7 12/28] KVM: arm64: Add SPE VCPU device attribute to
 set the interrupt number
Content-Language: en-GB
To: Alexandru Elisei <alexandru.elisei@arm.com>, maz@kernel.org,
 oupton@kernel.org, fuad.tabba@linux.dev, joey.gouly@arm.com,
 seiden@linux.ibm.com, yuzenghui@huawei.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 will@kernel.org, mark.rutland@arm.com, linux-perf-users@vger.kernel.org,
 catalin.marinas@arm.com, james.clark@linaro.org
Cc: Sudeep Holla <sudeep.holla@arm.com>
References: <20260903160623.315525-1-alexandru.elisei@arm.com>
 <20260903160623.315525-13-alexandru.elisei@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20260903160623.315525-13-alexandru.elisei@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/09/2026 17:06, Alexandru Elisei wrote:
> From: Sudeep Holla <sudeep.holla@arm.com>
> 
> Add KVM_ARM_VCPU_SPE_CTRL(KVM_ARM_VCPU_SPE_IRQ) to allow the user to set
> the interrupt number for the buffer management interrupt.
> 
> [ Alexandru E: Split from "KVM: arm64: Add a new VCPU device control group
>                 for SPE" ]
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---

...

> diff --git a/arch/arm64/kvm/spe.c b/arch/arm64/kvm/spe.c
> index fe45ad4c703a..dd5f80318ba4 100644
> --- a/arch/arm64/kvm/spe.c
> +++ b/arch/arm64/kvm/spe.c
> @@ -59,17 +59,99 @@ bool kvm_supports_spe(void)
>   	return !list_empty(&spe_pmus);
>   }
>   

...

>   int kvm_spe_get_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
>   {
> +	struct kvm_vcpu_spe *vcpu_spe = &vcpu->arch.vcpu_spe;
> +	struct kvm *kvm = vcpu->kvm;
> +
> +	if (!vcpu_has_spe(vcpu))
> +		return -ENODEV;
> +
> +	switch (attr->attr) {
> +	case KVM_ARM_VCPU_SPE_IRQ: {
> +		int __user *uaddr = (int __user *)(long)attr->addr;
> +		int irq;
> +
> +		if (!irqchip_in_kernel(kvm))
> +			return -EINVAL;
> +
> +		if (!vcpu_spe->irq_num)
> +			return -ENXIO;
> +
> +		irq = vcpu_spe->irq_num;
> +		if (put_user(irq, uaddr))
> +			return -EFAULT;
> +
> +		return 0;
> +	}
> +	}
> +
>   	return -ENXIO;
>   }
>   
>   int kvm_spe_has_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
>   {
> +	if (!vcpu_has_spe(vcpu))
> +		return -ENODEV;
> +
> +	switch(attr->attr) {
> +	case KVM_ARM_VCPU_SPE_IRQ:
> +		return 0;

Should we gate this too on irqchip_in_kernel(vcpu->kvm) ? Otherwise
we would advertise to the userspace that it has the SPE_IRQ, but
would return -EINVAL when we try get_attr if the irqchip is not
in kernel.

Also, do we need to mandate the ordering of the SPE configuration on
VGIC ?

Cheers
Suzuki


> +	}
> +
>   	return -ENXIO;
>   }

