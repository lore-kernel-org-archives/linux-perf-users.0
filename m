From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/91] perf script: Avoid NULL dereference on symbol
Date: Wed,  6 May 2020 12:21:07 -0300
Message-ID: <20200506152234.21977-5-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ian Rogers <irogers@google.com>

al->sym may be NULL given current if conditions and may cause a segv.

Fixes: d2bedb7863e9 ("perf script: Allow --symbol to accept hexadecimal addresses")
Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20200421004329.43109-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index dc0e11214ae1..f581550a3015 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -626,7 +626,7 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 			ret = strlist__has_entry(symbol_conf.sym_list,
 						al->sym->name);
 		}
-		if (!(ret && al->sym)) {
+		if (!ret && al->sym) {
 			snprintf(al_addr_str, sz, "0x%"PRIx64,
 				al->map->unmap_ip(al->map, al->sym->start));
 			ret = strlist__has_entry(symbol_conf.sym_list,
-- 
2.21.1
