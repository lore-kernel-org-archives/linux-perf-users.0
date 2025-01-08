Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462381A840E
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jan 2025 07:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736321844; cv=none; b=Dm+tWDAHDm64R7We9syNMBZQkBtWFaawfkVyg8zUqZ7sDo5JecwTUsOPPxW/l9XyCpblbLzFcHNlDXFG/8Yt2/I/s8O0Vw4iGOcOmKL9Mphy9OL1P6ZmPmyB1y72P81OO8PZohcEvi3RNmHHFRd61j0l9UI69bUvIPPvVtbdtc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736321844; c=relaxed/simple;
	bh=sToZfWRaUW8Im8Bnkr2+2ii+m0XA6wWa9xs0c2mJes4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N2PsjsPVG7IBKiYXOCfDLQTKYeA3qABrFuRlvpyZev2gXM7HIMu+YyKSsjlFbXBZ3jvGMMwJZB2W2eEILOAR9W/Qpz/vjaHevdqKwSsixU8P3hGQsBqkBTVC9PSs3BUGbBx//nqVr/0Qa9mQ2JOTWrYCA/S5eOScrUwKVmzghs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2zYf+wAz; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2zYf+wAz"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-aa6b904a886so1012735466b.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jan 2025 23:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736321841; x=1736926641; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KLyisN5UV5HFPMTGXG+9mPr/NL9P15aK3nqRMup9oBA=;
        b=2zYf+wAziiv/3pWLrPtscLNZlmfSwCyKIAeoyEFalqaQbzR9vZfA1DQPpDiHtz/19E
         +R6fD5D/nvLu5n6/6ecPX0ln07n/VW/5GuctHllIVvZMiu2TscSFAs0lvbxIAkxCy44Z
         nHJK+KT4aw6dVNEy/LF3YnTRlHxIJH1JvWlUltNoXTzOK9LtQbhGPzwTCWOZ6Qei6kmp
         1YPJtwKc/fObDaJW5qgDeA7W0b45wNkLjQCSUMNCofzf8mFhugDScI/mjrW5+ds0oXzw
         8yauNLo0PSdtygUjJu7XagZmqJSrrB++0BqJjvh+XMzBGVQLf6xQsDojCF1CwrAjH6HT
         k8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736321841; x=1736926641;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KLyisN5UV5HFPMTGXG+9mPr/NL9P15aK3nqRMup9oBA=;
        b=QL5imhlVCGXjGjqQIl/xOMkGFjS19gp7pL33L8Evqppf2xaWkkhyYY2Fn+97byWkWn
         GOmq5r7XmbJfn3B4Lr34CZ30+R8DRIzv4bAGRbqodfspLxvwyPMSp+wzoKcfCWws571L
         wryD1kkJus5xB/NapMD2CIp3Y4skqNRc//OtlNOjzKcw39kfNBCkrnek2L989zhlqRzf
         ChZsx2MlnYOKdlN+k/l3j4+6QBsmtSEe2uKCLfms6zacbxkWPwm7BBPOdm6/+BVBbut3
         WUuZrLjtTF/oGXzCCNaBNshzDBN5PZfIyOafWxB/l8JhR4xTml0plI+XWwxEMisfOhZ+
         53Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVX3/5rTX4bx9V18OUUF/AfvgPJOiNlAFPK7/cAhPJ7T3B5Ki8PDDJjmlfmouWqLqjhtgaZsYfIDALSAjiR8AW8@vger.kernel.org
X-Gm-Message-State: AOJu0YyvmJCEBS0EsA/2jqbPfAJaXkRakyyQjMHZloLcdDShJSRK/f9X
	WFgNuRJo41XC+YPrZvd/yXjLvbipdD8Zl/UzEjo+Isk+amOdiaYnp9klBbk4LaJJqEPJuC7v3e2
	c02gQYQ==
X-Google-Smtp-Source: AGHT+IHqEzJsfJtLrre8q2n8Go1hiTNsXp5KHvUyg9FAcFp3rwhS0zxAEY7W8NmSQ+zphIkr26kjVGM2vXU9
X-Received: from edah41.prod.google.com ([2002:a05:6402:ea9:b0:5d3:ecb9:7312])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:6e9f:b0:aa5:1a1c:d0a2
 with SMTP id a640c23a62f3a-ab2ab74b240mr137121366b.34.1736321840800; Tue, 07
 Jan 2025 23:37:20 -0800 (PST)
Date: Wed,  8 Jan 2025 08:36:53 +0100
In-Reply-To: <cover.1736321686.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1736321686.git.dvyukov@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <4bf65a9a789a0bb78e4a3e120ad30389725d2249.1736321686.git.dvyukov@google.com>
Subject: [PATCH 1/2] perf hist: Deduplicate cmp/sort/collapse code
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com
Cc: Dmitry Vyukov <dvyukov@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Application of cmp/sort/collapse fmt callbacks is duplicated 6 times.
Factor it into a common helper function. NFC.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/perf/util/hist.c | 104 +++++++++++++++++------------------------
 tools/perf/util/hist.h |   2 -
 2 files changed, 44 insertions(+), 62 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index fff1345658016..8e4e844425370 100644
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
@@ -1292,19 +1295,27 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
 	return err;
 }
 
-int64_t
-hist_entry__cmp(struct hist_entry *left, struct hist_entry *right)
+static int64_t
+hist_entry__cmp_impl(struct perf_hpp_list *hpp_list, struct hist_entry *left,
+		     struct hist_entry *right, unsigned long fn_offset,
+		     bool ignore_dynamic, bool ignore_skipped)
 {
+	typedef int64_t (*fn_t)(struct perf_hpp_fmt *, struct hist_entry *, struct hist_entry *);
 	struct hists *hists = left->hists;
 	struct perf_hpp_fmt *fmt;
 	int64_t cmp = 0;
+	fn_t fn;
 
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
+		fn = *(fn_t *)(((char *)fmt) + fn_offset);
+		cmp = fn(fmt, left, right);
 		if (cmp)
 			break;
 	}
@@ -1313,23 +1324,33 @@ hist_entry__cmp(struct hist_entry *left, struct hist_entry *right)
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
@@ -1503,14 +1524,7 @@ static struct hist_entry *hierarchy_insert_entry(struct hists *hists,
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
@@ -1730,24 +1744,6 @@ int hists__collapse_resort(struct hists *hists, struct ui_progress *prog)
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
@@ -2449,21 +2445,15 @@ static struct hist_entry *add_dummy_hierarchy_entry(struct hists *hists,
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
 
@@ -2521,16 +2511,10 @@ static struct hist_entry *hists__find_hierarchy_entry(struct rb_root_cached *roo
 
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
index 1131056924d9c..6cff03eb043b7 100644
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
-- 
2.47.1.613.gc27f4b7a9f-goog

