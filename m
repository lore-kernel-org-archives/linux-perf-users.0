Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B985632
	for <linux-perf-users@vger.kernel.org>; Thu,  2 May 2024 00:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714608369; cv=none; b=MI/I9OQIic0S7LMSip9uH/MNrPEmhGdUhij//WaBejoal2T6ciz+JcDMwkq+UceYM+XzMTYyLvj8Xyof3jS2L2VlJFqTkcHgivdQTJjgrBsyDSH0ryP8PsOE3Gv2aT9RlcRMXn99ItozkhSa87T4bPMoO6/gI3/eq3FLoKxNKFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714608369; c=relaxed/simple;
	bh=ydHrqPxoGeEttPy9dZN+F3NvpxP2IRhfrRzA30wOWp4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=M2RWgKmdQLlkU7V7I4fsDlVqnj2GSg3qWly3U/+bIP6FRSYhRW9acacQl54Q0HFL5Z4pYcATDO2+EjaDbG8guxRTnmXVm4Dy71EL8fApAvlbQYwJ1dWQjwaCRg6tsNg7dEDFmdEdt1PU9JB1zuwcTX1/4F6hK50zX5dwTLgL3uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2BhoMKOl; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2BhoMKOl"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be4b79115so63934347b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 01 May 2024 17:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714608365; x=1715213165; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eQRSP9X13w24BKs2qzwk/bhbNErXynjf0Rfm5l0EiQA=;
        b=2BhoMKOlvY3p9M6TME3JwxugtGNr6trMq4TgKLQv+e1DkPSfMV9vBk3E7u/ByfgcxU
         bLL1X+7fnF9V8273P7PNKplWPufgxEX3xJC3NRSJTqRq+juNJ9HNtKJxKpPcOvuQZFhY
         UpzKaE1YB7tRAf6AxJpNuQWiC3dHSrPdaBR5jilUEcUPa4JS6RvKP4XtAUx0W4jmJvM2
         0zaF8O88aLxB+feiyVUgnyfmUPklWkIq1sUZoXVqxDHTw/Ev2sdD2iykTCBCEevpHnI4
         I4W+61R+H8cWqxQeX4sNQk2sb3tal/BuO+hiKmNCJAnePXqNFdEF9a8FanRVDPBT5n6Q
         D1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714608365; x=1715213165;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eQRSP9X13w24BKs2qzwk/bhbNErXynjf0Rfm5l0EiQA=;
        b=GbW9WlrQ69odNKyPiGt88gcBg0rkMKPRzhMmtPG/AVPJAjnhQEX35hnuGaAUmup9Za
         tZGykpZcemNwcFSeeKwhZHsx8UbeLJQVtrOA+B9Q9V4WJYcQuwPPhy84e/Z2UrnSkpL5
         FAPWWETr7zWD6faTIxl2ZyIAaQTOqjdh5zjMcpbND+qviVdZ30xw+CDkt5pVnYMWHDHS
         oeZjkEiOFHBc5NrRZ/GbmwiM5033s0Ac1gQkYIbOZBIHCRKHv8sVjCXnkXM195SAGvFU
         x/Zbr9foco+pRiuXas/UT1+lmxRrLP/+0kxUj2ZRzJSWRvxvGInMX3Foke9Xq57vKIsE
         b++w==
X-Gm-Message-State: AOJu0Ywp3WJZcu8bcfbuspcG110zCtTnsMLx2wjZxkAiJlFczR4LlULL
	wIb4Vb0Vg7TeZ6IKHCGqZFZNDCJUtlRytkz6f5S6+2/TyqndD0bxqjfisN22I9ewyihCYYk9cSh
	b
X-Google-Smtp-Source: AGHT+IHP8OVULzYdZ/+rNjnenXdxVIu1A6L0kGwRCEVIBzk82Mkash/Yy6qJdq3lu7WrFTxM4xr0U9dwA+c=
X-Received: from yabinc-desktop.mtv.corp.google.com ([2620:15c:211:202:a80f:b677:9355:6ccc])
 (user=yabinc job=sendgmr) by 2002:a05:6902:708:b0:dd9:1702:4837 with SMTP id
 k8-20020a056902070800b00dd917024837mr1190112ybt.3.1714608365414; Wed, 01 May
 2024 17:06:05 -0700 (PDT)
Date: Wed,  1 May 2024 17:06:02 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240502000602.753861-1-yabinc@google.com>
Subject: [PATCH v2] perf/core: Save raw sample data conditionally based on
 sample type
From: Yabin Cui <yabinc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, space for raw sample data is always allocated within sample
records for both BPF output and tracepoint events. This leads to unused
space in sample records when raw sample data is not requested.

This patch checks sample type of an event before saving raw sample data
in both BPF output and tracepoint event handling logic. Raw sample data
will only be saved if explicitly requested, reducing overhead when it
is not needed.

Fixes: 0a9081cf0a11 ("perf/core: Add perf_sample_save_raw_data() helper")
Signed-off-by: Yabin Cui <yabinc@google.com>
---

Changes since v1:
 - Check event->attr.sample_type & PERF_SAMPLE_RAW before
   calling perf_sample_save_raw_data().
 - Subject has been changed to reflect the change of solution.

Original commit message from v1:
perf/core: Trim dyn_size if raw data is absent

 kernel/events/core.c     | 37 ++++++++++++++++++++-----------------
 kernel/trace/bpf_trace.c | 12 +++++++-----
 2 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 724e6d7e128f..dc5f3147feef 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10120,9 +10120,9 @@ static struct pmu perf_tracepoint = {
 };
 
 static int perf_tp_filter_match(struct perf_event *event,
-				struct perf_sample_data *data)
+				struct perf_raw_record *raw)
 {
-	void *record = data->raw->frag.data;
+	void *record = raw->frag.data;
 
 	/* only top level events have filters set */
 	if (event->parent)
@@ -10134,7 +10134,7 @@ static int perf_tp_filter_match(struct perf_event *event,
 }
 
 static int perf_tp_event_match(struct perf_event *event,
-				struct perf_sample_data *data,
+				struct perf_raw_record *raw,
 				struct pt_regs *regs)
 {
 	if (event->hw.state & PERF_HES_STOPPED)
@@ -10145,7 +10145,7 @@ static int perf_tp_event_match(struct perf_event *event,
 	if (event->attr.exclude_kernel && !user_mode(regs))
 		return 0;
 
-	if (!perf_tp_filter_match(event, data))
+	if (!perf_tp_filter_match(event, raw))
 		return 0;
 
 	return 1;
@@ -10171,6 +10171,7 @@ EXPORT_SYMBOL_GPL(perf_trace_run_bpf_submit);
 static void __perf_tp_event_target_task(u64 count, void *record,
 					struct pt_regs *regs,
 					struct perf_sample_data *data,
+					struct perf_raw_record *raw,
 					struct perf_event *event)
 {
 	struct trace_entry *entry = record;
@@ -10180,13 +10181,18 @@ static void __perf_tp_event_target_task(u64 count, void *record,
 	/* Cannot deliver synchronous signal to other task. */
 	if (event->attr.sigtrap)
 		return;
-	if (perf_tp_event_match(event, data, regs))
+	if (perf_tp_event_match(event, raw, regs)) {
+		perf_sample_data_init(data, 0, 0);
+		if (event->attr.sample_type & PERF_SAMPLE_RAW)
+			perf_sample_save_raw_data(data, raw);
 		perf_swevent_event(event, count, data, regs);
+	}
 }
 
 static void perf_tp_event_target_task(u64 count, void *record,
 				      struct pt_regs *regs,
 				      struct perf_sample_data *data,
+				      struct perf_raw_record *raw,
 				      struct perf_event_context *ctx)
 {
 	unsigned int cpu = smp_processor_id();
@@ -10194,15 +10200,15 @@ static void perf_tp_event_target_task(u64 count, void *record,
 	struct perf_event *event, *sibling;
 
 	perf_event_groups_for_cpu_pmu(event, &ctx->pinned_groups, cpu, pmu) {
-		__perf_tp_event_target_task(count, record, regs, data, event);
+		__perf_tp_event_target_task(count, record, regs, data, raw, event);
 		for_each_sibling_event(sibling, event)
-			__perf_tp_event_target_task(count, record, regs, data, sibling);
+			__perf_tp_event_target_task(count, record, regs, data, raw, sibling);
 	}
 
 	perf_event_groups_for_cpu_pmu(event, &ctx->flexible_groups, cpu, pmu) {
-		__perf_tp_event_target_task(count, record, regs, data, event);
+		__perf_tp_event_target_task(count, record, regs, data, raw, event);
 		for_each_sibling_event(sibling, event)
-			__perf_tp_event_target_task(count, record, regs, data, sibling);
+			__perf_tp_event_target_task(count, record, regs, data, raw, sibling);
 	}
 }
 
@@ -10220,15 +10226,10 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 		},
 	};
 
-	perf_sample_data_init(&data, 0, 0);
-	perf_sample_save_raw_data(&data, &raw);
-
 	perf_trace_buf_update(record, event_type);
 
 	hlist_for_each_entry_rcu(event, head, hlist_entry) {
-		if (perf_tp_event_match(event, &data, regs)) {
-			perf_swevent_event(event, count, &data, regs);
-
+		if (perf_tp_event_match(event, &raw, regs)) {
 			/*
 			 * Here use the same on-stack perf_sample_data,
 			 * some members in data are event-specific and
@@ -10238,7 +10239,9 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 			 * because data->sample_flags is set.
 			 */
 			perf_sample_data_init(&data, 0, 0);
-			perf_sample_save_raw_data(&data, &raw);
+			if (event->attr.sample_type & PERF_SAMPLE_RAW)
+				perf_sample_save_raw_data(&data, &raw);
+			perf_swevent_event(event, count, &data, regs);
 		}
 	}
 
@@ -10255,7 +10258,7 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 			goto unlock;
 
 		raw_spin_lock(&ctx->lock);
-		perf_tp_event_target_task(count, record, regs, &data, ctx);
+		perf_tp_event_target_task(count, record, regs, &data, &raw, ctx);
 		raw_spin_unlock(&ctx->lock);
 unlock:
 		rcu_read_unlock();
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 9dc605f08a23..4b3ff71b4c0a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -620,7 +620,8 @@ static const struct bpf_func_proto bpf_perf_event_read_value_proto = {
 
 static __always_inline u64
 __bpf_perf_event_output(struct pt_regs *regs, struct bpf_map *map,
-			u64 flags, struct perf_sample_data *sd)
+			u64 flags, struct perf_raw_record *raw,
+			struct perf_sample_data *sd)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	unsigned int cpu = smp_processor_id();
@@ -645,6 +646,9 @@ __bpf_perf_event_output(struct pt_regs *regs, struct bpf_map *map,
 	if (unlikely(event->oncpu != cpu))
 		return -EOPNOTSUPP;
 
+	if (event->attr.sample_type & PERF_SAMPLE_RAW)
+		perf_sample_save_raw_data(sd, raw);
+
 	return perf_event_output(event, sd, regs);
 }
 
@@ -688,9 +692,8 @@ BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, regs, struct bpf_map *, map,
 	}
 
 	perf_sample_data_init(sd, 0, 0);
-	perf_sample_save_raw_data(sd, &raw);
 
-	err = __bpf_perf_event_output(regs, map, flags, sd);
+	err = __bpf_perf_event_output(regs, map, flags, &raw, sd);
 out:
 	this_cpu_dec(bpf_trace_nest_level);
 	preempt_enable();
@@ -749,9 +752,8 @@ u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
 
 	perf_fetch_caller_regs(regs);
 	perf_sample_data_init(sd, 0, 0);
-	perf_sample_save_raw_data(sd, &raw);
 
-	ret = __bpf_perf_event_output(regs, map, flags, sd);
+	ret = __bpf_perf_event_output(regs, map, flags, &raw, sd);
 out:
 	this_cpu_dec(bpf_event_output_nest_level);
 	preempt_enable();
-- 
2.45.0.rc0.197.gbae5840b3b-goog

