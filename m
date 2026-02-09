Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F399E38A9DE
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658872; cv=none; b=fhAOcDaZ9b3PW+tFOgqAdYlf9Z7vyT5wQIDpRjvuw9mJRTNhBqTLAffQozUscAGsxxgKc9uGWI+BSJpEAo2/+hC0XCPCKiXfjS1Klp/nmAScPbpPWb02BfYF+sGgKQ/D/zcTsxE/skMhk5Syk+ASZYCsDaa/vZv0Dk+Batq1ets=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658872; c=relaxed/simple;
	bh=vQHKUkDXv14dgQLvNuk2rgQAlZ3p30Uat+xMwq9mgn4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Va7fvuNdghpOjmpml5JMH+0HwLLrkDpzoMfpYWoAgEuahMj80h/bbkNonTnoGmZEhYV4Nlw8ldgiMz6XV5Xd3GavSNKjjWZEV+gYp/A6oYrGujhhNm43kvuYLksOAP9i9M1E3utuF2+wW2x1gB61S7vEzVU3GSaFcgvgezfMKyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YSRomaSe; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YSRomaSe"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1270e3704d6so16721416c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 09:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770658871; x=1771263671; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3r3ri6bpLQYsNSUtlkrKvtJ1xTRAKeUj544Bfodfkb4=;
        b=YSRomaSeyItNj9+y88FZMjjSwLBQQCgU2d2mK9LUsFAAGE0/i7K+Ap6u6mBvvMAkY/
         gxXsn89lt6UQadsHmwlJ0ARAYZuOJT5Yb8p3FFhlxVde0FR9IhI1My1bsqOY4587sHCi
         Z6zgS2r7vK5PgB8n1lvyYl9+XM3obzx4oITbRGG1F2ZuMuluv0eRfU6YY88a3r417WjC
         gxCMGBm9pK5/ER8hHvV0vQFuvfog74Hq+pG1PJ/b2wLUun1Gcw+E6BnoqFK/2FtAWCrz
         9uZdJwPprNqyeCrVTUD5R08M93MkB+s874elt45L53ju7/yPuauK83u7TasXEUtzfEdj
         yFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770658871; x=1771263671;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3r3ri6bpLQYsNSUtlkrKvtJ1xTRAKeUj544Bfodfkb4=;
        b=e49HlBf3IuGwifdmOOFqJwfFyddXUKZLGr3/TciIRyk70r5wpZfbgXAe/iv0xL6gVl
         83/g04w+AyMGOY5GFCxRoY9S8eL5pgO9IS2SdpKVpSsdsTd0SUy3FeROLWmc4VmlIod2
         hQ1mM6+FhFvsrPP2I03VmIK9UIBTrkDFZfjl7YgHB9A29KUBlP5oHd70Z7bw/Mh+Tv1R
         h7WI+WDF6LorxA3jbsh22rkwDgxNEn1TDYbCrasWw31WT8DHHOw4griCPjoZge6WPXwO
         ap5V5f8g+rkjdAjNXsbgEvwsf837tZndcm444TocmQvTG7UWXqHVTw+rIFCZohcMqnJq
         qoTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPfE2ekK6vVqwYJoIiKSNRmHLj18vFkqQBfqFwgtslD5YUzL1SItyx0AUmIPt3N2YNbiPu7zm0LDcmFTqZGTtq@vger.kernel.org
X-Gm-Message-State: AOJu0YwIs3ayIKj9cbyXrAnr21QzF8kiPyGz1mIsas/C4AielExowcuo
	1TCpp6UWbe6b7G7b5uqu6cmNUcM4gt5ZfGNJDTQVyNCX+e4kE9gEyjQaHt6/JzF0kPUWbae2dMt
	bSJVX76JGxA==
X-Received: from dlbcy19.prod.google.com ([2002:a05:7022:b93:b0:123:3358:ca1c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2484:b0:11b:ca88:c503
 with SMTP id a92af1059eb24-1270411beacmr6443427c88.3.1770658870680; Mon, 09
 Feb 2026 09:41:10 -0800 (PST)
Date: Mon,  9 Feb 2026 09:40:20 -0800
In-Reply-To: <20260209174032.4142096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260209174032.4142096-14-irogers@google.com>
Subject: [PATCH v1 13/25] perf hist: Remove evsel from struct hist_entry_iter
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

struct hist_entry_iter has the sample within it so the evsel is
unnecessary. Remove the evsel and update uses. Also remove the evsel
from hist__account_cycles and derive it from the sample too.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c     | 10 ++++------
 tools/perf/builtin-diff.c         |  3 +--
 tools/perf/builtin-report.c       |  6 ++----
 tools/perf/builtin-top.c          |  9 +++------
 tools/perf/tests/hists_cumulate.c |  1 -
 tools/perf/tests/hists_filter.c   |  1 -
 tools/perf/tests/hists_output.c   |  1 -
 tools/perf/util/hist.c            | 24 ++++++++++++------------
 tools/perf/util/hist.h            |  3 +--
 9 files changed, 23 insertions(+), 35 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 40c0ae0b52a4..26fe2cb93833 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -191,14 +191,12 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
 	return err;
 }
 
-static int process_branch_callback(struct evsel *evsel,
-				   struct perf_sample *sample,
+static int process_branch_callback(struct perf_sample *sample,
 				   struct addr_location *al,
 				   struct perf_annotate *ann,
 				   struct machine *machine)
 {
 	struct hist_entry_iter iter = {
-		.evsel		= evsel,
 		.sample		= sample,
 		.add_entry_cb	= hist_iter__branch_callback,
 		.hide_unresolved	= symbol_conf.hide_unresolved,
@@ -221,8 +219,8 @@ static int process_branch_callback(struct evsel *evsel,
 	if (a.map != NULL)
 		dso__set_hit(map__dso(a.map));
 
-	hist__account_cycles(sample->branch_stack, al, sample, false,
-			     NULL, evsel);
+	hist__account_cycles(sample->branch_stack, al, sample, /*nonany_branch_mode=*/false,
+			     /*total_cycles=*/NULL);
 
 	ret = hist_entry_iter__add(&iter, &a, PERF_MAX_STACK_DEPTH, ann);
 out:
@@ -269,7 +267,7 @@ static int evsel__add_sample(struct evsel *evsel, struct perf_sample *sample,
 	process_branch_stack(sample->branch_stack, al, sample);
 
 	if (ann->has_br_stack && has_annotation(ann))
-		return process_branch_callback(evsel, sample, al, ann, machine);
+		return process_branch_callback(sample, al, ann, machine);
 
 	he = hists__add_entry(hists, al, NULL, NULL, NULL, NULL, sample, true);
 	if (he == NULL)
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 793538ad3b4c..31620ac373d0 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -397,7 +397,6 @@ static int diff__process_sample_event(const struct perf_tool *tool,
 	struct evsel *evsel = sample->evsel;
 	struct hists *hists = evsel__hists(evsel);
 	struct hist_entry_iter iter = {
-		.evsel	= evsel,
 		.sample	= sample,
 		.ops	= &hist_iter_normal,
 	};
@@ -431,7 +430,7 @@ static int diff__process_sample_event(const struct perf_tool *tool,
 		}
 
 		hist__account_cycles(sample->branch_stack, &al, sample,
-				     false, NULL, evsel);
+				     /*nonany_branch_mode=*/false, /*total_cycles=*/NULL);
 		break;
 
 	case COMPUTE_STREAM:
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 596b1ec9885c..ae7985ec2bd8 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -270,10 +270,8 @@ static int process_sample_event(const struct perf_tool *tool,
 				struct machine *machine)
 {
 	struct report *rep = container_of(tool, struct report, tool);
-	struct evsel *evsel = sample->evsel;
 	struct addr_location al;
 	struct hist_entry_iter iter = {
-		.evsel 			= evsel,
 		.sample 		= sample,
 		.hide_unresolved 	= symbol_conf.hide_unresolved,
 		.add_entry_cb 		= hist_iter__report_callback,
@@ -285,7 +283,7 @@ static int process_sample_event(const struct perf_tool *tool,
 		return 0;
 	}
 
-	if (evswitch__discard(&rep->evswitch, evsel))
+	if (evswitch__discard(&rep->evswitch, sample->evsel))
 		return 0;
 
 	addr_location__init(&al);
@@ -329,7 +327,7 @@ static int process_sample_event(const struct perf_tool *tool,
 	if (ui__has_annotation() || rep->symbol_ipc || rep->total_cycles_mode) {
 		hist__account_cycles(sample->branch_stack, &al, sample,
 				     rep->nonany_branch_mode,
-				     &rep->total_cycles, evsel);
+				     &rep->total_cycles);
 	}
 
 	rep->total_samples++;
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index e863f9ef581f..b89ca48e5d02 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -731,20 +731,18 @@ static int hist_iter__top_callback(struct hist_entry_iter *iter,
 	EXCLUSIVE_LOCKS_REQUIRED(iter->he->hists->lock)
 {
 	struct perf_top *top = arg;
-	struct evsel *evsel = iter->evsel;
 
 	if (perf_hpp_list.sym && single)
 		perf_top__record_precise_ip(top, iter->he, iter->sample, al->addr);
 
 	hist__account_cycles(iter->sample->branch_stack, al, iter->sample,
 			     !(top->record_opts.branch_stack & PERF_SAMPLE_BRANCH_ANY),
-			     NULL, evsel);
+			     /*total_cycles=*/NULL);
 	return 0;
 }
 
 static void perf_event__process_sample(const struct perf_tool *tool,
 				       const union perf_event *event,
-				       struct evsel *evsel,
 				       struct perf_sample *sample,
 				       struct machine *machine)
 {
@@ -830,9 +828,8 @@ static void perf_event__process_sample(const struct perf_tool *tool,
 	}
 
 	if (al.sym == NULL || !al.sym->idle) {
-		struct hists *hists = evsel__hists(evsel);
+		struct hists *hists = evsel__hists(sample->evsel);
 		struct hist_entry_iter iter = {
-			.evsel		= evsel,
 			.sample 	= sample,
 			.add_entry_cb 	= hist_iter__top_callback,
 		};
@@ -1210,7 +1207,7 @@ static int deliver_event(struct ordered_events *qe,
 	}
 
 	if (event->header.type == PERF_RECORD_SAMPLE) {
-		perf_event__process_sample(&top->tool, event, evsel,
+		perf_event__process_sample(&top->tool, event,
 					   &sample, machine);
 	} else if (event->header.type == PERF_RECORD_LOST) {
 		perf_top__process_lost(top, event, evsel);
diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_cumulate.c
index 606aa926a8fc..267cbc24691a 100644
--- a/tools/perf/tests/hists_cumulate.c
+++ b/tools/perf/tests/hists_cumulate.c
@@ -87,7 +87,6 @@ static int add_hist_entries(struct hists *hists, struct machine *machine)
 	addr_location__init(&al);
 	for (i = 0; i < ARRAY_SIZE(fake_samples); i++) {
 		struct hist_entry_iter iter = {
-			.evsel = evsel,
 			.sample	= &sample,
 			.hide_unresolved = false,
 		};
diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/hists_filter.c
index cc6b26e373d1..002e3a4c1ca5 100644
--- a/tools/perf/tests/hists_filter.c
+++ b/tools/perf/tests/hists_filter.c
@@ -63,7 +63,6 @@ static int add_hist_entries(struct evlist *evlist,
 	evlist__for_each_entry(evlist, evsel) {
 		for (i = 0; i < ARRAY_SIZE(fake_samples); i++) {
 			struct hist_entry_iter iter = {
-				.evsel = evsel,
 				.sample = &sample,
 				.ops = &hist_iter_normal,
 				.hide_unresolved = false,
diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/hists_output.c
index 7818950d786e..fa683fd7b1e5 100644
--- a/tools/perf/tests/hists_output.c
+++ b/tools/perf/tests/hists_output.c
@@ -57,7 +57,6 @@ static int add_hist_entries(struct hists *hists, struct machine *machine)
 	addr_location__init(&al);
 	for (i = 0; i < ARRAY_SIZE(fake_samples); i++) {
 		struct hist_entry_iter iter = {
-			.evsel = evsel,
 			.sample = &sample,
 			.ops = &hist_iter_normal,
 			.hide_unresolved = false,
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 84a402d248a3..632c1edcab9a 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -932,8 +932,8 @@ iter_add_single_mem_entry(struct hist_entry_iter *iter, struct addr_location *al
 {
 	u64 cost;
 	struct mem_info *mi = iter->mi;
-	struct hists *hists = evsel__hists(iter->evsel);
 	struct perf_sample *sample = iter->sample;
+	struct hists *hists = evsel__hists(sample->evsel);
 	struct hist_entry *he;
 
 	if (mi == NULL)
@@ -965,7 +965,7 @@ static int
 iter_finish_mem_entry(struct hist_entry_iter *iter,
 		      struct addr_location *al __maybe_unused)
 {
-	struct evsel *evsel = iter->evsel;
+	struct evsel *evsel = iter->sample->evsel;
 	struct hists *hists = evsel__hists(evsel);
 	struct hist_entry *he = iter->he;
 	int err = -EINVAL;
@@ -1033,9 +1033,9 @@ static int
 iter_add_next_branch_entry(struct hist_entry_iter *iter, struct addr_location *al)
 {
 	struct branch_info *bi;
-	struct evsel *evsel = iter->evsel;
-	struct hists *hists = evsel__hists(evsel);
 	struct perf_sample *sample = iter->sample;
+	struct evsel *evsel = sample->evsel;
+	struct hists *hists = evsel__hists(evsel);
 	struct hist_entry *he = NULL;
 	int i = iter->curr;
 	int err = 0;
@@ -1075,7 +1075,7 @@ static int
 iter_finish_branch_entry(struct hist_entry_iter *iter,
 			 struct addr_location *al __maybe_unused)
 {
-	struct evsel *evsel = iter->evsel;
+	struct evsel *evsel = iter->sample->evsel;
 	struct hists *hists = evsel__hists(evsel);
 
 	for (int i = 0; i < iter->total; i++)
@@ -1100,8 +1100,8 @@ iter_prepare_normal_entry(struct hist_entry_iter *iter __maybe_unused,
 static int
 iter_add_single_normal_entry(struct hist_entry_iter *iter, struct addr_location *al)
 {
-	struct evsel *evsel = iter->evsel;
 	struct perf_sample *sample = iter->sample;
+	struct evsel *evsel = sample->evsel;
 	struct hist_entry *he;
 
 	he = hists__add_entry(evsel__hists(evsel), al, iter->parent, NULL, NULL,
@@ -1118,8 +1118,8 @@ iter_finish_normal_entry(struct hist_entry_iter *iter,
 			 struct addr_location *al __maybe_unused)
 {
 	struct hist_entry *he = iter->he;
-	struct evsel *evsel = iter->evsel;
 	struct perf_sample *sample = iter->sample;
+	struct evsel *evsel = sample->evsel;
 
 	if (he == NULL)
 		return 0;
@@ -1162,9 +1162,9 @@ static int
 iter_add_single_cumulative_entry(struct hist_entry_iter *iter,
 				 struct addr_location *al)
 {
-	struct evsel *evsel = iter->evsel;
-	struct hists *hists = evsel__hists(evsel);
 	struct perf_sample *sample = iter->sample;
+	struct evsel *evsel = sample->evsel;
+	struct hists *hists = evsel__hists(evsel);
 	struct hist_entry **he_cache = iter->he_cache;
 	struct hist_entry *he;
 	int err = 0;
@@ -1221,8 +1221,8 @@ static int
 iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
 			       struct addr_location *al)
 {
-	struct evsel *evsel = iter->evsel;
 	struct perf_sample *sample = iter->sample;
+	struct evsel *evsel = sample->evsel;
 	struct hist_entry **he_cache = iter->he_cache;
 	struct hist_entry *he;
 	struct hist_entry he_tmp = {
@@ -2823,7 +2823,7 @@ int hists__unlink(struct hists *hists)
 
 void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 			  struct perf_sample *sample, bool nonany_branch_mode,
-			  u64 *total_cycles, struct evsel *evsel)
+			  u64 *total_cycles)
 {
 	struct branch_info *bi;
 	struct branch_entry *entries = perf_sample__branch_entries(sample);
@@ -2847,7 +2847,7 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 			for (int i = bs->nr - 1; i >= 0; i--) {
 				addr_map_symbol__account_cycles(&bi[i].from,
 					nonany_branch_mode ? NULL : prev,
-					bi[i].flags.cycles, evsel,
+					bi[i].flags.cycles, sample->evsel,
 					bi[i].branch_stack_cntr);
 				prev = &bi[i].to;
 
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 1d5ea632ca4e..ee92fffc53a9 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -155,7 +155,6 @@ struct hist_entry_iter {
 	int total;
 	int curr;
 
-	struct evsel *evsel;
 	struct perf_sample *sample;
 	struct hist_entry *he;
 	struct symbol *parent;
@@ -797,7 +796,7 @@ unsigned int hists__overhead_width(struct hists *hists);
 
 void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 			  struct perf_sample *sample, bool nonany_branch_mode,
-			  u64 *total_cycles, struct evsel *evsel);
+			  u64 *total_cycles);
 
 struct option;
 int parse_filter_percentage(const struct option *opt, const char *arg, int unset);
-- 
2.53.0.239.g8d8fc8a987-goog

