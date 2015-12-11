From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH perf/core  00/22] perf refcnt debugger API and fixes
Date: Fri, 11 Dec 2015 19:26:21 -0300
Message-ID: <20151211222621.GE6843@kernel.org>
References: <20151209021047.10245.8918.stgit@localhost.localdomain>
 <20151209134138.GB15864@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33517 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753581AbbLKW01 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 11 Dec 2015 17:26:27 -0500
Content-Disposition: inline
In-Reply-To: <20151209134138.GB15864@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>, Wang Nan <wangnan0@huawei.com>, Alexei Starovoitov <ast@plumgrid.com>

Em Wed, Dec 09, 2015 at 10:41:38AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Dec 09, 2015 at 11:10:48AM +0900, Masami Hiramatsu escreveu:
> >   General refcnt miscodings
> >   =========================
> > 
> > BTW, while applying this change, I've found that there are refcnt
> > coding mismatches in those code and most of the bugs come from those
> > mismatches.
> > 
> > - The reference counter can be initialized by 0 or 1.
> >  - If 0 is chosen, caller have to get it and free it if failed to
> >    register appropriately.
> >  - If 1 is chosen, caller doesn't need to get it, but when exits the
> >    caller, it has to put it. (except for returning the object itself)
> > - The application should choose either one as its policy, to avoid
> >   confusion.
> > 
> > perf tools mixes it up (moreover, it initializes 2 in a case) and
> > caller usually forgets to put it (it is not surprising, because too
> > many "put" usually cause SEGV by accessing freed object.)
> 
> Well, we should fix the bugs and document why some initialization is
> deemed better than a single initialization style.
 
> For instance, if we know that we will keep multiple references straight
> away, then we could init it with some value different that preferred,
> that I aggee, is 1, i.e. the usual way for some constructor is:
> 
> 
> struct foo *foo__new()
> {
> 	struct foo *f = malloc(sizeof (*f));
> 
> 	if (f) {
> 		atomic_set(&f->refcnt, 1);
> 	}
> 
> 	return f;
> }
> 
> void *foo__delete(struct foo *f)
> {
> 	free(f);
> }
> 
> void foo__put(struct foo *f)
> {
> 	if (f && atomic_dec_and_test(f->refcnt))
> 		foo__delete(f);
> }
> 
> 
> Then, when using if, and before adding it to any other tree, list, i.e.
> a container, we do:
> 
> 	struct foo *f = foo__new();
> 
> 	/*
> 	 * assume f was allocated and then the function allocating it
> 	 * failed, when it bails out it should just do:
>  	 */
> out_error:
> 	foo__put(f);
> 
> And that will make it hit zero, which will call foo__delete(), case
> closed.
>  
> > As far as I can see, cgroup_sel, perf_mmap(this is initialized 0 or 2...),
> > thread, and comm_str are initialized by 0. Others are initialized by 1.
> > 
> > So, I'd like to suggest that we choose one policy and cleanup the code.
> > I recommend to use init by 1 policy, because anyway caller has to get
> 
> See above, if nothing else recommends using a different value, use 1.

So, I think I fixed the thread->refcnt case, please take a look at my
perf/core branch, more specifically this patch:

From a9a8442c64a86599600ecb2ae0f296b5c93e2a98 Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Fri, 11 Dec 2015 19:11:23 -0300
Subject: [PATCH 1/1] perf thread: Fix reference count initial state

We should always return from thread__new(), the constructor, with the
object with a reference count of one, so that:

     struct thread *thread = thread__new();
     thread__put(thread);

Will call thread__delete().

If any reference is made to that 'thread' variable, it better use
thread__get(thread) to hold a reference.

We were returning with thread->refcnt set to zero, fix it and some cases
where thread__delete() was being called, which were not a problem
because just one reference was being used, now that we set it to 1, use
thread__put() instead.

Reported-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-4b9mkuk66to4ecckpmpvqx6s@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c |  4 ++--
 tools/perf/util/machine.c  | 19 ++++++++++++-------
 tools/perf/util/thread.c   | 10 ++++++++--
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 97f963a3dcb9..81a2eb77ba7f 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1744,7 +1744,7 @@ static void intel_pt_free(struct perf_session *session)
 	auxtrace_heap__free(&pt->heap);
 	intel_pt_free_events(session);
 	session->auxtrace = NULL;
-	thread__delete(pt->unknown_thread);
+	thread__put(pt->unknown_thread);
 	free(pt);
 }
 
@@ -2153,7 +2153,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 	return 0;
 
 err_delete_thread:
-	thread__delete(pt->unknown_thread);
+	thread__zput(pt->unknown_thread);
 err_free_queues:
 	intel_pt_log_disable();
 	auxtrace_queues__free(&pt->queues);
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 1407d5107480..ad79297c76c8 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -352,13 +352,18 @@ static void machine__update_thread_pid(struct machine *machine,
 	}
 
 	th->mg = map_groups__get(leader->mg);
-
+out_put:
+	thread__put(leader);
 	return;
-
 out_err:
 	pr_err("Failed to join map groups for %d:%d\n", th->pid_, th->tid);
+	goto out_put;
 }
 
+/*
+ * Caller must eventually drop thread->refcnt returned with a successfull
+ * lookup/new thread inserted.
+ */
 static struct thread *____machine__findnew_thread(struct machine *machine,
 						  pid_t pid, pid_t tid,
 						  bool create)
@@ -376,7 +381,7 @@ static struct thread *____machine__findnew_thread(struct machine *machine,
 	if (th != NULL) {
 		if (th->tid == tid) {
 			machine__update_thread_pid(machine, th, pid);
-			return th;
+			return thread__get(th);
 		}
 
 		machine->last_match = NULL;
@@ -389,7 +394,7 @@ static struct thread *____machine__findnew_thread(struct machine *machine,
 		if (th->tid == tid) {
 			machine->last_match = th;
 			machine__update_thread_pid(machine, th, pid);
-			return th;
+			return thread__get(th);
 		}
 
 		if (tid < th->tid)
@@ -417,7 +422,7 @@ static struct thread *____machine__findnew_thread(struct machine *machine,
 		if (thread__init_map_groups(th, machine)) {
 			rb_erase_init(&th->rb_node, &machine->threads);
 			RB_CLEAR_NODE(&th->rb_node);
-			thread__delete(th);
+			thread__put(th);
 			return NULL;
 		}
 		/*
@@ -441,7 +446,7 @@ struct thread *machine__findnew_thread(struct machine *machine, pid_t pid,
 	struct thread *th;
 
 	pthread_rwlock_wrlock(&machine->threads_lock);
-	th = thread__get(__machine__findnew_thread(machine, pid, tid));
+	th = __machine__findnew_thread(machine, pid, tid);
 	pthread_rwlock_unlock(&machine->threads_lock);
 	return th;
 }
@@ -451,7 +456,7 @@ struct thread *machine__find_thread(struct machine *machine, pid_t pid,
 {
 	struct thread *th;
 	pthread_rwlock_rdlock(&machine->threads_lock);
-	th =  thread__get(____machine__findnew_thread(machine, pid, tid, false));
+	th =  ____machine__findnew_thread(machine, pid, tid, false);
 	pthread_rwlock_unlock(&machine->threads_lock);
 	return th;
 }
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 0a9ae8014729..dfd00c6dad6e 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -19,8 +19,10 @@ int thread__init_map_groups(struct thread *thread, struct machine *machine)
 		thread->mg = map_groups__new(machine);
 	} else {
 		leader = __machine__findnew_thread(machine, pid, pid);
-		if (leader)
+		if (leader) {
 			thread->mg = map_groups__get(leader->mg);
+			thread__put(leader);
+		}
 	}
 
 	return thread->mg ? 0 : -1;
@@ -53,7 +55,7 @@ struct thread *thread__new(pid_t pid, pid_t tid)
 			goto err_thread;
 
 		list_add(&comm->list, &thread->comm_list);
-		atomic_set(&thread->refcnt, 0);
+		atomic_set(&thread->refcnt, 1);
 		RB_CLEAR_NODE(&thread->rb_node);
 	}
 
@@ -95,6 +97,10 @@ struct thread *thread__get(struct thread *thread)
 void thread__put(struct thread *thread)
 {
 	if (thread && atomic_dec_and_test(&thread->refcnt)) {
+		/*
+		 * Remove it from the dead_threads list, as last reference
+		 * is gone.
+		 */
 		list_del_init(&thread->node);
 		thread__delete(thread);
 	}
-- 
2.1.0
