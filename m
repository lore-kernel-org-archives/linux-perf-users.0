Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4643D5251
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Apr 2026 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775248834; cv=none; b=f29N1AYWNyRDyYFySUu426La8H2u14fOZA0NPShNXlAp9jCVYcD2FBVf++jt60Rh4h1QLE6k9m9pCfTy8gBJTwQqcZUGytJ9bEuh6/lz5bE5H/n41emRkMWHMtdPy+JKp4J2JyMEl9eZ3mKlj5u5FvYhkrdEIHeW0j9s5BcxbFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775248834; c=relaxed/simple;
	bh=HUio6EFUcFG35wrQDexFicGMbtJ1iLBBli9+kdb2WfM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CDBuVFbw8zx7UPVtqrmw7jJMMaq0KY4NwD5qzftPDbh8v0XsjMyeLLW7XvYjsmQ0BsWxD5lq/+YzU/RXEVpwU7siRR2qdM4lN44tFDNwXitTSHrgvbHzWrH0sdHMOT3RrjF9tNAImIbwnOL4qtd6xFl138iyGTKyAK52p1fP3Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=etued1T2; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="etued1T2"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12bf921cf49so1977891c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 13:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775248832; x=1775853632; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/SN7H8nXQq0V7cxVTogrrT4hkaEDxSVli8PkUD/+JiU=;
        b=etued1T2CXC5DZLPc01a7/NRa6VTSjMmraW3GA1l9OXugZJqhBCsJhrHSYjBkim0sY
         jROJTHBisojGyUJMSxuOfLrxfElBr6CONRMyGTolvTv/OScfwQ/+DwuQNWBxb3H0pSk5
         rBPx+XJuNwV035SGGC1TfjYjbmNs17jaW37ttavxh18MkAFPIBa/2/YWmltu3UAeH1aL
         bCHtmjTubYrNOlBty8qro1hFd3St6nTiH1LgGRYjgDEOsIHS6r2UFpiuOCHRGt/CvUeM
         wq5xsmPjO5VmxWp9qNQ3LH8p9UibKeT9uWPbf9rKc7xYQ1vkSW/PvOiu1HmuAt2E3qGm
         qlow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775248832; x=1775853632;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/SN7H8nXQq0V7cxVTogrrT4hkaEDxSVli8PkUD/+JiU=;
        b=CEblax/A4yjpTnh6BEXq9hnjxqLH2DloawBYwoq11d7B4lIP9qSVaxGz/OAkEhuM8k
         cIva4tnFHjkmnXK6HrGBlFyMaLu/aj/DlSGLPFAr5pIR44InI5+R9jayursuQoM/9p3y
         g4l1sYM0vF2eQbRcFus1P764j0V9hsOPi1v+z3l/r5xGsoi1L2KIYBpQlU1XangTMGkM
         7exVtmHKHQGcpZa+KWKtv9+BLcreGSXdCBiymJZdpNyd/Zzb1LCTVbpdPvY+z813fqvA
         qMyxphOgPG3Ml+gjK0sBuSJSgN31FNKlBvFz/a7n0HH7t8EGts4LrKglVw6a+qpv5Df4
         D7sA==
X-Forwarded-Encrypted: i=1; AJvYcCUxYb3cY/E6FkqmLStZTEhE/Dh9T04XpBI7WrYxGV5BciE0gFxQan8bkDdgYKq1GTwylRNVgO29Cjo1o6glKPMg@vger.kernel.org
X-Gm-Message-State: AOJu0YwYxo0YwXmGtHKSvMFHXizEgEILyZ0q8H795jZRclaCzXEb5Kw0
	X+eZagn4iZBjuQ0ZMhCdYloB3W1U6dpVCy/Jgb2J5bxd+/uDXOV2Df7w1bntqO6r0nAhdb3Jqp4
	+jo1clZoHYw==
X-Received: from dldoa12.prod.google.com ([2002:a05:701a:ca8c:b0:128:ed1b:481d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6613:b0:127:9e95:a2f
 with SMTP id a92af1059eb24-12bfb6e7cd2mr1980208c88.2.1775248831384; Fri, 03
 Apr 2026 13:40:31 -0700 (PDT)
Date: Fri,  3 Apr 2026 13:39:55 -0700
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
Message-ID: <20260403204017.2919994-4-irogers@google.com>
Subject: [PATCH v5 03/25] perf sample: Add evsel to struct perf_sample
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

Add the evsel from evsel__parse_sample into the struct
perf_sample. Sometimes we want to alter the evsel associated with a
sample, such as with off-cpu bpf-output events. In general the evsel
and perf_sample are passed as a pair, but this makes an altered evsel
something of a chore to keep checking for and setting up. Later
patches will remove passing an evsel with the perf_sample and switch
to just using the perf_sample's value.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c       |  6 +++---
 tools/perf/builtin-script.c       |  4 ++++
 tools/perf/tests/hists_cumulate.c |  2 +-
 tools/perf/tests/hists_filter.c   |  1 +
 tools/perf/tests/hists_output.c   |  2 +-
 tools/perf/util/evsel.c           |  1 +
 tools/perf/util/sample.c          |  1 +
 tools/perf/util/sample.h          |  3 +++
 tools/perf/util/session.c         | 35 +++++++++++++++++++------------
 9 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index d63191ae4c5b..05b769a2a825 100644
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
 
@@ -1023,7 +1023,6 @@ int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *e
 
 	sample__for_each_callchain_node(thread, evsel, sample, PERF_MAX_STACK_DEPTH,
 					/*symbols=*/false, mark_dso_hit_callback, &args);
-
 	thread__put(thread);
 repipe:
 	perf_event__repipe(tool, event, sample, machine);
@@ -1432,6 +1431,7 @@ static int synthesize_build_id(struct perf_inject *inject, struct dso *dso, pid_
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
index 4d3615d7b885..33b9a4c284ad 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3225,6 +3225,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
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
2.53.0.1213.gd9a14994de-goog

