Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6629C16EB6A;
	Mon,  1 Jul 2024 17:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719856549; cv=none; b=FOOb6R6oSoiuNYu2bqelLyM6OqbDuU3mWZGTcxrSnssczIm14ODy9mAgHpco9w/EL+hmW3I+kB7INQd7liu+xl9/bj0vSup3suu9PzJTnZQqUonZ9IjomsY7HdJZgY97GayCqez2vr76uV1KiT6ySrBtl94XY7ayX18oy/2xV9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719856549; c=relaxed/simple;
	bh=SGQJsHnQ5hH73LkMg9W47h+XoIg3nmMQ48iQr3+H3sY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dS4oQLSvb3DRVn4VcegZC6EbpNAszh68WhV0L/tKAwZ1K91leo0wnUtcuPmeF9OUQ8l+s09XP0XotuG6C2crEHEz67bNUoigik7GQ5kZ3PI30h8M5QYMHawkv4CA+C/xpnuMS18gGZD3RKZrc81WPkd+sZYaPr6vDwO5808zIdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Me7R+7ax; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Me7R+7ax"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719856547; x=1751392547;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SGQJsHnQ5hH73LkMg9W47h+XoIg3nmMQ48iQr3+H3sY=;
  b=Me7R+7axUMNfMWxGttgnb+89XbTsKhSmWZFpkdmgE7LxZuC4a9QuN4fa
   5bhgmXcnygT4fmlqfXECJZAQKYYLMoDRs07VVYypPJPAX/xPaUMxmuHGG
   YYyDybgrA4BL/600MyG0NDkB7e8z+5/W6PY6aY1Ht4kC6f/I07h9xKQlm
   H5stO5bd8RXPvsYqEuVvoQZa2P7mfOmh2DhBp1sc/gFPgZC+w9rVVt23z
   6CunIOt+YtYBR6saP0Qx4qEsTzVcbyV1TVrFsp4gDMxNHK121YV/fB1Ng
   bYSp/elPueeWzFC/+KKLYAJpHa0CfgLfliS8o2UmZfX7jBNjGCp2Id5cs
   g==;
X-CSE-ConnectionGUID: soQ9o0/nS5iazJpkUfDtgw==
X-CSE-MsgGUID: U+riKPaDQ+i6Vcy4D0tgpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="34542838"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="34542838"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 10:55:46 -0700
X-CSE-ConnectionGUID: VvlaK8fdRBex0s2yHtTBBA==
X-CSE-MsgGUID: Hy0V87hJRWagHoxyaofFRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="46263903"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 10:55:47 -0700
Date: Mon, 1 Jul 2024 11:00:58 -0700
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
Message-ID: <20240701110058.098c6445@jacob-builder>
In-Reply-To: <51768b50-96ac-49a7-a63b-02d2b94c2c6a@zytor.com>
References: <20240628201839.673086-1-jacob.jun.pan@linux.intel.com>
	<20240628201839.673086-8-jacob.jun.pan@linux.intel.com>
	<6c8160e4-3d67-410d-aad0-3ec731a903f8@zytor.com>
	<20240701084558.1620584f@jacob-builder>
	<51768b50-96ac-49a7-a63b-02d2b94c2c6a@zytor.com>
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


On Mon, 1 Jul 2024 10:03:58 -0700, Xin Li <xin@zytor.com> wrote:

> On 7/1/2024 8:45 AM, Jacob Pan wrote:
> > 
> > On Fri, 28 Jun 2024 21:07:04 -0700, Xin Li <xin@zytor.com> wrote:
> >   
> >> On 6/28/2024 1:18 PM, Jacob Pan wrote:  
> >>> From: Zeng Guang <guang.zeng@intel.com>
> >>>
> >>> If the "NMI exiting" VM-execution control is 1, the value of the
> >>> 16-bit NMI source vector is saved in the exit-qualification field in
> >>> the VMCS when VM exits occur on CPUs that support NMI source.
> >>>
> >>> KVM that is aware of NMI-source reporting will push the bitmask of NMI
> >>> source vectors as the exceptoin event data field on the stack for then
> >>> entry of FRED exception. Subsequently, the host NMI exception handler
> >>> is invoked which will process NMI source information in the event
> >>> data. This operation is independent of vCPU FRED enabling status.
> >>>
> >>> Signed-off-by: Zeng Guang <guang.zeng@intel.com>
> >>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >>> ---
> >>>    arch/x86/entry/entry_64_fred.S |  2 +-
> >>>    arch/x86/kvm/vmx/vmx.c         | 11 ++++++++---
> >>>    2 files changed, 9 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/arch/x86/entry/entry_64_fred.S
> >>> b/arch/x86/entry/entry_64_fred.S index a02bc6f3d2e6..0d934a3fcaf8
> >>> 100644 --- a/arch/x86/entry/entry_64_fred.S
> >>> +++ b/arch/x86/entry/entry_64_fred.S
> >>> @@ -92,7 +92,7 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
> >>>    	 * +--------+-----------------+
> >>>    	 */
> >>>    	push $0				/* Reserved, must
> >>> be 0 */
> >>> -	push $0				/* Event data, 0 for
> >>> IRQ/NMI */
> >>> +	push %rsi			/* Event data for IRQ/NMI */
> >>>    	push %rdi			/* fred_ss handed in by
> >>> the caller */ push %rbp
> >>>    	pushf  
> >>
> >> This belongs to the previous patch, it is part of the host changes.  
> > right, will do.
> >   
> >>  
> >>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> >>> index 4e7b36081b76..6719c598fa5f 100644
> >>> --- a/arch/x86/kvm/vmx/vmx.c
> >>> +++ b/arch/x86/kvm/vmx/vmx.c
> >>> @@ -7331,10 +7331,15 @@ static noinstr void vmx_vcpu_enter_exit(struct
> >>> kvm_vcpu *vcpu, if ((u16)vmx->exit_reason.basic ==
> >>> EXIT_REASON_EXCEPTION_NMI && is_nmi(vmx_get_intr_info(vcpu))) {
> >>>    		kvm_before_interrupt(vcpu, KVM_HANDLING_NMI);
> >>> -		if (cpu_feature_enabled(X86_FEATURE_FRED))
> >>> -			fred_entry_from_kvm(EVENT_TYPE_NMI,
> >>> NMI_VECTOR, 0);
> >>> -		else
> >>> +		if (cpu_feature_enabled(X86_FEATURE_FRED)) {
> >>> +			unsigned long edata = 0;
> >>> +
> >>> +			if
> >>> (cpu_feature_enabled(X86_FEATURE_NMI_SOURCE))
> >>> +				edata = vmx_get_exit_qual(vcpu);
> >>> +			fred_entry_from_kvm(EVENT_TYPE_NMI,
> >>> NMI_VECTOR, edata);  
> >>
> >> Simply do fred_entry_from_kvm(EVENT_TYPE_NMI, NMI_VECTOR,
> >> vmx_get_exit_qual(vcpu))?  
> > I don't have strong preference but having a local variable improves
> > readability IMHO.  
> 
> My point was, do we actually need this check:
>      (cpu_feature_enabled(X86_FEATURE_NMI_SOURCE)?
I also pondered about the value of this CPUID bit if it is consistently
linked with the FRED bit. But since the architecture provided this
additional enumeration, as noted in Chapter 9 of the FRED specification,
which states: 

"Processors that support FRED *may* also support a related feature called
NMI-source reporting".

The use of "may" suggests that there are scenarios where FRED might exist
without NMI-source reporting. To ensure future compatibility, I believe
it is still valid to maintain this check.


Thanks,

Jacob
