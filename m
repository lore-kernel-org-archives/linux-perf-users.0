Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606577;
	b=5b8wDbnnq2ifqrwdLf8lWlAO25Ly/ExxaQaVfQAtU253X4PW2D97kJe9fyljoYh5EHdf
	 dOEVyBo2gMmpjo8zoJ8ObffQc399Pet6dNgq8ZuZU70WeaJdU2YPlIFJD1bL8Z3i7H0dh
	 bAw0V55Jvvm/huenV20ngzyP6yia0QQyv/V30WCp5qYhtql30HLVJ0y3wkvjpgzc0q2aY
	 TD2OsWvD0IPJbLFIA3WWwHOe5rVAYDI++TtDVvIZgy80cUOVuUURUko/PWssvTjpO+8j1
	 QkxYeuHuGNMwlUYaSdhdjaQhWXfI+UqOpySs7zw4tK/WzCl942bsS/FhFJXa4KN8Low==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606577;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=J6FCJSX/pFQyzHxlmw9wr3kwImFzupV0wPE3xeESIIQ=;
	b=NLOBzjqPyZ0cOkVXoQtcpABNL1KS7EX5zLVmufelvZ8QBnIA3vO+oZFkriWvQgjjFRFp
	 FP/gKfohRTKRgY7msu8nSS6H+PvI1A9Ae/Vpf6ihaYpq7ESdIAMVdgzzyAfPNnq/wXqq1
	 bV2B9iUnF/VDfKBdBr1VWUP2XvFFmLBKcZGpytDSsd8QeBWeFMkv2TtdP2oMqKt/2lijN
	 JsxlrQ4ltnGOMc4OI3s4OCYBH9fqu4/sgQljaPgFZ05rxAqq5dOSIhCNzVUoH3YHgUDup
	 eIqjBJCUpQrFxmuO/c0rJXWczkVR1V7Un8JIEWy9b67bapvQcIN57KVjEco+t2U41Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IAZ8rsVF;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E15B60A263E
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E15B60A263E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IAZ8rsVF
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36a3451ea93so1458272eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794606575; x=1795211375; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J6FCJSX/pFQyzHxlmw9wr3kwImFzupV0wPE3xeESIIQ=;
        b=IAZ8rsVFSiSpoxWJV54g1/gn3ncNNSt8Y3Xia6if7/Tx0gphCFprrLHNRP87XXUiVf
         flxA58njeobFxGBM8oRZHgacoKLRWf5AV6qB/rWainqV3hBkko1Pqlpe/ixcDOYwFZBh
         wKF0i660DkgdBgLAVrCAoC6yZJxb9EjGe9uF3DRnCII9XnPY9svkvMcvtjtSgqFXUxK8
         oLmX891rqlV0VSRsrvjLpxXgC7CwDR/3QMxne+h3p6SJ9TcC/NspF6pKV3D/T7dvmPbc
         2PQxBqRM7Wk60qoWVjEMKMJT6qKyaHn4aK9ocGGe84p6OSmRoaXNHUT9mUf9uSmVFPx8
         nHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794606575; x=1795211375;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J6FCJSX/pFQyzHxlmw9wr3kwImFzupV0wPE3xeESIIQ=;
        b=rRqAZJfwpbPDSN1gvNMRyHcTWaB04Bz5PUceZVVJP9vk+585zUVQf5KK1y8BxYb1VA
         8QMp1TJoRIRw+Prelj7U+IZAkEgi2Zf/wtMmmRYqkuCE5x5IoYNobuNp4DMHLayYLUHY
         if3TcXTKex/ax+baApTgqSsEdz/wvAU9020/3MUnwoGw9iNyvW76EFZM1pdprIDORM39
         ipBxwUlE807yTH4MtS8/uBla02Djl5EDHuO6L/rBSKEr5meb/qOEYvTxo9fwM1hOcbW0
         ElbBr5mHD7uqqEfYUB/scVVUfYEymFDh/0ck0EKE6amsc6fDNM4BCRcA8SxtFA3TWmp0
         rzcw==
X-Forwarded-Encrypted: i=1; AL+hErHQPJHgyw6zHNFpDTTN80uOvCsjJQvxJoqmxyP4FDFQg+l/QKYpxg5Ok9RQRoHPNN9T3c3gUXAd3TpGw+QXJMKZ@vger.kernel.org
X-Gm-Message-State: APuU4Z9QZLP1qU2NIiHWx5+cz/kLHDgCeEqIEQLBaqt3YAfk/QZhatum
	pESrgcumMt4V+SM0mE6jUTaSSS84SIRXbOK326R8R+qcOmfRUz4Mm/8uQetWuXS5GrDQdPV8Vmg
	M6M1sQh63lw==
X-Received: from dycpq7.prod.google.com ([2002:a05:7301:fd07:b0:36c:9ca8:5abe])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e9cd:10b0:351:7e5d:2de9
 with SMTP id 5a478bee46e88-379636603f6mr4068457eec.1.1794606575176; Fri, 13
 Nov 2026 13:49:35 -0800 (PST)
Date: Fri, 13 Nov 2026 13:48:33 -0800
In-Reply-To: <20261113214850.3329699-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113214850.3329699-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113214850.3329699-10-irogers@google.com>
Subject: [PATCH v1 09/26] perf fncache: Use generic hashmap for fncache
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Convert fncache in tools/perf/util/fncache.c to
DECLARE_HASHMAP(fncache_map, char *, bool) and use the type-checked
hashmap__* wrappers, eliminating the manual long temporary conversion on
bool lookups.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/fncache.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/fncache.c b/tools/perf/util/fncache.c
index 04ea150bc7cd..f00367b5f265 100644
--- a/tools/perf/util/fncache.c
+++ b/tools/perf/util/fncache.c
@@ -8,7 +8,9 @@
 #include "fncache.h"
 #include "hashmap.h"
 
-static struct hashmap *fncache;
+DECLARE_HASHMAP(fncache_map, char *, bool);
+
+static struct fncache_map *fncache;
 
 static size_t fncache__hash(long key, void *ctx __maybe_unused)
 {
@@ -22,10 +24,10 @@ static bool fncache__equal(long key1, long key2, void *ctx __maybe_unused)
 
 static void fncache__init(void)
 {
-	fncache = hashmap__new(fncache__hash, fncache__equal, /*ctx=*/NULL);
+	fncache = fncache_map__new(fncache__hash, fncache__equal, /*ctx=*/NULL);
 }
 
-static struct hashmap *fncache__get(void)
+static struct fncache_map *fncache__get(void)
 {
 	static pthread_once_t fncache_once = PTHREAD_ONCE_INIT;
 
@@ -36,23 +38,18 @@ static struct hashmap *fncache__get(void)
 
 static bool lookup_fncache(const char *name, bool *res)
 {
-	struct hashmap *map = fncache__get();
-	long val;
-
-	if (!map || !hashmap__find(map, name, &val))
-		return false;
+	struct fncache_map *map = fncache__get();
 
-	*res = (val != 0);
-	return true;
+	return map && hashmap__find(map, name, res);
 }
 
 static void update_fncache(const char *name, bool res)
 {
-	struct hashmap *map = fncache__get();
+	struct fncache_map *map = fncache__get();
 	char *old_key = NULL, *key = strdup(name);
 
 	if (map && key) {
-		hashmap__set(map, key, res, &old_key, /*old_value*/NULL);
+		hashmap__set(map, key, res, &old_key, /*old_value=*/NULL);
 		free(old_key);
 	} else {
 		free(key);
-- 
2.56.1.703.gf848ed807c-goog

