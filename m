Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604122;
	b=b+cAXz8KLiRe4Q4SGjpAnCr4cHI0a8hYvQ6SP9YcU3fVAVQD8m7t5MibX9OGqOQlPXPu
	 hLduzKpp5eq+2KHTb1N669knndoSgdJhYjSZfY/9KBsSY4LkRhgqbRMppIrWM0gPKiLcz
	 BP5/pAAoS+3ZnURJZOBNOfHnaRVcqki5dTivhTX2Via9TjZWv3pbbBBPSrwheEmwznB/E
	 1l5CfDr3bGgzmtLWMqC5PtdsVGZH/pAILcxN66nz2nQv5kxM78ubnKzuzHvofIx47qwYp
	 IRnkzD3CpiwPXNFUUeo7k6pnAOTZTog+plG73N8Z8pPJ/NaUEt8m9BEaqNmQ4h7Y2Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604122;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Lhg7vjfljkaPWwLKxyCYOtVh4SsvfERM2T6Qb20BisE=;
	b=PRNGxPmxAg+Yur3L1q3wimpR+hhq8anGMKjGncvHZ+fLUCYijK95qJ3KJc1UUgJjUxo0
	 S8awmoXj1sGe7u1T8Uxj32PMZpwWS7yUclluJVceQF/qqURG6jOcR4wlZ6FThTqwlTMwh
	 yMZL3X12HeGBsGWumaVn1w4UP7X3ARPhw+lD3V+xz2FO995U2D3LI4XvFtrctQuZxIG9i
	 B1paFrpjb2ZAX+6x9mMzxWqDsTcpj9YEuah+xkF70BU5WL4qzjhu5j4YskKYlo6yfQsdo
	 ucJ7s5f8EW/iFwW9wvp/0rBmGJTwLmQwSv3ff1/nRu4DJ3w4ZLEsnrZObMRwl3AWm4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=he7bLflj;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7536260A3819
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7536260A3819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=he7bLflj
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cdb061cc4dbso1516982a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794604120; x=1795208920; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Lhg7vjfljkaPWwLKxyCYOtVh4SsvfERM2T6Qb20BisE=;
        b=he7bLflj1vCbHmsi5FaWH5Eu3xaDtvjhc0Fv6OaVdPH71nOcFIfB05hf9jl/idJrgF
         EeDjTmQ5Dv85kkEUpz6KJLTIoOFB++Ii2UrKJsh1dYiKaoRP02hAiIpTFsow1jACsmSK
         Vmwg+rMdkqlZmYQkCg4pxaxpcVKswNFQiF2Y+zv9wM4ZIpmq9E7HrudYhlJBt/RBnpGi
         6f4+N2UB0T0tfofCgFB/nCnHu5QVjPwe8yBMhbFQKPetDsPoAQoSpUC6yX/7Xn8ebF79
         16K0+BOMK8dPqyqiYJYX7/aT/d69KGZmaxDu7LEdUEkgQYTpszpYCcxndlyAomNV0MxD
         GmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794604120; x=1795208920;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lhg7vjfljkaPWwLKxyCYOtVh4SsvfERM2T6Qb20BisE=;
        b=PrE6BENIrndBSMRfoeNigxOX3rchh1arN/HRtyer6ocYu3aS15tOd9ejHVkG179TRG
         jgUCCePmcq6l8JyZs2zRCnDlHJWU8MaqpVkQaX9Xufb3EPGe30n+aQTZgbV69rdcjZ5d
         79Z7jaa5xoQkZXDcjz1bNFiVgeR5J2pu2RTf9qUb6hukBPfhrVCeW0glW1MrrEWGb5Ck
         kjzwSUSeI9b83zLPHOVRaRwX5Nug2c59ZxTKXPa9BvOA/zwm3HXAWuBFT8atsukoPB1Z
         EOY7Wh2oSbHekk9ofLRKs4oXQjVs4cY4aLeZN31s6hG2nPJg214X3ePd8DtxTGWTNKOd
         oLZQ==
X-Forwarded-Encrypted: i=1; AL+hErFv9E7GXWm+xB0L9oLeDIx/8B53+NsSyBzT86E5IdESBPPyXYlFfK43WK+7fBGaptPMSDqks6KrVbjLiT15kMyj@vger.kernel.org
X-Gm-Message-State: APuU4Z+oqQm0xjuN/vm75oleMfqXte3b4Tgslvvgf7F+cY0Z8OBz5t+1
	yt9xakMiANR+yD9ExRhcWn6t8NYR5uePCOuNpc54rFlAE6xLw6G+Glep5CUII/d6qM1H5cYW94P
	9CfQkpUT+pA==
X-Received: from pgdo15-n2.prod.google.com ([2002:a05:6a02:620f:20b0:cdd:bfcd:be0a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a126:b0:3e2:5850:a6d9
 with SMTP id adf61e73a8af0-3f6312836c4mr5130321637.6.1794604118831; Fri, 13
 Nov 2026 13:08:38 -0800 (PST)
Date: Fri, 13 Nov 2026 13:08:14 -0800
In-Reply-To: <20261113210822.3112700-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113210822.3112700-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113210822.3112700-3-irogers@google.com>
Subject: [PATCH 02/10] perf jevents: Sort BigCString entries alphabetically
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Currently BigCString partitions non-metric event strings before metric
and metricgroup strings, and orders deduplicated entries within each
partition by first-seen insertion order (insert_point). Because strings
shared across multiple CPU models stay at their earliest insertion
position while model-unique strings are appended later, later models are
already fragmented across big_c_string, and identically prefixed event
and metric definitions from different models are scattered far apart.

Drop insert_number/insert_point so non-folded BigCString entries are
still partitioned with event strings before metric strings, and sorted
lexicographically by their raw UTF-8 byte sequence (which starts with
the NUL-terminated event or metric name) within each partition. Grouping
identically prefixed event names, event encodings, descriptions, and
metric expressions adjacent to one another prepares big_c_string for
block-indexed string compression (splitting big_c_string into
independently compressed ~8 KiB blocks decompressed on demand by block
index and intra-block byte offset), shrinking the compressed blocks by
~20-23%.

Regenerate empty-pmu-events.c for the updated string offsets.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 7700 +++++++++++-----------
 tools/perf/pmu-events/jevents.py         |   10 +-
 2 files changed, 3852 insertions(+), 3858 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-even=
ts/empty-pmu-events.c
index 7df1552403e7..c0023687e3dd 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -20,5166 +20,5166 @@ struct pmu_table_entry {
 /* clang-format off */
 static const char *const big_c_string =3D
 /* offset=3D0 */
-"default_core\000"
-/* offset=3D13 */
-"l1-dcache\000legacy cache\000Level 1 data cache read accesses\000legacy-c=
ache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D99 */
-"l1-dcache-load\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D190 */
-"l1-dcache-load-refs\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D286 */
-"l1-dcache-load-reference\000legacy cache\000Level 1 data cache read acces=
ses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D387 */
-"l1-dcache-load-ops\000legacy cache\000Level 1 data cache read accesses\00=
0legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D482 */
-"l1-dcache-load-access\000legacy cache\000Level 1 data cache read accesses=
\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D580 */
-"l1-dcache-load-misses\000legacy cache\000Level 1 data cache read misses\0=
00legacy-cache-config=3D0x10000\000\00000\000\000\000\000\000"
-/* offset=3D682 */
-"l1-dcache-load-miss\000legacy cache\000Level 1 data cache read misses\000=
legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D782 */
-"l1-dcache-loads\000legacy cache\000Level 1 data cache read accesses\000le=
gacy-cache-config=3D0\000\00000\000\000\000\000\000"
-/* offset=3D874 */
-"l1-dcache-loads-refs\000legacy cache\000Level 1 data cache read accesses\=
000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D971 */
-"l1-dcache-loads-reference\000legacy cache\000Level 1 data cache read acce=
sses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D1073 */
-"l1-dcache-loads-ops\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D1169 */
-"l1-dcache-loads-access\000legacy cache\000Level 1 data cache read accesse=
s\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D1268 */
-"l1-dcache-loads-misses\000legacy cache\000Level 1 data cache read misses\=
000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D1371 */
-"l1-dcache-loads-miss\000legacy cache\000Level 1 data cache read misses\00=
0legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D1472 */
-"l1-dcache-read\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D1563 */
-"l1-dcache-read-refs\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D1659 */
-"l1-dcache-read-reference\000legacy cache\000Level 1 data cache read acces=
ses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D1760 */
-"l1-dcache-read-ops\000legacy cache\000Level 1 data cache read accesses\00=
0legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D1855 */
-"l1-dcache-read-access\000legacy cache\000Level 1 data cache read accesses=
\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D1953 */
-"l1-dcache-read-misses\000legacy cache\000Level 1 data cache read misses\0=
00legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D2055 */
-"l1-dcache-read-miss\000legacy cache\000Level 1 data cache read misses\000=
legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D2155 */
-"l1-dcache-store\000legacy cache\000Level 1 data cache write accesses\000l=
egacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D2252 */
-"l1-dcache-store-refs\000legacy cache\000Level 1 data cache write accesses=
\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D2354 */
-"l1-dcache-store-reference\000legacy cache\000Level 1 data cache write acc=
esses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D2461 */
-"l1-dcache-store-ops\000legacy cache\000Level 1 data cache write accesses\=
000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D2562 */
-"l1-dcache-store-access\000legacy cache\000Level 1 data cache write access=
es\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D2666 */
-"l1-dcache-store-misses\000legacy cache\000Level 1 data cache write misses=
\000legacy-cache-config=3D0x10100\000\00000\000\000\000\000\000"
-/* offset=3D2770 */
-"l1-dcache-store-miss\000legacy cache\000Level 1 data cache write misses\0=
00legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D2872 */
-"l1-dcache-stores\000legacy cache\000Level 1 data cache write accesses\000=
legacy-cache-config=3D0x100\000\00000\000\000\000\000\000"
-/* offset=3D2970 */
-"l1-dcache-stores-refs\000legacy cache\000Level 1 data cache write accesse=
s\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D3073 */
-"l1-dcache-stores-reference\000legacy cache\000Level 1 data cache write ac=
cesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D3181 */
-"l1-dcache-stores-ops\000legacy cache\000Level 1 data cache write accesses=
\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D3283 */
-"l1-dcache-stores-access\000legacy cache\000Level 1 data cache write acces=
ses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D3388 */
-"l1-dcache-stores-misses\000legacy cache\000Level 1 data cache write misse=
s\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D3493 */
-"l1-dcache-stores-miss\000legacy cache\000Level 1 data cache write misses\=
000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D3596 */
-"l1-dcache-write\000legacy cache\000Level 1 data cache write accesses\000l=
egacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D3693 */
-"l1-dcache-write-refs\000legacy cache\000Level 1 data cache write accesses=
\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D3795 */
-"l1-dcache-write-reference\000legacy cache\000Level 1 data cache write acc=
esses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D3902 */
-"l1-dcache-write-ops\000legacy cache\000Level 1 data cache write accesses\=
000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D4003 */
-"l1-dcache-write-access\000legacy cache\000Level 1 data cache write access=
es\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D4107 */
-"l1-dcache-write-misses\000legacy cache\000Level 1 data cache write misses=
\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D4211 */
-"l1-dcache-write-miss\000legacy cache\000Level 1 data cache write misses\0=
00legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D4313 */
-"l1-dcache-prefetch\000legacy cache\000Level 1 data cache prefetch accesse=
s\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D4416 */
-"l1-dcache-prefetch-refs\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D4524 */
-"l1-dcache-prefetch-reference\000legacy cache\000Level 1 data cache prefet=
ch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D4637 */
-"l1-dcache-prefetch-ops\000legacy cache\000Level 1 data cache prefetch acc=
esses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D4744 */
-"l1-dcache-prefetch-access\000legacy cache\000Level 1 data cache prefetch =
accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D4854 */
-"l1-dcache-prefetch-misses\000legacy cache\000Level 1 data cache prefetch =
misses\000legacy-cache-config=3D0x10200\000\00000\000\000\000\000\000"
-/* offset=3D4964 */
-"l1-dcache-prefetch-miss\000legacy cache\000Level 1 data cache prefetch mi=
sses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D5072 */
-"l1-dcache-prefetches\000legacy cache\000Level 1 data cache prefetch acces=
ses\000legacy-cache-config=3D0x200\000\00000\000\000\000\000\000"
-/* offset=3D5177 */
-"l1-dcache-prefetches-refs\000legacy cache\000Level 1 data cache prefetch =
accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D5287 */
-"l1-dcache-prefetches-reference\000legacy cache\000Level 1 data cache pref=
etch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D5402 */
-"l1-dcache-prefetches-ops\000legacy cache\000Level 1 data cache prefetch a=
ccesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D5511 */
-"l1-dcache-prefetches-access\000legacy cache\000Level 1 data cache prefetc=
h accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D5623 */
-"l1-dcache-prefetches-misses\000legacy cache\000Level 1 data cache prefetc=
h misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D5735 */
-"l1-dcache-prefetches-miss\000legacy cache\000Level 1 data cache prefetch =
misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D5845 */
-"l1-dcache-speculative-read\000legacy cache\000Level 1 data cache prefetch=
 accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D5956 */
-"l1-dcache-speculative-read-refs\000legacy cache\000Level 1 data cache pre=
fetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000=
"
-/* offset=3D6072 */
-"l1-dcache-speculative-read-reference\000legacy cache\000Level 1 data cach=
e prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\00=
0\000"
-/* offset=3D6193 */
-"l1-dcache-speculative-read-ops\000legacy cache\000Level 1 data cache pref=
etch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D6308 */
-"l1-dcache-speculative-read-access\000legacy cache\000Level 1 data cache p=
refetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\0=
00"
-/* offset=3D6426 */
-"l1-dcache-speculative-read-misses\000legacy cache\000Level 1 data cache p=
refetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\0=
00"
-/* offset=3D6544 */
-"l1-dcache-speculative-read-miss\000legacy cache\000Level 1 data cache pre=
fetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000=
"
-/* offset=3D6660 */
-"l1-dcache-speculative-load\000legacy cache\000Level 1 data cache prefetch=
 accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D6771 */
-"l1-dcache-speculative-load-refs\000legacy cache\000Level 1 data cache pre=
fetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000=
"
-/* offset=3D6887 */
-"l1-dcache-speculative-load-reference\000legacy cache\000Level 1 data cach=
e prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\00=
0\000"
-/* offset=3D7008 */
-"l1-dcache-speculative-load-ops\000legacy cache\000Level 1 data cache pref=
etch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D7123 */
-"l1-dcache-speculative-load-access\000legacy cache\000Level 1 data cache p=
refetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\0=
00"
-/* offset=3D7241 */
-"l1-dcache-speculative-load-misses\000legacy cache\000Level 1 data cache p=
refetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\0=
00"
-/* offset=3D7359 */
-"l1-dcache-speculative-load-miss\000legacy cache\000Level 1 data cache pre=
fetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000=
"
-/* offset=3D7475 */
-"l1-dcache-refs\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D7566 */
-"l1-dcache-reference\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D7662 */
-"l1-dcache-ops\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D7752 */
-"l1-dcache-access\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D7845 */
-"l1-dcache-misses\000legacy cache\000Level 1 data cache read misses\000leg=
acy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D7942 */
-"l1-dcache-miss\000legacy cache\000Level 1 data cache read misses\000legac=
y-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D8037 */
-"l1-d\000legacy cache\000Level 1 data cache read accesses\000legacy-cache-=
config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D8118 */
-"l1-d-load\000legacy cache\000Level 1 data cache read accesses\000legacy-c=
ache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D8204 */
-"l1-d-load-refs\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D8295 */
-"l1-d-load-reference\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D8391 */
-"l1-d-load-ops\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D8481 */
-"l1-d-load-access\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D8574 */
-"l1-d-load-misses\000legacy cache\000Level 1 data cache read misses\000leg=
acy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D8671 */
-"l1-d-load-miss\000legacy cache\000Level 1 data cache read misses\000legac=
y-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D8766 */
-"l1-d-loads\000legacy cache\000Level 1 data cache read accesses\000legacy-=
cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D8853 */
-"l1-d-loads-refs\000legacy cache\000Level 1 data cache read accesses\000le=
gacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D8945 */
-"l1-d-loads-reference\000legacy cache\000Level 1 data cache read accesses\=
000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D9042 */
-"l1-d-loads-ops\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D9133 */
-"l1-d-loads-access\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D9227 */
-"l1-d-loads-misses\000legacy cache\000Level 1 data cache read misses\000le=
gacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D9325 */
-"l1-d-loads-miss\000legacy cache\000Level 1 data cache read misses\000lega=
cy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D9421 */
-"l1-d-read\000legacy cache\000Level 1 data cache read accesses\000legacy-c=
ache-config=3D0\000\00010\000\000\000\000\000"
+"alignment-faults\000software\000Number of kernel handled memory alignment=
 faults\000config=3D7\000\00000\000\000\000\000\000"
+/* offset=3D92 */
+"bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=3D0x8a\000\0000=
0\000\000\000\000\000"
+/* offset=3D154 */
+"bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=3D0x8b\000\0000=
0\000\000\000\000\000"
+/* offset=3D216 */
+"bpc\000legacy cache\000Branch prediction unit read accesses\000legacy-cac=
he-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D300 */
+"bpc-access\000legacy cache\000Branch prediction unit read accesses\000leg=
acy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D391 */
+"bpc-load\000legacy cache\000Branch prediction unit read accesses\000legac=
y-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D480 */
+"bpc-load-access\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D576 */
+"bpc-load-miss\000legacy cache\000Branch prediction unit read misses\000le=
gacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D674 */
+"bpc-load-misses\000legacy cache\000Branch prediction unit read misses\000=
legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D774 */
+"bpc-load-ops\000legacy cache\000Branch prediction unit read accesses\000l=
egacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D867 */
+"bpc-load-reference\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D966 */
+"bpc-load-refs\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D1060 */
+"bpc-loads\000legacy cache\000Branch prediction unit read accesses\000lega=
cy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D1150 */
+"bpc-loads-access\000legacy cache\000Branch prediction unit read accesses\=
000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D1247 */
+"bpc-loads-miss\000legacy cache\000Branch prediction unit read misses\000l=
egacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D1346 */
+"bpc-loads-misses\000legacy cache\000Branch prediction unit read misses\00=
0legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D1447 */
+"bpc-loads-ops\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D1541 */
+"bpc-loads-reference\000legacy cache\000Branch prediction unit read access=
es\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D1641 */
+"bpc-loads-refs\000legacy cache\000Branch prediction unit read accesses\00=
0legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D1736 */
+"bpc-miss\000legacy cache\000Branch prediction unit read misses\000legacy-=
cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D1829 */
+"bpc-misses\000legacy cache\000Branch prediction unit read misses\000legac=
y-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D1924 */
+"bpc-ops\000legacy cache\000Branch prediction unit read accesses\000legacy=
-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D2012 */
+"bpc-read\000legacy cache\000Branch prediction unit read accesses\000legac=
y-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D2101 */
+"bpc-read-access\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D2197 */
+"bpc-read-miss\000legacy cache\000Branch prediction unit read misses\000le=
gacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D2295 */
+"bpc-read-misses\000legacy cache\000Branch prediction unit read misses\000=
legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D2395 */
+"bpc-read-ops\000legacy cache\000Branch prediction unit read accesses\000l=
egacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D2488 */
+"bpc-read-reference\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D2587 */
+"bpc-read-refs\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D2681 */
+"bpc-reference\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D2775 */
+"bpc-refs\000legacy cache\000Branch prediction unit read accesses\000legac=
y-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D2864 */
+"bpf-output\000software\000An event used by BPF programs to write to the p=
erf ring buffer\000config=3D0xa\000\00000\000\000\000\000\000"
+/* offset=3D2966 */
+"bpu\000legacy cache\000Branch prediction unit read accesses\000legacy-cac=
he-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D3050 */
+"bpu-access\000legacy cache\000Branch prediction unit read accesses\000leg=
acy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D3141 */
+"bpu-load\000legacy cache\000Branch prediction unit read accesses\000legac=
y-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D3230 */
+"bpu-load-access\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D3326 */
+"bpu-load-miss\000legacy cache\000Branch prediction unit read misses\000le=
gacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D3424 */
+"bpu-load-misses\000legacy cache\000Branch prediction unit read misses\000=
legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D3524 */
+"bpu-load-ops\000legacy cache\000Branch prediction unit read accesses\000l=
egacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D3617 */
+"bpu-load-reference\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D3716 */
+"bpu-load-refs\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D3810 */
+"bpu-loads\000legacy cache\000Branch prediction unit read accesses\000lega=
cy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D3900 */
+"bpu-loads-access\000legacy cache\000Branch prediction unit read accesses\=
000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D3997 */
+"bpu-loads-miss\000legacy cache\000Branch prediction unit read misses\000l=
egacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D4096 */
+"bpu-loads-misses\000legacy cache\000Branch prediction unit read misses\00=
0legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D4197 */
+"bpu-loads-ops\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D4291 */
+"bpu-loads-reference\000legacy cache\000Branch prediction unit read access=
es\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D4391 */
+"bpu-loads-refs\000legacy cache\000Branch prediction unit read accesses\00=
0legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D4486 */
+"bpu-miss\000legacy cache\000Branch prediction unit read misses\000legacy-=
cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D4579 */
+"bpu-misses\000legacy cache\000Branch prediction unit read misses\000legac=
y-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D4674 */
+"bpu-ops\000legacy cache\000Branch prediction unit read accesses\000legacy=
-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D4762 */
+"bpu-read\000legacy cache\000Branch prediction unit read accesses\000legac=
y-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D4851 */
+"bpu-read-access\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D4947 */
+"bpu-read-miss\000legacy cache\000Branch prediction unit read misses\000le=
gacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D5045 */
+"bpu-read-misses\000legacy cache\000Branch prediction unit read misses\000=
legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D5145 */
+"bpu-read-ops\000legacy cache\000Branch prediction unit read accesses\000l=
egacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D5238 */
+"bpu-read-reference\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D5337 */
+"bpu-read-refs\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D5431 */
+"bpu-reference\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D5525 */
+"bpu-refs\000legacy cache\000Branch prediction unit read accesses\000legac=
y-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D5614 */
+"branch\000legacy cache\000Branch prediction unit read accesses\000legacy-=
cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D5701 */
+"branch-access\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D5795 */
+"branch-instructions\000legacy hardware\000Retired branch instructions [Th=
is event is an alias of branches]\000legacy-hardware-config=3D4\000\00000\0=
00\000\000\000\000"
+/* offset=3D5929 */
+"branch-load\000legacy cache\000Branch prediction unit read accesses\000le=
gacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D6021 */
+"branch-load-access\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D6120 */
+"branch-load-miss\000legacy cache\000Branch prediction unit read misses\00=
0legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D6221 */
+"branch-load-misses\000legacy cache\000Branch prediction unit read misses\=
000legacy-cache-config=3D0x10005\000\00000\000\000\000\000\000"
+/* offset=3D6324 */
+"branch-load-ops\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D6420 */
+"branch-load-reference\000legacy cache\000Branch prediction unit read acce=
sses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D6522 */
+"branch-load-refs\000legacy cache\000Branch prediction unit read accesses\=
000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D6619 */
+"branch-loads\000legacy cache\000Branch prediction unit read accesses\000l=
egacy-cache-config=3D5\000\00000\000\000\000\000\000"
+/* offset=3D6712 */
+"branch-loads-access\000legacy cache\000Branch prediction unit read access=
es\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D6812 */
+"branch-loads-miss\000legacy cache\000Branch prediction unit read misses\0=
00legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D6914 */
+"branch-loads-misses\000legacy cache\000Branch prediction unit read misses=
\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D7018 */
+"branch-loads-ops\000legacy cache\000Branch prediction unit read accesses\=
000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D7115 */
+"branch-loads-reference\000legacy cache\000Branch prediction unit read acc=
esses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D7218 */
+"branch-loads-refs\000legacy cache\000Branch prediction unit read accesses=
\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D7316 */
+"branch-miss\000legacy cache\000Branch prediction unit read misses\000lega=
cy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D7412 */
+"branch-misses\000legacy hardware\000Mispredicted branch instructions\000l=
egacy-hardware-config=3D5\000\00000\000\000\000\000\000"
+/* offset=3D7508 */
+"branch-ops\000legacy cache\000Branch prediction unit read accesses\000leg=
acy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D7599 */
+"branch-read\000legacy cache\000Branch prediction unit read accesses\000le=
gacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D7691 */
+"branch-read-access\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D7790 */
+"branch-read-miss\000legacy cache\000Branch prediction unit read misses\00=
0legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D7891 */
+"branch-read-misses\000legacy cache\000Branch prediction unit read misses\=
000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D7994 */
+"branch-read-ops\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D8090 */
+"branch-read-reference\000legacy cache\000Branch prediction unit read acce=
sses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D8192 */
+"branch-read-refs\000legacy cache\000Branch prediction unit read accesses\=
000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D8289 */
+"branch-reference\000legacy cache\000Branch prediction unit read accesses\=
000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D8386 */
+"branch-refs\000legacy cache\000Branch prediction unit read accesses\000le=
gacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D8478 */
+"branches\000legacy hardware\000Retired branch instructions [This event is=
 an alias of branch-instructions]\000legacy-hardware-config=3D4\000\00000\0=
00\000\000\000\000"
+/* offset=3D8612 */
+"branches-access\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D8708 */
+"branches-load\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D8802 */
+"branches-load-access\000legacy cache\000Branch prediction unit read acces=
ses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D8903 */
+"branches-load-miss\000legacy cache\000Branch prediction unit read misses\=
000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D9006 */
+"branches-load-misses\000legacy cache\000Branch prediction unit read misse=
s\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D9111 */
+"branches-load-ops\000legacy cache\000Branch prediction unit read accesses=
\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D9209 */
+"branches-load-reference\000legacy cache\000Branch prediction unit read ac=
cesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D9313 */
+"branches-load-refs\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D9412 */
+"branches-loads\000legacy cache\000Branch prediction unit read accesses\00=
0legacy-cache-config=3D5\000\00010\000\000\000\000\000"
 /* offset=3D9507 */
-"l1-d-read-refs\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D9598 */
-"l1-d-read-reference\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D9694 */
-"l1-d-read-ops\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D9784 */
-"l1-d-read-access\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D9877 */
-"l1-d-read-misses\000legacy cache\000Level 1 data cache read misses\000leg=
acy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D9974 */
-"l1-d-read-miss\000legacy cache\000Level 1 data cache read misses\000legac=
y-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D10069 */
-"l1-d-store\000legacy cache\000Level 1 data cache write accesses\000legacy=
-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D10161 */
-"l1-d-store-refs\000legacy cache\000Level 1 data cache write accesses\000l=
egacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D10258 */
-"l1-d-store-reference\000legacy cache\000Level 1 data cache write accesses=
\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D10360 */
-"l1-d-store-ops\000legacy cache\000Level 1 data cache write accesses\000le=
gacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D10456 */
-"l1-d-store-access\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D10555 */
-"l1-d-store-misses\000legacy cache\000Level 1 data cache write misses\000l=
egacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D10654 */
-"l1-d-store-miss\000legacy cache\000Level 1 data cache write misses\000leg=
acy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D10751 */
-"l1-d-stores\000legacy cache\000Level 1 data cache write accesses\000legac=
y-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D10844 */
-"l1-d-stores-refs\000legacy cache\000Level 1 data cache write accesses\000=
legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D10942 */
-"l1-d-stores-reference\000legacy cache\000Level 1 data cache write accesse=
s\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D11045 */
-"l1-d-stores-ops\000legacy cache\000Level 1 data cache write accesses\000l=
egacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D11142 */
-"l1-d-stores-access\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D11242 */
-"l1-d-stores-misses\000legacy cache\000Level 1 data cache write misses\000=
legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D11342 */
-"l1-d-stores-miss\000legacy cache\000Level 1 data cache write misses\000le=
gacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D11440 */
-"l1-d-write\000legacy cache\000Level 1 data cache write accesses\000legacy=
-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D11532 */
-"l1-d-write-refs\000legacy cache\000Level 1 data cache write accesses\000l=
egacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D11629 */
-"l1-d-write-reference\000legacy cache\000Level 1 data cache write accesses=
\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D11731 */
-"l1-d-write-ops\000legacy cache\000Level 1 data cache write accesses\000le=
gacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D11827 */
-"l1-d-write-access\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D11926 */
-"l1-d-write-misses\000legacy cache\000Level 1 data cache write misses\000l=
egacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D12025 */
-"l1-d-write-miss\000legacy cache\000Level 1 data cache write misses\000leg=
acy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D12122 */
-"l1-d-prefetch\000legacy cache\000Level 1 data cache prefetch accesses\000=
legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D12220 */
-"l1-d-prefetch-refs\000legacy cache\000Level 1 data cache prefetch accesse=
s\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D12323 */
-"l1-d-prefetch-reference\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D12431 */
-"l1-d-prefetch-ops\000legacy cache\000Level 1 data cache prefetch accesses=
\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D12533 */
-"l1-d-prefetch-access\000legacy cache\000Level 1 data cache prefetch acces=
ses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D12638 */
-"l1-d-prefetch-misses\000legacy cache\000Level 1 data cache prefetch misse=
s\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D12743 */
-"l1-d-prefetch-miss\000legacy cache\000Level 1 data cache prefetch misses\=
000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D12846 */
-"l1-d-prefetches\000legacy cache\000Level 1 data cache prefetch accesses\0=
00legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D12946 */
-"l1-d-prefetches-refs\000legacy cache\000Level 1 data cache prefetch acces=
ses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D13051 */
-"l1-d-prefetches-reference\000legacy cache\000Level 1 data cache prefetch =
accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D13161 */
-"l1-d-prefetches-ops\000legacy cache\000Level 1 data cache prefetch access=
es\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D13265 */
-"l1-d-prefetches-access\000legacy cache\000Level 1 data cache prefetch acc=
esses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D13372 */
-"l1-d-prefetches-misses\000legacy cache\000Level 1 data cache prefetch mis=
ses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D13479 */
-"l1-d-prefetches-miss\000legacy cache\000Level 1 data cache prefetch misse=
s\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D13584 */
-"l1-d-speculative-read\000legacy cache\000Level 1 data cache prefetch acce=
sses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D13690 */
-"l1-d-speculative-read-refs\000legacy cache\000Level 1 data cache prefetch=
 accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D13801 */
-"l1-d-speculative-read-reference\000legacy cache\000Level 1 data cache pre=
fetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000=
"
-/* offset=3D13917 */
-"l1-d-speculative-read-ops\000legacy cache\000Level 1 data cache prefetch =
accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D14027 */
-"l1-d-speculative-read-access\000legacy cache\000Level 1 data cache prefet=
ch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D14140 */
-"l1-d-speculative-read-misses\000legacy cache\000Level 1 data cache prefet=
ch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D14253 */
-"l1-d-speculative-read-miss\000legacy cache\000Level 1 data cache prefetch=
 misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D14364 */
-"l1-d-speculative-load\000legacy cache\000Level 1 data cache prefetch acce=
sses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D14470 */
-"l1-d-speculative-load-refs\000legacy cache\000Level 1 data cache prefetch=
 accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D14581 */
-"l1-d-speculative-load-reference\000legacy cache\000Level 1 data cache pre=
fetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000=
"
-/* offset=3D14697 */
-"l1-d-speculative-load-ops\000legacy cache\000Level 1 data cache prefetch =
accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D14807 */
-"l1-d-speculative-load-access\000legacy cache\000Level 1 data cache prefet=
ch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D14920 */
-"l1-d-speculative-load-misses\000legacy cache\000Level 1 data cache prefet=
ch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D15033 */
-"l1-d-speculative-load-miss\000legacy cache\000Level 1 data cache prefetch=
 misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D15144 */
-"l1-d-refs\000legacy cache\000Level 1 data cache read accesses\000legacy-c=
ache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D15230 */
-"l1-d-reference\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D15321 */
-"l1-d-ops\000legacy cache\000Level 1 data cache read accesses\000legacy-ca=
che-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D15406 */
-"l1-d-access\000legacy cache\000Level 1 data cache read accesses\000legacy=
-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D15494 */
-"l1-d-misses\000legacy cache\000Level 1 data cache read misses\000legacy-c=
ache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D15586 */
-"l1-d-miss\000legacy cache\000Level 1 data cache read misses\000legacy-cac=
he-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D15676 */
-"l1d\000legacy cache\000Level 1 data cache read accesses\000legacy-cache-c=
onfig=3D0\000\00010\000\000\000\000\000"
-/* offset=3D15756 */
-"l1d-load\000legacy cache\000Level 1 data cache read accesses\000legacy-ca=
che-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D15841 */
-"l1d-load-refs\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D15931 */
-"l1d-load-reference\000legacy cache\000Level 1 data cache read accesses\00=
0legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D16026 */
-"l1d-load-ops\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D16115 */
-"l1d-load-access\000legacy cache\000Level 1 data cache read accesses\000le=
gacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D16207 */
-"l1d-load-misses\000legacy cache\000Level 1 data cache read misses\000lega=
cy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D16303 */
-"l1d-load-miss\000legacy cache\000Level 1 data cache read misses\000legacy=
-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D16397 */
-"l1d-loads\000legacy cache\000Level 1 data cache read accesses\000legacy-c=
ache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D16483 */
-"l1d-loads-refs\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D16574 */
-"l1d-loads-reference\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D16670 */
-"l1d-loads-ops\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D16760 */
-"l1d-loads-access\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D16853 */
-"l1d-loads-misses\000legacy cache\000Level 1 data cache read misses\000leg=
acy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D16950 */
-"l1d-loads-miss\000legacy cache\000Level 1 data cache read misses\000legac=
y-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D17045 */
-"l1d-read\000legacy cache\000Level 1 data cache read accesses\000legacy-ca=
che-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D17130 */
-"l1d-read-refs\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D17220 */
-"l1d-read-reference\000legacy cache\000Level 1 data cache read accesses\00=
0legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D17315 */
-"l1d-read-ops\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D17404 */
-"l1d-read-access\000legacy cache\000Level 1 data cache read accesses\000le=
gacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D17496 */
-"l1d-read-misses\000legacy cache\000Level 1 data cache read misses\000lega=
cy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D17592 */
-"l1d-read-miss\000legacy cache\000Level 1 data cache read misses\000legacy=
-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D17686 */
-"l1d-store\000legacy cache\000Level 1 data cache write accesses\000legacy-=
cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D17777 */
-"l1d-store-refs\000legacy cache\000Level 1 data cache write accesses\000le=
gacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D17873 */
-"l1d-store-reference\000legacy cache\000Level 1 data cache write accesses\=
000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D17974 */
-"l1d-store-ops\000legacy cache\000Level 1 data cache write accesses\000leg=
acy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D18069 */
-"l1d-store-access\000legacy cache\000Level 1 data cache write accesses\000=
legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D18167 */
-"l1d-store-misses\000legacy cache\000Level 1 data cache write misses\000le=
gacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D18265 */
-"l1d-store-miss\000legacy cache\000Level 1 data cache write misses\000lega=
cy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D18361 */
-"l1d-stores\000legacy cache\000Level 1 data cache write accesses\000legacy=
-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D18453 */
-"l1d-stores-refs\000legacy cache\000Level 1 data cache write accesses\000l=
egacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D18550 */
-"l1d-stores-reference\000legacy cache\000Level 1 data cache write accesses=
\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D18652 */
-"l1d-stores-ops\000legacy cache\000Level 1 data cache write accesses\000le=
gacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D18748 */
-"l1d-stores-access\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D18847 */
-"l1d-stores-misses\000legacy cache\000Level 1 data cache write misses\000l=
egacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D18946 */
-"l1d-stores-miss\000legacy cache\000Level 1 data cache write misses\000leg=
acy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D19043 */
-"l1d-write\000legacy cache\000Level 1 data cache write accesses\000legacy-=
cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D19134 */
-"l1d-write-refs\000legacy cache\000Level 1 data cache write accesses\000le=
gacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D19230 */
-"l1d-write-reference\000legacy cache\000Level 1 data cache write accesses\=
000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D19331 */
-"l1d-write-ops\000legacy cache\000Level 1 data cache write accesses\000leg=
acy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D19426 */
-"l1d-write-access\000legacy cache\000Level 1 data cache write accesses\000=
legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D19524 */
-"l1d-write-misses\000legacy cache\000Level 1 data cache write misses\000le=
gacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D19622 */
-"l1d-write-miss\000legacy cache\000Level 1 data cache write misses\000lega=
cy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D19718 */
-"l1d-prefetch\000legacy cache\000Level 1 data cache prefetch accesses\000l=
egacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D19815 */
-"l1d-prefetch-refs\000legacy cache\000Level 1 data cache prefetch accesses=
\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D19917 */
-"l1d-prefetch-reference\000legacy cache\000Level 1 data cache prefetch acc=
esses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D20024 */
-"l1d-prefetch-ops\000legacy cache\000Level 1 data cache prefetch accesses\=
000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D20125 */
-"l1d-prefetch-access\000legacy cache\000Level 1 data cache prefetch access=
es\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D20229 */
-"l1d-prefetch-misses\000legacy cache\000Level 1 data cache prefetch misses=
\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D20333 */
-"l1d-prefetch-miss\000legacy cache\000Level 1 data cache prefetch misses\0=
00legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D20435 */
-"l1d-prefetches\000legacy cache\000Level 1 data cache prefetch accesses\00=
0legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D20534 */
-"l1d-prefetches-refs\000legacy cache\000Level 1 data cache prefetch access=
es\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D20638 */
-"l1d-prefetches-reference\000legacy cache\000Level 1 data cache prefetch a=
ccesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D20747 */
-"l1d-prefetches-ops\000legacy cache\000Level 1 data cache prefetch accesse=
s\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D20850 */
-"l1d-prefetches-access\000legacy cache\000Level 1 data cache prefetch acce=
sses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D20956 */
-"l1d-prefetches-misses\000legacy cache\000Level 1 data cache prefetch miss=
es\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D21062 */
-"l1d-prefetches-miss\000legacy cache\000Level 1 data cache prefetch misses=
\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D21166 */
-"l1d-speculative-read\000legacy cache\000Level 1 data cache prefetch acces=
ses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D21271 */
-"l1d-speculative-read-refs\000legacy cache\000Level 1 data cache prefetch =
accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D21381 */
-"l1d-speculative-read-reference\000legacy cache\000Level 1 data cache pref=
etch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D21496 */
-"l1d-speculative-read-ops\000legacy cache\000Level 1 data cache prefetch a=
ccesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D21605 */
-"l1d-speculative-read-access\000legacy cache\000Level 1 data cache prefetc=
h accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D21717 */
-"l1d-speculative-read-misses\000legacy cache\000Level 1 data cache prefetc=
h misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D21829 */
-"l1d-speculative-read-miss\000legacy cache\000Level 1 data cache prefetch =
misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D21939 */
-"l1d-speculative-load\000legacy cache\000Level 1 data cache prefetch acces=
ses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D22044 */
-"l1d-speculative-load-refs\000legacy cache\000Level 1 data cache prefetch =
accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D22154 */
-"l1d-speculative-load-reference\000legacy cache\000Level 1 data cache pref=
etch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D22269 */
-"l1d-speculative-load-ops\000legacy cache\000Level 1 data cache prefetch a=
ccesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D22378 */
-"l1d-speculative-load-access\000legacy cache\000Level 1 data cache prefetc=
h accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D22490 */
-"l1d-speculative-load-misses\000legacy cache\000Level 1 data cache prefetc=
h misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D22602 */
-"l1d-speculative-load-miss\000legacy cache\000Level 1 data cache prefetch =
misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D22712 */
-"l1d-refs\000legacy cache\000Level 1 data cache read accesses\000legacy-ca=
che-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D22797 */
-"l1d-reference\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D22887 */
-"l1d-ops\000legacy cache\000Level 1 data cache read accesses\000legacy-cac=
he-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D22971 */
-"l1d-access\000legacy cache\000Level 1 data cache read accesses\000legacy-=
cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D23058 */
-"l1d-misses\000legacy cache\000Level 1 data cache read misses\000legacy-ca=
che-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D23149 */
-"l1d-miss\000legacy cache\000Level 1 data cache read misses\000legacy-cach=
e-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D23238 */
-"l1-data\000legacy cache\000Level 1 data cache read accesses\000legacy-cac=
he-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D23322 */
-"l1-data-load\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D23411 */
-"l1-data-load-refs\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D23505 */
-"l1-data-load-reference\000legacy cache\000Level 1 data cache read accesse=
s\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D23604 */
-"l1-data-load-ops\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D23697 */
-"l1-data-load-access\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D23793 */
-"l1-data-load-misses\000legacy cache\000Level 1 data cache read misses\000=
legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D23893 */
-"l1-data-load-miss\000legacy cache\000Level 1 data cache read misses\000le=
gacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D23991 */
-"l1-data-loads\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D24081 */
-"l1-data-loads-refs\000legacy cache\000Level 1 data cache read accesses\00=
0legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D24176 */
-"l1-data-loads-reference\000legacy cache\000Level 1 data cache read access=
es\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D24276 */
-"l1-data-loads-ops\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D24370 */
-"l1-data-loads-access\000legacy cache\000Level 1 data cache read accesses\=
000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D24467 */
-"l1-data-loads-misses\000legacy cache\000Level 1 data cache read misses\00=
0legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D24568 */
-"l1-data-loads-miss\000legacy cache\000Level 1 data cache read misses\000l=
egacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D24667 */
-"l1-data-read\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D24756 */
-"l1-data-read-refs\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D24850 */
-"l1-data-read-reference\000legacy cache\000Level 1 data cache read accesse=
s\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D24949 */
-"l1-data-read-ops\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D25042 */
-"l1-data-read-access\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D25138 */
-"l1-data-read-misses\000legacy cache\000Level 1 data cache read misses\000=
legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D25238 */
-"l1-data-read-miss\000legacy cache\000Level 1 data cache read misses\000le=
gacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D25336 */
-"l1-data-store\000legacy cache\000Level 1 data cache write accesses\000leg=
acy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D25431 */
-"l1-data-store-refs\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D25531 */
-"l1-data-store-reference\000legacy cache\000Level 1 data cache write acces=
ses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D25636 */
-"l1-data-store-ops\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D25735 */
-"l1-data-store-access\000legacy cache\000Level 1 data cache write accesses=
\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D25837 */
-"l1-data-store-misses\000legacy cache\000Level 1 data cache write misses\0=
00legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D25939 */
-"l1-data-store-miss\000legacy cache\000Level 1 data cache write misses\000=
legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D26039 */
-"l1-data-stores\000legacy cache\000Level 1 data cache write accesses\000le=
gacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D26135 */
-"l1-data-stores-refs\000legacy cache\000Level 1 data cache write accesses\=
000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D26236 */
-"l1-data-stores-reference\000legacy cache\000Level 1 data cache write acce=
sses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D26342 */
-"l1-data-stores-ops\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D26442 */
-"l1-data-stores-access\000legacy cache\000Level 1 data cache write accesse=
s\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D26545 */
-"l1-data-stores-misses\000legacy cache\000Level 1 data cache write misses\=
000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D26648 */
-"l1-data-stores-miss\000legacy cache\000Level 1 data cache write misses\00=
0legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D26749 */
-"l1-data-write\000legacy cache\000Level 1 data cache write accesses\000leg=
acy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D26844 */
-"l1-data-write-refs\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D26944 */
-"l1-data-write-reference\000legacy cache\000Level 1 data cache write acces=
ses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D27049 */
-"l1-data-write-ops\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D27148 */
-"l1-data-write-access\000legacy cache\000Level 1 data cache write accesses=
\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D27250 */
-"l1-data-write-misses\000legacy cache\000Level 1 data cache write misses\0=
00legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D27352 */
-"l1-data-write-miss\000legacy cache\000Level 1 data cache write misses\000=
legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D27452 */
-"l1-data-prefetch\000legacy cache\000Level 1 data cache prefetch accesses\=
000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D27553 */
-"l1-data-prefetch-refs\000legacy cache\000Level 1 data cache prefetch acce=
sses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D27659 */
-"l1-data-prefetch-reference\000legacy cache\000Level 1 data cache prefetch=
 accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D27770 */
-"l1-data-prefetch-ops\000legacy cache\000Level 1 data cache prefetch acces=
ses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D27875 */
-"l1-data-prefetch-access\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D27983 */
-"l1-data-prefetch-misses\000legacy cache\000Level 1 data cache prefetch mi=
sses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D28091 */
-"l1-data-prefetch-miss\000legacy cache\000Level 1 data cache prefetch miss=
es\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D28197 */
-"l1-data-prefetches\000legacy cache\000Level 1 data cache prefetch accesse=
s\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D28300 */
-"l1-data-prefetches-refs\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D28408 */
-"l1-data-prefetches-reference\000legacy cache\000Level 1 data cache prefet=
ch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D28521 */
-"l1-data-prefetches-ops\000legacy cache\000Level 1 data cache prefetch acc=
esses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D28628 */
-"l1-data-prefetches-access\000legacy cache\000Level 1 data cache prefetch =
accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D28738 */
-"l1-data-prefetches-misses\000legacy cache\000Level 1 data cache prefetch =
misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D28848 */
-"l1-data-prefetches-miss\000legacy cache\000Level 1 data cache prefetch mi=
sses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D28956 */
-"l1-data-speculative-read\000legacy cache\000Level 1 data cache prefetch a=
ccesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D29065 */
-"l1-data-speculative-read-refs\000legacy cache\000Level 1 data cache prefe=
tch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D29179 */
-"l1-data-speculative-read-reference\000legacy cache\000Level 1 data cache =
prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\=
000"
-/* offset=3D29298 */
-"l1-data-speculative-read-ops\000legacy cache\000Level 1 data cache prefet=
ch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D29411 */
-"l1-data-speculative-read-access\000legacy cache\000Level 1 data cache pre=
fetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000=
"
-/* offset=3D29527 */
-"l1-data-speculative-read-misses\000legacy cache\000Level 1 data cache pre=
fetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000=
"
-/* offset=3D29643 */
-"l1-data-speculative-read-miss\000legacy cache\000Level 1 data cache prefe=
tch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D29757 */
-"l1-data-speculative-load\000legacy cache\000Level 1 data cache prefetch a=
ccesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D29866 */
-"l1-data-speculative-load-refs\000legacy cache\000Level 1 data cache prefe=
tch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D29980 */
-"l1-data-speculative-load-reference\000legacy cache\000Level 1 data cache =
prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\=
000"
-/* offset=3D30099 */
-"l1-data-speculative-load-ops\000legacy cache\000Level 1 data cache prefet=
ch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D30212 */
-"l1-data-speculative-load-access\000legacy cache\000Level 1 data cache pre=
fetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000=
"
-/* offset=3D30328 */
-"l1-data-speculative-load-misses\000legacy cache\000Level 1 data cache pre=
fetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000=
"
-/* offset=3D30444 */
-"l1-data-speculative-load-miss\000legacy cache\000Level 1 data cache prefe=
tch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D30558 */
-"l1-data-refs\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D30647 */
-"l1-data-reference\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D30741 */
-"l1-data-ops\000legacy cache\000Level 1 data cache read accesses\000legacy=
-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D30829 */
-"l1-data-access\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D30920 */
-"l1-data-misses\000legacy cache\000Level 1 data cache read misses\000legac=
y-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D31015 */
-"l1-data-miss\000legacy cache\000Level 1 data cache read misses\000legacy-=
cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D31108 */
-"l1-icache\000legacy cache\000Level 1 instruction cache read accesses\000l=
egacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D31201 */
-"l1-icache-load\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D31299 */
-"l1-icache-load-refs\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D31402 */
-"l1-icache-load-reference\000legacy cache\000Level 1 instruction cache rea=
d accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D31510 */
-"l1-icache-load-ops\000legacy cache\000Level 1 instruction cache read acce=
sses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D31612 */
-"l1-icache-load-access\000legacy cache\000Level 1 instruction cache read a=
ccesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D31717 */
-"l1-icache-load-misses\000legacy cache\000Level 1 instruction cache read m=
isses\000legacy-cache-config=3D0x10001\000\00000\000\000\000\000\000"
-/* offset=3D31826 */
-"l1-icache-load-miss\000legacy cache\000Level 1 instruction cache read mis=
ses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D31933 */
-"l1-icache-loads\000legacy cache\000Level 1 instruction cache read accesse=
s\000legacy-cache-config=3D1\000\00000\000\000\000\000\000"
-/* offset=3D32032 */
-"l1-icache-loads-refs\000legacy cache\000Level 1 instruction cache read ac=
cesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D32136 */
-"l1-icache-loads-reference\000legacy cache\000Level 1 instruction cache re=
ad accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D32245 */
-"l1-icache-loads-ops\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D32348 */
-"l1-icache-loads-access\000legacy cache\000Level 1 instruction cache read =
accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D32454 */
-"l1-icache-loads-misses\000legacy cache\000Level 1 instruction cache read =
misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D32564 */
-"l1-icache-loads-miss\000legacy cache\000Level 1 instruction cache read mi=
sses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D32672 */
-"l1-icache-read\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D32770 */
-"l1-icache-read-refs\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D32873 */
-"l1-icache-read-reference\000legacy cache\000Level 1 instruction cache rea=
d accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D32981 */
-"l1-icache-read-ops\000legacy cache\000Level 1 instruction cache read acce=
sses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D33083 */
-"l1-icache-read-access\000legacy cache\000Level 1 instruction cache read a=
ccesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D33188 */
-"l1-icache-read-misses\000legacy cache\000Level 1 instruction cache read m=
isses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D33297 */
-"l1-icache-read-miss\000legacy cache\000Level 1 instruction cache read mis=
ses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D33404 */
-"l1-icache-prefetch\000legacy cache\000Level 1 instruction cache prefetch =
accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D33514 */
-"l1-icache-prefetch-refs\000legacy cache\000Level 1 instruction cache pref=
etch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D33629 */
-"l1-icache-prefetch-reference\000legacy cache\000Level 1 instruction cache=
 prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000=
\000"
-/* offset=3D33749 */
-"l1-icache-prefetch-ops\000legacy cache\000Level 1 instruction cache prefe=
tch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D33863 */
-"l1-icache-prefetch-access\000legacy cache\000Level 1 instruction cache pr=
efetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\00=
0"
-/* offset=3D33980 */
-"l1-icache-prefetch-misses\000legacy cache\000Level 1 instruction cache pr=
efetch misses\000legacy-cache-config=3D0x10201\000\00000\000\000\000\000\00=
0"
-/* offset=3D34097 */
-"l1-icache-prefetch-miss\000legacy cache\000Level 1 instruction cache pref=
etch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
-/* offset=3D34212 */
-"l1-icache-prefetches\000legacy cache\000Level 1 instruction cache prefetc=
h accesses\000legacy-cache-config=3D0x201\000\00000\000\000\000\000\000"
-/* offset=3D34324 */
-"l1-icache-prefetches-refs\000legacy cache\000Level 1 instruction cache pr=
efetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\00=
0"
-/* offset=3D34441 */
-"l1-icache-prefetches-reference\000legacy cache\000Level 1 instruction cac=
he prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\0=
00\000"
-/* offset=3D34563 */
-"l1-icache-prefetches-ops\000legacy cache\000Level 1 instruction cache pre=
fetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000=
"
-/* offset=3D34679 */
-"l1-icache-prefetches-access\000legacy cache\000Level 1 instruction cache =
prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\=
000"
-/* offset=3D34798 */
-"l1-icache-prefetches-misses\000legacy cache\000Level 1 instruction cache =
prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\=
000"
-/* offset=3D34917 */
-"l1-icache-prefetches-miss\000legacy cache\000Level 1 instruction cache pr=
efetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\00=
0"
-/* offset=3D35034 */
-"l1-icache-speculative-read\000legacy cache\000Level 1 instruction cache p=
refetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\0=
00"
-/* offset=3D35152 */
-"l1-icache-speculative-read-refs\000legacy cache\000Level 1 instruction ca=
che prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\=
000\000"
-/* offset=3D35275 */
-"l1-icache-speculative-read-reference\000legacy cache\000Level 1 instructi=
on cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000=
\000\000\000"
-/* offset=3D35403 */
-"l1-icache-speculative-read-ops\000legacy cache\000Level 1 instruction cac=
he prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\0=
00\000"
-/* offset=3D35525 */
-"l1-icache-speculative-read-access\000legacy cache\000Level 1 instruction =
cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\00=
0\000\000"
-/* offset=3D35650 */
-"l1-icache-speculative-read-misses\000legacy cache\000Level 1 instruction =
cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\00=
0\000\000"
-/* offset=3D35775 */
-"l1-icache-speculative-read-miss\000legacy cache\000Level 1 instruction ca=
che prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\=
000\000"
-/* offset=3D35898 */
-"l1-icache-speculative-load\000legacy cache\000Level 1 instruction cache p=
refetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\0=
00"
-/* offset=3D36016 */
-"l1-icache-speculative-load-refs\000legacy cache\000Level 1 instruction ca=
che prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\=
000\000"
-/* offset=3D36139 */
-"l1-icache-speculative-load-reference\000legacy cache\000Level 1 instructi=
on cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000=
\000\000\000"
-/* offset=3D36267 */
-"l1-icache-speculative-load-ops\000legacy cache\000Level 1 instruction cac=
he prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\0=
00\000"
-/* offset=3D36389 */
-"l1-icache-speculative-load-access\000legacy cache\000Level 1 instruction =
cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\00=
0\000\000"
-/* offset=3D36514 */
-"l1-icache-speculative-load-misses\000legacy cache\000Level 1 instruction =
cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\00=
0\000\000"
-/* offset=3D36639 */
-"l1-icache-speculative-load-miss\000legacy cache\000Level 1 instruction ca=
che prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\=
000\000"
-/* offset=3D36762 */
-"l1-icache-refs\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D36860 */
-"l1-icache-reference\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D36963 */
-"l1-icache-ops\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D37060 */
-"l1-icache-access\000legacy cache\000Level 1 instruction cache read access=
es\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D37160 */
-"l1-icache-misses\000legacy cache\000Level 1 instruction cache read misses=
\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D37264 */
-"l1-icache-miss\000legacy cache\000Level 1 instruction cache read misses\0=
00legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D37366 */
-"l1-i\000legacy cache\000Level 1 instruction cache read accesses\000legacy=
-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D37454 */
-"l1-i-load\000legacy cache\000Level 1 instruction cache read accesses\000l=
egacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D37547 */
-"l1-i-load-refs\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D37645 */
-"l1-i-load-reference\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D37748 */
-"l1-i-load-ops\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D37845 */
-"l1-i-load-access\000legacy cache\000Level 1 instruction cache read access=
es\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D37945 */
-"l1-i-load-misses\000legacy cache\000Level 1 instruction cache read misses=
\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D38049 */
-"l1-i-load-miss\000legacy cache\000Level 1 instruction cache read misses\0=
00legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D38151 */
-"l1-i-loads\000legacy cache\000Level 1 instruction cache read accesses\000=
legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D38245 */
-"l1-i-loads-refs\000legacy cache\000Level 1 instruction cache read accesse=
s\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D38344 */
-"l1-i-loads-reference\000legacy cache\000Level 1 instruction cache read ac=
cesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D38448 */
-"l1-i-loads-ops\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D38546 */
-"l1-i-loads-access\000legacy cache\000Level 1 instruction cache read acces=
ses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D38647 */
-"l1-i-loads-misses\000legacy cache\000Level 1 instruction cache read misse=
s\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D38752 */
-"l1-i-loads-miss\000legacy cache\000Level 1 instruction cache read misses\=
000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D38855 */
-"l1-i-read\000legacy cache\000Level 1 instruction cache read accesses\000l=
egacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D38948 */
-"l1-i-read-refs\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D39046 */
-"l1-i-read-reference\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D39149 */
-"l1-i-read-ops\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D39246 */
-"l1-i-read-access\000legacy cache\000Level 1 instruction cache read access=
es\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D39346 */
-"l1-i-read-misses\000legacy cache\000Level 1 instruction cache read misses=
\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D39450 */
-"l1-i-read-miss\000legacy cache\000Level 1 instruction cache read misses\0=
00legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D39552 */
-"l1-i-prefetch\000legacy cache\000Level 1 instruction cache prefetch acces=
ses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D39657 */
-"l1-i-prefetch-refs\000legacy cache\000Level 1 instruction cache prefetch =
accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D39767 */
-"l1-i-prefetch-reference\000legacy cache\000Level 1 instruction cache pref=
etch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D39882 */
-"l1-i-prefetch-ops\000legacy cache\000Level 1 instruction cache prefetch a=
ccesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D39991 */
-"l1-i-prefetch-access\000legacy cache\000Level 1 instruction cache prefetc=
h accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D40103 */
-"l1-i-prefetch-misses\000legacy cache\000Level 1 instruction cache prefetc=
h misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
-/* offset=3D40215 */
-"l1-i-prefetch-miss\000legacy cache\000Level 1 instruction cache prefetch =
misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
-/* offset=3D40325 */
-"l1-i-prefetches\000legacy cache\000Level 1 instruction cache prefetch acc=
esses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D40432 */
-"l1-i-prefetches-refs\000legacy cache\000Level 1 instruction cache prefetc=
h accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D40544 */
-"l1-i-prefetches-reference\000legacy cache\000Level 1 instruction cache pr=
efetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\00=
0"
-/* offset=3D40661 */
-"l1-i-prefetches-ops\000legacy cache\000Level 1 instruction cache prefetch=
 accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D40772 */
-"l1-i-prefetches-access\000legacy cache\000Level 1 instruction cache prefe=
tch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D40886 */
-"l1-i-prefetches-misses\000legacy cache\000Level 1 instruction cache prefe=
tch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
-/* offset=3D41000 */
-"l1-i-prefetches-miss\000legacy cache\000Level 1 instruction cache prefetc=
h misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
-/* offset=3D41112 */
-"l1-i-speculative-read\000legacy cache\000Level 1 instruction cache prefet=
ch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D41225 */
-"l1-i-speculative-read-refs\000legacy cache\000Level 1 instruction cache p=
refetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\0=
00"
-/* offset=3D41343 */
-"l1-i-speculative-read-reference\000legacy cache\000Level 1 instruction ca=
che prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\=
000\000"
-/* offset=3D41466 */
-"l1-i-speculative-read-ops\000legacy cache\000Level 1 instruction cache pr=
efetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\00=
0"
-/* offset=3D41583 */
-"l1-i-speculative-read-access\000legacy cache\000Level 1 instruction cache=
 prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000=
\000"
-/* offset=3D41703 */
-"l1-i-speculative-read-misses\000legacy cache\000Level 1 instruction cache=
 prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000=
\000"
-/* offset=3D41823 */
-"l1-i-speculative-read-miss\000legacy cache\000Level 1 instruction cache p=
refetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\0=
00"
-/* offset=3D41941 */
-"l1-i-speculative-load\000legacy cache\000Level 1 instruction cache prefet=
ch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D42054 */
-"l1-i-speculative-load-refs\000legacy cache\000Level 1 instruction cache p=
refetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\0=
00"
-/* offset=3D42172 */
-"l1-i-speculative-load-reference\000legacy cache\000Level 1 instruction ca=
che prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\=
000\000"
-/* offset=3D42295 */
-"l1-i-speculative-load-ops\000legacy cache\000Level 1 instruction cache pr=
efetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\00=
0"
-/* offset=3D42412 */
-"l1-i-speculative-load-access\000legacy cache\000Level 1 instruction cache=
 prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000=
\000"
-/* offset=3D42532 */
-"l1-i-speculative-load-misses\000legacy cache\000Level 1 instruction cache=
 prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000=
\000"
-/* offset=3D42652 */
-"l1-i-speculative-load-miss\000legacy cache\000Level 1 instruction cache p=
refetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\0=
00"
-/* offset=3D42770 */
-"l1-i-refs\000legacy cache\000Level 1 instruction cache read accesses\000l=
egacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D42863 */
-"l1-i-reference\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D42961 */
-"l1-i-ops\000legacy cache\000Level 1 instruction cache read accesses\000le=
gacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D43053 */
-"l1-i-access\000legacy cache\000Level 1 instruction cache read accesses\00=
0legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D43148 */
-"l1-i-misses\000legacy cache\000Level 1 instruction cache read misses\000l=
egacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D43247 */
-"l1-i-miss\000legacy cache\000Level 1 instruction cache read misses\000leg=
acy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D43344 */
-"l1i\000legacy cache\000Level 1 instruction cache read accesses\000legacy-=
cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D43431 */
-"l1i-load\000legacy cache\000Level 1 instruction cache read accesses\000le=
gacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D43523 */
-"l1i-load-refs\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D43620 */
-"l1i-load-reference\000legacy cache\000Level 1 instruction cache read acce=
sses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D43722 */
-"l1i-load-ops\000legacy cache\000Level 1 instruction cache read accesses\0=
00legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D43818 */
-"l1i-load-access\000legacy cache\000Level 1 instruction cache read accesse=
s\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D43917 */
-"l1i-load-misses\000legacy cache\000Level 1 instruction cache read misses\=
000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D44020 */
-"l1i-load-miss\000legacy cache\000Level 1 instruction cache read misses\00=
0legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D44121 */
-"l1i-loads\000legacy cache\000Level 1 instruction cache read accesses\000l=
egacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D44214 */
-"l1i-loads-refs\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D44312 */
-"l1i-loads-reference\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D44415 */
-"l1i-loads-ops\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D44512 */
-"l1i-loads-access\000legacy cache\000Level 1 instruction cache read access=
es\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D44612 */
-"l1i-loads-misses\000legacy cache\000Level 1 instruction cache read misses=
\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D44716 */
-"l1i-loads-miss\000legacy cache\000Level 1 instruction cache read misses\0=
00legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D44818 */
-"l1i-read\000legacy cache\000Level 1 instruction cache read accesses\000le=
gacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D44910 */
-"l1i-read-refs\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D45007 */
-"l1i-read-reference\000legacy cache\000Level 1 instruction cache read acce=
sses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D45109 */
-"l1i-read-ops\000legacy cache\000Level 1 instruction cache read accesses\0=
00legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D45205 */
-"l1i-read-access\000legacy cache\000Level 1 instruction cache read accesse=
s\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D45304 */
-"l1i-read-misses\000legacy cache\000Level 1 instruction cache read misses\=
000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D45407 */
-"l1i-read-miss\000legacy cache\000Level 1 instruction cache read misses\00=
0legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D45508 */
-"l1i-prefetch\000legacy cache\000Level 1 instruction cache prefetch access=
es\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D45612 */
-"l1i-prefetch-refs\000legacy cache\000Level 1 instruction cache prefetch a=
ccesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D45721 */
-"l1i-prefetch-reference\000legacy cache\000Level 1 instruction cache prefe=
tch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D45835 */
-"l1i-prefetch-ops\000legacy cache\000Level 1 instruction cache prefetch ac=
cesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D45943 */
-"l1i-prefetch-access\000legacy cache\000Level 1 instruction cache prefetch=
 accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D46054 */
-"l1i-prefetch-misses\000legacy cache\000Level 1 instruction cache prefetch=
 misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
-/* offset=3D46165 */
-"l1i-prefetch-miss\000legacy cache\000Level 1 instruction cache prefetch m=
isses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
-/* offset=3D46274 */
-"l1i-prefetches\000legacy cache\000Level 1 instruction cache prefetch acce=
sses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D46380 */
-"l1i-prefetches-refs\000legacy cache\000Level 1 instruction cache prefetch=
 accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D46491 */
-"l1i-prefetches-reference\000legacy cache\000Level 1 instruction cache pre=
fetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000=
"
-/* offset=3D46607 */
-"l1i-prefetches-ops\000legacy cache\000Level 1 instruction cache prefetch =
accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D46717 */
-"l1i-prefetches-access\000legacy cache\000Level 1 instruction cache prefet=
ch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D46830 */
-"l1i-prefetches-misses\000legacy cache\000Level 1 instruction cache prefet=
ch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
-/* offset=3D46943 */
-"l1i-prefetches-miss\000legacy cache\000Level 1 instruction cache prefetch=
 misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
-/* offset=3D47054 */
-"l1i-speculative-read\000legacy cache\000Level 1 instruction cache prefetc=
h accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D47166 */
-"l1i-speculative-read-refs\000legacy cache\000Level 1 instruction cache pr=
efetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\00=
0"
-/* offset=3D47283 */
-"l1i-speculative-read-reference\000legacy cache\000Level 1 instruction cac=
he prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\0=
00\000"
-/* offset=3D47405 */
-"l1i-speculative-read-ops\000legacy cache\000Level 1 instruction cache pre=
fetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000=
"
-/* offset=3D47521 */
-"l1i-speculative-read-access\000legacy cache\000Level 1 instruction cache =
prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\=
000"
-/* offset=3D47640 */
-"l1i-speculative-read-misses\000legacy cache\000Level 1 instruction cache =
prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\=
000"
-/* offset=3D47759 */
-"l1i-speculative-read-miss\000legacy cache\000Level 1 instruction cache pr=
efetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\00=
0"
-/* offset=3D47876 */
-"l1i-speculative-load\000legacy cache\000Level 1 instruction cache prefetc=
h accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D47988 */
-"l1i-speculative-load-refs\000legacy cache\000Level 1 instruction cache pr=
efetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\00=
0"
-/* offset=3D48105 */
-"l1i-speculative-load-reference\000legacy cache\000Level 1 instruction cac=
he prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\0=
00\000"
-/* offset=3D48227 */
-"l1i-speculative-load-ops\000legacy cache\000Level 1 instruction cache pre=
fetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000=
"
-/* offset=3D48343 */
-"l1i-speculative-load-access\000legacy cache\000Level 1 instruction cache =
prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\=
000"
-/* offset=3D48462 */
-"l1i-speculative-load-misses\000legacy cache\000Level 1 instruction cache =
prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\=
000"
-/* offset=3D48581 */
-"l1i-speculative-load-miss\000legacy cache\000Level 1 instruction cache pr=
efetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\00=
0"
-/* offset=3D48698 */
-"l1i-refs\000legacy cache\000Level 1 instruction cache read accesses\000le=
gacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D48790 */
-"l1i-reference\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D48887 */
-"l1i-ops\000legacy cache\000Level 1 instruction cache read accesses\000leg=
acy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D48978 */
-"l1i-access\000legacy cache\000Level 1 instruction cache read accesses\000=
legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D49072 */
-"l1i-misses\000legacy cache\000Level 1 instruction cache read misses\000le=
gacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D49170 */
-"l1i-miss\000legacy cache\000Level 1 instruction cache read misses\000lega=
cy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D49266 */
-"l1-instruction\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D49364 */
-"l1-instruction-load\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D49467 */
-"l1-instruction-load-refs\000legacy cache\000Level 1 instruction cache rea=
d accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D49575 */
-"l1-instruction-load-reference\000legacy cache\000Level 1 instruction cach=
e read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D49688 */
-"l1-instruction-load-ops\000legacy cache\000Level 1 instruction cache read=
 accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D49795 */
-"l1-instruction-load-access\000legacy cache\000Level 1 instruction cache r=
ead accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D49905 */
-"l1-instruction-load-misses\000legacy cache\000Level 1 instruction cache r=
ead misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D50019 */
-"l1-instruction-load-miss\000legacy cache\000Level 1 instruction cache rea=
d misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D50131 */
-"l1-instruction-loads\000legacy cache\000Level 1 instruction cache read ac=
cesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D50235 */
-"l1-instruction-loads-refs\000legacy cache\000Level 1 instruction cache re=
ad accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D50344 */
-"l1-instruction-loads-reference\000legacy cache\000Level 1 instruction cac=
he read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D50458 */
-"l1-instruction-loads-ops\000legacy cache\000Level 1 instruction cache rea=
d accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D50566 */
-"l1-instruction-loads-access\000legacy cache\000Level 1 instruction cache =
read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D50677 */
-"l1-instruction-loads-misses\000legacy cache\000Level 1 instruction cache =
read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D50792 */
-"l1-instruction-loads-miss\000legacy cache\000Level 1 instruction cache re=
ad misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D50905 */
-"l1-instruction-read\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D51008 */
-"l1-instruction-read-refs\000legacy cache\000Level 1 instruction cache rea=
d accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D51116 */
-"l1-instruction-read-reference\000legacy cache\000Level 1 instruction cach=
e read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D51229 */
-"l1-instruction-read-ops\000legacy cache\000Level 1 instruction cache read=
 accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D51336 */
-"l1-instruction-read-access\000legacy cache\000Level 1 instruction cache r=
ead accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D51446 */
-"l1-instruction-read-misses\000legacy cache\000Level 1 instruction cache r=
ead misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D51560 */
-"l1-instruction-read-miss\000legacy cache\000Level 1 instruction cache rea=
d misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D51672 */
-"l1-instruction-prefetch\000legacy cache\000Level 1 instruction cache pref=
etch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D51787 */
-"l1-instruction-prefetch-refs\000legacy cache\000Level 1 instruction cache=
 prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000=
\000"
-/* offset=3D51907 */
-"l1-instruction-prefetch-reference\000legacy cache\000Level 1 instruction =
cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\00=
0\000\000"
-/* offset=3D52032 */
-"l1-instruction-prefetch-ops\000legacy cache\000Level 1 instruction cache =
prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\=
000"
-/* offset=3D52151 */
-"l1-instruction-prefetch-access\000legacy cache\000Level 1 instruction cac=
he prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\0=
00\000"
-/* offset=3D52273 */
-"l1-instruction-prefetch-misses\000legacy cache\000Level 1 instruction cac=
he prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\0=
00\000"
-/* offset=3D52395 */
-"l1-instruction-prefetch-miss\000legacy cache\000Level 1 instruction cache=
 prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000=
\000"
-/* offset=3D52515 */
-"l1-instruction-prefetches\000legacy cache\000Level 1 instruction cache pr=
efetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\00=
0"
-/* offset=3D52632 */
-"l1-instruction-prefetches-refs\000legacy cache\000Level 1 instruction cac=
he prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\0=
00\000"
-/* offset=3D52754 */
-"l1-instruction-prefetches-reference\000legacy cache\000Level 1 instructio=
n cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\=
000\000\000"
-/* offset=3D52881 */
-"l1-instruction-prefetches-ops\000legacy cache\000Level 1 instruction cach=
e prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\00=
0\000"
-/* offset=3D53002 */
-"l1-instruction-prefetches-access\000legacy cache\000Level 1 instruction c=
ache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000=
\000\000"
-/* offset=3D53126 */
-"l1-instruction-prefetches-misses\000legacy cache\000Level 1 instruction c=
ache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000=
\000\000"
-/* offset=3D53250 */
-"l1-instruction-prefetches-miss\000legacy cache\000Level 1 instruction cac=
he prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\0=
00\000"
-/* offset=3D53372 */
-"l1-instruction-speculative-read\000legacy cache\000Level 1 instruction ca=
che prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\=
000\000"
-/* offset=3D53495 */
-"l1-instruction-speculative-read-refs\000legacy cache\000Level 1 instructi=
on cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000=
\000\000\000"
-/* offset=3D53623 */
-"l1-instruction-speculative-read-reference\000legacy cache\000Level 1 inst=
ruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\00=
0\000\000\000\000"
-/* offset=3D53756 */
-"l1-instruction-speculative-read-ops\000legacy cache\000Level 1 instructio=
n cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\=
000\000\000"
-/* offset=3D53883 */
-"l1-instruction-speculative-read-access\000legacy cache\000Level 1 instruc=
tion cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\0=
00\000\000\000"
-/* offset=3D54013 */
-"l1-instruction-speculative-read-misses\000legacy cache\000Level 1 instruc=
tion cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\0=
00\000\000\000"
-/* offset=3D54143 */
-"l1-instruction-speculative-read-miss\000legacy cache\000Level 1 instructi=
on cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000=
\000\000\000"
-/* offset=3D54271 */
-"l1-instruction-speculative-load\000legacy cache\000Level 1 instruction ca=
che prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\=
000\000"
-/* offset=3D54394 */
-"l1-instruction-speculative-load-refs\000legacy cache\000Level 1 instructi=
on cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000=
\000\000\000"
-/* offset=3D54522 */
-"l1-instruction-speculative-load-reference\000legacy cache\000Level 1 inst=
ruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\00=
0\000\000\000\000"
-/* offset=3D54655 */
-"l1-instruction-speculative-load-ops\000legacy cache\000Level 1 instructio=
n cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\=
000\000\000"
-/* offset=3D54782 */
-"l1-instruction-speculative-load-access\000legacy cache\000Level 1 instruc=
tion cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\0=
00\000\000\000"
-/* offset=3D54912 */
-"l1-instruction-speculative-load-misses\000legacy cache\000Level 1 instruc=
tion cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\0=
00\000\000\000"
-/* offset=3D55042 */
-"l1-instruction-speculative-load-miss\000legacy cache\000Level 1 instructi=
on cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000=
\000\000\000"
-/* offset=3D55170 */
-"l1-instruction-refs\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D55273 */
-"l1-instruction-reference\000legacy cache\000Level 1 instruction cache rea=
d accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D55381 */
-"l1-instruction-ops\000legacy cache\000Level 1 instruction cache read acce=
sses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D55483 */
-"l1-instruction-access\000legacy cache\000Level 1 instruction cache read a=
ccesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D55588 */
-"l1-instruction-misses\000legacy cache\000Level 1 instruction cache read m=
isses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D55697 */
-"l1-instruction-miss\000legacy cache\000Level 1 instruction cache read mis=
ses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D55804 */
-"llc\000legacy cache\000Last level cache read accesses\000legacy-cache-con=
fig=3D2\000\00010\000\000\000\000\000"
-/* offset=3D55882 */
-"llc-load\000legacy cache\000Last level cache read accesses\000legacy-cach=
e-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D55965 */
-"llc-load-refs\000legacy cache\000Last level cache read accesses\000legacy=
-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D56053 */
-"llc-load-reference\000legacy cache\000Last level cache read accesses\000l=
egacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D56146 */
-"llc-load-ops\000legacy cache\000Last level cache read accesses\000legacy-=
cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D56233 */
-"llc-load-access\000legacy cache\000Last level cache read accesses\000lega=
cy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D56323 */
-"llc-load-misses\000legacy cache\000Last level cache read misses\000legacy=
-cache-config=3D0x10002\000\00000\000\000\000\000\000"
-/* offset=3D56417 */
-"llc-load-miss\000legacy cache\000Last level cache read misses\000legacy-c=
ache-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D56509 */
-"llc-loads\000legacy cache\000Last level cache read accesses\000legacy-cac=
he-config=3D2\000\00000\000\000\000\000\000"
-/* offset=3D56593 */
-"llc-loads-refs\000legacy cache\000Last level cache read accesses\000legac=
y-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D56682 */
-"llc-loads-reference\000legacy cache\000Last level cache read accesses\000=
legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D56776 */
-"llc-loads-ops\000legacy cache\000Last level cache read accesses\000legacy=
-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D56864 */
-"llc-loads-access\000legacy cache\000Last level cache read accesses\000leg=
acy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D56955 */
-"llc-loads-misses\000legacy cache\000Last level cache read misses\000legac=
y-cache-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D57050 */
-"llc-loads-miss\000legacy cache\000Last level cache read misses\000legacy-=
cache-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D57143 */
-"llc-read\000legacy cache\000Last level cache read accesses\000legacy-cach=
e-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D57226 */
-"llc-read-refs\000legacy cache\000Last level cache read accesses\000legacy=
-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D57314 */
-"llc-read-reference\000legacy cache\000Last level cache read accesses\000l=
egacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D57407 */
-"llc-read-ops\000legacy cache\000Last level cache read accesses\000legacy-=
cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D57494 */
-"llc-read-access\000legacy cache\000Last level cache read accesses\000lega=
cy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D57584 */
-"llc-read-misses\000legacy cache\000Last level cache read misses\000legacy=
-cache-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D57678 */
-"llc-read-miss\000legacy cache\000Last level cache read misses\000legacy-c=
ache-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D57770 */
-"llc-store\000legacy cache\000Last level cache write accesses\000legacy-ca=
che-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D57859 */
-"llc-store-refs\000legacy cache\000Last level cache write accesses\000lega=
cy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D57953 */
-"llc-store-reference\000legacy cache\000Last level cache write accesses\00=
0legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D58052 */
-"llc-store-ops\000legacy cache\000Last level cache write accesses\000legac=
y-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D58145 */
-"llc-store-access\000legacy cache\000Last level cache write accesses\000le=
gacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D58241 */
-"llc-store-misses\000legacy cache\000Last level cache write misses\000lega=
cy-cache-config=3D0x10102\000\00000\000\000\000\000\000"
-/* offset=3D58337 */
-"llc-store-miss\000legacy cache\000Last level cache write misses\000legacy=
-cache-config=3D0x10102\000\00010\000\000\000\000\000"
-/* offset=3D58431 */
-"llc-stores\000legacy cache\000Last level cache write accesses\000legacy-c=
ache-config=3D0x102\000\00000\000\000\000\000\000"
-/* offset=3D58521 */
-"llc-stores-refs\000legacy cache\000Last level cache write accesses\000leg=
acy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D58616 */
-"llc-stores-reference\000legacy cache\000Last level cache write accesses\0=
00legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D58716 */
-"llc-stores-ops\000legacy cache\000Last level cache write accesses\000lega=
cy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D58810 */
-"llc-stores-access\000legacy cache\000Last level cache write accesses\000l=
egacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D58907 */
-"llc-stores-misses\000legacy cache\000Last level cache write misses\000leg=
acy-cache-config=3D0x10102\000\00010\000\000\000\000\000"
-/* offset=3D59004 */
-"llc-stores-miss\000legacy cache\000Last level cache write misses\000legac=
y-cache-config=3D0x10102\000\00010\000\000\000\000\000"
-/* offset=3D59099 */
-"llc-write\000legacy cache\000Last level cache write accesses\000legacy-ca=
che-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D59188 */
-"llc-write-refs\000legacy cache\000Last level cache write accesses\000lega=
cy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D59282 */
-"llc-write-reference\000legacy cache\000Last level cache write accesses\00=
0legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D59381 */
-"llc-write-ops\000legacy cache\000Last level cache write accesses\000legac=
y-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D59474 */
-"llc-write-access\000legacy cache\000Last level cache write accesses\000le=
gacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D59570 */
-"llc-write-misses\000legacy cache\000Last level cache write misses\000lega=
cy-cache-config=3D0x10102\000\00010\000\000\000\000\000"
-/* offset=3D59666 */
-"llc-write-miss\000legacy cache\000Last level cache write misses\000legacy=
-cache-config=3D0x10102\000\00010\000\000\000\000\000"
-/* offset=3D59760 */
-"llc-prefetch\000legacy cache\000Last level cache prefetch accesses\000leg=
acy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D59855 */
-"llc-prefetch-refs\000legacy cache\000Last level cache prefetch accesses\0=
00legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D59955 */
-"llc-prefetch-reference\000legacy cache\000Last level cache prefetch acces=
ses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D60060 */
-"llc-prefetch-ops\000legacy cache\000Last level cache prefetch accesses\00=
0legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D60159 */
-"llc-prefetch-access\000legacy cache\000Last level cache prefetch accesses=
\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D60261 */
-"llc-prefetch-misses\000legacy cache\000Last level cache prefetch misses\0=
00legacy-cache-config=3D0x10202\000\00000\000\000\000\000\000"
-/* offset=3D60363 */
-"llc-prefetch-miss\000legacy cache\000Last level cache prefetch misses\000=
legacy-cache-config=3D0x10202\000\00010\000\000\000\000\000"
-/* offset=3D60463 */
-"llc-prefetches\000legacy cache\000Last level cache prefetch accesses\000l=
egacy-cache-config=3D0x202\000\00000\000\000\000\000\000"
-/* offset=3D60560 */
-"llc-prefetches-refs\000legacy cache\000Last level cache prefetch accesses=
\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D60662 */
-"llc-prefetches-reference\000legacy cache\000Last level cache prefetch acc=
esses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D60769 */
-"llc-prefetches-ops\000legacy cache\000Last level cache prefetch accesses\=
000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D60870 */
-"llc-prefetches-access\000legacy cache\000Last level cache prefetch access=
es\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D60974 */
-"llc-prefetches-misses\000legacy cache\000Last level cache prefetch misses=
\000legacy-cache-config=3D0x10202\000\00010\000\000\000\000\000"
-/* offset=3D61078 */
-"llc-prefetches-miss\000legacy cache\000Last level cache prefetch misses\0=
00legacy-cache-config=3D0x10202\000\00010\000\000\000\000\000"
-/* offset=3D61180 */
-"llc-speculative-read\000legacy cache\000Last level cache prefetch accesse=
s\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D61283 */
-"llc-speculative-read-refs\000legacy cache\000Last level cache prefetch ac=
cesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D61391 */
-"llc-speculative-read-reference\000legacy cache\000Last level cache prefet=
ch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D61504 */
-"llc-speculative-read-ops\000legacy cache\000Last level cache prefetch acc=
esses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D61611 */
-"llc-speculative-read-access\000legacy cache\000Last level cache prefetch =
accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D61721 */
-"llc-speculative-read-misses\000legacy cache\000Last level cache prefetch =
misses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\000\000"
-/* offset=3D61831 */
-"llc-speculative-read-miss\000legacy cache\000Last level cache prefetch mi=
sses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\000\000"
-/* offset=3D61939 */
-"llc-speculative-load\000legacy cache\000Last level cache prefetch accesse=
s\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D62042 */
-"llc-speculative-load-refs\000legacy cache\000Last level cache prefetch ac=
cesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D62150 */
-"llc-speculative-load-reference\000legacy cache\000Last level cache prefet=
ch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D62263 */
-"llc-speculative-load-ops\000legacy cache\000Last level cache prefetch acc=
esses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D62370 */
-"llc-speculative-load-access\000legacy cache\000Last level cache prefetch =
accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D62480 */
-"llc-speculative-load-misses\000legacy cache\000Last level cache prefetch =
misses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\000\000"
-/* offset=3D62590 */
-"llc-speculative-load-miss\000legacy cache\000Last level cache prefetch mi=
sses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\000\000"
-/* offset=3D62698 */
-"llc-refs\000legacy cache\000Last level cache read accesses\000legacy-cach=
e-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D62781 */
-"llc-reference\000legacy cache\000Last level cache read accesses\000legacy=
-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D62869 */
-"llc-ops\000legacy cache\000Last level cache read accesses\000legacy-cache=
-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D62951 */
-"llc-access\000legacy cache\000Last level cache read accesses\000legacy-ca=
che-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D63036 */
-"llc-misses\000legacy cache\000Last level cache read misses\000legacy-cach=
e-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D63125 */
-"llc-miss\000legacy cache\000Last level cache read misses\000legacy-cache-=
config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D63212 */
-"l2\000legacy cache\000Level 2 (or higher) last level cache read accesses\=
000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D63309 */
-"l2-load\000legacy cache\000Level 2 (or higher) last level cache read acce=
sses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D63411 */
-"l2-load-refs\000legacy cache\000Level 2 (or higher) last level cache read=
 accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D63518 */
-"l2-load-reference\000legacy cache\000Level 2 (or higher) last level cache=
 read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D63630 */
-"l2-load-ops\000legacy cache\000Level 2 (or higher) last level cache read =
accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D63736 */
-"l2-load-access\000legacy cache\000Level 2 (or higher) last level cache re=
ad accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D63845 */
-"l2-load-misses\000legacy cache\000Level 2 (or higher) last level cache re=
ad misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D63958 */
-"l2-load-miss\000legacy cache\000Level 2 (or higher) last level cache read=
 misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D64069 */
-"l2-loads\000legacy cache\000Level 2 (or higher) last level cache read acc=
esses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D64172 */
-"l2-loads-refs\000legacy cache\000Level 2 (or higher) last level cache rea=
d accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D64280 */
-"l2-loads-reference\000legacy cache\000Level 2 (or higher) last level cach=
e read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D64393 */
-"l2-loads-ops\000legacy cache\000Level 2 (or higher) last level cache read=
 accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D64500 */
-"l2-loads-access\000legacy cache\000Level 2 (or higher) last level cache r=
ead accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D64610 */
-"l2-loads-misses\000legacy cache\000Level 2 (or higher) last level cache r=
ead misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D64724 */
-"l2-loads-miss\000legacy cache\000Level 2 (or higher) last level cache rea=
d misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D64836 */
-"l2-read\000legacy cache\000Level 2 (or higher) last level cache read acce=
sses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D64938 */
-"l2-read-refs\000legacy cache\000Level 2 (or higher) last level cache read=
 accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D65045 */
-"l2-read-reference\000legacy cache\000Level 2 (or higher) last level cache=
 read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D65157 */
-"l2-read-ops\000legacy cache\000Level 2 (or higher) last level cache read =
accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D65263 */
-"l2-read-access\000legacy cache\000Level 2 (or higher) last level cache re=
ad accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D65372 */
-"l2-read-misses\000legacy cache\000Level 2 (or higher) last level cache re=
ad misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D65485 */
-"l2-read-miss\000legacy cache\000Level 2 (or higher) last level cache read=
 misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D65596 */
-"l2-store\000legacy cache\000Level 2 (or higher) last level cache write ac=
cesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D65704 */
-"l2-store-refs\000legacy cache\000Level 2 (or higher) last level cache wri=
te accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D65817 */
-"l2-store-reference\000legacy cache\000Level 2 (or higher) last level cach=
e write accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\0=
00"
-/* offset=3D65935 */
-"l2-store-ops\000legacy cache\000Level 2 (or higher) last level cache writ=
e accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D66047 */
-"l2-store-access\000legacy cache\000Level 2 (or higher) last level cache w=
rite accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D66162 */
-"l2-store-misses\000legacy cache\000Level 2 (or higher) last level cache w=
rite misses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\000"
-/* offset=3D66277 */
-"l2-store-miss\000legacy cache\000Level 2 (or higher) last level cache wri=
te misses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\000"
-/* offset=3D66390 */
-"l2-stores\000legacy cache\000Level 2 (or higher) last level cache write a=
ccesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D66499 */
-"l2-stores-refs\000legacy cache\000Level 2 (or higher) last level cache wr=
ite accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D66613 */
-"l2-stores-reference\000legacy cache\000Level 2 (or higher) last level cac=
he write accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\=
000"
-/* offset=3D66732 */
-"l2-stores-ops\000legacy cache\000Level 2 (or higher) last level cache wri=
te accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D66845 */
-"l2-stores-access\000legacy cache\000Level 2 (or higher) last level cache =
write accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000=
"
-/* offset=3D66961 */
-"l2-stores-misses\000legacy cache\000Level 2 (or higher) last level cache =
write misses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\000=
"
-/* offset=3D67077 */
-"l2-stores-miss\000legacy cache\000Level 2 (or higher) last level cache wr=
ite misses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\000"
-/* offset=3D67191 */
-"l2-write\000legacy cache\000Level 2 (or higher) last level cache write ac=
cesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D67299 */
-"l2-write-refs\000legacy cache\000Level 2 (or higher) last level cache wri=
te accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D67412 */
-"l2-write-reference\000legacy cache\000Level 2 (or higher) last level cach=
e write accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\0=
00"
-/* offset=3D67530 */
-"l2-write-ops\000legacy cache\000Level 2 (or higher) last level cache writ=
e accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D67642 */
-"l2-write-access\000legacy cache\000Level 2 (or higher) last level cache w=
rite accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D67757 */
-"l2-write-misses\000legacy cache\000Level 2 (or higher) last level cache w=
rite misses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\000"
-/* offset=3D67872 */
-"l2-write-miss\000legacy cache\000Level 2 (or higher) last level cache wri=
te misses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\000"
-/* offset=3D67985 */
-"l2-prefetch\000legacy cache\000Level 2 (or higher) last level cache prefe=
tch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D68099 */
-"l2-prefetch-refs\000legacy cache\000Level 2 (or higher) last level cache =
prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\=
000"
-/* offset=3D68218 */
-"l2-prefetch-reference\000legacy cache\000Level 2 (or higher) last level c=
ache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000=
\000\000"
-/* offset=3D68342 */
-"l2-prefetch-ops\000legacy cache\000Level 2 (or higher) last level cache p=
refetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\0=
00"
-/* offset=3D68460 */
-"l2-prefetch-access\000legacy cache\000Level 2 (or higher) last level cach=
e prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\00=
0\000"
-/* offset=3D68581 */
-"l2-prefetch-misses\000legacy cache\000Level 2 (or higher) last level cach=
e prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\00=
0\000"
-/* offset=3D68702 */
-"l2-prefetch-miss\000legacy cache\000Level 2 (or higher) last level cache =
prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\000\=
000"
-/* offset=3D68821 */
-"l2-prefetches\000legacy cache\000Level 2 (or higher) last level cache pre=
fetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000=
"
-/* offset=3D68937 */
-"l2-prefetches-refs\000legacy cache\000Level 2 (or higher) last level cach=
e prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\00=
0\000"
-/* offset=3D69058 */
-"l2-prefetches-reference\000legacy cache\000Level 2 (or higher) last level=
 cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\0=
00\000\000"
-/* offset=3D69184 */
-"l2-prefetches-ops\000legacy cache\000Level 2 (or higher) last level cache=
 prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000=
\000"
-/* offset=3D69304 */
-"l2-prefetches-access\000legacy cache\000Level 2 (or higher) last level ca=
che prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\=
000\000"
-/* offset=3D69427 */
-"l2-prefetches-misses\000legacy cache\000Level 2 (or higher) last level ca=
che prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\=
000\000"
-/* offset=3D69550 */
-"l2-prefetches-miss\000legacy cache\000Level 2 (or higher) last level cach=
e prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\00=
0\000"
-/* offset=3D69671 */
-"l2-speculative-read\000legacy cache\000Level 2 (or higher) last level cac=
he prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\0=
00\000"
-/* offset=3D69793 */
-"l2-speculative-read-refs\000legacy cache\000Level 2 (or higher) last leve=
l cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\=
000\000\000"
-/* offset=3D69920 */
-"l2-speculative-read-reference\000legacy cache\000Level 2 (or higher) last=
 level cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000=
\000\000\000\000"
-/* offset=3D70052 */
-"l2-speculative-read-ops\000legacy cache\000Level 2 (or higher) last level=
 cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\0=
00\000\000"
-/* offset=3D70178 */
-"l2-speculative-read-access\000legacy cache\000Level 2 (or higher) last le=
vel cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\00=
0\000\000\000"
-/* offset=3D70307 */
-"l2-speculative-read-misses\000legacy cache\000Level 2 (or higher) last le=
vel cache prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\00=
0\000\000\000"
-/* offset=3D70436 */
-"l2-speculative-read-miss\000legacy cache\000Level 2 (or higher) last leve=
l cache prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\=
000\000\000"
-/* offset=3D70563 */
-"l2-speculative-load\000legacy cache\000Level 2 (or higher) last level cac=
he prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\0=
00\000"
-/* offset=3D70685 */
-"l2-speculative-load-refs\000legacy cache\000Level 2 (or higher) last leve=
l cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\=
000\000\000"
-/* offset=3D70812 */
-"l2-speculative-load-reference\000legacy cache\000Level 2 (or higher) last=
 level cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000=
\000\000\000\000"
-/* offset=3D70944 */
-"l2-speculative-load-ops\000legacy cache\000Level 2 (or higher) last level=
 cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\0=
00\000\000"
-/* offset=3D71070 */
-"l2-speculative-load-access\000legacy cache\000Level 2 (or higher) last le=
vel cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\00=
0\000\000\000"
-/* offset=3D71199 */
-"l2-speculative-load-misses\000legacy cache\000Level 2 (or higher) last le=
vel cache prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\00=
0\000\000\000"
-/* offset=3D71328 */
-"l2-speculative-load-miss\000legacy cache\000Level 2 (or higher) last leve=
l cache prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\=
000\000\000"
-/* offset=3D71455 */
-"l2-refs\000legacy cache\000Level 2 (or higher) last level cache read acce=
sses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D71557 */
-"l2-reference\000legacy cache\000Level 2 (or higher) last level cache read=
 accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D71664 */
-"l2-ops\000legacy cache\000Level 2 (or higher) last level cache read acces=
ses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D71765 */
-"l2-access\000legacy cache\000Level 2 (or higher) last level cache read ac=
cesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D71869 */
-"l2-misses\000legacy cache\000Level 2 (or higher) last level cache read mi=
sses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D71977 */
-"l2-miss\000legacy cache\000Level 2 (or higher) last level cache read miss=
es\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D72083 */
-"dtlb\000legacy cache\000Data TLB read accesses\000legacy-cache-config=3D3=
\000\00010\000\000\000\000\000"
-/* offset=3D72154 */
-"dtlb-load\000legacy cache\000Data TLB read accesses\000legacy-cache-confi=
g=3D3\000\00010\000\000\000\000\000"
-/* offset=3D72230 */
-"dtlb-load-refs\000legacy cache\000Data TLB read accesses\000legacy-cache-=
config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D72311 */
-"dtlb-load-reference\000legacy cache\000Data TLB read accesses\000legacy-c=
ache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D72397 */
-"dtlb-load-ops\000legacy cache\000Data TLB read accesses\000legacy-cache-c=
onfig=3D3\000\00010\000\000\000\000\000"
-/* offset=3D72477 */
-"dtlb-load-access\000legacy cache\000Data TLB read accesses\000legacy-cach=
e-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D72560 */
-"dtlb-load-misses\000legacy cache\000Data TLB read misses\000legacy-cache-=
config=3D0x10003\000\00000\000\000\000\000\000"
-/* offset=3D72647 */
-"dtlb-load-miss\000legacy cache\000Data TLB read misses\000legacy-cache-co=
nfig=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D72732 */
-"dtlb-loads\000legacy cache\000Data TLB read accesses\000legacy-cache-conf=
ig=3D3\000\00000\000\000\000\000\000"
-/* offset=3D72809 */
-"dtlb-loads-refs\000legacy cache\000Data TLB read accesses\000legacy-cache=
-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D72891 */
-"dtlb-loads-reference\000legacy cache\000Data TLB read accesses\000legacy-=
cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D72978 */
-"dtlb-loads-ops\000legacy cache\000Data TLB read accesses\000legacy-cache-=
config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D73059 */
-"dtlb-loads-access\000legacy cache\000Data TLB read accesses\000legacy-cac=
he-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D73143 */
-"dtlb-loads-misses\000legacy cache\000Data TLB read misses\000legacy-cache=
-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D73231 */
-"dtlb-loads-miss\000legacy cache\000Data TLB read misses\000legacy-cache-c=
onfig=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D73317 */
-"dtlb-read\000legacy cache\000Data TLB read accesses\000legacy-cache-confi=
g=3D3\000\00010\000\000\000\000\000"
-/* offset=3D73393 */
-"dtlb-read-refs\000legacy cache\000Data TLB read accesses\000legacy-cache-=
config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D73474 */
-"dtlb-read-reference\000legacy cache\000Data TLB read accesses\000legacy-c=
ache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D73560 */
-"dtlb-read-ops\000legacy cache\000Data TLB read accesses\000legacy-cache-c=
onfig=3D3\000\00010\000\000\000\000\000"
-/* offset=3D73640 */
-"dtlb-read-access\000legacy cache\000Data TLB read accesses\000legacy-cach=
e-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D73723 */
-"dtlb-read-misses\000legacy cache\000Data TLB read misses\000legacy-cache-=
config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D73810 */
-"dtlb-read-miss\000legacy cache\000Data TLB read misses\000legacy-cache-co=
nfig=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D73895 */
-"dtlb-store\000legacy cache\000Data TLB write accesses\000legacy-cache-con=
fig=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D73977 */
-"dtlb-store-refs\000legacy cache\000Data TLB write accesses\000legacy-cach=
e-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D74064 */
-"dtlb-store-reference\000legacy cache\000Data TLB write accesses\000legacy=
-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D74156 */
-"dtlb-store-ops\000legacy cache\000Data TLB write accesses\000legacy-cache=
-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D74242 */
-"dtlb-store-access\000legacy cache\000Data TLB write accesses\000legacy-ca=
che-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D74331 */
-"dtlb-store-misses\000legacy cache\000Data TLB write misses\000legacy-cach=
e-config=3D0x10103\000\00000\000\000\000\000\000"
-/* offset=3D74420 */
-"dtlb-store-miss\000legacy cache\000Data TLB write misses\000legacy-cache-=
config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D74507 */
-"dtlb-stores\000legacy cache\000Data TLB write accesses\000legacy-cache-co=
nfig=3D0x103\000\00000\000\000\000\000\000"
-/* offset=3D74590 */
-"dtlb-stores-refs\000legacy cache\000Data TLB write accesses\000legacy-cac=
he-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D74678 */
-"dtlb-stores-reference\000legacy cache\000Data TLB write accesses\000legac=
y-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D74771 */
-"dtlb-stores-ops\000legacy cache\000Data TLB write accesses\000legacy-cach=
e-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D74858 */
-"dtlb-stores-access\000legacy cache\000Data TLB write accesses\000legacy-c=
ache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D74948 */
-"dtlb-stores-misses\000legacy cache\000Data TLB write misses\000legacy-cac=
he-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D75038 */
-"dtlb-stores-miss\000legacy cache\000Data TLB write misses\000legacy-cache=
-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D75126 */
-"dtlb-write\000legacy cache\000Data TLB write accesses\000legacy-cache-con=
fig=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D75208 */
-"dtlb-write-refs\000legacy cache\000Data TLB write accesses\000legacy-cach=
e-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D75295 */
-"dtlb-write-reference\000legacy cache\000Data TLB write accesses\000legacy=
-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D75387 */
-"dtlb-write-ops\000legacy cache\000Data TLB write accesses\000legacy-cache=
-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D75473 */
-"dtlb-write-access\000legacy cache\000Data TLB write accesses\000legacy-ca=
che-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D75562 */
-"dtlb-write-misses\000legacy cache\000Data TLB write misses\000legacy-cach=
e-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D75651 */
-"dtlb-write-miss\000legacy cache\000Data TLB write misses\000legacy-cache-=
config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D75738 */
-"dtlb-prefetch\000legacy cache\000Data TLB prefetch accesses\000legacy-cac=
he-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D75826 */
-"dtlb-prefetch-refs\000legacy cache\000Data TLB prefetch accesses\000legac=
y-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D75919 */
-"dtlb-prefetch-reference\000legacy cache\000Data TLB prefetch accesses\000=
legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D76017 */
-"dtlb-prefetch-ops\000legacy cache\000Data TLB prefetch accesses\000legacy=
-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D76109 */
-"dtlb-prefetch-access\000legacy cache\000Data TLB prefetch accesses\000leg=
acy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D76204 */
-"dtlb-prefetch-misses\000legacy cache\000Data TLB prefetch misses\000legac=
y-cache-config=3D0x10203\000\00000\000\000\000\000\000"
-/* offset=3D76299 */
-"dtlb-prefetch-miss\000legacy cache\000Data TLB prefetch misses\000legacy-=
cache-config=3D0x10203\000\00010\000\000\000\000\000"
-/* offset=3D76392 */
-"dtlb-prefetches\000legacy cache\000Data TLB prefetch accesses\000legacy-c=
ache-config=3D0x203\000\00000\000\000\000\000\000"
-/* offset=3D76482 */
-"dtlb-prefetches-refs\000legacy cache\000Data TLB prefetch accesses\000leg=
acy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D76577 */
-"dtlb-prefetches-reference\000legacy cache\000Data TLB prefetch accesses\0=
00legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D76677 */
-"dtlb-prefetches-ops\000legacy cache\000Data TLB prefetch accesses\000lega=
cy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D76771 */
-"dtlb-prefetches-access\000legacy cache\000Data TLB prefetch accesses\000l=
egacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D76868 */
-"dtlb-prefetches-misses\000legacy cache\000Data TLB prefetch misses\000leg=
acy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
-/* offset=3D76965 */
-"dtlb-prefetches-miss\000legacy cache\000Data TLB prefetch misses\000legac=
y-cache-config=3D0x10203\000\00010\000\000\000\000\000"
-/* offset=3D77060 */
-"dtlb-speculative-read\000legacy cache\000Data TLB prefetch accesses\000le=
gacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D77156 */
-"dtlb-speculative-read-refs\000legacy cache\000Data TLB prefetch accesses\=
000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D77257 */
-"dtlb-speculative-read-reference\000legacy cache\000Data TLB prefetch acce=
sses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D77363 */
-"dtlb-speculative-read-ops\000legacy cache\000Data TLB prefetch accesses\0=
00legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D77463 */
-"dtlb-speculative-read-access\000legacy cache\000Data TLB prefetch accesse=
s\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D77566 */
-"dtlb-speculative-read-misses\000legacy cache\000Data TLB prefetch misses\=
000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
-/* offset=3D77669 */
-"dtlb-speculative-read-miss\000legacy cache\000Data TLB prefetch misses\00=
0legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
-/* offset=3D77770 */
-"dtlb-speculative-load\000legacy cache\000Data TLB prefetch accesses\000le=
gacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D77866 */
-"dtlb-speculative-load-refs\000legacy cache\000Data TLB prefetch accesses\=
000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D77967 */
-"dtlb-speculative-load-reference\000legacy cache\000Data TLB prefetch acce=
sses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D78073 */
-"dtlb-speculative-load-ops\000legacy cache\000Data TLB prefetch accesses\0=
00legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D78173 */
-"dtlb-speculative-load-access\000legacy cache\000Data TLB prefetch accesse=
s\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D78276 */
-"dtlb-speculative-load-misses\000legacy cache\000Data TLB prefetch misses\=
000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
-/* offset=3D78379 */
-"dtlb-speculative-load-miss\000legacy cache\000Data TLB prefetch misses\00=
0legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
-/* offset=3D78480 */
-"dtlb-refs\000legacy cache\000Data TLB read accesses\000legacy-cache-confi=
g=3D3\000\00010\000\000\000\000\000"
-/* offset=3D78556 */
-"dtlb-reference\000legacy cache\000Data TLB read accesses\000legacy-cache-=
config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D78637 */
-"dtlb-ops\000legacy cache\000Data TLB read accesses\000legacy-cache-config=
=3D3\000\00010\000\000\000\000\000"
-/* offset=3D78712 */
-"dtlb-access\000legacy cache\000Data TLB read accesses\000legacy-cache-con=
fig=3D3\000\00010\000\000\000\000\000"
-/* offset=3D78790 */
-"dtlb-misses\000legacy cache\000Data TLB read misses\000legacy-cache-confi=
g=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D78872 */
-"dtlb-miss\000legacy cache\000Data TLB read misses\000legacy-cache-config=
=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D78952 */
+"branches-loads-access\000legacy cache\000Branch prediction unit read acce=
sses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D9609 */
+"branches-loads-miss\000legacy cache\000Branch prediction unit read misses=
\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D9713 */
+"branches-loads-misses\000legacy cache\000Branch prediction unit read miss=
es\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D9819 */
+"branches-loads-ops\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D9918 */
+"branches-loads-reference\000legacy cache\000Branch prediction unit read a=
ccesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D10023 */
+"branches-loads-refs\000legacy cache\000Branch prediction unit read access=
es\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D10123 */
+"branches-miss\000legacy cache\000Branch prediction unit read misses\000le=
gacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D10221 */
+"branches-misses\000legacy cache\000Branch prediction unit read misses\000=
legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D10321 */
+"branches-ops\000legacy cache\000Branch prediction unit read accesses\000l=
egacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D10414 */
+"branches-read\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D10508 */
+"branches-read-access\000legacy cache\000Branch prediction unit read acces=
ses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D10609 */
+"branches-read-miss\000legacy cache\000Branch prediction unit read misses\=
000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D10712 */
+"branches-read-misses\000legacy cache\000Branch prediction unit read misse=
s\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D10817 */
+"branches-read-ops\000legacy cache\000Branch prediction unit read accesses=
\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D10915 */
+"branches-read-reference\000legacy cache\000Branch prediction unit read ac=
cesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D11019 */
+"branches-read-refs\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D11118 */
+"branches-reference\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D11217 */
+"branches-refs\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D11311 */
+"btb\000legacy cache\000Branch prediction unit read accesses\000legacy-cac=
he-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D11395 */
+"btb-access\000legacy cache\000Branch prediction unit read accesses\000leg=
acy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D11486 */
+"btb-load\000legacy cache\000Branch prediction unit read accesses\000legac=
y-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D11575 */
+"btb-load-access\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D11671 */
+"btb-load-miss\000legacy cache\000Branch prediction unit read misses\000le=
gacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D11769 */
+"btb-load-misses\000legacy cache\000Branch prediction unit read misses\000=
legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D11869 */
+"btb-load-ops\000legacy cache\000Branch prediction unit read accesses\000l=
egacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D11962 */
+"btb-load-reference\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D12061 */
+"btb-load-refs\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D12155 */
+"btb-loads\000legacy cache\000Branch prediction unit read accesses\000lega=
cy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D12245 */
+"btb-loads-access\000legacy cache\000Branch prediction unit read accesses\=
000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D12342 */
+"btb-loads-miss\000legacy cache\000Branch prediction unit read misses\000l=
egacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D12441 */
+"btb-loads-misses\000legacy cache\000Branch prediction unit read misses\00=
0legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D12542 */
+"btb-loads-ops\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D12636 */
+"btb-loads-reference\000legacy cache\000Branch prediction unit read access=
es\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D12736 */
+"btb-loads-refs\000legacy cache\000Branch prediction unit read accesses\00=
0legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D12831 */
+"btb-miss\000legacy cache\000Branch prediction unit read misses\000legacy-=
cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D12924 */
+"btb-misses\000legacy cache\000Branch prediction unit read misses\000legac=
y-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D13019 */
+"btb-ops\000legacy cache\000Branch prediction unit read accesses\000legacy=
-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D13107 */
+"btb-read\000legacy cache\000Branch prediction unit read accesses\000legac=
y-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D13196 */
+"btb-read-access\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D13292 */
+"btb-read-miss\000legacy cache\000Branch prediction unit read misses\000le=
gacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D13390 */
+"btb-read-misses\000legacy cache\000Branch prediction unit read misses\000=
legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
+/* offset=3D13490 */
+"btb-read-ops\000legacy cache\000Branch prediction unit read accesses\000l=
egacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D13583 */
+"btb-read-reference\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D13682 */
+"btb-read-refs\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D13776 */
+"btb-reference\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D13870 */
+"btb-refs\000legacy cache\000Branch prediction unit read accesses\000legac=
y-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D13959 */
+"bus-cycles\000legacy hardware\000Bus cycles, which can be different from =
total cycles\000legacy-hardware-config=3D6\000\00000\000\000\000\000\000"
+/* offset=3D14072 */
+"cache-misses\000legacy hardware\000Cache misses. Usually this indicates L=
ast Level Cache misses; this is intended to be used in conjunction with the=
 PERF_COUNT_HW_CACHE_REFERENCES event to calculate cache miss rates\000lega=
cy-hardware-config=3D3\000\00000\000\000\000\000\000"
+/* offset=3D14315 */
+"cache-references\000legacy hardware\000Cache accesses. Usually this indic=
ates Last Level Cache accesses but this may vary depending on your CPU.  Th=
is may include prefetches and coherency messages; again this depends on the=
 design of your CPU\000legacy-hardware-config=3D2\000\00000\000\000\000\000=
\000"
+/* offset=3D14585 */
+"cgroup-switches\000software\000Number of context switches to a task in a =
different cgroup\000config=3D0xb\000\00000\000\000\000\000\000"
+/* offset=3D14688 */
+"context-switches\000software\000Number of context switches [This event is=
 an alias of cs]\000config=3D3\000\00000\000\000\000\000\000"
+/* offset=3D14789 */
+"core_wide\000tool\0001 if not SMT, if SMT are events being gathered on al=
l SMT threads 1 otherwise 0\000config=3D0xd\000\00000\000\000\000\000\000"
+/* offset=3D14903 */
+"cpu-clock\000software\000Per-CPU high-resolution timer based event\000con=
fig=3D0\000\000001e-6msec\000\000\000\000\000"
+/* offset=3D14989 */
+"cpu-cycles\000legacy hardware\000Total cycles. Be wary of what happens du=
ring CPU frequency scaling [This event is an alias of cycles]\000legacy-har=
dware-config=3D0\000\00000\000\000\000\000\000"
+/* offset=3D15151 */
+"cpu-migrations\000software\000Number of times a process has migrated to a=
 new CPU [This event is an alias of migrations]\000config=3D4\000\00000\000=
\000\000\000\000"
+/* offset=3D15283 */
+"cs\000software\000Number of context switches [This event is an alias of c=
ontext-switches]\000config=3D3\000\00000\000\000\000\000\000"
+/* offset=3D15384 */
+"cycles\000legacy hardware\000Total cycles. Be wary of what happens during=
 CPU frequency scaling [This event is an alias of cpu-cycles]\000legacy-har=
dware-config=3D0\000\00000\000\000\000\000\000"
+/* offset=3D15546 */
 "d-tlb\000legacy cache\000Data TLB read accesses\000legacy-cache-config=3D=
3\000\00010\000\000\000\000\000"
-/* offset=3D79024 */
+/* offset=3D15618 */
+"d-tlb-access\000legacy cache\000Data TLB read accesses\000legacy-cache-co=
nfig=3D3\000\00010\000\000\000\000\000"
+/* offset=3D15697 */
 "d-tlb-load\000legacy cache\000Data TLB read accesses\000legacy-cache-conf=
ig=3D3\000\00010\000\000\000\000\000"
-/* offset=3D79101 */
-"d-tlb-load-refs\000legacy cache\000Data TLB read accesses\000legacy-cache=
-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D79183 */
-"d-tlb-load-reference\000legacy cache\000Data TLB read accesses\000legacy-=
cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D79270 */
-"d-tlb-load-ops\000legacy cache\000Data TLB read accesses\000legacy-cache-=
config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D79351 */
+/* offset=3D15774 */
 "d-tlb-load-access\000legacy cache\000Data TLB read accesses\000legacy-cac=
he-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D79435 */
-"d-tlb-load-misses\000legacy cache\000Data TLB read misses\000legacy-cache=
-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D79523 */
+/* offset=3D15858 */
 "d-tlb-load-miss\000legacy cache\000Data TLB read misses\000legacy-cache-c=
onfig=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D79609 */
+/* offset=3D15944 */
+"d-tlb-load-misses\000legacy cache\000Data TLB read misses\000legacy-cache=
-config=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D16032 */
+"d-tlb-load-ops\000legacy cache\000Data TLB read accesses\000legacy-cache-=
config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D16113 */
+"d-tlb-load-reference\000legacy cache\000Data TLB read accesses\000legacy-=
cache-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D16200 */
+"d-tlb-load-refs\000legacy cache\000Data TLB read accesses\000legacy-cache=
-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D16282 */
 "d-tlb-loads\000legacy cache\000Data TLB read accesses\000legacy-cache-con=
fig=3D3\000\00010\000\000\000\000\000"
-/* offset=3D79687 */
-"d-tlb-loads-refs\000legacy cache\000Data TLB read accesses\000legacy-cach=
e-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D79770 */
-"d-tlb-loads-reference\000legacy cache\000Data TLB read accesses\000legacy=
-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D79858 */
-"d-tlb-loads-ops\000legacy cache\000Data TLB read accesses\000legacy-cache=
-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D79940 */
+/* offset=3D16360 */
 "d-tlb-loads-access\000legacy cache\000Data TLB read accesses\000legacy-ca=
che-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D80025 */
-"d-tlb-loads-misses\000legacy cache\000Data TLB read misses\000legacy-cach=
e-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D80114 */
+/* offset=3D16445 */
 "d-tlb-loads-miss\000legacy cache\000Data TLB read misses\000legacy-cache-=
config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D80201 */
+/* offset=3D16532 */
+"d-tlb-loads-misses\000legacy cache\000Data TLB read misses\000legacy-cach=
e-config=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D16621 */
+"d-tlb-loads-ops\000legacy cache\000Data TLB read accesses\000legacy-cache=
-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D16703 */
+"d-tlb-loads-reference\000legacy cache\000Data TLB read accesses\000legacy=
-cache-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D16791 */
+"d-tlb-loads-refs\000legacy cache\000Data TLB read accesses\000legacy-cach=
e-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D16874 */
+"d-tlb-miss\000legacy cache\000Data TLB read misses\000legacy-cache-config=
=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D16955 */
+"d-tlb-misses\000legacy cache\000Data TLB read misses\000legacy-cache-conf=
ig=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D17038 */
+"d-tlb-ops\000legacy cache\000Data TLB read accesses\000legacy-cache-confi=
g=3D3\000\00010\000\000\000\000\000"
+/* offset=3D17114 */
+"d-tlb-prefetch\000legacy cache\000Data TLB prefetch accesses\000legacy-ca=
che-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D17203 */
+"d-tlb-prefetch-access\000legacy cache\000Data TLB prefetch accesses\000le=
gacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D17299 */
+"d-tlb-prefetch-miss\000legacy cache\000Data TLB prefetch misses\000legacy=
-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D17393 */
+"d-tlb-prefetch-misses\000legacy cache\000Data TLB prefetch misses\000lega=
cy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D17489 */
+"d-tlb-prefetch-ops\000legacy cache\000Data TLB prefetch accesses\000legac=
y-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D17582 */
+"d-tlb-prefetch-reference\000legacy cache\000Data TLB prefetch accesses\00=
0legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D17681 */
+"d-tlb-prefetch-refs\000legacy cache\000Data TLB prefetch accesses\000lega=
cy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D17775 */
+"d-tlb-prefetches\000legacy cache\000Data TLB prefetch accesses\000legacy-=
cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D17866 */
+"d-tlb-prefetches-access\000legacy cache\000Data TLB prefetch accesses\000=
legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D17964 */
+"d-tlb-prefetches-miss\000legacy cache\000Data TLB prefetch misses\000lega=
cy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D18060 */
+"d-tlb-prefetches-misses\000legacy cache\000Data TLB prefetch misses\000le=
gacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D18158 */
+"d-tlb-prefetches-ops\000legacy cache\000Data TLB prefetch accesses\000leg=
acy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D18253 */
+"d-tlb-prefetches-reference\000legacy cache\000Data TLB prefetch accesses\=
000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D18354 */
+"d-tlb-prefetches-refs\000legacy cache\000Data TLB prefetch accesses\000le=
gacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D18450 */
 "d-tlb-read\000legacy cache\000Data TLB read accesses\000legacy-cache-conf=
ig=3D3\000\00010\000\000\000\000\000"
-/* offset=3D80278 */
-"d-tlb-read-refs\000legacy cache\000Data TLB read accesses\000legacy-cache=
-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D80360 */
-"d-tlb-read-reference\000legacy cache\000Data TLB read accesses\000legacy-=
cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D80447 */
-"d-tlb-read-ops\000legacy cache\000Data TLB read accesses\000legacy-cache-=
config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D80528 */
+/* offset=3D18527 */
 "d-tlb-read-access\000legacy cache\000Data TLB read accesses\000legacy-cac=
he-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D80612 */
-"d-tlb-read-misses\000legacy cache\000Data TLB read misses\000legacy-cache=
-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D80700 */
+/* offset=3D18611 */
 "d-tlb-read-miss\000legacy cache\000Data TLB read misses\000legacy-cache-c=
onfig=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D80786 */
+/* offset=3D18697 */
+"d-tlb-read-misses\000legacy cache\000Data TLB read misses\000legacy-cache=
-config=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D18785 */
+"d-tlb-read-ops\000legacy cache\000Data TLB read accesses\000legacy-cache-=
config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D18866 */
+"d-tlb-read-reference\000legacy cache\000Data TLB read accesses\000legacy-=
cache-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D18953 */
+"d-tlb-read-refs\000legacy cache\000Data TLB read accesses\000legacy-cache=
-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D19035 */
+"d-tlb-reference\000legacy cache\000Data TLB read accesses\000legacy-cache=
-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D19117 */
+"d-tlb-refs\000legacy cache\000Data TLB read accesses\000legacy-cache-conf=
ig=3D3\000\00010\000\000\000\000\000"
+/* offset=3D19194 */
+"d-tlb-speculative-load\000legacy cache\000Data TLB prefetch accesses\000l=
egacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D19291 */
+"d-tlb-speculative-load-access\000legacy cache\000Data TLB prefetch access=
es\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D19395 */
+"d-tlb-speculative-load-miss\000legacy cache\000Data TLB prefetch misses\0=
00legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D19497 */
+"d-tlb-speculative-load-misses\000legacy cache\000Data TLB prefetch misses=
\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D19601 */
+"d-tlb-speculative-load-ops\000legacy cache\000Data TLB prefetch accesses\=
000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D19702 */
+"d-tlb-speculative-load-reference\000legacy cache\000Data TLB prefetch acc=
esses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D19809 */
+"d-tlb-speculative-load-refs\000legacy cache\000Data TLB prefetch accesses=
\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D19911 */
+"d-tlb-speculative-read\000legacy cache\000Data TLB prefetch accesses\000l=
egacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D20008 */
+"d-tlb-speculative-read-access\000legacy cache\000Data TLB prefetch access=
es\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D20112 */
+"d-tlb-speculative-read-miss\000legacy cache\000Data TLB prefetch misses\0=
00legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D20214 */
+"d-tlb-speculative-read-misses\000legacy cache\000Data TLB prefetch misses=
\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D20318 */
+"d-tlb-speculative-read-ops\000legacy cache\000Data TLB prefetch accesses\=
000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D20419 */
+"d-tlb-speculative-read-reference\000legacy cache\000Data TLB prefetch acc=
esses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D20526 */
+"d-tlb-speculative-read-refs\000legacy cache\000Data TLB prefetch accesses=
\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D20628 */
 "d-tlb-store\000legacy cache\000Data TLB write accesses\000legacy-cache-co=
nfig=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D80869 */
-"d-tlb-store-refs\000legacy cache\000Data TLB write accesses\000legacy-cac=
he-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D80957 */
-"d-tlb-store-reference\000legacy cache\000Data TLB write accesses\000legac=
y-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D81050 */
-"d-tlb-store-ops\000legacy cache\000Data TLB write accesses\000legacy-cach=
e-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D81137 */
+/* offset=3D20711 */
 "d-tlb-store-access\000legacy cache\000Data TLB write accesses\000legacy-c=
ache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D81227 */
-"d-tlb-store-misses\000legacy cache\000Data TLB write misses\000legacy-cac=
he-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D81317 */
+/* offset=3D20801 */
 "d-tlb-store-miss\000legacy cache\000Data TLB write misses\000legacy-cache=
-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D81405 */
+/* offset=3D20889 */
+"d-tlb-store-misses\000legacy cache\000Data TLB write misses\000legacy-cac=
he-config=3D0x10103\000\00010\000\000\000\000\000"
+/* offset=3D20979 */
+"d-tlb-store-ops\000legacy cache\000Data TLB write accesses\000legacy-cach=
e-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D21066 */
+"d-tlb-store-reference\000legacy cache\000Data TLB write accesses\000legac=
y-cache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D21159 */
+"d-tlb-store-refs\000legacy cache\000Data TLB write accesses\000legacy-cac=
he-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D21247 */
 "d-tlb-stores\000legacy cache\000Data TLB write accesses\000legacy-cache-c=
onfig=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D81489 */
-"d-tlb-stores-refs\000legacy cache\000Data TLB write accesses\000legacy-ca=
che-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D81578 */
-"d-tlb-stores-reference\000legacy cache\000Data TLB write accesses\000lega=
cy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D81672 */
-"d-tlb-stores-ops\000legacy cache\000Data TLB write accesses\000legacy-cac=
he-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D81760 */
+/* offset=3D21331 */
 "d-tlb-stores-access\000legacy cache\000Data TLB write accesses\000legacy-=
cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D81851 */
-"d-tlb-stores-misses\000legacy cache\000Data TLB write misses\000legacy-ca=
che-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D81942 */
+/* offset=3D21422 */
 "d-tlb-stores-miss\000legacy cache\000Data TLB write misses\000legacy-cach=
e-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D82031 */
+/* offset=3D21511 */
+"d-tlb-stores-misses\000legacy cache\000Data TLB write misses\000legacy-ca=
che-config=3D0x10103\000\00010\000\000\000\000\000"
+/* offset=3D21602 */
+"d-tlb-stores-ops\000legacy cache\000Data TLB write accesses\000legacy-cac=
he-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D21690 */
+"d-tlb-stores-reference\000legacy cache\000Data TLB write accesses\000lega=
cy-cache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D21784 */
+"d-tlb-stores-refs\000legacy cache\000Data TLB write accesses\000legacy-ca=
che-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D21873 */
 "d-tlb-write\000legacy cache\000Data TLB write accesses\000legacy-cache-co=
nfig=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D82114 */
-"d-tlb-write-refs\000legacy cache\000Data TLB write accesses\000legacy-cac=
he-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D82202 */
-"d-tlb-write-reference\000legacy cache\000Data TLB write accesses\000legac=
y-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D82295 */
-"d-tlb-write-ops\000legacy cache\000Data TLB write accesses\000legacy-cach=
e-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D82382 */
+/* offset=3D21956 */
 "d-tlb-write-access\000legacy cache\000Data TLB write accesses\000legacy-c=
ache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D82472 */
-"d-tlb-write-misses\000legacy cache\000Data TLB write misses\000legacy-cac=
he-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D82562 */
+/* offset=3D22046 */
 "d-tlb-write-miss\000legacy cache\000Data TLB write misses\000legacy-cache=
-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D82650 */
-"d-tlb-prefetch\000legacy cache\000Data TLB prefetch accesses\000legacy-ca=
che-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D82739 */
-"d-tlb-prefetch-refs\000legacy cache\000Data TLB prefetch accesses\000lega=
cy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D82833 */
-"d-tlb-prefetch-reference\000legacy cache\000Data TLB prefetch accesses\00=
0legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D82932 */
-"d-tlb-prefetch-ops\000legacy cache\000Data TLB prefetch accesses\000legac=
y-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D83025 */
-"d-tlb-prefetch-access\000legacy cache\000Data TLB prefetch accesses\000le=
gacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D83121 */
-"d-tlb-prefetch-misses\000legacy cache\000Data TLB prefetch misses\000lega=
cy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
-/* offset=3D83217 */
-"d-tlb-prefetch-miss\000legacy cache\000Data TLB prefetch misses\000legacy=
-cache-config=3D0x10203\000\00010\000\000\000\000\000"
-/* offset=3D83311 */
-"d-tlb-prefetches\000legacy cache\000Data TLB prefetch accesses\000legacy-=
cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D83402 */
-"d-tlb-prefetches-refs\000legacy cache\000Data TLB prefetch accesses\000le=
gacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D83498 */
-"d-tlb-prefetches-reference\000legacy cache\000Data TLB prefetch accesses\=
000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D83599 */
-"d-tlb-prefetches-ops\000legacy cache\000Data TLB prefetch accesses\000leg=
acy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D83694 */
-"d-tlb-prefetches-access\000legacy cache\000Data TLB prefetch accesses\000=
legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D83792 */
-"d-tlb-prefetches-misses\000legacy cache\000Data TLB prefetch misses\000le=
gacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
-/* offset=3D83890 */
-"d-tlb-prefetches-miss\000legacy cache\000Data TLB prefetch misses\000lega=
cy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
-/* offset=3D83986 */
-"d-tlb-speculative-read\000legacy cache\000Data TLB prefetch accesses\000l=
egacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D84083 */
-"d-tlb-speculative-read-refs\000legacy cache\000Data TLB prefetch accesses=
\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D84185 */
-"d-tlb-speculative-read-reference\000legacy cache\000Data TLB prefetch acc=
esses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D84292 */
-"d-tlb-speculative-read-ops\000legacy cache\000Data TLB prefetch accesses\=
000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D84393 */
-"d-tlb-speculative-read-access\000legacy cache\000Data TLB prefetch access=
es\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D84497 */
-"d-tlb-speculative-read-misses\000legacy cache\000Data TLB prefetch misses=
\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
-/* offset=3D84601 */
-"d-tlb-speculative-read-miss\000legacy cache\000Data TLB prefetch misses\0=
00legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
-/* offset=3D84703 */
-"d-tlb-speculative-load\000legacy cache\000Data TLB prefetch accesses\000l=
egacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D84800 */
-"d-tlb-speculative-load-refs\000legacy cache\000Data TLB prefetch accesses=
\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D84902 */
-"d-tlb-speculative-load-reference\000legacy cache\000Data TLB prefetch acc=
esses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D85009 */
-"d-tlb-speculative-load-ops\000legacy cache\000Data TLB prefetch accesses\=
000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D85110 */
-"d-tlb-speculative-load-access\000legacy cache\000Data TLB prefetch access=
es\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D85214 */
-"d-tlb-speculative-load-misses\000legacy cache\000Data TLB prefetch misses=
\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
-/* offset=3D85318 */
-"d-tlb-speculative-load-miss\000legacy cache\000Data TLB prefetch misses\0=
00legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
-/* offset=3D85420 */
-"d-tlb-refs\000legacy cache\000Data TLB read accesses\000legacy-cache-conf=
ig=3D3\000\00010\000\000\000\000\000"
-/* offset=3D85497 */
-"d-tlb-reference\000legacy cache\000Data TLB read accesses\000legacy-cache=
-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D85579 */
-"d-tlb-ops\000legacy cache\000Data TLB read accesses\000legacy-cache-confi=
g=3D3\000\00010\000\000\000\000\000"
-/* offset=3D85655 */
-"d-tlb-access\000legacy cache\000Data TLB read accesses\000legacy-cache-co=
nfig=3D3\000\00010\000\000\000\000\000"
-/* offset=3D85734 */
-"d-tlb-misses\000legacy cache\000Data TLB read misses\000legacy-cache-conf=
ig=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D85817 */
-"d-tlb-miss\000legacy cache\000Data TLB read misses\000legacy-cache-config=
=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D85898 */
+/* offset=3D22134 */
+"d-tlb-write-misses\000legacy cache\000Data TLB write misses\000legacy-cac=
he-config=3D0x10103\000\00010\000\000\000\000\000"
+/* offset=3D22224 */
+"d-tlb-write-ops\000legacy cache\000Data TLB write accesses\000legacy-cach=
e-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D22311 */
+"d-tlb-write-reference\000legacy cache\000Data TLB write accesses\000legac=
y-cache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D22404 */
+"d-tlb-write-refs\000legacy cache\000Data TLB write accesses\000legacy-cac=
he-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D22492 */
 "data-tlb\000legacy cache\000Data TLB read accesses\000legacy-cache-config=
=3D3\000\00010\000\000\000\000\000"
-/* offset=3D85973 */
+/* offset=3D22567 */
+"data-tlb-access\000legacy cache\000Data TLB read accesses\000legacy-cache=
-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D22649 */
 "data-tlb-load\000legacy cache\000Data TLB read accesses\000legacy-cache-c=
onfig=3D3\000\00010\000\000\000\000\000"
-/* offset=3D86053 */
-"data-tlb-load-refs\000legacy cache\000Data TLB read accesses\000legacy-ca=
che-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D86138 */
-"data-tlb-load-reference\000legacy cache\000Data TLB read accesses\000lega=
cy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D86228 */
-"data-tlb-load-ops\000legacy cache\000Data TLB read accesses\000legacy-cac=
he-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D86312 */
+/* offset=3D22729 */
 "data-tlb-load-access\000legacy cache\000Data TLB read accesses\000legacy-=
cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D86399 */
-"data-tlb-load-misses\000legacy cache\000Data TLB read misses\000legacy-ca=
che-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D86490 */
+/* offset=3D22816 */
 "data-tlb-load-miss\000legacy cache\000Data TLB read misses\000legacy-cach=
e-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D86579 */
+/* offset=3D22905 */
+"data-tlb-load-misses\000legacy cache\000Data TLB read misses\000legacy-ca=
che-config=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D22996 */
+"data-tlb-load-ops\000legacy cache\000Data TLB read accesses\000legacy-cac=
he-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D23080 */
+"data-tlb-load-reference\000legacy cache\000Data TLB read accesses\000lega=
cy-cache-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D23170 */
+"data-tlb-load-refs\000legacy cache\000Data TLB read accesses\000legacy-ca=
che-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D23255 */
 "data-tlb-loads\000legacy cache\000Data TLB read accesses\000legacy-cache-=
config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D86660 */
-"data-tlb-loads-refs\000legacy cache\000Data TLB read accesses\000legacy-c=
ache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D86746 */
-"data-tlb-loads-reference\000legacy cache\000Data TLB read accesses\000leg=
acy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D86837 */
-"data-tlb-loads-ops\000legacy cache\000Data TLB read accesses\000legacy-ca=
che-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D86922 */
+/* offset=3D23336 */
 "data-tlb-loads-access\000legacy cache\000Data TLB read accesses\000legacy=
-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D87010 */
-"data-tlb-loads-misses\000legacy cache\000Data TLB read misses\000legacy-c=
ache-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D87102 */
+/* offset=3D23424 */
 "data-tlb-loads-miss\000legacy cache\000Data TLB read misses\000legacy-cac=
he-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D87192 */
+/* offset=3D23514 */
+"data-tlb-loads-misses\000legacy cache\000Data TLB read misses\000legacy-c=
ache-config=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D23606 */
+"data-tlb-loads-ops\000legacy cache\000Data TLB read accesses\000legacy-ca=
che-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D23691 */
+"data-tlb-loads-reference\000legacy cache\000Data TLB read accesses\000leg=
acy-cache-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D23782 */
+"data-tlb-loads-refs\000legacy cache\000Data TLB read accesses\000legacy-c=
ache-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D23868 */
+"data-tlb-miss\000legacy cache\000Data TLB read misses\000legacy-cache-con=
fig=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D23952 */
+"data-tlb-misses\000legacy cache\000Data TLB read misses\000legacy-cache-c=
onfig=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D24038 */
+"data-tlb-ops\000legacy cache\000Data TLB read accesses\000legacy-cache-co=
nfig=3D3\000\00010\000\000\000\000\000"
+/* offset=3D24117 */
+"data-tlb-prefetch\000legacy cache\000Data TLB prefetch accesses\000legacy=
-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D24209 */
+"data-tlb-prefetch-access\000legacy cache\000Data TLB prefetch accesses\00=
0legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D24308 */
+"data-tlb-prefetch-miss\000legacy cache\000Data TLB prefetch misses\000leg=
acy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D24405 */
+"data-tlb-prefetch-misses\000legacy cache\000Data TLB prefetch misses\000l=
egacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D24504 */
+"data-tlb-prefetch-ops\000legacy cache\000Data TLB prefetch accesses\000le=
gacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D24600 */
+"data-tlb-prefetch-reference\000legacy cache\000Data TLB prefetch accesses=
\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D24702 */
+"data-tlb-prefetch-refs\000legacy cache\000Data TLB prefetch accesses\000l=
egacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D24799 */
+"data-tlb-prefetches\000legacy cache\000Data TLB prefetch accesses\000lega=
cy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D24893 */
+"data-tlb-prefetches-access\000legacy cache\000Data TLB prefetch accesses\=
000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D24994 */
+"data-tlb-prefetches-miss\000legacy cache\000Data TLB prefetch misses\000l=
egacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D25093 */
+"data-tlb-prefetches-misses\000legacy cache\000Data TLB prefetch misses\00=
0legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D25194 */
+"data-tlb-prefetches-ops\000legacy cache\000Data TLB prefetch accesses\000=
legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D25292 */
+"data-tlb-prefetches-reference\000legacy cache\000Data TLB prefetch access=
es\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D25396 */
+"data-tlb-prefetches-refs\000legacy cache\000Data TLB prefetch accesses\00=
0legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D25495 */
 "data-tlb-read\000legacy cache\000Data TLB read accesses\000legacy-cache-c=
onfig=3D3\000\00010\000\000\000\000\000"
-/* offset=3D87272 */
-"data-tlb-read-refs\000legacy cache\000Data TLB read accesses\000legacy-ca=
che-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D87357 */
-"data-tlb-read-reference\000legacy cache\000Data TLB read accesses\000lega=
cy-cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D87447 */
-"data-tlb-read-ops\000legacy cache\000Data TLB read accesses\000legacy-cac=
he-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D87531 */
+/* offset=3D25575 */
 "data-tlb-read-access\000legacy cache\000Data TLB read accesses\000legacy-=
cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D87618 */
-"data-tlb-read-misses\000legacy cache\000Data TLB read misses\000legacy-ca=
che-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D87709 */
+/* offset=3D25662 */
 "data-tlb-read-miss\000legacy cache\000Data TLB read misses\000legacy-cach=
e-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D87798 */
+/* offset=3D25751 */
+"data-tlb-read-misses\000legacy cache\000Data TLB read misses\000legacy-ca=
che-config=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D25842 */
+"data-tlb-read-ops\000legacy cache\000Data TLB read accesses\000legacy-cac=
he-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D25926 */
+"data-tlb-read-reference\000legacy cache\000Data TLB read accesses\000lega=
cy-cache-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D26016 */
+"data-tlb-read-refs\000legacy cache\000Data TLB read accesses\000legacy-ca=
che-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D26101 */
+"data-tlb-reference\000legacy cache\000Data TLB read accesses\000legacy-ca=
che-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D26186 */
+"data-tlb-refs\000legacy cache\000Data TLB read accesses\000legacy-cache-c=
onfig=3D3\000\00010\000\000\000\000\000"
+/* offset=3D26266 */
+"data-tlb-speculative-load\000legacy cache\000Data TLB prefetch accesses\0=
00legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D26366 */
+"data-tlb-speculative-load-access\000legacy cache\000Data TLB prefetch acc=
esses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D26473 */
+"data-tlb-speculative-load-miss\000legacy cache\000Data TLB prefetch misse=
s\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D26578 */
+"data-tlb-speculative-load-misses\000legacy cache\000Data TLB prefetch mis=
ses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D26685 */
+"data-tlb-speculative-load-ops\000legacy cache\000Data TLB prefetch access=
es\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D26789 */
+"data-tlb-speculative-load-reference\000legacy cache\000Data TLB prefetch =
accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D26899 */
+"data-tlb-speculative-load-refs\000legacy cache\000Data TLB prefetch acces=
ses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D27004 */
+"data-tlb-speculative-read\000legacy cache\000Data TLB prefetch accesses\0=
00legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D27104 */
+"data-tlb-speculative-read-access\000legacy cache\000Data TLB prefetch acc=
esses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D27211 */
+"data-tlb-speculative-read-miss\000legacy cache\000Data TLB prefetch misse=
s\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D27316 */
+"data-tlb-speculative-read-misses\000legacy cache\000Data TLB prefetch mis=
ses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D27423 */
+"data-tlb-speculative-read-ops\000legacy cache\000Data TLB prefetch access=
es\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D27527 */
+"data-tlb-speculative-read-reference\000legacy cache\000Data TLB prefetch =
accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D27637 */
+"data-tlb-speculative-read-refs\000legacy cache\000Data TLB prefetch acces=
ses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D27742 */
 "data-tlb-store\000legacy cache\000Data TLB write accesses\000legacy-cache=
-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D87884 */
-"data-tlb-store-refs\000legacy cache\000Data TLB write accesses\000legacy-=
cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D87975 */
-"data-tlb-store-reference\000legacy cache\000Data TLB write accesses\000le=
gacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D88071 */
-"data-tlb-store-ops\000legacy cache\000Data TLB write accesses\000legacy-c=
ache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D88161 */
+/* offset=3D27828 */
 "data-tlb-store-access\000legacy cache\000Data TLB write accesses\000legac=
y-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D88254 */
-"data-tlb-store-misses\000legacy cache\000Data TLB write misses\000legacy-=
cache-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D88347 */
+/* offset=3D27921 */
 "data-tlb-store-miss\000legacy cache\000Data TLB write misses\000legacy-ca=
che-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D88438 */
+/* offset=3D28012 */
+"data-tlb-store-misses\000legacy cache\000Data TLB write misses\000legacy-=
cache-config=3D0x10103\000\00010\000\000\000\000\000"
+/* offset=3D28105 */
+"data-tlb-store-ops\000legacy cache\000Data TLB write accesses\000legacy-c=
ache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D28195 */
+"data-tlb-store-reference\000legacy cache\000Data TLB write accesses\000le=
gacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D28291 */
+"data-tlb-store-refs\000legacy cache\000Data TLB write accesses\000legacy-=
cache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D28382 */
 "data-tlb-stores\000legacy cache\000Data TLB write accesses\000legacy-cach=
e-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D88525 */
-"data-tlb-stores-refs\000legacy cache\000Data TLB write accesses\000legacy=
-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D88617 */
-"data-tlb-stores-reference\000legacy cache\000Data TLB write accesses\000l=
egacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D88714 */
-"data-tlb-stores-ops\000legacy cache\000Data TLB write accesses\000legacy-=
cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D88805 */
+/* offset=3D28469 */
 "data-tlb-stores-access\000legacy cache\000Data TLB write accesses\000lega=
cy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D88899 */
-"data-tlb-stores-misses\000legacy cache\000Data TLB write misses\000legacy=
-cache-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D88993 */
+/* offset=3D28563 */
 "data-tlb-stores-miss\000legacy cache\000Data TLB write misses\000legacy-c=
ache-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D89085 */
+/* offset=3D28655 */
+"data-tlb-stores-misses\000legacy cache\000Data TLB write misses\000legacy=
-cache-config=3D0x10103\000\00010\000\000\000\000\000"
+/* offset=3D28749 */
+"data-tlb-stores-ops\000legacy cache\000Data TLB write accesses\000legacy-=
cache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D28840 */
+"data-tlb-stores-reference\000legacy cache\000Data TLB write accesses\000l=
egacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D28937 */
+"data-tlb-stores-refs\000legacy cache\000Data TLB write accesses\000legacy=
-cache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D29029 */
 "data-tlb-write\000legacy cache\000Data TLB write accesses\000legacy-cache=
-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D89171 */
-"data-tlb-write-refs\000legacy cache\000Data TLB write accesses\000legacy-=
cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D89262 */
-"data-tlb-write-reference\000legacy cache\000Data TLB write accesses\000le=
gacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D89358 */
-"data-tlb-write-ops\000legacy cache\000Data TLB write accesses\000legacy-c=
ache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D89448 */
+/* offset=3D29115 */
 "data-tlb-write-access\000legacy cache\000Data TLB write accesses\000legac=
y-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D89541 */
-"data-tlb-write-misses\000legacy cache\000Data TLB write misses\000legacy-=
cache-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D89634 */
+/* offset=3D29208 */
 "data-tlb-write-miss\000legacy cache\000Data TLB write misses\000legacy-ca=
che-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D89725 */
-"data-tlb-prefetch\000legacy cache\000Data TLB prefetch accesses\000legacy=
-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D89817 */
-"data-tlb-prefetch-refs\000legacy cache\000Data TLB prefetch accesses\000l=
egacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D89914 */
-"data-tlb-prefetch-reference\000legacy cache\000Data TLB prefetch accesses=
\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D90016 */
-"data-tlb-prefetch-ops\000legacy cache\000Data TLB prefetch accesses\000le=
gacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D90112 */
-"data-tlb-prefetch-access\000legacy cache\000Data TLB prefetch accesses\00=
0legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D90211 */
-"data-tlb-prefetch-misses\000legacy cache\000Data TLB prefetch misses\000l=
egacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
-/* offset=3D90310 */
-"data-tlb-prefetch-miss\000legacy cache\000Data TLB prefetch misses\000leg=
acy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
-/* offset=3D90407 */
-"data-tlb-prefetches\000legacy cache\000Data TLB prefetch accesses\000lega=
cy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D90501 */
-"data-tlb-prefetches-refs\000legacy cache\000Data TLB prefetch accesses\00=
0legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D90600 */
-"data-tlb-prefetches-reference\000legacy cache\000Data TLB prefetch access=
es\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D90704 */
-"data-tlb-prefetches-ops\000legacy cache\000Data TLB prefetch accesses\000=
legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D90802 */
-"data-tlb-prefetches-access\000legacy cache\000Data TLB prefetch accesses\=
000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D90903 */
-"data-tlb-prefetches-misses\000legacy cache\000Data TLB prefetch misses\00=
0legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
-/* offset=3D91004 */
-"data-tlb-prefetches-miss\000legacy cache\000Data TLB prefetch misses\000l=
egacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
-/* offset=3D91103 */
-"data-tlb-speculative-read\000legacy cache\000Data TLB prefetch accesses\0=
00legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D91203 */
-"data-tlb-speculative-read-refs\000legacy cache\000Data TLB prefetch acces=
ses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D91308 */
-"data-tlb-speculative-read-reference\000legacy cache\000Data TLB prefetch =
accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D91418 */
-"data-tlb-speculative-read-ops\000legacy cache\000Data TLB prefetch access=
es\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D91522 */
-"data-tlb-speculative-read-access\000legacy cache\000Data TLB prefetch acc=
esses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D91629 */
-"data-tlb-speculative-read-misses\000legacy cache\000Data TLB prefetch mis=
ses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
-/* offset=3D91736 */
-"data-tlb-speculative-read-miss\000legacy cache\000Data TLB prefetch misse=
s\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
-/* offset=3D91841 */
-"data-tlb-speculative-load\000legacy cache\000Data TLB prefetch accesses\0=
00legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D91941 */
-"data-tlb-speculative-load-refs\000legacy cache\000Data TLB prefetch acces=
ses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D92046 */
-"data-tlb-speculative-load-reference\000legacy cache\000Data TLB prefetch =
accesses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D92156 */
-"data-tlb-speculative-load-ops\000legacy cache\000Data TLB prefetch access=
es\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D92260 */
-"data-tlb-speculative-load-access\000legacy cache\000Data TLB prefetch acc=
esses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D92367 */
-"data-tlb-speculative-load-misses\000legacy cache\000Data TLB prefetch mis=
ses\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
-/* offset=3D92474 */
-"data-tlb-speculative-load-miss\000legacy cache\000Data TLB prefetch misse=
s\000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
-/* offset=3D92579 */
-"data-tlb-refs\000legacy cache\000Data TLB read accesses\000legacy-cache-c=
onfig=3D3\000\00010\000\000\000\000\000"
-/* offset=3D92659 */
-"data-tlb-reference\000legacy cache\000Data TLB read accesses\000legacy-ca=
che-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D92744 */
-"data-tlb-ops\000legacy cache\000Data TLB read accesses\000legacy-cache-co=
nfig=3D3\000\00010\000\000\000\000\000"
-/* offset=3D92823 */
-"data-tlb-access\000legacy cache\000Data TLB read accesses\000legacy-cache=
-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D92905 */
-"data-tlb-misses\000legacy cache\000Data TLB read misses\000legacy-cache-c=
onfig=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D92991 */
-"data-tlb-miss\000legacy cache\000Data TLB read misses\000legacy-cache-con=
fig=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D93075 */
-"itlb\000legacy cache\000Instruction TLB read accesses\000legacy-cache-con=
fig=3D4\000\00010\000\000\000\000\000"
-/* offset=3D93153 */
-"itlb-load\000legacy cache\000Instruction TLB read accesses\000legacy-cach=
e-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D93236 */
-"itlb-load-refs\000legacy cache\000Instruction TLB read accesses\000legacy=
-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D93324 */
-"itlb-load-reference\000legacy cache\000Instruction TLB read accesses\000l=
egacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D93417 */
-"itlb-load-ops\000legacy cache\000Instruction TLB read accesses\000legacy-=
cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D93504 */
-"itlb-load-access\000legacy cache\000Instruction TLB read accesses\000lega=
cy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D93594 */
-"itlb-load-misses\000legacy cache\000Instruction TLB read misses\000legacy=
-cache-config=3D0x10004\000\00000\000\000\000\000\000"
-/* offset=3D93688 */
-"itlb-load-miss\000legacy cache\000Instruction TLB read misses\000legacy-c=
ache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D93780 */
-"itlb-loads\000legacy cache\000Instruction TLB read accesses\000legacy-cac=
he-config=3D4\000\00000\000\000\000\000\000"
-/* offset=3D93864 */
-"itlb-loads-refs\000legacy cache\000Instruction TLB read accesses\000legac=
y-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D93953 */
-"itlb-loads-reference\000legacy cache\000Instruction TLB read accesses\000=
legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D94047 */
-"itlb-loads-ops\000legacy cache\000Instruction TLB read accesses\000legacy=
-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D94135 */
-"itlb-loads-access\000legacy cache\000Instruction TLB read accesses\000leg=
acy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D94226 */
-"itlb-loads-misses\000legacy cache\000Instruction TLB read misses\000legac=
y-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D94321 */
-"itlb-loads-miss\000legacy cache\000Instruction TLB read misses\000legacy-=
cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D94414 */
-"itlb-read\000legacy cache\000Instruction TLB read accesses\000legacy-cach=
e-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D94497 */
-"itlb-read-refs\000legacy cache\000Instruction TLB read accesses\000legacy=
-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D94585 */
-"itlb-read-reference\000legacy cache\000Instruction TLB read accesses\000l=
egacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D94678 */
-"itlb-read-ops\000legacy cache\000Instruction TLB read accesses\000legacy-=
cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D94765 */
-"itlb-read-access\000legacy cache\000Instruction TLB read accesses\000lega=
cy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D94855 */
-"itlb-read-misses\000legacy cache\000Instruction TLB read misses\000legacy=
-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D94949 */
-"itlb-read-miss\000legacy cache\000Instruction TLB read misses\000legacy-c=
ache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D95041 */
-"itlb-refs\000legacy cache\000Instruction TLB read accesses\000legacy-cach=
e-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D95124 */
-"itlb-reference\000legacy cache\000Instruction TLB read accesses\000legacy=
-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D95212 */
-"itlb-ops\000legacy cache\000Instruction TLB read accesses\000legacy-cache=
-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D95294 */
-"itlb-access\000legacy cache\000Instruction TLB read accesses\000legacy-ca=
che-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D95379 */
-"itlb-misses\000legacy cache\000Instruction TLB read misses\000legacy-cach=
e-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D95468 */
-"itlb-miss\000legacy cache\000Instruction TLB read misses\000legacy-cache-=
config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D95555 */
+/* offset=3D29299 */
+"data-tlb-write-misses\000legacy cache\000Data TLB write misses\000legacy-=
cache-config=3D0x10103\000\00010\000\000\000\000\000"
+/* offset=3D29392 */
+"data-tlb-write-ops\000legacy cache\000Data TLB write accesses\000legacy-c=
ache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D29482 */
+"data-tlb-write-reference\000legacy cache\000Data TLB write accesses\000le=
gacy-cache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D29578 */
+"data-tlb-write-refs\000legacy cache\000Data TLB write accesses\000legacy-=
cache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D29669 */
+"default_core\000"
+/* offset=3D29682 */
+"dispatch_blocked.any\000other\000Memory cluster signals to block micro-op=
 dispatch for any reason\000event=3D9,period=3D200000,umask=3D0x20\000\0000=
0\000\000\000\000\000"
+/* offset=3D29815 */
+"dtlb\000legacy cache\000Data TLB read accesses\000legacy-cache-config=3D3=
\000\00010\000\000\000\000\000"
+/* offset=3D29886 */
+"dtlb-access\000legacy cache\000Data TLB read accesses\000legacy-cache-con=
fig=3D3\000\00010\000\000\000\000\000"
+/* offset=3D29964 */
+"dtlb-load\000legacy cache\000Data TLB read accesses\000legacy-cache-confi=
g=3D3\000\00010\000\000\000\000\000"
+/* offset=3D30040 */
+"dtlb-load-access\000legacy cache\000Data TLB read accesses\000legacy-cach=
e-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D30123 */
+"dtlb-load-miss\000legacy cache\000Data TLB read misses\000legacy-cache-co=
nfig=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D30208 */
+"dtlb-load-misses\000legacy cache\000Data TLB read misses\000legacy-cache-=
config=3D0x10003\000\00000\000\000\000\000\000"
+/* offset=3D30295 */
+"dtlb-load-ops\000legacy cache\000Data TLB read accesses\000legacy-cache-c=
onfig=3D3\000\00010\000\000\000\000\000"
+/* offset=3D30375 */
+"dtlb-load-reference\000legacy cache\000Data TLB read accesses\000legacy-c=
ache-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D30461 */
+"dtlb-load-refs\000legacy cache\000Data TLB read accesses\000legacy-cache-=
config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D30542 */
+"dtlb-loads\000legacy cache\000Data TLB read accesses\000legacy-cache-conf=
ig=3D3\000\00000\000\000\000\000\000"
+/* offset=3D30619 */
+"dtlb-loads-access\000legacy cache\000Data TLB read accesses\000legacy-cac=
he-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D30703 */
+"dtlb-loads-miss\000legacy cache\000Data TLB read misses\000legacy-cache-c=
onfig=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D30789 */
+"dtlb-loads-misses\000legacy cache\000Data TLB read misses\000legacy-cache=
-config=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D30877 */
+"dtlb-loads-ops\000legacy cache\000Data TLB read accesses\000legacy-cache-=
config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D30958 */
+"dtlb-loads-reference\000legacy cache\000Data TLB read accesses\000legacy-=
cache-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D31045 */
+"dtlb-loads-refs\000legacy cache\000Data TLB read accesses\000legacy-cache=
-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D31127 */
+"dtlb-miss\000legacy cache\000Data TLB read misses\000legacy-cache-config=
=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D31207 */
+"dtlb-misses\000legacy cache\000Data TLB read misses\000legacy-cache-confi=
g=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D31289 */
+"dtlb-ops\000legacy cache\000Data TLB read accesses\000legacy-cache-config=
=3D3\000\00010\000\000\000\000\000"
+/* offset=3D31364 */
+"dtlb-prefetch\000legacy cache\000Data TLB prefetch accesses\000legacy-cac=
he-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D31452 */
+"dtlb-prefetch-access\000legacy cache\000Data TLB prefetch accesses\000leg=
acy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D31547 */
+"dtlb-prefetch-miss\000legacy cache\000Data TLB prefetch misses\000legacy-=
cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D31640 */
+"dtlb-prefetch-misses\000legacy cache\000Data TLB prefetch misses\000legac=
y-cache-config=3D0x10203\000\00000\000\000\000\000\000"
+/* offset=3D31735 */
+"dtlb-prefetch-ops\000legacy cache\000Data TLB prefetch accesses\000legacy=
-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D31827 */
+"dtlb-prefetch-reference\000legacy cache\000Data TLB prefetch accesses\000=
legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D31925 */
+"dtlb-prefetch-refs\000legacy cache\000Data TLB prefetch accesses\000legac=
y-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D32018 */
+"dtlb-prefetches\000legacy cache\000Data TLB prefetch accesses\000legacy-c=
ache-config=3D0x203\000\00000\000\000\000\000\000"
+/* offset=3D32108 */
+"dtlb-prefetches-access\000legacy cache\000Data TLB prefetch accesses\000l=
egacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D32205 */
+"dtlb-prefetches-miss\000legacy cache\000Data TLB prefetch misses\000legac=
y-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D32300 */
+"dtlb-prefetches-misses\000legacy cache\000Data TLB prefetch misses\000leg=
acy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D32397 */
+"dtlb-prefetches-ops\000legacy cache\000Data TLB prefetch accesses\000lega=
cy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D32491 */
+"dtlb-prefetches-reference\000legacy cache\000Data TLB prefetch accesses\0=
00legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D32591 */
+"dtlb-prefetches-refs\000legacy cache\000Data TLB prefetch accesses\000leg=
acy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D32686 */
+"dtlb-read\000legacy cache\000Data TLB read accesses\000legacy-cache-confi=
g=3D3\000\00010\000\000\000\000\000"
+/* offset=3D32762 */
+"dtlb-read-access\000legacy cache\000Data TLB read accesses\000legacy-cach=
e-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D32845 */
+"dtlb-read-miss\000legacy cache\000Data TLB read misses\000legacy-cache-co=
nfig=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D32930 */
+"dtlb-read-misses\000legacy cache\000Data TLB read misses\000legacy-cache-=
config=3D0x10003\000\00010\000\000\000\000\000"
+/* offset=3D33017 */
+"dtlb-read-ops\000legacy cache\000Data TLB read accesses\000legacy-cache-c=
onfig=3D3\000\00010\000\000\000\000\000"
+/* offset=3D33097 */
+"dtlb-read-reference\000legacy cache\000Data TLB read accesses\000legacy-c=
ache-config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D33183 */
+"dtlb-read-refs\000legacy cache\000Data TLB read accesses\000legacy-cache-=
config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D33264 */
+"dtlb-reference\000legacy cache\000Data TLB read accesses\000legacy-cache-=
config=3D3\000\00010\000\000\000\000\000"
+/* offset=3D33345 */
+"dtlb-refs\000legacy cache\000Data TLB read accesses\000legacy-cache-confi=
g=3D3\000\00010\000\000\000\000\000"
+/* offset=3D33421 */
+"dtlb-speculative-load\000legacy cache\000Data TLB prefetch accesses\000le=
gacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D33517 */
+"dtlb-speculative-load-access\000legacy cache\000Data TLB prefetch accesse=
s\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D33620 */
+"dtlb-speculative-load-miss\000legacy cache\000Data TLB prefetch misses\00=
0legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D33721 */
+"dtlb-speculative-load-misses\000legacy cache\000Data TLB prefetch misses\=
000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D33824 */
+"dtlb-speculative-load-ops\000legacy cache\000Data TLB prefetch accesses\0=
00legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D33924 */
+"dtlb-speculative-load-reference\000legacy cache\000Data TLB prefetch acce=
sses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D34030 */
+"dtlb-speculative-load-refs\000legacy cache\000Data TLB prefetch accesses\=
000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D34131 */
+"dtlb-speculative-read\000legacy cache\000Data TLB prefetch accesses\000le=
gacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D34227 */
+"dtlb-speculative-read-access\000legacy cache\000Data TLB prefetch accesse=
s\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D34330 */
+"dtlb-speculative-read-miss\000legacy cache\000Data TLB prefetch misses\00=
0legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D34431 */
+"dtlb-speculative-read-misses\000legacy cache\000Data TLB prefetch misses\=
000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
+/* offset=3D34534 */
+"dtlb-speculative-read-ops\000legacy cache\000Data TLB prefetch accesses\0=
00legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D34634 */
+"dtlb-speculative-read-reference\000legacy cache\000Data TLB prefetch acce=
sses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D34740 */
+"dtlb-speculative-read-refs\000legacy cache\000Data TLB prefetch accesses\=
000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
+/* offset=3D34841 */
+"dtlb-store\000legacy cache\000Data TLB write accesses\000legacy-cache-con=
fig=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D34923 */
+"dtlb-store-access\000legacy cache\000Data TLB write accesses\000legacy-ca=
che-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D35012 */
+"dtlb-store-miss\000legacy cache\000Data TLB write misses\000legacy-cache-=
config=3D0x10103\000\00010\000\000\000\000\000"
+/* offset=3D35099 */
+"dtlb-store-misses\000legacy cache\000Data TLB write misses\000legacy-cach=
e-config=3D0x10103\000\00000\000\000\000\000\000"
+/* offset=3D35188 */
+"dtlb-store-ops\000legacy cache\000Data TLB write accesses\000legacy-cache=
-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D35274 */
+"dtlb-store-reference\000legacy cache\000Data TLB write accesses\000legacy=
-cache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D35366 */
+"dtlb-store-refs\000legacy cache\000Data TLB write accesses\000legacy-cach=
e-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D35453 */
+"dtlb-stores\000legacy cache\000Data TLB write accesses\000legacy-cache-co=
nfig=3D0x103\000\00000\000\000\000\000\000"
+/* offset=3D35536 */
+"dtlb-stores-access\000legacy cache\000Data TLB write accesses\000legacy-c=
ache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D35626 */
+"dtlb-stores-miss\000legacy cache\000Data TLB write misses\000legacy-cache=
-config=3D0x10103\000\00010\000\000\000\000\000"
+/* offset=3D35714 */
+"dtlb-stores-misses\000legacy cache\000Data TLB write misses\000legacy-cac=
he-config=3D0x10103\000\00010\000\000\000\000\000"
+/* offset=3D35804 */
+"dtlb-stores-ops\000legacy cache\000Data TLB write accesses\000legacy-cach=
e-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D35891 */
+"dtlb-stores-reference\000legacy cache\000Data TLB write accesses\000legac=
y-cache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D35984 */
+"dtlb-stores-refs\000legacy cache\000Data TLB write accesses\000legacy-cac=
he-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D36072 */
+"dtlb-write\000legacy cache\000Data TLB write accesses\000legacy-cache-con=
fig=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D36154 */
+"dtlb-write-access\000legacy cache\000Data TLB write accesses\000legacy-ca=
che-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D36243 */
+"dtlb-write-miss\000legacy cache\000Data TLB write misses\000legacy-cache-=
config=3D0x10103\000\00010\000\000\000\000\000"
+/* offset=3D36330 */
+"dtlb-write-misses\000legacy cache\000Data TLB write misses\000legacy-cach=
e-config=3D0x10103\000\00010\000\000\000\000\000"
+/* offset=3D36419 */
+"dtlb-write-ops\000legacy cache\000Data TLB write accesses\000legacy-cache=
-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D36505 */
+"dtlb-write-reference\000legacy cache\000Data TLB write accesses\000legacy=
-cache-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D36597 */
+"dtlb-write-refs\000legacy cache\000Data TLB write accesses\000legacy-cach=
e-config=3D0x103\000\00010\000\000\000\000\000"
+/* offset=3D36684 */
+"dummy\000software\000A placeholder event that doesn't count anything\000c=
onfig=3D9\000\00000\000\000\000\000\000"
+/* offset=3D36764 */
+"duration_time\000tool\000Wall clock interval time in nanoseconds\000confi=
g=3D1\000\00000\000\000\000\000\000"
+/* offset=3D36840 */
+"eist_trans\000other\000Number of Enhanced Intel SpeedStep(R) Technology (=
EIST) transitions\000event=3D0x3a,period=3D200000\000\00000\000\000\000\000=
\000"
+/* offset=3D36958 */
+"emulation-faults\000software\000Number of kernel handled unimplemented in=
struction faults handled through emulation\000config=3D8\000\00000\000\000\=
000\000\000"
+/* offset=3D37085 */
+"event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\000\00000\000\00=
0\000\000\000"
+/* offset=3D37139 */
+"event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0xc0\000\00000\00=
0\000\000\000\000"
+/* offset=3D37197 */
+"faults\000software\000Number of page faults [This event is an alias of pa=
ge-faults]\000config=3D2\000\00000\000\000\000\000\000"
+/* offset=3D37292 */
+"has_pmem\000tool\0001 if persistent memory installed otherwise 0\000confi=
g=3D4\000\00000\000\000\000\000\000"
+/* offset=3D37368 */
+"hisi_sccl,ddrc\000"
+/* offset=3D37383 */
+"hisi_sccl,l3c\000"
+/* offset=3D37397 */
 "i-tlb\000legacy cache\000Instruction TLB read accesses\000legacy-cache-co=
nfig=3D4\000\00010\000\000\000\000\000"
-/* offset=3D95634 */
+/* offset=3D37476 */
+"i-tlb-access\000legacy cache\000Instruction TLB read accesses\000legacy-c=
ache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D37562 */
 "i-tlb-load\000legacy cache\000Instruction TLB read accesses\000legacy-cac=
he-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D95718 */
-"i-tlb-load-refs\000legacy cache\000Instruction TLB read accesses\000legac=
y-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D95807 */
-"i-tlb-load-reference\000legacy cache\000Instruction TLB read accesses\000=
legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D95901 */
-"i-tlb-load-ops\000legacy cache\000Instruction TLB read accesses\000legacy=
-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D95989 */
+/* offset=3D37646 */
 "i-tlb-load-access\000legacy cache\000Instruction TLB read accesses\000leg=
acy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D96080 */
-"i-tlb-load-misses\000legacy cache\000Instruction TLB read misses\000legac=
y-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D96175 */
+/* offset=3D37737 */
 "i-tlb-load-miss\000legacy cache\000Instruction TLB read misses\000legacy-=
cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D96268 */
+/* offset=3D37830 */
+"i-tlb-load-misses\000legacy cache\000Instruction TLB read misses\000legac=
y-cache-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D37925 */
+"i-tlb-load-ops\000legacy cache\000Instruction TLB read accesses\000legacy=
-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D38013 */
+"i-tlb-load-reference\000legacy cache\000Instruction TLB read accesses\000=
legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D38107 */
+"i-tlb-load-refs\000legacy cache\000Instruction TLB read accesses\000legac=
y-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D38196 */
 "i-tlb-loads\000legacy cache\000Instruction TLB read accesses\000legacy-ca=
che-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D96353 */
-"i-tlb-loads-refs\000legacy cache\000Instruction TLB read accesses\000lega=
cy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D96443 */
-"i-tlb-loads-reference\000legacy cache\000Instruction TLB read accesses\00=
0legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D96538 */
-"i-tlb-loads-ops\000legacy cache\000Instruction TLB read accesses\000legac=
y-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D96627 */
+/* offset=3D38281 */
 "i-tlb-loads-access\000legacy cache\000Instruction TLB read accesses\000le=
gacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D96719 */
-"i-tlb-loads-misses\000legacy cache\000Instruction TLB read misses\000lega=
cy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D96815 */
+/* offset=3D38373 */
 "i-tlb-loads-miss\000legacy cache\000Instruction TLB read misses\000legacy=
-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D96909 */
+/* offset=3D38467 */
+"i-tlb-loads-misses\000legacy cache\000Instruction TLB read misses\000lega=
cy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D38563 */
+"i-tlb-loads-ops\000legacy cache\000Instruction TLB read accesses\000legac=
y-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D38652 */
+"i-tlb-loads-reference\000legacy cache\000Instruction TLB read accesses\00=
0legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D38747 */
+"i-tlb-loads-refs\000legacy cache\000Instruction TLB read accesses\000lega=
cy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D38837 */
+"i-tlb-miss\000legacy cache\000Instruction TLB read misses\000legacy-cache=
-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D38925 */
+"i-tlb-misses\000legacy cache\000Instruction TLB read misses\000legacy-cac=
he-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D39015 */
+"i-tlb-ops\000legacy cache\000Instruction TLB read accesses\000legacy-cach=
e-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D39098 */
 "i-tlb-read\000legacy cache\000Instruction TLB read accesses\000legacy-cac=
he-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D96993 */
-"i-tlb-read-refs\000legacy cache\000Instruction TLB read accesses\000legac=
y-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D97082 */
-"i-tlb-read-reference\000legacy cache\000Instruction TLB read accesses\000=
legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D97176 */
-"i-tlb-read-ops\000legacy cache\000Instruction TLB read accesses\000legacy=
-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D97264 */
+/* offset=3D39182 */
 "i-tlb-read-access\000legacy cache\000Instruction TLB read accesses\000leg=
acy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D97355 */
-"i-tlb-read-misses\000legacy cache\000Instruction TLB read misses\000legac=
y-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D97450 */
+/* offset=3D39273 */
 "i-tlb-read-miss\000legacy cache\000Instruction TLB read misses\000legacy-=
cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D97543 */
-"i-tlb-refs\000legacy cache\000Instruction TLB read accesses\000legacy-cac=
he-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D97627 */
+/* offset=3D39366 */
+"i-tlb-read-misses\000legacy cache\000Instruction TLB read misses\000legac=
y-cache-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D39461 */
+"i-tlb-read-ops\000legacy cache\000Instruction TLB read accesses\000legacy=
-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D39549 */
+"i-tlb-read-reference\000legacy cache\000Instruction TLB read accesses\000=
legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D39643 */
+"i-tlb-read-refs\000legacy cache\000Instruction TLB read accesses\000legac=
y-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D39732 */
 "i-tlb-reference\000legacy cache\000Instruction TLB read accesses\000legac=
y-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D97716 */
-"i-tlb-ops\000legacy cache\000Instruction TLB read accesses\000legacy-cach=
e-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D97799 */
-"i-tlb-access\000legacy cache\000Instruction TLB read accesses\000legacy-c=
ache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D97885 */
-"i-tlb-misses\000legacy cache\000Instruction TLB read misses\000legacy-cac=
he-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D97975 */
-"i-tlb-miss\000legacy cache\000Instruction TLB read misses\000legacy-cache=
-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D98063 */
+/* offset=3D39821 */
+"i-tlb-refs\000legacy cache\000Instruction TLB read accesses\000legacy-cac=
he-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D39905 */
+"idle-cycles-backend\000legacy hardware\000Stalled cycles during retiremen=
t [This event is an alias of stalled-cycles-backend]\000legacy-hardware-con=
fig=3D8\000\00000\000\000\000\000\000"
+/* offset=3D40058 */
+"idle-cycles-frontend\000legacy hardware\000Stalled cycles during issue [T=
his event is an alias of stalled-cycles-frontend]\000legacy-hardware-config=
=3D7\000\00000\000\000\000\000\000"
+/* offset=3D40208 */
 "instruction-tlb\000legacy cache\000Instruction TLB read accesses\000legac=
y-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D98152 */
+/* offset=3D40297 */
+"instruction-tlb-access\000legacy cache\000Instruction TLB read accesses\0=
00legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D40393 */
 "instruction-tlb-load\000legacy cache\000Instruction TLB read accesses\000=
legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D98246 */
-"instruction-tlb-load-refs\000legacy cache\000Instruction TLB read accesse=
s\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D98345 */
-"instruction-tlb-load-reference\000legacy cache\000Instruction TLB read ac=
cesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D98449 */
-"instruction-tlb-load-ops\000legacy cache\000Instruction TLB read accesses=
\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D98547 */
+/* offset=3D40487 */
 "instruction-tlb-load-access\000legacy cache\000Instruction TLB read acces=
ses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D98648 */
-"instruction-tlb-load-misses\000legacy cache\000Instruction TLB read misse=
s\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D98753 */
+/* offset=3D40588 */
 "instruction-tlb-load-miss\000legacy cache\000Instruction TLB read misses\=
000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D98856 */
+/* offset=3D40691 */
+"instruction-tlb-load-misses\000legacy cache\000Instruction TLB read misse=
s\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D40796 */
+"instruction-tlb-load-ops\000legacy cache\000Instruction TLB read accesses=
\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D40894 */
+"instruction-tlb-load-reference\000legacy cache\000Instruction TLB read ac=
cesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D40998 */
+"instruction-tlb-load-refs\000legacy cache\000Instruction TLB read accesse=
s\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D41097 */
 "instruction-tlb-loads\000legacy cache\000Instruction TLB read accesses\00=
0legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D98951 */
-"instruction-tlb-loads-refs\000legacy cache\000Instruction TLB read access=
es\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D99051 */
-"instruction-tlb-loads-reference\000legacy cache\000Instruction TLB read a=
ccesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D99156 */
-"instruction-tlb-loads-ops\000legacy cache\000Instruction TLB read accesse=
s\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D99255 */
+/* offset=3D41192 */
 "instruction-tlb-loads-access\000legacy cache\000Instruction TLB read acce=
sses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D99357 */
-"instruction-tlb-loads-misses\000legacy cache\000Instruction TLB read miss=
es\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D99463 */
+/* offset=3D41294 */
 "instruction-tlb-loads-miss\000legacy cache\000Instruction TLB read misses=
\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D99567 */
+/* offset=3D41398 */
+"instruction-tlb-loads-misses\000legacy cache\000Instruction TLB read miss=
es\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D41504 */
+"instruction-tlb-loads-ops\000legacy cache\000Instruction TLB read accesse=
s\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D41603 */
+"instruction-tlb-loads-reference\000legacy cache\000Instruction TLB read a=
ccesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D41708 */
+"instruction-tlb-loads-refs\000legacy cache\000Instruction TLB read access=
es\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D41808 */
+"instruction-tlb-miss\000legacy cache\000Instruction TLB read misses\000le=
gacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D41906 */
+"instruction-tlb-misses\000legacy cache\000Instruction TLB read misses\000=
legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D42006 */
+"instruction-tlb-ops\000legacy cache\000Instruction TLB read accesses\000l=
egacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D42099 */
 "instruction-tlb-read\000legacy cache\000Instruction TLB read accesses\000=
legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D99661 */
-"instruction-tlb-read-refs\000legacy cache\000Instruction TLB read accesse=
s\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D99760 */
-"instruction-tlb-read-reference\000legacy cache\000Instruction TLB read ac=
cesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D99864 */
-"instruction-tlb-read-ops\000legacy cache\000Instruction TLB read accesses=
\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D99962 */
+/* offset=3D42193 */
 "instruction-tlb-read-access\000legacy cache\000Instruction TLB read acces=
ses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D100063 */
-"instruction-tlb-read-misses\000legacy cache\000Instruction TLB read misse=
s\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D100168 */
+/* offset=3D42294 */
 "instruction-tlb-read-miss\000legacy cache\000Instruction TLB read misses\=
000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D100271 */
-"instruction-tlb-refs\000legacy cache\000Instruction TLB read accesses\000=
legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D100365 */
-"instruction-tlb-reference\000legacy cache\000Instruction TLB read accesse=
s\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D100464 */
-"instruction-tlb-ops\000legacy cache\000Instruction TLB read accesses\000l=
egacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D100557 */
-"instruction-tlb-access\000legacy cache\000Instruction TLB read accesses\0=
00legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D100653 */
-"instruction-tlb-misses\000legacy cache\000Instruction TLB read misses\000=
legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D100753 */
-"instruction-tlb-miss\000legacy cache\000Instruction TLB read misses\000le=
gacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D100851 */
-"branch\000legacy cache\000Branch prediction unit read accesses\000legacy-=
cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D100938 */
-"branch-load\000legacy cache\000Branch prediction unit read accesses\000le=
gacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D101030 */
-"branch-load-refs\000legacy cache\000Branch prediction unit read accesses\=
000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D101127 */
-"branch-load-reference\000legacy cache\000Branch prediction unit read acce=
sses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D101229 */
-"branch-load-ops\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D101325 */
-"branch-load-access\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D101424 */
-"branch-load-misses\000legacy cache\000Branch prediction unit read misses\=
000legacy-cache-config=3D0x10005\000\00000\000\000\000\000\000"
-/* offset=3D101527 */
-"branch-load-miss\000legacy cache\000Branch prediction unit read misses\00=
0legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D101628 */
-"branch-loads\000legacy cache\000Branch prediction unit read accesses\000l=
egacy-cache-config=3D5\000\00000\000\000\000\000\000"
-/* offset=3D101721 */
-"branch-loads-refs\000legacy cache\000Branch prediction unit read accesses=
\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D101819 */
-"branch-loads-reference\000legacy cache\000Branch prediction unit read acc=
esses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D101922 */
-"branch-loads-ops\000legacy cache\000Branch prediction unit read accesses\=
000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D102019 */
-"branch-loads-access\000legacy cache\000Branch prediction unit read access=
es\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D102119 */
-"branch-loads-misses\000legacy cache\000Branch prediction unit read misses=
\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D102223 */
-"branch-loads-miss\000legacy cache\000Branch prediction unit read misses\0=
00legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D102325 */
-"branch-read\000legacy cache\000Branch prediction unit read accesses\000le=
gacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D102417 */
-"branch-read-refs\000legacy cache\000Branch prediction unit read accesses\=
000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D102514 */
-"branch-read-reference\000legacy cache\000Branch prediction unit read acce=
sses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D102616 */
-"branch-read-ops\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D102712 */
-"branch-read-access\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D102811 */
-"branch-read-misses\000legacy cache\000Branch prediction unit read misses\=
000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D102914 */
-"branch-read-miss\000legacy cache\000Branch prediction unit read misses\00=
0legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D103015 */
-"branch-refs\000legacy cache\000Branch prediction unit read accesses\000le=
gacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D103107 */
-"branch-reference\000legacy cache\000Branch prediction unit read accesses\=
000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D103204 */
-"branch-ops\000legacy cache\000Branch prediction unit read accesses\000leg=
acy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D103295 */
-"branch-access\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D103389 */
-"branch-miss\000legacy cache\000Branch prediction unit read misses\000lega=
cy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D103485 */
-"branches-load\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D103579 */
-"branches-load-refs\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D103678 */
-"branches-load-reference\000legacy cache\000Branch prediction unit read ac=
cesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D103782 */
-"branches-load-ops\000legacy cache\000Branch prediction unit read accesses=
\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D103880 */
-"branches-load-access\000legacy cache\000Branch prediction unit read acces=
ses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D103981 */
-"branches-load-misses\000legacy cache\000Branch prediction unit read misse=
s\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D104086 */
-"branches-load-miss\000legacy cache\000Branch prediction unit read misses\=
000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D104189 */
-"branches-loads\000legacy cache\000Branch prediction unit read accesses\00=
0legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D104284 */
-"branches-loads-refs\000legacy cache\000Branch prediction unit read access=
es\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D104384 */
-"branches-loads-reference\000legacy cache\000Branch prediction unit read a=
ccesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D104489 */
-"branches-loads-ops\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D104588 */
-"branches-loads-access\000legacy cache\000Branch prediction unit read acce=
sses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D104690 */
-"branches-loads-misses\000legacy cache\000Branch prediction unit read miss=
es\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D104796 */
-"branches-loads-miss\000legacy cache\000Branch prediction unit read misses=
\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D104900 */
-"branches-read\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D104994 */
-"branches-read-refs\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D105093 */
-"branches-read-reference\000legacy cache\000Branch prediction unit read ac=
cesses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D105197 */
-"branches-read-ops\000legacy cache\000Branch prediction unit read accesses=
\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D105295 */
-"branches-read-access\000legacy cache\000Branch prediction unit read acces=
ses\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D105396 */
-"branches-read-misses\000legacy cache\000Branch prediction unit read misse=
s\000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D105501 */
-"branches-read-miss\000legacy cache\000Branch prediction unit read misses\=
000legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D105604 */
-"branches-refs\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D105698 */
-"branches-reference\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D105797 */
-"branches-ops\000legacy cache\000Branch prediction unit read accesses\000l=
egacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D105890 */
-"branches-access\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D105986 */
-"branches-misses\000legacy cache\000Branch prediction unit read misses\000=
legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D106086 */
-"branches-miss\000legacy cache\000Branch prediction unit read misses\000le=
gacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D106184 */
-"bpu\000legacy cache\000Branch prediction unit read accesses\000legacy-cac=
he-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D106268 */
-"bpu-load\000legacy cache\000Branch prediction unit read accesses\000legac=
y-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D106357 */
-"bpu-load-refs\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D106451 */
-"bpu-load-reference\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D106550 */
-"bpu-load-ops\000legacy cache\000Branch prediction unit read accesses\000l=
egacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D106643 */
-"bpu-load-access\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D106739 */
-"bpu-load-misses\000legacy cache\000Branch prediction unit read misses\000=
legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D106839 */
-"bpu-load-miss\000legacy cache\000Branch prediction unit read misses\000le=
gacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D106937 */
-"bpu-loads\000legacy cache\000Branch prediction unit read accesses\000lega=
cy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D107027 */
-"bpu-loads-refs\000legacy cache\000Branch prediction unit read accesses\00=
0legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D107122 */
-"bpu-loads-reference\000legacy cache\000Branch prediction unit read access=
es\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D107222 */
-"bpu-loads-ops\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D107316 */
-"bpu-loads-access\000legacy cache\000Branch prediction unit read accesses\=
000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D107413 */
-"bpu-loads-misses\000legacy cache\000Branch prediction unit read misses\00=
0legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D107514 */
-"bpu-loads-miss\000legacy cache\000Branch prediction unit read misses\000l=
egacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D107613 */
-"bpu-read\000legacy cache\000Branch prediction unit read accesses\000legac=
y-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D107702 */
-"bpu-read-refs\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D107796 */
-"bpu-read-reference\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D107895 */
-"bpu-read-ops\000legacy cache\000Branch prediction unit read accesses\000l=
egacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D107988 */
-"bpu-read-access\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D108084 */
-"bpu-read-misses\000legacy cache\000Branch prediction unit read misses\000=
legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D108184 */
-"bpu-read-miss\000legacy cache\000Branch prediction unit read misses\000le=
gacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D108282 */
-"bpu-refs\000legacy cache\000Branch prediction unit read accesses\000legac=
y-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D108371 */
-"bpu-reference\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D108465 */
-"bpu-ops\000legacy cache\000Branch prediction unit read accesses\000legacy=
-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D108553 */
-"bpu-access\000legacy cache\000Branch prediction unit read accesses\000leg=
acy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D108644 */
-"bpu-misses\000legacy cache\000Branch prediction unit read misses\000legac=
y-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D108739 */
-"bpu-miss\000legacy cache\000Branch prediction unit read misses\000legacy-=
cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D108832 */
-"btb\000legacy cache\000Branch prediction unit read accesses\000legacy-cac=
he-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D108916 */
-"btb-load\000legacy cache\000Branch prediction unit read accesses\000legac=
y-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D109005 */
-"btb-load-refs\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D109099 */
-"btb-load-reference\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D109198 */
-"btb-load-ops\000legacy cache\000Branch prediction unit read accesses\000l=
egacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D109291 */
-"btb-load-access\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D109387 */
-"btb-load-misses\000legacy cache\000Branch prediction unit read misses\000=
legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D109487 */
-"btb-load-miss\000legacy cache\000Branch prediction unit read misses\000le=
gacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D109585 */
-"btb-loads\000legacy cache\000Branch prediction unit read accesses\000lega=
cy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D109675 */
-"btb-loads-refs\000legacy cache\000Branch prediction unit read accesses\00=
0legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D109770 */
-"btb-loads-reference\000legacy cache\000Branch prediction unit read access=
es\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D109870 */
-"btb-loads-ops\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D109964 */
-"btb-loads-access\000legacy cache\000Branch prediction unit read accesses\=
000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D110061 */
-"btb-loads-misses\000legacy cache\000Branch prediction unit read misses\00=
0legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D110162 */
-"btb-loads-miss\000legacy cache\000Branch prediction unit read misses\000l=
egacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D110261 */
-"btb-read\000legacy cache\000Branch prediction unit read accesses\000legac=
y-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D110350 */
-"btb-read-refs\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D110444 */
-"btb-read-reference\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D110543 */
-"btb-read-ops\000legacy cache\000Branch prediction unit read accesses\000l=
egacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D110636 */
-"btb-read-access\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D110732 */
-"btb-read-misses\000legacy cache\000Branch prediction unit read misses\000=
legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D110832 */
-"btb-read-miss\000legacy cache\000Branch prediction unit read misses\000le=
gacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D110930 */
-"btb-refs\000legacy cache\000Branch prediction unit read accesses\000legac=
y-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D111019 */
-"btb-reference\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D111113 */
-"btb-ops\000legacy cache\000Branch prediction unit read accesses\000legacy=
-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D111201 */
-"btb-access\000legacy cache\000Branch prediction unit read accesses\000leg=
acy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D111292 */
-"btb-misses\000legacy cache\000Branch prediction unit read misses\000legac=
y-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D111387 */
-"btb-miss\000legacy cache\000Branch prediction unit read misses\000legacy-=
cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D111480 */
-"bpc\000legacy cache\000Branch prediction unit read accesses\000legacy-cac=
he-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D111564 */
-"bpc-load\000legacy cache\000Branch prediction unit read accesses\000legac=
y-cache-config=3D5\000\00010\000\000\000\000\000"
+/* offset=3D42397 */
+"instruction-tlb-read-misses\000legacy cache\000Instruction TLB read misse=
s\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D42502 */
+"instruction-tlb-read-ops\000legacy cache\000Instruction TLB read accesses=
\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D42600 */
+"instruction-tlb-read-reference\000legacy cache\000Instruction TLB read ac=
cesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D42704 */
+"instruction-tlb-read-refs\000legacy cache\000Instruction TLB read accesse=
s\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D42803 */
+"instruction-tlb-reference\000legacy cache\000Instruction TLB read accesse=
s\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D42902 */
+"instruction-tlb-refs\000legacy cache\000Instruction TLB read accesses\000=
legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D42996 */
+"instructions\000legacy hardware\000Retired instructions. Be careful, thes=
e can be affected by various issues, most notably hardware interrupt counts=
\000legacy-hardware-config=3D1\000\00000\000\000\000\000\000"
+/* offset=3D43172 */
+"itlb\000legacy cache\000Instruction TLB read accesses\000legacy-cache-con=
fig=3D4\000\00010\000\000\000\000\000"
+/* offset=3D43250 */
+"itlb-access\000legacy cache\000Instruction TLB read accesses\000legacy-ca=
che-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D43335 */
+"itlb-load\000legacy cache\000Instruction TLB read accesses\000legacy-cach=
e-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D43418 */
+"itlb-load-access\000legacy cache\000Instruction TLB read accesses\000lega=
cy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D43508 */
+"itlb-load-miss\000legacy cache\000Instruction TLB read misses\000legacy-c=
ache-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D43600 */
+"itlb-load-misses\000legacy cache\000Instruction TLB read misses\000legacy=
-cache-config=3D0x10004\000\00000\000\000\000\000\000"
+/* offset=3D43694 */
+"itlb-load-ops\000legacy cache\000Instruction TLB read accesses\000legacy-=
cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D43781 */
+"itlb-load-reference\000legacy cache\000Instruction TLB read accesses\000l=
egacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D43874 */
+"itlb-load-refs\000legacy cache\000Instruction TLB read accesses\000legacy=
-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D43962 */
+"itlb-loads\000legacy cache\000Instruction TLB read accesses\000legacy-cac=
he-config=3D4\000\00000\000\000\000\000\000"
+/* offset=3D44046 */
+"itlb-loads-access\000legacy cache\000Instruction TLB read accesses\000leg=
acy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D44137 */
+"itlb-loads-miss\000legacy cache\000Instruction TLB read misses\000legacy-=
cache-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D44230 */
+"itlb-loads-misses\000legacy cache\000Instruction TLB read misses\000legac=
y-cache-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D44325 */
+"itlb-loads-ops\000legacy cache\000Instruction TLB read accesses\000legacy=
-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D44413 */
+"itlb-loads-reference\000legacy cache\000Instruction TLB read accesses\000=
legacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D44507 */
+"itlb-loads-refs\000legacy cache\000Instruction TLB read accesses\000legac=
y-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D44596 */
+"itlb-miss\000legacy cache\000Instruction TLB read misses\000legacy-cache-=
config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D44683 */
+"itlb-misses\000legacy cache\000Instruction TLB read misses\000legacy-cach=
e-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D44772 */
+"itlb-ops\000legacy cache\000Instruction TLB read accesses\000legacy-cache=
-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D44854 */
+"itlb-read\000legacy cache\000Instruction TLB read accesses\000legacy-cach=
e-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D44937 */
+"itlb-read-access\000legacy cache\000Instruction TLB read accesses\000lega=
cy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D45027 */
+"itlb-read-miss\000legacy cache\000Instruction TLB read misses\000legacy-c=
ache-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D45119 */
+"itlb-read-misses\000legacy cache\000Instruction TLB read misses\000legacy=
-cache-config=3D0x10004\000\00010\000\000\000\000\000"
+/* offset=3D45213 */
+"itlb-read-ops\000legacy cache\000Instruction TLB read accesses\000legacy-=
cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D45300 */
+"itlb-read-reference\000legacy cache\000Instruction TLB read accesses\000l=
egacy-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D45393 */
+"itlb-read-refs\000legacy cache\000Instruction TLB read accesses\000legacy=
-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D45481 */
+"itlb-reference\000legacy cache\000Instruction TLB read accesses\000legacy=
-cache-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D45569 */
+"itlb-refs\000legacy cache\000Instruction TLB read accesses\000legacy-cach=
e-config=3D4\000\00010\000\000\000\000\000"
+/* offset=3D45652 */
+"l1-d\000legacy cache\000Level 1 data cache read accesses\000legacy-cache-=
config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D45733 */
+"l1-d-access\000legacy cache\000Level 1 data cache read accesses\000legacy=
-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D45821 */
+"l1-d-load\000legacy cache\000Level 1 data cache read accesses\000legacy-c=
ache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D45907 */
+"l1-d-load-access\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D46000 */
+"l1-d-load-miss\000legacy cache\000Level 1 data cache read misses\000legac=
y-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D46095 */
+"l1-d-load-misses\000legacy cache\000Level 1 data cache read misses\000leg=
acy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D46192 */
+"l1-d-load-ops\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D46282 */
+"l1-d-load-reference\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D46378 */
+"l1-d-load-refs\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D46469 */
+"l1-d-loads\000legacy cache\000Level 1 data cache read accesses\000legacy-=
cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D46556 */
+"l1-d-loads-access\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D46650 */
+"l1-d-loads-miss\000legacy cache\000Level 1 data cache read misses\000lega=
cy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D46746 */
+"l1-d-loads-misses\000legacy cache\000Level 1 data cache read misses\000le=
gacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D46844 */
+"l1-d-loads-ops\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D46935 */
+"l1-d-loads-reference\000legacy cache\000Level 1 data cache read accesses\=
000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D47032 */
+"l1-d-loads-refs\000legacy cache\000Level 1 data cache read accesses\000le=
gacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D47124 */
+"l1-d-miss\000legacy cache\000Level 1 data cache read misses\000legacy-cac=
he-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D47214 */
+"l1-d-misses\000legacy cache\000Level 1 data cache read misses\000legacy-c=
ache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D47306 */
+"l1-d-ops\000legacy cache\000Level 1 data cache read accesses\000legacy-ca=
che-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D47391 */
+"l1-d-prefetch\000legacy cache\000Level 1 data cache prefetch accesses\000=
legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D47489 */
+"l1-d-prefetch-access\000legacy cache\000Level 1 data cache prefetch acces=
ses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D47594 */
+"l1-d-prefetch-miss\000legacy cache\000Level 1 data cache prefetch misses\=
000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D47697 */
+"l1-d-prefetch-misses\000legacy cache\000Level 1 data cache prefetch misse=
s\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D47802 */
+"l1-d-prefetch-ops\000legacy cache\000Level 1 data cache prefetch accesses=
\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D47904 */
+"l1-d-prefetch-reference\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D48012 */
+"l1-d-prefetch-refs\000legacy cache\000Level 1 data cache prefetch accesse=
s\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D48115 */
+"l1-d-prefetches\000legacy cache\000Level 1 data cache prefetch accesses\0=
00legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D48215 */
+"l1-d-prefetches-access\000legacy cache\000Level 1 data cache prefetch acc=
esses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D48322 */
+"l1-d-prefetches-miss\000legacy cache\000Level 1 data cache prefetch misse=
s\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D48427 */
+"l1-d-prefetches-misses\000legacy cache\000Level 1 data cache prefetch mis=
ses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D48534 */
+"l1-d-prefetches-ops\000legacy cache\000Level 1 data cache prefetch access=
es\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D48638 */
+"l1-d-prefetches-reference\000legacy cache\000Level 1 data cache prefetch =
accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D48748 */
+"l1-d-prefetches-refs\000legacy cache\000Level 1 data cache prefetch acces=
ses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D48853 */
+"l1-d-read\000legacy cache\000Level 1 data cache read accesses\000legacy-c=
ache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D48939 */
+"l1-d-read-access\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D49032 */
+"l1-d-read-miss\000legacy cache\000Level 1 data cache read misses\000legac=
y-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D49127 */
+"l1-d-read-misses\000legacy cache\000Level 1 data cache read misses\000leg=
acy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D49224 */
+"l1-d-read-ops\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D49314 */
+"l1-d-read-reference\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D49410 */
+"l1-d-read-refs\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D49501 */
+"l1-d-reference\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D49592 */
+"l1-d-refs\000legacy cache\000Level 1 data cache read accesses\000legacy-c=
ache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D49678 */
+"l1-d-speculative-load\000legacy cache\000Level 1 data cache prefetch acce=
sses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D49784 */
+"l1-d-speculative-load-access\000legacy cache\000Level 1 data cache prefet=
ch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D49897 */
+"l1-d-speculative-load-miss\000legacy cache\000Level 1 data cache prefetch=
 misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D50008 */
+"l1-d-speculative-load-misses\000legacy cache\000Level 1 data cache prefet=
ch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D50121 */
+"l1-d-speculative-load-ops\000legacy cache\000Level 1 data cache prefetch =
accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D50231 */
+"l1-d-speculative-load-reference\000legacy cache\000Level 1 data cache pre=
fetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000=
"
+/* offset=3D50347 */
+"l1-d-speculative-load-refs\000legacy cache\000Level 1 data cache prefetch=
 accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D50458 */
+"l1-d-speculative-read\000legacy cache\000Level 1 data cache prefetch acce=
sses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D50564 */
+"l1-d-speculative-read-access\000legacy cache\000Level 1 data cache prefet=
ch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D50677 */
+"l1-d-speculative-read-miss\000legacy cache\000Level 1 data cache prefetch=
 misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D50788 */
+"l1-d-speculative-read-misses\000legacy cache\000Level 1 data cache prefet=
ch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D50901 */
+"l1-d-speculative-read-ops\000legacy cache\000Level 1 data cache prefetch =
accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D51011 */
+"l1-d-speculative-read-reference\000legacy cache\000Level 1 data cache pre=
fetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000=
"
+/* offset=3D51127 */
+"l1-d-speculative-read-refs\000legacy cache\000Level 1 data cache prefetch=
 accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D51238 */
+"l1-d-store\000legacy cache\000Level 1 data cache write accesses\000legacy=
-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D51330 */
+"l1-d-store-access\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D51429 */
+"l1-d-store-miss\000legacy cache\000Level 1 data cache write misses\000leg=
acy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D51526 */
+"l1-d-store-misses\000legacy cache\000Level 1 data cache write misses\000l=
egacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D51625 */
+"l1-d-store-ops\000legacy cache\000Level 1 data cache write accesses\000le=
gacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D51721 */
+"l1-d-store-reference\000legacy cache\000Level 1 data cache write accesses=
\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D51823 */
+"l1-d-store-refs\000legacy cache\000Level 1 data cache write accesses\000l=
egacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D51920 */
+"l1-d-stores\000legacy cache\000Level 1 data cache write accesses\000legac=
y-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D52013 */
+"l1-d-stores-access\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D52113 */
+"l1-d-stores-miss\000legacy cache\000Level 1 data cache write misses\000le=
gacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D52211 */
+"l1-d-stores-misses\000legacy cache\000Level 1 data cache write misses\000=
legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D52311 */
+"l1-d-stores-ops\000legacy cache\000Level 1 data cache write accesses\000l=
egacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D52408 */
+"l1-d-stores-reference\000legacy cache\000Level 1 data cache write accesse=
s\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D52511 */
+"l1-d-stores-refs\000legacy cache\000Level 1 data cache write accesses\000=
legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D52609 */
+"l1-d-write\000legacy cache\000Level 1 data cache write accesses\000legacy=
-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D52701 */
+"l1-d-write-access\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D52800 */
+"l1-d-write-miss\000legacy cache\000Level 1 data cache write misses\000leg=
acy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D52897 */
+"l1-d-write-misses\000legacy cache\000Level 1 data cache write misses\000l=
egacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D52996 */
+"l1-d-write-ops\000legacy cache\000Level 1 data cache write accesses\000le=
gacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D53092 */
+"l1-d-write-reference\000legacy cache\000Level 1 data cache write accesses=
\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D53194 */
+"l1-d-write-refs\000legacy cache\000Level 1 data cache write accesses\000l=
egacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D53291 */
+"l1-data\000legacy cache\000Level 1 data cache read accesses\000legacy-cac=
he-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D53375 */
+"l1-data-access\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D53466 */
+"l1-data-load\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D53555 */
+"l1-data-load-access\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D53651 */
+"l1-data-load-miss\000legacy cache\000Level 1 data cache read misses\000le=
gacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D53749 */
+"l1-data-load-misses\000legacy cache\000Level 1 data cache read misses\000=
legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D53849 */
+"l1-data-load-ops\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D53942 */
+"l1-data-load-reference\000legacy cache\000Level 1 data cache read accesse=
s\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D54041 */
+"l1-data-load-refs\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D54135 */
+"l1-data-loads\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D54225 */
+"l1-data-loads-access\000legacy cache\000Level 1 data cache read accesses\=
000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D54322 */
+"l1-data-loads-miss\000legacy cache\000Level 1 data cache read misses\000l=
egacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D54421 */
+"l1-data-loads-misses\000legacy cache\000Level 1 data cache read misses\00=
0legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D54522 */
+"l1-data-loads-ops\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D54616 */
+"l1-data-loads-reference\000legacy cache\000Level 1 data cache read access=
es\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D54716 */
+"l1-data-loads-refs\000legacy cache\000Level 1 data cache read accesses\00=
0legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D54811 */
+"l1-data-miss\000legacy cache\000Level 1 data cache read misses\000legacy-=
cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D54904 */
+"l1-data-misses\000legacy cache\000Level 1 data cache read misses\000legac=
y-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D54999 */
+"l1-data-ops\000legacy cache\000Level 1 data cache read accesses\000legacy=
-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D55087 */
+"l1-data-prefetch\000legacy cache\000Level 1 data cache prefetch accesses\=
000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D55188 */
+"l1-data-prefetch-access\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D55296 */
+"l1-data-prefetch-miss\000legacy cache\000Level 1 data cache prefetch miss=
es\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D55402 */
+"l1-data-prefetch-misses\000legacy cache\000Level 1 data cache prefetch mi=
sses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D55510 */
+"l1-data-prefetch-ops\000legacy cache\000Level 1 data cache prefetch acces=
ses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D55615 */
+"l1-data-prefetch-reference\000legacy cache\000Level 1 data cache prefetch=
 accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D55726 */
+"l1-data-prefetch-refs\000legacy cache\000Level 1 data cache prefetch acce=
sses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D55832 */
+"l1-data-prefetches\000legacy cache\000Level 1 data cache prefetch accesse=
s\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D55935 */
+"l1-data-prefetches-access\000legacy cache\000Level 1 data cache prefetch =
accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D56045 */
+"l1-data-prefetches-miss\000legacy cache\000Level 1 data cache prefetch mi=
sses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D56153 */
+"l1-data-prefetches-misses\000legacy cache\000Level 1 data cache prefetch =
misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D56263 */
+"l1-data-prefetches-ops\000legacy cache\000Level 1 data cache prefetch acc=
esses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D56370 */
+"l1-data-prefetches-reference\000legacy cache\000Level 1 data cache prefet=
ch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D56483 */
+"l1-data-prefetches-refs\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D56591 */
+"l1-data-read\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D56680 */
+"l1-data-read-access\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D56776 */
+"l1-data-read-miss\000legacy cache\000Level 1 data cache read misses\000le=
gacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D56874 */
+"l1-data-read-misses\000legacy cache\000Level 1 data cache read misses\000=
legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D56974 */
+"l1-data-read-ops\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D57067 */
+"l1-data-read-reference\000legacy cache\000Level 1 data cache read accesse=
s\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D57166 */
+"l1-data-read-refs\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D57260 */
+"l1-data-reference\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D57354 */
+"l1-data-refs\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D57443 */
+"l1-data-speculative-load\000legacy cache\000Level 1 data cache prefetch a=
ccesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D57552 */
+"l1-data-speculative-load-access\000legacy cache\000Level 1 data cache pre=
fetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000=
"
+/* offset=3D57668 */
+"l1-data-speculative-load-miss\000legacy cache\000Level 1 data cache prefe=
tch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D57782 */
+"l1-data-speculative-load-misses\000legacy cache\000Level 1 data cache pre=
fetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000=
"
+/* offset=3D57898 */
+"l1-data-speculative-load-ops\000legacy cache\000Level 1 data cache prefet=
ch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D58011 */
+"l1-data-speculative-load-reference\000legacy cache\000Level 1 data cache =
prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\=
000"
+/* offset=3D58130 */
+"l1-data-speculative-load-refs\000legacy cache\000Level 1 data cache prefe=
tch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D58244 */
+"l1-data-speculative-read\000legacy cache\000Level 1 data cache prefetch a=
ccesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D58353 */
+"l1-data-speculative-read-access\000legacy cache\000Level 1 data cache pre=
fetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000=
"
+/* offset=3D58469 */
+"l1-data-speculative-read-miss\000legacy cache\000Level 1 data cache prefe=
tch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D58583 */
+"l1-data-speculative-read-misses\000legacy cache\000Level 1 data cache pre=
fetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000=
"
+/* offset=3D58699 */
+"l1-data-speculative-read-ops\000legacy cache\000Level 1 data cache prefet=
ch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D58812 */
+"l1-data-speculative-read-reference\000legacy cache\000Level 1 data cache =
prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\=
000"
+/* offset=3D58931 */
+"l1-data-speculative-read-refs\000legacy cache\000Level 1 data cache prefe=
tch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D59045 */
+"l1-data-store\000legacy cache\000Level 1 data cache write accesses\000leg=
acy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D59140 */
+"l1-data-store-access\000legacy cache\000Level 1 data cache write accesses=
\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D59242 */
+"l1-data-store-miss\000legacy cache\000Level 1 data cache write misses\000=
legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D59342 */
+"l1-data-store-misses\000legacy cache\000Level 1 data cache write misses\0=
00legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D59444 */
+"l1-data-store-ops\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D59543 */
+"l1-data-store-reference\000legacy cache\000Level 1 data cache write acces=
ses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D59648 */
+"l1-data-store-refs\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D59748 */
+"l1-data-stores\000legacy cache\000Level 1 data cache write accesses\000le=
gacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D59844 */
+"l1-data-stores-access\000legacy cache\000Level 1 data cache write accesse=
s\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D59947 */
+"l1-data-stores-miss\000legacy cache\000Level 1 data cache write misses\00=
0legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D60048 */
+"l1-data-stores-misses\000legacy cache\000Level 1 data cache write misses\=
000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D60151 */
+"l1-data-stores-ops\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D60251 */
+"l1-data-stores-reference\000legacy cache\000Level 1 data cache write acce=
sses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D60357 */
+"l1-data-stores-refs\000legacy cache\000Level 1 data cache write accesses\=
000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D60458 */
+"l1-data-write\000legacy cache\000Level 1 data cache write accesses\000leg=
acy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D60553 */
+"l1-data-write-access\000legacy cache\000Level 1 data cache write accesses=
\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D60655 */
+"l1-data-write-miss\000legacy cache\000Level 1 data cache write misses\000=
legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D60755 */
+"l1-data-write-misses\000legacy cache\000Level 1 data cache write misses\0=
00legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D60857 */
+"l1-data-write-ops\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D60956 */
+"l1-data-write-reference\000legacy cache\000Level 1 data cache write acces=
ses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D61061 */
+"l1-data-write-refs\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D61161 */
+"l1-dcache\000legacy cache\000Level 1 data cache read accesses\000legacy-c=
ache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D61247 */
+"l1-dcache-access\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D61340 */
+"l1-dcache-load\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D61431 */
+"l1-dcache-load-access\000legacy cache\000Level 1 data cache read accesses=
\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D61529 */
+"l1-dcache-load-miss\000legacy cache\000Level 1 data cache read misses\000=
legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D61629 */
+"l1-dcache-load-misses\000legacy cache\000Level 1 data cache read misses\0=
00legacy-cache-config=3D0x10000\000\00000\000\000\000\000\000"
+/* offset=3D61731 */
+"l1-dcache-load-ops\000legacy cache\000Level 1 data cache read accesses\00=
0legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D61826 */
+"l1-dcache-load-reference\000legacy cache\000Level 1 data cache read acces=
ses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D61927 */
+"l1-dcache-load-refs\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D62023 */
+"l1-dcache-loads\000legacy cache\000Level 1 data cache read accesses\000le=
gacy-cache-config=3D0\000\00000\000\000\000\000\000"
+/* offset=3D62115 */
+"l1-dcache-loads-access\000legacy cache\000Level 1 data cache read accesse=
s\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D62214 */
+"l1-dcache-loads-miss\000legacy cache\000Level 1 data cache read misses\00=
0legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D62315 */
+"l1-dcache-loads-misses\000legacy cache\000Level 1 data cache read misses\=
000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D62418 */
+"l1-dcache-loads-ops\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D62514 */
+"l1-dcache-loads-reference\000legacy cache\000Level 1 data cache read acce=
sses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D62616 */
+"l1-dcache-loads-refs\000legacy cache\000Level 1 data cache read accesses\=
000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D62713 */
+"l1-dcache-miss\000legacy cache\000Level 1 data cache read misses\000legac=
y-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D62808 */
+"l1-dcache-misses\000legacy cache\000Level 1 data cache read misses\000leg=
acy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D62905 */
+"l1-dcache-ops\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D62995 */
+"l1-dcache-prefetch\000legacy cache\000Level 1 data cache prefetch accesse=
s\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D63098 */
+"l1-dcache-prefetch-access\000legacy cache\000Level 1 data cache prefetch =
accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D63208 */
+"l1-dcache-prefetch-miss\000legacy cache\000Level 1 data cache prefetch mi=
sses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D63316 */
+"l1-dcache-prefetch-misses\000legacy cache\000Level 1 data cache prefetch =
misses\000legacy-cache-config=3D0x10200\000\00000\000\000\000\000\000"
+/* offset=3D63426 */
+"l1-dcache-prefetch-ops\000legacy cache\000Level 1 data cache prefetch acc=
esses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D63533 */
+"l1-dcache-prefetch-reference\000legacy cache\000Level 1 data cache prefet=
ch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D63646 */
+"l1-dcache-prefetch-refs\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D63754 */
+"l1-dcache-prefetches\000legacy cache\000Level 1 data cache prefetch acces=
ses\000legacy-cache-config=3D0x200\000\00000\000\000\000\000\000"
+/* offset=3D63859 */
+"l1-dcache-prefetches-access\000legacy cache\000Level 1 data cache prefetc=
h accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D63971 */
+"l1-dcache-prefetches-miss\000legacy cache\000Level 1 data cache prefetch =
misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D64081 */
+"l1-dcache-prefetches-misses\000legacy cache\000Level 1 data cache prefetc=
h misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D64193 */
+"l1-dcache-prefetches-ops\000legacy cache\000Level 1 data cache prefetch a=
ccesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D64302 */
+"l1-dcache-prefetches-reference\000legacy cache\000Level 1 data cache pref=
etch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D64417 */
+"l1-dcache-prefetches-refs\000legacy cache\000Level 1 data cache prefetch =
accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D64527 */
+"l1-dcache-read\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D64618 */
+"l1-dcache-read-access\000legacy cache\000Level 1 data cache read accesses=
\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D64716 */
+"l1-dcache-read-miss\000legacy cache\000Level 1 data cache read misses\000=
legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D64816 */
+"l1-dcache-read-misses\000legacy cache\000Level 1 data cache read misses\0=
00legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D64918 */
+"l1-dcache-read-ops\000legacy cache\000Level 1 data cache read accesses\00=
0legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D65013 */
+"l1-dcache-read-reference\000legacy cache\000Level 1 data cache read acces=
ses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D65114 */
+"l1-dcache-read-refs\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D65210 */
+"l1-dcache-reference\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D65306 */
+"l1-dcache-refs\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D65397 */
+"l1-dcache-speculative-load\000legacy cache\000Level 1 data cache prefetch=
 accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D65508 */
+"l1-dcache-speculative-load-access\000legacy cache\000Level 1 data cache p=
refetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\0=
00"
+/* offset=3D65626 */
+"l1-dcache-speculative-load-miss\000legacy cache\000Level 1 data cache pre=
fetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000=
"
+/* offset=3D65742 */
+"l1-dcache-speculative-load-misses\000legacy cache\000Level 1 data cache p=
refetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\0=
00"
+/* offset=3D65860 */
+"l1-dcache-speculative-load-ops\000legacy cache\000Level 1 data cache pref=
etch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D65975 */
+"l1-dcache-speculative-load-reference\000legacy cache\000Level 1 data cach=
e prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\00=
0\000"
+/* offset=3D66096 */
+"l1-dcache-speculative-load-refs\000legacy cache\000Level 1 data cache pre=
fetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000=
"
+/* offset=3D66212 */
+"l1-dcache-speculative-read\000legacy cache\000Level 1 data cache prefetch=
 accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D66323 */
+"l1-dcache-speculative-read-access\000legacy cache\000Level 1 data cache p=
refetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\0=
00"
+/* offset=3D66441 */
+"l1-dcache-speculative-read-miss\000legacy cache\000Level 1 data cache pre=
fetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000=
"
+/* offset=3D66557 */
+"l1-dcache-speculative-read-misses\000legacy cache\000Level 1 data cache p=
refetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\0=
00"
+/* offset=3D66675 */
+"l1-dcache-speculative-read-ops\000legacy cache\000Level 1 data cache pref=
etch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D66790 */
+"l1-dcache-speculative-read-reference\000legacy cache\000Level 1 data cach=
e prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\00=
0\000"
+/* offset=3D66911 */
+"l1-dcache-speculative-read-refs\000legacy cache\000Level 1 data cache pre=
fetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000=
"
+/* offset=3D67027 */
+"l1-dcache-store\000legacy cache\000Level 1 data cache write accesses\000l=
egacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D67124 */
+"l1-dcache-store-access\000legacy cache\000Level 1 data cache write access=
es\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D67228 */
+"l1-dcache-store-miss\000legacy cache\000Level 1 data cache write misses\0=
00legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D67330 */
+"l1-dcache-store-misses\000legacy cache\000Level 1 data cache write misses=
\000legacy-cache-config=3D0x10100\000\00000\000\000\000\000\000"
+/* offset=3D67434 */
+"l1-dcache-store-ops\000legacy cache\000Level 1 data cache write accesses\=
000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D67535 */
+"l1-dcache-store-reference\000legacy cache\000Level 1 data cache write acc=
esses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D67642 */
+"l1-dcache-store-refs\000legacy cache\000Level 1 data cache write accesses=
\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D67744 */
+"l1-dcache-stores\000legacy cache\000Level 1 data cache write accesses\000=
legacy-cache-config=3D0x100\000\00000\000\000\000\000\000"
+/* offset=3D67842 */
+"l1-dcache-stores-access\000legacy cache\000Level 1 data cache write acces=
ses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D67947 */
+"l1-dcache-stores-miss\000legacy cache\000Level 1 data cache write misses\=
000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D68050 */
+"l1-dcache-stores-misses\000legacy cache\000Level 1 data cache write misse=
s\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D68155 */
+"l1-dcache-stores-ops\000legacy cache\000Level 1 data cache write accesses=
\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D68257 */
+"l1-dcache-stores-reference\000legacy cache\000Level 1 data cache write ac=
cesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D68365 */
+"l1-dcache-stores-refs\000legacy cache\000Level 1 data cache write accesse=
s\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D68468 */
+"l1-dcache-write\000legacy cache\000Level 1 data cache write accesses\000l=
egacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D68565 */
+"l1-dcache-write-access\000legacy cache\000Level 1 data cache write access=
es\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D68669 */
+"l1-dcache-write-miss\000legacy cache\000Level 1 data cache write misses\0=
00legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D68771 */
+"l1-dcache-write-misses\000legacy cache\000Level 1 data cache write misses=
\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D68875 */
+"l1-dcache-write-ops\000legacy cache\000Level 1 data cache write accesses\=
000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D68976 */
+"l1-dcache-write-reference\000legacy cache\000Level 1 data cache write acc=
esses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D69083 */
+"l1-dcache-write-refs\000legacy cache\000Level 1 data cache write accesses=
\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D69185 */
+"l1-i\000legacy cache\000Level 1 instruction cache read accesses\000legacy=
-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D69273 */
+"l1-i-access\000legacy cache\000Level 1 instruction cache read accesses\00=
0legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D69368 */
+"l1-i-load\000legacy cache\000Level 1 instruction cache read accesses\000l=
egacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D69461 */
+"l1-i-load-access\000legacy cache\000Level 1 instruction cache read access=
es\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D69561 */
+"l1-i-load-miss\000legacy cache\000Level 1 instruction cache read misses\0=
00legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D69663 */
+"l1-i-load-misses\000legacy cache\000Level 1 instruction cache read misses=
\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D69767 */
+"l1-i-load-ops\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D69864 */
+"l1-i-load-reference\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D69967 */
+"l1-i-load-refs\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D70065 */
+"l1-i-loads\000legacy cache\000Level 1 instruction cache read accesses\000=
legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D70159 */
+"l1-i-loads-access\000legacy cache\000Level 1 instruction cache read acces=
ses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D70260 */
+"l1-i-loads-miss\000legacy cache\000Level 1 instruction cache read misses\=
000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D70363 */
+"l1-i-loads-misses\000legacy cache\000Level 1 instruction cache read misse=
s\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D70468 */
+"l1-i-loads-ops\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D70566 */
+"l1-i-loads-reference\000legacy cache\000Level 1 instruction cache read ac=
cesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D70670 */
+"l1-i-loads-refs\000legacy cache\000Level 1 instruction cache read accesse=
s\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D70769 */
+"l1-i-miss\000legacy cache\000Level 1 instruction cache read misses\000leg=
acy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D70866 */
+"l1-i-misses\000legacy cache\000Level 1 instruction cache read misses\000l=
egacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D70965 */
+"l1-i-ops\000legacy cache\000Level 1 instruction cache read accesses\000le=
gacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D71057 */
+"l1-i-prefetch\000legacy cache\000Level 1 instruction cache prefetch acces=
ses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D71162 */
+"l1-i-prefetch-access\000legacy cache\000Level 1 instruction cache prefetc=
h accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D71274 */
+"l1-i-prefetch-miss\000legacy cache\000Level 1 instruction cache prefetch =
misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
+/* offset=3D71384 */
+"l1-i-prefetch-misses\000legacy cache\000Level 1 instruction cache prefetc=
h misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
+/* offset=3D71496 */
+"l1-i-prefetch-ops\000legacy cache\000Level 1 instruction cache prefetch a=
ccesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D71605 */
+"l1-i-prefetch-reference\000legacy cache\000Level 1 instruction cache pref=
etch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D71720 */
+"l1-i-prefetch-refs\000legacy cache\000Level 1 instruction cache prefetch =
accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D71830 */
+"l1-i-prefetches\000legacy cache\000Level 1 instruction cache prefetch acc=
esses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D71937 */
+"l1-i-prefetches-access\000legacy cache\000Level 1 instruction cache prefe=
tch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D72051 */
+"l1-i-prefetches-miss\000legacy cache\000Level 1 instruction cache prefetc=
h misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
+/* offset=3D72163 */
+"l1-i-prefetches-misses\000legacy cache\000Level 1 instruction cache prefe=
tch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
+/* offset=3D72277 */
+"l1-i-prefetches-ops\000legacy cache\000Level 1 instruction cache prefetch=
 accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D72388 */
+"l1-i-prefetches-reference\000legacy cache\000Level 1 instruction cache pr=
efetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\00=
0"
+/* offset=3D72505 */
+"l1-i-prefetches-refs\000legacy cache\000Level 1 instruction cache prefetc=
h accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D72617 */
+"l1-i-read\000legacy cache\000Level 1 instruction cache read accesses\000l=
egacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D72710 */
+"l1-i-read-access\000legacy cache\000Level 1 instruction cache read access=
es\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D72810 */
+"l1-i-read-miss\000legacy cache\000Level 1 instruction cache read misses\0=
00legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D72912 */
+"l1-i-read-misses\000legacy cache\000Level 1 instruction cache read misses=
\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D73016 */
+"l1-i-read-ops\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D73113 */
+"l1-i-read-reference\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D73216 */
+"l1-i-read-refs\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D73314 */
+"l1-i-reference\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D73412 */
+"l1-i-refs\000legacy cache\000Level 1 instruction cache read accesses\000l=
egacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D73505 */
+"l1-i-speculative-load\000legacy cache\000Level 1 instruction cache prefet=
ch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D73618 */
+"l1-i-speculative-load-access\000legacy cache\000Level 1 instruction cache=
 prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000=
\000"
+/* offset=3D73738 */
+"l1-i-speculative-load-miss\000legacy cache\000Level 1 instruction cache p=
refetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\0=
00"
+/* offset=3D73856 */
+"l1-i-speculative-load-misses\000legacy cache\000Level 1 instruction cache=
 prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000=
\000"
+/* offset=3D73976 */
+"l1-i-speculative-load-ops\000legacy cache\000Level 1 instruction cache pr=
efetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\00=
0"
+/* offset=3D74093 */
+"l1-i-speculative-load-reference\000legacy cache\000Level 1 instruction ca=
che prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\=
000\000"
+/* offset=3D74216 */
+"l1-i-speculative-load-refs\000legacy cache\000Level 1 instruction cache p=
refetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\0=
00"
+/* offset=3D74334 */
+"l1-i-speculative-read\000legacy cache\000Level 1 instruction cache prefet=
ch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D74447 */
+"l1-i-speculative-read-access\000legacy cache\000Level 1 instruction cache=
 prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000=
\000"
+/* offset=3D74567 */
+"l1-i-speculative-read-miss\000legacy cache\000Level 1 instruction cache p=
refetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\0=
00"
+/* offset=3D74685 */
+"l1-i-speculative-read-misses\000legacy cache\000Level 1 instruction cache=
 prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000=
\000"
+/* offset=3D74805 */
+"l1-i-speculative-read-ops\000legacy cache\000Level 1 instruction cache pr=
efetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\00=
0"
+/* offset=3D74922 */
+"l1-i-speculative-read-reference\000legacy cache\000Level 1 instruction ca=
che prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\=
000\000"
+/* offset=3D75045 */
+"l1-i-speculative-read-refs\000legacy cache\000Level 1 instruction cache p=
refetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\0=
00"
+/* offset=3D75163 */
+"l1-icache\000legacy cache\000Level 1 instruction cache read accesses\000l=
egacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D75256 */
+"l1-icache-access\000legacy cache\000Level 1 instruction cache read access=
es\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D75356 */
+"l1-icache-load\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D75454 */
+"l1-icache-load-access\000legacy cache\000Level 1 instruction cache read a=
ccesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D75559 */
+"l1-icache-load-miss\000legacy cache\000Level 1 instruction cache read mis=
ses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D75666 */
+"l1-icache-load-misses\000legacy cache\000Level 1 instruction cache read m=
isses\000legacy-cache-config=3D0x10001\000\00000\000\000\000\000\000"
+/* offset=3D75775 */
+"l1-icache-load-ops\000legacy cache\000Level 1 instruction cache read acce=
sses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D75877 */
+"l1-icache-load-reference\000legacy cache\000Level 1 instruction cache rea=
d accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D75985 */
+"l1-icache-load-refs\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D76088 */
+"l1-icache-loads\000legacy cache\000Level 1 instruction cache read accesse=
s\000legacy-cache-config=3D1\000\00000\000\000\000\000\000"
+/* offset=3D76187 */
+"l1-icache-loads-access\000legacy cache\000Level 1 instruction cache read =
accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D76293 */
+"l1-icache-loads-miss\000legacy cache\000Level 1 instruction cache read mi=
sses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D76401 */
+"l1-icache-loads-misses\000legacy cache\000Level 1 instruction cache read =
misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D76511 */
+"l1-icache-loads-ops\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D76614 */
+"l1-icache-loads-reference\000legacy cache\000Level 1 instruction cache re=
ad accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D76723 */
+"l1-icache-loads-refs\000legacy cache\000Level 1 instruction cache read ac=
cesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D76827 */
+"l1-icache-miss\000legacy cache\000Level 1 instruction cache read misses\0=
00legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D76929 */
+"l1-icache-misses\000legacy cache\000Level 1 instruction cache read misses=
\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D77033 */
+"l1-icache-ops\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D77130 */
+"l1-icache-prefetch\000legacy cache\000Level 1 instruction cache prefetch =
accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D77240 */
+"l1-icache-prefetch-access\000legacy cache\000Level 1 instruction cache pr=
efetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\00=
0"
+/* offset=3D77357 */
+"l1-icache-prefetch-miss\000legacy cache\000Level 1 instruction cache pref=
etch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
+/* offset=3D77472 */
+"l1-icache-prefetch-misses\000legacy cache\000Level 1 instruction cache pr=
efetch misses\000legacy-cache-config=3D0x10201\000\00000\000\000\000\000\00=
0"
+/* offset=3D77589 */
+"l1-icache-prefetch-ops\000legacy cache\000Level 1 instruction cache prefe=
tch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D77703 */
+"l1-icache-prefetch-reference\000legacy cache\000Level 1 instruction cache=
 prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000=
\000"
+/* offset=3D77823 */
+"l1-icache-prefetch-refs\000legacy cache\000Level 1 instruction cache pref=
etch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D77938 */
+"l1-icache-prefetches\000legacy cache\000Level 1 instruction cache prefetc=
h accesses\000legacy-cache-config=3D0x201\000\00000\000\000\000\000\000"
+/* offset=3D78050 */
+"l1-icache-prefetches-access\000legacy cache\000Level 1 instruction cache =
prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\=
000"
+/* offset=3D78169 */
+"l1-icache-prefetches-miss\000legacy cache\000Level 1 instruction cache pr=
efetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\00=
0"
+/* offset=3D78286 */
+"l1-icache-prefetches-misses\000legacy cache\000Level 1 instruction cache =
prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\=
000"
+/* offset=3D78405 */
+"l1-icache-prefetches-ops\000legacy cache\000Level 1 instruction cache pre=
fetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000=
"
+/* offset=3D78521 */
+"l1-icache-prefetches-reference\000legacy cache\000Level 1 instruction cac=
he prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\0=
00\000"
+/* offset=3D78643 */
+"l1-icache-prefetches-refs\000legacy cache\000Level 1 instruction cache pr=
efetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\00=
0"
+/* offset=3D78760 */
+"l1-icache-read\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D78858 */
+"l1-icache-read-access\000legacy cache\000Level 1 instruction cache read a=
ccesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D78963 */
+"l1-icache-read-miss\000legacy cache\000Level 1 instruction cache read mis=
ses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D79070 */
+"l1-icache-read-misses\000legacy cache\000Level 1 instruction cache read m=
isses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D79179 */
+"l1-icache-read-ops\000legacy cache\000Level 1 instruction cache read acce=
sses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D79281 */
+"l1-icache-read-reference\000legacy cache\000Level 1 instruction cache rea=
d accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D79389 */
+"l1-icache-read-refs\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D79492 */
+"l1-icache-reference\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D79595 */
+"l1-icache-refs\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D79693 */
+"l1-icache-speculative-load\000legacy cache\000Level 1 instruction cache p=
refetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\0=
00"
+/* offset=3D79811 */
+"l1-icache-speculative-load-access\000legacy cache\000Level 1 instruction =
cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\00=
0\000\000"
+/* offset=3D79936 */
+"l1-icache-speculative-load-miss\000legacy cache\000Level 1 instruction ca=
che prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\=
000\000"
+/* offset=3D80059 */
+"l1-icache-speculative-load-misses\000legacy cache\000Level 1 instruction =
cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\00=
0\000\000"
+/* offset=3D80184 */
+"l1-icache-speculative-load-ops\000legacy cache\000Level 1 instruction cac=
he prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\0=
00\000"
+/* offset=3D80306 */
+"l1-icache-speculative-load-reference\000legacy cache\000Level 1 instructi=
on cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000=
\000\000\000"
+/* offset=3D80434 */
+"l1-icache-speculative-load-refs\000legacy cache\000Level 1 instruction ca=
che prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\=
000\000"
+/* offset=3D80557 */
+"l1-icache-speculative-read\000legacy cache\000Level 1 instruction cache p=
refetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\0=
00"
+/* offset=3D80675 */
+"l1-icache-speculative-read-access\000legacy cache\000Level 1 instruction =
cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\00=
0\000\000"
+/* offset=3D80800 */
+"l1-icache-speculative-read-miss\000legacy cache\000Level 1 instruction ca=
che prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\=
000\000"
+/* offset=3D80923 */
+"l1-icache-speculative-read-misses\000legacy cache\000Level 1 instruction =
cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\00=
0\000\000"
+/* offset=3D81048 */
+"l1-icache-speculative-read-ops\000legacy cache\000Level 1 instruction cac=
he prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\0=
00\000"
+/* offset=3D81170 */
+"l1-icache-speculative-read-reference\000legacy cache\000Level 1 instructi=
on cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000=
\000\000\000"
+/* offset=3D81298 */
+"l1-icache-speculative-read-refs\000legacy cache\000Level 1 instruction ca=
che prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\=
000\000"
+/* offset=3D81421 */
+"l1-instruction\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D81519 */
+"l1-instruction-access\000legacy cache\000Level 1 instruction cache read a=
ccesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D81624 */
+"l1-instruction-load\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D81727 */
+"l1-instruction-load-access\000legacy cache\000Level 1 instruction cache r=
ead accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D81837 */
+"l1-instruction-load-miss\000legacy cache\000Level 1 instruction cache rea=
d misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D81949 */
+"l1-instruction-load-misses\000legacy cache\000Level 1 instruction cache r=
ead misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D82063 */
+"l1-instruction-load-ops\000legacy cache\000Level 1 instruction cache read=
 accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D82170 */
+"l1-instruction-load-reference\000legacy cache\000Level 1 instruction cach=
e read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D82283 */
+"l1-instruction-load-refs\000legacy cache\000Level 1 instruction cache rea=
d accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D82391 */
+"l1-instruction-loads\000legacy cache\000Level 1 instruction cache read ac=
cesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D82495 */
+"l1-instruction-loads-access\000legacy cache\000Level 1 instruction cache =
read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D82606 */
+"l1-instruction-loads-miss\000legacy cache\000Level 1 instruction cache re=
ad misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D82719 */
+"l1-instruction-loads-misses\000legacy cache\000Level 1 instruction cache =
read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D82834 */
+"l1-instruction-loads-ops\000legacy cache\000Level 1 instruction cache rea=
d accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D82942 */
+"l1-instruction-loads-reference\000legacy cache\000Level 1 instruction cac=
he read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D83056 */
+"l1-instruction-loads-refs\000legacy cache\000Level 1 instruction cache re=
ad accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D83165 */
+"l1-instruction-miss\000legacy cache\000Level 1 instruction cache read mis=
ses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D83272 */
+"l1-instruction-misses\000legacy cache\000Level 1 instruction cache read m=
isses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D83381 */
+"l1-instruction-ops\000legacy cache\000Level 1 instruction cache read acce=
sses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D83483 */
+"l1-instruction-prefetch\000legacy cache\000Level 1 instruction cache pref=
etch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D83598 */
+"l1-instruction-prefetch-access\000legacy cache\000Level 1 instruction cac=
he prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\0=
00\000"
+/* offset=3D83720 */
+"l1-instruction-prefetch-miss\000legacy cache\000Level 1 instruction cache=
 prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000=
\000"
+/* offset=3D83840 */
+"l1-instruction-prefetch-misses\000legacy cache\000Level 1 instruction cac=
he prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\0=
00\000"
+/* offset=3D83962 */
+"l1-instruction-prefetch-ops\000legacy cache\000Level 1 instruction cache =
prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\=
000"
+/* offset=3D84081 */
+"l1-instruction-prefetch-reference\000legacy cache\000Level 1 instruction =
cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\00=
0\000\000"
+/* offset=3D84206 */
+"l1-instruction-prefetch-refs\000legacy cache\000Level 1 instruction cache=
 prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000=
\000"
+/* offset=3D84326 */
+"l1-instruction-prefetches\000legacy cache\000Level 1 instruction cache pr=
efetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\00=
0"
+/* offset=3D84443 */
+"l1-instruction-prefetches-access\000legacy cache\000Level 1 instruction c=
ache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000=
\000\000"
+/* offset=3D84567 */
+"l1-instruction-prefetches-miss\000legacy cache\000Level 1 instruction cac=
he prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\0=
00\000"
+/* offset=3D84689 */
+"l1-instruction-prefetches-misses\000legacy cache\000Level 1 instruction c=
ache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000=
\000\000"
+/* offset=3D84813 */
+"l1-instruction-prefetches-ops\000legacy cache\000Level 1 instruction cach=
e prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\00=
0\000"
+/* offset=3D84934 */
+"l1-instruction-prefetches-reference\000legacy cache\000Level 1 instructio=
n cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\=
000\000\000"
+/* offset=3D85061 */
+"l1-instruction-prefetches-refs\000legacy cache\000Level 1 instruction cac=
he prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\0=
00\000"
+/* offset=3D85183 */
+"l1-instruction-read\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D85286 */
+"l1-instruction-read-access\000legacy cache\000Level 1 instruction cache r=
ead accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D85396 */
+"l1-instruction-read-miss\000legacy cache\000Level 1 instruction cache rea=
d misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D85508 */
+"l1-instruction-read-misses\000legacy cache\000Level 1 instruction cache r=
ead misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D85622 */
+"l1-instruction-read-ops\000legacy cache\000Level 1 instruction cache read=
 accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D85729 */
+"l1-instruction-read-reference\000legacy cache\000Level 1 instruction cach=
e read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D85842 */
+"l1-instruction-read-refs\000legacy cache\000Level 1 instruction cache rea=
d accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D85950 */
+"l1-instruction-reference\000legacy cache\000Level 1 instruction cache rea=
d accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D86058 */
+"l1-instruction-refs\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D86161 */
+"l1-instruction-speculative-load\000legacy cache\000Level 1 instruction ca=
che prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\=
000\000"
+/* offset=3D86284 */
+"l1-instruction-speculative-load-access\000legacy cache\000Level 1 instruc=
tion cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\0=
00\000\000\000"
+/* offset=3D86414 */
+"l1-instruction-speculative-load-miss\000legacy cache\000Level 1 instructi=
on cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000=
\000\000\000"
+/* offset=3D86542 */
+"l1-instruction-speculative-load-misses\000legacy cache\000Level 1 instruc=
tion cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\0=
00\000\000\000"
+/* offset=3D86672 */
+"l1-instruction-speculative-load-ops\000legacy cache\000Level 1 instructio=
n cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\=
000\000\000"
+/* offset=3D86799 */
+"l1-instruction-speculative-load-reference\000legacy cache\000Level 1 inst=
ruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\00=
0\000\000\000\000"
+/* offset=3D86932 */
+"l1-instruction-speculative-load-refs\000legacy cache\000Level 1 instructi=
on cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000=
\000\000\000"
+/* offset=3D87060 */
+"l1-instruction-speculative-read\000legacy cache\000Level 1 instruction ca=
che prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\=
000\000"
+/* offset=3D87183 */
+"l1-instruction-speculative-read-access\000legacy cache\000Level 1 instruc=
tion cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\0=
00\000\000\000"
+/* offset=3D87313 */
+"l1-instruction-speculative-read-miss\000legacy cache\000Level 1 instructi=
on cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000=
\000\000\000"
+/* offset=3D87441 */
+"l1-instruction-speculative-read-misses\000legacy cache\000Level 1 instruc=
tion cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\0=
00\000\000\000"
+/* offset=3D87571 */
+"l1-instruction-speculative-read-ops\000legacy cache\000Level 1 instructio=
n cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\=
000\000\000"
+/* offset=3D87698 */
+"l1-instruction-speculative-read-reference\000legacy cache\000Level 1 inst=
ruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\00=
0\000\000\000\000"
+/* offset=3D87831 */
+"l1-instruction-speculative-read-refs\000legacy cache\000Level 1 instructi=
on cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000=
\000\000\000"
+/* offset=3D87959 */
+"l1d\000legacy cache\000Level 1 data cache read accesses\000legacy-cache-c=
onfig=3D0\000\00010\000\000\000\000\000"
+/* offset=3D88039 */
+"l1d-access\000legacy cache\000Level 1 data cache read accesses\000legacy-=
cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D88126 */
+"l1d-load\000legacy cache\000Level 1 data cache read accesses\000legacy-ca=
che-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D88211 */
+"l1d-load-access\000legacy cache\000Level 1 data cache read accesses\000le=
gacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D88303 */
+"l1d-load-miss\000legacy cache\000Level 1 data cache read misses\000legacy=
-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D88397 */
+"l1d-load-misses\000legacy cache\000Level 1 data cache read misses\000lega=
cy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D88493 */
+"l1d-load-ops\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D88582 */
+"l1d-load-reference\000legacy cache\000Level 1 data cache read accesses\00=
0legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D88677 */
+"l1d-load-refs\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D88767 */
+"l1d-loads\000legacy cache\000Level 1 data cache read accesses\000legacy-c=
ache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D88853 */
+"l1d-loads-access\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D88946 */
+"l1d-loads-miss\000legacy cache\000Level 1 data cache read misses\000legac=
y-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D89041 */
+"l1d-loads-misses\000legacy cache\000Level 1 data cache read misses\000leg=
acy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D89138 */
+"l1d-loads-ops\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D89228 */
+"l1d-loads-reference\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D89324 */
+"l1d-loads-refs\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D89415 */
+"l1d-miss\000legacy cache\000Level 1 data cache read misses\000legacy-cach=
e-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D89504 */
+"l1d-misses\000legacy cache\000Level 1 data cache read misses\000legacy-ca=
che-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D89595 */
+"l1d-ops\000legacy cache\000Level 1 data cache read accesses\000legacy-cac=
he-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D89679 */
+"l1d-prefetch\000legacy cache\000Level 1 data cache prefetch accesses\000l=
egacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D89776 */
+"l1d-prefetch-access\000legacy cache\000Level 1 data cache prefetch access=
es\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D89880 */
+"l1d-prefetch-miss\000legacy cache\000Level 1 data cache prefetch misses\0=
00legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D89982 */
+"l1d-prefetch-misses\000legacy cache\000Level 1 data cache prefetch misses=
\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D90086 */
+"l1d-prefetch-ops\000legacy cache\000Level 1 data cache prefetch accesses\=
000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D90187 */
+"l1d-prefetch-reference\000legacy cache\000Level 1 data cache prefetch acc=
esses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D90294 */
+"l1d-prefetch-refs\000legacy cache\000Level 1 data cache prefetch accesses=
\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D90396 */
+"l1d-prefetches\000legacy cache\000Level 1 data cache prefetch accesses\00=
0legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D90495 */
+"l1d-prefetches-access\000legacy cache\000Level 1 data cache prefetch acce=
sses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D90601 */
+"l1d-prefetches-miss\000legacy cache\000Level 1 data cache prefetch misses=
\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D90705 */
+"l1d-prefetches-misses\000legacy cache\000Level 1 data cache prefetch miss=
es\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D90811 */
+"l1d-prefetches-ops\000legacy cache\000Level 1 data cache prefetch accesse=
s\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D90914 */
+"l1d-prefetches-reference\000legacy cache\000Level 1 data cache prefetch a=
ccesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D91023 */
+"l1d-prefetches-refs\000legacy cache\000Level 1 data cache prefetch access=
es\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D91127 */
+"l1d-read\000legacy cache\000Level 1 data cache read accesses\000legacy-ca=
che-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D91212 */
+"l1d-read-access\000legacy cache\000Level 1 data cache read accesses\000le=
gacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D91304 */
+"l1d-read-miss\000legacy cache\000Level 1 data cache read misses\000legacy=
-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D91398 */
+"l1d-read-misses\000legacy cache\000Level 1 data cache read misses\000lega=
cy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
+/* offset=3D91494 */
+"l1d-read-ops\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D91583 */
+"l1d-read-reference\000legacy cache\000Level 1 data cache read accesses\00=
0legacy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D91678 */
+"l1d-read-refs\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D91768 */
+"l1d-reference\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D91858 */
+"l1d-refs\000legacy cache\000Level 1 data cache read accesses\000legacy-ca=
che-config=3D0\000\00010\000\000\000\000\000"
+/* offset=3D91943 */
+"l1d-speculative-load\000legacy cache\000Level 1 data cache prefetch acces=
ses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D92048 */
+"l1d-speculative-load-access\000legacy cache\000Level 1 data cache prefetc=
h accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D92160 */
+"l1d-speculative-load-miss\000legacy cache\000Level 1 data cache prefetch =
misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D92270 */
+"l1d-speculative-load-misses\000legacy cache\000Level 1 data cache prefetc=
h misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D92382 */
+"l1d-speculative-load-ops\000legacy cache\000Level 1 data cache prefetch a=
ccesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D92491 */
+"l1d-speculative-load-reference\000legacy cache\000Level 1 data cache pref=
etch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D92606 */
+"l1d-speculative-load-refs\000legacy cache\000Level 1 data cache prefetch =
accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D92716 */
+"l1d-speculative-read\000legacy cache\000Level 1 data cache prefetch acces=
ses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D92821 */
+"l1d-speculative-read-access\000legacy cache\000Level 1 data cache prefetc=
h accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D92933 */
+"l1d-speculative-read-miss\000legacy cache\000Level 1 data cache prefetch =
misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D93043 */
+"l1d-speculative-read-misses\000legacy cache\000Level 1 data cache prefetc=
h misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
+/* offset=3D93155 */
+"l1d-speculative-read-ops\000legacy cache\000Level 1 data cache prefetch a=
ccesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D93264 */
+"l1d-speculative-read-reference\000legacy cache\000Level 1 data cache pref=
etch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D93379 */
+"l1d-speculative-read-refs\000legacy cache\000Level 1 data cache prefetch =
accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
+/* offset=3D93489 */
+"l1d-store\000legacy cache\000Level 1 data cache write accesses\000legacy-=
cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D93580 */
+"l1d-store-access\000legacy cache\000Level 1 data cache write accesses\000=
legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D93678 */
+"l1d-store-miss\000legacy cache\000Level 1 data cache write misses\000lega=
cy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D93774 */
+"l1d-store-misses\000legacy cache\000Level 1 data cache write misses\000le=
gacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D93872 */
+"l1d-store-ops\000legacy cache\000Level 1 data cache write accesses\000leg=
acy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D93967 */
+"l1d-store-reference\000legacy cache\000Level 1 data cache write accesses\=
000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D94068 */
+"l1d-store-refs\000legacy cache\000Level 1 data cache write accesses\000le=
gacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D94164 */
+"l1d-stores\000legacy cache\000Level 1 data cache write accesses\000legacy=
-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D94256 */
+"l1d-stores-access\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D94355 */
+"l1d-stores-miss\000legacy cache\000Level 1 data cache write misses\000leg=
acy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D94452 */
+"l1d-stores-misses\000legacy cache\000Level 1 data cache write misses\000l=
egacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D94551 */
+"l1d-stores-ops\000legacy cache\000Level 1 data cache write accesses\000le=
gacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D94647 */
+"l1d-stores-reference\000legacy cache\000Level 1 data cache write accesses=
\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D94749 */
+"l1d-stores-refs\000legacy cache\000Level 1 data cache write accesses\000l=
egacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D94846 */
+"l1d-write\000legacy cache\000Level 1 data cache write accesses\000legacy-=
cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D94937 */
+"l1d-write-access\000legacy cache\000Level 1 data cache write accesses\000=
legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D95035 */
+"l1d-write-miss\000legacy cache\000Level 1 data cache write misses\000lega=
cy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D95131 */
+"l1d-write-misses\000legacy cache\000Level 1 data cache write misses\000le=
gacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
+/* offset=3D95229 */
+"l1d-write-ops\000legacy cache\000Level 1 data cache write accesses\000leg=
acy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D95324 */
+"l1d-write-reference\000legacy cache\000Level 1 data cache write accesses\=
000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D95425 */
+"l1d-write-refs\000legacy cache\000Level 1 data cache write accesses\000le=
gacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
+/* offset=3D95521 */
+"l1i\000legacy cache\000Level 1 instruction cache read accesses\000legacy-=
cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D95608 */
+"l1i-access\000legacy cache\000Level 1 instruction cache read accesses\000=
legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D95702 */
+"l1i-load\000legacy cache\000Level 1 instruction cache read accesses\000le=
gacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D95794 */
+"l1i-load-access\000legacy cache\000Level 1 instruction cache read accesse=
s\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D95893 */
+"l1i-load-miss\000legacy cache\000Level 1 instruction cache read misses\00=
0legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D95994 */
+"l1i-load-misses\000legacy cache\000Level 1 instruction cache read misses\=
000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D96097 */
+"l1i-load-ops\000legacy cache\000Level 1 instruction cache read accesses\0=
00legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D96193 */
+"l1i-load-reference\000legacy cache\000Level 1 instruction cache read acce=
sses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D96295 */
+"l1i-load-refs\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D96392 */
+"l1i-loads\000legacy cache\000Level 1 instruction cache read accesses\000l=
egacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D96485 */
+"l1i-loads-access\000legacy cache\000Level 1 instruction cache read access=
es\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D96585 */
+"l1i-loads-miss\000legacy cache\000Level 1 instruction cache read misses\0=
00legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D96687 */
+"l1i-loads-misses\000legacy cache\000Level 1 instruction cache read misses=
\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D96791 */
+"l1i-loads-ops\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D96888 */
+"l1i-loads-reference\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D96991 */
+"l1i-loads-refs\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D97089 */
+"l1i-miss\000legacy cache\000Level 1 instruction cache read misses\000lega=
cy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D97185 */
+"l1i-misses\000legacy cache\000Level 1 instruction cache read misses\000le=
gacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D97283 */
+"l1i-ops\000legacy cache\000Level 1 instruction cache read accesses\000leg=
acy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D97374 */
+"l1i-prefetch\000legacy cache\000Level 1 instruction cache prefetch access=
es\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D97478 */
+"l1i-prefetch-access\000legacy cache\000Level 1 instruction cache prefetch=
 accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D97589 */
+"l1i-prefetch-miss\000legacy cache\000Level 1 instruction cache prefetch m=
isses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
+/* offset=3D97698 */
+"l1i-prefetch-misses\000legacy cache\000Level 1 instruction cache prefetch=
 misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
+/* offset=3D97809 */
+"l1i-prefetch-ops\000legacy cache\000Level 1 instruction cache prefetch ac=
cesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D97917 */
+"l1i-prefetch-reference\000legacy cache\000Level 1 instruction cache prefe=
tch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D98031 */
+"l1i-prefetch-refs\000legacy cache\000Level 1 instruction cache prefetch a=
ccesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D98140 */
+"l1i-prefetches\000legacy cache\000Level 1 instruction cache prefetch acce=
sses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D98246 */
+"l1i-prefetches-access\000legacy cache\000Level 1 instruction cache prefet=
ch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D98359 */
+"l1i-prefetches-miss\000legacy cache\000Level 1 instruction cache prefetch=
 misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
+/* offset=3D98470 */
+"l1i-prefetches-misses\000legacy cache\000Level 1 instruction cache prefet=
ch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
+/* offset=3D98583 */
+"l1i-prefetches-ops\000legacy cache\000Level 1 instruction cache prefetch =
accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D98693 */
+"l1i-prefetches-reference\000legacy cache\000Level 1 instruction cache pre=
fetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000=
"
+/* offset=3D98809 */
+"l1i-prefetches-refs\000legacy cache\000Level 1 instruction cache prefetch=
 accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D98920 */
+"l1i-read\000legacy cache\000Level 1 instruction cache read accesses\000le=
gacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D99012 */
+"l1i-read-access\000legacy cache\000Level 1 instruction cache read accesse=
s\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D99111 */
+"l1i-read-miss\000legacy cache\000Level 1 instruction cache read misses\00=
0legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D99212 */
+"l1i-read-misses\000legacy cache\000Level 1 instruction cache read misses\=
000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
+/* offset=3D99315 */
+"l1i-read-ops\000legacy cache\000Level 1 instruction cache read accesses\0=
00legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D99411 */
+"l1i-read-reference\000legacy cache\000Level 1 instruction cache read acce=
sses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D99513 */
+"l1i-read-refs\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D99610 */
+"l1i-reference\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D99707 */
+"l1i-refs\000legacy cache\000Level 1 instruction cache read accesses\000le=
gacy-cache-config=3D1\000\00010\000\000\000\000\000"
+/* offset=3D99799 */
+"l1i-speculative-load\000legacy cache\000Level 1 instruction cache prefetc=
h accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D99911 */
+"l1i-speculative-load-access\000legacy cache\000Level 1 instruction cache =
prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\=
000"
+/* offset=3D100030 */
+"l1i-speculative-load-miss\000legacy cache\000Level 1 instruction cache pr=
efetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\00=
0"
+/* offset=3D100147 */
+"l1i-speculative-load-misses\000legacy cache\000Level 1 instruction cache =
prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\=
000"
+/* offset=3D100266 */
+"l1i-speculative-load-ops\000legacy cache\000Level 1 instruction cache pre=
fetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000=
"
+/* offset=3D100382 */
+"l1i-speculative-load-reference\000legacy cache\000Level 1 instruction cac=
he prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\0=
00\000"
+/* offset=3D100504 */
+"l1i-speculative-load-refs\000legacy cache\000Level 1 instruction cache pr=
efetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\00=
0"
+/* offset=3D100621 */
+"l1i-speculative-read\000legacy cache\000Level 1 instruction cache prefetc=
h accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
+/* offset=3D100733 */
+"l1i-speculative-read-access\000legacy cache\000Level 1 instruction cache =
prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\=
000"
+/* offset=3D100852 */
+"l1i-speculative-read-miss\000legacy cache\000Level 1 instruction cache pr=
efetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\00=
0"
+/* offset=3D100969 */
+"l1i-speculative-read-misses\000legacy cache\000Level 1 instruction cache =
prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\=
000"
+/* offset=3D101088 */
+"l1i-speculative-read-ops\000legacy cache\000Level 1 instruction cache pre=
fetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000=
"
+/* offset=3D101204 */
+"l1i-speculative-read-reference\000legacy cache\000Level 1 instruction cac=
he prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\0=
00\000"
+/* offset=3D101326 */
+"l1i-speculative-read-refs\000legacy cache\000Level 1 instruction cache pr=
efetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\00=
0"
+/* offset=3D101443 */
+"l2\000legacy cache\000Level 2 (or higher) last level cache read accesses\=
000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D101540 */
+"l2-access\000legacy cache\000Level 2 (or higher) last level cache read ac=
cesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D101644 */
+"l2-load\000legacy cache\000Level 2 (or higher) last level cache read acce=
sses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D101746 */
+"l2-load-access\000legacy cache\000Level 2 (or higher) last level cache re=
ad accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D101855 */
+"l2-load-miss\000legacy cache\000Level 2 (or higher) last level cache read=
 misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
+/* offset=3D101966 */
+"l2-load-misses\000legacy cache\000Level 2 (or higher) last level cache re=
ad misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
+/* offset=3D102079 */
+"l2-load-ops\000legacy cache\000Level 2 (or higher) last level cache read =
accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D102185 */
+"l2-load-reference\000legacy cache\000Level 2 (or higher) last level cache=
 read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D102297 */
+"l2-load-refs\000legacy cache\000Level 2 (or higher) last level cache read=
 accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D102404 */
+"l2-loads\000legacy cache\000Level 2 (or higher) last level cache read acc=
esses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D102507 */
+"l2-loads-access\000legacy cache\000Level 2 (or higher) last level cache r=
ead accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D102617 */
+"l2-loads-miss\000legacy cache\000Level 2 (or higher) last level cache rea=
d misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
+/* offset=3D102729 */
+"l2-loads-misses\000legacy cache\000Level 2 (or higher) last level cache r=
ead misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
+/* offset=3D102843 */
+"l2-loads-ops\000legacy cache\000Level 2 (or higher) last level cache read=
 accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D102950 */
+"l2-loads-reference\000legacy cache\000Level 2 (or higher) last level cach=
e read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D103063 */
+"l2-loads-refs\000legacy cache\000Level 2 (or higher) last level cache rea=
d accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D103171 */
+"l2-miss\000legacy cache\000Level 2 (or higher) last level cache read miss=
es\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
+/* offset=3D103277 */
+"l2-misses\000legacy cache\000Level 2 (or higher) last level cache read mi=
sses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
+/* offset=3D103385 */
+"l2-ops\000legacy cache\000Level 2 (or higher) last level cache read acces=
ses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D103486 */
+"l2-prefetch\000legacy cache\000Level 2 (or higher) last level cache prefe=
tch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D103600 */
+"l2-prefetch-access\000legacy cache\000Level 2 (or higher) last level cach=
e prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\00=
0\000"
+/* offset=3D103721 */
+"l2-prefetch-miss\000legacy cache\000Level 2 (or higher) last level cache =
prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\000\=
000"
+/* offset=3D103840 */
+"l2-prefetch-misses\000legacy cache\000Level 2 (or higher) last level cach=
e prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\00=
0\000"
+/* offset=3D103961 */
+"l2-prefetch-ops\000legacy cache\000Level 2 (or higher) last level cache p=
refetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\0=
00"
+/* offset=3D104079 */
+"l2-prefetch-reference\000legacy cache\000Level 2 (or higher) last level c=
ache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000=
\000\000"
+/* offset=3D104203 */
+"l2-prefetch-refs\000legacy cache\000Level 2 (or higher) last level cache =
prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\=
000"
+/* offset=3D104322 */
+"l2-prefetches\000legacy cache\000Level 2 (or higher) last level cache pre=
fetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000=
"
+/* offset=3D104438 */
+"l2-prefetches-access\000legacy cache\000Level 2 (or higher) last level ca=
che prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\=
000\000"
+/* offset=3D104561 */
+"l2-prefetches-miss\000legacy cache\000Level 2 (or higher) last level cach=
e prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\00=
0\000"
+/* offset=3D104682 */
+"l2-prefetches-misses\000legacy cache\000Level 2 (or higher) last level ca=
che prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\=
000\000"
+/* offset=3D104805 */
+"l2-prefetches-ops\000legacy cache\000Level 2 (or higher) last level cache=
 prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000=
\000"
+/* offset=3D104925 */
+"l2-prefetches-reference\000legacy cache\000Level 2 (or higher) last level=
 cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\0=
00\000\000"
+/* offset=3D105051 */
+"l2-prefetches-refs\000legacy cache\000Level 2 (or higher) last level cach=
e prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\00=
0\000"
+/* offset=3D105172 */
+"l2-read\000legacy cache\000Level 2 (or higher) last level cache read acce=
sses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D105274 */
+"l2-read-access\000legacy cache\000Level 2 (or higher) last level cache re=
ad accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D105383 */
+"l2-read-miss\000legacy cache\000Level 2 (or higher) last level cache read=
 misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
+/* offset=3D105494 */
+"l2-read-misses\000legacy cache\000Level 2 (or higher) last level cache re=
ad misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
+/* offset=3D105607 */
+"l2-read-ops\000legacy cache\000Level 2 (or higher) last level cache read =
accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D105713 */
+"l2-read-reference\000legacy cache\000Level 2 (or higher) last level cache=
 read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D105825 */
+"l2-read-refs\000legacy cache\000Level 2 (or higher) last level cache read=
 accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D105932 */
+"l2-reference\000legacy cache\000Level 2 (or higher) last level cache read=
 accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D106039 */
+"l2-refs\000legacy cache\000Level 2 (or higher) last level cache read acce=
sses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D106141 */
+"l2-speculative-load\000legacy cache\000Level 2 (or higher) last level cac=
he prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\0=
00\000"
+/* offset=3D106263 */
+"l2-speculative-load-access\000legacy cache\000Level 2 (or higher) last le=
vel cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\00=
0\000\000\000"
+/* offset=3D106392 */
+"l2-speculative-load-miss\000legacy cache\000Level 2 (or higher) last leve=
l cache prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\=
000\000\000"
+/* offset=3D106519 */
+"l2-speculative-load-misses\000legacy cache\000Level 2 (or higher) last le=
vel cache prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\00=
0\000\000\000"
+/* offset=3D106648 */
+"l2-speculative-load-ops\000legacy cache\000Level 2 (or higher) last level=
 cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\0=
00\000\000"
+/* offset=3D106774 */
+"l2-speculative-load-reference\000legacy cache\000Level 2 (or higher) last=
 level cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000=
\000\000\000\000"
+/* offset=3D106906 */
+"l2-speculative-load-refs\000legacy cache\000Level 2 (or higher) last leve=
l cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\=
000\000\000"
+/* offset=3D107033 */
+"l2-speculative-read\000legacy cache\000Level 2 (or higher) last level cac=
he prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\0=
00\000"
+/* offset=3D107155 */
+"l2-speculative-read-access\000legacy cache\000Level 2 (or higher) last le=
vel cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\00=
0\000\000\000"
+/* offset=3D107284 */
+"l2-speculative-read-miss\000legacy cache\000Level 2 (or higher) last leve=
l cache prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\=
000\000\000"
+/* offset=3D107411 */
+"l2-speculative-read-misses\000legacy cache\000Level 2 (or higher) last le=
vel cache prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\00=
0\000\000\000"
+/* offset=3D107540 */
+"l2-speculative-read-ops\000legacy cache\000Level 2 (or higher) last level=
 cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\0=
00\000\000"
+/* offset=3D107666 */
+"l2-speculative-read-reference\000legacy cache\000Level 2 (or higher) last=
 level cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000=
\000\000\000\000"
+/* offset=3D107798 */
+"l2-speculative-read-refs\000legacy cache\000Level 2 (or higher) last leve=
l cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\=
000\000\000"
+/* offset=3D107925 */
+"l2-store\000legacy cache\000Level 2 (or higher) last level cache write ac=
cesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D108033 */
+"l2-store-access\000legacy cache\000Level 2 (or higher) last level cache w=
rite accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D108148 */
+"l2-store-miss\000legacy cache\000Level 2 (or higher) last level cache wri=
te misses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\000"
+/* offset=3D108261 */
+"l2-store-misses\000legacy cache\000Level 2 (or higher) last level cache w=
rite misses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\000"
+/* offset=3D108376 */
+"l2-store-ops\000legacy cache\000Level 2 (or higher) last level cache writ=
e accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D108488 */
+"l2-store-reference\000legacy cache\000Level 2 (or higher) last level cach=
e write accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\0=
00"
+/* offset=3D108606 */
+"l2-store-refs\000legacy cache\000Level 2 (or higher) last level cache wri=
te accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D108719 */
+"l2-stores\000legacy cache\000Level 2 (or higher) last level cache write a=
ccesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D108828 */
+"l2-stores-access\000legacy cache\000Level 2 (or higher) last level cache =
write accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000=
"
+/* offset=3D108944 */
+"l2-stores-miss\000legacy cache\000Level 2 (or higher) last level cache wr=
ite misses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\000"
+/* offset=3D109058 */
+"l2-stores-misses\000legacy cache\000Level 2 (or higher) last level cache =
write misses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\000=
"
+/* offset=3D109174 */
+"l2-stores-ops\000legacy cache\000Level 2 (or higher) last level cache wri=
te accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D109287 */
+"l2-stores-reference\000legacy cache\000Level 2 (or higher) last level cac=
he write accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\=
000"
+/* offset=3D109406 */
+"l2-stores-refs\000legacy cache\000Level 2 (or higher) last level cache wr=
ite accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D109520 */
+"l2-write\000legacy cache\000Level 2 (or higher) last level cache write ac=
cesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D109628 */
+"l2-write-access\000legacy cache\000Level 2 (or higher) last level cache w=
rite accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D109743 */
+"l2-write-miss\000legacy cache\000Level 2 (or higher) last level cache wri=
te misses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\000"
+/* offset=3D109856 */
+"l2-write-misses\000legacy cache\000Level 2 (or higher) last level cache w=
rite misses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\000"
+/* offset=3D109971 */
+"l2-write-ops\000legacy cache\000Level 2 (or higher) last level cache writ=
e accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D110083 */
+"l2-write-reference\000legacy cache\000Level 2 (or higher) last level cach=
e write accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\0=
00"
+/* offset=3D110201 */
+"l2-write-refs\000legacy cache\000Level 2 (or higher) last level cache wri=
te accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D110314 */
+"l3_cache_rd\000cache\000L3 cache access, read\000event=3D0x40\000\00000\0=
00\000\000\000Attributable Level 3 cache access, read\000"
+/* offset=3D110412 */
+"llc\000legacy cache\000Last level cache read accesses\000legacy-cache-con=
fig=3D2\000\00010\000\000\000\000\000"
+/* offset=3D110490 */
+"llc-access\000legacy cache\000Last level cache read accesses\000legacy-ca=
che-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D110575 */
+"llc-load\000legacy cache\000Last level cache read accesses\000legacy-cach=
e-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D110658 */
+"llc-load-access\000legacy cache\000Last level cache read accesses\000lega=
cy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D110748 */
+"llc-load-miss\000legacy cache\000Last level cache read misses\000legacy-c=
ache-config=3D0x10002\000\00010\000\000\000\000\000"
+/* offset=3D110840 */
+"llc-load-misses\000legacy cache\000Last level cache read misses\000legacy=
-cache-config=3D0x10002\000\00000\000\000\000\000\000"
+/* offset=3D110934 */
+"llc-load-ops\000legacy cache\000Last level cache read accesses\000legacy-=
cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D111021 */
+"llc-load-reference\000legacy cache\000Last level cache read accesses\000l=
egacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D111114 */
+"llc-load-refs\000legacy cache\000Last level cache read accesses\000legacy=
-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D111202 */
+"llc-loads\000legacy cache\000Last level cache read accesses\000legacy-cac=
he-config=3D2\000\00000\000\000\000\000\000"
+/* offset=3D111286 */
+"llc-loads-access\000legacy cache\000Last level cache read accesses\000leg=
acy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D111377 */
+"llc-loads-miss\000legacy cache\000Last level cache read misses\000legacy-=
cache-config=3D0x10002\000\00010\000\000\000\000\000"
+/* offset=3D111470 */
+"llc-loads-misses\000legacy cache\000Last level cache read misses\000legac=
y-cache-config=3D0x10002\000\00010\000\000\000\000\000"
+/* offset=3D111565 */
+"llc-loads-ops\000legacy cache\000Last level cache read accesses\000legacy=
-cache-config=3D2\000\00010\000\000\000\000\000"
 /* offset=3D111653 */
-"bpc-load-refs\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
+"llc-loads-reference\000legacy cache\000Last level cache read accesses\000=
legacy-cache-config=3D2\000\00010\000\000\000\000\000"
 /* offset=3D111747 */
-"bpc-load-reference\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D111846 */
-"bpc-load-ops\000legacy cache\000Branch prediction unit read accesses\000l=
egacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D111939 */
-"bpc-load-access\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D112035 */
-"bpc-load-misses\000legacy cache\000Branch prediction unit read misses\000=
legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D112135 */
-"bpc-load-miss\000legacy cache\000Branch prediction unit read misses\000le=
gacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D112233 */
-"bpc-loads\000legacy cache\000Branch prediction unit read accesses\000lega=
cy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D112323 */
-"bpc-loads-refs\000legacy cache\000Branch prediction unit read accesses\00=
0legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D112418 */
-"bpc-loads-reference\000legacy cache\000Branch prediction unit read access=
es\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D112518 */
-"bpc-loads-ops\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D112612 */
-"bpc-loads-access\000legacy cache\000Branch prediction unit read accesses\=
000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D112709 */
-"bpc-loads-misses\000legacy cache\000Branch prediction unit read misses\00=
0legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D112810 */
-"bpc-loads-miss\000legacy cache\000Branch prediction unit read misses\000l=
egacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D112909 */
-"bpc-read\000legacy cache\000Branch prediction unit read accesses\000legac=
y-cache-config=3D5\000\00010\000\000\000\000\000"
+"llc-loads-refs\000legacy cache\000Last level cache read accesses\000legac=
y-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D111836 */
+"llc-miss\000legacy cache\000Last level cache read misses\000legacy-cache-=
config=3D0x10002\000\00010\000\000\000\000\000"
+/* offset=3D111923 */
+"llc-misses\000legacy cache\000Last level cache read misses\000legacy-cach=
e-config=3D0x10002\000\00010\000\000\000\000\000"
+/* offset=3D112012 */
+"llc-ops\000legacy cache\000Last level cache read accesses\000legacy-cache=
-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D112094 */
+"llc-prefetch\000legacy cache\000Last level cache prefetch accesses\000leg=
acy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D112189 */
+"llc-prefetch-access\000legacy cache\000Last level cache prefetch accesses=
\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D112291 */
+"llc-prefetch-miss\000legacy cache\000Last level cache prefetch misses\000=
legacy-cache-config=3D0x10202\000\00010\000\000\000\000\000"
+/* offset=3D112391 */
+"llc-prefetch-misses\000legacy cache\000Last level cache prefetch misses\0=
00legacy-cache-config=3D0x10202\000\00000\000\000\000\000\000"
+/* offset=3D112493 */
+"llc-prefetch-ops\000legacy cache\000Last level cache prefetch accesses\00=
0legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D112592 */
+"llc-prefetch-reference\000legacy cache\000Last level cache prefetch acces=
ses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D112697 */
+"llc-prefetch-refs\000legacy cache\000Last level cache prefetch accesses\0=
00legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D112797 */
+"llc-prefetches\000legacy cache\000Last level cache prefetch accesses\000l=
egacy-cache-config=3D0x202\000\00000\000\000\000\000\000"
+/* offset=3D112894 */
+"llc-prefetches-access\000legacy cache\000Last level cache prefetch access=
es\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
 /* offset=3D112998 */
-"bpc-read-refs\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D113092 */
-"bpc-read-reference\000legacy cache\000Branch prediction unit read accesse=
s\000legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D113191 */
-"bpc-read-ops\000legacy cache\000Branch prediction unit read accesses\000l=
egacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D113284 */
-"bpc-read-access\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D113380 */
-"bpc-read-misses\000legacy cache\000Branch prediction unit read misses\000=
legacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D113480 */
-"bpc-read-miss\000legacy cache\000Branch prediction unit read misses\000le=
gacy-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D113578 */
-"bpc-refs\000legacy cache\000Branch prediction unit read accesses\000legac=
y-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D113667 */
-"bpc-reference\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D113761 */
-"bpc-ops\000legacy cache\000Branch prediction unit read accesses\000legacy=
-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D113849 */
-"bpc-access\000legacy cache\000Branch prediction unit read accesses\000leg=
acy-cache-config=3D5\000\00010\000\000\000\000\000"
-/* offset=3D113940 */
-"bpc-misses\000legacy cache\000Branch prediction unit read misses\000legac=
y-cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D114035 */
-"bpc-miss\000legacy cache\000Branch prediction unit read misses\000legacy-=
cache-config=3D0x10005\000\00010\000\000\000\000\000"
-/* offset=3D114128 */
+"llc-prefetches-miss\000legacy cache\000Last level cache prefetch misses\0=
00legacy-cache-config=3D0x10202\000\00010\000\000\000\000\000"
+/* offset=3D113100 */
+"llc-prefetches-misses\000legacy cache\000Last level cache prefetch misses=
\000legacy-cache-config=3D0x10202\000\00010\000\000\000\000\000"
+/* offset=3D113204 */
+"llc-prefetches-ops\000legacy cache\000Last level cache prefetch accesses\=
000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D113305 */
+"llc-prefetches-reference\000legacy cache\000Last level cache prefetch acc=
esses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D113412 */
+"llc-prefetches-refs\000legacy cache\000Last level cache prefetch accesses=
\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D113514 */
+"llc-read\000legacy cache\000Last level cache read accesses\000legacy-cach=
e-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D113597 */
+"llc-read-access\000legacy cache\000Last level cache read accesses\000lega=
cy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D113687 */
+"llc-read-miss\000legacy cache\000Last level cache read misses\000legacy-c=
ache-config=3D0x10002\000\00010\000\000\000\000\000"
+/* offset=3D113779 */
+"llc-read-misses\000legacy cache\000Last level cache read misses\000legacy=
-cache-config=3D0x10002\000\00010\000\000\000\000\000"
+/* offset=3D113873 */
+"llc-read-ops\000legacy cache\000Last level cache read accesses\000legacy-=
cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D113960 */
+"llc-read-reference\000legacy cache\000Last level cache read accesses\000l=
egacy-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D114053 */
+"llc-read-refs\000legacy cache\000Last level cache read accesses\000legacy=
-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D114141 */
+"llc-reference\000legacy cache\000Last level cache read accesses\000legacy=
-cache-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D114229 */
+"llc-refs\000legacy cache\000Last level cache read accesses\000legacy-cach=
e-config=3D2\000\00010\000\000\000\000\000"
+/* offset=3D114312 */
+"llc-speculative-load\000legacy cache\000Last level cache prefetch accesse=
s\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D114415 */
+"llc-speculative-load-access\000legacy cache\000Last level cache prefetch =
accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D114525 */
+"llc-speculative-load-miss\000legacy cache\000Last level cache prefetch mi=
sses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\000\000"
+/* offset=3D114633 */
+"llc-speculative-load-misses\000legacy cache\000Last level cache prefetch =
misses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\000\000"
+/* offset=3D114743 */
+"llc-speculative-load-ops\000legacy cache\000Last level cache prefetch acc=
esses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D114850 */
+"llc-speculative-load-reference\000legacy cache\000Last level cache prefet=
ch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D114963 */
+"llc-speculative-load-refs\000legacy cache\000Last level cache prefetch ac=
cesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D115071 */
+"llc-speculative-read\000legacy cache\000Last level cache prefetch accesse=
s\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D115174 */
+"llc-speculative-read-access\000legacy cache\000Last level cache prefetch =
accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D115284 */
+"llc-speculative-read-miss\000legacy cache\000Last level cache prefetch mi=
sses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\000\000"
+/* offset=3D115392 */
+"llc-speculative-read-misses\000legacy cache\000Last level cache prefetch =
misses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\000\000"
+/* offset=3D115502 */
+"llc-speculative-read-ops\000legacy cache\000Last level cache prefetch acc=
esses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D115609 */
+"llc-speculative-read-reference\000legacy cache\000Last level cache prefet=
ch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D115722 */
+"llc-speculative-read-refs\000legacy cache\000Last level cache prefetch ac=
cesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
+/* offset=3D115830 */
+"llc-store\000legacy cache\000Last level cache write accesses\000legacy-ca=
che-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D115919 */
+"llc-store-access\000legacy cache\000Last level cache write accesses\000le=
gacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D116015 */
+"llc-store-miss\000legacy cache\000Last level cache write misses\000legacy=
-cache-config=3D0x10102\000\00010\000\000\000\000\000"
+/* offset=3D116109 */
+"llc-store-misses\000legacy cache\000Last level cache write misses\000lega=
cy-cache-config=3D0x10102\000\00000\000\000\000\000\000"
+/* offset=3D116205 */
+"llc-store-ops\000legacy cache\000Last level cache write accesses\000legac=
y-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D116298 */
+"llc-store-reference\000legacy cache\000Last level cache write accesses\00=
0legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D116397 */
+"llc-store-refs\000legacy cache\000Last level cache write accesses\000lega=
cy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D116491 */
+"llc-stores\000legacy cache\000Last level cache write accesses\000legacy-c=
ache-config=3D0x102\000\00000\000\000\000\000\000"
+/* offset=3D116581 */
+"llc-stores-access\000legacy cache\000Last level cache write accesses\000l=
egacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D116678 */
+"llc-stores-miss\000legacy cache\000Last level cache write misses\000legac=
y-cache-config=3D0x10102\000\00010\000\000\000\000\000"
+/* offset=3D116773 */
+"llc-stores-misses\000legacy cache\000Last level cache write misses\000leg=
acy-cache-config=3D0x10102\000\00010\000\000\000\000\000"
+/* offset=3D116870 */
+"llc-stores-ops\000legacy cache\000Last level cache write accesses\000lega=
cy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D116964 */
+"llc-stores-reference\000legacy cache\000Last level cache write accesses\0=
00legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D117064 */
+"llc-stores-refs\000legacy cache\000Last level cache write accesses\000leg=
acy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D117159 */
+"llc-write\000legacy cache\000Last level cache write accesses\000legacy-ca=
che-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D117248 */
+"llc-write-access\000legacy cache\000Last level cache write accesses\000le=
gacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D117344 */
+"llc-write-miss\000legacy cache\000Last level cache write misses\000legacy=
-cache-config=3D0x10102\000\00010\000\000\000\000\000"
+/* offset=3D117438 */
+"llc-write-misses\000legacy cache\000Last level cache write misses\000lega=
cy-cache-config=3D0x10102\000\00010\000\000\000\000\000"
+/* offset=3D117534 */
+"llc-write-ops\000legacy cache\000Last level cache write accesses\000legac=
y-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D117627 */
+"llc-write-reference\000legacy cache\000Last level cache write accesses\00=
0legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D117726 */
+"llc-write-refs\000legacy cache\000Last level cache write accesses\000lega=
cy-cache-config=3D0x102\000\00010\000\000\000\000\000"
+/* offset=3D117820 */
+"major-faults\000software\000Number of major page faults. Major faults req=
uire I/O to handle\000config=3D6\000\00000\000\000\000\000\000"
+/* offset=3D117923 */
+"migrations\000software\000Number of times a process has migrated to a new=
 CPU [This event is an alias of cpu-migrations]\000config=3D4\000\00000\000=
\000\000\000\000"
+/* offset=3D118055 */
+"minor-faults\000software\000Number of minor page faults. Minor faults don=
't require I/O to handle\000config=3D5\000\00000\000\000\000\000\000"
+/* offset=3D118164 */
 "node\000legacy cache\000Local memory read accesses\000legacy-cache-config=
=3D6\000\00010\000\000\000\000\000"
-/* offset=3D114203 */
+/* offset=3D118239 */
+"node-access\000legacy cache\000Local memory read accesses\000legacy-cache=
-config=3D6\000\00010\000\000\000\000\000"
+/* offset=3D118321 */
 "node-load\000legacy cache\000Local memory read accesses\000legacy-cache-c=
onfig=3D6\000\00010\000\000\000\000\000"
-/* offset=3D114283 */
-"node-load-refs\000legacy cache\000Local memory read accesses\000legacy-ca=
che-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D114368 */
-"node-load-reference\000legacy cache\000Local memory read accesses\000lega=
cy-cache-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D114458 */
-"node-load-ops\000legacy cache\000Local memory read accesses\000legacy-cac=
he-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D114542 */
+/* offset=3D118401 */
 "node-load-access\000legacy cache\000Local memory read accesses\000legacy-=
cache-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D114629 */
-"node-load-misses\000legacy cache\000Local memory read misses\000legacy-ca=
che-config=3D0x10006\000\00000\000\000\000\000\000"
-/* offset=3D114720 */
+/* offset=3D118488 */
 "node-load-miss\000legacy cache\000Local memory read misses\000legacy-cach=
e-config=3D0x10006\000\00010\000\000\000\000\000"
-/* offset=3D114809 */
+/* offset=3D118577 */
+"node-load-misses\000legacy cache\000Local memory read misses\000legacy-ca=
che-config=3D0x10006\000\00000\000\000\000\000\000"
+/* offset=3D118668 */
+"node-load-ops\000legacy cache\000Local memory read accesses\000legacy-cac=
he-config=3D6\000\00010\000\000\000\000\000"
+/* offset=3D118752 */
+"node-load-reference\000legacy cache\000Local memory read accesses\000lega=
cy-cache-config=3D6\000\00010\000\000\000\000\000"
+/* offset=3D118842 */
+"node-load-refs\000legacy cache\000Local memory read accesses\000legacy-ca=
che-config=3D6\000\00010\000\000\000\000\000"
+/* offset=3D118927 */
 "node-loads\000legacy cache\000Local memory read accesses\000legacy-cache-=
config=3D6\000\00000\000\000\000\000\000"
-/* offset=3D114890 */
-"node-loads-refs\000legacy cache\000Local memory read accesses\000legacy-c=
ache-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D114976 */
-"node-loads-reference\000legacy cache\000Local memory read accesses\000leg=
acy-cache-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D115067 */
-"node-loads-ops\000legacy cache\000Local memory read accesses\000legacy-ca=
che-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D115152 */
+/* offset=3D119008 */
 "node-loads-access\000legacy cache\000Local memory read accesses\000legacy=
-cache-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D115240 */
-"node-loads-misses\000legacy cache\000Local memory read misses\000legacy-c=
ache-config=3D0x10006\000\00010\000\000\000\000\000"
-/* offset=3D115332 */
+/* offset=3D119096 */
 "node-loads-miss\000legacy cache\000Local memory read misses\000legacy-cac=
he-config=3D0x10006\000\00010\000\000\000\000\000"
-/* offset=3D115422 */
+/* offset=3D119186 */
+"node-loads-misses\000legacy cache\000Local memory read misses\000legacy-c=
ache-config=3D0x10006\000\00010\000\000\000\000\000"
+/* offset=3D119278 */
+"node-loads-ops\000legacy cache\000Local memory read accesses\000legacy-ca=
che-config=3D6\000\00010\000\000\000\000\000"
+/* offset=3D119363 */
+"node-loads-reference\000legacy cache\000Local memory read accesses\000leg=
acy-cache-config=3D6\000\00010\000\000\000\000\000"
+/* offset=3D119454 */
+"node-loads-refs\000legacy cache\000Local memory read accesses\000legacy-c=
ache-config=3D6\000\00010\000\000\000\000\000"
+/* offset=3D119540 */
+"node-miss\000legacy cache\000Local memory read misses\000legacy-cache-con=
fig=3D0x10006\000\00010\000\000\000\000\000"
+/* offset=3D119624 */
+"node-misses\000legacy cache\000Local memory read misses\000legacy-cache-c=
onfig=3D0x10006\000\00010\000\000\000\000\000"
+/* offset=3D119710 */
+"node-ops\000legacy cache\000Local memory read accesses\000legacy-cache-co=
nfig=3D6\000\00010\000\000\000\000\000"
+/* offset=3D119789 */
+"node-prefetch\000legacy cache\000Local memory prefetch accesses\000legacy=
-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D119881 */
+"node-prefetch-access\000legacy cache\000Local memory prefetch accesses\00=
0legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D119980 */
+"node-prefetch-miss\000legacy cache\000Local memory prefetch misses\000leg=
acy-cache-config=3D0x10206\000\00010\000\000\000\000\000"
+/* offset=3D120077 */
+"node-prefetch-misses\000legacy cache\000Local memory prefetch misses\000l=
egacy-cache-config=3D0x10206\000\00000\000\000\000\000\000"
+/* offset=3D120176 */
+"node-prefetch-ops\000legacy cache\000Local memory prefetch accesses\000le=
gacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D120272 */
+"node-prefetch-reference\000legacy cache\000Local memory prefetch accesses=
\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D120374 */
+"node-prefetch-refs\000legacy cache\000Local memory prefetch accesses\000l=
egacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D120471 */
+"node-prefetches\000legacy cache\000Local memory prefetch accesses\000lega=
cy-cache-config=3D0x206\000\00000\000\000\000\000\000"
+/* offset=3D120565 */
+"node-prefetches-access\000legacy cache\000Local memory prefetch accesses\=
000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D120666 */
+"node-prefetches-miss\000legacy cache\000Local memory prefetch misses\000l=
egacy-cache-config=3D0x10206\000\00010\000\000\000\000\000"
+/* offset=3D120765 */
+"node-prefetches-misses\000legacy cache\000Local memory prefetch misses\00=
0legacy-cache-config=3D0x10206\000\00010\000\000\000\000\000"
+/* offset=3D120866 */
+"node-prefetches-ops\000legacy cache\000Local memory prefetch accesses\000=
legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D120964 */
+"node-prefetches-reference\000legacy cache\000Local memory prefetch access=
es\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D121068 */
+"node-prefetches-refs\000legacy cache\000Local memory prefetch accesses\00=
0legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D121167 */
 "node-read\000legacy cache\000Local memory read accesses\000legacy-cache-c=
onfig=3D6\000\00010\000\000\000\000\000"
-/* offset=3D115502 */
-"node-read-refs\000legacy cache\000Local memory read accesses\000legacy-ca=
che-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D115587 */
-"node-read-reference\000legacy cache\000Local memory read accesses\000lega=
cy-cache-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D115677 */
-"node-read-ops\000legacy cache\000Local memory read accesses\000legacy-cac=
he-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D115761 */
+/* offset=3D121247 */
 "node-read-access\000legacy cache\000Local memory read accesses\000legacy-=
cache-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D115848 */
-"node-read-misses\000legacy cache\000Local memory read misses\000legacy-ca=
che-config=3D0x10006\000\00010\000\000\000\000\000"
-/* offset=3D115939 */
+/* offset=3D121334 */
 "node-read-miss\000legacy cache\000Local memory read misses\000legacy-cach=
e-config=3D0x10006\000\00010\000\000\000\000\000"
-/* offset=3D116028 */
+/* offset=3D121423 */
+"node-read-misses\000legacy cache\000Local memory read misses\000legacy-ca=
che-config=3D0x10006\000\00010\000\000\000\000\000"
+/* offset=3D121514 */
+"node-read-ops\000legacy cache\000Local memory read accesses\000legacy-cac=
he-config=3D6\000\00010\000\000\000\000\000"
+/* offset=3D121598 */
+"node-read-reference\000legacy cache\000Local memory read accesses\000lega=
cy-cache-config=3D6\000\00010\000\000\000\000\000"
+/* offset=3D121688 */
+"node-read-refs\000legacy cache\000Local memory read accesses\000legacy-ca=
che-config=3D6\000\00010\000\000\000\000\000"
+/* offset=3D121773 */
+"node-reference\000legacy cache\000Local memory read accesses\000legacy-ca=
che-config=3D6\000\00010\000\000\000\000\000"
+/* offset=3D121858 */
+"node-refs\000legacy cache\000Local memory read accesses\000legacy-cache-c=
onfig=3D6\000\00010\000\000\000\000\000"
+/* offset=3D121938 */
+"node-speculative-load\000legacy cache\000Local memory prefetch accesses\0=
00legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D122038 */
+"node-speculative-load-access\000legacy cache\000Local memory prefetch acc=
esses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D122145 */
+"node-speculative-load-miss\000legacy cache\000Local memory prefetch misse=
s\000legacy-cache-config=3D0x10206\000\00010\000\000\000\000\000"
+/* offset=3D122250 */
+"node-speculative-load-misses\000legacy cache\000Local memory prefetch mis=
ses\000legacy-cache-config=3D0x10206\000\00010\000\000\000\000\000"
+/* offset=3D122357 */
+"node-speculative-load-ops\000legacy cache\000Local memory prefetch access=
es\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D122461 */
+"node-speculative-load-reference\000legacy cache\000Local memory prefetch =
accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D122571 */
+"node-speculative-load-refs\000legacy cache\000Local memory prefetch acces=
ses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D122676 */
+"node-speculative-read\000legacy cache\000Local memory prefetch accesses\0=
00legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D122776 */
+"node-speculative-read-access\000legacy cache\000Local memory prefetch acc=
esses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D122883 */
+"node-speculative-read-miss\000legacy cache\000Local memory prefetch misse=
s\000legacy-cache-config=3D0x10206\000\00010\000\000\000\000\000"
+/* offset=3D122988 */
+"node-speculative-read-misses\000legacy cache\000Local memory prefetch mis=
ses\000legacy-cache-config=3D0x10206\000\00010\000\000\000\000\000"
+/* offset=3D123095 */
+"node-speculative-read-ops\000legacy cache\000Local memory prefetch access=
es\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D123199 */
+"node-speculative-read-reference\000legacy cache\000Local memory prefetch =
accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D123309 */
+"node-speculative-read-refs\000legacy cache\000Local memory prefetch acces=
ses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
+/* offset=3D123414 */
 "node-store\000legacy cache\000Local memory write accesses\000legacy-cache=
-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D116114 */
-"node-store-refs\000legacy cache\000Local memory write accesses\000legacy-=
cache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D116205 */
-"node-store-reference\000legacy cache\000Local memory write accesses\000le=
gacy-cache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D116301 */
-"node-store-ops\000legacy cache\000Local memory write accesses\000legacy-c=
ache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D116391 */
+/* offset=3D123500 */
 "node-store-access\000legacy cache\000Local memory write accesses\000legac=
y-cache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D116484 */
-"node-store-misses\000legacy cache\000Local memory write misses\000legacy-=
cache-config=3D0x10106\000\00000\000\000\000\000\000"
-/* offset=3D116577 */
+/* offset=3D123593 */
 "node-store-miss\000legacy cache\000Local memory write misses\000legacy-ca=
che-config=3D0x10106\000\00010\000\000\000\000\000"
-/* offset=3D116668 */
+/* offset=3D123684 */
+"node-store-misses\000legacy cache\000Local memory write misses\000legacy-=
cache-config=3D0x10106\000\00000\000\000\000\000\000"
+/* offset=3D123777 */
+"node-store-ops\000legacy cache\000Local memory write accesses\000legacy-c=
ache-config=3D0x106\000\00010\000\000\000\000\000"
+/* offset=3D123867 */
+"node-store-reference\000legacy cache\000Local memory write accesses\000le=
gacy-cache-config=3D0x106\000\00010\000\000\000\000\000"
+/* offset=3D123963 */
+"node-store-refs\000legacy cache\000Local memory write accesses\000legacy-=
cache-config=3D0x106\000\00010\000\000\000\000\000"
+/* offset=3D124054 */
 "node-stores\000legacy cache\000Local memory write accesses\000legacy-cach=
e-config=3D0x106\000\00000\000\000\000\000\000"
-/* offset=3D116755 */
-"node-stores-refs\000legacy cache\000Local memory write accesses\000legacy=
-cache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D116847 */
-"node-stores-reference\000legacy cache\000Local memory write accesses\000l=
egacy-cache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D116944 */
-"node-stores-ops\000legacy cache\000Local memory write accesses\000legacy-=
cache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D117035 */
+/* offset=3D124141 */
 "node-stores-access\000legacy cache\000Local memory write accesses\000lega=
cy-cache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D117129 */
-"node-stores-misses\000legacy cache\000Local memory write misses\000legacy=
-cache-config=3D0x10106\000\00010\000\000\000\000\000"
-/* offset=3D117223 */
+/* offset=3D124235 */
 "node-stores-miss\000legacy cache\000Local memory write misses\000legacy-c=
ache-config=3D0x10106\000\00010\000\000\000\000\000"
-/* offset=3D117315 */
+/* offset=3D124327 */
+"node-stores-misses\000legacy cache\000Local memory write misses\000legacy=
-cache-config=3D0x10106\000\00010\000\000\000\000\000"
+/* offset=3D124421 */
+"node-stores-ops\000legacy cache\000Local memory write accesses\000legacy-=
cache-config=3D0x106\000\00010\000\000\000\000\000"
+/* offset=3D124512 */
+"node-stores-reference\000legacy cache\000Local memory write accesses\000l=
egacy-cache-config=3D0x106\000\00010\000\000\000\000\000"
+/* offset=3D124609 */
+"node-stores-refs\000legacy cache\000Local memory write accesses\000legacy=
-cache-config=3D0x106\000\00010\000\000\000\000\000"
+/* offset=3D124701 */
 "node-write\000legacy cache\000Local memory write accesses\000legacy-cache=
-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D117401 */
-"node-write-refs\000legacy cache\000Local memory write accesses\000legacy-=
cache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D117492 */
-"node-write-reference\000legacy cache\000Local memory write accesses\000le=
gacy-cache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D117588 */
-"node-write-ops\000legacy cache\000Local memory write accesses\000legacy-c=
ache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D117678 */
+/* offset=3D124787 */
 "node-write-access\000legacy cache\000Local memory write accesses\000legac=
y-cache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D117771 */
-"node-write-misses\000legacy cache\000Local memory write misses\000legacy-=
cache-config=3D0x10106\000\00010\000\000\000\000\000"
-/* offset=3D117864 */
+/* offset=3D124880 */
 "node-write-miss\000legacy cache\000Local memory write misses\000legacy-ca=
che-config=3D0x10106\000\00010\000\000\000\000\000"
-/* offset=3D117955 */
-"node-prefetch\000legacy cache\000Local memory prefetch accesses\000legacy=
-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D118047 */
-"node-prefetch-refs\000legacy cache\000Local memory prefetch accesses\000l=
egacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D118144 */
-"node-prefetch-reference\000legacy cache\000Local memory prefetch accesses=
\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D118246 */
-"node-prefetch-ops\000legacy cache\000Local memory prefetch accesses\000le=
gacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D118342 */
-"node-prefetch-access\000legacy cache\000Local memory prefetch accesses\00=
0legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D118441 */
-"node-prefetch-misses\000legacy cache\000Local memory prefetch misses\000l=
egacy-cache-config=3D0x10206\000\00000\000\000\000\000\000"
-/* offset=3D118540 */
-"node-prefetch-miss\000legacy cache\000Local memory prefetch misses\000leg=
acy-cache-config=3D0x10206\000\00010\000\000\000\000\000"
-/* offset=3D118637 */
-"node-prefetches\000legacy cache\000Local memory prefetch accesses\000lega=
cy-cache-config=3D0x206\000\00000\000\000\000\000\000"
-/* offset=3D118731 */
-"node-prefetches-refs\000legacy cache\000Local memory prefetch accesses\00=
0legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D118830 */
-"node-prefetches-reference\000legacy cache\000Local memory prefetch access=
es\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D118934 */
-"node-prefetches-ops\000legacy cache\000Local memory prefetch accesses\000=
legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D119032 */
-"node-prefetches-access\000legacy cache\000Local memory prefetch accesses\=
000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D119133 */
-"node-prefetches-misses\000legacy cache\000Local memory prefetch misses\00=
0legacy-cache-config=3D0x10206\000\00010\000\000\000\000\000"
-/* offset=3D119234 */
-"node-prefetches-miss\000legacy cache\000Local memory prefetch misses\000l=
egacy-cache-config=3D0x10206\000\00010\000\000\000\000\000"
-/* offset=3D119333 */
-"node-speculative-read\000legacy cache\000Local memory prefetch accesses\0=
00legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D119433 */
-"node-speculative-read-refs\000legacy cache\000Local memory prefetch acces=
ses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D119538 */
-"node-speculative-read-reference\000legacy cache\000Local memory prefetch =
accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D119648 */
-"node-speculative-read-ops\000legacy cache\000Local memory prefetch access=
es\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D119752 */
-"node-speculative-read-access\000legacy cache\000Local memory prefetch acc=
esses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D119859 */
-"node-speculative-read-misses\000legacy cache\000Local memory prefetch mis=
ses\000legacy-cache-config=3D0x10206\000\00010\000\000\000\000\000"
-/* offset=3D119966 */
-"node-speculative-read-miss\000legacy cache\000Local memory prefetch misse=
s\000legacy-cache-config=3D0x10206\000\00010\000\000\000\000\000"
-/* offset=3D120071 */
-"node-speculative-load\000legacy cache\000Local memory prefetch accesses\0=
00legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D120171 */
-"node-speculative-load-refs\000legacy cache\000Local memory prefetch acces=
ses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D120276 */
-"node-speculative-load-reference\000legacy cache\000Local memory prefetch =
accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D120386 */
-"node-speculative-load-ops\000legacy cache\000Local memory prefetch access=
es\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D120490 */
-"node-speculative-load-access\000legacy cache\000Local memory prefetch acc=
esses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D120597 */
-"node-speculative-load-misses\000legacy cache\000Local memory prefetch mis=
ses\000legacy-cache-config=3D0x10206\000\00010\000\000\000\000\000"
-/* offset=3D120704 */
-"node-speculative-load-miss\000legacy cache\000Local memory prefetch misse=
s\000legacy-cache-config=3D0x10206\000\00010\000\000\000\000\000"
-/* offset=3D120809 */
-"node-refs\000legacy cache\000Local memory read accesses\000legacy-cache-c=
onfig=3D6\000\00010\000\000\000\000\000"
-/* offset=3D120889 */
-"node-reference\000legacy cache\000Local memory read accesses\000legacy-ca=
che-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D120974 */
-"node-ops\000legacy cache\000Local memory read accesses\000legacy-cache-co=
nfig=3D6\000\00010\000\000\000\000\000"
-/* offset=3D121053 */
-"node-access\000legacy cache\000Local memory read accesses\000legacy-cache=
-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D121135 */
-"node-misses\000legacy cache\000Local memory read misses\000legacy-cache-c=
onfig=3D0x10006\000\00010\000\000\000\000\000"
-/* offset=3D121221 */
-"node-miss\000legacy cache\000Local memory read misses\000legacy-cache-con=
fig=3D0x10006\000\00010\000\000\000\000\000"
-/* offset=3D121305 */
-"cpu-cycles\000legacy hardware\000Total cycles. Be wary of what happens du=
ring CPU frequency scaling [This event is an alias of cycles]\000legacy-har=
dware-config=3D0\000\00000\000\000\000\000\000"
-/* offset=3D121467 */
-"cycles\000legacy hardware\000Total cycles. Be wary of what happens during=
 CPU frequency scaling [This event is an alias of cpu-cycles]\000legacy-har=
dware-config=3D0\000\00000\000\000\000\000\000"
-/* offset=3D121629 */
-"instructions\000legacy hardware\000Retired instructions. Be careful, thes=
e can be affected by various issues, most notably hardware interrupt counts=
\000legacy-hardware-config=3D1\000\00000\000\000\000\000\000"
-/* offset=3D121805 */
-"cache-references\000legacy hardware\000Cache accesses. Usually this indic=
ates Last Level Cache accesses but this may vary depending on your CPU.  Th=
is may include prefetches and coherency messages; again this depends on the=
 design of your CPU\000legacy-hardware-config=3D2\000\00000\000\000\000\000=
\000"
-/* offset=3D122075 */
-"cache-misses\000legacy hardware\000Cache misses. Usually this indicates L=
ast Level Cache misses; this is intended to be used in conjunction with the=
 PERF_COUNT_HW_CACHE_REFERENCES event to calculate cache miss rates\000lega=
cy-hardware-config=3D3\000\00000\000\000\000\000\000"
-/* offset=3D122318 */
-"branches\000legacy hardware\000Retired branch instructions [This event is=
 an alias of branch-instructions]\000legacy-hardware-config=3D4\000\00000\0=
00\000\000\000\000"
-/* offset=3D122452 */
-"branch-instructions\000legacy hardware\000Retired branch instructions [Th=
is event is an alias of branches]\000legacy-hardware-config=3D4\000\00000\0=
00\000\000\000\000"
-/* offset=3D122586 */
-"branch-misses\000legacy hardware\000Mispredicted branch instructions\000l=
egacy-hardware-config=3D5\000\00000\000\000\000\000\000"
-/* offset=3D122682 */
-"bus-cycles\000legacy hardware\000Bus cycles, which can be different from =
total cycles\000legacy-hardware-config=3D6\000\00000\000\000\000\000\000"
-/* offset=3D122795 */
-"stalled-cycles-frontend\000legacy hardware\000Stalled cycles during issue=
 [This event is an alias of idle-cycles-frontend]\000legacy-hardware-config=
=3D7\000\00000\000\000\000\000\000"
-/* offset=3D122945 */
-"idle-cycles-frontend\000legacy hardware\000Stalled cycles during issue [T=
his event is an alias of stalled-cycles-frontend]\000legacy-hardware-config=
=3D7\000\00000\000\000\000\000\000"
-/* offset=3D123095 */
-"stalled-cycles-backend\000legacy hardware\000Stalled cycles during retire=
ment [This event is an alias of idle-cycles-backend]\000legacy-hardware-con=
fig=3D8\000\00000\000\000\000\000\000"
-/* offset=3D123248 */
-"idle-cycles-backend\000legacy hardware\000Stalled cycles during retiremen=
t [This event is an alias of stalled-cycles-backend]\000legacy-hardware-con=
fig=3D8\000\00000\000\000\000\000\000"
-/* offset=3D123401 */
-"ref-cycles\000legacy hardware\000Total cycles; not affected by CPU freque=
ncy scaling\000legacy-hardware-config=3D9\000\00000\000\000\000\000\000"
-/* offset=3D123513 */
-"software\000"
-/* offset=3D123522 */
-"cpu-clock\000software\000Per-CPU high-resolution timer based event\000con=
fig=3D0\000\000001e-6msec\000\000\000\000\000"
-/* offset=3D123608 */
-"task-clock\000software\000Per-task high-resolution timer based event\000c=
onfig=3D1\000\000001e-6msec\000\000\000\000\000"
-/* offset=3D123696 */
-"faults\000software\000Number of page faults [This event is an alias of pa=
ge-faults]\000config=3D2\000\00000\000\000\000\000\000"
-/* offset=3D123791 */
-"page-faults\000software\000Number of page faults [This event is an alias =
of faults]\000config=3D2\000\00000\000\000\000\000\000"
-/* offset=3D123886 */
-"context-switches\000software\000Number of context switches [This event is=
 an alias of cs]\000config=3D3\000\00000\000\000\000\000\000"
-/* offset=3D123987 */
-"cs\000software\000Number of context switches [This event is an alias of c=
ontext-switches]\000config=3D3\000\00000\000\000\000\000\000"
-/* offset=3D124088 */
-"cpu-migrations\000software\000Number of times a process has migrated to a=
 new CPU [This event is an alias of migrations]\000config=3D4\000\00000\000=
\000\000\000\000"
-/* offset=3D124220 */
-"migrations\000software\000Number of times a process has migrated to a new=
 CPU [This event is an alias of cpu-migrations]\000config=3D4\000\00000\000=
\000\000\000\000"
-/* offset=3D124352 */
-"minor-faults\000software\000Number of minor page faults. Minor faults don=
't require I/O to handle\000config=3D5\000\00000\000\000\000\000\000"
-/* offset=3D124461 */
-"major-faults\000software\000Number of major page faults. Major faults req=
uire I/O to handle\000config=3D6\000\00000\000\000\000\000\000"
-/* offset=3D124564 */
-"alignment-faults\000software\000Number of kernel handled memory alignment=
 faults\000config=3D7\000\00000\000\000\000\000\000"
-/* offset=3D124656 */
-"emulation-faults\000software\000Number of kernel handled unimplemented in=
struction faults handled through emulation\000config=3D8\000\00000\000\000\=
000\000\000"
-/* offset=3D124783 */
-"dummy\000software\000A placeholder event that doesn't count anything\000c=
onfig=3D9\000\00000\000\000\000\000\000"
-/* offset=3D124863 */
-"bpf-output\000software\000An event used by BPF programs to write to the p=
erf ring buffer\000config=3D0xa\000\00000\000\000\000\000\000"
-/* offset=3D124965 */
-"cgroup-switches\000software\000Number of context switches to a task in a =
different cgroup\000config=3D0xb\000\00000\000\000\000\000\000"
-/* offset=3D125068 */
-"tool\000"
-/* offset=3D125073 */
-"duration_time\000tool\000Wall clock interval time in nanoseconds\000confi=
g=3D1\000\00000\000\000\000\000\000"
-/* offset=3D125149 */
-"user_time\000tool\000User (non-kernel) time in nanoseconds\000config=3D2\=
000\00000\000\000\000\000\000"
-/* offset=3D125219 */
-"system_time\000tool\000System/kernel time in nanoseconds\000config=3D3\00=
0\00000\000\000\000\000\000"
-/* offset=3D125287 */
-"has_pmem\000tool\0001 if persistent memory installed otherwise 0\000confi=
g=3D4\000\00000\000\000\000\000\000"
-/* offset=3D125363 */
+/* offset=3D124971 */
+"node-write-misses\000legacy cache\000Local memory write misses\000legacy-=
cache-config=3D0x10106\000\00010\000\000\000\000\000"
+/* offset=3D125064 */
+"node-write-ops\000legacy cache\000Local memory write accesses\000legacy-c=
ache-config=3D0x106\000\00010\000\000\000\000\000"
+/* offset=3D125154 */
+"node-write-reference\000legacy cache\000Local memory write accesses\000le=
gacy-cache-config=3D0x106\000\00010\000\000\000\000\000"
+/* offset=3D125250 */
+"node-write-refs\000legacy cache\000Local memory write accesses\000legacy-=
cache-config=3D0x106\000\00010\000\000\000\000\000"
+/* offset=3D125341 */
 "num_cores\000tool\000Number of cores. A core consists of 1 or more thread=
, with each thread being associated with a logical Linux CPU\000config=3D5\=
000\00000\000\000\000\000\000"
-/* offset=3D125508 */
+/* offset=3D125486 */
 "num_cpus\000tool\000Number of logical Linux CPUs. There may be multiple s=
uch CPUs on a core\000config=3D6\000\00000\000\000\000\000\000"
-/* offset=3D125611 */
+/* offset=3D125589 */
 "num_cpus_online\000tool\000Number of online logical Linux CPUs. There may=
 be multiple such CPUs on a core\000config=3D7\000\00000\000\000\000\000\00=
0"
-/* offset=3D125728 */
+/* offset=3D125706 */
 "num_dies\000tool\000Number of dies. Each die has 1 or more cores\000confi=
g=3D8\000\00000\000\000\000\000\000"
-/* offset=3D125804 */
+/* offset=3D125782 */
 "num_packages\000tool\000Number of packages. Each package has 1 or more di=
e\000config=3D9\000\00000\000\000\000\000\000"
-/* offset=3D125890 */
+/* offset=3D125868 */
+"page-faults\000software\000Number of page faults [This event is an alias =
of faults]\000config=3D2\000\00000\000\000\000\000\000"
+/* offset=3D125963 */
+"ref-cycles\000legacy hardware\000Total cycles; not affected by CPU freque=
ncy scaling\000legacy-hardware-config=3D9\000\00000\000\000\000\000\000"
+/* offset=3D126075 */
+"segment_reg_loads.any\000other\000Number of segment register loads\000eve=
nt=3D6,period=3D200000,umask=3D0x80\000\00000\000\000\000\000\000"
+/* offset=3D126177 */
 "slots\000tool\000Number of functional units that in parallel can execute =
parts of an instruction\000config=3D0xa\000\00000\000\000\000\000\000"
-/* offset=3D126000 */
+/* offset=3D126287 */
 "smt_on\000tool\0001 if simultaneous multithreading (aka hyperthreading) i=
s enable otherwise 0\000config=3D0xb\000\00000\000\000\000\000\000"
-/* offset=3D126107 */
+/* offset=3D126394 */
+"software\000"
+/* offset=3D126403 */
+"stalled-cycles-backend\000legacy hardware\000Stalled cycles during retire=
ment [This event is an alias of idle-cycles-backend]\000legacy-hardware-con=
fig=3D8\000\00000\000\000\000\000\000"
+/* offset=3D126556 */
+"stalled-cycles-frontend\000legacy hardware\000Stalled cycles during issue=
 [This event is an alias of idle-cycles-frontend]\000legacy-hardware-config=
=3D7\000\00000\000\000\000\000\000"
+/* offset=3D126706 */
+"sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\000config=3D0x=
2c\0000x01\00000\000\000\000\000\000"
+/* offset=3D126783 */
+"sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache misses in firs=
t lookup result (high priority)\000eventid=3D1,type=3D5\000(434|436|43c|43a=
).*\00000\000\000\000\000\000"
+/* offset=3D126926 */
+"sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles event\000event=3D0=
x2b\000v8\00000\000\000\000\000\000"
+/* offset=3D127002 */
+"system_time\000tool\000System/kernel time in nanoseconds\000config=3D3\00=
0\00000\000\000\000\000\000"
+/* offset=3D127070 */
 "system_tsc_freq\000tool\000The amount a Time Stamp Counter (TSC) increase=
s per second\000config=3D0xc\000\00000\000\000\000\000\000"
-/* offset=3D126206 */
-"core_wide\000tool\0001 if not SMT, if SMT are events being gathered on al=
l SMT threads 1 otherwise 0\000config=3D0xd\000\00000\000\000\000\000\000"
-/* offset=3D126320 */
+/* offset=3D127169 */
 "target_cpu\000tool\0001 if CPUs being analyzed, 0 if threads/processes\00=
0config=3D0xe\000\00000\000\000\000\000\000"
-/* offset=3D126404 */
-"bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=3D0x8a\000\0000=
0\000\000\000\000\000"
-/* offset=3D126466 */
-"bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=3D0x8b\000\0000=
0\000\000\000\000\000"
-/* offset=3D126528 */
-"l3_cache_rd\000cache\000L3 cache access, read\000event=3D0x40\000\00000\0=
00\000\000\000Attributable Level 3 cache access, read\000"
-/* offset=3D126626 */
-"segment_reg_loads.any\000other\000Number of segment register loads\000eve=
nt=3D6,period=3D200000,umask=3D0x80\000\00000\000\000\000\000\000"
-/* offset=3D126728 */
-"dispatch_blocked.any\000other\000Memory cluster signals to block micro-op=
 dispatch for any reason\000event=3D9,period=3D200000,umask=3D0x20\000\0000=
0\000\000\000\000\000"
-/* offset=3D126861 */
-"eist_trans\000other\000Number of Enhanced Intel SpeedStep(R) Technology (=
EIST) transitions\000event=3D0x3a,period=3D200000\000\00000\000\000\000\000=
\000"
-/* offset=3D126979 */
-"hisi_sccl,ddrc\000"
-/* offset=3D126994 */
-"uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands\000event=3D2\=
000\00000\000\000\000\000\000"
-/* offset=3D127064 */
-"uncore_cbox\000"
-/* offset=3D127076 */
+/* offset=3D127253 */
+"task-clock\000software\000Per-task high-resolution timer based event\000c=
onfig=3D1\000\000001e-6msec\000\000\000\000\000"
+/* offset=3D127341 */
+"tool\000"
+/* offset=3D127346 */
 "unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-core snoop resul=
ted from L3 Eviction which misses in some processor core\000event=3D0x22,um=
ask=3D0x81\000\00000\000\000\000\000\000"
-/* offset=3D127230 */
-"event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\000\00000\000\00=
0\000\000\000"
-/* offset=3D127284 */
-"event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0xc0\000\00000\00=
0\000\000\000\000"
-/* offset=3D127342 */
-"hisi_sccl,l3c\000"
-/* offset=3D127356 */
+/* offset=3D127500 */
+"uncore_cbox\000"
+/* offset=3D127512 */
+"uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands\000event=3D2\=
000\00000\000\000\000\000\000"
+/* offset=3D127582 */
 "uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\000event=3D7\00=
0\00000\000\000\000\000\000"
-/* offset=3D127424 */
-"uncore_imc_free_running\000"
-/* offset=3D127448 */
-"uncore_imc_free_running.cache_miss\000uncore\000Total cache misses\000eve=
nt=3D0x12\000\00000\000\000\000\000\000"
-/* offset=3D127528 */
+/* offset=3D127650 */
 "uncore_imc\000"
-/* offset=3D127539 */
+/* offset=3D127661 */
 "uncore_imc.cache_hits\000uncore\000Total cache hits\000event=3D0x34\000\0=
0000\000\000\000\000\000"
-/* offset=3D127604 */
-"uncore_sys_ddr_pmu\000"
-/* offset=3D127623 */
-"sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles event\000event=3D0=
x2b\000v8\00000\000\000\000\000\000"
-/* offset=3D127699 */
+/* offset=3D127726 */
+"uncore_imc_free_running\000"
+/* offset=3D127750 */
+"uncore_imc_free_running.cache_miss\000uncore\000Total cache misses\000eve=
nt=3D0x12\000\00000\000\000\000\000\000"
+/* offset=3D127830 */
 "uncore_sys_ccn_pmu\000"
-/* offset=3D127718 */
-"sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\000config=3D0x=
2c\0000x01\00000\000\000\000\000\000"
-/* offset=3D127795 */
+/* offset=3D127849 */
 "uncore_sys_cmn_pmu\000"
-/* offset=3D127814 */
-"sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache misses in firs=
t lookup result (high priority)\000eventid=3D1,type=3D5\000(434|436|43c|43a=
).*\00000\000\000\000\000\000"
+/* offset=3D127868 */
+"uncore_sys_ddr_pmu\000"
+/* offset=3D127887 */
+"user_time\000tool\000User (non-kernel) time in nanoseconds\000config=3D2\=
000\00000\000\000\000\000\000"
 /* offset=3D127957 */
-"CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=3Dcpu\\-clock@=
 if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@) / (dur=
ation_time * 1e9)\000\000Average CPU utilization\000\0001CPUs\000\000\000\0=
00011"
-/* offset=3D128143 */
-"cs_per_second\000Default\000software@context\\-switches\\,name\\=3Dcontex=
t\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #tar=
get_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\000\000Context=
 switches per CPU second\000\0001cs/sec\000\000\000\000011"
-/* offset=3D128376 */
-"migrations_per_second\000Default\000software@cpu\\-migrations\\,name\\=3D=
cpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if =
#target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\000\000Pro=
cess migrations to a new CPU per CPU second\000\0001migrations/sec\000\000\=
000\000011"
-/* offset=3D128636 */
-"page_faults_per_second\000Default\000software@page\\-faults\\,name\\=3Dpa=
ge\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #targ=
et_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\000\000Page fau=
lts per CPU second\000\0001faults/sec\000\000\000\000011"
-/* offset=3D128867 */
-"insn_per_cycle\000Default\000instructions / cpu\\-cycles\000insn_per_cycl=
e < 1\000Instructions Per Cycle\000\0001instructions\000\000\000\000001"
-/* offset=3D128980 */
-"stalled_cycles_per_instruction\000Default\000(max(stalled\\-cycles\\-fron=
tend, stalled\\-cycles\\-backend) / instructions if has_event(stalled\\-cyc=
les\\-frontend) & has_event(stalled\\-cycles\\-backend) else (stalled\\-cyc=
les\\-frontend / instructions if has_event(stalled\\-cycles\\-frontend) els=
e (stalled\\-cycles\\-backend / instructions if has_event(stalled\\-cycles\=
\-backend) else 0)))\000\000Max front or backend stalls per instruction\000=
\000\000\000\000\000001"
-/* offset=3D129405 */
-"frontend_cycles_idle\000Default\000(stalled\\-cycles\\-frontend / cpu\\-c=
ycles if has_event(stalled\\-cycles\\-frontend) else 0)\000frontend_cycles_=
idle > 0.1\000Frontend stalls per cycle\000\000\000\000\000\000001"
-/* offset=3D129584 */
-"backend_cycles_idle\000Default\000(stalled\\-cycles\\-backend / cpu\\-cyc=
les if has_event(stalled\\-cycles\\-backend) else 0)\000backend_cycles_idle=
 > 0.2\000Backend stalls per cycle\000\000\000\000\000\000001"
-/* offset=3D129758 */
-"cycles_frequency\000Default\000cpu\\-cycles / (software@cpu\\-clock\\,nam=
e\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtas=
k\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\000\000\000011"
-/* offset=3D129934 */
-"branch_frequency\000Default\000branches / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Branches per CPU second\000\0001000M/sec\000\000\000\000011=
"
-/* offset=3D130114 */
-"branch_miss_rate\000Default\000branch\\-misses / branches\000branch_miss_=
rate > 0.05\000Branch miss rate\000\000100%\000\000\000\000001"
-/* offset=3D130218 */
-"l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-misses / L1\\-dcache\\-=
loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000\000100%\000\000\000\000=
001"
-/* offset=3D130334 */
-"llc_miss_rate\000Default2\000LLC\\-load\\-misses / LLC\\-loads\000llc_mis=
s_rate > 0.05\000LLC miss rate\000\000100%\000\000\000\000001"
-/* offset=3D130435 */
-"l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-misses / L1\\-icache\\-=
loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\000100%\000\000\000\0000=
01"
-/* offset=3D130550 */
-"dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses / dTLB\\-loads\000dtlb=
_miss_rate > 0.05\000dTLB miss rate\000\000100%\000\000\000\000001"
-/* offset=3D130656 */
-"itlb_miss_rate\000Default3\000iTLB\\-load\\-misses / iTLB\\-loads\000itlb=
_miss_rate > 0.05\000iTLB miss rate\000\000100%\000\000\000\000001"
-/* offset=3D130762 */
-"l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-prefetch\\-misses / L1=
\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0.05\000L1 prefetch miss =
rate\000\000100%\000\000\000\000001"
-/* offset=3D130910 */
 "CPI\000\0001 / IPC\000\000\000\000\000\000\000\000000"
-/* offset=3D130933 */
-"IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\000\000\000\0=
00\000\000\000\000000"
-/* offset=3D130997 */
-"Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * (cpu_clk_unh=
alted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalt=
ed.ref_xclk)))\000\000\000\000\000\000\000\000000"
-/* offset=3D131164 */
-"dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.any\000\000\00=
0\000\000\000\000\000000"
-/* offset=3D131229 */
-"icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired.any\000\000=
\000\000\000\000\000\000000"
-/* offset=3D131297 */
-"cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_cycles\000\0=
00\000\000\000\000\000\000000"
-/* offset=3D131369 */
+/* offset=3D127980 */
+"CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=3Dcpu\\-clock@=
 if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@) / (dur=
ation_time * 1e9)\000\000Average CPU utilization\000\0001CPUs\000\000\000\0=
00011"
+/* offset=3D128166 */
+"DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\000\000\000\=
000\000\000\000\000000"
+/* offset=3D128231 */
 "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit +=
 l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000"
-/* offset=3D131464 */
+/* offset=3D128326 */
 "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd - l2_rqsts.dema=
nd_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000\000\000\000\0=
00\000\000\000000"
-/* offset=3D131599 */
-"DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\000\000\000\=
000\000\000\000\000000"
-/* offset=3D131664 */
+/* offset=3D128461 */
 "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2_All)\000\000\=
000\000\000\000\000\000000"
-/* offset=3D131733 */
+/* offset=3D128530 */
 "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_L2_All)\000\00=
0\000\000\000\000\000\000000"
-/* offset=3D131804 */
+/* offset=3D128601 */
+"Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * (cpu_clk_unh=
alted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalt=
ed.ref_xclk)))\000\000\000\000\000\000\000\000000"
+/* offset=3D128768 */
+"IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\000\000\000\0=
00\000\000\000\000000"
+/* offset=3D128832 */
+"L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duration_time\000\0=
00\000\000\000\000\000\000000"
+/* offset=3D128904 */
 "M1\000\000ipc + M2\000\000\000\000\000\000\000\000000"
-/* offset=3D131827 */
+/* offset=3D128927 */
 "M2\000\000ipc + M1\000\000\000\000\000\000\000\000000"
-/* offset=3D131850 */
+/* offset=3D128950 */
 "M3\000\0001 / M3\000\000\000\000\000\000\000\000000"
-/* offset=3D131871 */
-"L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duration_time\000\0=
00\000\000\000\000\000\000000"
+/* offset=3D128971 */
+"backend_cycles_idle\000Default\000(stalled\\-cycles\\-backend / cpu\\-cyc=
les if has_event(stalled\\-cycles\\-backend) else 0)\000backend_cycles_idle=
 > 0.2\000Backend stalls per cycle\000\000\000\000\000\000001"
+/* offset=3D129145 */
+"branch_frequency\000Default\000branches / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Branches per CPU second\000\0001000M/sec\000\000\000\000011=
"
+/* offset=3D129325 */
+"branch_miss_rate\000Default\000branch\\-misses / branches\000branch_miss_=
rate > 0.05\000Branch miss rate\000\000100%\000\000\000\000001"
+/* offset=3D129429 */
+"cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_cycles\000\0=
00\000\000\000\000\000\000000"
+/* offset=3D129501 */
+"cs_per_second\000Default\000software@context\\-switches\\,name\\=3Dcontex=
t\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #tar=
get_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\000\000Context=
 switches per CPU second\000\0001cs/sec\000\000\000\000011"
+/* offset=3D129734 */
+"cycles_frequency\000Default\000cpu\\-cycles / (software@cpu\\-clock\\,nam=
e\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtas=
k\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\000\000\000011"
+/* offset=3D129910 */
+"dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.any\000\000\00=
0\000\000\000\000\000000"
+/* offset=3D129975 */
+"dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses / dTLB\\-loads\000dtlb=
_miss_rate > 0.05\000dTLB miss rate\000\000100%\000\000\000\000001"
+/* offset=3D130081 */
+"frontend_cycles_idle\000Default\000(stalled\\-cycles\\-frontend / cpu\\-c=
ycles if has_event(stalled\\-cycles\\-frontend) else 0)\000frontend_cycles_=
idle > 0.1\000Frontend stalls per cycle\000\000\000\000\000\000001"
+/* offset=3D130260 */
+"icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired.any\000\000=
\000\000\000\000\000\000000"
+/* offset=3D130328 */
+"insn_per_cycle\000Default\000instructions / cpu\\-cycles\000insn_per_cycl=
e < 1\000Instructions Per Cycle\000\0001instructions\000\000\000\000001"
+/* offset=3D130441 */
+"itlb_miss_rate\000Default3\000iTLB\\-load\\-misses / iTLB\\-loads\000itlb=
_miss_rate > 0.05\000iTLB miss rate\000\000100%\000\000\000\000001"
+/* offset=3D130547 */
+"l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-prefetch\\-misses / L1=
\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0.05\000L1 prefetch miss =
rate\000\000100%\000\000\000\000001"
+/* offset=3D130695 */
+"l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-misses / L1\\-dcache\\-=
loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000\000100%\000\000\000\000=
001"
+/* offset=3D130811 */
+"l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-misses / L1\\-icache\\-=
loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\000100%\000\000\000\0000=
01"
+/* offset=3D130926 */
+"llc_miss_rate\000Default2\000LLC\\-load\\-misses / LLC\\-loads\000llc_mis=
s_rate > 0.05\000LLC miss rate\000\000100%\000\000\000\000001"
+/* offset=3D131027 */
+"migrations_per_second\000Default\000software@cpu\\-migrations\\,name\\=3D=
cpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if =
#target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\000\000Pro=
cess migrations to a new CPU per CPU second\000\0001migrations/sec\000\000\=
000\000011"
+/* offset=3D131287 */
+"page_faults_per_second\000Default\000software@page\\-faults\\,name\\=3Dpa=
ge\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #targ=
et_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\000\000Page fau=
lts per CPU second\000\0001faults/sec\000\000\000\000011"
+/* offset=3D131518 */
+"stalled_cycles_per_instruction\000Default\000(max(stalled\\-cycles\\-fron=
tend, stalled\\-cycles\\-backend) / instructions if has_event(stalled\\-cyc=
les\\-frontend) & has_event(stalled\\-cycles\\-backend) else (stalled\\-cyc=
les\\-frontend / instructions if has_event(stalled\\-cycles\\-frontend) els=
e (stalled\\-cycles\\-backend / instructions if has_event(stalled\\-cycles\=
\-backend) else 0)))\000\000Max front or backend stalls per instruction\000=
\000\000\000\000\000001"
 ;
=20
 static const struct compact_pmu_event pmu_events__common_default_core[] =
=3D {
 	/* bpc\000legacy cache\000Branch prediction unit read accesses\000legacy-=
cache-conf... */
-	{ 111480 },
+	{ 216 },
 	/* bpc-access\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cac... */
-	{ 113849 },
+	{ 300 },
 	/* bpc-load\000legacy cache\000Branch prediction unit read accesses\000le=
gacy-cache... */
-	{ 111564 },
+	{ 391 },
 	/* bpc-load-access\000legacy cache\000Branch prediction unit read accesse=
s\000legac... */
-	{ 111939 },
+	{ 480 },
 	/* bpc-load-miss\000legacy cache\000Branch prediction unit read misses\00=
0legacy-ca... */
-	{ 112135 },
+	{ 576 },
 	/* bpc-load-misses\000legacy cache\000Branch prediction unit read misses\=
000legacy-... */
-	{ 112035 },
+	{ 674 },
 	/* bpc-load-ops\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-c... */
-	{ 111846 },
+	{ 774 },
 	/* bpc-load-reference\000legacy cache\000Branch prediction unit read acce=
sses\000le... */
-	{ 111747 },
+	{ 867 },
 	/* bpc-load-refs\000legacy cache\000Branch prediction unit read accesses\=
000legacy-... */
-	{ 111653 },
+	{ 966 },
 	/* bpc-loads\000legacy cache\000Branch prediction unit read accesses\000l=
egacy-cach... */
-	{ 112233 },
+	{ 1060 },
 	/* bpc-loads-access\000legacy cache\000Branch prediction unit read access=
es\000lega... */
-	{ 112612 },
+	{ 1150 },
 	/* bpc-loads-miss\000legacy cache\000Branch prediction unit read misses\0=
00legacy-c... */
-	{ 112810 },
+	{ 1247 },
 	/* bpc-loads-misses\000legacy cache\000Branch prediction unit read misses=
\000legacy... */
-	{ 112709 },
+	{ 1346 },
 	/* bpc-loads-ops\000legacy cache\000Branch prediction unit read accesses\=
000legacy-... */
-	{ 112518 },
+	{ 1447 },
 	/* bpc-loads-reference\000legacy cache\000Branch prediction unit read acc=
esses\000l... */
-	{ 112418 },
+	{ 1541 },
 	/* bpc-loads-refs\000legacy cache\000Branch prediction unit read accesses=
\000legacy... */
-	{ 112323 },
+	{ 1641 },
 	/* bpc-miss\000legacy cache\000Branch prediction unit read misses\000lega=
cy-cache-c... */
-	{ 114035 },
+	{ 1736 },
 	/* bpc-misses\000legacy cache\000Branch prediction unit read misses\000le=
gacy-cache... */
-	{ 113940 },
+	{ 1829 },
 	/* bpc-ops\000legacy cache\000Branch prediction unit read accesses\000leg=
acy-cache-... */
-	{ 113761 },
+	{ 1924 },
 	/* bpc-read\000legacy cache\000Branch prediction unit read accesses\000le=
gacy-cache... */
-	{ 112909 },
+	{ 2012 },
 	/* bpc-read-access\000legacy cache\000Branch prediction unit read accesse=
s\000legac... */
-	{ 113284 },
+	{ 2101 },
 	/* bpc-read-miss\000legacy cache\000Branch prediction unit read misses\00=
0legacy-ca... */
-	{ 113480 },
+	{ 2197 },
 	/* bpc-read-misses\000legacy cache\000Branch prediction unit read misses\=
000legacy-... */
-	{ 113380 },
+	{ 2295 },
 	/* bpc-read-ops\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-c... */
-	{ 113191 },
+	{ 2395 },
 	/* bpc-read-reference\000legacy cache\000Branch prediction unit read acce=
sses\000le... */
-	{ 113092 },
+	{ 2488 },
 	/* bpc-read-refs\000legacy cache\000Branch prediction unit read accesses\=
000legacy-... */
-	{ 112998 },
+	{ 2587 },
 	/* bpc-reference\000legacy cache\000Branch prediction unit read accesses\=
000legacy-... */
-	{ 113667 },
+	{ 2681 },
 	/* bpc-refs\000legacy cache\000Branch prediction unit read accesses\000le=
gacy-cache... */
-	{ 113578 },
+	{ 2775 },
 	/* bpu\000legacy cache\000Branch prediction unit read accesses\000legacy-=
cache-conf... */
-	{ 106184 },
+	{ 2966 },
 	/* bpu-access\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cac... */
-	{ 108553 },
+	{ 3050 },
 	/* bpu-load\000legacy cache\000Branch prediction unit read accesses\000le=
gacy-cache... */
-	{ 106268 },
+	{ 3141 },
 	/* bpu-load-access\000legacy cache\000Branch prediction unit read accesse=
s\000legac... */
-	{ 106643 },
+	{ 3230 },
 	/* bpu-load-miss\000legacy cache\000Branch prediction unit read misses\00=
0legacy-ca... */
-	{ 106839 },
+	{ 3326 },
 	/* bpu-load-misses\000legacy cache\000Branch prediction unit read misses\=
000legacy-... */
-	{ 106739 },
+	{ 3424 },
 	/* bpu-load-ops\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-c... */
-	{ 106550 },
+	{ 3524 },
 	/* bpu-load-reference\000legacy cache\000Branch prediction unit read acce=
sses\000le... */
-	{ 106451 },
+	{ 3617 },
 	/* bpu-load-refs\000legacy cache\000Branch prediction unit read accesses\=
000legacy-... */
-	{ 106357 },
+	{ 3716 },
 	/* bpu-loads\000legacy cache\000Branch prediction unit read accesses\000l=
egacy-cach... */
-	{ 106937 },
+	{ 3810 },
 	/* bpu-loads-access\000legacy cache\000Branch prediction unit read access=
es\000lega... */
-	{ 107316 },
+	{ 3900 },
 	/* bpu-loads-miss\000legacy cache\000Branch prediction unit read misses\0=
00legacy-c... */
-	{ 107514 },
+	{ 3997 },
 	/* bpu-loads-misses\000legacy cache\000Branch prediction unit read misses=
\000legacy... */
-	{ 107413 },
+	{ 4096 },
 	/* bpu-loads-ops\000legacy cache\000Branch prediction unit read accesses\=
000legacy-... */
-	{ 107222 },
+	{ 4197 },
 	/* bpu-loads-reference\000legacy cache\000Branch prediction unit read acc=
esses\000l... */
-	{ 107122 },
+	{ 4291 },
 	/* bpu-loads-refs\000legacy cache\000Branch prediction unit read accesses=
\000legacy... */
-	{ 107027 },
+	{ 4391 },
 	/* bpu-miss\000legacy cache\000Branch prediction unit read misses\000lega=
cy-cache-c... */
-	{ 108739 },
+	{ 4486 },
 	/* bpu-misses\000legacy cache\000Branch prediction unit read misses\000le=
gacy-cache... */
-	{ 108644 },
+	{ 4579 },
 	/* bpu-ops\000legacy cache\000Branch prediction unit read accesses\000leg=
acy-cache-... */
-	{ 108465 },
+	{ 4674 },
 	/* bpu-read\000legacy cache\000Branch prediction unit read accesses\000le=
gacy-cache... */
-	{ 107613 },
+	{ 4762 },
 	/* bpu-read-access\000legacy cache\000Branch prediction unit read accesse=
s\000legac... */
-	{ 107988 },
+	{ 4851 },
 	/* bpu-read-miss\000legacy cache\000Branch prediction unit read misses\00=
0legacy-ca... */
-	{ 108184 },
+	{ 4947 },
 	/* bpu-read-misses\000legacy cache\000Branch prediction unit read misses\=
000legacy-... */
-	{ 108084 },
+	{ 5045 },
 	/* bpu-read-ops\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-c... */
-	{ 107895 },
+	{ 5145 },
 	/* bpu-read-reference\000legacy cache\000Branch prediction unit read acce=
sses\000le... */
-	{ 107796 },
+	{ 5238 },
 	/* bpu-read-refs\000legacy cache\000Branch prediction unit read accesses\=
000legacy-... */
-	{ 107702 },
+	{ 5337 },
 	/* bpu-reference\000legacy cache\000Branch prediction unit read accesses\=
000legacy-... */
-	{ 108371 },
+	{ 5431 },
 	/* bpu-refs\000legacy cache\000Branch prediction unit read accesses\000le=
gacy-cache... */
-	{ 108282 },
+	{ 5525 },
 	/* branch\000legacy cache\000Branch prediction unit read accesses\000lega=
cy-cache-c... */
-	{ 100851 },
+	{ 5614 },
 	/* branch-access\000legacy cache\000Branch prediction unit read accesses\=
000legacy-... */
-	{ 103295 },
+	{ 5701 },
 	/* branch-instructions\000legacy hardware\000Retired branch instructions =
[This even... */
-	{ 122452 },
+	{ 5795 },
 	/* branch-load\000legacy cache\000Branch prediction unit read accesses\00=
0legacy-ca... */
-	{ 100938 },
+	{ 5929 },
 	/* branch-load-access\000legacy cache\000Branch prediction unit read acce=
sses\000le... */
-	{ 101325 },
+	{ 6021 },
 	/* branch-load-miss\000legacy cache\000Branch prediction unit read misses=
\000legacy... */
-	{ 101527 },
+	{ 6120 },
 	/* branch-load-misses\000legacy cache\000Branch prediction unit read miss=
es\000lega... */
-	{ 101424 },
+	{ 6221 },
 	/* branch-load-ops\000legacy cache\000Branch prediction unit read accesse=
s\000legac... */
-	{ 101229 },
+	{ 6324 },
 	/* branch-load-reference\000legacy cache\000Branch prediction unit read a=
ccesses\00... */
-	{ 101127 },
+	{ 6420 },
 	/* branch-load-refs\000legacy cache\000Branch prediction unit read access=
es\000lega... */
-	{ 101030 },
+	{ 6522 },
 	/* branch-loads\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-c... */
-	{ 101628 },
+	{ 6619 },
 	/* branch-loads-access\000legacy cache\000Branch prediction unit read acc=
esses\000l... */
-	{ 102019 },
+	{ 6712 },
 	/* branch-loads-miss\000legacy cache\000Branch prediction unit read misse=
s\000legac... */
-	{ 102223 },
+	{ 6812 },
 	/* branch-loads-misses\000legacy cache\000Branch prediction unit read mis=
ses\000leg... */
-	{ 102119 },
+	{ 6914 },
 	/* branch-loads-ops\000legacy cache\000Branch prediction unit read access=
es\000lega... */
-	{ 101922 },
+	{ 7018 },
 	/* branch-loads-reference\000legacy cache\000Branch prediction unit read =
accesses\0... */
-	{ 101819 },
+	{ 7115 },
 	/* branch-loads-refs\000legacy cache\000Branch prediction unit read acces=
ses\000leg... */
-	{ 101721 },
+	{ 7218 },
 	/* branch-miss\000legacy cache\000Branch prediction unit read misses\000l=
egacy-cach... */
-	{ 103389 },
+	{ 7316 },
 	/* branch-misses\000legacy hardware\000Mispredicted branch instructions\0=
00legacy-h... */
-	{ 122586 },
+	{ 7412 },
 	/* branch-ops\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cac... */
-	{ 103204 },
+	{ 7508 },
 	/* branch-read\000legacy cache\000Branch prediction unit read accesses\00=
0legacy-ca... */
-	{ 102325 },
+	{ 7599 },
 	/* branch-read-access\000legacy cache\000Branch prediction unit read acce=
sses\000le... */
-	{ 102712 },
+	{ 7691 },
 	/* branch-read-miss\000legacy cache\000Branch prediction unit read misses=
\000legacy... */
-	{ 102914 },
+	{ 7790 },
 	/* branch-read-misses\000legacy cache\000Branch prediction unit read miss=
es\000lega... */
-	{ 102811 },
+	{ 7891 },
 	/* branch-read-ops\000legacy cache\000Branch prediction unit read accesse=
s\000legac... */
-	{ 102616 },
+	{ 7994 },
 	/* branch-read-reference\000legacy cache\000Branch prediction unit read a=
ccesses\00... */
-	{ 102514 },
+	{ 8090 },
 	/* branch-read-refs\000legacy cache\000Branch prediction unit read access=
es\000lega... */
-	{ 102417 },
+	{ 8192 },
 	/* branch-reference\000legacy cache\000Branch prediction unit read access=
es\000lega... */
-	{ 103107 },
+	{ 8289 },
 	/* branch-refs\000legacy cache\000Branch prediction unit read accesses\00=
0legacy-ca... */
-	{ 103015 },
+	{ 8386 },
 	/* branches\000legacy hardware\000Retired branch instructions [This event=
 is an ali... */
-	{ 122318 },
+	{ 8478 },
 	/* branches-access\000legacy cache\000Branch prediction unit read accesse=
s\000legac... */
-	{ 105890 },
+	{ 8612 },
 	/* branches-load\000legacy cache\000Branch prediction unit read accesses\=
000legacy-... */
-	{ 103485 },
+	{ 8708 },
 	/* branches-load-access\000legacy cache\000Branch prediction unit read ac=
cesses\000... */
-	{ 103880 },
+	{ 8802 },
 	/* branches-load-miss\000legacy cache\000Branch prediction unit read miss=
es\000lega... */
-	{ 104086 },
+	{ 8903 },
 	/* branches-load-misses\000legacy cache\000Branch prediction unit read mi=
sses\000le... */
-	{ 103981 },
+	{ 9006 },
 	/* branches-load-ops\000legacy cache\000Branch prediction unit read acces=
ses\000leg... */
-	{ 103782 },
+	{ 9111 },
 	/* branches-load-reference\000legacy cache\000Branch prediction unit read=
 accesses\... */
-	{ 103678 },
+	{ 9209 },
 	/* branches-load-refs\000legacy cache\000Branch prediction unit read acce=
sses\000le... */
-	{ 103579 },
+	{ 9313 },
 	/* branches-loads\000legacy cache\000Branch prediction unit read accesses=
\000legacy... */
-	{ 104189 },
+	{ 9412 },
 	/* branches-loads-access\000legacy cache\000Branch prediction unit read a=
ccesses\00... */
-	{ 104588 },
+	{ 9507 },
 	/* branches-loads-miss\000legacy cache\000Branch prediction unit read mis=
ses\000leg... */
-	{ 104796 },
+	{ 9609 },
 	/* branches-loads-misses\000legacy cache\000Branch prediction unit read m=
isses\000l... */
-	{ 104690 },
+	{ 9713 },
 	/* branches-loads-ops\000legacy cache\000Branch prediction unit read acce=
sses\000le... */
-	{ 104489 },
+	{ 9819 },
 	/* branches-loads-reference\000legacy cache\000Branch prediction unit rea=
d accesses... */
-	{ 104384 },
+	{ 9918 },
 	/* branches-loads-refs\000legacy cache\000Branch prediction unit read acc=
esses\000l... */
-	{ 104284 },
+	{ 10023 },
 	/* branches-miss\000legacy cache\000Branch prediction unit read misses\00=
0legacy-ca... */
-	{ 106086 },
+	{ 10123 },
 	/* branches-misses\000legacy cache\000Branch prediction unit read misses\=
000legacy-... */
-	{ 105986 },
+	{ 10221 },
 	/* branches-ops\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-c... */
-	{ 105797 },
+	{ 10321 },
 	/* branches-read\000legacy cache\000Branch prediction unit read accesses\=
000legacy-... */
-	{ 104900 },
+	{ 10414 },
 	/* branches-read-access\000legacy cache\000Branch prediction unit read ac=
cesses\000... */
-	{ 105295 },
+	{ 10508 },
 	/* branches-read-miss\000legacy cache\000Branch prediction unit read miss=
es\000lega... */
-	{ 105501 },
+	{ 10609 },
 	/* branches-read-misses\000legacy cache\000Branch prediction unit read mi=
sses\000le... */
-	{ 105396 },
+	{ 10712 },
 	/* branches-read-ops\000legacy cache\000Branch prediction unit read acces=
ses\000leg... */
-	{ 105197 },
+	{ 10817 },
 	/* branches-read-reference\000legacy cache\000Branch prediction unit read=
 accesses\... */
-	{ 105093 },
+	{ 10915 },
 	/* branches-read-refs\000legacy cache\000Branch prediction unit read acce=
sses\000le... */
-	{ 104994 },
+	{ 11019 },
 	/* branches-reference\000legacy cache\000Branch prediction unit read acce=
sses\000le... */
-	{ 105698 },
+	{ 11118 },
 	/* branches-refs\000legacy cache\000Branch prediction unit read accesses\=
000legacy-... */
-	{ 105604 },
+	{ 11217 },
 	/* btb\000legacy cache\000Branch prediction unit read accesses\000legacy-=
cache-conf... */
-	{ 108832 },
+	{ 11311 },
 	/* btb-access\000legacy cache\000Branch prediction unit read accesses\000=
legacy-cac... */
-	{ 111201 },
+	{ 11395 },
 	/* btb-load\000legacy cache\000Branch prediction unit read accesses\000le=
gacy-cache... */
-	{ 108916 },
+	{ 11486 },
 	/* btb-load-access\000legacy cache\000Branch prediction unit read accesse=
s\000legac... */
-	{ 109291 },
+	{ 11575 },
 	/* btb-load-miss\000legacy cache\000Branch prediction unit read misses\00=
0legacy-ca... */
-	{ 109487 },
+	{ 11671 },
 	/* btb-load-misses\000legacy cache\000Branch prediction unit read misses\=
000legacy-... */
-	{ 109387 },
+	{ 11769 },
 	/* btb-load-ops\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-c... */
-	{ 109198 },
+	{ 11869 },
 	/* btb-load-reference\000legacy cache\000Branch prediction unit read acce=
sses\000le... */
-	{ 109099 },
+	{ 11962 },
 	/* btb-load-refs\000legacy cache\000Branch prediction unit read accesses\=
000legacy-... */
-	{ 109005 },
+	{ 12061 },
 	/* btb-loads\000legacy cache\000Branch prediction unit read accesses\000l=
egacy-cach... */
-	{ 109585 },
+	{ 12155 },
 	/* btb-loads-access\000legacy cache\000Branch prediction unit read access=
es\000lega... */
-	{ 109964 },
+	{ 12245 },
 	/* btb-loads-miss\000legacy cache\000Branch prediction unit read misses\0=
00legacy-c... */
-	{ 110162 },
+	{ 12342 },
 	/* btb-loads-misses\000legacy cache\000Branch prediction unit read misses=
\000legacy... */
-	{ 110061 },
+	{ 12441 },
 	/* btb-loads-ops\000legacy cache\000Branch prediction unit read accesses\=
000legacy-... */
-	{ 109870 },
+	{ 12542 },
 	/* btb-loads-reference\000legacy cache\000Branch prediction unit read acc=
esses\000l... */
-	{ 109770 },
+	{ 12636 },
 	/* btb-loads-refs\000legacy cache\000Branch prediction unit read accesses=
\000legacy... */
-	{ 109675 },
+	{ 12736 },
 	/* btb-miss\000legacy cache\000Branch prediction unit read misses\000lega=
cy-cache-c... */
-	{ 111387 },
+	{ 12831 },
 	/* btb-misses\000legacy cache\000Branch prediction unit read misses\000le=
gacy-cache... */
-	{ 111292 },
+	{ 12924 },
 	/* btb-ops\000legacy cache\000Branch prediction unit read accesses\000leg=
acy-cache-... */
-	{ 111113 },
+	{ 13019 },
 	/* btb-read\000legacy cache\000Branch prediction unit read accesses\000le=
gacy-cache... */
-	{ 110261 },
+	{ 13107 },
 	/* btb-read-access\000legacy cache\000Branch prediction unit read accesse=
s\000legac... */
-	{ 110636 },
+	{ 13196 },
 	/* btb-read-miss\000legacy cache\000Branch prediction unit read misses\00=
0legacy-ca... */
-	{ 110832 },
+	{ 13292 },
 	/* btb-read-misses\000legacy cache\000Branch prediction unit read misses\=
000legacy-... */
-	{ 110732 },
+	{ 13390 },
 	/* btb-read-ops\000legacy cache\000Branch prediction unit read accesses\0=
00legacy-c... */
-	{ 110543 },
+	{ 13490 },
 	/* btb-read-reference\000legacy cache\000Branch prediction unit read acce=
sses\000le... */
-	{ 110444 },
+	{ 13583 },
 	/* btb-read-refs\000legacy cache\000Branch prediction unit read accesses\=
000legacy-... */
-	{ 110350 },
+	{ 13682 },
 	/* btb-reference\000legacy cache\000Branch prediction unit read accesses\=
000legacy-... */
-	{ 111019 },
+	{ 13776 },
 	/* btb-refs\000legacy cache\000Branch prediction unit read accesses\000le=
gacy-cache... */
-	{ 110930 },
+	{ 13870 },
 	/* bus-cycles\000legacy hardware\000Bus cycles, which can be different fr=
om total c... */
-	{ 122682 },
+	{ 13959 },
 	/* cache-misses\000legacy hardware\000Cache misses. Usually this indicate=
s Last Lev... */
-	{ 122075 },
+	{ 14072 },
 	/* cache-references\000legacy hardware\000Cache accesses. Usually this in=
dicates La... */
-	{ 121805 },
+	{ 14315 },
 	/* cpu-cycles\000legacy hardware\000Total cycles. Be wary of what happens=
 during CP... */
-	{ 121305 },
+	{ 14989 },
 	/* cycles\000legacy hardware\000Total cycles. Be wary of what happens dur=
ing CPU fr... */
-	{ 121467 },
+	{ 15384 },
 	/* d-tlb\000legacy cache\000Data TLB read accesses\000legacy-cache-config=
=3D3\000\000... */
-	{ 78952 },
+	{ 15546 },
 	/* d-tlb-access\000legacy cache\000Data TLB read accesses\000legacy-cache=
-config=3D3\... */
-	{ 85655 },
+	{ 15618 },
 	/* d-tlb-load\000legacy cache\000Data TLB read accesses\000legacy-cache-c=
onfig=3D3\00... */
-	{ 79024 },
+	{ 15697 },
 	/* d-tlb-load-access\000legacy cache\000Data TLB read accesses\000legacy-=
cache-conf... */
-	{ 79351 },
+	{ 15774 },
 	/* d-tlb-load-miss\000legacy cache\000Data TLB read misses\000legacy-cach=
e-config=3D0... */
-	{ 79523 },
+	{ 15858 },
 	/* d-tlb-load-misses\000legacy cache\000Data TLB read misses\000legacy-ca=
che-config... */
-	{ 79435 },
+	{ 15944 },
 	/* d-tlb-load-ops\000legacy cache\000Data TLB read accesses\000legacy-cac=
he-config=3D... */
-	{ 79270 },
+	{ 16032 },
 	/* d-tlb-load-reference\000legacy cache\000Data TLB read accesses\000lega=
cy-cache-c... */
-	{ 79183 },
+	{ 16113 },
 	/* d-tlb-load-refs\000legacy cache\000Data TLB read accesses\000legacy-ca=
che-config... */
-	{ 79101 },
+	{ 16200 },
 	/* d-tlb-loads\000legacy cache\000Data TLB read accesses\000legacy-cache-=
config=3D3\0... */
-	{ 79609 },
+	{ 16282 },
 	/* d-tlb-loads-access\000legacy cache\000Data TLB read accesses\000legacy=
-cache-con... */
-	{ 79940 },
+	{ 16360 },
 	/* d-tlb-loads-miss\000legacy cache\000Data TLB read misses\000legacy-cac=
he-config=3D... */
-	{ 80114 },
+	{ 16445 },
 	/* d-tlb-loads-misses\000legacy cache\000Data TLB read misses\000legacy-c=
ache-confi... */
-	{ 80025 },
+	{ 16532 },
 	/* d-tlb-loads-ops\000legacy cache\000Data TLB read accesses\000legacy-ca=
che-config... */
-	{ 79858 },
+	{ 16621 },
 	/* d-tlb-loads-reference\000legacy cache\000Data TLB read accesses\000leg=
acy-cache-... */
-	{ 79770 },
+	{ 16703 },
 	/* d-tlb-loads-refs\000legacy cache\000Data TLB read accesses\000legacy-c=
ache-confi... */
-	{ 79687 },
+	{ 16791 },
 	/* d-tlb-miss\000legacy cache\000Data TLB read misses\000legacy-cache-con=
fig=3D0x1000... */
-	{ 85817 },
+	{ 16874 },
 	/* d-tlb-misses\000legacy cache\000Data TLB read misses\000legacy-cache-c=
onfig=3D0x10... */
-	{ 85734 },
+	{ 16955 },
 	/* d-tlb-ops\000legacy cache\000Data TLB read accesses\000legacy-cache-co=
nfig=3D3\000... */
-	{ 85579 },
+	{ 17038 },
 	/* d-tlb-prefetch\000legacy cache\000Data TLB prefetch accesses\000legacy=
-cache-con... */
-	{ 82650 },
+	{ 17114 },
 	/* d-tlb-prefetch-access\000legacy cache\000Data TLB prefetch accesses\00=
0legacy-ca... */
-	{ 83025 },
+	{ 17203 },
 	/* d-tlb-prefetch-miss\000legacy cache\000Data TLB prefetch misses\000leg=
acy-cache-... */
-	{ 83217 },
+	{ 17299 },
 	/* d-tlb-prefetch-misses\000legacy cache\000Data TLB prefetch misses\000l=
egacy-cach... */
-	{ 83121 },
+	{ 17393 },
 	/* d-tlb-prefetch-ops\000legacy cache\000Data TLB prefetch accesses\000le=
gacy-cache... */
-	{ 82932 },
+	{ 17489 },
 	/* d-tlb-prefetch-reference\000legacy cache\000Data TLB prefetch accesses=
\000legacy... */
-	{ 82833 },
+	{ 17582 },
 	/* d-tlb-prefetch-refs\000legacy cache\000Data TLB prefetch accesses\000l=
egacy-cach... */
-	{ 82739 },
+	{ 17681 },
 	/* d-tlb-prefetches\000legacy cache\000Data TLB prefetch accesses\000lega=
cy-cache-c... */
-	{ 83311 },
+	{ 17775 },
 	/* d-tlb-prefetches-access\000legacy cache\000Data TLB prefetch accesses\=
000legacy-... */
-	{ 83694 },
+	{ 17866 },
 	/* d-tlb-prefetches-miss\000legacy cache\000Data TLB prefetch misses\000l=
egacy-cach... */
-	{ 83890 },
+	{ 17964 },
 	/* d-tlb-prefetches-misses\000legacy cache\000Data TLB prefetch misses\00=
0legacy-ca... */
-	{ 83792 },
+	{ 18060 },
 	/* d-tlb-prefetches-ops\000legacy cache\000Data TLB prefetch accesses\000=
legacy-cac... */
-	{ 83599 },
+	{ 18158 },
 	/* d-tlb-prefetches-reference\000legacy cache\000Data TLB prefetch access=
es\000lega... */
-	{ 83498 },
+	{ 18253 },
 	/* d-tlb-prefetches-refs\000legacy cache\000Data TLB prefetch accesses\00=
0legacy-ca... */
-	{ 83402 },
+	{ 18354 },
 	/* d-tlb-read\000legacy cache\000Data TLB read accesses\000legacy-cache-c=
onfig=3D3\00... */
-	{ 80201 },
+	{ 18450 },
 	/* d-tlb-read-access\000legacy cache\000Data TLB read accesses\000legacy-=
cache-conf... */
-	{ 80528 },
+	{ 18527 },
 	/* d-tlb-read-miss\000legacy cache\000Data TLB read misses\000legacy-cach=
e-config=3D0... */
-	{ 80700 },
+	{ 18611 },
 	/* d-tlb-read-misses\000legacy cache\000Data TLB read misses\000legacy-ca=
che-config... */
-	{ 80612 },
+	{ 18697 },
 	/* d-tlb-read-ops\000legacy cache\000Data TLB read accesses\000legacy-cac=
he-config=3D... */
-	{ 80447 },
+	{ 18785 },
 	/* d-tlb-read-reference\000legacy cache\000Data TLB read accesses\000lega=
cy-cache-c... */
-	{ 80360 },
+	{ 18866 },
 	/* d-tlb-read-refs\000legacy cache\000Data TLB read accesses\000legacy-ca=
che-config... */
-	{ 80278 },
+	{ 18953 },
 	/* d-tlb-reference\000legacy cache\000Data TLB read accesses\000legacy-ca=
che-config... */
-	{ 85497 },
+	{ 19035 },
 	/* d-tlb-refs\000legacy cache\000Data TLB read accesses\000legacy-cache-c=
onfig=3D3\00... */
-	{ 85420 },
+	{ 19117 },
 	/* d-tlb-speculative-load\000legacy cache\000Data TLB prefetch accesses\0=
00legacy-c... */
-	{ 84703 },
+	{ 19194 },
 	/* d-tlb-speculative-load-access\000legacy cache\000Data TLB prefetch acc=
esses\000l... */
-	{ 85110 },
+	{ 19291 },
 	/* d-tlb-speculative-load-miss\000legacy cache\000Data TLB prefetch misse=
s\000legac... */
-	{ 85318 },
+	{ 19395 },
 	/* d-tlb-speculative-load-misses\000legacy cache\000Data TLB prefetch mis=
ses\000leg... */
-	{ 85214 },
+	{ 19497 },
 	/* d-tlb-speculative-load-ops\000legacy cache\000Data TLB prefetch access=
es\000lega... */
-	{ 85009 },
+	{ 19601 },
 	/* d-tlb-speculative-load-reference\000legacy cache\000Data TLB prefetch =
accesses\0... */
-	{ 84902 },
+	{ 19702 },
 	/* d-tlb-speculative-load-refs\000legacy cache\000Data TLB prefetch acces=
ses\000leg... */
-	{ 84800 },
+	{ 19809 },
 	/* d-tlb-speculative-read\000legacy cache\000Data TLB prefetch accesses\0=
00legacy-c... */
-	{ 83986 },
+	{ 19911 },
 	/* d-tlb-speculative-read-access\000legacy cache\000Data TLB prefetch acc=
esses\000l... */
-	{ 84393 },
+	{ 20008 },
 	/* d-tlb-speculative-read-miss\000legacy cache\000Data TLB prefetch misse=
s\000legac... */
-	{ 84601 },
+	{ 20112 },
 	/* d-tlb-speculative-read-misses\000legacy cache\000Data TLB prefetch mis=
ses\000leg... */
-	{ 84497 },
+	{ 20214 },
 	/* d-tlb-speculative-read-ops\000legacy cache\000Data TLB prefetch access=
es\000lega... */
-	{ 84292 },
+	{ 20318 },
 	/* d-tlb-speculative-read-reference\000legacy cache\000Data TLB prefetch =
accesses\0... */
-	{ 84185 },
+	{ 20419 },
 	/* d-tlb-speculative-read-refs\000legacy cache\000Data TLB prefetch acces=
ses\000leg... */
-	{ 84083 },
+	{ 20526 },
 	/* d-tlb-store\000legacy cache\000Data TLB write accesses\000legacy-cache=
-config=3D0x... */
-	{ 80786 },
+	{ 20628 },
 	/* d-tlb-store-access\000legacy cache\000Data TLB write accesses\000legac=
y-cache-co... */
-	{ 81137 },
+	{ 20711 },
 	/* d-tlb-store-miss\000legacy cache\000Data TLB write misses\000legacy-ca=
che-config... */
-	{ 81317 },
+	{ 20801 },
 	/* d-tlb-store-misses\000legacy cache\000Data TLB write misses\000legacy-=
cache-conf... */
-	{ 81227 },
+	{ 20889 },
 	/* d-tlb-store-ops\000legacy cache\000Data TLB write accesses\000legacy-c=
ache-confi... */
-	{ 81050 },
+	{ 20979 },
 	/* d-tlb-store-reference\000legacy cache\000Data TLB write accesses\000le=
gacy-cache... */
-	{ 80957 },
+	{ 21066 },
 	/* d-tlb-store-refs\000legacy cache\000Data TLB write accesses\000legacy-=
cache-conf... */
-	{ 80869 },
+	{ 21159 },
 	/* d-tlb-stores\000legacy cache\000Data TLB write accesses\000legacy-cach=
e-config=3D0... */
-	{ 81405 },
+	{ 21247 },
 	/* d-tlb-stores-access\000legacy cache\000Data TLB write accesses\000lega=
cy-cache-c... */
-	{ 81760 },
+	{ 21331 },
 	/* d-tlb-stores-miss\000legacy cache\000Data TLB write misses\000legacy-c=
ache-confi... */
-	{ 81942 },
+	{ 21422 },
 	/* d-tlb-stores-misses\000legacy cache\000Data TLB write misses\000legacy=
-cache-con... */
-	{ 81851 },
+	{ 21511 },
 	/* d-tlb-stores-ops\000legacy cache\000Data TLB write accesses\000legacy-=
cache-conf... */
-	{ 81672 },
+	{ 21602 },
 	/* d-tlb-stores-reference\000legacy cache\000Data TLB write accesses\000l=
egacy-cach... */
-	{ 81578 },
+	{ 21690 },
 	/* d-tlb-stores-refs\000legacy cache\000Data TLB write accesses\000legacy=
-cache-con... */
-	{ 81489 },
+	{ 21784 },
 	/* d-tlb-write\000legacy cache\000Data TLB write accesses\000legacy-cache=
-config=3D0x... */
-	{ 82031 },
+	{ 21873 },
 	/* d-tlb-write-access\000legacy cache\000Data TLB write accesses\000legac=
y-cache-co... */
-	{ 82382 },
+	{ 21956 },
 	/* d-tlb-write-miss\000legacy cache\000Data TLB write misses\000legacy-ca=
che-config... */
-	{ 82562 },
+	{ 22046 },
 	/* d-tlb-write-misses\000legacy cache\000Data TLB write misses\000legacy-=
cache-conf... */
-	{ 82472 },
+	{ 22134 },
 	/* d-tlb-write-ops\000legacy cache\000Data TLB write accesses\000legacy-c=
ache-confi... */
-	{ 82295 },
+	{ 22224 },
 	/* d-tlb-write-reference\000legacy cache\000Data TLB write accesses\000le=
gacy-cache... */
-	{ 82202 },
+	{ 22311 },
 	/* d-tlb-write-refs\000legacy cache\000Data TLB write accesses\000legacy-=
cache-conf... */
-	{ 82114 },
+	{ 22404 },
 	/* data-tlb\000legacy cache\000Data TLB read accesses\000legacy-cache-con=
fig=3D3\000\... */
-	{ 85898 },
+	{ 22492 },
 	/* data-tlb-access\000legacy cache\000Data TLB read accesses\000legacy-ca=
che-config... */
-	{ 92823 },
+	{ 22567 },
 	/* data-tlb-load\000legacy cache\000Data TLB read accesses\000legacy-cach=
e-config=3D3... */
-	{ 85973 },
+	{ 22649 },
 	/* data-tlb-load-access\000legacy cache\000Data TLB read accesses\000lega=
cy-cache-c... */
-	{ 86312 },
+	{ 22729 },
 	/* data-tlb-load-miss\000legacy cache\000Data TLB read misses\000legacy-c=
ache-confi... */
-	{ 86490 },
+	{ 22816 },
 	/* data-tlb-load-misses\000legacy cache\000Data TLB read misses\000legacy=
-cache-con... */
-	{ 86399 },
+	{ 22905 },
 	/* data-tlb-load-ops\000legacy cache\000Data TLB read accesses\000legacy-=
cache-conf... */
-	{ 86228 },
+	{ 22996 },
 	/* data-tlb-load-reference\000legacy cache\000Data TLB read accesses\000l=
egacy-cach... */
-	{ 86138 },
+	{ 23080 },
 	/* data-tlb-load-refs\000legacy cache\000Data TLB read accesses\000legacy=
-cache-con... */
-	{ 86053 },
+	{ 23170 },
 	/* data-tlb-loads\000legacy cache\000Data TLB read accesses\000legacy-cac=
he-config=3D... */
-	{ 86579 },
+	{ 23255 },
 	/* data-tlb-loads-access\000legacy cache\000Data TLB read accesses\000leg=
acy-cache-... */
-	{ 86922 },
+	{ 23336 },
 	/* data-tlb-loads-miss\000legacy cache\000Data TLB read misses\000legacy-=
cache-conf... */
-	{ 87102 },
+	{ 23424 },
 	/* data-tlb-loads-misses\000legacy cache\000Data TLB read misses\000legac=
y-cache-co... */
-	{ 87010 },
+	{ 23514 },
 	/* data-tlb-loads-ops\000legacy cache\000Data TLB read accesses\000legacy=
-cache-con... */
-	{ 86837 },
+	{ 23606 },
 	/* data-tlb-loads-reference\000legacy cache\000Data TLB read accesses\000=
legacy-cac... */
-	{ 86746 },
+	{ 23691 },
 	/* data-tlb-loads-refs\000legacy cache\000Data TLB read accesses\000legac=
y-cache-co... */
-	{ 86660 },
+	{ 23782 },
 	/* data-tlb-miss\000legacy cache\000Data TLB read misses\000legacy-cache-=
config=3D0x1... */
-	{ 92991 },
+	{ 23868 },
 	/* data-tlb-misses\000legacy cache\000Data TLB read misses\000legacy-cach=
e-config=3D0... */
-	{ 92905 },
+	{ 23952 },
 	/* data-tlb-ops\000legacy cache\000Data TLB read accesses\000legacy-cache=
-config=3D3\... */
-	{ 92744 },
+	{ 24038 },
 	/* data-tlb-prefetch\000legacy cache\000Data TLB prefetch accesses\000leg=
acy-cache-... */
-	{ 89725 },
+	{ 24117 },
 	/* data-tlb-prefetch-access\000legacy cache\000Data TLB prefetch accesses=
\000legacy... */
-	{ 90112 },
+	{ 24209 },
 	/* data-tlb-prefetch-miss\000legacy cache\000Data TLB prefetch misses\000=
legacy-cac... */
-	{ 90310 },
+	{ 24308 },
 	/* data-tlb-prefetch-misses\000legacy cache\000Data TLB prefetch misses\0=
00legacy-c... */
-	{ 90211 },
+	{ 24405 },
 	/* data-tlb-prefetch-ops\000legacy cache\000Data TLB prefetch accesses\00=
0legacy-ca... */
-	{ 90016 },
+	{ 24504 },
 	/* data-tlb-prefetch-reference\000legacy cache\000Data TLB prefetch acces=
ses\000leg... */
-	{ 89914 },
+	{ 24600 },
 	/* data-tlb-prefetch-refs\000legacy cache\000Data TLB prefetch accesses\0=
00legacy-c... */
-	{ 89817 },
+	{ 24702 },
 	/* data-tlb-prefetches\000legacy cache\000Data TLB prefetch accesses\000l=
egacy-cach... */
-	{ 90407 },
+	{ 24799 },
 	/* data-tlb-prefetches-access\000legacy cache\000Data TLB prefetch access=
es\000lega... */
-	{ 90802 },
+	{ 24893 },
 	/* data-tlb-prefetches-miss\000legacy cache\000Data TLB prefetch misses\0=
00legacy-c... */
-	{ 91004 },
+	{ 24994 },
 	/* data-tlb-prefetches-misses\000legacy cache\000Data TLB prefetch misses=
\000legacy... */
-	{ 90903 },
+	{ 25093 },
 	/* data-tlb-prefetches-ops\000legacy cache\000Data TLB prefetch accesses\=
000legacy-... */
-	{ 90704 },
+	{ 25194 },
 	/* data-tlb-prefetches-reference\000legacy cache\000Data TLB prefetch acc=
esses\000l... */
-	{ 90600 },
+	{ 25292 },
 	/* data-tlb-prefetches-refs\000legacy cache\000Data TLB prefetch accesses=
\000legacy... */
-	{ 90501 },
+	{ 25396 },
 	/* data-tlb-read\000legacy cache\000Data TLB read accesses\000legacy-cach=
e-config=3D3... */
-	{ 87192 },
+	{ 25495 },
 	/* data-tlb-read-access\000legacy cache\000Data TLB read accesses\000lega=
cy-cache-c... */
-	{ 87531 },
+	{ 25575 },
 	/* data-tlb-read-miss\000legacy cache\000Data TLB read misses\000legacy-c=
ache-confi... */
-	{ 87709 },
+	{ 25662 },
 	/* data-tlb-read-misses\000legacy cache\000Data TLB read misses\000legacy=
-cache-con... */
-	{ 87618 },
+	{ 25751 },
 	/* data-tlb-read-ops\000legacy cache\000Data TLB read accesses\000legacy-=
cache-conf... */
-	{ 87447 },
+	{ 25842 },
 	/* data-tlb-read-reference\000legacy cache\000Data TLB read accesses\000l=
egacy-cach... */
-	{ 87357 },
+	{ 25926 },
 	/* data-tlb-read-refs\000legacy cache\000Data TLB read accesses\000legacy=
-cache-con... */
-	{ 87272 },
+	{ 26016 },
 	/* data-tlb-reference\000legacy cache\000Data TLB read accesses\000legacy=
-cache-con... */
-	{ 92659 },
+	{ 26101 },
 	/* data-tlb-refs\000legacy cache\000Data TLB read accesses\000legacy-cach=
e-config=3D3... */
-	{ 92579 },
+	{ 26186 },
 	/* data-tlb-speculative-load\000legacy cache\000Data TLB prefetch accesse=
s\000legac... */
-	{ 91841 },
+	{ 26266 },
 	/* data-tlb-speculative-load-access\000legacy cache\000Data TLB prefetch =
accesses\0... */
-	{ 92260 },
+	{ 26366 },
 	/* data-tlb-speculative-load-miss\000legacy cache\000Data TLB prefetch mi=
sses\000le... */
-	{ 92474 },
+	{ 26473 },
 	/* data-tlb-speculative-load-misses\000legacy cache\000Data TLB prefetch =
misses\000... */
-	{ 92367 },
+	{ 26578 },
 	/* data-tlb-speculative-load-ops\000legacy cache\000Data TLB prefetch acc=
esses\000l... */
-	{ 92156 },
+	{ 26685 },
 	/* data-tlb-speculative-load-reference\000legacy cache\000Data TLB prefet=
ch accesse... */
-	{ 92046 },
+	{ 26789 },
 	/* data-tlb-speculative-load-refs\000legacy cache\000Data TLB prefetch ac=
cesses\000... */
-	{ 91941 },
+	{ 26899 },
 	/* data-tlb-speculative-read\000legacy cache\000Data TLB prefetch accesse=
s\000legac... */
-	{ 91103 },
+	{ 27004 },
 	/* data-tlb-speculative-read-access\000legacy cache\000Data TLB prefetch =
accesses\0... */
-	{ 91522 },
+	{ 27104 },
 	/* data-tlb-speculative-read-miss\000legacy cache\000Data TLB prefetch mi=
sses\000le... */
-	{ 91736 },
+	{ 27211 },
 	/* data-tlb-speculative-read-misses\000legacy cache\000Data TLB prefetch =
misses\000... */
-	{ 91629 },
+	{ 27316 },
 	/* data-tlb-speculative-read-ops\000legacy cache\000Data TLB prefetch acc=
esses\000l... */
-	{ 91418 },
+	{ 27423 },
 	/* data-tlb-speculative-read-reference\000legacy cache\000Data TLB prefet=
ch accesse... */
-	{ 91308 },
+	{ 27527 },
 	/* data-tlb-speculative-read-refs\000legacy cache\000Data TLB prefetch ac=
cesses\000... */
-	{ 91203 },
+	{ 27637 },
 	/* data-tlb-store\000legacy cache\000Data TLB write accesses\000legacy-ca=
che-config... */
-	{ 87798 },
+	{ 27742 },
 	/* data-tlb-store-access\000legacy cache\000Data TLB write accesses\000le=
gacy-cache... */
-	{ 88161 },
+	{ 27828 },
 	/* data-tlb-store-miss\000legacy cache\000Data TLB write misses\000legacy=
-cache-con... */
-	{ 88347 },
+	{ 27921 },
 	/* data-tlb-store-misses\000legacy cache\000Data TLB write misses\000lega=
cy-cache-c... */
-	{ 88254 },
+	{ 28012 },
 	/* data-tlb-store-ops\000legacy cache\000Data TLB write accesses\000legac=
y-cache-co... */
-	{ 88071 },
+	{ 28105 },
 	/* data-tlb-store-reference\000legacy cache\000Data TLB write accesses\00=
0legacy-ca... */
-	{ 87975 },
+	{ 28195 },
 	/* data-tlb-store-refs\000legacy cache\000Data TLB write accesses\000lega=
cy-cache-c... */
-	{ 87884 },
+	{ 28291 },
 	/* data-tlb-stores\000legacy cache\000Data TLB write accesses\000legacy-c=
ache-confi... */
-	{ 88438 },
+	{ 28382 },
 	/* data-tlb-stores-access\000legacy cache\000Data TLB write accesses\000l=
egacy-cach... */
-	{ 88805 },
+	{ 28469 },
 	/* data-tlb-stores-miss\000legacy cache\000Data TLB write misses\000legac=
y-cache-co... */
-	{ 88993 },
+	{ 28563 },
 	/* data-tlb-stores-misses\000legacy cache\000Data TLB write misses\000leg=
acy-cache-... */
-	{ 88899 },
+	{ 28655 },
 	/* data-tlb-stores-ops\000legacy cache\000Data TLB write accesses\000lega=
cy-cache-c... */
-	{ 88714 },
+	{ 28749 },
 	/* data-tlb-stores-reference\000legacy cache\000Data TLB write accesses\0=
00legacy-c... */
-	{ 88617 },
+	{ 28840 },
 	/* data-tlb-stores-refs\000legacy cache\000Data TLB write accesses\000leg=
acy-cache-... */
-	{ 88525 },
+	{ 28937 },
 	/* data-tlb-write\000legacy cache\000Data TLB write accesses\000legacy-ca=
che-config... */
-	{ 89085 },
+	{ 29029 },
 	/* data-tlb-write-access\000legacy cache\000Data TLB write accesses\000le=
gacy-cache... */
-	{ 89448 },
+	{ 29115 },
 	/* data-tlb-write-miss\000legacy cache\000Data TLB write misses\000legacy=
-cache-con... */
-	{ 89634 },
+	{ 29208 },
 	/* data-tlb-write-misses\000legacy cache\000Data TLB write misses\000lega=
cy-cache-c... */
-	{ 89541 },
+	{ 29299 },
 	/* data-tlb-write-ops\000legacy cache\000Data TLB write accesses\000legac=
y-cache-co... */
-	{ 89358 },
+	{ 29392 },
 	/* data-tlb-write-reference\000legacy cache\000Data TLB write accesses\00=
0legacy-ca... */
-	{ 89262 },
+	{ 29482 },
 	/* data-tlb-write-refs\000legacy cache\000Data TLB write accesses\000lega=
cy-cache-c... */
-	{ 89171 },
+	{ 29578 },
 	/* dtlb\000legacy cache\000Data TLB read accesses\000legacy-cache-config=
=3D3\000\0001... */
-	{ 72083 },
+	{ 29815 },
 	/* dtlb-access\000legacy cache\000Data TLB read accesses\000legacy-cache-=
config=3D3\0... */
-	{ 78712 },
+	{ 29886 },
 	/* dtlb-load\000legacy cache\000Data TLB read accesses\000legacy-cache-co=
nfig=3D3\000... */
-	{ 72154 },
+	{ 29964 },
 	/* dtlb-load-access\000legacy cache\000Data TLB read accesses\000legacy-c=
ache-confi... */
-	{ 72477 },
+	{ 30040 },
 	/* dtlb-load-miss\000legacy cache\000Data TLB read misses\000legacy-cache=
-config=3D0x... */
-	{ 72647 },
+	{ 30123 },
 	/* dtlb-load-misses\000legacy cache\000Data TLB read misses\000legacy-cac=
he-config=3D... */
-	{ 72560 },
+	{ 30208 },
 	/* dtlb-load-ops\000legacy cache\000Data TLB read accesses\000legacy-cach=
e-config=3D3... */
-	{ 72397 },
+	{ 30295 },
 	/* dtlb-load-reference\000legacy cache\000Data TLB read accesses\000legac=
y-cache-co... */
-	{ 72311 },
+	{ 30375 },
 	/* dtlb-load-refs\000legacy cache\000Data TLB read accesses\000legacy-cac=
he-config=3D... */
-	{ 72230 },
+	{ 30461 },
 	/* dtlb-loads\000legacy cache\000Data TLB read accesses\000legacy-cache-c=
onfig=3D3\00... */
-	{ 72732 },
+	{ 30542 },
 	/* dtlb-loads-access\000legacy cache\000Data TLB read accesses\000legacy-=
cache-conf... */
-	{ 73059 },
+	{ 30619 },
 	/* dtlb-loads-miss\000legacy cache\000Data TLB read misses\000legacy-cach=
e-config=3D0... */
-	{ 73231 },
+	{ 30703 },
 	/* dtlb-loads-misses\000legacy cache\000Data TLB read misses\000legacy-ca=
che-config... */
-	{ 73143 },
+	{ 30789 },
 	/* dtlb-loads-ops\000legacy cache\000Data TLB read accesses\000legacy-cac=
he-config=3D... */
-	{ 72978 },
+	{ 30877 },
 	/* dtlb-loads-reference\000legacy cache\000Data TLB read accesses\000lega=
cy-cache-c... */
-	{ 72891 },
+	{ 30958 },
 	/* dtlb-loads-refs\000legacy cache\000Data TLB read accesses\000legacy-ca=
che-config... */
-	{ 72809 },
+	{ 31045 },
 	/* dtlb-miss\000legacy cache\000Data TLB read misses\000legacy-cache-conf=
ig=3D0x10003... */
-	{ 78872 },
+	{ 31127 },
 	/* dtlb-misses\000legacy cache\000Data TLB read misses\000legacy-cache-co=
nfig=3D0x100... */
-	{ 78790 },
+	{ 31207 },
 	/* dtlb-ops\000legacy cache\000Data TLB read accesses\000legacy-cache-con=
fig=3D3\000\... */
-	{ 78637 },
+	{ 31289 },
 	/* dtlb-prefetch\000legacy cache\000Data TLB prefetch accesses\000legacy-=
cache-conf... */
-	{ 75738 },
+	{ 31364 },
 	/* dtlb-prefetch-access\000legacy cache\000Data TLB prefetch accesses\000=
legacy-cac... */
-	{ 76109 },
+	{ 31452 },
 	/* dtlb-prefetch-miss\000legacy cache\000Data TLB prefetch misses\000lega=
cy-cache-c... */
-	{ 76299 },
+	{ 31547 },
 	/* dtlb-prefetch-misses\000legacy cache\000Data TLB prefetch misses\000le=
gacy-cache... */
-	{ 76204 },
+	{ 31640 },
 	/* dtlb-prefetch-ops\000legacy cache\000Data TLB prefetch accesses\000leg=
acy-cache-... */
-	{ 76017 },
+	{ 31735 },
 	/* dtlb-prefetch-reference\000legacy cache\000Data TLB prefetch accesses\=
000legacy-... */
-	{ 75919 },
+	{ 31827 },
 	/* dtlb-prefetch-refs\000legacy cache\000Data TLB prefetch accesses\000le=
gacy-cache... */
-	{ 75826 },
+	{ 31925 },
 	/* dtlb-prefetches\000legacy cache\000Data TLB prefetch accesses\000legac=
y-cache-co... */
-	{ 76392 },
+	{ 32018 },
 	/* dtlb-prefetches-access\000legacy cache\000Data TLB prefetch accesses\0=
00legacy-c... */
-	{ 76771 },
+	{ 32108 },
 	/* dtlb-prefetches-miss\000legacy cache\000Data TLB prefetch misses\000le=
gacy-cache... */
-	{ 76965 },
+	{ 32205 },
 	/* dtlb-prefetches-misses\000legacy cache\000Data TLB prefetch misses\000=
legacy-cac... */
-	{ 76868 },
+	{ 32300 },
 	/* dtlb-prefetches-ops\000legacy cache\000Data TLB prefetch accesses\000l=
egacy-cach... */
-	{ 76677 },
+	{ 32397 },
 	/* dtlb-prefetches-reference\000legacy cache\000Data TLB prefetch accesse=
s\000legac... */
-	{ 76577 },
+	{ 32491 },
 	/* dtlb-prefetches-refs\000legacy cache\000Data TLB prefetch accesses\000=
legacy-cac... */
-	{ 76482 },
+	{ 32591 },
 	/* dtlb-read\000legacy cache\000Data TLB read accesses\000legacy-cache-co=
nfig=3D3\000... */
-	{ 73317 },
+	{ 32686 },
 	/* dtlb-read-access\000legacy cache\000Data TLB read accesses\000legacy-c=
ache-confi... */
-	{ 73640 },
+	{ 32762 },
 	/* dtlb-read-miss\000legacy cache\000Data TLB read misses\000legacy-cache=
-config=3D0x... */
-	{ 73810 },
+	{ 32845 },
 	/* dtlb-read-misses\000legacy cache\000Data TLB read misses\000legacy-cac=
he-config=3D... */
-	{ 73723 },
+	{ 32930 },
 	/* dtlb-read-ops\000legacy cache\000Data TLB read accesses\000legacy-cach=
e-config=3D3... */
-	{ 73560 },
+	{ 33017 },
 	/* dtlb-read-reference\000legacy cache\000Data TLB read accesses\000legac=
y-cache-co... */
-	{ 73474 },
+	{ 33097 },
 	/* dtlb-read-refs\000legacy cache\000Data TLB read accesses\000legacy-cac=
he-config=3D... */
-	{ 73393 },
+	{ 33183 },
 	/* dtlb-reference\000legacy cache\000Data TLB read accesses\000legacy-cac=
he-config=3D... */
-	{ 78556 },
+	{ 33264 },
 	/* dtlb-refs\000legacy cache\000Data TLB read accesses\000legacy-cache-co=
nfig=3D3\000... */
-	{ 78480 },
+	{ 33345 },
 	/* dtlb-speculative-load\000legacy cache\000Data TLB prefetch accesses\00=
0legacy-ca... */
-	{ 77770 },
+	{ 33421 },
 	/* dtlb-speculative-load-access\000legacy cache\000Data TLB prefetch acce=
sses\000le... */
-	{ 78173 },
+	{ 33517 },
 	/* dtlb-speculative-load-miss\000legacy cache\000Data TLB prefetch misses=
\000legacy... */
-	{ 78379 },
+	{ 33620 },
 	/* dtlb-speculative-load-misses\000legacy cache\000Data TLB prefetch miss=
es\000lega... */
-	{ 78276 },
+	{ 33721 },
 	/* dtlb-speculative-load-ops\000legacy cache\000Data TLB prefetch accesse=
s\000legac... */
-	{ 78073 },
+	{ 33824 },
 	/* dtlb-speculative-load-reference\000legacy cache\000Data TLB prefetch a=
ccesses\00... */
-	{ 77967 },
+	{ 33924 },
 	/* dtlb-speculative-load-refs\000legacy cache\000Data TLB prefetch access=
es\000lega... */
-	{ 77866 },
+	{ 34030 },
 	/* dtlb-speculative-read\000legacy cache\000Data TLB prefetch accesses\00=
0legacy-ca... */
-	{ 77060 },
+	{ 34131 },
 	/* dtlb-speculative-read-access\000legacy cache\000Data TLB prefetch acce=
sses\000le... */
-	{ 77463 },
+	{ 34227 },
 	/* dtlb-speculative-read-miss\000legacy cache\000Data TLB prefetch misses=
\000legacy... */
-	{ 77669 },
+	{ 34330 },
 	/* dtlb-speculative-read-misses\000legacy cache\000Data TLB prefetch miss=
es\000lega... */
-	{ 77566 },
+	{ 34431 },
 	/* dtlb-speculative-read-ops\000legacy cache\000Data TLB prefetch accesse=
s\000legac... */
-	{ 77363 },
+	{ 34534 },
 	/* dtlb-speculative-read-reference\000legacy cache\000Data TLB prefetch a=
ccesses\00... */
-	{ 77257 },
+	{ 34634 },
 	/* dtlb-speculative-read-refs\000legacy cache\000Data TLB prefetch access=
es\000lega... */
-	{ 77156 },
+	{ 34740 },
 	/* dtlb-store\000legacy cache\000Data TLB write accesses\000legacy-cache-=
config=3D0x1... */
-	{ 73895 },
+	{ 34841 },
 	/* dtlb-store-access\000legacy cache\000Data TLB write accesses\000legacy=
-cache-con... */
-	{ 74242 },
+	{ 34923 },
 	/* dtlb-store-miss\000legacy cache\000Data TLB write misses\000legacy-cac=
he-config=3D... */
-	{ 74420 },
+	{ 35012 },
 	/* dtlb-store-misses\000legacy cache\000Data TLB write misses\000legacy-c=
ache-confi... */
-	{ 74331 },
+	{ 35099 },
 	/* dtlb-store-ops\000legacy cache\000Data TLB write accesses\000legacy-ca=
che-config... */
-	{ 74156 },
+	{ 35188 },
 	/* dtlb-store-reference\000legacy cache\000Data TLB write accesses\000leg=
acy-cache-... */
-	{ 74064 },
+	{ 35274 },
 	/* dtlb-store-refs\000legacy cache\000Data TLB write accesses\000legacy-c=
ache-confi... */
-	{ 73977 },
+	{ 35366 },
 	/* dtlb-stores\000legacy cache\000Data TLB write accesses\000legacy-cache=
-config=3D0x... */
-	{ 74507 },
+	{ 35453 },
 	/* dtlb-stores-access\000legacy cache\000Data TLB write accesses\000legac=
y-cache-co... */
-	{ 74858 },
+	{ 35536 },
 	/* dtlb-stores-miss\000legacy cache\000Data TLB write misses\000legacy-ca=
che-config... */
-	{ 75038 },
+	{ 35626 },
 	/* dtlb-stores-misses\000legacy cache\000Data TLB write misses\000legacy-=
cache-conf... */
-	{ 74948 },
+	{ 35714 },
 	/* dtlb-stores-ops\000legacy cache\000Data TLB write accesses\000legacy-c=
ache-confi... */
-	{ 74771 },
+	{ 35804 },
 	/* dtlb-stores-reference\000legacy cache\000Data TLB write accesses\000le=
gacy-cache... */
-	{ 74678 },
+	{ 35891 },
 	/* dtlb-stores-refs\000legacy cache\000Data TLB write accesses\000legacy-=
cache-conf... */
-	{ 74590 },
+	{ 35984 },
 	/* dtlb-write\000legacy cache\000Data TLB write accesses\000legacy-cache-=
config=3D0x1... */
-	{ 75126 },
+	{ 36072 },
 	/* dtlb-write-access\000legacy cache\000Data TLB write accesses\000legacy=
-cache-con... */
-	{ 75473 },
+	{ 36154 },
 	/* dtlb-write-miss\000legacy cache\000Data TLB write misses\000legacy-cac=
he-config=3D... */
-	{ 75651 },
+	{ 36243 },
 	/* dtlb-write-misses\000legacy cache\000Data TLB write misses\000legacy-c=
ache-confi... */
-	{ 75562 },
+	{ 36330 },
 	/* dtlb-write-ops\000legacy cache\000Data TLB write accesses\000legacy-ca=
che-config... */
-	{ 75387 },
+	{ 36419 },
 	/* dtlb-write-reference\000legacy cache\000Data TLB write accesses\000leg=
acy-cache-... */
-	{ 75295 },
+	{ 36505 },
 	/* dtlb-write-refs\000legacy cache\000Data TLB write accesses\000legacy-c=
ache-confi... */
-	{ 75208 },
+	{ 36597 },
 	/* i-tlb\000legacy cache\000Instruction TLB read accesses\000legacy-cache=
-config=3D4\... */
-	{ 95555 },
+	{ 37397 },
 	/* i-tlb-access\000legacy cache\000Instruction TLB read accesses\000legac=
y-cache-co... */
-	{ 97799 },
+	{ 37476 },
 	/* i-tlb-load\000legacy cache\000Instruction TLB read accesses\000legacy-=
cache-conf... */
-	{ 95634 },
+	{ 37562 },
 	/* i-tlb-load-access\000legacy cache\000Instruction TLB read accesses\000=
legacy-cac... */
-	{ 95989 },
+	{ 37646 },
 	/* i-tlb-load-miss\000legacy cache\000Instruction TLB read misses\000lega=
cy-cache-c... */
-	{ 96175 },
+	{ 37737 },
 	/* i-tlb-load-misses\000legacy cache\000Instruction TLB read misses\000le=
gacy-cache... */
-	{ 96080 },
+	{ 37830 },
 	/* i-tlb-load-ops\000legacy cache\000Instruction TLB read accesses\000leg=
acy-cache-... */
-	{ 95901 },
+	{ 37925 },
 	/* i-tlb-load-reference\000legacy cache\000Instruction TLB read accesses\=
000legacy-... */
-	{ 95807 },
+	{ 38013 },
 	/* i-tlb-load-refs\000legacy cache\000Instruction TLB read accesses\000le=
gacy-cache... */
-	{ 95718 },
+	{ 38107 },
 	/* i-tlb-loads\000legacy cache\000Instruction TLB read accesses\000legacy=
-cache-con... */
-	{ 96268 },
+	{ 38196 },
 	/* i-tlb-loads-access\000legacy cache\000Instruction TLB read accesses\00=
0legacy-ca... */
-	{ 96627 },
+	{ 38281 },
 	/* i-tlb-loads-miss\000legacy cache\000Instruction TLB read misses\000leg=
acy-cache-... */
-	{ 96815 },
+	{ 38373 },
 	/* i-tlb-loads-misses\000legacy cache\000Instruction TLB read misses\000l=
egacy-cach... */
-	{ 96719 },
+	{ 38467 },
 	/* i-tlb-loads-ops\000legacy cache\000Instruction TLB read accesses\000le=
gacy-cache... */
-	{ 96538 },
+	{ 38563 },
 	/* i-tlb-loads-reference\000legacy cache\000Instruction TLB read accesses=
\000legacy... */
-	{ 96443 },
+	{ 38652 },
 	/* i-tlb-loads-refs\000legacy cache\000Instruction TLB read accesses\000l=
egacy-cach... */
-	{ 96353 },
+	{ 38747 },
 	/* i-tlb-miss\000legacy cache\000Instruction TLB read misses\000legacy-ca=
che-config... */
-	{ 97975 },
+	{ 38837 },
 	/* i-tlb-misses\000legacy cache\000Instruction TLB read misses\000legacy-=
cache-conf... */
-	{ 97885 },
+	{ 38925 },
 	/* i-tlb-ops\000legacy cache\000Instruction TLB read accesses\000legacy-c=
ache-confi... */
-	{ 97716 },
+	{ 39015 },
 	/* i-tlb-read\000legacy cache\000Instruction TLB read accesses\000legacy-=
cache-conf... */
-	{ 96909 },
+	{ 39098 },
 	/* i-tlb-read-access\000legacy cache\000Instruction TLB read accesses\000=
legacy-cac... */
-	{ 97264 },
+	{ 39182 },
 	/* i-tlb-read-miss\000legacy cache\000Instruction TLB read misses\000lega=
cy-cache-c... */
-	{ 97450 },
+	{ 39273 },
 	/* i-tlb-read-misses\000legacy cache\000Instruction TLB read misses\000le=
gacy-cache... */
-	{ 97355 },
+	{ 39366 },
 	/* i-tlb-read-ops\000legacy cache\000Instruction TLB read accesses\000leg=
acy-cache-... */
-	{ 97176 },
+	{ 39461 },
 	/* i-tlb-read-reference\000legacy cache\000Instruction TLB read accesses\=
000legacy-... */
-	{ 97082 },
+	{ 39549 },
 	/* i-tlb-read-refs\000legacy cache\000Instruction TLB read accesses\000le=
gacy-cache... */
-	{ 96993 },
+	{ 39643 },
 	/* i-tlb-reference\000legacy cache\000Instruction TLB read accesses\000le=
gacy-cache... */
-	{ 97627 },
+	{ 39732 },
 	/* i-tlb-refs\000legacy cache\000Instruction TLB read accesses\000legacy-=
cache-conf... */
-	{ 97543 },
+	{ 39821 },
 	/* idle-cycles-backend\000legacy hardware\000Stalled cycles during retire=
ment [This... */
-	{ 123248 },
+	{ 39905 },
 	/* idle-cycles-frontend\000legacy hardware\000Stalled cycles during issue=
 [This eve... */
-	{ 122945 },
+	{ 40058 },
 	/* instruction-tlb\000legacy cache\000Instruction TLB read accesses\000le=
gacy-cache... */
-	{ 98063 },
+	{ 40208 },
 	/* instruction-tlb-access\000legacy cache\000Instruction TLB read accesse=
s\000legac... */
-	{ 100557 },
+	{ 40297 },
 	/* instruction-tlb-load\000legacy cache\000Instruction TLB read accesses\=
000legacy-... */
-	{ 98152 },
+	{ 40393 },
 	/* instruction-tlb-load-access\000legacy cache\000Instruction TLB read ac=
cesses\000... */
-	{ 98547 },
+	{ 40487 },
 	/* instruction-tlb-load-miss\000legacy cache\000Instruction TLB read miss=
es\000lega... */
-	{ 98753 },
+	{ 40588 },
 	/* instruction-tlb-load-misses\000legacy cache\000Instruction TLB read mi=
sses\000le... */
-	{ 98648 },
+	{ 40691 },
 	/* instruction-tlb-load-ops\000legacy cache\000Instruction TLB read acces=
ses\000leg... */
-	{ 98449 },
+	{ 40796 },
 	/* instruction-tlb-load-reference\000legacy cache\000Instruction TLB read=
 accesses\... */
-	{ 98345 },
+	{ 40894 },
 	/* instruction-tlb-load-refs\000legacy cache\000Instruction TLB read acce=
sses\000le... */
-	{ 98246 },
+	{ 40998 },
 	/* instruction-tlb-loads\000legacy cache\000Instruction TLB read accesses=
\000legacy... */
-	{ 98856 },
+	{ 41097 },
 	/* instruction-tlb-loads-access\000legacy cache\000Instruction TLB read a=
ccesses\00... */
-	{ 99255 },
+	{ 41192 },
 	/* instruction-tlb-loads-miss\000legacy cache\000Instruction TLB read mis=
ses\000leg... */
-	{ 99463 },
+	{ 41294 },
 	/* instruction-tlb-loads-misses\000legacy cache\000Instruction TLB read m=
isses\000l... */
-	{ 99357 },
+	{ 41398 },
 	/* instruction-tlb-loads-ops\000legacy cache\000Instruction TLB read acce=
sses\000le... */
-	{ 99156 },
+	{ 41504 },
 	/* instruction-tlb-loads-reference\000legacy cache\000Instruction TLB rea=
d accesses... */
-	{ 99051 },
+	{ 41603 },
 	/* instruction-tlb-loads-refs\000legacy cache\000Instruction TLB read acc=
esses\000l... */
-	{ 98951 },
+	{ 41708 },
 	/* instruction-tlb-miss\000legacy cache\000Instruction TLB read misses\00=
0legacy-ca... */
-	{ 100753 },
+	{ 41808 },
 	/* instruction-tlb-misses\000legacy cache\000Instruction TLB read misses\=
000legacy-... */
-	{ 100653 },
+	{ 41906 },
 	/* instruction-tlb-ops\000legacy cache\000Instruction TLB read accesses\0=
00legacy-c... */
-	{ 100464 },
+	{ 42006 },
 	/* instruction-tlb-read\000legacy cache\000Instruction TLB read accesses\=
000legacy-... */
-	{ 99567 },
+	{ 42099 },
 	/* instruction-tlb-read-access\000legacy cache\000Instruction TLB read ac=
cesses\000... */
-	{ 99962 },
+	{ 42193 },
 	/* instruction-tlb-read-miss\000legacy cache\000Instruction TLB read miss=
es\000lega... */
-	{ 100168 },
+	{ 42294 },
 	/* instruction-tlb-read-misses\000legacy cache\000Instruction TLB read mi=
sses\000le... */
-	{ 100063 },
+	{ 42397 },
 	/* instruction-tlb-read-ops\000legacy cache\000Instruction TLB read acces=
ses\000leg... */
-	{ 99864 },
+	{ 42502 },
 	/* instruction-tlb-read-reference\000legacy cache\000Instruction TLB read=
 accesses\... */
-	{ 99760 },
+	{ 42600 },
 	/* instruction-tlb-read-refs\000legacy cache\000Instruction TLB read acce=
sses\000le... */
-	{ 99661 },
+	{ 42704 },
 	/* instruction-tlb-reference\000legacy cache\000Instruction TLB read acce=
sses\000le... */
-	{ 100365 },
+	{ 42803 },
 	/* instruction-tlb-refs\000legacy cache\000Instruction TLB read accesses\=
000legacy-... */
-	{ 100271 },
+	{ 42902 },
 	/* instructions\000legacy hardware\000Retired instructions. Be careful, t=
hese can b... */
-	{ 121629 },
+	{ 42996 },
 	/* itlb\000legacy cache\000Instruction TLB read accesses\000legacy-cache-=
config=3D4\0... */
-	{ 93075 },
+	{ 43172 },
 	/* itlb-access\000legacy cache\000Instruction TLB read accesses\000legacy=
-cache-con... */
-	{ 95294 },
+	{ 43250 },
 	/* itlb-load\000legacy cache\000Instruction TLB read accesses\000legacy-c=
ache-confi... */
-	{ 93153 },
+	{ 43335 },
 	/* itlb-load-access\000legacy cache\000Instruction TLB read accesses\000l=
egacy-cach... */
-	{ 93504 },
+	{ 43418 },
 	/* itlb-load-miss\000legacy cache\000Instruction TLB read misses\000legac=
y-cache-co... */
-	{ 93688 },
+	{ 43508 },
 	/* itlb-load-misses\000legacy cache\000Instruction TLB read misses\000leg=
acy-cache-... */
-	{ 93594 },
+	{ 43600 },
 	/* itlb-load-ops\000legacy cache\000Instruction TLB read accesses\000lega=
cy-cache-c... */
-	{ 93417 },
+	{ 43694 },
 	/* itlb-load-reference\000legacy cache\000Instruction TLB read accesses\0=
00legacy-c... */
-	{ 93324 },
+	{ 43781 },
 	/* itlb-load-refs\000legacy cache\000Instruction TLB read accesses\000leg=
acy-cache-... */
-	{ 93236 },
+	{ 43874 },
 	/* itlb-loads\000legacy cache\000Instruction TLB read accesses\000legacy-=
cache-conf... */
-	{ 93780 },
+	{ 43962 },
 	/* itlb-loads-access\000legacy cache\000Instruction TLB read accesses\000=
legacy-cac... */
-	{ 94135 },
+	{ 44046 },
 	/* itlb-loads-miss\000legacy cache\000Instruction TLB read misses\000lega=
cy-cache-c... */
-	{ 94321 },
+	{ 44137 },
 	/* itlb-loads-misses\000legacy cache\000Instruction TLB read misses\000le=
gacy-cache... */
-	{ 94226 },
+	{ 44230 },
 	/* itlb-loads-ops\000legacy cache\000Instruction TLB read accesses\000leg=
acy-cache-... */
-	{ 94047 },
+	{ 44325 },
 	/* itlb-loads-reference\000legacy cache\000Instruction TLB read accesses\=
000legacy-... */
-	{ 93953 },
+	{ 44413 },
 	/* itlb-loads-refs\000legacy cache\000Instruction TLB read accesses\000le=
gacy-cache... */
-	{ 93864 },
+	{ 44507 },
 	/* itlb-miss\000legacy cache\000Instruction TLB read misses\000legacy-cac=
he-config=3D... */
-	{ 95468 },
+	{ 44596 },
 	/* itlb-misses\000legacy cache\000Instruction TLB read misses\000legacy-c=
ache-confi... */
-	{ 95379 },
+	{ 44683 },
 	/* itlb-ops\000legacy cache\000Instruction TLB read accesses\000legacy-ca=
che-config... */
-	{ 95212 },
+	{ 44772 },
 	/* itlb-read\000legacy cache\000Instruction TLB read accesses\000legacy-c=
ache-confi... */
-	{ 94414 },
+	{ 44854 },
 	/* itlb-read-access\000legacy cache\000Instruction TLB read accesses\000l=
egacy-cach... */
-	{ 94765 },
+	{ 44937 },
 	/* itlb-read-miss\000legacy cache\000Instruction TLB read misses\000legac=
y-cache-co... */
-	{ 94949 },
+	{ 45027 },
 	/* itlb-read-misses\000legacy cache\000Instruction TLB read misses\000leg=
acy-cache-... */
-	{ 94855 },
+	{ 45119 },
 	/* itlb-read-ops\000legacy cache\000Instruction TLB read accesses\000lega=
cy-cache-c... */
-	{ 94678 },
+	{ 45213 },
 	/* itlb-read-reference\000legacy cache\000Instruction TLB read accesses\0=
00legacy-c... */
-	{ 94585 },
+	{ 45300 },
 	/* itlb-read-refs\000legacy cache\000Instruction TLB read accesses\000leg=
acy-cache-... */
-	{ 94497 },
+	{ 45393 },
 	/* itlb-reference\000legacy cache\000Instruction TLB read accesses\000leg=
acy-cache-... */
-	{ 95124 },
+	{ 45481 },
 	/* itlb-refs\000legacy cache\000Instruction TLB read accesses\000legacy-c=
ache-confi... */
-	{ 95041 },
+	{ 45569 },
 	/* l1-d\000legacy cache\000Level 1 data cache read accesses\000legacy-cac=
he-config=3D... */
-	{ 8037 },
+	{ 45652 },
 	/* l1-d-access\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-... */
-	{ 15406 },
+	{ 45733 },
 	/* l1-d-load\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-co... */
-	{ 8118 },
+	{ 45821 },
 	/* l1-d-load-access\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-c... */
-	{ 8481 },
+	{ 45907 },
 	/* l1-d-load-miss\000legacy cache\000Level 1 data cache read misses\000le=
gacy-cache... */
-	{ 8671 },
+	{ 46000 },
 	/* l1-d-load-misses\000legacy cache\000Level 1 data cache read misses\000=
legacy-cac... */
-	{ 8574 },
+	{ 46095 },
 	/* l1-d-load-ops\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cach... */
-	{ 8391 },
+	{ 46192 },
 	/* l1-d-load-reference\000legacy cache\000Level 1 data cache read accesse=
s\000legac... */
-	{ 8295 },
+	{ 46282 },
 	/* l1-d-load-refs\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cac... */
-	{ 8204 },
+	{ 46378 },
 	/* l1-d-loads\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-c... */
-	{ 8766 },
+	{ 46469 },
 	/* l1-d-loads-access\000legacy cache\000Level 1 data cache read accesses\=
000legacy-... */
-	{ 9133 },
+	{ 46556 },
 	/* l1-d-loads-miss\000legacy cache\000Level 1 data cache read misses\000l=
egacy-cach... */
-	{ 9325 },
+	{ 46650 },
 	/* l1-d-loads-misses\000legacy cache\000Level 1 data cache read misses\00=
0legacy-ca... */
-	{ 9227 },
+	{ 46746 },
 	/* l1-d-loads-ops\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cac... */
-	{ 9042 },
+	{ 46844 },
 	/* l1-d-loads-reference\000legacy cache\000Level 1 data cache read access=
es\000lega... */
-	{ 8945 },
+	{ 46935 },
 	/* l1-d-loads-refs\000legacy cache\000Level 1 data cache read accesses\00=
0legacy-ca... */
-	{ 8853 },
+	{ 47032 },
 	/* l1-d-miss\000legacy cache\000Level 1 data cache read misses\000legacy-=
cache-conf... */
-	{ 15586 },
+	{ 47124 },
 	/* l1-d-misses\000legacy cache\000Level 1 data cache read misses\000legac=
y-cache-co... */
-	{ 15494 },
+	{ 47214 },
 	/* l1-d-ops\000legacy cache\000Level 1 data cache read accesses\000legacy=
-cache-con... */
-	{ 15321 },
+	{ 47306 },
 	/* l1-d-prefetch\000legacy cache\000Level 1 data cache prefetch accesses\=
000legacy-... */
-	{ 12122 },
+	{ 47391 },
 	/* l1-d-prefetch-access\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000... */
-	{ 12533 },
+	{ 47489 },
 	/* l1-d-prefetch-miss\000legacy cache\000Level 1 data cache prefetch miss=
es\000lega... */
-	{ 12743 },
+	{ 47594 },
 	/* l1-d-prefetch-misses\000legacy cache\000Level 1 data cache prefetch mi=
sses\000le... */
-	{ 12638 },
+	{ 47697 },
 	/* l1-d-prefetch-ops\000legacy cache\000Level 1 data cache prefetch acces=
ses\000leg... */
-	{ 12431 },
+	{ 47802 },
 	/* l1-d-prefetch-reference\000legacy cache\000Level 1 data cache prefetch=
 accesses\... */
-	{ 12323 },
+	{ 47904 },
 	/* l1-d-prefetch-refs\000legacy cache\000Level 1 data cache prefetch acce=
sses\000le... */
-	{ 12220 },
+	{ 48012 },
 	/* l1-d-prefetches\000legacy cache\000Level 1 data cache prefetch accesse=
s\000legac... */
-	{ 12846 },
+	{ 48115 },
 	/* l1-d-prefetches-access\000legacy cache\000Level 1 data cache prefetch =
accesses\0... */
-	{ 13265 },
+	{ 48215 },
 	/* l1-d-prefetches-miss\000legacy cache\000Level 1 data cache prefetch mi=
sses\000le... */
-	{ 13479 },
+	{ 48322 },
 	/* l1-d-prefetches-misses\000legacy cache\000Level 1 data cache prefetch =
misses\000... */
-	{ 13372 },
+	{ 48427 },
 	/* l1-d-prefetches-ops\000legacy cache\000Level 1 data cache prefetch acc=
esses\000l... */
-	{ 13161 },
+	{ 48534 },
 	/* l1-d-prefetches-reference\000legacy cache\000Level 1 data cache prefet=
ch accesse... */
-	{ 13051 },
+	{ 48638 },
 	/* l1-d-prefetches-refs\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000... */
-	{ 12946 },
+	{ 48748 },
 	/* l1-d-read\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-co... */
-	{ 9421 },
+	{ 48853 },
 	/* l1-d-read-access\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-c... */
-	{ 9784 },
+	{ 48939 },
 	/* l1-d-read-miss\000legacy cache\000Level 1 data cache read misses\000le=
gacy-cache... */
-	{ 9974 },
+	{ 49032 },
 	/* l1-d-read-misses\000legacy cache\000Level 1 data cache read misses\000=
legacy-cac... */
-	{ 9877 },
+	{ 49127 },
 	/* l1-d-read-ops\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cach... */
-	{ 9694 },
+	{ 49224 },
 	/* l1-d-read-reference\000legacy cache\000Level 1 data cache read accesse=
s\000legac... */
-	{ 9598 },
+	{ 49314 },
 	/* l1-d-read-refs\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cac... */
-	{ 9507 },
+	{ 49410 },
 	/* l1-d-reference\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cac... */
-	{ 15230 },
+	{ 49501 },
 	/* l1-d-refs\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-co... */
-	{ 15144 },
+	{ 49592 },
 	/* l1-d-speculative-load\000legacy cache\000Level 1 data cache prefetch a=
ccesses\00... */
-	{ 14364 },
+	{ 49678 },
 	/* l1-d-speculative-load-access\000legacy cache\000Level 1 data cache pre=
fetch acce... */
-	{ 14807 },
+	{ 49784 },
 	/* l1-d-speculative-load-miss\000legacy cache\000Level 1 data cache prefe=
tch misses... */
-	{ 15033 },
+	{ 49897 },
 	/* l1-d-speculative-load-misses\000legacy cache\000Level 1 data cache pre=
fetch miss... */
-	{ 14920 },
+	{ 50008 },
 	/* l1-d-speculative-load-ops\000legacy cache\000Level 1 data cache prefet=
ch accesse... */
-	{ 14697 },
+	{ 50121 },
 	/* l1-d-speculative-load-reference\000legacy cache\000Level 1 data cache =
prefetch a... */
-	{ 14581 },
+	{ 50231 },
 	/* l1-d-speculative-load-refs\000legacy cache\000Level 1 data cache prefe=
tch access... */
-	{ 14470 },
+	{ 50347 },
 	/* l1-d-speculative-read\000legacy cache\000Level 1 data cache prefetch a=
ccesses\00... */
-	{ 13584 },
+	{ 50458 },
 	/* l1-d-speculative-read-access\000legacy cache\000Level 1 data cache pre=
fetch acce... */
-	{ 14027 },
+	{ 50564 },
 	/* l1-d-speculative-read-miss\000legacy cache\000Level 1 data cache prefe=
tch misses... */
-	{ 14253 },
+	{ 50677 },
 	/* l1-d-speculative-read-misses\000legacy cache\000Level 1 data cache pre=
fetch miss... */
-	{ 14140 },
+	{ 50788 },
 	/* l1-d-speculative-read-ops\000legacy cache\000Level 1 data cache prefet=
ch accesse... */
-	{ 13917 },
+	{ 50901 },
 	/* l1-d-speculative-read-reference\000legacy cache\000Level 1 data cache =
prefetch a... */
-	{ 13801 },
+	{ 51011 },
 	/* l1-d-speculative-read-refs\000legacy cache\000Level 1 data cache prefe=
tch access... */
-	{ 13690 },
+	{ 51127 },
 	/* l1-d-store\000legacy cache\000Level 1 data cache write accesses\000leg=
acy-cache-... */
-	{ 10069 },
+	{ 51238 },
 	/* l1-d-store-access\000legacy cache\000Level 1 data cache write accesses=
\000legacy... */
-	{ 10456 },
+	{ 51330 },
 	/* l1-d-store-miss\000legacy cache\000Level 1 data cache write misses\000=
legacy-cac... */
-	{ 10654 },
+	{ 51429 },
 	/* l1-d-store-misses\000legacy cache\000Level 1 data cache write misses\0=
00legacy-c... */
-	{ 10555 },
+	{ 51526 },
 	/* l1-d-store-ops\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-ca... */
-	{ 10360 },
+	{ 51625 },
 	/* l1-d-store-reference\000legacy cache\000Level 1 data cache write acces=
ses\000leg... */
-	{ 10258 },
+	{ 51721 },
 	/* l1-d-store-refs\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-c... */
-	{ 10161 },
+	{ 51823 },
 	/* l1-d-stores\000legacy cache\000Level 1 data cache write accesses\000le=
gacy-cache... */
-	{ 10751 },
+	{ 51920 },
 	/* l1-d-stores-access\000legacy cache\000Level 1 data cache write accesse=
s\000legac... */
-	{ 11142 },
+	{ 52013 },
 	/* l1-d-stores-miss\000legacy cache\000Level 1 data cache write misses\00=
0legacy-ca... */
-	{ 11342 },
+	{ 52113 },
 	/* l1-d-stores-misses\000legacy cache\000Level 1 data cache write misses\=
000legacy-... */
-	{ 11242 },
+	{ 52211 },
 	/* l1-d-stores-ops\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-c... */
-	{ 11045 },
+	{ 52311 },
 	/* l1-d-stores-reference\000legacy cache\000Level 1 data cache write acce=
sses\000le... */
-	{ 10942 },
+	{ 52408 },
 	/* l1-d-stores-refs\000legacy cache\000Level 1 data cache write accesses\=
000legacy-... */
-	{ 10844 },
+	{ 52511 },
 	/* l1-d-write\000legacy cache\000Level 1 data cache write accesses\000leg=
acy-cache-... */
-	{ 11440 },
+	{ 52609 },
 	/* l1-d-write-access\000legacy cache\000Level 1 data cache write accesses=
\000legacy... */
-	{ 11827 },
+	{ 52701 },
 	/* l1-d-write-miss\000legacy cache\000Level 1 data cache write misses\000=
legacy-cac... */
-	{ 12025 },
+	{ 52800 },
 	/* l1-d-write-misses\000legacy cache\000Level 1 data cache write misses\0=
00legacy-c... */
-	{ 11926 },
+	{ 52897 },
 	/* l1-d-write-ops\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-ca... */
-	{ 11731 },
+	{ 52996 },
 	/* l1-d-write-reference\000legacy cache\000Level 1 data cache write acces=
ses\000leg... */
-	{ 11629 },
+	{ 53092 },
 	/* l1-d-write-refs\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-c... */
-	{ 11532 },
+	{ 53194 },
 	/* l1-data\000legacy cache\000Level 1 data cache read accesses\000legacy-=
cache-conf... */
-	{ 23238 },
+	{ 53291 },
 	/* l1-data-access\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cac... */
-	{ 30829 },
+	{ 53375 },
 	/* l1-data-load\000legacy cache\000Level 1 data cache read accesses\000le=
gacy-cache... */
-	{ 23322 },
+	{ 53466 },
 	/* l1-data-load-access\000legacy cache\000Level 1 data cache read accesse=
s\000legac... */
-	{ 23697 },
+	{ 53555 },
 	/* l1-data-load-miss\000legacy cache\000Level 1 data cache read misses\00=
0legacy-ca... */
-	{ 23893 },
+	{ 53651 },
 	/* l1-data-load-misses\000legacy cache\000Level 1 data cache read misses\=
000legacy-... */
-	{ 23793 },
+	{ 53749 },
 	/* l1-data-load-ops\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-c... */
-	{ 23604 },
+	{ 53849 },
 	/* l1-data-load-reference\000legacy cache\000Level 1 data cache read acce=
sses\000le... */
-	{ 23505 },
+	{ 53942 },
 	/* l1-data-load-refs\000legacy cache\000Level 1 data cache read accesses\=
000legacy-... */
-	{ 23411 },
+	{ 54041 },
 	/* l1-data-loads\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cach... */
-	{ 23991 },
+	{ 54135 },
 	/* l1-data-loads-access\000legacy cache\000Level 1 data cache read access=
es\000lega... */
-	{ 24370 },
+	{ 54225 },
 	/* l1-data-loads-miss\000legacy cache\000Level 1 data cache read misses\0=
00legacy-c... */
-	{ 24568 },
+	{ 54322 },
 	/* l1-data-loads-misses\000legacy cache\000Level 1 data cache read misses=
\000legacy... */
-	{ 24467 },
+	{ 54421 },
 	/* l1-data-loads-ops\000legacy cache\000Level 1 data cache read accesses\=
000legacy-... */
-	{ 24276 },
+	{ 54522 },
 	/* l1-data-loads-reference\000legacy cache\000Level 1 data cache read acc=
esses\000l... */
-	{ 24176 },
+	{ 54616 },
 	/* l1-data-loads-refs\000legacy cache\000Level 1 data cache read accesses=
\000legacy... */
-	{ 24081 },
+	{ 54716 },
 	/* l1-data-miss\000legacy cache\000Level 1 data cache read misses\000lega=
cy-cache-c... */
-	{ 31015 },
+	{ 54811 },
 	/* l1-data-misses\000legacy cache\000Level 1 data cache read misses\000le=
gacy-cache... */
-	{ 30920 },
+	{ 54904 },
 	/* l1-data-ops\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-... */
-	{ 30741 },
+	{ 54999 },
 	/* l1-data-prefetch\000legacy cache\000Level 1 data cache prefetch access=
es\000lega... */
-	{ 27452 },
+	{ 55087 },
 	/* l1-data-prefetch-access\000legacy cache\000Level 1 data cache prefetch=
 accesses\... */
-	{ 27875 },
+	{ 55188 },
 	/* l1-data-prefetch-miss\000legacy cache\000Level 1 data cache prefetch m=
isses\000l... */
-	{ 28091 },
+	{ 55296 },
 	/* l1-data-prefetch-misses\000legacy cache\000Level 1 data cache prefetch=
 misses\00... */
-	{ 27983 },
+	{ 55402 },
 	/* l1-data-prefetch-ops\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000... */
-	{ 27770 },
+	{ 55510 },
 	/* l1-data-prefetch-reference\000legacy cache\000Level 1 data cache prefe=
tch access... */
-	{ 27659 },
+	{ 55615 },
 	/* l1-data-prefetch-refs\000legacy cache\000Level 1 data cache prefetch a=
ccesses\00... */
-	{ 27553 },
+	{ 55726 },
 	/* l1-data-prefetches\000legacy cache\000Level 1 data cache prefetch acce=
sses\000le... */
-	{ 28197 },
+	{ 55832 },
 	/* l1-data-prefetches-access\000legacy cache\000Level 1 data cache prefet=
ch accesse... */
-	{ 28628 },
+	{ 55935 },
 	/* l1-data-prefetches-miss\000legacy cache\000Level 1 data cache prefetch=
 misses\00... */
-	{ 28848 },
+	{ 56045 },
 	/* l1-data-prefetches-misses\000legacy cache\000Level 1 data cache prefet=
ch misses\... */
-	{ 28738 },
+	{ 56153 },
 	/* l1-data-prefetches-ops\000legacy cache\000Level 1 data cache prefetch =
accesses\0... */
-	{ 28521 },
+	{ 56263 },
 	/* l1-data-prefetches-reference\000legacy cache\000Level 1 data cache pre=
fetch acce... */
-	{ 28408 },
+	{ 56370 },
 	/* l1-data-prefetches-refs\000legacy cache\000Level 1 data cache prefetch=
 accesses\... */
-	{ 28300 },
+	{ 56483 },
 	/* l1-data-read\000legacy cache\000Level 1 data cache read accesses\000le=
gacy-cache... */
-	{ 24667 },
+	{ 56591 },
 	/* l1-data-read-access\000legacy cache\000Level 1 data cache read accesse=
s\000legac... */
-	{ 25042 },
+	{ 56680 },
 	/* l1-data-read-miss\000legacy cache\000Level 1 data cache read misses\00=
0legacy-ca... */
-	{ 25238 },
+	{ 56776 },
 	/* l1-data-read-misses\000legacy cache\000Level 1 data cache read misses\=
000legacy-... */
-	{ 25138 },
+	{ 56874 },
 	/* l1-data-read-ops\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-c... */
-	{ 24949 },
+	{ 56974 },
 	/* l1-data-read-reference\000legacy cache\000Level 1 data cache read acce=
sses\000le... */
-	{ 24850 },
+	{ 57067 },
 	/* l1-data-read-refs\000legacy cache\000Level 1 data cache read accesses\=
000legacy-... */
-	{ 24756 },
+	{ 57166 },
 	/* l1-data-reference\000legacy cache\000Level 1 data cache read accesses\=
000legacy-... */
-	{ 30647 },
+	{ 57260 },
 	/* l1-data-refs\000legacy cache\000Level 1 data cache read accesses\000le=
gacy-cache... */
-	{ 30558 },
+	{ 57354 },
 	/* l1-data-speculative-load\000legacy cache\000Level 1 data cache prefetc=
h accesses... */
-	{ 29757 },
+	{ 57443 },
 	/* l1-data-speculative-load-access\000legacy cache\000Level 1 data cache =
prefetch a... */
-	{ 30212 },
+	{ 57552 },
 	/* l1-data-speculative-load-miss\000legacy cache\000Level 1 data cache pr=
efetch mis... */
-	{ 30444 },
+	{ 57668 },
 	/* l1-data-speculative-load-misses\000legacy cache\000Level 1 data cache =
prefetch m... */
-	{ 30328 },
+	{ 57782 },
 	/* l1-data-speculative-load-ops\000legacy cache\000Level 1 data cache pre=
fetch acce... */
-	{ 30099 },
+	{ 57898 },
 	/* l1-data-speculative-load-reference\000legacy cache\000Level 1 data cac=
he prefetc... */
-	{ 29980 },
+	{ 58011 },
 	/* l1-data-speculative-load-refs\000legacy cache\000Level 1 data cache pr=
efetch acc... */
-	{ 29866 },
+	{ 58130 },
 	/* l1-data-speculative-read\000legacy cache\000Level 1 data cache prefetc=
h accesses... */
-	{ 28956 },
+	{ 58244 },
 	/* l1-data-speculative-read-access\000legacy cache\000Level 1 data cache =
prefetch a... */
-	{ 29411 },
+	{ 58353 },
 	/* l1-data-speculative-read-miss\000legacy cache\000Level 1 data cache pr=
efetch mis... */
-	{ 29643 },
+	{ 58469 },
 	/* l1-data-speculative-read-misses\000legacy cache\000Level 1 data cache =
prefetch m... */
-	{ 29527 },
+	{ 58583 },
 	/* l1-data-speculative-read-ops\000legacy cache\000Level 1 data cache pre=
fetch acce... */
-	{ 29298 },
+	{ 58699 },
 	/* l1-data-speculative-read-reference\000legacy cache\000Level 1 data cac=
he prefetc... */
-	{ 29179 },
+	{ 58812 },
 	/* l1-data-speculative-read-refs\000legacy cache\000Level 1 data cache pr=
efetch acc... */
-	{ 29065 },
+	{ 58931 },
 	/* l1-data-store\000legacy cache\000Level 1 data cache write accesses\000=
legacy-cac... */
-	{ 25336 },
+	{ 59045 },
 	/* l1-data-store-access\000legacy cache\000Level 1 data cache write acces=
ses\000leg... */
-	{ 25735 },
+	{ 59140 },
 	/* l1-data-store-miss\000legacy cache\000Level 1 data cache write misses\=
000legacy-... */
-	{ 25939 },
+	{ 59242 },
 	/* l1-data-store-misses\000legacy cache\000Level 1 data cache write misse=
s\000legac... */
-	{ 25837 },
+	{ 59342 },
 	/* l1-data-store-ops\000legacy cache\000Level 1 data cache write accesses=
\000legacy... */
-	{ 25636 },
+	{ 59444 },
 	/* l1-data-store-reference\000legacy cache\000Level 1 data cache write ac=
cesses\000... */
-	{ 25531 },
+	{ 59543 },
 	/* l1-data-store-refs\000legacy cache\000Level 1 data cache write accesse=
s\000legac... */
-	{ 25431 },
+	{ 59648 },
 	/* l1-data-stores\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-ca... */
-	{ 26039 },
+	{ 59748 },
 	/* l1-data-stores-access\000legacy cache\000Level 1 data cache write acce=
sses\000le... */
-	{ 26442 },
+	{ 59844 },
 	/* l1-data-stores-miss\000legacy cache\000Level 1 data cache write misses=
\000legacy... */
-	{ 26648 },
+	{ 59947 },
 	/* l1-data-stores-misses\000legacy cache\000Level 1 data cache write miss=
es\000lega... */
-	{ 26545 },
+	{ 60048 },
 	/* l1-data-stores-ops\000legacy cache\000Level 1 data cache write accesse=
s\000legac... */
-	{ 26342 },
+	{ 60151 },
 	/* l1-data-stores-reference\000legacy cache\000Level 1 data cache write a=
ccesses\00... */
-	{ 26236 },
+	{ 60251 },
 	/* l1-data-stores-refs\000legacy cache\000Level 1 data cache write access=
es\000lega... */
-	{ 26135 },
+	{ 60357 },
 	/* l1-data-write\000legacy cache\000Level 1 data cache write accesses\000=
legacy-cac... */
-	{ 26749 },
+	{ 60458 },
 	/* l1-data-write-access\000legacy cache\000Level 1 data cache write acces=
ses\000leg... */
-	{ 27148 },
+	{ 60553 },
 	/* l1-data-write-miss\000legacy cache\000Level 1 data cache write misses\=
000legacy-... */
-	{ 27352 },
+	{ 60655 },
 	/* l1-data-write-misses\000legacy cache\000Level 1 data cache write misse=
s\000legac... */
-	{ 27250 },
+	{ 60755 },
 	/* l1-data-write-ops\000legacy cache\000Level 1 data cache write accesses=
\000legacy... */
-	{ 27049 },
+	{ 60857 },
 	/* l1-data-write-reference\000legacy cache\000Level 1 data cache write ac=
cesses\000... */
-	{ 26944 },
+	{ 60956 },
 	/* l1-data-write-refs\000legacy cache\000Level 1 data cache write accesse=
s\000legac... */
-	{ 26844 },
+	{ 61061 },
 	/* l1-dcache\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-co... */
-	{ 13 },
+	{ 61161 },
 	/* l1-dcache-access\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-c... */
-	{ 7752 },
+	{ 61247 },
 	/* l1-dcache-load\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cac... */
-	{ 99 },
+	{ 61340 },
 	/* l1-dcache-load-access\000legacy cache\000Level 1 data cache read acces=
ses\000leg... */
-	{ 482 },
+	{ 61431 },
 	/* l1-dcache-load-miss\000legacy cache\000Level 1 data cache read misses\=
000legacy-... */
-	{ 682 },
+	{ 61529 },
 	/* l1-dcache-load-misses\000legacy cache\000Level 1 data cache read misse=
s\000legac... */
-	{ 580 },
+	{ 61629 },
 	/* l1-dcache-load-ops\000legacy cache\000Level 1 data cache read accesses=
\000legacy... */
-	{ 387 },
+	{ 61731 },
 	/* l1-dcache-load-reference\000legacy cache\000Level 1 data cache read ac=
cesses\000... */
-	{ 286 },
+	{ 61826 },
 	/* l1-dcache-load-refs\000legacy cache\000Level 1 data cache read accesse=
s\000legac... */
-	{ 190 },
+	{ 61927 },
 	/* l1-dcache-loads\000legacy cache\000Level 1 data cache read accesses\00=
0legacy-ca... */
-	{ 782 },
+	{ 62023 },
 	/* l1-dcache-loads-access\000legacy cache\000Level 1 data cache read acce=
sses\000le... */
-	{ 1169 },
+	{ 62115 },
 	/* l1-dcache-loads-miss\000legacy cache\000Level 1 data cache read misses=
\000legacy... */
-	{ 1371 },
+	{ 62214 },
 	/* l1-dcache-loads-misses\000legacy cache\000Level 1 data cache read miss=
es\000lega... */
-	{ 1268 },
+	{ 62315 },
 	/* l1-dcache-loads-ops\000legacy cache\000Level 1 data cache read accesse=
s\000legac... */
-	{ 1073 },
+	{ 62418 },
 	/* l1-dcache-loads-reference\000legacy cache\000Level 1 data cache read a=
ccesses\00... */
-	{ 971 },
+	{ 62514 },
 	/* l1-dcache-loads-refs\000legacy cache\000Level 1 data cache read access=
es\000lega... */
-	{ 874 },
+	{ 62616 },
 	/* l1-dcache-miss\000legacy cache\000Level 1 data cache read misses\000le=
gacy-cache... */
-	{ 7942 },
+	{ 62713 },
 	/* l1-dcache-misses\000legacy cache\000Level 1 data cache read misses\000=
legacy-cac... */
-	{ 7845 },
+	{ 62808 },
 	/* l1-dcache-ops\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cach... */
-	{ 7662 },
+	{ 62905 },
 	/* l1-dcache-prefetch\000legacy cache\000Level 1 data cache prefetch acce=
sses\000le... */
-	{ 4313 },
+	{ 62995 },
 	/* l1-dcache-prefetch-access\000legacy cache\000Level 1 data cache prefet=
ch accesse... */
-	{ 4744 },
+	{ 63098 },
 	/* l1-dcache-prefetch-miss\000legacy cache\000Level 1 data cache prefetch=
 misses\00... */
-	{ 4964 },
+	{ 63208 },
 	/* l1-dcache-prefetch-misses\000legacy cache\000Level 1 data cache prefet=
ch misses\... */
-	{ 4854 },
+	{ 63316 },
 	/* l1-dcache-prefetch-ops\000legacy cache\000Level 1 data cache prefetch =
accesses\0... */
-	{ 4637 },
+	{ 63426 },
 	/* l1-dcache-prefetch-reference\000legacy cache\000Level 1 data cache pre=
fetch acce... */
-	{ 4524 },
+	{ 63533 },
 	/* l1-dcache-prefetch-refs\000legacy cache\000Level 1 data cache prefetch=
 accesses\... */
-	{ 4416 },
+	{ 63646 },
 	/* l1-dcache-prefetches\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000... */
-	{ 5072 },
+	{ 63754 },
 	/* l1-dcache-prefetches-access\000legacy cache\000Level 1 data cache pref=
etch acces... */
-	{ 5511 },
+	{ 63859 },
 	/* l1-dcache-prefetches-miss\000legacy cache\000Level 1 data cache prefet=
ch misses\... */
-	{ 5735 },
+	{ 63971 },
 	/* l1-dcache-prefetches-misses\000legacy cache\000Level 1 data cache pref=
etch misse... */
-	{ 5623 },
+	{ 64081 },
 	/* l1-dcache-prefetches-ops\000legacy cache\000Level 1 data cache prefetc=
h accesses... */
-	{ 5402 },
+	{ 64193 },
 	/* l1-dcache-prefetches-reference\000legacy cache\000Level 1 data cache p=
refetch ac... */
-	{ 5287 },
+	{ 64302 },
 	/* l1-dcache-prefetches-refs\000legacy cache\000Level 1 data cache prefet=
ch accesse... */
-	{ 5177 },
+	{ 64417 },
 	/* l1-dcache-read\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cac... */
-	{ 1472 },
+	{ 64527 },
 	/* l1-dcache-read-access\000legacy cache\000Level 1 data cache read acces=
ses\000leg... */
-	{ 1855 },
+	{ 64618 },
 	/* l1-dcache-read-miss\000legacy cache\000Level 1 data cache read misses\=
000legacy-... */
-	{ 2055 },
+	{ 64716 },
 	/* l1-dcache-read-misses\000legacy cache\000Level 1 data cache read misse=
s\000legac... */
-	{ 1953 },
+	{ 64816 },
 	/* l1-dcache-read-ops\000legacy cache\000Level 1 data cache read accesses=
\000legacy... */
-	{ 1760 },
+	{ 64918 },
 	/* l1-dcache-read-reference\000legacy cache\000Level 1 data cache read ac=
cesses\000... */
-	{ 1659 },
+	{ 65013 },
 	/* l1-dcache-read-refs\000legacy cache\000Level 1 data cache read accesse=
s\000legac... */
-	{ 1563 },
+	{ 65114 },
 	/* l1-dcache-reference\000legacy cache\000Level 1 data cache read accesse=
s\000legac... */
-	{ 7566 },
+	{ 65210 },
 	/* l1-dcache-refs\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cac... */
-	{ 7475 },
+	{ 65306 },
 	/* l1-dcache-speculative-load\000legacy cache\000Level 1 data cache prefe=
tch access... */
-	{ 6660 },
+	{ 65397 },
 	/* l1-dcache-speculative-load-access\000legacy cache\000Level 1 data cach=
e prefetch... */
-	{ 7123 },
+	{ 65508 },
 	/* l1-dcache-speculative-load-miss\000legacy cache\000Level 1 data cache =
prefetch m... */
-	{ 7359 },
+	{ 65626 },
 	/* l1-dcache-speculative-load-misses\000legacy cache\000Level 1 data cach=
e prefetch... */
-	{ 7241 },
+	{ 65742 },
 	/* l1-dcache-speculative-load-ops\000legacy cache\000Level 1 data cache p=
refetch ac... */
-	{ 7008 },
+	{ 65860 },
 	/* l1-dcache-speculative-load-reference\000legacy cache\000Level 1 data c=
ache prefe... */
-	{ 6887 },
+	{ 65975 },
 	/* l1-dcache-speculative-load-refs\000legacy cache\000Level 1 data cache =
prefetch a... */
-	{ 6771 },
+	{ 66096 },
 	/* l1-dcache-speculative-read\000legacy cache\000Level 1 data cache prefe=
tch access... */
-	{ 5845 },
+	{ 66212 },
 	/* l1-dcache-speculative-read-access\000legacy cache\000Level 1 data cach=
e prefetch... */
-	{ 6308 },
+	{ 66323 },
 	/* l1-dcache-speculative-read-miss\000legacy cache\000Level 1 data cache =
prefetch m... */
-	{ 6544 },
+	{ 66441 },
 	/* l1-dcache-speculative-read-misses\000legacy cache\000Level 1 data cach=
e prefetch... */
-	{ 6426 },
+	{ 66557 },
 	/* l1-dcache-speculative-read-ops\000legacy cache\000Level 1 data cache p=
refetch ac... */
-	{ 6193 },
+	{ 66675 },
 	/* l1-dcache-speculative-read-reference\000legacy cache\000Level 1 data c=
ache prefe... */
-	{ 6072 },
+	{ 66790 },
 	/* l1-dcache-speculative-read-refs\000legacy cache\000Level 1 data cache =
prefetch a... */
-	{ 5956 },
+	{ 66911 },
 	/* l1-dcache-store\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-c... */
-	{ 2155 },
+	{ 67027 },
 	/* l1-dcache-store-access\000legacy cache\000Level 1 data cache write acc=
esses\000l... */
-	{ 2562 },
+	{ 67124 },
 	/* l1-dcache-store-miss\000legacy cache\000Level 1 data cache write misse=
s\000legac... */
-	{ 2770 },
+	{ 67228 },
 	/* l1-dcache-store-misses\000legacy cache\000Level 1 data cache write mis=
ses\000leg... */
-	{ 2666 },
+	{ 67330 },
 	/* l1-dcache-store-ops\000legacy cache\000Level 1 data cache write access=
es\000lega... */
-	{ 2461 },
+	{ 67434 },
 	/* l1-dcache-store-reference\000legacy cache\000Level 1 data cache write =
accesses\0... */
-	{ 2354 },
+	{ 67535 },
 	/* l1-dcache-store-refs\000legacy cache\000Level 1 data cache write acces=
ses\000leg... */
-	{ 2252 },
+	{ 67642 },
 	/* l1-dcache-stores\000legacy cache\000Level 1 data cache write accesses\=
000legacy-... */
-	{ 2872 },
+	{ 67744 },
 	/* l1-dcache-stores-access\000legacy cache\000Level 1 data cache write ac=
cesses\000... */
-	{ 3283 },
+	{ 67842 },
 	/* l1-dcache-stores-miss\000legacy cache\000Level 1 data cache write miss=
es\000lega... */
-	{ 3493 },
+	{ 67947 },
 	/* l1-dcache-stores-misses\000legacy cache\000Level 1 data cache write mi=
sses\000le... */
-	{ 3388 },
+	{ 68050 },
 	/* l1-dcache-stores-ops\000legacy cache\000Level 1 data cache write acces=
ses\000leg... */
-	{ 3181 },
+	{ 68155 },
 	/* l1-dcache-stores-reference\000legacy cache\000Level 1 data cache write=
 accesses\... */
-	{ 3073 },
+	{ 68257 },
 	/* l1-dcache-stores-refs\000legacy cache\000Level 1 data cache write acce=
sses\000le... */
-	{ 2970 },
+	{ 68365 },
 	/* l1-dcache-write\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-c... */
-	{ 3596 },
+	{ 68468 },
 	/* l1-dcache-write-access\000legacy cache\000Level 1 data cache write acc=
esses\000l... */
-	{ 4003 },
+	{ 68565 },
 	/* l1-dcache-write-miss\000legacy cache\000Level 1 data cache write misse=
s\000legac... */
-	{ 4211 },
+	{ 68669 },
 	/* l1-dcache-write-misses\000legacy cache\000Level 1 data cache write mis=
ses\000leg... */
-	{ 4107 },
+	{ 68771 },
 	/* l1-dcache-write-ops\000legacy cache\000Level 1 data cache write access=
es\000lega... */
-	{ 3902 },
+	{ 68875 },
 	/* l1-dcache-write-reference\000legacy cache\000Level 1 data cache write =
accesses\0... */
-	{ 3795 },
+	{ 68976 },
 	/* l1-dcache-write-refs\000legacy cache\000Level 1 data cache write acces=
ses\000leg... */
-	{ 3693 },
+	{ 69083 },
 	/* l1-i\000legacy cache\000Level 1 instruction cache read accesses\000leg=
acy-cache-... */
-	{ 37366 },
+	{ 69185 },
 	/* l1-i-access\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy... */
-	{ 43053 },
+	{ 69273 },
 	/* l1-i-load\000legacy cache\000Level 1 instruction cache read accesses\0=
00legacy-c... */
-	{ 37454 },
+	{ 69368 },
 	/* l1-i-load-access\000legacy cache\000Level 1 instruction cache read acc=
esses\000l... */
-	{ 37845 },
+	{ 69461 },
 	/* l1-i-load-miss\000legacy cache\000Level 1 instruction cache read misse=
s\000legac... */
-	{ 38049 },
+	{ 69561 },
 	/* l1-i-load-misses\000legacy cache\000Level 1 instruction cache read mis=
ses\000leg... */
-	{ 37945 },
+	{ 69663 },
 	/* l1-i-load-ops\000legacy cache\000Level 1 instruction cache read access=
es\000lega... */
-	{ 37748 },
+	{ 69767 },
 	/* l1-i-load-reference\000legacy cache\000Level 1 instruction cache read =
accesses\0... */
-	{ 37645 },
+	{ 69864 },
 	/* l1-i-load-refs\000legacy cache\000Level 1 instruction cache read acces=
ses\000leg... */
-	{ 37547 },
+	{ 69967 },
 	/* l1-i-loads\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-... */
-	{ 38151 },
+	{ 70065 },
 	/* l1-i-loads-access\000legacy cache\000Level 1 instruction cache read ac=
cesses\000... */
-	{ 38546 },
+	{ 70159 },
 	/* l1-i-loads-miss\000legacy cache\000Level 1 instruction cache read miss=
es\000lega... */
-	{ 38752 },
+	{ 70260 },
 	/* l1-i-loads-misses\000legacy cache\000Level 1 instruction cache read mi=
sses\000le... */
-	{ 38647 },
+	{ 70363 },
 	/* l1-i-loads-ops\000legacy cache\000Level 1 instruction cache read acces=
ses\000leg... */
-	{ 38448 },
+	{ 70468 },
 	/* l1-i-loads-reference\000legacy cache\000Level 1 instruction cache read=
 accesses\... */
-	{ 38344 },
+	{ 70566 },
 	/* l1-i-loads-refs\000legacy cache\000Level 1 instruction cache read acce=
sses\000le... */
-	{ 38245 },
+	{ 70670 },
 	/* l1-i-miss\000legacy cache\000Level 1 instruction cache read misses\000=
legacy-cac... */
-	{ 43247 },
+	{ 70769 },
 	/* l1-i-misses\000legacy cache\000Level 1 instruction cache read misses\0=
00legacy-c... */
-	{ 43148 },
+	{ 70866 },
 	/* l1-i-ops\000legacy cache\000Level 1 instruction cache read accesses\00=
0legacy-ca... */
-	{ 42961 },
+	{ 70965 },
 	/* l1-i-prefetch\000legacy cache\000Level 1 instruction cache prefetch ac=
cesses\000... */
-	{ 39552 },
+	{ 71057 },
 	/* l1-i-prefetch-access\000legacy cache\000Level 1 instruction cache pref=
etch acces... */
-	{ 39991 },
+	{ 71162 },
 	/* l1-i-prefetch-miss\000legacy cache\000Level 1 instruction cache prefet=
ch misses\... */
-	{ 40215 },
+	{ 71274 },
 	/* l1-i-prefetch-misses\000legacy cache\000Level 1 instruction cache pref=
etch misse... */
-	{ 40103 },
+	{ 71384 },
 	/* l1-i-prefetch-ops\000legacy cache\000Level 1 instruction cache prefetc=
h accesses... */
-	{ 39882 },
+	{ 71496 },
 	/* l1-i-prefetch-reference\000legacy cache\000Level 1 instruction cache p=
refetch ac... */
-	{ 39767 },
+	{ 71605 },
 	/* l1-i-prefetch-refs\000legacy cache\000Level 1 instruction cache prefet=
ch accesse... */
-	{ 39657 },
+	{ 71720 },
 	/* l1-i-prefetches\000legacy cache\000Level 1 instruction cache prefetch =
accesses\0... */
-	{ 40325 },
+	{ 71830 },
 	/* l1-i-prefetches-access\000legacy cache\000Level 1 instruction cache pr=
efetch acc... */
-	{ 40772 },
+	{ 71937 },
 	/* l1-i-prefetches-miss\000legacy cache\000Level 1 instruction cache pref=
etch misse... */
-	{ 41000 },
+	{ 72051 },
 	/* l1-i-prefetches-misses\000legacy cache\000Level 1 instruction cache pr=
efetch mis... */
-	{ 40886 },
+	{ 72163 },
 	/* l1-i-prefetches-ops\000legacy cache\000Level 1 instruction cache prefe=
tch access... */
-	{ 40661 },
+	{ 72277 },
 	/* l1-i-prefetches-reference\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
-	{ 40544 },
+	{ 72388 },
 	/* l1-i-prefetches-refs\000legacy cache\000Level 1 instruction cache pref=
etch acces... */
-	{ 40432 },
+	{ 72505 },
 	/* l1-i-read\000legacy cache\000Level 1 instruction cache read accesses\0=
00legacy-c... */
-	{ 38855 },
+	{ 72617 },
 	/* l1-i-read-access\000legacy cache\000Level 1 instruction cache read acc=
esses\000l... */
-	{ 39246 },
+	{ 72710 },
 	/* l1-i-read-miss\000legacy cache\000Level 1 instruction cache read misse=
s\000legac... */
-	{ 39450 },
+	{ 72810 },
 	/* l1-i-read-misses\000legacy cache\000Level 1 instruction cache read mis=
ses\000leg... */
-	{ 39346 },
+	{ 72912 },
 	/* l1-i-read-ops\000legacy cache\000Level 1 instruction cache read access=
es\000lega... */
-	{ 39149 },
+	{ 73016 },
 	/* l1-i-read-reference\000legacy cache\000Level 1 instruction cache read =
accesses\0... */
-	{ 39046 },
+	{ 73113 },
 	/* l1-i-read-refs\000legacy cache\000Level 1 instruction cache read acces=
ses\000leg... */
-	{ 38948 },
+	{ 73216 },
 	/* l1-i-reference\000legacy cache\000Level 1 instruction cache read acces=
ses\000leg... */
-	{ 42863 },
+	{ 73314 },
 	/* l1-i-refs\000legacy cache\000Level 1 instruction cache read accesses\0=
00legacy-c... */
-	{ 42770 },
+	{ 73412 },
 	/* l1-i-speculative-load\000legacy cache\000Level 1 instruction cache pre=
fetch acce... */
-	{ 41941 },
+	{ 73505 },
 	/* l1-i-speculative-load-access\000legacy cache\000Level 1 instruction ca=
che prefet... */
-	{ 42412 },
+	{ 73618 },
 	/* l1-i-speculative-load-miss\000legacy cache\000Level 1 instruction cach=
e prefetch... */
-	{ 42652 },
+	{ 73738 },
 	/* l1-i-speculative-load-misses\000legacy cache\000Level 1 instruction ca=
che prefet... */
-	{ 42532 },
+	{ 73856 },
 	/* l1-i-speculative-load-ops\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
-	{ 42295 },
+	{ 73976 },
 	/* l1-i-speculative-load-reference\000legacy cache\000Level 1 instruction=
 cache pre... */
-	{ 42172 },
+	{ 74093 },
 	/* l1-i-speculative-load-refs\000legacy cache\000Level 1 instruction cach=
e prefetch... */
-	{ 42054 },
+	{ 74216 },
 	/* l1-i-speculative-read\000legacy cache\000Level 1 instruction cache pre=
fetch acce... */
-	{ 41112 },
+	{ 74334 },
 	/* l1-i-speculative-read-access\000legacy cache\000Level 1 instruction ca=
che prefet... */
-	{ 41583 },
+	{ 74447 },
 	/* l1-i-speculative-read-miss\000legacy cache\000Level 1 instruction cach=
e prefetch... */
-	{ 41823 },
+	{ 74567 },
 	/* l1-i-speculative-read-misses\000legacy cache\000Level 1 instruction ca=
che prefet... */
-	{ 41703 },
+	{ 74685 },
 	/* l1-i-speculative-read-ops\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
-	{ 41466 },
+	{ 74805 },
 	/* l1-i-speculative-read-reference\000legacy cache\000Level 1 instruction=
 cache pre... */
-	{ 41343 },
+	{ 74922 },
 	/* l1-i-speculative-read-refs\000legacy cache\000Level 1 instruction cach=
e prefetch... */
-	{ 41225 },
+	{ 75045 },
 	/* l1-icache\000legacy cache\000Level 1 instruction cache read accesses\0=
00legacy-c... */
-	{ 31108 },
+	{ 75163 },
 	/* l1-icache-access\000legacy cache\000Level 1 instruction cache read acc=
esses\000l... */
-	{ 37060 },
+	{ 75256 },
 	/* l1-icache-load\000legacy cache\000Level 1 instruction cache read acces=
ses\000leg... */
-	{ 31201 },
+	{ 75356 },
 	/* l1-icache-load-access\000legacy cache\000Level 1 instruction cache rea=
d accesses... */
-	{ 31612 },
+	{ 75454 },
 	/* l1-icache-load-miss\000legacy cache\000Level 1 instruction cache read =
misses\000... */
-	{ 31826 },
+	{ 75559 },
 	/* l1-icache-load-misses\000legacy cache\000Level 1 instruction cache rea=
d misses\0... */
-	{ 31717 },
+	{ 75666 },
 	/* l1-icache-load-ops\000legacy cache\000Level 1 instruction cache read a=
ccesses\00... */
-	{ 31510 },
+	{ 75775 },
 	/* l1-icache-load-reference\000legacy cache\000Level 1 instruction cache =
read acces... */
-	{ 31402 },
+	{ 75877 },
 	/* l1-icache-load-refs\000legacy cache\000Level 1 instruction cache read =
accesses\0... */
-	{ 31299 },
+	{ 75985 },
 	/* l1-icache-loads\000legacy cache\000Level 1 instruction cache read acce=
sses\000le... */
-	{ 31933 },
+	{ 76088 },
 	/* l1-icache-loads-access\000legacy cache\000Level 1 instruction cache re=
ad accesse... */
-	{ 32348 },
+	{ 76187 },
 	/* l1-icache-loads-miss\000legacy cache\000Level 1 instruction cache read=
 misses\00... */
-	{ 32564 },
+	{ 76293 },
 	/* l1-icache-loads-misses\000legacy cache\000Level 1 instruction cache re=
ad misses\... */
-	{ 32454 },
+	{ 76401 },
 	/* l1-icache-loads-ops\000legacy cache\000Level 1 instruction cache read =
accesses\0... */
-	{ 32245 },
+	{ 76511 },
 	/* l1-icache-loads-reference\000legacy cache\000Level 1 instruction cache=
 read acce... */
-	{ 32136 },
+	{ 76614 },
 	/* l1-icache-loads-refs\000legacy cache\000Level 1 instruction cache read=
 accesses\... */
-	{ 32032 },
+	{ 76723 },
 	/* l1-icache-miss\000legacy cache\000Level 1 instruction cache read misse=
s\000legac... */
-	{ 37264 },
+	{ 76827 },
 	/* l1-icache-misses\000legacy cache\000Level 1 instruction cache read mis=
ses\000leg... */
-	{ 37160 },
+	{ 76929 },
 	/* l1-icache-ops\000legacy cache\000Level 1 instruction cache read access=
es\000lega... */
-	{ 36963 },
+	{ 77033 },
 	/* l1-icache-prefetch\000legacy cache\000Level 1 instruction cache prefet=
ch accesse... */
-	{ 33404 },
+	{ 77130 },
 	/* l1-icache-prefetch-access\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
-	{ 33863 },
+	{ 77240 },
 	/* l1-icache-prefetch-miss\000legacy cache\000Level 1 instruction cache p=
refetch mi... */
-	{ 34097 },
+	{ 77357 },
 	/* l1-icache-prefetch-misses\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
-	{ 33980 },
+	{ 77472 },
 	/* l1-icache-prefetch-ops\000legacy cache\000Level 1 instruction cache pr=
efetch acc... */
-	{ 33749 },
+	{ 77589 },
 	/* l1-icache-prefetch-reference\000legacy cache\000Level 1 instruction ca=
che prefet... */
-	{ 33629 },
+	{ 77703 },
 	/* l1-icache-prefetch-refs\000legacy cache\000Level 1 instruction cache p=
refetch ac... */
-	{ 33514 },
+	{ 77823 },
 	/* l1-icache-prefetches\000legacy cache\000Level 1 instruction cache pref=
etch acces... */
-	{ 34212 },
+	{ 77938 },
 	/* l1-icache-prefetches-access\000legacy cache\000Level 1 instruction cac=
he prefetc... */
-	{ 34679 },
+	{ 78050 },
 	/* l1-icache-prefetches-miss\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
-	{ 34917 },
+	{ 78169 },
 	/* l1-icache-prefetches-misses\000legacy cache\000Level 1 instruction cac=
he prefetc... */
-	{ 34798 },
+	{ 78286 },
 	/* l1-icache-prefetches-ops\000legacy cache\000Level 1 instruction cache =
prefetch a... */
-	{ 34563 },
+	{ 78405 },
 	/* l1-icache-prefetches-reference\000legacy cache\000Level 1 instruction =
cache pref... */
-	{ 34441 },
+	{ 78521 },
 	/* l1-icache-prefetches-refs\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
-	{ 34324 },
+	{ 78643 },
 	/* l1-icache-read\000legacy cache\000Level 1 instruction cache read acces=
ses\000leg... */
-	{ 32672 },
+	{ 78760 },
 	/* l1-icache-read-access\000legacy cache\000Level 1 instruction cache rea=
d accesses... */
-	{ 33083 },
+	{ 78858 },
 	/* l1-icache-read-miss\000legacy cache\000Level 1 instruction cache read =
misses\000... */
-	{ 33297 },
+	{ 78963 },
 	/* l1-icache-read-misses\000legacy cache\000Level 1 instruction cache rea=
d misses\0... */
-	{ 33188 },
+	{ 79070 },
 	/* l1-icache-read-ops\000legacy cache\000Level 1 instruction cache read a=
ccesses\00... */
-	{ 32981 },
+	{ 79179 },
 	/* l1-icache-read-reference\000legacy cache\000Level 1 instruction cache =
read acces... */
-	{ 32873 },
+	{ 79281 },
 	/* l1-icache-read-refs\000legacy cache\000Level 1 instruction cache read =
accesses\0... */
-	{ 32770 },
+	{ 79389 },
 	/* l1-icache-reference\000legacy cache\000Level 1 instruction cache read =
accesses\0... */
-	{ 36860 },
+	{ 79492 },
 	/* l1-icache-refs\000legacy cache\000Level 1 instruction cache read acces=
ses\000leg... */
-	{ 36762 },
+	{ 79595 },
 	/* l1-icache-speculative-load\000legacy cache\000Level 1 instruction cach=
e prefetch... */
-	{ 35898 },
+	{ 79693 },
 	/* l1-icache-speculative-load-access\000legacy cache\000Level 1 instructi=
on cache p... */
-	{ 36389 },
+	{ 79811 },
 	/* l1-icache-speculative-load-miss\000legacy cache\000Level 1 instruction=
 cache pre... */
-	{ 36639 },
+	{ 79936 },
 	/* l1-icache-speculative-load-misses\000legacy cache\000Level 1 instructi=
on cache p... */
-	{ 36514 },
+	{ 80059 },
 	/* l1-icache-speculative-load-ops\000legacy cache\000Level 1 instruction =
cache pref... */
-	{ 36267 },
+	{ 80184 },
 	/* l1-icache-speculative-load-reference\000legacy cache\000Level 1 instru=
ction cach... */
-	{ 36139 },
+	{ 80306 },
 	/* l1-icache-speculative-load-refs\000legacy cache\000Level 1 instruction=
 cache pre... */
-	{ 36016 },
+	{ 80434 },
 	/* l1-icache-speculative-read\000legacy cache\000Level 1 instruction cach=
e prefetch... */
-	{ 35034 },
+	{ 80557 },
 	/* l1-icache-speculative-read-access\000legacy cache\000Level 1 instructi=
on cache p... */
-	{ 35525 },
+	{ 80675 },
 	/* l1-icache-speculative-read-miss\000legacy cache\000Level 1 instruction=
 cache pre... */
-	{ 35775 },
+	{ 80800 },
 	/* l1-icache-speculative-read-misses\000legacy cache\000Level 1 instructi=
on cache p... */
-	{ 35650 },
+	{ 80923 },
 	/* l1-icache-speculative-read-ops\000legacy cache\000Level 1 instruction =
cache pref... */
-	{ 35403 },
+	{ 81048 },
 	/* l1-icache-speculative-read-reference\000legacy cache\000Level 1 instru=
ction cach... */
-	{ 35275 },
+	{ 81170 },
 	/* l1-icache-speculative-read-refs\000legacy cache\000Level 1 instruction=
 cache pre... */
-	{ 35152 },
+	{ 81298 },
 	/* l1-instruction\000legacy cache\000Level 1 instruction cache read acces=
ses\000leg... */
-	{ 49266 },
+	{ 81421 },
 	/* l1-instruction-access\000legacy cache\000Level 1 instruction cache rea=
d accesses... */
-	{ 55483 },
+	{ 81519 },
 	/* l1-instruction-load\000legacy cache\000Level 1 instruction cache read =
accesses\0... */
-	{ 49364 },
+	{ 81624 },
 	/* l1-instruction-load-access\000legacy cache\000Level 1 instruction cach=
e read acc... */
-	{ 49795 },
+	{ 81727 },
 	/* l1-instruction-load-miss\000legacy cache\000Level 1 instruction cache =
read misse... */
-	{ 50019 },
+	{ 81837 },
 	/* l1-instruction-load-misses\000legacy cache\000Level 1 instruction cach=
e read mis... */
-	{ 49905 },
+	{ 81949 },
 	/* l1-instruction-load-ops\000legacy cache\000Level 1 instruction cache r=
ead access... */
-	{ 49688 },
+	{ 82063 },
 	/* l1-instruction-load-reference\000legacy cache\000Level 1 instruction c=
ache read ... */
-	{ 49575 },
+	{ 82170 },
 	/* l1-instruction-load-refs\000legacy cache\000Level 1 instruction cache =
read acces... */
-	{ 49467 },
+	{ 82283 },
 	/* l1-instruction-loads\000legacy cache\000Level 1 instruction cache read=
 accesses\... */
-	{ 50131 },
+	{ 82391 },
 	/* l1-instruction-loads-access\000legacy cache\000Level 1 instruction cac=
he read ac... */
-	{ 50566 },
+	{ 82495 },
 	/* l1-instruction-loads-miss\000legacy cache\000Level 1 instruction cache=
 read miss... */
-	{ 50792 },
+	{ 82606 },
 	/* l1-instruction-loads-misses\000legacy cache\000Level 1 instruction cac=
he read mi... */
-	{ 50677 },
+	{ 82719 },
 	/* l1-instruction-loads-ops\000legacy cache\000Level 1 instruction cache =
read acces... */
-	{ 50458 },
+	{ 82834 },
 	/* l1-instruction-loads-reference\000legacy cache\000Level 1 instruction =
cache read... */
-	{ 50344 },
+	{ 82942 },
 	/* l1-instruction-loads-refs\000legacy cache\000Level 1 instruction cache=
 read acce... */
-	{ 50235 },
+	{ 83056 },
 	/* l1-instruction-miss\000legacy cache\000Level 1 instruction cache read =
misses\000... */
-	{ 55697 },
+	{ 83165 },
 	/* l1-instruction-misses\000legacy cache\000Level 1 instruction cache rea=
d misses\0... */
-	{ 55588 },
+	{ 83272 },
 	/* l1-instruction-ops\000legacy cache\000Level 1 instruction cache read a=
ccesses\00... */
-	{ 55381 },
+	{ 83381 },
 	/* l1-instruction-prefetch\000legacy cache\000Level 1 instruction cache p=
refetch ac... */
-	{ 51672 },
+	{ 83483 },
 	/* l1-instruction-prefetch-access\000legacy cache\000Level 1 instruction =
cache pref... */
-	{ 52151 },
+	{ 83598 },
 	/* l1-instruction-prefetch-miss\000legacy cache\000Level 1 instruction ca=
che prefet... */
-	{ 52395 },
+	{ 83720 },
 	/* l1-instruction-prefetch-misses\000legacy cache\000Level 1 instruction =
cache pref... */
-	{ 52273 },
+	{ 83840 },
 	/* l1-instruction-prefetch-ops\000legacy cache\000Level 1 instruction cac=
he prefetc... */
-	{ 52032 },
+	{ 83962 },
 	/* l1-instruction-prefetch-reference\000legacy cache\000Level 1 instructi=
on cache p... */
-	{ 51907 },
+	{ 84081 },
 	/* l1-instruction-prefetch-refs\000legacy cache\000Level 1 instruction ca=
che prefet... */
-	{ 51787 },
+	{ 84206 },
 	/* l1-instruction-prefetches\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
-	{ 52515 },
+	{ 84326 },
 	/* l1-instruction-prefetches-access\000legacy cache\000Level 1 instructio=
n cache pr... */
-	{ 53002 },
+	{ 84443 },
 	/* l1-instruction-prefetches-miss\000legacy cache\000Level 1 instruction =
cache pref... */
-	{ 53250 },
+	{ 84567 },
 	/* l1-instruction-prefetches-misses\000legacy cache\000Level 1 instructio=
n cache pr... */
-	{ 53126 },
+	{ 84689 },
 	/* l1-instruction-prefetches-ops\000legacy cache\000Level 1 instruction c=
ache prefe... */
-	{ 52881 },
+	{ 84813 },
 	/* l1-instruction-prefetches-reference\000legacy cache\000Level 1 instruc=
tion cache... */
-	{ 52754 },
+	{ 84934 },
 	/* l1-instruction-prefetches-refs\000legacy cache\000Level 1 instruction =
cache pref... */
-	{ 52632 },
+	{ 85061 },
 	/* l1-instruction-read\000legacy cache\000Level 1 instruction cache read =
accesses\0... */
-	{ 50905 },
+	{ 85183 },
 	/* l1-instruction-read-access\000legacy cache\000Level 1 instruction cach=
e read acc... */
-	{ 51336 },
+	{ 85286 },
 	/* l1-instruction-read-miss\000legacy cache\000Level 1 instruction cache =
read misse... */
-	{ 51560 },
+	{ 85396 },
 	/* l1-instruction-read-misses\000legacy cache\000Level 1 instruction cach=
e read mis... */
-	{ 51446 },
+	{ 85508 },
 	/* l1-instruction-read-ops\000legacy cache\000Level 1 instruction cache r=
ead access... */
-	{ 51229 },
+	{ 85622 },
 	/* l1-instruction-read-reference\000legacy cache\000Level 1 instruction c=
ache read ... */
-	{ 51116 },
+	{ 85729 },
 	/* l1-instruction-read-refs\000legacy cache\000Level 1 instruction cache =
read acces... */
-	{ 51008 },
+	{ 85842 },
 	/* l1-instruction-reference\000legacy cache\000Level 1 instruction cache =
read acces... */
-	{ 55273 },
+	{ 85950 },
 	/* l1-instruction-refs\000legacy cache\000Level 1 instruction cache read =
accesses\0... */
-	{ 55170 },
+	{ 86058 },
 	/* l1-instruction-speculative-load\000legacy cache\000Level 1 instruction=
 cache pre... */
-	{ 54271 },
+	{ 86161 },
 	/* l1-instruction-speculative-load-access\000legacy cache\000Level 1 inst=
ruction ca... */
-	{ 54782 },
+	{ 86284 },
 	/* l1-instruction-speculative-load-miss\000legacy cache\000Level 1 instru=
ction cach... */
-	{ 55042 },
+	{ 86414 },
 	/* l1-instruction-speculative-load-misses\000legacy cache\000Level 1 inst=
ruction ca... */
-	{ 54912 },
+	{ 86542 },
 	/* l1-instruction-speculative-load-ops\000legacy cache\000Level 1 instruc=
tion cache... */
-	{ 54655 },
+	{ 86672 },
 	/* l1-instruction-speculative-load-reference\000legacy cache\000Level 1 i=
nstruction... */
-	{ 54522 },
+	{ 86799 },
 	/* l1-instruction-speculative-load-refs\000legacy cache\000Level 1 instru=
ction cach... */
-	{ 54394 },
+	{ 86932 },
 	/* l1-instruction-speculative-read\000legacy cache\000Level 1 instruction=
 cache pre... */
-	{ 53372 },
+	{ 87060 },
 	/* l1-instruction-speculative-read-access\000legacy cache\000Level 1 inst=
ruction ca... */
-	{ 53883 },
+	{ 87183 },
 	/* l1-instruction-speculative-read-miss\000legacy cache\000Level 1 instru=
ction cach... */
-	{ 54143 },
+	{ 87313 },
 	/* l1-instruction-speculative-read-misses\000legacy cache\000Level 1 inst=
ruction ca... */
-	{ 54013 },
+	{ 87441 },
 	/* l1-instruction-speculative-read-ops\000legacy cache\000Level 1 instruc=
tion cache... */
-	{ 53756 },
+	{ 87571 },
 	/* l1-instruction-speculative-read-reference\000legacy cache\000Level 1 i=
nstruction... */
-	{ 53623 },
+	{ 87698 },
 	/* l1-instruction-speculative-read-refs\000legacy cache\000Level 1 instru=
ction cach... */
-	{ 53495 },
+	{ 87831 },
 	/* l1d\000legacy cache\000Level 1 data cache read accesses\000legacy-cach=
e-config=3D0... */
-	{ 15676 },
+	{ 87959 },
 	/* l1d-access\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-c... */
-	{ 22971 },
+	{ 88039 },
 	/* l1d-load\000legacy cache\000Level 1 data cache read accesses\000legacy=
-cache-con... */
-	{ 15756 },
+	{ 88126 },
 	/* l1d-load-access\000legacy cache\000Level 1 data cache read accesses\00=
0legacy-ca... */
-	{ 16115 },
+	{ 88211 },
 	/* l1d-load-miss\000legacy cache\000Level 1 data cache read misses\000leg=
acy-cache-... */
-	{ 16303 },
+	{ 88303 },
 	/* l1d-load-misses\000legacy cache\000Level 1 data cache read misses\000l=
egacy-cach... */
-	{ 16207 },
+	{ 88397 },
 	/* l1d-load-ops\000legacy cache\000Level 1 data cache read accesses\000le=
gacy-cache... */
-	{ 16026 },
+	{ 88493 },
 	/* l1d-load-reference\000legacy cache\000Level 1 data cache read accesses=
\000legacy... */
-	{ 15931 },
+	{ 88582 },
 	/* l1d-load-refs\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cach... */
-	{ 15841 },
+	{ 88677 },
 	/* l1d-loads\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-co... */
-	{ 16397 },
+	{ 88767 },
 	/* l1d-loads-access\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-c... */
-	{ 16760 },
+	{ 88853 },
 	/* l1d-loads-miss\000legacy cache\000Level 1 data cache read misses\000le=
gacy-cache... */
-	{ 16950 },
+	{ 88946 },
 	/* l1d-loads-misses\000legacy cache\000Level 1 data cache read misses\000=
legacy-cac... */
-	{ 16853 },
+	{ 89041 },
 	/* l1d-loads-ops\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cach... */
-	{ 16670 },
+	{ 89138 },
 	/* l1d-loads-reference\000legacy cache\000Level 1 data cache read accesse=
s\000legac... */
-	{ 16574 },
+	{ 89228 },
 	/* l1d-loads-refs\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cac... */
-	{ 16483 },
+	{ 89324 },
 	/* l1d-miss\000legacy cache\000Level 1 data cache read misses\000legacy-c=
ache-confi... */
-	{ 23149 },
+	{ 89415 },
 	/* l1d-misses\000legacy cache\000Level 1 data cache read misses\000legacy=
-cache-con... */
-	{ 23058 },
+	{ 89504 },
 	/* l1d-ops\000legacy cache\000Level 1 data cache read accesses\000legacy-=
cache-conf... */
-	{ 22887 },
+	{ 89595 },
 	/* l1d-prefetch\000legacy cache\000Level 1 data cache prefetch accesses\0=
00legacy-c... */
-	{ 19718 },
+	{ 89679 },
 	/* l1d-prefetch-access\000legacy cache\000Level 1 data cache prefetch acc=
esses\000l... */
-	{ 20125 },
+	{ 89776 },
 	/* l1d-prefetch-miss\000legacy cache\000Level 1 data cache prefetch misse=
s\000legac... */
-	{ 20333 },
+	{ 89880 },
 	/* l1d-prefetch-misses\000legacy cache\000Level 1 data cache prefetch mis=
ses\000leg... */
-	{ 20229 },
+	{ 89982 },
 	/* l1d-prefetch-ops\000legacy cache\000Level 1 data cache prefetch access=
es\000lega... */
-	{ 20024 },
+	{ 90086 },
 	/* l1d-prefetch-reference\000legacy cache\000Level 1 data cache prefetch =
accesses\0... */
-	{ 19917 },
+	{ 90187 },
 	/* l1d-prefetch-refs\000legacy cache\000Level 1 data cache prefetch acces=
ses\000leg... */
-	{ 19815 },
+	{ 90294 },
 	/* l1d-prefetches\000legacy cache\000Level 1 data cache prefetch accesses=
\000legacy... */
-	{ 20435 },
+	{ 90396 },
 	/* l1d-prefetches-access\000legacy cache\000Level 1 data cache prefetch a=
ccesses\00... */
-	{ 20850 },
+	{ 90495 },
 	/* l1d-prefetches-miss\000legacy cache\000Level 1 data cache prefetch mis=
ses\000leg... */
-	{ 21062 },
+	{ 90601 },
 	/* l1d-prefetches-misses\000legacy cache\000Level 1 data cache prefetch m=
isses\000l... */
-	{ 20956 },
+	{ 90705 },
 	/* l1d-prefetches-ops\000legacy cache\000Level 1 data cache prefetch acce=
sses\000le... */
-	{ 20747 },
+	{ 90811 },
 	/* l1d-prefetches-reference\000legacy cache\000Level 1 data cache prefetc=
h accesses... */
-	{ 20638 },
+	{ 90914 },
 	/* l1d-prefetches-refs\000legacy cache\000Level 1 data cache prefetch acc=
esses\000l... */
-	{ 20534 },
+	{ 91023 },
 	/* l1d-read\000legacy cache\000Level 1 data cache read accesses\000legacy=
-cache-con... */
-	{ 17045 },
+	{ 91127 },
 	/* l1d-read-access\000legacy cache\000Level 1 data cache read accesses\00=
0legacy-ca... */
-	{ 17404 },
+	{ 91212 },
 	/* l1d-read-miss\000legacy cache\000Level 1 data cache read misses\000leg=
acy-cache-... */
-	{ 17592 },
+	{ 91304 },
 	/* l1d-read-misses\000legacy cache\000Level 1 data cache read misses\000l=
egacy-cach... */
-	{ 17496 },
+	{ 91398 },
 	/* l1d-read-ops\000legacy cache\000Level 1 data cache read accesses\000le=
gacy-cache... */
-	{ 17315 },
+	{ 91494 },
 	/* l1d-read-reference\000legacy cache\000Level 1 data cache read accesses=
\000legacy... */
-	{ 17220 },
+	{ 91583 },
 	/* l1d-read-refs\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cach... */
-	{ 17130 },
+	{ 91678 },
 	/* l1d-reference\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cach... */
-	{ 22797 },
+	{ 91768 },
 	/* l1d-refs\000legacy cache\000Level 1 data cache read accesses\000legacy=
-cache-con... */
-	{ 22712 },
+	{ 91858 },
 	/* l1d-speculative-load\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000... */
-	{ 21939 },
+	{ 91943 },
 	/* l1d-speculative-load-access\000legacy cache\000Level 1 data cache pref=
etch acces... */
-	{ 22378 },
+	{ 92048 },
 	/* l1d-speculative-load-miss\000legacy cache\000Level 1 data cache prefet=
ch misses\... */
-	{ 22602 },
+	{ 92160 },
 	/* l1d-speculative-load-misses\000legacy cache\000Level 1 data cache pref=
etch misse... */
-	{ 22490 },
+	{ 92270 },
 	/* l1d-speculative-load-ops\000legacy cache\000Level 1 data cache prefetc=
h accesses... */
-	{ 22269 },
+	{ 92382 },
 	/* l1d-speculative-load-reference\000legacy cache\000Level 1 data cache p=
refetch ac... */
-	{ 22154 },
+	{ 92491 },
 	/* l1d-speculative-load-refs\000legacy cache\000Level 1 data cache prefet=
ch accesse... */
-	{ 22044 },
+	{ 92606 },
 	/* l1d-speculative-read\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000... */
-	{ 21166 },
+	{ 92716 },
 	/* l1d-speculative-read-access\000legacy cache\000Level 1 data cache pref=
etch acces... */
-	{ 21605 },
+	{ 92821 },
 	/* l1d-speculative-read-miss\000legacy cache\000Level 1 data cache prefet=
ch misses\... */
-	{ 21829 },
+	{ 92933 },
 	/* l1d-speculative-read-misses\000legacy cache\000Level 1 data cache pref=
etch misse... */
-	{ 21717 },
+	{ 93043 },
 	/* l1d-speculative-read-ops\000legacy cache\000Level 1 data cache prefetc=
h accesses... */
-	{ 21496 },
+	{ 93155 },
 	/* l1d-speculative-read-reference\000legacy cache\000Level 1 data cache p=
refetch ac... */
-	{ 21381 },
+	{ 93264 },
 	/* l1d-speculative-read-refs\000legacy cache\000Level 1 data cache prefet=
ch accesse... */
-	{ 21271 },
+	{ 93379 },
 	/* l1d-store\000legacy cache\000Level 1 data cache write accesses\000lega=
cy-cache-c... */
-	{ 17686 },
+	{ 93489 },
 	/* l1d-store-access\000legacy cache\000Level 1 data cache write accesses\=
000legacy-... */
-	{ 18069 },
+	{ 93580 },
 	/* l1d-store-miss\000legacy cache\000Level 1 data cache write misses\000l=
egacy-cach... */
-	{ 18265 },
+	{ 93678 },
 	/* l1d-store-misses\000legacy cache\000Level 1 data cache write misses\00=
0legacy-ca... */
-	{ 18167 },
+	{ 93774 },
 	/* l1d-store-ops\000legacy cache\000Level 1 data cache write accesses\000=
legacy-cac... */
-	{ 17974 },
+	{ 93872 },
 	/* l1d-store-reference\000legacy cache\000Level 1 data cache write access=
es\000lega... */
-	{ 17873 },
+	{ 93967 },
 	/* l1d-store-refs\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-ca... */
-	{ 17777 },
+	{ 94068 },
 	/* l1d-stores\000legacy cache\000Level 1 data cache write accesses\000leg=
acy-cache-... */
-	{ 18361 },
+	{ 94164 },
 	/* l1d-stores-access\000legacy cache\000Level 1 data cache write accesses=
\000legacy... */
-	{ 18748 },
+	{ 94256 },
 	/* l1d-stores-miss\000legacy cache\000Level 1 data cache write misses\000=
legacy-cac... */
-	{ 18946 },
+	{ 94355 },
 	/* l1d-stores-misses\000legacy cache\000Level 1 data cache write misses\0=
00legacy-c... */
-	{ 18847 },
+	{ 94452 },
 	/* l1d-stores-ops\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-ca... */
-	{ 18652 },
+	{ 94551 },
 	/* l1d-stores-reference\000legacy cache\000Level 1 data cache write acces=
ses\000leg... */
-	{ 18550 },
+	{ 94647 },
 	/* l1d-stores-refs\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-c... */
-	{ 18453 },
+	{ 94749 },
 	/* l1d-write\000legacy cache\000Level 1 data cache write accesses\000lega=
cy-cache-c... */
-	{ 19043 },
+	{ 94846 },
 	/* l1d-write-access\000legacy cache\000Level 1 data cache write accesses\=
000legacy-... */
-	{ 19426 },
+	{ 94937 },
 	/* l1d-write-miss\000legacy cache\000Level 1 data cache write misses\000l=
egacy-cach... */
-	{ 19622 },
+	{ 95035 },
 	/* l1d-write-misses\000legacy cache\000Level 1 data cache write misses\00=
0legacy-ca... */
-	{ 19524 },
+	{ 95131 },
 	/* l1d-write-ops\000legacy cache\000Level 1 data cache write accesses\000=
legacy-cac... */
-	{ 19331 },
+	{ 95229 },
 	/* l1d-write-reference\000legacy cache\000Level 1 data cache write access=
es\000lega... */
-	{ 19230 },
+	{ 95324 },
 	/* l1d-write-refs\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-ca... */
-	{ 19134 },
+	{ 95425 },
 	/* l1i\000legacy cache\000Level 1 instruction cache read accesses\000lega=
cy-cache-c... */
-	{ 43344 },
+	{ 95521 },
 	/* l1i-access\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-... */
-	{ 48978 },
+	{ 95608 },
 	/* l1i-load\000legacy cache\000Level 1 instruction cache read accesses\00=
0legacy-ca... */
-	{ 43431 },
+	{ 95702 },
 	/* l1i-load-access\000legacy cache\000Level 1 instruction cache read acce=
sses\000le... */
-	{ 43818 },
+	{ 95794 },
 	/* l1i-load-miss\000legacy cache\000Level 1 instruction cache read misses=
\000legacy... */
-	{ 44020 },
+	{ 95893 },
 	/* l1i-load-misses\000legacy cache\000Level 1 instruction cache read miss=
es\000lega... */
-	{ 43917 },
+	{ 95994 },
 	/* l1i-load-ops\000legacy cache\000Level 1 instruction cache read accesse=
s\000legac... */
-	{ 43722 },
+	{ 96097 },
 	/* l1i-load-reference\000legacy cache\000Level 1 instruction cache read a=
ccesses\00... */
-	{ 43620 },
+	{ 96193 },
 	/* l1i-load-refs\000legacy cache\000Level 1 instruction cache read access=
es\000lega... */
-	{ 43523 },
+	{ 96295 },
 	/* l1i-loads\000legacy cache\000Level 1 instruction cache read accesses\0=
00legacy-c... */
-	{ 44121 },
+	{ 96392 },
 	/* l1i-loads-access\000legacy cache\000Level 1 instruction cache read acc=
esses\000l... */
-	{ 44512 },
+	{ 96485 },
 	/* l1i-loads-miss\000legacy cache\000Level 1 instruction cache read misse=
s\000legac... */
-	{ 44716 },
+	{ 96585 },
 	/* l1i-loads-misses\000legacy cache\000Level 1 instruction cache read mis=
ses\000leg... */
-	{ 44612 },
+	{ 96687 },
 	/* l1i-loads-ops\000legacy cache\000Level 1 instruction cache read access=
es\000lega... */
-	{ 44415 },
+	{ 96791 },
 	/* l1i-loads-reference\000legacy cache\000Level 1 instruction cache read =
accesses\0... */
-	{ 44312 },
+	{ 96888 },
 	/* l1i-loads-refs\000legacy cache\000Level 1 instruction cache read acces=
ses\000leg... */
-	{ 44214 },
+	{ 96991 },
 	/* l1i-miss\000legacy cache\000Level 1 instruction cache read misses\000l=
egacy-cach... */
-	{ 49170 },
+	{ 97089 },
 	/* l1i-misses\000legacy cache\000Level 1 instruction cache read misses\00=
0legacy-ca... */
-	{ 49072 },
+	{ 97185 },
 	/* l1i-ops\000legacy cache\000Level 1 instruction cache read accesses\000=
legacy-cac... */
-	{ 48887 },
+	{ 97283 },
 	/* l1i-prefetch\000legacy cache\000Level 1 instruction cache prefetch acc=
esses\000l... */
-	{ 45508 },
+	{ 97374 },
 	/* l1i-prefetch-access\000legacy cache\000Level 1 instruction cache prefe=
tch access... */
-	{ 45943 },
+	{ 97478 },
 	/* l1i-prefetch-miss\000legacy cache\000Level 1 instruction cache prefetc=
h misses\0... */
-	{ 46165 },
+	{ 97589 },
 	/* l1i-prefetch-misses\000legacy cache\000Level 1 instruction cache prefe=
tch misses... */
-	{ 46054 },
+	{ 97698 },
 	/* l1i-prefetch-ops\000legacy cache\000Level 1 instruction cache prefetch=
 accesses\... */
-	{ 45835 },
+	{ 97809 },
 	/* l1i-prefetch-reference\000legacy cache\000Level 1 instruction cache pr=
efetch acc... */
-	{ 45721 },
+	{ 97917 },
 	/* l1i-prefetch-refs\000legacy cache\000Level 1 instruction cache prefetc=
h accesses... */
-	{ 45612 },
+	{ 98031 },
 	/* l1i-prefetches\000legacy cache\000Level 1 instruction cache prefetch a=
ccesses\00... */
-	{ 46274 },
+	{ 98140 },
 	/* l1i-prefetches-access\000legacy cache\000Level 1 instruction cache pre=
fetch acce... */
-	{ 46717 },
+	{ 98246 },
 	/* l1i-prefetches-miss\000legacy cache\000Level 1 instruction cache prefe=
tch misses... */
-	{ 46943 },
+	{ 98359 },
 	/* l1i-prefetches-misses\000legacy cache\000Level 1 instruction cache pre=
fetch miss... */
-	{ 46830 },
+	{ 98470 },
 	/* l1i-prefetches-ops\000legacy cache\000Level 1 instruction cache prefet=
ch accesse... */
-	{ 46607 },
+	{ 98583 },
 	/* l1i-prefetches-reference\000legacy cache\000Level 1 instruction cache =
prefetch a... */
-	{ 46491 },
+	{ 98693 },
 	/* l1i-prefetches-refs\000legacy cache\000Level 1 instruction cache prefe=
tch access... */
-	{ 46380 },
+	{ 98809 },
 	/* l1i-read\000legacy cache\000Level 1 instruction cache read accesses\00=
0legacy-ca... */
-	{ 44818 },
+	{ 98920 },
 	/* l1i-read-access\000legacy cache\000Level 1 instruction cache read acce=
sses\000le... */
-	{ 45205 },
+	{ 99012 },
 	/* l1i-read-miss\000legacy cache\000Level 1 instruction cache read misses=
\000legacy... */
-	{ 45407 },
+	{ 99111 },
 	/* l1i-read-misses\000legacy cache\000Level 1 instruction cache read miss=
es\000lega... */
-	{ 45304 },
+	{ 99212 },
 	/* l1i-read-ops\000legacy cache\000Level 1 instruction cache read accesse=
s\000legac... */
-	{ 45109 },
+	{ 99315 },
 	/* l1i-read-reference\000legacy cache\000Level 1 instruction cache read a=
ccesses\00... */
-	{ 45007 },
+	{ 99411 },
 	/* l1i-read-refs\000legacy cache\000Level 1 instruction cache read access=
es\000lega... */
-	{ 44910 },
+	{ 99513 },
 	/* l1i-reference\000legacy cache\000Level 1 instruction cache read access=
es\000lega... */
-	{ 48790 },
+	{ 99610 },
 	/* l1i-refs\000legacy cache\000Level 1 instruction cache read accesses\00=
0legacy-ca... */
-	{ 48698 },
+	{ 99707 },
 	/* l1i-speculative-load\000legacy cache\000Level 1 instruction cache pref=
etch acces... */
-	{ 47876 },
+	{ 99799 },
 	/* l1i-speculative-load-access\000legacy cache\000Level 1 instruction cac=
he prefetc... */
-	{ 48343 },
+	{ 99911 },
 	/* l1i-speculative-load-miss\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
-	{ 48581 },
+	{ 100030 },
 	/* l1i-speculative-load-misses\000legacy cache\000Level 1 instruction cac=
he prefetc... */
-	{ 48462 },
+	{ 100147 },
 	/* l1i-speculative-load-ops\000legacy cache\000Level 1 instruction cache =
prefetch a... */
-	{ 48227 },
+	{ 100266 },
 	/* l1i-speculative-load-reference\000legacy cache\000Level 1 instruction =
cache pref... */
-	{ 48105 },
+	{ 100382 },
 	/* l1i-speculative-load-refs\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
-	{ 47988 },
+	{ 100504 },
 	/* l1i-speculative-read\000legacy cache\000Level 1 instruction cache pref=
etch acces... */
-	{ 47054 },
+	{ 100621 },
 	/* l1i-speculative-read-access\000legacy cache\000Level 1 instruction cac=
he prefetc... */
-	{ 47521 },
+	{ 100733 },
 	/* l1i-speculative-read-miss\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
-	{ 47759 },
+	{ 100852 },
 	/* l1i-speculative-read-misses\000legacy cache\000Level 1 instruction cac=
he prefetc... */
-	{ 47640 },
+	{ 100969 },
 	/* l1i-speculative-read-ops\000legacy cache\000Level 1 instruction cache =
prefetch a... */
-	{ 47405 },
+	{ 101088 },
 	/* l1i-speculative-read-reference\000legacy cache\000Level 1 instruction =
cache pref... */
-	{ 47283 },
+	{ 101204 },
 	/* l1i-speculative-read-refs\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
-	{ 47166 },
+	{ 101326 },
 	/* l2\000legacy cache\000Level 2 (or higher) last level cache read access=
es\000lega... */
-	{ 63212 },
+	{ 101443 },
 	/* l2-access\000legacy cache\000Level 2 (or higher) last level cache read=
 accesses\... */
-	{ 71765 },
+	{ 101540 },
 	/* l2-load\000legacy cache\000Level 2 (or higher) last level cache read a=
ccesses\00... */
-	{ 63309 },
+	{ 101644 },
 	/* l2-load-access\000legacy cache\000Level 2 (or higher) last level cache=
 read acce... */
-	{ 63736 },
+	{ 101746 },
 	/* l2-load-miss\000legacy cache\000Level 2 (or higher) last level cache r=
ead misses... */
-	{ 63958 },
+	{ 101855 },
 	/* l2-load-misses\000legacy cache\000Level 2 (or higher) last level cache=
 read miss... */
-	{ 63845 },
+	{ 101966 },
 	/* l2-load-ops\000legacy cache\000Level 2 (or higher) last level cache re=
ad accesse... */
-	{ 63630 },
+	{ 102079 },
 	/* l2-load-reference\000legacy cache\000Level 2 (or higher) last level ca=
che read a... */
-	{ 63518 },
+	{ 102185 },
 	/* l2-load-refs\000legacy cache\000Level 2 (or higher) last level cache r=
ead access... */
-	{ 63411 },
+	{ 102297 },
 	/* l2-loads\000legacy cache\000Level 2 (or higher) last level cache read =
accesses\0... */
-	{ 64069 },
+	{ 102404 },
 	/* l2-loads-access\000legacy cache\000Level 2 (or higher) last level cach=
e read acc... */
-	{ 64500 },
+	{ 102507 },
 	/* l2-loads-miss\000legacy cache\000Level 2 (or higher) last level cache =
read misse... */
-	{ 64724 },
+	{ 102617 },
 	/* l2-loads-misses\000legacy cache\000Level 2 (or higher) last level cach=
e read mis... */
-	{ 64610 },
+	{ 102729 },
 	/* l2-loads-ops\000legacy cache\000Level 2 (or higher) last level cache r=
ead access... */
-	{ 64393 },
+	{ 102843 },
 	/* l2-loads-reference\000legacy cache\000Level 2 (or higher) last level c=
ache read ... */
-	{ 64280 },
+	{ 102950 },
 	/* l2-loads-refs\000legacy cache\000Level 2 (or higher) last level cache =
read acces... */
-	{ 64172 },
+	{ 103063 },
 	/* l2-miss\000legacy cache\000Level 2 (or higher) last level cache read m=
isses\000l... */
-	{ 71977 },
+	{ 103171 },
 	/* l2-misses\000legacy cache\000Level 2 (or higher) last level cache read=
 misses\00... */
-	{ 71869 },
+	{ 103277 },
 	/* l2-ops\000legacy cache\000Level 2 (or higher) last level cache read ac=
cesses\000... */
-	{ 71664 },
+	{ 103385 },
 	/* l2-prefetch\000legacy cache\000Level 2 (or higher) last level cache pr=
efetch acc... */
-	{ 67985 },
+	{ 103486 },
 	/* l2-prefetch-access\000legacy cache\000Level 2 (or higher) last level c=
ache prefe... */
-	{ 68460 },
+	{ 103600 },
 	/* l2-prefetch-miss\000legacy cache\000Level 2 (or higher) last level cac=
he prefetc... */
-	{ 68702 },
+	{ 103721 },
 	/* l2-prefetch-misses\000legacy cache\000Level 2 (or higher) last level c=
ache prefe... */
-	{ 68581 },
+	{ 103840 },
 	/* l2-prefetch-ops\000legacy cache\000Level 2 (or higher) last level cach=
e prefetch... */
-	{ 68342 },
+	{ 103961 },
 	/* l2-prefetch-reference\000legacy cache\000Level 2 (or higher) last leve=
l cache pr... */
-	{ 68218 },
+	{ 104079 },
 	/* l2-prefetch-refs\000legacy cache\000Level 2 (or higher) last level cac=
he prefetc... */
-	{ 68099 },
+	{ 104203 },
 	/* l2-prefetches\000legacy cache\000Level 2 (or higher) last level cache =
prefetch a... */
-	{ 68821 },
+	{ 104322 },
 	/* l2-prefetches-access\000legacy cache\000Level 2 (or higher) last level=
 cache pre... */
-	{ 69304 },
+	{ 104438 },
 	/* l2-prefetches-miss\000legacy cache\000Level 2 (or higher) last level c=
ache prefe... */
-	{ 69550 },
+	{ 104561 },
 	/* l2-prefetches-misses\000legacy cache\000Level 2 (or higher) last level=
 cache pre... */
-	{ 69427 },
+	{ 104682 },
 	/* l2-prefetches-ops\000legacy cache\000Level 2 (or higher) last level ca=
che prefet... */
-	{ 69184 },
+	{ 104805 },
 	/* l2-prefetches-reference\000legacy cache\000Level 2 (or higher) last le=
vel cache ... */
-	{ 69058 },
+	{ 104925 },
 	/* l2-prefetches-refs\000legacy cache\000Level 2 (or higher) last level c=
ache prefe... */
-	{ 68937 },
+	{ 105051 },
 	/* l2-read\000legacy cache\000Level 2 (or higher) last level cache read a=
ccesses\00... */
-	{ 64836 },
+	{ 105172 },
 	/* l2-read-access\000legacy cache\000Level 2 (or higher) last level cache=
 read acce... */
-	{ 65263 },
+	{ 105274 },
 	/* l2-read-miss\000legacy cache\000Level 2 (or higher) last level cache r=
ead misses... */
-	{ 65485 },
+	{ 105383 },
 	/* l2-read-misses\000legacy cache\000Level 2 (or higher) last level cache=
 read miss... */
-	{ 65372 },
+	{ 105494 },
 	/* l2-read-ops\000legacy cache\000Level 2 (or higher) last level cache re=
ad accesse... */
-	{ 65157 },
+	{ 105607 },
 	/* l2-read-reference\000legacy cache\000Level 2 (or higher) last level ca=
che read a... */
-	{ 65045 },
+	{ 105713 },
 	/* l2-read-refs\000legacy cache\000Level 2 (or higher) last level cache r=
ead access... */
-	{ 64938 },
+	{ 105825 },
 	/* l2-reference\000legacy cache\000Level 2 (or higher) last level cache r=
ead access... */
-	{ 71557 },
+	{ 105932 },
 	/* l2-refs\000legacy cache\000Level 2 (or higher) last level cache read a=
ccesses\00... */
-	{ 71455 },
+	{ 106039 },
 	/* l2-speculative-load\000legacy cache\000Level 2 (or higher) last level =
cache pref... */
-	{ 70563 },
+	{ 106141 },
 	/* l2-speculative-load-access\000legacy cache\000Level 2 (or higher) last=
 level cac... */
-	{ 71070 },
+	{ 106263 },
 	/* l2-speculative-load-miss\000legacy cache\000Level 2 (or higher) last l=
evel cache... */
-	{ 71328 },
+	{ 106392 },
 	/* l2-speculative-load-misses\000legacy cache\000Level 2 (or higher) last=
 level cac... */
-	{ 71199 },
+	{ 106519 },
 	/* l2-speculative-load-ops\000legacy cache\000Level 2 (or higher) last le=
vel cache ... */
-	{ 70944 },
+	{ 106648 },
 	/* l2-speculative-load-reference\000legacy cache\000Level 2 (or higher) l=
ast level ... */
-	{ 70812 },
+	{ 106774 },
 	/* l2-speculative-load-refs\000legacy cache\000Level 2 (or higher) last l=
evel cache... */
-	{ 70685 },
+	{ 106906 },
 	/* l2-speculative-read\000legacy cache\000Level 2 (or higher) last level =
cache pref... */
-	{ 69671 },
+	{ 107033 },
 	/* l2-speculative-read-access\000legacy cache\000Level 2 (or higher) last=
 level cac... */
-	{ 70178 },
+	{ 107155 },
 	/* l2-speculative-read-miss\000legacy cache\000Level 2 (or higher) last l=
evel cache... */
-	{ 70436 },
+	{ 107284 },
 	/* l2-speculative-read-misses\000legacy cache\000Level 2 (or higher) last=
 level cac... */
-	{ 70307 },
+	{ 107411 },
 	/* l2-speculative-read-ops\000legacy cache\000Level 2 (or higher) last le=
vel cache ... */
-	{ 70052 },
+	{ 107540 },
 	/* l2-speculative-read-reference\000legacy cache\000Level 2 (or higher) l=
ast level ... */
-	{ 69920 },
+	{ 107666 },
 	/* l2-speculative-read-refs\000legacy cache\000Level 2 (or higher) last l=
evel cache... */
-	{ 69793 },
+	{ 107798 },
 	/* l2-store\000legacy cache\000Level 2 (or higher) last level cache write=
 accesses\... */
-	{ 65596 },
+	{ 107925 },
 	/* l2-store-access\000legacy cache\000Level 2 (or higher) last level cach=
e write ac... */
-	{ 66047 },
+	{ 108033 },
 	/* l2-store-miss\000legacy cache\000Level 2 (or higher) last level cache =
write miss... */
-	{ 66277 },
+	{ 108148 },
 	/* l2-store-misses\000legacy cache\000Level 2 (or higher) last level cach=
e write mi... */
-	{ 66162 },
+	{ 108261 },
 	/* l2-store-ops\000legacy cache\000Level 2 (or higher) last level cache w=
rite acces... */
-	{ 65935 },
+	{ 108376 },
 	/* l2-store-reference\000legacy cache\000Level 2 (or higher) last level c=
ache write... */
-	{ 65817 },
+	{ 108488 },
 	/* l2-store-refs\000legacy cache\000Level 2 (or higher) last level cache =
write acce... */
-	{ 65704 },
+	{ 108606 },
 	/* l2-stores\000legacy cache\000Level 2 (or higher) last level cache writ=
e accesses... */
-	{ 66390 },
+	{ 108719 },
 	/* l2-stores-access\000legacy cache\000Level 2 (or higher) last level cac=
he write a... */
-	{ 66845 },
+	{ 108828 },
 	/* l2-stores-miss\000legacy cache\000Level 2 (or higher) last level cache=
 write mis... */
-	{ 67077 },
+	{ 108944 },
 	/* l2-stores-misses\000legacy cache\000Level 2 (or higher) last level cac=
he write m... */
-	{ 66961 },
+	{ 109058 },
 	/* l2-stores-ops\000legacy cache\000Level 2 (or higher) last level cache =
write acce... */
-	{ 66732 },
+	{ 109174 },
 	/* l2-stores-reference\000legacy cache\000Level 2 (or higher) last level =
cache writ... */
-	{ 66613 },
+	{ 109287 },
 	/* l2-stores-refs\000legacy cache\000Level 2 (or higher) last level cache=
 write acc... */
-	{ 66499 },
+	{ 109406 },
 	/* l2-write\000legacy cache\000Level 2 (or higher) last level cache write=
 accesses\... */
-	{ 67191 },
+	{ 109520 },
 	/* l2-write-access\000legacy cache\000Level 2 (or higher) last level cach=
e write ac... */
-	{ 67642 },
+	{ 109628 },
 	/* l2-write-miss\000legacy cache\000Level 2 (or higher) last level cache =
write miss... */
-	{ 67872 },
+	{ 109743 },
 	/* l2-write-misses\000legacy cache\000Level 2 (or higher) last level cach=
e write mi... */
-	{ 67757 },
+	{ 109856 },
 	/* l2-write-ops\000legacy cache\000Level 2 (or higher) last level cache w=
rite acces... */
-	{ 67530 },
+	{ 109971 },
 	/* l2-write-reference\000legacy cache\000Level 2 (or higher) last level c=
ache write... */
-	{ 67412 },
+	{ 110083 },
 	/* l2-write-refs\000legacy cache\000Level 2 (or higher) last level cache =
write acce... */
-	{ 67299 },
+	{ 110201 },
 	/* llc\000legacy cache\000Last level cache read accesses\000legacy-cache-=
config=3D2\0... */
-	{ 55804 },
+	{ 110412 },
 	/* llc-access\000legacy cache\000Last level cache read accesses\000legacy=
-cache-con... */
-	{ 62951 },
+	{ 110490 },
 	/* llc-load\000legacy cache\000Last level cache read accesses\000legacy-c=
ache-confi... */
-	{ 55882 },
+	{ 110575 },
 	/* llc-load-access\000legacy cache\000Last level cache read accesses\000l=
egacy-cach... */
-	{ 56233 },
+	{ 110658 },
 	/* llc-load-miss\000legacy cache\000Last level cache read misses\000legac=
y-cache-co... */
-	{ 56417 },
+	{ 110748 },
 	/* llc-load-misses\000legacy cache\000Last level cache read misses\000leg=
acy-cache-... */
-	{ 56323 },
+	{ 110840 },
 	/* llc-load-ops\000legacy cache\000Last level cache read accesses\000lega=
cy-cache-c... */
-	{ 56146 },
+	{ 110934 },
 	/* llc-load-reference\000legacy cache\000Last level cache read accesses\0=
00legacy-c... */
-	{ 56053 },
+	{ 111021 },
 	/* llc-load-refs\000legacy cache\000Last level cache read accesses\000leg=
acy-cache-... */
-	{ 55965 },
+	{ 111114 },
 	/* llc-loads\000legacy cache\000Last level cache read accesses\000legacy-=
cache-conf... */
-	{ 56509 },
+	{ 111202 },
 	/* llc-loads-access\000legacy cache\000Last level cache read accesses\000=
legacy-cac... */
-	{ 56864 },
+	{ 111286 },
 	/* llc-loads-miss\000legacy cache\000Last level cache read misses\000lega=
cy-cache-c... */
-	{ 57050 },
+	{ 111377 },
 	/* llc-loads-misses\000legacy cache\000Last level cache read misses\000le=
gacy-cache... */
-	{ 56955 },
+	{ 111470 },
 	/* llc-loads-ops\000legacy cache\000Last level cache read accesses\000leg=
acy-cache-... */
-	{ 56776 },
+	{ 111565 },
 	/* llc-loads-reference\000legacy cache\000Last level cache read accesses\=
000legacy-... */
-	{ 56682 },
+	{ 111653 },
 	/* llc-loads-refs\000legacy cache\000Last level cache read accesses\000le=
gacy-cache... */
-	{ 56593 },
+	{ 111747 },
 	/* llc-miss\000legacy cache\000Last level cache read misses\000legacy-cac=
he-config=3D... */
-	{ 63125 },
+	{ 111836 },
 	/* llc-misses\000legacy cache\000Last level cache read misses\000legacy-c=
ache-confi... */
-	{ 63036 },
+	{ 111923 },
 	/* llc-ops\000legacy cache\000Last level cache read accesses\000legacy-ca=
che-config... */
-	{ 62869 },
+	{ 112012 },
 	/* llc-prefetch\000legacy cache\000Last level cache prefetch accesses\000=
legacy-cac... */
-	{ 59760 },
+	{ 112094 },
 	/* llc-prefetch-access\000legacy cache\000Last level cache prefetch acces=
ses\000leg... */
-	{ 60159 },
+	{ 112189 },
 	/* llc-prefetch-miss\000legacy cache\000Last level cache prefetch misses\=
000legacy-... */
-	{ 60363 },
+	{ 112291 },
 	/* llc-prefetch-misses\000legacy cache\000Last level cache prefetch misse=
s\000legac... */
-	{ 60261 },
+	{ 112391 },
 	/* llc-prefetch-ops\000legacy cache\000Last level cache prefetch accesses=
\000legacy... */
-	{ 60060 },
+	{ 112493 },
 	/* llc-prefetch-reference\000legacy cache\000Last level cache prefetch ac=
cesses\000... */
-	{ 59955 },
+	{ 112592 },
 	/* llc-prefetch-refs\000legacy cache\000Last level cache prefetch accesse=
s\000legac... */
-	{ 59855 },
+	{ 112697 },
 	/* llc-prefetches\000legacy cache\000Last level cache prefetch accesses\0=
00legacy-c... */
-	{ 60463 },
+	{ 112797 },
 	/* llc-prefetches-access\000legacy cache\000Last level cache prefetch acc=
esses\000l... */
-	{ 60870 },
+	{ 112894 },
 	/* llc-prefetches-miss\000legacy cache\000Last level cache prefetch misse=
s\000legac... */
-	{ 61078 },
+	{ 112998 },
 	/* llc-prefetches-misses\000legacy cache\000Last level cache prefetch mis=
ses\000leg... */
-	{ 60974 },
+	{ 113100 },
 	/* llc-prefetches-ops\000legacy cache\000Last level cache prefetch access=
es\000lega... */
-	{ 60769 },
+	{ 113204 },
 	/* llc-prefetches-reference\000legacy cache\000Last level cache prefetch =
accesses\0... */
-	{ 60662 },
+	{ 113305 },
 	/* llc-prefetches-refs\000legacy cache\000Last level cache prefetch acces=
ses\000leg... */
-	{ 60560 },
+	{ 113412 },
 	/* llc-read\000legacy cache\000Last level cache read accesses\000legacy-c=
ache-confi... */
-	{ 57143 },
+	{ 113514 },
 	/* llc-read-access\000legacy cache\000Last level cache read accesses\000l=
egacy-cach... */
-	{ 57494 },
+	{ 113597 },
 	/* llc-read-miss\000legacy cache\000Last level cache read misses\000legac=
y-cache-co... */
-	{ 57678 },
+	{ 113687 },
 	/* llc-read-misses\000legacy cache\000Last level cache read misses\000leg=
acy-cache-... */
-	{ 57584 },
+	{ 113779 },
 	/* llc-read-ops\000legacy cache\000Last level cache read accesses\000lega=
cy-cache-c... */
-	{ 57407 },
+	{ 113873 },
 	/* llc-read-reference\000legacy cache\000Last level cache read accesses\0=
00legacy-c... */
-	{ 57314 },
+	{ 113960 },
 	/* llc-read-refs\000legacy cache\000Last level cache read accesses\000leg=
acy-cache-... */
-	{ 57226 },
+	{ 114053 },
 	/* llc-reference\000legacy cache\000Last level cache read accesses\000leg=
acy-cache-... */
-	{ 62781 },
+	{ 114141 },
 	/* llc-refs\000legacy cache\000Last level cache read accesses\000legacy-c=
ache-confi... */
-	{ 62698 },
+	{ 114229 },
 	/* llc-speculative-load\000legacy cache\000Last level cache prefetch acce=
sses\000le... */
-	{ 61939 },
+	{ 114312 },
 	/* llc-speculative-load-access\000legacy cache\000Last level cache prefet=
ch accesse... */
-	{ 62370 },
+	{ 114415 },
 	/* llc-speculative-load-miss\000legacy cache\000Last level cache prefetch=
 misses\00... */
-	{ 62590 },
+	{ 114525 },
 	/* llc-speculative-load-misses\000legacy cache\000Last level cache prefet=
ch misses\... */
-	{ 62480 },
+	{ 114633 },
 	/* llc-speculative-load-ops\000legacy cache\000Last level cache prefetch =
accesses\0... */
-	{ 62263 },
+	{ 114743 },
 	/* llc-speculative-load-reference\000legacy cache\000Last level cache pre=
fetch acce... */
-	{ 62150 },
+	{ 114850 },
 	/* llc-speculative-load-refs\000legacy cache\000Last level cache prefetch=
 accesses\... */
-	{ 62042 },
+	{ 114963 },
 	/* llc-speculative-read\000legacy cache\000Last level cache prefetch acce=
sses\000le... */
-	{ 61180 },
+	{ 115071 },
 	/* llc-speculative-read-access\000legacy cache\000Last level cache prefet=
ch accesse... */
-	{ 61611 },
+	{ 115174 },
 	/* llc-speculative-read-miss\000legacy cache\000Last level cache prefetch=
 misses\00... */
-	{ 61831 },
+	{ 115284 },
 	/* llc-speculative-read-misses\000legacy cache\000Last level cache prefet=
ch misses\... */
-	{ 61721 },
+	{ 115392 },
 	/* llc-speculative-read-ops\000legacy cache\000Last level cache prefetch =
accesses\0... */
-	{ 61504 },
+	{ 115502 },
 	/* llc-speculative-read-reference\000legacy cache\000Last level cache pre=
fetch acce... */
-	{ 61391 },
+	{ 115609 },
 	/* llc-speculative-read-refs\000legacy cache\000Last level cache prefetch=
 accesses\... */
-	{ 61283 },
+	{ 115722 },
 	/* llc-store\000legacy cache\000Last level cache write accesses\000legacy=
-cache-con... */
-	{ 57770 },
+	{ 115830 },
 	/* llc-store-access\000legacy cache\000Last level cache write accesses\00=
0legacy-ca... */
-	{ 58145 },
+	{ 115919 },
 	/* llc-store-miss\000legacy cache\000Last level cache write misses\000leg=
acy-cache-... */
-	{ 58337 },
+	{ 116015 },
 	/* llc-store-misses\000legacy cache\000Last level cache write misses\000l=
egacy-cach... */
-	{ 58241 },
+	{ 116109 },
 	/* llc-store-ops\000legacy cache\000Last level cache write accesses\000le=
gacy-cache... */
-	{ 58052 },
+	{ 116205 },
 	/* llc-store-reference\000legacy cache\000Last level cache write accesses=
\000legacy... */
-	{ 57953 },
+	{ 116298 },
 	/* llc-store-refs\000legacy cache\000Last level cache write accesses\000l=
egacy-cach... */
-	{ 57859 },
+	{ 116397 },
 	/* llc-stores\000legacy cache\000Last level cache write accesses\000legac=
y-cache-co... */
-	{ 58431 },
+	{ 116491 },
 	/* llc-stores-access\000legacy cache\000Last level cache write accesses\0=
00legacy-c... */
-	{ 58810 },
+	{ 116581 },
 	/* llc-stores-miss\000legacy cache\000Last level cache write misses\000le=
gacy-cache... */
-	{ 59004 },
+	{ 116678 },
 	/* llc-stores-misses\000legacy cache\000Last level cache write misses\000=
legacy-cac... */
-	{ 58907 },
+	{ 116773 },
 	/* llc-stores-ops\000legacy cache\000Last level cache write accesses\000l=
egacy-cach... */
-	{ 58716 },
+	{ 116870 },
 	/* llc-stores-reference\000legacy cache\000Last level cache write accesse=
s\000legac... */
-	{ 58616 },
+	{ 116964 },
 	/* llc-stores-refs\000legacy cache\000Last level cache write accesses\000=
legacy-cac... */
-	{ 58521 },
+	{ 117064 },
 	/* llc-write\000legacy cache\000Last level cache write accesses\000legacy=
-cache-con... */
-	{ 59099 },
+	{ 117159 },
 	/* llc-write-access\000legacy cache\000Last level cache write accesses\00=
0legacy-ca... */
-	{ 59474 },
+	{ 117248 },
 	/* llc-write-miss\000legacy cache\000Last level cache write misses\000leg=
acy-cache-... */
-	{ 59666 },
+	{ 117344 },
 	/* llc-write-misses\000legacy cache\000Last level cache write misses\000l=
egacy-cach... */
-	{ 59570 },
+	{ 117438 },
 	/* llc-write-ops\000legacy cache\000Last level cache write accesses\000le=
gacy-cache... */
-	{ 59381 },
+	{ 117534 },
 	/* llc-write-reference\000legacy cache\000Last level cache write accesses=
\000legacy... */
-	{ 59282 },
+	{ 117627 },
 	/* llc-write-refs\000legacy cache\000Last level cache write accesses\000l=
egacy-cach... */
-	{ 59188 },
+	{ 117726 },
 	/* node\000legacy cache\000Local memory read accesses\000legacy-cache-con=
fig=3D6\000\... */
-	{ 114128 },
+	{ 118164 },
 	/* node-access\000legacy cache\000Local memory read accesses\000legacy-ca=
che-config... */
-	{ 121053 },
+	{ 118239 },
 	/* node-load\000legacy cache\000Local memory read accesses\000legacy-cach=
e-config=3D6... */
-	{ 114203 },
+	{ 118321 },
 	/* node-load-access\000legacy cache\000Local memory read accesses\000lega=
cy-cache-c... */
-	{ 114542 },
+	{ 118401 },
 	/* node-load-miss\000legacy cache\000Local memory read misses\000legacy-c=
ache-confi... */
-	{ 114720 },
+	{ 118488 },
 	/* node-load-misses\000legacy cache\000Local memory read misses\000legacy=
-cache-con... */
-	{ 114629 },
+	{ 118577 },
 	/* node-load-ops\000legacy cache\000Local memory read accesses\000legacy-=
cache-conf... */
-	{ 114458 },
+	{ 118668 },
 	/* node-load-reference\000legacy cache\000Local memory read accesses\000l=
egacy-cach... */
-	{ 114368 },
+	{ 118752 },
 	/* node-load-refs\000legacy cache\000Local memory read accesses\000legacy=
-cache-con... */
-	{ 114283 },
+	{ 118842 },
 	/* node-loads\000legacy cache\000Local memory read accesses\000legacy-cac=
he-config=3D... */
-	{ 114809 },
+	{ 118927 },
 	/* node-loads-access\000legacy cache\000Local memory read accesses\000leg=
acy-cache-... */
-	{ 115152 },
+	{ 119008 },
 	/* node-loads-miss\000legacy cache\000Local memory read misses\000legacy-=
cache-conf... */
-	{ 115332 },
+	{ 119096 },
 	/* node-loads-misses\000legacy cache\000Local memory read misses\000legac=
y-cache-co... */
-	{ 115240 },
+	{ 119186 },
 	/* node-loads-ops\000legacy cache\000Local memory read accesses\000legacy=
-cache-con... */
-	{ 115067 },
+	{ 119278 },
 	/* node-loads-reference\000legacy cache\000Local memory read accesses\000=
legacy-cac... */
-	{ 114976 },
+	{ 119363 },
 	/* node-loads-refs\000legacy cache\000Local memory read accesses\000legac=
y-cache-co... */
-	{ 114890 },
+	{ 119454 },
 	/* node-miss\000legacy cache\000Local memory read misses\000legacy-cache-=
config=3D0x1... */
-	{ 121221 },
+	{ 119540 },
 	/* node-misses\000legacy cache\000Local memory read misses\000legacy-cach=
e-config=3D0... */
-	{ 121135 },
+	{ 119624 },
 	/* node-ops\000legacy cache\000Local memory read accesses\000legacy-cache=
-config=3D6\... */
-	{ 120974 },
+	{ 119710 },
 	/* node-prefetch\000legacy cache\000Local memory prefetch accesses\000leg=
acy-cache-... */
-	{ 117955 },
+	{ 119789 },
 	/* node-prefetch-access\000legacy cache\000Local memory prefetch accesses=
\000legacy... */
-	{ 118342 },
+	{ 119881 },
 	/* node-prefetch-miss\000legacy cache\000Local memory prefetch misses\000=
legacy-cac... */
-	{ 118540 },
+	{ 119980 },
 	/* node-prefetch-misses\000legacy cache\000Local memory prefetch misses\0=
00legacy-c... */
-	{ 118441 },
+	{ 120077 },
 	/* node-prefetch-ops\000legacy cache\000Local memory prefetch accesses\00=
0legacy-ca... */
-	{ 118246 },
+	{ 120176 },
 	/* node-prefetch-reference\000legacy cache\000Local memory prefetch acces=
ses\000leg... */
-	{ 118144 },
+	{ 120272 },
 	/* node-prefetch-refs\000legacy cache\000Local memory prefetch accesses\0=
00legacy-c... */
-	{ 118047 },
+	{ 120374 },
 	/* node-prefetches\000legacy cache\000Local memory prefetch accesses\000l=
egacy-cach... */
-	{ 118637 },
+	{ 120471 },
 	/* node-prefetches-access\000legacy cache\000Local memory prefetch access=
es\000lega... */
-	{ 119032 },
+	{ 120565 },
 	/* node-prefetches-miss\000legacy cache\000Local memory prefetch misses\0=
00legacy-c... */
-	{ 119234 },
+	{ 120666 },
 	/* node-prefetches-misses\000legacy cache\000Local memory prefetch misses=
\000legacy... */
-	{ 119133 },
+	{ 120765 },
 	/* node-prefetches-ops\000legacy cache\000Local memory prefetch accesses\=
000legacy-... */
-	{ 118934 },
+	{ 120866 },
 	/* node-prefetches-reference\000legacy cache\000Local memory prefetch acc=
esses\000l... */
-	{ 118830 },
+	{ 120964 },
 	/* node-prefetches-refs\000legacy cache\000Local memory prefetch accesses=
\000legacy... */
-	{ 118731 },
+	{ 121068 },
 	/* node-read\000legacy cache\000Local memory read accesses\000legacy-cach=
e-config=3D6... */
-	{ 115422 },
+	{ 121167 },
 	/* node-read-access\000legacy cache\000Local memory read accesses\000lega=
cy-cache-c... */
-	{ 115761 },
+	{ 121247 },
 	/* node-read-miss\000legacy cache\000Local memory read misses\000legacy-c=
ache-confi... */
-	{ 115939 },
+	{ 121334 },
 	/* node-read-misses\000legacy cache\000Local memory read misses\000legacy=
-cache-con... */
-	{ 115848 },
+	{ 121423 },
 	/* node-read-ops\000legacy cache\000Local memory read accesses\000legacy-=
cache-conf... */
-	{ 115677 },
+	{ 121514 },
 	/* node-read-reference\000legacy cache\000Local memory read accesses\000l=
egacy-cach... */
-	{ 115587 },
+	{ 121598 },
 	/* node-read-refs\000legacy cache\000Local memory read accesses\000legacy=
-cache-con... */
-	{ 115502 },
+	{ 121688 },
 	/* node-reference\000legacy cache\000Local memory read accesses\000legacy=
-cache-con... */
-	{ 120889 },
+	{ 121773 },
 	/* node-refs\000legacy cache\000Local memory read accesses\000legacy-cach=
e-config=3D6... */
-	{ 120809 },
+	{ 121858 },
 	/* node-speculative-load\000legacy cache\000Local memory prefetch accesse=
s\000legac... */
-	{ 120071 },
+	{ 121938 },
 	/* node-speculative-load-access\000legacy cache\000Local memory prefetch =
accesses\0... */
-	{ 120490 },
+	{ 122038 },
 	/* node-speculative-load-miss\000legacy cache\000Local memory prefetch mi=
sses\000le... */
-	{ 120704 },
+	{ 122145 },
 	/* node-speculative-load-misses\000legacy cache\000Local memory prefetch =
misses\000... */
-	{ 120597 },
+	{ 122250 },
 	/* node-speculative-load-ops\000legacy cache\000Local memory prefetch acc=
esses\000l... */
-	{ 120386 },
+	{ 122357 },
 	/* node-speculative-load-reference\000legacy cache\000Local memory prefet=
ch accesse... */
-	{ 120276 },
+	{ 122461 },
 	/* node-speculative-load-refs\000legacy cache\000Local memory prefetch ac=
cesses\000... */
-	{ 120171 },
+	{ 122571 },
 	/* node-speculative-read\000legacy cache\000Local memory prefetch accesse=
s\000legac... */
-	{ 119333 },
+	{ 122676 },
 	/* node-speculative-read-access\000legacy cache\000Local memory prefetch =
accesses\0... */
-	{ 119752 },
+	{ 122776 },
 	/* node-speculative-read-miss\000legacy cache\000Local memory prefetch mi=
sses\000le... */
-	{ 119966 },
+	{ 122883 },
 	/* node-speculative-read-misses\000legacy cache\000Local memory prefetch =
misses\000... */
-	{ 119859 },
+	{ 122988 },
 	/* node-speculative-read-ops\000legacy cache\000Local memory prefetch acc=
esses\000l... */
-	{ 119648 },
+	{ 123095 },
 	/* node-speculative-read-reference\000legacy cache\000Local memory prefet=
ch accesse... */
-	{ 119538 },
+	{ 123199 },
 	/* node-speculative-read-refs\000legacy cache\000Local memory prefetch ac=
cesses\000... */
-	{ 119433 },
+	{ 123309 },
 	/* node-store\000legacy cache\000Local memory write accesses\000legacy-ca=
che-config... */
-	{ 116028 },
+	{ 123414 },
 	/* node-store-access\000legacy cache\000Local memory write accesses\000le=
gacy-cache... */
-	{ 116391 },
+	{ 123500 },
 	/* node-store-miss\000legacy cache\000Local memory write misses\000legacy=
-cache-con... */
-	{ 116577 },
+	{ 123593 },
 	/* node-store-misses\000legacy cache\000Local memory write misses\000lega=
cy-cache-c... */
-	{ 116484 },
+	{ 123684 },
 	/* node-store-ops\000legacy cache\000Local memory write accesses\000legac=
y-cache-co... */
-	{ 116301 },
+	{ 123777 },
 	/* node-store-reference\000legacy cache\000Local memory write accesses\00=
0legacy-ca... */
-	{ 116205 },
+	{ 123867 },
 	/* node-store-refs\000legacy cache\000Local memory write accesses\000lega=
cy-cache-c... */
-	{ 116114 },
+	{ 123963 },
 	/* node-stores\000legacy cache\000Local memory write accesses\000legacy-c=
ache-confi... */
-	{ 116668 },
+	{ 124054 },
 	/* node-stores-access\000legacy cache\000Local memory write accesses\000l=
egacy-cach... */
-	{ 117035 },
+	{ 124141 },
 	/* node-stores-miss\000legacy cache\000Local memory write misses\000legac=
y-cache-co... */
-	{ 117223 },
+	{ 124235 },
 	/* node-stores-misses\000legacy cache\000Local memory write misses\000leg=
acy-cache-... */
-	{ 117129 },
+	{ 124327 },
 	/* node-stores-ops\000legacy cache\000Local memory write accesses\000lega=
cy-cache-c... */
-	{ 116944 },
+	{ 124421 },
 	/* node-stores-reference\000legacy cache\000Local memory write accesses\0=
00legacy-c... */
-	{ 116847 },
+	{ 124512 },
 	/* node-stores-refs\000legacy cache\000Local memory write accesses\000leg=
acy-cache-... */
-	{ 116755 },
+	{ 124609 },
 	/* node-write\000legacy cache\000Local memory write accesses\000legacy-ca=
che-config... */
-	{ 117315 },
+	{ 124701 },
 	/* node-write-access\000legacy cache\000Local memory write accesses\000le=
gacy-cache... */
-	{ 117678 },
+	{ 124787 },
 	/* node-write-miss\000legacy cache\000Local memory write misses\000legacy=
-cache-con... */
-	{ 117864 },
+	{ 124880 },
 	/* node-write-misses\000legacy cache\000Local memory write misses\000lega=
cy-cache-c... */
-	{ 117771 },
+	{ 124971 },
 	/* node-write-ops\000legacy cache\000Local memory write accesses\000legac=
y-cache-co... */
-	{ 117588 },
+	{ 125064 },
 	/* node-write-reference\000legacy cache\000Local memory write accesses\00=
0legacy-ca... */
-	{ 117492 },
+	{ 125154 },
 	/* node-write-refs\000legacy cache\000Local memory write accesses\000lega=
cy-cache-c... */
-	{ 117401 },
+	{ 125250 },
 	/* ref-cycles\000legacy hardware\000Total cycles; not affected by CPU fre=
quency sca... */
-	{ 123401 },
+	{ 125963 },
 	/* stalled-cycles-backend\000legacy hardware\000Stalled cycles during ret=
irement [T... */
-	{ 123095 },
+	{ 126403 },
 	/* stalled-cycles-frontend\000legacy hardware\000Stalled cycles during is=
sue [This ... */
-	{ 122795 },
+	{ 126556 },
 };
 static const struct compact_pmu_event pmu_events__common_software[] =3D {
 	/* alignment-faults\000software\000Number of kernel handled memory alignm=
ent faults... */
-	{ 124564 },
+	{ 0 },
 	/* bpf-output\000software\000An event used by BPF programs to write to th=
e perf rin... */
-	{ 124863 },
+	{ 2864 },
 	/* cgroup-switches\000software\000Number of context switches to a task in=
 a differe... */
-	{ 124965 },
+	{ 14585 },
 	/* context-switches\000software\000Number of context switches [This event=
 is an ali... */
-	{ 123886 },
+	{ 14688 },
 	/* cpu-clock\000software\000Per-CPU high-resolution timer based event\000=
config=3D0\0... */
-	{ 123522 },
+	{ 14903 },
 	/* cpu-migrations\000software\000Number of times a process has migrated t=
o a new CP... */
-	{ 124088 },
+	{ 15151 },
 	/* cs\000software\000Number of context switches [This event is an alias o=
f context-... */
-	{ 123987 },
+	{ 15283 },
 	/* dummy\000software\000A placeholder event that doesn't count anything\0=
00config=3D9... */
-	{ 124783 },
+	{ 36684 },
 	/* emulation-faults\000software\000Number of kernel handled unimplemented=
 instructi... */
-	{ 124656 },
+	{ 36958 },
 	/* faults\000software\000Number of page faults [This event is an alias of=
 page-faul... */
-	{ 123696 },
+	{ 37197 },
 	/* major-faults\000software\000Number of major page faults. Major faults =
require I/... */
-	{ 124461 },
+	{ 117820 },
 	/* migrations\000software\000Number of times a process has migrated to a =
new CPU [T... */
-	{ 124220 },
+	{ 117923 },
 	/* minor-faults\000software\000Number of minor page faults. Minor faults =
don't requ... */
-	{ 124352 },
+	{ 118055 },
 	/* page-faults\000software\000Number of page faults [This event is an ali=
as of faul... */
-	{ 123791 },
+	{ 125868 },
 	/* task-clock\000software\000Per-task high-resolution timer based event\0=
00config=3D1... */
-	{ 123608 },
+	{ 127253 },
 };
 static const struct compact_pmu_event pmu_events__common_tool[] =3D {
 	/* core_wide\000tool\0001 if not SMT, if SMT are events being gathered on=
 all SMT t... */
-	{ 126206 },
+	{ 14789 },
 	/* duration_time\000tool\000Wall clock interval time in nanoseconds\000co=
nfig=3D1\000... */
-	{ 125073 },
+	{ 36764 },
 	/* has_pmem\000tool\0001 if persistent memory installed otherwise 0\000co=
nfig=3D4\000... */
-	{ 125287 },
+	{ 37292 },
 	/* num_cores\000tool\000Number of cores. A core consists of 1 or more thr=
ead, with ... */
-	{ 125363 },
+	{ 125341 },
 	/* num_cpus\000tool\000Number of logical Linux CPUs. There may be multipl=
e such CPU... */
-	{ 125508 },
+	{ 125486 },
 	/* num_cpus_online\000tool\000Number of online logical Linux CPUs. There =
may be mul... */
-	{ 125611 },
+	{ 125589 },
 	/* num_dies\000tool\000Number of dies. Each die has 1 or more cores\000co=
nfig=3D8\000... */
-	{ 125728 },
+	{ 125706 },
 	/* num_packages\000tool\000Number of packages. Each package has 1 or more=
 die\000co... */
-	{ 125804 },
+	{ 125782 },
 	/* slots\000tool\000Number of functional units that in parallel can execu=
te parts o... */
-	{ 125890 },
+	{ 126177 },
 	/* smt_on\000tool\0001 if simultaneous multithreading (aka hyperthreading=
) is enabl... */
-	{ 126000 },
+	{ 126287 },
 	/* system_time\000tool\000System/kernel time in nanoseconds\000config=3D3=
\000\00000\0... */
-	{ 125219 },
+	{ 127002 },
 	/* system_tsc_freq\000tool\000The amount a Time Stamp Counter (TSC) incre=
ases per s... */
-	{ 126107 },
+	{ 127070 },
 	/* target_cpu\000tool\0001 if CPUs being analyzed, 0 if threads/processes=
\000config... */
-	{ 126320 },
+	{ 127169 },
 	/* user_time\000tool\000User (non-kernel) time in nanoseconds\000config=
=3D2\000\00000... */
-	{ 125149 },
+	{ 127887 },
=20
 };
=20
@@ -5187,55 +5187,55 @@ static const struct pmu_table_entry pmu_events__com=
mon[] =3D {
 	{
 		.entries =3D pmu_events__common_default_core,
 		.num_entries =3D ARRAY_SIZE(pmu_events__common_default_core),
-		.pmu_name =3D { 0 /* default_core\000 */ },
+		.pmu_name =3D { 29669 /* default_core\000 */ },
 	},
 	{
 		.entries =3D pmu_events__common_software,
 		.num_entries =3D ARRAY_SIZE(pmu_events__common_software),
-		.pmu_name =3D { 123513 /* software\000 */ },
+		.pmu_name =3D { 126394 /* software\000 */ },
 	},
 	{
 		.entries =3D pmu_events__common_tool,
 		.num_entries =3D ARRAY_SIZE(pmu_events__common_tool),
-		.pmu_name =3D { 125068 /* tool\000 */ },
+		.pmu_name =3D { 127341 /* tool\000 */ },
 	},
 };
=20
 static const struct compact_pmu_event pmu_metrics__common_default_core[] =
=3D {
 	/* CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=3Dcpu\\-clo=
ck@ if #targ... */
-	{ 127957 },
+	{ 127980 },
 	/* backend_cycles_idle\000Default\000(stalled\\-cycles\\-backend / cpu\\-=
cycles if ... */
-	{ 129584 },
+	{ 128971 },
 	/* branch_frequency\000Default\000branches / (software@cpu\\-clock\\,name=
\\=3Dcpu\\-c... */
-	{ 129934 },
+	{ 129145 },
 	/* branch_miss_rate\000Default\000branch\\-misses / branches\000branch_mi=
ss_rate > ... */
-	{ 130114 },
+	{ 129325 },
 	/* cs_per_second\000Default\000software@context\\-switches\\,name\\=3Dcon=
text\\-switc... */
-	{ 128143 },
+	{ 129501 },
 	/* cycles_frequency\000Default\000cpu\\-cycles / (software@cpu\\-clock\\,=
name\\=3Dcpu... */
-	{ 129758 },
+	{ 129734 },
 	/* dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses / dTLB\\-loads\000d=
tlb_miss_r... */
-	{ 130550 },
+	{ 129975 },
 	/* frontend_cycles_idle\000Default\000(stalled\\-cycles\\-frontend / cpu\=
\-cycles i... */
-	{ 129405 },
+	{ 130081 },
 	/* insn_per_cycle\000Default\000instructions / cpu\\-cycles\000insn_per_c=
ycle < 1\0... */
-	{ 128867 },
+	{ 130328 },
 	/* itlb_miss_rate\000Default3\000iTLB\\-load\\-misses / iTLB\\-loads\000i=
tlb_miss_r... */
-	{ 130656 },
+	{ 130441 },
 	/* l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-prefetch\\-misses /=
 L1\\-dcac... */
-	{ 130762 },
+	{ 130547 },
 	/* l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-misses / L1\\-dcache=
\\-loads\0... */
-	{ 130218 },
+	{ 130695 },
 	/* l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-misses / L1\\-icache=
\\-loads\0... */
-	{ 130435 },
+	{ 130811 },
 	/* llc_miss_rate\000Default2\000LLC\\-load\\-misses / LLC\\-loads\000llc_=
miss_rate ... */
-	{ 130334 },
+	{ 130926 },
 	/* migrations_per_second\000Default\000software@cpu\\-migrations\\,name\\=
=3Dcpu\\-mig... */
-	{ 128376 },
+	{ 131027 },
 	/* page_faults_per_second\000Default\000software@page\\-faults\\,name\\=
=3Dpage\\-faul... */
-	{ 128636 },
+	{ 131287 },
 	/* stalled_cycles_per_instruction\000Default\000(max(stalled\\-cycles\\-f=
rontend, s... */
-	{ 128980 },
+	{ 131518 },
=20
 };
=20
@@ -5243,47 +5243,47 @@ static const struct pmu_table_entry pmu_metrics__co=
mmon[] =3D {
 	{
 		.entries =3D pmu_metrics__common_default_core,
 		.num_entries =3D ARRAY_SIZE(pmu_metrics__common_default_core),
-		.pmu_name =3D { 0 /* default_core\000 */ },
+		.pmu_name =3D { 29669 /* default_core\000 */ },
 	},
 };
=20
 static const struct compact_pmu_event pmu_events__test_soc_cpu_default_cor=
e[] =3D {
 	/* bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=3D0x8a\000\0=
0000\000\000... */
-	{ 126404 },
+	{ 92 },
 	/* bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=3D0x8b\000\0=
0000\000\000... */
-	{ 126466 },
+	{ 154 },
 	/* dispatch_blocked.any\000other\000Memory cluster signals to block micro=
-op dispat... */
-	{ 126728 },
+	{ 29682 },
 	/* eist_trans\000other\000Number of Enhanced Intel SpeedStep(R) Technolog=
y (EIST) t... */
-	{ 126861 },
+	{ 36840 },
 	/* l3_cache_rd\000cache\000L3 cache access, read\000event=3D0x40\000\0000=
0\000\000\00... */
-	{ 126528 },
+	{ 110314 },
 	/* segment_reg_loads.any\000other\000Number of segment register loads\000=
event=3D6,pe... */
-	{ 126626 },
+	{ 126075 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl_d=
drc[] =3D {
 	/* uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands\000event=
=3D2\000\00000... */
-	{ 126994 },
+	{ 127512 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl_l=
3c[] =3D {
 	/* uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\000event=3D7=
\000\00000\0... */
-	{ 127356 },
+	{ 127582 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_cbox=
[] =3D {
 	/* event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\000\00000\000=
\000\000\000... */
-	{ 127230 },
+	{ 37085 },
 	/* event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0xc0\000\00000=
\000\000\000... */
-	{ 127284 },
+	{ 37139 },
 	/* unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-core snoop re=
sulted fro... */
-	{ 127076 },
+	{ 127346 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc[=
] =3D {
 	/* uncore_imc.cache_hits\000uncore\000Total cache hits\000event=3D0x34\00=
0\00000\000\... */
-	{ 127539 },
+	{ 127661 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc_=
free_running[] =3D {
 	/* uncore_imc_free_running.cache_miss\000uncore\000Total cache misses\000=
event=3D0x12... */
-	{ 127448 },
+	{ 127750 },
=20
 };
=20
@@ -5291,66 +5291,66 @@ static const struct pmu_table_entry pmu_events__tes=
t_soc_cpu[] =3D {
 	{
 		.entries =3D pmu_events__test_soc_cpu_default_core,
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_default_core),
-		.pmu_name =3D { 0 /* default_core\000 */ },
+		.pmu_name =3D { 29669 /* default_core\000 */ },
 	},
 	{
 		.entries =3D pmu_events__test_soc_cpu_hisi_sccl_ddrc,
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_ddrc),
-		.pmu_name =3D { 126979 /* hisi_sccl,ddrc\000 */ },
+		.pmu_name =3D { 37368 /* hisi_sccl,ddrc\000 */ },
 	},
 	{
 		.entries =3D pmu_events__test_soc_cpu_hisi_sccl_l3c,
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_l3c),
-		.pmu_name =3D { 127342 /* hisi_sccl,l3c\000 */ },
+		.pmu_name =3D { 37383 /* hisi_sccl,l3c\000 */ },
 	},
 	{
 		.entries =3D pmu_events__test_soc_cpu_uncore_cbox,
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_cbox),
-		.pmu_name =3D { 127064 /* uncore_cbox\000 */ },
+		.pmu_name =3D { 127500 /* uncore_cbox\000 */ },
 	},
 	{
 		.entries =3D pmu_events__test_soc_cpu_uncore_imc,
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc),
-		.pmu_name =3D { 127528 /* uncore_imc\000 */ },
+		.pmu_name =3D { 127650 /* uncore_imc\000 */ },
 	},
 	{
 		.entries =3D pmu_events__test_soc_cpu_uncore_imc_free_running,
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc_free_run=
ning),
-		.pmu_name =3D { 127424 /* uncore_imc_free_running\000 */ },
+		.pmu_name =3D { 127726 /* uncore_imc_free_running\000 */ },
 	},
 };
=20
 static const struct compact_pmu_event pmu_metrics__test_soc_cpu_default_co=
re[] =3D {
 	/* CPI\000\0001 / IPC\000\000\000\000\000\000\000\000000 */
-	{ 130910 },
+	{ 127957 },
 	/* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\000\000\0=
00\000\000... */
-	{ 131599 },
+	{ 128166 },
 	/* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hi=
t + l2_rqs... */
-	{ 131369 },
+	{ 128231 },
 	/* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd - l2_rqsts.d=
emand_data... */
-	{ 131464 },
+	{ 128326 },
 	/* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2_All)\000\0=
00\000\000... */
-	{ 131664 },
+	{ 128461 },
 	/* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_L2_All)\000=
\000\000\0... */
-	{ 131733 },
+	{ 128530 },
 	/* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * (cpu_clk_=
unhalted.t... */
-	{ 130997 },
+	{ 128601 },
 	/* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\000\000\00=
0\000\000\... */
-	{ 130933 },
+	{ 128768 },
 	/* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duration_time\00=
0\000\000\... */
-	{ 131871 },
+	{ 128832 },
 	/* M1\000\000ipc + M2\000\000\000\000\000\000\000\000000 */
-	{ 131804 },
+	{ 128904 },
 	/* M2\000\000ipc + M1\000\000\000\000\000\000\000\000000 */
-	{ 131827 },
+	{ 128927 },
 	/* M3\000\0001 / M3\000\000\000\000\000\000\000\000000 */
-	{ 131850 },
+	{ 128950 },
 	/* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_cycles\00=
0\000\000\... */
-	{ 131297 },
+	{ 129429 },
 	/* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.any\000\000=
\000\000\0... */
-	{ 131164 },
+	{ 129910 },
 	/* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired.any\000\=
000\000\00... */
-	{ 131229 },
+	{ 130260 },
=20
 };
=20
@@ -5358,21 +5358,21 @@ static const struct pmu_table_entry pmu_metrics__te=
st_soc_cpu[] =3D {
 	{
 		.entries =3D pmu_metrics__test_soc_cpu_default_core,
 		.num_entries =3D ARRAY_SIZE(pmu_metrics__test_soc_cpu_default_core),
-		.pmu_name =3D { 0 /* default_core\000 */ },
+		.pmu_name =3D { 29669 /* default_core\000 */ },
 	},
 };
=20
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
ccn_pmu[] =3D {
 	/* sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\000config=
=3D0x2c\0000x0... */
-	{ 127718 },
+	{ 126706 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
cmn_pmu[] =3D {
 	/* sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache misses in f=
irst looku... */
-	{ 127814 },
+	{ 126783 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
ddr_pmu[] =3D {
 	/* sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles event\000event=
=3D0x2b\000v8... */
-	{ 127623 },
+	{ 126926 },
=20
 };
=20
@@ -5380,17 +5380,17 @@ static const struct pmu_table_entry pmu_events__tes=
t_soc_sys[] =3D {
 	{
 		.entries =3D pmu_events__test_soc_sys_uncore_sys_ccn_pmu,
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ccn_pmu)=
,
-		.pmu_name =3D { 127699 /* uncore_sys_ccn_pmu\000 */ },
+		.pmu_name =3D { 127830 /* uncore_sys_ccn_pmu\000 */ },
 	},
 	{
 		.entries =3D pmu_events__test_soc_sys_uncore_sys_cmn_pmu,
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_cmn_pmu)=
,
-		.pmu_name =3D { 127795 /* uncore_sys_cmn_pmu\000 */ },
+		.pmu_name =3D { 127849 /* uncore_sys_cmn_pmu\000 */ },
 	},
 	{
 		.entries =3D pmu_events__test_soc_sys_uncore_sys_ddr_pmu,
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ddr_pmu)=
,
-		.pmu_name =3D { 127604 /* uncore_sys_ddr_pmu\000 */ },
+		.pmu_name =3D { 127868 /* uncore_sys_ddr_pmu\000 */ },
 	},
 };
=20
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jeven=
ts.py
index 0721c8b2551c..fae191272859 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -106,22 +106,16 @@ class BigCString:
   strings: Set[bytes]
   big_string: Sequence[str]
   offsets: Dict[bytes, int]
-  insert_number: int
-  insert_point: Dict[bytes, int]
   metrics: Set[bytes]
=20
   def __init__(self):
     self.strings =3D set()
-    self.insert_number =3D 0
-    self.insert_point =3D {}
     self.metrics =3D set()
=20
   def add(self, b: bytes, is_metric: bool) -> None:
     """Called to add NUL-terminated UTF-8 bytes to the big string."""
     if b not in self.strings:
       self.strings.add(b)
-      self.insert_point[b] =3D self.insert_number
-      self.insert_number +=3D 1
       if is_metric:
         self.metrics.add(b)
=20
@@ -162,8 +156,8 @@ class BigCString:
     self.big_string =3D []
     self.offsets =3D {}
=20
-    def string_cmp_key(b: bytes) -> Tuple[bool, int, bytes]:
-      return (b in self.metrics, self.insert_point[b], b)
+    def string_cmp_key(b: bytes) -> Tuple[bool, bytes]:
+      return (b in self.metrics, b)
=20
     # Emit all strings that aren't folded in a sorted manner.
     for b in sorted(self.strings, key=3Dstring_cmp_key):
--=20
2.56.1.703.gf848ed807c-goog

