Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795567914;
	b=Bitd97AYQ1yqmKCxupMVyd4vs2WWV+l83SyYt8RY5hQ09YbY5becW5g1H9w4J+ChtEk3
	 KENPGxwB/w0ymq3jO15m/yHMRLuke77PXxQWFqIOsHA2LyHfdlbX82X8tZAZjgSHJR7E1
	 Kj2dPcgR9lY+r0jjwX4r94jvAnaV5LOc10eJrM6YPcro6avqchQq/cLw9oWUK3bZAvkfh
	 GH0rECS9fzdOiWDN2Ydq8KOXLkRO42sWq/+53EE1VgPPSHi21cDGAfZUIBJA53HwcU8Bo
	 1WUVz2kd3rtG+9gRAq3/aiBJGlB7dmvTsDG/5MUHNSbXRqPaud0mC957weVxpbfxSwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795567914;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=mOWZ5TjvlMkL4oBUD0ybCU/Vosi/rN1lSKG3xTizPns=;
	b=HdJwoz8LKWYmMzrgpDKPcnFwuVIf/pgskMUPpHhcjStyo2n0yFYzuM1K8+BYPP4sYvJL
	 Ch0Kztnd1OFXtrZ35UX5P1o0Jk74yn1gDxaTeSWTDuyWHCyaBtGsRUHZSk3fvSQImljKx
	 m74+t/6YShFWBLS9Y3AIn7z3szL7kTWCsX3MkN/TOI68end2ns3vmJqCUP3HoSiw9bjPj
	 ynBhY0uZOnt9HnAqAFG3PPC2aC+eseUMhY4Mym46wCKkAm57mt2X9QoT81Qo5DqXY9OCs
	 pOXRssX+wyPeGSeqMIdLEk49A6PM8qZIwFnQn3isS/UtO4nYlxNr1UhQvoP46KEXmjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IP87fBqT;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C74606A33A
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 00:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6C74606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IP87fBqT
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-139b62317d0so6178333c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 16:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795567912; x=1796172712; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mOWZ5TjvlMkL4oBUD0ybCU/Vosi/rN1lSKG3xTizPns=;
        b=IP87fBqTnTyIJM+Mkyo4ecmoPe5S0XmoTklc+Ox2cfsUN/znu4osfEFNvQllY7fXIc
         EuYpi77UklzKNn6DcN18UmTh6m+6mZQUVBZL1YmvxR0VSzS8O6anky+HZw0wTx+Gpykg
         sqgTLZeUM8JqVbo8B1pbwEosyPawN39sC04gKesN0CGiPuXzin6HXL8qOM+2k9GygKcP
         KjYXuxiSCloIBIp3ExqcAmAyvBikhQ+F6w0/vqVaImqFAIf32xYS8exL4AVjPEFmOHlo
         /nYxAgINhxDjXgh3PEeMN1+pNHu8jln7r/NEFa8ZNbUMVIJCiel3MM99akv2V8Rbk4XH
         4A7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795567912; x=1796172712;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mOWZ5TjvlMkL4oBUD0ybCU/Vosi/rN1lSKG3xTizPns=;
        b=dLcKRHLYEJivQHHc+VIUAASvD+AEp7hRP3gKuxg1rnoiLZagv/pUW/+/e1twoWeyVM
         lfNZHWlDiGAodsevQ14ZM2gq6CufhgrcY/YrW7Z3pnn32T4UTR8I40cVrZ6sFgxo/kcj
         UgUtlXS8dsxbHZI6nLf635QCG0ND+bhFtYfX7a1UflrpSkZQvJZ4s1uYVkB9iYBhXBHw
         lFZDIreoimjDWb9a063Z70bvgMHNQZB+XPvA9YxO5Y0J+q+cHNm24eqkJ3WSdmLDmtHZ
         //9DnjdxNoPIkJbV+Dd6Cy5DAX+NgPxzhzEtmUOmD+5HBRaVl8rvFMjTdh6KkfF9h0k6
         KK7A==
X-Forwarded-Encrypted: i=1; AL+hErGn2Czo3S+eBbgGP4rRpjEIP7uwwvsAGvMjdpEdGMJX0Hun0KKM3/tqiURH9KLLEi7+e8L6heuYCCDF+hBN4Wp+@vger.kernel.org
X-Gm-Message-State: APuU4Z/9niDEQcwHPhuf9s0+BPLYmyhXjvV33AXsA+bmAUTvvrdOQNiS
	RBba/nMEYXC0G0Zn/rimBf2MpMnt1lxdh9H3570jSMZlbxpYhfuT/sIbRGQGGAeGj/hZd0Q+/D4
	WIJfoGthrwA==
X-Received: from dlgj1-n1.prod.google.com ([2002:a05:7023:e41:10b0:1a7:2bf1:46cc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701a:cc88:10b0:1b2:60ab:1e9d
 with SMTP id a92af1059eb24-1b55690cf1bmr17191341c88.37.1795567911530; Tue, 24
 Nov 2026 16:51:51 -0800 (PST)
Date: Tue, 24 Nov 2026 16:51:04 -0800
In-Reply-To: <20261125005108.1020003-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125005108.1020003-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125005108.1020003-16-irogers@google.com>
Subject: [PATCH v4 15/19] perf symbol: Resolve symbols and callchains using
 build ID and offset
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Athira Rajeev <atrajeev@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Leo Yan <leo.yan@linux.dev>, Dmitry Vyukov <dvyukov@google.com>, 
	"Steinar H . Gunderson" <sesse@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Update thread__find_map(), callchain resolution in machine.c, deferred
callchain merging in sample__merge_deferred_callchain(), and perf
report/script to resolve symbols and callchains using the build ID and
file offset recorded in samples.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-report.c     |   4 +-
 tools/perf/builtin-script.c     |  28 ++++--
 tools/perf/util/callchain.c     | 153 +++++++++++++++++++++++-----
 tools/perf/util/event.c         |  36 +++++--
 tools/perf/util/evsel_fprintf.c |   9 +-
 tools/perf/util/machine.c       | 173 ++++++++++++++++++++++++--------
 6 files changed, 315 insertions(+), 88 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 6672a4d16529..a1041c8605ec 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -384,7 +384,7 @@ static int report__setup_sample_type(struct report *rep)
 	    session->itrace_synth_opts->add_last_branch)
 		sample_type |= PERF_SAMPLE_BRANCH_STACK;
 
-	if (!is_pipe && !(sample_type & PERF_SAMPLE_CALLCHAIN)) {
+	if (!is_pipe && !(sample_type & PERF_SAMPLE_CALLCHAIN_TYPE)) {
 		if (perf_hpp_list.parent) {
 			ui__error("Selected --sort parent, but no "
 				    "callchain data. Did you call "
@@ -410,7 +410,7 @@ static int report__setup_sample_type(struct report *rep)
 
 	if (symbol_conf.cumulate_callchain) {
 		/* Silently ignore if callchain is missing */
-		if (!(sample_type & PERF_SAMPLE_CALLCHAIN)) {
+		if (!(sample_type & PERF_SAMPLE_CALLCHAIN_TYPE)) {
 			symbol_conf.cumulate_callchain = false;
 			perf_hpp__cancel_cumulate(session->evlist);
 		}
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 376a4e0d7b0c..a490b6b525b5 100644
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
@@ -1796,7 +1799,8 @@ static int perf_sample__fprintf_bts(struct perf_sample *sample,
 		unsigned int print_opts = output[type].print_ip_opts;
 		struct callchain_cursor *cursor = NULL;
 
-		if (symbol_conf.use_callchain && sample->callchain) {
+		if (symbol_conf.use_callchain &&
+		    (sample->callchain || sample->callchain_bid.nr_offsets)) {
 			cursor = get_tls_callchain_cursor();
 			if (thread__resolve_callchain(al->thread, cursor,
 						      sample, NULL, NULL,
@@ -2755,13 +2759,18 @@ static void process_event(struct perf_script *script,
 		fprintf(fp, " %s", cgrp_name);
 	}
 
-	if (PRINT_FIELD(IP)) {
+	if (PRINT_FIELD(IP) ||
+	    ((attr->sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_BUILD_ID_OFFSET)) &&
+	     output[type].print_ip_opts &&
+	     !(PRINT_FIELD(ADDR) || PRINT_FIELD(BRSTACK) ||
+	       PRINT_FIELD(BRSTACKSYM) || PRINT_FIELD(BRSTACKOFF)))) {
 		struct callchain_cursor *cursor = NULL;
 
 		if (script->stitch_lbr)
 			thread__set_lbr_stitch_enable(al->thread, true);
 
-		if (symbol_conf.use_callchain && sample->callchain) {
+		if (symbol_conf.use_callchain &&
+		    (sample->callchain || sample->callchain_bid.nr_offsets)) {
 			cursor = get_tls_callchain_cursor();
 			if (thread__resolve_callchain(al->thread, cursor,
 						      sample, NULL, NULL,
@@ -3005,10 +3014,11 @@ static int process_deferred_sample_event(const struct perf_tool *tool,
 	fprintf(fp, "DEFERRED CALLCHAIN [cookie: %llx]",
 		(unsigned long long)event->callchain_deferred.cookie);
 
-	if (PRINT_FIELD(IP)) {
+	if (output[type].print_ip_opts) {
 		struct callchain_cursor *cursor = NULL;
 
-		if (symbol_conf.use_callchain && sample->callchain) {
+		if (symbol_conf.use_callchain &&
+		    (sample->callchain || sample->callchain_bid.nr_offsets)) {
 			cursor = get_tls_callchain_cursor();
 			if (thread__resolve_callchain(al.thread, cursor,
 						      sample, NULL, NULL,
@@ -3089,7 +3099,7 @@ static int process_attr(const struct perf_tool *tool, union perf_event *event,
 
 	/* Enable fields for callchain entries */
 	if (symbol_conf.use_callchain &&
-	    (sample_type & PERF_SAMPLE_CALLCHAIN ||
+	    (sample_type & PERF_SAMPLE_CALLCHAIN_TYPE ||
 	     sample_type & PERF_SAMPLE_BRANCH_STACK ||
 	     (sample_type & PERF_SAMPLE_REGS_USER &&
 	      sample_type & PERF_SAMPLE_STACK_USER))) {
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 4e4696cfa6d4..57c6f940c2ad 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1175,7 +1175,8 @@ int sample__resolve_callchain(struct perf_sample *sample,
 			      struct addr_location *al,
 			      int max_stack)
 {
-	if (sample->callchain == NULL && !symbol_conf.show_branchflag_count)
+	if (sample->callchain == NULL && sample->callchain_bid.nr_offsets == 0 &&
+	    !symbol_conf.show_branchflag_count)
 		return 0;
 
 	if (symbol_conf.use_callchain || symbol_conf.cumulate_callchain ||
@@ -1188,7 +1189,8 @@ int sample__resolve_callchain(struct perf_sample *sample,
 
 int hist_entry__append_callchain(struct hist_entry *he, struct perf_sample *sample)
 {
-	if ((!symbol_conf.use_callchain || sample->callchain == NULL) &&
+	if ((!symbol_conf.use_callchain ||
+	     (sample->callchain == NULL && sample->callchain_bid.nr_offsets == 0)) &&
 		!symbol_conf.show_branchflag_count)
 		return 0;
 	return callchain_append(he->callchain, get_tls_callchain_cursor(), sample->period);
@@ -1914,32 +1916,137 @@ int sample__for_each_callchain_node(struct thread *thread,
 int sample__merge_deferred_callchain(struct perf_sample *sample_orig,
 				     struct perf_sample *sample_callchain)
 {
-	u64 nr_orig = sample_orig->callchain->nr - 1;
-	u64 nr_deferred = sample_callchain->callchain->nr;
-	struct ip_callchain *callchain;
+	if (sample_orig->deferred_bid && sample_callchain->callchain_bid.nr_offsets > 0) {
+		struct perf_build_id *bid =
+			(struct perf_build_id *)sample_orig->bid.deferred_storage;
+		u64 offset = 0;
+
+		perf_sample__callchain_bid_entry(sample_callchain, 0, bid, &offset);
+		sample_orig->bid.bid = bid;
+		sample_orig->bid.offset = offset;
+		if (!sample_orig->evsel ||
+		    !(sample_orig->evsel->core.attr.sample_type & PERF_SAMPLE_IP))
+			sample_orig->ip = offset;
+		sample_orig->deferred_bid = false;
+	}
+
+	if (sample_orig->callchain_bid.nr_offsets >= 2 &&
+	    sample_callchain->callchain_bid.nr_offsets > 0) {
+		u32 nr_orig = sample_orig->callchain_bid.nr_offsets - 1;
+		u32 nr_deferred = sample_callchain->callchain_bid.nr_offsets;
+
+		if (sample_orig->merged_callchain_bids)
+			return -EINVAL;
+
+		if (sample_orig->callchain_bid.offsets[nr_orig - 1] ==
+		    PERF_CONTEXT_USER_DEFERRED) {
+			u32 max_orig_idx = 0, orig_bids_bytes = 0, def_bids_bytes = 0;
+			u32 total_bids, aligned_bids_len;
+			u32 total_offsets = nr_orig + nr_deferred;
+			u8 *buf;
+			u64 *offsets;
+
+			bool is_user_ctx = true;
+
+			for (u32 i = 0; i < nr_orig; i++) {
+				u64 raw = sample_orig->callchain_bid.offsets[i];
+				u8 idx;
+
+				if (raw >= PERF_CONTEXT_MAX) {
+					is_user_ctx = (raw == PERF_CONTEXT_USER ||
+						       raw == PERF_CONTEXT_GUEST_USER ||
+						       raw == PERF_CONTEXT_USER_DEFERRED);
+					continue;
+				}
+				if (!is_user_ctx)
+					continue;
+				idx = raw >> 56;
+				if (idx >= 1 && idx <= sample_orig->callchain_bid.nr_build_ids &&
+				    idx > max_orig_idx)
+					max_orig_idx = idx;
+			}
+			for (u32 i = 0; i < max_orig_idx; i++) {
+				u8 sz = sample_orig->callchain_bid.build_ids[orig_bids_bytes];
 
-	if (sample_orig->merged_callchain) {
-		/* Already merged. */
-		return -EINVAL;
-	}
+				orig_bids_bytes += 1 + sz;
+			}
+			for (u32 i = 0; i < sample_callchain->callchain_bid.nr_build_ids; i++) {
+				u8 sz = sample_callchain->callchain_bid.build_ids[def_bids_bytes];
 
-	if (sample_orig->callchain->nr < 2) {
-		sample_orig->deferred_callchain = false;
-		return -EINVAL;
+				def_bids_bytes += 1 + sz;
+			}
+
+			total_bids = max_orig_idx + sample_callchain->callchain_bid.nr_build_ids;
+			if (total_bids > 254)
+				return -EINVAL;
+			aligned_bids_len = ALIGN(orig_bids_bytes + def_bids_bytes, sizeof(u64));
+			buf = zalloc(aligned_bids_len + total_offsets * sizeof(u64));
+			if (!buf)
+				return -ENOMEM;
+
+			if (orig_bids_bytes)
+				memcpy(buf, sample_orig->callchain_bid.build_ids, orig_bids_bytes);
+			if (def_bids_bytes)
+				memcpy(buf + orig_bids_bytes,
+				       sample_callchain->callchain_bid.build_ids, def_bids_bytes);
+
+			offsets = (u64 *)(buf + aligned_bids_len);
+			memcpy(offsets, sample_orig->callchain_bid.offsets,
+			       nr_orig * sizeof(u64));
+			for (u32 i = 0; i < nr_deferred; i++) {
+				u64 raw = sample_callchain->callchain_bid.offsets[i];
+				u8 idx = raw >> 56;
+
+				if (idx >= 1 &&
+				    idx <= sample_callchain->callchain_bid.nr_build_ids) {
+					u8 new_idx = idx + max_orig_idx;
+
+					raw = (raw & ((1ULL << 56) - 1)) | ((u64)new_idx << 56);
+				}
+				offsets[nr_orig + i] = raw;
+			}
+
+			if (sample_orig->allocated_callchain_bids)
+				free(sample_orig->callchain_bid.build_ids);
+			sample_orig->callchain_bid.nr_build_ids = total_bids;
+			sample_orig->callchain_bid.nr_offsets = total_offsets;
+			sample_orig->callchain_bid.build_ids_len = aligned_bids_len;
+			sample_orig->callchain_bid.build_ids = buf;
+			sample_orig->callchain_bid.offsets = offsets;
+			sample_orig->allocated_callchain_bids = true;
+			sample_orig->merged_callchain_bids = true;
+		}
 	}
 
-	callchain = calloc(1 + nr_orig + nr_deferred, sizeof(u64));
-	if (callchain == NULL)
-		return -ENOMEM;
+	if (sample_orig->callchain && sample_callchain->callchain) {
+		u64 nr_orig = sample_orig->callchain->nr - 1;
+		u64 nr_deferred = sample_callchain->callchain->nr;
+		struct ip_callchain *callchain;
+
+		if (sample_orig->merged_callchain) {
+			/* Already merged. */
+			return -EINVAL;
+		}
+
+		if (sample_orig->callchain->nr < 2) {
+			sample_orig->deferred_callchain = false;
+			return -EINVAL;
+		}
+
+		callchain = calloc(1 + nr_orig + nr_deferred, sizeof(u64));
+		if (callchain == NULL)
+			return -ENOMEM;
 
-	callchain->nr = nr_orig + nr_deferred;
-	/* copy original including PERF_CONTEXT_USER_DEFERRED (but the cookie) */
-	memcpy(callchain->ips, sample_orig->callchain->ips, nr_orig * sizeof(u64));
-	/* copy deferred user callchains */
-	memcpy(&callchain->ips[nr_orig], sample_callchain->callchain->ips,
-	       nr_deferred * sizeof(u64));
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
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 4a6b59fa9d82..ddb572d33b24 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -702,8 +702,8 @@ struct map *thread__find_map(struct thread *thread, struct perf_sample *sample,
 	thread__zput(al->thread);
 	al->thread = thread__get(thread);
 
-	al->addr = sample->ip;
 	al->cpumode = sample->cpumode;
+	al->addr = sample->bid.bid ? sample->bid.offset : sample->ip;
 	al->filtered = 0;
 
 	if (sample->cpumode == PERF_RECORD_MISC_KERNEL && perf_host) {
@@ -732,15 +732,31 @@ struct map *thread__find_map(struct thread *thread, struct perf_sample *sample,
 
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
diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index 0f7a25500a44..91f52ead2562 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -131,7 +131,7 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 	if (cursor == NULL)
 		return fprintf(fp, "<not enough memory for the callchain cursor>%s", print_oneline ? "" : "\n");
 
-	if (sample->callchain) {
+	if (sample->callchain || sample->callchain_bid.nr_offsets) {
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
index c5a4a00db5c5..693eec1bbdbf 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2253,7 +2253,9 @@ static int add_callchain_ip(struct thread *thread,
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
@@ -2267,6 +2269,8 @@ static int add_callchain_ip(struct thread *thread,
 	al.sym = NULL;
 	al.srcline = NULL;
 	sample.ip = ip;
+	sample.bid.bid = bid;
+	sample.bid.offset = offset;
 	if (!cpumode) {
 		thread__find_cpumode_addr_location(thread, &sample, symbols, &al);
 	} else {
@@ -2331,6 +2335,9 @@ static int add_callchain_ip(struct thread *thread,
 	ms.map = map__get(al.map);
 	ms.sym = al.sym;
 
+	if (bid && bid->size > 0 && al.map)
+		ip = map__unmap_ip(al.map, al.addr);
+
 	if (append_inlines(cursor, &ms, ip, branch, flags, nr_loop_iter,
 			   iter_cycles, branch_from) == 0)
 		goto out;
@@ -2446,10 +2453,18 @@ static int lbr_callchain_add_kernel_ip(struct thread *thread,
 
 	if (callee) {
 		for (i = 0; i < end + 1; i++) {
+			struct perf_build_id bid_buf;
+			struct perf_build_id *bid = NULL;
+			u64 offset = 0;
+
+			if (i < (int)sample->callchain_bid.nr_offsets) {
+				perf_sample__callchain_bid_entry(sample, i, &bid_buf, &offset);
+				bid = &bid_buf;
+			}
 			err = add_callchain_ip(thread, cursor, parent,
 					       root_al, &cpumode, chain->ips[i],
 					       false, NULL, NULL, branch_from,
-					       symbols);
+					       symbols, bid, offset);
 			if (err)
 				return err;
 		}
@@ -2457,10 +2472,18 @@ static int lbr_callchain_add_kernel_ip(struct thread *thread,
 	}
 
 	for (i = end; i >= 0; i--) {
+		struct perf_build_id bid_buf;
+		struct perf_build_id *bid = NULL;
+		u64 offset = 0;
+
+		if (i < (int)sample->callchain_bid.nr_offsets) {
+			perf_sample__callchain_bid_entry(sample, i, &bid_buf, &offset);
+			bid = &bid_buf;
+		}
 		err = add_callchain_ip(thread, cursor, parent,
 				       root_al, &cpumode, chain->ips[i],
 				       false, NULL, NULL, branch_from,
-				       symbols);
+				       symbols, bid, offset);
 		if (err)
 			return err;
 	}
@@ -2534,16 +2557,25 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 		 * Set the (first) leaf function's IP to sample->ip (the
 		 * location of the sample) but if not recorded use entries.to
 		 */
-		if (sample->ip)
+		if ((sample->bid.bid && sample->bid.bid->size > 0) || sample->ip) {
 			ip = sample->ip;
-		else
+			flags = &entries[0].flags;
+			*branch_from = entries[0].from;
+			err = add_callchain_ip(thread, cursor, parent,
+					       root_al, &cpumode, ip,
+					       true, flags, NULL,
+					       *branch_from, symbols,
+					       sample->bid.bid, sample->bid.offset);
+		} else {
 			ip = entries[0].to;
-		flags = &entries[0].flags;
-		*branch_from = entries[0].from;
-		err = add_callchain_ip(thread, cursor, parent,
-				       root_al, &cpumode, ip,
-				       true, flags, NULL,
-				       *branch_from, symbols);
+			flags = &entries[0].flags;
+			*branch_from = entries[0].from;
+			err = add_callchain_ip(thread, cursor, parent,
+					       root_al, &cpumode, ip,
+					       true, flags, NULL,
+					       *branch_from, symbols,
+					       /*bid=*/NULL, /*offset=*/0);
+		}
 		if (err)
 			return err;
 
@@ -2568,7 +2600,7 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 			err = add_callchain_ip(thread, cursor, parent,
 					       root_al, &cpumode, ip,
 					       true, flags, NULL,
-					       *branch_from, symbols);
+					       *branch_from, symbols, /*bid=*/NULL, /*offset=*/0);
 			if (err)
 				return err;
 			save_lbr_cursor_node(thread, cursor, i);
@@ -2583,7 +2615,7 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 		err = add_callchain_ip(thread, cursor, parent,
 				       root_al, &cpumode, ip,
 				       true, flags, NULL,
-				       *branch_from, symbols);
+				       *branch_from, symbols, /*bid=*/NULL, /*offset=*/0);
 		if (err)
 			return err;
 		save_lbr_cursor_node(thread, cursor, i);
@@ -2594,16 +2626,25 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 		 * Set the (first) leaf function's IP to sample->ip (the
 		 * location of the sample) but if not recorded use entries.to
 		 */
-		if (sample->ip)
+		if ((sample->bid.bid && sample->bid.bid->size > 0) || sample->ip) {
 			ip = sample->ip;
-		else
+			flags = &entries[0].flags;
+			*branch_from = entries[0].from;
+			err = add_callchain_ip(thread, cursor, parent,
+					       root_al, &cpumode, ip,
+					       true, flags, NULL,
+					       *branch_from, symbols,
+					       sample->bid.bid, sample->bid.offset);
+		} else {
 			ip = entries[0].to;
-		flags = &entries[0].flags;
-		*branch_from = entries[0].from;
-		err = add_callchain_ip(thread, cursor, parent,
-				root_al, &cpumode, ip,
-				true, flags, NULL,
-				*branch_from, symbols);
+			flags = &entries[0].flags;
+			*branch_from = entries[0].from;
+			err = add_callchain_ip(thread, cursor, parent,
+					       root_al, &cpumode, ip,
+					       true, flags, NULL,
+					       *branch_from, symbols,
+					       /*bid=*/NULL, /*offset=*/0);
+		}
 		if (err)
 			return err;
 	}
@@ -2776,12 +2817,16 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
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
+	chain_nr = min_t(int, max_stack, chain->nr);
 	for (i = 0; i < chain_nr; i++) {
 		if (chain->ips[i] == PERF_CONTEXT_USER)
 			break;
@@ -2867,7 +2912,8 @@ static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
 		if (ip >= PERF_CONTEXT_MAX) {
 			err = add_callchain_ip(thread, cursor, parent,
 					       root_al, cpumode, ip,
-					       false, NULL, NULL, 0, symbols);
+					       false, NULL, NULL, 0, symbols,
+					       /*bid=*/NULL, /*offset=*/0);
 			break;
 		}
 	}
@@ -2895,6 +2941,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 	struct branch_stack *branch = sample->branch_stack;
 	struct branch_entry *entries = perf_sample__branch_entries(sample);
 	struct ip_callchain *chain = sample->callchain;
+	struct ip_callchain *alloc_chain = NULL;
 	int chain_nr = 0;
 	u8 cpumode = PERF_RECORD_MISC_USER;
 	int i, j, err, nr_entries, usr_idx;
@@ -2902,6 +2949,22 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 	int first_call = 0;
 	u64 leaf_frame_caller;
 
+	if (!chain && sample->callchain_bid.nr_offsets > 0) {
+		alloc_chain = malloc(sizeof(*chain) +
+				     sample->callchain_bid.nr_offsets * sizeof(u64));
+		if (!alloc_chain)
+			return -ENOMEM;
+		alloc_chain->nr = sample->callchain_bid.nr_offsets;
+		for (i = 0; i < (int)sample->callchain_bid.nr_offsets; i++) {
+			u64 offset = 0;
+
+			perf_sample__callchain_bid_entry(sample, i, NULL, &offset);
+			alloc_chain->ips[i] = offset;
+		}
+		chain = alloc_chain;
+		sample->callchain = alloc_chain;
+	}
+
 	if (chain)
 		chain_nr = chain->nr;
 
@@ -2912,8 +2975,10 @@ static int thread__resolve_callchain_sample(struct thread *thread,
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
@@ -2976,22 +3041,26 @@ static int thread__resolve_callchain_sample(struct thread *thread,
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
@@ -3000,12 +3069,17 @@ static int thread__resolve_callchain_sample(struct thread *thread,
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
+		struct perf_build_id bid_buf;
+		struct perf_build_id *bid = NULL;
+		u64 offset = 0;
 
 		if (callchain_param.order == ORDER_CALLEE)
 			j = i;
@@ -3017,13 +3091,19 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 			continue;
 #endif
 		ip = chain->ips[j];
+		if (j < (int)sample->callchain_bid.nr_offsets) {
+			perf_sample__callchain_bid_entry(sample, j, &bid_buf, &offset);
+			bid = &bid_buf;
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
 
@@ -3049,21 +3129,32 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 
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
-- 
2.56.1.831.g720f3f5937-goog

