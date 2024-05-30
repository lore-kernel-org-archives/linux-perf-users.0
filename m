Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3194187560;
	Thu, 30 May 2024 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717085133; cv=none; b=QxIkt2474RGJ4YwaS9O9EkPTDyPwY8vBvQnrBvW7zZ9vgojYFP56PzXFKb0qac27IlVMJ8ftGeNiE8KkgLVor032+0OujPyR0pIJiBEBbhRONx4k8A4Rlc99jqpzfb7NZJFBqetJKehbHrzYso8r3+djSCQGBoLC2XzLPOXtOTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717085133; c=relaxed/simple;
	bh=VWawOdHq3pvRafrtZzhAFuI6fqqdhDNv37/Cz9EPRXM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CzqjrI5qohJAxUy48l+hI8UnwyACkVp0ktMJTns+z94bLboYCgsaHg181H/tFnbatw8QrhAjwreq5MJngydMSKyMoJZG2bL+faVgiJpz3ciYcOe5HiXkGVDkm38Iw5fF37mkM9RAcMCNnk4kd5slxFNjkmeWbZa/qkLqKSAIoNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f8TK4pCZ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f8TK4pCZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717085133; x=1748621133;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VWawOdHq3pvRafrtZzhAFuI6fqqdhDNv37/Cz9EPRXM=;
  b=f8TK4pCZcPlKRLRErE93N7ATpRbdPOIB+y4Sck4wl/pjmiFp+mMbppjv
   Pn/mAjRi8ZtwCGIYfjOos5FrVwqqBu4mOXiiEB6a8MCHXIavXA03uHFiF
   R93WUM1tUeMRdb/jylzeq+3t+FM/Zc1gUIEYWC8T3IrMx5SINImPvc+Xt
   LsUW5Be5Ji5CU8mlW5rGCZ+mQhv9+u80JYlYbiAHa5GeMTKcr/fP+JYbW
   7OxY4Rspx2vCMfxE4Nzrtpu12dohqgN5zX6ZRuz/+aNd8ST0rqedlcT7v
   0IYx3/tN1N305wtcg7uYoSiBiUJJa4PSAa2XMQwajP16H+g1vUEcR8mZQ
   g==;
X-CSE-ConnectionGUID: 0YwEWJ2gRsKphmSdvTqX9g==
X-CSE-MsgGUID: oRv51B1lTTKm1kINIHub8w==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13533072"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="13533072"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 09:05:31 -0700
X-CSE-ConnectionGUID: cG7ziEy0Qtif4gZxG+QDOA==
X-CSE-MsgGUID: 8G0md/MaSF6ec6TKm5X+AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="35893157"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 09:05:29 -0700
Date: Thu, 30 May 2024 09:10:25 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: X86 Kernel <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@intel.com>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Andi Kleen <andi.kleen@intel.com>, Xin Li <xin3.li@intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 4/6] x86/irq: Process nmi sources in NMI handler
Message-ID: <20240530091025.60de3227@jacob-builder>
In-Reply-To: <0bac819f-fdbe-4de2-8a5f-30ded87bb036@zytor.com>
References: <20240529203325.3039243-1-jacob.jun.pan@linux.intel.com>
	<20240529203325.3039243-5-jacob.jun.pan@linux.intel.com>
	<0bac819f-fdbe-4de2-8a5f-30ded87bb036@zytor.com>
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

Hi Peter,

On Wed, 29 May 2024 13:47:09 -0700, "H. Peter Anvin" <hpa@zytor.com> wrote:

> On 5/29/24 13:33, Jacob Pan wrote:
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
> Note: if bit 0 is set, you can process any other bits first (on the 
> general assumption that if you bother with NMI source then those events 
> are performance sensitive), and you could even exclude them from the 
> poll. This is an optimization, and what you have here is correct from a 
> functional point of view.
> 
Yes, it is a good optimization but also a rare case that bit 0 is set. no?

> > +	source_bitmask = fred_event_data(regs);
> > +	if (!source_bitmask) {
> > +		pr_warn_ratelimited("NMI received without source
> > information!\n");
> > +		return 0;
> > +	}  
> 
> If the event data word is 0, it probably should be treated as a 
> *permanent* failure, as it is a Should Not Happen[TM] situation, and 
> means there is an implementation (or, perhaps more likely, 
> virtualization!) bug, and as such it may not be safe to trust the NMI 
> source information in the future.
> 
Good point, I will add a flag to permanently disable NMI source reporting
for this boot cycle if that happens.

> > +	if (!cpu_feature_enabled(X86_FEATURE_NMI_SOURCE) || type !=
> > NMI_LOCAL)
> > +		return 0;  
> 
> I'm not sure I understand why you are requiring type to be NMI_LOCAL here?
> 
It is just for this current implementation I am not including external
NMIs. AFAIK, there is no users, i.e. no device MSIs delivered as NMI. I saw
effort trying to make HPET NMI watchdog but not materialized.

Thanks,

Jacob
