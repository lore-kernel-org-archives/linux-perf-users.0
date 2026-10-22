Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792701023;
	b=lURytfn9clokY02E0SInHVyueJGqH3TGtpIbU5x3+y2dJZ/Eq2PvBno6nzoZiPP290pj
	 yyhNF9CYobUULD49o91O489hZhrg6YV8/9BoceR9khFwMQ7Ri7409PGQ8Fho8kcMrjIxI
	 NhHSK341/MMi+9XDV+K3HB4HVsJ6tutBWG3ajRcxkiRc1u/G8KdCQzuFsxV1KDmIpJRyI
	 ycra2SJmOqpDH+KJCnqibdzIVOuqdx9Zqtd/V/w5+Isqr9IccL1Bf1nMFxiTv4K0yj4w0
	 dLzQYt4Z6LI88HIgE7QOWaQvz20SFY7L0MMTZVshnwQOQhmem5ma0rxIrLKWd54gnKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792701023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=jncnN8hNB149YV/7QR6pbWspMiNEL/g00PLfD5StrJE=;
	b=in2B3QZucagELeG0BgK36D/E+lrh2ewSf1+WkcWmWuO9d/oFZadlWT7Q6vhJ4NbO9cps
	 DXpdDLsneg7637nfHR6YqGdFyFfYgMWtPY6Z32vXRzrDj7ZVSvPHC+KU2Jw9pNs5Ws+o9
	 qYpxLHVpLhAG2VvHncUN+zy2idrP1M2mQDBqxEEuYv4ZVYoptRrVdxoQc5x8uzUzQnV0k
	 ig4aHsStuPRZpyipYaR2hTvxFYvWy7Dwr6pQfhpkv0sucU9bIZbQZfJhZsSWDcmE5Y+vW
	 Xhm/2GOHe1wbBesp/j0BX9Jf14S31y+SBvexA6eFo4UhMy8Tv662nOhe7mfPv6O4Dfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=al2a4dDN;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE0A606A325
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABE0A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=al2a4dDN
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-155a75f91e1so1210231c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 13:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792701022; x=1793305822; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jncnN8hNB149YV/7QR6pbWspMiNEL/g00PLfD5StrJE=;
        b=al2a4dDNtnNQKDJTNaWoOW/tX5Wu00kFM/0d+1ZnH73GlJT+0lOGpoW6Y5NJP76/B3
         FJQ3w+agnI1YkkgU8a13Nc63DImxppMQLZvbFy/rcGLeUK9PSRDdn1X5WhhCjVu8Za1P
         mu4cdknjbAiqmnwrGEx0uBflO3BxeqE2A28g3EkVToNWYOjhWmUUKJ1vtp+8SPtisA6h
         2qZP8F3rLVhZ8iyN3H7OMRgLtWbMayLzrevPhLAheL6MO0Zf+Ta+bV2ly8MTRUkv+t9l
         aLcPxtN3IZ9l2XZKqiTKhQGM7GNXwJbo9qNt/251YGAKzr9YOXCrTMoeItEA71GYVZAp
         Q5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792701022; x=1793305822;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jncnN8hNB149YV/7QR6pbWspMiNEL/g00PLfD5StrJE=;
        b=GY7ouXD+MCmXKDU0YtqxXgMQmCtF1xjjG263lK+K39ye696HBfoKwIWlWuXvjo4Rdf
         3KLzNsapzbFo/+t7nMRAwH88OFkz9vwXrqGV5mNb0j5fMXLoywzgVgTI0En9GquRaov8
         mOwb9kTzifUCxK0CSQoB+Rdr8P1Sc27rcHsi4LdRtW3cKpjMshD7ulN4h/NrsitwpV2s
         b/ZmEtpOe8l4bS3mixsdslkKEWHH8AbJuIFTsCMYKy7uAm8ZJexHkcog35XWCc/B/MWm
         lalnu9oHACUltHusXPTbzZ+xlpFiQDcWf4qKYRQp0jxjq+z5qEgBW4GMU0gxx9Cu47lk
         A4aQ==
X-Forwarded-Encrypted: i=1; AKwUvBzOip2EYVh01xF6i6sQV2BiHiDTXYQXxJyBAVw4ss60fNaEK98YRQ0fhxc6YilvYXVhFy3SRY5BNTqeATlyrJSL@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/wTPeoUbydHRyd7N+vhd32X6N6s0GUpNf3xEzNxSNQ8km8Na1
	18cR1B2n9Eee14z4DQAMnKTnOpdcJNlrAbRDNMmo8ACATWv2hhznujP4c9zR49c5xI1gd73YV2B
	NWBHUUyCN2Q==
X-Received: from dlea4-n2.prod.google.com ([2002:a05:701b:4204:20b0:189:5eec:837b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4081:b0:195:8fa1:b447
 with SMTP id a92af1059eb24-1958fa1b4c4mr519494c88.12.1792701021167; Thu, 22
 Oct 2026 13:30:21 -0700 (PDT)
Date: Thu, 22 Oct 2026 13:29:56 -0700
In-Reply-To: <20261022203003.1779152-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261020205859.1080743-1-irogers@google.com> <20261022203003.1779152-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261022203003.1779152-5-irogers@google.com>
Subject: [PATCH v6 04/11] perf lock contention: Extend get_lock_owner() for
 rt_mutex and mutex handoff
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ddhariwal@google.com, eranian@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Extend get_lock_owner() in tools/perf/util/bpf_skel/lock_data.h to:
- Support rt_mutex locks (LCB_F_RT) and CONFIG_PREEMPT_RT mutexes via
  struct rt_mutex_base and struct rt_mutex___old, masking out the low
  waiter bit (0x1UL).
- Return NULL when a mutex has MUTEX_FLAG_HANDOFF (0x4UL) set on
  owner.counter and is in the middle of being handed off rather than
  actively held.

Also add rw_semaphore.count and struct rt_mutex_base to the fallback
tools/perf/util/bpf_skel/vmlinux/vmlinux.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_skel/lock_data.h       | 62 ++++++++++++++++++----
 tools/perf/util/bpf_skel/vmlinux/vmlinux.h |  5 ++
 2 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
index 91d464ac18bd..43d8f5030bc1 100644
--- a/tools/perf/util/bpf_skel/lock_data.h
+++ b/tools/perf/util/bpf_skel/lock_data.h
@@ -104,11 +104,24 @@ extern struct rq runqueues __ksym __weak;
 # define __has_builtin(x) 0
 #endif
 
+struct mutex___non_rt {
+	atomic_long_t owner;
+} __attribute__((preserve_access_index));
+
+struct rt_mutex_base___new {
+	struct task_struct *owner;
+} __attribute__((preserve_access_index));
+
+struct rt_mutex___old {
+	struct task_struct *owner;
+} __attribute__((preserve_access_index));
+
 struct rw_semaphore___old {
 	struct task_struct *owner;
 } __attribute__((preserve_access_index));
 
 struct rw_semaphore___new {
+	atomic_long_t count;
 	atomic_long_t owner;
 } __attribute__((preserve_access_index));
 
@@ -146,9 +159,25 @@ static __always_inline struct task_struct *get_lock_owner(__u64 lock, __u32 flag
 	__u64 owner = 0;
 
 	if (flags & LCB_F_MUTEX) {
-		struct mutex *mutex = (void *)lock;
-
-		owner = BPF_CORE_READ(mutex, owner.counter);
+		struct mutex___non_rt *mutex = (void *)lock;
+
+		if (bpf_core_field_exists(mutex->owner.counter)) {
+			owner = BPF_CORE_READ(mutex, owner.counter);
+			if (owner & 0x4UL)
+				return NULL;
+		} else if (bpf_core_type_exists(struct rt_mutex_base___new)) {
+			struct rt_mutex_base___new *rtm = (void *)lock;
+
+			owner = (__u64)BPF_CORE_READ(rtm, owner);
+			return (void *)(owner & ~1UL);
+		} else {
+			struct rt_mutex___old *rtm = (void *)lock;
+
+			if (bpf_core_field_exists(rtm->owner)) {
+				owner = (__u64)BPF_CORE_READ(rtm, owner);
+				return (void *)(owner & ~1UL);
+			}
+		}
 	} else if (flags == LCB_F_READ || flags == LCB_F_WRITE) {
 	/*
 	 * Support for the BPF_TYPE_MATCHES argument to the
@@ -158,20 +187,35 @@ static __always_inline struct task_struct *get_lock_owner(__u64 lock, __u32 flag
 	 */
 #if __has_builtin(__builtin_preserve_type_info) && __clang_major__ >= 15
 		if (bpf_core_type_matches(struct rw_semaphore___old)) {
-			struct rw_semaphore___old *rwsem = (void *)lock;
+			struct rw_semaphore___old *old = (void *)lock;
 
-			owner = (unsigned long)BPF_CORE_READ(rwsem, owner);
+			owner = (unsigned long)BPF_CORE_READ(old, owner);
 		} else if (bpf_core_type_matches(struct rw_semaphore___new)) {
-			struct rw_semaphore___new *rwsem = (void *)lock;
+			struct rw_semaphore___new *new = (void *)lock;
 
-			owner = BPF_CORE_READ(rwsem, owner.counter);
+			owner = BPF_CORE_READ(new, owner.counter);
 		}
 #else
 		/* assume new struct */
-		struct rw_semaphore *rwsem = (void *)lock;
+		struct rw_semaphore___new *new = (void *)lock;
 
-		owner = BPF_CORE_READ(rwsem, owner.counter);
+		if (bpf_core_field_exists(new->owner.counter))
+			owner = BPF_CORE_READ(new, owner.counter);
 #endif
+	} else if (flags == LCB_F_RT) {
+		if (bpf_core_type_exists(struct rt_mutex_base___new)) {
+			struct rt_mutex_base___new *rtm = (void *)lock;
+
+			owner = (__u64)BPF_CORE_READ(rtm, owner);
+			return (void *)(owner & ~1UL);
+		} else {
+			struct rt_mutex___old *rtm = (void *)lock;
+
+			if (bpf_core_field_exists(rtm->owner)) {
+				owner = (__u64)BPF_CORE_READ(rtm, owner);
+				return (void *)(owner & ~1UL);
+			}
+		}
 	}
 
 	if (!owner)
diff --git a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
index 94e42b022ab1..b75ddc6846bb 100644
--- a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
+++ b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
@@ -76,6 +76,7 @@ struct signal_struct {
 } __attribute__((preserve_access_index));
 
 struct rw_semaphore {
+	atomic_long_t count;
 	atomic_long_t owner;
 } __attribute__((preserve_access_index));
 
@@ -83,6 +84,10 @@ struct mutex {
 	atomic_long_t owner;
 } __attribute__((preserve_access_index));
 
+struct rt_mutex_base {
+	struct task_struct *owner;
+} __attribute__((preserve_access_index));
+
 struct kernfs_node {
 	u64 id;
 } __attribute__((preserve_access_index));
-- 
2.56.0.307.g5fe7bd680c-goog

