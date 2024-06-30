Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EC4139CFE;
	Sun, 30 Jun 2024 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719752688; cv=none; b=WFtoa3yjEpqGJ/BAnsflEah1K1KSbqhZcGhFtpdSgHlzrPK51/bTMJPADhNg+Lu2PwUrvKurmzsrEU6db0rt7X9q+0e1DPD5q6i8ihLqJZCB6o8ZkgoFimiTVJfS0sTgWL5kbLmhQx5jHIYJO9rCrAboSvs2C7LSYO33SV3ZlHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719752688; c=relaxed/simple;
	bh=RrLWiQBjsoYvNfIZgXYkVgvN4JQKRcw545/SAmBihDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJI15hVmR35azkhyJwXgTr2G0WzTtqZpP57rJ998Ph3DfKor0d06M6dfnCMAqgApwrRcX9DRCLw1GXfdnQjH6oABEVB+ZMwmv2GAC29IjGU/d62gSUHeIVYcXCiWYXQ9tpQX97hiA2YVdNsTkhUp1/cjKsbHggNqnnIbefAOQ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U7CCIXnn; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U7CCIXnn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719752686; x=1751288686;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RrLWiQBjsoYvNfIZgXYkVgvN4JQKRcw545/SAmBihDA=;
  b=U7CCIXnnYHJptefMWf1gsdoXYk70fi34CBOwW5Sza8lGt8+lwBmLcumb
   MfKHcXRA9WIBe6ejoto84kjnaA9U5OaKijjPXIglKPmZtOLnjjqmtCKvu
   gdjfb8uETPwjQONdGYmjt6CuexEAF4KJbfWgscyHRlMQ2nNedJ9Gwp19N
   xGMGZjyugwEUKBBYoJjjwy8iDB4KY3e1i/TXepTWerRI9dPRdyU1jx5w+
   l6Omb3K0Yr6h3djldLXRdWD9NeeAHGgJu5VGXCoDpC77fNMuIGw9OjKNN
   eVZT+X13KO/pmkU0vuh8lHsUYpEngCmWbYAzDjdoxmXQsfR/ynq5oYonB
   Q==;
X-CSE-ConnectionGUID: gkwEg9QwSkupgIAr5JKohA==
X-CSE-MsgGUID: MWCkjEf8SoCbPARQ6qA+Vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="17008626"
X-IronPort-AV: E=Sophos;i="6.09,174,1716274800"; 
   d="scan'208";a="17008626"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2024 06:04:45 -0700
X-CSE-ConnectionGUID: 2J2qHSVbSYK4K8q+LkPhsw==
X-CSE-MsgGUID: JwSXk9YAQ1eH2sbNyLxsKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,174,1716274800"; 
   d="scan'208";a="49562294"
Received: from zengguan-mobl1.ccr.corp.intel.com (HELO [10.125.240.47]) ([10.125.240.47])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2024 06:04:40 -0700
Message-ID: <eeaf0647-e165-4736-97d0-a2856875c59d@intel.com>
Date: Sun, 30 Jun 2024 21:04:18 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/11] KVM: VMX: Handle NMI Source report in VM exit
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, X86 Kernel <x86@kernel.org>,
 Sean Christopherson <seanjc@google.com>, LKML
 <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Xin Li <xin3.li@intel.com>, linux-perf-users@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tony Luck <tony.luck@intel.com>,
 Andy Lutomirski <luto@kernel.org>, acme@kernel.org,
 kan.liang@linux.intel.com, Andi Kleen <andi.kleen@intel.com>,
 "Mehta, Sohil" <sohil.mehta@intel.com>
References: <20240628201839.673086-1-jacob.jun.pan@linux.intel.com>
 <20240628201839.673086-8-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
From: Zeng Guang <guang.zeng@intel.com>
In-Reply-To: <20240628201839.673086-8-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/29/2024 4:18 AM, Jacob Pan wrote:
> From: Zeng Guang <guang.zeng@intel.com>
>
> If the "NMI exiting" VM-execution control is 1, the value of the 16-bit NMI
> source vector is saved in the exit-qualification field in the VMCS when VM
> exits occur on CPUs that support NMI source.
>
> KVM that is aware of NMI-source reporting will push the bitmask of NMI source
> vectors as the exceptoin event data field on the stack for then entry of FRED
> exception. Subsequently, the host NMI exception handler is invoked which
> will process NMI source information in the event data. This operation is
> independent of vCPU FRED enabling status.
>
> Signed-off-by: Zeng Guang <guang.zeng@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   arch/x86/entry/entry_64_fred.S |  2 +-
>   arch/x86/kvm/vmx/vmx.c         | 11 ++++++++---
>   2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
> index a02bc6f3d2e6..0d934a3fcaf8 100644
> --- a/arch/x86/entry/entry_64_fred.S
> +++ b/arch/x86/entry/entry_64_fred.S
> @@ -92,7 +92,7 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
>   	 * +--------+-----------------+
>   	 */
>   	push $0				/* Reserved, must be 0 */
> -	push $0				/* Event data, 0 for IRQ/NMI */
> +	push %rsi			/* Event data for IRQ/NMI */
>   	push %rdi			/* fred_ss handed in by the caller */
>   	push %rbp
>   	pushf
Move this part to previous patch as it changes the common FRED api and 
prepares for nmi handling in case of nmi
source enabled in this patch.
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 4e7b36081b76..6719c598fa5f 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7331,10 +7331,15 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
>   	if ((u16)vmx->exit_reason.basic == EXIT_REASON_EXCEPTION_NMI &&
>   	    is_nmi(vmx_get_intr_info(vcpu))) {
>   		kvm_before_interrupt(vcpu, KVM_HANDLING_NMI);
> -		if (cpu_feature_enabled(X86_FEATURE_FRED))
> -			fred_entry_from_kvm(EVENT_TYPE_NMI, NMI_VECTOR, 0);
> -		else
> +		if (cpu_feature_enabled(X86_FEATURE_FRED)) {
> +			unsigned long edata = 0;
> +
> +			if (cpu_feature_enabled(X86_FEATURE_NMI_SOURCE))
> +				edata = vmx_get_exit_qual(vcpu);
> +			fred_entry_from_kvm(EVENT_TYPE_NMI, NMI_VECTOR, edata);
> +		} else {
>   			vmx_do_nmi_irqoff();
> +		}
>   		kvm_after_interrupt(vcpu);
>   	}
>   
