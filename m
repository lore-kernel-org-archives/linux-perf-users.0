Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622405;
	b=Fv0dh76rLJjCCzRGKF8ZlPnKTmb9DgABd6+Pzv4qgC+ow7+GPqsCln1ruWn6Cj9KEYwm
	 4c+8FuuDsED3ze6kkPRnNICMDfPEWyYn8MjJAzGqOdv18s+GPP7R19iyw0AV/EBJM4Y3z
	 i1UdEoV2H21XdLmyRVAdVyWgpr3+FCSLh8YhmwAZGOrYqQCbMPkfacn8NseZrVeYR3qec
	 5pbKvv1yZTnDSXT7yiFgvOX7Xlygh9g0xdzG+sCXpCW0G55VaJX9rwejPeoAhUgX/dEgF
	 TXKH64mTxtrNpqfWB9feRfOeZMRohLR+7/2VBoYnKSs5Yif981Yr1YruQskioBfD2mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=4N6lG/9faT9ECF/bBopwnnQUqKUgvyQE1Rye5tZt4hw=;
	b=u280g5QIgaFFG3p8cHBaxvawI5e/C3ccFYsM8PrTSLYeddH5lEHvfDzgoR2TSiMwkZtV
	 agsOYBSvIXOMHIAhsSSZ7GBy/t+6ofyzrcInAESM2vw4cHo9usaUyqHozN+DPP9HJGsb9
	 y8Apym7t6mlJl8SGUBzmiWo1Jrbf18+Qd0lm0I80J8GdPCtWgshTyHq6NTPVtHiXOdr4Q
	 UsmGKKLN4FmXPIpFiWpSb3ELeM3MqDAgyVxtW+KYruWYvMvgzi5aljJZhK7xcjj1rVCte
	 Uh84xF8oMQPd6A/yjC5rtTzsg9bo0PHjsYdGzhTb30mq/DBFazuoNqm2Ls5zW1JA6sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=mDAi6naM;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A5C60A2600
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:40:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8A5C60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=mDAi6naM
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-18b5ee75447so4598999c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 15:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792622404; x=1793227204; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4N6lG/9faT9ECF/bBopwnnQUqKUgvyQE1Rye5tZt4hw=;
        b=mDAi6naMWf/YDg+OgEI121OjdBsSj+jPDyqanERchN17bho8pzqg+0li3AJwK4tB7+
         AR/tEfDyMQ8F5ivDqA8AgRQNLlT5UOB3XpaqJ1yxLwC27A9axZxA9Kei5V7k3XRClXaw
         Yr98aPRXpbctl3lfihjqOFar8rsXX6XqzPmjjHLieNgC1T6hVO/Vkqj8butY7nt/VoZj
         72ZL8uaUk/8CNQDm3JIbUvBy6Qy3LkMPZBQ/knvPsHwBbc+QU2UW9tYl/TjmFW/Wn+Rx
         d3KKkDQRCQmxqqLcAfKaSPg9UnI49AZrYzbbtLkGlt3lEBtC3coDd6CrRQwFgM1i5ycP
         VN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792622404; x=1793227204;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4N6lG/9faT9ECF/bBopwnnQUqKUgvyQE1Rye5tZt4hw=;
        b=g1tlrU+5j3fUwHLwJ0L7BmFnM4x9srpzR0qSZTt8/GybQz8Zz38+7QmPBAdDB0u+53
         H3mup/PnwGksXOFbxWjnuRwm13dC8llO0DMhvcc63cx4XCc84toRZRYvx9Ik/fNlq1MT
         Kh9foIKXT2bs2RrrEey6kDta82MDqMGfCx1N3EnSXWRbyu2ZexwcJXiF89bAWvrGNOJZ
         b0rl10KicLUKiHs+verd1a4CBrsGheti9OdIrTp+nNwZ0+oVNj0PEYa2yXhQ0gLOfepx
         kUdfzYVj8cc+5lyZmVaV07AgoqxGw+Vq+ksHJU2o9iBCrRyfFWw6LMqCzhgBNj+NOCjO
         aKEA==
X-Forwarded-Encrypted: i=1; AKwUvBxuL42kFPg2MD65imnhXfohZ0rjBeQDw/OCfV3JvRShO39Od8O1iI6CFe++dbdrbj2KTBr+XJfAgNsm4aRquJIt@vger.kernel.org
X-Gm-Message-State: AFq9FYK0NwuP1RkfwsfGX/1I9ytSM/KUY9CDz6eJbs0e7O1M19+fs3bI
	PTaWt91U6eq1gi00W4uPXfABgAMEFkI3JrU4kEN3xqMRZiqgIOPBEThrqit8HUgYfHaBQYc2kdD
	UV+gVmYcuHQ==
X-Received: from dlbsn13.prod.google.com ([2002:a05:7022:b90d:b0:14f:4204:735e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:5f08:b0:177:9a5b:a89
 with SMTP id a92af1059eb24-190a67fe0d1mr3720865c88.29.1792622403745; Wed, 21
 Oct 2026 15:40:03 -0700 (PDT)
Date: Wed, 21 Oct 2026 15:39:04 -0700
In-Reply-To: <20261021223905.715051-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021171044.155240-1-irogers@google.com> <20261021223905.715051-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261021223905.715051-17-irogers@google.com>
Subject: [PATCH v7 16/17] perf maps: Fix lock inversion in maps__load_first()
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
before indexing and removing the entry, and remove from maps_by_name
before calling map__put(maps_by_address[address_idx]) so that callers
such as maps__remove_maps() that pass maps_by_address[i] as map do not
use a freed handle in maps__by_name_index() under REFCNT_CHECKING.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index f808df2fe77b..e947506c60a5 100644
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
@@ -548,20 +549,27 @@ static void __maps__remove(struct maps *maps, struct map *map)
 
 	/* Slide later mappings over the one to remove */
 	address_idx = maps__by_address_index(maps, map);
-	map__put(maps_by_address[address_idx]);
-	memmove(&maps_by_address[address_idx],
-		&maps_by_address[address_idx + 1],
-		(nr_maps - address_idx - 1) * sizeof(*maps_by_address));
+	if (address_idx >= nr_maps)
+		return;
 
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
 
+	map__put(maps_by_address[address_idx]);
+	memmove(&maps_by_address[address_idx],
+		&maps_by_address[address_idx + 1],
+		(nr_maps - address_idx - 1) * sizeof(*maps_by_address));
+
 	--RC_CHK_ACCESS(maps)->nr_maps;
 }
 
@@ -1459,10 +1467,15 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 
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
2.56.0.218.g1ec904b173-goog

