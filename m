Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D944964E;
	Wed,  3 Jul 2024 23:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720047940; cv=none; b=i3fVFPa4fOGSUJlOZ5iTNacV8H0hgSaEQEToQ6wk66qtnA9lwd4j8q4AupX8w+BQUWwws+wXYHGGKl38GtihOvs3UHRCeLiwioLOUEWYnjRhNePOpJY5Di2bh3vMtUnxYSg78Q2fJ1naF6mepEtlmBms4mKZ5yHIHQ79tmA9sOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720047940; c=relaxed/simple;
	bh=ib2MQP1+VFmSLV17Wu7+aGnrGqFHS1DAxRVpfizpWaw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+B5gH9E2tcAMNiMHqJdL0BmOlAp+M3h4xAxPxfCHw03919QVvS0dmUwAbzOUTpVDzwwRF/Yu/XTuB3++D67kVb6InNuva7Cf3E4zSqnklnD6VV2z5xeEBbGAVOxYNWfAXQKIdvirVBylZhmjbLLv8B/a4T4c9TUZ1oZwWJW0HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FcVc/46K; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FcVc/46K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720047939; x=1751583939;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ib2MQP1+VFmSLV17Wu7+aGnrGqFHS1DAxRVpfizpWaw=;
  b=FcVc/46KZ+7kqlsDhvWbkV1ekFo7JsbkdbD3BF1AqblINE0ICWlmG6vf
   ttWDentozdiUG1CoxXp2lv4hHfmGo+LgI1iT5v1mCjm2Xo9JP6yy43cZC
   65uRwMZ1cfxsl0dpEONFeyVbyRtbAVA6pe+iv+8G68QFL9hYKTDaRNXFu
   z4/nK4cPl/IEiG/ZYR/x6ilJqfaN8iHUMe9kt/hekAZxePKuo6wlSqPn5
   +CIJ+KHqfPnNbQ8iBUezWk6t8Edety/ieFozA5rl2Zy5YtFdzzLX8/1Db
   Smj8omCY5eRvhOuROibjZ0Y6Alyf56BHliJhsxac2OGtyGLTY9Ap1RsMW
   A==;
X-CSE-ConnectionGUID: Ekg7IIQLRU6RGNmQ3ZulPA==
X-CSE-MsgGUID: hiDsGiCGRT+IQ9viRRGPjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17259836"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17259836"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 16:05:39 -0700
X-CSE-ConnectionGUID: qdl4Jy95Qx+NMw2anMUn9A==
X-CSE-MsgGUID: BXzv9cMDQseBkyjPW6b29w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="46544441"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 16:05:38 -0700
Date: Wed, 3 Jul 2024 16:10:51 -0700
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
Subject: Re: [PATCH v3 04/11] x86/irq: Factor out common NMI handling code
Message-ID: <20240703161051.3fb87920@jacob-builder>
In-Reply-To: <889c06bc-6577-4fac-b61e-b2d30e99bbfb@zytor.com>
References: <20240628201839.673086-1-jacob.jun.pan@linux.intel.com>
	<20240628201839.673086-5-jacob.jun.pan@linux.intel.com>
	<889c06bc-6577-4fac-b61e-b2d30e99bbfb@zytor.com>
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


On Fri, 28 Jun 2024 17:31:50 -0700, Xin Li <xin@zytor.com> wrote:

> On 6/28/2024 1:18 PM, Jacob Pan wrote:
> > In preparation for handling NMIs with explicit source reporting, factor
> > out common code for reuse.
> >   
> 
> My read is that this patch has no functional change, right?
> 
> If yes, please add "No functional change intended."
will do.

> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >   arch/x86/kernel/nmi.c | 28 ++++++++++++++++------------
> >   1 file changed, 16 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
> > index 1ebe93edba7a..639a34e78bc9 100644
> > --- a/arch/x86/kernel/nmi.c
> > +++ b/arch/x86/kernel/nmi.c
> > @@ -135,6 +135,20 @@ static void nmi_check_duration(struct nmiaction
> > *action, u64 duration) action->handler, duration, decimal_msecs);
> >   }
> >   
> > +static inline int do_handle_nmi(struct nmiaction *a, struct pt_regs
> > *regs, unsigned int type) +{
> > +	int thishandled;
> > +	u64 delta;
> > +
> > +	delta = sched_clock();
> > +	thishandled = a->handler(type, regs);
> > +	delta = sched_clock() - delta;
> > +	trace_nmi_handler(a->handler, (int)delta, thishandled);
> > +	nmi_check_duration(a, delta);
> > +
> > +	return thishandled;
> > +}
> > +
> >   static int nmi_handle(unsigned int type, struct pt_regs *regs)
> >   {
> >   	struct nmi_desc *desc = nmi_to_desc(type);
> > @@ -149,18 +163,8 @@ static int nmi_handle(unsigned int type, struct
> > pt_regs *regs)
> >   	 * can be latched at any given time.  Walk the whole list
> >   	 * to handle those situations.
> >   	 */
> > -	list_for_each_entry_rcu(a, &desc->head, list) {
> > -		int thishandled;
> > -		u64 delta;
> > -
> > -		delta = sched_clock();
> > -		thishandled = a->handler(type, regs);
> > -		handled += thishandled;
> > -		delta = sched_clock() - delta;
> > -		trace_nmi_handler(a->handler, (int)delta, thishandled);
> > -
> > -		nmi_check_duration(a, delta);
> > -	}
> > +	list_for_each_entry_rcu(a, &desc->head, list)
> > +		handled += do_handle_nmi(a, regs, type);
> >   
> >   	rcu_read_unlock();
> >     
> 
> As this is a preparation patch, better move it earlier before any actual 
> NMI source changes, maybe the first patch of this series.
This preparatory patch is utilized immediately by the subsequent patch,
enhancing the narrative flow, in my opinion.

Thanks,

Jacob
