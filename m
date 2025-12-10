Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9702826E71E;
	Wed, 10 Dec 2025 02:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765334024; cv=none; b=VBi/MZTbYGSicwFAvSmyjyA2tqu7dW79hHFrHVOS4uSZJbmVTQQosYaTJzOEAs7HDJR1JGacvOF0o0jbRGw+3lyFz8a/i3BzXOYrnq31Ty1+b/Mqq4MLUkE6wrr/f7pybNh4BDw//PLwifTRyRv80vztM0DUiePix95XDwlu1BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765334024; c=relaxed/simple;
	bh=2ET50jGh2zEf2KwurBT8d0DBGCrJY2+Me9GIaIayBZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PA+oD6LsbxzBd+xnMo8EUKxr5a1MOHZ31+iuUQliMOHHkZF0sZR4OtZ1OHXDfRD9RUHSZWkIHfLTh5HlSlW+fGly0TCQnY9ruiZO6jLiu6YvOSrEo0CjA0R/2I+1hUlkaQhLB4GWyoDr7cot39X9iQ4TNEh04yJbxWKwN6urQAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMFFs7RJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMFFs7RJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6669C19423;
	Wed, 10 Dec 2025 02:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765334024;
	bh=2ET50jGh2zEf2KwurBT8d0DBGCrJY2+Me9GIaIayBZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PMFFs7RJPYDG1s3DNtfowOVURPagfnRcj+r3F30ywbA0ubPA1c6/XKpn5alq9A8hO
	 t1XJrxjIiupGhUkPSDFgNaY4ujZrZ5IqDXd8AVIf4cJLWg+qUKEwrUZIBw2Rz4VmbO
	 IeX0TTcbG1u2VnVublqqqKNogwIXSzv28nAIX7kzhRVFsThEnt9uVDQwxE/NA5Bvm2
	 TQaDXtxHcKCzhpJ25+7uFAdcyjBlf9l/EkRwVwn00NvEvrkLNbrZJ1W/ScLnopkMW9
	 KY84su1BcxdhfHCzFl04b/eSrgSGsrEyJxcu7Qj3mwRzn/8Fo0fcxvPmR5U3OJaxNv
	 dBd0Mvo4P4S2A==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 4/4] perf report: Update sort key state from -F option
Date: Tue,  9 Dec 2025 18:33:27 -0800
Message-ID: <20251210023327.1669863-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
In-Reply-To: <20251210023327.1669863-1-namhyung@kernel.org>
References: <20251210023327.1669863-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out __sort_dimension__update() so that it can be called from -s
and -F option parsing logics.  Otherwise the following command cannot go
into the annotation mode.

  $ perf report -F overhead,type,sym

  Warning: Annotation is only available for symbolic views, include "sym*" in --sort to use it.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/sort.c | 100 ++++++++++++++++++++++-------------------
 1 file changed, 54 insertions(+), 46 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index c51604eaae0a4b90..5e27a66e3ccb0bbe 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -3531,6 +3531,56 @@ static int add_dynamic_entry(struct evlist *evlist, const char *tok,
 	return ret;
 }
 
+static int __sort_dimension__update(struct sort_dimension *sd,
+				    struct perf_hpp_list *list)
+{
+	if (sd->entry == &sort_parent && parent_pattern) {
+		int ret = regcomp(&parent_regex, parent_pattern, REG_EXTENDED);
+		if (ret) {
+			char err[BUFSIZ];
+
+			regerror(ret, &parent_regex, err, sizeof(err));
+			pr_err("Invalid regex: %s\n%s", parent_pattern, err);
+			return -EINVAL;
+		}
+		list->parent = 1;
+	} else if (sd->entry == &sort_sym) {
+		list->sym = 1;
+		/*
+		 * perf diff displays the performance difference amongst
+		 * two or more perf.data files. Those files could come
+		 * from different binaries. So we should not compare
+		 * their ips, but the name of symbol.
+		 */
+		if (sort__mode == SORT_MODE__DIFF)
+			sd->entry->se_collapse = sort__sym_sort;
+
+	} else if (sd->entry == &sort_sym_offset) {
+		list->sym = 1;
+	} else if (sd->entry == &sort_dso) {
+		list->dso = 1;
+	} else if (sd->entry == &sort_socket) {
+		list->socket = 1;
+	} else if (sd->entry == &sort_thread) {
+		list->thread = 1;
+	} else if (sd->entry == &sort_comm) {
+		list->comm = 1;
+	} else if (sd->entry == &sort_type_offset) {
+		symbol_conf.annotate_data_member = true;
+	} else if (sd->entry == &sort_sym_from || sd->entry == &sort_sym_to) {
+		list->sym = 1;
+	} else if (sd->entry == &sort_mem_dcacheline && cacheline_size() == 0) {
+		return -EINVAL;
+	} else if (sd->entry == &sort_mem_daddr_sym) {
+		list->sym = 1;
+	}
+
+	if (sd->entry->se_collapse)
+		list->need_collapse = 1;
+
+	return 0;
+}
+
 static int __sort_dimension__add(struct sort_dimension *sd,
 				 struct perf_hpp_list *list,
 				 int level)
@@ -3541,8 +3591,8 @@ static int __sort_dimension__add(struct sort_dimension *sd,
 	if (__sort_dimension__add_hpp_sort(sd, list, level) < 0)
 		return -1;
 
-	if (sd->entry->se_collapse)
-		list->need_collapse = 1;
+	if (__sort_dimension__update(sd, list) < 0)
+		return -1;
 
 	sd->taken = 1;
 
@@ -3578,8 +3628,8 @@ static int __sort_dimension__add_output(struct perf_hpp_list *list,
 	if (__sort_dimension__add_hpp_output(sd, list, level) < 0)
 		return -1;
 
-	if (sd->entry->se_collapse)
-		list->need_collapse = 1;
+	if (__sort_dimension__update(sd, list) < 0)
+		return -1;
 
 	sd->taken = 1;
 	return 0;
@@ -3644,39 +3694,6 @@ int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
 				sort_dimension_add_dynamic_header(sd, env);
 		}
 
-		if (sd->entry == &sort_parent && parent_pattern) {
-			int ret = regcomp(&parent_regex, parent_pattern, REG_EXTENDED);
-			if (ret) {
-				char err[BUFSIZ];
-
-				regerror(ret, &parent_regex, err, sizeof(err));
-				pr_err("Invalid regex: %s\n%s", parent_pattern, err);
-				return -EINVAL;
-			}
-			list->parent = 1;
-		} else if (sd->entry == &sort_sym) {
-			list->sym = 1;
-			/*
-			 * perf diff displays the performance difference amongst
-			 * two or more perf.data files. Those files could come
-			 * from different binaries. So we should not compare
-			 * their ips, but the name of symbol.
-			 */
-			if (sort__mode == SORT_MODE__DIFF)
-				sd->entry->se_collapse = sort__sym_sort;
-
-		} else if (sd->entry == &sort_dso) {
-			list->dso = 1;
-		} else if (sd->entry == &sort_socket) {
-			list->socket = 1;
-		} else if (sd->entry == &sort_thread) {
-			list->thread = 1;
-		} else if (sd->entry == &sort_comm) {
-			list->comm = 1;
-		} else if (sd->entry == &sort_type_offset) {
-			symbol_conf.annotate_data_member = true;
-		}
-
 		return __sort_dimension__add(sd, list, level);
 	}
 
@@ -3695,9 +3712,6 @@ int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
 				    strlen(tok)))
 			return -EINVAL;
 
-		if (sd->entry == &sort_sym_from || sd->entry == &sort_sym_to)
-			list->sym = 1;
-
 		__sort_dimension__add(sd, list, level);
 		return 0;
 	}
@@ -3711,12 +3725,6 @@ int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
 		if (sort__mode != SORT_MODE__MEMORY)
 			return -EINVAL;
 
-		if (sd->entry == &sort_mem_dcacheline && cacheline_size() == 0)
-			return -EINVAL;
-
-		if (sd->entry == &sort_mem_daddr_sym)
-			list->sym = 1;
-
 		__sort_dimension__add(sd, list, level);
 		return 0;
 	}
-- 
2.52.0.223.gf5cc29aaa4-goog

