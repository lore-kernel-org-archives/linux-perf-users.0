Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E2633DED9
	for <linux-perf-users@vger.kernel.org>; Sat,  4 Apr 2026 03:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775274256; cv=none; b=bIANObqm+Ao73eMlMMOIlveiMNvWPB8LiEwJXcNhzSy0fG3tOJnchH/hnZCfnlQUD98UqFuyQ7IlB1Fsrh7V917kX+XKuPNMN3UGS42F9bjyHF55x4sVHYRLjsJbNasErNhI7aaJF2nxgl1yoObH6zPdAM0AGLuowHqRWHdXoWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775274256; c=relaxed/simple;
	bh=VdNNtvbANMFm8v5XnUjh2ZQyoLZo0SLeNCRO7TwEeyk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EHNMdMFzfOvwupBhxIbYa54KtfdURvYZUFJ6ftGR3/fkiQ5ipGdN3U3PuewOW0PeYXZ3eigmR/po6AoBoCG9TXBqjSKA7xAqHIsoPO3S8eykn9pkBCWrFhkmJVxJdmZJRUhlNO0Eo84O/ueiztcaLp+MNyPD8/0iJA+v0y3w9mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DfVL1o0C; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DfVL1o0C"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12bf9974587so7267293c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 20:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775274254; x=1775879054; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/cz+478EfxkM43OzcAVpLqwywf8zDsZmpT8yQPVEpgc=;
        b=DfVL1o0CYTrZoC2zG9XSr2xWh6yGPl4UjV6N5k9TY8t9NUJmtxFzXVnen9OAtBGFTe
         LkgdS0IEWCDYzhjo9e0aUQVQaW//z9QDUYmRQKrmRiw7DU7kW8TQHiqpPMhLjKxPJqCY
         3nclZP/SO97UNyJSeQhT0iOsdhw50/EB53D5WUQqTXr4gbJhEiYaQ5glr+uE0fh1uu/M
         fFpSiWeeuZRWID6P8qrNKcNYaNVKT4pOSFTrrh2EiuUNcE48dThpU9Bn/6twwplOeXCC
         p61c4IG3I3QSN8fEtbPTQ/oHafZAL9cETaxIGocOnfILCBkXL3ujzFtwgd492T5U4aQa
         HLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775274254; x=1775879054;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/cz+478EfxkM43OzcAVpLqwywf8zDsZmpT8yQPVEpgc=;
        b=JjXhbGLnd4r6DhCuLeeYeJyPYWT6pKw+6JiB7+aO8R7Zeqf3hNeEAh7GeiB15K41l+
         uWIjwlcCjmxWzLf9zFp3uEpAyKrBV5kuB1ENLGGaorI/YDEtA0xzaq8PtSaSvmHXzhrv
         2o6WQRvVTvl5tlEuQzC+PuS1lX4l4v5WSXhFmWEp0U20yQLhWqZC/2ktPmkEWPNkKRRa
         5oR6E09Nly2cUoAbtW/jTecsfFr1ociv4F4y7mCjJt3eMos3j7gQmcwNFAbBlhplkmSn
         XZPDnyAOGxTdSXG4mFRKbF8Pnv9cLAnnYN7EdcAUIfi0Be1jUOpEJ+6DanQrr3ztKLsN
         rjEA==
X-Forwarded-Encrypted: i=1; AJvYcCW2uZNBIwD0vMf5wfr5X3XhuHahqVa4DAkSr66A0jxcMJE0eKPh2HG7pTYAD82oYNDUiMt9DMbLtDMchrQtth0b@vger.kernel.org
X-Gm-Message-State: AOJu0YzPqAzZOng96uFAWtbotrUbxFwsYBNP37FteWXMTl7nk1IdoPh+
	M5uOZpLwNihUQhy18xwBrSuK3WT65Zwc3yzVmlIekw5TWGaJmr1InORAAV0HVMw6W5DluTUiWXi
	ze+Hvj+/hCg==
X-Received: from dlbtp9.prod.google.com ([2002:a05:7022:3b89:b0:12a:6d14:dfd9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6713:b0:128:ca6f:adf0
 with SMTP id a92af1059eb24-12bfb74c93fmr2686725c88.17.1775274253421; Fri, 03
 Apr 2026 20:44:13 -0700 (PDT)
Date: Fri,  3 Apr 2026 20:43:16 -0700
In-Reply-To: <20260404034325.3172592-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403204017.2919994-1-irogers@google.com> <20260404034325.3172592-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260404034325.3172592-17-irogers@google.com>
Subject: [PATCH v6 16/25] perf inject: Don't pass evsel with sample
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

The sample contains the evsel and so it is unnecessary to pass the
evsel as well. Clean up handling of sample and mmap_evsel when
synthesizing build id events and mmap2 events with build ids. For
callchain walking and things that expect the evsel to match sample,
the sample->evsel shouldn't change. The mmap_evsel should be used when
making mmap2 events.

Add space for sample identifiers in
perf_event__synthesize_mmap2_build_id to avoid Sashiko caught
potential buffer overrun. Also add a NULL check to avoid an unlikely
SEGV.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c        | 52 ++++++++++++++-------------
 tools/perf/util/synthetic-events.c | 57 ++++++++++++++++++++++--------
 tools/perf/util/synthetic-events.h |  2 --
 3 files changed, 70 insertions(+), 41 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index ebcbe7a7202c..1989feedd6ff 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -146,14 +146,12 @@ struct event_entry {
 static int tool__inject_build_id(const struct perf_tool *tool,
 				 struct perf_sample *sample,
 				 struct machine *machine,
-				 const struct evsel *evsel,
 				 __u16 misc,
 				 const char *filename,
 				 struct dso *dso, u32 flags);
 static int tool__inject_mmap2_build_id(const struct perf_tool *tool,
 				      struct perf_sample *sample,
 				      struct machine *machine,
-				      const struct evsel *evsel,
 				      __u16 misc,
 				      __u32 pid, __u32 tid,
 				      __u64 start, __u64 len, __u64 pgoff,
@@ -357,7 +355,6 @@ perf_inject__cut_auxtrace_sample(struct perf_inject *inject,
 typedef int (*inject_handler)(const struct perf_tool *tool,
 			      union perf_event *event,
 			      struct perf_sample *sample,
-			      struct evsel *evsel,
 			      struct machine *machine);
 
 static int perf_event__repipe_sample(const struct perf_tool *tool,
@@ -370,7 +367,7 @@ static int perf_event__repipe_sample(const struct perf_tool *tool,
 
 	if (evsel && evsel->handler) {
 		inject_handler f = evsel->handler;
-		return f(tool, event, sample, evsel, machine);
+		return f(tool, event, sample, machine);
 	}
 
 	build_id__mark_dso_hit(tool, event, sample, machine);
@@ -584,11 +581,12 @@ static int perf_event__repipe_common_mmap(const struct perf_tool *tool,
 		}
 
 		if (dso && !dso__hit(dso)) {
-			struct evsel *evsel = evlist__event2evsel(inject->session->evlist, event);
+			if (!sample->evsel)
+				sample->evsel = evlist__event2evsel(inject->session->evlist, event);
 
-			if (evsel) {
+			if (sample->evsel) {
 				dso__set_hit(dso);
-				tool__inject_build_id(tool, sample, machine, evsel,
+				tool__inject_build_id(tool, sample, machine,
 						      /*misc=*/sample->cpumode,
 						      filename, dso, flags);
 			}
@@ -615,23 +613,26 @@ static int perf_event__repipe_common_mmap(const struct perf_tool *tool,
 	}
 	if ((inject->build_id_style == BID_RWS__MMAP2_BUILDID_ALL) &&
 	    !(event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)) {
-		struct evsel *evsel = evlist__event2evsel(inject->session->evlist, event);
+		struct evsel *saved_evsel = sample->evsel;
 
-		if (evsel && !dso_sought) {
+		sample->evsel = evlist__event2evsel(inject->session->evlist, event);
+		if (sample->evsel && !dso_sought) {
 			dso = findnew_dso(pid, tid, filename, dso_id, machine);
 			dso_sought = true;
 		}
-		if (evsel && dso &&
-		    !tool__inject_mmap2_build_id(tool, sample, machine, evsel,
+		if (sample->evsel && dso &&
+		    !tool__inject_mmap2_build_id(tool, sample, machine,
 						 sample->cpumode | PERF_RECORD_MISC_MMAP_BUILD_ID,
 						 pid, tid, start, len, pgoff,
 						 dso,
 						 prot, flags,
 						 filename)) {
 			/* Injected mmap2 so no need to repipe. */
+			sample->evsel = saved_evsel;
 			dso__put(dso);
 			return 0;
 		}
+		sample->evsel = saved_evsel;
 	}
 	dso__put(dso);
 	if (inject->build_id_style == BID_RWS__MMAP2_BUILDID_LAZY)
@@ -836,7 +837,6 @@ static bool perf_inject__lookup_known_build_id(struct perf_inject *inject,
 static int tool__inject_build_id(const struct perf_tool *tool,
 				 struct perf_sample *sample,
 				 struct machine *machine,
-				 const struct evsel *evsel,
 				 __u16 misc,
 				 const char *filename,
 				 struct dso *dso, u32 flags)
@@ -860,7 +860,7 @@ static int tool__inject_build_id(const struct perf_tool *tool,
 
 	err = perf_event__synthesize_build_id(tool, sample, machine,
 					      perf_event__repipe,
-					      evsel, misc, dso__bid(dso),
+					      misc, dso__bid(dso),
 					      filename);
 	if (err) {
 		pr_err("Can't synthesize build_id event for %s\n", filename);
@@ -873,7 +873,6 @@ static int tool__inject_build_id(const struct perf_tool *tool,
 static int tool__inject_mmap2_build_id(const struct perf_tool *tool,
 				       struct perf_sample *sample,
 				       struct machine *machine,
-				       const struct evsel *evsel,
 				       __u16 misc,
 				       __u32 pid, __u32 tid,
 				       __u64 start, __u64 len, __u64 pgoff,
@@ -896,7 +895,6 @@ static int tool__inject_mmap2_build_id(const struct perf_tool *tool,
 
 	err = perf_event__synthesize_mmap2_build_id(tool, sample, machine,
 						    perf_event__repipe,
-						    evsel,
 						    misc, pid, tid,
 						    start, len, pgoff,
 						    dso__bid(dso),
@@ -913,7 +911,7 @@ static int mark_dso_hit(const struct perf_inject *inject,
 			const struct perf_tool *tool,
 			struct perf_sample *sample,
 			struct machine *machine,
-			const struct evsel *mmap_evsel,
+			struct evsel *mmap_evsel,
 			struct map *map, bool sample_in_dso)
 {
 	struct dso *dso;
@@ -941,9 +939,13 @@ static int mark_dso_hit(const struct perf_inject *inject,
 	dso = map__dso(map);
 	if (inject->build_id_style == BID_RWS__INJECT_HEADER_LAZY) {
 		if (dso && !dso__hit(dso)) {
+			/*
+			 * The sample is just read for identifiers which we want
+			 * to match the for the event of the sample.
+			 */
 			dso__set_hit(dso);
 			tool__inject_build_id(tool, sample, machine,
-					     mmap_evsel, misc, dso__long_name(dso), dso,
+					     misc, dso__long_name(dso), dso,
 					     map__flags(map));
 		}
 	} else if (inject->build_id_style == BID_RWS__MMAP2_BUILDID_LAZY) {
@@ -951,11 +953,13 @@ static int mark_dso_hit(const struct perf_inject *inject,
 			const struct build_id null_bid = { .size = 0 };
 			const struct build_id *bid = dso ? dso__bid(dso) : &null_bid;
 			const char *filename = dso ? dso__long_name(dso) : "";
+			struct evsel *saved_evsel = sample->evsel;
 
 			map__set_hit(map);
+			/* Creating a new mmap2 event which has an evsel for the mmap event. */
+			sample->evsel = mmap_evsel;
 			perf_event__synthesize_mmap2_build_id(tool, sample, machine,
 								perf_event__repipe,
-								mmap_evsel,
 								misc,
 								sample->pid, sample->tid,
 								map__start(map),
@@ -965,6 +969,7 @@ static int mark_dso_hit(const struct perf_inject *inject,
 								map__prot(map),
 								map__flags(map),
 								filename);
+			sample->evsel = saved_evsel;
 		}
 	}
 	return 0;
@@ -975,7 +980,7 @@ struct mark_dso_hit_args {
 	const struct perf_tool *tool;
 	struct perf_sample *sample;
 	struct machine *machine;
-	const struct evsel *mmap_evsel;
+	struct evsel *mmap_evsel;
 };
 
 static int mark_dso_hit_callback(struct callchain_cursor_node *node, void *data)
@@ -1030,7 +1035,6 @@ static int perf_event__inject_buildid(const struct perf_tool *tool, union perf_e
 static int perf_inject__sched_process_exit(const struct perf_tool *tool,
 					   union perf_event *event __maybe_unused,
 					   struct perf_sample *sample,
-					   struct evsel *evsel __maybe_unused,
 					   struct machine *machine __maybe_unused)
 {
 	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
@@ -1050,13 +1054,12 @@ static int perf_inject__sched_process_exit(const struct perf_tool *tool,
 static int perf_inject__sched_switch(const struct perf_tool *tool,
 				     union perf_event *event,
 				     struct perf_sample *sample,
-				     struct evsel *evsel,
 				     struct machine *machine)
 {
 	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
 	struct event_entry *ent;
 
-	perf_inject__sched_process_exit(tool, event, sample, evsel, machine);
+	perf_inject__sched_process_exit(tool, event, sample, machine);
 
 	ent = malloc(event->header.size + sizeof(struct event_entry));
 	if (ent == NULL) {
@@ -1075,13 +1078,13 @@ static int perf_inject__sched_switch(const struct perf_tool *tool,
 static int perf_inject__sched_stat(const struct perf_tool *tool,
 				   union perf_event *event __maybe_unused,
 				   struct perf_sample *sample,
-				   struct evsel *evsel,
 				   struct machine *machine)
 {
 	struct event_entry *ent;
 	union perf_event *event_sw;
 	struct perf_sample sample_sw;
 	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
+	struct evsel *evsel = sample->evsel;
 	u32 pid = perf_sample__intval(sample, "pid");
 	int ret;
 
@@ -1446,7 +1449,7 @@ static int synthesize_build_id(struct perf_inject *inject, struct dso *dso, pid_
 	dso__set_hit(dso);
 
 	return perf_event__synthesize_build_id(&inject->tool, &synth_sample, machine,
-					       process_build_id, inject__mmap_evsel(inject),
+					       process_build_id,
 					       /*misc=*/synth_sample.cpumode,
 					       dso__bid(dso), dso__long_name(dso));
 }
@@ -2008,7 +2011,6 @@ static int evsel__check_stype(struct evsel *evsel, u64 sample_type, const char *
 static int drop_sample(const struct perf_tool *tool __maybe_unused,
 		       union perf_event *event __maybe_unused,
 		       struct perf_sample *sample __maybe_unused,
-		       struct evsel *evsel __maybe_unused,
 		       struct machine *machine __maybe_unused)
 {
 	return 0;
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 85bee747f4cd..502b1f847c91 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1802,7 +1802,12 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
 	return 0;
 }
 
-int perf_event__synthesize_id_sample(__u64 *array, u64 type, const struct perf_sample *sample)
+static int __perf_event__synthesize_id_sample(__u64 *array, u64 type,
+					__u32 pid, __u32 tid,
+					__u64 sample_time,
+					__u64 sample_id,
+					__u64 stream_id,
+					__u32 cpu)
 {
 	__u64 *start = array;
 
@@ -1813,42 +1818,52 @@ int perf_event__synthesize_id_sample(__u64 *array, u64 type, const struct perf_s
 	union u64_swap u;
 
 	if (type & PERF_SAMPLE_TID) {
-		u.val32[0] = sample->pid;
-		u.val32[1] = sample->tid;
+		u.val32[0] = pid;
+		u.val32[1] = tid;
 		*array = u.val64;
 		array++;
 	}
 
 	if (type & PERF_SAMPLE_TIME) {
-		*array = sample->time;
+		*array = sample_time;
 		array++;
 	}
 
 	if (type & PERF_SAMPLE_ID) {
-		*array = sample->id;
+		*array = sample_id;
 		array++;
 	}
 
 	if (type & PERF_SAMPLE_STREAM_ID) {
-		*array = sample->stream_id;
+		*array = stream_id;
 		array++;
 	}
 
 	if (type & PERF_SAMPLE_CPU) {
-		u.val32[0] = sample->cpu;
+		u.val32[0] = cpu;
 		u.val32[1] = 0;
 		*array = u.val64;
 		array++;
 	}
 
 	if (type & PERF_SAMPLE_IDENTIFIER) {
-		*array = sample->id;
+		*array = sample_id;
 		array++;
 	}
 
 	return (void *)array - (void *)start;
 }
 
+int perf_event__synthesize_id_sample(__u64 *array, u64 type, const struct perf_sample *sample)
+{
+	return __perf_event__synthesize_id_sample(array, type,
+						sample->pid, sample->tid,
+						sample->time,
+						sample->id,
+						sample->stream_id,
+						sample->cpu);
+}
+
 int __perf_event__synthesize_id_index(const struct perf_tool *tool, perf_event__handler_t process,
 				      struct evlist *evlist, struct machine *machine, size_t from)
 {
@@ -2252,7 +2267,6 @@ int perf_event__synthesize_build_id(const struct perf_tool *tool,
 				    struct perf_sample *sample,
 				    struct machine *machine,
 				    perf_event__handler_t process,
-				    const struct evsel *evsel,
 				    __u16 misc,
 				    const struct build_id *bid,
 				    const char *filename)
@@ -2275,12 +2289,13 @@ int perf_event__synthesize_build_id(const struct perf_tool *tool,
 	ev.build_id.header.size = len;
 	strcpy(ev.build_id.filename, filename);
 
-	if (evsel) {
+	if (sample->evsel) {
 		void *array = &ev;
 		int ret;
 
 		array += ev.header.size;
-		ret = perf_event__synthesize_id_sample(array, evsel->core.attr.sample_type, sample);
+		ret = perf_event__synthesize_id_sample(array, sample->evsel->core.attr.sample_type,
+						       sample);
 		if (ret < 0)
 			return ret;
 
@@ -2299,7 +2314,6 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 					  struct perf_sample *sample,
 					  struct machine *machine,
 					  perf_event__handler_t process,
-					  const struct evsel *evsel,
 					  __u16 misc,
 					  __u32 pid, __u32 tid,
 					  __u64 start, __u64 len, __u64 pgoff,
@@ -2308,13 +2322,23 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 					  const char *filename)
 {
 	union perf_event ev;
+	size_t filename_len = strlen(filename);
 	size_t ev_len;
 	void *array;
 	int ret;
 
-	ev_len = sizeof(ev.mmap2) - sizeof(ev.mmap2.filename) + strlen(filename) + 1;
+	if (!sample->evsel)
+		return -EINVAL; /* Evsel is needed for sample_type data. */
+
+	if (filename_len >= sizeof(ev.mmap2.filename))
+		return -EINVAL;
+
+	ev_len = sizeof(ev.mmap2) - sizeof(ev.mmap2.filename) + filename_len + 1;
 	ev_len = PERF_ALIGN(ev_len, sizeof(u64));
 
+	if (ev_len + MAX_ID_HDR_ENTRIES * sizeof(__u64) > sizeof(ev))
+		return -E2BIG;
+
 	memset(&ev, 0, ev_len);
 
 	ev.mmap2.header.type = PERF_RECORD_MMAP2;
@@ -2339,7 +2363,12 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 
 	array = &ev;
 	array += ev.header.size;
-	ret = perf_event__synthesize_id_sample(array, evsel->core.attr.sample_type, sample);
+	ret = __perf_event__synthesize_id_sample(array, sample->evsel->core.attr.sample_type,
+						pid, tid,
+						sample->time,
+						sample->id,
+						sample->stream_id,
+						sample->cpu);
 	if (ret < 0)
 		return ret;
 
diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
index b0edad0c3100..473a43a78993 100644
--- a/tools/perf/util/synthetic-events.h
+++ b/tools/perf/util/synthetic-events.h
@@ -50,7 +50,6 @@ int perf_event__synthesize_build_id(const struct perf_tool *tool,
 				    struct perf_sample *sample,
 				    struct machine *machine,
 				    perf_event__handler_t process,
-				    const struct evsel *evsel,
 				    __u16 misc,
 				    const struct build_id *bid,
 				    const char *filename);
@@ -58,7 +57,6 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 					  struct perf_sample *sample,
 					  struct machine *machine,
 					  perf_event__handler_t process,
-					  const struct evsel *evsel,
 					  __u16 misc,
 					  __u32 pid, __u32 tid,
 					  __u64 start, __u64 len, __u64 pgoff,
-- 
2.53.0.1213.gd9a14994de-goog

