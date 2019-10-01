From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/24] perf docs: Allow man page date to be specified
Date: Tue,  1 Oct 2019 08:11:55 -0300
Message-ID: <20191001111216.7208-4-acme@kernel.org>
References: <20191001111216.7208-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191001111216.7208-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ian Rogers <irogers@google.com>

With this change if a perf_date parameter is provided to asciidoc then
it will override the default date written to the man page metadata.

Without this change, or if the perf_date isn't specified, then the
current date is written to the metadata.

Having this parameter allows the metadata to be constant if builds
happen on different dates.

The name of the parameter is intended to be consistent with the existing
perf_version parameter.

Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20190921041327.155054-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/asciidoc.conf | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/Documentation/asciidoc.conf b/tools/perf/Documentation/asciidoc.conf
index 356b23a40339..2b62ba1e72b7 100644
--- a/tools/perf/Documentation/asciidoc.conf
+++ b/tools/perf/Documentation/asciidoc.conf
@@ -71,6 +71,9 @@ ifdef::backend-docbook[]
 [header]
 template::[header-declarations]
 <refentry>
+ifdef::perf_date[]
+<refentryinfo><date>{perf_date}</date></refentryinfo>
+endif::perf_date[]
 <refmeta>
 <refentrytitle>{mantitle}</refentrytitle>
 <manvolnum>{manvolnum}</manvolnum>
-- 
2.21.0
