Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70B357F742
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792171901; cv=none; b=hKKWxqkdewtstvIMIVRcmJRvoXxsWg3HF/DUaHCDnkL6UvQrSNuvn2smV8sNwOLTWNkfFuti/UaxMGaHor3No2Xnq2vSjQNdgA+hFJeSDiwZGZ/fE0G8TKPuhTujOqCL9mn8IDGjFDfGR7KwkeN9Cb3fCWpS2HmEdz/Bk3d3Dvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792171901; c=relaxed/simple;
	bh=zCnkTOdmh2uDxf1d7GmWTCvKUJYiRgpWQeEVRQ48ef4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JNct1k4GUOn409j4ulT6dQUhJY0r0jLSQzOyBpiKEnLC0oYYe9Q9KoFQqwPHkGwk1bo3GtuifQ6OqxCDKnOuBNo+zAhs84Rg/cl1Mdua8rkmqJI/AWAcX9ZZyT35R+9MqCbj6445S1mpNk/jLHj+h1Q4eodSCkpo4/xnfIkZLFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NDX/91/5; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NDX/91/5"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-351788121cfso358088eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 10:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792171899; x=1792776699; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RuYawT59glMptZ35wOhbA9GOK99t83Pm42C8J2txBr8=;
        b=NDX/91/5B/ksPMhm3uMnRn0iTrsEGaSiesMY8XQiyTwyoJUOu9kI/sMLyeqcx+v9rK
         K3KLxjAslHoyiTSYBQt3KVgnIVuLbDUNuS7apBtx6/ZXMB9S7eqayD+llckx5OPZiv30
         ygYRA/S9RV9mfCggTILemUuXNE8qUIKE26Z043sWKixCrUZN1Uxl1+XC9NsaMXx0yxaA
         EKu9pAG1ikIGnRajNrdBDE6skk94JsERkZ51mwcpf7KryqZz729CtIPrOdshwoEDdB1q
         GdNrqLrKjzC4FA25Dbyjn5mqEvY90HkCT8koj1aiiwX3emoPj0C6Gqq84mgQO6n74Jla
         dfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792171899; x=1792776699;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RuYawT59glMptZ35wOhbA9GOK99t83Pm42C8J2txBr8=;
        b=2Fj3xtbZcyJTWJ5FteGOWaQqk6hRhfDnkJLlRklV88G79i/KvUufZhcdAF1y5D2DwW
         GgGeRc6h+P5fssL8HIZNGLiCfkM/obCQ4D7RmlxYE2cat1z5V4P0JS42HtX5J1jAM5+3
         8BWI+yCxaZnEwkjkLuNhct4T+hUanm2z8H7/YEeK2MjM98KKZKgo3fd7SAb8J6b2kmuu
         m1ciUtIN8WrYrit/+1csCyZieBXBY9N9K1vIfNbJ9j5vbZjG7s6sfynaE2KiUL70tpBc
         4yuwZaYBjLBTBy7KTmIK92YL4fWTBFSpH/KFozdqIGHBMsK6DK14xJyrTDeKsXrdq0LJ
         gJTg==
X-Forwarded-Encrypted: i=1; AKwUvBxiCbFBCgV8hgz9+dqatY764BnjSe3tftJogTscixPt1J/AXSni6JCpvYCCOfWp9pfimsCj0ibK1/l701wYcWXI@vger.kernel.org
X-Gm-Message-State: AFq9FYJC/ool50JRDZcmm+2YsOaLdoefDqI2GympaVynjCA/BeyK/cwG
	iA8ZzxP6CBsmNv6YkERE2v7w9UNLGbaSdvLSzEs8L7u5TvAYgHVTa+T/x8T05g6g4e28MU2pM8+
	+4NB2DZZGFw==
X-Received: from dlbsv11.prod.google.com ([2002:a05:7022:3a0b:b0:17f:8a38:d873])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f213:b0:144:c122:6cc6
 with SMTP id a92af1059eb24-185139aea8amr814967c88.32.1792171898521; Fri, 16
 Oct 2026 10:31:38 -0700 (PDT)
Date: Fri, 16 Oct 2026 10:30:57 -0700
In-Reply-To: <20261016173106.679725-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013222622.1822619-1-irogers@google.com> <20261016173106.679725-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261016173106.679725-9-irogers@google.com>
Subject: [PATCH v3 08/17] perf dso: Pass dso_data to close_data_fd() and dso__list_del()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, elver@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, ljs@kernel.org, llvm@lists.linux.dev, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
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
index fa5669709eb3..d6b0a1a4dac9 100644
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
2.56.0.212.g129ede20d9-goog

