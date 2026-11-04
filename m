Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826001;
	b=z+FpPnSfh3YZVRdbFbiuDe+ruhux6aQPKP6/c1wlY0bFJ6irfDUMoSC6JRP/8+kCaWrR
	 Az7TWvW/PPhiygqZKQ/NQE3x4pypdcUAhBlwllnWKYABtSibTHwXFVGXAhSJi8kJifHo7
	 NubEqP1r8r9xCHoIsf3Lu31g9pDQo2rNTN/G4hOfOEJxIpL54cBRbCF1YoMafHnhRENJ1
	 gQWSOEyUvSUBL9LjeKvezOLUuZBsXzZGn88+WEXnV0cFfcYVaC9oiMG8KyE+fh5p3cNeU
	 CAWbbirOuossCUpxUbmG2eXYLqcwmsyH0C+lmD6F3ReEcyFv88bKMaW9GK1NlIezxkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826001;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=rt/D2V0pPqFKKFuRewSMDlrES2za5EAC5J3ia35lEA4=;
	b=CZfqsHciSdthgFyRsX0B3hndk1Y8zGxP1O/e4i5g538h/w5Wl4CZcNimRtv7STH6YgEH
	 vtrpHNXLYiVE641Ms2HnnMmvh2WXA6HDbUVeWlBAbl96xtNagUA8yy91m7dGLxnB0reoj
	 Kk7Y2SBq3VRpH2uwdt3QTlT4LxIP9Cyycj9XUFE8xnsqzAQT/84XrzzJMFbIeHAm0kxsm
	 vQziRXdSpt8oUW9v+3VmLM8EfqgH7lUHhWHX8mHoTlZPakspONVgzEjAxZAdoUEVsn1/R
	 NqX34+VWsHuByWjVz8WuaPBKG+esYAXM0G6+OVd4ZSYecL9DuJGvAyohI+YcS9bGisA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hTYsfX6s;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD71609505A
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 21:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FD71609505A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hTYsfX6s
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36d2d353a5aso8366eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 13:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793826001; x=1794430801; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rt/D2V0pPqFKKFuRewSMDlrES2za5EAC5J3ia35lEA4=;
        b=hTYsfX6sMT+vbRbCxP1AWIdEU7DHmtlHys2mJZE4YcK2GxLM8823NQrs9HE5vPfCI8
         LwQUFKRiDk0dipm5PnbTbpPmIGQ1Mbk494KR7mLWzYtfyCATE6KNPOPL8BCUmtpqii1c
         19BPbjxmz3b3r1L6AkrjKy4BaowOCPADaEjKiGoIIFePjJoja3mCOO6DA+IG9aBmWLMQ
         On4R8R9yj4SLoiFR/jopZxVpVikIspqFwL4w9TrrxVgJg97oSqr5RIKc8kqusLdaFFgw
         Jj2s8MyXDCw7IoVxYi5I06Lp+Q0Kxg+GD1QZu+KPNta5B36q94AwaIQ6UToxTTpAFNay
         5Chg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826001; x=1794430801;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rt/D2V0pPqFKKFuRewSMDlrES2za5EAC5J3ia35lEA4=;
        b=wTLXGTbVHSi027meGi7O04I+KAYsupWefBY5Kwr5yFzCTKFeYV+1eSPq0QT1cBiLuk
         NlNh6/yql8Z/GWqbH0+Ywm1UeiQkrx3pX40Qhzt7FB32nnkJSsGzfWxtK53KNcRqagH2
         76YU2LV56fPikCp29ZqP37ekS118ACEEviwLW2VLZbaWv8X97JMoOgrq+wpKVDamIIrG
         YxXCN5o77X+BpwlUMFxezv2BzHT5S/rK4rIHBWzT3q9BNROzPP2WEeGl/QAes5sgZkrD
         MJGhZto5juHhDEFRvOVMcalpcVRBla8ueVzjBDd/9DF0rnB9889OQ/uHOqQhfekvUItd
         Hong==
X-Forwarded-Encrypted: i=1; AKwUvBw81DQsE1a5bzqbilU0s13SlZMxFKGLP0dGWb5yf/gyKvwx/XpTPK3wJw4Gm9ooJJJup/cFZ8fZAr3Lyo567JJG@vger.kernel.org
X-Gm-Message-State: APuU4Z8e0APDJJqT6iUttFpNv2B5FPR+iWoAuTHvttXYhcRZyvdyZwqt
	6S051odJ9RUBQmpE3Ni62huSCjehpd0Y8OYHPtcMhEBboKgChNE4I/x8pDCZF1agjCmsTs4KJO5
	gp8DDg6zzMw==
X-Received: from dyay26.prod.google.com ([2002:a05:693c:62da:b0:34d:46b2:7513])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:51c3:b0:36a:37:1404
 with SMTP id 5a478bee46e88-36de576a94fmr767686eec.13.1793826000418; Wed, 04
 Nov 2026 13:00:00 -0800 (PST)
Date: Wed,  4 Nov 2026 12:59:08 -0800
In-Reply-To: <20261104205909.2078411-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261104205909.2078411-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261104205909.2078411-19-irogers@google.com>
Subject: [PATCH v9 18/19] perf maps: Fix lock inversion in maps__load_first()
 and bounds check in __maps__remove()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, bvanassche@acm.org, elver@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
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
2.56.0.455.g6c5a503b38-goog

