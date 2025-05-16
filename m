Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1630A4CE08
	for <linux-perf-users@vger.kernel.org>; Fri, 16 May 2025 13:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402547; cv=none; b=tg0dy+KRKg9lv6Xkzh0ThyyA14aAViWtnZZRJIRqbM/SoGb3rm/JR5Tp4G0H0PBx8GLVdYJaBBIobkksu19AP09kjmt2dbRgCOOVAmCQ3o4rbEahmlhNpCybDVRtj7rAENcBJwHS3WPZQZ6DS8CUbVBHlNZtD+2mcuq9PNh6e8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402547; c=relaxed/simple;
	bh=mbNJO6rbhRMwuIoVTU8ZDSG2mOIuj9eAx47BnBtUGTw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KPxXpdvx2tHTgFpOaxQaZsohbawuhB5qiDMk84LR473DBk+/m6IMghVNGO7937S8XiLquKyUviX1Uq/U4T5OsU+srG8cfKUsq+/JyE2JplsymdzRsbaL1zAPJ++joyWVpgO97JyImxpWsR2scGZIRJ0cmBUbeafR4taD19KAVgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XCZwYujY; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XCZwYujY"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22e816139b8so18630815ad.3
        for <linux-perf-users@vger.kernel.org>; Fri, 16 May 2025 06:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747402544; x=1748007344; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LnEPS5xIYcZ/9QBFlM2YvgXWlEvCitmvF/+QPuGAd2E=;
        b=XCZwYujYQfYJsx/wj/myE0yvEc3xR3IA8lSVucuBObUMrXF0cIxgmbGCIv0rkbooja
         xSeje9BnYXphJu5V8YW6g3C+pEvb9XPeeRzWczYqzkNtme49LMmGawLHABx5QNK2Kzur
         TLzRs5MURdmLNJ3sDfhFVD+RIIg1TgxHKgbhMKfcvQyycJvB/G5/0dADnJiOugPh45gH
         srDS0nC447YKE2NFgChNM9iNTe34/ArNk43WTAkuB03R8jFIL7yOgef67XMZUUaTaNLt
         nNEr4dE+N7eyVAcFYZxfCJImugtEfmd4CtbLkmBbZAYaDOHz+Qok1Fhu3poTvbDrxmqQ
         ZXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747402544; x=1748007344;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LnEPS5xIYcZ/9QBFlM2YvgXWlEvCitmvF/+QPuGAd2E=;
        b=cndnLUeWbe4awb5U8x7Vg2TLeLEjBFy3Lx3QzIYut1hw9uQhBFbyOFHBNiBmWqQj3F
         rZju+O12qLQMT3sVG4YU0dFMzXKKoybinmGBIa4euqji0xFI76btOKmvlFmsn6lRD7GA
         6Fgu1hwzkCaKEp/9PF6Iez0sY/eBnSNn17zuaj3mgXHVvu7ffv/wvZkuYPR9rG6Lbyj+
         RpWxZaaWkw67rAJNgTnFaN5GvWnDee6M1bU/tfUi85UPufDOtKhbjbiZJAsF8MWqLNaG
         ev2/tC7tFuIq+OO9xfjioqGe3uAd6pPX2Lnfohvm/mYsS6kvxdPq/cJ3hQWhQz5W9Gos
         fktQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN7uX5E0iJ5sQshT5+B92hM0ELoCbjNY7qQfkc2xkd1YPpzIExnKeqySVn6eqSe7QS2Mhy9akxHdUDTf5cECsK@vger.kernel.org
X-Gm-Message-State: AOJu0YzJzfbxEagLYCFgBrAwb5D2Brtfya+4luWCLhj8u8cMH/yZrHeJ
	bFwFprw3xKhdxagZZeU3iEq3I7G992EWnGMFScfE+gG2/Naiftp3n2Xyr8pkCfzjXxmeW4riXJU
	Qp2ForA==
X-Google-Smtp-Source: AGHT+IGYPJLPbPNyk9fQYDfhkPqOAQlx8+ac872IbMGJ++7mqndtzn4UY6HAjcLA0ay95SrGo+cLkFm5AkA=
X-Received: from plblm14.prod.google.com ([2002:a17:903:298e:b0:220:ca3c:96bc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1ca:b0:221:78a1:27fb
 with SMTP id d9443c01a7336-231d438a223mr46909995ad.11.1747402544334; Fri, 16
 May 2025 06:35:44 -0700 (PDT)
Date: Fri, 16 May 2025 06:35:42 -0700
In-Reply-To: <20250324173121.1275209-25-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-25-mizhang@google.com>
Message-ID: <aCc_LmORNibXBt8V@google.com>
Subject: Re: [PATCH v4 24/38] KVM: x86/pmu: Exclude PMU MSRs in vmx_get_passthrough_msr_slot()
From: Sean Christopherson <seanjc@google.com>
To: Mingwei Zhang <mizhang@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yongwei Ma <yongwei.ma@intel.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Jim Mattson <jmattson@google.com>, 
	Sandipan Das <sandipan.das@amd.com>, Zide Chen <zide.chen@intel.com>, 
	Eranian Stephane <eranian@google.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 24, 2025, Mingwei Zhang wrote:
> Reject PMU MSRs interception explicitly in
> vmx_get_passthrough_msr_slot() since interception of PMU MSRs are
> specially handled in intel_passthrough_pmu_msrs().
> 
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 38ecf3c116bd..7bb16bed08da 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -165,7 +165,7 @@ module_param(allow_smaller_maxphyaddr, bool, S_IRUGO);
>  
>  /*
>   * List of MSRs that can be directly passed to the guest.
> - * In addition to these x2apic, PT and LBR MSRs are handled specially.
> + * In addition to these x2apic, PMU, PT and LBR MSRs are handled specially.
>   */
>  static u32 vmx_possible_passthrough_msrs[MAX_POSSIBLE_PASSTHROUGH_MSRS] = {
>  	MSR_IA32_SPEC_CTRL,
> @@ -691,6 +691,16 @@ static int vmx_get_passthrough_msr_slot(u32 msr)
>  	case MSR_LBR_CORE_FROM ... MSR_LBR_CORE_FROM + 8:
>  	case MSR_LBR_CORE_TO ... MSR_LBR_CORE_TO + 8:
>  		/* LBR MSRs. These are handled in vmx_update_intercept_for_lbr_msrs() */
> +	case MSR_IA32_PMC0 ...
> +		MSR_IA32_PMC0 + KVM_MAX_NR_GP_COUNTERS - 1:
> +	case MSR_IA32_PERFCTR0 ...
> +		MSR_IA32_PERFCTR0 + KVM_MAX_NR_GP_COUNTERS - 1:
> +	case MSR_CORE_PERF_FIXED_CTR0 ...
> +		MSR_CORE_PERF_FIXED_CTR0 + KVM_MAX_NR_FIXED_COUNTERS - 1:
> +	case MSR_CORE_PERF_GLOBAL_STATUS:
> +	case MSR_CORE_PERF_GLOBAL_CTRL:
> +	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
> +		/* PMU MSRs. These are handled in intel_passthrough_pmu_msrs() */
>  		return -ENOENT;
>  	}

This belongs in the patch that configures interception.  A better split would be
to have an Intel patch and an AMD patch, not three patches with logic splattered
all over.
