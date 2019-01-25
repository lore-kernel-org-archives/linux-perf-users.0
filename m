From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/29] perf bpf: Fix synthesized PERF_RECORD_KSYMBOL/BPF_EVENT
Date: Sat, 26 Jan 2019 00:18:31 +0100
Message-ID: <20190125231843.2895-18-acme@kernel.org>
References: <20190125231843.2895-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125231843.2895-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com
List-Id: linux-perf-users.vger.kernel.org

From: Song Liu <songliubraving@fb.com>

Added missing machine->id_hdr_size to event->header.size. Also fixed
size of PERF_RECORD_KSYMBOL by removing extra bytes for name.

Committer notes:

We need to malloc that extra machine->id_hdr_size at the start of
perf_event__synthesize_bpf_events() and also need to cast the event to
(void *) otherwise we segfault, fix it.

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Suggested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Song Liu <songliubraving@fb.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-team@fb.com
Fixes: 7b612e291a5a ("perf tools: Synthesize PERF_RECORD_* for loaded BPF programs")
Link: http://lkml.kernel.org/r/20190122210218.358664-1-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-event.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 01e1dc1bb7fb..796ef793f4ce 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -7,6 +7,7 @@
 #include "bpf-event.h"
 #include "debug.h"
 #include "symbol.h"
+#include "machine.h"
 
 #define ptr_to_u64(ptr)    ((__u64)(unsigned long)(ptr))
 
@@ -149,7 +150,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
 		*ksymbol_event = (struct ksymbol_event){
 			.header = {
 				.type = PERF_RECORD_KSYMBOL,
-				.size = sizeof(struct ksymbol_event),
+				.size = offsetof(struct ksymbol_event, name),
 			},
 			.addr = prog_addrs[i],
 			.len = prog_lens[i],
@@ -178,6 +179,9 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
 
 		ksymbol_event->header.size += PERF_ALIGN(name_len + 1,
 							 sizeof(u64));
+
+		memset((void *)event + event->header.size, 0, machine->id_hdr_size);
+		event->header.size += machine->id_hdr_size;
 		err = perf_tool__process_synth_event(tool, event,
 						     machine, process);
 	}
@@ -194,6 +198,8 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
 			.id = info.id,
 		};
 		memcpy(bpf_event->tag, prog_tags[i], BPF_TAG_SIZE);
+		memset((void *)event + event->header.size, 0, machine->id_hdr_size);
+		event->header.size += machine->id_hdr_size;
 		err = perf_tool__process_synth_event(tool, event,
 						     machine, process);
 	}
@@ -217,7 +223,7 @@ int perf_event__synthesize_bpf_events(struct perf_tool *tool,
 	int err;
 	int fd;
 
-	event = malloc(sizeof(event->bpf_event) + KSYM_NAME_LEN);
+	event = malloc(sizeof(event->bpf_event) + KSYM_NAME_LEN + machine->id_hdr_size);
 	if (!event)
 		return -1;
 	while (true) {
-- 
2.20.1
