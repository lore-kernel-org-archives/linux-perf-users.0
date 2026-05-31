Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4024322B8F
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 05:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780205292; cv=none; b=KOaHgbeM6kaL0o3KmuFzDdhADeL6bUTVi5WaVHdlom8o2JTw6fIhSSGMBZO4vXsYjga6ie0MiVBBJCA50Pk7m0Dfsse5t8KUkO02naENc2SEh8P0l1qwGnFGwrO56SMxuVk/hps5kQfz/qkJz09G9zj5jqQPVZDzMm6otG8y4Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780205292; c=relaxed/simple;
	bh=txyKGQo24fin7m1p74ROQ7cRDlrhWhajkrhSrKqE+po=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UMDaJFFYT1HiJr3imwTSed03SyxWd1DJ4wBBsWb2rvB9Yd42A5mjGlC8s0m02cVa8ZU5nD94X+TghdgQaXH47zeo8YnCLstnVAQcF1fTIAlUGG4KR1toA2Mgx65ouWSJAbubA9fX83K3Sxsoih+HXnRj972dHI8MqhpXwQYGXZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uHoPT2DX; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uHoPT2DX"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304d8613efbso3730263eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 22:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780205290; x=1780810090; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cd2WPZf0TpUvjHmu+vrNHwNue4mtrYecW6yfz8hMPUk=;
        b=uHoPT2DXF6sUmD2OLOXzmKiuQIHYa4qbi9rXFkZRptdOlToZxSUZWV+p0WHayTqtj9
         x0xMTaGLSENg3rwfrU1nsbRGFUQPcqBvgnh96TDUSZQGBlsVRSZzyjdcSPcERy8FwWw2
         KbRxFtv/ZdiBI8Lfql/pkMN8eDVtrKz1jzuIsi5oi6RCrNtFDRLWmqaVMYxe82JYJVkI
         d4q4iJjGnXy9jWRPXGS0Y+HlD3j43dXZ2RJANRqTeGvoY/wD0dTJ+8ufq9xRE26wIdEu
         kpTx6SqG8jezVCxYg6DPnAFZ52kfCETqhkIQqyadui0UXJO/HXoOvcozKKau8H96NkC4
         2BsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780205290; x=1780810090;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cd2WPZf0TpUvjHmu+vrNHwNue4mtrYecW6yfz8hMPUk=;
        b=IsVZSl+rIC2unBppjnTWxAoexhGrrKx1/9BJvj/w2E4SCMf6k3KRaFjvnMWc9C3OJM
         Q6X+JcIhB3MqyVuCrcV1q8xWQ1iGduhyZIpxQ0j1gxyO96+dxMj2OO6v50Z/iXcPj8WH
         HpU0HAbNAsXTWeTWQYR2qIM8K4PcgFcnPcpUqPfgqDNEXz3lcZ+5N8ISb1b2K1K25EGH
         JjyVndV9fVgXZdb2GXukITpfXLyIJjW1HVxxRDdurQUQH9zywO3J7RetCG2E1fwASlc3
         tfgJs+pYWZEKju3fVKYd5TpatisaT4lrSEElj56kR/NOxFwlzpKkpzALYqJEkIfk7wpu
         snNw==
X-Forwarded-Encrypted: i=1; AFNElJ/ccIv/NbGsFnvCFmaNxBmmWOI7rLLbpszP8qQ6jPfCOe1dUCyivsZO9dP2zPI+/ZBTcsSL6ayzaoDj6hO1H9f0@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9rhDVHKg4NEaV5U4jzRiAoFUHtgUJ1vMQG7dp4nblTYfP+AQ5
	X0H29UEjcWMdiqWySoGFlcMwhC9pIy3JFBupCLWLVZgNE6dILjVXl+FbnQ3bu6265a6mt0DddYj
	njxlgKaaWmg==
X-Received: from dlan16-n1.prod.google.com ([2002:a05:7022:eb50:10b0:137:c9b:c045])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:60a4:b0:136:d237:b428
 with SMTP id a92af1059eb24-137d412b133mr2896769c88.22.1780205289763; Sat, 30
 May 2026 22:28:09 -0700 (PDT)
Date: Sat, 30 May 2026 22:27:38 -0700
In-Reply-To: <20260531052740.796087-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513230450.529380-1-irogers@google.com> <20260531052740.796087-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531052740.796087-13-irogers@google.com>
Subject: [PATCH v2 12/14] perf test: Add -j/--junit option for JUnit XML test reports
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
index fb4dffacf406..38697243f33a 100644
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
@@ -367,8 +373,34 @@ static unsigned int summary_tests_skipped;
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
@@ -416,6 +448,34 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
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
 
@@ -630,6 +690,8 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 	struct strbuf err_output = STRBUF_INIT;
 	int last_running = -1;
 	int ret;
+	struct timespec end_time;
+	double elapsed;
 
 	if (child_test == NULL) {
 		/* Test wasn't started. */
@@ -683,7 +745,7 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 					fprintf(debug_file(), PERF_COLOR_DELETE_LINE);
 				}
 				print_test_result(t, curr_suite, curr_test_case, TEST_RUNNING,
-						  width, running);
+						  width, running, NULL, 0.0);
 				last_running = running;
 			}
 		}
@@ -732,8 +794,13 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
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
@@ -823,7 +890,7 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
 				}
 				print_test_result(next_child->test, next_child->suite_num,
 						  next_child->test_case_num, TEST_RUNNING, width,
-						  running_count);
+						  running_count, NULL, 0.0);
 			}
 			last_running = running_count;
 		}
@@ -870,12 +937,14 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
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
@@ -913,8 +982,12 @@ static int finish_tests_parallel(struct child_test **child_tests, size_t num_tes
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
@@ -935,11 +1008,18 @@ static int start_test(struct test_suite *test, int curr_suite, int curr_test_cas
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
@@ -969,6 +1049,7 @@ static int start_test(struct test_suite *test, int curr_suite, int curr_test_cas
 		(*child)->process.err = -1;
 	}
 	(*child)->process.no_exec_cmd = run_test_child;
+	clock_gettime(CLOCK_MONOTONIC, &(*child)->start_time);
 	if (sequential || pass == 2) {
 		err = start_command(&(*child)->process);
 		if (err)
@@ -1004,6 +1085,41 @@ static void print_tests_summary(void)
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
 
@@ -1087,8 +1203,28 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 				if (pass == 1) {
 					pr_info("%3d: %-*s:", curr_suite + 1, width,
 						test_description(*t, -1));
-					color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (user override)\n");
+					color_fprintf(stderr, PERF_COLOR_YELLOW,
+						      " Skip (user override)\n");
 					summary_tests_skipped++;
+					if (junit_filename) {
+						char *escaped_class =
+							xml_escape(test_description(*t, -1));
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
@@ -1264,6 +1400,8 @@ int cmd_test(int argc, const char **argv)
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

