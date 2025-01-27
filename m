Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6E51FDE22
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Jan 2025 09:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737971963; cv=none; b=eBjZAs80KLxN4rr8NZcQItZBd1SUYS5ey3TevLqpBjyLyRVKHaQmiIuuO3T20LaAH7WnXqefdty226D+q6twhHfeEQPgTLmHY9DuxhvjSsDywx0GXZeLHEBjNf0c03/hStrFWHanuE2+r0y3dshQgcLSHWwVwavpg9MHNOYWuDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737971963; c=relaxed/simple;
	bh=cNclnO68vswCkh+84xPCh9o2+/2+lsK7sgZCyii1PpI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J0J5tcZKrk3G4clUEAoqaoNl+jm3DxWJbyeM+PZ/5d0UhFNM8RpCMU+p/YeLSMij+JpAYCZACr6VtpV/3op7DbjhWBcLHHwI+/s6E1G+dEdjfPO+gQQo8ay5fhTzTiqhTGno1EmnxwQiFmUyEA2LnHPRsDVhyc2oLJxyZRVUMmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YZWRN+S9; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YZWRN+S9"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5d3ff30b566so4229064a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Jan 2025 01:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737971959; x=1738576759; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fOELaFIO5iUqHVPdsTFBOAPxUJnQlKBp6D46phdh9Z0=;
        b=YZWRN+S9QjmgF6FtkKaDX709nQI4/zIKQW8StVo0FxyPyNiduKkf4Mjq42ApN4X/hb
         5vzjNIwTBPsjx9MHeUXhCn8qkmpx4Z0BnCxEVl8qm81dofV+9z2FWv7dUcQ+9+/PUMPN
         zFSDDYNckdIsZUz4Kyu/RbB+mb+0NMEpoxSjGO2EcPW7UCy8HveaJPcCE7v4S78MakN9
         7B536/SIHDSXSUJaIcsfLT26PwJ4NHnUY+3nwKVswqgiaV2KZhzgy6v7/7IbknqoTBom
         2PSMO4bUOBsdihp7+c3/QivxVkfXvNx6E9+Al+gPTxRLisw4UkSWRTdCVRxdZuwpA/wK
         CSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737971959; x=1738576759;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fOELaFIO5iUqHVPdsTFBOAPxUJnQlKBp6D46phdh9Z0=;
        b=v9MMpQcYx9eyRjAfa8jS4ybiRQS+PTL5T1U/NR+vKRsZPH2XcKvz7L9illwXHdla/V
         RdfmJNvXXvPlXcGxuXKOtHYDPVjM8j9xooTJ8nadAg5bPCU3KKVaapmTGV9u7+VW/wf4
         vNxBZTGJ25MLvZL7QdS+79EKflcg7Q3V6Ql5+1K2iibAmma0JZxreoYM4EZYPHYXtWOX
         IwdQgYOgy56tcaADdRWyFVBuohQ0K4jw/ZgdN6vqHLKFXD3UztyGmFgadYPbTmRvSQbY
         wl+JJB/qMepTw9HB7nM8WJ6pbCp3ceHfg6JLdDyiScklSsidcg8IMWeDUDxa3cbQ2QEt
         21+A==
X-Gm-Message-State: AOJu0Yzq0WCBoLlHTqxL0cryn1bdy+VDLAe1qEsyF6Vc3PSR6E/ToK1s
	NvTlQ8PaJMp7EaOwudWRJenfVPpRObxHaqkXlRkN4r1FC61eHrw6N5Cadv4at0EdwquHG72gd6r
	9jYEA5Q==
X-Google-Smtp-Source: AGHT+IGA9+D9Jw5XlvJVQYmyZq4z9qPj1Raw20IsgspYZ/XEthKM0PaESyfATbCHjlFPN+y77Ajbop+3/fBw
X-Received: from edbb6.prod.google.com ([2002:a05:6402:1f06:b0:5d8:7c86:ecac])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:278f:b0:5d2:7346:3ecb
 with SMTP id 4fb4d7f45d1cf-5db7d2f8066mr38124892a12.12.1737971958994; Mon, 27
 Jan 2025 01:59:18 -0800 (PST)
Date: Mon, 27 Jan 2025 10:58:49 +0100
In-Reply-To: <cover.1737971364.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1737971364.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <3e52ed435e0ce98e1108b172fdcadc4749a25c98.1737971364.git.dvyukov@google.com>
Subject: [PATCH v3 2/7] perf report: Add parallelism sort key
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
2.48.1.262.g85cc9f2d1e-goog

