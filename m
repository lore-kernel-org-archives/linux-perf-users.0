Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002513BBA08
	for <linux-perf-users@vger.kernel.org>; Fri,  8 May 2026 23:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778282046; cv=none; b=XQl56cEisd7UB2pCPB1I0KpLOg4Ey7TiQ4n/EIoiGNgxvhpsJtygrV+ze7zCXwlaszZe0PTytIKyMYphoPLly6TNjbS1jQQqIrZXTyGMDJfOa9yPrLA6f3J5HDtgcSlP5CSWBmtFlE/yQx/Qb9Oh2zDvgea5nAUXGCigkeWQjoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778282046; c=relaxed/simple;
	bh=otxpZlAkHL5y/QJE3G7rXySXlAmg9ZfAXrLlLt/iukw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jFtUQ4M5pe/9pRe1SMPMWMmu7MT088rF5AzylO7Pmut0IMs/ejOkHor+yY4WhDBbO4wQDVD3IED2HqvLFbgS+gG9fCQ9ZoYe9i2sh2BJaJ4mqekEx9XxKE5PAyJ07dfr4EF55204i/SjPc9qS4qv3vbnhnkUsZ1JaJBYyW9WqR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aHSEJIo8; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aHSEJIo8"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b9fe2d6793so47007475ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 08 May 2026 16:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778282043; x=1778886843; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=3hn/vCE+SheJ11Toa1ORgidQGCGEmHGjeA0kV3k6HSI=;
        b=aHSEJIo8yiUuaIJPqXXdH5YPIOyhvJxNQ4wU6b8VYp+d56noOimiqNwf/4knnhrt3H
         lxeXwaIe0uu1RwYW9agkuyCeSyjDxw1vGvvz+ql/TeM/TPfOkxG1E05+5mOWVmcJLWUp
         QdmqGW21M04iJf/U/NKP930Ri8p+ROpOlhKEq3Inq+SdlhifImO+p++NdOOc1EowHqSE
         DRJL3qXfZl7xPXXVVpwl/tUrqLbUGmXN221REiomrbICJDUeKeyhOr5d5GOcTYVgRvHZ
         cCLqMCWalLqdhV6K2nMlGMeaceZ1lZW7rKEuYxCkfuOsN51Ler3W6cuhDsOihyTy/Zex
         wXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778282043; x=1778886843;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3hn/vCE+SheJ11Toa1ORgidQGCGEmHGjeA0kV3k6HSI=;
        b=UUxEYYbItNqLbYCePg3BfTg/Wr6Iwn6FX1lrpUCt69oq0U23QSc2eXNlaHuE87XQm+
         TNP4WEb+uigBXuWc1mf4UhadEt3ueMS2cVdDfQlXFk9WjUxnu1PscIgE99BMdwb/Vsy5
         0txPQUignEuukO+DYD+3HDaDgKKC2pBd/RgnNnJ33Qcapf/TzN9oA1jBIBiqbfZ1C/d+
         J+ZlrqSqK+Mxd7eG+SsqDWKWyI9f9dgC8tmL+XRC0l4bdLkgzQMNVuN+CxTJJEg4pubH
         uOkLw8KYvsWoKW834J1bK+ftLYVCbAI2sYllvZAXjoKfNcRwJSAdSg+Bjwpu4pYJo7Rc
         mUvQ==
X-Forwarded-Encrypted: i=1; AFNElJ8UYaD0ZLm14y1G8/zB58JMM+jJIJlu7VCXv09YTurguXkc12pjDtl3+rGY+YSB1sxW9rvuv4hMEm08PR4E4KKx@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtkg5VrneFGMpUyT6runwlIpHNQ96CNQUfa8aSiujBSGPo3v22
	if8Fumr6x7pmENgKc6dAnfW72b8xpMUfN6KGY7rN0A57u2/5ac1kd2EYmlRpHKa4K2rJCPeBTX4
	9Ls1oYw==
X-Received: from plot2.prod.google.com ([2002:a17:902:8c82:b0:2b2:50b1:327c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c410:b0:2ba:839e:15dc
 with SMTP id d9443c01a7336-2bc7a9b46a8mr2444545ad.17.1778282043244; Fri, 08
 May 2026 16:14:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  8 May 2026 16:13:51 -0700
In-Reply-To: <20260508231353.406465-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508231353.406465-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508231353.406465-8-seanjc@google.com>
Subject: [PATCH v3 7/9] perf/x86/intel: KVM: Handle cross-mapped PEBS PMCs
 entirely within KVM
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Stephane Eranian <eranian@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Now that perf operates on a KVM-provided snapshot of PMU state, handled
cross-mapped PEBS counters entirely in KVM by clearing unusable counters
from the to-be-enabled mask instead of foisting the work on perf.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/intel/core.c      |  8 --------
 arch/x86/include/asm/perf_event.h |  1 -
 arch/x86/kvm/vmx/vmx.c            | 10 ++++++++--
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e9acfc3f3a82..8f6be0cc4c4b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5053,14 +5053,6 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr,
 			  ~cpuc->intel_ctrl_exclude_guest_mask &
 			  cpuc->intel_ctrl_exclude_host_mask;
 
-	/*
-	 * Disable counters where the guest PMC is different than the host PMC
-	 * being used on behalf of the guest, as the PEBS record includes
-	 * PERF_GLOBAL_STATUS, i.e. the guest will see overflow status for the
-	 * wrong counter(s).
-	 */
-	guest_pebs_mask &= ~guest_pebs->cross_mapped_mask;
-
 	/*
 	 * FIXME: Allow guest and host usage of PEBS events to co-exist instead
 	 *        of disabling guest PEBS entirely if the host is using PEBS.
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index bc7e48f6f4a8..19f874a79ab0 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -790,7 +790,6 @@ struct x86_guest_pebs {
 	u64	enable;
 	u64	ds_area;
 	u64	data_cfg;
-	u64	cross_mapped_mask;
 };
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
 extern struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 9f0a028cf10b..fbe3ce5f5a51 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7319,8 +7319,14 @@ static void atomic_switch_perf_msrs(struct vcpu_vmx *vmx)
 		.data_cfg = pmu->pebs_data_cfg,
 	};
 
-	if (pmu->pebs_enable & pmu->global_ctrl)
-		guest_pebs.cross_mapped_mask = intel_pmu_get_cross_mapped_mask(pmu);
+	/*
+	 * Disable counters where the guest PMC is different than the host PMC
+	 * being used on behalf of the guest, as the PEBS record includes
+	 * PERF_GLOBAL_STATUS, i.e. the guest will see overflow status for the
+	 * wrong counter(s).
+	 */
+	if (guest_pebs.enable & pmu->global_ctrl)
+		guest_pebs.enable &= ~intel_pmu_get_cross_mapped_mask(pmu);
 
 	/* Note, nr_msrs may be garbage if perf_guest_get_msrs() returns NULL. */
 	msrs = perf_guest_get_msrs(&nr_msrs, &guest_pebs);
-- 
2.54.0.563.g4f69b47b94-goog

