Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795792043;
	b=F7XOmE9bMmuV6EbOUuxk91K/KULJwIk82Wwe8Nq2EZ5c/E7QzXlS0stwgRphaEC45XfP
	 5ZQQDgoTnwQhNLA9tBeZEcnQtIl+M8PjGyIqiOnkM6s2vAnvQZWIvB0lJm0OSvGFQ8x9n
	 CFSxamCp2Ha8OqyTBu3zuZcKHkLhjTX3wesyU8p4HExdVzXm27YtE0ijnGW3s17A+Pa6W
	 HBjSQbYvKdfkCmdNESn3+swjf/8PiUVluK/7bcoDED+TxC3fbaleVhmfg1Frx3WCVulzB
	 SuL1UgwPv7c2XOg3Q2rRvqlNpNE3QzGh3KSs3D+xP4kDTzAgfeUmdHlTdHkqlMF9DWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795792043;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=B5Ck8QcmZUAlkcxrFv8qpQfkG3CLKPwiTCqYeBBAEsE=;
	b=aqRWWOnUHSt/Mh8TwpuhTq4tOqa15JmPtMmvaT7jZUcegMZU1ASyVN20uZ0NA+QGhNLf
	 W1vHi7x9fhD7K+DI4uu6K46aHsjFpkn1GnZydNWBMxKq7/N0Y1nba4NidOQqx0c6bBv+N
	 y7/OYk3oWj6un6JGyuI8hkYCOayTRqNcL72MuNq3G111NLe/KNAb0wHAkUyFNTrwx+rtE
	 OsgWnVcEE6Tn3XF96wirL5SdY9REGvTfUdtGcT+v7c5Vum35IeUCxvtXGdJ/rz8OiaMcM
	 aH5L7ip40XarR/8w0z3CeZfxRJ3g8lHIo/rvdY0PssoLbR6JrVs6D471kESZMKFKRTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=us9ZXcXN;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A52606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 15:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38A52606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=us9ZXcXN
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADCF51570;
	Fri, 27 Nov 2026 07:07:18 -0800 (PST)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E4923F632;
	Fri, 27 Nov 2026 07:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795792041; bh=t9JEmXoi7UsrPtxB0TwwfX1bVrMLJhUNWjCkxSHRbLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=us9ZXcXNEOrwNRY4bxXA6zO5LT4iIH1/+aWFswtgO+NfCyLyR3PavPbqXGXA8DZ2l
	 lkjHpanpJpiY/vt7tIH5rvRxY4eNWNeHNkCvG+SBIvfejsxbgOPu9Abp4p0Pdh9NM4
	 H/taBlnSKZ/+Lubr8H7VpZsVYVz3vofgl3g5pl1o=
Date: Fri, 27 Nov 2026 15:07:15 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: maz@kernel.org, oupton@kernel.org, fuad.tabba@linux.dev,
	joey.gouly@arm.com, seiden@linux.ibm.com, yuzenghui@huawei.com,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	will@kernel.org, mark.rutland@arm.com,
	linux-perf-users@vger.kernel.org, catalin.marinas@arm.com,
	james.clark@linaro.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC PATCH v7 12/28] KVM: arm64: Add SPE VCPU device attribute
 to set the interrupt number
Message-ID: <awmco0j3gEvK_LHp@raptor>
References: <20260903160623.315525-1-alexandru.elisei@arm.com>
 <20260903160623.315525-13-alexandru.elisei@arm.com>
 <69288872-2576-4697-a62d-87ab2bcedd49@arm.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69288872-2576-4697-a62d-87ab2bcedd49@arm.com>

Hi Suzuki,

On Wed, Oct 28, 2026 at 04:52:53PM +0000, Suzuki K Poulose wrote:
> On 03/09/2026 17:06, Alexandru Elisei wrote:
> > From: Sudeep Holla <sudeep.holla@arm.com>
> > 
> > Add KVM_ARM_VCPU_SPE_CTRL(KVM_ARM_VCPU_SPE_IRQ) to allow the user to set
> > the interrupt number for the buffer management interrupt.
> > 
> > [ Alexandru E: Split from "KVM: arm64: Add a new VCPU device control group
> >                 for SPE" ]
> > 
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > ---
> 
> ...
> 
> > diff --git a/arch/arm64/kvm/spe.c b/arch/arm64/kvm/spe.c
> > index fe45ad4c703a..dd5f80318ba4 100644
> > --- a/arch/arm64/kvm/spe.c
> > +++ b/arch/arm64/kvm/spe.c
> > @@ -59,17 +59,99 @@ bool kvm_supports_spe(void)
> >   	return !list_empty(&spe_pmus);
> >   }
> 
> ...
> 
> >   int kvm_spe_get_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
> >   {
> > +	struct kvm_vcpu_spe *vcpu_spe = &vcpu->arch.vcpu_spe;
> > +	struct kvm *kvm = vcpu->kvm;
> > +
> > +	if (!vcpu_has_spe(vcpu))
> > +		return -ENODEV;
> > +
> > +	switch (attr->attr) {
> > +	case KVM_ARM_VCPU_SPE_IRQ: {
> > +		int __user *uaddr = (int __user *)(long)attr->addr;
> > +		int irq;
> > +
> > +		if (!irqchip_in_kernel(kvm))
> > +			return -EINVAL;
> > +
> > +		if (!vcpu_spe->irq_num)
> > +			return -ENXIO;
> > +
> > +		irq = vcpu_spe->irq_num;
> > +		if (put_user(irq, uaddr))
> > +			return -EFAULT;
> > +
> > +		return 0;
> > +	}
> > +	}
> > +
> >   	return -ENXIO;
> >   }
> >   int kvm_spe_has_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
> >   {
> > +	if (!vcpu_has_spe(vcpu))
> > +		return -ENODEV;
> > +
> > +	switch(attr->attr) {
> > +	case KVM_ARM_VCPU_SPE_IRQ:
> > +		return 0;
> 
> Should we gate this too on irqchip_in_kernel(vcpu->kvm) ? Otherwise
> we would advertise to the userspace that it has the SPE_IRQ, but
> would return -EINVAL when we try get_attr if the irqchip is not
> in kernel.

From Documentation/virt/kvm/api.rst:

4.81 KVM_HAS_DEVICE_ATTR
------------------------
[..]
A successful return indicates the attribute is implemented.  It does not
necessarily indicate that the attribute can be read or written in the
device's current state.  "addr" is ignored.

I think my implementation adheres to the documentation? Unless you have a
specific use case in mind?

> 
> Also, do we need to mandate the ordering of the SPE configuration on
> VGIC ?

That doesn't seem to be an issue for the PMU?

Thanks,
Alex
