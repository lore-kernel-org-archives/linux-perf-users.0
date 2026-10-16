Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9EB47FB19
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 22:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792189117; cv=none; b=AE1iP22BjPMdTFOcTzH4IQE3FMSOko9jMoMta3pv889O7a1xxX5EwZFsE8Njf3hL76EuBCmn8G1ufwV24q6MvAaWaIUXFx5rlEFHX9DkDPHXvyr80OAVFa24dlNN+iu3On0ehauhY53pMC4ZUcfiAqOyjlqt8KrHG+8hJFVdZcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792189117; c=relaxed/simple;
	bh=yvJtqhI/9d/q34H3RICcBHm5LlIhdwGTqRFIDwkADkA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T1h9jb3305ogTtnPGd5NrsahdzIePlEOKeHXjxYr/KPt/lGEeN982dA7coggXtswbAkn1Tnaux4uA5Hzk9h1WwIYYSgVDD1rECUdRMkM27qLrw643krCb7r5ftODUOZcoGw6FAflWFs9G0NPa7vckLH6wfSe+NQ+VsT3fj735eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rNfoZ3xb; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rNfoZ3xb"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-151ba226e1bso610923c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 15:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792189114; x=1792793914; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3mxM05Ni0M2UlqzYItHva6zjMOsFxpKbe1J+CpnJE0I=;
        b=rNfoZ3xbhb0GMUCsdi+7QeXyKMtCBB5WHxJQe7fjHAbJ/TOxLHF/tNNbBiiXYFg5pc
         F05SmRgnLu9gXmVQ/tlXZxHbzNLyjVJFWYUPwMhuZJ1CQo1ktWFf0sSD2UZCyHrPBdzg
         /isdtS2I5/nSzBU6yKPtDkTKQqpP57w6cz4ZrtdLTY+5HicTgBnnssD/B5wyheHttq0U
         XdqRk/1FerQJZPcR4WVoY4nsjFakO8yWCyGpz0Y4GWaqKADHDHXrOGm+za0j8NHAjQnC
         udjoT0FWjDytgYbWBpfrUHpddF0XQOZoftoafRI3PTC1zWUmGmJ4SULXuVDUWSeKO4RH
         eFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792189114; x=1792793914;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3mxM05Ni0M2UlqzYItHva6zjMOsFxpKbe1J+CpnJE0I=;
        b=ZFBjGSr0PJmeOQKiavsdP3s9L9UkfN02Uq+kO5QzH6J9HPH/HLGaDVq7vpVJAOh4un
         2T9HwUhEq/6YldZa9h26lYm7CQzyBqLewBgip98V9+ww1go+s1PZEe/Qbq9wXXV1X0n+
         G7Mauxesq7qTu+l1hAZgFMbow3lAYAghhY24vqKwfA+Ax/EwJoifwOs6Q3o6El0dE9We
         +y8HyAAmaep/xlFD/5iJCfZH2JtJj4Ki4C+VVKXK+w/hsF7f/KZutRKpZGVBmiFipBNx
         gRksSudmvppEjKNfwqXUiwhpcaDY3VB3yPNiuny1j57VIuk68Zngi2MRsybbCm+g5wbz
         sq1A==
X-Forwarded-Encrypted: i=1; AKwUvBxFUFVlUXjlUiWhPS/yaC9EgTePgmMSOKL2rlScjg2P9pADGUQTZdyp1xw53LVfRNhpV5Ca8tO7Kha1QsWSzgyc@vger.kernel.org
X-Gm-Message-State: AFq9FYLyzrk63YWDAndU2h+eO2HhqoYZ5tmW3Aay81+VOCP1IkOUYPjY
	FM6CYJ/uK5dnrjH7ylLEH+W9ogeE9+qWi9l6B5BfEYZYGLMDAShQM959rlnvWWqpqZgfLWGnn3o
	EEeX+fPsKYw==
X-Received: from dldyq20-n2.prod.google.com ([2002:a05:701b:4554:20b0:17f:c757:3afd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:454c:20b0:168:e942:4e62
 with SMTP id a92af1059eb24-18515691e7amr1319527c88.40.1792189113884; Fri, 16
 Oct 2026 15:18:33 -0700 (PDT)
Date: Fri, 16 Oct 2026 15:16:52 -0700
In-Reply-To: <20261016221700.1282659-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261016173106.679725-1-irogers@google.com> <20261016221700.1282659-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261016221700.1282659-10-irogers@google.com>
Subject: [PATCH v4 09/17] perf dso: Use DEFINE_MUTEX for dso__data_open_lock
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, elver@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
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
2.56.0.212.g129ede20d9-goog

