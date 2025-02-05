Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D8F1FC7C4
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Feb 2025 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738772914; cv=none; b=ILIGgUJQMUdlGDVJmtFYzD6O+2S/aA1oMN+4BRI41C/dXJoU0jC7bJ67M/+sKs2Lmd50M0XWssPH4531mHGtzThVrl7c7FlW+1kavLW9+G8IXem6WzvgDsaQDLkuaZzhZ60qEN2DvoHl8dYqv6Pa+kGBLD8+WmMoUy1aBHH9BWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738772914; c=relaxed/simple;
	bh=ouB9vCO60RBwHqR1z/Isx31uYGH0D3yEBxVjr4wx+9k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ePAWJwvSuy+5FyVWyqzmtZZ/1oAglsPPETSMaOlXhjIkNXDgSYwDTwnkyQswOOXhQB2zWXBwLPI81dkrIkZ29CVIu5WrFIPBP7r4Jhrr7nSZc2BI8Fc4FosPlIWU9+J/ieJzhhREPoMkYaLpfeTdFlQ4tQXviCAxG9ONfv4hEXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MmN8oxdf; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MmN8oxdf"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-aa68952272bso319113766b.2
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Feb 2025 08:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738772910; x=1739377710; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9MsIRX7DG9MGtj3A+aD4rpdCKFF6CVLblb/noWICajE=;
        b=MmN8oxdfv8L6H+/Hn7Sb+rJzmRZ9Ki0uRXLFI4jkJSXNdsEnSQyy/0LtUpI3LOULXR
         q0mlpgJK/GwEsGRtIQQz4U/WWSaNP3M7IeHoMtRTujPYc8p1rH43mvlT5pZLDQsawWfy
         PVx0GHbv70iLwwHBr+bx82R5ALfWc+kc2G3l3WGKdV0yscwjc9HsVetXLJBxEMR2rkcc
         3rYb3xGACHjM7ep86A2RfzKZnnu7flG3LQf+1t8fLTeP/i/kDylyA1FJloNMD70R3O0T
         Ho3Osie7CqnQt+4rzrf5/tl5eLeczyHanHzsAlD+gx/IjvGP5t13jGaQAtnoA9X1AzXa
         F5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738772910; x=1739377710;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9MsIRX7DG9MGtj3A+aD4rpdCKFF6CVLblb/noWICajE=;
        b=lyAyOGAYZwlOjwHNeDpKL0jVoiguaxogvlXZXuApJL9pqtyG4s48t3UV6qU5iOwIRP
         e7/pVNyZ00oFAqD4gVplP5UhTiEKpkvmGVSY6LWZVNJF5s4oJ5xrBHU9Esey/Q7U+qBW
         TiBYS+ccmRvTP34QiAzVp+NRD1MsK1RXZF8XOxcPIeNODBGU/aozKXoloK0HiSJrCMDv
         Q7RaNJ8jFV0xDdpI+HC2D5z4MJFJIftViOIofcaRRnNAQRKF9G8EPKpZrxvLdMANVHcF
         AbhopMAIXJsTVAHPl4ghJFoB8a5jelN1mmKSopxzpPcAb3h8qyOzV0V7XTQ3dSG3GH1h
         VNnw==
X-Gm-Message-State: AOJu0YyCyeqytpokygV7+pam4kdZUGSm60VhXZ7pwpsQ+EFj3SjjvS/7
	w8YR8cX114ZZ3PcCVqnNOlGaVBqSI3Ehen0bOc6khoKmBhk3nj0W+OxiIn+URE6CO5HGH9ABXrT
	WKxiNIQ==
X-Google-Smtp-Source: AGHT+IGP2Mq+o6OttSnARUKf1vBVaHm+AgE7bhyTRvO5/V+OTQ8afDB6b6/8SGo51eEithWP3XIowSODVKJp
X-Received: from ejctn5.prod.google.com ([2002:a17:907:c405:b0:ab6:d6eb:7d3])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:9688:b0:aa6:7a81:3077
 with SMTP id a640c23a62f3a-ab75e322c85mr392661066b.54.1738772910584; Wed, 05
 Feb 2025 08:28:30 -0800 (PST)
Date: Wed,  5 Feb 2025 17:27:41 +0100
In-Reply-To: <cover.1738772628.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1738772628.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <b416c5729ed054a14045a028cb63b4a2b3d52bdf.1738772628.git.dvyukov@google.com>
Subject: [PATCH v5 2/8] perf report: Add parallelism sort key
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com
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
2.48.1.362.g079036d154-goog

