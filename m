Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791033081C8
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Dec 2025 00:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764980330; cv=none; b=MkWNlafPzjYGn2mXTvyWh5phUdsjkROgpmplsLwxWfcMMY7lQckoRVFzAfhJ4N+VqicoEzw0rH2Sk5wbWxxU2J2yijNqiMA8+sK5lTlsu7828zT8YTSoUhXab55tJ7k5u4hlw2vYp0GbUlfA5truwcsaZX474v/8wMCja1MJ2MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764980330; c=relaxed/simple;
	bh=B/6xHmD7dd8wWjqN/hAhxWOoQSEJgrYoSRISc3YL0mc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qyt/2Vtl0UDEWmzCwrPQKmhe1ARxZNnDQX2Uuc0bZBNPiBH2BA/AX9QsHJKs9gKjOlR7IzM5WJmiWnFfedKZgLh/hKwiDq1NmcuA/POxyaHSXYwjglzu92/NcClg8FZ6aN4EDCmf7FoRon6a1JKB9HrlcZa3RCVWaFXytZ9yMAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iKh511QB; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iKh511QB"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7c7957d978aso2757592b3a.1
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Dec 2025 16:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764980328; x=1765585128; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=56r/hH7ijnps8qr4K++rAycxqMKLQxyC6YFw0gfnCKk=;
        b=iKh511QBc/yEjfAhHuNG3iwhGXLgAXOynU5yTYI2xMrq25M2JhWxwoAtJ3wDJY6YV2
         H9fH+MCGTRzzWkfGbO5s9rJaYZX+ciwdEcOXBk0P+9iRN//wsDl9j+EljKYXYmBdJoqh
         y4TZiXQOAW4fy53h68wMBHVPGfnOlMIB7QmQicnDxKXif/9zK35OOLLf9o66e7XnCX0h
         HcGua1Zk1H/Np+gG0LXyAyn6aCP26whYJS4crd7mefUhZrDIrmy+YiBwFNQHPOZrjDGL
         GbWxE4pfG9uLB79xjW0yZ1pMMr5+ZRfciXr22w2bjumA8BZ/vaC9YSndsOHxIJH+c3S/
         tZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764980328; x=1765585128;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=56r/hH7ijnps8qr4K++rAycxqMKLQxyC6YFw0gfnCKk=;
        b=Su7jUF2MjN1fQH4mmQ1BZXGvNYXf0dVMippRxEYRCNDsP4kXAvq6esgvzN/5cRxynq
         hlnEkxePLA59prxb5u2dVcZ3PI7a6TSQCxusBvmJX3b77HsQoY/MmLQ0ono43ICzFFk6
         ybYY40riCUFU9zLKMy1kMS1wQDc88xmMrFfEjAW0DSKI7uqFkOmLe0ct6JX0qIdc/P31
         CqWioi+qK6r1wIHAlz9e/6TObSJgT4SNx5+luX/xe4OooZZ7pHWNnIzuqmcWnBfvPwZC
         qXBV5myygIiecLzmELmAxc1TpjFp2nAu31zdbsbsg9l99oSbvJXz6neN3iO9taW0njF0
         y1Xw==
X-Forwarded-Encrypted: i=1; AJvYcCX8WJjrLXG4+AjTzI1sq7JYX2KSKNNalimn6d8g88gIgI1+rHPS/Kpv33q/jF+NAgewB5TBd/aV4OjH1PJx31N1@vger.kernel.org
X-Gm-Message-State: AOJu0YwPtyxoaMoNsC3scLf7t/nxQ63CqT+E5/WtdqLWG25rs/JJfJjs
	Rtd3nWx/VlcL+uGdlpNkNkjGfDTEhCbB9wBSRAA9hvnDXKM5FzzwMUQtOZe1iyp9q5bOBeQp51D
	hOet22Q==
X-Google-Smtp-Source: AGHT+IGLiFKCkiAoyo8w1adxKIx9TSOzM2AC83Bo64USM+supssaEydukBJfVufrwhWzLpi5mXFgs4LcC10=
X-Received: from pfbmy25-n2.prod.google.com ([2002:a05:6a00:6d59:20b0:7e5:4656:9d96])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d90:b0:7e8:4471:8ca
 with SMTP id d2e1a72fcca58-7e8c6dac0c1mr746508b3a.43.1764980327560; Fri, 05
 Dec 2025 16:18:47 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  5 Dec 2025 16:17:16 -0800
In-Reply-To: <20251206001720.468579-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251206001720.468579-1-seanjc@google.com>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251206001720.468579-41-seanjc@google.com>
Subject: [PATCH v6 40/44] KVM: VMX: Set MSR index auto-load entry if and only
 if entry is "new"
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

When adding an MSR to the auto-load lists, update the MSR index in the
list entry if and only if a new entry is being inserted, as 'i' can only
be non-negative if vmx_find_loadstore_msr_slot() found an entry with the
MSR's index.  Unnecessarily setting the index is benign, but it makes it
harder to see that updating the value is necessary even when an existing
entry for the MSR was found.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2c50ebf4ff1b..be2a2580e8f1 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1141,16 +1141,16 @@ static void add_atomic_switch_msr(struct vcpu_vmx *vmx, unsigned msr,
 
 	if (i < 0) {
 		i = m->guest.nr++;
+		m->guest.val[i].index = msr;
 		vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, m->guest.nr);
 	}
-	m->guest.val[i].index = msr;
 	m->guest.val[i].value = guest_val;
 
 	if (j < 0) {
 		j = m->host.nr++;
+		m->host.val[j].index = msr;
 		vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, m->host.nr);
 	}
-	m->host.val[j].index = msr;
 	m->host.val[j].value = host_val;
 }
 
-- 
2.52.0.223.gf5cc29aaa4-goog

