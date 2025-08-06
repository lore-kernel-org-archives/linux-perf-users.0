Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD542E1C50
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Aug 2025 19:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510327; cv=none; b=LzvZZUwwMr7/+nJgrGnWr3XZTagYWmoXyc4olfcfjeQ0Zu/+6Xf65oGjWV3kmHeRmEVyMF16ehixQPv7MNfNEO5Ki+k3JWoUlMs5FW+g/8+mSXRAl+qWidmT6PxSu/x9ji22G4cjP/Ymnexs2sDuD7XLbhjxAyxdUCF147uNJzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510327; c=relaxed/simple;
	bh=mktiJzkM34N6Zf3/nCj8gPSMPc22J/Q3PSgyAnIfDJg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BqA1qbteb7Eil2N/rya3qdHrSoKfcE4xL056pa0T5Vk92ybso/hsSrTV2iGEfoUFisML9qOuIwibeutjxLeAiqiaz42zPNgT7FzH+1dLv9pv1koi+OZAhYxpUcsGTLhWCAHTQTai3YEzqMBgDXCRrX2ZxPDWu1Ozfhp1otR2ZVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fXpA5j26; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fXpA5j26"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2fcbd76b61so240453a12.3
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Aug 2025 12:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510324; x=1755115124; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=aIwiS3b08lZbnfZBzBRHsRLYuS/hl5WgYmD0pyHBLVw=;
        b=fXpA5j26IVK6dc9rtP00kkCEtvN2bqVStiB/w8fOy12s9JAtL+3eaGIEN0E3zRCEpF
         PB3xnRRQ7u1/ZEdLfYH4/2FLCNwESlB2Cc++/dfTWBjt0Y1aDY/a6162vkv8DudCjTKy
         y9FKqOhFjiD5kjvq1gDrDG7gCAcoag/+U+L6PisuV457jMx9oKdwVhF0knKU2TMZnCZT
         aISWWeRj88t0BXWJ/gSngCEF9dChvgrgu8i3tKgdvqaHjc1FBADtS3qLsgemZByv1hMM
         Hb35zir3S358snxgHky/ncSHxxhbaG+ryusJJeANTjNNH5HYdVcVNu6KHjWnGGsWfrq8
         cRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510324; x=1755115124;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aIwiS3b08lZbnfZBzBRHsRLYuS/hl5WgYmD0pyHBLVw=;
        b=g9s5/DOsbOtTbD5RQTBM/PeWpWixHbxzlsDygCqNn8ScEHDvltuc6MQyJB0pjcCVAz
         LLcC2smRglpQ1jURmWwpSn3dyt1cE9oEyuQetb5kwAH19hnTuiHWaf6+5gNbu0YUaKJ3
         NiMzJlUdsFE1XDnrxeGBsEpiAXBjs8q8+8FmggtAm6XXnLiMKUtz3EDtQSwZ5ypRkUIT
         DR5eNLKixsWI8WC2JpRpFUw8QFrGvodJWAWb0PbAneMk3Bj9T6HWvs34qRPTaFvjlXGo
         wJ4DCZlHmTW3gDuz/1V+ZZmYHTSz2F46kkaLVuqNH7pEu5g6QanN/T71zw8or7L59Luz
         M/nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYEVst8hTlX6iYPcnDYJ6X36k5De8H+UssLSG1poeRwJvZty8oGob6e/t+eNop9SqI5WYadAlJ1BpxKeiliWAo@vger.kernel.org
X-Gm-Message-State: AOJu0YyIOv3G5NWB11eBE8PVDjl+/Zuz6DUVNDtb22wty5DPZOt2lb2j
	PLjV7rlmfgzNhFjpWgkUCsxU9TOGfftCmZQiaJPFtmRUh6RRL1JKDIEX1PLwUHKzAKlzjnvty9T
	AxXMOyg==
X-Google-Smtp-Source: AGHT+IEQR+T9dam/zfnLIV/i5izf3PHRRWb6ka2239rbCk7AqXY3VxMNYGaiVe7zhD28m3tT7rq7DHc261E=
X-Received: from pjzd15.prod.google.com ([2002:a17:90a:e28f:b0:312:151d:c818])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f645:b0:240:150e:57ba
 with SMTP id d9443c01a7336-242a0a90e7amr55806795ad.3.1754510324526; Wed, 06
 Aug 2025 12:58:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:57:04 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-43-seanjc@google.com>
Subject: [PATCH v5 42/44] KVM: nSVM: Disable PMU MSR interception as
 appropriate while running L2
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

Add MSRs that might be passed through to L1 when running with a mediated
PMU to the nested SVM's set of to-be-merged MSR indices, i.e. disable
interception of PMU MSRs when running L2 if both KVM (L0) and L1 disable
interception.  There is no need for KVM to interpose on such MSR accesses,
e.g. if L1 exposes a mediated PMU (or equivalent) to L2.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/nested.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index b7fd2e869998..de2b9db2d0ba 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -194,7 +194,7 @@ void recalc_intercepts(struct vcpu_svm *svm)
  * Hardcode the capacity of the array based on the maximum number of _offsets_.
  * MSRs are batched together, so there are fewer offsets than MSRs.
  */
-static int nested_svm_msrpm_merge_offsets[7] __ro_after_init;
+static int nested_svm_msrpm_merge_offsets[10] __ro_after_init;
 static int nested_svm_nr_msrpm_merge_offsets __ro_after_init;
 typedef unsigned long nsvm_msrpm_merge_t;
 
@@ -222,6 +222,22 @@ int __init nested_svm_init_msrpm_merge_offsets(void)
 		MSR_IA32_LASTBRANCHTOIP,
 		MSR_IA32_LASTINTFROMIP,
 		MSR_IA32_LASTINTTOIP,
+
+		MSR_K7_PERFCTR0,
+		MSR_K7_PERFCTR1,
+		MSR_K7_PERFCTR2,
+		MSR_K7_PERFCTR3,
+		MSR_F15H_PERF_CTR0,
+		MSR_F15H_PERF_CTR1,
+		MSR_F15H_PERF_CTR2,
+		MSR_F15H_PERF_CTR3,
+		MSR_F15H_PERF_CTR4,
+		MSR_F15H_PERF_CTR5,
+
+		MSR_AMD64_PERF_CNTR_GLOBAL_CTL,
+		MSR_AMD64_PERF_CNTR_GLOBAL_STATUS,
+		MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
+		MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET,
 	};
 	int i, j;
 
-- 
2.50.1.565.gc32cd1483b-goog

