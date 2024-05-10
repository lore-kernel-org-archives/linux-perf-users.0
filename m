Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F0A50276
	for <linux-perf-users@vger.kernel.org>; Fri, 10 May 2024 00:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715300694; cv=none; b=rWlMUQH7/tWCqVaQkTA/SZsulZzafmvt4V1fp/JHl6u2B882RjBMEHTae3QqNoznuZqYrkjIOvxjzNMNdnpRwRGDImNNwYyL5kbWHabSgAKB2MlhpPX0gfboVIXbjx5T82rCM7+3ncnNybaYnQia/zd5lZ7ca0Wonk36h81G8sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715300694; c=relaxed/simple;
	bh=cGpULC1B1HXkvRfCSn3TdeH+Xj5EwEpr4DGLnTg+pCQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZgWIgTqzoZJw0buXYC2h8tVjWpcZrdXAUjalbIn+N9du6r2l/ksF77N5PxEqBAzLtNraobQ3L7Rfs2PS/OPDgqo5pmNFlWlXn4geJzOLe8evSOLhIqZBkovI1QIyI1Mhf2z9Son/2HNWjUjjkF6bSACDGsI824uTredgzUIuHKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VO/sDB54; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VO/sDB54"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61c9e368833so26200547b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 09 May 2024 17:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715300692; x=1715905492; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ot0TEs4BvD2J9QyiZT5bC39KllHj7+HFnRVXvIw7CTU=;
        b=VO/sDB54S3qSxJVTmyoabGla9DZoE2c3nPIwrgewoiuNBvaOau+sH0G8BuFGcpEpQO
         T653MqpMHs7sFSBrgomGTU0DJsPyVccE4wG6ZKzLYCFHR8mVnplA2bBZbpNLlrAQl6F7
         Uibqgs0s0vruoPqNx4FKbueKm7DGE9blJO0oXtLBjuBvtSsDmYVzvzYe4fQMF4oYJIGe
         bNXjzJO6t06FyVPXNdoEdjZroYxXm7Cuh2gYIzFIKAeBMmL8ux8oE8FwIPV3CgD5UiV6
         RTqqUDcV/fmgs7JIL7pahZd1vwa+GiMImqsPlNLazX/spy13kMf5TDA8Hc+gk9y3vWVm
         XH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715300692; x=1715905492;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ot0TEs4BvD2J9QyiZT5bC39KllHj7+HFnRVXvIw7CTU=;
        b=JYMtdvj4kaq0yKueKH+0wosHebAxXe1EO146O2L74+Xt1CNgq2R6MsqZcmmrPEJlrd
         WTdTE14IwqWAF6ju1IcMXNt+WUhA1ZmZ0Vx5v+/IJCxJGDwHHed12RTIqaw82lYzWZdN
         IWRVpG+COvgD9OwmCYS8sovX5U1sZ6pIyO8h5bZWDrXg1tfzuXKffGBosDPj1qpMylQt
         Zmbqgoc/guTO1eEepIQT7LGkvDb7sj98FnWRa4WJJM44kCj7fn9uCsQHuO3cxpAFFIRL
         v3cQ/mJN9k/5PUwgAX3q9oMWOPIxWTijrKRAVtHgJhMEx2a+ArHca0lY84lLePPZq9Uu
         WjGA==
X-Gm-Message-State: AOJu0YwKRB9pAc4SjqySgstir9NSNUPP2jq7PUW+yWxelTMLPixGEtzi
	s96qkKny1XnN9d1g/dnRpGbMNI6cfwMrjqg3ylt8NmtI4ORHGV0tsZ26PXasEqZk6bVv3ldt38/
	z
X-Google-Smtp-Source: AGHT+IGtVehGREnSCfDjF50uDOFlHxuUhMLfztYum1ee5p3PcJUXmBGA2TuIoR4t/QC1CWL4ydsyKZkmBx8=
X-Received: from yabinc-desktop.mtv.corp.google.com ([2620:15c:211:202:1b7d:8132:c198:e24f])
 (user=yabinc job=sendgmr) by 2002:a05:690c:b10:b0:61c:89a4:dd5f with SMTP id
 00721157ae682-622afcbec26mr3237517b3.0.1715300692087; Thu, 09 May 2024
 17:24:52 -0700 (PDT)
Date: Thu,  9 May 2024 17:24:24 -0700
In-Reply-To: <20240510002424.1277314-1-yabinc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510002424.1277314-1-yabinc@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510002424.1277314-4-yabinc@google.com>
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

