Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D122C026C;
	Fri, 16 Oct 2026 00:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792109981; cv=none; b=WgIelgtBLp5y/BnM24+ZxU134O4s0yDOSfDGhwlMDAaHhfIQXWX18d8+n+qQvcSjieUQCJ/QLoohFXn59wLX1HRlMuXislKnJghFfHv7+7tdPsjjmbtYLWiB1CLRrBOn3Eq6dH++LNEdx1+YeqcMCRoYn56cWYNPiJ2L4GOpbLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792109981; c=relaxed/simple;
	bh=mOgM/f/qnDsKW6XdMSTXIRaN6C4wdEUudWVcYzIPz7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pu5CLU7D25b0v+FycuxRVP4t59Tz6iekjP0WEmM7/PZZdQCDZBn57+YHbyY0G4YrlYCIWmaxwmxbzkzUtZGqXubjnmDrHvXa9o5OfMgVNUuuY7vRcbTekjGyJTkxTHwVXEr0ptBZOEIhe1lCsVjFg9mChtceY7f0kYcf78vu2S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAflB4ns; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAflB4ns"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6D21F000C4;
	Fri, 16 Oct 2026 00:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792109979;
	bh=iVUpMp1ZNqzgMx/GKdnUJ/dt5nzO2iLIlc6Czzamges=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XAflB4nsRufx5DY/GMFSmmKVLbNt4cPIhvMFrh/bxPT70uz80HimlbJm62fnpj2tx
	 DTfgYNJUWxqUp3+GqoFli7zrkgdyTmnnD2VV5MaVV+obEG03ogTSpptzlu5oxZrEUz
	 bmdLgWwKJyhTl1RDYq5En5EopIEWLeWPMhCTZ0uZ0+F6FlD9dzJKONYseX1EtAqylT
	 /fFsSg2epXsoO0qCk3CAVhJ8UNbp/lH3GsWQuy693wsvAx8HAEc0aWn+UTeUL38jnU
	 XEGzzlKTt/Geoz9aKVAVRrqoUW7q9Y05QHnmsynbOz43g3Ej2tLL8PItz9Fpnu8oeU
	 VC9Hw/e8V9wUw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v3 18/19] perf mutex: Add a robust, process-shared mutex initializer
Date: Thu, 15 Oct 2026 21:18:42 -0300
Message-ID: <20261016001843.71978-19-acme@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016001843.71978-1-acme@kernel.org>
References: <20261016001843.71978-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

A mutex held by a process that can die before unlocking it, like the
tests forked by 'perf test' that will take turns using the per user
budget set in kernel.perf_event_mlock_kb, has to be taken over by the
next locker instead of staying locked forever.

Robust mutexes, on top of the kernel's robust futexes, do that: when an
owner dies while holding it the kernel marks the futex word owner-died
and the next pthread_mutex_lock() returns EOWNERDEAD, then mutex_lock()
makes it consistent and takes it over; mutex_trylock() and cond_wait()
come back with EOWNERDEAD too, so they take it over the same way, with
mutex_trylock() giving the mutex back when it can't be taken over: it
is held all the same, and a failed trylock must not leak it.

Add mutex_init_pshared_robust(), returning false when robust mutexes
aren't available: from libcs without the API, gated by a feature check,
to musl and glibc refusing them at runtime, when get_robust_list(2) or
set_robust_list(2) aren't usable.  glibc only sets a flag in
pthread_mutexattr_setrobust(), refusing the mutex itself in
pthread_mutex_init() with ENOTSUP instead, other errors from it still
being reported.  Robust mutexes being unavailable isn't an error, just a
debug message for whoever then falls back.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature                  |   1 +
 tools/build/feature/Makefile                  |   4 +
 tools/build/feature/test-all.c                |   5 +
 .../build/feature/test-pthread-mutex-robust.c |  18 ++++
 tools/perf/Makefile.config                    |   4 +
 tools/perf/util/mutex.c                       | 101 +++++++++++++++---
 tools/perf/util/mutex.h                       |   6 ++
 7 files changed, 125 insertions(+), 14 deletions(-)
 create mode 100644 tools/build/feature/test-pthread-mutex-robust.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index dbef5b6c4e43c857..4d37d11f674c5bd5 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -85,6 +85,7 @@ FEATURE_TESTS_BASIC :=                  \
         libcpupower                     \
         pthread-attr-setaffinity-np     \
         pthread-barrier     		\
+        pthread-mutex-robust		\
         reallocarray                    \
         stackprotector-all              \
         timerfd                         \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 62f9cbf3dee97936..10340a5372242e05 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -41,6 +41,7 @@ FILES=                                          \
          $(foreach arch,$(LIBUNWIND_ARCHS),test-libunwind-$(arch).bin test-libunwind-debug-frame-$(arch).bin) \
          test-pthread-attr-setaffinity-np.bin   \
          test-pthread-barrier.bin		\
+         test-pthread-mutex-robust.bin		\
          test-stackprotector-all.bin            \
          test-timerfd.bin                       \
          test-babeltrace2-ctf-writer.bin        \
@@ -128,6 +129,9 @@ $(OUTPUT)test-pthread-attr-setaffinity-np.bin:
 $(OUTPUT)test-pthread-barrier.bin:
 	$(BUILD) -lpthread
 
+$(OUTPUT)test-pthread-mutex-robust.bin:
+	$(BUILD) -lpthread
+
 $(OUTPUT)test-stackprotector-all.bin:
 	$(BUILD) -fstack-protector-all
 
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 0ee16eccd9e05788..4a6890290f7462a7 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -90,6 +90,10 @@
 # include "test-pthread-barrier.c"
 #undef main
 
+#define main main_test_pthread_mutex_robust
+# include "test-pthread-mutex-robust.c"
+#undef main
+
 #define main main_test_scandirat
 # include "test-scandirat.c"
 #undef main
@@ -167,6 +171,7 @@ int main(int argc, char *argv[])
 	main_test_zlib();
 	main_test_pthread_attr_setaffinity_np();
 	main_test_pthread_barrier();
+	main_test_pthread_mutex_robust();
 	main_test_lzma();
 	main_test_bpf();
 	main_test_scandirat();
diff --git a/tools/build/feature/test-pthread-mutex-robust.c b/tools/build/feature/test-pthread-mutex-robust.c
new file mode 100644
index 0000000000000000..d8409074713d172b
--- /dev/null
+++ b/tools/build/feature/test-pthread-mutex-robust.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <pthread.h>
+
+int main(void)
+{
+	pthread_mutexattr_t attr;
+	pthread_mutex_t mtx;
+
+	pthread_mutexattr_init(&attr);
+	pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
+	pthread_mutexattr_setrobust(&attr, PTHREAD_MUTEX_ROBUST);
+	pthread_mutex_init(&mtx, &attr);
+	pthread_mutex_consistent(&mtx);
+	pthread_mutex_destroy(&mtx);
+	pthread_mutexattr_destroy(&attr);
+
+	return 0;
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index cafc7be79643b26c..b4764f69f47f4d8c 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -417,6 +417,10 @@ ifeq ($(feature-pthread-barrier), 1)
   CFLAGS += -DHAVE_PTHREAD_BARRIER
 endif
 
+ifeq ($(feature-pthread-mutex-robust), 1)
+  CFLAGS += -DHAVE_PTHREAD_MUTEX_ROBUST
+endif
+
 ifndef NO_BIONIC
   $(call feature_check,bionic)
   ifeq ($(feature-bionic), 1)
diff --git a/tools/perf/util/mutex.c b/tools/perf/util/mutex.c
index 7aa1f3f55a7d4089..df3b7cce3d5a6a35 100644
--- a/tools/perf/util/mutex.c
+++ b/tools/perf/util/mutex.c
@@ -17,37 +17,106 @@ static void check_err(const char *fn, int err)
 
 #define CHECK_ERR(err) check_err(__func__, err)
 
-static void __mutex_init(struct mutex *mtx, bool pshared, bool recursive)
+#ifdef HAVE_PTHREAD_MUTEX_ROBUST
+/*
+ * A robust mutex whose owner died while holding it comes back as EOWNERDEAD,
+ * with the caller holding it: make it consistent, which takes it over; failing
+ * that, a give_up caller unlocks it, leaving it ENOTRECOVERABLE, not leaked.
+ */
+static int mutex_take_over(struct mutex *mtx, int err, bool give_up)
+{
+	if (err != EOWNERDEAD)
+		return err;
+
+	pr_debug("mutex: taking over one left by a dead owner\n");
+	err = pthread_mutex_consistent(&mtx->lock);
+	if (err && give_up)
+		CHECK_ERR(pthread_mutex_unlock(&mtx->lock));
+
+	return err;
+}
+#else
+#define mutex_take_over(mtx, err, give_up) ((void)(mtx), (void)(give_up), (err))
+#endif
+
+static bool __mutex_init(struct mutex *mtx, bool pshared, bool recursive, bool robust)
 {
 	pthread_mutexattr_t attr;
+	bool ok = false, robust_unavailable = false;
+	int err;
 
-	CHECK_ERR(pthread_mutexattr_init(&attr));
+	err = pthread_mutexattr_init(&attr);
+	if (err)
+		goto out;
 
 #ifndef NDEBUG
 	/* In normal builds enable error checking, such as recursive usage. */
-	CHECK_ERR(pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_ERRORCHECK));
+	err = pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_ERRORCHECK);
+	if (err)
+		goto out_destroy;
 #endif
-	if (recursive)
-		CHECK_ERR(pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE));
-	if (pshared)
-		CHECK_ERR(pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED));
-	CHECK_ERR(pthread_mutex_init(&mtx->lock, &attr));
+	if (recursive) {
+		err = pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
+		if (err)
+			goto out_destroy;
+	}
+	if (pshared) {
+		err = pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
+		if (err)
+			goto out_destroy;
+	}
+	if (robust) {
+#ifdef HAVE_PTHREAD_MUTEX_ROBUST
+		err = pthread_mutexattr_setrobust(&attr, PTHREAD_MUTEX_ROBUST);
+		if (err)
+			robust_unavailable = true;
+#else
+		robust_unavailable = true;
+#endif
+		if (robust_unavailable)
+			goto out_destroy;
+	}
+
+	err = pthread_mutex_init(&mtx->lock, &attr);
+	if (!err)
+		ok = true;
+	else if (robust && pshared && err == ENOTSUP)
+		/*
+		 * glibc refuses a robust process shared mutex with ENOTSUP when
+		 * set_robust_list(2) isn't usable, i.e. when the machine provides
+		 * no robust mutexes for the process shared case: an unavailable
+		 * API, not a bad request.
+		 */
+		robust_unavailable = true;
+out_destroy:
 	CHECK_ERR(pthread_mutexattr_destroy(&attr));
+out:
+	if (robust_unavailable)
+		pr_debug("mutex: robust mutexes aren't available\n");
+	else if (err)
+		CHECK_ERR(err);
+
+	return ok;
 }
 
 void mutex_init(struct mutex *mtx)
 {
-	__mutex_init(mtx, /*pshared=*/false, /*recursive=*/false);
+	__mutex_init(mtx, /*pshared=*/false, /*recursive=*/false, /*robust=*/false);
 }
 
 void mutex_init_pshared(struct mutex *mtx)
 {
-	__mutex_init(mtx, /*pshared=*/true, /*recursive=*/false);
+	__mutex_init(mtx, /*pshared=*/true, /*recursive=*/false, /*robust=*/false);
 }
 
 void mutex_init_recursive(struct mutex *mtx)
 {
-	__mutex_init(mtx, /*pshared=*/false, /*recursive=*/true);
+	__mutex_init(mtx, /*pshared=*/false, /*recursive=*/true, /*robust=*/false);
+}
+
+bool mutex_init_pshared_robust(struct mutex *mtx)
+{
+	return __mutex_init(mtx, /*pshared=*/true, /*recursive=*/false, /*robust=*/true);
 }
 
 void mutex_destroy(struct mutex *mtx)
@@ -58,7 +127,8 @@ void mutex_destroy(struct mutex *mtx)
 void mutex_lock(struct mutex *mtx)
 	NO_THREAD_SAFETY_ANALYSIS
 {
-	CHECK_ERR(pthread_mutex_lock(&mtx->lock));
+	CHECK_ERR(mutex_take_over(mtx, pthread_mutex_lock(&mtx->lock),
+				  /*give_up=*/false));
 }
 
 void mutex_unlock(struct mutex *mtx)
@@ -69,7 +139,8 @@ void mutex_unlock(struct mutex *mtx)
 
 bool mutex_trylock(struct mutex *mtx)
 {
-	int ret = pthread_mutex_trylock(&mtx->lock);
+	int ret = mutex_take_over(mtx, pthread_mutex_trylock(&mtx->lock),
+				  /*give_up=*/true);
 
 	if (ret == 0)
 		return true; /* Lock acquired. */
@@ -111,7 +182,9 @@ void cond_destroy(struct cond *cnd)
 
 void cond_wait(struct cond *cnd, struct mutex *mtx)
 {
-	CHECK_ERR(pthread_cond_wait(&cnd->cond, &mtx->lock));
+	CHECK_ERR(mutex_take_over(mtx,
+				  pthread_cond_wait(&cnd->cond, &mtx->lock),
+				  /*give_up=*/false));
 }
 
 void cond_signal(struct cond *cnd)
diff --git a/tools/perf/util/mutex.h b/tools/perf/util/mutex.h
index 5554937675886ef3..5de1065ea2b94bbb 100644
--- a/tools/perf/util/mutex.h
+++ b/tools/perf/util/mutex.h
@@ -142,6 +142,12 @@ void mutex_init(struct mutex *mtx);
 void mutex_init_pshared(struct mutex *mtx);
 /* Initializes a mutex that may be recursively held on the same thread. */
 void mutex_init_recursive(struct mutex *mtx);
+/*
+ * As mutex_init_pshared(), plus the robust attribute: a process dying while
+ * holding it doesn't leave it locked, but the takeover isn't reported and the
+ * data it protects may be mid update.  Returns false when not available.
+ */
+bool mutex_init_pshared_robust(struct mutex *mtx);
 void mutex_destroy(struct mutex *mtx);
 
 void mutex_lock(struct mutex *mtx) EXCLUSIVE_LOCK_FUNCTION(*mtx);
-- 
2.55.0

