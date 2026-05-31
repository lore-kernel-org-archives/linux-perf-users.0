Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFE7349B15
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 06:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780209497; cv=none; b=htesBpo1Ws8iZvV5s0Em4OsA//tOrOYEW9GKoSDwMP4rAqWk23zQfP0OTvNDtZAGl0uNA26UEeASc/e6CijuqRnlpmikmpndhWljYpfetqb0wL6ndY9h4LBCDpd5tHWlCQUdjoQVMlvSg7MruwLoXl2gqt6feUPw0S23Yw17QBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780209497; c=relaxed/simple;
	bh=ak/hw09StGYNc5jRQ2eWE+nFI5Dv2QpvkpDIgghCYv8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rHSTAvEIEwe7DkxO1M4iHlze3P9ZC0dnQZHEtSZkdz0C1etxhqPLQxOJlvHrxSS3M9uoucF2lGtU02ThCdEM9ZjnAerDpC9nu9OilUaMkt2FZeeN/H/PMcT7hPJLEDPfc1zZkJ4q01yoqcWjgIKvjlWhaZwxbIavtlzoAnPSm9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OhU9sjid; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OhU9sjid"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304e7fc90b1so2330538eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 23:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780209494; x=1780814294; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0HOM05LT1lE7kNZx1pI35EyeXWl+aeg39mCX+QoYTrs=;
        b=OhU9sjid+Be6JSGrtjMZklEjuCj7Sz8NnqTdHWln/5pEdqSiYXxhjyB+PJSKN4sjuX
         vlWS60WWYIeUhFi7KlvkYc2vk6fgvTKmxU0Jp5Q2zeKhLlfaGboQEOfFPmwSryzeDFUY
         5cnj5RvOFoOvYV3AAWLIMr8ETagIfEXXkSmp4Qd2sx3R8k/zlNoZR3MzZLVDEt+Rbs/6
         1aonltNTRIWx6ER/weMzgL/R/BAv5R+69CiVEXZkCEr8Izn4C4rkmvIvZezZk0+MdI2w
         Qhh1pGjF+AV/ujUcr6ATc7KYlNXdvlE6Zn+4i0sn2jxZZw0HrfjeaHXgqJjl5+jczwvl
         3hnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780209494; x=1780814294;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0HOM05LT1lE7kNZx1pI35EyeXWl+aeg39mCX+QoYTrs=;
        b=R7kjfATZlMjvLyAz7NS3m61KUGT1n5ld5aRqWmlEbjXM+wZlo9O716fZ8qx11PNL43
         z0ptiChxbNZu97pxCLZRwK54aq2yObZ3uTK2K42+JhsN3nyYCXxHNN7p0EvLeh7tb/vG
         pt+tNKrh3Unh0z6DHEaXgZc4rjneE15azZb+hcDcZCiFippho6cm2QdxuHknHOzfn4pE
         rB66Lfys8DQ/lIBJ+RPd/n+bAjGDuz5B0b5Iovim8moEcotewsUBdXM4OLZRij4WT08C
         LdxUq4Aj4wUDYmpMrVManQn8quco73IES6wN3IymhZ93A39stN2wRearHQjZi06a3F2f
         Z0Rg==
X-Forwarded-Encrypted: i=1; AFNElJ9FFU/VeO9kQIHi7laa2QmT/F7LEGVrfkpc5CYwgaYB/8ZWrPJC/KVmFSQoGY8MdBwtGyZlGm/XU0Hyt/6glJVM@vger.kernel.org
X-Gm-Message-State: AOJu0YyeWgf57fCJ9cGXr1KG67TzqUI09YToyEANQNvXAMkT5WEYhdEJ
	TeMOSjUCvY/HsjiFz88oAibPR34V8H04GZ3lGDK2zHFipo6n/ZBb+lovkLZ+0Y5QF5q/tws0GUA
	H0bgvZmHJzQ==
X-Received: from dlbvs5.prod.google.com ([2002:a05:7022:3f05:b0:12d:bef6:56f4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e984:b0:136:7b88:4395
 with SMTP id a92af1059eb24-137d426d5e7mr2561636c88.40.1780209493541; Sat, 30
 May 2026 23:38:13 -0700 (PDT)
Date: Sat, 30 May 2026 23:37:34 -0700
In-Reply-To: <20260531063736.871777-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531052740.796087-1-irogers@google.com> <20260531063736.871777-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531063736.871777-13-irogers@google.com>
Subject: [PATCH v3 12/14] perf test: Add -j/--junit option for JUnit XML test reports
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
index 42dc7f6f00ae..450f246422e8 100644
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
 
@@ -629,6 +689,8 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 	struct strbuf err_output = STRBUF_INIT;
 	int last_running = -1;
 	int ret;
+	struct timespec end_time;
+	double elapsed;
 
 	if (child_test == NULL) {
 		/* Test wasn't started. */
@@ -682,7 +744,7 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 					fprintf(debug_file(), PERF_COLOR_DELETE_LINE);
 				}
 				print_test_result(t, curr_suite, curr_test_case, TEST_RUNNING,
-						  width, running);
+						  width, running, NULL, 0.0);
 				last_running = running;
 			}
 		}
@@ -731,9 +793,14 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
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
@@ -827,7 +894,7 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 				}
 				print_test_result(next_child->test, next_child->suite_num,
 						  next_child->test_case_num, TEST_RUNNING, width,
-						  running_count);
+						  running_count, NULL, 0.0);
 			}
 			last_running = running_count;
 		}
@@ -874,12 +941,14 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
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
@@ -917,8 +986,12 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
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
@@ -941,11 +1014,18 @@ static int start_test(struct test_suite *test, int curr_suite, int curr_test_cas
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
@@ -975,6 +1055,7 @@ static int start_test(struct test_suite *test, int curr_suite, int curr_test_cas
 		(*child)->process.err = -1;
 	}
 	(*child)->process.no_exec_cmd = run_test_child;
+	clock_gettime(CLOCK_MONOTONIC, &(*child)->start_time);
 	if (sequential || pass == 2) {
 		err = start_command(&(*child)->process);
 		if (err)
@@ -1010,6 +1091,41 @@ static void print_tests_summary(void)
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
 
@@ -1093,8 +1209,28 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
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
@@ -1274,6 +1410,8 @@ int cmd_test(int argc, const char **argv)
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

