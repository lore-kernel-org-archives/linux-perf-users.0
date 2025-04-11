Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1079E27CB1A
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Apr 2025 05:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744349203; cv=none; b=jeLR4WETHU3wIVGl8CGvPEMJsBsOq8uhWZ2rxf6TJQwpftx+wk53RYwQ80Dymzljv5RpJEjd323JOUDViIcV1h1PF04FWRTG1cnmT1pIGLw0HDazkbnDDAk5GHKrBzvXYQgDFgmZaEVHXiElDQmf9KVdur0DTjzI0la/1AhPUq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744349203; c=relaxed/simple;
	bh=A+el4cpdw/DhRuCXHAdR6mgrmqbbrV0NpjVlr1loDPc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FX2tshdlbVdA24Y+p11AM6qcAANbht6vAnWP+AS8ivqhpPL2EIgQRPEgSeJtHDj4doMjQ5Kez2pyhXVt7RRk3E6qQnoHV5zth8Q4U7GvFkzG0hF8jpfebNrjUOq2v5mb4bnvUkL7tagMqLfs+scsI3lkqzZhDYeutOQJQk7CjZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O+ordTYK; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O+ordTYK"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-227ed471999so14378305ad.3
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Apr 2025 22:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744349200; x=1744954000; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GFJBxRHU0RjyStMVHhHodlZr7xNoOo3rThfX4oypk9I=;
        b=O+ordTYKlhF7PiDYiEbU6p+dTQ6Khx7pFhH9qZWxzPIMyeia6TH4nqNF8zbRhV2gaZ
         mZEZSzxDGHtNvWK7DqPp4awfHEtQazdylR21QCd6LZx2oP/pcpqLhN8dNvwKm2yNvfqX
         QWiUjHRZOlHHxt8d/kNLBLg9TakSCnR16UecvPlR7lU0dCCQDlCTToRFU9KejCzaqewq
         fiw8MzDsTWWmFA5c1tc4++DplrsQEbQuMgqjKUyoNQPk9Jz8+cCyOkSttbdNy3ifAYy3
         8qVkAoC3sVBURkjxc/hdIJwB6tRHyZ9sf7/RExOSZMjJw8KRabyUZZCErSVf8n2rOMte
         oDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744349200; x=1744954000;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GFJBxRHU0RjyStMVHhHodlZr7xNoOo3rThfX4oypk9I=;
        b=FAiMLIj+qydnEuh08OlzisdQVZGxKaQvHSyZHdUa2Ws08be8AjlHF4MXHYWWqoKFoN
         z61rM3NBMMtKbfW7G/TgiNqvo/cU2rpuf1YtXDvZL5YBOk5u3btmQcRTrOyBUkNqX6tu
         cBgksdBgf7No1Lk97hVgW90m8cPzivxhqCu205uS5nu3fgYDKWuax4wPkKw/E/KMeIbP
         zcmeQToyAJqeQPJwlvIiN85iVrIOwG5M0ewsyVivsti+dsi0rC7NlbP3W5l+jk1Ip7Op
         aZMFf9TB6R7sum80d5tPqvSvDr0veZgY3ChzH7g7veq8zdQZR2ZuSfZ8upUryNugo0+p
         WoPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrZUlmZnNdtzIASy84e9/hKe8ttIpSB0H7AHHiyQDY+bwwcNxlE8PGgm/kmidlrfnKEvbfvoDvkU6lMvkxb5Or@vger.kernel.org
X-Gm-Message-State: AOJu0YwII3fSsw/lj27vHizkAzUjDQwcRuD2WwGfwniIMffJ8vnmyjKz
	g1OC8ZWhafJ5tD9Ffpaz/oDfjHL5FHyUnKXobiqmLH2Nij1mOs5V0R/1Y88V97zM3cDkIIaz+9K
	5ng==
X-Google-Smtp-Source: AGHT+IH9Q5mYNu3CzERsko0z+dCQEZ1FE++BBu5zXD3RNKjtAxnHlvIt9cA6peJ0Qhv/dqlZ2hXZbRZYJpo=
X-Received: from plblv12.prod.google.com ([2002:a17:903:2a8c:b0:223:58e2:570d])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db0e:b0:223:66bb:8995
 with SMTP id d9443c01a7336-22bea4ab827mr17319935ad.20.1744349200338; Thu, 10
 Apr 2025 22:26:40 -0700 (PDT)
Date: Thu, 10 Apr 2025 22:24:19 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250411052548.2089332-1-ctshao@google.com>
Subject: [PATCH v1] perf lock: Add --duration-filter option
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, Namhyung Kim <namhyung@kernel.org>, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, nick.forrington@arm.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch introduces the `--duration-filter` option, allows users to
exclude lock contention samples with durations shorter than the
specified filter value.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-lock.txt        |  3 +++
 tools/perf/builtin-lock.c                     |  3 +++
 tools/perf/util/bpf_lock_contention.c         | 22 ++++++++++++++-----
 .../perf/util/bpf_skel/lock_contention.bpf.c  |  7 ++++++
 tools/perf/util/lock-contention.h             |  1 +
 5 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index 859dc11a7372..1f57f5fc59e0 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -216,6 +216,9 @@ CONTENTION OPTIONS
 --cgroup-filter=<value>::
 	Show lock contention only in the given cgroups (comma separated list).
 
+--duration-filter=<value>::
+  Filter out lock contention samples which durations less than the specified
+  value (default: 0). The unit is nanoseconds (ns).
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 05e7bc30488a..d7b454e712bf 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -60,6 +60,7 @@ static int stack_skip = CONTENTION_STACK_SKIP;
 static int print_nr_entries = INT_MAX / 2;
 static const char *output_name = NULL;
 static FILE *lock_output;
+static int duration_filter;
 
 static struct lock_filter filters;
 
@@ -2004,6 +2005,7 @@ static int __cmd_contention(int argc, const char **argv)
 		.save_callstack = needs_callstack(),
 		.owner = show_lock_owner,
 		.cgroups = RB_ROOT,
+		.duration_filter = duration_filter,
 	};
 
 	lockhash_table = calloc(LOCKHASH_SIZE, sizeof(*lockhash_table));
@@ -2580,6 +2582,7 @@ int cmd_lock(int argc, const char **argv)
 	OPT_BOOLEAN(0, "lock-cgroup", &show_lock_cgroups, "show lock stats by cgroup"),
 	OPT_CALLBACK('G', "cgroup-filter", NULL, "CGROUPS",
 		     "Filter specific cgroups", parse_cgroup_filter),
+	OPT_INTEGER(0, "duration-filter", &duration_filter, "Filter samples by duration"),
 	OPT_PARENT(lock_options)
 	};
 
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 5af8f6d1bc95..7b982a3e4000 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -203,6 +203,7 @@ int lock_contention_prepare(struct lock_contention *con)
 	skel->rodata->aggr_mode = con->aggr_mode;
 	skel->rodata->needs_callstack = con->save_callstack;
 	skel->rodata->lock_owner = con->owner;
+	skel->rodata->duration_filter = con->duration_filter;
 
 	if (con->aggr_mode == LOCK_AGGR_CGROUP || con->filters->nr_cgrps) {
 		if (cgroup_is_v2("perf_event"))
@@ -568,12 +569,23 @@ struct lock_stat *pop_owner_stack_trace(struct lock_contention *con)
 	if (stack_trace == NULL)
 		goto out_err;
 
-	if (bpf_map_get_next_key(stacks_fd, NULL, stack_trace))
-		goto out_err;
+	/*
+	 * `owner_stacks` contains stacks recorded in `contention_begin()` that either never reached
+	 * `contention_end()` or were filtered out and not stored in `owner_stat`. We skip if we
+	 * cannot find corresponding `contention_data` in `owner_stat` with the given `stack_id`.
+	 */
+	while (true) {
+		if (bpf_map_get_next_key(stacks_fd, NULL, stack_trace))
+			goto out_err;
+
+		bpf_map_lookup_elem(stacks_fd, stack_trace, &stack_id);
+		ckey.stack_id = stack_id;
+		if (bpf_map_lookup_elem(stat_fd, &ckey, &cdata) == 0)
+			break;
 
-	bpf_map_lookup_elem(stacks_fd, stack_trace, &stack_id);
-	ckey.stack_id = stack_id;
-	bpf_map_lookup_elem(stat_fd, &ckey, &cdata);
+		/* Can not find `contention_data`, delete and skip. */
+		bpf_map_delete_elem(stacks_fd, stack_trace);
+	}
 
 	st = zalloc(sizeof(struct lock_stat));
 	if (!st)
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 69be7a4234e0..26ddc0f21378 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -176,6 +176,7 @@ const volatile int stack_skip;
 const volatile int lock_owner;
 const volatile int use_cgroup_v2;
 const volatile int max_stack;
+const volatile int duration_filter;
 
 /* determine the key of lock stat */
 const volatile int aggr_mode;
@@ -457,6 +458,9 @@ static inline void update_contention_data(struct contention_data *data, u64 dura
 
 static inline void update_owner_stat(u32 id, u64 duration, u32 flags)
 {
+	if (duration < duration_filter)
+		return;
+
 	struct contention_key key = {
 		.stack_id = id,
 		.pid = 0,
@@ -707,6 +711,9 @@ int contention_end(u64 *ctx)
 		}
 	}
 skip_owner:
+	if (duration < duration_filter)
+		goto out;
+
 	switch (aggr_mode) {
 	case LOCK_AGGR_CALLER:
 		key.stack_id = pelem->stack_id;
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index b5d916aa49df..97042e6d8b10 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -149,6 +149,7 @@ struct lock_contention {
 	int owner;
 	int nr_filtered;
 	bool save_callstack;
+	int duration_filter;
 };
 
 struct option;
-- 
2.49.0.604.gff1f9ca942-goog

