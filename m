Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794588148;
	b=J/loAv/NmOugvA4lC5P+r1DNYMM9hTsL6Ahqh4Chz2Fg+mWD+UFLXUieuTqAqEmuku6h
	 iSg+vyjh/8ocmagejJJbqg403+vXMjJtponQ8//NtIcskCzamxU/GO0U9Uc7C9DmtD+Ub
	 //eInFJnkKt4Vrd0lVCQsLIxB5PdEf7UjvUuMHoOfh6CTR3cYYb2ZB0j7gJR2HNBFhyCJ
	 Y11AXAhjwJvh9neGLRBFVy4kuNPWa8UtH4fUAFt9J//4KmiJjp4aWqTjYLatgv5BT7aJV
	 pIkV369XP/ji9F58WMdtqDq20RVThgtfBdpYxnt5ZuK5yLfqWYadX9AEg/9HsjfplUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588148;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=drIFIGRpVF4Rwfa4SlpVZ10h9THWcqWMFBwpCDBlAuo=;
	b=NpGgzzls4QeB79l7vb9YWbR2IfsjsVEXa9N3pTFVhJqzdBn+4QMazWylUX2hSvpf44Cq
	 7Vbli39cbWFLDgtQp/5FVwoAmm4ajM//YlFv0VDlicLamMrUFTx4Zc2KASl1XhGvACP/V
	 4rfp7ft5fXuZukymtvcJ2lqUqrt8Bi4OCWoBqyQK812cl5LFurWV+Ls5lFrMOPIjALvbp
	 nPuPSgvBzocfHMDa8E67QsHCe2rENuDznSMexHDskEp1ME3050wmDBsHdtLTAUCJZhjF0
	 XxdiTN0axBaSINOlJbbP18dlzovFG8JKWZoVTfY/rCc+xXJd+fX4UBmk2IzuP8M1xUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=i582PxfJ;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E990860A2623
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 16:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E990860A2623
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=i582PxfJ
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36fa5673fccso2236704eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 08:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794588147; x=1795192947; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=drIFIGRpVF4Rwfa4SlpVZ10h9THWcqWMFBwpCDBlAuo=;
        b=i582PxfJOFjU+m5anCk9n8CPMq6QCkKvDvZ4TCl8/Tgqez57JjhexVsszjbUPji/QF
         3ya3czsPHuqZpf+aHlMl2Z90UkjiQXn0oWBD79VxQCNH4DgmpRSul37p8r2WDfrp6CJK
         LZR3595OpPTyUDqyXZDElh7VC+Y24sM94S/+/KHbem5LyMGD3ZfOw+tRmKPT55QhORNy
         M+iiv9W2EuT0KP/8cgloaSBh4RDQM1jy9njjvQWlYfvppF7szc7zBapD+guGKo+FfAGM
         GI2hSRvuEj9kGmO0ei55qVR/42BS5aFa2wt2ttGkAgNWysI7SBjbfGa+KBVUkod4We63
         l6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794588147; x=1795192947;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=drIFIGRpVF4Rwfa4SlpVZ10h9THWcqWMFBwpCDBlAuo=;
        b=GBCRXrzT+Buy60HguFXFdLWr7MzcYjbVWzdS+Dhbcesol+W93w22DphMYl541NHA31
         VbI1J8WKvJTTE7Ll4dYPCWgX53moS5ZHm3WMhXFAxzI+1sZDbR3M+tlbsyd+LKtZO8ne
         VI0JYqnubnKAZ2T/g2e/bfbHcIIYagsoJpgps7SHVi8Qcp7qwvsT3t9g1XjsD1bsVRiP
         qRkZwjhA76p4w97ZyqPTO04UhrcGV4MKwrD20Ncl4c3vMgJBJdkzFk5HfXfO1KUwWXJM
         aqB7fjZykHa7f/MljzQXCewWQ7i8P6rIBMWOWihGXl71eIOafEYjz8Z4Kw4SYOQfB5eH
         1CSg==
X-Forwarded-Encrypted: i=1; AL+hErGSUaCOXLJ3FgNp+NRO++pj6vMzs75hHZ8Irq+iaPmnZHN30awrdqJB88/Zr3EEIzv+bSi/MmuRWncPotcly5yR@vger.kernel.org
X-Gm-Message-State: APuU4Z93RkSK8unnCHk+JoMZ7meHKmkvX37iiKaoy9T2zpTrnUNZFNqZ
	ID5I/Z3KIWMc6UZx4wUQmFIANUHQqEcSaYPeFj8tyOi8Ww3u2doWr/vFt3cHsqgfwnri14xBYwg
	yw9mYSbKJ7Q==
X-Received: from dycnm4.prod.google.com ([2002:a05:7300:d184:b0:369:7ef0:57b0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:83cf:10b0:36a:79e7:2fd
 with SMTP id 5a478bee46e88-379684b838cmr3033785eec.40.1794588146719; Fri, 13
 Nov 2026 08:42:26 -0800 (PST)
Date: Fri, 13 Nov 2026 08:41:44 -0800
In-Reply-To: <20261113164152.2095566-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113164152.2095566-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113164152.2095566-14-irogers@google.com>
Subject: [PATCH v13 13/21] perf dso: Expand context analysis annotations
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
index f736a94a53a9..d233cc5baad9 100644
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
2.56.1.703.gf848ed807c-goog

