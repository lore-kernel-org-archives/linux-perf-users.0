Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B793E1F12FE
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Dec 2024 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734436588; cv=none; b=o7aRTHsnCAtFHMvOK8lGBvGvCp4yyamjWEaGW//Ubq5Tgm2QKWMBNuZT9xUW9d5Oy7t1az6RW9IIYsgBemcOTOikUEsZfL8beEwZ9wrrklWl9uH2AuCIO5EI/qFLZY21bh1LXzxHO6hmLKEtNB9qLpAHc36yI52r6SHCFFLySYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734436588; c=relaxed/simple;
	bh=t6W362mVGL6hjIcJ6Gq1mX6T3k5VXFAyf1XwkSuGV6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cRILF9hD6t7z2HFWqgZvtQ0LPWm827TmSlGhW95sb9P/7t0BVMRId7Bp4jA17orZONHwIKnzOQra+i+KK5DEQJTmIGkzG/k0Qz2z8nQRp27HRGZDckI9HkiurZeXuom1GxGZwltmjN4i6bQfm92pVPvL9IGgdtW/ZlTJXXJIRrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aBYz4VSa; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aBYz4VSa"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4363ae65100so27779655e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Dec 2024 03:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734436585; x=1735041385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmEIgAdG7I77Lmy/EJIbJ6DkTA3vVYUkhkE5mP+SPGE=;
        b=aBYz4VSaqV6AFEWhCvGR8ncYZZG5J+YD/KMgoP2UHPNkwwEu7j1l83zYi+08infi29
         PRzYK7oOsZVfqro3EmRn4ZGVyueyC1jLahtR7i8b4Lzx5MDTzvJJV7e/I7y861YPne0R
         o+bEQlfAGo74U7paJ3AQIadqCv12g95NVRHuM3wO8wFTLG3q5P+Ir8ipeYFNDEh3eRdK
         n2biadKRnYsUmNQ3ihI35ej48uvKibzVUHTqCAYPK/Nk0jflI8I4vNXU0dl+eg1ft0FG
         MSy7ao3OO9XBcI760mEI7U/IeZUGmHD2oEJuU8kotWOaqrsg4HVFF2RLmpk78A9i7bE3
         kRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734436585; x=1735041385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmEIgAdG7I77Lmy/EJIbJ6DkTA3vVYUkhkE5mP+SPGE=;
        b=eG71W1l0Q7XGvPyAjvZXNgm4jHzI1zGmimBuoDPbgYM1nfnkcAMih7skGjP9hH4f2U
         82oLpTFj+LeovBnOqehf7/Sy7/QgoPe5w9eXLS9hb6r0PjR3Ng39B7MKTWgjWsa805Tf
         yY5aWbWrC6Tq3a+WzI0czhRdD30PJ3B8xmzePJwC2Umj/EK13qakri2W3hBfOtQtyVYZ
         a2PMhre6wbSpsqQ+2/Wu9nyqwdIh1U4zegaSFiPdTsNDEwikPtqE9HwDGW9EPhMEx1XO
         UmmaLH/NV57U6Mr5YmXQ/Wah5RW8bE70NvbacEvDp3CnsNo2iolBny0cKaUt4Hk/H8+m
         /Khg==
X-Forwarded-Encrypted: i=1; AJvYcCV+8rNCsjJPPmNLOl3Nuh8K+LXOne6aYkjI184lZzTrbDFSz3Me6cAQJImlRyD+siANLa/EuxVmDMqgfKZrZoAV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2jS4qor0z7OV3wOd/ospSS1fztoCNYoiBM11f3Lz7uber3K7Z
	HHcSSy4byBfOBy38E4aXSHNJeKe68May/ODR9qHpdj5xxmrCNwLdAaioWch9Qyw=
X-Gm-Gg: ASbGnctXQPFoWlAD56V3QS1GAmswTcf3ZKVJB0rA2pEONXKTon1QYHYIy/yQPnt/Jp6
	kFA6PTa2KO3/ksGh2ff46Yre38KQRPsyNcyielLXZD7i1JhyNtpflk3mim2ZoaJyIYBcism0Fgu
	wvFs5s8UxJeMTU5MQURPO1Yzrhf5QOEIlBzLgPlLK/UJE+dc8xjpdxlBW9k2MuaqHmjtxusU+Gi
	J64aow5HA7gL5uL7n9522rFRsAirSKTmsrbXDaXTHR1z4hSoge25gJH
X-Google-Smtp-Source: AGHT+IGNJedMudEIFVaDxE+oFB3UvniCIpMWZQiyQUFW16zagcfc+ek6kUelO/SpR4GWuh2tlAEkwA==
X-Received: by 2002:a05:600c:364b:b0:436:18d0:aa6e with SMTP id 5b1f17b1804b1-4362aa1b077mr127025825e9.5.1734436585066;
        Tue, 17 Dec 2024 03:56:25 -0800 (PST)
Received: from pop-os.. ([145.224.66.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436360159aasm114935825e9.6.2024.12.17.03.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 03:56:24 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Graham Woodward <graham.woodward@arm.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 1/5] perf: arm_spe: Add format option for discard mode
Date: Tue, 17 Dec 2024 11:56:04 +0000
Message-Id: <20241217115610.371755-2-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217115610.371755-1-james.clark@linaro.org>
References: <20241217115610.371755-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FEAT_SPEv1p2 (optional from Armv8.6) adds a discard mode that allows all
SPE data to be discarded rather than written to memory. Add a format
bit for this mode.

If the mode isn't supported, the format bit isn't published and attempts
to use it will result in -EOPNOTSUPP. Allocating an aux buffer is still
allowed even though it won't be written to so that old tools continue to
work, but updated tools can choose to skip this step.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/perf/arm_spe_pmu.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index fd5b78732603..9aaf3f98e6f5 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -193,6 +193,9 @@ static const struct attribute_group arm_spe_pmu_cap_group = {
 #define ATTR_CFG_FLD_store_filter_CFG		config	/* PMSFCR_EL1.ST */
 #define ATTR_CFG_FLD_store_filter_LO		34
 #define ATTR_CFG_FLD_store_filter_HI		34
+#define ATTR_CFG_FLD_discard_CFG		config	/* PMBLIMITR_EL1.FM = DISCARD */
+#define ATTR_CFG_FLD_discard_LO			35
+#define ATTR_CFG_FLD_discard_HI			35
 
 #define ATTR_CFG_FLD_event_filter_CFG		config1	/* PMSEVFR_EL1 */
 #define ATTR_CFG_FLD_event_filter_LO		0
@@ -216,6 +219,7 @@ GEN_PMU_FORMAT_ATTR(store_filter);
 GEN_PMU_FORMAT_ATTR(event_filter);
 GEN_PMU_FORMAT_ATTR(inv_event_filter);
 GEN_PMU_FORMAT_ATTR(min_latency);
+GEN_PMU_FORMAT_ATTR(discard);
 
 static struct attribute *arm_spe_pmu_formats_attr[] = {
 	&format_attr_ts_enable.attr,
@@ -228,9 +232,15 @@ static struct attribute *arm_spe_pmu_formats_attr[] = {
 	&format_attr_event_filter.attr,
 	&format_attr_inv_event_filter.attr,
 	&format_attr_min_latency.attr,
+	&format_attr_discard.attr,
 	NULL,
 };
 
+static bool discard_unsupported(struct arm_spe_pmu *spe_pmu)
+{
+	return spe_pmu->pmsver < ID_AA64DFR0_EL1_PMSVer_V1P2;
+}
+
 static umode_t arm_spe_pmu_format_attr_is_visible(struct kobject *kobj,
 						  struct attribute *attr,
 						  int unused)
@@ -238,6 +248,9 @@ static umode_t arm_spe_pmu_format_attr_is_visible(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct arm_spe_pmu *spe_pmu = dev_get_drvdata(dev);
 
+	if (attr == &format_attr_discard.attr && discard_unsupported(spe_pmu))
+		return 0;
+
 	if (attr == &format_attr_inv_event_filter.attr && !(spe_pmu->features & SPE_PMU_FEAT_INV_FILT_EVT))
 		return 0;
 
@@ -502,6 +515,12 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
 	u64 base, limit;
 	struct arm_spe_pmu_buf *buf;
 
+	if (ATTR_CFG_GET_FLD(&event->attr, discard)) {
+		limit = FIELD_PREP(PMBLIMITR_EL1_FM, PMBLIMITR_EL1_FM_DISCARD);
+		limit |= PMBLIMITR_EL1_E;
+		goto out_write_limit;
+	}
+
 	/* Start a new aux session */
 	buf = perf_aux_output_begin(handle, event);
 	if (!buf) {
@@ -743,6 +762,10 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_LAT))
 		return -EOPNOTSUPP;
 
+	if (ATTR_CFG_GET_FLD(&event->attr, discard) &&
+	    discard_unsupported(spe_pmu))
+		return -EOPNOTSUPP;
+
 	set_spe_event_has_cx(event);
 	reg = arm_spe_event_to_pmscr(event);
 	if (reg & (PMSCR_EL1_PA | PMSCR_EL1_PCT))
-- 
2.34.1

