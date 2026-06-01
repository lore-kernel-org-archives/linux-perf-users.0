Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DB25733E
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 00:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780272391; cv=none; b=McfGNgIcsKbiYz9gkAZddIUfzbd+EB+0YYynfrt2cbm+gj/FpiM2TIkhsenpOwXbrKrpjijzzfFHKiukVf6HMaTucN5sQLwWQ4evUmLXLlSvE8Fk1YxvdHRPUoxAY+nO8WUz9LKP5/PST/q3DVnwhPQEpzvhh205S+BBqhEDVbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780272391; c=relaxed/simple;
	bh=PyzCx5r+VhBlyfK47PQQdei6W72n0NNI00GKgnCrqJQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GA7Tv3B+iGXdGNMQwUT122kfcDdOsLfMifamElk1svU4IgU1291R2tPagTy7EKzJevD01jy8Zh5Qw7b8OOylRmIoUOrrrDtoes1RvUaVT5A4rXmD2iKVshQNTupnKeEC0rDk3rSrQ1HzSj2CXjgWx51VuW/cix9eeyO3WiN7QuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=huMLR+r1; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="huMLR+r1"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137731eae44so14404125c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 17:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780272383; x=1780877183; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0IsK/qykYrqKKE0Zvr6wnPXW5URIji97DP2+h6jcxFk=;
        b=huMLR+r1TEijFiKRa1QpMsFWfqIHbnRwc6f0s0Zzhl1Bt1tbqW5n7d5aM92s83EUgz
         ysno/KdObzAJdbby+UCvkjlq6Sm6ka0mhiAtPkLOrla+TOBxwycINPIRuXai47h/4Sm6
         +MswEzcnO3K8ZB0K7BWJE+G0ZH5s9q6bNLzZpZ2JFjVxVnOzV6RfYVyNcPkw88ILGl/4
         0fqvEzx7qvoDJcdmuZn31O4JXx7iYfMpo7AzPnLVQMfj+3kb1bYUn2ULK/dBIeOgW/KR
         NEUbPyItTMd/03LTxgbxI4e2AZD8kYC1haKEGZts9ZmW+wbNmBZ22gS215F5k+W0SN8F
         x2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780272383; x=1780877183;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0IsK/qykYrqKKE0Zvr6wnPXW5URIji97DP2+h6jcxFk=;
        b=iF1uuZ0Dm1cBK2xfdoLnCJ2ZbiBsyAz9Mo4IIgcG0ba+PBDcBRPisJI9IjXsmxbdWW
         8qB4XfC7LhTjUSsnYykuX23WyBy3xaiKpdtw0uMemNZFtReRmZUWGFqPo6Xa7iR6b2hx
         LjmYZrqoQu61flKvx2IIBP9cHYfNlpJFm6Kf9mF7nk9JCZLNVtFknWBapngNG25EGs66
         g0Wd05n92xyHmT4KcRIQKwXlYpGK9cJ8CweLht98GPIeOBlFAZ39WtPhYggJjynJzLaZ
         TzqyOfdduUPfxcuO1qNQxFbY3sjYyYVfTiKJrh3UgZ1mNwM91IhUbiBsD5T2wP92ns3H
         oWqg==
X-Forwarded-Encrypted: i=1; AFNElJ/NAjFlzWcjIyityHTXuD3psLx/KadoClFhvKeR9ZAf+5v6mrmu7ANQ5O99rpOnuqUql0c2HTVWqM+G2ziP0TaK@vger.kernel.org
X-Gm-Message-State: AOJu0YxkGG0KRVUhf2EwFTa4zi8ciqePdYdRoHtIK+ynnf871Mkt3SAx
	X4PjP+q/MSv0fH6DotqavKLGZuplP4dcYzab0hJf3fcEYkChPKKVF2+UcIXYdn3nyOYi5qVDNsH
	7GMeAQrkLgw==
X-Received: from dlan21-n1.prod.google.com ([2002:a05:7022:eb55:10b0:135:5b92:ee65])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3b83:b0:135:dd5a:b99b
 with SMTP id a92af1059eb24-137d42c37e4mr2783567c88.40.1780272382808; Sun, 31
 May 2026 17:06:22 -0700 (PDT)
Date: Sun, 31 May 2026 17:05:46 -0700
In-Reply-To: <20260601000548.1195604-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531082235.940833-1-irogers@google.com> <20260601000548.1195604-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601000548.1195604-14-irogers@google.com>
Subject: [PATCH 13/15] perf test: Add -j/--junit option for JUnit XML test reports
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Add a -j/--junit command line option to generate standard JUnit XML format
test reports. The generated file defaults to 'test.xml' if no filename is
specified, but allows users to override the path (e.g. -jmytest.xml).

The XML report captures individual test suite and subtest execution latency,
alongside XML-escaped failure logs and skip reasons, while preserving the
full multi-process concurrency speed of parallel test execution.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 152 ++++++++++++++++++++++++++++++--
 1 file changed, 145 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 4c0caa8d0b27..1c1e77e19a0a 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -19,6 +19,7 @@
 #include <dirent.h>
 #include <sys/wait.h>
 #include <sys/stat.h>
+#include <sys/time.h>
 #include "builtin.h"
 #include "config.h"
 #include "hist.h"
@@ -39,6 +40,9 @@
 
 #include "tests-scripts.h"
 
+static const char *junit_filename;
+static struct strbuf junit_xml_buf = STRBUF_INIT;
+
 /*
  * Command line option to not fork the test running in the same process and
  * making them easier to debug.
@@ -307,6 +311,8 @@ struct child_test {
 	struct strbuf err_output;
 	int result;
 	bool done;
+	struct timespec start_time;
+	struct timespec end_time;
 };
 
 static jmp_buf run_test_jmp_buf;
@@ -369,8 +375,34 @@ static unsigned int summary_tests_skipped;
 static unsigned int summary_tests_failed;
 static struct strbuf summary_failed_tests_buf = STRBUF_INIT;
 
+static char *xml_escape(const char *str)
+{
+	struct strbuf buf = STRBUF_INIT;
+	const char *p;
+	char *res;
+
+	if (!str)
+		return strdup("");
+
+	for (p = str; *p; p++) {
+		if (*p == '&')
+			strbuf_addstr(&buf, "&amp;");
+		else if (*p == '<')
+			strbuf_addstr(&buf, "&lt;");
+		else if (*p == '>')
+			strbuf_addstr(&buf, "&gt;");
+		else if (*p == '"')
+			strbuf_addstr(&buf, "&quot;");
+		else if ((unsigned char)*p >= 32 || *p == '\n' || *p == '\t')
+			strbuf_addch(&buf, *p);
+	}
+	res = strbuf_detach(&buf, NULL);
+	return res ? res : strdup("");
+}
+
 static int print_test_result(struct test_suite *t, int curr_suite, int curr_test_case,
-			     int result, int width, int running)
+			     int result, int width, int running,
+			     const char *err_output, double elapsed)
 {
 	if (test_suite__num_test_cases(t) > 1) {
 		char prefix[32];
@@ -418,6 +450,34 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
 		break;
 	}
 
+	if (junit_filename && result != TEST_RUNNING) {
+		const char *classname = t->desc;
+		const char *testname = test_description(t, curr_test_case);
+		char *escaped_err = xml_escape(err_output);
+		char *escaped_class = xml_escape(classname);
+		char *escaped_test = xml_escape(testname);
+
+		strbuf_addf(&junit_xml_buf,
+			    "    <testcase classname=\"%s\" name=\"%s\" time=\"%.2f\">\n",
+			    escaped_class, escaped_test, elapsed);
+		if (result == TEST_FAIL) {
+			strbuf_addf(&junit_xml_buf,
+				    "      <failure message=\"FAILED\">\n%s\n      </failure>\n",
+				    escaped_err);
+		} else if (result == TEST_SKIP) {
+			const char *reason = skip_reason(t, curr_test_case);
+			char *escaped_reason = xml_escape(reason ? reason : "Skip");
+
+			strbuf_addf(&junit_xml_buf, "      <skipped message=\"%s\"/>\n",
+				    escaped_reason);
+			free(escaped_reason);
+		}
+		strbuf_addstr(&junit_xml_buf, "    </testcase>\n");
+		free(escaped_err);
+		free(escaped_class);
+		free(escaped_test);
+	}
+
 	return 0;
 }
 
@@ -617,6 +677,8 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 	struct strbuf err_output = STRBUF_INIT;
 	int last_running = -1;
 	int ret;
+	struct timespec end_time;
+	double elapsed;
 
 	if (child_test == NULL) {
 		/* Test wasn't started. */
@@ -670,7 +732,7 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 					fprintf(debug_file(), PERF_COLOR_DELETE_LINE);
 				}
 				print_test_result(t, curr_suite, curr_test_case, TEST_RUNNING,
-						  width, running);
+						  width, running, NULL, 0.0);
 				last_running = running;
 			}
 		}
@@ -719,9 +781,14 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 	else if (verbose == 1 && ret == TEST_FAIL)
 		print_test_failure_snippet(stderr, err_output.buf);
 
+	clock_gettime(CLOCK_MONOTONIC, &end_time);
+	elapsed = (end_time.tv_sec - child_test->start_time.tv_sec) +
+		  (end_time.tv_nsec - child_test->start_time.tv_nsec) / 1000000000.0;
+
+	print_test_result(t, curr_suite, curr_test_case, ret, width, /*running=*/0,
+			  err_output.buf, elapsed);
 	strbuf_release(&err_output);
 	strbuf_release(&child_test->err_output);
-	print_test_result(t, curr_suite, curr_test_case, ret, width, /*running=*/0);
 	if (err > 0)
 		close(err);
 	zfree(&child_tests[running_test]);
@@ -815,7 +882,7 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 				}
 				print_test_result(next_child->test, next_child->suite_num,
 						  next_child->test_case_num, TEST_RUNNING, width,
-						  running_count);
+						  running_count, NULL, 0.0);
 			}
 			last_running = running_count;
 		}
@@ -862,12 +929,14 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 					child->process.err = -1;
 				}
 				child->result = finish_command(&child->process);
+				clock_gettime(CLOCK_MONOTONIC, &child->end_time);
 				child->done = true;
 			}
 		}
 
 		while (next_to_print < num_tests) {
 			struct child_test *child = child_tests[next_to_print];
+			double elapsed;
 
 			if (!child) {
 				next_to_print++;
@@ -905,8 +974,12 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 			else if (verbose == 1 && child->result == TEST_FAIL)
 				print_test_failure_snippet(stderr, child->err_output.buf);
 
+			elapsed = (child->end_time.tv_sec - child->start_time.tv_sec) +
+				  (child->end_time.tv_nsec -
+				   child->start_time.tv_nsec) / 1000000000.0;
+
 			print_test_result(child->test, child->suite_num, child->test_case_num,
-					  child->result, width, 0);
+					  child->result, width, 0, child->err_output.buf, elapsed);
 			strbuf_release(&child->err_output);
 			child_tests[next_to_print] = NULL;
 			zfree(&child);
@@ -929,11 +1002,18 @@ static int start_test(struct test_suite *test, int curr_suite, int curr_test_cas
 	*child = NULL;
 	if (dont_fork) {
 		if (pass == 1) {
+			struct timespec start_time, end_time;
+			double elapsed;
+
+			clock_gettime(CLOCK_MONOTONIC, &start_time);
 			pr_debug("--- start ---\n");
 			err = test_function(test, curr_test_case)(test, curr_test_case);
 			pr_debug("---- end ----\n");
+			clock_gettime(CLOCK_MONOTONIC, &end_time);
+			elapsed = (end_time.tv_sec - start_time.tv_sec) +
+				  (end_time.tv_nsec - start_time.tv_nsec) / 1000000000.0;
 			print_test_result(test, curr_suite, curr_test_case, err, width,
-					  /*running=*/0);
+					  /*running=*/0, NULL, elapsed);
 		}
 		return 0;
 	}
@@ -963,6 +1043,7 @@ static int start_test(struct test_suite *test, int curr_suite, int curr_test_cas
 		(*child)->process.err = -1;
 	}
 	(*child)->process.no_exec_cmd = run_test_child;
+	clock_gettime(CLOCK_MONOTONIC, &(*child)->start_time);
 	if (sequential || pass == 2) {
 		err = start_command(&(*child)->process);
 		if (err)
@@ -998,6 +1079,41 @@ static void print_tests_summary(void)
 	} else {
 		color_fprintf(stderr, PERF_COLOR_GREEN, "Failed tests      : 0\n");
 	}
+
+	if (junit_filename) {
+		int fd;
+		FILE *fp;
+
+		fd = open(junit_filename, O_CREAT | O_TRUNC | O_WRONLY | O_NOFOLLOW, 0644);
+		if (fd >= 0) {
+			fp = fdopen(fd, "w");
+			if (fp) {
+				unsigned int total = summary_tests_passed +
+						     summary_subtests_passed +
+						     summary_tests_skipped +
+						     summary_tests_failed;
+				fprintf(fp, "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n");
+				fprintf(fp, "<testsuites>\n");
+				fprintf(fp, "  <testsuite name=\"perf-tests\" tests=\"%u\" "
+					"failures=\"%u\" skipped=\"%u\">\n",
+					total, summary_tests_failed,
+					summary_tests_skipped);
+				fprintf(fp, "%s", junit_xml_buf.buf);
+				fprintf(fp, "  </testsuite>\n");
+				fprintf(fp, "</testsuites>\n");
+				fclose(fp);
+				pr_info("Wrote junit XML output to %s\n", junit_filename);
+			} else {
+				close(fd);
+				pr_err("Failed to associate stream with fd for %s: %s\n",
+				       junit_filename, strerror(errno));
+			}
+		} else {
+			pr_err("Failed to open %s for writing junit XML output: %s\n",
+			       junit_filename, strerror(errno));
+		}
+	}
+	strbuf_release(&junit_xml_buf);
 	strbuf_release(&summary_failed_tests_buf);
 }
 
@@ -1081,8 +1197,28 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 				if (pass == 1) {
 					pr_info("%3d: %-*s:", curr_suite + 1, width,
 						test_description(*t, -1));
-					color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (user override)\n");
+					color_fprintf(stderr, PERF_COLOR_YELLOW,
+						      " Skip (user override)\n");
 					summary_tests_skipped++;
+					if (junit_filename) {
+						char *escaped_class =
+							xml_escape((const char *)test_description(*t, -1));
+						char *escaped_test = xml_escape("override");
+						char *escaped_reason =
+							xml_escape("user override");
+
+						strbuf_addf(&junit_xml_buf,
+							"    <testcase classname=\"%s\" "
+							"name=\"%s\" time=\"0.000\">\n",
+							escaped_class, escaped_test);
+						strbuf_addf(&junit_xml_buf,
+							"      <skipped message=\"%s\"/>\n",
+							escaped_reason);
+						strbuf_addstr(&junit_xml_buf, "    </testcase>\n");
+						free(escaped_reason);
+						free(escaped_test);
+						free(escaped_class);
+					}
 				}
 				continue;
 			}
@@ -1262,6 +1398,8 @@ int cmd_test(int argc, const char **argv)
 		   "objdump binary to use for disassembly and annotations"),
 	OPT_UINTEGER(0, "failure-snippet-lines", &failure_snippet_lines,
 		     "Number of lines to include in failure snippet, default 10"),
+	OPT_STRING_OPTARG('j', "junit", &junit_filename, "file",
+			  "Generate junit XML output, default test.xml", "test.xml"),
 	OPT_END()
 	};
 	const char * const test_subcommands[] = { "list", NULL };
-- 
2.54.0.823.g6e5bcc1fc9-goog

