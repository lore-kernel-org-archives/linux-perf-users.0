Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B862367D3
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 01:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790644727; cv=none; b=EP+1GnzkQeoqvKz92hLbl70bzNQpCXNgnlMzh9xxorguHVYdWzPipLIZf1tzYuZmUoCcSlWfWDm9mYWRN+1TENeqwlHG3qWe3nNBuv05/IbYQnR6zJhP0YVnnw3Kvi/rOjErX8ThEZnOQOGz1xhB6uvZ+9vY1e2qY2TOUEnbktc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790644727; c=relaxed/simple;
	bh=kqqYPmLRMtRK+SM1Qc1MbjwHpBTqSedeKoIhc/NaV/w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RveTh/teOiWIOszUlv9qdgJQ6OhbASJHDUiE+gNKg8yAu683DxMU5Uh56/fR6qhoE0QowoMCVlFpnwuIz45gtST5XC3gNgmN76+fVBmuaxiRCuTMtNYf68qNFkga1wshb65aciw9+bY1Jf7q9T4ENumiSD5UGfbYMJ87AIPH0XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YTGTAu75; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YTGTAu75"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3441e2b3fc3so2442080eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790644723; x=1791249523; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mfF0n/3FquVGSmkwNIYpE3boWmeLEn//zug4omUkTE4=;
        b=YTGTAu75/VJd2VldjX+QwIN3Te7bhAyVsbcSOHcMtWC93ruJ3RzcJDY0vgacwDYxcJ
         wHIp70CsJTYFN7Ah281kMj3YD03CY6qW6RC+MBoRBVuPNbPBGM4bjMyViBfOziQ6239C
         S2bKwerzXypQS65aZ4orthXsv+jUatQ3r77a29U0gWp+8hEEV2SX7/j+MP3+qGZhu+94
         4MNBETykYLJ32EFAj26eXQQG5xeVOXBjJTLpTxOtC22wHCT2v0/Yd+U5UWxnCq+7nzUh
         O6AiWBVttO47OM8O1YZdbFqi9gGHZ7Zg9bb4ZHYrCLyEArCkjQ6D2VIAiZfMJqOPM5jl
         Mjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790644723; x=1791249523;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mfF0n/3FquVGSmkwNIYpE3boWmeLEn//zug4omUkTE4=;
        b=dQufey1VprZ4QVRJdJ8a58yXjetSnXxKCqqjiI4Zuu9iDGvvFrvab51DshR9kymypX
         Ivh4D2CnzWuqLEQNSfcfOLBV6nuY/dqXJL5mv13k7Di/gy1dt9xJnEF24qktWlOJinOd
         IkXm6uKstLCkxYWO7GCXQueK8BPwvJql/1TE+IYorrlNVsO2Hdg6ObpbM9PTcMUecuSI
         YukxuESp+8u/t1VaodGzCETSjJ91XCEQj357E/4zS5hZGEtaeVr00TT5wEWjQYWqIDDD
         g45pMe1gGUvJCiNj0mkvjrfZADQulyvMULr4TmZxRZuf+nkSAM3VWy4zihGwkcVWtfck
         S+bA==
X-Forwarded-Encrypted: i=1; AKwUvBxkunJwYskJXg0YpEREwWVqEYyzSB8VQ9vuAaA4gQOqirNuMXpfbz1RlxzkGE+MwggByy5XYqSbKdoS0K7L/s4K@vger.kernel.org
X-Gm-Message-State: AFuF++lxkEPemQQ+Fv16LrVqDL+QbwjzCoFwUitdaMaUGvx2g9Jq2iR5
	QKzVxl0WjiXDwIJQZagLrcY4fzswsSGkPwtOnMe2uvb3Ryx9l8mKd/+fNhjUaVQi4/OIzehB5TL
	Ag8dYViMxTQ==
X-Received: from dlbpv14.prod.google.com ([2002:a05:7023:90e:b0:144:c590:e885])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4354:b0:143:8865:cca
 with SMTP id a92af1059eb24-146cfdcf390mr11215940c88.22.1790644722913; Mon, 28
 Sep 2026 18:18:42 -0700 (PDT)
Date: Mon, 28 Sep 2026 18:18:36 -0700
In-Reply-To: <20260929011837.4157334-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928210144.3925224-1-irogers@google.com> <20260929011837.4157334-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929011837.4157334-2-irogers@google.com>
Subject: [PATCH v2 2/2] perf test: Improve JUnit XML schema compliance and completeness
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Improve the JUnit XML output generated by 'perf test -j' so that it
validates cleanly against both the strict Apache Ant/Windy Road JUnit
schema (JUnit.xsd) and the Jenkins xUnit/Maven Surefire schema
(junit-10.xsd):
- Add the required 'package', 'id', 'timestamp' (ISO 8601 UTC),
  'hostname', and 'time' attributes to '<testsuite>'.
- Emit '<properties>' (populated with uname sysname, release, version,
  and machine when available) at the start of '<testsuite>' and
  '<system-out/>' and '<system-err/>' at the end, matching the element
  sequence required by JUnit.xsd.
- Add the required 'type="failure"' attribute to '<failure>' elements
  and emit self-closing tags for passing '<testcase>' elements and
  '<failure>'/'<error>' elements with empty error output.
- Escape apostrophes ('&apos;') and validate UTF-8 multi-byte sequences
  against valid XML 1.0 codepoints in xml_escape().
- Use the actual suite description and '%.2f' time format for user
  override skipped tests ('-s'/'--skip').
- Document '-j[<file>]'/'--junit[=<file>]' in perf-test.txt.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-test.txt |   5 +
 tools/perf/tests/builtin-test.c        | 309 +++++++++++++++++--------
 2 files changed, 212 insertions(+), 102 deletions(-)

diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
index 16d940e8d221..9b1f153ce881 100644
--- a/tools/perf/Documentation/perf-test.txt
+++ b/tools/perf/Documentation/perf-test.txt
@@ -55,6 +55,11 @@ OPTIONS
 	Do not fork child for each test, run all tests within single process, this
 	sets sequential mode and disables the per-test timeout.
 
+-j[<file>]::
+--junit[=<file>]::
+	Generate JUnit XML test report to the specified file, or 'test.xml' if
+	no file is specified.
+
 --dso::
 	Specify a DSO for the "Symbols" test.
 
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 4ecbaf757095..1e85eb1eba82 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -28,6 +28,7 @@
 #include <sys/stat.h>
 #include <sys/time.h>
 #include <sys/types.h>
+#include <sys/utsname.h>
 #include <sys/wait.h>
 #include <unistd.h>
 
@@ -466,23 +467,59 @@ static int __printf(2, 3) strbuf_addf_safe(struct strbuf *sb, const char *fmt, .
 static char *xml_escape(const char *str)
 {
 	struct strbuf buf = STRBUF_INIT;
-	const char *p;
+	const unsigned char *p;
 	char *res;
 
 	if (!str)
 		return strdup("");
 
-	for (p = str; *p; p++) {
-		if (*p == '&')
-			strbuf_addstr(&buf, "&amp;");
-		else if (*p == '<')
-			strbuf_addstr(&buf, "&lt;");
-		else if (*p == '>')
-			strbuf_addstr(&buf, "&gt;");
-		else if (*p == '"')
-			strbuf_addstr(&buf, "&quot;");
-		else if ((unsigned char)*p >= 32 || *p == '\n' || *p == '\t')
-			strbuf_addch(&buf, *p);
+	for (p = (const unsigned char *)str; *p; p++) {
+		unsigned char c = *p;
+		int err = 0;
+
+		if (c == '&') {
+			err = strbuf_addstr(&buf, "&amp;");
+		} else if (c == '<') {
+			err = strbuf_addstr(&buf, "&lt;");
+		} else if (c == '>') {
+			err = strbuf_addstr(&buf, "&gt;");
+		} else if (c == '"') {
+			err = strbuf_addstr(&buf, "&quot;");
+		} else if (c == '\'') {
+			err = strbuf_addstr(&buf, "&apos;");
+		} else if ((c >= 0x20 && c <= 0x7e) || c == '\n' || c == '\t') {
+			err = strbuf_addch(&buf, c);
+		} else if (c >= 0xc2 && c <= 0xdf && (p[1] & 0xc0) == 0x80) {
+			err = strbuf_add(&buf, p, 2);
+			p += 1;
+		} else if (c >= 0xe0 && c <= 0xef &&
+			   (p[1] & 0xc0) == 0x80 && (p[2] & 0xc0) == 0x80) {
+			unsigned int cp = ((c & 0x0f) << 12) |
+					  ((p[1] & 0x3f) << 6) |
+					  (p[2] & 0x3f);
+
+			if (cp >= 0x800 &&
+			    (cp < 0xd800 || (cp >= 0xe000 && cp <= 0xfffd))) {
+				err = strbuf_add(&buf, p, 3);
+				p += 2;
+			}
+		} else if (c >= 0xf0 && c <= 0xf4 &&
+			   (p[1] & 0xc0) == 0x80 && (p[2] & 0xc0) == 0x80 &&
+			   (p[3] & 0xc0) == 0x80) {
+			unsigned int cp = ((c & 0x07) << 18) |
+					  ((p[1] & 0x3f) << 12) |
+					  ((p[2] & 0x3f) << 6) |
+					  (p[3] & 0x3f);
+
+			if (cp >= 0x10000 && cp <= 0x10ffff) {
+				err = strbuf_add(&buf, p, 4);
+				p += 3;
+			}
+		}
+		if (err < 0) {
+			strbuf_release(&buf);
+			return NULL;
+		}
 	}
 	res = strbuf_detach(&buf, NULL);
 	return res ? res : strdup("");
@@ -531,6 +568,68 @@ static int get_max_desc_width(int width)
 	return width > term_width ? term_width : width;
 }
 
+static void append_junit_testcase(const char *classname, const char *testname,
+				  int result, const char *skip_msg,
+				  const char *err_output, double elapsed)
+{
+	char *escaped_err = xml_escape(err_output);
+	char *escaped_class = xml_escape(classname);
+	char *escaped_test = xml_escape(testname);
+
+	if (!escaped_err || !escaped_class || !escaped_test)
+		goto out;
+
+	if (result == TEST_OK) {
+		strbuf_addf(&junit_xml_buf,
+			    "    <testcase classname=\"%s\" name=\"%s\" time=\"%.2f\"/>\n",
+			    escaped_class, escaped_test, elapsed);
+		goto out;
+	}
+
+	strbuf_addf(&junit_xml_buf,
+		    "    <testcase classname=\"%s\" name=\"%s\" time=\"%.2f\">\n",
+		    escaped_class, escaped_test, elapsed);
+	if (result == TEST_TIMEOUT) {
+		if (err_output && *err_output) {
+			strbuf_addf(&junit_xml_buf,
+				    "      <error message=\"TIMEOUT\" type=\"timeout\">\n%s\n      </error>\n",
+				    escaped_err);
+		} else {
+			strbuf_addstr(&junit_xml_buf,
+				      "      <error message=\"TIMEOUT\" type=\"timeout\"/>\n");
+		}
+	} else if (result != TEST_SKIP) {
+		if (err_output && *err_output) {
+			strbuf_addf(&junit_xml_buf,
+				    "      <failure message=\"FAILED\" type=\"failure\">\n%s\n      </failure>\n",
+				    escaped_err);
+		} else {
+			strbuf_addstr(&junit_xml_buf,
+				      "      <failure message=\"FAILED\" type=\"failure\"/>\n");
+		}
+	} else {
+		char *escaped_reason = xml_escape(skip_msg ? skip_msg : "Skip");
+
+		if (escaped_reason) {
+			if (err_output && *err_output) {
+				strbuf_addf(&junit_xml_buf,
+					    "      <skipped message=\"%s\">\n%s\n      </skipped>\n",
+					    escaped_reason, escaped_err);
+			} else {
+				strbuf_addf(&junit_xml_buf,
+					    "      <skipped message=\"%s\"/>\n",
+					    escaped_reason);
+			}
+			free(escaped_reason);
+		}
+	}
+	strbuf_addstr(&junit_xml_buf, "    </testcase>\n");
+out:
+	free(escaped_err);
+	free(escaped_class);
+	free(escaped_test);
+}
+
 static int print_test_result(struct test_suite *t, int curr_suite, int curr_test_case,
 			     int result, int width, int running,
 			     const char *err_output, double elapsed)
@@ -601,41 +700,9 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
 	}
 
 	if (junit_filename && result != TEST_RUNNING) {
-		const char *classname = t->desc;
-		const char *testname = test_description(t, curr_test_case);
-		char *escaped_err = xml_escape(err_output);
-		char *escaped_class = xml_escape(classname);
-		char *escaped_test = xml_escape(testname);
-
-		strbuf_addf(&junit_xml_buf,
-			    "    <testcase classname=\"%s\" name=\"%s\" time=\"%.2f\">\n",
-			    escaped_class, escaped_test, elapsed);
-		if (result == TEST_TIMEOUT) {
-			strbuf_addf(&junit_xml_buf,
-				    "      <error message=\"TIMEOUT\" type=\"timeout\">\n%s\n      </error>\n",
-				    escaped_err);
-		} else if (result != TEST_OK && result != TEST_SKIP) {
-			strbuf_addf(&junit_xml_buf,
-				    "      <failure message=\"FAILED\">\n%s\n      </failure>\n",
-				    escaped_err);
-		} else if (result == TEST_SKIP) {
-			const char *reason = skip_reason(t, curr_test_case);
-			char *escaped_reason = xml_escape(reason ? reason : "Skip");
-
-			if (err_output && *err_output) {
-				strbuf_addf(&junit_xml_buf,
-					    "      <skipped message=\"%s\">\n%s\n      </skipped>\n",
-					    escaped_reason, escaped_err);
-			} else {
-				strbuf_addf(&junit_xml_buf, "      <skipped message=\"%s\"/>\n",
-					    escaped_reason);
-			}
-			free(escaped_reason);
-		}
-		strbuf_addstr(&junit_xml_buf, "    </testcase>\n");
-		free(escaped_err);
-		free(escaped_class);
-		free(escaped_test);
+		append_junit_testcase(t->desc, test_description(t, curr_test_case),
+				      result, skip_reason(t, curr_test_case),
+				      err_output, elapsed);
 	}
 
 	return 0;
@@ -1407,7 +1474,86 @@ static void cmd_test_sig_handler(int sig)
 	siglongjmp(cmd_test_jmp_buf, sig);
 }
 
-static void print_tests_summary(void)
+static void write_junit_xml(const struct timespec *start_time, time_t start_realtime)
+{
+	unsigned int total = summary_tests_passed + summary_subtests_passed +
+			     summary_tests_skipped + summary_tests_timed_out +
+			     summary_tests_failed;
+	struct timespec end_time;
+	double elapsed;
+	struct tm tm;
+	char timestamp[32];
+	struct utsname uts;
+	bool have_uts;
+	char *escaped_host;
+	FILE *fp;
+	int fd;
+
+	fd = open(junit_filename, O_CREAT | O_TRUNC | O_WRONLY | O_NOFOLLOW, 0644);
+	if (fd < 0) {
+		pr_err("Failed to open %s for writing junit XML output: %s\n",
+		       junit_filename, strerror(errno));
+		return;
+	}
+
+	fp = fdopen(fd, "w");
+	if (!fp) {
+		close(fd);
+		pr_err("Failed to associate stream with fd for %s: %s\n",
+		       junit_filename, strerror(errno));
+		return;
+	}
+
+	have_uts = uname(&uts) == 0;
+	escaped_host = xml_escape(have_uts && uts.nodename[0] ? uts.nodename : "localhost");
+
+	clock_gettime(CLOCK_MONOTONIC, &end_time);
+	elapsed = (end_time.tv_sec - start_time->tv_sec) +
+		  (end_time.tv_nsec - start_time->tv_nsec) / 1000000000.0;
+	if (!gmtime_r(&start_realtime, &tm) ||
+	    !strftime(timestamp, sizeof(timestamp), "%Y-%m-%dT%H:%M:%S", &tm))
+		snprintf(timestamp, sizeof(timestamp), "1970-01-01T00:00:00");
+
+	fprintf(fp, "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n");
+	fprintf(fp, "<testsuites>\n");
+	fprintf(fp,
+		"  <testsuite name=\"perf-tests\" package=\"perf-tests\" id=\"0\" timestamp=\"%s\" hostname=\"%s\" tests=\"%u\" failures=\"%u\" errors=\"%u\" skipped=\"%u\" time=\"%.2f\">\n",
+		timestamp, escaped_host ?: "localhost", total, summary_tests_failed,
+		summary_tests_timed_out, summary_tests_skipped, elapsed);
+	free(escaped_host);
+	if (have_uts) {
+		char *sysname = xml_escape(uts.sysname);
+		char *release = xml_escape(uts.release);
+		char *version = xml_escape(uts.version);
+		char *machine = xml_escape(uts.machine);
+
+		fprintf(fp, "    <properties>\n");
+		if (sysname)
+			fprintf(fp, "      <property name=\"sysname\" value=\"%s\"/>\n", sysname);
+		if (release)
+			fprintf(fp, "      <property name=\"release\" value=\"%s\"/>\n", release);
+		if (version)
+			fprintf(fp, "      <property name=\"version\" value=\"%s\"/>\n", version);
+		if (machine)
+			fprintf(fp, "      <property name=\"machine\" value=\"%s\"/>\n", machine);
+		fprintf(fp, "    </properties>\n");
+		free(sysname);
+		free(release);
+		free(version);
+		free(machine);
+	} else {
+		fprintf(fp, "    <properties/>\n");
+	}
+	fprintf(fp, "%s", junit_xml_buf.buf);
+	fprintf(fp, "    <system-out/>\n");
+	fprintf(fp, "    <system-err/>\n");
+	fprintf(fp, "  </testsuite>\n");
+	fprintf(fp, "</testsuites>\n");
+	fclose(fp);
+	pr_info("Wrote junit XML output to %s\n", junit_filename);
+}
+
+static void print_tests_summary(const struct timespec *start_time, time_t start_realtime)
 {
 	pr_info("\n=== Test Summary ===\n");
 	pr_info("Passed main tests : %u\n", summary_tests_passed);
@@ -1430,42 +1576,9 @@ static void print_tests_summary(void)
 		color_fprintf(debug_file(), PERF_COLOR_GREEN, "Failed tests      : 0\n");
 	}
 
-	if (junit_filename) {
-		int fd;
-		FILE *fp;
-
-		fd = open(junit_filename, O_CREAT | O_TRUNC | O_WRONLY | O_NOFOLLOW, 0644);
-		if (fd >= 0) {
-			fp = fdopen(fd, "w");
-			if (fp) {
-				unsigned int total = summary_tests_passed +
-						     summary_subtests_passed +
-						     summary_tests_skipped +
-						     summary_tests_timed_out +
-						     summary_tests_failed;
-				fprintf(fp, "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n");
-				fprintf(fp, "<testsuites>\n");
-				fprintf(fp,
-					"  <testsuite name=\"perf-tests\" tests=\"%u\" failures=\"%u\" errors=\"%u\" skipped=\"%u\">\n",
-					total,
-					summary_tests_failed,
-					summary_tests_timed_out,
-					summary_tests_skipped);
-				fprintf(fp, "%s", junit_xml_buf.buf);
-				fprintf(fp, "  </testsuite>\n");
-				fprintf(fp, "</testsuites>\n");
-				fclose(fp);
-				pr_info("Wrote junit XML output to %s\n", junit_filename);
-			} else {
-				close(fd);
-				pr_err("Failed to associate stream with fd for %s: %s\n",
-				       junit_filename, strerror(errno));
-			}
-		} else {
-			pr_err("Failed to open %s for writing junit XML output: %s\n",
-			       junit_filename, strerror(errno));
-		}
-	}
+	if (junit_filename)
+		write_junit_xml(start_time, start_realtime);
+
 	strbuf_release(&junit_xml_buf);
 	strbuf_release(&summary_timed_out_tests_buf);
 	strbuf_release(&summary_failed_tests_buf);
@@ -1475,8 +1588,13 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 		      struct intlist *skiplist)
 {
 	static int width = 0;
+	struct timespec suite_start_time;
+	time_t suite_start_realtime;
 	int err = 0;
 
+	clock_gettime(CLOCK_MONOTONIC, &suite_start_time);
+	suite_start_realtime = time(NULL);
+
 	for (struct test_suite **t = suites; *t; t++) {
 		int i, len = strlen(test_description(*t, -1));
 
@@ -1574,23 +1692,10 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 						      " Skip (user override)\n");
 					summary_tests_skipped++;
 					if (junit_filename) {
-						char *escaped_class =
-							xml_escape((const char *)
-								   test_description(*t, -1));
-						char *escaped_test = xml_escape("override");
-						char *escaped_reason =
-							xml_escape("user override");
-
-						strbuf_addf(&junit_xml_buf,
-							"    <testcase classname=\"%s\" name=\"%s\" time=\"0.000\">\n",
-							escaped_class, escaped_test);
-						strbuf_addf(&junit_xml_buf,
-							"      <skipped message=\"%s\"/>\n",
-							escaped_reason);
-						strbuf_addstr(&junit_xml_buf, "    </testcase>\n");
-						free(escaped_reason);
-						free(escaped_test);
-						free(escaped_class);
+						const char *desc = test_description(*t, -1);
+
+						append_junit_testcase(desc, desc, TEST_SKIP,
+								      "user override", NULL, 0.0);
 					}
 				}
 				continue;
@@ -1631,7 +1736,7 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 		setitimer(ITIMER_REAL, &timer, NULL);
 		signal(SIGALRM, SIG_DFL);
 	}
-	print_tests_summary();
+	print_tests_summary(&suite_start_time, suite_start_realtime);
 	free(global_pfds);
 	free(global_pfd_indices);
 	global_pfds = NULL;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

