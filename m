Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5287F224D4;
	Thu, 30 May 2024 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717085661; cv=none; b=fdEmfOkCuNg4LCfmWSX4igIopYq/p8o7XYWdfiAWcapFYm/FydweADkpRmUxNv4CDvE/lY+t+AlWju4YAG8TUxwygJkJj/1pbiY6AH9c4p2Szp/wfXVh8xDPrCgo2DtVht/DkTjyokAI7yBz4eiYYcn/dQvFWYqiry6aFElH0q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717085661; c=relaxed/simple;
	bh=vO9ICB2yAEetlEsTPbH9D4zJdMe3WF2DAv8xb1Z1tAg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S6c+21UD0xETFjBP738WxGoviSz7zp0PlLJFxrf1/DkiJXL4dff/qnrkM7NvTqyR6hbWl3X2r/GUExPyB4U4v+WLQoNGbPKGeaVc+vR35d8IdRCMN3VQVryybOzIyyxqMVVSHfGpCP8HX4VYvuJGHreXUhevq0t5VlSSdGTQbio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fCUKYoIJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fCUKYoIJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717085660; x=1748621660;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vO9ICB2yAEetlEsTPbH9D4zJdMe3WF2DAv8xb1Z1tAg=;
  b=fCUKYoIJGUjPujRfKe8EkKJWrrLVO9HJIvGXBjcBsZN7cIGYPu0dTCe4
   bvopC65I7G4hpuQ9DESyGr32596T4pYzDfhc2OqNj6keByeUYS0cwyhV1
   A+FjcP8xLiHBwon8+0b53ocqhV1t7lL0l24fS+zrSqsVZSqJvkntn3OMb
   AD7UQeMO+/8MEqukVxCZfPtcCpAt/5TKio3ZHJMFGaL+aIYG7wWSCUwkT
   IoSxq5O6TE7qkJIMxzxEpZyBFF/RvUVXuYf4w15b6inwIBOOLjF2JWc8C
   c6tfvf4XjQLVildhoKv3m54KidNq8kTP8Eu/m5O1oKpwiwWL4vVow3Nbi
   Q==;
X-CSE-ConnectionGUID: PkzVj07nRhCpzh+T861L/Q==
X-CSE-MsgGUID: 6IjnvU9BSR2oeHI+aUMNHA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="17417120"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="17417120"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 09:14:20 -0700
X-CSE-ConnectionGUID: VBEg22EZSgmNrAnc22YIUw==
X-CSE-MsgGUID: lNUcn36hSAGcvBZ9YFy71A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="36486185"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 09:14:19 -0700
Date: Thu, 30 May 2024 09:19:16 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: X86 Kernel <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@intel.com>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Andi Kleen <andi.kleen@intel.com>, Xin Li <xin3.li@intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 1/6] x86/irq: Add enumeration of NMI source reporting
 CPU feature
Message-ID: <20240530091916.54056820@jacob-builder>
In-Reply-To: <9dabe435-7208-4aa8-886c-a3351ee11e80@zytor.com>
References: <20240529203325.3039243-1-jacob.jun.pan@linux.intel.com>
	<20240529203325.3039243-2-jacob.jun.pan@linux.intel.com>
	<9dabe435-7208-4aa8-886c-a3351ee11e80@zytor.com>
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

On Wed, 29 May 2024 13:49:40 -0700, "H. Peter Anvin" <hpa@zytor.com> wrote:

> On 5/29/24 13:33, Jacob Pan wrote:
> > diff --git a/arch/x86/kernel/cpu/cpuid-deps.c
> > b/arch/x86/kernel/cpu/cpuid-deps.c index b7d9f530ae16..3f1a1a1961fa
> > 100644 --- a/arch/x86/kernel/cpu/cpuid-deps.c
> > +++ b/arch/x86/kernel/cpu/cpuid-deps.c
> > @@ -84,6 +84,7 @@ static const struct cpuid_dep cpuid_deps[] = {
> >   	{ X86_FEATURE_SHSTK,
> > X86_FEATURE_XSAVES    }, { X86_FEATURE_FRED,
> > X86_FEATURE_LKGS      }, { X86_FEATURE_FRED,
> > X86_FEATURE_WRMSRNS   },
> > +	{ X86_FEATURE_FRED,
> > X86_FEATURE_NMI_SOURCE}, {}
> >   };
> >     
> 
> This is incorrect. FRED does *not* inherently depend on NMI_SOURCE; the 
> dependency is the reverse, but since it *also* depends on FRED being 
> dynamically enabled, there is no need to add it to the static table; the 
> dynamic test:
> 
My misunderstanding of the dependency table, thanks for pointing it out.
Will remove.

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
> ... suffices just fine on its own.
I am not following, do you mean checking for FRED is sufficient for NMI
source? I think it works since NMI source cannot be disabled if FRED is on.
Just want to use the architectural CPUID bits to the fullest.


Thanks,

Jacob
