Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795231281;
	b=ztz8EQAmyZVr77cENsJ6UOjjszh8drioGg/OF2LgCBLCyLe+nPdH/HMKu4HwcvqF31Ab
	 vGlbVgvnHsbCNp23efI4MCooIwpD31K4riMrK6nNjrxBVZaWA1qkV6s10+6Zn4qcmcC6J
	 J1eHaldjZ6zkzZuZ6jrrotvMPsuXamf0rvmb07DzwRbTH3WldYn422hGV1h0ak/a+5Wvh
	 jNsrNJ2aHkvRrURJNiGgltjTf3suqXXqbzifR7HWxY8ws75Y3M8EZCKxw/CKAG9QfKBVg
	 u88GZthH6OPqqQRxxbTQ0K7GJY5B8MRd2fg6Tmv4tfqXjvPremAsqP5QwvXbXMh0HlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795231281;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=M7OJHFSjd8T4K7iSmGwlRH3p7LR2cBaH3oOxz9lF1k0=;
	b=DtIF64EY5yhjB5aX/HBRPe97XQJF8kBEkm9mmt7IfpdEPQXdWroG1VcTM/sGIosyGAoS
	 8jjKnt6697k8Kca8JWfBk9kFJbVmB03yLIwcGIq55AL6S+0vOy1pFXKpR9lkUqmgSig+R
	 vNgvO49Ud7BnL+WZxl9Ra7Zm05M/W217Pssxt/kO6WBYEAHo4mSNfrklgDRSbLWFH/4Oa
	 +aF0CbT2/fI+8kcaeVAFjv3xuzqK7bYyZXzRBTTNXGi2X/Y4z+0nFtKqAJ6klGWWufOk6
	 3XW5yCQaSk3ouNXMm4lZnhc6TDKVyohfmLIeISjQH/T2naycXjJdWzBt+YXYLDzmKkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfpMng+6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED0A606A6B8;
	Sat, 21 Nov 2026 03:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfpMng+6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112291F000D3;
	Sat, 21 Nov 2026 03:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795231280;
	bh=M7OJHFSjd8T4K7iSmGwlRH3p7LR2cBaH3oOxz9lF1k0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jfpMng+67T3qg/GfCC20bQSA/XX8ykCUE9ypJ6N2s+CXs1Vt8zjdd4WcsOtqHaRII
	 aRTdgZuc7bPa6wSysNlJXU777ZHZdgFq4Z7cj1HJkDU0axj/rusrqC5ZiHLGGhzmV8
	 5xSyPnH8HR6xilLVwRgLkiQGgT9CQCllZf4cG0WRy+kYM8voS4EGXmur9wxI2FkOZ9
	 8bnrLOmuJII5/pXJIr9tNeG2rDxdgpqOU0dSCoC0WssZactl/FqEGug/uQNbYlzT9L
	 PKTFSnX5RGIh6vvKPB9C761AimK676gtpurpk7QG9ezStaYyGJauVxj2yMXL3e2LRY
	 ziQZznf0MrQSA==
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
Subject: [PATCH v10 06/16] perf annotate-data: Count flexible array accesses for the whole struct
Date: Sat, 21 Nov 2026 00:20:42 -0300
Message-ID: <20261121032052.1392234-7-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261121032052.1392234-1-acme@kernel.org>
References: <20261121032052.1392234-1-acme@kernel.org>
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
past the end of its struct, so the struct row only covered its declared
size and showed 0.00% while the member row showed 100.00% and the
header said N samples.

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
 tools/perf/util/annotate-data.c        | 25 +++++++++++++++++++++++--
 tools/perf/util/annotate-data.h        |  8 ++++++++
 3 files changed, 34 insertions(+), 6 deletions(-)

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
index 2332d465f9751ef3..19c1de5c29853f69 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
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
2.56.0

