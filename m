Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9445D1865E5
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 05:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736745770; cv=none; b=gwGCruzl7G/ZhP1gR+nfmbn8v1CWKekz6pVEot5SfTOr4D5gBBgkVuaG+7TNj6b970nRba4FTK9tQMCiQ1lqnxESaEjDrJ/ooZSvwq2j4/lhuwybXf+MUk2xaYnxP2IwNNeIjIA80xHMKXjraAqJv4S/wfQCYo9/J6MWvw5wWUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736745770; c=relaxed/simple;
	bh=PdTe3jFnoCLWzm3kmTMuOUCvtR+GmRocsG2mc9gfwJE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tCVgOOUeHLNivJle8GoBds1VwY4xYagUwY+PfO/s3op9Rk+6EtN8jTAIYuZtvwuqOcTb0UzM3nStrlD0FiJqmp+ULVfMyJWnp6iIplpmndSOjlVGdtVXDp7ZhzxRB6eA/U6Ui8bndQg+Y7Gi3vNBnK1Ne9HI0wpNnQDUENeeRsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XTy6+AD5; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XTy6+AD5"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21681a2c0d5so70088645ad.2
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Jan 2025 21:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736745768; x=1737350568; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QOc+Zq7RKw8PAGfDRJz3cORnG4jrHFHNhA/YUYdk0Pc=;
        b=XTy6+AD5WymuFRHb+EP/IS3Tj3Cttqx3mYARK8FWDBP6jImcIRXZ7ZWCV44Sp/1Xzp
         eX6XgE7Pk57tf3dVuXzVPCAgzlQSYqVDZhRZgeYFxG5GYWELkEvg8A89n/0keRrxjjsU
         DkOa2p2yBKcH6A9LuUGX3ZRyMc9eeaTaYw28egdkwr2keqfPiLIB2sY+f7Iz++wB3FOr
         CwxJHAwFxnAsErw9tUpZFR5u295jC0KWBSOfGW2NDzG9zkqAWitEyjuQap/q+GkiQqpW
         t37xAgwLmrcntI7sacNtgEAaOKTQcJaF694WoNEilalnIVLP0GJaBQ6xSY4cQZOP0IMg
         hwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736745768; x=1737350568;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QOc+Zq7RKw8PAGfDRJz3cORnG4jrHFHNhA/YUYdk0Pc=;
        b=lWU9MFGKvNu7IPeKA33EKc000HaKGDunzvbQBJcG6V4xDSANPEUtBMLjMD9D8xublj
         fcCVeLP9RL0Spsc8sxSmSvXfOcEIML8xnQMmUsWOHLSGoMOieFuCwpYBpqhOJ5OJO+Ur
         LJ5KebpatcpVBQqbIL3emmriQAi4RJGx1QieUy9ocnnt0MIk0WWVBNdwSSx1DGJ7IyRV
         VJoKDtC6thvjLZE8JYPBWO8Yz8h+XTpH7S5kOFGXGkNafeWKPORGuAMYjgSMWTNE43ZZ
         5T+Ta4kWFbAkgDxkoat1i3f28E0Kd4K+w36nABhUZZfrweGMB2wLlNm/r92x6V9D73eb
         JQLg==
X-Forwarded-Encrypted: i=1; AJvYcCUe3Zl7yKevYun5Ia8AT0JSe4UV4AGId/wr+HneLexfWT4l7O6KMp9eG5nkqjfhcS7OpBgzZ4BayQYDs3jmrxA9@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3d15wpK7sb3uH3T+X7QChhQxnpK9U+7LBuflxeN2gP41md2lu
	jGS41MkpVozgSlhA1YSaOLx3ZOzXjdcHm1lbPIZjeBbvj9GYZbKb2krPycePPmr1tocpNQVOh5z
	Pyw==
X-Google-Smtp-Source: AGHT+IHH/Mxk3EqK90R+Z9E4lysnhPshUJ3SCSQXzHeG1/4fEs9Zwt+JxdWBKH1V7xSGCQ4evVrdtYgZbdw=
X-Received: from pfay7.prod.google.com ([2002:a05:6a00:1807:b0:72a:89d4:9641])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d045:b0:1e1:afa9:d38a
 with SMTP id adf61e73a8af0-1e88d0dfa70mr29764707637.1.1736745768047; Sun, 12
 Jan 2025 21:22:48 -0800 (PST)
Date: Sun, 12 Jan 2025 21:20:14 -0800
In-Reply-To: <20250113052220.2105645-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250113052220.2105645-1-ctshao@google.com>
X-Mailer: git-send-email 2.47.1.688.g23fc6f90ad-goog
Message-ID: <20250113052220.2105645-2-ctshao@google.com>
Subject: [PATCH v2 1/4] perf lock: Add bpf maps for owner stack tracing
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add few bpf maps in order to tracing owner stack.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/util/bpf_lock_contention.c         | 17 ++++++--
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 40 +++++++++++++++++--
 tools/perf/util/bpf_skel/lock_data.h          |  6 +++
 3 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 41a1ad087895..c9c58f243ceb 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -41,9 +41,20 @@ int lock_contention_prepare(struct lock_contention *con)
 	else
 		bpf_map__set_max_entries(skel->maps.task_data, 1);
 
-	if (con->save_callstack)
-		bpf_map__set_max_entries(skel->maps.stacks, con->map_nr_entries);
-	else
+	if (con->save_callstack) {
+		bpf_map__set_max_entries(skel->maps.stacks,
+					 con->map_nr_entries);
+		if (con->owner) {
+			bpf_map__set_value_size(skel->maps.owner_stacks_entries,
+						con->max_stack * sizeof(u64));
+			bpf_map__set_value_size(
+				skel->maps.contention_owner_stacks,
+				con->max_stack * sizeof(u64));
+			bpf_map__set_key_size(skel->maps.owner_lock_stat,
+						con->max_stack * sizeof(u64));
+			skel->rodata->max_stack = con->max_stack;
+		}
+	} else
 		bpf_map__set_max_entries(skel->maps.stacks, 1);
 
 	if (target__has_cpu(target)) {
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 1069bda5d733..05da19fdab23 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -19,13 +19,37 @@
 #define LCB_F_PERCPU	(1U << 4)
 #define LCB_F_MUTEX	(1U << 5)
 
-/* callstack storage  */
+ /* tmp buffer for owner callstack */
 struct {
-	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
 	__uint(key_size, sizeof(__u32));
 	__uint(value_size, sizeof(__u64));
+	__uint(max_entries, 1);
+} owner_stacks_entries SEC(".maps");
+
+/* a map for tracing lock address to owner data */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u64)); // lock address
+	__uint(value_size, sizeof(cotd));
 	__uint(max_entries, MAX_ENTRIES);
-} stacks SEC(".maps");
+} contention_owner_tracing SEC(".maps");
+
+/* a map for tracing lock address to owner stacktrace */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u64)); // lock address
+	__uint(value_size, sizeof(__u64)); // straktrace
+	__uint(max_entries, MAX_ENTRIES);
+} contention_owner_stacks SEC(".maps");
+
+/* owner callstack to contention data storage */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u64));
+	__uint(value_size, sizeof(struct contention_data));
+	__uint(max_entries, MAX_ENTRIES);
+} owner_lock_stat SEC(".maps");
 
 /* maintain timestamp at the beginning of contention */
 struct {
@@ -43,6 +67,14 @@ struct {
 	__uint(max_entries, 1);
 } tstamp_cpu SEC(".maps");
 
+/* callstack storage  */
+struct {
+	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u64));
+	__uint(max_entries, MAX_ENTRIES);
+} stacks SEC(".maps");
+
 /* actual lock contention statistics */
 struct {
 	__uint(type, BPF_MAP_TYPE_HASH);
@@ -126,6 +158,7 @@ const volatile int needs_callstack;
 const volatile int stack_skip;
 const volatile int lock_owner;
 const volatile int use_cgroup_v2;
+const volatile int max_stack;
 
 /* determine the key of lock stat */
 const volatile int aggr_mode;
@@ -436,7 +469,6 @@ int contention_end(u64 *ctx)
 			return 0;
 		need_delete = true;
 	}
-
 	duration = bpf_ktime_get_ns() - pelem->timestamp;
 	if ((__s64)duration < 0) {
 		__sync_fetch_and_add(&time_fail, 1);
diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
index de12892f992f..1ef0bca9860e 100644
--- a/tools/perf/util/bpf_skel/lock_data.h
+++ b/tools/perf/util/bpf_skel/lock_data.h
@@ -3,6 +3,12 @@
 #ifndef UTIL_BPF_SKEL_LOCK_DATA_H
 #define UTIL_BPF_SKEL_LOCK_DATA_H
 
+typedef struct contention_owner_tracing_data {
+	u32 pid; // Who has the lock.
+	u64 timestamp; // The time while the owner acquires lock and contention is going on.
+	u32 count; // How many waiters for this lock.
+} cotd;
+
 struct tstamp_data {
 	u64 timestamp;
 	u64 lock;
-- 
2.47.1.688.g23fc6f90ad-goog

