Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AED12135A0
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Feb 2025 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593075; cv=none; b=IQIUbtqTOTZkq1jEkUHI8AhQxmNJRwmSzyhBRB0FwOB7vq799qiAlP/q5IZijZfxdiMOWXdo9+eGBatBmsafHWXvktILI7VLMFW4VTPqD8aCem8oq9e3472J4tJDb3zYs48/v3bz4Ww2SKxHi8IUr9irXiQ5TxLgkgRkrG+68XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593075; c=relaxed/simple;
	bh=ouB9vCO60RBwHqR1z/Isx31uYGH0D3yEBxVjr4wx+9k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fTAKTJk4X5YQTukTzQ2/2j5MDAqsO8bpeQkya3Z3kybgVqZDIER5yqwKacfRRGFeLiJwXpHNEFGFXYmdesTz9laME7h0lrkZWwnfkgBzCuODbt4FZXUu2pPOLCEvpIYPOxNxyoNZTieQC5Vfd8xSg9QWwGdYhpeBCOLHAd4bOxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AyHlIgo7; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AyHlIgo7"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-aab954d1116so427094066b.3
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Feb 2025 06:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738593072; x=1739197872; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9MsIRX7DG9MGtj3A+aD4rpdCKFF6CVLblb/noWICajE=;
        b=AyHlIgo708f1lTU8p4+2a0UmmaGc770Kf04CJuMOGYPBtATqDhVwm260r6Madzgzwn
         tOfbNzbkHmQ7CpXkRzrlZ+4m0Ysam2lC5ucdQlFPcCPQ+Ik0UPp1mbVQRdzIsYICsndR
         p1DhiAoEcfQwCbN+m+SO7XhtmxFG1gM1qEsU0XQD+/tgnvihy6Jf5Lr5HWL+JU33/pRY
         q6Z6qC/wXGx8PObGj1pVx2hMzIKBWYWSu0VxBKM5hpXgt8m+6cvGeXGfVvmuEveN+79u
         e2cBIiStwFV9Q8rcK5A7S3HcA3waFNbwk16M/5AZzabRxKsxGoAbNJc8i3PrMKK2VUC7
         RDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738593072; x=1739197872;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9MsIRX7DG9MGtj3A+aD4rpdCKFF6CVLblb/noWICajE=;
        b=J7LqoSrXVA6wI0+ZooNiUA270Bq79f2SF34OtJ/N2Furwr6VmMovoTaO75ftqjrAdu
         1ad0JDr4gUbZOH/gs19DByQ/Sj/CMdBI6m6Wf9M0IRpju31AkLA/NI+n8c5opgmauuOu
         wGpNHPQAMUzNSgTpRA7T/vb4WaU2Oy32RdCromB7ey95M4KpXRqseYZaFx8pEvtCEVBK
         9faEWgW1FVIkrSfY4oPF5ccvhrpUDIn/DtLLBijnUc81jXFRMiRFLRm7T+vRw9RuCMx0
         ai87ql0N5dJRYgN+GH+b7W9quzlehITsIdL/FTGRfDmHzwR4DTMkwv4+CttzbzEoBIkx
         qXeg==
X-Gm-Message-State: AOJu0YwZqauxEeOhMy06nvoWYhLn3i9MKIT2c0y3SOzhY0mdrk1YeoTg
	NReIUQ/NNsL7g9ntnsGEdTTVteZiTqf2vc35yo+E7xqKFE1vYiISxiCqd0hSKtCfbLQTy4Uxs7B
	/MdLwpQ==
X-Google-Smtp-Source: AGHT+IG9ymIMti540LEptQJHIhiHqLWmwE7t/pCnlvQQ/g0ph3CipPs2W4EGQRkWjQ8zw26VGwYMiMSCC96D
X-Received: from ejcvg18.prod.google.com ([2002:a17:907:d312:b0:ab6:9b62:b39c])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:774b:b0:ab6:d5a6:e4c
 with SMTP id a640c23a62f3a-ab6d5a61059mr2121297466b.5.1738593071878; Mon, 03
 Feb 2025 06:31:11 -0800 (PST)
Date: Mon,  3 Feb 2025 15:30:37 +0100
In-Reply-To: <cover.1738592865.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1738592865.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <b416c5729ed054a14045a028cb63b4a2b3d52bdf.1738592865.git.dvyukov@google.com>
Subject: [PATCH v3 2/8] perf report: Add parallelism sort key
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com, acme@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>
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
2.48.1.362.g079036d154-goog

