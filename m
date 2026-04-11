Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33B03BC677
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775935043; cv=none; b=sU7lokbf/VUo4HGTIT924VOCHspPmIpvFVytrNEKZzPXV3DCn7ndpmG4t5fgqXGHTtlFV4tQ2hg92Q3aZbzf1lnKjRLI46DYKmo2l5VDXoijFGXmOLDnQQnPYDjDirTpY4FJm6mcfGwMOL6LoLrmEXH1bJ4CRugSvsd1s4iv5G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775935043; c=relaxed/simple;
	bh=Vb2j/URb3QO7BAssSKxkK5mAjrJs/pLZhsGaxkgHYgM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lGQXaCJCQ6cgNLDh9kFjmj1H/GYtoGXGz8r8zz292+3YjlR72DZSyjLfaMZzQ+FF3AaDFbnuAJMoXPl7SgCgMTn8tpBjZzwhyYrhH7uRphj+9pzRIWScVovTGF3cfJ02Ifu9Svq9ECnB5FfydKm+L+zurCjjWr5Z++y/46Inbmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pZj6miHj; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pZj6miHj"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c28353912so3095913c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 12:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775935040; x=1776539840; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oAQ3kf9+7lnpDXcb3kNRnHyobYDSr9TH1cF4PamcK4M=;
        b=pZj6miHjyyrOZsMy8uQylAiU1YP6pgx4DrmJZQHqirDQnVhJqOVMT3DzDVyXEtLmuR
         /JrTpo2o6TuPrRP8hR6zsM7BgeqHbkr3L2MKjJ+tvjFdPW/0GD6K0AGhV0ofuD7wWNrF
         /GGadldHZfgZtSlm5N46A+WBp5XkA7it8jry1yraJx6p/hfqS5qp023NMLwxfuXs+A8D
         EqbuPnWfFHQfC6eyfNfK97AlZrT0NpNM/8w99JtuwLiNIBfliuyS+u33b69MlML453YL
         w+Nm5xijU1nGTsbE+iEnbZzy/FVuvRQtDaVgfAEDvg2qMbBBTuizCa0+YmGvMVpPZS1o
         r0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775935040; x=1776539840;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oAQ3kf9+7lnpDXcb3kNRnHyobYDSr9TH1cF4PamcK4M=;
        b=IMNZc8tqa7O4uOYFB96AW7Z4Pf2jbnYXcxsky+13Bxf47DD7+hKMPA5pdhJHwC87cG
         7yvYBk54Gyq4QElpfECbXI/kqzZbAJLoambewVrGleS+eqzvM3sdVW59yi8md887hGcs
         uwUn8l74tsB0Z2zt33vyk5uCUx7bWyhfQYQ0+rte74+VJiAdrRTWHjrxvNKBvcXKoG7/
         GztbQn/RfMY2kiz2MWKq3K4LebhqUpN3s+C2vbg1piQkhArCc1F3VO5bg2cxjXg3y6FK
         krhTLGxvSiFxCIkt3b5huMeHr4YL+09s55KZkVBXMpge7gvbQYj+btJ538mhG/e06Qd6
         aVoA==
X-Forwarded-Encrypted: i=1; AJvYcCX+Vumo0m9LxuHJ2TwOx1OlOO4D3R8r9NBonQ/8TQTBy44DyoeAdW7y4jNO+PUNLobzo3+bykO09uORWT8cxmaT@vger.kernel.org
X-Gm-Message-State: AOJu0YyhpaV+vEmdve1NmAwLnK3Gyxa7NG1kuuF7BriWfui/uHv0Qji6
	ak3HiaWWiwOumWF79SkRZjQkUc9qNANc8ATkcEeR8FCVqUJ51no4od8WmnSZYcy2i/Yf0xi6aKb
	G4DhGvDUs+g==
X-Received: from dlbur20.prod.google.com ([2002:a05:7022:ea54:b0:12b:fc23:6fcb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e982:b0:119:e56b:957b
 with SMTP id a92af1059eb24-12c34dba22dmr4818429c88.0.1775935039738; Sat, 11
 Apr 2026 12:17:19 -0700 (PDT)
Date: Sat, 11 Apr 2026 12:16:43 -0700
In-Reply-To: <20260411191710.524998-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411065718.372240-1-irogers@google.com> <20260411191710.524998-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411191710.524998-3-irogers@google.com>
Subject: [PATCH v9 02/29] perf tool: Remove evsel from tool APIs that pass the sample
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

Now struct perf_sample has the evsel within it there is no need to
pass the evsel along with the sample. In the called functions read the
sample's evsel in to a variable if there are multiple uses, or use
directly if there is just one use - the goal being to leave the code
with as little change as possible. Some functions only use the evsel
to pass to another function which they also pass the sample, in those
cases just pass the sample and get the evsel in the called function.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c       |  3 +--
 tools/perf/builtin-c2c.c            |  2 +-
 tools/perf/builtin-diff.c           |  2 +-
 tools/perf/builtin-inject.c         | 19 ++++++---------
 tools/perf/builtin-kmem.c           |  2 +-
 tools/perf/builtin-kvm.c            |  5 ++--
 tools/perf/builtin-kwork.c          |  2 +-
 tools/perf/builtin-lock.c           |  2 +-
 tools/perf/builtin-mem.c            |  1 -
 tools/perf/builtin-record.c         |  3 +--
 tools/perf/builtin-report.c         | 10 +++-----
 tools/perf/builtin-sched.c          |  4 +--
 tools/perf/builtin-script.c         |  4 +--
 tools/perf/builtin-timechart.c      |  2 +-
 tools/perf/builtin-trace.c          |  2 +-
 tools/perf/util/build-id.c          |  3 +--
 tools/perf/util/build-id.h          |  7 +-----
 tools/perf/util/data-convert-bt.c   |  2 +-
 tools/perf/util/data-convert-json.c |  5 ++--
 tools/perf/util/intel-tpebs.c       |  3 +--
 tools/perf/util/jitdump.c           |  2 +-
 tools/perf/util/session.c           | 38 ++++++++++++++---------------
 tools/perf/util/tool.c              |  4 +--
 tools/perf/util/tool.h              |  4 +--
 24 files changed, 55 insertions(+), 76 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 5e57b78548f4..58e56f826367 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -283,7 +283,6 @@ static int evsel__add_sample(struct evsel *evsel, struct perf_sample *sample,
 static int process_sample_event(const struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
-				struct evsel *evsel,
 				struct machine *machine)
 {
 	struct perf_annotate *ann = container_of(tool, struct perf_annotate, tool);
@@ -302,7 +301,7 @@ static int process_sample_event(const struct perf_tool *tool,
 		goto out_put;
 
 	if (!al.filtered &&
-	    evsel__add_sample(evsel, sample, &al, ann, machine)) {
+	    evsel__add_sample(sample->evsel, sample, &al, ann, machine)) {
 		pr_warning("problem incrementing symbol count, "
 			   "skipping event\n");
 		ret = -1;
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 72a7802775ee..7593e5908fcc 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -314,9 +314,9 @@ static void perf_c2c__evsel_hists_inc_stats(struct evsel *evsel,
 static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 				union perf_event *event,
 				struct perf_sample *sample,
-				struct evsel *evsel,
 				struct machine *machine)
 {
+	struct evsel *evsel = sample->evsel;
 	struct c2c_hists *c2c_hists = &c2c.hists;
 	struct c2c_hist_entry *c2c_he;
 	struct c2c_stats stats = { .nr_entries = 0, };
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 1b3df868849a..82e9e514922b 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -390,11 +390,11 @@ static struct hist_entry_ops block_hist_ops = {
 static int diff__process_sample_event(const struct perf_tool *tool,
 				      union perf_event *event,
 				      struct perf_sample *sample,
-				      struct evsel *evsel,
 				      struct machine *machine)
 {
 	struct perf_diff *pdiff = container_of(tool, struct perf_diff, tool);
 	struct addr_location al;
+	struct evsel *evsel = sample->evsel;
 	struct hists *hists = evsel__hists(evsel);
 	struct hist_entry_iter iter = {
 		.evsel	= evsel,
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index f174bc69cec4..6ba489452777 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -362,18 +362,17 @@ typedef int (*inject_handler)(const struct perf_tool *tool,
 static int perf_event__repipe_sample(const struct perf_tool *tool,
 				     union perf_event *event,
 				     struct perf_sample *sample,
-				     struct evsel *evsel,
 				     struct machine *machine)
 {
-	struct perf_inject *inject = container_of(tool, struct perf_inject,
-						  tool);
+	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
+	struct evsel *evsel = sample->evsel;
 
 	if (evsel && evsel->handler) {
 		inject_handler f = evsel->handler;
 		return f(tool, event, sample, evsel, machine);
 	}
 
-	build_id__mark_dso_hit(tool, event, sample, evsel, machine);
+	build_id__mark_dso_hit(tool, event, sample, machine);
 
 	if (inject->itrace_synth_opts.set && sample->aux_sample.size) {
 		event = perf_inject__cut_auxtrace_sample(inject, event, sample);
@@ -387,10 +386,10 @@ static int perf_event__repipe_sample(const struct perf_tool *tool,
 static int perf_event__convert_sample_callchain(const struct perf_tool *tool,
 						union perf_event *event,
 						struct perf_sample *sample,
-						struct evsel *evsel,
 						struct machine *machine)
 {
 	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
+	struct evsel *evsel = sample->evsel;
 	struct callchain_cursor *cursor = get_tls_callchain_cursor();
 	union perf_event *event_copy = (void *)inject->event_copy;
 	struct callchain_cursor_node *node;
@@ -987,10 +986,8 @@ static int mark_dso_hit_callback(struct callchain_cursor_node *node, void *data)
 			    args->mmap_evsel, map, /*sample_in_dso=*/false);
 }
 
-int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *event,
-			       struct perf_sample *sample,
-			       struct evsel *evsel __maybe_unused,
-			       struct machine *machine)
+static int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *event,
+				      struct perf_sample *sample, struct machine *machine)
 {
 	struct addr_location al;
 	struct thread *thread;
@@ -1020,7 +1017,7 @@ int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *e
 			     /*sample_in_dso=*/true);
 	}
 
-	sample__for_each_callchain_node(thread, evsel, sample, PERF_MAX_STACK_DEPTH,
+	sample__for_each_callchain_node(thread, sample->evsel, sample, PERF_MAX_STACK_DEPTH,
 					/*symbols=*/false, mark_dso_hit_callback, &args);
 	thread__put(thread);
 repipe:
@@ -1101,7 +1098,7 @@ static int perf_inject__sched_stat(const struct perf_tool *tool,
 	sample_sw.time	 = sample->time;
 	perf_event__synthesize_sample(event_sw, evsel->core.attr.sample_type,
 				      evsel->core.attr.read_format, &sample_sw);
-	build_id__mark_dso_hit(tool, event_sw, &sample_sw, evsel, machine);
+	build_id__mark_dso_hit(tool, event_sw, &sample_sw, machine);
 	ret = perf_event__repipe(tool, event_sw, &sample_sw, machine);
 	perf_sample__exit(&sample_sw);
 	return ret;
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 9c64a0d74823..45b383fa9ce9 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -960,9 +960,9 @@ typedef int (*tracepoint_handler)(struct evsel *evsel,
 static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 				union perf_event *event,
 				struct perf_sample *sample,
-				struct evsel *evsel,
 				struct machine *machine)
 {
+	struct evsel *evsel = sample->evsel;
 	int err = 0;
 	struct thread *thread = machine__findnew_thread(machine, sample->pid,
 							sample->tid);
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 0c5e6b3aac74..5e8e6fde097a 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -941,9 +941,9 @@ struct vcpu_event_record *per_vcpu_record(struct thread *thread,
 
 static bool handle_kvm_event(struct perf_kvm_stat *kvm,
 			     struct thread *thread,
-			     struct evsel *evsel,
 			     struct perf_sample *sample)
 {
+	struct evsel *evsel = sample->evsel;
 	struct vcpu_event_record *vcpu_record;
 	struct event_key key = { .key = INVALID_KEY,
 				 .exit_reasons = kvm->exit_reasons };
@@ -1133,7 +1133,6 @@ static bool skip_sample(struct perf_kvm_stat *kvm,
 static int process_sample_event(const struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
-				struct evsel *evsel,
 				struct machine *machine)
 {
 	int err = 0;
@@ -1156,7 +1155,7 @@ static int process_sample_event(const struct perf_tool *tool,
 		return -1;
 	}
 
-	if (!handle_kvm_event(kvm, thread, evsel, sample))
+	if (!handle_kvm_event(kvm, thread, sample))
 		err = -1;
 
 	thread__put(thread);
diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 9d3a4c779a41..d4bb19ed91b5 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -1955,9 +1955,9 @@ typedef int (*tracepoint_handler)(const struct perf_tool *tool,
 static int perf_kwork__process_tracepoint_sample(const struct perf_tool *tool,
 						 union perf_event *event __maybe_unused,
 						 struct perf_sample *sample,
-						 struct evsel *evsel,
 						 struct machine *machine)
 {
+	struct evsel *evsel = sample->evsel;
 	int err = 0;
 
 	if (evsel->handler != NULL) {
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 5585aeb97684..4d8ddf6391e8 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1430,9 +1430,9 @@ typedef int (*tracepoint_handler)(struct evsel *evsel,
 static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 				union perf_event *event,
 				struct perf_sample *sample,
-				struct evsel *evsel,
 				struct machine *machine)
 {
+	struct evsel *evsel = sample->evsel;
 	int err = 0;
 	struct thread *thread = machine__findnew_thread(machine, sample->pid,
 							sample->tid);
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index d43500b92a7b..6101a26b3a78 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -255,7 +255,6 @@ dump_raw_samples(const struct perf_tool *tool,
 static int process_sample_event(const struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
-				struct evsel *evsel __maybe_unused,
 				struct machine *machine)
 {
 	return dump_raw_samples(tool, event, sample, machine);
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4a5eba498c02..9ba787406919 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1489,7 +1489,6 @@ static void set_timestamp_boundary(struct record *rec, u64 sample_time)
 static int process_sample_event(const struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
-				struct evsel *evsel,
 				struct machine *machine)
 {
 	struct record *rec = container_of(tool, struct record, tool);
@@ -1500,7 +1499,7 @@ static int process_sample_event(const struct perf_tool *tool,
 		return 0;
 
 	rec->samples++;
-	return build_id__mark_dso_hit(tool, event, sample, evsel, machine);
+	return build_id__mark_dso_hit(tool, event, sample, machine);
 }
 
 static int process_buildids(struct record *rec)
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 95c0bdba6b11..848e2ccb1420 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -264,10 +264,10 @@ static int process_feature_event(const struct perf_tool *tool,
 static int process_sample_event(const struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
-				struct evsel *evsel,
 				struct machine *machine)
 {
 	struct report *rep = container_of(tool, struct report, tool);
+	struct evsel *evsel = sample->evsel;
 	struct addr_location al;
 	struct hist_entry_iter iter = {
 		.evsel 			= evsel,
@@ -344,7 +344,6 @@ static int process_sample_event(const struct perf_tool *tool,
 static int process_read_event(const struct perf_tool *tool,
 			      union perf_event *event,
 			      struct perf_sample *sample __maybe_unused,
-			      struct evsel *evsel,
 			      struct machine *machine __maybe_unused)
 {
 	struct report *rep = container_of(tool, struct report, tool);
@@ -352,7 +351,7 @@ static int process_read_event(const struct perf_tool *tool,
 	if (rep->show_threads) {
 		int err = perf_read_values_add_value(&rep->show_threads_values,
 					   event->read.pid, event->read.tid,
-					   evsel,
+					   sample->evsel,
 					   event->read.value);
 
 		if (err)
@@ -778,11 +777,10 @@ static void report__output_resort(struct report *rep)
 
 static int count_sample_event(const struct perf_tool *tool __maybe_unused,
 			      union perf_event *event __maybe_unused,
-			      struct perf_sample *sample __maybe_unused,
-			      struct evsel *evsel,
+			      struct perf_sample *sample,
 			      struct machine *machine __maybe_unused)
 {
-	struct hists *hists = evsel__hists(evsel);
+	struct hists *hists = evsel__hists(sample->evsel);
 
 	hists__inc_nr_events(hists);
 	return 0;
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 555247568e7a..0713e6b28f92 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1867,9 +1867,9 @@ typedef int (*tracepoint_handler)(const struct perf_tool *tool,
 static int perf_sched__process_tracepoint_sample(const struct perf_tool *tool __maybe_unused,
 						 union perf_event *event __maybe_unused,
 						 struct perf_sample *sample,
-						 struct evsel *evsel,
 						 struct machine *machine)
 {
+	struct evsel *evsel = sample->evsel;
 	int err = 0;
 
 	if (evsel->handler != NULL) {
@@ -3184,10 +3184,10 @@ typedef int (*sched_handler)(const struct perf_tool *tool,
 static int perf_timehist__process_sample(const struct perf_tool *tool,
 					 union perf_event *event,
 					 struct perf_sample *sample,
-					 struct evsel *evsel,
 					 struct machine *machine)
 {
 	struct perf_sched *sched = container_of(tool, struct perf_sched, tool);
+	struct evsel *evsel = sample->evsel;
 	int err = 0;
 	struct perf_cpu this_cpu = {
 		.cpu = sample->cpu,
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c8ac9f01a36b..3ffb8baf40f6 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2645,10 +2645,10 @@ static bool filter_cpu(struct perf_sample *sample)
 static int process_sample_event(const struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
-				struct evsel *evsel,
 				struct machine *machine)
 {
 	struct perf_script *scr = container_of(tool, struct perf_script, tool);
+	struct evsel *evsel = sample->evsel;
 	struct addr_location al;
 	struct addr_location addr_al;
 	int ret = 0;
@@ -2729,10 +2729,10 @@ static int process_sample_event(const struct perf_tool *tool,
 static int process_deferred_sample_event(const struct perf_tool *tool,
 					 union perf_event *event,
 					 struct perf_sample *sample,
-					 struct evsel *evsel,
 					 struct machine *machine)
 {
 	struct perf_script *scr = container_of(tool, struct perf_script, tool);
+	struct evsel *evsel = sample->evsel;
 	struct perf_event_attr *attr = &evsel->core.attr;
 	struct evsel_script *es = evsel->priv;
 	unsigned int type = output_type(attr->type);
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 28f33e39895d..8692d11ccd29 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -574,10 +574,10 @@ typedef int (*tracepoint_handler)(struct timechart *tchart,
 static int process_sample_event(const struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
-				struct evsel *evsel,
 				struct machine *machine)
 {
 	struct timechart *tchart = container_of(tool, struct timechart, tool);
+	struct evsel *evsel = sample->evsel;
 
 	if (evsel->core.attr.sample_type & PERF_SAMPLE_TIME) {
 		if (!tchart->first_time || tchart->first_time > sample->time)
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e58c49d047a2..d9e80740e9ac 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3464,10 +3464,10 @@ static void trace__set_base_time(struct trace *trace,
 static int trace__process_sample(const struct perf_tool *tool,
 				 union perf_event *event,
 				 struct perf_sample *sample,
-				 struct evsel *evsel,
 				 struct machine *machine __maybe_unused)
 {
 	struct trace *trace = container_of(tool, struct trace, tool);
+	struct evsel *evsel = sample->evsel;
 	struct thread *thread;
 	int err = 0;
 
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index fdb35133fde4..55b72235f891 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -55,7 +55,6 @@ static int mark_dso_hit_callback(struct callchain_cursor_node *node, void *data
 int build_id__mark_dso_hit(const struct perf_tool *tool __maybe_unused,
 			   union perf_event *event,
 			   struct perf_sample *sample,
-			   struct evsel *evsel,
 			   struct machine *machine)
 {
 	struct addr_location al;
@@ -74,7 +73,7 @@ int build_id__mark_dso_hit(const struct perf_tool *tool __maybe_unused,
 
 	addr_location__exit(&al);
 
-	sample__for_each_callchain_node(thread, evsel, sample, PERF_MAX_STACK_DEPTH,
+	sample__for_each_callchain_node(thread, sample->evsel, sample, PERF_MAX_STACK_DEPTH,
 					/*symbols=*/false, mark_dso_hit_callback, /*data=*/NULL);
 
 
diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
index 47e621cebe1b..73bad90b06f9 100644
--- a/tools/perf/util/build-id.h
+++ b/tools/perf/util/build-id.h
@@ -34,12 +34,7 @@ char *__dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
 			       bool is_debug, bool is_kallsyms);
 
 int build_id__mark_dso_hit(const struct perf_tool *tool, union perf_event *event,
-			   struct perf_sample *sample, struct evsel *evsel,
-			   struct machine *machine);
-
-int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *event,
-			       struct perf_sample *sample, struct evsel *evsel,
-			       struct machine *machine);
+			   struct perf_sample *sample, struct machine *machine);
 
 bool perf_session__read_build_ids(struct perf_session *session, bool with_hits);
 int perf_session__write_buildid_table(struct perf_session *session,
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 3b8f2df823a9..b3f745cff2a7 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -803,10 +803,10 @@ static bool is_flush_needed(struct ctf_stream *cs)
 static int process_sample_event(const struct perf_tool *tool,
 				union perf_event *_event,
 				struct perf_sample *sample,
-				struct evsel *evsel,
 				struct machine *machine __maybe_unused)
 {
 	struct convert *c = container_of(tool, struct convert, tool);
+	struct evsel *evsel = sample->evsel;
 	struct evsel_priv *priv = evsel->priv;
 	struct ctf_writer *cw = &c->writer;
 	struct ctf_stream *cs;
diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index d526c91312ed..a7da93a7ff0e 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -159,13 +159,12 @@ static void output_sample_callchain_entry(const struct perf_tool *tool,
 static int process_sample_event(const struct perf_tool *tool,
 				union perf_event *event __maybe_unused,
 				struct perf_sample *sample,
-				struct evsel *evsel __maybe_unused,
 				struct machine *machine)
 {
 	struct convert_json *c = container_of(tool, struct convert_json, tool);
 	FILE *out = c->out;
 	struct addr_location al;
-	u64 sample_type = __evlist__combined_sample_type(evsel->evlist);
+	u64 sample_type = __evlist__combined_sample_type(sample->evsel->evlist);
 	u8 cpumode = PERF_RECORD_MISC_USER;
 
 	addr_location__init(&al);
@@ -245,7 +244,7 @@ static int process_sample_event(const struct perf_tool *tool,
 
 #ifdef HAVE_LIBTRACEEVENT
 	if (sample->raw_data) {
-		struct tep_event *tp_format = evsel__tp_format(evsel);
+		struct tep_event *tp_format = evsel__tp_format(sample->evsel);
 		struct tep_format_field **fields = tp_format ? tep_event_fields(tp_format) : NULL;
 
 		if (fields) {
diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 8b615dc94e9e..ed8cfe2ba2fa 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -185,7 +185,6 @@ static bool should_ignore_sample(const struct perf_sample *sample, const struct
 static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 				union perf_event *event __maybe_unused,
 				struct perf_sample *sample,
-				struct evsel *evsel,
 				struct machine *machine __maybe_unused)
 {
 	struct tpebs_retire_lat *t;
@@ -196,7 +195,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 		mutex_unlock(tpebs_mtx_get());
 		return 0;
 	}
-	t = tpebs_retire_lat__find(evsel);
+	t = tpebs_retire_lat__find(sample->evsel);
 	if (!t) {
 		mutex_unlock(tpebs_mtx_get());
 		return -EINVAL;
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index e0ce8b904729..52e6ffac2b3e 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -642,7 +642,7 @@ static int jit_repipe_code_move(struct jit_buf_desc *jd, union jr_entry *jr)
 
 	ret = jit_inject_event(jd, event);
 	if (!ret)
-		build_id__mark_dso_hit(tool, event, &sample, NULL, jd->machine);
+		build_id__mark_dso_hit(tool, event, &sample, jd->machine);
 out:
 	perf_sample__exit(&sample);
 	return ret;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index fe0de2a0277f..1e25892963b7 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1117,9 +1117,10 @@ char *get_page_size_name(u64 size, char *str)
 	return str;
 }
 
-static void dump_sample(struct machine *machine, struct evsel *evsel, union perf_event *event,
+static void dump_sample(struct machine *machine, union perf_event *event,
 			struct perf_sample *sample)
 {
+	struct evsel *evsel = sample->evsel;
 	u64 sample_type;
 	char str[PAGE_SIZE_NAME_LEN];
 	uint16_t e_machine = EM_NONE;
@@ -1183,9 +1184,10 @@ static void dump_sample(struct machine *machine, struct evsel *evsel, union perf
 		sample_read__printf(sample, evsel->core.attr.read_format);
 }
 
-static void dump_deferred_callchain(struct evsel *evsel, union perf_event *event,
-				    struct perf_sample *sample)
+static void dump_deferred_callchain(union perf_event *event, struct perf_sample *sample)
 {
+	struct evsel *evsel = sample->evsel;
+
 	if (!dump_trace)
 		return;
 
@@ -1291,7 +1293,7 @@ static int deliver_sample_value(struct evlist *evlist,
 		return 0;
 
 	sample->evsel = container_of(sid->evsel, struct evsel, core);
-	ret = tool->sample(tool, event, sample, sample->evsel, machine);
+	ret = tool->sample(tool, event, sample, machine);
 	sample->evsel = saved_evsel;
 	return ret;
 }
@@ -1323,8 +1325,9 @@ static int deliver_sample_group(struct evlist *evlist,
 
 static int evlist__deliver_sample(struct evlist *evlist, const struct perf_tool *tool,
 				  union  perf_event *event, struct perf_sample *sample,
-				  struct evsel *evsel, struct machine *machine)
+				  struct machine *machine)
 {
+	struct evsel *evsel = sample->evsel;
 	/* We know evsel != NULL. */
 	u64 sample_type = evsel->core.attr.sample_type;
 	u64 read_format = evsel->core.attr.read_format;
@@ -1332,7 +1335,7 @@ static int evlist__deliver_sample(struct evlist *evlist, const struct perf_tool
 
 	/* Standard sample delivery. */
 	if (!(sample_type & PERF_SAMPLE_READ))
-		return tool->sample(tool, event, sample, evsel, machine);
+		return tool->sample(tool, event, sample, machine);
 
 	/* For PERF_SAMPLE_READ we have either single or group mode. */
 	if (read_format & PERF_FORMAT_GROUP)
@@ -1371,8 +1374,7 @@ static int evlist__deliver_deferred_callchain(struct evlist *evlist,
 		struct evsel *saved_evsel = sample->evsel;
 
 		sample->evsel = evlist__id2evsel(evlist, sample->id);
-		ret = tool->callchain_deferred(tool, event, sample,
-					       sample->evsel, machine);
+		ret = tool->callchain_deferred(tool, event, sample, machine);
 		sample->evsel = saved_evsel;
 		return ret;
 	}
@@ -1400,7 +1402,7 @@ static int evlist__deliver_deferred_callchain(struct evlist *evlist,
 
 		orig_sample.evsel = evlist__id2evsel(evlist, orig_sample.id);
 		ret = evlist__deliver_sample(evlist, tool, de->event,
-					     &orig_sample, orig_sample.evsel, machine);
+					     &orig_sample, machine);
 
 		perf_sample__exit(&orig_sample);
 		list_del(&de->list);
@@ -1438,7 +1440,7 @@ static int session__flush_deferred_samples(struct perf_session *session,
 
 		sample.evsel = evlist__id2evsel(evlist, sample.id);
 		ret = evlist__deliver_sample(evlist, tool, de->event,
-					     &sample, sample.evsel, machine);
+					     &sample, machine);
 
 		perf_sample__exit(&sample);
 		list_del(&de->list);
@@ -1458,7 +1460,6 @@ static int machines__deliver_event(struct machines *machines,
 				   const struct perf_tool *tool, u64 file_offset,
 				   const char *file_path)
 {
-	struct evsel *evsel;
 	struct machine *machine;
 
 	dump_event(evlist, event, file_offset, sample, file_path);
@@ -1468,21 +1469,20 @@ static int machines__deliver_event(struct machines *machines,
 	else
 		assert(sample->evsel == evlist__id2evsel(evlist, sample->id));
 
-	evsel = sample->evsel;
 	machine = machines__find_for_cpumode(machines, event, sample);
 
 	switch (event->header.type) {
 	case PERF_RECORD_SAMPLE:
-		if (evsel == NULL) {
+		if (sample->evsel == NULL) {
 			++evlist->stats.nr_unknown_id;
 			return 0;
 		}
 		if (machine == NULL) {
 			++evlist->stats.nr_unprocessable_samples;
-			dump_sample(machine, evsel, event, sample);
+			dump_sample(machine, event, sample);
 			return 0;
 		}
-		dump_sample(machine, evsel, event, sample);
+		dump_sample(machine, event, sample);
 		if (sample->deferred_callchain && tool->merge_deferred_callchains) {
 			struct deferred_event *de = malloc(sizeof(*de));
 			size_t sz = event->header.size;
@@ -1499,7 +1499,7 @@ static int machines__deliver_event(struct machines *machines,
 			list_add_tail(&de->list, &evlist->deferred_samples);
 			return 0;
 		}
-		return evlist__deliver_sample(evlist, tool, event, sample, evsel, machine);
+		return evlist__deliver_sample(evlist, tool, event, sample, machine);
 	case PERF_RECORD_MMAP:
 		return tool->mmap(tool, event, sample, machine);
 	case PERF_RECORD_MMAP2:
@@ -1527,8 +1527,8 @@ static int machines__deliver_event(struct machines *machines,
 			evlist->stats.total_lost_samples += event->lost_samples.lost;
 		return tool->lost_samples(tool, event, sample, machine);
 	case PERF_RECORD_READ:
-		dump_read(evsel, event);
-		return tool->read(tool, event, sample, evsel, machine);
+		dump_read(sample->evsel, event);
+		return tool->read(tool, event, sample, machine);
 	case PERF_RECORD_THROTTLE:
 		return tool->throttle(tool, event, sample, machine);
 	case PERF_RECORD_UNTHROTTLE:
@@ -1557,7 +1557,7 @@ static int machines__deliver_event(struct machines *machines,
 	case PERF_RECORD_AUX_OUTPUT_HW_ID:
 		return tool->aux_output_hw_id(tool, event, sample, machine);
 	case PERF_RECORD_CALLCHAIN_DEFERRED:
-		dump_deferred_callchain(evsel, event, sample);
+		dump_deferred_callchain(event, sample);
 		return evlist__deliver_deferred_callchain(evlist, tool, event,
 							  sample, machine);
 	default:
diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
index 013c7839e2cf..0f285a2574c8 100644
--- a/tools/perf/util/tool.c
+++ b/tools/perf/util/tool.c
@@ -110,7 +110,6 @@ static int process_event_synth_event_update_stub(const struct perf_tool *tool __
 int process_event_sample_stub(const struct perf_tool *tool __maybe_unused,
 			      union perf_event *event __maybe_unused,
 			      struct perf_sample *sample __maybe_unused,
-			      struct evsel *evsel __maybe_unused,
 			      struct machine *machine __maybe_unused)
 {
 	dump_printf(": unhandled!\n");
@@ -348,12 +347,11 @@ bool perf_tool__compressed_is_stub(const struct perf_tool *tool)
 	static int delegate_ ## name(const struct perf_tool *tool, \
 				     union perf_event *event, \
 				     struct perf_sample *sample, \
-				     struct evsel *evsel, \
 				     struct machine *machine) \
 	{								\
 		struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool); \
 		struct perf_tool *delegate = del_tool->delegate;		\
-		return delegate->name(delegate, event, sample, evsel, machine);	\
+		return delegate->name(delegate, event, sample, machine);	\
 	}
 CREATE_DELEGATE_SAMPLE(read);
 CREATE_DELEGATE_SAMPLE(sample);
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 2d9a4b1ca9d0..2a4f124ffd8d 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -9,7 +9,6 @@
 struct perf_session;
 union perf_event;
 struct evlist;
-struct evsel;
 struct perf_sample;
 struct perf_tool;
 struct machine;
@@ -17,7 +16,7 @@ struct ordered_events;
 
 typedef int (*event_sample)(const struct perf_tool *tool, union perf_event *event,
 			    struct perf_sample *sample,
-			    struct evsel *evsel, struct machine *machine);
+			    struct machine *machine);
 
 typedef int (*event_op)(const struct perf_tool *tool, union perf_event *event,
 			struct perf_sample *sample, struct machine *machine);
@@ -103,7 +102,6 @@ bool perf_tool__compressed_is_stub(const struct perf_tool *tool);
 int process_event_sample_stub(const struct perf_tool *tool,
 			      union perf_event *event,
 			      struct perf_sample *sample,
-			      struct evsel *evsel,
 			      struct machine *machine);
 
 struct delegate_tool {
-- 
2.53.0.1213.gd9a14994de-goog

