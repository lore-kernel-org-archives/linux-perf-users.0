Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825983;
	b=zqKdLf3PLOQW4N4MwxhfXyyax4ZMStlSVQvoHuSjHyI9BVmdgUgGgo3lmc2MVEbBrKjQ
	 t0zCkCVHuFkpnBFZNXl4YTWRtR/sY+VPZQcFMk+C/yZ1o0j37RDoB7twosFMLvtDIu5It
	 PbGmNiX6MJIlka5Z48l8yYJLEEpEaMT2nC7Hb6Y03J2qxI9q5YMqhU8tSmbH6kX7NeVkZ
	 nSARUAoNvDzbVRIquhmdsmwW8KeRtB5XhB+b4gUQL+uRngKkS4f9gsUMlOVuesmxg4dkA
	 8lCAgnjSm4Gf4BUzWc6Ko+rFJj7DBcuCqFK9DyCyJd3z3iTB6NpZZWOk7q+OVGdp0rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825983;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=2a4uTEfYyENfXkXgldFnQHQSxFOjVMgANt9KL9E1Kps=;
	b=eHZcwN0l+Ub7FgzOGBkdw5G52jyqh8EeP3iS0sha87rtCM1APNSqRTp2TgeswNfLB75E
	 7aIRtvaD39UH4qWrTPc5Io+lDlIeRrnqjcQRcgQ8ZXgZNeUTNCtnzzTc7+bIQhsO3T7Fd
	 hGyBGW9SbpfoKZU5/fpvDFy3wZ+SLdPB8TZLnHOVx9sQGFsoIiXyAnt/ahLc7RRznFLbK
	 1iyJHCF7BKiMmAG+yh1rCZObVRKts04I6GRCuMAWBc7Zm6UicDFW37aZTCaIiRppLNKqq
	 Ayw7bcl/jfLxdpy+78AtzVlrI9Z0fEPaSvu9PhncveTeNyu2bcOV1Yvslxf0qxY8g3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gkk+r+YT;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD8960E4818
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 20:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CD8960E4818
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gkk+r+YT
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36a223755e4so3901211eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 12:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793825982; x=1794430782; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2a4uTEfYyENfXkXgldFnQHQSxFOjVMgANt9KL9E1Kps=;
        b=gkk+r+YTFEutHm5maEy7JasojIWmY3NYSdRE8roSyOtUJr6Vb6NtJI9dozMnCIUZVC
         hq08LywZo7du4FavTPLJoHXZX8G35+JAc5b8cKQvwL9GhYSgpvPfVq5TKcF1BcK/92Gt
         ONq+UBewa1XToyLAcXQjD0tnW7CZY0Tfp0QVTL7wxREHDJR9xnrxNsMs9MMB0UPWK2dq
         ZpFtvLCp4URgMeFDxzMQfwH74PDiAwdIkFLBnGffd+nl+ZA+FaAd5Xi8D294MB8JS0N7
         Z3KDKM2PuwL5UYJ88rTzgrgiGj6VIE+yRl027gV3GdEDwfgQ3o5f4FNZwnnQjFbCatnL
         NmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825982; x=1794430782;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2a4uTEfYyENfXkXgldFnQHQSxFOjVMgANt9KL9E1Kps=;
        b=Bv9FE5C3iuGeuW1/qdRsKZ0q+x6TJ5xyFp39kAFzV/secR//AY9sSTDjTmjULrTUxu
         WigdnNltRRF4KTymD0oxs+ecSCHo4RYq58y0Wo1CS5g/2TXXQ7iXY0V6KKy5M3CKR/Lb
         R2xKQKY67OW52rv1ntgoIO2qW5HgGGOLfrziNOBDw26vtF3jHJ7EbwHaVjZiYjSF/p49
         mJNjI+t6Jj/AsNAVrebr88noldn48O8BbrBiFZ81MyoanckvoZbtqJDw+4xwXtJ1utRc
         NTkrzWcQ1rLpkLuT/rnf1BLIjhAz+gdWv+rj92a+1l/2hhu8CFBzwc3mHVkvZWTsRWC/
         nSCw==
X-Forwarded-Encrypted: i=1; AKwUvBxZs7mvBAHVZGyjegwSfZOZiMVjytqgcjdwhIlrYyMuCHBfvazCrRWRMu/RwKlQoRX39TVGCaEHkhnxopury4R6@vger.kernel.org
X-Gm-Message-State: APuU4Z/7VJG9PdOgyzVENYAkqLe9vE6RkDdUsgTXa+dQ5VAQTM0vOLEl
	MaIS31ZqOMA1obHgRuz+HOYU/Xd/yLWRH0MF9pzgMtW6pTQxz0hpOYJX9OIqHubTtaa76lQZPVl
	kSQBUq0lM4Q==
X-Received: from dybmh6.prod.google.com ([2002:a05:7301:f06:b0:369:dee2:2b2b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:88c9:20b0:36a:18e2:64c
 with SMTP id 5a478bee46e88-36a4232bf0fmr25918959eec.11.1793825982110; Wed, 04
 Nov 2026 12:59:42 -0800 (PST)
Date: Wed,  4 Nov 2026 12:59:01 -0800
In-Reply-To: <20261104205909.2078411-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261104205909.2078411-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261104205909.2078411-12-irogers@google.com>
Subject: [PATCH v9 11/19] perf dso: Use DEFINE_MUTEX for dso__data_open_lock
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, bvanassche@acm.org, elver@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
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
index 0c18c0f3ef88..9e38b3b69e9b 100644
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
2.56.0.455.g6c5a503b38-goog

