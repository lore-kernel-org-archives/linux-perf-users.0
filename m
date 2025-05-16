Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA6929D0D
	for <linux-perf-users@vger.kernel.org>; Fri, 16 May 2025 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747401996; cv=none; b=qdcRKC8Jsq5NhKFtRQd7EyITeLDQgoDmkNtght/Snj5xX56wZFenBsUhqIeqTdx65bl125PJ0gWtFN7Rh8JHSwRw36fN0mXl9EfYl/K2cvGhoCpr24SiaHKtnUi8Hl0EEUCbMPE/xXCH3e4KVu9J1B3Bw3Af0caPUKolHRBBY60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747401996; c=relaxed/simple;
	bh=oOqs3k0tlpF5HjyzxYG4IK2pdYHASxUiUCxNE7N6sVQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tQVq3e6cyhyKvzM1DJn3QS172ucsqteJ6387inCPbgUi4X4bB/C8AFaJ+MjK8hKvOAtx/ikcMMJMk3JRTY21ZbjhOXU78Jq7LREPYdKNimnOYoXVS/sw65LaOabOZSqw75eQ0RFbHwqgP6g0Boke652vi7X/ytbg97z7ML+rkL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NjT84hXe; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NjT84hXe"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30c06465976so2208124a91.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 May 2025 06:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747401994; x=1748006794; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jUF92U1DJmFEjkB/6aO1QXrYLsPasET5mz/HpdkaAk0=;
        b=NjT84hXecCf9KCtiUY32vsnEwyF0h8tmXlIMd/UlrjQVnCLXQwbfPy6FAgLewRkDSe
         FK/kvajs/JV6xEsk20fi9J3CHDw3hhjT9pArWxOFAAT0EE8h+Uf95rIAJolFtVBHHklE
         UQc+UA05tS2DaMJ6hylE8SoCF9HvAmVoOThNQpd/AZHZP3DlMv1BooB1fznhuVzm2P5u
         CwLNsMNzPZibm/llen7xkyHQd3aeQw5cR52t5AlaE367br4iI2FjBK0JO9/U2V9bWYyp
         cTElatBDShYV9ZN0V2vFtxrr4bokU/sKEKbkJhPwN+8y/ob/C+19chKQeasl7rcBgmpA
         Jfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747401994; x=1748006794;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jUF92U1DJmFEjkB/6aO1QXrYLsPasET5mz/HpdkaAk0=;
        b=dwI9IE0BWaMRv7HbopFvAvY1EI/AOuXXMr+4VqbKZszeNmTvR/J+qrhCvuyZ84zD3x
         srAZoP+U1JalXBeJ6clG0iDtzNhnNfTvAD5d7Tebh3BAXj0ixiCBJixBjaqjh6VEv+8Z
         q9QFAVtXTEUFfKMX4rEMy6d/ltSzTEOIXKOp1ZVZAjWZ+OAjBI6pYSIxb0pIdCxZRBbJ
         0PIFBpoVgtmXy7ON+z3RNXoiz1Bqx6QDfvE24g0+D2dorNyUceofsD3N2k2+G2t4jh9K
         52VM3978Sf7eTI/7FzZ6lhbna7+yY6AcKof0GlWi4yAfJa53gJIsyeyIGqpdJPBofYll
         2CKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUykE8nt9NNxNnlFbpwVNp9t6qhr4GROdjR35VjIN/ybRwfPGjWRGWbfzrGDf62aWTCAmP4CrkMrIsIxWpQo/Eu@vger.kernel.org
X-Gm-Message-State: AOJu0YyS5oS9rdn/QF/XyA9MVDFNzb/fselUAX3cmQRw9N9rv06t2uJM
	8RInAt9e1n/JAlxuewKPLwW60DwVfJXbdjGWarODbQZEtBLQwIE2JbBAw10eneM3KHGQx3DlCoy
	yfdMoww==
X-Google-Smtp-Source: AGHT+IENAvEw35fiE7fP5luIXtFIoumLYQF+Tnj/cRu9Hs0uoimDXOXKxgPyre23vv5rc2HSAcjSbPWRUJQ=
X-Received: from pjbsb5.prod.google.com ([2002:a17:90b:50c5:b0:2fc:1158:9fe5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c88e:b0:2fe:b937:2a51
 with SMTP id 98e67ed59e1d1-30e7d5d91f8mr5440318a91.33.1747401994585; Fri, 16
 May 2025 06:26:34 -0700 (PDT)
Date: Fri, 16 May 2025 06:26:32 -0700
In-Reply-To: <20250324173121.1275209-30-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-30-mizhang@google.com>
Message-ID: <aCc9CKw3DGXXQbbe@google.com>
Subject: Re: [PATCH v4 29/38] KVM: x86/pmu: Switch host/guest PMU context at vm-exit/vm-entry
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
> +	/*
> +	 * Clear hardware selector MSR content and its counter to avoid
> +	 * leakage and also avoid this guest GP counter get accidentally
> +	 * enabled during host running when host enable global ctrl.
> +	 */
> +	for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
> +		pmc = &pmu->gp_counters[i];
> +		eventsel_msr = pmc_msr_addr(pmu, pmu->gp_eventsel_base, i);
> +		counter_msr = pmc_msr_addr(pmu, pmu->gp_counter_base, i);
> +
> +		rdpmcl(i, pmc->counter);
> +		rdmsrl(eventsel_msr, pmc->eventsel_hw);

As pointed out by Dapeng offlist, this RDMSR is unnecessary since event selector
MSRs are always intercepted.

> +		if (pmc->counter)
> +			wrmsrl(counter_msr, 0);
> +		if (pmc->eventsel_hw)
> +			wrmsrl(eventsel_msr, 0);
> +	}
> +
> +	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
> +		pmc = &pmu->fixed_counters[i];
> +		counter_msr = pmc_msr_addr(pmu, pmu->fixed_base, i);
> +
> +		rdpmcl(INTEL_PMC_FIXED_RDPMC_BASE | i, pmc->counter);
> +		if (pmc->counter)
> +			wrmsrl(counter_msr, 0);
> +	}
> +
> +}
> +static void intel_put_guest_context(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> +
> +	/* Global ctrl register is already saved at VM-exit. */
> +	rdmsrl(MSR_CORE_PERF_GLOBAL_STATUS, pmu->global_status);
> +
> +	/* Clear hardware MSR_CORE_PERF_GLOBAL_STATUS MSR, if non-zero. */
> +	if (pmu->global_status)
> +		wrmsrl(MSR_CORE_PERF_GLOBAL_OVF_CTRL, pmu->global_status);
> +
> +	rdmsrl(MSR_CORE_PERF_FIXED_CTR_CTRL, pmu->fixed_ctr_ctrl_hw);

And same thing here.  Though I'm confused as to why KVM always intercept
FIXED_CTR_CTRL.

/me rummages around the SDM

Ahh, because there are Any Thread bits in there.  That absolutely needs to be
called out, probably in the interception logic in pmu_intel.c.  I'll add a comment.
