Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365D23D8912
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Apr 2026 20:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775248864; cv=none; b=ewLLx02L8k5XYxBLiaENF+2ELKMNXmu07fSIRuGR1x7XUoMRl7uSINbMZBv1iF9RBbdpYkP9fcGHsMJI43Hu8/KP6wBrFv6FJtTX4aArYvnzIAV2mfCpZOP7YKE0pJYDEQHVjapva+pyM5sdtc8+Tziul3WZJaPEok+lPFAjy50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775248864; c=relaxed/simple;
	bh=TGry0rol2phRV3nf/gGlXMg5O8aSIHeIVmtzCEk+VAw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i5ZTlldo11dS/hTM6d7FBHEKcTwkUejNL7vy92MNL5FIqVzsl0/M2adUbgJJ9vpkoRlrIgsLdh+LMqugsvOJYm+yO7oHvoCUHhdY1qyRELgGJDyYW71nUVZtLoxBF8T4bXZ0tDvi35fdgz/6xo/UVaYJ3fDXyACMoRzf/DbQn8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XfMXiNRR; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XfMXiNRR"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c8ac8e422dso3553405eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 13:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775248861; x=1775853661; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8aSAXkrfY52iMPy7jV0WTr7OXSfW79HOOKSw/IFS7Ow=;
        b=XfMXiNRRVQBws82OaKhOCHxj/wfpUM0XjHgo8AK5Fyh/2HqV+Kx0ul2jF1MdR0gtz6
         SEXgJl0tSS5ftwfVye6HitRdDbyayDVSUNt3XvLBgGM7xbqTDyrW+cWj02u70CpW4rjb
         bweQQlLuuptfenoBt8e9fHBXdWKuvtMZ6ABHI7GaA51eJhzVPzr9A6CS3/XTesP2U+vl
         UiUtgKhE/w66qN1NdYurdGNmH2VqA1ApQC/7b1SNzibVdXDQM5Ah4ywhdJ6OtqbMdxNs
         OGi7Qv7iRP+mby1LHY4VdGSEeXfVgVQPNqvgo8MPrj1v+UhiH6EBijq+txUjcKejdlFo
         8e0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775248861; x=1775853661;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8aSAXkrfY52iMPy7jV0WTr7OXSfW79HOOKSw/IFS7Ow=;
        b=NFFz0uniaLyHFVi9uPJDvwfPcpmiTkaa70t4PDDRUryPzcKrUVHRxaQbef/hpage27
         lKp0mfwxy+TUurLz8nXvrN9DhXTTmzXD/hh5+KzAw6sLF1DWBpeQ0bY8AGMYJMOu5nlU
         lbBXIGYafKFaobXHdDZtEcgcN+tvMn5apFMRyIQfFe5x8JyF/V1435xKwpFBVpFBZelw
         V5FHOlSQDIks5J5Npk8PppdprzmVgmVRREcoKA5JNFa/0bVc8Iwd86QoHjmOBdWKDKfr
         E8qND6IJ3yq93TCorimplk/lG3DbPMe3HEcUvUmG0qWz+XViQv8q0zBLlS0ZSQBAIAXW
         eUSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDCnNebtBYWZFAcJupspmZ4rrxOB4w3I6ZHBzmXvkRv+ugCDIIht6Nd8krzIjpMwKpLwjYCi6TPivewQakY4BW@vger.kernel.org
X-Gm-Message-State: AOJu0YzMolLIH3GxY8joAEQPIyr09Z4eg8sJIb6xNoPtK2ADwtJqu/nG
	I4XmJ6SGiTExc3cpwXCai9ykta80RgVC/bQmDrL6WVzUQWaC/hBmVC8Vp55bhHdde8dmZc0aIWG
	5m5777ig3HQ==
X-Received: from dlbuy21.prod.google.com ([2002:a05:7022:1e15:b0:128:d48f:6f7d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e25:b0:12a:6e97:c21f
 with SMTP id a92af1059eb24-12bfb62b033mr2060481c88.0.1775248861093; Fri, 03
 Apr 2026 13:41:01 -0700 (PDT)
Date: Fri,  3 Apr 2026 13:40:08 -0700
In-Reply-To: <20260403204017.2919994-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fXDd2_uqRHGOrbbjsAjbunsW67P-kONsmhm6UZWQUc-2w@mail.gmail.com>
 <20260403204017.2919994-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403204017.2919994-17-irogers@google.com>
Subject: [PATCH v5 16/25] perf inject: Don't pass evsel with sample
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
 tools/perf/builtin-inject.c        | 52 +++++++++--------
 tools/perf/util/synthetic-events.c | 92 +++++++++++++++++++-----------
 tools/perf/util/synthetic-events.h |  2 -
 3 files changed, 86 insertions(+), 60 deletions(-)

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
index ddf1cbda1902..e848129db996 100644
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
@@ -2307,39 +2321,51 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 					  __u32 prot, __u32 flags,
 					  const char *filename)
 {
-	union perf_event ev;
+	struct {
+		union perf_event ev;
+		/* Esnure there is sufficient storage space for sample ids. */
+		__u64 sample_ids[MAX_ID_HDR_ENTRIES];
+	} ev;
 	size_t ev_len;
 	void *array;
 	int ret;
 
-	ev_len = sizeof(ev.mmap2) - sizeof(ev.mmap2.filename) + strlen(filename) + 1;
+	if (!sample->evsel)
+		return -EINVAL; /* Evsel is needed for sample_type data. */
+
+	ev_len = sizeof(ev.ev.mmap2) - sizeof(ev.ev.mmap2.filename) + strlen(filename) + 1;
 	ev_len = PERF_ALIGN(ev_len, sizeof(u64));
 
 	memset(&ev, 0, ev_len);
 
-	ev.mmap2.header.type = PERF_RECORD_MMAP2;
-	ev.mmap2.header.misc = misc | PERF_RECORD_MISC_MMAP_BUILD_ID;
-	ev.mmap2.header.size = ev_len;
+	ev.ev.mmap2.header.type = PERF_RECORD_MMAP2;
+	ev.ev.mmap2.header.misc = misc | PERF_RECORD_MISC_MMAP_BUILD_ID;
+	ev.ev.mmap2.header.size = ev_len;
 
-	ev.mmap2.pid = pid;
-	ev.mmap2.tid = tid;
-	ev.mmap2.start = start;
-	ev.mmap2.len = len;
-	ev.mmap2.pgoff = pgoff;
+	ev.ev.mmap2.pid = pid;
+	ev.ev.mmap2.tid = tid;
+	ev.ev.mmap2.start = start;
+	ev.ev.mmap2.len = len;
+	ev.ev.mmap2.pgoff = pgoff;
 
-	ev.mmap2.build_id_size = bid->size;
-	if (ev.mmap2.build_id_size > sizeof(ev.mmap2.build_id))
-		ev.build_id.size = sizeof(ev.mmap2.build_id);
-	memcpy(ev.mmap2.build_id, bid->data, ev.mmap2.build_id_size);
+	ev.ev.mmap2.build_id_size = bid->size;
+	if (ev.ev.mmap2.build_id_size > sizeof(ev.ev.mmap2.build_id))
+		ev.ev.build_id.size = sizeof(ev.ev.mmap2.build_id);
+	memcpy(ev.ev.mmap2.build_id, bid->data, ev.ev.mmap2.build_id_size);
 
-	ev.mmap2.prot = prot;
-	ev.mmap2.flags = flags;
+	ev.ev.mmap2.prot = prot;
+	ev.ev.mmap2.flags = flags;
 
-	memcpy(ev.mmap2.filename, filename, min(strlen(filename), sizeof(ev.mmap.filename)));
+	memcpy(ev.ev.mmap2.filename, filename, min(strlen(filename), sizeof(ev.ev.mmap.filename)));
 
 	array = &ev;
-	array += ev.header.size;
-	ret = perf_event__synthesize_id_sample(array, evsel->core.attr.sample_type, sample);
+	array += ev.ev.header.size;
+	ret = __perf_event__synthesize_id_sample(array, sample->evsel->core.attr.sample_type,
+						pid, tid,
+						sample->time,
+						sample->id,
+						sample->stream_id,
+						sample->cpu);
 	if (ret < 0)
 		return ret;
 
@@ -2348,9 +2374,9 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 		return -EINVAL;
 	}
 
-	ev.header.size += ret;
+	ev.ev.header.size += ret;
 
-	return process(tool, &ev, sample, machine);
+	return process(tool, &ev.ev, sample, machine);
 }
 
 int perf_event__synthesize_stat_events(struct perf_stat_config *config, const struct perf_tool *tool,
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

