Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3913815D5
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 08:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780215805; cv=none; b=AgOD9dRGEA16PlQNKc0Had0pieJM5gWlTHPfI3BjyN3POYlzcxGIwJtIfsrASR+DOJxXId38cdtedjAX5bV8bsjBWHuFoWhLnoCVu/ezlr0HlAODX56f3eBYbO39fi47duxSwldU8u3T8OAfO1mtyuCvprkoCd8XcOntJ4Sw2P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780215805; c=relaxed/simple;
	bh=FXe6+//YOH9BJZuzxzhHR3Qx+3KjauYebSwpv/qjf6M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q4/1zW1s6cxzzPz3mJ3ECv7S5qZSkRmjGZiqp8D5hfgSTyDW7quIECuBBLhzRjy1v0Ag68iXH+KeNV2LNFgrD6w4+ayCjTAVCKloyckfdBrXrUlxr/LIavoVsL6CvBKB5INUj2vEiFojTE5iptrgMPDY+Zjqhcr6VC3itFXVtUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CuRgAio+; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CuRgAio+"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304e4636205so6155131eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 01:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780215770; x=1780820570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+R44dqv5PtTJNELlv6V1Je9BlKTwCsO9yQ6W9gOlhiI=;
        b=CuRgAio+Q3Y155o4/Hp4bNRprvP4zQUW8vdOhG+wkHjDjqfLTN006eSeFjAut3+hAh
         4S3bhqiXigh3+eBw3jamFRVf18qN4GAq51zzrXvsdN8sE123TaUEuEZevQBvUd6L8thE
         mUHyK3RcwTWN0a30sAAGIRcf41cznB9AKC15vCQrPB0r5oQk+OzV5ThWCnIa8jAWo7Gz
         E3O0Pyi4XLsfdKxTG+WtHcbuDZOBbiQbIBX8PWrq8rkC66Ee1dXRPFrjW7fA8cOT81RQ
         QdqR2JY2lRICvQhF5YwHBrnW5sTX1N3Rr1HJFYOMfviSbEvHN2JjCb9GTMStPC/W57Mx
         YNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780215770; x=1780820570;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+R44dqv5PtTJNELlv6V1Je9BlKTwCsO9yQ6W9gOlhiI=;
        b=s6d+nK3AwNl0pymRvKim2XWx3ujcPJQC/JPrHKQzICBS6IbMsNKQYlo9j9xl2oLrLm
         pS8PnEWqFabegKBJIBlnvguXGltgoNu0eVHf1FmziXdKei1FfhcHciqDwglkeAn3n+8p
         DaJ7imyBRox9CgH8RYBqy8lALxeU8uWrlIFXMoPuxuwWnbY2MihrntxwrHvZlHYfl7MQ
         FQqjRiBllA5UzzzAimwBFuD5+TjadfRfxnrUvTWhlqnUgWgpvnMM6G/DEta0XHb6vt2o
         FyF7AuVBfA3MYwJ+66OT11tYW0lkaS5AavVXYceqDB3CmkEXj4xaX8Bt/yGHEcbwQakl
         t2bg==
X-Forwarded-Encrypted: i=1; AFNElJ8n2pF/MOGsDHTOJFtuL1NRWm7m49uXy+KvFYl0zkMp4NRnWzzLzH0wEGi6WF8OQ7ZeuUgUCDT1cYfQRnYpL3OO@vger.kernel.org
X-Gm-Message-State: AOJu0YxoWOpHESc6+suQUk4QdOpWiQcnBu/siqEpDgW4/OPuPWv6oUWS
	wC/DqJPIceAEsoOxSJSQBoYW1EZA0uA4vF7y2urgqRailGtjxyrSeEg6seHpcEOGSgyoa4+F7pu
	OciAneHfddg==
X-Received: from dybsi10.prod.google.com ([2002:a05:7301:488a:b0:2f1:f1df:db11])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:2201:b0:304:6782:d5a4
 with SMTP id 5a478bee46e88-304fa527b85mr3330556eec.5.1780215769726; Sun, 31
 May 2026 01:22:49 -0700 (PDT)
Date: Sun, 31 May 2026 01:22:21 -0700
In-Reply-To: <20260531082235.940833-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531063736.871777-1-irogers@google.com> <20260531082235.940833-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531082235.940833-2-irogers@google.com>
Subject: [PATCH v4 01/15] perf jevents.py: Make generated C code more kernel style
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Make jevents.py generate C code that complies with formatting tools:

- Add /* clang-format off */ before big_c_string and re-enable it
  after system mapping tables, bypassing large generated tables while
  checking functions and early structs.
- Make comments more human readable and avoid going over 100 character
  line length.
- Fix spaces indentation to tabs in struct/array initializers.
- Fix other checkpatch detected related issues.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 8775 ++++++++++++++--------
 tools/perf/pmu-events/jevents.py         |  791 +-
 2 files changed, 6094 insertions(+), 3472 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-even=
ts/empty-pmu-events.c
index a92dd0424f79..ad5ade37adb0 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -1,6 +1,5 @@
-
 /* SPDX-License-Identifier: GPL-2.0 */
-/* THIS FILE WAS AUTOGENERATED BY jevents.py arch=3Dnone model=3Dnone ! */
+/* THIS FILE WAS AUTOGENERATED BY `jevents.py arch=3Dnone model=3Dnone` ! =
*/
=20
 #include <pmu-events/pmu-events.h>
 #include "util/header.h"
@@ -9,2777 +8,5403 @@
 #include <stddef.h>
=20
 struct compact_pmu_event {
-        int offset;
+	int offset;
 };
=20
 struct pmu_table_entry {
-        const struct compact_pmu_event *entries;
-        uint32_t num_entries;
-        struct compact_pmu_event pmu_name;
+	const struct compact_pmu_event *entries;
+	uint32_t num_entries;
+	struct compact_pmu_event pmu_name;
 };
=20
+/* clang-format off */
 static const char *const big_c_string =3D
-/* offset=3D0 */ "default_core\000"
-/* offset=3D13 */ "l1-dcache\000legacy cache\000Level 1 data cache read ac=
cesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D99 */ "l1-dcache-load\000legacy cache\000Level 1 data cache re=
ad accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D190 */ "l1-dcache-load-refs\000legacy cache\000Level 1 data ca=
che read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D286 */ "l1-dcache-load-reference\000legacy cache\000Level 1 da=
ta cache read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000=
\000"
-/* offset=3D387 */ "l1-dcache-load-ops\000legacy cache\000Level 1 data cac=
he read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D482 */ "l1-dcache-load-access\000legacy cache\000Level 1 data =
cache read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\00=
0"
-/* offset=3D580 */ "l1-dcache-load-misses\000legacy cache\000Level 1 data =
cache read misses\000legacy-cache-config=3D0x10000\000\00000\000\000\000\00=
0\000"
-/* offset=3D682 */ "l1-dcache-load-miss\000legacy cache\000Level 1 data ca=
che read misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\=
000"
-/* offset=3D782 */ "l1-dcache-loads\000legacy cache\000Level 1 data cache =
read accesses\000legacy-cache-config=3D0\000\00000\000\000\000\000\000"
-/* offset=3D874 */ "l1-dcache-loads-refs\000legacy cache\000Level 1 data c=
ache read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000=
"
-/* offset=3D971 */ "l1-dcache-loads-reference\000legacy cache\000Level 1 d=
ata cache read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\00=
0\000"
-/* offset=3D1073 */ "l1-dcache-loads-ops\000legacy cache\000Level 1 data c=
ache read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000=
"
-/* offset=3D1169 */ "l1-dcache-loads-access\000legacy cache\000Level 1 dat=
a cache read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\=
000"
-/* offset=3D1268 */ "l1-dcache-loads-misses\000legacy cache\000Level 1 dat=
a cache read misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\=
000\000"
-/* offset=3D1371 */ "l1-dcache-loads-miss\000legacy cache\000Level 1 data =
cache read misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\00=
0\000"
-/* offset=3D1472 */ "l1-dcache-read\000legacy cache\000Level 1 data cache =
read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D1563 */ "l1-dcache-read-refs\000legacy cache\000Level 1 data c=
ache read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000=
"
-/* offset=3D1659 */ "l1-dcache-read-reference\000legacy cache\000Level 1 d=
ata cache read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\00=
0\000"
-/* offset=3D1760 */ "l1-dcache-read-ops\000legacy cache\000Level 1 data ca=
che read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D1855 */ "l1-dcache-read-access\000legacy cache\000Level 1 data=
 cache read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\0=
00"
-/* offset=3D1953 */ "l1-dcache-read-misses\000legacy cache\000Level 1 data=
 cache read misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\0=
00\000"
-/* offset=3D2055 */ "l1-dcache-read-miss\000legacy cache\000Level 1 data c=
ache read misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000=
\000"
-/* offset=3D2155 */ "l1-dcache-store\000legacy cache\000Level 1 data cache=
 write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\00=
0"
-/* offset=3D2252 */ "l1-dcache-store-refs\000legacy cache\000Level 1 data =
cache write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\0=
00\000"
-/* offset=3D2354 */ "l1-dcache-store-reference\000legacy cache\000Level 1 =
data cache write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\=
000\000\000"
-/* offset=3D2461 */ "l1-dcache-store-ops\000legacy cache\000Level 1 data c=
ache write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\00=
0\000"
-/* offset=3D2562 */ "l1-dcache-store-access\000legacy cache\000Level 1 dat=
a cache write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000=
\000\000"
-/* offset=3D2666 */ "l1-dcache-store-misses\000legacy cache\000Level 1 dat=
a cache write misses\000legacy-cache-config=3D0x10100\000\00000\000\000\000=
\000\000"
-/* offset=3D2770 */ "l1-dcache-store-miss\000legacy cache\000Level 1 data =
cache write misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\0=
00\000"
-/* offset=3D2872 */ "l1-dcache-stores\000legacy cache\000Level 1 data cach=
e write accesses\000legacy-cache-config=3D0x100\000\00000\000\000\000\000\0=
00"
-/* offset=3D2970 */ "l1-dcache-stores-refs\000legacy cache\000Level 1 data=
 cache write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\=
000\000"
-/* offset=3D3073 */ "l1-dcache-stores-reference\000legacy cache\000Level 1=
 data cache write accesses\000legacy-cache-config=3D0x100\000\00010\000\000=
\000\000\000"
-/* offset=3D3181 */ "l1-dcache-stores-ops\000legacy cache\000Level 1 data =
cache write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\0=
00\000"
-/* offset=3D3283 */ "l1-dcache-stores-access\000legacy cache\000Level 1 da=
ta cache write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\00=
0\000\000"
-/* offset=3D3388 */ "l1-dcache-stores-misses\000legacy cache\000Level 1 da=
ta cache write misses\000legacy-cache-config=3D0x10100\000\00010\000\000\00=
0\000\000"
-/* offset=3D3493 */ "l1-dcache-stores-miss\000legacy cache\000Level 1 data=
 cache write misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\=
000\000"
-/* offset=3D3596 */ "l1-dcache-write\000legacy cache\000Level 1 data cache=
 write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\00=
0"
-/* offset=3D3693 */ "l1-dcache-write-refs\000legacy cache\000Level 1 data =
cache write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\0=
00\000"
-/* offset=3D3795 */ "l1-dcache-write-reference\000legacy cache\000Level 1 =
data cache write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\=
000\000\000"
-/* offset=3D3902 */ "l1-dcache-write-ops\000legacy cache\000Level 1 data c=
ache write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\00=
0\000"
-/* offset=3D4003 */ "l1-dcache-write-access\000legacy cache\000Level 1 dat=
a cache write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000=
\000\000"
-/* offset=3D4107 */ "l1-dcache-write-misses\000legacy cache\000Level 1 dat=
a cache write misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000=
\000\000"
-/* offset=3D4211 */ "l1-dcache-write-miss\000legacy cache\000Level 1 data =
cache write misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\0=
00\000"
-/* offset=3D4313 */ "l1-dcache-prefetch\000legacy cache\000Level 1 data ca=
che prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\=
000\000"
-/* offset=3D4416 */ "l1-dcache-prefetch-refs\000legacy cache\000Level 1 da=
ta cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000=
\000\000\000"
-/* offset=3D4524 */ "l1-dcache-prefetch-reference\000legacy cache\000Level=
 1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\00=
0\000\000\000\000"
-/* offset=3D4637 */ "l1-dcache-prefetch-ops\000legacy cache\000Level 1 dat=
a cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\=
000\000\000"
-/* offset=3D4744 */ "l1-dcache-prefetch-access\000legacy cache\000Level 1 =
data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\0=
00\000\000\000"
-/* offset=3D4854 */ "l1-dcache-prefetch-misses\000legacy cache\000Level 1 =
data cache prefetch misses\000legacy-cache-config=3D0x10200\000\00000\000\0=
00\000\000\000"
-/* offset=3D4964 */ "l1-dcache-prefetch-miss\000legacy cache\000Level 1 da=
ta cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000=
\000\000\000"
-/* offset=3D5072 */ "l1-dcache-prefetches\000legacy cache\000Level 1 data =
cache prefetch accesses\000legacy-cache-config=3D0x200\000\00000\000\000\00=
0\000\000"
-/* offset=3D5177 */ "l1-dcache-prefetches-refs\000legacy cache\000Level 1 =
data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\0=
00\000\000\000"
-/* offset=3D5287 */ "l1-dcache-prefetches-reference\000legacy cache\000Lev=
el 1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\=
000\000\000\000\000"
-/* offset=3D5402 */ "l1-dcache-prefetches-ops\000legacy cache\000Level 1 d=
ata cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\00=
0\000\000\000"
-/* offset=3D5511 */ "l1-dcache-prefetches-access\000legacy cache\000Level =
1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000=
\000\000\000\000"
-/* offset=3D5623 */ "l1-dcache-prefetches-misses\000legacy cache\000Level =
1 data cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000=
\000\000\000\000"
-/* offset=3D5735 */ "l1-dcache-prefetches-miss\000legacy cache\000Level 1 =
data cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\0=
00\000\000\000"
-/* offset=3D5845 */ "l1-dcache-speculative-read\000legacy cache\000Level 1=
 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\=
000\000\000\000"
-/* offset=3D5956 */ "l1-dcache-speculative-read-refs\000legacy cache\000Le=
vel 1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010=
\000\000\000\000\000"
-/* offset=3D6072 */ "l1-dcache-speculative-read-reference\000legacy cache\=
000Level 1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\=
00010\000\000\000\000\000"
-/* offset=3D6193 */ "l1-dcache-speculative-read-ops\000legacy cache\000Lev=
el 1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\=
000\000\000\000\000"
-/* offset=3D6308 */ "l1-dcache-speculative-read-access\000legacy cache\000=
Level 1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\000=
10\000\000\000\000\000"
-/* offset=3D6426 */ "l1-dcache-speculative-read-misses\000legacy cache\000=
Level 1 data cache prefetch misses\000legacy-cache-config=3D0x10200\000\000=
10\000\000\000\000\000"
-/* offset=3D6544 */ "l1-dcache-speculative-read-miss\000legacy cache\000Le=
vel 1 data cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010=
\000\000\000\000\000"
-/* offset=3D6660 */ "l1-dcache-speculative-load\000legacy cache\000Level 1=
 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\=
000\000\000\000"
-/* offset=3D6771 */ "l1-dcache-speculative-load-refs\000legacy cache\000Le=
vel 1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010=
\000\000\000\000\000"
-/* offset=3D6887 */ "l1-dcache-speculative-load-reference\000legacy cache\=
000Level 1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\=
00010\000\000\000\000\000"
-/* offset=3D7008 */ "l1-dcache-speculative-load-ops\000legacy cache\000Lev=
el 1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\=
000\000\000\000\000"
-/* offset=3D7123 */ "l1-dcache-speculative-load-access\000legacy cache\000=
Level 1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\000=
10\000\000\000\000\000"
-/* offset=3D7241 */ "l1-dcache-speculative-load-misses\000legacy cache\000=
Level 1 data cache prefetch misses\000legacy-cache-config=3D0x10200\000\000=
10\000\000\000\000\000"
-/* offset=3D7359 */ "l1-dcache-speculative-load-miss\000legacy cache\000Le=
vel 1 data cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010=
\000\000\000\000\000"
-/* offset=3D7475 */ "l1-dcache-refs\000legacy cache\000Level 1 data cache =
read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D7566 */ "l1-dcache-reference\000legacy cache\000Level 1 data c=
ache read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000=
"
-/* offset=3D7662 */ "l1-dcache-ops\000legacy cache\000Level 1 data cache r=
ead accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D7752 */ "l1-dcache-access\000legacy cache\000Level 1 data cach=
e read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D7845 */ "l1-dcache-misses\000legacy cache\000Level 1 data cach=
e read misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\00=
0"
-/* offset=3D7942 */ "l1-dcache-miss\000legacy cache\000Level 1 data cache =
read misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D8037 */ "l1-d\000legacy cache\000Level 1 data cache read acces=
ses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D8118 */ "l1-d-load\000legacy cache\000Level 1 data cache read =
accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D8204 */ "l1-d-load-refs\000legacy cache\000Level 1 data cache =
read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D8295 */ "l1-d-load-reference\000legacy cache\000Level 1 data c=
ache read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000=
"
-/* offset=3D8391 */ "l1-d-load-ops\000legacy cache\000Level 1 data cache r=
ead accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D8481 */ "l1-d-load-access\000legacy cache\000Level 1 data cach=
e read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D8574 */ "l1-d-load-misses\000legacy cache\000Level 1 data cach=
e read misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\00=
0"
-/* offset=3D8671 */ "l1-d-load-miss\000legacy cache\000Level 1 data cache =
read misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D8766 */ "l1-d-loads\000legacy cache\000Level 1 data cache read=
 accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D8853 */ "l1-d-loads-refs\000legacy cache\000Level 1 data cache=
 read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D8945 */ "l1-d-loads-reference\000legacy cache\000Level 1 data =
cache read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\00=
0"
-/* offset=3D9042 */ "l1-d-loads-ops\000legacy cache\000Level 1 data cache =
read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D9133 */ "l1-d-loads-access\000legacy cache\000Level 1 data cac=
he read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D9227 */ "l1-d-loads-misses\000legacy cache\000Level 1 data cac=
he read misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\0=
00"
-/* offset=3D9325 */ "l1-d-loads-miss\000legacy cache\000Level 1 data cache=
 read misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000=
"
-/* offset=3D9421 */ "l1-d-read\000legacy cache\000Level 1 data cache read =
accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D9507 */ "l1-d-read-refs\000legacy cache\000Level 1 data cache =
read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D9598 */ "l1-d-read-reference\000legacy cache\000Level 1 data c=
ache read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000=
"
-/* offset=3D9694 */ "l1-d-read-ops\000legacy cache\000Level 1 data cache r=
ead accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D9784 */ "l1-d-read-access\000legacy cache\000Level 1 data cach=
e read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D9877 */ "l1-d-read-misses\000legacy cache\000Level 1 data cach=
e read misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\00=
0"
-/* offset=3D9974 */ "l1-d-read-miss\000legacy cache\000Level 1 data cache =
read misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D10069 */ "l1-d-store\000legacy cache\000Level 1 data cache wri=
te accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D10161 */ "l1-d-store-refs\000legacy cache\000Level 1 data cach=
e write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\0=
00"
-/* offset=3D10258 */ "l1-d-store-reference\000legacy cache\000Level 1 data=
 cache write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\=
000\000"
-/* offset=3D10360 */ "l1-d-store-ops\000legacy cache\000Level 1 data cache=
 write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\00=
0"
-/* offset=3D10456 */ "l1-d-store-access\000legacy cache\000Level 1 data ca=
che write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000=
\000"
-/* offset=3D10555 */ "l1-d-store-misses\000legacy cache\000Level 1 data ca=
che write misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000=
\000"
-/* offset=3D10654 */ "l1-d-store-miss\000legacy cache\000Level 1 data cach=
e write misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\0=
00"
-/* offset=3D10751 */ "l1-d-stores\000legacy cache\000Level 1 data cache wr=
ite accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D10844 */ "l1-d-stores-refs\000legacy cache\000Level 1 data cac=
he write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\=
000"
-/* offset=3D10942 */ "l1-d-stores-reference\000legacy cache\000Level 1 dat=
a cache write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000=
\000\000"
-/* offset=3D11045 */ "l1-d-stores-ops\000legacy cache\000Level 1 data cach=
e write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\0=
00"
-/* offset=3D11142 */ "l1-d-stores-access\000legacy cache\000Level 1 data c=
ache write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\00=
0\000"
-/* offset=3D11242 */ "l1-d-stores-misses\000legacy cache\000Level 1 data c=
ache write misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\00=
0\000"
-/* offset=3D11342 */ "l1-d-stores-miss\000legacy cache\000Level 1 data cac=
he write misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\=
000"
-/* offset=3D11440 */ "l1-d-write\000legacy cache\000Level 1 data cache wri=
te accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D11532 */ "l1-d-write-refs\000legacy cache\000Level 1 data cach=
e write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\0=
00"
-/* offset=3D11629 */ "l1-d-write-reference\000legacy cache\000Level 1 data=
 cache write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\=
000\000"
-/* offset=3D11731 */ "l1-d-write-ops\000legacy cache\000Level 1 data cache=
 write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\00=
0"
-/* offset=3D11827 */ "l1-d-write-access\000legacy cache\000Level 1 data ca=
che write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000=
\000"
-/* offset=3D11926 */ "l1-d-write-misses\000legacy cache\000Level 1 data ca=
che write misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000=
\000"
-/* offset=3D12025 */ "l1-d-write-miss\000legacy cache\000Level 1 data cach=
e write misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\0=
00"
-/* offset=3D12122 */ "l1-d-prefetch\000legacy cache\000Level 1 data cache =
prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\=
000"
-/* offset=3D12220 */ "l1-d-prefetch-refs\000legacy cache\000Level 1 data c=
ache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000=
\000\000"
-/* offset=3D12323 */ "l1-d-prefetch-reference\000legacy cache\000Level 1 d=
ata cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\00=
0\000\000\000"
-/* offset=3D12431 */ "l1-d-prefetch-ops\000legacy cache\000Level 1 data ca=
che prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\=
000\000"
-/* offset=3D12533 */ "l1-d-prefetch-access\000legacy cache\000Level 1 data=
 cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\0=
00\000\000"
-/* offset=3D12638 */ "l1-d-prefetch-misses\000legacy cache\000Level 1 data=
 cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\0=
00\000\000"
-/* offset=3D12743 */ "l1-d-prefetch-miss\000legacy cache\000Level 1 data c=
ache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000=
\000\000"
-/* offset=3D12846 */ "l1-d-prefetches\000legacy cache\000Level 1 data cach=
e prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\00=
0\000"
-/* offset=3D12946 */ "l1-d-prefetches-refs\000legacy cache\000Level 1 data=
 cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\0=
00\000\000"
-/* offset=3D13051 */ "l1-d-prefetches-reference\000legacy cache\000Level 1=
 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\=
000\000\000\000"
-/* offset=3D13161 */ "l1-d-prefetches-ops\000legacy cache\000Level 1 data =
cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\00=
0\000\000"
-/* offset=3D13265 */ "l1-d-prefetches-access\000legacy cache\000Level 1 da=
ta cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000=
\000\000\000"
-/* offset=3D13372 */ "l1-d-prefetches-misses\000legacy cache\000Level 1 da=
ta cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000=
\000\000\000"
-/* offset=3D13479 */ "l1-d-prefetches-miss\000legacy cache\000Level 1 data=
 cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\0=
00\000\000"
-/* offset=3D13584 */ "l1-d-speculative-read\000legacy cache\000Level 1 dat=
a cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\=
000\000\000"
-/* offset=3D13690 */ "l1-d-speculative-read-refs\000legacy cache\000Level =
1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000=
\000\000\000\000"
-/* offset=3D13801 */ "l1-d-speculative-read-reference\000legacy cache\000L=
evel 1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\0001=
0\000\000\000\000\000"
-/* offset=3D13917 */ "l1-d-speculative-read-ops\000legacy cache\000Level 1=
 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\=
000\000\000\000"
-/* offset=3D14027 */ "l1-d-speculative-read-access\000legacy cache\000Leve=
l 1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\0=
00\000\000\000\000"
-/* offset=3D14140 */ "l1-d-speculative-read-misses\000legacy cache\000Leve=
l 1 data cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\0=
00\000\000\000\000"
-/* offset=3D14253 */ "l1-d-speculative-read-miss\000legacy cache\000Level =
1 data cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000=
\000\000\000\000"
-/* offset=3D14364 */ "l1-d-speculative-load\000legacy cache\000Level 1 dat=
a cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\=
000\000\000"
-/* offset=3D14470 */ "l1-d-speculative-load-refs\000legacy cache\000Level =
1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000=
\000\000\000\000"
-/* offset=3D14581 */ "l1-d-speculative-load-reference\000legacy cache\000L=
evel 1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\0001=
0\000\000\000\000\000"
-/* offset=3D14697 */ "l1-d-speculative-load-ops\000legacy cache\000Level 1=
 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\=
000\000\000\000"
-/* offset=3D14807 */ "l1-d-speculative-load-access\000legacy cache\000Leve=
l 1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\0=
00\000\000\000\000"
-/* offset=3D14920 */ "l1-d-speculative-load-misses\000legacy cache\000Leve=
l 1 data cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\0=
00\000\000\000\000"
-/* offset=3D15033 */ "l1-d-speculative-load-miss\000legacy cache\000Level =
1 data cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000=
\000\000\000\000"
-/* offset=3D15144 */ "l1-d-refs\000legacy cache\000Level 1 data cache read=
 accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D15230 */ "l1-d-reference\000legacy cache\000Level 1 data cache=
 read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D15321 */ "l1-d-ops\000legacy cache\000Level 1 data cache read =
accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D15406 */ "l1-d-access\000legacy cache\000Level 1 data cache re=
ad accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D15494 */ "l1-d-misses\000legacy cache\000Level 1 data cache re=
ad misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D15586 */ "l1-d-miss\000legacy cache\000Level 1 data cache read=
 misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D15676 */ "l1d\000legacy cache\000Level 1 data cache read acces=
ses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D15756 */ "l1d-load\000legacy cache\000Level 1 data cache read =
accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D15841 */ "l1d-load-refs\000legacy cache\000Level 1 data cache =
read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D15931 */ "l1d-load-reference\000legacy cache\000Level 1 data c=
ache read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000=
"
-/* offset=3D16026 */ "l1d-load-ops\000legacy cache\000Level 1 data cache r=
ead accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D16115 */ "l1d-load-access\000legacy cache\000Level 1 data cach=
e read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D16207 */ "l1d-load-misses\000legacy cache\000Level 1 data cach=
e read misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\00=
0"
-/* offset=3D16303 */ "l1d-load-miss\000legacy cache\000Level 1 data cache =
read misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D16397 */ "l1d-loads\000legacy cache\000Level 1 data cache read=
 accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D16483 */ "l1d-loads-refs\000legacy cache\000Level 1 data cache=
 read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D16574 */ "l1d-loads-reference\000legacy cache\000Level 1 data =
cache read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\00=
0"
-/* offset=3D16670 */ "l1d-loads-ops\000legacy cache\000Level 1 data cache =
read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D16760 */ "l1d-loads-access\000legacy cache\000Level 1 data cac=
he read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D16853 */ "l1d-loads-misses\000legacy cache\000Level 1 data cac=
he read misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\0=
00"
-/* offset=3D16950 */ "l1d-loads-miss\000legacy cache\000Level 1 data cache=
 read misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000=
"
-/* offset=3D17045 */ "l1d-read\000legacy cache\000Level 1 data cache read =
accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D17130 */ "l1d-read-refs\000legacy cache\000Level 1 data cache =
read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D17220 */ "l1d-read-reference\000legacy cache\000Level 1 data c=
ache read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000=
"
-/* offset=3D17315 */ "l1d-read-ops\000legacy cache\000Level 1 data cache r=
ead accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D17404 */ "l1d-read-access\000legacy cache\000Level 1 data cach=
e read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D17496 */ "l1d-read-misses\000legacy cache\000Level 1 data cach=
e read misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\00=
0"
-/* offset=3D17592 */ "l1d-read-miss\000legacy cache\000Level 1 data cache =
read misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D17686 */ "l1d-store\000legacy cache\000Level 1 data cache writ=
e accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D17777 */ "l1d-store-refs\000legacy cache\000Level 1 data cache=
 write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\00=
0"
-/* offset=3D17873 */ "l1d-store-reference\000legacy cache\000Level 1 data =
cache write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\0=
00\000"
-/* offset=3D17974 */ "l1d-store-ops\000legacy cache\000Level 1 data cache =
write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000=
"
-/* offset=3D18069 */ "l1d-store-access\000legacy cache\000Level 1 data cac=
he write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\=
000"
-/* offset=3D18167 */ "l1d-store-misses\000legacy cache\000Level 1 data cac=
he write misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\=
000"
-/* offset=3D18265 */ "l1d-store-miss\000legacy cache\000Level 1 data cache=
 write misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\00=
0"
-/* offset=3D18361 */ "l1d-stores\000legacy cache\000Level 1 data cache wri=
te accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D18453 */ "l1d-stores-refs\000legacy cache\000Level 1 data cach=
e write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\0=
00"
-/* offset=3D18550 */ "l1d-stores-reference\000legacy cache\000Level 1 data=
 cache write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\=
000\000"
-/* offset=3D18652 */ "l1d-stores-ops\000legacy cache\000Level 1 data cache=
 write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\00=
0"
-/* offset=3D18748 */ "l1d-stores-access\000legacy cache\000Level 1 data ca=
che write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000=
\000"
-/* offset=3D18847 */ "l1d-stores-misses\000legacy cache\000Level 1 data ca=
che write misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000=
\000"
-/* offset=3D18946 */ "l1d-stores-miss\000legacy cache\000Level 1 data cach=
e write misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\0=
00"
-/* offset=3D19043 */ "l1d-write\000legacy cache\000Level 1 data cache writ=
e accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D19134 */ "l1d-write-refs\000legacy cache\000Level 1 data cache=
 write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\00=
0"
-/* offset=3D19230 */ "l1d-write-reference\000legacy cache\000Level 1 data =
cache write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\0=
00\000"
-/* offset=3D19331 */ "l1d-write-ops\000legacy cache\000Level 1 data cache =
write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000=
"
-/* offset=3D19426 */ "l1d-write-access\000legacy cache\000Level 1 data cac=
he write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\=
000"
-/* offset=3D19524 */ "l1d-write-misses\000legacy cache\000Level 1 data cac=
he write misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\=
000"
-/* offset=3D19622 */ "l1d-write-miss\000legacy cache\000Level 1 data cache=
 write misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\00=
0"
-/* offset=3D19718 */ "l1d-prefetch\000legacy cache\000Level 1 data cache p=
refetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\0=
00"
-/* offset=3D19815 */ "l1d-prefetch-refs\000legacy cache\000Level 1 data ca=
che prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\=
000\000"
-/* offset=3D19917 */ "l1d-prefetch-reference\000legacy cache\000Level 1 da=
ta cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000=
\000\000\000"
-/* offset=3D20024 */ "l1d-prefetch-ops\000legacy cache\000Level 1 data cac=
he prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\0=
00\000"
-/* offset=3D20125 */ "l1d-prefetch-access\000legacy cache\000Level 1 data =
cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\00=
0\000\000"
-/* offset=3D20229 */ "l1d-prefetch-misses\000legacy cache\000Level 1 data =
cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\00=
0\000\000"
-/* offset=3D20333 */ "l1d-prefetch-miss\000legacy cache\000Level 1 data ca=
che prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\=
000\000"
-/* offset=3D20435 */ "l1d-prefetches\000legacy cache\000Level 1 data cache=
 prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000=
\000"
-/* offset=3D20534 */ "l1d-prefetches-refs\000legacy cache\000Level 1 data =
cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\00=
0\000\000"
-/* offset=3D20638 */ "l1d-prefetches-reference\000legacy cache\000Level 1 =
data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\0=
00\000\000\000"
-/* offset=3D20747 */ "l1d-prefetches-ops\000legacy cache\000Level 1 data c=
ache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000=
\000\000"
-/* offset=3D20850 */ "l1d-prefetches-access\000legacy cache\000Level 1 dat=
a cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\=
000\000\000"
-/* offset=3D20956 */ "l1d-prefetches-misses\000legacy cache\000Level 1 dat=
a cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\=
000\000\000"
-/* offset=3D21062 */ "l1d-prefetches-miss\000legacy cache\000Level 1 data =
cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\00=
0\000\000"
-/* offset=3D21166 */ "l1d-speculative-read\000legacy cache\000Level 1 data=
 cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\0=
00\000\000"
-/* offset=3D21271 */ "l1d-speculative-read-refs\000legacy cache\000Level 1=
 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\=
000\000\000\000"
-/* offset=3D21381 */ "l1d-speculative-read-reference\000legacy cache\000Le=
vel 1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010=
\000\000\000\000\000"
-/* offset=3D21496 */ "l1d-speculative-read-ops\000legacy cache\000Level 1 =
data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\0=
00\000\000\000"
-/* offset=3D21605 */ "l1d-speculative-read-access\000legacy cache\000Level=
 1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\00=
0\000\000\000\000"
-/* offset=3D21717 */ "l1d-speculative-read-misses\000legacy cache\000Level=
 1 data cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\00=
0\000\000\000\000"
-/* offset=3D21829 */ "l1d-speculative-read-miss\000legacy cache\000Level 1=
 data cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\=
000\000\000\000"
-/* offset=3D21939 */ "l1d-speculative-load\000legacy cache\000Level 1 data=
 cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\0=
00\000\000"
-/* offset=3D22044 */ "l1d-speculative-load-refs\000legacy cache\000Level 1=
 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\=
000\000\000\000"
-/* offset=3D22154 */ "l1d-speculative-load-reference\000legacy cache\000Le=
vel 1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010=
\000\000\000\000\000"
-/* offset=3D22269 */ "l1d-speculative-load-ops\000legacy cache\000Level 1 =
data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\0=
00\000\000\000"
-/* offset=3D22378 */ "l1d-speculative-load-access\000legacy cache\000Level=
 1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\00=
0\000\000\000\000"
-/* offset=3D22490 */ "l1d-speculative-load-misses\000legacy cache\000Level=
 1 data cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\00=
0\000\000\000\000"
-/* offset=3D22602 */ "l1d-speculative-load-miss\000legacy cache\000Level 1=
 data cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\=
000\000\000\000"
-/* offset=3D22712 */ "l1d-refs\000legacy cache\000Level 1 data cache read =
accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D22797 */ "l1d-reference\000legacy cache\000Level 1 data cache =
read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D22887 */ "l1d-ops\000legacy cache\000Level 1 data cache read a=
ccesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D22971 */ "l1d-access\000legacy cache\000Level 1 data cache rea=
d accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D23058 */ "l1d-misses\000legacy cache\000Level 1 data cache rea=
d misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D23149 */ "l1d-miss\000legacy cache\000Level 1 data cache read =
misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D23238 */ "l1-data\000legacy cache\000Level 1 data cache read a=
ccesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D23322 */ "l1-data-load\000legacy cache\000Level 1 data cache r=
ead accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D23411 */ "l1-data-load-refs\000legacy cache\000Level 1 data ca=
che read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D23505 */ "l1-data-load-reference\000legacy cache\000Level 1 da=
ta cache read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000=
\000"
-/* offset=3D23604 */ "l1-data-load-ops\000legacy cache\000Level 1 data cac=
he read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D23697 */ "l1-data-load-access\000legacy cache\000Level 1 data =
cache read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\00=
0"
-/* offset=3D23793 */ "l1-data-load-misses\000legacy cache\000Level 1 data =
cache read misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\00=
0\000"
-/* offset=3D23893 */ "l1-data-load-miss\000legacy cache\000Level 1 data ca=
che read misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\=
000"
-/* offset=3D23991 */ "l1-data-loads\000legacy cache\000Level 1 data cache =
read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D24081 */ "l1-data-loads-refs\000legacy cache\000Level 1 data c=
ache read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000=
"
-/* offset=3D24176 */ "l1-data-loads-reference\000legacy cache\000Level 1 d=
ata cache read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\00=
0\000"
-/* offset=3D24276 */ "l1-data-loads-ops\000legacy cache\000Level 1 data ca=
che read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D24370 */ "l1-data-loads-access\000legacy cache\000Level 1 data=
 cache read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\0=
00"
-/* offset=3D24467 */ "l1-data-loads-misses\000legacy cache\000Level 1 data=
 cache read misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\0=
00\000"
-/* offset=3D24568 */ "l1-data-loads-miss\000legacy cache\000Level 1 data c=
ache read misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000=
\000"
-/* offset=3D24667 */ "l1-data-read\000legacy cache\000Level 1 data cache r=
ead accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D24756 */ "l1-data-read-refs\000legacy cache\000Level 1 data ca=
che read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D24850 */ "l1-data-read-reference\000legacy cache\000Level 1 da=
ta cache read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000=
\000"
-/* offset=3D24949 */ "l1-data-read-ops\000legacy cache\000Level 1 data cac=
he read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D25042 */ "l1-data-read-access\000legacy cache\000Level 1 data =
cache read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\00=
0"
-/* offset=3D25138 */ "l1-data-read-misses\000legacy cache\000Level 1 data =
cache read misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\00=
0\000"
-/* offset=3D25238 */ "l1-data-read-miss\000legacy cache\000Level 1 data ca=
che read misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\=
000"
-/* offset=3D25336 */ "l1-data-store\000legacy cache\000Level 1 data cache =
write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000=
"
-/* offset=3D25431 */ "l1-data-store-refs\000legacy cache\000Level 1 data c=
ache write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\00=
0\000"
-/* offset=3D25531 */ "l1-data-store-reference\000legacy cache\000Level 1 d=
ata cache write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\0=
00\000\000"
-/* offset=3D25636 */ "l1-data-store-ops\000legacy cache\000Level 1 data ca=
che write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000=
\000"
-/* offset=3D25735 */ "l1-data-store-access\000legacy cache\000Level 1 data=
 cache write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\=
000\000"
-/* offset=3D25837 */ "l1-data-store-misses\000legacy cache\000Level 1 data=
 cache write misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\=
000\000"
-/* offset=3D25939 */ "l1-data-store-miss\000legacy cache\000Level 1 data c=
ache write misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\00=
0\000"
-/* offset=3D26039 */ "l1-data-stores\000legacy cache\000Level 1 data cache=
 write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\00=
0"
-/* offset=3D26135 */ "l1-data-stores-refs\000legacy cache\000Level 1 data =
cache write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\0=
00\000"
-/* offset=3D26236 */ "l1-data-stores-reference\000legacy cache\000Level 1 =
data cache write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\=
000\000\000"
-/* offset=3D26342 */ "l1-data-stores-ops\000legacy cache\000Level 1 data c=
ache write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\00=
0\000"
-/* offset=3D26442 */ "l1-data-stores-access\000legacy cache\000Level 1 dat=
a cache write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000=
\000\000"
-/* offset=3D26545 */ "l1-data-stores-misses\000legacy cache\000Level 1 dat=
a cache write misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000=
\000\000"
-/* offset=3D26648 */ "l1-data-stores-miss\000legacy cache\000Level 1 data =
cache write misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\0=
00\000"
-/* offset=3D26749 */ "l1-data-write\000legacy cache\000Level 1 data cache =
write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000=
"
-/* offset=3D26844 */ "l1-data-write-refs\000legacy cache\000Level 1 data c=
ache write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\00=
0\000"
-/* offset=3D26944 */ "l1-data-write-reference\000legacy cache\000Level 1 d=
ata cache write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\0=
00\000\000"
-/* offset=3D27049 */ "l1-data-write-ops\000legacy cache\000Level 1 data ca=
che write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000=
\000"
-/* offset=3D27148 */ "l1-data-write-access\000legacy cache\000Level 1 data=
 cache write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\=
000\000"
-/* offset=3D27250 */ "l1-data-write-misses\000legacy cache\000Level 1 data=
 cache write misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\=
000\000"
-/* offset=3D27352 */ "l1-data-write-miss\000legacy cache\000Level 1 data c=
ache write misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\00=
0\000"
-/* offset=3D27452 */ "l1-data-prefetch\000legacy cache\000Level 1 data cac=
he prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\0=
00\000"
-/* offset=3D27553 */ "l1-data-prefetch-refs\000legacy cache\000Level 1 dat=
a cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\=
000\000\000"
-/* offset=3D27659 */ "l1-data-prefetch-reference\000legacy cache\000Level =
1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000=
\000\000\000\000"
-/* offset=3D27770 */ "l1-data-prefetch-ops\000legacy cache\000Level 1 data=
 cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\0=
00\000\000"
-/* offset=3D27875 */ "l1-data-prefetch-access\000legacy cache\000Level 1 d=
ata cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\00=
0\000\000\000"
-/* offset=3D27983 */ "l1-data-prefetch-misses\000legacy cache\000Level 1 d=
ata cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\00=
0\000\000\000"
-/* offset=3D28091 */ "l1-data-prefetch-miss\000legacy cache\000Level 1 dat=
a cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\=
000\000\000"
-/* offset=3D28197 */ "l1-data-prefetches\000legacy cache\000Level 1 data c=
ache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000=
\000\000"
-/* offset=3D28300 */ "l1-data-prefetches-refs\000legacy cache\000Level 1 d=
ata cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\00=
0\000\000\000"
-/* offset=3D28408 */ "l1-data-prefetches-reference\000legacy cache\000Leve=
l 1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\0=
00\000\000\000\000"
-/* offset=3D28521 */ "l1-data-prefetches-ops\000legacy cache\000Level 1 da=
ta cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000=
\000\000\000"
-/* offset=3D28628 */ "l1-data-prefetches-access\000legacy cache\000Level 1=
 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\=
000\000\000\000"
-/* offset=3D28738 */ "l1-data-prefetches-misses\000legacy cache\000Level 1=
 data cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\=
000\000\000\000"
-/* offset=3D28848 */ "l1-data-prefetches-miss\000legacy cache\000Level 1 d=
ata cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\00=
0\000\000\000"
-/* offset=3D28956 */ "l1-data-speculative-read\000legacy cache\000Level 1 =
data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\0=
00\000\000\000"
-/* offset=3D29065 */ "l1-data-speculative-read-refs\000legacy cache\000Lev=
el 1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\=
000\000\000\000\000"
-/* offset=3D29179 */ "l1-data-speculative-read-reference\000legacy cache\0=
00Level 1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\0=
0010\000\000\000\000\000"
-/* offset=3D29298 */ "l1-data-speculative-read-ops\000legacy cache\000Leve=
l 1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\0=
00\000\000\000\000"
-/* offset=3D29411 */ "l1-data-speculative-read-access\000legacy cache\000L=
evel 1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\0001=
0\000\000\000\000\000"
-/* offset=3D29527 */ "l1-data-speculative-read-misses\000legacy cache\000L=
evel 1 data cache prefetch misses\000legacy-cache-config=3D0x10200\000\0001=
0\000\000\000\000\000"
-/* offset=3D29643 */ "l1-data-speculative-read-miss\000legacy cache\000Lev=
el 1 data cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\=
000\000\000\000\000"
-/* offset=3D29757 */ "l1-data-speculative-load\000legacy cache\000Level 1 =
data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\0=
00\000\000\000"
-/* offset=3D29866 */ "l1-data-speculative-load-refs\000legacy cache\000Lev=
el 1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\=
000\000\000\000\000"
-/* offset=3D29980 */ "l1-data-speculative-load-reference\000legacy cache\0=
00Level 1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\0=
0010\000\000\000\000\000"
-/* offset=3D30099 */ "l1-data-speculative-load-ops\000legacy cache\000Leve=
l 1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\0=
00\000\000\000\000"
-/* offset=3D30212 */ "l1-data-speculative-load-access\000legacy cache\000L=
evel 1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\0001=
0\000\000\000\000\000"
-/* offset=3D30328 */ "l1-data-speculative-load-misses\000legacy cache\000L=
evel 1 data cache prefetch misses\000legacy-cache-config=3D0x10200\000\0001=
0\000\000\000\000\000"
-/* offset=3D30444 */ "l1-data-speculative-load-miss\000legacy cache\000Lev=
el 1 data cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\=
000\000\000\000\000"
-/* offset=3D30558 */ "l1-data-refs\000legacy cache\000Level 1 data cache r=
ead accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D30647 */ "l1-data-reference\000legacy cache\000Level 1 data ca=
che read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D30741 */ "l1-data-ops\000legacy cache\000Level 1 data cache re=
ad accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D30829 */ "l1-data-access\000legacy cache\000Level 1 data cache=
 read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D30920 */ "l1-data-misses\000legacy cache\000Level 1 data cache=
 read misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000=
"
-/* offset=3D31015 */ "l1-data-miss\000legacy cache\000Level 1 data cache r=
ead misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D31108 */ "l1-icache\000legacy cache\000Level 1 instruction cac=
he read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D31201 */ "l1-icache-load\000legacy cache\000Level 1 instructio=
n cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\=
000"
-/* offset=3D31299 */ "l1-icache-load-refs\000legacy cache\000Level 1 instr=
uction cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000=
\000\000"
-/* offset=3D31402 */ "l1-icache-load-reference\000legacy cache\000Level 1 =
instruction cache read accesses\000legacy-cache-config=3D1\000\00010\000\00=
0\000\000\000"
-/* offset=3D31510 */ "l1-icache-load-ops\000legacy cache\000Level 1 instru=
ction cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\=
000\000"
-/* offset=3D31612 */ "l1-icache-load-access\000legacy cache\000Level 1 ins=
truction cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\0=
00\000\000"
-/* offset=3D31717 */ "l1-icache-load-misses\000legacy cache\000Level 1 ins=
truction cache read misses\000legacy-cache-config=3D0x10001\000\00000\000\0=
00\000\000\000"
-/* offset=3D31826 */ "l1-icache-load-miss\000legacy cache\000Level 1 instr=
uction cache read misses\000legacy-cache-config=3D0x10001\000\00010\000\000=
\000\000\000"
-/* offset=3D31933 */ "l1-icache-loads\000legacy cache\000Level 1 instructi=
on cache read accesses\000legacy-cache-config=3D1\000\00000\000\000\000\000=
\000"
-/* offset=3D32032 */ "l1-icache-loads-refs\000legacy cache\000Level 1 inst=
ruction cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\00=
0\000\000"
-/* offset=3D32136 */ "l1-icache-loads-reference\000legacy cache\000Level 1=
 instruction cache read accesses\000legacy-cache-config=3D1\000\00010\000\0=
00\000\000\000"
-/* offset=3D32245 */ "l1-icache-loads-ops\000legacy cache\000Level 1 instr=
uction cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000=
\000\000"
-/* offset=3D32348 */ "l1-icache-loads-access\000legacy cache\000Level 1 in=
struction cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\=
000\000\000"
-/* offset=3D32454 */ "l1-icache-loads-misses\000legacy cache\000Level 1 in=
struction cache read misses\000legacy-cache-config=3D0x10001\000\00010\000\=
000\000\000\000"
-/* offset=3D32564 */ "l1-icache-loads-miss\000legacy cache\000Level 1 inst=
ruction cache read misses\000legacy-cache-config=3D0x10001\000\00010\000\00=
0\000\000\000"
-/* offset=3D32672 */ "l1-icache-read\000legacy cache\000Level 1 instructio=
n cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\=
000"
-/* offset=3D32770 */ "l1-icache-read-refs\000legacy cache\000Level 1 instr=
uction cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000=
\000\000"
-/* offset=3D32873 */ "l1-icache-read-reference\000legacy cache\000Level 1 =
instruction cache read accesses\000legacy-cache-config=3D1\000\00010\000\00=
0\000\000\000"
-/* offset=3D32981 */ "l1-icache-read-ops\000legacy cache\000Level 1 instru=
ction cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\=
000\000"
-/* offset=3D33083 */ "l1-icache-read-access\000legacy cache\000Level 1 ins=
truction cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\0=
00\000\000"
-/* offset=3D33188 */ "l1-icache-read-misses\000legacy cache\000Level 1 ins=
truction cache read misses\000legacy-cache-config=3D0x10001\000\00010\000\0=
00\000\000\000"
-/* offset=3D33297 */ "l1-icache-read-miss\000legacy cache\000Level 1 instr=
uction cache read misses\000legacy-cache-config=3D0x10001\000\00010\000\000=
\000\000\000"
-/* offset=3D33404 */ "l1-icache-prefetch\000legacy cache\000Level 1 instru=
ction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\=
000\000\000\000"
-/* offset=3D33514 */ "l1-icache-prefetch-refs\000legacy cache\000Level 1 i=
nstruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010=
\000\000\000\000\000"
-/* offset=3D33629 */ "l1-icache-prefetch-reference\000legacy cache\000Leve=
l 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\=
00010\000\000\000\000\000"
-/* offset=3D33749 */ "l1-icache-prefetch-ops\000legacy cache\000Level 1 in=
struction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\=
000\000\000\000\000"
-/* offset=3D33863 */ "l1-icache-prefetch-access\000legacy cache\000Level 1=
 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\000=
10\000\000\000\000\000"
-/* offset=3D33980 */ "l1-icache-prefetch-misses\000legacy cache\000Level 1=
 instruction cache prefetch misses\000legacy-cache-config=3D0x10201\000\000=
00\000\000\000\000\000"
-/* offset=3D34097 */ "l1-icache-prefetch-miss\000legacy cache\000Level 1 i=
nstruction cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010=
\000\000\000\000\000"
-/* offset=3D34212 */ "l1-icache-prefetches\000legacy cache\000Level 1 inst=
ruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00000\00=
0\000\000\000\000"
-/* offset=3D34324 */ "l1-icache-prefetches-refs\000legacy cache\000Level 1=
 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\000=
10\000\000\000\000\000"
-/* offset=3D34441 */ "l1-icache-prefetches-reference\000legacy cache\000Le=
vel 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\00=
0\00010\000\000\000\000\000"
-/* offset=3D34563 */ "l1-icache-prefetches-ops\000legacy cache\000Level 1 =
instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\0001=
0\000\000\000\000\000"
-/* offset=3D34679 */ "l1-icache-prefetches-access\000legacy cache\000Level=
 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\0=
0010\000\000\000\000\000"
-/* offset=3D34798 */ "l1-icache-prefetches-misses\000legacy cache\000Level=
 1 instruction cache prefetch misses\000legacy-cache-config=3D0x10201\000\0=
0010\000\000\000\000\000"
-/* offset=3D34917 */ "l1-icache-prefetches-miss\000legacy cache\000Level 1=
 instruction cache prefetch misses\000legacy-cache-config=3D0x10201\000\000=
10\000\000\000\000\000"
-/* offset=3D35034 */ "l1-icache-speculative-read\000legacy cache\000Level =
1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00=
010\000\000\000\000\000"
-/* offset=3D35152 */ "l1-icache-speculative-read-refs\000legacy cache\000L=
evel 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\0=
00\00010\000\000\000\000\000"
-/* offset=3D35275 */ "l1-icache-speculative-read-reference\000legacy cache=
\000Level 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x=
201\000\00010\000\000\000\000\000"
-/* offset=3D35403 */ "l1-icache-speculative-read-ops\000legacy cache\000Le=
vel 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\00=
0\00010\000\000\000\000\000"
-/* offset=3D35525 */ "l1-icache-speculative-read-access\000legacy cache\00=
0Level 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201=
\000\00010\000\000\000\000\000"
-/* offset=3D35650 */ "l1-icache-speculative-read-misses\000legacy cache\00=
0Level 1 instruction cache prefetch misses\000legacy-cache-config=3D0x10201=
\000\00010\000\000\000\000\000"
-/* offset=3D35775 */ "l1-icache-speculative-read-miss\000legacy cache\000L=
evel 1 instruction cache prefetch misses\000legacy-cache-config=3D0x10201\0=
00\00010\000\000\000\000\000"
-/* offset=3D35898 */ "l1-icache-speculative-load\000legacy cache\000Level =
1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00=
010\000\000\000\000\000"
-/* offset=3D36016 */ "l1-icache-speculative-load-refs\000legacy cache\000L=
evel 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\0=
00\00010\000\000\000\000\000"
-/* offset=3D36139 */ "l1-icache-speculative-load-reference\000legacy cache=
\000Level 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x=
201\000\00010\000\000\000\000\000"
-/* offset=3D36267 */ "l1-icache-speculative-load-ops\000legacy cache\000Le=
vel 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\00=
0\00010\000\000\000\000\000"
-/* offset=3D36389 */ "l1-icache-speculative-load-access\000legacy cache\00=
0Level 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201=
\000\00010\000\000\000\000\000"
-/* offset=3D36514 */ "l1-icache-speculative-load-misses\000legacy cache\00=
0Level 1 instruction cache prefetch misses\000legacy-cache-config=3D0x10201=
\000\00010\000\000\000\000\000"
-/* offset=3D36639 */ "l1-icache-speculative-load-miss\000legacy cache\000L=
evel 1 instruction cache prefetch misses\000legacy-cache-config=3D0x10201\0=
00\00010\000\000\000\000\000"
-/* offset=3D36762 */ "l1-icache-refs\000legacy cache\000Level 1 instructio=
n cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\=
000"
-/* offset=3D36860 */ "l1-icache-reference\000legacy cache\000Level 1 instr=
uction cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000=
\000\000"
-/* offset=3D36963 */ "l1-icache-ops\000legacy cache\000Level 1 instruction=
 cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\0=
00"
-/* offset=3D37060 */ "l1-icache-access\000legacy cache\000Level 1 instruct=
ion cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\00=
0\000"
-/* offset=3D37160 */ "l1-icache-misses\000legacy cache\000Level 1 instruct=
ion cache read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\00=
0\000\000"
-/* offset=3D37264 */ "l1-icache-miss\000legacy cache\000Level 1 instructio=
n cache read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\=
000\000"
-/* offset=3D37366 */ "l1-i\000legacy cache\000Level 1 instruction cache re=
ad accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D37454 */ "l1-i-load\000legacy cache\000Level 1 instruction cac=
he read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D37547 */ "l1-i-load-refs\000legacy cache\000Level 1 instructio=
n cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\=
000"
-/* offset=3D37645 */ "l1-i-load-reference\000legacy cache\000Level 1 instr=
uction cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000=
\000\000"
-/* offset=3D37748 */ "l1-i-load-ops\000legacy cache\000Level 1 instruction=
 cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\0=
00"
-/* offset=3D37845 */ "l1-i-load-access\000legacy cache\000Level 1 instruct=
ion cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\00=
0\000"
-/* offset=3D37945 */ "l1-i-load-misses\000legacy cache\000Level 1 instruct=
ion cache read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\00=
0\000\000"
-/* offset=3D38049 */ "l1-i-load-miss\000legacy cache\000Level 1 instructio=
n cache read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\=
000\000"
-/* offset=3D38151 */ "l1-i-loads\000legacy cache\000Level 1 instruction ca=
che read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D38245 */ "l1-i-loads-refs\000legacy cache\000Level 1 instructi=
on cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000=
\000"
-/* offset=3D38344 */ "l1-i-loads-reference\000legacy cache\000Level 1 inst=
ruction cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\00=
0\000\000"
-/* offset=3D38448 */ "l1-i-loads-ops\000legacy cache\000Level 1 instructio=
n cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\=
000"
-/* offset=3D38546 */ "l1-i-loads-access\000legacy cache\000Level 1 instruc=
tion cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\0=
00\000"
-/* offset=3D38647 */ "l1-i-loads-misses\000legacy cache\000Level 1 instruc=
tion cache read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\0=
00\000\000"
-/* offset=3D38752 */ "l1-i-loads-miss\000legacy cache\000Level 1 instructi=
on cache read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000=
\000\000"
-/* offset=3D38855 */ "l1-i-read\000legacy cache\000Level 1 instruction cac=
he read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D38948 */ "l1-i-read-refs\000legacy cache\000Level 1 instructio=
n cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\=
000"
-/* offset=3D39046 */ "l1-i-read-reference\000legacy cache\000Level 1 instr=
uction cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000=
\000\000"
-/* offset=3D39149 */ "l1-i-read-ops\000legacy cache\000Level 1 instruction=
 cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\0=
00"
-/* offset=3D39246 */ "l1-i-read-access\000legacy cache\000Level 1 instruct=
ion cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\00=
0\000"
-/* offset=3D39346 */ "l1-i-read-misses\000legacy cache\000Level 1 instruct=
ion cache read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\00=
0\000\000"
-/* offset=3D39450 */ "l1-i-read-miss\000legacy cache\000Level 1 instructio=
n cache read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\=
000\000"
-/* offset=3D39552 */ "l1-i-prefetch\000legacy cache\000Level 1 instruction=
 cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\0=
00\000\000"
-/* offset=3D39657 */ "l1-i-prefetch-refs\000legacy cache\000Level 1 instru=
ction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\=
000\000\000\000"
-/* offset=3D39767 */ "l1-i-prefetch-reference\000legacy cache\000Level 1 i=
nstruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010=
\000\000\000\000\000"
-/* offset=3D39882 */ "l1-i-prefetch-ops\000legacy cache\000Level 1 instruc=
tion cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\0=
00\000\000\000"
-/* offset=3D39991 */ "l1-i-prefetch-access\000legacy cache\000Level 1 inst=
ruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\00=
0\000\000\000\000"
-/* offset=3D40103 */ "l1-i-prefetch-misses\000legacy cache\000Level 1 inst=
ruction cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\00=
0\000\000\000\000"
-/* offset=3D40215 */ "l1-i-prefetch-miss\000legacy cache\000Level 1 instru=
ction cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\=
000\000\000\000"
-/* offset=3D40325 */ "l1-i-prefetches\000legacy cache\000Level 1 instructi=
on cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000=
\000\000\000"
-/* offset=3D40432 */ "l1-i-prefetches-refs\000legacy cache\000Level 1 inst=
ruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\00=
0\000\000\000\000"
-/* offset=3D40544 */ "l1-i-prefetches-reference\000legacy cache\000Level 1=
 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\000=
10\000\000\000\000\000"
-/* offset=3D40661 */ "l1-i-prefetches-ops\000legacy cache\000Level 1 instr=
uction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000=
\000\000\000\000"
-/* offset=3D40772 */ "l1-i-prefetches-access\000legacy cache\000Level 1 in=
struction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\=
000\000\000\000\000"
-/* offset=3D40886 */ "l1-i-prefetches-misses\000legacy cache\000Level 1 in=
struction cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\=
000\000\000\000\000"
-/* offset=3D41000 */ "l1-i-prefetches-miss\000legacy cache\000Level 1 inst=
ruction cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\00=
0\000\000\000\000"
-/* offset=3D41112 */ "l1-i-speculative-read\000legacy cache\000Level 1 ins=
truction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\0=
00\000\000\000\000"
-/* offset=3D41225 */ "l1-i-speculative-read-refs\000legacy cache\000Level =
1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00=
010\000\000\000\000\000"
-/* offset=3D41343 */ "l1-i-speculative-read-reference\000legacy cache\000L=
evel 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\0=
00\00010\000\000\000\000\000"
-/* offset=3D41466 */ "l1-i-speculative-read-ops\000legacy cache\000Level 1=
 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\000=
10\000\000\000\000\000"
-/* offset=3D41583 */ "l1-i-speculative-read-access\000legacy cache\000Leve=
l 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\=
00010\000\000\000\000\000"
-/* offset=3D41703 */ "l1-i-speculative-read-misses\000legacy cache\000Leve=
l 1 instruction cache prefetch misses\000legacy-cache-config=3D0x10201\000\=
00010\000\000\000\000\000"
-/* offset=3D41823 */ "l1-i-speculative-read-miss\000legacy cache\000Level =
1 instruction cache prefetch misses\000legacy-cache-config=3D0x10201\000\00=
010\000\000\000\000\000"
-/* offset=3D41941 */ "l1-i-speculative-load\000legacy cache\000Level 1 ins=
truction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\0=
00\000\000\000\000"
-/* offset=3D42054 */ "l1-i-speculative-load-refs\000legacy cache\000Level =
1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00=
010\000\000\000\000\000"
-/* offset=3D42172 */ "l1-i-speculative-load-reference\000legacy cache\000L=
evel 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\0=
00\00010\000\000\000\000\000"
-/* offset=3D42295 */ "l1-i-speculative-load-ops\000legacy cache\000Level 1=
 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\000=
10\000\000\000\000\000"
-/* offset=3D42412 */ "l1-i-speculative-load-access\000legacy cache\000Leve=
l 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\=
00010\000\000\000\000\000"
-/* offset=3D42532 */ "l1-i-speculative-load-misses\000legacy cache\000Leve=
l 1 instruction cache prefetch misses\000legacy-cache-config=3D0x10201\000\=
00010\000\000\000\000\000"
-/* offset=3D42652 */ "l1-i-speculative-load-miss\000legacy cache\000Level =
1 instruction cache prefetch misses\000legacy-cache-config=3D0x10201\000\00=
010\000\000\000\000\000"
-/* offset=3D42770 */ "l1-i-refs\000legacy cache\000Level 1 instruction cac=
he read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D42863 */ "l1-i-reference\000legacy cache\000Level 1 instructio=
n cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\=
000"
-/* offset=3D42961 */ "l1-i-ops\000legacy cache\000Level 1 instruction cach=
e read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D43053 */ "l1-i-access\000legacy cache\000Level 1 instruction c=
ache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000=
"
-/* offset=3D43148 */ "l1-i-misses\000legacy cache\000Level 1 instruction c=
ache read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000=
\000"
-/* offset=3D43247 */ "l1-i-miss\000legacy cache\000Level 1 instruction cac=
he read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\0=
00"
-/* offset=3D43344 */ "l1i\000legacy cache\000Level 1 instruction cache rea=
d accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D43431 */ "l1i-load\000legacy cache\000Level 1 instruction cach=
e read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D43523 */ "l1i-load-refs\000legacy cache\000Level 1 instruction=
 cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\0=
00"
-/* offset=3D43620 */ "l1i-load-reference\000legacy cache\000Level 1 instru=
ction cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\=
000\000"
-/* offset=3D43722 */ "l1i-load-ops\000legacy cache\000Level 1 instruction =
cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\00=
0"
-/* offset=3D43818 */ "l1i-load-access\000legacy cache\000Level 1 instructi=
on cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000=
\000"
-/* offset=3D43917 */ "l1i-load-misses\000legacy cache\000Level 1 instructi=
on cache read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000=
\000\000"
-/* offset=3D44020 */ "l1i-load-miss\000legacy cache\000Level 1 instruction=
 cache read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\0=
00\000"
-/* offset=3D44121 */ "l1i-loads\000legacy cache\000Level 1 instruction cac=
he read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D44214 */ "l1i-loads-refs\000legacy cache\000Level 1 instructio=
n cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\=
000"
-/* offset=3D44312 */ "l1i-loads-reference\000legacy cache\000Level 1 instr=
uction cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000=
\000\000"
-/* offset=3D44415 */ "l1i-loads-ops\000legacy cache\000Level 1 instruction=
 cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\0=
00"
-/* offset=3D44512 */ "l1i-loads-access\000legacy cache\000Level 1 instruct=
ion cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\00=
0\000"
-/* offset=3D44612 */ "l1i-loads-misses\000legacy cache\000Level 1 instruct=
ion cache read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\00=
0\000\000"
-/* offset=3D44716 */ "l1i-loads-miss\000legacy cache\000Level 1 instructio=
n cache read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\=
000\000"
-/* offset=3D44818 */ "l1i-read\000legacy cache\000Level 1 instruction cach=
e read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D44910 */ "l1i-read-refs\000legacy cache\000Level 1 instruction=
 cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\0=
00"
-/* offset=3D45007 */ "l1i-read-reference\000legacy cache\000Level 1 instru=
ction cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\=
000\000"
-/* offset=3D45109 */ "l1i-read-ops\000legacy cache\000Level 1 instruction =
cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\00=
0"
-/* offset=3D45205 */ "l1i-read-access\000legacy cache\000Level 1 instructi=
on cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000=
\000"
-/* offset=3D45304 */ "l1i-read-misses\000legacy cache\000Level 1 instructi=
on cache read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000=
\000\000"
-/* offset=3D45407 */ "l1i-read-miss\000legacy cache\000Level 1 instruction=
 cache read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\0=
00\000"
-/* offset=3D45508 */ "l1i-prefetch\000legacy cache\000Level 1 instruction =
cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\00=
0\000\000"
-/* offset=3D45612 */ "l1i-prefetch-refs\000legacy cache\000Level 1 instruc=
tion cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\0=
00\000\000\000"
-/* offset=3D45721 */ "l1i-prefetch-reference\000legacy cache\000Level 1 in=
struction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\=
000\000\000\000\000"
-/* offset=3D45835 */ "l1i-prefetch-ops\000legacy cache\000Level 1 instruct=
ion cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\00=
0\000\000\000"
-/* offset=3D45943 */ "l1i-prefetch-access\000legacy cache\000Level 1 instr=
uction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000=
\000\000\000\000"
-/* offset=3D46054 */ "l1i-prefetch-misses\000legacy cache\000Level 1 instr=
uction cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000=
\000\000\000\000"
-/* offset=3D46165 */ "l1i-prefetch-miss\000legacy cache\000Level 1 instruc=
tion cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\0=
00\000\000\000"
-/* offset=3D46274 */ "l1i-prefetches\000legacy cache\000Level 1 instructio=
n cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\=
000\000\000"
-/* offset=3D46380 */ "l1i-prefetches-refs\000legacy cache\000Level 1 instr=
uction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000=
\000\000\000\000"
-/* offset=3D46491 */ "l1i-prefetches-reference\000legacy cache\000Level 1 =
instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\0001=
0\000\000\000\000\000"
-/* offset=3D46607 */ "l1i-prefetches-ops\000legacy cache\000Level 1 instru=
ction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\=
000\000\000\000"
-/* offset=3D46717 */ "l1i-prefetches-access\000legacy cache\000Level 1 ins=
truction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\0=
00\000\000\000\000"
-/* offset=3D46830 */ "l1i-prefetches-misses\000legacy cache\000Level 1 ins=
truction cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\0=
00\000\000\000\000"
-/* offset=3D46943 */ "l1i-prefetches-miss\000legacy cache\000Level 1 instr=
uction cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000=
\000\000\000\000"
-/* offset=3D47054 */ "l1i-speculative-read\000legacy cache\000Level 1 inst=
ruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\00=
0\000\000\000\000"
-/* offset=3D47166 */ "l1i-speculative-read-refs\000legacy cache\000Level 1=
 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\000=
10\000\000\000\000\000"
-/* offset=3D47283 */ "l1i-speculative-read-reference\000legacy cache\000Le=
vel 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\00=
0\00010\000\000\000\000\000"
-/* offset=3D47405 */ "l1i-speculative-read-ops\000legacy cache\000Level 1 =
instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\0001=
0\000\000\000\000\000"
-/* offset=3D47521 */ "l1i-speculative-read-access\000legacy cache\000Level=
 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\0=
0010\000\000\000\000\000"
-/* offset=3D47640 */ "l1i-speculative-read-misses\000legacy cache\000Level=
 1 instruction cache prefetch misses\000legacy-cache-config=3D0x10201\000\0=
0010\000\000\000\000\000"
-/* offset=3D47759 */ "l1i-speculative-read-miss\000legacy cache\000Level 1=
 instruction cache prefetch misses\000legacy-cache-config=3D0x10201\000\000=
10\000\000\000\000\000"
-/* offset=3D47876 */ "l1i-speculative-load\000legacy cache\000Level 1 inst=
ruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\00=
0\000\000\000\000"
-/* offset=3D47988 */ "l1i-speculative-load-refs\000legacy cache\000Level 1=
 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\000=
10\000\000\000\000\000"
-/* offset=3D48105 */ "l1i-speculative-load-reference\000legacy cache\000Le=
vel 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\00=
0\00010\000\000\000\000\000"
-/* offset=3D48227 */ "l1i-speculative-load-ops\000legacy cache\000Level 1 =
instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\0001=
0\000\000\000\000\000"
-/* offset=3D48343 */ "l1i-speculative-load-access\000legacy cache\000Level=
 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\0=
0010\000\000\000\000\000"
-/* offset=3D48462 */ "l1i-speculative-load-misses\000legacy cache\000Level=
 1 instruction cache prefetch misses\000legacy-cache-config=3D0x10201\000\0=
0010\000\000\000\000\000"
-/* offset=3D48581 */ "l1i-speculative-load-miss\000legacy cache\000Level 1=
 instruction cache prefetch misses\000legacy-cache-config=3D0x10201\000\000=
10\000\000\000\000\000"
-/* offset=3D48698 */ "l1i-refs\000legacy cache\000Level 1 instruction cach=
e read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D48790 */ "l1i-reference\000legacy cache\000Level 1 instruction=
 cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\0=
00"
-/* offset=3D48887 */ "l1i-ops\000legacy cache\000Level 1 instruction cache=
 read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D48978 */ "l1i-access\000legacy cache\000Level 1 instruction ca=
che read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D49072 */ "l1i-misses\000legacy cache\000Level 1 instruction ca=
che read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\=
000"
-/* offset=3D49170 */ "l1i-miss\000legacy cache\000Level 1 instruction cach=
e read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\00=
0"
-/* offset=3D49266 */ "l1-instruction\000legacy cache\000Level 1 instructio=
n cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\=
000"
-/* offset=3D49364 */ "l1-instruction-load\000legacy cache\000Level 1 instr=
uction cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000=
\000\000"
-/* offset=3D49467 */ "l1-instruction-load-refs\000legacy cache\000Level 1 =
instruction cache read accesses\000legacy-cache-config=3D1\000\00010\000\00=
0\000\000\000"
-/* offset=3D49575 */ "l1-instruction-load-reference\000legacy cache\000Lev=
el 1 instruction cache read accesses\000legacy-cache-config=3D1\000\00010\0=
00\000\000\000\000"
-/* offset=3D49688 */ "l1-instruction-load-ops\000legacy cache\000Level 1 i=
nstruction cache read accesses\000legacy-cache-config=3D1\000\00010\000\000=
\000\000\000"
-/* offset=3D49795 */ "l1-instruction-load-access\000legacy cache\000Level =
1 instruction cache read accesses\000legacy-cache-config=3D1\000\00010\000\=
000\000\000\000"
-/* offset=3D49905 */ "l1-instruction-load-misses\000legacy cache\000Level =
1 instruction cache read misses\000legacy-cache-config=3D0x10001\000\00010\=
000\000\000\000\000"
-/* offset=3D50019 */ "l1-instruction-load-miss\000legacy cache\000Level 1 =
instruction cache read misses\000legacy-cache-config=3D0x10001\000\00010\00=
0\000\000\000\000"
-/* offset=3D50131 */ "l1-instruction-loads\000legacy cache\000Level 1 inst=
ruction cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\00=
0\000\000"
-/* offset=3D50235 */ "l1-instruction-loads-refs\000legacy cache\000Level 1=
 instruction cache read accesses\000legacy-cache-config=3D1\000\00010\000\0=
00\000\000\000"
-/* offset=3D50344 */ "l1-instruction-loads-reference\000legacy cache\000Le=
vel 1 instruction cache read accesses\000legacy-cache-config=3D1\000\00010\=
000\000\000\000\000"
-/* offset=3D50458 */ "l1-instruction-loads-ops\000legacy cache\000Level 1 =
instruction cache read accesses\000legacy-cache-config=3D1\000\00010\000\00=
0\000\000\000"
-/* offset=3D50566 */ "l1-instruction-loads-access\000legacy cache\000Level=
 1 instruction cache read accesses\000legacy-cache-config=3D1\000\00010\000=
\000\000\000\000"
-/* offset=3D50677 */ "l1-instruction-loads-misses\000legacy cache\000Level=
 1 instruction cache read misses\000legacy-cache-config=3D0x10001\000\00010=
\000\000\000\000\000"
-/* offset=3D50792 */ "l1-instruction-loads-miss\000legacy cache\000Level 1=
 instruction cache read misses\000legacy-cache-config=3D0x10001\000\00010\0=
00\000\000\000\000"
-/* offset=3D50905 */ "l1-instruction-read\000legacy cache\000Level 1 instr=
uction cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000=
\000\000"
-/* offset=3D51008 */ "l1-instruction-read-refs\000legacy cache\000Level 1 =
instruction cache read accesses\000legacy-cache-config=3D1\000\00010\000\00=
0\000\000\000"
-/* offset=3D51116 */ "l1-instruction-read-reference\000legacy cache\000Lev=
el 1 instruction cache read accesses\000legacy-cache-config=3D1\000\00010\0=
00\000\000\000\000"
-/* offset=3D51229 */ "l1-instruction-read-ops\000legacy cache\000Level 1 i=
nstruction cache read accesses\000legacy-cache-config=3D1\000\00010\000\000=
\000\000\000"
-/* offset=3D51336 */ "l1-instruction-read-access\000legacy cache\000Level =
1 instruction cache read accesses\000legacy-cache-config=3D1\000\00010\000\=
000\000\000\000"
-/* offset=3D51446 */ "l1-instruction-read-misses\000legacy cache\000Level =
1 instruction cache read misses\000legacy-cache-config=3D0x10001\000\00010\=
000\000\000\000\000"
-/* offset=3D51560 */ "l1-instruction-read-miss\000legacy cache\000Level 1 =
instruction cache read misses\000legacy-cache-config=3D0x10001\000\00010\00=
0\000\000\000\000"
-/* offset=3D51672 */ "l1-instruction-prefetch\000legacy cache\000Level 1 i=
nstruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010=
\000\000\000\000\000"
-/* offset=3D51787 */ "l1-instruction-prefetch-refs\000legacy cache\000Leve=
l 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\=
00010\000\000\000\000\000"
-/* offset=3D51907 */ "l1-instruction-prefetch-reference\000legacy cache\00=
0Level 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201=
\000\00010\000\000\000\000\000"
-/* offset=3D52032 */ "l1-instruction-prefetch-ops\000legacy cache\000Level=
 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\0=
0010\000\000\000\000\000"
-/* offset=3D52151 */ "l1-instruction-prefetch-access\000legacy cache\000Le=
vel 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\00=
0\00010\000\000\000\000\000"
-/* offset=3D52273 */ "l1-instruction-prefetch-misses\000legacy cache\000Le=
vel 1 instruction cache prefetch misses\000legacy-cache-config=3D0x10201\00=
0\00010\000\000\000\000\000"
-/* offset=3D52395 */ "l1-instruction-prefetch-miss\000legacy cache\000Leve=
l 1 instruction cache prefetch misses\000legacy-cache-config=3D0x10201\000\=
00010\000\000\000\000\000"
-/* offset=3D52515 */ "l1-instruction-prefetches\000legacy cache\000Level 1=
 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\000=
10\000\000\000\000\000"
-/* offset=3D52632 */ "l1-instruction-prefetches-refs\000legacy cache\000Le=
vel 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\00=
0\00010\000\000\000\000\000"
-/* offset=3D52754 */ "l1-instruction-prefetches-reference\000legacy cache\=
000Level 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x2=
01\000\00010\000\000\000\000\000"
-/* offset=3D52881 */ "l1-instruction-prefetches-ops\000legacy cache\000Lev=
el 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000=
\00010\000\000\000\000\000"
-/* offset=3D53002 */ "l1-instruction-prefetches-access\000legacy cache\000=
Level 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\=
000\00010\000\000\000\000\000"
-/* offset=3D53126 */ "l1-instruction-prefetches-misses\000legacy cache\000=
Level 1 instruction cache prefetch misses\000legacy-cache-config=3D0x10201\=
000\00010\000\000\000\000\000"
-/* offset=3D53250 */ "l1-instruction-prefetches-miss\000legacy cache\000Le=
vel 1 instruction cache prefetch misses\000legacy-cache-config=3D0x10201\00=
0\00010\000\000\000\000\000"
-/* offset=3D53372 */ "l1-instruction-speculative-read\000legacy cache\000L=
evel 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\0=
00\00010\000\000\000\000\000"
-/* offset=3D53495 */ "l1-instruction-speculative-read-refs\000legacy cache=
\000Level 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x=
201\000\00010\000\000\000\000\000"
-/* offset=3D53623 */ "l1-instruction-speculative-read-reference\000legacy =
cache\000Level 1 instruction cache prefetch accesses\000legacy-cache-config=
=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D53756 */ "l1-instruction-speculative-read-ops\000legacy cache\=
000Level 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x2=
01\000\00010\000\000\000\000\000"
-/* offset=3D53883 */ "l1-instruction-speculative-read-access\000legacy cac=
he\000Level 1 instruction cache prefetch accesses\000legacy-cache-config=3D=
0x201\000\00010\000\000\000\000\000"
-/* offset=3D54013 */ "l1-instruction-speculative-read-misses\000legacy cac=
he\000Level 1 instruction cache prefetch misses\000legacy-cache-config=3D0x=
10201\000\00010\000\000\000\000\000"
-/* offset=3D54143 */ "l1-instruction-speculative-read-miss\000legacy cache=
\000Level 1 instruction cache prefetch misses\000legacy-cache-config=3D0x10=
201\000\00010\000\000\000\000\000"
-/* offset=3D54271 */ "l1-instruction-speculative-load\000legacy cache\000L=
evel 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\0=
00\00010\000\000\000\000\000"
-/* offset=3D54394 */ "l1-instruction-speculative-load-refs\000legacy cache=
\000Level 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x=
201\000\00010\000\000\000\000\000"
-/* offset=3D54522 */ "l1-instruction-speculative-load-reference\000legacy =
cache\000Level 1 instruction cache prefetch accesses\000legacy-cache-config=
=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D54655 */ "l1-instruction-speculative-load-ops\000legacy cache\=
000Level 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x2=
01\000\00010\000\000\000\000\000"
-/* offset=3D54782 */ "l1-instruction-speculative-load-access\000legacy cac=
he\000Level 1 instruction cache prefetch accesses\000legacy-cache-config=3D=
0x201\000\00010\000\000\000\000\000"
-/* offset=3D54912 */ "l1-instruction-speculative-load-misses\000legacy cac=
he\000Level 1 instruction cache prefetch misses\000legacy-cache-config=3D0x=
10201\000\00010\000\000\000\000\000"
-/* offset=3D55042 */ "l1-instruction-speculative-load-miss\000legacy cache=
\000Level 1 instruction cache prefetch misses\000legacy-cache-config=3D0x10=
201\000\00010\000\000\000\000\000"
-/* offset=3D55170 */ "l1-instruction-refs\000legacy cache\000Level 1 instr=
uction cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000=
\000\000"
-/* offset=3D55273 */ "l1-instruction-reference\000legacy cache\000Level 1 =
instruction cache read accesses\000legacy-cache-config=3D1\000\00010\000\00=
0\000\000\000"
-/* offset=3D55381 */ "l1-instruction-ops\000legacy cache\000Level 1 instru=
ction cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\=
000\000"
-/* offset=3D55483 */ "l1-instruction-access\000legacy cache\000Level 1 ins=
truction cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\0=
00\000\000"
-/* offset=3D55588 */ "l1-instruction-misses\000legacy cache\000Level 1 ins=
truction cache read misses\000legacy-cache-config=3D0x10001\000\00010\000\0=
00\000\000\000"
-/* offset=3D55697 */ "l1-instruction-miss\000legacy cache\000Level 1 instr=
uction cache read misses\000legacy-cache-config=3D0x10001\000\00010\000\000=
\000\000\000"
-/* offset=3D55804 */ "llc\000legacy cache\000Last level cache read accesse=
s\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D55882 */ "llc-load\000legacy cache\000Last level cache read ac=
cesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D55965 */ "llc-load-refs\000legacy cache\000Last level cache re=
ad accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D56053 */ "llc-load-reference\000legacy cache\000Last level cac=
he read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D56146 */ "llc-load-ops\000legacy cache\000Last level cache rea=
d accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D56233 */ "llc-load-access\000legacy cache\000Last level cache =
read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D56323 */ "llc-load-misses\000legacy cache\000Last level cache =
read misses\000legacy-cache-config=3D0x10002\000\00000\000\000\000\000\000"
-/* offset=3D56417 */ "llc-load-miss\000legacy cache\000Last level cache re=
ad misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D56509 */ "llc-loads\000legacy cache\000Last level cache read a=
ccesses\000legacy-cache-config=3D2\000\00000\000\000\000\000\000"
-/* offset=3D56593 */ "llc-loads-refs\000legacy cache\000Last level cache r=
ead accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D56682 */ "llc-loads-reference\000legacy cache\000Last level ca=
che read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D56776 */ "llc-loads-ops\000legacy cache\000Last level cache re=
ad accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D56864 */ "llc-loads-access\000legacy cache\000Last level cache=
 read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D56955 */ "llc-loads-misses\000legacy cache\000Last level cache=
 read misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000=
"
-/* offset=3D57050 */ "llc-loads-miss\000legacy cache\000Last level cache r=
ead misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D57143 */ "llc-read\000legacy cache\000Last level cache read ac=
cesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D57226 */ "llc-read-refs\000legacy cache\000Last level cache re=
ad accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D57314 */ "llc-read-reference\000legacy cache\000Last level cac=
he read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D57407 */ "llc-read-ops\000legacy cache\000Last level cache rea=
d accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D57494 */ "llc-read-access\000legacy cache\000Last level cache =
read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D57584 */ "llc-read-misses\000legacy cache\000Last level cache =
read misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D57678 */ "llc-read-miss\000legacy cache\000Last level cache re=
ad misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D57770 */ "llc-store\000legacy cache\000Last level cache write =
accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D57859 */ "llc-store-refs\000legacy cache\000Last level cache w=
rite accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D57953 */ "llc-store-reference\000legacy cache\000Last level ca=
che write accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000=
\000"
-/* offset=3D58052 */ "llc-store-ops\000legacy cache\000Last level cache wr=
ite accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D58145 */ "llc-store-access\000legacy cache\000Last level cache=
 write accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\00=
0"
-/* offset=3D58241 */ "llc-store-misses\000legacy cache\000Last level cache=
 write misses\000legacy-cache-config=3D0x10102\000\00000\000\000\000\000\00=
0"
-/* offset=3D58337 */ "llc-store-miss\000legacy cache\000Last level cache w=
rite misses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\000"
-/* offset=3D58431 */ "llc-stores\000legacy cache\000Last level cache write=
 accesses\000legacy-cache-config=3D0x102\000\00000\000\000\000\000\000"
-/* offset=3D58521 */ "llc-stores-refs\000legacy cache\000Last level cache =
write accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000=
"
-/* offset=3D58616 */ "llc-stores-reference\000legacy cache\000Last level c=
ache write accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\00=
0\000"
-/* offset=3D58716 */ "llc-stores-ops\000legacy cache\000Last level cache w=
rite accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D58810 */ "llc-stores-access\000legacy cache\000Last level cach=
e write accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\0=
00"
-/* offset=3D58907 */ "llc-stores-misses\000legacy cache\000Last level cach=
e write misses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\0=
00"
-/* offset=3D59004 */ "llc-stores-miss\000legacy cache\000Last level cache =
write misses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\000=
"
-/* offset=3D59099 */ "llc-write\000legacy cache\000Last level cache write =
accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D59188 */ "llc-write-refs\000legacy cache\000Last level cache w=
rite accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D59282 */ "llc-write-reference\000legacy cache\000Last level ca=
che write accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000=
\000"
-/* offset=3D59381 */ "llc-write-ops\000legacy cache\000Last level cache wr=
ite accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D59474 */ "llc-write-access\000legacy cache\000Last level cache=
 write accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\00=
0"
-/* offset=3D59570 */ "llc-write-misses\000legacy cache\000Last level cache=
 write misses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\00=
0"
-/* offset=3D59666 */ "llc-write-miss\000legacy cache\000Last level cache w=
rite misses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\000"
-/* offset=3D59760 */ "llc-prefetch\000legacy cache\000Last level cache pre=
fetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000=
"
-/* offset=3D59855 */ "llc-prefetch-refs\000legacy cache\000Last level cach=
e prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\00=
0\000"
-/* offset=3D59955 */ "llc-prefetch-reference\000legacy cache\000Last level=
 cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\0=
00\000\000"
-/* offset=3D60060 */ "llc-prefetch-ops\000legacy cache\000Last level cache=
 prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000=
\000"
-/* offset=3D60159 */ "llc-prefetch-access\000legacy cache\000Last level ca=
che prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\=
000\000"
-/* offset=3D60261 */ "llc-prefetch-misses\000legacy cache\000Last level ca=
che prefetch misses\000legacy-cache-config=3D0x10202\000\00000\000\000\000\=
000\000"
-/* offset=3D60363 */ "llc-prefetch-miss\000legacy cache\000Last level cach=
e prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\00=
0\000"
-/* offset=3D60463 */ "llc-prefetches\000legacy cache\000Last level cache p=
refetch accesses\000legacy-cache-config=3D0x202\000\00000\000\000\000\000\0=
00"
-/* offset=3D60560 */ "llc-prefetches-refs\000legacy cache\000Last level ca=
che prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\=
000\000"
-/* offset=3D60662 */ "llc-prefetches-reference\000legacy cache\000Last lev=
el cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000=
\000\000\000"
-/* offset=3D60769 */ "llc-prefetches-ops\000legacy cache\000Last level cac=
he prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\0=
00\000"
-/* offset=3D60870 */ "llc-prefetches-access\000legacy cache\000Last level =
cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\00=
0\000\000"
-/* offset=3D60974 */ "llc-prefetches-misses\000legacy cache\000Last level =
cache prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\00=
0\000\000"
-/* offset=3D61078 */ "llc-prefetches-miss\000legacy cache\000Last level ca=
che prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\=
000\000"
-/* offset=3D61180 */ "llc-speculative-read\000legacy cache\000Last level c=
ache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000=
\000\000"
-/* offset=3D61283 */ "llc-speculative-read-refs\000legacy cache\000Last le=
vel cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\00=
0\000\000\000"
-/* offset=3D61391 */ "llc-speculative-read-reference\000legacy cache\000La=
st level cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\0=
00\000\000\000\000"
-/* offset=3D61504 */ "llc-speculative-read-ops\000legacy cache\000Last lev=
el cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000=
\000\000\000"
-/* offset=3D61611 */ "llc-speculative-read-access\000legacy cache\000Last =
level cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\=
000\000\000\000"
-/* offset=3D61721 */ "llc-speculative-read-misses\000legacy cache\000Last =
level cache prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\=
000\000\000\000"
-/* offset=3D61831 */ "llc-speculative-read-miss\000legacy cache\000Last le=
vel cache prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\00=
0\000\000\000"
-/* offset=3D61939 */ "llc-speculative-load\000legacy cache\000Last level c=
ache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000=
\000\000"
-/* offset=3D62042 */ "llc-speculative-load-refs\000legacy cache\000Last le=
vel cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\00=
0\000\000\000"
-/* offset=3D62150 */ "llc-speculative-load-reference\000legacy cache\000La=
st level cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\0=
00\000\000\000\000"
-/* offset=3D62263 */ "llc-speculative-load-ops\000legacy cache\000Last lev=
el cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000=
\000\000\000"
-/* offset=3D62370 */ "llc-speculative-load-access\000legacy cache\000Last =
level cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\=
000\000\000\000"
-/* offset=3D62480 */ "llc-speculative-load-misses\000legacy cache\000Last =
level cache prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\=
000\000\000\000"
-/* offset=3D62590 */ "llc-speculative-load-miss\000legacy cache\000Last le=
vel cache prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\00=
0\000\000\000"
-/* offset=3D62698 */ "llc-refs\000legacy cache\000Last level cache read ac=
cesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D62781 */ "llc-reference\000legacy cache\000Last level cache re=
ad accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D62869 */ "llc-ops\000legacy cache\000Last level cache read acc=
esses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D62951 */ "llc-access\000legacy cache\000Last level cache read =
accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D63036 */ "llc-misses\000legacy cache\000Last level cache read =
misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D63125 */ "llc-miss\000legacy cache\000Last level cache read mi=
sses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D63212 */ "l2\000legacy cache\000Level 2 (or higher) last level=
 cache read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\0=
00"
-/* offset=3D63309 */ "l2-load\000legacy cache\000Level 2 (or higher) last =
level cache read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\=
000\000"
-/* offset=3D63411 */ "l2-load-refs\000legacy cache\000Level 2 (or higher) =
last level cache read accesses\000legacy-cache-config=3D2\000\00010\000\000=
\000\000\000"
-/* offset=3D63518 */ "l2-load-reference\000legacy cache\000Level 2 (or hig=
her) last level cache read accesses\000legacy-cache-config=3D2\000\00010\00=
0\000\000\000\000"
-/* offset=3D63630 */ "l2-load-ops\000legacy cache\000Level 2 (or higher) l=
ast level cache read accesses\000legacy-cache-config=3D2\000\00010\000\000\=
000\000\000"
-/* offset=3D63736 */ "l2-load-access\000legacy cache\000Level 2 (or higher=
) last level cache read accesses\000legacy-cache-config=3D2\000\00010\000\0=
00\000\000\000"
-/* offset=3D63845 */ "l2-load-misses\000legacy cache\000Level 2 (or higher=
) last level cache read misses\000legacy-cache-config=3D0x10002\000\00010\0=
00\000\000\000\000"
-/* offset=3D63958 */ "l2-load-miss\000legacy cache\000Level 2 (or higher) =
last level cache read misses\000legacy-cache-config=3D0x10002\000\00010\000=
\000\000\000\000"
-/* offset=3D64069 */ "l2-loads\000legacy cache\000Level 2 (or higher) last=
 level cache read accesses\000legacy-cache-config=3D2\000\00010\000\000\000=
\000\000"
-/* offset=3D64172 */ "l2-loads-refs\000legacy cache\000Level 2 (or higher)=
 last level cache read accesses\000legacy-cache-config=3D2\000\00010\000\00=
0\000\000\000"
-/* offset=3D64280 */ "l2-loads-reference\000legacy cache\000Level 2 (or hi=
gher) last level cache read accesses\000legacy-cache-config=3D2\000\00010\0=
00\000\000\000\000"
-/* offset=3D64393 */ "l2-loads-ops\000legacy cache\000Level 2 (or higher) =
last level cache read accesses\000legacy-cache-config=3D2\000\00010\000\000=
\000\000\000"
-/* offset=3D64500 */ "l2-loads-access\000legacy cache\000Level 2 (or highe=
r) last level cache read accesses\000legacy-cache-config=3D2\000\00010\000\=
000\000\000\000"
-/* offset=3D64610 */ "l2-loads-misses\000legacy cache\000Level 2 (or highe=
r) last level cache read misses\000legacy-cache-config=3D0x10002\000\00010\=
000\000\000\000\000"
-/* offset=3D64724 */ "l2-loads-miss\000legacy cache\000Level 2 (or higher)=
 last level cache read misses\000legacy-cache-config=3D0x10002\000\00010\00=
0\000\000\000\000"
-/* offset=3D64836 */ "l2-read\000legacy cache\000Level 2 (or higher) last =
level cache read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\=
000\000"
-/* offset=3D64938 */ "l2-read-refs\000legacy cache\000Level 2 (or higher) =
last level cache read accesses\000legacy-cache-config=3D2\000\00010\000\000=
\000\000\000"
-/* offset=3D65045 */ "l2-read-reference\000legacy cache\000Level 2 (or hig=
her) last level cache read accesses\000legacy-cache-config=3D2\000\00010\00=
0\000\000\000\000"
-/* offset=3D65157 */ "l2-read-ops\000legacy cache\000Level 2 (or higher) l=
ast level cache read accesses\000legacy-cache-config=3D2\000\00010\000\000\=
000\000\000"
-/* offset=3D65263 */ "l2-read-access\000legacy cache\000Level 2 (or higher=
) last level cache read accesses\000legacy-cache-config=3D2\000\00010\000\0=
00\000\000\000"
-/* offset=3D65372 */ "l2-read-misses\000legacy cache\000Level 2 (or higher=
) last level cache read misses\000legacy-cache-config=3D0x10002\000\00010\0=
00\000\000\000\000"
-/* offset=3D65485 */ "l2-read-miss\000legacy cache\000Level 2 (or higher) =
last level cache read misses\000legacy-cache-config=3D0x10002\000\00010\000=
\000\000\000\000"
-/* offset=3D65596 */ "l2-store\000legacy cache\000Level 2 (or higher) last=
 level cache write accesses\000legacy-cache-config=3D0x102\000\00010\000\00=
0\000\000\000"
-/* offset=3D65704 */ "l2-store-refs\000legacy cache\000Level 2 (or higher)=
 last level cache write accesses\000legacy-cache-config=3D0x102\000\00010\0=
00\000\000\000\000"
-/* offset=3D65817 */ "l2-store-reference\000legacy cache\000Level 2 (or hi=
gher) last level cache write accesses\000legacy-cache-config=3D0x102\000\00=
010\000\000\000\000\000"
-/* offset=3D65935 */ "l2-store-ops\000legacy cache\000Level 2 (or higher) =
last level cache write accesses\000legacy-cache-config=3D0x102\000\00010\00=
0\000\000\000\000"
-/* offset=3D66047 */ "l2-store-access\000legacy cache\000Level 2 (or highe=
r) last level cache write accesses\000legacy-cache-config=3D0x102\000\00010=
\000\000\000\000\000"
-/* offset=3D66162 */ "l2-store-misses\000legacy cache\000Level 2 (or highe=
r) last level cache write misses\000legacy-cache-config=3D0x10102\000\00010=
\000\000\000\000\000"
-/* offset=3D66277 */ "l2-store-miss\000legacy cache\000Level 2 (or higher)=
 last level cache write misses\000legacy-cache-config=3D0x10102\000\00010\0=
00\000\000\000\000"
-/* offset=3D66390 */ "l2-stores\000legacy cache\000Level 2 (or higher) las=
t level cache write accesses\000legacy-cache-config=3D0x102\000\00010\000\0=
00\000\000\000"
-/* offset=3D66499 */ "l2-stores-refs\000legacy cache\000Level 2 (or higher=
) last level cache write accesses\000legacy-cache-config=3D0x102\000\00010\=
000\000\000\000\000"
-/* offset=3D66613 */ "l2-stores-reference\000legacy cache\000Level 2 (or h=
igher) last level cache write accesses\000legacy-cache-config=3D0x102\000\0=
0010\000\000\000\000\000"
-/* offset=3D66732 */ "l2-stores-ops\000legacy cache\000Level 2 (or higher)=
 last level cache write accesses\000legacy-cache-config=3D0x102\000\00010\0=
00\000\000\000\000"
-/* offset=3D66845 */ "l2-stores-access\000legacy cache\000Level 2 (or high=
er) last level cache write accesses\000legacy-cache-config=3D0x102\000\0001=
0\000\000\000\000\000"
-/* offset=3D66961 */ "l2-stores-misses\000legacy cache\000Level 2 (or high=
er) last level cache write misses\000legacy-cache-config=3D0x10102\000\0001=
0\000\000\000\000\000"
-/* offset=3D67077 */ "l2-stores-miss\000legacy cache\000Level 2 (or higher=
) last level cache write misses\000legacy-cache-config=3D0x10102\000\00010\=
000\000\000\000\000"
-/* offset=3D67191 */ "l2-write\000legacy cache\000Level 2 (or higher) last=
 level cache write accesses\000legacy-cache-config=3D0x102\000\00010\000\00=
0\000\000\000"
-/* offset=3D67299 */ "l2-write-refs\000legacy cache\000Level 2 (or higher)=
 last level cache write accesses\000legacy-cache-config=3D0x102\000\00010\0=
00\000\000\000\000"
-/* offset=3D67412 */ "l2-write-reference\000legacy cache\000Level 2 (or hi=
gher) last level cache write accesses\000legacy-cache-config=3D0x102\000\00=
010\000\000\000\000\000"
-/* offset=3D67530 */ "l2-write-ops\000legacy cache\000Level 2 (or higher) =
last level cache write accesses\000legacy-cache-config=3D0x102\000\00010\00=
0\000\000\000\000"
-/* offset=3D67642 */ "l2-write-access\000legacy cache\000Level 2 (or highe=
r) last level cache write accesses\000legacy-cache-config=3D0x102\000\00010=
\000\000\000\000\000"
-/* offset=3D67757 */ "l2-write-misses\000legacy cache\000Level 2 (or highe=
r) last level cache write misses\000legacy-cache-config=3D0x10102\000\00010=
\000\000\000\000\000"
-/* offset=3D67872 */ "l2-write-miss\000legacy cache\000Level 2 (or higher)=
 last level cache write misses\000legacy-cache-config=3D0x10102\000\00010\0=
00\000\000\000\000"
-/* offset=3D67985 */ "l2-prefetch\000legacy cache\000Level 2 (or higher) l=
ast level cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\=
000\000\000\000\000"
-/* offset=3D68099 */ "l2-prefetch-refs\000legacy cache\000Level 2 (or high=
er) last level cache prefetch accesses\000legacy-cache-config=3D0x202\000\0=
0010\000\000\000\000\000"
-/* offset=3D68218 */ "l2-prefetch-reference\000legacy cache\000Level 2 (or=
 higher) last level cache prefetch accesses\000legacy-cache-config=3D0x202\=
000\00010\000\000\000\000\000"
-/* offset=3D68342 */ "l2-prefetch-ops\000legacy cache\000Level 2 (or highe=
r) last level cache prefetch accesses\000legacy-cache-config=3D0x202\000\00=
010\000\000\000\000\000"
-/* offset=3D68460 */ "l2-prefetch-access\000legacy cache\000Level 2 (or hi=
gher) last level cache prefetch accesses\000legacy-cache-config=3D0x202\000=
\00010\000\000\000\000\000"
-/* offset=3D68581 */ "l2-prefetch-misses\000legacy cache\000Level 2 (or hi=
gher) last level cache prefetch misses\000legacy-cache-config=3D0x10202\000=
\00010\000\000\000\000\000"
-/* offset=3D68702 */ "l2-prefetch-miss\000legacy cache\000Level 2 (or high=
er) last level cache prefetch misses\000legacy-cache-config=3D0x10202\000\0=
0010\000\000\000\000\000"
-/* offset=3D68821 */ "l2-prefetches\000legacy cache\000Level 2 (or higher)=
 last level cache prefetch accesses\000legacy-cache-config=3D0x202\000\0001=
0\000\000\000\000\000"
-/* offset=3D68937 */ "l2-prefetches-refs\000legacy cache\000Level 2 (or hi=
gher) last level cache prefetch accesses\000legacy-cache-config=3D0x202\000=
\00010\000\000\000\000\000"
-/* offset=3D69058 */ "l2-prefetches-reference\000legacy cache\000Level 2 (=
or higher) last level cache prefetch accesses\000legacy-cache-config=3D0x20=
2\000\00010\000\000\000\000\000"
-/* offset=3D69184 */ "l2-prefetches-ops\000legacy cache\000Level 2 (or hig=
her) last level cache prefetch accesses\000legacy-cache-config=3D0x202\000\=
00010\000\000\000\000\000"
-/* offset=3D69304 */ "l2-prefetches-access\000legacy cache\000Level 2 (or =
higher) last level cache prefetch accesses\000legacy-cache-config=3D0x202\0=
00\00010\000\000\000\000\000"
-/* offset=3D69427 */ "l2-prefetches-misses\000legacy cache\000Level 2 (or =
higher) last level cache prefetch misses\000legacy-cache-config=3D0x10202\0=
00\00010\000\000\000\000\000"
-/* offset=3D69550 */ "l2-prefetches-miss\000legacy cache\000Level 2 (or hi=
gher) last level cache prefetch misses\000legacy-cache-config=3D0x10202\000=
\00010\000\000\000\000\000"
-/* offset=3D69671 */ "l2-speculative-read\000legacy cache\000Level 2 (or h=
igher) last level cache prefetch accesses\000legacy-cache-config=3D0x202\00=
0\00010\000\000\000\000\000"
-/* offset=3D69793 */ "l2-speculative-read-refs\000legacy cache\000Level 2 =
(or higher) last level cache prefetch accesses\000legacy-cache-config=3D0x2=
02\000\00010\000\000\000\000\000"
-/* offset=3D69920 */ "l2-speculative-read-reference\000legacy cache\000Lev=
el 2 (or higher) last level cache prefetch accesses\000legacy-cache-config=
=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D70052 */ "l2-speculative-read-ops\000legacy cache\000Level 2 (=
or higher) last level cache prefetch accesses\000legacy-cache-config=3D0x20=
2\000\00010\000\000\000\000\000"
-/* offset=3D70178 */ "l2-speculative-read-access\000legacy cache\000Level =
2 (or higher) last level cache prefetch accesses\000legacy-cache-config=3D0=
x202\000\00010\000\000\000\000\000"
-/* offset=3D70307 */ "l2-speculative-read-misses\000legacy cache\000Level =
2 (or higher) last level cache prefetch misses\000legacy-cache-config=3D0x1=
0202\000\00010\000\000\000\000\000"
-/* offset=3D70436 */ "l2-speculative-read-miss\000legacy cache\000Level 2 =
(or higher) last level cache prefetch misses\000legacy-cache-config=3D0x102=
02\000\00010\000\000\000\000\000"
-/* offset=3D70563 */ "l2-speculative-load\000legacy cache\000Level 2 (or h=
igher) last level cache prefetch accesses\000legacy-cache-config=3D0x202\00=
0\00010\000\000\000\000\000"
-/* offset=3D70685 */ "l2-speculative-load-refs\000legacy cache\000Level 2 =
(or higher) last level cache prefetch accesses\000legacy-cache-config=3D0x2=
02\000\00010\000\000\000\000\000"
-/* offset=3D70812 */ "l2-speculative-load-reference\000legacy cache\000Lev=
el 2 (or higher) last level cache prefetch accesses\000legacy-cache-config=
=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D70944 */ "l2-speculative-load-ops\000legacy cache\000Level 2 (=
or higher) last level cache prefetch accesses\000legacy-cache-config=3D0x20=
2\000\00010\000\000\000\000\000"
-/* offset=3D71070 */ "l2-speculative-load-access\000legacy cache\000Level =
2 (or higher) last level cache prefetch accesses\000legacy-cache-config=3D0=
x202\000\00010\000\000\000\000\000"
-/* offset=3D71199 */ "l2-speculative-load-misses\000legacy cache\000Level =
2 (or higher) last level cache prefetch misses\000legacy-cache-config=3D0x1=
0202\000\00010\000\000\000\000\000"
-/* offset=3D71328 */ "l2-speculative-load-miss\000legacy cache\000Level 2 =
(or higher) last level cache prefetch misses\000legacy-cache-config=3D0x102=
02\000\00010\000\000\000\000\000"
-/* offset=3D71455 */ "l2-refs\000legacy cache\000Level 2 (or higher) last =
level cache read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\=
000\000"
-/* offset=3D71557 */ "l2-reference\000legacy cache\000Level 2 (or higher) =
last level cache read accesses\000legacy-cache-config=3D2\000\00010\000\000=
\000\000\000"
-/* offset=3D71664 */ "l2-ops\000legacy cache\000Level 2 (or higher) last l=
evel cache read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\0=
00\000"
-/* offset=3D71765 */ "l2-access\000legacy cache\000Level 2 (or higher) las=
t level cache read accesses\000legacy-cache-config=3D2\000\00010\000\000\00=
0\000\000"
-/* offset=3D71869 */ "l2-misses\000legacy cache\000Level 2 (or higher) las=
t level cache read misses\000legacy-cache-config=3D0x10002\000\00010\000\00=
0\000\000\000"
-/* offset=3D71977 */ "l2-miss\000legacy cache\000Level 2 (or higher) last =
level cache read misses\000legacy-cache-config=3D0x10002\000\00010\000\000\=
000\000\000"
-/* offset=3D72083 */ "dtlb\000legacy cache\000Data TLB read accesses\000le=
gacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D72154 */ "dtlb-load\000legacy cache\000Data TLB read accesses\=
000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D72230 */ "dtlb-load-refs\000legacy cache\000Data TLB read acce=
sses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D72311 */ "dtlb-load-reference\000legacy cache\000Data TLB read=
 accesses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D72397 */ "dtlb-load-ops\000legacy cache\000Data TLB read acces=
ses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D72477 */ "dtlb-load-access\000legacy cache\000Data TLB read ac=
cesses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D72560 */ "dtlb-load-misses\000legacy cache\000Data TLB read mi=
sses\000legacy-cache-config=3D0x10003\000\00000\000\000\000\000\000"
-/* offset=3D72647 */ "dtlb-load-miss\000legacy cache\000Data TLB read miss=
es\000legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D72732 */ "dtlb-loads\000legacy cache\000Data TLB read accesses=
\000legacy-cache-config=3D3\000\00000\000\000\000\000\000"
-/* offset=3D72809 */ "dtlb-loads-refs\000legacy cache\000Data TLB read acc=
esses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D72891 */ "dtlb-loads-reference\000legacy cache\000Data TLB rea=
d accesses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D72978 */ "dtlb-loads-ops\000legacy cache\000Data TLB read acce=
sses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D73059 */ "dtlb-loads-access\000legacy cache\000Data TLB read a=
ccesses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D73143 */ "dtlb-loads-misses\000legacy cache\000Data TLB read m=
isses\000legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D73231 */ "dtlb-loads-miss\000legacy cache\000Data TLB read mis=
ses\000legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D73317 */ "dtlb-read\000legacy cache\000Data TLB read accesses\=
000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D73393 */ "dtlb-read-refs\000legacy cache\000Data TLB read acce=
sses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D73474 */ "dtlb-read-reference\000legacy cache\000Data TLB read=
 accesses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D73560 */ "dtlb-read-ops\000legacy cache\000Data TLB read acces=
ses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D73640 */ "dtlb-read-access\000legacy cache\000Data TLB read ac=
cesses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D73723 */ "dtlb-read-misses\000legacy cache\000Data TLB read mi=
sses\000legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D73810 */ "dtlb-read-miss\000legacy cache\000Data TLB read miss=
es\000legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D73895 */ "dtlb-store\000legacy cache\000Data TLB write accesse=
s\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D73977 */ "dtlb-store-refs\000legacy cache\000Data TLB write ac=
cesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D74064 */ "dtlb-store-reference\000legacy cache\000Data TLB wri=
te accesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D74156 */ "dtlb-store-ops\000legacy cache\000Data TLB write acc=
esses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D74242 */ "dtlb-store-access\000legacy cache\000Data TLB write =
accesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D74331 */ "dtlb-store-misses\000legacy cache\000Data TLB write =
misses\000legacy-cache-config=3D0x10103\000\00000\000\000\000\000\000"
-/* offset=3D74420 */ "dtlb-store-miss\000legacy cache\000Data TLB write mi=
sses\000legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D74507 */ "dtlb-stores\000legacy cache\000Data TLB write access=
es\000legacy-cache-config=3D0x103\000\00000\000\000\000\000\000"
-/* offset=3D74590 */ "dtlb-stores-refs\000legacy cache\000Data TLB write a=
ccesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D74678 */ "dtlb-stores-reference\000legacy cache\000Data TLB wr=
ite accesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D74771 */ "dtlb-stores-ops\000legacy cache\000Data TLB write ac=
cesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D74858 */ "dtlb-stores-access\000legacy cache\000Data TLB write=
 accesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D74948 */ "dtlb-stores-misses\000legacy cache\000Data TLB write=
 misses\000legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D75038 */ "dtlb-stores-miss\000legacy cache\000Data TLB write m=
isses\000legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D75126 */ "dtlb-write\000legacy cache\000Data TLB write accesse=
s\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D75208 */ "dtlb-write-refs\000legacy cache\000Data TLB write ac=
cesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D75295 */ "dtlb-write-reference\000legacy cache\000Data TLB wri=
te accesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D75387 */ "dtlb-write-ops\000legacy cache\000Data TLB write acc=
esses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D75473 */ "dtlb-write-access\000legacy cache\000Data TLB write =
accesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D75562 */ "dtlb-write-misses\000legacy cache\000Data TLB write =
misses\000legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D75651 */ "dtlb-write-miss\000legacy cache\000Data TLB write mi=
sses\000legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D75738 */ "dtlb-prefetch\000legacy cache\000Data TLB prefetch a=
ccesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D75826 */ "dtlb-prefetch-refs\000legacy cache\000Data TLB prefe=
tch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D75919 */ "dtlb-prefetch-reference\000legacy cache\000Data TLB =
prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\=
000"
-/* offset=3D76017 */ "dtlb-prefetch-ops\000legacy cache\000Data TLB prefet=
ch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D76109 */ "dtlb-prefetch-access\000legacy cache\000Data TLB pre=
fetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000=
"
-/* offset=3D76204 */ "dtlb-prefetch-misses\000legacy cache\000Data TLB pre=
fetch misses\000legacy-cache-config=3D0x10203\000\00000\000\000\000\000\000=
"
-/* offset=3D76299 */ "dtlb-prefetch-miss\000legacy cache\000Data TLB prefe=
tch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
-/* offset=3D76392 */ "dtlb-prefetches\000legacy cache\000Data TLB prefetch=
 accesses\000legacy-cache-config=3D0x203\000\00000\000\000\000\000\000"
-/* offset=3D76482 */ "dtlb-prefetches-refs\000legacy cache\000Data TLB pre=
fetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000=
"
-/* offset=3D76577 */ "dtlb-prefetches-reference\000legacy cache\000Data TL=
B prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\00=
0\000"
-/* offset=3D76677 */ "dtlb-prefetches-ops\000legacy cache\000Data TLB pref=
etch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D76771 */ "dtlb-prefetches-access\000legacy cache\000Data TLB p=
refetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\0=
00"
-/* offset=3D76868 */ "dtlb-prefetches-misses\000legacy cache\000Data TLB p=
refetch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\0=
00"
-/* offset=3D76965 */ "dtlb-prefetches-miss\000legacy cache\000Data TLB pre=
fetch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000=
"
-/* offset=3D77060 */ "dtlb-speculative-read\000legacy cache\000Data TLB pr=
efetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\00=
0"
-/* offset=3D77156 */ "dtlb-speculative-read-refs\000legacy cache\000Data T=
LB prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\0=
00\000"
-/* offset=3D77257 */ "dtlb-speculative-read-reference\000legacy cache\000D=
ata TLB prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\=
000\000\000"
-/* offset=3D77363 */ "dtlb-speculative-read-ops\000legacy cache\000Data TL=
B prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\00=
0\000"
-/* offset=3D77463 */ "dtlb-speculative-read-access\000legacy cache\000Data=
 TLB prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000=
\000\000"
-/* offset=3D77566 */ "dtlb-speculative-read-misses\000legacy cache\000Data=
 TLB prefetch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000=
\000\000"
-/* offset=3D77669 */ "dtlb-speculative-read-miss\000legacy cache\000Data T=
LB prefetch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\0=
00\000"
-/* offset=3D77770 */ "dtlb-speculative-load\000legacy cache\000Data TLB pr=
efetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\00=
0"
-/* offset=3D77866 */ "dtlb-speculative-load-refs\000legacy cache\000Data T=
LB prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\0=
00\000"
-/* offset=3D77967 */ "dtlb-speculative-load-reference\000legacy cache\000D=
ata TLB prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\=
000\000\000"
-/* offset=3D78073 */ "dtlb-speculative-load-ops\000legacy cache\000Data TL=
B prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\00=
0\000"
-/* offset=3D78173 */ "dtlb-speculative-load-access\000legacy cache\000Data=
 TLB prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000=
\000\000"
-/* offset=3D78276 */ "dtlb-speculative-load-misses\000legacy cache\000Data=
 TLB prefetch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000=
\000\000"
-/* offset=3D78379 */ "dtlb-speculative-load-miss\000legacy cache\000Data T=
LB prefetch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\0=
00\000"
-/* offset=3D78480 */ "dtlb-refs\000legacy cache\000Data TLB read accesses\=
000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D78556 */ "dtlb-reference\000legacy cache\000Data TLB read acce=
sses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D78637 */ "dtlb-ops\000legacy cache\000Data TLB read accesses\0=
00legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D78712 */ "dtlb-access\000legacy cache\000Data TLB read accesse=
s\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D78790 */ "dtlb-misses\000legacy cache\000Data TLB read misses\=
000legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D78872 */ "dtlb-miss\000legacy cache\000Data TLB read misses\00=
0legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D78952 */ "d-tlb\000legacy cache\000Data TLB read accesses\000l=
egacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D79024 */ "d-tlb-load\000legacy cache\000Data TLB read accesses=
\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D79101 */ "d-tlb-load-refs\000legacy cache\000Data TLB read acc=
esses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D79183 */ "d-tlb-load-reference\000legacy cache\000Data TLB rea=
d accesses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D79270 */ "d-tlb-load-ops\000legacy cache\000Data TLB read acce=
sses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D79351 */ "d-tlb-load-access\000legacy cache\000Data TLB read a=
ccesses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D79435 */ "d-tlb-load-misses\000legacy cache\000Data TLB read m=
isses\000legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D79523 */ "d-tlb-load-miss\000legacy cache\000Data TLB read mis=
ses\000legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D79609 */ "d-tlb-loads\000legacy cache\000Data TLB read accesse=
s\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D79687 */ "d-tlb-loads-refs\000legacy cache\000Data TLB read ac=
cesses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D79770 */ "d-tlb-loads-reference\000legacy cache\000Data TLB re=
ad accesses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D79858 */ "d-tlb-loads-ops\000legacy cache\000Data TLB read acc=
esses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D79940 */ "d-tlb-loads-access\000legacy cache\000Data TLB read =
accesses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D80025 */ "d-tlb-loads-misses\000legacy cache\000Data TLB read =
misses\000legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D80114 */ "d-tlb-loads-miss\000legacy cache\000Data TLB read mi=
sses\000legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D80201 */ "d-tlb-read\000legacy cache\000Data TLB read accesses=
\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D80278 */ "d-tlb-read-refs\000legacy cache\000Data TLB read acc=
esses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D80360 */ "d-tlb-read-reference\000legacy cache\000Data TLB rea=
d accesses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D80447 */ "d-tlb-read-ops\000legacy cache\000Data TLB read acce=
sses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D80528 */ "d-tlb-read-access\000legacy cache\000Data TLB read a=
ccesses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D80612 */ "d-tlb-read-misses\000legacy cache\000Data TLB read m=
isses\000legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D80700 */ "d-tlb-read-miss\000legacy cache\000Data TLB read mis=
ses\000legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D80786 */ "d-tlb-store\000legacy cache\000Data TLB write access=
es\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D80869 */ "d-tlb-store-refs\000legacy cache\000Data TLB write a=
ccesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D80957 */ "d-tlb-store-reference\000legacy cache\000Data TLB wr=
ite accesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D81050 */ "d-tlb-store-ops\000legacy cache\000Data TLB write ac=
cesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D81137 */ "d-tlb-store-access\000legacy cache\000Data TLB write=
 accesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D81227 */ "d-tlb-store-misses\000legacy cache\000Data TLB write=
 misses\000legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D81317 */ "d-tlb-store-miss\000legacy cache\000Data TLB write m=
isses\000legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D81405 */ "d-tlb-stores\000legacy cache\000Data TLB write acces=
ses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D81489 */ "d-tlb-stores-refs\000legacy cache\000Data TLB write =
accesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D81578 */ "d-tlb-stores-reference\000legacy cache\000Data TLB w=
rite accesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D81672 */ "d-tlb-stores-ops\000legacy cache\000Data TLB write a=
ccesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D81760 */ "d-tlb-stores-access\000legacy cache\000Data TLB writ=
e accesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D81851 */ "d-tlb-stores-misses\000legacy cache\000Data TLB writ=
e misses\000legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D81942 */ "d-tlb-stores-miss\000legacy cache\000Data TLB write =
misses\000legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D82031 */ "d-tlb-write\000legacy cache\000Data TLB write access=
es\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D82114 */ "d-tlb-write-refs\000legacy cache\000Data TLB write a=
ccesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D82202 */ "d-tlb-write-reference\000legacy cache\000Data TLB wr=
ite accesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D82295 */ "d-tlb-write-ops\000legacy cache\000Data TLB write ac=
cesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D82382 */ "d-tlb-write-access\000legacy cache\000Data TLB write=
 accesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D82472 */ "d-tlb-write-misses\000legacy cache\000Data TLB write=
 misses\000legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D82562 */ "d-tlb-write-miss\000legacy cache\000Data TLB write m=
isses\000legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D82650 */ "d-tlb-prefetch\000legacy cache\000Data TLB prefetch =
accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D82739 */ "d-tlb-prefetch-refs\000legacy cache\000Data TLB pref=
etch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D82833 */ "d-tlb-prefetch-reference\000legacy cache\000Data TLB=
 prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000=
\000"
-/* offset=3D82932 */ "d-tlb-prefetch-ops\000legacy cache\000Data TLB prefe=
tch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D83025 */ "d-tlb-prefetch-access\000legacy cache\000Data TLB pr=
efetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\00=
0"
-/* offset=3D83121 */ "d-tlb-prefetch-misses\000legacy cache\000Data TLB pr=
efetch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\00=
0"
-/* offset=3D83217 */ "d-tlb-prefetch-miss\000legacy cache\000Data TLB pref=
etch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
-/* offset=3D83311 */ "d-tlb-prefetches\000legacy cache\000Data TLB prefetc=
h accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D83402 */ "d-tlb-prefetches-refs\000legacy cache\000Data TLB pr=
efetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\00=
0"
-/* offset=3D83498 */ "d-tlb-prefetches-reference\000legacy cache\000Data T=
LB prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\0=
00\000"
-/* offset=3D83599 */ "d-tlb-prefetches-ops\000legacy cache\000Data TLB pre=
fetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000=
"
-/* offset=3D83694 */ "d-tlb-prefetches-access\000legacy cache\000Data TLB =
prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\=
000"
-/* offset=3D83792 */ "d-tlb-prefetches-misses\000legacy cache\000Data TLB =
prefetch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\=
000"
-/* offset=3D83890 */ "d-tlb-prefetches-miss\000legacy cache\000Data TLB pr=
efetch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\00=
0"
-/* offset=3D83986 */ "d-tlb-speculative-read\000legacy cache\000Data TLB p=
refetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\0=
00"
-/* offset=3D84083 */ "d-tlb-speculative-read-refs\000legacy cache\000Data =
TLB prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\=
000\000"
-/* offset=3D84185 */ "d-tlb-speculative-read-reference\000legacy cache\000=
Data TLB prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000=
\000\000\000"
-/* offset=3D84292 */ "d-tlb-speculative-read-ops\000legacy cache\000Data T=
LB prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\0=
00\000"
-/* offset=3D84393 */ "d-tlb-speculative-read-access\000legacy cache\000Dat=
a TLB prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\00=
0\000\000"
-/* offset=3D84497 */ "d-tlb-speculative-read-misses\000legacy cache\000Dat=
a TLB prefetch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\00=
0\000\000"
-/* offset=3D84601 */ "d-tlb-speculative-read-miss\000legacy cache\000Data =
TLB prefetch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\=
000\000"
-/* offset=3D84703 */ "d-tlb-speculative-load\000legacy cache\000Data TLB p=
refetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\0=
00"
-/* offset=3D84800 */ "d-tlb-speculative-load-refs\000legacy cache\000Data =
TLB prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\=
000\000"
-/* offset=3D84902 */ "d-tlb-speculative-load-reference\000legacy cache\000=
Data TLB prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000=
\000\000\000"
-/* offset=3D85009 */ "d-tlb-speculative-load-ops\000legacy cache\000Data T=
LB prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\0=
00\000"
-/* offset=3D85110 */ "d-tlb-speculative-load-access\000legacy cache\000Dat=
a TLB prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\00=
0\000\000"
-/* offset=3D85214 */ "d-tlb-speculative-load-misses\000legacy cache\000Dat=
a TLB prefetch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\00=
0\000\000"
-/* offset=3D85318 */ "d-tlb-speculative-load-miss\000legacy cache\000Data =
TLB prefetch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\=
000\000"
-/* offset=3D85420 */ "d-tlb-refs\000legacy cache\000Data TLB read accesses=
\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D85497 */ "d-tlb-reference\000legacy cache\000Data TLB read acc=
esses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D85579 */ "d-tlb-ops\000legacy cache\000Data TLB read accesses\=
000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D85655 */ "d-tlb-access\000legacy cache\000Data TLB read access=
es\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D85734 */ "d-tlb-misses\000legacy cache\000Data TLB read misses=
\000legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D85817 */ "d-tlb-miss\000legacy cache\000Data TLB read misses\0=
00legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D85898 */ "data-tlb\000legacy cache\000Data TLB read accesses\0=
00legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D85973 */ "data-tlb-load\000legacy cache\000Data TLB read acces=
ses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D86053 */ "data-tlb-load-refs\000legacy cache\000Data TLB read =
accesses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D86138 */ "data-tlb-load-reference\000legacy cache\000Data TLB =
read accesses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D86228 */ "data-tlb-load-ops\000legacy cache\000Data TLB read a=
ccesses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D86312 */ "data-tlb-load-access\000legacy cache\000Data TLB rea=
d accesses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D86399 */ "data-tlb-load-misses\000legacy cache\000Data TLB rea=
d misses\000legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D86490 */ "data-tlb-load-miss\000legacy cache\000Data TLB read =
misses\000legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D86579 */ "data-tlb-loads\000legacy cache\000Data TLB read acce=
sses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D86660 */ "data-tlb-loads-refs\000legacy cache\000Data TLB read=
 accesses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D86746 */ "data-tlb-loads-reference\000legacy cache\000Data TLB=
 read accesses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D86837 */ "data-tlb-loads-ops\000legacy cache\000Data TLB read =
accesses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D86922 */ "data-tlb-loads-access\000legacy cache\000Data TLB re=
ad accesses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D87010 */ "data-tlb-loads-misses\000legacy cache\000Data TLB re=
ad misses\000legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D87102 */ "data-tlb-loads-miss\000legacy cache\000Data TLB read=
 misses\000legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D87192 */ "data-tlb-read\000legacy cache\000Data TLB read acces=
ses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D87272 */ "data-tlb-read-refs\000legacy cache\000Data TLB read =
accesses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D87357 */ "data-tlb-read-reference\000legacy cache\000Data TLB =
read accesses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D87447 */ "data-tlb-read-ops\000legacy cache\000Data TLB read a=
ccesses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D87531 */ "data-tlb-read-access\000legacy cache\000Data TLB rea=
d accesses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D87618 */ "data-tlb-read-misses\000legacy cache\000Data TLB rea=
d misses\000legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D87709 */ "data-tlb-read-miss\000legacy cache\000Data TLB read =
misses\000legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D87798 */ "data-tlb-store\000legacy cache\000Data TLB write acc=
esses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D87884 */ "data-tlb-store-refs\000legacy cache\000Data TLB writ=
e accesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D87975 */ "data-tlb-store-reference\000legacy cache\000Data TLB=
 write accesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\00=
0"
-/* offset=3D88071 */ "data-tlb-store-ops\000legacy cache\000Data TLB write=
 accesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D88161 */ "data-tlb-store-access\000legacy cache\000Data TLB wr=
ite accesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D88254 */ "data-tlb-store-misses\000legacy cache\000Data TLB wr=
ite misses\000legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D88347 */ "data-tlb-store-miss\000legacy cache\000Data TLB writ=
e misses\000legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D88438 */ "data-tlb-stores\000legacy cache\000Data TLB write ac=
cesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D88525 */ "data-tlb-stores-refs\000legacy cache\000Data TLB wri=
te accesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D88617 */ "data-tlb-stores-reference\000legacy cache\000Data TL=
B write accesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\0=
00"
-/* offset=3D88714 */ "data-tlb-stores-ops\000legacy cache\000Data TLB writ=
e accesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D88805 */ "data-tlb-stores-access\000legacy cache\000Data TLB w=
rite accesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D88899 */ "data-tlb-stores-misses\000legacy cache\000Data TLB w=
rite misses\000legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D88993 */ "data-tlb-stores-miss\000legacy cache\000Data TLB wri=
te misses\000legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D89085 */ "data-tlb-write\000legacy cache\000Data TLB write acc=
esses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D89171 */ "data-tlb-write-refs\000legacy cache\000Data TLB writ=
e accesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D89262 */ "data-tlb-write-reference\000legacy cache\000Data TLB=
 write accesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\00=
0"
-/* offset=3D89358 */ "data-tlb-write-ops\000legacy cache\000Data TLB write=
 accesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D89448 */ "data-tlb-write-access\000legacy cache\000Data TLB wr=
ite accesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D89541 */ "data-tlb-write-misses\000legacy cache\000Data TLB wr=
ite misses\000legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D89634 */ "data-tlb-write-miss\000legacy cache\000Data TLB writ=
e misses\000legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D89725 */ "data-tlb-prefetch\000legacy cache\000Data TLB prefet=
ch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D89817 */ "data-tlb-prefetch-refs\000legacy cache\000Data TLB p=
refetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\0=
00"
-/* offset=3D89914 */ "data-tlb-prefetch-reference\000legacy cache\000Data =
TLB prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\=
000\000"
-/* offset=3D90016 */ "data-tlb-prefetch-ops\000legacy cache\000Data TLB pr=
efetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\00=
0"
-/* offset=3D90112 */ "data-tlb-prefetch-access\000legacy cache\000Data TLB=
 prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000=
\000"
-/* offset=3D90211 */ "data-tlb-prefetch-misses\000legacy cache\000Data TLB=
 prefetch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000=
\000"
-/* offset=3D90310 */ "data-tlb-prefetch-miss\000legacy cache\000Data TLB p=
refetch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\0=
00"
-/* offset=3D90407 */ "data-tlb-prefetches\000legacy cache\000Data TLB pref=
etch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D90501 */ "data-tlb-prefetches-refs\000legacy cache\000Data TLB=
 prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000=
\000"
-/* offset=3D90600 */ "data-tlb-prefetches-reference\000legacy cache\000Dat=
a TLB prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\00=
0\000\000"
-/* offset=3D90704 */ "data-tlb-prefetches-ops\000legacy cache\000Data TLB =
prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\=
000"
-/* offset=3D90802 */ "data-tlb-prefetches-access\000legacy cache\000Data T=
LB prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\0=
00\000"
-/* offset=3D90903 */ "data-tlb-prefetches-misses\000legacy cache\000Data T=
LB prefetch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\0=
00\000"
-/* offset=3D91004 */ "data-tlb-prefetches-miss\000legacy cache\000Data TLB=
 prefetch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000=
\000"
-/* offset=3D91103 */ "data-tlb-speculative-read\000legacy cache\000Data TL=
B prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\00=
0\000"
-/* offset=3D91203 */ "data-tlb-speculative-read-refs\000legacy cache\000Da=
ta TLB prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\0=
00\000\000"
-/* offset=3D91308 */ "data-tlb-speculative-read-reference\000legacy cache\=
000Data TLB prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\=
000\000\000\000"
-/* offset=3D91418 */ "data-tlb-speculative-read-ops\000legacy cache\000Dat=
a TLB prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\00=
0\000\000"
-/* offset=3D91522 */ "data-tlb-speculative-read-access\000legacy cache\000=
Data TLB prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000=
\000\000\000"
-/* offset=3D91629 */ "data-tlb-speculative-read-misses\000legacy cache\000=
Data TLB prefetch misses\000legacy-cache-config=3D0x10203\000\00010\000\000=
\000\000\000"
-/* offset=3D91736 */ "data-tlb-speculative-read-miss\000legacy cache\000Da=
ta TLB prefetch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\0=
00\000\000"
-/* offset=3D91841 */ "data-tlb-speculative-load\000legacy cache\000Data TL=
B prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\00=
0\000"
-/* offset=3D91941 */ "data-tlb-speculative-load-refs\000legacy cache\000Da=
ta TLB prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\0=
00\000\000"
-/* offset=3D92046 */ "data-tlb-speculative-load-reference\000legacy cache\=
000Data TLB prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\=
000\000\000\000"
-/* offset=3D92156 */ "data-tlb-speculative-load-ops\000legacy cache\000Dat=
a TLB prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\00=
0\000\000"
-/* offset=3D92260 */ "data-tlb-speculative-load-access\000legacy cache\000=
Data TLB prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000=
\000\000\000"
-/* offset=3D92367 */ "data-tlb-speculative-load-misses\000legacy cache\000=
Data TLB prefetch misses\000legacy-cache-config=3D0x10203\000\00010\000\000=
\000\000\000"
-/* offset=3D92474 */ "data-tlb-speculative-load-miss\000legacy cache\000Da=
ta TLB prefetch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\0=
00\000\000"
-/* offset=3D92579 */ "data-tlb-refs\000legacy cache\000Data TLB read acces=
ses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D92659 */ "data-tlb-reference\000legacy cache\000Data TLB read =
accesses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D92744 */ "data-tlb-ops\000legacy cache\000Data TLB read access=
es\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D92823 */ "data-tlb-access\000legacy cache\000Data TLB read acc=
esses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D92905 */ "data-tlb-misses\000legacy cache\000Data TLB read mis=
ses\000legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D92991 */ "data-tlb-miss\000legacy cache\000Data TLB read misse=
s\000legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D93075 */ "itlb\000legacy cache\000Instruction TLB read accesse=
s\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D93153 */ "itlb-load\000legacy cache\000Instruction TLB read ac=
cesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D93236 */ "itlb-load-refs\000legacy cache\000Instruction TLB re=
ad accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D93324 */ "itlb-load-reference\000legacy cache\000Instruction T=
LB read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D93417 */ "itlb-load-ops\000legacy cache\000Instruction TLB rea=
d accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D93504 */ "itlb-load-access\000legacy cache\000Instruction TLB =
read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D93594 */ "itlb-load-misses\000legacy cache\000Instruction TLB =
read misses\000legacy-cache-config=3D0x10004\000\00000\000\000\000\000\000"
-/* offset=3D93688 */ "itlb-load-miss\000legacy cache\000Instruction TLB re=
ad misses\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D93780 */ "itlb-loads\000legacy cache\000Instruction TLB read a=
ccesses\000legacy-cache-config=3D4\000\00000\000\000\000\000\000"
-/* offset=3D93864 */ "itlb-loads-refs\000legacy cache\000Instruction TLB r=
ead accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D93953 */ "itlb-loads-reference\000legacy cache\000Instruction =
TLB read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D94047 */ "itlb-loads-ops\000legacy cache\000Instruction TLB re=
ad accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D94135 */ "itlb-loads-access\000legacy cache\000Instruction TLB=
 read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D94226 */ "itlb-loads-misses\000legacy cache\000Instruction TLB=
 read misses\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000=
"
-/* offset=3D94321 */ "itlb-loads-miss\000legacy cache\000Instruction TLB r=
ead misses\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D94414 */ "itlb-read\000legacy cache\000Instruction TLB read ac=
cesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D94497 */ "itlb-read-refs\000legacy cache\000Instruction TLB re=
ad accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D94585 */ "itlb-read-reference\000legacy cache\000Instruction T=
LB read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D94678 */ "itlb-read-ops\000legacy cache\000Instruction TLB rea=
d accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D94765 */ "itlb-read-access\000legacy cache\000Instruction TLB =
read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D94855 */ "itlb-read-misses\000legacy cache\000Instruction TLB =
read misses\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D94949 */ "itlb-read-miss\000legacy cache\000Instruction TLB re=
ad misses\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D95041 */ "itlb-refs\000legacy cache\000Instruction TLB read ac=
cesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D95124 */ "itlb-reference\000legacy cache\000Instruction TLB re=
ad accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D95212 */ "itlb-ops\000legacy cache\000Instruction TLB read acc=
esses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D95294 */ "itlb-access\000legacy cache\000Instruction TLB read =
accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D95379 */ "itlb-misses\000legacy cache\000Instruction TLB read =
misses\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D95468 */ "itlb-miss\000legacy cache\000Instruction TLB read mi=
sses\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D95555 */ "i-tlb\000legacy cache\000Instruction TLB read access=
es\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D95634 */ "i-tlb-load\000legacy cache\000Instruction TLB read a=
ccesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D95718 */ "i-tlb-load-refs\000legacy cache\000Instruction TLB r=
ead accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D95807 */ "i-tlb-load-reference\000legacy cache\000Instruction =
TLB read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D95901 */ "i-tlb-load-ops\000legacy cache\000Instruction TLB re=
ad accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D95989 */ "i-tlb-load-access\000legacy cache\000Instruction TLB=
 read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D96080 */ "i-tlb-load-misses\000legacy cache\000Instruction TLB=
 read misses\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000=
"
-/* offset=3D96175 */ "i-tlb-load-miss\000legacy cache\000Instruction TLB r=
ead misses\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D96268 */ "i-tlb-loads\000legacy cache\000Instruction TLB read =
accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D96353 */ "i-tlb-loads-refs\000legacy cache\000Instruction TLB =
read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D96443 */ "i-tlb-loads-reference\000legacy cache\000Instruction=
 TLB read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000=
"
-/* offset=3D96538 */ "i-tlb-loads-ops\000legacy cache\000Instruction TLB r=
ead accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D96627 */ "i-tlb-loads-access\000legacy cache\000Instruction TL=
B read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D96719 */ "i-tlb-loads-misses\000legacy cache\000Instruction TL=
B read misses\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\00=
0"
-/* offset=3D96815 */ "i-tlb-loads-miss\000legacy cache\000Instruction TLB =
read misses\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D96909 */ "i-tlb-read\000legacy cache\000Instruction TLB read a=
ccesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D96993 */ "i-tlb-read-refs\000legacy cache\000Instruction TLB r=
ead accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D97082 */ "i-tlb-read-reference\000legacy cache\000Instruction =
TLB read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D97176 */ "i-tlb-read-ops\000legacy cache\000Instruction TLB re=
ad accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D97264 */ "i-tlb-read-access\000legacy cache\000Instruction TLB=
 read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D97355 */ "i-tlb-read-misses\000legacy cache\000Instruction TLB=
 read misses\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000=
"
-/* offset=3D97450 */ "i-tlb-read-miss\000legacy cache\000Instruction TLB r=
ead misses\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D97543 */ "i-tlb-refs\000legacy cache\000Instruction TLB read a=
ccesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D97627 */ "i-tlb-reference\000legacy cache\000Instruction TLB r=
ead accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D97716 */ "i-tlb-ops\000legacy cache\000Instruction TLB read ac=
cesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D97799 */ "i-tlb-access\000legacy cache\000Instruction TLB read=
 accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D97885 */ "i-tlb-misses\000legacy cache\000Instruction TLB read=
 misses\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D97975 */ "i-tlb-miss\000legacy cache\000Instruction TLB read m=
isses\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D98063 */ "instruction-tlb\000legacy cache\000Instruction TLB r=
ead accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D98152 */ "instruction-tlb-load\000legacy cache\000Instruction =
TLB read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D98246 */ "instruction-tlb-load-refs\000legacy cache\000Instruc=
tion TLB read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000=
\000"
-/* offset=3D98345 */ "instruction-tlb-load-reference\000legacy cache\000In=
struction TLB read accesses\000legacy-cache-config=3D4\000\00010\000\000\00=
0\000\000"
-/* offset=3D98449 */ "instruction-tlb-load-ops\000legacy cache\000Instruct=
ion TLB read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\=
000"
-/* offset=3D98547 */ "instruction-tlb-load-access\000legacy cache\000Instr=
uction TLB read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\0=
00\000"
-/* offset=3D98648 */ "instruction-tlb-load-misses\000legacy cache\000Instr=
uction TLB read misses\000legacy-cache-config=3D0x10004\000\00010\000\000\0=
00\000\000"
-/* offset=3D98753 */ "instruction-tlb-load-miss\000legacy cache\000Instruc=
tion TLB read misses\000legacy-cache-config=3D0x10004\000\00010\000\000\000=
\000\000"
-/* offset=3D98856 */ "instruction-tlb-loads\000legacy cache\000Instruction=
 TLB read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000=
"
-/* offset=3D98951 */ "instruction-tlb-loads-refs\000legacy cache\000Instru=
ction TLB read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\00=
0\000"
-/* offset=3D99051 */ "instruction-tlb-loads-reference\000legacy cache\000I=
nstruction TLB read accesses\000legacy-cache-config=3D4\000\00010\000\000\0=
00\000\000"
-/* offset=3D99156 */ "instruction-tlb-loads-ops\000legacy cache\000Instruc=
tion TLB read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000=
\000"
-/* offset=3D99255 */ "instruction-tlb-loads-access\000legacy cache\000Inst=
ruction TLB read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\=
000\000"
-/* offset=3D99357 */ "instruction-tlb-loads-misses\000legacy cache\000Inst=
ruction TLB read misses\000legacy-cache-config=3D0x10004\000\00010\000\000\=
000\000\000"
-/* offset=3D99463 */ "instruction-tlb-loads-miss\000legacy cache\000Instru=
ction TLB read misses\000legacy-cache-config=3D0x10004\000\00010\000\000\00=
0\000\000"
-/* offset=3D99567 */ "instruction-tlb-read\000legacy cache\000Instruction =
TLB read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D99661 */ "instruction-tlb-read-refs\000legacy cache\000Instruc=
tion TLB read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000=
\000"
-/* offset=3D99760 */ "instruction-tlb-read-reference\000legacy cache\000In=
struction TLB read accesses\000legacy-cache-config=3D4\000\00010\000\000\00=
0\000\000"
-/* offset=3D99864 */ "instruction-tlb-read-ops\000legacy cache\000Instruct=
ion TLB read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\=
000"
-/* offset=3D99962 */ "instruction-tlb-read-access\000legacy cache\000Instr=
uction TLB read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\0=
00\000"
-/* offset=3D100063 */ "instruction-tlb-read-misses\000legacy cache\000Inst=
ruction TLB read misses\000legacy-cache-config=3D0x10004\000\00010\000\000\=
000\000\000"
-/* offset=3D100168 */ "instruction-tlb-read-miss\000legacy cache\000Instru=
ction TLB read misses\000legacy-cache-config=3D0x10004\000\00010\000\000\00=
0\000\000"
-/* offset=3D100271 */ "instruction-tlb-refs\000legacy cache\000Instruction=
 TLB read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000=
"
-/* offset=3D100365 */ "instruction-tlb-reference\000legacy cache\000Instru=
ction TLB read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\00=
0\000"
-/* offset=3D100464 */ "instruction-tlb-ops\000legacy cache\000Instruction =
TLB read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D100557 */ "instruction-tlb-access\000legacy cache\000Instructi=
on TLB read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\0=
00"
-/* offset=3D100653 */ "instruction-tlb-misses\000legacy cache\000Instructi=
on TLB read misses\000legacy-cache-config=3D0x10004\000\00010\000\000\000\0=
00\000"
-/* offset=3D100753 */ "instruction-tlb-miss\000legacy cache\000Instruction=
 TLB read misses\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000=
\000"
-/* offset=3D100851 */ "branch\000legacy cache\000Branch prediction unit re=
ad accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D100938 */ "branch-load\000legacy cache\000Branch prediction un=
it read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D101030 */ "branch-load-refs\000legacy cache\000Branch predicti=
on unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\=
000"
-/* offset=3D101127 */ "branch-load-reference\000legacy cache\000Branch pre=
diction unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000=
\000\000"
-/* offset=3D101229 */ "branch-load-ops\000legacy cache\000Branch predictio=
n unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\0=
00"
-/* offset=3D101325 */ "branch-load-access\000legacy cache\000Branch predic=
tion unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\00=
0\000"
-/* offset=3D101424 */ "branch-load-misses\000legacy cache\000Branch predic=
tion unit read misses\000legacy-cache-config=3D0x10005\000\00000\000\000\00=
0\000\000"
-/* offset=3D101527 */ "branch-load-miss\000legacy cache\000Branch predicti=
on unit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\=
000\000"
-/* offset=3D101628 */ "branch-loads\000legacy cache\000Branch prediction u=
nit read accesses\000legacy-cache-config=3D5\000\00000\000\000\000\000\000"
-/* offset=3D101721 */ "branch-loads-refs\000legacy cache\000Branch predict=
ion unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000=
\000"
-/* offset=3D101819 */ "branch-loads-reference\000legacy cache\000Branch pr=
ediction unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\00=
0\000\000"
-/* offset=3D101922 */ "branch-loads-ops\000legacy cache\000Branch predicti=
on unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\=
000"
-/* offset=3D102019 */ "branch-loads-access\000legacy cache\000Branch predi=
ction unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\0=
00\000"
-/* offset=3D102119 */ "branch-loads-misses\000legacy cache\000Branch predi=
ction unit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\0=
00\000\000"
-/* offset=3D102223 */ "branch-loads-miss\000legacy cache\000Branch predict=
ion unit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000=
\000\000"
-/* offset=3D102325 */ "branch-read\000legacy cache\000Branch prediction un=
it read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D102417 */ "branch-read-refs\000legacy cache\000Branch predicti=
on unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\=
000"
-/* offset=3D102514 */ "branch-read-reference\000legacy cache\000Branch pre=
diction unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000=
\000\000"
-/* offset=3D102616 */ "branch-read-ops\000legacy cache\000Branch predictio=
n unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\0=
00"
-/* offset=3D102712 */ "branch-read-access\000legacy cache\000Branch predic=
tion unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\00=
0\000"
-/* offset=3D102811 */ "branch-read-misses\000legacy cache\000Branch predic=
tion unit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\00=
0\000\000"
-/* offset=3D102914 */ "branch-read-miss\000legacy cache\000Branch predicti=
on unit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\=
000\000"
-/* offset=3D103015 */ "branch-refs\000legacy cache\000Branch prediction un=
it read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D103107 */ "branch-reference\000legacy cache\000Branch predicti=
on unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\=
000"
-/* offset=3D103204 */ "branch-ops\000legacy cache\000Branch prediction uni=
t read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D103295 */ "branch-access\000legacy cache\000Branch prediction =
unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000=
"
-/* offset=3D103389 */ "branch-miss\000legacy cache\000Branch prediction un=
it read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\0=
00"
-/* offset=3D103485 */ "branches-load\000legacy cache\000Branch prediction =
unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000=
"
-/* offset=3D103579 */ "branches-load-refs\000legacy cache\000Branch predic=
tion unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\00=
0\000"
-/* offset=3D103678 */ "branches-load-reference\000legacy cache\000Branch p=
rediction unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\0=
00\000\000"
-/* offset=3D103782 */ "branches-load-ops\000legacy cache\000Branch predict=
ion unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000=
\000"
-/* offset=3D103880 */ "branches-load-access\000legacy cache\000Branch pred=
iction unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\=
000\000"
-/* offset=3D103981 */ "branches-load-misses\000legacy cache\000Branch pred=
iction unit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\=
000\000\000"
-/* offset=3D104086 */ "branches-load-miss\000legacy cache\000Branch predic=
tion unit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\00=
0\000\000"
-/* offset=3D104189 */ "branches-loads\000legacy cache\000Branch prediction=
 unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\00=
0"
-/* offset=3D104284 */ "branches-loads-refs\000legacy cache\000Branch predi=
ction unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\0=
00\000"
-/* offset=3D104384 */ "branches-loads-reference\000legacy cache\000Branch =
prediction unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\=
000\000\000"
-/* offset=3D104489 */ "branches-loads-ops\000legacy cache\000Branch predic=
tion unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\00=
0\000"
-/* offset=3D104588 */ "branches-loads-access\000legacy cache\000Branch pre=
diction unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000=
\000\000"
-/* offset=3D104690 */ "branches-loads-misses\000legacy cache\000Branch pre=
diction unit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000=
\000\000\000"
-/* offset=3D104796 */ "branches-loads-miss\000legacy cache\000Branch predi=
ction unit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\0=
00\000\000"
-/* offset=3D104900 */ "branches-read\000legacy cache\000Branch prediction =
unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000=
"
-/* offset=3D104994 */ "branches-read-refs\000legacy cache\000Branch predic=
tion unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\00=
0\000"
-/* offset=3D105093 */ "branches-read-reference\000legacy cache\000Branch p=
rediction unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\0=
00\000\000"
-/* offset=3D105197 */ "branches-read-ops\000legacy cache\000Branch predict=
ion unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000=
\000"
-/* offset=3D105295 */ "branches-read-access\000legacy cache\000Branch pred=
iction unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\=
000\000"
-/* offset=3D105396 */ "branches-read-misses\000legacy cache\000Branch pred=
iction unit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\=
000\000\000"
-/* offset=3D105501 */ "branches-read-miss\000legacy cache\000Branch predic=
tion unit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\00=
0\000\000"
-/* offset=3D105604 */ "branches-refs\000legacy cache\000Branch prediction =
unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000=
"
-/* offset=3D105698 */ "branches-reference\000legacy cache\000Branch predic=
tion unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\00=
0\000"
-/* offset=3D105797 */ "branches-ops\000legacy cache\000Branch prediction u=
nit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D105890 */ "branches-access\000legacy cache\000Branch predictio=
n unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\0=
00"
-/* offset=3D105986 */ "branches-misses\000legacy cache\000Branch predictio=
n unit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\0=
00\000"
-/* offset=3D106086 */ "branches-miss\000legacy cache\000Branch prediction =
unit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000=
\000"
-/* offset=3D106184 */ "bpu\000legacy cache\000Branch prediction unit read =
accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D106268 */ "bpu-load\000legacy cache\000Branch prediction unit =
read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D106357 */ "bpu-load-refs\000legacy cache\000Branch prediction =
unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000=
"
-/* offset=3D106451 */ "bpu-load-reference\000legacy cache\000Branch predic=
tion unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\00=
0\000"
-/* offset=3D106550 */ "bpu-load-ops\000legacy cache\000Branch prediction u=
nit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D106643 */ "bpu-load-access\000legacy cache\000Branch predictio=
n unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\0=
00"
-/* offset=3D106739 */ "bpu-load-misses\000legacy cache\000Branch predictio=
n unit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\0=
00\000"
-/* offset=3D106839 */ "bpu-load-miss\000legacy cache\000Branch prediction =
unit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000=
\000"
-/* offset=3D106937 */ "bpu-loads\000legacy cache\000Branch prediction unit=
 read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D107027 */ "bpu-loads-refs\000legacy cache\000Branch prediction=
 unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\00=
0"
-/* offset=3D107122 */ "bpu-loads-reference\000legacy cache\000Branch predi=
ction unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\0=
00\000"
-/* offset=3D107222 */ "bpu-loads-ops\000legacy cache\000Branch prediction =
unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000=
"
-/* offset=3D107316 */ "bpu-loads-access\000legacy cache\000Branch predicti=
on unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\=
000"
-/* offset=3D107413 */ "bpu-loads-misses\000legacy cache\000Branch predicti=
on unit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\=
000\000"
-/* offset=3D107514 */ "bpu-loads-miss\000legacy cache\000Branch prediction=
 unit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\00=
0\000"
-/* offset=3D107613 */ "bpu-read\000legacy cache\000Branch prediction unit =
read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D107702 */ "bpu-read-refs\000legacy cache\000Branch prediction =
unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000=
"
-/* offset=3D107796 */ "bpu-read-reference\000legacy cache\000Branch predic=
tion unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\00=
0\000"
-/* offset=3D107895 */ "bpu-read-ops\000legacy cache\000Branch prediction u=
nit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D107988 */ "bpu-read-access\000legacy cache\000Branch predictio=
n unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\0=
00"
-/* offset=3D108084 */ "bpu-read-misses\000legacy cache\000Branch predictio=
n unit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\0=
00\000"
-/* offset=3D108184 */ "bpu-read-miss\000legacy cache\000Branch prediction =
unit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000=
\000"
-/* offset=3D108282 */ "bpu-refs\000legacy cache\000Branch prediction unit =
read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D108371 */ "bpu-reference\000legacy cache\000Branch prediction =
unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000=
"
-/* offset=3D108465 */ "bpu-ops\000legacy cache\000Branch prediction unit r=
ead accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D108553 */ "bpu-access\000legacy cache\000Branch prediction uni=
t read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D108644 */ "bpu-misses\000legacy cache\000Branch prediction uni=
t read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\00=
0"
-/* offset=3D108739 */ "bpu-miss\000legacy cache\000Branch prediction unit =
read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D108832 */ "btb\000legacy cache\000Branch prediction unit read =
accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D108916 */ "btb-load\000legacy cache\000Branch prediction unit =
read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D109005 */ "btb-load-refs\000legacy cache\000Branch prediction =
unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000=
"
-/* offset=3D109099 */ "btb-load-reference\000legacy cache\000Branch predic=
tion unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\00=
0\000"
-/* offset=3D109198 */ "btb-load-ops\000legacy cache\000Branch prediction u=
nit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D109291 */ "btb-load-access\000legacy cache\000Branch predictio=
n unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\0=
00"
-/* offset=3D109387 */ "btb-load-misses\000legacy cache\000Branch predictio=
n unit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\0=
00\000"
-/* offset=3D109487 */ "btb-load-miss\000legacy cache\000Branch prediction =
unit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000=
\000"
-/* offset=3D109585 */ "btb-loads\000legacy cache\000Branch prediction unit=
 read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D109675 */ "btb-loads-refs\000legacy cache\000Branch prediction=
 unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\00=
0"
-/* offset=3D109770 */ "btb-loads-reference\000legacy cache\000Branch predi=
ction unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\0=
00\000"
-/* offset=3D109870 */ "btb-loads-ops\000legacy cache\000Branch prediction =
unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000=
"
-/* offset=3D109964 */ "btb-loads-access\000legacy cache\000Branch predicti=
on unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\=
000"
-/* offset=3D110061 */ "btb-loads-misses\000legacy cache\000Branch predicti=
on unit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\=
000\000"
-/* offset=3D110162 */ "btb-loads-miss\000legacy cache\000Branch prediction=
 unit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\00=
0\000"
-/* offset=3D110261 */ "btb-read\000legacy cache\000Branch prediction unit =
read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D110350 */ "btb-read-refs\000legacy cache\000Branch prediction =
unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000=
"
-/* offset=3D110444 */ "btb-read-reference\000legacy cache\000Branch predic=
tion unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\00=
0\000"
-/* offset=3D110543 */ "btb-read-ops\000legacy cache\000Branch prediction u=
nit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D110636 */ "btb-read-access\000legacy cache\000Branch predictio=
n unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\0=
00"
-/* offset=3D110732 */ "btb-read-misses\000legacy cache\000Branch predictio=
n unit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\0=
00\000"
-/* offset=3D110832 */ "btb-read-miss\000legacy cache\000Branch prediction =
unit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000=
\000"
-/* offset=3D110930 */ "btb-refs\000legacy cache\000Branch prediction unit =
read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D111019 */ "btb-reference\000legacy cache\000Branch prediction =
unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000=
"
-/* offset=3D111113 */ "btb-ops\000legacy cache\000Branch prediction unit r=
ead accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D111201 */ "btb-access\000legacy cache\000Branch prediction uni=
t read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D111292 */ "btb-misses\000legacy cache\000Branch prediction uni=
t read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\00=
0"
-/* offset=3D111387 */ "btb-miss\000legacy cache\000Branch prediction unit =
read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D111480 */ "bpc\000legacy cache\000Branch prediction unit read =
accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D111564 */ "bpc-load\000legacy cache\000Branch prediction unit =
read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D111653 */ "bpc-load-refs\000legacy cache\000Branch prediction =
unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000=
"
-/* offset=3D111747 */ "bpc-load-reference\000legacy cache\000Branch predic=
tion unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\00=
0\000"
-/* offset=3D111846 */ "bpc-load-ops\000legacy cache\000Branch prediction u=
nit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D111939 */ "bpc-load-access\000legacy cache\000Branch predictio=
n unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\0=
00"
-/* offset=3D112035 */ "bpc-load-misses\000legacy cache\000Branch predictio=
n unit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\0=
00\000"
-/* offset=3D112135 */ "bpc-load-miss\000legacy cache\000Branch prediction =
unit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000=
\000"
-/* offset=3D112233 */ "bpc-loads\000legacy cache\000Branch prediction unit=
 read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D112323 */ "bpc-loads-refs\000legacy cache\000Branch prediction=
 unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\00=
0"
-/* offset=3D112418 */ "bpc-loads-reference\000legacy cache\000Branch predi=
ction unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\0=
00\000"
-/* offset=3D112518 */ "bpc-loads-ops\000legacy cache\000Branch prediction =
unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000=
"
-/* offset=3D112612 */ "bpc-loads-access\000legacy cache\000Branch predicti=
on unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\=
000"
-/* offset=3D112709 */ "bpc-loads-misses\000legacy cache\000Branch predicti=
on unit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\=
000\000"
-/* offset=3D112810 */ "bpc-loads-miss\000legacy cache\000Branch prediction=
 unit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\00=
0\000"
-/* offset=3D112909 */ "bpc-read\000legacy cache\000Branch prediction unit =
read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D112998 */ "bpc-read-refs\000legacy cache\000Branch prediction =
unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000=
"
-/* offset=3D113092 */ "bpc-read-reference\000legacy cache\000Branch predic=
tion unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\00=
0\000"
-/* offset=3D113191 */ "bpc-read-ops\000legacy cache\000Branch prediction u=
nit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D113284 */ "bpc-read-access\000legacy cache\000Branch predictio=
n unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\0=
00"
-/* offset=3D113380 */ "bpc-read-misses\000legacy cache\000Branch predictio=
n unit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\0=
00\000"
-/* offset=3D113480 */ "bpc-read-miss\000legacy cache\000Branch prediction =
unit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000=
\000"
-/* offset=3D113578 */ "bpc-refs\000legacy cache\000Branch prediction unit =
read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D113667 */ "bpc-reference\000legacy cache\000Branch prediction =
unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000=
"
-/* offset=3D113761 */ "bpc-ops\000legacy cache\000Branch prediction unit r=
ead accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D113849 */ "bpc-access\000legacy cache\000Branch prediction uni=
t read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D113940 */ "bpc-misses\000legacy cache\000Branch prediction uni=
t read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\00=
0"
-/* offset=3D114035 */ "bpc-miss\000legacy cache\000Branch prediction unit =
read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D114128 */ "node\000legacy cache\000Local memory read accesses\=
000legacy-cache-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D114203 */ "node-load\000legacy cache\000Local memory read acce=
sses\000legacy-cache-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D114283 */ "node-load-refs\000legacy cache\000Local memory read=
 accesses\000legacy-cache-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D114368 */ "node-load-reference\000legacy cache\000Local memory=
 read accesses\000legacy-cache-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D114458 */ "node-load-ops\000legacy cache\000Local memory read =
accesses\000legacy-cache-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D114542 */ "node-load-access\000legacy cache\000Local memory re=
ad accesses\000legacy-cache-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D114629 */ "node-load-misses\000legacy cache\000Local memory re=
ad misses\000legacy-cache-config=3D0x10006\000\00000\000\000\000\000\000"
-/* offset=3D114720 */ "node-load-miss\000legacy cache\000Local memory read=
 misses\000legacy-cache-config=3D0x10006\000\00010\000\000\000\000\000"
-/* offset=3D114809 */ "node-loads\000legacy cache\000Local memory read acc=
esses\000legacy-cache-config=3D6\000\00000\000\000\000\000\000"
-/* offset=3D114890 */ "node-loads-refs\000legacy cache\000Local memory rea=
d accesses\000legacy-cache-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D114976 */ "node-loads-reference\000legacy cache\000Local memor=
y read accesses\000legacy-cache-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D115067 */ "node-loads-ops\000legacy cache\000Local memory read=
 accesses\000legacy-cache-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D115152 */ "node-loads-access\000legacy cache\000Local memory r=
ead accesses\000legacy-cache-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D115240 */ "node-loads-misses\000legacy cache\000Local memory r=
ead misses\000legacy-cache-config=3D0x10006\000\00010\000\000\000\000\000"
-/* offset=3D115332 */ "node-loads-miss\000legacy cache\000Local memory rea=
d misses\000legacy-cache-config=3D0x10006\000\00010\000\000\000\000\000"
-/* offset=3D115422 */ "node-read\000legacy cache\000Local memory read acce=
sses\000legacy-cache-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D115502 */ "node-read-refs\000legacy cache\000Local memory read=
 accesses\000legacy-cache-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D115587 */ "node-read-reference\000legacy cache\000Local memory=
 read accesses\000legacy-cache-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D115677 */ "node-read-ops\000legacy cache\000Local memory read =
accesses\000legacy-cache-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D115761 */ "node-read-access\000legacy cache\000Local memory re=
ad accesses\000legacy-cache-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D115848 */ "node-read-misses\000legacy cache\000Local memory re=
ad misses\000legacy-cache-config=3D0x10006\000\00010\000\000\000\000\000"
-/* offset=3D115939 */ "node-read-miss\000legacy cache\000Local memory read=
 misses\000legacy-cache-config=3D0x10006\000\00010\000\000\000\000\000"
-/* offset=3D116028 */ "node-store\000legacy cache\000Local memory write ac=
cesses\000legacy-cache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D116114 */ "node-store-refs\000legacy cache\000Local memory wri=
te accesses\000legacy-cache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D116205 */ "node-store-reference\000legacy cache\000Local memor=
y write accesses\000legacy-cache-config=3D0x106\000\00010\000\000\000\000\0=
00"
-/* offset=3D116301 */ "node-store-ops\000legacy cache\000Local memory writ=
e accesses\000legacy-cache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D116391 */ "node-store-access\000legacy cache\000Local memory w=
rite accesses\000legacy-cache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D116484 */ "node-store-misses\000legacy cache\000Local memory w=
rite misses\000legacy-cache-config=3D0x10106\000\00000\000\000\000\000\000"
-/* offset=3D116577 */ "node-store-miss\000legacy cache\000Local memory wri=
te misses\000legacy-cache-config=3D0x10106\000\00010\000\000\000\000\000"
-/* offset=3D116668 */ "node-stores\000legacy cache\000Local memory write a=
ccesses\000legacy-cache-config=3D0x106\000\00000\000\000\000\000\000"
-/* offset=3D116755 */ "node-stores-refs\000legacy cache\000Local memory wr=
ite accesses\000legacy-cache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D116847 */ "node-stores-reference\000legacy cache\000Local memo=
ry write accesses\000legacy-cache-config=3D0x106\000\00010\000\000\000\000\=
000"
-/* offset=3D116944 */ "node-stores-ops\000legacy cache\000Local memory wri=
te accesses\000legacy-cache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D117035 */ "node-stores-access\000legacy cache\000Local memory =
write accesses\000legacy-cache-config=3D0x106\000\00010\000\000\000\000\000=
"
-/* offset=3D117129 */ "node-stores-misses\000legacy cache\000Local memory =
write misses\000legacy-cache-config=3D0x10106\000\00010\000\000\000\000\000=
"
-/* offset=3D117223 */ "node-stores-miss\000legacy cache\000Local memory wr=
ite misses\000legacy-cache-config=3D0x10106\000\00010\000\000\000\000\000"
-/* offset=3D117315 */ "node-write\000legacy cache\000Local memory write ac=
cesses\000legacy-cache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D117401 */ "node-write-refs\000legacy cache\000Local memory wri=
te accesses\000legacy-cache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D117492 */ "node-write-reference\000legacy cache\000Local memor=
y write accesses\000legacy-cache-config=3D0x106\000\00010\000\000\000\000\0=
00"
-/* offset=3D117588 */ "node-write-ops\000legacy cache\000Local memory writ=
e accesses\000legacy-cache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D117678 */ "node-write-access\000legacy cache\000Local memory w=
rite accesses\000legacy-cache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D117771 */ "node-write-misses\000legacy cache\000Local memory w=
rite misses\000legacy-cache-config=3D0x10106\000\00010\000\000\000\000\000"
-/* offset=3D117864 */ "node-write-miss\000legacy cache\000Local memory wri=
te misses\000legacy-cache-config=3D0x10106\000\00010\000\000\000\000\000"
-/* offset=3D117955 */ "node-prefetch\000legacy cache\000Local memory prefe=
tch accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D118047 */ "node-prefetch-refs\000legacy cache\000Local memory =
prefetch accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\=
000"
-/* offset=3D118144 */ "node-prefetch-reference\000legacy cache\000Local me=
mory prefetch accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000=
\000\000"
-/* offset=3D118246 */ "node-prefetch-ops\000legacy cache\000Local memory p=
refetch accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\0=
00"
-/* offset=3D118342 */ "node-prefetch-access\000legacy cache\000Local memor=
y prefetch accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000\00=
0\000"
-/* offset=3D118441 */ "node-prefetch-misses\000legacy cache\000Local memor=
y prefetch misses\000legacy-cache-config=3D0x10206\000\00000\000\000\000\00=
0\000"
-/* offset=3D118540 */ "node-prefetch-miss\000legacy cache\000Local memory =
prefetch misses\000legacy-cache-config=3D0x10206\000\00010\000\000\000\000\=
000"
-/* offset=3D118637 */ "node-prefetches\000legacy cache\000Local memory pre=
fetch accesses\000legacy-cache-config=3D0x206\000\00000\000\000\000\000\000=
"
-/* offset=3D118731 */ "node-prefetches-refs\000legacy cache\000Local memor=
y prefetch accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000\00=
0\000"
-/* offset=3D118830 */ "node-prefetches-reference\000legacy cache\000Local =
memory prefetch accesses\000legacy-cache-config=3D0x206\000\00010\000\000\0=
00\000\000"
-/* offset=3D118934 */ "node-prefetches-ops\000legacy cache\000Local memory=
 prefetch accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000=
\000"
-/* offset=3D119032 */ "node-prefetches-access\000legacy cache\000Local mem=
ory prefetch accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000\=
000\000"
-/* offset=3D119133 */ "node-prefetches-misses\000legacy cache\000Local mem=
ory prefetch misses\000legacy-cache-config=3D0x10206\000\00010\000\000\000\=
000\000"
-/* offset=3D119234 */ "node-prefetches-miss\000legacy cache\000Local memor=
y prefetch misses\000legacy-cache-config=3D0x10206\000\00010\000\000\000\00=
0\000"
-/* offset=3D119333 */ "node-speculative-read\000legacy cache\000Local memo=
ry prefetch accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000\0=
00\000"
-/* offset=3D119433 */ "node-speculative-read-refs\000legacy cache\000Local=
 memory prefetch accesses\000legacy-cache-config=3D0x206\000\00010\000\000\=
000\000\000"
-/* offset=3D119538 */ "node-speculative-read-reference\000legacy cache\000=
Local memory prefetch accesses\000legacy-cache-config=3D0x206\000\00010\000=
\000\000\000\000"
-/* offset=3D119648 */ "node-speculative-read-ops\000legacy cache\000Local =
memory prefetch accesses\000legacy-cache-config=3D0x206\000\00010\000\000\0=
00\000\000"
-/* offset=3D119752 */ "node-speculative-read-access\000legacy cache\000Loc=
al memory prefetch accesses\000legacy-cache-config=3D0x206\000\00010\000\00=
0\000\000\000"
-/* offset=3D119859 */ "node-speculative-read-misses\000legacy cache\000Loc=
al memory prefetch misses\000legacy-cache-config=3D0x10206\000\00010\000\00=
0\000\000\000"
-/* offset=3D119966 */ "node-speculative-read-miss\000legacy cache\000Local=
 memory prefetch misses\000legacy-cache-config=3D0x10206\000\00010\000\000\=
000\000\000"
-/* offset=3D120071 */ "node-speculative-load\000legacy cache\000Local memo=
ry prefetch accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000\0=
00\000"
-/* offset=3D120171 */ "node-speculative-load-refs\000legacy cache\000Local=
 memory prefetch accesses\000legacy-cache-config=3D0x206\000\00010\000\000\=
000\000\000"
-/* offset=3D120276 */ "node-speculative-load-reference\000legacy cache\000=
Local memory prefetch accesses\000legacy-cache-config=3D0x206\000\00010\000=
\000\000\000\000"
-/* offset=3D120386 */ "node-speculative-load-ops\000legacy cache\000Local =
memory prefetch accesses\000legacy-cache-config=3D0x206\000\00010\000\000\0=
00\000\000"
-/* offset=3D120490 */ "node-speculative-load-access\000legacy cache\000Loc=
al memory prefetch accesses\000legacy-cache-config=3D0x206\000\00010\000\00=
0\000\000\000"
-/* offset=3D120597 */ "node-speculative-load-misses\000legacy cache\000Loc=
al memory prefetch misses\000legacy-cache-config=3D0x10206\000\00010\000\00=
0\000\000\000"
-/* offset=3D120704 */ "node-speculative-load-miss\000legacy cache\000Local=
 memory prefetch misses\000legacy-cache-config=3D0x10206\000\00010\000\000\=
000\000\000"
-/* offset=3D120809 */ "node-refs\000legacy cache\000Local memory read acce=
sses\000legacy-cache-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D120889 */ "node-reference\000legacy cache\000Local memory read=
 accesses\000legacy-cache-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D120974 */ "node-ops\000legacy cache\000Local memory read acces=
ses\000legacy-cache-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D121053 */ "node-access\000legacy cache\000Local memory read ac=
cesses\000legacy-cache-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D121135 */ "node-misses\000legacy cache\000Local memory read mi=
sses\000legacy-cache-config=3D0x10006\000\00010\000\000\000\000\000"
-/* offset=3D121221 */ "node-miss\000legacy cache\000Local memory read miss=
es\000legacy-cache-config=3D0x10006\000\00010\000\000\000\000\000"
-/* offset=3D121305 */ "cpu-cycles\000legacy hardware\000Total cycles. Be w=
ary of what happens during CPU frequency scaling [This event is an alias of=
 cycles]\000legacy-hardware-config=3D0\000\00000\000\000\000\000\000"
-/* offset=3D121467 */ "cycles\000legacy hardware\000Total cycles. Be wary =
of what happens during CPU frequency scaling [This event is an alias of cpu=
-cycles]\000legacy-hardware-config=3D0\000\00000\000\000\000\000\000"
-/* offset=3D121629 */ "instructions\000legacy hardware\000Retired instruct=
ions. Be careful, these can be affected by various issues, most notably har=
dware interrupt counts\000legacy-hardware-config=3D1\000\00000\000\000\000\=
000\000"
-/* offset=3D121805 */ "cache-references\000legacy hardware\000Cache access=
es. Usually this indicates Last Level Cache accesses but this may vary depe=
nding on your CPU.  This may include prefetches and coherency messages; aga=
in this depends on the design of your CPU\000legacy-hardware-config=3D2\000=
\00000\000\000\000\000\000"
-/* offset=3D122075 */ "cache-misses\000legacy hardware\000Cache misses. Us=
ually this indicates Last Level Cache misses; this is intended to be used i=
n conjunction with the PERF_COUNT_HW_CACHE_REFERENCES event to calculate ca=
che miss rates\000legacy-hardware-config=3D3\000\00000\000\000\000\000\000"
-/* offset=3D122318 */ "branches\000legacy hardware\000Retired branch instr=
uctions [This event is an alias of branch-instructions]\000legacy-hardware-=
config=3D4\000\00000\000\000\000\000\000"
-/* offset=3D122452 */ "branch-instructions\000legacy hardware\000Retired b=
ranch instructions [This event is an alias of branches]\000legacy-hardware-=
config=3D4\000\00000\000\000\000\000\000"
-/* offset=3D122586 */ "branch-misses\000legacy hardware\000Mispredicted br=
anch instructions\000legacy-hardware-config=3D5\000\00000\000\000\000\000\0=
00"
-/* offset=3D122682 */ "bus-cycles\000legacy hardware\000Bus cycles, which =
can be different from total cycles\000legacy-hardware-config=3D6\000\00000\=
000\000\000\000\000"
-/* offset=3D122795 */ "stalled-cycles-frontend\000legacy hardware\000Stall=
ed cycles during issue [This event is an alias of idle-cycles-frontend]\000=
legacy-hardware-config=3D7\000\00000\000\000\000\000\000"
-/* offset=3D122945 */ "idle-cycles-frontend\000legacy hardware\000Stalled =
cycles during issue [This event is an alias of stalled-cycles-fronted]\000l=
egacy-hardware-config=3D7\000\00000\000\000\000\000\000"
-/* offset=3D123094 */ "stalled-cycles-backend\000legacy hardware\000Stalle=
d cycles during retirement [This event is an alias of idle-cycles-backend]\=
000legacy-hardware-config=3D8\000\00000\000\000\000\000\000"
-/* offset=3D123247 */ "idle-cycles-backend\000legacy hardware\000Stalled c=
ycles during retirement [This event is an alias of stalled-cycles-backend]\=
000legacy-hardware-config=3D8\000\00000\000\000\000\000\000"
-/* offset=3D123400 */ "ref-cycles\000legacy hardware\000Total cycles; not =
affected by CPU frequency scaling\000legacy-hardware-config=3D9\000\00000\0=
00\000\000\000\000"
-/* offset=3D123512 */ "software\000"
-/* offset=3D123521 */ "cpu-clock\000software\000Per-CPU high-resolution ti=
mer based event\000config=3D0\000\000001e-6msec\000\000\000\000\000"
-/* offset=3D123607 */ "task-clock\000software\000Per-task high-resolution =
timer based event\000config=3D1\000\000001e-6msec\000\000\000\000\000"
-/* offset=3D123695 */ "faults\000software\000Number of page faults [This e=
vent is an alias of page-faults]\000config=3D2\000\00000\000\000\000\000\00=
0"
-/* offset=3D123790 */ "page-faults\000software\000Number of page faults [T=
his event is an alias of faults]\000config=3D2\000\00000\000\000\000\000\00=
0"
-/* offset=3D123885 */ "context-switches\000software\000Number of context s=
witches [This event is an alias of cs]\000config=3D3\000\00000\000\000\000\=
000\000"
-/* offset=3D123986 */ "cs\000software\000Number of context switches [This =
event is an alias of context-switches]\000config=3D3\000\00000\000\000\000\=
000\000"
-/* offset=3D124087 */ "cpu-migrations\000software\000Number of times a pro=
cess has migrated to a new CPU [This event is an alias of migrations]\000co=
nfig=3D4\000\00000\000\000\000\000\000"
-/* offset=3D124219 */ "migrations\000software\000Number of times a process=
 has migrated to a new CPU [This event is an alias of cpu-migrations]\000co=
nfig=3D4\000\00000\000\000\000\000\000"
-/* offset=3D124351 */ "minor-faults\000software\000Number of minor page fa=
ults. Minor faults don't require I/O to handle\000config=3D5\000\00000\000\=
000\000\000\000"
-/* offset=3D124460 */ "major-faults\000software\000Number of major page fa=
ults. Major faults require I/O to handle\000config=3D6\000\00000\000\000\00=
0\000\000"
-/* offset=3D124563 */ "alignment-faults\000software\000Number of kernel ha=
ndled memory alignment faults\000config=3D7\000\00000\000\000\000\000\000"
-/* offset=3D124655 */ "emulation-faults\000software\000Number of kernel ha=
ndled unimplemented instruction faults handled through emulation\000config=
=3D8\000\00000\000\000\000\000\000"
-/* offset=3D124782 */ "dummy\000software\000A placeholder event that doesn=
't count anything\000config=3D9\000\00000\000\000\000\000\000"
-/* offset=3D124862 */ "bpf-output\000software\000An event used by BPF prog=
rams to write to the perf ring buffer\000config=3D0xa\000\00000\000\000\000=
\000\000"
-/* offset=3D124964 */ "cgroup-switches\000software\000Number of context sw=
itches to a task in a different cgroup\000config=3D0xb\000\00000\000\000\00=
0\000\000"
-/* offset=3D125067 */ "tool\000"
-/* offset=3D125072 */ "duration_time\000tool\000Wall clock interval time i=
n nanoseconds\000config=3D1\000\00000\000\000\000\000\000"
-/* offset=3D125148 */ "user_time\000tool\000User (non-kernel) time in nano=
seconds\000config=3D2\000\00000\000\000\000\000\000"
-/* offset=3D125218 */ "system_time\000tool\000System/kernel time in nanose=
conds\000config=3D3\000\00000\000\000\000\000\000"
-/* offset=3D125286 */ "has_pmem\000tool\0001 if persistent memory installe=
d otherwise 0\000config=3D4\000\00000\000\000\000\000\000"
-/* offset=3D125362 */ "num_cores\000tool\000Number of cores. A core consis=
ts of 1 or more thread, with each thread being associated with a logical Li=
nux CPU\000config=3D5\000\00000\000\000\000\000\000"
-/* offset=3D125507 */ "num_cpus\000tool\000Number of logical Linux CPUs. T=
here may be multiple such CPUs on a core\000config=3D6\000\00000\000\000\00=
0\000\000"
-/* offset=3D125610 */ "num_cpus_online\000tool\000Number of online logical=
 Linux CPUs. There may be multiple such CPUs on a core\000config=3D7\000\00=
000\000\000\000\000\000"
-/* offset=3D125727 */ "num_dies\000tool\000Number of dies. Each die has 1 =
or more cores\000config=3D8\000\00000\000\000\000\000\000"
-/* offset=3D125803 */ "num_packages\000tool\000Number of packages. Each pa=
ckage has 1 or more die\000config=3D9\000\00000\000\000\000\000\000"
-/* offset=3D125889 */ "slots\000tool\000Number of functional units that in=
 parallel can execute parts of an instruction\000config=3D0xa\000\00000\000=
\000\000\000\000"
-/* offset=3D125999 */ "smt_on\000tool\0001 if simultaneous multithreading =
(aka hyperthreading) is enable otherwise 0\000config=3D0xb\000\00000\000\00=
0\000\000\000"
-/* offset=3D126106 */ "system_tsc_freq\000tool\000The amount a Time Stamp =
Counter (TSC) increases per second\000config=3D0xc\000\00000\000\000\000\00=
0\000"
-/* offset=3D126205 */ "core_wide\000tool\0001 if not SMT, if SMT are event=
s being gathered on all SMT threads 1 otherwise 0\000config=3D0xd\000\00000=
\000\000\000\000\000"
-/* offset=3D126319 */ "target_cpu\000tool\0001 if CPUs being analyzed, 0 i=
f threads/processes\000config=3D0xe\000\00000\000\000\000\000\000"
-/* offset=3D126403 */ "bp_l1_btb_correct\000branch\000L1 BTB Correction\00=
0event=3D0x8a\000\00000\000\000\000\000\000"
-/* offset=3D126465 */ "bp_l2_btb_correct\000branch\000L2 BTB Correction\00=
0event=3D0x8b\000\00000\000\000\000\000\000"
-/* offset=3D126527 */ "l3_cache_rd\000cache\000L3 cache access, read\000ev=
ent=3D0x40\000\00000\000\000\000\000Attributable Level 3 cache access, read=
\000"
-/* offset=3D126625 */ "segment_reg_loads.any\000other\000Number of segment=
 register loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\000=
\000\000\000"
-/* offset=3D126727 */ "dispatch_blocked.any\000other\000Memory cluster sig=
nals to block micro-op dispatch for any reason\000event=3D9,period=3D200000=
,umask=3D0x20\000\00000\000\000\000\000\000"
-/* offset=3D126860 */ "eist_trans\000other\000Number of Enhanced Intel Spe=
edStep(R) Technology (EIST) transitions\000event=3D0x3a,period=3D200000\000=
\00000\000\000\000\000\000"
-/* offset=3D126978 */ "hisi_sccl,ddrc\000"
-/* offset=3D126993 */ "uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write =
commands\000event=3D2\000\00000\000\000\000\000\000"
-/* offset=3D127063 */ "uncore_cbox\000"
-/* offset=3D127075 */ "unc_cbo_xsnp_response.miss_eviction\000uncore\000A =
cross-core snoop resulted from L3 Eviction which misses in some processor c=
ore\000event=3D0x22,umask=3D0x81\000\00000\000\000\000\000\000"
-/* offset=3D127229 */ "event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=
=3D0xe0\000\00000\000\000\000\000\000"
-/* offset=3D127283 */ "event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000eve=
nt=3D0xc0\000\00000\000\000\000\000\000"
-/* offset=3D127341 */ "hisi_sccl,l3c\000"
-/* offset=3D127355 */ "uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total rea=
d hits\000event=3D7\000\00000\000\000\000\000\000"
-/* offset=3D127423 */ "uncore_imc_free_running\000"
-/* offset=3D127447 */ "uncore_imc_free_running.cache_miss\000uncore\000Tot=
al cache misses\000event=3D0x12\000\00000\000\000\000\000\000"
-/* offset=3D127527 */ "uncore_imc\000"
-/* offset=3D127538 */ "uncore_imc.cache_hits\000uncore\000Total cache hits=
\000event=3D0x34\000\00000\000\000\000\000\000"
-/* offset=3D127603 */ "uncore_sys_ddr_pmu\000"
-/* offset=3D127622 */ "sys_ddr_pmu.write_cycles\000uncore\000ddr write-cyc=
les event\000event=3D0x2b\000v8\00000\000\000\000\000\000"
-/* offset=3D127698 */ "uncore_sys_ccn_pmu\000"
-/* offset=3D127717 */ "sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycle=
s event\000config=3D0x2c\0000x01\00000\000\000\000\000\000"
-/* offset=3D127794 */ "uncore_sys_cmn_pmu\000"
-/* offset=3D127813 */ "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts tota=
l cache misses in first lookup result (high priority)\000eventid=3D1,type=
=3D5\000(434|436|43c|43a).*\00000\000\000\000\000\000"
-/* offset=3D127956 */ "CPUs_utilized\000Default\000(software@cpu\\-clock\\=
,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=
=3Dtask\\-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\00=
0\0001CPUs\000\000\000\000011"
-/* offset=3D128142 */ "cs_per_second\000Default\000software@context\\-swit=
ches\\,name\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Context switches per CPU second\000\0001cs/sec\000\000\000\=
000011"
-/* offset=3D128375 */ "migrations_per_second\000Default\000software@cpu\\-=
migrations\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,nam=
e\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtas=
k\\-clock@)\000\000Process migrations to a new CPU per CPU second\000\0001m=
igrations/sec\000\000\000\000011"
-/* offset=3D128635 */ "page_faults_per_second\000Default\000software@page\=
\-faults\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Page faults per CPU second\000\0001faults/sec\000\000\000\0=
00011"
-/* offset=3D128866 */ "insn_per_cycle\000Default\000instructions / cpu\\-c=
ycles\000insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\=
000\000\000\000001"
-/* offset=3D128979 */ "stalled_cycles_per_instruction\000Default\000(max(s=
talled\\-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions if h=
as_event(stalled\\-cycles\\-frontend) & has_event(stalled\\-cycles\\-backen=
d) else (stalled\\-cycles\\-frontend / instructions if has_event(stalled\\-=
cycles\\-frontend) else (stalled\\-cycles\\-backend / instructions if has_e=
vent(stalled\\-cycles\\-backend) else 0)))\000\000Max front or backend stal=
ls per instruction\000\000\000\000\000\000001"
-/* offset=3D129404 */ "frontend_cycles_idle\000Default\000(stalled\\-cycle=
s\\-frontend / cpu\\-cycles if has_event(stalled\\-cycles\\-frontend) else =
0)\000frontend_cycles_idle > 0.1\000Frontend stalls per cycle\000\000\000\0=
00\000\000001"
-/* offset=3D129583 */ "backend_cycles_idle\000Default\000(stalled\\-cycles=
\\-backend / cpu\\-cycles if has_event(stalled\\-cycles\\-backend) else 0)\=
000backend_cycles_idle > 0.2\000Backend stalls per cycle\000\000\000\000\00=
0\000001"
-/* offset=3D129757 */ "cycles_frequency\000Default\000cpu\\-cycles / (soft=
ware@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\=
\-clock\\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\=
000\000\000\000011"
-/* offset=3D129933 */ "branch_frequency\000Default\000branches / (software=
@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-cl=
ock\\,name\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000M/s=
ec\000\000\000\000011"
-/* offset=3D130113 */ "branch_miss_rate\000Default\000branch\\-misses / br=
anches\000branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\0=
00\000001"
-/* offset=3D130217 */ "l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-m=
isses / L1\\-dcache\\-loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000\0=
00100%\000\000\000\000001"
-/* offset=3D130333 */ "llc_miss_rate\000Default2\000LLC\\-load\\-misses / =
LLC\\-loads\000llc_miss_rate > 0.05\000LLC miss rate\000\000100%\000\000\00=
0\000001"
-/* offset=3D130434 */ "l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-m=
isses / L1\\-icache\\-loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\00=
0100%\000\000\000\000001"
-/* offset=3D130549 */ "dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses =
/ dTLB\\-loads\000dtlb_miss_rate > 0.05\000dTLB miss rate\000\000100%\000\0=
00\000\000001"
-/* offset=3D130655 */ "itlb_miss_rate\000Default3\000iTLB\\-load\\-misses =
/ iTLB\\-loads\000itlb_miss_rate > 0.05\000iTLB miss rate\000\000100%\000\0=
00\000\000001"
-/* offset=3D130761 */ "l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-=
prefetch\\-misses / L1\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0.0=
5\000L1 prefetch miss rate\000\000100%\000\000\000\000001"
-/* offset=3D130909 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\0000=
00"
-/* offset=3D130932 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhalte=
d.thread\000\000\000\000\000\000\000\000000"
-/* offset=3D130996 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.co=
re / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_a=
ctive / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000"
-/* offset=3D131163 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_=
retired.any\000\000\000\000\000\000\000\000000"
-/* offset=3D131228 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / in=
st_retired.any\000\000\000\000\000\000\000\000000"
-/* offset=3D131296 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + ic=
ache_miss_cycles\000\000\000\000\000\000\000\000000"
-/* offset=3D131368 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_h=
it + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000"
-/* offset=3D131463 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_d=
ata_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_=
miss\000\000\000\000\000\000\000\000000"
-/* offset=3D131598 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2=
_All_Miss\000\000\000\000\000\000\000\000000"
-/* offset=3D131663 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, D=
Cache_L2_All)\000\000\000\000\000\000\000\000000"
-/* offset=3D131732 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss,=
 DCache_L2_All)\000\000\000\000\000\000\000\000000"
-/* offset=3D131803 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\0000=
00"
-/* offset=3D131826 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\0000=
00"
-/* offset=3D131849 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\000000=
"
-/* offset=3D131870 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9=
 / duration_time\000\000\000\000\000\000\000\000000"
+/* offset=3D0 */
+"default_core\000"
+/* offset=3D13 */
+"l1-dcache\000legacy cache\000Level 1 data cache read accesses\000legacy-c=
ache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D99 */
+"l1-dcache-load\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D190 */
+"l1-dcache-load-refs\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D286 */
+"l1-dcache-load-reference\000legacy cache\000Level 1 data cache read acces=
ses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D387 */
+"l1-dcache-load-ops\000legacy cache\000Level 1 data cache read accesses\00=
0legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D482 */
+"l1-dcache-load-access\000legacy cache\000Level 1 data cache read accesses=
\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D580 */
+"l1-dcache-load-misses\000legacy cache\000Level 1 data cache read misses\0=
00legacy-cache-config=3D0x10000\000\00000\000\000\000\000\000"
+/* offset=3D682 */
+"l1-dcache-load-miss\000legacy cache\000Level 1 data cache read misses\000=
legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D782 */
+"l1-dcache-loads\000legacy cache\000Level 1 data cache read accesses\000le=
gacy-cache-config=3D0\000\00000\000\000\000\000\000"
+/* offset=3D874 */
+"l1-dcache-loads-refs\000legacy cache\000Level 1 data cache read accesses\=
000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D971 */
+"l1-dcache-loads-reference\000legacy cache\000Level 1 data cache read acce=
sses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D1073 */
+"l1-dcache-loads-ops\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D1169 */
+"l1-dcache-loads-access\000legacy cache\000Level 1 data cache read accesse=
s\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D1268 */
+"l1-dcache-loads-misses\000legacy cache\000Level 1 data cache read misses\=
000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D1371 */
+"l1-dcache-loads-miss\000legacy cache\000Level 1 data cache read misses\00=
0legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D1472 */
+"l1-dcache-read\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D1563 */
+"l1-dcache-read-refs\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D1659 */
+"l1-dcache-read-reference\000legacy cache\000Level 1 data cache read acces=
ses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D1760 */
+"l1-dcache-read-ops\000legacy cache\000Level 1 data cache read accesses\00=
0legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D1855 */
+"l1-dcache-read-access\000legacy cache\000Level 1 data cache read accesses=
\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D1953 */
+"l1-dcache-read-misses\000legacy cache\000Level 1 data cache read misses\0=
00legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D2055 */
+"l1-dcache-read-miss\000legacy cache\000Level 1 data cache read misses\000=
legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D2155 */
+"l1-dcache-store\000legacy cache\000Level 1 data cache write accesses\000l=
egacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D2252 */
+"l1-dcache-store-refs\000legacy cache\000Level 1 data cache write accesses=
\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D2354 */
+"l1-dcache-store-reference\000legacy cache\000Level 1 data cache write acc=
esses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D2461 */
+"l1-dcache-store-ops\000legacy cache\000Level 1 data cache write accesses\=
000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D2562 */
+"l1-dcache-store-access\000legacy cache\000Level 1 data cache write access=
es\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D2666 */
+"l1-dcache-store-misses\000legacy cache\000Level 1 data cache write misses=
\000legacy-cache-config=3D0x10100\000\00000\000\000\000\000\000"
+/* offset=3D2770 */
+"l1-dcache-store-miss\000legacy cache\000Level 1 data cache write misses\0=
00legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D2872 */
+"l1-dcache-stores\000legacy cache\000Level 1 data cache write accesses\000=
legacy-cache-config=3D0x100\000\00000\000\000\000\000\000"
+/* offset=3D2970 */
+"l1-dcache-stores-refs\000legacy cache\000Level 1 data cache write accesse=
s\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D3073 */
+"l1-dcache-stores-reference\000legacy cache\000Level 1 data cache write ac=
cesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D3181 */
+"l1-dcache-stores-ops\000legacy cache\000Level 1 data cache write accesses=
\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D3283 */
+"l1-dcache-stores-access\000legacy cache\000Level 1 data cache write acces=
ses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D3388 */
+"l1-dcache-stores-misses\000legacy cache\000Level 1 data cache write misse=
s\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D3493 */
+"l1-dcache-stores-miss\000legacy cache\000Level 1 data cache write misses\=
000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D3596 */
+"l1-dcache-write\000legacy cache\000Level 1 data cache write accesses\000l=
egacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D3693 */
+"l1-dcache-write-refs\000legacy cache\000Level 1 data cache write accesses=
\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D3795 */
+"l1-dcache-write-reference\000legacy cache\000Level 1 data cache write acc=
esses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D3902 */
+"l1-dcache-write-ops\000legacy cache\000Level 1 data cache write accesses\=
000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D4003 */
+"l1-dcache-write-access\000legacy cache\000Level 1 data cache write access=
es\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D4107 */
+"l1-dcache-write-misses\000legacy cache\000Level 1 data cache write misses=
\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D4211 */
+"l1-dcache-write-miss\000legacy cache\000Level 1 data cache write misses\0=
00legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D4313 */
+"l1-dcache-prefetch\000legacy cache\000Level 1 data cache prefetch accesse=
s\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D4416 */
+"l1-dcache-prefetch-refs\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D4524 */
+"l1-dcache-prefetch-reference\000legacy cache\000Level 1 data cache prefet=
ch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D4637 */
+"l1-dcache-prefetch-ops\000legacy cache\000Level 1 data cache prefetch acc=
esses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D4744 */
+"l1-dcache-prefetch-access\000legacy cache\000Level 1 data cache prefetch =
accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D4854 */
+"l1-dcache-prefetch-misses\000legacy cache\000Level 1 data cache prefetch =
misses\000legacy-cache-config=3D0x10200\000\00000\000\000\000\000\000"
+/* offset=3D4964 */
+"l1-dcache-prefetch-miss\000legacy cache\000Level 1 data cache prefetch mi=
sses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D5072 */
+"l1-dcache-prefetches\000legacy cache\000Level 1 data cache prefetch acces=
ses\000legacy-cache-config=3D0x200\000\00000\000\000\000\000\000"
+/* offset=3D5177 */
+"l1-dcache-prefetches-refs\000legacy cache\000Level 1 data cache prefetch =
accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D5287 */
+"l1-dcache-prefetches-reference\000legacy cache\000Level 1 data cache pref=
etch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D5402 */
+"l1-dcache-prefetches-ops\000legacy cache\000Level 1 data cache prefetch a=
ccesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D5511 */
+"l1-dcache-prefetches-access\000legacy cache\000Level 1 data cache prefetc=
h accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D5623 */
+"l1-dcache-prefetches-misses\000legacy cache\000Level 1 data cache prefetc=
h misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D5735 */
+"l1-dcache-prefetches-miss\000legacy cache\000Level 1 data cache prefetch =
misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D5845 */
+"l1-dcache-speculative-read\000legacy cache\000Level 1 data cache prefetch=
 accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D5956 */
+"l1-dcache-speculative-read-refs\000legacy cache\000Level 1 data cache pre=
fetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000=
"
+/* offset=3D6072 */
+"l1-dcache-speculative-read-reference\000legacy cache\000Level 1 data cach=
e prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\00=
0\000"
+/* offset=3D6193 */
+"l1-dcache-speculative-read-ops\000legacy cache\000Level 1 data cache pref=
etch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D6308 */
+"l1-dcache-speculative-read-access\000legacy cache\000Level 1 data cache p=
refetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\0=
00"
+/* offset=3D6426 */
+"l1-dcache-speculative-read-misses\000legacy cache\000Level 1 data cache p=
refetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\0=
00"
+/* offset=3D6544 */
+"l1-dcache-speculative-read-miss\000legacy cache\000Level 1 data cache pre=
fetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000=
"
+/* offset=3D6660 */
+"l1-dcache-speculative-load\000legacy cache\000Level 1 data cache prefetch=
 accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D6771 */
+"l1-dcache-speculative-load-refs\000legacy cache\000Level 1 data cache pre=
fetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000=
"
+/* offset=3D6887 */
+"l1-dcache-speculative-load-reference\000legacy cache\000Level 1 data cach=
e prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\00=
0\000"
+/* offset=3D7008 */
+"l1-dcache-speculative-load-ops\000legacy cache\000Level 1 data cache pref=
etch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D7123 */
+"l1-dcache-speculative-load-access\000legacy cache\000Level 1 data cache p=
refetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\0=
00"
+/* offset=3D7241 */
+"l1-dcache-speculative-load-misses\000legacy cache\000Level 1 data cache p=
refetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\0=
00"
+/* offset=3D7359 */
+"l1-dcache-speculative-load-miss\000legacy cache\000Level 1 data cache pre=
fetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000=
"
+/* offset=3D7475 */
+"l1-dcache-refs\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D7566 */
+"l1-dcache-reference\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D7662 */
+"l1-dcache-ops\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D7752 */
+"l1-dcache-access\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D7845 */
+"l1-dcache-misses\000legacy cache\000Level 1 data cache read misses\000leg=
acy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D7942 */
+"l1-dcache-miss\000legacy cache\000Level 1 data cache read misses\000legac=
y-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D8037 */
+"l1-d\000legacy cache\000Level 1 data cache read accesses\000legacy-cache-=
config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D8118 */
+"l1-d-load\000legacy cache\000Level 1 data cache read accesses\000legacy-c=
ache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D8204 */
+"l1-d-load-refs\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D8295 */
+"l1-d-load-reference\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D8391 */
+"l1-d-load-ops\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D8481 */
+"l1-d-load-access\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D8574 */
+"l1-d-load-misses\000legacy cache\000Level 1 data cache read misses\000leg=
acy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D8671 */
+"l1-d-load-miss\000legacy cache\000Level 1 data cache read misses\000legac=
y-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D8766 */
+"l1-d-loads\000legacy cache\000Level 1 data cache read accesses\000legacy-=
cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D8853 */
+"l1-d-loads-refs\000legacy cache\000Level 1 data cache read accesses\000le=
gacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D8945 */
+"l1-d-loads-reference\000legacy cache\000Level 1 data cache read accesses\=
000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D9042 */
+"l1-d-loads-ops\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D9133 */
+"l1-d-loads-access\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D9227 */
+"l1-d-loads-misses\000legacy cache\000Level 1 data cache read misses\000le=
gacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D9325 */
+"l1-d-loads-miss\000legacy cache\000Level 1 data cache read misses\000lega=
cy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D9421 */
+"l1-d-read\000legacy cache\000Level 1 data cache read accesses\000legacy-c=
ache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D9507 */
+"l1-d-read-refs\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D9598 */
+"l1-d-read-reference\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D9694 */
+"l1-d-read-ops\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D9784 */
+"l1-d-read-access\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D9877 */
+"l1-d-read-misses\000legacy cache\000Level 1 data cache read misses\000leg=
acy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D9974 */
+"l1-d-read-miss\000legacy cache\000Level 1 data cache read misses\000legac=
y-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D10069 */
+"l1-d-store\000legacy cache\000Level 1 data cache write accesses\000legacy=
-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D10161 */
+"l1-d-store-refs\000legacy cache\000Level 1 data cache write accesses\000l=
egacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D10258 */
+"l1-d-store-reference\000legacy cache\000Level 1 data cache write accesses=
\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D10360 */
+"l1-d-store-ops\000legacy cache\000Level 1 data cache write accesses\000le=
gacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D10456 */
+"l1-d-store-access\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D10555 */
+"l1-d-store-misses\000legacy cache\000Level 1 data cache write misses\000l=
egacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D10654 */
+"l1-d-store-miss\000legacy cache\000Level 1 data cache write misses\000leg=
acy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D10751 */
+"l1-d-stores\000legacy cache\000Level 1 data cache write accesses\000legac=
y-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D10844 */
+"l1-d-stores-refs\000legacy cache\000Level 1 data cache write accesses\000=
legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D10942 */
+"l1-d-stores-reference\000legacy cache\000Level 1 data cache write accesse=
s\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D11045 */
+"l1-d-stores-ops\000legacy cache\000Level 1 data cache write accesses\000l=
egacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D11142 */
+"l1-d-stores-access\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D11242 */
+"l1-d-stores-misses\000legacy cache\000Level 1 data cache write misses\000=
legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D11342 */
+"l1-d-stores-miss\000legacy cache\000Level 1 data cache write misses\000le=
gacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D11440 */
+"l1-d-write\000legacy cache\000Level 1 data cache write accesses\000legacy=
-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D11532 */
+"l1-d-write-refs\000legacy cache\000Level 1 data cache write accesses\000l=
egacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D11629 */
+"l1-d-write-reference\000legacy cache\000Level 1 data cache write accesses=
\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D11731 */
+"l1-d-write-ops\000legacy cache\000Level 1 data cache write accesses\000le=
gacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D11827 */
+"l1-d-write-access\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D11926 */
+"l1-d-write-misses\000legacy cache\000Level 1 data cache write misses\000l=
egacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D12025 */
+"l1-d-write-miss\000legacy cache\000Level 1 data cache write misses\000leg=
acy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D12122 */
+"l1-d-prefetch\000legacy cache\000Level 1 data cache prefetch accesses\000=
legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D12220 */
+"l1-d-prefetch-refs\000legacy cache\000Level 1 data cache prefetch accesse=
s\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D12323 */
+"l1-d-prefetch-reference\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D12431 */
+"l1-d-prefetch-ops\000legacy cache\000Level 1 data cache prefetch accesses=
\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D12533 */
+"l1-d-prefetch-access\000legacy cache\000Level 1 data cache prefetch acces=
ses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D12638 */
+"l1-d-prefetch-misses\000legacy cache\000Level 1 data cache prefetch misse=
s\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D12743 */
+"l1-d-prefetch-miss\000legacy cache\000Level 1 data cache prefetch misses\=
000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D12846 */
+"l1-d-prefetches\000legacy cache\000Level 1 data cache prefetch accesses\0=
00legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D12946 */
+"l1-d-prefetches-refs\000legacy cache\000Level 1 data cache prefetch acces=
ses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D13051 */
+"l1-d-prefetches-reference\000legacy cache\000Level 1 data cache prefetch =
accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D13161 */
+"l1-d-prefetches-ops\000legacy cache\000Level 1 data cache prefetch access=
es\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D13265 */
+"l1-d-prefetches-access\000legacy cache\000Level 1 data cache prefetch acc=
esses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D13372 */
+"l1-d-prefetches-misses\000legacy cache\000Level 1 data cache prefetch mis=
ses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D13479 */
+"l1-d-prefetches-miss\000legacy cache\000Level 1 data cache prefetch misse=
s\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D13584 */
+"l1-d-speculative-read\000legacy cache\000Level 1 data cache prefetch acce=
sses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D13690 */
+"l1-d-speculative-read-refs\000legacy cache\000Level 1 data cache prefetch=
 accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D13801 */
+"l1-d-speculative-read-reference\000legacy cache\000Level 1 data cache pre=
fetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000=
"
+/* offset=3D13917 */
+"l1-d-speculative-read-ops\000legacy cache\000Level 1 data cache prefetch =
accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D14027 */
+"l1-d-speculative-read-access\000legacy cache\000Level 1 data cache prefet=
ch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D14140 */
+"l1-d-speculative-read-misses\000legacy cache\000Level 1 data cache prefet=
ch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D14253 */
+"l1-d-speculative-read-miss\000legacy cache\000Level 1 data cache prefetch=
 misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D14364 */
+"l1-d-speculative-load\000legacy cache\000Level 1 data cache prefetch acce=
sses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D14470 */
+"l1-d-speculative-load-refs\000legacy cache\000Level 1 data cache prefetch=
 accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D14581 */
+"l1-d-speculative-load-reference\000legacy cache\000Level 1 data cache pre=
fetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000=
"
+/* offset=3D14697 */
+"l1-d-speculative-load-ops\000legacy cache\000Level 1 data cache prefetch =
accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D14807 */
+"l1-d-speculative-load-access\000legacy cache\000Level 1 data cache prefet=
ch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D14920 */
+"l1-d-speculative-load-misses\000legacy cache\000Level 1 data cache prefet=
ch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D15033 */
+"l1-d-speculative-load-miss\000legacy cache\000Level 1 data cache prefetch=
 misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D15144 */
+"l1-d-refs\000legacy cache\000Level 1 data cache read accesses\000legacy-c=
ache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D15230 */
+"l1-d-reference\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D15321 */
+"l1-d-ops\000legacy cache\000Level 1 data cache read accesses\000legacy-ca=
che-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D15406 */
+"l1-d-access\000legacy cache\000Level 1 data cache read accesses\000legacy=
-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D15494 */
+"l1-d-misses\000legacy cache\000Level 1 data cache read misses\000legacy-c=
ache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D15586 */
+"l1-d-miss\000legacy cache\000Level 1 data cache read misses\000legacy-cac=
he-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D15676 */
+"l1d\000legacy cache\000Level 1 data cache read accesses\000legacy-cache-c=
onfig=3D0\000\00010\000\000\000\000\000"
+/* offset=3D15756 */
+"l1d-load\000legacy cache\000Level 1 data cache read accesses\000legacy-ca=
che-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D15841 */
+"l1d-load-refs\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D15931 */
+"l1d-load-reference\000legacy cache\000Level 1 data cache read accesses\00=
0legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D16026 */
+"l1d-load-ops\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D16115 */
+"l1d-load-access\000legacy cache\000Level 1 data cache read accesses\000le=
gacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D16207 */
+"l1d-load-misses\000legacy cache\000Level 1 data cache read misses\000lega=
cy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D16303 */
+"l1d-load-miss\000legacy cache\000Level 1 data cache read misses\000legacy=
-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D16397 */
+"l1d-loads\000legacy cache\000Level 1 data cache read accesses\000legacy-c=
ache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D16483 */
+"l1d-loads-refs\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D16574 */
+"l1d-loads-reference\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D16670 */
+"l1d-loads-ops\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D16760 */
+"l1d-loads-access\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D16853 */
+"l1d-loads-misses\000legacy cache\000Level 1 data cache read misses\000leg=
acy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D16950 */
+"l1d-loads-miss\000legacy cache\000Level 1 data cache read misses\000legac=
y-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D17045 */
+"l1d-read\000legacy cache\000Level 1 data cache read accesses\000legacy-ca=
che-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D17130 */
+"l1d-read-refs\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D17220 */
+"l1d-read-reference\000legacy cache\000Level 1 data cache read accesses\00=
0legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D17315 */
+"l1d-read-ops\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D17404 */
+"l1d-read-access\000legacy cache\000Level 1 data cache read accesses\000le=
gacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D17496 */
+"l1d-read-misses\000legacy cache\000Level 1 data cache read misses\000lega=
cy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D17592 */
+"l1d-read-miss\000legacy cache\000Level 1 data cache read misses\000legacy=
-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D17686 */
+"l1d-store\000legacy cache\000Level 1 data cache write accesses\000legacy-=
cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D17777 */
+"l1d-store-refs\000legacy cache\000Level 1 data cache write accesses\000le=
gacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D17873 */
+"l1d-store-reference\000legacy cache\000Level 1 data cache write accesses\=
000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D17974 */
+"l1d-store-ops\000legacy cache\000Level 1 data cache write accesses\000leg=
acy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D18069 */
+"l1d-store-access\000legacy cache\000Level 1 data cache write accesses\000=
legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D18167 */
+"l1d-store-misses\000legacy cache\000Level 1 data cache write misses\000le=
gacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D18265 */
+"l1d-store-miss\000legacy cache\000Level 1 data cache write misses\000lega=
cy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D18361 */
+"l1d-stores\000legacy cache\000Level 1 data cache write accesses\000legacy=
-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D18453 */
+"l1d-stores-refs\000legacy cache\000Level 1 data cache write accesses\000l=
egacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D18550 */
+"l1d-stores-reference\000legacy cache\000Level 1 data cache write accesses=
\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D18652 */
+"l1d-stores-ops\000legacy cache\000Level 1 data cache write accesses\000le=
gacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D18748 */
+"l1d-stores-access\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D18847 */
+"l1d-stores-misses\000legacy cache\000Level 1 data cache write misses\000l=
egacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D18946 */
+"l1d-stores-miss\000legacy cache\000Level 1 data cache write misses\000leg=
acy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D19043 */
+"l1d-write\000legacy cache\000Level 1 data cache write accesses\000legacy-=
cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D19134 */
+"l1d-write-refs\000legacy cache\000Level 1 data cache write accesses\000le=
gacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D19230 */
+"l1d-write-reference\000legacy cache\000Level 1 data cache write accesses\=
000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D19331 */
+"l1d-write-ops\000legacy cache\000Level 1 data cache write accesses\000leg=
acy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D19426 */
+"l1d-write-access\000legacy cache\000Level 1 data cache write accesses\000=
legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D19524 */
+"l1d-write-misses\000legacy cache\000Level 1 data cache write misses\000le=
gacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D19622 */
+"l1d-write-miss\000legacy cache\000Level 1 data cache write misses\000lega=
cy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D19718 */
+"l1d-prefetch\000legacy cache\000Level 1 data cache prefetch accesses\000l=
egacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D19815 */
+"l1d-prefetch-refs\000legacy cache\000Level 1 data cache prefetch accesses=
\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D19917 */
+"l1d-prefetch-reference\000legacy cache\000Level 1 data cache prefetch acc=
esses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D20024 */
+"l1d-prefetch-ops\000legacy cache\000Level 1 data cache prefetch accesses\=
000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D20125 */
+"l1d-prefetch-access\000legacy cache\000Level 1 data cache prefetch access=
es\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D20229 */
+"l1d-prefetch-misses\000legacy cache\000Level 1 data cache prefetch misses=
\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D20333 */
+"l1d-prefetch-miss\000legacy cache\000Level 1 data cache prefetch misses\0=
00legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D20435 */
+"l1d-prefetches\000legacy cache\000Level 1 data cache prefetch accesses\00=
0legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D20534 */
+"l1d-prefetches-refs\000legacy cache\000Level 1 data cache prefetch access=
es\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D20638 */
+"l1d-prefetches-reference\000legacy cache\000Level 1 data cache prefetch a=
ccesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D20747 */
+"l1d-prefetches-ops\000legacy cache\000Level 1 data cache prefetch accesse=
s\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D20850 */
+"l1d-prefetches-access\000legacy cache\000Level 1 data cache prefetch acce=
sses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D20956 */
+"l1d-prefetches-misses\000legacy cache\000Level 1 data cache prefetch miss=
es\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D21062 */
+"l1d-prefetches-miss\000legacy cache\000Level 1 data cache prefetch misses=
\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D21166 */
+"l1d-speculative-read\000legacy cache\000Level 1 data cache prefetch acces=
ses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D21271 */
+"l1d-speculative-read-refs\000legacy cache\000Level 1 data cache prefetch =
accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D21381 */
+"l1d-speculative-read-reference\000legacy cache\000Level 1 data cache pref=
etch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D21496 */
+"l1d-speculative-read-ops\000legacy cache\000Level 1 data cache prefetch a=
ccesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D21605 */
+"l1d-speculative-read-access\000legacy cache\000Level 1 data cache prefetc=
h accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D21717 */
+"l1d-speculative-read-misses\000legacy cache\000Level 1 data cache prefetc=
h misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D21829 */
+"l1d-speculative-read-miss\000legacy cache\000Level 1 data cache prefetch =
misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D21939 */
+"l1d-speculative-load\000legacy cache\000Level 1 data cache prefetch acces=
ses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D22044 */
+"l1d-speculative-load-refs\000legacy cache\000Level 1 data cache prefetch =
accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D22154 */
+"l1d-speculative-load-reference\000legacy cache\000Level 1 data cache pref=
etch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D22269 */
+"l1d-speculative-load-ops\000legacy cache\000Level 1 data cache prefetch a=
ccesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D22378 */
+"l1d-speculative-load-access\000legacy cache\000Level 1 data cache prefetc=
h accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D22490 */
+"l1d-speculative-load-misses\000legacy cache\000Level 1 data cache prefetc=
h misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D22602 */
+"l1d-speculative-load-miss\000legacy cache\000Level 1 data cache prefetch =
misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D22712 */
+"l1d-refs\000legacy cache\000Level 1 data cache read accesses\000legacy-ca=
che-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D22797 */
+"l1d-reference\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D22887 */
+"l1d-ops\000legacy cache\000Level 1 data cache read accesses\000legacy-cac=
he-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D22971 */
+"l1d-access\000legacy cache\000Level 1 data cache read accesses\000legacy-=
cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D23058 */
+"l1d-misses\000legacy cache\000Level 1 data cache read misses\000legacy-ca=
che-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D23149 */
+"l1d-miss\000legacy cache\000Level 1 data cache read misses\000legacy-cach=
e-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D23238 */
+"l1-data\000legacy cache\000Level 1 data cache read accesses\000legacy-cac=
he-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D23322 */
+"l1-data-load\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D23411 */
+"l1-data-load-refs\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D23505 */
+"l1-data-load-reference\000legacy cache\000Level 1 data cache read accesse=
s\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D23604 */
+"l1-data-load-ops\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D23697 */
+"l1-data-load-access\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D23793 */
+"l1-data-load-misses\000legacy cache\000Level 1 data cache read misses\000=
legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D23893 */
+"l1-data-load-miss\000legacy cache\000Level 1 data cache read misses\000le=
gacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D23991 */
+"l1-data-loads\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D24081 */
+"l1-data-loads-refs\000legacy cache\000Level 1 data cache read accesses\00=
0legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D24176 */
+"l1-data-loads-reference\000legacy cache\000Level 1 data cache read access=
es\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D24276 */
+"l1-data-loads-ops\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D24370 */
+"l1-data-loads-access\000legacy cache\000Level 1 data cache read accesses\=
000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D24467 */
+"l1-data-loads-misses\000legacy cache\000Level 1 data cache read misses\00=
0legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D24568 */
+"l1-data-loads-miss\000legacy cache\000Level 1 data cache read misses\000l=
egacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D24667 */
+"l1-data-read\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D24756 */
+"l1-data-read-refs\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D24850 */
+"l1-data-read-reference\000legacy cache\000Level 1 data cache read accesse=
s\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D24949 */
+"l1-data-read-ops\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D25042 */
+"l1-data-read-access\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D25138 */
+"l1-data-read-misses\000legacy cache\000Level 1 data cache read misses\000=
legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D25238 */
+"l1-data-read-miss\000legacy cache\000Level 1 data cache read misses\000le=
gacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D25336 */
+"l1-data-store\000legacy cache\000Level 1 data cache write accesses\000leg=
acy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D25431 */
+"l1-data-store-refs\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D25531 */
+"l1-data-store-reference\000legacy cache\000Level 1 data cache write acces=
ses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D25636 */
+"l1-data-store-ops\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D25735 */
+"l1-data-store-access\000legacy cache\000Level 1 data cache write accesses=
\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D25837 */
+"l1-data-store-misses\000legacy cache\000Level 1 data cache write misses\0=
00legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D25939 */
+"l1-data-store-miss\000legacy cache\000Level 1 data cache write misses\000=
legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D26039 */
+"l1-data-stores\000legacy cache\000Level 1 data cache write accesses\000le=
gacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D26135 */
+"l1-data-stores-refs\000legacy cache\000Level 1 data cache write accesses\=
000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D26236 */
+"l1-data-stores-reference\000legacy cache\000Level 1 data cache write acce=
sses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D26342 */
+"l1-data-stores-ops\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D26442 */
+"l1-data-stores-access\000legacy cache\000Level 1 data cache write accesse=
s\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D26545 */
+"l1-data-stores-misses\000legacy cache\000Level 1 data cache write misses\=
000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D26648 */
+"l1-data-stores-miss\000legacy cache\000Level 1 data cache write misses\00=
0legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D26749 */
+"l1-data-write\000legacy cache\000Level 1 data cache write accesses\000leg=
acy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D26844 */
+"l1-data-write-refs\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D26944 */
+"l1-data-write-reference\000legacy cache\000Level 1 data cache write acces=
ses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D27049 */
+"l1-data-write-ops\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D27148 */
+"l1-data-write-access\000legacy cache\000Level 1 data cache write accesses=
\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D27250 */
+"l1-data-write-misses\000legacy cache\000Level 1 data cache write misses\0=
00legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D27352 */
+"l1-data-write-miss\000legacy cache\000Level 1 data cache write misses\000=
legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D27452 */
+"l1-data-prefetch\000legacy cache\000Level 1 data cache prefetch accesses\=
000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D27553 */
+"l1-data-prefetch-refs\000legacy cache\000Level 1 data cache prefetch acce=
sses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D27659 */
+"l1-data-prefetch-reference\000legacy cache\000Level 1 data cache prefetch=
 accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D27770 */
+"l1-data-prefetch-ops\000legacy cache\000Level 1 data cache prefetch acces=
ses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D27875 */
+"l1-data-prefetch-access\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D27983 */
+"l1-data-prefetch-misses\000legacy cache\000Level 1 data cache prefetch mi=
sses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D28091 */
+"l1-data-prefetch-miss\000legacy cache\000Level 1 data cache prefetch miss=
es\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D28197 */
+"l1-data-prefetches\000legacy cache\000Level 1 data cache prefetch accesse=
s\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D28300 */
+"l1-data-prefetches-refs\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D28408 */
+"l1-data-prefetches-reference\000legacy cache\000Level 1 data cache prefet=
ch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D28521 */
+"l1-data-prefetches-ops\000legacy cache\000Level 1 data cache prefetch acc=
esses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D28628 */
+"l1-data-prefetches-access\000legacy cache\000Level 1 data cache prefetch =
accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D28738 */
+"l1-data-prefetches-misses\000legacy cache\000Level 1 data cache prefetch =
misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D28848 */
+"l1-data-prefetches-miss\000legacy cache\000Level 1 data cache prefetch mi=
sses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D28956 */
+"l1-data-speculative-read\000legacy cache\000Level 1 data cache prefetch a=
ccesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D29065 */
+"l1-data-speculative-read-refs\000legacy cache\000Level 1 data cache prefe=
tch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D29179 */
+"l1-data-speculative-read-reference\000legacy cache\000Level 1 data cache =
prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\=
000"
+/* offset=3D29298 */
+"l1-data-speculative-read-ops\000legacy cache\000Level 1 data cache prefet=
ch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D29411 */
+"l1-data-speculative-read-access\000legacy cache\000Level 1 data cache pre=
fetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000=
"
+/* offset=3D29527 */
+"l1-data-speculative-read-misses\000legacy cache\000Level 1 data cache pre=
fetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000=
"
+/* offset=3D29643 */
+"l1-data-speculative-read-miss\000legacy cache\000Level 1 data cache prefe=
tch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D29757 */
+"l1-data-speculative-load\000legacy cache\000Level 1 data cache prefetch a=
ccesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D29866 */
+"l1-data-speculative-load-refs\000legacy cache\000Level 1 data cache prefe=
tch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D29980 */
+"l1-data-speculative-load-reference\000legacy cache\000Level 1 data cache =
prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\=
000"
+/* offset=3D30099 */
+"l1-data-speculative-load-ops\000legacy cache\000Level 1 data cache prefet=
ch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D30212 */
+"l1-data-speculative-load-access\000legacy cache\000Level 1 data cache pre=
fetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000=
"
+/* offset=3D30328 */
+"l1-data-speculative-load-misses\000legacy cache\000Level 1 data cache pre=
fetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000=
"
+/* offset=3D30444 */
+"l1-data-speculative-load-miss\000legacy cache\000Level 1 data cache prefe=
tch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D30558 */
+"l1-data-refs\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D30647 */
+"l1-data-reference\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D30741 */
+"l1-data-ops\000legacy cache\000Level 1 data cache read accesses\000legacy=
-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D30829 */
+"l1-data-access\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D30920 */
+"l1-data-misses\000legacy cache\000Level 1 data cache read misses\000legac=
y-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D31015 */
+"l1-data-miss\000legacy cache\000Level 1 data cache read misses\000legacy-=
cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D31108 */
+"l1-icache\000legacy cache\000Level 1 instruction cache read accesses\000l=
egacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D31201 */
+"l1-icache-load\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D31299 */
+"l1-icache-load-refs\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D31402 */
+"l1-icache-load-reference\000legacy cache\000Level 1 instruction cache rea=
d accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D31510 */
+"l1-icache-load-ops\000legacy cache\000Level 1 instruction cache read acce=
sses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D31612 */
+"l1-icache-load-access\000legacy cache\000Level 1 instruction cache read a=
ccesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D31717 */
+"l1-icache-load-misses\000legacy cache\000Level 1 instruction cache read m=
isses\000legacy-cache-config=3D0x10001\000\00000\000\000\000\000\000"
+/* offset=3D31826 */
+"l1-icache-load-miss\000legacy cache\000Level 1 instruction cache read mis=
ses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D31933 */
+"l1-icache-loads\000legacy cache\000Level 1 instruction cache read accesse=
s\000legacy-cache-config=3D1\000\00000\000\000\000\000\000"
+/* offset=3D32032 */
+"l1-icache-loads-refs\000legacy cache\000Level 1 instruction cache read ac=
cesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D32136 */
+"l1-icache-loads-reference\000legacy cache\000Level 1 instruction cache re=
ad accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D32245 */
+"l1-icache-loads-ops\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D32348 */
+"l1-icache-loads-access\000legacy cache\000Level 1 instruction cache read =
accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D32454 */
+"l1-icache-loads-misses\000legacy cache\000Level 1 instruction cache read =
misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D32564 */
+"l1-icache-loads-miss\000legacy cache\000Level 1 instruction cache read mi=
sses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D32672 */
+"l1-icache-read\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D32770 */
+"l1-icache-read-refs\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D32873 */
+"l1-icache-read-reference\000legacy cache\000Level 1 instruction cache rea=
d accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D32981 */
+"l1-icache-read-ops\000legacy cache\000Level 1 instruction cache read acce=
sses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D33083 */
+"l1-icache-read-access\000legacy cache\000Level 1 instruction cache read a=
ccesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D33188 */
+"l1-icache-read-misses\000legacy cache\000Level 1 instruction cache read m=
isses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D33297 */
+"l1-icache-read-miss\000legacy cache\000Level 1 instruction cache read mis=
ses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D33404 */
+"l1-icache-prefetch\000legacy cache\000Level 1 instruction cache prefetch =
accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D33514 */
+"l1-icache-prefetch-refs\000legacy cache\000Level 1 instruction cache pref=
etch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D33629 */
+"l1-icache-prefetch-reference\000legacy cache\000Level 1 instruction cache=
 prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000=
\000"
+/* offset=3D33749 */
+"l1-icache-prefetch-ops\000legacy cache\000Level 1 instruction cache prefe=
tch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D33863 */
+"l1-icache-prefetch-access\000legacy cache\000Level 1 instruction cache pr=
efetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\00=
0"
+/* offset=3D33980 */
+"l1-icache-prefetch-misses\000legacy cache\000Level 1 instruction cache pr=
efetch misses\000legacy-cache-config=3D0x10201\000\00000\000\000\000\000\00=
0"
+/* offset=3D34097 */
+"l1-icache-prefetch-miss\000legacy cache\000Level 1 instruction cache pref=
etch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
+/* offset=3D34212 */
+"l1-icache-prefetches\000legacy cache\000Level 1 instruction cache prefetc=
h accesses\000legacy-cache-config=3D0x201\000\00000\000\000\000\000\000"
+/* offset=3D34324 */
+"l1-icache-prefetches-refs\000legacy cache\000Level 1 instruction cache pr=
efetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\00=
0"
+/* offset=3D34441 */
+"l1-icache-prefetches-reference\000legacy cache\000Level 1 instruction cac=
he prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\0=
00\000"
+/* offset=3D34563 */
+"l1-icache-prefetches-ops\000legacy cache\000Level 1 instruction cache pre=
fetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000=
"
+/* offset=3D34679 */
+"l1-icache-prefetches-access\000legacy cache\000Level 1 instruction cache =
prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\=
000"
+/* offset=3D34798 */
+"l1-icache-prefetches-misses\000legacy cache\000Level 1 instruction cache =
prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\=
000"
+/* offset=3D34917 */
+"l1-icache-prefetches-miss\000legacy cache\000Level 1 instruction cache pr=
efetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\00=
0"
+/* offset=3D35034 */
+"l1-icache-speculative-read\000legacy cache\000Level 1 instruction cache p=
refetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\0=
00"
+/* offset=3D35152 */
+"l1-icache-speculative-read-refs\000legacy cache\000Level 1 instruction ca=
che prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\=
000\000"
+/* offset=3D35275 */
+"l1-icache-speculative-read-reference\000legacy cache\000Level 1 instructi=
on cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000=
\000\000\000"
+/* offset=3D35403 */
+"l1-icache-speculative-read-ops\000legacy cache\000Level 1 instruction cac=
he prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\0=
00\000"
+/* offset=3D35525 */
+"l1-icache-speculative-read-access\000legacy cache\000Level 1 instruction =
cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\00=
0\000\000"
+/* offset=3D35650 */
+"l1-icache-speculative-read-misses\000legacy cache\000Level 1 instruction =
cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\00=
0\000\000"
+/* offset=3D35775 */
+"l1-icache-speculative-read-miss\000legacy cache\000Level 1 instruction ca=
che prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\=
000\000"
+/* offset=3D35898 */
+"l1-icache-speculative-load\000legacy cache\000Level 1 instruction cache p=
refetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\0=
00"
+/* offset=3D36016 */
+"l1-icache-speculative-load-refs\000legacy cache\000Level 1 instruction ca=
che prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\=
000\000"
+/* offset=3D36139 */
+"l1-icache-speculative-load-reference\000legacy cache\000Level 1 instructi=
on cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000=
\000\000\000"
+/* offset=3D36267 */
+"l1-icache-speculative-load-ops\000legacy cache\000Level 1 instruction cac=
he prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\0=
00\000"
+/* offset=3D36389 */
+"l1-icache-speculative-load-access\000legacy cache\000Level 1 instruction =
cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\00=
0\000\000"
+/* offset=3D36514 */
+"l1-icache-speculative-load-misses\000legacy cache\000Level 1 instruction =
cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\00=
0\000\000"
+/* offset=3D36639 */
+"l1-icache-speculative-load-miss\000legacy cache\000Level 1 instruction ca=
che prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\=
000\000"
+/* offset=3D36762 */
+"l1-icache-refs\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D36860 */
+"l1-icache-reference\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D36963 */
+"l1-icache-ops\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D37060 */
+"l1-icache-access\000legacy cache\000Level 1 instruction cache read access=
es\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D37160 */
+"l1-icache-misses\000legacy cache\000Level 1 instruction cache read misses=
\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D37264 */
+"l1-icache-miss\000legacy cache\000Level 1 instruction cache read misses\0=
00legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D37366 */
+"l1-i\000legacy cache\000Level 1 instruction cache read accesses\000legacy=
-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D37454 */
+"l1-i-load\000legacy cache\000Level 1 instruction cache read accesses\000l=
egacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D37547 */
+"l1-i-load-refs\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D37645 */
+"l1-i-load-reference\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D37748 */
+"l1-i-load-ops\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D37845 */
+"l1-i-load-access\000legacy cache\000Level 1 instruction cache read access=
es\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D37945 */
+"l1-i-load-misses\000legacy cache\000Level 1 instruction cache read misses=
\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D38049 */
+"l1-i-load-miss\000legacy cache\000Level 1 instruction cache read misses\0=
00legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D38151 */
+"l1-i-loads\000legacy cache\000Level 1 instruction cache read accesses\000=
legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D38245 */
+"l1-i-loads-refs\000legacy cache\000Level 1 instruction cache read accesse=
s\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D38344 */
+"l1-i-loads-reference\000legacy cache\000Level 1 instruction cache read ac=
cesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D38448 */
+"l1-i-loads-ops\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D38546 */
+"l1-i-loads-access\000legacy cache\000Level 1 instruction cache read acces=
ses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D38647 */
+"l1-i-loads-misses\000legacy cache\000Level 1 instruction cache read misse=
s\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D38752 */
+"l1-i-loads-miss\000legacy cache\000Level 1 instruction cache read misses\=
000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D38855 */
+"l1-i-read\000legacy cache\000Level 1 instruction cache read accesses\000l=
egacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D38948 */
+"l1-i-read-refs\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D39046 */
+"l1-i-read-reference\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D39149 */
+"l1-i-read-ops\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D39246 */
+"l1-i-read-access\000legacy cache\000Level 1 instruction cache read access=
es\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D39346 */
+"l1-i-read-misses\000legacy cache\000Level 1 instruction cache read misses=
\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D39450 */
+"l1-i-read-miss\000legacy cache\000Level 1 instruction cache read misses\0=
00legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D39552 */
+"l1-i-prefetch\000legacy cache\000Level 1 instruction cache prefetch acces=
ses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D39657 */
+"l1-i-prefetch-refs\000legacy cache\000Level 1 instruction cache prefetch =
accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D39767 */
+"l1-i-prefetch-reference\000legacy cache\000Level 1 instruction cache pref=
etch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D39882 */
+"l1-i-prefetch-ops\000legacy cache\000Level 1 instruction cache prefetch a=
ccesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D39991 */
+"l1-i-prefetch-access\000legacy cache\000Level 1 instruction cache prefetc=
h accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D40103 */
+"l1-i-prefetch-misses\000legacy cache\000Level 1 instruction cache prefetc=
h misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
+/* offset=3D40215 */
+"l1-i-prefetch-miss\000legacy cache\000Level 1 instruction cache prefetch =
misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
+/* offset=3D40325 */
+"l1-i-prefetches\000legacy cache\000Level 1 instruction cache prefetch acc=
esses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D40432 */
+"l1-i-prefetches-refs\000legacy cache\000Level 1 instruction cache prefetc=
h accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D40544 */
+"l1-i-prefetches-reference\000legacy cache\000Level 1 instruction cache pr=
efetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\00=
0"
+/* offset=3D40661 */
+"l1-i-prefetches-ops\000legacy cache\000Level 1 instruction cache prefetch=
 accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D40772 */
+"l1-i-prefetches-access\000legacy cache\000Level 1 instruction cache prefe=
tch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D40886 */
+"l1-i-prefetches-misses\000legacy cache\000Level 1 instruction cache prefe=
tch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
+/* offset=3D41000 */
+"l1-i-prefetches-miss\000legacy cache\000Level 1 instruction cache prefetc=
h misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
+/* offset=3D41112 */
+"l1-i-speculative-read\000legacy cache\000Level 1 instruction cache prefet=
ch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D41225 */
+"l1-i-speculative-read-refs\000legacy cache\000Level 1 instruction cache p=
refetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\0=
00"
+/* offset=3D41343 */
+"l1-i-speculative-read-reference\000legacy cache\000Level 1 instruction ca=
che prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\=
000\000"
+/* offset=3D41466 */
+"l1-i-speculative-read-ops\000legacy cache\000Level 1 instruction cache pr=
efetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\00=
0"
+/* offset=3D41583 */
+"l1-i-speculative-read-access\000legacy cache\000Level 1 instruction cache=
 prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000=
\000"
+/* offset=3D41703 */
+"l1-i-speculative-read-misses\000legacy cache\000Level 1 instruction cache=
 prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000=
\000"
+/* offset=3D41823 */
+"l1-i-speculative-read-miss\000legacy cache\000Level 1 instruction cache p=
refetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\0=
00"
+/* offset=3D41941 */
+"l1-i-speculative-load\000legacy cache\000Level 1 instruction cache prefet=
ch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D42054 */
+"l1-i-speculative-load-refs\000legacy cache\000Level 1 instruction cache p=
refetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\0=
00"
+/* offset=3D42172 */
+"l1-i-speculative-load-reference\000legacy cache\000Level 1 instruction ca=
che prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\=
000\000"
+/* offset=3D42295 */
+"l1-i-speculative-load-ops\000legacy cache\000Level 1 instruction cache pr=
efetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\00=
0"
+/* offset=3D42412 */
+"l1-i-speculative-load-access\000legacy cache\000Level 1 instruction cache=
 prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000=
\000"
+/* offset=3D42532 */
+"l1-i-speculative-load-misses\000legacy cache\000Level 1 instruction cache=
 prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000=
\000"
+/* offset=3D42652 */
+"l1-i-speculative-load-miss\000legacy cache\000Level 1 instruction cache p=
refetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\0=
00"
+/* offset=3D42770 */
+"l1-i-refs\000legacy cache\000Level 1 instruction cache read accesses\000l=
egacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D42863 */
+"l1-i-reference\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D42961 */
+"l1-i-ops\000legacy cache\000Level 1 instruction cache read accesses\000le=
gacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D43053 */
+"l1-i-access\000legacy cache\000Level 1 instruction cache read accesses\00=
0legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D43148 */
+"l1-i-misses\000legacy cache\000Level 1 instruction cache read misses\000l=
egacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D43247 */
+"l1-i-miss\000legacy cache\000Level 1 instruction cache read misses\000leg=
acy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D43344 */
+"l1i\000legacy cache\000Level 1 instruction cache read accesses\000legacy-=
cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D43431 */
+"l1i-load\000legacy cache\000Level 1 instruction cache read accesses\000le=
gacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D43523 */
+"l1i-load-refs\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D43620 */
+"l1i-load-reference\000legacy cache\000Level 1 instruction cache read acce=
sses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D43722 */
+"l1i-load-ops\000legacy cache\000Level 1 instruction cache read accesses\0=
00legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D43818 */
+"l1i-load-access\000legacy cache\000Level 1 instruction cache read accesse=
s\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D43917 */
+"l1i-load-misses\000legacy cache\000Level 1 instruction cache read misses\=
000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D44020 */
+"l1i-load-miss\000legacy cache\000Level 1 instruction cache read misses\00=
0legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D44121 */
+"l1i-loads\000legacy cache\000Level 1 instruction cache read accesses\000l=
egacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D44214 */
+"l1i-loads-refs\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D44312 */
+"l1i-loads-reference\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D44415 */
+"l1i-loads-ops\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D44512 */
+"l1i-loads-access\000legacy cache\000Level 1 instruction cache read access=
es\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D44612 */
+"l1i-loads-misses\000legacy cache\000Level 1 instruction cache read misses=
\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D44716 */
+"l1i-loads-miss\000legacy cache\000Level 1 instruction cache read misses\0=
00legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D44818 */
+"l1i-read\000legacy cache\000Level 1 instruction cache read accesses\000le=
gacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D44910 */
+"l1i-read-refs\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D45007 */
+"l1i-read-reference\000legacy cache\000Level 1 instruction cache read acce=
sses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D45109 */
+"l1i-read-ops\000legacy cache\000Level 1 instruction cache read accesses\0=
00legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D45205 */
+"l1i-read-access\000legacy cache\000Level 1 instruction cache read accesse=
s\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D45304 */
+"l1i-read-misses\000legacy cache\000Level 1 instruction cache read misses\=
000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D45407 */
+"l1i-read-miss\000legacy cache\000Level 1 instruction cache read misses\00=
0legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D45508 */
+"l1i-prefetch\000legacy cache\000Level 1 instruction cache prefetch access=
es\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D45612 */
+"l1i-prefetch-refs\000legacy cache\000Level 1 instruction cache prefetch a=
ccesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D45721 */
+"l1i-prefetch-reference\000legacy cache\000Level 1 instruction cache prefe=
tch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D45835 */
+"l1i-prefetch-ops\000legacy cache\000Level 1 instruction cache prefetch ac=
cesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D45943 */
+"l1i-prefetch-access\000legacy cache\000Level 1 instruction cache prefetch=
 accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D46054 */
+"l1i-prefetch-misses\000legacy cache\000Level 1 instruction cache prefetch=
 misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
+/* offset=3D46165 */
+"l1i-prefetch-miss\000legacy cache\000Level 1 instruction cache prefetch m=
isses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
+/* offset=3D46274 */
+"l1i-prefetches\000legacy cache\000Level 1 instruction cache prefetch acce=
sses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D46380 */
+"l1i-prefetches-refs\000legacy cache\000Level 1 instruction cache prefetch=
 accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D46491 */
+"l1i-prefetches-reference\000legacy cache\000Level 1 instruction cache pre=
fetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000=
"
+/* offset=3D46607 */
+"l1i-prefetches-ops\000legacy cache\000Level 1 instruction cache prefetch =
accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D46717 */
+"l1i-prefetches-access\000legacy cache\000Level 1 instruction cache prefet=
ch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D46830 */
+"l1i-prefetches-misses\000legacy cache\000Level 1 instruction cache prefet=
ch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
+/* offset=3D46943 */
+"l1i-prefetches-miss\000legacy cache\000Level 1 instruction cache prefetch=
 misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
+/* offset=3D47054 */
+"l1i-speculative-read\000legacy cache\000Level 1 instruction cache prefetc=
h accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D47166 */
+"l1i-speculative-read-refs\000legacy cache\000Level 1 instruction cache pr=
efetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\00=
0"
+/* offset=3D47283 */
+"l1i-speculative-read-reference\000legacy cache\000Level 1 instruction cac=
he prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\0=
00\000"
+/* offset=3D47405 */
+"l1i-speculative-read-ops\000legacy cache\000Level 1 instruction cache pre=
fetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000=
"
+/* offset=3D47521 */
+"l1i-speculative-read-access\000legacy cache\000Level 1 instruction cache =
prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\=
000"
+/* offset=3D47640 */
+"l1i-speculative-read-misses\000legacy cache\000Level 1 instruction cache =
prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\=
000"
+/* offset=3D47759 */
+"l1i-speculative-read-miss\000legacy cache\000Level 1 instruction cache pr=
efetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\00=
0"
+/* offset=3D47876 */
+"l1i-speculative-load\000legacy cache\000Level 1 instruction cache prefetc=
h accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D47988 */
+"l1i-speculative-load-refs\000legacy cache\000Level 1 instruction cache pr=
efetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\00=
0"
+/* offset=3D48105 */
+"l1i-speculative-load-reference\000legacy cache\000Level 1 instruction cac=
he prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\0=
00\000"
+/* offset=3D48227 */
+"l1i-speculative-load-ops\000legacy cache\000Level 1 instruction cache pre=
fetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000=
"
+/* offset=3D48343 */
+"l1i-speculative-load-access\000legacy cache\000Level 1 instruction cache =
prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\=
000"
+/* offset=3D48462 */
+"l1i-speculative-load-misses\000legacy cache\000Level 1 instruction cache =
prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\=
000"
+/* offset=3D48581 */
+"l1i-speculative-load-miss\000legacy cache\000Level 1 instruction cache pr=
efetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\00=
0"
+/* offset=3D48698 */
+"l1i-refs\000legacy cache\000Level 1 instruction cache read accesses\000le=
gacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D48790 */
+"l1i-reference\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D48887 */
+"l1i-ops\000legacy cache\000Level 1 instruction cache read accesses\000leg=
acy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D48978 */
+"l1i-access\000legacy cache\000Level 1 instruction cache read accesses\000=
legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D49072 */
+"l1i-misses\000legacy cache\000Level 1 instruction cache read misses\000le=
gacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D49170 */
+"l1i-miss\000legacy cache\000Level 1 instruction cache read misses\000lega=
cy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D49266 */
+"l1-instruction\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D49364 */
+"l1-instruction-load\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D49467 */
+"l1-instruction-load-refs\000legacy cache\000Level 1 instruction cache rea=
d accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D49575 */
+"l1-instruction-load-reference\000legacy cache\000Level 1 instruction cach=
e read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D49688 */
+"l1-instruction-load-ops\000legacy cache\000Level 1 instruction cache read=
 accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D49795 */
+"l1-instruction-load-access\000legacy cache\000Level 1 instruction cache r=
ead accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D49905 */
+"l1-instruction-load-misses\000legacy cache\000Level 1 instruction cache r=
ead misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D50019 */
+"l1-instruction-load-miss\000legacy cache\000Level 1 instruction cache rea=
d misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D50131 */
+"l1-instruction-loads\000legacy cache\000Level 1 instruction cache read ac=
cesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D50235 */
+"l1-instruction-loads-refs\000legacy cache\000Level 1 instruction cache re=
ad accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D50344 */
+"l1-instruction-loads-reference\000legacy cache\000Level 1 instruction cac=
he read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D50458 */
+"l1-instruction-loads-ops\000legacy cache\000Level 1 instruction cache rea=
d accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D50566 */
+"l1-instruction-loads-access\000legacy cache\000Level 1 instruction cache =
read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D50677 */
+"l1-instruction-loads-misses\000legacy cache\000Level 1 instruction cache =
read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D50792 */
+"l1-instruction-loads-miss\000legacy cache\000Level 1 instruction cache re=
ad misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D50905 */
+"l1-instruction-read\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D51008 */
+"l1-instruction-read-refs\000legacy cache\000Level 1 instruction cache rea=
d accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D51116 */
+"l1-instruction-read-reference\000legacy cache\000Level 1 instruction cach=
e read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D51229 */
+"l1-instruction-read-ops\000legacy cache\000Level 1 instruction cache read=
 accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D51336 */
+"l1-instruction-read-access\000legacy cache\000Level 1 instruction cache r=
ead accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D51446 */
+"l1-instruction-read-misses\000legacy cache\000Level 1 instruction cache r=
ead misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D51560 */
+"l1-instruction-read-miss\000legacy cache\000Level 1 instruction cache rea=
d misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D51672 */
+"l1-instruction-prefetch\000legacy cache\000Level 1 instruction cache pref=
etch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D51787 */
+"l1-instruction-prefetch-refs\000legacy cache\000Level 1 instruction cache=
 prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000=
\000"
+/* offset=3D51907 */
+"l1-instruction-prefetch-reference\000legacy cache\000Level 1 instruction =
cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\00=
0\000\000"
+/* offset=3D52032 */
+"l1-instruction-prefetch-ops\000legacy cache\000Level 1 instruction cache =
prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\=
000"
+/* offset=3D52151 */
+"l1-instruction-prefetch-access\000legacy cache\000Level 1 instruction cac=
he prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\0=
00\000"
+/* offset=3D52273 */
+"l1-instruction-prefetch-misses\000legacy cache\000Level 1 instruction cac=
he prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\0=
00\000"
+/* offset=3D52395 */
+"l1-instruction-prefetch-miss\000legacy cache\000Level 1 instruction cache=
 prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000=
\000"
+/* offset=3D52515 */
+"l1-instruction-prefetches\000legacy cache\000Level 1 instruction cache pr=
efetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\00=
0"
+/* offset=3D52632 */
+"l1-instruction-prefetches-refs\000legacy cache\000Level 1 instruction cac=
he prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\0=
00\000"
+/* offset=3D52754 */
+"l1-instruction-prefetches-reference\000legacy cache\000Level 1 instructio=
n cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\=
000\000\000"
+/* offset=3D52881 */
+"l1-instruction-prefetches-ops\000legacy cache\000Level 1 instruction cach=
e prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\00=
0\000"
+/* offset=3D53002 */
+"l1-instruction-prefetches-access\000legacy cache\000Level 1 instruction c=
ache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000=
\000\000"
+/* offset=3D53126 */
+"l1-instruction-prefetches-misses\000legacy cache\000Level 1 instruction c=
ache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000=
\000\000"
+/* offset=3D53250 */
+"l1-instruction-prefetches-miss\000legacy cache\000Level 1 instruction cac=
he prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\0=
00\000"
+/* offset=3D53372 */
+"l1-instruction-speculative-read\000legacy cache\000Level 1 instruction ca=
che prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\=
000\000"
+/* offset=3D53495 */
+"l1-instruction-speculative-read-refs\000legacy cache\000Level 1 instructi=
on cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000=
\000\000\000"
+/* offset=3D53623 */
+"l1-instruction-speculative-read-reference\000legacy cache\000Level 1 inst=
ruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\00=
0\000\000\000\000"
+/* offset=3D53756 */
+"l1-instruction-speculative-read-ops\000legacy cache\000Level 1 instructio=
n cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\=
000\000\000"
+/* offset=3D53883 */
+"l1-instruction-speculative-read-access\000legacy cache\000Level 1 instruc=
tion cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\0=
00\000\000\000"
+/* offset=3D54013 */
+"l1-instruction-speculative-read-misses\000legacy cache\000Level 1 instruc=
tion cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\0=
00\000\000\000"
+/* offset=3D54143 */
+"l1-instruction-speculative-read-miss\000legacy cache\000Level 1 instructi=
on cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000=
\000\000\000"
+/* offset=3D54271 */
+"l1-instruction-speculative-load\000legacy cache\000Level 1 instruction ca=
che prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\=
000\000"
+/* offset=3D54394 */
+"l1-instruction-speculative-load-refs\000legacy cache\000Level 1 instructi=
on cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000=
\000\000\000"
+/* offset=3D54522 */
+"l1-instruction-speculative-load-reference\000legacy cache\000Level 1 inst=
ruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\00=
0\000\000\000\000"
+/* offset=3D54655 */
+"l1-instruction-speculative-load-ops\000legacy cache\000Level 1 instructio=
n cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\=
000\000\000"
+/* offset=3D54782 */
+"l1-instruction-speculative-load-access\000legacy cache\000Level 1 instruc=
tion cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\0=
00\000\000\000"
+/* offset=3D54912 */
+"l1-instruction-speculative-load-misses\000legacy cache\000Level 1 instruc=
tion cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\0=
00\000\000\000"
+/* offset=3D55042 */
+"l1-instruction-speculative-load-miss\000legacy cache\000Level 1 instructi=
on cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000=
\000\000\000"
+/* offset=3D55170 */
+"l1-instruction-refs\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D55273 */
+"l1-instruction-reference\000legacy cache\000Level 1 instruction cache rea=
d accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D55381 */
+"l1-instruction-ops\000legacy cache\000Level 1 instruction cache read acce=
sses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D55483 */
+"l1-instruction-access\000legacy cache\000Level 1 instruction cache read a=
ccesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D55588 */
+"l1-instruction-misses\000legacy cache\000Level 1 instruction cache read m=
isses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D55697 */
+"l1-instruction-miss\000legacy cache\000Level 1 instruction cache read mis=
ses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D55804 */
+"llc\000legacy cache\000Last level cache read accesses\000legacy-cache-con=
fig=3D2\000\00010\000\000\000\000\000"
+/* offset=3D55882 */
+"llc-load\000legacy cache\000Last level cache read accesses\000legacy-cach=
e-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D55965 */
+"llc-load-refs\000legacy cache\000Last level cache read accesses\000legacy=
-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D56053 */
+"llc-load-reference\000legacy cache\000Last level cache read accesses\000l=
egacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D56146 */
+"llc-load-ops\000legacy cache\000Last level cache read accesses\000legacy-=
cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D56233 */
+"llc-load-access\000legacy cache\000Last level cache read accesses\000lega=
cy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D56323 */
+"llc-load-misses\000legacy cache\000Last level cache read misses\000legacy=
-cache-config=3D0x10002\000\00000\000\000\000\000\000"
+/* offset=3D56417 */
+"llc-load-miss\000legacy cache\000Last level cache read misses\000legacy-c=
ache-config=3D0x10002\000\00010\000\000\000\000\000"
+/* offset=3D56509 */
+"llc-loads\000legacy cache\000Last level cache read accesses\000legacy-cac=
he-config=3D2\000\00000\000\000\000\000\000"
+/* offset=3D56593 */
+"llc-loads-refs\000legacy cache\000Last level cache read accesses\000legac=
y-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D56682 */
+"llc-loads-reference\000legacy cache\000Last level cache read accesses\000=
legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D56776 */
+"llc-loads-ops\000legacy cache\000Last level cache read accesses\000legacy=
-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D56864 */
+"llc-loads-access\000legacy cache\000Last level cache read accesses\000leg=
acy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D56955 */
+"llc-loads-misses\000legacy cache\000Last level cache read misses\000legac=
y-cache-config=3D0x10002\000\00010\000\000\000\000\000"
+/* offset=3D57050 */
+"llc-loads-miss\000legacy cache\000Last level cache read misses\000legacy-=
cache-config=3D0x10002\000\00010\000\000\000\000\000"
+/* offset=3D57143 */
+"llc-read\000legacy cache\000Last level cache read accesses\000legacy-cach=
e-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D57226 */
+"llc-read-refs\000legacy cache\000Last level cache read accesses\000legacy=
-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D57314 */
+"llc-read-reference\000legacy cache\000Last level cache read accesses\000l=
egacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D57407 */
+"llc-read-ops\000legacy cache\000Last level cache read accesses\000legacy-=
cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D57494 */
+"llc-read-access\000legacy cache\000Last level cache read accesses\000lega=
cy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D57584 */
+"llc-read-misses\000legacy cache\000Last level cache read misses\000legacy=
-cache-config=3D0x10002\000\00010\000\000\000\000\000"
+/* offset=3D57678 */
+"llc-read-miss\000legacy cache\000Last level cache read misses\000legacy-c=
ache-config=3D0x10002\000\00010\000\000\000\000\000"
+/* offset=3D57770 */
+"llc-store\000legacy cache\000Last level cache write accesses\000legacy-ca=
che-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D57859 */
+"llc-store-refs\000legacy cache\000Last level cache write accesses\000lega=
cy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D57953 */
+"llc-store-reference\000legacy cache\000Last level cache write accesses\00=
0legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D58052 */
+"llc-store-ops\000legacy cache\000Last level cache write accesses\000legac=
y-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D58145 */
+"llc-store-access\000legacy cache\000Last level cache write accesses\000le=
gacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D58241 */
+"llc-store-misses\000legacy cache\000Last level cache write misses\000lega=
cy-cache-config=3D0x10102\000\00000\000\000\000\000\000"
+/* offset=3D58337 */
+"llc-store-miss\000legacy cache\000Last level cache write misses\000legacy=
-cache-config=3D0x10102\000\00010\000\000\000\000\000"
+/* offset=3D58431 */
+"llc-stores\000legacy cache\000Last level cache write accesses\000legacy-c=
ache-config=3D0x102\000\00000\000\000\000\000\000"
+/* offset=3D58521 */
+"llc-stores-refs\000legacy cache\000Last level cache write accesses\000leg=
acy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D58616 */
+"llc-stores-reference\000legacy cache\000Last level cache write accesses\0=
00legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D58716 */
+"llc-stores-ops\000legacy cache\000Last level cache write accesses\000lega=
cy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D58810 */
+"llc-stores-access\000legacy cache\000Last level cache write accesses\000l=
egacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D58907 */
+"llc-stores-misses\000legacy cache\000Last level cache write misses\000leg=
acy-cache-config=3D0x10102\000\00010\000\000\000\000\000"
+/* offset=3D59004 */
+"llc-stores-miss\000legacy cache\000Last level cache write misses\000legac=
y-cache-config=3D0x10102\000\00010\000\000\000\000\000"
+/* offset=3D59099 */
+"llc-write\000legacy cache\000Last level cache write accesses\000legacy-ca=
che-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D59188 */
+"llc-write-refs\000legacy cache\000Last level cache write accesses\000lega=
cy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D59282 */
+"llc-write-reference\000legacy cache\000Last level cache write accesses\00=
0legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D59381 */
+"llc-write-ops\000legacy cache\000Last level cache write accesses\000legac=
y-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D59474 */
+"llc-write-access\000legacy cache\000Last level cache write accesses\000le=
gacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D59570 */
+"llc-write-misses\000legacy cache\000Last level cache write misses\000lega=
cy-cache-config=3D0x10102\000\00010\000\000\000\000\000"
+/* offset=3D59666 */
+"llc-write-miss\000legacy cache\000Last level cache write misses\000legacy=
-cache-config=3D0x10102\000\00010\000\000\000\000\000"
+/* offset=3D59760 */
+"llc-prefetch\000legacy cache\000Last level cache prefetch accesses\000leg=
acy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D59855 */
+"llc-prefetch-refs\000legacy cache\000Last level cache prefetch accesses\0=
00legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D59955 */
+"llc-prefetch-reference\000legacy cache\000Last level cache prefetch acces=
ses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D60060 */
+"llc-prefetch-ops\000legacy cache\000Last level cache prefetch accesses\00=
0legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D60159 */
+"llc-prefetch-access\000legacy cache\000Last level cache prefetch accesses=
\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D60261 */
+"llc-prefetch-misses\000legacy cache\000Last level cache prefetch misses\0=
00legacy-cache-config=3D0x10202\000\00000\000\000\000\000\000"
+/* offset=3D60363 */
+"llc-prefetch-miss\000legacy cache\000Last level cache prefetch misses\000=
legacy-cache-config=3D0x10202\000\00010\000\000\000\000\000"
+/* offset=3D60463 */
+"llc-prefetches\000legacy cache\000Last level cache prefetch accesses\000l=
egacy-cache-config=3D0x202\000\00000\000\000\000\000\000"
+/* offset=3D60560 */
+"llc-prefetches-refs\000legacy cache\000Last level cache prefetch accesses=
\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D60662 */
+"llc-prefetches-reference\000legacy cache\000Last level cache prefetch acc=
esses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D60769 */
+"llc-prefetches-ops\000legacy cache\000Last level cache prefetch accesses\=
000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D60870 */
+"llc-prefetches-access\000legacy cache\000Last level cache prefetch access=
es\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D60974 */
+"llc-prefetches-misses\000legacy cache\000Last level cache prefetch misses=
\000legacy-cache-config=3D0x10202\000\00010\000\000\000\000\000"
+/* offset=3D61078 */
+"llc-prefetches-miss\000legacy cache\000Last level cache prefetch misses\0=
00legacy-cache-config=3D0x10202\000\00010\000\000\000\000\000"
+/* offset=3D61180 */
+"llc-speculative-read\000legacy cache\000Last level cache prefetch accesse=
s\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D61283 */
+"llc-speculative-read-refs\000legacy cache\000Last level cache prefetch ac=
cesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D61391 */
+"llc-speculative-read-reference\000legacy cache\000Last level cache prefet=
ch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D61504 */
+"llc-speculative-read-ops\000legacy cache\000Last level cache prefetch acc=
esses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D61611 */
+"llc-speculative-read-access\000legacy cache\000Last level cache prefetch =
accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D61721 */
+"llc-speculative-read-misses\000legacy cache\000Last level cache prefetch =
misses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\000\000"
+/* offset=3D61831 */
+"llc-speculative-read-miss\000legacy cache\000Last level cache prefetch mi=
sses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\000\000"
+/* offset=3D61939 */
+"llc-speculative-load\000legacy cache\000Last level cache prefetch accesse=
s\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D62042 */
+"llc-speculative-load-refs\000legacy cache\000Last level cache prefetch ac=
cesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D62150 */
+"llc-speculative-load-reference\000legacy cache\000Last level cache prefet=
ch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D62263 */
+"llc-speculative-load-ops\000legacy cache\000Last level cache prefetch acc=
esses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D62370 */
+"llc-speculative-load-access\000legacy cache\000Last level cache prefetch =
accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D62480 */
+"llc-speculative-load-misses\000legacy cache\000Last level cache prefetch =
misses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\000\000"
+/* offset=3D62590 */
+"llc-speculative-load-miss\000legacy cache\000Last level cache prefetch mi=
sses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\000\000"
+/* offset=3D62698 */
+"llc-refs\000legacy cache\000Last level cache read accesses\000legacy-cach=
e-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D62781 */
+"llc-reference\000legacy cache\000Last level cache read accesses\000legacy=
-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D62869 */
+"llc-ops\000legacy cache\000Last level cache read accesses\000legacy-cache=
-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D62951 */
+"llc-access\000legacy cache\000Last level cache read accesses\000legacy-ca=
che-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D63036 */
+"llc-misses\000legacy cache\000Last level cache read misses\000legacy-cach=
e-config=3D0x10002\000\00010\000\000\000\000\000"
+/* offset=3D63125 */
+"llc-miss\000legacy cache\000Last level cache read misses\000legacy-cache-=
config=3D0x10002\000\00010\000\000\000\000\000"
+/* offset=3D63212 */
+"l2\000legacy cache\000Level 2 (or higher) last level cache read accesses\=
000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D63309 */
+"l2-load\000legacy cache\000Level 2 (or higher) last level cache read acce=
sses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D63411 */
+"l2-load-refs\000legacy cache\000Level 2 (or higher) last level cache read=
 accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D63518 */
+"l2-load-reference\000legacy cache\000Level 2 (or higher) last level cache=
 read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D63630 */
+"l2-load-ops\000legacy cache\000Level 2 (or higher) last level cache read =
accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D63736 */
+"l2-load-access\000legacy cache\000Level 2 (or higher) last level cache re=
ad accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D63845 */
+"l2-load-misses\000legacy cache\000Level 2 (or higher) last level cache re=
ad misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
+/* offset=3D63958 */
+"l2-load-miss\000legacy cache\000Level 2 (or higher) last level cache read=
 misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
+/* offset=3D64069 */
+"l2-loads\000legacy cache\000Level 2 (or higher) last level cache read acc=
esses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D64172 */
+"l2-loads-refs\000legacy cache\000Level 2 (or higher) last level cache rea=
d accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D64280 */
+"l2-loads-reference\000legacy cache\000Level 2 (or higher) last level cach=
e read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D64393 */
+"l2-loads-ops\000legacy cache\000Level 2 (or higher) last level cache read=
 accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D64500 */
+"l2-loads-access\000legacy cache\000Level 2 (or higher) last level cache r=
ead accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D64610 */
+"l2-loads-misses\000legacy cache\000Level 2 (or higher) last level cache r=
ead misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
+/* offset=3D64724 */
+"l2-loads-miss\000legacy cache\000Level 2 (or higher) last level cache rea=
d misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
+/* offset=3D64836 */
+"l2-read\000legacy cache\000Level 2 (or higher) last level cache read acce=
sses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D64938 */
+"l2-read-refs\000legacy cache\000Level 2 (or higher) last level cache read=
 accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D65045 */
+"l2-read-reference\000legacy cache\000Level 2 (or higher) last level cache=
 read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D65157 */
+"l2-read-ops\000legacy cache\000Level 2 (or higher) last level cache read =
accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D65263 */
+"l2-read-access\000legacy cache\000Level 2 (or higher) last level cache re=
ad accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D65372 */
+"l2-read-misses\000legacy cache\000Level 2 (or higher) last level cache re=
ad misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
+/* offset=3D65485 */
+"l2-read-miss\000legacy cache\000Level 2 (or higher) last level cache read=
 misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
+/* offset=3D65596 */
+"l2-store\000legacy cache\000Level 2 (or higher) last level cache write ac=
cesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D65704 */
+"l2-store-refs\000legacy cache\000Level 2 (or higher) last level cache wri=
te accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D65817 */
+"l2-store-reference\000legacy cache\000Level 2 (or higher) last level cach=
e write accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\0=
00"
+/* offset=3D65935 */
+"l2-store-ops\000legacy cache\000Level 2 (or higher) last level cache writ=
e accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D66047 */
+"l2-store-access\000legacy cache\000Level 2 (or higher) last level cache w=
rite accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D66162 */
+"l2-store-misses\000legacy cache\000Level 2 (or higher) last level cache w=
rite misses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\000"
+/* offset=3D66277 */
+"l2-store-miss\000legacy cache\000Level 2 (or higher) last level cache wri=
te misses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\000"
+/* offset=3D66390 */
+"l2-stores\000legacy cache\000Level 2 (or higher) last level cache write a=
ccesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D66499 */
+"l2-stores-refs\000legacy cache\000Level 2 (or higher) last level cache wr=
ite accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D66613 */
+"l2-stores-reference\000legacy cache\000Level 2 (or higher) last level cac=
he write accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\=
000"
+/* offset=3D66732 */
+"l2-stores-ops\000legacy cache\000Level 2 (or higher) last level cache wri=
te accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D66845 */
+"l2-stores-access\000legacy cache\000Level 2 (or higher) last level cache =
write accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000=
"
+/* offset=3D66961 */
+"l2-stores-misses\000legacy cache\000Level 2 (or higher) last level cache =
write misses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\000=
"
+/* offset=3D67077 */
+"l2-stores-miss\000legacy cache\000Level 2 (or higher) last level cache wr=
ite misses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\000"
+/* offset=3D67191 */
+"l2-write\000legacy cache\000Level 2 (or higher) last level cache write ac=
cesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D67299 */
+"l2-write-refs\000legacy cache\000Level 2 (or higher) last level cache wri=
te accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D67412 */
+"l2-write-reference\000legacy cache\000Level 2 (or higher) last level cach=
e write accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\0=
00"
+/* offset=3D67530 */
+"l2-write-ops\000legacy cache\000Level 2 (or higher) last level cache writ=
e accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D67642 */
+"l2-write-access\000legacy cache\000Level 2 (or higher) last level cache w=
rite accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D67757 */
+"l2-write-misses\000legacy cache\000Level 2 (or higher) last level cache w=
rite misses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\000"
+/* offset=3D67872 */
+"l2-write-miss\000legacy cache\000Level 2 (or higher) last level cache wri=
te misses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\000"
+/* offset=3D67985 */
+"l2-prefetch\000legacy cache\000Level 2 (or higher) last level cache prefe=
tch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D68099 */
+"l2-prefetch-refs\000legacy cache\000Level 2 (or higher) last level cache =
prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\=
000"
+/* offset=3D68218 */
+"l2-prefetch-reference\000legacy cache\000Level 2 (or higher) last level c=
ache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000=
\000\000"
+/* offset=3D68342 */
+"l2-prefetch-ops\000legacy cache\000Level 2 (or higher) last level cache p=
refetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\0=
00"
+/* offset=3D68460 */
+"l2-prefetch-access\000legacy cache\000Level 2 (or higher) last level cach=
e prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\00=
0\000"
+/* offset=3D68581 */
+"l2-prefetch-misses\000legacy cache\000Level 2 (or higher) last level cach=
e prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\00=
0\000"
+/* offset=3D68702 */
+"l2-prefetch-miss\000legacy cache\000Level 2 (or higher) last level cache =
prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\000\=
000"
+/* offset=3D68821 */
+"l2-prefetches\000legacy cache\000Level 2 (or higher) last level cache pre=
fetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000=
"
+/* offset=3D68937 */
+"l2-prefetches-refs\000legacy cache\000Level 2 (or higher) last level cach=
e prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\00=
0\000"
+/* offset=3D69058 */
+"l2-prefetches-reference\000legacy cache\000Level 2 (or higher) last level=
 cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\0=
00\000\000"
+/* offset=3D69184 */
+"l2-prefetches-ops\000legacy cache\000Level 2 (or higher) last level cache=
 prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000=
\000"
+/* offset=3D69304 */
+"l2-prefetches-access\000legacy cache\000Level 2 (or higher) last level ca=
che prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\=
000\000"
+/* offset=3D69427 */
+"l2-prefetches-misses\000legacy cache\000Level 2 (or higher) last level ca=
che prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\=
000\000"
+/* offset=3D69550 */
+"l2-prefetches-miss\000legacy cache\000Level 2 (or higher) last level cach=
e prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\00=
0\000"
+/* offset=3D69671 */
+"l2-speculative-read\000legacy cache\000Level 2 (or higher) last level cac=
he prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\0=
00\000"
+/* offset=3D69793 */
+"l2-speculative-read-refs\000legacy cache\000Level 2 (or higher) last leve=
l cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\=
000\000\000"
+/* offset=3D69920 */
+"l2-speculative-read-reference\000legacy cache\000Level 2 (or higher) last=
 level cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000=
\000\000\000\000"
+/* offset=3D70052 */
+"l2-speculative-read-ops\000legacy cache\000Level 2 (or higher) last level=
 cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\0=
00\000\000"
+/* offset=3D70178 */
+"l2-speculative-read-access\000legacy cache\000Level 2 (or higher) last le=
vel cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\00=
0\000\000\000"
+/* offset=3D70307 */
+"l2-speculative-read-misses\000legacy cache\000Level 2 (or higher) last le=
vel cache prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\00=
0\000\000\000"
+/* offset=3D70436 */
+"l2-speculative-read-miss\000legacy cache\000Level 2 (or higher) last leve=
l cache prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\=
000\000\000"
+/* offset=3D70563 */
+"l2-speculative-load\000legacy cache\000Level 2 (or higher) last level cac=
he prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\0=
00\000"
+/* offset=3D70685 */
+"l2-speculative-load-refs\000legacy cache\000Level 2 (or higher) last leve=
l cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\=
000\000\000"
+/* offset=3D70812 */
+"l2-speculative-load-reference\000legacy cache\000Level 2 (or higher) last=
 level cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000=
\000\000\000\000"
+/* offset=3D70944 */
+"l2-speculative-load-ops\000legacy cache\000Level 2 (or higher) last level=
 cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\0=
00\000\000"
+/* offset=3D71070 */
+"l2-speculative-load-access\000legacy cache\000Level 2 (or higher) last le=
vel cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\00=
0\000\000\000"
+/* offset=3D71199 */
+"l2-speculative-load-misses\000legacy cache\000Level 2 (or higher) last le=
vel cache prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\00=
0\000\000\000"
+/* offset=3D71328 */
+"l2-speculative-load-miss\000legacy cache\000Level 2 (or higher) last leve=
l cache prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\=
000\000\000"
+/* offset=3D71455 */
+"l2-refs\000legacy cache\000Level 2 (or higher) last level cache read acce=
sses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D71557 */
+"l2-reference\000legacy cache\000Level 2 (or higher) last level cache read=
 accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D71664 */
+"l2-ops\000legacy cache\000Level 2 (or higher) last level cache read acces=
ses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D71765 */
+"l2-access\000legacy cache\000Level 2 (or higher) last level cache read ac=
cesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D71869 */
+"l2-misses\000legacy cache\000Level 2 (or higher) last level cache read mi=
sses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
+/* offset=3D71977 */
+"l2-miss\000legacy cache\000Level 2 (or higher) last level cache read miss=
es\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
+/* offset=3D72083 */
+"dtlb\000legacy cache\000Data TLB read accesses\000legacy-cache-config=3D3=
\000\00010\000\000\000\000\000"
+/* offset=3D72154 */
+"dtlb-load\000legacy cache\000Data TLB read accesses\000legacy-cache-confi=
g=3D3\000\00010\000\000\000\000\000"
+/* offset=3D72230 */
+"dtlb-load-refs\000legacy cache\000Data TLB read accesses\000legacy-cache-=
config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D72311 */
+"dtlb-load-reference\000legacy cache\000Data TLB read accesses\000legacy-c=
ache-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D72397 */
+"dtlb-load-ops\000legacy cache\000Data TLB read accesses\000legacy-cache-c=
onfig=3D3\000\00010\000\000\000\000\000"
+/* offset=3D72477 */
+"dtlb-load-access\000legacy cache\000Data TLB read accesses\000legacy-cach=
e-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D72560 */
+"dtlb-load-misses\000legacy cache\000Data TLB read misses\000legacy-cache-=
config=3D0x10003\000\00000\000\000\000\000\000"
+/* offset=3D72647 */
+"dtlb-load-miss\000legacy cache\000Data TLB read misses\000legacy-cache-co=
nfig=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D72732 */
+"dtlb-loads\000legacy cache\000Data TLB read accesses\000legacy-cache-conf=
ig=3D3\000\00000\000\000\000\000\000"
+/* offset=3D72809 */
+"dtlb-loads-refs\000legacy cache\000Data TLB read accesses\000legacy-cache=
-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D72891 */
+"dtlb-loads-reference\000legacy cache\000Data TLB read accesses\000legacy-=
cache-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D72978 */
+"dtlb-loads-ops\000legacy cache\000Data TLB read accesses\000legacy-cache-=
config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D73059 */
+"dtlb-loads-access\000legacy cache\000Data TLB read accesses\000legacy-cac=
he-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D73143 */
+"dtlb-loads-misses\000legacy cache\000Data TLB read misses\000legacy-cache=
-config=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D73231 */
+"dtlb-loads-miss\000legacy cache\000Data TLB read misses\000legacy-cache-c=
onfig=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D73317 */
+"dtlb-read\000legacy cache\000Data TLB read accesses\000legacy-cache-confi=
g=3D3\000\00010\000\000\000\000\000"
+/* offset=3D73393 */
+"dtlb-read-refs\000legacy cache\000Data TLB read accesses\000legacy-cache-=
config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D73474 */
+"dtlb-read-reference\000legacy cache\000Data TLB read accesses\000legacy-c=
ache-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D73560 */
+"dtlb-read-ops\000legacy cache\000Data TLB read accesses\000legacy-cache-c=
onfig=3D3\000\00010\000\000\000\000\000"
+/* offset=3D73640 */
+"dtlb-read-access\000legacy cache\000Data TLB read accesses\000legacy-cach=
e-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D73723 */
+"dtlb-read-misses\000legacy cache\000Data TLB read misses\000legacy-cache-=
config=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D73810 */
+"dtlb-read-miss\000legacy cache\000Data TLB read misses\000legacy-cache-co=
nfig=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D73895 */
+"dtlb-store\000legacy cache\000Data TLB write accesses\000legacy-cache-con=
fig=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D73977 */
+"dtlb-store-refs\000legacy cache\000Data TLB write accesses\000legacy-cach=
e-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D74064 */
+"dtlb-store-reference\000legacy cache\000Data TLB write accesses\000legacy=
-cache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D74156 */
+"dtlb-store-ops\000legacy cache\000Data TLB write accesses\000legacy-cache=
-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D74242 */
+"dtlb-store-access\000legacy cache\000Data TLB write accesses\000legacy-ca=
che-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D74331 */
+"dtlb-store-misses\000legacy cache\000Data TLB write misses\000legacy-cach=
e-config=3D0x10103\000\00000\000\000\000\000\000"
+/* offset=3D74420 */
+"dtlb-store-miss\000legacy cache\000Data TLB write misses\000legacy-cache-=
config=3D0x10103\000\00010\000\000\000\000\000"
+/* offset=3D74507 */
+"dtlb-stores\000legacy cache\000Data TLB write accesses\000legacy-cache-co=
nfig=3D0x103\000\00000\000\000\000\000\000"
+/* offset=3D74590 */
+"dtlb-stores-refs\000legacy cache\000Data TLB write accesses\000legacy-cac=
he-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D74678 */
+"dtlb-stores-reference\000legacy cache\000Data TLB write accesses\000legac=
y-cache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D74771 */
+"dtlb-stores-ops\000legacy cache\000Data TLB write accesses\000legacy-cach=
e-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D74858 */
+"dtlb-stores-access\000legacy cache\000Data TLB write accesses\000legacy-c=
ache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D74948 */
+"dtlb-stores-misses\000legacy cache\000Data TLB write misses\000legacy-cac=
he-config=3D0x10103\000\00010\000\000\000\000\000"
+/* offset=3D75038 */
+"dtlb-stores-miss\000legacy cache\000Data TLB write misses\000legacy-cache=
-config=3D0x10103\000\00010\000\000\000\000\000"
+/* offset=3D75126 */
+"dtlb-write\000legacy cache\000Data TLB write accesses\000legacy-cache-con=
fig=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D75208 */
+"dtlb-write-refs\000legacy cache\000Data TLB write accesses\000legacy-cach=
e-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D75295 */
+"dtlb-write-reference\000legacy cache\000Data TLB write accesses\000legacy=
-cache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D75387 */
+"dtlb-write-ops\000legacy cache\000Data TLB write accesses\000legacy-cache=
-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D75473 */
+"dtlb-write-access\000legacy cache\000Data TLB write accesses\000legacy-ca=
che-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D75562 */
+"dtlb-write-misses\000legacy cache\000Data TLB write misses\000legacy-cach=
e-config=3D0x10103\000\00010\000\000\000\000\000"
+/* offset=3D75651 */
+"dtlb-write-miss\000legacy cache\000Data TLB write misses\000legacy-cache-=
config=3D0x10103\000\00010\000\000\000\000\000"
+/* offset=3D75738 */
+"dtlb-prefetch\000legacy cache\000Data TLB prefetch accesses\000legacy-cac=
he-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D75826 */
+"dtlb-prefetch-refs\000legacy cache\000Data TLB prefetch accesses\000legac=
y-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D75919 */
+"dtlb-prefetch-reference\000legacy cache\000Data TLB prefetch accesses\000=
legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D76017 */
+"dtlb-prefetch-ops\000legacy cache\000Data TLB prefetch accesses\000legacy=
-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D76109 */
+"dtlb-prefetch-access\000legacy cache\000Data TLB prefetch accesses\000leg=
acy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D76204 */
+"dtlb-prefetch-misses\000legacy cache\000Data TLB prefetch misses\000legac=
y-cache-config=3D0x10203\000\00000\000\000\000\000\000"
+/* offset=3D76299 */
+"dtlb-prefetch-miss\000legacy cache\000Data TLB prefetch misses\000legacy-=
cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D76392 */
+"dtlb-prefetches\000legacy cache\000Data TLB prefetch accesses\000legacy-c=
ache-config=3D0x203\000\00000\000\000\000\000\000"
+/* offset=3D76482 */
+"dtlb-prefetches-refs\000legacy cache\000Data TLB prefetch accesses\000leg=
acy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D76577 */
+"dtlb-prefetches-reference\000legacy cache\000Data TLB prefetch accesses\0=
00legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D76677 */
+"dtlb-prefetches-ops\000legacy cache\000Data TLB prefetch accesses\000lega=
cy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D76771 */
+"dtlb-prefetches-access\000legacy cache\000Data TLB prefetch accesses\000l=
egacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D76868 */
+"dtlb-prefetches-misses\000legacy cache\000Data TLB prefetch misses\000leg=
acy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D76965 */
+"dtlb-prefetches-miss\000legacy cache\000Data TLB prefetch misses\000legac=
y-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D77060 */
+"dtlb-speculative-read\000legacy cache\000Data TLB prefetch accesses\000le=
gacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D77156 */
+"dtlb-speculative-read-refs\000legacy cache\000Data TLB prefetch accesses\=
000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D77257 */
+"dtlb-speculative-read-reference\000legacy cache\000Data TLB prefetch acce=
sses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D77363 */
+"dtlb-speculative-read-ops\000legacy cache\000Data TLB prefetch accesses\0=
00legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D77463 */
+"dtlb-speculative-read-access\000legacy cache\000Data TLB prefetch accesse=
s\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D77566 */
+"dtlb-speculative-read-misses\000legacy cache\000Data TLB prefetch misses\=
000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D77669 */
+"dtlb-speculative-read-miss\000legacy cache\000Data TLB prefetch misses\00=
0legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D77770 */
+"dtlb-speculative-load\000legacy cache\000Data TLB prefetch accesses\000le=
gacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D77866 */
+"dtlb-speculative-load-refs\000legacy cache\000Data TLB prefetch accesses\=
000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D77967 */
+"dtlb-speculative-load-reference\000legacy cache\000Data TLB prefetch acce=
sses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D78073 */
+"dtlb-speculative-load-ops\000legacy cache\000Data TLB prefetch accesses\0=
00legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D78173 */
+"dtlb-speculative-load-access\000legacy cache\000Data TLB prefetch accesse=
s\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D78276 */
+"dtlb-speculative-load-misses\000legacy cache\000Data TLB prefetch misses\=
000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D78379 */
+"dtlb-speculative-load-miss\000legacy cache\000Data TLB prefetch misses\00=
0legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D78480 */
+"dtlb-refs\000legacy cache\000Data TLB read accesses\000legacy-cache-confi=
g=3D3\000\00010\000\000\000\000\000"
+/* offset=3D78556 */
+"dtlb-reference\000legacy cache\000Data TLB read accesses\000legacy-cache-=
config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D78637 */
+"dtlb-ops\000legacy cache\000Data TLB read accesses\000legacy-cache-config=
=3D3\000\00010\000\000\000\000\000"
+/* offset=3D78712 */
+"dtlb-access\000legacy cache\000Data TLB read accesses\000legacy-cache-con=
fig=3D3\000\00010\000\000\000\000\000"
+/* offset=3D78790 */
+"dtlb-misses\000legacy cache\000Data TLB read misses\000legacy-cache-confi=
g=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D78872 */
+"dtlb-miss\000legacy cache\000Data TLB read misses\000legacy-cache-config=
=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D78952 */
+"d-tlb\000legacy cache\000Data TLB read accesses\000legacy-cache-config=3D=
3\000\00010\000\000\000\000\000"
+/* offset=3D79024 */
+"d-tlb-load\000legacy cache\000Data TLB read accesses\000legacy-cache-conf=
ig=3D3\000\00010\000\000\000\000\000"
+/* offset=3D79101 */
+"d-tlb-load-refs\000legacy cache\000Data TLB read accesses\000legacy-cache=
-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D79183 */
+"d-tlb-load-reference\000legacy cache\000Data TLB read accesses\000legacy-=
cache-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D79270 */
+"d-tlb-load-ops\000legacy cache\000Data TLB read accesses\000legacy-cache-=
config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D79351 */
+"d-tlb-load-access\000legacy cache\000Data TLB read accesses\000legacy-cac=
he-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D79435 */
+"d-tlb-load-misses\000legacy cache\000Data TLB read misses\000legacy-cache=
-config=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D79523 */
+"d-tlb-load-miss\000legacy cache\000Data TLB read misses\000legacy-cache-c=
onfig=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D79609 */
+"d-tlb-loads\000legacy cache\000Data TLB read accesses\000legacy-cache-con=
fig=3D3\000\00010\000\000\000\000\000"
+/* offset=3D79687 */
+"d-tlb-loads-refs\000legacy cache\000Data TLB read accesses\000legacy-cach=
e-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D79770 */
+"d-tlb-loads-reference\000legacy cache\000Data TLB read accesses\000legacy=
-cache-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D79858 */
+"d-tlb-loads-ops\000legacy cache\000Data TLB read accesses\000legacy-cache=
-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D79940 */
+"d-tlb-loads-access\000legacy cache\000Data TLB read accesses\000legacy-ca=
che-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D80025 */
+"d-tlb-loads-misses\000legacy cache\000Data TLB read misses\000legacy-cach=
e-config=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D80114 */
+"d-tlb-loads-miss\000legacy cache\000Data TLB read misses\000legacy-cache-=
config=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D80201 */
+"d-tlb-read\000legacy cache\000Data TLB read accesses\000legacy-cache-conf=
ig=3D3\000\00010\000\000\000\000\000"
+/* offset=3D80278 */
+"d-tlb-read-refs\000legacy cache\000Data TLB read accesses\000legacy-cache=
-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D80360 */
+"d-tlb-read-reference\000legacy cache\000Data TLB read accesses\000legacy-=
cache-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D80447 */
+"d-tlb-read-ops\000legacy cache\000Data TLB read accesses\000legacy-cache-=
config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D80528 */
+"d-tlb-read-access\000legacy cache\000Data TLB read accesses\000legacy-cac=
he-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D80612 */
+"d-tlb-read-misses\000legacy cache\000Data TLB read misses\000legacy-cache=
-config=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D80700 */
+"d-tlb-read-miss\000legacy cache\000Data TLB read misses\000legacy-cache-c=
onfig=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D80786 */
+"d-tlb-store\000legacy cache\000Data TLB write accesses\000legacy-cache-co=
nfig=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D80869 */
+"d-tlb-store-refs\000legacy cache\000Data TLB write accesses\000legacy-cac=
he-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D80957 */
+"d-tlb-store-reference\000legacy cache\000Data TLB write accesses\000legac=
y-cache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D81050 */
+"d-tlb-store-ops\000legacy cache\000Data TLB write accesses\000legacy-cach=
e-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D81137 */
+"d-tlb-store-access\000legacy cache\000Data TLB write accesses\000legacy-c=
ache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D81227 */
+"d-tlb-store-misses\000legacy cache\000Data TLB write misses\000legacy-cac=
he-config=3D0x10103\000\00010\000\000\000\000\000"
+/* offset=3D81317 */
+"d-tlb-store-miss\000legacy cache\000Data TLB write misses\000legacy-cache=
-config=3D0x10103\000\00010\000\000\000\000\000"
+/* offset=3D81405 */
+"d-tlb-stores\000legacy cache\000Data TLB write accesses\000legacy-cache-c=
onfig=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D81489 */
+"d-tlb-stores-refs\000legacy cache\000Data TLB write accesses\000legacy-ca=
che-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D81578 */
+"d-tlb-stores-reference\000legacy cache\000Data TLB write accesses\000lega=
cy-cache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D81672 */
+"d-tlb-stores-ops\000legacy cache\000Data TLB write accesses\000legacy-cac=
he-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D81760 */
+"d-tlb-stores-access\000legacy cache\000Data TLB write accesses\000legacy-=
cache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D81851 */
+"d-tlb-stores-misses\000legacy cache\000Data TLB write misses\000legacy-ca=
che-config=3D0x10103\000\00010\000\000\000\000\000"
+/* offset=3D81942 */
+"d-tlb-stores-miss\000legacy cache\000Data TLB write misses\000legacy-cach=
e-config=3D0x10103\000\00010\000\000\000\000\000"
+/* offset=3D82031 */
+"d-tlb-write\000legacy cache\000Data TLB write accesses\000legacy-cache-co=
nfig=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D82114 */
+"d-tlb-write-refs\000legacy cache\000Data TLB write accesses\000legacy-cac=
he-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D82202 */
+"d-tlb-write-reference\000legacy cache\000Data TLB write accesses\000legac=
y-cache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D82295 */
+"d-tlb-write-ops\000legacy cache\000Data TLB write accesses\000legacy-cach=
e-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D82382 */
+"d-tlb-write-access\000legacy cache\000Data TLB write accesses\000legacy-c=
ache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D82472 */
+"d-tlb-write-misses\000legacy cache\000Data TLB write misses\000legacy-cac=
he-config=3D0x10103\000\00010\000\000\000\000\000"
+/* offset=3D82562 */
+"d-tlb-write-miss\000legacy cache\000Data TLB write misses\000legacy-cache=
-config=3D0x10103\000\00010\000\000\000\000\000"
+/* offset=3D82650 */
+"d-tlb-prefetch\000legacy cache\000Data TLB prefetch accesses\000legacy-ca=
che-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D82739 */
+"d-tlb-prefetch-refs\000legacy cache\000Data TLB prefetch accesses\000lega=
cy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D82833 */
+"d-tlb-prefetch-reference\000legacy cache\000Data TLB prefetch accesses\00=
0legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D82932 */
+"d-tlb-prefetch-ops\000legacy cache\000Data TLB prefetch accesses\000legac=
y-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D83025 */
+"d-tlb-prefetch-access\000legacy cache\000Data TLB prefetch accesses\000le=
gacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D83121 */
+"d-tlb-prefetch-misses\000legacy cache\000Data TLB prefetch misses\000lega=
cy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D83217 */
+"d-tlb-prefetch-miss\000legacy cache\000Data TLB prefetch misses\000legacy=
-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D83311 */
+"d-tlb-prefetches\000legacy cache\000Data TLB prefetch accesses\000legacy-=
cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D83402 */
+"d-tlb-prefetches-refs\000legacy cache\000Data TLB prefetch accesses\000le=
gacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D83498 */
+"d-tlb-prefetches-reference\000legacy cache\000Data TLB prefetch accesses\=
000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D83599 */
+"d-tlb-prefetches-ops\000legacy cache\000Data TLB prefetch accesses\000leg=
acy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D83694 */
+"d-tlb-prefetches-access\000legacy cache\000Data TLB prefetch accesses\000=
legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D83792 */
+"d-tlb-prefetches-misses\000legacy cache\000Data TLB prefetch misses\000le=
gacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D83890 */
+"d-tlb-prefetches-miss\000legacy cache\000Data TLB prefetch misses\000lega=
cy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D83986 */
+"d-tlb-speculative-read\000legacy cache\000Data TLB prefetch accesses\000l=
egacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D84083 */
+"d-tlb-speculative-read-refs\000legacy cache\000Data TLB prefetch accesses=
\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D84185 */
+"d-tlb-speculative-read-reference\000legacy cache\000Data TLB prefetch acc=
esses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D84292 */
+"d-tlb-speculative-read-ops\000legacy cache\000Data TLB prefetch accesses\=
000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D84393 */
+"d-tlb-speculative-read-access\000legacy cache\000Data TLB prefetch access=
es\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D84497 */
+"d-tlb-speculative-read-misses\000legacy cache\000Data TLB prefetch misses=
\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D84601 */
+"d-tlb-speculative-read-miss\000legacy cache\000Data TLB prefetch misses\0=
00legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D84703 */
+"d-tlb-speculative-load\000legacy cache\000Data TLB prefetch accesses\000l=
egacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D84800 */
+"d-tlb-speculative-load-refs\000legacy cache\000Data TLB prefetch accesses=
\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D84902 */
+"d-tlb-speculative-load-reference\000legacy cache\000Data TLB prefetch acc=
esses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D85009 */
+"d-tlb-speculative-load-ops\000legacy cache\000Data TLB prefetch accesses\=
000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D85110 */
+"d-tlb-speculative-load-access\000legacy cache\000Data TLB prefetch access=
es\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D85214 */
+"d-tlb-speculative-load-misses\000legacy cache\000Data TLB prefetch misses=
\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D85318 */
+"d-tlb-speculative-load-miss\000legacy cache\000Data TLB prefetch misses\0=
00legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D85420 */
+"d-tlb-refs\000legacy cache\000Data TLB read accesses\000legacy-cache-conf=
ig=3D3\000\00010\000\000\000\000\000"
+/* offset=3D85497 */
+"d-tlb-reference\000legacy cache\000Data TLB read accesses\000legacy-cache=
-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D85579 */
+"d-tlb-ops\000legacy cache\000Data TLB read accesses\000legacy-cache-confi=
g=3D3\000\00010\000\000\000\000\000"
+/* offset=3D85655 */
+"d-tlb-access\000legacy cache\000Data TLB read accesses\000legacy-cache-co=
nfig=3D3\000\00010\000\000\000\000\000"
+/* offset=3D85734 */
+"d-tlb-misses\000legacy cache\000Data TLB read misses\000legacy-cache-conf=
ig=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D85817 */
+"d-tlb-miss\000legacy cache\000Data TLB read misses\000legacy-cache-config=
=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D85898 */
+"data-tlb\000legacy cache\000Data TLB read accesses\000legacy-cache-config=
=3D3\000\00010\000\000\000\000\000"
+/* offset=3D85973 */
+"data-tlb-load\000legacy cache\000Data TLB read accesses\000legacy-cache-c=
onfig=3D3\000\00010\000\000\000\000\000"
+/* offset=3D86053 */
+"data-tlb-load-refs\000legacy cache\000Data TLB read accesses\000legacy-ca=
che-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D86138 */
+"data-tlb-load-reference\000legacy cache\000Data TLB read accesses\000lega=
cy-cache-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D86228 */
+"data-tlb-load-ops\000legacy cache\000Data TLB read accesses\000legacy-cac=
he-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D86312 */
+"data-tlb-load-access\000legacy cache\000Data TLB read accesses\000legacy-=
cache-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D86399 */
+"data-tlb-load-misses\000legacy cache\000Data TLB read misses\000legacy-ca=
che-config=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D86490 */
+"data-tlb-load-miss\000legacy cache\000Data TLB read misses\000legacy-cach=
e-config=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D86579 */
+"data-tlb-loads\000legacy cache\000Data TLB read accesses\000legacy-cache-=
config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D86660 */
+"data-tlb-loads-refs\000legacy cache\000Data TLB read accesses\000legacy-c=
ache-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D86746 */
+"data-tlb-loads-reference\000legacy cache\000Data TLB read accesses\000leg=
acy-cache-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D86837 */
+"data-tlb-loads-ops\000legacy cache\000Data TLB read accesses\000legacy-ca=
che-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D86922 */
+"data-tlb-loads-access\000legacy cache\000Data TLB read accesses\000legacy=
-cache-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D87010 */
+"data-tlb-loads-misses\000legacy cache\000Data TLB read misses\000legacy-c=
ache-config=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D87102 */
+"data-tlb-loads-miss\000legacy cache\000Data TLB read misses\000legacy-cac=
he-config=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D87192 */
+"data-tlb-read\000legacy cache\000Data TLB read accesses\000legacy-cache-c=
onfig=3D3\000\00010\000\000\000\000\000"
+/* offset=3D87272 */
+"data-tlb-read-refs\000legacy cache\000Data TLB read accesses\000legacy-ca=
che-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D87357 */
+"data-tlb-read-reference\000legacy cache\000Data TLB read accesses\000lega=
cy-cache-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D87447 */
+"data-tlb-read-ops\000legacy cache\000Data TLB read accesses\000legacy-cac=
he-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D87531 */
+"data-tlb-read-access\000legacy cache\000Data TLB read accesses\000legacy-=
cache-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D87618 */
+"data-tlb-read-misses\000legacy cache\000Data TLB read misses\000legacy-ca=
che-config=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D87709 */
+"data-tlb-read-miss\000legacy cache\000Data TLB read misses\000legacy-cach=
e-config=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D87798 */
+"data-tlb-store\000legacy cache\000Data TLB write accesses\000legacy-cache=
-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D87884 */
+"data-tlb-store-refs\000legacy cache\000Data TLB write accesses\000legacy-=
cache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D87975 */
+"data-tlb-store-reference\000legacy cache\000Data TLB write accesses\000le=
gacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D88071 */
+"data-tlb-store-ops\000legacy cache\000Data TLB write accesses\000legacy-c=
ache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D88161 */
+"data-tlb-store-access\000legacy cache\000Data TLB write accesses\000legac=
y-cache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D88254 */
+"data-tlb-store-misses\000legacy cache\000Data TLB write misses\000legacy-=
cache-config=3D0x10103\000\00010\000\000\000\000\000"
+/* offset=3D88347 */
+"data-tlb-store-miss\000legacy cache\000Data TLB write misses\000legacy-ca=
che-config=3D0x10103\000\00010\000\000\000\000\000"
+/* offset=3D88438 */
+"data-tlb-stores\000legacy cache\000Data TLB write accesses\000legacy-cach=
e-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D88525 */
+"data-tlb-stores-refs\000legacy cache\000Data TLB write accesses\000legacy=
-cache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D88617 */
+"data-tlb-stores-reference\000legacy cache\000Data TLB write accesses\000l=
egacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D88714 */
+"data-tlb-stores-ops\000legacy cache\000Data TLB write accesses\000legacy-=
cache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D88805 */
+"data-tlb-stores-access\000legacy cache\000Data TLB write accesses\000lega=
cy-cache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D88899 */
+"data-tlb-stores-misses\000legacy cache\000Data TLB write misses\000legacy=
-cache-config=3D0x10103\000\00010\000\000\000\000\000"
+/* offset=3D88993 */
+"data-tlb-stores-miss\000legacy cache\000Data TLB write misses\000legacy-c=
ache-config=3D0x10103\000\00010\000\000\000\000\000"
+/* offset=3D89085 */
+"data-tlb-write\000legacy cache\000Data TLB write accesses\000legacy-cache=
-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D89171 */
+"data-tlb-write-refs\000legacy cache\000Data TLB write accesses\000legacy-=
cache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D89262 */
+"data-tlb-write-reference\000legacy cache\000Data TLB write accesses\000le=
gacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D89358 */
+"data-tlb-write-ops\000legacy cache\000Data TLB write accesses\000legacy-c=
ache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D89448 */
+"data-tlb-write-access\000legacy cache\000Data TLB write accesses\000legac=
y-cache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D89541 */
+"data-tlb-write-misses\000legacy cache\000Data TLB write misses\000legacy-=
cache-config=3D0x10103\000\00010\000\000\000\000\000"
+/* offset=3D89634 */
+"data-tlb-write-miss\000legacy cache\000Data TLB write misses\000legacy-ca=
che-config=3D0x10103\000\00010\000\000\000\000\000"
+/* offset=3D89725 */
+"data-tlb-prefetch\000legacy cache\000Data TLB prefetch accesses\000legacy=
-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D89817 */
+"data-tlb-prefetch-refs\000legacy cache\000Data TLB prefetch accesses\000l=
egacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D89914 */
+"data-tlb-prefetch-reference\000legacy cache\000Data TLB prefetch accesses=
\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D90016 */
+"data-tlb-prefetch-ops\000legacy cache\000Data TLB prefetch accesses\000le=
gacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D90112 */
+"data-tlb-prefetch-access\000legacy cache\000Data TLB prefetch accesses\00=
0legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D90211 */
+"data-tlb-prefetch-misses\000legacy cache\000Data TLB prefetch misses\000l=
egacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D90310 */
+"data-tlb-prefetch-miss\000legacy cache\000Data TLB prefetch misses\000leg=
acy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D90407 */
+"data-tlb-prefetches\000legacy cache\000Data TLB prefetch accesses\000lega=
cy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D90501 */
+"data-tlb-prefetches-refs\000legacy cache\000Data TLB prefetch accesses\00=
0legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D90600 */
+"data-tlb-prefetches-reference\000legacy cache\000Data TLB prefetch access=
es\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D90704 */
+"data-tlb-prefetches-ops\000legacy cache\000Data TLB prefetch accesses\000=
legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D90802 */
+"data-tlb-prefetches-access\000legacy cache\000Data TLB prefetch accesses\=
000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D90903 */
+"data-tlb-prefetches-misses\000legacy cache\000Data TLB prefetch misses\00=
0legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D91004 */
+"data-tlb-prefetches-miss\000legacy cache\000Data TLB prefetch misses\000l=
egacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D91103 */
+"data-tlb-speculative-read\000legacy cache\000Data TLB prefetch accesses\0=
00legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D91203 */
+"data-tlb-speculative-read-refs\000legacy cache\000Data TLB prefetch acces=
ses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D91308 */
+"data-tlb-speculative-read-reference\000legacy cache\000Data TLB prefetch =
accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D91418 */
+"data-tlb-speculative-read-ops\000legacy cache\000Data TLB prefetch access=
es\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D91522 */
+"data-tlb-speculative-read-access\000legacy cache\000Data TLB prefetch acc=
esses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D91629 */
+"data-tlb-speculative-read-misses\000legacy cache\000Data TLB prefetch mis=
ses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D91736 */
+"data-tlb-speculative-read-miss\000legacy cache\000Data TLB prefetch misse=
s\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D91841 */
+"data-tlb-speculative-load\000legacy cache\000Data TLB prefetch accesses\0=
00legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D91941 */
+"data-tlb-speculative-load-refs\000legacy cache\000Data TLB prefetch acces=
ses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D92046 */
+"data-tlb-speculative-load-reference\000legacy cache\000Data TLB prefetch =
accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D92156 */
+"data-tlb-speculative-load-ops\000legacy cache\000Data TLB prefetch access=
es\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D92260 */
+"data-tlb-speculative-load-access\000legacy cache\000Data TLB prefetch acc=
esses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D92367 */
+"data-tlb-speculative-load-misses\000legacy cache\000Data TLB prefetch mis=
ses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D92474 */
+"data-tlb-speculative-load-miss\000legacy cache\000Data TLB prefetch misse=
s\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D92579 */
+"data-tlb-refs\000legacy cache\000Data TLB read accesses\000legacy-cache-c=
onfig=3D3\000\00010\000\000\000\000\000"
+/* offset=3D92659 */
+"data-tlb-reference\000legacy cache\000Data TLB read accesses\000legacy-ca=
che-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D92744 */
+"data-tlb-ops\000legacy cache\000Data TLB read accesses\000legacy-cache-co=
nfig=3D3\000\00010\000\000\000\000\000"
+/* offset=3D92823 */
+"data-tlb-access\000legacy cache\000Data TLB read accesses\000legacy-cache=
-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D92905 */
+"data-tlb-misses\000legacy cache\000Data TLB read misses\000legacy-cache-c=
onfig=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D92991 */
+"data-tlb-miss\000legacy cache\000Data TLB read misses\000legacy-cache-con=
fig=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D93075 */
+"itlb\000legacy cache\000Instruction TLB read accesses\000legacy-cache-con=
fig=3D4\000\00010\000\000\000\000\000"
+/* offset=3D93153 */
+"itlb-load\000legacy cache\000Instruction TLB read accesses\000legacy-cach=
e-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D93236 */
+"itlb-load-refs\000legacy cache\000Instruction TLB read accesses\000legacy=
-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D93324 */
+"itlb-load-reference\000legacy cache\000Instruction TLB read accesses\000l=
egacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D93417 */
+"itlb-load-ops\000legacy cache\000Instruction TLB read accesses\000legacy-=
cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D93504 */
+"itlb-load-access\000legacy cache\000Instruction TLB read accesses\000lega=
cy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D93594 */
+"itlb-load-misses\000legacy cache\000Instruction TLB read misses\000legacy=
-cache-config=3D0x10004\000\00000\000\000\000\000\000"
+/* offset=3D93688 */
+"itlb-load-miss\000legacy cache\000Instruction TLB read misses\000legacy-c=
ache-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D93780 */
+"itlb-loads\000legacy cache\000Instruction TLB read accesses\000legacy-cac=
he-config=3D4\000\00000\000\000\000\000\000"
+/* offset=3D93864 */
+"itlb-loads-refs\000legacy cache\000Instruction TLB read accesses\000legac=
y-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D93953 */
+"itlb-loads-reference\000legacy cache\000Instruction TLB read accesses\000=
legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D94047 */
+"itlb-loads-ops\000legacy cache\000Instruction TLB read accesses\000legacy=
-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D94135 */
+"itlb-loads-access\000legacy cache\000Instruction TLB read accesses\000leg=
acy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D94226 */
+"itlb-loads-misses\000legacy cache\000Instruction TLB read misses\000legac=
y-cache-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D94321 */
+"itlb-loads-miss\000legacy cache\000Instruction TLB read misses\000legacy-=
cache-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D94414 */
+"itlb-read\000legacy cache\000Instruction TLB read accesses\000legacy-cach=
e-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D94497 */
+"itlb-read-refs\000legacy cache\000Instruction TLB read accesses\000legacy=
-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D94585 */
+"itlb-read-reference\000legacy cache\000Instruction TLB read accesses\000l=
egacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D94678 */
+"itlb-read-ops\000legacy cache\000Instruction TLB read accesses\000legacy-=
cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D94765 */
+"itlb-read-access\000legacy cache\000Instruction TLB read accesses\000lega=
cy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D94855 */
+"itlb-read-misses\000legacy cache\000Instruction TLB read misses\000legacy=
-cache-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D94949 */
+"itlb-read-miss\000legacy cache\000Instruction TLB read misses\000legacy-c=
ache-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D95041 */
+"itlb-refs\000legacy cache\000Instruction TLB read accesses\000legacy-cach=
e-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D95124 */
+"itlb-reference\000legacy cache\000Instruction TLB read accesses\000legacy=
-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D95212 */
+"itlb-ops\000legacy cache\000Instruction TLB read accesses\000legacy-cache=
-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D95294 */
+"itlb-access\000legacy cache\000Instruction TLB read accesses\000legacy-ca=
che-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D95379 */
+"itlb-misses\000legacy cache\000Instruction TLB read misses\000legacy-cach=
e-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D95468 */
+"itlb-miss\000legacy cache\000Instruction TLB read misses\000legacy-cache-=
config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D95555 */
+"i-tlb\000legacy cache\000Instruction TLB read accesses\000legacy-cache-co=
nfig=3D4\000\00010\000\000\000\000\000"
+/* offset=3D95634 */
+"i-tlb-load\000legacy cache\000Instruction TLB read accesses\000legacy-cac=
he-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D95718 */
+"i-tlb-load-refs\000legacy cache\000Instruction TLB read accesses\000legac=
y-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D95807 */
+"i-tlb-load-reference\000legacy cache\000Instruction TLB read accesses\000=
legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D95901 */
+"i-tlb-load-ops\000legacy cache\000Instruction TLB read accesses\000legacy=
-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D95989 */
+"i-tlb-load-access\000legacy cache\000Instruction TLB read accesses\000leg=
acy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D96080 */
+"i-tlb-load-misses\000legacy cache\000Instruction TLB read misses\000legac=
y-cache-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D96175 */
+"i-tlb-load-miss\000legacy cache\000Instruction TLB read misses\000legacy-=
cache-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D96268 */
+"i-tlb-loads\000legacy cache\000Instruction TLB read accesses\000legacy-ca=
che-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D96353 */
+"i-tlb-loads-refs\000legacy cache\000Instruction TLB read accesses\000lega=
cy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D96443 */
+"i-tlb-loads-reference\000legacy cache\000Instruction TLB read accesses\00=
0legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D96538 */
+"i-tlb-loads-ops\000legacy cache\000Instruction TLB read accesses\000legac=
y-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D96627 */
+"i-tlb-loads-access\000legacy cache\000Instruction TLB read accesses\000le=
gacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D96719 */
+"i-tlb-loads-misses\000legacy cache\000Instruction TLB read misses\000lega=
cy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D96815 */
+"i-tlb-loads-miss\000legacy cache\000Instruction TLB read misses\000legacy=
-cache-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D96909 */
+"i-tlb-read\000legacy cache\000Instruction TLB read accesses\000legacy-cac=
he-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D96993 */
+"i-tlb-read-refs\000legacy cache\000Instruction TLB read accesses\000legac=
y-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D97082 */
+"i-tlb-read-reference\000legacy cache\000Instruction TLB read accesses\000=
legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D97176 */
+"i-tlb-read-ops\000legacy cache\000Instruction TLB read accesses\000legacy=
-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D97264 */
+"i-tlb-read-access\000legacy cache\000Instruction TLB read accesses\000leg=
acy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D97355 */
+"i-tlb-read-misses\000legacy cache\000Instruction TLB read misses\000legac=
y-cache-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D97450 */
+"i-tlb-read-miss\000legacy cache\000Instruction TLB read misses\000legacy-=
cache-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D97543 */
+"i-tlb-refs\000legacy cache\000Instruction TLB read accesses\000legacy-cac=
he-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D97627 */
+"i-tlb-reference\000legacy cache\000Instruction TLB read accesses\000legac=
y-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D97716 */
+"i-tlb-ops\000legacy cache\000Instruction TLB read accesses\000legacy-cach=
e-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D97799 */
+"i-tlb-access\000legacy cache\000Instruction TLB read accesses\000legacy-c=
ache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D97885 */
+"i-tlb-misses\000legacy cache\000Instruction TLB read misses\000legacy-cac=
he-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D97975 */
+"i-tlb-miss\000legacy cache\000Instruction TLB read misses\000legacy-cache=
-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D98063 */
+"instruction-tlb\000legacy cache\000Instruction TLB read accesses\000legac=
y-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D98152 */
+"instruction-tlb-load\000legacy cache\000Instruction TLB read accesses\000=
legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D98246 */
+"instruction-tlb-load-refs\000legacy cache\000Instruction TLB read accesse=
s\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D98345 */
+"instruction-tlb-load-reference\000legacy cache\000Instruction TLB read ac=
cesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D98449 */
+"instruction-tlb-load-ops\000legacy cache\000Instruction TLB read accesses=
\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D98547 */
+"instruction-tlb-load-access\000legacy cache\000Instruction TLB read acces=
ses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D98648 */
+"instruction-tlb-load-misses\000legacy cache\000Instruction TLB read misse=
s\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D98753 */
+"instruction-tlb-load-miss\000legacy cache\000Instruction TLB read misses\=
000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D98856 */
+"instruction-tlb-loads\000legacy cache\000Instruction TLB read accesses\00=
0legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D98951 */
+"instruction-tlb-loads-refs\000legacy cache\000Instruction TLB read access=
es\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D99051 */
+"instruction-tlb-loads-reference\000legacy cache\000Instruction TLB read a=
ccesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D99156 */
+"instruction-tlb-loads-ops\000legacy cache\000Instruction TLB read accesse=
s\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D99255 */
+"instruction-tlb-loads-access\000legacy cache\000Instruction TLB read acce=
sses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D99357 */
+"instruction-tlb-loads-misses\000legacy cache\000Instruction TLB read miss=
es\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D99463 */
+"instruction-tlb-loads-miss\000legacy cache\000Instruction TLB read misses=
\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D99567 */
+"instruction-tlb-read\000legacy cache\000Instruction TLB read accesses\000=
legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D99661 */
+"instruction-tlb-read-refs\000legacy cache\000Instruction TLB read accesse=
s\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D99760 */
+"instruction-tlb-read-reference\000legacy cache\000Instruction TLB read ac=
cesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D99864 */
+"instruction-tlb-read-ops\000legacy cache\000Instruction TLB read accesses=
\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D99962 */
+"instruction-tlb-read-access\000legacy cache\000Instruction TLB read acces=
ses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D100063 */
+"instruction-tlb-read-misses\000legacy cache\000Instruction TLB read misse=
s\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D100168 */
+"instruction-tlb-read-miss\000legacy cache\000Instruction TLB read misses\=
000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D100271 */
+"instruction-tlb-refs\000legacy cache\000Instruction TLB read accesses\000=
legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D100365 */
+"instruction-tlb-reference\000legacy cache\000Instruction TLB read accesse=
s\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D100464 */
+"instruction-tlb-ops\000legacy cache\000Instruction TLB read accesses\000l=
egacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D100557 */
+"instruction-tlb-access\000legacy cache\000Instruction TLB read accesses\0=
00legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D100653 */
+"instruction-tlb-misses\000legacy cache\000Instruction TLB read misses\000=
legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D100753 */
+"instruction-tlb-miss\000legacy cache\000Instruction TLB read misses\000le=
gacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D100851 */
+"branch\000legacy cache\000Branch prediction unit read accesses\000legacy-=
cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D100938 */
+"branch-load\000legacy cache\000Branch prediction unit read accesses\000le=
gacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D101030 */
+"branch-load-refs\000legacy cache\000Branch prediction unit read accesses\=
000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D101127 */
+"branch-load-reference\000legacy cache\000Branch prediction unit read acce=
sses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D101229 */
+"branch-load-ops\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D101325 */
+"branch-load-access\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D101424 */
+"branch-load-misses\000legacy cache\000Branch prediction unit read misses\=
000legacy-cache-config=3D0x10005\000\00000\000\000\000\000\000"
+/* offset=3D101527 */
+"branch-load-miss\000legacy cache\000Branch prediction unit read misses\00=
0legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D101628 */
+"branch-loads\000legacy cache\000Branch prediction unit read accesses\000l=
egacy-cache-config=3D5\000\00000\000\000\000\000\000"
+/* offset=3D101721 */
+"branch-loads-refs\000legacy cache\000Branch prediction unit read accesses=
\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D101819 */
+"branch-loads-reference\000legacy cache\000Branch prediction unit read acc=
esses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D101922 */
+"branch-loads-ops\000legacy cache\000Branch prediction unit read accesses\=
000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D102019 */
+"branch-loads-access\000legacy cache\000Branch prediction unit read access=
es\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D102119 */
+"branch-loads-misses\000legacy cache\000Branch prediction unit read misses=
\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D102223 */
+"branch-loads-miss\000legacy cache\000Branch prediction unit read misses\0=
00legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D102325 */
+"branch-read\000legacy cache\000Branch prediction unit read accesses\000le=
gacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D102417 */
+"branch-read-refs\000legacy cache\000Branch prediction unit read accesses\=
000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D102514 */
+"branch-read-reference\000legacy cache\000Branch prediction unit read acce=
sses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D102616 */
+"branch-read-ops\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D102712 */
+"branch-read-access\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D102811 */
+"branch-read-misses\000legacy cache\000Branch prediction unit read misses\=
000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D102914 */
+"branch-read-miss\000legacy cache\000Branch prediction unit read misses\00=
0legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D103015 */
+"branch-refs\000legacy cache\000Branch prediction unit read accesses\000le=
gacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D103107 */
+"branch-reference\000legacy cache\000Branch prediction unit read accesses\=
000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D103204 */
+"branch-ops\000legacy cache\000Branch prediction unit read accesses\000leg=
acy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D103295 */
+"branch-access\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D103389 */
+"branch-miss\000legacy cache\000Branch prediction unit read misses\000lega=
cy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D103485 */
+"branches-load\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D103579 */
+"branches-load-refs\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D103678 */
+"branches-load-reference\000legacy cache\000Branch prediction unit read ac=
cesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D103782 */
+"branches-load-ops\000legacy cache\000Branch prediction unit read accesses=
\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D103880 */
+"branches-load-access\000legacy cache\000Branch prediction unit read acces=
ses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D103981 */
+"branches-load-misses\000legacy cache\000Branch prediction unit read misse=
s\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D104086 */
+"branches-load-miss\000legacy cache\000Branch prediction unit read misses\=
000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D104189 */
+"branches-loads\000legacy cache\000Branch prediction unit read accesses\00=
0legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D104284 */
+"branches-loads-refs\000legacy cache\000Branch prediction unit read access=
es\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D104384 */
+"branches-loads-reference\000legacy cache\000Branch prediction unit read a=
ccesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D104489 */
+"branches-loads-ops\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D104588 */
+"branches-loads-access\000legacy cache\000Branch prediction unit read acce=
sses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D104690 */
+"branches-loads-misses\000legacy cache\000Branch prediction unit read miss=
es\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D104796 */
+"branches-loads-miss\000legacy cache\000Branch prediction unit read misses=
\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D104900 */
+"branches-read\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D104994 */
+"branches-read-refs\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D105093 */
+"branches-read-reference\000legacy cache\000Branch prediction unit read ac=
cesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D105197 */
+"branches-read-ops\000legacy cache\000Branch prediction unit read accesses=
\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D105295 */
+"branches-read-access\000legacy cache\000Branch prediction unit read acces=
ses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D105396 */
+"branches-read-misses\000legacy cache\000Branch prediction unit read misse=
s\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D105501 */
+"branches-read-miss\000legacy cache\000Branch prediction unit read misses\=
000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D105604 */
+"branches-refs\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D105698 */
+"branches-reference\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D105797 */
+"branches-ops\000legacy cache\000Branch prediction unit read accesses\000l=
egacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D105890 */
+"branches-access\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D105986 */
+"branches-misses\000legacy cache\000Branch prediction unit read misses\000=
legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D106086 */
+"branches-miss\000legacy cache\000Branch prediction unit read misses\000le=
gacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D106184 */
+"bpu\000legacy cache\000Branch prediction unit read accesses\000legacy-cac=
he-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D106268 */
+"bpu-load\000legacy cache\000Branch prediction unit read accesses\000legac=
y-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D106357 */
+"bpu-load-refs\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D106451 */
+"bpu-load-reference\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D106550 */
+"bpu-load-ops\000legacy cache\000Branch prediction unit read accesses\000l=
egacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D106643 */
+"bpu-load-access\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D106739 */
+"bpu-load-misses\000legacy cache\000Branch prediction unit read misses\000=
legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D106839 */
+"bpu-load-miss\000legacy cache\000Branch prediction unit read misses\000le=
gacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D106937 */
+"bpu-loads\000legacy cache\000Branch prediction unit read accesses\000lega=
cy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D107027 */
+"bpu-loads-refs\000legacy cache\000Branch prediction unit read accesses\00=
0legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D107122 */
+"bpu-loads-reference\000legacy cache\000Branch prediction unit read access=
es\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D107222 */
+"bpu-loads-ops\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D107316 */
+"bpu-loads-access\000legacy cache\000Branch prediction unit read accesses\=
000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D107413 */
+"bpu-loads-misses\000legacy cache\000Branch prediction unit read misses\00=
0legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D107514 */
+"bpu-loads-miss\000legacy cache\000Branch prediction unit read misses\000l=
egacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D107613 */
+"bpu-read\000legacy cache\000Branch prediction unit read accesses\000legac=
y-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D107702 */
+"bpu-read-refs\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D107796 */
+"bpu-read-reference\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D107895 */
+"bpu-read-ops\000legacy cache\000Branch prediction unit read accesses\000l=
egacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D107988 */
+"bpu-read-access\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D108084 */
+"bpu-read-misses\000legacy cache\000Branch prediction unit read misses\000=
legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D108184 */
+"bpu-read-miss\000legacy cache\000Branch prediction unit read misses\000le=
gacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D108282 */
+"bpu-refs\000legacy cache\000Branch prediction unit read accesses\000legac=
y-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D108371 */
+"bpu-reference\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D108465 */
+"bpu-ops\000legacy cache\000Branch prediction unit read accesses\000legacy=
-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D108553 */
+"bpu-access\000legacy cache\000Branch prediction unit read accesses\000leg=
acy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D108644 */
+"bpu-misses\000legacy cache\000Branch prediction unit read misses\000legac=
y-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D108739 */
+"bpu-miss\000legacy cache\000Branch prediction unit read misses\000legacy-=
cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D108832 */
+"btb\000legacy cache\000Branch prediction unit read accesses\000legacy-cac=
he-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D108916 */
+"btb-load\000legacy cache\000Branch prediction unit read accesses\000legac=
y-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D109005 */
+"btb-load-refs\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D109099 */
+"btb-load-reference\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D109198 */
+"btb-load-ops\000legacy cache\000Branch prediction unit read accesses\000l=
egacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D109291 */
+"btb-load-access\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D109387 */
+"btb-load-misses\000legacy cache\000Branch prediction unit read misses\000=
legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D109487 */
+"btb-load-miss\000legacy cache\000Branch prediction unit read misses\000le=
gacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D109585 */
+"btb-loads\000legacy cache\000Branch prediction unit read accesses\000lega=
cy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D109675 */
+"btb-loads-refs\000legacy cache\000Branch prediction unit read accesses\00=
0legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D109770 */
+"btb-loads-reference\000legacy cache\000Branch prediction unit read access=
es\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D109870 */
+"btb-loads-ops\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D109964 */
+"btb-loads-access\000legacy cache\000Branch prediction unit read accesses\=
000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D110061 */
+"btb-loads-misses\000legacy cache\000Branch prediction unit read misses\00=
0legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D110162 */
+"btb-loads-miss\000legacy cache\000Branch prediction unit read misses\000l=
egacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D110261 */
+"btb-read\000legacy cache\000Branch prediction unit read accesses\000legac=
y-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D110350 */
+"btb-read-refs\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D110444 */
+"btb-read-reference\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D110543 */
+"btb-read-ops\000legacy cache\000Branch prediction unit read accesses\000l=
egacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D110636 */
+"btb-read-access\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D110732 */
+"btb-read-misses\000legacy cache\000Branch prediction unit read misses\000=
legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D110832 */
+"btb-read-miss\000legacy cache\000Branch prediction unit read misses\000le=
gacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D110930 */
+"btb-refs\000legacy cache\000Branch prediction unit read accesses\000legac=
y-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D111019 */
+"btb-reference\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D111113 */
+"btb-ops\000legacy cache\000Branch prediction unit read accesses\000legacy=
-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D111201 */
+"btb-access\000legacy cache\000Branch prediction unit read accesses\000leg=
acy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D111292 */
+"btb-misses\000legacy cache\000Branch prediction unit read misses\000legac=
y-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D111387 */
+"btb-miss\000legacy cache\000Branch prediction unit read misses\000legacy-=
cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D111480 */
+"bpc\000legacy cache\000Branch prediction unit read accesses\000legacy-cac=
he-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D111564 */
+"bpc-load\000legacy cache\000Branch prediction unit read accesses\000legac=
y-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D111653 */
+"bpc-load-refs\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D111747 */
+"bpc-load-reference\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D111846 */
+"bpc-load-ops\000legacy cache\000Branch prediction unit read accesses\000l=
egacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D111939 */
+"bpc-load-access\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D112035 */
+"bpc-load-misses\000legacy cache\000Branch prediction unit read misses\000=
legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D112135 */
+"bpc-load-miss\000legacy cache\000Branch prediction unit read misses\000le=
gacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D112233 */
+"bpc-loads\000legacy cache\000Branch prediction unit read accesses\000lega=
cy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D112323 */
+"bpc-loads-refs\000legacy cache\000Branch prediction unit read accesses\00=
0legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D112418 */
+"bpc-loads-reference\000legacy cache\000Branch prediction unit read access=
es\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D112518 */
+"bpc-loads-ops\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D112612 */
+"bpc-loads-access\000legacy cache\000Branch prediction unit read accesses\=
000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D112709 */
+"bpc-loads-misses\000legacy cache\000Branch prediction unit read misses\00=
0legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D112810 */
+"bpc-loads-miss\000legacy cache\000Branch prediction unit read misses\000l=
egacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D112909 */
+"bpc-read\000legacy cache\000Branch prediction unit read accesses\000legac=
y-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D112998 */
+"bpc-read-refs\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D113092 */
+"bpc-read-reference\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D113191 */
+"bpc-read-ops\000legacy cache\000Branch prediction unit read accesses\000l=
egacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D113284 */
+"bpc-read-access\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D113380 */
+"bpc-read-misses\000legacy cache\000Branch prediction unit read misses\000=
legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D113480 */
+"bpc-read-miss\000legacy cache\000Branch prediction unit read misses\000le=
gacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D113578 */
+"bpc-refs\000legacy cache\000Branch prediction unit read accesses\000legac=
y-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D113667 */
+"bpc-reference\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D113761 */
+"bpc-ops\000legacy cache\000Branch prediction unit read accesses\000legacy=
-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D113849 */
+"bpc-access\000legacy cache\000Branch prediction unit read accesses\000leg=
acy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D113940 */
+"bpc-misses\000legacy cache\000Branch prediction unit read misses\000legac=
y-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D114035 */
+"bpc-miss\000legacy cache\000Branch prediction unit read misses\000legacy-=
cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D114128 */
+"node\000legacy cache\000Local memory read accesses\000legacy-cache-config=
=3D6\000\00010\000\000\000\000\000"
+/* offset=3D114203 */
+"node-load\000legacy cache\000Local memory read accesses\000legacy-cache-c=
onfig=3D6\000\00010\000\000\000\000\000"
+/* offset=3D114283 */
+"node-load-refs\000legacy cache\000Local memory read accesses\000legacy-ca=
che-config=3D6\000\00010\000\000\000\000\000"
+/* offset=3D114368 */
+"node-load-reference\000legacy cache\000Local memory read accesses\000lega=
cy-cache-config=3D6\000\00010\000\000\000\000\000"
+/* offset=3D114458 */
+"node-load-ops\000legacy cache\000Local memory read accesses\000legacy-cac=
he-config=3D6\000\00010\000\000\000\000\000"
+/* offset=3D114542 */
+"node-load-access\000legacy cache\000Local memory read accesses\000legacy-=
cache-config=3D6\000\00010\000\000\000\000\000"
+/* offset=3D114629 */
+"node-load-misses\000legacy cache\000Local memory read misses\000legacy-ca=
che-config=3D0x10006\000\00000\000\000\000\000\000"
+/* offset=3D114720 */
+"node-load-miss\000legacy cache\000Local memory read misses\000legacy-cach=
e-config=3D0x10006\000\00010\000\000\000\000\000"
+/* offset=3D114809 */
+"node-loads\000legacy cache\000Local memory read accesses\000legacy-cache-=
config=3D6\000\00000\000\000\000\000\000"
+/* offset=3D114890 */
+"node-loads-refs\000legacy cache\000Local memory read accesses\000legacy-c=
ache-config=3D6\000\00010\000\000\000\000\000"
+/* offset=3D114976 */
+"node-loads-reference\000legacy cache\000Local memory read accesses\000leg=
acy-cache-config=3D6\000\00010\000\000\000\000\000"
+/* offset=3D115067 */
+"node-loads-ops\000legacy cache\000Local memory read accesses\000legacy-ca=
che-config=3D6\000\00010\000\000\000\000\000"
+/* offset=3D115152 */
+"node-loads-access\000legacy cache\000Local memory read accesses\000legacy=
-cache-config=3D6\000\00010\000\000\000\000\000"
+/* offset=3D115240 */
+"node-loads-misses\000legacy cache\000Local memory read misses\000legacy-c=
ache-config=3D0x10006\000\00010\000\000\000\000\000"
+/* offset=3D115332 */
+"node-loads-miss\000legacy cache\000Local memory read misses\000legacy-cac=
he-config=3D0x10006\000\00010\000\000\000\000\000"
+/* offset=3D115422 */
+"node-read\000legacy cache\000Local memory read accesses\000legacy-cache-c=
onfig=3D6\000\00010\000\000\000\000\000"
+/* offset=3D115502 */
+"node-read-refs\000legacy cache\000Local memory read accesses\000legacy-ca=
che-config=3D6\000\00010\000\000\000\000\000"
+/* offset=3D115587 */
+"node-read-reference\000legacy cache\000Local memory read accesses\000lega=
cy-cache-config=3D6\000\00010\000\000\000\000\000"
+/* offset=3D115677 */
+"node-read-ops\000legacy cache\000Local memory read accesses\000legacy-cac=
he-config=3D6\000\00010\000\000\000\000\000"
+/* offset=3D115761 */
+"node-read-access\000legacy cache\000Local memory read accesses\000legacy-=
cache-config=3D6\000\00010\000\000\000\000\000"
+/* offset=3D115848 */
+"node-read-misses\000legacy cache\000Local memory read misses\000legacy-ca=
che-config=3D0x10006\000\00010\000\000\000\000\000"
+/* offset=3D115939 */
+"node-read-miss\000legacy cache\000Local memory read misses\000legacy-cach=
e-config=3D0x10006\000\00010\000\000\000\000\000"
+/* offset=3D116028 */
+"node-store\000legacy cache\000Local memory write accesses\000legacy-cache=
-config=3D0x106\000\00010\000\000\000\000\000"
+/* offset=3D116114 */
+"node-store-refs\000legacy cache\000Local memory write accesses\000legacy-=
cache-config=3D0x106\000\00010\000\000\000\000\000"
+/* offset=3D116205 */
+"node-store-reference\000legacy cache\000Local memory write accesses\000le=
gacy-cache-config=3D0x106\000\00010\000\000\000\000\000"
+/* offset=3D116301 */
+"node-store-ops\000legacy cache\000Local memory write accesses\000legacy-c=
ache-config=3D0x106\000\00010\000\000\000\000\000"
+/* offset=3D116391 */
+"node-store-access\000legacy cache\000Local memory write accesses\000legac=
y-cache-config=3D0x106\000\00010\000\000\000\000\000"
+/* offset=3D116484 */
+"node-store-misses\000legacy cache\000Local memory write misses\000legacy-=
cache-config=3D0x10106\000\00000\000\000\000\000\000"
+/* offset=3D116577 */
+"node-store-miss\000legacy cache\000Local memory write misses\000legacy-ca=
che-config=3D0x10106\000\00010\000\000\000\000\000"
+/* offset=3D116668 */
+"node-stores\000legacy cache\000Local memory write accesses\000legacy-cach=
e-config=3D0x106\000\00000\000\000\000\000\000"
+/* offset=3D116755 */
+"node-stores-refs\000legacy cache\000Local memory write accesses\000legacy=
-cache-config=3D0x106\000\00010\000\000\000\000\000"
+/* offset=3D116847 */
+"node-stores-reference\000legacy cache\000Local memory write accesses\000l=
egacy-cache-config=3D0x106\000\00010\000\000\000\000\000"
+/* offset=3D116944 */
+"node-stores-ops\000legacy cache\000Local memory write accesses\000legacy-=
cache-config=3D0x106\000\00010\000\000\000\000\000"
+/* offset=3D117035 */
+"node-stores-access\000legacy cache\000Local memory write accesses\000lega=
cy-cache-config=3D0x106\000\00010\000\000\000\000\000"
+/* offset=3D117129 */
+"node-stores-misses\000legacy cache\000Local memory write misses\000legacy=
-cache-config=3D0x10106\000\00010\000\000\000\000\000"
+/* offset=3D117223 */
+"node-stores-miss\000legacy cache\000Local memory write misses\000legacy-c=
ache-config=3D0x10106\000\00010\000\000\000\000\000"
+/* offset=3D117315 */
+"node-write\000legacy cache\000Local memory write accesses\000legacy-cache=
-config=3D0x106\000\00010\000\000\000\000\000"
+/* offset=3D117401 */
+"node-write-refs\000legacy cache\000Local memory write accesses\000legacy-=
cache-config=3D0x106\000\00010\000\000\000\000\000"
+/* offset=3D117492 */
+"node-write-reference\000legacy cache\000Local memory write accesses\000le=
gacy-cache-config=3D0x106\000\00010\000\000\000\000\000"
+/* offset=3D117588 */
+"node-write-ops\000legacy cache\000Local memory write accesses\000legacy-c=
ache-config=3D0x106\000\00010\000\000\000\000\000"
+/* offset=3D117678 */
+"node-write-access\000legacy cache\000Local memory write accesses\000legac=
y-cache-config=3D0x106\000\00010\000\000\000\000\000"
+/* offset=3D117771 */
+"node-write-misses\000legacy cache\000Local memory write misses\000legacy-=
cache-config=3D0x10106\000\00010\000\000\000\000\000"
+/* offset=3D117864 */
+"node-write-miss\000legacy cache\000Local memory write misses\000legacy-ca=
che-config=3D0x10106\000\00010\000\000\000\000\000"
+/* offset=3D117955 */
+"node-prefetch\000legacy cache\000Local memory prefetch accesses\000legacy=
-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D118047 */
+"node-prefetch-refs\000legacy cache\000Local memory prefetch accesses\000l=
egacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D118144 */
+"node-prefetch-reference\000legacy cache\000Local memory prefetch accesses=
\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D118246 */
+"node-prefetch-ops\000legacy cache\000Local memory prefetch accesses\000le=
gacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D118342 */
+"node-prefetch-access\000legacy cache\000Local memory prefetch accesses\00=
0legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D118441 */
+"node-prefetch-misses\000legacy cache\000Local memory prefetch misses\000l=
egacy-cache-config=3D0x10206\000\00000\000\000\000\000\000"
+/* offset=3D118540 */
+"node-prefetch-miss\000legacy cache\000Local memory prefetch misses\000leg=
acy-cache-config=3D0x10206\000\00010\000\000\000\000\000"
+/* offset=3D118637 */
+"node-prefetches\000legacy cache\000Local memory prefetch accesses\000lega=
cy-cache-config=3D0x206\000\00000\000\000\000\000\000"
+/* offset=3D118731 */
+"node-prefetches-refs\000legacy cache\000Local memory prefetch accesses\00=
0legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D118830 */
+"node-prefetches-reference\000legacy cache\000Local memory prefetch access=
es\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D118934 */
+"node-prefetches-ops\000legacy cache\000Local memory prefetch accesses\000=
legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D119032 */
+"node-prefetches-access\000legacy cache\000Local memory prefetch accesses\=
000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D119133 */
+"node-prefetches-misses\000legacy cache\000Local memory prefetch misses\00=
0legacy-cache-config=3D0x10206\000\00010\000\000\000\000\000"
+/* offset=3D119234 */
+"node-prefetches-miss\000legacy cache\000Local memory prefetch misses\000l=
egacy-cache-config=3D0x10206\000\00010\000\000\000\000\000"
+/* offset=3D119333 */
+"node-speculative-read\000legacy cache\000Local memory prefetch accesses\0=
00legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D119433 */
+"node-speculative-read-refs\000legacy cache\000Local memory prefetch acces=
ses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D119538 */
+"node-speculative-read-reference\000legacy cache\000Local memory prefetch =
accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D119648 */
+"node-speculative-read-ops\000legacy cache\000Local memory prefetch access=
es\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D119752 */
+"node-speculative-read-access\000legacy cache\000Local memory prefetch acc=
esses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D119859 */
+"node-speculative-read-misses\000legacy cache\000Local memory prefetch mis=
ses\000legacy-cache-config=3D0x10206\000\00010\000\000\000\000\000"
+/* offset=3D119966 */
+"node-speculative-read-miss\000legacy cache\000Local memory prefetch misse=
s\000legacy-cache-config=3D0x10206\000\00010\000\000\000\000\000"
+/* offset=3D120071 */
+"node-speculative-load\000legacy cache\000Local memory prefetch accesses\0=
00legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D120171 */
+"node-speculative-load-refs\000legacy cache\000Local memory prefetch acces=
ses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D120276 */
+"node-speculative-load-reference\000legacy cache\000Local memory prefetch =
accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D120386 */
+"node-speculative-load-ops\000legacy cache\000Local memory prefetch access=
es\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D120490 */
+"node-speculative-load-access\000legacy cache\000Local memory prefetch acc=
esses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D120597 */
+"node-speculative-load-misses\000legacy cache\000Local memory prefetch mis=
ses\000legacy-cache-config=3D0x10206\000\00010\000\000\000\000\000"
+/* offset=3D120704 */
+"node-speculative-load-miss\000legacy cache\000Local memory prefetch misse=
s\000legacy-cache-config=3D0x10206\000\00010\000\000\000\000\000"
+/* offset=3D120809 */
+"node-refs\000legacy cache\000Local memory read accesses\000legacy-cache-c=
onfig=3D6\000\00010\000\000\000\000\000"
+/* offset=3D120889 */
+"node-reference\000legacy cache\000Local memory read accesses\000legacy-ca=
che-config=3D6\000\00010\000\000\000\000\000"
+/* offset=3D120974 */
+"node-ops\000legacy cache\000Local memory read accesses\000legacy-cache-co=
nfig=3D6\000\00010\000\000\000\000\000"
+/* offset=3D121053 */
+"node-access\000legacy cache\000Local memory read accesses\000legacy-cache=
-config=3D6\000\00010\000\000\000\000\000"
+/* offset=3D121135 */
+"node-misses\000legacy cache\000Local memory read misses\000legacy-cache-c=
onfig=3D0x10006\000\00010\000\000\000\000\000"
+/* offset=3D121221 */
+"node-miss\000legacy cache\000Local memory read misses\000legacy-cache-con=
fig=3D0x10006\000\00010\000\000\000\000\000"
+/* offset=3D121305 */
+"cpu-cycles\000legacy hardware\000Total cycles. Be wary of what happens du=
ring CPU frequency scaling [This event is an alias of cycles]\000legacy-har=
dware-config=3D0\000\00000\000\000\000\000\000"
+/* offset=3D121467 */
+"cycles\000legacy hardware\000Total cycles. Be wary of what happens during=
 CPU frequency scaling [This event is an alias of cpu-cycles]\000legacy-har=
dware-config=3D0\000\00000\000\000\000\000\000"
+/* offset=3D121629 */
+"instructions\000legacy hardware\000Retired instructions. Be careful, thes=
e can be affected by various issues, most notably hardware interrupt counts=
\000legacy-hardware-config=3D1\000\00000\000\000\000\000\000"
+/* offset=3D121805 */
+"cache-references\000legacy hardware\000Cache accesses. Usually this indic=
ates Last Level Cache accesses but this may vary depending on your CPU.  Th=
is may include prefetches and coherency messages; again this depends on the=
 design of your CPU\000legacy-hardware-config=3D2\000\00000\000\000\000\000=
\000"
+/* offset=3D122075 */
+"cache-misses\000legacy hardware\000Cache misses. Usually this indicates L=
ast Level Cache misses; this is intended to be used in conjunction with the=
 PERF_COUNT_HW_CACHE_REFERENCES event to calculate cache miss rates\000lega=
cy-hardware-config=3D3\000\00000\000\000\000\000\000"
+/* offset=3D122318 */
+"branches\000legacy hardware\000Retired branch instructions [This event is=
 an alias of branch-instructions]\000legacy-hardware-config=3D4\000\00000\0=
00\000\000\000\000"
+/* offset=3D122452 */
+"branch-instructions\000legacy hardware\000Retired branch instructions [Th=
is event is an alias of branches]\000legacy-hardware-config=3D4\000\00000\0=
00\000\000\000\000"
+/* offset=3D122586 */
+"branch-misses\000legacy hardware\000Mispredicted branch instructions\000l=
egacy-hardware-config=3D5\000\00000\000\000\000\000\000"
+/* offset=3D122682 */
+"bus-cycles\000legacy hardware\000Bus cycles, which can be different from =
total cycles\000legacy-hardware-config=3D6\000\00000\000\000\000\000\000"
+/* offset=3D122795 */
+"stalled-cycles-frontend\000legacy hardware\000Stalled cycles during issue=
 [This event is an alias of idle-cycles-frontend]\000legacy-hardware-config=
=3D7\000\00000\000\000\000\000\000"
+/* offset=3D122945 */
+"idle-cycles-frontend\000legacy hardware\000Stalled cycles during issue [T=
his event is an alias of stalled-cycles-fronted]\000legacy-hardware-config=
=3D7\000\00000\000\000\000\000\000"
+/* offset=3D123094 */
+"stalled-cycles-backend\000legacy hardware\000Stalled cycles during retire=
ment [This event is an alias of idle-cycles-backend]\000legacy-hardware-con=
fig=3D8\000\00000\000\000\000\000\000"
+/* offset=3D123247 */
+"idle-cycles-backend\000legacy hardware\000Stalled cycles during retiremen=
t [This event is an alias of stalled-cycles-backend]\000legacy-hardware-con=
fig=3D8\000\00000\000\000\000\000\000"
+/* offset=3D123400 */
+"ref-cycles\000legacy hardware\000Total cycles; not affected by CPU freque=
ncy scaling\000legacy-hardware-config=3D9\000\00000\000\000\000\000\000"
+/* offset=3D123512 */
+"software\000"
+/* offset=3D123521 */
+"cpu-clock\000software\000Per-CPU high-resolution timer based event\000con=
fig=3D0\000\000001e-6msec\000\000\000\000\000"
+/* offset=3D123607 */
+"task-clock\000software\000Per-task high-resolution timer based event\000c=
onfig=3D1\000\000001e-6msec\000\000\000\000\000"
+/* offset=3D123695 */
+"faults\000software\000Number of page faults [This event is an alias of pa=
ge-faults]\000config=3D2\000\00000\000\000\000\000\000"
+/* offset=3D123790 */
+"page-faults\000software\000Number of page faults [This event is an alias =
of faults]\000config=3D2\000\00000\000\000\000\000\000"
+/* offset=3D123885 */
+"context-switches\000software\000Number of context switches [This event is=
 an alias of cs]\000config=3D3\000\00000\000\000\000\000\000"
+/* offset=3D123986 */
+"cs\000software\000Number of context switches [This event is an alias of c=
ontext-switches]\000config=3D3\000\00000\000\000\000\000\000"
+/* offset=3D124087 */
+"cpu-migrations\000software\000Number of times a process has migrated to a=
 new CPU [This event is an alias of migrations]\000config=3D4\000\00000\000=
\000\000\000\000"
+/* offset=3D124219 */
+"migrations\000software\000Number of times a process has migrated to a new=
 CPU [This event is an alias of cpu-migrations]\000config=3D4\000\00000\000=
\000\000\000\000"
+/* offset=3D124351 */
+"minor-faults\000software\000Number of minor page faults. Minor faults don=
't require I/O to handle\000config=3D5\000\00000\000\000\000\000\000"
+/* offset=3D124460 */
+"major-faults\000software\000Number of major page faults. Major faults req=
uire I/O to handle\000config=3D6\000\00000\000\000\000\000\000"
+/* offset=3D124563 */
+"alignment-faults\000software\000Number of kernel handled memory alignment=
 faults\000config=3D7\000\00000\000\000\000\000\000"
+/* offset=3D124655 */
+"emulation-faults\000software\000Number of kernel handled unimplemented in=
struction faults handled through emulation\000config=3D8\000\00000\000\000\=
000\000\000"
+/* offset=3D124782 */
+"dummy\000software\000A placeholder event that doesn't count anything\000c=
onfig=3D9\000\00000\000\000\000\000\000"
+/* offset=3D124862 */
+"bpf-output\000software\000An event used by BPF programs to write to the p=
erf ring buffer\000config=3D0xa\000\00000\000\000\000\000\000"
+/* offset=3D124964 */
+"cgroup-switches\000software\000Number of context switches to a task in a =
different cgroup\000config=3D0xb\000\00000\000\000\000\000\000"
+/* offset=3D125067 */
+"tool\000"
+/* offset=3D125072 */
+"duration_time\000tool\000Wall clock interval time in nanoseconds\000confi=
g=3D1\000\00000\000\000\000\000\000"
+/* offset=3D125148 */
+"user_time\000tool\000User (non-kernel) time in nanoseconds\000config=3D2\=
000\00000\000\000\000\000\000"
+/* offset=3D125218 */
+"system_time\000tool\000System/kernel time in nanoseconds\000config=3D3\00=
0\00000\000\000\000\000\000"
+/* offset=3D125286 */
+"has_pmem\000tool\0001 if persistent memory installed otherwise 0\000confi=
g=3D4\000\00000\000\000\000\000\000"
+/* offset=3D125362 */
+"num_cores\000tool\000Number of cores. A core consists of 1 or more thread=
, with each thread being associated with a logical Linux CPU\000config=3D5\=
000\00000\000\000\000\000\000"
+/* offset=3D125507 */
+"num_cpus\000tool\000Number of logical Linux CPUs. There may be multiple s=
uch CPUs on a core\000config=3D6\000\00000\000\000\000\000\000"
+/* offset=3D125610 */
+"num_cpus_online\000tool\000Number of online logical Linux CPUs. There may=
 be multiple such CPUs on a core\000config=3D7\000\00000\000\000\000\000\00=
0"
+/* offset=3D125727 */
+"num_dies\000tool\000Number of dies. Each die has 1 or more cores\000confi=
g=3D8\000\00000\000\000\000\000\000"
+/* offset=3D125803 */
+"num_packages\000tool\000Number of packages. Each package has 1 or more di=
e\000config=3D9\000\00000\000\000\000\000\000"
+/* offset=3D125889 */
+"slots\000tool\000Number of functional units that in parallel can execute =
parts of an instruction\000config=3D0xa\000\00000\000\000\000\000\000"
+/* offset=3D125999 */
+"smt_on\000tool\0001 if simultaneous multithreading (aka hyperthreading) i=
s enable otherwise 0\000config=3D0xb\000\00000\000\000\000\000\000"
+/* offset=3D126106 */
+"system_tsc_freq\000tool\000The amount a Time Stamp Counter (TSC) increase=
s per second\000config=3D0xc\000\00000\000\000\000\000\000"
+/* offset=3D126205 */
+"core_wide\000tool\0001 if not SMT, if SMT are events being gathered on al=
l SMT threads 1 otherwise 0\000config=3D0xd\000\00000\000\000\000\000\000"
+/* offset=3D126319 */
+"target_cpu\000tool\0001 if CPUs being analyzed, 0 if threads/processes\00=
0config=3D0xe\000\00000\000\000\000\000\000"
+/* offset=3D126403 */
+"bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=3D0x8a\000\0000=
0\000\000\000\000\000"
+/* offset=3D126465 */
+"bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=3D0x8b\000\0000=
0\000\000\000\000\000"
+/* offset=3D126527 */
+"l3_cache_rd\000cache\000L3 cache access, read\000event=3D0x40\000\00000\0=
00\000\000\000Attributable Level 3 cache access, read\000"
+/* offset=3D126625 */
+"segment_reg_loads.any\000other\000Number of segment register loads\000eve=
nt=3D6,period=3D200000,umask=3D0x80\000\00000\000\000\000\000\000"
+/* offset=3D126727 */
+"dispatch_blocked.any\000other\000Memory cluster signals to block micro-op=
 dispatch for any reason\000event=3D9,period=3D200000,umask=3D0x20\000\0000=
0\000\000\000\000\000"
+/* offset=3D126860 */
+"eist_trans\000other\000Number of Enhanced Intel SpeedStep(R) Technology (=
EIST) transitions\000event=3D0x3a,period=3D200000\000\00000\000\000\000\000=
\000"
+/* offset=3D126978 */
+"hisi_sccl,ddrc\000"
+/* offset=3D126993 */
+"uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands\000event=3D2\=
000\00000\000\000\000\000\000"
+/* offset=3D127063 */
+"uncore_cbox\000"
+/* offset=3D127075 */
+"unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-core snoop resul=
ted from L3 Eviction which misses in some processor core\000event=3D0x22,um=
ask=3D0x81\000\00000\000\000\000\000\000"
+/* offset=3D127229 */
+"event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\000\00000\000\00=
0\000\000\000"
+/* offset=3D127283 */
+"event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0xc0\000\00000\00=
0\000\000\000\000"
+/* offset=3D127341 */
+"hisi_sccl,l3c\000"
+/* offset=3D127355 */
+"uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\000event=3D7\00=
0\00000\000\000\000\000\000"
+/* offset=3D127423 */
+"uncore_imc_free_running\000"
+/* offset=3D127447 */
+"uncore_imc_free_running.cache_miss\000uncore\000Total cache misses\000eve=
nt=3D0x12\000\00000\000\000\000\000\000"
+/* offset=3D127527 */
+"uncore_imc\000"
+/* offset=3D127538 */
+"uncore_imc.cache_hits\000uncore\000Total cache hits\000event=3D0x34\000\0=
0000\000\000\000\000\000"
+/* offset=3D127603 */
+"uncore_sys_ddr_pmu\000"
+/* offset=3D127622 */
+"sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles event\000event=3D0=
x2b\000v8\00000\000\000\000\000\000"
+/* offset=3D127698 */
+"uncore_sys_ccn_pmu\000"
+/* offset=3D127717 */
+"sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\000config=3D0x=
2c\0000x01\00000\000\000\000\000\000"
+/* offset=3D127794 */
+"uncore_sys_cmn_pmu\000"
+/* offset=3D127813 */
+"sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache misses in firs=
t lookup result (high priority)\000eventid=3D1,type=3D5\000(434|436|43c|43a=
).*\00000\000\000\000\000\000"
+/* offset=3D127956 */
+"CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=3Dcpu\\-clock@=
 if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@) / (dur=
ation_time * 1e9)\000\000Average CPU utilization\000\0001CPUs\000\000\000\0=
00011"
+/* offset=3D128142 */
+"cs_per_second\000Default\000software@context\\-switches\\,name\\=3Dcontex=
t\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #tar=
get_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\000\000Context=
 switches per CPU second\000\0001cs/sec\000\000\000\000011"
+/* offset=3D128375 */
+"migrations_per_second\000Default\000software@cpu\\-migrations\\,name\\=3D=
cpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if =
#target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\000\000Pro=
cess migrations to a new CPU per CPU second\000\0001migrations/sec\000\000\=
000\000011"
+/* offset=3D128635 */
+"page_faults_per_second\000Default\000software@page\\-faults\\,name\\=3Dpa=
ge\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #targ=
et_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\000\000Page fau=
lts per CPU second\000\0001faults/sec\000\000\000\000011"
+/* offset=3D128866 */
+"insn_per_cycle\000Default\000instructions / cpu\\-cycles\000insn_per_cycl=
e < 1\000Instructions Per Cycle\000\0001instructions\000\000\000\000001"
+/* offset=3D128979 */
+"stalled_cycles_per_instruction\000Default\000(max(stalled\\-cycles\\-fron=
tend, stalled\\-cycles\\-backend) / instructions if has_event(stalled\\-cyc=
les\\-frontend) & has_event(stalled\\-cycles\\-backend) else (stalled\\-cyc=
les\\-frontend / instructions if has_event(stalled\\-cycles\\-frontend) els=
e (stalled\\-cycles\\-backend / instructions if has_event(stalled\\-cycles\=
\-backend) else 0)))\000\000Max front or backend stalls per instruction\000=
\000\000\000\000\000001"
+/* offset=3D129404 */
+"frontend_cycles_idle\000Default\000(stalled\\-cycles\\-frontend / cpu\\-c=
ycles if has_event(stalled\\-cycles\\-frontend) else 0)\000frontend_cycles_=
idle > 0.1\000Frontend stalls per cycle\000\000\000\000\000\000001"
+/* offset=3D129583 */
+"backend_cycles_idle\000Default\000(stalled\\-cycles\\-backend / cpu\\-cyc=
les if has_event(stalled\\-cycles\\-backend) else 0)\000backend_cycles_idle=
 > 0.2\000Backend stalls per cycle\000\000\000\000\000\000001"
+/* offset=3D129757 */
+"cycles_frequency\000Default\000cpu\\-cycles / (software@cpu\\-clock\\,nam=
e\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtas=
k\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\000\000\000011"
+/* offset=3D129933 */
+"branch_frequency\000Default\000branches / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Branches per CPU second\000\0001000M/sec\000\000\000\000011=
"
+/* offset=3D130113 */
+"branch_miss_rate\000Default\000branch\\-misses / branches\000branch_miss_=
rate > 0.05\000Branch miss rate\000\000100%\000\000\000\000001"
+/* offset=3D130217 */
+"l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-misses / L1\\-dcache\\-=
loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000\000100%\000\000\000\000=
001"
+/* offset=3D130333 */
+"llc_miss_rate\000Default2\000LLC\\-load\\-misses / LLC\\-loads\000llc_mis=
s_rate > 0.05\000LLC miss rate\000\000100%\000\000\000\000001"
+/* offset=3D130434 */
+"l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-misses / L1\\-icache\\-=
loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\000100%\000\000\000\0000=
01"
+/* offset=3D130549 */
+"dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses / dTLB\\-loads\000dtlb=
_miss_rate > 0.05\000dTLB miss rate\000\000100%\000\000\000\000001"
+/* offset=3D130655 */
+"itlb_miss_rate\000Default3\000iTLB\\-load\\-misses / iTLB\\-loads\000itlb=
_miss_rate > 0.05\000iTLB miss rate\000\000100%\000\000\000\000001"
+/* offset=3D130761 */
+"l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-prefetch\\-misses / L1=
\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0.05\000L1 prefetch miss =
rate\000\000100%\000\000\000\000001"
+/* offset=3D130909 */
+"CPI\000\0001 / IPC\000\000\000\000\000\000\000\000000"
+/* offset=3D130932 */
+"IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\000\000\000\0=
00\000\000\000\000000"
+/* offset=3D130996 */
+"Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * (cpu_clk_unh=
alted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalt=
ed.ref_xclk)))\000\000\000\000\000\000\000\000000"
+/* offset=3D131163 */
+"dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.any\000\000\00=
0\000\000\000\000\000000"
+/* offset=3D131228 */
+"icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired.any\000\000=
\000\000\000\000\000\000000"
+/* offset=3D131296 */
+"cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_cycles\000\0=
00\000\000\000\000\000\000000"
+/* offset=3D131368 */
+"DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit +=
 l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000"
+/* offset=3D131463 */
+"DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd - l2_rqsts.dema=
nd_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000\000\000\000\0=
00\000\000\000000"
+/* offset=3D131598 */
+"DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\000\000\000\=
000\000\000\000\000000"
+/* offset=3D131663 */
+"DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2_All)\000\000\=
000\000\000\000\000\000000"
+/* offset=3D131732 */
+"DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_L2_All)\000\00=
0\000\000\000\000\000\000000"
+/* offset=3D131803 */
+"M1\000\000ipc + M2\000\000\000\000\000\000\000\000000"
+/* offset=3D131826 */
+"M2\000\000ipc + M1\000\000\000\000\000\000\000\000000"
+/* offset=3D131849 */
+"M3\000\0001 / M3\000\000\000\000\000\000\000\000000"
+/* offset=3D131870 */
+"L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duration_time\000\0=
00\000\000\000\000\000\000000"
 ;
=20
 static const struct compact_pmu_event pmu_events__common_default_core[] =
=3D {
-{ 111480 }, /* bpc\000legacy cache\000Branch prediction unit read accesses=
\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 113849 }, /* bpc-access\000legacy cache\000Branch prediction unit read a=
ccesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 111564 }, /* bpc-load\000legacy cache\000Branch prediction unit read acc=
esses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 111939 }, /* bpc-load-access\000legacy cache\000Branch prediction unit r=
ead accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 112135 }, /* bpc-load-miss\000legacy cache\000Branch prediction unit rea=
d misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000 */
-{ 112035 }, /* bpc-load-misses\000legacy cache\000Branch prediction unit r=
ead misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000 *=
/
-{ 111846 }, /* bpc-load-ops\000legacy cache\000Branch prediction unit read=
 accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 111747 }, /* bpc-load-reference\000legacy cache\000Branch prediction uni=
t read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 111653 }, /* bpc-load-refs\000legacy cache\000Branch prediction unit rea=
d accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 112233 }, /* bpc-loads\000legacy cache\000Branch prediction unit read ac=
cesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 112612 }, /* bpc-loads-access\000legacy cache\000Branch prediction unit =
read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 112810 }, /* bpc-loads-miss\000legacy cache\000Branch prediction unit re=
ad misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000 */
-{ 112709 }, /* bpc-loads-misses\000legacy cache\000Branch prediction unit =
read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000 =
*/
-{ 112518 }, /* bpc-loads-ops\000legacy cache\000Branch prediction unit rea=
d accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 112418 }, /* bpc-loads-reference\000legacy cache\000Branch prediction un=
it read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 *=
/
-{ 112323 }, /* bpc-loads-refs\000legacy cache\000Branch prediction unit re=
ad accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 114035 }, /* bpc-miss\000legacy cache\000Branch prediction unit read mis=
ses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000 */
-{ 113940 }, /* bpc-misses\000legacy cache\000Branch prediction unit read m=
isses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000 */
-{ 113761 }, /* bpc-ops\000legacy cache\000Branch prediction unit read acce=
sses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 112909 }, /* bpc-read\000legacy cache\000Branch prediction unit read acc=
esses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 113284 }, /* bpc-read-access\000legacy cache\000Branch prediction unit r=
ead accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 113480 }, /* bpc-read-miss\000legacy cache\000Branch prediction unit rea=
d misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000 */
-{ 113380 }, /* bpc-read-misses\000legacy cache\000Branch prediction unit r=
ead misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000 *=
/
-{ 113191 }, /* bpc-read-ops\000legacy cache\000Branch prediction unit read=
 accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 113092 }, /* bpc-read-reference\000legacy cache\000Branch prediction uni=
t read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 112998 }, /* bpc-read-refs\000legacy cache\000Branch prediction unit rea=
d accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 113667 }, /* bpc-reference\000legacy cache\000Branch prediction unit rea=
d accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 113578 }, /* bpc-refs\000legacy cache\000Branch prediction unit read acc=
esses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 106184 }, /* bpu\000legacy cache\000Branch prediction unit read accesses=
\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 108553 }, /* bpu-access\000legacy cache\000Branch prediction unit read a=
ccesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 106268 }, /* bpu-load\000legacy cache\000Branch prediction unit read acc=
esses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 106643 }, /* bpu-load-access\000legacy cache\000Branch prediction unit r=
ead accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 106839 }, /* bpu-load-miss\000legacy cache\000Branch prediction unit rea=
d misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000 */
-{ 106739 }, /* bpu-load-misses\000legacy cache\000Branch prediction unit r=
ead misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000 *=
/
-{ 106550 }, /* bpu-load-ops\000legacy cache\000Branch prediction unit read=
 accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 106451 }, /* bpu-load-reference\000legacy cache\000Branch prediction uni=
t read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 106357 }, /* bpu-load-refs\000legacy cache\000Branch prediction unit rea=
d accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 106937 }, /* bpu-loads\000legacy cache\000Branch prediction unit read ac=
cesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 107316 }, /* bpu-loads-access\000legacy cache\000Branch prediction unit =
read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 107514 }, /* bpu-loads-miss\000legacy cache\000Branch prediction unit re=
ad misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000 */
-{ 107413 }, /* bpu-loads-misses\000legacy cache\000Branch prediction unit =
read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000 =
*/
-{ 107222 }, /* bpu-loads-ops\000legacy cache\000Branch prediction unit rea=
d accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 107122 }, /* bpu-loads-reference\000legacy cache\000Branch prediction un=
it read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 *=
/
-{ 107027 }, /* bpu-loads-refs\000legacy cache\000Branch prediction unit re=
ad accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 108739 }, /* bpu-miss\000legacy cache\000Branch prediction unit read mis=
ses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000 */
-{ 108644 }, /* bpu-misses\000legacy cache\000Branch prediction unit read m=
isses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000 */
-{ 108465 }, /* bpu-ops\000legacy cache\000Branch prediction unit read acce=
sses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 107613 }, /* bpu-read\000legacy cache\000Branch prediction unit read acc=
esses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 107988 }, /* bpu-read-access\000legacy cache\000Branch prediction unit r=
ead accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 108184 }, /* bpu-read-miss\000legacy cache\000Branch prediction unit rea=
d misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000 */
-{ 108084 }, /* bpu-read-misses\000legacy cache\000Branch prediction unit r=
ead misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000 *=
/
-{ 107895 }, /* bpu-read-ops\000legacy cache\000Branch prediction unit read=
 accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 107796 }, /* bpu-read-reference\000legacy cache\000Branch prediction uni=
t read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 107702 }, /* bpu-read-refs\000legacy cache\000Branch prediction unit rea=
d accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 108371 }, /* bpu-reference\000legacy cache\000Branch prediction unit rea=
d accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 108282 }, /* bpu-refs\000legacy cache\000Branch prediction unit read acc=
esses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 100851 }, /* branch\000legacy cache\000Branch prediction unit read acces=
ses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 103295 }, /* branch-access\000legacy cache\000Branch prediction unit rea=
d accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 122452 }, /* branch-instructions\000legacy hardware\000Retired branch in=
structions [This event is an alias of branches]\000legacy-hardware-config=
=3D4\000\00000\000\000\000\000\000 */
-{ 100938 }, /* branch-load\000legacy cache\000Branch prediction unit read =
accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 101325 }, /* branch-load-access\000legacy cache\000Branch prediction uni=
t read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 101527 }, /* branch-load-miss\000legacy cache\000Branch prediction unit =
read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000 =
*/
-{ 101424 }, /* branch-load-misses\000legacy cache\000Branch prediction uni=
t read misses\000legacy-cache-config=3D0x10005\000\00000\000\000\000\000\00=
0 */
-{ 101229 }, /* branch-load-ops\000legacy cache\000Branch prediction unit r=
ead accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 101127 }, /* branch-load-reference\000legacy cache\000Branch prediction =
unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000=
 */
-{ 101030 }, /* branch-load-refs\000legacy cache\000Branch prediction unit =
read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 101628 }, /* branch-loads\000legacy cache\000Branch prediction unit read=
 accesses\000legacy-cache-config=3D5\000\00000\000\000\000\000\000 */
-{ 102019 }, /* branch-loads-access\000legacy cache\000Branch prediction un=
it read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 *=
/
-{ 102223 }, /* branch-loads-miss\000legacy cache\000Branch prediction unit=
 read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000=
 */
-{ 102119 }, /* branch-loads-misses\000legacy cache\000Branch prediction un=
it read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\0=
00 */
-{ 101922 }, /* branch-loads-ops\000legacy cache\000Branch prediction unit =
read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 101819 }, /* branch-loads-reference\000legacy cache\000Branch prediction=
 unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\00=
0 */
-{ 101721 }, /* branch-loads-refs\000legacy cache\000Branch prediction unit=
 read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 103389 }, /* branch-miss\000legacy cache\000Branch prediction unit read =
misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000 */
-{ 122586 }, /* branch-misses\000legacy hardware\000Mispredicted branch ins=
tructions\000legacy-hardware-config=3D5\000\00000\000\000\000\000\000 */
-{ 103204 }, /* branch-ops\000legacy cache\000Branch prediction unit read a=
ccesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 102325 }, /* branch-read\000legacy cache\000Branch prediction unit read =
accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 102712 }, /* branch-read-access\000legacy cache\000Branch prediction uni=
t read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 102914 }, /* branch-read-miss\000legacy cache\000Branch prediction unit =
read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000 =
*/
-{ 102811 }, /* branch-read-misses\000legacy cache\000Branch prediction uni=
t read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\00=
0 */
-{ 102616 }, /* branch-read-ops\000legacy cache\000Branch prediction unit r=
ead accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 102514 }, /* branch-read-reference\000legacy cache\000Branch prediction =
unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000=
 */
-{ 102417 }, /* branch-read-refs\000legacy cache\000Branch prediction unit =
read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 103107 }, /* branch-reference\000legacy cache\000Branch prediction unit =
read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 103015 }, /* branch-refs\000legacy cache\000Branch prediction unit read =
accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 122318 }, /* branches\000legacy hardware\000Retired branch instructions =
[This event is an alias of branch-instructions]\000legacy-hardware-config=
=3D4\000\00000\000\000\000\000\000 */
-{ 105890 }, /* branches-access\000legacy cache\000Branch prediction unit r=
ead accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 103485 }, /* branches-load\000legacy cache\000Branch prediction unit rea=
d accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 103880 }, /* branches-load-access\000legacy cache\000Branch prediction u=
nit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 =
*/
-{ 104086 }, /* branches-load-miss\000legacy cache\000Branch prediction uni=
t read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\00=
0 */
-{ 103981 }, /* branches-load-misses\000legacy cache\000Branch prediction u=
nit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\=
000 */
-{ 103782 }, /* branches-load-ops\000legacy cache\000Branch prediction unit=
 read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 103678 }, /* branches-load-reference\000legacy cache\000Branch predictio=
n unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\0=
00 */
-{ 103579 }, /* branches-load-refs\000legacy cache\000Branch prediction uni=
t read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 104189 }, /* branches-loads\000legacy cache\000Branch prediction unit re=
ad accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 104588 }, /* branches-loads-access\000legacy cache\000Branch prediction =
unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000=
 */
-{ 104796 }, /* branches-loads-miss\000legacy cache\000Branch prediction un=
it read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\0=
00 */
-{ 104690 }, /* branches-loads-misses\000legacy cache\000Branch prediction =
unit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000=
\000 */
-{ 104489 }, /* branches-loads-ops\000legacy cache\000Branch prediction uni=
t read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 104384 }, /* branches-loads-reference\000legacy cache\000Branch predicti=
on unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\=
000 */
-{ 104284 }, /* branches-loads-refs\000legacy cache\000Branch prediction un=
it read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 *=
/
-{ 106086 }, /* branches-miss\000legacy cache\000Branch prediction unit rea=
d misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000 */
-{ 105986 }, /* branches-misses\000legacy cache\000Branch prediction unit r=
ead misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000 *=
/
-{ 105797 }, /* branches-ops\000legacy cache\000Branch prediction unit read=
 accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 104900 }, /* branches-read\000legacy cache\000Branch prediction unit rea=
d accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 105295 }, /* branches-read-access\000legacy cache\000Branch prediction u=
nit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 =
*/
-{ 105501 }, /* branches-read-miss\000legacy cache\000Branch prediction uni=
t read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\00=
0 */
-{ 105396 }, /* branches-read-misses\000legacy cache\000Branch prediction u=
nit read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\=
000 */
-{ 105197 }, /* branches-read-ops\000legacy cache\000Branch prediction unit=
 read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 105093 }, /* branches-read-reference\000legacy cache\000Branch predictio=
n unit read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\0=
00 */
-{ 104994 }, /* branches-read-refs\000legacy cache\000Branch prediction uni=
t read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 105698 }, /* branches-reference\000legacy cache\000Branch prediction uni=
t read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 105604 }, /* branches-refs\000legacy cache\000Branch prediction unit rea=
d accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 108832 }, /* btb\000legacy cache\000Branch prediction unit read accesses=
\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 111201 }, /* btb-access\000legacy cache\000Branch prediction unit read a=
ccesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 108916 }, /* btb-load\000legacy cache\000Branch prediction unit read acc=
esses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 109291 }, /* btb-load-access\000legacy cache\000Branch prediction unit r=
ead accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 109487 }, /* btb-load-miss\000legacy cache\000Branch prediction unit rea=
d misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000 */
-{ 109387 }, /* btb-load-misses\000legacy cache\000Branch prediction unit r=
ead misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000 *=
/
-{ 109198 }, /* btb-load-ops\000legacy cache\000Branch prediction unit read=
 accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 109099 }, /* btb-load-reference\000legacy cache\000Branch prediction uni=
t read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 109005 }, /* btb-load-refs\000legacy cache\000Branch prediction unit rea=
d accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 109585 }, /* btb-loads\000legacy cache\000Branch prediction unit read ac=
cesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 109964 }, /* btb-loads-access\000legacy cache\000Branch prediction unit =
read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 110162 }, /* btb-loads-miss\000legacy cache\000Branch prediction unit re=
ad misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000 */
-{ 110061 }, /* btb-loads-misses\000legacy cache\000Branch prediction unit =
read misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000 =
*/
-{ 109870 }, /* btb-loads-ops\000legacy cache\000Branch prediction unit rea=
d accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 109770 }, /* btb-loads-reference\000legacy cache\000Branch prediction un=
it read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 *=
/
-{ 109675 }, /* btb-loads-refs\000legacy cache\000Branch prediction unit re=
ad accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 111387 }, /* btb-miss\000legacy cache\000Branch prediction unit read mis=
ses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000 */
-{ 111292 }, /* btb-misses\000legacy cache\000Branch prediction unit read m=
isses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000 */
-{ 111113 }, /* btb-ops\000legacy cache\000Branch prediction unit read acce=
sses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 110261 }, /* btb-read\000legacy cache\000Branch prediction unit read acc=
esses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 110636 }, /* btb-read-access\000legacy cache\000Branch prediction unit r=
ead accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 110832 }, /* btb-read-miss\000legacy cache\000Branch prediction unit rea=
d misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000 */
-{ 110732 }, /* btb-read-misses\000legacy cache\000Branch prediction unit r=
ead misses\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000 *=
/
-{ 110543 }, /* btb-read-ops\000legacy cache\000Branch prediction unit read=
 accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 110444 }, /* btb-read-reference\000legacy cache\000Branch prediction uni=
t read accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 110350 }, /* btb-read-refs\000legacy cache\000Branch prediction unit rea=
d accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 111019 }, /* btb-reference\000legacy cache\000Branch prediction unit rea=
d accesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 110930 }, /* btb-refs\000legacy cache\000Branch prediction unit read acc=
esses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000 */
-{ 122682 }, /* bus-cycles\000legacy hardware\000Bus cycles, which can be d=
ifferent from total cycles\000legacy-hardware-config=3D6\000\00000\000\000\=
000\000\000 */
-{ 122075 }, /* cache-misses\000legacy hardware\000Cache misses. Usually th=
is indicates Last Level Cache misses; this is intended to be used in conjun=
ction with the PERF_COUNT_HW_CACHE_REFERENCES event to calculate cache miss=
 rates\000legacy-hardware-config=3D3\000\00000\000\000\000\000\000 */
-{ 121805 }, /* cache-references\000legacy hardware\000Cache accesses. Usua=
lly this indicates Last Level Cache accesses but this may vary depending on=
 your CPU.  This may include prefetches and coherency messages; again this =
depends on the design of your CPU\000legacy-hardware-config=3D2\000\00000\0=
00\000\000\000\000 */
-{ 121305 }, /* cpu-cycles\000legacy hardware\000Total cycles. Be wary of w=
hat happens during CPU frequency scaling [This event is an alias of cycles]=
\000legacy-hardware-config=3D0\000\00000\000\000\000\000\000 */
-{ 121467 }, /* cycles\000legacy hardware\000Total cycles. Be wary of what =
happens during CPU frequency scaling [This event is an alias of cpu-cycles]=
\000legacy-hardware-config=3D0\000\00000\000\000\000\000\000 */
-{ 78952 }, /* d-tlb\000legacy cache\000Data TLB read accesses\000legacy-ca=
che-config=3D3\000\00010\000\000\000\000\000 */
-{ 85655 }, /* d-tlb-access\000legacy cache\000Data TLB read accesses\000le=
gacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 79024 }, /* d-tlb-load\000legacy cache\000Data TLB read accesses\000lega=
cy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 79351 }, /* d-tlb-load-access\000legacy cache\000Data TLB read accesses\=
000legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 79523 }, /* d-tlb-load-miss\000legacy cache\000Data TLB read misses\000l=
egacy-cache-config=3D0x10003\000\00010\000\000\000\000\000 */
-{ 79435 }, /* d-tlb-load-misses\000legacy cache\000Data TLB read misses\00=
0legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000 */
-{ 79270 }, /* d-tlb-load-ops\000legacy cache\000Data TLB read accesses\000=
legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 79183 }, /* d-tlb-load-reference\000legacy cache\000Data TLB read access=
es\000legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 79101 }, /* d-tlb-load-refs\000legacy cache\000Data TLB read accesses\00=
0legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 79609 }, /* d-tlb-loads\000legacy cache\000Data TLB read accesses\000leg=
acy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 79940 }, /* d-tlb-loads-access\000legacy cache\000Data TLB read accesses=
\000legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 80114 }, /* d-tlb-loads-miss\000legacy cache\000Data TLB read misses\000=
legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000 */
-{ 80025 }, /* d-tlb-loads-misses\000legacy cache\000Data TLB read misses\0=
00legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000 */
-{ 79858 }, /* d-tlb-loads-ops\000legacy cache\000Data TLB read accesses\00=
0legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 79770 }, /* d-tlb-loads-reference\000legacy cache\000Data TLB read acces=
ses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 79687 }, /* d-tlb-loads-refs\000legacy cache\000Data TLB read accesses\0=
00legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 85817 }, /* d-tlb-miss\000legacy cache\000Data TLB read misses\000legacy=
-cache-config=3D0x10003\000\00010\000\000\000\000\000 */
-{ 85734 }, /* d-tlb-misses\000legacy cache\000Data TLB read misses\000lega=
cy-cache-config=3D0x10003\000\00010\000\000\000\000\000 */
-{ 85579 }, /* d-tlb-ops\000legacy cache\000Data TLB read accesses\000legac=
y-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 82650 }, /* d-tlb-prefetch\000legacy cache\000Data TLB prefetch accesses=
\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 */
-{ 83025 }, /* d-tlb-prefetch-access\000legacy cache\000Data TLB prefetch a=
ccesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 */
-{ 83217 }, /* d-tlb-prefetch-miss\000legacy cache\000Data TLB prefetch mis=
ses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000 */
-{ 83121 }, /* d-tlb-prefetch-misses\000legacy cache\000Data TLB prefetch m=
isses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000 */
-{ 82932 }, /* d-tlb-prefetch-ops\000legacy cache\000Data TLB prefetch acce=
sses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 */
-{ 82833 }, /* d-tlb-prefetch-reference\000legacy cache\000Data TLB prefetc=
h accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 */
-{ 82739 }, /* d-tlb-prefetch-refs\000legacy cache\000Data TLB prefetch acc=
esses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 */
-{ 83311 }, /* d-tlb-prefetches\000legacy cache\000Data TLB prefetch access=
es\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 */
-{ 83694 }, /* d-tlb-prefetches-access\000legacy cache\000Data TLB prefetch=
 accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 */
-{ 83890 }, /* d-tlb-prefetches-miss\000legacy cache\000Data TLB prefetch m=
isses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000 */
-{ 83792 }, /* d-tlb-prefetches-misses\000legacy cache\000Data TLB prefetch=
 misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000 */
-{ 83599 }, /* d-tlb-prefetches-ops\000legacy cache\000Data TLB prefetch ac=
cesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 */
-{ 83498 }, /* d-tlb-prefetches-reference\000legacy cache\000Data TLB prefe=
tch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 *=
/
-{ 83402 }, /* d-tlb-prefetches-refs\000legacy cache\000Data TLB prefetch a=
ccesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 */
-{ 80201 }, /* d-tlb-read\000legacy cache\000Data TLB read accesses\000lega=
cy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 80528 }, /* d-tlb-read-access\000legacy cache\000Data TLB read accesses\=
000legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 80700 }, /* d-tlb-read-miss\000legacy cache\000Data TLB read misses\000l=
egacy-cache-config=3D0x10003\000\00010\000\000\000\000\000 */
-{ 80612 }, /* d-tlb-read-misses\000legacy cache\000Data TLB read misses\00=
0legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000 */
-{ 80447 }, /* d-tlb-read-ops\000legacy cache\000Data TLB read accesses\000=
legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 80360 }, /* d-tlb-read-reference\000legacy cache\000Data TLB read access=
es\000legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 80278 }, /* d-tlb-read-refs\000legacy cache\000Data TLB read accesses\00=
0legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 85497 }, /* d-tlb-reference\000legacy cache\000Data TLB read accesses\00=
0legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 85420 }, /* d-tlb-refs\000legacy cache\000Data TLB read accesses\000lega=
cy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 84703 }, /* d-tlb-speculative-load\000legacy cache\000Data TLB prefetch =
accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 */
-{ 85110 }, /* d-tlb-speculative-load-access\000legacy cache\000Data TLB pr=
efetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\00=
0 */
-{ 85318 }, /* d-tlb-speculative-load-miss\000legacy cache\000Data TLB pref=
etch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000 =
*/
-{ 85214 }, /* d-tlb-speculative-load-misses\000legacy cache\000Data TLB pr=
efetch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\00=
0 */
-{ 85009 }, /* d-tlb-speculative-load-ops\000legacy cache\000Data TLB prefe=
tch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 *=
/
-{ 84902 }, /* d-tlb-speculative-load-reference\000legacy cache\000Data TLB=
 prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000=
\000 */
-{ 84800 }, /* d-tlb-speculative-load-refs\000legacy cache\000Data TLB pref=
etch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 =
*/
-{ 83986 }, /* d-tlb-speculative-read\000legacy cache\000Data TLB prefetch =
accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 */
-{ 84393 }, /* d-tlb-speculative-read-access\000legacy cache\000Data TLB pr=
efetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\00=
0 */
-{ 84601 }, /* d-tlb-speculative-read-miss\000legacy cache\000Data TLB pref=
etch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000 =
*/
-{ 84497 }, /* d-tlb-speculative-read-misses\000legacy cache\000Data TLB pr=
efetch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\00=
0 */
-{ 84292 }, /* d-tlb-speculative-read-ops\000legacy cache\000Data TLB prefe=
tch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 *=
/
-{ 84185 }, /* d-tlb-speculative-read-reference\000legacy cache\000Data TLB=
 prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000=
\000 */
-{ 84083 }, /* d-tlb-speculative-read-refs\000legacy cache\000Data TLB pref=
etch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 =
*/
-{ 80786 }, /* d-tlb-store\000legacy cache\000Data TLB write accesses\000le=
gacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 81137 }, /* d-tlb-store-access\000legacy cache\000Data TLB write accesse=
s\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 81317 }, /* d-tlb-store-miss\000legacy cache\000Data TLB write misses\00=
0legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000 */
-{ 81227 }, /* d-tlb-store-misses\000legacy cache\000Data TLB write misses\=
000legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000 */
-{ 81050 }, /* d-tlb-store-ops\000legacy cache\000Data TLB write accesses\0=
00legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 80957 }, /* d-tlb-store-reference\000legacy cache\000Data TLB write acce=
sses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 80869 }, /* d-tlb-store-refs\000legacy cache\000Data TLB write accesses\=
000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 81405 }, /* d-tlb-stores\000legacy cache\000Data TLB write accesses\000l=
egacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 81760 }, /* d-tlb-stores-access\000legacy cache\000Data TLB write access=
es\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 81942 }, /* d-tlb-stores-miss\000legacy cache\000Data TLB write misses\0=
00legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000 */
-{ 81851 }, /* d-tlb-stores-misses\000legacy cache\000Data TLB write misses=
\000legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000 */
-{ 81672 }, /* d-tlb-stores-ops\000legacy cache\000Data TLB write accesses\=
000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 81578 }, /* d-tlb-stores-reference\000legacy cache\000Data TLB write acc=
esses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 81489 }, /* d-tlb-stores-refs\000legacy cache\000Data TLB write accesses=
\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 82031 }, /* d-tlb-write\000legacy cache\000Data TLB write accesses\000le=
gacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 82382 }, /* d-tlb-write-access\000legacy cache\000Data TLB write accesse=
s\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 82562 }, /* d-tlb-write-miss\000legacy cache\000Data TLB write misses\00=
0legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000 */
-{ 82472 }, /* d-tlb-write-misses\000legacy cache\000Data TLB write misses\=
000legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000 */
-{ 82295 }, /* d-tlb-write-ops\000legacy cache\000Data TLB write accesses\0=
00legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 82202 }, /* d-tlb-write-reference\000legacy cache\000Data TLB write acce=
sses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 82114 }, /* d-tlb-write-refs\000legacy cache\000Data TLB write accesses\=
000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 85898 }, /* data-tlb\000legacy cache\000Data TLB read accesses\000legacy=
-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 92823 }, /* data-tlb-access\000legacy cache\000Data TLB read accesses\00=
0legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 85973 }, /* data-tlb-load\000legacy cache\000Data TLB read accesses\000l=
egacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 86312 }, /* data-tlb-load-access\000legacy cache\000Data TLB read access=
es\000legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 86490 }, /* data-tlb-load-miss\000legacy cache\000Data TLB read misses\0=
00legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000 */
-{ 86399 }, /* data-tlb-load-misses\000legacy cache\000Data TLB read misses=
\000legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000 */
-{ 86228 }, /* data-tlb-load-ops\000legacy cache\000Data TLB read accesses\=
000legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 86138 }, /* data-tlb-load-reference\000legacy cache\000Data TLB read acc=
esses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 86053 }, /* data-tlb-load-refs\000legacy cache\000Data TLB read accesses=
\000legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 86579 }, /* data-tlb-loads\000legacy cache\000Data TLB read accesses\000=
legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 86922 }, /* data-tlb-loads-access\000legacy cache\000Data TLB read acces=
ses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 87102 }, /* data-tlb-loads-miss\000legacy cache\000Data TLB read misses\=
000legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000 */
-{ 87010 }, /* data-tlb-loads-misses\000legacy cache\000Data TLB read misse=
s\000legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000 */
-{ 86837 }, /* data-tlb-loads-ops\000legacy cache\000Data TLB read accesses=
\000legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 86746 }, /* data-tlb-loads-reference\000legacy cache\000Data TLB read ac=
cesses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 86660 }, /* data-tlb-loads-refs\000legacy cache\000Data TLB read accesse=
s\000legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 92991 }, /* data-tlb-miss\000legacy cache\000Data TLB read misses\000leg=
acy-cache-config=3D0x10003\000\00010\000\000\000\000\000 */
-{ 92905 }, /* data-tlb-misses\000legacy cache\000Data TLB read misses\000l=
egacy-cache-config=3D0x10003\000\00010\000\000\000\000\000 */
-{ 92744 }, /* data-tlb-ops\000legacy cache\000Data TLB read accesses\000le=
gacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 89725 }, /* data-tlb-prefetch\000legacy cache\000Data TLB prefetch acces=
ses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 */
-{ 90112 }, /* data-tlb-prefetch-access\000legacy cache\000Data TLB prefetc=
h accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 */
-{ 90310 }, /* data-tlb-prefetch-miss\000legacy cache\000Data TLB prefetch =
misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000 */
-{ 90211 }, /* data-tlb-prefetch-misses\000legacy cache\000Data TLB prefetc=
h misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000 */
-{ 90016 }, /* data-tlb-prefetch-ops\000legacy cache\000Data TLB prefetch a=
ccesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 */
-{ 89914 }, /* data-tlb-prefetch-reference\000legacy cache\000Data TLB pref=
etch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 =
*/
-{ 89817 }, /* data-tlb-prefetch-refs\000legacy cache\000Data TLB prefetch =
accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 */
-{ 90407 }, /* data-tlb-prefetches\000legacy cache\000Data TLB prefetch acc=
esses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 */
-{ 90802 }, /* data-tlb-prefetches-access\000legacy cache\000Data TLB prefe=
tch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 *=
/
-{ 91004 }, /* data-tlb-prefetches-miss\000legacy cache\000Data TLB prefetc=
h misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000 */
-{ 90903 }, /* data-tlb-prefetches-misses\000legacy cache\000Data TLB prefe=
tch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000 *=
/
-{ 90704 }, /* data-tlb-prefetches-ops\000legacy cache\000Data TLB prefetch=
 accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 */
-{ 90600 }, /* data-tlb-prefetches-reference\000legacy cache\000Data TLB pr=
efetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\00=
0 */
-{ 90501 }, /* data-tlb-prefetches-refs\000legacy cache\000Data TLB prefetc=
h accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 */
-{ 87192 }, /* data-tlb-read\000legacy cache\000Data TLB read accesses\000l=
egacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 87531 }, /* data-tlb-read-access\000legacy cache\000Data TLB read access=
es\000legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 87709 }, /* data-tlb-read-miss\000legacy cache\000Data TLB read misses\0=
00legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000 */
-{ 87618 }, /* data-tlb-read-misses\000legacy cache\000Data TLB read misses=
\000legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000 */
-{ 87447 }, /* data-tlb-read-ops\000legacy cache\000Data TLB read accesses\=
000legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 87357 }, /* data-tlb-read-reference\000legacy cache\000Data TLB read acc=
esses\000legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 87272 }, /* data-tlb-read-refs\000legacy cache\000Data TLB read accesses=
\000legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 92659 }, /* data-tlb-reference\000legacy cache\000Data TLB read accesses=
\000legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 92579 }, /* data-tlb-refs\000legacy cache\000Data TLB read accesses\000l=
egacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 91841 }, /* data-tlb-speculative-load\000legacy cache\000Data TLB prefet=
ch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 */
-{ 92260 }, /* data-tlb-speculative-load-access\000legacy cache\000Data TLB=
 prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000=
\000 */
-{ 92474 }, /* data-tlb-speculative-load-miss\000legacy cache\000Data TLB p=
refetch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\0=
00 */
-{ 92367 }, /* data-tlb-speculative-load-misses\000legacy cache\000Data TLB=
 prefetch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000=
\000 */
-{ 92156 }, /* data-tlb-speculative-load-ops\000legacy cache\000Data TLB pr=
efetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\00=
0 */
-{ 92046 }, /* data-tlb-speculative-load-reference\000legacy cache\000Data =
TLB prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\=
000\000 */
-{ 91941 }, /* data-tlb-speculative-load-refs\000legacy cache\000Data TLB p=
refetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\0=
00 */
-{ 91103 }, /* data-tlb-speculative-read\000legacy cache\000Data TLB prefet=
ch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 */
-{ 91522 }, /* data-tlb-speculative-read-access\000legacy cache\000Data TLB=
 prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000=
\000 */
-{ 91736 }, /* data-tlb-speculative-read-miss\000legacy cache\000Data TLB p=
refetch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\0=
00 */
-{ 91629 }, /* data-tlb-speculative-read-misses\000legacy cache\000Data TLB=
 prefetch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000=
\000 */
-{ 91418 }, /* data-tlb-speculative-read-ops\000legacy cache\000Data TLB pr=
efetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\00=
0 */
-{ 91308 }, /* data-tlb-speculative-read-reference\000legacy cache\000Data =
TLB prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\=
000\000 */
-{ 91203 }, /* data-tlb-speculative-read-refs\000legacy cache\000Data TLB p=
refetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\0=
00 */
-{ 87798 }, /* data-tlb-store\000legacy cache\000Data TLB write accesses\00=
0legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 88161 }, /* data-tlb-store-access\000legacy cache\000Data TLB write acce=
sses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 88347 }, /* data-tlb-store-miss\000legacy cache\000Data TLB write misses=
\000legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000 */
-{ 88254 }, /* data-tlb-store-misses\000legacy cache\000Data TLB write miss=
es\000legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000 */
-{ 88071 }, /* data-tlb-store-ops\000legacy cache\000Data TLB write accesse=
s\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 87975 }, /* data-tlb-store-reference\000legacy cache\000Data TLB write a=
ccesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 87884 }, /* data-tlb-store-refs\000legacy cache\000Data TLB write access=
es\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 88438 }, /* data-tlb-stores\000legacy cache\000Data TLB write accesses\0=
00legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 88805 }, /* data-tlb-stores-access\000legacy cache\000Data TLB write acc=
esses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 88993 }, /* data-tlb-stores-miss\000legacy cache\000Data TLB write misse=
s\000legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000 */
-{ 88899 }, /* data-tlb-stores-misses\000legacy cache\000Data TLB write mis=
ses\000legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000 */
-{ 88714 }, /* data-tlb-stores-ops\000legacy cache\000Data TLB write access=
es\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 88617 }, /* data-tlb-stores-reference\000legacy cache\000Data TLB write =
accesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 88525 }, /* data-tlb-stores-refs\000legacy cache\000Data TLB write acces=
ses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 89085 }, /* data-tlb-write\000legacy cache\000Data TLB write accesses\00=
0legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 89448 }, /* data-tlb-write-access\000legacy cache\000Data TLB write acce=
sses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 89634 }, /* data-tlb-write-miss\000legacy cache\000Data TLB write misses=
\000legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000 */
-{ 89541 }, /* data-tlb-write-misses\000legacy cache\000Data TLB write miss=
es\000legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000 */
-{ 89358 }, /* data-tlb-write-ops\000legacy cache\000Data TLB write accesse=
s\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 89262 }, /* data-tlb-write-reference\000legacy cache\000Data TLB write a=
ccesses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 89171 }, /* data-tlb-write-refs\000legacy cache\000Data TLB write access=
es\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 72083 }, /* dtlb\000legacy cache\000Data TLB read accesses\000legacy-cac=
he-config=3D3\000\00010\000\000\000\000\000 */
-{ 78712 }, /* dtlb-access\000legacy cache\000Data TLB read accesses\000leg=
acy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 72154 }, /* dtlb-load\000legacy cache\000Data TLB read accesses\000legac=
y-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 72477 }, /* dtlb-load-access\000legacy cache\000Data TLB read accesses\0=
00legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 72647 }, /* dtlb-load-miss\000legacy cache\000Data TLB read misses\000le=
gacy-cache-config=3D0x10003\000\00010\000\000\000\000\000 */
-{ 72560 }, /* dtlb-load-misses\000legacy cache\000Data TLB read misses\000=
legacy-cache-config=3D0x10003\000\00000\000\000\000\000\000 */
-{ 72397 }, /* dtlb-load-ops\000legacy cache\000Data TLB read accesses\000l=
egacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 72311 }, /* dtlb-load-reference\000legacy cache\000Data TLB read accesse=
s\000legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 72230 }, /* dtlb-load-refs\000legacy cache\000Data TLB read accesses\000=
legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 72732 }, /* dtlb-loads\000legacy cache\000Data TLB read accesses\000lega=
cy-cache-config=3D3\000\00000\000\000\000\000\000 */
-{ 73059 }, /* dtlb-loads-access\000legacy cache\000Data TLB read accesses\=
000legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 73231 }, /* dtlb-loads-miss\000legacy cache\000Data TLB read misses\000l=
egacy-cache-config=3D0x10003\000\00010\000\000\000\000\000 */
-{ 73143 }, /* dtlb-loads-misses\000legacy cache\000Data TLB read misses\00=
0legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000 */
-{ 72978 }, /* dtlb-loads-ops\000legacy cache\000Data TLB read accesses\000=
legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 72891 }, /* dtlb-loads-reference\000legacy cache\000Data TLB read access=
es\000legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 72809 }, /* dtlb-loads-refs\000legacy cache\000Data TLB read accesses\00=
0legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 78872 }, /* dtlb-miss\000legacy cache\000Data TLB read misses\000legacy-=
cache-config=3D0x10003\000\00010\000\000\000\000\000 */
-{ 78790 }, /* dtlb-misses\000legacy cache\000Data TLB read misses\000legac=
y-cache-config=3D0x10003\000\00010\000\000\000\000\000 */
-{ 78637 }, /* dtlb-ops\000legacy cache\000Data TLB read accesses\000legacy=
-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 75738 }, /* dtlb-prefetch\000legacy cache\000Data TLB prefetch accesses\=
000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 */
-{ 76109 }, /* dtlb-prefetch-access\000legacy cache\000Data TLB prefetch ac=
cesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 */
-{ 76299 }, /* dtlb-prefetch-miss\000legacy cache\000Data TLB prefetch miss=
es\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000 */
-{ 76204 }, /* dtlb-prefetch-misses\000legacy cache\000Data TLB prefetch mi=
sses\000legacy-cache-config=3D0x10203\000\00000\000\000\000\000\000 */
-{ 76017 }, /* dtlb-prefetch-ops\000legacy cache\000Data TLB prefetch acces=
ses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 */
-{ 75919 }, /* dtlb-prefetch-reference\000legacy cache\000Data TLB prefetch=
 accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 */
-{ 75826 }, /* dtlb-prefetch-refs\000legacy cache\000Data TLB prefetch acce=
sses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 */
-{ 76392 }, /* dtlb-prefetches\000legacy cache\000Data TLB prefetch accesse=
s\000legacy-cache-config=3D0x203\000\00000\000\000\000\000\000 */
-{ 76771 }, /* dtlb-prefetches-access\000legacy cache\000Data TLB prefetch =
accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 */
-{ 76965 }, /* dtlb-prefetches-miss\000legacy cache\000Data TLB prefetch mi=
sses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000 */
-{ 76868 }, /* dtlb-prefetches-misses\000legacy cache\000Data TLB prefetch =
misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000 */
-{ 76677 }, /* dtlb-prefetches-ops\000legacy cache\000Data TLB prefetch acc=
esses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 */
-{ 76577 }, /* dtlb-prefetches-reference\000legacy cache\000Data TLB prefet=
ch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 */
-{ 76482 }, /* dtlb-prefetches-refs\000legacy cache\000Data TLB prefetch ac=
cesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 */
-{ 73317 }, /* dtlb-read\000legacy cache\000Data TLB read accesses\000legac=
y-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 73640 }, /* dtlb-read-access\000legacy cache\000Data TLB read accesses\0=
00legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 73810 }, /* dtlb-read-miss\000legacy cache\000Data TLB read misses\000le=
gacy-cache-config=3D0x10003\000\00010\000\000\000\000\000 */
-{ 73723 }, /* dtlb-read-misses\000legacy cache\000Data TLB read misses\000=
legacy-cache-config=3D0x10003\000\00010\000\000\000\000\000 */
-{ 73560 }, /* dtlb-read-ops\000legacy cache\000Data TLB read accesses\000l=
egacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 73474 }, /* dtlb-read-reference\000legacy cache\000Data TLB read accesse=
s\000legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 73393 }, /* dtlb-read-refs\000legacy cache\000Data TLB read accesses\000=
legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 78556 }, /* dtlb-reference\000legacy cache\000Data TLB read accesses\000=
legacy-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 78480 }, /* dtlb-refs\000legacy cache\000Data TLB read accesses\000legac=
y-cache-config=3D3\000\00010\000\000\000\000\000 */
-{ 77770 }, /* dtlb-speculative-load\000legacy cache\000Data TLB prefetch a=
ccesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 */
-{ 78173 }, /* dtlb-speculative-load-access\000legacy cache\000Data TLB pre=
fetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000=
 */
-{ 78379 }, /* dtlb-speculative-load-miss\000legacy cache\000Data TLB prefe=
tch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000 *=
/
-{ 78276 }, /* dtlb-speculative-load-misses\000legacy cache\000Data TLB pre=
fetch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000=
 */
-{ 78073 }, /* dtlb-speculative-load-ops\000legacy cache\000Data TLB prefet=
ch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 */
-{ 77967 }, /* dtlb-speculative-load-reference\000legacy cache\000Data TLB =
prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\=
000 */
-{ 77866 }, /* dtlb-speculative-load-refs\000legacy cache\000Data TLB prefe=
tch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 *=
/
-{ 77060 }, /* dtlb-speculative-read\000legacy cache\000Data TLB prefetch a=
ccesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 */
-{ 77463 }, /* dtlb-speculative-read-access\000legacy cache\000Data TLB pre=
fetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000=
 */
-{ 77669 }, /* dtlb-speculative-read-miss\000legacy cache\000Data TLB prefe=
tch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000 *=
/
-{ 77566 }, /* dtlb-speculative-read-misses\000legacy cache\000Data TLB pre=
fetch misses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000=
 */
-{ 77363 }, /* dtlb-speculative-read-ops\000legacy cache\000Data TLB prefet=
ch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 */
-{ 77257 }, /* dtlb-speculative-read-reference\000legacy cache\000Data TLB =
prefetch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\=
000 */
-{ 77156 }, /* dtlb-speculative-read-refs\000legacy cache\000Data TLB prefe=
tch accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000 *=
/
-{ 73895 }, /* dtlb-store\000legacy cache\000Data TLB write accesses\000leg=
acy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 74242 }, /* dtlb-store-access\000legacy cache\000Data TLB write accesses=
\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 74420 }, /* dtlb-store-miss\000legacy cache\000Data TLB write misses\000=
legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000 */
-{ 74331 }, /* dtlb-store-misses\000legacy cache\000Data TLB write misses\0=
00legacy-cache-config=3D0x10103\000\00000\000\000\000\000\000 */
-{ 74156 }, /* dtlb-store-ops\000legacy cache\000Data TLB write accesses\00=
0legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 74064 }, /* dtlb-store-reference\000legacy cache\000Data TLB write acces=
ses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 73977 }, /* dtlb-store-refs\000legacy cache\000Data TLB write accesses\0=
00legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 74507 }, /* dtlb-stores\000legacy cache\000Data TLB write accesses\000le=
gacy-cache-config=3D0x103\000\00000\000\000\000\000\000 */
-{ 74858 }, /* dtlb-stores-access\000legacy cache\000Data TLB write accesse=
s\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 75038 }, /* dtlb-stores-miss\000legacy cache\000Data TLB write misses\00=
0legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000 */
-{ 74948 }, /* dtlb-stores-misses\000legacy cache\000Data TLB write misses\=
000legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000 */
-{ 74771 }, /* dtlb-stores-ops\000legacy cache\000Data TLB write accesses\0=
00legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 74678 }, /* dtlb-stores-reference\000legacy cache\000Data TLB write acce=
sses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 74590 }, /* dtlb-stores-refs\000legacy cache\000Data TLB write accesses\=
000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 75126 }, /* dtlb-write\000legacy cache\000Data TLB write accesses\000leg=
acy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 75473 }, /* dtlb-write-access\000legacy cache\000Data TLB write accesses=
\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 75651 }, /* dtlb-write-miss\000legacy cache\000Data TLB write misses\000=
legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000 */
-{ 75562 }, /* dtlb-write-misses\000legacy cache\000Data TLB write misses\0=
00legacy-cache-config=3D0x10103\000\00010\000\000\000\000\000 */
-{ 75387 }, /* dtlb-write-ops\000legacy cache\000Data TLB write accesses\00=
0legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 75295 }, /* dtlb-write-reference\000legacy cache\000Data TLB write acces=
ses\000legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 75208 }, /* dtlb-write-refs\000legacy cache\000Data TLB write accesses\0=
00legacy-cache-config=3D0x103\000\00010\000\000\000\000\000 */
-{ 95555 }, /* i-tlb\000legacy cache\000Instruction TLB read accesses\000le=
gacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 97799 }, /* i-tlb-access\000legacy cache\000Instruction TLB read accesse=
s\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 95634 }, /* i-tlb-load\000legacy cache\000Instruction TLB read accesses\=
000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 95989 }, /* i-tlb-load-access\000legacy cache\000Instruction TLB read ac=
cesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 96175 }, /* i-tlb-load-miss\000legacy cache\000Instruction TLB read miss=
es\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000 */
-{ 96080 }, /* i-tlb-load-misses\000legacy cache\000Instruction TLB read mi=
sses\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000 */
-{ 95901 }, /* i-tlb-load-ops\000legacy cache\000Instruction TLB read acces=
ses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 95807 }, /* i-tlb-load-reference\000legacy cache\000Instruction TLB read=
 accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 95718 }, /* i-tlb-load-refs\000legacy cache\000Instruction TLB read acce=
sses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 96268 }, /* i-tlb-loads\000legacy cache\000Instruction TLB read accesses=
\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 96627 }, /* i-tlb-loads-access\000legacy cache\000Instruction TLB read a=
ccesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 96815 }, /* i-tlb-loads-miss\000legacy cache\000Instruction TLB read mis=
ses\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000 */
-{ 96719 }, /* i-tlb-loads-misses\000legacy cache\000Instruction TLB read m=
isses\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000 */
-{ 96538 }, /* i-tlb-loads-ops\000legacy cache\000Instruction TLB read acce=
sses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 96443 }, /* i-tlb-loads-reference\000legacy cache\000Instruction TLB rea=
d accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 96353 }, /* i-tlb-loads-refs\000legacy cache\000Instruction TLB read acc=
esses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 97975 }, /* i-tlb-miss\000legacy cache\000Instruction TLB read misses\00=
0legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000 */
-{ 97885 }, /* i-tlb-misses\000legacy cache\000Instruction TLB read misses\=
000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000 */
-{ 97716 }, /* i-tlb-ops\000legacy cache\000Instruction TLB read accesses\0=
00legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 96909 }, /* i-tlb-read\000legacy cache\000Instruction TLB read accesses\=
000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 97264 }, /* i-tlb-read-access\000legacy cache\000Instruction TLB read ac=
cesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 97450 }, /* i-tlb-read-miss\000legacy cache\000Instruction TLB read miss=
es\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000 */
-{ 97355 }, /* i-tlb-read-misses\000legacy cache\000Instruction TLB read mi=
sses\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000 */
-{ 97176 }, /* i-tlb-read-ops\000legacy cache\000Instruction TLB read acces=
ses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 97082 }, /* i-tlb-read-reference\000legacy cache\000Instruction TLB read=
 accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 96993 }, /* i-tlb-read-refs\000legacy cache\000Instruction TLB read acce=
sses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 97627 }, /* i-tlb-reference\000legacy cache\000Instruction TLB read acce=
sses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 97543 }, /* i-tlb-refs\000legacy cache\000Instruction TLB read accesses\=
000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 123247 }, /* idle-cycles-backend\000legacy hardware\000Stalled cycles du=
ring retirement [This event is an alias of stalled-cycles-backend]\000legac=
y-hardware-config=3D8\000\00000\000\000\000\000\000 */
-{ 122945 }, /* idle-cycles-frontend\000legacy hardware\000Stalled cycles d=
uring issue [This event is an alias of stalled-cycles-fronted]\000legacy-ha=
rdware-config=3D7\000\00000\000\000\000\000\000 */
-{ 98063 }, /* instruction-tlb\000legacy cache\000Instruction TLB read acce=
sses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 100557 }, /* instruction-tlb-access\000legacy cache\000Instruction TLB r=
ead accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 98152 }, /* instruction-tlb-load\000legacy cache\000Instruction TLB read=
 accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 98547 }, /* instruction-tlb-load-access\000legacy cache\000Instruction T=
LB read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 *=
/
-{ 98753 }, /* instruction-tlb-load-miss\000legacy cache\000Instruction TLB=
 read misses\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000=
 */
-{ 98648 }, /* instruction-tlb-load-misses\000legacy cache\000Instruction T=
LB read misses\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\0=
00 */
-{ 98449 }, /* instruction-tlb-load-ops\000legacy cache\000Instruction TLB =
read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 98345 }, /* instruction-tlb-load-reference\000legacy cache\000Instructio=
n TLB read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\00=
0 */
-{ 98246 }, /* instruction-tlb-load-refs\000legacy cache\000Instruction TLB=
 read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 98856 }, /* instruction-tlb-loads\000legacy cache\000Instruction TLB rea=
d accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 99255 }, /* instruction-tlb-loads-access\000legacy cache\000Instruction =
TLB read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 =
*/
-{ 99463 }, /* instruction-tlb-loads-miss\000legacy cache\000Instruction TL=
B read misses\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\00=
0 */
-{ 99357 }, /* instruction-tlb-loads-misses\000legacy cache\000Instruction =
TLB read misses\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\=
000 */
-{ 99156 }, /* instruction-tlb-loads-ops\000legacy cache\000Instruction TLB=
 read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 99051 }, /* instruction-tlb-loads-reference\000legacy cache\000Instructi=
on TLB read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\0=
00 */
-{ 98951 }, /* instruction-tlb-loads-refs\000legacy cache\000Instruction TL=
B read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 100753 }, /* instruction-tlb-miss\000legacy cache\000Instruction TLB rea=
d misses\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000 */
-{ 100653 }, /* instruction-tlb-misses\000legacy cache\000Instruction TLB r=
ead misses\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000 *=
/
-{ 100464 }, /* instruction-tlb-ops\000legacy cache\000Instruction TLB read=
 accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 99567 }, /* instruction-tlb-read\000legacy cache\000Instruction TLB read=
 accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 99962 }, /* instruction-tlb-read-access\000legacy cache\000Instruction T=
LB read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 *=
/
-{ 100168 }, /* instruction-tlb-read-miss\000legacy cache\000Instruction TL=
B read misses\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\00=
0 */
-{ 100063 }, /* instruction-tlb-read-misses\000legacy cache\000Instruction =
TLB read misses\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\=
000 */
-{ 99864 }, /* instruction-tlb-read-ops\000legacy cache\000Instruction TLB =
read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 99760 }, /* instruction-tlb-read-reference\000legacy cache\000Instructio=
n TLB read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\00=
0 */
-{ 99661 }, /* instruction-tlb-read-refs\000legacy cache\000Instruction TLB=
 read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 100365 }, /* instruction-tlb-reference\000legacy cache\000Instruction TL=
B read accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 100271 }, /* instruction-tlb-refs\000legacy cache\000Instruction TLB rea=
d accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 121629 }, /* instructions\000legacy hardware\000Retired instructions. Be=
 careful, these can be affected by various issues, most notably hardware in=
terrupt counts\000legacy-hardware-config=3D1\000\00000\000\000\000\000\000 =
*/
-{ 93075 }, /* itlb\000legacy cache\000Instruction TLB read accesses\000leg=
acy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 95294 }, /* itlb-access\000legacy cache\000Instruction TLB read accesses=
\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 93153 }, /* itlb-load\000legacy cache\000Instruction TLB read accesses\0=
00legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 93504 }, /* itlb-load-access\000legacy cache\000Instruction TLB read acc=
esses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 93688 }, /* itlb-load-miss\000legacy cache\000Instruction TLB read misse=
s\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000 */
-{ 93594 }, /* itlb-load-misses\000legacy cache\000Instruction TLB read mis=
ses\000legacy-cache-config=3D0x10004\000\00000\000\000\000\000\000 */
-{ 93417 }, /* itlb-load-ops\000legacy cache\000Instruction TLB read access=
es\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 93324 }, /* itlb-load-reference\000legacy cache\000Instruction TLB read =
accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 93236 }, /* itlb-load-refs\000legacy cache\000Instruction TLB read acces=
ses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 93780 }, /* itlb-loads\000legacy cache\000Instruction TLB read accesses\=
000legacy-cache-config=3D4\000\00000\000\000\000\000\000 */
-{ 94135 }, /* itlb-loads-access\000legacy cache\000Instruction TLB read ac=
cesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 94321 }, /* itlb-loads-miss\000legacy cache\000Instruction TLB read miss=
es\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000 */
-{ 94226 }, /* itlb-loads-misses\000legacy cache\000Instruction TLB read mi=
sses\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000 */
-{ 94047 }, /* itlb-loads-ops\000legacy cache\000Instruction TLB read acces=
ses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 93953 }, /* itlb-loads-reference\000legacy cache\000Instruction TLB read=
 accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 93864 }, /* itlb-loads-refs\000legacy cache\000Instruction TLB read acce=
sses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 95468 }, /* itlb-miss\000legacy cache\000Instruction TLB read misses\000=
legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000 */
-{ 95379 }, /* itlb-misses\000legacy cache\000Instruction TLB read misses\0=
00legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000 */
-{ 95212 }, /* itlb-ops\000legacy cache\000Instruction TLB read accesses\00=
0legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 94414 }, /* itlb-read\000legacy cache\000Instruction TLB read accesses\0=
00legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 94765 }, /* itlb-read-access\000legacy cache\000Instruction TLB read acc=
esses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 94949 }, /* itlb-read-miss\000legacy cache\000Instruction TLB read misse=
s\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000 */
-{ 94855 }, /* itlb-read-misses\000legacy cache\000Instruction TLB read mis=
ses\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000 */
-{ 94678 }, /* itlb-read-ops\000legacy cache\000Instruction TLB read access=
es\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 94585 }, /* itlb-read-reference\000legacy cache\000Instruction TLB read =
accesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 94497 }, /* itlb-read-refs\000legacy cache\000Instruction TLB read acces=
ses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 95124 }, /* itlb-reference\000legacy cache\000Instruction TLB read acces=
ses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 95041 }, /* itlb-refs\000legacy cache\000Instruction TLB read accesses\0=
00legacy-cache-config=3D4\000\00010\000\000\000\000\000 */
-{ 8037 }, /* l1-d\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 15406 }, /* l1-d-access\000legacy cache\000Level 1 data cache read acces=
ses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 8118 }, /* l1-d-load\000legacy cache\000Level 1 data cache read accesses=
\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 8481 }, /* l1-d-load-access\000legacy cache\000Level 1 data cache read a=
ccesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 8671 }, /* l1-d-load-miss\000legacy cache\000Level 1 data cache read mis=
ses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000 */
-{ 8574 }, /* l1-d-load-misses\000legacy cache\000Level 1 data cache read m=
isses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000 */
-{ 8391 }, /* l1-d-load-ops\000legacy cache\000Level 1 data cache read acce=
sses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 8295 }, /* l1-d-load-reference\000legacy cache\000Level 1 data cache rea=
d accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 8204 }, /* l1-d-load-refs\000legacy cache\000Level 1 data cache read acc=
esses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 8766 }, /* l1-d-loads\000legacy cache\000Level 1 data cache read accesse=
s\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 9133 }, /* l1-d-loads-access\000legacy cache\000Level 1 data cache read =
accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 9325 }, /* l1-d-loads-miss\000legacy cache\000Level 1 data cache read mi=
sses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000 */
-{ 9227 }, /* l1-d-loads-misses\000legacy cache\000Level 1 data cache read =
misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000 */
-{ 9042 }, /* l1-d-loads-ops\000legacy cache\000Level 1 data cache read acc=
esses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 8945 }, /* l1-d-loads-reference\000legacy cache\000Level 1 data cache re=
ad accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 8853 }, /* l1-d-loads-refs\000legacy cache\000Level 1 data cache read ac=
cesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 15586 }, /* l1-d-miss\000legacy cache\000Level 1 data cache read misses\=
000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000 */
-{ 15494 }, /* l1-d-misses\000legacy cache\000Level 1 data cache read misse=
s\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000 */
-{ 15321 }, /* l1-d-ops\000legacy cache\000Level 1 data cache read accesses=
\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 12122 }, /* l1-d-prefetch\000legacy cache\000Level 1 data cache prefetch=
 accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000 */
-{ 12533 }, /* l1-d-prefetch-access\000legacy cache\000Level 1 data cache p=
refetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\0=
00 */
-{ 12743 }, /* l1-d-prefetch-miss\000legacy cache\000Level 1 data cache pre=
fetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000=
 */
-{ 12638 }, /* l1-d-prefetch-misses\000legacy cache\000Level 1 data cache p=
refetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\0=
00 */
-{ 12431 }, /* l1-d-prefetch-ops\000legacy cache\000Level 1 data cache pref=
etch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000 =
*/
-{ 12323 }, /* l1-d-prefetch-reference\000legacy cache\000Level 1 data cach=
e prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\00=
0\000 */
-{ 12220 }, /* l1-d-prefetch-refs\000legacy cache\000Level 1 data cache pre=
fetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000=
 */
-{ 12846 }, /* l1-d-prefetches\000legacy cache\000Level 1 data cache prefet=
ch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000 */
-{ 13265 }, /* l1-d-prefetches-access\000legacy cache\000Level 1 data cache=
 prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000=
\000 */
-{ 13479 }, /* l1-d-prefetches-miss\000legacy cache\000Level 1 data cache p=
refetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\0=
00 */
-{ 13372 }, /* l1-d-prefetches-misses\000legacy cache\000Level 1 data cache=
 prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000=
\000 */
-{ 13161 }, /* l1-d-prefetches-ops\000legacy cache\000Level 1 data cache pr=
efetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\00=
0 */
-{ 13051 }, /* l1-d-prefetches-reference\000legacy cache\000Level 1 data ca=
che prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\=
000\000 */
-{ 12946 }, /* l1-d-prefetches-refs\000legacy cache\000Level 1 data cache p=
refetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\0=
00 */
-{ 9421 }, /* l1-d-read\000legacy cache\000Level 1 data cache read accesses=
\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 9784 }, /* l1-d-read-access\000legacy cache\000Level 1 data cache read a=
ccesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 9974 }, /* l1-d-read-miss\000legacy cache\000Level 1 data cache read mis=
ses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000 */
-{ 9877 }, /* l1-d-read-misses\000legacy cache\000Level 1 data cache read m=
isses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000 */
-{ 9694 }, /* l1-d-read-ops\000legacy cache\000Level 1 data cache read acce=
sses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 9598 }, /* l1-d-read-reference\000legacy cache\000Level 1 data cache rea=
d accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 9507 }, /* l1-d-read-refs\000legacy cache\000Level 1 data cache read acc=
esses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 15230 }, /* l1-d-reference\000legacy cache\000Level 1 data cache read ac=
cesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 15144 }, /* l1-d-refs\000legacy cache\000Level 1 data cache read accesse=
s\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 14364 }, /* l1-d-speculative-load\000legacy cache\000Level 1 data cache =
prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\=
000 */
-{ 14807 }, /* l1-d-speculative-load-access\000legacy cache\000Level 1 data=
 cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\0=
00\000\000 */
-{ 15033 }, /* l1-d-speculative-load-miss\000legacy cache\000Level 1 data c=
ache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000=
\000\000 */
-{ 14920 }, /* l1-d-speculative-load-misses\000legacy cache\000Level 1 data=
 cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\0=
00\000\000 */
-{ 14697 }, /* l1-d-speculative-load-ops\000legacy cache\000Level 1 data ca=
che prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\=
000\000 */
-{ 14581 }, /* l1-d-speculative-load-reference\000legacy cache\000Level 1 d=
ata cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\00=
0\000\000\000 */
-{ 14470 }, /* l1-d-speculative-load-refs\000legacy cache\000Level 1 data c=
ache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000=
\000\000 */
-{ 13584 }, /* l1-d-speculative-read\000legacy cache\000Level 1 data cache =
prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\=
000 */
-{ 14027 }, /* l1-d-speculative-read-access\000legacy cache\000Level 1 data=
 cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\0=
00\000\000 */
-{ 14253 }, /* l1-d-speculative-read-miss\000legacy cache\000Level 1 data c=
ache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000=
\000\000 */
-{ 14140 }, /* l1-d-speculative-read-misses\000legacy cache\000Level 1 data=
 cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\0=
00\000\000 */
-{ 13917 }, /* l1-d-speculative-read-ops\000legacy cache\000Level 1 data ca=
che prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\=
000\000 */
-{ 13801 }, /* l1-d-speculative-read-reference\000legacy cache\000Level 1 d=
ata cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\00=
0\000\000\000 */
-{ 13690 }, /* l1-d-speculative-read-refs\000legacy cache\000Level 1 data c=
ache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000=
\000\000 */
-{ 10069 }, /* l1-d-store\000legacy cache\000Level 1 data cache write acces=
ses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 10456 }, /* l1-d-store-access\000legacy cache\000Level 1 data cache writ=
e accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 10654 }, /* l1-d-store-miss\000legacy cache\000Level 1 data cache write =
misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000 */
-{ 10555 }, /* l1-d-store-misses\000legacy cache\000Level 1 data cache writ=
e misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000 */
-{ 10360 }, /* l1-d-store-ops\000legacy cache\000Level 1 data cache write a=
ccesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 10258 }, /* l1-d-store-reference\000legacy cache\000Level 1 data cache w=
rite accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 =
*/
-{ 10161 }, /* l1-d-store-refs\000legacy cache\000Level 1 data cache write =
accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 10751 }, /* l1-d-stores\000legacy cache\000Level 1 data cache write acce=
sses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 11142 }, /* l1-d-stores-access\000legacy cache\000Level 1 data cache wri=
te accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 11342 }, /* l1-d-stores-miss\000legacy cache\000Level 1 data cache write=
 misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000 */
-{ 11242 }, /* l1-d-stores-misses\000legacy cache\000Level 1 data cache wri=
te misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000 */
-{ 11045 }, /* l1-d-stores-ops\000legacy cache\000Level 1 data cache write =
accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 10942 }, /* l1-d-stores-reference\000legacy cache\000Level 1 data cache =
write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000=
 */
-{ 10844 }, /* l1-d-stores-refs\000legacy cache\000Level 1 data cache write=
 accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 11440 }, /* l1-d-write\000legacy cache\000Level 1 data cache write acces=
ses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 11827 }, /* l1-d-write-access\000legacy cache\000Level 1 data cache writ=
e accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 12025 }, /* l1-d-write-miss\000legacy cache\000Level 1 data cache write =
misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000 */
-{ 11926 }, /* l1-d-write-misses\000legacy cache\000Level 1 data cache writ=
e misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000 */
-{ 11731 }, /* l1-d-write-ops\000legacy cache\000Level 1 data cache write a=
ccesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 11629 }, /* l1-d-write-reference\000legacy cache\000Level 1 data cache w=
rite accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 =
*/
-{ 11532 }, /* l1-d-write-refs\000legacy cache\000Level 1 data cache write =
accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 23238 }, /* l1-data\000legacy cache\000Level 1 data cache read accesses\=
000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 30829 }, /* l1-data-access\000legacy cache\000Level 1 data cache read ac=
cesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 23322 }, /* l1-data-load\000legacy cache\000Level 1 data cache read acce=
sses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 23697 }, /* l1-data-load-access\000legacy cache\000Level 1 data cache re=
ad accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 23893 }, /* l1-data-load-miss\000legacy cache\000Level 1 data cache read=
 misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000 */
-{ 23793 }, /* l1-data-load-misses\000legacy cache\000Level 1 data cache re=
ad misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000 */
-{ 23604 }, /* l1-data-load-ops\000legacy cache\000Level 1 data cache read =
accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 23505 }, /* l1-data-load-reference\000legacy cache\000Level 1 data cache=
 read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 23411 }, /* l1-data-load-refs\000legacy cache\000Level 1 data cache read=
 accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 23991 }, /* l1-data-loads\000legacy cache\000Level 1 data cache read acc=
esses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 24370 }, /* l1-data-loads-access\000legacy cache\000Level 1 data cache r=
ead accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 24568 }, /* l1-data-loads-miss\000legacy cache\000Level 1 data cache rea=
d misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000 */
-{ 24467 }, /* l1-data-loads-misses\000legacy cache\000Level 1 data cache r=
ead misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000 *=
/
-{ 24276 }, /* l1-data-loads-ops\000legacy cache\000Level 1 data cache read=
 accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 24176 }, /* l1-data-loads-reference\000legacy cache\000Level 1 data cach=
e read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 24081 }, /* l1-data-loads-refs\000legacy cache\000Level 1 data cache rea=
d accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 31015 }, /* l1-data-miss\000legacy cache\000Level 1 data cache read miss=
es\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000 */
-{ 30920 }, /* l1-data-misses\000legacy cache\000Level 1 data cache read mi=
sses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000 */
-{ 30741 }, /* l1-data-ops\000legacy cache\000Level 1 data cache read acces=
ses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 27452 }, /* l1-data-prefetch\000legacy cache\000Level 1 data cache prefe=
tch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000 *=
/
-{ 27875 }, /* l1-data-prefetch-access\000legacy cache\000Level 1 data cach=
e prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\00=
0\000 */
-{ 28091 }, /* l1-data-prefetch-miss\000legacy cache\000Level 1 data cache =
prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\=
000 */
-{ 27983 }, /* l1-data-prefetch-misses\000legacy cache\000Level 1 data cach=
e prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\00=
0\000 */
-{ 27770 }, /* l1-data-prefetch-ops\000legacy cache\000Level 1 data cache p=
refetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\0=
00 */
-{ 27659 }, /* l1-data-prefetch-reference\000legacy cache\000Level 1 data c=
ache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000=
\000\000 */
-{ 27553 }, /* l1-data-prefetch-refs\000legacy cache\000Level 1 data cache =
prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\=
000 */
-{ 28197 }, /* l1-data-prefetches\000legacy cache\000Level 1 data cache pre=
fetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000=
 */
-{ 28628 }, /* l1-data-prefetches-access\000legacy cache\000Level 1 data ca=
che prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\=
000\000 */
-{ 28848 }, /* l1-data-prefetches-miss\000legacy cache\000Level 1 data cach=
e prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\00=
0\000 */
-{ 28738 }, /* l1-data-prefetches-misses\000legacy cache\000Level 1 data ca=
che prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\=
000\000 */
-{ 28521 }, /* l1-data-prefetches-ops\000legacy cache\000Level 1 data cache=
 prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000=
\000 */
-{ 28408 }, /* l1-data-prefetches-reference\000legacy cache\000Level 1 data=
 cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\0=
00\000\000 */
-{ 28300 }, /* l1-data-prefetches-refs\000legacy cache\000Level 1 data cach=
e prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\00=
0\000 */
-{ 24667 }, /* l1-data-read\000legacy cache\000Level 1 data cache read acce=
sses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 25042 }, /* l1-data-read-access\000legacy cache\000Level 1 data cache re=
ad accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 25238 }, /* l1-data-read-miss\000legacy cache\000Level 1 data cache read=
 misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000 */
-{ 25138 }, /* l1-data-read-misses\000legacy cache\000Level 1 data cache re=
ad misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000 */
-{ 24949 }, /* l1-data-read-ops\000legacy cache\000Level 1 data cache read =
accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 24850 }, /* l1-data-read-reference\000legacy cache\000Level 1 data cache=
 read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 24756 }, /* l1-data-read-refs\000legacy cache\000Level 1 data cache read=
 accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 30647 }, /* l1-data-reference\000legacy cache\000Level 1 data cache read=
 accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 30558 }, /* l1-data-refs\000legacy cache\000Level 1 data cache read acce=
sses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 29757 }, /* l1-data-speculative-load\000legacy cache\000Level 1 data cac=
he prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\0=
00\000 */
-{ 30212 }, /* l1-data-speculative-load-access\000legacy cache\000Level 1 d=
ata cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\00=
0\000\000\000 */
-{ 30444 }, /* l1-data-speculative-load-miss\000legacy cache\000Level 1 dat=
a cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\=
000\000\000 */
-{ 30328 }, /* l1-data-speculative-load-misses\000legacy cache\000Level 1 d=
ata cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\00=
0\000\000\000 */
-{ 30099 }, /* l1-data-speculative-load-ops\000legacy cache\000Level 1 data=
 cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\0=
00\000\000 */
-{ 29980 }, /* l1-data-speculative-load-reference\000legacy cache\000Level =
1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000=
\000\000\000\000 */
-{ 29866 }, /* l1-data-speculative-load-refs\000legacy cache\000Level 1 dat=
a cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\=
000\000\000 */
-{ 28956 }, /* l1-data-speculative-read\000legacy cache\000Level 1 data cac=
he prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\0=
00\000 */
-{ 29411 }, /* l1-data-speculative-read-access\000legacy cache\000Level 1 d=
ata cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\00=
0\000\000\000 */
-{ 29643 }, /* l1-data-speculative-read-miss\000legacy cache\000Level 1 dat=
a cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\=
000\000\000 */
-{ 29527 }, /* l1-data-speculative-read-misses\000legacy cache\000Level 1 d=
ata cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\00=
0\000\000\000 */
-{ 29298 }, /* l1-data-speculative-read-ops\000legacy cache\000Level 1 data=
 cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\0=
00\000\000 */
-{ 29179 }, /* l1-data-speculative-read-reference\000legacy cache\000Level =
1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000=
\000\000\000\000 */
-{ 29065 }, /* l1-data-speculative-read-refs\000legacy cache\000Level 1 dat=
a cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\=
000\000\000 */
-{ 25336 }, /* l1-data-store\000legacy cache\000Level 1 data cache write ac=
cesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 25735 }, /* l1-data-store-access\000legacy cache\000Level 1 data cache w=
rite accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 =
*/
-{ 25939 }, /* l1-data-store-miss\000legacy cache\000Level 1 data cache wri=
te misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000 */
-{ 25837 }, /* l1-data-store-misses\000legacy cache\000Level 1 data cache w=
rite misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000 =
*/
-{ 25636 }, /* l1-data-store-ops\000legacy cache\000Level 1 data cache writ=
e accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 25531 }, /* l1-data-store-reference\000legacy cache\000Level 1 data cach=
e write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\0=
00 */
-{ 25431 }, /* l1-data-store-refs\000legacy cache\000Level 1 data cache wri=
te accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 26039 }, /* l1-data-stores\000legacy cache\000Level 1 data cache write a=
ccesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 26442 }, /* l1-data-stores-access\000legacy cache\000Level 1 data cache =
write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000=
 */
-{ 26648 }, /* l1-data-stores-miss\000legacy cache\000Level 1 data cache wr=
ite misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000 *=
/
-{ 26545 }, /* l1-data-stores-misses\000legacy cache\000Level 1 data cache =
write misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000=
 */
-{ 26342 }, /* l1-data-stores-ops\000legacy cache\000Level 1 data cache wri=
te accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 26236 }, /* l1-data-stores-reference\000legacy cache\000Level 1 data cac=
he write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\=
000 */
-{ 26135 }, /* l1-data-stores-refs\000legacy cache\000Level 1 data cache wr=
ite accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 *=
/
-{ 26749 }, /* l1-data-write\000legacy cache\000Level 1 data cache write ac=
cesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 27148 }, /* l1-data-write-access\000legacy cache\000Level 1 data cache w=
rite accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 =
*/
-{ 27352 }, /* l1-data-write-miss\000legacy cache\000Level 1 data cache wri=
te misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000 */
-{ 27250 }, /* l1-data-write-misses\000legacy cache\000Level 1 data cache w=
rite misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000 =
*/
-{ 27049 }, /* l1-data-write-ops\000legacy cache\000Level 1 data cache writ=
e accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 26944 }, /* l1-data-write-reference\000legacy cache\000Level 1 data cach=
e write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\0=
00 */
-{ 26844 }, /* l1-data-write-refs\000legacy cache\000Level 1 data cache wri=
te accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 13 }, /* l1-dcache\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 7752 }, /* l1-dcache-access\000legacy cache\000Level 1 data cache read a=
ccesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 99 }, /* l1-dcache-load\000legacy cache\000Level 1 data cache read acces=
ses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 482 }, /* l1-dcache-load-access\000legacy cache\000Level 1 data cache re=
ad accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 682 }, /* l1-dcache-load-miss\000legacy cache\000Level 1 data cache read=
 misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000 */
-{ 580 }, /* l1-dcache-load-misses\000legacy cache\000Level 1 data cache re=
ad misses\000legacy-cache-config=3D0x10000\000\00000\000\000\000\000\000 */
-{ 387 }, /* l1-dcache-load-ops\000legacy cache\000Level 1 data cache read =
accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 286 }, /* l1-dcache-load-reference\000legacy cache\000Level 1 data cache=
 read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 190 }, /* l1-dcache-load-refs\000legacy cache\000Level 1 data cache read=
 accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 782 }, /* l1-dcache-loads\000legacy cache\000Level 1 data cache read acc=
esses\000legacy-cache-config=3D0\000\00000\000\000\000\000\000 */
-{ 1169 }, /* l1-dcache-loads-access\000legacy cache\000Level 1 data cache =
read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 1371 }, /* l1-dcache-loads-miss\000legacy cache\000Level 1 data cache re=
ad misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000 */
-{ 1268 }, /* l1-dcache-loads-misses\000legacy cache\000Level 1 data cache =
read misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000 =
*/
-{ 1073 }, /* l1-dcache-loads-ops\000legacy cache\000Level 1 data cache rea=
d accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 971 }, /* l1-dcache-loads-reference\000legacy cache\000Level 1 data cach=
e read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 874 }, /* l1-dcache-loads-refs\000legacy cache\000Level 1 data cache rea=
d accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 7942 }, /* l1-dcache-miss\000legacy cache\000Level 1 data cache read mis=
ses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000 */
-{ 7845 }, /* l1-dcache-misses\000legacy cache\000Level 1 data cache read m=
isses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000 */
-{ 7662 }, /* l1-dcache-ops\000legacy cache\000Level 1 data cache read acce=
sses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 4313 }, /* l1-dcache-prefetch\000legacy cache\000Level 1 data cache pref=
etch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000 =
*/
-{ 4744 }, /* l1-dcache-prefetch-access\000legacy cache\000Level 1 data cac=
he prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\0=
00\000 */
-{ 4964 }, /* l1-dcache-prefetch-miss\000legacy cache\000Level 1 data cache=
 prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000=
\000 */
-{ 4854 }, /* l1-dcache-prefetch-misses\000legacy cache\000Level 1 data cac=
he prefetch misses\000legacy-cache-config=3D0x10200\000\00000\000\000\000\0=
00\000 */
-{ 4637 }, /* l1-dcache-prefetch-ops\000legacy cache\000Level 1 data cache =
prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\=
000 */
-{ 4524 }, /* l1-dcache-prefetch-reference\000legacy cache\000Level 1 data =
cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\00=
0\000\000 */
-{ 4416 }, /* l1-dcache-prefetch-refs\000legacy cache\000Level 1 data cache=
 prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000=
\000 */
-{ 5072 }, /* l1-dcache-prefetches\000legacy cache\000Level 1 data cache pr=
efetch accesses\000legacy-cache-config=3D0x200\000\00000\000\000\000\000\00=
0 */
-{ 5511 }, /* l1-dcache-prefetches-access\000legacy cache\000Level 1 data c=
ache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000=
\000\000 */
-{ 5735 }, /* l1-dcache-prefetches-miss\000legacy cache\000Level 1 data cac=
he prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\0=
00\000 */
-{ 5623 }, /* l1-dcache-prefetches-misses\000legacy cache\000Level 1 data c=
ache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000=
\000\000 */
-{ 5402 }, /* l1-dcache-prefetches-ops\000legacy cache\000Level 1 data cach=
e prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\00=
0\000 */
-{ 5287 }, /* l1-dcache-prefetches-reference\000legacy cache\000Level 1 dat=
a cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\=
000\000\000 */
-{ 5177 }, /* l1-dcache-prefetches-refs\000legacy cache\000Level 1 data cac=
he prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\0=
00\000 */
-{ 1472 }, /* l1-dcache-read\000legacy cache\000Level 1 data cache read acc=
esses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 1855 }, /* l1-dcache-read-access\000legacy cache\000Level 1 data cache r=
ead accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 2055 }, /* l1-dcache-read-miss\000legacy cache\000Level 1 data cache rea=
d misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000 */
-{ 1953 }, /* l1-dcache-read-misses\000legacy cache\000Level 1 data cache r=
ead misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000 *=
/
-{ 1760 }, /* l1-dcache-read-ops\000legacy cache\000Level 1 data cache read=
 accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 1659 }, /* l1-dcache-read-reference\000legacy cache\000Level 1 data cach=
e read accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 1563 }, /* l1-dcache-read-refs\000legacy cache\000Level 1 data cache rea=
d accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 7566 }, /* l1-dcache-reference\000legacy cache\000Level 1 data cache rea=
d accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 7475 }, /* l1-dcache-refs\000legacy cache\000Level 1 data cache read acc=
esses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 6660 }, /* l1-dcache-speculative-load\000legacy cache\000Level 1 data ca=
che prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\=
000\000 */
-{ 7123 }, /* l1-dcache-speculative-load-access\000legacy cache\000Level 1 =
data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\0=
00\000\000\000 */
-{ 7359 }, /* l1-dcache-speculative-load-miss\000legacy cache\000Level 1 da=
ta cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000=
\000\000\000 */
-{ 7241 }, /* l1-dcache-speculative-load-misses\000legacy cache\000Level 1 =
data cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\0=
00\000\000\000 */
-{ 7008 }, /* l1-dcache-speculative-load-ops\000legacy cache\000Level 1 dat=
a cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\=
000\000\000 */
-{ 6887 }, /* l1-dcache-speculative-load-reference\000legacy cache\000Level=
 1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\00=
0\000\000\000\000 */
-{ 6771 }, /* l1-dcache-speculative-load-refs\000legacy cache\000Level 1 da=
ta cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000=
\000\000\000 */
-{ 5845 }, /* l1-dcache-speculative-read\000legacy cache\000Level 1 data ca=
che prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\=
000\000 */
-{ 6308 }, /* l1-dcache-speculative-read-access\000legacy cache\000Level 1 =
data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\0=
00\000\000\000 */
-{ 6544 }, /* l1-dcache-speculative-read-miss\000legacy cache\000Level 1 da=
ta cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000=
\000\000\000 */
-{ 6426 }, /* l1-dcache-speculative-read-misses\000legacy cache\000Level 1 =
data cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\0=
00\000\000\000 */
-{ 6193 }, /* l1-dcache-speculative-read-ops\000legacy cache\000Level 1 dat=
a cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\=
000\000\000 */
-{ 6072 }, /* l1-dcache-speculative-read-reference\000legacy cache\000Level=
 1 data cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\00=
0\000\000\000\000 */
-{ 5956 }, /* l1-dcache-speculative-read-refs\000legacy cache\000Level 1 da=
ta cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000=
\000\000\000 */
-{ 2155 }, /* l1-dcache-store\000legacy cache\000Level 1 data cache write a=
ccesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 2562 }, /* l1-dcache-store-access\000legacy cache\000Level 1 data cache =
write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000=
 */
-{ 2770 }, /* l1-dcache-store-miss\000legacy cache\000Level 1 data cache wr=
ite misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000 *=
/
-{ 2666 }, /* l1-dcache-store-misses\000legacy cache\000Level 1 data cache =
write misses\000legacy-cache-config=3D0x10100\000\00000\000\000\000\000\000=
 */
-{ 2461 }, /* l1-dcache-store-ops\000legacy cache\000Level 1 data cache wri=
te accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 2354 }, /* l1-dcache-store-reference\000legacy cache\000Level 1 data cac=
he write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\=
000 */
-{ 2252 }, /* l1-dcache-store-refs\000legacy cache\000Level 1 data cache wr=
ite accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 *=
/
-{ 2872 }, /* l1-dcache-stores\000legacy cache\000Level 1 data cache write =
accesses\000legacy-cache-config=3D0x100\000\00000\000\000\000\000\000 */
-{ 3283 }, /* l1-dcache-stores-access\000legacy cache\000Level 1 data cache=
 write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\00=
0 */
-{ 3493 }, /* l1-dcache-stores-miss\000legacy cache\000Level 1 data cache w=
rite misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000 =
*/
-{ 3388 }, /* l1-dcache-stores-misses\000legacy cache\000Level 1 data cache=
 write misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\00=
0 */
-{ 3181 }, /* l1-dcache-stores-ops\000legacy cache\000Level 1 data cache wr=
ite accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 *=
/
-{ 3073 }, /* l1-dcache-stores-reference\000legacy cache\000Level 1 data ca=
che write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000=
\000 */
-{ 2970 }, /* l1-dcache-stores-refs\000legacy cache\000Level 1 data cache w=
rite accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 =
*/
-{ 3596 }, /* l1-dcache-write\000legacy cache\000Level 1 data cache write a=
ccesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 4003 }, /* l1-dcache-write-access\000legacy cache\000Level 1 data cache =
write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000=
 */
-{ 4211 }, /* l1-dcache-write-miss\000legacy cache\000Level 1 data cache wr=
ite misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000 *=
/
-{ 4107 }, /* l1-dcache-write-misses\000legacy cache\000Level 1 data cache =
write misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000=
 */
-{ 3902 }, /* l1-dcache-write-ops\000legacy cache\000Level 1 data cache wri=
te accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 3795 }, /* l1-dcache-write-reference\000legacy cache\000Level 1 data cac=
he write accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\=
000 */
-{ 3693 }, /* l1-dcache-write-refs\000legacy cache\000Level 1 data cache wr=
ite accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 *=
/
-{ 37366 }, /* l1-i\000legacy cache\000Level 1 instruction cache read acces=
ses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 43053 }, /* l1-i-access\000legacy cache\000Level 1 instruction cache rea=
d accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 37454 }, /* l1-i-load\000legacy cache\000Level 1 instruction cache read =
accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 37845 }, /* l1-i-load-access\000legacy cache\000Level 1 instruction cach=
e read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 38049 }, /* l1-i-load-miss\000legacy cache\000Level 1 instruction cache =
read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000 =
*/
-{ 37945 }, /* l1-i-load-misses\000legacy cache\000Level 1 instruction cach=
e read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\00=
0 */
-{ 37748 }, /* l1-i-load-ops\000legacy cache\000Level 1 instruction cache r=
ead accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 37645 }, /* l1-i-load-reference\000legacy cache\000Level 1 instruction c=
ache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000=
 */
-{ 37547 }, /* l1-i-load-refs\000legacy cache\000Level 1 instruction cache =
read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 38151 }, /* l1-i-loads\000legacy cache\000Level 1 instruction cache read=
 accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 38546 }, /* l1-i-loads-access\000legacy cache\000Level 1 instruction cac=
he read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 *=
/
-{ 38752 }, /* l1-i-loads-miss\000legacy cache\000Level 1 instruction cache=
 read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000=
 */
-{ 38647 }, /* l1-i-loads-misses\000legacy cache\000Level 1 instruction cac=
he read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\0=
00 */
-{ 38448 }, /* l1-i-loads-ops\000legacy cache\000Level 1 instruction cache =
read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 38344 }, /* l1-i-loads-reference\000legacy cache\000Level 1 instruction =
cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\00=
0 */
-{ 38245 }, /* l1-i-loads-refs\000legacy cache\000Level 1 instruction cache=
 read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 43247 }, /* l1-i-miss\000legacy cache\000Level 1 instruction cache read =
misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000 */
-{ 43148 }, /* l1-i-misses\000legacy cache\000Level 1 instruction cache rea=
d misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000 */
-{ 42961 }, /* l1-i-ops\000legacy cache\000Level 1 instruction cache read a=
ccesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 39552 }, /* l1-i-prefetch\000legacy cache\000Level 1 instruction cache p=
refetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\0=
00 */
-{ 39991 }, /* l1-i-prefetch-access\000legacy cache\000Level 1 instruction =
cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\00=
0\000\000 */
-{ 40215 }, /* l1-i-prefetch-miss\000legacy cache\000Level 1 instruction ca=
che prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\=
000\000 */
-{ 40103 }, /* l1-i-prefetch-misses\000legacy cache\000Level 1 instruction =
cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\00=
0\000\000 */
-{ 39882 }, /* l1-i-prefetch-ops\000legacy cache\000Level 1 instruction cac=
he prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\0=
00\000 */
-{ 39767 }, /* l1-i-prefetch-reference\000legacy cache\000Level 1 instructi=
on cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000=
\000\000\000 */
-{ 39657 }, /* l1-i-prefetch-refs\000legacy cache\000Level 1 instruction ca=
che prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\=
000\000 */
-{ 40325 }, /* l1-i-prefetches\000legacy cache\000Level 1 instruction cache=
 prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000=
\000 */
-{ 40772 }, /* l1-i-prefetches-access\000legacy cache\000Level 1 instructio=
n cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\=
000\000\000 */
-{ 41000 }, /* l1-i-prefetches-miss\000legacy cache\000Level 1 instruction =
cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\00=
0\000\000 */
-{ 40886 }, /* l1-i-prefetches-misses\000legacy cache\000Level 1 instructio=
n cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\=
000\000\000 */
-{ 40661 }, /* l1-i-prefetches-ops\000legacy cache\000Level 1 instruction c=
ache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000=
\000\000 */
-{ 40544 }, /* l1-i-prefetches-reference\000legacy cache\000Level 1 instruc=
tion cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\0=
00\000\000\000 */
-{ 40432 }, /* l1-i-prefetches-refs\000legacy cache\000Level 1 instruction =
cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\00=
0\000\000 */
-{ 38855 }, /* l1-i-read\000legacy cache\000Level 1 instruction cache read =
accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 39246 }, /* l1-i-read-access\000legacy cache\000Level 1 instruction cach=
e read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 39450 }, /* l1-i-read-miss\000legacy cache\000Level 1 instruction cache =
read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000 =
*/
-{ 39346 }, /* l1-i-read-misses\000legacy cache\000Level 1 instruction cach=
e read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\00=
0 */
-{ 39149 }, /* l1-i-read-ops\000legacy cache\000Level 1 instruction cache r=
ead accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 39046 }, /* l1-i-read-reference\000legacy cache\000Level 1 instruction c=
ache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000=
 */
-{ 38948 }, /* l1-i-read-refs\000legacy cache\000Level 1 instruction cache =
read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 42863 }, /* l1-i-reference\000legacy cache\000Level 1 instruction cache =
read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 42770 }, /* l1-i-refs\000legacy cache\000Level 1 instruction cache read =
accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 41941 }, /* l1-i-speculative-load\000legacy cache\000Level 1 instruction=
 cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\0=
00\000\000 */
-{ 42412 }, /* l1-i-speculative-load-access\000legacy cache\000Level 1 inst=
ruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\00=
0\000\000\000\000 */
-{ 42652 }, /* l1-i-speculative-load-miss\000legacy cache\000Level 1 instru=
ction cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\=
000\000\000\000 */
-{ 42532 }, /* l1-i-speculative-load-misses\000legacy cache\000Level 1 inst=
ruction cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\00=
0\000\000\000\000 */
-{ 42295 }, /* l1-i-speculative-load-ops\000legacy cache\000Level 1 instruc=
tion cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\0=
00\000\000\000 */
-{ 42172 }, /* l1-i-speculative-load-reference\000legacy cache\000Level 1 i=
nstruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010=
\000\000\000\000\000 */
-{ 42054 }, /* l1-i-speculative-load-refs\000legacy cache\000Level 1 instru=
ction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\=
000\000\000\000 */
-{ 41112 }, /* l1-i-speculative-read\000legacy cache\000Level 1 instruction=
 cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\0=
00\000\000 */
-{ 41583 }, /* l1-i-speculative-read-access\000legacy cache\000Level 1 inst=
ruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\00=
0\000\000\000\000 */
-{ 41823 }, /* l1-i-speculative-read-miss\000legacy cache\000Level 1 instru=
ction cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\=
000\000\000\000 */
-{ 41703 }, /* l1-i-speculative-read-misses\000legacy cache\000Level 1 inst=
ruction cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\00=
0\000\000\000\000 */
-{ 41466 }, /* l1-i-speculative-read-ops\000legacy cache\000Level 1 instruc=
tion cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\0=
00\000\000\000 */
-{ 41343 }, /* l1-i-speculative-read-reference\000legacy cache\000Level 1 i=
nstruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010=
\000\000\000\000\000 */
-{ 41225 }, /* l1-i-speculative-read-refs\000legacy cache\000Level 1 instru=
ction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\=
000\000\000\000 */
-{ 31108 }, /* l1-icache\000legacy cache\000Level 1 instruction cache read =
accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 37060 }, /* l1-icache-access\000legacy cache\000Level 1 instruction cach=
e read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 31201 }, /* l1-icache-load\000legacy cache\000Level 1 instruction cache =
read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 31612 }, /* l1-icache-load-access\000legacy cache\000Level 1 instruction=
 cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\0=
00 */
-{ 31826 }, /* l1-icache-load-miss\000legacy cache\000Level 1 instruction c=
ache read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000=
\000 */
-{ 31717 }, /* l1-icache-load-misses\000legacy cache\000Level 1 instruction=
 cache read misses\000legacy-cache-config=3D0x10001\000\00000\000\000\000\0=
00\000 */
-{ 31510 }, /* l1-icache-load-ops\000legacy cache\000Level 1 instruction ca=
che read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 =
*/
-{ 31402 }, /* l1-icache-load-reference\000legacy cache\000Level 1 instruct=
ion cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\00=
0\000 */
-{ 31299 }, /* l1-icache-load-refs\000legacy cache\000Level 1 instruction c=
ache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000=
 */
-{ 31933 }, /* l1-icache-loads\000legacy cache\000Level 1 instruction cache=
 read accesses\000legacy-cache-config=3D1\000\00000\000\000\000\000\000 */
-{ 32348 }, /* l1-icache-loads-access\000legacy cache\000Level 1 instructio=
n cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\=
000 */
-{ 32564 }, /* l1-icache-loads-miss\000legacy cache\000Level 1 instruction =
cache read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\00=
0\000 */
-{ 32454 }, /* l1-icache-loads-misses\000legacy cache\000Level 1 instructio=
n cache read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\=
000\000 */
-{ 32245 }, /* l1-icache-loads-ops\000legacy cache\000Level 1 instruction c=
ache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000=
 */
-{ 32136 }, /* l1-icache-loads-reference\000legacy cache\000Level 1 instruc=
tion cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\0=
00\000 */
-{ 32032 }, /* l1-icache-loads-refs\000legacy cache\000Level 1 instruction =
cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\00=
0 */
-{ 37264 }, /* l1-icache-miss\000legacy cache\000Level 1 instruction cache =
read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000 =
*/
-{ 37160 }, /* l1-icache-misses\000legacy cache\000Level 1 instruction cach=
e read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\00=
0 */
-{ 36963 }, /* l1-icache-ops\000legacy cache\000Level 1 instruction cache r=
ead accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 33404 }, /* l1-icache-prefetch\000legacy cache\000Level 1 instruction ca=
che prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\=
000\000 */
-{ 33863 }, /* l1-icache-prefetch-access\000legacy cache\000Level 1 instruc=
tion cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\0=
00\000\000\000 */
-{ 34097 }, /* l1-icache-prefetch-miss\000legacy cache\000Level 1 instructi=
on cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000=
\000\000\000 */
-{ 33980 }, /* l1-icache-prefetch-misses\000legacy cache\000Level 1 instruc=
tion cache prefetch misses\000legacy-cache-config=3D0x10201\000\00000\000\0=
00\000\000\000 */
-{ 33749 }, /* l1-icache-prefetch-ops\000legacy cache\000Level 1 instructio=
n cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\=
000\000\000 */
-{ 33629 }, /* l1-icache-prefetch-reference\000legacy cache\000Level 1 inst=
ruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\00=
0\000\000\000\000 */
-{ 33514 }, /* l1-icache-prefetch-refs\000legacy cache\000Level 1 instructi=
on cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000=
\000\000\000 */
-{ 34212 }, /* l1-icache-prefetches\000legacy cache\000Level 1 instruction =
cache prefetch accesses\000legacy-cache-config=3D0x201\000\00000\000\000\00=
0\000\000 */
-{ 34679 }, /* l1-icache-prefetches-access\000legacy cache\000Level 1 instr=
uction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000=
\000\000\000\000 */
-{ 34917 }, /* l1-icache-prefetches-miss\000legacy cache\000Level 1 instruc=
tion cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\0=
00\000\000\000 */
-{ 34798 }, /* l1-icache-prefetches-misses\000legacy cache\000Level 1 instr=
uction cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000=
\000\000\000\000 */
-{ 34563 }, /* l1-icache-prefetches-ops\000legacy cache\000Level 1 instruct=
ion cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\00=
0\000\000\000 */
-{ 34441 }, /* l1-icache-prefetches-reference\000legacy cache\000Level 1 in=
struction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\=
000\000\000\000\000 */
-{ 34324 }, /* l1-icache-prefetches-refs\000legacy cache\000Level 1 instruc=
tion cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\0=
00\000\000\000 */
-{ 32672 }, /* l1-icache-read\000legacy cache\000Level 1 instruction cache =
read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 33083 }, /* l1-icache-read-access\000legacy cache\000Level 1 instruction=
 cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\0=
00 */
-{ 33297 }, /* l1-icache-read-miss\000legacy cache\000Level 1 instruction c=
ache read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000=
\000 */
-{ 33188 }, /* l1-icache-read-misses\000legacy cache\000Level 1 instruction=
 cache read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\0=
00\000 */
-{ 32981 }, /* l1-icache-read-ops\000legacy cache\000Level 1 instruction ca=
che read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 =
*/
-{ 32873 }, /* l1-icache-read-reference\000legacy cache\000Level 1 instruct=
ion cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\00=
0\000 */
-{ 32770 }, /* l1-icache-read-refs\000legacy cache\000Level 1 instruction c=
ache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000=
 */
-{ 36860 }, /* l1-icache-reference\000legacy cache\000Level 1 instruction c=
ache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000=
 */
-{ 36762 }, /* l1-icache-refs\000legacy cache\000Level 1 instruction cache =
read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 35898 }, /* l1-icache-speculative-load\000legacy cache\000Level 1 instru=
ction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\=
000\000\000\000 */
-{ 36389 }, /* l1-icache-speculative-load-access\000legacy cache\000Level 1=
 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\000=
10\000\000\000\000\000 */
-{ 36639 }, /* l1-icache-speculative-load-miss\000legacy cache\000Level 1 i=
nstruction cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010=
\000\000\000\000\000 */
-{ 36514 }, /* l1-icache-speculative-load-misses\000legacy cache\000Level 1=
 instruction cache prefetch misses\000legacy-cache-config=3D0x10201\000\000=
10\000\000\000\000\000 */
-{ 36267 }, /* l1-icache-speculative-load-ops\000legacy cache\000Level 1 in=
struction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\=
000\000\000\000\000 */
-{ 36139 }, /* l1-icache-speculative-load-reference\000legacy cache\000Leve=
l 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\=
00010\000\000\000\000\000 */
-{ 36016 }, /* l1-icache-speculative-load-refs\000legacy cache\000Level 1 i=
nstruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010=
\000\000\000\000\000 */
-{ 35034 }, /* l1-icache-speculative-read\000legacy cache\000Level 1 instru=
ction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\=
000\000\000\000 */
-{ 35525 }, /* l1-icache-speculative-read-access\000legacy cache\000Level 1=
 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\000=
10\000\000\000\000\000 */
-{ 35775 }, /* l1-icache-speculative-read-miss\000legacy cache\000Level 1 i=
nstruction cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010=
\000\000\000\000\000 */
-{ 35650 }, /* l1-icache-speculative-read-misses\000legacy cache\000Level 1=
 instruction cache prefetch misses\000legacy-cache-config=3D0x10201\000\000=
10\000\000\000\000\000 */
-{ 35403 }, /* l1-icache-speculative-read-ops\000legacy cache\000Level 1 in=
struction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\=
000\000\000\000\000 */
-{ 35275 }, /* l1-icache-speculative-read-reference\000legacy cache\000Leve=
l 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\=
00010\000\000\000\000\000 */
-{ 35152 }, /* l1-icache-speculative-read-refs\000legacy cache\000Level 1 i=
nstruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010=
\000\000\000\000\000 */
-{ 49266 }, /* l1-instruction\000legacy cache\000Level 1 instruction cache =
read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 55483 }, /* l1-instruction-access\000legacy cache\000Level 1 instruction=
 cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\0=
00 */
-{ 49364 }, /* l1-instruction-load\000legacy cache\000Level 1 instruction c=
ache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000=
 */
-{ 49795 }, /* l1-instruction-load-access\000legacy cache\000Level 1 instru=
ction cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\=
000\000 */
-{ 50019 }, /* l1-instruction-load-miss\000legacy cache\000Level 1 instruct=
ion cache read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\00=
0\000\000 */
-{ 49905 }, /* l1-instruction-load-misses\000legacy cache\000Level 1 instru=
ction cache read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\=
000\000\000 */
-{ 49688 }, /* l1-instruction-load-ops\000legacy cache\000Level 1 instructi=
on cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000=
\000 */
-{ 49575 }, /* l1-instruction-load-reference\000legacy cache\000Level 1 ins=
truction cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\0=
00\000\000 */
-{ 49467 }, /* l1-instruction-load-refs\000legacy cache\000Level 1 instruct=
ion cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\00=
0\000 */
-{ 50131 }, /* l1-instruction-loads\000legacy cache\000Level 1 instruction =
cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\00=
0 */
-{ 50566 }, /* l1-instruction-loads-access\000legacy cache\000Level 1 instr=
uction cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000=
\000\000 */
-{ 50792 }, /* l1-instruction-loads-miss\000legacy cache\000Level 1 instruc=
tion cache read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\0=
00\000\000 */
-{ 50677 }, /* l1-instruction-loads-misses\000legacy cache\000Level 1 instr=
uction cache read misses\000legacy-cache-config=3D0x10001\000\00010\000\000=
\000\000\000 */
-{ 50458 }, /* l1-instruction-loads-ops\000legacy cache\000Level 1 instruct=
ion cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\00=
0\000 */
-{ 50344 }, /* l1-instruction-loads-reference\000legacy cache\000Level 1 in=
struction cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\=
000\000\000 */
-{ 50235 }, /* l1-instruction-loads-refs\000legacy cache\000Level 1 instruc=
tion cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\0=
00\000 */
-{ 55697 }, /* l1-instruction-miss\000legacy cache\000Level 1 instruction c=
ache read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000=
\000 */
-{ 55588 }, /* l1-instruction-misses\000legacy cache\000Level 1 instruction=
 cache read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\0=
00\000 */
-{ 55381 }, /* l1-instruction-ops\000legacy cache\000Level 1 instruction ca=
che read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 =
*/
-{ 51672 }, /* l1-instruction-prefetch\000legacy cache\000Level 1 instructi=
on cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000=
\000\000\000 */
-{ 52151 }, /* l1-instruction-prefetch-access\000legacy cache\000Level 1 in=
struction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\=
000\000\000\000\000 */
-{ 52395 }, /* l1-instruction-prefetch-miss\000legacy cache\000Level 1 inst=
ruction cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\00=
0\000\000\000\000 */
-{ 52273 }, /* l1-instruction-prefetch-misses\000legacy cache\000Level 1 in=
struction cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\=
000\000\000\000\000 */
-{ 52032 }, /* l1-instruction-prefetch-ops\000legacy cache\000Level 1 instr=
uction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000=
\000\000\000\000 */
-{ 51907 }, /* l1-instruction-prefetch-reference\000legacy cache\000Level 1=
 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\000=
10\000\000\000\000\000 */
-{ 51787 }, /* l1-instruction-prefetch-refs\000legacy cache\000Level 1 inst=
ruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\00=
0\000\000\000\000 */
-{ 52515 }, /* l1-instruction-prefetches\000legacy cache\000Level 1 instruc=
tion cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\0=
00\000\000\000 */
-{ 53002 }, /* l1-instruction-prefetches-access\000legacy cache\000Level 1 =
instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\0001=
0\000\000\000\000\000 */
-{ 53250 }, /* l1-instruction-prefetches-miss\000legacy cache\000Level 1 in=
struction cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\=
000\000\000\000\000 */
-{ 53126 }, /* l1-instruction-prefetches-misses\000legacy cache\000Level 1 =
instruction cache prefetch misses\000legacy-cache-config=3D0x10201\000\0001=
0\000\000\000\000\000 */
-{ 52881 }, /* l1-instruction-prefetches-ops\000legacy cache\000Level 1 ins=
truction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\0=
00\000\000\000\000 */
-{ 52754 }, /* l1-instruction-prefetches-reference\000legacy cache\000Level=
 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\0=
0010\000\000\000\000\000 */
-{ 52632 }, /* l1-instruction-prefetches-refs\000legacy cache\000Level 1 in=
struction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\=
000\000\000\000\000 */
-{ 50905 }, /* l1-instruction-read\000legacy cache\000Level 1 instruction c=
ache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000=
 */
-{ 51336 }, /* l1-instruction-read-access\000legacy cache\000Level 1 instru=
ction cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\=
000\000 */
-{ 51560 }, /* l1-instruction-read-miss\000legacy cache\000Level 1 instruct=
ion cache read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\00=
0\000\000 */
-{ 51446 }, /* l1-instruction-read-misses\000legacy cache\000Level 1 instru=
ction cache read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\=
000\000\000 */
-{ 51229 }, /* l1-instruction-read-ops\000legacy cache\000Level 1 instructi=
on cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000=
\000 */
-{ 51116 }, /* l1-instruction-read-reference\000legacy cache\000Level 1 ins=
truction cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\0=
00\000\000 */
-{ 51008 }, /* l1-instruction-read-refs\000legacy cache\000Level 1 instruct=
ion cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\00=
0\000 */
-{ 55273 }, /* l1-instruction-reference\000legacy cache\000Level 1 instruct=
ion cache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\00=
0\000 */
-{ 55170 }, /* l1-instruction-refs\000legacy cache\000Level 1 instruction c=
ache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000=
 */
-{ 54271 }, /* l1-instruction-speculative-load\000legacy cache\000Level 1 i=
nstruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010=
\000\000\000\000\000 */
-{ 54782 }, /* l1-instruction-speculative-load-access\000legacy cache\000Le=
vel 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\00=
0\00010\000\000\000\000\000 */
-{ 55042 }, /* l1-instruction-speculative-load-miss\000legacy cache\000Leve=
l 1 instruction cache prefetch misses\000legacy-cache-config=3D0x10201\000\=
00010\000\000\000\000\000 */
-{ 54912 }, /* l1-instruction-speculative-load-misses\000legacy cache\000Le=
vel 1 instruction cache prefetch misses\000legacy-cache-config=3D0x10201\00=
0\00010\000\000\000\000\000 */
-{ 54655 }, /* l1-instruction-speculative-load-ops\000legacy cache\000Level=
 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\0=
0010\000\000\000\000\000 */
-{ 54522 }, /* l1-instruction-speculative-load-reference\000legacy cache\00=
0Level 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201=
\000\00010\000\000\000\000\000 */
-{ 54394 }, /* l1-instruction-speculative-load-refs\000legacy cache\000Leve=
l 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\=
00010\000\000\000\000\000 */
-{ 53372 }, /* l1-instruction-speculative-read\000legacy cache\000Level 1 i=
nstruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010=
\000\000\000\000\000 */
-{ 53883 }, /* l1-instruction-speculative-read-access\000legacy cache\000Le=
vel 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\00=
0\00010\000\000\000\000\000 */
-{ 54143 }, /* l1-instruction-speculative-read-miss\000legacy cache\000Leve=
l 1 instruction cache prefetch misses\000legacy-cache-config=3D0x10201\000\=
00010\000\000\000\000\000 */
-{ 54013 }, /* l1-instruction-speculative-read-misses\000legacy cache\000Le=
vel 1 instruction cache prefetch misses\000legacy-cache-config=3D0x10201\00=
0\00010\000\000\000\000\000 */
-{ 53756 }, /* l1-instruction-speculative-read-ops\000legacy cache\000Level=
 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\0=
0010\000\000\000\000\000 */
-{ 53623 }, /* l1-instruction-speculative-read-reference\000legacy cache\00=
0Level 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201=
\000\00010\000\000\000\000\000 */
-{ 53495 }, /* l1-instruction-speculative-read-refs\000legacy cache\000Leve=
l 1 instruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\=
00010\000\000\000\000\000 */
-{ 15676 }, /* l1d\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 22971 }, /* l1d-access\000legacy cache\000Level 1 data cache read access=
es\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 15756 }, /* l1d-load\000legacy cache\000Level 1 data cache read accesses=
\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 16115 }, /* l1d-load-access\000legacy cache\000Level 1 data cache read a=
ccesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 16303 }, /* l1d-load-miss\000legacy cache\000Level 1 data cache read mis=
ses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000 */
-{ 16207 }, /* l1d-load-misses\000legacy cache\000Level 1 data cache read m=
isses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000 */
-{ 16026 }, /* l1d-load-ops\000legacy cache\000Level 1 data cache read acce=
sses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 15931 }, /* l1d-load-reference\000legacy cache\000Level 1 data cache rea=
d accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 15841 }, /* l1d-load-refs\000legacy cache\000Level 1 data cache read acc=
esses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 16397 }, /* l1d-loads\000legacy cache\000Level 1 data cache read accesse=
s\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 16760 }, /* l1d-loads-access\000legacy cache\000Level 1 data cache read =
accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 16950 }, /* l1d-loads-miss\000legacy cache\000Level 1 data cache read mi=
sses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000 */
-{ 16853 }, /* l1d-loads-misses\000legacy cache\000Level 1 data cache read =
misses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000 */
-{ 16670 }, /* l1d-loads-ops\000legacy cache\000Level 1 data cache read acc=
esses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 16574 }, /* l1d-loads-reference\000legacy cache\000Level 1 data cache re=
ad accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 16483 }, /* l1d-loads-refs\000legacy cache\000Level 1 data cache read ac=
cesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 23149 }, /* l1d-miss\000legacy cache\000Level 1 data cache read misses\0=
00legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000 */
-{ 23058 }, /* l1d-misses\000legacy cache\000Level 1 data cache read misses=
\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000 */
-{ 22887 }, /* l1d-ops\000legacy cache\000Level 1 data cache read accesses\=
000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 19718 }, /* l1d-prefetch\000legacy cache\000Level 1 data cache prefetch =
accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000 */
-{ 20125 }, /* l1d-prefetch-access\000legacy cache\000Level 1 data cache pr=
efetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\00=
0 */
-{ 20333 }, /* l1d-prefetch-miss\000legacy cache\000Level 1 data cache pref=
etch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000 =
*/
-{ 20229 }, /* l1d-prefetch-misses\000legacy cache\000Level 1 data cache pr=
efetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\00=
0 */
-{ 20024 }, /* l1d-prefetch-ops\000legacy cache\000Level 1 data cache prefe=
tch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000 *=
/
-{ 19917 }, /* l1d-prefetch-reference\000legacy cache\000Level 1 data cache=
 prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000=
\000 */
-{ 19815 }, /* l1d-prefetch-refs\000legacy cache\000Level 1 data cache pref=
etch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000 =
*/
-{ 20435 }, /* l1d-prefetches\000legacy cache\000Level 1 data cache prefetc=
h accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000 */
-{ 20850 }, /* l1d-prefetches-access\000legacy cache\000Level 1 data cache =
prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\=
000 */
-{ 21062 }, /* l1d-prefetches-miss\000legacy cache\000Level 1 data cache pr=
efetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\00=
0 */
-{ 20956 }, /* l1d-prefetches-misses\000legacy cache\000Level 1 data cache =
prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\=
000 */
-{ 20747 }, /* l1d-prefetches-ops\000legacy cache\000Level 1 data cache pre=
fetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000=
 */
-{ 20638 }, /* l1d-prefetches-reference\000legacy cache\000Level 1 data cac=
he prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\0=
00\000 */
-{ 20534 }, /* l1d-prefetches-refs\000legacy cache\000Level 1 data cache pr=
efetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\00=
0 */
-{ 17045 }, /* l1d-read\000legacy cache\000Level 1 data cache read accesses=
\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 17404 }, /* l1d-read-access\000legacy cache\000Level 1 data cache read a=
ccesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 17592 }, /* l1d-read-miss\000legacy cache\000Level 1 data cache read mis=
ses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000 */
-{ 17496 }, /* l1d-read-misses\000legacy cache\000Level 1 data cache read m=
isses\000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000 */
-{ 17315 }, /* l1d-read-ops\000legacy cache\000Level 1 data cache read acce=
sses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 17220 }, /* l1d-read-reference\000legacy cache\000Level 1 data cache rea=
d accesses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 17130 }, /* l1d-read-refs\000legacy cache\000Level 1 data cache read acc=
esses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 22797 }, /* l1d-reference\000legacy cache\000Level 1 data cache read acc=
esses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 22712 }, /* l1d-refs\000legacy cache\000Level 1 data cache read accesses=
\000legacy-cache-config=3D0\000\00010\000\000\000\000\000 */
-{ 21939 }, /* l1d-speculative-load\000legacy cache\000Level 1 data cache p=
refetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\0=
00 */
-{ 22378 }, /* l1d-speculative-load-access\000legacy cache\000Level 1 data =
cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\00=
0\000\000 */
-{ 22602 }, /* l1d-speculative-load-miss\000legacy cache\000Level 1 data ca=
che prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\=
000\000 */
-{ 22490 }, /* l1d-speculative-load-misses\000legacy cache\000Level 1 data =
cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\00=
0\000\000 */
-{ 22269 }, /* l1d-speculative-load-ops\000legacy cache\000Level 1 data cac=
he prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\0=
00\000 */
-{ 22154 }, /* l1d-speculative-load-reference\000legacy cache\000Level 1 da=
ta cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000=
\000\000\000 */
-{ 22044 }, /* l1d-speculative-load-refs\000legacy cache\000Level 1 data ca=
che prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\=
000\000 */
-{ 21166 }, /* l1d-speculative-read\000legacy cache\000Level 1 data cache p=
refetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\0=
00 */
-{ 21605 }, /* l1d-speculative-read-access\000legacy cache\000Level 1 data =
cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\00=
0\000\000 */
-{ 21829 }, /* l1d-speculative-read-miss\000legacy cache\000Level 1 data ca=
che prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\=
000\000 */
-{ 21717 }, /* l1d-speculative-read-misses\000legacy cache\000Level 1 data =
cache prefetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\00=
0\000\000 */
-{ 21496 }, /* l1d-speculative-read-ops\000legacy cache\000Level 1 data cac=
he prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\0=
00\000 */
-{ 21381 }, /* l1d-speculative-read-reference\000legacy cache\000Level 1 da=
ta cache prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000=
\000\000\000 */
-{ 21271 }, /* l1d-speculative-read-refs\000legacy cache\000Level 1 data ca=
che prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\=
000\000 */
-{ 17686 }, /* l1d-store\000legacy cache\000Level 1 data cache write access=
es\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 18069 }, /* l1d-store-access\000legacy cache\000Level 1 data cache write=
 accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 18265 }, /* l1d-store-miss\000legacy cache\000Level 1 data cache write m=
isses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000 */
-{ 18167 }, /* l1d-store-misses\000legacy cache\000Level 1 data cache write=
 misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000 */
-{ 17974 }, /* l1d-store-ops\000legacy cache\000Level 1 data cache write ac=
cesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 17873 }, /* l1d-store-reference\000legacy cache\000Level 1 data cache wr=
ite accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 *=
/
-{ 17777 }, /* l1d-store-refs\000legacy cache\000Level 1 data cache write a=
ccesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 18361 }, /* l1d-stores\000legacy cache\000Level 1 data cache write acces=
ses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 18748 }, /* l1d-stores-access\000legacy cache\000Level 1 data cache writ=
e accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 18946 }, /* l1d-stores-miss\000legacy cache\000Level 1 data cache write =
misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000 */
-{ 18847 }, /* l1d-stores-misses\000legacy cache\000Level 1 data cache writ=
e misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000 */
-{ 18652 }, /* l1d-stores-ops\000legacy cache\000Level 1 data cache write a=
ccesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 18550 }, /* l1d-stores-reference\000legacy cache\000Level 1 data cache w=
rite accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 =
*/
-{ 18453 }, /* l1d-stores-refs\000legacy cache\000Level 1 data cache write =
accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 19043 }, /* l1d-write\000legacy cache\000Level 1 data cache write access=
es\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 19426 }, /* l1d-write-access\000legacy cache\000Level 1 data cache write=
 accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 19622 }, /* l1d-write-miss\000legacy cache\000Level 1 data cache write m=
isses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000 */
-{ 19524 }, /* l1d-write-misses\000legacy cache\000Level 1 data cache write=
 misses\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000 */
-{ 19331 }, /* l1d-write-ops\000legacy cache\000Level 1 data cache write ac=
cesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 19230 }, /* l1d-write-reference\000legacy cache\000Level 1 data cache wr=
ite accesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 *=
/
-{ 19134 }, /* l1d-write-refs\000legacy cache\000Level 1 data cache write a=
ccesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000 */
-{ 43344 }, /* l1i\000legacy cache\000Level 1 instruction cache read access=
es\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 48978 }, /* l1i-access\000legacy cache\000Level 1 instruction cache read=
 accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 43431 }, /* l1i-load\000legacy cache\000Level 1 instruction cache read a=
ccesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 43818 }, /* l1i-load-access\000legacy cache\000Level 1 instruction cache=
 read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 44020 }, /* l1i-load-miss\000legacy cache\000Level 1 instruction cache r=
ead misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000 *=
/
-{ 43917 }, /* l1i-load-misses\000legacy cache\000Level 1 instruction cache=
 read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000=
 */
-{ 43722 }, /* l1i-load-ops\000legacy cache\000Level 1 instruction cache re=
ad accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 43620 }, /* l1i-load-reference\000legacy cache\000Level 1 instruction ca=
che read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 =
*/
-{ 43523 }, /* l1i-load-refs\000legacy cache\000Level 1 instruction cache r=
ead accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 44121 }, /* l1i-loads\000legacy cache\000Level 1 instruction cache read =
accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 44512 }, /* l1i-loads-access\000legacy cache\000Level 1 instruction cach=
e read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 44716 }, /* l1i-loads-miss\000legacy cache\000Level 1 instruction cache =
read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000 =
*/
-{ 44612 }, /* l1i-loads-misses\000legacy cache\000Level 1 instruction cach=
e read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\00=
0 */
-{ 44415 }, /* l1i-loads-ops\000legacy cache\000Level 1 instruction cache r=
ead accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 44312 }, /* l1i-loads-reference\000legacy cache\000Level 1 instruction c=
ache read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000=
 */
-{ 44214 }, /* l1i-loads-refs\000legacy cache\000Level 1 instruction cache =
read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 49170 }, /* l1i-miss\000legacy cache\000Level 1 instruction cache read m=
isses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000 */
-{ 49072 }, /* l1i-misses\000legacy cache\000Level 1 instruction cache read=
 misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000 */
-{ 48887 }, /* l1i-ops\000legacy cache\000Level 1 instruction cache read ac=
cesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 45508 }, /* l1i-prefetch\000legacy cache\000Level 1 instruction cache pr=
efetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\00=
0 */
-{ 45943 }, /* l1i-prefetch-access\000legacy cache\000Level 1 instruction c=
ache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000=
\000\000 */
-{ 46165 }, /* l1i-prefetch-miss\000legacy cache\000Level 1 instruction cac=
he prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\0=
00\000 */
-{ 46054 }, /* l1i-prefetch-misses\000legacy cache\000Level 1 instruction c=
ache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000=
\000\000 */
-{ 45835 }, /* l1i-prefetch-ops\000legacy cache\000Level 1 instruction cach=
e prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\00=
0\000 */
-{ 45721 }, /* l1i-prefetch-reference\000legacy cache\000Level 1 instructio=
n cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\=
000\000\000 */
-{ 45612 }, /* l1i-prefetch-refs\000legacy cache\000Level 1 instruction cac=
he prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\0=
00\000 */
-{ 46274 }, /* l1i-prefetches\000legacy cache\000Level 1 instruction cache =
prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\=
000 */
-{ 46717 }, /* l1i-prefetches-access\000legacy cache\000Level 1 instruction=
 cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\0=
00\000\000 */
-{ 46943 }, /* l1i-prefetches-miss\000legacy cache\000Level 1 instruction c=
ache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000=
\000\000 */
-{ 46830 }, /* l1i-prefetches-misses\000legacy cache\000Level 1 instruction=
 cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\0=
00\000\000 */
-{ 46607 }, /* l1i-prefetches-ops\000legacy cache\000Level 1 instruction ca=
che prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\=
000\000 */
-{ 46491 }, /* l1i-prefetches-reference\000legacy cache\000Level 1 instruct=
ion cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\00=
0\000\000\000 */
-{ 46380 }, /* l1i-prefetches-refs\000legacy cache\000Level 1 instruction c=
ache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000=
\000\000 */
-{ 44818 }, /* l1i-read\000legacy cache\000Level 1 instruction cache read a=
ccesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 45205 }, /* l1i-read-access\000legacy cache\000Level 1 instruction cache=
 read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 45407 }, /* l1i-read-miss\000legacy cache\000Level 1 instruction cache r=
ead misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000 *=
/
-{ 45304 }, /* l1i-read-misses\000legacy cache\000Level 1 instruction cache=
 read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000=
 */
-{ 45109 }, /* l1i-read-ops\000legacy cache\000Level 1 instruction cache re=
ad accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 45007 }, /* l1i-read-reference\000legacy cache\000Level 1 instruction ca=
che read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 =
*/
-{ 44910 }, /* l1i-read-refs\000legacy cache\000Level 1 instruction cache r=
ead accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 48790 }, /* l1i-reference\000legacy cache\000Level 1 instruction cache r=
ead accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 48698 }, /* l1i-refs\000legacy cache\000Level 1 instruction cache read a=
ccesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000 */
-{ 47876 }, /* l1i-speculative-load\000legacy cache\000Level 1 instruction =
cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\00=
0\000\000 */
-{ 48343 }, /* l1i-speculative-load-access\000legacy cache\000Level 1 instr=
uction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000=
\000\000\000\000 */
-{ 48581 }, /* l1i-speculative-load-miss\000legacy cache\000Level 1 instruc=
tion cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\0=
00\000\000\000 */
-{ 48462 }, /* l1i-speculative-load-misses\000legacy cache\000Level 1 instr=
uction cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000=
\000\000\000\000 */
-{ 48227 }, /* l1i-speculative-load-ops\000legacy cache\000Level 1 instruct=
ion cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\00=
0\000\000\000 */
-{ 48105 }, /* l1i-speculative-load-reference\000legacy cache\000Level 1 in=
struction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\=
000\000\000\000\000 */
-{ 47988 }, /* l1i-speculative-load-refs\000legacy cache\000Level 1 instruc=
tion cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\0=
00\000\000\000 */
-{ 47054 }, /* l1i-speculative-read\000legacy cache\000Level 1 instruction =
cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\00=
0\000\000 */
-{ 47521 }, /* l1i-speculative-read-access\000legacy cache\000Level 1 instr=
uction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000=
\000\000\000\000 */
-{ 47759 }, /* l1i-speculative-read-miss\000legacy cache\000Level 1 instruc=
tion cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\0=
00\000\000\000 */
-{ 47640 }, /* l1i-speculative-read-misses\000legacy cache\000Level 1 instr=
uction cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000=
\000\000\000\000 */
-{ 47405 }, /* l1i-speculative-read-ops\000legacy cache\000Level 1 instruct=
ion cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\00=
0\000\000\000 */
-{ 47283 }, /* l1i-speculative-read-reference\000legacy cache\000Level 1 in=
struction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\=
000\000\000\000\000 */
-{ 47166 }, /* l1i-speculative-read-refs\000legacy cache\000Level 1 instruc=
tion cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\0=
00\000\000\000 */
-{ 63212 }, /* l2\000legacy cache\000Level 2 (or higher) last level cache r=
ead accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000 */
-{ 71765 }, /* l2-access\000legacy cache\000Level 2 (or higher) last level =
cache read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\00=
0 */
-{ 63309 }, /* l2-load\000legacy cache\000Level 2 (or higher) last level ca=
che read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000 =
*/
-{ 63736 }, /* l2-load-access\000legacy cache\000Level 2 (or higher) last l=
evel cache read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\0=
00\000 */
-{ 63958 }, /* l2-load-miss\000legacy cache\000Level 2 (or higher) last lev=
el cache read misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000=
\000\000 */
-{ 63845 }, /* l2-load-misses\000legacy cache\000Level 2 (or higher) last l=
evel cache read misses\000legacy-cache-config=3D0x10002\000\00010\000\000\0=
00\000\000 */
-{ 63630 }, /* l2-load-ops\000legacy cache\000Level 2 (or higher) last leve=
l cache read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\=
000 */
-{ 63518 }, /* l2-load-reference\000legacy cache\000Level 2 (or higher) las=
t level cache read accesses\000legacy-cache-config=3D2\000\00010\000\000\00=
0\000\000 */
-{ 63411 }, /* l2-load-refs\000legacy cache\000Level 2 (or higher) last lev=
el cache read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000=
\000 */
-{ 64069 }, /* l2-loads\000legacy cache\000Level 2 (or higher) last level c=
ache read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000=
 */
-{ 64500 }, /* l2-loads-access\000legacy cache\000Level 2 (or higher) last =
level cache read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\=
000\000 */
-{ 64724 }, /* l2-loads-miss\000legacy cache\000Level 2 (or higher) last le=
vel cache read misses\000legacy-cache-config=3D0x10002\000\00010\000\000\00=
0\000\000 */
-{ 64610 }, /* l2-loads-misses\000legacy cache\000Level 2 (or higher) last =
level cache read misses\000legacy-cache-config=3D0x10002\000\00010\000\000\=
000\000\000 */
-{ 64393 }, /* l2-loads-ops\000legacy cache\000Level 2 (or higher) last lev=
el cache read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000=
\000 */
-{ 64280 }, /* l2-loads-reference\000legacy cache\000Level 2 (or higher) la=
st level cache read accesses\000legacy-cache-config=3D2\000\00010\000\000\0=
00\000\000 */
-{ 64172 }, /* l2-loads-refs\000legacy cache\000Level 2 (or higher) last le=
vel cache read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\00=
0\000 */
-{ 71977 }, /* l2-miss\000legacy cache\000Level 2 (or higher) last level ca=
che read misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\=
000 */
-{ 71869 }, /* l2-misses\000legacy cache\000Level 2 (or higher) last level =
cache read misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\00=
0\000 */
-{ 71664 }, /* l2-ops\000legacy cache\000Level 2 (or higher) last level cac=
he read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000 *=
/
-{ 67985 }, /* l2-prefetch\000legacy cache\000Level 2 (or higher) last leve=
l cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\=
000\000\000 */
-{ 68460 }, /* l2-prefetch-access\000legacy cache\000Level 2 (or higher) la=
st level cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\0=
00\000\000\000\000 */
-{ 68702 }, /* l2-prefetch-miss\000legacy cache\000Level 2 (or higher) last=
 level cache prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000=
\000\000\000\000 */
-{ 68581 }, /* l2-prefetch-misses\000legacy cache\000Level 2 (or higher) la=
st level cache prefetch misses\000legacy-cache-config=3D0x10202\000\00010\0=
00\000\000\000\000 */
-{ 68342 }, /* l2-prefetch-ops\000legacy cache\000Level 2 (or higher) last =
level cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\=
000\000\000\000 */
-{ 68218 }, /* l2-prefetch-reference\000legacy cache\000Level 2 (or higher)=
 last level cache prefetch accesses\000legacy-cache-config=3D0x202\000\0001=
0\000\000\000\000\000 */
-{ 68099 }, /* l2-prefetch-refs\000legacy cache\000Level 2 (or higher) last=
 level cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000=
\000\000\000\000 */
-{ 68821 }, /* l2-prefetches\000legacy cache\000Level 2 (or higher) last le=
vel cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\00=
0\000\000\000 */
-{ 69304 }, /* l2-prefetches-access\000legacy cache\000Level 2 (or higher) =
last level cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010=
\000\000\000\000\000 */
-{ 69550 }, /* l2-prefetches-miss\000legacy cache\000Level 2 (or higher) la=
st level cache prefetch misses\000legacy-cache-config=3D0x10202\000\00010\0=
00\000\000\000\000 */
-{ 69427 }, /* l2-prefetches-misses\000legacy cache\000Level 2 (or higher) =
last level cache prefetch misses\000legacy-cache-config=3D0x10202\000\00010=
\000\000\000\000\000 */
-{ 69184 }, /* l2-prefetches-ops\000legacy cache\000Level 2 (or higher) las=
t level cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\00=
0\000\000\000\000 */
-{ 69058 }, /* l2-prefetches-reference\000legacy cache\000Level 2 (or highe=
r) last level cache prefetch accesses\000legacy-cache-config=3D0x202\000\00=
010\000\000\000\000\000 */
-{ 68937 }, /* l2-prefetches-refs\000legacy cache\000Level 2 (or higher) la=
st level cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\0=
00\000\000\000\000 */
-{ 64836 }, /* l2-read\000legacy cache\000Level 2 (or higher) last level ca=
che read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000 =
*/
-{ 65263 }, /* l2-read-access\000legacy cache\000Level 2 (or higher) last l=
evel cache read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\0=
00\000 */
-{ 65485 }, /* l2-read-miss\000legacy cache\000Level 2 (or higher) last lev=
el cache read misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000=
\000\000 */
-{ 65372 }, /* l2-read-misses\000legacy cache\000Level 2 (or higher) last l=
evel cache read misses\000legacy-cache-config=3D0x10002\000\00010\000\000\0=
00\000\000 */
-{ 65157 }, /* l2-read-ops\000legacy cache\000Level 2 (or higher) last leve=
l cache read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\=
000 */
-{ 65045 }, /* l2-read-reference\000legacy cache\000Level 2 (or higher) las=
t level cache read accesses\000legacy-cache-config=3D2\000\00010\000\000\00=
0\000\000 */
-{ 64938 }, /* l2-read-refs\000legacy cache\000Level 2 (or higher) last lev=
el cache read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000=
\000 */
-{ 71557 }, /* l2-reference\000legacy cache\000Level 2 (or higher) last lev=
el cache read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000=
\000 */
-{ 71455 }, /* l2-refs\000legacy cache\000Level 2 (or higher) last level ca=
che read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000 =
*/
-{ 70563 }, /* l2-speculative-load\000legacy cache\000Level 2 (or higher) l=
ast level cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\=
000\000\000\000\000 */
-{ 71070 }, /* l2-speculative-load-access\000legacy cache\000Level 2 (or hi=
gher) last level cache prefetch accesses\000legacy-cache-config=3D0x202\000=
\00010\000\000\000\000\000 */
-{ 71328 }, /* l2-speculative-load-miss\000legacy cache\000Level 2 (or high=
er) last level cache prefetch misses\000legacy-cache-config=3D0x10202\000\0=
0010\000\000\000\000\000 */
-{ 71199 }, /* l2-speculative-load-misses\000legacy cache\000Level 2 (or hi=
gher) last level cache prefetch misses\000legacy-cache-config=3D0x10202\000=
\00010\000\000\000\000\000 */
-{ 70944 }, /* l2-speculative-load-ops\000legacy cache\000Level 2 (or highe=
r) last level cache prefetch accesses\000legacy-cache-config=3D0x202\000\00=
010\000\000\000\000\000 */
-{ 70812 }, /* l2-speculative-load-reference\000legacy cache\000Level 2 (or=
 higher) last level cache prefetch accesses\000legacy-cache-config=3D0x202\=
000\00010\000\000\000\000\000 */
-{ 70685 }, /* l2-speculative-load-refs\000legacy cache\000Level 2 (or high=
er) last level cache prefetch accesses\000legacy-cache-config=3D0x202\000\0=
0010\000\000\000\000\000 */
-{ 69671 }, /* l2-speculative-read\000legacy cache\000Level 2 (or higher) l=
ast level cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\=
000\000\000\000\000 */
-{ 70178 }, /* l2-speculative-read-access\000legacy cache\000Level 2 (or hi=
gher) last level cache prefetch accesses\000legacy-cache-config=3D0x202\000=
\00010\000\000\000\000\000 */
-{ 70436 }, /* l2-speculative-read-miss\000legacy cache\000Level 2 (or high=
er) last level cache prefetch misses\000legacy-cache-config=3D0x10202\000\0=
0010\000\000\000\000\000 */
-{ 70307 }, /* l2-speculative-read-misses\000legacy cache\000Level 2 (or hi=
gher) last level cache prefetch misses\000legacy-cache-config=3D0x10202\000=
\00010\000\000\000\000\000 */
-{ 70052 }, /* l2-speculative-read-ops\000legacy cache\000Level 2 (or highe=
r) last level cache prefetch accesses\000legacy-cache-config=3D0x202\000\00=
010\000\000\000\000\000 */
-{ 69920 }, /* l2-speculative-read-reference\000legacy cache\000Level 2 (or=
 higher) last level cache prefetch accesses\000legacy-cache-config=3D0x202\=
000\00010\000\000\000\000\000 */
-{ 69793 }, /* l2-speculative-read-refs\000legacy cache\000Level 2 (or high=
er) last level cache prefetch accesses\000legacy-cache-config=3D0x202\000\0=
0010\000\000\000\000\000 */
-{ 65596 }, /* l2-store\000legacy cache\000Level 2 (or higher) last level c=
ache write accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\00=
0\000 */
-{ 66047 }, /* l2-store-access\000legacy cache\000Level 2 (or higher) last =
level cache write accesses\000legacy-cache-config=3D0x102\000\00010\000\000=
\000\000\000 */
-{ 66277 }, /* l2-store-miss\000legacy cache\000Level 2 (or higher) last le=
vel cache write misses\000legacy-cache-config=3D0x10102\000\00010\000\000\0=
00\000\000 */
-{ 66162 }, /* l2-store-misses\000legacy cache\000Level 2 (or higher) last =
level cache write misses\000legacy-cache-config=3D0x10102\000\00010\000\000=
\000\000\000 */
-{ 65935 }, /* l2-store-ops\000legacy cache\000Level 2 (or higher) last lev=
el cache write accesses\000legacy-cache-config=3D0x102\000\00010\000\000\00=
0\000\000 */
-{ 65817 }, /* l2-store-reference\000legacy cache\000Level 2 (or higher) la=
st level cache write accesses\000legacy-cache-config=3D0x102\000\00010\000\=
000\000\000\000 */
-{ 65704 }, /* l2-store-refs\000legacy cache\000Level 2 (or higher) last le=
vel cache write accesses\000legacy-cache-config=3D0x102\000\00010\000\000\0=
00\000\000 */
-{ 66390 }, /* l2-stores\000legacy cache\000Level 2 (or higher) last level =
cache write accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\0=
00\000 */
-{ 66845 }, /* l2-stores-access\000legacy cache\000Level 2 (or higher) last=
 level cache write accesses\000legacy-cache-config=3D0x102\000\00010\000\00=
0\000\000\000 */
-{ 67077 }, /* l2-stores-miss\000legacy cache\000Level 2 (or higher) last l=
evel cache write misses\000legacy-cache-config=3D0x10102\000\00010\000\000\=
000\000\000 */
-{ 66961 }, /* l2-stores-misses\000legacy cache\000Level 2 (or higher) last=
 level cache write misses\000legacy-cache-config=3D0x10102\000\00010\000\00=
0\000\000\000 */
-{ 66732 }, /* l2-stores-ops\000legacy cache\000Level 2 (or higher) last le=
vel cache write accesses\000legacy-cache-config=3D0x102\000\00010\000\000\0=
00\000\000 */
-{ 66613 }, /* l2-stores-reference\000legacy cache\000Level 2 (or higher) l=
ast level cache write accesses\000legacy-cache-config=3D0x102\000\00010\000=
\000\000\000\000 */
-{ 66499 }, /* l2-stores-refs\000legacy cache\000Level 2 (or higher) last l=
evel cache write accesses\000legacy-cache-config=3D0x102\000\00010\000\000\=
000\000\000 */
-{ 67191 }, /* l2-write\000legacy cache\000Level 2 (or higher) last level c=
ache write accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\00=
0\000 */
-{ 67642 }, /* l2-write-access\000legacy cache\000Level 2 (or higher) last =
level cache write accesses\000legacy-cache-config=3D0x102\000\00010\000\000=
\000\000\000 */
-{ 67872 }, /* l2-write-miss\000legacy cache\000Level 2 (or higher) last le=
vel cache write misses\000legacy-cache-config=3D0x10102\000\00010\000\000\0=
00\000\000 */
-{ 67757 }, /* l2-write-misses\000legacy cache\000Level 2 (or higher) last =
level cache write misses\000legacy-cache-config=3D0x10102\000\00010\000\000=
\000\000\000 */
-{ 67530 }, /* l2-write-ops\000legacy cache\000Level 2 (or higher) last lev=
el cache write accesses\000legacy-cache-config=3D0x102\000\00010\000\000\00=
0\000\000 */
-{ 67412 }, /* l2-write-reference\000legacy cache\000Level 2 (or higher) la=
st level cache write accesses\000legacy-cache-config=3D0x102\000\00010\000\=
000\000\000\000 */
-{ 67299 }, /* l2-write-refs\000legacy cache\000Level 2 (or higher) last le=
vel cache write accesses\000legacy-cache-config=3D0x102\000\00010\000\000\0=
00\000\000 */
-{ 55804 }, /* llc\000legacy cache\000Last level cache read accesses\000leg=
acy-cache-config=3D2\000\00010\000\000\000\000\000 */
-{ 62951 }, /* llc-access\000legacy cache\000Last level cache read accesses=
\000legacy-cache-config=3D2\000\00010\000\000\000\000\000 */
-{ 55882 }, /* llc-load\000legacy cache\000Last level cache read accesses\0=
00legacy-cache-config=3D2\000\00010\000\000\000\000\000 */
-{ 56233 }, /* llc-load-access\000legacy cache\000Last level cache read acc=
esses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000 */
-{ 56417 }, /* llc-load-miss\000legacy cache\000Last level cache read misse=
s\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000 */
-{ 56323 }, /* llc-load-misses\000legacy cache\000Last level cache read mis=
ses\000legacy-cache-config=3D0x10002\000\00000\000\000\000\000\000 */
-{ 56146 }, /* llc-load-ops\000legacy cache\000Last level cache read access=
es\000legacy-cache-config=3D2\000\00010\000\000\000\000\000 */
-{ 56053 }, /* llc-load-reference\000legacy cache\000Last level cache read =
accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000 */
-{ 55965 }, /* llc-load-refs\000legacy cache\000Last level cache read acces=
ses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000 */
-{ 56509 }, /* llc-loads\000legacy cache\000Last level cache read accesses\=
000legacy-cache-config=3D2\000\00000\000\000\000\000\000 */
-{ 56864 }, /* llc-loads-access\000legacy cache\000Last level cache read ac=
cesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000 */
-{ 57050 }, /* llc-loads-miss\000legacy cache\000Last level cache read miss=
es\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000 */
-{ 56955 }, /* llc-loads-misses\000legacy cache\000Last level cache read mi=
sses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000 */
-{ 56776 }, /* llc-loads-ops\000legacy cache\000Last level cache read acces=
ses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000 */
-{ 56682 }, /* llc-loads-reference\000legacy cache\000Last level cache read=
 accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000 */
-{ 56593 }, /* llc-loads-refs\000legacy cache\000Last level cache read acce=
sses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000 */
-{ 63125 }, /* llc-miss\000legacy cache\000Last level cache read misses\000=
legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000 */
-{ 63036 }, /* llc-misses\000legacy cache\000Last level cache read misses\0=
00legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000 */
-{ 62869 }, /* llc-ops\000legacy cache\000Last level cache read accesses\00=
0legacy-cache-config=3D2\000\00010\000\000\000\000\000 */
-{ 59760 }, /* llc-prefetch\000legacy cache\000Last level cache prefetch ac=
cesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000 */
-{ 60159 }, /* llc-prefetch-access\000legacy cache\000Last level cache pref=
etch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000 =
*/
-{ 60363 }, /* llc-prefetch-miss\000legacy cache\000Last level cache prefet=
ch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\000\000 */
-{ 60261 }, /* llc-prefetch-misses\000legacy cache\000Last level cache pref=
etch misses\000legacy-cache-config=3D0x10202\000\00000\000\000\000\000\000 =
*/
-{ 60060 }, /* llc-prefetch-ops\000legacy cache\000Last level cache prefetc=
h accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000 */
-{ 59955 }, /* llc-prefetch-reference\000legacy cache\000Last level cache p=
refetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\0=
00 */
-{ 59855 }, /* llc-prefetch-refs\000legacy cache\000Last level cache prefet=
ch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000 */
-{ 60463 }, /* llc-prefetches\000legacy cache\000Last level cache prefetch =
accesses\000legacy-cache-config=3D0x202\000\00000\000\000\000\000\000 */
-{ 60870 }, /* llc-prefetches-access\000legacy cache\000Last level cache pr=
efetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\00=
0 */
-{ 61078 }, /* llc-prefetches-miss\000legacy cache\000Last level cache pref=
etch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\000\000 =
*/
-{ 60974 }, /* llc-prefetches-misses\000legacy cache\000Last level cache pr=
efetch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\000\00=
0 */
-{ 60769 }, /* llc-prefetches-ops\000legacy cache\000Last level cache prefe=
tch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000 *=
/
-{ 60662 }, /* llc-prefetches-reference\000legacy cache\000Last level cache=
 prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000=
\000 */
-{ 60560 }, /* llc-prefetches-refs\000legacy cache\000Last level cache pref=
etch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000 =
*/
-{ 57143 }, /* llc-read\000legacy cache\000Last level cache read accesses\0=
00legacy-cache-config=3D2\000\00010\000\000\000\000\000 */
-{ 57494 }, /* llc-read-access\000legacy cache\000Last level cache read acc=
esses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000 */
-{ 57678 }, /* llc-read-miss\000legacy cache\000Last level cache read misse=
s\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000 */
-{ 57584 }, /* llc-read-misses\000legacy cache\000Last level cache read mis=
ses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000 */
-{ 57407 }, /* llc-read-ops\000legacy cache\000Last level cache read access=
es\000legacy-cache-config=3D2\000\00010\000\000\000\000\000 */
-{ 57314 }, /* llc-read-reference\000legacy cache\000Last level cache read =
accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000 */
-{ 57226 }, /* llc-read-refs\000legacy cache\000Last level cache read acces=
ses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000 */
-{ 62781 }, /* llc-reference\000legacy cache\000Last level cache read acces=
ses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000 */
-{ 62698 }, /* llc-refs\000legacy cache\000Last level cache read accesses\0=
00legacy-cache-config=3D2\000\00010\000\000\000\000\000 */
-{ 61939 }, /* llc-speculative-load\000legacy cache\000Last level cache pre=
fetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000=
 */
-{ 62370 }, /* llc-speculative-load-access\000legacy cache\000Last level ca=
che prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\=
000\000 */
-{ 62590 }, /* llc-speculative-load-miss\000legacy cache\000Last level cach=
e prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\00=
0\000 */
-{ 62480 }, /* llc-speculative-load-misses\000legacy cache\000Last level ca=
che prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\=
000\000 */
-{ 62263 }, /* llc-speculative-load-ops\000legacy cache\000Last level cache=
 prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000=
\000 */
-{ 62150 }, /* llc-speculative-load-reference\000legacy cache\000Last level=
 cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\0=
00\000\000 */
-{ 62042 }, /* llc-speculative-load-refs\000legacy cache\000Last level cach=
e prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\00=
0\000 */
-{ 61180 }, /* llc-speculative-read\000legacy cache\000Last level cache pre=
fetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000=
 */
-{ 61611 }, /* llc-speculative-read-access\000legacy cache\000Last level ca=
che prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\=
000\000 */
-{ 61831 }, /* llc-speculative-read-miss\000legacy cache\000Last level cach=
e prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\00=
0\000 */
-{ 61721 }, /* llc-speculative-read-misses\000legacy cache\000Last level ca=
che prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\=
000\000 */
-{ 61504 }, /* llc-speculative-read-ops\000legacy cache\000Last level cache=
 prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000=
\000 */
-{ 61391 }, /* llc-speculative-read-reference\000legacy cache\000Last level=
 cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\0=
00\000\000 */
-{ 61283 }, /* llc-speculative-read-refs\000legacy cache\000Last level cach=
e prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\00=
0\000 */
-{ 57770 }, /* llc-store\000legacy cache\000Last level cache write accesses=
\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000 */
-{ 58145 }, /* llc-store-access\000legacy cache\000Last level cache write a=
ccesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000 */
-{ 58337 }, /* llc-store-miss\000legacy cache\000Last level cache write mis=
ses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\000 */
-{ 58241 }, /* llc-store-misses\000legacy cache\000Last level cache write m=
isses\000legacy-cache-config=3D0x10102\000\00000\000\000\000\000\000 */
-{ 58052 }, /* llc-store-ops\000legacy cache\000Last level cache write acce=
sses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000 */
-{ 57953 }, /* llc-store-reference\000legacy cache\000Last level cache writ=
e accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000 */
-{ 57859 }, /* llc-store-refs\000legacy cache\000Last level cache write acc=
esses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000 */
-{ 58431 }, /* llc-stores\000legacy cache\000Last level cache write accesse=
s\000legacy-cache-config=3D0x102\000\00000\000\000\000\000\000 */
-{ 58810 }, /* llc-stores-access\000legacy cache\000Last level cache write =
accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000 */
-{ 59004 }, /* llc-stores-miss\000legacy cache\000Last level cache write mi=
sses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\000 */
-{ 58907 }, /* llc-stores-misses\000legacy cache\000Last level cache write =
misses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\000 */
-{ 58716 }, /* llc-stores-ops\000legacy cache\000Last level cache write acc=
esses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000 */
-{ 58616 }, /* llc-stores-reference\000legacy cache\000Last level cache wri=
te accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000 */
-{ 58521 }, /* llc-stores-refs\000legacy cache\000Last level cache write ac=
cesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000 */
-{ 59099 }, /* llc-write\000legacy cache\000Last level cache write accesses=
\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000 */
-{ 59474 }, /* llc-write-access\000legacy cache\000Last level cache write a=
ccesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000 */
-{ 59666 }, /* llc-write-miss\000legacy cache\000Last level cache write mis=
ses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\000 */
-{ 59570 }, /* llc-write-misses\000legacy cache\000Last level cache write m=
isses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\000 */
-{ 59381 }, /* llc-write-ops\000legacy cache\000Last level cache write acce=
sses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000 */
-{ 59282 }, /* llc-write-reference\000legacy cache\000Last level cache writ=
e accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000 */
-{ 59188 }, /* llc-write-refs\000legacy cache\000Last level cache write acc=
esses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000 */
-{ 114128 }, /* node\000legacy cache\000Local memory read accesses\000legac=
y-cache-config=3D6\000\00010\000\000\000\000\000 */
-{ 121053 }, /* node-access\000legacy cache\000Local memory read accesses\0=
00legacy-cache-config=3D6\000\00010\000\000\000\000\000 */
-{ 114203 }, /* node-load\000legacy cache\000Local memory read accesses\000=
legacy-cache-config=3D6\000\00010\000\000\000\000\000 */
-{ 114542 }, /* node-load-access\000legacy cache\000Local memory read acces=
ses\000legacy-cache-config=3D6\000\00010\000\000\000\000\000 */
-{ 114720 }, /* node-load-miss\000legacy cache\000Local memory read misses\=
000legacy-cache-config=3D0x10006\000\00010\000\000\000\000\000 */
-{ 114629 }, /* node-load-misses\000legacy cache\000Local memory read misse=
s\000legacy-cache-config=3D0x10006\000\00000\000\000\000\000\000 */
-{ 114458 }, /* node-load-ops\000legacy cache\000Local memory read accesses=
\000legacy-cache-config=3D6\000\00010\000\000\000\000\000 */
-{ 114368 }, /* node-load-reference\000legacy cache\000Local memory read ac=
cesses\000legacy-cache-config=3D6\000\00010\000\000\000\000\000 */
-{ 114283 }, /* node-load-refs\000legacy cache\000Local memory read accesse=
s\000legacy-cache-config=3D6\000\00010\000\000\000\000\000 */
-{ 114809 }, /* node-loads\000legacy cache\000Local memory read accesses\00=
0legacy-cache-config=3D6\000\00000\000\000\000\000\000 */
-{ 115152 }, /* node-loads-access\000legacy cache\000Local memory read acce=
sses\000legacy-cache-config=3D6\000\00010\000\000\000\000\000 */
-{ 115332 }, /* node-loads-miss\000legacy cache\000Local memory read misses=
\000legacy-cache-config=3D0x10006\000\00010\000\000\000\000\000 */
-{ 115240 }, /* node-loads-misses\000legacy cache\000Local memory read miss=
es\000legacy-cache-config=3D0x10006\000\00010\000\000\000\000\000 */
-{ 115067 }, /* node-loads-ops\000legacy cache\000Local memory read accesse=
s\000legacy-cache-config=3D6\000\00010\000\000\000\000\000 */
-{ 114976 }, /* node-loads-reference\000legacy cache\000Local memory read a=
ccesses\000legacy-cache-config=3D6\000\00010\000\000\000\000\000 */
-{ 114890 }, /* node-loads-refs\000legacy cache\000Local memory read access=
es\000legacy-cache-config=3D6\000\00010\000\000\000\000\000 */
-{ 121221 }, /* node-miss\000legacy cache\000Local memory read misses\000le=
gacy-cache-config=3D0x10006\000\00010\000\000\000\000\000 */
-{ 121135 }, /* node-misses\000legacy cache\000Local memory read misses\000=
legacy-cache-config=3D0x10006\000\00010\000\000\000\000\000 */
-{ 120974 }, /* node-ops\000legacy cache\000Local memory read accesses\000l=
egacy-cache-config=3D6\000\00010\000\000\000\000\000 */
-{ 117955 }, /* node-prefetch\000legacy cache\000Local memory prefetch acce=
sses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000 */
-{ 118342 }, /* node-prefetch-access\000legacy cache\000Local memory prefet=
ch accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000 */
-{ 118540 }, /* node-prefetch-miss\000legacy cache\000Local memory prefetch=
 misses\000legacy-cache-config=3D0x10206\000\00010\000\000\000\000\000 */
-{ 118441 }, /* node-prefetch-misses\000legacy cache\000Local memory prefet=
ch misses\000legacy-cache-config=3D0x10206\000\00000\000\000\000\000\000 */
-{ 118246 }, /* node-prefetch-ops\000legacy cache\000Local memory prefetch =
accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000 */
-{ 118144 }, /* node-prefetch-reference\000legacy cache\000Local memory pre=
fetch accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000=
 */
-{ 118047 }, /* node-prefetch-refs\000legacy cache\000Local memory prefetch=
 accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000 */
-{ 118637 }, /* node-prefetches\000legacy cache\000Local memory prefetch ac=
cesses\000legacy-cache-config=3D0x206\000\00000\000\000\000\000\000 */
-{ 119032 }, /* node-prefetches-access\000legacy cache\000Local memory pref=
etch accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000 =
*/
-{ 119234 }, /* node-prefetches-miss\000legacy cache\000Local memory prefet=
ch misses\000legacy-cache-config=3D0x10206\000\00010\000\000\000\000\000 */
-{ 119133 }, /* node-prefetches-misses\000legacy cache\000Local memory pref=
etch misses\000legacy-cache-config=3D0x10206\000\00010\000\000\000\000\000 =
*/
-{ 118934 }, /* node-prefetches-ops\000legacy cache\000Local memory prefetc=
h accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000 */
-{ 118830 }, /* node-prefetches-reference\000legacy cache\000Local memory p=
refetch accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\0=
00 */
-{ 118731 }, /* node-prefetches-refs\000legacy cache\000Local memory prefet=
ch accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000 */
-{ 115422 }, /* node-read\000legacy cache\000Local memory read accesses\000=
legacy-cache-config=3D6\000\00010\000\000\000\000\000 */
-{ 115761 }, /* node-read-access\000legacy cache\000Local memory read acces=
ses\000legacy-cache-config=3D6\000\00010\000\000\000\000\000 */
-{ 115939 }, /* node-read-miss\000legacy cache\000Local memory read misses\=
000legacy-cache-config=3D0x10006\000\00010\000\000\000\000\000 */
-{ 115848 }, /* node-read-misses\000legacy cache\000Local memory read misse=
s\000legacy-cache-config=3D0x10006\000\00010\000\000\000\000\000 */
-{ 115677 }, /* node-read-ops\000legacy cache\000Local memory read accesses=
\000legacy-cache-config=3D6\000\00010\000\000\000\000\000 */
-{ 115587 }, /* node-read-reference\000legacy cache\000Local memory read ac=
cesses\000legacy-cache-config=3D6\000\00010\000\000\000\000\000 */
-{ 115502 }, /* node-read-refs\000legacy cache\000Local memory read accesse=
s\000legacy-cache-config=3D6\000\00010\000\000\000\000\000 */
-{ 120889 }, /* node-reference\000legacy cache\000Local memory read accesse=
s\000legacy-cache-config=3D6\000\00010\000\000\000\000\000 */
-{ 120809 }, /* node-refs\000legacy cache\000Local memory read accesses\000=
legacy-cache-config=3D6\000\00010\000\000\000\000\000 */
-{ 120071 }, /* node-speculative-load\000legacy cache\000Local memory prefe=
tch accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000 *=
/
-{ 120490 }, /* node-speculative-load-access\000legacy cache\000Local memor=
y prefetch accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000\00=
0\000 */
-{ 120704 }, /* node-speculative-load-miss\000legacy cache\000Local memory =
prefetch misses\000legacy-cache-config=3D0x10206\000\00010\000\000\000\000\=
000 */
-{ 120597 }, /* node-speculative-load-misses\000legacy cache\000Local memor=
y prefetch misses\000legacy-cache-config=3D0x10206\000\00010\000\000\000\00=
0\000 */
-{ 120386 }, /* node-speculative-load-ops\000legacy cache\000Local memory p=
refetch accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\0=
00 */
-{ 120276 }, /* node-speculative-load-reference\000legacy cache\000Local me=
mory prefetch accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000=
\000\000 */
-{ 120171 }, /* node-speculative-load-refs\000legacy cache\000Local memory =
prefetch accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\=
000 */
-{ 119333 }, /* node-speculative-read\000legacy cache\000Local memory prefe=
tch accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000 *=
/
-{ 119752 }, /* node-speculative-read-access\000legacy cache\000Local memor=
y prefetch accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000\00=
0\000 */
-{ 119966 }, /* node-speculative-read-miss\000legacy cache\000Local memory =
prefetch misses\000legacy-cache-config=3D0x10206\000\00010\000\000\000\000\=
000 */
-{ 119859 }, /* node-speculative-read-misses\000legacy cache\000Local memor=
y prefetch misses\000legacy-cache-config=3D0x10206\000\00010\000\000\000\00=
0\000 */
-{ 119648 }, /* node-speculative-read-ops\000legacy cache\000Local memory p=
refetch accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\0=
00 */
-{ 119538 }, /* node-speculative-read-reference\000legacy cache\000Local me=
mory prefetch accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000=
\000\000 */
-{ 119433 }, /* node-speculative-read-refs\000legacy cache\000Local memory =
prefetch accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\=
000 */
-{ 116028 }, /* node-store\000legacy cache\000Local memory write accesses\0=
00legacy-cache-config=3D0x106\000\00010\000\000\000\000\000 */
-{ 116391 }, /* node-store-access\000legacy cache\000Local memory write acc=
esses\000legacy-cache-config=3D0x106\000\00010\000\000\000\000\000 */
-{ 116577 }, /* node-store-miss\000legacy cache\000Local memory write misse=
s\000legacy-cache-config=3D0x10106\000\00010\000\000\000\000\000 */
-{ 116484 }, /* node-store-misses\000legacy cache\000Local memory write mis=
ses\000legacy-cache-config=3D0x10106\000\00000\000\000\000\000\000 */
-{ 116301 }, /* node-store-ops\000legacy cache\000Local memory write access=
es\000legacy-cache-config=3D0x106\000\00010\000\000\000\000\000 */
-{ 116205 }, /* node-store-reference\000legacy cache\000Local memory write =
accesses\000legacy-cache-config=3D0x106\000\00010\000\000\000\000\000 */
-{ 116114 }, /* node-store-refs\000legacy cache\000Local memory write acces=
ses\000legacy-cache-config=3D0x106\000\00010\000\000\000\000\000 */
-{ 116668 }, /* node-stores\000legacy cache\000Local memory write accesses\=
000legacy-cache-config=3D0x106\000\00000\000\000\000\000\000 */
-{ 117035 }, /* node-stores-access\000legacy cache\000Local memory write ac=
cesses\000legacy-cache-config=3D0x106\000\00010\000\000\000\000\000 */
-{ 117223 }, /* node-stores-miss\000legacy cache\000Local memory write miss=
es\000legacy-cache-config=3D0x10106\000\00010\000\000\000\000\000 */
-{ 117129 }, /* node-stores-misses\000legacy cache\000Local memory write mi=
sses\000legacy-cache-config=3D0x10106\000\00010\000\000\000\000\000 */
-{ 116944 }, /* node-stores-ops\000legacy cache\000Local memory write acces=
ses\000legacy-cache-config=3D0x106\000\00010\000\000\000\000\000 */
-{ 116847 }, /* node-stores-reference\000legacy cache\000Local memory write=
 accesses\000legacy-cache-config=3D0x106\000\00010\000\000\000\000\000 */
-{ 116755 }, /* node-stores-refs\000legacy cache\000Local memory write acce=
sses\000legacy-cache-config=3D0x106\000\00010\000\000\000\000\000 */
-{ 117315 }, /* node-write\000legacy cache\000Local memory write accesses\0=
00legacy-cache-config=3D0x106\000\00010\000\000\000\000\000 */
-{ 117678 }, /* node-write-access\000legacy cache\000Local memory write acc=
esses\000legacy-cache-config=3D0x106\000\00010\000\000\000\000\000 */
-{ 117864 }, /* node-write-miss\000legacy cache\000Local memory write misse=
s\000legacy-cache-config=3D0x10106\000\00010\000\000\000\000\000 */
-{ 117771 }, /* node-write-misses\000legacy cache\000Local memory write mis=
ses\000legacy-cache-config=3D0x10106\000\00010\000\000\000\000\000 */
-{ 117588 }, /* node-write-ops\000legacy cache\000Local memory write access=
es\000legacy-cache-config=3D0x106\000\00010\000\000\000\000\000 */
-{ 117492 }, /* node-write-reference\000legacy cache\000Local memory write =
accesses\000legacy-cache-config=3D0x106\000\00010\000\000\000\000\000 */
-{ 117401 }, /* node-write-refs\000legacy cache\000Local memory write acces=
ses\000legacy-cache-config=3D0x106\000\00010\000\000\000\000\000 */
-{ 123400 }, /* ref-cycles\000legacy hardware\000Total cycles; not affected=
 by CPU frequency scaling\000legacy-hardware-config=3D9\000\00000\000\000\0=
00\000\000 */
-{ 123094 }, /* stalled-cycles-backend\000legacy hardware\000Stalled cycles=
 during retirement [This event is an alias of idle-cycles-backend]\000legac=
y-hardware-config=3D8\000\00000\000\000\000\000\000 */
-{ 122795 }, /* stalled-cycles-frontend\000legacy hardware\000Stalled cycle=
s during issue [This event is an alias of idle-cycles-frontend]\000legacy-h=
ardware-config=3D7\000\00000\000\000\000\000\000 */
+	/* bpc\000legacy cache\000Branch prediction unit read accesses\000legacy-=
cache-conf... */
+	{ 111480 },
+	/* bpc-access\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cac... */
+	{ 113849 },
+	/* bpc-load\000legacy cache\000Branch prediction unit read accesses\000le=
gacy-cache... */
+	{ 111564 },
+	/* bpc-load-access\000legacy cache\000Branch prediction unit read accesse=
s\000legac... */
+	{ 111939 },
+	/* bpc-load-miss\000legacy cache\000Branch prediction unit read misses\00=
0legacy-ca... */
+	{ 112135 },
+	/* bpc-load-misses\000legacy cache\000Branch prediction unit read misses\=
000legacy-... */
+	{ 112035 },
+	/* bpc-load-ops\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-c... */
+	{ 111846 },
+	/* bpc-load-reference\000legacy cache\000Branch prediction unit read acce=
sses\000le... */
+	{ 111747 },
+	/* bpc-load-refs\000legacy cache\000Branch prediction unit read accesses\=
000legacy-... */
+	{ 111653 },
+	/* bpc-loads\000legacy cache\000Branch prediction unit read accesses\000l=
egacy-cach... */
+	{ 112233 },
+	/* bpc-loads-access\000legacy cache\000Branch prediction unit read access=
es\000lega... */
+	{ 112612 },
+	/* bpc-loads-miss\000legacy cache\000Branch prediction unit read misses\0=
00legacy-c... */
+	{ 112810 },
+	/* bpc-loads-misses\000legacy cache\000Branch prediction unit read misses=
\000legacy... */
+	{ 112709 },
+	/* bpc-loads-ops\000legacy cache\000Branch prediction unit read accesses\=
000legacy-... */
+	{ 112518 },
+	/* bpc-loads-reference\000legacy cache\000Branch prediction unit read acc=
esses\000l... */
+	{ 112418 },
+	/* bpc-loads-refs\000legacy cache\000Branch prediction unit read accesses=
\000legacy... */
+	{ 112323 },
+	/* bpc-miss\000legacy cache\000Branch prediction unit read misses\000lega=
cy-cache-c... */
+	{ 114035 },
+	/* bpc-misses\000legacy cache\000Branch prediction unit read misses\000le=
gacy-cache... */
+	{ 113940 },
+	/* bpc-ops\000legacy cache\000Branch prediction unit read accesses\000leg=
acy-cache-... */
+	{ 113761 },
+	/* bpc-read\000legacy cache\000Branch prediction unit read accesses\000le=
gacy-cache... */
+	{ 112909 },
+	/* bpc-read-access\000legacy cache\000Branch prediction unit read accesse=
s\000legac... */
+	{ 113284 },
+	/* bpc-read-miss\000legacy cache\000Branch prediction unit read misses\00=
0legacy-ca... */
+	{ 113480 },
+	/* bpc-read-misses\000legacy cache\000Branch prediction unit read misses\=
000legacy-... */
+	{ 113380 },
+	/* bpc-read-ops\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-c... */
+	{ 113191 },
+	/* bpc-read-reference\000legacy cache\000Branch prediction unit read acce=
sses\000le... */
+	{ 113092 },
+	/* bpc-read-refs\000legacy cache\000Branch prediction unit read accesses\=
000legacy-... */
+	{ 112998 },
+	/* bpc-reference\000legacy cache\000Branch prediction unit read accesses\=
000legacy-... */
+	{ 113667 },
+	/* bpc-refs\000legacy cache\000Branch prediction unit read accesses\000le=
gacy-cache... */
+	{ 113578 },
+	/* bpu\000legacy cache\000Branch prediction unit read accesses\000legacy-=
cache-conf... */
+	{ 106184 },
+	/* bpu-access\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cac... */
+	{ 108553 },
+	/* bpu-load\000legacy cache\000Branch prediction unit read accesses\000le=
gacy-cache... */
+	{ 106268 },
+	/* bpu-load-access\000legacy cache\000Branch prediction unit read accesse=
s\000legac... */
+	{ 106643 },
+	/* bpu-load-miss\000legacy cache\000Branch prediction unit read misses\00=
0legacy-ca... */
+	{ 106839 },
+	/* bpu-load-misses\000legacy cache\000Branch prediction unit read misses\=
000legacy-... */
+	{ 106739 },
+	/* bpu-load-ops\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-c... */
+	{ 106550 },
+	/* bpu-load-reference\000legacy cache\000Branch prediction unit read acce=
sses\000le... */
+	{ 106451 },
+	/* bpu-load-refs\000legacy cache\000Branch prediction unit read accesses\=
000legacy-... */
+	{ 106357 },
+	/* bpu-loads\000legacy cache\000Branch prediction unit read accesses\000l=
egacy-cach... */
+	{ 106937 },
+	/* bpu-loads-access\000legacy cache\000Branch prediction unit read access=
es\000lega... */
+	{ 107316 },
+	/* bpu-loads-miss\000legacy cache\000Branch prediction unit read misses\0=
00legacy-c... */
+	{ 107514 },
+	/* bpu-loads-misses\000legacy cache\000Branch prediction unit read misses=
\000legacy... */
+	{ 107413 },
+	/* bpu-loads-ops\000legacy cache\000Branch prediction unit read accesses\=
000legacy-... */
+	{ 107222 },
+	/* bpu-loads-reference\000legacy cache\000Branch prediction unit read acc=
esses\000l... */
+	{ 107122 },
+	/* bpu-loads-refs\000legacy cache\000Branch prediction unit read accesses=
\000legacy... */
+	{ 107027 },
+	/* bpu-miss\000legacy cache\000Branch prediction unit read misses\000lega=
cy-cache-c... */
+	{ 108739 },
+	/* bpu-misses\000legacy cache\000Branch prediction unit read misses\000le=
gacy-cache... */
+	{ 108644 },
+	/* bpu-ops\000legacy cache\000Branch prediction unit read accesses\000leg=
acy-cache-... */
+	{ 108465 },
+	/* bpu-read\000legacy cache\000Branch prediction unit read accesses\000le=
gacy-cache... */
+	{ 107613 },
+	/* bpu-read-access\000legacy cache\000Branch prediction unit read accesse=
s\000legac... */
+	{ 107988 },
+	/* bpu-read-miss\000legacy cache\000Branch prediction unit read misses\00=
0legacy-ca... */
+	{ 108184 },
+	/* bpu-read-misses\000legacy cache\000Branch prediction unit read misses\=
000legacy-... */
+	{ 108084 },
+	/* bpu-read-ops\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-c... */
+	{ 107895 },
+	/* bpu-read-reference\000legacy cache\000Branch prediction unit read acce=
sses\000le... */
+	{ 107796 },
+	/* bpu-read-refs\000legacy cache\000Branch prediction unit read accesses\=
000legacy-... */
+	{ 107702 },
+	/* bpu-reference\000legacy cache\000Branch prediction unit read accesses\=
000legacy-... */
+	{ 108371 },
+	/* bpu-refs\000legacy cache\000Branch prediction unit read accesses\000le=
gacy-cache... */
+	{ 108282 },
+	/* branch\000legacy cache\000Branch prediction unit read accesses\000lega=
cy-cache-c... */
+	{ 100851 },
+	/* branch-access\000legacy cache\000Branch prediction unit read accesses\=
000legacy-... */
+	{ 103295 },
+	/* branch-instructions\000legacy hardware\000Retired branch instructions =
[This even... */
+	{ 122452 },
+	/* branch-load\000legacy cache\000Branch prediction unit read accesses\00=
0legacy-ca... */
+	{ 100938 },
+	/* branch-load-access\000legacy cache\000Branch prediction unit read acce=
sses\000le... */
+	{ 101325 },
+	/* branch-load-miss\000legacy cache\000Branch prediction unit read misses=
\000legacy... */
+	{ 101527 },
+	/* branch-load-misses\000legacy cache\000Branch prediction unit read miss=
es\000lega... */
+	{ 101424 },
+	/* branch-load-ops\000legacy cache\000Branch prediction unit read accesse=
s\000legac... */
+	{ 101229 },
+	/* branch-load-reference\000legacy cache\000Branch prediction unit read a=
ccesses\00... */
+	{ 101127 },
+	/* branch-load-refs\000legacy cache\000Branch prediction unit read access=
es\000lega... */
+	{ 101030 },
+	/* branch-loads\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-c... */
+	{ 101628 },
+	/* branch-loads-access\000legacy cache\000Branch prediction unit read acc=
esses\000l... */
+	{ 102019 },
+	/* branch-loads-miss\000legacy cache\000Branch prediction unit read misse=
s\000legac... */
+	{ 102223 },
+	/* branch-loads-misses\000legacy cache\000Branch prediction unit read mis=
ses\000leg... */
+	{ 102119 },
+	/* branch-loads-ops\000legacy cache\000Branch prediction unit read access=
es\000lega... */
+	{ 101922 },
+	/* branch-loads-reference\000legacy cache\000Branch prediction unit read =
accesses\0... */
+	{ 101819 },
+	/* branch-loads-refs\000legacy cache\000Branch prediction unit read acces=
ses\000leg... */
+	{ 101721 },
+	/* branch-miss\000legacy cache\000Branch prediction unit read misses\000l=
egacy-cach... */
+	{ 103389 },
+	/* branch-misses\000legacy hardware\000Mispredicted branch instructions\0=
00legacy-h... */
+	{ 122586 },
+	/* branch-ops\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cac... */
+	{ 103204 },
+	/* branch-read\000legacy cache\000Branch prediction unit read accesses\00=
0legacy-ca... */
+	{ 102325 },
+	/* branch-read-access\000legacy cache\000Branch prediction unit read acce=
sses\000le... */
+	{ 102712 },
+	/* branch-read-miss\000legacy cache\000Branch prediction unit read misses=
\000legacy... */
+	{ 102914 },
+	/* branch-read-misses\000legacy cache\000Branch prediction unit read miss=
es\000lega... */
+	{ 102811 },
+	/* branch-read-ops\000legacy cache\000Branch prediction unit read accesse=
s\000legac... */
+	{ 102616 },
+	/* branch-read-reference\000legacy cache\000Branch prediction unit read a=
ccesses\00... */
+	{ 102514 },
+	/* branch-read-refs\000legacy cache\000Branch prediction unit read access=
es\000lega... */
+	{ 102417 },
+	/* branch-reference\000legacy cache\000Branch prediction unit read access=
es\000lega... */
+	{ 103107 },
+	/* branch-refs\000legacy cache\000Branch prediction unit read accesses\00=
0legacy-ca... */
+	{ 103015 },
+	/* branches\000legacy hardware\000Retired branch instructions [This event=
 is an ali... */
+	{ 122318 },
+	/* branches-access\000legacy cache\000Branch prediction unit read accesse=
s\000legac... */
+	{ 105890 },
+	/* branches-load\000legacy cache\000Branch prediction unit read accesses\=
000legacy-... */
+	{ 103485 },
+	/* branches-load-access\000legacy cache\000Branch prediction unit read ac=
cesses\000... */
+	{ 103880 },
+	/* branches-load-miss\000legacy cache\000Branch prediction unit read miss=
es\000lega... */
+	{ 104086 },
+	/* branches-load-misses\000legacy cache\000Branch prediction unit read mi=
sses\000le... */
+	{ 103981 },
+	/* branches-load-ops\000legacy cache\000Branch prediction unit read acces=
ses\000leg... */
+	{ 103782 },
+	/* branches-load-reference\000legacy cache\000Branch prediction unit read=
 accesses\... */
+	{ 103678 },
+	/* branches-load-refs\000legacy cache\000Branch prediction unit read acce=
sses\000le... */
+	{ 103579 },
+	/* branches-loads\000legacy cache\000Branch prediction unit read accesses=
\000legacy... */
+	{ 104189 },
+	/* branches-loads-access\000legacy cache\000Branch prediction unit read a=
ccesses\00... */
+	{ 104588 },
+	/* branches-loads-miss\000legacy cache\000Branch prediction unit read mis=
ses\000leg... */
+	{ 104796 },
+	/* branches-loads-misses\000legacy cache\000Branch prediction unit read m=
isses\000l... */
+	{ 104690 },
+	/* branches-loads-ops\000legacy cache\000Branch prediction unit read acce=
sses\000le... */
+	{ 104489 },
+	/* branches-loads-reference\000legacy cache\000Branch prediction unit rea=
d accesses... */
+	{ 104384 },
+	/* branches-loads-refs\000legacy cache\000Branch prediction unit read acc=
esses\000l... */
+	{ 104284 },
+	/* branches-miss\000legacy cache\000Branch prediction unit read misses\00=
0legacy-ca... */
+	{ 106086 },
+	/* branches-misses\000legacy cache\000Branch prediction unit read misses\=
000legacy-... */
+	{ 105986 },
+	/* branches-ops\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-c... */
+	{ 105797 },
+	/* branches-read\000legacy cache\000Branch prediction unit read accesses\=
000legacy-... */
+	{ 104900 },
+	/* branches-read-access\000legacy cache\000Branch prediction unit read ac=
cesses\000... */
+	{ 105295 },
+	/* branches-read-miss\000legacy cache\000Branch prediction unit read miss=
es\000lega... */
+	{ 105501 },
+	/* branches-read-misses\000legacy cache\000Branch prediction unit read mi=
sses\000le... */
+	{ 105396 },
+	/* branches-read-ops\000legacy cache\000Branch prediction unit read acces=
ses\000leg... */
+	{ 105197 },
+	/* branches-read-reference\000legacy cache\000Branch prediction unit read=
 accesses\... */
+	{ 105093 },
+	/* branches-read-refs\000legacy cache\000Branch prediction unit read acce=
sses\000le... */
+	{ 104994 },
+	/* branches-reference\000legacy cache\000Branch prediction unit read acce=
sses\000le... */
+	{ 105698 },
+	/* branches-refs\000legacy cache\000Branch prediction unit read accesses\=
000legacy-... */
+	{ 105604 },
+	/* btb\000legacy cache\000Branch prediction unit read accesses\000legacy-=
cache-conf... */
+	{ 108832 },
+	/* btb-access\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cac... */
+	{ 111201 },
+	/* btb-load\000legacy cache\000Branch prediction unit read accesses\000le=
gacy-cache... */
+	{ 108916 },
+	/* btb-load-access\000legacy cache\000Branch prediction unit read accesse=
s\000legac... */
+	{ 109291 },
+	/* btb-load-miss\000legacy cache\000Branch prediction unit read misses\00=
0legacy-ca... */
+	{ 109487 },
+	/* btb-load-misses\000legacy cache\000Branch prediction unit read misses\=
000legacy-... */
+	{ 109387 },
+	/* btb-load-ops\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-c... */
+	{ 109198 },
+	/* btb-load-reference\000legacy cache\000Branch prediction unit read acce=
sses\000le... */
+	{ 109099 },
+	/* btb-load-refs\000legacy cache\000Branch prediction unit read accesses\=
000legacy-... */
+	{ 109005 },
+	/* btb-loads\000legacy cache\000Branch prediction unit read accesses\000l=
egacy-cach... */
+	{ 109585 },
+	/* btb-loads-access\000legacy cache\000Branch prediction unit read access=
es\000lega... */
+	{ 109964 },
+	/* btb-loads-miss\000legacy cache\000Branch prediction unit read misses\0=
00legacy-c... */
+	{ 110162 },
+	/* btb-loads-misses\000legacy cache\000Branch prediction unit read misses=
\000legacy... */
+	{ 110061 },
+	/* btb-loads-ops\000legacy cache\000Branch prediction unit read accesses\=
000legacy-... */
+	{ 109870 },
+	/* btb-loads-reference\000legacy cache\000Branch prediction unit read acc=
esses\000l... */
+	{ 109770 },
+	/* btb-loads-refs\000legacy cache\000Branch prediction unit read accesses=
\000legacy... */
+	{ 109675 },
+	/* btb-miss\000legacy cache\000Branch prediction unit read misses\000lega=
cy-cache-c... */
+	{ 111387 },
+	/* btb-misses\000legacy cache\000Branch prediction unit read misses\000le=
gacy-cache... */
+	{ 111292 },
+	/* btb-ops\000legacy cache\000Branch prediction unit read accesses\000leg=
acy-cache-... */
+	{ 111113 },
+	/* btb-read\000legacy cache\000Branch prediction unit read accesses\000le=
gacy-cache... */
+	{ 110261 },
+	/* btb-read-access\000legacy cache\000Branch prediction unit read accesse=
s\000legac... */
+	{ 110636 },
+	/* btb-read-miss\000legacy cache\000Branch prediction unit read misses\00=
0legacy-ca... */
+	{ 110832 },
+	/* btb-read-misses\000legacy cache\000Branch prediction unit read misses\=
000legacy-... */
+	{ 110732 },
+	/* btb-read-ops\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-c... */
+	{ 110543 },
+	/* btb-read-reference\000legacy cache\000Branch prediction unit read acce=
sses\000le... */
+	{ 110444 },
+	/* btb-read-refs\000legacy cache\000Branch prediction unit read accesses\=
000legacy-... */
+	{ 110350 },
+	/* btb-reference\000legacy cache\000Branch prediction unit read accesses\=
000legacy-... */
+	{ 111019 },
+	/* btb-refs\000legacy cache\000Branch prediction unit read accesses\000le=
gacy-cache... */
+	{ 110930 },
+	/* bus-cycles\000legacy hardware\000Bus cycles, which can be different fr=
om total c... */
+	{ 122682 },
+	/* cache-misses\000legacy hardware\000Cache misses. Usually this indicate=
s Last Lev... */
+	{ 122075 },
+	/* cache-references\000legacy hardware\000Cache accesses. Usually this in=
dicates La... */
+	{ 121805 },
+	/* cpu-cycles\000legacy hardware\000Total cycles. Be wary of what happens=
 during CP... */
+	{ 121305 },
+	/* cycles\000legacy hardware\000Total cycles. Be wary of what happens dur=
ing CPU fr... */
+	{ 121467 },
+	/* d-tlb\000legacy cache\000Data TLB read accesses\000legacy-cache-config=
=3D3\000\000... */
+	{ 78952 },
+	/* d-tlb-access\000legacy cache\000Data TLB read accesses\000legacy-cache=
-config=3D3\... */
+	{ 85655 },
+	/* d-tlb-load\000legacy cache\000Data TLB read accesses\000legacy-cache-c=
onfig=3D3\00... */
+	{ 79024 },
+	/* d-tlb-load-access\000legacy cache\000Data TLB read accesses\000legacy-=
cache-conf... */
+	{ 79351 },
+	/* d-tlb-load-miss\000legacy cache\000Data TLB read misses\000legacy-cach=
e-config=3D0... */
+	{ 79523 },
+	/* d-tlb-load-misses\000legacy cache\000Data TLB read misses\000legacy-ca=
che-config... */
+	{ 79435 },
+	/* d-tlb-load-ops\000legacy cache\000Data TLB read accesses\000legacy-cac=
he-config=3D... */
+	{ 79270 },
+	/* d-tlb-load-reference\000legacy cache\000Data TLB read accesses\000lega=
cy-cache-c... */
+	{ 79183 },
+	/* d-tlb-load-refs\000legacy cache\000Data TLB read accesses\000legacy-ca=
che-config... */
+	{ 79101 },
+	/* d-tlb-loads\000legacy cache\000Data TLB read accesses\000legacy-cache-=
config=3D3\0... */
+	{ 79609 },
+	/* d-tlb-loads-access\000legacy cache\000Data TLB read accesses\000legacy=
-cache-con... */
+	{ 79940 },
+	/* d-tlb-loads-miss\000legacy cache\000Data TLB read misses\000legacy-cac=
he-config=3D... */
+	{ 80114 },
+	/* d-tlb-loads-misses\000legacy cache\000Data TLB read misses\000legacy-c=
ache-confi... */
+	{ 80025 },
+	/* d-tlb-loads-ops\000legacy cache\000Data TLB read accesses\000legacy-ca=
che-config... */
+	{ 79858 },
+	/* d-tlb-loads-reference\000legacy cache\000Data TLB read accesses\000leg=
acy-cache-... */
+	{ 79770 },
+	/* d-tlb-loads-refs\000legacy cache\000Data TLB read accesses\000legacy-c=
ache-confi... */
+	{ 79687 },
+	/* d-tlb-miss\000legacy cache\000Data TLB read misses\000legacy-cache-con=
fig=3D0x1000... */
+	{ 85817 },
+	/* d-tlb-misses\000legacy cache\000Data TLB read misses\000legacy-cache-c=
onfig=3D0x10... */
+	{ 85734 },
+	/* d-tlb-ops\000legacy cache\000Data TLB read accesses\000legacy-cache-co=
nfig=3D3\000... */
+	{ 85579 },
+	/* d-tlb-prefetch\000legacy cache\000Data TLB prefetch accesses\000legacy=
-cache-con... */
+	{ 82650 },
+	/* d-tlb-prefetch-access\000legacy cache\000Data TLB prefetch accesses\00=
0legacy-ca... */
+	{ 83025 },
+	/* d-tlb-prefetch-miss\000legacy cache\000Data TLB prefetch misses\000leg=
acy-cache-... */
+	{ 83217 },
+	/* d-tlb-prefetch-misses\000legacy cache\000Data TLB prefetch misses\000l=
egacy-cach... */
+	{ 83121 },
+	/* d-tlb-prefetch-ops\000legacy cache\000Data TLB prefetch accesses\000le=
gacy-cache... */
+	{ 82932 },
+	/* d-tlb-prefetch-reference\000legacy cache\000Data TLB prefetch accesses=
\000legacy... */
+	{ 82833 },
+	/* d-tlb-prefetch-refs\000legacy cache\000Data TLB prefetch accesses\000l=
egacy-cach... */
+	{ 82739 },
+	/* d-tlb-prefetches\000legacy cache\000Data TLB prefetch accesses\000lega=
cy-cache-c... */
+	{ 83311 },
+	/* d-tlb-prefetches-access\000legacy cache\000Data TLB prefetch accesses\=
000legacy-... */
+	{ 83694 },
+	/* d-tlb-prefetches-miss\000legacy cache\000Data TLB prefetch misses\000l=
egacy-cach... */
+	{ 83890 },
+	/* d-tlb-prefetches-misses\000legacy cache\000Data TLB prefetch misses\00=
0legacy-ca... */
+	{ 83792 },
+	/* d-tlb-prefetches-ops\000legacy cache\000Data TLB prefetch accesses\000=
legacy-cac... */
+	{ 83599 },
+	/* d-tlb-prefetches-reference\000legacy cache\000Data TLB prefetch access=
es\000lega... */
+	{ 83498 },
+	/* d-tlb-prefetches-refs\000legacy cache\000Data TLB prefetch accesses\00=
0legacy-ca... */
+	{ 83402 },
+	/* d-tlb-read\000legacy cache\000Data TLB read accesses\000legacy-cache-c=
onfig=3D3\00... */
+	{ 80201 },
+	/* d-tlb-read-access\000legacy cache\000Data TLB read accesses\000legacy-=
cache-conf... */
+	{ 80528 },
+	/* d-tlb-read-miss\000legacy cache\000Data TLB read misses\000legacy-cach=
e-config=3D0... */
+	{ 80700 },
+	/* d-tlb-read-misses\000legacy cache\000Data TLB read misses\000legacy-ca=
che-config... */
+	{ 80612 },
+	/* d-tlb-read-ops\000legacy cache\000Data TLB read accesses\000legacy-cac=
he-config=3D... */
+	{ 80447 },
+	/* d-tlb-read-reference\000legacy cache\000Data TLB read accesses\000lega=
cy-cache-c... */
+	{ 80360 },
+	/* d-tlb-read-refs\000legacy cache\000Data TLB read accesses\000legacy-ca=
che-config... */
+	{ 80278 },
+	/* d-tlb-reference\000legacy cache\000Data TLB read accesses\000legacy-ca=
che-config... */
+	{ 85497 },
+	/* d-tlb-refs\000legacy cache\000Data TLB read accesses\000legacy-cache-c=
onfig=3D3\00... */
+	{ 85420 },
+	/* d-tlb-speculative-load\000legacy cache\000Data TLB prefetch accesses\0=
00legacy-c... */
+	{ 84703 },
+	/* d-tlb-speculative-load-access\000legacy cache\000Data TLB prefetch acc=
esses\000l... */
+	{ 85110 },
+	/* d-tlb-speculative-load-miss\000legacy cache\000Data TLB prefetch misse=
s\000legac... */
+	{ 85318 },
+	/* d-tlb-speculative-load-misses\000legacy cache\000Data TLB prefetch mis=
ses\000leg... */
+	{ 85214 },
+	/* d-tlb-speculative-load-ops\000legacy cache\000Data TLB prefetch access=
es\000lega... */
+	{ 85009 },
+	/* d-tlb-speculative-load-reference\000legacy cache\000Data TLB prefetch =
accesses\0... */
+	{ 84902 },
+	/* d-tlb-speculative-load-refs\000legacy cache\000Data TLB prefetch acces=
ses\000leg... */
+	{ 84800 },
+	/* d-tlb-speculative-read\000legacy cache\000Data TLB prefetch accesses\0=
00legacy-c... */
+	{ 83986 },
+	/* d-tlb-speculative-read-access\000legacy cache\000Data TLB prefetch acc=
esses\000l... */
+	{ 84393 },
+	/* d-tlb-speculative-read-miss\000legacy cache\000Data TLB prefetch misse=
s\000legac... */
+	{ 84601 },
+	/* d-tlb-speculative-read-misses\000legacy cache\000Data TLB prefetch mis=
ses\000leg... */
+	{ 84497 },
+	/* d-tlb-speculative-read-ops\000legacy cache\000Data TLB prefetch access=
es\000lega... */
+	{ 84292 },
+	/* d-tlb-speculative-read-reference\000legacy cache\000Data TLB prefetch =
accesses\0... */
+	{ 84185 },
+	/* d-tlb-speculative-read-refs\000legacy cache\000Data TLB prefetch acces=
ses\000leg... */
+	{ 84083 },
+	/* d-tlb-store\000legacy cache\000Data TLB write accesses\000legacy-cache=
-config=3D0x... */
+	{ 80786 },
+	/* d-tlb-store-access\000legacy cache\000Data TLB write accesses\000legac=
y-cache-co... */
+	{ 81137 },
+	/* d-tlb-store-miss\000legacy cache\000Data TLB write misses\000legacy-ca=
che-config... */
+	{ 81317 },
+	/* d-tlb-store-misses\000legacy cache\000Data TLB write misses\000legacy-=
cache-conf... */
+	{ 81227 },
+	/* d-tlb-store-ops\000legacy cache\000Data TLB write accesses\000legacy-c=
ache-confi... */
+	{ 81050 },
+	/* d-tlb-store-reference\000legacy cache\000Data TLB write accesses\000le=
gacy-cache... */
+	{ 80957 },
+	/* d-tlb-store-refs\000legacy cache\000Data TLB write accesses\000legacy-=
cache-conf... */
+	{ 80869 },
+	/* d-tlb-stores\000legacy cache\000Data TLB write accesses\000legacy-cach=
e-config=3D0... */
+	{ 81405 },
+	/* d-tlb-stores-access\000legacy cache\000Data TLB write accesses\000lega=
cy-cache-c... */
+	{ 81760 },
+	/* d-tlb-stores-miss\000legacy cache\000Data TLB write misses\000legacy-c=
ache-confi... */
+	{ 81942 },
+	/* d-tlb-stores-misses\000legacy cache\000Data TLB write misses\000legacy=
-cache-con... */
+	{ 81851 },
+	/* d-tlb-stores-ops\000legacy cache\000Data TLB write accesses\000legacy-=
cache-conf... */
+	{ 81672 },
+	/* d-tlb-stores-reference\000legacy cache\000Data TLB write accesses\000l=
egacy-cach... */
+	{ 81578 },
+	/* d-tlb-stores-refs\000legacy cache\000Data TLB write accesses\000legacy=
-cache-con... */
+	{ 81489 },
+	/* d-tlb-write\000legacy cache\000Data TLB write accesses\000legacy-cache=
-config=3D0x... */
+	{ 82031 },
+	/* d-tlb-write-access\000legacy cache\000Data TLB write accesses\000legac=
y-cache-co... */
+	{ 82382 },
+	/* d-tlb-write-miss\000legacy cache\000Data TLB write misses\000legacy-ca=
che-config... */
+	{ 82562 },
+	/* d-tlb-write-misses\000legacy cache\000Data TLB write misses\000legacy-=
cache-conf... */
+	{ 82472 },
+	/* d-tlb-write-ops\000legacy cache\000Data TLB write accesses\000legacy-c=
ache-confi... */
+	{ 82295 },
+	/* d-tlb-write-reference\000legacy cache\000Data TLB write accesses\000le=
gacy-cache... */
+	{ 82202 },
+	/* d-tlb-write-refs\000legacy cache\000Data TLB write accesses\000legacy-=
cache-conf... */
+	{ 82114 },
+	/* data-tlb\000legacy cache\000Data TLB read accesses\000legacy-cache-con=
fig=3D3\000\... */
+	{ 85898 },
+	/* data-tlb-access\000legacy cache\000Data TLB read accesses\000legacy-ca=
che-config... */
+	{ 92823 },
+	/* data-tlb-load\000legacy cache\000Data TLB read accesses\000legacy-cach=
e-config=3D3... */
+	{ 85973 },
+	/* data-tlb-load-access\000legacy cache\000Data TLB read accesses\000lega=
cy-cache-c... */
+	{ 86312 },
+	/* data-tlb-load-miss\000legacy cache\000Data TLB read misses\000legacy-c=
ache-confi... */
+	{ 86490 },
+	/* data-tlb-load-misses\000legacy cache\000Data TLB read misses\000legacy=
-cache-con... */
+	{ 86399 },
+	/* data-tlb-load-ops\000legacy cache\000Data TLB read accesses\000legacy-=
cache-conf... */
+	{ 86228 },
+	/* data-tlb-load-reference\000legacy cache\000Data TLB read accesses\000l=
egacy-cach... */
+	{ 86138 },
+	/* data-tlb-load-refs\000legacy cache\000Data TLB read accesses\000legacy=
-cache-con... */
+	{ 86053 },
+	/* data-tlb-loads\000legacy cache\000Data TLB read accesses\000legacy-cac=
he-config=3D... */
+	{ 86579 },
+	/* data-tlb-loads-access\000legacy cache\000Data TLB read accesses\000leg=
acy-cache-... */
+	{ 86922 },
+	/* data-tlb-loads-miss\000legacy cache\000Data TLB read misses\000legacy-=
cache-conf... */
+	{ 87102 },
+	/* data-tlb-loads-misses\000legacy cache\000Data TLB read misses\000legac=
y-cache-co... */
+	{ 87010 },
+	/* data-tlb-loads-ops\000legacy cache\000Data TLB read accesses\000legacy=
-cache-con... */
+	{ 86837 },
+	/* data-tlb-loads-reference\000legacy cache\000Data TLB read accesses\000=
legacy-cac... */
+	{ 86746 },
+	/* data-tlb-loads-refs\000legacy cache\000Data TLB read accesses\000legac=
y-cache-co... */
+	{ 86660 },
+	/* data-tlb-miss\000legacy cache\000Data TLB read misses\000legacy-cache-=
config=3D0x1... */
+	{ 92991 },
+	/* data-tlb-misses\000legacy cache\000Data TLB read misses\000legacy-cach=
e-config=3D0... */
+	{ 92905 },
+	/* data-tlb-ops\000legacy cache\000Data TLB read accesses\000legacy-cache=
-config=3D3\... */
+	{ 92744 },
+	/* data-tlb-prefetch\000legacy cache\000Data TLB prefetch accesses\000leg=
acy-cache-... */
+	{ 89725 },
+	/* data-tlb-prefetch-access\000legacy cache\000Data TLB prefetch accesses=
\000legacy... */
+	{ 90112 },
+	/* data-tlb-prefetch-miss\000legacy cache\000Data TLB prefetch misses\000=
legacy-cac... */
+	{ 90310 },
+	/* data-tlb-prefetch-misses\000legacy cache\000Data TLB prefetch misses\0=
00legacy-c... */
+	{ 90211 },
+	/* data-tlb-prefetch-ops\000legacy cache\000Data TLB prefetch accesses\00=
0legacy-ca... */
+	{ 90016 },
+	/* data-tlb-prefetch-reference\000legacy cache\000Data TLB prefetch acces=
ses\000leg... */
+	{ 89914 },
+	/* data-tlb-prefetch-refs\000legacy cache\000Data TLB prefetch accesses\0=
00legacy-c... */
+	{ 89817 },
+	/* data-tlb-prefetches\000legacy cache\000Data TLB prefetch accesses\000l=
egacy-cach... */
+	{ 90407 },
+	/* data-tlb-prefetches-access\000legacy cache\000Data TLB prefetch access=
es\000lega... */
+	{ 90802 },
+	/* data-tlb-prefetches-miss\000legacy cache\000Data TLB prefetch misses\0=
00legacy-c... */
+	{ 91004 },
+	/* data-tlb-prefetches-misses\000legacy cache\000Data TLB prefetch misses=
\000legacy... */
+	{ 90903 },
+	/* data-tlb-prefetches-ops\000legacy cache\000Data TLB prefetch accesses\=
000legacy-... */
+	{ 90704 },
+	/* data-tlb-prefetches-reference\000legacy cache\000Data TLB prefetch acc=
esses\000l... */
+	{ 90600 },
+	/* data-tlb-prefetches-refs\000legacy cache\000Data TLB prefetch accesses=
\000legacy... */
+	{ 90501 },
+	/* data-tlb-read\000legacy cache\000Data TLB read accesses\000legacy-cach=
e-config=3D3... */
+	{ 87192 },
+	/* data-tlb-read-access\000legacy cache\000Data TLB read accesses\000lega=
cy-cache-c... */
+	{ 87531 },
+	/* data-tlb-read-miss\000legacy cache\000Data TLB read misses\000legacy-c=
ache-confi... */
+	{ 87709 },
+	/* data-tlb-read-misses\000legacy cache\000Data TLB read misses\000legacy=
-cache-con... */
+	{ 87618 },
+	/* data-tlb-read-ops\000legacy cache\000Data TLB read accesses\000legacy-=
cache-conf... */
+	{ 87447 },
+	/* data-tlb-read-reference\000legacy cache\000Data TLB read accesses\000l=
egacy-cach... */
+	{ 87357 },
+	/* data-tlb-read-refs\000legacy cache\000Data TLB read accesses\000legacy=
-cache-con... */
+	{ 87272 },
+	/* data-tlb-reference\000legacy cache\000Data TLB read accesses\000legacy=
-cache-con... */
+	{ 92659 },
+	/* data-tlb-refs\000legacy cache\000Data TLB read accesses\000legacy-cach=
e-config=3D3... */
+	{ 92579 },
+	/* data-tlb-speculative-load\000legacy cache\000Data TLB prefetch accesse=
s\000legac... */
+	{ 91841 },
+	/* data-tlb-speculative-load-access\000legacy cache\000Data TLB prefetch =
accesses\0... */
+	{ 92260 },
+	/* data-tlb-speculative-load-miss\000legacy cache\000Data TLB prefetch mi=
sses\000le... */
+	{ 92474 },
+	/* data-tlb-speculative-load-misses\000legacy cache\000Data TLB prefetch =
misses\000... */
+	{ 92367 },
+	/* data-tlb-speculative-load-ops\000legacy cache\000Data TLB prefetch acc=
esses\000l... */
+	{ 92156 },
+	/* data-tlb-speculative-load-reference\000legacy cache\000Data TLB prefet=
ch accesse... */
+	{ 92046 },
+	/* data-tlb-speculative-load-refs\000legacy cache\000Data TLB prefetch ac=
cesses\000... */
+	{ 91941 },
+	/* data-tlb-speculative-read\000legacy cache\000Data TLB prefetch accesse=
s\000legac... */
+	{ 91103 },
+	/* data-tlb-speculative-read-access\000legacy cache\000Data TLB prefetch =
accesses\0... */
+	{ 91522 },
+	/* data-tlb-speculative-read-miss\000legacy cache\000Data TLB prefetch mi=
sses\000le... */
+	{ 91736 },
+	/* data-tlb-speculative-read-misses\000legacy cache\000Data TLB prefetch =
misses\000... */
+	{ 91629 },
+	/* data-tlb-speculative-read-ops\000legacy cache\000Data TLB prefetch acc=
esses\000l... */
+	{ 91418 },
+	/* data-tlb-speculative-read-reference\000legacy cache\000Data TLB prefet=
ch accesse... */
+	{ 91308 },
+	/* data-tlb-speculative-read-refs\000legacy cache\000Data TLB prefetch ac=
cesses\000... */
+	{ 91203 },
+	/* data-tlb-store\000legacy cache\000Data TLB write accesses\000legacy-ca=
che-config... */
+	{ 87798 },
+	/* data-tlb-store-access\000legacy cache\000Data TLB write accesses\000le=
gacy-cache... */
+	{ 88161 },
+	/* data-tlb-store-miss\000legacy cache\000Data TLB write misses\000legacy=
-cache-con... */
+	{ 88347 },
+	/* data-tlb-store-misses\000legacy cache\000Data TLB write misses\000lega=
cy-cache-c... */
+	{ 88254 },
+	/* data-tlb-store-ops\000legacy cache\000Data TLB write accesses\000legac=
y-cache-co... */
+	{ 88071 },
+	/* data-tlb-store-reference\000legacy cache\000Data TLB write accesses\00=
0legacy-ca... */
+	{ 87975 },
+	/* data-tlb-store-refs\000legacy cache\000Data TLB write accesses\000lega=
cy-cache-c... */
+	{ 87884 },
+	/* data-tlb-stores\000legacy cache\000Data TLB write accesses\000legacy-c=
ache-confi... */
+	{ 88438 },
+	/* data-tlb-stores-access\000legacy cache\000Data TLB write accesses\000l=
egacy-cach... */
+	{ 88805 },
+	/* data-tlb-stores-miss\000legacy cache\000Data TLB write misses\000legac=
y-cache-co... */
+	{ 88993 },
+	/* data-tlb-stores-misses\000legacy cache\000Data TLB write misses\000leg=
acy-cache-... */
+	{ 88899 },
+	/* data-tlb-stores-ops\000legacy cache\000Data TLB write accesses\000lega=
cy-cache-c... */
+	{ 88714 },
+	/* data-tlb-stores-reference\000legacy cache\000Data TLB write accesses\0=
00legacy-c... */
+	{ 88617 },
+	/* data-tlb-stores-refs\000legacy cache\000Data TLB write accesses\000leg=
acy-cache-... */
+	{ 88525 },
+	/* data-tlb-write\000legacy cache\000Data TLB write accesses\000legacy-ca=
che-config... */
+	{ 89085 },
+	/* data-tlb-write-access\000legacy cache\000Data TLB write accesses\000le=
gacy-cache... */
+	{ 89448 },
+	/* data-tlb-write-miss\000legacy cache\000Data TLB write misses\000legacy=
-cache-con... */
+	{ 89634 },
+	/* data-tlb-write-misses\000legacy cache\000Data TLB write misses\000lega=
cy-cache-c... */
+	{ 89541 },
+	/* data-tlb-write-ops\000legacy cache\000Data TLB write accesses\000legac=
y-cache-co... */
+	{ 89358 },
+	/* data-tlb-write-reference\000legacy cache\000Data TLB write accesses\00=
0legacy-ca... */
+	{ 89262 },
+	/* data-tlb-write-refs\000legacy cache\000Data TLB write accesses\000lega=
cy-cache-c... */
+	{ 89171 },
+	/* dtlb\000legacy cache\000Data TLB read accesses\000legacy-cache-config=
=3D3\000\0001... */
+	{ 72083 },
+	/* dtlb-access\000legacy cache\000Data TLB read accesses\000legacy-cache-=
config=3D3\0... */
+	{ 78712 },
+	/* dtlb-load\000legacy cache\000Data TLB read accesses\000legacy-cache-co=
nfig=3D3\000... */
+	{ 72154 },
+	/* dtlb-load-access\000legacy cache\000Data TLB read accesses\000legacy-c=
ache-confi... */
+	{ 72477 },
+	/* dtlb-load-miss\000legacy cache\000Data TLB read misses\000legacy-cache=
-config=3D0x... */
+	{ 72647 },
+	/* dtlb-load-misses\000legacy cache\000Data TLB read misses\000legacy-cac=
he-config=3D... */
+	{ 72560 },
+	/* dtlb-load-ops\000legacy cache\000Data TLB read accesses\000legacy-cach=
e-config=3D3... */
+	{ 72397 },
+	/* dtlb-load-reference\000legacy cache\000Data TLB read accesses\000legac=
y-cache-co... */
+	{ 72311 },
+	/* dtlb-load-refs\000legacy cache\000Data TLB read accesses\000legacy-cac=
he-config=3D... */
+	{ 72230 },
+	/* dtlb-loads\000legacy cache\000Data TLB read accesses\000legacy-cache-c=
onfig=3D3\00... */
+	{ 72732 },
+	/* dtlb-loads-access\000legacy cache\000Data TLB read accesses\000legacy-=
cache-conf... */
+	{ 73059 },
+	/* dtlb-loads-miss\000legacy cache\000Data TLB read misses\000legacy-cach=
e-config=3D0... */
+	{ 73231 },
+	/* dtlb-loads-misses\000legacy cache\000Data TLB read misses\000legacy-ca=
che-config... */
+	{ 73143 },
+	/* dtlb-loads-ops\000legacy cache\000Data TLB read accesses\000legacy-cac=
he-config=3D... */
+	{ 72978 },
+	/* dtlb-loads-reference\000legacy cache\000Data TLB read accesses\000lega=
cy-cache-c... */
+	{ 72891 },
+	/* dtlb-loads-refs\000legacy cache\000Data TLB read accesses\000legacy-ca=
che-config... */
+	{ 72809 },
+	/* dtlb-miss\000legacy cache\000Data TLB read misses\000legacy-cache-conf=
ig=3D0x10003... */
+	{ 78872 },
+	/* dtlb-misses\000legacy cache\000Data TLB read misses\000legacy-cache-co=
nfig=3D0x100... */
+	{ 78790 },
+	/* dtlb-ops\000legacy cache\000Data TLB read accesses\000legacy-cache-con=
fig=3D3\000\... */
+	{ 78637 },
+	/* dtlb-prefetch\000legacy cache\000Data TLB prefetch accesses\000legacy-=
cache-conf... */
+	{ 75738 },
+	/* dtlb-prefetch-access\000legacy cache\000Data TLB prefetch accesses\000=
legacy-cac... */
+	{ 76109 },
+	/* dtlb-prefetch-miss\000legacy cache\000Data TLB prefetch misses\000lega=
cy-cache-c... */
+	{ 76299 },
+	/* dtlb-prefetch-misses\000legacy cache\000Data TLB prefetch misses\000le=
gacy-cache... */
+	{ 76204 },
+	/* dtlb-prefetch-ops\000legacy cache\000Data TLB prefetch accesses\000leg=
acy-cache-... */
+	{ 76017 },
+	/* dtlb-prefetch-reference\000legacy cache\000Data TLB prefetch accesses\=
000legacy-... */
+	{ 75919 },
+	/* dtlb-prefetch-refs\000legacy cache\000Data TLB prefetch accesses\000le=
gacy-cache... */
+	{ 75826 },
+	/* dtlb-prefetches\000legacy cache\000Data TLB prefetch accesses\000legac=
y-cache-co... */
+	{ 76392 },
+	/* dtlb-prefetches-access\000legacy cache\000Data TLB prefetch accesses\0=
00legacy-c... */
+	{ 76771 },
+	/* dtlb-prefetches-miss\000legacy cache\000Data TLB prefetch misses\000le=
gacy-cache... */
+	{ 76965 },
+	/* dtlb-prefetches-misses\000legacy cache\000Data TLB prefetch misses\000=
legacy-cac... */
+	{ 76868 },
+	/* dtlb-prefetches-ops\000legacy cache\000Data TLB prefetch accesses\000l=
egacy-cach... */
+	{ 76677 },
+	/* dtlb-prefetches-reference\000legacy cache\000Data TLB prefetch accesse=
s\000legac... */
+	{ 76577 },
+	/* dtlb-prefetches-refs\000legacy cache\000Data TLB prefetch accesses\000=
legacy-cac... */
+	{ 76482 },
+	/* dtlb-read\000legacy cache\000Data TLB read accesses\000legacy-cache-co=
nfig=3D3\000... */
+	{ 73317 },
+	/* dtlb-read-access\000legacy cache\000Data TLB read accesses\000legacy-c=
ache-confi... */
+	{ 73640 },
+	/* dtlb-read-miss\000legacy cache\000Data TLB read misses\000legacy-cache=
-config=3D0x... */
+	{ 73810 },
+	/* dtlb-read-misses\000legacy cache\000Data TLB read misses\000legacy-cac=
he-config=3D... */
+	{ 73723 },
+	/* dtlb-read-ops\000legacy cache\000Data TLB read accesses\000legacy-cach=
e-config=3D3... */
+	{ 73560 },
+	/* dtlb-read-reference\000legacy cache\000Data TLB read accesses\000legac=
y-cache-co... */
+	{ 73474 },
+	/* dtlb-read-refs\000legacy cache\000Data TLB read accesses\000legacy-cac=
he-config=3D... */
+	{ 73393 },
+	/* dtlb-reference\000legacy cache\000Data TLB read accesses\000legacy-cac=
he-config=3D... */
+	{ 78556 },
+	/* dtlb-refs\000legacy cache\000Data TLB read accesses\000legacy-cache-co=
nfig=3D3\000... */
+	{ 78480 },
+	/* dtlb-speculative-load\000legacy cache\000Data TLB prefetch accesses\00=
0legacy-ca... */
+	{ 77770 },
+	/* dtlb-speculative-load-access\000legacy cache\000Data TLB prefetch acce=
sses\000le... */
+	{ 78173 },
+	/* dtlb-speculative-load-miss\000legacy cache\000Data TLB prefetch misses=
\000legacy... */
+	{ 78379 },
+	/* dtlb-speculative-load-misses\000legacy cache\000Data TLB prefetch miss=
es\000lega... */
+	{ 78276 },
+	/* dtlb-speculative-load-ops\000legacy cache\000Data TLB prefetch accesse=
s\000legac... */
+	{ 78073 },
+	/* dtlb-speculative-load-reference\000legacy cache\000Data TLB prefetch a=
ccesses\00... */
+	{ 77967 },
+	/* dtlb-speculative-load-refs\000legacy cache\000Data TLB prefetch access=
es\000lega... */
+	{ 77866 },
+	/* dtlb-speculative-read\000legacy cache\000Data TLB prefetch accesses\00=
0legacy-ca... */
+	{ 77060 },
+	/* dtlb-speculative-read-access\000legacy cache\000Data TLB prefetch acce=
sses\000le... */
+	{ 77463 },
+	/* dtlb-speculative-read-miss\000legacy cache\000Data TLB prefetch misses=
\000legacy... */
+	{ 77669 },
+	/* dtlb-speculative-read-misses\000legacy cache\000Data TLB prefetch miss=
es\000lega... */
+	{ 77566 },
+	/* dtlb-speculative-read-ops\000legacy cache\000Data TLB prefetch accesse=
s\000legac... */
+	{ 77363 },
+	/* dtlb-speculative-read-reference\000legacy cache\000Data TLB prefetch a=
ccesses\00... */
+	{ 77257 },
+	/* dtlb-speculative-read-refs\000legacy cache\000Data TLB prefetch access=
es\000lega... */
+	{ 77156 },
+	/* dtlb-store\000legacy cache\000Data TLB write accesses\000legacy-cache-=
config=3D0x1... */
+	{ 73895 },
+	/* dtlb-store-access\000legacy cache\000Data TLB write accesses\000legacy=
-cache-con... */
+	{ 74242 },
+	/* dtlb-store-miss\000legacy cache\000Data TLB write misses\000legacy-cac=
he-config=3D... */
+	{ 74420 },
+	/* dtlb-store-misses\000legacy cache\000Data TLB write misses\000legacy-c=
ache-confi... */
+	{ 74331 },
+	/* dtlb-store-ops\000legacy cache\000Data TLB write accesses\000legacy-ca=
che-config... */
+	{ 74156 },
+	/* dtlb-store-reference\000legacy cache\000Data TLB write accesses\000leg=
acy-cache-... */
+	{ 74064 },
+	/* dtlb-store-refs\000legacy cache\000Data TLB write accesses\000legacy-c=
ache-confi... */
+	{ 73977 },
+	/* dtlb-stores\000legacy cache\000Data TLB write accesses\000legacy-cache=
-config=3D0x... */
+	{ 74507 },
+	/* dtlb-stores-access\000legacy cache\000Data TLB write accesses\000legac=
y-cache-co... */
+	{ 74858 },
+	/* dtlb-stores-miss\000legacy cache\000Data TLB write misses\000legacy-ca=
che-config... */
+	{ 75038 },
+	/* dtlb-stores-misses\000legacy cache\000Data TLB write misses\000legacy-=
cache-conf... */
+	{ 74948 },
+	/* dtlb-stores-ops\000legacy cache\000Data TLB write accesses\000legacy-c=
ache-confi... */
+	{ 74771 },
+	/* dtlb-stores-reference\000legacy cache\000Data TLB write accesses\000le=
gacy-cache... */
+	{ 74678 },
+	/* dtlb-stores-refs\000legacy cache\000Data TLB write accesses\000legacy-=
cache-conf... */
+	{ 74590 },
+	/* dtlb-write\000legacy cache\000Data TLB write accesses\000legacy-cache-=
config=3D0x1... */
+	{ 75126 },
+	/* dtlb-write-access\000legacy cache\000Data TLB write accesses\000legacy=
-cache-con... */
+	{ 75473 },
+	/* dtlb-write-miss\000legacy cache\000Data TLB write misses\000legacy-cac=
he-config=3D... */
+	{ 75651 },
+	/* dtlb-write-misses\000legacy cache\000Data TLB write misses\000legacy-c=
ache-confi... */
+	{ 75562 },
+	/* dtlb-write-ops\000legacy cache\000Data TLB write accesses\000legacy-ca=
che-config... */
+	{ 75387 },
+	/* dtlb-write-reference\000legacy cache\000Data TLB write accesses\000leg=
acy-cache-... */
+	{ 75295 },
+	/* dtlb-write-refs\000legacy cache\000Data TLB write accesses\000legacy-c=
ache-confi... */
+	{ 75208 },
+	/* i-tlb\000legacy cache\000Instruction TLB read accesses\000legacy-cache=
-config=3D4\... */
+	{ 95555 },
+	/* i-tlb-access\000legacy cache\000Instruction TLB read accesses\000legac=
y-cache-co... */
+	{ 97799 },
+	/* i-tlb-load\000legacy cache\000Instruction TLB read accesses\000legacy-=
cache-conf... */
+	{ 95634 },
+	/* i-tlb-load-access\000legacy cache\000Instruction TLB read accesses\000=
legacy-cac... */
+	{ 95989 },
+	/* i-tlb-load-miss\000legacy cache\000Instruction TLB read misses\000lega=
cy-cache-c... */
+	{ 96175 },
+	/* i-tlb-load-misses\000legacy cache\000Instruction TLB read misses\000le=
gacy-cache... */
+	{ 96080 },
+	/* i-tlb-load-ops\000legacy cache\000Instruction TLB read accesses\000leg=
acy-cache-... */
+	{ 95901 },
+	/* i-tlb-load-reference\000legacy cache\000Instruction TLB read accesses\=
000legacy-... */
+	{ 95807 },
+	/* i-tlb-load-refs\000legacy cache\000Instruction TLB read accesses\000le=
gacy-cache... */
+	{ 95718 },
+	/* i-tlb-loads\000legacy cache\000Instruction TLB read accesses\000legacy=
-cache-con... */
+	{ 96268 },
+	/* i-tlb-loads-access\000legacy cache\000Instruction TLB read accesses\00=
0legacy-ca... */
+	{ 96627 },
+	/* i-tlb-loads-miss\000legacy cache\000Instruction TLB read misses\000leg=
acy-cache-... */
+	{ 96815 },
+	/* i-tlb-loads-misses\000legacy cache\000Instruction TLB read misses\000l=
egacy-cach... */
+	{ 96719 },
+	/* i-tlb-loads-ops\000legacy cache\000Instruction TLB read accesses\000le=
gacy-cache... */
+	{ 96538 },
+	/* i-tlb-loads-reference\000legacy cache\000Instruction TLB read accesses=
\000legacy... */
+	{ 96443 },
+	/* i-tlb-loads-refs\000legacy cache\000Instruction TLB read accesses\000l=
egacy-cach... */
+	{ 96353 },
+	/* i-tlb-miss\000legacy cache\000Instruction TLB read misses\000legacy-ca=
che-config... */
+	{ 97975 },
+	/* i-tlb-misses\000legacy cache\000Instruction TLB read misses\000legacy-=
cache-conf... */
+	{ 97885 },
+	/* i-tlb-ops\000legacy cache\000Instruction TLB read accesses\000legacy-c=
ache-confi... */
+	{ 97716 },
+	/* i-tlb-read\000legacy cache\000Instruction TLB read accesses\000legacy-=
cache-conf... */
+	{ 96909 },
+	/* i-tlb-read-access\000legacy cache\000Instruction TLB read accesses\000=
legacy-cac... */
+	{ 97264 },
+	/* i-tlb-read-miss\000legacy cache\000Instruction TLB read misses\000lega=
cy-cache-c... */
+	{ 97450 },
+	/* i-tlb-read-misses\000legacy cache\000Instruction TLB read misses\000le=
gacy-cache... */
+	{ 97355 },
+	/* i-tlb-read-ops\000legacy cache\000Instruction TLB read accesses\000leg=
acy-cache-... */
+	{ 97176 },
+	/* i-tlb-read-reference\000legacy cache\000Instruction TLB read accesses\=
000legacy-... */
+	{ 97082 },
+	/* i-tlb-read-refs\000legacy cache\000Instruction TLB read accesses\000le=
gacy-cache... */
+	{ 96993 },
+	/* i-tlb-reference\000legacy cache\000Instruction TLB read accesses\000le=
gacy-cache... */
+	{ 97627 },
+	/* i-tlb-refs\000legacy cache\000Instruction TLB read accesses\000legacy-=
cache-conf... */
+	{ 97543 },
+	/* idle-cycles-backend\000legacy hardware\000Stalled cycles during retire=
ment [This... */
+	{ 123247 },
+	/* idle-cycles-frontend\000legacy hardware\000Stalled cycles during issue=
 [This eve... */
+	{ 122945 },
+	/* instruction-tlb\000legacy cache\000Instruction TLB read accesses\000le=
gacy-cache... */
+	{ 98063 },
+	/* instruction-tlb-access\000legacy cache\000Instruction TLB read accesse=
s\000legac... */
+	{ 100557 },
+	/* instruction-tlb-load\000legacy cache\000Instruction TLB read accesses\=
000legacy-... */
+	{ 98152 },
+	/* instruction-tlb-load-access\000legacy cache\000Instruction TLB read ac=
cesses\000... */
+	{ 98547 },
+	/* instruction-tlb-load-miss\000legacy cache\000Instruction TLB read miss=
es\000lega... */
+	{ 98753 },
+	/* instruction-tlb-load-misses\000legacy cache\000Instruction TLB read mi=
sses\000le... */
+	{ 98648 },
+	/* instruction-tlb-load-ops\000legacy cache\000Instruction TLB read acces=
ses\000leg... */
+	{ 98449 },
+	/* instruction-tlb-load-reference\000legacy cache\000Instruction TLB read=
 accesses\... */
+	{ 98345 },
+	/* instruction-tlb-load-refs\000legacy cache\000Instruction TLB read acce=
sses\000le... */
+	{ 98246 },
+	/* instruction-tlb-loads\000legacy cache\000Instruction TLB read accesses=
\000legacy... */
+	{ 98856 },
+	/* instruction-tlb-loads-access\000legacy cache\000Instruction TLB read a=
ccesses\00... */
+	{ 99255 },
+	/* instruction-tlb-loads-miss\000legacy cache\000Instruction TLB read mis=
ses\000leg... */
+	{ 99463 },
+	/* instruction-tlb-loads-misses\000legacy cache\000Instruction TLB read m=
isses\000l... */
+	{ 99357 },
+	/* instruction-tlb-loads-ops\000legacy cache\000Instruction TLB read acce=
sses\000le... */
+	{ 99156 },
+	/* instruction-tlb-loads-reference\000legacy cache\000Instruction TLB rea=
d accesses... */
+	{ 99051 },
+	/* instruction-tlb-loads-refs\000legacy cache\000Instruction TLB read acc=
esses\000l... */
+	{ 98951 },
+	/* instruction-tlb-miss\000legacy cache\000Instruction TLB read misses\00=
0legacy-ca... */
+	{ 100753 },
+	/* instruction-tlb-misses\000legacy cache\000Instruction TLB read misses\=
000legacy-... */
+	{ 100653 },
+	/* instruction-tlb-ops\000legacy cache\000Instruction TLB read accesses\0=
00legacy-c... */
+	{ 100464 },
+	/* instruction-tlb-read\000legacy cache\000Instruction TLB read accesses\=
000legacy-... */
+	{ 99567 },
+	/* instruction-tlb-read-access\000legacy cache\000Instruction TLB read ac=
cesses\000... */
+	{ 99962 },
+	/* instruction-tlb-read-miss\000legacy cache\000Instruction TLB read miss=
es\000lega... */
+	{ 100168 },
+	/* instruction-tlb-read-misses\000legacy cache\000Instruction TLB read mi=
sses\000le... */
+	{ 100063 },
+	/* instruction-tlb-read-ops\000legacy cache\000Instruction TLB read acces=
ses\000leg... */
+	{ 99864 },
+	/* instruction-tlb-read-reference\000legacy cache\000Instruction TLB read=
 accesses\... */
+	{ 99760 },
+	/* instruction-tlb-read-refs\000legacy cache\000Instruction TLB read acce=
sses\000le... */
+	{ 99661 },
+	/* instruction-tlb-reference\000legacy cache\000Instruction TLB read acce=
sses\000le... */
+	{ 100365 },
+	/* instruction-tlb-refs\000legacy cache\000Instruction TLB read accesses\=
000legacy-... */
+	{ 100271 },
+	/* instructions\000legacy hardware\000Retired instructions. Be careful, t=
hese can b... */
+	{ 121629 },
+	/* itlb\000legacy cache\000Instruction TLB read accesses\000legacy-cache-=
config=3D4\0... */
+	{ 93075 },
+	/* itlb-access\000legacy cache\000Instruction TLB read accesses\000legacy=
-cache-con... */
+	{ 95294 },
+	/* itlb-load\000legacy cache\000Instruction TLB read accesses\000legacy-c=
ache-confi... */
+	{ 93153 },
+	/* itlb-load-access\000legacy cache\000Instruction TLB read accesses\000l=
egacy-cach... */
+	{ 93504 },
+	/* itlb-load-miss\000legacy cache\000Instruction TLB read misses\000legac=
y-cache-co... */
+	{ 93688 },
+	/* itlb-load-misses\000legacy cache\000Instruction TLB read misses\000leg=
acy-cache-... */
+	{ 93594 },
+	/* itlb-load-ops\000legacy cache\000Instruction TLB read accesses\000lega=
cy-cache-c... */
+	{ 93417 },
+	/* itlb-load-reference\000legacy cache\000Instruction TLB read accesses\0=
00legacy-c... */
+	{ 93324 },
+	/* itlb-load-refs\000legacy cache\000Instruction TLB read accesses\000leg=
acy-cache-... */
+	{ 93236 },
+	/* itlb-loads\000legacy cache\000Instruction TLB read accesses\000legacy-=
cache-conf... */
+	{ 93780 },
+	/* itlb-loads-access\000legacy cache\000Instruction TLB read accesses\000=
legacy-cac... */
+	{ 94135 },
+	/* itlb-loads-miss\000legacy cache\000Instruction TLB read misses\000lega=
cy-cache-c... */
+	{ 94321 },
+	/* itlb-loads-misses\000legacy cache\000Instruction TLB read misses\000le=
gacy-cache... */
+	{ 94226 },
+	/* itlb-loads-ops\000legacy cache\000Instruction TLB read accesses\000leg=
acy-cache-... */
+	{ 94047 },
+	/* itlb-loads-reference\000legacy cache\000Instruction TLB read accesses\=
000legacy-... */
+	{ 93953 },
+	/* itlb-loads-refs\000legacy cache\000Instruction TLB read accesses\000le=
gacy-cache... */
+	{ 93864 },
+	/* itlb-miss\000legacy cache\000Instruction TLB read misses\000legacy-cac=
he-config=3D... */
+	{ 95468 },
+	/* itlb-misses\000legacy cache\000Instruction TLB read misses\000legacy-c=
ache-confi... */
+	{ 95379 },
+	/* itlb-ops\000legacy cache\000Instruction TLB read accesses\000legacy-ca=
che-config... */
+	{ 95212 },
+	/* itlb-read\000legacy cache\000Instruction TLB read accesses\000legacy-c=
ache-confi... */
+	{ 94414 },
+	/* itlb-read-access\000legacy cache\000Instruction TLB read accesses\000l=
egacy-cach... */
+	{ 94765 },
+	/* itlb-read-miss\000legacy cache\000Instruction TLB read misses\000legac=
y-cache-co... */
+	{ 94949 },
+	/* itlb-read-misses\000legacy cache\000Instruction TLB read misses\000leg=
acy-cache-... */
+	{ 94855 },
+	/* itlb-read-ops\000legacy cache\000Instruction TLB read accesses\000lega=
cy-cache-c... */
+	{ 94678 },
+	/* itlb-read-reference\000legacy cache\000Instruction TLB read accesses\0=
00legacy-c... */
+	{ 94585 },
+	/* itlb-read-refs\000legacy cache\000Instruction TLB read accesses\000leg=
acy-cache-... */
+	{ 94497 },
+	/* itlb-reference\000legacy cache\000Instruction TLB read accesses\000leg=
acy-cache-... */
+	{ 95124 },
+	/* itlb-refs\000legacy cache\000Instruction TLB read accesses\000legacy-c=
ache-confi... */
+	{ 95041 },
+	/* l1-d\000legacy cache\000Level 1 data cache read accesses\000legacy-cac=
he-config=3D... */
+	{ 8037 },
+	/* l1-d-access\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-... */
+	{ 15406 },
+	/* l1-d-load\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-co... */
+	{ 8118 },
+	/* l1-d-load-access\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-c... */
+	{ 8481 },
+	/* l1-d-load-miss\000legacy cache\000Level 1 data cache read misses\000le=
gacy-cache... */
+	{ 8671 },
+	/* l1-d-load-misses\000legacy cache\000Level 1 data cache read misses\000=
legacy-cac... */
+	{ 8574 },
+	/* l1-d-load-ops\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cach... */
+	{ 8391 },
+	/* l1-d-load-reference\000legacy cache\000Level 1 data cache read accesse=
s\000legac... */
+	{ 8295 },
+	/* l1-d-load-refs\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cac... */
+	{ 8204 },
+	/* l1-d-loads\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-c... */
+	{ 8766 },
+	/* l1-d-loads-access\000legacy cache\000Level 1 data cache read accesses\=
000legacy-... */
+	{ 9133 },
+	/* l1-d-loads-miss\000legacy cache\000Level 1 data cache read misses\000l=
egacy-cach... */
+	{ 9325 },
+	/* l1-d-loads-misses\000legacy cache\000Level 1 data cache read misses\00=
0legacy-ca... */
+	{ 9227 },
+	/* l1-d-loads-ops\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cac... */
+	{ 9042 },
+	/* l1-d-loads-reference\000legacy cache\000Level 1 data cache read access=
es\000lega... */
+	{ 8945 },
+	/* l1-d-loads-refs\000legacy cache\000Level 1 data cache read accesses\00=
0legacy-ca... */
+	{ 8853 },
+	/* l1-d-miss\000legacy cache\000Level 1 data cache read misses\000legacy-=
cache-conf... */
+	{ 15586 },
+	/* l1-d-misses\000legacy cache\000Level 1 data cache read misses\000legac=
y-cache-co... */
+	{ 15494 },
+	/* l1-d-ops\000legacy cache\000Level 1 data cache read accesses\000legacy=
-cache-con... */
+	{ 15321 },
+	/* l1-d-prefetch\000legacy cache\000Level 1 data cache prefetch accesses\=
000legacy-... */
+	{ 12122 },
+	/* l1-d-prefetch-access\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000... */
+	{ 12533 },
+	/* l1-d-prefetch-miss\000legacy cache\000Level 1 data cache prefetch miss=
es\000lega... */
+	{ 12743 },
+	/* l1-d-prefetch-misses\000legacy cache\000Level 1 data cache prefetch mi=
sses\000le... */
+	{ 12638 },
+	/* l1-d-prefetch-ops\000legacy cache\000Level 1 data cache prefetch acces=
ses\000leg... */
+	{ 12431 },
+	/* l1-d-prefetch-reference\000legacy cache\000Level 1 data cache prefetch=
 accesses\... */
+	{ 12323 },
+	/* l1-d-prefetch-refs\000legacy cache\000Level 1 data cache prefetch acce=
sses\000le... */
+	{ 12220 },
+	/* l1-d-prefetches\000legacy cache\000Level 1 data cache prefetch accesse=
s\000legac... */
+	{ 12846 },
+	/* l1-d-prefetches-access\000legacy cache\000Level 1 data cache prefetch =
accesses\0... */
+	{ 13265 },
+	/* l1-d-prefetches-miss\000legacy cache\000Level 1 data cache prefetch mi=
sses\000le... */
+	{ 13479 },
+	/* l1-d-prefetches-misses\000legacy cache\000Level 1 data cache prefetch =
misses\000... */
+	{ 13372 },
+	/* l1-d-prefetches-ops\000legacy cache\000Level 1 data cache prefetch acc=
esses\000l... */
+	{ 13161 },
+	/* l1-d-prefetches-reference\000legacy cache\000Level 1 data cache prefet=
ch accesse... */
+	{ 13051 },
+	/* l1-d-prefetches-refs\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000... */
+	{ 12946 },
+	/* l1-d-read\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-co... */
+	{ 9421 },
+	/* l1-d-read-access\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-c... */
+	{ 9784 },
+	/* l1-d-read-miss\000legacy cache\000Level 1 data cache read misses\000le=
gacy-cache... */
+	{ 9974 },
+	/* l1-d-read-misses\000legacy cache\000Level 1 data cache read misses\000=
legacy-cac... */
+	{ 9877 },
+	/* l1-d-read-ops\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cach... */
+	{ 9694 },
+	/* l1-d-read-reference\000legacy cache\000Level 1 data cache read accesse=
s\000legac... */
+	{ 9598 },
+	/* l1-d-read-refs\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cac... */
+	{ 9507 },
+	/* l1-d-reference\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cac... */
+	{ 15230 },
+	/* l1-d-refs\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-co... */
+	{ 15144 },
+	/* l1-d-speculative-load\000legacy cache\000Level 1 data cache prefetch a=
ccesses\00... */
+	{ 14364 },
+	/* l1-d-speculative-load-access\000legacy cache\000Level 1 data cache pre=
fetch acce... */
+	{ 14807 },
+	/* l1-d-speculative-load-miss\000legacy cache\000Level 1 data cache prefe=
tch misses... */
+	{ 15033 },
+	/* l1-d-speculative-load-misses\000legacy cache\000Level 1 data cache pre=
fetch miss... */
+	{ 14920 },
+	/* l1-d-speculative-load-ops\000legacy cache\000Level 1 data cache prefet=
ch accesse... */
+	{ 14697 },
+	/* l1-d-speculative-load-reference\000legacy cache\000Level 1 data cache =
prefetch a... */
+	{ 14581 },
+	/* l1-d-speculative-load-refs\000legacy cache\000Level 1 data cache prefe=
tch access... */
+	{ 14470 },
+	/* l1-d-speculative-read\000legacy cache\000Level 1 data cache prefetch a=
ccesses\00... */
+	{ 13584 },
+	/* l1-d-speculative-read-access\000legacy cache\000Level 1 data cache pre=
fetch acce... */
+	{ 14027 },
+	/* l1-d-speculative-read-miss\000legacy cache\000Level 1 data cache prefe=
tch misses... */
+	{ 14253 },
+	/* l1-d-speculative-read-misses\000legacy cache\000Level 1 data cache pre=
fetch miss... */
+	{ 14140 },
+	/* l1-d-speculative-read-ops\000legacy cache\000Level 1 data cache prefet=
ch accesse... */
+	{ 13917 },
+	/* l1-d-speculative-read-reference\000legacy cache\000Level 1 data cache =
prefetch a... */
+	{ 13801 },
+	/* l1-d-speculative-read-refs\000legacy cache\000Level 1 data cache prefe=
tch access... */
+	{ 13690 },
+	/* l1-d-store\000legacy cache\000Level 1 data cache write accesses\000leg=
acy-cache-... */
+	{ 10069 },
+	/* l1-d-store-access\000legacy cache\000Level 1 data cache write accesses=
\000legacy... */
+	{ 10456 },
+	/* l1-d-store-miss\000legacy cache\000Level 1 data cache write misses\000=
legacy-cac... */
+	{ 10654 },
+	/* l1-d-store-misses\000legacy cache\000Level 1 data cache write misses\0=
00legacy-c... */
+	{ 10555 },
+	/* l1-d-store-ops\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-ca... */
+	{ 10360 },
+	/* l1-d-store-reference\000legacy cache\000Level 1 data cache write acces=
ses\000leg... */
+	{ 10258 },
+	/* l1-d-store-refs\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-c... */
+	{ 10161 },
+	/* l1-d-stores\000legacy cache\000Level 1 data cache write accesses\000le=
gacy-cache... */
+	{ 10751 },
+	/* l1-d-stores-access\000legacy cache\000Level 1 data cache write accesse=
s\000legac... */
+	{ 11142 },
+	/* l1-d-stores-miss\000legacy cache\000Level 1 data cache write misses\00=
0legacy-ca... */
+	{ 11342 },
+	/* l1-d-stores-misses\000legacy cache\000Level 1 data cache write misses\=
000legacy-... */
+	{ 11242 },
+	/* l1-d-stores-ops\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-c... */
+	{ 11045 },
+	/* l1-d-stores-reference\000legacy cache\000Level 1 data cache write acce=
sses\000le... */
+	{ 10942 },
+	/* l1-d-stores-refs\000legacy cache\000Level 1 data cache write accesses\=
000legacy-... */
+	{ 10844 },
+	/* l1-d-write\000legacy cache\000Level 1 data cache write accesses\000leg=
acy-cache-... */
+	{ 11440 },
+	/* l1-d-write-access\000legacy cache\000Level 1 data cache write accesses=
\000legacy... */
+	{ 11827 },
+	/* l1-d-write-miss\000legacy cache\000Level 1 data cache write misses\000=
legacy-cac... */
+	{ 12025 },
+	/* l1-d-write-misses\000legacy cache\000Level 1 data cache write misses\0=
00legacy-c... */
+	{ 11926 },
+	/* l1-d-write-ops\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-ca... */
+	{ 11731 },
+	/* l1-d-write-reference\000legacy cache\000Level 1 data cache write acces=
ses\000leg... */
+	{ 11629 },
+	/* l1-d-write-refs\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-c... */
+	{ 11532 },
+	/* l1-data\000legacy cache\000Level 1 data cache read accesses\000legacy-=
cache-conf... */
+	{ 23238 },
+	/* l1-data-access\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cac... */
+	{ 30829 },
+	/* l1-data-load\000legacy cache\000Level 1 data cache read accesses\000le=
gacy-cache... */
+	{ 23322 },
+	/* l1-data-load-access\000legacy cache\000Level 1 data cache read accesse=
s\000legac... */
+	{ 23697 },
+	/* l1-data-load-miss\000legacy cache\000Level 1 data cache read misses\00=
0legacy-ca... */
+	{ 23893 },
+	/* l1-data-load-misses\000legacy cache\000Level 1 data cache read misses\=
000legacy-... */
+	{ 23793 },
+	/* l1-data-load-ops\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-c... */
+	{ 23604 },
+	/* l1-data-load-reference\000legacy cache\000Level 1 data cache read acce=
sses\000le... */
+	{ 23505 },
+	/* l1-data-load-refs\000legacy cache\000Level 1 data cache read accesses\=
000legacy-... */
+	{ 23411 },
+	/* l1-data-loads\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cach... */
+	{ 23991 },
+	/* l1-data-loads-access\000legacy cache\000Level 1 data cache read access=
es\000lega... */
+	{ 24370 },
+	/* l1-data-loads-miss\000legacy cache\000Level 1 data cache read misses\0=
00legacy-c... */
+	{ 24568 },
+	/* l1-data-loads-misses\000legacy cache\000Level 1 data cache read misses=
\000legacy... */
+	{ 24467 },
+	/* l1-data-loads-ops\000legacy cache\000Level 1 data cache read accesses\=
000legacy-... */
+	{ 24276 },
+	/* l1-data-loads-reference\000legacy cache\000Level 1 data cache read acc=
esses\000l... */
+	{ 24176 },
+	/* l1-data-loads-refs\000legacy cache\000Level 1 data cache read accesses=
\000legacy... */
+	{ 24081 },
+	/* l1-data-miss\000legacy cache\000Level 1 data cache read misses\000lega=
cy-cache-c... */
+	{ 31015 },
+	/* l1-data-misses\000legacy cache\000Level 1 data cache read misses\000le=
gacy-cache... */
+	{ 30920 },
+	/* l1-data-ops\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-... */
+	{ 30741 },
+	/* l1-data-prefetch\000legacy cache\000Level 1 data cache prefetch access=
es\000lega... */
+	{ 27452 },
+	/* l1-data-prefetch-access\000legacy cache\000Level 1 data cache prefetch=
 accesses\... */
+	{ 27875 },
+	/* l1-data-prefetch-miss\000legacy cache\000Level 1 data cache prefetch m=
isses\000l... */
+	{ 28091 },
+	/* l1-data-prefetch-misses\000legacy cache\000Level 1 data cache prefetch=
 misses\00... */
+	{ 27983 },
+	/* l1-data-prefetch-ops\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000... */
+	{ 27770 },
+	/* l1-data-prefetch-reference\000legacy cache\000Level 1 data cache prefe=
tch access... */
+	{ 27659 },
+	/* l1-data-prefetch-refs\000legacy cache\000Level 1 data cache prefetch a=
ccesses\00... */
+	{ 27553 },
+	/* l1-data-prefetches\000legacy cache\000Level 1 data cache prefetch acce=
sses\000le... */
+	{ 28197 },
+	/* l1-data-prefetches-access\000legacy cache\000Level 1 data cache prefet=
ch accesse... */
+	{ 28628 },
+	/* l1-data-prefetches-miss\000legacy cache\000Level 1 data cache prefetch=
 misses\00... */
+	{ 28848 },
+	/* l1-data-prefetches-misses\000legacy cache\000Level 1 data cache prefet=
ch misses\... */
+	{ 28738 },
+	/* l1-data-prefetches-ops\000legacy cache\000Level 1 data cache prefetch =
accesses\0... */
+	{ 28521 },
+	/* l1-data-prefetches-reference\000legacy cache\000Level 1 data cache pre=
fetch acce... */
+	{ 28408 },
+	/* l1-data-prefetches-refs\000legacy cache\000Level 1 data cache prefetch=
 accesses\... */
+	{ 28300 },
+	/* l1-data-read\000legacy cache\000Level 1 data cache read accesses\000le=
gacy-cache... */
+	{ 24667 },
+	/* l1-data-read-access\000legacy cache\000Level 1 data cache read accesse=
s\000legac... */
+	{ 25042 },
+	/* l1-data-read-miss\000legacy cache\000Level 1 data cache read misses\00=
0legacy-ca... */
+	{ 25238 },
+	/* l1-data-read-misses\000legacy cache\000Level 1 data cache read misses\=
000legacy-... */
+	{ 25138 },
+	/* l1-data-read-ops\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-c... */
+	{ 24949 },
+	/* l1-data-read-reference\000legacy cache\000Level 1 data cache read acce=
sses\000le... */
+	{ 24850 },
+	/* l1-data-read-refs\000legacy cache\000Level 1 data cache read accesses\=
000legacy-... */
+	{ 24756 },
+	/* l1-data-reference\000legacy cache\000Level 1 data cache read accesses\=
000legacy-... */
+	{ 30647 },
+	/* l1-data-refs\000legacy cache\000Level 1 data cache read accesses\000le=
gacy-cache... */
+	{ 30558 },
+	/* l1-data-speculative-load\000legacy cache\000Level 1 data cache prefetc=
h accesses... */
+	{ 29757 },
+	/* l1-data-speculative-load-access\000legacy cache\000Level 1 data cache =
prefetch a... */
+	{ 30212 },
+	/* l1-data-speculative-load-miss\000legacy cache\000Level 1 data cache pr=
efetch mis... */
+	{ 30444 },
+	/* l1-data-speculative-load-misses\000legacy cache\000Level 1 data cache =
prefetch m... */
+	{ 30328 },
+	/* l1-data-speculative-load-ops\000legacy cache\000Level 1 data cache pre=
fetch acce... */
+	{ 30099 },
+	/* l1-data-speculative-load-reference\000legacy cache\000Level 1 data cac=
he prefetc... */
+	{ 29980 },
+	/* l1-data-speculative-load-refs\000legacy cache\000Level 1 data cache pr=
efetch acc... */
+	{ 29866 },
+	/* l1-data-speculative-read\000legacy cache\000Level 1 data cache prefetc=
h accesses... */
+	{ 28956 },
+	/* l1-data-speculative-read-access\000legacy cache\000Level 1 data cache =
prefetch a... */
+	{ 29411 },
+	/* l1-data-speculative-read-miss\000legacy cache\000Level 1 data cache pr=
efetch mis... */
+	{ 29643 },
+	/* l1-data-speculative-read-misses\000legacy cache\000Level 1 data cache =
prefetch m... */
+	{ 29527 },
+	/* l1-data-speculative-read-ops\000legacy cache\000Level 1 data cache pre=
fetch acce... */
+	{ 29298 },
+	/* l1-data-speculative-read-reference\000legacy cache\000Level 1 data cac=
he prefetc... */
+	{ 29179 },
+	/* l1-data-speculative-read-refs\000legacy cache\000Level 1 data cache pr=
efetch acc... */
+	{ 29065 },
+	/* l1-data-store\000legacy cache\000Level 1 data cache write accesses\000=
legacy-cac... */
+	{ 25336 },
+	/* l1-data-store-access\000legacy cache\000Level 1 data cache write acces=
ses\000leg... */
+	{ 25735 },
+	/* l1-data-store-miss\000legacy cache\000Level 1 data cache write misses\=
000legacy-... */
+	{ 25939 },
+	/* l1-data-store-misses\000legacy cache\000Level 1 data cache write misse=
s\000legac... */
+	{ 25837 },
+	/* l1-data-store-ops\000legacy cache\000Level 1 data cache write accesses=
\000legacy... */
+	{ 25636 },
+	/* l1-data-store-reference\000legacy cache\000Level 1 data cache write ac=
cesses\000... */
+	{ 25531 },
+	/* l1-data-store-refs\000legacy cache\000Level 1 data cache write accesse=
s\000legac... */
+	{ 25431 },
+	/* l1-data-stores\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-ca... */
+	{ 26039 },
+	/* l1-data-stores-access\000legacy cache\000Level 1 data cache write acce=
sses\000le... */
+	{ 26442 },
+	/* l1-data-stores-miss\000legacy cache\000Level 1 data cache write misses=
\000legacy... */
+	{ 26648 },
+	/* l1-data-stores-misses\000legacy cache\000Level 1 data cache write miss=
es\000lega... */
+	{ 26545 },
+	/* l1-data-stores-ops\000legacy cache\000Level 1 data cache write accesse=
s\000legac... */
+	{ 26342 },
+	/* l1-data-stores-reference\000legacy cache\000Level 1 data cache write a=
ccesses\00... */
+	{ 26236 },
+	/* l1-data-stores-refs\000legacy cache\000Level 1 data cache write access=
es\000lega... */
+	{ 26135 },
+	/* l1-data-write\000legacy cache\000Level 1 data cache write accesses\000=
legacy-cac... */
+	{ 26749 },
+	/* l1-data-write-access\000legacy cache\000Level 1 data cache write acces=
ses\000leg... */
+	{ 27148 },
+	/* l1-data-write-miss\000legacy cache\000Level 1 data cache write misses\=
000legacy-... */
+	{ 27352 },
+	/* l1-data-write-misses\000legacy cache\000Level 1 data cache write misse=
s\000legac... */
+	{ 27250 },
+	/* l1-data-write-ops\000legacy cache\000Level 1 data cache write accesses=
\000legacy... */
+	{ 27049 },
+	/* l1-data-write-reference\000legacy cache\000Level 1 data cache write ac=
cesses\000... */
+	{ 26944 },
+	/* l1-data-write-refs\000legacy cache\000Level 1 data cache write accesse=
s\000legac... */
+	{ 26844 },
+	/* l1-dcache\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-co... */
+	{ 13 },
+	/* l1-dcache-access\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-c... */
+	{ 7752 },
+	/* l1-dcache-load\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cac... */
+	{ 99 },
+	/* l1-dcache-load-access\000legacy cache\000Level 1 data cache read acces=
ses\000leg... */
+	{ 482 },
+	/* l1-dcache-load-miss\000legacy cache\000Level 1 data cache read misses\=
000legacy-... */
+	{ 682 },
+	/* l1-dcache-load-misses\000legacy cache\000Level 1 data cache read misse=
s\000legac... */
+	{ 580 },
+	/* l1-dcache-load-ops\000legacy cache\000Level 1 data cache read accesses=
\000legacy... */
+	{ 387 },
+	/* l1-dcache-load-reference\000legacy cache\000Level 1 data cache read ac=
cesses\000... */
+	{ 286 },
+	/* l1-dcache-load-refs\000legacy cache\000Level 1 data cache read accesse=
s\000legac... */
+	{ 190 },
+	/* l1-dcache-loads\000legacy cache\000Level 1 data cache read accesses\00=
0legacy-ca... */
+	{ 782 },
+	/* l1-dcache-loads-access\000legacy cache\000Level 1 data cache read acce=
sses\000le... */
+	{ 1169 },
+	/* l1-dcache-loads-miss\000legacy cache\000Level 1 data cache read misses=
\000legacy... */
+	{ 1371 },
+	/* l1-dcache-loads-misses\000legacy cache\000Level 1 data cache read miss=
es\000lega... */
+	{ 1268 },
+	/* l1-dcache-loads-ops\000legacy cache\000Level 1 data cache read accesse=
s\000legac... */
+	{ 1073 },
+	/* l1-dcache-loads-reference\000legacy cache\000Level 1 data cache read a=
ccesses\00... */
+	{ 971 },
+	/* l1-dcache-loads-refs\000legacy cache\000Level 1 data cache read access=
es\000lega... */
+	{ 874 },
+	/* l1-dcache-miss\000legacy cache\000Level 1 data cache read misses\000le=
gacy-cache... */
+	{ 7942 },
+	/* l1-dcache-misses\000legacy cache\000Level 1 data cache read misses\000=
legacy-cac... */
+	{ 7845 },
+	/* l1-dcache-ops\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cach... */
+	{ 7662 },
+	/* l1-dcache-prefetch\000legacy cache\000Level 1 data cache prefetch acce=
sses\000le... */
+	{ 4313 },
+	/* l1-dcache-prefetch-access\000legacy cache\000Level 1 data cache prefet=
ch accesse... */
+	{ 4744 },
+	/* l1-dcache-prefetch-miss\000legacy cache\000Level 1 data cache prefetch=
 misses\00... */
+	{ 4964 },
+	/* l1-dcache-prefetch-misses\000legacy cache\000Level 1 data cache prefet=
ch misses\... */
+	{ 4854 },
+	/* l1-dcache-prefetch-ops\000legacy cache\000Level 1 data cache prefetch =
accesses\0... */
+	{ 4637 },
+	/* l1-dcache-prefetch-reference\000legacy cache\000Level 1 data cache pre=
fetch acce... */
+	{ 4524 },
+	/* l1-dcache-prefetch-refs\000legacy cache\000Level 1 data cache prefetch=
 accesses\... */
+	{ 4416 },
+	/* l1-dcache-prefetches\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000... */
+	{ 5072 },
+	/* l1-dcache-prefetches-access\000legacy cache\000Level 1 data cache pref=
etch acces... */
+	{ 5511 },
+	/* l1-dcache-prefetches-miss\000legacy cache\000Level 1 data cache prefet=
ch misses\... */
+	{ 5735 },
+	/* l1-dcache-prefetches-misses\000legacy cache\000Level 1 data cache pref=
etch misse... */
+	{ 5623 },
+	/* l1-dcache-prefetches-ops\000legacy cache\000Level 1 data cache prefetc=
h accesses... */
+	{ 5402 },
+	/* l1-dcache-prefetches-reference\000legacy cache\000Level 1 data cache p=
refetch ac... */
+	{ 5287 },
+	/* l1-dcache-prefetches-refs\000legacy cache\000Level 1 data cache prefet=
ch accesse... */
+	{ 5177 },
+	/* l1-dcache-read\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cac... */
+	{ 1472 },
+	/* l1-dcache-read-access\000legacy cache\000Level 1 data cache read acces=
ses\000leg... */
+	{ 1855 },
+	/* l1-dcache-read-miss\000legacy cache\000Level 1 data cache read misses\=
000legacy-... */
+	{ 2055 },
+	/* l1-dcache-read-misses\000legacy cache\000Level 1 data cache read misse=
s\000legac... */
+	{ 1953 },
+	/* l1-dcache-read-ops\000legacy cache\000Level 1 data cache read accesses=
\000legacy... */
+	{ 1760 },
+	/* l1-dcache-read-reference\000legacy cache\000Level 1 data cache read ac=
cesses\000... */
+	{ 1659 },
+	/* l1-dcache-read-refs\000legacy cache\000Level 1 data cache read accesse=
s\000legac... */
+	{ 1563 },
+	/* l1-dcache-reference\000legacy cache\000Level 1 data cache read accesse=
s\000legac... */
+	{ 7566 },
+	/* l1-dcache-refs\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cac... */
+	{ 7475 },
+	/* l1-dcache-speculative-load\000legacy cache\000Level 1 data cache prefe=
tch access... */
+	{ 6660 },
+	/* l1-dcache-speculative-load-access\000legacy cache\000Level 1 data cach=
e prefetch... */
+	{ 7123 },
+	/* l1-dcache-speculative-load-miss\000legacy cache\000Level 1 data cache =
prefetch m... */
+	{ 7359 },
+	/* l1-dcache-speculative-load-misses\000legacy cache\000Level 1 data cach=
e prefetch... */
+	{ 7241 },
+	/* l1-dcache-speculative-load-ops\000legacy cache\000Level 1 data cache p=
refetch ac... */
+	{ 7008 },
+	/* l1-dcache-speculative-load-reference\000legacy cache\000Level 1 data c=
ache prefe... */
+	{ 6887 },
+	/* l1-dcache-speculative-load-refs\000legacy cache\000Level 1 data cache =
prefetch a... */
+	{ 6771 },
+	/* l1-dcache-speculative-read\000legacy cache\000Level 1 data cache prefe=
tch access... */
+	{ 5845 },
+	/* l1-dcache-speculative-read-access\000legacy cache\000Level 1 data cach=
e prefetch... */
+	{ 6308 },
+	/* l1-dcache-speculative-read-miss\000legacy cache\000Level 1 data cache =
prefetch m... */
+	{ 6544 },
+	/* l1-dcache-speculative-read-misses\000legacy cache\000Level 1 data cach=
e prefetch... */
+	{ 6426 },
+	/* l1-dcache-speculative-read-ops\000legacy cache\000Level 1 data cache p=
refetch ac... */
+	{ 6193 },
+	/* l1-dcache-speculative-read-reference\000legacy cache\000Level 1 data c=
ache prefe... */
+	{ 6072 },
+	/* l1-dcache-speculative-read-refs\000legacy cache\000Level 1 data cache =
prefetch a... */
+	{ 5956 },
+	/* l1-dcache-store\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-c... */
+	{ 2155 },
+	/* l1-dcache-store-access\000legacy cache\000Level 1 data cache write acc=
esses\000l... */
+	{ 2562 },
+	/* l1-dcache-store-miss\000legacy cache\000Level 1 data cache write misse=
s\000legac... */
+	{ 2770 },
+	/* l1-dcache-store-misses\000legacy cache\000Level 1 data cache write mis=
ses\000leg... */
+	{ 2666 },
+	/* l1-dcache-store-ops\000legacy cache\000Level 1 data cache write access=
es\000lega... */
+	{ 2461 },
+	/* l1-dcache-store-reference\000legacy cache\000Level 1 data cache write =
accesses\0... */
+	{ 2354 },
+	/* l1-dcache-store-refs\000legacy cache\000Level 1 data cache write acces=
ses\000leg... */
+	{ 2252 },
+	/* l1-dcache-stores\000legacy cache\000Level 1 data cache write accesses\=
000legacy-... */
+	{ 2872 },
+	/* l1-dcache-stores-access\000legacy cache\000Level 1 data cache write ac=
cesses\000... */
+	{ 3283 },
+	/* l1-dcache-stores-miss\000legacy cache\000Level 1 data cache write miss=
es\000lega... */
+	{ 3493 },
+	/* l1-dcache-stores-misses\000legacy cache\000Level 1 data cache write mi=
sses\000le... */
+	{ 3388 },
+	/* l1-dcache-stores-ops\000legacy cache\000Level 1 data cache write acces=
ses\000leg... */
+	{ 3181 },
+	/* l1-dcache-stores-reference\000legacy cache\000Level 1 data cache write=
 accesses\... */
+	{ 3073 },
+	/* l1-dcache-stores-refs\000legacy cache\000Level 1 data cache write acce=
sses\000le... */
+	{ 2970 },
+	/* l1-dcache-write\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-c... */
+	{ 3596 },
+	/* l1-dcache-write-access\000legacy cache\000Level 1 data cache write acc=
esses\000l... */
+	{ 4003 },
+	/* l1-dcache-write-miss\000legacy cache\000Level 1 data cache write misse=
s\000legac... */
+	{ 4211 },
+	/* l1-dcache-write-misses\000legacy cache\000Level 1 data cache write mis=
ses\000leg... */
+	{ 4107 },
+	/* l1-dcache-write-ops\000legacy cache\000Level 1 data cache write access=
es\000lega... */
+	{ 3902 },
+	/* l1-dcache-write-reference\000legacy cache\000Level 1 data cache write =
accesses\0... */
+	{ 3795 },
+	/* l1-dcache-write-refs\000legacy cache\000Level 1 data cache write acces=
ses\000leg... */
+	{ 3693 },
+	/* l1-i\000legacy cache\000Level 1 instruction cache read accesses\000leg=
acy-cache-... */
+	{ 37366 },
+	/* l1-i-access\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy... */
+	{ 43053 },
+	/* l1-i-load\000legacy cache\000Level 1 instruction cache read accesses\0=
00legacy-c... */
+	{ 37454 },
+	/* l1-i-load-access\000legacy cache\000Level 1 instruction cache read acc=
esses\000l... */
+	{ 37845 },
+	/* l1-i-load-miss\000legacy cache\000Level 1 instruction cache read misse=
s\000legac... */
+	{ 38049 },
+	/* l1-i-load-misses\000legacy cache\000Level 1 instruction cache read mis=
ses\000leg... */
+	{ 37945 },
+	/* l1-i-load-ops\000legacy cache\000Level 1 instruction cache read access=
es\000lega... */
+	{ 37748 },
+	/* l1-i-load-reference\000legacy cache\000Level 1 instruction cache read =
accesses\0... */
+	{ 37645 },
+	/* l1-i-load-refs\000legacy cache\000Level 1 instruction cache read acces=
ses\000leg... */
+	{ 37547 },
+	/* l1-i-loads\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-... */
+	{ 38151 },
+	/* l1-i-loads-access\000legacy cache\000Level 1 instruction cache read ac=
cesses\000... */
+	{ 38546 },
+	/* l1-i-loads-miss\000legacy cache\000Level 1 instruction cache read miss=
es\000lega... */
+	{ 38752 },
+	/* l1-i-loads-misses\000legacy cache\000Level 1 instruction cache read mi=
sses\000le... */
+	{ 38647 },
+	/* l1-i-loads-ops\000legacy cache\000Level 1 instruction cache read acces=
ses\000leg... */
+	{ 38448 },
+	/* l1-i-loads-reference\000legacy cache\000Level 1 instruction cache read=
 accesses\... */
+	{ 38344 },
+	/* l1-i-loads-refs\000legacy cache\000Level 1 instruction cache read acce=
sses\000le... */
+	{ 38245 },
+	/* l1-i-miss\000legacy cache\000Level 1 instruction cache read misses\000=
legacy-cac... */
+	{ 43247 },
+	/* l1-i-misses\000legacy cache\000Level 1 instruction cache read misses\0=
00legacy-c... */
+	{ 43148 },
+	/* l1-i-ops\000legacy cache\000Level 1 instruction cache read accesses\00=
0legacy-ca... */
+	{ 42961 },
+	/* l1-i-prefetch\000legacy cache\000Level 1 instruction cache prefetch ac=
cesses\000... */
+	{ 39552 },
+	/* l1-i-prefetch-access\000legacy cache\000Level 1 instruction cache pref=
etch acces... */
+	{ 39991 },
+	/* l1-i-prefetch-miss\000legacy cache\000Level 1 instruction cache prefet=
ch misses\... */
+	{ 40215 },
+	/* l1-i-prefetch-misses\000legacy cache\000Level 1 instruction cache pref=
etch misse... */
+	{ 40103 },
+	/* l1-i-prefetch-ops\000legacy cache\000Level 1 instruction cache prefetc=
h accesses... */
+	{ 39882 },
+	/* l1-i-prefetch-reference\000legacy cache\000Level 1 instruction cache p=
refetch ac... */
+	{ 39767 },
+	/* l1-i-prefetch-refs\000legacy cache\000Level 1 instruction cache prefet=
ch accesse... */
+	{ 39657 },
+	/* l1-i-prefetches\000legacy cache\000Level 1 instruction cache prefetch =
accesses\0... */
+	{ 40325 },
+	/* l1-i-prefetches-access\000legacy cache\000Level 1 instruction cache pr=
efetch acc... */
+	{ 40772 },
+	/* l1-i-prefetches-miss\000legacy cache\000Level 1 instruction cache pref=
etch misse... */
+	{ 41000 },
+	/* l1-i-prefetches-misses\000legacy cache\000Level 1 instruction cache pr=
efetch mis... */
+	{ 40886 },
+	/* l1-i-prefetches-ops\000legacy cache\000Level 1 instruction cache prefe=
tch access... */
+	{ 40661 },
+	/* l1-i-prefetches-reference\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
+	{ 40544 },
+	/* l1-i-prefetches-refs\000legacy cache\000Level 1 instruction cache pref=
etch acces... */
+	{ 40432 },
+	/* l1-i-read\000legacy cache\000Level 1 instruction cache read accesses\0=
00legacy-c... */
+	{ 38855 },
+	/* l1-i-read-access\000legacy cache\000Level 1 instruction cache read acc=
esses\000l... */
+	{ 39246 },
+	/* l1-i-read-miss\000legacy cache\000Level 1 instruction cache read misse=
s\000legac... */
+	{ 39450 },
+	/* l1-i-read-misses\000legacy cache\000Level 1 instruction cache read mis=
ses\000leg... */
+	{ 39346 },
+	/* l1-i-read-ops\000legacy cache\000Level 1 instruction cache read access=
es\000lega... */
+	{ 39149 },
+	/* l1-i-read-reference\000legacy cache\000Level 1 instruction cache read =
accesses\0... */
+	{ 39046 },
+	/* l1-i-read-refs\000legacy cache\000Level 1 instruction cache read acces=
ses\000leg... */
+	{ 38948 },
+	/* l1-i-reference\000legacy cache\000Level 1 instruction cache read acces=
ses\000leg... */
+	{ 42863 },
+	/* l1-i-refs\000legacy cache\000Level 1 instruction cache read accesses\0=
00legacy-c... */
+	{ 42770 },
+	/* l1-i-speculative-load\000legacy cache\000Level 1 instruction cache pre=
fetch acce... */
+	{ 41941 },
+	/* l1-i-speculative-load-access\000legacy cache\000Level 1 instruction ca=
che prefet... */
+	{ 42412 },
+	/* l1-i-speculative-load-miss\000legacy cache\000Level 1 instruction cach=
e prefetch... */
+	{ 42652 },
+	/* l1-i-speculative-load-misses\000legacy cache\000Level 1 instruction ca=
che prefet... */
+	{ 42532 },
+	/* l1-i-speculative-load-ops\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
+	{ 42295 },
+	/* l1-i-speculative-load-reference\000legacy cache\000Level 1 instruction=
 cache pre... */
+	{ 42172 },
+	/* l1-i-speculative-load-refs\000legacy cache\000Level 1 instruction cach=
e prefetch... */
+	{ 42054 },
+	/* l1-i-speculative-read\000legacy cache\000Level 1 instruction cache pre=
fetch acce... */
+	{ 41112 },
+	/* l1-i-speculative-read-access\000legacy cache\000Level 1 instruction ca=
che prefet... */
+	{ 41583 },
+	/* l1-i-speculative-read-miss\000legacy cache\000Level 1 instruction cach=
e prefetch... */
+	{ 41823 },
+	/* l1-i-speculative-read-misses\000legacy cache\000Level 1 instruction ca=
che prefet... */
+	{ 41703 },
+	/* l1-i-speculative-read-ops\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
+	{ 41466 },
+	/* l1-i-speculative-read-reference\000legacy cache\000Level 1 instruction=
 cache pre... */
+	{ 41343 },
+	/* l1-i-speculative-read-refs\000legacy cache\000Level 1 instruction cach=
e prefetch... */
+	{ 41225 },
+	/* l1-icache\000legacy cache\000Level 1 instruction cache read accesses\0=
00legacy-c... */
+	{ 31108 },
+	/* l1-icache-access\000legacy cache\000Level 1 instruction cache read acc=
esses\000l... */
+	{ 37060 },
+	/* l1-icache-load\000legacy cache\000Level 1 instruction cache read acces=
ses\000leg... */
+	{ 31201 },
+	/* l1-icache-load-access\000legacy cache\000Level 1 instruction cache rea=
d accesses... */
+	{ 31612 },
+	/* l1-icache-load-miss\000legacy cache\000Level 1 instruction cache read =
misses\000... */
+	{ 31826 },
+	/* l1-icache-load-misses\000legacy cache\000Level 1 instruction cache rea=
d misses\0... */
+	{ 31717 },
+	/* l1-icache-load-ops\000legacy cache\000Level 1 instruction cache read a=
ccesses\00... */
+	{ 31510 },
+	/* l1-icache-load-reference\000legacy cache\000Level 1 instruction cache =
read acces... */
+	{ 31402 },
+	/* l1-icache-load-refs\000legacy cache\000Level 1 instruction cache read =
accesses\0... */
+	{ 31299 },
+	/* l1-icache-loads\000legacy cache\000Level 1 instruction cache read acce=
sses\000le... */
+	{ 31933 },
+	/* l1-icache-loads-access\000legacy cache\000Level 1 instruction cache re=
ad accesse... */
+	{ 32348 },
+	/* l1-icache-loads-miss\000legacy cache\000Level 1 instruction cache read=
 misses\00... */
+	{ 32564 },
+	/* l1-icache-loads-misses\000legacy cache\000Level 1 instruction cache re=
ad misses\... */
+	{ 32454 },
+	/* l1-icache-loads-ops\000legacy cache\000Level 1 instruction cache read =
accesses\0... */
+	{ 32245 },
+	/* l1-icache-loads-reference\000legacy cache\000Level 1 instruction cache=
 read acce... */
+	{ 32136 },
+	/* l1-icache-loads-refs\000legacy cache\000Level 1 instruction cache read=
 accesses\... */
+	{ 32032 },
+	/* l1-icache-miss\000legacy cache\000Level 1 instruction cache read misse=
s\000legac... */
+	{ 37264 },
+	/* l1-icache-misses\000legacy cache\000Level 1 instruction cache read mis=
ses\000leg... */
+	{ 37160 },
+	/* l1-icache-ops\000legacy cache\000Level 1 instruction cache read access=
es\000lega... */
+	{ 36963 },
+	/* l1-icache-prefetch\000legacy cache\000Level 1 instruction cache prefet=
ch accesse... */
+	{ 33404 },
+	/* l1-icache-prefetch-access\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
+	{ 33863 },
+	/* l1-icache-prefetch-miss\000legacy cache\000Level 1 instruction cache p=
refetch mi... */
+	{ 34097 },
+	/* l1-icache-prefetch-misses\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
+	{ 33980 },
+	/* l1-icache-prefetch-ops\000legacy cache\000Level 1 instruction cache pr=
efetch acc... */
+	{ 33749 },
+	/* l1-icache-prefetch-reference\000legacy cache\000Level 1 instruction ca=
che prefet... */
+	{ 33629 },
+	/* l1-icache-prefetch-refs\000legacy cache\000Level 1 instruction cache p=
refetch ac... */
+	{ 33514 },
+	/* l1-icache-prefetches\000legacy cache\000Level 1 instruction cache pref=
etch acces... */
+	{ 34212 },
+	/* l1-icache-prefetches-access\000legacy cache\000Level 1 instruction cac=
he prefetc... */
+	{ 34679 },
+	/* l1-icache-prefetches-miss\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
+	{ 34917 },
+	/* l1-icache-prefetches-misses\000legacy cache\000Level 1 instruction cac=
he prefetc... */
+	{ 34798 },
+	/* l1-icache-prefetches-ops\000legacy cache\000Level 1 instruction cache =
prefetch a... */
+	{ 34563 },
+	/* l1-icache-prefetches-reference\000legacy cache\000Level 1 instruction =
cache pref... */
+	{ 34441 },
+	/* l1-icache-prefetches-refs\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
+	{ 34324 },
+	/* l1-icache-read\000legacy cache\000Level 1 instruction cache read acces=
ses\000leg... */
+	{ 32672 },
+	/* l1-icache-read-access\000legacy cache\000Level 1 instruction cache rea=
d accesses... */
+	{ 33083 },
+	/* l1-icache-read-miss\000legacy cache\000Level 1 instruction cache read =
misses\000... */
+	{ 33297 },
+	/* l1-icache-read-misses\000legacy cache\000Level 1 instruction cache rea=
d misses\0... */
+	{ 33188 },
+	/* l1-icache-read-ops\000legacy cache\000Level 1 instruction cache read a=
ccesses\00... */
+	{ 32981 },
+	/* l1-icache-read-reference\000legacy cache\000Level 1 instruction cache =
read acces... */
+	{ 32873 },
+	/* l1-icache-read-refs\000legacy cache\000Level 1 instruction cache read =
accesses\0... */
+	{ 32770 },
+	/* l1-icache-reference\000legacy cache\000Level 1 instruction cache read =
accesses\0... */
+	{ 36860 },
+	/* l1-icache-refs\000legacy cache\000Level 1 instruction cache read acces=
ses\000leg... */
+	{ 36762 },
+	/* l1-icache-speculative-load\000legacy cache\000Level 1 instruction cach=
e prefetch... */
+	{ 35898 },
+	/* l1-icache-speculative-load-access\000legacy cache\000Level 1 instructi=
on cache p... */
+	{ 36389 },
+	/* l1-icache-speculative-load-miss\000legacy cache\000Level 1 instruction=
 cache pre... */
+	{ 36639 },
+	/* l1-icache-speculative-load-misses\000legacy cache\000Level 1 instructi=
on cache p... */
+	{ 36514 },
+	/* l1-icache-speculative-load-ops\000legacy cache\000Level 1 instruction =
cache pref... */
+	{ 36267 },
+	/* l1-icache-speculative-load-reference\000legacy cache\000Level 1 instru=
ction cach... */
+	{ 36139 },
+	/* l1-icache-speculative-load-refs\000legacy cache\000Level 1 instruction=
 cache pre... */
+	{ 36016 },
+	/* l1-icache-speculative-read\000legacy cache\000Level 1 instruction cach=
e prefetch... */
+	{ 35034 },
+	/* l1-icache-speculative-read-access\000legacy cache\000Level 1 instructi=
on cache p... */
+	{ 35525 },
+	/* l1-icache-speculative-read-miss\000legacy cache\000Level 1 instruction=
 cache pre... */
+	{ 35775 },
+	/* l1-icache-speculative-read-misses\000legacy cache\000Level 1 instructi=
on cache p... */
+	{ 35650 },
+	/* l1-icache-speculative-read-ops\000legacy cache\000Level 1 instruction =
cache pref... */
+	{ 35403 },
+	/* l1-icache-speculative-read-reference\000legacy cache\000Level 1 instru=
ction cach... */
+	{ 35275 },
+	/* l1-icache-speculative-read-refs\000legacy cache\000Level 1 instruction=
 cache pre... */
+	{ 35152 },
+	/* l1-instruction\000legacy cache\000Level 1 instruction cache read acces=
ses\000leg... */
+	{ 49266 },
+	/* l1-instruction-access\000legacy cache\000Level 1 instruction cache rea=
d accesses... */
+	{ 55483 },
+	/* l1-instruction-load\000legacy cache\000Level 1 instruction cache read =
accesses\0... */
+	{ 49364 },
+	/* l1-instruction-load-access\000legacy cache\000Level 1 instruction cach=
e read acc... */
+	{ 49795 },
+	/* l1-instruction-load-miss\000legacy cache\000Level 1 instruction cache =
read misse... */
+	{ 50019 },
+	/* l1-instruction-load-misses\000legacy cache\000Level 1 instruction cach=
e read mis... */
+	{ 49905 },
+	/* l1-instruction-load-ops\000legacy cache\000Level 1 instruction cache r=
ead access... */
+	{ 49688 },
+	/* l1-instruction-load-reference\000legacy cache\000Level 1 instruction c=
ache read ... */
+	{ 49575 },
+	/* l1-instruction-load-refs\000legacy cache\000Level 1 instruction cache =
read acces... */
+	{ 49467 },
+	/* l1-instruction-loads\000legacy cache\000Level 1 instruction cache read=
 accesses\... */
+	{ 50131 },
+	/* l1-instruction-loads-access\000legacy cache\000Level 1 instruction cac=
he read ac... */
+	{ 50566 },
+	/* l1-instruction-loads-miss\000legacy cache\000Level 1 instruction cache=
 read miss... */
+	{ 50792 },
+	/* l1-instruction-loads-misses\000legacy cache\000Level 1 instruction cac=
he read mi... */
+	{ 50677 },
+	/* l1-instruction-loads-ops\000legacy cache\000Level 1 instruction cache =
read acces... */
+	{ 50458 },
+	/* l1-instruction-loads-reference\000legacy cache\000Level 1 instruction =
cache read... */
+	{ 50344 },
+	/* l1-instruction-loads-refs\000legacy cache\000Level 1 instruction cache=
 read acce... */
+	{ 50235 },
+	/* l1-instruction-miss\000legacy cache\000Level 1 instruction cache read =
misses\000... */
+	{ 55697 },
+	/* l1-instruction-misses\000legacy cache\000Level 1 instruction cache rea=
d misses\0... */
+	{ 55588 },
+	/* l1-instruction-ops\000legacy cache\000Level 1 instruction cache read a=
ccesses\00... */
+	{ 55381 },
+	/* l1-instruction-prefetch\000legacy cache\000Level 1 instruction cache p=
refetch ac... */
+	{ 51672 },
+	/* l1-instruction-prefetch-access\000legacy cache\000Level 1 instruction =
cache pref... */
+	{ 52151 },
+	/* l1-instruction-prefetch-miss\000legacy cache\000Level 1 instruction ca=
che prefet... */
+	{ 52395 },
+	/* l1-instruction-prefetch-misses\000legacy cache\000Level 1 instruction =
cache pref... */
+	{ 52273 },
+	/* l1-instruction-prefetch-ops\000legacy cache\000Level 1 instruction cac=
he prefetc... */
+	{ 52032 },
+	/* l1-instruction-prefetch-reference\000legacy cache\000Level 1 instructi=
on cache p... */
+	{ 51907 },
+	/* l1-instruction-prefetch-refs\000legacy cache\000Level 1 instruction ca=
che prefet... */
+	{ 51787 },
+	/* l1-instruction-prefetches\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
+	{ 52515 },
+	/* l1-instruction-prefetches-access\000legacy cache\000Level 1 instructio=
n cache pr... */
+	{ 53002 },
+	/* l1-instruction-prefetches-miss\000legacy cache\000Level 1 instruction =
cache pref... */
+	{ 53250 },
+	/* l1-instruction-prefetches-misses\000legacy cache\000Level 1 instructio=
n cache pr... */
+	{ 53126 },
+	/* l1-instruction-prefetches-ops\000legacy cache\000Level 1 instruction c=
ache prefe... */
+	{ 52881 },
+	/* l1-instruction-prefetches-reference\000legacy cache\000Level 1 instruc=
tion cache... */
+	{ 52754 },
+	/* l1-instruction-prefetches-refs\000legacy cache\000Level 1 instruction =
cache pref... */
+	{ 52632 },
+	/* l1-instruction-read\000legacy cache\000Level 1 instruction cache read =
accesses\0... */
+	{ 50905 },
+	/* l1-instruction-read-access\000legacy cache\000Level 1 instruction cach=
e read acc... */
+	{ 51336 },
+	/* l1-instruction-read-miss\000legacy cache\000Level 1 instruction cache =
read misse... */
+	{ 51560 },
+	/* l1-instruction-read-misses\000legacy cache\000Level 1 instruction cach=
e read mis... */
+	{ 51446 },
+	/* l1-instruction-read-ops\000legacy cache\000Level 1 instruction cache r=
ead access... */
+	{ 51229 },
+	/* l1-instruction-read-reference\000legacy cache\000Level 1 instruction c=
ache read ... */
+	{ 51116 },
+	/* l1-instruction-read-refs\000legacy cache\000Level 1 instruction cache =
read acces... */
+	{ 51008 },
+	/* l1-instruction-reference\000legacy cache\000Level 1 instruction cache =
read acces... */
+	{ 55273 },
+	/* l1-instruction-refs\000legacy cache\000Level 1 instruction cache read =
accesses\0... */
+	{ 55170 },
+	/* l1-instruction-speculative-load\000legacy cache\000Level 1 instruction=
 cache pre... */
+	{ 54271 },
+	/* l1-instruction-speculative-load-access\000legacy cache\000Level 1 inst=
ruction ca... */
+	{ 54782 },
+	/* l1-instruction-speculative-load-miss\000legacy cache\000Level 1 instru=
ction cach... */
+	{ 55042 },
+	/* l1-instruction-speculative-load-misses\000legacy cache\000Level 1 inst=
ruction ca... */
+	{ 54912 },
+	/* l1-instruction-speculative-load-ops\000legacy cache\000Level 1 instruc=
tion cache... */
+	{ 54655 },
+	/* l1-instruction-speculative-load-reference\000legacy cache\000Level 1 i=
nstruction... */
+	{ 54522 },
+	/* l1-instruction-speculative-load-refs\000legacy cache\000Level 1 instru=
ction cach... */
+	{ 54394 },
+	/* l1-instruction-speculative-read\000legacy cache\000Level 1 instruction=
 cache pre... */
+	{ 53372 },
+	/* l1-instruction-speculative-read-access\000legacy cache\000Level 1 inst=
ruction ca... */
+	{ 53883 },
+	/* l1-instruction-speculative-read-miss\000legacy cache\000Level 1 instru=
ction cach... */
+	{ 54143 },
+	/* l1-instruction-speculative-read-misses\000legacy cache\000Level 1 inst=
ruction ca... */
+	{ 54013 },
+	/* l1-instruction-speculative-read-ops\000legacy cache\000Level 1 instruc=
tion cache... */
+	{ 53756 },
+	/* l1-instruction-speculative-read-reference\000legacy cache\000Level 1 i=
nstruction... */
+	{ 53623 },
+	/* l1-instruction-speculative-read-refs\000legacy cache\000Level 1 instru=
ction cach... */
+	{ 53495 },
+	/* l1d\000legacy cache\000Level 1 data cache read accesses\000legacy-cach=
e-config=3D0... */
+	{ 15676 },
+	/* l1d-access\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-c... */
+	{ 22971 },
+	/* l1d-load\000legacy cache\000Level 1 data cache read accesses\000legacy=
-cache-con... */
+	{ 15756 },
+	/* l1d-load-access\000legacy cache\000Level 1 data cache read accesses\00=
0legacy-ca... */
+	{ 16115 },
+	/* l1d-load-miss\000legacy cache\000Level 1 data cache read misses\000leg=
acy-cache-... */
+	{ 16303 },
+	/* l1d-load-misses\000legacy cache\000Level 1 data cache read misses\000l=
egacy-cach... */
+	{ 16207 },
+	/* l1d-load-ops\000legacy cache\000Level 1 data cache read accesses\000le=
gacy-cache... */
+	{ 16026 },
+	/* l1d-load-reference\000legacy cache\000Level 1 data cache read accesses=
\000legacy... */
+	{ 15931 },
+	/* l1d-load-refs\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cach... */
+	{ 15841 },
+	/* l1d-loads\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-co... */
+	{ 16397 },
+	/* l1d-loads-access\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-c... */
+	{ 16760 },
+	/* l1d-loads-miss\000legacy cache\000Level 1 data cache read misses\000le=
gacy-cache... */
+	{ 16950 },
+	/* l1d-loads-misses\000legacy cache\000Level 1 data cache read misses\000=
legacy-cac... */
+	{ 16853 },
+	/* l1d-loads-ops\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cach... */
+	{ 16670 },
+	/* l1d-loads-reference\000legacy cache\000Level 1 data cache read accesse=
s\000legac... */
+	{ 16574 },
+	/* l1d-loads-refs\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cac... */
+	{ 16483 },
+	/* l1d-miss\000legacy cache\000Level 1 data cache read misses\000legacy-c=
ache-confi... */
+	{ 23149 },
+	/* l1d-misses\000legacy cache\000Level 1 data cache read misses\000legacy=
-cache-con... */
+	{ 23058 },
+	/* l1d-ops\000legacy cache\000Level 1 data cache read accesses\000legacy-=
cache-conf... */
+	{ 22887 },
+	/* l1d-prefetch\000legacy cache\000Level 1 data cache prefetch accesses\0=
00legacy-c... */
+	{ 19718 },
+	/* l1d-prefetch-access\000legacy cache\000Level 1 data cache prefetch acc=
esses\000l... */
+	{ 20125 },
+	/* l1d-prefetch-miss\000legacy cache\000Level 1 data cache prefetch misse=
s\000legac... */
+	{ 20333 },
+	/* l1d-prefetch-misses\000legacy cache\000Level 1 data cache prefetch mis=
ses\000leg... */
+	{ 20229 },
+	/* l1d-prefetch-ops\000legacy cache\000Level 1 data cache prefetch access=
es\000lega... */
+	{ 20024 },
+	/* l1d-prefetch-reference\000legacy cache\000Level 1 data cache prefetch =
accesses\0... */
+	{ 19917 },
+	/* l1d-prefetch-refs\000legacy cache\000Level 1 data cache prefetch acces=
ses\000leg... */
+	{ 19815 },
+	/* l1d-prefetches\000legacy cache\000Level 1 data cache prefetch accesses=
\000legacy... */
+	{ 20435 },
+	/* l1d-prefetches-access\000legacy cache\000Level 1 data cache prefetch a=
ccesses\00... */
+	{ 20850 },
+	/* l1d-prefetches-miss\000legacy cache\000Level 1 data cache prefetch mis=
ses\000leg... */
+	{ 21062 },
+	/* l1d-prefetches-misses\000legacy cache\000Level 1 data cache prefetch m=
isses\000l... */
+	{ 20956 },
+	/* l1d-prefetches-ops\000legacy cache\000Level 1 data cache prefetch acce=
sses\000le... */
+	{ 20747 },
+	/* l1d-prefetches-reference\000legacy cache\000Level 1 data cache prefetc=
h accesses... */
+	{ 20638 },
+	/* l1d-prefetches-refs\000legacy cache\000Level 1 data cache prefetch acc=
esses\000l... */
+	{ 20534 },
+	/* l1d-read\000legacy cache\000Level 1 data cache read accesses\000legacy=
-cache-con... */
+	{ 17045 },
+	/* l1d-read-access\000legacy cache\000Level 1 data cache read accesses\00=
0legacy-ca... */
+	{ 17404 },
+	/* l1d-read-miss\000legacy cache\000Level 1 data cache read misses\000leg=
acy-cache-... */
+	{ 17592 },
+	/* l1d-read-misses\000legacy cache\000Level 1 data cache read misses\000l=
egacy-cach... */
+	{ 17496 },
+	/* l1d-read-ops\000legacy cache\000Level 1 data cache read accesses\000le=
gacy-cache... */
+	{ 17315 },
+	/* l1d-read-reference\000legacy cache\000Level 1 data cache read accesses=
\000legacy... */
+	{ 17220 },
+	/* l1d-read-refs\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cach... */
+	{ 17130 },
+	/* l1d-reference\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cach... */
+	{ 22797 },
+	/* l1d-refs\000legacy cache\000Level 1 data cache read accesses\000legacy=
-cache-con... */
+	{ 22712 },
+	/* l1d-speculative-load\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000... */
+	{ 21939 },
+	/* l1d-speculative-load-access\000legacy cache\000Level 1 data cache pref=
etch acces... */
+	{ 22378 },
+	/* l1d-speculative-load-miss\000legacy cache\000Level 1 data cache prefet=
ch misses\... */
+	{ 22602 },
+	/* l1d-speculative-load-misses\000legacy cache\000Level 1 data cache pref=
etch misse... */
+	{ 22490 },
+	/* l1d-speculative-load-ops\000legacy cache\000Level 1 data cache prefetc=
h accesses... */
+	{ 22269 },
+	/* l1d-speculative-load-reference\000legacy cache\000Level 1 data cache p=
refetch ac... */
+	{ 22154 },
+	/* l1d-speculative-load-refs\000legacy cache\000Level 1 data cache prefet=
ch accesse... */
+	{ 22044 },
+	/* l1d-speculative-read\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000... */
+	{ 21166 },
+	/* l1d-speculative-read-access\000legacy cache\000Level 1 data cache pref=
etch acces... */
+	{ 21605 },
+	/* l1d-speculative-read-miss\000legacy cache\000Level 1 data cache prefet=
ch misses\... */
+	{ 21829 },
+	/* l1d-speculative-read-misses\000legacy cache\000Level 1 data cache pref=
etch misse... */
+	{ 21717 },
+	/* l1d-speculative-read-ops\000legacy cache\000Level 1 data cache prefetc=
h accesses... */
+	{ 21496 },
+	/* l1d-speculative-read-reference\000legacy cache\000Level 1 data cache p=
refetch ac... */
+	{ 21381 },
+	/* l1d-speculative-read-refs\000legacy cache\000Level 1 data cache prefet=
ch accesse... */
+	{ 21271 },
+	/* l1d-store\000legacy cache\000Level 1 data cache write accesses\000lega=
cy-cache-c... */
+	{ 17686 },
+	/* l1d-store-access\000legacy cache\000Level 1 data cache write accesses\=
000legacy-... */
+	{ 18069 },
+	/* l1d-store-miss\000legacy cache\000Level 1 data cache write misses\000l=
egacy-cach... */
+	{ 18265 },
+	/* l1d-store-misses\000legacy cache\000Level 1 data cache write misses\00=
0legacy-ca... */
+	{ 18167 },
+	/* l1d-store-ops\000legacy cache\000Level 1 data cache write accesses\000=
legacy-cac... */
+	{ 17974 },
+	/* l1d-store-reference\000legacy cache\000Level 1 data cache write access=
es\000lega... */
+	{ 17873 },
+	/* l1d-store-refs\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-ca... */
+	{ 17777 },
+	/* l1d-stores\000legacy cache\000Level 1 data cache write accesses\000leg=
acy-cache-... */
+	{ 18361 },
+	/* l1d-stores-access\000legacy cache\000Level 1 data cache write accesses=
\000legacy... */
+	{ 18748 },
+	/* l1d-stores-miss\000legacy cache\000Level 1 data cache write misses\000=
legacy-cac... */
+	{ 18946 },
+	/* l1d-stores-misses\000legacy cache\000Level 1 data cache write misses\0=
00legacy-c... */
+	{ 18847 },
+	/* l1d-stores-ops\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-ca... */
+	{ 18652 },
+	/* l1d-stores-reference\000legacy cache\000Level 1 data cache write acces=
ses\000leg... */
+	{ 18550 },
+	/* l1d-stores-refs\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-c... */
+	{ 18453 },
+	/* l1d-write\000legacy cache\000Level 1 data cache write accesses\000lega=
cy-cache-c... */
+	{ 19043 },
+	/* l1d-write-access\000legacy cache\000Level 1 data cache write accesses\=
000legacy-... */
+	{ 19426 },
+	/* l1d-write-miss\000legacy cache\000Level 1 data cache write misses\000l=
egacy-cach... */
+	{ 19622 },
+	/* l1d-write-misses\000legacy cache\000Level 1 data cache write misses\00=
0legacy-ca... */
+	{ 19524 },
+	/* l1d-write-ops\000legacy cache\000Level 1 data cache write accesses\000=
legacy-cac... */
+	{ 19331 },
+	/* l1d-write-reference\000legacy cache\000Level 1 data cache write access=
es\000lega... */
+	{ 19230 },
+	/* l1d-write-refs\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-ca... */
+	{ 19134 },
+	/* l1i\000legacy cache\000Level 1 instruction cache read accesses\000lega=
cy-cache-c... */
+	{ 43344 },
+	/* l1i-access\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-... */
+	{ 48978 },
+	/* l1i-load\000legacy cache\000Level 1 instruction cache read accesses\00=
0legacy-ca... */
+	{ 43431 },
+	/* l1i-load-access\000legacy cache\000Level 1 instruction cache read acce=
sses\000le... */
+	{ 43818 },
+	/* l1i-load-miss\000legacy cache\000Level 1 instruction cache read misses=
\000legacy... */
+	{ 44020 },
+	/* l1i-load-misses\000legacy cache\000Level 1 instruction cache read miss=
es\000lega... */
+	{ 43917 },
+	/* l1i-load-ops\000legacy cache\000Level 1 instruction cache read accesse=
s\000legac... */
+	{ 43722 },
+	/* l1i-load-reference\000legacy cache\000Level 1 instruction cache read a=
ccesses\00... */
+	{ 43620 },
+	/* l1i-load-refs\000legacy cache\000Level 1 instruction cache read access=
es\000lega... */
+	{ 43523 },
+	/* l1i-loads\000legacy cache\000Level 1 instruction cache read accesses\0=
00legacy-c... */
+	{ 44121 },
+	/* l1i-loads-access\000legacy cache\000Level 1 instruction cache read acc=
esses\000l... */
+	{ 44512 },
+	/* l1i-loads-miss\000legacy cache\000Level 1 instruction cache read misse=
s\000legac... */
+	{ 44716 },
+	/* l1i-loads-misses\000legacy cache\000Level 1 instruction cache read mis=
ses\000leg... */
+	{ 44612 },
+	/* l1i-loads-ops\000legacy cache\000Level 1 instruction cache read access=
es\000lega... */
+	{ 44415 },
+	/* l1i-loads-reference\000legacy cache\000Level 1 instruction cache read =
accesses\0... */
+	{ 44312 },
+	/* l1i-loads-refs\000legacy cache\000Level 1 instruction cache read acces=
ses\000leg... */
+	{ 44214 },
+	/* l1i-miss\000legacy cache\000Level 1 instruction cache read misses\000l=
egacy-cach... */
+	{ 49170 },
+	/* l1i-misses\000legacy cache\000Level 1 instruction cache read misses\00=
0legacy-ca... */
+	{ 49072 },
+	/* l1i-ops\000legacy cache\000Level 1 instruction cache read accesses\000=
legacy-cac... */
+	{ 48887 },
+	/* l1i-prefetch\000legacy cache\000Level 1 instruction cache prefetch acc=
esses\000l... */
+	{ 45508 },
+	/* l1i-prefetch-access\000legacy cache\000Level 1 instruction cache prefe=
tch access... */
+	{ 45943 },
+	/* l1i-prefetch-miss\000legacy cache\000Level 1 instruction cache prefetc=
h misses\0... */
+	{ 46165 },
+	/* l1i-prefetch-misses\000legacy cache\000Level 1 instruction cache prefe=
tch misses... */
+	{ 46054 },
+	/* l1i-prefetch-ops\000legacy cache\000Level 1 instruction cache prefetch=
 accesses\... */
+	{ 45835 },
+	/* l1i-prefetch-reference\000legacy cache\000Level 1 instruction cache pr=
efetch acc... */
+	{ 45721 },
+	/* l1i-prefetch-refs\000legacy cache\000Level 1 instruction cache prefetc=
h accesses... */
+	{ 45612 },
+	/* l1i-prefetches\000legacy cache\000Level 1 instruction cache prefetch a=
ccesses\00... */
+	{ 46274 },
+	/* l1i-prefetches-access\000legacy cache\000Level 1 instruction cache pre=
fetch acce... */
+	{ 46717 },
+	/* l1i-prefetches-miss\000legacy cache\000Level 1 instruction cache prefe=
tch misses... */
+	{ 46943 },
+	/* l1i-prefetches-misses\000legacy cache\000Level 1 instruction cache pre=
fetch miss... */
+	{ 46830 },
+	/* l1i-prefetches-ops\000legacy cache\000Level 1 instruction cache prefet=
ch accesse... */
+	{ 46607 },
+	/* l1i-prefetches-reference\000legacy cache\000Level 1 instruction cache =
prefetch a... */
+	{ 46491 },
+	/* l1i-prefetches-refs\000legacy cache\000Level 1 instruction cache prefe=
tch access... */
+	{ 46380 },
+	/* l1i-read\000legacy cache\000Level 1 instruction cache read accesses\00=
0legacy-ca... */
+	{ 44818 },
+	/* l1i-read-access\000legacy cache\000Level 1 instruction cache read acce=
sses\000le... */
+	{ 45205 },
+	/* l1i-read-miss\000legacy cache\000Level 1 instruction cache read misses=
\000legacy... */
+	{ 45407 },
+	/* l1i-read-misses\000legacy cache\000Level 1 instruction cache read miss=
es\000lega... */
+	{ 45304 },
+	/* l1i-read-ops\000legacy cache\000Level 1 instruction cache read accesse=
s\000legac... */
+	{ 45109 },
+	/* l1i-read-reference\000legacy cache\000Level 1 instruction cache read a=
ccesses\00... */
+	{ 45007 },
+	/* l1i-read-refs\000legacy cache\000Level 1 instruction cache read access=
es\000lega... */
+	{ 44910 },
+	/* l1i-reference\000legacy cache\000Level 1 instruction cache read access=
es\000lega... */
+	{ 48790 },
+	/* l1i-refs\000legacy cache\000Level 1 instruction cache read accesses\00=
0legacy-ca... */
+	{ 48698 },
+	/* l1i-speculative-load\000legacy cache\000Level 1 instruction cache pref=
etch acces... */
+	{ 47876 },
+	/* l1i-speculative-load-access\000legacy cache\000Level 1 instruction cac=
he prefetc... */
+	{ 48343 },
+	/* l1i-speculative-load-miss\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
+	{ 48581 },
+	/* l1i-speculative-load-misses\000legacy cache\000Level 1 instruction cac=
he prefetc... */
+	{ 48462 },
+	/* l1i-speculative-load-ops\000legacy cache\000Level 1 instruction cache =
prefetch a... */
+	{ 48227 },
+	/* l1i-speculative-load-reference\000legacy cache\000Level 1 instruction =
cache pref... */
+	{ 48105 },
+	/* l1i-speculative-load-refs\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
+	{ 47988 },
+	/* l1i-speculative-read\000legacy cache\000Level 1 instruction cache pref=
etch acces... */
+	{ 47054 },
+	/* l1i-speculative-read-access\000legacy cache\000Level 1 instruction cac=
he prefetc... */
+	{ 47521 },
+	/* l1i-speculative-read-miss\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
+	{ 47759 },
+	/* l1i-speculative-read-misses\000legacy cache\000Level 1 instruction cac=
he prefetc... */
+	{ 47640 },
+	/* l1i-speculative-read-ops\000legacy cache\000Level 1 instruction cache =
prefetch a... */
+	{ 47405 },
+	/* l1i-speculative-read-reference\000legacy cache\000Level 1 instruction =
cache pref... */
+	{ 47283 },
+	/* l1i-speculative-read-refs\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
+	{ 47166 },
+	/* l2\000legacy cache\000Level 2 (or higher) last level cache read access=
es\000lega... */
+	{ 63212 },
+	/* l2-access\000legacy cache\000Level 2 (or higher) last level cache read=
 accesses\... */
+	{ 71765 },
+	/* l2-load\000legacy cache\000Level 2 (or higher) last level cache read a=
ccesses\00... */
+	{ 63309 },
+	/* l2-load-access\000legacy cache\000Level 2 (or higher) last level cache=
 read acce... */
+	{ 63736 },
+	/* l2-load-miss\000legacy cache\000Level 2 (or higher) last level cache r=
ead misses... */
+	{ 63958 },
+	/* l2-load-misses\000legacy cache\000Level 2 (or higher) last level cache=
 read miss... */
+	{ 63845 },
+	/* l2-load-ops\000legacy cache\000Level 2 (or higher) last level cache re=
ad accesse... */
+	{ 63630 },
+	/* l2-load-reference\000legacy cache\000Level 2 (or higher) last level ca=
che read a... */
+	{ 63518 },
+	/* l2-load-refs\000legacy cache\000Level 2 (or higher) last level cache r=
ead access... */
+	{ 63411 },
+	/* l2-loads\000legacy cache\000Level 2 (or higher) last level cache read =
accesses\0... */
+	{ 64069 },
+	/* l2-loads-access\000legacy cache\000Level 2 (or higher) last level cach=
e read acc... */
+	{ 64500 },
+	/* l2-loads-miss\000legacy cache\000Level 2 (or higher) last level cache =
read misse... */
+	{ 64724 },
+	/* l2-loads-misses\000legacy cache\000Level 2 (or higher) last level cach=
e read mis... */
+	{ 64610 },
+	/* l2-loads-ops\000legacy cache\000Level 2 (or higher) last level cache r=
ead access... */
+	{ 64393 },
+	/* l2-loads-reference\000legacy cache\000Level 2 (or higher) last level c=
ache read ... */
+	{ 64280 },
+	/* l2-loads-refs\000legacy cache\000Level 2 (or higher) last level cache =
read acces... */
+	{ 64172 },
+	/* l2-miss\000legacy cache\000Level 2 (or higher) last level cache read m=
isses\000l... */
+	{ 71977 },
+	/* l2-misses\000legacy cache\000Level 2 (or higher) last level cache read=
 misses\00... */
+	{ 71869 },
+	/* l2-ops\000legacy cache\000Level 2 (or higher) last level cache read ac=
cesses\000... */
+	{ 71664 },
+	/* l2-prefetch\000legacy cache\000Level 2 (or higher) last level cache pr=
efetch acc... */
+	{ 67985 },
+	/* l2-prefetch-access\000legacy cache\000Level 2 (or higher) last level c=
ache prefe... */
+	{ 68460 },
+	/* l2-prefetch-miss\000legacy cache\000Level 2 (or higher) last level cac=
he prefetc... */
+	{ 68702 },
+	/* l2-prefetch-misses\000legacy cache\000Level 2 (or higher) last level c=
ache prefe... */
+	{ 68581 },
+	/* l2-prefetch-ops\000legacy cache\000Level 2 (or higher) last level cach=
e prefetch... */
+	{ 68342 },
+	/* l2-prefetch-reference\000legacy cache\000Level 2 (or higher) last leve=
l cache pr... */
+	{ 68218 },
+	/* l2-prefetch-refs\000legacy cache\000Level 2 (or higher) last level cac=
he prefetc... */
+	{ 68099 },
+	/* l2-prefetches\000legacy cache\000Level 2 (or higher) last level cache =
prefetch a... */
+	{ 68821 },
+	/* l2-prefetches-access\000legacy cache\000Level 2 (or higher) last level=
 cache pre... */
+	{ 69304 },
+	/* l2-prefetches-miss\000legacy cache\000Level 2 (or higher) last level c=
ache prefe... */
+	{ 69550 },
+	/* l2-prefetches-misses\000legacy cache\000Level 2 (or higher) last level=
 cache pre... */
+	{ 69427 },
+	/* l2-prefetches-ops\000legacy cache\000Level 2 (or higher) last level ca=
che prefet... */
+	{ 69184 },
+	/* l2-prefetches-reference\000legacy cache\000Level 2 (or higher) last le=
vel cache ... */
+	{ 69058 },
+	/* l2-prefetches-refs\000legacy cache\000Level 2 (or higher) last level c=
ache prefe... */
+	{ 68937 },
+	/* l2-read\000legacy cache\000Level 2 (or higher) last level cache read a=
ccesses\00... */
+	{ 64836 },
+	/* l2-read-access\000legacy cache\000Level 2 (or higher) last level cache=
 read acce... */
+	{ 65263 },
+	/* l2-read-miss\000legacy cache\000Level 2 (or higher) last level cache r=
ead misses... */
+	{ 65485 },
+	/* l2-read-misses\000legacy cache\000Level 2 (or higher) last level cache=
 read miss... */
+	{ 65372 },
+	/* l2-read-ops\000legacy cache\000Level 2 (or higher) last level cache re=
ad accesse... */
+	{ 65157 },
+	/* l2-read-reference\000legacy cache\000Level 2 (or higher) last level ca=
che read a... */
+	{ 65045 },
+	/* l2-read-refs\000legacy cache\000Level 2 (or higher) last level cache r=
ead access... */
+	{ 64938 },
+	/* l2-reference\000legacy cache\000Level 2 (or higher) last level cache r=
ead access... */
+	{ 71557 },
+	/* l2-refs\000legacy cache\000Level 2 (or higher) last level cache read a=
ccesses\00... */
+	{ 71455 },
+	/* l2-speculative-load\000legacy cache\000Level 2 (or higher) last level =
cache pref... */
+	{ 70563 },
+	/* l2-speculative-load-access\000legacy cache\000Level 2 (or higher) last=
 level cac... */
+	{ 71070 },
+	/* l2-speculative-load-miss\000legacy cache\000Level 2 (or higher) last l=
evel cache... */
+	{ 71328 },
+	/* l2-speculative-load-misses\000legacy cache\000Level 2 (or higher) last=
 level cac... */
+	{ 71199 },
+	/* l2-speculative-load-ops\000legacy cache\000Level 2 (or higher) last le=
vel cache ... */
+	{ 70944 },
+	/* l2-speculative-load-reference\000legacy cache\000Level 2 (or higher) l=
ast level ... */
+	{ 70812 },
+	/* l2-speculative-load-refs\000legacy cache\000Level 2 (or higher) last l=
evel cache... */
+	{ 70685 },
+	/* l2-speculative-read\000legacy cache\000Level 2 (or higher) last level =
cache pref... */
+	{ 69671 },
+	/* l2-speculative-read-access\000legacy cache\000Level 2 (or higher) last=
 level cac... */
+	{ 70178 },
+	/* l2-speculative-read-miss\000legacy cache\000Level 2 (or higher) last l=
evel cache... */
+	{ 70436 },
+	/* l2-speculative-read-misses\000legacy cache\000Level 2 (or higher) last=
 level cac... */
+	{ 70307 },
+	/* l2-speculative-read-ops\000legacy cache\000Level 2 (or higher) last le=
vel cache ... */
+	{ 70052 },
+	/* l2-speculative-read-reference\000legacy cache\000Level 2 (or higher) l=
ast level ... */
+	{ 69920 },
+	/* l2-speculative-read-refs\000legacy cache\000Level 2 (or higher) last l=
evel cache... */
+	{ 69793 },
+	/* l2-store\000legacy cache\000Level 2 (or higher) last level cache write=
 accesses\... */
+	{ 65596 },
+	/* l2-store-access\000legacy cache\000Level 2 (or higher) last level cach=
e write ac... */
+	{ 66047 },
+	/* l2-store-miss\000legacy cache\000Level 2 (or higher) last level cache =
write miss... */
+	{ 66277 },
+	/* l2-store-misses\000legacy cache\000Level 2 (or higher) last level cach=
e write mi... */
+	{ 66162 },
+	/* l2-store-ops\000legacy cache\000Level 2 (or higher) last level cache w=
rite acces... */
+	{ 65935 },
+	/* l2-store-reference\000legacy cache\000Level 2 (or higher) last level c=
ache write... */
+	{ 65817 },
+	/* l2-store-refs\000legacy cache\000Level 2 (or higher) last level cache =
write acce... */
+	{ 65704 },
+	/* l2-stores\000legacy cache\000Level 2 (or higher) last level cache writ=
e accesses... */
+	{ 66390 },
+	/* l2-stores-access\000legacy cache\000Level 2 (or higher) last level cac=
he write a... */
+	{ 66845 },
+	/* l2-stores-miss\000legacy cache\000Level 2 (or higher) last level cache=
 write mis... */
+	{ 67077 },
+	/* l2-stores-misses\000legacy cache\000Level 2 (or higher) last level cac=
he write m... */
+	{ 66961 },
+	/* l2-stores-ops\000legacy cache\000Level 2 (or higher) last level cache =
write acce... */
+	{ 66732 },
+	/* l2-stores-reference\000legacy cache\000Level 2 (or higher) last level =
cache writ... */
+	{ 66613 },
+	/* l2-stores-refs\000legacy cache\000Level 2 (or higher) last level cache=
 write acc... */
+	{ 66499 },
+	/* l2-write\000legacy cache\000Level 2 (or higher) last level cache write=
 accesses\... */
+	{ 67191 },
+	/* l2-write-access\000legacy cache\000Level 2 (or higher) last level cach=
e write ac... */
+	{ 67642 },
+	/* l2-write-miss\000legacy cache\000Level 2 (or higher) last level cache =
write miss... */
+	{ 67872 },
+	/* l2-write-misses\000legacy cache\000Level 2 (or higher) last level cach=
e write mi... */
+	{ 67757 },
+	/* l2-write-ops\000legacy cache\000Level 2 (or higher) last level cache w=
rite acces... */
+	{ 67530 },
+	/* l2-write-reference\000legacy cache\000Level 2 (or higher) last level c=
ache write... */
+	{ 67412 },
+	/* l2-write-refs\000legacy cache\000Level 2 (or higher) last level cache =
write acce... */
+	{ 67299 },
+	/* llc\000legacy cache\000Last level cache read accesses\000legacy-cache-=
config=3D2\0... */
+	{ 55804 },
+	/* llc-access\000legacy cache\000Last level cache read accesses\000legacy=
-cache-con... */
+	{ 62951 },
+	/* llc-load\000legacy cache\000Last level cache read accesses\000legacy-c=
ache-confi... */
+	{ 55882 },
+	/* llc-load-access\000legacy cache\000Last level cache read accesses\000l=
egacy-cach... */
+	{ 56233 },
+	/* llc-load-miss\000legacy cache\000Last level cache read misses\000legac=
y-cache-co... */
+	{ 56417 },
+	/* llc-load-misses\000legacy cache\000Last level cache read misses\000leg=
acy-cache-... */
+	{ 56323 },
+	/* llc-load-ops\000legacy cache\000Last level cache read accesses\000lega=
cy-cache-c... */
+	{ 56146 },
+	/* llc-load-reference\000legacy cache\000Last level cache read accesses\0=
00legacy-c... */
+	{ 56053 },
+	/* llc-load-refs\000legacy cache\000Last level cache read accesses\000leg=
acy-cache-... */
+	{ 55965 },
+	/* llc-loads\000legacy cache\000Last level cache read accesses\000legacy-=
cache-conf... */
+	{ 56509 },
+	/* llc-loads-access\000legacy cache\000Last level cache read accesses\000=
legacy-cac... */
+	{ 56864 },
+	/* llc-loads-miss\000legacy cache\000Last level cache read misses\000lega=
cy-cache-c... */
+	{ 57050 },
+	/* llc-loads-misses\000legacy cache\000Last level cache read misses\000le=
gacy-cache... */
+	{ 56955 },
+	/* llc-loads-ops\000legacy cache\000Last level cache read accesses\000leg=
acy-cache-... */
+	{ 56776 },
+	/* llc-loads-reference\000legacy cache\000Last level cache read accesses\=
000legacy-... */
+	{ 56682 },
+	/* llc-loads-refs\000legacy cache\000Last level cache read accesses\000le=
gacy-cache... */
+	{ 56593 },
+	/* llc-miss\000legacy cache\000Last level cache read misses\000legacy-cac=
he-config=3D... */
+	{ 63125 },
+	/* llc-misses\000legacy cache\000Last level cache read misses\000legacy-c=
ache-confi... */
+	{ 63036 },
+	/* llc-ops\000legacy cache\000Last level cache read accesses\000legacy-ca=
che-config... */
+	{ 62869 },
+	/* llc-prefetch\000legacy cache\000Last level cache prefetch accesses\000=
legacy-cac... */
+	{ 59760 },
+	/* llc-prefetch-access\000legacy cache\000Last level cache prefetch acces=
ses\000leg... */
+	{ 60159 },
+	/* llc-prefetch-miss\000legacy cache\000Last level cache prefetch misses\=
000legacy-... */
+	{ 60363 },
+	/* llc-prefetch-misses\000legacy cache\000Last level cache prefetch misse=
s\000legac... */
+	{ 60261 },
+	/* llc-prefetch-ops\000legacy cache\000Last level cache prefetch accesses=
\000legacy... */
+	{ 60060 },
+	/* llc-prefetch-reference\000legacy cache\000Last level cache prefetch ac=
cesses\000... */
+	{ 59955 },
+	/* llc-prefetch-refs\000legacy cache\000Last level cache prefetch accesse=
s\000legac... */
+	{ 59855 },
+	/* llc-prefetches\000legacy cache\000Last level cache prefetch accesses\0=
00legacy-c... */
+	{ 60463 },
+	/* llc-prefetches-access\000legacy cache\000Last level cache prefetch acc=
esses\000l... */
+	{ 60870 },
+	/* llc-prefetches-miss\000legacy cache\000Last level cache prefetch misse=
s\000legac... */
+	{ 61078 },
+	/* llc-prefetches-misses\000legacy cache\000Last level cache prefetch mis=
ses\000leg... */
+	{ 60974 },
+	/* llc-prefetches-ops\000legacy cache\000Last level cache prefetch access=
es\000lega... */
+	{ 60769 },
+	/* llc-prefetches-reference\000legacy cache\000Last level cache prefetch =
accesses\0... */
+	{ 60662 },
+	/* llc-prefetches-refs\000legacy cache\000Last level cache prefetch acces=
ses\000leg... */
+	{ 60560 },
+	/* llc-read\000legacy cache\000Last level cache read accesses\000legacy-c=
ache-confi... */
+	{ 57143 },
+	/* llc-read-access\000legacy cache\000Last level cache read accesses\000l=
egacy-cach... */
+	{ 57494 },
+	/* llc-read-miss\000legacy cache\000Last level cache read misses\000legac=
y-cache-co... */
+	{ 57678 },
+	/* llc-read-misses\000legacy cache\000Last level cache read misses\000leg=
acy-cache-... */
+	{ 57584 },
+	/* llc-read-ops\000legacy cache\000Last level cache read accesses\000lega=
cy-cache-c... */
+	{ 57407 },
+	/* llc-read-reference\000legacy cache\000Last level cache read accesses\0=
00legacy-c... */
+	{ 57314 },
+	/* llc-read-refs\000legacy cache\000Last level cache read accesses\000leg=
acy-cache-... */
+	{ 57226 },
+	/* llc-reference\000legacy cache\000Last level cache read accesses\000leg=
acy-cache-... */
+	{ 62781 },
+	/* llc-refs\000legacy cache\000Last level cache read accesses\000legacy-c=
ache-confi... */
+	{ 62698 },
+	/* llc-speculative-load\000legacy cache\000Last level cache prefetch acce=
sses\000le... */
+	{ 61939 },
+	/* llc-speculative-load-access\000legacy cache\000Last level cache prefet=
ch accesse... */
+	{ 62370 },
+	/* llc-speculative-load-miss\000legacy cache\000Last level cache prefetch=
 misses\00... */
+	{ 62590 },
+	/* llc-speculative-load-misses\000legacy cache\000Last level cache prefet=
ch misses\... */
+	{ 62480 },
+	/* llc-speculative-load-ops\000legacy cache\000Last level cache prefetch =
accesses\0... */
+	{ 62263 },
+	/* llc-speculative-load-reference\000legacy cache\000Last level cache pre=
fetch acce... */
+	{ 62150 },
+	/* llc-speculative-load-refs\000legacy cache\000Last level cache prefetch=
 accesses\... */
+	{ 62042 },
+	/* llc-speculative-read\000legacy cache\000Last level cache prefetch acce=
sses\000le... */
+	{ 61180 },
+	/* llc-speculative-read-access\000legacy cache\000Last level cache prefet=
ch accesse... */
+	{ 61611 },
+	/* llc-speculative-read-miss\000legacy cache\000Last level cache prefetch=
 misses\00... */
+	{ 61831 },
+	/* llc-speculative-read-misses\000legacy cache\000Last level cache prefet=
ch misses\... */
+	{ 61721 },
+	/* llc-speculative-read-ops\000legacy cache\000Last level cache prefetch =
accesses\0... */
+	{ 61504 },
+	/* llc-speculative-read-reference\000legacy cache\000Last level cache pre=
fetch acce... */
+	{ 61391 },
+	/* llc-speculative-read-refs\000legacy cache\000Last level cache prefetch=
 accesses\... */
+	{ 61283 },
+	/* llc-store\000legacy cache\000Last level cache write accesses\000legacy=
-cache-con... */
+	{ 57770 },
+	/* llc-store-access\000legacy cache\000Last level cache write accesses\00=
0legacy-ca... */
+	{ 58145 },
+	/* llc-store-miss\000legacy cache\000Last level cache write misses\000leg=
acy-cache-... */
+	{ 58337 },
+	/* llc-store-misses\000legacy cache\000Last level cache write misses\000l=
egacy-cach... */
+	{ 58241 },
+	/* llc-store-ops\000legacy cache\000Last level cache write accesses\000le=
gacy-cache... */
+	{ 58052 },
+	/* llc-store-reference\000legacy cache\000Last level cache write accesses=
\000legacy... */
+	{ 57953 },
+	/* llc-store-refs\000legacy cache\000Last level cache write accesses\000l=
egacy-cach... */
+	{ 57859 },
+	/* llc-stores\000legacy cache\000Last level cache write accesses\000legac=
y-cache-co... */
+	{ 58431 },
+	/* llc-stores-access\000legacy cache\000Last level cache write accesses\0=
00legacy-c... */
+	{ 58810 },
+	/* llc-stores-miss\000legacy cache\000Last level cache write misses\000le=
gacy-cache... */
+	{ 59004 },
+	/* llc-stores-misses\000legacy cache\000Last level cache write misses\000=
legacy-cac... */
+	{ 58907 },
+	/* llc-stores-ops\000legacy cache\000Last level cache write accesses\000l=
egacy-cach... */
+	{ 58716 },
+	/* llc-stores-reference\000legacy cache\000Last level cache write accesse=
s\000legac... */
+	{ 58616 },
+	/* llc-stores-refs\000legacy cache\000Last level cache write accesses\000=
legacy-cac... */
+	{ 58521 },
+	/* llc-write\000legacy cache\000Last level cache write accesses\000legacy=
-cache-con... */
+	{ 59099 },
+	/* llc-write-access\000legacy cache\000Last level cache write accesses\00=
0legacy-ca... */
+	{ 59474 },
+	/* llc-write-miss\000legacy cache\000Last level cache write misses\000leg=
acy-cache-... */
+	{ 59666 },
+	/* llc-write-misses\000legacy cache\000Last level cache write misses\000l=
egacy-cach... */
+	{ 59570 },
+	/* llc-write-ops\000legacy cache\000Last level cache write accesses\000le=
gacy-cache... */
+	{ 59381 },
+	/* llc-write-reference\000legacy cache\000Last level cache write accesses=
\000legacy... */
+	{ 59282 },
+	/* llc-write-refs\000legacy cache\000Last level cache write accesses\000l=
egacy-cach... */
+	{ 59188 },
+	/* node\000legacy cache\000Local memory read accesses\000legacy-cache-con=
fig=3D6\000\... */
+	{ 114128 },
+	/* node-access\000legacy cache\000Local memory read accesses\000legacy-ca=
che-config... */
+	{ 121053 },
+	/* node-load\000legacy cache\000Local memory read accesses\000legacy-cach=
e-config=3D6... */
+	{ 114203 },
+	/* node-load-access\000legacy cache\000Local memory read accesses\000lega=
cy-cache-c... */
+	{ 114542 },
+	/* node-load-miss\000legacy cache\000Local memory read misses\000legacy-c=
ache-confi... */
+	{ 114720 },
+	/* node-load-misses\000legacy cache\000Local memory read misses\000legacy=
-cache-con... */
+	{ 114629 },
+	/* node-load-ops\000legacy cache\000Local memory read accesses\000legacy-=
cache-conf... */
+	{ 114458 },
+	/* node-load-reference\000legacy cache\000Local memory read accesses\000l=
egacy-cach... */
+	{ 114368 },
+	/* node-load-refs\000legacy cache\000Local memory read accesses\000legacy=
-cache-con... */
+	{ 114283 },
+	/* node-loads\000legacy cache\000Local memory read accesses\000legacy-cac=
he-config=3D... */
+	{ 114809 },
+	/* node-loads-access\000legacy cache\000Local memory read accesses\000leg=
acy-cache-... */
+	{ 115152 },
+	/* node-loads-miss\000legacy cache\000Local memory read misses\000legacy-=
cache-conf... */
+	{ 115332 },
+	/* node-loads-misses\000legacy cache\000Local memory read misses\000legac=
y-cache-co... */
+	{ 115240 },
+	/* node-loads-ops\000legacy cache\000Local memory read accesses\000legacy=
-cache-con... */
+	{ 115067 },
+	/* node-loads-reference\000legacy cache\000Local memory read accesses\000=
legacy-cac... */
+	{ 114976 },
+	/* node-loads-refs\000legacy cache\000Local memory read accesses\000legac=
y-cache-co... */
+	{ 114890 },
+	/* node-miss\000legacy cache\000Local memory read misses\000legacy-cache-=
config=3D0x1... */
+	{ 121221 },
+	/* node-misses\000legacy cache\000Local memory read misses\000legacy-cach=
e-config=3D0... */
+	{ 121135 },
+	/* node-ops\000legacy cache\000Local memory read accesses\000legacy-cache=
-config=3D6\... */
+	{ 120974 },
+	/* node-prefetch\000legacy cache\000Local memory prefetch accesses\000leg=
acy-cache-... */
+	{ 117955 },
+	/* node-prefetch-access\000legacy cache\000Local memory prefetch accesses=
\000legacy... */
+	{ 118342 },
+	/* node-prefetch-miss\000legacy cache\000Local memory prefetch misses\000=
legacy-cac... */
+	{ 118540 },
+	/* node-prefetch-misses\000legacy cache\000Local memory prefetch misses\0=
00legacy-c... */
+	{ 118441 },
+	/* node-prefetch-ops\000legacy cache\000Local memory prefetch accesses\00=
0legacy-ca... */
+	{ 118246 },
+	/* node-prefetch-reference\000legacy cache\000Local memory prefetch acces=
ses\000leg... */
+	{ 118144 },
+	/* node-prefetch-refs\000legacy cache\000Local memory prefetch accesses\0=
00legacy-c... */
+	{ 118047 },
+	/* node-prefetches\000legacy cache\000Local memory prefetch accesses\000l=
egacy-cach... */
+	{ 118637 },
+	/* node-prefetches-access\000legacy cache\000Local memory prefetch access=
es\000lega... */
+	{ 119032 },
+	/* node-prefetches-miss\000legacy cache\000Local memory prefetch misses\0=
00legacy-c... */
+	{ 119234 },
+	/* node-prefetches-misses\000legacy cache\000Local memory prefetch misses=
\000legacy... */
+	{ 119133 },
+	/* node-prefetches-ops\000legacy cache\000Local memory prefetch accesses\=
000legacy-... */
+	{ 118934 },
+	/* node-prefetches-reference\000legacy cache\000Local memory prefetch acc=
esses\000l... */
+	{ 118830 },
+	/* node-prefetches-refs\000legacy cache\000Local memory prefetch accesses=
\000legacy... */
+	{ 118731 },
+	/* node-read\000legacy cache\000Local memory read accesses\000legacy-cach=
e-config=3D6... */
+	{ 115422 },
+	/* node-read-access\000legacy cache\000Local memory read accesses\000lega=
cy-cache-c... */
+	{ 115761 },
+	/* node-read-miss\000legacy cache\000Local memory read misses\000legacy-c=
ache-confi... */
+	{ 115939 },
+	/* node-read-misses\000legacy cache\000Local memory read misses\000legacy=
-cache-con... */
+	{ 115848 },
+	/* node-read-ops\000legacy cache\000Local memory read accesses\000legacy-=
cache-conf... */
+	{ 115677 },
+	/* node-read-reference\000legacy cache\000Local memory read accesses\000l=
egacy-cach... */
+	{ 115587 },
+	/* node-read-refs\000legacy cache\000Local memory read accesses\000legacy=
-cache-con... */
+	{ 115502 },
+	/* node-reference\000legacy cache\000Local memory read accesses\000legacy=
-cache-con... */
+	{ 120889 },
+	/* node-refs\000legacy cache\000Local memory read accesses\000legacy-cach=
e-config=3D6... */
+	{ 120809 },
+	/* node-speculative-load\000legacy cache\000Local memory prefetch accesse=
s\000legac... */
+	{ 120071 },
+	/* node-speculative-load-access\000legacy cache\000Local memory prefetch =
accesses\0... */
+	{ 120490 },
+	/* node-speculative-load-miss\000legacy cache\000Local memory prefetch mi=
sses\000le... */
+	{ 120704 },
+	/* node-speculative-load-misses\000legacy cache\000Local memory prefetch =
misses\000... */
+	{ 120597 },
+	/* node-speculative-load-ops\000legacy cache\000Local memory prefetch acc=
esses\000l... */
+	{ 120386 },
+	/* node-speculative-load-reference\000legacy cache\000Local memory prefet=
ch accesse... */
+	{ 120276 },
+	/* node-speculative-load-refs\000legacy cache\000Local memory prefetch ac=
cesses\000... */
+	{ 120171 },
+	/* node-speculative-read\000legacy cache\000Local memory prefetch accesse=
s\000legac... */
+	{ 119333 },
+	/* node-speculative-read-access\000legacy cache\000Local memory prefetch =
accesses\0... */
+	{ 119752 },
+	/* node-speculative-read-miss\000legacy cache\000Local memory prefetch mi=
sses\000le... */
+	{ 119966 },
+	/* node-speculative-read-misses\000legacy cache\000Local memory prefetch =
misses\000... */
+	{ 119859 },
+	/* node-speculative-read-ops\000legacy cache\000Local memory prefetch acc=
esses\000l... */
+	{ 119648 },
+	/* node-speculative-read-reference\000legacy cache\000Local memory prefet=
ch accesse... */
+	{ 119538 },
+	/* node-speculative-read-refs\000legacy cache\000Local memory prefetch ac=
cesses\000... */
+	{ 119433 },
+	/* node-store\000legacy cache\000Local memory write accesses\000legacy-ca=
che-config... */
+	{ 116028 },
+	/* node-store-access\000legacy cache\000Local memory write accesses\000le=
gacy-cache... */
+	{ 116391 },
+	/* node-store-miss\000legacy cache\000Local memory write misses\000legacy=
-cache-con... */
+	{ 116577 },
+	/* node-store-misses\000legacy cache\000Local memory write misses\000lega=
cy-cache-c... */
+	{ 116484 },
+	/* node-store-ops\000legacy cache\000Local memory write accesses\000legac=
y-cache-co... */
+	{ 116301 },
+	/* node-store-reference\000legacy cache\000Local memory write accesses\00=
0legacy-ca... */
+	{ 116205 },
+	/* node-store-refs\000legacy cache\000Local memory write accesses\000lega=
cy-cache-c... */
+	{ 116114 },
+	/* node-stores\000legacy cache\000Local memory write accesses\000legacy-c=
ache-confi... */
+	{ 116668 },
+	/* node-stores-access\000legacy cache\000Local memory write accesses\000l=
egacy-cach... */
+	{ 117035 },
+	/* node-stores-miss\000legacy cache\000Local memory write misses\000legac=
y-cache-co... */
+	{ 117223 },
+	/* node-stores-misses\000legacy cache\000Local memory write misses\000leg=
acy-cache-... */
+	{ 117129 },
+	/* node-stores-ops\000legacy cache\000Local memory write accesses\000lega=
cy-cache-c... */
+	{ 116944 },
+	/* node-stores-reference\000legacy cache\000Local memory write accesses\0=
00legacy-c... */
+	{ 116847 },
+	/* node-stores-refs\000legacy cache\000Local memory write accesses\000leg=
acy-cache-... */
+	{ 116755 },
+	/* node-write\000legacy cache\000Local memory write accesses\000legacy-ca=
che-config... */
+	{ 117315 },
+	/* node-write-access\000legacy cache\000Local memory write accesses\000le=
gacy-cache... */
+	{ 117678 },
+	/* node-write-miss\000legacy cache\000Local memory write misses\000legacy=
-cache-con... */
+	{ 117864 },
+	/* node-write-misses\000legacy cache\000Local memory write misses\000lega=
cy-cache-c... */
+	{ 117771 },
+	/* node-write-ops\000legacy cache\000Local memory write accesses\000legac=
y-cache-co... */
+	{ 117588 },
+	/* node-write-reference\000legacy cache\000Local memory write accesses\00=
0legacy-ca... */
+	{ 117492 },
+	/* node-write-refs\000legacy cache\000Local memory write accesses\000lega=
cy-cache-c... */
+	{ 117401 },
+	/* ref-cycles\000legacy hardware\000Total cycles; not affected by CPU fre=
quency sca... */
+	{ 123400 },
+	/* stalled-cycles-backend\000legacy hardware\000Stalled cycles during ret=
irement [T... */
+	{ 123094 },
+	/* stalled-cycles-frontend\000legacy hardware\000Stalled cycles during is=
sue [This ... */
+	{ 122795 },
 };
 static const struct compact_pmu_event pmu_events__common_software[] =3D {
-{ 124563 }, /* alignment-faults\000software\000Number of kernel handled me=
mory alignment faults\000config=3D7\000\00000\000\000\000\000\000 */
-{ 124862 }, /* bpf-output\000software\000An event used by BPF programs to =
write to the perf ring buffer\000config=3D0xa\000\00000\000\000\000\000\000=
 */
-{ 124964 }, /* cgroup-switches\000software\000Number of context switches t=
o a task in a different cgroup\000config=3D0xb\000\00000\000\000\000\000\00=
0 */
-{ 123885 }, /* context-switches\000software\000Number of context switches =
[This event is an alias of cs]\000config=3D3\000\00000\000\000\000\000\000 =
*/
-{ 123521 }, /* cpu-clock\000software\000Per-CPU high-resolution timer base=
d event\000config=3D0\000\000001e-6msec\000\000\000\000\000 */
-{ 124087 }, /* cpu-migrations\000software\000Number of times a process has=
 migrated to a new CPU [This event is an alias of migrations]\000config=3D4=
\000\00000\000\000\000\000\000 */
-{ 123986 }, /* cs\000software\000Number of context switches [This event is=
 an alias of context-switches]\000config=3D3\000\00000\000\000\000\000\000 =
*/
-{ 124782 }, /* dummy\000software\000A placeholder event that doesn't count=
 anything\000config=3D9\000\00000\000\000\000\000\000 */
-{ 124655 }, /* emulation-faults\000software\000Number of kernel handled un=
implemented instruction faults handled through emulation\000config=3D8\000\=
00000\000\000\000\000\000 */
-{ 123695 }, /* faults\000software\000Number of page faults [This event is =
an alias of page-faults]\000config=3D2\000\00000\000\000\000\000\000 */
-{ 124460 }, /* major-faults\000software\000Number of major page faults. Ma=
jor faults require I/O to handle\000config=3D6\000\00000\000\000\000\000\00=
0 */
-{ 124219 }, /* migrations\000software\000Number of times a process has mig=
rated to a new CPU [This event is an alias of cpu-migrations]\000config=3D4=
\000\00000\000\000\000\000\000 */
-{ 124351 }, /* minor-faults\000software\000Number of minor page faults. Mi=
nor faults don't require I/O to handle\000config=3D5\000\00000\000\000\000\=
000\000 */
-{ 123790 }, /* page-faults\000software\000Number of page faults [This even=
t is an alias of faults]\000config=3D2\000\00000\000\000\000\000\000 */
-{ 123607 }, /* task-clock\000software\000Per-task high-resolution timer ba=
sed event\000config=3D1\000\000001e-6msec\000\000\000\000\000 */
+	/* alignment-faults\000software\000Number of kernel handled memory alignm=
ent faults... */
+	{ 124563 },
+	/* bpf-output\000software\000An event used by BPF programs to write to th=
e perf rin... */
+	{ 124862 },
+	/* cgroup-switches\000software\000Number of context switches to a task in=
 a differe... */
+	{ 124964 },
+	/* context-switches\000software\000Number of context switches [This event=
 is an ali... */
+	{ 123885 },
+	/* cpu-clock\000software\000Per-CPU high-resolution timer based event\000=
config=3D0\0... */
+	{ 123521 },
+	/* cpu-migrations\000software\000Number of times a process has migrated t=
o a new CP... */
+	{ 124087 },
+	/* cs\000software\000Number of context switches [This event is an alias o=
f context-... */
+	{ 123986 },
+	/* dummy\000software\000A placeholder event that doesn't count anything\0=
00config=3D9... */
+	{ 124782 },
+	/* emulation-faults\000software\000Number of kernel handled unimplemented=
 instructi... */
+	{ 124655 },
+	/* faults\000software\000Number of page faults [This event is an alias of=
 page-faul... */
+	{ 123695 },
+	/* major-faults\000software\000Number of major page faults. Major faults =
require I/... */
+	{ 124460 },
+	/* migrations\000software\000Number of times a process has migrated to a =
new CPU [T... */
+	{ 124219 },
+	/* minor-faults\000software\000Number of minor page faults. Minor faults =
don't requ... */
+	{ 124351 },
+	/* page-faults\000software\000Number of page faults [This event is an ali=
as of faul... */
+	{ 123790 },
+	/* task-clock\000software\000Per-task high-resolution timer based event\0=
00config=3D1... */
+	{ 123607 },
 };
 static const struct compact_pmu_event pmu_events__common_tool[] =3D {
-{ 126205 }, /* core_wide\000tool\0001 if not SMT, if SMT are events being =
gathered on all SMT threads 1 otherwise 0\000config=3D0xd\000\00000\000\000=
\000\000\000 */
-{ 125072 }, /* duration_time\000tool\000Wall clock interval time in nanose=
conds\000config=3D1\000\00000\000\000\000\000\000 */
-{ 125286 }, /* has_pmem\000tool\0001 if persistent memory installed otherw=
ise 0\000config=3D4\000\00000\000\000\000\000\000 */
-{ 125362 }, /* num_cores\000tool\000Number of cores. A core consists of 1 =
or more thread, with each thread being associated with a logical Linux CPU\=
000config=3D5\000\00000\000\000\000\000\000 */
-{ 125507 }, /* num_cpus\000tool\000Number of logical Linux CPUs. There may=
 be multiple such CPUs on a core\000config=3D6\000\00000\000\000\000\000\00=
0 */
-{ 125610 }, /* num_cpus_online\000tool\000Number of online logical Linux C=
PUs. There may be multiple such CPUs on a core\000config=3D7\000\00000\000\=
000\000\000\000 */
-{ 125727 }, /* num_dies\000tool\000Number of dies. Each die has 1 or more =
cores\000config=3D8\000\00000\000\000\000\000\000 */
-{ 125803 }, /* num_packages\000tool\000Number of packages. Each package ha=
s 1 or more die\000config=3D9\000\00000\000\000\000\000\000 */
-{ 125889 }, /* slots\000tool\000Number of functional units that in paralle=
l can execute parts of an instruction\000config=3D0xa\000\00000\000\000\000=
\000\000 */
-{ 125999 }, /* smt_on\000tool\0001 if simultaneous multithreading (aka hyp=
erthreading) is enable otherwise 0\000config=3D0xb\000\00000\000\000\000\00=
0\000 */
-{ 125218 }, /* system_time\000tool\000System/kernel time in nanoseconds\00=
0config=3D3\000\00000\000\000\000\000\000 */
-{ 126106 }, /* system_tsc_freq\000tool\000The amount a Time Stamp Counter =
(TSC) increases per second\000config=3D0xc\000\00000\000\000\000\000\000 */
-{ 126319 }, /* target_cpu\000tool\0001 if CPUs being analyzed, 0 if thread=
s/processes\000config=3D0xe\000\00000\000\000\000\000\000 */
-{ 125148 }, /* user_time\000tool\000User (non-kernel) time in nanoseconds\=
000config=3D2\000\00000\000\000\000\000\000 */
+	/* core_wide\000tool\0001 if not SMT, if SMT are events being gathered on=
 all SMT t... */
+	{ 126205 },
+	/* duration_time\000tool\000Wall clock interval time in nanoseconds\000co=
nfig=3D1\000... */
+	{ 125072 },
+	/* has_pmem\000tool\0001 if persistent memory installed otherwise 0\000co=
nfig=3D4\000... */
+	{ 125286 },
+	/* num_cores\000tool\000Number of cores. A core consists of 1 or more thr=
ead, with ... */
+	{ 125362 },
+	/* num_cpus\000tool\000Number of logical Linux CPUs. There may be multipl=
e such CPU... */
+	{ 125507 },
+	/* num_cpus_online\000tool\000Number of online logical Linux CPUs. There =
may be mul... */
+	{ 125610 },
+	/* num_dies\000tool\000Number of dies. Each die has 1 or more cores\000co=
nfig=3D8\000... */
+	{ 125727 },
+	/* num_packages\000tool\000Number of packages. Each package has 1 or more=
 die\000co... */
+	{ 125803 },
+	/* slots\000tool\000Number of functional units that in parallel can execu=
te parts o... */
+	{ 125889 },
+	/* smt_on\000tool\0001 if simultaneous multithreading (aka hyperthreading=
) is enabl... */
+	{ 125999 },
+	/* system_time\000tool\000System/kernel time in nanoseconds\000config=3D3=
\000\00000\0... */
+	{ 125218 },
+	/* system_tsc_freq\000tool\000The amount a Time Stamp Counter (TSC) incre=
ases per s... */
+	{ 126106 },
+	/* target_cpu\000tool\0001 if CPUs being analyzed, 0 if threads/processes=
\000config... */
+	{ 126319 },
+	/* user_time\000tool\000User (non-kernel) time in nanoseconds\000config=
=3D2\000\00000... */
+	{ 125148 },
=20
 };
=20
 static const struct pmu_table_entry pmu_events__common[] =3D {
-{
-     .entries =3D pmu_events__common_default_core,
-     .num_entries =3D ARRAY_SIZE(pmu_events__common_default_core),
-     .pmu_name =3D { 0 /* default_core\000 */ },
-},
-{
-     .entries =3D pmu_events__common_software,
-     .num_entries =3D ARRAY_SIZE(pmu_events__common_software),
-     .pmu_name =3D { 123512 /* software\000 */ },
-},
-{
-     .entries =3D pmu_events__common_tool,
-     .num_entries =3D ARRAY_SIZE(pmu_events__common_tool),
-     .pmu_name =3D { 125067 /* tool\000 */ },
-},
+	{
+		.entries =3D pmu_events__common_default_core,
+		.num_entries =3D ARRAY_SIZE(pmu_events__common_default_core),
+		.pmu_name =3D { 0 /* default_core\000 */ },
+	},
+	{
+		.entries =3D pmu_events__common_software,
+		.num_entries =3D ARRAY_SIZE(pmu_events__common_software),
+		.pmu_name =3D { 123512 /* software\000 */ },
+	},
+	{
+		.entries =3D pmu_events__common_tool,
+		.num_entries =3D ARRAY_SIZE(pmu_events__common_tool),
+		.pmu_name =3D { 125067 /* tool\000 */ },
+	},
 };
=20
 static const struct compact_pmu_event pmu_metrics__common_default_core[] =
=3D {
-{ 127956 }, /* CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\000\0001CPU=
s\000\000\000\000011 */
-{ 129583 }, /* backend_cycles_idle\000Default\000(stalled\\-cycles\\-backe=
nd / cpu\\-cycles if has_event(stalled\\-cycles\\-backend) else 0)\000backe=
nd_cycles_idle > 0.2\000Backend stalls per cycle\000\000\000\000\000\000001=
 */
-{ 129933 }, /* branch_frequency\000Default\000branches / (software@cpu\\-c=
lock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,na=
me\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000M/sec\000\0=
00\000\000011 */
-{ 130113 }, /* branch_miss_rate\000Default\000branch\\-misses / branches\0=
00branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\000\00000=
1 */
-{ 128142 }, /* cs_per_second\000Default\000software@context\\-switches\\,n=
ame\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-=
clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\=
000\000Context switches per CPU second\000\0001cs/sec\000\000\000\000011 */
-{ 129757 }, /* cycles_frequency\000Default\000cpu\\-cycles / (software@cpu=
\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\=
\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\000\=
000\000011 */
-{ 130549 }, /* dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses / dTLB\\=
-loads\000dtlb_miss_rate > 0.05\000dTLB miss rate\000\000100%\000\000\000\0=
00001 */
-{ 129404 }, /* frontend_cycles_idle\000Default\000(stalled\\-cycles\\-fron=
tend / cpu\\-cycles if has_event(stalled\\-cycles\\-frontend) else 0)\000fr=
ontend_cycles_idle > 0.1\000Frontend stalls per cycle\000\000\000\000\000\0=
00001 */
-{ 128866 }, /* insn_per_cycle\000Default\000instructions / cpu\\-cycles\00=
0insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\000\000\=
000\000001 */
-{ 130655 }, /* itlb_miss_rate\000Default3\000iTLB\\-load\\-misses / iTLB\\=
-loads\000itlb_miss_rate > 0.05\000iTLB miss rate\000\000100%\000\000\000\0=
00001 */
-{ 130761 }, /* l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-prefetch=
\\-misses / L1\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0.05\000L1 =
prefetch miss rate\000\000100%\000\000\000\000001 */
-{ 130217 }, /* l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-misses / =
L1\\-dcache\\-loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000\000100%\0=
00\000\000\000001 */
-{ 130434 }, /* l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-misses / =
L1\\-icache\\-loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\000100%\00=
0\000\000\000001 */
-{ 130333 }, /* llc_miss_rate\000Default2\000LLC\\-load\\-misses / LLC\\-lo=
ads\000llc_miss_rate > 0.05\000LLC miss rate\000\000100%\000\000\000\000001=
 */
-{ 128375 }, /* migrations_per_second\000Default\000software@cpu\\-migratio=
ns\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcp=
u\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-cloc=
k@)\000\000Process migrations to a new CPU per CPU second\000\0001migration=
s/sec\000\000\000\000011 */
-{ 128635 }, /* page_faults_per_second\000Default\000software@page\\-faults=
\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-c=
lock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\0=
00\000Page faults per CPU second\000\0001faults/sec\000\000\000\000011 */
-{ 128979 }, /* stalled_cycles_per_instruction\000Default\000(max(stalled\\=
-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions if has_event=
(stalled\\-cycles\\-frontend) & has_event(stalled\\-cycles\\-backend) else =
(stalled\\-cycles\\-frontend / instructions if has_event(stalled\\-cycles\\=
-frontend) else (stalled\\-cycles\\-backend / instructions if has_event(sta=
lled\\-cycles\\-backend) else 0)))\000\000Max front or backend stalls per i=
nstruction\000\000\000\000\000\000001 */
+	/* CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=3Dcpu\\-clo=
ck@ if #targ... */
+	{ 127956 },
+	/* backend_cycles_idle\000Default\000(stalled\\-cycles\\-backend / cpu\\-=
cycles if ... */
+	{ 129583 },
+	/* branch_frequency\000Default\000branches / (software@cpu\\-clock\\,name=
\\=3Dcpu\\-c... */
+	{ 129933 },
+	/* branch_miss_rate\000Default\000branch\\-misses / branches\000branch_mi=
ss_rate > ... */
+	{ 130113 },
+	/* cs_per_second\000Default\000software@context\\-switches\\,name\\=3Dcon=
text\\-switc... */
+	{ 128142 },
+	/* cycles_frequency\000Default\000cpu\\-cycles / (software@cpu\\-clock\\,=
name\\=3Dcpu... */
+	{ 129757 },
+	/* dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses / dTLB\\-loads\000d=
tlb_miss_r... */
+	{ 130549 },
+	/* frontend_cycles_idle\000Default\000(stalled\\-cycles\\-frontend / cpu\=
\-cycles i... */
+	{ 129404 },
+	/* insn_per_cycle\000Default\000instructions / cpu\\-cycles\000insn_per_c=
ycle < 1\0... */
+	{ 128866 },
+	/* itlb_miss_rate\000Default3\000iTLB\\-load\\-misses / iTLB\\-loads\000i=
tlb_miss_r... */
+	{ 130655 },
+	/* l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-prefetch\\-misses /=
 L1\\-dcac... */
+	{ 130761 },
+	/* l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-misses / L1\\-dcache=
\\-loads\0... */
+	{ 130217 },
+	/* l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-misses / L1\\-icache=
\\-loads\0... */
+	{ 130434 },
+	/* llc_miss_rate\000Default2\000LLC\\-load\\-misses / LLC\\-loads\000llc_=
miss_rate ... */
+	{ 130333 },
+	/* migrations_per_second\000Default\000software@cpu\\-migrations\\,name\\=
=3Dcpu\\-mig... */
+	{ 128375 },
+	/* page_faults_per_second\000Default\000software@page\\-faults\\,name\\=
=3Dpage\\-faul... */
+	{ 128635 },
+	/* stalled_cycles_per_instruction\000Default\000(max(stalled\\-cycles\\-f=
rontend, s... */
+	{ 128979 },
=20
 };
=20
 static const struct pmu_table_entry pmu_metrics__common[] =3D {
-{
-     .entries =3D pmu_metrics__common_default_core,
-     .num_entries =3D ARRAY_SIZE(pmu_metrics__common_default_core),
-     .pmu_name =3D { 0 /* default_core\000 */ },
-},
+	{
+		.entries =3D pmu_metrics__common_default_core,
+		.num_entries =3D ARRAY_SIZE(pmu_metrics__common_default_core),
+		.pmu_name =3D { 0 /* default_core\000 */ },
+	},
 };
=20
 static const struct compact_pmu_event pmu_events__test_soc_cpu_default_cor=
e[] =3D {
-{ 126403 }, /* bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=
=3D0x8a\000\00000\000\000\000\000\000 */
-{ 126465 }, /* bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=
=3D0x8b\000\00000\000\000\000\000\000 */
-{ 126727 }, /* dispatch_blocked.any\000other\000Memory cluster signals to =
block micro-op dispatch for any reason\000event=3D9,period=3D200000,umask=
=3D0x20\000\00000\000\000\000\000\000 */
-{ 126860 }, /* eist_trans\000other\000Number of Enhanced Intel SpeedStep(R=
) Technology (EIST) transitions\000event=3D0x3a,period=3D200000\000\00000\0=
00\000\000\000\000 */
-{ 126527 }, /* l3_cache_rd\000cache\000L3 cache access, read\000event=3D0x=
40\000\00000\000\000\000\000Attributable Level 3 cache access, read\000 */
-{ 126625 }, /* segment_reg_loads.any\000other\000Number of segment registe=
r loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\000\000\000=
\000 */
+	/* bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=3D0x8a\000\0=
0000\000\000... */
+	{ 126403 },
+	/* bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=3D0x8b\000\0=
0000\000\000... */
+	{ 126465 },
+	/* dispatch_blocked.any\000other\000Memory cluster signals to block micro=
-op dispat... */
+	{ 126727 },
+	/* eist_trans\000other\000Number of Enhanced Intel SpeedStep(R) Technolog=
y (EIST) t... */
+	{ 126860 },
+	/* l3_cache_rd\000cache\000L3 cache access, read\000event=3D0x40\000\0000=
0\000\000\00... */
+	{ 126527 },
+	/* segment_reg_loads.any\000other\000Number of segment register loads\000=
event=3D6,pe... */
+	{ 126625 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl_d=
drc[] =3D {
-{ 126993 }, /* uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands=
\000event=3D2\000\00000\000\000\000\000\000 */
+	/* uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands\000event=
=3D2\000\00000... */
+	{ 126993 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl_l=
3c[] =3D {
-{ 127355 }, /* uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\0=
00event=3D7\000\00000\000\000\000\000\000 */
+	/* uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\000event=3D7=
\000\00000\0... */
+	{ 127355 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_cbox=
[] =3D {
-{ 127229 }, /* event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\00=
0\00000\000\000\000\000\000 */
-{ 127283 }, /* event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0xc=
0\000\00000\000\000\000\000\000 */
-{ 127075 }, /* unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-co=
re snoop resulted from L3 Eviction which misses in some processor core\000e=
vent=3D0x22,umask=3D0x81\000\00000\000\000\000\000\000 */
+	/* event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\000\00000\000=
\000\000\000... */
+	{ 127229 },
+	/* event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0xc0\000\00000=
\000\000\000... */
+	{ 127283 },
+	/* unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-core snoop re=
sulted fro... */
+	{ 127075 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc[=
] =3D {
-{ 127538 }, /* uncore_imc.cache_hits\000uncore\000Total cache hits\000even=
t=3D0x34\000\00000\000\000\000\000\000 */
+	/* uncore_imc.cache_hits\000uncore\000Total cache hits\000event=3D0x34\00=
0\00000\000\... */
+	{ 127538 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc_=
free_running[] =3D {
-{ 127447 }, /* uncore_imc_free_running.cache_miss\000uncore\000Total cache=
 misses\000event=3D0x12\000\00000\000\000\000\000\000 */
+	/* uncore_imc_free_running.cache_miss\000uncore\000Total cache misses\000=
event=3D0x12... */
+	{ 127447 },
=20
 };
=20
 static const struct pmu_table_entry pmu_events__test_soc_cpu[] =3D {
-{
-     .entries =3D pmu_events__test_soc_cpu_default_core,
-     .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_default_core),
-     .pmu_name =3D { 0 /* default_core\000 */ },
-},
-{
-     .entries =3D pmu_events__test_soc_cpu_hisi_sccl_ddrc,
-     .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_ddrc),
-     .pmu_name =3D { 126978 /* hisi_sccl,ddrc\000 */ },
-},
-{
-     .entries =3D pmu_events__test_soc_cpu_hisi_sccl_l3c,
-     .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_l3c),
-     .pmu_name =3D { 127341 /* hisi_sccl,l3c\000 */ },
-},
-{
-     .entries =3D pmu_events__test_soc_cpu_uncore_cbox,
-     .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_cbox),
-     .pmu_name =3D { 127063 /* uncore_cbox\000 */ },
-},
-{
-     .entries =3D pmu_events__test_soc_cpu_uncore_imc,
-     .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc),
-     .pmu_name =3D { 127527 /* uncore_imc\000 */ },
-},
-{
-     .entries =3D pmu_events__test_soc_cpu_uncore_imc_free_running,
-     .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc_free_=
running),
-     .pmu_name =3D { 127423 /* uncore_imc_free_running\000 */ },
-},
+	{
+		.entries =3D pmu_events__test_soc_cpu_default_core,
+		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_default_core),
+		.pmu_name =3D { 0 /* default_core\000 */ },
+	},
+	{
+		.entries =3D pmu_events__test_soc_cpu_hisi_sccl_ddrc,
+		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_ddrc),
+		.pmu_name =3D { 126978 /* hisi_sccl,ddrc\000 */ },
+	},
+	{
+		.entries =3D pmu_events__test_soc_cpu_hisi_sccl_l3c,
+		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_l3c),
+		.pmu_name =3D { 127341 /* hisi_sccl,l3c\000 */ },
+	},
+	{
+		.entries =3D pmu_events__test_soc_cpu_uncore_cbox,
+		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_cbox),
+		.pmu_name =3D { 127063 /* uncore_cbox\000 */ },
+	},
+	{
+		.entries =3D pmu_events__test_soc_cpu_uncore_imc,
+		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc),
+		.pmu_name =3D { 127527 /* uncore_imc\000 */ },
+	},
+	{
+		.entries =3D pmu_events__test_soc_cpu_uncore_imc_free_running,
+		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc_free_run=
ning),
+		.pmu_name =3D { 127423 /* uncore_imc_free_running\000 */ },
+	},
 };
=20
 static const struct compact_pmu_event pmu_metrics__test_soc_cpu_default_co=
re[] =3D {
-{ 130909 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\000000 */
-{ 131598 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Mis=
s\000\000\000\000\000\000\000\000000 */
-{ 131368 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_=
rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000 */
-{ 131463 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd -=
 l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000=
\000\000\000\000\000\000\000000 */
-{ 131663 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2=
_All)\000\000\000\000\000\000\000\000000 */
-{ 131732 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_=
L2_All)\000\000\000\000\000\000\000\000000 */
-{ 130996 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 =
* (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / =
cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000 */
-{ 130932 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread=
\000\000\000\000\000\000\000\000000 */
-{ 131870 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / durat=
ion_time\000\000\000\000\000\000\000\000000 */
-{ 131803 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\000000 */
-{ 131826 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\000000 */
-{ 131849 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\000000 */
-{ 131296 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_mis=
s_cycles\000\000\000\000\000\000\000\000000 */
-{ 131163 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.=
any\000\000\000\000\000\000\000\000000 */
-{ 131228 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retir=
ed.any\000\000\000\000\000\000\000\000000 */
+	/* CPI\000\0001 / IPC\000\000\000\000\000\000\000\000000 */
+	{ 130909 },
+	/* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\000\000\0=
00\000\000... */
+	{ 131598 },
+	/* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hi=
t + l2_rqs... */
+	{ 131368 },
+	/* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd - l2_rqsts.d=
emand_data... */
+	{ 131463 },
+	/* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2_All)\000\0=
00\000\000... */
+	{ 131663 },
+	/* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_L2_All)\000=
\000\000\0... */
+	{ 131732 },
+	/* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * (cpu_clk_=
unhalted.t... */
+	{ 130996 },
+	/* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\000\000\00=
0\000\000\... */
+	{ 130932 },
+	/* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duration_time\00=
0\000\000\... */
+	{ 131870 },
+	/* M1\000\000ipc + M2\000\000\000\000\000\000\000\000000 */
+	{ 131803 },
+	/* M2\000\000ipc + M1\000\000\000\000\000\000\000\000000 */
+	{ 131826 },
+	/* M3\000\0001 / M3\000\000\000\000\000\000\000\000000 */
+	{ 131849 },
+	/* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_cycles\00=
0\000\000\... */
+	{ 131296 },
+	/* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.any\000\000=
\000\000\0... */
+	{ 131163 },
+	/* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired.any\000\=
000\000\00... */
+	{ 131228 },
=20
 };
=20
 static const struct pmu_table_entry pmu_metrics__test_soc_cpu[] =3D {
-{
-     .entries =3D pmu_metrics__test_soc_cpu_default_core,
-     .num_entries =3D ARRAY_SIZE(pmu_metrics__test_soc_cpu_default_core),
-     .pmu_name =3D { 0 /* default_core\000 */ },
-},
+	{
+		.entries =3D pmu_metrics__test_soc_cpu_default_core,
+		.num_entries =3D ARRAY_SIZE(pmu_metrics__test_soc_cpu_default_core),
+		.pmu_name =3D { 0 /* default_core\000 */ },
+	},
 };
=20
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
ccn_pmu[] =3D {
-{ 127717 }, /* sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\=
000config=3D0x2c\0000x01\00000\000\000\000\000\000 */
+	/* sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\000config=
=3D0x2c\0000x0... */
+	{ 127717 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
cmn_pmu[] =3D {
-{ 127813 }, /* sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache =
misses in first lookup result (high priority)\000eventid=3D1,type=3D5\000(4=
34|436|43c|43a).*\00000\000\000\000\000\000 */
+	/* sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache misses in f=
irst looku... */
+	{ 127813 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
ddr_pmu[] =3D {
-{ 127622 }, /* sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles even=
t\000event=3D0x2b\000v8\00000\000\000\000\000\000 */
+	/* sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles event\000event=
=3D0x2b\000v8... */
+	{ 127622 },
=20
 };
=20
 static const struct pmu_table_entry pmu_events__test_soc_sys[] =3D {
-{
-     .entries =3D pmu_events__test_soc_sys_uncore_sys_ccn_pmu,
-     .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ccn_p=
mu),
-     .pmu_name =3D { 127698 /* uncore_sys_ccn_pmu\000 */ },
-},
-{
-     .entries =3D pmu_events__test_soc_sys_uncore_sys_cmn_pmu,
-     .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_cmn_p=
mu),
-     .pmu_name =3D { 127794 /* uncore_sys_cmn_pmu\000 */ },
-},
-{
-     .entries =3D pmu_events__test_soc_sys_uncore_sys_ddr_pmu,
-     .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ddr_p=
mu),
-     .pmu_name =3D { 127603 /* uncore_sys_ddr_pmu\000 */ },
-},
+	{
+		.entries =3D pmu_events__test_soc_sys_uncore_sys_ccn_pmu,
+		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ccn_pmu)=
,
+		.pmu_name =3D { 127698 /* uncore_sys_ccn_pmu\000 */ },
+	},
+	{
+		.entries =3D pmu_events__test_soc_sys_uncore_sys_cmn_pmu,
+		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_cmn_pmu)=
,
+		.pmu_name =3D { 127794 /* uncore_sys_cmn_pmu\000 */ },
+	},
+	{
+		.entries =3D pmu_events__test_soc_sys_uncore_sys_ddr_pmu,
+		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ddr_pmu)=
,
+		.pmu_name =3D { 127603 /* uncore_sys_ddr_pmu\000 */ },
+	},
 };
=20
=20
 /* Struct used to make the PMU event table implementation opaque to caller=
s. */
 struct pmu_events_table {
-        const struct pmu_table_entry *pmus;
-        uint32_t num_pmus;
+	const struct pmu_table_entry *pmus;
+	uint32_t num_pmus;
 };
=20
 /* Struct used to make the PMU metric table implementation opaque to calle=
rs. */
 struct pmu_metrics_table {
-        const struct pmu_table_entry *pmus;
-        uint32_t num_pmus;
+	const struct pmu_table_entry *pmus;
+	uint32_t num_pmus;
 };
=20
 /*
@@ -2791,10 +5416,10 @@ struct pmu_metrics_table {
  * The  cpuid can contain any character other than the comma.
  */
 struct pmu_events_map {
-        const char *arch;
-        const char *cpuid;
-        struct pmu_events_table event_table;
-        struct pmu_metrics_table metric_table;
+	const char *arch;
+	const char *cpuid;
+	struct pmu_events_table event_table;
+	struct pmu_metrics_table metric_table;
 };
=20
 /*
@@ -2915,456 +5540,455 @@ static void decompress_metric(int offset, struct =
pmu_metric *pm)
 }
=20
 static int pmu_events_table__for_each_event_pmu(const struct pmu_events_ta=
ble *table,
-                                                const struct pmu_table_ent=
ry *pmu,
-                                                pmu_event_iter_fn fn,
-                                                void *data)
+						const struct pmu_table_entry *pmu,
+						pmu_event_iter_fn fn,
+						void *data)
 {
-        int ret;
-        struct pmu_event pe =3D {
-                .pmu =3D &big_c_string[pmu->pmu_name.offset],
-        };
-
-        for (uint32_t i =3D 0; i < pmu->num_entries; i++) {
-                decompress_event(pmu->entries[i].offset, &pe);
-                if (!pe.name)
-                        continue;
-                ret =3D fn(&pe, table, data);
-                if (ret)
-                        return ret;
-        }
-        return 0;
+	int ret;
+	struct pmu_event pe =3D {
+		.pmu =3D &big_c_string[pmu->pmu_name.offset],
+	};
+
+	for (uint32_t i =3D 0; i < pmu->num_entries; i++) {
+		decompress_event(pmu->entries[i].offset, &pe);
+		if (!pe.name)
+			continue;
+		ret =3D fn(&pe, table, data);
+		if (ret)
+			return ret;
+	}
+	return 0;
  }
=20
 static int pmu_events_table__find_event_pmu(const struct pmu_events_table =
*table,
-                                            const struct pmu_table_entry *=
pmu,
-                                            const char *name,
-                                            pmu_event_iter_fn fn,
-                                            void *data)
+					    const struct pmu_table_entry *pmu,
+					    const char *name,
+					    pmu_event_iter_fn fn,
+					    void *data)
 {
-        struct pmu_event pe =3D {
-                .pmu =3D &big_c_string[pmu->pmu_name.offset],
-        };
-        int low =3D 0, high =3D pmu->num_entries - 1;
-
-        while (low <=3D high) {
-                int cmp, mid =3D (low + high) / 2;
-
-                decompress_event(pmu->entries[mid].offset, &pe);
-
-                if (!pe.name && !name)
-                        goto do_call;
-
-                if (!pe.name && name) {
-                        low =3D mid + 1;
-                        continue;
-                }
-                if (pe.name && !name) {
-                        high =3D mid - 1;
-                        continue;
-                }
-
-                cmp =3D strcasecmp(pe.name, name);
-                if (cmp < 0) {
-                        low =3D mid + 1;
-                        continue;
-                }
-                if (cmp > 0) {
-                        high =3D mid - 1;
-                        continue;
-                }
+	struct pmu_event pe =3D {
+		.pmu =3D &big_c_string[pmu->pmu_name.offset],
+	};
+	int low =3D 0, high =3D pmu->num_entries - 1;
+
+	while (low <=3D high) {
+		int cmp, mid =3D (low + high) / 2;
+
+		decompress_event(pmu->entries[mid].offset, &pe);
+
+		if (!pe.name && !name)
+			goto do_call;
+
+		if (!pe.name && name) {
+			low =3D mid + 1;
+			continue;
+		}
+		if (pe.name && !name) {
+			high =3D mid - 1;
+			continue;
+		}
+
+		cmp =3D strcasecmp(pe.name, name);
+		if (cmp < 0) {
+			low =3D mid + 1;
+			continue;
+		}
+		if (cmp > 0) {
+			high =3D mid - 1;
+			continue;
+		}
   do_call:
-                return fn ? fn(&pe, table, data) : 0;
-        }
-        return PMU_EVENTS__NOT_FOUND;
+		return fn ? fn(&pe, table, data) : 0;
+	}
+	return PMU_EVENTS__NOT_FOUND;
 }
=20
 int pmu_events_table__for_each_event(const struct pmu_events_table *table,
-                                    struct perf_pmu *pmu,
-                                    pmu_event_iter_fn fn,
-                                    void *data)
+				    struct perf_pmu *pmu,
+				    pmu_event_iter_fn fn,
+				    void *data)
 {
-        if (!table)
-                return 0;
-        for (size_t i =3D 0; i < table->num_pmus; i++) {
-                const struct pmu_table_entry *table_pmu =3D &table->pmus[i=
];
-                const char *pmu_name =3D &big_c_string[table_pmu->pmu_name=
.offset];
-                int ret;
-
-                if (pmu && !perf_pmu__name_wildcard_match(pmu, pmu_name))
-                        continue;
-
-                ret =3D pmu_events_table__for_each_event_pmu(table, table_=
pmu, fn, data);
-                if (ret)
-                        return ret;
-        }
-        return 0;
+	if (!table)
+		return 0;
+	for (size_t i =3D 0; i < table->num_pmus; i++) {
+		const struct pmu_table_entry *table_pmu =3D &table->pmus[i];
+		const char *pmu_name =3D &big_c_string[table_pmu->pmu_name.offset];
+		int ret;
+
+		if (pmu && !perf_pmu__name_wildcard_match(pmu, pmu_name))
+			continue;
+
+		ret =3D pmu_events_table__for_each_event_pmu(table, table_pmu, fn, data)=
;
+		if (ret)
+			return ret;
+	}
+	return 0;
 }
=20
 int pmu_events_table__find_event(const struct pmu_events_table *table,
-                                 struct perf_pmu *pmu,
-                                 const char *name,
-                                 pmu_event_iter_fn fn,
-                                 void *data)
+				 struct perf_pmu *pmu,
+				 const char *name,
+				 pmu_event_iter_fn fn,
+				 void *data)
 {
-        if (!table)
-                return PMU_EVENTS__NOT_FOUND;
-        for (size_t i =3D 0; i < table->num_pmus; i++) {
-                const struct pmu_table_entry *table_pmu =3D &table->pmus[i=
];
-                const char *pmu_name =3D &big_c_string[table_pmu->pmu_name=
.offset];
-                int ret;
-
-                if (pmu && !perf_pmu__name_wildcard_match(pmu, pmu_name))
-                        continue;
-
-                ret =3D pmu_events_table__find_event_pmu(table, table_pmu,=
 name, fn, data);
-                if (ret !=3D PMU_EVENTS__NOT_FOUND)
-                        return ret;
-        }
-        return PMU_EVENTS__NOT_FOUND;
+	if (!table)
+		return PMU_EVENTS__NOT_FOUND;
+	for (size_t i =3D 0; i < table->num_pmus; i++) {
+		const struct pmu_table_entry *table_pmu =3D &table->pmus[i];
+		const char *pmu_name =3D &big_c_string[table_pmu->pmu_name.offset];
+		int ret;
+
+		if (pmu && !perf_pmu__name_wildcard_match(pmu, pmu_name))
+			continue;
+
+		ret =3D pmu_events_table__find_event_pmu(table, table_pmu, name, fn, dat=
a);
+		if (ret !=3D PMU_EVENTS__NOT_FOUND)
+			return ret;
+	}
+	return PMU_EVENTS__NOT_FOUND;
 }
=20
-size_t pmu_events_table__num_events(const struct pmu_events_table *table,
-                                    struct perf_pmu *pmu)
+size_t pmu_events_table__num_events(const struct pmu_events_table *table, =
struct perf_pmu *pmu)
 {
-        size_t count =3D 0;
-
-        if (!table)
-                return 0;
-        for (size_t i =3D 0; i < table->num_pmus; i++) {
-                const struct pmu_table_entry *table_pmu =3D &table->pmus[i=
];
-                const char *pmu_name =3D &big_c_string[table_pmu->pmu_name=
.offset];
-
-                if (perf_pmu__name_wildcard_match(pmu, pmu_name))
-                        count +=3D table_pmu->num_entries;
-        }
-        return count;
+	size_t count =3D 0;
+
+	if (!table)
+		return 0;
+	for (size_t i =3D 0; i < table->num_pmus; i++) {
+		const struct pmu_table_entry *table_pmu =3D &table->pmus[i];
+		const char *pmu_name =3D &big_c_string[table_pmu->pmu_name.offset];
+
+		if (perf_pmu__name_wildcard_match(pmu, pmu_name))
+			count +=3D table_pmu->num_entries;
+	}
+	return count;
 }
=20
 static int pmu_metrics_table__for_each_metric_pmu(const struct pmu_metrics=
_table *table,
-                                                const struct pmu_table_ent=
ry *pmu,
-                                                pmu_metric_iter_fn fn,
-                                                void *data)
+						const struct pmu_table_entry *pmu,
+						pmu_metric_iter_fn fn,
+						void *data)
 {
-        int ret;
-        struct pmu_metric pm =3D {
-                .pmu =3D &big_c_string[pmu->pmu_name.offset],
-        };
-
-        for (uint32_t i =3D 0; i < pmu->num_entries; i++) {
-                decompress_metric(pmu->entries[i].offset, &pm);
-                if (!pm.metric_expr)
-                        continue;
-                ret =3D fn(&pm, table, data);
-                if (ret)
-                        return ret;
-        }
-        return 0;
+	int ret;
+	struct pmu_metric pm =3D {
+		.pmu =3D &big_c_string[pmu->pmu_name.offset],
+	};
+
+	for (uint32_t i =3D 0; i < pmu->num_entries; i++) {
+		decompress_metric(pmu->entries[i].offset, &pm);
+		if (!pm.metric_expr)
+			continue;
+		ret =3D fn(&pm, table, data);
+		if (ret)
+			return ret;
+	}
+	return 0;
 }
=20
 static int pmu_metrics_table__find_metric_pmu(const struct pmu_metrics_tab=
le *table,
-                                            const struct pmu_table_entry *=
pmu,
-                                            const char *metric,
-                                            pmu_metric_iter_fn fn,
-                                            void *data)
+					    const struct pmu_table_entry *pmu,
+					    const char *metric,
+					    pmu_metric_iter_fn fn,
+					    void *data)
 {
-        struct pmu_metric pm =3D {
-                .pmu =3D &big_c_string[pmu->pmu_name.offset],
-        };
-        int low =3D 0, high =3D pmu->num_entries - 1;
-
-        while (low <=3D high) {
-                int cmp, mid =3D (low + high) / 2;
-
-                decompress_metric(pmu->entries[mid].offset, &pm);
-
-                if (!pm.metric_name && !metric)
-                        goto do_call;
-
-                if (!pm.metric_name && metric) {
-                        low =3D mid + 1;
-                        continue;
-                }
-                if (pm.metric_name && !metric) {
-                        high =3D mid - 1;
-                        continue;
-                }
-
-                cmp =3D strcmp(pm.metric_name, metric);
-                if (cmp < 0) {
-                        low =3D mid + 1;
-                        continue;
-                }
-                if (cmp > 0) {
-                        high =3D mid - 1;
-                        continue;
-                }
+	struct pmu_metric pm =3D {
+		.pmu =3D &big_c_string[pmu->pmu_name.offset],
+	};
+	int low =3D 0, high =3D pmu->num_entries - 1;
+
+	while (low <=3D high) {
+		int cmp, mid =3D (low + high) / 2;
+
+		decompress_metric(pmu->entries[mid].offset, &pm);
+
+		if (!pm.metric_name && !metric)
+			goto do_call;
+
+		if (!pm.metric_name && metric) {
+			low =3D mid + 1;
+			continue;
+		}
+		if (pm.metric_name && !metric) {
+			high =3D mid - 1;
+			continue;
+		}
+
+		cmp =3D strcmp(pm.metric_name, metric);
+		if (cmp < 0) {
+			low =3D mid + 1;
+			continue;
+		}
+		if (cmp > 0) {
+			high =3D mid - 1;
+			continue;
+		}
   do_call:
-                return fn ? fn(&pm, table, data) : 0;
-        }
-        return PMU_METRICS__NOT_FOUND;
+		return fn ? fn(&pm, table, data) : 0;
+	}
+	return PMU_METRICS__NOT_FOUND;
 }
=20
 int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *tab=
le,
-                                     pmu_metric_iter_fn fn,
-                                     void *data)
+				     pmu_metric_iter_fn fn,
+				     void *data)
 {
-        if (!table)
-                return 0;
-        for (size_t i =3D 0; i < table->num_pmus; i++) {
-                int ret =3D pmu_metrics_table__for_each_metric_pmu(table, =
&table->pmus[i],
-                                                                 fn, data)=
;
-
-                if (ret)
-                        return ret;
-        }
-        return 0;
+	if (!table)
+		return 0;
+	for (size_t i =3D 0; i < table->num_pmus; i++) {
+		int ret =3D pmu_metrics_table__for_each_metric_pmu(table, &table->pmus[i=
], fn, data);
+
+		if (ret)
+			return ret;
+	}
+	return 0;
 }
=20
 int pmu_metrics_table__find_metric(const struct pmu_metrics_table *table,
-                                 struct perf_pmu *pmu,
-                                 const char *metric,
-                                 pmu_metric_iter_fn fn,
-                                 void *data)
+				 struct perf_pmu *pmu,
+				 const char *metric,
+				 pmu_metric_iter_fn fn,
+				 void *data)
 {
-        if (!table)
-                return 0;
-        for (size_t i =3D 0; i < table->num_pmus; i++) {
-                const struct pmu_table_entry *table_pmu =3D &table->pmus[i=
];
-                const char *pmu_name =3D &big_c_string[table_pmu->pmu_name=
.offset];
-                int ret;
-
-                if (pmu && !perf_pmu__name_wildcard_match(pmu, pmu_name))
-                        continue;
-
-                ret =3D pmu_metrics_table__find_metric_pmu(table, table_pm=
u, metric, fn, data);
-                if (ret !=3D PMU_METRICS__NOT_FOUND)
-                        return ret;
-        }
-        return PMU_METRICS__NOT_FOUND;
+	if (!table)
+		return 0;
+	for (size_t i =3D 0; i < table->num_pmus; i++) {
+		const struct pmu_table_entry *table_pmu =3D &table->pmus[i];
+		const char *pmu_name =3D &big_c_string[table_pmu->pmu_name.offset];
+		int ret;
+
+		if (pmu && !perf_pmu__name_wildcard_match(pmu, pmu_name))
+			continue;
+
+		ret =3D pmu_metrics_table__find_metric_pmu(table, table_pmu, metric, fn,=
 data);
+		if (ret !=3D PMU_METRICS__NOT_FOUND)
+			return ret;
+	}
+	return PMU_METRICS__NOT_FOUND;
 }
=20
 static const struct pmu_events_map *map_for_cpu(struct perf_cpu cpu)
 {
-        static struct {
-                const struct pmu_events_map *map;
-                struct perf_cpu cpu;
-        } last_result;
-        static struct {
-                const struct pmu_events_map *map;
-                char *cpuid;
-        } last_map_search;
-        static bool has_last_result, has_last_map_search;
-        const struct pmu_events_map *map =3D NULL;
-        char *cpuid =3D NULL;
-        size_t i;
-
-        if (has_last_result && last_result.cpu.cpu =3D=3D cpu.cpu)
-                return last_result.map;
-
-        cpuid =3D get_cpuid_allow_env_override(cpu);
-
-        /*
-         * On some platforms which uses cpus map, cpuid can be NULL for
-         * PMUs other than CORE PMUs.
-         */
-        if (!cpuid)
-                goto out_update_last_result;
-
-        if (has_last_map_search && !strcmp(last_map_search.cpuid, cpuid)) =
{
-                map =3D last_map_search.map;
-                free(cpuid);
-        } else {
-                i =3D 0;
-                for (;;) {
-                        map =3D &pmu_events_map[i++];
-
-                        if (!map->arch) {
-                                map =3D NULL;
-                                break;
-                        }
-
-                        if (!strcmp_cpuid_str(map->cpuid, cpuid))
-                                break;
-               }
-               free(last_map_search.cpuid);
-               last_map_search.cpuid =3D cpuid;
-               last_map_search.map =3D map;
-               has_last_map_search =3D true;
-        }
+	static struct {
+		const struct pmu_events_map *map;
+		struct perf_cpu cpu;
+	} last_result;
+	static struct {
+		const struct pmu_events_map *map;
+		char *cpuid;
+	} last_map_search;
+	static bool has_last_result, has_last_map_search;
+	const struct pmu_events_map *map =3D NULL;
+	char *cpuid =3D NULL;
+	size_t i;
+
+	if (has_last_result && last_result.cpu.cpu =3D=3D cpu.cpu)
+		return last_result.map;
+
+	cpuid =3D get_cpuid_allow_env_override(cpu);
+
+	/*
+	 * On some platforms which uses cpus map, cpuid can be NULL for
+	 * PMUs other than CORE PMUs.
+	 */
+	if (!cpuid)
+		goto out_update_last_result;
+
+	if (has_last_map_search && !strcmp(last_map_search.cpuid, cpuid)) {
+		map =3D last_map_search.map;
+		free(cpuid);
+	} else {
+		i =3D 0;
+		for (;;) {
+			map =3D &pmu_events_map[i++];
+
+			if (!map->arch) {
+				map =3D NULL;
+				break;
+			}
+
+			if (!strcmp_cpuid_str(map->cpuid, cpuid))
+				break;
+		}
+		free(last_map_search.cpuid);
+		last_map_search.cpuid =3D cpuid;
+		last_map_search.map =3D map;
+		has_last_map_search =3D true;
+	}
 out_update_last_result:
-        last_result.cpu =3D cpu;
-        last_result.map =3D map;
-        has_last_result =3D true;
-        return map;
+	last_result.cpu =3D cpu;
+	last_result.map =3D map;
+	has_last_result =3D true;
+	return map;
 }
=20
 static const struct pmu_events_map *map_for_pmu(struct perf_pmu *pmu)
 {
-        struct perf_cpu cpu =3D {-1};
-
-        if (pmu) {
-                for (size_t i =3D 0; i < ARRAY_SIZE(pmu_events__common); i=
++) {
-                        const char *pmu_name =3D &big_c_string[pmu_events_=
_common[i].pmu_name.offset];
-
-                        if (!strcmp(pmu_name, pmu->name)) {
-                                const struct pmu_events_map *map =3D &pmu_=
events_map[0];
-
-                                while (strcmp("common", map->arch))
-                                        map++;
-                                return map;
-                        }
-                }
-                cpu =3D perf_cpu_map__min(pmu->cpus);
-        }
-        return map_for_cpu(cpu);
+	struct perf_cpu cpu =3D { -1 };
+
+	if (pmu) {
+		for (size_t i =3D 0; i < ARRAY_SIZE(pmu_events__common); i++) {
+			const char *pmu_name =3D &big_c_string[pmu_events__common[i].pmu_name.o=
ffset];
+
+			if (!strcmp(pmu_name, pmu->name)) {
+				const struct pmu_events_map *map =3D &pmu_events_map[0];
+
+				while (strcmp("common", map->arch))
+					map++;
+				return map;
+			}
+		}
+		cpu =3D perf_cpu_map__min(pmu->cpus);
+	}
+	return map_for_cpu(cpu);
 }
=20
 const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu=
 *pmu)
 {
-        const struct pmu_events_map *map =3D map_for_pmu(pmu);
+	const struct pmu_events_map *map =3D map_for_pmu(pmu);
=20
-        if (!map)
-                return NULL;
+	if (!map)
+		return NULL;
=20
-        if (!pmu)
-                return &map->event_table;
+	if (!pmu)
+		return &map->event_table;
=20
-        for (size_t i =3D 0; i < map->event_table.num_pmus; i++) {
-                const struct pmu_table_entry *table_pmu =3D &map->event_ta=
ble.pmus[i];
-                const char *pmu_name =3D &big_c_string[table_pmu->pmu_name=
.offset];
+	for (size_t i =3D 0; i < map->event_table.num_pmus; i++) {
+		const struct pmu_table_entry *table_pmu =3D &map->event_table.pmus[i];
+		const char *pmu_name =3D &big_c_string[table_pmu->pmu_name.offset];
=20
-                if (perf_pmu__name_wildcard_match(pmu, pmu_name))
-                         return &map->event_table;
-        }
-        return NULL;
+		if (perf_pmu__name_wildcard_match(pmu, pmu_name))
+			return &map->event_table;
+	}
+	return NULL;
 }
=20
 const struct pmu_events_table *perf_pmu__default_core_events_table(void)
 {
-        int i =3D 0;
+	int i =3D 0;
=20
-        for (;;) {
-                const struct pmu_events_map *map =3D &pmu_events_map[i++];
+	for (;;) {
+		const struct pmu_events_map *map =3D &pmu_events_map[i++];
=20
-                if (!map->arch)
-                        break;
+		if (!map->arch)
+			break;
=20
-                if (!strcmp(map->cpuid, "common"))
-                        return &map->event_table;
-        }
-        return NULL;
+		if (!strcmp(map->cpuid, "common"))
+			return &map->event_table;
+	}
+	return NULL;
 }
=20
 const struct pmu_metrics_table *pmu_metrics_table__find(void)
 {
-        struct perf_cpu cpu =3D {-1};
-        const struct pmu_events_map *map =3D map_for_cpu(cpu);
+	struct perf_cpu cpu =3D { -1 };
+	const struct pmu_events_map *map =3D map_for_cpu(cpu);
=20
-        return map ? &map->metric_table : NULL;
+	return map ? &map->metric_table : NULL;
 }
=20
 const struct pmu_metrics_table *pmu_metrics_table__default(void)
 {
-        int i =3D 0;
+	int i =3D 0;
=20
-        for (;;) {
-                const struct pmu_events_map *map =3D &pmu_events_map[i++];
+	for (;;) {
+		const struct pmu_events_map *map =3D &pmu_events_map[i++];
=20
-                if (!map->arch)
-                        break;
+		if (!map->arch)
+			break;
=20
-                if (!strcmp(map->cpuid, "common"))
-                        return &map->metric_table;
-        }
-        return NULL;
+		if (!strcmp(map->cpuid, "common"))
+			return &map->metric_table;
+	}
+	return NULL;
 }
=20
 const struct pmu_events_table *find_core_events_table(const char *arch, co=
nst char *cpuid)
 {
-        for (const struct pmu_events_map *tables =3D &pmu_events_map[0];
-             tables->arch;
-             tables++) {
-                if (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(table=
s->cpuid, cpuid))
-                        return &tables->event_table;
-        }
-        return NULL;
+	for (const struct pmu_events_map *tables =3D &pmu_events_map[0];
+	     tables->arch;
+	     tables++) {
+		if (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(tables->cpuid, cpui=
d))
+			return &tables->event_table;
+	}
+	return NULL;
 }
=20
 const struct pmu_metrics_table *find_core_metrics_table(const char *arch, =
const char *cpuid)
 {
-        for (const struct pmu_events_map *tables =3D &pmu_events_map[0];
-             tables->arch;
-             tables++) {
-                if (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(table=
s->cpuid, cpuid))
-                        return &tables->metric_table;
-        }
-        return NULL;
+	for (const struct pmu_events_map *tables =3D &pmu_events_map[0];
+	     tables->arch;
+	     tables++) {
+		if (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(tables->cpuid, cpui=
d))
+			return &tables->metric_table;
+	}
+	return NULL;
 }
=20
 int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data)
 {
-        for (const struct pmu_events_map *tables =3D &pmu_events_map[0];
-             tables->arch;
-             tables++) {
-                int ret =3D pmu_events_table__for_each_event(&tables->even=
t_table,
-                                                           /*pmu=3D*/ NULL=
, fn, data);
-
-                if (ret)
-                        return ret;
-        }
-        return 0;
+	for (const struct pmu_events_map *tables =3D &pmu_events_map[0];
+	     tables->arch;
+	     tables++) {
+		int ret =3D pmu_events_table__for_each_event(&tables->event_table,
+							   /*pmu=3D*/NULL, fn, data);
+
+		if (ret)
+			return ret;
+	}
+	return 0;
 }
=20
 int pmu_for_each_core_metric(pmu_metric_iter_fn fn, void *data)
 {
-        for (const struct pmu_events_map *tables =3D &pmu_events_map[0];
-             tables->arch;
-             tables++) {
-                int ret =3D pmu_metrics_table__for_each_metric(&tables->me=
tric_table, fn, data);
-
-                if (ret)
-                        return ret;
-        }
-        return 0;
+	for (const struct pmu_events_map *tables =3D &pmu_events_map[0];
+	     tables->arch;
+	     tables++) {
+		int ret =3D pmu_metrics_table__for_each_metric(&tables->metric_table, fn=
, data);
+
+		if (ret)
+			return ret;
+	}
+	return 0;
 }
=20
 const struct pmu_events_table *find_sys_events_table(const char *name)
 {
-        for (const struct pmu_sys_events *tables =3D &pmu_sys_event_tables=
[0];
-             tables->name;
-             tables++) {
-                if (!strcmp(tables->name, name))
-                        return &tables->event_table;
-        }
-        return NULL;
+	for (const struct pmu_sys_events *tables =3D &pmu_sys_event_tables[0];
+	     tables->name;
+	     tables++) {
+		if (!strcmp(tables->name, name))
+			return &tables->event_table;
+	}
+	return NULL;
 }
=20
 int pmu_for_each_sys_event(pmu_event_iter_fn fn, void *data)
 {
-        for (const struct pmu_sys_events *tables =3D &pmu_sys_event_tables=
[0];
-             tables->name;
-             tables++) {
-                int ret =3D pmu_events_table__for_each_event(&tables->even=
t_table,
-                                                           /*pmu=3D*/ NULL=
, fn, data);
-
-                if (ret)
-                        return ret;
-        }
-        return 0;
+	for (const struct pmu_sys_events *tables =3D &pmu_sys_event_tables[0];
+	     tables->name;
+	     tables++) {
+		int ret =3D pmu_events_table__for_each_event(&tables->event_table,
+							   /*pmu=3D*/NULL, fn, data);
+
+		if (ret)
+			return ret;
+	}
+	return 0;
 }
=20
 int pmu_for_each_sys_metric(pmu_metric_iter_fn fn, void *data)
 {
-        for (const struct pmu_sys_events *tables =3D &pmu_sys_event_tables=
[0];
-             tables->name;
-             tables++) {
-                int ret =3D pmu_metrics_table__for_each_metric(&tables->me=
tric_table, fn, data);
-
-                if (ret)
-                        return ret;
-        }
-        return 0;
+	for (const struct pmu_sys_events *tables =3D &pmu_sys_event_tables[0];
+	     tables->name;
+	     tables++) {
+		int ret =3D pmu_metrics_table__for_each_metric(&tables->metric_table, fn=
, data);
+
+		if (ret)
+			return ret;
+	}
+	return 0;
 }
+/* clang-format on */
=20
 static const int metricgroups[][2] =3D {
=20
@@ -3372,20 +5996,19 @@ static const int metricgroups[][2] =3D {
=20
 const char *describe_metricgroup(const char *group)
 {
-        int low =3D 0, high =3D (int)ARRAY_SIZE(metricgroups) - 1;
-
-        while (low <=3D high) {
-                int mid =3D (low + high) / 2;
-                const char *mgroup =3D &big_c_string[metricgroups[mid][0]]=
;
-                int cmp =3D strcmp(mgroup, group);
-
-                if (cmp =3D=3D 0) {
-                        return &big_c_string[metricgroups[mid][1]];
-                } else if (cmp < 0) {
-                        low =3D mid + 1;
-                } else {
-                        high =3D mid - 1;
-                }
-        }
-        return NULL;
+	int low =3D 0, high =3D (int)ARRAY_SIZE(metricgroups) - 1;
+
+	while (low <=3D high) {
+		int mid =3D (low + high) / 2;
+		const char *mgroup =3D &big_c_string[metricgroups[mid][0]];
+		int cmp =3D strcmp(mgroup, group);
+
+		if (cmp =3D=3D 0)
+			return &big_c_string[metricgroups[mid][1]];
+		else if (cmp < 0)
+			low =3D mid + 1;
+		else
+			high =3D mid - 1;
+	}
+	return NULL;
 }
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jeven=
ts.py
index 7344940e776a..6f80f937f9f9 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -183,7 +183,7 @@ class BigCString:
     for s in sorted(self.strings, key=3Dstring_cmp_key):
       if s not in folded_strings:
         self.offsets[s] =3D big_string_offset
-        self.big_string.append(f'/* offset=3D{big_string_offset} */ "')
+        self.big_string.append(f'/* offset=3D{big_string_offset} */\n"')
         self.big_string.append(s)
         self.big_string.append('"')
         if s in fold_into_strings:
@@ -450,11 +450,12 @@ class JsonEvent:
   def to_c_string(self, metric: bool) -> str:
     """Representation of the event as a C struct initializer."""
=20
-    def fix_comment(s: str) -> str:
-        return s.replace('*/', r'\*\/')
+    def make_comment(s: str) -> str:
+        s =3D s.replace('*/', r'\*\/')
+        return f'\t/* {s} */\n' if len(s) < 80 else f'\t/* {s[0:80]}... */=
\n'
=20
     s =3D self.build_c_string(metric)
-    return f'{{ { _bcs.offsets[s] } }}, /* {fix_comment(s)} */\n'
+    return f'{make_comment(s)}\t{{ { _bcs.offsets[s] } }},\n'
=20
=20
 @lru_cache(maxsize=3DNone)
@@ -558,11 +559,11 @@ static const struct pmu_table_entry {_pending_events_=
tblname}[] =3D {{
 """)
   for (pmu, tbl_pmu) in sorted(pmus):
     pmu_name =3D f"{pmu}\\000"
-    _args.output_file.write(f"""{{
-     .entries =3D {_pending_events_tblname}_{tbl_pmu},
-     .num_entries =3D ARRAY_SIZE({_pending_events_tblname}_{tbl_pmu}),
-     .pmu_name =3D {{ {_bcs.offsets[pmu_name]} /* {pmu_name} */ }},
-}},
+    _args.output_file.write(f"""\t{{
+\t\t.entries =3D {_pending_events_tblname}_{tbl_pmu},
+\t\t.num_entries =3D ARRAY_SIZE({_pending_events_tblname}_{tbl_pmu}),
+\t\t.pmu_name =3D {{ {_bcs.offsets[pmu_name]} /* {pmu_name} */ }},
+\t}},
 """)
   _args.output_file.write('};\n\n')
=20
@@ -613,11 +614,11 @@ static const struct pmu_table_entry {_pending_metrics=
_tblname}[] =3D {{
 """)
   for (pmu, tbl_pmu) in sorted(pmus):
     pmu_name =3D f"{pmu}\\000"
-    _args.output_file.write(f"""{{
-     .entries =3D {_pending_metrics_tblname}_{tbl_pmu},
-     .num_entries =3D ARRAY_SIZE({_pending_metrics_tblname}_{tbl_pmu}),
-     .pmu_name =3D {{ {_bcs.offsets[pmu_name]} /* {pmu_name} */ }},
-}},
+    _args.output_file.write(f"""\t{{
+\t\t.entries =3D {_pending_metrics_tblname}_{tbl_pmu},
+\t\t.num_entries =3D ARRAY_SIZE({_pending_metrics_tblname}_{tbl_pmu}),
+\t\t.pmu_name =3D {{ {_bcs.offsets[pmu_name]} /* {pmu_name} */ }},
+\t}},
 """)
   _args.output_file.write('};\n\n')
=20
@@ -705,14 +706,14 @@ def print_mapping_table(archs: Sequence[str]) -> None=
:
   _args.output_file.write("""
 /* Struct used to make the PMU event table implementation opaque to caller=
s. */
 struct pmu_events_table {
-        const struct pmu_table_entry *pmus;
-        uint32_t num_pmus;
+\tconst struct pmu_table_entry *pmus;
+\tuint32_t num_pmus;
 };
=20
 /* Struct used to make the PMU metric table implementation opaque to calle=
rs. */
 struct pmu_metrics_table {
-        const struct pmu_table_entry *pmus;
-        uint32_t num_pmus;
+\tconst struct pmu_table_entry *pmus;
+\tuint32_t num_pmus;
 };
=20
 /*
@@ -724,10 +725,10 @@ struct pmu_metrics_table {
  * The  cpuid can contain any character other than the comma.
  */
 struct pmu_events_map {
-        const char *arch;
-        const char *cpuid;
-        struct pmu_events_table event_table;
-        struct pmu_metrics_table metric_table;
+\tconst char *arch;
+\tconst char *cpuid;
+\tstruct pmu_events_table event_table;
+\tstruct pmu_metrics_table metric_table;
 };
=20
 /*
@@ -896,455 +897,453 @@ static void decompress_metric(int offset, struct pm=
u_metric *pm)
   _args.output_file.write("""}
=20
 static int pmu_events_table__for_each_event_pmu(const struct pmu_events_ta=
ble *table,
-                                                const struct pmu_table_ent=
ry *pmu,
-                                                pmu_event_iter_fn fn,
-                                                void *data)
+\t\t\t\t\t\tconst struct pmu_table_entry *pmu,
+\t\t\t\t\t\tpmu_event_iter_fn fn,
+\t\t\t\t\t\tvoid *data)
 {
-        int ret;
-        struct pmu_event pe =3D {
-                .pmu =3D &big_c_string[pmu->pmu_name.offset],
-        };
-
-        for (uint32_t i =3D 0; i < pmu->num_entries; i++) {
-                decompress_event(pmu->entries[i].offset, &pe);
-                if (!pe.name)
-                        continue;
-                ret =3D fn(&pe, table, data);
-                if (ret)
-                        return ret;
-        }
-        return 0;
+\tint ret;
+\tstruct pmu_event pe =3D {
+\t\t.pmu =3D &big_c_string[pmu->pmu_name.offset],
+\t};
+
+\tfor (uint32_t i =3D 0; i < pmu->num_entries; i++) {
+\t\tdecompress_event(pmu->entries[i].offset, &pe);
+\t\tif (!pe.name)
+\t\t\tcontinue;
+\t\tret =3D fn(&pe, table, data);
+\t\tif (ret)
+\t\t\treturn ret;
+\t}
+\treturn 0;
  }
=20
 static int pmu_events_table__find_event_pmu(const struct pmu_events_table =
*table,
-                                            const struct pmu_table_entry *=
pmu,
-                                            const char *name,
-                                            pmu_event_iter_fn fn,
-                                            void *data)
+\t\t\t\t\t    const struct pmu_table_entry *pmu,
+\t\t\t\t\t    const char *name,
+\t\t\t\t\t    pmu_event_iter_fn fn,
+\t\t\t\t\t    void *data)
 {
-        struct pmu_event pe =3D {
-                .pmu =3D &big_c_string[pmu->pmu_name.offset],
-        };
-        int low =3D 0, high =3D pmu->num_entries - 1;
-
-        while (low <=3D high) {
-                int cmp, mid =3D (low + high) / 2;
-
-                decompress_event(pmu->entries[mid].offset, &pe);
-
-                if (!pe.name && !name)
-                        goto do_call;
-
-                if (!pe.name && name) {
-                        low =3D mid + 1;
-                        continue;
-                }
-                if (pe.name && !name) {
-                        high =3D mid - 1;
-                        continue;
-                }
-
-                cmp =3D strcasecmp(pe.name, name);
-                if (cmp < 0) {
-                        low =3D mid + 1;
-                        continue;
-                }
-                if (cmp > 0) {
-                        high =3D mid - 1;
-                        continue;
-                }
+\tstruct pmu_event pe =3D {
+\t\t.pmu =3D &big_c_string[pmu->pmu_name.offset],
+\t};
+\tint low =3D 0, high =3D pmu->num_entries - 1;
+
+\twhile (low <=3D high) {
+\t\tint cmp, mid =3D (low + high) / 2;
+
+\t\tdecompress_event(pmu->entries[mid].offset, &pe);
+
+\t\tif (!pe.name && !name)
+\t\t\tgoto do_call;
+
+\t\tif (!pe.name && name) {
+\t\t\tlow =3D mid + 1;
+\t\t\tcontinue;
+\t\t}
+\t\tif (pe.name && !name) {
+\t\t\thigh =3D mid - 1;
+\t\t\tcontinue;
+\t\t}
+
+\t\tcmp =3D strcasecmp(pe.name, name);
+\t\tif (cmp < 0) {
+\t\t\tlow =3D mid + 1;
+\t\t\tcontinue;
+\t\t}
+\t\tif (cmp > 0) {
+\t\t\thigh =3D mid - 1;
+\t\t\tcontinue;
+\t\t}
   do_call:
-                return fn ? fn(&pe, table, data) : 0;
-        }
-        return PMU_EVENTS__NOT_FOUND;
+\t\treturn fn ? fn(&pe, table, data) : 0;
+\t}
+\treturn PMU_EVENTS__NOT_FOUND;
 }
=20
 int pmu_events_table__for_each_event(const struct pmu_events_table *table,
-                                    struct perf_pmu *pmu,
-                                    pmu_event_iter_fn fn,
-                                    void *data)
+\t\t\t\t    struct perf_pmu *pmu,
+\t\t\t\t    pmu_event_iter_fn fn,
+\t\t\t\t    void *data)
 {
-        if (!table)
-                return 0;
-        for (size_t i =3D 0; i < table->num_pmus; i++) {
-                const struct pmu_table_entry *table_pmu =3D &table->pmus[i=
];
-                const char *pmu_name =3D &big_c_string[table_pmu->pmu_name=
.offset];
-                int ret;
-
-                if (pmu && !perf_pmu__name_wildcard_match(pmu, pmu_name))
-                        continue;
-
-                ret =3D pmu_events_table__for_each_event_pmu(table, table_=
pmu, fn, data);
-                if (ret)
-                        return ret;
-        }
-        return 0;
+\tif (!table)
+\t\treturn 0;
+\tfor (size_t i =3D 0; i < table->num_pmus; i++) {
+\t\tconst struct pmu_table_entry *table_pmu =3D &table->pmus[i];
+\t\tconst char *pmu_name =3D &big_c_string[table_pmu->pmu_name.offset];
+\t\tint ret;
+
+\t\tif (pmu && !perf_pmu__name_wildcard_match(pmu, pmu_name))
+\t\t\tcontinue;
+
+\t\tret =3D pmu_events_table__for_each_event_pmu(table, table_pmu, fn, dat=
a);
+\t\tif (ret)
+\t\t\treturn ret;
+\t}
+\treturn 0;
 }
=20
 int pmu_events_table__find_event(const struct pmu_events_table *table,
-                                 struct perf_pmu *pmu,
-                                 const char *name,
-                                 pmu_event_iter_fn fn,
-                                 void *data)
+\t\t\t\t struct perf_pmu *pmu,
+\t\t\t\t const char *name,
+\t\t\t\t pmu_event_iter_fn fn,
+\t\t\t\t void *data)
 {
-        if (!table)
-                return PMU_EVENTS__NOT_FOUND;
-        for (size_t i =3D 0; i < table->num_pmus; i++) {
-                const struct pmu_table_entry *table_pmu =3D &table->pmus[i=
];
-                const char *pmu_name =3D &big_c_string[table_pmu->pmu_name=
.offset];
-                int ret;
-
-                if (pmu && !perf_pmu__name_wildcard_match(pmu, pmu_name))
-                        continue;
-
-                ret =3D pmu_events_table__find_event_pmu(table, table_pmu,=
 name, fn, data);
-                if (ret !=3D PMU_EVENTS__NOT_FOUND)
-                        return ret;
-        }
-        return PMU_EVENTS__NOT_FOUND;
+\tif (!table)
+\t\treturn PMU_EVENTS__NOT_FOUND;
+\tfor (size_t i =3D 0; i < table->num_pmus; i++) {
+\t\tconst struct pmu_table_entry *table_pmu =3D &table->pmus[i];
+\t\tconst char *pmu_name =3D &big_c_string[table_pmu->pmu_name.offset];
+\t\tint ret;
+
+\t\tif (pmu && !perf_pmu__name_wildcard_match(pmu, pmu_name))
+\t\t\tcontinue;
+
+\t\tret =3D pmu_events_table__find_event_pmu(table, table_pmu, name, fn, d=
ata);
+\t\tif (ret !=3D PMU_EVENTS__NOT_FOUND)
+\t\t\treturn ret;
+\t}
+\treturn PMU_EVENTS__NOT_FOUND;
 }
=20
-size_t pmu_events_table__num_events(const struct pmu_events_table *table,
-                                    struct perf_pmu *pmu)
+size_t pmu_events_table__num_events(const struct pmu_events_table *table, =
struct perf_pmu *pmu)
 {
-        size_t count =3D 0;
-
-        if (!table)
-                return 0;
-        for (size_t i =3D 0; i < table->num_pmus; i++) {
-                const struct pmu_table_entry *table_pmu =3D &table->pmus[i=
];
-                const char *pmu_name =3D &big_c_string[table_pmu->pmu_name=
.offset];
-
-                if (perf_pmu__name_wildcard_match(pmu, pmu_name))
-                        count +=3D table_pmu->num_entries;
-        }
-        return count;
+\tsize_t count =3D 0;
+
+\tif (!table)
+\t\treturn 0;
+\tfor (size_t i =3D 0; i < table->num_pmus; i++) {
+\t\tconst struct pmu_table_entry *table_pmu =3D &table->pmus[i];
+\t\tconst char *pmu_name =3D &big_c_string[table_pmu->pmu_name.offset];
+
+\t\tif (perf_pmu__name_wildcard_match(pmu, pmu_name))
+\t\t\tcount +=3D table_pmu->num_entries;
+\t}
+\treturn count;
 }
=20
 static int pmu_metrics_table__for_each_metric_pmu(const struct pmu_metrics=
_table *table,
-                                                const struct pmu_table_ent=
ry *pmu,
-                                                pmu_metric_iter_fn fn,
-                                                void *data)
+\t\t\t\t\t\tconst struct pmu_table_entry *pmu,
+\t\t\t\t\t\tpmu_metric_iter_fn fn,
+\t\t\t\t\t\tvoid *data)
 {
-        int ret;
-        struct pmu_metric pm =3D {
-                .pmu =3D &big_c_string[pmu->pmu_name.offset],
-        };
-
-        for (uint32_t i =3D 0; i < pmu->num_entries; i++) {
-                decompress_metric(pmu->entries[i].offset, &pm);
-                if (!pm.metric_expr)
-                        continue;
-                ret =3D fn(&pm, table, data);
-                if (ret)
-                        return ret;
-        }
-        return 0;
+\tint ret;
+\tstruct pmu_metric pm =3D {
+\t\t.pmu =3D &big_c_string[pmu->pmu_name.offset],
+\t};
+
+\tfor (uint32_t i =3D 0; i < pmu->num_entries; i++) {
+\t\tdecompress_metric(pmu->entries[i].offset, &pm);
+\t\tif (!pm.metric_expr)
+\t\t\tcontinue;
+\t\tret =3D fn(&pm, table, data);
+\t\tif (ret)
+\t\t\treturn ret;
+\t}
+\treturn 0;
 }
=20
 static int pmu_metrics_table__find_metric_pmu(const struct pmu_metrics_tab=
le *table,
-                                            const struct pmu_table_entry *=
pmu,
-                                            const char *metric,
-                                            pmu_metric_iter_fn fn,
-                                            void *data)
+\t\t\t\t\t    const struct pmu_table_entry *pmu,
+\t\t\t\t\t    const char *metric,
+\t\t\t\t\t    pmu_metric_iter_fn fn,
+\t\t\t\t\t    void *data)
 {
-        struct pmu_metric pm =3D {
-                .pmu =3D &big_c_string[pmu->pmu_name.offset],
-        };
-        int low =3D 0, high =3D pmu->num_entries - 1;
-
-        while (low <=3D high) {
-                int cmp, mid =3D (low + high) / 2;
-
-                decompress_metric(pmu->entries[mid].offset, &pm);
-
-                if (!pm.metric_name && !metric)
-                        goto do_call;
-
-                if (!pm.metric_name && metric) {
-                        low =3D mid + 1;
-                        continue;
-                }
-                if (pm.metric_name && !metric) {
-                        high =3D mid - 1;
-                        continue;
-                }
-
-                cmp =3D strcmp(pm.metric_name, metric);
-                if (cmp < 0) {
-                        low =3D mid + 1;
-                        continue;
-                }
-                if (cmp > 0) {
-                        high =3D mid - 1;
-                        continue;
-                }
+\tstruct pmu_metric pm =3D {
+\t\t.pmu =3D &big_c_string[pmu->pmu_name.offset],
+\t};
+\tint low =3D 0, high =3D pmu->num_entries - 1;
+
+\twhile (low <=3D high) {
+\t\tint cmp, mid =3D (low + high) / 2;
+
+\t\tdecompress_metric(pmu->entries[mid].offset, &pm);
+
+\t\tif (!pm.metric_name && !metric)
+\t\t\tgoto do_call;
+
+\t\tif (!pm.metric_name && metric) {
+\t\t\tlow =3D mid + 1;
+\t\t\tcontinue;
+\t\t}
+\t\tif (pm.metric_name && !metric) {
+\t\t\thigh =3D mid - 1;
+\t\t\tcontinue;
+\t\t}
+
+\t\tcmp =3D strcmp(pm.metric_name, metric);
+\t\tif (cmp < 0) {
+\t\t\tlow =3D mid + 1;
+\t\t\tcontinue;
+\t\t}
+\t\tif (cmp > 0) {
+\t\t\thigh =3D mid - 1;
+\t\t\tcontinue;
+\t\t}
   do_call:
-                return fn ? fn(&pm, table, data) : 0;
-        }
-        return PMU_METRICS__NOT_FOUND;
+\t\treturn fn ? fn(&pm, table, data) : 0;
+\t}
+\treturn PMU_METRICS__NOT_FOUND;
 }
=20
 int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *tab=
le,
-                                     pmu_metric_iter_fn fn,
-                                     void *data)
+\t\t\t\t     pmu_metric_iter_fn fn,
+\t\t\t\t     void *data)
 {
-        if (!table)
-                return 0;
-        for (size_t i =3D 0; i < table->num_pmus; i++) {
-                int ret =3D pmu_metrics_table__for_each_metric_pmu(table, =
&table->pmus[i],
-                                                                 fn, data)=
;
-
-                if (ret)
-                        return ret;
-        }
-        return 0;
+\tif (!table)
+\t\treturn 0;
+\tfor (size_t i =3D 0; i < table->num_pmus; i++) {
+\t\tint ret =3D pmu_metrics_table__for_each_metric_pmu(table, &table->pmus=
[i], fn, data);
+
+\t\tif (ret)
+\t\t\treturn ret;
+\t}
+\treturn 0;
 }
=20
 int pmu_metrics_table__find_metric(const struct pmu_metrics_table *table,
-                                 struct perf_pmu *pmu,
-                                 const char *metric,
-                                 pmu_metric_iter_fn fn,
-                                 void *data)
+\t\t\t\t struct perf_pmu *pmu,
+\t\t\t\t const char *metric,
+\t\t\t\t pmu_metric_iter_fn fn,
+\t\t\t\t void *data)
 {
-        if (!table)
-                return 0;
-        for (size_t i =3D 0; i < table->num_pmus; i++) {
-                const struct pmu_table_entry *table_pmu =3D &table->pmus[i=
];
-                const char *pmu_name =3D &big_c_string[table_pmu->pmu_name=
.offset];
-                int ret;
-
-                if (pmu && !perf_pmu__name_wildcard_match(pmu, pmu_name))
-                        continue;
-
-                ret =3D pmu_metrics_table__find_metric_pmu(table, table_pm=
u, metric, fn, data);
-                if (ret !=3D PMU_METRICS__NOT_FOUND)
-                        return ret;
-        }
-        return PMU_METRICS__NOT_FOUND;
+\tif (!table)
+\t\treturn 0;
+\tfor (size_t i =3D 0; i < table->num_pmus; i++) {
+\t\tconst struct pmu_table_entry *table_pmu =3D &table->pmus[i];
+\t\tconst char *pmu_name =3D &big_c_string[table_pmu->pmu_name.offset];
+\t\tint ret;
+
+\t\tif (pmu && !perf_pmu__name_wildcard_match(pmu, pmu_name))
+\t\t\tcontinue;
+
+\t\tret =3D pmu_metrics_table__find_metric_pmu(table, table_pmu, metric, f=
n, data);
+\t\tif (ret !=3D PMU_METRICS__NOT_FOUND)
+\t\t\treturn ret;
+\t}
+\treturn PMU_METRICS__NOT_FOUND;
 }
=20
 static const struct pmu_events_map *map_for_cpu(struct perf_cpu cpu)
 {
-        static struct {
-                const struct pmu_events_map *map;
-                struct perf_cpu cpu;
-        } last_result;
-        static struct {
-                const struct pmu_events_map *map;
-                char *cpuid;
-        } last_map_search;
-        static bool has_last_result, has_last_map_search;
-        const struct pmu_events_map *map =3D NULL;
-        char *cpuid =3D NULL;
-        size_t i;
-
-        if (has_last_result && last_result.cpu.cpu =3D=3D cpu.cpu)
-                return last_result.map;
-
-        cpuid =3D get_cpuid_allow_env_override(cpu);
-
-        /*
-         * On some platforms which uses cpus map, cpuid can be NULL for
-         * PMUs other than CORE PMUs.
-         */
-        if (!cpuid)
-                goto out_update_last_result;
-
-        if (has_last_map_search && !strcmp(last_map_search.cpuid, cpuid)) =
{
-                map =3D last_map_search.map;
-                free(cpuid);
-        } else {
-                i =3D 0;
-                for (;;) {
-                        map =3D &pmu_events_map[i++];
-
-                        if (!map->arch) {
-                                map =3D NULL;
-                                break;
-                        }
-
-                        if (!strcmp_cpuid_str(map->cpuid, cpuid))
-                                break;
-               }
-               free(last_map_search.cpuid);
-               last_map_search.cpuid =3D cpuid;
-               last_map_search.map =3D map;
-               has_last_map_search =3D true;
-        }
+\tstatic struct {
+\t\tconst struct pmu_events_map *map;
+\t\tstruct perf_cpu cpu;
+\t} last_result;
+\tstatic struct {
+\t\tconst struct pmu_events_map *map;
+\t\tchar *cpuid;
+\t} last_map_search;
+\tstatic bool has_last_result, has_last_map_search;
+\tconst struct pmu_events_map *map =3D NULL;
+\tchar *cpuid =3D NULL;
+\tsize_t i;
+
+\tif (has_last_result && last_result.cpu.cpu =3D=3D cpu.cpu)
+\t\treturn last_result.map;
+
+\tcpuid =3D get_cpuid_allow_env_override(cpu);
+
+\t/*
+\t * On some platforms which uses cpus map, cpuid can be NULL for
+\t * PMUs other than CORE PMUs.
+\t */
+\tif (!cpuid)
+\t\tgoto out_update_last_result;
+
+\tif (has_last_map_search && !strcmp(last_map_search.cpuid, cpuid)) {
+\t\tmap =3D last_map_search.map;
+\t\tfree(cpuid);
+\t} else {
+\t\ti =3D 0;
+\t\tfor (;;) {
+\t\t\tmap =3D &pmu_events_map[i++];
+
+\t\t\tif (!map->arch) {
+\t\t\t\tmap =3D NULL;
+\t\t\t\tbreak;
+\t\t\t}
+
+\t\t\tif (!strcmp_cpuid_str(map->cpuid, cpuid))
+\t\t\t\tbreak;
+\t\t}
+\t\tfree(last_map_search.cpuid);
+\t\tlast_map_search.cpuid =3D cpuid;
+\t\tlast_map_search.map =3D map;
+\t\thas_last_map_search =3D true;
+\t}
 out_update_last_result:
-        last_result.cpu =3D cpu;
-        last_result.map =3D map;
-        has_last_result =3D true;
-        return map;
+\tlast_result.cpu =3D cpu;
+\tlast_result.map =3D map;
+\thas_last_result =3D true;
+\treturn map;
 }
=20
 static const struct pmu_events_map *map_for_pmu(struct perf_pmu *pmu)
 {
-        struct perf_cpu cpu =3D {-1};
-
-        if (pmu) {
-                for (size_t i =3D 0; i < ARRAY_SIZE(pmu_events__common); i=
++) {
-                        const char *pmu_name =3D &big_c_string[pmu_events_=
_common[i].pmu_name.offset];
-
-                        if (!strcmp(pmu_name, pmu->name)) {
-                                const struct pmu_events_map *map =3D &pmu_=
events_map[0];
-
-                                while (strcmp("common", map->arch))
-                                        map++;
-                                return map;
-                        }
-                }
-                cpu =3D perf_cpu_map__min(pmu->cpus);
-        }
-        return map_for_cpu(cpu);
+\tstruct perf_cpu cpu =3D { -1 };
+
+\tif (pmu) {
+\t\tfor (size_t i =3D 0; i < ARRAY_SIZE(pmu_events__common); i++) {
+\t\t\tconst char *pmu_name =3D &big_c_string[pmu_events__common[i].pmu_nam=
e.offset];
+
+\t\t\tif (!strcmp(pmu_name, pmu->name)) {
+\t\t\t\tconst struct pmu_events_map *map =3D &pmu_events_map[0];
+
+\t\t\t\twhile (strcmp("common", map->arch))
+\t\t\t\t\tmap++;
+\t\t\t\treturn map;
+\t\t\t}
+\t\t}
+\t\tcpu =3D perf_cpu_map__min(pmu->cpus);
+\t}
+\treturn map_for_cpu(cpu);
 }
=20
 const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu=
 *pmu)
 {
-        const struct pmu_events_map *map =3D map_for_pmu(pmu);
+\tconst struct pmu_events_map *map =3D map_for_pmu(pmu);
=20
-        if (!map)
-                return NULL;
+\tif (!map)
+\t\treturn NULL;
=20
-        if (!pmu)
-                return &map->event_table;
+\tif (!pmu)
+\t\treturn &map->event_table;
=20
-        for (size_t i =3D 0; i < map->event_table.num_pmus; i++) {
-                const struct pmu_table_entry *table_pmu =3D &map->event_ta=
ble.pmus[i];
-                const char *pmu_name =3D &big_c_string[table_pmu->pmu_name=
.offset];
+\tfor (size_t i =3D 0; i < map->event_table.num_pmus; i++) {
+\t\tconst struct pmu_table_entry *table_pmu =3D &map->event_table.pmus[i];
+\t\tconst char *pmu_name =3D &big_c_string[table_pmu->pmu_name.offset];
=20
-                if (perf_pmu__name_wildcard_match(pmu, pmu_name))
-                         return &map->event_table;
-        }
-        return NULL;
+\t\tif (perf_pmu__name_wildcard_match(pmu, pmu_name))
+\t\t\treturn &map->event_table;
+\t}
+\treturn NULL;
 }
=20
 const struct pmu_events_table *perf_pmu__default_core_events_table(void)
 {
-        int i =3D 0;
+\tint i =3D 0;
=20
-        for (;;) {
-                const struct pmu_events_map *map =3D &pmu_events_map[i++];
+\tfor (;;) {
+\t\tconst struct pmu_events_map *map =3D &pmu_events_map[i++];
=20
-                if (!map->arch)
-                        break;
+\t\tif (!map->arch)
+\t\t\tbreak;
=20
-                if (!strcmp(map->cpuid, "common"))
-                        return &map->event_table;
-        }
-        return NULL;
+\t\tif (!strcmp(map->cpuid, "common"))
+\t\t\treturn &map->event_table;
+\t}
+\treturn NULL;
 }
=20
 const struct pmu_metrics_table *pmu_metrics_table__find(void)
 {
-        struct perf_cpu cpu =3D {-1};
-        const struct pmu_events_map *map =3D map_for_cpu(cpu);
+\tstruct perf_cpu cpu =3D { -1 };
+\tconst struct pmu_events_map *map =3D map_for_cpu(cpu);
=20
-        return map ? &map->metric_table : NULL;
+\treturn map ? &map->metric_table : NULL;
 }
=20
 const struct pmu_metrics_table *pmu_metrics_table__default(void)
 {
-        int i =3D 0;
+\tint i =3D 0;
=20
-        for (;;) {
-                const struct pmu_events_map *map =3D &pmu_events_map[i++];
+\tfor (;;) {
+\t\tconst struct pmu_events_map *map =3D &pmu_events_map[i++];
=20
-                if (!map->arch)
-                        break;
+\t\tif (!map->arch)
+\t\t\tbreak;
=20
-                if (!strcmp(map->cpuid, "common"))
-                        return &map->metric_table;
-        }
-        return NULL;
+\t\tif (!strcmp(map->cpuid, "common"))
+\t\t\treturn &map->metric_table;
+\t}
+\treturn NULL;
 }
=20
 const struct pmu_events_table *find_core_events_table(const char *arch, co=
nst char *cpuid)
 {
-        for (const struct pmu_events_map *tables =3D &pmu_events_map[0];
-             tables->arch;
-             tables++) {
-                if (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(table=
s->cpuid, cpuid))
-                        return &tables->event_table;
-        }
-        return NULL;
+\tfor (const struct pmu_events_map *tables =3D &pmu_events_map[0];
+\t     tables->arch;
+\t     tables++) {
+\t\tif (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(tables->cpuid, cp=
uid))
+\t\t\treturn &tables->event_table;
+\t}
+\treturn NULL;
 }
=20
 const struct pmu_metrics_table *find_core_metrics_table(const char *arch, =
const char *cpuid)
 {
-        for (const struct pmu_events_map *tables =3D &pmu_events_map[0];
-             tables->arch;
-             tables++) {
-                if (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(table=
s->cpuid, cpuid))
-                        return &tables->metric_table;
-        }
-        return NULL;
+\tfor (const struct pmu_events_map *tables =3D &pmu_events_map[0];
+\t     tables->arch;
+\t     tables++) {
+\t\tif (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(tables->cpuid, cp=
uid))
+\t\t\treturn &tables->metric_table;
+\t}
+\treturn NULL;
 }
=20
 int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data)
 {
-        for (const struct pmu_events_map *tables =3D &pmu_events_map[0];
-             tables->arch;
-             tables++) {
-                int ret =3D pmu_events_table__for_each_event(&tables->even=
t_table,
-                                                           /*pmu=3D*/ NULL=
, fn, data);
-
-                if (ret)
-                        return ret;
-        }
-        return 0;
+\tfor (const struct pmu_events_map *tables =3D &pmu_events_map[0];
+\t     tables->arch;
+\t     tables++) {
+\t\tint ret =3D pmu_events_table__for_each_event(&tables->event_table,
+\t\t\t\t\t\t\t   /*pmu=3D*/NULL, fn, data);
+
+\t\tif (ret)
+\t\t\treturn ret;
+\t}
+\treturn 0;
 }
=20
 int pmu_for_each_core_metric(pmu_metric_iter_fn fn, void *data)
 {
-        for (const struct pmu_events_map *tables =3D &pmu_events_map[0];
-             tables->arch;
-             tables++) {
-                int ret =3D pmu_metrics_table__for_each_metric(&tables->me=
tric_table, fn, data);
-
-                if (ret)
-                        return ret;
-        }
-        return 0;
+\tfor (const struct pmu_events_map *tables =3D &pmu_events_map[0];
+\t     tables->arch;
+\t     tables++) {
+\t\tint ret =3D pmu_metrics_table__for_each_metric(&tables->metric_table, =
fn, data);
+
+\t\tif (ret)
+\t\t\treturn ret;
+\t}
+\treturn 0;
 }
=20
 const struct pmu_events_table *find_sys_events_table(const char *name)
 {
-        for (const struct pmu_sys_events *tables =3D &pmu_sys_event_tables=
[0];
-             tables->name;
-             tables++) {
-                if (!strcmp(tables->name, name))
-                        return &tables->event_table;
-        }
-        return NULL;
+\tfor (const struct pmu_sys_events *tables =3D &pmu_sys_event_tables[0];
+\t     tables->name;
+\t     tables++) {
+\t\tif (!strcmp(tables->name, name))
+\t\t\treturn &tables->event_table;
+\t}
+\treturn NULL;
 }
=20
 int pmu_for_each_sys_event(pmu_event_iter_fn fn, void *data)
 {
-        for (const struct pmu_sys_events *tables =3D &pmu_sys_event_tables=
[0];
-             tables->name;
-             tables++) {
-                int ret =3D pmu_events_table__for_each_event(&tables->even=
t_table,
-                                                           /*pmu=3D*/ NULL=
, fn, data);
-
-                if (ret)
-                        return ret;
-        }
-        return 0;
+\tfor (const struct pmu_sys_events *tables =3D &pmu_sys_event_tables[0];
+\t     tables->name;
+\t     tables++) {
+\t\tint ret =3D pmu_events_table__for_each_event(&tables->event_table,
+\t\t\t\t\t\t\t   /*pmu=3D*/NULL, fn, data);
+
+\t\tif (ret)
+\t\t\treturn ret;
+\t}
+\treturn 0;
 }
=20
 int pmu_for_each_sys_metric(pmu_metric_iter_fn fn, void *data)
 {
-        for (const struct pmu_sys_events *tables =3D &pmu_sys_event_tables=
[0];
-             tables->name;
-             tables++) {
-                int ret =3D pmu_metrics_table__for_each_metric(&tables->me=
tric_table, fn, data);
-
-                if (ret)
-                        return ret;
-        }
-        return 0;
+\tfor (const struct pmu_sys_events *tables =3D &pmu_sys_event_tables[0];
+\t     tables->name;
+\t     tables++) {
+\t\tint ret =3D pmu_metrics_table__for_each_metric(&tables->metric_table, =
fn, data);
+
+\t\tif (ret)
+\t\t\treturn ret;
+\t}
+\treturn 0;
 }
 """)
=20
@@ -1362,22 +1361,21 @@ static const int metricgroups[][2] =3D {
=20
 const char *describe_metricgroup(const char *group)
 {
-        int low =3D 0, high =3D (int)ARRAY_SIZE(metricgroups) - 1;
-
-        while (low <=3D high) {
-                int mid =3D (low + high) / 2;
-                const char *mgroup =3D &big_c_string[metricgroups[mid][0]]=
;
-                int cmp =3D strcmp(mgroup, group);
-
-                if (cmp =3D=3D 0) {
-                        return &big_c_string[metricgroups[mid][1]];
-                } else if (cmp < 0) {
-                        low =3D mid + 1;
-                } else {
-                        high =3D mid - 1;
-                }
-        }
-        return NULL;
+\tint low =3D 0, high =3D (int)ARRAY_SIZE(metricgroups) - 1;
+
+\twhile (low <=3D high) {
+\t\tint mid =3D (low + high) / 2;
+\t\tconst char *mgroup =3D &big_c_string[metricgroups[mid][0]];
+\t\tint cmp =3D strcmp(mgroup, group);
+
+\t\tif (cmp =3D=3D 0)
+\t\t\treturn &big_c_string[metricgroups[mid][1]];
+\t\telse if (cmp < 0)
+\t\t\tlow =3D mid + 1;
+\t\telse
+\t\t\thigh =3D mid - 1;
+\t}
+\treturn NULL;
 }
 """)
=20
@@ -1426,9 +1424,8 @@ such as "arm/cortex-a34".''',
       'output_string_file', type=3Dargparse.FileType('w', encoding=3D'utf-=
8'), nargs=3D'?', default=3DNone)
   _args =3D ap.parse_args()
=20
-  _args.output_file.write(f"""
-/* SPDX-License-Identifier: GPL-2.0 */
-/* THIS FILE WAS AUTOGENERATED BY jevents.py arch=3D{_args.arch} model=3D{=
_args.model} ! */
+  _args.output_file.write(f"""/* SPDX-License-Identifier: GPL-2.0 */
+/* THIS FILE WAS AUTOGENERATED BY `jevents.py arch=3D{_args.arch} model=3D=
{_args.model}` ! */
 """)
   _args.output_file.write("""
 #include <pmu-events/pmu-events.h>
@@ -1438,13 +1435,13 @@ such as "arm/cortex-a34".''',
 #include <stddef.h>
=20
 struct compact_pmu_event {
-        int offset;
+\tint offset;
 };
=20
 struct pmu_table_entry {
-        const struct compact_pmu_event *entries;
-        uint32_t num_entries;
-        struct compact_pmu_event pmu_name;
+\tconst struct compact_pmu_event *entries;
+\tuint32_t num_entries;
+\tstruct compact_pmu_event pmu_name;
 };
=20
 """)
@@ -1466,6 +1463,7 @@ struct pmu_table_entry {
=20
   _bcs.compute()
   if not _args.output_string_file:
+    _args.output_file.write('/* clang-format off */\n')
     _args.output_file.write('static const char *const big_c_string =3D\n')
     for s in _bcs.big_string:
       _args.output_file.write(s)
@@ -1487,6 +1485,7 @@ struct pmu_table_entry {
=20
   print_mapping_table(archs)
   print_system_mapping_table()
+  _args.output_file.write('/* clang-format on */\n')
   print_metricgroups()
   _args.output_file.close()
   if _args.output_string_file:
--=20
2.54.0.823.g6e5bcc1fc9-goog

