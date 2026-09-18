Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12424FDA5A
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789740448; cv=none; b=W+RggOBYQbknzTucNLE1+PcxetkumbC4FMbYBWSjmyKbLn16xuytQB2TbtyPiQC+CHQ42qRl9+5RaOr3FlYP5szORftBDp2HQz0huM2fU6nUhoYjVlcyHirWxBB9SJ27bufW9OmEUdjDmN1ehA+jyPapHLDnGq/16E3mUPNFA90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789740448; c=relaxed/simple;
	bh=1L9Gtjsw7/vGFr5x+phwALZyTUxzyJZRMY1VfeZr7L0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H0wRz2WWNuunF7RxrEc4LrM79cJ6/F94l+uF93UD4kZFNmj0AO86hlpMTTXfrzupO5ONvnvJA/qVMkqcVNFZL2x2ZKbosXwEiWbGG931ZqjTDo0xhif7Kw7/e/gXd7xxgcTFq//tnJLJVdJvIlBDGmQjkOeClnGjzNBqAsId6Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kIi0nkTS; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kIi0nkTS"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e8e864ef0so1565824a91.0
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 07:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789740445; x=1790345245; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vcUkvKf8vM1mu+qdUkPQj6QInmuMOdGHw3tXI+H/Ouk=;
        b=kIi0nkTS+uOeqCzGGTNVN198x2dU9PwXPeWoeE92coPe+FBfU6EYHKb/Hn4bxdsz6j
         gz4+OrCcl95kQa2x1FKExxfeDGyypXKYnNckNLCWLRzbm5ZND0KgQ/Lcp5j8YyxdQ9Di
         XrawhLcUbhaJxQ6umeCHxxP900HvOxpMXteeLj2UAfMcKK1cTIS6CvcdKzIBD7Ko3jcb
         6Zr/qk4NdCB5u6nyahqNay8NIvvlkJJZOTR11ImYWPovTEr9DJffY5YwS5BlbqplPgXh
         wQF4ZRH6M3JAXHDjovg+qWP+fsyweS5ilsal8fG4XY0BfaBqQOaFJ9B3IU1H4UpiVO6j
         U6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789740445; x=1790345245;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vcUkvKf8vM1mu+qdUkPQj6QInmuMOdGHw3tXI+H/Ouk=;
        b=q2KeMko0nucoRVxBSTP0ApqrJKynNDaigSUmg3hufnxy+Ua361dJ/s6WheRfV+85Fx
         6g1ZYVjyqOiRP4UYVI3a+UTaixMl4ckALTfV1bvxLPWt2lmEMDk0phuVYhPCS3ZhUpPM
         gcv9h/z8cfaqVNYVMmI9Qxr+uBLcbRYxkqV4tCpSGawuuvfvNSemtWb3TOGLnIP2EeGm
         +bTV1m00G8OTr26XqpIDxHX7Ql0cTZPoVMWaSPaWQ9Tf6chKfgc6CvOhF3NUkwXsjTzK
         yDnR07NuZ4xCeLrkTDb6+S2UIIfGH5Pj77pcUHDdCk+FF1QRP2AWSIGlQXX7W5FbFcAJ
         AfMA==
X-Forwarded-Encrypted: i=1; AKwUvBzhwfPVd80XIbB1z7B6CZvAf7O5OAvwK/tXGMy+ze9XsAOR0acyOS6q+x3meYivH+i3zP0ex0XTeV2jJXY8+0zt@vger.kernel.org
X-Gm-Message-State: AFuF++loSKjmKnE7OtXDKvVbRjYZdpTSZl7VLtnwUgD/dcoNxTU2NPij
	onwzCa3qNnA4O7a2Fkh8raqA8KR8XY9qRhAgcZ9SewVQl1/gf6XU6RSn4Uchs2QSbW98qyxOi5m
	16rFGY0aiQg==
X-Received: from dlbrs5.prod.google.com ([2002:a05:7022:f685:b0:143:dfee:bf83])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b43:b0:39e:423:bb8f
 with SMTP id 98e67ed59e1d1-39e54d38b4amr10839701a91.1.1789740445248; Fri, 18
 Sep 2026 07:07:25 -0700 (PDT)
Date: Fri, 18 Sep 2026 07:06:51 -0700
In-Reply-To: <20260918140659.2501976-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789662556.git.irogers@google.com> <20260918140659.2501976-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918140659.2501976-9-irogers@google.com>
Subject: [PATCH v3 08/16] perf trace: Enumerate the target again once BPF is attached
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

evlist__create_maps() reads the target out of /proc, and the BPF
sched_process_fork() program only sees what is cloned once it is
attached. A task the target creates between the two is in neither, and
since cmd_trace() drops the sys_enter evsel in favour of
__augmented_syscalls__ there is no other source of enter events. Such a
task, and in turn everything it forks, goes unreported for the rest of
the session.

Read the target out of /proc once more, after the attach. Whatever
existed before the programs went live is there to be found, and whatever
is created after it is sched_process_fork()'s to add, so between them
nothing is left out. Doing this before the attach instead would only
move the window rather than close it.

The enumeration follows the same rule as the BPF programs, which is that
the maps name individual tasks:

 - -p names a process, so its thread group is read from
   /proc/<pid>/task.
 - -t names a thread, which is taken on its own. Expanding it to its
   thread group would trace the siblings it asked to leave out.
 - Descendants come from task->children, read through
   /proc/<pid>/task/<tid>/children. A forked task leads a thread group
   of its own, so each one found is walked in turn and a tree of any
   depth is covered. New threads are not listed there, copy_process()
   gives a CLONE_THREAD child the real_parent of its creator rather than
   the creator itself, but the thread group walk above has them.

The other two ways of choosing what to trace need nothing, for the same
reasons the window never affected them: 'perf trace -a' does not filter
on pid at all, and evlist__prepare_workload() keeps a workload blocked
on a pipe until evlist__start_workload(), well after the attach.

A target that exits during startup is not an error. Reading /proc for a
task that has gone fails with ENOENT, and a task directory that is read
but has nothing in it sets nothing at all, so errno is cleared before the
enumeration and only an allocation failure is passed back. Anything else
leaves the tasks that evlist__create_maps() already found in the map,
which sched_process_exit() takes out again as they die, and the session
runs on rather than being ended over a target that was going to stop
producing events anyway.

What is left is smaller and no longer lasts. A task found here may have
made syscalls between sys_enter going live and it being added to the
map, and those are not reported, but it is traced from that point on. On
a kernel built without CONFIG_PROC_CHILDREN the children files are
absent and descendants cannot be named, leaving the threads of the
target, which are still picked up.

pid_t, PATH_MAX, FILE and the directory reading are all used directly by
the new code, so <sys/types.h>, <limits.h>, <stdio.h> and <dirent.h> are
included rather than relied upon to arrive through another header.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 233 +++++++++++++++++++++++++++++++++++++
 1 file changed, 233 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 914e6e4b34f8..56bec2dfeb4e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -15,6 +15,7 @@
  */
 
 #include "util/record.h"
+#include <api/fs/fs.h>
 #include <api/fs/tracing_path.h>
 #ifdef HAVE_LIBBPF_SUPPORT
 #include <bpf/bpf.h>
@@ -65,11 +66,15 @@
 #include "trace_augment.h"
 #include "dwarf-regs.h"
 
+#include <dirent.h>
 #include <errno.h>
 #include <sys/stat.h>
+#include <sys/types.h>
 #include <inttypes.h>
+#include <limits.h>
 #include <poll.h>
 #include <signal.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <linux/err.h>
@@ -4638,6 +4643,224 @@ static int trace__set_filter_pids(struct trace *trace)
 	return err;
 }
 
+/* A list of pids that grows as it is added to, holding each pid once. */
+struct pid_list {
+	pid_t	*entries;
+	size_t	nr;
+	size_t	allocated;
+};
+
+static bool pid_list__has(const struct pid_list *list, pid_t pid)
+{
+	for (size_t i = 0; i < list->nr; i++) {
+		if (list->entries[i] == pid)
+			return true;
+	}
+	return false;
+}
+
+/* Append pid, unless it is already there. */
+static int pid_list__add(struct pid_list *list, pid_t pid)
+{
+	if (pid_list__has(list, pid))
+		return 0;
+
+	if (list->nr == list->allocated) {
+		size_t allocated = list->allocated ? list->allocated * 2 : 32;
+		pid_t *entries = realloc(list->entries, allocated * sizeof(*entries));
+
+		if (entries == NULL)
+			return -ENOMEM;
+
+		list->entries = entries;
+		list->allocated = allocated;
+	}
+
+	list->entries[list->nr++] = pid;
+	return 0;
+}
+
+static void pid_list__exit(struct pid_list *list)
+{
+	zfree(&list->entries);
+	list->nr = 0;
+	list->allocated = 0;
+}
+
+/*
+ * Append the tasks tid has forked to tgids.
+ *
+ * task->children holds what a task forked, and a forked task leads a thread
+ * group of its own, so each is something to expand in turn. New threads are
+ * not listed: copy_process() gives a CLONE_THREAD child the real_parent of
+ * its creator rather than the creator itself, so a thread is a sibling of the
+ * task that created it. Those are enumerated from the task directory instead.
+ */
+static int pid_list__add_children(struct pid_list *tgids, pid_t tid)
+{
+	char path[PATH_MAX];
+	pid_t child;
+	FILE *fp;
+	int err = 0;
+
+	scnprintf(path, sizeof(path), "%s/%d/task/%d/children",
+		  procfs__mountpoint(), tid, tid);
+	fp = fopen(path, "r");
+	/*
+	 * Absent if the task exited, and on a kernel built without
+	 * CONFIG_PROC_CHILDREN. Neither is worth failing for: what is missed
+	 * is a task that has gone away, or descendants the kernel will not
+	 * name.
+	 */
+	if (fp == NULL)
+		return 0;
+
+	while (fscanf(fp, "%d", &child) == 1) {
+		err = pid_list__add(tgids, child);
+		if (err)
+			break;
+	}
+
+	fclose(fp);
+	return err;
+}
+
+/*
+ * Collect the tasks to trace: the target, its threads, and everything they
+ * have forked.
+ *
+ * tgids is the queue of thread groups still to expand. It is walked as it
+ * grows, so a child found here has its own children picked up in a later
+ * pass and the depth of the tree does not matter. The walk terminates
+ * because a task cannot be its own ancestor and pid_list__add() ignores a
+ * pid that is already listed.
+ */
+static int trace__collect_target_pids(struct trace *trace, struct pid_list *pids)
+{
+	struct target *target = &trace->opts.target;
+	/*
+	 * -p names processes, so the whole thread group is a target. -t names
+	 * threads, and expanding one to its group would trace the siblings
+	 * that were deliberately left out.
+	 */
+	bool whole_group = target->pid != NULL;
+	struct perf_thread_map *threads;
+	struct pid_list tgids = {};
+	int err = 0;
+
+	/* Enumerate the target as evlist__create_maps() did, but now. */
+	errno = 0;
+	threads = thread_map__new_str(target->pid, target->tid, target->per_thread);
+	if (threads == NULL) {
+		char bf[128];
+
+		/*
+		 * A target that exited while perf trace was starting up shows
+		 * up here as a failure to read /proc/<pid>/task, with scandir()
+		 * setting ENOENT, or as a task directory that is read but has
+		 * nothing in it, which sets nothing at all and is why errno is
+		 * cleared above. Neither is worth ending the session for: the
+		 * tasks the target had are already in the map from
+		 * evlist__create_maps() and sched_process_exit() takes them out
+		 * again as they die. Carry on with what is known and let only
+		 * an allocation failure through, matching how the pid_list
+		 * additions below are treated.
+		 */
+		if (errno == ENOMEM)
+			return -ENOMEM;
+
+		pr_debug("Couldn't enumerate the target again (%s), tracing the tasks already known\n",
+			 errno == 0 ? "it exited" : str_error_r(errno, bf, sizeof(bf)));
+		return 0;
+	}
+
+	for (int i = 0; i < perf_thread_map__nr(threads); i++) {
+		pid_t pid = perf_thread_map__pid(threads, i);
+
+		err = pid_list__add(whole_group ? &tgids : pids, pid);
+		/* A thread named by -t is not expanded, but its children are. */
+		if (!err && !whole_group)
+			err = pid_list__add_children(&tgids, pid);
+		if (err)
+			goto out;
+	}
+
+	for (size_t i = 0; i < tgids.nr; i++) {
+		pid_t tgid = tgids.entries[i];
+		char path[PATH_MAX];
+		struct dirent *dent;
+		DIR *tasks;
+
+		scnprintf(path, sizeof(path), "%s/%d/task", procfs__mountpoint(), tgid);
+		tasks = opendir(path);
+		if (tasks == NULL)
+			continue;	/* Exited between being named and being read. */
+
+		while ((dent = readdir(tasks)) != NULL) {
+			char *end;
+			pid_t tid = strtol(dent->d_name, &end, 10);
+
+			/* Skip "." and "..". */
+			if (*end != '\0')
+				continue;
+
+			err = pid_list__add(pids, tid);
+			if (!err)
+				err = pid_list__add_children(&tgids, tid);
+			if (err)
+				break;
+		}
+
+		closedir(tasks);
+		if (err)
+			goto out;
+	}
+out:
+	perf_thread_map__put(threads);
+	pid_list__exit(&tgids);
+	return err;
+}
+
+/*
+ * Trace the tasks that appeared while perf trace was starting up.
+ *
+ * evlist__create_maps() enumerated the target from /proc, and
+ * sched_process_fork() only sees what is cloned once it is attached. A task
+ * created in between is in neither, and since cmd_trace() drops the sys_enter
+ * evsel in favour of __augmented_syscalls__ it would go unreported for the
+ * whole session.
+ *
+ * Read the target out of /proc again now that the programs are attached.
+ * Whatever came before the attach is in /proc to be found, and whatever comes
+ * after it is sched_process_fork()'s to add, so between them nothing is left
+ * out.
+ *
+ * Doing this after the attach rather than before it is what makes that true;
+ * before it would only move the window. The cost is that a task found here
+ * may have made syscalls between sys_enter going live and it being added
+ * below, and those are not reported. It is traced from that point on.
+ */
+static int trace__set_startup_pids(struct trace *trace)
+{
+	struct pid_list pids = {};
+	int err;
+
+	/*
+	 * Nothing to do without a target: 'perf trace -a' does not filter on
+	 * pid at all, and evlist__prepare_workload() keeps a workload blocked
+	 * on a pipe until evlist__start_workload(), well after the attach.
+	 */
+	if (!target__has_task(&trace->opts.target))
+		return 0;
+
+	err = trace__collect_target_pids(trace, &pids);
+	if (!err)
+		err = augmented_syscalls__set_target_pids(pids.nr, pids.entries);
+
+	pid_list__exit(&pids);
+	return err;
+}
+
 static int __trace__deliver_event(struct trace *trace, union perf_event *event)
 {
 	struct evlist *evlist = trace->evlist;
@@ -4992,6 +5215,16 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	if (err < 0)
 		goto out_error_attach;
 
+	/*
+	 * With the programs live, anything the target created while they were
+	 * being set up is now sched_process_fork()'s to keep track of, but it
+	 * was not there to see it appear. Enumerate the target once more to
+	 * pick those up.
+	 */
+	err = trace__set_startup_pids(trace);
+	if (err < 0)
+		goto out_error_filter_pids;
+
 	/*
 	 * If the "close" syscall is not traced, then we will not have the
 	 * opportunity to, in syscall_arg__scnprintf_close_fd() invalidate the
-- 
2.55.0.1082.g2b9226bbc0-goog

