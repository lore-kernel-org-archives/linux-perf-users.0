Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DBA3C9896
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 23:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778713532; cv=none; b=KJ6llAmgdShT4oP+DhL4lalXBdYGHrtQwM6qACLuJxyhsoISbbtv5qmqM4LWdPZlQvn78ESKctFhEORFQ2t7t74r0DavFim0bBp8V1KJDS/fp7jjWWb6rxxYDoDZtvFXcXuTA6P9kHC28yrp/DMnvCS7hVBilFAH/Q7869UmChM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778713532; c=relaxed/simple;
	bh=XRim+fJ6OqRcuvmQ3+YwAlQT8aOkGR1Kves1qhvoDVs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i/pA/xDNeFCGbzPwElT5ziDScToDJyrbguk4/l/T1RWRym//FoUZQwJ/aTsxOn+rmO1Ght8EJqfi9/omFALPYEu9yuWEDsuVkYNbWHffk2Amhg0LYpWqknLfWaB6feiwXePVlcoYpKUrIebPXLf9W9fPl8dDQUeHwKXo4dWT0BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IwBuwcPB; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IwBuwcPB"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c16233ee11so9887105eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 16:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778713529; x=1779318329; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ow7tEvI0EJMFX4mHRYCbILp0FVB4qgqzZjfyrrhisoM=;
        b=IwBuwcPBBgh/bGsSZgnrL17lfmvQ3nNDYsZrYtKUWBq1C9nNyUd3V+jo/RX/L2lDyk
         a2Ke9ZBBV4XADUtNJ2HDk259Xl7mZIAiDkodW5X0LSdQA9hlNMJsKNQsvz4HJYqTw5DP
         m4iIqVUGsq01sBD+E9hFkZ+IN8vVcWx31xs7yM38k8GJJy4seRkWcX/7jMKUHU8690Jg
         KKnxLsCtJZbdmxT1DQamzmutfC9T5JyyVuQ5GaIS1BEFmilJf893UwaWHCdvAZf9Rp3T
         aOyTy/+P6fywqzf4qY09fklrhOuw9vGJ9bAWgET2n3JT3xBjX3IV6poLaaArFTTPWi4U
         Cqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778713529; x=1779318329;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ow7tEvI0EJMFX4mHRYCbILp0FVB4qgqzZjfyrrhisoM=;
        b=glmxuQQI4WjPJDwrg7VAHl+YgHmM2fADNUfZokvPW1Krd3y8K5lgk8Gkr9EzlGaQ6k
         Knbz/ci4vCGeFL/j/Rjwpf5oArMsp4diSlDENEXOUMAFZAkECKD2+hndKW7aCm2eheZK
         BrhrHH/hWWAf+v5h+UYZ71C2M1mqciFzIs609xsCWw3SlSoHPM3jjNhFZTITffK2jL6r
         8uAbZoGjpY2TJQo/FaGIeSVELjnViLcNJtF8TJNug8+CBJrLGU236p5+tlqfeBAvuALJ
         wanIx6v4VFFVNjIzPzE2kP39zXhfBvVv2aBa4pZ7qmSmSFYIp4KuSq9vE8Ny7imtijYf
         X/Eg==
X-Forwarded-Encrypted: i=1; AFNElJ8zZaM8OCGfuXj4pLiaywgsavtPXnxdi0AzJkL8vrEmZRvHFxBxvW5YsJbhAdQyyCRFd8W5Lx9zzpgrcCOj1Q8t@vger.kernel.org
X-Gm-Message-State: AOJu0YwP4hrtgt5n1IjByTuM96axVSI+H5QH7cgqVv046Xs7ExvNbjJL
	59lXIlS1vBE04zfnGpqIoE935nvEl5ybDfEsYf12ci0vlp//9wBKNHmOA8EtWQ2tERiPMvApS+m
	igiUQ67UpSQ==
X-Received: from dlea18-n2.prod.google.com ([2002:a05:701b:4212:20b0:12c:211d:3e86])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f8f:b0:132:ac76:9772
 with SMTP id a92af1059eb24-13436ba5882mr3201004c88.34.1778713528490; Wed, 13
 May 2026 16:05:28 -0700 (PDT)
Date: Wed, 13 May 2026 16:04:48 -0700
In-Reply-To: <20260513230450.529380-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513230450.529380-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513230450.529380-13-irogers@google.com>
Subject: [PATCH v1 12/14] perf test: Add -j/--junit option for JUnit XML test reports
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
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
 tools/perf/tests/builtin-test.c | 116 ++++++++++++++++++++++++++++++--
 1 file changed, 110 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 765724817776..99f5afba1082 100644
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
@@ -306,6 +310,8 @@ struct child_test {
 	struct strbuf err_output;
 	int result;
 	bool done;
+	struct timespec start_time;
+	struct timespec end_time;
 };
 
 static jmp_buf run_test_jmp_buf;
@@ -366,8 +372,34 @@ static unsigned int summary_tests_skipped;
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
+		else if (*p >= 32 || *p == '\n' || *p == '\t')
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
@@ -414,6 +446,33 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
 		break;
 	}
 
+	if (junit_filename && result != TEST_RUNNING) {
+		const char *classname = t->desc;
+		const char *testname = test_description(t, curr_test_case);
+		char *escaped_err = xml_escape(err_output);
+		char *escaped_class = xml_escape(classname);
+		char *escaped_test = xml_escape(testname);
+
+		strbuf_addf(&junit_xml_buf, "    <testcase classname=\"%s\" name=\"%s\" time=\"%.2f\">\n",
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
 
@@ -631,6 +690,8 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 	struct strbuf err_output = STRBUF_INIT;
 	int last_running = -1;
 	int ret;
+	struct timespec end_time;
+	double elapsed;
 
 	if (child_test == NULL) {
 		/* Test wasn't started. */
@@ -684,7 +745,7 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 					fprintf(debug_file(), PERF_COLOR_DELETE_LINE);
 				}
 				print_test_result(t, curr_suite, curr_test_case, TEST_RUNNING,
-						  width, running);
+						  width, running, NULL, 0.0);
 				last_running = running;
 			}
 		}
@@ -733,8 +794,13 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 	else if (verbose == 1 && ret == TEST_FAIL)
 		print_test_failure_snippet(stderr, err_output.buf);
 
+	clock_gettime(CLOCK_MONOTONIC, &end_time);
+	elapsed = (end_time.tv_sec - child_test->start_time.tv_sec) +
+		  (end_time.tv_nsec - child_test->start_time.tv_nsec) / 1000000000.0;
+
+	print_test_result(t, curr_suite, curr_test_case, ret, width, /*running=*/0,
+			  err_output.buf, elapsed);
 	strbuf_release(&err_output);
-	print_test_result(t, curr_suite, curr_test_case, ret, width, /*running=*/0);
 	if (err > 0)
 		close(err);
 	zfree(&child_tests[running_test]);
@@ -830,7 +896,7 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 				}
 				print_test_result(next_child->test, next_child->suite_num,
 						  next_child->test_case_num, TEST_RUNNING, width,
-						  running_count);
+						  running_count, NULL, 0.0);
 			}
 			last_running = running_count;
 		}
@@ -866,12 +932,14 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
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
@@ -909,8 +977,11 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 			else if (verbose == 1 && child->result == TEST_FAIL)
 				print_test_failure_snippet(stderr, child->err_output.buf);
 
+			elapsed = (child->end_time.tv_sec - child->start_time.tv_sec) +
+				  (child->end_time.tv_nsec - child->start_time.tv_nsec) / 1000000000.0;
+
 			print_test_result(child->test, child->suite_num, child->test_case_num,
-					  child->result, width, 0);
+					  child->result, width, 0, child->err_output.buf, elapsed);
 			strbuf_release(&child->err_output);
 			child_tests[next_to_print] = NULL;
 			zfree(&child);
@@ -931,11 +1002,18 @@ static int start_test(struct test_suite *test, int curr_suite, int curr_test_cas
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
@@ -965,6 +1043,7 @@ static int start_test(struct test_suite *test, int curr_suite, int curr_test_cas
 		(*child)->process.err = -1;
 	}
 	(*child)->process.no_exec_cmd = run_test_child;
+	clock_gettime(CLOCK_MONOTONIC, &(*child)->start_time);
 	if (sequential || pass == 2) {
 		err = start_command(&(*child)->process);
 		if (err)
@@ -999,6 +1078,29 @@ static void print_tests_summary(void)
 	} else {
 		color_fprintf(stderr, PERF_COLOR_GREEN, "Failed tests      : 0\n");
 	}
+
+	if (junit_filename) {
+		FILE *fp;
+
+		fp = fopen(junit_filename, "w");
+		if (fp) {
+			unsigned int total = summary_tests_passed + summary_subtests_passed +
+					     summary_tests_skipped + summary_tests_failed;
+			fprintf(fp, "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n");
+			fprintf(fp, "<testsuites>\n");
+			fprintf(fp, "  <testsuite name=\"perf-tests\" tests=\"%u\" failures=\"%u\" skipped=\"%u\">\n",
+				total, summary_tests_failed, summary_tests_skipped);
+			fprintf(fp, "%s", junit_xml_buf.buf);
+			fprintf(fp, "  </testsuite>\n");
+			fprintf(fp, "</testsuites>\n");
+			fclose(fp);
+			pr_info("Wrote junit XML output to %s\n", junit_filename);
+		} else {
+			pr_err("Failed to open %s for writing junit XML output: %s\n",
+			       junit_filename, strerror(errno));
+		}
+	}
+	strbuf_release(&junit_xml_buf);
 	strbuf_release(&summary_failed_tests_buf);
 }
 
@@ -1256,6 +1358,8 @@ int cmd_test(int argc, const char **argv)
 		   "objdump binary to use for disassembly and annotations"),
 	OPT_UINTEGER(0, "failure-snippet-lines", &failure_snippet_lines,
 		     "Number of lines to include in failure snippet, default 10"),
+	OPT_STRING_OPTARG('j', "junit", &junit_filename, "file",
+			  "Generate junit XML output, default test.xml", "test.xml"),
 	OPT_END()
 	};
 	const char * const test_subcommands[] = { "list", NULL };
-- 
2.54.0.563.g4f69b47b94-goog

