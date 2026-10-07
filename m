Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8C7391835;
	Wed,  7 Oct 2026 08:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791361131; cv=none; b=aOM+Wx1ueVYXxUkqqP8Kdz3/lAWJ2sk69+1FRAILq5hf2que7s0GiqeagYo0C4GeAON/t49Wjv5ocVbKm7HKG+anJpuIhWl/y6pxO2dHVIZLgWkBwKrhRoOpaZXwCAbUjjtMzYDZFyf/hskWOdpQkuXy3fSxpxaTba/FrimXNkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791361131; c=relaxed/simple;
	bh=MyqC3h/MCGtGNFcHgQdVBKkmwX4hPvWFwf5yZpwYALk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGL/huHiZEVLQS88i7dEs96Pm+Slwk6AkCXTGgF/qWTVIPs4HqvTG1pGQvrFb0KtTCNlEH8xo9hkXpWNE8EzSwHzRRvY0BixLEQatA3XRooBsXUlMIV66Od6fXcBh+05Nz5B2GXVZNPeIC49fDcjdRBpXocFnOtbm1o80pV1f2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=VWFnsp1o; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="VWFnsp1o"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1791361134; x=1822897134;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MyqC3h/MCGtGNFcHgQdVBKkmwX4hPvWFwf5yZpwYALk=;
  b=VWFnsp1onXxat3U1/zrgRvN5Y8bjvOp5xGXpUdmNE8tfZSowZWuktVkD
   fQKXJpug57d49Bgnuieo+L8jjQeAhkCKgmGMtJmRstYVJhukiHWSQoOhp
   yKAtjk8k6WjRSsJlcq4zEp5FlWFBVeMxStEOWY6qFFMA/E8PMTGhazyBc
   OQuNPOxDezEvxL4II5YJs/DUNf0vcJiV90YmDuV2/EctMe6yE/8ex7l0A
   wLqKLnieIsUzBfozNa4msE3gyuM4IfFtHVX0b5wb21oH1FNoCHkIREYqw
   Q0x4HRJAaT51CodNdXWm6mRn+WcbLCtgbvi7RnWu5ADdniMZ+yr+KfqdV
   g==;
X-CSE-ConnectionGUID: a8D3CcJKQimngFF89Cwtvg==
X-CSE-MsgGUID: tNYKJC5HQ3u2MDVmrdoBOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="244987115"
X-IronPort-AV: E=Sophos;i="6.27,144,1786978800"; 
   d="scan'208";a="244987115"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 17:17:42 +0900
Received: from az2nlsmgm3.fujitsu.com (unknown [10.150.26.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 4B78D40613C;
	Wed,  7 Oct 2026 08:17:37 +0000 (UTC)
Received: from az2nlsmom4.fujitsu.com (unknown [10.150.26.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm3.fujitsu.com (Postfix) with ESMTPS id EFD9F18019BE;
	Wed,  7 Oct 2026 08:17:36 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.8.51.148])
	by az2nlsmom4.fujitsu.com (Postfix) with SMTP id 9AEAF2000AA7;
	Wed,  7 Oct 2026 08:17:31 +0000 (UTC)
Date: Wed, 7 Oct 2026 17:17:29 +0900
From: Kohei Enju <enju.kohei@fujitsu.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Tomohiro Misono <misono.tomohiro@fujitsu.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 4/4] irqchip/gicv3: Add workaround for FUJITSU-MONAKA
 erratum E#030003
Message-ID: <asX5CiaDodoFrn0q@FCCLS0092175.localdomain>
References: <20261002-monaka-fix-for-upstream-v1-0-4aec0b0cbe34@fujitsu.com>
 <20261002-monaka-fix-for-upstream-v1-4-4aec0b0cbe34@fujitsu.com>
 <86tsn42sqr.wl-maz@kernel.org>
 <asS5r0WNCQpMIo4p@FCCLS0092175.localdomain>
 <878q4b2mj5.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878q4b2mj5.wl-maz@kernel.org>

Hi Marc,

On 10/06 10:42, Marc Zyngier wrote:
> On Tue, 06 Oct 2026 10:08:19 +0100,
> Kohei Enju <enju.kohei@fujitsu.com> wrote:
> > 
> > On 10/02 13:26, Marc Zyngier wrote:
> > > On Fri, 02 Oct 2026 11:26:52 +0100,
> > > Tomohiro Misono <misono.tomohiro@fujitsu.com> wrote:
> > > > 
> > > > From: Kohei Enju <enju.kohei@fujitsu.com>
> > > > 
> > > > On affected FUJITSU-MONAKA CPUs, an SGI generated by writing to
> > > > ICC_SGI0R_EL1, ICC_SGI1R_EL1, or ICC_ASGI1R_EL1 may be lost if the
> > > > operation races with CPU interface processing triggered by the arrival
> > > > of a higher-priority interrupt, an update to a pending interrupt, or a
> > > > transition of the PE to the Sleep state. When this occurs, the system
> > > > register write does not complete, causing the issuing core to hang.
> > > >
> > > 
> > > Is the SGI lost? Or is the sender core hanging?
> > 
> > Both: the SGI is lost, and the sysreg write does not complete, causing
> > the sending core to hang.
> 
> I don't think the two are distinguishable. You might want to simplify
> the commit message to simply say that the CPU hangs.
> 
> [...]
> 
> > > > +		 */
> > > > +		for_each_cpu(cpu, mask)
> > > > +			gic_send_sgi_via_rdist(cpu, d->hwirq);
> > > > +
> > > > +		/* Force the above writes to GICR_ISPENDR0 to be executed */
> > > > +		dsb(st);
> > > 
> > > This doesn't force things to be executed. This is about completion of
> > > the access, and with an nGnRE mapping, it doesn't enforce that the
> > > stores actually reach the RDs, only an arbitrary point in the memory
> > > subsystem.  The only way to guarantee this is to perform a read-back.
> > 
> > Understood.
> > 
> > I hadn't considered this when writing v1, but on further reflection, I
> > don't think gic_ipi_send_mask() needs to wait for the target CPUs to
> > handle the IPIs.
> 
> It's not about the target CPU handling the IPI, that'd be crazy. It is
> about making sure that the IPI request has been observed by the HW and
> that it is not going to race with something else.
> 
> > Given that the GICv2 driver does not wait for MMIO
> > write completion either, I don't think we need to ensure completion of
> > these writes before returning.
> 
> GICv2 has different architectural requirements (i.e. none). GICv3 is a
> bit clearer, see the requirements at the end of 12.1.3 in IHI0069H.b.
> 
> > 
> > If my understanding is correct, I'll remove the dsb(st) in v2.
> >
> 
> As indicated in the spec, you either need nGnRnE+DSB, or a read-back.
> Given that Linux uses nGnRE for all device mappings, read-back is the
> only option here.

I understand that section 12.1.3 describes how software can guarantee
completion of a memory-mapped GIC write. With an nGnRE mapping, if the
GICR_ISPENDR0 writes must complete before gic_ipi_send_mask() returns, a
read-back from each target Redistributor is needed.

What I am trying to understand is whether completion at this point is an
architectural requirement for this particular write, or a requirement of
Linux's ipi_send_mask() interface.

I could not find an explicit completion requirement for ipi_send_mask()
itself. The normal GICv3 path also appears to return after an ISB,
without the DSB described in section 12.1.6 as necessary to guarantee
that the associated Redistributor has observed the write. This is why I
am unsure what completion guarantee is required here.

More specifically, I would like to understand:
- What could an outstanding IPI request race with?
- Which component must have observed the request before
  gic_ipi_send_mask() returns: the CPU interface, the sending PE's
  Redistributor, or the target Redistributor?

A pointer to the relevant architectural requirement or an example of
such a race in Linux would help me understand why completion is needed
here.

Thanks,
Kohei

> 
> Thanks,
> 
> 	M.
> 
> -- 
> Jazz isn't dead. It just smells funny.
