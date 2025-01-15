Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8E62309A5
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jan 2025 08:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736928066; cv=none; b=E1WlWxbK29YMvHOVczt7x+mMSfRFaCKtAu6iUUBwSzJs5tKGm6hE4GxZEWGyUWLizlTLBww3vl4sTGBO/vHruADUH9h/YgProQZo91xC3hugEKtHENJjPTRteMmQNc8qdfTkotLvKrDNlZTP8f4QRX2M5XlM2rC3UsXC4pZND/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736928066; c=relaxed/simple;
	bh=YKHxLAnwi1/RFMou0CO808TfBTITsxzcHkibYVw5Mwo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kcBxsa1XdLxUqhdcaSz8g1ePtxy6BCXy8AsN9mGcY4PaMaUI25XP/Vg6ka0P6fRm52p3pIH7vA87LwbFNBXX9hobhSm54tK/UOvAAmXqNNAU8jJgEogawzzVvLIOg8YNiBLsJhW1/B1Fd6wrUn+TmMybsNXnFcHL63v/xLt5JLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tqp28Gbk; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tqp28Gbk"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5d3cff6aedbso722840a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jan 2025 00:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736928063; x=1737532863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YgHKE3uZqH4ST2EhNohkGFxAJXehtiGaOdsmit+cAuY=;
        b=tqp28GbkFDaoldts3q5FzEshcchxv0Yra1ffgoJDN7yg0yXqOEarDuiZHPtS0sY1pf
         m5gnaxjGmmd18cgMLYO7BarL+Mx8B/M5aePGkxsMcSyM9h9K45GrOxhhf1ocrpaYL9bj
         76fLwvEq+sAk5E7DA+XXZDS7ndneLuQp1uk9U22BveL/xcTaDGOYR8+017aCFDAea2bF
         VwFLlQcG7jkkLs/fB+29ij6f3eWrV6qUYfePDKC2t0SQ37uC/ql0TCKo9Js0JMWX79WP
         Gy62ophkk/jO/0ibMAs4r6TacyYqHqEQJc6JUPaCBioIXpQMNSxD+wkO2LKd+E95+JJH
         uNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736928063; x=1737532863;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YgHKE3uZqH4ST2EhNohkGFxAJXehtiGaOdsmit+cAuY=;
        b=gsAs6ojZxSl3rXgdqTXxPvh1ayVoZY6bg8D70YV5ZtSZAU/QK0fudLrPWtcllI5AMj
         x3uMFl7SB2Dyxb49CpSLe+rOnfWc7EEUSdIFXOKdxgW23ukRmF1q+90eDmnSN6HIcYdY
         3ZOxRZtrgOOmaYm3El472OYe/Ha3OpuG9dEnQqgJWxxq9w3kCvpr09uP/MWiRFG7r9sJ
         xa4maf5dMOW8Al/NVar4Gij2JeEzI2CeZo66WDuDD0Pgnn/qu7S2JTYjTfN75KLiRIPu
         ZgCkWzY2kqnxHMbiAbcWuNgwrqKfSuiWgJA6m621OGFzMHEoI1AiIHBEQe0ArbfhA7N7
         cvuw==
X-Gm-Message-State: AOJu0YzCFwGlRgebH7LOvU61leaBwvP+xfBhaEfFbNKBibrxjItsoByp
	AGhvV3IMTtV4edQbkWLKcUyATtwcTXzbvRIxSD0uoeaTG0Y/WjW2spVYl1mvTl8FuLnJpPR+U02
	qxoq5BQ==
X-Google-Smtp-Source: AGHT+IHN6w2FMMthhnA3GmLnZ6CBcMdxbW6uiBVxYW7Oy7R2XJatzlT8mYEDwMJrIUH3NvuPCDn+ZnwdO1uR
X-Received: from edpj11.prod.google.com ([2002:aa7:c0cb:0:b0:5d9:3dfe:dcaf])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:845:b0:5d9:c2f:a961
 with SMTP id 4fb4d7f45d1cf-5da0c2f19e7mr1440448a12.11.1736928063010; Wed, 15
 Jan 2025 00:01:03 -0800 (PST)
Date: Wed, 15 Jan 2025 09:00:41 +0100
In-Reply-To: <cover.1736927981.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1736927981.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <84c4b55614e24a344f86ae0db62e8fa8f251f874.1736927981.git.dvyukov@google.com>
Subject: [PATCH v3 1/2] perf hist: Deduplicate cmp/sort/collapse code
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

Application of cmp/sort/collapse fmt callbacks is duplicated 6 times.
Factor it into a common helper function. NFC.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---

Changes in v2:
 - add perf_hpp_fmt_cmp_t typedef to util/hist.h
 - use the typedef for perf_hpp_fmt::{cmp,collapse,sort}

Changes in v3:
 - make fn a pointer in hist_entry__cmp_impl()
---
 tools/perf/util/hist.c | 103 +++++++++++++++++------------------------
 tools/perf/util/hist.h |  14 +++---
 2 files changed, 49 insertions(+), 68 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index fff1345658016..493b3cc30eac0 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -32,6 +32,9 @@
 #include <linux/time64.h>
 #include <linux/zalloc.h>
 
+static int64_t hist_entry__cmp(struct hist_entry *left, struct hist_entry *right);
+static int64_t hist_entry__collapse(struct hist_entry *left, struct hist_entry *right);
+
 static bool hists__filter_entry_by_dso(struct hists *hists,
 				       struct hist_entry *he);
 static bool hists__filter_entry_by_thread(struct hists *hists,
@@ -1292,19 +1295,26 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
 	return err;
 }
 
-int64_t
-hist_entry__cmp(struct hist_entry *left, struct hist_entry *right)
+static int64_t
+hist_entry__cmp_impl(struct perf_hpp_list *hpp_list, struct hist_entry *left,
+		     struct hist_entry *right, unsigned long fn_offset,
+		     bool ignore_dynamic, bool ignore_skipped)
 {
 	struct hists *hists = left->hists;
 	struct perf_hpp_fmt *fmt;
+	perf_hpp_fmt_cmp_t *fn;
 	int64_t cmp = 0;
 
-	hists__for_each_sort_list(hists, fmt) {
-		if (perf_hpp__is_dynamic_entry(fmt) &&
+	perf_hpp_list__for_each_sort_list(hpp_list, fmt) {
+		if (ignore_dynamic && perf_hpp__is_dynamic_entry(fmt) &&
 		    !perf_hpp__defined_dynamic_entry(fmt, hists))
 			continue;
 
-		cmp = fmt->cmp(fmt, left, right);
+		if (ignore_skipped && perf_hpp__should_skip(fmt, hists))
+			continue;
+
+		fn = (void *)fmt + fn_offset;
+		cmp = (*fn)(fmt, left, right);
 		if (cmp)
 			break;
 	}
@@ -1313,23 +1323,33 @@ hist_entry__cmp(struct hist_entry *left, struct hist_entry *right)
 }
 
 int64_t
-hist_entry__collapse(struct hist_entry *left, struct hist_entry *right)
+hist_entry__cmp(struct hist_entry *left, struct hist_entry *right)
 {
-	struct hists *hists = left->hists;
-	struct perf_hpp_fmt *fmt;
-	int64_t cmp = 0;
+	return hist_entry__cmp_impl(left->hists->hpp_list, left, right,
+		offsetof(struct perf_hpp_fmt, cmp), true, false);
+}
 
-	hists__for_each_sort_list(hists, fmt) {
-		if (perf_hpp__is_dynamic_entry(fmt) &&
-		    !perf_hpp__defined_dynamic_entry(fmt, hists))
-			continue;
+static int64_t
+hist_entry__sort(struct hist_entry *left, struct hist_entry *right)
+{
+	return hist_entry__cmp_impl(left->hists->hpp_list, left, right,
+		offsetof(struct perf_hpp_fmt, sort), false, true);
+}
 
-		cmp = fmt->collapse(fmt, left, right);
-		if (cmp)
-			break;
-	}
+int64_t
+hist_entry__collapse(struct hist_entry *left, struct hist_entry *right)
+{
+	return hist_entry__cmp_impl(left->hists->hpp_list, left, right,
+		offsetof(struct perf_hpp_fmt, collapse), true, false);
+}
 
-	return cmp;
+static int64_t
+hist_entry__collapse_hierarchy(struct perf_hpp_list *hpp_list,
+			       struct hist_entry *left,
+			       struct hist_entry *right)
+{
+	return hist_entry__cmp_impl(hpp_list, left, right,
+		offsetof(struct perf_hpp_fmt, collapse), false, false);
 }
 
 void hist_entry__delete(struct hist_entry *he)
@@ -1503,14 +1523,7 @@ static struct hist_entry *hierarchy_insert_entry(struct hists *hists,
 	while (*p != NULL) {
 		parent = *p;
 		iter = rb_entry(parent, struct hist_entry, rb_node_in);
-
-		cmp = 0;
-		perf_hpp_list__for_each_sort_list(hpp_list, fmt) {
-			cmp = fmt->collapse(fmt, iter, he);
-			if (cmp)
-				break;
-		}
-
+		cmp = hist_entry__collapse_hierarchy(hpp_list, iter, he);
 		if (!cmp) {
 			he_stat__add_stat(&iter->stat, &he->stat);
 			return iter;
@@ -1730,24 +1743,6 @@ int hists__collapse_resort(struct hists *hists, struct ui_progress *prog)
 	return 0;
 }
 
-static int64_t hist_entry__sort(struct hist_entry *a, struct hist_entry *b)
-{
-	struct hists *hists = a->hists;
-	struct perf_hpp_fmt *fmt;
-	int64_t cmp = 0;
-
-	hists__for_each_sort_list(hists, fmt) {
-		if (perf_hpp__should_skip(fmt, a->hists))
-			continue;
-
-		cmp = fmt->sort(fmt, a, b);
-		if (cmp)
-			break;
-	}
-
-	return cmp;
-}
-
 static void hists__reset_filter_stats(struct hists *hists)
 {
 	hists->nr_non_filtered_entries = 0;
@@ -2449,21 +2444,15 @@ static struct hist_entry *add_dummy_hierarchy_entry(struct hists *hists,
 	struct rb_node **p;
 	struct rb_node *parent = NULL;
 	struct hist_entry *he;
-	struct perf_hpp_fmt *fmt;
 	bool leftmost = true;
 
 	p = &root->rb_root.rb_node;
 	while (*p != NULL) {
-		int64_t cmp = 0;
+		int64_t cmp;
 
 		parent = *p;
 		he = rb_entry(parent, struct hist_entry, rb_node_in);
-
-		perf_hpp_list__for_each_sort_list(he->hpp_list, fmt) {
-			cmp = fmt->collapse(fmt, he, pair);
-			if (cmp)
-				break;
-		}
+		cmp = hist_entry__collapse_hierarchy(he->hpp_list, he, pair);
 		if (!cmp)
 			goto out;
 
@@ -2521,16 +2510,10 @@ static struct hist_entry *hists__find_hierarchy_entry(struct rb_root_cached *roo
 
 	while (n) {
 		struct hist_entry *iter;
-		struct perf_hpp_fmt *fmt;
-		int64_t cmp = 0;
+		int64_t cmp;
 
 		iter = rb_entry(n, struct hist_entry, rb_node_in);
-		perf_hpp_list__for_each_sort_list(he->hpp_list, fmt) {
-			cmp = fmt->collapse(fmt, iter, he);
-			if (cmp)
-				break;
-		}
-
+		cmp = hist_entry__collapse_hierarchy(he->hpp_list, iter, he);
 		if (cmp < 0)
 			n = n->rb_left;
 		else if (cmp > 0)
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 1131056924d9c..46c8373e31465 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -342,8 +342,6 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
 struct perf_hpp;
 struct perf_hpp_fmt;
 
-int64_t hist_entry__cmp(struct hist_entry *left, struct hist_entry *right);
-int64_t hist_entry__collapse(struct hist_entry *left, struct hist_entry *right);
 int hist_entry__transaction_len(void);
 int hist_entry__sort_snprintf(struct hist_entry *he, char *bf, size_t size,
 			      struct hists *hists);
@@ -452,6 +450,9 @@ struct perf_hpp {
 	bool skip;
 };
 
+typedef int64_t (*perf_hpp_fmt_cmp_t)(
+	struct perf_hpp_fmt *, struct hist_entry *, struct hist_entry *);
+
 struct perf_hpp_fmt {
 	const char *name;
 	int (*header)(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
@@ -463,12 +464,9 @@ struct perf_hpp_fmt {
 		     struct hist_entry *he);
 	int (*entry)(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 		     struct hist_entry *he);
-	int64_t (*cmp)(struct perf_hpp_fmt *fmt,
-		       struct hist_entry *a, struct hist_entry *b);
-	int64_t (*collapse)(struct perf_hpp_fmt *fmt,
-			    struct hist_entry *a, struct hist_entry *b);
-	int64_t (*sort)(struct perf_hpp_fmt *fmt,
-			struct hist_entry *a, struct hist_entry *b);
+	perf_hpp_fmt_cmp_t cmp;
+	perf_hpp_fmt_cmp_t collapse;
+	perf_hpp_fmt_cmp_t sort;
 	bool (*equal)(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b);
 	void (*free)(struct perf_hpp_fmt *fmt);
 
-- 
2.48.0.rc2.279.g1de40edade-goog

