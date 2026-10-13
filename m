Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FED75437F1;
	Tue, 13 Oct 2026 20:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922514; cv=none; b=qX3IyKdFBCkjFjjunkWXubk2TzUuVK3jiXGhSf01C5JgXLHk+QSyWgJClofIFb1LzsHAJ/CtalUxKQ0m0qh+W5Yk+sDUiYWLvV6wMgkTHcRex4xZaQ+Fi2OQ9qDiMdqRfjL1GmfGUvYLjzjmugeY0oYKW83wfyarcypc60uboTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922514; c=relaxed/simple;
	bh=v4ExAQ1ys6sFCnFEXdwWFegUC+svoGuSzL/Juygp1O0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1pR+RG06RLDVEUql9FCCHBtDG9KfmO4hFhEbSKnQ9z0irESCXZPrxBwACv9B7DhePCoUYTpDLolRdXDs5V+c2glChhpYyMB6s/HtvDvpnX99mArJbZloaTY6NjHgrgOScM1fg/hEL8T6iZoV+6IcExI8NzVtIc6yaxnw/g4IHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GptN9f0R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GptN9f0R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A7D1F00893;
	Tue, 13 Oct 2026 20:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791922512;
	bh=je6B2bmfWa+j+yEFsXQ/4UZ8t6eGtjdyakVUMjvqZJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GptN9f0R37BxJw5GlW9XAjIfuPTr7hV9Zrct9wyxNBQWTnO99O+QEW17AQ4a1Uvce
	 Rc2xEBCrOrmI7UycDKt2SovD/xcV50ORAQB9ZcV+n1ZHo7tJGJlsUm3IHGhHOmXM23
	 tBveTVkrG2z2fge8zorBAxE5enn4fy9xam34axqu7EcpGcgJn8t8HNLIe5YCfm/AjT
	 RO2O46pd+RZuNneqiX2+iPR3n4diXhgIuEnOO5prGyOBYJHe5BW8YvZ2iPt9nSIx7C
	 UE8G+ed1PpQDCMEJHdAVgAEEnXUjvLFPNJaekivaJpVV98YuQWrpKEARr4OCrexM2y
	 mhpcwYDxwbf6Q==
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
Subject: [PATCH v2 16/19] perf mutex: Add a robust, process-shared mutex initializer
Date: Tue, 13 Oct 2026 17:14:11 -0300
Message-ID: <20261013201415.36428-17-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013201415.36428-1-acme@kernel.org>
References: <20261013201415.36428-1-acme@kernel.org>
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
makes it consistent and takes it over.

Add mutex_init_pshared_robust(), returning false when robust mutexes
aren't available: from libcs without the API, gated by a feature check,
to musl and glibc refusing them at runtime, when get_robust_list(2) or
set_robust_list(2) aren't usable.  glibc only sets a flag in
pthread_mutexattr_setrobust(), refusing the mutex itself in
pthread_mutex_init() with ENOTSUP instead.  Neither is an error, so
nothing is printed about them.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature                  |  1 +
 tools/build/feature/Makefile                  |  4 +
 tools/build/feature/test-all.c                |  5 ++
 .../build/feature/test-pthread-mutex-robust.c | 19 ++++
 tools/perf/Makefile.config                    |  4 +
 tools/perf/util/mutex.c                       | 86 ++++++++++++++++---
 tools/perf/util/mutex.h                       |  5 ++
 7 files changed, 112 insertions(+), 12 deletions(-)
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
index 0000000000000000..33241fbde3eab87f
--- /dev/null
+++ b/tools/build/feature/test-pthread-mutex-robust.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdint.h>
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
index 7aa1f3f55a7d4089..712fbf839d59085f 100644
--- a/tools/perf/util/mutex.c
+++ b/tools/perf/util/mutex.c
@@ -17,37 +17,84 @@ static void check_err(const char *fn, int err)
 
 #define CHECK_ERR(err) check_err(__func__, err)
 
-static void __mutex_init(struct mutex *mtx, bool pshared, bool recursive)
+static bool __mutex_init(struct mutex *mtx, bool pshared, bool recursive, bool robust)
 {
 	pthread_mutexattr_t attr;
+	bool ok = false;
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
-	CHECK_ERR(pthread_mutexattr_destroy(&attr));
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
+			goto out_unavailable;
+#else
+		goto out_unavailable;
+#endif
+	}
+
+	err = pthread_mutex_init(&mtx->lock, &attr);
+	if (!err)
+		ok = true;
+	else if (robust && pshared)
+		/*
+		 * glibc refuses a robust process shared mutex with ENOTSUP when
+		 * set_robust_list(2) isn't usable, i.e. when the machine provides
+		 * no robust mutexes for the process shared case: an unavailable
+		 * API, not a bad request.
+		 */
+		err = 0;
+out_destroy:
+	pthread_mutexattr_destroy(&attr);
+out:
+	if (err)
+		CHECK_ERR(err);
+
+	return ok;
+
+out_unavailable:
+	pthread_mutexattr_destroy(&attr);
+	return false;
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
@@ -58,7 +105,22 @@ void mutex_destroy(struct mutex *mtx)
 void mutex_lock(struct mutex *mtx)
 	NO_THREAD_SAFETY_ANALYSIS
 {
+#ifdef HAVE_PTHREAD_MUTEX_ROBUST
+	int err = pthread_mutex_lock(&mtx->lock);
+
+	/*
+	 * A robust mutex whose owner died while holding it comes back as
+	 * EOWNERDEAD, marked by the kernel: take it over.
+	 */
+	if (err == EOWNERDEAD) {
+		pr_debug("mutex: taking over one left by a dead owner\n");
+		CHECK_ERR(pthread_mutex_consistent(&mtx->lock));
+	} else {
+		CHECK_ERR(err);
+	}
+#else
 	CHECK_ERR(pthread_mutex_lock(&mtx->lock));
+#endif
 }
 
 void mutex_unlock(struct mutex *mtx)
diff --git a/tools/perf/util/mutex.h b/tools/perf/util/mutex.h
index 5554937675886ef3..fcac92d307fb7dad 100644
--- a/tools/perf/util/mutex.h
+++ b/tools/perf/util/mutex.h
@@ -142,6 +142,11 @@ void mutex_init(struct mutex *mtx);
 void mutex_init_pshared(struct mutex *mtx);
 /* Initializes a mutex that may be recursively held on the same thread. */
 void mutex_init_recursive(struct mutex *mtx);
+/*
+ * As mutex_init_pshared(), plus the robust attribute: a process dying while
+ * holding it doesn't leave it locked.  Returns false when not available.
+ */
+bool mutex_init_pshared_robust(struct mutex *mtx);
 void mutex_destroy(struct mutex *mtx);
 
 void mutex_lock(struct mutex *mtx) EXCLUSIVE_LOCK_FUNCTION(*mtx);
-- 
2.55.0

