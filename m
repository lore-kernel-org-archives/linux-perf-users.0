Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82C241D626
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270980; cv=none; b=KPiHb0Hq97IGkxb7z0zXCGfPZ5dIG5We7pB8XbSL2jlB/AH60vP2P+49bVFvvXnyUzjCKcTMw5Ae5JAM8VFmfcPpvcCiPkB0eae6K+EqEkntPLgkkC66HMhYHBXUCPbZmO97wTRha36oSP/PV454tv6kAYmU9FhBf9vrZMj4r88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270980; c=relaxed/simple;
	bh=o0Jzui9ZfVVjkFYulYQU6i4Uskd7NOEsWuEiZOIDfiA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EaeWfl/t8IuavDeRPAdxixDzFwVW5oYYNH0xIyDVJpSMBTCY92qA57ULKIthwDVTx647fJc/D28ncMM2oar0iIyA7U4IYnvmu9uovWBG78z3TYMz+n07Yd8fFImXyDmihdcejS/t6wV1vDRltNEOQKdPX37X9Vp5Rj1LjruU1nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qGkyzOV7; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qGkyzOV7"
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-8064fadbb1dso20986a34.0
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 10:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790270975; x=1790875775; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eo5DRTmpsGszPddi/UamZur+o5cefOUS1h+X+Vf57sI=;
        b=qGkyzOV7t7WvBIhx0CGdBWaFEv3ZXNxB6n6q0AlFoDFpK15NbQpSIFW2ppkqZ2TxYM
         DuQ+wfl0zWXW+sI1QPfjZ9d7Ef/V93KtHIkZyw3DkdqZYqLCWaAgZ8HQhz2UBNe4MVNF
         5Bf5D0dlgHucr/D0RUNv06vQjaJUO2gBinIbtAocrmtBqMP9vSDsU6xO8QnJ9+9tuVFS
         QRA4mt2osFqxFJZCvJVG88YolYDB9WCc/1CYr384e7wbcIq8WdMDD/usTZTMbo4dNt4Q
         5LJ6l+T2gylI3v5xN9bqLpu3nkJvmOtBt1RHpwuUc5T5jluZYhWgL9xEsnf1EFmZsGkH
         eNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790270975; x=1790875775;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eo5DRTmpsGszPddi/UamZur+o5cefOUS1h+X+Vf57sI=;
        b=ui0gBi1iWC4rSbt0Yu/SJr2Nz7X3rjQXfb1gtIT+wlRvPLAyuNa4TglsPhRyiVPviK
         Qc1kNZ+VAnCs9v84xVFXbGMunC/qQgoK8MiuOc93D3AENkOrXJGMo7K8VkT9j+u7mkTF
         dETTvA96TBZBdPVXg1IMqww2X8TKzFMGVuTzZTKmv9e8yYwwCui+rfkv2kO6V6arWkeb
         RRjGpr0xYTO5Dv4zqRF8lNvNCNAI5JOZqSq6OsI6d+Nv7QdA1TUubE7FdAfu3l+3jUPV
         U1Jit04XRyr/xK9wcZsnMIq70D5k101PNn4JJGFFoeZobyjAQGVmfgBodYJX2XIOfXE0
         /06Q==
X-Forwarded-Encrypted: i=1; AKwUvBxJETcmgT29BRPAAQHCLxiVp721uaPyXAmsX68sm7KKjxjs5XPp20CptzA6EHtxoObgryYOF9m89kKG5OFf0GhL@vger.kernel.org
X-Gm-Message-State: AFuF++kClOB0F7qE5QWGFM4lCJn+PVOms9U8chqRMFd07h5e5m7hqiP3
	/mNknQjFyTBCqP5E7wh9TSFOUInxBw2SzInzdcwstZJkx/VtispoMPqgxWwHkULXKU/MGq7nhBx
	iE+YYTGjHyyyUpC2L3nn3oznBLQ==
X-Received: from ilei14-n2.prod.google.com ([2002:a05:6e02:61ce:20b0:50d:6d0c:d703])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1825:b0:4c3:5e7e:84cf with SMTP id 5614622812f47-4d728717be4mr3871316b6e.14.1790270974963;
 Thu, 24 Sep 2026 10:29:34 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:29:10 +0000
In-Reply-To: <20260924172928.2110956-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924172928.2110956-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924172928.2110956-5-coltonlewis@google.com>
Subject: [PATCH v9 04/22] perf: arm_pmuv3: Generalize counter bitmasks
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	James Clark <james.clark@linaro.org>, Robin Murphy <robin.murphy@arm.com>, 
	Zide Chen <zide.chen@intel.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Mingwei Zhang <mizhang@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, Shuah Khan <shuah@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

The OVSR bitmasks are valid for enable and interrupt registers as well as
overflow registers. Generalize the names.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 drivers/perf/arm_pmuv3.c       |  4 ++--
 include/linux/perf/arm_pmuv3.h | 14 +++++++-------
 tools/include/perf/arm_pmuv3.h | 12 +++++++-----
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index fbd631ec71a65..4a6c1f3bcea1f 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -535,7 +535,7 @@ static void armv8pmu_pmcr_write(u64 val)
 
 static int armv8pmu_has_overflowed(u64 pmovsr)
 {
-	return !!(pmovsr & ARMV8_PMU_OVERFLOWED_MASK);
+	return !!(pmovsr & ARMV8_PMU_CNT_MASK_ALL);
 }
 
 static int armv8pmu_counter_has_overflowed(u64 pmnc, int idx)
@@ -771,7 +771,7 @@ static u64 armv8pmu_getreset_flags(void)
 	value = read_pmovsclr();
 
 	/* Write to clear flags */
-	value &= ARMV8_PMU_OVERFLOWED_MASK;
+	value &= ARMV8_PMU_CNT_MASK_ALL;
 	write_pmovsclr(value);
 
 	return value;
diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
index d698efba28a27..fd2a34b4a64d1 100644
--- a/include/linux/perf/arm_pmuv3.h
+++ b/include/linux/perf/arm_pmuv3.h
@@ -224,14 +224,14 @@
 				 ARMV8_PMU_PMCR_LC | ARMV8_PMU_PMCR_LP)
 
 /*
- * PMOVSR: counters overflow flag status reg
+ * Counter bitmask layouts for overflow, enable, and interrupts
  */
-#define ARMV8_PMU_OVSR_P		GENMASK(30, 0)
-#define ARMV8_PMU_OVSR_C		BIT(31)
-#define ARMV8_PMU_OVSR_F		BIT_ULL(32) /* arm64 only */
-/* Mask for writable bits is both P and C fields */
-#define ARMV8_PMU_OVERFLOWED_MASK	(ARMV8_PMU_OVSR_P | ARMV8_PMU_OVSR_C | \
-					ARMV8_PMU_OVSR_F)
+#define ARMV8_PMU_CNT_MASK_P		GENMASK(30, 0)
+#define ARMV8_PMU_CNT_MASK_C		BIT(31)
+#define ARMV8_PMU_CNT_MASK_F		BIT_ULL(32) /* arm64 only */
+#define ARMV8_PMU_CNT_MASK_ALL		(ARMV8_PMU_CNT_MASK_P | \
+					 ARMV8_PMU_CNT_MASK_C | \
+					 ARMV8_PMU_CNT_MASK_F)
 
 /*
  * PMXEVTYPER: Event selection reg
diff --git a/tools/include/perf/arm_pmuv3.h b/tools/include/perf/arm_pmuv3.h
index 1e397d55384ed..d045b0f3b93fe 100644
--- a/tools/include/perf/arm_pmuv3.h
+++ b/tools/include/perf/arm_pmuv3.h
@@ -226,12 +226,14 @@
 				 ARMV8_PMU_PMCR_LC | ARMV8_PMU_PMCR_LP)
 
 /*
- * PMOVSR: counters overflow flag status reg
+ * Counter bitmask layouts for overflow, enable, and interrupts
  */
-#define ARMV8_PMU_OVSR_P		GENMASK(30, 0)
-#define ARMV8_PMU_OVSR_C		BIT(31)
-/* Mask for writable bits is both P and C fields */
-#define ARMV8_PMU_OVERFLOWED_MASK	(ARMV8_PMU_OVSR_P | ARMV8_PMU_OVSR_C)
+#define ARMV8_PMU_CNT_MASK_P		GENMASK(30, 0)
+#define ARMV8_PMU_CNT_MASK_C		BIT(31)
+#define ARMV8_PMU_CNT_MASK_F		BIT_ULL(32) /* arm64 only */
+#define ARMV8_PMU_CNT_MASK_ALL		(ARMV8_PMU_CNT_MASK_P | \
+					 ARMV8_PMU_CNT_MASK_C | \
+					 ARMV8_PMU_CNT_MASK_F)
 
 /*
  * PMXEVTYPER: Event selection reg
-- 
2.56.0.rc1.310.g51773c2048-goog

