Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC172DF3DA
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 06:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294507; cv=none; b=cO8+VPMUwU9Yx1BAck5xSKIvl0z/27xXo7rXtYN0ppeKgSeoxjEbgzEecuYAJsLSFUcYvRfRqmDwtlDAjwlYFKGNdVzqxE+VNskPtEFNU7iUCN7LCkKp6eegBfFyrxV44TYufhis3GpHwJY2vaNmjluPQMxlnDPCnFKGM80gNTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294507; c=relaxed/simple;
	bh=D3kM3gDImil5pxAGwr3yerGk8mIeh8kvqTsdcZGAWks=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qeuq/9g4+mrj9IzzoxWd4nvHS+7nYkuVY488heSF5MP+oCHSbW1f9Yu6YmJekrsUWnhMh6Bc1s9TBmBglH69ZJ9ksHQMjr/GMnGaEA8k467PtB4qGqRPObBLRuat6Ij6s+8HOAO7Iya5n5jba+PaVVXhEGxTGXD4QR5ldY26lHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=maInYiXe; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="maInYiXe"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-137d003cf09so1949810c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 23:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780294504; x=1780899304; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IO9hSSDaD/0oS9Tujh/bVfShBf+nyjaOI9A7HAr7T5Q=;
        b=maInYiXePLcYb37AYNG/Erjvxs3/l3qh85WT1CLL+lkYV5IZxltSFFJ/h8I1xMCdE3
         zNun4A4ov1JCZ6skJnuLA41MRFFgqi4xWw9yLqIdVjrL5C7vGJxuTXHJn9Be0hGk1Pmt
         /XEmxXlINzFjlyXXMqn0v+Chlx9jRrNiB6+WaS+dyG/RTQ6BsTBbEMERkLDHitem1XrD
         QD/yLEAGa4EitBxYcLPwITiDK8rxyn9Qx3Dnl6f9hEIGqmxC4jIm5kJUc89D0w0d0uwz
         gEcDrhl82nAKgv0URbGz757ekFu6HDLi/jeidqyY9YueHy+RS4C23ciyANc3/TLgnHqI
         DeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780294504; x=1780899304;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IO9hSSDaD/0oS9Tujh/bVfShBf+nyjaOI9A7HAr7T5Q=;
        b=X66yQksrR92QYmDMss8yhUTjNnqMzc/TmHyy5oYootR/GbQKhzvnqwvv5gtGkvCymr
         nlCwbFMshaLLFcX4TLdrFFOlztteo/MYT/2U1bwBvCv92K//PyqogIr/RKGuoim3Ykra
         MQ7UmhFazQ03sNb6SM2dCS11lDPWT2L2DSrEtZ8O4gaefrbl8/qBfFx/xxH0pg37N9NK
         cJLGVlKx4hkHi/KYQafARDK/rXsAG/Vbih6NChnPgcCiUbUH6f3YLTgzwK0aGS4j/cPV
         Q0AnsfKuI+NPUjGjLgEJj0OG/0aCEYuE+BSFAFHJZGIO3oIzAFa0KL35g8GZLI98Aoe3
         r1dg==
X-Forwarded-Encrypted: i=1; AFNElJ9K5OrlBrDPD02cB+DbCHxDNtaTFuq9yr0SCtpVpIqQpgRjEQBjTkLq5tw7HCjcHOmM0EqewbvBcUhdFeld7oXx@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc159VE3OrHAXS6uHzcxL4sLkmO3t2oDeqp7rDIFHrF63mlFoK
	rJGyJSK2+MGzcmxEIywn3OjY45hSiTUNrMcTNfZDcTw0kbqdtxaS5VfudM8EWyJIVoBviTDd+1u
	UUuwcadg0+Q==
X-Received: from dlbrh9.prod.google.com ([2002:a05:7022:f309:b0:137:e606:67e4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:527:b0:135:dc82:85f7
 with SMTP id a92af1059eb24-137d3f1860fmr4105325c88.4.1780294503861; Sun, 31
 May 2026 23:15:03 -0700 (PDT)
Date: Sun, 31 May 2026 23:13:54 -0700
In-Reply-To: <20260601061401.1541457-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601000548.1195604-1-irogers@google.com> <20260601061401.1541457-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601061401.1541457-9-irogers@google.com>
Subject: [PATCH 08/15] perf test: Show snippet failure output for verbose=1
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Currently, when running tests in verbose mode (-v), if a test case fails,
the entire raw standard error buffer is dumped to stderr via
fprintf(stderr, "%s", child->err_output.buf). For tests that generate
massive amounts of debugging or logging output before dying, this results
in multi-page terminal dumps where highly critical diagnostic keywords
(error, fail, segv) are easily lost.

Implement a smart, bounded snippet string processor to improve failure
triaging:
1. Introduce a configurable quota limit static unsigned int
   failure_snippet_lines = 10; accessible via a new command-line option
   --failure-snippet-lines <N>.
2. Parse the raw error buffer dynamically into lines and run a three-pass
   extraction algorithm:
   - Pass 0: Always select the very first line of the log as an initial
     outline marker.
   - Pass 1: Scan forward from the top of the log to pick up to N lines
     that contain case-insensitive failure keywords (error, fail, segv,
     abort) to isolate the root cause. Automatically pull in the immediate
     subsequent line as highly-prioritized context. Allow adjacent matching
     lines to overlap without dropping context by evaluating keywords for all
     lines (e.g. when "Failed to report" is followed by "Error:").
   - Pass 2: If quota remains, scan backward from the absolute tail of
     the log to capture trailing crash or abort context.
3. Output the selected lines in their original chronological order,
   inserting a clear ... separator between non-contiguous line jumps.
4. Wrap matched failure keywords dynamically in bold red (PERF_COLOR_RED)
   to immediately draw the eye to failures.
5. Invoke the smart processor purely when verbose == 1 && ret == TEST_FAIL
   in both finish_test and finish_tests_parallel, leaving raw full-output
   dumping completely untouched when running highly verbose (-vv).

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 200 +++++++++++++++++++++++++++++++-
 1 file changed, 197 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 1ce7f596ad70..6d7b4a952e90 100644
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
@@ -400,6 +402,192 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
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
@@ -517,8 +705,10 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
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
@@ -715,8 +905,10 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 				}
 			}
 
-			if (verbose > 1 || (verbose == 1 && child->result == TEST_FAIL))
+			if (verbose > 1)
 				fprintf(stderr, "%s", child->err_output.buf);
+			else if (verbose == 1 && child->result == TEST_FAIL)
+				print_test_failure_snippet(stderr, child->err_output.buf);
 
 			print_test_result(child->test, child->suite_num, child->test_case_num,
 					  child->result, width, 0);
@@ -1052,6 +1244,8 @@ int cmd_test(int argc, const char **argv)
 	OPT_STRING(0, "dso", &dso_to_test, "dso", "dso to test"),
 	OPT_STRING(0, "objdump", &test_objdump_path, "path",
 		   "objdump binary to use for disassembly and annotations"),
+	OPT_UINTEGER(0, "failure-snippet-lines", &failure_snippet_lines,
+		     "Number of lines to include in failure snippet, default 10"),
 	OPT_END()
 	};
 	const char * const test_subcommands[] = { "list", NULL };
-- 
2.54.0.823.g6e5bcc1fc9-goog

