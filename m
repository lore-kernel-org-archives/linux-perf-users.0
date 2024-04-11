Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83544134A6
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712863381; cv=none; b=LpDsNIf14F69loQkNeh5vYOOKWp5yTv0i8LoHEq7lWq+BQOL5DimovrEBQIOtlZ5bPcoUz/538py4PkKut7RtpHA+zrL9WF+EbfHXP0CaNDjH2lkz+SvJvexPmowpZLWgpR1RqfZOtu++pvRCG/jGW2PaFvAbxLrIIzdklk9NM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712863381; c=relaxed/simple;
	bh=fT4P0gGE+O7sWBDiZ8pLxxyQEVTnnen55DJKAfs9ezU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FvEFzW/e2Se5X5vu29tPWT3pSCagWMi2RHJ0Sfj+bOT91EDVocID/goA73iuzwBlhi0PtvhYcS+1XAoGlfnzYRVlLR7d4mzU1Pzzv2YVJiBbKhXcgOp+DbhlHy+vbkR7w/0CgYD8VS071ybSpz/4d2oZyW6qyr5Mx4RJr+459/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X4ADJCl3; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X4ADJCl3"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6144244c60cso1646247b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 12:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712863379; x=1713468179; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWyDifNB+g3/yqoVnm4if7NwdO+FurrszL4Rzn9n/PI=;
        b=X4ADJCl3aXslKO6WR1GzXOkIx0F8RxwRThktrxh9RgpI76pJwgZ7dMeC4vPKWdryr7
         NyvINpteUicAKPS/0EdyiSoTk/iB8XAl66qjAMj22rb35cwl1ahQf/ZGOBHaLswN21p+
         Coj8WrxEOUz/KyypUDOlXG7Ayc9Wcag0eMGY1AcQ8Ke1tzRypVB/LGTxm0ZZEElfXh3r
         QBj7b7rBXv9Kk2IV4CIp+33I+UQdShsd5G/5YLdTm6SXXzvxyktb2mminHz+xEGNOAGL
         jqDzOxpblthADLbthzW0AV7ziin4Wgo1DXDSoseD+Sai/PTPu9dpnIxu8xgqUIz/3AeF
         zVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712863379; x=1713468179;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWyDifNB+g3/yqoVnm4if7NwdO+FurrszL4Rzn9n/PI=;
        b=bOWP0xAqXDsmUEIHUFkbbgmGumlYofWi21gPC+e8goKplsOtH1rjCC4fWzEwIVZzND
         I0rScnnOL52JlCly5v8BnoqmHR8Ah95iRCmXUIjGnqdBOCf1jxfjr0hbwcbSrJoFJJsL
         f8cSNOJFkfvF2tJTrOjMM7xMFOrARCB7Ps3WapzEf0HkyKtb+K82FXUYE/qi6pf1Y/8b
         ClTLJ79VNTgtXhs4+5v6fsspnWJbdJ0fjiIKhi+ZtP3xhW53dR5Dh0hEJmnqNu16r//5
         oI7Xic1rPojCmuhcBLvR8YYB8jf3xj203sRdC3fzQK5FedZ/GOlmKYRr8aNa/QYU6CvI
         KvBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs4c7kpeckpXQ7Kkx60MseDhXEUpnZimOXhrxq9A+KDOcd6kB6JMgxTV4F7dma4fSddWgIbOMKNN2zNDA6KAOp/o/c99Z6zfT6wGLrx/fTbA==
X-Gm-Message-State: AOJu0YxfTzyjxdBF9Wf5yVxWcFutrY+kM37Rn3NfLU9xMNVRHDKASxLY
	akmUXSU/xfohh8v2G4PkNkPgYbZPzFSNurbx8/JT8srNKKtu5uaz5Fy3xSqAW2OEUcL4AqJgkR/
	ngw==
X-Google-Smtp-Source: AGHT+IEkfHzR+4m+Th6V2ts/oqUxiy0aOaoToSSBUi9LCjdVmQdDERNlhn8Fq9lXwBTSzwWtpL0hLyOgrA4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:6cc9:0:b0:615:2597:7246 with SMTP id
 h192-20020a816cc9000000b0061525977246mr83113ywc.6.1712863379573; Thu, 11 Apr
 2024 12:22:59 -0700 (PDT)
Date: Thu, 11 Apr 2024 12:22:58 -0700
In-Reply-To: <20240126085444.324918-9-xiong.y.zhang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com> <20240126085444.324918-9-xiong.y.zhang@linux.intel.com>
Message-ID: <Zhg4kkDzmdUiCYg8@google.com>
Subject: Re: [RFC PATCH 08/41] KVM: x86/pmu: Add get virtual LVTPC_MASK bit function
From: Sean Christopherson <seanjc@google.com>
To: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Cc: pbonzini@redhat.com, peterz@infradead.org, mizhang@google.com, 
	kan.liang@intel.com, zhenyuw@linux.intel.com, dapeng1.mi@linux.intel.com, 
	jmattson@google.com, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com, eranian@google.com, 
	irogers@google.com, samantha.alt@intel.com, like.xu.linux@gmail.com, 
	chao.gao@intel.com, Xiong Zhang <xiong.y.zhang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 26, 2024, Xiong Zhang wrote:
> From: Xiong Zhang <xiong.y.zhang@intel.com>
> 
> On PMU passthrough mode, guest virtual LVTPC_MASK bit must be reflected
> onto HW, especially when guest clear it, the HW bit should be cleared also.
> Otherwise processor can't generate PMI until the HW mask bit is cleared.
> 
> This commit add a function to get virtual LVTPC_MASK bit, so that

No "This commit", "This patch", or any other variation.  Please read through:

  Documentation/process/maintainer-tip.rst 
  Documentation/process/maintainer-kvm-x86.rst

> it can be set onto HW later.
> 
> Signed-off-by: Xiong Zhang <xiong.y.zhang@intel.com>
> ---
>  arch/x86/kvm/lapic.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
> index e30641d5ac90..dafae44325d1 100644
> --- a/arch/x86/kvm/lapic.h
> +++ b/arch/x86/kvm/lapic.h
> @@ -277,4 +277,10 @@ static inline u8 kvm_xapic_id(struct kvm_lapic *apic)
>  {
>  	return kvm_lapic_get_reg(apic, APIC_ID) >> 24;
>  }
> +
> +static inline bool kvm_lapic_get_lvtpc_mask(struct kvm_vcpu *vcpu)
> +{
> +	return lapic_in_kernel(vcpu) &&
> +	       (kvm_lapic_get_reg(vcpu->arch.apic, APIC_LVTPC) & APIC_LVT_MASKED);
> +}

As suggested in the previous patch, I'm pretty sure we can safely omit this
helper.

>  #endif
> -- 
> 2.34.1
> 
