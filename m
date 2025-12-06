Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9122DF13B
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Dec 2025 00:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764980301; cv=none; b=aF117Gn56mY15naizRFKcM0TazbcNpfKs1mmlsrn3lm7PX0/SI5fzOOrVGsIpi+onTvAj/RuRHi+aGh7qeixd/yALRl/WZSdNJKBYECYXFtaVsIZHvDhbHnnGmphkUeI9WaVPQ9zbKTkUfxkarU/Z3w2MEEZzFMaRw51uA2sjMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764980301; c=relaxed/simple;
	bh=KX2afOBO5JliLIBcGy7PGHDj+yaeSTNsvwyLPzdSmQM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bGn8xBIw/Ehzwtzj/7lKXZ6Bzc0qP5pzTqDuZy/UxrWCY1N+iyL4J5QhH8jbHUIlhvb0GBlDE2Aupi0pFJ9pY9ENbYzAl4NnH49WRqOPBEL7IXsToC8mz4aky0ZyCgnX1oEUhIrGM4HzFHJX/JKe1yRLX3FvNpFhNZJgHS/w7rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Aibxls9; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Aibxls9"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3418ad76023so4734860a91.0
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Dec 2025 16:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764980298; x=1765585098; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=3dnk2MNp76sLgAxgNfD42hkkfZBnnHFIERQ6eKlhSyM=;
        b=0Aibxls9R4YhFOB28CMCf+STW8cIf+Ju1G3mAyXFx9Nkmhy+mXgEayTR/CdmiT7OsN
         3fMKAmFqAmyzhDImLf4tQPEti8l6NdbhTAyA5wSUgdvSOD9yfgv/74NlOx5fT87/goDL
         /bOTEA91KnKUe6p/qQsyIURKpVATa6yqEJfytCUBA2QmmDOTIYstWMXokygj3z5emT5+
         xhzPP6tsp7pfIXFn0sEqaIv/4bD5BnYQpgmHugccohtIKLMihaC+OD9UCaw6mo67NVzH
         73T3Uc6MKbIlFlgtHClRCP5QakQA52z0LzqG9kRV0X65gReYNSGH4jQlgYydc1SWnQAt
         X3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764980298; x=1765585098;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3dnk2MNp76sLgAxgNfD42hkkfZBnnHFIERQ6eKlhSyM=;
        b=cr3ipbZ9vuHZFu5puHAgIip+SglOvyq1quUCsXNUSq9ZD4laA9ku8UiWni4n2dtfC4
         dFD30vt3n8RaPDUdBxRyLCVbEEfRyZ/p9PrlkDSk5TId/y+pP5SiBD6revBRmLgmjpr3
         DbqmOjWPHxA+mfTp28AD+vkjeq++y7/AzL6kT1ASt5t7RpNfrnGHcKs70+rl0dmHnD0H
         zEqX2i7wwNSBrtheB/+lMvMLNj0NABKc24kzVbuD3Pi7Jc3A8ekeD11/H7pS2G66Ys3S
         tcBjYnwVLdAqrWjCNcnFVK+SHgVmf+8p+P3YIOuRWz7Y5tKasMqiMzo1ED5F+Ddn9BeL
         NQrA==
X-Forwarded-Encrypted: i=1; AJvYcCXBXXpDtcYmZhGMhxbpAxQX7phszSD0DhVl+gh6Takp/gc1YDPOTyaL2OpI/3qMUSnyTPs89upfJoZ/20KYFJ/Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwmrceyDm/YW7V8TJqlUTG1mQRHfwYwYMpLK7Ihmx+7DDlJ8O8/
	baBWMVf2fxQLKH0WIN+ZGb03VxUnrwgKNASLnq1Cr4JqZjIsC0KXVtJyJtqDTzglIF8tfUX56DK
	AHQW/tA==
X-Google-Smtp-Source: AGHT+IFWJxm66Taju4sAXeG8Zi046j5cUgR9dVl+uDTUXVS82TWmhcnKPkrnyr1pnneTXazQsF/t/WHWvfY=
X-Received: from pjll2.prod.google.com ([2002:a17:90a:702:b0:349:3867:ccc1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c4a:b0:339:d03e:2a11
 with SMTP id 98e67ed59e1d1-349a2511dfemr604485a91.14.1764980298595; Fri, 05
 Dec 2025 16:18:18 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  5 Dec 2025 16:17:02 -0800
In-Reply-To: <20251206001720.468579-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251206001720.468579-1-seanjc@google.com>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251206001720.468579-27-seanjc@google.com>
Subject: [PATCH v6 26/44] KVM: x86/pmu: Always stuff GuestOnly=1,HostOnly=0
 for mediated PMCs on AMD
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

From: Sandipan Das <sandipan.das@amd.com>

On AMD platforms, there is no way to restore PerfCntrGlobalCtl at
VM-Entry or clear it at VM-Exit. Since the register states will be
restored before entering and saved after exiting guest context, the
counters can keep ticking and even overflow leading to chaos while
still in host context.

To avoid this, intecept event selectors, which is already done by mediated
PMU. In addition, always set the GuestOnly bit and clear the HostOnly bit
for PMU selectors on AMD. Doing so allows the counters run only in guest
context even if their enable bits are still set after VM exit and before
host/guest PMU context switch.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
[sean: massage shortlog]
Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/pmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index c1ec1962314e..6d5f791126b1 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -166,7 +166,8 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		data &= ~pmu->reserved_bits;
 		if (data != pmc->eventsel) {
 			pmc->eventsel = data;
-			pmc->eventsel_hw = data;
+			pmc->eventsel_hw = (data & ~AMD64_EVENTSEL_HOSTONLY) |
+					   AMD64_EVENTSEL_GUESTONLY;
 			kvm_pmu_request_counter_reprogram(pmc);
 		}
 		return 0;
-- 
2.52.0.223.gf5cc29aaa4-goog

