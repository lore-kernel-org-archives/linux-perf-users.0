Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA33257AEC
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Dec 2025 00:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764980296; cv=none; b=XEjmgN/8z/WBpTJm6UjhlVeRa8q6Hnq/dIx6x0cxMKbTWKTcOAoyNY0VcUX3SBtOI7T++pUTRZDqVQoaGD1uljpexmO+bgn+yAjRPMw3bLExdJQ7cVwnGtLTxeXGyehZ0QrVQavT62wGNlPpi3Wg/IB/KoSZVrlUqhFqVLYUnyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764980296; c=relaxed/simple;
	bh=O/jVTq5Qhwa5T0yytQs5FBna5XRpIRNeziQvPpiH8po=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ccn7GhVKi/ZJa3GmSbs6wkBF4nVvouXo34BEf1Yie4+Riy3/ut2hQ8OC1UujZsc+3NxTmYyPqdNZXqvQOl6BDFaEunE+gtRXjHJgtANNWMMQQ6W7xs61QucMQrZ7ZnqldZDmjmuQ4QiKCpu/wR/5KqiWelVAoAeiXHLTsmwlPa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FpxehNyk; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FpxehNyk"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7b9090d9f2eso4938017b3a.0
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Dec 2025 16:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764980293; x=1765585093; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=XDWqFeiOQLKkxB3EbvG31YUh6Q8If2ANhLHUmz0BNv4=;
        b=FpxehNykeSeTIGWdL861D/TzeZmcl1U/r5ojW5iOLnUEZM5HqBLDYEueYpe0BnQsn6
         P6q5gRuQUk839fGFI8EyMS9Fzt2iQnT2BwZzfyCz2iZ2hxCQ5hPigNSzKJgtGE138XsD
         ZJtSW36/vAOR6lFflOB7H+nXgOLj7xw9USQGIpmX5iySBaHUTt0Y9lbagEXcsXYuAMVN
         6vvuYej8HfqRq7xui33CzwIzoDMoD4lfSnjIgANZ4m0XUnl7pTMzQ90/QU2Mn0itBQD5
         rrCTprnDWlHgvcaphRZH7y4Ewt2D+HIV22tMJMoI01bYds/7HYK1jclhjCx1Ce6xncqz
         byyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764980293; x=1765585093;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XDWqFeiOQLKkxB3EbvG31YUh6Q8If2ANhLHUmz0BNv4=;
        b=KjcMLkHbozjt6WtYeJ/WbYh35WB7TsZhSLWvqADgtL6Qa+5Y1ySe2J3MRxRp8Op5s6
         BfyhV9ZiwZ4Jnxn0ajGlWCSBA5EO+RJs3WSnzWPCjLmDgJAmn0Ql4UkhMVNDqRKiWvsf
         nB1FxR/MXLsWv3dH6Pr+qArCfNfEu7NYFzDV3JBQYxEQGsS83oUpVhHfeg6llXCmhA0X
         vuM/V9SGB+/PjhIGCPr3Yb82MLTe9uhvip9Mmh6+KhCUOe/jvpQkVXAQtw3AGTB3Jm9s
         zZOoLxXFq7sBQxL+h7en7ytRSt9YcpeeuhRvGjByU5Pw0jfPSPKoqDaAoLFhp9X4Meu2
         Crqw==
X-Forwarded-Encrypted: i=1; AJvYcCUyksCsg13DP9lqvRh1mKLJn7fjyqFjwC87wQyKW+6VPuRl4MOlTE3ebthSqKOxHpKxGCkZSTpS+vjMKC1rn+bZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwpgORsuopwP+SknCWcKLA8vIX3fLA7F4VcLyix6s9xzoFgDDy8
	5rPc7UqBL+RaGtyk/mR44+l8qCMm8hp/iD9ZcFpOJQjLJ0qkLRzinDFpZ7avENrBjLXgNhWHRxr
	gadLumQ==
X-Google-Smtp-Source: AGHT+IEUzuqWf57QLYzTtVTMaTDzv0I3kjHOLmfOTP6Jt6doQKesYDsCDJnJjl04ZJwHyBMoU/64HyX4VwM=
X-Received: from pgar12.prod.google.com ([2002:a05:6a02:2e8c:b0:b63:2a80:d077])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7f81:b0:334:912f:acea
 with SMTP id adf61e73a8af0-366180175c0mr936268637.59.1764980292181; Fri, 05
 Dec 2025 16:18:12 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  5 Dec 2025 16:16:59 -0800
In-Reply-To: <20251206001720.468579-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251206001720.468579-1-seanjc@google.com>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251206001720.468579-24-seanjc@google.com>
Subject: [PATCH v6 23/44] KVM: x86/pmu: Bypass perf checks when emulating
 mediated PMU counter accesses
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

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

When emulating a PMC counter read or write for a mediated PMU, bypass the
perf checks and emulated_counter logic as the counters aren't proxied
through perf, i.e. pmc->counter always holds the guest's up-to-date value,
and thus there's no need to defer emulated overflow checks.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Co-developed-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
[sean: split from event filtering change, write shortlog+changelog]
Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c | 5 +++++
 arch/x86/kvm/pmu.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 57833f29a746..621722e8cc7e 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -381,6 +381,11 @@ static void pmc_update_sample_period(struct kvm_pmc *pmc)
 
 void pmc_write_counter(struct kvm_pmc *pmc, u64 val)
 {
+	if (kvm_vcpu_has_mediated_pmu(pmc->vcpu)) {
+		pmc->counter = val & pmc_bitmask(pmc);
+		return;
+	}
+
 	/*
 	 * Drop any unconsumed accumulated counts, the WRMSR is a write, not a
 	 * read-modify-write.  Adjust the counter value so that its value is
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 356b08e92bc9..9a199109d672 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -111,6 +111,9 @@ static inline u64 pmc_read_counter(struct kvm_pmc *pmc)
 {
 	u64 counter, enabled, running;
 
+	if (kvm_vcpu_has_mediated_pmu(pmc->vcpu))
+		return pmc->counter & pmc_bitmask(pmc);
+
 	counter = pmc->counter + pmc->emulated_counter;
 
 	if (pmc->perf_event && !pmc->is_paused)
-- 
2.52.0.223.gf5cc29aaa4-goog

