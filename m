Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3D025634;
	Thu, 30 May 2024 20:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717101304; cv=none; b=B/2CGkBNgIVGb1eG32Rl7URoaTkNG5IrTE5Pw4LtzBK/uPtF55f0et3CpxdSTlaojiXBvH7Zt5nxXYXz51cHEXWKwDcwGM9zwtfW3xIsNp/U6oIAAqTTr+JyZ/zrW8wWtRZsPc1wsEp1+vaUCeQfgaQKbUf2eWVlCuTKySqmXlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717101304; c=relaxed/simple;
	bh=kAKen4NyriQ88zKA+tglPnCd/Pr0Xbljz36Nbgay9Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZafJWQvSSG77GcdI4QAjSTXYw70UOGgDIhtTu0hX1g9ZPazaa6QeO6CyvQN5FezcJNrUhQAcdvCyZ2+qu/n4KhWfjG61WzhHG1xUTIMWLZlOxw6qxiSriELq9HHLVZuVlSZQHJLvCxpKSfBpnts4b7kg13bwRNwneCIG9y8mZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EdXkL8O4; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EdXkL8O4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717101303; x=1748637303;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kAKen4NyriQ88zKA+tglPnCd/Pr0Xbljz36Nbgay9Qo=;
  b=EdXkL8O4rLGjVsPTioHQqVMZ2z/f1NLjtMAPvw6+Na1iyaoPUUa8KSit
   R8gstQM9NzQx99F0R4Kv6Sk08idCsLr5XoTLf8DWSPd7v7lu6xPatCt7I
   HnCPNBsTUiiJpsvaCImfkIsv+rxZ7Pm9bQSQK3DMMToVGN/ESXgOC4bfE
   5h9w7loWD5lGAoeoKL7P/kTi1NveHmG11+tu2MxHA5wW08/y3KiJfqH+6
   NfhPpMStoXYtZ4M9e4lICLwpReJQskObLjmaDS3+ePPFKnUYQabjV2odM
   lgqfFBRus2qjYS0ytH3zFKjDNrFV8umX81HWT1oEnay6wT/GUSRhT6e/B
   Q==;
X-CSE-ConnectionGUID: NQqhdIpSRvSOrq/B2vdaLA==
X-CSE-MsgGUID: Q0wEa24ARpqRrLBokVqjVQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13816728"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="13816728"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 13:35:02 -0700
X-CSE-ConnectionGUID: ZC/1h9rtQlaQZtkVvz9Niw==
X-CSE-MsgGUID: CT6c8GOnSymlhdPdSxMcbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="40855571"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 13:35:02 -0700
Date: Thu, 30 May 2024 13:39:58 -0700
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
Message-ID: <20240530133958.229975d1@jacob-builder>
In-Reply-To: <20240530091916.54056820@jacob-builder>
References: <20240529203325.3039243-1-jacob.jun.pan@linux.intel.com>
	<20240529203325.3039243-2-jacob.jun.pan@linux.intel.com>
	<9dabe435-7208-4aa8-886c-a3351ee11e80@zytor.com>
	<20240530091916.54056820@jacob-builder>
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

Hi Jacob,

On Thu, 30 May 2024 09:19:16 -0700, Jacob Pan
<jacob.jun.pan@linux.intel.com> wrote:

> Hi Peter,
> 
> On Wed, 29 May 2024 13:49:40 -0700, "H. Peter Anvin" <hpa@zytor.com>
> wrote:
> 
> > On 5/29/24 13:33, Jacob Pan wrote:  
> > > diff --git a/arch/x86/kernel/cpu/cpuid-deps.c
> > > b/arch/x86/kernel/cpu/cpuid-deps.c index b7d9f530ae16..3f1a1a1961fa
> > > 100644 --- a/arch/x86/kernel/cpu/cpuid-deps.c
> > > +++ b/arch/x86/kernel/cpu/cpuid-deps.c
> > > @@ -84,6 +84,7 @@ static const struct cpuid_dep cpuid_deps[] = {
> > >   	{ X86_FEATURE_SHSTK,
> > > X86_FEATURE_XSAVES    }, { X86_FEATURE_FRED,
> > > X86_FEATURE_LKGS      }, { X86_FEATURE_FRED,
> > > X86_FEATURE_WRMSRNS   },
> > > +	{ X86_FEATURE_FRED,
> > > X86_FEATURE_NMI_SOURCE}, {}
> > >   };
> > >       
> > 
> > This is incorrect. FRED does *not* inherently depend on NMI_SOURCE; the 
> > dependency is the reverse, but since it *also* depends on FRED being 
> > dynamically enabled, there is no need to add it to the static table;
> > the dynamic test:
> >   
> My misunderstanding of the dependency table, thanks for pointing it out.
> Will remove.
> 
> > > diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> > > index 4fa0b17e5043..465f04e4a79f 100644
> > > --- a/arch/x86/kernel/traps.c
> > > +++ b/arch/x86/kernel/traps.c
> > > @@ -1427,8 +1427,10 @@ early_param("fred", fred_setup);
> > >  
> > >  void __init trap_init(void)
> > >  {
> > > -	if (cpu_feature_enabled(X86_FEATURE_FRED) && !enable_fred)
> > > +	if (cpu_feature_enabled(X86_FEATURE_FRED) && !enable_fred) {
> > >  		setup_clear_cpu_cap(X86_FEATURE_FRED);
> > > +		setup_clear_cpu_cap(X86_FEATURE_NMI_SOURCE);
> > > +	}
> > >  
> > >  	/* Init cpu_entry_area before IST entries are set up */
> > >  	setup_cpu_entry_areas();    
> > 
> > ... suffices just fine on its own.  
> I am not following, do you mean checking for FRED is sufficient for NMI
> source? I think it works since NMI source cannot be disabled if FRED is
> on. Just want to use the architectural CPUID bits to the fullest.
> 
Nevermind, I got it now, will keep the dynamic test.


Thanks,

Jacob
