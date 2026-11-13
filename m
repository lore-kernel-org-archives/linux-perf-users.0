Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590296;
	b=EUmA1Pnnjav4+qkjbEtcQ4yJvDXWA4onjZphKE1y09UXZAqBTLlq6b+VIsCsMRMlwOBS
	 lAancG2ThqVMjdgkJArtE1Oay0XjglzvQ+0R89g/j/oeGQYBZIgNYeoZxHlDM5hcilCFh
	 K2dkkkBcDnkb9wviNDw2+lsda4X8SXPbNULkJx3xxyY++oHrTmuJ8JLikYANCY4xNqj91
	 7g0EmfJvEY0D6wlaoTlsT769CowOvC4rjH1MeVF3aOIsya2S7dAK98ogdvFiJ3PpQOi4e
	 BhlvFZfi1G3+ygr5c1g9TnNJdiT5BmvDUzUMW+bKQIsrLzVsRL9UdS1d/OUNA+KwA4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590296;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=FqXrkekpazBGo74ROnhtZH/D/ijqIvj3BVMdkvQVaV4=;
	b=YxOTW78ZdYycZc67nDxbYSiC2sHgKIfL6FV+83ClG0fX7kXwy0rFiGQj7TLAgg7r2EHD
	 z5dKGRyDsSoTnfutlP4viPnAAsunUPpbPSBhGz4I7i/pJLUX+ghmwyFhTr1Gl5qoGOYbz
	 8HDV0Q/b2v66/wl3wguiRgZTE3K9Lu+/i2FwCCldVXGkBSAjs8Oh/d9EJh9tPGaN3teEd
	 DpwsIPsRkrgmCENWgYIinUcusOAZaaNl5g9fKD8LDApppciejHpD+aMVLvCUTN2CRF8P/
	 InSIbUrY1vHt2ssTIPXR1flp1Scyddpfqzx8858W0plj42NpUjQYB5jcf8/oHRPzUIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UMyk5pVl;
	arc=none smtp.remote-ip=209.85.160.69
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A990607B59A
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A990607B59A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UMyk5pVl
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-46dade0d7cdso1145292fac.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 09:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794590294; x=1795195094; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FqXrkekpazBGo74ROnhtZH/D/ijqIvj3BVMdkvQVaV4=;
        b=UMyk5pVlrfLZcmWajc9eoQ5rqc8ncqPc1DnN4iLD5fs01dI25x1QkSlq9L5TCL1Uur
         PEYxbFUv/iBEXKfkOWnpnShY52WmxMChZzHyev2tON/wlCgpQ17aPPB9GPF6dlKg29ol
         QdW7/tnSNek87lrNfrOyoFQaqGav+K7EMCr7Yx5xrAPsbRalZrrI/JQRYdTqWqq1gD3x
         sgSrfEgHa+MTbtaw+8XkszlHkXcyyQ4jJ6U/yjnLy8OkujERIvTJJzd3JhvG/fM4MGGL
         kT5fhFALvoyj1TtlhV8nIb731cU4s7K8iQLo8aIza0oiJ3KJ30OtTYps0biT2KvmzkKc
         9IGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590294; x=1795195094;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FqXrkekpazBGo74ROnhtZH/D/ijqIvj3BVMdkvQVaV4=;
        b=vR1xU3RrtYYW3A49VRhRh4K1KGwVpC8ibXioYxGpY9TxXSTBti8Jw8lEyG+vU64csZ
         K3xCW9/K1EDAZiBHKhV+y18iesc2yeaDox2r0n5jcTUXk3r6YKamxT8MKdHIsrohRfv+
         SlUFVeSzT/B0AG1J7YLZG4vk43OFP4WpQIxUfYJsK0jfiqCMYgQseXnVY29eWDhef1H3
         lA/mFXNk96vYxGeT24OKi0lZOs1B+72e6o9teSZw4wRcKYpKONnl7xMVYrVjHL6nf9B3
         XXvqfuUFh2KWHWyLfMzJd4QYrHvvJQrMxIJS4mYtASVqxvyHJS6sT6Ra/FBykUQslvlo
         Itdw==
X-Forwarded-Encrypted: i=1; AL+hErEySmSvFQP81KenkI4GftKaxZq+AeAG/7a3uiXl2YmGsS5bMwv3XovtE81+L97vgypSglta4x3tQGuo8Epbfd6i@vger.kernel.org
X-Gm-Message-State: APuU4Z+td47PRnYM3QwKbGtUmFr0rCMOJ25NGQ3dEoi1ZgEJP9GzYuty
	AI4otQsqRRbUFV0npDVXckWs8HmNvctzDTo+smQsPSAtG05J0l7A53td+Y6xs0yCGNGG7U0baId
	r+ctr/6JkAQ==
X-Received: from ioeu21.prod.google.com ([2002:a05:6602:2415:b0:9c7:5b22:eaaa])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:e88:b0:564:3fe1:2f95
 with SMTP id 5614622812f47-56e66063859mr2434950b6e.56.1794590294004; Fri, 13
 Nov 2026 09:18:14 -0800 (PST)
Date: Fri, 13 Nov 2026 09:17:18 -0800
In-Reply-To: <20261113171734.2188066-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110220803.2503416-1-irogers@google.com> <20261113171734.2188066-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113171734.2188066-8-irogers@google.com>
Subject: [PATCH v4 07/23] perf rwsem: Add down_read_trylock() and down_write_trylock()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, haghdoost@uber.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
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
 tools/perf/util/rwsem.h | 11 +++++++++++
 3 files changed, 34 insertions(+)

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
index 1d15c0e3732b..9548a3b44f16 100644
--- a/tools/perf/util/rwsem.c
+++ b/tools/perf/util/rwsem.c
@@ -36,6 +36,16 @@ int down_read(struct rw_semaphore *sem)
 #endif
 }
 
+bool down_read_trylock(struct rw_semaphore *sem)
+	NO_THREAD_SAFETY_ANALYSIS
+{
+#if RWS_ERRORCHECK
+	return mutex_trylock(&sem->mtx);
+#else
+	return pthread_rwlock_tryrdlock(&sem->lock) == 0;
+#endif
+}
+
 int up_read(struct rw_semaphore *sem)
 	NO_THREAD_SAFETY_ANALYSIS
 {
@@ -58,6 +68,16 @@ int down_write(struct rw_semaphore *sem)
 #endif
 }
 
+bool down_write_trylock(struct rw_semaphore *sem)
+	NO_THREAD_SAFETY_ANALYSIS
+{
+#if RWS_ERRORCHECK
+	return mutex_trylock(&sem->mtx);
+#else
+	return pthread_rwlock_trywrlock(&sem->lock) == 0;
+#endif
+}
+
 int up_write(struct rw_semaphore *sem)
 	NO_THREAD_SAFETY_ANALYSIS
 {
diff --git a/tools/perf/util/rwsem.h b/tools/perf/util/rwsem.h
index b102d8143181..53c45990d9c9 100644
--- a/tools/perf/util/rwsem.h
+++ b/tools/perf/util/rwsem.h
@@ -22,9 +22,20 @@ int init_rwsem(struct rw_semaphore *sem);
 int exit_rwsem(struct rw_semaphore *sem);
 
 int down_read(struct rw_semaphore *sem) SHARED_LOCK_FUNCTION(sem);
+/*
+ * Tries to acquire a shared read lock without blocking. Per POSIX
+ * pthread_rwlock_tryrdlock(), succeeds when no writer holds or blocks on @sem
+ * (including when the calling thread already holds a read lock on @sem).
+ */
+bool down_read_trylock(struct rw_semaphore *sem) SHARED_TRYLOCK_FUNCTION(true, sem);
 int up_read(struct rw_semaphore *sem) UNLOCK_FUNCTION(sem);
 
 int down_write(struct rw_semaphore *sem) EXCLUSIVE_LOCK_FUNCTION(sem);
+/*
+ * Tries to acquire an exclusive write lock without blocking. Returns false if
+ * any thread (including the calling thread) holds a read or write lock on @sem.
+ */
+bool down_write_trylock(struct rw_semaphore *sem) EXCLUSIVE_TRYLOCK_FUNCTION(true, sem);
 int up_write(struct rw_semaphore *sem) UNLOCK_FUNCTION(sem);
 
 #endif /* _PERF_RWSEM_H */
-- 
2.56.1.703.gf848ed807c-goog

