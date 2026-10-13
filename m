Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EB85632AE
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 22:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791930418; cv=none; b=A3ohdlSIbqStxU8OYQk486blOVdI53c9//CCeM5CHsNypyrNg39Z5RRXSRSsJ23P63kqSA7zcyewvx8W41YlvQk2TtR4+DCLRBzG1zKRhc6S9bUb0wmEv5ZOsQT8cHiZPjGvn8uN+yAMN9MZhWGUscA0tIaSVuiHpGNbwHUw4Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791930418; c=relaxed/simple;
	bh=y3F9Xy4dskAVm4223YtE9IjPGvPgI5+h696DQ/KHXJQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=POjmvuYdxQxsc/wQpCnHGgu/Je8kn6SLUeYyu2p0WBmS2N7e14Mx404mfTyAHB/go9arBh5sR7PBtdj2g3vcg+JsoqI2YhmAlj8wSvWnczkq/F5xU6pllosZz3pfhRBcyggLVV5fpa5kUCIvPsOopjTQiT5CQH05FUWmSt+uA38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rGGYEutI; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rGGYEutI"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-341eff9e381so9401456eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 15:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791930414; x=1792535214; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=akhiltbw0LF7IWKPfQyuqpmH/j7Qc/MOnF0HaTFVPUE=;
        b=rGGYEutI7Oy5YnaxsNO03LRhvila+awMyIPIoXRTq1z18CxaJB5N9aszDzzeIQkIi5
         +em9tbq5OM5UFfeIyKSILX4Hjlz8K55gwMmOhFut3Aw5xMo7AmSxP9mNBpBplpirk5eO
         WYbe68Fd/VT73incXErAxkqO0sOhNgjdsaYnWVs2Xgp7Urim34pzykyzEg5IR8GtiYAc
         WVD6VV2ZWs86AmMIx9j5NTpToIOn4d37dGctI27Jo/O1LqsSiec9dNvngW/KU5FdMDAk
         Dqtv662gpdoNXlyrRQ8pODh5+7pMor/wMqcqn2/v6oLZwCrwgwBlQ3E/c0/iGA8nqx0m
         lT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791930414; x=1792535214;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=akhiltbw0LF7IWKPfQyuqpmH/j7Qc/MOnF0HaTFVPUE=;
        b=dS9X4+T/EiHhivq783gW9lMqhUUhPfuZ48252CiabIoawXqGpOjSnrxeH7FG0MnFBP
         6VSqWixnuuXucjPxknuwCLhGxgIMryII8EOlsfvDNjdOZ4+DbcNArUGaGB0Yj0XBzyCn
         GLOArpkGFSciM2rt4zgPmxt1dow+I/Fpe6d9m06GfwcgEfgTSKZkJRYKBORihpfpHtMV
         /Ye/LrkK93QedQ0EqUPve9jgpVfOCKTsNuSWu55oiHQlPShbD8d33zPTld8d6f4O/Kxj
         Ah03DW5nYBFiu15Y30XlgB0yBIi1rj8+FqNQJ5QZOUcV7acGGs4tVW4SWjfzP1nXS456
         h0CA==
X-Forwarded-Encrypted: i=1; AKwUvBxJqA2RJaS53uIBHYNY0qEgIVHA45j16yv0HsKwVBoBAz8Roy2rCfqRM60kcFQs8wY+lP+wQuK0IQ33HVZ0uPSH@vger.kernel.org
X-Gm-Message-State: AFq9FYIfZNYv+t5ccpQ3JliGk/Xk9jTt37Pe9c/vtc3zpxjpz3dXir4M
	uC33yQYs6PjIfCjhVv/mv6QRq+RxYtfM0KRNJ8NNrVnUt8M0Xo8ydNJhTZnPY/v575SmSc6CSjH
	WE8jniaqKDA==
X-Received: from dlbts25-n2.prod.google.com ([2002:a05:7022:b059:20b0:168:46d:d4f5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1713:b0:14d:3c0c:79ec
 with SMTP id a92af1059eb24-16a5dbfddf2mr15065047c88.9.1791930413307; Tue, 13
 Oct 2026 15:26:53 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:26:19 -0700
In-Reply-To: <20261013222622.1822619-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013182458.1234616-1-irogers@google.com> <20261013222622.1822619-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013222622.1822619-8-irogers@google.com>
Subject: [PATCH v2 07/10] perf dso: Fix unlocked __dsos__add() in vdso and
 expand lock annotations
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, elver@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, bvanassche@acm.org, james.clark@linaro.org, 
	jolsa@kernel.org, justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, ljs@kernel.org, llvm@lists.linux.dev, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

__machine__addnew_vdso() called __dsos__add(&machine->dsos, dso) without
holding machine->dsos.lock. Acquire machine->dsos.lock in write mode,
double-check __dsos__find() to avoid inserting duplicate VDSO entries
when racing with another thread, and set the long name before calling
__dsos__add().

In dsos__findnew_id(), try finding the DSO under the read lock first and
only acquire the write lock when a new DSO must be inserted or an
existing DSO needs its ID updated (checked via dso__needs_improve_id()).

In dso__list_del(), release the REFCNT_CHECKING reference directly via
refcount_dec_and_test() and RC_CHK_PUT() instead of unlocking
dso__data_open_lock to call dso__put(), keeping dso__data_open_lock held
continuously across try_to_open_dso() and avoiding lock-order inversions
and races during EMFILE eviction.

Also replace _dso__data_open_lock and its pthread_once() wrapper with
DEFINE_MUTEX(dso__data_open_lock), annotate struct dsos fields with
__guarded_by(&lock), add __returns_ctx_lock() to dso__lock(), annotate
dso__data_open and fd_limit in util/dso.c with
__guarded_by(&dso__data_open_lock), and tighten __dsos__findnew_id() and
__dsos__addnew_id() from shared to exclusive lock requirements.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/dso-data.c |  4 ++
 tools/perf/util/dso.c       | 93 ++++++++++++++++++-------------------
 tools/perf/util/dso.h       | 12 +++--
 tools/perf/util/dsos.c      | 31 +++++++++++--
 tools/perf/util/dsos.h      | 12 +++--
 tools/perf/util/vdso.c      | 17 ++++++-
 6 files changed, 106 insertions(+), 63 deletions(-)

diff --git a/tools/perf/tests/dso-data.c b/tools/perf/tests/dso-data.c
index 46bc3f597260..6753380f36ab 100644
--- a/tools/perf/tests/dso-data.c
+++ b/tools/perf/tests/dso-data.c
@@ -116,12 +116,14 @@ static int dso__data_fd(struct dso *dso, struct machine *machine)
 
 static void dsos__delete(struct dsos *dsos)
 {
+	down_write(&dsos->lock);
 	for (unsigned int i = 0; i < dsos->cnt; i++) {
 		struct dso *dso = dsos->dsos[i];
 
 		dso__data_close(dso);
 		unlink(dso__name(dso));
 	}
+	up_write(&dsos->lock);
 	dsos__exit(dsos);
 }
 
@@ -247,6 +249,7 @@ static int set_fd_limit(int n)
 }
 
 static int test__dso_data_cache(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+	__context_unsafe(/* single-threaded test */)
 {
 	struct machine machine;
 	long nr_end, nr = open_files_cnt();
@@ -317,6 +320,7 @@ static long new_limit(int count)
 }
 
 static int test__dso_data_reopen(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+	__context_unsafe(/* single-threaded test */)
 {
 	struct machine machine;
 	long nr_end, nr = open_files_cnt(), lim = new_limit(3);
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index ff5b30a3d424..21491625ec82 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -523,25 +523,12 @@ void dso__set_module_info(struct dso *dso, struct kmod_path *m,
 /*
  * Global list of open DSOs and the counter.
  */
-struct mutex _dso__data_open_lock;
-static LIST_HEAD(dso__data_open);
-static long dso__data_open_cnt __guarded_by(&_dso__data_open_lock);
+DEFINE_MUTEX(dso__data_open_lock);
+static struct list_head dso__data_open __guarded_by(&dso__data_open_lock) =
+	LIST_HEAD_INIT(dso__data_open);
+static long dso__data_open_cnt __guarded_by(&dso__data_open_lock);
 
-static void dso__data_open_lock_init(void)
-{
-	mutex_init(&_dso__data_open_lock);
-}
-
-static struct mutex *dso__data_open_lock(void) __returns_ctx_lock(&_dso__data_open_lock)
-{
-	static pthread_once_t data_open_lock_once = PTHREAD_ONCE_INIT;
-
-	pthread_once(&data_open_lock_once, dso__data_open_lock_init);
-
-	return &_dso__data_open_lock;
-}
-
-static void dso__list_add(struct dso *dso) __must_hold(&_dso__data_open_lock)
+static void dso__list_add(struct dso *dso) __must_hold(&dso__data_open_lock)
 {
 	list_add_tail(&dso__data(dso)->open_entry, &dso__data_open);
 #ifdef REFCNT_CHECKING
@@ -552,13 +539,13 @@ static void dso__list_add(struct dso *dso) __must_hold(&_dso__data_open_lock)
 	dso__data_open_cnt++;
 }
 
-static void dso__list_del(struct dso *dso) __must_hold(&_dso__data_open_lock)
+static void dso__list_del(struct dso *dso) __must_hold(&dso__data_open_lock)
 {
 	list_del_init(&dso__data(dso)->open_entry);
 #ifdef REFCNT_CHECKING
-	mutex_unlock(dso__data_open_lock());
-	dso__put(dso__data(dso)->dso);
-	mutex_lock(dso__data_open_lock());
+	BUG_ON(refcount_dec_and_test(&RC_CHK_ACCESS(dso)->refcnt));
+	RC_CHK_PUT(dso__data(dso)->dso);
+	dso__data(dso)->dso = NULL;
 #endif
 	WARN_ONCE(dso__data_open_cnt <= 0,
 		  "DSO data fd counter out of bounds.");
@@ -567,7 +554,7 @@ static void dso__list_del(struct dso *dso) __must_hold(&_dso__data_open_lock)
 
 static void close_first_dso(void);
 
-static int do_open(char *name) __must_hold(&_dso__data_open_lock)
+static int do_open(char *name) __must_hold(&dso__data_open_lock)
 {
 	do {
 		int fd = open(name, O_RDONLY|O_CLOEXEC);
@@ -670,7 +657,7 @@ void dso__put_filename(struct dso *dso __maybe_unused, char *filename, bool deco
 }
 
 static int __open_dso(struct dso *dso, struct machine *machine)
-	__must_hold(&_dso__data_open_lock)
+	__must_hold(&dso__data_open_lock)
 {
 	int fd = -EINVAL;
 	char *name;
@@ -703,7 +690,7 @@ static void check_data_close(void);
  * list/count of open DSO objects.
  */
 static int open_dso(struct dso *dso, struct machine *machine)
-	__must_hold(&_dso__data_open_lock)
+	__must_hold(&dso__data_open_lock)
 {
 	int fd;
 	struct nscookie nsc;
@@ -729,7 +716,7 @@ static int open_dso(struct dso *dso, struct machine *machine)
 	return fd;
 }
 
-static void close_data_fd(struct dso *dso) __must_hold(&_dso__data_open_lock)
+static void close_data_fd(struct dso *dso) __must_hold(&dso__data_open_lock)
 {
 	if (dso__data(dso)->fd >= 0) {
 		close(dso__data(dso)->fd);
@@ -746,12 +733,12 @@ static void close_data_fd(struct dso *dso) __must_hold(&_dso__data_open_lock)
  * Close @dso's data file descriptor and updates
  * list/count of open DSO objects.
  */
-static void close_dso(struct dso *dso) __must_hold(&_dso__data_open_lock)
+static void close_dso(struct dso *dso) __must_hold(&dso__data_open_lock)
 {
 	close_data_fd(dso);
 }
 
-static void close_first_dso(void) __must_hold(&_dso__data_open_lock)
+static void close_first_dso(void) __must_hold(&dso__data_open_lock)
 {
 	struct dso_data *dso_data;
 	struct dso *dso;
@@ -784,7 +771,7 @@ static rlim_t get_fd_limit(void)
 	return limit;
 }
 
-static rlim_t fd_limit;
+static rlim_t fd_limit __guarded_by(&dso__data_open_lock);
 
 /*
  * Used only by tests/dso-data.c to reset the environment
@@ -793,10 +780,11 @@ static rlim_t fd_limit;
  */
 void reset_fd_limit(void)
 {
-	fd_limit = 0;
+	/* Only called by single-threaded test setup. */
+	context_unsafe(fd_limit = 0);
 }
 
-static bool may_cache_fd(void) __must_hold(&_dso__data_open_lock)
+static bool may_cache_fd(void) __must_hold(&dso__data_open_lock)
 {
 	if (!fd_limit)
 		fd_limit = get_fd_limit();
@@ -812,7 +800,7 @@ static bool may_cache_fd(void) __must_hold(&_dso__data_open_lock)
  * for opened dso file descriptors. The limit is half
  * of the RLIMIT_NOFILE files opened.
 */
-static void check_data_close(void) __must_hold(&_dso__data_open_lock)
+static void check_data_close(void) __must_hold(&dso__data_open_lock)
 {
 	bool cache_fd = may_cache_fd();
 
@@ -828,13 +816,13 @@ static void check_data_close(void) __must_hold(&_dso__data_open_lock)
  */
 void dso__data_close(struct dso *dso)
 {
-	mutex_lock(dso__data_open_lock());
+	mutex_lock(&dso__data_open_lock);
 	close_dso(dso);
-	mutex_unlock(dso__data_open_lock());
+	mutex_unlock(&dso__data_open_lock);
 }
 
 static void try_to_open_dso(struct dso *dso, struct machine *machine)
-	__must_hold(&_dso__data_open_lock)
+	__must_hold(&dso__data_open_lock)
 {
 	enum dso_binary_type binary_type_data[] = {
 		DSO_BINARY_TYPE__BUILD_ID_CACHE,
@@ -882,7 +870,7 @@ bool dso__data_get_fd(struct dso *dso, struct machine *machine, int *fd)
 	if (dso__data(dso)->status == DSO_DATA_STATUS_ERROR)
 		return false;
 
-	mutex_lock(dso__data_open_lock());
+	mutex_lock(&dso__data_open_lock);
 
 	try_to_open_dso(dso, machine);
 
@@ -890,13 +878,13 @@ bool dso__data_get_fd(struct dso *dso, struct machine *machine, int *fd)
 	if (*fd >= 0)
 		return true;
 
-	mutex_unlock(dso__data_open_lock());
+	mutex_unlock(&dso__data_open_lock);
 	return false;
 }
 
 void dso__data_put_fd(struct dso *dso __maybe_unused)
 {
-	mutex_unlock(dso__data_open_lock());
+	mutex_unlock(&dso__data_open_lock);
 }
 
 bool dso__data_status_seen(struct dso *dso, enum dso_data_status_seen by)
@@ -1067,7 +1055,7 @@ static ssize_t file_read(struct dso *dso, struct machine *machine,
 {
 	ssize_t ret;
 
-	mutex_lock(dso__data_open_lock());
+	mutex_lock(&dso__data_open_lock);
 
 	/*
 	 * dso__data(dso)->fd might be closed if other thread opened another
@@ -1083,7 +1071,7 @@ static ssize_t file_read(struct dso *dso, struct machine *machine,
 
 	ret = pread(dso__data(dso)->fd, data, DSO__DATA_CACHE_SIZE, offset);
 out:
-	mutex_unlock(dso__data_open_lock());
+	mutex_unlock(&dso__data_open_lock);
 	return ret;
 }
 
@@ -1190,7 +1178,7 @@ static int file_size(struct dso *dso, struct machine *machine)
 	int ret = 0;
 	struct stat st;
 
-	mutex_lock(dso__data_open_lock());
+	mutex_lock(&dso__data_open_lock);
 
 	/*
 	 * dso__data(dso)->fd might be closed if other thread opened another
@@ -1213,7 +1201,7 @@ static int file_size(struct dso *dso, struct machine *machine)
 	dso__data(dso)->file_size = st.st_size;
 
 out:
-	mutex_unlock(dso__data_open_lock());
+	mutex_unlock(&dso__data_open_lock);
 	return ret;
 }
 
@@ -1417,7 +1405,7 @@ uint16_t dso__e_machine_endian(struct dso *dso, struct machine *machine, uint32_
 		return EM_NONE;
 	}
 
-	mutex_lock(dso__data_open_lock());
+	mutex_lock(&dso__data_open_lock);
 
 	/*
 	 * dso__data(dso)->fd might be closed if other thread opened another
@@ -1430,7 +1418,7 @@ uint16_t dso__e_machine_endian(struct dso *dso, struct machine *machine, uint32_
 	else if (e_flags)
 		*e_flags = 0;
 
-	mutex_unlock(dso__data_open_lock());
+	mutex_unlock(&dso__data_open_lock);
 	return e_machine;
 }
 
@@ -1596,6 +1584,15 @@ const struct dso_id dso_id_empty = {
 	}
 };
 
+bool dso__needs_improve_id(const struct dso *dso, const struct dso_id *id)
+{
+	const struct dso_id *dso_id = dso__id_const(dso);
+
+	return (id->mmap2_valid && !dso_id->mmap2_valid) ||
+	       (id->mmap2_ino_generation_valid && !dso_id->mmap2_ino_generation_valid) ||
+	       (build_id__is_defined(&id->build_id) && !build_id__is_defined(&dso_id->build_id));
+}
+
 void __dso__improve_id(struct dso *dso, const struct dso_id *id)
 {
 	struct dsos *dsos = dso__dsos(dso);
@@ -1620,8 +1617,10 @@ void __dso__improve_id(struct dso *dso, const struct dso_id *id)
 		dso_id->build_id = id->build_id;
 		changed = true;
 	}
-	if (changed && dsos)
-		dsos->sorted = false;
+	if (changed && dsos) {
+		/* dsos write lock held by caller. */
+		context_unsafe(dsos->sorted = false);
+	}
 }
 
 int dso_id__cmp(const struct dso_id *a, const struct dso_id *b)
@@ -1805,7 +1804,7 @@ struct dso *dso__get(struct dso *dso)
 void dso__put(struct dso *dso)
 {
 #ifdef REFCNT_CHECKING
-	if (dso && dso__data(dso) && refcount_read(&RC_CHK_ACCESS(dso)->refcnt) == 2)
+	if (dso && dso__data(dso)->dso && refcount_read(&RC_CHK_ACCESS(dso)->refcnt) == 2)
 		dso__data_close(dso);
 #endif
 	if (dso && refcount_dec_and_test(&RC_CHK_ACCESS(dso)->refcnt))
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 54aaa88f574e..3ad6ab5272bb 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -356,7 +356,7 @@ DECLARE_RC_STRUCT(dso) {
 	char		 name[];
 };
 
-extern struct mutex _dso__data_open_lock;
+extern struct mutex dso__data_open_lock;
 extern const struct dso_id dso_id_empty;
 
 int dso_id__cmp(const struct dso_id *a, const struct dso_id *b);
@@ -628,6 +628,7 @@ static inline void dso__set_loaded(struct dso *dso)
 }
 
 static inline struct mutex *dso__lock(struct dso *dso)
+	__returns_ctx_lock(&RC_CHK_ACCESS(dso)->lock)
 {
 	return &RC_CHK_ACCESS(dso)->lock;
 }
@@ -803,12 +804,13 @@ void dso__delete(struct dso *dso);
 int dso__cmp_id(struct dso *a, struct dso *b);
 void dso__set_short_name(struct dso *dso, const char *name, bool name_allocated);
 void dso__set_long_name(struct dso *dso, const char *name, bool name_allocated);
+bool dso__needs_improve_id(const struct dso *dso, const struct dso_id *id);
 void __dso__improve_id(struct dso *dso, const struct dso_id *id);
 
 int dso__name_len(const struct dso *dso);
 
 struct dso *dso__get(struct dso *dso);
-void dso__put(struct dso *dso) __must_not_hold(&_dso__data_open_lock);
+void dso__put(struct dso *dso) __must_not_hold(&dso__data_open_lock);
 
 static inline void __dso__zput(struct dso **dso)
 {
@@ -918,9 +920,9 @@ void dso__set_module_info(struct dso *dso, struct kmod_path *m,
  * TODO
 */
 bool dso__data_get_fd(struct dso *dso, struct machine *machine, int *fd)
-	__cond_acquires(true, &_dso__data_open_lock);
-void dso__data_put_fd(struct dso *dso) __releases(&_dso__data_open_lock);
-void dso__data_close(struct dso *dso) __must_not_hold(&_dso__data_open_lock);
+	__cond_acquires(true, &dso__data_open_lock);
+void dso__data_put_fd(struct dso *dso) __releases(&dso__data_open_lock);
+void dso__data_close(struct dso *dso) __must_not_hold(&dso__data_open_lock);
 
 int dso__data_file_size(struct dso *dso, struct machine *machine);
 off_t dso__data_size(struct dso *dso, struct machine *machine);
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index a2cd37bd1660..0e4307e35768 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -12,6 +12,7 @@
 #include <unistd.h>
 
 void dsos__init(struct dsos *dsos)
+	__context_unsafe(/* initialization */)
 {
 	init_rwsem(&dsos->lock);
 
@@ -50,6 +51,7 @@ void dsos__exit(struct dsos *dsos)
 static int __dsos__for_each_dso(struct dsos *dsos,
 				int (*cb)(struct dso *dso, void *data),
 				void *data)
+	__must_hold_shared(&dsos->lock)
 {
 	for (unsigned int i = 0; i < dsos->cnt; i++) {
 		struct dso *dso = dsos->dsos[i];
@@ -182,7 +184,8 @@ static struct dso *__dsos__find_by_longname_id(struct dsos *dsos,
 		}
 		qsort(dsos->dsos, dsos->cnt, sizeof(struct dso *),
 		      dsos__cmp_long_name_id_short_name);
-		dsos->sorted = true;
+		/* write_locked is true, so dsos->lock is held exclusively. */
+		context_unsafe(dsos->sorted = true);
 	}
 
 	res = bsearch(&key, dsos->dsos, dsos->cnt, sizeof(struct dso *),
@@ -194,6 +197,7 @@ static struct dso *__dsos__find_by_longname_id(struct dsos *dsos,
 }
 
 int __dsos__add(struct dsos *dsos, struct dso *dso)
+	__must_hold(&dsos->lock)
 {
 	if (!dso)
 		return -EINVAL;
@@ -284,12 +288,18 @@ static struct dso *__dsos__find_id(struct dsos *dsos, const char *name, const st
 	return res;
 }
 
+struct dso *__dsos__find(struct dsos *dsos, const char *name, bool cmp_short)
+	__must_hold_shared(&dsos->lock)
+{
+	return __dsos__find_id(dsos, name, &dso_id_empty, cmp_short, /*write_locked=*/false);
+}
+
 struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short)
 {
 	struct dso *res;
 
 	down_read(&dsos->lock);
-	res = __dsos__find_id(dsos, name, &dso_id_empty, cmp_short, /*write_locked=*/false);
+	res = __dsos__find(dsos, name, cmp_short);
 	up_read(&dsos->lock);
 	return res;
 }
@@ -314,6 +324,7 @@ static void dso__set_basename(struct dso *dso)
 }
 
 static struct dso *__dsos__addnew_id(struct dsos *dsos, const char *name, const struct dso_id *id)
+	__must_hold(&dsos->lock)
 {
 	struct dso *dso = dso__new_id(name, id);
 
@@ -330,7 +341,7 @@ static struct dso *__dsos__addnew_id(struct dsos *dsos, const char *name, const
 }
 
 static struct dso *__dsos__findnew_id(struct dsos *dsos, const char *name, const struct dso_id *id)
-	__must_hold_shared(&dsos->lock)
+	__must_hold(&dsos->lock)
 {
 	struct dso *dso = __dsos__find_id(dsos, name, id, false, /*write_locked=*/true);
 
@@ -343,8 +354,20 @@ static struct dso *__dsos__findnew_id(struct dsos *dsos, const char *name, const
 struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, const struct dso_id *id)
 {
 	struct dso *dso;
+
+	down_read(&dsos->lock);
+	dso = __dsos__find_id(dsos, name, id, false, /*write_locked=*/false);
+	if (dso && !dso__needs_improve_id(dso, id)) {
+		up_read(&dsos->lock);
+		return dso;
+	}
+	up_read(&dsos->lock);
+
 	down_write(&dsos->lock);
-	dso = __dsos__findnew_id(dsos, name, id);
+	if (dso)
+		__dso__improve_id(dso, id);
+	else
+		dso = __dsos__findnew_id(dsos, name, id);
 	up_write(&dsos->lock);
 	return dso;
 }
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index a26774950866..418899c17233 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -19,17 +19,19 @@ struct machine;
  */
 struct dsos {
 	struct rw_semaphore lock;
-	struct dso **dsos;
-	unsigned int cnt;
-	unsigned int allocated;
-	bool sorted;
+	struct dso **dsos __pt_guarded_by(&lock) __guarded_by(&lock);
+	unsigned int cnt __guarded_by(&lock);
+	unsigned int allocated __guarded_by(&lock);
+	bool sorted __guarded_by(&lock);
 };
 
 void dsos__init(struct dsos *dsos);
 void dsos__exit(struct dsos *dsos);
 
-int __dsos__add(struct dsos *dsos, struct dso *dso);
+int __dsos__add(struct dsos *dsos, struct dso *dso) __must_hold(&dsos->lock);
 int dsos__add(struct dsos *dsos, struct dso *dso);
+struct dso *__dsos__find(struct dsos *dsos, const char *name, bool cmp_short)
+	__must_hold_shared(&dsos->lock);
 struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
 
 struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, const struct dso_id *id);
diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index c12f5d8c4bf6..5f84cc789cf6 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -127,13 +127,26 @@ void machine__exit_vdso(struct machine *machine)
 static struct dso *__machine__addnew_vdso(struct machine *machine, const char *short_name,
 					  const char *long_name)
 {
-	struct dso *dso;
+	struct dso *dso, *existing;
+
+	down_write(&machine->dsos.lock);
+	existing = __dsos__find(&machine->dsos, short_name, true);
+	if (existing) {
+		up_write(&machine->dsos.lock);
+		return existing;
+	}
 
 	dso = dso__new(short_name);
 	if (dso != NULL) {
-		__dsos__add(&machine->dsos, dso);
+		/*
+		 * Set the long name before adding to machine->dsos so that
+		 * __dsos__add() inserts it in sorted order without needing to
+		 * re-take machine->dsos.lock.
+		 */
 		dso__set_long_name(dso, long_name, false);
+		__dsos__add(&machine->dsos, dso);
 	}
+	up_write(&machine->dsos.lock);
 
 	return dso;
 }
-- 
2.56.0.385.gd3acb90ef8-goog

