From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v5 2/3] perf report: extend raw dump (-D) out with switch out
 event type
Date: Mon, 9 Apr 2018 10:26:05 +0300
Message-ID: <6f5aebb9-b96c-f304-f08f-8f046d38de4f@linux.intel.com>
References: <ff228fc5-5742-a5fe-8cad-79704742672c@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ff228fc5-5742-a5fe-8cad-79704742672c@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org


Print additional 'preempt' tag for PERF_RECORD_SWITCH[_CPU_WIDE] OUT records when
event header misc field contains PERF_RECORD_MISC_SWITCH_OUT_PREEMPT bit set 
designating preemption context switch out event:

tools/perf/perf report -D -i perf.data | grep _SWITCH

0 768361415226 0x27f076 [0x28]: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:     8/8    
4 768362216813 0x28f45e [0x28]: PERF_RECORD_SWITCH_CPU_WIDE OUT          next pid/tid:     0/0    
4 768362217824 0x28f486 [0x28]: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:  4073/4073 
0 768362414027 0x27f0ce [0x28]: PERF_RECORD_SWITCH_CPU_WIDE OUT preempt  next pid/tid:     8/8    
0 768362414367 0x27f0f6 [0x28]: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:     0/0    

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/util/event.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index f0a6cbd033cc..98ff3a6a3d50 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1421,7 +1421,9 @@ size_t perf_event__fprintf_itrace_start(union perf_event *event, FILE *fp)
 size_t perf_event__fprintf_switch(union perf_event *event, FILE *fp)
 {
 	bool out = event->header.misc & PERF_RECORD_MISC_SWITCH_OUT;
-	const char *in_out = out ? "OUT" : "IN ";
+	const char *in_out = !out ? "IN         " :
+		!(event->header.misc & PERF_RECORD_MISC_SWITCH_OUT_PREEMPT) ?
+				    "OUT        " : "OUT preempt";
 
 	if (event->header.type == PERF_RECORD_SWITCH)
 		return fprintf(fp, " %s\n", in_out);
