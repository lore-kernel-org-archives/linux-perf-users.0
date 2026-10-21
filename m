Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602739;
	b=QrTLCiY1ftazKv8vyQi+9up4fo3f3iYgujupjLOVDiv/e1Z2BwMa89/GkxvT/Mt9hRys
	 DN/5FRdYGrOi4LtNFEU/jf8aeA+EQE9GhN0P4l+2URAvwwHFfc7+Ut2hlWyp7uJU183Hx
	 aADrFzYdrq3Vo0lFWDvBi0U1+QfcWDBCCC7GzyWWbCrRnxz6YoXIGafcXU56/5jginntQ
	 z0TqIkCrcLCfEp5aieDo5KNiJplXI6/x1Qlh7jyXTAmM36I3LJTwOLAFA2JR7AJHXvZoL
	 +GDyBDMxcRuvaF16mJVnp9Q9/SuYKMzvjjpQL6sHs0dju/OnORS3dyKKpnja140JSbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602739;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=va0jPRyzS9qJUXCbRxN41MmkIP1NzQbKCEMrTZrHPo0=;
	b=TCJQ58QoQ4LNo3wJSsvpPFMntD/C4L29rkLEOoKiaO47PwXRCyvY1XrTLXidWFIRA/3e
	 J2SRcX/kWaDJZRXA7gWALDNC8mmbDEIAVpDC+fFR5y9fSpVQe9P/hcjWX166i9mnc8Ax+
	 w3kmIUxuSKnE54rwzV1XXsoIC4BBkSTrek8OVSFd3g2myRDhcE2afrSKZfOUsMQLKN29G
	 P0NVjc4c7LkShe2CCRgldj4YAhmtDN2Bd4uvqTOGLNUnprhYR1BnCn6K8/+mRiY/5Ot9I
	 W7jnWtslSg2DBHd7f/TK6iciiLyy8BzjH5SUdKTc91EzXwq6+HxDkUy243j/6+m5cAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=bGDOhXEd;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCB060A4AC4
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 17:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFCB060A4AC4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=bGDOhXEd
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-359b81ad4e8so1628916eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 10:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792602738; x=1793207538; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=va0jPRyzS9qJUXCbRxN41MmkIP1NzQbKCEMrTZrHPo0=;
        b=bGDOhXEdaqPzP5cdnFiwy2WkgmwPpQoNggE6yuSKbh+c6tXCCJG1/xFsgJDQFHiIJR
         t1f60ZBSCuqyBwVJaAZsZUoRlggTP5vFbPCn9/zLP/dbhJCzJxIIwe9huJc0ud1eD+sV
         prfDGOIq0bw+RFhUFC954JTAbpoppeQUaLrcvlPnifo+js4X6LMBo8E6KrvTCtOi5WtB
         5e0ly9mFCUZcZsqEfKKPaY2eYngxnF6M2YxaqHrzxZZcLr6x1nY6KFakkdluBgn2atmK
         pVfd7B2eH4D3fpUUMu+anqTTTR0ncZKR4rCGSO8vMBnWDgS905rKj0qoVLO+lejUgkaW
         FYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792602738; x=1793207538;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=va0jPRyzS9qJUXCbRxN41MmkIP1NzQbKCEMrTZrHPo0=;
        b=JRaHhjYqKTsrsvNtqwnlyAlPvhTRT/GTZDG84hHuIetijJcMC3y3NvX2ix9rxSDXiP
         0YlayD5kZ0hwvGyelRDGz46HtOyMwfoRMuxMwwAoduCBIGI7zZHnlojR/OXnoN1uMD1C
         Tyk6vhhJmtvlTzLG+9gzu4T5aLw89fWx5A3GxhTTBAIVPIji48AGDCEybx67ZgKuTKew
         BmGWDG6gYKmzZn2T/aQp9EL1eZ6u/POa5b/23zyK21wXP0X7JleLYRAT0tjvKgx0B9dq
         +tLp7abKzNlaE11F4FJXFl5UYihRDVsWd/3UFdL9SpETJDhD0Sf2eWyMjaRKO12P2Psu
         W8vg==
X-Forwarded-Encrypted: i=1; AKwUvBwpW185NPeXgz/kZ5lpMw3l0gqTfWMdsUipEj3n027jHFTNg79uUtLeramaLuCzIjVlZbQdf1f1X9wbHpZ0G6U2@vger.kernel.org
X-Gm-Message-State: AFq9FYKK3pMTK2H8Aw2cmwiAX7k83Y3LOt1OMJOQRFDfxphbaYkIkMwR
	hzbQ5FV4syVu5Gu9rmEBrfxSX7OP1EC3FvBx7lsVwsBrzNsPaQFGIVKHNfiqwZsXafWAVlHppn3
	xIweSEgeWrw==
X-Received: from dldyr16-n2.prod.google.com ([2002:a05:701b:4510:20b0:191:1e8e:83d3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ea48:10b0:14d:ef19:246f
 with SMTP id a92af1059eb24-190a7756c63mr3346132c88.45.1792602737568; Wed, 21
 Oct 2026 10:12:17 -0700 (PDT)
Date: Wed, 21 Oct 2026 10:10:42 -0700
In-Reply-To: <20261021171044.155240-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261020163640.746159-1-irogers@google.com> <20261021171044.155240-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261021171044.155240-17-irogers@google.com>
Subject: [PATCH v6 16/17] perf maps: Fix lock inversion in maps__load_first()
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
2.56.0.218.g1ec904b173-goog

