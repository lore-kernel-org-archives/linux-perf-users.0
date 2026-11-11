Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418961;
	b=sOuRfC/bIvvO60ooZjJB8jzh1SvJflLj6/nfwCTeWoAkhEPqa2VfumPalG33CkfFYM7u
	 Ou0s+AY2e90gBRQ+4FNc4kP/gUvm8+LYnWRdyFZf8HaBgwbhyAmnfoZx2uaIv8gDO4V8s
	 MKS9pw8t5XZ8xOPAijdY63JHULtJkyKF4oAzTUddsLVN+o1/CWHuB1ohV3sCHEoOg2ke/
	 UgKPQpoTD2O/AeGRJ1tOcrCs/QSiFmxJcDyTg/EWc2jsoxCHzrpbcj4ClA5wOn0QdItrv
	 tJzFLlMmAaZSldq4EH1UfsHwU7Eab/ZZ8Mm68ehMM+p7+9fNCNM3bmNIpZi2Fha3oVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418961;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Q33zUquzaxzwFL46zB7BQvJ6nt/PPHjvDq2pz1nWxko=;
	b=f3ckWv5vVDrcRFWlVP2VzcrNoblcQDpbcXAoTdClTXWnexPuHEttw/ub6V6z4XA1r7VF
	 65cxzSCyltW917yAzZmT/aloCZ4OxbT5+H7n1d3/BOhE8p+cVNXMDwHv+00UJuQvujI05
	 Plk5PIgTAmJLXIV0FvUAQw3Bb2ToPO4tjzPoqqZDeI3fjj5usTSOo8oKdb2bQ0ugB4/C5
	 AEDsD2wJv+KcUaVaCVvtQV3oGYaaiahu8z+4u/6UJLYJ8j42fddR/dIN+puLeSRAE5l1B
	 PdUb/T2zRjwWrUOsWXK5klxiej8jf9AHMLElo1/7/0BuNLjXImvs+zV/bTb+no28AwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hcWXFxMz;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261B260A2610
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 17:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 261B260A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hcWXFxMz
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1b3ae327c55so52504c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 09:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794418960; x=1795023760; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q33zUquzaxzwFL46zB7BQvJ6nt/PPHjvDq2pz1nWxko=;
        b=hcWXFxMz7XODvdK0V2Pka6XWcyXAh/2wuo9M02uzyDTgy0QmzL9ZayZWyBUDtHYGdR
         JpNh3fcsBimUJ1SBL9h/v5fv2Zu0dmpyGWGPrwCKJ2D0xyjKnSyuiOfeUbqmBDz0p9Lk
         LuqWRFmBBu0o7qBI4Hz8z8DTwMMSRSp4r3kmi+M1+vpdgqvkAHZwV0U60OtHpS7/+pCd
         Rh+koRSariK+ExbdGt2yjwnpL7PYL3k3VfLZKnT/yQy9KUQa5Ar+b5vyB2KinHJ+pkNE
         /BGGBBtHuNU6KsjQCnWfRQw/oNJlX5sksR+SADpmZc/JjniTwv6FcGj9zoAsrolpktA4
         r3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794418960; x=1795023760;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q33zUquzaxzwFL46zB7BQvJ6nt/PPHjvDq2pz1nWxko=;
        b=AZvBfL/INkDXdWIXD0qHBX/J5O/+0uOSGlxQe2PVUV2YGHvbPIBFdh3z3mC7GMZyO5
         TRe7Ig5938rvF1L+k0IU9QtPAxSrodmVInZPDSnAQBtHRJfa1pliHJWen8uA/p7FoMsi
         1Ya70NCJFow4LD0F5uRr2YVREugMnRw2m9t03t0fx7l22u/Udh95ZEwU82xb3CmJ1GMo
         2gZp178tfs+99izJaRiF0PmI+8dYs44KPKYf8hY1py8h5AqamU+6pjriKW5cWfMBRA6i
         dw7QOnN0+ZJaLmThyxY9kc/tKGsczd4sD5W375SVhf3/BT0uvvKWW+8jzmLWpViMo6Bk
         PnUw==
X-Forwarded-Encrypted: i=1; AL+hErHolBZvoyMN6WiOA7VKjB3Z3HZT0vGhs2mWVUP5VOM26E7j5MKxvG0skpoi4C0/j7+hGe5tj6GvueWKNZVVJ+yt@vger.kernel.org
X-Gm-Message-State: APuU4Z+oG/8ztKueEHsraTmPFMMy778VTAz7L4QBPXNmOrXVtzGa+sSC
	omrXx58feGy2W+4r0ZKR9/PT9F1DBjDkC2CinYI5pchRzfg2GpzsyUA3Oh101CzjNcJbaCWTyrz
	BplWqzdVzRg==
X-Received: from dlbtu7.prod.google.com ([2002:a05:7022:3c07:b0:184:b43a:63ac])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1701:b0:1b2:6b17:28e6
 with SMTP id a92af1059eb24-1b4f5e83172mr125327c88.9.1794418959955; Wed, 11
 Nov 2026 09:42:39 -0800 (PST)
Date: Wed, 11 Nov 2026 09:42:02 -0800
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
Message-ID: <20261111174213.3526604-11-irogers@google.com>
Subject: [PATCH v12 10/20] perf dso: Pass dso_data to close_data_fd() and dso__list_del()
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
2.56.0.542.g3ef89b7020-goog

