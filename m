Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E60128489D;
	Tue,  2 Sep 2025 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814178; cv=none; b=uNFm0z48aJGSpCXZTTkP0wqaNO0I6ReOe8RpZWIqMLbCBQTOvacxtoYqQaa4NtTOf+/kTzf/TarK931bX3eWahCI3H0HsMgFHcYCyIxZ1vOSUfO6pVR3SHiTaeR1SQAtyiKggED84lgTw++J/3+9oJnV7EixlfPUgqQLjdME+YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814178; c=relaxed/simple;
	bh=USlvZvEcvktPaDZdc5sQZBY1RYFuLDu7/foa35q4LKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ug77SD9aPaEzrMzioE00xNQajOug/1XSR+Tm0uN9kO3RBcMOxHW5mVwWrfOTPoWxgQNygUiQttGjwyfbmxWv4fJXyH1JpXySUT0dcM46KyWcP1YdVAUEhuTCbAwtQ0YGAVUaYImB5EIVhIWSHF8W9+LtTk3dtJ8OoMuqiJ1RAQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sifflez.org; spf=pass smtp.mailfrom=sifflez.org; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sifflez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifflez.org
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 39C6B834F2D;
	Tue,  2 Sep 2025 13:49:16 +0200 (CEST)
Received: from ix.ufr-stq-vauban.uvsq.fr (unknown [193.51.39.209])
	(Authenticated sender: pablo.deoliveiracastro@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id 2A08513F8B9;
	Tue,  2 Sep 2025 13:48:52 +0200 (CEST)
From: Pablo de Oliveira Castro <pablo@sifflez.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Pablo de Oliveira Castro <pablo@sifflez.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf stat: fix JSON output with non-C locales
Date: Tue,  2 Sep 2025 13:48:37 +0200
Message-ID: <20250902114837.274786-1-pablo@sifflez.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running `perf stat -j` under a locale that uses ',' as radix point
separator (e.g. LC_NUMERIC=fr_FR.UTF-8), the JSON output becomes
invalid. This is reproducible with perf test "perf stat JSON output
linter", which fails which such locales.

Example failure:

  $ LC_NUMERIC=fr_FR.UTF-8 perf test "JSON output" -v

  Checking json output: no args Test failed for input:

  {"counter-value" : "1,202545", "unit" : "msec", "event" :
   "task-clock", "event-runtime" : 1202545, "pcnt-running" : 100,00,
   "metric-value" : "0,473483", "metric-unit" : "CPUs utilized"}

  json.decoder.JSONDecodeError: Expecting property name enclosed in
  double quotes: line 2 column 121 (char 122)

Fix this by always using the POSIX numeric locale in json_out(),
ensuring that '.' is consistently used as the radix point in all JSON
numbers.

Signed-off-by: Pablo de Oliveira Castro <pablo@sifflez.org>
---
 tools/perf/util/stat-display.c | 35 +++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index a67b991f4e81..ff8225e7435c 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1,6 +1,8 @@
 #include <stdlib.h>
 #include <stdio.h>
+#include <stdarg.h>
 #include <inttypes.h>
+#include <locale.h>
 #include <linux/string.h>
 #include <linux/time64.h>
 #include <math.h>
@@ -149,7 +151,38 @@ static const char *json_sep(struct outstate *os)
 	return sep;
 }
 
-#define json_out(os, format, ...) fprintf((os)->fh, "%s" format, json_sep(os), ##__VA_ARGS__)
+/* Print formatted output using the POSIX numeric locale */
+static int clocale_fprintf(FILE *os, const char *fmt, ...)
+{
+	int ret;
+	va_list ap;
+
+	/* Create and temporarily switch to a POSIX numeric locale */
+	locale_t posix_numeric = newlocale(LC_NUMERIC_MASK, "C", (locale_t)0);
+
+	if (posix_numeric) {
+		locale_t prev = uselocale(posix_numeric);
+
+		va_start(ap, fmt);
+		ret = vfprintf(os, fmt, ap);
+		va_end(ap);
+
+		/* restore previous locale */
+		uselocale(prev);
+		freelocale(posix_numeric);
+		return ret;
+	}
+
+	/* If newlocale() failed, just print with the current locale */
+	va_start(ap, fmt);
+	ret = vfprintf(os, fmt, ap);
+	va_end(ap);
+	return ret;
+}
+
+/* use clocale_fprintf so the radix point is always . as required by JSON */
+#define json_out(os, format, ...) \
+	clocale_fprintf((os)->fh, "%s" format, json_sep(os), ##__VA_ARGS__)
 
 static void print_running_json(struct outstate *os, u64 run, u64 ena)
 {
-- 
2.43.0

