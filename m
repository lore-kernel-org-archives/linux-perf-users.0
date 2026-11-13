Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604127;
	b=R6ZHDPV7wydC7QTcjMmczBcgEgsukmUk4hw5jWQidfGUABf2vQbqs2m91GdLMwXSsmRk
	 daZvC1TlnkDpEhJeRkjxiSj1snnR1eJNCVGCHXiwNG88xjG6g3c/Zb+ID+z1twcEOEtZA
	 HNkxMzqaiX/Mc1lVMw5WjKfFf6gfSvx/qdZ12Y/qaDcel5VBm3QRK3+yIbJMoVkXDms8J
	 MkSQkX8snXH/8I6yLSkrLZC42pYXjaoDlZPjsq1KGFe+5E4np5nLDozlPUZpxxOCkV8Gw
	 B9FrcWDfjSUUGWtqFTZVJ+vGN4I5i3Umr/pLm0zpOI5KKzh7ZT1HfomUDhwaCfEIFjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604127;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=/RyOOuSWVxFXknt+64xQN5ytp4thWsWTPVcFP2zK+s4=;
	b=T/CklKdAPhVpv6FoX7RphctQHgxRRp8Fc/Qkb2+142cY8QYLwMF4BEyMZHDtnKOiFbdd
	 PBIOEWvhu+XOPcvPH6/JHuhpe0dryy/e2l4FsnSja5StWPc1C4DRofaJ81gcjGaFAP5yy
	 4aeNF/NdU8ZbGaZ07OigaArtfpedizqEaL+cE6I9cYb/HvIvn/Kn3WroTlxDigWYrhSwg
	 R+PgSRqOlmhAFaLZUvXe4Fv338zu53heA23pShb53cfL/VWOYi3GEXp9bWiiLoVl+PPwX
	 WhqjcXc6zE4aiKhteArjYaWTaKjkwIPK4IztWzYgUu53wfhCXcyi+ivpbDL6cqRmohg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YcSp3Oo+;
	arc=none smtp.remote-ip=209.85.161.69
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE63606A896
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FE63606A896
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YcSp3Oo+
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-716ea5e38e9so1047431eaf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794604122; x=1795208922; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/RyOOuSWVxFXknt+64xQN5ytp4thWsWTPVcFP2zK+s4=;
        b=YcSp3Oo+vmNMOJFIk2AZCzJwO2AS7eSBWDArwugKGS/Z2pUj4OMrWOvbz/9x5ZryGH
         SjrmErJimb1r6kvGj5ZElLBF9R0q9W58pUjv8FUEScraVJHZXH6kyufCQu0jZDfBR5Qk
         Atusg1N1kxJW5l5IFjxQEr5h2BmvqL5UK1CacYkmi03n/G8usOjU5fTf9mIj+6iHGYFB
         vSMGFgSK4eJAAXa2+m/pXKI/pwRQTH3+IyJcMg2HTDwOKm0h8jDkbE8L8zvXrsbmGrkq
         mrozoeg2qI3qXC56pz17ZzYCqzNPdvcVPxeNH7iQIaWjO3I/AEHJzsZt+WAywjdYl8f+
         GaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794604122; x=1795208922;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/RyOOuSWVxFXknt+64xQN5ytp4thWsWTPVcFP2zK+s4=;
        b=YyRjCYnjxSTwOBuKcCkDgOem5XuwXMmRbebUNpV9ZnbVlvcNOUq8oqj1I9gbbTDQCK
         WPd9s8TLuYZGLSioZeg76rscs+1bX7PIRYd0Q83nf/rA/9x/oim2g54fgaHQS1Djb77/
         LhPBF4y4KeQAApNE/+45T3Fka++JSkZL9zhPLCNYfQMRzu12Dj3G3nrOxj5mlqqvvWAD
         xJibZkM98qDhn4H7ryhS0R3QAwF7UdLcndjkUUIsAGur/XzfK2hbLHpg7rJLqKlfDl/8
         d4asL5ID+MioJ4uRMsEASZTvxznmWBuJ6S+C+wEKgu24aKMLshr2n+Tgb5uEfl24ROpT
         GiOg==
X-Forwarded-Encrypted: i=1; AL+hErFvqvviViTkJZTFnCi83Sx77+27F7bS/8fAZMvQCKBAu3ZN6ErIFBe7yEc8cKHHqMLZ8z2IkDbOxaf2RCIDu/76@vger.kernel.org
X-Gm-Message-State: APuU4Z+Yk/NSKGoK/PT5hLiIRi4DdVMUSf3g07JuJ0jPh7zcOurs48GJ
	d/bC5Vp/NNqC6qBIP/NPvaU8+CQPnoMEI4kfxz9W0/EpIH4J/M1JnqtObmGxseInRQgNfnAOOUF
	/0jRhzucyXA==
X-Received: from oobbj7.prod.google.com ([2002:a05:6820:907:b0:708:d9eb:b1ef])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:a742:20b0:6b7:8396:f3da
 with SMTP id 006d021491bc7-71ab510c502mr1538725eaf.60.1794604121896; Fri, 13
 Nov 2026 13:08:41 -0800 (PST)
Date: Fri, 13 Nov 2026 13:08:15 -0800
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
Message-ID: <20261113210822.3112700-4-irogers@google.com>
Subject: [PATCH 03/10] perf jevents: Store PMU names as string literals in
 struct pmu_table_entry
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Every PMU table lookup (perf_pmu__find_events_table(), map_for_pmu(),
pmu_events_table__for_each_event(), pmu_events_table__find_event(),
pmu_events_table__num_events(), pmu_metrics_table__find_metric()) scans
table_pmu->pmu_name across PMU table entries to check wildcard matches.

Across all architectures, there are only 68 unique PMU name strings
(536 bytes total) across ~443 pmu_table_entry rows (which already reside
in .data.rel.ro due to their entries pointer). Replace
struct compact_pmu_event pmu_name in struct pmu_table_entry with a plain
const char *pmu_name string literal so the compiler and linker merge the
PMU name strings in .rodata.str1.1 while hot PMU wildcard scans never
touch big_c_string or trigger block decompression.

Regenerate empty-pmu-events.c accordingly.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 4065 +++++++++++-----------
 tools/perf/pmu-events/jevents.py         |   42 +-
 2 files changed, 2033 insertions(+), 2074 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-even=
ts/empty-pmu-events.c
index c0023687e3dd..6121ef3d2a98 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -13,8 +13,8 @@ struct compact_pmu_event {
=20
 struct pmu_table_entry {
 	const struct compact_pmu_event *entries;
+	const char *pmu_name;
 	uint32_t num_entries;
-	struct compact_pmu_event pmu_name;
 };
=20
 /* clang-format off */
@@ -640,2020 +640,1998 @@ static const char *const big_c_string =3D
 /* offset=3D29578 */
 "data-tlb-write-refs\000legacy cache\000Data TLB write accesses\000legacy-=
cache-config=3D0x103\000\00010\000\000\000\000\000"
 /* offset=3D29669 */
-"default_core\000"
-/* offset=3D29682 */
 "dispatch_blocked.any\000other\000Memory cluster signals to block micro-op=
 dispatch for any reason\000event=3D9,period=3D200000,umask=3D0x20\000\0000=
0\000\000\000\000\000"
-/* offset=3D29815 */
+/* offset=3D29802 */
 "dtlb\000legacy cache\000Data TLB read accesses\000legacy-cache-config=3D3=
\000\00010\000\000\000\000\000"
-/* offset=3D29886 */
+/* offset=3D29873 */
 "dtlb-access\000legacy cache\000Data TLB read accesses\000legacy-cache-con=
fig=3D3\000\00010\000\000\000\000\000"
-/* offset=3D29964 */
+/* offset=3D29951 */
 "dtlb-load\000legacy cache\000Data TLB read accesses\000legacy-cache-confi=
g=3D3\000\00010\000\000\000\000\000"
-/* offset=3D30040 */
+/* offset=3D30027 */
 "dtlb-load-access\000legacy cache\000Data TLB read accesses\000legacy-cach=
e-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D30123 */
+/* offset=3D30110 */
 "dtlb-load-miss\000legacy cache\000Data TLB read misses\000legacy-cache-co=
nfig=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D30208 */
+/* offset=3D30195 */
 "dtlb-load-misses\000legacy cache\000Data TLB read misses\000legacy-cache-=
config=3D0x10003\000\00000\000\000\000\000\000"
-/* offset=3D30295 */
+/* offset=3D30282 */
 "dtlb-load-ops\000legacy cache\000Data TLB read accesses\000legacy-cache-c=
onfig=3D3\000\00010\000\000\000\000\000"
-/* offset=3D30375 */
+/* offset=3D30362 */
 "dtlb-load-reference\000legacy cache\000Data TLB read accesses\000legacy-c=
ache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D30461 */
+/* offset=3D30448 */
 "dtlb-load-refs\000legacy cache\000Data TLB read accesses\000legacy-cache-=
config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D30542 */
+/* offset=3D30529 */
 "dtlb-loads\000legacy cache\000Data TLB read accesses\000legacy-cache-conf=
ig=3D3\000\00000\000\000\000\000\000"
-/* offset=3D30619 */
+/* offset=3D30606 */
 "dtlb-loads-access\000legacy cache\000Data TLB read accesses\000legacy-cac=
he-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D30703 */
+/* offset=3D30690 */
 "dtlb-loads-miss\000legacy cache\000Data TLB read misses\000legacy-cache-c=
onfig=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D30789 */
+/* offset=3D30776 */
 "dtlb-loads-misses\000legacy cache\000Data TLB read misses\000legacy-cache=
-config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D30877 */
+/* offset=3D30864 */
 "dtlb-loads-ops\000legacy cache\000Data TLB read accesses\000legacy-cache-=
config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D30958 */
+/* offset=3D30945 */
 "dtlb-loads-reference\000legacy cache\000Data TLB read accesses\000legacy-=
cache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D31045 */
+/* offset=3D31032 */
 "dtlb-loads-refs\000legacy cache\000Data TLB read accesses\000legacy-cache=
-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D31127 */
+/* offset=3D31114 */
 "dtlb-miss\000legacy cache\000Data TLB read misses\000legacy-cache-config=
=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D31207 */
+/* offset=3D31194 */
 "dtlb-misses\000legacy cache\000Data TLB read misses\000legacy-cache-confi=
g=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D31289 */
+/* offset=3D31276 */
 "dtlb-ops\000legacy cache\000Data TLB read accesses\000legacy-cache-config=
=3D3\000\00010\000\000\000\000\000"
-/* offset=3D31364 */
+/* offset=3D31351 */
 "dtlb-prefetch\000legacy cache\000Data TLB prefetch accesses\000legacy-cac=
he-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D31452 */
+/* offset=3D31439 */
 "dtlb-prefetch-access\000legacy cache\000Data TLB prefetch accesses\000leg=
acy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D31547 */
+/* offset=3D31534 */
 "dtlb-prefetch-miss\000legacy cache\000Data TLB prefetch misses\000legacy-=
cache-config=3D0x10203\000\00010\000\000\000\000\000"
-/* offset=3D31640 */
+/* offset=3D31627 */
 "dtlb-prefetch-misses\000legacy cache\000Data TLB prefetch misses\000legac=
y-cache-config=3D0x10203\000\00000\000\000\000\000\000"
-/* offset=3D31735 */
+/* offset=3D31722 */
 "dtlb-prefetch-ops\000legacy cache\000Data TLB prefetch accesses\000legacy=
-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D31827 */
+/* offset=3D31814 */
 "dtlb-prefetch-reference\000legacy cache\000Data TLB prefetch accesses\000=
legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D31925 */
+/* offset=3D31912 */
 "dtlb-prefetch-refs\000legacy cache\000Data TLB prefetch accesses\000legac=
y-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D32018 */
+/* offset=3D32005 */
 "dtlb-prefetches\000legacy cache\000Data TLB prefetch accesses\000legacy-c=
ache-config=3D0x203\000\00000\000\000\000\000\000"
-/* offset=3D32108 */
+/* offset=3D32095 */
 "dtlb-prefetches-access\000legacy cache\000Data TLB prefetch accesses\000l=
egacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D32205 */
+/* offset=3D32192 */
 "dtlb-prefetches-miss\000legacy cache\000Data TLB prefetch misses\000legac=
y-cache-config=3D0x10203\000\00010\000\000\000\000\000"
-/* offset=3D32300 */
+/* offset=3D32287 */
 "dtlb-prefetches-misses\000legacy cache\000Data TLB prefetch misses\000leg=
acy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
-/* offset=3D32397 */
+/* offset=3D32384 */
 "dtlb-prefetches-ops\000legacy cache\000Data TLB prefetch accesses\000lega=
cy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D32491 */
+/* offset=3D32478 */
 "dtlb-prefetches-reference\000legacy cache\000Data TLB prefetch accesses\0=
00legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D32591 */
+/* offset=3D32578 */
 "dtlb-prefetches-refs\000legacy cache\000Data TLB prefetch accesses\000leg=
acy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D32686 */
+/* offset=3D32673 */
 "dtlb-read\000legacy cache\000Data TLB read accesses\000legacy-cache-confi=
g=3D3\000\00010\000\000\000\000\000"
-/* offset=3D32762 */
+/* offset=3D32749 */
 "dtlb-read-access\000legacy cache\000Data TLB read accesses\000legacy-cach=
e-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D32845 */
+/* offset=3D32832 */
 "dtlb-read-miss\000legacy cache\000Data TLB read misses\000legacy-cache-co=
nfig=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D32930 */
+/* offset=3D32917 */
 "dtlb-read-misses\000legacy cache\000Data TLB read misses\000legacy-cache-=
config=3D0x10003\000\00010\000\000\000\000\000"
-/* offset=3D33017 */
+/* offset=3D33004 */
 "dtlb-read-ops\000legacy cache\000Data TLB read accesses\000legacy-cache-c=
onfig=3D3\000\00010\000\000\000\000\000"
-/* offset=3D33097 */
+/* offset=3D33084 */
 "dtlb-read-reference\000legacy cache\000Data TLB read accesses\000legacy-c=
ache-config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D33183 */
+/* offset=3D33170 */
 "dtlb-read-refs\000legacy cache\000Data TLB read accesses\000legacy-cache-=
config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D33264 */
+/* offset=3D33251 */
 "dtlb-reference\000legacy cache\000Data TLB read accesses\000legacy-cache-=
config=3D3\000\00010\000\000\000\000\000"
-/* offset=3D33345 */
+/* offset=3D33332 */
 "dtlb-refs\000legacy cache\000Data TLB read accesses\000legacy-cache-confi=
g=3D3\000\00010\000\000\000\000\000"
-/* offset=3D33421 */
+/* offset=3D33408 */
 "dtlb-speculative-load\000legacy cache\000Data TLB prefetch accesses\000le=
gacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D33517 */
+/* offset=3D33504 */
 "dtlb-speculative-load-access\000legacy cache\000Data TLB prefetch accesse=
s\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D33620 */
+/* offset=3D33607 */
 "dtlb-speculative-load-miss\000legacy cache\000Data TLB prefetch misses\00=
0legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
-/* offset=3D33721 */
+/* offset=3D33708 */
 "dtlb-speculative-load-misses\000legacy cache\000Data TLB prefetch misses\=
000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
-/* offset=3D33824 */
+/* offset=3D33811 */
 "dtlb-speculative-load-ops\000legacy cache\000Data TLB prefetch accesses\0=
00legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D33924 */
+/* offset=3D33911 */
 "dtlb-speculative-load-reference\000legacy cache\000Data TLB prefetch acce=
sses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D34030 */
+/* offset=3D34017 */
 "dtlb-speculative-load-refs\000legacy cache\000Data TLB prefetch accesses\=
000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D34131 */
+/* offset=3D34118 */
 "dtlb-speculative-read\000legacy cache\000Data TLB prefetch accesses\000le=
gacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D34227 */
+/* offset=3D34214 */
 "dtlb-speculative-read-access\000legacy cache\000Data TLB prefetch accesse=
s\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D34330 */
+/* offset=3D34317 */
 "dtlb-speculative-read-miss\000legacy cache\000Data TLB prefetch misses\00=
0legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
-/* offset=3D34431 */
+/* offset=3D34418 */
 "dtlb-speculative-read-misses\000legacy cache\000Data TLB prefetch misses\=
000legacy-cache-config=3D0x10203\000\00010\000\000\000\000\000"
-/* offset=3D34534 */
+/* offset=3D34521 */
 "dtlb-speculative-read-ops\000legacy cache\000Data TLB prefetch accesses\0=
00legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D34634 */
+/* offset=3D34621 */
 "dtlb-speculative-read-reference\000legacy cache\000Data TLB prefetch acce=
sses\000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D34740 */
+/* offset=3D34727 */
 "dtlb-speculative-read-refs\000legacy cache\000Data TLB prefetch accesses\=
000legacy-cache-config=3D0x203\000\00010\000\000\000\000\000"
-/* offset=3D34841 */
+/* offset=3D34828 */
 "dtlb-store\000legacy cache\000Data TLB write accesses\000legacy-cache-con=
fig=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D34923 */
+/* offset=3D34910 */
 "dtlb-store-access\000legacy cache\000Data TLB write accesses\000legacy-ca=
che-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D35012 */
+/* offset=3D34999 */
 "dtlb-store-miss\000legacy cache\000Data TLB write misses\000legacy-cache-=
config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D35099 */
+/* offset=3D35086 */
 "dtlb-store-misses\000legacy cache\000Data TLB write misses\000legacy-cach=
e-config=3D0x10103\000\00000\000\000\000\000\000"
-/* offset=3D35188 */
+/* offset=3D35175 */
 "dtlb-store-ops\000legacy cache\000Data TLB write accesses\000legacy-cache=
-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D35274 */
+/* offset=3D35261 */
 "dtlb-store-reference\000legacy cache\000Data TLB write accesses\000legacy=
-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D35366 */
+/* offset=3D35353 */
 "dtlb-store-refs\000legacy cache\000Data TLB write accesses\000legacy-cach=
e-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D35453 */
+/* offset=3D35440 */
 "dtlb-stores\000legacy cache\000Data TLB write accesses\000legacy-cache-co=
nfig=3D0x103\000\00000\000\000\000\000\000"
-/* offset=3D35536 */
+/* offset=3D35523 */
 "dtlb-stores-access\000legacy cache\000Data TLB write accesses\000legacy-c=
ache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D35626 */
+/* offset=3D35613 */
 "dtlb-stores-miss\000legacy cache\000Data TLB write misses\000legacy-cache=
-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D35714 */
+/* offset=3D35701 */
 "dtlb-stores-misses\000legacy cache\000Data TLB write misses\000legacy-cac=
he-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D35804 */
+/* offset=3D35791 */
 "dtlb-stores-ops\000legacy cache\000Data TLB write accesses\000legacy-cach=
e-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D35891 */
+/* offset=3D35878 */
 "dtlb-stores-reference\000legacy cache\000Data TLB write accesses\000legac=
y-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D35984 */
+/* offset=3D35971 */
 "dtlb-stores-refs\000legacy cache\000Data TLB write accesses\000legacy-cac=
he-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D36072 */
+/* offset=3D36059 */
 "dtlb-write\000legacy cache\000Data TLB write accesses\000legacy-cache-con=
fig=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D36154 */
+/* offset=3D36141 */
 "dtlb-write-access\000legacy cache\000Data TLB write accesses\000legacy-ca=
che-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D36243 */
+/* offset=3D36230 */
 "dtlb-write-miss\000legacy cache\000Data TLB write misses\000legacy-cache-=
config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D36330 */
+/* offset=3D36317 */
 "dtlb-write-misses\000legacy cache\000Data TLB write misses\000legacy-cach=
e-config=3D0x10103\000\00010\000\000\000\000\000"
-/* offset=3D36419 */
+/* offset=3D36406 */
 "dtlb-write-ops\000legacy cache\000Data TLB write accesses\000legacy-cache=
-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D36505 */
+/* offset=3D36492 */
 "dtlb-write-reference\000legacy cache\000Data TLB write accesses\000legacy=
-cache-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D36597 */
+/* offset=3D36584 */
 "dtlb-write-refs\000legacy cache\000Data TLB write accesses\000legacy-cach=
e-config=3D0x103\000\00010\000\000\000\000\000"
-/* offset=3D36684 */
+/* offset=3D36671 */
 "dummy\000software\000A placeholder event that doesn't count anything\000c=
onfig=3D9\000\00000\000\000\000\000\000"
-/* offset=3D36764 */
+/* offset=3D36751 */
 "duration_time\000tool\000Wall clock interval time in nanoseconds\000confi=
g=3D1\000\00000\000\000\000\000\000"
-/* offset=3D36840 */
+/* offset=3D36827 */
 "eist_trans\000other\000Number of Enhanced Intel SpeedStep(R) Technology (=
EIST) transitions\000event=3D0x3a,period=3D200000\000\00000\000\000\000\000=
\000"
-/* offset=3D36958 */
+/* offset=3D36945 */
 "emulation-faults\000software\000Number of kernel handled unimplemented in=
struction faults handled through emulation\000config=3D8\000\00000\000\000\=
000\000\000"
-/* offset=3D37085 */
+/* offset=3D37072 */
 "event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\000\00000\000\00=
0\000\000\000"
-/* offset=3D37139 */
+/* offset=3D37126 */
 "event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0xc0\000\00000\00=
0\000\000\000\000"
-/* offset=3D37197 */
+/* offset=3D37184 */
 "faults\000software\000Number of page faults [This event is an alias of pa=
ge-faults]\000config=3D2\000\00000\000\000\000\000\000"
-/* offset=3D37292 */
+/* offset=3D37279 */
 "has_pmem\000tool\0001 if persistent memory installed otherwise 0\000confi=
g=3D4\000\00000\000\000\000\000\000"
-/* offset=3D37368 */
-"hisi_sccl,ddrc\000"
-/* offset=3D37383 */
-"hisi_sccl,l3c\000"
-/* offset=3D37397 */
+/* offset=3D37355 */
 "i-tlb\000legacy cache\000Instruction TLB read accesses\000legacy-cache-co=
nfig=3D4\000\00010\000\000\000\000\000"
-/* offset=3D37476 */
+/* offset=3D37434 */
 "i-tlb-access\000legacy cache\000Instruction TLB read accesses\000legacy-c=
ache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D37562 */
+/* offset=3D37520 */
 "i-tlb-load\000legacy cache\000Instruction TLB read accesses\000legacy-cac=
he-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D37646 */
+/* offset=3D37604 */
 "i-tlb-load-access\000legacy cache\000Instruction TLB read accesses\000leg=
acy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D37737 */
+/* offset=3D37695 */
 "i-tlb-load-miss\000legacy cache\000Instruction TLB read misses\000legacy-=
cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D37830 */
+/* offset=3D37788 */
 "i-tlb-load-misses\000legacy cache\000Instruction TLB read misses\000legac=
y-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D37925 */
+/* offset=3D37883 */
 "i-tlb-load-ops\000legacy cache\000Instruction TLB read accesses\000legacy=
-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D38013 */
+/* offset=3D37971 */
 "i-tlb-load-reference\000legacy cache\000Instruction TLB read accesses\000=
legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D38107 */
+/* offset=3D38065 */
 "i-tlb-load-refs\000legacy cache\000Instruction TLB read accesses\000legac=
y-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D38196 */
+/* offset=3D38154 */
 "i-tlb-loads\000legacy cache\000Instruction TLB read accesses\000legacy-ca=
che-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D38281 */
+/* offset=3D38239 */
 "i-tlb-loads-access\000legacy cache\000Instruction TLB read accesses\000le=
gacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D38373 */
+/* offset=3D38331 */
 "i-tlb-loads-miss\000legacy cache\000Instruction TLB read misses\000legacy=
-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D38467 */
+/* offset=3D38425 */
 "i-tlb-loads-misses\000legacy cache\000Instruction TLB read misses\000lega=
cy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D38563 */
+/* offset=3D38521 */
 "i-tlb-loads-ops\000legacy cache\000Instruction TLB read accesses\000legac=
y-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D38652 */
+/* offset=3D38610 */
 "i-tlb-loads-reference\000legacy cache\000Instruction TLB read accesses\00=
0legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D38747 */
+/* offset=3D38705 */
 "i-tlb-loads-refs\000legacy cache\000Instruction TLB read accesses\000lega=
cy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D38837 */
+/* offset=3D38795 */
 "i-tlb-miss\000legacy cache\000Instruction TLB read misses\000legacy-cache=
-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D38925 */
+/* offset=3D38883 */
 "i-tlb-misses\000legacy cache\000Instruction TLB read misses\000legacy-cac=
he-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D39015 */
+/* offset=3D38973 */
 "i-tlb-ops\000legacy cache\000Instruction TLB read accesses\000legacy-cach=
e-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D39098 */
+/* offset=3D39056 */
 "i-tlb-read\000legacy cache\000Instruction TLB read accesses\000legacy-cac=
he-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D39182 */
+/* offset=3D39140 */
 "i-tlb-read-access\000legacy cache\000Instruction TLB read accesses\000leg=
acy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D39273 */
+/* offset=3D39231 */
 "i-tlb-read-miss\000legacy cache\000Instruction TLB read misses\000legacy-=
cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D39366 */
+/* offset=3D39324 */
 "i-tlb-read-misses\000legacy cache\000Instruction TLB read misses\000legac=
y-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D39461 */
+/* offset=3D39419 */
 "i-tlb-read-ops\000legacy cache\000Instruction TLB read accesses\000legacy=
-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D39549 */
+/* offset=3D39507 */
 "i-tlb-read-reference\000legacy cache\000Instruction TLB read accesses\000=
legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D39643 */
+/* offset=3D39601 */
 "i-tlb-read-refs\000legacy cache\000Instruction TLB read accesses\000legac=
y-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D39732 */
+/* offset=3D39690 */
 "i-tlb-reference\000legacy cache\000Instruction TLB read accesses\000legac=
y-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D39821 */
+/* offset=3D39779 */
 "i-tlb-refs\000legacy cache\000Instruction TLB read accesses\000legacy-cac=
he-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D39905 */
+/* offset=3D39863 */
 "idle-cycles-backend\000legacy hardware\000Stalled cycles during retiremen=
t [This event is an alias of stalled-cycles-backend]\000legacy-hardware-con=
fig=3D8\000\00000\000\000\000\000\000"
-/* offset=3D40058 */
+/* offset=3D40016 */
 "idle-cycles-frontend\000legacy hardware\000Stalled cycles during issue [T=
his event is an alias of stalled-cycles-frontend]\000legacy-hardware-config=
=3D7\000\00000\000\000\000\000\000"
-/* offset=3D40208 */
+/* offset=3D40166 */
 "instruction-tlb\000legacy cache\000Instruction TLB read accesses\000legac=
y-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D40297 */
+/* offset=3D40255 */
 "instruction-tlb-access\000legacy cache\000Instruction TLB read accesses\0=
00legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D40393 */
+/* offset=3D40351 */
 "instruction-tlb-load\000legacy cache\000Instruction TLB read accesses\000=
legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D40487 */
+/* offset=3D40445 */
 "instruction-tlb-load-access\000legacy cache\000Instruction TLB read acces=
ses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D40588 */
+/* offset=3D40546 */
 "instruction-tlb-load-miss\000legacy cache\000Instruction TLB read misses\=
000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D40691 */
+/* offset=3D40649 */
 "instruction-tlb-load-misses\000legacy cache\000Instruction TLB read misse=
s\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D40796 */
+/* offset=3D40754 */
 "instruction-tlb-load-ops\000legacy cache\000Instruction TLB read accesses=
\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D40894 */
+/* offset=3D40852 */
 "instruction-tlb-load-reference\000legacy cache\000Instruction TLB read ac=
cesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D40998 */
+/* offset=3D40956 */
 "instruction-tlb-load-refs\000legacy cache\000Instruction TLB read accesse=
s\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D41097 */
+/* offset=3D41055 */
 "instruction-tlb-loads\000legacy cache\000Instruction TLB read accesses\00=
0legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D41192 */
+/* offset=3D41150 */
 "instruction-tlb-loads-access\000legacy cache\000Instruction TLB read acce=
sses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D41294 */
+/* offset=3D41252 */
 "instruction-tlb-loads-miss\000legacy cache\000Instruction TLB read misses=
\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D41398 */
+/* offset=3D41356 */
 "instruction-tlb-loads-misses\000legacy cache\000Instruction TLB read miss=
es\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D41504 */
+/* offset=3D41462 */
 "instruction-tlb-loads-ops\000legacy cache\000Instruction TLB read accesse=
s\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D41603 */
+/* offset=3D41561 */
 "instruction-tlb-loads-reference\000legacy cache\000Instruction TLB read a=
ccesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D41708 */
+/* offset=3D41666 */
 "instruction-tlb-loads-refs\000legacy cache\000Instruction TLB read access=
es\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D41808 */
+/* offset=3D41766 */
 "instruction-tlb-miss\000legacy cache\000Instruction TLB read misses\000le=
gacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D41906 */
+/* offset=3D41864 */
 "instruction-tlb-misses\000legacy cache\000Instruction TLB read misses\000=
legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D42006 */
+/* offset=3D41964 */
 "instruction-tlb-ops\000legacy cache\000Instruction TLB read accesses\000l=
egacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D42099 */
+/* offset=3D42057 */
 "instruction-tlb-read\000legacy cache\000Instruction TLB read accesses\000=
legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D42193 */
+/* offset=3D42151 */
 "instruction-tlb-read-access\000legacy cache\000Instruction TLB read acces=
ses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D42294 */
+/* offset=3D42252 */
 "instruction-tlb-read-miss\000legacy cache\000Instruction TLB read misses\=
000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D42397 */
+/* offset=3D42355 */
 "instruction-tlb-read-misses\000legacy cache\000Instruction TLB read misse=
s\000legacy-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D42502 */
+/* offset=3D42460 */
 "instruction-tlb-read-ops\000legacy cache\000Instruction TLB read accesses=
\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D42600 */
+/* offset=3D42558 */
 "instruction-tlb-read-reference\000legacy cache\000Instruction TLB read ac=
cesses\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D42704 */
+/* offset=3D42662 */
 "instruction-tlb-read-refs\000legacy cache\000Instruction TLB read accesse=
s\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D42803 */
+/* offset=3D42761 */
 "instruction-tlb-reference\000legacy cache\000Instruction TLB read accesse=
s\000legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D42902 */
+/* offset=3D42860 */
 "instruction-tlb-refs\000legacy cache\000Instruction TLB read accesses\000=
legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D42996 */
+/* offset=3D42954 */
 "instructions\000legacy hardware\000Retired instructions. Be careful, thes=
e can be affected by various issues, most notably hardware interrupt counts=
\000legacy-hardware-config=3D1\000\00000\000\000\000\000\000"
-/* offset=3D43172 */
+/* offset=3D43130 */
 "itlb\000legacy cache\000Instruction TLB read accesses\000legacy-cache-con=
fig=3D4\000\00010\000\000\000\000\000"
-/* offset=3D43250 */
+/* offset=3D43208 */
 "itlb-access\000legacy cache\000Instruction TLB read accesses\000legacy-ca=
che-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D43335 */
+/* offset=3D43293 */
 "itlb-load\000legacy cache\000Instruction TLB read accesses\000legacy-cach=
e-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D43418 */
+/* offset=3D43376 */
 "itlb-load-access\000legacy cache\000Instruction TLB read accesses\000lega=
cy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D43508 */
+/* offset=3D43466 */
 "itlb-load-miss\000legacy cache\000Instruction TLB read misses\000legacy-c=
ache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D43600 */
+/* offset=3D43558 */
 "itlb-load-misses\000legacy cache\000Instruction TLB read misses\000legacy=
-cache-config=3D0x10004\000\00000\000\000\000\000\000"
-/* offset=3D43694 */
+/* offset=3D43652 */
 "itlb-load-ops\000legacy cache\000Instruction TLB read accesses\000legacy-=
cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D43781 */
+/* offset=3D43739 */
 "itlb-load-reference\000legacy cache\000Instruction TLB read accesses\000l=
egacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D43874 */
+/* offset=3D43832 */
 "itlb-load-refs\000legacy cache\000Instruction TLB read accesses\000legacy=
-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D43962 */
+/* offset=3D43920 */
 "itlb-loads\000legacy cache\000Instruction TLB read accesses\000legacy-cac=
he-config=3D4\000\00000\000\000\000\000\000"
-/* offset=3D44046 */
+/* offset=3D44004 */
 "itlb-loads-access\000legacy cache\000Instruction TLB read accesses\000leg=
acy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D44137 */
+/* offset=3D44095 */
 "itlb-loads-miss\000legacy cache\000Instruction TLB read misses\000legacy-=
cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D44230 */
+/* offset=3D44188 */
 "itlb-loads-misses\000legacy cache\000Instruction TLB read misses\000legac=
y-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D44325 */
+/* offset=3D44283 */
 "itlb-loads-ops\000legacy cache\000Instruction TLB read accesses\000legacy=
-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D44413 */
+/* offset=3D44371 */
 "itlb-loads-reference\000legacy cache\000Instruction TLB read accesses\000=
legacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D44507 */
+/* offset=3D44465 */
 "itlb-loads-refs\000legacy cache\000Instruction TLB read accesses\000legac=
y-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D44596 */
+/* offset=3D44554 */
 "itlb-miss\000legacy cache\000Instruction TLB read misses\000legacy-cache-=
config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D44683 */
+/* offset=3D44641 */
 "itlb-misses\000legacy cache\000Instruction TLB read misses\000legacy-cach=
e-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D44772 */
+/* offset=3D44730 */
 "itlb-ops\000legacy cache\000Instruction TLB read accesses\000legacy-cache=
-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D44854 */
+/* offset=3D44812 */
 "itlb-read\000legacy cache\000Instruction TLB read accesses\000legacy-cach=
e-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D44937 */
+/* offset=3D44895 */
 "itlb-read-access\000legacy cache\000Instruction TLB read accesses\000lega=
cy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D45027 */
+/* offset=3D44985 */
 "itlb-read-miss\000legacy cache\000Instruction TLB read misses\000legacy-c=
ache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D45119 */
+/* offset=3D45077 */
 "itlb-read-misses\000legacy cache\000Instruction TLB read misses\000legacy=
-cache-config=3D0x10004\000\00010\000\000\000\000\000"
-/* offset=3D45213 */
+/* offset=3D45171 */
 "itlb-read-ops\000legacy cache\000Instruction TLB read accesses\000legacy-=
cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D45300 */
+/* offset=3D45258 */
 "itlb-read-reference\000legacy cache\000Instruction TLB read accesses\000l=
egacy-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D45393 */
+/* offset=3D45351 */
 "itlb-read-refs\000legacy cache\000Instruction TLB read accesses\000legacy=
-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D45481 */
+/* offset=3D45439 */
 "itlb-reference\000legacy cache\000Instruction TLB read accesses\000legacy=
-cache-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D45569 */
+/* offset=3D45527 */
 "itlb-refs\000legacy cache\000Instruction TLB read accesses\000legacy-cach=
e-config=3D4\000\00010\000\000\000\000\000"
-/* offset=3D45652 */
+/* offset=3D45610 */
 "l1-d\000legacy cache\000Level 1 data cache read accesses\000legacy-cache-=
config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D45733 */
+/* offset=3D45691 */
 "l1-d-access\000legacy cache\000Level 1 data cache read accesses\000legacy=
-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D45821 */
+/* offset=3D45779 */
 "l1-d-load\000legacy cache\000Level 1 data cache read accesses\000legacy-c=
ache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D45907 */
+/* offset=3D45865 */
 "l1-d-load-access\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D46000 */
+/* offset=3D45958 */
 "l1-d-load-miss\000legacy cache\000Level 1 data cache read misses\000legac=
y-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D46095 */
+/* offset=3D46053 */
 "l1-d-load-misses\000legacy cache\000Level 1 data cache read misses\000leg=
acy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D46192 */
+/* offset=3D46150 */
 "l1-d-load-ops\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D46282 */
+/* offset=3D46240 */
 "l1-d-load-reference\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D46378 */
+/* offset=3D46336 */
 "l1-d-load-refs\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D46469 */
+/* offset=3D46427 */
 "l1-d-loads\000legacy cache\000Level 1 data cache read accesses\000legacy-=
cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D46556 */
+/* offset=3D46514 */
 "l1-d-loads-access\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D46650 */
+/* offset=3D46608 */
 "l1-d-loads-miss\000legacy cache\000Level 1 data cache read misses\000lega=
cy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D46746 */
+/* offset=3D46704 */
 "l1-d-loads-misses\000legacy cache\000Level 1 data cache read misses\000le=
gacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D46844 */
+/* offset=3D46802 */
 "l1-d-loads-ops\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D46935 */
+/* offset=3D46893 */
 "l1-d-loads-reference\000legacy cache\000Level 1 data cache read accesses\=
000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D47032 */
+/* offset=3D46990 */
 "l1-d-loads-refs\000legacy cache\000Level 1 data cache read accesses\000le=
gacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D47124 */
+/* offset=3D47082 */
 "l1-d-miss\000legacy cache\000Level 1 data cache read misses\000legacy-cac=
he-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D47214 */
+/* offset=3D47172 */
 "l1-d-misses\000legacy cache\000Level 1 data cache read misses\000legacy-c=
ache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D47306 */
+/* offset=3D47264 */
 "l1-d-ops\000legacy cache\000Level 1 data cache read accesses\000legacy-ca=
che-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D47391 */
+/* offset=3D47349 */
 "l1-d-prefetch\000legacy cache\000Level 1 data cache prefetch accesses\000=
legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D47489 */
+/* offset=3D47447 */
 "l1-d-prefetch-access\000legacy cache\000Level 1 data cache prefetch acces=
ses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D47594 */
+/* offset=3D47552 */
 "l1-d-prefetch-miss\000legacy cache\000Level 1 data cache prefetch misses\=
000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D47697 */
+/* offset=3D47655 */
 "l1-d-prefetch-misses\000legacy cache\000Level 1 data cache prefetch misse=
s\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D47802 */
+/* offset=3D47760 */
 "l1-d-prefetch-ops\000legacy cache\000Level 1 data cache prefetch accesses=
\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D47904 */
+/* offset=3D47862 */
 "l1-d-prefetch-reference\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D48012 */
+/* offset=3D47970 */
 "l1-d-prefetch-refs\000legacy cache\000Level 1 data cache prefetch accesse=
s\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D48115 */
+/* offset=3D48073 */
 "l1-d-prefetches\000legacy cache\000Level 1 data cache prefetch accesses\0=
00legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D48215 */
+/* offset=3D48173 */
 "l1-d-prefetches-access\000legacy cache\000Level 1 data cache prefetch acc=
esses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D48322 */
+/* offset=3D48280 */
 "l1-d-prefetches-miss\000legacy cache\000Level 1 data cache prefetch misse=
s\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D48427 */
+/* offset=3D48385 */
 "l1-d-prefetches-misses\000legacy cache\000Level 1 data cache prefetch mis=
ses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D48534 */
+/* offset=3D48492 */
 "l1-d-prefetches-ops\000legacy cache\000Level 1 data cache prefetch access=
es\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D48638 */
+/* offset=3D48596 */
 "l1-d-prefetches-reference\000legacy cache\000Level 1 data cache prefetch =
accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D48748 */
+/* offset=3D48706 */
 "l1-d-prefetches-refs\000legacy cache\000Level 1 data cache prefetch acces=
ses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D48853 */
+/* offset=3D48811 */
 "l1-d-read\000legacy cache\000Level 1 data cache read accesses\000legacy-c=
ache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D48939 */
+/* offset=3D48897 */
 "l1-d-read-access\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D49032 */
+/* offset=3D48990 */
 "l1-d-read-miss\000legacy cache\000Level 1 data cache read misses\000legac=
y-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D49127 */
+/* offset=3D49085 */
 "l1-d-read-misses\000legacy cache\000Level 1 data cache read misses\000leg=
acy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D49224 */
+/* offset=3D49182 */
 "l1-d-read-ops\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D49314 */
+/* offset=3D49272 */
 "l1-d-read-reference\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D49410 */
+/* offset=3D49368 */
 "l1-d-read-refs\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D49501 */
+/* offset=3D49459 */
 "l1-d-reference\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D49592 */
+/* offset=3D49550 */
 "l1-d-refs\000legacy cache\000Level 1 data cache read accesses\000legacy-c=
ache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D49678 */
+/* offset=3D49636 */
 "l1-d-speculative-load\000legacy cache\000Level 1 data cache prefetch acce=
sses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D49784 */
+/* offset=3D49742 */
 "l1-d-speculative-load-access\000legacy cache\000Level 1 data cache prefet=
ch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D49897 */
+/* offset=3D49855 */
 "l1-d-speculative-load-miss\000legacy cache\000Level 1 data cache prefetch=
 misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D50008 */
+/* offset=3D49966 */
 "l1-d-speculative-load-misses\000legacy cache\000Level 1 data cache prefet=
ch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D50121 */
+/* offset=3D50079 */
 "l1-d-speculative-load-ops\000legacy cache\000Level 1 data cache prefetch =
accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D50231 */
+/* offset=3D50189 */
 "l1-d-speculative-load-reference\000legacy cache\000Level 1 data cache pre=
fetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000=
"
-/* offset=3D50347 */
+/* offset=3D50305 */
 "l1-d-speculative-load-refs\000legacy cache\000Level 1 data cache prefetch=
 accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D50458 */
+/* offset=3D50416 */
 "l1-d-speculative-read\000legacy cache\000Level 1 data cache prefetch acce=
sses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D50564 */
+/* offset=3D50522 */
 "l1-d-speculative-read-access\000legacy cache\000Level 1 data cache prefet=
ch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D50677 */
+/* offset=3D50635 */
 "l1-d-speculative-read-miss\000legacy cache\000Level 1 data cache prefetch=
 misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D50788 */
+/* offset=3D50746 */
 "l1-d-speculative-read-misses\000legacy cache\000Level 1 data cache prefet=
ch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D50901 */
+/* offset=3D50859 */
 "l1-d-speculative-read-ops\000legacy cache\000Level 1 data cache prefetch =
accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D51011 */
+/* offset=3D50969 */
 "l1-d-speculative-read-reference\000legacy cache\000Level 1 data cache pre=
fetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000=
"
-/* offset=3D51127 */
+/* offset=3D51085 */
 "l1-d-speculative-read-refs\000legacy cache\000Level 1 data cache prefetch=
 accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D51238 */
+/* offset=3D51196 */
 "l1-d-store\000legacy cache\000Level 1 data cache write accesses\000legacy=
-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D51330 */
+/* offset=3D51288 */
 "l1-d-store-access\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D51429 */
+/* offset=3D51387 */
 "l1-d-store-miss\000legacy cache\000Level 1 data cache write misses\000leg=
acy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D51526 */
+/* offset=3D51484 */
 "l1-d-store-misses\000legacy cache\000Level 1 data cache write misses\000l=
egacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D51625 */
+/* offset=3D51583 */
 "l1-d-store-ops\000legacy cache\000Level 1 data cache write accesses\000le=
gacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D51721 */
+/* offset=3D51679 */
 "l1-d-store-reference\000legacy cache\000Level 1 data cache write accesses=
\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D51823 */
+/* offset=3D51781 */
 "l1-d-store-refs\000legacy cache\000Level 1 data cache write accesses\000l=
egacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D51920 */
+/* offset=3D51878 */
 "l1-d-stores\000legacy cache\000Level 1 data cache write accesses\000legac=
y-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D52013 */
+/* offset=3D51971 */
 "l1-d-stores-access\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D52113 */
+/* offset=3D52071 */
 "l1-d-stores-miss\000legacy cache\000Level 1 data cache write misses\000le=
gacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D52211 */
+/* offset=3D52169 */
 "l1-d-stores-misses\000legacy cache\000Level 1 data cache write misses\000=
legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D52311 */
+/* offset=3D52269 */
 "l1-d-stores-ops\000legacy cache\000Level 1 data cache write accesses\000l=
egacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D52408 */
+/* offset=3D52366 */
 "l1-d-stores-reference\000legacy cache\000Level 1 data cache write accesse=
s\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D52511 */
+/* offset=3D52469 */
 "l1-d-stores-refs\000legacy cache\000Level 1 data cache write accesses\000=
legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D52609 */
+/* offset=3D52567 */
 "l1-d-write\000legacy cache\000Level 1 data cache write accesses\000legacy=
-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D52701 */
+/* offset=3D52659 */
 "l1-d-write-access\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D52800 */
+/* offset=3D52758 */
 "l1-d-write-miss\000legacy cache\000Level 1 data cache write misses\000leg=
acy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D52897 */
+/* offset=3D52855 */
 "l1-d-write-misses\000legacy cache\000Level 1 data cache write misses\000l=
egacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D52996 */
+/* offset=3D52954 */
 "l1-d-write-ops\000legacy cache\000Level 1 data cache write accesses\000le=
gacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D53092 */
+/* offset=3D53050 */
 "l1-d-write-reference\000legacy cache\000Level 1 data cache write accesses=
\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D53194 */
+/* offset=3D53152 */
 "l1-d-write-refs\000legacy cache\000Level 1 data cache write accesses\000l=
egacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D53291 */
+/* offset=3D53249 */
 "l1-data\000legacy cache\000Level 1 data cache read accesses\000legacy-cac=
he-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D53375 */
+/* offset=3D53333 */
 "l1-data-access\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D53466 */
+/* offset=3D53424 */
 "l1-data-load\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D53555 */
+/* offset=3D53513 */
 "l1-data-load-access\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D53651 */
+/* offset=3D53609 */
 "l1-data-load-miss\000legacy cache\000Level 1 data cache read misses\000le=
gacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D53749 */
+/* offset=3D53707 */
 "l1-data-load-misses\000legacy cache\000Level 1 data cache read misses\000=
legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D53849 */
+/* offset=3D53807 */
 "l1-data-load-ops\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D53942 */
+/* offset=3D53900 */
 "l1-data-load-reference\000legacy cache\000Level 1 data cache read accesse=
s\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D54041 */
+/* offset=3D53999 */
 "l1-data-load-refs\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D54135 */
+/* offset=3D54093 */
 "l1-data-loads\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D54225 */
+/* offset=3D54183 */
 "l1-data-loads-access\000legacy cache\000Level 1 data cache read accesses\=
000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D54322 */
+/* offset=3D54280 */
 "l1-data-loads-miss\000legacy cache\000Level 1 data cache read misses\000l=
egacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D54421 */
+/* offset=3D54379 */
 "l1-data-loads-misses\000legacy cache\000Level 1 data cache read misses\00=
0legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D54522 */
+/* offset=3D54480 */
 "l1-data-loads-ops\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D54616 */
+/* offset=3D54574 */
 "l1-data-loads-reference\000legacy cache\000Level 1 data cache read access=
es\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D54716 */
+/* offset=3D54674 */
 "l1-data-loads-refs\000legacy cache\000Level 1 data cache read accesses\00=
0legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D54811 */
+/* offset=3D54769 */
 "l1-data-miss\000legacy cache\000Level 1 data cache read misses\000legacy-=
cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D54904 */
+/* offset=3D54862 */
 "l1-data-misses\000legacy cache\000Level 1 data cache read misses\000legac=
y-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D54999 */
+/* offset=3D54957 */
 "l1-data-ops\000legacy cache\000Level 1 data cache read accesses\000legacy=
-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D55087 */
+/* offset=3D55045 */
 "l1-data-prefetch\000legacy cache\000Level 1 data cache prefetch accesses\=
000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D55188 */
+/* offset=3D55146 */
 "l1-data-prefetch-access\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D55296 */
+/* offset=3D55254 */
 "l1-data-prefetch-miss\000legacy cache\000Level 1 data cache prefetch miss=
es\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D55402 */
+/* offset=3D55360 */
 "l1-data-prefetch-misses\000legacy cache\000Level 1 data cache prefetch mi=
sses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D55510 */
+/* offset=3D55468 */
 "l1-data-prefetch-ops\000legacy cache\000Level 1 data cache prefetch acces=
ses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D55615 */
+/* offset=3D55573 */
 "l1-data-prefetch-reference\000legacy cache\000Level 1 data cache prefetch=
 accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D55726 */
+/* offset=3D55684 */
 "l1-data-prefetch-refs\000legacy cache\000Level 1 data cache prefetch acce=
sses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D55832 */
+/* offset=3D55790 */
 "l1-data-prefetches\000legacy cache\000Level 1 data cache prefetch accesse=
s\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D55935 */
+/* offset=3D55893 */
 "l1-data-prefetches-access\000legacy cache\000Level 1 data cache prefetch =
accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D56045 */
+/* offset=3D56003 */
 "l1-data-prefetches-miss\000legacy cache\000Level 1 data cache prefetch mi=
sses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D56153 */
+/* offset=3D56111 */
 "l1-data-prefetches-misses\000legacy cache\000Level 1 data cache prefetch =
misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D56263 */
+/* offset=3D56221 */
 "l1-data-prefetches-ops\000legacy cache\000Level 1 data cache prefetch acc=
esses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D56370 */
+/* offset=3D56328 */
 "l1-data-prefetches-reference\000legacy cache\000Level 1 data cache prefet=
ch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D56483 */
+/* offset=3D56441 */
 "l1-data-prefetches-refs\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D56591 */
+/* offset=3D56549 */
 "l1-data-read\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D56680 */
+/* offset=3D56638 */
 "l1-data-read-access\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D56776 */
+/* offset=3D56734 */
 "l1-data-read-miss\000legacy cache\000Level 1 data cache read misses\000le=
gacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D56874 */
+/* offset=3D56832 */
 "l1-data-read-misses\000legacy cache\000Level 1 data cache read misses\000=
legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D56974 */
+/* offset=3D56932 */
 "l1-data-read-ops\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D57067 */
+/* offset=3D57025 */
 "l1-data-read-reference\000legacy cache\000Level 1 data cache read accesse=
s\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D57166 */
+/* offset=3D57124 */
 "l1-data-read-refs\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D57260 */
+/* offset=3D57218 */
 "l1-data-reference\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D57354 */
+/* offset=3D57312 */
 "l1-data-refs\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D57443 */
+/* offset=3D57401 */
 "l1-data-speculative-load\000legacy cache\000Level 1 data cache prefetch a=
ccesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D57552 */
+/* offset=3D57510 */
 "l1-data-speculative-load-access\000legacy cache\000Level 1 data cache pre=
fetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000=
"
-/* offset=3D57668 */
+/* offset=3D57626 */
 "l1-data-speculative-load-miss\000legacy cache\000Level 1 data cache prefe=
tch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D57782 */
+/* offset=3D57740 */
 "l1-data-speculative-load-misses\000legacy cache\000Level 1 data cache pre=
fetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000=
"
-/* offset=3D57898 */
+/* offset=3D57856 */
 "l1-data-speculative-load-ops\000legacy cache\000Level 1 data cache prefet=
ch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D58011 */
+/* offset=3D57969 */
 "l1-data-speculative-load-reference\000legacy cache\000Level 1 data cache =
prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\=
000"
-/* offset=3D58130 */
+/* offset=3D58088 */
 "l1-data-speculative-load-refs\000legacy cache\000Level 1 data cache prefe=
tch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D58244 */
+/* offset=3D58202 */
 "l1-data-speculative-read\000legacy cache\000Level 1 data cache prefetch a=
ccesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D58353 */
+/* offset=3D58311 */
 "l1-data-speculative-read-access\000legacy cache\000Level 1 data cache pre=
fetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000=
"
-/* offset=3D58469 */
+/* offset=3D58427 */
 "l1-data-speculative-read-miss\000legacy cache\000Level 1 data cache prefe=
tch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D58583 */
+/* offset=3D58541 */
 "l1-data-speculative-read-misses\000legacy cache\000Level 1 data cache pre=
fetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000=
"
-/* offset=3D58699 */
+/* offset=3D58657 */
 "l1-data-speculative-read-ops\000legacy cache\000Level 1 data cache prefet=
ch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D58812 */
+/* offset=3D58770 */
 "l1-data-speculative-read-reference\000legacy cache\000Level 1 data cache =
prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\=
000"
-/* offset=3D58931 */
+/* offset=3D58889 */
 "l1-data-speculative-read-refs\000legacy cache\000Level 1 data cache prefe=
tch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D59045 */
+/* offset=3D59003 */
 "l1-data-store\000legacy cache\000Level 1 data cache write accesses\000leg=
acy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D59140 */
+/* offset=3D59098 */
 "l1-data-store-access\000legacy cache\000Level 1 data cache write accesses=
\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D59242 */
+/* offset=3D59200 */
 "l1-data-store-miss\000legacy cache\000Level 1 data cache write misses\000=
legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D59342 */
+/* offset=3D59300 */
 "l1-data-store-misses\000legacy cache\000Level 1 data cache write misses\0=
00legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D59444 */
+/* offset=3D59402 */
 "l1-data-store-ops\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D59543 */
+/* offset=3D59501 */
 "l1-data-store-reference\000legacy cache\000Level 1 data cache write acces=
ses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D59648 */
+/* offset=3D59606 */
 "l1-data-store-refs\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D59748 */
+/* offset=3D59706 */
 "l1-data-stores\000legacy cache\000Level 1 data cache write accesses\000le=
gacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D59844 */
+/* offset=3D59802 */
 "l1-data-stores-access\000legacy cache\000Level 1 data cache write accesse=
s\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D59947 */
+/* offset=3D59905 */
 "l1-data-stores-miss\000legacy cache\000Level 1 data cache write misses\00=
0legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D60048 */
+/* offset=3D60006 */
 "l1-data-stores-misses\000legacy cache\000Level 1 data cache write misses\=
000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D60151 */
+/* offset=3D60109 */
 "l1-data-stores-ops\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D60251 */
+/* offset=3D60209 */
 "l1-data-stores-reference\000legacy cache\000Level 1 data cache write acce=
sses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D60357 */
+/* offset=3D60315 */
 "l1-data-stores-refs\000legacy cache\000Level 1 data cache write accesses\=
000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D60458 */
+/* offset=3D60416 */
 "l1-data-write\000legacy cache\000Level 1 data cache write accesses\000leg=
acy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D60553 */
+/* offset=3D60511 */
 "l1-data-write-access\000legacy cache\000Level 1 data cache write accesses=
\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D60655 */
+/* offset=3D60613 */
 "l1-data-write-miss\000legacy cache\000Level 1 data cache write misses\000=
legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D60755 */
+/* offset=3D60713 */
 "l1-data-write-misses\000legacy cache\000Level 1 data cache write misses\0=
00legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D60857 */
+/* offset=3D60815 */
 "l1-data-write-ops\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D60956 */
+/* offset=3D60914 */
 "l1-data-write-reference\000legacy cache\000Level 1 data cache write acces=
ses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D61061 */
+/* offset=3D61019 */
 "l1-data-write-refs\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D61161 */
+/* offset=3D61119 */
 "l1-dcache\000legacy cache\000Level 1 data cache read accesses\000legacy-c=
ache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D61247 */
+/* offset=3D61205 */
 "l1-dcache-access\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D61340 */
+/* offset=3D61298 */
 "l1-dcache-load\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D61431 */
+/* offset=3D61389 */
 "l1-dcache-load-access\000legacy cache\000Level 1 data cache read accesses=
\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D61529 */
+/* offset=3D61487 */
 "l1-dcache-load-miss\000legacy cache\000Level 1 data cache read misses\000=
legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D61629 */
+/* offset=3D61587 */
 "l1-dcache-load-misses\000legacy cache\000Level 1 data cache read misses\0=
00legacy-cache-config=3D0x10000\000\00000\000\000\000\000\000"
-/* offset=3D61731 */
+/* offset=3D61689 */
 "l1-dcache-load-ops\000legacy cache\000Level 1 data cache read accesses\00=
0legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D61826 */
+/* offset=3D61784 */
 "l1-dcache-load-reference\000legacy cache\000Level 1 data cache read acces=
ses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D61927 */
+/* offset=3D61885 */
 "l1-dcache-load-refs\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D62023 */
+/* offset=3D61981 */
 "l1-dcache-loads\000legacy cache\000Level 1 data cache read accesses\000le=
gacy-cache-config=3D0\000\00000\000\000\000\000\000"
-/* offset=3D62115 */
+/* offset=3D62073 */
 "l1-dcache-loads-access\000legacy cache\000Level 1 data cache read accesse=
s\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D62214 */
+/* offset=3D62172 */
 "l1-dcache-loads-miss\000legacy cache\000Level 1 data cache read misses\00=
0legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D62315 */
+/* offset=3D62273 */
 "l1-dcache-loads-misses\000legacy cache\000Level 1 data cache read misses\=
000legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D62418 */
+/* offset=3D62376 */
 "l1-dcache-loads-ops\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D62514 */
+/* offset=3D62472 */
 "l1-dcache-loads-reference\000legacy cache\000Level 1 data cache read acce=
sses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D62616 */
+/* offset=3D62574 */
 "l1-dcache-loads-refs\000legacy cache\000Level 1 data cache read accesses\=
000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D62713 */
+/* offset=3D62671 */
 "l1-dcache-miss\000legacy cache\000Level 1 data cache read misses\000legac=
y-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D62808 */
+/* offset=3D62766 */
 "l1-dcache-misses\000legacy cache\000Level 1 data cache read misses\000leg=
acy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D62905 */
+/* offset=3D62863 */
 "l1-dcache-ops\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D62995 */
+/* offset=3D62953 */
 "l1-dcache-prefetch\000legacy cache\000Level 1 data cache prefetch accesse=
s\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D63098 */
+/* offset=3D63056 */
 "l1-dcache-prefetch-access\000legacy cache\000Level 1 data cache prefetch =
accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D63208 */
+/* offset=3D63166 */
 "l1-dcache-prefetch-miss\000legacy cache\000Level 1 data cache prefetch mi=
sses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D63316 */
+/* offset=3D63274 */
 "l1-dcache-prefetch-misses\000legacy cache\000Level 1 data cache prefetch =
misses\000legacy-cache-config=3D0x10200\000\00000\000\000\000\000\000"
-/* offset=3D63426 */
+/* offset=3D63384 */
 "l1-dcache-prefetch-ops\000legacy cache\000Level 1 data cache prefetch acc=
esses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D63533 */
+/* offset=3D63491 */
 "l1-dcache-prefetch-reference\000legacy cache\000Level 1 data cache prefet=
ch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D63646 */
+/* offset=3D63604 */
 "l1-dcache-prefetch-refs\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D63754 */
+/* offset=3D63712 */
 "l1-dcache-prefetches\000legacy cache\000Level 1 data cache prefetch acces=
ses\000legacy-cache-config=3D0x200\000\00000\000\000\000\000\000"
-/* offset=3D63859 */
+/* offset=3D63817 */
 "l1-dcache-prefetches-access\000legacy cache\000Level 1 data cache prefetc=
h accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D63971 */
+/* offset=3D63929 */
 "l1-dcache-prefetches-miss\000legacy cache\000Level 1 data cache prefetch =
misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D64081 */
+/* offset=3D64039 */
 "l1-dcache-prefetches-misses\000legacy cache\000Level 1 data cache prefetc=
h misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D64193 */
+/* offset=3D64151 */
 "l1-dcache-prefetches-ops\000legacy cache\000Level 1 data cache prefetch a=
ccesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D64302 */
+/* offset=3D64260 */
 "l1-dcache-prefetches-reference\000legacy cache\000Level 1 data cache pref=
etch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D64417 */
+/* offset=3D64375 */
 "l1-dcache-prefetches-refs\000legacy cache\000Level 1 data cache prefetch =
accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D64527 */
+/* offset=3D64485 */
 "l1-dcache-read\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D64618 */
+/* offset=3D64576 */
 "l1-dcache-read-access\000legacy cache\000Level 1 data cache read accesses=
\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D64716 */
+/* offset=3D64674 */
 "l1-dcache-read-miss\000legacy cache\000Level 1 data cache read misses\000=
legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D64816 */
+/* offset=3D64774 */
 "l1-dcache-read-misses\000legacy cache\000Level 1 data cache read misses\0=
00legacy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D64918 */
+/* offset=3D64876 */
 "l1-dcache-read-ops\000legacy cache\000Level 1 data cache read accesses\00=
0legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D65013 */
+/* offset=3D64971 */
 "l1-dcache-read-reference\000legacy cache\000Level 1 data cache read acces=
ses\000legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D65114 */
+/* offset=3D65072 */
 "l1-dcache-read-refs\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D65210 */
+/* offset=3D65168 */
 "l1-dcache-reference\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D65306 */
+/* offset=3D65264 */
 "l1-dcache-refs\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D65397 */
+/* offset=3D65355 */
 "l1-dcache-speculative-load\000legacy cache\000Level 1 data cache prefetch=
 accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D65508 */
+/* offset=3D65466 */
 "l1-dcache-speculative-load-access\000legacy cache\000Level 1 data cache p=
refetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\0=
00"
-/* offset=3D65626 */
+/* offset=3D65584 */
 "l1-dcache-speculative-load-miss\000legacy cache\000Level 1 data cache pre=
fetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000=
"
-/* offset=3D65742 */
+/* offset=3D65700 */
 "l1-dcache-speculative-load-misses\000legacy cache\000Level 1 data cache p=
refetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\0=
00"
-/* offset=3D65860 */
+/* offset=3D65818 */
 "l1-dcache-speculative-load-ops\000legacy cache\000Level 1 data cache pref=
etch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D65975 */
+/* offset=3D65933 */
 "l1-dcache-speculative-load-reference\000legacy cache\000Level 1 data cach=
e prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\00=
0\000"
-/* offset=3D66096 */
+/* offset=3D66054 */
 "l1-dcache-speculative-load-refs\000legacy cache\000Level 1 data cache pre=
fetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000=
"
-/* offset=3D66212 */
+/* offset=3D66170 */
 "l1-dcache-speculative-read\000legacy cache\000Level 1 data cache prefetch=
 accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D66323 */
+/* offset=3D66281 */
 "l1-dcache-speculative-read-access\000legacy cache\000Level 1 data cache p=
refetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\0=
00"
-/* offset=3D66441 */
+/* offset=3D66399 */
 "l1-dcache-speculative-read-miss\000legacy cache\000Level 1 data cache pre=
fetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000=
"
-/* offset=3D66557 */
+/* offset=3D66515 */
 "l1-dcache-speculative-read-misses\000legacy cache\000Level 1 data cache p=
refetch misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\0=
00"
-/* offset=3D66675 */
+/* offset=3D66633 */
 "l1-dcache-speculative-read-ops\000legacy cache\000Level 1 data cache pref=
etch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D66790 */
+/* offset=3D66748 */
 "l1-dcache-speculative-read-reference\000legacy cache\000Level 1 data cach=
e prefetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\00=
0\000"
-/* offset=3D66911 */
+/* offset=3D66869 */
 "l1-dcache-speculative-read-refs\000legacy cache\000Level 1 data cache pre=
fetch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000=
"
-/* offset=3D67027 */
+/* offset=3D66985 */
 "l1-dcache-store\000legacy cache\000Level 1 data cache write accesses\000l=
egacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D67124 */
+/* offset=3D67082 */
 "l1-dcache-store-access\000legacy cache\000Level 1 data cache write access=
es\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D67228 */
+/* offset=3D67186 */
 "l1-dcache-store-miss\000legacy cache\000Level 1 data cache write misses\0=
00legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D67330 */
+/* offset=3D67288 */
 "l1-dcache-store-misses\000legacy cache\000Level 1 data cache write misses=
\000legacy-cache-config=3D0x10100\000\00000\000\000\000\000\000"
-/* offset=3D67434 */
+/* offset=3D67392 */
 "l1-dcache-store-ops\000legacy cache\000Level 1 data cache write accesses\=
000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D67535 */
+/* offset=3D67493 */
 "l1-dcache-store-reference\000legacy cache\000Level 1 data cache write acc=
esses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D67642 */
+/* offset=3D67600 */
 "l1-dcache-store-refs\000legacy cache\000Level 1 data cache write accesses=
\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D67744 */
+/* offset=3D67702 */
 "l1-dcache-stores\000legacy cache\000Level 1 data cache write accesses\000=
legacy-cache-config=3D0x100\000\00000\000\000\000\000\000"
-/* offset=3D67842 */
+/* offset=3D67800 */
 "l1-dcache-stores-access\000legacy cache\000Level 1 data cache write acces=
ses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D67947 */
+/* offset=3D67905 */
 "l1-dcache-stores-miss\000legacy cache\000Level 1 data cache write misses\=
000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D68050 */
+/* offset=3D68008 */
 "l1-dcache-stores-misses\000legacy cache\000Level 1 data cache write misse=
s\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D68155 */
+/* offset=3D68113 */
 "l1-dcache-stores-ops\000legacy cache\000Level 1 data cache write accesses=
\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D68257 */
+/* offset=3D68215 */
 "l1-dcache-stores-reference\000legacy cache\000Level 1 data cache write ac=
cesses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D68365 */
+/* offset=3D68323 */
 "l1-dcache-stores-refs\000legacy cache\000Level 1 data cache write accesse=
s\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D68468 */
+/* offset=3D68426 */
 "l1-dcache-write\000legacy cache\000Level 1 data cache write accesses\000l=
egacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D68565 */
+/* offset=3D68523 */
 "l1-dcache-write-access\000legacy cache\000Level 1 data cache write access=
es\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D68669 */
+/* offset=3D68627 */
 "l1-dcache-write-miss\000legacy cache\000Level 1 data cache write misses\0=
00legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D68771 */
+/* offset=3D68729 */
 "l1-dcache-write-misses\000legacy cache\000Level 1 data cache write misses=
\000legacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D68875 */
+/* offset=3D68833 */
 "l1-dcache-write-ops\000legacy cache\000Level 1 data cache write accesses\=
000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D68976 */
+/* offset=3D68934 */
 "l1-dcache-write-reference\000legacy cache\000Level 1 data cache write acc=
esses\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D69083 */
+/* offset=3D69041 */
 "l1-dcache-write-refs\000legacy cache\000Level 1 data cache write accesses=
\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D69185 */
+/* offset=3D69143 */
 "l1-i\000legacy cache\000Level 1 instruction cache read accesses\000legacy=
-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D69273 */
+/* offset=3D69231 */
 "l1-i-access\000legacy cache\000Level 1 instruction cache read accesses\00=
0legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D69368 */
+/* offset=3D69326 */
 "l1-i-load\000legacy cache\000Level 1 instruction cache read accesses\000l=
egacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D69461 */
+/* offset=3D69419 */
 "l1-i-load-access\000legacy cache\000Level 1 instruction cache read access=
es\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D69561 */
+/* offset=3D69519 */
 "l1-i-load-miss\000legacy cache\000Level 1 instruction cache read misses\0=
00legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D69663 */
+/* offset=3D69621 */
 "l1-i-load-misses\000legacy cache\000Level 1 instruction cache read misses=
\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D69767 */
+/* offset=3D69725 */
 "l1-i-load-ops\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D69864 */
+/* offset=3D69822 */
 "l1-i-load-reference\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D69967 */
+/* offset=3D69925 */
 "l1-i-load-refs\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D70065 */
+/* offset=3D70023 */
 "l1-i-loads\000legacy cache\000Level 1 instruction cache read accesses\000=
legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D70159 */
+/* offset=3D70117 */
 "l1-i-loads-access\000legacy cache\000Level 1 instruction cache read acces=
ses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D70260 */
+/* offset=3D70218 */
 "l1-i-loads-miss\000legacy cache\000Level 1 instruction cache read misses\=
000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D70363 */
+/* offset=3D70321 */
 "l1-i-loads-misses\000legacy cache\000Level 1 instruction cache read misse=
s\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D70468 */
+/* offset=3D70426 */
 "l1-i-loads-ops\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D70566 */
+/* offset=3D70524 */
 "l1-i-loads-reference\000legacy cache\000Level 1 instruction cache read ac=
cesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D70670 */
+/* offset=3D70628 */
 "l1-i-loads-refs\000legacy cache\000Level 1 instruction cache read accesse=
s\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D70769 */
+/* offset=3D70727 */
 "l1-i-miss\000legacy cache\000Level 1 instruction cache read misses\000leg=
acy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D70866 */
+/* offset=3D70824 */
 "l1-i-misses\000legacy cache\000Level 1 instruction cache read misses\000l=
egacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D70965 */
+/* offset=3D70923 */
 "l1-i-ops\000legacy cache\000Level 1 instruction cache read accesses\000le=
gacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D71057 */
+/* offset=3D71015 */
 "l1-i-prefetch\000legacy cache\000Level 1 instruction cache prefetch acces=
ses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D71162 */
+/* offset=3D71120 */
 "l1-i-prefetch-access\000legacy cache\000Level 1 instruction cache prefetc=
h accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D71274 */
+/* offset=3D71232 */
 "l1-i-prefetch-miss\000legacy cache\000Level 1 instruction cache prefetch =
misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
-/* offset=3D71384 */
+/* offset=3D71342 */
 "l1-i-prefetch-misses\000legacy cache\000Level 1 instruction cache prefetc=
h misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
-/* offset=3D71496 */
+/* offset=3D71454 */
 "l1-i-prefetch-ops\000legacy cache\000Level 1 instruction cache prefetch a=
ccesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D71605 */
+/* offset=3D71563 */
 "l1-i-prefetch-reference\000legacy cache\000Level 1 instruction cache pref=
etch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D71720 */
+/* offset=3D71678 */
 "l1-i-prefetch-refs\000legacy cache\000Level 1 instruction cache prefetch =
accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D71830 */
+/* offset=3D71788 */
 "l1-i-prefetches\000legacy cache\000Level 1 instruction cache prefetch acc=
esses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D71937 */
+/* offset=3D71895 */
 "l1-i-prefetches-access\000legacy cache\000Level 1 instruction cache prefe=
tch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D72051 */
+/* offset=3D72009 */
 "l1-i-prefetches-miss\000legacy cache\000Level 1 instruction cache prefetc=
h misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
-/* offset=3D72163 */
+/* offset=3D72121 */
 "l1-i-prefetches-misses\000legacy cache\000Level 1 instruction cache prefe=
tch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
-/* offset=3D72277 */
+/* offset=3D72235 */
 "l1-i-prefetches-ops\000legacy cache\000Level 1 instruction cache prefetch=
 accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D72388 */
+/* offset=3D72346 */
 "l1-i-prefetches-reference\000legacy cache\000Level 1 instruction cache pr=
efetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\00=
0"
-/* offset=3D72505 */
+/* offset=3D72463 */
 "l1-i-prefetches-refs\000legacy cache\000Level 1 instruction cache prefetc=
h accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D72617 */
+/* offset=3D72575 */
 "l1-i-read\000legacy cache\000Level 1 instruction cache read accesses\000l=
egacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D72710 */
+/* offset=3D72668 */
 "l1-i-read-access\000legacy cache\000Level 1 instruction cache read access=
es\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D72810 */
+/* offset=3D72768 */
 "l1-i-read-miss\000legacy cache\000Level 1 instruction cache read misses\0=
00legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D72912 */
+/* offset=3D72870 */
 "l1-i-read-misses\000legacy cache\000Level 1 instruction cache read misses=
\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D73016 */
+/* offset=3D72974 */
 "l1-i-read-ops\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D73113 */
+/* offset=3D73071 */
 "l1-i-read-reference\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D73216 */
+/* offset=3D73174 */
 "l1-i-read-refs\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D73314 */
+/* offset=3D73272 */
 "l1-i-reference\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D73412 */
+/* offset=3D73370 */
 "l1-i-refs\000legacy cache\000Level 1 instruction cache read accesses\000l=
egacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D73505 */
+/* offset=3D73463 */
 "l1-i-speculative-load\000legacy cache\000Level 1 instruction cache prefet=
ch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D73618 */
+/* offset=3D73576 */
 "l1-i-speculative-load-access\000legacy cache\000Level 1 instruction cache=
 prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000=
\000"
-/* offset=3D73738 */
+/* offset=3D73696 */
 "l1-i-speculative-load-miss\000legacy cache\000Level 1 instruction cache p=
refetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\0=
00"
-/* offset=3D73856 */
+/* offset=3D73814 */
 "l1-i-speculative-load-misses\000legacy cache\000Level 1 instruction cache=
 prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000=
\000"
-/* offset=3D73976 */
+/* offset=3D73934 */
 "l1-i-speculative-load-ops\000legacy cache\000Level 1 instruction cache pr=
efetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\00=
0"
-/* offset=3D74093 */
+/* offset=3D74051 */
 "l1-i-speculative-load-reference\000legacy cache\000Level 1 instruction ca=
che prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\=
000\000"
-/* offset=3D74216 */
+/* offset=3D74174 */
 "l1-i-speculative-load-refs\000legacy cache\000Level 1 instruction cache p=
refetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\0=
00"
-/* offset=3D74334 */
+/* offset=3D74292 */
 "l1-i-speculative-read\000legacy cache\000Level 1 instruction cache prefet=
ch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D74447 */
+/* offset=3D74405 */
 "l1-i-speculative-read-access\000legacy cache\000Level 1 instruction cache=
 prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000=
\000"
-/* offset=3D74567 */
+/* offset=3D74525 */
 "l1-i-speculative-read-miss\000legacy cache\000Level 1 instruction cache p=
refetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\0=
00"
-/* offset=3D74685 */
+/* offset=3D74643 */
 "l1-i-speculative-read-misses\000legacy cache\000Level 1 instruction cache=
 prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000=
\000"
-/* offset=3D74805 */
+/* offset=3D74763 */
 "l1-i-speculative-read-ops\000legacy cache\000Level 1 instruction cache pr=
efetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\00=
0"
-/* offset=3D74922 */
+/* offset=3D74880 */
 "l1-i-speculative-read-reference\000legacy cache\000Level 1 instruction ca=
che prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\=
000\000"
-/* offset=3D75045 */
+/* offset=3D75003 */
 "l1-i-speculative-read-refs\000legacy cache\000Level 1 instruction cache p=
refetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\0=
00"
-/* offset=3D75163 */
+/* offset=3D75121 */
 "l1-icache\000legacy cache\000Level 1 instruction cache read accesses\000l=
egacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D75256 */
+/* offset=3D75214 */
 "l1-icache-access\000legacy cache\000Level 1 instruction cache read access=
es\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D75356 */
+/* offset=3D75314 */
 "l1-icache-load\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D75454 */
+/* offset=3D75412 */
 "l1-icache-load-access\000legacy cache\000Level 1 instruction cache read a=
ccesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D75559 */
+/* offset=3D75517 */
 "l1-icache-load-miss\000legacy cache\000Level 1 instruction cache read mis=
ses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D75666 */
+/* offset=3D75624 */
 "l1-icache-load-misses\000legacy cache\000Level 1 instruction cache read m=
isses\000legacy-cache-config=3D0x10001\000\00000\000\000\000\000\000"
-/* offset=3D75775 */
+/* offset=3D75733 */
 "l1-icache-load-ops\000legacy cache\000Level 1 instruction cache read acce=
sses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D75877 */
+/* offset=3D75835 */
 "l1-icache-load-reference\000legacy cache\000Level 1 instruction cache rea=
d accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D75985 */
+/* offset=3D75943 */
 "l1-icache-load-refs\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D76088 */
+/* offset=3D76046 */
 "l1-icache-loads\000legacy cache\000Level 1 instruction cache read accesse=
s\000legacy-cache-config=3D1\000\00000\000\000\000\000\000"
-/* offset=3D76187 */
+/* offset=3D76145 */
 "l1-icache-loads-access\000legacy cache\000Level 1 instruction cache read =
accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D76293 */
+/* offset=3D76251 */
 "l1-icache-loads-miss\000legacy cache\000Level 1 instruction cache read mi=
sses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D76401 */
+/* offset=3D76359 */
 "l1-icache-loads-misses\000legacy cache\000Level 1 instruction cache read =
misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D76511 */
+/* offset=3D76469 */
 "l1-icache-loads-ops\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D76614 */
+/* offset=3D76572 */
 "l1-icache-loads-reference\000legacy cache\000Level 1 instruction cache re=
ad accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D76723 */
+/* offset=3D76681 */
 "l1-icache-loads-refs\000legacy cache\000Level 1 instruction cache read ac=
cesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D76827 */
+/* offset=3D76785 */
 "l1-icache-miss\000legacy cache\000Level 1 instruction cache read misses\0=
00legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D76929 */
+/* offset=3D76887 */
 "l1-icache-misses\000legacy cache\000Level 1 instruction cache read misses=
\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D77033 */
+/* offset=3D76991 */
 "l1-icache-ops\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D77130 */
+/* offset=3D77088 */
 "l1-icache-prefetch\000legacy cache\000Level 1 instruction cache prefetch =
accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D77240 */
+/* offset=3D77198 */
 "l1-icache-prefetch-access\000legacy cache\000Level 1 instruction cache pr=
efetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\00=
0"
-/* offset=3D77357 */
+/* offset=3D77315 */
 "l1-icache-prefetch-miss\000legacy cache\000Level 1 instruction cache pref=
etch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
-/* offset=3D77472 */
+/* offset=3D77430 */
 "l1-icache-prefetch-misses\000legacy cache\000Level 1 instruction cache pr=
efetch misses\000legacy-cache-config=3D0x10201\000\00000\000\000\000\000\00=
0"
-/* offset=3D77589 */
+/* offset=3D77547 */
 "l1-icache-prefetch-ops\000legacy cache\000Level 1 instruction cache prefe=
tch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D77703 */
+/* offset=3D77661 */
 "l1-icache-prefetch-reference\000legacy cache\000Level 1 instruction cache=
 prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000=
\000"
-/* offset=3D77823 */
+/* offset=3D77781 */
 "l1-icache-prefetch-refs\000legacy cache\000Level 1 instruction cache pref=
etch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D77938 */
+/* offset=3D77896 */
 "l1-icache-prefetches\000legacy cache\000Level 1 instruction cache prefetc=
h accesses\000legacy-cache-config=3D0x201\000\00000\000\000\000\000\000"
-/* offset=3D78050 */
+/* offset=3D78008 */
 "l1-icache-prefetches-access\000legacy cache\000Level 1 instruction cache =
prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\=
000"
-/* offset=3D78169 */
+/* offset=3D78127 */
 "l1-icache-prefetches-miss\000legacy cache\000Level 1 instruction cache pr=
efetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\00=
0"
-/* offset=3D78286 */
+/* offset=3D78244 */
 "l1-icache-prefetches-misses\000legacy cache\000Level 1 instruction cache =
prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\=
000"
-/* offset=3D78405 */
+/* offset=3D78363 */
 "l1-icache-prefetches-ops\000legacy cache\000Level 1 instruction cache pre=
fetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000=
"
-/* offset=3D78521 */
+/* offset=3D78479 */
 "l1-icache-prefetches-reference\000legacy cache\000Level 1 instruction cac=
he prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\0=
00\000"
-/* offset=3D78643 */
+/* offset=3D78601 */
 "l1-icache-prefetches-refs\000legacy cache\000Level 1 instruction cache pr=
efetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\00=
0"
-/* offset=3D78760 */
+/* offset=3D78718 */
 "l1-icache-read\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D78858 */
+/* offset=3D78816 */
 "l1-icache-read-access\000legacy cache\000Level 1 instruction cache read a=
ccesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D78963 */
+/* offset=3D78921 */
 "l1-icache-read-miss\000legacy cache\000Level 1 instruction cache read mis=
ses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D79070 */
+/* offset=3D79028 */
 "l1-icache-read-misses\000legacy cache\000Level 1 instruction cache read m=
isses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D79179 */
+/* offset=3D79137 */
 "l1-icache-read-ops\000legacy cache\000Level 1 instruction cache read acce=
sses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D79281 */
+/* offset=3D79239 */
 "l1-icache-read-reference\000legacy cache\000Level 1 instruction cache rea=
d accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D79389 */
+/* offset=3D79347 */
 "l1-icache-read-refs\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D79492 */
+/* offset=3D79450 */
 "l1-icache-reference\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D79595 */
+/* offset=3D79553 */
 "l1-icache-refs\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D79693 */
+/* offset=3D79651 */
 "l1-icache-speculative-load\000legacy cache\000Level 1 instruction cache p=
refetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\0=
00"
-/* offset=3D79811 */
+/* offset=3D79769 */
 "l1-icache-speculative-load-access\000legacy cache\000Level 1 instruction =
cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\00=
0\000\000"
-/* offset=3D79936 */
+/* offset=3D79894 */
 "l1-icache-speculative-load-miss\000legacy cache\000Level 1 instruction ca=
che prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\=
000\000"
-/* offset=3D80059 */
+/* offset=3D80017 */
 "l1-icache-speculative-load-misses\000legacy cache\000Level 1 instruction =
cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\00=
0\000\000"
-/* offset=3D80184 */
+/* offset=3D80142 */
 "l1-icache-speculative-load-ops\000legacy cache\000Level 1 instruction cac=
he prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\0=
00\000"
-/* offset=3D80306 */
+/* offset=3D80264 */
 "l1-icache-speculative-load-reference\000legacy cache\000Level 1 instructi=
on cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000=
\000\000\000"
-/* offset=3D80434 */
+/* offset=3D80392 */
 "l1-icache-speculative-load-refs\000legacy cache\000Level 1 instruction ca=
che prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\=
000\000"
-/* offset=3D80557 */
+/* offset=3D80515 */
 "l1-icache-speculative-read\000legacy cache\000Level 1 instruction cache p=
refetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\0=
00"
-/* offset=3D80675 */
+/* offset=3D80633 */
 "l1-icache-speculative-read-access\000legacy cache\000Level 1 instruction =
cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\00=
0\000\000"
-/* offset=3D80800 */
+/* offset=3D80758 */
 "l1-icache-speculative-read-miss\000legacy cache\000Level 1 instruction ca=
che prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\=
000\000"
-/* offset=3D80923 */
+/* offset=3D80881 */
 "l1-icache-speculative-read-misses\000legacy cache\000Level 1 instruction =
cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\00=
0\000\000"
-/* offset=3D81048 */
+/* offset=3D81006 */
 "l1-icache-speculative-read-ops\000legacy cache\000Level 1 instruction cac=
he prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\0=
00\000"
-/* offset=3D81170 */
+/* offset=3D81128 */
 "l1-icache-speculative-read-reference\000legacy cache\000Level 1 instructi=
on cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000=
\000\000\000"
-/* offset=3D81298 */
+/* offset=3D81256 */
 "l1-icache-speculative-read-refs\000legacy cache\000Level 1 instruction ca=
che prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\=
000\000"
-/* offset=3D81421 */
+/* offset=3D81379 */
 "l1-instruction\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D81519 */
+/* offset=3D81477 */
 "l1-instruction-access\000legacy cache\000Level 1 instruction cache read a=
ccesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D81624 */
+/* offset=3D81582 */
 "l1-instruction-load\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D81727 */
+/* offset=3D81685 */
 "l1-instruction-load-access\000legacy cache\000Level 1 instruction cache r=
ead accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D81837 */
+/* offset=3D81795 */
 "l1-instruction-load-miss\000legacy cache\000Level 1 instruction cache rea=
d misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D81949 */
+/* offset=3D81907 */
 "l1-instruction-load-misses\000legacy cache\000Level 1 instruction cache r=
ead misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D82063 */
+/* offset=3D82021 */
 "l1-instruction-load-ops\000legacy cache\000Level 1 instruction cache read=
 accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D82170 */
+/* offset=3D82128 */
 "l1-instruction-load-reference\000legacy cache\000Level 1 instruction cach=
e read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D82283 */
+/* offset=3D82241 */
 "l1-instruction-load-refs\000legacy cache\000Level 1 instruction cache rea=
d accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D82391 */
+/* offset=3D82349 */
 "l1-instruction-loads\000legacy cache\000Level 1 instruction cache read ac=
cesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D82495 */
+/* offset=3D82453 */
 "l1-instruction-loads-access\000legacy cache\000Level 1 instruction cache =
read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D82606 */
+/* offset=3D82564 */
 "l1-instruction-loads-miss\000legacy cache\000Level 1 instruction cache re=
ad misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D82719 */
+/* offset=3D82677 */
 "l1-instruction-loads-misses\000legacy cache\000Level 1 instruction cache =
read misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D82834 */
+/* offset=3D82792 */
 "l1-instruction-loads-ops\000legacy cache\000Level 1 instruction cache rea=
d accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D82942 */
+/* offset=3D82900 */
 "l1-instruction-loads-reference\000legacy cache\000Level 1 instruction cac=
he read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D83056 */
+/* offset=3D83014 */
 "l1-instruction-loads-refs\000legacy cache\000Level 1 instruction cache re=
ad accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D83165 */
+/* offset=3D83123 */
 "l1-instruction-miss\000legacy cache\000Level 1 instruction cache read mis=
ses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D83272 */
+/* offset=3D83230 */
 "l1-instruction-misses\000legacy cache\000Level 1 instruction cache read m=
isses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D83381 */
+/* offset=3D83339 */
 "l1-instruction-ops\000legacy cache\000Level 1 instruction cache read acce=
sses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D83483 */
+/* offset=3D83441 */
 "l1-instruction-prefetch\000legacy cache\000Level 1 instruction cache pref=
etch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D83598 */
+/* offset=3D83556 */
 "l1-instruction-prefetch-access\000legacy cache\000Level 1 instruction cac=
he prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\0=
00\000"
-/* offset=3D83720 */
+/* offset=3D83678 */
 "l1-instruction-prefetch-miss\000legacy cache\000Level 1 instruction cache=
 prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000=
\000"
-/* offset=3D83840 */
+/* offset=3D83798 */
 "l1-instruction-prefetch-misses\000legacy cache\000Level 1 instruction cac=
he prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\0=
00\000"
-/* offset=3D83962 */
+/* offset=3D83920 */
 "l1-instruction-prefetch-ops\000legacy cache\000Level 1 instruction cache =
prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\=
000"
-/* offset=3D84081 */
+/* offset=3D84039 */
 "l1-instruction-prefetch-reference\000legacy cache\000Level 1 instruction =
cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\00=
0\000\000"
-/* offset=3D84206 */
+/* offset=3D84164 */
 "l1-instruction-prefetch-refs\000legacy cache\000Level 1 instruction cache=
 prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000=
\000"
-/* offset=3D84326 */
+/* offset=3D84284 */
 "l1-instruction-prefetches\000legacy cache\000Level 1 instruction cache pr=
efetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\00=
0"
-/* offset=3D84443 */
+/* offset=3D84401 */
 "l1-instruction-prefetches-access\000legacy cache\000Level 1 instruction c=
ache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000=
\000\000"
-/* offset=3D84567 */
+/* offset=3D84525 */
 "l1-instruction-prefetches-miss\000legacy cache\000Level 1 instruction cac=
he prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\0=
00\000"
-/* offset=3D84689 */
+/* offset=3D84647 */
 "l1-instruction-prefetches-misses\000legacy cache\000Level 1 instruction c=
ache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000=
\000\000"
-/* offset=3D84813 */
+/* offset=3D84771 */
 "l1-instruction-prefetches-ops\000legacy cache\000Level 1 instruction cach=
e prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\00=
0\000"
-/* offset=3D84934 */
+/* offset=3D84892 */
 "l1-instruction-prefetches-reference\000legacy cache\000Level 1 instructio=
n cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\=
000\000\000"
-/* offset=3D85061 */
+/* offset=3D85019 */
 "l1-instruction-prefetches-refs\000legacy cache\000Level 1 instruction cac=
he prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\0=
00\000"
-/* offset=3D85183 */
+/* offset=3D85141 */
 "l1-instruction-read\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D85286 */
+/* offset=3D85244 */
 "l1-instruction-read-access\000legacy cache\000Level 1 instruction cache r=
ead accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D85396 */
+/* offset=3D85354 */
 "l1-instruction-read-miss\000legacy cache\000Level 1 instruction cache rea=
d misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D85508 */
+/* offset=3D85466 */
 "l1-instruction-read-misses\000legacy cache\000Level 1 instruction cache r=
ead misses\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D85622 */
+/* offset=3D85580 */
 "l1-instruction-read-ops\000legacy cache\000Level 1 instruction cache read=
 accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D85729 */
+/* offset=3D85687 */
 "l1-instruction-read-reference\000legacy cache\000Level 1 instruction cach=
e read accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D85842 */
+/* offset=3D85800 */
 "l1-instruction-read-refs\000legacy cache\000Level 1 instruction cache rea=
d accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D85950 */
+/* offset=3D85908 */
 "l1-instruction-reference\000legacy cache\000Level 1 instruction cache rea=
d accesses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D86058 */
+/* offset=3D86016 */
 "l1-instruction-refs\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D86161 */
+/* offset=3D86119 */
 "l1-instruction-speculative-load\000legacy cache\000Level 1 instruction ca=
che prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\=
000\000"
-/* offset=3D86284 */
+/* offset=3D86242 */
 "l1-instruction-speculative-load-access\000legacy cache\000Level 1 instruc=
tion cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\0=
00\000\000\000"
-/* offset=3D86414 */
+/* offset=3D86372 */
 "l1-instruction-speculative-load-miss\000legacy cache\000Level 1 instructi=
on cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000=
\000\000\000"
-/* offset=3D86542 */
+/* offset=3D86500 */
 "l1-instruction-speculative-load-misses\000legacy cache\000Level 1 instruc=
tion cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\0=
00\000\000\000"
-/* offset=3D86672 */
+/* offset=3D86630 */
 "l1-instruction-speculative-load-ops\000legacy cache\000Level 1 instructio=
n cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\=
000\000\000"
-/* offset=3D86799 */
+/* offset=3D86757 */
 "l1-instruction-speculative-load-reference\000legacy cache\000Level 1 inst=
ruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\00=
0\000\000\000\000"
-/* offset=3D86932 */
+/* offset=3D86890 */
 "l1-instruction-speculative-load-refs\000legacy cache\000Level 1 instructi=
on cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000=
\000\000\000"
-/* offset=3D87060 */
+/* offset=3D87018 */
 "l1-instruction-speculative-read\000legacy cache\000Level 1 instruction ca=
che prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\=
000\000"
-/* offset=3D87183 */
+/* offset=3D87141 */
 "l1-instruction-speculative-read-access\000legacy cache\000Level 1 instruc=
tion cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\0=
00\000\000\000"
-/* offset=3D87313 */
+/* offset=3D87271 */
 "l1-instruction-speculative-read-miss\000legacy cache\000Level 1 instructi=
on cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000=
\000\000\000"
-/* offset=3D87441 */
+/* offset=3D87399 */
 "l1-instruction-speculative-read-misses\000legacy cache\000Level 1 instruc=
tion cache prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\0=
00\000\000\000"
-/* offset=3D87571 */
+/* offset=3D87529 */
 "l1-instruction-speculative-read-ops\000legacy cache\000Level 1 instructio=
n cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\=
000\000\000"
-/* offset=3D87698 */
+/* offset=3D87656 */
 "l1-instruction-speculative-read-reference\000legacy cache\000Level 1 inst=
ruction cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\00=
0\000\000\000\000"
-/* offset=3D87831 */
+/* offset=3D87789 */
 "l1-instruction-speculative-read-refs\000legacy cache\000Level 1 instructi=
on cache prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000=
\000\000\000"
-/* offset=3D87959 */
+/* offset=3D87917 */
 "l1d\000legacy cache\000Level 1 data cache read accesses\000legacy-cache-c=
onfig=3D0\000\00010\000\000\000\000\000"
-/* offset=3D88039 */
+/* offset=3D87997 */
 "l1d-access\000legacy cache\000Level 1 data cache read accesses\000legacy-=
cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D88126 */
+/* offset=3D88084 */
 "l1d-load\000legacy cache\000Level 1 data cache read accesses\000legacy-ca=
che-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D88211 */
+/* offset=3D88169 */
 "l1d-load-access\000legacy cache\000Level 1 data cache read accesses\000le=
gacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D88303 */
+/* offset=3D88261 */
 "l1d-load-miss\000legacy cache\000Level 1 data cache read misses\000legacy=
-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D88397 */
+/* offset=3D88355 */
 "l1d-load-misses\000legacy cache\000Level 1 data cache read misses\000lega=
cy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D88493 */
+/* offset=3D88451 */
 "l1d-load-ops\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D88582 */
+/* offset=3D88540 */
 "l1d-load-reference\000legacy cache\000Level 1 data cache read accesses\00=
0legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D88677 */
+/* offset=3D88635 */
 "l1d-load-refs\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D88767 */
+/* offset=3D88725 */
 "l1d-loads\000legacy cache\000Level 1 data cache read accesses\000legacy-c=
ache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D88853 */
+/* offset=3D88811 */
 "l1d-loads-access\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D88946 */
+/* offset=3D88904 */
 "l1d-loads-miss\000legacy cache\000Level 1 data cache read misses\000legac=
y-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D89041 */
+/* offset=3D88999 */
 "l1d-loads-misses\000legacy cache\000Level 1 data cache read misses\000leg=
acy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D89138 */
+/* offset=3D89096 */
 "l1d-loads-ops\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D89228 */
+/* offset=3D89186 */
 "l1d-loads-reference\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D89324 */
+/* offset=3D89282 */
 "l1d-loads-refs\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D89415 */
+/* offset=3D89373 */
 "l1d-miss\000legacy cache\000Level 1 data cache read misses\000legacy-cach=
e-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D89504 */
+/* offset=3D89462 */
 "l1d-misses\000legacy cache\000Level 1 data cache read misses\000legacy-ca=
che-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D89595 */
+/* offset=3D89553 */
 "l1d-ops\000legacy cache\000Level 1 data cache read accesses\000legacy-cac=
he-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D89679 */
+/* offset=3D89637 */
 "l1d-prefetch\000legacy cache\000Level 1 data cache prefetch accesses\000l=
egacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D89776 */
+/* offset=3D89734 */
 "l1d-prefetch-access\000legacy cache\000Level 1 data cache prefetch access=
es\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D89880 */
+/* offset=3D89838 */
 "l1d-prefetch-miss\000legacy cache\000Level 1 data cache prefetch misses\0=
00legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D89982 */
+/* offset=3D89940 */
 "l1d-prefetch-misses\000legacy cache\000Level 1 data cache prefetch misses=
\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D90086 */
+/* offset=3D90044 */
 "l1d-prefetch-ops\000legacy cache\000Level 1 data cache prefetch accesses\=
000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D90187 */
+/* offset=3D90145 */
 "l1d-prefetch-reference\000legacy cache\000Level 1 data cache prefetch acc=
esses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D90294 */
+/* offset=3D90252 */
 "l1d-prefetch-refs\000legacy cache\000Level 1 data cache prefetch accesses=
\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D90396 */
+/* offset=3D90354 */
 "l1d-prefetches\000legacy cache\000Level 1 data cache prefetch accesses\00=
0legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D90495 */
+/* offset=3D90453 */
 "l1d-prefetches-access\000legacy cache\000Level 1 data cache prefetch acce=
sses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D90601 */
+/* offset=3D90559 */
 "l1d-prefetches-miss\000legacy cache\000Level 1 data cache prefetch misses=
\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D90705 */
+/* offset=3D90663 */
 "l1d-prefetches-misses\000legacy cache\000Level 1 data cache prefetch miss=
es\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D90811 */
+/* offset=3D90769 */
 "l1d-prefetches-ops\000legacy cache\000Level 1 data cache prefetch accesse=
s\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D90914 */
+/* offset=3D90872 */
 "l1d-prefetches-reference\000legacy cache\000Level 1 data cache prefetch a=
ccesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D91023 */
+/* offset=3D90981 */
 "l1d-prefetches-refs\000legacy cache\000Level 1 data cache prefetch access=
es\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D91127 */
+/* offset=3D91085 */
 "l1d-read\000legacy cache\000Level 1 data cache read accesses\000legacy-ca=
che-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D91212 */
+/* offset=3D91170 */
 "l1d-read-access\000legacy cache\000Level 1 data cache read accesses\000le=
gacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D91304 */
+/* offset=3D91262 */
 "l1d-read-miss\000legacy cache\000Level 1 data cache read misses\000legacy=
-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D91398 */
+/* offset=3D91356 */
 "l1d-read-misses\000legacy cache\000Level 1 data cache read misses\000lega=
cy-cache-config=3D0x10000\000\00010\000\000\000\000\000"
-/* offset=3D91494 */
+/* offset=3D91452 */
 "l1d-read-ops\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D91583 */
+/* offset=3D91541 */
 "l1d-read-reference\000legacy cache\000Level 1 data cache read accesses\00=
0legacy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D91678 */
+/* offset=3D91636 */
 "l1d-read-refs\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D91768 */
+/* offset=3D91726 */
 "l1d-reference\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D91858 */
+/* offset=3D91816 */
 "l1d-refs\000legacy cache\000Level 1 data cache read accesses\000legacy-ca=
che-config=3D0\000\00010\000\000\000\000\000"
-/* offset=3D91943 */
+/* offset=3D91901 */
 "l1d-speculative-load\000legacy cache\000Level 1 data cache prefetch acces=
ses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D92048 */
+/* offset=3D92006 */
 "l1d-speculative-load-access\000legacy cache\000Level 1 data cache prefetc=
h accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D92160 */
+/* offset=3D92118 */
 "l1d-speculative-load-miss\000legacy cache\000Level 1 data cache prefetch =
misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D92270 */
+/* offset=3D92228 */
 "l1d-speculative-load-misses\000legacy cache\000Level 1 data cache prefetc=
h misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D92382 */
+/* offset=3D92340 */
 "l1d-speculative-load-ops\000legacy cache\000Level 1 data cache prefetch a=
ccesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D92491 */
+/* offset=3D92449 */
 "l1d-speculative-load-reference\000legacy cache\000Level 1 data cache pref=
etch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D92606 */
+/* offset=3D92564 */
 "l1d-speculative-load-refs\000legacy cache\000Level 1 data cache prefetch =
accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D92716 */
+/* offset=3D92674 */
 "l1d-speculative-read\000legacy cache\000Level 1 data cache prefetch acces=
ses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D92821 */
+/* offset=3D92779 */
 "l1d-speculative-read-access\000legacy cache\000Level 1 data cache prefetc=
h accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D92933 */
+/* offset=3D92891 */
 "l1d-speculative-read-miss\000legacy cache\000Level 1 data cache prefetch =
misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D93043 */
+/* offset=3D93001 */
 "l1d-speculative-read-misses\000legacy cache\000Level 1 data cache prefetc=
h misses\000legacy-cache-config=3D0x10200\000\00010\000\000\000\000\000"
-/* offset=3D93155 */
+/* offset=3D93113 */
 "l1d-speculative-read-ops\000legacy cache\000Level 1 data cache prefetch a=
ccesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D93264 */
+/* offset=3D93222 */
 "l1d-speculative-read-reference\000legacy cache\000Level 1 data cache pref=
etch accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D93379 */
+/* offset=3D93337 */
 "l1d-speculative-read-refs\000legacy cache\000Level 1 data cache prefetch =
accesses\000legacy-cache-config=3D0x200\000\00010\000\000\000\000\000"
-/* offset=3D93489 */
+/* offset=3D93447 */
 "l1d-store\000legacy cache\000Level 1 data cache write accesses\000legacy-=
cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D93580 */
+/* offset=3D93538 */
 "l1d-store-access\000legacy cache\000Level 1 data cache write accesses\000=
legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D93678 */
+/* offset=3D93636 */
 "l1d-store-miss\000legacy cache\000Level 1 data cache write misses\000lega=
cy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D93774 */
+/* offset=3D93732 */
 "l1d-store-misses\000legacy cache\000Level 1 data cache write misses\000le=
gacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D93872 */
+/* offset=3D93830 */
 "l1d-store-ops\000legacy cache\000Level 1 data cache write accesses\000leg=
acy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D93967 */
+/* offset=3D93925 */
 "l1d-store-reference\000legacy cache\000Level 1 data cache write accesses\=
000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D94068 */
+/* offset=3D94026 */
 "l1d-store-refs\000legacy cache\000Level 1 data cache write accesses\000le=
gacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D94164 */
+/* offset=3D94122 */
 "l1d-stores\000legacy cache\000Level 1 data cache write accesses\000legacy=
-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D94256 */
+/* offset=3D94214 */
 "l1d-stores-access\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D94355 */
+/* offset=3D94313 */
 "l1d-stores-miss\000legacy cache\000Level 1 data cache write misses\000leg=
acy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D94452 */
+/* offset=3D94410 */
 "l1d-stores-misses\000legacy cache\000Level 1 data cache write misses\000l=
egacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D94551 */
+/* offset=3D94509 */
 "l1d-stores-ops\000legacy cache\000Level 1 data cache write accesses\000le=
gacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D94647 */
+/* offset=3D94605 */
 "l1d-stores-reference\000legacy cache\000Level 1 data cache write accesses=
\000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D94749 */
+/* offset=3D94707 */
 "l1d-stores-refs\000legacy cache\000Level 1 data cache write accesses\000l=
egacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D94846 */
+/* offset=3D94804 */
 "l1d-write\000legacy cache\000Level 1 data cache write accesses\000legacy-=
cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D94937 */
+/* offset=3D94895 */
 "l1d-write-access\000legacy cache\000Level 1 data cache write accesses\000=
legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D95035 */
+/* offset=3D94993 */
 "l1d-write-miss\000legacy cache\000Level 1 data cache write misses\000lega=
cy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D95131 */
+/* offset=3D95089 */
 "l1d-write-misses\000legacy cache\000Level 1 data cache write misses\000le=
gacy-cache-config=3D0x10100\000\00010\000\000\000\000\000"
-/* offset=3D95229 */
+/* offset=3D95187 */
 "l1d-write-ops\000legacy cache\000Level 1 data cache write accesses\000leg=
acy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D95324 */
+/* offset=3D95282 */
 "l1d-write-reference\000legacy cache\000Level 1 data cache write accesses\=
000legacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D95425 */
+/* offset=3D95383 */
 "l1d-write-refs\000legacy cache\000Level 1 data cache write accesses\000le=
gacy-cache-config=3D0x100\000\00010\000\000\000\000\000"
-/* offset=3D95521 */
+/* offset=3D95479 */
 "l1i\000legacy cache\000Level 1 instruction cache read accesses\000legacy-=
cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D95608 */
+/* offset=3D95566 */
 "l1i-access\000legacy cache\000Level 1 instruction cache read accesses\000=
legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D95702 */
+/* offset=3D95660 */
 "l1i-load\000legacy cache\000Level 1 instruction cache read accesses\000le=
gacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D95794 */
+/* offset=3D95752 */
 "l1i-load-access\000legacy cache\000Level 1 instruction cache read accesse=
s\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D95893 */
+/* offset=3D95851 */
 "l1i-load-miss\000legacy cache\000Level 1 instruction cache read misses\00=
0legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D95994 */
+/* offset=3D95952 */
 "l1i-load-misses\000legacy cache\000Level 1 instruction cache read misses\=
000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D96097 */
+/* offset=3D96055 */
 "l1i-load-ops\000legacy cache\000Level 1 instruction cache read accesses\0=
00legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D96193 */
+/* offset=3D96151 */
 "l1i-load-reference\000legacy cache\000Level 1 instruction cache read acce=
sses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D96295 */
+/* offset=3D96253 */
 "l1i-load-refs\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D96392 */
+/* offset=3D96350 */
 "l1i-loads\000legacy cache\000Level 1 instruction cache read accesses\000l=
egacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D96485 */
+/* offset=3D96443 */
 "l1i-loads-access\000legacy cache\000Level 1 instruction cache read access=
es\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D96585 */
+/* offset=3D96543 */
 "l1i-loads-miss\000legacy cache\000Level 1 instruction cache read misses\0=
00legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D96687 */
+/* offset=3D96645 */
 "l1i-loads-misses\000legacy cache\000Level 1 instruction cache read misses=
\000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D96791 */
+/* offset=3D96749 */
 "l1i-loads-ops\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D96888 */
+/* offset=3D96846 */
 "l1i-loads-reference\000legacy cache\000Level 1 instruction cache read acc=
esses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D96991 */
+/* offset=3D96949 */
 "l1i-loads-refs\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D97089 */
+/* offset=3D97047 */
 "l1i-miss\000legacy cache\000Level 1 instruction cache read misses\000lega=
cy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D97185 */
+/* offset=3D97143 */
 "l1i-misses\000legacy cache\000Level 1 instruction cache read misses\000le=
gacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D97283 */
+/* offset=3D97241 */
 "l1i-ops\000legacy cache\000Level 1 instruction cache read accesses\000leg=
acy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D97374 */
+/* offset=3D97332 */
 "l1i-prefetch\000legacy cache\000Level 1 instruction cache prefetch access=
es\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D97478 */
+/* offset=3D97436 */
 "l1i-prefetch-access\000legacy cache\000Level 1 instruction cache prefetch=
 accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D97589 */
+/* offset=3D97547 */
 "l1i-prefetch-miss\000legacy cache\000Level 1 instruction cache prefetch m=
isses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
-/* offset=3D97698 */
+/* offset=3D97656 */
 "l1i-prefetch-misses\000legacy cache\000Level 1 instruction cache prefetch=
 misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
-/* offset=3D97809 */
+/* offset=3D97767 */
 "l1i-prefetch-ops\000legacy cache\000Level 1 instruction cache prefetch ac=
cesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D97917 */
+/* offset=3D97875 */
 "l1i-prefetch-reference\000legacy cache\000Level 1 instruction cache prefe=
tch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D98031 */
+/* offset=3D97989 */
 "l1i-prefetch-refs\000legacy cache\000Level 1 instruction cache prefetch a=
ccesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D98140 */
+/* offset=3D98098 */
 "l1i-prefetches\000legacy cache\000Level 1 instruction cache prefetch acce=
sses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D98246 */
+/* offset=3D98204 */
 "l1i-prefetches-access\000legacy cache\000Level 1 instruction cache prefet=
ch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D98359 */
+/* offset=3D98317 */
 "l1i-prefetches-miss\000legacy cache\000Level 1 instruction cache prefetch=
 misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
-/* offset=3D98470 */
+/* offset=3D98428 */
 "l1i-prefetches-misses\000legacy cache\000Level 1 instruction cache prefet=
ch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\000"
-/* offset=3D98583 */
+/* offset=3D98541 */
 "l1i-prefetches-ops\000legacy cache\000Level 1 instruction cache prefetch =
accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D98693 */
+/* offset=3D98651 */
 "l1i-prefetches-reference\000legacy cache\000Level 1 instruction cache pre=
fetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000=
"
-/* offset=3D98809 */
+/* offset=3D98767 */
 "l1i-prefetches-refs\000legacy cache\000Level 1 instruction cache prefetch=
 accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D98920 */
+/* offset=3D98878 */
 "l1i-read\000legacy cache\000Level 1 instruction cache read accesses\000le=
gacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D99012 */
+/* offset=3D98970 */
 "l1i-read-access\000legacy cache\000Level 1 instruction cache read accesse=
s\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D99111 */
+/* offset=3D99069 */
 "l1i-read-miss\000legacy cache\000Level 1 instruction cache read misses\00=
0legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D99212 */
+/* offset=3D99170 */
 "l1i-read-misses\000legacy cache\000Level 1 instruction cache read misses\=
000legacy-cache-config=3D0x10001\000\00010\000\000\000\000\000"
-/* offset=3D99315 */
+/* offset=3D99273 */
 "l1i-read-ops\000legacy cache\000Level 1 instruction cache read accesses\0=
00legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D99411 */
+/* offset=3D99369 */
 "l1i-read-reference\000legacy cache\000Level 1 instruction cache read acce=
sses\000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D99513 */
+/* offset=3D99471 */
 "l1i-read-refs\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D99610 */
+/* offset=3D99568 */
 "l1i-reference\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D99707 */
+/* offset=3D99665 */
 "l1i-refs\000legacy cache\000Level 1 instruction cache read accesses\000le=
gacy-cache-config=3D1\000\00010\000\000\000\000\000"
-/* offset=3D99799 */
+/* offset=3D99757 */
 "l1i-speculative-load\000legacy cache\000Level 1 instruction cache prefetc=
h accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D99911 */
+/* offset=3D99869 */
 "l1i-speculative-load-access\000legacy cache\000Level 1 instruction cache =
prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\=
000"
-/* offset=3D100030 */
+/* offset=3D99988 */
 "l1i-speculative-load-miss\000legacy cache\000Level 1 instruction cache pr=
efetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\00=
0"
-/* offset=3D100147 */
+/* offset=3D100105 */
 "l1i-speculative-load-misses\000legacy cache\000Level 1 instruction cache =
prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\=
000"
-/* offset=3D100266 */
+/* offset=3D100224 */
 "l1i-speculative-load-ops\000legacy cache\000Level 1 instruction cache pre=
fetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000=
"
-/* offset=3D100382 */
+/* offset=3D100340 */
 "l1i-speculative-load-reference\000legacy cache\000Level 1 instruction cac=
he prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\0=
00\000"
-/* offset=3D100504 */
+/* offset=3D100462 */
 "l1i-speculative-load-refs\000legacy cache\000Level 1 instruction cache pr=
efetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\00=
0"
-/* offset=3D100621 */
+/* offset=3D100579 */
 "l1i-speculative-read\000legacy cache\000Level 1 instruction cache prefetc=
h accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000"
-/* offset=3D100733 */
+/* offset=3D100691 */
 "l1i-speculative-read-access\000legacy cache\000Level 1 instruction cache =
prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\=
000"
-/* offset=3D100852 */
+/* offset=3D100810 */
 "l1i-speculative-read-miss\000legacy cache\000Level 1 instruction cache pr=
efetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\00=
0"
-/* offset=3D100969 */
+/* offset=3D100927 */
 "l1i-speculative-read-misses\000legacy cache\000Level 1 instruction cache =
prefetch misses\000legacy-cache-config=3D0x10201\000\00010\000\000\000\000\=
000"
-/* offset=3D101088 */
+/* offset=3D101046 */
 "l1i-speculative-read-ops\000legacy cache\000Level 1 instruction cache pre=
fetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\000=
"
-/* offset=3D101204 */
+/* offset=3D101162 */
 "l1i-speculative-read-reference\000legacy cache\000Level 1 instruction cac=
he prefetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\0=
00\000"
-/* offset=3D101326 */
+/* offset=3D101284 */
 "l1i-speculative-read-refs\000legacy cache\000Level 1 instruction cache pr=
efetch accesses\000legacy-cache-config=3D0x201\000\00010\000\000\000\000\00=
0"
-/* offset=3D101443 */
+/* offset=3D101401 */
 "l2\000legacy cache\000Level 2 (or higher) last level cache read accesses\=
000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D101540 */
+/* offset=3D101498 */
 "l2-access\000legacy cache\000Level 2 (or higher) last level cache read ac=
cesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D101644 */
+/* offset=3D101602 */
 "l2-load\000legacy cache\000Level 2 (or higher) last level cache read acce=
sses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D101746 */
+/* offset=3D101704 */
 "l2-load-access\000legacy cache\000Level 2 (or higher) last level cache re=
ad accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D101855 */
+/* offset=3D101813 */
 "l2-load-miss\000legacy cache\000Level 2 (or higher) last level cache read=
 misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D101966 */
+/* offset=3D101924 */
 "l2-load-misses\000legacy cache\000Level 2 (or higher) last level cache re=
ad misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D102079 */
+/* offset=3D102037 */
 "l2-load-ops\000legacy cache\000Level 2 (or higher) last level cache read =
accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D102185 */
+/* offset=3D102143 */
 "l2-load-reference\000legacy cache\000Level 2 (or higher) last level cache=
 read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D102297 */
+/* offset=3D102255 */
 "l2-load-refs\000legacy cache\000Level 2 (or higher) last level cache read=
 accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D102404 */
+/* offset=3D102362 */
 "l2-loads\000legacy cache\000Level 2 (or higher) last level cache read acc=
esses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D102507 */
+/* offset=3D102465 */
 "l2-loads-access\000legacy cache\000Level 2 (or higher) last level cache r=
ead accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D102617 */
+/* offset=3D102575 */
 "l2-loads-miss\000legacy cache\000Level 2 (or higher) last level cache rea=
d misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D102729 */
+/* offset=3D102687 */
 "l2-loads-misses\000legacy cache\000Level 2 (or higher) last level cache r=
ead misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D102843 */
+/* offset=3D102801 */
 "l2-loads-ops\000legacy cache\000Level 2 (or higher) last level cache read=
 accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D102950 */
+/* offset=3D102908 */
 "l2-loads-reference\000legacy cache\000Level 2 (or higher) last level cach=
e read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D103063 */
+/* offset=3D103021 */
 "l2-loads-refs\000legacy cache\000Level 2 (or higher) last level cache rea=
d accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D103171 */
+/* offset=3D103129 */
 "l2-miss\000legacy cache\000Level 2 (or higher) last level cache read miss=
es\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D103277 */
+/* offset=3D103235 */
 "l2-misses\000legacy cache\000Level 2 (or higher) last level cache read mi=
sses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D103385 */
+/* offset=3D103343 */
 "l2-ops\000legacy cache\000Level 2 (or higher) last level cache read acces=
ses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D103486 */
+/* offset=3D103444 */
 "l2-prefetch\000legacy cache\000Level 2 (or higher) last level cache prefe=
tch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D103600 */
+/* offset=3D103558 */
 "l2-prefetch-access\000legacy cache\000Level 2 (or higher) last level cach=
e prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\00=
0\000"
-/* offset=3D103721 */
+/* offset=3D103679 */
 "l2-prefetch-miss\000legacy cache\000Level 2 (or higher) last level cache =
prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\000\=
000"
-/* offset=3D103840 */
+/* offset=3D103798 */
 "l2-prefetch-misses\000legacy cache\000Level 2 (or higher) last level cach=
e prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\00=
0\000"
-/* offset=3D103961 */
+/* offset=3D103919 */
 "l2-prefetch-ops\000legacy cache\000Level 2 (or higher) last level cache p=
refetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\0=
00"
-/* offset=3D104079 */
+/* offset=3D104037 */
 "l2-prefetch-reference\000legacy cache\000Level 2 (or higher) last level c=
ache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000=
\000\000"
-/* offset=3D104203 */
+/* offset=3D104161 */
 "l2-prefetch-refs\000legacy cache\000Level 2 (or higher) last level cache =
prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\=
000"
-/* offset=3D104322 */
+/* offset=3D104280 */
 "l2-prefetches\000legacy cache\000Level 2 (or higher) last level cache pre=
fetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000=
"
-/* offset=3D104438 */
+/* offset=3D104396 */
 "l2-prefetches-access\000legacy cache\000Level 2 (or higher) last level ca=
che prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\=
000\000"
-/* offset=3D104561 */
+/* offset=3D104519 */
 "l2-prefetches-miss\000legacy cache\000Level 2 (or higher) last level cach=
e prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\00=
0\000"
-/* offset=3D104682 */
+/* offset=3D104640 */
 "l2-prefetches-misses\000legacy cache\000Level 2 (or higher) last level ca=
che prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\=
000\000"
-/* offset=3D104805 */
+/* offset=3D104763 */
 "l2-prefetches-ops\000legacy cache\000Level 2 (or higher) last level cache=
 prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000=
\000"
-/* offset=3D104925 */
+/* offset=3D104883 */
 "l2-prefetches-reference\000legacy cache\000Level 2 (or higher) last level=
 cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\0=
00\000\000"
-/* offset=3D105051 */
+/* offset=3D105009 */
 "l2-prefetches-refs\000legacy cache\000Level 2 (or higher) last level cach=
e prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\00=
0\000"
-/* offset=3D105172 */
+/* offset=3D105130 */
 "l2-read\000legacy cache\000Level 2 (or higher) last level cache read acce=
sses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D105274 */
+/* offset=3D105232 */
 "l2-read-access\000legacy cache\000Level 2 (or higher) last level cache re=
ad accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D105383 */
+/* offset=3D105341 */
 "l2-read-miss\000legacy cache\000Level 2 (or higher) last level cache read=
 misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D105494 */
+/* offset=3D105452 */
 "l2-read-misses\000legacy cache\000Level 2 (or higher) last level cache re=
ad misses\000legacy-cache-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D105607 */
+/* offset=3D105565 */
 "l2-read-ops\000legacy cache\000Level 2 (or higher) last level cache read =
accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D105713 */
+/* offset=3D105671 */
 "l2-read-reference\000legacy cache\000Level 2 (or higher) last level cache=
 read accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D105825 */
+/* offset=3D105783 */
 "l2-read-refs\000legacy cache\000Level 2 (or higher) last level cache read=
 accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D105932 */
+/* offset=3D105890 */
 "l2-reference\000legacy cache\000Level 2 (or higher) last level cache read=
 accesses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D106039 */
+/* offset=3D105997 */
 "l2-refs\000legacy cache\000Level 2 (or higher) last level cache read acce=
sses\000legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D106141 */
+/* offset=3D106099 */
 "l2-speculative-load\000legacy cache\000Level 2 (or higher) last level cac=
he prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\0=
00\000"
-/* offset=3D106263 */
+/* offset=3D106221 */
 "l2-speculative-load-access\000legacy cache\000Level 2 (or higher) last le=
vel cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\00=
0\000\000\000"
-/* offset=3D106392 */
+/* offset=3D106350 */
 "l2-speculative-load-miss\000legacy cache\000Level 2 (or higher) last leve=
l cache prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\=
000\000\000"
-/* offset=3D106519 */
+/* offset=3D106477 */
 "l2-speculative-load-misses\000legacy cache\000Level 2 (or higher) last le=
vel cache prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\00=
0\000\000\000"
-/* offset=3D106648 */
+/* offset=3D106606 */
 "l2-speculative-load-ops\000legacy cache\000Level 2 (or higher) last level=
 cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\0=
00\000\000"
-/* offset=3D106774 */
+/* offset=3D106732 */
 "l2-speculative-load-reference\000legacy cache\000Level 2 (or higher) last=
 level cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000=
\000\000\000\000"
-/* offset=3D106906 */
+/* offset=3D106864 */
 "l2-speculative-load-refs\000legacy cache\000Level 2 (or higher) last leve=
l cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\=
000\000\000"
-/* offset=3D107033 */
+/* offset=3D106991 */
 "l2-speculative-read\000legacy cache\000Level 2 (or higher) last level cac=
he prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\0=
00\000"
-/* offset=3D107155 */
+/* offset=3D107113 */
 "l2-speculative-read-access\000legacy cache\000Level 2 (or higher) last le=
vel cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\00=
0\000\000\000"
-/* offset=3D107284 */
+/* offset=3D107242 */
 "l2-speculative-read-miss\000legacy cache\000Level 2 (or higher) last leve=
l cache prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\000\=
000\000\000"
-/* offset=3D107411 */
+/* offset=3D107369 */
 "l2-speculative-read-misses\000legacy cache\000Level 2 (or higher) last le=
vel cache prefetch misses\000legacy-cache-config=3D0x10202\000\00010\000\00=
0\000\000\000"
-/* offset=3D107540 */
+/* offset=3D107498 */
 "l2-speculative-read-ops\000legacy cache\000Level 2 (or higher) last level=
 cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\0=
00\000\000"
-/* offset=3D107666 */
+/* offset=3D107624 */
 "l2-speculative-read-reference\000legacy cache\000Level 2 (or higher) last=
 level cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000=
\000\000\000\000"
-/* offset=3D107798 */
+/* offset=3D107756 */
 "l2-speculative-read-refs\000legacy cache\000Level 2 (or higher) last leve=
l cache prefetch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\=
000\000\000"
-/* offset=3D107925 */
+/* offset=3D107883 */
 "l2-store\000legacy cache\000Level 2 (or higher) last level cache write ac=
cesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D108033 */
+/* offset=3D107991 */
 "l2-store-access\000legacy cache\000Level 2 (or higher) last level cache w=
rite accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D108148 */
+/* offset=3D108106 */
 "l2-store-miss\000legacy cache\000Level 2 (or higher) last level cache wri=
te misses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\000"
-/* offset=3D108261 */
+/* offset=3D108219 */
 "l2-store-misses\000legacy cache\000Level 2 (or higher) last level cache w=
rite misses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\000"
-/* offset=3D108376 */
+/* offset=3D108334 */
 "l2-store-ops\000legacy cache\000Level 2 (or higher) last level cache writ=
e accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D108488 */
+/* offset=3D108446 */
 "l2-store-reference\000legacy cache\000Level 2 (or higher) last level cach=
e write accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\0=
00"
-/* offset=3D108606 */
+/* offset=3D108564 */
 "l2-store-refs\000legacy cache\000Level 2 (or higher) last level cache wri=
te accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D108719 */
+/* offset=3D108677 */
 "l2-stores\000legacy cache\000Level 2 (or higher) last level cache write a=
ccesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D108828 */
+/* offset=3D108786 */
 "l2-stores-access\000legacy cache\000Level 2 (or higher) last level cache =
write accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000=
"
-/* offset=3D108944 */
+/* offset=3D108902 */
 "l2-stores-miss\000legacy cache\000Level 2 (or higher) last level cache wr=
ite misses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\000"
-/* offset=3D109058 */
+/* offset=3D109016 */
 "l2-stores-misses\000legacy cache\000Level 2 (or higher) last level cache =
write misses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\000=
"
-/* offset=3D109174 */
+/* offset=3D109132 */
 "l2-stores-ops\000legacy cache\000Level 2 (or higher) last level cache wri=
te accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D109287 */
+/* offset=3D109245 */
 "l2-stores-reference\000legacy cache\000Level 2 (or higher) last level cac=
he write accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\=
000"
-/* offset=3D109406 */
+/* offset=3D109364 */
 "l2-stores-refs\000legacy cache\000Level 2 (or higher) last level cache wr=
ite accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D109520 */
+/* offset=3D109478 */
 "l2-write\000legacy cache\000Level 2 (or higher) last level cache write ac=
cesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D109628 */
+/* offset=3D109586 */
 "l2-write-access\000legacy cache\000Level 2 (or higher) last level cache w=
rite accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D109743 */
+/* offset=3D109701 */
 "l2-write-miss\000legacy cache\000Level 2 (or higher) last level cache wri=
te misses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\000"
-/* offset=3D109856 */
+/* offset=3D109814 */
 "l2-write-misses\000legacy cache\000Level 2 (or higher) last level cache w=
rite misses\000legacy-cache-config=3D0x10102\000\00010\000\000\000\000\000"
-/* offset=3D109971 */
+/* offset=3D109929 */
 "l2-write-ops\000legacy cache\000Level 2 (or higher) last level cache writ=
e accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D110083 */
+/* offset=3D110041 */
 "l2-write-reference\000legacy cache\000Level 2 (or higher) last level cach=
e write accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\0=
00"
-/* offset=3D110201 */
+/* offset=3D110159 */
 "l2-write-refs\000legacy cache\000Level 2 (or higher) last level cache wri=
te accesses\000legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D110314 */
+/* offset=3D110272 */
 "l3_cache_rd\000cache\000L3 cache access, read\000event=3D0x40\000\00000\0=
00\000\000\000Attributable Level 3 cache access, read\000"
-/* offset=3D110412 */
+/* offset=3D110370 */
 "llc\000legacy cache\000Last level cache read accesses\000legacy-cache-con=
fig=3D2\000\00010\000\000\000\000\000"
-/* offset=3D110490 */
+/* offset=3D110448 */
 "llc-access\000legacy cache\000Last level cache read accesses\000legacy-ca=
che-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D110575 */
+/* offset=3D110533 */
 "llc-load\000legacy cache\000Last level cache read accesses\000legacy-cach=
e-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D110658 */
+/* offset=3D110616 */
 "llc-load-access\000legacy cache\000Last level cache read accesses\000lega=
cy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D110748 */
+/* offset=3D110706 */
 "llc-load-miss\000legacy cache\000Last level cache read misses\000legacy-c=
ache-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D110840 */
+/* offset=3D110798 */
 "llc-load-misses\000legacy cache\000Last level cache read misses\000legacy=
-cache-config=3D0x10002\000\00000\000\000\000\000\000"
-/* offset=3D110934 */
+/* offset=3D110892 */
 "llc-load-ops\000legacy cache\000Last level cache read accesses\000legacy-=
cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D111021 */
+/* offset=3D110979 */
 "llc-load-reference\000legacy cache\000Last level cache read accesses\000l=
egacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D111114 */
+/* offset=3D111072 */
 "llc-load-refs\000legacy cache\000Last level cache read accesses\000legacy=
-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D111202 */
+/* offset=3D111160 */
 "llc-loads\000legacy cache\000Last level cache read accesses\000legacy-cac=
he-config=3D2\000\00000\000\000\000\000\000"
-/* offset=3D111286 */
+/* offset=3D111244 */
 "llc-loads-access\000legacy cache\000Last level cache read accesses\000leg=
acy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D111377 */
+/* offset=3D111335 */
 "llc-loads-miss\000legacy cache\000Last level cache read misses\000legacy-=
cache-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D111470 */
+/* offset=3D111428 */
 "llc-loads-misses\000legacy cache\000Last level cache read misses\000legac=
y-cache-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D111565 */
+/* offset=3D111523 */
 "llc-loads-ops\000legacy cache\000Last level cache read accesses\000legacy=
-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D111653 */
+/* offset=3D111611 */
 "llc-loads-reference\000legacy cache\000Last level cache read accesses\000=
legacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D111747 */
+/* offset=3D111705 */
 "llc-loads-refs\000legacy cache\000Last level cache read accesses\000legac=
y-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D111836 */
+/* offset=3D111794 */
 "llc-miss\000legacy cache\000Last level cache read misses\000legacy-cache-=
config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D111923 */
+/* offset=3D111881 */
 "llc-misses\000legacy cache\000Last level cache read misses\000legacy-cach=
e-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D112012 */
+/* offset=3D111970 */
 "llc-ops\000legacy cache\000Last level cache read accesses\000legacy-cache=
-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D112094 */
+/* offset=3D112052 */
 "llc-prefetch\000legacy cache\000Last level cache prefetch accesses\000leg=
acy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D112189 */
+/* offset=3D112147 */
 "llc-prefetch-access\000legacy cache\000Last level cache prefetch accesses=
\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D112291 */
+/* offset=3D112249 */
 "llc-prefetch-miss\000legacy cache\000Last level cache prefetch misses\000=
legacy-cache-config=3D0x10202\000\00010\000\000\000\000\000"
-/* offset=3D112391 */
+/* offset=3D112349 */
 "llc-prefetch-misses\000legacy cache\000Last level cache prefetch misses\0=
00legacy-cache-config=3D0x10202\000\00000\000\000\000\000\000"
-/* offset=3D112493 */
+/* offset=3D112451 */
 "llc-prefetch-ops\000legacy cache\000Last level cache prefetch accesses\00=
0legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D112592 */
+/* offset=3D112550 */
 "llc-prefetch-reference\000legacy cache\000Last level cache prefetch acces=
ses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D112697 */
+/* offset=3D112655 */
 "llc-prefetch-refs\000legacy cache\000Last level cache prefetch accesses\0=
00legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D112797 */
+/* offset=3D112755 */
 "llc-prefetches\000legacy cache\000Last level cache prefetch accesses\000l=
egacy-cache-config=3D0x202\000\00000\000\000\000\000\000"
-/* offset=3D112894 */
+/* offset=3D112852 */
 "llc-prefetches-access\000legacy cache\000Last level cache prefetch access=
es\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D112998 */
+/* offset=3D112956 */
 "llc-prefetches-miss\000legacy cache\000Last level cache prefetch misses\0=
00legacy-cache-config=3D0x10202\000\00010\000\000\000\000\000"
-/* offset=3D113100 */
+/* offset=3D113058 */
 "llc-prefetches-misses\000legacy cache\000Last level cache prefetch misses=
\000legacy-cache-config=3D0x10202\000\00010\000\000\000\000\000"
-/* offset=3D113204 */
+/* offset=3D113162 */
 "llc-prefetches-ops\000legacy cache\000Last level cache prefetch accesses\=
000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D113305 */
+/* offset=3D113263 */
 "llc-prefetches-reference\000legacy cache\000Last level cache prefetch acc=
esses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D113412 */
+/* offset=3D113370 */
 "llc-prefetches-refs\000legacy cache\000Last level cache prefetch accesses=
\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D113514 */
+/* offset=3D113472 */
 "llc-read\000legacy cache\000Last level cache read accesses\000legacy-cach=
e-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D113597 */
+/* offset=3D113555 */
 "llc-read-access\000legacy cache\000Last level cache read accesses\000lega=
cy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D113687 */
+/* offset=3D113645 */
 "llc-read-miss\000legacy cache\000Last level cache read misses\000legacy-c=
ache-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D113779 */
+/* offset=3D113737 */
 "llc-read-misses\000legacy cache\000Last level cache read misses\000legacy=
-cache-config=3D0x10002\000\00010\000\000\000\000\000"
-/* offset=3D113873 */
+/* offset=3D113831 */
 "llc-read-ops\000legacy cache\000Last level cache read accesses\000legacy-=
cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D113960 */
+/* offset=3D113918 */
 "llc-read-reference\000legacy cache\000Last level cache read accesses\000l=
egacy-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D114053 */
+/* offset=3D114011 */
 "llc-read-refs\000legacy cache\000Last level cache read accesses\000legacy=
-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D114141 */
+/* offset=3D114099 */
 "llc-reference\000legacy cache\000Last level cache read accesses\000legacy=
-cache-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D114229 */
+/* offset=3D114187 */
 "llc-refs\000legacy cache\000Last level cache read accesses\000legacy-cach=
e-config=3D2\000\00010\000\000\000\000\000"
-/* offset=3D114312 */
+/* offset=3D114270 */
 "llc-speculative-load\000legacy cache\000Last level cache prefetch accesse=
s\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D114415 */
+/* offset=3D114373 */
 "llc-speculative-load-access\000legacy cache\000Last level cache prefetch =
accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D114525 */
+/* offset=3D114483 */
 "llc-speculative-load-miss\000legacy cache\000Last level cache prefetch mi=
sses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\000\000"
-/* offset=3D114633 */
+/* offset=3D114591 */
 "llc-speculative-load-misses\000legacy cache\000Last level cache prefetch =
misses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\000\000"
-/* offset=3D114743 */
+/* offset=3D114701 */
 "llc-speculative-load-ops\000legacy cache\000Last level cache prefetch acc=
esses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D114850 */
+/* offset=3D114808 */
 "llc-speculative-load-reference\000legacy cache\000Last level cache prefet=
ch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D114963 */
+/* offset=3D114921 */
 "llc-speculative-load-refs\000legacy cache\000Last level cache prefetch ac=
cesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D115071 */
+/* offset=3D115029 */
 "llc-speculative-read\000legacy cache\000Last level cache prefetch accesse=
s\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D115174 */
+/* offset=3D115132 */
 "llc-speculative-read-access\000legacy cache\000Last level cache prefetch =
accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D115284 */
+/* offset=3D115242 */
 "llc-speculative-read-miss\000legacy cache\000Last level cache prefetch mi=
sses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\000\000"
-/* offset=3D115392 */
+/* offset=3D115350 */
 "llc-speculative-read-misses\000legacy cache\000Last level cache prefetch =
misses\000legacy-cache-config=3D0x10202\000\00010\000\000\000\000\000"
-/* offset=3D115502 */
+/* offset=3D115460 */
 "llc-speculative-read-ops\000legacy cache\000Last level cache prefetch acc=
esses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D115609 */
+/* offset=3D115567 */
 "llc-speculative-read-reference\000legacy cache\000Last level cache prefet=
ch accesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D115722 */
+/* offset=3D115680 */
 "llc-speculative-read-refs\000legacy cache\000Last level cache prefetch ac=
cesses\000legacy-cache-config=3D0x202\000\00010\000\000\000\000\000"
-/* offset=3D115830 */
+/* offset=3D115788 */
 "llc-store\000legacy cache\000Last level cache write accesses\000legacy-ca=
che-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D115919 */
+/* offset=3D115877 */
 "llc-store-access\000legacy cache\000Last level cache write accesses\000le=
gacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D116015 */
+/* offset=3D115973 */
 "llc-store-miss\000legacy cache\000Last level cache write misses\000legacy=
-cache-config=3D0x10102\000\00010\000\000\000\000\000"
-/* offset=3D116109 */
+/* offset=3D116067 */
 "llc-store-misses\000legacy cache\000Last level cache write misses\000lega=
cy-cache-config=3D0x10102\000\00000\000\000\000\000\000"
-/* offset=3D116205 */
+/* offset=3D116163 */
 "llc-store-ops\000legacy cache\000Last level cache write accesses\000legac=
y-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D116298 */
+/* offset=3D116256 */
 "llc-store-reference\000legacy cache\000Last level cache write accesses\00=
0legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D116397 */
+/* offset=3D116355 */
 "llc-store-refs\000legacy cache\000Last level cache write accesses\000lega=
cy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D116491 */
+/* offset=3D116449 */
 "llc-stores\000legacy cache\000Last level cache write accesses\000legacy-c=
ache-config=3D0x102\000\00000\000\000\000\000\000"
-/* offset=3D116581 */
+/* offset=3D116539 */
 "llc-stores-access\000legacy cache\000Last level cache write accesses\000l=
egacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D116678 */
+/* offset=3D116636 */
 "llc-stores-miss\000legacy cache\000Last level cache write misses\000legac=
y-cache-config=3D0x10102\000\00010\000\000\000\000\000"
-/* offset=3D116773 */
+/* offset=3D116731 */
 "llc-stores-misses\000legacy cache\000Last level cache write misses\000leg=
acy-cache-config=3D0x10102\000\00010\000\000\000\000\000"
-/* offset=3D116870 */
+/* offset=3D116828 */
 "llc-stores-ops\000legacy cache\000Last level cache write accesses\000lega=
cy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D116964 */
+/* offset=3D116922 */
 "llc-stores-reference\000legacy cache\000Last level cache write accesses\0=
00legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D117064 */
+/* offset=3D117022 */
 "llc-stores-refs\000legacy cache\000Last level cache write accesses\000leg=
acy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D117159 */
+/* offset=3D117117 */
 "llc-write\000legacy cache\000Last level cache write accesses\000legacy-ca=
che-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D117248 */
+/* offset=3D117206 */
 "llc-write-access\000legacy cache\000Last level cache write accesses\000le=
gacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D117344 */
+/* offset=3D117302 */
 "llc-write-miss\000legacy cache\000Last level cache write misses\000legacy=
-cache-config=3D0x10102\000\00010\000\000\000\000\000"
-/* offset=3D117438 */
+/* offset=3D117396 */
 "llc-write-misses\000legacy cache\000Last level cache write misses\000lega=
cy-cache-config=3D0x10102\000\00010\000\000\000\000\000"
-/* offset=3D117534 */
+/* offset=3D117492 */
 "llc-write-ops\000legacy cache\000Last level cache write accesses\000legac=
y-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D117627 */
+/* offset=3D117585 */
 "llc-write-reference\000legacy cache\000Last level cache write accesses\00=
0legacy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D117726 */
+/* offset=3D117684 */
 "llc-write-refs\000legacy cache\000Last level cache write accesses\000lega=
cy-cache-config=3D0x102\000\00010\000\000\000\000\000"
-/* offset=3D117820 */
+/* offset=3D117778 */
 "major-faults\000software\000Number of major page faults. Major faults req=
uire I/O to handle\000config=3D6\000\00000\000\000\000\000\000"
-/* offset=3D117923 */
+/* offset=3D117881 */
 "migrations\000software\000Number of times a process has migrated to a new=
 CPU [This event is an alias of cpu-migrations]\000config=3D4\000\00000\000=
\000\000\000\000"
-/* offset=3D118055 */
+/* offset=3D118013 */
 "minor-faults\000software\000Number of minor page faults. Minor faults don=
't require I/O to handle\000config=3D5\000\00000\000\000\000\000\000"
-/* offset=3D118164 */
+/* offset=3D118122 */
 "node\000legacy cache\000Local memory read accesses\000legacy-cache-config=
=3D6\000\00010\000\000\000\000\000"
-/* offset=3D118239 */
+/* offset=3D118197 */
 "node-access\000legacy cache\000Local memory read accesses\000legacy-cache=
-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D118321 */
+/* offset=3D118279 */
 "node-load\000legacy cache\000Local memory read accesses\000legacy-cache-c=
onfig=3D6\000\00010\000\000\000\000\000"
-/* offset=3D118401 */
+/* offset=3D118359 */
 "node-load-access\000legacy cache\000Local memory read accesses\000legacy-=
cache-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D118488 */
+/* offset=3D118446 */
 "node-load-miss\000legacy cache\000Local memory read misses\000legacy-cach=
e-config=3D0x10006\000\00010\000\000\000\000\000"
-/* offset=3D118577 */
+/* offset=3D118535 */
 "node-load-misses\000legacy cache\000Local memory read misses\000legacy-ca=
che-config=3D0x10006\000\00000\000\000\000\000\000"
-/* offset=3D118668 */
+/* offset=3D118626 */
 "node-load-ops\000legacy cache\000Local memory read accesses\000legacy-cac=
he-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D118752 */
+/* offset=3D118710 */
 "node-load-reference\000legacy cache\000Local memory read accesses\000lega=
cy-cache-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D118842 */
+/* offset=3D118800 */
 "node-load-refs\000legacy cache\000Local memory read accesses\000legacy-ca=
che-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D118927 */
+/* offset=3D118885 */
 "node-loads\000legacy cache\000Local memory read accesses\000legacy-cache-=
config=3D6\000\00000\000\000\000\000\000"
-/* offset=3D119008 */
+/* offset=3D118966 */
 "node-loads-access\000legacy cache\000Local memory read accesses\000legacy=
-cache-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D119096 */
+/* offset=3D119054 */
 "node-loads-miss\000legacy cache\000Local memory read misses\000legacy-cac=
he-config=3D0x10006\000\00010\000\000\000\000\000"
-/* offset=3D119186 */
+/* offset=3D119144 */
 "node-loads-misses\000legacy cache\000Local memory read misses\000legacy-c=
ache-config=3D0x10006\000\00010\000\000\000\000\000"
-/* offset=3D119278 */
+/* offset=3D119236 */
 "node-loads-ops\000legacy cache\000Local memory read accesses\000legacy-ca=
che-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D119363 */
+/* offset=3D119321 */
 "node-loads-reference\000legacy cache\000Local memory read accesses\000leg=
acy-cache-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D119454 */
+/* offset=3D119412 */
 "node-loads-refs\000legacy cache\000Local memory read accesses\000legacy-c=
ache-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D119540 */
+/* offset=3D119498 */
 "node-miss\000legacy cache\000Local memory read misses\000legacy-cache-con=
fig=3D0x10006\000\00010\000\000\000\000\000"
-/* offset=3D119624 */
+/* offset=3D119582 */
 "node-misses\000legacy cache\000Local memory read misses\000legacy-cache-c=
onfig=3D0x10006\000\00010\000\000\000\000\000"
-/* offset=3D119710 */
+/* offset=3D119668 */
 "node-ops\000legacy cache\000Local memory read accesses\000legacy-cache-co=
nfig=3D6\000\00010\000\000\000\000\000"
-/* offset=3D119789 */
+/* offset=3D119747 */
 "node-prefetch\000legacy cache\000Local memory prefetch accesses\000legacy=
-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D119881 */
+/* offset=3D119839 */
 "node-prefetch-access\000legacy cache\000Local memory prefetch accesses\00=
0legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D119980 */
+/* offset=3D119938 */
 "node-prefetch-miss\000legacy cache\000Local memory prefetch misses\000leg=
acy-cache-config=3D0x10206\000\00010\000\000\000\000\000"
-/* offset=3D120077 */
+/* offset=3D120035 */
 "node-prefetch-misses\000legacy cache\000Local memory prefetch misses\000l=
egacy-cache-config=3D0x10206\000\00000\000\000\000\000\000"
-/* offset=3D120176 */
+/* offset=3D120134 */
 "node-prefetch-ops\000legacy cache\000Local memory prefetch accesses\000le=
gacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D120272 */
+/* offset=3D120230 */
 "node-prefetch-reference\000legacy cache\000Local memory prefetch accesses=
\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D120374 */
+/* offset=3D120332 */
 "node-prefetch-refs\000legacy cache\000Local memory prefetch accesses\000l=
egacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D120471 */
+/* offset=3D120429 */
 "node-prefetches\000legacy cache\000Local memory prefetch accesses\000lega=
cy-cache-config=3D0x206\000\00000\000\000\000\000\000"
-/* offset=3D120565 */
+/* offset=3D120523 */
 "node-prefetches-access\000legacy cache\000Local memory prefetch accesses\=
000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D120666 */
+/* offset=3D120624 */
 "node-prefetches-miss\000legacy cache\000Local memory prefetch misses\000l=
egacy-cache-config=3D0x10206\000\00010\000\000\000\000\000"
-/* offset=3D120765 */
+/* offset=3D120723 */
 "node-prefetches-misses\000legacy cache\000Local memory prefetch misses\00=
0legacy-cache-config=3D0x10206\000\00010\000\000\000\000\000"
-/* offset=3D120866 */
+/* offset=3D120824 */
 "node-prefetches-ops\000legacy cache\000Local memory prefetch accesses\000=
legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D120964 */
+/* offset=3D120922 */
 "node-prefetches-reference\000legacy cache\000Local memory prefetch access=
es\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D121068 */
+/* offset=3D121026 */
 "node-prefetches-refs\000legacy cache\000Local memory prefetch accesses\00=
0legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D121167 */
+/* offset=3D121125 */
 "node-read\000legacy cache\000Local memory read accesses\000legacy-cache-c=
onfig=3D6\000\00010\000\000\000\000\000"
-/* offset=3D121247 */
+/* offset=3D121205 */
 "node-read-access\000legacy cache\000Local memory read accesses\000legacy-=
cache-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D121334 */
+/* offset=3D121292 */
 "node-read-miss\000legacy cache\000Local memory read misses\000legacy-cach=
e-config=3D0x10006\000\00010\000\000\000\000\000"
-/* offset=3D121423 */
+/* offset=3D121381 */
 "node-read-misses\000legacy cache\000Local memory read misses\000legacy-ca=
che-config=3D0x10006\000\00010\000\000\000\000\000"
-/* offset=3D121514 */
+/* offset=3D121472 */
 "node-read-ops\000legacy cache\000Local memory read accesses\000legacy-cac=
he-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D121598 */
+/* offset=3D121556 */
 "node-read-reference\000legacy cache\000Local memory read accesses\000lega=
cy-cache-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D121688 */
+/* offset=3D121646 */
 "node-read-refs\000legacy cache\000Local memory read accesses\000legacy-ca=
che-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D121773 */
+/* offset=3D121731 */
 "node-reference\000legacy cache\000Local memory read accesses\000legacy-ca=
che-config=3D6\000\00010\000\000\000\000\000"
-/* offset=3D121858 */
+/* offset=3D121816 */
 "node-refs\000legacy cache\000Local memory read accesses\000legacy-cache-c=
onfig=3D6\000\00010\000\000\000\000\000"
-/* offset=3D121938 */
+/* offset=3D121896 */
 "node-speculative-load\000legacy cache\000Local memory prefetch accesses\0=
00legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D122038 */
+/* offset=3D121996 */
 "node-speculative-load-access\000legacy cache\000Local memory prefetch acc=
esses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D122145 */
+/* offset=3D122103 */
 "node-speculative-load-miss\000legacy cache\000Local memory prefetch misse=
s\000legacy-cache-config=3D0x10206\000\00010\000\000\000\000\000"
-/* offset=3D122250 */
+/* offset=3D122208 */
 "node-speculative-load-misses\000legacy cache\000Local memory prefetch mis=
ses\000legacy-cache-config=3D0x10206\000\00010\000\000\000\000\000"
-/* offset=3D122357 */
+/* offset=3D122315 */
 "node-speculative-load-ops\000legacy cache\000Local memory prefetch access=
es\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D122461 */
+/* offset=3D122419 */
 "node-speculative-load-reference\000legacy cache\000Local memory prefetch =
accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D122571 */
+/* offset=3D122529 */
 "node-speculative-load-refs\000legacy cache\000Local memory prefetch acces=
ses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D122676 */
+/* offset=3D122634 */
 "node-speculative-read\000legacy cache\000Local memory prefetch accesses\0=
00legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D122776 */
+/* offset=3D122734 */
 "node-speculative-read-access\000legacy cache\000Local memory prefetch acc=
esses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D122883 */
+/* offset=3D122841 */
 "node-speculative-read-miss\000legacy cache\000Local memory prefetch misse=
s\000legacy-cache-config=3D0x10206\000\00010\000\000\000\000\000"
-/* offset=3D122988 */
+/* offset=3D122946 */
 "node-speculative-read-misses\000legacy cache\000Local memory prefetch mis=
ses\000legacy-cache-config=3D0x10206\000\00010\000\000\000\000\000"
-/* offset=3D123095 */
+/* offset=3D123053 */
 "node-speculative-read-ops\000legacy cache\000Local memory prefetch access=
es\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D123199 */
+/* offset=3D123157 */
 "node-speculative-read-reference\000legacy cache\000Local memory prefetch =
accesses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D123309 */
+/* offset=3D123267 */
 "node-speculative-read-refs\000legacy cache\000Local memory prefetch acces=
ses\000legacy-cache-config=3D0x206\000\00010\000\000\000\000\000"
-/* offset=3D123414 */
+/* offset=3D123372 */
 "node-store\000legacy cache\000Local memory write accesses\000legacy-cache=
-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D123500 */
+/* offset=3D123458 */
 "node-store-access\000legacy cache\000Local memory write accesses\000legac=
y-cache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D123593 */
+/* offset=3D123551 */
 "node-store-miss\000legacy cache\000Local memory write misses\000legacy-ca=
che-config=3D0x10106\000\00010\000\000\000\000\000"
-/* offset=3D123684 */
+/* offset=3D123642 */
 "node-store-misses\000legacy cache\000Local memory write misses\000legacy-=
cache-config=3D0x10106\000\00000\000\000\000\000\000"
-/* offset=3D123777 */
+/* offset=3D123735 */
 "node-store-ops\000legacy cache\000Local memory write accesses\000legacy-c=
ache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D123867 */
+/* offset=3D123825 */
 "node-store-reference\000legacy cache\000Local memory write accesses\000le=
gacy-cache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D123963 */
+/* offset=3D123921 */
 "node-store-refs\000legacy cache\000Local memory write accesses\000legacy-=
cache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D124054 */
+/* offset=3D124012 */
 "node-stores\000legacy cache\000Local memory write accesses\000legacy-cach=
e-config=3D0x106\000\00000\000\000\000\000\000"
-/* offset=3D124141 */
+/* offset=3D124099 */
 "node-stores-access\000legacy cache\000Local memory write accesses\000lega=
cy-cache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D124235 */
+/* offset=3D124193 */
 "node-stores-miss\000legacy cache\000Local memory write misses\000legacy-c=
ache-config=3D0x10106\000\00010\000\000\000\000\000"
-/* offset=3D124327 */
+/* offset=3D124285 */
 "node-stores-misses\000legacy cache\000Local memory write misses\000legacy=
-cache-config=3D0x10106\000\00010\000\000\000\000\000"
-/* offset=3D124421 */
+/* offset=3D124379 */
 "node-stores-ops\000legacy cache\000Local memory write accesses\000legacy-=
cache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D124512 */
+/* offset=3D124470 */
 "node-stores-reference\000legacy cache\000Local memory write accesses\000l=
egacy-cache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D124609 */
+/* offset=3D124567 */
 "node-stores-refs\000legacy cache\000Local memory write accesses\000legacy=
-cache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D124701 */
+/* offset=3D124659 */
 "node-write\000legacy cache\000Local memory write accesses\000legacy-cache=
-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D124787 */
+/* offset=3D124745 */
 "node-write-access\000legacy cache\000Local memory write accesses\000legac=
y-cache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D124880 */
+/* offset=3D124838 */
 "node-write-miss\000legacy cache\000Local memory write misses\000legacy-ca=
che-config=3D0x10106\000\00010\000\000\000\000\000"
-/* offset=3D124971 */
+/* offset=3D124929 */
 "node-write-misses\000legacy cache\000Local memory write misses\000legacy-=
cache-config=3D0x10106\000\00010\000\000\000\000\000"
-/* offset=3D125064 */
+/* offset=3D125022 */
 "node-write-ops\000legacy cache\000Local memory write accesses\000legacy-c=
ache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D125154 */
+/* offset=3D125112 */
 "node-write-reference\000legacy cache\000Local memory write accesses\000le=
gacy-cache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D125250 */
+/* offset=3D125208 */
 "node-write-refs\000legacy cache\000Local memory write accesses\000legacy-=
cache-config=3D0x106\000\00010\000\000\000\000\000"
-/* offset=3D125341 */
+/* offset=3D125299 */
 "num_cores\000tool\000Number of cores. A core consists of 1 or more thread=
, with each thread being associated with a logical Linux CPU\000config=3D5\=
000\00000\000\000\000\000\000"
-/* offset=3D125486 */
+/* offset=3D125444 */
 "num_cpus\000tool\000Number of logical Linux CPUs. There may be multiple s=
uch CPUs on a core\000config=3D6\000\00000\000\000\000\000\000"
-/* offset=3D125589 */
+/* offset=3D125547 */
 "num_cpus_online\000tool\000Number of online logical Linux CPUs. There may=
 be multiple such CPUs on a core\000config=3D7\000\00000\000\000\000\000\00=
0"
-/* offset=3D125706 */
+/* offset=3D125664 */
 "num_dies\000tool\000Number of dies. Each die has 1 or more cores\000confi=
g=3D8\000\00000\000\000\000\000\000"
-/* offset=3D125782 */
+/* offset=3D125740 */
 "num_packages\000tool\000Number of packages. Each package has 1 or more di=
e\000config=3D9\000\00000\000\000\000\000\000"
-/* offset=3D125868 */
+/* offset=3D125826 */
 "page-faults\000software\000Number of page faults [This event is an alias =
of faults]\000config=3D2\000\00000\000\000\000\000\000"
-/* offset=3D125963 */
+/* offset=3D125921 */
 "ref-cycles\000legacy hardware\000Total cycles; not affected by CPU freque=
ncy scaling\000legacy-hardware-config=3D9\000\00000\000\000\000\000\000"
-/* offset=3D126075 */
+/* offset=3D126033 */
 "segment_reg_loads.any\000other\000Number of segment register loads\000eve=
nt=3D6,period=3D200000,umask=3D0x80\000\00000\000\000\000\000\000"
-/* offset=3D126177 */
+/* offset=3D126135 */
 "slots\000tool\000Number of functional units that in parallel can execute =
parts of an instruction\000config=3D0xa\000\00000\000\000\000\000\000"
-/* offset=3D126287 */
+/* offset=3D126245 */
 "smt_on\000tool\0001 if simultaneous multithreading (aka hyperthreading) i=
s enable otherwise 0\000config=3D0xb\000\00000\000\000\000\000\000"
-/* offset=3D126394 */
-"software\000"
-/* offset=3D126403 */
+/* offset=3D126352 */
 "stalled-cycles-backend\000legacy hardware\000Stalled cycles during retire=
ment [This event is an alias of idle-cycles-backend]\000legacy-hardware-con=
fig=3D8\000\00000\000\000\000\000\000"
-/* offset=3D126556 */
+/* offset=3D126505 */
 "stalled-cycles-frontend\000legacy hardware\000Stalled cycles during issue=
 [This event is an alias of idle-cycles-frontend]\000legacy-hardware-config=
=3D7\000\00000\000\000\000\000\000"
-/* offset=3D126706 */
+/* offset=3D126655 */
 "sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\000config=3D0x=
2c\0000x01\00000\000\000\000\000\000"
-/* offset=3D126783 */
+/* offset=3D126732 */
 "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache misses in firs=
t lookup result (high priority)\000eventid=3D1,type=3D5\000(434|436|43c|43a=
).*\00000\000\000\000\000\000"
-/* offset=3D126926 */
+/* offset=3D126875 */
 "sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles event\000event=3D0=
x2b\000v8\00000\000\000\000\000\000"
-/* offset=3D127002 */
+/* offset=3D126951 */
 "system_time\000tool\000System/kernel time in nanoseconds\000config=3D3\00=
0\00000\000\000\000\000\000"
-/* offset=3D127070 */
+/* offset=3D127019 */
 "system_tsc_freq\000tool\000The amount a Time Stamp Counter (TSC) increase=
s per second\000config=3D0xc\000\00000\000\000\000\000\000"
-/* offset=3D127169 */
+/* offset=3D127118 */
 "target_cpu\000tool\0001 if CPUs being analyzed, 0 if threads/processes\00=
0config=3D0xe\000\00000\000\000\000\000\000"
-/* offset=3D127253 */
+/* offset=3D127202 */
 "task-clock\000software\000Per-task high-resolution timer based event\000c=
onfig=3D1\000\000001e-6msec\000\000\000\000\000"
-/* offset=3D127341 */
-"tool\000"
-/* offset=3D127346 */
+/* offset=3D127290 */
 "unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-core snoop resul=
ted from L3 Eviction which misses in some processor core\000event=3D0x22,um=
ask=3D0x81\000\00000\000\000\000\000\000"
-/* offset=3D127500 */
-"uncore_cbox\000"
-/* offset=3D127512 */
+/* offset=3D127444 */
 "uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands\000event=3D2\=
000\00000\000\000\000\000\000"
-/* offset=3D127582 */
+/* offset=3D127514 */
 "uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\000event=3D7\00=
0\00000\000\000\000\000\000"
-/* offset=3D127650 */
-"uncore_imc\000"
-/* offset=3D127661 */
+/* offset=3D127582 */
 "uncore_imc.cache_hits\000uncore\000Total cache hits\000event=3D0x34\000\0=
0000\000\000\000\000\000"
-/* offset=3D127726 */
-"uncore_imc_free_running\000"
-/* offset=3D127750 */
+/* offset=3D127647 */
 "uncore_imc_free_running.cache_miss\000uncore\000Total cache misses\000eve=
nt=3D0x12\000\00000\000\000\000\000\000"
-/* offset=3D127830 */
-"uncore_sys_ccn_pmu\000"
-/* offset=3D127849 */
-"uncore_sys_cmn_pmu\000"
-/* offset=3D127868 */
-"uncore_sys_ddr_pmu\000"
-/* offset=3D127887 */
+/* offset=3D127727 */
 "user_time\000tool\000User (non-kernel) time in nanoseconds\000config=3D2\=
000\00000\000\000\000\000\000"
-/* offset=3D127957 */
+/* offset=3D127797 */
 "CPI\000\0001 / IPC\000\000\000\000\000\000\000\000000"
-/* offset=3D127980 */
+/* offset=3D127820 */
 "CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=3Dcpu\\-clock@=
 if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@) / (dur=
ation_time * 1e9)\000\000Average CPU utilization\000\0001CPUs\000\000\000\0=
00011"
-/* offset=3D128166 */
+/* offset=3D128006 */
 "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\000\000\000\=
000\000\000\000\000000"
-/* offset=3D128231 */
+/* offset=3D128071 */
 "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit +=
 l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000"
-/* offset=3D128326 */
+/* offset=3D128166 */
 "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd - l2_rqsts.dema=
nd_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000\000\000\000\0=
00\000\000\000000"
-/* offset=3D128461 */
+/* offset=3D128301 */
 "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2_All)\000\000\=
000\000\000\000\000\000000"
-/* offset=3D128530 */
+/* offset=3D128370 */
 "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_L2_All)\000\00=
0\000\000\000\000\000\000000"
-/* offset=3D128601 */
+/* offset=3D128441 */
 "Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * (cpu_clk_unh=
alted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalt=
ed.ref_xclk)))\000\000\000\000\000\000\000\000000"
-/* offset=3D128768 */
+/* offset=3D128608 */
 "IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\000\000\000\0=
00\000\000\000\000000"
-/* offset=3D128832 */
+/* offset=3D128672 */
 "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duration_time\000\0=
00\000\000\000\000\000\000000"
-/* offset=3D128904 */
+/* offset=3D128744 */
 "M1\000\000ipc + M2\000\000\000\000\000\000\000\000000"
-/* offset=3D128927 */
+/* offset=3D128767 */
 "M2\000\000ipc + M1\000\000\000\000\000\000\000\000000"
-/* offset=3D128950 */
+/* offset=3D128790 */
 "M3\000\0001 / M3\000\000\000\000\000\000\000\000000"
-/* offset=3D128971 */
+/* offset=3D128811 */
 "backend_cycles_idle\000Default\000(stalled\\-cycles\\-backend / cpu\\-cyc=
les if has_event(stalled\\-cycles\\-backend) else 0)\000backend_cycles_idle=
 > 0.2\000Backend stalls per cycle\000\000\000\000\000\000001"
-/* offset=3D129145 */
+/* offset=3D128985 */
 "branch_frequency\000Default\000branches / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Branches per CPU second\000\0001000M/sec\000\000\000\000011=
"
-/* offset=3D129325 */
+/* offset=3D129165 */
 "branch_miss_rate\000Default\000branch\\-misses / branches\000branch_miss_=
rate > 0.05\000Branch miss rate\000\000100%\000\000\000\000001"
-/* offset=3D129429 */
+/* offset=3D129269 */
 "cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_cycles\000\0=
00\000\000\000\000\000\000000"
-/* offset=3D129501 */
+/* offset=3D129341 */
 "cs_per_second\000Default\000software@context\\-switches\\,name\\=3Dcontex=
t\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #tar=
get_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\000\000Context=
 switches per CPU second\000\0001cs/sec\000\000\000\000011"
-/* offset=3D129734 */
+/* offset=3D129574 */
 "cycles_frequency\000Default\000cpu\\-cycles / (software@cpu\\-clock\\,nam=
e\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtas=
k\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\000\000\000011"
-/* offset=3D129910 */
+/* offset=3D129750 */
 "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.any\000\000\00=
0\000\000\000\000\000000"
-/* offset=3D129975 */
+/* offset=3D129815 */
 "dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses / dTLB\\-loads\000dtlb=
_miss_rate > 0.05\000dTLB miss rate\000\000100%\000\000\000\000001"
-/* offset=3D130081 */
+/* offset=3D129921 */
 "frontend_cycles_idle\000Default\000(stalled\\-cycles\\-frontend / cpu\\-c=
ycles if has_event(stalled\\-cycles\\-frontend) else 0)\000frontend_cycles_=
idle > 0.1\000Frontend stalls per cycle\000\000\000\000\000\000001"
-/* offset=3D130260 */
+/* offset=3D130100 */
 "icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired.any\000\000=
\000\000\000\000\000\000000"
-/* offset=3D130328 */
+/* offset=3D130168 */
 "insn_per_cycle\000Default\000instructions / cpu\\-cycles\000insn_per_cycl=
e < 1\000Instructions Per Cycle\000\0001instructions\000\000\000\000001"
-/* offset=3D130441 */
+/* offset=3D130281 */
 "itlb_miss_rate\000Default3\000iTLB\\-load\\-misses / iTLB\\-loads\000itlb=
_miss_rate > 0.05\000iTLB miss rate\000\000100%\000\000\000\000001"
-/* offset=3D130547 */
+/* offset=3D130387 */
 "l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-prefetch\\-misses / L1=
\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0.05\000L1 prefetch miss =
rate\000\000100%\000\000\000\000001"
-/* offset=3D130695 */
+/* offset=3D130535 */
 "l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-misses / L1\\-dcache\\-=
loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000\000100%\000\000\000\000=
001"
-/* offset=3D130811 */
+/* offset=3D130651 */
 "l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-misses / L1\\-icache\\-=
loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\000100%\000\000\000\0000=
01"
-/* offset=3D130926 */
+/* offset=3D130766 */
 "llc_miss_rate\000Default2\000LLC\\-load\\-misses / LLC\\-loads\000llc_mis=
s_rate > 0.05\000LLC miss rate\000\000100%\000\000\000\000001"
-/* offset=3D131027 */
+/* offset=3D130867 */
 "migrations_per_second\000Default\000software@cpu\\-migrations\\,name\\=3D=
cpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if =
#target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\000\000Pro=
cess migrations to a new CPU per CPU second\000\0001migrations/sec\000\000\=
000\000011"
-/* offset=3D131287 */
+/* offset=3D131127 */
 "page_faults_per_second\000Default\000software@page\\-faults\\,name\\=3Dpa=
ge\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #targ=
et_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\000\000Page fau=
lts per CPU second\000\0001faults/sec\000\000\000\000011"
-/* offset=3D131518 */
+/* offset=3D131358 */
 "stalled_cycles_per_instruction\000Default\000(max(stalled\\-cycles\\-fron=
tend, stalled\\-cycles\\-backend) / instructions if has_event(stalled\\-cyc=
les\\-frontend) & has_event(stalled\\-cycles\\-backend) else (stalled\\-cyc=
les\\-frontend / instructions if has_event(stalled\\-cycles\\-frontend) els=
e (stalled\\-cycles\\-backend / instructions if has_event(stalled\\-cycles\=
\-backend) else 0)))\000\000Max front or backend stalls per instruction\000=
\000\000\000\000\000001"
 ;
=20
@@ -3259,1865 +3237,1865 @@ static const struct compact_pmu_event pmu_event=
s__common_default_core[] =3D {
 	/* data-tlb-write-refs\000legacy cache\000Data TLB write accesses\000lega=
cy-cache-c... */
 	{ 29578 },
 	/* dtlb\000legacy cache\000Data TLB read accesses\000legacy-cache-config=
=3D3\000\0001... */
-	{ 29815 },
+	{ 29802 },
 	/* dtlb-access\000legacy cache\000Data TLB read accesses\000legacy-cache-=
config=3D3\0... */
-	{ 29886 },
+	{ 29873 },
 	/* dtlb-load\000legacy cache\000Data TLB read accesses\000legacy-cache-co=
nfig=3D3\000... */
-	{ 29964 },
+	{ 29951 },
 	/* dtlb-load-access\000legacy cache\000Data TLB read accesses\000legacy-c=
ache-confi... */
-	{ 30040 },
+	{ 30027 },
 	/* dtlb-load-miss\000legacy cache\000Data TLB read misses\000legacy-cache=
-config=3D0x... */
-	{ 30123 },
+	{ 30110 },
 	/* dtlb-load-misses\000legacy cache\000Data TLB read misses\000legacy-cac=
he-config=3D... */
-	{ 30208 },
+	{ 30195 },
 	/* dtlb-load-ops\000legacy cache\000Data TLB read accesses\000legacy-cach=
e-config=3D3... */
-	{ 30295 },
+	{ 30282 },
 	/* dtlb-load-reference\000legacy cache\000Data TLB read accesses\000legac=
y-cache-co... */
-	{ 30375 },
+	{ 30362 },
 	/* dtlb-load-refs\000legacy cache\000Data TLB read accesses\000legacy-cac=
he-config=3D... */
-	{ 30461 },
+	{ 30448 },
 	/* dtlb-loads\000legacy cache\000Data TLB read accesses\000legacy-cache-c=
onfig=3D3\00... */
-	{ 30542 },
+	{ 30529 },
 	/* dtlb-loads-access\000legacy cache\000Data TLB read accesses\000legacy-=
cache-conf... */
-	{ 30619 },
+	{ 30606 },
 	/* dtlb-loads-miss\000legacy cache\000Data TLB read misses\000legacy-cach=
e-config=3D0... */
-	{ 30703 },
+	{ 30690 },
 	/* dtlb-loads-misses\000legacy cache\000Data TLB read misses\000legacy-ca=
che-config... */
-	{ 30789 },
+	{ 30776 },
 	/* dtlb-loads-ops\000legacy cache\000Data TLB read accesses\000legacy-cac=
he-config=3D... */
-	{ 30877 },
+	{ 30864 },
 	/* dtlb-loads-reference\000legacy cache\000Data TLB read accesses\000lega=
cy-cache-c... */
-	{ 30958 },
+	{ 30945 },
 	/* dtlb-loads-refs\000legacy cache\000Data TLB read accesses\000legacy-ca=
che-config... */
-	{ 31045 },
+	{ 31032 },
 	/* dtlb-miss\000legacy cache\000Data TLB read misses\000legacy-cache-conf=
ig=3D0x10003... */
-	{ 31127 },
+	{ 31114 },
 	/* dtlb-misses\000legacy cache\000Data TLB read misses\000legacy-cache-co=
nfig=3D0x100... */
-	{ 31207 },
+	{ 31194 },
 	/* dtlb-ops\000legacy cache\000Data TLB read accesses\000legacy-cache-con=
fig=3D3\000\... */
-	{ 31289 },
+	{ 31276 },
 	/* dtlb-prefetch\000legacy cache\000Data TLB prefetch accesses\000legacy-=
cache-conf... */
-	{ 31364 },
+	{ 31351 },
 	/* dtlb-prefetch-access\000legacy cache\000Data TLB prefetch accesses\000=
legacy-cac... */
-	{ 31452 },
+	{ 31439 },
 	/* dtlb-prefetch-miss\000legacy cache\000Data TLB prefetch misses\000lega=
cy-cache-c... */
-	{ 31547 },
+	{ 31534 },
 	/* dtlb-prefetch-misses\000legacy cache\000Data TLB prefetch misses\000le=
gacy-cache... */
-	{ 31640 },
+	{ 31627 },
 	/* dtlb-prefetch-ops\000legacy cache\000Data TLB prefetch accesses\000leg=
acy-cache-... */
-	{ 31735 },
+	{ 31722 },
 	/* dtlb-prefetch-reference\000legacy cache\000Data TLB prefetch accesses\=
000legacy-... */
-	{ 31827 },
+	{ 31814 },
 	/* dtlb-prefetch-refs\000legacy cache\000Data TLB prefetch accesses\000le=
gacy-cache... */
-	{ 31925 },
+	{ 31912 },
 	/* dtlb-prefetches\000legacy cache\000Data TLB prefetch accesses\000legac=
y-cache-co... */
-	{ 32018 },
+	{ 32005 },
 	/* dtlb-prefetches-access\000legacy cache\000Data TLB prefetch accesses\0=
00legacy-c... */
-	{ 32108 },
+	{ 32095 },
 	/* dtlb-prefetches-miss\000legacy cache\000Data TLB prefetch misses\000le=
gacy-cache... */
-	{ 32205 },
+	{ 32192 },
 	/* dtlb-prefetches-misses\000legacy cache\000Data TLB prefetch misses\000=
legacy-cac... */
-	{ 32300 },
+	{ 32287 },
 	/* dtlb-prefetches-ops\000legacy cache\000Data TLB prefetch accesses\000l=
egacy-cach... */
-	{ 32397 },
+	{ 32384 },
 	/* dtlb-prefetches-reference\000legacy cache\000Data TLB prefetch accesse=
s\000legac... */
-	{ 32491 },
+	{ 32478 },
 	/* dtlb-prefetches-refs\000legacy cache\000Data TLB prefetch accesses\000=
legacy-cac... */
-	{ 32591 },
+	{ 32578 },
 	/* dtlb-read\000legacy cache\000Data TLB read accesses\000legacy-cache-co=
nfig=3D3\000... */
-	{ 32686 },
+	{ 32673 },
 	/* dtlb-read-access\000legacy cache\000Data TLB read accesses\000legacy-c=
ache-confi... */
-	{ 32762 },
+	{ 32749 },
 	/* dtlb-read-miss\000legacy cache\000Data TLB read misses\000legacy-cache=
-config=3D0x... */
-	{ 32845 },
+	{ 32832 },
 	/* dtlb-read-misses\000legacy cache\000Data TLB read misses\000legacy-cac=
he-config=3D... */
-	{ 32930 },
+	{ 32917 },
 	/* dtlb-read-ops\000legacy cache\000Data TLB read accesses\000legacy-cach=
e-config=3D3... */
-	{ 33017 },
+	{ 33004 },
 	/* dtlb-read-reference\000legacy cache\000Data TLB read accesses\000legac=
y-cache-co... */
-	{ 33097 },
+	{ 33084 },
 	/* dtlb-read-refs\000legacy cache\000Data TLB read accesses\000legacy-cac=
he-config=3D... */
-	{ 33183 },
+	{ 33170 },
 	/* dtlb-reference\000legacy cache\000Data TLB read accesses\000legacy-cac=
he-config=3D... */
-	{ 33264 },
+	{ 33251 },
 	/* dtlb-refs\000legacy cache\000Data TLB read accesses\000legacy-cache-co=
nfig=3D3\000... */
-	{ 33345 },
+	{ 33332 },
 	/* dtlb-speculative-load\000legacy cache\000Data TLB prefetch accesses\00=
0legacy-ca... */
-	{ 33421 },
+	{ 33408 },
 	/* dtlb-speculative-load-access\000legacy cache\000Data TLB prefetch acce=
sses\000le... */
-	{ 33517 },
+	{ 33504 },
 	/* dtlb-speculative-load-miss\000legacy cache\000Data TLB prefetch misses=
\000legacy... */
-	{ 33620 },
+	{ 33607 },
 	/* dtlb-speculative-load-misses\000legacy cache\000Data TLB prefetch miss=
es\000lega... */
-	{ 33721 },
+	{ 33708 },
 	/* dtlb-speculative-load-ops\000legacy cache\000Data TLB prefetch accesse=
s\000legac... */
-	{ 33824 },
+	{ 33811 },
 	/* dtlb-speculative-load-reference\000legacy cache\000Data TLB prefetch a=
ccesses\00... */
-	{ 33924 },
+	{ 33911 },
 	/* dtlb-speculative-load-refs\000legacy cache\000Data TLB prefetch access=
es\000lega... */
-	{ 34030 },
+	{ 34017 },
 	/* dtlb-speculative-read\000legacy cache\000Data TLB prefetch accesses\00=
0legacy-ca... */
-	{ 34131 },
+	{ 34118 },
 	/* dtlb-speculative-read-access\000legacy cache\000Data TLB prefetch acce=
sses\000le... */
-	{ 34227 },
+	{ 34214 },
 	/* dtlb-speculative-read-miss\000legacy cache\000Data TLB prefetch misses=
\000legacy... */
-	{ 34330 },
+	{ 34317 },
 	/* dtlb-speculative-read-misses\000legacy cache\000Data TLB prefetch miss=
es\000lega... */
-	{ 34431 },
+	{ 34418 },
 	/* dtlb-speculative-read-ops\000legacy cache\000Data TLB prefetch accesse=
s\000legac... */
-	{ 34534 },
+	{ 34521 },
 	/* dtlb-speculative-read-reference\000legacy cache\000Data TLB prefetch a=
ccesses\00... */
-	{ 34634 },
+	{ 34621 },
 	/* dtlb-speculative-read-refs\000legacy cache\000Data TLB prefetch access=
es\000lega... */
-	{ 34740 },
+	{ 34727 },
 	/* dtlb-store\000legacy cache\000Data TLB write accesses\000legacy-cache-=
config=3D0x1... */
-	{ 34841 },
+	{ 34828 },
 	/* dtlb-store-access\000legacy cache\000Data TLB write accesses\000legacy=
-cache-con... */
-	{ 34923 },
+	{ 34910 },
 	/* dtlb-store-miss\000legacy cache\000Data TLB write misses\000legacy-cac=
he-config=3D... */
-	{ 35012 },
+	{ 34999 },
 	/* dtlb-store-misses\000legacy cache\000Data TLB write misses\000legacy-c=
ache-confi... */
-	{ 35099 },
+	{ 35086 },
 	/* dtlb-store-ops\000legacy cache\000Data TLB write accesses\000legacy-ca=
che-config... */
-	{ 35188 },
+	{ 35175 },
 	/* dtlb-store-reference\000legacy cache\000Data TLB write accesses\000leg=
acy-cache-... */
-	{ 35274 },
+	{ 35261 },
 	/* dtlb-store-refs\000legacy cache\000Data TLB write accesses\000legacy-c=
ache-confi... */
-	{ 35366 },
+	{ 35353 },
 	/* dtlb-stores\000legacy cache\000Data TLB write accesses\000legacy-cache=
-config=3D0x... */
-	{ 35453 },
+	{ 35440 },
 	/* dtlb-stores-access\000legacy cache\000Data TLB write accesses\000legac=
y-cache-co... */
-	{ 35536 },
+	{ 35523 },
 	/* dtlb-stores-miss\000legacy cache\000Data TLB write misses\000legacy-ca=
che-config... */
-	{ 35626 },
+	{ 35613 },
 	/* dtlb-stores-misses\000legacy cache\000Data TLB write misses\000legacy-=
cache-conf... */
-	{ 35714 },
+	{ 35701 },
 	/* dtlb-stores-ops\000legacy cache\000Data TLB write accesses\000legacy-c=
ache-confi... */
-	{ 35804 },
+	{ 35791 },
 	/* dtlb-stores-reference\000legacy cache\000Data TLB write accesses\000le=
gacy-cache... */
-	{ 35891 },
+	{ 35878 },
 	/* dtlb-stores-refs\000legacy cache\000Data TLB write accesses\000legacy-=
cache-conf... */
-	{ 35984 },
+	{ 35971 },
 	/* dtlb-write\000legacy cache\000Data TLB write accesses\000legacy-cache-=
config=3D0x1... */
-	{ 36072 },
+	{ 36059 },
 	/* dtlb-write-access\000legacy cache\000Data TLB write accesses\000legacy=
-cache-con... */
-	{ 36154 },
+	{ 36141 },
 	/* dtlb-write-miss\000legacy cache\000Data TLB write misses\000legacy-cac=
he-config=3D... */
-	{ 36243 },
+	{ 36230 },
 	/* dtlb-write-misses\000legacy cache\000Data TLB write misses\000legacy-c=
ache-confi... */
-	{ 36330 },
+	{ 36317 },
 	/* dtlb-write-ops\000legacy cache\000Data TLB write accesses\000legacy-ca=
che-config... */
-	{ 36419 },
+	{ 36406 },
 	/* dtlb-write-reference\000legacy cache\000Data TLB write accesses\000leg=
acy-cache-... */
-	{ 36505 },
+	{ 36492 },
 	/* dtlb-write-refs\000legacy cache\000Data TLB write accesses\000legacy-c=
ache-confi... */
-	{ 36597 },
+	{ 36584 },
 	/* i-tlb\000legacy cache\000Instruction TLB read accesses\000legacy-cache=
-config=3D4\... */
-	{ 37397 },
+	{ 37355 },
 	/* i-tlb-access\000legacy cache\000Instruction TLB read accesses\000legac=
y-cache-co... */
-	{ 37476 },
+	{ 37434 },
 	/* i-tlb-load\000legacy cache\000Instruction TLB read accesses\000legacy-=
cache-conf... */
-	{ 37562 },
+	{ 37520 },
 	/* i-tlb-load-access\000legacy cache\000Instruction TLB read accesses\000=
legacy-cac... */
-	{ 37646 },
+	{ 37604 },
 	/* i-tlb-load-miss\000legacy cache\000Instruction TLB read misses\000lega=
cy-cache-c... */
-	{ 37737 },
+	{ 37695 },
 	/* i-tlb-load-misses\000legacy cache\000Instruction TLB read misses\000le=
gacy-cache... */
-	{ 37830 },
+	{ 37788 },
 	/* i-tlb-load-ops\000legacy cache\000Instruction TLB read accesses\000leg=
acy-cache-... */
-	{ 37925 },
+	{ 37883 },
 	/* i-tlb-load-reference\000legacy cache\000Instruction TLB read accesses\=
000legacy-... */
-	{ 38013 },
+	{ 37971 },
 	/* i-tlb-load-refs\000legacy cache\000Instruction TLB read accesses\000le=
gacy-cache... */
-	{ 38107 },
+	{ 38065 },
 	/* i-tlb-loads\000legacy cache\000Instruction TLB read accesses\000legacy=
-cache-con... */
-	{ 38196 },
+	{ 38154 },
 	/* i-tlb-loads-access\000legacy cache\000Instruction TLB read accesses\00=
0legacy-ca... */
-	{ 38281 },
+	{ 38239 },
 	/* i-tlb-loads-miss\000legacy cache\000Instruction TLB read misses\000leg=
acy-cache-... */
-	{ 38373 },
+	{ 38331 },
 	/* i-tlb-loads-misses\000legacy cache\000Instruction TLB read misses\000l=
egacy-cach... */
-	{ 38467 },
+	{ 38425 },
 	/* i-tlb-loads-ops\000legacy cache\000Instruction TLB read accesses\000le=
gacy-cache... */
-	{ 38563 },
+	{ 38521 },
 	/* i-tlb-loads-reference\000legacy cache\000Instruction TLB read accesses=
\000legacy... */
-	{ 38652 },
+	{ 38610 },
 	/* i-tlb-loads-refs\000legacy cache\000Instruction TLB read accesses\000l=
egacy-cach... */
-	{ 38747 },
+	{ 38705 },
 	/* i-tlb-miss\000legacy cache\000Instruction TLB read misses\000legacy-ca=
che-config... */
-	{ 38837 },
+	{ 38795 },
 	/* i-tlb-misses\000legacy cache\000Instruction TLB read misses\000legacy-=
cache-conf... */
-	{ 38925 },
+	{ 38883 },
 	/* i-tlb-ops\000legacy cache\000Instruction TLB read accesses\000legacy-c=
ache-confi... */
-	{ 39015 },
+	{ 38973 },
 	/* i-tlb-read\000legacy cache\000Instruction TLB read accesses\000legacy-=
cache-conf... */
-	{ 39098 },
+	{ 39056 },
 	/* i-tlb-read-access\000legacy cache\000Instruction TLB read accesses\000=
legacy-cac... */
-	{ 39182 },
+	{ 39140 },
 	/* i-tlb-read-miss\000legacy cache\000Instruction TLB read misses\000lega=
cy-cache-c... */
-	{ 39273 },
+	{ 39231 },
 	/* i-tlb-read-misses\000legacy cache\000Instruction TLB read misses\000le=
gacy-cache... */
-	{ 39366 },
+	{ 39324 },
 	/* i-tlb-read-ops\000legacy cache\000Instruction TLB read accesses\000leg=
acy-cache-... */
-	{ 39461 },
+	{ 39419 },
 	/* i-tlb-read-reference\000legacy cache\000Instruction TLB read accesses\=
000legacy-... */
-	{ 39549 },
+	{ 39507 },
 	/* i-tlb-read-refs\000legacy cache\000Instruction TLB read accesses\000le=
gacy-cache... */
-	{ 39643 },
+	{ 39601 },
 	/* i-tlb-reference\000legacy cache\000Instruction TLB read accesses\000le=
gacy-cache... */
-	{ 39732 },
+	{ 39690 },
 	/* i-tlb-refs\000legacy cache\000Instruction TLB read accesses\000legacy-=
cache-conf... */
-	{ 39821 },
+	{ 39779 },
 	/* idle-cycles-backend\000legacy hardware\000Stalled cycles during retire=
ment [This... */
-	{ 39905 },
+	{ 39863 },
 	/* idle-cycles-frontend\000legacy hardware\000Stalled cycles during issue=
 [This eve... */
-	{ 40058 },
+	{ 40016 },
 	/* instruction-tlb\000legacy cache\000Instruction TLB read accesses\000le=
gacy-cache... */
-	{ 40208 },
+	{ 40166 },
 	/* instruction-tlb-access\000legacy cache\000Instruction TLB read accesse=
s\000legac... */
-	{ 40297 },
+	{ 40255 },
 	/* instruction-tlb-load\000legacy cache\000Instruction TLB read accesses\=
000legacy-... */
-	{ 40393 },
+	{ 40351 },
 	/* instruction-tlb-load-access\000legacy cache\000Instruction TLB read ac=
cesses\000... */
-	{ 40487 },
+	{ 40445 },
 	/* instruction-tlb-load-miss\000legacy cache\000Instruction TLB read miss=
es\000lega... */
-	{ 40588 },
+	{ 40546 },
 	/* instruction-tlb-load-misses\000legacy cache\000Instruction TLB read mi=
sses\000le... */
-	{ 40691 },
+	{ 40649 },
 	/* instruction-tlb-load-ops\000legacy cache\000Instruction TLB read acces=
ses\000leg... */
-	{ 40796 },
+	{ 40754 },
 	/* instruction-tlb-load-reference\000legacy cache\000Instruction TLB read=
 accesses\... */
-	{ 40894 },
+	{ 40852 },
 	/* instruction-tlb-load-refs\000legacy cache\000Instruction TLB read acce=
sses\000le... */
-	{ 40998 },
+	{ 40956 },
 	/* instruction-tlb-loads\000legacy cache\000Instruction TLB read accesses=
\000legacy... */
-	{ 41097 },
+	{ 41055 },
 	/* instruction-tlb-loads-access\000legacy cache\000Instruction TLB read a=
ccesses\00... */
-	{ 41192 },
+	{ 41150 },
 	/* instruction-tlb-loads-miss\000legacy cache\000Instruction TLB read mis=
ses\000leg... */
-	{ 41294 },
+	{ 41252 },
 	/* instruction-tlb-loads-misses\000legacy cache\000Instruction TLB read m=
isses\000l... */
-	{ 41398 },
+	{ 41356 },
 	/* instruction-tlb-loads-ops\000legacy cache\000Instruction TLB read acce=
sses\000le... */
-	{ 41504 },
+	{ 41462 },
 	/* instruction-tlb-loads-reference\000legacy cache\000Instruction TLB rea=
d accesses... */
-	{ 41603 },
+	{ 41561 },
 	/* instruction-tlb-loads-refs\000legacy cache\000Instruction TLB read acc=
esses\000l... */
-	{ 41708 },
+	{ 41666 },
 	/* instruction-tlb-miss\000legacy cache\000Instruction TLB read misses\00=
0legacy-ca... */
-	{ 41808 },
+	{ 41766 },
 	/* instruction-tlb-misses\000legacy cache\000Instruction TLB read misses\=
000legacy-... */
-	{ 41906 },
+	{ 41864 },
 	/* instruction-tlb-ops\000legacy cache\000Instruction TLB read accesses\0=
00legacy-c... */
-	{ 42006 },
+	{ 41964 },
 	/* instruction-tlb-read\000legacy cache\000Instruction TLB read accesses\=
000legacy-... */
-	{ 42099 },
+	{ 42057 },
 	/* instruction-tlb-read-access\000legacy cache\000Instruction TLB read ac=
cesses\000... */
-	{ 42193 },
+	{ 42151 },
 	/* instruction-tlb-read-miss\000legacy cache\000Instruction TLB read miss=
es\000lega... */
-	{ 42294 },
+	{ 42252 },
 	/* instruction-tlb-read-misses\000legacy cache\000Instruction TLB read mi=
sses\000le... */
-	{ 42397 },
+	{ 42355 },
 	/* instruction-tlb-read-ops\000legacy cache\000Instruction TLB read acces=
ses\000leg... */
-	{ 42502 },
+	{ 42460 },
 	/* instruction-tlb-read-reference\000legacy cache\000Instruction TLB read=
 accesses\... */
-	{ 42600 },
+	{ 42558 },
 	/* instruction-tlb-read-refs\000legacy cache\000Instruction TLB read acce=
sses\000le... */
-	{ 42704 },
+	{ 42662 },
 	/* instruction-tlb-reference\000legacy cache\000Instruction TLB read acce=
sses\000le... */
-	{ 42803 },
+	{ 42761 },
 	/* instruction-tlb-refs\000legacy cache\000Instruction TLB read accesses\=
000legacy-... */
-	{ 42902 },
+	{ 42860 },
 	/* instructions\000legacy hardware\000Retired instructions. Be careful, t=
hese can b... */
-	{ 42996 },
+	{ 42954 },
 	/* itlb\000legacy cache\000Instruction TLB read accesses\000legacy-cache-=
config=3D4\0... */
-	{ 43172 },
+	{ 43130 },
 	/* itlb-access\000legacy cache\000Instruction TLB read accesses\000legacy=
-cache-con... */
-	{ 43250 },
+	{ 43208 },
 	/* itlb-load\000legacy cache\000Instruction TLB read accesses\000legacy-c=
ache-confi... */
-	{ 43335 },
+	{ 43293 },
 	/* itlb-load-access\000legacy cache\000Instruction TLB read accesses\000l=
egacy-cach... */
-	{ 43418 },
+	{ 43376 },
 	/* itlb-load-miss\000legacy cache\000Instruction TLB read misses\000legac=
y-cache-co... */
-	{ 43508 },
+	{ 43466 },
 	/* itlb-load-misses\000legacy cache\000Instruction TLB read misses\000leg=
acy-cache-... */
-	{ 43600 },
+	{ 43558 },
 	/* itlb-load-ops\000legacy cache\000Instruction TLB read accesses\000lega=
cy-cache-c... */
-	{ 43694 },
+	{ 43652 },
 	/* itlb-load-reference\000legacy cache\000Instruction TLB read accesses\0=
00legacy-c... */
-	{ 43781 },
+	{ 43739 },
 	/* itlb-load-refs\000legacy cache\000Instruction TLB read accesses\000leg=
acy-cache-... */
-	{ 43874 },
+	{ 43832 },
 	/* itlb-loads\000legacy cache\000Instruction TLB read accesses\000legacy-=
cache-conf... */
-	{ 43962 },
+	{ 43920 },
 	/* itlb-loads-access\000legacy cache\000Instruction TLB read accesses\000=
legacy-cac... */
-	{ 44046 },
+	{ 44004 },
 	/* itlb-loads-miss\000legacy cache\000Instruction TLB read misses\000lega=
cy-cache-c... */
-	{ 44137 },
+	{ 44095 },
 	/* itlb-loads-misses\000legacy cache\000Instruction TLB read misses\000le=
gacy-cache... */
-	{ 44230 },
+	{ 44188 },
 	/* itlb-loads-ops\000legacy cache\000Instruction TLB read accesses\000leg=
acy-cache-... */
-	{ 44325 },
+	{ 44283 },
 	/* itlb-loads-reference\000legacy cache\000Instruction TLB read accesses\=
000legacy-... */
-	{ 44413 },
+	{ 44371 },
 	/* itlb-loads-refs\000legacy cache\000Instruction TLB read accesses\000le=
gacy-cache... */
-	{ 44507 },
+	{ 44465 },
 	/* itlb-miss\000legacy cache\000Instruction TLB read misses\000legacy-cac=
he-config=3D... */
-	{ 44596 },
+	{ 44554 },
 	/* itlb-misses\000legacy cache\000Instruction TLB read misses\000legacy-c=
ache-confi... */
-	{ 44683 },
+	{ 44641 },
 	/* itlb-ops\000legacy cache\000Instruction TLB read accesses\000legacy-ca=
che-config... */
-	{ 44772 },
+	{ 44730 },
 	/* itlb-read\000legacy cache\000Instruction TLB read accesses\000legacy-c=
ache-confi... */
-	{ 44854 },
+	{ 44812 },
 	/* itlb-read-access\000legacy cache\000Instruction TLB read accesses\000l=
egacy-cach... */
-	{ 44937 },
+	{ 44895 },
 	/* itlb-read-miss\000legacy cache\000Instruction TLB read misses\000legac=
y-cache-co... */
-	{ 45027 },
+	{ 44985 },
 	/* itlb-read-misses\000legacy cache\000Instruction TLB read misses\000leg=
acy-cache-... */
-	{ 45119 },
+	{ 45077 },
 	/* itlb-read-ops\000legacy cache\000Instruction TLB read accesses\000lega=
cy-cache-c... */
-	{ 45213 },
+	{ 45171 },
 	/* itlb-read-reference\000legacy cache\000Instruction TLB read accesses\0=
00legacy-c... */
-	{ 45300 },
+	{ 45258 },
 	/* itlb-read-refs\000legacy cache\000Instruction TLB read accesses\000leg=
acy-cache-... */
-	{ 45393 },
+	{ 45351 },
 	/* itlb-reference\000legacy cache\000Instruction TLB read accesses\000leg=
acy-cache-... */
-	{ 45481 },
+	{ 45439 },
 	/* itlb-refs\000legacy cache\000Instruction TLB read accesses\000legacy-c=
ache-confi... */
-	{ 45569 },
+	{ 45527 },
 	/* l1-d\000legacy cache\000Level 1 data cache read accesses\000legacy-cac=
he-config=3D... */
-	{ 45652 },
+	{ 45610 },
 	/* l1-d-access\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-... */
-	{ 45733 },
+	{ 45691 },
 	/* l1-d-load\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-co... */
-	{ 45821 },
+	{ 45779 },
 	/* l1-d-load-access\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-c... */
-	{ 45907 },
+	{ 45865 },
 	/* l1-d-load-miss\000legacy cache\000Level 1 data cache read misses\000le=
gacy-cache... */
-	{ 46000 },
+	{ 45958 },
 	/* l1-d-load-misses\000legacy cache\000Level 1 data cache read misses\000=
legacy-cac... */
-	{ 46095 },
+	{ 46053 },
 	/* l1-d-load-ops\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cach... */
-	{ 46192 },
+	{ 46150 },
 	/* l1-d-load-reference\000legacy cache\000Level 1 data cache read accesse=
s\000legac... */
-	{ 46282 },
+	{ 46240 },
 	/* l1-d-load-refs\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cac... */
-	{ 46378 },
+	{ 46336 },
 	/* l1-d-loads\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-c... */
-	{ 46469 },
+	{ 46427 },
 	/* l1-d-loads-access\000legacy cache\000Level 1 data cache read accesses\=
000legacy-... */
-	{ 46556 },
+	{ 46514 },
 	/* l1-d-loads-miss\000legacy cache\000Level 1 data cache read misses\000l=
egacy-cach... */
-	{ 46650 },
+	{ 46608 },
 	/* l1-d-loads-misses\000legacy cache\000Level 1 data cache read misses\00=
0legacy-ca... */
-	{ 46746 },
+	{ 46704 },
 	/* l1-d-loads-ops\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cac... */
-	{ 46844 },
+	{ 46802 },
 	/* l1-d-loads-reference\000legacy cache\000Level 1 data cache read access=
es\000lega... */
-	{ 46935 },
+	{ 46893 },
 	/* l1-d-loads-refs\000legacy cache\000Level 1 data cache read accesses\00=
0legacy-ca... */
-	{ 47032 },
+	{ 46990 },
 	/* l1-d-miss\000legacy cache\000Level 1 data cache read misses\000legacy-=
cache-conf... */
-	{ 47124 },
+	{ 47082 },
 	/* l1-d-misses\000legacy cache\000Level 1 data cache read misses\000legac=
y-cache-co... */
-	{ 47214 },
+	{ 47172 },
 	/* l1-d-ops\000legacy cache\000Level 1 data cache read accesses\000legacy=
-cache-con... */
-	{ 47306 },
+	{ 47264 },
 	/* l1-d-prefetch\000legacy cache\000Level 1 data cache prefetch accesses\=
000legacy-... */
-	{ 47391 },
+	{ 47349 },
 	/* l1-d-prefetch-access\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000... */
-	{ 47489 },
+	{ 47447 },
 	/* l1-d-prefetch-miss\000legacy cache\000Level 1 data cache prefetch miss=
es\000lega... */
-	{ 47594 },
+	{ 47552 },
 	/* l1-d-prefetch-misses\000legacy cache\000Level 1 data cache prefetch mi=
sses\000le... */
-	{ 47697 },
+	{ 47655 },
 	/* l1-d-prefetch-ops\000legacy cache\000Level 1 data cache prefetch acces=
ses\000leg... */
-	{ 47802 },
+	{ 47760 },
 	/* l1-d-prefetch-reference\000legacy cache\000Level 1 data cache prefetch=
 accesses\... */
-	{ 47904 },
+	{ 47862 },
 	/* l1-d-prefetch-refs\000legacy cache\000Level 1 data cache prefetch acce=
sses\000le... */
-	{ 48012 },
+	{ 47970 },
 	/* l1-d-prefetches\000legacy cache\000Level 1 data cache prefetch accesse=
s\000legac... */
-	{ 48115 },
+	{ 48073 },
 	/* l1-d-prefetches-access\000legacy cache\000Level 1 data cache prefetch =
accesses\0... */
-	{ 48215 },
+	{ 48173 },
 	/* l1-d-prefetches-miss\000legacy cache\000Level 1 data cache prefetch mi=
sses\000le... */
-	{ 48322 },
+	{ 48280 },
 	/* l1-d-prefetches-misses\000legacy cache\000Level 1 data cache prefetch =
misses\000... */
-	{ 48427 },
+	{ 48385 },
 	/* l1-d-prefetches-ops\000legacy cache\000Level 1 data cache prefetch acc=
esses\000l... */
-	{ 48534 },
+	{ 48492 },
 	/* l1-d-prefetches-reference\000legacy cache\000Level 1 data cache prefet=
ch accesse... */
-	{ 48638 },
+	{ 48596 },
 	/* l1-d-prefetches-refs\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000... */
-	{ 48748 },
+	{ 48706 },
 	/* l1-d-read\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-co... */
-	{ 48853 },
+	{ 48811 },
 	/* l1-d-read-access\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-c... */
-	{ 48939 },
+	{ 48897 },
 	/* l1-d-read-miss\000legacy cache\000Level 1 data cache read misses\000le=
gacy-cache... */
-	{ 49032 },
+	{ 48990 },
 	/* l1-d-read-misses\000legacy cache\000Level 1 data cache read misses\000=
legacy-cac... */
-	{ 49127 },
+	{ 49085 },
 	/* l1-d-read-ops\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cach... */
-	{ 49224 },
+	{ 49182 },
 	/* l1-d-read-reference\000legacy cache\000Level 1 data cache read accesse=
s\000legac... */
-	{ 49314 },
+	{ 49272 },
 	/* l1-d-read-refs\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cac... */
-	{ 49410 },
+	{ 49368 },
 	/* l1-d-reference\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cac... */
-	{ 49501 },
+	{ 49459 },
 	/* l1-d-refs\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-co... */
-	{ 49592 },
+	{ 49550 },
 	/* l1-d-speculative-load\000legacy cache\000Level 1 data cache prefetch a=
ccesses\00... */
-	{ 49678 },
+	{ 49636 },
 	/* l1-d-speculative-load-access\000legacy cache\000Level 1 data cache pre=
fetch acce... */
-	{ 49784 },
+	{ 49742 },
 	/* l1-d-speculative-load-miss\000legacy cache\000Level 1 data cache prefe=
tch misses... */
-	{ 49897 },
+	{ 49855 },
 	/* l1-d-speculative-load-misses\000legacy cache\000Level 1 data cache pre=
fetch miss... */
-	{ 50008 },
+	{ 49966 },
 	/* l1-d-speculative-load-ops\000legacy cache\000Level 1 data cache prefet=
ch accesse... */
-	{ 50121 },
+	{ 50079 },
 	/* l1-d-speculative-load-reference\000legacy cache\000Level 1 data cache =
prefetch a... */
-	{ 50231 },
+	{ 50189 },
 	/* l1-d-speculative-load-refs\000legacy cache\000Level 1 data cache prefe=
tch access... */
-	{ 50347 },
+	{ 50305 },
 	/* l1-d-speculative-read\000legacy cache\000Level 1 data cache prefetch a=
ccesses\00... */
-	{ 50458 },
+	{ 50416 },
 	/* l1-d-speculative-read-access\000legacy cache\000Level 1 data cache pre=
fetch acce... */
-	{ 50564 },
+	{ 50522 },
 	/* l1-d-speculative-read-miss\000legacy cache\000Level 1 data cache prefe=
tch misses... */
-	{ 50677 },
+	{ 50635 },
 	/* l1-d-speculative-read-misses\000legacy cache\000Level 1 data cache pre=
fetch miss... */
-	{ 50788 },
+	{ 50746 },
 	/* l1-d-speculative-read-ops\000legacy cache\000Level 1 data cache prefet=
ch accesse... */
-	{ 50901 },
+	{ 50859 },
 	/* l1-d-speculative-read-reference\000legacy cache\000Level 1 data cache =
prefetch a... */
-	{ 51011 },
+	{ 50969 },
 	/* l1-d-speculative-read-refs\000legacy cache\000Level 1 data cache prefe=
tch access... */
-	{ 51127 },
+	{ 51085 },
 	/* l1-d-store\000legacy cache\000Level 1 data cache write accesses\000leg=
acy-cache-... */
-	{ 51238 },
+	{ 51196 },
 	/* l1-d-store-access\000legacy cache\000Level 1 data cache write accesses=
\000legacy... */
-	{ 51330 },
+	{ 51288 },
 	/* l1-d-store-miss\000legacy cache\000Level 1 data cache write misses\000=
legacy-cac... */
-	{ 51429 },
+	{ 51387 },
 	/* l1-d-store-misses\000legacy cache\000Level 1 data cache write misses\0=
00legacy-c... */
-	{ 51526 },
+	{ 51484 },
 	/* l1-d-store-ops\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-ca... */
-	{ 51625 },
+	{ 51583 },
 	/* l1-d-store-reference\000legacy cache\000Level 1 data cache write acces=
ses\000leg... */
-	{ 51721 },
+	{ 51679 },
 	/* l1-d-store-refs\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-c... */
-	{ 51823 },
+	{ 51781 },
 	/* l1-d-stores\000legacy cache\000Level 1 data cache write accesses\000le=
gacy-cache... */
-	{ 51920 },
+	{ 51878 },
 	/* l1-d-stores-access\000legacy cache\000Level 1 data cache write accesse=
s\000legac... */
-	{ 52013 },
+	{ 51971 },
 	/* l1-d-stores-miss\000legacy cache\000Level 1 data cache write misses\00=
0legacy-ca... */
-	{ 52113 },
+	{ 52071 },
 	/* l1-d-stores-misses\000legacy cache\000Level 1 data cache write misses\=
000legacy-... */
-	{ 52211 },
+	{ 52169 },
 	/* l1-d-stores-ops\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-c... */
-	{ 52311 },
+	{ 52269 },
 	/* l1-d-stores-reference\000legacy cache\000Level 1 data cache write acce=
sses\000le... */
-	{ 52408 },
+	{ 52366 },
 	/* l1-d-stores-refs\000legacy cache\000Level 1 data cache write accesses\=
000legacy-... */
-	{ 52511 },
+	{ 52469 },
 	/* l1-d-write\000legacy cache\000Level 1 data cache write accesses\000leg=
acy-cache-... */
-	{ 52609 },
+	{ 52567 },
 	/* l1-d-write-access\000legacy cache\000Level 1 data cache write accesses=
\000legacy... */
-	{ 52701 },
+	{ 52659 },
 	/* l1-d-write-miss\000legacy cache\000Level 1 data cache write misses\000=
legacy-cac... */
-	{ 52800 },
+	{ 52758 },
 	/* l1-d-write-misses\000legacy cache\000Level 1 data cache write misses\0=
00legacy-c... */
-	{ 52897 },
+	{ 52855 },
 	/* l1-d-write-ops\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-ca... */
-	{ 52996 },
+	{ 52954 },
 	/* l1-d-write-reference\000legacy cache\000Level 1 data cache write acces=
ses\000leg... */
-	{ 53092 },
+	{ 53050 },
 	/* l1-d-write-refs\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-c... */
-	{ 53194 },
+	{ 53152 },
 	/* l1-data\000legacy cache\000Level 1 data cache read accesses\000legacy-=
cache-conf... */
-	{ 53291 },
+	{ 53249 },
 	/* l1-data-access\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cac... */
-	{ 53375 },
+	{ 53333 },
 	/* l1-data-load\000legacy cache\000Level 1 data cache read accesses\000le=
gacy-cache... */
-	{ 53466 },
+	{ 53424 },
 	/* l1-data-load-access\000legacy cache\000Level 1 data cache read accesse=
s\000legac... */
-	{ 53555 },
+	{ 53513 },
 	/* l1-data-load-miss\000legacy cache\000Level 1 data cache read misses\00=
0legacy-ca... */
-	{ 53651 },
+	{ 53609 },
 	/* l1-data-load-misses\000legacy cache\000Level 1 data cache read misses\=
000legacy-... */
-	{ 53749 },
+	{ 53707 },
 	/* l1-data-load-ops\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-c... */
-	{ 53849 },
+	{ 53807 },
 	/* l1-data-load-reference\000legacy cache\000Level 1 data cache read acce=
sses\000le... */
-	{ 53942 },
+	{ 53900 },
 	/* l1-data-load-refs\000legacy cache\000Level 1 data cache read accesses\=
000legacy-... */
-	{ 54041 },
+	{ 53999 },
 	/* l1-data-loads\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cach... */
-	{ 54135 },
+	{ 54093 },
 	/* l1-data-loads-access\000legacy cache\000Level 1 data cache read access=
es\000lega... */
-	{ 54225 },
+	{ 54183 },
 	/* l1-data-loads-miss\000legacy cache\000Level 1 data cache read misses\0=
00legacy-c... */
-	{ 54322 },
+	{ 54280 },
 	/* l1-data-loads-misses\000legacy cache\000Level 1 data cache read misses=
\000legacy... */
-	{ 54421 },
+	{ 54379 },
 	/* l1-data-loads-ops\000legacy cache\000Level 1 data cache read accesses\=
000legacy-... */
-	{ 54522 },
+	{ 54480 },
 	/* l1-data-loads-reference\000legacy cache\000Level 1 data cache read acc=
esses\000l... */
-	{ 54616 },
+	{ 54574 },
 	/* l1-data-loads-refs\000legacy cache\000Level 1 data cache read accesses=
\000legacy... */
-	{ 54716 },
+	{ 54674 },
 	/* l1-data-miss\000legacy cache\000Level 1 data cache read misses\000lega=
cy-cache-c... */
-	{ 54811 },
+	{ 54769 },
 	/* l1-data-misses\000legacy cache\000Level 1 data cache read misses\000le=
gacy-cache... */
-	{ 54904 },
+	{ 54862 },
 	/* l1-data-ops\000legacy cache\000Level 1 data cache read accesses\000leg=
acy-cache-... */
-	{ 54999 },
+	{ 54957 },
 	/* l1-data-prefetch\000legacy cache\000Level 1 data cache prefetch access=
es\000lega... */
-	{ 55087 },
+	{ 55045 },
 	/* l1-data-prefetch-access\000legacy cache\000Level 1 data cache prefetch=
 accesses\... */
-	{ 55188 },
+	{ 55146 },
 	/* l1-data-prefetch-miss\000legacy cache\000Level 1 data cache prefetch m=
isses\000l... */
-	{ 55296 },
+	{ 55254 },
 	/* l1-data-prefetch-misses\000legacy cache\000Level 1 data cache prefetch=
 misses\00... */
-	{ 55402 },
+	{ 55360 },
 	/* l1-data-prefetch-ops\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000... */
-	{ 55510 },
+	{ 55468 },
 	/* l1-data-prefetch-reference\000legacy cache\000Level 1 data cache prefe=
tch access... */
-	{ 55615 },
+	{ 55573 },
 	/* l1-data-prefetch-refs\000legacy cache\000Level 1 data cache prefetch a=
ccesses\00... */
-	{ 55726 },
+	{ 55684 },
 	/* l1-data-prefetches\000legacy cache\000Level 1 data cache prefetch acce=
sses\000le... */
-	{ 55832 },
+	{ 55790 },
 	/* l1-data-prefetches-access\000legacy cache\000Level 1 data cache prefet=
ch accesse... */
-	{ 55935 },
+	{ 55893 },
 	/* l1-data-prefetches-miss\000legacy cache\000Level 1 data cache prefetch=
 misses\00... */
-	{ 56045 },
+	{ 56003 },
 	/* l1-data-prefetches-misses\000legacy cache\000Level 1 data cache prefet=
ch misses\... */
-	{ 56153 },
+	{ 56111 },
 	/* l1-data-prefetches-ops\000legacy cache\000Level 1 data cache prefetch =
accesses\0... */
-	{ 56263 },
+	{ 56221 },
 	/* l1-data-prefetches-reference\000legacy cache\000Level 1 data cache pre=
fetch acce... */
-	{ 56370 },
+	{ 56328 },
 	/* l1-data-prefetches-refs\000legacy cache\000Level 1 data cache prefetch=
 accesses\... */
-	{ 56483 },
+	{ 56441 },
 	/* l1-data-read\000legacy cache\000Level 1 data cache read accesses\000le=
gacy-cache... */
-	{ 56591 },
+	{ 56549 },
 	/* l1-data-read-access\000legacy cache\000Level 1 data cache read accesse=
s\000legac... */
-	{ 56680 },
+	{ 56638 },
 	/* l1-data-read-miss\000legacy cache\000Level 1 data cache read misses\00=
0legacy-ca... */
-	{ 56776 },
+	{ 56734 },
 	/* l1-data-read-misses\000legacy cache\000Level 1 data cache read misses\=
000legacy-... */
-	{ 56874 },
+	{ 56832 },
 	/* l1-data-read-ops\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-c... */
-	{ 56974 },
+	{ 56932 },
 	/* l1-data-read-reference\000legacy cache\000Level 1 data cache read acce=
sses\000le... */
-	{ 57067 },
+	{ 57025 },
 	/* l1-data-read-refs\000legacy cache\000Level 1 data cache read accesses\=
000legacy-... */
-	{ 57166 },
+	{ 57124 },
 	/* l1-data-reference\000legacy cache\000Level 1 data cache read accesses\=
000legacy-... */
-	{ 57260 },
+	{ 57218 },
 	/* l1-data-refs\000legacy cache\000Level 1 data cache read accesses\000le=
gacy-cache... */
-	{ 57354 },
+	{ 57312 },
 	/* l1-data-speculative-load\000legacy cache\000Level 1 data cache prefetc=
h accesses... */
-	{ 57443 },
+	{ 57401 },
 	/* l1-data-speculative-load-access\000legacy cache\000Level 1 data cache =
prefetch a... */
-	{ 57552 },
+	{ 57510 },
 	/* l1-data-speculative-load-miss\000legacy cache\000Level 1 data cache pr=
efetch mis... */
-	{ 57668 },
+	{ 57626 },
 	/* l1-data-speculative-load-misses\000legacy cache\000Level 1 data cache =
prefetch m... */
-	{ 57782 },
+	{ 57740 },
 	/* l1-data-speculative-load-ops\000legacy cache\000Level 1 data cache pre=
fetch acce... */
-	{ 57898 },
+	{ 57856 },
 	/* l1-data-speculative-load-reference\000legacy cache\000Level 1 data cac=
he prefetc... */
-	{ 58011 },
+	{ 57969 },
 	/* l1-data-speculative-load-refs\000legacy cache\000Level 1 data cache pr=
efetch acc... */
-	{ 58130 },
+	{ 58088 },
 	/* l1-data-speculative-read\000legacy cache\000Level 1 data cache prefetc=
h accesses... */
-	{ 58244 },
+	{ 58202 },
 	/* l1-data-speculative-read-access\000legacy cache\000Level 1 data cache =
prefetch a... */
-	{ 58353 },
+	{ 58311 },
 	/* l1-data-speculative-read-miss\000legacy cache\000Level 1 data cache pr=
efetch mis... */
-	{ 58469 },
+	{ 58427 },
 	/* l1-data-speculative-read-misses\000legacy cache\000Level 1 data cache =
prefetch m... */
-	{ 58583 },
+	{ 58541 },
 	/* l1-data-speculative-read-ops\000legacy cache\000Level 1 data cache pre=
fetch acce... */
-	{ 58699 },
+	{ 58657 },
 	/* l1-data-speculative-read-reference\000legacy cache\000Level 1 data cac=
he prefetc... */
-	{ 58812 },
+	{ 58770 },
 	/* l1-data-speculative-read-refs\000legacy cache\000Level 1 data cache pr=
efetch acc... */
-	{ 58931 },
+	{ 58889 },
 	/* l1-data-store\000legacy cache\000Level 1 data cache write accesses\000=
legacy-cac... */
-	{ 59045 },
+	{ 59003 },
 	/* l1-data-store-access\000legacy cache\000Level 1 data cache write acces=
ses\000leg... */
-	{ 59140 },
+	{ 59098 },
 	/* l1-data-store-miss\000legacy cache\000Level 1 data cache write misses\=
000legacy-... */
-	{ 59242 },
+	{ 59200 },
 	/* l1-data-store-misses\000legacy cache\000Level 1 data cache write misse=
s\000legac... */
-	{ 59342 },
+	{ 59300 },
 	/* l1-data-store-ops\000legacy cache\000Level 1 data cache write accesses=
\000legacy... */
-	{ 59444 },
+	{ 59402 },
 	/* l1-data-store-reference\000legacy cache\000Level 1 data cache write ac=
cesses\000... */
-	{ 59543 },
+	{ 59501 },
 	/* l1-data-store-refs\000legacy cache\000Level 1 data cache write accesse=
s\000legac... */
-	{ 59648 },
+	{ 59606 },
 	/* l1-data-stores\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-ca... */
-	{ 59748 },
+	{ 59706 },
 	/* l1-data-stores-access\000legacy cache\000Level 1 data cache write acce=
sses\000le... */
-	{ 59844 },
+	{ 59802 },
 	/* l1-data-stores-miss\000legacy cache\000Level 1 data cache write misses=
\000legacy... */
-	{ 59947 },
+	{ 59905 },
 	/* l1-data-stores-misses\000legacy cache\000Level 1 data cache write miss=
es\000lega... */
-	{ 60048 },
+	{ 60006 },
 	/* l1-data-stores-ops\000legacy cache\000Level 1 data cache write accesse=
s\000legac... */
-	{ 60151 },
+	{ 60109 },
 	/* l1-data-stores-reference\000legacy cache\000Level 1 data cache write a=
ccesses\00... */
-	{ 60251 },
+	{ 60209 },
 	/* l1-data-stores-refs\000legacy cache\000Level 1 data cache write access=
es\000lega... */
-	{ 60357 },
+	{ 60315 },
 	/* l1-data-write\000legacy cache\000Level 1 data cache write accesses\000=
legacy-cac... */
-	{ 60458 },
+	{ 60416 },
 	/* l1-data-write-access\000legacy cache\000Level 1 data cache write acces=
ses\000leg... */
-	{ 60553 },
+	{ 60511 },
 	/* l1-data-write-miss\000legacy cache\000Level 1 data cache write misses\=
000legacy-... */
-	{ 60655 },
+	{ 60613 },
 	/* l1-data-write-misses\000legacy cache\000Level 1 data cache write misse=
s\000legac... */
-	{ 60755 },
+	{ 60713 },
 	/* l1-data-write-ops\000legacy cache\000Level 1 data cache write accesses=
\000legacy... */
-	{ 60857 },
+	{ 60815 },
 	/* l1-data-write-reference\000legacy cache\000Level 1 data cache write ac=
cesses\000... */
-	{ 60956 },
+	{ 60914 },
 	/* l1-data-write-refs\000legacy cache\000Level 1 data cache write accesse=
s\000legac... */
-	{ 61061 },
+	{ 61019 },
 	/* l1-dcache\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-co... */
-	{ 61161 },
+	{ 61119 },
 	/* l1-dcache-access\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-c... */
-	{ 61247 },
+	{ 61205 },
 	/* l1-dcache-load\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cac... */
-	{ 61340 },
+	{ 61298 },
 	/* l1-dcache-load-access\000legacy cache\000Level 1 data cache read acces=
ses\000leg... */
-	{ 61431 },
+	{ 61389 },
 	/* l1-dcache-load-miss\000legacy cache\000Level 1 data cache read misses\=
000legacy-... */
-	{ 61529 },
+	{ 61487 },
 	/* l1-dcache-load-misses\000legacy cache\000Level 1 data cache read misse=
s\000legac... */
-	{ 61629 },
+	{ 61587 },
 	/* l1-dcache-load-ops\000legacy cache\000Level 1 data cache read accesses=
\000legacy... */
-	{ 61731 },
+	{ 61689 },
 	/* l1-dcache-load-reference\000legacy cache\000Level 1 data cache read ac=
cesses\000... */
-	{ 61826 },
+	{ 61784 },
 	/* l1-dcache-load-refs\000legacy cache\000Level 1 data cache read accesse=
s\000legac... */
-	{ 61927 },
+	{ 61885 },
 	/* l1-dcache-loads\000legacy cache\000Level 1 data cache read accesses\00=
0legacy-ca... */
-	{ 62023 },
+	{ 61981 },
 	/* l1-dcache-loads-access\000legacy cache\000Level 1 data cache read acce=
sses\000le... */
-	{ 62115 },
+	{ 62073 },
 	/* l1-dcache-loads-miss\000legacy cache\000Level 1 data cache read misses=
\000legacy... */
-	{ 62214 },
+	{ 62172 },
 	/* l1-dcache-loads-misses\000legacy cache\000Level 1 data cache read miss=
es\000lega... */
-	{ 62315 },
+	{ 62273 },
 	/* l1-dcache-loads-ops\000legacy cache\000Level 1 data cache read accesse=
s\000legac... */
-	{ 62418 },
+	{ 62376 },
 	/* l1-dcache-loads-reference\000legacy cache\000Level 1 data cache read a=
ccesses\00... */
-	{ 62514 },
+	{ 62472 },
 	/* l1-dcache-loads-refs\000legacy cache\000Level 1 data cache read access=
es\000lega... */
-	{ 62616 },
+	{ 62574 },
 	/* l1-dcache-miss\000legacy cache\000Level 1 data cache read misses\000le=
gacy-cache... */
-	{ 62713 },
+	{ 62671 },
 	/* l1-dcache-misses\000legacy cache\000Level 1 data cache read misses\000=
legacy-cac... */
-	{ 62808 },
+	{ 62766 },
 	/* l1-dcache-ops\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cach... */
-	{ 62905 },
+	{ 62863 },
 	/* l1-dcache-prefetch\000legacy cache\000Level 1 data cache prefetch acce=
sses\000le... */
-	{ 62995 },
+	{ 62953 },
 	/* l1-dcache-prefetch-access\000legacy cache\000Level 1 data cache prefet=
ch accesse... */
-	{ 63098 },
+	{ 63056 },
 	/* l1-dcache-prefetch-miss\000legacy cache\000Level 1 data cache prefetch=
 misses\00... */
-	{ 63208 },
+	{ 63166 },
 	/* l1-dcache-prefetch-misses\000legacy cache\000Level 1 data cache prefet=
ch misses\... */
-	{ 63316 },
+	{ 63274 },
 	/* l1-dcache-prefetch-ops\000legacy cache\000Level 1 data cache prefetch =
accesses\0... */
-	{ 63426 },
+	{ 63384 },
 	/* l1-dcache-prefetch-reference\000legacy cache\000Level 1 data cache pre=
fetch acce... */
-	{ 63533 },
+	{ 63491 },
 	/* l1-dcache-prefetch-refs\000legacy cache\000Level 1 data cache prefetch=
 accesses\... */
-	{ 63646 },
+	{ 63604 },
 	/* l1-dcache-prefetches\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000... */
-	{ 63754 },
+	{ 63712 },
 	/* l1-dcache-prefetches-access\000legacy cache\000Level 1 data cache pref=
etch acces... */
-	{ 63859 },
+	{ 63817 },
 	/* l1-dcache-prefetches-miss\000legacy cache\000Level 1 data cache prefet=
ch misses\... */
-	{ 63971 },
+	{ 63929 },
 	/* l1-dcache-prefetches-misses\000legacy cache\000Level 1 data cache pref=
etch misse... */
-	{ 64081 },
+	{ 64039 },
 	/* l1-dcache-prefetches-ops\000legacy cache\000Level 1 data cache prefetc=
h accesses... */
-	{ 64193 },
+	{ 64151 },
 	/* l1-dcache-prefetches-reference\000legacy cache\000Level 1 data cache p=
refetch ac... */
-	{ 64302 },
+	{ 64260 },
 	/* l1-dcache-prefetches-refs\000legacy cache\000Level 1 data cache prefet=
ch accesse... */
-	{ 64417 },
+	{ 64375 },
 	/* l1-dcache-read\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cac... */
-	{ 64527 },
+	{ 64485 },
 	/* l1-dcache-read-access\000legacy cache\000Level 1 data cache read acces=
ses\000leg... */
-	{ 64618 },
+	{ 64576 },
 	/* l1-dcache-read-miss\000legacy cache\000Level 1 data cache read misses\=
000legacy-... */
-	{ 64716 },
+	{ 64674 },
 	/* l1-dcache-read-misses\000legacy cache\000Level 1 data cache read misse=
s\000legac... */
-	{ 64816 },
+	{ 64774 },
 	/* l1-dcache-read-ops\000legacy cache\000Level 1 data cache read accesses=
\000legacy... */
-	{ 64918 },
+	{ 64876 },
 	/* l1-dcache-read-reference\000legacy cache\000Level 1 data cache read ac=
cesses\000... */
-	{ 65013 },
+	{ 64971 },
 	/* l1-dcache-read-refs\000legacy cache\000Level 1 data cache read accesse=
s\000legac... */
-	{ 65114 },
+	{ 65072 },
 	/* l1-dcache-reference\000legacy cache\000Level 1 data cache read accesse=
s\000legac... */
-	{ 65210 },
+	{ 65168 },
 	/* l1-dcache-refs\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cac... */
-	{ 65306 },
+	{ 65264 },
 	/* l1-dcache-speculative-load\000legacy cache\000Level 1 data cache prefe=
tch access... */
-	{ 65397 },
+	{ 65355 },
 	/* l1-dcache-speculative-load-access\000legacy cache\000Level 1 data cach=
e prefetch... */
-	{ 65508 },
+	{ 65466 },
 	/* l1-dcache-speculative-load-miss\000legacy cache\000Level 1 data cache =
prefetch m... */
-	{ 65626 },
+	{ 65584 },
 	/* l1-dcache-speculative-load-misses\000legacy cache\000Level 1 data cach=
e prefetch... */
-	{ 65742 },
+	{ 65700 },
 	/* l1-dcache-speculative-load-ops\000legacy cache\000Level 1 data cache p=
refetch ac... */
-	{ 65860 },
+	{ 65818 },
 	/* l1-dcache-speculative-load-reference\000legacy cache\000Level 1 data c=
ache prefe... */
-	{ 65975 },
+	{ 65933 },
 	/* l1-dcache-speculative-load-refs\000legacy cache\000Level 1 data cache =
prefetch a... */
-	{ 66096 },
+	{ 66054 },
 	/* l1-dcache-speculative-read\000legacy cache\000Level 1 data cache prefe=
tch access... */
-	{ 66212 },
+	{ 66170 },
 	/* l1-dcache-speculative-read-access\000legacy cache\000Level 1 data cach=
e prefetch... */
-	{ 66323 },
+	{ 66281 },
 	/* l1-dcache-speculative-read-miss\000legacy cache\000Level 1 data cache =
prefetch m... */
-	{ 66441 },
+	{ 66399 },
 	/* l1-dcache-speculative-read-misses\000legacy cache\000Level 1 data cach=
e prefetch... */
-	{ 66557 },
+	{ 66515 },
 	/* l1-dcache-speculative-read-ops\000legacy cache\000Level 1 data cache p=
refetch ac... */
-	{ 66675 },
+	{ 66633 },
 	/* l1-dcache-speculative-read-reference\000legacy cache\000Level 1 data c=
ache prefe... */
-	{ 66790 },
+	{ 66748 },
 	/* l1-dcache-speculative-read-refs\000legacy cache\000Level 1 data cache =
prefetch a... */
-	{ 66911 },
+	{ 66869 },
 	/* l1-dcache-store\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-c... */
-	{ 67027 },
+	{ 66985 },
 	/* l1-dcache-store-access\000legacy cache\000Level 1 data cache write acc=
esses\000l... */
-	{ 67124 },
+	{ 67082 },
 	/* l1-dcache-store-miss\000legacy cache\000Level 1 data cache write misse=
s\000legac... */
-	{ 67228 },
+	{ 67186 },
 	/* l1-dcache-store-misses\000legacy cache\000Level 1 data cache write mis=
ses\000leg... */
-	{ 67330 },
+	{ 67288 },
 	/* l1-dcache-store-ops\000legacy cache\000Level 1 data cache write access=
es\000lega... */
-	{ 67434 },
+	{ 67392 },
 	/* l1-dcache-store-reference\000legacy cache\000Level 1 data cache write =
accesses\0... */
-	{ 67535 },
+	{ 67493 },
 	/* l1-dcache-store-refs\000legacy cache\000Level 1 data cache write acces=
ses\000leg... */
-	{ 67642 },
+	{ 67600 },
 	/* l1-dcache-stores\000legacy cache\000Level 1 data cache write accesses\=
000legacy-... */
-	{ 67744 },
+	{ 67702 },
 	/* l1-dcache-stores-access\000legacy cache\000Level 1 data cache write ac=
cesses\000... */
-	{ 67842 },
+	{ 67800 },
 	/* l1-dcache-stores-miss\000legacy cache\000Level 1 data cache write miss=
es\000lega... */
-	{ 67947 },
+	{ 67905 },
 	/* l1-dcache-stores-misses\000legacy cache\000Level 1 data cache write mi=
sses\000le... */
-	{ 68050 },
+	{ 68008 },
 	/* l1-dcache-stores-ops\000legacy cache\000Level 1 data cache write acces=
ses\000leg... */
-	{ 68155 },
+	{ 68113 },
 	/* l1-dcache-stores-reference\000legacy cache\000Level 1 data cache write=
 accesses\... */
-	{ 68257 },
+	{ 68215 },
 	/* l1-dcache-stores-refs\000legacy cache\000Level 1 data cache write acce=
sses\000le... */
-	{ 68365 },
+	{ 68323 },
 	/* l1-dcache-write\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-c... */
-	{ 68468 },
+	{ 68426 },
 	/* l1-dcache-write-access\000legacy cache\000Level 1 data cache write acc=
esses\000l... */
-	{ 68565 },
+	{ 68523 },
 	/* l1-dcache-write-miss\000legacy cache\000Level 1 data cache write misse=
s\000legac... */
-	{ 68669 },
+	{ 68627 },
 	/* l1-dcache-write-misses\000legacy cache\000Level 1 data cache write mis=
ses\000leg... */
-	{ 68771 },
+	{ 68729 },
 	/* l1-dcache-write-ops\000legacy cache\000Level 1 data cache write access=
es\000lega... */
-	{ 68875 },
+	{ 68833 },
 	/* l1-dcache-write-reference\000legacy cache\000Level 1 data cache write =
accesses\0... */
-	{ 68976 },
+	{ 68934 },
 	/* l1-dcache-write-refs\000legacy cache\000Level 1 data cache write acces=
ses\000leg... */
-	{ 69083 },
+	{ 69041 },
 	/* l1-i\000legacy cache\000Level 1 instruction cache read accesses\000leg=
acy-cache-... */
-	{ 69185 },
+	{ 69143 },
 	/* l1-i-access\000legacy cache\000Level 1 instruction cache read accesses=
\000legacy... */
-	{ 69273 },
+	{ 69231 },
 	/* l1-i-load\000legacy cache\000Level 1 instruction cache read accesses\0=
00legacy-c... */
-	{ 69368 },
+	{ 69326 },
 	/* l1-i-load-access\000legacy cache\000Level 1 instruction cache read acc=
esses\000l... */
-	{ 69461 },
+	{ 69419 },
 	/* l1-i-load-miss\000legacy cache\000Level 1 instruction cache read misse=
s\000legac... */
-	{ 69561 },
+	{ 69519 },
 	/* l1-i-load-misses\000legacy cache\000Level 1 instruction cache read mis=
ses\000leg... */
-	{ 69663 },
+	{ 69621 },
 	/* l1-i-load-ops\000legacy cache\000Level 1 instruction cache read access=
es\000lega... */
-	{ 69767 },
+	{ 69725 },
 	/* l1-i-load-reference\000legacy cache\000Level 1 instruction cache read =
accesses\0... */
-	{ 69864 },
+	{ 69822 },
 	/* l1-i-load-refs\000legacy cache\000Level 1 instruction cache read acces=
ses\000leg... */
-	{ 69967 },
+	{ 69925 },
 	/* l1-i-loads\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-... */
-	{ 70065 },
+	{ 70023 },
 	/* l1-i-loads-access\000legacy cache\000Level 1 instruction cache read ac=
cesses\000... */
-	{ 70159 },
+	{ 70117 },
 	/* l1-i-loads-miss\000legacy cache\000Level 1 instruction cache read miss=
es\000lega... */
-	{ 70260 },
+	{ 70218 },
 	/* l1-i-loads-misses\000legacy cache\000Level 1 instruction cache read mi=
sses\000le... */
-	{ 70363 },
+	{ 70321 },
 	/* l1-i-loads-ops\000legacy cache\000Level 1 instruction cache read acces=
ses\000leg... */
-	{ 70468 },
+	{ 70426 },
 	/* l1-i-loads-reference\000legacy cache\000Level 1 instruction cache read=
 accesses\... */
-	{ 70566 },
+	{ 70524 },
 	/* l1-i-loads-refs\000legacy cache\000Level 1 instruction cache read acce=
sses\000le... */
-	{ 70670 },
+	{ 70628 },
 	/* l1-i-miss\000legacy cache\000Level 1 instruction cache read misses\000=
legacy-cac... */
-	{ 70769 },
+	{ 70727 },
 	/* l1-i-misses\000legacy cache\000Level 1 instruction cache read misses\0=
00legacy-c... */
-	{ 70866 },
+	{ 70824 },
 	/* l1-i-ops\000legacy cache\000Level 1 instruction cache read accesses\00=
0legacy-ca... */
-	{ 70965 },
+	{ 70923 },
 	/* l1-i-prefetch\000legacy cache\000Level 1 instruction cache prefetch ac=
cesses\000... */
-	{ 71057 },
+	{ 71015 },
 	/* l1-i-prefetch-access\000legacy cache\000Level 1 instruction cache pref=
etch acces... */
-	{ 71162 },
+	{ 71120 },
 	/* l1-i-prefetch-miss\000legacy cache\000Level 1 instruction cache prefet=
ch misses\... */
-	{ 71274 },
+	{ 71232 },
 	/* l1-i-prefetch-misses\000legacy cache\000Level 1 instruction cache pref=
etch misse... */
-	{ 71384 },
+	{ 71342 },
 	/* l1-i-prefetch-ops\000legacy cache\000Level 1 instruction cache prefetc=
h accesses... */
-	{ 71496 },
+	{ 71454 },
 	/* l1-i-prefetch-reference\000legacy cache\000Level 1 instruction cache p=
refetch ac... */
-	{ 71605 },
+	{ 71563 },
 	/* l1-i-prefetch-refs\000legacy cache\000Level 1 instruction cache prefet=
ch accesse... */
-	{ 71720 },
+	{ 71678 },
 	/* l1-i-prefetches\000legacy cache\000Level 1 instruction cache prefetch =
accesses\0... */
-	{ 71830 },
+	{ 71788 },
 	/* l1-i-prefetches-access\000legacy cache\000Level 1 instruction cache pr=
efetch acc... */
-	{ 71937 },
+	{ 71895 },
 	/* l1-i-prefetches-miss\000legacy cache\000Level 1 instruction cache pref=
etch misse... */
-	{ 72051 },
+	{ 72009 },
 	/* l1-i-prefetches-misses\000legacy cache\000Level 1 instruction cache pr=
efetch mis... */
-	{ 72163 },
+	{ 72121 },
 	/* l1-i-prefetches-ops\000legacy cache\000Level 1 instruction cache prefe=
tch access... */
-	{ 72277 },
+	{ 72235 },
 	/* l1-i-prefetches-reference\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
-	{ 72388 },
+	{ 72346 },
 	/* l1-i-prefetches-refs\000legacy cache\000Level 1 instruction cache pref=
etch acces... */
-	{ 72505 },
+	{ 72463 },
 	/* l1-i-read\000legacy cache\000Level 1 instruction cache read accesses\0=
00legacy-c... */
-	{ 72617 },
+	{ 72575 },
 	/* l1-i-read-access\000legacy cache\000Level 1 instruction cache read acc=
esses\000l... */
-	{ 72710 },
+	{ 72668 },
 	/* l1-i-read-miss\000legacy cache\000Level 1 instruction cache read misse=
s\000legac... */
-	{ 72810 },
+	{ 72768 },
 	/* l1-i-read-misses\000legacy cache\000Level 1 instruction cache read mis=
ses\000leg... */
-	{ 72912 },
+	{ 72870 },
 	/* l1-i-read-ops\000legacy cache\000Level 1 instruction cache read access=
es\000lega... */
-	{ 73016 },
+	{ 72974 },
 	/* l1-i-read-reference\000legacy cache\000Level 1 instruction cache read =
accesses\0... */
-	{ 73113 },
+	{ 73071 },
 	/* l1-i-read-refs\000legacy cache\000Level 1 instruction cache read acces=
ses\000leg... */
-	{ 73216 },
+	{ 73174 },
 	/* l1-i-reference\000legacy cache\000Level 1 instruction cache read acces=
ses\000leg... */
-	{ 73314 },
+	{ 73272 },
 	/* l1-i-refs\000legacy cache\000Level 1 instruction cache read accesses\0=
00legacy-c... */
-	{ 73412 },
+	{ 73370 },
 	/* l1-i-speculative-load\000legacy cache\000Level 1 instruction cache pre=
fetch acce... */
-	{ 73505 },
+	{ 73463 },
 	/* l1-i-speculative-load-access\000legacy cache\000Level 1 instruction ca=
che prefet... */
-	{ 73618 },
+	{ 73576 },
 	/* l1-i-speculative-load-miss\000legacy cache\000Level 1 instruction cach=
e prefetch... */
-	{ 73738 },
+	{ 73696 },
 	/* l1-i-speculative-load-misses\000legacy cache\000Level 1 instruction ca=
che prefet... */
-	{ 73856 },
+	{ 73814 },
 	/* l1-i-speculative-load-ops\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
-	{ 73976 },
+	{ 73934 },
 	/* l1-i-speculative-load-reference\000legacy cache\000Level 1 instruction=
 cache pre... */
-	{ 74093 },
+	{ 74051 },
 	/* l1-i-speculative-load-refs\000legacy cache\000Level 1 instruction cach=
e prefetch... */
-	{ 74216 },
+	{ 74174 },
 	/* l1-i-speculative-read\000legacy cache\000Level 1 instruction cache pre=
fetch acce... */
-	{ 74334 },
+	{ 74292 },
 	/* l1-i-speculative-read-access\000legacy cache\000Level 1 instruction ca=
che prefet... */
-	{ 74447 },
+	{ 74405 },
 	/* l1-i-speculative-read-miss\000legacy cache\000Level 1 instruction cach=
e prefetch... */
-	{ 74567 },
+	{ 74525 },
 	/* l1-i-speculative-read-misses\000legacy cache\000Level 1 instruction ca=
che prefet... */
-	{ 74685 },
+	{ 74643 },
 	/* l1-i-speculative-read-ops\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
-	{ 74805 },
+	{ 74763 },
 	/* l1-i-speculative-read-reference\000legacy cache\000Level 1 instruction=
 cache pre... */
-	{ 74922 },
+	{ 74880 },
 	/* l1-i-speculative-read-refs\000legacy cache\000Level 1 instruction cach=
e prefetch... */
-	{ 75045 },
+	{ 75003 },
 	/* l1-icache\000legacy cache\000Level 1 instruction cache read accesses\0=
00legacy-c... */
-	{ 75163 },
+	{ 75121 },
 	/* l1-icache-access\000legacy cache\000Level 1 instruction cache read acc=
esses\000l... */
-	{ 75256 },
+	{ 75214 },
 	/* l1-icache-load\000legacy cache\000Level 1 instruction cache read acces=
ses\000leg... */
-	{ 75356 },
+	{ 75314 },
 	/* l1-icache-load-access\000legacy cache\000Level 1 instruction cache rea=
d accesses... */
-	{ 75454 },
+	{ 75412 },
 	/* l1-icache-load-miss\000legacy cache\000Level 1 instruction cache read =
misses\000... */
-	{ 75559 },
+	{ 75517 },
 	/* l1-icache-load-misses\000legacy cache\000Level 1 instruction cache rea=
d misses\0... */
-	{ 75666 },
+	{ 75624 },
 	/* l1-icache-load-ops\000legacy cache\000Level 1 instruction cache read a=
ccesses\00... */
-	{ 75775 },
+	{ 75733 },
 	/* l1-icache-load-reference\000legacy cache\000Level 1 instruction cache =
read acces... */
-	{ 75877 },
+	{ 75835 },
 	/* l1-icache-load-refs\000legacy cache\000Level 1 instruction cache read =
accesses\0... */
-	{ 75985 },
+	{ 75943 },
 	/* l1-icache-loads\000legacy cache\000Level 1 instruction cache read acce=
sses\000le... */
-	{ 76088 },
+	{ 76046 },
 	/* l1-icache-loads-access\000legacy cache\000Level 1 instruction cache re=
ad accesse... */
-	{ 76187 },
+	{ 76145 },
 	/* l1-icache-loads-miss\000legacy cache\000Level 1 instruction cache read=
 misses\00... */
-	{ 76293 },
+	{ 76251 },
 	/* l1-icache-loads-misses\000legacy cache\000Level 1 instruction cache re=
ad misses\... */
-	{ 76401 },
+	{ 76359 },
 	/* l1-icache-loads-ops\000legacy cache\000Level 1 instruction cache read =
accesses\0... */
-	{ 76511 },
+	{ 76469 },
 	/* l1-icache-loads-reference\000legacy cache\000Level 1 instruction cache=
 read acce... */
-	{ 76614 },
+	{ 76572 },
 	/* l1-icache-loads-refs\000legacy cache\000Level 1 instruction cache read=
 accesses\... */
-	{ 76723 },
+	{ 76681 },
 	/* l1-icache-miss\000legacy cache\000Level 1 instruction cache read misse=
s\000legac... */
-	{ 76827 },
+	{ 76785 },
 	/* l1-icache-misses\000legacy cache\000Level 1 instruction cache read mis=
ses\000leg... */
-	{ 76929 },
+	{ 76887 },
 	/* l1-icache-ops\000legacy cache\000Level 1 instruction cache read access=
es\000lega... */
-	{ 77033 },
+	{ 76991 },
 	/* l1-icache-prefetch\000legacy cache\000Level 1 instruction cache prefet=
ch accesse... */
-	{ 77130 },
+	{ 77088 },
 	/* l1-icache-prefetch-access\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
-	{ 77240 },
+	{ 77198 },
 	/* l1-icache-prefetch-miss\000legacy cache\000Level 1 instruction cache p=
refetch mi... */
-	{ 77357 },
+	{ 77315 },
 	/* l1-icache-prefetch-misses\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
-	{ 77472 },
+	{ 77430 },
 	/* l1-icache-prefetch-ops\000legacy cache\000Level 1 instruction cache pr=
efetch acc... */
-	{ 77589 },
+	{ 77547 },
 	/* l1-icache-prefetch-reference\000legacy cache\000Level 1 instruction ca=
che prefet... */
-	{ 77703 },
+	{ 77661 },
 	/* l1-icache-prefetch-refs\000legacy cache\000Level 1 instruction cache p=
refetch ac... */
-	{ 77823 },
+	{ 77781 },
 	/* l1-icache-prefetches\000legacy cache\000Level 1 instruction cache pref=
etch acces... */
-	{ 77938 },
+	{ 77896 },
 	/* l1-icache-prefetches-access\000legacy cache\000Level 1 instruction cac=
he prefetc... */
-	{ 78050 },
+	{ 78008 },
 	/* l1-icache-prefetches-miss\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
-	{ 78169 },
+	{ 78127 },
 	/* l1-icache-prefetches-misses\000legacy cache\000Level 1 instruction cac=
he prefetc... */
-	{ 78286 },
+	{ 78244 },
 	/* l1-icache-prefetches-ops\000legacy cache\000Level 1 instruction cache =
prefetch a... */
-	{ 78405 },
+	{ 78363 },
 	/* l1-icache-prefetches-reference\000legacy cache\000Level 1 instruction =
cache pref... */
-	{ 78521 },
+	{ 78479 },
 	/* l1-icache-prefetches-refs\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
-	{ 78643 },
+	{ 78601 },
 	/* l1-icache-read\000legacy cache\000Level 1 instruction cache read acces=
ses\000leg... */
-	{ 78760 },
+	{ 78718 },
 	/* l1-icache-read-access\000legacy cache\000Level 1 instruction cache rea=
d accesses... */
-	{ 78858 },
+	{ 78816 },
 	/* l1-icache-read-miss\000legacy cache\000Level 1 instruction cache read =
misses\000... */
-	{ 78963 },
+	{ 78921 },
 	/* l1-icache-read-misses\000legacy cache\000Level 1 instruction cache rea=
d misses\0... */
-	{ 79070 },
+	{ 79028 },
 	/* l1-icache-read-ops\000legacy cache\000Level 1 instruction cache read a=
ccesses\00... */
-	{ 79179 },
+	{ 79137 },
 	/* l1-icache-read-reference\000legacy cache\000Level 1 instruction cache =
read acces... */
-	{ 79281 },
+	{ 79239 },
 	/* l1-icache-read-refs\000legacy cache\000Level 1 instruction cache read =
accesses\0... */
-	{ 79389 },
+	{ 79347 },
 	/* l1-icache-reference\000legacy cache\000Level 1 instruction cache read =
accesses\0... */
-	{ 79492 },
+	{ 79450 },
 	/* l1-icache-refs\000legacy cache\000Level 1 instruction cache read acces=
ses\000leg... */
-	{ 79595 },
+	{ 79553 },
 	/* l1-icache-speculative-load\000legacy cache\000Level 1 instruction cach=
e prefetch... */
-	{ 79693 },
+	{ 79651 },
 	/* l1-icache-speculative-load-access\000legacy cache\000Level 1 instructi=
on cache p... */
-	{ 79811 },
+	{ 79769 },
 	/* l1-icache-speculative-load-miss\000legacy cache\000Level 1 instruction=
 cache pre... */
-	{ 79936 },
+	{ 79894 },
 	/* l1-icache-speculative-load-misses\000legacy cache\000Level 1 instructi=
on cache p... */
-	{ 80059 },
+	{ 80017 },
 	/* l1-icache-speculative-load-ops\000legacy cache\000Level 1 instruction =
cache pref... */
-	{ 80184 },
+	{ 80142 },
 	/* l1-icache-speculative-load-reference\000legacy cache\000Level 1 instru=
ction cach... */
-	{ 80306 },
+	{ 80264 },
 	/* l1-icache-speculative-load-refs\000legacy cache\000Level 1 instruction=
 cache pre... */
-	{ 80434 },
+	{ 80392 },
 	/* l1-icache-speculative-read\000legacy cache\000Level 1 instruction cach=
e prefetch... */
-	{ 80557 },
+	{ 80515 },
 	/* l1-icache-speculative-read-access\000legacy cache\000Level 1 instructi=
on cache p... */
-	{ 80675 },
+	{ 80633 },
 	/* l1-icache-speculative-read-miss\000legacy cache\000Level 1 instruction=
 cache pre... */
-	{ 80800 },
+	{ 80758 },
 	/* l1-icache-speculative-read-misses\000legacy cache\000Level 1 instructi=
on cache p... */
-	{ 80923 },
+	{ 80881 },
 	/* l1-icache-speculative-read-ops\000legacy cache\000Level 1 instruction =
cache pref... */
-	{ 81048 },
+	{ 81006 },
 	/* l1-icache-speculative-read-reference\000legacy cache\000Level 1 instru=
ction cach... */
-	{ 81170 },
+	{ 81128 },
 	/* l1-icache-speculative-read-refs\000legacy cache\000Level 1 instruction=
 cache pre... */
-	{ 81298 },
+	{ 81256 },
 	/* l1-instruction\000legacy cache\000Level 1 instruction cache read acces=
ses\000leg... */
-	{ 81421 },
+	{ 81379 },
 	/* l1-instruction-access\000legacy cache\000Level 1 instruction cache rea=
d accesses... */
-	{ 81519 },
+	{ 81477 },
 	/* l1-instruction-load\000legacy cache\000Level 1 instruction cache read =
accesses\0... */
-	{ 81624 },
+	{ 81582 },
 	/* l1-instruction-load-access\000legacy cache\000Level 1 instruction cach=
e read acc... */
-	{ 81727 },
+	{ 81685 },
 	/* l1-instruction-load-miss\000legacy cache\000Level 1 instruction cache =
read misse... */
-	{ 81837 },
+	{ 81795 },
 	/* l1-instruction-load-misses\000legacy cache\000Level 1 instruction cach=
e read mis... */
-	{ 81949 },
+	{ 81907 },
 	/* l1-instruction-load-ops\000legacy cache\000Level 1 instruction cache r=
ead access... */
-	{ 82063 },
+	{ 82021 },
 	/* l1-instruction-load-reference\000legacy cache\000Level 1 instruction c=
ache read ... */
-	{ 82170 },
+	{ 82128 },
 	/* l1-instruction-load-refs\000legacy cache\000Level 1 instruction cache =
read acces... */
-	{ 82283 },
+	{ 82241 },
 	/* l1-instruction-loads\000legacy cache\000Level 1 instruction cache read=
 accesses\... */
-	{ 82391 },
+	{ 82349 },
 	/* l1-instruction-loads-access\000legacy cache\000Level 1 instruction cac=
he read ac... */
-	{ 82495 },
+	{ 82453 },
 	/* l1-instruction-loads-miss\000legacy cache\000Level 1 instruction cache=
 read miss... */
-	{ 82606 },
+	{ 82564 },
 	/* l1-instruction-loads-misses\000legacy cache\000Level 1 instruction cac=
he read mi... */
-	{ 82719 },
+	{ 82677 },
 	/* l1-instruction-loads-ops\000legacy cache\000Level 1 instruction cache =
read acces... */
-	{ 82834 },
+	{ 82792 },
 	/* l1-instruction-loads-reference\000legacy cache\000Level 1 instruction =
cache read... */
-	{ 82942 },
+	{ 82900 },
 	/* l1-instruction-loads-refs\000legacy cache\000Level 1 instruction cache=
 read acce... */
-	{ 83056 },
+	{ 83014 },
 	/* l1-instruction-miss\000legacy cache\000Level 1 instruction cache read =
misses\000... */
-	{ 83165 },
+	{ 83123 },
 	/* l1-instruction-misses\000legacy cache\000Level 1 instruction cache rea=
d misses\0... */
-	{ 83272 },
+	{ 83230 },
 	/* l1-instruction-ops\000legacy cache\000Level 1 instruction cache read a=
ccesses\00... */
-	{ 83381 },
+	{ 83339 },
 	/* l1-instruction-prefetch\000legacy cache\000Level 1 instruction cache p=
refetch ac... */
-	{ 83483 },
+	{ 83441 },
 	/* l1-instruction-prefetch-access\000legacy cache\000Level 1 instruction =
cache pref... */
-	{ 83598 },
+	{ 83556 },
 	/* l1-instruction-prefetch-miss\000legacy cache\000Level 1 instruction ca=
che prefet... */
-	{ 83720 },
+	{ 83678 },
 	/* l1-instruction-prefetch-misses\000legacy cache\000Level 1 instruction =
cache pref... */
-	{ 83840 },
+	{ 83798 },
 	/* l1-instruction-prefetch-ops\000legacy cache\000Level 1 instruction cac=
he prefetc... */
-	{ 83962 },
+	{ 83920 },
 	/* l1-instruction-prefetch-reference\000legacy cache\000Level 1 instructi=
on cache p... */
-	{ 84081 },
+	{ 84039 },
 	/* l1-instruction-prefetch-refs\000legacy cache\000Level 1 instruction ca=
che prefet... */
-	{ 84206 },
+	{ 84164 },
 	/* l1-instruction-prefetches\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
-	{ 84326 },
+	{ 84284 },
 	/* l1-instruction-prefetches-access\000legacy cache\000Level 1 instructio=
n cache pr... */
-	{ 84443 },
+	{ 84401 },
 	/* l1-instruction-prefetches-miss\000legacy cache\000Level 1 instruction =
cache pref... */
-	{ 84567 },
+	{ 84525 },
 	/* l1-instruction-prefetches-misses\000legacy cache\000Level 1 instructio=
n cache pr... */
-	{ 84689 },
+	{ 84647 },
 	/* l1-instruction-prefetches-ops\000legacy cache\000Level 1 instruction c=
ache prefe... */
-	{ 84813 },
+	{ 84771 },
 	/* l1-instruction-prefetches-reference\000legacy cache\000Level 1 instruc=
tion cache... */
-	{ 84934 },
+	{ 84892 },
 	/* l1-instruction-prefetches-refs\000legacy cache\000Level 1 instruction =
cache pref... */
-	{ 85061 },
+	{ 85019 },
 	/* l1-instruction-read\000legacy cache\000Level 1 instruction cache read =
accesses\0... */
-	{ 85183 },
+	{ 85141 },
 	/* l1-instruction-read-access\000legacy cache\000Level 1 instruction cach=
e read acc... */
-	{ 85286 },
+	{ 85244 },
 	/* l1-instruction-read-miss\000legacy cache\000Level 1 instruction cache =
read misse... */
-	{ 85396 },
+	{ 85354 },
 	/* l1-instruction-read-misses\000legacy cache\000Level 1 instruction cach=
e read mis... */
-	{ 85508 },
+	{ 85466 },
 	/* l1-instruction-read-ops\000legacy cache\000Level 1 instruction cache r=
ead access... */
-	{ 85622 },
+	{ 85580 },
 	/* l1-instruction-read-reference\000legacy cache\000Level 1 instruction c=
ache read ... */
-	{ 85729 },
+	{ 85687 },
 	/* l1-instruction-read-refs\000legacy cache\000Level 1 instruction cache =
read acces... */
-	{ 85842 },
+	{ 85800 },
 	/* l1-instruction-reference\000legacy cache\000Level 1 instruction cache =
read acces... */
-	{ 85950 },
+	{ 85908 },
 	/* l1-instruction-refs\000legacy cache\000Level 1 instruction cache read =
accesses\0... */
-	{ 86058 },
+	{ 86016 },
 	/* l1-instruction-speculative-load\000legacy cache\000Level 1 instruction=
 cache pre... */
-	{ 86161 },
+	{ 86119 },
 	/* l1-instruction-speculative-load-access\000legacy cache\000Level 1 inst=
ruction ca... */
-	{ 86284 },
+	{ 86242 },
 	/* l1-instruction-speculative-load-miss\000legacy cache\000Level 1 instru=
ction cach... */
-	{ 86414 },
+	{ 86372 },
 	/* l1-instruction-speculative-load-misses\000legacy cache\000Level 1 inst=
ruction ca... */
-	{ 86542 },
+	{ 86500 },
 	/* l1-instruction-speculative-load-ops\000legacy cache\000Level 1 instruc=
tion cache... */
-	{ 86672 },
+	{ 86630 },
 	/* l1-instruction-speculative-load-reference\000legacy cache\000Level 1 i=
nstruction... */
-	{ 86799 },
+	{ 86757 },
 	/* l1-instruction-speculative-load-refs\000legacy cache\000Level 1 instru=
ction cach... */
-	{ 86932 },
+	{ 86890 },
 	/* l1-instruction-speculative-read\000legacy cache\000Level 1 instruction=
 cache pre... */
-	{ 87060 },
+	{ 87018 },
 	/* l1-instruction-speculative-read-access\000legacy cache\000Level 1 inst=
ruction ca... */
-	{ 87183 },
+	{ 87141 },
 	/* l1-instruction-speculative-read-miss\000legacy cache\000Level 1 instru=
ction cach... */
-	{ 87313 },
+	{ 87271 },
 	/* l1-instruction-speculative-read-misses\000legacy cache\000Level 1 inst=
ruction ca... */
-	{ 87441 },
+	{ 87399 },
 	/* l1-instruction-speculative-read-ops\000legacy cache\000Level 1 instruc=
tion cache... */
-	{ 87571 },
+	{ 87529 },
 	/* l1-instruction-speculative-read-reference\000legacy cache\000Level 1 i=
nstruction... */
-	{ 87698 },
+	{ 87656 },
 	/* l1-instruction-speculative-read-refs\000legacy cache\000Level 1 instru=
ction cach... */
-	{ 87831 },
+	{ 87789 },
 	/* l1d\000legacy cache\000Level 1 data cache read accesses\000legacy-cach=
e-config=3D0... */
-	{ 87959 },
+	{ 87917 },
 	/* l1d-access\000legacy cache\000Level 1 data cache read accesses\000lega=
cy-cache-c... */
-	{ 88039 },
+	{ 87997 },
 	/* l1d-load\000legacy cache\000Level 1 data cache read accesses\000legacy=
-cache-con... */
-	{ 88126 },
+	{ 88084 },
 	/* l1d-load-access\000legacy cache\000Level 1 data cache read accesses\00=
0legacy-ca... */
-	{ 88211 },
+	{ 88169 },
 	/* l1d-load-miss\000legacy cache\000Level 1 data cache read misses\000leg=
acy-cache-... */
-	{ 88303 },
+	{ 88261 },
 	/* l1d-load-misses\000legacy cache\000Level 1 data cache read misses\000l=
egacy-cach... */
-	{ 88397 },
+	{ 88355 },
 	/* l1d-load-ops\000legacy cache\000Level 1 data cache read accesses\000le=
gacy-cache... */
-	{ 88493 },
+	{ 88451 },
 	/* l1d-load-reference\000legacy cache\000Level 1 data cache read accesses=
\000legacy... */
-	{ 88582 },
+	{ 88540 },
 	/* l1d-load-refs\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cach... */
-	{ 88677 },
+	{ 88635 },
 	/* l1d-loads\000legacy cache\000Level 1 data cache read accesses\000legac=
y-cache-co... */
-	{ 88767 },
+	{ 88725 },
 	/* l1d-loads-access\000legacy cache\000Level 1 data cache read accesses\0=
00legacy-c... */
-	{ 88853 },
+	{ 88811 },
 	/* l1d-loads-miss\000legacy cache\000Level 1 data cache read misses\000le=
gacy-cache... */
-	{ 88946 },
+	{ 88904 },
 	/* l1d-loads-misses\000legacy cache\000Level 1 data cache read misses\000=
legacy-cac... */
-	{ 89041 },
+	{ 88999 },
 	/* l1d-loads-ops\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cach... */
-	{ 89138 },
+	{ 89096 },
 	/* l1d-loads-reference\000legacy cache\000Level 1 data cache read accesse=
s\000legac... */
-	{ 89228 },
+	{ 89186 },
 	/* l1d-loads-refs\000legacy cache\000Level 1 data cache read accesses\000=
legacy-cac... */
-	{ 89324 },
+	{ 89282 },
 	/* l1d-miss\000legacy cache\000Level 1 data cache read misses\000legacy-c=
ache-confi... */
-	{ 89415 },
+	{ 89373 },
 	/* l1d-misses\000legacy cache\000Level 1 data cache read misses\000legacy=
-cache-con... */
-	{ 89504 },
+	{ 89462 },
 	/* l1d-ops\000legacy cache\000Level 1 data cache read accesses\000legacy-=
cache-conf... */
-	{ 89595 },
+	{ 89553 },
 	/* l1d-prefetch\000legacy cache\000Level 1 data cache prefetch accesses\0=
00legacy-c... */
-	{ 89679 },
+	{ 89637 },
 	/* l1d-prefetch-access\000legacy cache\000Level 1 data cache prefetch acc=
esses\000l... */
-	{ 89776 },
+	{ 89734 },
 	/* l1d-prefetch-miss\000legacy cache\000Level 1 data cache prefetch misse=
s\000legac... */
-	{ 89880 },
+	{ 89838 },
 	/* l1d-prefetch-misses\000legacy cache\000Level 1 data cache prefetch mis=
ses\000leg... */
-	{ 89982 },
+	{ 89940 },
 	/* l1d-prefetch-ops\000legacy cache\000Level 1 data cache prefetch access=
es\000lega... */
-	{ 90086 },
+	{ 90044 },
 	/* l1d-prefetch-reference\000legacy cache\000Level 1 data cache prefetch =
accesses\0... */
-	{ 90187 },
+	{ 90145 },
 	/* l1d-prefetch-refs\000legacy cache\000Level 1 data cache prefetch acces=
ses\000leg... */
-	{ 90294 },
+	{ 90252 },
 	/* l1d-prefetches\000legacy cache\000Level 1 data cache prefetch accesses=
\000legacy... */
-	{ 90396 },
+	{ 90354 },
 	/* l1d-prefetches-access\000legacy cache\000Level 1 data cache prefetch a=
ccesses\00... */
-	{ 90495 },
+	{ 90453 },
 	/* l1d-prefetches-miss\000legacy cache\000Level 1 data cache prefetch mis=
ses\000leg... */
-	{ 90601 },
+	{ 90559 },
 	/* l1d-prefetches-misses\000legacy cache\000Level 1 data cache prefetch m=
isses\000l... */
-	{ 90705 },
+	{ 90663 },
 	/* l1d-prefetches-ops\000legacy cache\000Level 1 data cache prefetch acce=
sses\000le... */
-	{ 90811 },
+	{ 90769 },
 	/* l1d-prefetches-reference\000legacy cache\000Level 1 data cache prefetc=
h accesses... */
-	{ 90914 },
+	{ 90872 },
 	/* l1d-prefetches-refs\000legacy cache\000Level 1 data cache prefetch acc=
esses\000l... */
-	{ 91023 },
+	{ 90981 },
 	/* l1d-read\000legacy cache\000Level 1 data cache read accesses\000legacy=
-cache-con... */
-	{ 91127 },
+	{ 91085 },
 	/* l1d-read-access\000legacy cache\000Level 1 data cache read accesses\00=
0legacy-ca... */
-	{ 91212 },
+	{ 91170 },
 	/* l1d-read-miss\000legacy cache\000Level 1 data cache read misses\000leg=
acy-cache-... */
-	{ 91304 },
+	{ 91262 },
 	/* l1d-read-misses\000legacy cache\000Level 1 data cache read misses\000l=
egacy-cach... */
-	{ 91398 },
+	{ 91356 },
 	/* l1d-read-ops\000legacy cache\000Level 1 data cache read accesses\000le=
gacy-cache... */
-	{ 91494 },
+	{ 91452 },
 	/* l1d-read-reference\000legacy cache\000Level 1 data cache read accesses=
\000legacy... */
-	{ 91583 },
+	{ 91541 },
 	/* l1d-read-refs\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cach... */
-	{ 91678 },
+	{ 91636 },
 	/* l1d-reference\000legacy cache\000Level 1 data cache read accesses\000l=
egacy-cach... */
-	{ 91768 },
+	{ 91726 },
 	/* l1d-refs\000legacy cache\000Level 1 data cache read accesses\000legacy=
-cache-con... */
-	{ 91858 },
+	{ 91816 },
 	/* l1d-speculative-load\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000... */
-	{ 91943 },
+	{ 91901 },
 	/* l1d-speculative-load-access\000legacy cache\000Level 1 data cache pref=
etch acces... */
-	{ 92048 },
+	{ 92006 },
 	/* l1d-speculative-load-miss\000legacy cache\000Level 1 data cache prefet=
ch misses\... */
-	{ 92160 },
+	{ 92118 },
 	/* l1d-speculative-load-misses\000legacy cache\000Level 1 data cache pref=
etch misse... */
-	{ 92270 },
+	{ 92228 },
 	/* l1d-speculative-load-ops\000legacy cache\000Level 1 data cache prefetc=
h accesses... */
-	{ 92382 },
+	{ 92340 },
 	/* l1d-speculative-load-reference\000legacy cache\000Level 1 data cache p=
refetch ac... */
-	{ 92491 },
+	{ 92449 },
 	/* l1d-speculative-load-refs\000legacy cache\000Level 1 data cache prefet=
ch accesse... */
-	{ 92606 },
+	{ 92564 },
 	/* l1d-speculative-read\000legacy cache\000Level 1 data cache prefetch ac=
cesses\000... */
-	{ 92716 },
+	{ 92674 },
 	/* l1d-speculative-read-access\000legacy cache\000Level 1 data cache pref=
etch acces... */
-	{ 92821 },
+	{ 92779 },
 	/* l1d-speculative-read-miss\000legacy cache\000Level 1 data cache prefet=
ch misses\... */
-	{ 92933 },
+	{ 92891 },
 	/* l1d-speculative-read-misses\000legacy cache\000Level 1 data cache pref=
etch misse... */
-	{ 93043 },
+	{ 93001 },
 	/* l1d-speculative-read-ops\000legacy cache\000Level 1 data cache prefetc=
h accesses... */
-	{ 93155 },
+	{ 93113 },
 	/* l1d-speculative-read-reference\000legacy cache\000Level 1 data cache p=
refetch ac... */
-	{ 93264 },
+	{ 93222 },
 	/* l1d-speculative-read-refs\000legacy cache\000Level 1 data cache prefet=
ch accesse... */
-	{ 93379 },
+	{ 93337 },
 	/* l1d-store\000legacy cache\000Level 1 data cache write accesses\000lega=
cy-cache-c... */
-	{ 93489 },
+	{ 93447 },
 	/* l1d-store-access\000legacy cache\000Level 1 data cache write accesses\=
000legacy-... */
-	{ 93580 },
+	{ 93538 },
 	/* l1d-store-miss\000legacy cache\000Level 1 data cache write misses\000l=
egacy-cach... */
-	{ 93678 },
+	{ 93636 },
 	/* l1d-store-misses\000legacy cache\000Level 1 data cache write misses\00=
0legacy-ca... */
-	{ 93774 },
+	{ 93732 },
 	/* l1d-store-ops\000legacy cache\000Level 1 data cache write accesses\000=
legacy-cac... */
-	{ 93872 },
+	{ 93830 },
 	/* l1d-store-reference\000legacy cache\000Level 1 data cache write access=
es\000lega... */
-	{ 93967 },
+	{ 93925 },
 	/* l1d-store-refs\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-ca... */
-	{ 94068 },
+	{ 94026 },
 	/* l1d-stores\000legacy cache\000Level 1 data cache write accesses\000leg=
acy-cache-... */
-	{ 94164 },
+	{ 94122 },
 	/* l1d-stores-access\000legacy cache\000Level 1 data cache write accesses=
\000legacy... */
-	{ 94256 },
+	{ 94214 },
 	/* l1d-stores-miss\000legacy cache\000Level 1 data cache write misses\000=
legacy-cac... */
-	{ 94355 },
+	{ 94313 },
 	/* l1d-stores-misses\000legacy cache\000Level 1 data cache write misses\0=
00legacy-c... */
-	{ 94452 },
+	{ 94410 },
 	/* l1d-stores-ops\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-ca... */
-	{ 94551 },
+	{ 94509 },
 	/* l1d-stores-reference\000legacy cache\000Level 1 data cache write acces=
ses\000leg... */
-	{ 94647 },
+	{ 94605 },
 	/* l1d-stores-refs\000legacy cache\000Level 1 data cache write accesses\0=
00legacy-c... */
-	{ 94749 },
+	{ 94707 },
 	/* l1d-write\000legacy cache\000Level 1 data cache write accesses\000lega=
cy-cache-c... */
-	{ 94846 },
+	{ 94804 },
 	/* l1d-write-access\000legacy cache\000Level 1 data cache write accesses\=
000legacy-... */
-	{ 94937 },
+	{ 94895 },
 	/* l1d-write-miss\000legacy cache\000Level 1 data cache write misses\000l=
egacy-cach... */
-	{ 95035 },
+	{ 94993 },
 	/* l1d-write-misses\000legacy cache\000Level 1 data cache write misses\00=
0legacy-ca... */
-	{ 95131 },
+	{ 95089 },
 	/* l1d-write-ops\000legacy cache\000Level 1 data cache write accesses\000=
legacy-cac... */
-	{ 95229 },
+	{ 95187 },
 	/* l1d-write-reference\000legacy cache\000Level 1 data cache write access=
es\000lega... */
-	{ 95324 },
+	{ 95282 },
 	/* l1d-write-refs\000legacy cache\000Level 1 data cache write accesses\00=
0legacy-ca... */
-	{ 95425 },
+	{ 95383 },
 	/* l1i\000legacy cache\000Level 1 instruction cache read accesses\000lega=
cy-cache-c... */
-	{ 95521 },
+	{ 95479 },
 	/* l1i-access\000legacy cache\000Level 1 instruction cache read accesses\=
000legacy-... */
-	{ 95608 },
+	{ 95566 },
 	/* l1i-load\000legacy cache\000Level 1 instruction cache read accesses\00=
0legacy-ca... */
-	{ 95702 },
+	{ 95660 },
 	/* l1i-load-access\000legacy cache\000Level 1 instruction cache read acce=
sses\000le... */
-	{ 95794 },
+	{ 95752 },
 	/* l1i-load-miss\000legacy cache\000Level 1 instruction cache read misses=
\000legacy... */
-	{ 95893 },
+	{ 95851 },
 	/* l1i-load-misses\000legacy cache\000Level 1 instruction cache read miss=
es\000lega... */
-	{ 95994 },
+	{ 95952 },
 	/* l1i-load-ops\000legacy cache\000Level 1 instruction cache read accesse=
s\000legac... */
-	{ 96097 },
+	{ 96055 },
 	/* l1i-load-reference\000legacy cache\000Level 1 instruction cache read a=
ccesses\00... */
-	{ 96193 },
+	{ 96151 },
 	/* l1i-load-refs\000legacy cache\000Level 1 instruction cache read access=
es\000lega... */
-	{ 96295 },
+	{ 96253 },
 	/* l1i-loads\000legacy cache\000Level 1 instruction cache read accesses\0=
00legacy-c... */
-	{ 96392 },
+	{ 96350 },
 	/* l1i-loads-access\000legacy cache\000Level 1 instruction cache read acc=
esses\000l... */
-	{ 96485 },
+	{ 96443 },
 	/* l1i-loads-miss\000legacy cache\000Level 1 instruction cache read misse=
s\000legac... */
-	{ 96585 },
+	{ 96543 },
 	/* l1i-loads-misses\000legacy cache\000Level 1 instruction cache read mis=
ses\000leg... */
-	{ 96687 },
+	{ 96645 },
 	/* l1i-loads-ops\000legacy cache\000Level 1 instruction cache read access=
es\000lega... */
-	{ 96791 },
+	{ 96749 },
 	/* l1i-loads-reference\000legacy cache\000Level 1 instruction cache read =
accesses\0... */
-	{ 96888 },
+	{ 96846 },
 	/* l1i-loads-refs\000legacy cache\000Level 1 instruction cache read acces=
ses\000leg... */
-	{ 96991 },
+	{ 96949 },
 	/* l1i-miss\000legacy cache\000Level 1 instruction cache read misses\000l=
egacy-cach... */
-	{ 97089 },
+	{ 97047 },
 	/* l1i-misses\000legacy cache\000Level 1 instruction cache read misses\00=
0legacy-ca... */
-	{ 97185 },
+	{ 97143 },
 	/* l1i-ops\000legacy cache\000Level 1 instruction cache read accesses\000=
legacy-cac... */
-	{ 97283 },
+	{ 97241 },
 	/* l1i-prefetch\000legacy cache\000Level 1 instruction cache prefetch acc=
esses\000l... */
-	{ 97374 },
+	{ 97332 },
 	/* l1i-prefetch-access\000legacy cache\000Level 1 instruction cache prefe=
tch access... */
-	{ 97478 },
+	{ 97436 },
 	/* l1i-prefetch-miss\000legacy cache\000Level 1 instruction cache prefetc=
h misses\0... */
-	{ 97589 },
+	{ 97547 },
 	/* l1i-prefetch-misses\000legacy cache\000Level 1 instruction cache prefe=
tch misses... */
-	{ 97698 },
+	{ 97656 },
 	/* l1i-prefetch-ops\000legacy cache\000Level 1 instruction cache prefetch=
 accesses\... */
-	{ 97809 },
+	{ 97767 },
 	/* l1i-prefetch-reference\000legacy cache\000Level 1 instruction cache pr=
efetch acc... */
-	{ 97917 },
+	{ 97875 },
 	/* l1i-prefetch-refs\000legacy cache\000Level 1 instruction cache prefetc=
h accesses... */
-	{ 98031 },
+	{ 97989 },
 	/* l1i-prefetches\000legacy cache\000Level 1 instruction cache prefetch a=
ccesses\00... */
-	{ 98140 },
+	{ 98098 },
 	/* l1i-prefetches-access\000legacy cache\000Level 1 instruction cache pre=
fetch acce... */
-	{ 98246 },
+	{ 98204 },
 	/* l1i-prefetches-miss\000legacy cache\000Level 1 instruction cache prefe=
tch misses... */
-	{ 98359 },
+	{ 98317 },
 	/* l1i-prefetches-misses\000legacy cache\000Level 1 instruction cache pre=
fetch miss... */
-	{ 98470 },
+	{ 98428 },
 	/* l1i-prefetches-ops\000legacy cache\000Level 1 instruction cache prefet=
ch accesse... */
-	{ 98583 },
+	{ 98541 },
 	/* l1i-prefetches-reference\000legacy cache\000Level 1 instruction cache =
prefetch a... */
-	{ 98693 },
+	{ 98651 },
 	/* l1i-prefetches-refs\000legacy cache\000Level 1 instruction cache prefe=
tch access... */
-	{ 98809 },
+	{ 98767 },
 	/* l1i-read\000legacy cache\000Level 1 instruction cache read accesses\00=
0legacy-ca... */
-	{ 98920 },
+	{ 98878 },
 	/* l1i-read-access\000legacy cache\000Level 1 instruction cache read acce=
sses\000le... */
-	{ 99012 },
+	{ 98970 },
 	/* l1i-read-miss\000legacy cache\000Level 1 instruction cache read misses=
\000legacy... */
-	{ 99111 },
+	{ 99069 },
 	/* l1i-read-misses\000legacy cache\000Level 1 instruction cache read miss=
es\000lega... */
-	{ 99212 },
+	{ 99170 },
 	/* l1i-read-ops\000legacy cache\000Level 1 instruction cache read accesse=
s\000legac... */
-	{ 99315 },
+	{ 99273 },
 	/* l1i-read-reference\000legacy cache\000Level 1 instruction cache read a=
ccesses\00... */
-	{ 99411 },
+	{ 99369 },
 	/* l1i-read-refs\000legacy cache\000Level 1 instruction cache read access=
es\000lega... */
-	{ 99513 },
+	{ 99471 },
 	/* l1i-reference\000legacy cache\000Level 1 instruction cache read access=
es\000lega... */
-	{ 99610 },
+	{ 99568 },
 	/* l1i-refs\000legacy cache\000Level 1 instruction cache read accesses\00=
0legacy-ca... */
-	{ 99707 },
+	{ 99665 },
 	/* l1i-speculative-load\000legacy cache\000Level 1 instruction cache pref=
etch acces... */
-	{ 99799 },
+	{ 99757 },
 	/* l1i-speculative-load-access\000legacy cache\000Level 1 instruction cac=
he prefetc... */
-	{ 99911 },
+	{ 99869 },
 	/* l1i-speculative-load-miss\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
-	{ 100030 },
+	{ 99988 },
 	/* l1i-speculative-load-misses\000legacy cache\000Level 1 instruction cac=
he prefetc... */
-	{ 100147 },
+	{ 100105 },
 	/* l1i-speculative-load-ops\000legacy cache\000Level 1 instruction cache =
prefetch a... */
-	{ 100266 },
+	{ 100224 },
 	/* l1i-speculative-load-reference\000legacy cache\000Level 1 instruction =
cache pref... */
-	{ 100382 },
+	{ 100340 },
 	/* l1i-speculative-load-refs\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
-	{ 100504 },
+	{ 100462 },
 	/* l1i-speculative-read\000legacy cache\000Level 1 instruction cache pref=
etch acces... */
-	{ 100621 },
+	{ 100579 },
 	/* l1i-speculative-read-access\000legacy cache\000Level 1 instruction cac=
he prefetc... */
-	{ 100733 },
+	{ 100691 },
 	/* l1i-speculative-read-miss\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
-	{ 100852 },
+	{ 100810 },
 	/* l1i-speculative-read-misses\000legacy cache\000Level 1 instruction cac=
he prefetc... */
-	{ 100969 },
+	{ 100927 },
 	/* l1i-speculative-read-ops\000legacy cache\000Level 1 instruction cache =
prefetch a... */
-	{ 101088 },
+	{ 101046 },
 	/* l1i-speculative-read-reference\000legacy cache\000Level 1 instruction =
cache pref... */
-	{ 101204 },
+	{ 101162 },
 	/* l1i-speculative-read-refs\000legacy cache\000Level 1 instruction cache=
 prefetch ... */
-	{ 101326 },
+	{ 101284 },
 	/* l2\000legacy cache\000Level 2 (or higher) last level cache read access=
es\000lega... */
-	{ 101443 },
+	{ 101401 },
 	/* l2-access\000legacy cache\000Level 2 (or higher) last level cache read=
 accesses\... */
-	{ 101540 },
+	{ 101498 },
 	/* l2-load\000legacy cache\000Level 2 (or higher) last level cache read a=
ccesses\00... */
-	{ 101644 },
+	{ 101602 },
 	/* l2-load-access\000legacy cache\000Level 2 (or higher) last level cache=
 read acce... */
-	{ 101746 },
+	{ 101704 },
 	/* l2-load-miss\000legacy cache\000Level 2 (or higher) last level cache r=
ead misses... */
-	{ 101855 },
+	{ 101813 },
 	/* l2-load-misses\000legacy cache\000Level 2 (or higher) last level cache=
 read miss... */
-	{ 101966 },
+	{ 101924 },
 	/* l2-load-ops\000legacy cache\000Level 2 (or higher) last level cache re=
ad accesse... */
-	{ 102079 },
+	{ 102037 },
 	/* l2-load-reference\000legacy cache\000Level 2 (or higher) last level ca=
che read a... */
-	{ 102185 },
+	{ 102143 },
 	/* l2-load-refs\000legacy cache\000Level 2 (or higher) last level cache r=
ead access... */
-	{ 102297 },
+	{ 102255 },
 	/* l2-loads\000legacy cache\000Level 2 (or higher) last level cache read =
accesses\0... */
-	{ 102404 },
+	{ 102362 },
 	/* l2-loads-access\000legacy cache\000Level 2 (or higher) last level cach=
e read acc... */
-	{ 102507 },
+	{ 102465 },
 	/* l2-loads-miss\000legacy cache\000Level 2 (or higher) last level cache =
read misse... */
-	{ 102617 },
+	{ 102575 },
 	/* l2-loads-misses\000legacy cache\000Level 2 (or higher) last level cach=
e read mis... */
-	{ 102729 },
+	{ 102687 },
 	/* l2-loads-ops\000legacy cache\000Level 2 (or higher) last level cache r=
ead access... */
-	{ 102843 },
+	{ 102801 },
 	/* l2-loads-reference\000legacy cache\000Level 2 (or higher) last level c=
ache read ... */
-	{ 102950 },
+	{ 102908 },
 	/* l2-loads-refs\000legacy cache\000Level 2 (or higher) last level cache =
read acces... */
-	{ 103063 },
+	{ 103021 },
 	/* l2-miss\000legacy cache\000Level 2 (or higher) last level cache read m=
isses\000l... */
-	{ 103171 },
+	{ 103129 },
 	/* l2-misses\000legacy cache\000Level 2 (or higher) last level cache read=
 misses\00... */
-	{ 103277 },
+	{ 103235 },
 	/* l2-ops\000legacy cache\000Level 2 (or higher) last level cache read ac=
cesses\000... */
-	{ 103385 },
+	{ 103343 },
 	/* l2-prefetch\000legacy cache\000Level 2 (or higher) last level cache pr=
efetch acc... */
-	{ 103486 },
+	{ 103444 },
 	/* l2-prefetch-access\000legacy cache\000Level 2 (or higher) last level c=
ache prefe... */
-	{ 103600 },
+	{ 103558 },
 	/* l2-prefetch-miss\000legacy cache\000Level 2 (or higher) last level cac=
he prefetc... */
-	{ 103721 },
+	{ 103679 },
 	/* l2-prefetch-misses\000legacy cache\000Level 2 (or higher) last level c=
ache prefe... */
-	{ 103840 },
+	{ 103798 },
 	/* l2-prefetch-ops\000legacy cache\000Level 2 (or higher) last level cach=
e prefetch... */
-	{ 103961 },
+	{ 103919 },
 	/* l2-prefetch-reference\000legacy cache\000Level 2 (or higher) last leve=
l cache pr... */
-	{ 104079 },
+	{ 104037 },
 	/* l2-prefetch-refs\000legacy cache\000Level 2 (or higher) last level cac=
he prefetc... */
-	{ 104203 },
+	{ 104161 },
 	/* l2-prefetches\000legacy cache\000Level 2 (or higher) last level cache =
prefetch a... */
-	{ 104322 },
+	{ 104280 },
 	/* l2-prefetches-access\000legacy cache\000Level 2 (or higher) last level=
 cache pre... */
-	{ 104438 },
+	{ 104396 },
 	/* l2-prefetches-miss\000legacy cache\000Level 2 (or higher) last level c=
ache prefe... */
-	{ 104561 },
+	{ 104519 },
 	/* l2-prefetches-misses\000legacy cache\000Level 2 (or higher) last level=
 cache pre... */
-	{ 104682 },
+	{ 104640 },
 	/* l2-prefetches-ops\000legacy cache\000Level 2 (or higher) last level ca=
che prefet... */
-	{ 104805 },
+	{ 104763 },
 	/* l2-prefetches-reference\000legacy cache\000Level 2 (or higher) last le=
vel cache ... */
-	{ 104925 },
+	{ 104883 },
 	/* l2-prefetches-refs\000legacy cache\000Level 2 (or higher) last level c=
ache prefe... */
-	{ 105051 },
+	{ 105009 },
 	/* l2-read\000legacy cache\000Level 2 (or higher) last level cache read a=
ccesses\00... */
-	{ 105172 },
+	{ 105130 },
 	/* l2-read-access\000legacy cache\000Level 2 (or higher) last level cache=
 read acce... */
-	{ 105274 },
+	{ 105232 },
 	/* l2-read-miss\000legacy cache\000Level 2 (or higher) last level cache r=
ead misses... */
-	{ 105383 },
+	{ 105341 },
 	/* l2-read-misses\000legacy cache\000Level 2 (or higher) last level cache=
 read miss... */
-	{ 105494 },
+	{ 105452 },
 	/* l2-read-ops\000legacy cache\000Level 2 (or higher) last level cache re=
ad accesse... */
-	{ 105607 },
+	{ 105565 },
 	/* l2-read-reference\000legacy cache\000Level 2 (or higher) last level ca=
che read a... */
-	{ 105713 },
+	{ 105671 },
 	/* l2-read-refs\000legacy cache\000Level 2 (or higher) last level cache r=
ead access... */
-	{ 105825 },
+	{ 105783 },
 	/* l2-reference\000legacy cache\000Level 2 (or higher) last level cache r=
ead access... */
-	{ 105932 },
+	{ 105890 },
 	/* l2-refs\000legacy cache\000Level 2 (or higher) last level cache read a=
ccesses\00... */
-	{ 106039 },
+	{ 105997 },
 	/* l2-speculative-load\000legacy cache\000Level 2 (or higher) last level =
cache pref... */
-	{ 106141 },
+	{ 106099 },
 	/* l2-speculative-load-access\000legacy cache\000Level 2 (or higher) last=
 level cac... */
-	{ 106263 },
+	{ 106221 },
 	/* l2-speculative-load-miss\000legacy cache\000Level 2 (or higher) last l=
evel cache... */
-	{ 106392 },
+	{ 106350 },
 	/* l2-speculative-load-misses\000legacy cache\000Level 2 (or higher) last=
 level cac... */
-	{ 106519 },
+	{ 106477 },
 	/* l2-speculative-load-ops\000legacy cache\000Level 2 (or higher) last le=
vel cache ... */
-	{ 106648 },
+	{ 106606 },
 	/* l2-speculative-load-reference\000legacy cache\000Level 2 (or higher) l=
ast level ... */
-	{ 106774 },
+	{ 106732 },
 	/* l2-speculative-load-refs\000legacy cache\000Level 2 (or higher) last l=
evel cache... */
-	{ 106906 },
+	{ 106864 },
 	/* l2-speculative-read\000legacy cache\000Level 2 (or higher) last level =
cache pref... */
-	{ 107033 },
+	{ 106991 },
 	/* l2-speculative-read-access\000legacy cache\000Level 2 (or higher) last=
 level cac... */
-	{ 107155 },
+	{ 107113 },
 	/* l2-speculative-read-miss\000legacy cache\000Level 2 (or higher) last l=
evel cache... */
-	{ 107284 },
+	{ 107242 },
 	/* l2-speculative-read-misses\000legacy cache\000Level 2 (or higher) last=
 level cac... */
-	{ 107411 },
+	{ 107369 },
 	/* l2-speculative-read-ops\000legacy cache\000Level 2 (or higher) last le=
vel cache ... */
-	{ 107540 },
+	{ 107498 },
 	/* l2-speculative-read-reference\000legacy cache\000Level 2 (or higher) l=
ast level ... */
-	{ 107666 },
+	{ 107624 },
 	/* l2-speculative-read-refs\000legacy cache\000Level 2 (or higher) last l=
evel cache... */
-	{ 107798 },
+	{ 107756 },
 	/* l2-store\000legacy cache\000Level 2 (or higher) last level cache write=
 accesses\... */
-	{ 107925 },
+	{ 107883 },
 	/* l2-store-access\000legacy cache\000Level 2 (or higher) last level cach=
e write ac... */
-	{ 108033 },
+	{ 107991 },
 	/* l2-store-miss\000legacy cache\000Level 2 (or higher) last level cache =
write miss... */
-	{ 108148 },
+	{ 108106 },
 	/* l2-store-misses\000legacy cache\000Level 2 (or higher) last level cach=
e write mi... */
-	{ 108261 },
+	{ 108219 },
 	/* l2-store-ops\000legacy cache\000Level 2 (or higher) last level cache w=
rite acces... */
-	{ 108376 },
+	{ 108334 },
 	/* l2-store-reference\000legacy cache\000Level 2 (or higher) last level c=
ache write... */
-	{ 108488 },
+	{ 108446 },
 	/* l2-store-refs\000legacy cache\000Level 2 (or higher) last level cache =
write acce... */
-	{ 108606 },
+	{ 108564 },
 	/* l2-stores\000legacy cache\000Level 2 (or higher) last level cache writ=
e accesses... */
-	{ 108719 },
+	{ 108677 },
 	/* l2-stores-access\000legacy cache\000Level 2 (or higher) last level cac=
he write a... */
-	{ 108828 },
+	{ 108786 },
 	/* l2-stores-miss\000legacy cache\000Level 2 (or higher) last level cache=
 write mis... */
-	{ 108944 },
+	{ 108902 },
 	/* l2-stores-misses\000legacy cache\000Level 2 (or higher) last level cac=
he write m... */
-	{ 109058 },
+	{ 109016 },
 	/* l2-stores-ops\000legacy cache\000Level 2 (or higher) last level cache =
write acce... */
-	{ 109174 },
+	{ 109132 },
 	/* l2-stores-reference\000legacy cache\000Level 2 (or higher) last level =
cache writ... */
-	{ 109287 },
+	{ 109245 },
 	/* l2-stores-refs\000legacy cache\000Level 2 (or higher) last level cache=
 write acc... */
-	{ 109406 },
+	{ 109364 },
 	/* l2-write\000legacy cache\000Level 2 (or higher) last level cache write=
 accesses\... */
-	{ 109520 },
+	{ 109478 },
 	/* l2-write-access\000legacy cache\000Level 2 (or higher) last level cach=
e write ac... */
-	{ 109628 },
+	{ 109586 },
 	/* l2-write-miss\000legacy cache\000Level 2 (or higher) last level cache =
write miss... */
-	{ 109743 },
+	{ 109701 },
 	/* l2-write-misses\000legacy cache\000Level 2 (or higher) last level cach=
e write mi... */
-	{ 109856 },
+	{ 109814 },
 	/* l2-write-ops\000legacy cache\000Level 2 (or higher) last level cache w=
rite acces... */
-	{ 109971 },
+	{ 109929 },
 	/* l2-write-reference\000legacy cache\000Level 2 (or higher) last level c=
ache write... */
-	{ 110083 },
+	{ 110041 },
 	/* l2-write-refs\000legacy cache\000Level 2 (or higher) last level cache =
write acce... */
-	{ 110201 },
+	{ 110159 },
 	/* llc\000legacy cache\000Last level cache read accesses\000legacy-cache-=
config=3D2\0... */
-	{ 110412 },
+	{ 110370 },
 	/* llc-access\000legacy cache\000Last level cache read accesses\000legacy=
-cache-con... */
-	{ 110490 },
+	{ 110448 },
 	/* llc-load\000legacy cache\000Last level cache read accesses\000legacy-c=
ache-confi... */
-	{ 110575 },
+	{ 110533 },
 	/* llc-load-access\000legacy cache\000Last level cache read accesses\000l=
egacy-cach... */
-	{ 110658 },
+	{ 110616 },
 	/* llc-load-miss\000legacy cache\000Last level cache read misses\000legac=
y-cache-co... */
-	{ 110748 },
+	{ 110706 },
 	/* llc-load-misses\000legacy cache\000Last level cache read misses\000leg=
acy-cache-... */
-	{ 110840 },
+	{ 110798 },
 	/* llc-load-ops\000legacy cache\000Last level cache read accesses\000lega=
cy-cache-c... */
-	{ 110934 },
+	{ 110892 },
 	/* llc-load-reference\000legacy cache\000Last level cache read accesses\0=
00legacy-c... */
-	{ 111021 },
+	{ 110979 },
 	/* llc-load-refs\000legacy cache\000Last level cache read accesses\000leg=
acy-cache-... */
-	{ 111114 },
+	{ 111072 },
 	/* llc-loads\000legacy cache\000Last level cache read accesses\000legacy-=
cache-conf... */
-	{ 111202 },
+	{ 111160 },
 	/* llc-loads-access\000legacy cache\000Last level cache read accesses\000=
legacy-cac... */
-	{ 111286 },
+	{ 111244 },
 	/* llc-loads-miss\000legacy cache\000Last level cache read misses\000lega=
cy-cache-c... */
-	{ 111377 },
+	{ 111335 },
 	/* llc-loads-misses\000legacy cache\000Last level cache read misses\000le=
gacy-cache... */
-	{ 111470 },
+	{ 111428 },
 	/* llc-loads-ops\000legacy cache\000Last level cache read accesses\000leg=
acy-cache-... */
-	{ 111565 },
+	{ 111523 },
 	/* llc-loads-reference\000legacy cache\000Last level cache read accesses\=
000legacy-... */
-	{ 111653 },
+	{ 111611 },
 	/* llc-loads-refs\000legacy cache\000Last level cache read accesses\000le=
gacy-cache... */
-	{ 111747 },
+	{ 111705 },
 	/* llc-miss\000legacy cache\000Last level cache read misses\000legacy-cac=
he-config=3D... */
-	{ 111836 },
+	{ 111794 },
 	/* llc-misses\000legacy cache\000Last level cache read misses\000legacy-c=
ache-confi... */
-	{ 111923 },
+	{ 111881 },
 	/* llc-ops\000legacy cache\000Last level cache read accesses\000legacy-ca=
che-config... */
-	{ 112012 },
+	{ 111970 },
 	/* llc-prefetch\000legacy cache\000Last level cache prefetch accesses\000=
legacy-cac... */
-	{ 112094 },
+	{ 112052 },
 	/* llc-prefetch-access\000legacy cache\000Last level cache prefetch acces=
ses\000leg... */
-	{ 112189 },
+	{ 112147 },
 	/* llc-prefetch-miss\000legacy cache\000Last level cache prefetch misses\=
000legacy-... */
-	{ 112291 },
+	{ 112249 },
 	/* llc-prefetch-misses\000legacy cache\000Last level cache prefetch misse=
s\000legac... */
-	{ 112391 },
+	{ 112349 },
 	/* llc-prefetch-ops\000legacy cache\000Last level cache prefetch accesses=
\000legacy... */
-	{ 112493 },
+	{ 112451 },
 	/* llc-prefetch-reference\000legacy cache\000Last level cache prefetch ac=
cesses\000... */
-	{ 112592 },
+	{ 112550 },
 	/* llc-prefetch-refs\000legacy cache\000Last level cache prefetch accesse=
s\000legac... */
-	{ 112697 },
+	{ 112655 },
 	/* llc-prefetches\000legacy cache\000Last level cache prefetch accesses\0=
00legacy-c... */
-	{ 112797 },
+	{ 112755 },
 	/* llc-prefetches-access\000legacy cache\000Last level cache prefetch acc=
esses\000l... */
-	{ 112894 },
+	{ 112852 },
 	/* llc-prefetches-miss\000legacy cache\000Last level cache prefetch misse=
s\000legac... */
-	{ 112998 },
+	{ 112956 },
 	/* llc-prefetches-misses\000legacy cache\000Last level cache prefetch mis=
ses\000leg... */
-	{ 113100 },
+	{ 113058 },
 	/* llc-prefetches-ops\000legacy cache\000Last level cache prefetch access=
es\000lega... */
-	{ 113204 },
+	{ 113162 },
 	/* llc-prefetches-reference\000legacy cache\000Last level cache prefetch =
accesses\0... */
-	{ 113305 },
+	{ 113263 },
 	/* llc-prefetches-refs\000legacy cache\000Last level cache prefetch acces=
ses\000leg... */
-	{ 113412 },
+	{ 113370 },
 	/* llc-read\000legacy cache\000Last level cache read accesses\000legacy-c=
ache-confi... */
-	{ 113514 },
+	{ 113472 },
 	/* llc-read-access\000legacy cache\000Last level cache read accesses\000l=
egacy-cach... */
-	{ 113597 },
+	{ 113555 },
 	/* llc-read-miss\000legacy cache\000Last level cache read misses\000legac=
y-cache-co... */
-	{ 113687 },
+	{ 113645 },
 	/* llc-read-misses\000legacy cache\000Last level cache read misses\000leg=
acy-cache-... */
-	{ 113779 },
+	{ 113737 },
 	/* llc-read-ops\000legacy cache\000Last level cache read accesses\000lega=
cy-cache-c... */
-	{ 113873 },
+	{ 113831 },
 	/* llc-read-reference\000legacy cache\000Last level cache read accesses\0=
00legacy-c... */
-	{ 113960 },
+	{ 113918 },
 	/* llc-read-refs\000legacy cache\000Last level cache read accesses\000leg=
acy-cache-... */
-	{ 114053 },
+	{ 114011 },
 	/* llc-reference\000legacy cache\000Last level cache read accesses\000leg=
acy-cache-... */
-	{ 114141 },
+	{ 114099 },
 	/* llc-refs\000legacy cache\000Last level cache read accesses\000legacy-c=
ache-confi... */
-	{ 114229 },
+	{ 114187 },
 	/* llc-speculative-load\000legacy cache\000Last level cache prefetch acce=
sses\000le... */
-	{ 114312 },
+	{ 114270 },
 	/* llc-speculative-load-access\000legacy cache\000Last level cache prefet=
ch accesse... */
-	{ 114415 },
+	{ 114373 },
 	/* llc-speculative-load-miss\000legacy cache\000Last level cache prefetch=
 misses\00... */
-	{ 114525 },
+	{ 114483 },
 	/* llc-speculative-load-misses\000legacy cache\000Last level cache prefet=
ch misses\... */
-	{ 114633 },
+	{ 114591 },
 	/* llc-speculative-load-ops\000legacy cache\000Last level cache prefetch =
accesses\0... */
-	{ 114743 },
+	{ 114701 },
 	/* llc-speculative-load-reference\000legacy cache\000Last level cache pre=
fetch acce... */
-	{ 114850 },
+	{ 114808 },
 	/* llc-speculative-load-refs\000legacy cache\000Last level cache prefetch=
 accesses\... */
-	{ 114963 },
+	{ 114921 },
 	/* llc-speculative-read\000legacy cache\000Last level cache prefetch acce=
sses\000le... */
-	{ 115071 },
+	{ 115029 },
 	/* llc-speculative-read-access\000legacy cache\000Last level cache prefet=
ch accesse... */
-	{ 115174 },
+	{ 115132 },
 	/* llc-speculative-read-miss\000legacy cache\000Last level cache prefetch=
 misses\00... */
-	{ 115284 },
+	{ 115242 },
 	/* llc-speculative-read-misses\000legacy cache\000Last level cache prefet=
ch misses\... */
-	{ 115392 },
+	{ 115350 },
 	/* llc-speculative-read-ops\000legacy cache\000Last level cache prefetch =
accesses\0... */
-	{ 115502 },
+	{ 115460 },
 	/* llc-speculative-read-reference\000legacy cache\000Last level cache pre=
fetch acce... */
-	{ 115609 },
+	{ 115567 },
 	/* llc-speculative-read-refs\000legacy cache\000Last level cache prefetch=
 accesses\... */
-	{ 115722 },
+	{ 115680 },
 	/* llc-store\000legacy cache\000Last level cache write accesses\000legacy=
-cache-con... */
-	{ 115830 },
+	{ 115788 },
 	/* llc-store-access\000legacy cache\000Last level cache write accesses\00=
0legacy-ca... */
-	{ 115919 },
+	{ 115877 },
 	/* llc-store-miss\000legacy cache\000Last level cache write misses\000leg=
acy-cache-... */
-	{ 116015 },
+	{ 115973 },
 	/* llc-store-misses\000legacy cache\000Last level cache write misses\000l=
egacy-cach... */
-	{ 116109 },
+	{ 116067 },
 	/* llc-store-ops\000legacy cache\000Last level cache write accesses\000le=
gacy-cache... */
-	{ 116205 },
+	{ 116163 },
 	/* llc-store-reference\000legacy cache\000Last level cache write accesses=
\000legacy... */
-	{ 116298 },
+	{ 116256 },
 	/* llc-store-refs\000legacy cache\000Last level cache write accesses\000l=
egacy-cach... */
-	{ 116397 },
+	{ 116355 },
 	/* llc-stores\000legacy cache\000Last level cache write accesses\000legac=
y-cache-co... */
-	{ 116491 },
+	{ 116449 },
 	/* llc-stores-access\000legacy cache\000Last level cache write accesses\0=
00legacy-c... */
-	{ 116581 },
+	{ 116539 },
 	/* llc-stores-miss\000legacy cache\000Last level cache write misses\000le=
gacy-cache... */
-	{ 116678 },
+	{ 116636 },
 	/* llc-stores-misses\000legacy cache\000Last level cache write misses\000=
legacy-cac... */
-	{ 116773 },
+	{ 116731 },
 	/* llc-stores-ops\000legacy cache\000Last level cache write accesses\000l=
egacy-cach... */
-	{ 116870 },
+	{ 116828 },
 	/* llc-stores-reference\000legacy cache\000Last level cache write accesse=
s\000legac... */
-	{ 116964 },
+	{ 116922 },
 	/* llc-stores-refs\000legacy cache\000Last level cache write accesses\000=
legacy-cac... */
-	{ 117064 },
+	{ 117022 },
 	/* llc-write\000legacy cache\000Last level cache write accesses\000legacy=
-cache-con... */
-	{ 117159 },
+	{ 117117 },
 	/* llc-write-access\000legacy cache\000Last level cache write accesses\00=
0legacy-ca... */
-	{ 117248 },
+	{ 117206 },
 	/* llc-write-miss\000legacy cache\000Last level cache write misses\000leg=
acy-cache-... */
-	{ 117344 },
+	{ 117302 },
 	/* llc-write-misses\000legacy cache\000Last level cache write misses\000l=
egacy-cach... */
-	{ 117438 },
+	{ 117396 },
 	/* llc-write-ops\000legacy cache\000Last level cache write accesses\000le=
gacy-cache... */
-	{ 117534 },
+	{ 117492 },
 	/* llc-write-reference\000legacy cache\000Last level cache write accesses=
\000legacy... */
-	{ 117627 },
+	{ 117585 },
 	/* llc-write-refs\000legacy cache\000Last level cache write accesses\000l=
egacy-cach... */
-	{ 117726 },
+	{ 117684 },
 	/* node\000legacy cache\000Local memory read accesses\000legacy-cache-con=
fig=3D6\000\... */
-	{ 118164 },
+	{ 118122 },
 	/* node-access\000legacy cache\000Local memory read accesses\000legacy-ca=
che-config... */
-	{ 118239 },
+	{ 118197 },
 	/* node-load\000legacy cache\000Local memory read accesses\000legacy-cach=
e-config=3D6... */
-	{ 118321 },
+	{ 118279 },
 	/* node-load-access\000legacy cache\000Local memory read accesses\000lega=
cy-cache-c... */
-	{ 118401 },
+	{ 118359 },
 	/* node-load-miss\000legacy cache\000Local memory read misses\000legacy-c=
ache-confi... */
-	{ 118488 },
+	{ 118446 },
 	/* node-load-misses\000legacy cache\000Local memory read misses\000legacy=
-cache-con... */
-	{ 118577 },
+	{ 118535 },
 	/* node-load-ops\000legacy cache\000Local memory read accesses\000legacy-=
cache-conf... */
-	{ 118668 },
+	{ 118626 },
 	/* node-load-reference\000legacy cache\000Local memory read accesses\000l=
egacy-cach... */
-	{ 118752 },
+	{ 118710 },
 	/* node-load-refs\000legacy cache\000Local memory read accesses\000legacy=
-cache-con... */
-	{ 118842 },
+	{ 118800 },
 	/* node-loads\000legacy cache\000Local memory read accesses\000legacy-cac=
he-config=3D... */
-	{ 118927 },
+	{ 118885 },
 	/* node-loads-access\000legacy cache\000Local memory read accesses\000leg=
acy-cache-... */
-	{ 119008 },
+	{ 118966 },
 	/* node-loads-miss\000legacy cache\000Local memory read misses\000legacy-=
cache-conf... */
-	{ 119096 },
+	{ 119054 },
 	/* node-loads-misses\000legacy cache\000Local memory read misses\000legac=
y-cache-co... */
-	{ 119186 },
+	{ 119144 },
 	/* node-loads-ops\000legacy cache\000Local memory read accesses\000legacy=
-cache-con... */
-	{ 119278 },
+	{ 119236 },
 	/* node-loads-reference\000legacy cache\000Local memory read accesses\000=
legacy-cac... */
-	{ 119363 },
+	{ 119321 },
 	/* node-loads-refs\000legacy cache\000Local memory read accesses\000legac=
y-cache-co... */
-	{ 119454 },
+	{ 119412 },
 	/* node-miss\000legacy cache\000Local memory read misses\000legacy-cache-=
config=3D0x1... */
-	{ 119540 },
+	{ 119498 },
 	/* node-misses\000legacy cache\000Local memory read misses\000legacy-cach=
e-config=3D0... */
-	{ 119624 },
+	{ 119582 },
 	/* node-ops\000legacy cache\000Local memory read accesses\000legacy-cache=
-config=3D6\... */
-	{ 119710 },
+	{ 119668 },
 	/* node-prefetch\000legacy cache\000Local memory prefetch accesses\000leg=
acy-cache-... */
-	{ 119789 },
+	{ 119747 },
 	/* node-prefetch-access\000legacy cache\000Local memory prefetch accesses=
\000legacy... */
-	{ 119881 },
+	{ 119839 },
 	/* node-prefetch-miss\000legacy cache\000Local memory prefetch misses\000=
legacy-cac... */
-	{ 119980 },
+	{ 119938 },
 	/* node-prefetch-misses\000legacy cache\000Local memory prefetch misses\0=
00legacy-c... */
-	{ 120077 },
+	{ 120035 },
 	/* node-prefetch-ops\000legacy cache\000Local memory prefetch accesses\00=
0legacy-ca... */
-	{ 120176 },
+	{ 120134 },
 	/* node-prefetch-reference\000legacy cache\000Local memory prefetch acces=
ses\000leg... */
-	{ 120272 },
+	{ 120230 },
 	/* node-prefetch-refs\000legacy cache\000Local memory prefetch accesses\0=
00legacy-c... */
-	{ 120374 },
+	{ 120332 },
 	/* node-prefetches\000legacy cache\000Local memory prefetch accesses\000l=
egacy-cach... */
-	{ 120471 },
+	{ 120429 },
 	/* node-prefetches-access\000legacy cache\000Local memory prefetch access=
es\000lega... */
-	{ 120565 },
+	{ 120523 },
 	/* node-prefetches-miss\000legacy cache\000Local memory prefetch misses\0=
00legacy-c... */
-	{ 120666 },
+	{ 120624 },
 	/* node-prefetches-misses\000legacy cache\000Local memory prefetch misses=
\000legacy... */
-	{ 120765 },
+	{ 120723 },
 	/* node-prefetches-ops\000legacy cache\000Local memory prefetch accesses\=
000legacy-... */
-	{ 120866 },
+	{ 120824 },
 	/* node-prefetches-reference\000legacy cache\000Local memory prefetch acc=
esses\000l... */
-	{ 120964 },
+	{ 120922 },
 	/* node-prefetches-refs\000legacy cache\000Local memory prefetch accesses=
\000legacy... */
-	{ 121068 },
+	{ 121026 },
 	/* node-read\000legacy cache\000Local memory read accesses\000legacy-cach=
e-config=3D6... */
-	{ 121167 },
+	{ 121125 },
 	/* node-read-access\000legacy cache\000Local memory read accesses\000lega=
cy-cache-c... */
-	{ 121247 },
+	{ 121205 },
 	/* node-read-miss\000legacy cache\000Local memory read misses\000legacy-c=
ache-confi... */
-	{ 121334 },
+	{ 121292 },
 	/* node-read-misses\000legacy cache\000Local memory read misses\000legacy=
-cache-con... */
-	{ 121423 },
+	{ 121381 },
 	/* node-read-ops\000legacy cache\000Local memory read accesses\000legacy-=
cache-conf... */
-	{ 121514 },
+	{ 121472 },
 	/* node-read-reference\000legacy cache\000Local memory read accesses\000l=
egacy-cach... */
-	{ 121598 },
+	{ 121556 },
 	/* node-read-refs\000legacy cache\000Local memory read accesses\000legacy=
-cache-con... */
-	{ 121688 },
+	{ 121646 },
 	/* node-reference\000legacy cache\000Local memory read accesses\000legacy=
-cache-con... */
-	{ 121773 },
+	{ 121731 },
 	/* node-refs\000legacy cache\000Local memory read accesses\000legacy-cach=
e-config=3D6... */
-	{ 121858 },
+	{ 121816 },
 	/* node-speculative-load\000legacy cache\000Local memory prefetch accesse=
s\000legac... */
-	{ 121938 },
+	{ 121896 },
 	/* node-speculative-load-access\000legacy cache\000Local memory prefetch =
accesses\0... */
-	{ 122038 },
+	{ 121996 },
 	/* node-speculative-load-miss\000legacy cache\000Local memory prefetch mi=
sses\000le... */
-	{ 122145 },
+	{ 122103 },
 	/* node-speculative-load-misses\000legacy cache\000Local memory prefetch =
misses\000... */
-	{ 122250 },
+	{ 122208 },
 	/* node-speculative-load-ops\000legacy cache\000Local memory prefetch acc=
esses\000l... */
-	{ 122357 },
+	{ 122315 },
 	/* node-speculative-load-reference\000legacy cache\000Local memory prefet=
ch accesse... */
-	{ 122461 },
+	{ 122419 },
 	/* node-speculative-load-refs\000legacy cache\000Local memory prefetch ac=
cesses\000... */
-	{ 122571 },
+	{ 122529 },
 	/* node-speculative-read\000legacy cache\000Local memory prefetch accesse=
s\000legac... */
-	{ 122676 },
+	{ 122634 },
 	/* node-speculative-read-access\000legacy cache\000Local memory prefetch =
accesses\0... */
-	{ 122776 },
+	{ 122734 },
 	/* node-speculative-read-miss\000legacy cache\000Local memory prefetch mi=
sses\000le... */
-	{ 122883 },
+	{ 122841 },
 	/* node-speculative-read-misses\000legacy cache\000Local memory prefetch =
misses\000... */
-	{ 122988 },
+	{ 122946 },
 	/* node-speculative-read-ops\000legacy cache\000Local memory prefetch acc=
esses\000l... */
-	{ 123095 },
+	{ 123053 },
 	/* node-speculative-read-reference\000legacy cache\000Local memory prefet=
ch accesse... */
-	{ 123199 },
+	{ 123157 },
 	/* node-speculative-read-refs\000legacy cache\000Local memory prefetch ac=
cesses\000... */
-	{ 123309 },
+	{ 123267 },
 	/* node-store\000legacy cache\000Local memory write accesses\000legacy-ca=
che-config... */
-	{ 123414 },
+	{ 123372 },
 	/* node-store-access\000legacy cache\000Local memory write accesses\000le=
gacy-cache... */
-	{ 123500 },
+	{ 123458 },
 	/* node-store-miss\000legacy cache\000Local memory write misses\000legacy=
-cache-con... */
-	{ 123593 },
+	{ 123551 },
 	/* node-store-misses\000legacy cache\000Local memory write misses\000lega=
cy-cache-c... */
-	{ 123684 },
+	{ 123642 },
 	/* node-store-ops\000legacy cache\000Local memory write accesses\000legac=
y-cache-co... */
-	{ 123777 },
+	{ 123735 },
 	/* node-store-reference\000legacy cache\000Local memory write accesses\00=
0legacy-ca... */
-	{ 123867 },
+	{ 123825 },
 	/* node-store-refs\000legacy cache\000Local memory write accesses\000lega=
cy-cache-c... */
-	{ 123963 },
+	{ 123921 },
 	/* node-stores\000legacy cache\000Local memory write accesses\000legacy-c=
ache-confi... */
-	{ 124054 },
+	{ 124012 },
 	/* node-stores-access\000legacy cache\000Local memory write accesses\000l=
egacy-cach... */
-	{ 124141 },
+	{ 124099 },
 	/* node-stores-miss\000legacy cache\000Local memory write misses\000legac=
y-cache-co... */
-	{ 124235 },
+	{ 124193 },
 	/* node-stores-misses\000legacy cache\000Local memory write misses\000leg=
acy-cache-... */
-	{ 124327 },
+	{ 124285 },
 	/* node-stores-ops\000legacy cache\000Local memory write accesses\000lega=
cy-cache-c... */
-	{ 124421 },
+	{ 124379 },
 	/* node-stores-reference\000legacy cache\000Local memory write accesses\0=
00legacy-c... */
-	{ 124512 },
+	{ 124470 },
 	/* node-stores-refs\000legacy cache\000Local memory write accesses\000leg=
acy-cache-... */
-	{ 124609 },
+	{ 124567 },
 	/* node-write\000legacy cache\000Local memory write accesses\000legacy-ca=
che-config... */
-	{ 124701 },
+	{ 124659 },
 	/* node-write-access\000legacy cache\000Local memory write accesses\000le=
gacy-cache... */
-	{ 124787 },
+	{ 124745 },
 	/* node-write-miss\000legacy cache\000Local memory write misses\000legacy=
-cache-con... */
-	{ 124880 },
+	{ 124838 },
 	/* node-write-misses\000legacy cache\000Local memory write misses\000lega=
cy-cache-c... */
-	{ 124971 },
+	{ 124929 },
 	/* node-write-ops\000legacy cache\000Local memory write accesses\000legac=
y-cache-co... */
-	{ 125064 },
+	{ 125022 },
 	/* node-write-reference\000legacy cache\000Local memory write accesses\00=
0legacy-ca... */
-	{ 125154 },
+	{ 125112 },
 	/* node-write-refs\000legacy cache\000Local memory write accesses\000lega=
cy-cache-c... */
-	{ 125250 },
+	{ 125208 },
 	/* ref-cycles\000legacy hardware\000Total cycles; not affected by CPU fre=
quency sca... */
-	{ 125963 },
+	{ 125921 },
 	/* stalled-cycles-backend\000legacy hardware\000Stalled cycles during ret=
irement [T... */
-	{ 126403 },
+	{ 126352 },
 	/* stalled-cycles-frontend\000legacy hardware\000Stalled cycles during is=
sue [This ... */
-	{ 126556 },
+	{ 126505 },
 };
 static const struct compact_pmu_event pmu_events__common_software[] =3D {
 	/* alignment-faults\000software\000Number of kernel handled memory alignm=
ent faults... */
@@ -5135,115 +5113,115 @@ static const struct compact_pmu_event pmu_events_=
_common_software[] =3D {
 	/* cs\000software\000Number of context switches [This event is an alias o=
f context-... */
 	{ 15283 },
 	/* dummy\000software\000A placeholder event that doesn't count anything\0=
00config=3D9... */
-	{ 36684 },
+	{ 36671 },
 	/* emulation-faults\000software\000Number of kernel handled unimplemented=
 instructi... */
-	{ 36958 },
+	{ 36945 },
 	/* faults\000software\000Number of page faults [This event is an alias of=
 page-faul... */
-	{ 37197 },
+	{ 37184 },
 	/* major-faults\000software\000Number of major page faults. Major faults =
require I/... */
-	{ 117820 },
+	{ 117778 },
 	/* migrations\000software\000Number of times a process has migrated to a =
new CPU [T... */
-	{ 117923 },
+	{ 117881 },
 	/* minor-faults\000software\000Number of minor page faults. Minor faults =
don't requ... */
-	{ 118055 },
+	{ 118013 },
 	/* page-faults\000software\000Number of page faults [This event is an ali=
as of faul... */
-	{ 125868 },
+	{ 125826 },
 	/* task-clock\000software\000Per-task high-resolution timer based event\0=
00config=3D1... */
-	{ 127253 },
+	{ 127202 },
 };
 static const struct compact_pmu_event pmu_events__common_tool[] =3D {
 	/* core_wide\000tool\0001 if not SMT, if SMT are events being gathered on=
 all SMT t... */
 	{ 14789 },
 	/* duration_time\000tool\000Wall clock interval time in nanoseconds\000co=
nfig=3D1\000... */
-	{ 36764 },
+	{ 36751 },
 	/* has_pmem\000tool\0001 if persistent memory installed otherwise 0\000co=
nfig=3D4\000... */
-	{ 37292 },
+	{ 37279 },
 	/* num_cores\000tool\000Number of cores. A core consists of 1 or more thr=
ead, with ... */
-	{ 125341 },
+	{ 125299 },
 	/* num_cpus\000tool\000Number of logical Linux CPUs. There may be multipl=
e such CPU... */
-	{ 125486 },
+	{ 125444 },
 	/* num_cpus_online\000tool\000Number of online logical Linux CPUs. There =
may be mul... */
-	{ 125589 },
+	{ 125547 },
 	/* num_dies\000tool\000Number of dies. Each die has 1 or more cores\000co=
nfig=3D8\000... */
-	{ 125706 },
+	{ 125664 },
 	/* num_packages\000tool\000Number of packages. Each package has 1 or more=
 die\000co... */
-	{ 125782 },
+	{ 125740 },
 	/* slots\000tool\000Number of functional units that in parallel can execu=
te parts o... */
-	{ 126177 },
+	{ 126135 },
 	/* smt_on\000tool\0001 if simultaneous multithreading (aka hyperthreading=
) is enabl... */
-	{ 126287 },
+	{ 126245 },
 	/* system_time\000tool\000System/kernel time in nanoseconds\000config=3D3=
\000\00000\0... */
-	{ 127002 },
+	{ 126951 },
 	/* system_tsc_freq\000tool\000The amount a Time Stamp Counter (TSC) incre=
ases per s... */
-	{ 127070 },
+	{ 127019 },
 	/* target_cpu\000tool\0001 if CPUs being analyzed, 0 if threads/processes=
\000config... */
-	{ 127169 },
+	{ 127118 },
 	/* user_time\000tool\000User (non-kernel) time in nanoseconds\000config=
=3D2\000\00000... */
-	{ 127887 },
+	{ 127727 },
=20
 };
=20
 static const struct pmu_table_entry pmu_events__common[] =3D {
 	{
 		.entries =3D pmu_events__common_default_core,
+		.pmu_name =3D "default_core",
 		.num_entries =3D ARRAY_SIZE(pmu_events__common_default_core),
-		.pmu_name =3D { 29669 /* default_core\000 */ },
 	},
 	{
 		.entries =3D pmu_events__common_software,
+		.pmu_name =3D "software",
 		.num_entries =3D ARRAY_SIZE(pmu_events__common_software),
-		.pmu_name =3D { 126394 /* software\000 */ },
 	},
 	{
 		.entries =3D pmu_events__common_tool,
+		.pmu_name =3D "tool",
 		.num_entries =3D ARRAY_SIZE(pmu_events__common_tool),
-		.pmu_name =3D { 127341 /* tool\000 */ },
 	},
 };
=20
 static const struct compact_pmu_event pmu_metrics__common_default_core[] =
=3D {
 	/* CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=3Dcpu\\-clo=
ck@ if #targ... */
-	{ 127980 },
+	{ 127820 },
 	/* backend_cycles_idle\000Default\000(stalled\\-cycles\\-backend / cpu\\-=
cycles if ... */
-	{ 128971 },
+	{ 128811 },
 	/* branch_frequency\000Default\000branches / (software@cpu\\-clock\\,name=
\\=3Dcpu\\-c... */
-	{ 129145 },
+	{ 128985 },
 	/* branch_miss_rate\000Default\000branch\\-misses / branches\000branch_mi=
ss_rate > ... */
-	{ 129325 },
+	{ 129165 },
 	/* cs_per_second\000Default\000software@context\\-switches\\,name\\=3Dcon=
text\\-switc... */
-	{ 129501 },
+	{ 129341 },
 	/* cycles_frequency\000Default\000cpu\\-cycles / (software@cpu\\-clock\\,=
name\\=3Dcpu... */
-	{ 129734 },
+	{ 129574 },
 	/* dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses / dTLB\\-loads\000d=
tlb_miss_r... */
-	{ 129975 },
+	{ 129815 },
 	/* frontend_cycles_idle\000Default\000(stalled\\-cycles\\-frontend / cpu\=
\-cycles i... */
-	{ 130081 },
+	{ 129921 },
 	/* insn_per_cycle\000Default\000instructions / cpu\\-cycles\000insn_per_c=
ycle < 1\0... */
-	{ 130328 },
+	{ 130168 },
 	/* itlb_miss_rate\000Default3\000iTLB\\-load\\-misses / iTLB\\-loads\000i=
tlb_miss_r... */
-	{ 130441 },
+	{ 130281 },
 	/* l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-prefetch\\-misses /=
 L1\\-dcac... */
-	{ 130547 },
+	{ 130387 },
 	/* l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-misses / L1\\-dcache=
\\-loads\0... */
-	{ 130695 },
+	{ 130535 },
 	/* l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-misses / L1\\-icache=
\\-loads\0... */
-	{ 130811 },
+	{ 130651 },
 	/* llc_miss_rate\000Default2\000LLC\\-load\\-misses / LLC\\-loads\000llc_=
miss_rate ... */
-	{ 130926 },
+	{ 130766 },
 	/* migrations_per_second\000Default\000software@cpu\\-migrations\\,name\\=
=3Dcpu\\-mig... */
-	{ 131027 },
+	{ 130867 },
 	/* page_faults_per_second\000Default\000software@page\\-faults\\,name\\=
=3Dpage\\-faul... */
-	{ 131287 },
+	{ 131127 },
 	/* stalled_cycles_per_instruction\000Default\000(max(stalled\\-cycles\\-f=
rontend, s... */
-	{ 131518 },
+	{ 131358 },
=20
 };
=20
 static const struct pmu_table_entry pmu_metrics__common[] =3D {
 	{
 		.entries =3D pmu_metrics__common_default_core,
+		.pmu_name =3D "default_core",
 		.num_entries =3D ARRAY_SIZE(pmu_metrics__common_default_core),
-		.pmu_name =3D { 29669 /* default_core\000 */ },
 	},
 };
=20
@@ -5253,144 +5231,144 @@ static const struct compact_pmu_event pmu_events_=
_test_soc_cpu_default_core[] =3D
 	/* bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=3D0x8b\000\0=
0000\000\000... */
 	{ 154 },
 	/* dispatch_blocked.any\000other\000Memory cluster signals to block micro=
-op dispat... */
-	{ 29682 },
+	{ 29669 },
 	/* eist_trans\000other\000Number of Enhanced Intel SpeedStep(R) Technolog=
y (EIST) t... */
-	{ 36840 },
+	{ 36827 },
 	/* l3_cache_rd\000cache\000L3 cache access, read\000event=3D0x40\000\0000=
0\000\000\00... */
-	{ 110314 },
+	{ 110272 },
 	/* segment_reg_loads.any\000other\000Number of segment register loads\000=
event=3D6,pe... */
-	{ 126075 },
+	{ 126033 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl_d=
drc[] =3D {
 	/* uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands\000event=
=3D2\000\00000... */
-	{ 127512 },
+	{ 127444 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl_l=
3c[] =3D {
 	/* uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\000event=3D7=
\000\00000\0... */
-	{ 127582 },
+	{ 127514 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_cbox=
[] =3D {
 	/* event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\000\00000\000=
\000\000\000... */
-	{ 37085 },
+	{ 37072 },
 	/* event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0xc0\000\00000=
\000\000\000... */
-	{ 37139 },
+	{ 37126 },
 	/* unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-core snoop re=
sulted fro... */
-	{ 127346 },
+	{ 127290 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc[=
] =3D {
 	/* uncore_imc.cache_hits\000uncore\000Total cache hits\000event=3D0x34\00=
0\00000\000\... */
-	{ 127661 },
+	{ 127582 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc_=
free_running[] =3D {
 	/* uncore_imc_free_running.cache_miss\000uncore\000Total cache misses\000=
event=3D0x12... */
-	{ 127750 },
+	{ 127647 },
=20
 };
=20
 static const struct pmu_table_entry pmu_events__test_soc_cpu[] =3D {
 	{
 		.entries =3D pmu_events__test_soc_cpu_default_core,
+		.pmu_name =3D "default_core",
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_default_core),
-		.pmu_name =3D { 29669 /* default_core\000 */ },
 	},
 	{
 		.entries =3D pmu_events__test_soc_cpu_hisi_sccl_ddrc,
+		.pmu_name =3D "hisi_sccl,ddrc",
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_ddrc),
-		.pmu_name =3D { 37368 /* hisi_sccl,ddrc\000 */ },
 	},
 	{
 		.entries =3D pmu_events__test_soc_cpu_hisi_sccl_l3c,
+		.pmu_name =3D "hisi_sccl,l3c",
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_l3c),
-		.pmu_name =3D { 37383 /* hisi_sccl,l3c\000 */ },
 	},
 	{
 		.entries =3D pmu_events__test_soc_cpu_uncore_cbox,
+		.pmu_name =3D "uncore_cbox",
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_cbox),
-		.pmu_name =3D { 127500 /* uncore_cbox\000 */ },
 	},
 	{
 		.entries =3D pmu_events__test_soc_cpu_uncore_imc,
+		.pmu_name =3D "uncore_imc",
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc),
-		.pmu_name =3D { 127650 /* uncore_imc\000 */ },
 	},
 	{
 		.entries =3D pmu_events__test_soc_cpu_uncore_imc_free_running,
+		.pmu_name =3D "uncore_imc_free_running",
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc_free_run=
ning),
-		.pmu_name =3D { 127726 /* uncore_imc_free_running\000 */ },
 	},
 };
=20
 static const struct compact_pmu_event pmu_metrics__test_soc_cpu_default_co=
re[] =3D {
 	/* CPI\000\0001 / IPC\000\000\000\000\000\000\000\000000 */
-	{ 127957 },
+	{ 127797 },
 	/* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\000\000\0=
00\000\000... */
-	{ 128166 },
+	{ 128006 },
 	/* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hi=
t + l2_rqs... */
-	{ 128231 },
+	{ 128071 },
 	/* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd - l2_rqsts.d=
emand_data... */
-	{ 128326 },
+	{ 128166 },
 	/* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2_All)\000\0=
00\000\000... */
-	{ 128461 },
+	{ 128301 },
 	/* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_L2_All)\000=
\000\000\0... */
-	{ 128530 },
+	{ 128370 },
 	/* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * (cpu_clk_=
unhalted.t... */
-	{ 128601 },
+	{ 128441 },
 	/* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\000\000\00=
0\000\000\... */
-	{ 128768 },
+	{ 128608 },
 	/* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duration_time\00=
0\000\000\... */
-	{ 128832 },
+	{ 128672 },
 	/* M1\000\000ipc + M2\000\000\000\000\000\000\000\000000 */
-	{ 128904 },
+	{ 128744 },
 	/* M2\000\000ipc + M1\000\000\000\000\000\000\000\000000 */
-	{ 128927 },
+	{ 128767 },
 	/* M3\000\0001 / M3\000\000\000\000\000\000\000\000000 */
-	{ 128950 },
+	{ 128790 },
 	/* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_cycles\00=
0\000\000\... */
-	{ 129429 },
+	{ 129269 },
 	/* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.any\000\000=
\000\000\0... */
-	{ 129910 },
+	{ 129750 },
 	/* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired.any\000\=
000\000\00... */
-	{ 130260 },
+	{ 130100 },
=20
 };
=20
 static const struct pmu_table_entry pmu_metrics__test_soc_cpu[] =3D {
 	{
 		.entries =3D pmu_metrics__test_soc_cpu_default_core,
+		.pmu_name =3D "default_core",
 		.num_entries =3D ARRAY_SIZE(pmu_metrics__test_soc_cpu_default_core),
-		.pmu_name =3D { 29669 /* default_core\000 */ },
 	},
 };
=20
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
ccn_pmu[] =3D {
 	/* sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\000config=
=3D0x2c\0000x0... */
-	{ 126706 },
+	{ 126655 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
cmn_pmu[] =3D {
 	/* sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache misses in f=
irst looku... */
-	{ 126783 },
+	{ 126732 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
ddr_pmu[] =3D {
 	/* sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles event\000event=
=3D0x2b\000v8... */
-	{ 126926 },
+	{ 126875 },
=20
 };
=20
 static const struct pmu_table_entry pmu_events__test_soc_sys[] =3D {
 	{
 		.entries =3D pmu_events__test_soc_sys_uncore_sys_ccn_pmu,
+		.pmu_name =3D "uncore_sys_ccn_pmu",
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ccn_pmu)=
,
-		.pmu_name =3D { 127830 /* uncore_sys_ccn_pmu\000 */ },
 	},
 	{
 		.entries =3D pmu_events__test_soc_sys_uncore_sys_cmn_pmu,
+		.pmu_name =3D "uncore_sys_cmn_pmu",
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_cmn_pmu)=
,
-		.pmu_name =3D { 127849 /* uncore_sys_cmn_pmu\000 */ },
 	},
 	{
 		.entries =3D pmu_events__test_soc_sys_uncore_sys_ddr_pmu,
+		.pmu_name =3D "uncore_sys_ddr_pmu",
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ddr_pmu)=
,
-		.pmu_name =3D { 127868 /* uncore_sys_ddr_pmu\000 */ },
 	},
 };
=20
@@ -5549,7 +5527,7 @@ static int pmu_events_table__for_each_event_pmu(const=
 struct pmu_events_table *t
 {
 	int ret;
 	struct pmu_event pe =3D {
-		.pmu =3D &big_c_string[pmu->pmu_name.offset],
+		.pmu =3D pmu->pmu_name,
 	};
=20
 	for (uint32_t i =3D 0; i < pmu->num_entries; i++) {
@@ -5570,7 +5548,7 @@ static int pmu_events_table__find_event_pmu(const str=
uct pmu_events_table *table
 					    void *data)
 {
 	struct pmu_event pe =3D {
-		.pmu =3D &big_c_string[pmu->pmu_name.offset],
+		.pmu =3D pmu->pmu_name,
 	};
 	int low =3D 0, high =3D pmu->num_entries - 1;
=20
@@ -5615,10 +5593,9 @@ int pmu_events_table__for_each_event(const struct pm=
u_events_table *table,
 		return 0;
 	for (size_t i =3D 0; i < table->num_pmus; i++) {
 		const struct pmu_table_entry *table_pmu =3D &table->pmus[i];
-		const char *pmu_name =3D &big_c_string[table_pmu->pmu_name.offset];
 		int ret;
=20
-		if (pmu && !perf_pmu__name_wildcard_match(pmu, pmu_name))
+		if (pmu && !perf_pmu__name_wildcard_match(pmu, table_pmu->pmu_name))
 			continue;
=20
 		ret =3D pmu_events_table__for_each_event_pmu(table, table_pmu, fn, data)=
;
@@ -5638,10 +5615,9 @@ int pmu_events_table__find_event(const struct pmu_ev=
ents_table *table,
 		return PMU_EVENTS__NOT_FOUND;
 	for (size_t i =3D 0; i < table->num_pmus; i++) {
 		const struct pmu_table_entry *table_pmu =3D &table->pmus[i];
-		const char *pmu_name =3D &big_c_string[table_pmu->pmu_name.offset];
 		int ret;
=20
-		if (pmu && !perf_pmu__name_wildcard_match(pmu, pmu_name))
+		if (pmu && !perf_pmu__name_wildcard_match(pmu, table_pmu->pmu_name))
 			continue;
=20
 		ret =3D pmu_events_table__find_event_pmu(table, table_pmu, name, fn, dat=
a);
@@ -5659,9 +5635,8 @@ size_t pmu_events_table__num_events(const struct pmu_=
events_table *table, struct
 		return 0;
 	for (size_t i =3D 0; i < table->num_pmus; i++) {
 		const struct pmu_table_entry *table_pmu =3D &table->pmus[i];
-		const char *pmu_name =3D &big_c_string[table_pmu->pmu_name.offset];
=20
-		if (perf_pmu__name_wildcard_match(pmu, pmu_name))
+		if (perf_pmu__name_wildcard_match(pmu, table_pmu->pmu_name))
 			count +=3D table_pmu->num_entries;
 	}
 	return count;
@@ -5674,7 +5649,7 @@ static int pmu_metrics_table__for_each_metric_pmu(con=
st struct pmu_metrics_table
 {
 	int ret;
 	struct pmu_metric pm =3D {
-		.pmu =3D &big_c_string[pmu->pmu_name.offset],
+		.pmu =3D pmu->pmu_name,
 	};
=20
 	for (uint32_t i =3D 0; i < pmu->num_entries; i++) {
@@ -5695,7 +5670,7 @@ static int pmu_metrics_table__find_metric_pmu(const s=
truct pmu_metrics_table *ta
 					    void *data)
 {
 	struct pmu_metric pm =3D {
-		.pmu =3D &big_c_string[pmu->pmu_name.offset],
+		.pmu =3D pmu->pmu_name,
 	};
 	int low =3D 0, high =3D pmu->num_entries - 1;
=20
@@ -5756,10 +5731,9 @@ int pmu_metrics_table__find_metric(const struct pmu_=
metrics_table *table,
 		return 0;
 	for (size_t i =3D 0; i < table->num_pmus; i++) {
 		const struct pmu_table_entry *table_pmu =3D &table->pmus[i];
-		const char *pmu_name =3D &big_c_string[table_pmu->pmu_name.offset];
 		int ret;
=20
-		if (pmu && !perf_pmu__name_wildcard_match(pmu, pmu_name))
+		if (pmu && !perf_pmu__name_wildcard_match(pmu, table_pmu->pmu_name))
 			continue;
=20
 		ret =3D pmu_metrics_table__find_metric_pmu(table, table_pmu, metric, fn,=
 data);
@@ -5830,9 +5804,7 @@ static const struct pmu_events_map *map_for_pmu(struc=
t perf_pmu *pmu)
=20
 	if (pmu) {
 		for (size_t i =3D 0; i < ARRAY_SIZE(pmu_events__common); i++) {
-			const char *pmu_name =3D &big_c_string[pmu_events__common[i].pmu_name.o=
ffset];
-
-			if (!strcmp(pmu_name, pmu->name)) {
+			if (!strcmp(pmu_events__common[i].pmu_name, pmu->name)) {
 				const struct pmu_events_map *map =3D &pmu_events_map[0];
=20
 				while (strcmp("common", map->arch))
@@ -5857,9 +5829,8 @@ const struct pmu_events_table *perf_pmu__find_events_=
table(struct perf_pmu *pmu)
=20
 	for (size_t i =3D 0; i < map->event_table.num_pmus; i++) {
 		const struct pmu_table_entry *table_pmu =3D &map->event_table.pmus[i];
-		const char *pmu_name =3D &big_c_string[table_pmu->pmu_name.offset];
=20
-		if (perf_pmu__name_wildcard_match(pmu, pmu_name))
+		if (perf_pmu__name_wildcard_match(pmu, table_pmu->pmu_name))
 			return &map->event_table;
 	}
 	return NULL;
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jeven=
ts.py
index fae191272859..5d5f8fd79e11 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -544,12 +544,11 @@ def print_pending_events() -> None:
 static const struct pmu_table_entry {_pending_events_tblname}[] =3D {{
 """)
   for (pmu, tbl_pmu) in sorted(pmus):
-    pmu_name =3D (pmu + '\0').encode('utf-8')
-    pmu_comment =3D bytes_to_c_literal(pmu_name).replace('*/', r'\*\/')
+    pmu_lit =3D bytes_to_c_literal(pmu.encode('utf-8'))
     _args.output_file.write(f"""\t{{
 \t\t.entries =3D {_pending_events_tblname}_{tbl_pmu},
+\t\t.pmu_name =3D "{pmu_lit}",
 \t\t.num_entries =3D ARRAY_SIZE({_pending_events_tblname}_{tbl_pmu}),
-\t\t.pmu_name =3D {{ {_bcs.offsets[pmu_name]} /* {pmu_comment} */ }},
 \t}},
 """)
   _args.output_file.write('};\n\n')
@@ -601,12 +600,11 @@ def print_pending_metrics() -> None:
 static const struct pmu_table_entry {_pending_metrics_tblname}[] =3D {{
 """)
   for (pmu, tbl_pmu) in sorted(pmus):
-    pmu_name =3D (pmu + '\0').encode('utf-8')
-    pmu_comment =3D bytes_to_c_literal(pmu_name).replace('*/', r'\*\/')
+    pmu_lit =3D bytes_to_c_literal(pmu.encode('utf-8'))
     _args.output_file.write(f"""\t{{
 \t\t.entries =3D {_pending_metrics_tblname}_{tbl_pmu},
+\t\t.pmu_name =3D "{pmu_lit}",
 \t\t.num_entries =3D ARRAY_SIZE({_pending_metrics_tblname}_{tbl_pmu}),
-\t\t.pmu_name =3D {{ {_bcs.offsets[pmu_name]} /* {pmu_comment} */ }},
 \t}},
 """)
   _args.output_file.write('};\n\n')
@@ -645,12 +643,9 @@ def preprocess_one_file(parents: Sequence[str], item: =
os.DirEntry) -> None:
=20
   topic =3D get_topic(item.name)
   for event in read_json_events(item.path, topic):
-    pmu_name =3D (event.pmu + '\0').encode('utf-8')
     if event.name:
-      _bcs.add(pmu_name, is_metric=3DFalse)
       _bcs.add(event.build_bytes(is_metric=3DFalse), is_metric=3DFalse)
     if event.metric_name:
-      _bcs.add(pmu_name, is_metric=3DTrue)
       _bcs.add(event.build_bytes(is_metric=3DTrue), is_metric=3DTrue)
=20
 def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
@@ -947,7 +942,7 @@ static int pmu_events_table__for_each_event_pmu(const s=
truct pmu_events_table *t
 {
 \tint ret;
 \tstruct pmu_event pe =3D {
-\t\t.pmu =3D &big_c_string[pmu->pmu_name.offset],
+\t\t.pmu =3D pmu->pmu_name,
 \t};
=20
 \tfor (uint32_t i =3D 0; i < pmu->num_entries; i++) {
@@ -968,7 +963,7 @@ static int pmu_events_table__find_event_pmu(const struc=
t pmu_events_table *table
 \t\t\t\t\t    void *data)
 {
 \tstruct pmu_event pe =3D {
-\t\t.pmu =3D &big_c_string[pmu->pmu_name.offset],
+\t\t.pmu =3D pmu->pmu_name,
 \t};
 \tint low =3D 0, high =3D pmu->num_entries - 1;
=20
@@ -1013,10 +1008,9 @@ int pmu_events_table__for_each_event(const struct pm=
u_events_table *table,
 \t\treturn 0;
 \tfor (size_t i =3D 0; i < table->num_pmus; i++) {
 \t\tconst struct pmu_table_entry *table_pmu =3D &table->pmus[i];
-\t\tconst char *pmu_name =3D &big_c_string[table_pmu->pmu_name.offset];
 \t\tint ret;
=20
-\t\tif (pmu && !perf_pmu__name_wildcard_match(pmu, pmu_name))
+\t\tif (pmu && !perf_pmu__name_wildcard_match(pmu, table_pmu->pmu_name))
 \t\t\tcontinue;
=20
 \t\tret =3D pmu_events_table__for_each_event_pmu(table, table_pmu, fn, dat=
a);
@@ -1036,10 +1030,9 @@ int pmu_events_table__find_event(const struct pmu_ev=
ents_table *table,
 \t\treturn PMU_EVENTS__NOT_FOUND;
 \tfor (size_t i =3D 0; i < table->num_pmus; i++) {
 \t\tconst struct pmu_table_entry *table_pmu =3D &table->pmus[i];
-\t\tconst char *pmu_name =3D &big_c_string[table_pmu->pmu_name.offset];
 \t\tint ret;
=20
-\t\tif (pmu && !perf_pmu__name_wildcard_match(pmu, pmu_name))
+\t\tif (pmu && !perf_pmu__name_wildcard_match(pmu, table_pmu->pmu_name))
 \t\t\tcontinue;
=20
 \t\tret =3D pmu_events_table__find_event_pmu(table, table_pmu, name, fn, d=
ata);
@@ -1057,9 +1050,8 @@ size_t pmu_events_table__num_events(const struct pmu_=
events_table *table, struct
 \t\treturn 0;
 \tfor (size_t i =3D 0; i < table->num_pmus; i++) {
 \t\tconst struct pmu_table_entry *table_pmu =3D &table->pmus[i];
-\t\tconst char *pmu_name =3D &big_c_string[table_pmu->pmu_name.offset];
=20
-\t\tif (perf_pmu__name_wildcard_match(pmu, pmu_name))
+\t\tif (perf_pmu__name_wildcard_match(pmu, table_pmu->pmu_name))
 \t\t\tcount +=3D table_pmu->num_entries;
 \t}
 \treturn count;
@@ -1072,7 +1064,7 @@ static int pmu_metrics_table__for_each_metric_pmu(con=
st struct pmu_metrics_table
 {
 \tint ret;
 \tstruct pmu_metric pm =3D {
-\t\t.pmu =3D &big_c_string[pmu->pmu_name.offset],
+\t\t.pmu =3D pmu->pmu_name,
 \t};
=20
 \tfor (uint32_t i =3D 0; i < pmu->num_entries; i++) {
@@ -1093,7 +1085,7 @@ static int pmu_metrics_table__find_metric_pmu(const s=
truct pmu_metrics_table *ta
 \t\t\t\t\t    void *data)
 {
 \tstruct pmu_metric pm =3D {
-\t\t.pmu =3D &big_c_string[pmu->pmu_name.offset],
+\t\t.pmu =3D pmu->pmu_name,
 \t};
 \tint low =3D 0, high =3D pmu->num_entries - 1;
=20
@@ -1154,10 +1146,9 @@ int pmu_metrics_table__find_metric(const struct pmu_=
metrics_table *table,
 \t\treturn 0;
 \tfor (size_t i =3D 0; i < table->num_pmus; i++) {
 \t\tconst struct pmu_table_entry *table_pmu =3D &table->pmus[i];
-\t\tconst char *pmu_name =3D &big_c_string[table_pmu->pmu_name.offset];
 \t\tint ret;
=20
-\t\tif (pmu && !perf_pmu__name_wildcard_match(pmu, pmu_name))
+\t\tif (pmu && !perf_pmu__name_wildcard_match(pmu, table_pmu->pmu_name))
 \t\t\tcontinue;
=20
 \t\tret =3D pmu_metrics_table__find_metric_pmu(table, table_pmu, metric, f=
n, data);
@@ -1228,9 +1219,7 @@ static const struct pmu_events_map *map_for_pmu(struc=
t perf_pmu *pmu)
=20
 \tif (pmu) {
 \t\tfor (size_t i =3D 0; i < ARRAY_SIZE(pmu_events__common); i++) {
-\t\t\tconst char *pmu_name =3D &big_c_string[pmu_events__common[i].pmu_nam=
e.offset];
-
-\t\t\tif (!strcmp(pmu_name, pmu->name)) {
+\t\t\tif (!strcmp(pmu_events__common[i].pmu_name, pmu->name)) {
 \t\t\t\tconst struct pmu_events_map *map =3D &pmu_events_map[0];
=20
 \t\t\t\twhile (strcmp("common", map->arch))
@@ -1255,9 +1244,8 @@ const struct pmu_events_table *perf_pmu__find_events_=
table(struct perf_pmu *pmu)
=20
 \tfor (size_t i =3D 0; i < map->event_table.num_pmus; i++) {
 \t\tconst struct pmu_table_entry *table_pmu =3D &map->event_table.pmus[i];
-\t\tconst char *pmu_name =3D &big_c_string[table_pmu->pmu_name.offset];
=20
-\t\tif (perf_pmu__name_wildcard_match(pmu, pmu_name))
+\t\tif (perf_pmu__name_wildcard_match(pmu, table_pmu->pmu_name))
 \t\t\treturn &map->event_table;
 \t}
 \treturn NULL;
@@ -1503,8 +1491,8 @@ struct compact_pmu_event {
=20
 struct pmu_table_entry {
 \tconst struct compact_pmu_event *entries;
+\tconst char *pmu_name;
 \tuint32_t num_entries;
-\tstruct compact_pmu_event pmu_name;
 };
=20
 """)
--=20
2.56.1.703.gf848ed807c-goog

