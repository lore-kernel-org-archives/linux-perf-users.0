Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15617260A
	for <linux-perf-users@vger.kernel.org>; Fri, 16 May 2025 13:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402500; cv=none; b=bb1e+H6F9It9FM1BmwluD3ycOYkiP0P5YnGNKCixygQ2906kg7GpPeH5YQ5fyfVsv+eHUfbYBBSUZkLkCl06oNoJrJZxdySFhWK1dxMjxDhqWJNOnEb48shKoPc8Lo0vX6Mz2Zgk0yvt2sOhsNtpPnUwnHgD1k2tcO/Y4icc77U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402500; c=relaxed/simple;
	bh=XZ67zxckQNWX2u4GAkUhy4uGKDY0CIx1jcYW19gYh5A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jeFs/oFeX1RMBsKfT6JDrY3MVQ44vzPg9H1sf2D6LOhgrMLqBBi5/TdG6YxING/L50U2xp3n8AFR80c0lvQ/W4hqtqI1Se+FG6NAjiigE8NO1Ynvql3MhMKzOYRzGWVpyGTpz94l5UT262d9eIvlTe/ngAcCRvYM52Z3asC0hlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h6TxgVnd; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h6TxgVnd"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b269789425bso2183180a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 May 2025 06:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747402498; x=1748007298; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TCKX2+ubPZmRS49k2Vh1SgSk5f8TvOPmMU2uJSUuFS4=;
        b=h6TxgVndGQHappGd+FzJsGxGYHOJsYWjSTvxPqMa6FHfl4H9fnbSgyxj30YjDoZjTq
         Zh/G8qkFBln8Wfb0x0xrBYw02Q9f6Gq3mkEx5Aw0tJhLqFV1eFmwIaPDDc/9c+QocaOm
         r2FhljLoVkFiyk6u0vvmzUVyU7IDQ/BwKHhY8cKDvMx2COUt/dJ9odiNykCwpoqu6dD9
         nNHNv72+dyjtv08E9BgpFHD1dbqM70kbxGlDUCA0g6ohaqg4f/IrMXo6W6k9ZAeqTQkG
         Nf1QIbRqlXgw++owhq80lkFcIjEzh5fI5HwMkvFudDVhewia+UpASulWYaScvDIXT/WP
         9P8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747402498; x=1748007298;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TCKX2+ubPZmRS49k2Vh1SgSk5f8TvOPmMU2uJSUuFS4=;
        b=ecHRTDIBW4I2P3igLlNR8n6JMG80etEszXpbCIqMvLC+3py7PKSpl5LSnvMEhfl8/j
         f8GwaDGgbuFkt8SI09OW6faFWRxi/RKVXvV5sml89f61nysbVIHDLOO6fn2eUEH1dwIh
         L8tq+2jZExCGW+mD//1myqcujLW9h+vi4FPYlq3+ChXSnJGt1h4xhRrlp8MDBkyi8XEB
         l2UKZOtgTAV/aDTVnArCqNHy8TncTJLeqfKlLeXAqVDo/j/31QsPIeSpzUDNx/I2NRpw
         9bjyem57CrglZFC7CdyjTku1bTRnaAJ8nBM8ctvnh9xFI0XqOvoeSYSofGwGF64ZQePR
         0trQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp92YIVKrJfDRDkZ2BRNlIMGmN9RkBKPISGzn8P8gLG90wwWbjJhdYEqjsbOH2agdDYxmnL1nFcWQhckTCRm2M@vger.kernel.org
X-Gm-Message-State: AOJu0YxY3YoTKWjPC1pKFXbxW2AO4B5gZ2o/fVWseoGFBLALlptjVMJG
	L7WCDOnkotebHq0Eaktebrz5v3XBBiJUlC5MVEBHW6Svuy8YGloSzOXX0WXVwF4XArqxQZHHvgN
	O/4NWWw==
X-Google-Smtp-Source: AGHT+IHLZNDF6HDiaoIz/4c+rIDHTeF2k0UX9aFwOocIQqarWYVmipuqs3QX1FVECT5G/EZSswsfILH07BU=
X-Received: from pjbpt6.prod.google.com ([2002:a17:90b:3d06:b0:30a:7da4:f075])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d2ce:b0:2f9:c56b:6ec8
 with SMTP id 98e67ed59e1d1-30e7d52214amr5168883a91.10.1747402498195; Fri, 16
 May 2025 06:34:58 -0700 (PDT)
Date: Fri, 16 May 2025 06:34:56 -0700
In-Reply-To: <20250324173121.1275209-24-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-24-mizhang@google.com>
Message-ID: <aCc_AMOUiw69SiQr@google.com>
Subject: Re: [PATCH v4 23/38] KVM: x86/pmu: Configure the interception of PMU MSRs
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
> +static void amd_pmu_update_msr_intercepts(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +	int msr_clear = !!(kvm_mediated_pmu_enabled(vcpu));
> +	int i;
> +
> +	for (i = 0; i < min(pmu->nr_arch_gp_counters, AMD64_NUM_COUNTERS); i++) {
> +		/*
> +		 * Legacy counters are always available irrespective of any
> +		 * CPUID feature bits and when X86_FEATURE_PERFCTR_CORE is set,
> +		 * PERF_LEGACY_CTLx and PERF_LEGACY_CTRx registers are mirrored
> +		 * with PERF_CTLx and PERF_CTRx respectively.
> +		 */
> +		set_msr_interception(vcpu, svm->msrpm, MSR_K7_EVNTSEL0 + i, 0, 0);

This is pointless.  Simply do nothing and KVM will always intercept event selectors.
