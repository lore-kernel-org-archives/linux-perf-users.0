Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8FB1779B8
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 05:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736486068; cv=none; b=kLleD2AXehB61eJsLR/J9qTNC0GllsZ+XTNzRnQv6xMmQh1d/zzI1oghEGk3OkpMxoGGS1l5GE7E3Mb0ey2n7KTwNB1LMjgmHS1Ivqb8Qs+RlwSogd26G/XMrlewnugSHAakx0Z5vAjr/9kPtb776XqBYrnckbeoSjXbeB/HAYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736486068; c=relaxed/simple;
	bh=PdTe3jFnoCLWzm3kmTMuOUCvtR+GmRocsG2mc9gfwJE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lAukD6br7w+HeEwUwpSKQCyVElxceGDOAmeQtVqOb1fW52oK93ljy48vGJYRpPRbLNp5NVn9SrnChAE2z+SK0qwesAaJxL+gyJP+TTr8gZ4h9du8AQNH/hXfcslbeRS0VWgRtbTM+eSjuLRWuh9jqOSdv+dZv/7/7xT0k1WvVWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LHFYvfl3; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LHFYvfl3"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef9864e006so4846832a91.2
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jan 2025 21:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736486066; x=1737090866; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QOc+Zq7RKw8PAGfDRJz3cORnG4jrHFHNhA/YUYdk0Pc=;
        b=LHFYvfl3V1gDzJs4PIWHBPrlpESBCy1eCeHgBGDqVYxpsVR3+TJxomewZlexba9Ldg
         v6d3gasSmzMxDvRAeAcqnb59gLGJK7KflGP6oCCajLNpicBS3yeoOK5penqOawViWQg1
         rS2GBD/gSZWXdEX7tyLTGZXm9NQSzYs5iU0q8TAvt8IFlHzERi4kH37+n3gkqxwaUk2B
         MBPKr4tiGu9sogeYZxHOeORoH2lpNT6l1qnF/pyL+cOeRW05foAEaTqgzwsO5EcL+9F/
         2k/3iFdPjUiI+V8S94KnsSRmM9h8ZXKwTDbFkErRR4WDjQtsb1CuCUE3lxRMQ9wYBk1z
         i0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736486066; x=1737090866;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QOc+Zq7RKw8PAGfDRJz3cORnG4jrHFHNhA/YUYdk0Pc=;
        b=aPOjh2VpJvpu2TZBOVVa+H0Fic2oUPzDxPchAO1PaEDKHtgPWcYQExLqR76Fe3kfEL
         0jtY1Plgpvoxe3hnmwXK78hfSJECrBHzJlwGYdaMqnXTLeTevEEaPBIDlOQCMBBC43Ii
         9l58RKIVVnoKenMZMeTGzDobywQ5mVBr1kJGB4BMpEt8YZEg+02IZQPt6cC/AgGzq62z
         HkfHFoz3vcYOLrVKmFhYGOi7aPnV2nrgj2YAKs1WUlzpPfjwrK4GtZVEv5jBykSAiP/2
         C2SBBgEikV/yYSbYgXaTrKtqF4mRrP9e5KuSGcDphsmzDrI+QHYFSPw49C27yngWavo8
         p5ew==
X-Forwarded-Encrypted: i=1; AJvYcCUGzcDOfrae83xJKDnwwZ9wu7Sdc/yrK2M7BoeMBwrk7sjwFHO+r+RN9iTXRbJjDzrS++anUWLHICVQ1I9eHx8P@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb7h/FKUvKM1o4o7xqKhwHB378t+aZMUuJYERSrBOhQcGBbdha
	Q1amdpIJceQZYwtT1GS59QcEKvHx8k70MAiFUikpFNNf77z5Z7fF/Hqrza5yUDnJHWX2/R3ecm9
	Dpg==
X-Google-Smtp-Source: AGHT+IE0+PBeuwxpnzTELFvbH/TuHAsee1m+fOwEkUQNielCR8eFWLWwsp0ClZTyWE2gxhBLCgqSGXk/TAw=
X-Received: from pffk11.prod.google.com ([2002:aa7:88cb:0:b0:72b:2f6b:c0a3])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:170a:b0:725:d64c:f113
 with SMTP id d2e1a72fcca58-72d21f18064mr14061211b3a.3.1736486066382; Thu, 09
 Jan 2025 21:14:26 -0800 (PST)
Date: Thu,  9 Jan 2025 21:11:41 -0800
In-Reply-To: <20250110051346.1507178-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250110051346.1507178-1-ctshao@google.com>
X-Mailer: git-send-email 2.47.1.688.g23fc6f90ad-goog
Message-ID: <20250110051346.1507178-2-ctshao@google.com>
Subject: [PATCH v1 1/4] perf lock: Add bpf maps for owner stack tracing
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

