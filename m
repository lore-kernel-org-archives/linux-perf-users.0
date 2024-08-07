Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B803884D0F
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Aug 2024 15:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723045934; cv=none; b=rMn5TkBxdEkUTQN6rki/ojA2qr1lpqDRex/C97zO3zk6op4M75oa0EPdAstd2eZ8Lh4g/ycb9l9L4qESdLksJUyLNg1ZCaQ/yhau3OHtI71eKWSAkQakQIRahg08eF7jy6Kdn4k1z9kJe0e/T9BvQVqmQGzpqmnC0o95qNj9pLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723045934; c=relaxed/simple;
	bh=MTxacAatWTOpYma2qqk2MFtnl6sscbXpCf0B0L3Rvxo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Avaef9wSOgC4JKHBNTF066lxl0Jk6z8qHsfix8uJo5aXWv51edoXaVBWfBTEluf1qGSTPp5lnOZNS7LJDjKpnoKaYSwp4GPrLpUH6g4JuvkOuL/VF2nnSATJ8gHCc+54eG8iQWUihO0wI+BacNQ2N3BVP8aR+KCtynsdK+g1Rh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HvejrY7s; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HvejrY7s"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-367940c57ddso1087130f8f.3
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Aug 2024 08:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723045931; x=1723650731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oRFdCUk81EgAuZOPUgff1QAMGIx+EiDXi2BrG6XIJyg=;
        b=HvejrY7sgXAnhuLCIQPlpnwzfvgUxoE4fAKrn5gBhx3/pYp9DtIQ3JJzzcdGhfIM4K
         1U3eu9asMhoNrqLetT0J5G6H9Mmz41HEsYA4vCjBbt2ySoW8CNUDido7hkaoR/y+gksg
         B7gJfGuDGIi3Q/mn9Nq6Lkm7QS83zDnh+nHG4Ft4Uz6mRNQxhgBLeU5Z0o+xptQ/2Rur
         NqugPv9DXMzSMgY4MO9ByoXF8N8gN4UpcOdR1iJtM0xxSt30HMK1D02TflZHAjVJ/hDJ
         9YuZQ+twqMfPkcymJ+vQ/aWXyn3PJ2jE7pMGMZudhiIrIFUtfmDexiVExIWjgifo2wFt
         fmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723045931; x=1723650731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRFdCUk81EgAuZOPUgff1QAMGIx+EiDXi2BrG6XIJyg=;
        b=Y69/8VICF/JK/epeB8XBxmwvk2u3Ehr3uP/4iDCoOKb/EcldwaQ8FKDUEJ8bQ+7XHJ
         eZOaNLq+eZtFcKuJ7aiEx1Vg/JputZ0gW3lbg6GjKfBJH0VksPKZ/vabJZRi5wn1E4Fv
         Km2z/ep/tsz9z5+73XoXdoooNvMO9NGguGClGGINdVRciPqSEBWZMRNjtEkUOewsvUqk
         GkXKvReJNfO3MMS8k1/C4X80SbfkHvf5ZBHgmPcDSUNT5k56y1hse2sXQ5ATnHTn4Ao7
         aTcGqbjKnHYqDGAnpefDtYFFqU79EC1S5+xV97+aGUcapnFrmAnEI+i2oxeACFr1aQZY
         QYfg==
X-Forwarded-Encrypted: i=1; AJvYcCXkhSK3HEewIYL4cDBZsred/8+GUtqbCAJ8A9QcVIIULqy2RtSTQXG3IbXL38lBa8INPDS8K2xCNdU7yTtWnGb2GHwUmWKo/HrH1XtHFTMTmA==
X-Gm-Message-State: AOJu0Yx5F6JsxDyeFHMdrdKf1YtX7TntP1OsH7pmLVt1pkid3A9G2Ici
	8udZlNtYsoRSLlH1GZpd5YNGr27/qXZUkcvQhPoGBT/7lLIf3iQXmOMfm8uEuio=
X-Google-Smtp-Source: AGHT+IEEeoPN6j8nzeZeQO+PeuL8PISW2uSCLYbhFOCXh07DB880ZpSmwybG7OY/YQmH+1Lm/6eO9A==
X-Received: by 2002:a5d:4e90:0:b0:368:591:9bc1 with SMTP id ffacd0b85a97d-36bbc1bd311mr11569869f8f.46.1723045930947;
        Wed, 07 Aug 2024 08:52:10 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd0261c2sm16428839f8f.57.2024.08.07.08.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 08:52:10 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	peterz@infradead.org
Cc: James Clark <james.clark@linaro.org>,
	Al Grant <al.grant@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2] drivers/perf: arm_spe: Use perf_allow_kernel() for permissions
Date: Wed,  7 Aug 2024 16:51:53 +0100
Message-Id: <20240807155153.2714025-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For other PMUs, PERF_SAMPLE_PHYS_ADDR requires perf_allow_kernel()
rather than just perfmon_capable(). Because PMSCR_EL1_PA is another form
of physical address, make it consistent and use perf_allow_kernel() for
SPE as well. PMSCR_EL1_PCT and PMSCR_EL1_CX also get the same change.

This improves consistency and indirectly fixes the following error
message which is misleading because perf_event_paranoid is not taken
into account by perfmon_capable():

  $ perf record -e arm_spe/pa_enable/

  Error:
  Access to performance monitoring and observability operations is
  limited. Consider adjusting /proc/sys/kernel/perf_event_paranoid
  setting ...

Suggested-by: Al Grant <al.grant@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
Changes since v1:

  * Export perf_allow_kernel() instead of sysctl_perf_event_paranoid

 drivers/perf/arm_spe_pmu.c | 9 ++++-----
 include/linux/perf_event.h | 8 +-------
 kernel/events/core.c       | 9 +++++++++
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 9100d82bfabc..3569050f9cf3 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -41,7 +41,7 @@
 
 /*
  * Cache if the event is allowed to trace Context information.
- * This allows us to perform the check, i.e, perfmon_capable(),
+ * This allows us to perform the check, i.e, perf_allow_kernel(),
  * in the context of the event owner, once, during the event_init().
  */
 #define SPE_PMU_HW_FLAGS_CX			0x00001
@@ -50,7 +50,7 @@ static_assert((PERF_EVENT_FLAG_ARCH & SPE_PMU_HW_FLAGS_CX) == SPE_PMU_HW_FLAGS_C
 
 static void set_spe_event_has_cx(struct perf_event *event)
 {
-	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && perfmon_capable())
+	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && !perf_allow_kernel(&event->attr))
 		event->hw.flags |= SPE_PMU_HW_FLAGS_CX;
 }
 
@@ -745,9 +745,8 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 
 	set_spe_event_has_cx(event);
 	reg = arm_spe_event_to_pmscr(event);
-	if (!perfmon_capable() &&
-	    (reg & (PMSCR_EL1_PA | PMSCR_EL1_PCT)))
-		return -EACCES;
+	if (reg & (PMSCR_EL1_PA | PMSCR_EL1_PCT))
+		return perf_allow_kernel(&event->attr);
 
 	return 0;
 }
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1a8942277dda..e336306b8c08 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1602,13 +1602,7 @@ static inline int perf_is_paranoid(void)
 	return sysctl_perf_event_paranoid > -1;
 }
 
-static inline int perf_allow_kernel(struct perf_event_attr *attr)
-{
-	if (sysctl_perf_event_paranoid > 1 && !perfmon_capable())
-		return -EACCES;
-
-	return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
-}
+int perf_allow_kernel(struct perf_event_attr *attr);
 
 static inline int perf_allow_cpu(struct perf_event_attr *attr)
 {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index aa3450bdc227..ae7d63c0c593 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13351,6 +13351,15 @@ const struct perf_event_attr *perf_event_attrs(struct perf_event *event)
 	return &event->attr;
 }
 
+int perf_allow_kernel(struct perf_event_attr *attr)
+{
+	if (sysctl_perf_event_paranoid > 1 && !perfmon_capable())
+		return -EACCES;
+
+	return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
+}
+EXPORT_SYMBOL_GPL(perf_allow_kernel);
+
 /*
  * Inherit an event from parent task to child task.
  *
-- 
2.34.1

