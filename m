Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610AC56260C
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 22:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791930409; cv=none; b=WX0QYGfx/pHqyv2vFN07106kD7AE7Okl931OKcE4/ZLfzlS5VyR1gRDejY93lnwhEsjuu6a2otXVnIwl2SGBMndcbYOqvUCMOMEsyaxvxWIMgyUnkN9Wpa1Zhpee4s0uL0mOiBtFUGoUKZczoA6jzC1yRQ7UvOUH5jd0vKApIBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791930409; c=relaxed/simple;
	bh=8tzX56A32caS6UYQo7S6LUI2sWnaceFsyPigWewG/TE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b8TihkvZWcAmhIY37R5/c+arLlZZnoMH3rF1LSNmQz2+AWjGvgpXeGMShApmYdiw126cgamZeHmkApIUWLt+KilpkUsxeGfoESNMO8mxm9EENwIT6IyiGieSkO0LkdqViHJf0QktQa/zPwSdh0wVaYnkQv4GJ7NhNtxSA0P80T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EAICEWW4; arc=none smtp.client-ip=74.125.82.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EAICEWW4"
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-154e9d2d94fso541476c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 15:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791930406; x=1792535206; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VHdExMOnJlSZSSM6L7wDonePKQsGb0yHF23X81O15cQ=;
        b=EAICEWW4wPsGudSbXcEoOlQBeiLqRnooLxOCeueD3AW5TGe5DI8ODjIusTCAql4haK
         U31B3JOW3X4wHP/CgOpDjXbd55L7yBBG/7u5CuvcPy/LOk9racRLhdAHw+jtmtQYd6Jf
         HkaVrdI3Rq4FOqvWs5Enwa3iMb6edddyplmPti2fNS5sHAcFBlL22eFmi97ulJA7bh9U
         cfysqJSifljm/62nwU7Zw5C4hrSKqORb/o1krK5/PliDGj7YAPE27FaUV807QgIgiXnH
         eENWk5SivWk1pc4aGWPm5dWiuaZj7e8sdZWGkOs8WmM6Mv0OatzMU+SAhvpVENMdbLB5
         V6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791930406; x=1792535206;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VHdExMOnJlSZSSM6L7wDonePKQsGb0yHF23X81O15cQ=;
        b=tRSaQDkJMlqxoLJww1XhMnwYO9Tf7RpJ0nATyV/3TNX+k7Nmo9gdvBHPF+kOaESMQq
         lyadUsmLkaLnm+n3dNBp1BiRb5ASQNtEddocFK7CX/htnM+X0QEAc1EK/e3lGLXq2ZRz
         S4XWsVQOmiOic/etcUhE0EmoPxv8Th7F20pWs7swL5QYXNNPCbRUM4NTnxHUPAxcMWLd
         5rFYhZ/63NHDcnwB6EafvzdeJQbqXeHnhDTi5doOVzCT/UZryNIjbg65k15mpRjcstUq
         suBlZsm9T25zId8GACcb6kZP1iEUbdpPBWC4MkvFzmHGOh+z0kX3so0NgX8g/XuVmj1G
         ztpQ==
X-Forwarded-Encrypted: i=1; AKwUvBzS9fHrkDdVHV5HjhYhnjvZSiqqVNoY0NtWP1CeRgdja/PDHxp6+XhOIUKQOO3mROESrN1ZfXaQl4Sy81Hh4O5+@vger.kernel.org
X-Gm-Message-State: AFq9FYI1U23bv+cm8Tn0eLE47SwYcRilk36pe67BYPk/fdf3Jwludo/+
	Uq6FgUa/5ok+8a1HjWa0c4lRpPJR0dD2qooD/3XplQCdR+VVSyiii2ABNqwFSZaqWm/OwnCZ2SV
	6tM+eoMxwWg==
X-Received: from dli22-n1.prod.google.com ([2002:a05:7022:296:10b0:150:117b:cbf8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:42c9:10b0:15c:705f:b981
 with SMTP id a92af1059eb24-16a6043c616mr20628080c88.32.1791930405847; Tue, 13
 Oct 2026 15:26:45 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:26:16 -0700
In-Reply-To: <20261013222622.1822619-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013182458.1234616-1-irogers@google.com> <20261013222622.1822619-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013222622.1822619-5-irogers@google.com>
Subject: [PATCH v2 04/10] perf mutex: Use kernel style compiler-context-analysis.h
 annotations
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, elver@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, bvanassche@acm.org, james.clark@linaro.org, 
	jolsa@kernel.org, justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, ljs@kernel.org, llvm@lists.linux.dev, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Enable -DWARN_CONTEXT_ANALYSIS alongside -Wthread-safety for Clang
builds in tools/perf/Makefile.config, replace the custom lock safety
macros in tools/perf with the kernel's compiler-context-analysis.h
annotations (context_lock_struct, __guarded_by, __acquires,
__acquires_shared, __releases, __releases_shared, __cond_acquires,
__must_hold, __must_hold_shared, __must_not_hold, __returns_ctx_lock,
__no_context_analysis, and __context_unsafe), and remove the redundant
macro definitions from tools/perf/util/mutex.h.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config    |  2 +-
 tools/perf/builtin-sched.c    | 16 +++----
 tools/perf/builtin-top.c      |  4 +-
 tools/perf/util/annotate.c    |  4 +-
 tools/perf/util/annotate.h    |  8 ++--
 tools/perf/util/comm.c        |  4 +-
 tools/perf/util/dso.c         | 26 +++++-----
 tools/perf/util/dso.h         |  8 ++--
 tools/perf/util/dsos.c        |  6 +--
 tools/perf/util/intel-tpebs.c |  6 +--
 tools/perf/util/libbfd.c      |  4 +-
 tools/perf/util/mutex.c       |  4 +-
 tools/perf/util/mutex.h       | 90 +++--------------------------------
 tools/perf/util/rwsem.c       |  8 ++--
 tools/perf/util/rwsem.h       | 10 ++--
 tools/perf/util/thread.c      |  8 ++--
 tools/perf/util/thread.h      |  2 +-
 17 files changed, 66 insertions(+), 144 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index cafc7be79643..39442577418e 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -64,7 +64,7 @@ ifeq ($(CC_NO_CLANG), 0)
   endif
 
   # Enabled Wthread-safety analysis for clang builds.
-  CFLAGS += -Wthread-safety
+  CFLAGS += -Wthread-safety -DWARN_CONTEXT_ANALYSIS
 endif
 
 include $(srctree)/tools/scripts/Makefile.arch
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 39571f03eda2..ee74a6aa5ea3 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -828,8 +828,8 @@ static void *thread_func(void *ctx)
 }
 
 static void create_tasks(struct perf_sched *sched)
-	EXCLUSIVE_LOCK_FUNCTION(sched->start_work_mutex)
-	EXCLUSIVE_LOCK_FUNCTION(sched->work_done_wait_mutex)
+	__acquires(&sched->start_work_mutex)
+	__acquires(&sched->work_done_wait_mutex)
 {
 	struct task_desc *task;
 	pthread_attr_t attr;
@@ -858,8 +858,8 @@ static void create_tasks(struct perf_sched *sched)
 }
 
 static void destroy_tasks(struct perf_sched *sched)
-	UNLOCK_FUNCTION(sched->start_work_mutex)
-	UNLOCK_FUNCTION(sched->work_done_wait_mutex)
+	__releases(&sched->start_work_mutex)
+	__releases(&sched->work_done_wait_mutex)
 {
 	struct task_desc *task;
 	unsigned long i;
@@ -878,8 +878,8 @@ static void destroy_tasks(struct perf_sched *sched)
 }
 
 static void wait_for_tasks(struct perf_sched *sched)
-	EXCLUSIVE_LOCKS_REQUIRED(sched->work_done_wait_mutex)
-	EXCLUSIVE_LOCKS_REQUIRED(sched->start_work_mutex)
+	__must_hold(&sched->work_done_wait_mutex)
+	__must_hold(&sched->start_work_mutex)
 {
 	u64 cpu_usage_0, cpu_usage_1;
 	struct task_desc *task;
@@ -930,8 +930,8 @@ static void wait_for_tasks(struct perf_sched *sched)
 }
 
 static void run_one_test(struct perf_sched *sched)
-	EXCLUSIVE_LOCKS_REQUIRED(sched->work_done_wait_mutex)
-	EXCLUSIVE_LOCKS_REQUIRED(sched->start_work_mutex)
+	__must_hold(&sched->work_done_wait_mutex)
+	__must_hold(&sched->start_work_mutex)
 {
 	u64 T0, T1, delta, avg_delta, fluct;
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index a3442d2d6edf..9049db154fa4 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -201,7 +201,7 @@ static void perf_top__record_precise_ip(struct perf_top *top,
 					struct hist_entry *he,
 					struct perf_sample *sample,
 					u64 ip)
-	EXCLUSIVE_LOCKS_REQUIRED(he->hists->lock)
+	__must_hold(&he->hists->lock)
 {
 	struct annotation *notes;
 	struct symbol *sym = he->ms.sym;
@@ -730,7 +730,7 @@ static void *display_thread(void *arg)
 static int hist_iter__top_callback(struct hist_entry_iter *iter,
 				   struct addr_location *al, bool single,
 				   void *arg)
-	EXCLUSIVE_LOCKS_REQUIRED(iter->he->hists->lock)
+	__must_hold(&iter->he->hists->lock)
 {
 	struct perf_top *top = arg;
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 86a4beec6528..c466757e8508 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -655,7 +655,7 @@ static struct mutex *annotation__get_mutex(const struct annotation *notes)
 }
 
 void annotation__lock(struct annotation *notes)
-	NO_THREAD_SAFETY_ANALYSIS
+	__no_context_analysis
 {
 	struct mutex *mutex = annotation__get_mutex(notes);
 
@@ -664,7 +664,7 @@ void annotation__lock(struct annotation *notes)
 }
 
 void annotation__unlock(struct annotation *notes)
-	NO_THREAD_SAFETY_ANALYSIS
+	__no_context_analysis
 {
 	struct mutex *mutex = annotation__get_mutex(notes);
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 1b47c1156b9a..f5465c931721 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -369,7 +369,7 @@ struct annotated_branch {
 	u64			*br_cntr;
 };
 
-struct LOCKABLE annotation {
+context_lock_struct(annotation) {
 	struct annotated_source *src;
 	struct annotated_branch *branch;
 };
@@ -379,9 +379,9 @@ static inline void annotation__init(struct annotation *notes __maybe_unused)
 }
 void annotation__exit(struct annotation *notes);
 
-void annotation__lock(struct annotation *notes) EXCLUSIVE_LOCK_FUNCTION(*notes);
-void annotation__unlock(struct annotation *notes) UNLOCK_FUNCTION(*notes);
-bool annotation__trylock(struct annotation *notes) EXCLUSIVE_TRYLOCK_FUNCTION(true, *notes);
+void annotation__lock(struct annotation *notes) __acquires(notes);
+void annotation__unlock(struct annotation *notes) __releases(notes);
+bool annotation__trylock(struct annotation *notes) __cond_acquires(true, notes);
 
 static inline int annotation__cycles_width(struct annotation *notes)
 {
diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
index 9880247a2c33..6343a3c9debe 100644
--- a/tools/perf/util/comm.c
+++ b/tools/perf/util/comm.c
@@ -24,7 +24,7 @@ static struct comm_strs {
 static void comm_strs__remove_if_last(struct comm_str *cs);
 
 static void comm_strs__init(void)
-	NO_THREAD_SAFETY_ANALYSIS /* Inherently single threaded due to pthread_once. */
+	__context_unsafe(/* Inherently single threaded due to pthread_once. */)
 {
 	init_rwsem(&_comm_strs.lock);
 	_comm_strs.capacity = 16;
@@ -120,7 +120,7 @@ static void comm_strs__remove_if_last(struct comm_str *cs)
 }
 
 static struct comm_str *__comm_strs__find(struct comm_strs *comm_strs, const char *str)
-	SHARED_LOCKS_REQUIRED(comm_strs->lock)
+	__must_hold_shared(&comm_strs->lock)
 {
 	struct comm_str **result;
 
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index d3017c82ffb5..ff5b30a3d424 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -525,14 +525,14 @@ void dso__set_module_info(struct dso *dso, struct kmod_path *m,
  */
 struct mutex _dso__data_open_lock;
 static LIST_HEAD(dso__data_open);
-static long dso__data_open_cnt GUARDED_BY(_dso__data_open_lock);
+static long dso__data_open_cnt __guarded_by(&_dso__data_open_lock);
 
 static void dso__data_open_lock_init(void)
 {
 	mutex_init(&_dso__data_open_lock);
 }
 
-static struct mutex *dso__data_open_lock(void) LOCK_RETURNED(_dso__data_open_lock)
+static struct mutex *dso__data_open_lock(void) __returns_ctx_lock(&_dso__data_open_lock)
 {
 	static pthread_once_t data_open_lock_once = PTHREAD_ONCE_INIT;
 
@@ -541,7 +541,7 @@ static struct mutex *dso__data_open_lock(void) LOCK_RETURNED(_dso__data_open_loc
 	return &_dso__data_open_lock;
 }
 
-static void dso__list_add(struct dso *dso) EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
+static void dso__list_add(struct dso *dso) __must_hold(&_dso__data_open_lock)
 {
 	list_add_tail(&dso__data(dso)->open_entry, &dso__data_open);
 #ifdef REFCNT_CHECKING
@@ -552,7 +552,7 @@ static void dso__list_add(struct dso *dso) EXCLUSIVE_LOCKS_REQUIRED(_dso__data_o
 	dso__data_open_cnt++;
 }
 
-static void dso__list_del(struct dso *dso) EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
+static void dso__list_del(struct dso *dso) __must_hold(&_dso__data_open_lock)
 {
 	list_del_init(&dso__data(dso)->open_entry);
 #ifdef REFCNT_CHECKING
@@ -567,7 +567,7 @@ static void dso__list_del(struct dso *dso) EXCLUSIVE_LOCKS_REQUIRED(_dso__data_o
 
 static void close_first_dso(void);
 
-static int do_open(char *name) EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
+static int do_open(char *name) __must_hold(&_dso__data_open_lock)
 {
 	do {
 		int fd = open(name, O_RDONLY|O_CLOEXEC);
@@ -670,7 +670,7 @@ void dso__put_filename(struct dso *dso __maybe_unused, char *filename, bool deco
 }
 
 static int __open_dso(struct dso *dso, struct machine *machine)
-	EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
+	__must_hold(&_dso__data_open_lock)
 {
 	int fd = -EINVAL;
 	char *name;
@@ -703,7 +703,7 @@ static void check_data_close(void);
  * list/count of open DSO objects.
  */
 static int open_dso(struct dso *dso, struct machine *machine)
-	EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
+	__must_hold(&_dso__data_open_lock)
 {
 	int fd;
 	struct nscookie nsc;
@@ -729,7 +729,7 @@ static int open_dso(struct dso *dso, struct machine *machine)
 	return fd;
 }
 
-static void close_data_fd(struct dso *dso) EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
+static void close_data_fd(struct dso *dso) __must_hold(&_dso__data_open_lock)
 {
 	if (dso__data(dso)->fd >= 0) {
 		close(dso__data(dso)->fd);
@@ -746,12 +746,12 @@ static void close_data_fd(struct dso *dso) EXCLUSIVE_LOCKS_REQUIRED(_dso__data_o
  * Close @dso's data file descriptor and updates
  * list/count of open DSO objects.
  */
-static void close_dso(struct dso *dso) EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
+static void close_dso(struct dso *dso) __must_hold(&_dso__data_open_lock)
 {
 	close_data_fd(dso);
 }
 
-static void close_first_dso(void) EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
+static void close_first_dso(void) __must_hold(&_dso__data_open_lock)
 {
 	struct dso_data *dso_data;
 	struct dso *dso;
@@ -796,7 +796,7 @@ void reset_fd_limit(void)
 	fd_limit = 0;
 }
 
-static bool may_cache_fd(void) EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
+static bool may_cache_fd(void) __must_hold(&_dso__data_open_lock)
 {
 	if (!fd_limit)
 		fd_limit = get_fd_limit();
@@ -812,7 +812,7 @@ static bool may_cache_fd(void) EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
  * for opened dso file descriptors. The limit is half
  * of the RLIMIT_NOFILE files opened.
 */
-static void check_data_close(void) EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
+static void check_data_close(void) __must_hold(&_dso__data_open_lock)
 {
 	bool cache_fd = may_cache_fd();
 
@@ -834,7 +834,7 @@ void dso__data_close(struct dso *dso)
 }
 
 static void try_to_open_dso(struct dso *dso, struct machine *machine)
-	EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
+	__must_hold(&_dso__data_open_lock)
 {
 	enum dso_binary_type binary_type_data[] = {
 		DSO_BINARY_TYPE__BUILD_ID_CACHE,
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 3f08d45e7f53..54aaa88f574e 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -808,7 +808,7 @@ void __dso__improve_id(struct dso *dso, const struct dso_id *id);
 int dso__name_len(const struct dso *dso);
 
 struct dso *dso__get(struct dso *dso);
-void dso__put(struct dso *dso) LOCKS_EXCLUDED(_dso__data_open_lock);
+void dso__put(struct dso *dso) __must_not_hold(&_dso__data_open_lock);
 
 static inline void __dso__zput(struct dso **dso)
 {
@@ -918,9 +918,9 @@ void dso__set_module_info(struct dso *dso, struct kmod_path *m,
  * TODO
 */
 bool dso__data_get_fd(struct dso *dso, struct machine *machine, int *fd)
-	EXCLUSIVE_TRYLOCK_FUNCTION(true, _dso__data_open_lock);
-void dso__data_put_fd(struct dso *dso) UNLOCK_FUNCTION(_dso__data_open_lock);
-void dso__data_close(struct dso *dso) LOCKS_EXCLUDED(_dso__data_open_lock);
+	__cond_acquires(true, &_dso__data_open_lock);
+void dso__data_put_fd(struct dso *dso) __releases(&_dso__data_open_lock);
+void dso__data_close(struct dso *dso) __must_not_hold(&_dso__data_open_lock);
 
 int dso__data_file_size(struct dso *dso, struct machine *machine);
 off_t dso__data_size(struct dso *dso, struct machine *machine);
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index e927e707abac..a2cd37bd1660 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -157,7 +157,7 @@ static struct dso *__dsos__find_by_longname_id(struct dsos *dsos,
 					       const char *name,
 					       const struct dso_id *id,
 					       bool write_locked)
-	SHARED_LOCKS_REQUIRED(dsos->lock)
+	__must_hold_shared(&dsos->lock)
 {
 	struct dsos__key key = {
 		.long_name = name,
@@ -266,7 +266,7 @@ static int dsos__find_id_cb(struct dso *dso, void *data)
 
 static struct dso *__dsos__find_id(struct dsos *dsos, const char *name, const struct dso_id *id,
 				   bool cmp_short, bool write_locked)
-	SHARED_LOCKS_REQUIRED(dsos->lock)
+	__must_hold_shared(&dsos->lock)
 {
 	struct dso *res;
 
@@ -330,7 +330,7 @@ static struct dso *__dsos__addnew_id(struct dsos *dsos, const char *name, const
 }
 
 static struct dso *__dsos__findnew_id(struct dsos *dsos, const char *name, const struct dso_id *id)
-	SHARED_LOCKS_REQUIRED(dsos->lock)
+	__must_hold_shared(&dsos->lock)
 {
 	struct dso *dso = __dsos__find_id(dsos, name, id, false, /*write_locked=*/true);
 
diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index b41171b5df77..7c0b8b15bd10 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -69,7 +69,7 @@ static struct mutex *tpebs_mtx_get(void)
 }
 
 static struct tpebs_retire_lat *tpebs_retire_lat__find(struct evsel *evsel)
-	EXCLUSIVE_LOCKS_REQUIRED(tpebs_mtx_get());
+	__must_hold(tpebs_mtx_get());
 
 static int evsel__tpebs_start_perf_record(struct evsel *evsel)
 {
@@ -244,7 +244,7 @@ static void *__sample_reader(void *arg __maybe_unused)
 	return NULL;
 }
 
-static int tpebs_send_record_cmd(const char *msg) EXCLUSIVE_LOCKS_REQUIRED(tpebs_mtx_get())
+static int tpebs_send_record_cmd(const char *msg) __must_hold(tpebs_mtx_get())
 {
 	struct pollfd pollfd = { .events = POLLIN, };
 	int ret, len, retries = 0;
@@ -321,7 +321,7 @@ static int tpebs_send_record_cmd(const char *msg) EXCLUSIVE_LOCKS_REQUIRED(tpebs
 /*
  * tpebs_stop - stop the sample data read thread and the perf record process.
  */
-static int tpebs_stop(void) EXCLUSIVE_LOCKS_REQUIRED(tpebs_mtx_get())
+static int tpebs_stop(void) __must_hold(tpebs_mtx_get())
 {
 	int ret = 0;
 
diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
index a907d7c1ac94..adeb1f1c5016 100644
--- a/tools/perf/util/libbfd.c
+++ b/tools/perf/util/libbfd.c
@@ -51,13 +51,13 @@ struct a2l_data {
 	asymbol **syms;
 };
 
-static bool perf_bfd_lock(void *bfd_mutex) NO_THREAD_SAFETY_ANALYSIS
+static bool perf_bfd_lock(void *bfd_mutex) __no_context_analysis
 {
 	mutex_lock(bfd_mutex);
 	return true;
 }
 
-static bool perf_bfd_unlock(void *bfd_mutex) NO_THREAD_SAFETY_ANALYSIS
+static bool perf_bfd_unlock(void *bfd_mutex) __no_context_analysis
 {
 	mutex_unlock(bfd_mutex);
 	return true;
diff --git a/tools/perf/util/mutex.c b/tools/perf/util/mutex.c
index 7aa1f3f55a7d..99965eec983e 100644
--- a/tools/perf/util/mutex.c
+++ b/tools/perf/util/mutex.c
@@ -56,13 +56,13 @@ void mutex_destroy(struct mutex *mtx)
 }
 
 void mutex_lock(struct mutex *mtx)
-	NO_THREAD_SAFETY_ANALYSIS
+	__no_context_analysis
 {
 	CHECK_ERR(pthread_mutex_lock(&mtx->lock));
 }
 
 void mutex_unlock(struct mutex *mtx)
-	NO_THREAD_SAFETY_ANALYSIS
+	__no_context_analysis
 {
 	CHECK_ERR(pthread_mutex_unlock(&mtx->lock));
 }
diff --git a/tools/perf/util/mutex.h b/tools/perf/util/mutex.h
index 555493767588..424ce2989b6c 100644
--- a/tools/perf/util/mutex.h
+++ b/tools/perf/util/mutex.h
@@ -4,91 +4,13 @@
 
 #include <pthread.h>
 #include <stdbool.h>
-
-/*
- * A function-like feature checking macro that is a wrapper around
- * `__has_attribute`, which is defined by GCC 5+ and Clang and evaluates to a
- * nonzero constant integer if the attribute is supported or 0 if not.
- */
-#ifdef __has_attribute
-#define HAVE_ATTRIBUTE(x) __has_attribute(x)
-#else
-#define HAVE_ATTRIBUTE(x) 0
-#endif
-
-#if HAVE_ATTRIBUTE(guarded_by) && HAVE_ATTRIBUTE(pt_guarded_by) && \
-	HAVE_ATTRIBUTE(lockable) && HAVE_ATTRIBUTE(exclusive_lock_function) && \
-	HAVE_ATTRIBUTE(exclusive_trylock_function) && HAVE_ATTRIBUTE(exclusive_locks_required) && \
-	HAVE_ATTRIBUTE(no_thread_safety_analysis)
-
-/* Documents if a shared field or global variable needs to be protected by a mutex. */
-#define GUARDED_BY(x) __attribute__((guarded_by(x)))
-
-/*
- * Documents if the memory location pointed to by a pointer should be guarded by
- * a mutex when dereferencing the pointer.
- */
-#define PT_GUARDED_BY(x) __attribute__((pt_guarded_by(x)))
-
-/* Documents if a type is a lockable type. */
-#define LOCKABLE __attribute__((lockable))
-
-/* Documents a function that expects a lock not to be held prior to entry. */
-#define LOCKS_EXCLUDED(...) __attribute__((locks_excluded(__VA_ARGS__)))
-
-/* Documents a function that returns a lock. */
-#define LOCK_RETURNED(x) __attribute__((lock_returned(x)))
-
-/* Documents functions that acquire a lock in the body of a function, and do not release it. */
-#define EXCLUSIVE_LOCK_FUNCTION(...)  __attribute__((exclusive_lock_function(__VA_ARGS__)))
-
-/*
- * Documents functions that acquire a shared (reader) lock in the body of a
- * function, and do not release it.
- */
-#define SHARED_LOCK_FUNCTION(...)  __attribute__((shared_lock_function(__VA_ARGS__)))
-
-/*
- * Documents functions that expect a lock to be held on entry to the function,
- * and release it in the body of the function.
- */
-#define UNLOCK_FUNCTION(...) __attribute__((unlock_function(__VA_ARGS__)))
-
-/* Documents functions that try to acquire a lock, and return success or failure. */
-#define EXCLUSIVE_TRYLOCK_FUNCTION(...) \
-	__attribute__((exclusive_trylock_function(__VA_ARGS__)))
-
-/* Documents a function that expects a mutex to be held prior to entry. */
-#define EXCLUSIVE_LOCKS_REQUIRED(...) __attribute__((exclusive_locks_required(__VA_ARGS__)))
-
-/* Documents a function that expects a shared (reader) lock to be held prior to entry. */
-#define SHARED_LOCKS_REQUIRED(...) __attribute__((shared_locks_required(__VA_ARGS__)))
-
-/* Turns off thread safety checking within the body of a particular function. */
-#define NO_THREAD_SAFETY_ANALYSIS __attribute__((no_thread_safety_analysis))
-
-#else
-
-#define GUARDED_BY(x)
-#define PT_GUARDED_BY(x)
-#define LOCKABLE
-#define LOCKS_EXCLUDED(...)
-#define LOCK_RETURNED(x)
-#define EXCLUSIVE_LOCK_FUNCTION(...)
-#define SHARED_LOCK_FUNCTION(...)
-#define UNLOCK_FUNCTION(...)
-#define EXCLUSIVE_TRYLOCK_FUNCTION(...)
-#define EXCLUSIVE_LOCKS_REQUIRED(...)
-#define SHARED_LOCKS_REQUIRED(...)
-#define NO_THREAD_SAFETY_ANALYSIS
-
-#endif
+#include <linux/compiler.h>
 
 /*
  * A wrapper around the mutex implementation that allows perf to error check
  * usage, etc.
  */
-struct LOCKABLE mutex {
+context_lock_struct(mutex) {
 	pthread_mutex_t lock;
 };
 
@@ -144,10 +66,10 @@ void mutex_init_pshared(struct mutex *mtx);
 void mutex_init_recursive(struct mutex *mtx);
 void mutex_destroy(struct mutex *mtx);
 
-void mutex_lock(struct mutex *mtx) EXCLUSIVE_LOCK_FUNCTION(*mtx);
-void mutex_unlock(struct mutex *mtx) UNLOCK_FUNCTION(*mtx);
+void mutex_lock(struct mutex *mtx) __acquires(mtx);
+void mutex_unlock(struct mutex *mtx) __releases(mtx);
 /* Tries to acquire the lock and returns true on success. */
-bool mutex_trylock(struct mutex *mtx) EXCLUSIVE_TRYLOCK_FUNCTION(true, *mtx);
+bool mutex_trylock(struct mutex *mtx) __cond_acquires(true, mtx);
 
 /* Default initialize the cond struct. */
 void cond_init(struct cond *cnd);
@@ -158,7 +80,7 @@ void cond_init(struct cond *cnd);
 void cond_init_pshared(struct cond *cnd);
 void cond_destroy(struct cond *cnd);
 
-void cond_wait(struct cond *cnd, struct mutex *mtx) EXCLUSIVE_LOCKS_REQUIRED(mtx);
+void cond_wait(struct cond *cnd, struct mutex *mtx) __must_hold(mtx);
 void cond_signal(struct cond *cnd);
 void cond_broadcast(struct cond *cnd);
 
diff --git a/tools/perf/util/rwsem.c b/tools/perf/util/rwsem.c
index 9d26832398db..cc720b482333 100644
--- a/tools/perf/util/rwsem.c
+++ b/tools/perf/util/rwsem.c
@@ -27,7 +27,7 @@ int exit_rwsem(struct rw_semaphore *sem)
 }
 
 int down_read(struct rw_semaphore *sem)
-	NO_THREAD_SAFETY_ANALYSIS
+	__no_context_analysis
 {
 #if RWS_ERRORCHECK
 	mutex_lock(&sem->mtx);
@@ -38,7 +38,7 @@ int down_read(struct rw_semaphore *sem)
 }
 
 int up_read(struct rw_semaphore *sem)
-	NO_THREAD_SAFETY_ANALYSIS
+	__no_context_analysis
 {
 #if RWS_ERRORCHECK
 	mutex_unlock(&sem->mtx);
@@ -49,7 +49,7 @@ int up_read(struct rw_semaphore *sem)
 }
 
 int down_write(struct rw_semaphore *sem)
-	NO_THREAD_SAFETY_ANALYSIS
+	__no_context_analysis
 {
 #if RWS_ERRORCHECK
 	mutex_lock(&sem->mtx);
@@ -60,7 +60,7 @@ int down_write(struct rw_semaphore *sem)
 }
 
 int up_write(struct rw_semaphore *sem)
-	NO_THREAD_SAFETY_ANALYSIS
+	__no_context_analysis
 {
 #if RWS_ERRORCHECK
 	mutex_unlock(&sem->mtx);
diff --git a/tools/perf/util/rwsem.h b/tools/perf/util/rwsem.h
index b102d8143181..235bb63c92d0 100644
--- a/tools/perf/util/rwsem.h
+++ b/tools/perf/util/rwsem.h
@@ -10,7 +10,7 @@
  */
 #define RWS_ERRORCHECK 0
 
-struct LOCKABLE rw_semaphore {
+context_lock_struct(rw_semaphore) {
 #if RWS_ERRORCHECK
 	struct mutex mtx;
 #else
@@ -21,10 +21,10 @@ struct LOCKABLE rw_semaphore {
 int init_rwsem(struct rw_semaphore *sem);
 int exit_rwsem(struct rw_semaphore *sem);
 
-int down_read(struct rw_semaphore *sem) SHARED_LOCK_FUNCTION(sem);
-int up_read(struct rw_semaphore *sem) UNLOCK_FUNCTION(sem);
+int down_read(struct rw_semaphore *sem) __acquires_shared(sem);
+int up_read(struct rw_semaphore *sem) __releases_shared(sem);
 
-int down_write(struct rw_semaphore *sem) EXCLUSIVE_LOCK_FUNCTION(sem);
-int up_write(struct rw_semaphore *sem) UNLOCK_FUNCTION(sem);
+int down_write(struct rw_semaphore *sem) __acquires(sem);
+int up_write(struct rw_semaphore *sem) __releases(sem);
 
 #endif /* _PERF_RWSEM_H */
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 91118c301913..616d5bf87baf 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -41,7 +41,7 @@ int thread__init_maps(struct thread *thread, struct machine *machine)
 }
 
 struct thread *thread__new(pid_t pid, pid_t tid)
-	NO_THREAD_SAFETY_ANALYSIS /* Allocation/creation is inherently single threaded. */
+	__context_unsafe(/* Allocation/creation is inherently single threaded. */)
 {
 	RC_STRUCT(thread) *_thread = zalloc(sizeof(*_thread));
 	struct thread *thread;
@@ -203,7 +203,7 @@ int thread__set_namespaces(struct thread *thread, u64 timestamp,
 }
 
 static struct comm *__thread__comm(struct thread *thread)
-	SHARED_LOCKS_REQUIRED(thread__comm_lock(thread))
+	__must_hold_shared(thread__comm_lock(thread))
 {
 	if (list_empty(thread__comm_list(thread)))
 		return NULL;
@@ -250,7 +250,7 @@ struct comm *thread__exec_comm(struct thread *thread)
 
 static int ____thread__set_comm(struct thread *thread, const char *str,
 				u64 timestamp, bool exec)
-	EXCLUSIVE_LOCKS_REQUIRED(thread__comm_lock(thread))
+	__must_hold(thread__comm_lock(thread))
 {
 	struct comm *new, *curr = __thread__comm(thread);
 
@@ -308,7 +308,7 @@ int thread__set_comm_from_proc(struct thread *thread)
 }
 
 static const char *__thread__comm_str(struct thread *thread)
-	SHARED_LOCKS_REQUIRED(thread__comm_lock(thread))
+	__must_hold_shared(thread__comm_lock(thread))
 {
 	const struct comm *comm = __thread__comm(thread);
 
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index d82fce8173ae..9d0ce7742c06 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -251,7 +251,7 @@ static inline struct rw_semaphore *thread__comm_lock(struct thread *thread)
 }
 
 static inline struct list_head *thread__comm_list(struct thread *thread)
-	SHARED_LOCKS_REQUIRED(thread__comm_lock(thread))
+	__must_hold_shared(thread__comm_lock(thread))
 {
 	return &RC_CHK_ACCESS(thread)->comm_list;
 }
-- 
2.56.0.385.gd3acb90ef8-goog

