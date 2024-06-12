Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86BE31A67;
	Wed, 12 Jun 2024 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718228964; cv=none; b=dSqzj61dEjiPW7QTde3HUWaItkXSJMwU80CiPm5wWbnPJzKy1e0rSa+dfZ1SYyypiDaXgTpJI5HoXeTf8KAdg4QAMEWVLKk8eoQ4STQd1sLcZzRBKjLsMtZmImv8xu7v8qdnzlaUCOVHyptOjbnsGlOQXYSgEc2kNOR5hD13hGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718228964; c=relaxed/simple;
	bh=jt6vDOr2cS4RfuRvhJ7VhhFB890iPHTlYUOYQcsW/CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N54Hxqoe49bJHz8b92wgbkrEHeDvP+n8cEPhUnQHq9ZbO+1h0l5di4RXMzfYFuDYIwwKYOPg1DV+lBOvQe718/1vW3ezycVgYJNNteuagA2SvmSY7ozpUrzQwM0KaDL72LYX1qc9mVY8HGLA1iHP+qYi14uMzqGumedbisP9Mkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bGAmVynx; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bGAmVynx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718228963; x=1749764963;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jt6vDOr2cS4RfuRvhJ7VhhFB890iPHTlYUOYQcsW/CQ=;
  b=bGAmVynxv63nhKUFeefO0sbDwoOu6FN899ZEgBMx/3O4blfWvsW/dCWf
   uknWlL0fOwIhhzSy8h8rxY+JpqowOxny13yoSOqXhZv4sE2bv4VbDEEEb
   5WE6prCJy+wByoL3YS8M99fiQmlS/wCYm4zuVuAZ+hYIU+23MAiJI5SRn
   4xZrmTVW2pBbllmWSaeMrMfxM54CbXd80g8MN2lc3ec5QUFKyj27lwNE2
   /4iF5JSzeufoezrSgC7KWlO+hFWjNmaRnAsv4LBXglUO7rP3ytnSrGBDu
   TW+CJVabCVPzuDDm9aO05eyRluEAKAPrNxqH62TMPkDUlHTJM6F59xM41
   Q==;
X-CSE-ConnectionGUID: AMydol0ORUeyUqMNLfy/3w==
X-CSE-MsgGUID: OVjCr/hhTGKb26esavOq9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="37538063"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="37538063"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 14:49:22 -0700
X-CSE-ConnectionGUID: dCcAC2uKQDK2uEhxGOO+SA==
X-CSE-MsgGUID: r/u0rVcsT7GNOnZdviVPeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="39813691"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 14:49:22 -0700
Date: Wed, 12 Jun 2024 14:54:24 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: X86 Kernel <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@intel.com>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Andi Kleen <andi.kleen@intel.com>, Xin Li <xin3.li@intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 4/6] x86/irq: Process nmi sources in NMI handler
Message-ID: <20240612145424.61890aa3@jacob-builder>
In-Reply-To: <b2a230b0-3f00-49b3-87fb-63622f697395@zytor.com>
References: <20240611165457.156364-1-jacob.jun.pan@linux.intel.com>
	<20240611165457.156364-5-jacob.jun.pan@linux.intel.com>
	<b2a230b0-3f00-49b3-87fb-63622f697395@zytor.com>
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

On Tue, 11 Jun 2024 11:41:07 -0700, "H. Peter Anvin" <hpa@zytor.com> wrote:

> On 6/11/24 09:54, Jacob Pan wrote:
> > +
> > +	source_bitmask = fred_event_data(regs);
> > +	if (!source_bitmask) {
> > +		pr_warn_ratelimited("NMI without source information!
> > Disable source reporting.\n");
> > +		setup_clear_cpu_cap(X86_FEATURE_NMI_SOURCE);
> > +		return 0;
> > +	}  
> 
> Is setup_clear_cpu_cap() even meaningful here?
Right, alternative patching doesn't work here. Let me use a separate flag.

> 
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
> > +	 * to call every handler as if we have no NMI source.
> > +	 * On the other hand, if we do get non-zero vectors, we know
> > exactly
> > +	 * what the sources are. So we only call the handlers with the
> > bit set.
> > +	 */
> > +	if (source_bitmask & BIT(NMI_SOURCE_VEC_UNKNOWN)) {
> > +		pr_warn_ratelimited("NMI received with unknown
> > source\n");
> > +		return 0;
> > +	}
> > +  
> 
> You can still dispatch the known NMI handlers early before doing the 
> polling.

True, my thinking was based on two conditions:
1. unknown NMI source is a rare/unlikely case
2. when unknown source does get set, it is due to deep CPU idle where
performance optimization is not productive.

So I think any optimization to the unlikely case should not add cost to the
common case. Tracking early/direct dispatched handler adds cost to the
common case. Below is my attempt, there must be a better way.

static int nmi_handle_src(unsigned int type, struct pt_regs *regs, unsigned long *handled_mask)
{
	static bool nmi_source_disabled = false;
	bool has_unknown_src = false;
	unsigned long source_bitmask;
	struct nmiaction *a;
	int handled = 0;
	int vec = 1;

	if (!cpu_feature_enabled(X86_FEATURE_NMI_SOURCE) ||
	    type != NMI_LOCAL || nmi_source_disabled)
		return 0;

	source_bitmask = fred_event_data(regs);
	if (!source_bitmask) {
		pr_warn("NMI received without source information! Disable source reporting.\n");
		nmi_source_disabled = true;
		return 0;
	}

	/*
	 * Per NMI source specification, there is no guarantee that a valid
	 * NMI vector is always delivered, even when the source specified
	 * one. It is software's responsibility to check all available NMI
	 * sources when bit 0 is set in the NMI source bitmap. i.e. we have
	 * to call every handler as if we have no NMI source.
	 * On the other hand, if we do get non-zero vectors, we know exactly
	 * what the sources are. So we only call the handlers with the bit set.
	 */
	if (source_bitmask & BIT(NMI_SOURCE_VEC_UNKNOWN)) {
		pr_warn_ratelimited("NMI received with unknown source\n");
		has_unknown_src = true;
	}

	rcu_read_lock();
	/* Bit 0 is for unknown NMI sources, skip it. */
	for_each_set_bit_from(vec, &source_bitmask, NR_NMI_SOURCE_VECTORS) {
		a = rcu_dereference(nmiaction_src_table[vec]);
		if (!a) {
			pr_warn_ratelimited("NMI received %d no handler", vec);
			continue;
		}
		handled += do_handle_nmi(a, regs, type);
		/*
		 * Needs polling if unknown source bit is set, handled_mask is
		 * used to tell the polling code which NMIs can be skipped.
		 */
		if (has_unknown_src)
			*handled_mask |= BIT(vec);
	}
	rcu_read_unlock();

	return handled;
}

static int nmi_handle(unsigned int type, struct pt_regs *regs)
{
	struct nmi_desc *desc = nmi_to_desc(type);
	unsigned long handled_mask = 0;
	struct nmiaction *a;
	int handled=0;

	/*
	 * Check if the NMI source handling is complete, otherwise polling is
	 * still required. handled_mask is non-zero if NMI source handling is
	 * partial due to unknown NMI sources.
	 */
	handled = nmi_handle_src(type, regs, &handled_mask);
	if (handled && !handled_mask)
		return handled;

	rcu_read_lock();
	/*
	 * NMIs are edge-triggered, which means if you have enough
	 * of them concurrently, you can lose some because only one
	 * can be latched at any given time.  Walk the whole list
	 * to handle those situations.
	 */
	list_for_each_entry_rcu(a, &desc->head, list) {
		/* Skip NMIs handled earlier with source info */
		if (BIT(a->source_vec) & handled_mask)
			continue;
		handled += do_handle_nmi(a, regs, type);
	}
	rcu_read_unlock();

	/* return total number of NMI events handled */
	return handled;
}
NOKPROBE_SYMBOL(nmi_handle);


> > +	rcu_read_lock();
> > +	/* Bit 0 is for unknown NMI sources, skip it. */
> > +	for_each_set_bit_from(vec, &source_bitmask,
> > NR_NMI_SOURCE_VECTORS) {
> > +		a = rcu_dereference(nmiaction_src_table[vec]);
> > +		if (!a) {
> > +			pr_warn_ratelimited("NMI received %d no
> > handler", vec);
> > +			continue;
> > +		}
> > +		handled += do_handle_nmi(a, regs, type);
> > +	}
> > +	rcu_read_unlock();
> > +	return handled;
> > +}
> > +  
> 
> That would mean that you would also need to return a bitmask of which 
> source vectors need to be handled with polling.

Should it be the bitmask to be skipped by polling? see handled_mask in
the code above.



Thanks,

Jacob
