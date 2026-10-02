Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF82A502D5B
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 17:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790962780; cv=none; b=BqSCThxwCZASNluqVBXJzvOaoD0fdKoR1k5ril2fmWnMLaPd9Zlmhs+eBVnabHqmSujH0XCYmbzppU76QcZZCMAG3K6XE7nDnogF4y/vRKDJS94Jpc7ib+Ru4VF9MsVFnYJb42MbfDOM7fEI+xA1ZsWdgNWr+AzRzs3HyCpAxSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790962780; c=relaxed/simple;
	bh=MoJujnGejCdezpl7NHow1nJkPzpaW77CMRSOKY3iows=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IXjDi1U7ZBrraHyE3JUaGKAhnnqPVLDIbskzmfmLnxh67777UHDROo8QIRd4g3qcd602m8N7Uu2GXeonxqTzsHeS+nO2kD4FAZ0G3hq1LbDNEJ3dzXdBV5rtH3XDtI//LCELarXdmO9pBXb/tTKVt79Q854irkSsh6+6tWuw9X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qge+ghKu; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qge+ghKu"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33baaba6371so10826354eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 10:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790962763; x=1791567563; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o6jLbqTNe7Bn2eqZUbzzX25UtPpe9kS5W+zxUYAzac8=;
        b=Qge+ghKuJ4bibnzpTSSYOTrAsVXH11CjyFWR6RDm2PkNUGPgfKJTD06blbh0I6OF96
         f4FER8fuMFqfqQXLB+I+citvqSSM2yZ70G2AQvOb/L/c2jUqhvEnyyCtIG1Bq6W4FCaN
         Sb8Hem+k9J4SztHrZtmlDHDxamaRWPWXvK/l/8ujFBNljR9WoEPVYet36ovuYtwnUWuk
         3KTU1EgMGEI4b2vlzhbDRM3OTYCAgzfKg6Oazpuq43reV+tdRHRRLFnRVqBWAcLqq/88
         jso7JuW1EAuZ4wtw9yNSJWpfe6AUNwALuer3NE3bGT+JF0UAtNEKACT6/oiU35cSHqds
         kE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790962763; x=1791567563;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o6jLbqTNe7Bn2eqZUbzzX25UtPpe9kS5W+zxUYAzac8=;
        b=BNMjgE2yFrmkj6xvXgi+x2sYQ+727NJLBqOOIk52BUnPKF0ao4tfyxGEwxdg73+lYe
         ggDNSzIsNjS93L6X4cbAWDPX7RZdEXV5mxk6FBLZr+EKYuGdjPvPZmaoV3laYt6OHnby
         aNMEAuQEvdIh0BB0M2Xqy20v6hpfJlAR9/1k3TNZl1cHJL9dlU1lJw37pjClmNAmrQqb
         XX9aXOWA2690l7R5zPcaeHk25lHM8zy5TL2lmRYerTct7pFZpvTwUscMSRddnMLHkSYD
         uX+dba7DhSDyZg3jVOCRYfHvsGYntsUpWd7tvWWyv9TfpEY7JShqaeGXja4Rnu3exAvw
         8fHg==
X-Forwarded-Encrypted: i=1; AKwUvByk2ttNbiymVOLtWDKN1hbjjqaS4ViVnpdlekm3L7IJgkJgy2nvG6EjAjF1t6vFPWPF89UJXKOpPhYUTtsjF0JP@vger.kernel.org
X-Gm-Message-State: AFuF++keTII+g6JKfxBzhefUJ37LRS9PT1Hx1/Jg9m4TtlhltFoRe2U7
	V0Zaii89RLoLvYJcSz594voLifWua/JQ3/W83gQq8PmVY4qRNmc9eXNvava+rBRdSXfwPaGUzUV
	STSLKFXr73w==
X-Received: from dlnn16.prod.google.com ([2002:a05:7022:6190:b0:151:c50e:fd9d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ed07:b0:143:3617:c5ae
 with SMTP id a92af1059eb24-14f58de4ca6mr3339307c88.2.1790962761407; Fri, 02
 Oct 2026 10:39:21 -0700 (PDT)
Date: Fri,  2 Oct 2026 10:38:38 -0700
In-Reply-To: <20261002173848.3228217-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250424061943.1321025-1-irogers@google.com> <20261002173848.3228217-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261002173848.3228217-6-irogers@google.com>
Subject: [PATCH v2 5/8] perf tools: Internal support for BUILD_ID_OFFSET
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org
Cc: ak@linux.intel.com, alexander.shishkin@linux.intel.com, 
	atrajeev@linux.ibm.com, dvyukov@google.com, fzczx123@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, kjain@linux.ibm.com, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, lihuafei1@huawei.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, m.liska@foxlink.cz, mark.rutland@arm.com, 
	martin.liska@hey.com, mpetlan@redhat.com, quic_zhonhan@quicinc.com, 
	scclevenger@os.amperecomputing.com, sesse@google.com, 
	stephen.s.brennan@oracle.com, thomas.falcon@intel.com, 
	yangyicong@hisilicon.com
Content-Type: text/plain; charset="UTF-8"

Implement user-space parsing for the new sample types in evsel,
update perf_event_attr_fprintf to display the new bits
in 'perf report -D', and update synthetic event parameter names.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-report.c               |   6 +-
 tools/perf/builtin-script.c               |  16 +--
 tools/perf/util/callchain.c               |  93 ++++++++++++-----
 tools/perf/util/dsos.c                    |  27 +++++
 tools/perf/util/dsos.h                    |   2 +
 tools/perf/util/event.c                   |  35 +++++--
 tools/perf/util/evsel.c                   | 114 ++++++++++++++++++++-
 tools/perf/util/evsel.h                   |   3 +-
 tools/perf/util/evsel_fprintf.c           |   9 +-
 tools/perf/util/machine.c                 | 119 +++++++++++++++++-----
 tools/perf/util/maps.c                    |  59 +++++++++++
 tools/perf/util/maps.h                    |   2 +
 tools/perf/util/perf_event_attr_fprintf.c |   3 +-
 tools/perf/util/sample.c                  |   9 ++
 tools/perf/util/sample.h                  |  28 +++++
 tools/perf/util/session.c                 |  52 +++++++---
 tools/perf/util/synthetic-events.c        |  28 +++++
 17 files changed, 515 insertions(+), 90 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 57225bc87731..0c8596cf82b5 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -382,7 +382,8 @@ static int report__setup_sample_type(struct report *rep)
 	    session->itrace_synth_opts->add_last_branch)
 		sample_type |= PERF_SAMPLE_BRANCH_STACK;
 
-	if (!is_pipe && !(sample_type & PERF_SAMPLE_CALLCHAIN)) {
+	if (!is_pipe && !(sample_type & (PERF_SAMPLE_CALLCHAIN |
+					 PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET))) {
 		if (perf_hpp_list.parent) {
 			ui__error("Selected --sort parent, but no "
 				    "callchain data. Did you call "
@@ -408,7 +409,8 @@ static int report__setup_sample_type(struct report *rep)
 
 	if (symbol_conf.cumulate_callchain) {
 		/* Silently ignore if callchain is missing */
-		if (!(sample_type & PERF_SAMPLE_CALLCHAIN)) {
+		if (!(sample_type & (PERF_SAMPLE_CALLCHAIN |
+				     PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET))) {
 			symbol_conf.cumulate_callchain = false;
 			perf_hpp__cancel_cumulate(session->evlist);
 		}
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 99e9e0c60f14..0c93959574e5 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -498,7 +498,8 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
 		return -EINVAL;
 
 	if (PRINT_FIELD(IP)) {
-		if (evsel__check_stype(evsel, PERF_SAMPLE_IP, "IP", PERF_OUTPUT_IP))
+		if (evsel__check_stype(evsel, PERF_SAMPLE_IP | PERF_SAMPLE_BUILD_ID_OFFSET,
+			       "IP", PERF_OUTPUT_IP))
 			return -EINVAL;
 	}
 
@@ -515,7 +516,8 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
 		return -EINVAL;
 
 	if (PRINT_FIELD(SYM) &&
-	    !(evsel->core.attr.sample_type & (PERF_SAMPLE_IP|PERF_SAMPLE_ADDR))) {
+	    !(evsel->core.attr.sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_ADDR |
+					      PERF_SAMPLE_BUILD_ID_OFFSET))) {
 		pr_err("Display of symbols requested but neither sample IP nor "
 			   "sample address\navailable. Hence, no addresses to convert "
 		       "to symbols.\n");
@@ -527,7 +529,8 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
 		return -EINVAL;
 	}
 	if (PRINT_FIELD(DSO) &&
-	    !(evsel->core.attr.sample_type & (PERF_SAMPLE_IP|PERF_SAMPLE_ADDR))) {
+	    !(evsel->core.attr.sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_ADDR |
+					      PERF_SAMPLE_BUILD_ID_OFFSET))) {
 		pr_err("Display of DSO requested but no address to convert.\n");
 		return -EINVAL;
 	}
@@ -1788,7 +1791,7 @@ static int perf_sample__fprintf_bts(struct perf_sample *sample,
 		unsigned int print_opts = output[type].print_ip_opts;
 		struct callchain_cursor *cursor = NULL;
 
-		if (symbol_conf.use_callchain && sample->callchain) {
+		if (symbol_conf.use_callchain && (sample->callchain || sample->callchain_bids)) {
 			cursor = get_tls_callchain_cursor();
 			if (thread__resolve_callchain(al->thread, cursor,
 						      sample, NULL, NULL,
@@ -2753,7 +2756,7 @@ static void process_event(struct perf_script *script,
 		if (script->stitch_lbr)
 			thread__set_lbr_stitch_enable(al->thread, true);
 
-		if (symbol_conf.use_callchain && sample->callchain) {
+		if (symbol_conf.use_callchain && (sample->callchain || sample->callchain_bids)) {
 			cursor = get_tls_callchain_cursor();
 			if (thread__resolve_callchain(al->thread, cursor,
 						      sample, NULL, NULL,
@@ -3000,7 +3003,7 @@ static int process_deferred_sample_event(const struct perf_tool *tool,
 	if (PRINT_FIELD(IP)) {
 		struct callchain_cursor *cursor = NULL;
 
-		if (symbol_conf.use_callchain && sample->callchain) {
+		if (symbol_conf.use_callchain && (sample->callchain || sample->callchain_bids)) {
 			cursor = get_tls_callchain_cursor();
 			if (thread__resolve_callchain(al.thread, cursor,
 						      sample, NULL, NULL,
@@ -3082,6 +3085,7 @@ static int process_attr(const struct perf_tool *tool, union perf_event *event,
 	/* Enable fields for callchain entries */
 	if (symbol_conf.use_callchain &&
 	    (sample_type & PERF_SAMPLE_CALLCHAIN ||
+	     sample_type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET ||
 	     sample_type & PERF_SAMPLE_BRANCH_STACK ||
 	     (sample_type & PERF_SAMPLE_REGS_USER &&
 	      sample_type & PERF_SAMPLE_STACK_USER))) {
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 31c675cbab63..24a229ee2ada 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1173,7 +1173,8 @@ int sample__resolve_callchain(struct perf_sample *sample,
 			      struct addr_location *al,
 			      int max_stack)
 {
-	if (sample->callchain == NULL && !symbol_conf.show_branchflag_count)
+	if (sample->callchain == NULL && sample->callchain_bids == NULL &&
+	    !symbol_conf.show_branchflag_count)
 		return 0;
 
 	if (symbol_conf.use_callchain || symbol_conf.cumulate_callchain ||
@@ -1186,7 +1187,8 @@ int sample__resolve_callchain(struct perf_sample *sample,
 
 int hist_entry__append_callchain(struct hist_entry *he, struct perf_sample *sample)
 {
-	if ((!symbol_conf.use_callchain || sample->callchain == NULL) &&
+	if ((!symbol_conf.use_callchain ||
+	     (sample->callchain == NULL && sample->callchain_bids == NULL)) &&
 		!symbol_conf.show_branchflag_count)
 		return 0;
 	return callchain_append(he->callchain, get_tls_callchain_cursor(), sample->period);
@@ -1912,32 +1914,75 @@ int sample__for_each_callchain_node(struct thread *thread,
 int sample__merge_deferred_callchain(struct perf_sample *sample_orig,
 				     struct perf_sample *sample_callchain)
 {
-	u64 nr_orig = sample_orig->callchain->nr - 1;
-	u64 nr_deferred = sample_callchain->callchain->nr;
-	struct ip_callchain *callchain;
-
-	if (sample_orig->merged_callchain) {
-		/* Already merged. */
-		return -EINVAL;
+	if (sample_orig->deferred_bid && sample_callchain->callchain_bids_nr > 0) {
+		const struct perf_sample_build_id_offset *entry =
+			&sample_callchain->callchain_bids[0];
+
+		memcpy(sample_orig->bid.deferred_storage, &entry->bid,
+		       sizeof(struct perf_build_id));
+		sample_orig->bid.bid =
+			(struct perf_build_id *)sample_orig->bid.deferred_storage;
+		sample_orig->bid.offset = entry->offset;
+		if (!sample_orig->evsel ||
+		    !(sample_orig->evsel->core.attr.sample_type & PERF_SAMPLE_IP))
+			sample_orig->ip = entry->offset;
+		sample_orig->deferred_bid = false;
+	}
+
+	if (sample_orig->callchain_bids_nr >= 2 &&
+	    sample_callchain->callchain_bids_nr > 0) {
+		u64 nr_orig = sample_orig->callchain_bids_nr - 1;
+		u64 nr_deferred = sample_callchain->callchain_bids_nr;
+
+		if (sample_orig->callchain_bids[nr_orig - 1].offset ==
+		    PERF_CONTEXT_USER_DEFERRED) {
+			struct perf_sample_build_id_offset *bids =
+				calloc(nr_orig + nr_deferred, sizeof(*bids));
+
+			if (bids == NULL)
+				return -ENOMEM;
+
+			memcpy(bids, sample_orig->callchain_bids,
+			       nr_orig * sizeof(*bids));
+			memcpy(&bids[nr_orig], sample_callchain->callchain_bids,
+			       nr_deferred * sizeof(*bids));
+			if (sample_orig->merged_callchain_bids)
+				free(sample_orig->callchain_bids);
+			sample_orig->callchain_bids = bids;
+			sample_orig->callchain_bids_nr = nr_orig + nr_deferred;
+			sample_orig->merged_callchain_bids = true;
+		}
 	}
 
-	if (sample_orig->callchain->nr < 2) {
-		sample_orig->deferred_callchain = false;
-		return -EINVAL;
-	}
+	if (sample_orig->callchain && sample_callchain->callchain) {
+		u64 nr_orig = sample_orig->callchain->nr - 1;
+		u64 nr_deferred = sample_callchain->callchain->nr;
+		struct ip_callchain *callchain;
 
-	callchain = calloc(1 + nr_orig + nr_deferred, sizeof(u64));
-	if (callchain == NULL)
-		return -ENOMEM;
+		if (sample_orig->merged_callchain) {
+			/* Already merged. */
+			return -EINVAL;
+		}
 
-	callchain->nr = nr_orig + nr_deferred;
-	/* copy original including PERF_CONTEXT_USER_DEFERRED (but the cookie) */
-	memcpy(callchain->ips, sample_orig->callchain->ips, nr_orig * sizeof(u64));
-	/* copy deferred user callchains */
-	memcpy(&callchain->ips[nr_orig], sample_callchain->callchain->ips,
-	       nr_deferred * sizeof(u64));
+		if (sample_orig->callchain->nr < 2) {
+			sample_orig->deferred_callchain = false;
+			return -EINVAL;
+		}
+
+		callchain = calloc(1 + nr_orig + nr_deferred, sizeof(u64));
+		if (callchain == NULL)
+			return -ENOMEM;
+
+		callchain->nr = nr_orig + nr_deferred;
+		/* copy original including PERF_CONTEXT_USER_DEFERRED (but the cookie) */
+		memcpy(callchain->ips, sample_orig->callchain->ips, nr_orig * sizeof(u64));
+		/* copy deferred user callchains */
+		memcpy(&callchain->ips[nr_orig], sample_callchain->callchain->ips,
+		       nr_deferred * sizeof(u64));
+
+		sample_orig->merged_callchain = true;
+		sample_orig->callchain = callchain;
+	}
 
-	sample_orig->merged_callchain = true;
-	sample_orig->callchain = callchain;
 	return 0;
 }
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index e927e707abac..ae47966ff6af 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -294,6 +294,33 @@ struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short)
 	return res;
 }
 
+struct dsos__find_build_id_cb_args {
+	const struct build_id *bid;
+	struct dso *res;
+};
+
+static int dsos__find_build_id_cb(struct dso *dso, void *data)
+{
+	struct dsos__find_build_id_cb_args *args = data;
+
+	if (dso__build_id_equal(dso, args->bid)) {
+		args->res = dso__get(dso);
+		return 1;
+	}
+	return 0;
+}
+
+struct dso *dsos__find_by_build_id(struct dsos *dsos, const struct build_id *bid)
+{
+	struct dsos__find_build_id_cb_args args = {
+		.bid = bid,
+		.res = NULL,
+	};
+
+	dsos__for_each_dso(dsos, dsos__find_build_id_cb, &args);
+	return args.res;
+}
+
 static void dso__set_basename(struct dso *dso)
 {
 	bool allocated = false;
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index a26774950866..1b9d71c5857e 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -8,6 +8,7 @@
 #include <linux/rbtree.h>
 #include "rwsem.h"
 
+struct build_id;
 struct dso;
 struct dso_id;
 struct kmod_path;
@@ -31,6 +32,7 @@ void dsos__exit(struct dsos *dsos);
 int __dsos__add(struct dsos *dsos, struct dso *dso);
 int dsos__add(struct dsos *dsos, struct dso *dso);
 struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
+struct dso *dsos__find_by_build_id(struct dsos *dsos, const struct build_id *bid);
 
 struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, const struct dso_id *id);
  
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index cd13a0c3cb52..0483d0b25d19 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -702,7 +702,6 @@ struct map *thread__find_map(struct thread *thread, struct perf_sample *sample,
 	thread__zput(al->thread);
 	al->thread = thread__get(thread);
 
-	al->addr = sample->ip;
 	al->cpumode = sample->cpumode;
 	al->filtered = 0;
 
@@ -735,15 +734,31 @@ struct map *thread__find_map(struct thread *thread, struct perf_sample *sample,
 
 		return NULL;
 	}
-	al->map = maps__find(maps, al->addr);
-	if (al->map != NULL) {
-		/*
-		 * Kernel maps might be changed when loading symbols so loading
-		 * must be done prior to using kernel maps.
-		 */
-		if (load_map)
-			map__load(al->map);
-		al->addr = map__map_ip(al->map, al->addr);
+
+	if (sample->bid.bid && sample->bid.bid->size > 0) {
+		struct build_id bid;
+
+		build_id__init(&bid, sample->bid.bid->data, sample->bid.bid->size);
+		al->addr = sample->bid.offset;
+		al->map = maps__find_by_build_id(maps, &bid);
+		if (al->map != NULL) {
+			if (load_map)
+				map__load(al->map);
+			/* al->addr is already a file offset */
+		}
+	} else {
+		/* When bid.bid->size == 0, bid.ip holds the fallback virtual address. */
+		al->addr = sample->bid.bid ? sample->bid.ip : sample->ip;
+		al->map = maps__find(maps, al->addr);
+		if (al->map != NULL) {
+			/*
+			 * Kernel maps might be changed when loading symbols so loading
+			 * must be done prior to using kernel maps.
+			 */
+			if (load_map)
+				map__load(al->map);
+			al->addr = map__map_ip(al->map, al->addr);
+		}
 	}
 
 	return al->map;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 9c5e7510f0c0..08e9e6567bed 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3423,6 +3423,21 @@ static int __set_offcpu_sample(struct perf_sample *data)
 	return -EFAULT;
 }
 
+/*
+ * Before __evsel__parse_sample() is called on a cross-endian perf.data file,
+ * perf_event__all64_swap() has already byte-swapped the entire PERF_RECORD_SAMPLE
+ * payload in 64-bit chunks. That leaves 64-bit fields (like offset, ip, cookie)
+ * in host endianness, but scrambles the 24-byte struct perf_build_id (which
+ * contains a 16-bit reserved field, a 1-byte size, and a 20-byte byte array).
+ * Undo the 64-bit chunk swap on struct perf_build_id and byte-swap its 16-bit
+ * field.
+ */
+static void perf_build_id__undo_bswap_64(struct perf_build_id *bid)
+{
+	mem_bswap_64(bid, sizeof(*bid));
+	bid->__reserved_2 = bswap_16(bid->__reserved_2);
+}
+
 int __evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			  struct perf_sample *data, bool needs_swap)
 {
@@ -3450,11 +3465,23 @@ int __evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	data->vcpu = -1;
 
 	if (event->header.type == PERF_RECORD_CALLCHAIN_DEFERRED) {
-		const u64 max_callchain_nr = UINT64_MAX / sizeof(u64);
+		if (event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID) {
+			const size_t entry_sz = sizeof(struct perf_sample_build_id_offset);
+			const u64 max_nr = UINT64_MAX / entry_sz;
+			u64 nr = event->callchain_deferred.nr;
 
-		data->callchain = (struct ip_callchain *)&event->callchain_deferred.nr;
-		if (data->callchain->nr > max_callchain_nr)
-			goto out_efault;
+			if (nr > max_nr)
+				goto out_efault;
+			OVERFLOW_CHECK(event->callchain_deferred.bids, nr * entry_sz, max_size);
+			data->callchain_bids = event->callchain_deferred.bids;
+			data->callchain_bids_nr = nr;
+		} else {
+			const u64 max_callchain_nr = UINT64_MAX / sizeof(u64);
+
+			data->callchain = (struct ip_callchain *)&event->callchain_deferred.nr;
+			if (data->callchain->nr > max_callchain_nr)
+				goto out_efault;
+		}
 
 		data->deferred_cookie = event->callchain_deferred.cookie;
 
@@ -3885,6 +3912,85 @@ int __evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		array = (void *)array + sz;
 	}
 
+	if (type & PERF_SAMPLE_BUILD_ID_OFFSET) {
+		const struct perf_sample_build_id_offset *entry =
+			(const struct perf_sample_build_id_offset *)array;
+
+		OVERFLOW_CHECK(array, sizeof(*entry), max_size);
+		if (evsel->core.attr.defer_callchain && entry->zero == 0 &&
+		    entry->context == PERF_CONTEXT_USER_DEFERRED) {
+			data->deferred_bid = true;
+			data->deferred_callchain = true;
+			data->deferred_cookie = entry->cookie;
+			data->bid.bid = (struct perf_build_id *)&entry->bid;
+			data->bid.offset = entry->ip;
+		} else {
+			if (swapped) {
+				struct perf_build_id *bid =
+					(void *)data->bid.deferred_storage;
+
+				/*
+				 * perf_event__all64_swap() already swapped the
+				 * sample in 64-bit chunks, so entry->offset is
+				 * already in host endianness; undo the 64-bit
+				 * swap on the build ID bytes.
+				 */
+				memcpy(bid, &entry->bid, sizeof(*bid));
+				perf_build_id__undo_bswap_64(bid);
+				data->bid.bid = bid;
+			} else {
+				data->bid.bid = (struct perf_build_id *)&entry->bid;
+			}
+			data->bid.offset = entry->offset;
+		}
+		if (!(type & PERF_SAMPLE_IP))
+			data->ip = data->bid.offset;
+		array += sizeof(*entry) / sizeof(u64);
+	} else {
+		data->bid.bid = NULL;
+		data->bid.offset = 0;
+	}
+
+	if (type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET) {
+		const size_t entry_sz = sizeof(struct perf_sample_build_id_offset);
+		const u64 max_callchain_nr = UINT64_MAX / entry_sz;
+
+		OVERFLOW_CHECK_u64(array);
+		sz = *array++;
+		if (sz > max_callchain_nr)
+			goto out_efault;
+
+		OVERFLOW_CHECK(array, sz * entry_sz, max_size);
+		if (evsel->core.attr.defer_callchain && sz >= 2 &&
+		    array[(sz - 2) * 4 + 3] == PERF_CONTEXT_USER_DEFERRED) {
+			data->deferred_cookie = array[(sz - 1) * 4 + 3];
+			data->deferred_callchain = true;
+		}
+		if (swapped && sz > 0) {
+			struct perf_sample_build_id_offset *bids = calloc(sz, entry_sz);
+
+			if (!bids)
+				goto out_efault;
+			/*
+			 * perf_event__all64_swap() already swapped each 64-bit
+			 * word (including bids[i].offset); undo the 64-bit swap
+			 * on each build ID.
+			 */
+			memcpy(bids, array, sz * entry_sz);
+			for (u64 i = 0; i < sz; i++)
+				perf_build_id__undo_bswap_64(&bids[i].bid);
+			data->callchain_bids = bids;
+			data->merged_callchain_bids = true;
+		} else {
+			data->callchain_bids = (struct perf_sample_build_id_offset *)array;
+		}
+		data->callchain_bids_nr = sz;
+		array += sz * entry_sz / sizeof(u64);
+	} else {
+		data->callchain_bids = NULL;
+		data->callchain_bids_nr = 0;
+	}
+
 	if (evsel__is_offcpu_event(evsel)) {
 		if (__set_offcpu_sample(data))
 			goto out_efault;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 174f3414fd3c..d4aa0191a1fd 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -569,7 +569,8 @@ static inline bool evsel__has_callchain(const struct evsel *evsel)
 	 * For reporting purposes, an evsel sample can have a recorded callchain
 	 * or a callchain synthesized from AUX area data.
 	 */
-	return evsel->core.attr.sample_type & PERF_SAMPLE_CALLCHAIN ||
+	return evsel->core.attr.sample_type & (PERF_SAMPLE_CALLCHAIN |
+				       PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET) ||
 	       evsel->synth_sample_type & PERF_SAMPLE_CALLCHAIN;
 }
 
diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index 0f7a25500a44..e91411a1ac18 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -131,7 +131,7 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 	if (cursor == NULL)
 		return fprintf(fp, "<not enough memory for the callchain cursor>%s", print_oneline ? "" : "\n");
 
-	if (sample->callchain) {
+	if (sample->callchain || sample->callchain_bids) {
 		callchain_cursor_commit(cursor);
 
 		while (1) {
@@ -232,8 +232,11 @@ int sample__fprintf_sym(struct perf_sample *sample, struct addr_location *al,
 	} else {
 		printed += fprintf(fp, "%-*.*s", left_alignment, left_alignment, " ");
 
-		if (print_ip)
-			printed += fprintf(fp, "%16" PRIx64, sample->ip);
+		if (print_ip) {
+			u64 ip = sample->bid.bid ? sample->bid.offset : sample->ip;
+
+			printed += fprintf(fp, "%16" PRIx64, ip);
+		}
 
 		if (print_sym) {
 			printed += fprintf(fp, " ");
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 1a13253d0c7f..99dc47e95938 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2221,7 +2221,9 @@ static int add_callchain_ip(struct thread *thread,
 			    struct branch_flags *flags,
 			    struct iterations *iter,
 			    u64 branch_from,
-			    bool symbols)
+			    bool symbols,
+			      struct perf_build_id *bid,
+			      u64 offset)
 {
 	static __thread struct perf_sample sample;
 	struct map_symbol ms = {};
@@ -2235,6 +2237,8 @@ static int add_callchain_ip(struct thread *thread,
 	al.sym = NULL;
 	al.srcline = NULL;
 	sample.ip = ip;
+	sample.bid.bid = bid;
+	sample.bid.offset = offset;
 	if (!cpumode) {
 		thread__find_cpumode_addr_location(thread, &sample, symbols, &al);
 	} else {
@@ -2295,6 +2299,9 @@ static int add_callchain_ip(struct thread *thread,
 	ms.map = map__get(al.map);
 	ms.sym = al.sym;
 
+	if (bid && bid->size > 0 && al.map)
+		ip = map__unmap_ip(al.map, al.addr);
+
 	if (append_inlines(cursor, &ms, ip, branch, flags, nr_loop_iter,
 			   iter_cycles, branch_from) == 0)
 		goto out;
@@ -2410,10 +2417,17 @@ static int lbr_callchain_add_kernel_ip(struct thread *thread,
 
 	if (callee) {
 		for (i = 0; i < end + 1; i++) {
+			struct perf_build_id *bid = NULL;
+			u64 offset = 0;
+
+			if (sample->callchain_bids && i < (int)sample->callchain_bids_nr) {
+				bid = &sample->callchain_bids[i].bid;
+				offset = sample->callchain_bids[i].offset;
+			}
 			err = add_callchain_ip(thread, cursor, parent,
 					       root_al, &cpumode, chain->ips[i],
 					       false, NULL, NULL, branch_from,
-					       symbols);
+					       symbols, bid, offset);
 			if (err)
 				return err;
 		}
@@ -2421,10 +2435,17 @@ static int lbr_callchain_add_kernel_ip(struct thread *thread,
 	}
 
 	for (i = end; i >= 0; i--) {
+		struct perf_build_id *bid = NULL;
+		u64 offset = 0;
+
+		if (sample->callchain_bids && i < (int)sample->callchain_bids_nr) {
+			bid = &sample->callchain_bids[i].bid;
+			offset = sample->callchain_bids[i].offset;
+		}
 		err = add_callchain_ip(thread, cursor, parent,
 				       root_al, &cpumode, chain->ips[i],
 				       false, NULL, NULL, branch_from,
-				       symbols);
+				       symbols, bid, offset);
 		if (err)
 			return err;
 	}
@@ -2507,7 +2528,7 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 		err = add_callchain_ip(thread, cursor, parent,
 				       root_al, &cpumode, ip,
 				       true, flags, NULL,
-				       *branch_from, symbols);
+				       *branch_from, symbols, /*bid=*/NULL, /*offset=*/0);
 		if (err)
 			return err;
 
@@ -2532,7 +2553,7 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 			err = add_callchain_ip(thread, cursor, parent,
 					       root_al, &cpumode, ip,
 					       true, flags, NULL,
-					       *branch_from, symbols);
+					       *branch_from, symbols, /*bid=*/NULL, /*offset=*/0);
 			if (err)
 				return err;
 			save_lbr_cursor_node(thread, cursor, i);
@@ -2547,7 +2568,7 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 		err = add_callchain_ip(thread, cursor, parent,
 				       root_al, &cpumode, ip,
 				       true, flags, NULL,
-				       *branch_from, symbols);
+				       *branch_from, symbols, /*bid=*/NULL, /*offset=*/0);
 		if (err)
 			return err;
 		save_lbr_cursor_node(thread, cursor, i);
@@ -2567,7 +2588,7 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 		err = add_callchain_ip(thread, cursor, parent,
 				root_al, &cpumode, ip,
 				true, flags, NULL,
-				*branch_from, symbols);
+				*branch_from, symbols, /*bid=*/NULL, /*offset=*/0);
 		if (err)
 			return err;
 	}
@@ -2740,12 +2761,16 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 {
 	bool callee = (callchain_param.order == ORDER_CALLEE);
 	struct ip_callchain *chain = sample->callchain;
-	int chain_nr = min(max_stack, (int)chain->nr), i;
+	int chain_nr, i;
 	struct lbr_stitch *lbr_stitch;
 	bool stitched_lbr = false;
 	u64 branch_from = 0;
 	int err;
 
+	if (!chain)
+		return 0;
+
+	chain_nr = min(max_stack, (int)chain->nr);
 	for (i = 0; i < chain_nr; i++) {
 		if (chain->ips[i] == PERF_CONTEXT_USER)
 			break;
@@ -2831,7 +2856,8 @@ static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
 		if (ip >= PERF_CONTEXT_MAX) {
 			err = add_callchain_ip(thread, cursor, parent,
 					       root_al, cpumode, ip,
-					       false, NULL, NULL, 0, symbols);
+					       false, NULL, NULL, 0, symbols,
+					       /*bid=*/NULL, /*offset=*/0);
 			break;
 		}
 	}
@@ -2859,6 +2885,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 	struct branch_stack *branch = sample->branch_stack;
 	struct branch_entry *entries = perf_sample__branch_entries(sample);
 	struct ip_callchain *chain = sample->callchain;
+	struct ip_callchain *alloc_chain = NULL;
 	int chain_nr = 0;
 	u8 cpumode = PERF_RECORD_MISC_USER;
 	int i, j, err, nr_entries, usr_idx;
@@ -2866,6 +2893,17 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 	int first_call = 0;
 	u64 leaf_frame_caller;
 
+	if (!chain && sample->callchain_bids_nr > 0) {
+		alloc_chain = malloc(sizeof(*chain) + sample->callchain_bids_nr * sizeof(u64));
+		if (!alloc_chain)
+			return -ENOMEM;
+		alloc_chain->nr = sample->callchain_bids_nr;
+		for (i = 0; i < (int)sample->callchain_bids_nr; i++)
+			alloc_chain->ips[i] = sample->callchain_bids[i].offset;
+		chain = alloc_chain;
+		sample->callchain = alloc_chain;
+	}
+
 	if (chain)
 		chain_nr = chain->nr;
 
@@ -2876,8 +2914,10 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 						   root_al, max_stack,
 						   !env ? 0 : env->max_branches,
 						   symbols);
-		if (err)
-			return (err < 0) ? err : 0;
+		if (err) {
+			err = (err < 0) ? err : 0;
+			goto out;
+		}
 	}
 
 	/*
@@ -2940,22 +2980,26 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 					       root_al,
 					       NULL, be[i].to,
 					       true, &be[i].flags,
-					       NULL, be[i].from, symbols);
+					       NULL, be[i].from, symbols,
+					       /*bid=*/NULL, /*offset=*/0);
 
 			if (!err) {
 				err = add_callchain_ip(thread, cursor, parent, root_al,
 						       NULL, be[i].from,
 						       true, &be[i].flags,
-						       &iter[i], 0, symbols);
+						       &iter[i], 0, symbols,
+						       /*bid=*/NULL, /*offset=*/0);
 			}
 			if (err == -EINVAL)
 				break;
 			if (err)
-				return err;
+				goto out;
 		}
 
-		if (chain_nr == 0)
-			return 0;
+		if (chain_nr == 0) {
+			err = 0;
+			goto out;
+		}
 
 		chain_nr -= nr;
 	}
@@ -2964,12 +3008,16 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 	if (chain && callchain_param.order != ORDER_CALLEE) {
 		err = find_prev_cpumode(chain, thread, cursor, parent, root_al,
 					&cpumode, chain->nr - first_call, symbols);
-		if (err)
-			return (err < 0) ? err : 0;
+		if (err) {
+			err = (err < 0) ? err : 0;
+			goto out;
+		}
 	}
 	for (i = first_call, nr_entries = 0;
 	     i < chain_nr && nr_entries < max_stack; i++) {
 		u64 ip;
+		struct perf_build_id *bid = NULL;
+		u64 offset = 0;
 
 		if (callchain_param.order == ORDER_CALLEE)
 			j = i;
@@ -2981,13 +3029,19 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 			continue;
 #endif
 		ip = chain->ips[j];
+		if (sample->callchain_bids && j < (int)sample->callchain_bids_nr) {
+			bid = &sample->callchain_bids[j].bid;
+			offset = sample->callchain_bids[j].offset;
+		}
 		if (ip < PERF_CONTEXT_MAX)
                        ++nr_entries;
 		else if (callchain_param.order != ORDER_CALLEE) {
 			err = find_prev_cpumode(chain, thread, cursor, parent,
 						root_al, &cpumode, j, symbols);
-			if (err)
-				return (err < 0) ? err : 0;
+			if (err) {
+				err = (err < 0) ? err : 0;
+				goto out;
+			}
 			continue;
 		}
 
@@ -3013,21 +3067,32 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 
 				err = add_callchain_ip(thread, cursor, parent,
 						root_al, &cpumode, leaf_frame_caller,
-						false, NULL, NULL, 0, symbols);
-				if (err)
-					return (err < 0) ? err : 0;
+						false, NULL, NULL, 0, symbols,
+						/*bid=*/NULL, /*offset=*/0);
+				if (err) {
+					err = (err < 0) ? err : 0;
+					goto out;
+				}
 			}
 		}
 
 		err = add_callchain_ip(thread, cursor, parent,
 				       root_al, &cpumode, ip,
-				       false, NULL, NULL, 0, symbols);
+				       false, NULL, NULL, 0, symbols, bid, offset);
 
-		if (err)
-			return (err < 0) ? err : 0;
+		if (err) {
+			err = (err < 0) ? err : 0;
+			goto out;
+		}
 	}
 
-	return 0;
+	err = 0;
+out:
+	if (alloc_chain) {
+		sample->callchain = NULL;
+		free(alloc_chain);
+	}
+	return err;
 }
 
 static int unwind_entry(struct unwind_entry *entry, void *arg)
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index f808df2fe77b..1e83332ea00a 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -2,8 +2,11 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <linux/zalloc.h>
+#include "build-id.h"
 #include "debug.h"
 #include "dso.h"
+#include "dsos.h"
+#include "machine.h"
 #include "map.h"
 #include "maps.h"
 #include "rwsem.h"
@@ -1251,6 +1254,62 @@ static int map__strcmp_name(const void *name, const void *b)
 	return strcmp(name, dso__short_name(dso));
 }
 
+struct map *maps__find_by_build_id(struct maps *maps, struct build_id *bid)
+{
+	struct map *result = NULL;
+
+	down_read(maps__lock(maps));
+	for (unsigned int i = 0, n = maps__nr_maps(maps); i < n; i++) {
+		struct map *map = maps__maps_by_address(maps)[i];
+
+		if (dso__build_id_equal(map__dso(map), bid)) {
+			result = map__get(map);
+			break;
+		}
+	}
+	up_read(maps__lock(maps));
+
+	if (!result && maps__machine(maps)) {
+		struct machine *machine = maps__machine(maps);
+		struct dso *dso = dsos__find_by_build_id(&machine->dsos, bid);
+
+		if (!dso) {
+			char sbuild_id[SBUILD_ID_SIZE];
+			char *origname;
+
+			build_id__snprintf(bid, sbuild_id, sizeof(sbuild_id));
+			origname = build_id_cache__origname(sbuild_id);
+			if (origname) {
+				struct dso_id id = { .build_id = *bid };
+
+				dso = dsos__findnew_id(&machine->dsos, origname, &id);
+				free(origname);
+			}
+		}
+		if (dso) {
+			down_write(maps__lock(maps));
+			for (unsigned int i = 0, n = maps__nr_maps(maps); i < n; i++) {
+				struct map *map = maps__maps_by_address(maps)[i];
+
+				if (dso__build_id_equal(map__dso(map), bid)) {
+					result = map__get(map);
+					break;
+				}
+			}
+			if (!result) {
+				result = map__new2(0, dso);
+				if (result && __maps__insert(maps, result)) {
+					map__put(result);
+					result = NULL;
+				}
+			}
+			up_write(maps__lock(maps));
+			dso__put(dso);
+		}
+	}
+	return result;
+}
+
 struct map *maps__find_by_name(struct maps *maps, const char *name)
 {
 	struct map *result = NULL;
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index 4ec9b7453a3b..6f1791457068 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -11,6 +11,7 @@ struct ref_reloc_sym;
 struct machine;
 struct map;
 struct maps;
+struct build_id;
 
 #define KMAP_NAME_LEN 256
 
@@ -76,6 +77,7 @@ int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams);
 int maps__fixup_overlap_and_insert(struct maps *maps, struct map *new);
 
 struct map *maps__find_by_name(struct maps *maps, const char *name);
+struct map *maps__find_by_build_id(struct maps *maps, struct build_id *bid);
 
 struct map *maps__find_next_entry(struct maps *maps, struct map *map);
 
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 2e8be9a357dc..dd653da923c4 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -40,7 +40,8 @@ static void __p_sample_type(char *buf, size_t size, u64 value)
 		bit_name(IDENTIFIER), bit_name(REGS_INTR), bit_name(DATA_SRC),
 		bit_name(WEIGHT), bit_name(PHYS_ADDR), bit_name(AUX),
 		bit_name(CGROUP), bit_name(DATA_PAGE_SIZE), bit_name(CODE_PAGE_SIZE),
-		bit_name(WEIGHT_STRUCT),
+		bit_name(WEIGHT_STRUCT), bit_name(BUILD_ID_OFFSET),
+		bit_name(CALLCHAIN_BUILD_ID_OFFSET),
 		{ .name = NULL, }
 	};
 #undef bit_name
diff --git a/tools/perf/util/sample.c b/tools/perf/util/sample.c
index bccc19e2aaf2..1513eda8765b 100644
--- a/tools/perf/util/sample.c
+++ b/tools/perf/util/sample.c
@@ -24,11 +24,15 @@ void perf_sample__init(struct perf_sample *sample, bool all)
 	if (all) {
 		memset(sample, 0, sizeof(*sample));
 	} else {
+		sample->ip = 0;
 		sample->evsel = NULL;
 		sample->user_regs = NULL;
 		sample->intr_regs = NULL;
 		sample->merged_callchain = false;
 		sample->callchain = NULL;
+		sample->merged_callchain_bids = false;
+		sample->callchain_bids = NULL;
+		sample->callchain_bids_nr = 0;
 	}
 }
 
@@ -42,6 +46,11 @@ void perf_sample__exit(struct perf_sample *sample)
 		zfree(&sample->callchain);
 		sample->merged_callchain = false;
 	}
+	if (sample->merged_callchain_bids) {
+		zfree(&sample->callchain_bids);
+		sample->callchain_bids_nr = 0;
+		sample->merged_callchain_bids = false;
+	}
 }
 
 struct regs_dump *perf_sample__user_regs(struct perf_sample *sample)
diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index cb4b16654876..adf2ff1bd13b 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -7,7 +7,9 @@
 
 struct evsel;
 struct machine;
+struct perf_sample_build_id_offset;
 struct thread;
+struct perf_build_id;
 
 /* number of register is bound by the number of bits in regs_dump::mask (64) */
 #define PERF_SAMPLE_REGS_CACHE_SIZE (8 * sizeof(u64))
@@ -163,6 +165,22 @@ struct perf_sample {
 	u64 code_page_size;
 	/** @cgroup: The sample event PERF_SAMPLE_CGROUP value. */
 	u64 cgroup;
+	/** @bid: The sample event PERF_SAMPLE_BUILD_ID_OFFSET value. */
+	struct {
+		struct perf_build_id *bid;
+		union {
+			u64 offset;
+			u64 ip;
+		};
+		u64 deferred_storage[3];
+	} bid;
+	/**
+	 * @callchain_bids: Build IDs for the callchain when
+	 * PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET is set.
+	 */
+	struct perf_sample_build_id_offset *callchain_bids;
+	/** @callchain_bids_nr: Number of entries in callchain_bids. */
+	u32 callchain_bids_nr;
 	/** @file_offset: Byte offset of this event in the perf.data file. */
 	u64 file_offset;
 	/** @flags: Extra flag data from auxiliary events like intel-pt. */
@@ -205,11 +223,21 @@ struct perf_sample {
 	 *                      user callchain marker was encountered.
 	 */
 	bool deferred_callchain;
+	/**
+	 * @deferred_bid: When processing PERF_SAMPLE_BUILD_ID_OFFSET a deferred
+	 *                user marker was encountered.
+	 */
+	bool deferred_bid;
 	/**
 	 * @merged_callchain: A synthesized merged callchain that is allocated
 	 *                    and needs freeing.
 	 */
 	bool merged_callchain;
+	/**
+	 * @merged_callchain_bids: A synthesized merged callchain_bids that is
+	 *                         allocated and needs freeing.
+	 */
+	bool merged_callchain_bids;
 	/**
 	 * @deferred_cookie: Identifier of the deferred callchain in the later
 	 *                   PERF_RECORD_CALLCHAIN_DEFERRED event.
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 5e113070b3c6..d952e186dcf6 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -21,6 +21,7 @@
 
 #include "map_symbol.h"
 #include "branch.h"
+#include "build-id.h"
 #include "debug.h"
 #include "dwarf-regs.h"
 #include "env.h"
@@ -1326,15 +1327,17 @@ static void callchain__lbr_callstack_printf(struct perf_sample *sample)
 	struct ip_callchain *callchain = sample->callchain;
 	struct branch_stack *lbr_stack = sample->branch_stack;
 	struct branch_entry *entries = perf_sample__branch_entries(sample);
-	u64 kernel_callchain_nr = callchain->nr;
+	u64 kernel_callchain_nr = callchain ? callchain->nr : sample->callchain_bids_nr;
 	unsigned int i;
 
 	for (i = 0; i < kernel_callchain_nr; i++) {
-		if (callchain->ips[i] == PERF_CONTEXT_USER)
+		u64 ip = callchain ? callchain->ips[i] : sample->callchain_bids[i].offset;
+
+		if (ip == PERF_CONTEXT_USER)
 			break;
 	}
 
-	if ((i != kernel_callchain_nr) && lbr_stack->nr) {
+	if ((i != kernel_callchain_nr) && lbr_stack && lbr_stack->nr) {
 		u64 total_nr;
 		/*
 		 * LBR callstack can only get user call chain,
@@ -1357,9 +1360,11 @@ static void callchain__lbr_callstack_printf(struct perf_sample *sample)
 
 		printf("... LBR call chain: nr:%" PRIu64 "\n", total_nr);
 
-		for (i = 0; i < kernel_callchain_nr; i++)
-			printf("..... %2d: %016" PRIx64 "\n",
-			       i, callchain->ips[i]);
+		for (i = 0; i < kernel_callchain_nr; i++) {
+			u64 ip = callchain ? callchain->ips[i] : sample->callchain_bids[i].offset;
+
+			printf("..... %2d: %016" PRIx64 "\n", i, ip);
+		}
 
 		printf("..... %2d: %016" PRIx64 "\n",
 		       (int)(kernel_callchain_nr), entries[0].to);
@@ -1400,12 +1405,24 @@ static void callchain__printf(struct evsel *evsel,
 	if (evsel__has_branch_callstack(evsel))
 		callchain__lbr_callstack_printf(sample);
 
-	printf("... FP chain: nr:%" PRIu64 "\n", callchain->nr);
+	if (callchain) {
+		printf("... FP chain: nr:%" PRIu64 "\n", callchain->nr);
 
-	for (i = 0; i < callchain->nr; i++)
-		printf("..... %2d: %016" PRIx64 "%s\n",
-		       i, callchain->ips[i],
-		       callchain_context_str(callchain->ips[i]));
+		for (i = 0; i < callchain->nr; i++)
+			printf("..... %2d: %016" PRIx64 "%s\n",
+			       i, callchain->ips[i],
+			       callchain_context_str(callchain->ips[i]));
+	} else if (sample->callchain_bids) {
+		printf("... FP chain (build ID + offset): nr:%u\n",
+		       sample->callchain_bids_nr);
+
+		for (i = 0; i < sample->callchain_bids_nr; i++) {
+			u64 offset = sample->callchain_bids[i].offset;
+
+			printf("..... %2d: %016" PRIx64 "%s\n",
+			       i, offset, callchain_context_str(offset));
+		}
+	}
 
 	if (sample->deferred_callchain)
 		printf("...... (deferred)\n");
@@ -1730,6 +1747,17 @@ static void dump_sample(struct machine *machine, union perf_event *event,
 	       event->header.misc, sample->pid, sample->tid, sample->ip,
 	       sample->period, sample->addr);
 
+	if (sample_type & PERF_SAMPLE_BUILD_ID_OFFSET) {
+		struct build_id bid;
+		char sbuild_id[SBUILD_ID_SIZE] = "";
+
+		if (sample->bid.bid) {
+			build_id__init(&bid, sample->bid.bid->data, sample->bid.bid->size);
+			build_id__snprintf(&bid, sbuild_id, sizeof(sbuild_id));
+		}
+		printf("... build_id: %s offset: %#" PRIx64 "\n", sbuild_id, sample->bid.offset);
+	}
+
 	if (evsel__has_callchain(evsel))
 		callchain__printf(evsel, sample);
 
@@ -1783,7 +1811,7 @@ static void dump_deferred_callchain(union perf_event *event, struct perf_sample
 	printf("(IP, 0x%x): %d/%d: %#" PRIx64 "\n",
 	       event->header.misc, sample->pid, sample->tid, sample->deferred_cookie);
 
-	if (evsel__has_callchain(evsel))
+	if (evsel__has_callchain(evsel) || sample->callchain_bids)
 		callchain__printf(evsel, sample);
 }
 
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 4d552150bc04..e1c04f4ee76e 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1711,6 +1711,13 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 		result += sample->aux_sample.size;
 	}
 
+	if (type & PERF_SAMPLE_BUILD_ID_OFFSET)
+		result += sizeof(struct perf_build_id) + sizeof(u64);
+
+	if (type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET)
+		result += sizeof(u64) + sample->callchain_bids_nr *
+			  (sizeof(struct perf_build_id) + sizeof(u64));
+
 	return result;
 }
 
@@ -1967,6 +1974,27 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
 		array = (void *)array + sz;
 	}
 
+	if (type & PERF_SAMPLE_BUILD_ID_OFFSET) {
+		if (sample->bid.bid) {
+			memcpy(array, sample->bid.bid, sizeof(struct perf_build_id));
+			array += sizeof(struct perf_build_id) / sizeof(u64);
+			*array++ = sample->bid.offset;
+		} else {
+			memset(array, 0, sizeof(struct perf_build_id));
+			array += sizeof(struct perf_build_id) / sizeof(u64);
+			*array++ = sample->ip;
+		}
+	}
+
+	if (type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET) {
+		*array++ = sample->callchain_bids_nr;
+		if (sample->callchain_bids && sample->callchain_bids_nr) {
+			sz = sample->callchain_bids_nr * sizeof(*sample->callchain_bids);
+			memcpy(array, sample->callchain_bids, sz);
+			array += sz / sizeof(u64);
+		}
+	}
+
 	return 0;
 }
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

