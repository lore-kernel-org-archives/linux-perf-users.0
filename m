Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C066881E;
	Sat,  6 Jul 2024 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720305879; cv=none; b=daceC64R1r9JPl9Qar7xTFTBG01b9et1URjvkco+e70TNt7DQoW48m77qNPlyN22qMxR//XE6v0NTTxWUqQvSItTgSMeIhnI1gVF7zcgZ0FDTc4CLmjJmDv7kAWF0TczGNSnF5ak5vLQ0pr0njo/vlSzdbD8rgqzXv1HYoTgScs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720305879; c=relaxed/simple;
	bh=WQySAcpdbRQmQL4PCMwk5G7kS07P/ADMvxxt0WpGKRw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jk9+/gbxbl+EmVapwTADyhFc4cp7R9yf75lW7xHdrtcdl+H04e5gEZfp8yeMbRdDhhIXxKszIS1IXL70rxPWBok8aBbsukqPjqygKLQfC2vCoxJVjdG975IvrSJBrzBvLbj15ufR4DZKv5wUyRStpBiVPDiLPhJYU/z+M6EkYng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HHo6cmX/; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HHo6cmX/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720305878; x=1751841878;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WQySAcpdbRQmQL4PCMwk5G7kS07P/ADMvxxt0WpGKRw=;
  b=HHo6cmX/fjOYs1R5lNizQGg4VGtJHQC6h1LEKcvpdStUJLmApRNZSdYq
   pyj42si9tDC+dt8acrE89KXm6hn40UmUiIbbchVcGcyHZs4motYfAV9oc
   D4ufbuRYzQAeX1L1HSFtm47s4E50JA+ag2s/K/ZFk+pOLQjzskJVLrJKG
   WqxtQDEr+pxmKkeDwGFOF6+qy0jpcPzPfTYmfZEXs1UIXBzujMqamZXDn
   yxG8cHDmKn4/TnGMmbdH0os4DJAXDDInRGhlGSEQeR4H0m0iZM/vXlCPk
   GP40U0zURAIXxblA8MCnEtY2Gc2QknFgRDU2P8EvlmbaPGPcOjv0jQGHZ
   w==;
X-CSE-ConnectionGUID: kqQAxcayThq+x6FfPBxHhg==
X-CSE-MsgGUID: UI8gMLXUT5e4NAH4SBDoBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11125"; a="17756088"
X-IronPort-AV: E=Sophos;i="6.09,188,1716274800"; 
   d="scan'208";a="17756088"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 15:44:37 -0700
X-CSE-ConnectionGUID: v4wp8Vc9TnyrP3ci4ZPCOA==
X-CSE-MsgGUID: gWFq5QX3Rhe2NUcc64yoTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,188,1716274800"; 
   d="scan'208";a="84688673"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 15:44:37 -0700
Date: Sat, 6 Jul 2024 15:49:51 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: X86 Kernel <x86@kernel.org>, Sean Christopherson <seanjc@google.com>,
 LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Xin Li
 <xin3.li@intel.com>, linux-perf-users@vger.kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, Tony Luck
 <tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>, acme@kernel.org,
 Andi Kleen <andi.kleen@intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
 Zeng Guang <guang.zeng@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 08/11] perf/x86: Enable NMI source reporting for
 perfmon
Message-ID: <20240706154951.4852b8c4@jacob-builder>
In-Reply-To: <f5ec09c0-db5e-4c2f-b516-964e8d7eb2af@linux.intel.com>
References: <20240628201839.673086-1-jacob.jun.pan@linux.intel.com>
	<20240628201839.673086-9-jacob.jun.pan@linux.intel.com>
	<f5ec09c0-db5e-4c2f-b516-964e8d7eb2af@linux.intel.com>
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


On Thu, 4 Jul 2024 10:44:23 -0400, "Liang, Kan" <kan.liang@linux.intel.com>
wrote:

> On 2024-06-28 4:18 p.m., Jacob Pan wrote:
> > Program the designated NMI source vector into the performance monitoring
> > interrupt (PMI) of the local vector table. PMI handler will be directly
> > invoked when its NMI is generated. This avoids the latency of calling
> > all NMI handlers blindly.
> > 
> > Co-developed-by: Zeng Guang <guang.zeng@intel.com>
> > Signed-off-by: Zeng Guang <guang.zeng@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > 
> > ---
> > v3: Program NMI source vector in PVTPC unconditionally (HPA)
> > v2: Fix a compile error apic_perfmon_ctr is undefined in i386 config
> > ---
> >  arch/x86/events/core.c       | 6 ++++--
> >  arch/x86/events/intel/core.c | 6 +++---
> >  arch/x86/include/asm/apic.h  | 1 +
> >  3 files changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > index 1ef2201e48ac..be75bdcdd400 100644
> > --- a/arch/x86/events/core.c
> > +++ b/arch/x86/events/core.c
> > @@ -46,6 +46,7 @@
> >  
> >  struct x86_pmu x86_pmu __read_mostly;
> >  static struct pmu pmu;
> > +u32 apic_perfmon_ctr = APIC_DM_NMI;>
> >  DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = {
> >  	.enabled = 1,
> > @@ -1680,7 +1681,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
> >  	 * This generic handler doesn't seem to have any issues where
> > the
> >  	 * unmasking occurs so it was left at the top.
> >  	 */
> > -	apic_write(APIC_LVTPC, APIC_DM_NMI);
> > +	apic_write(APIC_LVTPC, apic_perfmon_ctr);
> >  
> >  	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
> >  		if (!test_bit(idx, cpuc->active_mask))
> > @@ -1723,7 +1724,8 @@ void perf_events_lapic_init(void)
> >  	/*
> >  	 * Always use NMI for PMU
> >  	 */
> > -	apic_write(APIC_LVTPC, APIC_DM_NMI);
> > +	apic_perfmon_ctr |= NMI_SOURCE_VEC_PMI;
> > +	apic_write(APIC_LVTPC, apic_perfmon_ctr);  
> 
> 
> It looks like the same value is written unconditionally.
> 
> Why not use a macro, e.g., APIC_DM_NMI_WITH_SOURCE, to replace the
> variable?
> 
yes, it is unconditional now. I will use the following:

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -30,6 +30,8 @@
 #define APIC_EXTNMI_ALL                1
 #define APIC_EXTNMI_NONE       2

+#define APIC_PERF_NMI          (APIC_DM_NMI | NMI_SOURCE_VEC_PMI)


Thanks,

Jacob
