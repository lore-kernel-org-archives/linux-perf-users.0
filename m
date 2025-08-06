Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0E12BE64F
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Aug 2025 19:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510258; cv=none; b=BTBZHlssHnz7hJhIeyJJSahdrgQ516WUb5ngieOZZ3XUbg/RdjW9PR4jBhjj8YNfxQaMxsVjZFKHL6/tot1m1M0jMm7X+UpMNOmDvmzqJ+/3TMe/92d3vzGGEPACpkev3TEbqff8K8BlkL7G9nY8WLMO+Vu33Fc/6wSisFCO2eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510258; c=relaxed/simple;
	bh=jUBl1OA0dbcCe9Exxx/O066eDYx/qkeyxg/XjKFA/3U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bm6cyZwp747He5OUuqAhX9Fy3hw6U9u2HU3lw9MaLNJk02AqmM/8rA9xjTQHlpDjU5SyhJLtLP3QcbiuWwxGPQsL4i3u8EAd3UMnvkkQNfR5/JtQRKW1VRQODKTQGx3JLgX/gtGBqxBEyHQ/+SqxJqpTaCfMQL8zw9Xa4Ug1Pp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=krqFVzHx; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="krqFVzHx"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76bef13c254so290737b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Aug 2025 12:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510252; x=1755115052; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=3IAofGMjgJOHx6SdMcFjG4jFgSxJevKv5cJ/ErNkHsk=;
        b=krqFVzHx48sFUhkTmv5ZdxVvJJbo9yybHXbJml4FKAfQUxzOY4jH1x4IujuldA6FMr
         C0+zX0xKrvTclXv7jhBwPGfFMBwKz14JTJaEdBZ+70bCTbFbTQ5Xcu0limwYhQffnRT1
         FCaCbpNmWYehwuLFuoJuSmpfOfKEHjXyqoWRlcCcYUhWpxWox9SHW9jhq5ivmdwOnlOi
         M8VHe2C3cxVOVnnB16o4ieO9NP8RP8SSHnDvNPO8i3ftSat6W9nnq7VOVBrTtE1bSHEA
         GW1sz/GYRCc8mL0hoHmzkx1cVT3yt0t/1gWrYDYckq2x7Gw1de223JzLbu7xVcmqkXsS
         Ng6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510252; x=1755115052;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3IAofGMjgJOHx6SdMcFjG4jFgSxJevKv5cJ/ErNkHsk=;
        b=nhCErLGcMSK2U59ctj63Y6HO87+ESF6MWxTcgvtTh5RqKwpUOR0HEqOoLgk5CySUtu
         zD1ySqw1FpovAXcigWVIAXM5wopbAqJaXHjsy9KAhmKSYx4xTJuIUY9tfF6UzDwFPtyX
         tLvn1SJTsAqMPc397DLMeOm+Oa1V+meXIlweWlBbbehfCOqxdncdVpQWGzC4vnZkKkRa
         Jc403XVBtaK54scjuOdSBLB7TEdHg/+XCb61jxn44xDeVdW0kP/kUm/sHGHTpH8xJabc
         6LMhsZzlTVbdXjeKI7ZJDf86pCl9t7KxKzKrxBoGHQ7LbwtaGRW0D6sDy2928MeM8Mhx
         t5uw==
X-Forwarded-Encrypted: i=1; AJvYcCUxQLYVvdixRMXkJ4tffFrtSODgtOzsrdRA8at0jS+7k1HFa4xqHgxwiXGHN3PqvAZgdyViNRvsgns78vfiCJbY@vger.kernel.org
X-Gm-Message-State: AOJu0YzM4rCbLY5gxf9EuucK/6a5rceFTf+89nIhGwYCDFhNo3ht89Cx
	cn1sUxpzdnU6K3ah9jbvHDvZA1CI43Alj8gvqyA6lliIltJYet2Z8hAdLCql6npkhmmM94KHXqN
	Nz4t7RQ==
X-Google-Smtp-Source: AGHT+IGg8m1AYQ1T/bkneerdDiI2IWHPXHDhUcioTumR7faJkpYOSLNXQVSuuMxt1I5dkPrSi8WAHfNQ8i8=
X-Received: from pgc3.prod.google.com ([2002:a05:6a02:2f83:b0:b42:2da2:8848])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a103:b0:23f:f712:4103
 with SMTP id adf61e73a8af0-24041364f38mr1167741637.18.1754510252085; Wed, 06
 Aug 2025 12:57:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:56:24 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-3-seanjc@google.com>
Subject: [PATCH v5 02/44] perf: Add generic exclude_guest support
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

Only KVM knows the exact time when a guest is entering/exiting. Expose
two interfaces to KVM to switch the ownership of the PMU resources.

All the pinned events must be scheduled in first. Extend the
perf_event_sched_in() helper to support extra flag, e.g., EVENT_GUEST.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 kernel/events/core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index d4528554528d..3a98e11d8efc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2866,14 +2866,15 @@ static void task_ctx_sched_out(struct perf_event_context *ctx,
 
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
@@ -2929,7 +2930,7 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 	else if (event_type & EVENT_PINNED)
 		ctx_sched_out(&cpuctx->ctx, pmu, EVENT_FLEXIBLE);
 
-	perf_event_sched_in(cpuctx, task_ctx, pmu);
+	perf_event_sched_in(cpuctx, task_ctx, pmu, 0);
 
 	for_each_epc(epc, &cpuctx->ctx, pmu, 0)
 		perf_pmu_enable(epc->pmu);
@@ -4147,7 +4148,7 @@ static void perf_event_context_sched_in(struct task_struct *task)
 		ctx_sched_out(&cpuctx->ctx, NULL, EVENT_FLEXIBLE);
 	}
 
-	perf_event_sched_in(cpuctx, ctx, NULL);
+	perf_event_sched_in(cpuctx, ctx, NULL, 0);
 
 	perf_ctx_sched_task_cb(cpuctx->task_ctx, task, true);
 
-- 
2.50.1.565.gc32cd1483b-goog

