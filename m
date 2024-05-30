Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3894212C48E
	for <linux-perf-users@vger.kernel.org>; Thu, 30 May 2024 05:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717046409; cv=none; b=axU2nykzIu6vxjadMHF/Lxea8td/pD9KoC2F13wTButZH1Z8swdzsQcgz91d19Z4OI+SOW3DEO1q2pNfS0k40wSsDqU4yrSpqGTqEVyN9RYZIecJfZnbFxI2BsB0tmpkWg9ololzVLaqpFzL65BwNX5mArqQpkO92S9NsNlTXR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717046409; c=relaxed/simple;
	bh=RE7/rHD6hA0HZU8BNTxAYNZyZXrYAewC2lvAFnovzcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ko52iZxtg+8Tk8Efn2NJuTPJ4NUAK7LGN5IPD6iqg0dqO62+Kq0QAEGVpoSWm63Jr86yBQ9Ri2qqCR2Ui8kTd55ryZqt+slMqQ4rJ2hzGpUlcKo3PkxhL8mUSAu8jelAGv1VU32rY9MgzBef1ZK2xHcofb+T/1NNA7CkpuaMR9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4I/x7I0n; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4I/x7I0n"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c195eb9af3so365506a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 May 2024 22:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717046407; x=1717651207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9qCiXp86mmPaO4lRyFEc5txWVo+t4xtzMhe/cX0w+gk=;
        b=4I/x7I0nCuezROlzTM9AVyC3qOw5dd5+i9iibxgUUi7ADnLX85BfFJCUeAj2C964bD
         GYRvh0b6QsIvtRcgeAcpr82IQLKEg+1CYqnT874OnKAQhPQbAQxYIisgC3+VhEYOIfWi
         AO3OT/0cXm1lpr9PYVVX8szivARhRxGyyYw8k/oc+nW+h62f7UP+ZoymH7bo9DKTHcMG
         Lzy4h/mhOvLva3Z3LAtlrqJoZVwzvAGxpQys/CJRaZe5Ixi3BDImtxCdbjQR4bQeF/hV
         sb0LjMmkYUdvpQvIcBiToHQzmTrk/LQZmcXpw7MbHUjRhJJdSdgeHt25TjWFxVXjnYUY
         xx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717046407; x=1717651207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qCiXp86mmPaO4lRyFEc5txWVo+t4xtzMhe/cX0w+gk=;
        b=SGMkemEEOHQEW3T7GeJjVLfpAf0QNLoq7SELeK0JzAUF6beBxbCfceUUmGUOrfhhrg
         RFgiJOcUYXjf9kd/RBF2gNQfj1eiNUu2Ww05vGJYIGW+ZbeEuFDoFiQuidhFM9o9H44u
         aDOUswuhYi6YsJrgFnn+mWaaEjN7Fh7gudqbKbyjdu6/kV3l30QoyuUVTS82CP76Ne+/
         A6SP8QZYgOsxHTQeInGLuZUYxbfSGmnLt1Jvq24vvel7JnWnnf27aVWTKwQ7exc7qaeR
         4XIsa8FQIol2/3J2Ps+b5KMYbH85oPYJUZrLk7CGpavdvePtquFeW97VdcAlC8Ra1j/Y
         jCCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX95smh13KTAipwyMhRLrhhIRw5T/XUk0Z5K30CLwC0aSkkjalkLYJLKQL0jy4b/4XNWDhDeQuzfCMw3XafmeIGVc3Eltt6bJ8FJF1QRxiRHw==
X-Gm-Message-State: AOJu0YyVh/YGqkQmiHDfmgckAt60mafPCQl07zJChOuuVy7dEZajC4ff
	LwEHMvK1EaQmoS7/UO+wxBBWkPmjJBNgl7XpSUhd6EnvaYaqLeCpWgguXC3q0g==
X-Google-Smtp-Source: AGHT+IEkGs4CSbz/gwJsBDQ8mRLv3uu+Olu7bNWDsblBZs23v8KVVAp+lA23RbpWR6ezd91uErJiqg==
X-Received: by 2002:a17:90b:4acb:b0:2bd:f439:546b with SMTP id 98e67ed59e1d1-2c1ab9e3aaamr1154730a91.19.1717046407152;
        Wed, 29 May 2024 22:20:07 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a775d28asm688632a91.8.2024.05.29.22.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 22:20:06 -0700 (PDT)
Date: Thu, 30 May 2024 05:20:02 +0000
From: Mingwei Zhang <mizhang@google.com>
To: "Chen, Zide" <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Xiong Zhang <xiong.y.zhang@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Kan Liang <kan.liang@intel.com>,
	Zhenyu Wang <zhenyuw@linux.intel.com>,
	Manali Shukla <manali.shukla@amd.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Jim Mattson <jmattson@google.com>,
	Stephane Eranian <eranian@google.com>,
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	gce-passthrou-pmu-dev@google.com,
	Samantha Alt <samantha.alt@intel.com>,
	Zhiyuan Lv <zhiyuan.lv@intel.com>, Yanfei Xu <yanfei.xu@intel.com>,
	maobibo <maobibo@loongson.cn>, Like Xu <like.xu.linux@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 20/54] KVM: x86/pmu: Allow RDPMC pass through when all
 counters exposed to guest
Message-ID: <ZlgMgucwDSOhzV7f@google.com>
References: <20240506053020.3911940-1-mizhang@google.com>
 <20240506053020.3911940-21-mizhang@google.com>
 <f2a9d5ba-e0ae-41fb-ae54-2456c826ac2c@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2a9d5ba-e0ae-41fb-ae54-2456c826ac2c@intel.com>

On Wed, May 08, 2024, Chen, Zide wrote:
> 
> 
> On 5/5/2024 10:29 PM, Mingwei Zhang wrote:
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index a5024b7b0439..a18ba5ae5376 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -7860,6 +7860,11 @@ static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
> >  		vmx->msr_ia32_feature_control_valid_bits &=
> >  			~FEAT_CTL_SGX_LC_ENABLED;
> >  
> > +	if (kvm_pmu_check_rdpmc_passthrough(&vmx->vcpu))
> > +		exec_controls_clearbit(vmx, CPU_BASED_RDPMC_EXITING);
> > +	else
> > +		exec_controls_setbit(vmx, CPU_BASED_RDPMC_EXITING);
> > +
>
> Seems it's cleaner to put the code inside vmx_set_perf_global_ctrl(),
> and change the name to reflect that it handles all the PMU related VMCS
> controls.

I prefer putting them separately, but I think I could put the above code
into a different helper.

Thanks.
-Mingwei
> 
> >  	/* Refresh #PF interception to account for MAXPHYADDR changes. */
> >  	vmx_update_exception_bitmap(vcpu);
> >  }
