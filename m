Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102B122C33C
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736775273; cv=none; b=FIol+dpicuuHczGTVicoivRbI6Ap+/cmPEmkVr0eCtZyAvHSo+k9R013bih9VPRWiY+hGDFjBfWwNYfDD66IINkGPIjmguvAsHUH5IuDHQfdF5or/SeMDRi9cMopaGPIWEgtIVYmyVFx/kdDyQ26pXDd3wX6UmK+a2t5bS4Odm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736775273; c=relaxed/simple;
	bh=qzgX8BAu8RTwwdUr75LldHPnrle7OP5QmvHOV2ovMOo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cBipcdG00Gt4X1huDSsUhGlNxr0PYNqUZZ+lN45v5lieUwHk3uzVY/pRlZ6BLum9xFwo6RJkUoycw419Omm/vwlo0EQ1d//AbWLafVvzgWucvx7Y7ods/WXFG9zbAh2jVFWM5mwYOPEDMJz4xia22ckPvhnwWcr0Vr6oZ68bZqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I023IiJ9; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I023IiJ9"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5d3e4e09ae7so6000743a12.3
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 05:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736775270; x=1737380070; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CQP8NTplT9yPzWKM/0e6vyrHCYCJiSLYF566hxjrbng=;
        b=I023IiJ9t/aQ7kbpHB3RW2aKEjl1TIJY2+qXVP/EOJCUTyz778ZtP+Q4UNK1hoV+Z3
         rJLtnRwQqHa4oWVsBvB7tU2twAVNwtMNF/pPPWOr6ik58I1wZhBu6M6ro8x7xk0ut7zz
         Fqh0iqsS34/LufaKxm+oZSZu5CSTAy5HFsG+sXSYtfnHRaTQEAz27hmigP2rTEmimq3q
         F/glRDATDzjs3dMYS1zN/im5xPcWca5piMFnhrmkwZsUFEbT8hNltAIvdLAH7znipvJ+
         18cE9YFYpPr0PmQ+YzdbaX6nL/peJMz+IYFuMIQQz5Fm3Ty2fncpeHcFmm9ZkCGr2U/g
         Kx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736775270; x=1737380070;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CQP8NTplT9yPzWKM/0e6vyrHCYCJiSLYF566hxjrbng=;
        b=uilWdN9JV94d1+cAu6wwpDgLFQPRck+iV3t0+tQY38KwPJtdtB+HxneKWzVG++W1lY
         Ky0BBSqSbNyxX3/X/gm6njkkRW6JCUBMq6JCDzMqEylGFuP7Wxjoec36Lk/MLgjKwCRq
         KZBT910EZuJP4dwq5EwyQx8N4uOxIXw8Ld4xYKRvcUJB/1SA0tincKWsATgiytlRffOI
         HxGoJXcbF9jMeVTV5CL8YPi4peon+sbAu1hNSsV1XarF3IsXVLDHhT8Bh6Cx2nztUnFN
         kgoajGFVEQJs68Efj/sLZlMDOMH+sRPupXQQGgnItIkMJic8/fDe5OCp/ELIK6M9Byb6
         4nRg==
X-Gm-Message-State: AOJu0Yx6XirZt2uOmm/2p30h1iXa16ZODSZ+hgwQxNGUqu68/7hGSZBb
	bEMuxlgUgFZlNHrJonvhjlCc6JPykDqVSq7B4YAoqFmdsFmFBOB2KIeiW2bySzfu/ZwX/CxOxv+
	0t3z7TQ==
X-Google-Smtp-Source: AGHT+IEAMqywM46SOBqhD/3twmIIR8tMI24EtNOar0e5VTXqT2Cj11YuIIoRapD+cDU/gSUy8FZt3tBIwKUL
X-Received: from edxb6.prod.google.com ([2002:a05:6402:2c6:b0:5d1:58a5:ef14])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:42d2:b0:5cf:f42f:de82
 with SMTP id 4fb4d7f45d1cf-5d972df67e1mr19561235a12.7.1736775270676; Mon, 13
 Jan 2025 05:34:30 -0800 (PST)
Date: Mon, 13 Jan 2025 14:34:14 +0100
In-Reply-To: <cover.1736775109.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1736775109.git.dvyukov@google.com>
X-Mailer: git-send-email 2.47.1.688.g23fc6f90ad-goog
Message-ID: <52f5a4dcc10ecb00fdf78750d1b32dabcbaf2a31.1736775109.git.dvyukov@google.com>
Subject: [PATCH v2 1/2] perf hist: Deduplicate cmp/sort/collapse code
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
---
 tools/perf/util/hist.c | 103 +++++++++++++++++------------------------
 tools/perf/util/hist.h |  14 +++---
 2 files changed, 49 insertions(+), 68 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index fff1345658016..a4b8ec3805565 100644
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
 	int64_t cmp = 0;
+	perf_hpp_fmt_cmp_t fn;
 
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
+		fn = *(perf_hpp_fmt_cmp_t *)(((char *)fmt) + fn_offset);
+		cmp = fn(fmt, left, right);
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
2.47.1.688.g23fc6f90ad-goog

