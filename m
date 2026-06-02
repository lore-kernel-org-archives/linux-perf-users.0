Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7433FDBFD
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422131; cv=none; b=Bb0eX+zSHQzu8prA54Ma/B8D+y47+uVKygGX6/Qd0l7PKcCTNLk2/UIISdyWYVya/NHi2d36chzZda7giu204o0MC3zLjgUyLw1JPJo6mREKKBDZk1qS5c+kXCMP9HhyDoIXjtOTq1R463SiItaIhWxsdyVKZ+7ckwtETrwp+sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422131; c=relaxed/simple;
	bh=pH6eyLhs6cxtxTKG69+0rd6Y4WXhccd3rDSrNXJe/+A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C3BTVWS1XVWjwNrcE6GboBi2ZJMGtRXcplQblTnTgX5ermgT/IcMirtQk0A9x8g1eqNjGW3j4uS4DuF4C5SzlQkaoFCudC3ji+SR7dHA5ua4+I190JNz6u89DfYBquHK/b3ClsKlysf6O4RCYKNRMX8NEM+LE/pGIO2moyC8bO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DKcPwfDo; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DKcPwfDo"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137dd5100c7so4538167c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 10:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780422129; x=1781026929; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cOeJ9wanFZ0uvQbLvnoNAYeAufd5mh/iMd/5/rwfFAQ=;
        b=DKcPwfDoQHKVOzo+kNqy0E2ZzoSQbtsRGpjv9jDZ+DKx7A2noDHL+MI8Z807F2weTk
         6bHFzF7eMPIM0HdqqE8/XqKc3w1mfCB+CCbOA8Er2jfxDGGEdfx5jVNe4ivCeBMPyD/z
         hEkfs0m9TfEJp+V+t7gBk2T0ob9MZWZh0T6vsa6L1R+E2CrHSPnIaW3qtGsSoVlyixwa
         WuYDI82ZFFJaQCn25CP/On2gF0f40NVanOE+OqK/Hv+N8MTkZpfWjxKU0m5PxWT0m3yQ
         BaRIq8KT4A9fUXhKsReyEAMfsD2J0jB2U68PVsY8KCqyI8QcLDXxvnqhkl0uR5XIcMpR
         KLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780422129; x=1781026929;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cOeJ9wanFZ0uvQbLvnoNAYeAufd5mh/iMd/5/rwfFAQ=;
        b=DHxfFpyTo1PKPipIZ4LTd6OwDHj+jna4B0mOZENwSNRjkE1QZOAovrPj3HStkcycFx
         w2/X5SFFUMU2MaxeklXi1zR4QxFnPQOvRZ367I6xh+xutZcSoauOdQFvB07FnzXiSngn
         bcdu165XXkh5N7DeqULSo67eYt+XTZ52H4LzyUTteg1PCb5CLnArpB1mzhhJ5xqlDSJt
         +B0bwrWSnxc8CFzihDZ7R6kbLe9R3de5neN1Yza/+gg7vb2Lc1735DVJatv+AhtsAuw5
         2c99SlY6fJ4jnUYn9qR+E+oKeNVQDESOI/owQJtHBH7iz3r9tRes1y9+9CT1oI+9Q8is
         MTAw==
X-Forwarded-Encrypted: i=1; AFNElJ+wQLum0/oqUSkr3sRZERPJIL/6tI/CVz4pSuWsFGglJP8snkHnqsh+bOraPmrWBPFOxCkf5J5cR2KS3NBuIFQi@vger.kernel.org
X-Gm-Message-State: AOJu0YzJfwmYDbVXccGVxpn7iiWwWsqzNy0v0Ukd7CePvl4yYCbfXnVZ
	bRXE8+nJwaFvCYnuTGKHaiACla9azG+2pUQSQtCIQbOYiak/GpNHgLCCkSoCznc6Vga5SqumGxp
	3dg4Iop5Pjw==
X-Received: from dlnn31.prod.google.com ([2002:a05:7022:619f:b0:135:5a9c:4291])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f91:b0:134:dfd0:9760
 with SMTP id a92af1059eb24-137d3bf3b74mr7464997c88.5.1780422128636; Tue, 02
 Jun 2026 10:42:08 -0700 (PDT)
Date: Tue,  2 Jun 2026 10:41:20 -0700
In-Reply-To: <20260602174129.3192312-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602073132.2653307-1-irogers@google.com> <20260602174129.3192312-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602174129.3192312-10-irogers@google.com>
Subject: [PATCH v8 09/18] perf test: Show snippet failure output for verbose=1
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Currently, when running tests in verbose mode (-v), if a test case
fails, the entire raw standard error buffer is dumped to stderr via
fprintf(stderr, "%s", child->err_output.buf). For tests that generate
massive amounts of debugging or logging output before dying, this
results in multi-page terminal dumps where highly critical diagnostic
keywords (error, fail, segv) are easily lost.

Implement a smart, bounded snippet string processor to improve
failure triaging:
1. Introduce a configurable quota limit static unsigned int
   failure_snippet_lines = 10; accessible via a new command-line option
   --failure-snippet-lines <N>.
2. Parse the raw error buffer dynamically into lines and run a
   three-pass extraction algorithm:
   - Pass 0: Always select the very first line of the log as an initial
     outline marker.
   - Pass 1: Scan forward from the top of the log to pick up to N lines
     that contain case-insensitive failure keywords (error, fail,
     segv, abort) to isolate the root cause. Automatically pull in
     the immediate subsequent line as highly-prioritized context.
     Allow adjacent matching lines to overlap without dropping context
     by evaluating keywords for all lines (e.g. when "Failed to
     report" is followed by "Error:").
   - Pass 2: If quota remains, scan backward from the absolute tail of
     the log to capture trailing crash or abort context.
3. Output the selected lines in their original chronological order,
   inserting a clear ... separator between non-contiguous line jumps.
4. Wrap matched failure keywords dynamically in bold red
   (PERF_COLOR_RED) to immediately draw the eye to failures.
5. Invoke the smart processor purely when verbose == 1 && ret ==
   TEST_FAIL in both finish_test and finish_tests_parallel, leaving
   raw full-output dumping completely untouched when running highly
   verbose (-vv).

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 203 +++++++++++++++++++++++++++++++-
 1 file changed, 200 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 0479184c3dda..3401d79a1d24 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -48,6 +48,8 @@ static bool dont_fork;
 static bool sequential;
 /* Number of times each test is run. */
 static unsigned int runs_per_test = 1;
+/* Number of lines to include in failure snippet. */
+static unsigned int failure_snippet_lines = 10;
 const char *dso_to_test;
 const char *test_objdump_path = "objdump";
 
@@ -344,7 +346,7 @@ static int run_test_child(struct child_process *process)
 	for (size_t i = 0; i < ARRAY_SIZE(signals); i++)
 		signal(signals[i], child_test_sig_handler);
 
-	pr_debug("--- start ---\n");
+	pr_debug("---- start ----\n");
 	pr_debug("test child forked, pid %d\n", getpid());
 	err = test_function(child->test, child->test_case_num)(child->test, child->test_case_num);
 	pr_debug("---- end(%d) ----\n", err);
@@ -400,6 +402,195 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
 	return 0;
 }
 
+static const char * const fail_keywords[] = {
+	"error", "fail", "segv", "abort",
+	"signal", "fatal", "panic", "corrupt", NULL
+};
+
+static const char *find_next_keyword(const char *str, size_t max_len, size_t *kw_len)
+{
+	const char *best = NULL;
+	size_t best_len = 0;
+	int k;
+
+	for (k = 0; fail_keywords[k]; k++) {
+		const char *s = str;
+		size_t len = strlen(fail_keywords[k]);
+
+		while ((size_t)(s - str) + len <= max_len) {
+			size_t i;
+
+			if (best && s >= best)
+				break;
+
+			for (i = 0; i < len; i++) {
+				if (tolower(s[i]) != fail_keywords[k][i])
+					break;
+			}
+			if (i == len) {
+				if (!best || s < best) {
+					best = s;
+					best_len = len;
+				}
+				break;
+			}
+			s++;
+		}
+	}
+	if (best) {
+		*kw_len = best_len;
+		return best;
+	}
+	return NULL;
+}
+
+static void print_line_highlighted(FILE *fp, const char *line, size_t len)
+{
+	const char *s = line;
+
+	while (len > 0) {
+		size_t kw_len = 0;
+		const char *match = find_next_keyword(s, len, &kw_len);
+
+		if (!match) {
+			fwrite(s, 1, len, fp);
+			break;
+		}
+		if (match > s)
+			fwrite(s, 1, match - s, fp);
+		if (perf_use_color_default)
+			fprintf(fp, "%s", PERF_COLOR_RED);
+		fwrite(match, 1, kw_len, fp);
+		if (perf_use_color_default)
+			fprintf(fp, "%s", PERF_COLOR_RESET);
+
+		len -= (match + kw_len) - s;
+		s = match + kw_len;
+	}
+}
+
+
+static void print_test_failure_snippet(FILE *fp, const char *buf)
+{
+	size_t num_lines = 0;
+	size_t max_lines = 128;
+	const char **lines = calloc(max_lines, sizeof(const char *));
+	size_t *line_lens = calloc(max_lines, sizeof(size_t));
+	const char *s = buf;
+	size_t i;
+	unsigned int picked_count = 0;
+	bool *pick;
+	int last_printed = -1;
+
+	if (!lines || !line_lens) {
+		free(lines); free(line_lens);
+		fprintf(fp, "%s", buf);
+		return;
+	}
+
+	while (*s) {
+		const char *eol = strchr(s, '\n');
+		size_t len;
+
+		if (eol)
+			len = eol - s + 1;
+		else
+			len = strlen(s);
+
+		if (num_lines == max_lines) {
+			const char **new_lines;
+			size_t *new_lens;
+
+			max_lines *= 2;
+			new_lines = realloc(lines, max_lines * sizeof(const char *));
+			if (!new_lines) {
+				free(lines); free(line_lens);
+				fprintf(fp, "%s", buf);
+				return;
+			}
+			lines = new_lines;
+
+			new_lens = realloc(line_lens, max_lines * sizeof(size_t));
+			if (!new_lens) {
+				free(lines); free(line_lens);
+				fprintf(fp, "%s", buf);
+				return;
+			}
+			line_lens = new_lens;
+		}
+		lines[num_lines] = s;
+		line_lens[num_lines] = len;
+		num_lines++;
+		s += len;
+	}
+
+	if (num_lines <= failure_snippet_lines) {
+		for (i = 0; i < num_lines; i++)
+			print_line_highlighted(fp, lines[i], line_lens[i]);
+		free(lines); free(line_lens);
+		return;
+	}
+
+	pick = calloc(num_lines, sizeof(bool));
+	if (!pick) {
+		for (i = 0; i < num_lines; i++)
+			print_line_highlighted(fp, lines[i], line_lens[i]);
+		free(lines); free(line_lens);
+		return;
+	}
+
+	/* Pass 0: Always pick the very first line */
+	if (num_lines > 0 && picked_count < failure_snippet_lines) {
+		pick[0] = true;
+		picked_count++;
+	}
+
+	/* Pass 1: Pick lines with failure keywords from start (Highest Priority) */
+	for (i = 0; i < num_lines && picked_count < failure_snippet_lines; i++) {
+		size_t dummy;
+
+		if (find_next_keyword(lines[i], line_lens[i], &dummy)) {
+			if (!pick[i]) {
+				pick[i] = true;
+				picked_count++;
+			}
+			/* Prioritize getting the immediate next line for context */
+			if (i + 1 < num_lines && !pick[i + 1] &&
+			    picked_count < failure_snippet_lines) {
+				pick[i + 1] = true;
+				picked_count++;
+			}
+		}
+	}
+
+	/* Pass 2: Fill remaining quota from the end backwards */
+	i = num_lines;
+	while (i > 0 && picked_count < failure_snippet_lines) {
+		i--;
+		if (!pick[i]) {
+			pick[i] = true;
+			picked_count++;
+		}
+	}
+
+	for (i = 0; i < num_lines; i++) {
+		if (!pick[i])
+			continue;
+		if (last_printed != -1 && (int)i > last_printed + 1) {
+			if (perf_use_color_default)
+				fprintf(fp, "%s...%s\n", PERF_COLOR_BLUE, PERF_COLOR_RESET);
+			else
+				fprintf(fp, "...\n");
+		}
+		print_line_highlighted(fp, lines[i], line_lens[i]);
+		last_printed = i;
+	}
+
+	free(pick);
+	free(lines);
+	free(line_lens);
+}
+
 static void finish_test(struct child_test **child_tests, int running_test, int child_test_num,
 		int width)
 {
@@ -518,8 +709,10 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 		strbuf_release(&err_output);
 		err_output = merged;
 	}
-	if (verbose > 1 || (verbose == 1 && ret == TEST_FAIL))
+	if (verbose > 1)
 		fprintf(stderr, "%s", err_output.buf);
+	else if (verbose == 1 && ret == TEST_FAIL)
+		print_test_failure_snippet(stderr, err_output.buf);
 
 	strbuf_release(&err_output);
 	strbuf_release(&child_test->err_output);
@@ -731,8 +924,10 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 				}
 			}
 
-			if (verbose > 1 || (verbose == 1 && child->result == TEST_FAIL))
+			if (verbose > 1)
 				fprintf(stderr, "%s", child->err_output.buf);
+			else if (verbose == 1 && child->result == TEST_FAIL)
+				print_test_failure_snippet(stderr, child->err_output.buf);
 
 			print_test_result(child->test, child->suite_num, child->test_case_num,
 					  child->result, width, 0);
@@ -1075,6 +1270,8 @@ int cmd_test(int argc, const char **argv)
 	OPT_STRING(0, "dso", &dso_to_test, "dso", "dso to test"),
 	OPT_STRING(0, "objdump", &test_objdump_path, "path",
 		   "objdump binary to use for disassembly and annotations"),
+	OPT_UINTEGER(0, "failure-snippet-lines", &failure_snippet_lines,
+		     "Number of lines to include in failure snippet, default 10"),
 	OPT_END()
 	};
 	const char * const test_subcommands[] = { "list", NULL };
-- 
2.54.0.1013.g208068f2d8-goog

