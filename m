Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1731C3314
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Dec 2025 00:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764980253; cv=none; b=dwtfeSmYPvlMRQD2tR+rJrTQ24J0kqO6LHbbhuk5Lw9gj1zKPrd+ZdhmMEPRvwWxDivQAE2zUC+xwbRw3hojxUMLzkkfSjD09RRjHd2A2Yt9sAuYXBiEBLo6KYtGhFSw97SCzB6umiN2TX+p5DX6iSavB1kXLUvEz7LZsNve3n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764980253; c=relaxed/simple;
	bh=53ZMr2ZRIpu7IbiEdlebeII/cbBReqilV+Dt6eLN4/M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XWOckPjRoDsVe91vJQAjb5KW0EWVRPeMM0l9mr8kyjsISTzezTLQ2MK2ZlkReJJ+uPqX6vgDbhY9z0Hy3/MFD+wymbJkuDEguaoFkg2523rd49gjIM5lD9+FZzsXhidvyHMSeMGvvGGgYwHf02plqJRs26Zf/ZSKWAxQZmkkVKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O+XPlgCr; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O+XPlgCr"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34566e62f16so3089642a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Dec 2025 16:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764980251; x=1765585051; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=UxEE6YFCrywRRLGygEARIDA06aPKgmiMBn7nXQjzdiI=;
        b=O+XPlgCrt31UvHqt1Yhm5OIlmo5qQ3OxvcB9NX19SC6EUoqFrv6xPgLXOeRENDgKmt
         BmHD0E8fhS6vD42fOvVRVYL1OPaN5NQrbWsJUxDRWnz6BmkmZMpBoZ3g10hSAc5oPXNy
         qd7C/FQ+3HAjuxRc+upNC4iGHXZCU8Gkl0xRfPeXMisrHOgTnVCuQNLmNiMiZZnMp8UM
         elVL6c5/ggQlrK0cs5Mxzn4lYsQs3kkkmC3g6Gq4ofFj2q2MbmAwC8lToD9oYE30us71
         X10Z0WSlSFR98SvxVzo90De/OPOXkN+qNmJbdQLwW+ipL/0w0ISnxPckE0X692l1n8r4
         dB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764980251; x=1765585051;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UxEE6YFCrywRRLGygEARIDA06aPKgmiMBn7nXQjzdiI=;
        b=mPg92aA0zLkVgjM0tp1qzEhrOQEbaiwGSJwjvwS9dCzqI3Lq9i/GKjpmDgRpQ2g9D5
         4sdzt5c0ty52UBcjCsOUIjIqe2vp2Zi1w2Gb3UNEQExgKE0wr+YowcQr9QgeJsvvQnge
         R2CyiQlCErGsVCKlRONvaHKjxyN+E0uuRw9a87CJ2Vh/bw0ykSZPGtGHwx7fFG9B17UP
         iCoH6w/PmoAxkXLB6RWD3em3egY80QqcGFE5gbr03FwDsfoIXWIgItX5f6S9i0v+sXZh
         mGFYiDMnZAYjEqLwRgP811SIKFOSP0G0I7yi0zP+2Ir3Lj3/bea/Ky+6uIVFCkC98A10
         m80w==
X-Forwarded-Encrypted: i=1; AJvYcCUUbUEzScKA21D281vHaANXDGfqQhOWW7XM8/LGe9+pu/hpHPbPVDD3zkK519lf9M5kzFx+yfGq2ItlV5dEzkgk@vger.kernel.org
X-Gm-Message-State: AOJu0YyzEXU0hxVpkt/LL63isQC5hU+WDKHLQ+QF1rsrPcc5c6B22NkA
	iKXmw/0XdvyqQap6gapGfLVZ15+J413XhvzQM7JReeP42hOOlKu3yJLOvwSSydriUNZvUpmNHBM
	SOUoxhw==
X-Google-Smtp-Source: AGHT+IHjg9edpOr3D1FDjetV+9fqRbGzj3yZXk9Coy0VtACLss4vYlJyIABW7Xcv++xOTx44sX1NPQCjnv8=
X-Received: from pjbkr8.prod.google.com ([2002:a17:90b:4908:b0:343:387b:f2fa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:38d0:b0:349:8116:a2e1
 with SMTP id 98e67ed59e1d1-349a25fe29fmr699857a91.20.1764980251086; Fri, 05
 Dec 2025 16:17:31 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  5 Dec 2025 16:16:38 -0800
In-Reply-To: <20251206001720.468579-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251206001720.468579-1-seanjc@google.com>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251206001720.468579-3-seanjc@google.com>
Subject: [PATCH v6 02/44] perf: Add generic exclude_guest support
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

From: Kan Liang <kan.liang@linux.intel.com>

Only KVM knows the exact time when a guest is entering/exiting. Expose
two interfaces to KVM to switch the ownership of the PMU resources.

All the pinned events must be scheduled in first. Extend the
perf_event_sched_in() helper to support extra flag, e.g., EVENT_GUEST.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 kernel/events/core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4cc95dd15620..1e37ab90b815 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2872,14 +2872,15 @@ static void task_ctx_sched_out(struct perf_event_context *ctx,
 
 static void perf_event_sched_in(struct perf_cpu_context *cpuctx,
 				struct perf_event_context *ctx,
-				struct pmu *pmu)
+				struct pmu *pmu,
+				enum event_type_t event_type)
 {
-	ctx_sched_in(&cpuctx->ctx, pmu, EVENT_PINNED);
+	ctx_sched_in(&cpuctx->ctx, pmu, EVENT_PINNED | event_type);
 	if (ctx)
-		 ctx_sched_in(ctx, pmu, EVENT_PINNED);
-	ctx_sched_in(&cpuctx->ctx, pmu, EVENT_FLEXIBLE);
+		ctx_sched_in(ctx, pmu, EVENT_PINNED | event_type);
+	ctx_sched_in(&cpuctx->ctx, pmu, EVENT_FLEXIBLE | event_type);
 	if (ctx)
-		 ctx_sched_in(ctx, pmu, EVENT_FLEXIBLE);
+		ctx_sched_in(ctx, pmu, EVENT_FLEXIBLE | event_type);
 }
 
 /*
@@ -2935,7 +2936,7 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 	else if (event_type & EVENT_PINNED)
 		ctx_sched_out(&cpuctx->ctx, pmu, EVENT_FLEXIBLE);
 
-	perf_event_sched_in(cpuctx, task_ctx, pmu);
+	perf_event_sched_in(cpuctx, task_ctx, pmu, 0);
 
 	for_each_epc(epc, &cpuctx->ctx, pmu, 0)
 		perf_pmu_enable(epc->pmu);
@@ -4153,7 +4154,7 @@ static void perf_event_context_sched_in(struct task_struct *task)
 		ctx_sched_out(&cpuctx->ctx, NULL, EVENT_FLEXIBLE);
 	}
 
-	perf_event_sched_in(cpuctx, ctx, NULL);
+	perf_event_sched_in(cpuctx, ctx, NULL, 0);
 
 	perf_ctx_sched_task_cb(cpuctx->task_ctx, task, true);
 
-- 
2.52.0.223.gf5cc29aaa4-goog

