From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/13] perf auxtrace: Make auxtrace_queues__add_buffer() do CPU filtering
Date: Mon,  9 Apr 2018 16:34:31 -0300
Message-ID: <20180409193437.14199-8-acme@kernel.org>
References: <20180409193437.14199-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180409193437.14199-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

In preparation for supporting AUX area sampling buffers,
auxtrace_queues__add_buffer() needs to be more generic. To that end, move
CPU filtering into it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/1520327598-1317-8-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index e1aff91c54a8..857de69a5361 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -302,6 +302,13 @@ static int auxtrace_queues__split_buffer(struct auxtrace_queues *queues,
 	return 0;
 }
 
+static bool filter_cpu(struct perf_session *session, int cpu)
+{
+	unsigned long *cpu_bitmap = session->itrace_synth_opts->cpu_bitmap;
+
+	return cpu_bitmap && cpu != -1 && !test_bit(cpu, cpu_bitmap);
+}
+
 static int auxtrace_queues__add_buffer(struct auxtrace_queues *queues,
 				       struct perf_session *session,
 				       unsigned int idx,
@@ -310,6 +317,9 @@ static int auxtrace_queues__add_buffer(struct auxtrace_queues *queues,
 {
 	int err = -ENOMEM;
 
+	if (filter_cpu(session, buffer->cpu))
+		return 0;
+
 	buffer = memdup(buffer, sizeof(*buffer));
 	if (!buffer)
 		return -ENOMEM;
@@ -344,13 +354,6 @@ static int auxtrace_queues__add_buffer(struct auxtrace_queues *queues,
 	return err;
 }
 
-static bool filter_cpu(struct perf_session *session, int cpu)
-{
-	unsigned long *cpu_bitmap = session->itrace_synth_opts->cpu_bitmap;
-
-	return cpu_bitmap && cpu != -1 && !test_bit(cpu, cpu_bitmap);
-}
-
 int auxtrace_queues__add_event(struct auxtrace_queues *queues,
 			       struct perf_session *session,
 			       union perf_event *event, off_t data_offset,
@@ -367,9 +370,6 @@ int auxtrace_queues__add_event(struct auxtrace_queues *queues,
 	};
 	unsigned int idx = event->auxtrace.idx;
 
-	if (filter_cpu(session, event->auxtrace.cpu))
-		return 0;
-
 	return auxtrace_queues__add_buffer(queues, session, idx, &buffer,
 					   buffer_ptr);
 }
-- 
2.14.3
