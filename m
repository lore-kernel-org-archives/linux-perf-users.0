Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4B9481C6;
	Thu, 30 May 2024 17:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717091098; cv=none; b=FyJYnKpUDYYP8xjA+9NjPUNx1/CPFM/fsfsOad0R3k/hs4uD48x2BMhuOHDl2PgyFMtO1Q1gGmFSF/feJ0GudKHe7CONfLFaGk/Gm5/s+ui7VTOBNE9/e8BW6ALak5pH8CscfDfYca0fIOOSmZiUg5CqJHhEDNBXUQPkU+A3qrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717091098; c=relaxed/simple;
	bh=LzU4fduxN0HLuWP2lHcULDPGCQdGRiORLYFoTFRWZUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y+GK1JGbGleOPWECBbQ5iFTlAb23b4aHZXAzWr6VaK9jSm4C2IX57FqUKXbhrOsZ9HJ+X2c01OzZ1aBISTau34q1DAV3b/4ZwF4oipoOEBrkf4IDppg9FkpBGU61PXN+9pKOvWlbIR+J61gSGustFRSI/+ktKGSoX7T3kZ9Xweg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UmNWz3Y/; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UmNWz3Y/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717091097; x=1748627097;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LzU4fduxN0HLuWP2lHcULDPGCQdGRiORLYFoTFRWZUM=;
  b=UmNWz3Y/bfYIOROXFzU3JHjzsnBCMBuRYejENk0S8gA67APS5d32bP32
   39kqlLQpGIfLiYVobLP1zJJXBO6PKOQOGeSpkXCNG7svA3RvwdHxQiXYL
   QGoD+UA1JoS9riSCIdzTOpD9mBTUgHULKfIOPy9yaj6uHZcDH2ERAsaXH
   gjyL3fll89Vh80rUNnyoUFTQ5lzbt4kER77YPyIC6ByTUg/xLdfng/JDu
   Rd5DnB2Hm8Nd4M0idpZIKWMK29d1Kz202tsjoUN/36daqoLdCr4l2nYrs
   FqDnaDd6cj+Z0hmz0SgEXGMAoBvz5vLUfuEu5A7TF4cbP1z8wQkzpVYjm
   A==;
X-CSE-ConnectionGUID: FYwP2TXbQpmhQ1LQKw+/mQ==
X-CSE-MsgGUID: R9ugTSE5Ry6P6Berfcys3w==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13824684"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="13824684"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 10:44:56 -0700
X-CSE-ConnectionGUID: JqUZDqpZQP2pc6YeyiQvBw==
X-CSE-MsgGUID: 2uB/rriYQsSWqE6xZws35w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="40458761"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 10:44:56 -0700
Date: Thu, 30 May 2024 10:49:52 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: X86 Kernel <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@intel.com>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Andi Kleen <andi.kleen@intel.com>, Xin Li <xin3.li@intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 2/6] x86/irq: Extend NMI handler registration interface
 to include source
Message-ID: <20240530104952.477eab3d@jacob-builder>
In-Reply-To: <746fecd5-4c79-42f9-919e-912ec415e73f@zytor.com>
References: <20240529203325.3039243-1-jacob.jun.pan@linux.intel.com>
	<20240529203325.3039243-3-jacob.jun.pan@linux.intel.com>
	<746fecd5-4c79-42f9-919e-912ec415e73f@zytor.com>
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

On Wed, 29 May 2024 13:59:51 -0700, "H. Peter Anvin" <hpa@zytor.com> wrote:

> On 5/29/24 13:33, Jacob Pan wrote:
> > diff --git a/arch/x86/include/asm/irq_vectors.h
> > b/arch/x86/include/asm/irq_vectors.h index 13aea8fc3d45..b8388bc00cde
> > 100644 --- a/arch/x86/include/asm/irq_vectors.h
> > +++ b/arch/x86/include/asm/irq_vectors.h
> > @@ -105,6 +105,27 @@
> >   
> >   #define NR_VECTORS			 256
> >   
> > +/*
> > + * The NMI senders specify the NMI source vector as an 8bit integer in
> > their
> > + * vector field with NMI delivery mode. A local APIC receiving an NMI
> > will
> > + * set the corresponding bit in a 16bit bitmask, which is accumulated
> > until
> > + * the NMI is delivered.
> > + * When a sender didn't specify an NMI source vector the source vector
> > will
> > + * be 0, which will result in bit 0 of the bitmask being set. For out
> > of
> > + * bounds vectors >= 16 bit 0 will also be set.
> > + * When bit 0 is set, system software must invoke all registered NMI
> > handlers
> > + * as if NMI source feature is not enabled.
> > + */
> > +#define NMI_SOURCE_VEC_UNKNOWN		0
> > +#define NMI_SOURCE_VEC_PMI		1	/* PerfMon counters
> > */ +#define NMI_SOURCE_VEC_IPI_BT		2	/* CPU
> > backtrace */ +#define NMI_SOURCE_VEC_IPI_MCE		3	/*
> > MCE injection */ +#define NMI_SOURCE_VEC_IPI_KGDB		4
> > +#define NMI_SOURCE_VEC_IPI_REBOOT	5	/* Crash reboot */
> > +#define NMI_SOURCE_VEC_IPI_SMP_STOP	6	/* Panic stop CPU
> > */ +#define NMI_SOURCE_VEC_IPI_TEST		7	/* For
> > remote and local IPIs*/ +#define NR_NMI_SOURCE_VECTORS		8
> > +  
> 
> I would avoid using vector 2; it is at least remotely possible that some 
> third-party chipset sends NMI messages with a hardcoded vector of 2. As 
> long as you don't actively need that slot, it is better to avoid it.
> 
I thought about that as well, then I dropped that when I limit NMIS to
local interrupts. Not aware the hardcoded case as you mentioned.

I will reserve vector #2 to avoid future headache.

> Even better is to set the LINT1 (= external NMI) vector to 2 and treat 
> bit 2 as "other"; use vector 2 for anything that you don't have an 
> explicit vector for. You can treat a received bit 2 the same as bit 0, 
> except that you can explicitly trust that any event assigned an explicit 
> vector number is *NOT* triggered and so do not need to be polled.
> 
Make sense, will set LINT1 vector to 2 and avoid polling known sources.
That is another optimization.

> I would also recommend sorting these in order of decreasing importance 
> (other than 0 and 2). Although the current intent is there to be 16 
> vectors indefinitely, defensive design would be to consider that number 
> to be potentially variable (up to 64, obviously). Since any out-of-range 
> vector will set bit 0, the code will still Just Work[TM].
Will sort them.

Thanks,

Jacob
