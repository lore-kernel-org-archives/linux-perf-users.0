From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/13] perf event-parse: Use fixed size string for comms
Date: Mon,  3 Sep 2018 11:52:22 -0300
Message-ID: <20180903145224.12318-12-acme@kernel.org>
References: <20180903145224.12318-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180903145224.12318-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Chris Phlipot <cphlipot0@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Chris Phlipot <cphlipot0@gmail.com>

Some implementations of libc do not support the 'm' width modifier as
part of the scanf string format specifier. This can cause the parsing to
fail.  Since the parser never checks if the scanf parsing was
successesful, this can result in a crash.

Change the comm string to be allocated as a fixed size instead of
dynamically using 'm' scanf width modifier. This can be safely done
since comm size is limited to 16 bytes by TASK_COMM_LEN within the
kernel.

This change prevents perf from crashing when linked against bionic as
well as reduces the total number of heap allocations and frees invoked
while accomplishing the same task.

Signed-off-by: Chris Phlipot <cphlipot0@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830021950.15563-1-cphlipot0@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/trace-event-parse.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
index 920b1d58a068..e76214f8d596 100644
--- a/tools/perf/util/trace-event-parse.c
+++ b/tools/perf/util/trace-event-parse.c
@@ -164,16 +164,15 @@ void parse_ftrace_printk(struct tep_handle *pevent,
 void parse_saved_cmdline(struct tep_handle *pevent,
 			 char *file, unsigned int size __maybe_unused)
 {
-	char *comm;
+	char comm[17]; /* Max comm length in the kernel is 16. */
 	char *line;
 	char *next = NULL;
 	int pid;
 
 	line = strtok_r(file, "\n", &next);
 	while (line) {
-		sscanf(line, "%d %ms", &pid, &comm);
-		tep_register_comm(pevent, comm, pid);
-		free(comm);
+		if (sscanf(line, "%d %16s", &pid, comm) == 2)
+			tep_register_comm(pevent, comm, pid);
 		line = strtok_r(NULL, "\n", &next);
 	}
 }
-- 
2.14.4
