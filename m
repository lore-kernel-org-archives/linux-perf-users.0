Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A0C28507C
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Jul 2025 22:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752533980; cv=none; b=dEEZkFCgoM5GwYLCBm7rANWZ3WhyXYzPoMKGrgsJqhJHqNX00xZau6cioL56os+bmOZK95pYrN8WN+P/x384uXu9O6ZV9vgx4tyipchvT105bsUefSc4RygBqvDHsZrS4useF2nzbqAqaRF7j07KXnH4Err6sYjIeHmvRjL+m7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752533980; c=relaxed/simple;
	bh=7v4sX5q8lLRJ/EAnEhPnRBoogEWKPydlhazoaBQzE90=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DEkOHYX/Vcw4JHMo1VG3beqwjDXaTOX+2pon7m7vGZyBUNqp0sfLJ0WoX8EtJkVDrmfiHtM7iuI4yfjqrxWP6nuRGK9cej1YpJVtErgpgsP75/iaaLN9MCrWJdjtaKU3Q3ZGis0WdDih0w54sVeb84xrmx9kkpnHDmaeIN0AaBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zu+YNcNa; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zu+YNcNa"
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-86463467dddso519843639f.3
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Jul 2025 15:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752533975; x=1753138775; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4LikijBgA9hgJn1z8WT/27yywkDcxcZWUZywAO0Cb1M=;
        b=Zu+YNcNa3/K+QAWxd2ELbUb/41b/6dRNMoftovfqHLGBpm5S0u89xQcHtiOMDeeTt9
         EUJ6s07PSjHp9PwA+Hxu/XV3Y+lx7lZfKnfMB0pV5C5oRMbjAaDx/WKPXQJasbDzP2MS
         rvqq29m8+GocQa1PjLMe2Wgs6j9IsKTVWhiRHaWOyWcYn3/E1W28D4SFmgtQSt6gdWMn
         2j8laq+kTXU68TZxPgsHI6klJ1/vGyhDgTgq+yPg2TD0fjX9k9Z6KTWVwISeY4yXJB82
         vJ5hg/PGehayVO7ItFwBZJgdDpEeGvaz9lCF+i67TRwnsMI2EFhX5hBjBhf3r9zS0+OQ
         cBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752533975; x=1753138775;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4LikijBgA9hgJn1z8WT/27yywkDcxcZWUZywAO0Cb1M=;
        b=u9faCJ+Cz0HxJng3F/pJq9J+cqF/7W7s4iCTlw/9o6kr+Mx/D9qc8KOAx7Vmwms2ff
         D6YauBR4P3HoNyLdZAgDJ+D01foAVR3vkU2odi2zPTBcxF4CcVhLtN3pMyFFocJVV6XC
         oscMsrKjyHtzBHTMWtFAJBCA6W1UlKF4CUQf31genNUGTPTleUTZripCpHBPLIlJWmDy
         wt8kACNW5H1KJo9sEzxU8Oc3kj/91Y+eaHv66osEtBSePuD5HaUcgh5AW7boT6lsh5df
         VBsB30PKsFbp4Aosa+4+2ju8oWyBsC0qQ7GN0uxzfyb7wNWUAzBmmCljYWYzI32XjSVB
         2WCw==
X-Forwarded-Encrypted: i=1; AJvYcCXw9xtEIqHsvFsuDH2zbtCu6f50HQyUEt7IavgiDQJ8QX4UuMsUqSIXFd/Gugy55gS3kWDgXUb4stE5Iviq7fMa@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ZunhBjFRjcrtYastQRMvR4i1gmzcw2ouHbDklQylI2ps+HJl
	YEBAJG1rpSnjejvW5sPMhK4epnsUgxk0J4DQL4yDsuNhOlja9B/nKPN83PB7UZrbiwkX+u6f7Aj
	AKUdlfWpjwFcJsYd3B7bTDihBWg==
X-Google-Smtp-Source: AGHT+IEwx9UBGT/8wheREiWV+S0ihYQlL4yh0otkxzUq1va/b8+IqqW7BehvDHYAb7BE/vWyVZofNwSdDr4keaqSbQ==
X-Received: from iove26.prod.google.com ([2002:a05:6602:45a:b0:861:c7b1:d848])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6602:7402:b0:873:35c8:16f9 with SMTP id ca18e2360f4ac-8797882781amr1351696339f.8.1752533975408;
 Mon, 14 Jul 2025 15:59:35 -0700 (PDT)
Date: Mon, 14 Jul 2025 22:58:59 +0000
In-Reply-To: <20250714225917.1396543-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714225917.1396543-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714225917.1396543-6-coltonlewis@google.com>
Subject: [PATCH v4 05/23] perf: arm_pmuv3: Generalize counter bitmasks
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

The OVSR bitmasks are valid for enable and interrupt registers as well as
overflow registers. Generalize the names.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 drivers/perf/arm_pmuv3.c       |  4 ++--
 include/linux/perf/arm_pmuv3.h | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 294ccbdc3816..339d3c2d91a0 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -518,7 +518,7 @@ static u64 armv8pmu_pmcr_n_read(void)
 
 static int armv8pmu_has_overflowed(u64 pmovsr)
 {
-	return !!(pmovsr & ARMV8_PMU_OVERFLOWED_MASK);
+	return !!(pmovsr & ARMV8_PMU_CNT_MASK_ALL);
 }
 
 static int armv8pmu_counter_has_overflowed(u64 pmnc, int idx)
@@ -754,7 +754,7 @@ static u64 armv8pmu_getreset_flags(void)
 	value = read_pmovsclr();
 
 	/* Write to clear flags */
-	value &= ARMV8_PMU_OVERFLOWED_MASK;
+	value &= ARMV8_PMU_CNT_MASK_ALL;
 	write_pmovsclr(value);
 
 	return value;
diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
index d698efba28a2..fd2a34b4a64d 100644
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
-- 
2.50.0.727.gbf7dc18ff4-goog

