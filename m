Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84EF14D2AC;
	Mon,  1 Jul 2024 16:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719851617; cv=none; b=aVmsrsJp9tCACyWUtPtl/Vbob6vNHIlJH//vcUhzUjL+MiWQX2iARZJietpS7+CPz6qORQnIskzG2yhIJg4j+qjiWGLe/AIN0KZUnoAwMpMqTCkUMDGy8SxnNmM3+Gs4GxsjXs7d586FDCOhI4Ohc+vzOt4jjxwqzEdj8zxFidg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719851617; c=relaxed/simple;
	bh=jbP1tKebowex1to7GOL6gesMVgJqYoDaSfBtDnkom/w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PEJnuVf+mift7gOvKoSYZskkobZT+89gIi0fGVijpGPljTLOf7x84q3hwRAG/Uj2Y5XAkJT+NE6Kyr1aJmKTCmTQHCqemW2z89ymCWdCWlD11XruMO5k9dAu/kAmUkbCfXs4HzPsypR09zynXPIHTRsebhQSGTa2nQO9Od//u9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iUK8THQs; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iUK8THQs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719851616; x=1751387616;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jbP1tKebowex1to7GOL6gesMVgJqYoDaSfBtDnkom/w=;
  b=iUK8THQsasnKU+mAVitqkPwawNUGu/xZEbinh3VfN2KcHVG2ibdydxc3
   Ro+V70ECOuNyi2CaVJWpBV5TzResCEPY6fyRWI0MlSxuAs8Tnpn7zc2RW
   uzm1rOeBYCzNWjTjjG5hM+6uXPnRiPdygPPvnux+5dc1Q7y2nFx7Xvtbt
   7AH8tNu4nco75ezrPMCUz2AqP5t28+brkCQjDrHaYlk7HpI3L6PXN8v2u
   Evk8IHNOyy829Rf5v1YDQx3u+8lE41fh5BdjErlXzYtKiC3PcrN1kqcN+
   o836+IjKKLGyjvc+fk2RADegCFX4gK6lARaUvxzPLFwAn2sQ6CodBN2jU
   A==;
X-CSE-ConnectionGUID: 4GIRvZ0ERfikS8sVmf17jA==
X-CSE-MsgGUID: 3e8x+xFAQmW+bk0UQwRwBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="17120641"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="17120641"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 09:33:35 -0700
X-CSE-ConnectionGUID: NvlDRiKRSAig7f0SKFg6NQ==
X-CSE-MsgGUID: axg3MeE2TzSF4iHtuDdYbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="46238427"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 09:33:35 -0700
Date: Mon, 1 Jul 2024 09:38:47 -0700
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
 Sohil" <sohil.mehta@intel.com>, Zeng Guang <guang.zeng@intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 11/11] KVM: X86: Use common code for PV IPIs in linux
 guest
Message-ID: <20240701093847.3f875868@jacob-builder>
In-Reply-To: <ca060eaf-0ace-4a8e-af86-a45b6f32340e@zytor.com>
References: <20240628201839.673086-1-jacob.jun.pan@linux.intel.com>
	<20240628201839.673086-12-jacob.jun.pan@linux.intel.com>
	<ca060eaf-0ace-4a8e-af86-a45b6f32340e@zytor.com>
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


On Sat, 29 Jun 2024 11:38:10 -0700, Xin Li <xin@zytor.com> wrote:

> On 6/28/2024 1:18 PM, Jacob Pan wrote:
> > Paravirtual apic hooks to enable PV IPIs for KVM if the "send IPI"  
> 
> s/Paravirtual apic/Paravirtualize APIC/

Paravirtual APIC makes sense to me. This is also the same language used in
previous commits.

How about:

"The paravirtual APIC hooks in KVM, some of which are used for sending PV
IPIs, can reuse common code for ICR preparation. This shared code also
encompasses NMI-source reporting when in effect."

> > hypercall is available. Reuse common code for ICR preparation which
> > covers NMI-source reporting if in effect.  
> 
> I see a lot of "NMI source". Should we use "NMI-source" in all places?
Not really, here NMI-source is a compound modifier before noun "reporting".

For other places, hyphen(-) is not needed if it is just a noun. e.g.
"partial due to unknown NMI sources"

I will go through the patchset to make sure they are consistent.

> > 
> > Originally-by: Zeng Guang <guang.zeng@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >   arch/x86/kernel/kvm.c | 10 +---------
> >   1 file changed, 1 insertion(+), 9 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> > index 263f8aed4e2c..a45d60aa0302 100644
> > --- a/arch/x86/kernel/kvm.c
> > +++ b/arch/x86/kernel/kvm.c
> > @@ -516,15 +516,7 @@ static void __send_ipi_mask(const struct cpumask
> > *mask, int vector) 
> >   	local_irq_save(flags);
> >   
> > -	switch (vector) {
> > -	default:
> > -		icr = APIC_DM_FIXED | vector;
> > -		break;
> > -	case NMI_VECTOR:
> > -		icr = APIC_DM_NMI;
> > -		break;
> > -	}
> > -
> > +	icr = __prepare_ICR(0, vector, 0);
> >   	for_each_cpu(cpu, mask) {
> >   		apic_id = per_cpu(x86_cpu_to_apicid, cpu);
> >   		if (!ipi_bitmap) {  
> 


Thanks,

Jacob
