Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FDB3839BD;
	Tue,  6 Oct 2026 09:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791277718; cv=none; b=PcAMNSFK7oWSVAAaTSTfXFHbvElvhCbdy7Mw/Rjr2lexlzXCS+kOBHN0U3arC5nE5TgodifJAM21ouNH8CwwvrsrjCDLafOkBeg6me6lAc54C2rM/1/rzyj6xvl3RQqCx9F8kSETnYVaEiwILa0AzNkkB1GORU+4IVcge5r4sBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791277718; c=relaxed/simple;
	bh=F4/2ziFaQ+14aJz8mQUHdsabipvtJe9Jxq46ZQmJerg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUOZYCkwBsVuGcS8l+ykHtITxXNJyMwG5nSWsPThJewqy8JyFEmIy48VJDYPiLh9Jyc/05rsTm2XCTrwFEebkCkMvn52tpjIzkeyZB4BqYyZqP60hn15fnFG77UryzzKLlX3yYwV+czRXnmeUzcE4QEdDadj6+ssFsFpa7x/750=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=grF1s9SQ; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="grF1s9SQ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1791277716; x=1822813716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F4/2ziFaQ+14aJz8mQUHdsabipvtJe9Jxq46ZQmJerg=;
  b=grF1s9SQ7r3HIj/kGSsPKaYkNqh/r8qXA5DcXClNqSfkxOneG79+swiA
   xQy8FUwYi8LjNRl/5kpRupvRvmi1GIbPDvqruaC9UvnnH0iAZtnDtTQA/
   yX473h4uKIZlEPyGSTiUGtHkwGgFFmzs37u5K3/tH1AqIG5o0r1N7G7Fs
   vkMY3VDaYA9ZLyyOk//KQr/w7vwQdrYLJLCzEUqnQ6xbflqAqeN+RLc2t
   /neJOT5zRzFTWhqivky3r/dX6WW8VdqaRVnOrJUXCgHvhAalyeNrZu1cZ
   8e+IGUfia4zTry4+6HxF6D4jo5jAfinH1MB/odkV65yGTJCPubg5MEjz/
   Q==;
X-CSE-ConnectionGUID: CyrKHvuWToK1ES1DJ8nzXQ==
X-CSE-MsgGUID: RkJRpu/eQWeJO87xh4O9xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="235074054"
X-IronPort-AV: E=Sophos;i="6.27,143,1786978800"; 
   d="scan'208";a="235074054"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 18:08:28 +0900
Received: from az2nlsmgm3.fujitsu.com (unknown [10.150.26.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id EEC28406126;
	Tue,  6 Oct 2026 09:08:27 +0000 (UTC)
Received: from az2nlsmom4.fujitsu.com (unknown [10.150.26.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm3.fujitsu.com (Postfix) with ESMTPS id 9E8571800336;
	Tue,  6 Oct 2026 09:08:27 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.10.34.24])
	by az2nlsmom4.fujitsu.com (Postfix) with SMTP id 0228720002A7;
	Tue,  6 Oct 2026 09:08:21 +0000 (UTC)
Date: Tue, 6 Oct 2026 18:08:19 +0900
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
Message-ID: <asS5r0WNCQpMIo4p@FCCLS0092175.localdomain>
References: <20261002-monaka-fix-for-upstream-v1-0-4aec0b0cbe34@fujitsu.com>
 <20261002-monaka-fix-for-upstream-v1-4-4aec0b0cbe34@fujitsu.com>
 <86tsn42sqr.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86tsn42sqr.wl-maz@kernel.org>

On 10/02 13:26, Marc Zyngier wrote:
> On Fri, 02 Oct 2026 11:26:52 +0100,
> Tomohiro Misono <misono.tomohiro@fujitsu.com> wrote:
> > 
> > From: Kohei Enju <enju.kohei@fujitsu.com>
> > 
> > On affected FUJITSU-MONAKA CPUs, an SGI generated by writing to
> > ICC_SGI0R_EL1, ICC_SGI1R_EL1, or ICC_ASGI1R_EL1 may be lost if the
> > operation races with CPU interface processing triggered by the arrival
> > of a higher-priority interrupt, an update to a pending interrupt, or a
> > transition of the PE to the Sleep state. When this occurs, the system
> > register write does not complete, causing the issuing core to hang.
> >
> 
> Is the SGI lost? Or is the sender core hanging?

Both: the SGI is lost, and the sysreg write does not complete, causing
the sending core to hang.

> 
> I expect that virtualised accesses to these registers are not
> affected, since they trap, but it'd be good to document this.

You're right. I'll document it in v2.

> 
> > Work around the erratum by writing 1 to the bit corresponding to the
> > target SGI INTID in GICR_ISPENDR0 of each target PE's GIC Redistributor,
> > instead of writing to the affected system registers.
> > 
> > The affinity topology of affected systems has Aff0 == 0 for every PE,
> > with PEs distinguished by higher affinity levels. Consequently, an
> > ICC_SGI1R_EL1 write can target only one PE, so the workaround does not
> > increase the number of writes required to send an SGI to multiple PEs.
> >
> > Accessing a target PE's GICR_ISPENDR0 requires its Redistributor base to
> > have been discovered. Affected platforms conform to SBBR, which requires
> > PSCI for secondary CPU boot. They therefore do not use the ACPI Parking
> > protocol, which sends an IPI before the secondary CPU has initialized
> > its Redistributor. With PSCI, a secondary CPU discovers its
> > Redistributor before becoming an IPI target.
> > 
> > Signed-off-by: Kohei Enju <enju.kohei@fujitsu.com>
> > ---
> >  Documentation/arch/arm64/silicon-errata.rst |  2 ++
> >  drivers/irqchip/irq-gic-v3.c                | 48 +++++++++++++++++++++++++++++
> >  2 files changed, 50 insertions(+)
> > 
> > diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
> > index 429bdf9a3d9d..13328a30df59 100644
> > --- a/Documentation/arch/arm64/silicon-errata.rst
> > +++ b/Documentation/arch/arm64/silicon-errata.rst
> > @@ -377,6 +377,8 @@ stable kernels.
> >  +----------------+-----------------+-----------------+-----------------------------+
> >  | Fujitsu        | MONAKA          | E#030002        | FUJITSU_ERRATUM_030002      |
> >  +----------------+-----------------+-----------------+-----------------------------+
> > +| Fujitsu        | MONAKA GICv3/v4 | E#030003        | N/A                         |
> > ++----------------+-----------------+-----------------+-----------------------------+
> >  +----------------+-----------------+-----------------+-----------------------------+
> >  | ASR            | ASR8601         | #8601001        | N/A                         |
> >  +----------------+-----------------+-----------------+-----------------------------+
> > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> > index 6e1fa5b247fc..e73fea8a0e27 100644
> > --- a/drivers/irqchip/irq-gic-v3.c
> > +++ b/drivers/irqchip/irq-gic-v3.c
> > @@ -80,6 +80,8 @@ static DEFINE_STATIC_KEY_FALSE(gic_nvidia_t241_erratum);
> >  
> >  static DEFINE_STATIC_KEY_FALSE(gic_arm64_2941627_erratum);
> >  
> > +static DEFINE_STATIC_KEY_FALSE(gic_fujitsu_030003_erratum);
> > +
> >  static struct gic_chip_data gic_data __read_mostly;
> >  static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
> >  
> > @@ -238,6 +240,9 @@ static DEFINE_PER_CPU(bool, has_rss);
> >  #define gic_data_rdist()		(this_cpu_ptr(gic_data.rdists.rdist))
> >  #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
> >  #define gic_data_rdist_sgi_base()	(gic_data_rdist_rd_base() + SZ_64K)
> > +#define gic_data_rdist_cpu(cpu)		(per_cpu_ptr(gic_data.rdists.rdist, cpu))
> > +#define gic_data_rdist_rd_base_cpu(cpu)	(gic_data_rdist_cpu(cpu)->rd_base)
> > +#define gic_data_rdist_sgi_base_cpu(cpu)	(gic_data_rdist_rd_base_cpu(cpu) + SZ_64K)
> >  
> >  /* Our default, arbitrary priority value. Linux only uses one anyway. */
> >  #define DEFAULT_PMR_VALUE	0xf0
> > @@ -1373,6 +1378,13 @@ static void gic_send_sgi(u64 cluster_id, u16 tlist, unsigned int irq)
> >  	gic_write_sgi1r(val);
> >  }
> >  
> > +static void gic_send_sgi_via_rdist(int cpu, unsigned int irq)
> > +{
> > +	void __iomem *base = gic_data_rdist_sgi_base_cpu(cpu);
> > +
> > +	writel_relaxed(BIT(irq), base + GICR_ISPENDR0);
> > +}
> > +
> 
> I don't think there is any need for a helper, given that there is a
> single caller.

Ack.

> 
> >  static void gic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
> >  {
> >  	int cpu;
> > @@ -1386,6 +1398,22 @@ static void gic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
> >  	 */
> >  	dsb(ishst);
> >  
> > +	if (static_branch_unlikely(&gic_fujitsu_030003_erratum)) {
> > +		/*
> > +		 * The affinity topology of affected systems has Aff0 == 0 for
> > +		 * every PE; PEs are distinguished by higher affinity levels.
> > +		 * ICC_SGI1R_EL1 therefore targets only one PE per write, so
> > +		 * using GICR_ISPENDR0 does not increase the number of writes
> > +		 * required to send an SGI to multiple PEs.
> 
> This is not about the number of writes, but the cost of individual
> writes. A sysreg access is almost free (at least it is on decent
> implementations), while an MMIO access is probably one of the worst
> offenders. Therefore implying that there is no extra overhead is
> likely to be misleading. The commit message has the same problem.
> 
> In any case, I don't think you need to justify anything here, as the
> choice between costly SGIs and a dead CPU is pretty moot.

Ack. I'll remove the comment and the corresponding explanation from the
commit message.

For context, on this implementation, we do not expect a significant
latency difference between the MMIO and system register accesses, as
both ultimately reach the same hardware block.

> 
> > +		 */
> > +		for_each_cpu(cpu, mask)
> > +			gic_send_sgi_via_rdist(cpu, d->hwirq);
> > +
> > +		/* Force the above writes to GICR_ISPENDR0 to be executed */
> > +		dsb(st);
> 
> This doesn't force things to be executed. This is about completion of
> the access, and with an nGnRE mapping, it doesn't enforce that the
> stores actually reach the RDs, only an arbitrary point in the memory
> subsystem.  The only way to guarantee this is to perform a read-back.

Understood.

I hadn't considered this when writing v1, but on further reflection, I
don't think gic_ipi_send_mask() needs to wait for the target CPUs to
handle the IPIs. Given that the GICv2 driver does not wait for MMIO
write completion either, I don't think we need to ensure completion of
these writes before returning. 

If my understanding is correct, I'll remove the dsb(st) in v2.

> 
> If this is relying on some additional properties that are
> implementation specific, then this requires to be documented (for
> example, if the implementation treats nGnRE as nGnRnE).
> 
> > +		return;
> > +	}
> > +
> >  	for_each_cpu(cpu, mask) {
> >  		u64 cluster_id = MPIDR_TO_SGI_CLUSTER_ID(gic_cpu_to_affinity(cpu));
> >  		u16 tlist;
> > @@ -1871,6 +1899,20 @@ static bool gic_enable_quirk_rk3399(void *data)
> >  	return false;
> >  }
> >  
> > +#define SMCCC_SOC_ID_FUJITSU_MONAKA	0x00040003
> > +
> > +static bool gic_enable_quirk_fujitsu_030003(void *data)
> > +{
> > +	s32 soc_id = arm_smccc_get_soc_id_version();
> > +
> > +	/* Check JEP106 code for FUJITSU-MONAKA chip (0004:0003) */
> > +	if (soc_id != SMCCC_SOC_ID_FUJITSU_MONAKA)
> > +		return false;
> 
> Why is this keyed on some firmware interface, while it is the CPU
> interface that is at fault? I'd expect that looking at the MIDR would
> be more reliable.

Ack.

> 
> > +
> > +	static_branch_enable(&gic_fujitsu_030003_erratum);
> > +	return true;
> > +}
> > +
> >  static bool rd_set_non_coherent(void *data)
> >  {
> >  	struct gic_chip_data *d = data;
> > @@ -1951,6 +1993,12 @@ static const struct gic_quirk gic_quirks[] = {
> >  		.mask	= 0xff000fff,
> >  		.init	= gic_enable_quirk_rk3399,
> >  	},
> > +	{
> > +		.desc	= "GICv3: Fujitsu erratum 030003",
> > +		.iidr	= 0x0403043b,
> > +		.mask	= 0xffffffff,
> > +		.init	= gic_enable_quirk_fujitsu_030003,
> 
> Same problem. This is looking that the distributor instead of the CPU.
> It's OK to use it as a proxy for further filtering, but the final
> decision should probably rest on the MIDR.

Ack. I'll use the MIDR instead of the SoC ID.

Thanks,
Kohei

> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
