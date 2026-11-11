Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417313;
	b=TC98PLiID9CNUNsxRDLHmmWfai7PhSUD0B528Rggvvmol9/BfCu7GyygnBY+M6cRnyeJ
	 WgUI88WtXM6OfsMywDbzSsIWl6hGKuFInC5oIHRCQRXazbmSRu9pxVUjyo2Upm2MeUp6j
	 X/t/Dl66p3rCLbgKr17c4XHefkv6rmL61eQIUrCUD50ruvU0vLhQSjaR09HGHbr+0Nrsz
	 yrr8LtyrEGHqqV5OS+pISdePuPpB67lufpz0qmV6cLjyRSFhAws+vVtI9r5MO6iiJ3QaF
	 1vikI7urXoMoKDK+Xmh1nN8Tlb0TyBpP4pa5jfektrB28tEBCJB0H5ZjZexz9vPy5sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417313;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=y9Z+7orzJdSx58L4lqUe9cGolgKUXKFkRTuN7SA8P9w=;
	b=cg9WVKCYHIjngi0dCUQm/la/rVPHbRz2pyQ30ztaW8uqTR2NecQ0Txw+A9g434JOzuMK
	 t52QekjTGyE72X+SX17b/EwoUzdSXmZsw8+h78eN5rP9i3OlT1A4/rIdRvyIamRqyo10m
	 v5HSFmYeFHRSns1B+P4boca/WsGXEcJHpPBUuFSDtlnHJFXg8NxEGnK2DNzmXcdASVwsF
	 AWd55kPwOn7bLcFpwmExnrRMClIXrLRgyXWWexNjnRURifxiYR/Q4yxiC1PlKFkYq1rWw
	 TyFPbd35Qpp2Q+oRgcM0oFafaZ8J6tCD1a+Qsrjk+WKA+jj5/Up7H2N3rjBYkc3/obA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Jvb50AXx;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8FB606A326
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 17:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E8FB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Jvb50AXx
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDE101576;
	Wed, 11 Nov 2026 09:15:07 -0800 (PST)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9914B3F632;
	Wed, 11 Nov 2026 09:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794417310; bh=2McGIo0I0qUn9Z5Bkhx58ruHvjbNzDromBqTIw7cA/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jvb50AXxGnQj9GSO/QAEN0TazkCWaZ2N/9XsGCnE/0y+001MSDX3Em9LlDYbwWLNr
	 QRDX5Hvi6PR46zWdXB3NvONbRrGlXeIODQnhFpC2TzOqBoUZ6eYJfpjZ9s38QMUWTJ
	 h5VqXB7zhPj4AiQnK6JXy4lYVlq3qKZ2O2qQgOvU=
Date: Wed, 11 Nov 2026 17:14:48 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: maz@kernel.org, oupton@kernel.org, fuad.tabba@linux.dev,
	joey.gouly@arm.com, seiden@linux.ibm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, will@kernel.org, mark.rutland@arm.com,
	linux-perf-users@vger.kernel.org, catalin.marinas@arm.com,
	james.clark@linaro.org
Subject: Re: [RFC PATCH v7 02/28] arm64/sysreg: Define MDCR_EL2.E2PB values
Message-ID: <avSiiFvN13FqNCDm@raptor>
References: <20260903160623.315525-1-alexandru.elisei@arm.com>
 <20260903160623.315525-3-alexandru.elisei@arm.com>
 <atDUMAe0QGP_4swk@gremlin>
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
In-Reply-To: <atDUMAe0QGP_4swk@gremlin>

Hi Lorenzo,

On Thu, Oct 15, 2026 at 02:52:32PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Thu, Sep 03, 2026 at 05:05:57PM +0100, Alexandru Elisei wrote:
> > KVM will make use of the different values for MDCR_EL2.E2PB, document them.
> 
> As with 1/28, using [0] to check the definition of the register.
> 
> >
> > Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> 
> Looks correct, a couple small nits below, with those addressed:
> 
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> 
> > ---
> >  arch/arm64/tools/sysreg | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> > index a11a968eb707..4485736a4f49 100644
> > --- a/arch/arm64/tools/sysreg
> > +++ b/arch/arm64/tools/sysreg
> > @@ -4045,7 +4045,12 @@ Field	17	HPMD
> >  Res0	16
> >  Field	15	EnSPM
> >  Field	14	TPMS
> > -Field	13:12	E2PB
> > +UnsignedEnum	13:12 E2PB
> 
> MEGA NIT: Shouldn't there be a tab rather than a space after '13:12'? :)

Fixed.

> 
> > +	0b00	EL2
> 
> So broadly - this means EL2 owns the profiling buffer right?

Yes.

> 
> This seems to align with the document (which is very verbose, obviously :):
> 
> "If EL2 is implemented and enabled in the Profiling Buffer owning Security
> state, then the Profiling Buffer owning Exception level is EL2. Otherwise,
> the Profiling Buffer owning Exception level is EL1 and, Profiling is
> prohibited at EL2."
> 
> "If EL2 is implemented and enabled in the current Security state, then
> accesses to Profiling Buffer System registers at EL1 are trapped to EL2,
> unless the access generates a higher priority exception."
> 
> > +	0b01	RESERVED
> 
> NIT: Hmm, it seems to be the convention to just omit entries that are
> missing from the definition in the docs? So is this needed?

Removed.

> 
> I see a couple named ones, e.g. in CTR_EL0.L1Ip:
> 
> 	# This was named as VPIPT in the ARM but now documented as reserved
> 	0b00	RESERVED_VPIPT
> 	# This is named as AIVIVT in the ARM but documented as reserved
> 	0b01	RESERVED_AIVIVT
> 
> Which have comments explaining why, i.e. they were defined before but are
> now reserved.
> 
> > +	0b10	EL1_TRAP
> 
> Again my understanding - EL1 owns the profiling buffer, but EL1 sysreg
> accesses trap to EL2?

Yes.

> 
> Seems to align with docs:
> 
> "Profiling Buffer owning Exception level is EL1. Profiling is prohibited at
> EL2."
> 
> "If EL2 is implemented and enabled in the current Security state, then
> accesses to Profiling Buffer System registers at EL1 are trapped to EL2,
> unless the access generates a higher priority exception."
> 
> > +	0b11	EL1
> 
> And finally - EL1, traps to EL1 too right?

Profiling buffer owning exception level is EL1, accesses to the profiling buffer
registers made at EL1 are not trapped.

For the exact trapping priority and possible trap configurations, you can have a
look at the pseudocode for accessing one of the profiling buffer system
registers (PMBSR_EL1, PMPTR_EL1 or PMBLIMITR_EL1).

> 
> Again seems to align with docs:
> 
> "Profiling Buffer owning Exception level is EL1. Profiling is prohibited at
> EL2."
> 
> "Accesses to Profiling Buffer System registers at EL1 are not trapped by
> this mechanism."
> 
> > +EndEnum
> >  Field	11	TDRA
> >  Field	10	TDOSA
> >  Field	9	TDA
> > --
> > 2.43.0
> >
> >
> 
> All LGTM!

Thanks,
Alex

> 
> --
> Cheers, Lorenzo
> 
> [0]:https://support.arm.com/documentation/ddi0601/2026-09/AArch64-Registers/MDCR-EL2--Monitor-Debug-Configuration-Register--EL2-?lang=en
