From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 81/85] perf time-utils: Add support for multiple explicit time intervals
Date: Tue, 11 Jun 2019 15:59:07 -0300
Message-ID: <20190611185911.11645-82-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Currently only a single explicit time range is accepted. Add support for
multiple ranges separated by spaces, which requires the string to be
quoted. Update the time utils test accordingly.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-20-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-diff.txt   |  8 ++-
 tools/perf/Documentation/perf-report.txt |  3 +-
 tools/perf/Documentation/perf-script.txt |  3 +-
 tools/perf/tests/time-utils-test.c       | 17 ++++++
 tools/perf/util/time-utils.c             | 74 ++++++++++++++++++++++--
 5 files changed, 94 insertions(+), 11 deletions(-)

diff --git a/tools/perf/Documentation/perf-diff.txt b/tools/perf/Documentation/perf-diff.txt
index 5732f69580ab..facd91e4e945 100644
--- a/tools/perf/Documentation/perf-diff.txt
+++ b/tools/perf/Documentation/perf-diff.txt
@@ -145,9 +145,11 @@ OPTIONS
 	<start>,<stop>. Times have the format seconds.nanoseconds. If 'start'
 	is not given (i.e. time string is ',x.y') then analysis starts at
 	the beginning of the file. If stop time is not given (i.e. time
-	string is 'x.y,') then analysis goes to the end of the file. Time string is
-	'a1.b1,c1.d1:a2.b2,c2.d2'. Use ':' to separate timestamps for different
-	perf.data files.
+	string is 'x.y,') then analysis goes to the end of the file.
+	Multiple ranges can be separated by spaces, which requires the argument
+	to be quoted e.g. --time "1234.567,1234.789 1235,"
+	Time string is'a1.b1,c1.d1:a2.b2,c2.d2'. Use ':' to separate timestamps
+	for different perf.data files.
 
 	For example, we get the timestamp information from 'perf script'.
 
diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 3de029f6881d..8c4372819e11 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -415,7 +415,8 @@ OPTIONS
 	have the format seconds.nanoseconds. If start is not given (i.e. time
 	string is ',x.y') then analysis starts at the beginning of the file. If
 	stop time is not given (i.e. time string is 'x.y,') then analysis goes
-	to end of file.
+	to end of file. Multiple ranges can be separated by spaces, which
+	requires the argument to be quoted e.g. --time "1234.567,1234.789 1235,"
 
 	Also support time percent with multiple time ranges. Time string is
 	'a%/n,b%/m,...' or 'a%-b%,c%-%d,...'.
diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 878349cce968..d4e2e18a5881 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -364,7 +364,8 @@ include::itrace.txt[]
 	have the format seconds.nanoseconds. If start is not given (i.e. time
 	string is ',x.y') then analysis starts at the beginning of the file. If
 	stop time is not given (i.e. time string is 'x.y,') then analysis goes
-	to end of file.
+	to end of file. Multiple ranges can be separated by spaces, which
+	requires the argument to be quoted e.g. --time "1234.567,1234.789 1235,"
 
 	Also support time percent with multiple time ranges. Time string is
 	'a%/n,b%/m,...' or 'a%-b%,c%-%d,...'.
diff --git a/tools/perf/tests/time-utils-test.c b/tools/perf/tests/time-utils-test.c
index 7504046b111c..4f53006233a1 100644
--- a/tools/perf/tests/time-utils-test.c
+++ b/tools/perf/tests/time-utils-test.c
@@ -168,6 +168,23 @@ int test__time_utils(struct test *t __maybe_unused, int subtest __maybe_unused)
 		pass &= test__perf_time__parse_for_ranges(&d);
 	}
 
+	{
+		u64 b = 1234567123456789ULL;
+		u64 c = 7654321987654321ULL;
+		u64 e = 8000000000000000ULL;
+		struct test_data d = {
+			.str   = "1234567.123456789,1234567.123456790 "
+				 "7654321.987654321,7654321.987654444 "
+				 "8000000,8000000.000000005",
+			.ptime = { {b, b + 1}, {c, c + 123}, {e, e + 5}, },
+			.num = 3,
+			.skip = { b - 1, b + 2, c - 1, c + 124, e - 1, e + 6 },
+			.noskip = { b, b + 1, c, c + 123, e, e + 5 },
+		};
+
+		pass &= test__perf_time__parse_for_ranges(&d);
+	}
+
 	{
 		u64 b = 7654321ULL * NSEC_PER_SEC;
 		struct test_data d = {
diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index d942840356e3..2b48816a2d2e 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -7,6 +7,7 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <math.h>
+#include <ctype.h>
 
 #include "perf.h"
 #include "debug.h"
@@ -116,6 +117,69 @@ int perf_time__parse_str(struct perf_time_interval *ptime, const char *ostr)
 	return rc;
 }
 
+static int perf_time__parse_strs(struct perf_time_interval *ptime,
+				 const char *ostr, int size)
+{
+	const char *cp;
+	char *str, *arg, *p;
+	int i, num = 0, rc = 0;
+
+	/* Count the commas */
+	for (cp = ostr; *cp; cp++)
+		num += !!(*cp == ',');
+
+	if (!num)
+		return -EINVAL;
+
+	BUG_ON(num > size);
+
+	str = strdup(ostr);
+	if (!str)
+		return -ENOMEM;
+
+	/* Split the string and parse each piece, except the last */
+	for (i = 0, p = str; i < num - 1; i++) {
+		arg = p;
+		/* Find next comma, there must be one */
+		p = strchr(p, ',') + 1;
+		/* Skip white space */
+		while (isspace(*p))
+			p++;
+		/* Skip the value, must not contain space or comma */
+		while (*p && !isspace(*p)) {
+			if (*p++ == ',') {
+				rc = -EINVAL;
+				goto out;
+			}
+		}
+		/* Split and parse */
+		if (*p)
+			*p++ = 0;
+		rc = perf_time__parse_str(ptime + i, arg);
+		if (rc < 0)
+			goto out;
+	}
+
+	/* Parse the last piece */
+	rc = perf_time__parse_str(ptime + i, p);
+	if (rc < 0)
+		goto out;
+
+	/* Check there is no overlap */
+	for (i = 0; i < num - 1; i++) {
+		if (ptime[i].end >= ptime[i + 1].start) {
+			rc = -EINVAL;
+			goto out;
+		}
+	}
+
+	rc = num;
+out:
+	free(str);
+
+	return rc;
+}
+
 static int parse_percent(double *pcnt, char *str)
 {
 	char *c, *endptr;
@@ -424,15 +488,13 @@ int perf_time__parse_for_ranges(const char *time_str,
 				time_str,
 				session->evlist->first_sample_time,
 				session->evlist->last_sample_time);
-
-		if (num < 0)
-			goto error_invalid;
 	} else {
-		if (perf_time__parse_str(ptime_range, time_str))
-			goto error_invalid;
-		num = 1;
+		num = perf_time__parse_strs(ptime_range, time_str, size);
 	}
 
+	if (num < 0)
+		goto error_invalid;
+
 	*range_size = size;
 	*range_num = num;
 	*ranges = ptime_range;
-- 
2.20.1
