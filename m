Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DC416F0DD;
	Fri, 21 Jun 2024 23:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719013272; cv=none; b=F8rZssX4cO/ShipmYWiVZeYESROhswFaqRMAsyuTq9tHP+GAoxeCjmqTSwKF3HrGEaL1URpIinoqKyV8v9dZ+39TNNKIfQLkI9nIMGdNZ2zsV7u5+ZFMyDglKnDUUXpyVTeBGBkD8DmjKHH0oMqR4cpzedJeLCSxhzXvE9Z72b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719013272; c=relaxed/simple;
	bh=8PV/Rh1aXyhwMjyp6bU0ce/btT27fi0C4PHFNRa0mKo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IWeT3LIrir2tPYgtD/72N86gMKflaeajRg9A74LxoCZRESFFUF/BClsKRId+0XNgrn1YPqD8BPFcQzU6flQcIGz1tyugpptk5ya+rLN3HsPrUOTJQB6LoY5IGnnzTO1XURHSIgVZepR75BzfoAaqdUMrIhjN5deRmTdxOGm4AO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Crifback; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Crifback"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719013269; x=1750549269;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8PV/Rh1aXyhwMjyp6bU0ce/btT27fi0C4PHFNRa0mKo=;
  b=CrifbackY5He+xPoQRGLOURCYYrK8BtASboz3pZBKYZAl0UyZGLlOYz1
   EYb/V+b/2FmkbWVwwEvou2vSLEjEPBATCH5RhXdDpYvUa3LXWi+bKG1T6
   a41oyLZXBit9NslsANWzciQPoab+zJLohu4qw/dYOuQbtyQYb6v94JhfT
   jdHdEmnQyoQDusaFf+/1h4/usZ7NsffBG5bRxcyBAuSOA/LDdhHSOLwnH
   11RGG4OBaFO4bBwWOPzs8oe29l29oEOdlAA2rXTuD4nxUlNaf4RvMZgM3
   IcZ2G3Q2d6yFD5R+xGdGhllFiej5N8H5F8Cs/3c0IZ69H1+eE5nmhHYqL
   g==;
X-CSE-ConnectionGUID: mfMjtCwmQVigPbKQjHUygg==
X-CSE-MsgGUID: /wp4wB5zSaqq+MnFZR3YaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="16038166"
X-IronPort-AV: E=Sophos;i="6.08,256,1712646000"; 
   d="scan'208";a="16038166"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 16:41:08 -0700
X-CSE-ConnectionGUID: nvrW9cR3RriVKn1PrQrkTQ==
X-CSE-MsgGUID: qtdMwCjPQTKWuAHl+zH4oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,256,1712646000"; 
   d="scan'208";a="73948122"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 16:41:08 -0700
Date: Fri, 21 Jun 2024 16:46:15 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: X86 Kernel <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>, "Ingo Molnar" <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, <linux-perf-users@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Andi Kleen <andi.kleen@intel.com>, Xin Li
 <xin3.li@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 1/6] x86/irq: Add enumeration of NMI source reporting
 CPU feature
Message-ID: <20240621164615.051217c4@jacob-builder>
In-Reply-To: <b3b10d29-857e-402b-95b9-1696baa88e81@intel.com>
References: <20240611165457.156364-1-jacob.jun.pan@linux.intel.com>
	<20240611165457.156364-2-jacob.jun.pan@linux.intel.com>
	<b3b10d29-857e-402b-95b9-1696baa88e81@intel.com>
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


On Fri, 21 Jun 2024 15:23:51 -0700, Sohil Mehta <sohil.mehta@intel.com>
wrote:

> > diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> > index 4fa0b17e5043..465f04e4a79f 100644
> > --- a/arch/x86/kernel/traps.c
> > +++ b/arch/x86/kernel/traps.c
> > @@ -1427,8 +1427,10 @@ early_param("fred", fred_setup);
> >  
> >  void __init trap_init(void)
> >  {
> > -	if (cpu_feature_enabled(X86_FEATURE_FRED) && !enable_fred)
> > +	if (cpu_feature_enabled(X86_FEATURE_FRED) && !enable_fred) {
> >  		setup_clear_cpu_cap(X86_FEATURE_FRED);
> > +		setup_clear_cpu_cap(X86_FEATURE_NMI_SOURCE);
> > +	}
> >  
> >  	/* Init cpu_entry_area before IST entries are set up */
> >  	setup_cpu_entry_areas();  
> 
> I think this relies on the fact that whenever X86_FEATURE_NMI_SOURCE is
> set, X86_FEATURE_FRED will also be set by the hardware. Though this
> might be the expected behavior, hardware sometimes messes up and the
> dependency entry in the static table would probably help catch that.
> 
> IIUC, when X86_FEATURE_NMI_SOURCE is set and X86_FEATURE_FRED is
> cleared, cpu_feature_enabled(X86_FEATURE_FRED) will fail and the above
> check would not end up clearing X86_FEATURE_NMI_SOURCE.
> 
> Isn't the following entry necessary to detect a misconfiguration or is
> the purpose of the cpuid_deps table something else?
My understanding is that cpuid_deps is to ensure CPU features are
cleared according to its dependency chain. Not for HW bugs/quirks.

> 
> diff --git a/arch/x86/kernel/cpu/cpuid-deps.c
> b/arch/x86/kernel/cpu/cpuid-deps.c
> index b7d9f530ae16..39526041e91a 100644
> --- a/arch/x86/kernel/cpu/cpuid-deps.c
> +++ b/arch/x86/kernel/cpu/cpuid-deps.c
> @@ -84,6 +84,7 @@ static const struct cpuid_dep cpuid_deps[] = {
>         { X86_FEATURE_SHSTK,                    X86_FEATURE_XSAVES    },
>         { X86_FEATURE_FRED,                     X86_FEATURE_LKGS      },
>         { X86_FEATURE_FRED,                     X86_FEATURE_WRMSRNS   },
> +       { X86_FEATURE_NMI_SOURCE,		X86_FEATURE_FRED      },
>         {}
>  };
If FRED is never reported by CPUID, then there would not be any calls to
setup_clear_cpu_cap(X86_FEATURE_FRED), so this table does not help clear
the dependent NMI_SOURCE, right?

In the next version, I will add runtime disable if HW malfunctions. i.e. no
valid bitmask.

Maybe we can also add a big WARN_ON like this:
if (WARN_ON_ONCE(!cpu_feature_enabled(X86_FEATURE_FRED) &&
		cpu_feature_enabled(X86_FEATURE_NMI_SOURCE)) 
	setup_clear_cpu_cap(X86_FEATURE_NMI_SOURCE);

Thanks,

Jacob
