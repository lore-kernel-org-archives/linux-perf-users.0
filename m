Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B541C5F35
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2025 21:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740001496; cv=none; b=iJSCSRd6lkIzPXM+CemrG9jGrj8LgxX/6ks437bfEMFF++e8eg8YguxB59f3P1+RvqFvkUGcDMuVhg0LfMEdMa0zzr6rgI5jQyFvKsmoa+XZkikWz3Xm0plOkM27p+Ca1xHczbLns2/GtuEyk2M/6HKF3vrtTnNGz531TOVaa8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740001496; c=relaxed/simple;
	bh=Jqgp2wmgjO178XP3RtYaAKQqy0yvqQ6UWL9YxILPX3w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=saHapGrVxR2CJn1BMdLQR5cXHv6l/Pq95327qDbPsTub2A1S1mPYgT44oGkVZ3AeUGift57JSpkbyCjT5pB0BXMPVL7v3jSdBLM/SUYelpFMwCY7G1gSC1DdX22c0JoZDPeK/FcZQYpLhTC44keeaZSgOFyENI4Cwi+kSeh7BDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qThRStWT; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qThRStWT"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220e1593b85so3944795ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2025 13:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740001494; x=1740606294; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9URqe4q5EaVTic8nJEv32s2nRRv6fRzN8VW0O0BkxXw=;
        b=qThRStWTwwG9bGhCLWI6Na1C5Md/fzZFMRped5r0u1qTS/40BUm4y0KFQa3q9G82xS
         Trhk5vfwglMiqLv8nDz3Evgyx3Z6kSSj/HodWcGrRMDwuzxoFIQyuX4lfX+ODLKjj0v0
         r1qAJqSwnrxEYsn/Yq1/vE43WSkn2fCKbal1CZwEL6NIv+HC88o4sLjywrJ735OXe/WQ
         7v7/hYseCmk9jyENJcBbo8BmapAq88ZRR9td07VKH8lrcGDfzIglGi0FcZINEvNC7bas
         3yJqPxKrf15ScVPCQPWErf3gjuTDidQBIgHKkneXaULiTi5LVcdTSkUFsIJtlMJTsIOc
         yCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740001494; x=1740606294;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9URqe4q5EaVTic8nJEv32s2nRRv6fRzN8VW0O0BkxXw=;
        b=HM8+lVYM+Q9w7EfLQPso/LLujb4sNs98rwMCs44BJyQQxxIg2jGs6UgxZzjBSI3FR9
         zs6JckqqbPAFRdYPY6NyVU11nqHspAyx+jihgUJcaMeJ8Hnvx8BkdSHiMeynDogg8tn2
         5d3ezG/BELBygO3ljxoMLbQWaZxoCFVP5QikxVnmtqqKHBFipLgNQz+GgGSFi6kxxyY+
         knVImNXu92WvGcPls6dZHFE67+d+X6ZDIbS14OhzPEsACrK3Z/O+sTwm6f7SZB6vzjtS
         y2aUI9Mxil8PpcrwaMSweN1pLj7/mqROwhPUnKUnI+dF6HzZVT4JTAFeGsXrcaZJwE8r
         8xyA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ0g8CqZmFKAR5cyX7jcrF0utb+EdS2+c55bVck6pi2KSVID5Trbpo+w6E213KWA2q4GZFd1TIvEzdM/3xtQ0C@vger.kernel.org
X-Gm-Message-State: AOJu0YxtqnccPXqpgW5fOQZ5ILt9JDlELI/Axr89+FmDjcNhAJ3GR0HQ
	FhjOQ0ETImdyvdyYAuj1fIJevq44+6OshKi7F4ey3Fxwd4AEjWyfMReNba+bnw9iGUhiu96JPhf
	IRw==
X-Google-Smtp-Source: AGHT+IFCachULn5aG8Vg3yNDuNDsFvwav2GkkYQOOWjjAGy+PyXDys5e6Kf1Gx37Li5ywJnHT6LRVdxaBWQ=
X-Received: from pfbct6.prod.google.com ([2002:a05:6a00:f86:b0:730:9499:1f46])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:32a3:b0:1ee:c75c:beda
 with SMTP id adf61e73a8af0-1eec75cc2c3mr15999778637.35.1740001494228; Wed, 19
 Feb 2025 13:44:54 -0800 (PST)
Date: Wed, 19 Feb 2025 13:40:00 -0800
In-Reply-To: <20250219214400.3317548-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250219214400.3317548-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250219214400.3317548-2-ctshao@google.com>
Subject: [PATCH v6 1/4] perf lock: Add bpf maps for owner stack tracing
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, nick.forrington@arm.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a struct and few bpf maps in order to tracing owner stack.
`struct owner_tracing_data`: Contains owner's pid, stack id, timestamp for
  when the owner acquires lock, and the count of lock waiters.
`stack_buf`: Percpu buffer for retrieving owner stacktrace.
`owner_stacks`: For tracing owner stacktrace to customized owner stack id.
`owner_data`: For tracing lock_address to `struct owner_tracing_data` in
  bpf program.
`owner_stat`: For reporting owner stacktrace in usermode.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/util/bpf_lock_contention.c         | 14 ++++++--
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 33 +++++++++++++++++++
 tools/perf/util/bpf_skel/lock_data.h          |  7 ++++
 3 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index fc8666222399..76542b86e83f 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -131,10 +131,20 @@ int lock_contention_prepare(struct lock_contention *con)
 	else
 		bpf_map__set_max_entries(skel->maps.task_data, 1);
 
-	if (con->save_callstack)
+	if (con->save_callstack) {
 		bpf_map__set_max_entries(skel->maps.stacks, con->map_nr_entries);
-	else
+		if (con->owner) {
+			bpf_map__set_value_size(skel->maps.stack_buf, con->max_stack * sizeof(u64));
+			bpf_map__set_key_size(skel->maps.owner_stacks,
+						con->max_stack * sizeof(u64));
+			bpf_map__set_max_entries(skel->maps.owner_stacks, con->map_nr_entries);
+			bpf_map__set_max_entries(skel->maps.owner_data, con->map_nr_entries);
+			bpf_map__set_max_entries(skel->maps.owner_stat, con->map_nr_entries);
+			skel->rodata->max_stack = con->max_stack;
+		}
+	} else {
 		bpf_map__set_max_entries(skel->maps.stacks, 1);
+	}
 
 	if (target__has_cpu(target)) {
 		skel->rodata->has_cpu = 1;
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 6533ea9b044c..23fe9cc980ae 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -27,6 +27,38 @@ struct {
 	__uint(max_entries, MAX_ENTRIES);
 } stacks SEC(".maps");
 
+/* buffer for owner stacktrace */
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u64));
+	__uint(max_entries, 1);
+} stack_buf SEC(".maps");
+
+/* a map for tracing owner stacktrace to owner stack id */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u64)); // owner stacktrace
+	__uint(value_size, sizeof(__s32)); // owner stack id
+	__uint(max_entries, 1);
+} owner_stacks SEC(".maps");
+
+/* a map for tracing lock address to owner data */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u64)); // lock address
+	__uint(value_size, sizeof(struct owner_tracing_data));
+	__uint(max_entries, 1);
+} owner_data SEC(".maps");
+
+/* a map for contention_key (stores owner stack id) to contention data */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(struct contention_key));
+	__uint(value_size, sizeof(struct contention_data));
+	__uint(max_entries, 1);
+} owner_stat SEC(".maps");
+
 /* maintain timestamp at the beginning of contention */
 struct {
 	__uint(type, BPF_MAP_TYPE_HASH);
@@ -143,6 +175,7 @@ const volatile int needs_callstack;
 const volatile int stack_skip;
 const volatile int lock_owner;
 const volatile int use_cgroup_v2;
+const volatile int max_stack;
 
 /* determine the key of lock stat */
 const volatile int aggr_mode;
diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
index c15f734d7fc4..15f5743bd409 100644
--- a/tools/perf/util/bpf_skel/lock_data.h
+++ b/tools/perf/util/bpf_skel/lock_data.h
@@ -3,6 +3,13 @@
 #ifndef UTIL_BPF_SKEL_LOCK_DATA_H
 #define UTIL_BPF_SKEL_LOCK_DATA_H
 
+struct owner_tracing_data {
+	u32 pid; // Who has the lock.
+	u32 count; // How many waiters for this lock.
+	u64 timestamp; // The time while the owner acquires lock and contention is going on.
+	s32 stack_id; // Identifier for `owner_stat`, which stores as value in `owner_stacks`
+};
+
 struct tstamp_data {
 	u64 timestamp;
 	u64 lock;
-- 
2.48.1.601.g30ceb7b040-goog

