Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E5839B97B
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 23:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778713521; cv=none; b=WIvyRh9q9WIxmhZwrufQg469ZHGBV9K5Y5iGUCxT/O9yVj3NKaofoZln9JgzFA1lZMTKr4uGc8ROhTz/wY9MOS+04O5iAe0w4U3GZQAy4QN+QkZPIH5DNX6r6PqC32yny3ygBYwSNY/9nKrRSnC5L/H4YIsn5JTgBN4y4bBiN4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778713521; c=relaxed/simple;
	bh=dvZ+vPHTUTQbH0ciFo/1zVOVrB2n5G2UVg4cVRCLlvE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oP4K1iTW6uGAid1t3W3Cd7a1W8dPYKdiHRJgzWskW5k9HGjE/yLAPfwN9aKmBEOkFXrsdBAtPO7rt6J561ZNqOOJp6h4jt2OLKKo1zOHYO4OdvMxkQX9fHQM4stMKX+T9gCu8fHiGMQ9lSY9kYGSKGfcTGy61E3KgKQb5PmSzL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ktpb1AJg; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ktpb1AJg"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-134cf343c58so643097c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 16:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778713519; x=1779318319; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tnIv39NW9TMrvcc9Vv1d2kKFshX+SLgDVKAaZCE0MXo=;
        b=ktpb1AJgy3yeFAvvQVHv8gePo1TokP87g10foOHW1rwuYMSOtJKnu0RC4ZTJbtmBV9
         hGrWjW/UflNJeYVM/UWZkZ4r8sazVF+F8OUvPO+FXVoV5bpx3V4VHw5pABW4r0yGxhl9
         gpGZOrSyTbKsNo9847dU7xBj2JbKAGAuk4WkX8baTkmotDrBPPzyaJXOj6jlyb6B7Pie
         2XMKEAtwGU1ge45K/VxmPMcWZdNKYPsBT8X4jFKd0u643+3YFKIqdg7lOEMY3ROPSAE9
         sK1AdIDTk87pcYnrd0ZbQ9ef/4aiXd/0H+hNmIvhepsb19AfDn7KvtHoNFvCTN7jhhBK
         3ysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778713519; x=1779318319;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tnIv39NW9TMrvcc9Vv1d2kKFshX+SLgDVKAaZCE0MXo=;
        b=ZJAnCH5sd1CSfLl0egCq3GYzhEin3BFXW1Nw4xyyKUODm/ZbhG0wctQkyQAwxCxYeu
         g0rj57PNq/UTqD6LOyfIYMW/UowJJHHqXYTey5BgTIi/FRB8fFfjschUTLNSxIkHmwZw
         sGLkrIosdkuHiSz4a6UhSRFBWAIRBW8eudG7re7Fq+Seak2x+jUgS/64MS3Hy0t4herG
         m/A+OQAGBlVoQaWo6pYVfUC2T1+nxceRM0dUqSQPTl7Y522wy774szNn++x/zlMvfz2L
         6wYBuaa75EmFygclCLsLKWl4QeGbydFePSWP3Dgrnbxf3jz/5AyduCqKKr5nfqIAS12d
         ClqQ==
X-Forwarded-Encrypted: i=1; AFNElJ8nYCuMxdImL9vCAziMCNMufCRyTqbZ/POhpT1pQjRSj/URUgIzZmjmFoLf9bnIj6wqCtHP1DNqRz+vU5MH4hIr@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1BGGZrQAzFpP+9/WzmpLFVRuyGmT1Q2m8vlfI7a4lYePT6KuO
	DpdngOn6uN1PwAMFNqk2zQomarb5ZAv+lJuhNTqoSssNJ8s4mkoeptvPWOAc6/kxxGmICVwCLr6
	662liSHz2xw==
X-Received: from dlai21.prod.google.com ([2002:a05:701b:2715:b0:132:9fc5:59aa])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:21e:b0:12c:34b9:61bc
 with SMTP id a92af1059eb24-1342ee3a02emr3317913c88.5.1778713518681; Wed, 13
 May 2026 16:05:18 -0700 (PDT)
Date: Wed, 13 May 2026 16:04:43 -0700
In-Reply-To: <20260513230450.529380-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513230450.529380-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513230450.529380-8-irogers@google.com>
Subject: [PATCH v1 07/14] perf test: Show snippet failure output for verbose=1
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
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
   - Pass 0: Prioritize retaining outline marker lines containing dashes
     (----) to beautifully frame the start and end execution boundaries.
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

Example output:
```
---- start ----
...
-- [ FAIL ] -- perf_probe :: test_adding_kernel :: listing added probe :: perf probe -l (output regexp parsing)
-- [ PASS ] -- perf_probe :: test_adding_kernel :: using added probe
...
-- [ FAIL ] -- perf_probe :: test_adding_kernel :: wildcard adding support (command exitcode + output regexp parsing)
Regexp not found: "somenonexistingrandomstuffwhichisalsoprettylongorevenlongertoexceed64"
...
-- [ FAIL ] -- perf_probe :: test_adding_kernel :: non-existing variable (output regexp parsing)
-- [ PASS ] -- perf_probe :: test_adding_kernel :: function with retval :: add
...
-- [ SKIP ] -- perf_probe :: test_basic :: help message :: testcase skipped
...
---- end(-1) ----
143: perftool-testsuite_probe                                        : FAILED!
```

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 218 +++++++++++++++++++++++++++++++-
 1 file changed, 215 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index ad1b941731ca..45c1afb9ad33 100644
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
 
@@ -343,7 +345,7 @@ static int run_test_child(struct child_process *process)
 	for (size_t i = 0; i < ARRAY_SIZE(signals); i++)
 		signal(signals[i], child_test_sig_handler);
 
-	pr_debug("--- start ---\n");
+	pr_debug("---- start ----\n");
 	pr_debug("test child forked, pid %d\n", getpid());
 	err = test_function(child->test, child->test_case_num)(child->test, child->test_case_num);
 	pr_debug("---- end(%d) ----\n", err);
@@ -394,6 +396,210 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
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
+static bool line_contains(const char *line, size_t len, const char *tok)
+{
+	size_t tok_len = strlen(tok);
+	const char *s = line;
+
+	while ((size_t)(s - line) + tok_len <= len) {
+		if (memcmp(s, tok, tok_len) == 0)
+			return true;
+		s++;
+	}
+	return false;
+}
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
+	/* Pass 0: Unconditionally pick marker lines */
+	for (i = 0; i < num_lines; i++) {
+		if (line_contains(lines[i], line_lens[i], "----")) {
+			pick[i] = true;
+			if (picked_count < failure_snippet_lines)
+				picked_count++;
+		}
+	}
+
+	/* Pass 1: Pick lines with failure keywords from start */
+	for (i = 0; i < num_lines && picked_count < failure_snippet_lines; i++) {
+		size_t dummy;
+
+		if (find_next_keyword(lines[i], line_lens[i], &dummy)) {
+			if (!pick[i]) {
+				pick[i] = true;
+				picked_count++;
+			}
+			/* Prioritize getting the next line for context */
+			if (i + 1 < num_lines && !pick[i + 1] &&
+			    picked_count < failure_snippet_lines) {
+				pick[i + 1] = true;
+				picked_count++;
+			}
+		}
+	}
+
+	/* Pass 2: Fill remaining quota from the end backwards */
+	if (picked_count < failure_snippet_lines) {
+		size_t j = num_lines;
+
+		while (j > 0 && picked_count < failure_snippet_lines) {
+			j--;
+			if (!pick[j]) {
+				pick[j] = true;
+				picked_count++;
+			}
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
@@ -501,8 +707,10 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 	}
 	/* Clean up child process. */
 	ret = finish_command(&child_test->process);
-	if (verbose > 1 || (verbose == 1 && ret == TEST_FAIL))
+	if (verbose > 1)
 		fprintf(stderr, "%s", err_output.buf);
+	else if (verbose == 1 && ret == TEST_FAIL)
+		print_test_failure_snippet(stderr, err_output.buf);
 
 	strbuf_release(&err_output);
 	print_test_result(t, curr_suite, curr_test_case, ret, width, /*running=*/0);
@@ -675,8 +883,10 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 				}
 			}
 
-			if (verbose > 1 || (verbose == 1 && child->result == TEST_FAIL))
+			if (verbose > 1)
 				fprintf(stderr, "%s", child->err_output.buf);
+			else if (verbose == 1 && child->result == TEST_FAIL)
+				print_test_failure_snippet(stderr, child->err_output.buf);
 
 			print_test_result(child->test, child->suite_num, child->test_case_num,
 					  child->result, width, 0);
@@ -1004,6 +1214,8 @@ int cmd_test(int argc, const char **argv)
 	OPT_STRING(0, "dso", &dso_to_test, "dso", "dso to test"),
 	OPT_STRING(0, "objdump", &test_objdump_path, "path",
 		   "objdump binary to use for disassembly and annotations"),
+	OPT_UINTEGER(0, "failure-snippet-lines", &failure_snippet_lines,
+		     "Number of lines to include in failure snippet, default 10"),
 	OPT_END()
 	};
 	const char * const test_subcommands[] = { "list", NULL };
-- 
2.54.0.563.g4f69b47b94-goog

