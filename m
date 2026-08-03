Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9992D949C;
	Mon,  3 Aug 2026 01:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785719512; cv=none; b=m8LlwS1HCgu5YYtkScHDDJN65LfzG8Fty8TVmT1qtZ1kcUE3TSTURy/dS89hHblwC0GPhBIGJDMo85gTGy4aWDmOJHcvQ0y2pi9lN38P5+jHgISNS8a6Klu0xyoK3A0Uh9+a3fF1SeD/a2DowTD1zMPSBwvFuYdLBBLwu29qBtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785719512; c=relaxed/simple;
	bh=ttYcqu4qrJ7YD1NMVsN5D7j0h4bPZwJPpbL8X5H9oR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTFVK7B9D0LC/Wuc1DOMe09GussMJdJuozZ/UyPdNpekdLxBqJ90l9NV38UAaXPu9SC3C4wDMGKJdfYAKIPGxRvJpaaNeRCXsFIeTlFKg29VK8EksaYoNSLtgl9r2TTFHRnJwmUDtbZE/pZHpaX+A1EuVa0jsWg6kvxJiCocLhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WY02y1XY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WY02y1XY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792871F00A3A;
	Mon,  3 Aug 2026 01:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785719510;
	bh=JbPcBM1pijKIIniNdkaqelB/3LHnd848Lbgh+q+4Qqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WY02y1XYi1yAocf5nTGM3eO1P9sfajyWTTwv0EF8xoOP0a7flbE+F9fGnnO1KUwVF
	 jxXTTolU5sdh/olft2WYvkrq20yYjOzv0i8lSkKf1vFnuFbram8DJY2c2cW8HOp6vk
	 u5hfdPEA4h1VnKYkt0OJYFkzSP7zzaBOVSDnX+fdU68kgfG1Gio923i1IbE1hhsMUx
	 5S8GUMQvJlVOiLRdeYHv+YgBJeqXlHB1Z8qeZy9UDylUdbp07r74MAn+S5VPKa5lkH
	 dKOf+mw17OsrX7ffvTxiiEFMEphBDUT3GD7x/vt2iQ2FpirGdKUZwgOAYGeRS4VsqH
	 xb5wXc6//u6xA==
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
Date: Sun,  2 Aug 2026 22:11:39 -0300
Message-ID: <20260803011140.179943-2-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803011140.179943-1-acme@kernel.org>
References: <20260803011140.179943-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

hpp_list__parse() has two bugs:

1. The PARSE_LIST macro resets ret = 0 at the start of each invocation,
   so an error from output parsing is silently overwritten when the sort
   parsing block runs.  The function returns success with partially
   initialized state.

2. When the caller passes a non-NULL output_ or sort_ string, but
   strdup() returns NULL due to OOM, NULL is passed to PARSE_LIST which
   treats it as empty input (the "if (!_list) break" branch).  No error
   is returned.

Fix both by checking strdup() return values before proceeding and adding
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

Fixes: 2d388bd0c9d3 ("perf c2c report: Add stdio output support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Assisted-by: Claude:claude-sonnet-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index c9584dbedf77afe8..df07e97155df2584 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2093,8 +2093,18 @@ static int hpp_list__parse(struct perf_hpp_list *hpp_list,
 	char *sort   = sort_   ? strdup(sort_) : NULL;
 	int ret;
 
+	/* strdup() returns NULL on OOM, don't silently treat as empty */
+	if ((output_ && !output) || (sort_ && !sort)) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	PARSE_LIST(output, c2c_hists__init_output);
+	if (ret)
+		goto out;
 	PARSE_LIST(sort,   c2c_hists__init_sort);
+	if (ret)
+		goto out;
 
 	/* copy sort keys to output fields */
 	perf_hpp__setup_output_field(hpp_list);
@@ -2111,6 +2121,7 @@ static int hpp_list__parse(struct perf_hpp_list *hpp_list,
 	perf_hpp__append_sort_keys(&hists->list);
 #endif
 
+out:
 	free(output);
 	free(sort);
 	return ret;
@@ -2281,6 +2292,7 @@ static int resort_cl_cb(struct hist_entry *he, void *arg)
 	struct c2c_hist_entry *c2c_he;
 	struct c2c_hists *c2c_hists;
 	bool display = he__display(he, &c2c.shared_clines_stats);
+	int ret;
 
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
 	c2c_hists = c2c_he->hists;
@@ -2291,7 +2303,9 @@ static int resort_cl_cb(struct hist_entry *he, void *arg)
 		c2c_he->cacheline_idx = idx++;
 		calc_width(c2c_he);
 
-		c2c_hists__reinit(c2c_hists, c2c.cl_output, c2c.cl_resort, env);
+		ret = c2c_hists__reinit(c2c_hists, c2c.cl_output, c2c.cl_resort, env);
+		if (ret)
+			return ret;
 
 		hists__collapse_resort(&c2c_hists->hists, NULL);
 		hists__output_resort_cb(&c2c_hists->hists, NULL, filter_cb);
@@ -3356,13 +3370,19 @@ static int perf_c2c__report(int argc, const char **argv)
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
 
-- 
2.55.0

