From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/14] perf session: Add missing swap ops for namespace events
Date: Tue, 28 May 2019 14:50:16 -0300
Message-ID: <20190528175020.13343-11-acme@kernel.org>
References: <20190528175020.13343-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190528175020.13343-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Hari Bathini <hbathini@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Krister Johansen <kjlx@templeofstupid.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

In case it's recorded in a different arch.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com> <hbathini@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Krister Johansen <kjlx@templeofstupid.com>
Fixes: f3b3614a284d ("perf tools: Add PERF_RECORD_NAMESPACES to include namespaces related info")
Link: http://lkml.kernel.org/r/20190522053250.207156-3-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 2310a1752983..54cf163347f7 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -647,6 +647,26 @@ static void perf_event__throttle_swap(union perf_event *event,
 		swap_sample_id_all(event, &event->throttle + 1);
 }
 
+static void perf_event__namespaces_swap(union perf_event *event,
+					bool sample_id_all)
+{
+	u64 i;
+
+	event->namespaces.pid		= bswap_32(event->namespaces.pid);
+	event->namespaces.tid		= bswap_32(event->namespaces.tid);
+	event->namespaces.nr_namespaces	= bswap_64(event->namespaces.nr_namespaces);
+
+	for (i = 0; i < event->namespaces.nr_namespaces; i++) {
+		struct perf_ns_link_info *ns = &event->namespaces.link_info[i];
+
+		ns->dev = bswap_64(ns->dev);
+		ns->ino = bswap_64(ns->ino);
+	}
+
+	if (sample_id_all)
+		swap_sample_id_all(event, &event->namespaces.link_info[i]);
+}
+
 static u8 revbyte(u8 b)
 {
 	int rev = (b >> 4) | ((b & 0xf) << 4);
@@ -887,6 +907,7 @@ static perf_event__swap_op perf_event__swap_ops[] = {
 	[PERF_RECORD_LOST_SAMPLES]	  = perf_event__all64_swap,
 	[PERF_RECORD_SWITCH]		  = perf_event__switch_swap,
 	[PERF_RECORD_SWITCH_CPU_WIDE]	  = perf_event__switch_swap,
+	[PERF_RECORD_NAMESPACES]	  = perf_event__namespaces_swap,
 	[PERF_RECORD_HEADER_ATTR]	  = perf_event__hdr_attr_swap,
 	[PERF_RECORD_HEADER_EVENT_TYPE]	  = perf_event__event_type_swap,
 	[PERF_RECORD_HEADER_TRACING_DATA] = perf_event__tracing_data_swap,
-- 
2.20.1
