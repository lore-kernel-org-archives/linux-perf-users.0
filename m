From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: [PATCH perf/core 16/22] perf: Fix __cmd_top and
 perf_session__process_events to put the idle thread
Date: Wed, 09 Dec 2015 11:11:23 +0900
Message-ID: <20151209021122.10245.69707.stgit@localhost.localdomain>
References: <20151209021047.10245.8918.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151209021047.10245.8918.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Since perf_session__register_idle_thread() got the idle thread,
caller functions have to put it afterwards.
Note that since the thread was already inserted to the session
list, it will be released when the session is released.
Also, in perf_session__register_idle_thread() failure path,
the thread should be put before returning.

Refcnt debugger shows that the perf_session__register_idle_thread
gets the returned thread, but the caller (__cmd_top) does not
put the returned idle thread.

  ----
  ==== [0] ====
  Unreclaimed thread@0x24e6240
  Refcount +1 => 0 at
    ./perf(thread__new+0xe5) [0x4c8a75]
    ./perf(machine__findnew_thread+0x9a) [0x4bbdba]
    ./perf(perf_session__register_idle_thread+0x28) [0x4c63c8]
    ./perf(cmd_top+0xd7d) [0x43cf6d]
    ./perf() [0x47ba35]
    ./perf(main+0x617) [0x4225b7]
    /lib64/libc.so.6(__libc_start_main+0xf5) [0x7f06027c5af5]
    ./perf() [0x42272d]
  Refcount +1 => 1 at
    ./perf(thread__get+0x2c) [0x4c8bcc]
    ./perf(machine__findnew_thread+0xee) [0x4bbe0e]
    ./perf(perf_session__register_idle_thread+0x28) [0x4c63c8]
    ./perf(cmd_top+0xd7d) [0x43cf6d]
    ./perf() [0x47ba35]
    ./perf(main+0x617) [0x4225b7]
    /lib64/libc.so.6(__libc_start_main+0xf5) [0x7f06027c5af5]
    ./perf() [0x42272d]
  Refcount +1 => 2 at
    ./perf(thread__get+0x2c) [0x4c8bcc]
    ./perf(machine__findnew_thread+0x112) [0x4bbe32]
    ./perf(perf_session__register_idle_thread+0x28) [0x4c63c8]
    ./perf(cmd_top+0xd7d) [0x43cf6d]
    ./perf() [0x47ba35]
    ./perf(main+0x617) [0x4225b7]
    /lib64/libc.so.6(__libc_start_main+0xf5) [0x7f06027c5af5]
    ./perf() [0x42272d]
  ----

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
---
 tools/perf/builtin-top.c  |    6 +++++-
 tools/perf/util/session.c |   10 +++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 7e2e72e..430177f 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -945,6 +945,7 @@ static int perf_top__setup_sample_type(struct perf_top *top __maybe_unused)
 static int __cmd_top(struct perf_top *top)
 {
 	struct record_opts *opts = &top->record_opts;
+	struct thread *idle;
 	pthread_t thread;
 	int ret;
 
@@ -964,8 +965,11 @@ static int __cmd_top(struct perf_top *top)
 	if (ret)
 		goto out_delete;
 
-	if (perf_session__register_idle_thread(top->session) == NULL)
+	idle = perf_session__register_idle_thread(top->session);
+	if (idle == NULL)
 		goto out_delete;
+	/* perf_session__register_idle_thread() got the returned thread. */
+	thread__put(idle);
 
 	machine__synthesize_threads(&top->session->machines.host, &opts->target,
 				    top->evlist->threads, false, opts->proc_map_timeout);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index c35ffdd..ee16228 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1318,6 +1318,8 @@ struct thread *perf_session__register_idle_thread(struct perf_session *session)
 	thread = machine__findnew_thread(&session->machines.host, 0, 0);
 	if (thread == NULL || thread__set_comm(thread, "swapper", 0)) {
 		pr_err("problem inserting idle task.\n");
+		/* machine__findnew_thread() got the thread, so put it */
+		thread__put(thread);
 		thread = NULL;
 	}
 
@@ -1674,10 +1676,16 @@ out_err:
 int perf_session__process_events(struct perf_session *session)
 {
 	u64 size = perf_data_file__size(session->file);
+	struct thread *idle = perf_session__register_idle_thread(session);
 	int err;
 
-	if (perf_session__register_idle_thread(session) == NULL)
+	if (idle == NULL)
 		return -ENOMEM;
+	/*
+	 * Since perf_session__register_idle_thread() got the idle thread,
+	 * we have to put it here.
+	 */
+	thread__put(idle);
 
 	if (!perf_data_file__is_pipe(session->file))
 		err = __perf_session__process_events(session,
