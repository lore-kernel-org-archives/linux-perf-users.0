Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795559486;
	b=vy8qDcW8i/zwIjlvs1a9+dc9WDfbR/lX5unQeDoClnlKcZ42tA52JJ5Z+ajpDmzD5G4V
	 PNS6J5N2C7Q3Mkay4gr/4GOkq0vH1U8vLFm6bBJ447Nt2qI8k0YLZhA0z8yX1pc8rbVYF
	 cM4LB/pnX5frXrGMLnukAjmnGh4f0Kt0TDPtCxe6eJ3IYRL/m/O/J1C7eWQoKwYwkCpmj
	 RGFLEdxarG+zGE1yBf2/3vh0uhNiTDhUsMOsFXa3iZ8xkuBeVenRFvEtD9mizGMr/EHL6
	 mAATb9P33Dbb0c5q52mMYcwMPZmuA558Y6+P6ADa2Cm2q4yv3LZmMMON2PSZ5w17Mhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795559486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=lLNotT62feMRZ/N4UsjYkvr6GW2w99BiJ+/SI+mEyxM=;
	b=evXVrhmjQntg0K1n1v1Ay5FaQIakFn1l5yNukvqNSZZohTa2Ki5sB0IS97mb1M4i81Ed
	 CTnacS2yVDmleRDn+z57Qbh7VXgTTX8deJ7S0OkdCCXA/wKowwTYuxl8FIIewYg2ZyAQd
	 8e2wpNogCcR/0zlvBXuUQrVNtvItF5PmjsOwkkydd7sC/BQwKnsB8rkdoZdvKxoO8MGDW
	 lgmpC7UP1q/fGQnFZxy7MfNoUan7BdQAOgpjmJYsw+2j63wWYnP4rGoYE574ZXyy+jwDN
	 GAplGhujzkAM1iA+PNeq8kcuQFcJ+yZGR39HBir+wGPHUt0+wnIUitalf+4MeTAmSvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=B0qQMC52;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5AF606A681
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 22:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B5AF606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=B0qQMC52
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1b3a348a6dbso4120924c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 14:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795559485; x=1796164285; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lLNotT62feMRZ/N4UsjYkvr6GW2w99BiJ+/SI+mEyxM=;
        b=B0qQMC52VuPJ7JzWfvF39jTGdX+R2JQxh5vI2fk/pxg7dmvUAGsYvjtPr1UVFKe1Ob
         WChWki9vBG8QLo+O08AG7e1IeHCqQmZ1cU+UuO8ZZZSVDlQlfzg8c5mg0tMOg18LaQN/
         6W7eKKH1LuPHonGQdXX1fELG4UimQrwROXqlsnwtvVPD2FSzuYoiDuvbiZO1jCBgwL37
         O73FxP6V+0y8c33qRl0biUPlsViudheFAVvr/vG3ydrcHqTFzuKEaMw8fAD9e6gp3oxa
         scsFVBnDhNTNENmVSTMWAvKIhnFGq/1qqxoMN+QsT1FscXGy6LUKiqGhvnkr5ndaCSyS
         zRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795559485; x=1796164285;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lLNotT62feMRZ/N4UsjYkvr6GW2w99BiJ+/SI+mEyxM=;
        b=XK8Edz7uOXGQCClHZfwnpLWoPWf+hVlsHx0acT+zO3829ujcBjgn9lbfvmpmF9+gfX
         P7uriNzAegGerweosGNuWWgWKmny5x946/z1ZivZNjykE28i9fYluYAuxPhBvkE/p5iD
         jcGiu0bYvpv6bWMKCGys8Y+7uKEklVHknHnARlfRT7E1yhxwXZrblCdtDq7TYiFJDAe1
         A5uUSPR7igtaUV5NeKGWb1r+gAJoAu7OAdEQ6KDXT++TcujTWvDntWRZWwaTRLRzlXow
         urH3KEjZUK+IX5h7TfY1DgWzHw2pgXp57Va78CkdP1S0LZp/+N7UfG4lcNRK/37SyxQ4
         Hl/w==
X-Forwarded-Encrypted: i=1; AL+hErGakege/lq7zG8iFLDi92MDAwWX+feomHQwKCheb7Kt1Ixvi4slxn7oro7vVjdeZ5MufGhtOt765G3hhciBV6oY@vger.kernel.org
X-Gm-Message-State: APuU4Z8m4LlHlFlxrgSm1Cgtw5JcovE2aVKWp+AzHKaE+lMnD4qEIeiR
	E0QmlrEZ6b3OoN2xtKHXuAbwiHjUFHK934ZPToaMplnLhKVU0G15SskQGe3ltMwpMMirMFoH2C7
	uBH+vE6yrbQ==
X-Received: from dleb17-n1.prod.google.com ([2002:a05:701b:4251:10b0:1a7:f7dd:f258])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ea8d:b0:1a7:216d:157c
 with SMTP id a92af1059eb24-1b556902db6mr15983910c88.34.1795559484349; Tue, 24
 Nov 2026 14:31:24 -0800 (PST)
Date: Tue, 24 Nov 2026 14:31:03 -0800
In-Reply-To: <20261124223109.820609-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261124223109.820609-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261124223109.820609-7-irogers@google.com>
Subject: [PATCH v10 06/12] perf dso: Synchronize dso_cache access and make
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
index 10b6c847d5e9..4e80ff176914 100644
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
@@ -2372,8 +2373,9 @@ int dso__load(struct dso *dso, struct map *map)
 	/* check again under the dso->lock */
 	if (dso__loaded(dso)) {
 		ret = 1;
-		goto out;
+		goto out_unlock;
 	}
+	atomic_store_explicit(&RC_CHK_ACCESS(dso)->loaded, false, memory_order_release);
 
 	kmod = dso__is_kmod(dso);
 
@@ -2531,6 +2533,7 @@ int dso__load(struct dso *dso, struct map *map)
 		ret = 0;
 out:
 	dso__set_loaded(dso);
+out_unlock:
 	mutex_unlock(dso__lock(dso));
 	nsinfo__mountns_exit(&nsc);
 
-- 
2.56.1.831.g720f3f5937-goog

