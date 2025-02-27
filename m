Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C40D27005B
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Feb 2025 00:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616549; cv=none; b=UIWPOQplfZcVIADAEMOHkKNZMjz7uZ9v9gc5C+qyZnKSflwqXG25dJDDDPlaP8iFq5t8Gm2lZr5vDsOCSoxe9JHLo+Iz5aHBEnPr/Ma8jcBaqv/4YEv9khUl5+7Zh+BNtEe+G+lbLgqbkTK8FN8Lu9nUXYZ/9Fq2xGrklBSyw3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616549; c=relaxed/simple;
	bh=sX6k+ExVgGNyDnumdmJIdayUEA+By8ga08Ti0Wfuoc8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YOeAbt6WBirTGOx1CQOuvX5bHKStMpmcLPiyDVlid5L1uT/DvH5eeia8Fw8OVpW1X9IQaBvAJLqVCJgnP/RfEdJt5tsk1PF857xvr0Y4Vauuz7ZvmW+8UYnRucpTVd9Tjj3nZRqxzVDGPWz0Cfl6FJ2B/AiNH0cALch+YmnfWqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CV93pHNl; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CV93pHNl"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2234c09241fso9374345ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2025 16:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740616547; x=1741221347; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uT5qN4teqIhN8OgGcN83osIEOThqIeAxronJTF18w94=;
        b=CV93pHNlEJa0nnH2FFCd9LoeYfdJBYrBlB3/XXlf3ud1rtRaS1obrYT60g9HIZxA/p
         j2cghqq8xyGh8p6dt+b7fHZe/l57Ilga7psO1P+uHr4o0Fmaxv8mueppNUERFaVdMO/T
         DTCzNmYyQHxwyxQgrmW1CbgMCcuM+hQ/PtevE2f3sVlBxdhMjWPLgCbziapv0HI9cm1M
         2vOA3zGsxCB3CTAryo7DEJ8alLbogjXmrOwHP/nQldk1gAZsZ4ALmLmUmmyXDTTAf5x6
         5+vmydmrWyXzLTCpVe8la6b4TVzV8PWjeZW+pOyGGt607ys3xdjahxHLXsi9ZPaPEDUw
         8O2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740616547; x=1741221347;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uT5qN4teqIhN8OgGcN83osIEOThqIeAxronJTF18w94=;
        b=Txw4VYaWrJmRGSUc+fapn1Yvmc3D6/Fk1zvFZQR2VJqR2o6wb7brp+jHgF9p/FEcje
         9q8EyLUqZSUeenBWkqJR0dEQIcjGgBG78J9uWk8tiz1MQC1do3QBPrR59NwoObE1fyhc
         2UgDvAfemJPoDnI+uho6SWsj8mOsdkrwJHxFqunOSNKJf0AtslxHT7AHZ718YosYKchl
         X4+/3ioynT3YbQzPxJZSfR0g/DkMB3U5AL8lfHAdpxn/o3Wl7zoAxrEstvygst28wsR9
         1YaxoceL04SBvv04N08gfSLAAmCLyxHXHzPGC391qd3mf2TTWSWVNbnQmbY1jxIzjHyl
         QQ2g==
X-Forwarded-Encrypted: i=1; AJvYcCVZhyy0Vkqerz1RE0szDP6VpJKV8n0V1Z61soxd1t4ZgmPtAPMm/odC9/5lPI4QhhFE7o91YhxX0vehTfFHmdC9@vger.kernel.org
X-Gm-Message-State: AOJu0YwJdSaJVgpaZpNNIOiuUaBvUEW0VcQwHPVoEI93+yph6r8+7+Wf
	Ss8no/9yQ9qJjfRNVmo9eal/JNyhwgGUq+YwKf5xaagRiUgISzL5Etey67NDuGohnAv+cKipaAq
	3JA==
X-Google-Smtp-Source: AGHT+IEhVou1kAichbSUs8mzNp9wPwBY0b2D1W3ERA7S8+Dol9j5TmEUBzuy/uk5ihEM3zbiUALvmCyQzkQ=
X-Received: from pfuw10.prod.google.com ([2002:a05:6a00:14ca:b0:732:9235:5f2])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1709:b0:732:2967:400
 with SMTP id d2e1a72fcca58-7347910977emr14896254b3a.12.1740616546640; Wed, 26
 Feb 2025 16:35:46 -0800 (PST)
Date: Wed, 26 Feb 2025 16:28:54 -0800
In-Reply-To: <20250227003359.732948-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227003359.732948-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250227003359.732948-3-ctshao@google.com>
Subject: [PATCH v8 2/4] perf lock: Retrieve owner callstack in bpf program
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
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 212 +++++++++++++++++-
 1 file changed, 203 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 23fe9cc980ae..69be7a4234e0 100644
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
 
@@ -500,12 +625,88 @@ int contention_end(u64 *ctx)
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
+			otdata->timestamp = timestamp;
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
+				 * If owner stack is changed, update owner stack id for this lock.
+				 */
+				if (id != otdata->stack_id)
+					otdata->stack_id = id;
+			}
+			/*
+			 * Otherwise, update tracing data with the current task, which is the new
+			 * owner.
+			 */
+			else {
+				otdata->pid = pid;
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
@@ -589,14 +790,7 @@ int contention_end(u64 *ctx)
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
2.48.1.658.g4767266eb4-goog

