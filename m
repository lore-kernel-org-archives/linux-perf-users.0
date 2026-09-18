Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3E252CCF4
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 21:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766416; cv=none; b=tBYdvqUIlEmXhFPipDLHY4nK7NeSk9saQNFtnwiC2LoANEUMiSq0ZTSmKpay+rTRCwRdTnlsBJUTDXwM7qdYropTTBEOG5/NrAeV+oJ5zAQl+QMmt2lEzZSLDqdHOjhpI1g/g5pHdUt+uBm5wS1wIq3C1i60/B0E7BSwahspuvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766416; c=relaxed/simple;
	bh=Zhvfi51yykr7PWTmA1NhO3U3DU27Kk6yVoyW1tyqw7M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dZ7vzGYkxEy/mqvQMMGo6ukxew+oIY1JGL6KcG+AsyV2lcHh+f7SgSd+/gPlH3an9nICAci/ZbFeXlonios0tNRprCJQKvcvfgkP+WrbgImr2u7M76DqOtBqkGziIWszsTVxUzuEuLNdYh7iNoulg0QAdLqT5PIeauOvWr8q9k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C0p0ygt1; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C0p0ygt1"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39e25a5f6e8so2208619a91.0
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789766413; x=1790371213; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6hvZXo3pCgiX/XPpeXdh9Ez/iC9+6VQipJ3Ls30PyTI=;
        b=C0p0ygt1fAKWEHYQNw1ylS9dzqWL+b7+JP63DC9Q7lZ1n2VzCinMb60YqyivGuZZ5s
         IxEVimGRpFUnzT4jC3+1Qv9C2VTpnVf4PwfwHhVjxOJSfAKifCj5yj4/tatF1zBz+lnE
         gwoUe9miG0D0JnA/RTcRYHpsyw2d6K3882QOpPFAJtC+aialmotR3Y3GBCYPgtO5MIX7
         HZLdqFWiMZHNpET9N/m/Ch/Iyqk7FN5eRTytg+oMxXSmuLl1iz6rmXKf/ABAHGjbkurl
         fPaTnWJQ+QZ86IZznUEVdYh+5NvUAhjTn1VurUrFoCtjWCv1+U6CKBizlH9sXBiEKdrp
         Seig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789766413; x=1790371213;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6hvZXo3pCgiX/XPpeXdh9Ez/iC9+6VQipJ3Ls30PyTI=;
        b=lS6yFqFQeOOLwfhWOiCYYPr12kA5+Oy1aQIiEEjwLrYua8UF2DnYEEuiclJ2aeOW5F
         fZU1qRFWvVzS7M/DYURQaaktLNU4X94wfPcETIRg6+geXgZPi/lk/WhuPfkACRdHQ3Rg
         a0EnoTlTlDc+RXUooCD9XuQ4H6VguS59dgydry1yxaPw5b0H4r1+a5YOrg1hlW3kWMB6
         u6shdB0vKQpFoQhz1j3kevUI4OWwlEt8VI7IxA3RDLSlBuG7gkZdEkAgOxJSWYGep5nI
         w1MooWWBFfV1i4RtLmuH4kAw1cg6LtB6OtmIed2nQflvTTwuhFRgBAWkkjcixtj8kRW3
         Poxg==
X-Forwarded-Encrypted: i=1; AKwUvByrudDNYCmIxc8gwOJw7XDH4NWYsLeQxdCTPpHFDfwgApbpa05FJgN8/vLi429t/DY2841lUdBnwkZoxfhRUggL@vger.kernel.org
X-Gm-Message-State: AFuF++n0MNHJeHtWWeyuS3rwb5FhoDh2FH4hPTj/9NrhoK0uELQQKemp
	0ful03gGS59tA9vsNsubMkHoIJmfGIAmbLbTu5+cT3ndaNltkEEOIuvALGqAXY/LcwPevNIDOD+
	kuzsE1FXmcg==
X-Received: from dloo7-n1.prod.google.com ([2002:a05:7023:a47:10b0:144:bf4d:c486])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2ecb:b0:39e:4c7f:8b1c
 with SMTP id 98e67ed59e1d1-39e54d4cb89mr7971941a91.33.1789766413010; Fri, 18
 Sep 2026 14:20:13 -0700 (PDT)
Date: Fri, 18 Sep 2026 14:19:24 -0700
In-Reply-To: <20260918211932.2966061-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918140659.2501976-1-irogers@google.com> <20260918211932.2966061-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918211932.2966061-11-irogers@google.com>
Subject: [PATCH v4 10/18] perf trace: Drop targets that died before they were filtered
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	Howard Chu <howardchu95@gmail.com>
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
index 8a5dbf144540..f2425a291eeb 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4846,6 +4846,59 @@ static int trace__collect_target_pids(struct trace *trace, struct pid_list *pids
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
@@ -4868,19 +4921,26 @@ static int trace__collect_target_pids(struct trace *trace, struct pid_list *pids
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
2.55.0.1082.g2b9226bbc0-goog

