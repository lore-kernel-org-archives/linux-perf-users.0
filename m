Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BB740FDAA
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 23:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773962679; cv=none; b=GF618wzxNulIW3bTlA9Jd7O8UjTL8mdq5IHeJHU9VweUES/4qMZ/DLs8OQmvqii3D4Jk08dbBOUDZ42TDW18bbcNNoMInkQN0wUoEBvhpdXe2H2qwI8ZYR9FPkcnkVBWRlr7eoJF/C2w+8WGD5+FgGXez/Non5Gxaas0S4SE55s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773962679; c=relaxed/simple;
	bh=vPg9VgZ3c7SsWfs3DNFG+E/UJQK7VY1DPa8uKtJ7fGc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pasjey9J0StDEZAu60CwiLsfFjB8/RDOUpcDowGNBGeh6bC/yKHOWEwAH0s4q2S6m2U+mWcSROtBhFYWLi7droFQ28msvLiAIcTYK/PsLo1DuclMCp+GUis0GV4+bUFbxtYhRwLkUpeM5ihF3dC43ihUhky+9cQsk5R5O4xzM38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dITCVDzh; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dITCVDzh"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35b901d542bso9642867a91.3
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 16:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773962677; x=1774567477; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W28Iv827p/4MEELaJazuln8g4iiY7jnX7+0vAOMUjQE=;
        b=dITCVDzhkwXnBInVUDdo8Rxr1O8KEJaoId5WNC8nZZlggTiR6kbZVADxCEHtbHwmOS
         xKpke/47vFKyIgFS3LxeoW8j5wXMTTjgN4zXDIjSelbPM++2+FubyY/NsMM4d6TRT9NE
         06LaHirJfezwhP3HYuExA/aLKeRR6+SiHboP+mRc6xa8iynTM8EVYfwCnmEsvvZv2/2Q
         5o4SbR8Z0QBBeg8V4fkWENVHmMaIS16zHnVkGRz8LD530E+OlGt5vnictLJm1AN9khsg
         TelsY0U5PMT4hjcXOY1maYtX5oC8I0G/ql/ojLgFw6N6qaczXyFbUOVatfUabgzrBgNU
         nAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773962677; x=1774567477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W28Iv827p/4MEELaJazuln8g4iiY7jnX7+0vAOMUjQE=;
        b=Ih7rEMgMBdh+KUmeTAtdT/PAO6/t9eVu9m/ZEXNV1L+apcdMokZv3/rhET+d4Ceyx8
         lsWTHHdFYSV6v8lQOhxDue5xLadeh4tMAPMikdLq3lS/sgih/FpdxRQkuxnBXiUPslj3
         AY7MdyLX0heDndwEfqC3ctwUW1gXnNTb8S5tKZohFI7eup1uqftdTNiwvlwJvHPmRj4h
         6lBdVXzoMRBrU9K/UQIZxZSn+O93lKr9YgJqtraz6bkLln/rmL0mUtz/8dpmPB6hITR0
         CdeHSUcQ7EP6B0YJ0E+OYqMsj27+tn5hoqwMHQC2uYBO0UPXBRNpgUS6pJG6kF+2TTxt
         Hq5g==
X-Forwarded-Encrypted: i=1; AJvYcCWwwJoT6bivsdfxdy+rqR8W/unkcT2cY881SZMkRYCRVAUrpKbUioQ4uRra06rb2/XGyGNb06w0nQ24wywyw9DE@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg4vhDH8bhwacFWvfp7OY6LjFBHc1xRWhlX1ujqdgugc6lhxUB
	rwdc0E0XK7DbEcgKKZW5Af5FhXe2Gv3n9gXafRCn7tXmPfRd7BpHgGBA5yDdTN8RlVvxW4LTCeP
	0wWwPPghAWg==
X-Received: from pjyj6.prod.google.com ([2002:a17:90a:e606:b0:359:8332:2cce])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b04:b0:354:a284:3fff
 with SMTP id 98e67ed59e1d1-35bd2d187e4mr704735a91.25.1773962676636; Thu, 19
 Mar 2026 16:24:36 -0700 (PDT)
Date: Thu, 19 Mar 2026 16:23:25 -0700
In-Reply-To: <20260319232334.287517-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com> <20260319232334.287517-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260319232334.287517-17-irogers@google.com>
Subject: [PATCH v2 16/25] perf inject: Don't pass evsel with sample
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
evsel as well.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c        | 37 +++++++++++-------------------
 tools/perf/util/synthetic-events.c |  9 ++++----
 tools/perf/util/synthetic-events.h |  2 --
 3 files changed, 18 insertions(+), 30 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index bc6d94806080..6e265b66a551 100644
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
@@ -584,11 +581,14 @@ static int perf_event__repipe_common_mmap(const struct perf_tool *tool,
 		}
 
 		if (dso && !dso__hit(dso)) {
-			struct evsel *evsel = evlist__event2evsel(inject->session->evlist, event);
+			struct evsel *evsel = sample->evsel;
+
+			if (!evsel)
+				evsel = evlist__event2evsel(inject->session->evlist, event);
 
 			if (evsel) {
 				dso__set_hit(dso);
-				tool__inject_build_id(tool, sample, machine, evsel,
+				tool__inject_build_id(tool, sample, machine,
 						      /*misc=*/sample->cpumode,
 						      filename, dso, flags);
 			}
@@ -622,7 +622,7 @@ static int perf_event__repipe_common_mmap(const struct perf_tool *tool,
 			dso_sought = true;
 		}
 		if (evsel && dso &&
-		    !tool__inject_mmap2_build_id(tool, sample, machine, evsel,
+		    !tool__inject_mmap2_build_id(tool, sample, machine,
 						 sample->cpumode | PERF_RECORD_MISC_MMAP_BUILD_ID,
 						 pid, tid, start, len, pgoff,
 						 dso,
@@ -836,7 +836,6 @@ static bool perf_inject__lookup_known_build_id(struct perf_inject *inject,
 static int tool__inject_build_id(const struct perf_tool *tool,
 				 struct perf_sample *sample,
 				 struct machine *machine,
-				 const struct evsel *evsel,
 				 __u16 misc,
 				 const char *filename,
 				 struct dso *dso, u32 flags)
@@ -860,7 +859,7 @@ static int tool__inject_build_id(const struct perf_tool *tool,
 
 	err = perf_event__synthesize_build_id(tool, sample, machine,
 					      perf_event__repipe,
-					      evsel, misc, dso__bid(dso),
+					      misc, dso__bid(dso),
 					      filename);
 	if (err) {
 		pr_err("Can't synthesize build_id event for %s\n", filename);
@@ -873,7 +872,6 @@ static int tool__inject_build_id(const struct perf_tool *tool,
 static int tool__inject_mmap2_build_id(const struct perf_tool *tool,
 				       struct perf_sample *sample,
 				       struct machine *machine,
-				       const struct evsel *evsel,
 				       __u16 misc,
 				       __u32 pid, __u32 tid,
 				       __u64 start, __u64 len, __u64 pgoff,
@@ -896,7 +894,6 @@ static int tool__inject_mmap2_build_id(const struct perf_tool *tool,
 
 	err = perf_event__synthesize_mmap2_build_id(tool, sample, machine,
 						    perf_event__repipe,
-						    evsel,
 						    misc, pid, tid,
 						    start, len, pgoff,
 						    dso__bid(dso),
@@ -913,7 +910,6 @@ static int mark_dso_hit(const struct perf_inject *inject,
 			const struct perf_tool *tool,
 			struct perf_sample *sample,
 			struct machine *machine,
-			const struct evsel *mmap_evsel,
 			struct map *map, bool sample_in_dso)
 {
 	struct dso *dso;
@@ -943,7 +939,7 @@ static int mark_dso_hit(const struct perf_inject *inject,
 		if (dso && !dso__hit(dso)) {
 			dso__set_hit(dso);
 			tool__inject_build_id(tool, sample, machine,
-					     mmap_evsel, misc, dso__long_name(dso), dso,
+					     misc, dso__long_name(dso), dso,
 					     map__flags(map));
 		}
 	} else if (inject->build_id_style == BID_RWS__MMAP2_BUILDID_LAZY) {
@@ -955,7 +951,6 @@ static int mark_dso_hit(const struct perf_inject *inject,
 			map__set_hit(map);
 			perf_event__synthesize_mmap2_build_id(tool, sample, machine,
 								perf_event__repipe,
-								mmap_evsel,
 								misc,
 								sample->pid, sample->tid,
 								map__start(map),
@@ -975,7 +970,6 @@ struct mark_dso_hit_args {
 	const struct perf_tool *tool;
 	struct perf_sample *sample;
 	struct machine *machine;
-	const struct evsel *mmap_evsel;
 };
 
 static int mark_dso_hit_callback(struct callchain_cursor_node *node, void *data)
@@ -984,7 +978,7 @@ static int mark_dso_hit_callback(struct callchain_cursor_node *node, void *data)
 	struct map *map = node->ms.map;
 
 	return mark_dso_hit(args->inject, args->tool, args->sample, args->machine,
-			    args->mmap_evsel, map, /*sample_in_dso=*/false);
+			    map, /*sample_in_dso=*/false);
 }
 
 static int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *event,
@@ -1002,7 +996,6 @@ static int perf_event__inject_buildid(const struct perf_tool *tool, union perf_e
 		 */
 		.sample = sample,
 		.machine = machine,
-		.mmap_evsel = inject__mmap_evsel(inject),
 	};
 	struct evsel *saved_evsel = sample->evsel;
 
@@ -1015,7 +1008,7 @@ static int perf_event__inject_buildid(const struct perf_tool *tool, union perf_e
 	}
 
 	if (thread__find_map(thread, sample->cpumode, sample->ip, &al)) {
-		mark_dso_hit(inject, tool, sample, machine, args.mmap_evsel, al.map,
+		mark_dso_hit(inject, tool, sample, machine, al.map,
 			     /*sample_in_dso=*/true);
 	}
 
@@ -1033,7 +1026,6 @@ static int perf_event__inject_buildid(const struct perf_tool *tool, union perf_e
 static int perf_inject__sched_process_exit(const struct perf_tool *tool,
 					   union perf_event *event __maybe_unused,
 					   struct perf_sample *sample,
-					   struct evsel *evsel __maybe_unused,
 					   struct machine *machine __maybe_unused)
 {
 	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
@@ -1053,13 +1045,12 @@ static int perf_inject__sched_process_exit(const struct perf_tool *tool,
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
@@ -1078,13 +1069,13 @@ static int perf_inject__sched_switch(const struct perf_tool *tool,
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
 
@@ -1449,7 +1440,7 @@ static int synthesize_build_id(struct perf_inject *inject, struct dso *dso, pid_
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

