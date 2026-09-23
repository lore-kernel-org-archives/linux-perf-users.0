Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983A346AA73
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147686; cv=none; b=dc1rck+/CondkfnoktiOYaJRvADOOLq9afK0Nj2E1PoXSWy4T7+1FXMGOloeJlq/yJwYD6jukSkDFAllm/itslUV37tuFO4RLlmFz+oM0a8jq334pu0Yk/Q2dZzmVPJ7Fbr/UOtYzm7AiFqKCXilw+0S1WN89rvll6grosEzvyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147686; c=relaxed/simple;
	bh=+xrSY7I9b4Gac4p3+5CfHpDGtn48eilsfL60mTFY8b0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V8pXuqyLHkyY6e7p96PEmlP5aKQKlvdKDG/gi0QFd0CmbXkYVFFvvkYYKt2tSxLJdB0kzKRusu+xRIuVHZ8hVd1foCwcNTpLsaiBtOpvpfwucPV4KDr3rzq0egKWVoA2yCHQPWSj1QwSAbM6VPylnqCbbkoshs3nOUAE0/hLGGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vPzt754l; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vPzt754l"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-32b8c2b30c4so897597eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 00:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790147682; x=1790752482; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VYyndSuCACAlZ1/aQblNPpqm/b+goCKk68wk6q62PbI=;
        b=vPzt754lBXCHT4qY+khnXN0pP3Vo9WCnKLfX2W2TmZg8xLix5m4ENAgglqux73A/XM
         oqOt/+vbvl4wfPlGLoLI9ze48lrDT7nJaLmm1JmGR8moQ2GYh2dckdxd9wncvJseZtcP
         iF1RskbhWNEPCllIdmB0zufkjC8dGI3oseojHiyg3amj3yTq8/+fVdYqcxgJ1z75QlUR
         WLezGcA4wSz5i3//tT7Fs0lk9HaqXqvndHvhC0naJfHwJa1CG+DC7MHHkP5vyepiThjl
         K6ziIlhviQHWeHih0cpdc0d0yZm/CwlmhXmpMeYpN34TpZxRADCKYdj//nnp1iFys1WX
         vfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790147682; x=1790752482;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VYyndSuCACAlZ1/aQblNPpqm/b+goCKk68wk6q62PbI=;
        b=lLqz9jc8XBURLvmHx6zkzKhEhyxwnAvxwIBxIL4wT02rkeIfJz0TYD+CTWvY4qHazM
         bEzGoqFpE/We3uDZ5sM7rZgd1nDyjqEFQWLfDl/MHpyums+eeZGavT6anbCfLULAHcPF
         ElmBV/VrJHgP8PI/yIAFGyaDa0Epa/tAYfvwmtkjzoeKWVV7c5fe41HJuEDUDb6UF9Rw
         pICu7J7nc0BxGEmM66d0u+2567O34Z+4q1sX6HF2vOdRvZ944zU/MtK5vO4+y9rp+s0c
         bl5J9zwEeN3G4u30sAEsZtPo/zkG9SqsJoI74pBIF5IfJdIwrusmq6cLK3avddTbPOmo
         BDpw==
X-Forwarded-Encrypted: i=1; AKwUvBxYdILE3VK+yG/nOJMnRSmKBegJXPBzax+PhrzfX3ZWDTb1CYsk9nqCq4rvRRVwqYbF2ROlHUMX3cmRHGir9Wys@vger.kernel.org
X-Gm-Message-State: AFuF++mnrDdivnoH63E2vWQcKydWgYyLl0YP6blZLXtYqT93QXDy9gXN
	gP3yo74ntRuXJwg4/hlcEnhHx1PjXQN5hs0ES43oiRf5l+DnxMYp5ZIeL9Fmqc8eUauuyZEhmQE
	9jjUvJgHGcw==
X-Received: from dybun8.prod.google.com ([2002:a05:7300:f3c8:b0:32d:1a84:9293])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6197:10b0:33c:13a1:84ea
 with SMTP id 5a478bee46e88-33e8e3ae194mr1731651eec.39.1790147682058; Wed, 23
 Sep 2026 00:14:42 -0700 (PDT)
Date: Wed, 23 Sep 2026 00:13:55 -0700
In-Reply-To: <cover.1790145937.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <b6d5596ad04aef749be8f57951d70f7e6bee4765.1790145937.git.irogers@google.com>
Subject: [PATCH v5 15/23] perf trace: Drop targets that died before they were filtered
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, howardchu95@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

sched_process_exit() takes a task out of pids_to_trace and pids_filtered
as it dies, which keeps the maps holding live tasks rather than growing
for the length of the session. It only finds a task there if userspace
put it there first, and userspace writes a pid some time after reading
it:

 - trace__set_filter_pids() writes the thread map and the --filter-pids
   list before the programs are attached, so for those there is nothing
   watching them die at all.
 - trace__set_startup_pids() writes what it enumerated after the attach,
   which is a much smaller gap but still a gap.

A task that dies inside one of those windows is never evicted, because
the delete that would have done it ran while the map had nothing to
delete. Its pid then sits in the map for the rest of the session: it
holds one of a fixed number of entries, and pids are reused, so the
unrelated task that eventually receives it is treated as the target, or
as a task the user asked to leave out and is then silently not reported.

Walk both maps once the last write to them is done and remove the tasks
that are not alive. Sweeping the maps rather than the lists that were
written to them covers every way a pid can get in, including the pid of
perf itself and of the terminal it was started from, which
trace__set_filter_loop_pids() adds without recording anywhere. A task
found alive here and dying later is one sched_process_exit() can see and
evict, so a single pass is enough, and the tasks the BPF programs add
for themselves need nothing: sched_process_fork() inserts a task before
it has run, so it cannot have died beforehand.

Deleting the key the walk is standing on leaves bpf_map__get_next_key()
to resume from a key that is no longer there, which
htab_map_get_next_key() answers with the first key of the whole map,
starting the walk over. The walk therefore only ever stands on a key it
has found alive, which is one it has just decided to keep, so nothing it
deletes is ever the key it would go on to ask from. A key deleted while
the walk stands on nothing is not a problem either: the next request is
for the first key of the map, and the deleted one is no longer it.

sched_process_exit() deletes keys while this runs and can take out the
key the walk is standing on, which there is no way to prevent or to
notice. The walk is bounded at max_entries steps so that it ends however
often that happens: the map holds no more than that many keys, so a walk
that has taken as many steps has either seen them all or been restarted,
and the bound is what stops a walk that keeps being restarted from going
round for ever. Ending on the bound can leave a dead task behind, which
costs one entry of a great many until the session ends, where not ending
would cost the session itself.

A task is taken to be gone when its /proc entry is not there, and also
when /proc reports it as Z or X. Both mean it is in or past do_exit(),
which is where sched_process_exit() runs, so waiting for a zombie to be
reaped before dropping it would only keep a dead task in the map for
longer.

Everything else, including not being able to tell, leaves the task in
the map. The two mistakes are not equal: a dead task left there holds an
entry nothing needs, while a live one taken out stops being traced for
the rest of the session, so a read that fails for perf's own reasons,
being out of file descriptors or of memory, is not read as the task
having exited.

Reading that state means finding the end of the command name, which
do_task_stat() writes out unescaped, unlike /proc/<pid>/status: it holds
whatever the task called itself, ')' and newlines included. The whole of
/proc/<pid>/stat is read rather than a line of it, because a line stops
at the first embedded newline, short of the name's closing ')', and the
last ')' in the file is taken as that one, since no field after the name
has parentheses in it.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c          | 76 ++++++++++++++++++++++++---
 tools/perf/util/bpf_trace_augment.c | 79 +++++++++++++++++++++++++++++
 tools/perf/util/trace_augment.h     |  6 +++
 3 files changed, 153 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 6b52f0d408dd..b318623486e2 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4897,6 +4897,59 @@ static int trace__collect_target_pids(struct trace *trace, struct pid_list *pids
 	return err;
 }
 
+/*
+ * Is the task still running?
+ *
+ * A pid with no /proc entry is gone, and one reported as Z (zombie) or X (dead)
+ * is in or past do_exit(), which is where sched_process_exit() runs. Either way
+ * the BPF programs will never hear about it again.
+ *
+ * Anything that is not one of those, including being unable to tell, is taken
+ * as alive. The two mistakes are not equal: a dead task left in the map holds
+ * an entry that nothing needs, while a live one taken out of it stops being
+ * traced for the rest of the session.
+ */
+static bool trace__task_is_alive(pid_t pid)
+{
+	char path[PATH_MAX];
+	const char *state;
+	char *stat = NULL;
+	bool alive = true;
+	size_t len;
+	int err;
+
+	scnprintf(path, sizeof(path), "%s/%d/stat", procfs__mountpoint(), pid);
+	err = filename__read_str(path, &stat, &len);
+	if (err) {
+		/*
+		 * ENOENT and ESRCH are the task being gone, which is what this
+		 * is looking for. Any other error is perf's own, running out
+		 * of file descriptors or of memory, and says nothing about the
+		 * task.
+		 */
+		return err != -ENOENT && err != -ESRCH;
+	}
+
+	/*
+	 * The state is the field after the command name. do_task_stat() writes
+	 * that name out as it is, so it can hold anything a task cares to call
+	 * itself, ')' and newlines included. Nothing after it has parentheses,
+	 * so the last ')' in the file is the one that closes it; the whole file
+	 * is read rather than a line of it because a line stops at the first of
+	 * those newlines, short of the ')' that is being looked for.
+	 *
+	 * A read that returns something the state cannot be read out of, such
+	 * as the empty result of the task exiting midway through it, leaves the
+	 * task alive by the rule above.
+	 */
+	state = strrchr(stat, ')');
+	if (state != NULL && state[1] == ' ')
+		alive = state[2] != 'Z' && state[2] != 'X';
+
+	free(stat);
+	return alive;
+}
+
 /*
  * Trace the tasks that appeared while perf trace was starting up.
  *
@@ -4919,19 +4972,26 @@ static int trace__collect_target_pids(struct trace *trace, struct pid_list *pids
 static int trace__set_startup_pids(struct trace *trace)
 {
 	struct pid_list pids = {};
-	int err;
+	int err = 0;
 
 	/*
-	 * Nothing to do without a target: 'perf trace -a' does not filter on
-	 * pid at all, and evlist__prepare_workload() keeps a workload blocked
-	 * on a pipe until evlist__start_workload(), well after the attach.
+	 * Only a target is enumerated: 'perf trace -a' does not filter on pid
+	 * at all, and evlist__prepare_workload() keeps a workload blocked on a
+	 * pipe until evlist__start_workload(), well after the attach.
 	 */
-	if (!target__has_task(&trace->opts.target))
-		return 0;
+	if (target__has_task(&trace->opts.target)) {
+		err = trace__collect_target_pids(trace, &pids);
+		if (!err)
+			err = augmented_syscalls__set_target_pids(pids.nr, pids.entries);
+	}
 
-	err = trace__collect_target_pids(trace, &pids);
+	/*
+	 * Every session gets the sweep, target or not: --filter-pids names
+	 * tasks to leave out with no target of its own, and those are written
+	 * to a map of their own, before the attach and with the same race.
+	 */
 	if (!err)
-		err = augmented_syscalls__set_target_pids(pids.nr, pids.entries);
+		err = augmented_syscalls__prune_dead_pids(trace__task_is_alive);
 
 	pid_list__exit(&pids);
 	return err;
diff --git a/tools/perf/util/bpf_trace_augment.c b/tools/perf/util/bpf_trace_augment.c
index 44f30dba5469..4f93f5c062c1 100644
--- a/tools/perf/util/bpf_trace_augment.c
+++ b/tools/perf/util/bpf_trace_augment.c
@@ -255,6 +255,85 @@ int augmented_syscalls__set_target_pids(unsigned int nr, pid_t *pids)
 	return 0;
 }
 
+/*
+ * Remove from a pid keyed map every task that is no longer alive.
+ *
+ * Deleting the key the walk is standing on leaves bpf_map__get_next_key() to
+ * resume from a key that is no longer there, which htab_map_get_next_key()
+ * answers with the first key of the whole map, starting the walk over. The
+ * cursor is therefore only ever moved onto a key that has been found alive,
+ * which is a key this function has just decided to keep, so nothing it does
+ * can send itself back to the beginning.
+ *
+ * sched_process_exit() deletes keys while this runs and can take out the
+ * cursor, which there is no way to prevent or to notice. The walk is bounded
+ * at max_entries steps so that it ends however often that happens: the map
+ * holds no more than that many keys, so a walk that has taken as many steps
+ * has either seen them all or been restarted, and the bound is what stops a
+ * repeatedly restarted walk from going round for ever. Stopping there can
+ * leave a dead task behind, which costs one entry of a great many until the
+ * session ends, where not stopping would cost the session itself.
+ */
+static int prune_dead_map_pids(struct bpf_map *map, bool (*is_alive)(pid_t pid))
+{
+	size_t max_entries = bpf_map__max_entries(map);
+	pid_t cursor, key;
+	bool have_cursor = false;
+
+	for (size_t step = 0; step < max_entries; step++) {
+		int err;
+
+		/* Anything other than success means there is no next key. */
+		if (bpf_map__get_next_key(map, have_cursor ? &cursor : NULL,
+					  &key, sizeof(key)) != 0)
+			break;
+
+		if (is_alive(key)) {
+			cursor = key;
+			have_cursor = true;
+			continue;
+		}
+
+		err = bpf_map__delete_elem(map, &key, sizeof(key), /*flags=*/0);
+		/*
+		 * ENOENT means the key went away while this was running, which
+		 * is sched_process_exit() doing the same job.
+		 */
+		if (err && err != -ENOENT)
+			return err;
+
+		/*
+		 * The cursor stays where it was, which is either a key that is
+		 * still in the map or unset. Unset asks the next step for the
+		 * first key of the map, and the one just deleted is no longer
+		 * it, so the walk moves on either way.
+		 */
+	}
+
+	return 0;
+}
+
+/*
+ * Remove the tasks that are no longer alive from both pid maps.
+ *
+ * has_pids_to_trace and has_pids_filtered are left alone. They say that the
+ * maps are in use rather than that they have anything in them, and clearing
+ * the first would turn a targeted session into a system wide one.
+ */
+int augmented_syscalls__prune_dead_pids(bool (*is_alive)(pid_t pid))
+{
+	int err;
+
+	if (skel == NULL)
+		return 0;
+
+	err = prune_dead_map_pids(skel->maps.pids_to_trace, is_alive);
+	if (!err)
+		err = prune_dead_map_pids(skel->maps.pids_filtered, is_alive);
+
+	return err;
+}
+
 /*
  * Populate syscalls in the BPF syscalls_to_trace map:
  * - not_syscalls: true if '!' prefix was specified (blacklist mode: trace
diff --git a/tools/perf/util/trace_augment.h b/tools/perf/util/trace_augment.h
index ad992f5fa726..87dbf8c46c1e 100644
--- a/tools/perf/util/trace_augment.h
+++ b/tools/perf/util/trace_augment.h
@@ -16,6 +16,7 @@ int augmented_syscalls__create_bpf_output(struct evlist *evlist);
 void augmented_syscalls__setup_bpf_output(void);
 int augmented_syscalls__set_filter_pids(unsigned int nr, pid_t *pids);
 int augmented_syscalls__set_target_pids(unsigned int nr, pid_t *pids);
+int augmented_syscalls__prune_dead_pids(bool (*is_alive)(pid_t pid));
 int augmented_syscalls__set_target_syscalls(unsigned int nr, int *syscall_ids, bool not_syscalls);
 int augmented_syscalls__get_map_fds(int *enter_fd, int *exit_fd, int *beauty_fd);
 struct bpf_program *augmented_syscalls__find_by_title(const char *name);
@@ -55,6 +56,11 @@ static inline int augmented_syscalls__set_target_pids(unsigned int nr __maybe_un
 	return 0;
 }
 
+static inline int augmented_syscalls__prune_dead_pids(bool (*is_alive)(pid_t pid) __maybe_unused)
+{
+	return 0;
+}
+
 static inline int augmented_syscalls__set_target_syscalls(unsigned int nr __maybe_unused,
 							  int *syscall_ids __maybe_unused,
 							  bool not_syscalls __maybe_unused)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

