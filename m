Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D53372EE5
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 08:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994158; cv=none; b=g44hKqs3buyMgKdDKdoiD38CQm4xQvd+k+b4a6w8wcPSvQ+k1s7EyrMG01Tx2OoxixYDiunP8WuTE7gpBSI8TGhKCt8lfxMO2z57o2xLLMUWLmNBNN5Oe1crdOCoSN5aOZRQP0DERwDv1FYAE+vY/zi4UsUQJHOlD/vjKR98wIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994158; c=relaxed/simple;
	bh=LqFRnK3aSdZuD9rdOYV+OBVFWv9xvS76uduaBHzQz98=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XLYBFE0RVLzkzR1BNfVHV4q/QM0xc3yPPmuqZoikmcNdEzE1AW3LMOx1rERG8mp96DWNGk5n9tfHmUz8sKCloOfiz5zhivTPWX81F2hN8Fv2tLulzac0KQYRD7b3q3GixYlcwrFaRZ6wL5BUiRd2mDQEGwkFn5taK+cuoeGfsVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bvTtB6j0; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bvTtB6j0"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c105e5ac70so430048eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 01:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773994156; x=1774598956; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Axq4DFGGwdZiGTNI5Qtm5bku13rQk5dCHnjd1ssnepE=;
        b=bvTtB6j0wtY3j7n6yTbaZvcIkGsE40WMwWt3j+0zb0wDJdPUbM51NmDQfSZ0W8Re2h
         BbNvAnQGYtgfa8Nsso4PYgXWNJ3extHAoFjeFMIDUm3gveIb27Rsipb5wKepgsNkUyHD
         eRvieuIe7FgGC82K6zkvyhFTZcm9vu0vhw1PNv0JW7/mXEIXCuR8uggHg0/SaHEjVU7V
         V02npuCNOPQS6hgXSN3iW84Fs6NZycBnteJPz/zXK5x9ESCGynkKtlRe4BZbqMljEqgc
         MTOkWYHUPTLemiG/fv34LXL+KdlKoMB5+sv1+0o2wsXoa4ANYoI4qg3zWBgpy/0vih/M
         SDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773994156; x=1774598956;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Axq4DFGGwdZiGTNI5Qtm5bku13rQk5dCHnjd1ssnepE=;
        b=PDwYpx9okOfcY+xvKn9soiELoHj9nEd0nqoPThkOqnuUBySEy1oZ3eKGovws3RItYI
         F19JQZ+AyKqDh9J+5+YITd2pBWA6/qHD4rK0FzTROBZwZqP9aQLhM1IamaMp1FBSyMri
         jkkPqGPjZha5Pjpj1QslMA0ZS4I782tWtkF+rR4u/Gg7Rv8UubMFRAK68Oy7lZZFz3aS
         3tG8+Jn8UVJJ7Kstk9TSJWj8rVf7EjHcavSJeEYrb8VGGV7R9ienw2jHpTDrKAf75EMl
         lcTPiaj9m+16263sfi95haOSu9ju08wkT/PfBVF9pjZxqFPeqDuvdG/Q8x9Tq2DiL234
         VcnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC5YhLJMr+PdQqO4WibAjroWN8H5BACB35LFpuCLCDIv8ZHEwociCqjtMjZAghd4zI0XIT/GwLpXYhdMXCZmv1@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb55HYx/+NvJMYZSeeU0PzXEK1mBHratxARDaJd1Dr01UlKzoG
	lDPwSU/yMMmhzsRnc0RJw/wayViVxku9BBSE9vF5JF0n+QtjePQHSx2o88g5e6pso3xFsclc+fP
	T6E4Avg4rTg==
X-Received: from dybmn16.prod.google.com ([2002:a05:7300:d210:b0:2c0:d899:d1a2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4083:b0:2be:171c:5048
 with SMTP id 5a478bee46e88-2c1095a4d51mr1065746eec.5.1773994156029; Fri, 20
 Mar 2026 01:09:16 -0700 (PDT)
Date: Fri, 20 Mar 2026 01:08:25 -0700
In-Reply-To: <20260320080835.724836-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260319232334.287517-1-irogers@google.com> <20260320080835.724836-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320080835.724836-17-irogers@google.com>
Subject: [PATCH v3 16/25] perf inject: Don't pass evsel with sample
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
evsel as well.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c        | 46 ++++++++++++------------------
 tools/perf/util/synthetic-events.c |  9 +++---
 tools/perf/util/synthetic-events.h |  2 --
 3 files changed, 23 insertions(+), 34 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 1b873377c6ad..0b2326ea63ad 100644
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
@@ -913,7 +911,6 @@ static int mark_dso_hit(const struct perf_inject *inject,
 			const struct perf_tool *tool,
 			struct perf_sample *sample,
 			struct machine *machine,
-			const struct evsel *mmap_evsel,
 			struct map *map, bool sample_in_dso)
 {
 	struct dso *dso;
@@ -943,7 +940,7 @@ static int mark_dso_hit(const struct perf_inject *inject,
 		if (dso && !dso__hit(dso)) {
 			dso__set_hit(dso);
 			tool__inject_build_id(tool, sample, machine,
-					     mmap_evsel, misc, dso__long_name(dso), dso,
+					     misc, dso__long_name(dso), dso,
 					     map__flags(map));
 		}
 	} else if (inject->build_id_style == BID_RWS__MMAP2_BUILDID_LAZY) {
@@ -955,7 +952,6 @@ static int mark_dso_hit(const struct perf_inject *inject,
 			map__set_hit(map);
 			perf_event__synthesize_mmap2_build_id(tool, sample, machine,
 								perf_event__repipe,
-								mmap_evsel,
 								misc,
 								sample->pid, sample->tid,
 								map__start(map),
@@ -975,7 +971,6 @@ struct mark_dso_hit_args {
 	const struct perf_tool *tool;
 	struct perf_sample *sample;
 	struct machine *machine;
-	const struct evsel *mmap_evsel;
 };
 
 static int mark_dso_hit_callback(struct callchain_cursor_node *node, void *data)
@@ -984,7 +979,7 @@ static int mark_dso_hit_callback(struct callchain_cursor_node *node, void *data)
 	struct map *map = node->ms.map;
 
 	return mark_dso_hit(args->inject, args->tool, args->sample, args->machine,
-			    args->mmap_evsel, map, /*sample_in_dso=*/false);
+			    map, /*sample_in_dso=*/false);
 }
 
 static int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *event,
@@ -1002,7 +997,6 @@ static int perf_event__inject_buildid(const struct perf_tool *tool, union perf_e
 		 */
 		.sample = sample,
 		.machine = machine,
-		.mmap_evsel = inject__mmap_evsel(inject),
 	};
 	struct evsel *saved_evsel = sample->evsel;
 
@@ -1016,7 +1010,7 @@ static int perf_event__inject_buildid(const struct perf_tool *tool, union perf_e
 
 	sample->evsel = inject__mmap_evsel(inject);
 	if (thread__find_map(thread, sample->cpumode, sample->ip, &al)) {
-		mark_dso_hit(inject, tool, sample, machine, args.mmap_evsel, al.map,
+		mark_dso_hit(inject, tool, sample, machine, al.map,
 			     /*sample_in_dso=*/true);
 	}
 
@@ -1033,7 +1027,6 @@ static int perf_event__inject_buildid(const struct perf_tool *tool, union perf_e
 static int perf_inject__sched_process_exit(const struct perf_tool *tool,
 					   union perf_event *event __maybe_unused,
 					   struct perf_sample *sample,
-					   struct evsel *evsel __maybe_unused,
 					   struct machine *machine __maybe_unused)
 {
 	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
@@ -1053,13 +1046,12 @@ static int perf_inject__sched_process_exit(const struct perf_tool *tool,
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
@@ -1078,13 +1070,13 @@ static int perf_inject__sched_switch(const struct perf_tool *tool,
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
 
@@ -1449,7 +1441,7 @@ static int synthesize_build_id(struct perf_inject *inject, struct dso *dso, pid_
 	dso__set_hit(dso);
 
 	return perf_event__synthesize_build_id(&inject->tool, &synth_sample, machine,
-					       process_build_id, inject__mmap_evsel(inject),
+					       process_build_id,
 					       /*misc=*/synth_sample.cpumode,
 					       dso__bid(dso), dso__long_name(dso));
 }
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index ef79433ebc3a..53e411cf33cc 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2247,7 +2247,6 @@ int perf_event__synthesize_build_id(const struct perf_tool *tool,
 				    struct perf_sample *sample,
 				    struct machine *machine,
 				    perf_event__handler_t process,
-				    const struct evsel *evsel,
 				    __u16 misc,
 				    const struct build_id *bid,
 				    const char *filename)
@@ -2270,12 +2269,13 @@ int perf_event__synthesize_build_id(const struct perf_tool *tool,
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
 
@@ -2294,7 +2294,6 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 					  struct perf_sample *sample,
 					  struct machine *machine,
 					  perf_event__handler_t process,
-					  const struct evsel *evsel,
 					  __u16 misc,
 					  __u32 pid, __u32 tid,
 					  __u64 start, __u64 len, __u64 pgoff,
@@ -2334,7 +2333,7 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 
 	array = &ev;
 	array += ev.header.size;
-	ret = perf_event__synthesize_id_sample(array, evsel->core.attr.sample_type, sample);
+	ret = perf_event__synthesize_id_sample(array, sample->evsel->core.attr.sample_type, sample);
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
2.53.0.959.g497ff81fa9-goog

