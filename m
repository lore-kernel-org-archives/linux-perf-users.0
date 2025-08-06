Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBE32D12E1
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Aug 2025 19:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510270; cv=none; b=isDLzfpFOm2WN8tq1m6p5n3ho9OMD+Ma0B52bI5W6ZpfHvpwWnA6E9q8Q9NgwEsn3M8+Vn+Su8amBNENabGXqJYRy+Rx6qxDnDJW46Ax3Ov+7TgedCsaBHh4ZMGLJFSH2LPEKbTcKx55clQioG7hsTkcTlZz45BMKNzK63HMiiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510270; c=relaxed/simple;
	bh=5aUcvaWHp6TRUDOiSNC6KCm1Cyy80ztm2LX/UEyRYFs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ggSkvtLtHyDNIa8RMtQIbax2/Ga8a/TaZ0sfKaSMl8mj8gxB7mpSN6Upx2E2m56ZBvFBuOK8rWsD8KeoHRdtVs1dD1cxfAjNywwjd08cJkOjwsklRh9AkvNiwfoDYvXbGV5+lKgfaK7A83rRqHcuFByWjqUbFHtzhLcTMH90MlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eMTwdtGF; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eMTwdtGF"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32129c65bf8so278288a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Aug 2025 12:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510267; x=1755115067; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=V6GitVs58LgSs5T9j7jt8hclUfm0doY6DCHFmJ55L1k=;
        b=eMTwdtGFjbvVQoXhRX/iyjkk815eoFubGn5kVNq0OdKfwh8Krtaq8ybEe0Gxzu/O+y
         KIsvZKJt1zp1pLtuiSr0kP2cgPKDL+AUZ54lUBwztyui30nPWwS4LZKjT/nZdA8WwAhk
         VNzALLYK3IDoIunP6Qmc1d2mum6nH4+Jironf1gTMd5ex9ENVAVGks/Jt0DRzUjggpnb
         ny78NS0xfSgVp5cx0nd42nL+Uv4G3FMou6JzaJ8z+17elLLZNEV440l51x0TXcAfVjo0
         zCtJyGPx/sIeN9oxibqxA6FfQjCMYe0q+DT6F0Ry643QWB+ORqn4rYBFWj91C/TSS2LA
         UVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510267; x=1755115067;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V6GitVs58LgSs5T9j7jt8hclUfm0doY6DCHFmJ55L1k=;
        b=MorSjOYWjPAGdXP6Dh2MVS1Py0wY0ekxGU3EmKTz8UYaoHp4lSLNm/CWlI8hUDaTjG
         eIhpNMdz3Inzc9Dn4yahU9V50o5b4oRXKMYUsvDjswcNIaYFs77VUihVOnTihJqwBlqq
         Sx901et3mYysMn9ZTdl6Xg41V/1T1cBXBViwVievW0n6nNOLcTyBPi5kylVgPhxgJqu1
         3bZtXJs5/aNGH+oVQN6HWhKHadOELVkmQIsGb8SaT790hp+csswrEL3SHXXmoI+lvuO+
         XrHJybRBX60V0l8rGypNR1GCMqo7/YxVWlIcLWAJwur9GKcvWjEk9xlCNOI9yqfOPDZr
         hxJA==
X-Forwarded-Encrypted: i=1; AJvYcCXmFacXJwx0gePSqKSiLkTySuthANCN+sfwJXqcP6ywBeMEKmfVhmrERmMQ4lX0Gs9dFo3Sq2t1KwTWqcUG8wLu@vger.kernel.org
X-Gm-Message-State: AOJu0YzOaPpyjFtODCUtcxNfYMQVD2mYQnsEMNTvgkXSt87Fy7EwEO6r
	9hRlIXTFPxy+9Og1AsJgIu8zsluiO/I/FDSPlidfnwUQp8F04P5sVTirHeltkRdMA+9pW5CSVx8
	3sK4HmA==
X-Google-Smtp-Source: AGHT+IEe9aouosNHmFsjzcywZl+bDxrMa7gzbIrywT1O9OJ/U5YazLpsqSIEAJkZctqsm307cXJuaDMPuPY=
X-Received: from pjbee13.prod.google.com ([2002:a17:90a:fc4d:b0:311:462d:cb60])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2743:b0:311:fde5:c4be
 with SMTP id 98e67ed59e1d1-32166d06ed8mr5169966a91.35.1754510266366; Wed, 06
 Aug 2025 12:57:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:56:32 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-11-seanjc@google.com>
Subject: [PATCH v5 10/44] perf/x86/core: Do not set bit width for unavailable counters
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

From: Sandipan Das <sandipan.das@amd.com>

Not all x86 processors have fixed counters. It may also be the case that
a processor has only fixed counters and no general-purpose counters. Set
the bit widths corresponding to each counter type only if such counters
are available.

Fixes: b3d9468a8bd2 ("perf, x86: Expose perf capability to other modules")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 9b0525b252f1..b8583a6962f1 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -3125,8 +3125,8 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
 	cap->version		= x86_pmu.version;
 	cap->num_counters_gp	= x86_pmu_num_counters(NULL);
 	cap->num_counters_fixed	= x86_pmu_num_counters_fixed(NULL);
-	cap->bit_width_gp	= x86_pmu.cntval_bits;
-	cap->bit_width_fixed	= x86_pmu.cntval_bits;
+	cap->bit_width_gp	= cap->num_counters_gp ? x86_pmu.cntval_bits : 0;
+	cap->bit_width_fixed	= cap->num_counters_fixed ? x86_pmu.cntval_bits : 0;
 	cap->events_mask	= (unsigned int)x86_pmu.events_maskl;
 	cap->events_mask_len	= x86_pmu.events_mask_len;
 	cap->pebs_ept		= x86_pmu.pebs_ept;
-- 
2.50.1.565.gc32cd1483b-goog

