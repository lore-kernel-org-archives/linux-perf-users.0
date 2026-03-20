Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9774C3FBECF
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 19:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034925; cv=none; b=JGSJScoMYvl6T1zVBK8Nr0omb5ozB0kPPkm8RuBF7D+4CcvUbat+Q2a/utj8xX5oGi0sVnh3hfVboCsR6AabytOCDGR7AR3UTDwjRS7vOZw32cGizNZJD5tEpNgvdqVcZl4QUDbvcbhMO95yuKfdwWbm8UKvUDr7cZlvm6RQsQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034925; c=relaxed/simple;
	bh=uaXbq5sB6jR23YcrU0TSpwqaN9vxrH71tW18wn1e7gk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l0vAcVsymHD9MNdIKAQiCg7eyPurb53FnmpM5gwdvuEaTOhijeBL/+ajtly4GeClIlZxdXEJKnd8Lj8UUrL0cGyo5ASJ2DxuGoHsecg1jwGjL0UsJh7P0TVWkm6aSplcRTOrqMhyatEjpmw2c8moy7W7es2dbokR94LsPXvMh8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CA8ElvB7; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CA8ElvB7"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c0bddb9196so1394405eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 12:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774034920; x=1774639720; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=//OhO+K8SAxH3wwANO979A4UoFJWciO8XiSL1taUHjA=;
        b=CA8ElvB7lKqLRXmZHAW1kpGKQT6my8DBpWlg+6YJKxpmxcHoaE6eS4Jax5Rbb86AJc
         Q2/yJ324WwKaoKiFnfOz1F65Ls8W1Nl8hgm+XoSKDihA6cX3qPfZ4JpK9MK4/OGzdBjV
         Oe5TOyRLeP6slfYPSsltL+SRchr4NnFq1ekBNOWRyhQgsOsLqygyisz0fWATcexdXZb5
         K+VfUeSitXCGrmZxCimgAdI6/fw0QVOohwMJ0Zl019YbM9JIbh5ck/U/FZis7thV7cb5
         KOi/YHmrKUyT7mXHzqUPHf+SgZAq6r1HIyb+OxMLzgk3ZtYzHBKtSbJDqRZgnh0rMEuX
         KSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034920; x=1774639720;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=//OhO+K8SAxH3wwANO979A4UoFJWciO8XiSL1taUHjA=;
        b=Jz33JkomsIc2SxaL4T1pngG2vVWKuPR5ljQQTLY8hurlnD3h9NBDbNhQIaoa3fBBKH
         fMvYEXHXIVSapcEHfHHPs3YmhTE8lCavqF09ENv+pFzhuLG90mHEwDlMdEaAsPFVlkgs
         Ff/Jf4xHp4nN2JlaB9bADpYUumRVTuLkTReAG7YUzZ7W8DT8FmE6GFRtwseCkhkDCUz9
         9ZsYmZ6dzFX6UvrPhVMsN2eHLP29VADTfGovDEIvV73omS1AlwypKF/2cc3L+5R7u4lB
         EYIAOeofBRePUq6ihc2jWVmh7wEVG298aW7xZ9jWMcGNO+801K+380gCbYk9Hqknxfqq
         2JAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmad4X3LmUiO+U84tvC0CYYnqGDm/qwV9fKh9RIe9aE39KCViJRoU5EZc1BYv/yIvB15xO6XN/5Pmk3wevDlN3@vger.kernel.org
X-Gm-Message-State: AOJu0YyvqaymEV2CnYE07kcgBgVYoD9C14bO+9h9bE6BUTgA/+eXgPb9
	kBGVaALSuYSsRY2KLdPUVVtV8eLn6ER+aFXAOXO+0JObkoR/UekSXJ8g57Y9MvWYOlAPWZKpF9o
	o4E0tes6sig==
X-Received: from dycao1.prod.google.com ([2002:a05:7301:7d01:b0:2c1:113a:5c84])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:e24:b0:2c0:c7cd:1288
 with SMTP id 5a478bee46e88-2c1097602b4mr1983502eec.27.1774034908656; Fri, 20
 Mar 2026 12:28:28 -0700 (PDT)
Date: Fri, 20 Mar 2026 12:26:15 -0700
In-Reply-To: <20260320192627.368357-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320080835.724836-1-irogers@google.com> <20260320192627.368357-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320192627.368357-14-irogers@google.com>
Subject: [PATCH v4 13/25] perf hist: Remove evsel from struct hist_entry_iter
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
index c2d0599fe5f5..041f5dc92ea8 100644
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
index 096adc65451c..67cf5bbaab29 100644
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
index 39968ae5cfb0..1051d7b75361 100644
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
2.53.0.959.g497ff81fa9-goog

