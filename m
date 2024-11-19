Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F3D1AC43E
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732028061; cv=none; b=LjAX96ddHz63sFJEhj2Ks8xK3sGgNAA59q0IyO18uBGS/0bLMjZ2gUU5YVZxenPzJPc2s74LcjVeIXOZ/O3yzkpSboJMbj1n/QysOLCcovwvfLDmimE2pNFGrn/wp6cUyUADgJYuGFcmjgsnGw88x45E7dIeZd+U8I49dY4cpHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732028061; c=relaxed/simple;
	bh=9128xCGIuXvaU49NjF1mWOVwIXLIuhSsSSvvDia+hRM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BJhCVKtGyuM3aW+wRSen8/gEET0n0hdnGGWYlhc+Wg8ZQX3Jk91igIE3krc3qHQREpU/L/CZyLaVCWsGmtR07GxiN4mwszLZPAJX+X46I7Vkli+GIJgm4lRJgHRqTtT23j6joAY0pGdwU5wzRoWdSU3CHiIB+iE3bvof20GdxAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oHjRfWxE; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oHjRfWxE"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e38100afa78so1601938276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 06:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732028059; x=1732632859; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ng0ADcAUF9BEyC9uJKl/YJ6KNTlUn/uj3eRa3WTv12c=;
        b=oHjRfWxErSqPwtqb12j0vCL79W1CkdyjN1yCvKdrGJ9qRw+EoqDkxLRyfA7mQjujqy
         1Buv15KL3HAvGer7XOwxTbgn8dw6o6ed022FmLvrFmHKM7h1mFi5x0YqGj7TMQapfZxd
         0nvB352crXsBCuQ61G840u76kyImV3deMwbEG3WC/MJ2t+s+CawbsZZV2+tl8yKFCk+k
         3KnIdMQLjObrEnxnJsY39ODdixwnHNpA2snI5g7CacDE32R6fGEhHJQ3epbKfVu1waMa
         1HNM0QZe/wvA5qvErjMmBVdrLGbHkzoOj2bmmK/qYBfUEkdiglhs3LST2b6Cx+Alt3Ha
         IRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732028059; x=1732632859;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ng0ADcAUF9BEyC9uJKl/YJ6KNTlUn/uj3eRa3WTv12c=;
        b=CEDhARZ9GN1ER38k+3j9+Ow1DX89Vau4gkoCkC9d8hKyYEdZgJKo+2Vcr4zf4aAHQz
         NOdmtjSNm5gRJW34BRtUV74FQM3Ms4kSAUbFokEqskw4bLwTr5EYjOCqzAST0dpGFLBK
         DRaEkVwmAjfZzkawIxNv5/3fBE6ALEKCeSKh9OI7n6MzabT1PPh9paF/mPbFGeWPI57v
         Dtknhk8UUr1XpBmV6Vf4ocrhRbeRhzxxPxg8sVBiguRgJtHZmSy2om4Hug+8W2WkzJT4
         kdGThJlNMvAhw5ICpveo9cuelBXPn+mX9Nfzas4KbB7WrLKpLDTOEFz7+nNDeWl4LGxB
         DpCw==
X-Forwarded-Encrypted: i=1; AJvYcCXMHnJoRhjh782gIotHyh5XTYxw1y9jPAX4dKI/Fv4sYhft6fqnB/CR+ewPeQUykEYRlA80OR3XDK5nS7EKmXe8@vger.kernel.org
X-Gm-Message-State: AOJu0YxwPP5UiNIvrQdL8rM8BxdD0IXkGZbk8BsFKeD7MTn6Ldl0lZOP
	zxq7RhXA3oLg/r7ZkYGWgH7uVfuZnAFWpp3PTlZ5uKIb1ctPF4HCIFQMNOjgM5Acd1c+K8i9HQ4
	y3w==
X-Google-Smtp-Source: AGHT+IHiBjarvPBtAHSxJkTUMY7pwcio1/kissXeruut+bT10tYNA48Ju6CocKcSJ83LEgeAx93OLOCj1yQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:acd3:0:b0:e38:c43:3002 with SMTP id
 3f1490d57ef6-e38263d33ddmr171019276.10.1732028058911; Tue, 19 Nov 2024
 06:54:18 -0800 (PST)
Date: Tue, 19 Nov 2024 06:54:17 -0800
In-Reply-To: <20240801045907.4010984-20-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com> <20240801045907.4010984-20-mizhang@google.com>
Message-ID: <ZzymmUKlPk7gHtup@google.com>
Subject: Re: [RFC PATCH v3 19/58] KVM: x86/pmu: Plumb through pass-through PMU
 to vcpu for Intel CPUs
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
> Plumb through pass-through PMU setting from kvm->arch into kvm_pmu on each
> vcpu created. Note that enabling PMU is decided by VMM when it sets the
> CPUID bits exposed to guest VM. So plumb through the enabling for each pmu
> in intel_pmu_refresh().

Why?  As with the per-VM snapshot, I see zero reason for this to exist, it's
simply:

  kvm->arch.enable_pmu && enable_mediated_pmu && pmu->version;

And in literally every correct usage of pmu->passthrough, kvm->arch.enable_pmu
and pmu->version have been checked (though implicitly), i.e. KVM can check
enable_mediated_pmu and nothing else.
