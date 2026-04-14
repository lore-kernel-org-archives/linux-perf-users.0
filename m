Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64893E6DCA
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 12:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776170902; cv=none; b=uNWGRshvy38n+wqPJOGnQ96r1Y8w+6QU7osWtUd99Wh3bbP9zcM2y7CDicJ/ZlAcfMYE1FavC56tpN3T4k1Yy+k/pY/ZJiqtJhV+U95ZFo0A+zUm93N/M0W2l0b+9VjMIke3CnCpohIBMOXgmcdjE93kyCJpDUcF3woaBn3Ypys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776170902; c=relaxed/simple;
	bh=chqGz8CXMiy63WmmO8OrPRWkTU/CYPZOJ9Kjy6IEH1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uc0ErGzLfxHijLd0x1YC9Lpcv1FDPIk+of3mviAsTO/2VfAKM9/VTV0Mkj6byo/rMr10Q+ev+C5V1LoFndnHgQ/kLsURHxHwtr0OOYPJr/v1W5WuQb+IuU8Uf6deKBjg01nWZ7W1xHpH1p/Rtsmvpb1DQ3Qr3oSQNwDA4spZCQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BWlCUnNA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BWlCUnNA"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488b8efed61so54556225e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 05:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776170898; x=1776775698; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wbsDVJkTRMx0qswgCm9IniTVkJpsMJgpoF58GIGXMdg=;
        b=BWlCUnNANL/P8sdQR1hL3ZWOx8e88hRN+LJDBRfI45uxMPJn9D+5lrhfa7lyZudFlI
         cp4yHwm7xdHGoJj6xEkrWswrM/DlI8DIkjgx7CQuzyJolIwF7nxY+CmjBdIEkIifpxba
         ggH0d9vxUpG0Irg5kldLYDWy8GFN88i3wflT0UjwG5aKBBJSePBVfWLrqA/8YcSlQ8Pt
         0jWflsXvyDloa1yytVpo07jrq+MHwb+6bb/XQQz0UKNrpH+mQ76m1+aXdJjYcXE0aQ1Z
         O4csPCKyKZVPnpFpI1SQIxKQgvyLLTGbEFP6H0fZjCX/l7aCwfOxkp+TM6Mk+R9BAMKM
         yX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776170898; x=1776775698;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wbsDVJkTRMx0qswgCm9IniTVkJpsMJgpoF58GIGXMdg=;
        b=H/1V6kwl+nXcFxHAgx7U9zH3OJd8xWmGPRPBpjuqrOoJfbMOI3HSjlBUmrsj3ldPsR
         JsEw0VAanf0VjUYsMtzGnqzwx8tnVpMe1Q4wiBZ4q9zuqTQcC46Wh8SieqG5H35yAofH
         AUeaNhv5JQJpd49h2gMyq4WkdXInofoxas84ZFt4hXjWPwL4k2EwrE4/6BcWVlB2pBMc
         tEcvsBcPVKtxdxIBDoPN77cPReMi7Z8vCLGlJqWs+kyu1C7UjTjGN3HIOzuSYRPKEjgW
         ifBaIyXPlT1zqDwLITYKn14ufGMTV9r/A7JpTTP1tnHU3ejwGm65F9syL83o/WiImQvD
         YdIw==
X-Forwarded-Encrypted: i=1; AFNElJ/gO4wfv0ZCg1as6umUMybxg+YxMrPhAPIZn5gOrQ5laxVRBwBpVKEQLY1gBTu7xtXOZz8A+3Vq0kzrc7JyI2n7@vger.kernel.org
X-Gm-Message-State: AOJu0YxFS6a7y7WtGcrS2NzmV/PjzGLmqpZOjwt7QNZWx+jVawHqBUI6
	qnZUEwgBaoa3I5Pv3ufupgJr1zA+NH6sex6KHYkqfHT3bSu3CGbq4f6iKd5Zd5b5m3I=
X-Gm-Gg: AeBDietpz2fYyT1MluYn0GuyQfEBhp6DadQq6kL6j+UenVklkqG5MXEqYFm+z/KS0Yn
	rIe7CdIYGh0FK7tbS/R3drjwR7S+03SvFcgx608tj6BepgFsfqAO0TJnpX9fwC5EZskT/R9S08J
	B9eIvfXsDahi3yOFqZdV8/FmgGHqHoGzgITu65+n5B5XuOaGLHPpFRuzuG1XqSs1/PSzl+mHwSB
	CbczOVWlHEf0yiTBxWzhrUU6dBWrHMj9Wwi/FVHqbrWtKVIUZ7AG0QeHTnGgu6uYbJas4HeTLFr
	M1D4niL37E28DQfPPkL7PqquwBsAmaAAMvpXljV3zHBn+eUOGNQ1WxyFJMBQECxB9JHv2r577Qh
	ncPoLaofI0VVF1viIWaNe/urblY1MiMNm/h483OBWWw8SkGAYlF++v5p/nUvd32gae3CKw4CyM4
	TfzNJB35elk2vplZKlPRUxLY3svYKtndbxJ8OlsRdKwA==
X-Received: by 2002:a05:600c:c10c:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-488d68cb8demr145699165e9.12.1776170898153;
        Tue, 14 Apr 2026 05:48:18 -0700 (PDT)
Received: from e133063.arm.com ([213.137.22.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1e05bsm81185285e9.6.2026.04.14.05.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:48:17 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 14 Apr 2026 13:48:02 +0100
Subject: [PATCH v4 4/6] perf arm_spe: Turn event name mappings into an
 array
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-james-spe-impdef-decode-v4-4-1dd30783a33b@linaro.org>
References: <20260414-james-spe-impdef-decode-v4-0-1dd30783a33b@linaro.org>
In-Reply-To: <20260414-james-spe-impdef-decode-v4-0-1dd30783a33b@linaro.org>
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

