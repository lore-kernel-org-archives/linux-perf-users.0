From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 29/29] perf session: Add comment for perf_session__register_idle_thread()
Date: Thu,  3 Jan 2019 09:46:09 -0300
Message-ID: <20190103124609.29672-30-acme@kernel.org>
References: <20190103124609.29672-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190103124609.29672-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add a comment to perf_session__register_idle_thread() to bring attention to
a pitfall with the idle task thread structure. The pitfall is that there
should really be a 'struct thread' for the idle task of each cpu, but there
is only one that can have pid == tid == 0.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20181221120620.9659-9-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 78a067777144..5456c84c7dd1 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1527,6 +1527,13 @@ struct thread *perf_session__findnew(struct perf_session *session, pid_t pid)
 	return machine__findnew_thread(&session->machines.host, -1, pid);
 }
 
+/*
+ * Threads are identified by pid and tid, and the idle task has pid == tid == 0.
+ * So here a single thread is created for that, but actually there is a separate
+ * idle task per cpu, so there should be one 'struct thread' per cpu, but there
+ * is only 1. That causes problems for some tools, requiring workarounds. For
+ * example get_idle_thread() in builtin-sched.c, or thread_stack__per_cpu().
+ */
 int perf_session__register_idle_thread(struct perf_session *session)
 {
 	struct thread *thread;
-- 
2.19.2
