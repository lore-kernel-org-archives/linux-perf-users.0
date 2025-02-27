Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B431CC2EF
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Feb 2025 00:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616502; cv=none; b=Tj/YebE7jw/k+FlPB2VjsxYjo2Gw+0Uyk8wkjB8jlRev8/n4MX70Q4fOmLetnkKjVl/hN5OjXdEnNVNGVSh8uFKHjSLyXIeetovxXulxs4+QsN0gwxfdGpDp+IMt8DmduybPhAgtemuElbqXZFFfKdOmoWiO4PlSrOCjhMoIeb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616502; c=relaxed/simple;
	bh=uMnqvAw20MjO8y1DkOGmvKZ76yZAmQWMHc3q5tVE6c4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t5l2u7ic97w5D0+sR2Uijn8jJGKu8IE1tAw2JqNC/FjiR1cO75++IZb/dWrZ5Jp2ll63NkohU4nCaQ/I5XdkLDyHIYuFz4+AGSqER6GJxZ0kVfGUxhvapVvaSWn5Ar5Xz3A2AmjP+KCB4a+yKdaYe7twJUXzTRQaWYnBbxvlX70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d/+ebxt1; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d/+ebxt1"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220caea15ccso9730315ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2025 16:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740616500; x=1741221300; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3LIHL/AK+Ozu93SKs05RSuuBRbA8GccmzuqZN2pzdx8=;
        b=d/+ebxt1taEkk7kAsAi0BQufMNbg9dO/Ct8hz7uqfxpMYdOBTjRARCN+JWwxMSA1KI
         ypjlnyH1XOBvfji3SeQmHfk9nH/1U6FJX1ZBaY2C1HoZ8qLAmPFxCqKAbyuNzjItb7J5
         QrCwYkrsoa88IYOamutKr3wezcnLhd7IMggB9Fpq7UfQLRDUML3YGi5dioTIpAqBk+Vr
         KfGTeWmuGElQUNLtML4gk+Qq4BZWVTG0A+nOQvwIljePIyA6eK5/tbSTIAyTmXj3uUF4
         f84y6g6UHworGlIJUQFXjzszdGQa28PFvzhWV9qqU+1cKa8grFmxb9Cg/LlSQazE0jFG
         vbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740616500; x=1741221300;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3LIHL/AK+Ozu93SKs05RSuuBRbA8GccmzuqZN2pzdx8=;
        b=hV7X5lvv1N2w8g4dqUHw/KEXmIqQ/43rg3j+MxSw3+nrAbA09+0P6laUO5HRCJeTGT
         6n4+TQZ94vRdGYhu9YP93heD528LnDxTffEX31m94WUWrjtdpwxDBvAhfxCaSTxAH5sa
         4nLCtEMTODQWMpq3v3ck6ZDJ2zUQb2cU+6xhvpEc4yfCasYswfRvZv5heRnc1L1oVXDt
         s1igv2xhTlooYvcQcwFHkZZvJQ2DcxsNzosSD3/OtI+1H23/wx17gs7OgnOA62pLW6QD
         H6U78h/ElYMmNs1pDKpT+2g+fqnigW14dxql2uZ/xQLbizXJVkMgH79M0C7b0IwDkQNu
         Qc7g==
X-Forwarded-Encrypted: i=1; AJvYcCXYBXzBshJckwIocIVLwPYw6CyNsQc6kDhShmNCr3VYhTHxqWENmshjqvM5HnFnGqS/57x5isxwfwyLas/2ZMWi@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxf/Wp4Ww05a+QgPm2/OStpyOvVpmhHNZEFNXRjnIJ7iwO6YqP
	xdknO2ALifRkp/uiZ02rxAERNkV7/n2jf9nve2dvJg3EqGFuaIj4aZN/rp1BX8N28qNqKgQXV6n
	JSw==
X-Google-Smtp-Source: AGHT+IGzqpdRIlXGVg5tN41iPkn8q/I+EgwjsABLkG5nK/bxhoYAQCfVKFZZej6m6MOjXo0szVKcrocvD50=
X-Received: from plbje3.prod.google.com ([2002:a17:903:2643:b0:223:4e55:d29a])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f92:b0:220:e896:54e1
 with SMTP id d9443c01a7336-221a10de4fdmr348252035ad.26.1740616498752; Wed, 26
 Feb 2025 16:34:58 -0800 (PST)
Date: Wed, 26 Feb 2025 16:28:53 -0800
In-Reply-To: <20250227003359.732948-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227003359.732948-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250227003359.732948-2-ctshao@google.com>
Subject: [PATCH v8 1/4] perf lock: Add bpf maps for owner stack tracing
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
2.48.1.658.g4767266eb4-goog

