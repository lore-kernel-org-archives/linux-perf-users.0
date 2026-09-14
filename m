Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB52F3793B3;
	Mon, 14 Sep 2026 06:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789368340; cv=none; b=FnEW4W2uz9uzntmaLYgkwz0dO7Fa/U/0/kpjQ4JtLLhkOUZ57X1NgdqrRSXdA67visnn74adI4Odwq7SNYTYWnQ0jVUACFtUa4hdcDMBHTdKAm/Spfpoaf+GTn1FGdyeU1cUzfpp4e8rWJ/MBsUpyw9MV4VuMMjO4Jgj3x9N3gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789368340; c=relaxed/simple;
	bh=Mttz1aZ/SxLb5zaGr/Ll+RW1mzydNrOt5oRqQc66Zq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=me8z1DNMBC057bB/YukYb+RjJFGnFJXhyZ+b8OGp/LwGS3Q7HJpGBYoS7WW4aPKlR/fhxF0AS1xSLKiS6WoaUn7wZhtj6kHQx0leK3p/pTQjLP1HdqYc4H+Tw3a6eDj0FT226Z9HHqOvbvWRO5W3SCAJpi0AQ91/wW0j1/v7UlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoC/KYvm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoC/KYvm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478341F00893;
	Mon, 14 Sep 2026 06:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789368338;
	bh=VXQG48QPP2TU0Wh8rrcVmUbq1RqmviBSiisLHe3B1oA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QoC/KYvmimHw+ayEqJ2DLN442U7uazFLe3ypDgqdVCSUYkzMOFjALJInpcAxkJ4R5
	 1rlRgSPU0Zub8pIMRRhO9UnzJMDvrHo3egW8dd1ml/25iFB3o0S+x4qfEYK06HkRht
	 E6QOo0W8lF5ZFAompj7w0il56MbOdBoJHOKjCeNOrTldb+MxigB/JiRE/I7owPOEmu
	 LmBzNOu7Dtye+t82oW48+Fk9hUfdTxtAtTVMF+79Q+ptUfFYtPPjSuctJK2MA9dLVs
	 kcfkU29yGAhkNkcblV0Ct73oThcQworiu65z3DtTSTzrXNIDr9c4fHeEtoKOwQ4594
	 639GTk4P8hgDw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Zecheng Li <zli94@ncsu.edu>,
	Yanbo Zhao <yzhao62@ncsu.edu>,
	Tengda Wu <wutengda@huaweicloud.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>
Subject: [PATCH v2 1/4] perf annotate-data: Convert type histogram to hashmap
Date: Sun, 13 Sep 2026 23:45:32 -0700
Message-ID: <20260914064535.1671939-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
In-Reply-To: <20260914064535.1671939-1-namhyung@kernel.org>
References: <20260914064535.1671939-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The type histogram maintains sample counts and periods per offset.  Use
a hashmap instead of an array to reduce the memory overhead.

No functional changes intended.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/annotate-data.c | 10 ++--
 tools/perf/util/annotate-data.c        | 72 ++++++++++++++++----------
 tools/perf/util/annotate-data.h        |  8 +--
 3 files changed, 57 insertions(+), 33 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate-data.c b/tools/perf/ui/browsers/annotate-data.c
index aa8c89fe2e82c1c5..c6e07a9b64089ab5 100644
--- a/tools/perf/ui/browsers/annotate-data.c
+++ b/tools/perf/ui/browsers/annotate-data.c
@@ -62,12 +62,16 @@ static int get_member_overhead(struct annotated_data_type *adt,
 
 		k = 0;
 		for_each_group_evsel(evsel, leader) {
+			struct type_hist_entry *hist;
+
 			if (symbol_conf.skip_empty &&
 			    evsel__hists(evsel)->stats.nr_samples == 0)
 				continue;
 
-			h = adt->histograms[evsel->core.idx];
-			update_hist_entry(&entry->hists[k++], &h->addr[offset]);
+			h = &adt->histograms[evsel->core.idx];
+			if (hashmap__find(&h->samples, offset, &hist))
+				update_hist_entry(&entry->hists[k], hist);
+			k++;
 		}
 	}
 	return 0;
@@ -416,7 +420,7 @@ static void browser__write(struct ui_browser *uib, void *entry, int row)
 
 	/* print the number */
 	for_each_group_evsel(evsel, leader) {
-		struct type_hist *h = adt->histograms[evsel->core.idx];
+		struct type_hist *h = &adt->histograms[evsel->core.idx];
 
 		if (symbol_conf.skip_empty &&
 		    evsel__hists(evsel)->stats.nr_samples == 0)
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 4e4c587640823c81..aff60a630fd05b01 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1750,42 +1750,45 @@ struct annotated_data_type *find_data_type(struct data_loc_info *dloc)
 	return dso__findnew_data_type(dso, &type_die);
 }
 
+static size_t data_type_hash(long key, void *ctx __maybe_unused)
+{
+	return key;
+}
+
+static bool data_type_equal(long key1, long key2, void *ctx __maybe_unused)
+{
+	return key1 == key2;
+}
+
 static int alloc_data_type_histograms(struct annotated_data_type *adt, int nr_entries)
 {
 	int i;
-	size_t sz = sizeof(struct type_hist);
 
-	sz += sizeof(struct type_hist_entry) * adt->self.size;
-
-	/* Allocate a table of pointers for each event */
+	/* Allocate a histogram for each event */
 	adt->histograms = calloc(nr_entries, sizeof(*adt->histograms));
 	if (adt->histograms == NULL)
 		return -ENOMEM;
 
-	/*
-	 * Each histogram is allocated for the whole size of the type.
-	 * TODO: Probably we can move the histogram to members.
-	 */
 	for (i = 0; i < nr_entries; i++) {
-		adt->histograms[i] = zalloc(sz);
-		if (adt->histograms[i] == NULL)
-			goto err;
+		hashmap__init(&adt->histograms[i].samples, data_type_hash,
+			      data_type_equal, /*ctx=*/NULL);
 	}
 
 	adt->nr_histograms = nr_entries;
 	return 0;
-
-err:
-	while (--i >= 0)
-		zfree(&(adt->histograms[i]));
-	zfree(&adt->histograms);
-	return -ENOMEM;
 }
 
 static void delete_data_type_histograms(struct annotated_data_type *adt)
 {
-	for (int i = 0; i < adt->nr_histograms; i++)
-		zfree(&(adt->histograms[i]));
+	for (int i = 0; i < adt->nr_histograms; i++) {
+		struct hashmap *map = &adt->histograms[i].samples;
+		struct hashmap_entry *pos, *tmp;
+		size_t bkt;
+
+		hashmap__for_each_entry_safe(map, pos, tmp, bkt)
+			free(pos->pvalue);
+		hashmap__clear(map);
+	}
 
 	zfree(&adt->histograms);
 	adt->nr_histograms = 0;
@@ -1824,6 +1827,7 @@ int annotated_data_type__update_samples(struct annotated_data_type *adt,
 					int nr_samples, u64 period)
 {
 	struct type_hist *h;
+	struct type_hist_entry *entry;
 
 	if (adt == NULL)
 		return 0;
@@ -1838,12 +1842,23 @@ int annotated_data_type__update_samples(struct annotated_data_type *adt,
 	if (offset < 0 || offset >= adt->self.size)
 		return -1;
 
-	h = adt->histograms[evsel->core.idx];
+	h = &adt->histograms[evsel->core.idx];
 
 	h->nr_samples += nr_samples;
-	h->addr[offset].nr_samples += nr_samples;
 	h->period += period;
-	h->addr[offset].period += period;
+
+	if (!hashmap__find(&h->samples, offset, &entry)) {
+		entry = zalloc(sizeof(*entry));
+		if (entry == NULL)
+			return -1;
+
+		if (hashmap__append(&h->samples, offset, entry) < 0) {
+			free(entry);
+			return -1;
+		}
+	}
+	entry->nr_samples += nr_samples;
+	entry->period += period;
 	return 0;
 }
 
@@ -1911,14 +1926,14 @@ static void print_annotated_data_type(struct annotated_data_type *mem_type,
 				      struct evsel *evsel, int indent)
 {
 	struct annotated_member *child;
-	struct type_hist *h = mem_type->histograms[evsel->core.idx];
+	struct type_hist *h;
 	int i, nr_events = 0, samples = 0;
 	u64 period = 0;
 	int width = symbol_conf.show_total_period ? 11 : 7;
 	struct evsel *pos;
 
 	for_each_group_evsel(pos, evsel) {
-		h = mem_type->histograms[pos->core.idx];
+		h = &mem_type->histograms[pos->core.idx];
 
 		if (symbol_conf.skip_empty &&
 		    evsel__hists(pos)->stats.nr_samples == 0)
@@ -1927,8 +1942,13 @@ static void print_annotated_data_type(struct annotated_data_type *mem_type,
 		samples = 0;
 		period = 0;
 		for (i = 0; i < member->size; i++) {
-			samples += h->addr[member->offset + i].nr_samples;
-			period += h->addr[member->offset + i].period;
+			struct type_hist_entry *entry;
+
+			if (!hashmap__find(&h->samples, member->offset + i, &entry))
+				continue;
+
+			samples += entry->nr_samples;
+			period += entry->period;
 		}
 		print_annotated_data_value(h, period, samples);
 		nr_events++;
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index c26130744260955f..ca2096a9ee62cbfe 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -73,12 +73,12 @@ struct type_hist_entry {
  * struct type_hist - Type histogram for each event
  * @nr_samples: Total number of samples in this data type
  * @period: Total count of the event in this data type
- * @offset: Array of histogram entry
+ * @samples: Hashmap of (offset, type_hist_entry)
  */
 struct type_hist {
 	u64			nr_samples;
 	u64			period;
-	struct type_hist_entry	addr[];
+	struct hashmap		samples;
 };
 
 /**
@@ -86,7 +86,7 @@ struct type_hist {
  * @node: RB-tree node for dso->type_tree
  * @self: Actual type information
  * @nr_histogram: Number of histogram entries
- * @histograms: An array of pointers to histograms
+ * @histograms: An array of histograms
  *
  * This represents a data type accessed by samples in the profile data.
  */
@@ -94,7 +94,7 @@ struct annotated_data_type {
 	struct rb_node node;
 	struct annotated_member self;
 	int nr_histograms;
-	struct type_hist **histograms;
+	struct type_hist *histograms;
 };
 
 extern struct annotated_data_type unknown_type;
-- 
2.55.0.1032.g73a4cd73de-goog

