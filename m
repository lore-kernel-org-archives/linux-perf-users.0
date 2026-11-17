Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941371;
	b=0xj1Pb0U5jJUKMzN8EYyHeNqjv9YoTyC+ve/USbFik332ZU3ZmXOEJkOkY/dXnUWjslZ
	 s7J48lkT6oa/XbBvhnD+xQEqi7GB//eok48z8VQuCFxlOp+n8M06xEqzuPN07LBMdEubM
	 MiNybqgDluj+OoPi+GHTCC3U9IjvVn1lnRISz44llspgDUcSYlmJjnaag+0hDFZLTmjaR
	 0rxRA/eKwaSTia0S/d6BVvogJqBybR1nUUwshOXwmLA4GJ2DC8zyMNMcaMqyj8WeyXn7+
	 tb4UrdVK4IEKND5c2COQyxX/cX6myOB4Dr55rTKXka7cL2v5Yy3Tt5DFZIHndHF9xHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941371;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=DNRVhU0fY8REp6mWqw1ufC/qGVxasW3xTXkil1uOiMI=;
	b=n2S9ZkqT9noY234A/YApIIu4AFEN4myuwFnm5fDuehNsM+NpqSszcEBk2MJ+aVN90wD6
	 AzN/su0M/cPLG16NouWizgNLozYEC3Ot1CCtLDLszuB+zqIbl9tn4BVwGz/gKZhwJjXsV
	 qJ7oZQQ1EvqmhBVTBFGTSJvAVvDJhoK9IK3yeOsL/K6E8IbbWBUUWaMUXCbsmNMrquMMW
	 g3TTPpfffT9mP99SZbt7ccgFQ4lUkh4WwoE2scvl9eMjYHm9f1TntpQpn3AI+FguGUrIb
	 XgbLKuGq49lEYf/uf1eOs1KArCZflvTHQwicGnQu83zNmzsZL6BXWpaPyQh7UJBop4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pbVeeakN;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A650606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 18:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A650606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pbVeeakN
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36a3451ea93so185725eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 10:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794941370; x=1795546170; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DNRVhU0fY8REp6mWqw1ufC/qGVxasW3xTXkil1uOiMI=;
        b=pbVeeakN0a3AmZvxkStpQRa3DBr9ZgkKs+9nnYY3/0xVzlKbxHRE780hwmubN2FKEk
         zbI918RugL03AQMJVKRp+V3r7sV93kt7/j7JUYdCYrkWPLNBvB309tvi10sl3cObOQOS
         jv9aw8SLCxZalI8jR67vqLhiPHW6QPR0FN3hUSfBRR69Ssx3OheVEzajewxusfSM1MSN
         dLGu6FxW/YifQ9W4V7GmmQps52J+Q70Bb5CIdJ/WvbhmUuAJjmJmt+Zc6ofGu0J7rynJ
         M4CIj3axOLUbjlupa0F2aqjaiQU1FUUF9Ay64UDMp/DWD3Cazwe0FJdaCvUKvC/vTd4d
         ydzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941370; x=1795546170;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DNRVhU0fY8REp6mWqw1ufC/qGVxasW3xTXkil1uOiMI=;
        b=naYWY7FHzzXT/mfBMyLnrQwOOCAHlNe4tc6DBPhWvcgRMBTmOzdmDNJujZccXABQYr
         K/Z5qGB4z0ONAfnRjjjI+9Mgv4FT/VhqsaM+rV2aXvT3ZvAxcSyfQVthFtxnbDorWJiD
         dEBzkX3ZbCeex3kvf38GApB57YHfZGKPlm7G4P2O0M6bX1MoRbFfb/LVDwiycpINfTop
         74Dc/3QfOaST9YFkS3xm3YYBkC62sAzdoPdQnb6X8M01iJdQC7Jn9KTSzA1sW8eDxrQB
         mB40S4yASx9RKD/tzh14cb8el14bCEFnYfDIIwLqclsSgHVIKWR+Ijkf7/mtVFDVnGJU
         HMSw==
X-Forwarded-Encrypted: i=1; AL+hErF4BNRAci2h+m03HZnyrUm6zN/CTyTT76jhhT2TS8o+3EPIvGfvEGGRvpjySL+bk2fXUhYaEtGcufk88AbOp7+b@vger.kernel.org
X-Gm-Message-State: APuU4Z9mBQd65jpOYnLq8UKxOar4G9f1iBA6WUhIBybvF583Q4b5l4Oj
	Ckj7dpAKnJX0gNEVVZg82bucCaSZbmcb3ZUxeU27iVoSaPZ1eURp6ysdpKNo5GJ5iMh2XclB2AJ
	yG/Mqns2oRQ==
X-Received: from dycrt13.prod.google.com ([2002:a05:693c:2d8d:b0:36a:e67:fbc2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1610:b0:351:7e5d:2de9
 with SMTP id 5a478bee46e88-3827d52c432mr279379eec.1.1794941369871; Tue, 17
 Nov 2026 10:49:29 -0800 (PST)
Date: Tue, 17 Nov 2026 10:48:34 -0800
In-Reply-To: <20261117184844.99889-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117184844.99889-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117184844.99889-14-irogers@google.com>
Subject: [PATCH v14 13/23] perf dso: Expand context analysis annotations
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
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
index 1c938d1b11e9..49813424e4ee 100644
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
@@ -1726,8 +1728,10 @@ void __dso__improve_id(struct dso *dso, const struct dso_id *id)
 			changed = true;
 		}
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
index 4ff38cb5e2cb..7a56577f4ec8 100644
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
index 8bf81e2c9e78..fe28e346dc2f 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -126,6 +126,7 @@ void machine__exit_vdso(struct machine *machine)
 
 static struct dso *__machine__addnew_vdso(struct machine *machine, const char *short_name,
 					  const char *long_name)
+	__must_hold(&machine->dsos.lock)
 {
 	struct dso *dso;
 
-- 
2.56.1.703.gf848ed807c-goog

