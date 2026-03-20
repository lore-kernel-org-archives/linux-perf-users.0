Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655DA3F1654
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 19:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034895; cv=none; b=Smw9e3cxc8ku6hyZ8RBd7x1tfIVkLbCD/bmX4taT977XJ88IF606iELNLlZK3AV7jSHSzdtDR/3JlSU+18RS0OB9J4jQPN8tlp+hTpaspWKv6xEhYqsNKN1LSqj0dsiuv7usX/ZWZo153Ps6BRrXzE8Fuvxd/DL1Ms70sYiNHNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034895; c=relaxed/simple;
	bh=Kqc9QmL6LV+9FM4lpjKWq2izRvGN8tKcPB8/7mTJxIw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UCe/AJHmTqoExYFOttvMqzsBBfaXlcm2jOjY8h4H583BxiydtbxzTD0/0/fFumzxVHILXOXg1Xsm9CId+MXujjcpg6qzjDzuZ5ZrCVZrsGLVuXXoJkx4QomjwRKKKsTKpApp82Kxvd10AAi05hv8QJyqmSMaXkkMjDqreBGj50I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H5kCwrVZ; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H5kCwrVZ"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c105e5ac70so940120eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 12:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774034888; x=1774639688; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mFL/oBsMTU0tz3/2XZ049tOen9MrhqAUABmBQfa09wo=;
        b=H5kCwrVZtpIAN98+cVZQDIjLlt0wMVel6Piyib1DE263W5o7pnbG2WQdo7q7MFrQSP
         9mbSH6p6c2R68eakW6vEALhOwexpypITK7H0EqCpJLeY8baa1pRX5LyXxiQgLOHQk9Mk
         ZTp+9NglbHBoa9G1AIkDdKWn6HMXq3VDPIkkGPHmjTVDWTWHrQYh5+WOr6PHmygSZFW1
         FEkwFT2Z354HmADCGdJQ7nzKfllCJ4Q/pnN+B/37th9EJKf0L5SH9D7E6//TeW9B9Ped
         igATbtoSwLOyqCnROWul6/u+nESg9tqb7Dysv4p1Ai5LuubjuyHxDyrcEUZGWLiWcIxi
         iVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034888; x=1774639688;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mFL/oBsMTU0tz3/2XZ049tOen9MrhqAUABmBQfa09wo=;
        b=QGAQHSLfkN2HW/bZIDycEEYTTlmWJt1jKNp2E5nK7wKrvJpyBlrCcLoZOshRCC7sHf
         8YrYDwD60w9WQWPvH3JhQ7PmEtZ7FtwDCAiZaEyWX1EcpVgCvdj4k7N0gBAklaUfWeqk
         qSKtG+BTPRBKs+O5UczIitZm12lcINE6L8m8ubi9f02K68277T43hn6+a5YsgXwbviGn
         6QGrspKcmoAuKHIFhZJrl606BwJ0bir0TcEcLWAyHZ/MbAHQz+GAEbThfzq2rd58FgPq
         LFM6UHiDz5GL4AMVoG3qoJarYBh07+BHqKb8FHyYRYwsvxcFimtSwJGhAbJdmGnHpTqf
         pivQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZKAl0kWrcyK/g6zAAyj01DClZa7AWCgVXeYkxCXp676Ni0zLW+uqg4URAAVYhYGVdCHE1KtRLa+Q181jJwGV8@vger.kernel.org
X-Gm-Message-State: AOJu0YypmVhBdqEEpp8AWAaShq4Fsk9JqSHcIQ9NLiTfAlqRAuxVldBB
	MMveVTfjJNbiXy/EhhWpEFfioQYCq0yjqtbNBkuJqWkQVuTU7NLxdEdRkJExyUcQlchpB8kBy1V
	cy/3XYLbQeA==
X-Received: from dycno10.prod.google.com ([2002:a05:7301:144a:b0:2c1:abe:76cb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:3252:b0:2c0:c55c:1574
 with SMTP id 5a478bee46e88-2c109752b38mr1637203eec.21.1774034887934; Fri, 20
 Mar 2026 12:28:07 -0700 (PDT)
Date: Fri, 20 Mar 2026 12:26:06 -0700
In-Reply-To: <20260320192627.368357-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320080835.724836-1-irogers@google.com> <20260320192627.368357-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320192627.368357-5-irogers@google.com>
Subject: [PATCH v4 04/25] perf tool: Remove evsel from tool APIs that pass the sample
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
index 686ad08561d6..c97a0fe159f8 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -284,7 +284,6 @@ static int evsel__add_sample(struct evsel *evsel, struct perf_sample *sample,
 static int process_sample_event(const struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
-				struct evsel *evsel,
 				struct machine *machine)
 {
 	struct perf_annotate *ann = container_of(tool, struct perf_annotate, tool);
@@ -303,7 +302,7 @@ static int process_sample_event(const struct perf_tool *tool,
 		goto out_put;
 
 	if (!al.filtered &&
-	    evsel__add_sample(evsel, sample, &al, ann, machine)) {
+	    evsel__add_sample(sample->evsel, sample, &al, ann, machine)) {
 		pr_warning("problem incrementing symbol count, "
 			   "skipping event\n");
 		ret = -1;
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index d390ae4e3ec8..89456ba6fcbb 100644
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
index 69069926dd0b..096adc65451c 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -390,11 +390,11 @@ struct hist_entry_ops block_hist_ops = {
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
index b7ecf78ef79b..8de152039f84 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -363,18 +363,17 @@ typedef int (*inject_handler)(const struct perf_tool *tool,
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
@@ -388,10 +387,10 @@ static int perf_event__repipe_sample(const struct perf_tool *tool,
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
@@ -988,10 +987,8 @@ static int mark_dso_hit_callback(struct callchain_cursor_node *node, void *data)
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
@@ -1021,7 +1018,7 @@ int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *e
 			     /*sample_in_dso=*/true);
 	}
 
-	sample__for_each_callchain_node(thread, evsel, sample, PERF_MAX_STACK_DEPTH,
+	sample__for_each_callchain_node(thread, sample->evsel, sample, PERF_MAX_STACK_DEPTH,
 					/*symbols=*/false, mark_dso_hit_callback, &args);
 	thread__put(thread);
 repipe:
@@ -1102,7 +1099,7 @@ static int perf_inject__sched_stat(const struct perf_tool *tool,
 	sample_sw.time	 = sample->time;
 	perf_event__synthesize_sample(event_sw, evsel->core.attr.sample_type,
 				      evsel->core.attr.read_format, &sample_sw);
-	build_id__mark_dso_hit(tool, event_sw, &sample_sw, evsel, machine);
+	build_id__mark_dso_hit(tool, event_sw, &sample_sw, machine);
 	ret = perf_event__repipe(tool, event_sw, &sample_sw, machine);
 	perf_sample__exit(&sample_sw);
 	return ret;
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 7929a5fa5f46..34852a4c3fc8 100644
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
index 6f94a8f45f60..e34a1f35439e 100644
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
index e8962c985d34..dc8d1d3b4cd7 100644
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
index 40917a0be238..09d6af344f3e 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1488,7 +1488,6 @@ static void set_timestamp_boundary(struct record *rec, u64 sample_time)
 static int process_sample_event(const struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
-				struct evsel *evsel,
 				struct machine *machine)
 {
 	struct record *rec = container_of(tool, struct record, tool);
@@ -1499,7 +1498,7 @@ static int process_sample_event(const struct perf_tool *tool,
 		return 0;
 
 	rec->samples++;
-	return build_id__mark_dso_hit(tool, event, sample, evsel, machine);
+	return build_id__mark_dso_hit(tool, event, sample, machine);
 }
 
 static int process_buildids(struct record *rec)
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 343c0ada5ea1..507002cbdd5b 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -269,10 +269,10 @@ static int process_feature_event(const struct perf_tool *tool,
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
@@ -349,7 +349,6 @@ static int process_sample_event(const struct perf_tool *tool,
 static int process_read_event(const struct perf_tool *tool,
 			      union perf_event *event,
 			      struct perf_sample *sample __maybe_unused,
-			      struct evsel *evsel,
 			      struct machine *machine __maybe_unused)
 {
 	struct report *rep = container_of(tool, struct report, tool);
@@ -357,7 +356,7 @@ static int process_read_event(const struct perf_tool *tool,
 	if (rep->show_threads) {
 		int err = perf_read_values_add_value(&rep->show_threads_values,
 					   event->read.pid, event->read.tid,
-					   evsel,
+					   sample->evsel,
 					   event->read.value);
 
 		if (err)
@@ -783,11 +782,10 @@ static void report__output_resort(struct report *rep)
 
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
index d083e2bb7703..296b9837278a 100644
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
index 8c3d06a3db62..8724c4ab3e88 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2644,10 +2644,10 @@ static bool filter_cpu(struct perf_sample *sample)
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
@@ -2728,10 +2728,10 @@ static int process_sample_event(const struct perf_tool *tool,
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
index 1c38f3d16a31..e86a3d375757 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3462,10 +3462,10 @@ static void trace__set_base_time(struct trace *trace,
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
index ba1c8e48d495..32e2173b86e3 100644
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
index 6a626322476a..d1f931ee565a 100644
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
index 2af5455488b2..01e030862d5d 100644
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
index 3794d3a04afb..150398b383fe 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1110,9 +1110,10 @@ char *get_page_size_name(u64 size, char *str)
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
@@ -1176,9 +1177,10 @@ static void dump_sample(struct machine *machine, struct evsel *evsel, union perf
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
 
@@ -1284,7 +1286,7 @@ static int deliver_sample_value(struct evlist *evlist,
 		return 0;
 
 	sample->evsel = container_of(sid->evsel, struct evsel, core);
-	ret = tool->sample(tool, event, sample, sample->evsel, machine);
+	ret = tool->sample(tool, event, sample, machine);
 	sample->evsel = saved_evsel;
 	return ret;
 }
@@ -1316,8 +1318,9 @@ static int deliver_sample_group(struct evlist *evlist,
 
 static int evlist__deliver_sample(struct evlist *evlist, const struct perf_tool *tool,
 				  union  perf_event *event, struct perf_sample *sample,
-				  struct evsel *evsel, struct machine *machine)
+				  struct machine *machine)
 {
+	struct evsel *evsel = sample->evsel;
 	/* We know evsel != NULL. */
 	u64 sample_type = evsel->core.attr.sample_type;
 	u64 read_format = evsel->core.attr.read_format;
@@ -1325,7 +1328,7 @@ static int evlist__deliver_sample(struct evlist *evlist, const struct perf_tool
 
 	/* Standard sample delivery. */
 	if (!(sample_type & PERF_SAMPLE_READ))
-		return tool->sample(tool, event, sample, evsel, machine);
+		return tool->sample(tool, event, sample, machine);
 
 	/* For PERF_SAMPLE_READ we have either single or group mode. */
 	if (read_format & PERF_FORMAT_GROUP)
@@ -1364,8 +1367,7 @@ static int evlist__deliver_deferred_callchain(struct evlist *evlist,
 		struct evsel *saved_evsel = sample->evsel;
 
 		sample->evsel = evlist__id2evsel(evlist, sample->id);
-		ret = tool->callchain_deferred(tool, event, sample,
-					       sample->evsel, machine);
+		ret = tool->callchain_deferred(tool, event, sample, machine);
 		sample->evsel = saved_evsel;
 		return ret;
 	}
@@ -1393,7 +1395,7 @@ static int evlist__deliver_deferred_callchain(struct evlist *evlist,
 
 		orig_sample.evsel = evlist__id2evsel(evlist, orig_sample.id);
 		ret = evlist__deliver_sample(evlist, tool, de->event,
-					     &orig_sample, orig_sample.evsel, machine);
+					     &orig_sample, machine);
 
 		perf_sample__exit(&orig_sample);
 		list_del(&de->list);
@@ -1431,7 +1433,7 @@ static int session__flush_deferred_samples(struct perf_session *session,
 
 		sample.evsel = evlist__id2evsel(evlist, sample.id);
 		ret = evlist__deliver_sample(evlist, tool, de->event,
-					     &sample, sample.evsel, machine);
+					     &sample, machine);
 
 		perf_sample__exit(&sample);
 		list_del(&de->list);
@@ -1451,7 +1453,6 @@ static int machines__deliver_event(struct machines *machines,
 				   const struct perf_tool *tool, u64 file_offset,
 				   const char *file_path)
 {
-	struct evsel *evsel;
 	struct machine *machine;
 
 	dump_event(evlist, event, file_offset, sample, file_path);
@@ -1461,21 +1462,20 @@ static int machines__deliver_event(struct machines *machines,
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
@@ -1492,7 +1492,7 @@ static int machines__deliver_event(struct machines *machines,
 			list_add_tail(&de->list, &evlist->deferred_samples);
 			return 0;
 		}
-		return evlist__deliver_sample(evlist, tool, event, sample, evsel, machine);
+		return evlist__deliver_sample(evlist, tool, event, sample, machine);
 	case PERF_RECORD_MMAP:
 		return tool->mmap(tool, event, sample, machine);
 	case PERF_RECORD_MMAP2:
@@ -1520,8 +1520,8 @@ static int machines__deliver_event(struct machines *machines,
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
@@ -1550,7 +1550,7 @@ static int machines__deliver_event(struct machines *machines,
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
2.53.0.959.g497ff81fa9-goog

