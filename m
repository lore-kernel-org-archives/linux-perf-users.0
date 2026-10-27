Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793142949;
	b=1WjW4rFjn3h1Urmp0ATnqtzKqv6OJvTMsxOMk3xbEnkempuF0grn1YacKk3kjEHpE6T7
	 mc3rEraM1n2wIfnqkNnQn+VskfjLllZYZQ3wOomvLk60N678MRjEwVMd7L/cm+ii0ATb9
	 MODvecq6ghuYcl3UA2hdfXlLtDKcEAP7v5euA4zVbqwJpM3dJ0Gd21Jvp3Yit9zmLbQIQ
	 OcrnbjT+NdGHLgvs3svF7elx4x6NiXiyyE39ZQWJnKpdsTCKb+LUJWhtDBY7SYERH4Ql6
	 /QbNQLItKGAi0uK49G2GygHbSKRlWxNdtqHlaRBePqxgG7W0qlmheg4SUMLJQQ67oQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142949;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=NkKLsyMxj9EW7cAPdC4Few1MpkVfWGCaxkYuBEFMHvs=;
	b=5oxWwt/UbHIHQyLjvqfZP/uRXWuSTUd8lH7r9Y/4mWQgXRVgy9HsfNtCOexcgo/ubxUT
	 snroZGFlusE/+firT3JFLzaX8Tc9C1Tau+0vyTm0GAqRVF5IBZJ4Sjl+vHLHYFSAt7S7w
	 vpdw3C9G8mEElOqeNUUECSzTganv1HWTZtHU0xjf38ChvHuHCqVvJFAWQOh/l2QmKCo0y
	 vORFXK5K2cZEErsQ/cswZaArNggAD2FPrC/hi8RdK3OQowWWEVITAvi3/3Q0Fck3u7Sti
	 qlctDlMBgyMi/T9pQcvLDjquxTfYln+w9Yxr+feWtXJ9zf5bgR5YnOROnFocYwVQ5Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XroHQIDt;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3C660A2613
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 23:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C3C660A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XroHQIDt
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36637676140so517039eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 16:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793142948; x=1793747748; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NkKLsyMxj9EW7cAPdC4Few1MpkVfWGCaxkYuBEFMHvs=;
        b=XroHQIDtmzOLdrNcuY8Ny446dwp+tG+PTosqrdE5GC3r2c8MeMFRA6TFW8rIgQMCZ2
         v/KYjl5k68PVCPKZxrW112QJJcrP2w92POYyQiJQtmUSDZ5mO7qDVH5l34Jao5nAoeHT
         Ju0nnNjuEmstPZ99bPoR+BDCaIQf0ex2Q89wjX87a67x4Cu5eOAemDXTFYZgonutMXt6
         49qdIKb3V3KxXXUII4N/SmzCOJsF1qWrHKTP3egTgZqj+cXViU+R2AeH3Grj8gEYggbH
         njnmFcNvwQvQE3E11OC3wir9RuddDyzLJ2Y9ZibinPhqIQ7FOB8iN6vxLwRRNddspVn5
         uHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793142948; x=1793747748;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NkKLsyMxj9EW7cAPdC4Few1MpkVfWGCaxkYuBEFMHvs=;
        b=KwRPrLLxv13LftHC8ty+Q/y6c7wbO95rlvrvuE+075pESU2sapPbZXuZukhdohIa2K
         zwarAYn4x74VrVDUZ9Fy9X5XSgJKSa6UIE9ag0B4bNgf3dkgeOG+Rm8XyxFSATfF5H+E
         A8w05eSoYOSQt/HYlSXqU+tTmQprtLNEQktlPHFEAlWYvUoXhPpUqhMhwywmBjYDYt1b
         BPl9VN19jz/kiy6WOnaVe1xgo0geRhKGt1S5c9ch8d0EXtXfQJEqVVykIRMLKg5Wgvje
         i86GTMuU70XTBJaepk65331NIIFJsH52yzLQL3U6MbdphSnchYkiBxFaQqHN29zfjepQ
         8BqQ==
X-Forwarded-Encrypted: i=1; AKwUvBwY49XiPv9I2bGu4v77atqAYb6fqpP4gfF6I8ScMnFdnSUONMcYbg19suaX5x5KrCBtLcbkHi4Vk8tyi9prFNeY@vger.kernel.org
X-Gm-Message-State: AFq9FYLuDTx2GKa2bCegy7NmsiATyHGH5BfVlZ1kFidkPvOXCu6zkz90
	zVIowpjKN7rh999T5A9iEZh/t3D3qS0Dmy7JkhnqyoZjvzEFJJuasRtshM5m69opIIIAtR5ekQB
	vhJkBFNY/gQ==
X-Received: from dyki4.prod.google.com ([2002:a05:7300:7c04:b0:364:225c:dfac])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:618b:20b0:360:e2e6:f849
 with SMTP id 5a478bee46e88-36a20138550mr1401763eec.28.1793142948028; Tue, 27
 Oct 2026 16:15:48 -0700 (PDT)
Date: Tue, 27 Oct 2026 16:15:06 -0700
In-Reply-To: <20261027231513.816148-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20260928075237.3055101-1-irogers@google.com> <20261027231513.816148-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261027231513.816148-13-irogers@google.com>
Subject: [PATCH v2 12/18] perf rwsem: Add down_read_trylock() and down_write_trylock()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, haghdoost@uber.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

On-demand memory shrinking (perf_session__shrink(), dsos__shrink(),
symbols__shrink()) can be triggered from OOM recovery inside allocation
wrappers while the current thread already holds a rw_semaphore (such as
symbols->lock, dsos->lock, or machines->lock). Non-blocking trylock
primitives are needed so shrinking paths can safely skip any locked
container without deadlocking.

Add non-blocking down_read_trylock() and down_write_trylock() wrappers
around pthread_rwlock_tryrdlock() / pthread_rwlock_trywrlock() and
pthread_mutex_trylock() along with SHARED_TRYLOCK_FUNCTION and
EXCLUSIVE_TRYLOCK_FUNCTION thread-safety annotations.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/mutex.h |  3 +++
 tools/perf/util/rwsem.c | 20 ++++++++++++++++++++
 tools/perf/util/rwsem.h |  2 ++
 3 files changed, 25 insertions(+)

diff --git a/tools/perf/util/mutex.h b/tools/perf/util/mutex.h
index 5de1065ea2b9..de7dd6d8326c 100644
--- a/tools/perf/util/mutex.h
+++ b/tools/perf/util/mutex.h
@@ -57,6 +57,8 @@
 /* Documents functions that try to acquire a lock, and return success or failure. */
 #define EXCLUSIVE_TRYLOCK_FUNCTION(...) \
 	__attribute__((exclusive_trylock_function(__VA_ARGS__)))
+#define SHARED_TRYLOCK_FUNCTION(...) \
+	__attribute__((shared_trylock_function(__VA_ARGS__)))
 
 /* Documents a function that expects a mutex to be held prior to entry. */
 #define EXCLUSIVE_LOCKS_REQUIRED(...) __attribute__((exclusive_locks_required(__VA_ARGS__)))
@@ -78,6 +80,7 @@
 #define SHARED_LOCK_FUNCTION(...)
 #define UNLOCK_FUNCTION(...)
 #define EXCLUSIVE_TRYLOCK_FUNCTION(...)
+#define SHARED_TRYLOCK_FUNCTION(...)
 #define EXCLUSIVE_LOCKS_REQUIRED(...)
 #define SHARED_LOCKS_REQUIRED(...)
 #define NO_THREAD_SAFETY_ANALYSIS
diff --git a/tools/perf/util/rwsem.c b/tools/perf/util/rwsem.c
index 9d26832398db..37fa08bae5e9 100644
--- a/tools/perf/util/rwsem.c
+++ b/tools/perf/util/rwsem.c
@@ -37,6 +37,16 @@ int down_read(struct rw_semaphore *sem)
 #endif
 }
 
+bool down_read_trylock(struct rw_semaphore *sem)
+	NO_THREAD_SAFETY_ANALYSIS
+{
+#if RWS_ERRORCHECK
+	return mutex_trylock(&sem->mtx);
+#else
+	return perf_singlethreaded ? true : pthread_rwlock_tryrdlock(&sem->lock) == 0;
+#endif
+}
+
 int up_read(struct rw_semaphore *sem)
 	NO_THREAD_SAFETY_ANALYSIS
 {
@@ -59,6 +69,16 @@ int down_write(struct rw_semaphore *sem)
 #endif
 }
 
+bool down_write_trylock(struct rw_semaphore *sem)
+	NO_THREAD_SAFETY_ANALYSIS
+{
+#if RWS_ERRORCHECK
+	return mutex_trylock(&sem->mtx);
+#else
+	return perf_singlethreaded ? true : pthread_rwlock_trywrlock(&sem->lock) == 0;
+#endif
+}
+
 int up_write(struct rw_semaphore *sem)
 	NO_THREAD_SAFETY_ANALYSIS
 {
diff --git a/tools/perf/util/rwsem.h b/tools/perf/util/rwsem.h
index b102d8143181..782016c3e01f 100644
--- a/tools/perf/util/rwsem.h
+++ b/tools/perf/util/rwsem.h
@@ -22,9 +22,11 @@ int init_rwsem(struct rw_semaphore *sem);
 int exit_rwsem(struct rw_semaphore *sem);
 
 int down_read(struct rw_semaphore *sem) SHARED_LOCK_FUNCTION(sem);
+bool down_read_trylock(struct rw_semaphore *sem) SHARED_TRYLOCK_FUNCTION(true, sem);
 int up_read(struct rw_semaphore *sem) UNLOCK_FUNCTION(sem);
 
 int down_write(struct rw_semaphore *sem) EXCLUSIVE_LOCK_FUNCTION(sem);
+bool down_write_trylock(struct rw_semaphore *sem) EXCLUSIVE_TRYLOCK_FUNCTION(true, sem);
 int up_write(struct rw_semaphore *sem) UNLOCK_FUNCTION(sem);
 
 #endif /* _PERF_RWSEM_H */
-- 
2.56.0.313.g2479322e68-goog

