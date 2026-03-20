Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75DA36F400
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 08:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994127; cv=none; b=Xw85TkafwwV/gVj6rX8L9+IL6AmS0dgTeruk+ifcsZy3Cmb2g+cbuXH2/U27bsIJygQ95YGmKWb1oC3RwPL5XjFZPCYcbLSyrkh4tpDUZGVQYWlUb4eGdBI9vKSRtBRdlTFgsEjIzz1v3t2mrM867SW+OKmWF9ar6sk1bRQwAns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994127; c=relaxed/simple;
	bh=/sSTCF+kDUcJ8dUXBQ4PAgNsqhMyoryJFN/IyjOtee4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K+OM5yP70ZjAwR1blFJm4G1R8naP8Z7qiMR7VFNYFoGiQwJZdQcixyIgWv/551w9BF2YP9FwAuXou+jaERkEwFzai9vJfRQBycy4mD5UNVq6J2wdDyhnKdS011xF0Dj708saABB/1FQ5zbH3lAWnnOK59l9Ch6iAx+HGDvx2DUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JUi/KbpX; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JUi/KbpX"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so1853084eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 01:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773994125; x=1774598925; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1QHyQpM2o6f8NAXtrrQJtdo8v5lvErK1d/WfnTFLwyg=;
        b=JUi/KbpXgE7GgKdOFrDlefXw08vzZ4EIRfaZJnMBAprmpOr6LeGXk545jvU+J4ZBfp
         kQQq1TWWYmeRqnpskO8CXYrSKF1x6fF35l/jhI0kFneLYnOgkpRz495/iSn/wj3o9dtf
         Q3IgibzMODtdfK4qy2cQMH1Sl83nfqlErQMT0BRYPz788AWq7SnKN5Mq9KxGlc/azRxP
         ICYb4hODTn+F6ZltVY2sLbF9/xX90KjKcwguSyN51r+d+8eQljxuBEjMBOUYldB+vvik
         JDnSvT3uenPrwW6hluLazIG9R2Y5OCGrDWjj7LBykyNO7+wqq/cT3hHKbjxtjIKAXAoF
         Bp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773994125; x=1774598925;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1QHyQpM2o6f8NAXtrrQJtdo8v5lvErK1d/WfnTFLwyg=;
        b=hA36FkeaTQER1AP0gwhrtsRRakBdr7ZDx+wYDqmqzVFkKQwPgTs0n0RVr8yZ7zXTz7
         +M76bMM+/3IDIpzrwLd3kAKxCbte4muPu7EUo+4J/UFjnYXiQ/FOHlCKV7vFijvMF6uf
         3Mu69kqr3Ilk5uzxsyS1rnDZxu0I88Gv9YmPWyTWkzXmRJ3+eJvbSa1o/3tP/r+TX1en
         xs+xTcgzSW/TSoPbDMvzOJz+eaHAlpLRA+X8WnY/AA/Q7qFatwWqLCPEhxtMpjHAnlOi
         F5TiDFyGodzEtWFgeU2BoeC8t36GlC4XuQOkDt3NgBwgIpOkTAQhLfsmOP+6ASkDTW8J
         q+og==
X-Forwarded-Encrypted: i=1; AJvYcCWD3BTgxNQjV5OehVWsilLXoaCsWlFMMx29k1ZJvSA9o7OYW/1zw59bvfPtRExMJIQNYIB8GQ7Eb9DJYV+E2Nfk@vger.kernel.org
X-Gm-Message-State: AOJu0YyBPWtoOp7G2bQXF0+X4KzsEKj62nWwbpXNUzs+z2gsZLDGd972
	Y0NKuyxTvWnFrde0x2IpJfX6XnDCCfSyOkDJ/0j45WrjKQo0OYcnAcWbz4ALZs3btW6cp1x2Ry9
	xTe33A2CDjg==
X-Received: from dybso14.prod.google.com ([2002:a05:7301:690e:b0:2c0:b988:33bc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:4342:b0:2ae:5e93:b69
 with SMTP id 5a478bee46e88-2c1097a59f3mr1125101eec.29.1773994124528; Fri, 20
 Mar 2026 01:08:44 -0700 (PDT)
Date: Fri, 20 Mar 2026 01:08:12 -0700
In-Reply-To: <20260320080835.724836-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260319232334.287517-1-irogers@google.com> <20260320080835.724836-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320080835.724836-4-irogers@google.com>
Subject: [PATCH v3 03/25] perf sample: Add evsel to struct perf_sample
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

Add the evsel from evsel__parse_sample into the struct
perf_sample. Sometimes we want to alter the evsel associated with a
sample, such as with off-cpu bpf-output events. In general the evsel
and perf_sample are passed as a pair, but this makes an altered evsel
something of a chore to keep checking for and setting up. Later
patches will remove passing an evsel with the perf_sample and switch
to just using the perf_sample's value.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c       |  9 +++++---
 tools/perf/builtin-script.c       |  4 ++++
 tools/perf/tests/hists_cumulate.c |  2 +-
 tools/perf/tests/hists_filter.c   |  1 +
 tools/perf/tests/hists_output.c   |  2 +-
 tools/perf/util/evsel.c           |  1 +
 tools/perf/util/sample.c          |  1 +
 tools/perf/util/sample.h          |  3 +++
 tools/perf/util/session.c         | 35 +++++++++++++++++++------------
 9 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 039323908ebf..52d74542f65f 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -133,7 +133,7 @@ struct perf_inject {
 	struct perf_file_section secs[HEADER_FEAT_BITS];
 	struct guest_session	guest_session;
 	struct strlist		*known_build_ids;
-	const struct evsel	*mmap_evsel;
+	struct evsel		*mmap_evsel;
 	struct ip_callchain	*raw_callchain;
 };
 
@@ -519,7 +519,7 @@ static struct dso *findnew_dso(int pid, int tid, const char *filename,
  * processing mmap events. If not stashed, search the evlist for the first mmap
  * gathering event.
  */
-static const struct evsel *inject__mmap_evsel(struct perf_inject *inject)
+static struct evsel *inject__mmap_evsel(struct perf_inject *inject)
 {
 	struct evsel *pos;
 
@@ -1007,6 +1007,7 @@ int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *e
 		.machine = machine,
 		.mmap_evsel = inject__mmap_evsel(inject),
 	};
+	struct evsel *saved_evsel = sample->evsel;
 
 	addr_location__init(&al);
 	thread = machine__findnew_thread(machine, sample->pid, sample->tid);
@@ -1016,6 +1017,7 @@ int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *e
 		goto repipe;
 	}
 
+	sample->evsel = inject__mmap_evsel(inject);
 	if (thread__find_map(thread, sample->cpumode, sample->ip, &al)) {
 		mark_dso_hit(inject, tool, sample, machine, args.mmap_evsel, al.map,
 			     /*sample_in_dso=*/true);
@@ -1023,7 +1025,7 @@ int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *e
 
 	sample__for_each_callchain_node(thread, evsel, sample, PERF_MAX_STACK_DEPTH,
 					/*symbols=*/false, mark_dso_hit_callback, &args);
-
+	sample->evsel = saved_evsel;
 	thread__put(thread);
 repipe:
 	perf_event__repipe(tool, event, sample, machine);
@@ -1432,6 +1434,7 @@ static int synthesize_build_id(struct perf_inject *inject, struct dso *dso, pid_
 {
 	struct machine *machine = perf_session__findnew_machine(inject->session, machine_pid);
 	struct perf_sample synth_sample = {
+		.evsel	   = inject__mmap_evsel(inject),
 		.pid	   = -1,
 		.tid	   = -1,
 		.time	   = -1,
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index b80c406d1fc1..8c3d06a3db62 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2909,8 +2909,12 @@ static int print_event_with_time(const struct perf_tool *tool,
 		thread = machine__findnew_thread(machine, pid, tid);
 
 	if (evsel) {
+		struct evsel *saved_evsel = sample->evsel;
+
+		sample->evsel = evsel;
 		perf_sample__fprintf_start(script, sample, thread, evsel,
 					   event->header.type, stdout);
+		sample->evsel = saved_evsel;
 	}
 
 	perf_event__fprintf(event, machine, stdout);
diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_cumulate.c
index 3eb9ef8d7ec6..606aa926a8fc 100644
--- a/tools/perf/tests/hists_cumulate.c
+++ b/tools/perf/tests/hists_cumulate.c
@@ -81,7 +81,7 @@ static int add_hist_entries(struct hists *hists, struct machine *machine)
 {
 	struct addr_location al;
 	struct evsel *evsel = hists_to_evsel(hists);
-	struct perf_sample sample = { .period = 1000, };
+	struct perf_sample sample = { .evsel = evsel, .period = 1000, };
 	size_t i;
 
 	addr_location__init(&al);
diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/hists_filter.c
index 1cebd20cc91c..cc6b26e373d1 100644
--- a/tools/perf/tests/hists_filter.c
+++ b/tools/perf/tests/hists_filter.c
@@ -70,6 +70,7 @@ static int add_hist_entries(struct evlist *evlist,
 			};
 			struct hists *hists = evsel__hists(evsel);
 
+			sample.evsel = evsel;
 			/* make sure it has no filter at first */
 			hists->thread_filter = NULL;
 			hists->dso_filter = NULL;
diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/hists_output.c
index ee5ec8bda60e..7818950d786e 100644
--- a/tools/perf/tests/hists_output.c
+++ b/tools/perf/tests/hists_output.c
@@ -51,7 +51,7 @@ static int add_hist_entries(struct hists *hists, struct machine *machine)
 {
 	struct addr_location al;
 	struct evsel *evsel = hists_to_evsel(hists);
-	struct perf_sample sample = { .period = 100, };
+	struct perf_sample sample = { .evsel = evsel, .period = 100, };
 	size_t i;
 
 	addr_location__init(&al);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 59efe460d9bc..29b1df875953 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3220,6 +3220,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	union u64_swap u;
 
 	perf_sample__init(data, /*all=*/true);
+	data->evsel = evsel;
 	data->cpu = data->pid = data->tid = -1;
 	data->stream_id = data->id = data->time = -1ULL;
 	data->period = evsel->core.attr.sample_period;
diff --git a/tools/perf/util/sample.c b/tools/perf/util/sample.c
index 2a30de4573f6..cf73329326d7 100644
--- a/tools/perf/util/sample.c
+++ b/tools/perf/util/sample.c
@@ -19,6 +19,7 @@ void perf_sample__init(struct perf_sample *sample, bool all)
 	if (all) {
 		memset(sample, 0, sizeof(*sample));
 	} else {
+		sample->evsel = NULL;
 		sample->user_regs = NULL;
 		sample->intr_regs = NULL;
 		sample->merged_callchain = false;
diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index 5809c42631e5..3bd6d8b60586 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -5,6 +5,7 @@
 #include <linux/perf_event.h>
 #include <linux/types.h>
 
+struct evsel;
 struct machine;
 struct thread;
 
@@ -102,6 +103,8 @@ struct simd_flags {
  * and clean up these values.
  */
 struct perf_sample {
+	/** @evsel: Backward reference to the evsel used when constructing the sample. */
+	struct evsel *evsel;
 	/** @ip: The sample event PERF_SAMPLE_IP value. */
 	u64 ip;
 	/** @pid: The sample event PERF_SAMPLE_TID pid value. */
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index c48e840da7d4..3794d3a04afb 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1257,8 +1257,9 @@ static int deliver_sample_value(struct evlist *evlist,
 				bool per_thread)
 {
 	struct perf_sample_id *sid = evlist__id2sid(evlist, v->id);
-	struct evsel *evsel;
+	struct evsel *saved_evsel = sample->evsel;
 	u64 *storage = NULL;
+	int ret;
 
 	if (sid) {
 		storage = perf_sample_id__get_period_storage(sid, sample->tid, per_thread);
@@ -1282,8 +1283,10 @@ static int deliver_sample_value(struct evlist *evlist,
 	if (!sample->period)
 		return 0;
 
-	evsel = container_of(sid->evsel, struct evsel, core);
-	return tool->sample(tool, event, sample, evsel, machine);
+	sample->evsel = container_of(sid->evsel, struct evsel, core);
+	ret = tool->sample(tool, event, sample, sample->evsel, machine);
+	sample->evsel = saved_evsel;
+	return ret;
 }
 
 static int deliver_sample_group(struct evlist *evlist,
@@ -1355,13 +1358,16 @@ static int evlist__deliver_deferred_callchain(struct evlist *evlist,
 					      struct machine *machine)
 {
 	struct deferred_event *de, *tmp;
-	struct evsel *evsel;
 	int ret = 0;
 
 	if (!tool->merge_deferred_callchains) {
-		evsel = evlist__id2evsel(evlist, sample->id);
-		return tool->callchain_deferred(tool, event, sample,
-						evsel, machine);
+		struct evsel *saved_evsel = sample->evsel;
+
+		sample->evsel = evlist__id2evsel(evlist, sample->id);
+		ret = tool->callchain_deferred(tool, event, sample,
+					       sample->evsel, machine);
+		sample->evsel = saved_evsel;
+		return ret;
 	}
 
 	list_for_each_entry_safe(de, tmp, &evlist->deferred_samples, list) {
@@ -1385,9 +1391,9 @@ static int evlist__deliver_deferred_callchain(struct evlist *evlist,
 		else
 			orig_sample.deferred_callchain = false;
 
-		evsel = evlist__id2evsel(evlist, orig_sample.id);
+		orig_sample.evsel = evlist__id2evsel(evlist, orig_sample.id);
 		ret = evlist__deliver_sample(evlist, tool, de->event,
-					     &orig_sample, evsel, machine);
+					     &orig_sample, orig_sample.evsel, machine);
 
 		perf_sample__exit(&orig_sample);
 		list_del(&de->list);
@@ -1410,7 +1416,6 @@ static int session__flush_deferred_samples(struct perf_session *session,
 	struct evlist *evlist = session->evlist;
 	struct machine *machine = &session->machines.host;
 	struct deferred_event *de, *tmp;
-	struct evsel *evsel;
 	int ret = 0;
 
 	list_for_each_entry_safe(de, tmp, &evlist->deferred_samples, list) {
@@ -1424,9 +1429,9 @@ static int session__flush_deferred_samples(struct perf_session *session,
 			break;
 		}
 
-		evsel = evlist__id2evsel(evlist, sample.id);
+		sample.evsel = evlist__id2evsel(evlist, sample.id);
 		ret = evlist__deliver_sample(evlist, tool, de->event,
-					     &sample, evsel, machine);
+					     &sample, sample.evsel, machine);
 
 		perf_sample__exit(&sample);
 		list_del(&de->list);
@@ -1451,8 +1456,12 @@ static int machines__deliver_event(struct machines *machines,
 
 	dump_event(evlist, event, file_offset, sample, file_path);
 
-	evsel = evlist__id2evsel(evlist, sample->id);
+	if (!sample->evsel)
+		sample->evsel = evlist__id2evsel(evlist, sample->id);
+	else
+		assert(sample->evsel == evlist__id2evsel(evlist, sample->id));
 
+	evsel = sample->evsel;
 	machine = machines__find_for_cpumode(machines, event, sample);
 
 	switch (event->header.type) {
-- 
2.53.0.959.g497ff81fa9-goog

