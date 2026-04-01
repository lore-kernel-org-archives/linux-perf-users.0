Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9B2451052
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053585; cv=none; b=OyU4sJzH0iRADVhuQyr2/s1+bN/5EJZflcsh+9vr3AaBhRD96UIIQU2inMSMPUdsxwiJ0W3T4q8TdGnQeKAVzwsBf0tbv/bYHDjHvG2RSQgrcNaVtAWNQbl+rSHD2R6+/uOWPrmqpIv8KQoOqhUzjwr+RCYh6Vqx8Bgem9KxM6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053585; c=relaxed/simple;
	bh=jccoruL2T+NGqOEgKJxsle4jnVNgDjpWN1VhgSnRmEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IhyxlV5LNYP22edn5q+mxawGmLM1bRcLLfcHpwsZcu7styiTkrCLtlBv057wA2NGcs7LamNq3tH+xNjgmL3Unv2E2l4T7f7r5U3NCwqrGNpnfTnUxtKzStwCxqWVDWbj03b1AtGFBbmmLKBQDiJ9GpD8bi5q1Z1rK5dn0OXxr2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VlLbknmB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VlLbknmB"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-486fb14227cso92410325e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 07:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775053583; x=1775658383; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n24sszBVzgPIC0kU6aw8yrDjc6YoHko/OXDuAL7iz6Q=;
        b=VlLbknmBTmbp4XuhubdX6S/nzRuEReObpGBZe5q0kI9Uuk33dhYPGM1l1emePzufDL
         +iAUt1VNjEXaN4gZc1QZZwedBCKTnkOIHH81kc4YiFi1lpcPUOE2TKyOP1YXufWeIZB8
         avMfOEtl2bZibmWqAxx0TkEL+lE82FY8QD3VA3rVE21FOnzHtp9hLtIpNKmphJLNIKkZ
         aTxqJuGPmcEMXcIbHDTjJTs6O1Ekx+BqdrxrYLIi9PaUawNORucF6RppFlaQLRkTwNPu
         fSnkbS1pjPztlB6emLjhJTGuKcM1466OoHzUS9ij2RSGg4cw6n+2M12o1T5ZP1wxtnac
         eBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775053583; x=1775658383;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n24sszBVzgPIC0kU6aw8yrDjc6YoHko/OXDuAL7iz6Q=;
        b=jYnbBvxRRLnqGKtFjKqtK8TIgBJuAau/orIcYYkLk4lCsO4IazYK1Av1WvW075TFuE
         uaePSWhL0AhBumsV30pApY099QAn8sG8NoXFAnoUUGRMB+0vWh+HwOgvitVDXa+9j5Wl
         MlaUgKe0NImLb/pvagJZTharkky0Vv/EJDLyPVEndV2XhdH3yPHH/k3snrsXqimEdCAn
         fQdExaCHArve4mwCL+rzHYJuTij0aCS/MDwdBizxmY7ckkRwBKMna3advgg3IEUwzfjE
         k4v2QpT7ICvjSIrcH4Afr6Z3WNGzjpS2A1Kx5ioqFGtksYf8jK+cHlp2cDZGIgOr6Ske
         W0Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVIBu1uhIMtnJmd4HqnziktZkPbGGfY66KZkLbC5FvmO+L19Ibov9pIQgvqmv4nb6NslXWj/YqMB4rX43caOxyE@vger.kernel.org
X-Gm-Message-State: AOJu0YyYoT1cCdI9BACTFlh7AFTqbLhOtOIvLUv8ORvbIhjFj1/X5kSw
	9gxt9piR0UbCTZDNjgEzd/QnBDi9UTHUkHnstBaVZWeEWONetoM/RB1UJhAWGncVFwk=
X-Gm-Gg: ATEYQzz1b878MFYmaAnVLWx1ZS7J44mfYbglpzzHK2b2eQvxR/1c+t72eLWG9Jt13NC
	u8XX9gGwMcaLoAh8/getUoywl/KnGModNx1NlD0yWOP76VIlLgGXsCKxcxpS14TcIsYIcVoiBDL
	UsvAi/Fyvzby+Z1ExAjxhREpEt/y1vtPAxz4LYMF6COrUreCVOsgOpSz+dbwzqaask0cURSVrct
	It9a4Ni9xsVRloVNTAn7rboMgBqGaD3IKtB6wm2NJq3gD2yznmBOyaEyc7dncD36a+XEINW6hch
	f9ZjHprapRUvHFUn9wjMLjAmBxokDEbc45SkbU4uBQknlBBAdwlfHIBw6RC03NN5vlT8PwKHDhG
	kzhtZPIxHvq8qLFiWEKmWjxGsPSKxQ89sThn/51INpBom92U+zDlCpxOhGLA91KVwE3d4gXfirC
	829+biYVeoJ66XPfW8AEBqcKhT66zQbxMIuHSC5q0/m9o=
X-Received: by 2002:a05:600c:828f:b0:485:4388:348b with SMTP id 5b1f17b1804b1-48883310809mr72258105e9.0.1775053582629;
        Wed, 01 Apr 2026 07:26:22 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a63c9b1sm2305595e9.5.2026.04.01.07.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 07:26:22 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 01 Apr 2026 15:25:50 +0100
Subject: [PATCH 2/4] perf arm_spe: Turn event name mappings into an array
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-james-spe-impdef-decode-v1-2-ad0d372c220c@linaro.org>
References: <20260401-james-spe-impdef-decode-v1-0-ad0d372c220c@linaro.org>
In-Reply-To: <20260401-james-spe-impdef-decode-v1-0-ad0d372c220c@linaro.org>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

This is so we can have a single function that prints events and can be
used with multiple mappings from different CPUs. Remove any bit that was
printed so that later we can print out the remaining unknown impdef
bits.

No functional changes intended.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     | 88 +++++++++++-----------
 1 file changed, 43 insertions(+), 45 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 5769ba2f4140..c880b0dec3a1 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -276,6 +276,48 @@ static int arm_spe_pkt_out_string(int *err, char **buf_p, size_t *blen,
 	return ret;
 }
 
+struct ev_string {
+	u8 event;
+	const char *desc;
+};
+
+static const struct ev_string common_ev_strings[] = {
+	{ .event = EV_EXCEPTION_GEN, .desc = "EXCEPTION-GEN" },
+	{ .event = EV_RETIRED, .desc = "RETIRED" },
+	{ .event = EV_L1D_ACCESS, .desc = "L1D-ACCESS" },
+	{ .event = EV_L1D_REFILL, .desc = "L1D-REFILL" },
+	{ .event = EV_TLB_ACCESS, .desc = "TLB-ACCESS" },
+	{ .event = EV_TLB_WALK, .desc = "TLB-REFILL" },
+	{ .event = EV_NOT_TAKEN, .desc = "NOT-TAKEN" },
+	{ .event = EV_MISPRED, .desc = "MISPRED" },
+	{ .event = EV_LLC_ACCESS, .desc = "LLC-ACCESS" },
+	{ .event = EV_LLC_MISS, .desc = "LLC-REFILL" },
+	{ .event = EV_REMOTE_ACCESS, .desc = "REMOTE-ACCESS" },
+	{ .event = EV_ALIGNMENT, .desc = "ALIGNMENT" },
+	{ .event = EV_TRANSACTIONAL, .desc = "TXN" },
+	{ .event = EV_PARTIAL_PREDICATE, .desc = "SVE-PARTIAL-PRED" },
+	{ .event = EV_EMPTY_PREDICATE, .desc = "SVE-EMPTY-PRED" },
+	{ .event = EV_L2D_ACCESS, .desc = "L2D-ACCESS" },
+	{ .event = EV_L2D_MISS, .desc = "L2D-MISS" },
+	{ .event = EV_CACHE_DATA_MODIFIED, .desc = "HITM" },
+	{ .event = EV_RECENTLY_FETCHED, .desc = "LFB" },
+	{ .event = EV_DATA_SNOOPED, .desc = "SNOOPED" },
+	{ .event = EV_STREAMING_SVE_MODE, .desc = "STREAMING-SVE" },
+	{ .event = EV_SMCU, .desc = "SMCU" },
+	{ .event = 0, .desc = NULL },
+};
+
+static u64 print_event_list(int *err, char **buf, size_t *buf_len,
+			    const struct ev_string *ev_strings, u64 payload)
+{
+	for (const struct ev_string *ev = ev_strings; ev->desc != NULL; ev++) {
+		if (payload & BIT(ev->event))
+			arm_spe_pkt_out_string(err, buf, buf_len, " %s", ev->desc);
+		payload &= ~BIT(ev->event);
+	}
+	return payload;
+}
+
 static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
 				  char *buf, size_t buf_len)
 {
@@ -283,51 +325,7 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
 	int err = 0;
 
 	arm_spe_pkt_out_string(&err, &buf, &buf_len, "EV");
-
-	if (payload & BIT(EV_EXCEPTION_GEN))
-		arm_spe_pkt_out_string(&err, &buf, &buf_len, " EXCEPTION-GEN");
-	if (payload & BIT(EV_RETIRED))
-		arm_spe_pkt_out_string(&err, &buf, &buf_len, " RETIRED");
-	if (payload & BIT(EV_L1D_ACCESS))
-		arm_spe_pkt_out_string(&err, &buf, &buf_len, " L1D-ACCESS");
-	if (payload & BIT(EV_L1D_REFILL))
-		arm_spe_pkt_out_string(&err, &buf, &buf_len, " L1D-REFILL");
-	if (payload & BIT(EV_TLB_ACCESS))
-		arm_spe_pkt_out_string(&err, &buf, &buf_len, " TLB-ACCESS");
-	if (payload & BIT(EV_TLB_WALK))
-		arm_spe_pkt_out_string(&err, &buf, &buf_len, " TLB-REFILL");
-	if (payload & BIT(EV_NOT_TAKEN))
-		arm_spe_pkt_out_string(&err, &buf, &buf_len, " NOT-TAKEN");
-	if (payload & BIT(EV_MISPRED))
-		arm_spe_pkt_out_string(&err, &buf, &buf_len, " MISPRED");
-	if (payload & BIT(EV_LLC_ACCESS))
-		arm_spe_pkt_out_string(&err, &buf, &buf_len, " LLC-ACCESS");
-	if (payload & BIT(EV_LLC_MISS))
-		arm_spe_pkt_out_string(&err, &buf, &buf_len, " LLC-REFILL");
-	if (payload & BIT(EV_REMOTE_ACCESS))
-		arm_spe_pkt_out_string(&err, &buf, &buf_len, " REMOTE-ACCESS");
-	if (payload & BIT(EV_ALIGNMENT))
-		arm_spe_pkt_out_string(&err, &buf, &buf_len, " ALIGNMENT");
-	if (payload & BIT(EV_TRANSACTIONAL))
-		arm_spe_pkt_out_string(&err, &buf, &buf_len, " TXN");
-	if (payload & BIT(EV_PARTIAL_PREDICATE))
-		arm_spe_pkt_out_string(&err, &buf, &buf_len, " SVE-PARTIAL-PRED");
-	if (payload & BIT(EV_EMPTY_PREDICATE))
-		arm_spe_pkt_out_string(&err, &buf, &buf_len, " SVE-EMPTY-PRED");
-	if (payload & BIT(EV_L2D_ACCESS))
-		arm_spe_pkt_out_string(&err, &buf, &buf_len, " L2D-ACCESS");
-	if (payload & BIT(EV_L2D_MISS))
-		arm_spe_pkt_out_string(&err, &buf, &buf_len, " L2D-MISS");
-	if (payload & BIT(EV_CACHE_DATA_MODIFIED))
-		arm_spe_pkt_out_string(&err, &buf, &buf_len, " HITM");
-	if (payload & BIT(EV_RECENTLY_FETCHED))
-		arm_spe_pkt_out_string(&err, &buf, &buf_len, " LFB");
-	if (payload & BIT(EV_DATA_SNOOPED))
-		arm_spe_pkt_out_string(&err, &buf, &buf_len, " SNOOPED");
-	if (payload & BIT(EV_STREAMING_SVE_MODE))
-		arm_spe_pkt_out_string(&err, &buf, &buf_len, " STREAMING-SVE");
-	if (payload & BIT(EV_SMCU))
-		arm_spe_pkt_out_string(&err, &buf, &buf_len, " SMCU");
+	print_event_list(&err, &buf, &buf_len, common_ev_strings, payload);
 
 	return err;
 }

-- 
2.34.1

