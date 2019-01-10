From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 2/4] perf symbols: Add 'arch_cpu_idle' to the list of kernel idle symbols
Date: Thu, 10 Jan 2019 13:56:34 -0300
Message-ID: <20190110165636.19338-3-acme@kernel.org>
References: <20190110165636.19338-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190110165636.19338-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When testing 'perf top' on a armhf system (32-bit, Orange Pi Zero), I
noticed that 'arch_cpu_idle' dominated, add it to the list of idle
symbols, so that we can see what is that being done when not idle.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-4q2b5g4p2hrstrhp9t2mrlho@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 01f2c7385e38..48efad6d0f90 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -614,6 +614,7 @@ int modules__parse(const char *filename, void *arg,
 static bool symbol__is_idle(const char *name)
 {
 	const char * const idle_symbols[] = {
+		"arch_cpu_idle",
 		"cpu_idle",
 		"cpu_startup_entry",
 		"intel_idle",
-- 
2.20.1
