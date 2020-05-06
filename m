From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 38/91] perf tools: Simplify checking if SMT is active.
Date: Wed,  6 May 2020 12:21:41 -0300
Message-ID: <20200506152234.21977-39-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Andi Kleen <ak@linux.intel.com>, Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

SMT now could be disabled via "/sys/devices/system/cpu/smt/control".

Status is shown in "/sys/devices/system/cpu/smt/active" simply as "0" / "1".

If this knob isn't here then fallback to checking topology as before.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/158817741394.748034.9273604089138009552.stgit@buzz
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/smt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
index 8481842e9edb..20bacd5972ad 100644
--- a/tools/perf/util/smt.c
+++ b/tools/perf/util/smt.c
@@ -15,6 +15,9 @@ int smt_on(void)
 	if (cached)
 		return cached_result;
 
+	if (sysfs__read_int("devices/system/cpu/smt/active", &cached_result) > 0)
+		goto done;
+
 	ncpu = sysconf(_SC_NPROCESSORS_CONF);
 	for (cpu = 0; cpu < ncpu; cpu++) {
 		unsigned long long siblings;
@@ -42,6 +45,7 @@ int smt_on(void)
 	}
 	if (!cached) {
 		cached_result = 0;
+done:
 		cached = true;
 	}
 	return cached_result;
-- 
2.21.1
