Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F1B45034
	for <linux-perf-users@vger.kernel.org>; Fri, 10 May 2024 19:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715368486; cv=none; b=nLiWXLAWwcGyAuU3+RZesm82uo48nyfD5zPemqq9VNp2nF100QPvkhGom2irLYwsVHpBlObPbYXmhj+3pw0qaLJwY7dRs6HPmgci8vMA9OASosWrpmXtzglceqWn68QTsPM+SyCxjYW6Y+54b3RnN8MWdfx2RUfT7CIk3rJd9LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715368486; c=relaxed/simple;
	bh=64XhRpFpi6uGMMX0j1mPwjoS0JMre2Gu6E5i4sgBX8A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gXBMO+lTGTEkepv4co7/zdYOKWZJtKTbyFfQLXmoZyeIUh++4wmamJI2D8ioCT5+ned5I/4rrvFodsLrCPFJPMmUsRbC57qY4K7ZM+1sl/lJqrVb9AsiQmZyFWQeCt+CsICcqexnE1Oi+NWk/z/FcS4AiW0JsIm2JuHP+4UKlp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mSm+5w8b; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mSm+5w8b"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de610854b8bso4012136276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 10 May 2024 12:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715368483; x=1715973283; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ge9EyDimfxMn8rYP5EBPFR6UgBM4kCiqqJN/HMjifYE=;
        b=mSm+5w8b6Ncs0PTyqk+rhjQUDFsGTuEqBQiwXNZGfWltimL917QadzuUgc8MvxGYUM
         lS/GPnX0ipBKAiQYt9wqEdN1ou9uXrLVRe6bObvbrsF+bgslN64ThFa/87+2L4jWq5Lr
         AFF1oYPYlsd1KjtXOTzfmTr6V4MDhkEUWnMjACUWkZuDPdXUCM5EBwK7WylPqKpw5M7I
         tjtb7zC3ZA0FbpEguuj7qUfttwThf5MI7rwO4qCVhhP5IpzPhqTnb9NwkKhcNWSSuFqY
         ayRuO+ZrPV7E4TiKjSnYIxCBW2eScT58KX1CwiFG/eZ/ZgadG+n7nd14RByaoICs1W3m
         dmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715368483; x=1715973283;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ge9EyDimfxMn8rYP5EBPFR6UgBM4kCiqqJN/HMjifYE=;
        b=rowfK5FajO5PIFfcJY0qjt7Yk04t+T1I5h7cjtIM/VklG39WjeCySVa2tQLZRMJQiD
         eDGqj+DlKfSH6PXI9fH6t9zAJS5zDGDsFzyyVHhEODlSfn4Jt/TsjRIy+0YPm9UDxwxv
         fgth0QvmZ4o2VPzI13oLIleGc4IVajYyxzwExnQF5SS1SlrAK6uo3gFBWFWUnNFxa7Pz
         4mTePzrXw8aMGltkVm6D66UGvTvuVMdsfoHr1dsRueyeXyq6qTTxfhrB+6wkGO4rN/tK
         +23eY1mUqRadL7p3ss+LQWuSOPUUSr0K9ebDP2uR8aDZlgSS4dNkWS4u/cFABlluukx9
         0tKQ==
X-Gm-Message-State: AOJu0YzPafd8Ot4pOaKK7YrQRcxX0YZ+hSVwdPLSe4PC8GYoCobzFn9L
	f/ptbjMzh6+R22Di2daKDjY0Crm7l77sdhYyUgPjqxRuAjNwJv7CNebolxscrs2GDgv+M1i0eLr
	y
X-Google-Smtp-Source: AGHT+IGhqbkgJUO7zEwDxia6wziXbaC9+EM84Ka6kxR3xOXAj7HrS61O7xc2aYjb63BaF7UfuWjVfnMHtWg=
X-Received: from yabinc-desktop.mtv.corp.google.com ([2620:15c:211:202:d3a5:c745:caa1:83ed])
 (user=yabinc job=sendgmr) by 2002:a05:6902:20ca:b0:dd9:2d94:cd8a with SMTP id
 3f1490d57ef6-dee4f4f51bamr343199276.9.1715368483517; Fri, 10 May 2024
 12:14:43 -0700 (PDT)
Date: Fri, 10 May 2024 12:14:21 -0700
In-Reply-To: <20240510191423.2297538-1-yabinc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510191423.2297538-1-yabinc@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510191423.2297538-2-yabinc@google.com>
Subject: [PATCH v4 1/3] perf/core: Save raw sample data conditionally based on
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

This patch enforces checking sample type of an event in
perf_sample_save_raw_data(). So raw sample data will only be saved if
explicitly requested, reducing overhead when it is not needed.

Fixes: 0a9081cf0a11 ("perf/core: Add perf_sample_save_raw_data() helper")
Signed-off-by: Yabin Cui <yabinc@google.com>
---
 arch/s390/kernel/perf_cpum_cf.c    |  2 +-
 arch/s390/kernel/perf_pai_crypto.c |  2 +-
 arch/s390/kernel/perf_pai_ext.c    |  2 +-
 arch/x86/events/amd/ibs.c          |  2 +-
 include/linux/perf_event.h         |  4 ++++
 kernel/events/core.c               | 35 +++++++++++++++---------------
 kernel/trace/bpf_trace.c           | 11 +++++-----
 7 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 41ed6e0f0a2a..c7fb99cb1e15 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -971,7 +971,7 @@ static int cfdiag_push_sample(struct perf_event *event,
 	if (event->attr.sample_type & PERF_SAMPLE_RAW) {
 		raw.frag.size = cpuhw->usedss;
 		raw.frag.data = cpuhw->stop;
-		perf_sample_save_raw_data(&data, &raw);
+		perf_sample_save_raw_data(&data, event, &raw);
 	}
 
 	overflow = perf_event_overflow(event, &data, &regs);
diff --git a/arch/s390/kernel/perf_pai_crypto.c b/arch/s390/kernel/perf_pai_crypto.c
index 4ad472d130a3..2fb8aeba4872 100644
--- a/arch/s390/kernel/perf_pai_crypto.c
+++ b/arch/s390/kernel/perf_pai_crypto.c
@@ -444,7 +444,7 @@ static int paicrypt_push_sample(size_t rawsize, struct paicrypt_map *cpump,
 	if (event->attr.sample_type & PERF_SAMPLE_RAW) {
 		raw.frag.size = rawsize;
 		raw.frag.data = cpump->save;
-		perf_sample_save_raw_data(&data, &raw);
+		perf_sample_save_raw_data(&data, event, &raw);
 	}
 
 	overflow = perf_event_overflow(event, &data, &regs);
diff --git a/arch/s390/kernel/perf_pai_ext.c b/arch/s390/kernel/perf_pai_ext.c
index a6da7e0cc7a6..b2914df2107a 100644
--- a/arch/s390/kernel/perf_pai_ext.c
+++ b/arch/s390/kernel/perf_pai_ext.c
@@ -458,7 +458,7 @@ static int paiext_push_sample(size_t rawsize, struct paiext_map *cpump,
 	if (event->attr.sample_type & PERF_SAMPLE_RAW) {
 		raw.frag.size = rawsize;
 		raw.frag.data = cpump->save;
-		perf_sample_save_raw_data(&data, &raw);
+		perf_sample_save_raw_data(&data, event, &raw);
 	}
 
 	overflow = perf_event_overflow(event, &data, &regs);
diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index e91970b01d62..c3a2f6f57770 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1118,7 +1118,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 				.data = ibs_data.data,
 			},
 		};
-		perf_sample_save_raw_data(&data, &raw);
+		perf_sample_save_raw_data(&data, event, &raw);
 	}
 
 	if (perf_ibs == &perf_ibs_op)
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d2a15c0c6f8a..9fc55193ff99 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1240,12 +1240,16 @@ static inline void perf_sample_save_callchain(struct perf_sample_data *data,
 }
 
 static inline void perf_sample_save_raw_data(struct perf_sample_data *data,
+					     struct perf_event *event,
 					     struct perf_raw_record *raw)
 {
 	struct perf_raw_frag *frag = &raw->frag;
 	u32 sum = 0;
 	int size;
 
+	if (!(event->attr.sample_type & PERF_SAMPLE_RAW))
+		return;
+
 	do {
 		sum += frag->size;
 		if (perf_raw_frag_last(frag))
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 724e6d7e128f..3031cade53bb 100644
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
@@ -10180,13 +10181,17 @@ static void __perf_tp_event_target_task(u64 count, void *record,
 	/* Cannot deliver synchronous signal to other task. */
 	if (event->attr.sigtrap)
 		return;
-	if (perf_tp_event_match(event, data, regs))
+	if (perf_tp_event_match(event, raw, regs)) {
+		perf_sample_data_init(data, 0, 0);
+		perf_sample_save_raw_data(data, event, raw);
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
@@ -10194,15 +10199,15 @@ static void perf_tp_event_target_task(u64 count, void *record,
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
 
@@ -10220,15 +10225,10 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
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
@@ -10238,7 +10238,8 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 			 * because data->sample_flags is set.
 			 */
 			perf_sample_data_init(&data, 0, 0);
-			perf_sample_save_raw_data(&data, &raw);
+			perf_sample_save_raw_data(&data, event, &raw);
+			perf_swevent_event(event, count, &data, regs);
 		}
 	}
 
@@ -10255,7 +10256,7 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 			goto unlock;
 
 		raw_spin_lock(&ctx->lock);
-		perf_tp_event_target_task(count, record, regs, &data, ctx);
+		perf_tp_event_target_task(count, record, regs, &data, &raw, ctx);
 		raw_spin_unlock(&ctx->lock);
 unlock:
 		rcu_read_unlock();
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 9dc605f08a23..23bcf28ccc82 100644
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
@@ -645,6 +646,8 @@ __bpf_perf_event_output(struct pt_regs *regs, struct bpf_map *map,
 	if (unlikely(event->oncpu != cpu))
 		return -EOPNOTSUPP;
 
+	perf_sample_save_raw_data(sd, event, raw);
+
 	return perf_event_output(event, sd, regs);
 }
 
@@ -688,9 +691,8 @@ BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, regs, struct bpf_map *, map,
 	}
 
 	perf_sample_data_init(sd, 0, 0);
-	perf_sample_save_raw_data(sd, &raw);
 
-	err = __bpf_perf_event_output(regs, map, flags, sd);
+	err = __bpf_perf_event_output(regs, map, flags, &raw, sd);
 out:
 	this_cpu_dec(bpf_trace_nest_level);
 	preempt_enable();
@@ -749,9 +751,8 @@ u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
 
 	perf_fetch_caller_regs(regs);
 	perf_sample_data_init(sd, 0, 0);
-	perf_sample_save_raw_data(sd, &raw);
 
-	ret = __bpf_perf_event_output(regs, map, flags, sd);
+	ret = __bpf_perf_event_output(regs, map, flags, &raw, sd);
 out:
 	this_cpu_dec(bpf_event_output_nest_level);
 	preempt_enable();
-- 
2.45.0.118.g7fe29c98d7-goog

