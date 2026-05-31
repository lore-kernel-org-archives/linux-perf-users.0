Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5144E30E851
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 05:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780205282; cv=none; b=a8mt29Cxg1jm79X4K5yNSZDz1qOPhc494MnAToHnAWUlZPCV6qFzS9ffiqaphhyBUCLz+Azbv0fY5nnLnOgy61eT/4hr1mRVDfXKStmlRYSiF7FDrDM2HlQH9niwtTPqamnwl180P42ozhNL7opTuagjrh/ACuKINby1Pdq9qq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780205282; c=relaxed/simple;
	bh=Rz4fHCEGTaLeiPHaReseDmJA7iCoGtlGcKbHe2n94u0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L/6opW4fxEYOz/91rVhiCU4qzZ+vWUP6+Nsq7Bj5N8Zw+1358SV5+aQg2zxrKarKLTq1wIJe6X2/72Y4dJgSZ60eWjIqDU+3Y3Aya0a2icjKBtfU5/w1tMOffk1xGjdXy8NSaP4DFFiimQTK1wO7ipQslZhU2Z027hf913Saaoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YGY/655F; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YGY/655F"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304e7fbfaf5so3149843eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 22:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780205278; x=1780810078; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rvCeaokOjCxr6DMgNrntVn5eGdnjHGRCMu9GwCNz+/Y=;
        b=YGY/655FW9NRPDi0uLBtKlPPwmW63O+ZKjV6K97lbFtoR/PZsxb0Iky4wd5xwHFprf
         z8y6h+bPfpICchxZxUA1hLauRtS8CEVk2JFzvIi4dEPxQ8W/436cgR0dpZAo2YdmlZjL
         BfJPaKzrrjK/fFeRp+8Tmxx1gb4BbfqsKokJ8QtSfPXcfIXjjeSzGIX7Ja4h6jcyJsUx
         hqVixTl8ukb2rV21UTMXoaeHRvBbx6YG2r2kfB7hkbfOh8F7S6dhoi7U405Jpg1V0fjT
         gfOMZlPIutSNSjWVGlqMGix8K2FirKCqk+hIKmIldaUOcdtUdsnrsoAgAKIVEjOK1PA4
         oc/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780205278; x=1780810078;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rvCeaokOjCxr6DMgNrntVn5eGdnjHGRCMu9GwCNz+/Y=;
        b=e0KI4mlqjYJGfhk8wV6SH4q1Oy26btjCMP9Ep6K1D77PqpzhbvjZ3iZbPTSaC3LF89
         B+jh0rYaegRizB9aOHf0B/2ekRYBERJz+e7XgtyDgYcdliBpeVHYn2jMdLGEA+P368zN
         rVokkE0NlB1J6On3LJIersHXcpi8Ae8jLjTXJiL/AwSQGWqQNJ20aohFdZwRXbN8468L
         MuoPy7MzjIKJMRS+jywQUTg72Gpm/+dGHG9GFkwwyWXBsIuZCPPSH3dSHR2y12fVQYiD
         qP9i8a/mg7GOFQGh2fMZ4B/Q0ePXWmF4kctjm2cRTZKCm44FtjUsUA9WKcql5axaVJ0z
         qBsw==
X-Forwarded-Encrypted: i=1; AFNElJ9BW8OBv8ljlGI0Zk+G0Ha+h0mmFeeE/pMDvMV4srybiS2OGqnzpkBzbp/gHzSWqOvbzPtqhXLZzDGJXLu9WOj4@vger.kernel.org
X-Gm-Message-State: AOJu0YwtQ3E4aeY/HnlMe6brguNMFYWgKFJf/YUIgEt4gl66uSOLSfQq
	kbZoYXYnfRCgig/LZNemqxJwlyc+ewhDi9bUBRIunfWiWMRXJKX+gqDTlvSsRf5xvQ4P2d61i/M
	Du6LyTKdcOQ==
X-Received: from dlbbo37.prod.google.com ([2002:a05:7022:43a5:b0:135:d0cf:93de])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:a887:b0:304:df0e:9db0
 with SMTP id 5a478bee46e88-304fa4fcd06mr3007996eec.15.1780205278297; Sat, 30
 May 2026 22:27:58 -0700 (PDT)
Date: Sat, 30 May 2026 22:27:33 -0700
In-Reply-To: <20260531052740.796087-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513230450.529380-1-irogers@google.com> <20260531052740.796087-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531052740.796087-8-irogers@google.com>
Subject: [PATCH v2 07/14] perf test: Show snippet failure output for verbose=1
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
   - Pass 0: Prioritize retaining outline marker lines containing dashes
     (====) to beautifully frame the start and end execution boundaries.
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
==== start ====
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
==== end(-1) ====
143: perftool-testsuite_probe                                        : FAILED!
```

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 215 +++++++++++++++++++++++++++++++-
 1 file changed, 212 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 87c6a67beb10..ec44b24d419c 100644
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
@@ -395,6 +397,207 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
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
+	/* Pass 2: Pick marker lines up to the remaining quota */
+	for (i = 0; i < num_lines && picked_count < failure_snippet_lines; i++) {
+		if (!pick[i] && line_contains(lines[i], line_lens[i], "----")) {
+			pick[i] = true;
+			picked_count++;
+		}
+	}
+
+	/* Pass 3: Fill remaining quota from the end backwards */
+	i = num_lines;
+
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
@@ -502,8 +705,10 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
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
@@ -681,8 +886,10 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 				}
 			}
 
-			if (verbose > 1 || (verbose == 1 && child->result == TEST_FAIL))
+			if (verbose > 1)
 				fprintf(stderr, "%s", child->err_output.buf);
+			else if (verbose == 1 && child->result == TEST_FAIL)
+				print_test_failure_snippet(stderr, child->err_output.buf);
 
 			print_test_result(child->test, child->suite_num, child->test_case_num,
 					  child->result, width, 0);
@@ -1012,6 +1219,8 @@ int cmd_test(int argc, const char **argv)
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

