Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825988;
	b=4w8nW0G2DbTbV9j+znvjo8FP2g7asHwDz2Cm0oYAkjp6DpENob21KZpdtYTyQkVw7ERA
	 DzjmfiNRTOmQXGDZdp78L3GJMXTXgcf51/GqFzRPrIf5nULumYgG/owUDc8LCnZHVbVo/
	 T0AUL5+9f8GLWGDTfEoe1l2B6/q+cIYBcVlD+wXADfu/5AXLviQge8/t2spXfi8AD5760
	 OI6C2MFtOt20+oUKHv6K7Te8a0ANFJRB5cIGU67JyHUyI7RavoyPZg3ntckaYUo2Se2EL
	 LbAzTLdj56+Q2n5MtnJOwRwY55bLSdpygYv2DMRnWFVLW3NAnURBhHGxOH8/3vzoj6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825988;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=5knpg2BfyPt4TIsiJMtCQDFUwwpSbTM1+VEalA98Iuk=;
	b=uswLyiH5eBIMNvJMebvHEuICtsj38SRS5Ycjk1E4nAs+bx8ybmSnFInMoUvku2NaqBY+
	 e37RqDyU2ULgdnyZQo8TTfa1m+e2qwv0EZg1+93phTybqZq35vVR/nu7vkisPKLOTBGya
	 S10j2HSIgJVQIxk1nDv4UcFM97ZdPxcizMQ79IhtHccF2kBYDxJ+a9swmKvc7dClARkDS
	 zqs1HUPQ3HAiLWOEnza6X8ZLtLqIVEuSwF1IBqlmGViF3cXW14nXUnGecfO1aWOo/wHZh
	 eF/9in4W8F9ZU1GwWE+APNRsYdqQLuPWIcn58YABAC/3D8VoNWrL/i0ea6saDQsV62Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Bj3Ysp9Y;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4587E60E4838
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 20:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4587E60E4838
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Bj3Ysp9Y
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso2043466eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 12:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793825987; x=1794430787; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5knpg2BfyPt4TIsiJMtCQDFUwwpSbTM1+VEalA98Iuk=;
        b=Bj3Ysp9YLmf6/9q+kBcZU9J2ywmRw4iFNHR3Qz3qFQz0b79LROhwtlyw4RUKBLQ7lU
         esKQNPDl+w+BOwhdloaosmzd9vfDr8RifLsH15yiZmLamgubDNdGULz0yJX/MvV7PhDe
         Qmp3ANqROfKNg4xUCG9yrghRqxc7BORlFXf6JTaWI+q+QUUinLABSz6qOp5rSZDwULMN
         evw8FJABerdLLYRvT56pj8IBStCh2+zO9KEXZtHxGRUQ2oK45mInxGJZy7Y1yt1wBrNh
         qsDP51Z+WARfRUKkZ5OI5CP7OcPcS8aFv31IAFvu6jL0DvEQC7zDUSYCAgZAIvVkcAaN
         5adw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825987; x=1794430787;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5knpg2BfyPt4TIsiJMtCQDFUwwpSbTM1+VEalA98Iuk=;
        b=VzOMU76z2zicrv2E0pMTO7/IhgC8OKfZrRUx0DPszHExvX8aeQAskTsRu+Vm8kZVhB
         oLWP0Qeu+1BkJkeUTlqrlbiSLsBa+/JN+Y1eyQaA2b6NR6/d5V6s+T2gDjeZSy/sUUPu
         sfB1rcVA9nUywIu9v0SXVyNypQnVGtuCVw6WFGSLpifySqUCAcBNdGT9Q+arexZ3Qai5
         UTc3RXgC7T0PFb1dZjmUhQP8/qT41CGOUFED6IR5yzOO0NBKrtbGf8JNmtMBifnuoRTO
         N0Zq0jFoEZTKIaUL5yvDOHJ+FblORJlzjaNhwx1GIPnYIZkdeCbFmOssFeS+yxO3QFJR
         D7Yw==
X-Forwarded-Encrypted: i=1; AKwUvBwuPBZlXBoCgi/UukmJFA2sPZFlYfyh0i6zYBoK7ZPWpN00fTEzBqi401OfuVq9Ut/lTThJBHi34Mv3+0guJ9qd@vger.kernel.org
X-Gm-Message-State: APuU4Z/CF9Kjtyab/tEo9eAFZEw/q9sYn3PrGvt8J2UxpAsGrnYpSOb1
	scQzZGt7O+IbuOoVvj12pvPFHqECUuKqNFaZZEFneNvhR6x7DQWF/BWL0emoHsNe1xQdmYdDuDr
	WJEvOrHbbDg==
X-Received: from dybvz4.prod.google.com ([2002:a05:7301:7a04:b0:369:fc78:c914])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:4154:10b0:369:f4d7:19fc
 with SMTP id 5a478bee46e88-36a424988abmr29598058eec.41.1793825986989; Wed, 04
 Nov 2026 12:59:46 -0800 (PST)
Date: Wed,  4 Nov 2026 12:59:03 -0800
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
Message-ID: <20261104205909.2078411-14-irogers@google.com>
Subject: [PATCH v9 13/19] perf dso: Expand context analysis annotations
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, bvanassche@acm.org, elver@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Annotate struct dsos fields with __guarded_by(&lock), annotate dso__data_open and
fd_limit in util/dso.c with __guarded_by(&dso__data_open_lock), and
tighten __dsos__findnew_id() and __dsos__addnew_id() from shared to
exclusive lock requirements.

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

