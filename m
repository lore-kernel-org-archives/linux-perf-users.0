Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCBB35AC01
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303970; cv=none; b=O26liNgndptGkwAdaam721JRIKaKak1afvhE7iAqPu0xnQYcJnzi+9uVpuxb6awuB25ppxfRey6xyJTbPTTw4IcCux8+n81EoZydB/HIoVQHxqOmxAELruVx63Kv+f4BfaKYnwB+lXJEzsdOSwB7P0iDeQo3waNVDnX0Z+h2p6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303970; c=relaxed/simple;
	bh=oOg33SbgKJuKvEntuVwv8gv6pphpXR26ltCjgqlWn2A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eUxD2V2bjZxTP8jp7tZxetaJsLsLtEZJd3ofW3kEB5boV/fAboFGxPZPwrbln7mnckr63I4wza4w7d7gvVJ9XS/nvp9aXqV4OhCEGprBfJ549yd5mkKKHR2h7jgkAtWXDeNntq/0KYu2rEq739vqQuEtVjJF+VuoQz4IYiNqme8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=POA3uqu0; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="POA3uqu0"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-13312be8a31so21199236c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779303967; x=1779908767; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bgdt/fVoQottJnY332POV7kECmfNrUqQRKJaagFMCuw=;
        b=POA3uqu0yxMQfUTaCYGRLF+8qq2KxjST38MZ1P3wjeSQg+TRYuSATuXxiuA7jQMjXD
         Mjr6RO158UgYu8cQjEIZbjAsBi2UAQExWDBfaobxiWZTNyDKSgQu35lW0OirenyW0Bjf
         bY1zsxId0XWcEVHjq5Ca9UbdEl+UWv3fPXQi/Yg7SRp4s4YZAGZdGFiy4EVT4uKBfUJY
         E5q+tXZffZGyLpRBPdIB/7dAdok9AnuE/RlKVDnd880V81T538axPhnKemK7hPCGQkrZ
         zOVH+Gf3Dwd/sYgdt1VQjP86J89n7J2nZW7AzLJ65oAmd9XqTT5LsI9VTds0FcF33AVx
         wcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779303967; x=1779908767;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bgdt/fVoQottJnY332POV7kECmfNrUqQRKJaagFMCuw=;
        b=e2RsI/tef02nJc+k5rMYbItTickhFxRC1Oc4ogY0F8RTjdGdqtEuhXXKlbbqLQdLys
         NI+wAGYb7jWeEmAF7oAffliOPb6IkrAQICmSRXdohZmbeLvcOnc6D35KfH0hHU1BSecF
         OyiM7Hl8rwcrCSmxQ5i8s6U2zGmXcNZeewpPF1ScdnlaKZHH1Ik7vgPie9KufXWwIeG4
         CAXnyYSrQEM2O4rXuIWJRWjWTKUCP2aAbmMNUT2amguOiylHGpMor4CqndTa3xiX87yK
         AWgS0ZIUv06K9ucILH5ntyse00yhWV/xAhbvhuJvkkLpaF7q0GcVf0Fk/LVupMgokvFo
         dxyg==
X-Forwarded-Encrypted: i=1; AFNElJ+fu/uxWaOtiAHAEI3QVlvDpvRDTihcOP2EM/cPMPnKwRJPAQxQ2uzVcxvd7se/Md1AA0ynwxJMsCHLymH7xyvS@vger.kernel.org
X-Gm-Message-State: AOJu0YwqqD2R6Ihn8oz7ubfWpi+bLemqNJVa2OES/ILbwktOmtKb7FZ6
	unQR6LC6lRILnHSp86jVszZTL/UjbRVSXyPTUF906SRUIprwkVHZ92s6zjxpcfCVbTuWUKF0bGJ
	SlbzEJcK3Mg==
X-Received: from dlbrn10.prod.google.com ([2002:a05:7022:150a:b0:135:bc52:ad87])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2397:b0:135:43d3:284c
 with SMTP id a92af1059eb24-13543d329f4mr8884868c88.9.1779303967218; Wed, 20
 May 2026 12:06:07 -0700 (PDT)
Date: Wed, 20 May 2026 12:05:18 -0700
In-Reply-To: <20260520190538.142018-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512223001.2952848-1-irogers@google.com> <20260520190538.142018-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260520190538.142018-13-irogers@google.com>
Subject: [PATCH v14 12/32] perf inject: Don't pass evsel with sample
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
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

As struct perf_sample now directly contains its own resolved evsel pointer,
passing the evsel separately is redundant and clutters the interface.

Remove the redundant evsel parameter from inject-specific handlers and
structures, ensuring the tool always directly accesses the evsel bound to the
sample. This simplifies the API signatures and eliminates the risk of passing
an inconsistent evsel.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-inject.c        | 52 ++++++++++++++++--------------
 tools/perf/util/synthetic-events.c | 30 ++++++++---------
 tools/perf/util/synthetic-events.h |  2 --
 3 files changed, 40 insertions(+), 44 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 3d48c8140ad9..f0d7b4888598 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -147,14 +147,12 @@ struct event_entry {
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
@@ -585,11 +582,12 @@ static int perf_event__repipe_common_mmap(const struct perf_tool *tool,
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
@@ -616,23 +614,26 @@ static int perf_event__repipe_common_mmap(const struct perf_tool *tool,
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
@@ -837,7 +838,6 @@ static bool perf_inject__lookup_known_build_id(struct perf_inject *inject,
 static int tool__inject_build_id(const struct perf_tool *tool,
 				 struct perf_sample *sample,
 				 struct machine *machine,
-				 const struct evsel *evsel,
 				 __u16 misc,
 				 const char *filename,
 				 struct dso *dso, u32 flags)
@@ -861,7 +861,7 @@ static int tool__inject_build_id(const struct perf_tool *tool,
 
 	err = perf_event__synthesize_build_id(tool, sample, machine,
 					      perf_event__repipe,
-					      evsel, misc, dso__bid(dso),
+					      misc, dso__bid(dso),
 					      filename);
 	if (err) {
 		pr_err("Can't synthesize build_id event for %s\n", filename);
@@ -874,7 +874,6 @@ static int tool__inject_build_id(const struct perf_tool *tool,
 static int tool__inject_mmap2_build_id(const struct perf_tool *tool,
 				       struct perf_sample *sample,
 				       struct machine *machine,
-				       const struct evsel *evsel,
 				       __u16 misc,
 				       __u32 pid, __u32 tid,
 				       __u64 start, __u64 len, __u64 pgoff,
@@ -897,7 +896,6 @@ static int tool__inject_mmap2_build_id(const struct perf_tool *tool,
 
 	err = perf_event__synthesize_mmap2_build_id(tool, sample, machine,
 						    perf_event__repipe,
-						    evsel,
 						    misc, pid, tid,
 						    start, len, pgoff,
 						    dso__bid(dso),
@@ -914,7 +912,7 @@ static int mark_dso_hit(const struct perf_inject *inject,
 			const struct perf_tool *tool,
 			struct perf_sample *sample,
 			struct machine *machine,
-			const struct evsel *mmap_evsel,
+			struct evsel *mmap_evsel,
 			struct map *map, bool sample_in_dso)
 {
 	struct dso *dso;
@@ -942,9 +940,13 @@ static int mark_dso_hit(const struct perf_inject *inject,
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
@@ -952,11 +954,13 @@ static int mark_dso_hit(const struct perf_inject *inject,
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
@@ -966,6 +970,7 @@ static int mark_dso_hit(const struct perf_inject *inject,
 								map__prot(map),
 								map__flags(map),
 								filename);
+			sample->evsel = saved_evsel;
 		}
 	}
 	return 0;
@@ -976,7 +981,7 @@ struct mark_dso_hit_args {
 	const struct perf_tool *tool;
 	struct perf_sample *sample;
 	struct machine *machine;
-	const struct evsel *mmap_evsel;
+	struct evsel *mmap_evsel;
 };
 
 static int mark_dso_hit_callback(struct callchain_cursor_node *node, void *data)
@@ -1031,7 +1036,6 @@ static int perf_event__inject_buildid(const struct perf_tool *tool, union perf_e
 static int perf_inject__sched_process_exit(const struct perf_tool *tool,
 					   union perf_event *event __maybe_unused,
 					   struct perf_sample *sample,
-					   struct evsel *evsel __maybe_unused,
 					   struct machine *machine __maybe_unused)
 {
 	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
@@ -1051,13 +1055,12 @@ static int perf_inject__sched_process_exit(const struct perf_tool *tool,
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
@@ -1076,13 +1079,13 @@ static int perf_inject__sched_switch(const struct perf_tool *tool,
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
 
@@ -1447,7 +1450,7 @@ static int synthesize_build_id(struct perf_inject *inject, struct dso *dso, pid_
 	dso__set_hit(dso);
 
 	return perf_event__synthesize_build_id(&inject->tool, &synth_sample, machine,
-					       process_build_id, inject__mmap_evsel(inject),
+					       process_build_id,
 					       /*misc=*/synth_sample.cpumode,
 					       dso__bid(dso), dso__long_name(dso));
 }
@@ -2009,7 +2012,6 @@ static int evsel__check_stype(struct evsel *evsel, u64 sample_type, const char *
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
2.54.0.746.g67dd491aae-goog

