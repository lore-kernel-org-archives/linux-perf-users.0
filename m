Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7FC4B921E
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 22:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792189134; cv=none; b=SQFHk4R3G29fZsMyKYSkutXhboUl4ZlS206qMWm1KVYgkaeUAnOeQCzN4PiAZ0IoczPyOVVG88SwYZjtIfTnsfTRx52zOl/VbZRYIvGVKuy1jK4+DngoIIdT7YwivLTdqZpm1tBGKV4fZGDzY1rDCjGb0t79ZY+LcCAPJZgX/os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792189134; c=relaxed/simple;
	bh=X9NMUUN/PE8VFQes15e35IRr9fY8ZZsea9uEfdcgfJA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dQ6i69ukZxHb3p6IdCxMN5EKC1Sv4qfT5yQFF7qqnD7zhgMOSASdAG0JRiiCJpRj3SUVQtri5ayhDZzcPAN9/7Sf/s2ZwmRDdnu4Xr1cB3JtvBcNtXl3IGkLOexYA127cvOXFD95lr5fhQfjG+FVGjkNtZZ1JUMCvZsBtfCNhjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QqKNCCCm; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QqKNCCCm"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c0d568830so557955eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 15:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792189132; x=1792793932; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hARxlh30ES9N4VBeaC7/4m4u2XE5g1KyZIf4o39eBbE=;
        b=QqKNCCCm9ZMxtp4FxhRoRxtuoFS1+BAYQYvJzjECGpUN67COn4xWTpRU6tkovfMuQ7
         4Tb23HhwSThIqKJCFoN8F47KRMxKSrIBfGkwtwRqUacP/znkv9Yq/56jy7biL2zOE6S0
         5BbXxutWNeghVwFk+WKzwyR9aYnVM4Zg75DxYHqhGP69MM4U63IXjGDjlSMBELyhFQnA
         w/g7RBCidBlH44eKP1Zd6Jvu+1GAQOgY+3yMzLZnDIn1lOsDkk6HxYJ8DGqTH/40fck4
         FHCA0DeTe0XQdgE3tusTJhzxdpKpBhhhY6bVZ9Ytz9qowwoa1pkDgy+CazDM768hIr3S
         U7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792189132; x=1792793932;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hARxlh30ES9N4VBeaC7/4m4u2XE5g1KyZIf4o39eBbE=;
        b=rWSznR0XDbK3bBIp0gU58Lu/U6uX5LrKU0Z96l+PkSOdGYBDQZ9EB6C/2oq55lgLOQ
         t6GxGqfxPO9tfaiUUkJqKm0NLYn9UW8SSFV3J1++sk+I2Es2/nk6DR0vTmu4m41d0Wka
         ViXSFoxnA2JVQZVG8t2NxoZPZUpBVw35xaXYRNgEznXo7IWY7S5MZrsUHMYBsezo261R
         N/sgaUNbssTyvMW3VdxgBOoMsaCRMuQ8RM8jCvrb8kn5ZIJL2xs8tIHCAews38bIPpj/
         zNWVZ43iga7vbUQpIyzKMITYES/RvQjW4a7wrLWq4yRmaH8qM6NXd64DPSXCN+OTD2s8
         8suQ==
X-Forwarded-Encrypted: i=1; AKwUvBy9PfoAgGlqeplnRRBHCOXmb5M89qWuoL9k9eUSJFJ5sk3mV3QLW/PsHR/vUOK+z7i5iR9Yu2ROlzr19Kqej4LO@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6HsEQGbbZrlEZZ8lPQwdHhWU9GsrzwTMBJN1/BYegMvz4nhjY
	htgpytaBn/l+w1/ndlqc0mFw8PNfUZgThWKQxsYjTZ7uHNQ/2EpauxBtCwgJC96W3YxAaM5NI7A
	5QJenauczkw==
X-Received: from dybmd43.prod.google.com ([2002:a05:7301:182b:b0:359:261e:1706])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8092:b0:35d:8c3a:38a8
 with SMTP id 5a478bee46e88-361a2942646mr1432826eec.39.1792189132086; Fri, 16
 Oct 2026 15:18:52 -0700 (PDT)
Date: Fri, 16 Oct 2026 15:16:59 -0700
In-Reply-To: <20261016221700.1282659-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261016173106.679725-1-irogers@google.com> <20261016221700.1282659-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261016221700.1282659-17-irogers@google.com>
Subject: [PATCH v4 16/17] perf maps: Fix lock inversion in maps__load_first()
 and bounds check in __maps__remove()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, elver@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, ljs@kernel.org, llvm@lists.linux.dev, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

In maps__load_first(), take a reference to the first map and drop
maps__lock(maps) before calling map__load() to avoid a read-to-write
self-deadlock when loading kernel maps inserts extra trampoline maps.

In __maps__remove(), check that the index returned by
maps__by_address_index() and maps__by_name_index() is within nr_maps
before indexing and removing the entry, in case a concurrent thread
already removed the map.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index f808df2fe77b..acaf93c7c206 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include <stdlib.h>
+#include <string.h>
 #include <linux/zalloc.h>
 #include "debug.h"
 #include "dso.h"
@@ -548,6 +549,8 @@ static void __maps__remove(struct maps *maps, struct map *map)
 
 	/* Slide later mappings over the one to remove */
 	address_idx = maps__by_address_index(maps, map);
+	if (address_idx >= nr_maps)
+		return;
 	map__put(maps_by_address[address_idx]);
 	memmove(&maps_by_address[address_idx],
 		&maps_by_address[address_idx + 1],
@@ -556,10 +559,14 @@ static void __maps__remove(struct maps *maps, struct map *map)
 	if (maps_by_name) {
 		unsigned int name_idx = maps__by_name_index(maps, map);
 
-		map__put(maps_by_name[name_idx]);
-		memmove(&maps_by_name[name_idx],
-			&maps_by_name[name_idx + 1],
-			(nr_maps - name_idx - 1) *  sizeof(*maps_by_name));
+		if (name_idx < nr_maps) {
+			map__put(maps_by_name[name_idx]);
+			memmove(&maps_by_name[name_idx],
+				&maps_by_name[name_idx + 1],
+				(nr_maps - name_idx - 1) * sizeof(*maps_by_name));
+		} else {
+			__maps__free_maps_by_name(maps);
+		}
 	}
 
 	--RC_CHK_ACCESS(maps)->nr_maps;
@@ -1459,10 +1466,15 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 
 void maps__load_first(struct maps *maps)
 {
-	down_read(maps__lock(maps));
+	struct map *first = NULL;
 
+	down_read(maps__lock(maps));
 	if (maps__nr_maps(maps) > 0)
-		map__load(maps__maps_by_address(maps)[0]);
-
+		first = map__get(maps__maps_by_address(maps)[0]);
 	up_read(maps__lock(maps));
+
+	if (first) {
+		map__load(first);
+		map__put(first);
+	}
 }
-- 
2.56.0.212.g129ede20d9-goog

