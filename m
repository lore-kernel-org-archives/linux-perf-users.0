From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/12] perf tools: Use %define api.pure full instead of %pure-parser
Date: Thu, 16 Jan 2020 10:48:09 -0300
Message-ID: <20200116134814.8811-8-acme@kernel.org>
References: <20200116134814.8811-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200116134814.8811-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

bison deprecated the "%pure-parser" directive in favor of "%define
api.pure full".

The api.pure got introduced in bison 2.3 (Oct 2007), so it seems safe to
use it without any version check.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lore.kernel.org/lkml/20200112192259.GA35080@krava
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/expr.y         | 3 ++-
 tools/perf/util/parse-events.y | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index f9a20a39b64a..7d226241f1d7 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -12,7 +12,8 @@
 #define MAXIDLEN 256
 %}
 
-%pure-parser
+%define api.pure full
+
 %parse-param { double *final_val }
 %parse-param { struct parse_ctx *ctx }
 %parse-param { const char **pp }
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index e2eea4e601b4..94f8bcd83582 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -1,4 +1,4 @@
-%pure-parser
+%define api.pure full
 %parse-param {void *_parse_state}
 %parse-param {void *scanner}
 %lex-param {void* scanner}
-- 
2.21.1
