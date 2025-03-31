Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03301D54D8;
	Mon, 31 Mar 2025 07:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743406645; cv=none; b=b9M5HgWXg6IDvUVwHjA3sgJDVvBLHoXVpajQqRIASETZheK2pr7g6FR3mz9mKv1vosY/RmveQBApZoN+lTR7prh6a2DgNo6Tq5UG40XLM/jJfGdmT/GZ+k7cLQBDyzbivkNE8PwzTBwepZbn97BsE12txtnDS3J5fHgfO/NHsco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743406645; c=relaxed/simple;
	bh=+g9pedH9vn7fn6iV8pHdDuF77nHGCBMjaxZvpLdqowI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BtKSJN3lR1dCSW8xjAQ5fwjBjVRiPN14dcQmHQTVz2S84cpXlVswn2UT8jCrLJw3EeuTnRmG/yArDtDzIwwRO05S6yDYPpiK1IjPYS+Mqn6mScMclGoc2dUgsglBC2u1l46/8bcW0pi/MOlkhvqSO7DHi/ZLGHsL376ZL0+L+sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvuvJCCM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvuvJCCM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68126C4CEEF;
	Mon, 31 Mar 2025 07:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743406644;
	bh=+g9pedH9vn7fn6iV8pHdDuF77nHGCBMjaxZvpLdqowI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QvuvJCCM8oYGbTNFptF8rvVEhpVLAPfE9BZK+3b5tQpdXruaWwp1YQQJ0s7JUrNQ6
	 Ge2upvcdO0dPJ5HnsK7/uiTBqafLw59g/bhFj9oBUQEORbBbMxzxqYWQBdaHHkKess
	 2fF7Tlq5/U3IGdX6UgHNRijpiOt8X163jBSSOQ+PSQngwOeJ5J5QoNTjvjTLdJcuZo
	 6ZI5JRk1pA+Ire8IDPs47XRW431h6XcjRoAvfz3v4pJfOslR4oCMXRrFbGd8pwb5Bl
	 PB9+khE7MKkAXzHfw2/LGMlAqTWE2p2TXk98f5XUDqYNzwlaHxUUQTa0ozEesdcDKP
	 FXeJq4tK2PZFQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 3/4] perf hist: Set levels in output_field_add()
Date: Mon, 31 Mar 2025 00:37:21 -0700
Message-ID: <20250331073722.4695-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331073722.4695-1-namhyung@kernel.org>
References: <20250331073722.4695-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It turns out that the output fields didn't consider the hierarchy mode
and put all the fields in the same level.  To support hierarchy, each
non-output field should be in a separate level.  Pass a pointer to level
to output_field_add() and make it increase the level when it sees non-
output fields.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-c2c.c |  3 ++-
 tools/perf/util/sort.c   | 36 +++++++++++++++++++++++-------------
 tools/perf/util/sort.h   |  2 +-
 3 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 5d5bb0f32334a975..e2e257bcc461fbdb 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1969,10 +1969,11 @@ static struct c2c_fmt *get_format(const char *name)
 static int c2c_hists__init_output(struct perf_hpp_list *hpp_list, char *name)
 {
 	struct c2c_fmt *c2c_fmt = get_format(name);
+	int level = 0;
 
 	if (!c2c_fmt) {
 		reset_dimensions();
-		return output_field_add(hpp_list, name);
+		return output_field_add(hpp_list, name, &level);
 	}
 
 	perf_hpp_list__column_register(hpp_list, &c2c_fmt->fmt);
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index c51049087e4ebb6c..594b75ca95bf72b2 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2884,9 +2884,10 @@ static int __sort_dimension__add_hpp_sort(struct sort_dimension *sd,
 }
 
 static int __sort_dimension__add_hpp_output(struct sort_dimension *sd,
-					    struct perf_hpp_list *list)
+					    struct perf_hpp_list *list,
+					    int level)
 {
-	struct hpp_sort_entry *hse = __sort_dimension__alloc_hpp(sd, 0);
+	struct hpp_sort_entry *hse = __sort_dimension__alloc_hpp(sd, level);
 
 	if (hse == NULL)
 		return -1;
@@ -3495,12 +3496,13 @@ static int __hpp_dimension__add(struct hpp_dimension *hd,
 }
 
 static int __sort_dimension__add_output(struct perf_hpp_list *list,
-					struct sort_dimension *sd)
+					struct sort_dimension *sd,
+					int level)
 {
 	if (sd->taken)
 		return 0;
 
-	if (__sort_dimension__add_hpp_output(sd, list) < 0)
+	if (__sort_dimension__add_hpp_output(sd, list, level) < 0)
 		return -1;
 
 	sd->taken = 1;
@@ -3508,14 +3510,15 @@ static int __sort_dimension__add_output(struct perf_hpp_list *list,
 }
 
 static int __hpp_dimension__add_output(struct perf_hpp_list *list,
-				       struct hpp_dimension *hd)
+				       struct hpp_dimension *hd,
+				       int level)
 {
 	struct perf_hpp_fmt *fmt;
 
 	if (hd->taken)
 		return 0;
 
-	fmt = __hpp_dimension__alloc_hpp(hd, 0);
+	fmt = __hpp_dimension__alloc_hpp(hd, level);
 	if (!fmt)
 		return -1;
 
@@ -3532,7 +3535,7 @@ int hpp_dimension__add_output(unsigned col, bool implicit)
 	hd = &hpp_sort_dimensions[col];
 	if (implicit && !hd->was_taken)
 		return 0;
-	return __hpp_dimension__add_output(&perf_hpp_list, hd);
+	return __hpp_dimension__add_output(&perf_hpp_list, hd, /*level=*/0);
 }
 
 int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
@@ -4000,7 +4003,7 @@ void sort__setup_elide(FILE *output)
 	}
 }
 
-int output_field_add(struct perf_hpp_list *list, const char *tok)
+int output_field_add(struct perf_hpp_list *list, const char *tok, int *level)
 {
 	unsigned int i;
 
@@ -4013,16 +4016,22 @@ int output_field_add(struct perf_hpp_list *list, const char *tok)
 		if (!strcasecmp(tok, "weight"))
 			ui__warning("--fields weight shows the average value unlike in the --sort key.\n");
 
-		return __hpp_dimension__add_output(list, hd);
+		return __hpp_dimension__add_output(list, hd, *level);
 	}
 
+	/*
+	 * A non-output field will increase level so that it can be in a
+	 * different hierarchy.
+	 */
+	(*level)++;
+
 	for (i = 0; i < ARRAY_SIZE(common_sort_dimensions); i++) {
 		struct sort_dimension *sd = &common_sort_dimensions[i];
 
 		if (!sd->name || strncasecmp(tok, sd->name, strlen(tok)))
 			continue;
 
-		return __sort_dimension__add_output(list, sd);
+		return __sort_dimension__add_output(list, sd, *level);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(bstack_sort_dimensions); i++) {
@@ -4034,7 +4043,7 @@ int output_field_add(struct perf_hpp_list *list, const char *tok)
 		if (sort__mode != SORT_MODE__BRANCH)
 			return -EINVAL;
 
-		return __sort_dimension__add_output(list, sd);
+		return __sort_dimension__add_output(list, sd, *level);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(memory_sort_dimensions); i++) {
@@ -4046,7 +4055,7 @@ int output_field_add(struct perf_hpp_list *list, const char *tok)
 		if (sort__mode != SORT_MODE__MEMORY)
 			return -EINVAL;
 
-		return __sort_dimension__add_output(list, sd);
+		return __sort_dimension__add_output(list, sd, *level);
 	}
 
 	return -ESRCH;
@@ -4056,10 +4065,11 @@ static int setup_output_list(struct perf_hpp_list *list, char *str)
 {
 	char *tmp, *tok;
 	int ret = 0;
+	int level = 0;
 
 	for (tok = strtok_r(str, ", ", &tmp);
 			tok; tok = strtok_r(NULL, ", ", &tmp)) {
-		ret = output_field_add(list, tok);
+		ret = output_field_add(list, tok, &level);
 		if (ret == -EINVAL) {
 			ui__error("Invalid --fields key: `%s'", tok);
 			break;
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 180d36a2bea355da..6e92ac62b9c80a0b 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -146,7 +146,7 @@ void reset_dimensions(void);
 int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
 			struct evlist *evlist,
 			int level);
-int output_field_add(struct perf_hpp_list *list, const char *tok);
+int output_field_add(struct perf_hpp_list *list, const char *tok, int *level);
 int64_t
 sort__iaddr_cmp(struct hist_entry *left, struct hist_entry *right);
 int64_t
-- 
2.49.0

