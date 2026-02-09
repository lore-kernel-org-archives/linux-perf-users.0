Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1509D387353
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658850; cv=none; b=PxeK9Y+akQvVBHwprMkEPgpIvX1nFt7GN9SHCaqIDJjPoeRFrj5r3aUuMIYOmAOVt2FQa1cJ2xHVsyPT1x37/m+vURlFl6B//YQVMrVQzLKzXmmzrOjP8NMPUaNr5YZRuKD5Vskq4zyNOztNtP5Svyjjm3gu/OR4rHjLdRnMEgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658850; c=relaxed/simple;
	bh=d9EhKkG6ze3jzDr0E895630a5304jf8nSoqGsqCsfzo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=RBwYyOI2+4WmLdPw1LmLbA/pWZMHjSHDNDAYuYNenhf3WqGDHCjy8bunhvP6DgnNo3sKqTq/szAqCOB60s1SqzD6qNfRMUCgj3UCxb0cFU/R/1r2dljWSp1U2B6U7iIwNa664oc0AZlqboYpxs91BxNnnpdnUUL8nLaHOCxMLPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LzFnsOaL; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LzFnsOaL"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-124a95b6f61so23132907c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 09:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770658849; x=1771263649; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0/jCV8OZGOh/GHl8+nOnmAz38qBf1dX7oFSvxJQYI9M=;
        b=LzFnsOaLlATvdN69YZb2fyxoC8R4cSljtGGVVcKl+JMAcmaPdmEREWsy+HOHjetvFH
         XtOq9yPjes2Ckn7V3YJtcKcN5/jh7cAuqqLOWpikOiq1hUA/0ca85uhBUyLvP0dlpaQf
         LvMkw2Mp7/fAxMx4omUfYcr5r67XoRaGg2FmJWgJ/f6q3Mm05QDbWwclH2gDrSSJ/9j2
         3UJLxL9NkHCo/1KWPkOnd/QVqxsZUuXsu4FfXqPh2GSg1cZKRKZjdKVBpvt4aIq/SUSe
         AeqbUA6+5Lba5CtPQ1AjimxnzrvKkGzwn37JFBu+m1TObdtr7A2PgoY7ylxXSvy4ps9b
         dpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770658849; x=1771263649;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0/jCV8OZGOh/GHl8+nOnmAz38qBf1dX7oFSvxJQYI9M=;
        b=UUHsqtgjvBB+8Q6oqXBEjbbjUzEHjt+pt9+5hR4l4YWtYmhFzSHrSEf7hETAQJ63yg
         2MG9+u6CQWQaQLgkGp9heNsWmpKX2emcqezPGmozuUEI/w3l3PpfeP/riMzH2s2vQdHq
         kZPwFHBpZqLoKWyEdDQU/pI/KC/OG3K30mzHAXudC0Rl4XG2+uZSyshc5sgYXpS8sFFK
         2aCozt1tbliJY6pjFJNm0skx3m0Smk6E738V9Y9tVCV+fHb+V7r8qBzTpYUDa2ODWxjM
         X2oN0ozrt9Eg8NtIhdY0Gmpv6IN8uuTGzdxYwCqDT5TklxLke8BoaflIk3OluKHYFl7u
         y8RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhvZtkzXGG0tuuu2nkco47bCaJPh0Sl8R9hAmfq1pISiftMCwki7TR3/liLtP5tx8BEZrC3lvmlKEDSJSwRf0k@vger.kernel.org
X-Gm-Message-State: AOJu0YxRAvqvsB0TykauS5mEyWNjRGF8+8qg7l1aRAG9e2DhuTstHIEE
	vg3Ej7Aj6ih0Wtb7b7dLWMo+1RKda1LLqG/ZNTx64UIypDeZTAkdpMnzq9rlwLywXO41E01PLip
	PXbESNy2ILg==
X-Received: from dlj11.prod.google.com ([2002:a05:7022:50b:b0:127:fa:7498])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6894:b0:122:153:d161
 with SMTP id a92af1059eb24-12704001972mr6324312c88.17.1770658849171; Mon, 09
 Feb 2026 09:40:49 -0800 (PST)
Date: Mon,  9 Feb 2026 09:40:10 -0800
In-Reply-To: <20260209174032.4142096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260209174032.4142096-4-irogers@google.com>
Subject: [PATCH v1 03/25] perf sample: Add evsel to struct perf_sample
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Leo Yan <leo.yan@arm.com>, Tianyou Li <tianyou.li@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, tanze <tanze@kylinos.cn>, 
	Hrishikesh Suresh <hrishikesh123s@gmail.com>, Quan Zhou <zhouquan@iscas.ac.cn>, 
	Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Chun-Tse Shao <ctshao@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Chen Ni <nichen@iscas.ac.cn>, Blake Jones <blakejones@google.com>, 
	Yujie Liu <yujie.liu@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
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
 tools/perf/builtin-inject.c       | 10 ++++++---
 tools/perf/builtin-script.c       |  4 ++++
 tools/perf/tests/hists_cumulate.c |  2 +-
 tools/perf/tests/hists_filter.c   |  1 +
 tools/perf/tests/hists_output.c   |  2 +-
 tools/perf/util/evsel.c           |  1 +
 tools/perf/util/sample.h          |  3 +++
 tools/perf/util/session.c         | 35 +++++++++++++++++++------------
 8 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 3d2556213599..8ae76bf5253e 100644
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
@@ -1021,9 +1022,10 @@ int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *e
 			     /*sample_in_dso=*/true);
 	}
 
+	sample->evsel = inject__mmap_evsel(inject);
 	sample__for_each_callchain_node(thread, evsel, sample, PERF_MAX_STACK_DEPTH,
 					/*symbols=*/false, mark_dso_hit_callback, &args);
-
+	sample->evsel = saved_evsel;
 	thread__put(thread);
 repipe:
 	perf_event__repipe(tool, event, sample, machine);
@@ -1100,6 +1102,7 @@ static int perf_inject__sched_stat(const struct perf_tool *tool,
 	evsel__parse_sample(evsel, event_sw, &sample_sw);
 
 	perf_sample__init(&sample_sw, /*all=*/false);
+	sample_sw.evsel = evsel;
 	sample_sw.period = sample->period;
 	sample_sw.time	 = sample->time;
 	perf_event__synthesize_sample(event_sw, evsel->core.attr.sample_type,
@@ -1433,6 +1436,7 @@ static int synthesize_build_id(struct perf_inject *inject, struct dso *dso, pid_
 {
 	struct machine *machine = perf_session__findnew_machine(inject->session, machine_pid);
 	struct perf_sample synth_sample = {
+		.evsel	   = inject__mmap_evsel(inject),
 		.pid	   = -1,
 		.tid	   = -1,
 		.time	   = -1,
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 14c6f6c3c4f2..c28897186341 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2905,8 +2905,12 @@ static int print_event_with_time(const struct perf_tool *tool,
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
index 34ae388750db..a7da54d365a9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3220,6 +3220,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	union u64_swap u;
 
 	perf_sample__init(data, /*all=*/true);
+	data->evsel = evsel;
 	data->cpu = data->pid = data->tid = -1;
 	data->stream_id = data->id = data->time = -1ULL;
 	data->period = evsel->core.attr.sample_period;
diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index 3fd2a5e01308..51ea4af452ea 100644
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
2.53.0.239.g8d8fc8a987-goog

