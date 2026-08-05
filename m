Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD55468C28;
	Wed,  5 Aug 2026 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785942665; cv=none; b=iE6fIDt6hkP2aBaEfhq24rQtTmarS+ZiuBG8+p9VTc0yQq/4ExLLt+ITo3WAa8FwT+firQvlC4oMg3PpKzKB394PCJDbVYT3VQvUC8yPxqx7sSfq65H0UR7eFNKBkfaG9mt4csp1hQhgMawGVUNJqGAbKwq/cPEBHyqB2OViMIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785942665; c=relaxed/simple;
	bh=ejjLZ7O65DcsPty9RAZL3PMR+obBOsqEbsgg2Tce320=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUTgqvfatxgFu7OhZrV/CcF5GY17OuJCjual8TNcZguROUawSdovO9bC8B7tdUJvmPFqQh3OBYd6ufGmfWVaWgcxv8xf2Rde+vKs+Q2IA9LOSWxC5kQEKQCva7f5xq1dEELpG+aWjeQW99dauZFNLQA+dCJAGPVaGFF2vsdnSDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqA5PR5Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqA5PR5Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E331F000E9;
	Wed,  5 Aug 2026 15:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785942663;
	bh=R/Qz7yDRFrAwuuEwAaKCqvsnfNtGCIPt8gEj0b125wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hqA5PR5Z8PC8wC5o3OLR3i3BJWFZOkos05pneyKMsR5xN31ulOdU9d4SbDUSZNb7G
	 XWJtS4dYaJshdmNhCUUEI65lcpzq/quoqwHxwB6xPPaNblIz3aFfD+k+UgQ5H+fvfU
	 HMpwmkypsSw5yNxasodoEfd+kHJXG8FR5Bc2KThU0JyhoEASlss6DV4mYGjslX0cMC
	 s3/D1TF5PQNeB2gzQsgeD4aIW6w1V20watBQk/5O6TQ5UyDSHiWR+IXJaSTs0Ade40
	 iJ0M3QXhPl/mVprekHG6oVviX0V7atNq7Hk9aLwmtnNumeZ4o0sUXKN3pq4LU0AbtE
	 uX/0yyI1XJPvQ==
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
Subject: [PATCH 2/2] perf c2c: Clean up registered formats on c2c_hists__init() and c2c_hists__reinit() failure
Date: Wed,  5 Aug 2026 12:10:43 -0300
Message-ID: <20260805151043.237233-3-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805151043.237233-1-acme@kernel.org>
References: <20260805151043.237233-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When c2c_hists__init() or c2c_hists__reinit() calls hpp_list__parse()
and it fails partway through, format structures registered via
perf_hpp_list__column_register() and perf_hpp_list__register_sort_field()
are left on the hpp_list.

In c2c_hists__init(), only one of the callers, c2c_he__alloc_hists(),
handled this with perf_hpp__reset_output_field(), while perf_c2c_report()
did not, leaking the partially registered entries.

In c2c_hists__reinit(), neither perf_c2c_report() nor resort_cl_cb()
clean up on failure.

Fix by adding cleanup inside both functions themselves, so all callers
are protected, and remove the now redundant reset in c2c_he__alloc_hists().

Fixes: 78b275437873 ("perf c2c report: Add sample processing")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Assisted-by: Claude:claude-opus-4.6
Assisted-by: Opencode:mimo-v2.5-free
Assisted-by: Opencode:DeepSeek-V4-Flash-free
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 160b82694d391c50..bc16a57e092742ad 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -229,7 +229,6 @@ he__get_c2c_hists(struct hist_entry *he,
 
 	ret = c2c_hists__init(hists, sort, nr_header_lines, env);
 	if (ret) {
-		perf_hpp__reset_output_field(&hists->list);
 		c2c_he->hists = NULL;
 		free(hists);
 		return NULL;
@@ -2147,6 +2146,8 @@ static int c2c_hists__init(struct c2c_hists *hists,
 			   int nr_header_lines,
 			   struct perf_env *env)
 {
+	int ret;
+
 	__hists__init(&hists->hists, &hists->list);
 
 	/*
@@ -2159,7 +2160,13 @@ static int c2c_hists__init(struct c2c_hists *hists,
 	/* Overload number of header lines.*/
 	hists->list.nr_header_lines = nr_header_lines;
 
-	return hpp_list__parse(&hists->list, /*output=*/NULL, sort, env);
+	ret = hpp_list__parse(&hists->list, /*output=*/NULL, sort, env);
+
+	/* Unregister any formats added before the failure point */
+	if (ret)
+		perf_hpp__reset_output_field(&hists->list);
+
+	return ret;
 }
 
 static int c2c_hists__reinit(struct c2c_hists *c2c_hists,
@@ -2167,8 +2174,16 @@ static int c2c_hists__reinit(struct c2c_hists *c2c_hists,
 			     const char *sort,
 			     struct perf_env *env)
 {
+	int ret;
+
 	perf_hpp__reset_output_field(&c2c_hists->list);
-	return hpp_list__parse(&c2c_hists->list, output, sort, env);
+	ret = hpp_list__parse(&c2c_hists->list, output, sort, env);
+
+	/* Unregister any formats added before the failure point */
+	if (ret)
+		perf_hpp__reset_output_field(&c2c_hists->list);
+
+	return ret;
 }
 
 #define DISPLAY_LINE_LIMIT  0.001
-- 
2.55.0

