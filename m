Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E91270058
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Feb 2025 00:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616643; cv=none; b=DhPMxQ3Nra9eRc5j82nfdSAcg+kGUCqfJ9k+on0NnzNr5XLajedL47hlscALcY+SkpTNqrJ7HIIqBmeAi4WFqk6YkY+XL488/JtMwUqLJUaY7pYjom6Q+pMbGCSZKWBSIGDI0cIGOSVUN/5f3sdg7gkc6PYRQ/LVvenFiiKOZIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616643; c=relaxed/simple;
	bh=ra0KxU6OZ2Kntw539Gq8DHkuYwWOUFGpZweLpDYUOnk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vp1LVKcXFjsoE0oSrswWCcH6EX/N186i/rAe8AKLIhQl2J+RsDu5wYP6MvFG7UlIq7FzzlTUdd9ENati9XeFiIjE3wfaLQ0Ew0zU+c3rMDlhJJYJqYLiA6ncJslmW611ZEeT1YQjuyrCoRcscj+4z7yJ5mFxBJBlVPTaYpCAFIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gj9ZwhK6; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gj9ZwhK6"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc518f0564so900357a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2025 16:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740616641; x=1741221441; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ySFre/DS9Ie6BpbqXRUL93PnxWJmHNbJVUPdTcYqivQ=;
        b=gj9ZwhK6cy7d5uq2CD1PKYQ1l5JIzsVXymr77b4AFmZiOvtMM5hydf+UOeqH99Kaed
         FlZ5o8ybEvs0Tan6r3iz9q0Ddaj3GK6n2KtJl/5dRG5PFBw2boKuij5BWIKkQNNHHdES
         jgbxFKydik14S3khEGKEsO3+o5/zTfgv72miT9oz+3nRelxLJN/JkTu5J70CHySei46B
         XJPYwgnscFy8B/jdQNcC8QsU328xEatQ1fOBeBIiA+fUZwGrzUn163p3tVCubPwYSTnI
         VG0KgoZJ/jpTLf0C90UGN98BBrl63axNy7B/KyV81UZTpnfOkdHQvn5IErSyYh6RXAk8
         XSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740616641; x=1741221441;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ySFre/DS9Ie6BpbqXRUL93PnxWJmHNbJVUPdTcYqivQ=;
        b=BdaqNC6BHkZh9PaqXoDvQwdRvOeLC218cGrHoPDO0ljiJ2HEvQM1+r1JzcTcFRCPef
         8Bv82lxUrd7FIn/ko1MpZPT06SArXGZ0NOr+oszDlINqzTuCm7ZS/Y9WxVbyVqydcMLK
         S4CU/mMN8JihSJ728GzuXbsT7fu8lxK0PjYN6TuvVYRSNBNMn3G52B31g4ru5fyp5q3v
         zOKRydkJz038VpNTuR7NgHUyVyJ2psLoEP5DTcFjzk1zShaR/9SLbDobEPxJfoYAIXeh
         a4zCw031nsu0RDMpmjS08aPWvXOEBd63UewROFZWRQ9yVgTOy5g56S1GTDAGXM3GgExQ
         ImZA==
X-Forwarded-Encrypted: i=1; AJvYcCUOH/SXVFPRkz/DmUt4b7DJpSUNEEWzc8PgjQPF8sqKW0+zQ0DDUXIELmgEArkxSU6taio7niHXi2jvbLMqfHlS@vger.kernel.org
X-Gm-Message-State: AOJu0YwSgs13iQJcP4QHOSfNvRZO7JAikcW1iH6PxCxrpokWpHwSONWl
	xCx1aeliC8PjQ6w8DhNV8iYjuw8XbJLq+IbJGRRjOOyPCL1aY2t6CGcfMdc2peMvSqNxchDgVzl
	Hqw==
X-Google-Smtp-Source: AGHT+IF/GB2SXwZz3UpivVRMccErkd62rEc6mCFXFCH/iGAfZUTC6MXPC2bQf8nMbVhWRK4P5ZBkHEd5nmg=
X-Received: from pfbft2.prod.google.com ([2002:a05:6a00:81c2:b0:730:8970:1f9c])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3254:b0:734:9157:7456
 with SMTP id d2e1a72fcca58-734915776d1mr4869228b3a.19.1740616641195; Wed, 26
 Feb 2025 16:37:21 -0800 (PST)
Date: Wed, 26 Feb 2025 16:28:56 -0800
In-Reply-To: <20250227003359.732948-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227003359.732948-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250227003359.732948-5-ctshao@google.com>
Subject: [PATCH v8 4/4] perf lock: Report owner stack in usermode
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, nick.forrington@arm.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch parses `owner_lock_stat` into a RB tree, enabling ordered
reporting of owner lock statistics with stack traces. It also updates
the documentation for the `-o` option in contention mode, decouples `-o`
from `-t`, and issues a warning to inform users about the new behavior
of `-ov`.

Example output:
  $ sudo ~/linux/tools/perf/perf lock con -abvo -Y mutex-spin -E3 perf bench sched pipe
  ...
   contended   total wait     max wait     avg wait         type   caller

         171      1.55 ms     20.26 us      9.06 us        mutex   pipe_read+0x57
                          0xffffffffac6318e7  pipe_read+0x57
                          0xffffffffac623862  vfs_read+0x332
                          0xffffffffac62434b  ksys_read+0xbb
                          0xfffffffface604b2  do_syscall_64+0x82
                          0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76
          36    193.71 us     15.27 us      5.38 us        mutex   pipe_write+0x50
                          0xffffffffac631ee0  pipe_write+0x50
                          0xffffffffac6241db  vfs_write+0x3bb
                          0xffffffffac6244ab  ksys_write+0xbb
                          0xfffffffface604b2  do_syscall_64+0x82
                          0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76
           4     51.22 us     16.47 us     12.80 us        mutex   do_epoll_wait+0x24d
                          0xffffffffac691f0d  do_epoll_wait+0x24d
                          0xffffffffac69249b  do_epoll_pwait.part.0+0xb
                          0xffffffffac693ba5  __x64_sys_epoll_pwait+0x95
                          0xfffffffface604b2  do_syscall_64+0x82
                          0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76

  === owner stack trace ===

           3     31.24 us     15.27 us     10.41 us        mutex   pipe_read+0x348
                          0xffffffffac631bd8  pipe_read+0x348
                          0xffffffffac623862  vfs_read+0x332
                          0xffffffffac62434b  ksys_read+0xbb
                          0xfffffffface604b2  do_syscall_64+0x82
                          0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76
  ...

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/Documentation/perf-lock.txt |  5 +-
 tools/perf/builtin-lock.c              | 22 +++++++-
 tools/perf/util/bpf_lock_contention.c  | 71 +++++++++++++++++++++++---
 tools/perf/util/lock-contention.h      |  7 +++
 4 files changed, 94 insertions(+), 11 deletions(-)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index d3793054f7d3..859dc11a7372 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -179,8 +179,9 @@ CONTENTION OPTIONS
 
 -o::
 --lock-owner::
-	Show lock contention stat by owners.  Implies --threads and
-	requires --use-bpf.
+	Show lock contention stat by owners. This option can be combined with -t,
+	which shows owner's per thread lock stats, or -v, which shows owner's
+	stacktrace. Requires --use-bpf.
 
 -Y::
 --type-filter=<value>::
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 9bebc186286f..05e7bc30488a 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1817,6 +1817,22 @@ static void print_contention_result(struct lock_contention *con)
 			break;
 	}
 
+	if (con->owner && con->save_callstack && verbose > 0) {
+		struct rb_root root = RB_ROOT;
+
+		if (symbol_conf.field_sep)
+			fprintf(lock_output, "# owner stack trace:\n");
+		else
+			fprintf(lock_output, "\n=== owner stack trace ===\n\n");
+		while ((st = pop_owner_stack_trace(con)))
+			insert_to(&root, st, compare);
+
+		while ((st = pop_from(&root))) {
+			print_lock_stat(con, st);
+			free(st);
+		}
+	}
+
 	if (print_nr_entries) {
 		/* update the total/bad stats */
 		while ((st = pop_from_result())) {
@@ -1962,8 +1978,10 @@ static int check_lock_contention_options(const struct option *options,
 		}
 	}
 
-	if (show_lock_owner)
-		show_thread_stats = true;
+	if (show_lock_owner && !show_thread_stats) {
+		pr_warning("Now -o try to show owner's callstack instead of pid and comm.\n");
+		pr_warning("Please use -t option too to keep the old behavior.\n");
+	}
 
 	return 0;
 }
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 76542b86e83f..5af8f6d1bc95 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -460,7 +460,6 @@ static const char *lock_contention_get_name(struct lock_contention *con,
 {
 	int idx = 0;
 	u64 addr;
-	const char *name = "";
 	static char name_buf[KSYM_NAME_LEN];
 	struct symbol *sym;
 	struct map *kmap;
@@ -475,13 +474,14 @@ static const char *lock_contention_get_name(struct lock_contention *con,
 		if (pid) {
 			struct thread *t = machine__findnew_thread(machine, /*pid=*/-1, pid);
 
-			if (t == NULL)
-				return name;
-			if (!bpf_map_lookup_elem(task_fd, &pid, &task) &&
-			    thread__set_comm(t, task.comm, /*timestamp=*/0))
-				name = task.comm;
+			if (t != NULL &&
+			    !bpf_map_lookup_elem(task_fd, &pid, &task) &&
+			    thread__set_comm(t, task.comm, /*timestamp=*/0)) {
+				snprintf(name_buf, sizeof(name_buf), "%s", task.comm);
+				return name_buf;
+			}
 		}
-		return name;
+		return "";
 	}
 
 	if (con->aggr_mode == LOCK_AGGR_ADDR) {
@@ -549,6 +549,63 @@ static const char *lock_contention_get_name(struct lock_contention *con,
 	return name_buf;
 }
 
+struct lock_stat *pop_owner_stack_trace(struct lock_contention *con)
+{
+	int stacks_fd, stat_fd;
+	u64 *stack_trace = NULL;
+	s32 stack_id;
+	struct contention_key ckey = {};
+	struct contention_data cdata = {};
+	size_t stack_size = con->max_stack * sizeof(*stack_trace);
+	struct lock_stat *st = NULL;
+
+	stacks_fd = bpf_map__fd(skel->maps.owner_stacks);
+	stat_fd = bpf_map__fd(skel->maps.owner_stat);
+	if (!stacks_fd || !stat_fd)
+		goto out_err;
+
+	stack_trace = zalloc(stack_size);
+	if (stack_trace == NULL)
+		goto out_err;
+
+	if (bpf_map_get_next_key(stacks_fd, NULL, stack_trace))
+		goto out_err;
+
+	bpf_map_lookup_elem(stacks_fd, stack_trace, &stack_id);
+	ckey.stack_id = stack_id;
+	bpf_map_lookup_elem(stat_fd, &ckey, &cdata);
+
+	st = zalloc(sizeof(struct lock_stat));
+	if (!st)
+		goto out_err;
+
+	st->name = strdup(stack_trace[0] ? lock_contention_get_name(con, NULL, stack_trace, 0) :
+					   "unknown");
+	if (!st->name)
+		goto out_err;
+
+	st->flags = cdata.flags;
+	st->nr_contended = cdata.count;
+	st->wait_time_total = cdata.total_time;
+	st->wait_time_max = cdata.max_time;
+	st->wait_time_min = cdata.min_time;
+	st->callstack = stack_trace;
+
+	if (cdata.count)
+		st->avg_wait_time = cdata.total_time / cdata.count;
+
+	bpf_map_delete_elem(stacks_fd, stack_trace);
+	bpf_map_delete_elem(stat_fd, &ckey);
+
+	return st;
+
+out_err:
+	free(stack_trace);
+	free(st);
+
+	return NULL;
+}
+
 int lock_contention_read(struct lock_contention *con)
 {
 	int fd, stack, err = 0;
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index a09f7fe877df..1da779d75b5f 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -168,6 +168,8 @@ int lock_contention_stop(void);
 int lock_contention_read(struct lock_contention *con);
 int lock_contention_finish(struct lock_contention *con);
 
+struct lock_stat *pop_owner_stack_trace(struct lock_contention *con);
+
 #else  /* !HAVE_BPF_SKEL */
 
 static inline int lock_contention_prepare(struct lock_contention *con __maybe_unused)
@@ -187,6 +189,11 @@ static inline int lock_contention_read(struct lock_contention *con __maybe_unuse
 	return 0;
 }
 
+struct lock_stat *pop_owner_stack_trace(struct lock_contention *con __maybe_unused)
+{
+	return NULL;
+}
+
 #endif  /* HAVE_BPF_SKEL */
 
 #endif  /* PERF_LOCK_CONTENTION_H */
-- 
2.48.1.658.g4767266eb4-goog

