Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6186C1DF240
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Feb 2025 11:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738928480; cv=none; b=NRys7dzYAo1cjYqHGP/e++qqZVr9ydLTOE1WTe7WVRRxam+B3B5iG8iakPb0MrxQK/GQtOQthiW8UN5D/F/as6BUeOqykF2v6qyL4oWmPsrmwZ/L+ng6ZhP8UDVDAXYMVRlGbT0GgSekaVfGKo/WkM12zv/faHSaBbZyI/DvURg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738928480; c=relaxed/simple;
	bh=bVdq4hc9YGjBJ7nZgP42O6s9vw1vEoorGjpbdnRHngo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gbuSNufDq3G/dN9OsZyuUot01p0riyojkv+B6G8Dnhw55OszMXuX4RS5dYSgn3FzTOlqlbcZWbWQNCd1mOTNsyprZ+RGCMXWlCJw0qEoyayBvETWWuisAY+u4EMSUE0UD4UxZyF1O1LLYgATNQ/+R0HNA5sCoTtl3oxfpP3WJ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O3d9zt+J; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O3d9zt+J"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-ab78f2aa826so37644966b.1
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 03:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738928477; x=1739533277; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YImqwGUqA/hzzpmvQV3kbZOr/KKA/KHBuOuOVe6LOyc=;
        b=O3d9zt+J1UOLxN4S1kNHLBhzn0ldtaNYfqX9DX0ewLGPB9OnZ8kr0LsKEIPdi94bt+
         Q367T82d9CnrXjLSU2+ocD2TC7XTyA90nYcmRNgU4+6dTVb4PY4PYpC/bec7LBz1fsu6
         TNgh5PSsdWv3L5fMyVgImmyaPWQotgGEb+EB6spap1u6KsvYsHksfwFT+qeO39veHvFN
         WCPmSLWVTCb4jEj5QmFehGhOZb6h6Ewp0EK3Z08QZa+kmd463W0MtvNw5JM/3hvh9TDK
         P3c6jBndOTvOeTuih18WaXSasaXMzfqRxJUpA+ZIEzzkpV7BegwSv96+fmYAXcXKZSQA
         xIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738928477; x=1739533277;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YImqwGUqA/hzzpmvQV3kbZOr/KKA/KHBuOuOVe6LOyc=;
        b=B/CdQpnNX5rVFGUHLLDE1sVYrH1g8uGRgS5YT4MaV2Fb9e+jNmRp9m71GBgGJ6Hrc0
         ES+E1rp+s+vVdviomN6MWMIGc0eZffY+VAJen2LifberJmfd83ReyPPm34EZfGCjse6f
         EGte2msNvhZIYuuLIqSiq3Ycuy5+zYUCnTYiEq8BSwzQE20jE/or86YiaqN5mRJd17wR
         Ibs9soP6r8Hpy1Q4f3kkcynjfFtbqY2bj7JT26FqWElviqzzNVdZtlyn1exfsaargKnV
         w5p6IYEy0vjLoIu0W763bWYY9GnR/1IrvDVyAK/2O/bbZHH7DKVVvJb9+VSKsTCoXAg+
         2ATQ==
X-Gm-Message-State: AOJu0Yz5GnSLxJya15l348VpOftgs6zzkcEP65qzgwyWMy8a4+/Z5AM+
	ArAojZdyEqXTiRl3WXgbcpccKefAYSOOFBnF1LWCSwUxrRj6EiuLhpywY4OJWtcBH12N4LAtw6+
	U7BFj4g==
X-Google-Smtp-Source: AGHT+IFTTOftZqCUohnB+fhoWj0asE05X7sP06eIvgKsRElzYBhllpisVupv2apjGpexvDu35y2kSQzWbafd
X-Received: from ejcex21.prod.google.com ([2002:a17:907:9555:b0:ab7:8aa2:5269])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:4606:b0:5d9:ae5:8318
 with SMTP id 4fb4d7f45d1cf-5de450706dbmr7297862a12.20.1738928476955; Fri, 07
 Feb 2025 03:41:16 -0800 (PST)
Date: Fri,  7 Feb 2025 12:40:29 +0100
In-Reply-To: <cover.1738928210.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1738928210.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <cf2e58d60a0b474c6b356064858629b9b4af2e90.1738928210.git.dvyukov@google.com>
Subject: [PATCH v6 2/9] perf report: Add parallelism sort key
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com, ak@linux.intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Show parallelism level in profiles if requested by user.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/perf/builtin-report.c | 11 +++++++++++
 tools/perf/util/hist.c      |  2 ++
 tools/perf/util/hist.h      |  3 +++
 tools/perf/util/session.c   | 12 ++++++++++++
 tools/perf/util/session.h   |  1 +
 tools/perf/util/sort.c      | 23 +++++++++++++++++++++++
 tools/perf/util/sort.h      |  1 +
 7 files changed, 53 insertions(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 0d9bd090eda71..14d49f0625881 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1720,6 +1720,17 @@ int cmd_report(int argc, const char **argv)
 		symbol_conf.annotate_data_sample = true;
 	}
 
+	if (report.disable_order || !perf_session__has_switch_events(session)) {
+		if ((sort_order && strstr(sort_order, "parallelism")) ||
+				(field_order && strstr(field_order, "parallelism"))) {
+			if (report.disable_order)
+				ui__error("Use of parallelism is incompatible with --disable-order.\n");
+			else
+				ui__error("Use of parallelism requires --switch-events during record.\n");
+			return -1;
+		}
+	}
+
 	if (sort_order && strstr(sort_order, "ipc")) {
 		parse_options_usage(report_usage, options, "s", 1);
 		goto error;
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 0f30f843c566d..cafd693568189 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -207,6 +207,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 
 	hists__new_col_len(hists, HISTC_CGROUP, 6);
 	hists__new_col_len(hists, HISTC_CGROUP_ID, 20);
+	hists__new_col_len(hists, HISTC_PARALLELISM, 11);
 	hists__new_col_len(hists, HISTC_CPU, 3);
 	hists__new_col_len(hists, HISTC_SOCKET, 6);
 	hists__new_col_len(hists, HISTC_MEM_LOCKED, 6);
@@ -741,6 +742,7 @@ __hists__add_entry(struct hists *hists,
 		.ip	 = al->addr,
 		.level	 = al->level,
 		.code_page_size = sample->code_page_size,
+		.parallelism	= al->parallelism,
 		.stat = {
 			.nr_events = 1,
 			.period	= sample->period,
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 46c8373e31465..a6e662d77dc24 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -42,6 +42,7 @@ enum hist_column {
 	HISTC_CGROUP_ID,
 	HISTC_CGROUP,
 	HISTC_PARENT,
+	HISTC_PARALLELISM,
 	HISTC_CPU,
 	HISTC_SOCKET,
 	HISTC_SRCLINE,
@@ -228,6 +229,7 @@ struct hist_entry {
 	u64			transaction;
 	s32			socket;
 	s32			cpu;
+	int			parallelism;
 	u64			code_page_size;
 	u64			weight;
 	u64			ins_lat;
@@ -580,6 +582,7 @@ bool perf_hpp__is_thread_entry(struct perf_hpp_fmt *fmt);
 bool perf_hpp__is_comm_entry(struct perf_hpp_fmt *fmt);
 bool perf_hpp__is_dso_entry(struct perf_hpp_fmt *fmt);
 bool perf_hpp__is_sym_entry(struct perf_hpp_fmt *fmt);
+bool perf_hpp__is_parallelism_entry(struct perf_hpp_fmt *fmt);
 
 struct perf_hpp_fmt *perf_hpp_fmt__dup(struct perf_hpp_fmt *fmt);
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index c06e3020a9769..00fcf8d8ac255 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2403,6 +2403,18 @@ bool perf_session__has_traces(struct perf_session *session, const char *msg)
 	return false;
 }
 
+bool perf_session__has_switch_events(struct perf_session *session)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(session->evlist, evsel) {
+		if (evsel->core.attr.context_switch)
+			return true;
+	}
+
+	return false;
+}
+
 int map__set_kallsyms_ref_reloc_sym(struct map *map, const char *symbol_name, u64 addr)
 {
 	char *bracket;
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index bcf1bcf06959b..db1c120a9e67f 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -141,6 +141,7 @@ int perf_session__resolve_callchain(struct perf_session *session,
 				    struct symbol **parent);
 
 bool perf_session__has_traces(struct perf_session *session, const char *msg);
+bool perf_session__has_switch_events(struct perf_session *session);
 
 void perf_event__attr_swap(struct perf_event_attr *attr);
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 3dd33721823f3..7eef43f5be360 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -892,6 +892,27 @@ struct sort_entry sort_cpu = {
 	.se_width_idx	= HISTC_CPU,
 };
 
+/* --sort parallelism */
+
+static int64_t
+sort__parallelism_cmp(struct hist_entry *left, struct hist_entry *right)
+{
+	return right->parallelism - left->parallelism;
+}
+
+static int hist_entry__parallelism_snprintf(struct hist_entry *he, char *bf,
+				    size_t size, unsigned int width)
+{
+	return repsep_snprintf(bf, size, "%*d", width, he->parallelism);
+}
+
+struct sort_entry sort_parallelism = {
+	.se_header      = "Parallelism",
+	.se_cmp	        = sort__parallelism_cmp,
+	.se_snprintf    = hist_entry__parallelism_snprintf,
+	.se_width_idx	= HISTC_PARALLELISM,
+};
+
 /* --sort cgroup_id */
 
 static int64_t _sort__cgroup_dev_cmp(u64 left_dev, u64 right_dev)
@@ -2534,6 +2555,7 @@ static struct sort_dimension common_sort_dimensions[] = {
 	DIM(SORT_ANNOTATE_DATA_TYPE_OFFSET, "typeoff", sort_type_offset),
 	DIM(SORT_SYM_OFFSET, "symoff", sort_sym_offset),
 	DIM(SORT_ANNOTATE_DATA_TYPE_CACHELINE, "typecln", sort_type_cacheline),
+	DIM(SORT_PARALLELISM, "parallelism", sort_parallelism),
 };
 
 #undef DIM
@@ -2735,6 +2757,7 @@ MK_SORT_ENTRY_CHK(thread)
 MK_SORT_ENTRY_CHK(comm)
 MK_SORT_ENTRY_CHK(dso)
 MK_SORT_ENTRY_CHK(sym)
+MK_SORT_ENTRY_CHK(parallelism)
 
 
 static bool __sort__hpp_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index a8572574e1686..11fb15f914093 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -72,6 +72,7 @@ enum sort_type {
 	SORT_ANNOTATE_DATA_TYPE_OFFSET,
 	SORT_SYM_OFFSET,
 	SORT_ANNOTATE_DATA_TYPE_CACHELINE,
+	SORT_PARALLELISM,
 
 	/* branch stack specific sort keys */
 	__SORT_BRANCH_STACK,
-- 
2.48.1.502.g6dc24dfdaf-goog

