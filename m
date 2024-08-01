Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B2F14885C
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 05:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488442; cv=none; b=V2v0jkDAke8th+MANeMkClJF6KLrPkoeh4F6Q6Vww0/U3gL2/ojmPQp/s8SrXepE0p+GfAXJJ4NxTlQ5ItH79oeQxxUkBLUX0dGjcEYovocaZGFe9ZLXLESP1jz9oUDLXHHw05oNP7Py/+4CgLvHLU6SpArPjOzMTIp7KiQBj8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488442; c=relaxed/simple;
	bh=gl95pBxp7BeyG9K/Y+Fnr6+jDVQ1IDOMug3Ga5gpSNk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eEVYENgFXrwao5VcA415ouohqhUUgzAEtsSRbbx5RPb4Pkn3DN2++RHzvzGUZwt3F30j9AOreeAWgd38g0iOa35H7us+qtCNegdF3G0wNWtZb/u2kbyFnreeN9/ruGxEro7OFSwP4x5I5d8zBEO2G8TN/CY0WfA8QIdDiD6518c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Ry74xMc; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Ry74xMc"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0badb6a986so3934139276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 22:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722488440; x=1723093240; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=CkIYviuQ5dR+yDR0bvvzUB4JBAAA8hfQoQWbxFCrigw=;
        b=0Ry74xMcCmcncRcFeZ0/SPAb8d5pUnKs/ZU7KPH2D5ZY6x8u5kGVgXeAZrUvBr57YT
         OyeuajcSWBLDdemiBsR90baehx2/0+8wTK5WZZpoXJzF4UYBk4EHkyYwunlh/vjVn5mg
         m4IXnX8/1+ZQEQsvzfh9ZmpJjOino7cRiwrIv+ovkPBYIfhRmH093RWYPp/nKnW6Mx0i
         Nx3SC2ntX9vJUuqrRIWLl6hPv5KCm1hTF4LWpHa/XTlHHKm2Xe4VNaTkJBjBZFcXsu5T
         6I5eetdYns1yzIZfR/060wTs2dyhByUcgoHT+wlJyWvV1cFK4EB/6ky+M5tkwH+A5/M4
         lSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488440; x=1723093240;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CkIYviuQ5dR+yDR0bvvzUB4JBAAA8hfQoQWbxFCrigw=;
        b=bb+cRLtUgG/Fpc1nbbNSRtwzI9FYaqTCMDpHTCbNz59DUotSGIaEGIAiCZ3gmYKeo5
         k/+7yTwA7vBO6frd5FtQxsZCWceAmvPXNN5Yi0P9EiEN7jutDOgoRtJHxleqip9aA4ih
         xXA01FNE3i3Mzz2cyqQ//yxZmRe3xbhboZ1BmnpGC/B4j2dXYLmewBR7XMXbGN9CQDO6
         uKgsZr1jqK5k0W4rhTRDr+LJTSEjNYRMgbQ48al4Tt0EpkuR/ZuBqG2v7byICLHEZmVm
         JjlWsuzlTQlut9qD4+f3M9Sows3h7yEZPq4dJ6JRHAzTPYGk6ttNjX8NL2YHUy0N9O4C
         u6xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEtUeyCnc0ovE85B+gwDYpo5QasOU3E+vADRd33bErxeYVD1zV2RrsvCHnKAyaxUuXPEOqjPaOMIzVs+2fMCRvqj+7PWHf9ghIET8uYkGqrQ==
X-Gm-Message-State: AOJu0YwnaJXwF7NJnwZTu1KgDfDm2j+DOL6RcE5i3ncrPRqtUCm26R5g
	U0WJhr+oEWZ04F4075mVx7Dodpv0S79S3qUq6rHTjVk8aFqZRCE9QYRk0YGlonj1wq3w7UzzfqH
	OPkRdzQ==
X-Google-Smtp-Source: AGHT+IHdlDxVEdWmfC6yxxfRkAXJgX2CgLmJcYEVF4/LpbYxa8ZRj7AVmDXVoAKs5gqpvX3cXhcOPaWAIdy2
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a05:6902:218a:b0:e05:fc91:8935 with SMTP id
 3f1490d57ef6-e0bcd28c40cmr3086276.3.1722488440480; Wed, 31 Jul 2024 22:00:40
 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu,  1 Aug 2024 04:58:57 +0000
In-Reply-To: <20240801045907.4010984-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801045907.4010984-49-mizhang@google.com>
Subject: [RFC PATCH v3 48/58] perf/x86/intel: Support PERF_PMU_CAP_PASSTHROUGH_VPMU
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

From: Kan Liang <kan.liang@linux.intel.com>

Apply the PERF_PMU_CAP_PASSTHROUGH_VPMU for Intel core PMU. It only
indicates that the perf side of core PMU is ready to support the
passthrough vPMU.  Besides the capability, the hypervisor should still need
to check the PMU version and other capabilities to decide whether to enable
the passthrough vPMU.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/events/intel/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 38c1b1f1deaa..d5bb7d4ed062 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4743,6 +4743,8 @@ static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
 	else
 		pmu->pmu.capabilities &= ~PERF_PMU_CAP_AUX_OUTPUT;
 
+	pmu->pmu.capabilities |= PERF_PMU_CAP_PASSTHROUGH_VPMU;
+
 	intel_pmu_check_event_constraints(pmu->event_constraints,
 					  pmu->num_counters,
 					  pmu->num_counters_fixed,
@@ -6235,6 +6237,9 @@ __init int intel_pmu_init(void)
 			pr_cont(" AnyThread deprecated, ");
 	}
 
+	/* The perf side of core PMU is ready to support the passthrough vPMU. */
+	x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_PASSTHROUGH_VPMU;
+
 	/*
 	 * Install the hw-cache-events table:
 	 */
-- 
2.46.0.rc1.232.g9752f9e123-goog

