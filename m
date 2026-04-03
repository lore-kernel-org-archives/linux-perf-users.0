Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786233D8904
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Apr 2026 20:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775248858; cv=none; b=VxYUEH5ZkmeSGEroL6Y1Z1atC0ZWl660ofLM6WHyU+jo5xmHcHIMQBsY/N9Ceu8ZWCgFgwJ4UlLcZaaMZvRDmCFSpu6euYIEOeeHKSCSrYYDz8mxHC6p+w+DhWLlm7mI3N+BR13udrRxbv7C6GXFBA87aDOa12cVRE0w21ftqLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775248858; c=relaxed/simple;
	bh=jNIL33k87gtaSUPMibDJ6yPQJtDK0dHAdF1GtgBune4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qMqvjWXwUVG6AoEAPytTzeyXpo2cWgdPPDS65BimcUyCkQ4n5nC6h9qK8Rj2vthEi97itX9bq3JN0MWsxiak+rn3RdAHNbRVdXzmbXHS45iv1QWHDEk90I+nuUUwsP/SQQfzomI93plXgDaw9ZorCsW/mDrIohEUNFrna+lPw98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KxMVnMT/; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KxMVnMT/"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12721cd1a2aso11297998c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 13:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775248855; x=1775853655; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ynwM+AEApMdqoZuvNbVdN+EnF0BWt1XhQbbnU8yhnto=;
        b=KxMVnMT/uCP+fa5uFu9nAoXgroYKJD72CmKyj2RY4ce+XjX4JWRhzAb+F8MlKNbP3F
         fUpSmCxDjet7sVve04ORXwJ3PRO3yncRRewALLRPXs+jcdlvhdq2NhQ/jNr/oCLUXeTL
         BbPaQx5mbvVN5gTL9tWDAQSK3aKhaTn1fRtCTmamnNTBNqm/bCw3mtKjp6lFBpWnx/bx
         szKDjwF6HqmmKS1zVy/QqICiZZAQKgsvxRBnyDRVLGCKEH91c8qaGzO2ku/jX2p+Mzfb
         Dw73/pdQcMI+EAL2JzoFvvtPemf0lyFHIP2E749T7QPZWlwiZqmEijzGr9I8U2edkjxO
         qiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775248855; x=1775853655;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ynwM+AEApMdqoZuvNbVdN+EnF0BWt1XhQbbnU8yhnto=;
        b=P1yR3Gj1DGnsLFfndkS4ozNrA5qUYEN2bOXE539fa7T/x0b4o6FVCrndFTUdxhgbFH
         K8AMkTqo2MQs6sSVpsDU4DP3C5qwgPBQ1Lj2XKNfk18McldJ3kuKIiVZZJG5YWXUiXjU
         FNp+Pl1RR5cK9ZaG1fkrEkeybWYBRBVqbRxSzWF+FqBTUETxi52TGfV365/qhaHYzRPg
         WPX5XpXwdElzhqPHC5N5tFbUIvaxa9wIEO3aglI85gIY/S/yh5+bPMDfp6RAAkTXwNb6
         q8pkz2ON6P+qcjTksXTBCayRuxY+8FjxxpLBiosPZhoaqfjuR+q1fYXR5FiyypVrFb6W
         d4lw==
X-Forwarded-Encrypted: i=1; AJvYcCVxVvzn7qWs+vcLjMvX4QiFY2pL6lOl7+T9h1GaUeC7BN3cyqrwHyL6kMd23LYpvV6DXMBUripBWsgr4qRa1f64@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy7/tGtUSwx3Vz7Ns7yH6HXn5yk5039fAdTAZwbmL1XlvP2jTx
	KdfdUJ5aU7ikdAix0AGLg/HQjTJeq7Y0CbbPFRSYeoOnTwy6uP+1nVzgKCvJX5QGskRmzX4CUJF
	OE07bNqpGvg==
X-Received: from dlbrh17.prod.google.com ([2002:a05:7022:f311:b0:12a:70c3:eda4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ec17:b0:124:11af:7b75
 with SMTP id a92af1059eb24-12bfb76f2a2mr2106655c88.34.1775248854355; Fri, 03
 Apr 2026 13:40:54 -0700 (PDT)
Date: Fri,  3 Apr 2026 13:40:05 -0700
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
Message-ID: <20260403204017.2919994-14-irogers@google.com>
Subject: [PATCH v5 13/25] perf hist: Remove evsel from struct hist_entry_iter
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
index b879592ae745..a66666e89f67 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -732,20 +732,18 @@ static int hist_iter__top_callback(struct hist_entry_iter *iter,
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
@@ -831,9 +829,8 @@ static void perf_event__process_sample(const struct perf_tool *tool,
 	}
 
 	if (al.sym == NULL || !al.sym->idle) {
-		struct hists *hists = evsel__hists(evsel);
+		struct hists *hists = evsel__hists(sample->evsel);
 		struct hist_entry_iter iter = {
-			.evsel		= evsel,
 			.sample 	= sample,
 			.add_entry_cb 	= hist_iter__top_callback,
 		};
@@ -1211,7 +1208,7 @@ static int deliver_event(struct ordered_events *qe,
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
index f51fd439d2dd..4e9a6e3b2a99 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -935,8 +935,8 @@ iter_add_single_mem_entry(struct hist_entry_iter *iter, struct addr_location *al
 {
 	u64 cost;
 	struct mem_info *mi = iter->mi;
-	struct hists *hists = evsel__hists(iter->evsel);
 	struct perf_sample *sample = iter->sample;
+	struct hists *hists = evsel__hists(sample->evsel);
 	struct hist_entry *he;
 
 	if (mi == NULL)
@@ -968,7 +968,7 @@ static int
 iter_finish_mem_entry(struct hist_entry_iter *iter,
 		      struct addr_location *al __maybe_unused)
 {
-	struct evsel *evsel = iter->evsel;
+	struct evsel *evsel = iter->sample->evsel;
 	struct hists *hists = evsel__hists(evsel);
 	struct hist_entry *he = iter->he;
 	int err = -EINVAL;
@@ -1036,9 +1036,9 @@ static int
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
@@ -1078,7 +1078,7 @@ static int
 iter_finish_branch_entry(struct hist_entry_iter *iter,
 			 struct addr_location *al __maybe_unused)
 {
-	struct evsel *evsel = iter->evsel;
+	struct evsel *evsel = iter->sample->evsel;
 	struct hists *hists = evsel__hists(evsel);
 
 	for (int i = 0; i < iter->total; i++)
@@ -1103,8 +1103,8 @@ iter_prepare_normal_entry(struct hist_entry_iter *iter __maybe_unused,
 static int
 iter_add_single_normal_entry(struct hist_entry_iter *iter, struct addr_location *al)
 {
-	struct evsel *evsel = iter->evsel;
 	struct perf_sample *sample = iter->sample;
+	struct evsel *evsel = sample->evsel;
 	struct hist_entry *he;
 
 	he = hists__add_entry(evsel__hists(evsel), al, iter->parent, NULL, NULL,
@@ -1121,8 +1121,8 @@ iter_finish_normal_entry(struct hist_entry_iter *iter,
 			 struct addr_location *al __maybe_unused)
 {
 	struct hist_entry *he = iter->he;
-	struct evsel *evsel = iter->evsel;
 	struct perf_sample *sample = iter->sample;
+	struct evsel *evsel = sample->evsel;
 
 	if (he == NULL)
 		return 0;
@@ -1165,9 +1165,9 @@ static int
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
@@ -1224,8 +1224,8 @@ static int
 iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
 			       struct addr_location *al)
 {
-	struct evsel *evsel = iter->evsel;
 	struct perf_sample *sample = iter->sample;
+	struct evsel *evsel = sample->evsel;
 	struct hist_entry **he_cache = iter->he_cache;
 	struct hist_entry *he;
 	struct hist_entry he_tmp = {
@@ -2826,7 +2826,7 @@ int hists__unlink(struct hists *hists)
 
 void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 			  struct perf_sample *sample, bool nonany_branch_mode,
-			  u64 *total_cycles, struct evsel *evsel)
+			  u64 *total_cycles)
 {
 	struct branch_info *bi;
 	struct branch_entry *entries = perf_sample__branch_entries(sample);
@@ -2850,7 +2850,7 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 			for (int i = bs->nr - 1; i >= 0; i--) {
 				addr_map_symbol__account_cycles(&bi[i].from,
 					nonany_branch_mode ? NULL : prev,
-					bi[i].flags.cycles, evsel,
+					bi[i].flags.cycles, sample->evsel,
 					bi[i].branch_stack_cntr);
 				prev = &bi[i].to;
 
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index d97a4efb9250..8fb89d81ef06 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -156,7 +156,6 @@ struct hist_entry_iter {
 	int total;
 	int curr;
 
-	struct evsel *evsel;
 	struct perf_sample *sample;
 	struct hist_entry *he;
 	struct symbol *parent;
@@ -799,7 +798,7 @@ unsigned int hists__overhead_width(struct hists *hists);
 
 void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 			  struct perf_sample *sample, bool nonany_branch_mode,
-			  u64 *total_cycles, struct evsel *evsel);
+			  u64 *total_cycles);
 
 struct option;
 int parse_filter_percentage(const struct option *opt, const char *arg, int unset);
-- 
2.53.0.1213.gd9a14994de-goog

