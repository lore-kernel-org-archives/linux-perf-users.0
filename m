Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1B333E37C
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 21:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790629317; cv=none; b=p1vP4hXwoGKq35ZuGr7y8uco35Cs8OXssBbHuxTpwhtR3twiEPspVs+miuICGgQEqxYRbxzwv/LhujvUWDhwdpMEIo2dPGZaglYDektyNTCMN90g3euhh07BJOGQVLrbkoyGCxToL3ZyptJowFyGC4ZtrHHUJH7wXRmN41SAjuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790629317; c=relaxed/simple;
	bh=R8NJ9JLL9Pnwru7kI4DJHm3rJZ9bP34jpqbmSC0kwNM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=FI6Fn2jAxPF1pM+tpBHSimxn+IDEDwFb+Em3ZbDH1T9aPoMP//obe0R0e1mStBioND0fIm+0NawuqTQuujcYGKxMMTEpkT34nmyVxKgZTxaii4wsmyWIpan+yY+dN5c832lTQ3u6Po1mV5XJ+ymtKC5TJXqyXGHdP8rTalp2xx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A4jyMGsz; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A4jyMGsz"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1416f32fe11so1031970c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 14:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790629313; x=1791234113; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N7bHTHida/HfrmxQ7fuM/aoEK5ekUtXtLiB+N1ix2cM=;
        b=A4jyMGsz5TfHDyoCMaxXZ/q4hCiTQdTpwfNDwYm4JMY4DL97lvOCTa/kR5RMS8/Bu/
         I1J3U7M/Ee9XQ48sSes95GVEb2kgMTF+BM7GXD48P8vYq7gwaKyOU7YBrAz69udKkKXH
         a82akT1SKae3IjC7ozSOolZV5OkokxGTuVePKa6jBP0a6ITRYN6yqQ2C7oqGxxAeZd8/
         QrEwt1wxjhR8d+CTt1dQf9sHahR9d3lumCyuNdybwZPgph8FKeFuUe1It7mLzQWLH7tw
         PLA96R0zaoTWHalAENbFknJ1OzKi2V4z6LZb6g2BnW9go+bhFocqw90d4gTRj0M2ie+g
         Z9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790629313; x=1791234113;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N7bHTHida/HfrmxQ7fuM/aoEK5ekUtXtLiB+N1ix2cM=;
        b=ki5b0qr+16o3RC+vaaXok0Nh3Ofv3qwU9pUyG9krlfXcOM5y/BktjvgN1l40jXWrmF
         DbXoyNiHNd7g/m/0D3rstBA7chdWVxRJgjCgLbyCdZW4wK8tRV74/Ua46RsPVrnW9O2S
         SphrCgKbAGuYh+BmdVPkOkE8rge6cD+SnSqpkgM4FLsbehC7N50m5qC9Oa6I6dJzthbG
         nEeQS9SCJloY3eu88HAmv2PdoOzxKpnsBbnVjG6uut+6Xy/ggrlDeiw+nGhqCWBrckNP
         7hZvxeoR8bWjGrKLhosWptQxxFCzELbQQFszimkdYuBiYGalJg8xTdGTN+E57XzbFYzZ
         CVFA==
X-Forwarded-Encrypted: i=1; AKwUvBzHB5P3nxiA/TvgVxIKbRYwSFXiI5RO2YJVhxheCXtBkpY9g3iQZpAYyhjLr+DFyB9o8zMXytnidntdQd6y1IYg@vger.kernel.org
X-Gm-Message-State: AFuF++m1LKgrNj9e6gDgjTv0WkJ/akz8r6JaVBMm6lZd3xqqdCIT/ERi
	5FgdPDdfMIeU9yW+hmWjmr+89mmD/vDLuTgB/yo5b6OcyFMry0XbSzPQAqSYyN+wOjL6tqtc3ct
	HIXTpz/6Ngw==
X-Received: from dlag22.prod.google.com ([2002:a05:701b:2516:b0:143:7cf0:d45a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f515:b0:143:26cf:8615
 with SMTP id a92af1059eb24-146cfec8423mr11122711c88.25.1790629312445; Mon, 28
 Sep 2026 14:01:52 -0700 (PDT)
Date: Mon, 28 Sep 2026 14:01:44 -0700
In-Reply-To: <20260928210144.3925224-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928210144.3925224-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928210144.3925224-2-irogers@google.com>
Subject: [PATCH v1 2/2] perf test: Improve JUnit XML schema compliance and completeness
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
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
index 451d98d7edad..2d0c5127752a 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -28,6 +28,7 @@
 #include <sys/stat.h>
 #include <sys/time.h>
 #include <sys/types.h>
+#include <sys/utsname.h>
 #include <sys/wait.h>
 #include <unistd.h>
 
@@ -428,23 +429,59 @@ static int __printf(2, 3) strbuf_addf_safe(struct strbuf *sb, const char *fmt, .
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
@@ -493,6 +530,68 @@ static int get_max_desc_width(int width)
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
@@ -563,41 +662,9 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
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
@@ -1351,7 +1418,86 @@ static void cmd_test_sig_handler(int sig)
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
@@ -1374,42 +1520,9 @@ static void print_tests_summary(void)
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
@@ -1419,8 +1532,13 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
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
 
@@ -1518,23 +1636,10 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
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
@@ -1575,7 +1680,7 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
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

