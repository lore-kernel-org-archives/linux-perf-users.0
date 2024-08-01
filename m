Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621B1142E62
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 05:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488461; cv=none; b=LFTjRrbuBu7RgUZdCPNez1DrdK5CXp3M03vNqBRm67PZADtQrojUuUEPKiWUisvQPfdwAawWsCvjGvST9LZMnoFbrEgxkjGXu1UHf1RDl3F8fmFq91q5nA1I60Z8wWQLz8F+nVTWGkHvrT9NS4pxMfMvjyteaRPBqUa+5AABLD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488461; c=relaxed/simple;
	bh=fXP7LGydKCxqdr0K8IzhBFKvsQh/bpt5mTvxJ7gEmnI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jO0ZDrVft3E7gitxP1wU/fHJvCh03CiXjUQ40PFH34p9rPebcnD74STeQqv2COVWLSOW75XI8YCLYPAhWzNqb2yes4QoUJslLI20j3tNqa+2RP4vzY402bI6idtqldPxzmJjjSkKqT3dKpwl/PLAd77V4vSXPHC/PYOeeKRhEGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KB4fx7ok; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KB4fx7ok"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7a2787eb33dso6445994a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 22:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722488460; x=1723093260; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=GjoERFKejGpS4usQM9OjkSeO52H+0Hj79NteoX98Mb4=;
        b=KB4fx7ok7gWdQwbs/O4qurCUMMjvJtT7UpIif3wf+yWCJt1uvMuSLcAQX8I494oCCy
         dGK4cYDqBty7+yBvMhBG6uAgKsNBID/WYfX+xbwSH2YsMSg6jKfgRXa61IPc65G8f/3q
         XhM7lPdiTiOIGQzSqTPPjBMdt2vqLiOVKvTX0GotIwtWCFvjMx2ycjLyo3fQoIXIAaUr
         GITAmzcs+XUa0myy5qXLVK5CeA6noSfg73CtI0dv+Aux4Foywqkvm2e1i5KkgKyY6ng6
         JujhRX8imve7o7BVK5NcWiYKKOf9PkiDklE4FReoCAm7lSTDYp9cD5py7X18wZ6vU0+u
         iMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488460; x=1723093260;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GjoERFKejGpS4usQM9OjkSeO52H+0Hj79NteoX98Mb4=;
        b=YauAse1iQqoC8YtX4haSd/K5478adR2RmZ1FN1hQ7aYZnT2of4x7iPgnShbfGFMNoz
         OgNDPtg2pvObONlmQxaBka70mZvEB1jZJn5EMgoLkiciTWyi4rVkq0taj2HfRjt8LPbz
         /4DzmvfKH86HkVZvzyj4emA+lhRJWvzu11u6Qxpkp+xF0IUqKIhQ+3E+Tm44xboB26wE
         s8SOFiIvC+q8H8XL3XbO7hfoI5LI+g8kLn8vfDd/RvKNB9d0AajXy/eqAtNd1UvgN7qG
         dstpxDMHLWB2Jr2BnhbKbp5KC4c/hEPM6O98cgTU1ECwh7OHbrIasJZFvt87tq9T33mb
         /PgA==
X-Forwarded-Encrypted: i=1; AJvYcCXE4WXylYHlIAZCOCYwKr4/HZvDY1p8omgp4tUItHKs3sXhRAX14OWnIb141l9ff8SRzwknpX8vkBuFueJvQqdm3/z7CuMfCvDpOgj4vGnT1g==
X-Gm-Message-State: AOJu0YwbOcVV4Sy5Bwe7ZzUBg0O/jcV25ckIT3WJjAUfkUxGvmQAHKi7
	MRtTUPfe6oqyyb9FWl8/WWGzV4cRKgIfnBMY7jZ0yHsxGxoYN3jZGxMBCz/MFC2YemZAn5WXxrl
	lHL6l8A==
X-Google-Smtp-Source: AGHT+IGH2B5hZj0CoAd0yBCiQG/xuC2VJX4+PA9cCxAa4A9gXQ/fi05isczh9OmtU5VnOqVQD7tgqygc9Fct
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a63:2543:0:b0:7a1:1324:6294 with SMTP id
 41be03b00d2f7-7b6362e5872mr2479a12.8.1722488459548; Wed, 31 Jul 2024 22:00:59
 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu,  1 Aug 2024 04:59:07 +0000
In-Reply-To: <20240801045907.4010984-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801045907.4010984-59-mizhang@google.com>
Subject: [RFC PATCH v3 58/58] perf/x86/amd: Support PERF_PMU_CAP_PASSTHROUGH_VPMU
 for AMD host
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kan Liang <kan.liang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Manali Shukla <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>
Cc: Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>, 
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mingwei Zhang <mizhang@google.com>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, Like Xu <like.xu.linux@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Sandipan Das <sandipan.das@amd.com>

Apply the PERF_PMU_CAP_PASSTHROUGH_VPMU flag for version 2 and later
implementations of the core PMU. Aside from having Global Control and
Status registers, virtualizing the PMU using the passthrough model
requires an interface to set or clear the overflow bits in the Global
Status MSRs while restoring or saving the PMU context of a vCPU.

PerfMonV2-capable hardware has additional MSRs for this purpose namely,
PerfCntrGlobalStatusSet and PerfCntrGlobalStatusClr, thereby making it
suitable for use with passthrough PMU.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/events/amd/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 1fc4ce44e743..09f61821029f 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1426,6 +1426,8 @@ static int __init amd_core_pmu_init(void)
 
 		amd_pmu_global_cntr_mask = (1ULL << x86_pmu.num_counters) - 1;
 
+		x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_PASSTHROUGH_VPMU;
+
 		/* Update PMC handling functions */
 		x86_pmu.enable_all = amd_pmu_v2_enable_all;
 		x86_pmu.disable_all = amd_pmu_v2_disable_all;
-- 
2.46.0.rc1.232.g9752f9e123-goog

