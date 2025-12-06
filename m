Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9682526CE2C
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Dec 2025 00:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764980272; cv=none; b=MQrz1zzIzgYI7/99Jus6QSrb7l/DYCTjo9aewFSHD1WP84GHMEJ/0/wfUAMl8GtzRBdqkSyY9ChcbvqaCYpFk1E2PpeYTY0SIlqi/6HSFisoUoiBIBW1LOhEbYtRTItA37DdGbJWFt9SxTDis3Q9sX5j0h8kFsl26fCm5cSOvhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764980272; c=relaxed/simple;
	bh=1cCrG4DCg3nVbAW9oH4QXbYa70u3YhFDXh9Xhmff200=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jpq5q/jS4Oz1zK7/u873qssmL2FPw2kMNMh/JE3gcWP+9pWJFPl0jjwOxjCi4SyVmUfnCL3uDo4gco/Ehon5ZacV96uZJfiLRY8dZEZ4yYAczo6dDWTv04LLtKjniqvGxxzvBG7/HTK9j1y4HIFXqdzdLqeWCwTsSkyuCGBFI0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B8/Ao4CL; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B8/Ao4CL"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7ba9c366057so6696397b3a.1
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Dec 2025 16:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764980269; x=1765585069; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=OFskCraMCAt1o1jXv8Q2cmHJ2OyK2yl9CAVs1/Lc01w=;
        b=B8/Ao4CLt3v5ehswAKCi138a1UFTPaFDajyIeBCnDnRvrwbScEDrmkI3ak6+RJV8Lh
         80CnXuTlh4+5ZYJAaOzdImSgsWqRLStxnCXMmS9A4xyxCOHWv1OS7jGT88ma0iBdA2Qd
         8JHjKoEHDcVBhrkaiudwxY9pDLovmxCqLonDllOzEpmV8rL398ugIlcWfR0eI2CFgPrg
         mb8PI+1OB7DUAGtGHkCNDEVq9ShAcRgsptAk9IRKpIaq5dIEobHgHCX4Sr9/gYJe+6Bl
         EMf6R2NWAQ1BVrHZYD+91KuUrqSH8l+IFLgy28p+uQusD6FZGMs3MA1WWwQVVUw0CLdT
         rO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764980269; x=1765585069;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OFskCraMCAt1o1jXv8Q2cmHJ2OyK2yl9CAVs1/Lc01w=;
        b=ZGrBMcE3n1DcvEkXHWuHr3iojsWHZ1oTkLMHj+TcGXFpTeXo3DRx6UxGdjByovY4nW
         H8EbQe37CkW/C57/JW61brsVijXlZYjAozb4alvFeTI/jRmonQI4DXG4w58J3R8J8/bt
         q/zETr+jw8VGh4/OUjHr+rm662Nxqux04RwxrMcQmsQLdlIz2BTnLhnJ0u/i1idp0N21
         nxj3KWn21lrGG/V/VZstkTipR063UF8sWDGgAVXIU/z5k9HUfMZEFEj5x1c9opExAExY
         aGTx6jBBMI5YMbd20oJaPQsF2JD2oTf4xoRgcrWuaiEdskNrNFoJWflGe3NDia0suFA2
         rZyw==
X-Forwarded-Encrypted: i=1; AJvYcCUkIpn8XgitXxnrytupuRsYjBgMbl0N3foOrcFFllZSpYrBw0+dx3wpjaIeOPq8o6esbNIPaHne2jy4cXvSNMH5@vger.kernel.org
X-Gm-Message-State: AOJu0YyoRU/MX3u2WaKBFMMniblbOS9IWmobyaLdfKqrotb9jagv0PmE
	OOvxpWsqFX0soIGJp4Jcbw15t6Ki8AMSJafADJROzsu8aJ8pvvIa8d/atpTNEWz2dDUXIA+72ez
	dijUwig==
X-Google-Smtp-Source: AGHT+IFfI+s5eY5Nrz61icCfCwYv8IGUZBRQf6oh7KDogWUJprIuAF6nUR9g3xDsrE/LDxUvXG6Y79XK/ls=
X-Received: from pfuf34.prod.google.com ([2002:a05:6a00:b22:b0:781:26f4:7855])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:234c:b0:7e8:450c:6195
 with SMTP id d2e1a72fcca58-7e8c6dac143mr767576b3a.44.1764980268965; Fri, 05
 Dec 2025 16:17:48 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  5 Dec 2025 16:16:47 -0800
In-Reply-To: <20251206001720.468579-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251206001720.468579-1-seanjc@google.com>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251206001720.468579-12-seanjc@google.com>
Subject: [PATCH v6 11/44] perf/x86/core: Plumb mediated PMU capability from
 x86_pmu to x86_pmu_cap
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Xudong Hao <xudong.hao@intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Manali Shukla <manali.shukla@amd.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Mingwei Zhang <mizhang@google.com>

Plumb mediated PMU capability to x86_pmu_cap in order to let any kernel
entity such as KVM know that host PMU support mediated PMU mode and has
the implementation.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/core.c            | 1 +
 arch/x86/include/asm/perf_event.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index bd9abe298469..1b50f0117876 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -3137,6 +3137,7 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
 	cap->events_mask	= (unsigned int)x86_pmu.events_maskl;
 	cap->events_mask_len	= x86_pmu.events_mask_len;
 	cap->pebs_ept		= x86_pmu.pebs_ept;
+	cap->mediated		= !!(pmu.capabilities & PERF_PMU_CAP_MEDIATED_VPMU);
 }
 EXPORT_SYMBOL_GPL(perf_get_x86_pmu_capability);
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 4cd38b9da0ba..4714bdee17b2 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -296,6 +296,7 @@ struct x86_pmu_capability {
 	unsigned int	events_mask;
 	int		events_mask_len;
 	unsigned int	pebs_ept	:1;
+	unsigned int	mediated	:1;
 };
 
 /*
-- 
2.52.0.223.gf5cc29aaa4-goog

