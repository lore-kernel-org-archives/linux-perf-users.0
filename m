Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DCE176AC7
	for <linux-perf-users@vger.kernel.org>; Wed, 20 Nov 2024 21:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732138685; cv=none; b=E5qLMr/hPR7gsN4SsIS5aaa+X58+fol0m/LV1fWVKvI0gzsRIL8fJFHPnqzqpGo9/0uGzjtgbB9vL2X7Geh2oDjcBw2wsirt+Z9Cna+dnVwaCv5k8nJL7B6a2xWten1JwQmGC0+0lG8JuYPixpTBt/8/biCWVxKp7kScZcVcFZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732138685; c=relaxed/simple;
	bh=XlXZ4cnlFqDQru63uBgI0es1B56U7QsYTjA4nU2nuiw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gvHcr2gbM4Lel0nvmYYKvQvX/16RRMsuBiNHNbwbWCoKcEeXGX0pyb95WXErntjLd+63j1z6uL7iJ5HrRa23OGr5vg3IGfK8C5FEuIyDslZHmKvD+FNHNq1up/seqFAT4xjZW4iy4o1CGX/BNGOZQQ9fKGtzlvt3KWAPI4ghokM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HQ4LVKjL; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HQ4LVKjL"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ea4291c177so246205a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Nov 2024 13:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732138684; x=1732743484; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hK50UHxviNBEUn8xmLOk7IXRFdynit29NKgyO3ZB+Yg=;
        b=HQ4LVKjLQZc2RAiC+lJJCqKdb0YdRqA5WnQuNRSgyo0Km+yIkYeAT3B+7O9GjO4Nqz
         vPGrBtev2onC/Qxdc60IgaxVOxlyYyAO6jtLk9LEaW45BvJht/UWxdiXhnDBbNE2cPPx
         B6KaIGiUM2rn0EEXqcRLZfEbA5SS51DjVcZdMPOSr1Bq36ti0fcrMbzxw2s9E0D3huC5
         t1q9YpzVZLE2MSUXF++fqnPqMbPnrfxpBo7g5lVWGYGJt4tgxpzTIRU1ienYWhKuP/oa
         ILRyOA2eiMHqRI2Luh/zAC4IKaNVWAyq2qO0czZ77WJNuLAsImmPHXvL+UsRgYSalh3P
         ArwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732138684; x=1732743484;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hK50UHxviNBEUn8xmLOk7IXRFdynit29NKgyO3ZB+Yg=;
        b=Z7gEoVFqII9Vf88IYbfkAYJT3+apfDUncJd/ALwL05VRAur3xQLOaGNipgglMy5WHM
         zr4kcjV6c2Mz/1U3JC8JpEZmUEryh5n9n3JWTDNJGk3EucYIGb9O3AhFFUrBRRNNhPbu
         9nkx2i0QizoLr0Cga+wutCmsij7uCDpgxQN41LZuIl72a5m3sMKdCDy3kXsQf4Oi2Lqh
         ax6o0uueriwzIoEzlAPzca1naht/KqAJSLjW2q0KPYaTtq6HzAEzVv10oqZQGMVUvwx4
         iUlFqYAjjpGG9+6YfrlZVZ96Q9aaMj7XHXhVFlluD51fydXLeBgJWkgmVe5EeBapGoKS
         UWWA==
X-Forwarded-Encrypted: i=1; AJvYcCVNS3HfE299g2KhA2UszRA6x8Fgl9KTff/FU9xv1+tvAw+bpWHVbfz8famTzBfyYzDjCLIg2PDqqfqHS537fpc3@vger.kernel.org
X-Gm-Message-State: AOJu0YzC0EqmLccxDqxzy0kPTypwle6Im1F85/J2ZCE9nNKHK/PFAvhe
	Ce/ew3izkTfOtRHWGZ19WlbxENY1ag2KJsEkSDyjekOD1XWeOqBzZqQqHDRjSLvZD7YI8OtGYOe
	HUQ==
X-Google-Smtp-Source: AGHT+IGkxYnG+hLXLUpjac2R9wZO6qBF93t2mWzts65zA8N1GmLd1ZGgyzq7ef0A6DNF+APY83cNlfgUfQY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:90b:3508:b0:2ea:4154:640d with SMTP id
 98e67ed59e1d1-2eaca0fdcc6mr2221a91.0.1732138683673; Wed, 20 Nov 2024 13:38:03
 -0800 (PST)
Date: Wed, 20 Nov 2024 13:38:02 -0800
In-Reply-To: <20240801045907.4010984-54-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com> <20240801045907.4010984-54-mizhang@google.com>
Message-ID: <Zz5WuqMBdDtZfJBq@google.com>
Subject: Re: [RFC PATCH v3 53/58] KVM: x86/pmu/svm: Set GuestOnly bit and
 clear HostOnly bit when guest write to event selectors
From: Sean Christopherson <seanjc@google.com>
To: Mingwei Zhang <mizhang@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Xiong Zhang <xiong.y.zhang@intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Kan Liang <kan.liang@intel.com>, 
	Zhenyu Wang <zhenyuw@linux.intel.com>, Manali Shukla <manali.shukla@amd.com>, 
	Sandipan Das <sandipan.das@amd.com>, Jim Mattson <jmattson@google.com>, 
	Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>, 
	Namhyung Kim <namhyung@kernel.org>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, Like Xu <like.xu.linux@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 01, 2024, Mingwei Zhang wrote:
> From: Sandipan Das <sandipan.das@amd.com>
> 
> On AMD platforms, there is no way to restore PerfCntrGlobalCtl at
> VM-Entry or clear it at VM-Exit. Since the register states will be
> restored before entering and saved after exiting guest context, the
> counters can keep ticking and even overflow leading to chaos while
> still in host context.
> 
> To avoid this, the PERF_CTLx MSRs (event selectors) are always
> intercepted. KVM will always set the GuestOnly bit and clear the
> HostOnly bit so that the counters run only in guest context even if
> their enable bits are set. Intercepting these MSRs is also necessary
> for guest event filtering.
> 
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  arch/x86/kvm/svm/pmu.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> index cc03c3e9941f..2b7cc7616162 100644
> --- a/arch/x86/kvm/svm/pmu.c
> +++ b/arch/x86/kvm/svm/pmu.c
> @@ -165,7 +165,12 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		data &= ~pmu->reserved_bits;
>  		if (data != pmc->eventsel) {
>  			pmc->eventsel = data;
> -			kvm_pmu_request_counter_reprogram(pmc);
> +			if (is_passthrough_pmu_enabled(vcpu)) {
> +				data &= ~AMD64_EVENTSEL_HOSTONLY;
> +				pmc->eventsel_hw = data | AMD64_EVENTSEL_GUESTONLY;

Do both in a single statment, i.e.

				pmc->eventsel_hw = (data & ~AMD64_EVENTSEL_HOSTONLY) |
						   AMD64_EVENTSEL_GUESTONLY;

Though per my earlier comments, this likely needs to end up in reprogram_counter().

> +			} else {
> +				kvm_pmu_request_counter_reprogram(pmc);
> +			}
>  		}
>  		return 0;
>  	}
> -- 
> 2.46.0.rc1.232.g9752f9e123-goog
> 
