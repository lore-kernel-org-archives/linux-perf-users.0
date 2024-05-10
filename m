Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ACDFC0E
	for <linux-perf-users@vger.kernel.org>; Fri, 10 May 2024 00:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299525; cv=none; b=NkgfGAJYb6vLfzKmagKgqF+gBrBBTBmemblOhTVy++1JJjyCzdbtbU65y3SC9xfFlDww8U4lgJyZpm++wsdXC4IWVNad4gU1rnoylEYMXkx1wIeqa3wdoz+GW2T+1O7rP7PWGn8rjKzx2KOHwd4gPxFfwxNj1pNuFuCd1DLMT34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299525; c=relaxed/simple;
	bh=cGpULC1B1HXkvRfCSn3TdeH+Xj5EwEpr4DGLnTg+pCQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TGeg8i5G+TbkNBFDOPnZ9DhVM2XiZWB99ZZNa18zRUMsIQdE41aSrbRqJE/cQvO4g2DIi4LudMbrFBVsxcdVR3gGDLSCauXxIlDr+heC0f3XOEEz+zcK3iLH0sHCXWw1PN5Y5rZRauDhp8RKIb4Q5vns7H4JBx12uEzsvhZooBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1GtDOigs; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1GtDOigs"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be325413eso18555307b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 May 2024 17:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299523; x=1715904323; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ot0TEs4BvD2J9QyiZT5bC39KllHj7+HFnRVXvIw7CTU=;
        b=1GtDOigsg5jSoXkWIBd0iOs/bvORgsA0dp9i8Pw9v6bPM3zeqJH0w94Q+/XodM3CT7
         q4SX4sjCybMXUdaTjgNlRUFYBfpyDFNxHgKjaMpNFpU6UcWIj0Pm1wFbfeYtZA7cJpMH
         jVuuTT6ZR5oSNuiDtBa98fqHK7zS2XPtiGlE70CPViVECq+MXsUrzx9aoFSD8ZW27y/z
         EM4dSqKAyBbHM3wgnnMp3s13c5nRD0y3bBkzLaVm31jAfA4DDndWfP0rs08CNbAreTuh
         EHL2HYRErZJB0+ZSLmJeBGAXXnwuZEyZAL97yB3hQoNG5Dsm9HEtUtcMxCIAUh6ZN7P3
         7W8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299523; x=1715904323;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ot0TEs4BvD2J9QyiZT5bC39KllHj7+HFnRVXvIw7CTU=;
        b=dJJXdORAekxLAApHJTSiSYY276xkpbJpbNJewR4Py11XZvyOBagJ8/inQw/BmWtOri
         OCjHUF9Z3vgYMRyn2yqd5p7VernpJQY/oyEUrCB76m3wlqJvyfOjll9zXoXEitbHNey2
         uP15o1EnHSvvnD89xkjnRfFNayHBfbjv2lrFS6T4j2kk1vxg02hYouDDmFhaXjx46QIv
         KtfIYdlO+wLwMdx6rSKAbvxTOhGNTe1/Zarf0gC9ENU5FCKazHkjAHyDmyWSFQZglNsV
         7+yecCoss5COblI1vzGv2E6PRK1hNxAViqg3RgA/nzl2K2v9ukHrNclQxeMkP6HLnmAS
         TVaA==
X-Gm-Message-State: AOJu0YwNMlDUgHsokj84VQQ1Uo1ajr1sPMGV7JEX/ZvqDbP7Qyw9GJtn
	exJNbadAs7sNoi5f+gpQNwF0IeKX/XrSJmKUfsXfDqoCS5SC79t/jCS4CypxUHfS+d4i9L/5eh4
	R
X-Google-Smtp-Source: AGHT+IEzy2h7K/VLaBZePrcCIRcOhw+P3u9Sa/loYEqzI4OLeWzMuuO/Li8UARzyxANE6fra/VW9xs+tfLs=
X-Received: from yabinc-desktop.mtv.corp.google.com ([2620:15c:211:202:1b7d:8132:c198:e24f])
 (user=yabinc job=sendgmr) by 2002:a05:690c:6904:b0:611:6f24:62b1 with SMTP id
 00721157ae682-622af7a98aamr3561297b3.1.1715299522736; Thu, 09 May 2024
 17:05:22 -0700 (PDT)
Date: Thu,  9 May 2024 17:05:02 -0700
In-Reply-To: <20240510000502.1257463-1-yabinc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000502.1257463-1-yabinc@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000502.1257463-4-yabinc@google.com>
Subject: [PATCH v3 3/3] perf: core: Check sample_type in perf_sample_save_brstack
From: Yabin Cui <yabinc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"

Check sample_type in perf_sample_save_brstack() to prevent
saving branch stack data when it isn't required.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Yabin Cui <yabinc@google.com>
---
 arch/x86/events/amd/core.c | 3 +--
 arch/x86/events/core.c     | 3 +--
 arch/x86/events/intel/ds.c | 3 +--
 include/linux/perf_event.h | 3 +++
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 985ef3b47919..fb9bf3aa1b42 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -967,8 +967,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 		if (!x86_perf_event_set_period(event))
 			continue;
 
-		if (has_branch_stack(event))
-			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
+		perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 5b0dd07b1ef1..ff5577315938 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1702,8 +1702,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 
 		perf_sample_data_init(&data, 0, event->hw.last_period);
 
-		if (has_branch_stack(event))
-			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
+		perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index c2b5585aa6d1..f25236ffa28f 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1754,8 +1754,7 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 	if (x86_pmu.intel_cap.pebs_format >= 3)
 		setup_pebs_time(event, data, pebs->tsc);
 
-	if (has_branch_stack(event))
-		perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
+	perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
 }
 
 static void adaptive_pebs_save_regs(struct pt_regs *regs,
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 8617815456b0..8cff96782446 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1276,6 +1276,9 @@ static inline void perf_sample_save_brstack(struct perf_sample_data *data,
 {
 	int size = sizeof(u64); /* nr */
 
+	if (!has_branch_stack(event))
+		return;
+
 	if (branch_sample_hw_index(event))
 		size += sizeof(u64);
 	size += brs->nr * sizeof(struct perf_branch_entry);
-- 
2.45.0.118.g7fe29c98d7-goog

