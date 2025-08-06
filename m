Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255C02D3231
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Aug 2025 19:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510277; cv=none; b=dyooioiKp1eHD5WJY+HSk5MQuVKgZBvMzJYQcCvqa5whP43SgfyqD3UGjEtudQCRSm3yo3jHFtQn99dM2pC3cm4gFP73b0hIAfPakULxAuJqnaYi//h5rL2/38YXbEGGB8uzjkCGaj6H1sZfiJlRH/pmiZHHl1VzihOdxO3YTe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510277; c=relaxed/simple;
	bh=C4TXme1dQYfX3HBX2bRS9WhICMNyLXZykAhB0txM4zg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZMhU0Vw0QdfOvBdcs2avRdGNZCXz54juNeOFTJf/ods3iPoouc5bSGorRjCUggvUeYPWR8/i+efbfAUjswUg/TScTl6+ssEFK0MuRg1YxfZ0IbkysLoYms+K1MK0AtxnGCMabbCogoC5wMIFp3pAG1Xmr6GViWGVc0PYlwTsVGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pl9ZsfmU; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pl9ZsfmU"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2400a0ad246so1471215ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Aug 2025 12:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510274; x=1755115074; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=0uQwWV7lYMOxBil53zyDkn96gfX2tt2/DqWsDrl/9hs=;
        b=Pl9ZsfmUpZY8vSNBS2r2M3kPAS0csHRRtJ4ESTdtPDF45DJk87cCDv2U+GKR2CsIPZ
         hI7J/d8Z/XWOb4jxCsjS1esCSyaH4Roo6IYL/tYUG0cdm6NO8iWw6Il3t8M4kukamOs5
         +cEY+VT2IyVElMw3Rx7+nUmJNpntPf643sujcpHTOPa3gr0kfvu/EIKUJizLABGGqXH/
         SroNv0EN67ezVFNbOczU1n5JdXtGQQnA5I4aNJnblnabEDq2CHiru8RmLYku3r5PmImT
         7oYQdkY0iCDteciU2cgemBYp5uPdGamFGlplyPLYPe38aOXzjWExn5UMMJG1EmfYgyR0
         JFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510274; x=1755115074;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0uQwWV7lYMOxBil53zyDkn96gfX2tt2/DqWsDrl/9hs=;
        b=CapHXCd0q9yrg1c3705HsEupOt8v+2uNWmgR0o0OjVqJuZmgxOXUzIBZcs2jD9iNyt
         ywIju9OalGMy/fUg0qtEGAED5D6SOl61/CjCdb2SKDxdiWmoZnrdGFSPO5mO1kIWlKIW
         Q6E8L42Wb5msidO0RIrxgXvpphY90RN/W0iDrCEvFA1lcnsnUKL4ZpbX+M7YxkK+oZuN
         7CFblHktUaDI3NuTy//c8xJTx9xzonUM1PtPevrs3LBvdtzzKuDRzpy0tRQ5Mlwuy4ja
         n+/mewHryywt+sFAn1xqhMtxPI8BCpjKu6natdBBKz0dNGkPhgsLcaylm0G9TCKCtuVc
         ILbw==
X-Forwarded-Encrypted: i=1; AJvYcCV18Ih2EIBuXbhMrAbyXe7J+AS5DJc5q/f1XCrk0uwsaPj7mj+PeV7Z5NxCwRx7DOjEUTujDVbfsEx4Hh9XhnJC@vger.kernel.org
X-Gm-Message-State: AOJu0YznRalxP3z2zXMKXSDN4a9vtLNG9jIutsyCZtiSY58UlOQ9YCcu
	fCjv5y2jQCB3fdr5B4/sVaeee/O8HSuvdcTlbRgqoGAMbHXVkmtHVZjnLK2mwAFix82izfpGC+k
	CG4bdWw==
X-Google-Smtp-Source: AGHT+IGH2b2xUlwmCehGLeN80BLd5ICkd9hx9VxyJMjC6VJA8pJue1wqM8eYOcrMqHKsQHTGrwNwqHX4jyM=
X-Received: from plkh12.prod.google.com ([2002:a17:903:19ec:b0:240:9ca:fc49])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce05:b0:240:49d1:6347
 with SMTP id d9443c01a7336-2429f30b512mr54270245ad.35.1754510274358; Wed, 06
 Aug 2025 12:57:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:56:36 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-15-seanjc@google.com>
Subject: [PATCH v5 14/44] KVM: VMX: Setup canonical VMCS config prior to kvm_x86_vendor_init()
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

Setup the golden VMCS config during vmx_init(), before the call to
kvm_x86_vendor_init(), instead of waiting until the callback to do
hardware setup.  setup_vmcs_config() only touches VMX state, i.e. doesn't
poke anything in kvm.ko, and has no runtime dependencies beyond
hv_init_evmcs().

Setting the VMCS config early on will allow referencing VMCS and VMX
capabilities at any point during setup, e.g. to check for PERF_GLOBAL_CTRL
save/load support during mediated PMU initialization.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 95765db52992..ed10013dac95 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8335,8 +8335,6 @@ __init int vmx_hardware_setup(void)
 
 	vmx_setup_user_return_msrs();
 
-	if (setup_vmcs_config(&vmcs_config, &vmx_capability) < 0)
-		return -EIO;
 
 	if (boot_cpu_has(X86_FEATURE_NX))
 		kvm_enable_efer_bits(EFER_NX);
@@ -8560,11 +8558,18 @@ int __init vmx_init(void)
 		return -EOPNOTSUPP;
 
 	/*
-	 * Note, hv_init_evmcs() touches only VMX knobs, i.e. there's nothing
-	 * to unwind if a later step fails.
+	 * Note, VMCS and eVMCS configuration only touch VMX knobs/variables,
+	 * i.e. there's nothing to unwind if a later step fails.
 	 */
 	hv_init_evmcs();
 
+	/*
+	 * Parse the VMCS config and VMX capabilities before anything else, so
+	 * that the information is available to all setup flows.
+	 */
+	if (setup_vmcs_config(&vmcs_config, &vmx_capability) < 0)
+		return -EIO;
+
 	r = kvm_x86_vendor_init(&vt_init_ops);
 	if (r)
 		return r;
-- 
2.50.1.565.gc32cd1483b-goog

