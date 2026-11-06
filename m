Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793948659;
	b=X+hqH4WHT8a0NBT/tJP8a/nGoOHi9nk8moSmZuCTcXn8+oGrEavVDdkEs86zBKSrwMZH
	 e8I/leDDFF9wYitWhYZ51TQbHTLo7n+mFtITUPf3etOWKZF0EqLnmTLVnG5ARAN6kz664
	 yPGH0/ELTWYa0P1kTiVkTus+QAKP+Cq2RCRRhEvJ/ewZwt392jj/mbEI9S+l9n4ULLnpI
	 Hd9xjvydT9kZPi3mkq8PjEnQvKPKuJtcc43Nd1Gm4CJtDszyPv8UBHeTN2lRB7H41BUy1
	 4qJPzkx1CKK5jYUlEmUePx1vHVTCIdpq4YAHsEc9KPJrDdB9dx7wPwHDUD8cEuv77GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793948659;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=EDmeF/auIXKu1URb5xeGAG2MsbxzBhazL93JWwVXPks=;
	b=M/h9MptwkQSCJ1oV7Hvj5T/ArlfVgnIOkdHI12SnxqY8DTqNhnLn8KqCqM+MAaFbR6kp
	 b29f3QfrnPXT7XToLUSF73UsHIeYU73vb/ehRHX+M3zL1o2k+gHUcV6gMqiN+Ue/EcXey
	 IFPtA5D4vOflq6hAQFjp8++KgEiWv1PpQ0XB6+YG9iQPVt968GdksmSpMFHDF52uPj0WB
	 8bp1cYVex7gftJdJX/tvdu2bt58RXTGHXRtFhGiTZv5zpSXs5gk3SZiF2q431c0ctnWca
	 vyI7vZyv3zXXlL79weU4grGgVrEXWn3gLUd+g197WDMKjVQF0lrnx4UPyf7OqLMxDwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e9iAAmEh;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE771606D80C
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE771606D80C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e9iAAmEh
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1b238436265so366957c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 23:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793948658; x=1794553458; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EDmeF/auIXKu1URb5xeGAG2MsbxzBhazL93JWwVXPks=;
        b=e9iAAmEhlmMYl5ZUV/li0yv3XqSJhJEqh84gU8+6cKjuxE2A2xdZasIPTnvdoEvXeh
         r1BWox/LHl5joPwDXmbkGCvpmpJVFG6XA5tN/ca2mqAEaAToYqhocvnQPKSQVSFMzmZ4
         HlH6USbqSha/F47NYMgHt+Ax5PRPua5kLwBCd1NZfh0IOc5bGiTOvPKWr1EADBII/Kdv
         OMcgc47Yz+N9PaMOUIBF2feTmEdBFlSoiKxtdrtd8p2sAPWGH8H11jv0dlOV2fd27hHt
         wfhsLBwSrEtpYH7EjQmGY7tgS4mHS5I0IHWMABzBYT1tlx68RpoUkjcwGlFLsmNE6+Be
         6I9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793948658; x=1794553458;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EDmeF/auIXKu1URb5xeGAG2MsbxzBhazL93JWwVXPks=;
        b=m19CfGtFfnzj8/AESp45TnQk7rMDfo2/cRo92Mv8Bj4aR0V8Br8Lt8nYfgDV5nQI/M
         YRFPGAprd2TxeH4xV0jwYo4MVHSw8mMdlYAfZ7NcPhay5NUdJ70VA74nqy/GUoasoi4w
         0kIu3stPsL1JHgvTNuf5HEs6/M1TDDt2figy4i8/2JcYJEzJj3Oz4jF0DEBcEzBVK/ri
         Z+35OBHzbRLs02xgfbKOlSnOxCxMMLlAiG7AEoVLy6sdRq1SNisNbymr5EjS1BDCGruM
         Q8vSSoKdYhTNLnFN8m5vqgX/0wIQIjBjIelUFNzJ/gwGnBMXT0WzKiLLyzIVOLJxizGZ
         XK2A==
X-Forwarded-Encrypted: i=1; AKwUvBxu5YbpyYxRmWAEgoENglHrxXKEtyQpxAcy82hgm275kOpd4mWrC91soaTbi3YVyM8xO6HYHYjfnLsD4trCeELL@vger.kernel.org
X-Gm-Message-State: APuU4Z8T2IaHDGQKNaJzTABRgTLFQ5pT2zqEAwrfD6ZEbmlmayJzMnu0
	XP9jXtB06cM6zZgJSBM2Mw74rHft7HjArVf+mIcoCfrWmbGZAAHqDaTRnfWkZQTm9UGLLNJSqR0
	8ogTKq46pXw==
X-Received: from dyvs14.prod.google.com ([2002:a05:693c:42ce:b0:36d:d73d:fc3e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b0cd:b0:14c:1f57:3e86
 with SMTP id a92af1059eb24-1b25d3b00bdmr1703920c88.47.1793948657549; Thu, 05
 Nov 2026 23:04:17 -0800 (PST)
Date: Thu,  5 Nov 2026 23:03:37 -0800
In-Reply-To: <20261106070344.329897-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106070344.329897-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106070344.329897-14-irogers@google.com>
Subject: [PATCH v10 13/20] perf dso: Expand context analysis annotations
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, bvanassche@acm.org, elver@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Annotate struct dsos fields with __guarded_by(&lock), annotate
dso__data_open and fd_limit in util/dso.c with
__guarded_by(&dso__data_open_lock), and tighten __dsos__findnew_id() and
__dsos__addnew_id() from shared to exclusive lock requirements.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/dso-data.c |  4 ++++
 tools/perf/util/dso.c       | 14 +++++++++-----
 tools/perf/util/dsos.c      |  9 +++++++--
 tools/perf/util/dsos.h      | 10 +++++-----
 tools/perf/util/vdso.c      |  1 +
 5 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/tools/perf/tests/dso-data.c b/tools/perf/tests/dso-data.c
index 18b7052a2dc5..6ef59929e6c0 100644
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
 
@@ -254,6 +256,7 @@ static int set_fd_limit(int n)
 }
 
 static int test__dso_data_cache(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+	__context_unsafe(/* single-threaded test */)
 {
 	struct machine machine;
 	long nr_end, nr = open_files_cnt();
@@ -324,6 +327,7 @@ static long new_limit(int count)
 }
 
 static int test__dso_data_reopen(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+	__context_unsafe(/* single-threaded test */)
 {
 	struct machine machine;
 	long nr_end, nr = open_files_cnt(), lim = new_limit(3);
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 4dc518f7cb7d..5f4b4cd9a089 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -525,7 +525,8 @@ void dso__set_module_info(struct dso *dso, struct kmod_path *m,
  * Global list of open DSOs and the counter.
  */
 DEFINE_MUTEX(dso__data_open_lock);
-static LIST_HEAD(dso__data_open);
+static struct list_head dso__data_open __guarded_by(&dso__data_open_lock) =
+	LIST_HEAD_INIT(dso__data_open);
 static long dso__data_open_cnt __guarded_by(&dso__data_open_lock);
 
 static void dso__list_add(struct dso *dso) __must_hold(&dso__data_open_lock)
@@ -757,7 +758,7 @@ static rlim_t get_fd_limit(void)
 	return limit;
 }
 
-static rlim_t fd_limit;
+static rlim_t fd_limit __guarded_by(&dso__data_open_lock);
 
 /*
  * Used only by tests/dso-data.c to reset the environment
@@ -766,7 +767,8 @@ static rlim_t fd_limit;
  */
 void reset_fd_limit(void)
 {
-	fd_limit = 0;
+	/* Only called by single-threaded test setup. */
+	context_unsafe(fd_limit = 0);
 }
 
 static bool may_cache_fd(void) __must_hold(&dso__data_open_lock)
@@ -1723,8 +1725,10 @@ void __dso__improve_id(struct dso *dso, const struct dso_id *id)
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
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 1b3f8b84ed30..7f3a6dabf8a7 100644
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
@@ -320,6 +324,7 @@ static void dso__set_basename(struct dso *dso)
 }
 
 static struct dso *__dsos__addnew_id(struct dsos *dsos, const char *name, const struct dso_id *id)
+	__must_hold(&dsos->lock)
 {
 	struct dso *dso = dso__new_id(name, id);
 
@@ -336,7 +341,7 @@ static struct dso *__dsos__addnew_id(struct dsos *dsos, const char *name, const
 }
 
 static struct dso *__dsos__findnew_id(struct dsos *dsos, const char *name, const struct dso_id *id)
-	__must_hold_shared(&dsos->lock)
+	__must_hold(&dsos->lock)
 {
 	struct dso *dso = __dsos__find_id(dsos, name, id, false, /*write_locked=*/true);
 
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index dbd06f420753..cc7e3a42f9cb 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -19,16 +19,16 @@ struct machine;
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
 struct dso *__dsos__find(struct dsos *dsos, const char *name, bool cmp_short, bool write_locked)
 	__must_hold_shared(&dsos->lock);
diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index 93828e660672..fc75c0cf372f 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -126,6 +126,7 @@ void machine__exit_vdso(struct machine *machine)
 
 static struct dso *__machine__addnew_vdso(struct machine *machine, const char *short_name,
 					  const char *long_name)
+	__must_hold(&machine->dsos.lock)
 {
 	struct dso *dso;
 
-- 
2.56.0.455.g6c5a503b38-goog

