Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF31B16E873;
	Mon,  1 Jul 2024 17:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719853476; cv=none; b=GwuvYSsS+OKWK+7CL+7WbBsOLowmkWygWEwraPZeZ34LfRfb0aAdw1Hl6L1RAbkO5pp4RDTRuRKaJaeEMbtZe8000TYvmyjhp0bAIrBFeBWZlaAfayYYIY0IrKZAv2a/UMk9g/b4p/LMoNLGUFdoeXUBGBYdRSZjOxdX71wSvkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719853476; c=relaxed/simple;
	bh=lQP6H0vJdE2QnG7W5l3CDY2oHw0bYpLWBAM3FeXZmQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TR7MRCLeOwqKWEU/RGkFfICcjIUXntEp4YplvJ67ZQIJz+C5AquEum3SiRX6CiI6Rc78BlWx/9/wpElyvgcTjvaXG1Q2m28cp2M7IZlCZYTHfFmJhMbl+7z3p1sUZaQz/veo3ZcCaMydEIsnEImoq0ihtf4fK/GgqSOaTsaAmhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=JBrRqlY4; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="JBrRqlY4"
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 461H3xOD201438
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 1 Jul 2024 10:03:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 461H3xOD201438
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1719853440;
	bh=bVdgeVqJIxpN5USH6OWlUiB4+5Yn1Ls/laGlGnmMX5o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JBrRqlY4UqNMQOM+tsQcZo0AkA5FXZKvXGY2wFHZbcWa5yLiYhl57wxjUDgod0QiO
	 FqyZyqGIot8R5HzyFZAw/MtBVwKMtDvsFvmbx8ZTgfP5Irm6lx1Y62kxtWKQxqpKbN
	 fws0YcZF8O9rfWU4eRLAEgqFUvK66uezTYWRwmclJCB/08SS90dF4KrNqcJdkcNtdi
	 igwpUn0q5TkTXqVGOP9ekk/pdQFW/UXJWhtCe+rE4HQu1Ci9R+xoWx+q3bu2i6R7Up
	 EINlHAQ3hza1NXWgHYl3xpeM9QpjkfLNVjRs+ifALohcRkMAAUhzfRurdLTm6edEPq
	 L1ZPQ+GG9LGfw==
Message-ID: <51768b50-96ac-49a7-a63b-02d2b94c2c6a@zytor.com>
Date: Mon, 1 Jul 2024 10:03:58 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/11] KVM: VMX: Handle NMI Source report in VM exit
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: X86 Kernel <x86@kernel.org>, Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Xin Li <xin3.li@intel.com>, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>, acme@kernel.org,
        kan.liang@linux.intel.com, Andi Kleen
 <andi.kleen@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        Zeng Guang <guang.zeng@intel.com>
References: <20240628201839.673086-1-jacob.jun.pan@linux.intel.com>
 <20240628201839.673086-8-jacob.jun.pan@linux.intel.com>
 <6c8160e4-3d67-410d-aad0-3ec731a903f8@zytor.com>
 <20240701084558.1620584f@jacob-builder>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <20240701084558.1620584f@jacob-builder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/1/2024 8:45 AM, Jacob Pan wrote:
> 
> On Fri, 28 Jun 2024 21:07:04 -0700, Xin Li <xin@zytor.com> wrote:
> 
>> On 6/28/2024 1:18 PM, Jacob Pan wrote:
>>> From: Zeng Guang <guang.zeng@intel.com>
>>>
>>> If the "NMI exiting" VM-execution control is 1, the value of the 16-bit
>>> NMI source vector is saved in the exit-qualification field in the VMCS
>>> when VM exits occur on CPUs that support NMI source.
>>>
>>> KVM that is aware of NMI-source reporting will push the bitmask of NMI
>>> source vectors as the exceptoin event data field on the stack for then
>>> entry of FRED exception. Subsequently, the host NMI exception handler
>>> is invoked which will process NMI source information in the event data.
>>> This operation is independent of vCPU FRED enabling status.
>>>
>>> Signed-off-by: Zeng Guang <guang.zeng@intel.com>
>>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> ---
>>>    arch/x86/entry/entry_64_fred.S |  2 +-
>>>    arch/x86/kvm/vmx/vmx.c         | 11 ++++++++---
>>>    2 files changed, 9 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/x86/entry/entry_64_fred.S
>>> b/arch/x86/entry/entry_64_fred.S index a02bc6f3d2e6..0d934a3fcaf8 100644
>>> --- a/arch/x86/entry/entry_64_fred.S
>>> +++ b/arch/x86/entry/entry_64_fred.S
>>> @@ -92,7 +92,7 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
>>>    	 * +--------+-----------------+
>>>    	 */
>>>    	push $0				/* Reserved, must be 0
>>> */
>>> -	push $0				/* Event data, 0 for
>>> IRQ/NMI */
>>> +	push %rsi			/* Event data for IRQ/NMI */
>>>    	push %rdi			/* fred_ss handed in by the
>>> caller */ push %rbp
>>>    	pushf
>>
>> This belongs to the previous patch, it is part of the host changes.
> right, will do.
> 
>>
>>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>>> index 4e7b36081b76..6719c598fa5f 100644
>>> --- a/arch/x86/kvm/vmx/vmx.c
>>> +++ b/arch/x86/kvm/vmx/vmx.c
>>> @@ -7331,10 +7331,15 @@ static noinstr void vmx_vcpu_enter_exit(struct
>>> kvm_vcpu *vcpu, if ((u16)vmx->exit_reason.basic ==
>>> EXIT_REASON_EXCEPTION_NMI && is_nmi(vmx_get_intr_info(vcpu))) {
>>>    		kvm_before_interrupt(vcpu, KVM_HANDLING_NMI);
>>> -		if (cpu_feature_enabled(X86_FEATURE_FRED))
>>> -			fred_entry_from_kvm(EVENT_TYPE_NMI,
>>> NMI_VECTOR, 0);
>>> -		else
>>> +		if (cpu_feature_enabled(X86_FEATURE_FRED)) {
>>> +			unsigned long edata = 0;
>>> +
>>> +			if
>>> (cpu_feature_enabled(X86_FEATURE_NMI_SOURCE))
>>> +				edata = vmx_get_exit_qual(vcpu);
>>> +			fred_entry_from_kvm(EVENT_TYPE_NMI,
>>> NMI_VECTOR, edata);
>>
>> Simply do fred_entry_from_kvm(EVENT_TYPE_NMI, NMI_VECTOR,
>> vmx_get_exit_qual(vcpu))?
> I don't have strong preference but having a local variable improves
> readability IMHO.

My point was, do we actually need this check:
     (cpu_feature_enabled(X86_FEATURE_NMI_SOURCE)?

I don't have a strong preference either.

> 
>>> +		} else {
>>>    			vmx_do_nmi_irqoff();
>>> +		}
>>>    		kvm_after_interrupt(vcpu);
>>>    	}
>>>      
>>
> 
> 
> Thanks,
> 
> Jacob
> 

