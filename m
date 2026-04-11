Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A82333730
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 06:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775890678; cv=none; b=FGRcfMgavxvmTh+uUFjm5wdIG7Svi/JCKBUQty44Hvn7yphBMvC8Pb6wW+X5HFvHMsb1PAG6bQ3a06CbL7NJapfdropvXl7ApD+dxHkqlseqhRswBy36y72qyUaDXh4uYuQpgU/UYDkvTbGjFHncAFQbrAUY1Rim505RGmEYaLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775890678; c=relaxed/simple;
	bh=tOjT0V3o9OQUCkpL7biDf21RImcEosUDVOGsrCBJTCQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fHCmuTISWkKBPhCnARnLSlqjTwGeM8VgK8QUY+Q+kS+Dod6CKDALwqa960q89mkF02dzwFPGx22h/e9rnZG/Y8sENtNBSN5TVvysG+XwKMO2aHamRcJtabmZy1CO+PRxNBiwDrSZhFpP1OeQafvA1GWsHnprKEy2mFeDIkiIZ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ksSGDlt3; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ksSGDlt3"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c28353912so1655386c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 23:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775890676; x=1776495476; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=afqz+zMoPVbhRBNCH670DVWCei3xJYDjf+gX2vRpWsE=;
        b=ksSGDlt3G2OR+O+BDfFByHc1EGM0D58SRIZlde0RdkHNpvtDXwCKve+sUG5ZrEOrsf
         XTWLvbHFlT20/lOWtKMW6OeNpU/bUHNuhULzcIvuu6cxvJy9wug9Tvh+OUbUX/pYSYlD
         F4FY5Odw+wYQSb/Q3EjSrRS5EZP7DZlampVIbeVicXAAOf9cwy/JDunvBwPbOR0Nu43+
         hi54A0T3v0JHL07NO6Xl3pLcJ/cQkVu8T1GWFc0Mg49J98HxRQZIOUpA60qwGDRizI15
         Ddtgt9tcbteVjtgVAROyeRWRupmVMmHvtf2Y95BQ+2m7kEON7WHDbmv8oi0wP1a8JRbT
         pNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775890676; x=1776495476;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=afqz+zMoPVbhRBNCH670DVWCei3xJYDjf+gX2vRpWsE=;
        b=JoIqs75WlnRySxN7+Wrd6YFpOWcQbZSqbBb/peZ0GEG8tWroRTT/jswYOJotyXzgKb
         lliMgmQwR9YIFiOuNfYhNl31BbKsVF63wJ0CXhkNgtwiawlZuJu/Gk9gBlGLDvPOhrqM
         52F3HaUjYOdOHtso+mzI6j+HMQ1wU7Rf36kSmc/AWAok7lg0bxFDXyAJEFK0mtsT3FFB
         bYnz5Nccy8Mey++AQjfjeao/aFlD8GsPLLYydSm3zpZ0/Cn9E32oqTkJcGNgIowXPEVK
         FneWQTlM+VP9yUosGvBEXRvEYolzU3on++yvwbCD/cQdP/MMwJeZW9WWWiiR3czLxMZ+
         GYdA==
X-Forwarded-Encrypted: i=1; AJvYcCWaUKZpOZNZ9b/ClQwaikf/0CV3q3enInsE/no9iH/in3qXp6u89CFCbohQ5rQS/nF7WfTJnYY4TAwHTXu5ltgU@vger.kernel.org
X-Gm-Message-State: AOJu0YwwpQialK4pz2Ml8eVcAyg8N4lmRzIZgImhv+Q/XwbBi+cXZ+uY
	cOYAT8PcIeIuMf7ZwkZ3URwis3AAmYe+sz9hzAVAs2NDkGcEk33cbKLK7s4p9WpTJ48guz5065R
	hILzZiF7atw==
X-Received: from dycmx14.prod.google.com ([2002:a05:693c:288e:b0:2d6:f1a6:66f6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6290:b0:12a:6fb7:87e3
 with SMTP id a92af1059eb24-12c34f05b51mr4192516c88.31.1775890675503; Fri, 10
 Apr 2026 23:57:55 -0700 (PDT)
Date: Fri, 10 Apr 2026 23:57:03 -0700
In-Reply-To: <20260411065718.372240-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408072601.210837-1-irogers@google.com> <20260411065718.372240-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411065718.372240-15-irogers@google.com>
Subject: [PATCH v8 14/29] perf inject: Don't pass evsel with sample
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

The sample contains the evsel and so it is unnecessary to pass the
evsel as well. Clean up handling of sample and mmap_evsel when
synthesizing build id events and mmap2 events with build ids. For
callchain walking and things that expect the evsel to match sample,
the sample->evsel shouldn't change. The mmap_evsel should be used when
making mmap2 events.

Bound check the filename length in
perf_event__synthesize_mmap2_build_id to avoid Sashiko caught
potential buffer overrun.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c        | 52 ++++++++++++++-------------
 tools/perf/util/synthetic-events.c | 58 ++++++++++++++++++++++--------
 tools/perf/util/synthetic-events.h |  2 --
 3 files changed, 71 insertions(+), 41 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index f43c165c3a13..593d3ed5ac47 100644
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
@@ -356,7 +354,6 @@ perf_inject__cut_auxtrace_sample(struct perf_inject *inject,
 typedef int (*inject_handler)(const struct perf_tool *tool,
 			      union perf_event *event,
 			      struct perf_sample *sample,
-			      struct evsel *evsel,
 			      struct machine *machine);
 
 static int perf_event__repipe_sample(const struct perf_tool *tool,
@@ -369,7 +366,7 @@ static int perf_event__repipe_sample(const struct perf_tool *tool,
 
 	if (evsel && evsel->handler) {
 		inject_handler f = evsel->handler;
-		return f(tool, event, sample, evsel, machine);
+		return f(tool, event, sample, machine);
 	}
 
 	build_id__mark_dso_hit(tool, event, sample, machine);
@@ -583,11 +580,12 @@ static int perf_event__repipe_common_mmap(const struct perf_tool *tool,
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
@@ -614,23 +612,26 @@ static int perf_event__repipe_common_mmap(const struct perf_tool *tool,
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
@@ -835,7 +836,6 @@ static bool perf_inject__lookup_known_build_id(struct perf_inject *inject,
 static int tool__inject_build_id(const struct perf_tool *tool,
 				 struct perf_sample *sample,
 				 struct machine *machine,
-				 const struct evsel *evsel,
 				 __u16 misc,
 				 const char *filename,
 				 struct dso *dso, u32 flags)
@@ -859,7 +859,7 @@ static int tool__inject_build_id(const struct perf_tool *tool,
 
 	err = perf_event__synthesize_build_id(tool, sample, machine,
 					      perf_event__repipe,
-					      evsel, misc, dso__bid(dso),
+					      misc, dso__bid(dso),
 					      filename);
 	if (err) {
 		pr_err("Can't synthesize build_id event for %s\n", filename);
@@ -872,7 +872,6 @@ static int tool__inject_build_id(const struct perf_tool *tool,
 static int tool__inject_mmap2_build_id(const struct perf_tool *tool,
 				       struct perf_sample *sample,
 				       struct machine *machine,
-				       const struct evsel *evsel,
 				       __u16 misc,
 				       __u32 pid, __u32 tid,
 				       __u64 start, __u64 len, __u64 pgoff,
@@ -895,7 +894,6 @@ static int tool__inject_mmap2_build_id(const struct perf_tool *tool,
 
 	err = perf_event__synthesize_mmap2_build_id(tool, sample, machine,
 						    perf_event__repipe,
-						    evsel,
 						    misc, pid, tid,
 						    start, len, pgoff,
 						    dso__bid(dso),
@@ -912,7 +910,7 @@ static int mark_dso_hit(const struct perf_inject *inject,
 			const struct perf_tool *tool,
 			struct perf_sample *sample,
 			struct machine *machine,
-			const struct evsel *mmap_evsel,
+			struct evsel *mmap_evsel,
 			struct map *map, bool sample_in_dso)
 {
 	struct dso *dso;
@@ -940,9 +938,13 @@ static int mark_dso_hit(const struct perf_inject *inject,
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
@@ -950,11 +952,13 @@ static int mark_dso_hit(const struct perf_inject *inject,
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
@@ -964,6 +968,7 @@ static int mark_dso_hit(const struct perf_inject *inject,
 								map__prot(map),
 								map__flags(map),
 								filename);
+			sample->evsel = saved_evsel;
 		}
 	}
 	return 0;
@@ -974,7 +979,7 @@ struct mark_dso_hit_args {
 	const struct perf_tool *tool;
 	struct perf_sample *sample;
 	struct machine *machine;
-	const struct evsel *mmap_evsel;
+	struct evsel *mmap_evsel;
 };
 
 static int mark_dso_hit_callback(struct callchain_cursor_node *node, void *data)
@@ -1029,7 +1034,6 @@ static int perf_event__inject_buildid(const struct perf_tool *tool, union perf_e
 static int perf_inject__sched_process_exit(const struct perf_tool *tool,
 					   union perf_event *event __maybe_unused,
 					   struct perf_sample *sample,
-					   struct evsel *evsel __maybe_unused,
 					   struct machine *machine __maybe_unused)
 {
 	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
@@ -1049,13 +1053,12 @@ static int perf_inject__sched_process_exit(const struct perf_tool *tool,
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
@@ -1074,13 +1077,13 @@ static int perf_inject__sched_switch(const struct perf_tool *tool,
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
 
@@ -1445,7 +1448,7 @@ static int synthesize_build_id(struct perf_inject *inject, struct dso *dso, pid_
 	dso__set_hit(dso);
 
 	return perf_event__synthesize_build_id(&inject->tool, &synth_sample, machine,
-					       process_build_id, inject__mmap_evsel(inject),
+					       process_build_id,
 					       /*misc=*/synth_sample.cpumode,
 					       dso__bid(dso), dso__long_name(dso));
 }
@@ -2007,7 +2010,6 @@ static int evsel__check_stype(struct evsel *evsel, u64 sample_type, const char *
 static int drop_sample(const struct perf_tool *tool __maybe_unused,
 		       union perf_event *event __maybe_unused,
 		       struct perf_sample *sample __maybe_unused,
-		       struct evsel *evsel __maybe_unused,
 		       struct machine *machine __maybe_unused)
 {
 	return 0;
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 85bee747f4cd..86049b6991d1 100644
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
@@ -2308,13 +2322,24 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 					  const char *filename)
 {
 	union perf_event ev;
+	size_t filename_len = strlen(filename);
 	size_t ev_len;
 	void *array;
 	int ret;
+	u64 sample_type = 0;
 
-	ev_len = sizeof(ev.mmap2) - sizeof(ev.mmap2.filename) + strlen(filename) + 1;
+	if (sample->evsel)
+		sample_type = sample->evsel->core.attr.sample_type;
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
@@ -2339,7 +2364,12 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 
 	array = &ev;
 	array += ev.header.size;
-	ret = perf_event__synthesize_id_sample(array, evsel->core.attr.sample_type, sample);
+	ret = __perf_event__synthesize_id_sample(array, sample_type,
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

