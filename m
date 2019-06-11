From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/85] perf tools: Add IPC information to perf_sample
Date: Tue, 11 Jun 2019 15:57:55 -0300
Message-ID: <20190611185911.11645-10-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add counts of instructions and cycles, in order to represent
instructions-per-cycle (IPC).

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-7-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/event.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 9e999550f247..1f1da6082806 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -204,6 +204,8 @@ struct perf_sample {
 	u64 period;
 	u64 weight;
 	u64 transaction;
+	u64 insn_cnt;
+	u64 cyc_cnt;
 	u32 cpu;
 	u32 raw_size;
 	u64 data_src;
-- 
2.20.1
