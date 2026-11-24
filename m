Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795490970;
	b=idvbtU2mqqdCO3/QWvF+oxpS/IWDo76GFoUopADrql75M9MAi3D1F96ah64qpEgM2nWk
	 e7pVBheuse2MMLZd8Pl3Jk1NMQ6Z7qKwTippbyudh+r3n809wP34sUAEUYJFf6TM7pdBP
	 hHgcnL+2nX7Z7tnUm63P5mtCcr9WkRkeYaVtmOOop2a3N/chHRRMo3BRtIWlV9l1nQxLQ
	 DFQGSiCZ77wHFeXwX3cf+rDxAEDsEnMM37HdQ5YAjBtQtLZ/duQDofqVckKYrvb3OIHN1
	 cingdu+6zfF3V5hGSdz/BdQyRGR7XZsPg6OV0ABVs6pUKtg83MmU/LPmdYrs2nh8gEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490970;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=JkzXroeaxuCGRxRbVVVL6+V74Pqks7y7nYFnKgCp/t0=;
	b=AKc3Oq9ZTkr/dPlZb+/d//7SI5ju+a4etA2XLxojq9LOkCEGrrTZtvccOFiGhq5IAMev
	 cuhn0Z3zf/a0de44Wxukzz+Cg9clUwfmChueSjsBfGUHgAmjZc0RCIwesn2wDOOTb7Hgc
	 nN+o7KtBc8AIu/xj+VF6XcCgYCGVbz1+Y2G9LZjT1Mtlfvp//XWvRN7jHnca2i99vH4Vd
	 15WaPPpCTLXtmm6srpGTwE0FXbU/xBYQW+Iue+AZ+NuGO1/Z4+TPllGPcpjHs0Ws8EROT
	 weVsNpr3azXwQ8iXrK1hKCAS5mGhuE0JlXLwnRCleK4k2B6j7HU1QnfiTsL8pzoMDZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JKCcefkU;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8454D606A334
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 03:29:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8454D606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JKCcefkU
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so6525172eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 19:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795490970; x=1796095770; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JkzXroeaxuCGRxRbVVVL6+V74Pqks7y7nYFnKgCp/t0=;
        b=JKCcefkUqnCbyUy6+wlukVLuqt5Jn3lfR6+68IO7tlQx8GXa5pMJbjyMdCKjdZ8dkr
         0BXoyzqj3jHEh3qrkJTpxjZyvZXqjNMVaRKj4xzDknv1DPwyCIRIuewnrLDywJUmoNxH
         HaTnVFzT59eyUSuGakp6ote5AYgwvF47MGSm9REKcMXNOuTnGPZplgvgtAzAXA1ZF0oo
         Gfhf4uTYBvc4ma2qGpgZ8+H8twcxITw+51nqz+RnFCMhdgaNNxz+hGmKRO6NZAMeFBan
         XdnxoBTstkcIMMY5xrmHkB9a5y7Zt6fBrDkHh82KO+VGU/FjB2+ZNB1WjGUEq05CWzKe
         GJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795490970; x=1796095770;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JkzXroeaxuCGRxRbVVVL6+V74Pqks7y7nYFnKgCp/t0=;
        b=ewlv9WYNHwzekf2UhC6x2fLotzZefiAX0Lzag1i/8fA2l1/EI0eHPd+63Bg+AMEhSN
         sfmJJMO+POeJFN5U0QUSFzt9hedNyKLzIAZkJWDFPuqlrGki65efBbuEKhzkwkt2o14y
         jhcuYQg6Awqp2fxiK7AV07ElK0ZwmW8BJ4bKjq8kYyRvL0vnYaLJPv4fRap0cWekEJTG
         ZS3KrEgy0ci9TeIiDzU7HeQ7rI2aLqoV39H25/tPMOtKJV+JuLaVP17p1WiCt5/ZlesR
         inDn9CJpLo7nlMgrFnSCAFko3+suCELO0dOjADUmgLg5ZDeAqY03uQbXoViqEaquKKya
         pmWg==
X-Forwarded-Encrypted: i=1; AL+hErG8D+QWnLZ3M+pGuoDNhamo5gnXY4CqG6yJVW9rJMF2woV5Hxy3FrhCHJsOkQx4pCJrqyd1DUO9WfBHwZ7ARfKr@vger.kernel.org
X-Gm-Message-State: APuU4Z+ub7Te1ZAzkGrUx6Ui4z5XytF6LWFIC7F/mrSxJVHwZq1Lrgsn
	pCGrflYTfbIH/UosWjJAbsRSGDUqRi79j1ekdumbME3MWtcWuTFQLNyiIWocpdud3ca0O18H9a5
	YHi7RfIdmqA==
X-Received: from dycnn7.prod.google.com ([2002:a05:7301:1407:b0:384:71f1:1227])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:d587:b0:381:d92e:ecab
 with SMTP id 5a478bee46e88-3856f25884emr12468733eec.11.1795490969336; Mon, 23
 Nov 2026 19:29:29 -0800 (PST)
Date: Mon, 23 Nov 2026 19:28:56 -0800
In-Reply-To: <20261124032902.3859564-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261124032902.3859564-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261124032902.3859564-6-irogers@google.com>
Subject: [PATCH v9 05/11] perf dso: Synchronize dso_cache access and make
 dso->loaded atomic
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alireza Haghdoost <haghdoost@uber.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Prepare struct dso for concurrent cache and symbol shrinking:
- Split __dso_cache__free() out of dso_cache__free() with
  __must_hold(dso__lock(dso)) so rb_first() is read under dso__lock(dso),
  and hold dso__lock(dso) across __dso_cache__find() and
  dso_cache__memcpy() in dso_cache_io(), re-looking up after
  dso_cache__populate() reacquires the lock.
- Make dso->loaded an _Atomic bool accessed with acquire/release ordering,
  and avoid redundant dso__set_loaded() writes when dso__load() finds the
  DSO already loaded under dso__lock(dso).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c    | 48 +++++++++++++++++++++++++---------------
 tools/perf/util/dso.h    |  5 +++--
 tools/perf/util/symbol.c |  5 ++++-
 3 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index ab0c87d0595e..83611d7ccaff 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -3,6 +3,7 @@
 
 #include <assert.h>
 #include <errno.h>
+#include <stdatomic.h>
 #include <stdlib.h>
 
 #include <asm/bug.h>
@@ -1053,12 +1054,12 @@ static int bpf_size(struct dso *dso)
 #endif // HAVE_LIBBPF_SUPPORT
 
 static void
-dso_cache__free(struct dso *dso)
+__dso_cache__free(struct dso *dso)
+	__must_hold(dso__lock(dso))
 {
 	struct rb_root *root = &dso__data(dso)->cache;
 	struct rb_node *next = rb_first(root);
 
-	mutex_lock(dso__lock(dso));
 	while (next) {
 		struct dso_cache *cache;
 
@@ -1067,10 +1068,18 @@ dso_cache__free(struct dso *dso)
 		rb_erase(&cache->rb_node, root);
 		free(cache);
 	}
+}
+
+static void
+dso_cache__free(struct dso *dso)
+{
+	mutex_lock(dso__lock(dso));
+	__dso_cache__free(dso);
 	mutex_unlock(dso__lock(dso));
 }
 
 static struct dso_cache *__dso_cache__find(struct dso *dso, u64 offset)
+	__must_hold(dso__lock(dso))
 {
 	const struct rb_root *root = &dso__data(dso)->cache;
 	struct rb_node * const *p = &root->rb_node;
@@ -1221,27 +1230,30 @@ static struct dso_cache *dso_cache__populate(struct dso *dso,
 	return cache;
 }
 
-static struct dso_cache *dso_cache__find(struct dso *dso,
-					 struct machine *machine,
-					 u64 offset,
-					 ssize_t *ret)
-{
-	struct dso_cache *cache = __dso_cache__find(dso, offset);
-
-	return cache ? cache : dso_cache__populate(dso, machine, offset, ret);
-}
-
 static ssize_t dso_cache_io(struct dso *dso, struct machine *machine,
 			    u64 offset, u8 *data, ssize_t size, bool out)
 {
 	struct dso_cache *cache;
 	ssize_t ret = 0;
 
-	cache = dso_cache__find(dso, machine, offset, &ret);
-	if (!cache)
-		return ret;
+	mutex_lock(dso__lock(dso));
+	cache = __dso_cache__find(dso, offset);
+	while (!cache) {
+		mutex_unlock(dso__lock(dso));
+		cache = dso_cache__populate(dso, machine, offset, &ret);
+		if (!cache)
+			return ret;
+		mutex_lock(dso__lock(dso));
+		/*
+		 * Re-lookup under dso__lock(dso) in case dso__shrink() freed
+		 * the cache while the lock was dropped.
+		 */
+		cache = __dso_cache__find(dso, offset);
+	}
 
-	return dso_cache__memcpy(cache, offset, data, size, out);
+	ret = dso_cache__memcpy(cache, offset, data, size, out);
+	mutex_unlock(dso__lock(dso));
+	return ret;
 }
 
 /*
@@ -1800,7 +1812,7 @@ int dso__name_len(const struct dso *dso)
 
 bool dso__loaded(const struct dso *dso)
 {
-	return RC_CHK_ACCESS(dso)->loaded;
+	return atomic_load_explicit(&RC_CHK_ACCESS(dso)->loaded, memory_order_acquire);
 }
 
 bool dso__sorted_by_name(const struct dso *dso)
@@ -1838,7 +1850,7 @@ struct dso *dso__new_id(const char *name, const struct dso_id *id)
 		dso->binary_type = DSO_BINARY_TYPE__NOT_FOUND;
 		dso->dbginfo_type = DSO_BINARY_TYPE__NOT_FOUND;
 		dso->is_64_bit = (sizeof(void *) == 8);
-		dso->loaded = 0;
+		atomic_init(&dso->loaded, false);
 		dso->rel = 0;
 		dso->has_srcline = 1;
 		dso->a2l_fails = 1;
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 63c1b7d6f6f8..70a121fd7ecd 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 #include <linux/rbtree.h>
 #include <sys/types.h>
+#include <stdatomic.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <linux/bitops.h>
@@ -343,7 +344,7 @@ DECLARE_RC_STRUCT(dso) {
 	u8		 is_64_bit:1;
 	u8		 bintype_searched:1;
 	u8		 debuginfo_searched:1;
-	bool		 loaded;
+	_Atomic bool	 loaded;
 	u8		 rel;
 	char		 name[];
 };
@@ -599,7 +600,7 @@ static inline enum dso_load_errno *dso__load_errno(struct dso *dso)
 
 static inline void dso__set_loaded(struct dso *dso)
 {
-	RC_CHK_ACCESS(dso)->loaded = true;
+	atomic_store_explicit(&RC_CHK_ACCESS(dso)->loaded, true, memory_order_release);
 }
 
 static inline struct mutex *dso__lock(struct dso *dso)
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index f3a3889f1062..f1abe3333ac0 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <dirent.h>
 #include <errno.h>
+#include <stdatomic.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
@@ -2362,8 +2363,9 @@ int dso__load(struct dso *dso, struct map *map)
 	/* check again under the dso->lock */
 	if (dso__loaded(dso)) {
 		ret = 1;
-		goto out;
+		goto out_unlock;
 	}
+	atomic_store_explicit(&RC_CHK_ACCESS(dso)->loaded, false, memory_order_release);
 
 	kmod = dso__is_kmod(dso);
 
@@ -2521,6 +2523,7 @@ int dso__load(struct dso *dso, struct map *map)
 		ret = 0;
 out:
 	dso__set_loaded(dso);
+out_unlock:
 	mutex_unlock(dso__lock(dso));
 	nsinfo__mountns_exit(&nsc);
 
-- 
2.56.1.809.ga0b61035b5-goog

