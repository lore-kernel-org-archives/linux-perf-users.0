Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.139.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480830;
	b=wTPBvlpDkin0WELvvZuduQokCWUjQrcj3gQ1nnf1chWhGC18FnuHv8RN8yA84MdJFQ/d
	 k+NJzHhFhdK8srO429ugsYKm9NKjlkDsn/TomEk/mxnbu2PQVH9pkv1edkuhMlPrWEwZ7
	 lWz0xlFGD9SWBug+GbpYX+6izf7csJQLTXw9zUmFfxXuCop+wGDbDZhA66NR28fwsPByD
	 abwHtwC/R9aUt5qVvLsWVQny8hYD678tIhwdUg+TIU2LH2Z0YPsorBnWoj3n/dxNTnwiS
	 epNp5MkRn2sPoYnWESFMwrKRrIsOV9VWFl0694W/XMb8VDDmwH/1bEBvctmfHlSaKIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480830;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=gTfcY3KbdiQmLNtrA7EgWSIO5XWoep6EANOAU6klbBo=;
	b=RuJCzESweX6zJ5RJUNpDeWil8OcxAVZUkk7mljgFmFOGQ4y/EsaJKCix0bP/jznbhNXE
	 is3eZCBZksZ0JTaPgylCY32YdwM/HyLNvS8UX2SxWTjU8CyhucCPThRaXIYh9rpj7g+et
	 822gfprKbRPLz6825Pi4fEFna4MaR/pWPqZneDncQXDHv3pxY3h8x346G8wQFueKnxlw0
	 wnERsF7wtHxJ65IEn1MN05WKKEtgoS59RLsbZi6lBEvNAN8QNMCzsYUqCGs7rUu7vDsDe
	 /iyje3G0+FHQplfGroPqB6OWTrDYOhcBTbe5fhbZNPtNzmTuHJv5Igz3Q8M9y4y/S7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fujitsu.com;
	spf=pass smtp.mailfrom=fujitsu.com;
	dkim=pass header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=PYemcUmX;
	arc=none smtp.remote-ip=68.232.139.139
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11E6606A31C;
	Tue, 20 Oct 2026 07:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F11E6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=PYemcUmX
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1792480835; x=1824016835;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=refqq25nv2RRzQpG9iY5BlA9ExyL3HdRLNTWhTg6kFM=;
  b=PYemcUmXPW0BmI/cgOEC8b9cnv25SyMurrhu+/pIeoUybZGGZBQvGjKR
   ih6KTyHxlPs3cEuEgIWTz2ViwCx9jYowZcw+U/MLs9Ib8N/ihsdLw+g3E
   Wbxb5pn1Bf2dXfcp8fcAssOJVNNUBWYfqtNqKaDtKShsPc07bZbAVDERo
   es2s7NmqPTI0FLdbZaTRXqHNfBT62wA48sEjuBTqgvd27c4CBSzMQkk3R
   8qz9PX03yyuU1sGSgfm2g/lxZ6D6P215A/AHIaly7IX+r2ZPLOBEjHRzg
   RUDMV8YrmcqR0wrbr0xK8ttsEB2gKW+nXxI+oCExK+5jLUNNOrVzdgajq
   g==;
X-CSE-ConnectionGUID: w3yeoTuBQiii3Ruo/LeNdA==
X-CSE-MsgGUID: JEFuNt0nR0ahm1t3B5Ftdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="262734108"
X-IronPort-AV: E=Sophos;i="6.27,168,1786978800"; 
   d="scan'208";a="262734108"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 16:20:27 +0900
Received: from az2nlsmgm3.fujitsu.com (unknown [10.150.26.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 1C53242A30A;
	Tue, 20 Oct 2026 07:20:21 +0000 (UTC)
Received: from az2nlsmom4.fujitsu.com (unknown [10.150.26.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm3.fujitsu.com (Postfix) with ESMTPS id C158B18026C6;
	Tue, 20 Oct 2026 07:20:20 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.8.226.149])
	by az2nlsmom4.fujitsu.com (Postfix) with SMTP id A09772000281;
	Tue, 20 Oct 2026 07:20:13 +0000 (UTC)
Date: Tue, 20 Oct 2026 16:20:12 +0900
From: Kohei Enju <enju.kohei@fujitsu.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Tomohiro Misono <misono.tomohiro@fujitsu.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, Oliver Upton <oupton@kernel.org>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v2 4/4] irqchip/gicv3: Add workaround for FUJITSU-MONAKA
 erratum E#030003
Message-ID: <atcTtojPd1BSS8fr@FCCLS0092175.localdomain>
References: <20261016-monaka-fix-for-upstream-v2-0-fc7ede7f9f48@fujitsu.com>
 <20261016-monaka-fix-for-upstream-v2-4-fc7ede7f9f48@fujitsu.com>
 <87wlrg8qc7.wl-maz@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wlrg8qc7.wl-maz@kernel.org>

On 10/17 13:27, Marc Zyngier wrote:
> On Fri, 16 Oct 2026 11:00:48 +0100,
> Tomohiro Misono <misono.tomohiro@fujitsu.com> wrote:
> > 
> > From: Kohei Enju <enju.kohei@fujitsu.com>
> > 
> > On affected FUJITSU-MONAKA CPUs, the erratum may occur when an SGI is
> > generated by writing to ICC_SGI0R_EL1, ICC_SGI1R_EL1, or ICC_ASGI1R_EL1,
> > if the operation races with CPU interface processing triggered by the
> > arrival of a higher-priority interrupt, an update to a pending
> > interrupt, or a transition of the PE to the Sleep state. When the
> > erratum occurs, the SGI is lost and the system register write does not
> > complete, causing the issuing core to hang.
> > 
> > Guest accesses to these registers are not affected by this erratum, as
> > they are trapped to EL2 and handled without issuing the affected system
> > register write.
> > 
> > Work around the erratum by writing 1 to the bit corresponding to the
> > target SGI INTID in GICR_ISPENDR0 of each target PE's GIC Redistributor,
> > instead of writing to the affected system registers.
> > 
> > Accessing a target PE's GICR_ISPENDR0 requires its Redistributor base to
> > have been discovered. Affected platforms conform to SBBR, which requires
> > PSCI for secondary CPU boot. They therefore do not use the ACPI Parking
> > protocol, which sends an IPI before the secondary CPU has initialized
> > its Redistributor. With PSCI, a secondary CPU discovers its
> > Redistributor before becoming an IPI target.
> > 
> > Signed-off-by: Kohei Enju <enju.kohei@fujitsu.com>
> 
> You are posting a patch on behalf of someone else, you need to add
> your own SoB:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v7.3-rc7#n448

Thanks for pointing this out. I'll let Tomohiro know.

> 
> > ---
> > Changes in v2:
> > - Clarify the erratum description and document that virtual accesses are
> >   unaffected.
> > - Remove the gic_send_sgi_via_rdist() helper.
> > - Remove the write-count rationale.
> > - Use the CPU MIDR instead of the SoC ID for filtering.
> > 
> > Note that I have left the dsb(st) after the GICR_ISPENDR0 writes
> > unchanged, pending clarification of the required completion point. If
> > the writes must be observed by a specific component before
> > gic_ipi_send_mask() returns, I will use the appropriate mechanism to
> > provide that guarantee.
> 
> See below.
> 
> [...]
> 
> > @@ -1386,6 +1391,17 @@ static void gic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
> >  	 */
> >  	dsb(ishst);
> >  
> > +	if (static_branch_unlikely(&gic_fujitsu_030003_erratum)) {
> > +		for_each_cpu(cpu, mask) {
> > +			void __iomem *base = gic_data_rdist_sgi_base_cpu(cpu);
> > +
> > +			writel_relaxed(BIT(d->hwirq), base + GICR_ISPENDR0);
> > +		}
> > +
> > +		dsb(st);
> 
> What is this DSB achieving? As far as I can tell, not much. The memory
> type is nGnRE, so DSB doesn't force writes to reach the end-point, and
> only guarantee ordering that system register SGI generation doesn't
> provide.

Yes, you're right.

> 
> So either
> 
> (a) there is a functional requirement on this HW to have a DSB, and
>     needs to be documented,
> 
> (b) or there is a need for end-point synchronisation, which needs to
>     be enforced by a read back (knowing that the sysreg doesn't
>     provide this guarantee), and this needs to be documented,
> 
> (c) or this is completely superfluous and can be dropped
> 
> Which case are we in?

I think this falls under (c). As far as I can tell, there is no
requirement for ipi_send_mask() to wait for the writes to be observed by
the hardware. I'm not aware of any hardware-specific requirements for
this DSB either. I'll drop the DSB and test the change on our hardware.

Thanks,
Kohei
