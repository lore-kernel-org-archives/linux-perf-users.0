Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792782371;
	b=piA1uiuo+Oee0+EVxEZPxlTY6tpAsqJ/Wss0tto4/r0pO2lOsgrtGkqx7T1a8OPhv/9B
	 a8t/8ssqJlZc+DgTopWECCYQP1ogIDGpONFWg9fDlpvpWgw34KkrXBzXaCeAzDIZeVrBM
	 Hq2j+giWEuxHxjC6m6GvW/i8ov0qH5YC/LTcqIo1JCpFEi3GiUTjXz6rPRfhwg7Oek6wb
	 hrL4DlSIfMRCWGVYcQLK3lYbfM8PPXag5h0ikB9ptKBotjzG9ps05ISTBTVDCE9ppm6n7
	 kWurf9Ofgr7Lkj0HWm2ZuyCllAlg7rlKmXGe0eC2kX9oDX0TUtp3vcfWLy++40Klxpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792782371;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=jncnN8hNB149YV/7QR6pbWspMiNEL/g00PLfD5StrJE=;
	b=MIo0h3bKNmQqDQcCOa84DCWCCIpOxSSbgK1RMoTA61bwVIPJTwNF22yQ4oyf0BjE98BI
	 06x665oxVK4g96BEMWV0i+hBalpVq8ulc9y+8+6Euwl2oBoqolWqU0bZIgszmmocS/wNp
	 x60Climbwzf7ICJH58JkHnqkF5UL8buFRmpzC0CTfggeEYKgSx6EHMxwtaC2x7heWs6K0
	 TtDcN4c23axHqxAvL+E8Xd3uD+fMkTQLQZFUblyEqmmTfbxgkPgPSjktY4tVSTiMDVbw4
	 EFhlVvB+5abKuJa5BSx5tIPng+2vFkgOnLpw+IvyLuWGQQD1vnSRmxUtdOGuE067Wew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Wbx66lod;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9AA606A325
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 19:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D9AA606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Wbx66lod
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso2039487eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 12:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792782370; x=1793387170; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jncnN8hNB149YV/7QR6pbWspMiNEL/g00PLfD5StrJE=;
        b=Wbx66lodXz//uoQzGumIuDsdaKzKeTZj2vxASniPeWt1xrX0mU5N3QQEqMKZD8a7SV
         TYLTGpQRxn5xl3LOPmQ3Q3pkJw5k3wjK4FVUjiP7aBWSAouEeFOS0SOQIv6YvHaskA05
         Rybst7Z3U+4/kIOzZKjoBGoYMqaRCMYrIdbqRgrPXg5repVmXNOVAKk71r00QWUJTaAP
         UqL9+WQq/Rlge82XdYmoQgSPVjjeSXCqnw7XQqcPMVUcZA4xJy+NbL5LuxqH52ERliNc
         ikIuWZTSTbuwNkhG2QbS1AQPXZDzzYm4Ig9/URBwwKGBE3bQE4xi0S3SFai3YAsErLaU
         ymHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792782370; x=1793387170;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jncnN8hNB149YV/7QR6pbWspMiNEL/g00PLfD5StrJE=;
        b=TSvdzu/9GOO58jpC1FU+6ijkRy4zeRdkMXmV0TeWDqEJoLCZ4FtjtyIsd96GzfSj63
         RQGxK3hA381vMD6LSoGi4YB0eMoliTvG/jZBCT/tsv2yIMZZIYMp4ldn/51vVMVv8Upp
         L4Vcjin6c+RFvhAvMEuurTO0fvVpF+GouRxr47StZjoz9tsmdABIBaWqDaN/HR3z/QU2
         +T6dXSSvkF/eufDPnzh3bHdc2PiFXDQduReQjhDAWQyw1HDGBsW4el1zwm85xnA7BBew
         7ZeXqPvphlEsjcgaMrWY7hTossXtkppWSRdU4A4ELc8sTpnPCFFwHhuwftSo3FXjDVzI
         TOUQ==
X-Forwarded-Encrypted: i=1; AKwUvBxyCCB3khEecLePhUKlfwg3lcQh8Pv562nvfXHNEgp1nu/W7VKhyAlpBlA3oXeLNET0jcBtiVTGxawETlyuJxJX@vger.kernel.org
X-Gm-Message-State: AFq9FYLljHPw0mAmrwZtpely7lmwd0QY9UhWTDlYUStx63klLo6RBxaf
	7S51MFP1jYlNubqs4F38PH+yX5aQXRM7b662fqQk5v8LP+G25dAK5qp1LO1UrY6bktotqbLfn7Z
	d40lNbxDQZw==
X-Received: from dlbut14.prod.google.com ([2002:a05:7022:7e0e:b0:197:4f80:9b9a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4388:b0:185:fd0c:4585
 with SMTP id a92af1059eb24-195c7b7c1cemr5635614c88.33.1792782369901; Fri, 23
 Oct 2026 12:06:09 -0700 (PDT)
Date: Fri, 23 Oct 2026 12:05:51 -0700
In-Reply-To: <20261023190558.3050796-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022203003.1779152-1-irogers@google.com> <20261023190558.3050796-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261023190558.3050796-5-irogers@google.com>
Subject: [PATCH v7 04/11] perf lock contention: Extend get_lock_owner() for
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

