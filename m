Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209C43BA220
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Apr 2026 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775570761; cv=none; b=YDZCZVXXa2LM+SJqUnG5xU3Oq67G72nG8TUqgBxdo94zuwf3w3aL+XTwtvwwHJpeUFKnbBufpU10z56spid6ThWQfvO4Qx+Fi3tlEwhq/gM6zMUySMV5g1OYPErG35m1so+oQAsXLIJHqojCb8nICYJ9y77CA0HgPB6OxAK2vPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775570761; c=relaxed/simple;
	bh=saJ9/B0yxMVCJ3Hqjc5BIWZkV3tpmYeyWUx6kRa8APo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RJE0Twr+m1ii5kBlTJNzggj9dZxD7JVcjbuAkzoYJ4SzkhiV6JA3Mx+Q3/UqqmV4B3RiY2VKaPz1rVec6JrWf8AQ7ssYfdGLJpYD7ghqhsm7g3fsjzGejrIbM8vCiaVNI0f7YivU535yLvVyHubF1gkSfuvtcELn8iIyl9oLkBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mksXcwme; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mksXcwme"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d01d6b50cso4813415f8f.1
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Apr 2026 07:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775570758; x=1776175558; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7a5dHlK5ecPt6xckcJpPIY0VEGI+9frdQ7qhWf9R0sQ=;
        b=mksXcwmeqZgFvpFqY/i2mfgLn8xeO8ogafEqM14pW7xRMLhHjlvt5s4r4N7D/KoRC4
         MiIaWuxdjt1kjCGiE4lcrn5hKu7iLtsWV9+D2YhHX4UqjS49Hx0PApCrGELONiig/s++
         MaZprhTCy/uqVHuagvDyXg86qPkqrn+9GF9ob4vd8655qQ27MBMsrHp6EgoNpUO8w4tB
         99K+OFs5ekuogG05WSXk2rZb4srp1b9jnh8brl4XoUI2Rb3//r9Skn6+ChPTO78wkQiw
         RKN7vOkRB/34hBF0JkpiS7eWgCeBpzPfMV3N2mA1sWYyOc8lMr2SOh8FEV6ydtffCPMS
         +Czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775570758; x=1776175558;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7a5dHlK5ecPt6xckcJpPIY0VEGI+9frdQ7qhWf9R0sQ=;
        b=aMVtKQV/YxP+L0ur7dOv5F5tiSivl+AzqnyB8tuWa3CW83gY9PyxlgSFmOYE5nwdh6
         i40cwQmfpBleWHQcC9E+vNnyd34CZdkzjNbPU4f/rrnDxdsaiKr9LIjKw/VzTCxLLdDG
         e1f5ERXCs3xc8fN3G0eKTOA4vwE3BLJ7JB5CbzGERjrFroFFTLk8/HKSBj81BwIxqeJn
         qXr7L/zL1B5SmqePvDpydPYWh1GNDJE6FOvx3Au6OEn5XGKLq7YqB0DLbTtAfWsExiC8
         WHonpXsQxxQLi29PBQZi0A8J/wUHn2pqeRhyS2sb7bk4+59F9uflpLigUOJx2GNuGbFl
         EniQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5chOhgaZdsu+9QnDlo8ZQO8w7f6+0ZkMc8C5XHBTnIip3mzSSTdSNx6ttsLamNJWrA4tZCxx2MWlu6wRZBpga@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8EYMrNNpqK95SF2oPkB6lVOwUAdkatgYXMpn+hFoh9hXbldlP
	MZErpx4U0Dsi8vOwACtWW1SouzLMLTZworwsCZCDt3JcP1ZsfQyoSVJ9Krj/5fpHtA8=
X-Gm-Gg: AeBDieuM4vNwgc1/srRu0Z95+jjHOXwViGgsGkvH/vkUThnXKzJd+uzZvMyEaCMHIs6
	doAaKlrMsQc0+lJA64qYphGdH4SAwWT6DTnWNJuLYZnqa8GCRdVFhyTHB3qRXYvEh8snieThms2
	ztadzby/PVFvd7qX8PNCoAHVMl+YCSGT1JzKAzL6E9jvjXYWyLJCjSzlLqHPuX5BERnG/qrsRhZ
	xdKBmg2BCvCoOoHYVOFnGF1MRMaJtUiMTbb4MM1GLSsN184tnZOEK6iA7rY95FO8VcSJDVFMNiW
	CVJnLEeeJvANTvVQQXnHKRcWTO+9li3sC2ZmtNzgrBcICY58WdSU+bk7lJETaIsomp6zj6Sywj0
	cP8bh+1JzU/+pO/tyH3KUj1U1Gf/psVK8k2pZyhfl6uI0uy382tEHpVU74ny5PyjVep3B824j5D
	qV7m7xz0U7ooM8Kyydg7uAorYNdYhdWd4kMsiFXQGicCM=
X-Received: by 2002:a05:600c:1990:b0:488:a82f:bbb6 with SMTP id 5b1f17b1804b1-488a82fbdeemr154986695e9.27.1775570758405;
        Tue, 07 Apr 2026 07:05:58 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e822227sm626876145e9.4.2026.04.07.07.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 07:05:58 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 07 Apr 2026 15:05:18 +0100
Subject: [PATCH v2 4/6] perf arm_spe: Turn event name mappings into an
 array
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-james-spe-impdef-decode-v2-4-55d3ef997c48@linaro.org>
References: <20260407-james-spe-impdef-decode-v2-0-55d3ef997c48@linaro.org>
In-Reply-To: <20260407-james-spe-impdef-decode-v2-0-55d3ef997c48@linaro.org>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.0

This is so we can have a single function that prints events and can be
used with multiple mappings from different CPUs. Remove any bit that was
printed so that later we can print out the remaining unknown impdef
bits.

No functional changes intended.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     | 88 +++++++++++-----------
 1 file changed, 43 insertions(+), 45 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 718022aecec3..67ca356100e5 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -277,6 +277,48 @@ static int arm_spe_pkt_out_string(int *err, char **buf_p, size_t *blen,
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
+		if (payload & BIT_ULL(ev->event))
+			arm_spe_pkt_out_string(err, buf, buf_len, " %s", ev->desc);
+		payload &= ~BIT_ULL(ev->event);
+	}
+	return payload;
+}
+
 static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
 				  char *buf, size_t buf_len)
 {
@@ -284,51 +326,7 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
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

