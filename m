Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504613AE19D
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781292559; cv=none; b=cTEHl/5IHDCHePmlCWcJQZs0JjRZQ6qTleZdM/yeft/u2qfVOhNNFwBPpG5yIr+cspzSjZRgFQjcE9/IPL6nEJU22cBwqC6qAe/l7C+KfWNWaYxDLsJLM3WSVOEHvxf8Anc7Dr6TmXhz7o+GhjoFs6bUjNG9+X/tDiRyp+P4VMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781292559; c=relaxed/simple;
	bh=06yjw3p+ipuRaTZAWCI5G1pBBjTnmA793yGUK4DpqJU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gbOSMSYGlDXvvBgf4YEyll3gna7EGhQz9zsGLyeFG7t9fXCbua6U41anjd9SEKCjvh0Xg4Wr6STipEIs4pn/sYLcM5mKuITI6cJiwCevmI9KZunBc3cqgZKKub7NsDjcxOWzeUVC00hKZ9dpSTKTD8I5SsZ1KONc3S0/5U0STFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qt4zRkD3; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qt4zRkD3"
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-485fdae1db3so1755326b6e.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 12:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781292555; x=1781897355; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2M2UIoQTEUhWBAO6CcMuiUQsYo7FQeN0Fuvmz5eDMgU=;
        b=qt4zRkD3P79O7CMpCSgk2omvpeByXpgYK9BDRDYhwAC8+FHRR8aGBq7LgT2OwxcuoU
         PwPKAiPPDUmcZyakBXMBHt5xbzkAyuwYYVR388mFOdByzJkudKL3psOSscsWulusiIOC
         Br8SXVene6LB43AzjyN7JDdft61KRpCxslVBWRa3ZsAduCrt3p4ztm3NNtAZZiu3ipQX
         3j+2fq85DkWaFF/y34kN5cpPYuATR3h8HakRWBcVgHlzN9iZDoCOspsFGGOjpslvcipm
         FgrQUGSgAcntqR6Txf4LGNcWg0mkC9dNcAHrz0JEh04lpgLotX6ynmO59E2pEn09Riwl
         B4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781292555; x=1781897355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2M2UIoQTEUhWBAO6CcMuiUQsYo7FQeN0Fuvmz5eDMgU=;
        b=omjoVppXltcBaGPdHpMLXnJSAd73+dvKTAneiG/01CpbGeQoRq4uFnoxIM0R0yzw09
         E0xKEKrDYA2cvFE5YckC3xia8rUCQE1WLk9GMYAr5QpLFrKjk422Gb7QZKkegR7foDtz
         qXU9O055LPN7YSbpoasWjxCbEWGrF/0TsfpxMFoSEcG7H7CdULxACJke8qqiLdVniEV/
         X11D+7oI+K7iyUZSDdMjaGqyBQgZMlsWg5/YSmPRBj6daxaXR5jn/jyNL5FvVuMd4KBP
         X3MkwgwJS8n5v7In9OLctkdNkyDjE0XPp068uO56tpkiAFpRlwd20gQNtc8U7z2zfnYq
         kURw==
X-Forwarded-Encrypted: i=1; AFNElJ+kbPxlrPRptwOPFJqyqzpj4gS5s5nRntIljHcHn5D/YaXzlVTjkkFyqUcBNILK19Q6MeUFc3eTlFkUVdTXCGA0@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi+iHR90hHC1kQJKw3M43aM0zdIq5H0caAZAilsWS4JSMtnTNW
	ZfNEJxe5fvzLlhizW6K55RpN4gjPVIjvKz0zLMlDnz4Vk2eb2v7liOpIIk6NgKkXWzyl4l5ppZ0
	IV6ROBwoqzdTaXwiUkFIYyGL7Jw==
X-Received: from ilbdw10-n1.prod.google.com ([2002:a05:6e02:410a:10b0:502:1132:3db9])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1920:b0:479:e7c7:dc76 with SMTP id 5614622812f47-4872f4bc1a3mr2488426b6e.26.1781292554890;
 Fri, 12 Jun 2026 12:29:14 -0700 (PDT)
Date: Fri, 12 Jun 2026 19:28:53 +0000
In-Reply-To: <20260612192909.1153907-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612192909.1153907-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612192909.1153907-6-coltonlewis@google.com>
Subject: [PATCH 05/21] perf: arm_pmuv3: Check cntr_mask before using pmccntr
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Alexandru Elisei <alexandru.elisei@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Mingwei Zhang <mizhang@google.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Shuah Khan <shuah@kernel.org>, Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, 
	James Clark <james.clark@linaro.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Check cntr_mask before using pmccntr to ensure it's available. With a
partitioned PMU, there may be instances where pmccntr is being used by
the guest and will be absent from cntr_mask.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 drivers/perf/arm_pmuv3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 1cceb1f614515..17bb1cfdc271c 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -1028,7 +1028,8 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
 
 	/* Always prefer to place a cycle counter into the cycle counter. */
 	if (armv8pmu_can_use_pmccntr(cpuc, event)) {
-		if (!test_and_set_bit(ARMV8_PMU_CYCLE_IDX, cpuc->used_mask))
+		if (test_bit(ARMV8_PMU_CYCLE_IDX, cpu_pmu->cntr_mask) &&
+		    !test_and_set_bit(ARMV8_PMU_CYCLE_IDX, cpuc->used_mask))
 			return ARMV8_PMU_CYCLE_IDX;
 		else if (armv8pmu_event_is_64bit(event) &&
 			   armv8pmu_event_want_user_access(event) &&
-- 
2.54.0.1136.gdb2ca164c4-goog

