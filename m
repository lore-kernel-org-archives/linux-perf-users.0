Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349481E871;
	Mon,  1 Jul 2024 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847880; cv=none; b=emhnq7zYM5KhQq9II8MeooKy5eEBH3KBalY0tYcd+tBJJRGtwlLlf4KCB00igWRjsRvrsebKPaE/n5aXF18F/uhPi6/WyIdP/woqAreENaVQufzZ7M+/cXdhZFk/gn0z8Gv4CtzJBZNTmxp9JwE6n9oDMzA05F1bNKSVOGgZpwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847880; c=relaxed/simple;
	bh=T2Q1XD5tEeR4cBqImPSELp6NvuCErUaT4Shazy8hl3M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hK79p5qOjrFaqU3rb7ti+Lnh1T4Y/9ey1RhCUQDJoGEqdCnI+qBr8V8F1hI7bZQOYlBngoej2Ogmk44y5jtTmFxPS27+MFW0s/mz6ci0AGeoISVdIqbO/9HXAIXl5UBAB6OOg0/BjuxVqr7t9cEGKx2TjqA1I7R1RN21HZiLQj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X0AvAVbn; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X0AvAVbn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719847879; x=1751383879;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T2Q1XD5tEeR4cBqImPSELp6NvuCErUaT4Shazy8hl3M=;
  b=X0AvAVbnc6i1eGPfY6FB7LqRm3qsCuB4jOHQvZ1YgbTXX8yTr8/BuMMF
   yFJVY81nji6tjDsl4dmAqeyDxXBcWP0HlNKJ/z2oMop0wX6LVwZhlkL1K
   1vsCiZ5tIwQr4skzlYphYDPra7B9BOXG6qVB1GXVu6BADnqYa/BzLD0G7
   YFUDQNOswZRrKO4D8bmi2Je/odMQe78eJINWCZGreM5UojZjzp6pJnyEv
   1ZxlDjWJCKHU1JATeXJiBp9iYFU8OnKse7ss+n661rD2Dtv+rz/DwAVA8
   v/RFa5EsPl1HvrOs5EJDn6SKIOt26lWMqIhLzOYQSXuRLyZBy66NpOtNb
   w==;
X-CSE-ConnectionGUID: wlmedhsSSkuKEzBlL85TiA==
X-CSE-MsgGUID: cv8DmSiQS4qZ2xzmLnOz7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="27602883"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="27602883"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 08:30:53 -0700
X-CSE-ConnectionGUID: ELzaDbQCRI+LXikilOlfWQ==
X-CSE-MsgGUID: WYOSE24kSb2f2HjIAivj1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="76742001"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 08:30:52 -0700
Date: Mon, 1 Jul 2024 08:36:04 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
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
Message-ID: <20240701083604.5dfeb087@jacob-builder>
In-Reply-To: <9cf3eef6-79d9-4969-be94-e5089a0d625b@suse.com>
References: <20240628201839.673086-1-jacob.jun.pan@linux.intel.com>
	<20240628201839.673086-6-jacob.jun.pan@linux.intel.com>
	<9cf3eef6-79d9-4969-be94-e5089a0d625b@suse.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


On Mon, 1 Jul 2024 17:31:48 +0300, Nikolay Borisov <nik.borisov@suse.com>
wrote:

> On 28.06.24 =D0=B3. 23:18 =D1=87., Jacob Pan wrote:
> > With NMI source reporting enabled, NMI handler can prioritize the
> > handling of sources reported explicitly. If the source is unknown, then
> > resume the existing processing flow. i.e. invoke all NMI handlers.
> >=20
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >=20
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
> >=20
> > diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
> > index 639a34e78bc9..c3a10af7f26b 100644
> > --- a/arch/x86/kernel/nmi.c
> > +++ b/arch/x86/kernel/nmi.c
> > @@ -149,23 +149,90 @@ static inline int do_handle_nmi(struct nmiaction
> > *a, struct pt_regs *regs, unsig return thishandled;
> >   }
> >  =20
> > +static int nmi_handle_src(unsigned int type, struct pt_regs *regs,
> > unsigned long *handled_mask) +{
> > +	static bool nmi_source_disabled;
> > +	bool has_unknown_src =3D false;
> > +	unsigned long source_bitmask;
> > +	struct nmiaction *a;
> > +	int handled =3D 0;
> > +	int vec =3D 1;
> > +
> > +	if (!cpu_feature_enabled(X86_FEATURE_NMI_SOURCE) ||
> > +	    type !=3D NMI_LOCAL || nmi_source_disabled)
> > +		return 0;
> > +
> > +	source_bitmask =3D fred_event_data(regs);
> > +	if (!source_bitmask) {
> > +		pr_warn("NMI received without source information!
> > Disable source reporting.\n");
> > +		nmi_source_disabled =3D true;
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
> > +	 * to call every handler as if we have no NMI source.
> > +	 * On the other hand, if we do get non-zero vectors, we know
> > exactly
> > +	 * what the sources are. So we only call the handlers with the
> > bit set.
> > +	 */
> > +	if (source_bitmask & BIT(NMI_SOURCE_VEC_UNKNOWN)) {
> > +		pr_warn_ratelimited("NMI received with unknown
> > source\n");
> > +		has_unknown_src =3D true;
> > +	}
> > +
> > +	rcu_read_lock();
> > +	/* Bit 0 is for unknown NMI sources, skip it. */
> > +	for_each_set_bit_from(vec, &source_bitmask,
> > NR_NMI_SOURCE_VECTORS) {
> > +		a =3D rcu_dereference(nmiaction_src_table[vec]);
> > +		if (!a) {
> > +			pr_warn_ratelimited("NMI received %d no
> > handler", vec);
> > +			continue;
> > +		}
> > +		handled +=3D do_handle_nmi(a, regs, type);
> > +		/*
> > +		 * Needs polling if unknown source bit is set,
> > handled_mask is
> > +		 * used to tell the polling code which NMIs can be
> > skipped.
> > +		 */
> > +		if (has_unknown_src)
> > +			*handled_mask |=3D BIT(vec);
> > +	}
> > +	rcu_read_unlock();
> > +
> > +	return handled;
> > +}
> > +
> >   static int nmi_handle(unsigned int type, struct pt_regs *regs)
> >   {
> >   	struct nmi_desc *desc =3D nmi_to_desc(type);
> > +	unsigned long handled_mask =3D 0;
> >   	struct nmiaction *a;
> >   	int handled=3D0;
> >  =20
> > -	rcu_read_lock();
> > +	/*
> > +	 * Check if the NMI source handling is complete, otherwise
> > polling is
> > +	 * still required. handled_mask is non-zero if NMI source
> > handling is
> > +	 * partial due to unknown NMI sources.
> > +	 */
> > +	handled =3D nmi_handle_src(type, regs, &handled_mask);
> > +	if (handled && !handled_mask)
> > +		return handled; =20
>=20
> How about renaming handled_mask to "partial_handled_mask" ? Because in=20
> addition to it being a mask it's also used as a boolean to signal that=20
> an unknown NMI source was encountered.
yeah, that is better. will do.

> >  =20
> > +	rcu_read_lock();
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
> >   		handled +=3D do_handle_nmi(a, regs, type);
> > -
> > +	}
> >   	rcu_read_unlock();
> >  =20
> >   	/* return total number of NMI events handled */ =20


Thanks,

Jacob
