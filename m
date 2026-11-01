Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793561304;
	b=I98NrcUBRYwWLFlcPrl3ALoLAK4uZ2ZOJKwXHD5g5DMvy0EWhMTeAmXDxWHeAsZGVjeY
	 3fR4mQbSuwXXZ6skRMtaZdTrGfd681Vx3c/SGZnCBxKoMcOreuXPoCQjWWkcQqj02rsfX
	 RmeIUk0XmzhfMA0iN4zde5sgXcz4wEEP6mwSsWVnYJliQBXReWZINDGQbEhe6wD3je+mC
	 RknY7pwanluzdc4CJUP9YCqbYEABUzmdU4724JWeTX92C81VrVfEpTkBXHAxwBe5yi+3h
	 1IVdKkbBIuy76GAGkhPj+nIyC8cA9r7p5XjwEHJIoYE06i0f5AwWfU3kKsw0Q93urGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793561304;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=4VWlDyarhGLs59ZmxOAL3pCox4wN1k2aQWsJ1VbQoyY=;
	b=GrDi1REMTRys8sWiwktexZbAKpyiPSDVIMPzT3xi7JJcdUxiF+CZ0+p0APYwLBJSc29z
	 5/NNQcfHQyUcbYfj2rgaP5LHgZga1nxILjLb8sfvYTSG5Pg6oHERmm9B9dQd70qSpJMJF
	 xTF8CajIIQPoNgCwG7hz4fVZZZWchgGeMlhtrLR/wG2lOz7ow5K8G0reGmkE8yjZhk09A
	 xAZs3ItRPxdqEg3EL2Y/AZN6CQ8ITWOsDWMxIO7ris9Cn1d07F2eF1PHwn6m3ekgQ/dDX
	 JWkzeaxp2hq7e5vlTYJk930dLXpPmazPxY/QFEpkAq50D+isDgj2hQwEVXRNNhwxYOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S2kisjCd;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19BA60A2623
	for <linux-perf-users@vger.kernel.org>; Sun,  1 Nov 2026 19:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A19BA60A2623
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S2kisjCd
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8ab38a051aaso21907187b3.3
        for <linux-perf-users@vger.kernel.org>; Sun, 01 Nov 2026 11:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793561303; x=1794166103; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4VWlDyarhGLs59ZmxOAL3pCox4wN1k2aQWsJ1VbQoyY=;
        b=S2kisjCdmPZ5bwqVbfQcLsUDTCaG3of2QvgAz2fQy00csrpt96ES9g8VW1DI/+P/XD
         1VxsxqI2E/no3LfUiMzQa9ol5B45jD3xv6yhW3o3dIqPmqEQS6wDcBCa2rpKwvegQDNv
         kB9b6UKhAdnZuuHRX46fHTpInntvYuJAykStCZWn+y/WP2ngtfSPPf2EMN/UfcJUKqFR
         eenkhEH/H1ohvyUbNh+6sDN3jbJdZxS8CNGUyRmKhZS24OEQ6MtzwZ7qMpkra01WMNsW
         muhvSyJFvX2Vn2yroRhn2AZIcGi3HFHDFZrXwB4T3foL/7Vv4Njx+7kCTbc3SfVdmVpZ
         CL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793561303; x=1794166103;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4VWlDyarhGLs59ZmxOAL3pCox4wN1k2aQWsJ1VbQoyY=;
        b=eBoHOBYshcx14iZZk1VsgpPpcEnbH4DxaHxuqJzrwqQiP7MUiA1O3zdcmguixAB+3f
         4St8xzC1GB2pNj58Tj7aOexLpKFA2F0NEBhynXRcenWlrz4CAq53ePiikfQP9dEjo4y9
         57VlRaIe5gavQ1vzlVBHKfB7YWoT8HYetzQ+GjXc3PWSPNvAWDfFfGe3Uk0NzlqrPQGr
         V4b/hkEeaiK/hh8cLj0icZKtuXamYJtGvEi3IWQ4Nht//z+txzEKaB4EiqUILHq/tn8Y
         2IXQpCGCRw9oMg/dQGBqMnwI/5hBs3SKG4YxUBpCJkyKaIsy/VWGLAyW7HsIQ6N2PT5h
         pzng==
X-Forwarded-Encrypted: i=1; AKwUvBxXJW9goPE7oG7IP27oRRsPer3rQ1STUbUoRmyE0Y9f5JzB4EyONsqjBStNqVQhEx7LB8xFy2LpzeFAWU+3zgGe@vger.kernel.org
X-Gm-Message-State: APuU4Z+J2Xs4ebjZx3K+nfT7xmaGGnlg05PzoQgwQk3ELoo6+35hW0Xu
	HpvUIapTd6+ekX2r/tilTKExyqwKSLRw6cCipBszihI+0d7XLnrMkZzM
X-Gm-Gg: AYBFou3UGHzr/4WYQUra03yvsrMfgsJFAnuWFelwUBEeo1Rmm0hWFIpDkwsDV0R33gq
	e36UVd6Z1zhVFOc+YnaRp4EjHe41UZyEhJqEeQI1rBdw62BMgvaAvRlchoi8JyH9+0lfmlIs/ah
	cVf6LXFq+WvkNSdIbOeFZ7ZPdfzJt8mHYqZoLttWakEprEYGvLPPTMX3v5QHK8ZUgNidraonKXQ
	M7eGlisK5p3r0x7rUnWJ1i56ufQ41xIvI9ihwdpLP4A3AH3xwYgN0bJ/K16gfo1CyzV21pl+tBC
	81XjIDYVSXr0KpcPhwgU0Z4I3qlGixvloo5ilVULHP7F24J0xIbawYn5NeEVBCIvuWsCK/sLkDy
	Z95LPnN5zJxP8XsfhJNcvsGPKDgGFbnqTmhixiHWxSeUIjh5k79LM0yfTnYBHPnUJlK71r7FW/M
	Wj9EdcfOV2OPboROIjvT3ccQD0Dci0gQELpfz4F/YaBZr4d48q4xSPIwrX9Uy/GfE+dWT/4Sc3f
	LHbflV5Y/+/CqhdOcrmSQSCXuDfrvwtaZ04iKUzqFZ9hj/kUdkI3CtiIk3Px3vYTMGY83KErq7o
	s7rs0/DUesQpknBaZwy372BkMV2TvA17p+pRfT/7IsgzMyoQ3rHYfWIAHADzoU2m8qVD7GEYomD
	4Z0fMBVcYwQ==
X-Received: by 2002:a05:690c:c513:b0:8b0:a857:654f with SMTP id 00721157ae682-8b2b67b73cemr51969817b3.63.1793561302558;
        Sun, 01 Nov 2026 11:28:22 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b7125371sm39969497b3.11.2026.11.01.11.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:28:21 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 01 Nov 2026 14:28:10 -0500
Subject: [PATCH v3 7/7] alpha/perf: optionally randomize the ProfileMe
 sampling interval
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261101-alpha-profileme-v3-7-92d511b5a044@gmail.com>
References: <20261101-alpha-profileme-v3-0-92d511b5a044@gmail.com>
In-Reply-To: <20261101-alpha-profileme-v3-0-92d511b5a044@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Oleg Nesterov <oleg@redhat.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Matt Turner <mattst88@gmail.com>, 
 Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4503; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=L90ZL0BUtYXerAHuGfkXQ/FfilBgYa9DEbvkOqQGpVc=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLKeTzp6Nsr/TVdmxomMa/Zhbo8CJsioC+99MetI3pnAH
 zm2pkZtHR9ZGMS4GGaKKbLErVdkmdW2Y6nPaelfMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChYxQPkdNj0MgsLi5NLdJNKyhyyMsvSSzJzM8r1ssvSM0rSC/QS8tMK8nIyC8qTgUaoZeXWmL
 q6uhmZGhgYuloYeZk4Whq4uzsZOjk5ujo7OpkZGluYuBs6WjiamnOwMUpAHPNbWeG/76q1WU/Ih
 JfM/zbmmPJ5Cb8KXSDcqG2147DN559P+FT/4Xhf9T/DXr2ur6nEtU4eEO1DS4X6TQtUZF4z5P66
 quYVIY/MwA=
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

A fixed sampling interval can phase-lock with a loop whose length divides
it, so that the same few instructions are profiled over and over while
the rest of the loop is never seen. DCPI avoided this by randomizing the
interval.

Add a randomize config bit that varies each interval by up to 1/16 of
the period in either direction. Only ProfileMe events accept it, since
Aggregate mode samples already land a variable distance from the
instruction that overflowed. Counts are unaffected, because prev_count
already records the value written to the counter. The jitter
is computed with mul_u64_u32_shr() and the sum saturates, so that a
period beyond 32 bits cannot overflow.

The jitter comes from a per-CPU prandom state rather than
get_random_u32_below(), which takes the batched entropy local lock and
triggers an invalid wait context report from lockdep in the PMI.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/kernel/perf_event.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_event.c
index a816a18036b7..037182b4f8c4 100644
--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -16,6 +16,9 @@
 #include <linux/kdebug.h>
 #include <linux/mutex.h>
 #include <linux/init.h>
+#include <linux/math64.h>
+#include <linux/overflow.h>
+#include <linux/prandom.h>
 
 #include <asm/hwrpb.h>
 #include <linux/atomic.h>
@@ -33,9 +36,11 @@
 /* Layout of attr.config for PERF_TYPE_RAW events; see format/ in sysfs. */
 #define ALPHA_PERF_CONFIG_EVENT		0xffULL
 #define ALPHA_PERF_CONFIG_PROFILEME	BIT_ULL(8)
+#define ALPHA_PERF_CONFIG_RANDOMIZE	BIT_ULL(9)
 
 /* hw_perf_event.flags */
 #define ALPHA_PERF_FLAG_PROFILEME	0x1
+#define ALPHA_PERF_FLAG_RANDOMIZE	0x2
 
 /* For tracking PMCs and the hw events they monitor on each CPU. */
 struct cpu_hw_events {
@@ -59,6 +64,9 @@ struct cpu_hw_events {
 };
 DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
 
+/* For randomizing sample intervals from the PMI, where locks are not allowed. */
+static DEFINE_PER_CPU(struct rnd_state, alpha_perf_rnd);
+
 
 
 /*
@@ -246,10 +254,12 @@ static int ev67_raw_event_valid(u64 config)
 
 PMU_FORMAT_ATTR(event, "config:0-7");
 PMU_FORMAT_ATTR(profileme, "config:8");
+PMU_FORMAT_ATTR(randomize, "config:9");
 
 static struct attribute *ev67_format_attrs[] = {
 	&format_attr_event.attr,
 	&format_attr_profileme.attr,
+	&format_attr_randomize.attr,
 	NULL,
 };
 
@@ -384,6 +394,22 @@ static int alpha_perf_event_set_period(struct perf_event *event,
 		ret = 1;
 	}
 
+	/*
+	 * Vary each new interval by up to 1/16 of the period either way, so
+	 * the samples cannot phase-lock with a loop whose length divides the
+	 * period. The count stays exact because prev_count records the value
+	 * written.
+	 */
+	if (ret && (hwc->flags & ALPHA_PERF_FLAG_RANDOMIZE) && period >= 8) {
+		long jitter = period / 8;
+		u32 r = prandom_u32_state(this_cpu_ptr(&alpha_perf_rnd));
+		long offset = mul_u64_u32_shr(jitter, r, 32) - jitter / 2;
+
+		if (check_add_overflow(left, offset, &left))
+			left = LONG_MAX;
+		local64_set(&hwc->period_left, left);
+	}
+
 	/*
 	 * Hardware restrictions require that the counters must not be
 	 * written with values that are too close to the maximum period.
@@ -750,7 +776,8 @@ static int __hw_perf_event_init(struct perf_event *event)
 		return -EOPNOTSUPP;
 	} else if (attr->type == PERF_TYPE_RAW) {
 		if (attr->config & ~(ALPHA_PERF_CONFIG_EVENT |
-				     ALPHA_PERF_CONFIG_PROFILEME))
+				     ALPHA_PERF_CONFIG_PROFILEME |
+				     ALPHA_PERF_CONFIG_RANDOMIZE))
 			return -EINVAL;
 		ev = attr->config & ALPHA_PERF_CONFIG_EVENT;
 		if (!alpha_pmu->raw_event_valid(ev))
@@ -775,6 +802,14 @@ static int __hw_perf_event_init(struct perf_event *event)
 		return -EINVAL;
 	hwc->flags = profileme ? ALPHA_PERF_FLAG_PROFILEME : 0;
 
+	if (attr->type == PERF_TYPE_RAW &&
+	    (attr->config & ALPHA_PERF_CONFIG_RANDOMIZE)) {
+		if (!profileme)
+			return -EINVAL;
+		prandom_init_once(&alpha_perf_rnd);
+		hwc->flags |= ALPHA_PERF_FLAG_RANDOMIZE;
+	}
+
 	/*
 	 * We place the event type in event_base here and leave calculation
 	 * of the codes to programme the PMU for alpha_pmu_enable() because

-- 
2.55.0

