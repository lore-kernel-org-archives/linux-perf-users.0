Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514252;
	b=OrZQNeS3EXlaFHoG22xexDhcHkVMR6StJGn6Ac76Jjyd57mL0hLxkk2cDKcs0wzUc2E1
	 Om1+OfKEtjTEF1V0FrIq9UQ+ZVVDjvTl3Ybfekf5sJcYk49QCRPcXUXHdueFgdt2Un+EU
	 KZTb0iVP6BiQq3q4ZgZNDMq5hOByq11bs7oj3tkiQbVypkTLVVyArBefheDW05lR20P/K
	 yzSAGligX/EVjpJIb883FpgHHh273PXagwwVe5fIH06HjqIZ4huRP6kmIukz1ZDsYWXar
	 A7NWpbqGwrZey1of4VGIM5DCBs1ZSVsXwvwJXHEXCmoghAcF/fEY3550tnR8ZP5p3jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514252;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=hARxlh30ES9N4VBeaC7/4m4u2XE5g1KyZIf4o39eBbE=;
	b=oobh35sV/1hSQTck3qSv2ZF1hWkLSLbVJ717ZWgfejqpxyWhzl6eITI3uI1WGZn39iRQ
	 nBsX5mYuonYbVkV9OsQ9wOF+8ET8fo5svqSBGs+sBlcrSQDfK72ZYBZnQ5T//cbEK2zNx
	 +2HTwUPX1+SodRShghyAhOuzR7GPvEL+7fqF+ZlCWX4QYsh+RFba5ApmaLTg2YANxKavK
	 tViGM0xNMlrSN9sunnSEa6v33pHCo6Wb42NaiN9fVWDIPgOc246pmqtOl7wBtAJyOJkAf
	 S97Wun8xEpMIdeEULOWqyKJsupLOPAlwJFdLUyeqBE/4H1e9Nm28EQyeISa/vdxqZSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Ql7+R7Sg;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145C560A4ADB
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 16:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 145C560A4ADB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Ql7+R7Sg
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a05a4396d2so1904901b3a.0
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 09:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792514251; x=1793119051; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hARxlh30ES9N4VBeaC7/4m4u2XE5g1KyZIf4o39eBbE=;
        b=Ql7+R7SgHfGNWLQv7+BZuEZA8CIIaQtqr4CUnv2/9kVM5mKhqRk8NmrFX81PELjQV2
         lMKXgkCa+O1C4AmgSihF/usNHyE+PEOIuuFrUaEpXjU41ay+jp5lXteJdNDHGI+gpcKg
         xrBpIKHWKnfLad4gebJm7nk3iFW/5fNJ1StYeDMH+B32UpuyO5ThXMvegzNIQNGLp8xC
         0q2+cETx8QI4dI5enfC/635fNzNPmDh6z0MI5tIXwdw+7ytolchvXndjQMZ/dWvUIfoX
         E+pPjvPU9kyxC4CIBC2r82y+lYmiFljbTgQgypQoMLC3Ckm9yyfTh2wNzjZU8cpL3LRy
         HUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792514251; x=1793119051;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hARxlh30ES9N4VBeaC7/4m4u2XE5g1KyZIf4o39eBbE=;
        b=W6Z14P9pWXEf6GHgxo304E68Jh14tClTLl3MoWDaKDXxkzhisiklxn+h0GKNVphHTY
         0+LxkwA+78VrnRByekS8nszFkYVjA627ffGT/txC1PTcha3cMbWZ5Mq0pFr07h6JWI77
         l9RrjGj6BmlOc3S9Y3fbz9pOCfibd1ZWgP+NmgWvmJTor3XuV/X6dlqs7HeyBbTC8U82
         htr11VrpKbhDy7m/JA95jXCHIh2EuNy5clhkV4JcKAn6IlCjss49FJE6m4JidXsPMsVC
         2hyc4r4JXCPVdxw0MKXlMq5e6gT+DHBhLshnkysR5tWUIcJAcdB4IFZLGK1M1C5QEUP5
         TwWQ==
X-Forwarded-Encrypted: i=1; AKwUvBw2RLRp9T7krj9Q6JESZ1cCv8LgILwpAdPh2g3G9zCe0/8doIrnaVIgsYXWo6vr8q/RLtOLdLOux7SGUFkxhkh2@vger.kernel.org
X-Gm-Message-State: AFq9FYL0G3ZRqc3e7LGzo5umYjIFE2H6Kwk6PBPDZXt25njJUq8RQQgr
	aL6OmFAAacKaoXvy5FyUhVDfcP8tLWCYv0SkD1hDGuwZsPaYjBGqWSeMmT7SRcojQnqIEBwMBwT
	SoKRktW4Nlw==
X-Received: from pfbij10.prod.google.com ([2002:a05:6a00:8cca:b0:89f:a557:42ae])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:8893:0:b0:882:6d80:e5ad
 with SMTP id d2e1a72fcca58-8a04b711535mr8300262b3a.9.1792514251065; Tue, 20
 Oct 2026 09:37:31 -0700 (PDT)
Date: Tue, 20 Oct 2026 09:36:39 -0700
In-Reply-To: <20261020163640.746159-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261016221700.1282659-1-irogers@google.com> <20261020163640.746159-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261020163640.746159-17-irogers@google.com>
Subject: [PATCH v5 16/17] perf maps: Fix lock inversion in maps__load_first()
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

