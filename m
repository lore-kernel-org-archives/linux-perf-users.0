Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116EB1DED6F
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2025 21:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740001537; cv=none; b=H7arcekF4nPQUAcsAR80b1Bp4z/YMw6ZNVK+cQGavT5veI8QNGo5U+pYLvyjx6hZ1kO3EW6LMSG4lUwb829aroRxz240VhEK+yoztCfHus2ZPyiw2vA7aC+zQoacAve/VaXasocetQ6A3vNy80biv4f0p/B/XurJ5bRheOcC8aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740001537; c=relaxed/simple;
	bh=+eUkK/iMLMnPi2bDwVTw1Pgm27u0MPdVhFfDE74FNK4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K2gHbCyfzREG5RtkgpQdv+Klt1pnIf2tCaLDkSxJAWivDDDkk7f8HfVl0eR2BHW1fwBAGWD8OuKtowkbeWobY3qWZgNpZVCjkLHKu+AWyH5Khiiwm8f1CTF7iAJFs6RHmFEwfSM1qCS5bO4CzaI+1OkxWkxVC1megHMSfgHOj+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JHgJS1Nz; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JHgJS1Nz"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220c86b3ef3so27279215ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2025 13:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740001535; x=1740606335; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R9XCsc+sgxUI5SOE40I45gWQYV0M4BiiAlFbbfMY96A=;
        b=JHgJS1NzZ/drNPp1YHQefAW3CNgne0Z3Qn8szAl04Hyg3678etRQos5nRflqMniWhB
         0BC0iEKNhTZ3LyoID/KnLnacSP1RyCb82hbs5x1MT2gvb4aLm0Kp3isbbeldSLwukC5r
         XttV+6DfQ/XCy7k5j/VWhHdBDPqSPGM6SvIM1Usirg5Ekw0VrlbiVKrnscY81TZrDEap
         x2cmxxn+bMb9BOIvO95iJHxIc53baZa9PCZJxa5jLRIczL2NoL+yWY0Ecmg4ULbKxhJ9
         5t91+xqlKgw43C3xvvbtiqd0/9f27Sj5UWo7Iq3327wXBRWXOszygyi+wPbkddzArNV/
         fMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740001535; x=1740606335;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R9XCsc+sgxUI5SOE40I45gWQYV0M4BiiAlFbbfMY96A=;
        b=QX3SGpS0qshUKHJRfKk7h8VkW/WaKiHGI52EnTOsosqXKSGPrV0PzmsCU3MxW/ZfQR
         hqpO1ofGyTT9MG7RhBOw4inNGMdb842GDPyUOoz4l0ZzAJMX9Hk2w51GX0hc9Hk2Widf
         ooITK3bmitETxmw5q5f63NUTWXu+JlzcBeree0wLp/WpHv2GIV7q+VsX2oChX2aYrAaI
         1gnpztrHmneAwcXBJYxAnpphgnR1dMsZLdhJ3Vn1ZrC+fT1tu3GBnmQfu90MlijQ0GQs
         xQj7uD9fYMrrmZF5UiMnvMmi14vfwGKB+mqhFpHzQSsXUM633WJulX9WLm2LU5+Tnv8x
         wpEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYewGOL1v/USw58lvQFB1MI2ywCf6zltzUCMXes2zlDm1kvDbO50O5fg8JtvhG1NYwXhudiD1tpfvzGiM6EdEV@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw/gsp1cfPVv35XEVqiUl+x8Mcp2C3FnW/5Xa+vkklXTh0I7Ha
	5UUqPFOp2LN8ypUTevidqP/6f92dPRCBkoIO2IFtj1HI3YO6FLwjd8j9HDM4HkC3KrHkbRysQUw
	NSQ==
X-Google-Smtp-Source: AGHT+IEr4XOJfbVGm62C1up0rxHHtYYCZ/jvQYmID3Q9Y23kgJjNXv8tTXR/JqI+FGWn2nzMhHvlem9jYWw=
X-Received: from plqw12.prod.google.com ([2002:a17:902:a70c:b0:21f:4f0a:c7e2])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:8cb:b0:220:e98e:4f1b
 with SMTP id d9443c01a7336-2218c356405mr18224675ad.0.1740001535274; Wed, 19
 Feb 2025 13:45:35 -0800 (PST)
Date: Wed, 19 Feb 2025 13:40:01 -0800
In-Reply-To: <20250219214400.3317548-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250219214400.3317548-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250219214400.3317548-3-ctshao@google.com>
Subject: [PATCH v6 2/4] perf lock: Retrieve owner callstack in bpf program
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, nick.forrington@arm.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This implements per-callstack aggregation of lock owners in addition to
per-thread.  The owner callstack is captured using `bpf_get_task_stack()`
at `contention_begin()` and it also adds a custom stackid function for the
owner stacks to be compared easily.

The owner info is kept in a hash map using lock addr as a key to handle
multiple waiters for the same lock.  At `contention_end()`, it updates the
owner lock stat based on the info that was saved at `contention_begin()`.
If there are more waiters, it'd update the owner pid to itself as
`contention_end()` means it gets the lock now.  But it also needs to check
the return value of the lock function in case task was killed by a signal
or something.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 218 +++++++++++++++++-
 1 file changed, 209 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 23fe9cc980ae..e8b113d5802a 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -197,6 +197,9 @@ int data_fail;
 int task_map_full;
 int data_map_full;
 
+struct task_struct *bpf_task_from_pid(s32 pid) __ksym __weak;
+void bpf_task_release(struct task_struct *p) __ksym __weak;
+
 static inline __u64 get_current_cgroup_id(void)
 {
 	struct task_struct *task;
@@ -420,6 +423,61 @@ static inline struct tstamp_data *get_tstamp_elem(__u32 flags)
 	return pelem;
 }
 
+static inline s32 get_owner_stack_id(u64 *stacktrace)
+{
+	s32 *id, new_id;
+	static s64 id_gen = 1;
+
+	id = bpf_map_lookup_elem(&owner_stacks, stacktrace);
+	if (id)
+		return *id;
+
+	new_id = (s32)__sync_fetch_and_add(&id_gen, 1);
+
+	bpf_map_update_elem(&owner_stacks, stacktrace, &new_id, BPF_NOEXIST);
+
+	id = bpf_map_lookup_elem(&owner_stacks, stacktrace);
+	if (id)
+		return *id;
+
+	return -1;
+}
+
+static inline void update_contention_data(struct contention_data *data, u64 duration, u32 count)
+{
+	__sync_fetch_and_add(&data->total_time, duration);
+	__sync_fetch_and_add(&data->count, count);
+
+	/* FIXME: need atomic operations */
+	if (data->max_time < duration)
+		data->max_time = duration;
+	if (data->min_time > duration)
+		data->min_time = duration;
+}
+
+static inline void update_owner_stat(u32 id, u64 duration, u32 flags)
+{
+	struct contention_key key = {
+		.stack_id = id,
+		.pid = 0,
+		.lock_addr_or_cgroup = 0,
+	};
+	struct contention_data *data = bpf_map_lookup_elem(&owner_stat, &key);
+
+	if (!data) {
+		struct contention_data first = {
+			.total_time = duration,
+			.max_time = duration,
+			.min_time = duration,
+			.count = 1,
+			.flags = flags,
+		};
+		bpf_map_update_elem(&owner_stat, &key, &first, BPF_NOEXIST);
+	} else {
+		update_contention_data(data, duration, 1);
+	}
+}
+
 SEC("tp_btf/contention_begin")
 int contention_begin(u64 *ctx)
 {
@@ -437,6 +495,72 @@ int contention_begin(u64 *ctx)
 	pelem->flags = (__u32)ctx[1];
 
 	if (needs_callstack) {
+		u32 i = 0;
+		u32 id = 0;
+		int owner_pid;
+		u64 *buf;
+		struct task_struct *task;
+		struct owner_tracing_data *otdata;
+
+		if (!lock_owner)
+			goto skip_owner;
+
+		task = get_lock_owner(pelem->lock, pelem->flags);
+		if (!task)
+			goto skip_owner;
+
+		owner_pid = BPF_CORE_READ(task, pid);
+
+		buf = bpf_map_lookup_elem(&stack_buf, &i);
+		if (!buf)
+			goto skip_owner;
+		for (i = 0; i < max_stack; i++)
+			buf[i] = 0x0;
+
+		if (!bpf_task_from_pid)
+			goto skip_owner;
+
+		task = bpf_task_from_pid(owner_pid);
+		if (!task)
+			goto skip_owner;
+
+		bpf_get_task_stack(task, buf, max_stack * sizeof(unsigned long), 0);
+		bpf_task_release(task);
+
+		otdata = bpf_map_lookup_elem(&owner_data, &pelem->lock);
+		id = get_owner_stack_id(buf);
+
+		/*
+		 * Contention just happens, or corner case `lock` is owned by process not
+		 * `owner_pid`. For the corner case we treat it as unexpected internal error and
+		 * just ignore the precvious tracing record.
+		 */
+		if (!otdata || otdata->pid != owner_pid) {
+			struct owner_tracing_data first = {
+				.pid = owner_pid,
+				.timestamp = pelem->timestamp,
+				.count = 1,
+				.stack_id = id,
+			};
+			bpf_map_update_elem(&owner_data, &pelem->lock, &first, BPF_ANY);
+		}
+		/* Contention is ongoing and new waiter joins */
+		else {
+			__sync_fetch_and_add(&otdata->count, 1);
+
+			/*
+			 * The owner is the same, but stacktrace might be changed. In this case we
+			 * store/update `owner_stat` based on current owner stack id.
+			 */
+			if (id != otdata->stack_id) {
+				update_owner_stat(id, pelem->timestamp - otdata->timestamp,
+						  pelem->flags);
+
+				otdata->timestamp = pelem->timestamp;
+				otdata->stack_id = id;
+			}
+		}
+skip_owner:
 		pelem->stack_id = bpf_get_stackid(ctx, &stacks,
 						  BPF_F_FAST_STACK_CMP | stack_skip);
 		if (pelem->stack_id < 0)
@@ -473,6 +597,7 @@ int contention_end(u64 *ctx)
 	struct tstamp_data *pelem;
 	struct contention_key key = {};
 	struct contention_data *data;
+	__u64 timestamp;
 	__u64 duration;
 	bool need_delete = false;
 
@@ -500,12 +625,94 @@ int contention_end(u64 *ctx)
 		need_delete = true;
 	}
 
-	duration = bpf_ktime_get_ns() - pelem->timestamp;
+	timestamp = bpf_ktime_get_ns();
+	duration = timestamp - pelem->timestamp;
 	if ((__s64)duration < 0) {
 		__sync_fetch_and_add(&time_fail, 1);
 		goto out;
 	}
 
+	if (needs_callstack && lock_owner) {
+		struct owner_tracing_data *otdata = bpf_map_lookup_elem(&owner_data, &pelem->lock);
+
+		if (!otdata)
+			goto skip_owner;
+
+		/* Update `owner_stat` */
+		update_owner_stat(otdata->stack_id, timestamp - otdata->timestamp, pelem->flags);
+
+		/* No contention is occurring, delete `lock` entry in `owner_data` */
+		if (otdata->count <= 1)
+			bpf_map_delete_elem(&owner_data, &pelem->lock);
+		/*
+		 * Contention is still ongoing, with a new owner (current task). `owner_data`
+		 * should be updated accordingly.
+		 */
+		else {
+			u32 i = 0;
+			s32 ret = (s32)ctx[1];
+			u64 *buf;
+
+			__sync_fetch_and_add(&otdata->count, -1);
+
+			buf = bpf_map_lookup_elem(&stack_buf, &i);
+			if (!buf)
+				goto skip_owner;
+			for (i = 0; i < (u32)max_stack; i++)
+				buf[i] = 0x0;
+
+			/*
+			 * `ret` has the return code of the lock function.
+			 * If `ret` is negative, the current task terminates lock waiting without
+			 * acquiring it. Owner is not changed, but we still need to update the owner
+			 * stack.
+			 */
+			if (ret < 0) {
+				s32 id = 0;
+				struct task_struct *task;
+
+				if (!bpf_task_from_pid)
+					goto skip_owner;
+
+				task = bpf_task_from_pid(otdata->pid);
+				if (!task)
+					goto skip_owner;
+
+				bpf_get_task_stack(task, buf,
+						   max_stack * sizeof(unsigned long), 0);
+				bpf_task_release(task);
+
+				id = get_owner_stack_id(buf);
+
+				/*
+				 * If owner stack is changed, update `owner_data` and `owner_stat`
+				 * accordingly.
+				 */
+				if (id != otdata->stack_id) {
+					update_owner_stat(id, pelem->timestamp - otdata->timestamp,
+							  pelem->flags);
+
+					otdata->timestamp = pelem->timestamp;
+					otdata->stack_id = id;
+				}
+			}
+			/*
+			 * Otherwise, update tracing data with the current task, which is the new
+			 * owner.
+			 */
+			else {
+				otdata->pid = pid;
+				otdata->timestamp = timestamp;
+				/*
+				 * We don't want to retrieve callstack here, since it is where the
+				 * current task acquires the lock and provides no additional
+				 * information. We simply assign -1 to invalidate it.
+				 */
+				otdata->stack_id = -1;
+			}
+		}
+	}
+skip_owner:
 	switch (aggr_mode) {
 	case LOCK_AGGR_CALLER:
 		key.stack_id = pelem->stack_id;
@@ -589,14 +796,7 @@ int contention_end(u64 *ctx)
 	}
 
 found:
-	__sync_fetch_and_add(&data->total_time, duration);
-	__sync_fetch_and_add(&data->count, 1);
-
-	/* FIXME: need atomic operations */
-	if (data->max_time < duration)
-		data->max_time = duration;
-	if (data->min_time > duration)
-		data->min_time = duration;
+	update_contention_data(data, duration, 1);
 
 out:
 	pelem->lock = 0;
-- 
2.48.1.601.g30ceb7b040-goog

