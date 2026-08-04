Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E854399E2;
	Tue,  4 Aug 2026 18:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869924; cv=none; b=Ysm6zhx+2wgQJU+0VuKSB6+DK+CEfoifPE9oMR0GWITpekR74P++KHZ84VouCzrPHSv0J1ONzS4fw85Cn5ZSYkL4ynk9Ov8MyNiGylVzNfibZUSwpXutX7nO7N+ZuobTicAD/wItsrqaJ86m71vvxBFH88nOiiTZ0TEiRhwdwaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869924; c=relaxed/simple;
	bh=GYpOdpX2OaU+Pc1zMNN8m1QKRrz2aA73mAVxOj/5ON4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XeOZQNiFemLzvRtJWhHyCI5XdmPJXEUdFBwQdjApsm4Q/jGAvdda5DyoXg5oN6OHuCjUyAzIJcUtcMn7B9J9CBlJGMe6MOSMTIiY3JzOzF4BDbcswersPXUVBLNzCb8wYXy8nJ9KQ3Umw6waZj7NUIkmHqNp4eQ1KlaEW2iCDvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVyckEc7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVyckEc7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF6F1F00A3A;
	Tue,  4 Aug 2026 18:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785869922;
	bh=ZmZ7nJfMxzL0cY57fEFcfbJRt9OEFmY6PAbW3x267FM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DVyckEc74uGy0z4/Bw0VLg1GEwgXoXSVV+rKtNPNKn1GLropZdTo7yzYW7Hm2CUR9
	 iXYbcKOdge6B7z2NGkPGJujRCwjjU/GvvGDKFtpEYWPY73jE+hvs+WShvzh4hhEVir
	 ROSpyr7cL+cCGhwwKNkr3b/nsQ+ThIIVGhhORSwur+XAoE79pXwn0NJfHRGltosv3f
	 1mt/K5CiGwmBH4sLP1QnDPSQgpEDlVlubnhqC30ED0Ko2Fcefpbl6PxaxX47SMSU1E
	 fPD5bt3VLvRpv8uvp6tF8zEypyhaWyqSZ87hU6iEO5XeXuig4kts5KOGXNE4il2FxU
	 +oZU3aCK++wXQ==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH 1/2] perf c2c: Fix error masking, OOM, and unchecked caller errors in hpp_list__parse()
Date: Tue,  4 Aug 2026 15:58:29 -0300
Message-ID: <20260804185830.228763-2-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804185830.228763-1-acme@kernel.org>
References: <20260804185830.228763-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

hpp_list__parse() has three bugs:

1. The PARSE_LIST macro resets ret = 0 at the start of each invocation,
   so an error from output parsing is silently overwritten when the sort
   parsing block runs.  The function returns success with partially
   initialized state.

2. When the caller passes a non-NULL output_ or sort_ string, but
   strdup() returns NULL due to OOM, NULL is passed to PARSE_LIST which
   treats it as empty input (the "if (!_list) break" branch).  No error
   is returned.

3. When the called _fn function fails and returns something other than
   -ESRCH or -EINVAL (-ENOMEM, for instance) it was not bailing out of
   the strtok loop.

Fix them by checking strdup() return values before proceeding and adding
a cleanup label so that ret from each PARSE_LIST call is checked before
the next runs, preserving the first error.

The early exits now skip perf_hpp__setup_output_field(), which means
c2c_hists__reinit() can return a non-zero value in cases that previously
always succeeded silently.  Both callers discarded its return:
resort_cl_cb() continued into hists__collapse_resort() on a broken list,
and perf_c2c__report() proceeded with uninitialised hists.  Fix the full
chain: check and propagate the error in resort_cl_cb() -- hists__iterate_cb()
already stops iteration and returns the callback error -- and check both
c2c_hists__reinit() and hists__iterate_cb() in perf_c2c__report().

Also turn PARSE_LIST into a function, using a switch to catch other
errors, converting the called functions to return an appropriate errno
instead of -1 on failure.

Fixes: 2d388bd0c9d3 ("perf c2c report: Add stdio output support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Assisted-by: Claude:claude-sonnet-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 85 ++++++++++++++++++++++++++++------------
 tools/perf/util/sort.c   | 38 ++++++++++--------
 2 files changed, 82 insertions(+), 41 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index c9584dbedf77afe8..160b82694d391c50 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -12,11 +12,14 @@
  */
 #include <errno.h>
 #include <inttypes.h>
+#include <stdlib.h>
+#include <string.h>
 
 #include <asm/bug.h>
 #include <linux/compiler.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include <linux/stringify.h>
 #include <linux/zalloc.h>
 #include <sys/param.h>
@@ -2063,26 +2066,38 @@ static int c2c_hists__init_sort(struct perf_hpp_list *hpp_list, char *name, stru
 	return 0;
 }
 
-#define PARSE_LIST(_list, _fn)							\
-	do {									\
-		char *tmp, *tok;						\
-		ret = 0;							\
-										\
-		if (!_list)							\
-			break;							\
-										\
-		for (tok = strtok_r((char *)_list, ", ", &tmp);			\
-				tok; tok = strtok_r(NULL, ", ", &tmp)) {	\
-			ret = _fn(hpp_list, tok, env);				\
-			if (ret == -EINVAL) {					\
-				pr_err("Invalid --fields key: `%s'", tok);	\
-				break;						\
-			} else if (ret == -ESRCH) {				\
-				pr_err("Unknown --fields key: `%s'", tok);	\
-				break;						\
-			}							\
-		}								\
-	} while (0)
+static int __hpp_list__parse(struct perf_hpp_list *hpp_list, char *_list, struct perf_env *env,
+			     int (*_fn)(struct perf_hpp_list *hpp_list, char *name, struct perf_env *env))
+{
+	char *tmp, *tok;
+	int ret = 0;
+
+	if (!_list)
+		return 0;
+
+	for (tok = strtok_r(_list, ", ", &tmp); tok; tok = strtok_r(NULL, ", ", &tmp)) {
+		ret = _fn(hpp_list, tok, env);
+		switch (ret) {
+		case 0:
+			continue;
+		case -EINVAL:
+			pr_err("Invalid --fields key: `%s'", tok);
+			goto out;
+		case -ESRCH:
+			pr_err("Unknown --fields key: `%s'", tok);
+			goto out;
+		default: {
+			char buf[STRERR_BUFSIZE];
+
+			pr_err("%s for --fields key: `%s'",
+			       str_error_r(-ret, buf, sizeof(buf)), tok);
+			goto out;
+		}
+		}
+	}
+out:
+	return ret;
+}
 
 static int hpp_list__parse(struct perf_hpp_list *hpp_list,
 			   const char *output_,
@@ -2093,8 +2108,18 @@ static int hpp_list__parse(struct perf_hpp_list *hpp_list,
 	char *sort   = sort_   ? strdup(sort_) : NULL;
 	int ret;
 
-	PARSE_LIST(output, c2c_hists__init_output);
-	PARSE_LIST(sort,   c2c_hists__init_sort);
+	/* strdup() returns NULL on OOM, don't silently treat as empty */
+	if ((output_ && !output) || (sort_ && !sort)) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = __hpp_list__parse(hpp_list, output, env, c2c_hists__init_output);
+	if (ret)
+		goto out;
+	ret = __hpp_list__parse(hpp_list, sort, env, c2c_hists__init_sort);
+	if (ret)
+		goto out;
 
 	/* copy sort keys to output fields */
 	perf_hpp__setup_output_field(hpp_list);
@@ -2111,6 +2136,7 @@ static int hpp_list__parse(struct perf_hpp_list *hpp_list,
 	perf_hpp__append_sort_keys(&hists->list);
 #endif
 
+out:
 	free(output);
 	free(sort);
 	return ret;
@@ -2281,6 +2307,7 @@ static int resort_cl_cb(struct hist_entry *he, void *arg)
 	struct c2c_hist_entry *c2c_he;
 	struct c2c_hists *c2c_hists;
 	bool display = he__display(he, &c2c.shared_clines_stats);
+	int ret;
 
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
 	c2c_hists = c2c_he->hists;
@@ -2291,7 +2318,9 @@ static int resort_cl_cb(struct hist_entry *he, void *arg)
 		c2c_he->cacheline_idx = idx++;
 		calc_width(c2c_he);
 
-		c2c_hists__reinit(c2c_hists, c2c.cl_output, c2c.cl_resort, env);
+		ret = c2c_hists__reinit(c2c_hists, c2c.cl_output, c2c.cl_resort, env);
+		if (ret)
+			return ret;
 
 		hists__collapse_resort(&c2c_hists->hists, NULL);
 		hists__output_resort_cb(&c2c_hists->hists, NULL, filter_cb);
@@ -3356,13 +3385,19 @@ static int perf_c2c__report(int argc, const char **argv)
 	else if (c2c.display == DISPLAY_SNP_PEER)
 		sort_str = "tot_peer";
 
-	c2c_hists__reinit(&c2c.hists, output_str, sort_str, perf_session__env(session));
+	err = c2c_hists__reinit(&c2c.hists, output_str, sort_str, perf_session__env(session));
+	if (err) {
+		pr_err("Failed to reinitialize hists\n");
+		goto out_mem2node;
+	}
 
 	ui_progress__init(&prog, c2c.hists.hists.nr_entries, "Sorting...");
 
 	hists__collapse_resort(&c2c.hists.hists, NULL);
 	hists__output_resort_cb(&c2c.hists.hists, &prog, resort_shared_cl_cb);
-	hists__iterate_cb(&c2c.hists.hists, resort_cl_cb, perf_session__env(session));
+	err = hists__iterate_cb(&c2c.hists.hists, resort_cl_cb, perf_session__env(session));
+	if (err)
+		goto out_mem2node;
 
 	ui_progress__finish();
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index dcf9189786f8aeba..2f59e37089ef06a2 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -3105,7 +3105,7 @@ static int __sort_dimension__add_hpp_sort(struct sort_dimension *sd,
 	struct hpp_sort_entry *hse = __sort_dimension__alloc_hpp(sd, level);
 
 	if (hse == NULL)
-		return -1;
+		return -ENOMEM;
 
 	perf_hpp_list__register_sort_field(list, &hse->hpp);
 	return 0;
@@ -3118,7 +3118,7 @@ static int __sort_dimension__add_hpp_output(struct sort_dimension *sd,
 	struct hpp_sort_entry *hse = __sort_dimension__alloc_hpp(sd, level);
 
 	if (hse == NULL)
-		return -1;
+		return -ENOMEM;
 
 	perf_hpp_list__column_register(list, &hse->hpp);
 	return 0;
@@ -3742,14 +3742,18 @@ static int __sort_dimension__add(struct sort_dimension *sd,
 				 struct perf_hpp_list *list,
 				 int level)
 {
+	int ret;
+
 	if (sd->taken)
 		return 0;
 
-	if (__sort_dimension__add_hpp_sort(sd, list, level) < 0)
-		return -1;
+	ret = __sort_dimension__add_hpp_sort(sd, list, level);
+	if (ret < 0)
+		return ret;
 
-	if (__sort_dimension__update(sd, list) < 0)
-		return -1;
+	ret = __sort_dimension__update(sd, list);
+	if (ret < 0)
+		return ret;
 
 	sd->taken = 1;
 
@@ -3767,7 +3771,7 @@ static int __hpp_dimension__add(struct hpp_dimension *hd,
 
 	fmt = __hpp_dimension__alloc_hpp(hd, level);
 	if (!fmt)
-		return -1;
+		return -ENOMEM;
 
 	hd->taken = 1;
 	hd->was_taken = 1;
@@ -3779,14 +3783,18 @@ static int __sort_dimension__add_output(struct perf_hpp_list *list,
 					struct sort_dimension *sd,
 					int level)
 {
+	int ret;
+
 	if (sd->taken)
 		return 0;
 
-	if (__sort_dimension__add_hpp_output(sd, list, level) < 0)
-		return -1;
+	ret = __sort_dimension__add_hpp_output(sd, list, level);
+	if (ret < 0)
+		return ret;
 
-	if (__sort_dimension__update(sd, list) < 0)
-		return -1;
+	ret = __sort_dimension__update(sd, list);
+	if (ret < 0)
+		return ret;
 
 	sd->taken = 1;
 	return 0;
@@ -3803,7 +3811,7 @@ static int __hpp_dimension__add_output(struct perf_hpp_list *list,
 
 	fmt = __hpp_dimension__alloc_hpp(hd, level);
 	if (!fmt)
-		return -1;
+		return -ENOMEM;
 
 	hd->taken = 1;
 	perf_hpp_list__column_register(list, fmt);
@@ -3869,8 +3877,7 @@ int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
 				    strlen(tok)))
 			return -EINVAL;
 
-		__sort_dimension__add(sd, list, level);
-		return 0;
+		return __sort_dimension__add(sd, list, level);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(memory_sort_dimensions); i++) {
@@ -3882,8 +3889,7 @@ int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
 		if (sort__mode != SORT_MODE__MEMORY)
 			return -EINVAL;
 
-		__sort_dimension__add(sd, list, level);
-		return 0;
+		return __sort_dimension__add(sd, list, level);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(hpp_sort_dimensions); i++) {
-- 
2.55.0

