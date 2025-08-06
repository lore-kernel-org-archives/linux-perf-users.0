Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B0A2D6614
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Aug 2025 19:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510293; cv=none; b=P/11MD2h1iAJf9jQ7Y3afgkQI54ZOoUi9UdOaJ0ZHGj+zCAAiNG4PtXNT0lTA3te6P/KU/LRrfkAjzG1JH8ZNg1sDysvMiwf97UuMRFY5u1bM3Lonvkaj9H/UCXis/6iYaq5BNy9xiuWkxBCzJi6lAMM9tjRu2dEEXb68mulNqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510293; c=relaxed/simple;
	bh=C/4r70x0T0JzgUP1RnZOZXEA4d1zjXrhrDvqbtcZVy0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ABt3gVMVJSuVuiZ7NHd5Clp/t018HugOYnUrwWvBL99A/iH7Csnzzr2NcUVeBoisejLkIoo/ImHp0dRR00sFZl1CgOdFeunSheU/Sb1/mG7NOvm5VIxsnF9JM8b9U3IgEP4/ZTO3KG7c9atpvwzcRL1iFFUzTCJrQDJC9ToDepo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pxaoaxds; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pxaoaxds"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-315af0857f2so334481a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Aug 2025 12:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510290; x=1755115090; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ThGb/1cQlCkxXgvsmi9By0m3uFp5vZO1mPp34NlVQTI=;
        b=pxaoaxdsqM3qDq0p82vQdGesaY5K5k9yAhyF44ZVSVGwdpsY2ZgvIyP9/hdDPGgVSm
         0dXmP+Fk0QqbkEgfVjWc9wtipY6138MYASUoLceKATrWeu7cgcEexAHk56mqT0o3bqmD
         4UpxSoE7wXBkug9J/SIi742y1Sa9fO1qYLNOjPdiB5PtpNxQ1j7Ks3hp7MkVPTQ11t3H
         18v7zv7E0N+Oxkweq7ad9i0RSOOvcJ+UshJVExVE2I/pV60Oqk4mxy5MasyU9+LEt+kM
         U9fISkY0guVtYVULf6jMdrnKa+ZXx6BpswpGZUEghC9Fvv6BpM9Nw9F7eEKfB7XbXbak
         e9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510290; x=1755115090;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ThGb/1cQlCkxXgvsmi9By0m3uFp5vZO1mPp34NlVQTI=;
        b=PB6X8JE/bigKkBjIo2xzhL9mJezBwwVUyE7OInisaMr7bVP8hm9ctKCqDXIlWHkMX9
         q2R8pEfqggq0+6zpU5gvqFWs4QqxLjzG4J6Af4dkV7bs7BXpPK8t0XkWySYkyiNkSUWg
         mfZdwBKTESurkSYhzcz6OCC+Z6r92QkNX2ArititqK0k3DAh+0ZvK6leDrBT36/pGKPQ
         IGeYV68HWbModMBy9eGZxHpFFZLO6iJvc9yEJS+B7xrkER5d0jFQ7RnhEAtCxPV/xkyC
         Vhn5cLBaRoqwNAhf1t25oD8GhhqcLBvJ+ZZ86RciatHSBTSntYxo5Hj3XwQsiahYc0MS
         cPUA==
X-Forwarded-Encrypted: i=1; AJvYcCWETza5xya9azcjlbOSmu9NwCcC1EsuQdaoODttZoMp3cqCdQun8KqGNpk5oA+nL4CtwjRRASnr9rzPm3dxz4kL@vger.kernel.org
X-Gm-Message-State: AOJu0YzqCGHNVSZe5ojOMsa2Vyz9vLwyys38wU1rCpWSXZ88lDTqPDpM
	ys6T1ataG/MLlRf+ZQJdxE7gJYybJsFH8cNQDWachDaTjVCGemGsgA+8A/qDhaC1AU66xgjOV5C
	LUy3Bjg==
X-Google-Smtp-Source: AGHT+IEDX7osU0iIbko+P3lNad2rdh21UdoQ7zV3q9ejnGRLDtg0+KAFySIgmFRbYCqEx1sz5hOKZCwZh1w=
X-Received: from pjbci4.prod.google.com ([2002:a17:90a:fc84:b0:313:242b:1773])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dce:b0:31f:5ebe:fa1c
 with SMTP id 98e67ed59e1d1-32166d77ff2mr6724469a91.0.1754510289629; Wed, 06
 Aug 2025 12:58:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:56:44 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-23-seanjc@google.com>
Subject: [PATCH v5 22/44] KVM: x86: Rename vmx_vmentry/vmexit_ctrl() helpers
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

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Rename the two helpers vmx_vmentry/vmexit_ctrl() to
vmx_get_initial_vmentry/vmexit_ctrl() to represent their real meaning.

No functional change intended.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 8c6343494e62..7b0b51809f0e 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4304,7 +4304,7 @@ static u32 vmx_pin_based_exec_ctrl(struct vcpu_vmx *vmx)
 	return pin_based_exec_ctrl;
 }
 
-static u32 vmx_vmentry_ctrl(void)
+static u32 vmx_get_initial_vmentry_ctrl(void)
 {
 	u32 vmentry_ctrl = vmcs_config.vmentry_ctrl;
 
@@ -4321,7 +4321,7 @@ static u32 vmx_vmentry_ctrl(void)
 	return vmentry_ctrl;
 }
 
-static u32 vmx_vmexit_ctrl(void)
+static u32 vmx_get_initial_vmexit_ctrl(void)
 {
 	u32 vmexit_ctrl = vmcs_config.vmexit_ctrl;
 
@@ -4686,10 +4686,10 @@ static void init_vmcs(struct vcpu_vmx *vmx)
 	if (vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_IA32_PAT)
 		vmcs_write64(GUEST_IA32_PAT, vmx->vcpu.arch.pat);
 
-	vm_exit_controls_set(vmx, vmx_vmexit_ctrl());
+	vm_exit_controls_set(vmx, vmx_get_initial_vmexit_ctrl());
 
 	/* 22.2.1, 20.8.1 */
-	vm_entry_controls_set(vmx, vmx_vmentry_ctrl());
+	vm_entry_controls_set(vmx, vmx_get_initial_vmentry_ctrl());
 
 	vmx->vcpu.arch.cr0_guest_owned_bits = vmx_l1_guest_owned_cr0_bits();
 	vmcs_writel(CR0_GUEST_HOST_MASK, ~vmx->vcpu.arch.cr0_guest_owned_bits);
-- 
2.50.1.565.gc32cd1483b-goog

