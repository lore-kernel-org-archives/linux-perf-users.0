Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17471BF33C
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Aug 2024 14:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817156; cv=none; b=X+pX1ie8//jDv/oqdDLOGMQWDLEdJ5ptgcrmFEa3+0NvniHC46dr1fUQbq5mrASZOmKBzOAoKB3iPxZwtCbxdyyG6uUory8Es6xBj2vcf1N3aV2tGH9jBD2O6Jy/m8ijVa81vpKbJaVccpzQBAjBqAoE6q6oJVpEpiDAjup+WNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817156; c=relaxed/simple;
	bh=meTHSRDJGDAP5kuUvwe2Smv3cAFWKpo17Usb97KDIF0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bulr0YznHJLbkVyj2DXbqx+CVbjbsf/zO38ipGOkCYJNkUUPpgIVdxy+nMXp0iNB2LA0O6KPxdgalWRbJjZ5WPpHBu2/tNzp02e143Cvlrf1tdodtJ+leoZ0QeuPmnavG8ZwFMNn8X77XAD13sn216vvyGGkTjfZ6qth1bQPuwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r/spDf23; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r/spDf23"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-650fccfd1dfso33365157b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Aug 2024 07:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723817154; x=1724421954; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YMPSBXcM1s1xvzkoMxunZaNUuWTcwdNp835NuUUemnU=;
        b=r/spDf23vjVLMM99sbpeP2wBLO842E9yEar0iOOPziZo3/YPkaLMNoPlg7b6QDd2cB
         nmPzCFCUl6eCnZfu/V3gaXmq1K/gHpUtNc/G/9hvzDYp9ySgy5Jgm5r69a3JdVhLK/v9
         dHAM/chbhHf0lmqv8pbbnS4znq+9XjJqydoWzuGJpfeQddad+he7GjEbf5BCIjImI5L+
         odiH1ScW2PBHYn0Y7lByLPl2khhkFgrv7qOw9/GZPbrXnbTH/Dvq0juSplYpbWWjzoIv
         lvZ8w29v2RojOJQOmLjXZpTAkCh9CxAhbNAouEoJTUUxhhmxopiCBc6PIRn2WGBF4Jy+
         H1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723817154; x=1724421954;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YMPSBXcM1s1xvzkoMxunZaNUuWTcwdNp835NuUUemnU=;
        b=OfPu9Ocvz9JpoA/SB7MmuYHx717JwF43POpJt9tFhNQEfI6fu4RW9/tP38NtDy39L2
         /Oa0ee5IRLiy5085icK/bh+Z0qCFgu75BkvpnCY3l9k3bPA+JaAshfaRuBw6pRPM1bwJ
         1ui9ZttYk/5L0BZFFRtLgEafI+9On95IBytZDVKRuQMyk+713h+IcRB68JVWpc55IJVp
         mMuIHkmbzYGHEVklfickupdJNiV3t/S/YU63roc0vY8sIP5CMog+aNk5Vd8V/HvFd5b+
         jJb2S5w2I2T53E3xU/dLZeoqevKDBK9tEC4pqsljroSti2RWfeX6oRtesmlzOj50fZGy
         aD8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfEP9ejbiTF31k8rMFAOTP9VGRL9Di/lGr5usa0lnB+6h3mE0JE2Q6zet970uoF8Oyg9uoai8O4Fm9XWJIzRaH5jEGmCt5HZAhti5dil3DxA==
X-Gm-Message-State: AOJu0YxpoNSXGIZqFJKjseVZzF8CqG7QHHSmKILb3KsaUHVI7/ONapWZ
	Ls6hdhaJTr01vBHS+y4hQBUMDL9VWiGT9wjLlVsM6rMZzqc6pNwPQAq+D4jeRTNEnBo/7LAV3Ap
	Wpw==
X-Google-Smtp-Source: AGHT+IFFGb4Jc9PbYZ35ni7YjtMePHyDkUKSP9dbCu4z8jc7TSuGCwJXKgtpZEAxuIcgSbT/axzPGvA+2/s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:4084:b0:6b0:57ec:c5f9 with SMTP id
 00721157ae682-6b1b2230c74mr600117b3.0.1723817153848; Fri, 16 Aug 2024
 07:05:53 -0700 (PDT)
Date: Fri, 16 Aug 2024 07:05:52 -0700
In-Reply-To: <20240709143906.1040477-8-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240709143906.1040477-1-jacob.jun.pan@linux.intel.com> <20240709143906.1040477-8-jacob.jun.pan@linux.intel.com>
Message-ID: <Zr9cwLUP-l2zgXtV@google.com>
Subject: Re: [PATCH v4 07/11] KVM: VMX: Handle NMI Source report in VM exit
From: Sean Christopherson <seanjc@google.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: X86 Kernel <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Xin Li <xin3.li@intel.com>, linux-perf-users@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Tony Luck <tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>, acme@kernel.org, 
	kan.liang@linux.intel.com, Andi Kleen <andi.kleen@intel.com>, 
	Nikolay Borisov <nik.borisov@suse.com>, Sohil Mehta <sohil.mehta@intel.com>, 
	Zeng Guang <guang.zeng@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 09, 2024, Jacob Pan wrote:
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
>  arch/x86/kvm/vmx/vmx.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 4e7b36081b76..6719c598fa5f 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7331,10 +7331,15 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
>  	if ((u16)vmx->exit_reason.basic == EXIT_REASON_EXCEPTION_NMI &&
>  	    is_nmi(vmx_get_intr_info(vcpu))) {
>  		kvm_before_interrupt(vcpu, KVM_HANDLING_NMI);
> -		if (cpu_feature_enabled(X86_FEATURE_FRED))
> -			fred_entry_from_kvm(EVENT_TYPE_NMI, NMI_VECTOR, 0);
> -		else
> +		if (cpu_feature_enabled(X86_FEATURE_FRED)) {
> +			unsigned long edata = 0;
> +
> +			if (cpu_feature_enabled(X86_FEATURE_NMI_SOURCE))
> +				edata = vmx_get_exit_qual(vcpu);
> +			fred_entry_from_kvm(EVENT_TYPE_NMI, NMI_VECTOR, edata);

Eh, I would just east the extra VMREAD if KVM happens to run on a CPU that supports
FRED but not NMI source reporting.  Per spec 7.0, the EXIT_QUALIFICATION is 0 if
NMI source isn't supported, i.e. it's guaranteed to not cause functional problems.

I assume there won't be many (any?) CPUs with FRED but not NMI_SOURCE (and if there
are, why!?!?!).  On the other hand, gating this on NMI_SOURCE means KVM will need
another update if some other event data is ever added for NMIs.  And readers don't
have to hunt through the FRED spec with a fine-toothed comb to suss out that
EXIT_QUALIFICATION == event data, but that KVM is getting cute and only reading
it when it can be non-zero (as far as KVM knows).

As a bonus, the code is less ugly:

		if (cpu_feature_enabled(X86_FEATURE_FRED))
			fred_entry_from_kvm(EVENT_TYPE_NMI, NMI_VECTOR,
					    vmx_get_exit_qual(vcpu));
		else
			vmx_do_nmi_irqoff();

> +		} else {
>  			vmx_do_nmi_irqoff();
> +		}
>  		kvm_after_interrupt(vcpu);
>  	}
>  
> -- 
> 2.25.1
> 
