Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CDE16DEB5
	for <linux-perf-users@vger.kernel.org>; Wed, 20 Nov 2024 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732127562; cv=none; b=s6MbZTcC3c0YY0CXfsVnYDQi2hScLttlWex44uy7NHbiKZ+tw1JaGuf1PCqTxX1tZ/3zlNtWHkmdR0ZBQDg42/8sXrzkmkpXgn+9dIJRzfsTNW9kz3HS8132YL+DZacBvyuK1hyB4JLRLbGDV6uqnwmHuvIEP+i91OuqVqAGZhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732127562; c=relaxed/simple;
	bh=VwJjkubkHDIoV/PS9SZTOQZlbw49t9+3GHSQEL6b5w0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=umwB0TQbfTr6A4L+GnBWvusppQlttTN43gpS2kAPWBbkNFL295LH9hACGs8kjskDgwPtXq+S+XsifijxF3HVYCS7+MaDFOT5r8iTzvMGa+B+qTeROy0HLJDLVlKQU8xyTtc8xSmr9R9sRdrnPdqoXwq0RFczGlBQjeF/mc9xCBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yZM3ErQx; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yZM3ErQx"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6eea70c89cbso323837b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Nov 2024 10:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732127560; x=1732732360; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9u128fHaxTBEIQSTD7iYlkQ+Vq37JApl5B1pQcBgC74=;
        b=yZM3ErQxlgbnLVpdnCWEOh7blIyA6tm7J8wglg3hYQOpmxdg5zGFpxqXVBWA2pdBqJ
         D64T+wV+tjK+gG8FctHpteRNrU5dBHpotWzS/iNxjdf9ifAU54yx+rmLpgux0Fjn5s6S
         bOZrAqbTLK0Cvlc2z5tBqj9ZfFlCzF09o9W0sRWq7g6lLEprFZ0aRG+b+SVl0S0FDWyz
         GAkX8GZaeaucYI00gQI9/JiZ+r+h2+iV23Qmy8x9/gpSZEXYcEOh3zKgbv928rwBeKJH
         10aXX6fQXqSGO/kqdqX8dHbAP+3i3QcBKTTpBjmosIOjXppJ2P5UXYEHxydPRSTZ/Vh0
         N/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732127560; x=1732732360;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9u128fHaxTBEIQSTD7iYlkQ+Vq37JApl5B1pQcBgC74=;
        b=dGPp6C3/f0wbnLbH/oPGaqWLghhyKgYlAfywO8Qjq1eaz7+4RoW4xr1eubg7KNVsQa
         xC78fqYcFgyal/EddoIL022NNv/99sK7eJYH+SqXXvjFl9yHVN5LAdjfYvSCGwmYFWOT
         Xsl5I0lpVxQUY+KGQQ3gI01Ya/C1pPZDgrdkR6UzlN3WQTNlY0WPr3ib7DC9a+OZiT+K
         qWivSSUVw+GXaoyxF+LGe4JZAmEQz0xqmDrGmi/oGVQllghiOCpZkqMJdy9dGgqlsTWF
         SjYjlcf8QgtYQH5EpNistn8fYaN777tStoEqYL0MqFu0iXKK3Op3Iunnt2qYD14BxoXz
         fvuw==
X-Forwarded-Encrypted: i=1; AJvYcCVsoF09rq9DBbRXolXgnZY82bBE2/x5EuALfdxdAbLLeBhgqMOkKFUJG5ARaJbk0CPLnzX9E3AVm82PvCcLoKup@vger.kernel.org
X-Gm-Message-State: AOJu0YzKzXYEd1w165DngbYHmmdntfOZ1NUYr5ctCyjjkK9U8GSAM7Ig
	K1gJU7pnKa7HSaHGcA4UDXndOZgqe46avgcAkWSH1JdF49eAIdGooWq9i3MhNTpaKYlwUCtkkf9
	yvg==
X-Google-Smtp-Source: AGHT+IG2KRTDVbxTtjyliF8d8kQoavYibFy65daI/RR5ZCi5PcdupGkOPRKNJ569wi+RIoyN0Nhf6nfki54=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:2b0f:b0:68e:8de6:617c with SMTP id
 00721157ae682-6eecd349dccmr34737b3.5.1732127560373; Wed, 20 Nov 2024 10:32:40
 -0800 (PST)
Date: Wed, 20 Nov 2024 10:32:38 -0800
In-Reply-To: <787182e1-75af-43dc-b7dd-179664022170@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com> <20240801045907.4010984-29-mizhang@google.com>
 <ZzzX0g0LtF_qHggI@google.com> <787182e1-75af-43dc-b7dd-179664022170@linux.intel.com>
Message-ID: <Zz4rRtg0Kfnl1798@google.com>
Subject: Re: [RFC PATCH v3 28/58] KVM: x86/pmu: Add intel_passthrough_pmu_msrs()
 to pass-through PMU MSRs
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Mingwei Zhang <mizhang@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Kan Liang <kan.liang@intel.com>, 
	Zhenyu Wang <zhenyuw@linux.intel.com>, Manali Shukla <manali.shukla@amd.com>, 
	Sandipan Das <sandipan.das@amd.com>, Jim Mattson <jmattson@google.com>, 
	Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>, 
	Namhyung Kim <namhyung@kernel.org>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, Like Xu <like.xu.linux@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 20, 2024, Dapeng Mi wrote:
> On 11/20/2024 2:24 AM, Sean Christopherson wrote:
> >> +	    pmu->nr_arch_gp_counters == kvm_pmu_cap.num_counters_gp &&
> >> +	    pmu->nr_arch_fixed_counters == kvm_pmu_cap.num_counters_fixed)
> >> +		msr_intercept = false;
> >> +	else
> >> +		msr_intercept = true;
> > This reinforces that checking PERF_CAPABILITIES for PERF_METRICS is likely doomed
> > to fail, because doesn't PERF_GLOBAL_CTRL need to be intercepted, strictly speaking,
> > to prevent setting EN_PERF_METRICS?
> 
> Sean, do you mean we need to check if guest supports PERF_METRICS here? If
> not, we need to set global MSRs to interception and then avoid guest tries
> to enable guest PERF_METRICS, right?

Yep, exactly.  And that the "nr_arch_fixed_counter == num_counters_fixed" takes
care of things here as well.
