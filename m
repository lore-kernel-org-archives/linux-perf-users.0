Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3487137FF75
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 04:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053558; cv=none; b=fg/jAMR95f/x+84d5ij6NBA0d9N1YwDffmWUAhO+REW6EWCKkWr14rxJNobhXjfpPvHLg2+4DoStuzLMF+IXHhbshrOJ0o4z3r0LhM/ZHlNU6ygdBX5Ud96UNRQL7X1puWm2rARIU/YnstauH4xf45Jz392elHAGi5BPr80W5Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053558; c=relaxed/simple;
	bh=U21YjZbTLKjhR+W4EfBEee1/yW+4HlS/oTGqe0Nrojw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k7T60A/6kg3Uaz3GrIKZMKHmoFHa/ISpjTO0q0As8HG73lGwJbZdzHMena+WeLkBTjIly8iF51Hph8DfVRU9eZ4tGFXbeJ+7zLv3ZHitAJgqyek7d0+kXSzGLQqS4bnHwyg2XqZBX74LA/M4lpNLbA5WZDbDRnq+Ljcd0mcy044=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r9mxQ560; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r9mxQ560"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2d8a677cdfaso786792eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 21:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776053547; x=1776658347; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CexyOKGLd1wDyUtEXB2mYM32u5jxlu6R2jpDLPNHjCI=;
        b=r9mxQ5608mNJEPgsG/cJnJOihZz8YDHCaGrUVu9ocpVX3R0AQx4hQwRgh/jW4FjtaX
         2wmd+kLryshEY9l6XdPHEULKKYTOVMH4rV2o98ChLDfkRZZJ9cFH+BMJl4m49BgATbSY
         9psMOT0/1trisglGvdUfunGEGmIJgJeFl3zpm9u1AfLQY//2qTvPE4CZWjnowmkO/YE/
         m+cHJYL/6Z9nJhp5iEVSWyAs0BrUNMyePleA4U5BHHTbmkpgnshbwBjQ6c8EtUuXw7vf
         JJZKF//tOpgaSUI7BLgC9XtKe+8A892QZ6n/wViQEDsWKhtWcIJKKdzMKge08aO1DdU3
         37MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776053547; x=1776658347;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CexyOKGLd1wDyUtEXB2mYM32u5jxlu6R2jpDLPNHjCI=;
        b=TIN26HOpT4J8VMBIOXVz8oRzvJyBDZpWqS8b5G3RSxHrktSUAwxxpDx/ERhEYafW1w
         3XuilUQWBkhoIrj7i48NVZpZ/rYcjnTt44Y8A1AQZz03NvI0waTHBj1AcnGZciqg5I47
         He9dWoxY8jjOziYwOk6CAdPnx8KQNKOw4csFTr5ZfE7khtI8Ot6N5bxCvRVrvz5bMlNA
         WtJBWFs4ltKfgFZ57S290Uqamti2Pr9FLWAtE5vZxEUpf82ofW7FmUGV0xLJZgOGQ21r
         XckNrIu8FuEAaoER88chpLdDaQ78PIfPZGConnhhabf1zVw6ZwdR8DzBBdVL6Nbw/R2E
         K5UA==
X-Forwarded-Encrypted: i=1; AFNElJ9iDrwd0mpLO3YWbW4djUCbQLPpobAHMB5xDCU5VsZtU9Yz4TngHEXKuq+YFFTF38d5hylaxbYLOqvNZ8pfXE6v@vger.kernel.org
X-Gm-Message-State: AOJu0YzkbLYAYK1xP8Ui7o3bi7l5wS/F3h5mUEgYXmm2LI+QMis4rzgu
	2DWKPRwROr9EiGTKoobrTnmc0kTcyroOPL2QALrSL9kO9k267UGM3BoNwBjU5Q2irh/aGKAReiv
	IqriUC8hbWg==
X-Received: from dyji40.prod.google.com ([2002:a05:7300:7a28:b0:2d8:dd18:baee])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d704:b0:2b7:fdb6:ccf6
 with SMTP id 5a478bee46e88-2d5890795cfmr6355216eec.14.1776053546399; Sun, 12
 Apr 2026 21:12:26 -0700 (PDT)
Date: Sun, 12 Apr 2026 21:11:23 -0700
In-Reply-To: <20260413041143.1736055-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413012227.1089445-1-irogers@google.com> <20260413041143.1736055-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413041143.1736055-14-irogers@google.com>
Subject: [PATCH v12 13/33] perf inject: Don't pass evsel with sample
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
making mmap2 events. Some minor tweaks to synthetic events to be
robust to evsel being NULL and to remove an unnecessary branch (as the
id sample will be empty) on the evsel.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c        | 52 ++++++++++++++++--------------
 tools/perf/util/synthetic-events.c | 30 ++++++++---------
 tools/perf/util/synthetic-events.h |  2 --
 3 files changed, 40 insertions(+), 44 deletions(-)

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
index 85bee747f4cd..de812a2befbc 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2252,13 +2252,15 @@ int perf_event__synthesize_build_id(const struct perf_tool *tool,
 				    struct perf_sample *sample,
 				    struct machine *machine,
 				    perf_event__handler_t process,
-				    const struct evsel *evsel,
 				    __u16 misc,
 				    const struct build_id *bid,
 				    const char *filename)
 {
 	union perf_event ev;
 	size_t len;
+	u64 sample_type = sample->evsel ? sample->evsel->core.attr.sample_type : 0;
+	void *array = &ev;
+	int ret;
 
 	len = sizeof(ev.build_id) + strlen(filename) + 1;
 	len = PERF_ALIGN(len, sizeof(u64));
@@ -2275,23 +2277,17 @@ int perf_event__synthesize_build_id(const struct perf_tool *tool,
 	ev.build_id.header.size = len;
 	strcpy(ev.build_id.filename, filename);
 
-	if (evsel) {
-		void *array = &ev;
-		int ret;
-
-		array += ev.header.size;
-		ret = perf_event__synthesize_id_sample(array, evsel->core.attr.sample_type, sample);
-		if (ret < 0)
-			return ret;
-
-		if (ret & 7) {
-			pr_err("Bad id sample size %d\n", ret);
-			return -EINVAL;
-		}
+	array += ev.header.size;
+	ret = perf_event__synthesize_id_sample(array, sample_type, sample);
+	if (ret < 0)
+		return ret;
 
-		ev.header.size += ret;
+	if (ret & 7) {
+		pr_err("Bad id sample size %d\n", ret);
+		return -EINVAL;
 	}
 
+	ev.header.size += ret;
 	return process(tool, &ev, sample, machine);
 }
 
@@ -2299,7 +2295,6 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 					  struct perf_sample *sample,
 					  struct machine *machine,
 					  perf_event__handler_t process,
-					  const struct evsel *evsel,
 					  __u16 misc,
 					  __u32 pid, __u32 tid,
 					  __u64 start, __u64 len, __u64 pgoff,
@@ -2309,6 +2304,7 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 {
 	union perf_event ev;
 	size_t ev_len;
+	u64 sample_type = sample->evsel ? sample->evsel->core.attr.sample_type : 0;
 	void *array;
 	int ret;
 
@@ -2339,7 +2335,7 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 
 	array = &ev;
 	array += ev.header.size;
-	ret = perf_event__synthesize_id_sample(array, evsel->core.attr.sample_type, sample);
+	ret = perf_event__synthesize_id_sample(array, sample_type, sample);
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

