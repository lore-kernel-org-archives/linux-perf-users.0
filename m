Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417409;
	b=f8g5v7cMnl2jiBtUn+ZVzDWUZI3XWc4LJvArlJKsGQos8Vtbv2A+aL6n/OlnE7tdy5ke
	 Pr8vnk8CLVIni0PXH5d7S1qQkVWiw4pzSTOtP/iwsdeRZ3HW67aIMQOQCjWtVOVxgcpFn
	 vFklhQeNoYHTlkB3R3Nq/Qp+F7zAbDI6w8efIFixCeSI4118/SnVEh69mpPgQ1le55X/D
	 DBilL+jK1/xNALYYr6HijDv4Milb3lwSc72Rg1vtmeuTg4rO9QhrJZfFtbpPWG979MnBj
	 ngJvg7fLJA0DjtQXTygFudL50iV3lpUqPbXePXbd58mO9R6OLKtNbx5Jq9qdyNyNirA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417409;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=2LtHlzenH8P0Let9eUokfApdyyGworpP/r1pDQ+TQU8=;
	b=QBLcqdpjVfhaMqh6DY81lcNUMd9RIZkQVIGMTnrhiWMt2ej2PFg4DmEBPsq38/geskSl
	 m+9kRw2ptDayuQVhgbAQLelCUAaepDquK3FQwaZ78aTWaBuNFwVOszI4a4IDeW2DrdDy8
	 4T2aXe7OMjk4SCE26T8lScjqi/XKDJ3xCc+CxWQjMndDd4QJCGQjuOfGMIZr6SK3EvLtu
	 TqONvU/BggVeYEQiLsQVG7c4c3BnQfs/Glp3upYbZI9kznd/sWQnIDdgKJjRXiluAop+g
	 gD4TkPSAO5WnGfv68IxX+X6xj9avliJcB/Yn3TmiMlAK2RqzJX2rwL/cR6F7Q9d9Y5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=kFzskHgB;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD94606A324
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 17:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CD94606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=kFzskHgB
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDCE6339;
	Wed, 11 Nov 2026 09:16:45 -0800 (PST)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4B2D3F632;
	Wed, 11 Nov 2026 09:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794417408; bh=I5J2kVvdKW4OqPmoJ/nQAip3vlK/SWhiWTZU2FsT3FI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kFzskHgBfJ2MED+UEtFv80JX+XpZT8ayy4tQXWR1Bkb8jNcjKtwWklLBsjqzy2EW2
	 WxBRsR3lK17xRh29ko6PvPw39RRBOceP94t6lHLkMTWvzQvje1GggtxXs6JrwOlJ/U
	 S2CHp4colJHqGlGTbLxoduOpLbJVoQXP3Q9PKwQM=
Date: Wed, 11 Nov 2026 17:16:37 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: maz@kernel.org, oupton@kernel.org, fuad.tabba@linux.dev,
	joey.gouly@arm.com, seiden@linux.ibm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, will@kernel.org, mark.rutland@arm.com,
	linux-perf-users@vger.kernel.org, catalin.marinas@arm.com,
	james.clark@linaro.org
Subject: Re: [RFC PATCH v7 03/28] KVM: arm64: Add CONFIG_KVM_ARM_SPE Kconfig
 option
Message-ID: <avSi9WPLhMLrnogk@raptor>
References: <20260903160623.315525-1-alexandru.elisei@arm.com>
 <20260903160623.315525-4-alexandru.elisei@arm.com>
 <atDa-BSF3RMzJSdE@gremlin>
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
In-Reply-To: <atDa-BSF3RMzJSdE@gremlin>

Hi,

On Thu, Oct 15, 2026 at 03:15:18PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Thu, Sep 03, 2026 at 05:05:58PM +0100, Alexandru Elisei wrote:
> > Add a new configuration option that will be used for KVM SPE emulation.
> > CONFIG_KVM_ARM_SPE depends on the SPE driver being loaded because:
> >
> > 1. The SPE driver maintains a cpumask of physical CPUs that support SPE,
> >    and that will be used by KVM to emulate SPE on heterogeneous systems.
> 
> I guess e.g. big.LITTLE?

That's the marketing term for it, yes.

> 
> >
> > 2. KVM will rely on the SPE driver enabling the SPE interrupt at the GIC
> >    level.
> >
> > The option will become user selectable after SPE support in KVM is
> > implemented.
> >
> > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> 
> With nit addressed the redundant dependency removed (both noted below),
> LGTM and:
> 
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> 
> > ---
> >  arch/arm64/kvm/Kconfig | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> > index 449154f9a485..fece4c02b97c 100644
> > --- a/arch/arm64/kvm/Kconfig
> > +++ b/arch/arm64/kvm/Kconfig
> > @@ -103,5 +103,14 @@ config PKVM_STACKTRACE
> >  	  If unsure, or not using protected nVHE (pKVM), say N.
> >
> >  endif # NVHE_EL2_DEBUG
> > +
> > +config KVM_ARM_SPE
> 
> NIT: Nothing else in the file has the _ARM_ prefix, so is that redundant
> here?

I add the capability KVM_CAP_ARM_SPE later, so I would rather keep the config
name KVM_ARM_SPE so the two align?

> 
> > +	bool
> > +	depends on KVM && ARM_SPE_PMU
> 
> I think KVM should be removed here, this is within an 'if KVM' block
> already, and nothing else here depends on it either so not a convention.

Removed the explicit dependency on KVM.

Thanks,
Alex

> 
> > +	default n
> > +	help
> > +	  Adds support for Statistical Profiling Extension (SPE) in virtual
> > +	  machines.
> > +
> >  endif # KVM
> >  endif # VIRTUALIZATION
> > --
> > 2.43.0
> >
> >
> 
> --
> Cheers, Lorenzo
