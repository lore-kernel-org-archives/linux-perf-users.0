Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700156;
	b=FfHmJRvwFE1RYx9TOwHLDO7ynmxcddfmPm+yLemYP5bUHeqqtfYHbKh4aSYcwVmNZA7I
	 Q9iLoNSP7uc88zFz2wiZ8iWNQxLLz6lITzRX8zNq81K/xhNmqr1//4+hJNlvaGOCtOD18
	 gaIVPbQU+gpab9sVnMZ0zAnpe+ZNYz+DnOL/Rg/eXRAX0ka9NGqalXPSeQuL+OPUPV2Jk
	 0OJfTvpkPU5R+Inv6S5YyGMDGZG3Me7s3Y1qSyXo3PP6h0jCBe+g0dmF/0/M+uVff17/G
	 GvqBn8vBQqvT+izQuLANzhJFfKIDDqXqeoqWfaAviqk3aGJ02yMxrjE4JN8ilFfAHQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=m93d6ML738qvEiSSbh/02KAktLjyqMoz7nlZaRp5/fY=;
	b=3bp28oSibSdZGCCrUMyzeoTngZQbe66i7ft73gD64v1WK6VXtFRRKNvzP1gUkfCfpmAJ
	 eXvcg61CymUZSyy+xPPsX8vKR9xOZl2xGQGrXwW5lt6IcCr6Kosih7yWLEQHJTNaCTt2V
	 mVwrn5WpEtW2+40QtO9hAYyc7yU0iaZSPx5OP1IWAt+GtV98f+TR56Ym8cxe9CC5N19Ng
	 pic0SutuAiXYgnPT9LniLUIRFGYsemdT2kEPRB/CvHcLmnncvIK6K2LYtgqwARvo33/7j
	 J8oajWVmy/UU8gWTvQl4UqLeEkSgXTIjOHH9INUho2FRQ7OpDzclaOYvW1WpX6bvQ9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=rbmiBBUJ;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E0A60A5BE7
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:15:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52E0A60A5BE7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=rbmiBBUJ
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-151ba226e1bso312976c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 13:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792700155; x=1793304955; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m93d6ML738qvEiSSbh/02KAktLjyqMoz7nlZaRp5/fY=;
        b=rbmiBBUJR3SL05JWWWJ162WeHaaOeyyTmao+2aSIDjlRjFJwHiyxM0THNMbFLcFm86
         V40kiWmGI7QT1D31uZwltdXpFSTbzez84I1HxoHd+v3CBFaxoY0xexynotDkxIvzyan1
         be2rnr9Uz53YEqJlWP5JSLoCtUrRbLxbblQY1haGjP8bzIYGHxBWzic1PkiMCRkaIeOP
         ypeBpMhspuocK+/OmH7AHHyzqtyGSouXsCBK+NX3MNtSlnD5cuc6UDpnKBNiK7o4GcjM
         Of2cDYJfMeQ73PFG3ztw678WsYNg1TQe+lLTuhTIG8NeSnDQEW+EOFOwI8vA17e7p32z
         p8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792700155; x=1793304955;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m93d6ML738qvEiSSbh/02KAktLjyqMoz7nlZaRp5/fY=;
        b=dvcXAKeZIM1/72LUtkduwIZJ4xeXlXZilIfgnLmz35C/AlPGVH68F5WrP2hPH5Ja9u
         gUTG11HmO6VegtwvN9Mm4YxLhkWaTTZ2w/HsKRqo9jZ4IUo44MR/rNxSBW+hhlq/caeg
         zV31AQsWCG7EpdGiJRHwBUjSxSKCAAt58m4+zyKtjVaQe7m6sjK11dL98zycNdj2HPh0
         LzLNMEB5cut4thMCkJZWLMRBXzzo76ExYDA7lX9zDOjy73RRHLyzv6bRBie2jBu7Imrh
         D+qqmHp2jsOzYuPaUpMdoanL0N+jNGqUshphLWBg8LCmKdB3yS9D9wOFnFKkSKNbo1C0
         jOeg==
X-Forwarded-Encrypted: i=1; AKwUvBwsr5uzcjxqGPpZwXG+ie6EUedMe5UGJJIqjoJz4kbCATORVsHW9n4RPo2qyBxZboB0685AsC7kPgPRzsuii2ow@vger.kernel.org
X-Gm-Message-State: AFq9FYL+dHHG04NboFNVNEtFGCEJYQ6f5pRLi1K6HNvolHdCypl4wGYm
	NTH3GfDa9xrk0qtq1wOYa0+SemTuqgbek/Dg/9tgenQTUYA+vuYINFzqLBQv2qHrBHRI0iIwTi1
	afXoipYMPQA==
X-Received: from dleb10-n2.prod.google.com ([2002:a05:701b:424a:20b0:18a:a95d:606c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4186:10b0:194:23e7:b526
 with SMTP id a92af1059eb24-195c77a8247mr373925c88.27.1792700155131; Thu, 22
 Oct 2026 13:15:55 -0700 (PDT)
Date: Thu, 22 Oct 2026 13:14:51 -0700
In-Reply-To: <20261022201453.1717523-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021223905.715051-1-irogers@google.com> <20261022201453.1717523-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261022201453.1717523-19-irogers@google.com>
Subject: [PATCH v8 18/19] perf maps: Fix lock inversion in maps__load_first()
 and bounds check in __maps__remove()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, elver@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, justinstitt@google.com, linux-kernel@vger.kernel.org, 
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
2.56.0.307.g5fe7bd680c-goog

