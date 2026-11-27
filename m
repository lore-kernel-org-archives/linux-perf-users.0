Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791598;
	b=GxrT/GdmcWNIjwBXGPwNFalrl7SZDPCFfshZpBrYybc8piwZoFqYDjiWGUWARZGc4adv
	 qKtGkMbihj0UVwq170taMRYZAsGaer9cZy0vY9zjh0MUA4FDDq4ry1lolNPrlhbAVXEaH
	 8JG7npoehRkdlj6Heq/CWlxJislI5hOR6qyiHXrc6T/L0dGZ0Kd3QQajI4RhHChIgSClO
	 GhKd8KI9cyUT5NmduusBUNB1VhkZbwYJ16jS5/ETeITwSijEUKznj4FuBHjGfHpfn9gcp
	 SOnOJW6jKf+DG+Qr7kn8M82BSbD5QlYZOC2Y7sQ2lOZM+51I9LQNEPW+CrT+jWOxslg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791598;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=trMeZ3I6wSRpel42gaDmvuE0j0JJNvQaWvB9cfT9V8g=;
	b=MdhNxM+HWAz7OZWzP4/WZ0Wc/jwjyoigRQTpF3PsbYhR6bEzP25fC4yhSPKts8arKHzo
	 yCRg617WX+eRnHUBsZ0DI0YwpkERWFkgWX4+za2PprSj9L02mLQOQ5CvtYjprvcPmZJ94
	 hmrRfm8OmPjwvZR9qI/e5zuxEX3PD/waStgGsrE1li2mQbE87lEp2u4fTvFg6j3b4hRpY
	 VP1oO55MdxBsNxkbW+7lUvkO1a2zAZf99f6LVXpouMIHjWX0OWRqb1SwiuHd7opW85XPd
	 Y4t1dJb6cCU5yGZQ1SKLVKX/n2gWE02EvSc5O9MwJFXcG/I6CZQzmLibdYw3TgzdF/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=G0oE+4R9;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D92606A333
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 14:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38D92606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=G0oE+4R9
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9E92169E;
	Fri, 27 Nov 2026 06:59:54 -0800 (PST)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE0C63F86C;
	Fri, 27 Nov 2026 06:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795791597; bh=Guj4qq8KsMECYr2/fFBhn4O8fhKzRg2BkXrLBTo0Gb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G0oE+4R90vGvAvd4EPODqjyWNz4FYDuvIubkX8g5SfO3rpfIpzY4gTODCV4SjonTe
	 b6Zx4iyimFZdZhM1LRqeYCIRqxuzun00cZsPUYxguVUmqgqGA0SIzSNOR4Fg0nYiIa
	 n7sT3zjvR5Oy8TYYnGNh/iinR8xg0IapWkQMpKrM=
Date: Fri, 27 Nov 2026 14:59:50 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: maz@kernel.org, oupton@kernel.org, fuad.tabba@linux.dev,
	joey.gouly@arm.com, seiden@linux.ibm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, will@kernel.org, mark.rutland@arm.com,
	linux-perf-users@vger.kernel.org, catalin.marinas@arm.com,
	james.clark@linaro.org
Subject: Re: [RFC PATCH v7 05/28] perf: arm_spe_pmu: Add PMBIDR_EL1 and
 PMSIDR_EL1 to struct arm_spe_pmu
Message-ID: <awma5sGHkk3LqlC-@raptor>
References: <20260903160623.315525-1-alexandru.elisei@arm.com>
 <20260903160623.315525-6-alexandru.elisei@arm.com>
 <atDmDRSNDllpJtmL@gremlin>
 <avSjyLhFsYjI7tG_@raptor>
 <avtDK5rtD38jnhqR@gremlin>
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
In-Reply-To: <avtDK5rtD38jnhqR@gremlin>

Hi Lorenzo,

On Mon, Nov 16, 2026 at 05:56:28PM +0000, Lorenzo Stoakes (ARM) wrote:
> On Wed, Nov 11, 2026 at 05:20:08PM +0000, Alexandru Elisei wrote:
[..]
> > On Thu, Oct 15, 2026 at 04:12:27PM +0100, Lorenzo Stoakes (ARM) wrote:
[..]
> > > On Thu, Sep 03, 2026 at 05:06:00PM +0100, Alexandru Elisei wrote:
[..]
> > > > diff --git a/include/linux/perf/arm_spe_pmu.h b/include/linux/perf/arm_spe_pmu.h
> > > > index af86fd184050..97b14e236fcd 100644
> > > > --- a/include/linux/perf/arm_spe_pmu.h
> > > > +++ b/include/linux/perf/arm_spe_pmu.h
> > > > @@ -21,6 +21,8 @@ struct arm_spe_pmu {
> > > >  	cpumask_t				supported_cpus;
> > > >  	struct hlist_node			hotplug_node;
> > > >
> > > > +	u64					pmbidr_el1;
> > >
> > > Equally, this doesn't seem to be used anywhere in the series, maybe drop?
> >
> > Fixed.
> >
> > >
> > > > +	u64					pmsidr_el1;
> > >
> > > This field is used in kvm_spe_has_feat_spe_fds() and
> > > kvm_spe_has_feat_spe_fne():
> > >
> > > bool kvm_spe_has_feat_spe_fds(struct kvm *kvm)
> > > {
> > > 	...
> > > 	return kvm_has_feat(kvm, ID_AA64DFR0_EL1, PMSVer, V1P4) &&
> > > 	       FIELD_GET(PMSIDR_EL1_FDS, spe_pmu->pmsidr_el1);
> > > }
> > >
> > > bool kvm_spe_has_feat_spe_fne(struct kvm *kvm)
> > > {
> > > 	...
> > > 	return kvm_has_feat(kvm, ID_AA64DFR0_EL1, PMSVer, V1P2) &&
> > > 	       FIELD_GET(PMSIDR_EL1_FnE, spe_pmu->pmsidr_el1);
> > > }
> > >
> > > So checking for FDS and FnE, but these are available as feature flags as
> > > __arm_spe_pmu_dev_probe() gets these:
> > >
> > > static void __arm_spe_pmu_dev_probe(void *info)
> > > {
> > > 	...
> > > 	if (FIELD_GET(PMSIDR_EL1_FnE, reg))
> > > 		spe_pmu->features |= SPE_PMU_FEAT_INV_FILT_EVT;
> > > 	...
> > > 	if (FIELD_GET(PMSIDR_EL1_FDS, reg))
> > > 		spe_pmu->features |= SPE_PMU_FEAT_FDS;
> > > 	...
> > > }
> > >
> > > And then kvm_spe_has_feat_spe_fds() and kvm_spe_has_feat_spe_fne() can be:
> > >
> > > bool kvm_spe_has_feat_spe_fds(struct kvm *kvm)
> > > {
> > > 	...
> > > 	return kvm_has_feat(kvm, ID_AA64DFR0_EL1, PMSVer, V1P4) &&
> > > 	       (spe_pmu->features & SPE_PMU_FEAT_FDS);
> > > }
> > >
> > > bool kvm_spe_has_feat_spe_fne(struct kvm *kvm)
> > > {
> > > 	...
> > > 	return kvm_has_feat(kvm, ID_AA64DFR0_EL1, PMSVer, V1P2) &&
> > > 	       (spe_pmu->features & SPE_PMU_FEAT_INV_FILT_EVT);
> > > }
> > >
> > > Right?
> >
> > In this use case they are functionally the same, yes, but conceptually, they are
> > not the same thing. spe_pmu->features advertises the features that the SPE
> > *driver* supports, PMSIDR_EL1 advertises the features that the *hardware*
> > implements. The two are not always equal.  For example, KVM added handling for
> > the PMSNEVFR_EL1 register (added by FEAT_SPE_FnE), a few years before the SPE
> > driver supported FEAT_SPE_FnE.
> >
> > I can see KVM, in the future, having to virtualize hardware features not
> > supported by the host driver yet, so unless you have a strong objection, I would
> > rather keep the use of the architectural register instead of relying on the
> > driver.
> 
> Ack OK, sounds sensible, no strong objection but could you add a sentence to the
> commit msg about that? Thanks! :)

Done.

Thanks,
Alex
