From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 36/66] libperf: Add missing 'struct xyarray' forward declaration
Date: Wed, 25 Sep 2019 21:32:14 -0300
Message-ID: <20190926003244.13962-37-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We were getting it by luck, from files included before internal/evsel.h
where it is being included.

Fixes: 9dfcb7599084 ("libperf: Move fd array from perf's evsel to lobperf's perf_evsel class")
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: https://lkml.kernel.org/n/tip-r8ukhxprpkflbd2k9vcc42v1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/internal/evsel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/lib/include/internal/evsel.h b/tools/perf/lib/include/internal/evsel.h
index 1bff789b0923..60daee6db914 100644
--- a/tools/perf/lib/include/internal/evsel.h
+++ b/tools/perf/lib/include/internal/evsel.h
@@ -8,6 +8,7 @@
 
 struct perf_cpu_map;
 struct perf_thread_map;
+struct xyarray;
 
 struct perf_evsel {
 	struct list_head	 node;
-- 
2.21.0
