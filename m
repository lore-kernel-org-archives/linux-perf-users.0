Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831EC453A50
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Oct 2026 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373088; cv=none; b=sZLLm7tCxF3rJhRIVTBiCK2+aryZfLpJT7vmCW152yrTq/m1O32NJRocTwJbznSbNT8yXK6ANChvojyKg1YKnCRlAAK7hbV/BkduQoBbY5oEfFYJ5ocrVFfEPqHzHdUmD7T+niNrwR5c+sarQLYY2Ernv/41y9FAE1JnuW6XxJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373088; c=relaxed/simple;
	bh=DO/a0lT2Nc32dXrUH+Sg0aUDVWuTnZWLgHfFw5sdJvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqKcXVEWf7uqYNLvnLoAj+ixHyCKv2z+eruL7GhA0PrstY7ouTtiGj1PHwes07erCnxzLcJhH4zHKpARqQQ6CP4UO97BjqyJonVimJYfkxlY+2/AqCf/atooY10sKBOTvMhSrsVWRSRMHG+QuIybvX2Lsl4TPt5fjwUAowT7+e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=meUbvnwI; arc=none smtp.client-ip=139.138.36.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="meUbvnwI"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1791373065; x=1822909065;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=DO/a0lT2Nc32dXrUH+Sg0aUDVWuTnZWLgHfFw5sdJvE=;
  b=meUbvnwIIkyndUkKy/O2nls6KcNP/68WokeTWrkmaw4gJeB/h+zc/BsP
   XyCcnxTK5SQDjI6Rc/HlVb/ail5DEeybyodHyH12niOtOAit6LZjYb36J
   HEkyUeAnICY7bLe4gStJ3GXUN3F3aMBVbBi+i0SgOekEwyMFGH9HGion6
   eRoXVi0lH98N+XLIZ9CBnSuUjrbgBTPZF8j4qu8Cb6WW2xABPvOCemOpt
   qdKqtlEp+l9IoxeN9rGnuwaaRL+hVyxD7s6ePA500PoFd+62z/IZyo+Db
   +pwFVXJJ2mAcnHR8HfhpAfiWIiDovMNhAf08TZlIcMXAtf0DFzzTOEqkx
   Q==;
X-CSE-ConnectionGUID: YeH1rd/3TeGd7bFEtSiabA==
X-CSE-MsgGUID: j7QJGln3Q6SfIyvf839+YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="243683659"
X-IronPort-AV: E=Sophos;i="6.27,144,1786978800"; 
   d="scan'208";a="243683659"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 20:37:38 +0900
Received: from az2uksmgm1.o.css.fujitsu.com (unknown [10.151.22.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id E3147C020F4
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Oct 2026 11:37:37 +0000 (UTC)
Received: from az2nlsmom3.fujitsu.com (unknown [10.150.26.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm1.o.css.fujitsu.com (Postfix) with ESMTPS id 96562896E1C
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Oct 2026 11:37:37 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.8.35.186])
	by az2nlsmom3.fujitsu.com (Postfix) with ESMTP id 11A24101E521;
	Wed,  7 Oct 2026 11:37:34 +0000 (UTC)
Date: Wed, 7 Oct 2026 20:37:33 +0900
From: Kohei Enju <enju.kohei@fujitsu.com>
To: sashiko-reviews@lists.linux.dev
Cc: Tomohiro Misono <misono.tomohiro@fujitsu.com>, 
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 4/4] irqchip/gicv3: Add workaround for FUJITSU-MONAKA
 erratum E#030003
Message-ID: <asYsHLoeNtc-sESV@FCCLS0092175.localdomain>
References: <20261002-monaka-fix-for-upstream-v1-0-4aec0b0cbe34@fujitsu.com>
 <20261002-monaka-fix-for-upstream-v1-4-4aec0b0cbe34@fujitsu.com>
 <20261002104108.8669D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261002104108.8669D1F000FF@smtp.kernel.org>

On 10/02 10:41, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] irqchip/gicv3: CONSTRAINED UNPREDICTABLE access to sleeping redistributor
> --
> 
> commit d6fd070c2b4a77ad65839152f8e6343482132aff
> Author: Kohei Enju <enju.kohei@fujitsu.com>
> 
> irqchip/gicv3: Add workaround for FUJITSU-MONAKA erratum E#030003
> 
> This commit adds a workaround for FUJITSU-MONAKA erratum E#030003, where
> SGIs generated by system register writes may be lost. The workaround changes
> the IPI delivery mechanism to write directly to the target CPU's
> GICR_ISPENDR0 register instead of using ICC_SGI1R_EL1.
> 
> [ ... ]
> 
> > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> > index 6e1fa5b247fc4..e73fea8a0e279 100644
> > --- a/drivers/irqchip/irq-gic-v3.c
> > +++ b/drivers/irqchip/irq-gic-v3.c
> [ ... ]
> > @@ -1373,6 +1378,13 @@ static void gic_send_sgi(u64 cluster_id, u16 tlist, unsigned int irq)
> >  	gic_write_sgi1r(val);
> >  }
> >  
> > +static void gic_send_sgi_via_rdist(int cpu, unsigned int irq)
> > +{
> > +	void __iomem *base = gic_data_rdist_sgi_base_cpu(cpu);
> > +
> > +	writel_relaxed(BIT(irq), base + GICR_ISPENDR0);
> 
> [Severity: High]
> Does this access handle the case where the target CPU is in deep idle
> (ProcessorSleep == 1)?
> 
> The GICv3 architecture mandates that accessing GICR_ registers (other than
> GICR_WAKER) while ProcessorSleep == 1 is constrained unpredictable.

I could not find such a restriction in the GICv3/v4 architecture
specification.

Section 11.1 states that, when GICR_WAKER.ProcessorSleep == 1 or
GICR_WAKER.ChildrenAsleep == 1 then a write to any GICC_*, GICV_*,
GICH_*, ICC_*, ICV_*, or ICH_* registers, other than those in the
following list, is unpredictable:
- ICC_SRE_EL1.
- ICC_SRE_EL2.
- ICC_SRE_EL3.

Therefore, this finding appears to be based on the incorrect assumption
that accessing GICR_* while ProcessorSleep == 1 is constrained
unpredictable. I believe this is a false positive.

> 
> When a CPU enters deep idle, gic_enable_redist(false) sets
> GICR_WAKER_ProcessorSleep. If another CPU sends an IPI to this idle CPU
> (e.g., a scheduler wake-up), it executes gic_send_sgi_via_rdist() which
> directly writes to the sleeping redistributor's MMIO register.
> 
> Bypassing ICC_SGI1R_EL1 and writing directly to GICR_ISPENDR0 could break
> standard IPI delivery to idle CPUs by either causing a synchronous external
> abort or dropping the IPI.
> 
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261002-monaka-fix-for-upstream-v1-0-4aec0b0cbe34@fujitsu.com?part=4
