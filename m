Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94253C699
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 21:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712870606; cv=none; b=Ya0rTEVkDxxDvZ4dEGQdnhXpnmeCW4CQPYSIKRfFtY1mRaK6U7bYsR4tlJ3McW7XcfYuDHAWm2Zo2PxCSJTfY6RLGP1n188Rt64TEbtJO8yAWtfh9nue5ky9bhNgDvNSoaQ3AQJJtxCIEb6W1VM7CRz7GcD8/otAcdJgANer0R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712870606; c=relaxed/simple;
	bh=+D2gqeHElRX7BXeeD1K9fckk7QQ7DkL0FOAQt6ybymU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kw4wLme1o80DucaPfsKytjflTnRlm/glYGY7YVR+octB821u56pDBo+H03mR+ItfnMw+2lj8klZ9PmDOeIzRjtgRDL1LmPNaSxhU/5cEXQ4+GLL2fdEULq0uCK9G7bpY8TnyqqLNlX9CJdJtrlA29qrGI1Q5HEVb4WK8Tw5zdUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XFm20QOy; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XFm20QOy"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2a4a2cace80so180593a91.3
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 14:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712870604; x=1713475404; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f4sYynhcMrBtwb48cfVkTJ5DoHsaKANS6hAxyOyilKo=;
        b=XFm20QOy/jSp8lW2aAR1UhriMz5YlZh9GILImy2itFB9NLKz0smphMXgcSAbjjFQvU
         PbLdAs11yFZDPu7PcKWKdxdiOrmcrgGO5n8QUeV6NQwa9V+Mf3XJEwtkbOVtLoGggRZ8
         mCy3sRiwR3LRSZivYti1JvcguV0K+eHjtXKFy03zMqaoG05cPWQTZ9CGQ2Fxejl5f9YX
         TTJE3o7AYJAylMX5FUYhBQOzqBLdv1gl+t1rsVhOiJACdL+Ddv2103TFagu8f86OtidM
         gXWlFwvDiU47gQgelhH8fxayK8/OWoqRTDzYXXG7ROvWHuGhod40Vd6OWhEWe7pvE/oM
         pbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712870604; x=1713475404;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f4sYynhcMrBtwb48cfVkTJ5DoHsaKANS6hAxyOyilKo=;
        b=jvBF+dNrM1AXw1ap4kqxhNsDbQDX67PeB16wM6fVClw4PKsu6Eo+5+QAHtf2Zs2ns7
         wa0K4i3afYgnPnRCsa9MWn9DLBBzYVYi7HNn/oiJPaUv6pJi0HBLgYlycdypxr6A0h5n
         r91WbxL1g2cvyK9opzn/6Q65jZYnfJVOA05JvbHODXiJlB4UMP3wCtF7ca4AyCs0oz4a
         sWWusd1KvMxNOuXtnlmhCoRah03Lqh0DrC+Od3/Gvvwhzk7jGRKHQNh2avDDvGgv9jSq
         qA8jOg5FuqSXDwGlB7tIqk8/4pI/rKE47Uu5AkejjOoWz0+PIqomAfmgr8vsripf7YcM
         uA5w==
X-Forwarded-Encrypted: i=1; AJvYcCXbbw2Jn45z4J4p6Td//7G8XaxWcdkDYKrcNvnsThyHMYeQrqs0ZG39Bsl01Jn2iyJvVCvddOU/W/S8z4Dl2CPka/dQsr9L1swhHYCAuHtwUA==
X-Gm-Message-State: AOJu0YyChArqgGFQJZPuocqC8OFuyuD6yjNspFHpdmSBq+xqxSGjkDvw
	cD6yV5owC0SW0wRUAm4lxg3F03ruiJYbFKbfJZ9e8vFcn38/dOcT/PsZWWOpZUEzqQPSAPkBTup
	DoQ==
X-Google-Smtp-Source: AGHT+IGLnJWSe1pvT4fYPO2ARANLiP/Na43gje8HhGRqItkZXxuLiueYxnrbicDCpCBuUCuFLqQcY6Xcom8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:e213:b0:2a5:c05e:6e3d with SMTP id
 a19-20020a17090ae21300b002a5c05e6e3dmr2191pjz.0.1712870603948; Thu, 11 Apr
 2024 14:23:23 -0700 (PDT)
Date: Thu, 11 Apr 2024 14:23:22 -0700
In-Reply-To: <20240126085444.324918-19-xiong.y.zhang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com> <20240126085444.324918-19-xiong.y.zhang@linux.intel.com>
Message-ID: <ZhhUyk2uAXqG7GEd@google.com>
Subject: Re: [RFC PATCH 18/41] KVM: x86/pmu: Intercept full-width GP counter
 MSRs by checking with perf capabilities
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
> From: Mingwei Zhang <mizhang@google.com>
> 
> Intercept full-width GP counter MSRs in passthrough PMU if guest does not
> have the capability to write in full-width. In addition, opportunistically
> add a warning if non-full-width counter MSRs are also intercepted, in which
> case it is a clear mistake.
> 
> Co-developed-by: Xiong Zhang <xiong.y.zhang@intel.com>
> Signed-off-by: Xiong Zhang <xiong.y.zhang@intel.com>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  arch/x86/kvm/vmx/pmu_intel.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 7f6cabb2c378..49df154fbb5b 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -429,6 +429,13 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	default:
>  		if ((pmc = get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0)) ||
>  		    (pmc = get_gp_pmc(pmu, msr, MSR_IA32_PMC0))) {
> +			if (is_passthrough_pmu_enabled(vcpu) &&
> +			    !(msr & MSR_PMC_FULL_WIDTH_BIT) &&
> +			    !msr_info->host_initiated) {
> +				pr_warn_once("passthrough PMU never intercepts non-full-width PMU counters\n");
> +				return 1;

This is broken, KVM must be prepared to handle WRMSR (and RDMSR and RDPMC) that
come in through the emulator.
