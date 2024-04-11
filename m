Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C30447A4C
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 23:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712877518; cv=none; b=Djn04xXf/Uc5hSQ6T3So7IOfTPCczccePqiwVpE+k/GL8JB435MI3rCf92nX/7vHuUC78H1vO114KLYEcqQsupep9kjs+s/JD0Lx1tzSgJOcPKupqgl2VQ9UIMW/HIcbhr7V3a1ZH0bgpkFUyCb+4zMx6F5JenL+vCZ8AgoJRPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712877518; c=relaxed/simple;
	bh=ChViTqgL4O0iExSvoXkrz8rlXUh1To7gRM7Ht5KUpHs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=doIZTMKnRT/d6ppiCmYdNS4UdPFmcjUOBODItjy44t1YJaiEOwH8DIeSGPe7oL9PT+uA4gy05ZbB4T7KEcwIK4k+YfABY4aBCPA79dJV72yn4EuaBYvaICfq5rguGJ9FyA5Ww4W2KAYtT7p2vCA5QbCLHlTZFKC27SwHyNFkelY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xrjbTxXF; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xrjbTxXF"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6ed58bc3d23so231850b3a.2
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 16:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712877516; x=1713482316; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=saPqzjSurmxMimUcoDIYz/TWWrwnNJQ5t2nRzRoA9jA=;
        b=xrjbTxXF07QyD9tjqrk/H8jq086lEHjMwzXhFCB3uQxE4rp6/4zWqbWOzDzcoRQq3F
         S9DsvJqAtHAe82kKQ/46o1U+Katt/t40OJO0zgVvCuY2Fqcl7CKAMEL9Lgi1WkXiN1zm
         d7zJOmOBp9FuxEL86QyhA1f+7OAo5MRbSWwLXTHp59MrZcyOM5dxzjMXNddNXqF9vVYX
         jHaLK76DdbD6TLYm7ZXBd/VQx91i1dUrBuwz9i1GFp/HvhH9D50ETistrRGtDWcvKrSh
         YIF4PkWhtgcGU4lbkcdCjJly3CPsGq5/J+JdTGBre/FlVM9UFf0cbmKCBzLyutTA5fmN
         ZmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712877516; x=1713482316;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=saPqzjSurmxMimUcoDIYz/TWWrwnNJQ5t2nRzRoA9jA=;
        b=cuimOWZtS5r2mWBuphUjPXaS6844cxZ5B+ASnAn8/oggS+LIosodotJWx2R2wSNeBe
         02mdUraITZa6wXDW4rSBT/9LslGo4sRfs+njHJsBNv23hdMfnTkfLaP5U+xC4hfWSSb0
         IIDwSgZpMxg8a/C5idUHjHnYigFVj6U0d6ZVaZsp0/pVwPSG/ur76q25JlXfqrpekjr1
         tKoY0wAtDvs5qx6tGTFu6om16qS48XYMLvJfVcsQXg/dcAdyeMQR/qwycfx5Mgm09u2I
         L0Z0cMnwKfMNXvHFJbLUxhtzKhckphu08wV6YeMCvWKCVAVtKw+/PXW7x+IRP6Zvk52K
         wg1A==
X-Forwarded-Encrypted: i=1; AJvYcCWJr6WcIRBp5jDWm25NCNZDu736h6ievlmLLMm6wnO9wQc5+SCbAImzQiQ9P5LoqOI1+sv04WhH5/11kA0N+VsLy6OzC7ahvR8nVH6oZBTTpw==
X-Gm-Message-State: AOJu0Yx+5nOO4YI67ZKnvMdM+IQCN0kIUBVX1v/7vgNe0I3w9Nvbtxyj
	1QMgsvHaPy7gB2aP0MQR+t/KSW7oaqFeZiTdIMdtTLSeVDjtX3pHzkBhKzSc+tBwNFrpURHZenn
	jzg==
X-Google-Smtp-Source: AGHT+IG8Zh+SkroWzAkIZMDgaZKlj32yE60tkT4BNAP8+QtCUFi+5DUdxxp9vGpRq/V5umwS9iv9z7OxYOM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2d17:b0:6ea:c2e5:3fc6 with SMTP id
 fa23-20020a056a002d1700b006eac2e53fc6mr40035pfb.4.1712877516535; Thu, 11 Apr
 2024 16:18:36 -0700 (PDT)
Date: Thu, 11 Apr 2024 16:18:34 -0700
In-Reply-To: <20240126085444.324918-41-xiong.y.zhang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com> <20240126085444.324918-41-xiong.y.zhang@linux.intel.com>
Message-ID: <ZhhvyhdvF-1LZNlu@google.com>
Subject: Re: [RFC PATCH 40/41] KVM: x86/pmu: Separate passthrough PMU logic in
 set/get_msr() from non-passthrough vPMU
From: Sean Christopherson <seanjc@google.com>
To: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Cc: pbonzini@redhat.com, peterz@infradead.org, mizhang@google.com, 
	kan.liang@intel.com, zhenyuw@linux.intel.com, dapeng1.mi@linux.intel.com, 
	jmattson@google.com, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com, eranian@google.com, 
	irogers@google.com, samantha.alt@intel.com, like.xu.linux@gmail.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 26, 2024, Xiong Zhang wrote:
> From: Mingwei Zhang <mizhang@google.com>
> 
> Separate passthrough PMU logic from non-passthrough vPMU code. There are
> two places in passthrough vPMU when set/get_msr() may call into the
> existing non-passthrough vPMU code: 1) set/get counters; 2) set global_ctrl
> MSR.
> 
> In the former case, non-passthrough vPMU will call into
> pmc_{read,write}_counter() which wires to the perf API. Update these
> functions to avoid the perf API invocation.
> 
> The 2nd case is where global_ctrl MSR writes invokes reprogram_counters()
> which will invokes the non-passthrough PMU logic. So use pmu->passthrough
> flag to wrap out the call.
> 
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  arch/x86/kvm/pmu.c |  4 +++-
>  arch/x86/kvm/pmu.h | 10 +++++++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 9e62e96fe48a..de653a67ba93 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -652,7 +652,9 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		if (pmu->global_ctrl != data) {
>  			diff = pmu->global_ctrl ^ data;
>  			pmu->global_ctrl = data;
> -			reprogram_counters(pmu, diff);
> +			/* Passthrough vPMU never reprogram counters. */
> +			if (!pmu->passthrough)

This should probably be handled in reprogram_counters(), otherwise we'll be
playing whack-a-mole, e.g. this misses MSR_IA32_PEBS_ENABLE, which benign, but
only because PEBS isn't yet supported.

> +				reprogram_counters(pmu, diff);
>  		}
>  		break;
>  	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index 0fc37a06fe48..ab8d4a8e58a8 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -70,6 +70,9 @@ static inline u64 pmc_read_counter(struct kvm_pmc *pmc)
>  	u64 counter, enabled, running;
>  
>  	counter = pmc->counter;
> +	if (pmc_to_pmu(pmc)->passthrough)
> +		return counter & pmc_bitmask(pmc);

Won't perf_event always be NULL for mediated counters?  I.e. this can be dropped,
I think.
