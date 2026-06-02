Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F913FE664
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 17:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422157; cv=none; b=Br9B+vyp8IucGPcq7sAwyrtDGtU58Yr9e6bT3CJpGe4F+s4O9CWp/fsgicRtYxlD83AKnP+pLOChadgtUxXlBC2UcKWTuSBP5Wv1nx71dBUvoFTlAONDNt9xJyviDY0bVeAlXwbI8stKzBkKael16kX1fa7orEg8NDSIBTYzRlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422157; c=relaxed/simple;
	bh=7zoS/DQb8LxZ/5FWG5oM7DskQu3ov3TTh9IX1qRXvmI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WUQoYo6MRWnKAlcIKa7Wm+kUnHVXoX2BLtAc1yjM+Z5nyqq8ndHz4FRNXAr8TIj0bmWBveOsrdrbvTahrJhyeL/rKrwmcwW+TIkT4mD+dN0C1iyj5HUHny9Mvblt6Zk75vHvX/DyLJ2YwFwsMKK/iBrof7aZclHlhdA38j2r55k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QBA3urfI; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QBA3urfI"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304d0d0b28eso5749838eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 10:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780422155; x=1781026955; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nQ36aqrIxJrk3Qf1tlYot1bO4SWFhpa59dUQaFvnNiY=;
        b=QBA3urfIK4+OnXQT3oGXM03Mu1EZohm9qtKMRy6Woapt0fZxnYJYosB6JbkPHXD6JE
         lsEtSLkM8iV1pcMylrFSBj7sXL0VNl8r8qL5pw31hnwCMxP1oaZiWYEDBXM28V3mmKtW
         4Pw3ajYDt+EVqT+0wa5vNnOgptrcALi8md+rHZ7Na59NEO8WMtlQPLRAG+ZXNxyv0bMl
         ONlUwfkLwRTuY53kkDp1KLwZWmGp50FKfhknDxyMEkLJwWUhSMmAx9sOyAY+r2jLFi0N
         9cmPqUWW6i9GrZawWczUIfiGfDSsgQ245oEAM6gKaJyKz6OEcN9gPGHHGofTU4s4Oaj1
         +IYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780422155; x=1781026955;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQ36aqrIxJrk3Qf1tlYot1bO4SWFhpa59dUQaFvnNiY=;
        b=TQb9it2I3MiQ80P2YLv+uFldjJS0YMHvbN7eDFYHfaHUur12/uLrCpQSh7VKvCS/0s
         KYbADRLoeZBpz3VsD3sAgmr+VYS+TUiIpCSLddVUBczYK/iRAdCgSO/uyDjvAL20NgzV
         FR5y58z+RIYxP94gofswErvc9upw5PICdcKBTC6EwCE8BtuYDi6WA69BgTglJS28UYJk
         24wSiqt4Z9aLqUqymeTu/GSKDwunYe2yX3M/7wJjhmV6z7yCeN5pgqlcnnL2P0hUUv0/
         EDtEHAKCR4MbbdNsae3gcBl34XZutwAzLT70dgrxhodwQ7WTD6bF/CAdjKxfc4HPIZIz
         q2nA==
X-Forwarded-Encrypted: i=1; AFNElJ+vhMPVA8VVbnmCKGEBu/vrjJ6Q2YdFm8FxAdsRTBheJUwKolN5eUC8J9NyCfy0loG5EdGv6ZsTfy7AX2vOsgg2@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbr4IGeuuuBH7iqqi1eqJNczsRsX/IAXw0/Pnzm1YBIaIpUIJU
	u7pEc4MfZKd1kelodP2wPWRvWaJhk+Ske/whZ28eZGriFOEkHPfYcf+MfdhdD/ZQN0DVM9dI2Xo
	5pTdcBvTp5w==
X-Received: from dybml15.prod.google.com ([2002:a05:7301:150f:b0:2f2:fc0:8869])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:80c6:b0:304:ab8:f899
 with SMTP id 5a478bee46e88-304fa4c9603mr8523416eec.8.1780422154783; Tue, 02
 Jun 2026 10:42:34 -0700 (PDT)
Date: Tue,  2 Jun 2026 10:41:28 -0700
In-Reply-To: <20260602174129.3192312-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602073132.2653307-1-irogers@google.com> <20260602174129.3192312-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602174129.3192312-18-irogers@google.com>
Subject: [PATCH v8 17/18] perf pmu: Recognize 'default_core' as a core PMU and
 document matching
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

The is_pmu_core function checks if a PMU name corresponds to a core
CPU PMU. However, it currently fails to recognize "default_core" as
a core PMU.

When "default_core" is used, the PMU scanning fallback in pmus.c
scans the "other_pmus" list. This scan is slow and always misses because
"default_core" is a core PMU, leading to unnecessary overhead.

Update is_pmu_core to recognize "default_core" directly. Additionally,
document the different matching approaches (exact name for x86/s390,
sysfs-based cpus file check for ARM/hybrid) to clarify how core PMUs are
classified.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 23337d2fa281..9994709ef12b 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2029,9 +2029,26 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_call
 	return 0;
 }
 
+/**
+ * is_pmu_core() - Check if the given PMU name corresponds to a core CPU PMU.
+ * @name: The PMU name to check.
+ *
+ * Core PMUs can be identified by:
+ * 1. Exact name match:
+ *    - "cpu": Typically used on x86 architectures.
+ *    - "cpum_cf": Typically used on s390 architectures (CPU Measurement Counter Facility).
+ *    - "default_core": A generic name used to refer to the default core PMU.
+ * 2. Sysfs file existence check (is_sysfs_pmu_core):
+ *    - Typically used on ARM systems or Intel hybrid architectures (e.g., "cpu_atom",
+ *      "cpu_core"). This approach checks if the sysfs directory for the PMU
+ *      contains a "cpus" file.
+ */
 bool is_pmu_core(const char *name)
 {
-	return !strcmp(name, "cpu") || !strcmp(name, "cpum_cf") || is_sysfs_pmu_core(name);
+	return !strcmp(name, "cpu") ||
+	       !strcmp(name, "cpum_cf") ||
+	       !strcmp(name, "default_core") ||
+	       is_sysfs_pmu_core(name);
 }
 
 bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu)
-- 
2.54.0.1013.g208068f2d8-goog

