Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418968;
	b=QIsK6NOpJRJR4HwMZGEOjt9+TyTVG9UG5PPrl/1PcfLMF7owhrZjDHwskm3CHM3WireE
	 teZtMF1JjJFUitzeX3Qwp2gy451c2qeeRNuQs1Y9hlGeJQGjXelT/HBvHpZ3ZC54lKBtI
	 Xdnn41cVyJlY4BnU2530zUlNBZoAB7pBzAb2Ay8DOaqA7lsCE2hx1sTmU3dOJnb4NhKlK
	 0KWVkGLCD5VYUt72iS9QtskoZVnrf0ocbvOaTbA0GWh2C6wZqXPtA/59LQj68bHBEUMWU
	 gkzraQLqYVyF9LeYHknpepHqUbuFPEivqkaBahdOQvWE5L3oJEJ2ConAXpB/MJSMwyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418968;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=9yFV65CbovkM9I2fqDRKiujWFrSZndZ/Dg6ysJSfsIM=;
	b=Cc/8Y141mmVzxLRUOZ8jsyldKvUjceL4FOl96PCrGTivKTHzxkaAbVbTPJFDanwvpX4e
	 vAeMFFD+Udxye3/7zHDhr77gfTEeuvQLBruesGXH4HA9qFAEEqXyiTtmaq35dXeB6KRC8
	 CzP1K+gkPH5psxGdYruSsmgnc0nJkEvigW3+zXukb+AviNUJ4H31/qTB3vIYSvTo4pTh1
	 LudkYRJQGfD2Teq3V7xtV5x01NXNr3nGXcbOo6+X64VlCRifId1C9m9SPAfpR5v5olFDY
	 5u/solfjFbMh4npbsOgO8B7103qMRhF2eu+IQ3acSmiqSKNBsNoYC11RlYSTNTS/cNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DqBx9BkA;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D19A60A5BC1
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 17:42:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D19A60A5BC1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DqBx9BkA
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-375f0fd31f4so2224806eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 09:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794418967; x=1795023767; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9yFV65CbovkM9I2fqDRKiujWFrSZndZ/Dg6ysJSfsIM=;
        b=DqBx9BkAQwlyhTcTthscVdKcqOarazMloY7aES0RKs+GrPn3apUVkIp+wfy4RWt1D0
         XqJKmdoPu5idJVGNFNQGWZQEGV9W/j+RZMzk3cxVX0d95WhJvd/B6xNvrgHsyb0eL3KQ
         +zBFOoK4pLqTA0oOqeJbDiLACPoEyaXOkEH9vRD+D7sPwMe8HHHFlWQTZGChFDfvGnyU
         S82zBTaGvPd1dWiTAlNH/1ZhKOxLfOGmW+z2vF7iShf+DCr4EIktPEkL4s61QK62iUul
         AXVa2C8+ogo7J8LuNwrfl51WDvYu0XHLKgYYJc5M5gU6c4N64LB2dJ0KP6C2kZ8UtZvn
         F2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794418967; x=1795023767;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9yFV65CbovkM9I2fqDRKiujWFrSZndZ/Dg6ysJSfsIM=;
        b=03fGAaU+l9gaX8ocHijjvldZuMO51lAKQlnYcMYNYH1cjC/BA/zYWsr1vIQH4hJ+eZ
         G3/gdvMOadBRgKUQHmlRdkdBLWF6XBKY/ZBISQhRt41fPbjCXBi+oW40v560255NxQru
         ahsRGAgEORJe/5nKwc92wMzWoUyDnG0E2dBQzCHG+o8jcHGN8l2ZDRzhJspfOBgLg5YP
         z3lJh902ahnU1YleWV+2f7V20ZrUQx2C/xy7PAi1FgtH4tqT3cEHbnnwl3FCQlvAF+H2
         ZSWWVp9Ao7adTi6Pa1QUddWRhsCntubo4O1wxtNP+iXwV7kWX4+dGrcrkBNL0wBH+phQ
         C9iw==
X-Forwarded-Encrypted: i=1; AL+hErFEEn1B0HRAkup8cU1gIurAQZjMvdA5UmYCP/tfl8NtcmwApQPylGSX7UKf8TBE7tkJTkZvM76zqrqMJd4HImMS@vger.kernel.org
X-Gm-Message-State: APuU4Z/kVtg+yRgWc5j9Yfl+pd5sHTvna8NkgxMmorBpksTEyw3jZ+OI
	Q7sKrwQTIJXOPYFDBxTeuJuIacMpncNl+iIWFR+1BkCGPHRoK1BEUWneuHtH0eLza8/+YE/3QS8
	T+PCDL8LD0A==
X-Received: from dyt3.prod.google.com ([2002:a05:693c:8083:b0:372:7af9:c0a7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:ce01:b0:36a:1452:8dad
 with SMTP id 5a478bee46e88-3768636e3c6mr3668923eec.20.1794418967057; Wed, 11
 Nov 2026 09:42:47 -0800 (PST)
Date: Wed, 11 Nov 2026 09:42:05 -0800
In-Reply-To: <20261111174213.3526604-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261111174213.3526604-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261111174213.3526604-14-irogers@google.com>
Subject: [PATCH v12 13/20] perf dso: Expand context analysis annotations
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
2.56.0.542.g3ef89b7020-goog

