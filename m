Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C3B3A1CD
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 05:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736486135; cv=none; b=JyvZaobCR+O19pZnaoIpg9Ijj5jtukmNTFj6egUW+N26N0P0CydQIxpHbO/1yNfWsN7Li0Jp0mlFKMwzfXjfD8WzGJwNSr5son3W3Uo1NJpe+yfOd1657H1SkI5FZSOiw+Yf53KNFZ8qq5c5AQM1NGYGE6u7fJ+BQSUpRpvYeiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736486135; c=relaxed/simple;
	bh=mxq8JbhUM61C/BdaOz17P9fYKKdIVBAz9OSawkUDkEU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RkohQC9AbGdjniHCv3vXvI+t6bw7/vxYS2cYEv9Vsvd+pKfzIMSWDxiS/dq7miWDq4XfQmyVRE5hgberwpJaYJSXQ+fAkEPwl4n3wlbF+iuaPPkV8tM4qJWOeioNiUWzDPulYjOtW7E+WP4js1zin2PbYZg7alHM3XHtPf0risY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NIXjhgMI; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NIXjhgMI"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef79403c5eso4890308a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jan 2025 21:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736486133; x=1737090933; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hE9EISDVTzVU1K+rlaaimzQWIvKlJ6sLk8tbkArb4CQ=;
        b=NIXjhgMIQ+OfNedIsSkypmaXak9pxlU7kuMjbLfHPMcO/RFXEp7bdb6SVZca9sUDbG
         OL2w0Ppkf9AkG+8YllMdQ6rxXmkpXSFtunBUyx6zl89qS4ty9KGNwgVTK6/1mTup2nIe
         ZvTsrSaPp/4nii4DIEbrSspN/p6WJERaLDQ9jJqffr/1EMfri2WIkG3a4gWChlPwTJ1U
         H3umhcoNVE+Fn8N5JBITADQPpXrHIHYabNPYcG8+DM6OztvUbqFgcJbJCQkZ7qgYrcw+
         PrEoHFOSwUTdS6gh7BlL1tfPe0Z3bnVQFrwK/K6SJDNfPtK+Dej1oFnyunOEOAVI0Bjv
         CZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736486133; x=1737090933;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hE9EISDVTzVU1K+rlaaimzQWIvKlJ6sLk8tbkArb4CQ=;
        b=t7G/Y3eMtNlxKAY+izBLEelEDrTrLHXj9SvCQIrItUWv1yIbJhPXHVlykKZCACxu2q
         nGVhkF69STpvH0sRgfb98qOrfWIuQwFrBd2S8yxDfvxUhkr4TsitsRYLflT3NilESFyp
         BBDkSNHhrrXGpCPlvLdYB+CmBuz0fX0O7UmrTVXZWutLSYfwzfIGJocvTsn9r+1CHURp
         fNyJ1yYjvfT060fOrHvHw6qYPvNYB5ZA7Y8ZOxXHBNpDjV0ilEEGfc1zFRExny8nORDN
         8cVJU7wvh9nA2jEZ1Pc68xhG+tRaWkcJQOw5YlHjTHhUVPAQjWnPbXlWXAdteLK9+Iho
         QfrA==
X-Forwarded-Encrypted: i=1; AJvYcCWs53CDEHlB3Dx7MDumLCPxwOH4dewXU5k6TQ5WcwI9hKB40YxBcaK13zHtDe1wrv/rgvCbj5jjzXDOELDGzB6y@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc/fAkzuJNllpZWPNB+oRlyfnvMnnPh/lq0CSpvwZ/as7yhntn
	9w5TtkGqxF8liTW2eUGucHzalLL3x3hS2yio35Y8bcfEBaZlssSrgvhHpbMEgQa3C5oCuf2whxR
	Pjg==
X-Google-Smtp-Source: AGHT+IHRqczsVQdVyjV3usT7mkM0Jd+4O54qlIoQebIseIGLadj0zMA2MHTCg5fOlfMt/wa+q4xdG6X0HYI=
X-Received: from pjbpq5.prod.google.com ([2002:a17:90b:3d85:b0:2ef:8ef8:2701])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a50:b0:2ea:bf1c:1e3a
 with SMTP id 98e67ed59e1d1-2f548f2a154mr16873338a91.12.1736486132920; Thu, 09
 Jan 2025 21:15:32 -0800 (PST)
Date: Thu,  9 Jan 2025 21:11:44 -0800
In-Reply-To: <20250110051346.1507178-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250110051346.1507178-1-ctshao@google.com>
X-Mailer: git-send-email 2.47.1.688.g23fc6f90ad-goog
Message-ID: <20250110051346.1507178-5-ctshao@google.com>
Subject: [PATCH v1 4/4] perf lock: Report owner stack in usermode
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Parse `owner_lock_stat` into a rb tree, and report owner lock stats with
stack trace in order.

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
 tools/perf/builtin-lock.c             | 21 +++++++++++++-
 tools/perf/util/bpf_lock_contention.c | 41 +++++++++++++++++++++++++++
 tools/perf/util/lock-contention.h     |  2 ++
 3 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index f9b7620444c0..b20687325d49 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -42,6 +42,7 @@
 #include <linux/zalloc.h>
 #include <linux/err.h>
 #include <linux/stringify.h>
+#include <linux/rbtree.h>
 
 static struct perf_session *session;
 static struct target target;
@@ -1926,6 +1927,24 @@ static void print_contention_result(struct lock_contention *con)
 			break;
 	}
 
+	if (con->owner && con->save_callstack) {
+		struct rb_root root = RB_ROOT;
+
+
+		if (symbol_conf.field_sep)
+			fprintf(lock_output, "# owner stack trace:\n");
+		else
+			fprintf(lock_output, "\n=== owner stack trace ===\n\n");
+		while ((st = pop_owner_stack_trace(con))) {
+			insert_to(&root, st, compare);
+		}
+
+		while ((st = pop_from(&root))) {
+			print_lock_stat(con, st);
+			zfree(st);
+		}
+	}
+
 	if (print_nr_entries) {
 		/* update the total/bad stats */
 		while ((st = pop_from_result())) {
@@ -2071,7 +2090,7 @@ static int check_lock_contention_options(const struct option *options,
 		}
 	}
 
-	if (show_lock_owner)
+	if (show_lock_owner && !verbose)
 		show_thread_stats = true;
 
 	return 0;
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index c9c58f243ceb..a63d5ffac386 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -414,6 +414,47 @@ static const char *lock_contention_get_name(struct lock_contention *con,
 	return name_buf;
 }
 
+struct lock_stat *pop_owner_stack_trace(struct lock_contention *con)
+{
+	int fd;
+	u64 *stack_trace;
+	struct contention_data data = {};
+	size_t stack_size = con->max_stack * sizeof(*stack_trace);
+	struct lock_stat *st;
+	char name[KSYM_NAME_LEN];
+
+	fd = bpf_map__fd(skel->maps.owner_lock_stat);
+
+	stack_trace = zalloc(stack_size);
+	if (stack_trace == NULL)
+		return NULL;
+
+	if (bpf_map_get_next_key(fd, NULL, stack_trace))
+		return NULL;
+
+	bpf_map_lookup_elem(fd, stack_trace, &data);
+	st = zalloc(sizeof(struct lock_stat));
+
+	strcpy(name, stack_trace[0] ? lock_contention_get_name(con, NULL,
+							       stack_trace, 0) :
+				      "unknown");
+
+	st->name = strdup(name);
+	st->flags = data.flags;
+	st->nr_contended = data.count;
+	st->wait_time_total = data.total_time;
+	st->wait_time_max = data.max_time;
+	st->wait_time_min = data.min_time;
+	st->callstack = memdup(stack_trace, stack_size);
+
+	if (data.count)
+		st->avg_wait_time = data.total_time / data.count;
+
+	bpf_map_delete_elem(fd, stack_trace);
+	free(stack_trace);
+
+	return st;
+}
 int lock_contention_read(struct lock_contention *con)
 {
 	int fd, stack, err = 0;
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index 1a7248ff3889..83b400a36137 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -156,6 +156,8 @@ int lock_contention_stop(void);
 int lock_contention_read(struct lock_contention *con);
 int lock_contention_finish(struct lock_contention *con);
 
+struct lock_stat *pop_owner_stack_trace(struct lock_contention *con);
+
 #else  /* !HAVE_BPF_SKEL */
 
 static inline int lock_contention_prepare(struct lock_contention *con __maybe_unused)
-- 
2.47.1.688.g23fc6f90ad-goog

