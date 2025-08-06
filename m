Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50AD2D1F61
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Aug 2025 19:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510275; cv=none; b=Q/11+3MV4Ss3QyCbAb2PUNmYgDk6Fz988+nvXoUW3cTWKin73GyX2/vu8ND3Y6CGJbDh450PzQzs0hZA8cYS9/ADmEVSkBp602vG8/5IQeCwDsC/hZoQu0/rAgdNrMMjqZw8oZn+ZcCU+LTb/ObF5HLKBuxr3fNGXIqGWlPyofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510275; c=relaxed/simple;
	bh=dsL7u0gCksSjkMYlnKFIZN+mhAdNQOloX5K9ddADbjw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DgK2nCyUpYu4ALAynMq5suypglfWrfMM1I0czYvJlPzfGCty2mEV6mSxjYbxQhLkTS6On/fTfnjygdln2a4ougiAn4Q4iVhODS83vqQLaFgJj4zoeqRPi+IOHaXfA0MOJ6OM4wVVQ83HPjTYsYjvEt2dg4CUAVUes3ZFFAT2bYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3mUGGDZ+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3mUGGDZ+"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-315af08594fso334377a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Aug 2025 12:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510269; x=1755115069; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=zcpMdowVJLAIFzpWUVXDuq4S/gKqPMBYO1OzyYmcx64=;
        b=3mUGGDZ+zv7uU59L8Ffhd//Jtbx25i3JD1bz2eGo6Z3VsU1hrc52wMguL5eBGBpd07
         kvDkTu/02am6NGibACJdrCbahTNW0RfmdXOCjn1dkuKsTyTz1JZZ7FXCq+jsI53zSKEd
         xmRm5+ZTX9+Y/FVsOZaiz/UVmhqPc7kemgrGx2gmWvzAgMWJqU+F2/iKGz1j8nzUk21M
         Xa7p7wdmHoynPZahfgtmt0iTe+C7gbcarlY6Py1Y6m2OkkjAldVnkNYOIDhGBbJLmOZ6
         lLYNcB1o6KuUNE4Acbs12URw9MLQiP3diNrz1QbIo0PtMR7sdVyeNA8CCUFWExuDBACP
         rDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510269; x=1755115069;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zcpMdowVJLAIFzpWUVXDuq4S/gKqPMBYO1OzyYmcx64=;
        b=ms8yp51RUXPscFZX9hijwrgufSpUdiTf658a1PjRcv5AOOZg0L3noXX7BfTzV5NlLX
         RSWjNXPoJblDxBcSchC6r0L3KYSNWSFSkYGltbwYXP4IlBkYtaQ8iPiOqJP9zKxnRNv7
         0DHeTmh+ClvnJYegjEGeynradaGIuREDZE9GqVT5qzR4gX7956cRAJchIWXRoP/gdTiC
         0KDnJjXXpNlMtLaXDMvqRwDK2Iy+E93wg3SIBOtepOdCjdoejagxTUSSYppn+yrDilXo
         3ye9n8mMioHHEu8I/Bdp8TwZ4zuvqMLD2CF6Rcd42PNorBZYgfXCtonxAF5QIoZ0HAkB
         rm1w==
X-Forwarded-Encrypted: i=1; AJvYcCWhLIklLcCon2Wu2emunkrhtwAOihna+cSrg6XSu1qzxpBXI+lioeeg22GkKm3AjLpBLSS1dSUlkuoLXSAzXC5T@vger.kernel.org
X-Gm-Message-State: AOJu0YyHxhhXwr8ugk5b6OOoRxhf10Xz395iBy2ST2CoFgK+FSCnIplR
	I+tJbwPXBawXUeOnXA1rm6yI8oAbRv/87wXIJcn+Mgxr8fcVvx/d0oi3xKbf/P4/qdOZS9Dyise
	gzhyRrA==
X-Google-Smtp-Source: AGHT+IEVLR7eG3e1/ODg1GEbzlPUzUDlLQzQgQfsonV4iFGNfX+Tq8xQvuZk8V1U7zslQQy51nOqc0FuQr8=
X-Received: from pjtd2.prod.google.com ([2002:a17:90b:42:b0:321:76a2:947c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:380a:b0:31f:36da:3f85
 with SMTP id 98e67ed59e1d1-32167520ee1mr6465429a91.17.1754510268743; Wed, 06
 Aug 2025 12:57:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:56:33 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-12-seanjc@google.com>
Subject: [PATCH v5 11/44] perf/x86/core: Plumb mediated PMU capability from
 x86_pmu to x86_pmu_cap
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

From: Mingwei Zhang <mizhang@google.com>

Plumb mediated PMU capability to x86_pmu_cap in order to let any kernel
entity such as KVM know that host PMU support mediated PMU mode and has
the implementation.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/core.c            | 1 +
 arch/x86/include/asm/perf_event.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index b8583a6962f1..d58aa316b65a 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -3130,6 +3130,7 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
 	cap->events_mask	= (unsigned int)x86_pmu.events_maskl;
 	cap->events_mask_len	= x86_pmu.events_mask_len;
 	cap->pebs_ept		= x86_pmu.pebs_ept;
+	cap->mediated		= !!(pmu.capabilities & PERF_PMU_CAP_MEDIATED_VPMU);
 }
 EXPORT_SYMBOL_GPL(perf_get_x86_pmu_capability);
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 70d1d94aca7e..74db361a53d3 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -292,6 +292,7 @@ struct x86_pmu_capability {
 	unsigned int	events_mask;
 	int		events_mask_len;
 	unsigned int	pebs_ept	:1;
+	unsigned int	mediated	:1;
 };
 
 /*
-- 
2.50.1.565.gc32cd1483b-goog

