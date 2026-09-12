Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E874369D54;
	Sat, 12 Sep 2026 05:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789192033; cv=none; b=loGpz8QnP+tA9n1dSklHsbyMU9Iecq2tMTPYWfPevPanTmXilppSsmMWyrCwfkeKag0cNWnctJL5jutOGJMG1BR4JamFT+0TAH4lJOgz1tuQgOtVg94y21IdvMBZEcibg+OddbqtPJifv5x9lypyFYQWiBmRhM5IUgWoQH47Gpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789192033; c=relaxed/simple;
	bh=WNKbhKgqiUM7cYedLfYZJc322IJnvKwdL9zCUyBNm7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7gZswASimUjmsxHmhXocaTOCJKW1uyl3b54Gpgp6ptMzEW6Q2EL2rRyFor/KbGU++WDVy6xrmnTyEU/5s92XxXMNWE6dqVQHxTyFlhLq5sS3yobcBrM9w/ZBqxosFlAX2jVRERr0LH2pR657nUtEZhImgpvaER+XoR13Bgrpuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkyL/Isd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkyL/Isd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8358E1F00898;
	Sat, 12 Sep 2026 05:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789192032;
	bh=JTsJ9/vKQrACbY3Fqgy68jekiTz8o+GkXh3fRunTm0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BkyL/IsdCPmIX36A0TuBRbReN3Qh8QepQfh2Xy+tFcoNtEWl3pXZjRmE64dC8/yA6
	 CBBmq0YG6L37+7Ofeake2SwJdXX4Wm7ojwb3V5dGQQPb3MUxzrQrlc2vzAPNshk/bO
	 ZiShdVH7q6MvX4A4tKxbPXg5Gs/FWE7657dP+ZeOfGnxnBucY8TpPRb/1pzcjBTiWK
	 KXBZU44kx5aBi6WWPHb3oWk8QNZeN1ZTZGCVs/sCFOgXtOYXu/N2aMDePmp4o+0K8w
	 XlKNY+Ul5QeXtaZaRPw5TV7A3TuX9FVvXvdmYC50GWHw2wwT8R9OwcPgEU1goahn/5
	 zMaDcZ4e99y6A==
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
Subject: [PATCH 3/4] perf annotate-date: Allow out-of-size access for flex-array types
Date: Fri, 11 Sep 2026 22:47:05 -0700
Message-ID: <20260912054706.1475583-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
In-Reply-To: <20260912054706.1475583-1-namhyung@kernel.org>
References: <20260912054706.1475583-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Structs that have a flex array will have accesses beyond its original
size as the array was declared as 0 sized.  For now, it just allow any
offset bigger than the size.  It could be refined later.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 22 +++++++++++++++-------
 tools/perf/util/annotate-data.h |  2 ++
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index aff60a630fd05b01..ad043403ced58d98 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -248,8 +248,15 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
 	else
 		die_mem = member_type;
 
-	if (dwarf_aggregate_size(&die_mem, &size) < 0)
-		size = 0;
+	if (dwarf_aggregate_size(&die_mem, &size) < 0) {
+		if (dwarf_tag(&die_mem) == DW_TAG_array_type) { /* flex-array? */
+			__die_get_real_type(&die_mem, &die_mem);
+			if (dwarf_aggregate_size(&die_mem, &size) < 0)
+				size = 0;
+		} else {
+			size = 0;
+		}
+	}
 
 	if (dwarf_attr_integrate(die, DW_AT_data_member_location, &attr)) {
 		if (dwarf_formudata(&attr, &loc) != 0) {
@@ -399,6 +406,7 @@ static struct annotated_data_type *dso__findnew_data_type(struct dso *dso,
 	result->self.type_name = type_name;
 	result->self.size = size;
 	INIT_LIST_HEAD(&result->self.children);
+	result->flex_array = die_has_flex_array(type_die);
 
 	if (symbol_conf.annotate_data_member)
 		add_member_types(result, type_die);
@@ -559,7 +567,7 @@ static enum type_match_result check_variable(struct data_loc_info *dloc,
 		return PERF_TMR_NO_SIZE;
 
 	/* Minimal sanity check */
-	if ((unsigned)offset >= size)
+	if ((unsigned)offset >= size && !die_has_flex_array(&sized_type))
 		return PERF_TMR_BAD_OFFSET;
 
 	return PERF_TMR_OK;
@@ -1168,7 +1176,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 
 		/* Get the size of the actual type */
 		if (dwarf_aggregate_size(&sized_type, &size) < 0 ||
-		    (unsigned)dloc->type_offset >= size)
+		    ((unsigned)dloc->type_offset >= size && !die_has_flex_array(&sized_type)))
 			return PERF_TMR_BAD_OFFSET;
 
 		return PERF_TMR_OK;
@@ -1192,7 +1200,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 
 		/* Get the size of the actual type */
 		if (dwarf_aggregate_size(type_die, &size) < 0 ||
-		    (unsigned)dloc->type_offset >= size)
+		    ((unsigned)dloc->type_offset >= size && !die_has_flex_array(type_die)))
 			return PERF_TMR_BAD_OFFSET;
 
 		return PERF_TMR_OK;
@@ -1211,7 +1219,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
 
 		/* Get the size of the actual type */
 		if (dwarf_aggregate_size(type_die, &size) < 0 ||
-		    (unsigned)dloc->type_offset >= size)
+		    ((unsigned)dloc->type_offset >= size && !die_has_flex_array(type_die)))
 			return PERF_TMR_BAIL_OUT;
 
 		return PERF_TMR_OK;
@@ -1839,7 +1847,7 @@ int annotated_data_type__update_samples(struct annotated_data_type *adt,
 			return -1;
 	}
 
-	if (offset < 0 || offset >= adt->self.size)
+	if (offset < 0 || (offset >= adt->self.size && !adt->flex_array))
 		return -1;
 
 	h = &adt->histograms[evsel->core.idx];
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index ca2096a9ee62cbfe..27b7148b64f60350 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -85,6 +85,7 @@ struct type_hist {
  * struct annotated_data_type - Data type to profile
  * @node: RB-tree node for dso->type_tree
  * @self: Actual type information
+ * @flex_array: Whethere it has a flex array
  * @nr_histogram: Number of histogram entries
  * @histograms: An array of histograms
  *
@@ -93,6 +94,7 @@ struct type_hist {
 struct annotated_data_type {
 	struct rb_node node;
 	struct annotated_member self;
+	bool flex_array;
 	int nr_histograms;
 	struct type_hist *histograms;
 };
-- 
2.55.0.1032.g73a4cd73de-goog

