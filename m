Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF31163A9;
	Sun,  7 Jul 2024 03:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720323794; cv=none; b=t6KZtlBrGYMOEBKFdeCHs0O3jGiiTd3w6QF2K15JMYpfyjajeT/R9CTSRIziSR8V9U42w675k4bNhZ40JJLLkoCbveWthZ+KxQpvkHjsJwBXI/Tdpn0k+YWykL4Ia9KdIUmU9PihtEK4KpiKp/vlyASWHSmPMA8nwIaVwl15/P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720323794; c=relaxed/simple;
	bh=ghVROWVIc3c3/fThPWcJa4BMe5iC/W72kb0OfZCohb4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RLalEJGmEXklIO1mBrUr49c0YEEUporTVZ+a0RoWLacVnSvtbQdR68ZlGsAka3BrU00jRAFqM84PFsYUsdbs/dpARsT1Gg4rtSADWb8uZnRG92KJt/P16uZsq+/PQt8mVZXjED12jiD3ycXZzK6nnxedv0tGCuxCD23Am+f4fYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C4OxZvRQ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C4OxZvRQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720323793; x=1751859793;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ghVROWVIc3c3/fThPWcJa4BMe5iC/W72kb0OfZCohb4=;
  b=C4OxZvRQx+qPdpy1MM66XaMwJCbPtzzKgzbp4THZTnM45UnLl+jKEC68
   2p2TKTpdi6x3dJAmU6VRN8MnkjHX+6T4khJGUJqDi0O+PJaGsxXXhRgxa
   crn01O3pHh7VvRItZewQ+vfw6gdCkjcoVSq1cCfXoymfz8TjiJOwkZgIG
   +4pG01sykmdo3Z/GeOYf+w3v/YaTq1YenLYRkfbSBa4QeyTLk0tR8ZSl/
   dy8IeCNvWvvpwonG9YKnrUt17oIPQvVJhdvHa4mO9ghlBw9bqyDXLdmvC
   FRrf3UCbwz16exO59rCQXqyxeMfSZn3m4AcJq99Po7XUOglDH67cu63Yz
   g==;
X-CSE-ConnectionGUID: 0x7JrpbQREarfkA+THOdAA==
X-CSE-MsgGUID: erh0eyFLSfqy2CqpIpZ2Gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11125"; a="17683427"
X-IronPort-AV: E=Sophos;i="6.09,189,1716274800"; 
   d="scan'208";a="17683427"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 20:43:12 -0700
X-CSE-ConnectionGUID: IEsGSMbYT1qNjZBdXdu9Xg==
X-CSE-MsgGUID: fwRK/Zk0RL+OJ+G/vY46TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,189,1716274800"; 
   d="scan'208";a="47169545"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 20:43:12 -0700
Date: Sat, 6 Jul 2024 20:48:26 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Xin Li <xin@zytor.com>
Cc: X86 Kernel <x86@kernel.org>, Sean Christopherson <seanjc@google.com>,
 LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Xin Li
 <xin3.li@intel.com>, linux-perf-users@vger.kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, Tony Luck
 <tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>, acme@kernel.org,
 kan.liang@linux.intel.com, Andi Kleen <andi.kleen@intel.com>, "Mehta,
 Sohil" <sohil.mehta@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 05/11] x86/irq: Process nmi sources in NMI handler
Message-ID: <20240706204826.1eda1bcd@jacob-builder>
In-Reply-To: <3177880c-6538-4a18-bb2b-2926c69ef434@zytor.com>
References: <20240628201839.673086-1-jacob.jun.pan@linux.intel.com>
	<20240628201839.673086-6-jacob.jun.pan@linux.intel.com>
	<3177880c-6538-4a18-bb2b-2926c69ef434@zytor.com>
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


On Fri, 28 Jun 2024 20:39:24 -0700, Xin Li <xin@zytor.com> wrote:

> On 6/28/2024 1:18 PM, Jacob Pan wrote:
> > With NMI source reporting enabled, NMI handler can prioritize the
> > handling of sources reported explicitly. If the source is unknown, then
> > resume the existing processing flow. i.e. invoke all NMI handlers.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>  
> 
> The code looks good to me, however please improve coding styles and
> comments, see below.
> 
> > 
> > ---
> > v3:
> >     - Use a static flag to disable NMIs in case of HW failure
> >     - Optimize the case when unknown NMIs are mixed with known NMIs(HPA)
> > v2:
> >     - Disable NMI source reporting once garbage data is given in FRED
> > return stack. (HPA)
> > ---
> >   arch/x86/kernel/nmi.c | 73 +++++++++++++++++++++++++++++++++++++++++--
> >   1 file changed, 70 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
> > index 639a34e78bc9..c3a10af7f26b 100644
> > --- a/arch/x86/kernel/nmi.c
> > +++ b/arch/x86/kernel/nmi.c
> > @@ -149,23 +149,90 @@ static inline int do_handle_nmi(struct nmiaction
> > *a, struct pt_regs *regs, unsig return thishandled;
> >   }
> >   
> > +static int nmi_handle_src(unsigned int type, struct pt_regs *regs,
> > unsigned long *handled_mask) +{
> > +	static bool nmi_source_disabled;
> > +	bool has_unknown_src = false;
> > +	unsigned long source_bitmask;
> > +	struct nmiaction *a;
> > +	int handled = 0;
> > +	int vec = 1;
> > +
> > +	if (!cpu_feature_enabled(X86_FEATURE_NMI_SOURCE) ||
> > +	    type != NMI_LOCAL || nmi_source_disabled)  
> 
> Harder to read, no need to break into 2 lines.
ok.
 
> > +		return 0;
> > +
> > +	source_bitmask = fred_event_data(regs);
> > +	if (!source_bitmask) {  
> 
> unlikely()?
yes.

> 
> > +		pr_warn("NMI received without source information!
> > Disable source reporting.\n");  
> 
> It sounds you're disabling some hardware functionality. Better to say,
> maybe:
> 
> Buggy hardware? Disable NMI source handling.
> 
yes, this is more clear.

> > +		nmi_source_disabled = true;
> > +		return 0;
> > +	}
> > +
> > +	/*
> > +	 * Per NMI source specification, there is no guarantee that a
> > valid
> > +	 * NMI vector is always delivered, even when the source
> > specified
> > +	 * one. It is software's responsibility to check all available
> > NMI
> > +	 * sources when bit 0 is set in the NMI source bitmap. i.e. we
> > have  
> 
> s/i.e./I.e.,/
will fix

> 
> > +	 * to call every handler as if we have no NMI source.  
> 
> This comment is misleading, because you do skip NMI handlers with source
> bits set in polling.
At a high level, it is still accurate to say that every handler is invoked,
whether by the NMI-source handling code or subsequently in the polling code.

How about this:
	 * in the NMI-source reporting bitmap. I.e. we have to call every
	 * handler as if there is no NMI-source reporting feature enabled.
	 *
	 * In this case, handlers for the known NMI sources will be called
	 * first, followed by the remaining handlers, which are called
	 * during the subsequent polling code.


> 
> And add an empty line to ease review.
will do

> 
> > +	 * On the other hand, if we do get non-zero vectors, we know
> > exactly
> > +	 * what the sources are. So we only call the handlers with the
> > bit set.
> > +	 */
> > +	if (source_bitmask & BIT(NMI_SOURCE_VEC_UNKNOWN)) {
> > +		pr_warn_ratelimited("NMI received with unknown
> > source\n");  
> 
> s/source/sources/
> 
> > +		has_unknown_src = true;
> > +	}
> > +
> > +	rcu_read_lock();  
> 
> Add an empty line.
> 
> > +	/* Bit 0 is for unknown NMI sources, skip it. */  
> 
> Put "vec = 1 " close to this comment.
yes

> 
> > +	for_each_set_bit_from(vec, &source_bitmask,
> > NR_NMI_SOURCE_VECTORS) {
> > +		a = rcu_dereference(nmiaction_src_table[vec]);
> > +		if (!a) {
> > +			pr_warn_ratelimited("NMI received %d no
> > handler", vec);  
> 
> Use a better log message.
pr_warn_ratelimited("NMI-source vector %d has no handler!", vec);

> 
> > +			continue;
> > +		}  
> 
> Empty line again.
will add

> 
> > +		handled += do_handle_nmi(a, regs, type);  
> 
> Ditto.
yes

> 
> > +		/*
> > +		 * Needs polling if unknown source bit is set,
> > handled_mask is  
> 
>                                     ^the
got that.

> 
> > +		 * used to tell the polling code which NMIs can be
> > skipped.
> > +		 */
> > +		if (has_unknown_src)
> > +			*handled_mask |= BIT(vec);
> > +	}  
> 
> empty line please.
will add

> 
> > +	rcu_read_unlock();
> > +
> > +	return handled;
> > +}
> > +
> >   static int nmi_handle(unsigned int type, struct pt_regs *regs)
> >   {
> >   	struct nmi_desc *desc = nmi_to_desc(type);
> > +	unsigned long handled_mask = 0;
> >   	struct nmiaction *a;
> >   	int handled=0;
> >   
> > -	rcu_read_lock();
> > +	/*
> > +	 * Check if the NMI source handling is complete, otherwise
> > polling is
> > +	 * still required. handled_mask is non-zero if NMI source
> > handling is
> > +	 * partial due to unknown NMI sources.
> > +	 */
> > +	handled = nmi_handle_src(type, regs, &handled_mask);
> > +	if (handled && !handled_mask)
> > +		return handled;
> >   
> > +	rcu_read_lock();  
> 
> keep original empty lines around it.
ok

> 
> >   	/*
> >   	 * NMIs are edge-triggered, which means if you have enough
> >   	 * of them concurrently, you can lose some because only one
> >   	 * can be latched at any given time.  Walk the whole list
> >   	 * to handle those situations.
> >   	 */
> > -	list_for_each_entry_rcu(a, &desc->head, list)
> > +	list_for_each_entry_rcu(a, &desc->head, list) {
> > +		/* Skip NMIs handled earlier with source info */
> > +		if (BIT(a->source_vec) & handled_mask)
> > +			continue;
> >   		handled += do_handle_nmi(a, regs, type);
> > -
> > +	}
> >   	rcu_read_unlock();  
> 
> keep original empty lines around it.
ok

Thanks,

Jacob
