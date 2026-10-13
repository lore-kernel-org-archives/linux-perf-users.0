Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6800B5372EF
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916012; cv=none; b=WlS4bv1NFfdnJjzsoi2yp2nym1X+mSPoHD+Cq5OY/QeexBpx/F1rRgjYL/OXktL8fYKgYIqdhN7HFqoaKuV/1QUQq13Q1g1w1SUEYEJje9UF6MqcMvNAwvYdx2iBCl5MMYrFpg9jQpZx2zFpTCp1j3amvjL9K5HoCcmYkCcPJa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916012; c=relaxed/simple;
	bh=x53lcadQtPWnkdwrSh1BLZY0Qb3HA6UsjBoAGqRHJUs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Oie3bdj00WIE6/n1aRV7HuzNhvbYSM6pf8HQxNQ6jWBqm8rGac9qdCGskWVPPLOKlAd/KZ3JCBdNn9ibvnvQRYB4/bLNCp2EPZz9gylnLO8NtTAtLPuxAZUNoTQHZAwOMgBJ9uwr4H1lxdH6HpcuKDZ+PwdipWzPrXYUI18csdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E32/sDoH; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E32/sDoH"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30c0d568830so6821145eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 11:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791916008; x=1792520808; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SWRrFCf5IHCneu7XSfGxIVuL6a03m6SucmFW85Q8JGw=;
        b=E32/sDoHyVldzTNgth6fV14v2ngfAUpQF+GHfCXUBqymPy8k2EbqoHPjCFyLfRfA7L
         +rg26OWu9Y/bh18+NCsC/8oAy3YeMLw9ZTaXmWRsYc5Uoz5A0TuPZIqqhwMUG3s4j4Xy
         TQcNZIdt6BihkjlWsGGsv9mK1V9A8sJ+BLiOpN+grGjVJOblPgA+6lE/4NmVZeiF5woZ
         7kuN3c5fE7cDNHmULAeSJTQXZTlcUUbD/TI97qqSuCKfxDbzOIJR7IgajVIl0ywYZQLd
         uKXuApgZK7VHhkIDGEQtG5FqWGB0MrzWbj3jRIBDOEtyNONfiH2wRNDmn4VOt1vD4lZA
         TG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791916008; x=1792520808;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SWRrFCf5IHCneu7XSfGxIVuL6a03m6SucmFW85Q8JGw=;
        b=yQmAk88ypoQFVmw2iyx7AlgEFWJQtVE/6k78Hx7VA5OshjSlGWdD7VQN/YDDeSQnC/
         Gu0jHHG1v4BS4aHK45sFCSymks14d0S9X+WaWUVuSlepWfhbN6w66xh/9DcMZ7yARp5A
         +UWXJr2mijCvUIfTf3GufR73NVTsSyz5Jg4hOADFX7cMQZ7N5YMHzOwKdKOeKagFDdSE
         DIKwtjYjag8JT2nEQFe4vIsa1zpFCZYNPxHlPt4DeEBSZEkWntjNBx0iIAqdwo5fAb7P
         sKPt0M1xt9zEhhchr9ZCy1Ufowo3R/qGH6adOOjkp4p2ww+AelaqIur9/lnHujsDAUVk
         15HA==
X-Forwarded-Encrypted: i=1; AKwUvBwTebtymwa7XPgCFPaE0vm5WFFJpA9Uf1OsYFil7lOpwXJlGBRPIhwXlwCisS4v0m+RoM9R8sNkWWp7EaKxthjU@vger.kernel.org
X-Gm-Message-State: AFq9FYLZdkI5A3kg+gbY3pgm6MIUQAcn5alor/THpgRwyM9QsCsI6RNT
	AbtM0vrEj/pIjk9Ii5WmWNkSEJsbsDkIRSPv4JU1E7Y2omo23OEwlgrDDou9pR5CVDIUCnbL5tE
	eVbblNtegYw==
X-Received: from dybb16.prod.google.com ([2002:a05:693c:6090:b0:359:8e0d:2c6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:69cc:b0:351:4a53:ddbd
 with SMTP id 5a478bee46e88-3537dede999mr19038217eec.1.1791916005615; Tue, 13
 Oct 2026 11:26:45 -0700 (PDT)
Date: Tue, 13 Oct 2026 11:24:55 -0700
In-Reply-To: <20261013182458.1234616-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013182458.1234616-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013182458.1234616-8-irogers@google.com>
Subject: [PATCH v1 07/10] perf dso: Fix unlocked __dsos__add() in vdso and
 expand lock annotations
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

__machine__addnew_vdso() called __dsos__add(&machine->dsos, dso) without
holding machine->dsos.lock. Switch it to dsos__add() and make
__dsos__add() static in util/dsos.c with __must_hold(&dsos->lock).

In dsos__findnew_id(), try finding the DSO under the read lock first and
only acquire the write lock when a new DSO must be inserted or an
existing DSO needs its ID updated (checked via dso__needs_improve_id()).

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
 tools/perf/util/dso.c       | 89 ++++++++++++++++++-------------------
 tools/perf/util/dso.h       | 12 ++---
 tools/perf/util/dsos.c      | 25 +++++++++--
 tools/perf/util/dsos.h      |  9 ++--
 tools/perf/util/vdso.c      |  2 +-
 6 files changed, 81 insertions(+), 60 deletions(-)

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
index ff5b30a3d424..87a92238d25b 100644
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
+	mutex_unlock(&dso__data_open_lock);
 	dso__put(dso__data(dso)->dso);
-	mutex_lock(dso__data_open_lock());
+	mutex_lock(&dso__data_open_lock);
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
index a2cd37bd1660..dc6c417fec05 100644
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
@@ -193,7 +196,8 @@ static struct dso *__dsos__find_by_longname_id(struct dsos *dsos,
 	return dso__get(*res);
 }
 
-int __dsos__add(struct dsos *dsos, struct dso *dso)
+static int __dsos__add(struct dsos *dsos, struct dso *dso)
+	__must_hold(&dsos->lock)
 {
 	if (!dso)
 		return -EINVAL;
@@ -314,6 +318,7 @@ static void dso__set_basename(struct dso *dso)
 }
 
 static struct dso *__dsos__addnew_id(struct dsos *dsos, const char *name, const struct dso_id *id)
+	__must_hold(&dsos->lock)
 {
 	struct dso *dso = dso__new_id(name, id);
 
@@ -330,7 +335,7 @@ static struct dso *__dsos__addnew_id(struct dsos *dsos, const char *name, const
 }
 
 static struct dso *__dsos__findnew_id(struct dsos *dsos, const char *name, const struct dso_id *id)
-	__must_hold_shared(&dsos->lock)
+	__must_hold(&dsos->lock)
 {
 	struct dso *dso = __dsos__find_id(dsos, name, id, false, /*write_locked=*/true);
 
@@ -343,8 +348,20 @@ static struct dso *__dsos__findnew_id(struct dsos *dsos, const char *name, const
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
index a26774950866..9629978d6c6d 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -19,16 +19,15 @@ struct machine;
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
 int dsos__add(struct dsos *dsos, struct dso *dso);
 struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
 
diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index c12f5d8c4bf6..862ca172ab59 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -131,7 +131,7 @@ static struct dso *__machine__addnew_vdso(struct machine *machine, const char *s
 
 	dso = dso__new(short_name);
 	if (dso != NULL) {
-		__dsos__add(&machine->dsos, dso);
+		dsos__add(&machine->dsos, dso);
 		dso__set_long_name(dso, long_name, false);
 	}
 
-- 
2.56.0.385.gd3acb90ef8-goog

