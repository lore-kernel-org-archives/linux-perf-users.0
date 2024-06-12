Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC9484A56;
	Wed, 12 Jun 2024 20:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718223760; cv=none; b=B7YbD/n0hli7TB/0P78b7IFKGtrElT5bZoF/ts+Fncve4lES73zWKnQxBcqSxmBzozNDne0ZRFHUABXmFdhPpPXDAGJ+6kIAf+Dz+IutxBWLmeV4HMw3FknD/LrhYJ6AxtrvTaOO7lOFb28IZ5SNE4bPBYdhccVv8FKN/6nXNpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718223760; c=relaxed/simple;
	bh=8WTD6sYve58aB6+RW7KFovQtTgqjvA9DP8iUKon4+mA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n6Pb7TU0m1AECL8gfRkcz2bnFWf+YCKUs/V9ZvAP05DYdNSUNl7H/OhPk8m3xhVQctO3UIH2hGphLeklxlSM6fo0f4IRCfVUkLOCn2TRs/WW8efuCc4Kq/4KEb9PNPLmtE3bhVQzhctGZEI17xfLGFtTV/JpVXQFyhyvjxP+MbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=igmSRE9K; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="igmSRE9K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718223759; x=1749759759;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8WTD6sYve58aB6+RW7KFovQtTgqjvA9DP8iUKon4+mA=;
  b=igmSRE9KuZZI71SEX5gbREGV1TbLt8b8RtjA8YHhISKjaHYK3qQ1ZCpa
   EuU0YsVbYfZmzmHimSPsS3iRyL40Srf/fK+70FmHZdh+T5rliZYVufBdb
   3EkHnL8f/OTvoaaG8VXdJW4PfD3mU+3qp9eyeP6FfwKvNQPJ8ZJ4QZFwv
   RMcZfGxwCmGMZfNnAs12NEOHI6RnkzHI200Z5AEHLhdrvmp6O6Ph4Au1E
   GTU6n8WwzBvxDSZJsReAbbhFiuJ8FFDdd6sbmS4WieZcNPo0r4zyhwuhs
   82KzRbdgD7M3MzNT42psrIZHN3On1kMHXYR6nsyR/iIlXVLK2uumqNw2V
   w==;
X-CSE-ConnectionGUID: zDlTbO8GRSyfkSDqhJBpvw==
X-CSE-MsgGUID: 8gIT4jzSTWSsXES11It+5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="14974327"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="14974327"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 13:22:39 -0700
X-CSE-ConnectionGUID: iGF4IHCHRwOQDfhlcK79FA==
X-CSE-MsgGUID: 0lpd7zF+RReLIylyivdOTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="45028858"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 13:22:39 -0700
Date: Wed, 12 Jun 2024 13:27:41 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: X86 Kernel <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@intel.com>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Andi Kleen <andi.kleen@intel.com>, Xin Li <xin3.li@intel.com>, Zeng Guang
 <guang.zeng@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 5/6] perf/x86: Enable NMI source reporting for
 perfmon
Message-ID: <20240612132741.10f58458@jacob-builder>
In-Reply-To: <8afef909-974e-40fe-a39c-3c1e4e6d6938@zytor.com>
References: <20240611165457.156364-1-jacob.jun.pan@linux.intel.com>
	<20240611165457.156364-6-jacob.jun.pan@linux.intel.com>
	<8afef909-974e-40fe-a39c-3c1e4e6d6938@zytor.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi H.,

On Tue, 11 Jun 2024 12:10:52 -0700, "H. Peter Anvin" <hpa@zytor.com> wrote:

> On 6/11/24 09:54, Jacob Pan wrote:
> > 
> > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > index 1ef2201e48ac..db8c30881f5c 100644
> > --- a/arch/x86/events/core.c
> > +++ b/arch/x86/events/core.c
> > @@ -46,6 +46,7 @@
> >   
> >   struct x86_pmu x86_pmu __read_mostly;
> >   static struct pmu pmu;
> > +u32 apic_perfmon_ctr = APIC_DM_NMI;
> >   
> >   DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = {
> >   	.enabled = 1,
> > @@ -1680,7 +1681,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
> >   	 * This generic handler doesn't seem to have any issues where
> > the
> >   	 * unmasking occurs so it was left at the top.
> >   	 */
> > -	apic_write(APIC_LVTPC, APIC_DM_NMI);
> > +	apic_write(APIC_LVTPC, apic_perfmon_ctr);
> >   
> >   	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
> >   		if (!test_bit(idx, cpuc->active_mask))
> > @@ -1723,7 +1724,10 @@ void perf_events_lapic_init(void)
> >   	/*
> >   	 * Always use NMI for PMU
> >   	 */
> > -	apic_write(APIC_LVTPC, APIC_DM_NMI);
> > +	if (cpu_feature_enabled(X86_FEATURE_NMI_SOURCE))
> > +		apic_perfmon_ctr |= NMI_SOURCE_VEC_PMI;
> > +
> > +	apic_write(APIC_LVTPC, apic_perfmon_ctr);
> >   }
> >  
> There really is no reason to not do this unconditinoally. If NMI source 
> is not supported it is simply a noop.
Yes, will do.

I was being paranoid in case some old CPUs don't ignore the vector field.

Thanks,

Jacob
