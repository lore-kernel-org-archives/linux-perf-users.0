Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7B92FFFA4
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Dec 2025 00:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764980314; cv=none; b=oMeNzNb6o8WA65/2JNVVCFB2SOjWZFaftZFdPmGBR/zNVhcWO6mgsLTrlBW/2jhmVItGGK08FUPY0QmBzhmhz4oM6lmn6sfpGgcpPfrJW4OgaEwoMWTNsZRzfmPIHDEVguPET29n+CkIwYa3oivzc3AFSwUjImOUMag+kB2vI4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764980314; c=relaxed/simple;
	bh=3Wr9JMWcB5q7jiwxMn5RBJWwtBvMspvu6SXJNEXPG6Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MK0BbQl/JVNNLg7Lu/Ort8xXYcUzLKQo03exm8MjuGky/eOcFbqeeBG9qd1q7zeW+95pifonKQ3C1xF7/Vbe7PyeqIVqha5qCvnEzBM8pGWEAiFRAO8+L2m3xRkOBX6GStq+IyplpLBSab+kam7ipBH75UqiKlXbbhJ9S0jjSl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=fail (0-bit key) header.d=google.com header.i=@google.com header.b=I+tov7Gi reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=google.com header.i=@google.com header.b="I+tov7Gi"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2958c80fcabso58736595ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Dec 2025 16:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764980310; x=1765585110; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=EW7FbaDPVd5t9h4ibnQZUOMw78F2xoAgB/he+4U2Bes=;
        b=I+tov7GiRtyiO58uXMws04H+CWBqQ/SiP98FOW9vQr8LzoPTX18XuRpDFBQf8Vwaqt
         FJLCo7cfwx/L3aDPUSuFlVEOhCM2Kl+juxNmm+hnU7OoBHv+F815d+euqz3p6BBPOjsf
         ZMAh7qvBtYCV2Gcw2colazmYI0HG5jK5TnnHABxR5OaHP0pMRZY69zS5JUXfUfo1+ujM
         Oz3SknGz4Ijyg8ItMgeEqK/8t1ulGarPso71HqSQ35dzMa8vJ/L5aCeNoCo2acMIaL3t
         tjvpyks8NJQNWkrMS7UzmXk+AOVwPvqa9NYhxvLVC5ThjqjW6XXGJgY+iJA3Acm02KHq
         Sq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764980310; x=1765585110;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EW7FbaDPVd5t9h4ibnQZUOMw78F2xoAgB/he+4U2Bes=;
        b=EmZgFfL3x9+Xj3VJcP1n8t2snwrbAK7H5qvjuJ+4f4HnLhxRpdzp99Md6W+WR6XPtT
         EcavJuA54NNiAxm4xCp4dNCmG4vJopbP6gNeb4QeYM5hXyGHVZJ8MXysMNubYGOYgtnP
         XM5DzdZ4wyl+iW6W5UICjhcwiKPYXJgfAZTpAMMgImhdvfw6NrWCgRcSGE3p91d64YP5
         s7omXWE3GhPYaQvaOqrfQ/dC29KNbcfj8o9c+cB8VXwYQUB8UhyohwbNQSSYNh9dO4e4
         1h6v8c5SuwQ3Lx5wwkA5t2Cbw5tNBO6vmTmxxvffsUYOsbRdwiFi8mciFKEqx2PoccAi
         yVVg==
X-Forwarded-Encrypted: i=1; AJvYcCX6xN+4/QTcx1vRlwe2AycOFydrgmqSUYVK0as3IIwSprEDNH3FQixns3UZFrD4plnDB/OOgyJJsOi63mZQMkjU@vger.kernel.org
X-Gm-Message-State: AOJu0YyoGX1y/oQlgbInL/ijSyLU1/6yv+Jy5jlHuh9SAzHTvJhl7Wvc
	xMwlE+7QsV/8Gt8eYSZQqReyMWxZRxQBVUS1gTgXmwRCaXA2DzZaNIsxTnze4usTx0aZ+9brIs9
	cP17nqw==
X-Google-Smtp-Source: AGHT+IEzWFttnZLEQAsOaxYvtzWLuPcRq6QltY73DikVd5gmywMn7Yi+CzZHr3S07fvHdxIzVSJyvXKfRes=
X-Received: from plrc6.prod.google.com ([2002:a17:902:aa46:b0:29d:5afa:2de])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32d0:b0:294:f310:5218
 with SMTP id d9443c01a7336-29df4cb6bfamr6615315ad.0.1764980310360; Fri, 05
 Dec 2025 16:18:30 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  5 Dec 2025 16:17:08 -0800
In-Reply-To: <20251206001720.468579-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251206001720.468579-1-seanjc@google.com>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251206001720.468579-33-seanjc@google.com>
Subject: [PATCH v6 32/44] KVM: nSVM: Disable PMU MSR interception as
 appropriate while running L2
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

Add MSRs that might be passed through to L1 when running with a mediated
PMU to the nested SVM's set of to-be-merged MSR indices, i.e. disable
interception of PMU MSRs when running L2 if both KVM (L0) and L1 disable
interception.  There is no need for KVM to interpose on such MSR accesses,
e.g. if L1 exposes a mediated PMU (or equivalent) to L2.

Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/nested.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index ba0f11c68372..93140ccec95d 100644
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
2.52.0.223.gf5cc29aaa4-goog

