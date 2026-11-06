Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793948653;
	b=ENTzuKelYYuE91nw+1PdNyaeBDfa2rbOo2ngHqeSl25fhpXKUkmzI8xAGR80DbBwEbOK
	 mkmAXNIfSLxGQlEn4GcqfkKhfIXV9hrkwnnKk0WWf/TigFdUrKsB01jK+M//vFZakO/35
	 MVKVoyR7elDjE7d3AcnKn6AEzncNRZgfaskxcKQMeqqAfFLyIehCeJi3st6DUvYyTMZQy
	 Jre9jck3pmqWbBIO7vL0CWlvYwDeCoeN9SelyJ9PurXmcUDt1cHxJdPdhR1rXLrbnCcP9
	 34PIiyiHTzpMtxNpFTNgrkb/2KNNLqC0x2U80WR0Hwa5EEsGYacMG+ILqghQsu8dxPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793948653;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=zj6YsX4Tj4P8BXnzaEP353OTjciTY2+kaiklZ9lU7mc=;
	b=UdCi72+7uPvzMxQ123PuMAnoibuqgEaIhzttSFqPQSkCQw2tiBqpLY/tSS74OMopu7St
	 H6ppmN83Ka+fS66Jvol/g9XT4IzpT1SLIGtc8HvC7hYBgGzaTKf+tL/PRhyyQBP5PdnAd
	 2+kjKkKgAOyK9/L1wBsFD7fkfbMqwMSSoWbrEQ/zM2FJtpEbBy/qk4lXYpL7vml5ob7K8
	 B60o5LCFikBmYRhxhaAVxcHJGjK8zvJsRZYb9aMZUykjQCgmLItzy/PKDYPnkAV681Gg7
	 kq1iZV0CSU88MMRr18z82FRr/c2hWniRpIW8MgRQz1AitJV6FOE2EwP947EI0u4lgnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=b0ikmBKS;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965B4606A336
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 965B4606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=b0ikmBKS
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-341eff9e381so771208eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 23:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793948652; x=1794553452; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zj6YsX4Tj4P8BXnzaEP353OTjciTY2+kaiklZ9lU7mc=;
        b=b0ikmBKSveGPnhPyK0Mwb7J1CfZWwPrM3pydafQMyn3ugiqroOHvE8+kMvW4qticSk
         3kB7ZhnvSHWDLyxWjHkYZrkHwNaP/+NisiFWAuz2B5gemhcxwTUKvZ5vDSGQ3rjgiVvp
         iKDKkt9G7sjE3t1D9pl4xzl2WZOmHhnuUtDd7MPEgzei8Y99u6Qf2oZgId5JVeFDqHGS
         CX4t8J3L4fbBFpN3VQXEUq6l1MMo5JVvTPdanw6hQP2K6+A2u+Ckm74y+r3Fjn5SCRkU
         HixDSr6OM3BJRlT2CkmoQgofzMwdjfWfjGXfp43wi9Pbuto+fIxcey+/0JgCVTjZ9HAO
         jiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793948652; x=1794553452;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zj6YsX4Tj4P8BXnzaEP353OTjciTY2+kaiklZ9lU7mc=;
        b=Illbj0HrlKPpf2HoL+xat9r4dekHTQSUpetwbuOC+W4rwHu8Dcz8xf45ySBUDcx87S
         zkh9v/wN8bYSmepFbis4YNG1EPD732nxOu0DNbQSAZUb+1lD1E0lsqF0XyRLe3SvHlVT
         0eYQtcSZRY+YtjO0YSHXZQSMoVTE4PUJursuQmbvUjV4MaNLuqw45rlQ8Z9Fe7IhyaRA
         kTzyxnCISDT6vKdmZv1ZvEjnzuwZCp0Cq0zTlWrn86Am7bksqPUpHi+NtuvJTMKQDCqK
         nAKsS9u3785TyBwrbpVCqHySSKw4nfk6kKUzkOo73kKzoQaa4lRDENGenvic14jrPR+4
         rPUg==
X-Forwarded-Encrypted: i=1; AKwUvByzD0rkGsQSsIL6/ZhBUXMiWRqw2odmzVzYjchEt6Ca3gNz82hbjSUsap3aZuM3tRkfiiAsyxftS2AJpEjASpVH@vger.kernel.org
X-Gm-Message-State: APuU4Z+yzC7UbxlVgb0VglEkTK38wnRdAVa/MijU7KRGMYl/b7Px4bdt
	w7O506xomwWSLxmrZfwY0G3nMirehJhkBuUMHwR0oyNHQlv42PwQfHW2UWpD1FewtgU3mJJl1h9
	SHTUQJ2Rh4A==
X-Received: from dldyq28-n2.prod.google.com ([2002:a05:701b:455c:20b0:1b2:48fb:f4d0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:a8e:b0:19a:8e3e:530e
 with SMTP id a92af1059eb24-1b25d32ea5amr2314713c88.8.1793948651489; Thu, 05
 Nov 2026 23:04:11 -0800 (PST)
Date: Thu,  5 Nov 2026 23:03:34 -0800
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
Message-ID: <20261106070344.329897-11-irogers@google.com>
Subject: [PATCH v10 10/20] perf dso: Pass dso_data to close_data_fd() and dso__list_del()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, bvanassche@acm.org, elver@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

close_data_fd() and dso__list_del() only operate on struct dso_data
fields, while close_first_dso() retrieves a struct dso_data * from
dso__data_open. Pass struct dso_data * directly to close_data_fd() and
dso__list_del() so close_first_dso() does not need to recover a
struct dso * from struct dso_data *.

This removes the REFCNT_CHECKING dso pointer from struct dso_data and
avoids dropping _dso__data_open_lock in dso__list_del() to call
dso__put(), preventing lock-order inversions and races during EMFILE
eviction.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c | 44 ++++++++++++-------------------------------
 tools/perf/util/dso.h |  3 ---
 2 files changed, 12 insertions(+), 35 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 24ff066b9878..cbc4f30e7f23 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "dso.h"
 
+#include <assert.h>
 #include <errno.h>
 #include <stdlib.h>
 
@@ -544,22 +545,14 @@ static struct mutex *dso__data_open_lock(void) __returns_ctx_lock(&_dso__data_op
 static void dso__list_add(struct dso *dso) __must_hold(&_dso__data_open_lock)
 {
 	list_add_tail(&dso__data(dso)->open_entry, &dso__data_open);
-#ifdef REFCNT_CHECKING
-	dso__data(dso)->dso = dso__get(dso);
-#endif
-	/* Assume the dso is part of dsos, hence the optional reference count above. */
+	/* Assume the dso is part of dsos, holding it live while on dso__data_open. */
 	assert(dso__dsos(dso));
 	dso__data_open_cnt++;
 }
 
-static void dso__list_del(struct dso *dso) __must_hold(&_dso__data_open_lock)
+static void dso__list_del(struct dso_data *dso_data) __must_hold(&_dso__data_open_lock)
 {
-	list_del_init(&dso__data(dso)->open_entry);
-#ifdef REFCNT_CHECKING
-	mutex_unlock(dso__data_open_lock());
-	dso__put(dso__data(dso)->dso);
-	mutex_lock(dso__data_open_lock());
-#endif
+	list_del_init(&dso_data->open_entry);
 	WARN_ONCE(dso__data_open_cnt <= 0,
 		  "DSO data fd counter out of bounds.");
 	dso__data_open_cnt--;
@@ -729,13 +722,13 @@ static int open_dso(struct dso *dso, struct machine *machine)
 	return fd;
 }
 
-static void close_data_fd(struct dso *dso) __must_hold(&_dso__data_open_lock)
+static void close_data_fd(struct dso_data *dso_data) __must_hold(&_dso__data_open_lock)
 {
-	if (dso__data(dso)->fd >= 0) {
-		close(dso__data(dso)->fd);
-		dso__data(dso)->fd = -1;
-		dso__data(dso)->file_size = 0;
-		dso__list_del(dso);
+	if (dso_data->fd >= 0) {
+		close(dso_data->fd);
+		dso_data->fd = -1;
+		dso_data->file_size = 0;
+		dso__list_del(dso_data);
 	}
 }
 
@@ -748,21 +741,15 @@ static void close_data_fd(struct dso *dso) __must_hold(&_dso__data_open_lock)
  */
 static void close_dso(struct dso *dso) __must_hold(&_dso__data_open_lock)
 {
-	close_data_fd(dso);
+	close_data_fd(dso__data(dso));
 }
 
 static void close_first_dso(void) __must_hold(&_dso__data_open_lock)
 {
 	struct dso_data *dso_data;
-	struct dso *dso;
 
 	dso_data = list_first_entry(&dso__data_open, struct dso_data, open_entry);
-#ifdef REFCNT_CHECKING
-	dso = dso_data->dso;
-#else
-	dso = container_of(dso_data, struct dso, data);
-#endif
-	close_dso(dso);
+	close_data_fd(dso_data);
 }
 
 static rlim_t get_fd_limit(void)
@@ -1858,9 +1845,6 @@ struct dso *dso__new_id(const char *name, const struct dso_id *id)
 		data->fd = -1;
 		data->status = DSO_DATA_STATUS_UNKNOWN;
 		INIT_LIST_HEAD(&data->open_entry);
-#ifdef REFCNT_CHECKING
-		data->dso = NULL; /* Set when on the open_entry list. */
-#endif
 	}
 	return res;
 }
@@ -1918,10 +1902,6 @@ struct dso *dso__get(struct dso *dso)
 
 void dso__put(struct dso *dso)
 {
-#ifdef REFCNT_CHECKING
-	if (dso && dso__data(dso) && refcount_read(&RC_CHK_ACCESS(dso)->refcnt) == 2)
-		dso__data_close(dso);
-#endif
 	if (dso && refcount_dec_and_test(&RC_CHK_ACCESS(dso)->refcnt))
 		dso__delete(dso);
 	else
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index f6c60bafcde1..0c18c0f3ef88 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -261,9 +261,6 @@ struct dso_cache {
 struct dso_data {
 	struct rb_root	 cache;
 	struct list_head open_entry;
-#ifdef REFCNT_CHECKING
-	struct dso	 *dso;
-#endif
 	int		 fd;
 	int		 status;
 	u32		 status_seen;
-- 
2.56.0.455.g6c5a503b38-goog

