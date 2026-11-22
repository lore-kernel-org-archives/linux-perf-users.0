Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795383658;
	b=HvR8D6pVWTThEwAZMRZjcXhv9O+RBJ7J46jejXH/OfrKeOVPbfQ/uPwusqXkPuJRXpz3
	 lQCD7cyHHXpwW1uk21D/iDJXIRHcMme8RgfHok/HMZiGzSA2iSpp0+KXVe+AlNKry214G
	 zXGjZ/p8v2H8p65nc4XIoopuqCV3vVtvS8RGNROeeVsIzcaK8n6kBqF6lqRPSMTOOCISL
	 yQvKEQtKSC7VdqdzhQsdE2IeggLah1Upnqsl9CeEJoi98wfkmQzy3IRBggMJelAXeSDyY
	 jui36X9/YL/b9IJ6K/avx7GHsBLUiPF8SSuSKl15ODHzRH2X+mdcAjNsPGb1ziBNuhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795383658;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4fAdOMUgRAB0ZB+5HKmnhmlOselZ13l7uCltf1t4T78=;
	b=2FZTQvjollw029MgTDc1xuhFgBMHheCmMi93TfPQ/xav0WSqtSPa2BiSKgjzZ6GOFbKw
	 rNJ1naRw7kiUpfa16XsMEI7ftKTUva8OYg5fJWJBAR0bM8EgG3YpanUQu+cQC5iRGIzEQ
	 Ky/1xLGLLJZbjthsGzKEB8nqT/sgplQlt8cJHV5kpUjfWQTqeoL60lERju5MiZNMx89mg
	 KxiO2ly/Qdc2idq1/S5bzXIu7MInGHm1OiSkbssLBhHIBMvfZfFccBO9SCt84ecBDqh5T
	 a3WycxgML270fAfuqkqfdjNqAPCn08R/dRoTX6Waj7qyNAQTllOOewq+N10faioZ+sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JmL5v2LP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F98606A31A;
	Sun, 22 Nov 2026 21:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JmL5v2LP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78B71F000C0;
	Sun, 22 Nov 2026 21:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795383657;
	bh=4fAdOMUgRAB0ZB+5HKmnhmlOselZ13l7uCltf1t4T78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JmL5v2LPlSOl3r+/hEs7Dw9Uwukm9WAqHL1O07nJb4560wwHMz59Ify8c+NEZGSrR
	 7FMkBBUwn10TsL1AAiYxjvmTGFrYSwX5nW3nOJ7cjTqhiX5YmELCT1ekMN7rCRVGbP
	 nCsweMOlBWu+DcOuvtnEDh3g1O/0A/EAXV/u3/TCdOkEM1Rr7Z1VERnABCwtp3b9wt
	 Gg2kw7z3Zs6VaomhH88mYlAlc4Lu+2T4ZLhYj6M8Cff0Npfd52rp1OSXjq0dzSihuA
	 omIKcLdoUAZwrJlRA9HWQsHQmYKxcJeu5QR7HLjctnzIQ32di92UAheNoQKR7OGuw/
	 NJW2FLn4LHaUw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v11 07/19] perf annotate-data: Count flexible array accesses for the whole struct
Date: Sun, 22 Nov 2026 18:40:13 -0300
Message-ID: <20261122214025.16769-8-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261122214025.16769-1-acme@kernel.org>
References: <20261122214025.16769-1-acme@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The per-member percentage sums the histogram entries in the member's
own [offset, offset + size) range.  A flexible array member is resolved
at or past the end of its struct, so the struct row only covered its
declared size and showed 0.00% while the member row showed 100.00% and
the header said N samples.

Take a member's extent as the end of its furthest child as well, so the
struct counts what was resolved past it.  Union members all start at
offset 0, so a plain union keeps its size; a member that is itself a
struct with a flexible array extends the union too.  The TUI browser
accounts the members the same way, use the extent there as well.

Fixes: aaca646915a1bb53 ("perf annotate-data: Adjust type offset for flex-array")
Reviewed-by: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate-data.c |  7 +++----
 tools/perf/util/annotate-data.c        | 27 +++++++++++++++++++++++---
 tools/perf/util/annotate-data.h        |  8 ++++++++
 3 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate-data.c b/tools/perf/ui/browsers/annotate-data.c
index 0f778788df4a934b..e4047e97e8a943a4 100644
--- a/tools/perf/ui/browsers/annotate-data.c
+++ b/tools/perf/ui/browsers/annotate-data.c
@@ -53,12 +53,11 @@ static int get_member_overhead(struct annotated_data_type *adt,
 			       struct evsel *leader)
 {
 	struct annotated_member *member = entry->data;
-	int i, k;
+	int i, k, end = annotated_member__extent(member);
 
-	for (i = 0; i < member->size; i++) {
+	for (i = member->offset; i < end; i++) {
 		struct type_hist *h;
 		struct evsel *evsel;
-		int offset = member->offset + i;
 
 		k = 0;
 		for_each_group_evsel(evsel, leader) {
@@ -69,7 +68,7 @@ static int get_member_overhead(struct annotated_data_type *adt,
 				continue;
 
 			h = &adt->histograms[evsel->core.idx];
-			if (hashmap__find(&h->samples, offset, &hist))
+			if (hashmap__find(&h->samples, i, &hist))
 				update_hist_entry(&entry->hists[k], hist);
 			k++;
 		}
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 2332d465f9751ef3..c22fec349c47c495 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -2011,7 +2011,7 @@ struct annotated_data_type *find_data_type(struct data_loc_info *dloc)
 	if (result == NULL)
 		return NULL;
 
-	if (result->flex_array && dloc->type_offset > result->self.size) {
+	if (result->flex_array && dloc->type_offset >= result->self.size) {
 		struct annotated_member *flex_array = get_flex_array_member(result);
 
 		if (flex_array && flex_array->size > 0) {
@@ -2208,6 +2208,26 @@ static void print_annotated_data_value(struct type_hist *h, u64 period, int nr_s
 		color_fprintf(stdout, color, " %7.2f", percent);
 }
 
+/*
+ * A flexible array member is resolved past the end of its parent, so the
+ * parent's samples are not bounded by its size.  A GNU extension non-last
+ * member with a flexible array can overlap the next member and double-count.
+ */
+int annotated_member__extent(struct annotated_member *member)
+{
+	struct annotated_member *child;
+	int end = member->offset + member->size;
+
+	list_for_each_entry(child, &member->children, node) {
+		int child_end = annotated_member__extent(child);
+
+		if (child_end > end)
+			end = child_end;
+	}
+
+	return end;
+}
+
 static void print_annotated_data_type(struct annotated_data_type *mem_type,
 				      struct annotated_member *member,
 				      struct evsel *evsel, int indent)
@@ -2215,6 +2235,7 @@ static void print_annotated_data_type(struct annotated_data_type *mem_type,
 	struct annotated_member *child;
 	struct type_hist *h;
 	int i, nr_events = 0, samples = 0;
+	int end = annotated_member__extent(member);
 	u64 period = 0;
 	int width = symbol_conf.show_total_period ? 11 : 7;
 	struct evsel *pos;
@@ -2228,10 +2249,10 @@ static void print_annotated_data_type(struct annotated_data_type *mem_type,
 
 		samples = 0;
 		period = 0;
-		for (i = 0; i < member->size; i++) {
+		for (i = member->offset; i < end; i++) {
 			struct type_hist_entry *entry;
 
-			if (!hashmap__find(&h->samples, member->offset + i, &entry))
+			if (!hashmap__find(&h->samples, i, &entry))
 				continue;
 
 			samples += entry->nr_samples;
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 184262c7356213fa..6e0d410929651426 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -260,6 +260,9 @@ void global_var_type__tree_delete(struct rb_root *root);
 /* Print data type annotation (including members) on stdout */
 int hist_entry__annotate_data_tty(struct hist_entry *he, struct evsel *evsel);
 
+/* End offset of a member, including a flexible array's children */
+int annotated_member__extent(struct annotated_member *member);
+
 /* Get name of member field at the given offset in the data type */
 int annotated_data_type__get_member_name(struct annotated_data_type *adt,
 					 char *buf, size_t sz, int member_offset);
@@ -316,6 +319,11 @@ static inline int hist_entry__annotate_data_tty(struct hist_entry *he __maybe_un
 	return -1;
 }
 
+static inline int annotated_member__extent(struct annotated_member *member)
+{
+	return member->offset + member->size;
+}
+
 static inline int annotated_data_type__get_member_name(struct annotated_data_type *adt __maybe_unused,
 						       char *buf __maybe_unused,
 						       size_t sz __maybe_unused,
-- 
2.56.1

