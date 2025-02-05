Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33231FC0E3
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Feb 2025 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738772919; cv=none; b=GeZx7pg8X9sNLqocVDQHT0jrRrc6TljeVwXUQe0JeOPqxAFZw4Fy97QbdHmQlZQVmZafN8LIpbk4C1UD+FgePcDjzn8r/wrM1efEPShPNpL5smhKhdsLPpE37PyFglBP4NfO1/lLr50kkgyswYU2JiyPflZFzaWo6LjHz6JYiF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738772919; c=relaxed/simple;
	bh=KQKCig+/K/lCLaXGsdWmze3UPKR1OsLMZWdeROL+d7A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XNcdGgmU5zdkadzARiLysuX5iUtL04daBUo1aZGokSnYwNRAY+nKXlEJgjxTPZI4lsNihd1ROYi49kNscdhX6IbPavNwxoEC7z4Jpk8eQ9EL2dMlDPs7GDkn/N/vtGOg8g+gA8BsuOpuh3Yeb0ZYeqi37f1+o5XBHY/nTyBaoJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GFqxCSi3; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GFqxCSi3"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5d90b88322aso6356112a12.3
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Feb 2025 08:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738772915; x=1739377715; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CSiHSGB+fMl625bNy51VXAQjQF/7wNbVPLFk6sXTjhQ=;
        b=GFqxCSi3zSliGhqGjGFcMUCfTN3KY5uHH0Vgrl2vtQ2Hy4gjjacXGBL+zEzRXBvSvs
         PAe98CyBvqKcM+jSWpUyau4XL35+7J1tMGkYOHKyWj+dfywjzcozg8eW0OZr8+wAr22i
         S7YWGVdaVsfbP2wTw4qKfiUtmmyW0q+irHbsZgDc4PQX41pkUKrM1X1qg7WRkdUD4nFI
         64DTBlBDIY6baK3zdN+V9uSrn51Jc43CGhfn11mbVqfImaujRt6rMkCNy2qGuAhle23N
         LHJnlEDiW4jigfGt/UKKA38THtwAcaGpFQfh8o+FKXs9bHAevKJLYzZkUhVVx1QoUiiJ
         8/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738772915; x=1739377715;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CSiHSGB+fMl625bNy51VXAQjQF/7wNbVPLFk6sXTjhQ=;
        b=BxmfEYa/Ww6HCJO2FnWhJMvNYPSTU/yUznwvORi26mxGODZR/T7EnfYHa7LUnkjULD
         EecBVQ38kha5BgTwYCsD7vS0CSdgeeCyJ0L6OKUcX+DLaoz83PKablQ+S6Z8ZL17PV6J
         C90qslUG5xd/tXKsBvgQWKYc9I8AxPUsh/NYZNtQQF612TdBLdt75xtqIYk8kucBWQbA
         bg8oJ4ntnF+YdRsaUJtrIHjPaTMheRGJOxTsGmJVvFXasNG7QP1hKImh+U/duv9x0qSC
         41UdgCRkbrNG8utuUJ9c5WzWdlnE6ZLqyRqKXCudyCf5eX+uyaLBjHWRZQHZuUrdtTM2
         gOww==
X-Gm-Message-State: AOJu0Yx67aQsTkeOCKAEaRGaZwch1eVMa3qmPGIwI+aMAOJqYmoL1MPy
	VUdEcA0BKEkyjr8s7r4fEWv1LJGnRkjylvv0n5MCEULyUlU1WbZOyMCx6a/oYkEv9Ol76x6uk6u
	Yq+xkvA==
X-Google-Smtp-Source: AGHT+IFNoBZmsearDuZ6E6s0PjEJFqo6xxQq2t0FHsUqLBj2CrS8vLJBNfEAaSlv3tEBAClqC9GGQtNrvDip
X-Received: from edc5.prod.google.com ([2002:a05:6402:4605:b0:5d9:12d3:9537])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:239b:b0:5dc:ebb8:fe64
 with SMTP id 4fb4d7f45d1cf-5dcebb8feb1mr316416a12.14.1738772915199; Wed, 05
 Feb 2025 08:28:35 -0800 (PST)
Date: Wed,  5 Feb 2025 17:27:43 +0100
In-Reply-To: <cover.1738772628.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1738772628.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <fb56820734fd562d0e40a830ee0bb51a12335945.1738772628.git.dvyukov@google.com>
Subject: [PATCH v5 4/8] perf report: Add parallelism filter
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Add parallelism filter that can be used to look at specific parallelism
levels only. The format is the same as cpu lists. For example:

Only single-threaded samples: --parallelism=1
Low parallelism only: --parallelism=1-4
High parallelism only: --parallelism=64-128

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/perf/builtin-report.c   |  5 ++++-
 tools/perf/util/event.c       |  2 ++
 tools/perf/util/hist.c        | 31 +++++++++++++++++++++++++++++++
 tools/perf/util/hist.h        |  6 +++++-
 tools/perf/util/sort.c        | 11 +++++++++++
 tools/perf/util/symbol.c      | 34 ++++++++++++++++++++++++++++++++++
 tools/perf/util/symbol_conf.h |  4 ++++
 7 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 14d49f0625881..2a19abdc869a1 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1390,6 +1390,8 @@ int cmd_report(int argc, const char **argv)
 		     symbol__config_symfs),
 	OPT_STRING('C', "cpu", &report.cpu_list, "cpu",
 		   "list of cpus to profile"),
+	OPT_STRING(0, "parallelism", &symbol_conf.parallelism_list_str, "parallelism",
+		   "only consider these parallelism levels (cpu set format)"),
 	OPT_BOOLEAN('I', "show-info", &report.show_full_info,
 		    "Display extended information about perf.data file"),
 	OPT_BOOLEAN(0, "source", &annotate_opts.annotate_src,
@@ -1721,7 +1723,8 @@ int cmd_report(int argc, const char **argv)
 	}
 
 	if (report.disable_order || !perf_session__has_switch_events(session)) {
-		if ((sort_order && strstr(sort_order, "parallelism")) ||
+		if (symbol_conf.parallelism_list_str ||
+				(sort_order && strstr(sort_order, "parallelism")) ||
 				(field_order && strstr(field_order, "parallelism"))) {
 			if (report.disable_order)
 				ui__error("Use of parallelism is incompatible with --disable-order.\n");
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 3d3ac58e1c660..bea9698e0c6bf 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -769,6 +769,8 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 
 	/* Account for possible out-of-order switch events. */
 	al->parallelism = min(max(machine->parallelism, 1), machine__nr_cpus_avail(machine));
+	if (test_bit(al->parallelism, symbol_conf.parallelism_filter))
+		al->filtered |= (1 << HIST_FILTER__PARALLELISM);
 
 	if (al->map) {
 		if (symbol_conf.dso_list &&
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 6b8f8da8d3b66..446342246f5ee 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -43,6 +43,8 @@ static bool hists__filter_entry_by_symbol(struct hists *hists,
 					  struct hist_entry *he);
 static bool hists__filter_entry_by_socket(struct hists *hists,
 					  struct hist_entry *he);
+static bool hists__filter_entry_by_parallelism(struct hists *hists,
+					       struct hist_entry *he);
 
 u16 hists__col_len(struct hists *hists, enum hist_column col)
 {
@@ -1457,6 +1459,10 @@ static void hist_entry__check_and_remove_filter(struct hist_entry *he,
 		if (symbol_conf.sym_list == NULL)
 			return;
 		break;
+	case HIST_FILTER__PARALLELISM:
+		if (__bitmap_weight(symbol_conf.parallelism_filter, MAX_NR_CPUS + 1) == 0)
+			return;
+		break;
 	case HIST_FILTER__PARENT:
 	case HIST_FILTER__GUEST:
 	case HIST_FILTER__HOST:
@@ -1515,6 +1521,9 @@ static void hist_entry__apply_hierarchy_filters(struct hist_entry *he)
 	hist_entry__check_and_remove_filter(he, HIST_FILTER__SYMBOL,
 					    perf_hpp__is_sym_entry);
 
+	hist_entry__check_and_remove_filter(he, HIST_FILTER__PARALLELISM,
+					    perf_hpp__is_parallelism_entry);
+
 	hists__apply_filters(he->hists, he);
 }
 
@@ -1711,6 +1720,7 @@ static void hists__apply_filters(struct hists *hists, struct hist_entry *he)
 	hists__filter_entry_by_thread(hists, he);
 	hists__filter_entry_by_symbol(hists, he);
 	hists__filter_entry_by_socket(hists, he);
+	hists__filter_entry_by_parallelism(hists, he);
 }
 
 int hists__collapse_resort(struct hists *hists, struct ui_progress *prog)
@@ -2197,6 +2207,16 @@ static bool hists__filter_entry_by_socket(struct hists *hists,
 	return false;
 }
 
+static bool hists__filter_entry_by_parallelism(struct hists *hists,
+					       struct hist_entry *he)
+{
+	if (test_bit(he->parallelism, hists->parallelism_filter)) {
+		he->filtered |= (1 << HIST_FILTER__PARALLELISM);
+		return true;
+	}
+	return false;
+}
+
 typedef bool (*filter_fn_t)(struct hists *hists, struct hist_entry *he);
 
 static void hists__filter_by_type(struct hists *hists, int type, filter_fn_t filter)
@@ -2366,6 +2386,16 @@ void hists__filter_by_socket(struct hists *hists)
 				      hists__filter_entry_by_socket);
 }
 
+void hists__filter_by_parallelism(struct hists *hists)
+{
+	if (symbol_conf.report_hierarchy)
+		hists__filter_hierarchy(hists, HIST_FILTER__PARALLELISM,
+					hists->parallelism_filter);
+	else
+		hists__filter_by_type(hists, HIST_FILTER__PARALLELISM,
+				      hists__filter_entry_by_parallelism);
+}
+
 void events_stats__inc(struct events_stats *stats, u32 type)
 {
 	++stats->nr_events[0];
@@ -2872,6 +2902,7 @@ int __hists__init(struct hists *hists, struct perf_hpp_list *hpp_list)
 	hists->entries = RB_ROOT_CACHED;
 	mutex_init(&hists->lock);
 	hists->socket_filter = -1;
+	hists->parallelism_filter = symbol_conf.parallelism_filter;
 	hists->hpp_list = hpp_list;
 	INIT_LIST_HEAD(&hists->hpp_formats);
 	return 0;
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 4035106a74087..c2236e0d89f2a 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -31,6 +31,7 @@ enum hist_filter {
 	HIST_FILTER__HOST,
 	HIST_FILTER__SOCKET,
 	HIST_FILTER__C2C,
+	HIST_FILTER__PARALLELISM,
 };
 
 typedef u16 filter_mask_t;
@@ -112,6 +113,7 @@ struct hists {
 	const struct dso	*dso_filter;
 	const char		*uid_filter_str;
 	const char		*symbol_filter_str;
+	unsigned long		*parallelism_filter;
 	struct mutex		lock;
 	struct hists_stats	stats;
 	u64			event_stream;
@@ -388,11 +390,13 @@ void hists__filter_by_dso(struct hists *hists);
 void hists__filter_by_thread(struct hists *hists);
 void hists__filter_by_symbol(struct hists *hists);
 void hists__filter_by_socket(struct hists *hists);
+void hists__filter_by_parallelism(struct hists *hists);
 
 static inline bool hists__has_filter(struct hists *hists)
 {
 	return hists->thread_filter || hists->dso_filter ||
-		hists->symbol_filter_str || (hists->socket_filter > -1);
+		hists->symbol_filter_str || (hists->socket_filter > -1) ||
+		hists->parallelism_filter;
 }
 
 u16 hists__col_len(struct hists *hists, enum hist_column col);
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 7eef43f5be360..3055496358ebb 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -900,6 +900,16 @@ sort__parallelism_cmp(struct hist_entry *left, struct hist_entry *right)
 	return right->parallelism - left->parallelism;
 }
 
+static int hist_entry__parallelism_filter(struct hist_entry *he, int type, const void *arg)
+{
+	const unsigned long *parallelism_filter = arg;
+
+	if (type != HIST_FILTER__PARALLELISM)
+		return -1;
+
+	return test_bit(he->parallelism, parallelism_filter);
+}
+
 static int hist_entry__parallelism_snprintf(struct hist_entry *he, char *bf,
 				    size_t size, unsigned int width)
 {
@@ -909,6 +919,7 @@ static int hist_entry__parallelism_snprintf(struct hist_entry *he, char *bf,
 struct sort_entry sort_parallelism = {
 	.se_header      = "Parallelism",
 	.se_cmp	        = sort__parallelism_cmp,
+	.se_filter	= hist_entry__parallelism_filter,
 	.se_snprintf    = hist_entry__parallelism_snprintf,
 	.se_width_idx	= HISTC_PARALLELISM,
 };
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 49b08adc6ee34..315f74b5bac06 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -18,6 +18,7 @@
 #include "annotate.h"
 #include "build-id.h"
 #include "cap.h"
+#include "cpumap.h"
 #include "dso.h"
 #include "util.h" // lsdir()
 #include "debug.h"
@@ -2471,6 +2472,36 @@ int symbol__annotation_init(void)
 	return 0;
 }
 
+static int setup_parallelism_bitmap(void)
+{
+	struct perf_cpu_map *map;
+	struct perf_cpu cpu;
+	int i, err = -1;
+
+	if (symbol_conf.parallelism_list_str == NULL)
+		return 0;
+
+	map = perf_cpu_map__new(symbol_conf.parallelism_list_str);
+	if (map == NULL) {
+		pr_err("failed to parse parallelism filter list\n");
+		return -1;
+	}
+
+	bitmap_fill(symbol_conf.parallelism_filter, MAX_NR_CPUS + 1);
+	perf_cpu_map__for_each_cpu(cpu, i, map) {
+		if (cpu.cpu <= 0 || cpu.cpu > MAX_NR_CPUS) {
+			pr_err("Requested parallelism level %d is invalid.\n", cpu.cpu);
+			goto out_delete_map;
+		}
+		__clear_bit(cpu.cpu, symbol_conf.parallelism_filter);
+	}
+
+	err = 0;
+out_delete_map:
+	perf_cpu_map__put(map);
+	return err;
+}
+
 int symbol__init(struct perf_env *env)
 {
 	const char *symfs;
@@ -2490,6 +2521,9 @@ int symbol__init(struct perf_env *env)
 		return -1;
 	}
 
+	if (setup_parallelism_bitmap())
+		return -1;
+
 	if (setup_list(&symbol_conf.dso_list,
 		       symbol_conf.dso_list_str, "dso") < 0)
 		return -1;
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index a9c51acc722fe..c5b2e56127e22 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -3,6 +3,8 @@
 #define __PERF_SYMBOL_CONF 1
 
 #include <stdbool.h>
+#include <linux/bitmap.h>
+#include "perf.h"
 
 struct strlist;
 struct intlist;
@@ -62,6 +64,7 @@ struct symbol_conf {
 			*pid_list_str,
 			*tid_list_str,
 			*sym_list_str,
+			*parallelism_list_str,
 			*col_width_list_str,
 			*bt_stop_list_str;
 	const char		*addr2line_path;
@@ -82,6 +85,7 @@ struct symbol_conf {
 	int		pad_output_len_dso;
 	int		group_sort_idx;
 	int		addr_range;
+	DECLARE_BITMAP(parallelism_filter, MAX_NR_CPUS + 1);
 };
 
 extern struct symbol_conf symbol_conf;
-- 
2.48.1.362.g079036d154-goog

