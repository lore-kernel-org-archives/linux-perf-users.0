Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584644D9EF
	for <linux-perf-users@vger.kernel.org>; Fri, 10 May 2024 19:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715368492; cv=none; b=n74U3dw4UMxPAMhbM2HCIuvZbnv1nQ+9c4Aiq65/cw2NqDP2oqL/gaaITO1gvKMik+CwNoqQCfl55Pln7kuGJFV2hsCmo6TKVvTwcA6y7ayz5wKWoxsnFnsybwOjfeLIzwJb/jKw5riNmHByqwqi6x/cWO1jhsMLDjzAc1OVtXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715368492; c=relaxed/simple;
	bh=Ef717kLuVBT1fbqK3xWzMcLvVUsMivpXuO9N8M0ap+U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A1zMnjAZ4eigGSM+Pe4yOeyAEH0T+Dv77HPPTt6YU4+DNmQcq+/of2Go/CHJqprlhk/Px4w+o2bauauzIukg0Rf7Lp10DbwimYPwvgsHKBrspl5lrQvuBeHuHqDhA+Epvh5cNfwpk4Dl8uYaKSV8iTTvA5A2LirMSxCtYvMSouA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NXbZzlWE; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NXbZzlWE"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de54ccab44aso4336195276.3
        for <linux-perf-users@vger.kernel.org>; Fri, 10 May 2024 12:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715368490; x=1715973290; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B7TYqXtK1Mk6NWoqrVFRwUxJwKqSCgyVFtFSV6E0LeA=;
        b=NXbZzlWEmSuq5zm4d594QWpJwFOdYp1PQ/9mfoL/3sovgdpfVqG54GWcyapOlk3Wep
         9O+2ngEtdBULUxJDdCkbLaptbyBe5anlw+LYtxXqmdok5d2G67yKOxWKUUiLRrbsRtWW
         a8w3G+XV63sKdwXPtwNrp6g8XmotuIlvwvv2cqVW2u9WFoznGtMlhyxwpii6gBvPwFrO
         VPcIjRO5TGMWmbW+gb4rjsCAZ5Lgsjn0QNf7oNGuHOkvguFv2YyKFwP8xFHc8QDE+Tvs
         V28sO0EVNKiMMlVUweZVbBNO086P6BM7bMkS2NgTpPHAJw0E6nsnOgiAntoZIf7BYyb1
         khWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715368490; x=1715973290;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B7TYqXtK1Mk6NWoqrVFRwUxJwKqSCgyVFtFSV6E0LeA=;
        b=OabEltKAVm1DrWbBIcItIs/lhQ3XEMMq858rFjV1c3VnmxxGokPeC35+3Pz2Z5KAYv
         BSrwrDa10GXZXDiNzAx/zzNT1+RUUU9UMWqt0EEso7qDZZPcx0vyECG9rt04C2GxRjVl
         PhzWDgnRTDTcwsQiN+Vtzc20BS0fcRtsFIW4hB8rXvih0Z/y8bWMzOKhokGr3rLmnMae
         gEGnifHAG2gL3tiJa36mgMZrdELcyPWHZKePzs7bCkYSwQ7a3LIhd+ONNFPSHQuJR+kA
         EkBtQ2FawoDToOkX27m7T7SncX/Yt0L4Cw9FyoDtwcY658YjDKjyhHRFvnA/aL2SRlOe
         MoRw==
X-Gm-Message-State: AOJu0Yz8tRXa0pNkzwkaWLp/mlI0X0HgamfG0B0Sv4JX3W7Ty3G2puaX
	CWH7M+8WTCW2qdMrM1gDlHLreWKXBHQQ6xThw+znXt6R0ax0nryzS9Qo2WokiNJ9kbru1ndDZkO
	q
X-Google-Smtp-Source: AGHT+IFb8jxmN6r68G4DcrXpnFSPXecUXaoio7CsPUw8x8nZIcXrAKCeTWV/1YMYhzP0k+gAt9nnkPiev4A=
X-Received: from yabinc-desktop.mtv.corp.google.com ([2620:15c:211:202:d3a5:c745:caa1:83ed])
 (user=yabinc job=sendgmr) by 2002:a05:6902:1109:b0:dee:5dc9:7e45 with SMTP id
 3f1490d57ef6-dee5dc993ebmr313635276.5.1715368490439; Fri, 10 May 2024
 12:14:50 -0700 (PDT)
Date: Fri, 10 May 2024 12:14:23 -0700
In-Reply-To: <20240510191423.2297538-1-yabinc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510191423.2297538-1-yabinc@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510191423.2297538-4-yabinc@google.com>
Subject: [PATCH v4 3/3] perf/core: Check sample_type in perf_sample_save_brstack
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
 arch/x86/events/amd/core.c |  3 +--
 arch/x86/events/core.c     |  3 +--
 arch/x86/events/intel/ds.c |  3 +--
 include/linux/perf_event.h | 13 ++++++++-----
 4 files changed, 11 insertions(+), 11 deletions(-)

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
index 8617815456b0..ecfbe22ff299 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1269,6 +1269,11 @@ static inline void perf_sample_save_raw_data(struct perf_sample_data *data,
 	data->sample_flags |= PERF_SAMPLE_RAW;
 }
 
+static inline bool has_branch_stack(struct perf_event *event)
+{
+	return event->attr.sample_type & PERF_SAMPLE_BRANCH_STACK;
+}
+
 static inline void perf_sample_save_brstack(struct perf_sample_data *data,
 					    struct perf_event *event,
 					    struct perf_branch_stack *brs,
@@ -1276,6 +1281,9 @@ static inline void perf_sample_save_brstack(struct perf_sample_data *data,
 {
 	int size = sizeof(u64); /* nr */
 
+	if (!has_branch_stack(event))
+		return;
+
 	if (branch_sample_hw_index(event))
 		size += sizeof(u64);
 	size += brs->nr * sizeof(struct perf_branch_entry);
@@ -1665,11 +1673,6 @@ extern void perf_bp_event(struct perf_event *event, void *data);
 # define perf_arch_bpf_user_pt_regs(regs) regs
 #endif
 
-static inline bool has_branch_stack(struct perf_event *event)
-{
-	return event->attr.sample_type & PERF_SAMPLE_BRANCH_STACK;
-}
-
 static inline bool needs_branch_stack(struct perf_event *event)
 {
 	return event->attr.branch_sample_type != 0;
-- 
2.45.0.118.g7fe29c98d7-goog

