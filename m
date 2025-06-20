Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1243924DD10
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Jun 2025 22:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750457931; cv=none; b=mOnDjDwsmTh/7n7YXEP3J21nu2SU7+tRcf/YmP1l4hZcWQdvWPgHJ1KSSI8lXiZA/7pWf5U++KYJtdC6Vm15i8JYY0xwjQJfATMAJapFJYE56sm1DnWFBwGucyrG+IcBklZK4fiVms97OumMM9g1+o5/ceRESVNxmj/7b4ZFtTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750457931; c=relaxed/simple;
	bh=QZPsbtUaYametyX+rMN8NQzux/Frt4tHD8rtEMiJ9Sc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VslKJViMgGjXm9EFaIYrA1hWOgMNHiVws7A4Za+bohnbv6CyTAJxG42Krt5rrbY7WSvLBn7nDYvsCeMyRkZ1TnxQGd3ITqcIMtOCYip5y7B4IXEkyjyRy4evKYvrMzoZ7jXAVxDhPoO2TEr4sTyZbHzfMOKCSqJ4Vb7/Kd+IlCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Z+cZGCf; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Z+cZGCf"
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3ddafe52d04so70001605ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Jun 2025 15:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750457927; x=1751062727; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qBxhIed3fkpmOQu/SLH3ienlsanfX2Wz3izzC9sfark=;
        b=3Z+cZGCfJ78sAjnnQ72+f3zHiwvuj5b/uXlIYL3THEqhtbdqTyH4shcij3/980B3Mn
         3XQ/BZCRacwGADPnTbY8217yPtpdCuBMr2PGkyQ1FhCyCyVvueVSO11Z1u274p71DKzm
         1nioFD5LH+WJankQC1S4IJo9sJ4ocWG4SyryHPE5c+v88Wu+yVcPmZoK5eFxE7/W5pLj
         hImWLkE3tC0bWIGZLpfPwAHK0zORXg3H0Jtm52vnXnCbS51le6znl1oz6+ONS6n6qQHq
         TEIj2LqBjO3Xqifh94dZjWpvsi9ALx0lCASLMYuSsQ/NzYv9jjVBRsBJRCByd32a7D5k
         Pzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750457927; x=1751062727;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBxhIed3fkpmOQu/SLH3ienlsanfX2Wz3izzC9sfark=;
        b=Fr7j8j3py0r26I0cfFVnAHNgPjbwSTTxyuLIXsF7Q9O0lHok7UOEzsn+/5g1Ta1KH1
         RAklk7etIL+ofhJYsU6CmBmPrzprjZ3j174ejbfgEd5roPbqH5fU9pYxs88Sw27WUfY+
         qKtkExcuFZ0NMOTUq98QpqqQy34rS+lVcSOBDqf0HccaS3Xx5Gs1u/u4le5XGj0YffYi
         56MFOdjU1L4aBfIGay1z6LPh/IDqW3IyTrLX/cpBpFVqfwBfKW+XIMXgNFo8dIYqVw4e
         ig7u3dZMbcSBNGXtZRSmMSij6PyzCFCo6tWbvacDRFtekIA2RcOecLwN8Ar9CxZyBQ8q
         i92Q==
X-Forwarded-Encrypted: i=1; AJvYcCUk8wd9Dqjppk5GhQsr9wsKTFLoFJMrSp/VseKb1JM3R4aMH5W4ly7zutbKjULtHko8tYsHChytS8NBcJ6FCtgx@vger.kernel.org
X-Gm-Message-State: AOJu0YxtKvJcPw60eEUIoKrZf4sEd4LpWhX+mSj3n0g+rlWQZjhToOPE
	4QG+nG0kOKwwa4GNb/wUt3o+xqrUOsttVnHYKaDk2MOR/obb9fPy+NEUxSEqtThOG9xdw/SghUU
	9dx42NkuAeWRakEUtM2nIYyEZEA==
X-Google-Smtp-Source: AGHT+IFTbBL04tu/5o1zgL0CZq/zWbduiqa+Y5YKeofcr7jFQYs86cUlPmuIGNSiiyk8Ax4cMVHcBUNCIBRZtQH70g==
X-Received: from ilbcp10.prod.google.com ([2002:a05:6e02:398a:b0:3dc:756a:e520])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:2488:b0:3dd:c40d:787e with SMTP id e9e14a558f8ab-3de38c1b8f3mr60278825ab.2.1750457927652;
 Fri, 20 Jun 2025 15:18:47 -0700 (PDT)
Date: Fri, 20 Jun 2025 22:13:11 +0000
In-Reply-To: <20250620221326.1261128-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620221326.1261128-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250620221326.1261128-12-coltonlewis@google.com>
Subject: [PATCH v2 10/23] KVM: arm64: Correct kvm_arm_pmu_get_max_counters()
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Since cntr_mask is modified when the PMU is partitioned to remove some
bits, make sure the missing counters are added back to get the right
total.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/pmu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index 79b7ea037153..67216451b8ce 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -533,6 +533,8 @@ static bool pmu_irq_is_valid(struct kvm *kvm, int irq)
 u8 kvm_arm_pmu_get_max_counters(struct kvm *kvm)
 {
 	struct arm_pmu *arm_pmu = kvm->arch.arm_pmu;
+	u8 counters;
+
 
 	/*
 	 * PMUv3 requires that all event counters are capable of counting any
@@ -545,7 +547,12 @@ u8 kvm_arm_pmu_get_max_counters(struct kvm *kvm)
 	 * The arm_pmu->cntr_mask considers the fixed counter(s) as well.
 	 * Ignore those and return only the general-purpose counters.
 	 */
-	return bitmap_weight(arm_pmu->cntr_mask, ARMV8_PMU_MAX_GENERAL_COUNTERS);
+	counters = bitmap_weight(arm_pmu->cntr_mask, ARMV8_PMU_MAX_GENERAL_COUNTERS);
+
+	if (kvm_pmu_is_partitioned(arm_pmu))
+		counters += arm_pmu->hpmn_max;
+
+	return counters;
 }
 
 static void kvm_arm_set_nr_counters(struct kvm *kvm, unsigned int nr)
-- 
2.50.0.714.g196bf9f422-goog

