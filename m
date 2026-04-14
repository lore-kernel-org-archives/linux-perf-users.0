Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EBC3939A4
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 11:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776164792; cv=none; b=Zuw7atHy34lIHPU9u9iKz7LZsMJc384lFZ8pv6UAmv/9jL1cn5zq+qXu7hkxDvS8XQsbfR3ZLlRdRhusk4KwbWdvMuYjVgUDl+IPe70oQ4eG1q+q38B9UIFh9KiNVahsUTYF/XhHgTPWU0wbmBxkckSuwlFWmUMUTtuCKXAq7Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776164792; c=relaxed/simple;
	bh=chqGz8CXMiy63WmmO8OrPRWkTU/CYPZOJ9Kjy6IEH1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bTbB9ethAOCERFXYhDY1r4raGQntfLDwXw71mIZOzW1TjL22Km6fq7hFnR4MgCXA/LSnS4C6EA2raabiJO4k13SNqGeWMf/hhhFknxOmUFONl4E8HbKWn/d2ARfBpcx8mE9QUQpgIug3mEfPelIBiA7b7xAb72FY/+aB8XFSaRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cBt3cuHG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cBt3cuHG"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4887fd35e60so38482725e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 04:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776164789; x=1776769589; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wbsDVJkTRMx0qswgCm9IniTVkJpsMJgpoF58GIGXMdg=;
        b=cBt3cuHGlqDlzFkCEpOPnUyhV4P1GAQ+7Uvhx78u1A+jquFL/TRND5Su/e05pnsU0N
         Ol+p/aIQRbYcruoo7Zypf+DVJ3mdozhHM23UjRYmBLRjkCmKqYF/1lNY/IUXXOWt5Bjz
         C/FOOaw48g6ZUTULFk1hTABqKjkDDPBFbsjP6SKzGWMBMLWVzBPnbcpwyUlzqVGxJt8I
         ke2Yt2qIpUA8215AePQnO/5rBm52okz0EmA7WaZMPbexNHqagWXrUwAgJUKGNalQ62g8
         2Q37yfY0bykIpHlk3wmZdc2wJuSto+rwh9A8UEZOqKx1Swgy8xcgUi3Uq55NuCO5c//Y
         Umbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776164789; x=1776769589;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wbsDVJkTRMx0qswgCm9IniTVkJpsMJgpoF58GIGXMdg=;
        b=mOL4u2/UErqSP7SZTtdc0yA5kBDBzP5kKD0eTrw3KrcPYlCHr6FsxLYc2iQM5feF2a
         xm4SeyQ+vLoLIB/69ewIkfuefTE/rfU7c/ghxQe4QT/bP1Pinf+6cEJ3a5QDIn4/htum
         44XnoXy62XBJAXjFNEYcXCpOKuZ6xITitwNMYos0G/JUETtMc4+YEwtUtSHLJ7BJfeQC
         elCiRx7uEIdBUtPv7xaNotKshzg9yO5geTDoV9fxq//WvEzAI9YWXo5TNxPuTfAx8edi
         bB51eM5oB46Wg0GqDZXeXiYQPvIJvlILcRsmSixy6oNtZrosJVbZsLWjaDekuTDRPLPe
         DfIw==
X-Forwarded-Encrypted: i=1; AFNElJ/kF2o0cQuGF8B5m//oB6fnuB5BViL3RDlhmoRVGoppu24aVpc9btLWvkPE7rJIqdbI+Umvcu5NjIdMWv/Cdo2F@vger.kernel.org
X-Gm-Message-State: AOJu0YzGqeSE4ZfcKMcvtpBPZqZZIhcG7V3g0S7VAC+97+o91Tf51W+D
	tMLPM+bzNfQR8fmmV7uiaT4CnaFIU+QrOuxh1+TTNth1g3+765IpUDwqeEjCezzMzZ0=
X-Gm-Gg: AeBDievXYC9Ew/y+SWIuTT7faiB03B/obOanbzpKErI55grLdvwLSO5+VEocl6bqaJI
	8fNC9oJEUfC7/hehKhWMkOGtYDdJ7Sn/gtaq9aiAHFGREBOllE+fpBQ+KYVYjFJMF4n/6xoXTHS
	dMgG2s8oRP+QjC2TQ+XIRHxsLQ9vObqiE0/hlzdqxApMR3VVDHpi9UAd3/8UX+6O9pe9aSHDXEL
	n2OvvrBFrrWljvyos2VJRDEEgCP27PC3XnO/ldqkmxuEeJylEWclKxMvckfmTWnsCADJZGuz1U3
	IUrYh/UN5yNN5DH/o9+VlqAwip+VSBmZeWulkguSjl1Zp9jIJGdPolmn5Oyds9XOEtDVI6zA6xv
	oudd6a79LvvmFTa3evnurzbcGjXaHxxREe6UGXNBXpwhMwDxscViElNUvtD/9W5lYV3W3Mk7B1N
	8Fx+XWAPlfTKIyWT/ABrBC8Q4EFrCPnPNnB4n4vqH1Ig==
X-Received: by 2002:a05:600c:8710:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-488d67bbd1dmr248340235e9.4.1776164789177;
        Tue, 14 Apr 2026 04:06:29 -0700 (PDT)
Received: from e133063.arm.com ([213.137.22.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d9dd86sm183254655e9.4.2026.04.14.04.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 04:06:25 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 14 Apr 2026 12:04:50 +0100
Subject: [PATCH v3 4/6] perf arm_spe: Turn event name mappings into an
 array
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-james-spe-impdef-decode-v3-4-63baf9c893b1@linaro.org>
References: <20260414-james-spe-impdef-decode-v3-0-63baf9c893b1@linaro.org>
In-Reply-To: <20260414-james-spe-impdef-decode-v3-0-63baf9c893b1@linaro.org>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2

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
index 718022aecec30bf30a51ba3d2bca9cf6465259a7..67ca356100e53aaf6d47489717537ba27aa2b98e 100644
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

