Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBFC204086
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Feb 2025 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399381; cv=none; b=gCcHR83Mh7MeCjSFEuSd0a1pXkpyxNB5E4yv3IQ8VI6nZPffJMcgFRyU/6/0EKWdtdVU7CASfaZqNNOcCxSOK2cwWq9ML1jb7u+r0s6XRMUGEwNS8TGKM/O109b8kGpg5gkXY/ew/nhBxyL3aJTR4gDOsX/Uq5zB5C39+ps+P0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399381; c=relaxed/simple;
	bh=OWCpQfV15fjfs91X5TWsuZAUowIODtiQVMeIkdX4org=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dJxUikgUdmOqV8EoyzdOcl4q25T3wLfOiawNWuo2zVc7ITpXEO7iucNNBrO2KpvTo/MIFaqkci2RNtpRk2A0aMbnGy07iCoy8hDVojRT3UaH5alfFslGCbSL64rRmy86DUjXgLE/b7nqwGB5n7HHHbZ0Z3WvreInY5X/9LrWM04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IF0brA+Z; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IF0brA+Z"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-216266cc0acso27153705ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Feb 2025 14:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739399378; x=1740004178; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3O9bMfrQLSuEn1cesD7grG9bYwMcsNdAGFS2Zv9IEeA=;
        b=IF0brA+Zd65etVDoaHi5ADqKjNjD8E31MTNFg1mVhO3CJeWL4u53PgPlSI4hQhz02E
         CgAeq5ZsJts3DjjorUdMYL/xn3CC45FV5qZGrEsWClZr8jChCFfwHw9ppGASstQxO5CG
         kzt2j8XG+DfmgzjbbHTBLR15of+EKtFbdKzxfaYBHNI0s2pkNGafS319VFaYoxSdk/3R
         QTGIgl+ytQPvOEHLnCbv4/4+fFiywqixua5Z1cOUnNG1RLtdr0lVGtwBH3eZkc8/fa2I
         zuget0tsLbX/6+c8mAJfW8/JdCiwlKMLyXQaE3EWkhZB0mSje+Hifku50B922LIsWtp+
         cewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739399378; x=1740004178;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3O9bMfrQLSuEn1cesD7grG9bYwMcsNdAGFS2Zv9IEeA=;
        b=QbqIvQCCPQG1V09S8MY35qFrIdpRWKQN2ReS2gIx19Z1nuvN3P1WWXS9l3butRvIF6
         AI18zMegCXA00DsRg9Aostj+CcZMGUxosyktaHIGTT6V7/x0Hy7Nb6uDbe+VKxLijDhl
         DrTkYb1lXt0MW4A76J3uCzC5dzryotezE04WtLD1TsIP95PzMflTkxDsG3s6J3Euzb/N
         Z4KcHVQOA5T4FAzXpCL9rmKIv91dT8oesRfFZFSJy5xpyqCidv5oCac/447YNnn23VPO
         U8rEIGu3wJlYq8vnrPmhRhKDBG7Vyhw3lXmDpGvgzBcdDG36EZNrPVA/KBt6PfCZFalr
         qOGw==
X-Forwarded-Encrypted: i=1; AJvYcCWno4N+iVUjw863GfptG3rv5Jr6mXbZa2/5ShdE5kId/UHVyoDWYeWnCX5KQPiZhYzDNWW1YeENPsqU2OqKdZWg@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4tH4fTIUB425PSTYHmHLl6ag88lJOS/Udl9hGg7qlk/L9Aci3
	t3Ct7bp5Z9/eam0BVrsvhGJ1ow9yeb1Utu14IBEulS+6s4WpNIAtnjgUFTjffPRoSyFhKUTy/u9
	H7w==
X-Google-Smtp-Source: AGHT+IGH91oQbQqQOltRzwNzcwjx/9c8q5oX8zM6hIaW2Mk5foDZ/RclC94i5ELe3GWDZVuHmetFFqhI8es=
X-Received: from pgbcr7.prod.google.com ([2002:a05:6a02:4107:b0:ad5:55c3:4034])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:12cb:b0:1ee:64c0:aa85
 with SMTP id adf61e73a8af0-1ee6c619d45mr958280637.6.1739399378557; Wed, 12
 Feb 2025 14:29:38 -0800 (PST)
Date: Wed, 12 Feb 2025 14:24:52 -0800
In-Reply-To: <20250212222859.2086080-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250212222859.2086080-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250212222859.2086080-2-ctshao@google.com>
Subject: [PATCH v5 1/5] perf lock: Add bpf maps for owner stack tracing
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
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
2.48.1.502.g6dc24dfdaf-goog

