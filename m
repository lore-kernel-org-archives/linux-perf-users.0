Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CB43EF0BE;
	Thu, 15 Oct 2026 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047513; cv=none; b=DLJzJkorJNq1npC8zvWvinS7GguDgzmCdpm1dN3MAKvi4X8UsZGx8kpafLyUuSpr30RfLqey/CLndcQSCP633EozIDGHEfHCF9MsAl9JQmxCT0sEmPci+E5SbiIT1mgxtVq6Y/a4ocqlTbFC1dOqSVmKY0V10GHMotKiq9SJ4WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047513; c=relaxed/simple;
	bh=6crGBfKNi73PeQjC9z/ZUIYzlXDzPo55Yd+1Y0VGCww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9au/Xm59un50wfQcK/EGaEmjvZt4t1ZTsBopOMCWPSH/mpglQ8CcGhfdQw6d1T8cg4XCBYubYsG2v5hdFpuPyqDYOFZDoU2x8zUB1Zd7WxNa2Agh6LY+x3Q09dcQmJXg+LTw0Uv8+1eQcDybHi2n3l7bNCGkHQev63cxPb1/yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Wb6s3g5C; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Wb6s3g5C"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1792047507; x=1823583507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6crGBfKNi73PeQjC9z/ZUIYzlXDzPo55Yd+1Y0VGCww=;
  b=Wb6s3g5CVHWNagJTWn1Rrsw8AxuBUHsQJndI3wrbk2DkS12O7P2pufYx
   5FSgTcezsJ9FodHjwRmi9f10qRa0YdNRTI56QF52gbE2lRNyzHa4lAW43
   ACMkc+4qeVBer8CnoDiIzLcm98fi+RiVaVXCcR5JIsGSlmjroAhrG2zcY
   Kzs78gTsi7bea7K7e5oqsMLlhWqWBpmEYnQ97h2eD+0E5M9OQK48pYfQh
   Bl8hO2iUbp7vGA62VmowVh/BQESR7cfR1MJ8w6ho7jr0FuFwU1urahg+V
   U7woLghvWcvI9FkbRlVNHVRquC/KK7UIMIdCSG1AWkssk0gsJ0mKdp54R
   A==;
X-CSE-ConnectionGUID: 5Qx/URfMSRmFPn37IyxpTQ==
X-CSE-MsgGUID: VTcKqDlwT2+h/GVTyJP2Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="256490962"
X-IronPort-AV: E=Sophos;i="6.27,159,1786978800"; 
   d="scan'208";a="256490962"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 15:58:24 +0900
Received: from az2uksmgm1.o.css.fujitsu.com (unknown [10.151.22.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id 77715C023E8;
	Thu, 15 Oct 2026 06:58:24 +0000 (UTC)
Received: from az2uksmom2.o.css.fujitsu.com (unknown [10.151.22.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm1.o.css.fujitsu.com (Postfix) with ESMTPS id 2D27792675F;
	Thu, 15 Oct 2026 06:58:24 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.8.129.144])
	by az2uksmom2.o.css.fujitsu.com (Postfix) with SMTP id 2DA60140011B;
	Thu, 15 Oct 2026 06:58:18 +0000 (UTC)
Date: Thu, 15 Oct 2026 15:58:16 +0900
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
Message-ID: <atB4BkUqPnGJs7yR@FCCLS0092175.localdomain>
References: <20261002-monaka-fix-for-upstream-v1-0-4aec0b0cbe34@fujitsu.com>
 <20261002-monaka-fix-for-upstream-v1-4-4aec0b0cbe34@fujitsu.com>
 <86tsn42sqr.wl-maz@kernel.org>
 <asS5r0WNCQpMIo4p@FCCLS0092175.localdomain>
 <878q4b2mj5.wl-maz@kernel.org>
 <asX5CiaDodoFrn0q@FCCLS0092175.localdomain>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <asX5CiaDodoFrn0q@FCCLS0092175.localdomain>

On 10/07 17:17, Kohei Enju wrote:
> Hi Marc,
> 
> On 10/06 10:42, Marc Zyngier wrote:
> > On Tue, 06 Oct 2026 10:08:19 +0100,
> > Kohei Enju <enju.kohei@fujitsu.com> wrote:
> > > 
> > > On 10/02 13:26, Marc Zyngier wrote:
> > > > On Fri, 02 Oct 2026 11:26:52 +0100,
> > > > Tomohiro Misono <misono.tomohiro@fujitsu.com> wrote:
> > > > > 
> > > > > From: Kohei Enju <enju.kohei@fujitsu.com>
> > > > > 
> > > > > On affected FUJITSU-MONAKA CPUs, an SGI generated by writing to
> > > > > ICC_SGI0R_EL1, ICC_SGI1R_EL1, or ICC_ASGI1R_EL1 may be lost if the
> > > > > operation races with CPU interface processing triggered by the arrival
> > > > > of a higher-priority interrupt, an update to a pending interrupt, or a
> > > > > transition of the PE to the Sleep state. When this occurs, the system
> > > > > register write does not complete, causing the issuing core to hang.
> > > > >
> > > > 
> > > > Is the SGI lost? Or is the sender core hanging?
> > > 
> > > Both: the SGI is lost, and the sysreg write does not complete, causing
> > > the sending core to hang.
> > 
> > I don't think the two are distinguishable. You might want to simplify
> > the commit message to simply say that the CPU hangs.
> > 
> > [...]
> > 
> > > > > +		 */
> > > > > +		for_each_cpu(cpu, mask)
> > > > > +			gic_send_sgi_via_rdist(cpu, d->hwirq);
> > > > > +
> > > > > +		/* Force the above writes to GICR_ISPENDR0 to be executed */
> > > > > +		dsb(st);
> > > > 
> > > > This doesn't force things to be executed. This is about completion of
> > > > the access, and with an nGnRE mapping, it doesn't enforce that the
> > > > stores actually reach the RDs, only an arbitrary point in the memory
> > > > subsystem.  The only way to guarantee this is to perform a read-back.
> > > 
> > > Understood.
> > > 
> > > I hadn't considered this when writing v1, but on further reflection, I
> > > don't think gic_ipi_send_mask() needs to wait for the target CPUs to
> > > handle the IPIs.
> > 
> > It's not about the target CPU handling the IPI, that'd be crazy. It is
> > about making sure that the IPI request has been observed by the HW and
> > that it is not going to race with something else.
> > 
> > > Given that the GICv2 driver does not wait for MMIO
> > > write completion either, I don't think we need to ensure completion of
> > > these writes before returning.
> > 
> > GICv2 has different architectural requirements (i.e. none). GICv3 is a
> > bit clearer, see the requirements at the end of 12.1.3 in IHI0069H.b.
> > 
> > > 
> > > If my understanding is correct, I'll remove the dsb(st) in v2.
> > >
> > 
> > As indicated in the spec, you either need nGnRnE+DSB, or a read-back.
> > Given that Linux uses nGnRE for all device mappings, read-back is the
> > only option here.
> 
> I understand that section 12.1.3 describes how software can guarantee
> completion of a memory-mapped GIC write. With an nGnRE mapping, if the
> GICR_ISPENDR0 writes must complete before gic_ipi_send_mask() returns, a
> read-back from each target Redistributor is needed.
> 
> What I am trying to understand is whether completion at this point is an
> architectural requirement for this particular write, or a requirement of
> Linux's ipi_send_mask() interface.
> 
> I could not find an explicit completion requirement for ipi_send_mask()
> itself. The normal GICv3 path also appears to return after an ISB,
> without the DSB described in section 12.1.6 as necessary to guarantee
> that the associated Redistributor has observed the write. This is why I
> am unsure what completion guarantee is required here.
> 
> More specifically, I would like to understand:
> - What could an outstanding IPI request race with?
> - Which component must have observed the request before
>   gic_ipi_send_mask() returns: the CPU interface, the sending PE's
>   Redistributor, or the target Redistributor?
> 
> A pointer to the relevant architectural requirement or an example of
> such a race in Linux would help me understand why completion is needed
> here.

Hi Marc,

A gentle ping on this question. I am preparing v2 with the other review
comments addressed.

I would like to better understand the completion requirement so that I
can address this correctly in v2. In particular, could you clarify what
an outstanding IPI request could race with, and which component must
have observed the request before gic_ipi_send_mask() returns?

Any clarification would be appreciated.

Thanks,
Kohei
