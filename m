Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39E57FF;
	Fri, 28 Jun 2024 04:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719550282; cv=none; b=u2EiCBpLqalwdowFT9Gtq6okoTwxEwr8uzegBb6NSqRJFUaTlBfs0d+euNlxgxbCiQT23CZNHUjc19CBSBMgJOXNl/wVyckojuicysMjfLrULU5H54sGWVNW+RR+kd/82EUGp0yO1KV89UJ3xzD7AcFRVw2arddlXKK0x0U6SUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719550282; c=relaxed/simple;
	bh=/tfSqBzLYCBCcu1HN4lLX7mZjFvUvumRecXG5kZloek=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OqTj+IQ+m7lpkgSu1hWe00HTY0sS3dxa4tmeVlXb1zQj3aI6ZKmG8H5AqTLvmBq4r3ynDCCgaCa61gB6nGDDyjoJuWCBOocA+n8NkNnSUsBqg1Qg9zgCR/wfkb+3efbU/M4h+7x3kSmkgxUIZeORLMhm/Fs3oFMwoUYgk+B+3vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kkPl8doI; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kkPl8doI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719550281; x=1751086281;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/tfSqBzLYCBCcu1HN4lLX7mZjFvUvumRecXG5kZloek=;
  b=kkPl8doI+M1fUAjpv+XJ3Z++serH+XPB3HrvhQR2c+I89Ff5JuUfKyok
   3jS5v/Dr9yCSvQ25pmUIwCKiXoYIF7wnvJ3QZOFHht7dtgV+pVWDoAIES
   5nesS2xX5ViMD49ATHdDF3eWvhNOg5Qpqz69ZMuCZy5+jjjS+sFiWXjz4
   CE/eabSttcVKyAsFozahXuIPJn2HUw1wIYVBa/KTuhAjg2e27KjKtXqNU
   dG73yilpG0XnjxEeR64tQbhfw5xf9lSzNPpf6u99XkkPL5fGbMol0jjtt
   RaC+adQEoFfDvOyLo3stYtkqxhRq246mRevlMefYbZXBXWecJA9ONPv21
   g==;
X-CSE-ConnectionGUID: pn25LuXlTt6/dP4c1QMTsQ==
X-CSE-MsgGUID: wHQcXfZ9R5Kw5UbxN7IQ7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="34257941"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="34257941"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 21:51:20 -0700
X-CSE-ConnectionGUID: SNDJrbC3TP62YR+GebecSg==
X-CSE-MsgGUID: 6UN8mwQ2Q++Qgrz3YAVWSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="45364269"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 21:51:19 -0700
Date: Thu, 27 Jun 2024 21:56:30 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: X86 Kernel <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>, "Ingo Molnar" <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, <linux-perf-users@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Andi Kleen <andi.kleen@intel.com>, Xin Li
 <xin3.li@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 2/6] x86/irq: Extend NMI handler registration
 interface to include source
Message-ID: <20240627215630.5d7eba96@jacob-builder>
In-Reply-To: <9057390e-1a15-43e7-b4bc-803651b951ed@intel.com>
References: <20240611165457.156364-1-jacob.jun.pan@linux.intel.com>
	<20240611165457.156364-3-jacob.jun.pan@linux.intel.com>
	<9057390e-1a15-43e7-b4bc-803651b951ed@intel.com>
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


On Mon, 24 Jun 2024 16:16:52 -0700, Sohil Mehta <sohil.mehta@intel.com>
wrote:

> On 6/11/2024 9:54 AM, Jacob Pan wrote:
> > Add a source vector argument to register_nmi_handler() such that
> > designated NMI originators can leverage NMI source reporting feature.
> > For those who do not use NMI source reporting, 0 (unknown) is used as
> > the source vector. NMI source vectors (up to 16) are pre-defined.
> >   
> 
> What determines whether a source supports the new reporting vs some that
> don't? It might be useful to add that reasoning to the commit message as
> well.
> 
> I am guessing there is some connection to NMI_LOCAL based on
> use_nmi_source() definition but I am not sure.
Yes, this patch only enables NMI source reporting for local interrupts.
There is no use of MSIs delivered as NMI so far. Will add the rationale
here.

> Also, would it be worthwhile to split this patch into 2? One part that
> extents the register_nmi_handler() API and another that allocates the
> source vectors to certain sources.
Good point, will do.
> 
> > +static inline bool use_nmi_source(unsigned int type, struct nmiaction
> > *a) +{
> > +	return (cpu_feature_enabled(X86_FEATURE_NMI_SOURCE) &&
> > +		type == NMI_LOCAL && a->source_vec);
> > +}
> > +  
> 
> Sohil


Thanks,

Jacob
