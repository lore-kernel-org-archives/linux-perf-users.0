Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734AE1E04A9
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Feb 2025 11:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738928488; cv=none; b=CvO/W3pokoU7qGIWr/THQ8cJC46vA5wWp9cFB9MukHq9lXIzuOChNgbUZ8k4wCzSu7rHUFCIUBWs+BjuZ1aLIxq5GfjEZZftja3P6ePg9nRVWeob/h0lvmjM5kMDWryz/RpU77rbHK882SzzlUWfS3vKn2BZFybxFIWETUfcFAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738928488; c=relaxed/simple;
	bh=sOhn0KnO2WzqPNgeHhQYU9u8KXnTV/qmcB6LUFGm99A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P4RGyIwuLyWRjsPAJv2bVWX7K+D8t4BTfX3MF7JcyCK+CM5JTEbPN+1QdQdEk/zDcQcFCOj4PoysebtV6PqbZrrCrfF5tqV/FbpO1bSKbtCkYVqiwUgxxCWRvKxgmq5zHc0XqZc2CVYtQEHqyFjwj+DMiTuqGERuZsq8j3tQUT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nG5yTFkA; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nG5yTFkA"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-438e4e9a53fso15563845e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 03:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738928484; x=1739533284; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Z+v5W5R67xiAzE9NJMzr/vTsU6YAr1VcvF4I8FLOHM=;
        b=nG5yTFkA0gT9JhHbLW+Qk1Bx45p5rw9CaRDupPXgMnAEfBnNOEmbkJpcpwo2U8CLjA
         /F3TyGCXZsAuNLbZT+LYKq+W9h0kx538n3aOcKwIPbVo1ibJQ1AB+Bz6M33M1MChN14l
         xBRRgTU7B7DhryFhjumKVkxrhNapPgPgj6WrrjE6WoBJ15eflLzHrljACyABN1MZePou
         iGY1dUM3qs34HIDOnT+xbbGaYVhmV6NNRv02uK0v7XzwhoulOv5y/h4rqdkrbULTDTLs
         3qA4rDYDqrWeTTc9PUXGI7DQ7RMdxzfbGXpL7nqMhslFkHlYyVg1A+u+875NBfp0F5E7
         6n7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738928484; x=1739533284;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Z+v5W5R67xiAzE9NJMzr/vTsU6YAr1VcvF4I8FLOHM=;
        b=DCJxHS6tqYKa6+4Fk1M5tdHRdxt8KuTxRfmREJXsj42146hGWEWS3BzPf+3q/bY6sd
         GNJTW1A3oY0vy1P5pbNy1cnBfedD7ees6JEKmnkOOkb3J6BRZ9z7U6H6tNRPNyPS46YT
         LBUxRzCjU2NTK1l5FbOlOyF/uVweVLgrvF++oAxZN0j08Q57ZbTHQW9OhraYEetIRFF8
         esyUTegjQaNjAMDzaJj1dNe7FksqtIfSQfUAy8cVDQDekMEjALFiXkW77dNSCOW6soBn
         Q25dt8sNM8rZsGLV29gTj9C2IJLA0d+t7r68WkMHQ0gnkALDHrNpIQbFrw+ReglZNec5
         /XKg==
X-Gm-Message-State: AOJu0YyD9x5ojui7Q6Vk7OxUdv6JBBW7rrpQL8P0RR+R1EWjM2Hfjkn1
	YoFkX03FzTms9yXTdppDLm+//FvcvMlPdesXj8G92qY/v/NAu0+OK0uFeDpNpAKYZfQUc/7nPuk
	q1Nzc5A==
X-Google-Smtp-Source: AGHT+IHIfJi43TC3oND3NNDIRK6r5DA/9eKC4eWLU3mCjPS5jDRigiGUd3h/jn4TeeNHsbEPyfo04HPKRz24
X-Received: from wmbhc23.prod.google.com ([2002:a05:600c:8717:b0:434:f0d4:cbaf])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1d0c:b0:434:ff30:a159
 with SMTP id 5b1f17b1804b1-439248d395cmr28096755e9.0.1738928483899; Fri, 07
 Feb 2025 03:41:23 -0800 (PST)
Date: Fri,  7 Feb 2025 12:40:32 +0100
In-Reply-To: <cover.1738928210.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1738928210.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <45bea37a8a04ccdbea027b7263453d3447a63d9c.1738928210.git.dvyukov@google.com>
Subject: [PATCH v6 5/9] perf report: Add latency output field
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com, ak@linux.intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Latency output field is similar to overhead, but represents overhead for
latency rather than CPU consumption. It's re-scaled from overhead by dividing
weight by the current parallelism level at the time of the sample.
It effectively models profiling with 1 sample taken per unit of wall-clock
time rather than unit of CPU time.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Changes in v5:
 - fixed formatting of latency field in --stdout mode
---
 tools/perf/ui/browsers/hists.c  | 27 ++++++++-----
 tools/perf/ui/hist.c            | 69 ++++++++++++++++++---------------
 tools/perf/util/addr_location.h |  2 +
 tools/perf/util/event.c         |  6 +++
 tools/perf/util/events_stats.h  |  2 +
 tools/perf/util/hist.c          | 55 +++++++++++++++++++-------
 tools/perf/util/hist.h          | 12 ++++++
 tools/perf/util/sort.c          |  2 +
 8 files changed, 120 insertions(+), 55 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 49ba82bf33918..35c10509b797f 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -1226,7 +1226,7 @@ int __hpp__slsmg_color_printf(struct perf_hpp *hpp, const char *fmt, ...)
 	return ret;
 }
 
-#define __HPP_COLOR_PERCENT_FN(_type, _field)				\
+#define __HPP_COLOR_PERCENT_FN(_type, _field, _fmttype)			\
 static u64 __hpp_get_##_field(struct hist_entry *he)			\
 {									\
 	return he->stat._field;						\
@@ -1238,10 +1238,10 @@ hist_browser__hpp_color_##_type(struct perf_hpp_fmt *fmt,		\
 				struct hist_entry *he)			\
 {									\
 	return hpp__fmt(fmt, hpp, he, __hpp_get_##_field, " %*.2f%%",	\
-			__hpp__slsmg_color_printf, true);		\
+			__hpp__slsmg_color_printf, _fmttype);		\
 }
 
-#define __HPP_COLOR_ACC_PERCENT_FN(_type, _field)			\
+#define __HPP_COLOR_ACC_PERCENT_FN(_type, _field, _fmttype)		\
 static u64 __hpp_get_acc_##_field(struct hist_entry *he)		\
 {									\
 	return he->stat_acc->_field;					\
@@ -1262,15 +1262,18 @@ hist_browser__hpp_color_##_type(struct perf_hpp_fmt *fmt,		\
 		return ret;						\
 	}								\
 	return hpp__fmt(fmt, hpp, he, __hpp_get_acc_##_field,		\
-			" %*.2f%%", __hpp__slsmg_color_printf, true);	\
+			" %*.2f%%", __hpp__slsmg_color_printf,		\
+			_fmttype);					\
 }
 
-__HPP_COLOR_PERCENT_FN(overhead, period)
-__HPP_COLOR_PERCENT_FN(overhead_sys, period_sys)
-__HPP_COLOR_PERCENT_FN(overhead_us, period_us)
-__HPP_COLOR_PERCENT_FN(overhead_guest_sys, period_guest_sys)
-__HPP_COLOR_PERCENT_FN(overhead_guest_us, period_guest_us)
-__HPP_COLOR_ACC_PERCENT_FN(overhead_acc, period)
+__HPP_COLOR_PERCENT_FN(overhead, period, PERF_HPP_FMT_TYPE__PERCENT)
+__HPP_COLOR_PERCENT_FN(latency, latency, PERF_HPP_FMT_TYPE__LATENCY)
+__HPP_COLOR_PERCENT_FN(overhead_sys, period_sys, PERF_HPP_FMT_TYPE__PERCENT)
+__HPP_COLOR_PERCENT_FN(overhead_us, period_us, PERF_HPP_FMT_TYPE__PERCENT)
+__HPP_COLOR_PERCENT_FN(overhead_guest_sys, period_guest_sys, PERF_HPP_FMT_TYPE__PERCENT)
+__HPP_COLOR_PERCENT_FN(overhead_guest_us, period_guest_us, PERF_HPP_FMT_TYPE__PERCENT)
+__HPP_COLOR_ACC_PERCENT_FN(overhead_acc, period, PERF_HPP_FMT_TYPE__PERCENT)
+__HPP_COLOR_ACC_PERCENT_FN(latency_acc, latency, PERF_HPP_FMT_TYPE__LATENCY)
 
 #undef __HPP_COLOR_PERCENT_FN
 #undef __HPP_COLOR_ACC_PERCENT_FN
@@ -1279,6 +1282,8 @@ void hist_browser__init_hpp(void)
 {
 	perf_hpp__format[PERF_HPP__OVERHEAD].color =
 				hist_browser__hpp_color_overhead;
+	perf_hpp__format[PERF_HPP__LATENCY].color =
+				hist_browser__hpp_color_latency;
 	perf_hpp__format[PERF_HPP__OVERHEAD_SYS].color =
 				hist_browser__hpp_color_overhead_sys;
 	perf_hpp__format[PERF_HPP__OVERHEAD_US].color =
@@ -1289,6 +1294,8 @@ void hist_browser__init_hpp(void)
 				hist_browser__hpp_color_overhead_guest_us;
 	perf_hpp__format[PERF_HPP__OVERHEAD_ACC].color =
 				hist_browser__hpp_color_overhead_acc;
+	perf_hpp__format[PERF_HPP__LATENCY_ACC].color =
+				hist_browser__hpp_color_latency_acc;
 
 	res_sample_init();
 }
diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index 34fda1d5eccb4..6de6309595f9e 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -27,9 +27,10 @@ static int __hpp__fmt_print(struct perf_hpp *hpp, struct hists *hists, u64 val,
 			    int nr_samples, const char *fmt, int len,
 			    hpp_snprint_fn print_fn, enum perf_hpp_fmt_type fmtype)
 {
-	if (fmtype == PERF_HPP_FMT_TYPE__PERCENT) {
+	if (fmtype == PERF_HPP_FMT_TYPE__PERCENT || fmtype == PERF_HPP_FMT_TYPE__LATENCY) {
 		double percent = 0.0;
-		u64 total = hists__total_period(hists);
+		u64 total = fmtype == PERF_HPP_FMT_TYPE__PERCENT ? hists__total_period(hists) :
+			hists__total_latency(hists);
 
 		if (total)
 			percent = 100.0 * val / total;
@@ -128,7 +129,7 @@ int hpp__fmt(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 				  print_fn, fmtype);
 	}
 
-	if (fmtype == PERF_HPP_FMT_TYPE__PERCENT)
+	if (fmtype == PERF_HPP_FMT_TYPE__PERCENT || fmtype == PERF_HPP_FMT_TYPE__LATENCY)
 		len -= 2; /* 2 for a space and a % sign */
 	else
 		len -= 1;
@@ -356,7 +357,7 @@ static int hpp_entry_scnprintf(struct perf_hpp *hpp, const char *fmt, ...)
 	return (ret >= ssize) ? (ssize - 1) : ret;
 }
 
-#define __HPP_COLOR_PERCENT_FN(_type, _field)					\
+#define __HPP_COLOR_PERCENT_FN(_type, _field, _fmttype)				\
 static u64 he_get_##_field(struct hist_entry *he)				\
 {										\
 	return he->stat._field;							\
@@ -366,15 +367,15 @@ static int hpp__color_##_type(struct perf_hpp_fmt *fmt,				\
 			      struct perf_hpp *hpp, struct hist_entry *he) 	\
 {										\
 	return hpp__fmt(fmt, hpp, he, he_get_##_field, " %*.2f%%",		\
-			hpp_color_scnprintf, PERF_HPP_FMT_TYPE__PERCENT);	\
+			hpp_color_scnprintf, _fmttype);				\
 }
 
-#define __HPP_ENTRY_PERCENT_FN(_type, _field)					\
+#define __HPP_ENTRY_PERCENT_FN(_type, _field, _fmttype)				\
 static int hpp__entry_##_type(struct perf_hpp_fmt *fmt,				\
 			      struct perf_hpp *hpp, struct hist_entry *he) 	\
 {										\
 	return hpp__fmt(fmt, hpp, he, he_get_##_field, " %*.2f%%",		\
-			hpp_entry_scnprintf, PERF_HPP_FMT_TYPE__PERCENT);	\
+			hpp_entry_scnprintf, _fmttype);	\
 }
 
 #define __HPP_SORT_FN(_type, _field)						\
@@ -384,7 +385,7 @@ static int64_t hpp__sort_##_type(struct perf_hpp_fmt *fmt __maybe_unused, 	\
 	return __hpp__sort(a, b, he_get_##_field);				\
 }
 
-#define __HPP_COLOR_ACC_PERCENT_FN(_type, _field)				\
+#define __HPP_COLOR_ACC_PERCENT_FN(_type, _field, _fmttype)			\
 static u64 he_get_acc_##_field(struct hist_entry *he)				\
 {										\
 	return he->stat_acc->_field;						\
@@ -394,15 +395,15 @@ static int hpp__color_##_type(struct perf_hpp_fmt *fmt,				\
 			      struct perf_hpp *hpp, struct hist_entry *he) 	\
 {										\
 	return hpp__fmt_acc(fmt, hpp, he, he_get_acc_##_field, " %*.2f%%", 	\
-			    hpp_color_scnprintf, PERF_HPP_FMT_TYPE__PERCENT);	\
+			    hpp_color_scnprintf, _fmttype);			\
 }
 
-#define __HPP_ENTRY_ACC_PERCENT_FN(_type, _field)				\
+#define __HPP_ENTRY_ACC_PERCENT_FN(_type, _field, _fmttype)			\
 static int hpp__entry_##_type(struct perf_hpp_fmt *fmt,				\
 			      struct perf_hpp *hpp, struct hist_entry *he) 	\
 {										\
 	return hpp__fmt_acc(fmt, hpp, he, he_get_acc_##_field, " %*.2f%%",	\
-			    hpp_entry_scnprintf, PERF_HPP_FMT_TYPE__PERCENT);	\
+			    hpp_entry_scnprintf, _fmttype);			\
 }
 
 #define __HPP_SORT_ACC_FN(_type, _field)					\
@@ -453,14 +454,14 @@ static int64_t hpp__sort_##_type(struct perf_hpp_fmt *fmt __maybe_unused, 	\
 }
 
 
-#define HPP_PERCENT_FNS(_type, _field)					\
-__HPP_COLOR_PERCENT_FN(_type, _field)					\
-__HPP_ENTRY_PERCENT_FN(_type, _field)					\
+#define HPP_PERCENT_FNS(_type, _field, _fmttype)			\
+__HPP_COLOR_PERCENT_FN(_type, _field, _fmttype)				\
+__HPP_ENTRY_PERCENT_FN(_type, _field, _fmttype)				\
 __HPP_SORT_FN(_type, _field)
 
-#define HPP_PERCENT_ACC_FNS(_type, _field)				\
-__HPP_COLOR_ACC_PERCENT_FN(_type, _field)				\
-__HPP_ENTRY_ACC_PERCENT_FN(_type, _field)				\
+#define HPP_PERCENT_ACC_FNS(_type, _field, _fmttype)			\
+__HPP_COLOR_ACC_PERCENT_FN(_type, _field, _fmttype)			\
+__HPP_ENTRY_ACC_PERCENT_FN(_type, _field, _fmttype)			\
 __HPP_SORT_ACC_FN(_type, _field)
 
 #define HPP_RAW_FNS(_type, _field)					\
@@ -471,12 +472,14 @@ __HPP_SORT_RAW_FN(_type, _field)
 __HPP_ENTRY_AVERAGE_FN(_type, _field)					\
 __HPP_SORT_AVERAGE_FN(_type, _field)
 
-HPP_PERCENT_FNS(overhead, period)
-HPP_PERCENT_FNS(overhead_sys, period_sys)
-HPP_PERCENT_FNS(overhead_us, period_us)
-HPP_PERCENT_FNS(overhead_guest_sys, period_guest_sys)
-HPP_PERCENT_FNS(overhead_guest_us, period_guest_us)
-HPP_PERCENT_ACC_FNS(overhead_acc, period)
+HPP_PERCENT_FNS(overhead, period, PERF_HPP_FMT_TYPE__PERCENT)
+HPP_PERCENT_FNS(latency, latency, PERF_HPP_FMT_TYPE__LATENCY)
+HPP_PERCENT_FNS(overhead_sys, period_sys, PERF_HPP_FMT_TYPE__PERCENT)
+HPP_PERCENT_FNS(overhead_us, period_us, PERF_HPP_FMT_TYPE__PERCENT)
+HPP_PERCENT_FNS(overhead_guest_sys, period_guest_sys, PERF_HPP_FMT_TYPE__PERCENT)
+HPP_PERCENT_FNS(overhead_guest_us, period_guest_us, PERF_HPP_FMT_TYPE__PERCENT)
+HPP_PERCENT_ACC_FNS(overhead_acc, period, PERF_HPP_FMT_TYPE__PERCENT)
+HPP_PERCENT_ACC_FNS(latency_acc, latency, PERF_HPP_FMT_TYPE__LATENCY)
 
 HPP_RAW_FNS(samples, nr_events)
 HPP_RAW_FNS(period, period)
@@ -548,11 +551,13 @@ static bool hpp__equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)
 
 struct perf_hpp_fmt perf_hpp__format[] = {
 	HPP__COLOR_PRINT_FNS("Overhead", overhead, OVERHEAD),
+	HPP__COLOR_PRINT_FNS("Latency", latency, LATENCY),
 	HPP__COLOR_PRINT_FNS("sys", overhead_sys, OVERHEAD_SYS),
 	HPP__COLOR_PRINT_FNS("usr", overhead_us, OVERHEAD_US),
 	HPP__COLOR_PRINT_FNS("guest sys", overhead_guest_sys, OVERHEAD_GUEST_SYS),
 	HPP__COLOR_PRINT_FNS("guest usr", overhead_guest_us, OVERHEAD_GUEST_US),
 	HPP__COLOR_ACC_PRINT_FNS("Children", overhead_acc, OVERHEAD_ACC),
+	HPP__COLOR_ACC_PRINT_FNS("Latency", latency_acc, LATENCY_ACC),
 	HPP__PRINT_FNS("Samples", samples, SAMPLES),
 	HPP__PRINT_FNS("Period", period, PERIOD),
 	HPP__PRINT_FNS("Weight1", weight1, WEIGHT1),
@@ -601,6 +606,11 @@ static void fmt_free(struct perf_hpp_fmt *fmt)
 		fmt->free(fmt);
 }
 
+static bool fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)
+{
+	return a->equal && a->equal(a, b);
+}
+
 void perf_hpp__init(void)
 {
 	int i;
@@ -671,30 +681,26 @@ static void perf_hpp__column_unregister(struct perf_hpp_fmt *format)
 
 void perf_hpp__cancel_cumulate(void)
 {
-	struct perf_hpp_fmt *fmt, *acc, *ovh, *tmp;
+	struct perf_hpp_fmt *fmt, *acc, *ovh, *acc_lat, *tmp;
 
 	if (is_strict_order(field_order))
 		return;
 
 	ovh = &perf_hpp__format[PERF_HPP__OVERHEAD];
 	acc = &perf_hpp__format[PERF_HPP__OVERHEAD_ACC];
+	acc_lat = &perf_hpp__format[PERF_HPP__LATENCY_ACC];
 
 	perf_hpp_list__for_each_format_safe(&perf_hpp_list, fmt, tmp) {
-		if (acc->equal(acc, fmt)) {
+		if (fmt_equal(acc, fmt) || fmt_equal(acc_lat, fmt)) {
 			perf_hpp__column_unregister(fmt);
 			continue;
 		}
 
-		if (ovh->equal(ovh, fmt))
+		if (fmt_equal(ovh, fmt))
 			fmt->name = "Overhead";
 	}
 }
 
-static bool fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)
-{
-	return a->equal && a->equal(a, b);
-}
-
 void perf_hpp__setup_output_field(struct perf_hpp_list *list)
 {
 	struct perf_hpp_fmt *fmt;
@@ -819,6 +825,7 @@ void perf_hpp__reset_width(struct perf_hpp_fmt *fmt, struct hists *hists)
 
 	switch (fmt->idx) {
 	case PERF_HPP__OVERHEAD:
+	case PERF_HPP__LATENCY:
 	case PERF_HPP__OVERHEAD_SYS:
 	case PERF_HPP__OVERHEAD_US:
 	case PERF_HPP__OVERHEAD_ACC:
diff --git a/tools/perf/util/addr_location.h b/tools/perf/util/addr_location.h
index f83d74e370b2f..663e9a55d8ed3 100644
--- a/tools/perf/util/addr_location.h
+++ b/tools/perf/util/addr_location.h
@@ -24,6 +24,8 @@ struct addr_location {
 	s32	      socket;
 	/* Same as machine.parallelism but within [1, nr_cpus]. */
 	int	      parallelism;
+	/* See he_stat.latency. */
+	u64	      latency;
 };
 
 void addr_location__init(struct addr_location *al);
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 6ceed46acd5a4..c23b77f8f854a 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -771,6 +771,12 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 	al->parallelism = max(1, min(machine->parallelism, machine__nr_cpus_avail(machine)));
 	if (test_bit(al->parallelism, symbol_conf.parallelism_filter))
 		al->filtered |= (1 << HIST_FILTER__PARALLELISM);
+	/*
+	 * Multiply it by some const to avoid precision loss or dealing
+	 * with floats. The multiplier does not matter otherwise since
+	 * we only print it as percents.
+	 */
+	al->latency = sample->period * 1000 / al->parallelism;
 
 	if (al->map) {
 		if (symbol_conf.dso_list &&
diff --git a/tools/perf/util/events_stats.h b/tools/perf/util/events_stats.h
index eabd7913c3092..dcff697ed2529 100644
--- a/tools/perf/util/events_stats.h
+++ b/tools/perf/util/events_stats.h
@@ -57,6 +57,8 @@ struct events_stats {
 struct hists_stats {
 	u64 total_period;
 	u64 total_non_filtered_period;
+	u64 total_latency;
+	u64 total_non_filtered_latency;
 	u32 nr_samples;
 	u32 nr_non_filtered_samples;
 	u32 nr_lost_samples;
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 446342246f5ee..a29324e33ed04 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -305,9 +305,10 @@ static long hist_time(unsigned long htime)
 	return htime;
 }
 
-static void he_stat__add_period(struct he_stat *he_stat, u64 period)
+static void he_stat__add_period(struct he_stat *he_stat, u64 period, u64 latency)
 {
 	he_stat->period		+= period;
+	he_stat->latency	+= latency;
 	he_stat->nr_events	+= 1;
 }
 
@@ -322,6 +323,7 @@ static void he_stat__add_stat(struct he_stat *dest, struct he_stat *src)
 	dest->weight2		+= src->weight2;
 	dest->weight3		+= src->weight3;
 	dest->nr_events		+= src->nr_events;
+	dest->latency		+= src->latency;
 }
 
 static void he_stat__decay(struct he_stat *he_stat)
@@ -331,6 +333,7 @@ static void he_stat__decay(struct he_stat *he_stat)
 	he_stat->weight1 = (he_stat->weight1 * 7) / 8;
 	he_stat->weight2 = (he_stat->weight2 * 7) / 8;
 	he_stat->weight3 = (he_stat->weight3 * 7) / 8;
+	he_stat->latency = (he_stat->latency * 7) / 8;
 }
 
 static void hists__delete_entry(struct hists *hists, struct hist_entry *he);
@@ -338,7 +341,7 @@ static void hists__delete_entry(struct hists *hists, struct hist_entry *he);
 static bool hists__decay_entry(struct hists *hists, struct hist_entry *he)
 {
 	u64 prev_period = he->stat.period;
-	u64 diff;
+	u64 prev_latency = he->stat.latency;
 
 	if (prev_period == 0)
 		return true;
@@ -348,12 +351,16 @@ static bool hists__decay_entry(struct hists *hists, struct hist_entry *he)
 		he_stat__decay(he->stat_acc);
 	decay_callchain(he->callchain);
 
-	diff = prev_period - he->stat.period;
-
 	if (!he->depth) {
-		hists->stats.total_period -= diff;
-		if (!he->filtered)
-			hists->stats.total_non_filtered_period -= diff;
+		u64 period_diff = prev_period - he->stat.period;
+		u64 latency_diff = prev_latency - he->stat.latency;
+
+		hists->stats.total_period -= period_diff;
+		hists->stats.total_latency -= latency_diff;
+		if (!he->filtered) {
+			hists->stats.total_non_filtered_period -= period_diff;
+			hists->stats.total_non_filtered_latency -= latency_diff;
+		}
 	}
 
 	if (!he->leaf) {
@@ -368,7 +375,7 @@ static bool hists__decay_entry(struct hists *hists, struct hist_entry *he)
 		}
 	}
 
-	return he->stat.period == 0;
+	return he->stat.period == 0 && he->stat.latency == 0;
 }
 
 static void hists__delete_entry(struct hists *hists, struct hist_entry *he)
@@ -594,14 +601,17 @@ static filter_mask_t symbol__parent_filter(const struct symbol *parent)
 	return 0;
 }
 
-static void hist_entry__add_callchain_period(struct hist_entry *he, u64 period)
+static void hist_entry__add_callchain_period(struct hist_entry *he, u64 period, u64 latency)
 {
 	if (!hist_entry__has_callchains(he) || !symbol_conf.use_callchain)
 		return;
 
 	he->hists->callchain_period += period;
-	if (!he->filtered)
+	he->hists->callchain_latency += latency;
+	if (!he->filtered) {
 		he->hists->callchain_non_filtered_period += period;
+		he->hists->callchain_non_filtered_latency += latency;
+	}
 }
 
 static struct hist_entry *hists__findnew_entry(struct hists *hists,
@@ -614,6 +624,7 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
 	struct hist_entry *he;
 	int64_t cmp;
 	u64 period = entry->stat.period;
+	u64 latency = entry->stat.latency;
 	bool leftmost = true;
 
 	p = &hists->entries_in->rb_root.rb_node;
@@ -632,10 +643,10 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
 		if (!cmp) {
 			if (sample_self) {
 				he_stat__add_stat(&he->stat, &entry->stat);
-				hist_entry__add_callchain_period(he, period);
+				hist_entry__add_callchain_period(he, period, latency);
 			}
 			if (symbol_conf.cumulate_callchain)
-				he_stat__add_period(he->stat_acc, period);
+				he_stat__add_period(he->stat_acc, period, latency);
 
 			block_info__delete(entry->block_info);
 
@@ -672,7 +683,7 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
 		return NULL;
 
 	if (sample_self)
-		hist_entry__add_callchain_period(he, period);
+		hist_entry__add_callchain_period(he, period, latency);
 	hists->nr_entries++;
 
 	rb_link_node(&he->rb_node_in, parent, p);
@@ -751,6 +762,7 @@ __hists__add_entry(struct hists *hists,
 			.weight1 = sample->weight,
 			.weight2 = sample->ins_lat,
 			.weight3 = sample->p_stage_cyc,
+			.latency = al->latency,
 		},
 		.parent = sym_parent,
 		.filtered = symbol__parent_filter(sym_parent) | al->filtered,
@@ -1768,12 +1780,14 @@ static void hists__reset_filter_stats(struct hists *hists)
 {
 	hists->nr_non_filtered_entries = 0;
 	hists->stats.total_non_filtered_period = 0;
+	hists->stats.total_non_filtered_latency = 0;
 }
 
 void hists__reset_stats(struct hists *hists)
 {
 	hists->nr_entries = 0;
 	hists->stats.total_period = 0;
+	hists->stats.total_latency = 0;
 
 	hists__reset_filter_stats(hists);
 }
@@ -1782,6 +1796,7 @@ static void hists__inc_filter_stats(struct hists *hists, struct hist_entry *h)
 {
 	hists->nr_non_filtered_entries++;
 	hists->stats.total_non_filtered_period += h->stat.period;
+	hists->stats.total_non_filtered_latency += h->stat.latency;
 }
 
 void hists__inc_stats(struct hists *hists, struct hist_entry *h)
@@ -1791,6 +1806,7 @@ void hists__inc_stats(struct hists *hists, struct hist_entry *h)
 
 	hists->nr_entries++;
 	hists->stats.total_period += h->stat.period;
+	hists->stats.total_latency += h->stat.latency;
 }
 
 static void hierarchy_recalc_total_periods(struct hists *hists)
@@ -1802,6 +1818,8 @@ static void hierarchy_recalc_total_periods(struct hists *hists)
 
 	hists->stats.total_period = 0;
 	hists->stats.total_non_filtered_period = 0;
+	hists->stats.total_latency = 0;
+	hists->stats.total_non_filtered_latency = 0;
 
 	/*
 	 * recalculate total period using top-level entries only
@@ -1813,8 +1831,11 @@ static void hierarchy_recalc_total_periods(struct hists *hists)
 		node = rb_next(node);
 
 		hists->stats.total_period += he->stat.period;
-		if (!he->filtered)
+		hists->stats.total_latency += he->stat.latency;
+		if (!he->filtered) {
 			hists->stats.total_non_filtered_period += he->stat.period;
+			hists->stats.total_non_filtered_latency += he->stat.latency;
+		}
 	}
 }
 
@@ -2791,6 +2812,12 @@ u64 hists__total_period(struct hists *hists)
 		hists->stats.total_period;
 }
 
+u64 hists__total_latency(struct hists *hists)
+{
+	return symbol_conf.filter_relative ? hists->stats.total_non_filtered_latency :
+		hists->stats.total_latency;
+}
+
 int __hists__scnprintf_title(struct hists *hists, char *bf, size_t size, bool show_freq)
 {
 	char unit;
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index c2236e0d89f2a..91159f16c60b2 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -109,6 +109,8 @@ struct hists {
 	u64			nr_non_filtered_entries;
 	u64			callchain_period;
 	u64			callchain_non_filtered_period;
+	u64			callchain_latency;
+	u64			callchain_non_filtered_latency;
 	struct thread		*thread_filter;
 	const struct dso	*dso_filter;
 	const char		*uid_filter_str;
@@ -170,6 +172,12 @@ struct res_sample {
 
 struct he_stat {
 	u64			period;
+	/*
+	 * Period re-scaled from CPU time to wall-clock time (divided by the
+	 * parallelism at the time of the sample). This represents effect of
+	 * the event on latency rather than CPU consumption.
+	 */
+	u64			latency;
 	u64			period_sys;
 	u64			period_us;
 	u64			period_guest_sys;
@@ -374,6 +382,7 @@ void hists__output_recalc_col_len(struct hists *hists, int max_rows);
 struct hist_entry *hists__get_entry(struct hists *hists, int idx);
 
 u64 hists__total_period(struct hists *hists);
+u64 hists__total_latency(struct hists *hists);
 void hists__reset_stats(struct hists *hists);
 void hists__inc_stats(struct hists *hists, struct hist_entry *h);
 void hists__inc_nr_events(struct hists *hists);
@@ -555,11 +564,13 @@ extern struct perf_hpp_fmt perf_hpp__format[];
 enum {
 	/* Matches perf_hpp__format array. */
 	PERF_HPP__OVERHEAD,
+	PERF_HPP__LATENCY,
 	PERF_HPP__OVERHEAD_SYS,
 	PERF_HPP__OVERHEAD_US,
 	PERF_HPP__OVERHEAD_GUEST_SYS,
 	PERF_HPP__OVERHEAD_GUEST_US,
 	PERF_HPP__OVERHEAD_ACC,
+	PERF_HPP__LATENCY_ACC,
 	PERF_HPP__SAMPLES,
 	PERF_HPP__PERIOD,
 	PERF_HPP__WEIGHT1,
@@ -615,6 +626,7 @@ void hists__reset_column_width(struct hists *hists);
 enum perf_hpp_fmt_type {
 	PERF_HPP_FMT_TYPE__RAW,
 	PERF_HPP_FMT_TYPE__PERCENT,
+	PERF_HPP_FMT_TYPE__LATENCY,
 	PERF_HPP_FMT_TYPE__AVERAGE,
 };
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 3055496358ebb..bc4c3acfe7552 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2628,11 +2628,13 @@ struct hpp_dimension {
 
 static struct hpp_dimension hpp_sort_dimensions[] = {
 	DIM(PERF_HPP__OVERHEAD, "overhead"),
+	DIM(PERF_HPP__LATENCY, "latency"),
 	DIM(PERF_HPP__OVERHEAD_SYS, "overhead_sys"),
 	DIM(PERF_HPP__OVERHEAD_US, "overhead_us"),
 	DIM(PERF_HPP__OVERHEAD_GUEST_SYS, "overhead_guest_sys"),
 	DIM(PERF_HPP__OVERHEAD_GUEST_US, "overhead_guest_us"),
 	DIM(PERF_HPP__OVERHEAD_ACC, "overhead_children"),
+	DIM(PERF_HPP__LATENCY_ACC, "latency_children"),
 	DIM(PERF_HPP__SAMPLES, "sample"),
 	DIM(PERF_HPP__PERIOD, "period"),
 	DIM(PERF_HPP__WEIGHT1, "weight1"),
-- 
2.48.1.502.g6dc24dfdaf-goog

