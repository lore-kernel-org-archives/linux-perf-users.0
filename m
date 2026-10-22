Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700136;
	b=iX7Llk2PpqY+TOZCxObe5XNkPoMu3Ulcv0DbbDnMzTcF/S4XqzPDgpcqV+sVvbfc8y5T
	 qsN+igSpL8paz+1sJe445/cBiqdVAIdaz1iV8d9XqMdRMYb4HS3iEBopRpxQSrraJ0PHv
	 Gb+PLhIaDeTlX5MYYB5VcDXUHcQc1EfpPlXsSXwm3+jJA8u8/bIQhkqVXmRWJghoYwUDT
	 j1iCy38My4nDoXmLsyFHakIP8lY+mH2x2DboBwTA3HuA21gL/980a5AoPJw39XxVaYODQ
	 C47ab7aFH7S4TE4dudIFr/mlhiUs4NzTATGqtrzxpZdjhSl3rgwXozICzWmi3rfl4Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=/sw3Zy3QfbyRHMtojg/LPx/IqMxZKrch2S1ubTvpkr4=;
	b=KuDyh9/8HkVHkHs+uYTTJw2w5acEmwLR+w6dBNulhTIwlZIgT0dZBQDoU5eTuj07DCJR
	 /dyvwJPjwjZemcRimv4eB/mGZosP8ZVdso++nIBqZJpUQAJSsImaYn7/fXmB6AQhcCino
	 ZSiC8zoXrZBDBRYcpDgTK+5JaMqoYiWS3HLeYvwu50AaiCioXL37ZcU7VfhtKbCPrGC0i
	 UhohImJsKLPmwS7qLm3HQHB5iioMvYY157SiAf9i2zIR44khSe2qqhmRsPY/FuXiEfEw7
	 dt2Yn5YVYimDlGXV+clAE05HwYPlo84Hzpf3Lvbyv+VD3/vAmElkuHzfCmXfbqxOnEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=vYU9R8rf;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597EF60A2611
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 597EF60A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=vYU9R8rf
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30c0d568830so434615eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 13:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792700135; x=1793304935; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/sw3Zy3QfbyRHMtojg/LPx/IqMxZKrch2S1ubTvpkr4=;
        b=vYU9R8rf1Mvrysy5e1W2YZHC1OywrFToMifiiD7ShD2Lpp12RygpiCpY4AlevtRRDf
         dtfVPalEimbxGG7OoJhVXMvSnMRp0X+r6Np6MgP/1Ea8bQR3aR14HwMU8VBc5ryrJIiX
         V1aDTTRUSMMFs5o2C8L1goPtHoCR1aoj0GoMSEiqA+L4faYvrURzHRBmeKF3KjsAv5aC
         5JcHUWyionSsTTZPYawzE1Qaj114PgVgHSKxKvBJKMPu5migg+8RG1m3QmOvqCo9Evbi
         IiAJFnKk9FeQpbQAUiGuXONTmn54swDbu9rPA9nVyiOSL0BWfMc/aDfM7nA02C+StGjT
         QVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792700135; x=1793304935;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/sw3Zy3QfbyRHMtojg/LPx/IqMxZKrch2S1ubTvpkr4=;
        b=ppcD9L4J7VpzQdYAV+yii88uwFmFHTMDwZgWm0sl8vdhdh4ljFzfV6pzb/FWew67xv
         3AOrDVKEI3FbO3oCXvLCH4ConF5iDzMqPQDj3FFPUCokD5yHS5AbDQ4zoJXI2uVNbo79
         g3e7PmA4DgwvNjAvDxquGHi29kMyHGZ7EdwR7Od2CFsWQD6BVJMZdMiI1qQVbI4I4u7q
         4AWAwOoeXhbicp7s9BT8lyZYbAgKqLORpfImFp0VzEK175PTz97TrmsOWvRiXAu5ToeX
         zW4h/XAVutTo+fzWIHCbjjXHQmQPM65qe7B282erTorvnHj+tnI41cvnr4gYmTYpNZNd
         dOPg==
X-Forwarded-Encrypted: i=1; AKwUvBwBzshcWwjA62t9G3hdjQf2ozVxCcJCk9UftRBIaxQk18DeUOF9fEHJy24li8lcPC+YYYvr8ebgKDiY1NrGk2fB@vger.kernel.org
X-Gm-Message-State: AFq9FYK7Ubbkj6HHvxnVWT3ZckrxVPEo8pSEugY8OPgjAlb7R8OLR7ak
	/SExJHFoaTIUoEDcJxHO+dXjFuE8NTg9wW7/QguDk6GQMjwUnKm600sgKiH4CwlkObJhCTTd71t
	xWVPKsvz9+w==
X-Received: from dycmz2.prod.google.com ([2002:a05:7300:ea02:b0:369:59e9:b1d0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:152c:b0:34e:f948:d7da
 with SMTP id 5a478bee46e88-369d972fffcmr252999eec.21.1792700133994; Thu, 22
 Oct 2026 13:15:33 -0700 (PDT)
Date: Thu, 22 Oct 2026 13:14:44 -0700
In-Reply-To: <20261022201453.1717523-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021223905.715051-1-irogers@google.com> <20261022201453.1717523-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261022201453.1717523-12-irogers@google.com>
Subject: [PATCH v8 11/19] perf dso: Use DEFINE_MUTEX for dso__data_open_lock
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, elver@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, ljs@kernel.org, llvm@lists.linux.dev, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Replace _dso__data_open_lock and its pthread_once() initialization
wrapper dso__data_open_lock() with DEFINE_MUTEX(dso__data_open_lock).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c | 68 +++++++++++++++++--------------------------
 tools/perf/util/dso.h | 10 +++----
 2 files changed, 32 insertions(+), 46 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index cbc4f30e7f23..f0e02062c09c 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -524,25 +524,11 @@ void dso__set_module_info(struct dso *dso, struct kmod_path *m,
 /*
  * Global list of open DSOs and the counter.
  */
-struct mutex _dso__data_open_lock;
+DEFINE_MUTEX(dso__data_open_lock);
 static LIST_HEAD(dso__data_open);
-static long dso__data_open_cnt __guarded_by(&_dso__data_open_lock);
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
 	/* Assume the dso is part of dsos, holding it live while on dso__data_open. */
@@ -550,7 +536,7 @@ static void dso__list_add(struct dso *dso) __must_hold(&_dso__data_open_lock)
 	dso__data_open_cnt++;
 }
 
-static void dso__list_del(struct dso_data *dso_data) __must_hold(&_dso__data_open_lock)
+static void dso__list_del(struct dso_data *dso_data) __must_hold(&dso__data_open_lock)
 {
 	list_del_init(&dso_data->open_entry);
 	WARN_ONCE(dso__data_open_cnt <= 0,
@@ -560,7 +546,7 @@ static void dso__list_del(struct dso_data *dso_data) __must_hold(&_dso__data_ope
 
 static void close_first_dso(void);
 
-static int do_open(char *name) __must_hold(&_dso__data_open_lock)
+static int do_open(char *name) __must_hold(&dso__data_open_lock)
 {
 	do {
 		int fd = open(name, O_RDONLY|O_CLOEXEC);
@@ -663,7 +649,7 @@ void dso__put_filename(struct dso *dso __maybe_unused, char *filename, bool deco
 }
 
 static int __open_dso(struct dso *dso, struct machine *machine)
-	__must_hold(&_dso__data_open_lock)
+	__must_hold(&dso__data_open_lock)
 {
 	int fd = -EINVAL;
 	char *name;
@@ -696,7 +682,7 @@ static void check_data_close(void);
  * list/count of open DSO objects.
  */
 static int open_dso(struct dso *dso, struct machine *machine)
-	__must_hold(&_dso__data_open_lock)
+	__must_hold(&dso__data_open_lock)
 {
 	int fd;
 	struct nscookie nsc;
@@ -722,7 +708,7 @@ static int open_dso(struct dso *dso, struct machine *machine)
 	return fd;
 }
 
-static void close_data_fd(struct dso_data *dso_data) __must_hold(&_dso__data_open_lock)
+static void close_data_fd(struct dso_data *dso_data) __must_hold(&dso__data_open_lock)
 {
 	if (dso_data->fd >= 0) {
 		close(dso_data->fd);
@@ -739,12 +725,12 @@ static void close_data_fd(struct dso_data *dso_data) __must_hold(&_dso__data_ope
  * Close @dso's data file descriptor and updates
  * list/count of open DSO objects.
  */
-static void close_dso(struct dso *dso) __must_hold(&_dso__data_open_lock)
+static void close_dso(struct dso *dso) __must_hold(&dso__data_open_lock)
 {
 	close_data_fd(dso__data(dso));
 }
 
-static void close_first_dso(void) __must_hold(&_dso__data_open_lock)
+static void close_first_dso(void) __must_hold(&dso__data_open_lock)
 {
 	struct dso_data *dso_data;
 
@@ -783,7 +769,7 @@ void reset_fd_limit(void)
 	fd_limit = 0;
 }
 
-static bool may_cache_fd(void) __must_hold(&_dso__data_open_lock)
+static bool may_cache_fd(void) __must_hold(&dso__data_open_lock)
 {
 	if (!fd_limit)
 		fd_limit = get_fd_limit();
@@ -799,7 +785,7 @@ static bool may_cache_fd(void) __must_hold(&_dso__data_open_lock)
  * for opened dso file descriptors. The limit is half
  * of the RLIMIT_NOFILE files opened.
 */
-static void check_data_close(void) __must_hold(&_dso__data_open_lock)
+static void check_data_close(void) __must_hold(&dso__data_open_lock)
 {
 	bool cache_fd = may_cache_fd();
 
@@ -815,9 +801,9 @@ static void check_data_close(void) __must_hold(&_dso__data_open_lock)
  */
 void dso__data_close(struct dso *dso)
 {
-	mutex_lock(dso__data_open_lock());
+	mutex_lock(&dso__data_open_lock);
 	close_dso(dso);
-	mutex_unlock(dso__data_open_lock());
+	mutex_unlock(&dso__data_open_lock);
 }
 
 static int dso__find_binary_type_locked(struct dso *dso)
@@ -913,7 +899,7 @@ static int dso__find_binary_type_locked(struct dso *dso)
 
 #define FIND_MAX_RETRY  3
 static int __dso__find_binary_type(struct dso *dso)
-	__must_hold(&_dso__data_open_lock)
+	__must_hold(&dso__data_open_lock)
 {
 	int ret;
 	int retry = 0;
@@ -945,15 +931,15 @@ enum dso_binary_type dso__find_binary_type(struct dso *dso)
 {
 	int ret;
 
-	mutex_lock(dso__data_open_lock());
+	mutex_lock(&dso__data_open_lock);
 	ret = __dso__find_binary_type(dso);
-	mutex_unlock(dso__data_open_lock());
+	mutex_unlock(&dso__data_open_lock);
 
 	return ret;
 }
 
 static void try_to_open_dso(struct dso *dso, struct machine *machine)
-	__must_hold(&_dso__data_open_lock)
+	__must_hold(&dso__data_open_lock)
 {
 	struct dso_data *dso_data = dso__data(dso);
 
@@ -984,7 +970,7 @@ bool dso__data_get_fd(struct dso *dso, struct machine *machine, int *fd)
 	if (dso__data(dso)->status == DSO_DATA_STATUS_ERROR)
 		return false;
 
-	mutex_lock(dso__data_open_lock());
+	mutex_lock(&dso__data_open_lock);
 
 	try_to_open_dso(dso, machine);
 
@@ -992,13 +978,13 @@ bool dso__data_get_fd(struct dso *dso, struct machine *machine, int *fd)
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
@@ -1169,7 +1155,7 @@ static ssize_t file_read(struct dso *dso, struct machine *machine,
 {
 	ssize_t ret;
 
-	mutex_lock(dso__data_open_lock());
+	mutex_lock(&dso__data_open_lock);
 
 	/*
 	 * dso__data(dso)->fd might be closed if other thread opened another
@@ -1185,7 +1171,7 @@ static ssize_t file_read(struct dso *dso, struct machine *machine,
 
 	ret = pread(dso__data(dso)->fd, data, DSO__DATA_CACHE_SIZE, offset);
 out:
-	mutex_unlock(dso__data_open_lock());
+	mutex_unlock(&dso__data_open_lock);
 	return ret;
 }
 
@@ -1292,7 +1278,7 @@ static int file_size(struct dso *dso, struct machine *machine)
 	int ret = 0;
 	struct stat st;
 
-	mutex_lock(dso__data_open_lock());
+	mutex_lock(&dso__data_open_lock);
 
 	/*
 	 * dso__data(dso)->fd might be closed if other thread opened another
@@ -1315,7 +1301,7 @@ static int file_size(struct dso *dso, struct machine *machine)
 	dso__data(dso)->file_size = st.st_size;
 
 out:
-	mutex_unlock(dso__data_open_lock());
+	mutex_unlock(&dso__data_open_lock);
 	return ret;
 }
 
@@ -1520,7 +1506,7 @@ uint16_t dso__e_machine_endian(struct dso *dso, struct machine *machine, uint32_
 		return EM_NONE;
 	}
 
-	mutex_lock(dso__data_open_lock());
+	mutex_lock(&dso__data_open_lock);
 
 	/*
 	 * dso__data(dso)->fd might be closed if other thread opened another
@@ -1533,7 +1519,7 @@ uint16_t dso__e_machine_endian(struct dso *dso, struct machine *machine, uint32_
 	else if (e_flags)
 		*e_flags = 0;
 
-	mutex_unlock(dso__data_open_lock());
+	mutex_unlock(&dso__data_open_lock);
 	return e_machine;
 }
 
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index d6b0a1a4dac9..9f026ccb0eb6 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -354,7 +354,7 @@ DECLARE_RC_STRUCT(dso) {
 	char		 name[];
 };
 
-extern struct mutex _dso__data_open_lock;
+extern struct mutex dso__data_open_lock;
 extern const struct dso_id dso_id_empty;
 
 int dso_id__cmp(const struct dso_id *a, const struct dso_id *b);
@@ -807,7 +807,7 @@ void __dso__improve_id(struct dso *dso, const struct dso_id *id);
 int dso__name_len(const struct dso *dso);
 
 struct dso *dso__get(struct dso *dso);
-void dso__put(struct dso *dso) __must_not_hold(&_dso__data_open_lock);
+void dso__put(struct dso *dso) __must_not_hold(&dso__data_open_lock);
 
 static inline void __dso__zput(struct dso **dso)
 {
@@ -917,9 +917,9 @@ void dso__set_module_info(struct dso *dso, struct kmod_path *m,
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
-- 
2.56.0.307.g5fe7bd680c-goog

