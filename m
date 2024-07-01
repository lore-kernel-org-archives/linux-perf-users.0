Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0C253AC;
	Mon,  1 Jul 2024 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719848449; cv=none; b=qDfxuF1sjKqAmaaRHYJd0Juz3teUW4su5A5QOWupKhdwkXh4buX2L/PWgRgGRv6zuk+2ZYBB4tK615VchfS0WoEvIdq+rMDfkKsmiJibgJci7Rw0ltBVA9iSlbwY5LnRoDr0rbDoecYKnLedjUVxpO0lJ7ZHK6BmQSpAhBg8w50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719848449; c=relaxed/simple;
	bh=een/u44RHHbOSr8wUZ1YivcJUZUcGARZ5X9uyg30b84=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WhTLCWUavf6Zpw+toe8UsX0EJd3pUA0WYGwSYc/US6NwrwDAX8s60YijHmcM6PN3UQ4pD3Bc35BWEvjVqbgjna32MNO+2V7zKwsqrjfwo+CUKARsPFe4yQZLZkPjePaflTe0Ze1sMWr4YqcIIpsP1UUAu9AjGyViyTmncKbQ3Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P+Ia4RYV; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P+Ia4RYV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719848448; x=1751384448;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=een/u44RHHbOSr8wUZ1YivcJUZUcGARZ5X9uyg30b84=;
  b=P+Ia4RYVrbCFWpoXBf5VEnUQtKTbUeG/Y0bYQXWo5rZt4Un+cfjltCz+
   xiOfr0t02M/niF2ElYmU3r7bgp49fPbDRamnoObqpfwmHUAO3HS3dRZdg
   p4tZuXpE/VrRwaTpdkEPV6pU2Uxqk9sSpEeRcK7Ov9sZ/qFd3jYU03afY
   wpVtC1eZ46IjG1KL0xaiS+LYOyH7eNHJ23FP9YODVObYGIJBCIVkIgBl8
   xykDT4E6F4s25XQ+aHtwSfCQjnFST7u3DS0b+Bg0Ku9EyJvHHFaUqmwO2
   eI0tFqPc6hd5K8bjD25yNr/l28w/ZfKAw5Ao17xyKwXKuJt8zjlrgTe06
   w==;
X-CSE-ConnectionGUID: 7/ob2AhORHunWMvr9Gh8WQ==
X-CSE-MsgGUID: oD2MTkcFSZiyT6TpXO6p0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="34528148"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="34528148"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 08:40:47 -0700
X-CSE-ConnectionGUID: A81hiQBvSMmHLYpz/Tm3MQ==
X-CSE-MsgGUID: t2s5aAH9QGi/ZScpGyvL/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="49917494"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 08:40:46 -0700
Date: Mon, 1 Jul 2024 08:45:58 -0700
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
Subject: Re: [PATCH v3 07/11] KVM: VMX: Handle NMI Source report in VM exit
Message-ID: <20240701084558.1620584f@jacob-builder>
In-Reply-To: <6c8160e4-3d67-410d-aad0-3ec731a903f8@zytor.com>
References: <20240628201839.673086-1-jacob.jun.pan@linux.intel.com>
	<20240628201839.673086-8-jacob.jun.pan@linux.intel.com>
	<6c8160e4-3d67-410d-aad0-3ec731a903f8@zytor.com>
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


On Fri, 28 Jun 2024 21:07:04 -0700, Xin Li <xin@zytor.com> wrote:

> On 6/28/2024 1:18 PM, Jacob Pan wrote:
> > From: Zeng Guang <guang.zeng@intel.com>
> > 
> > If the "NMI exiting" VM-execution control is 1, the value of the 16-bit
> > NMI source vector is saved in the exit-qualification field in the VMCS
> > when VM exits occur on CPUs that support NMI source.
> > 
> > KVM that is aware of NMI-source reporting will push the bitmask of NMI
> > source vectors as the exceptoin event data field on the stack for then
> > entry of FRED exception. Subsequently, the host NMI exception handler
> > is invoked which will process NMI source information in the event data.
> > This operation is independent of vCPU FRED enabling status.
> > 
> > Signed-off-by: Zeng Guang <guang.zeng@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >   arch/x86/entry/entry_64_fred.S |  2 +-
> >   arch/x86/kvm/vmx/vmx.c         | 11 ++++++++---
> >   2 files changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/entry/entry_64_fred.S
> > b/arch/x86/entry/entry_64_fred.S index a02bc6f3d2e6..0d934a3fcaf8 100644
> > --- a/arch/x86/entry/entry_64_fred.S
> > +++ b/arch/x86/entry/entry_64_fred.S
> > @@ -92,7 +92,7 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
> >   	 * +--------+-----------------+
> >   	 */
> >   	push $0				/* Reserved, must be 0
> > */
> > -	push $0				/* Event data, 0 for
> > IRQ/NMI */
> > +	push %rsi			/* Event data for IRQ/NMI */
> >   	push %rdi			/* fred_ss handed in by the
> > caller */ push %rbp
> >   	pushf  
> 
> This belongs to the previous patch, it is part of the host changes.
right, will do.

> 
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index 4e7b36081b76..6719c598fa5f 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -7331,10 +7331,15 @@ static noinstr void vmx_vcpu_enter_exit(struct
> > kvm_vcpu *vcpu, if ((u16)vmx->exit_reason.basic ==
> > EXIT_REASON_EXCEPTION_NMI && is_nmi(vmx_get_intr_info(vcpu))) {
> >   		kvm_before_interrupt(vcpu, KVM_HANDLING_NMI);
> > -		if (cpu_feature_enabled(X86_FEATURE_FRED))
> > -			fred_entry_from_kvm(EVENT_TYPE_NMI,
> > NMI_VECTOR, 0);
> > -		else
> > +		if (cpu_feature_enabled(X86_FEATURE_FRED)) {
> > +			unsigned long edata = 0;
> > +
> > +			if
> > (cpu_feature_enabled(X86_FEATURE_NMI_SOURCE))
> > +				edata = vmx_get_exit_qual(vcpu);
> > +			fred_entry_from_kvm(EVENT_TYPE_NMI,
> > NMI_VECTOR, edata);  
> 
> Simply do fred_entry_from_kvm(EVENT_TYPE_NMI, NMI_VECTOR, 
> vmx_get_exit_qual(vcpu))?
I don't have strong preference but having a local variable improves
readability IMHO.

> > +		} else {
> >   			vmx_do_nmi_irqoff();
> > +		}
> >   		kvm_after_interrupt(vcpu);
> >   	}
> >     
> 


Thanks,

Jacob
