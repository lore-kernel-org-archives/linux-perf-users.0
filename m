Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905492D239A
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Aug 2025 19:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510274; cv=none; b=fKd1dP2OoAkIW+uCdwTWzVRxvhvHvihfpM5tOMqUW5AxG7UN9JwbAsrNyZoRDus8L+GRVfrKPOwh3NpsdvN6RHRB91zuzYlDcONxgcC4I/r0dM7RZsmFhu6k2M5mLznbtiJUXu84ctehF/S6vbUuZwdlDF1N4IktHXhV55moA7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510274; c=relaxed/simple;
	bh=Bb1MCKlidS4HUVTcCu642tswWStbNqiXpa6NcxDtYbk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QSxj2CVBKd6mGFEPT9wTWvip6u/v7C8Hjczv0QfwX3p30F2wz0BKhDJyh4zVixh2pn1+dhlEfFg9MHFLiXi0dfGrUWiEG0w28jiTXACHbfiwc094GWrMQJqkn5RNh6Cm6h06vkXJlf3G+WQMKAk1R7NYmkpu1G8Mxy9jM79HExM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pGBJ+uSW; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pGBJ+uSW"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31f65d519d3so468873a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Aug 2025 12:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510270; x=1755115070; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=P+6kUSR5aBTgNcunERrWOcQMCZiG0moZeRQ0turCJ94=;
        b=pGBJ+uSWmY4u2nY77yBijaQ3pMQAq32EqtGrVokpellFCEw6GPtef9oej+go+VN3I3
         Sq5svNwPiH82SYrZeJinnAa2YMkUdBujXyglUR2OImyeJBRhKpQQpG9py2/v+3G+ncOF
         7Rf40w9xO1TFBSjh0FXPu0hKqPe2JyHd65kH9G131jwI3FhQBBCyM4hJ0Ta6e80/z12d
         fhLNiCtFwFINpHkrfbI9nghTiO+tUfM+UnARDMfORgb4jyveWWhsAOcuMIaFmVAk54QK
         /k9KAWqE/sn93EILPowyW2z9Ir91XNmlVpr+XHtFxbpxWP4gWBn6Ik31zh4M8hY1uDwi
         qRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510270; x=1755115070;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+6kUSR5aBTgNcunERrWOcQMCZiG0moZeRQ0turCJ94=;
        b=cfnQLkqLP0Zz0x92wHhJDpNS8lnsfT6lY9mD4zu2JZsIiAaFCu05ggbckQm2q4GmjT
         EKhsMd9w4OYkyLrezsInDFkRziolpWqM0Fux7pduTzc0xhSeXJoDv47ChvG3d3cbPc2O
         Rhtej8cpZ8ipwu0kDY/F7OgetOmPdcgauR98b4dOZvG8PN/KRN2X73ce6bxjmvBDkLoo
         i7SrW5d2bqud/8b+FBYkqinm/eZNIaXrWrIeWu6L8D5jSfxVv177lyTuXCa6YzA3P6jy
         XvjQrjJnF2IOONt5SQoYMTmnLA59XhTHUJhJkBUPtEwEnT7VEFLnk+u5pHH1emUADByL
         OVMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhWZ5K/h1zvnB244LcNIb95NV++74HPn+aZ6psfFHJda7WqTEgLl9Y8vq+4hnWgiTSJ0B4zEx6+pSxjUqDhNSx@vger.kernel.org
X-Gm-Message-State: AOJu0YwhXiebwS5EshNxpvXuuVZZR5JM7fjstwypngT5o7aRmSwjnlot
	B/vxARzGG5VgNTG5MhjnaxISXAbp6ivywvZEMK3MjQ48+YD2wm+sN4cxl3VaPcE7fwM9w2ub+zl
	WWWEl8A==
X-Google-Smtp-Source: AGHT+IF3NS6j+zPTC7HBpb/PhEo054/sULoDCrTNDdSbB3JBoD67HO9NJP/SyaYTvqhMXFbG0IGQUgBSmnM=
X-Received: from pjbeu16.prod.google.com ([2002:a17:90a:f950:b0:31f:28cf:d340])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7d0:b0:312:ea46:3e66
 with SMTP id 98e67ed59e1d1-32166ca3f0bmr5365514a91.21.1754510270478; Wed, 06
 Aug 2025 12:57:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:56:34 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-13-seanjc@google.com>
Subject: [PATCH v5 12/44] perf/x86/intel: Support PERF_PMU_CAP_MEDIATED_VPMU
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, 
	Yongwei Ma <yongwei.ma@intel.com>, Mingwei Zhang <mizhang@google.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Kan Liang <kan.liang@linux.intel.com>

Apply the PERF_PMU_CAP_MEDIATED_VPMU for Intel core PMU. It only indicates
that the perf side of core PMU is ready to support the mediated vPMU.
Besides the capability, the hypervisor, a.k.a. KVM, still needs to check
the PMU version and other PMU features/capabilities to decide whether to
enable support mediated vPMUs.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
[sean: massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/intel/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c2fb729c270e..3d93fcf8b650 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5322,6 +5322,8 @@ static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
 	else
 		pmu->intel_ctrl &= ~(1ULL << GLOBAL_CTRL_EN_PERF_METRICS);
 
+	pmu->pmu.capabilities |= PERF_PMU_CAP_MEDIATED_VPMU;
+
 	intel_pmu_check_event_constraints(pmu->event_constraints,
 					  pmu->cntr_mask64,
 					  pmu->fixed_cntr_mask64,
@@ -6939,6 +6941,9 @@ __init int intel_pmu_init(void)
 			pr_cont(" AnyThread deprecated, ");
 	}
 
+	/* The perf side of core PMU is ready to support the mediated vPMU. */
+	x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_MEDIATED_VPMU;
+
 	/*
 	 * Many features on and after V6 require dynamic constraint,
 	 * e.g., Arch PEBS, ACR.
-- 
2.50.1.565.gc32cd1483b-goog

