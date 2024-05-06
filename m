Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A61E140E29
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 05:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973449; cv=none; b=jux8AUPwGV3HJ6Dw70XcIV9Be2Ii2jkPewNqI4KKIkjSpSr48hgSDpoz8I7bxDCYu1W5oa8d7iT8m/T9rfyfTFR9nEdXb/cpNJMmNJAtgNxDSHjx4SH6ppQFOOTSd8WAFDjqiZEAjOozQoXVULzbJ3oMoGtFp8YgQXxxRFT1TWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973449; c=relaxed/simple;
	bh=kQemOPD0Zydqsmtn0w+cnNnsyxjU727hdz4fooWjwfo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JtaK8G1MYDwa6YvgMuZzxexcSUn8ALAX+jdfPH/TObgQxYYduJMKwp/xNyvO+Py8al7up/uGCHPlfm3sp4RnjOwIcG75j+ABlzL7SCxvd1ozi86OkTOL5A2UayGMXIxWUHa2zwDhYBTibQ6rLBuQVoeENGfLIx9WvB0YU1S8ObY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CZ5MBHEA; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CZ5MBHEA"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5d8bff2b792so1873578a12.1
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 22:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714973448; x=1715578248; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=9Dgs20dNjgAl9Yl4ETI/O5/Y7n5eoiN1wzowsGzoois=;
        b=CZ5MBHEACVJjouiWRaqSO4IuDijBhry+bgkmbBXV2QgX1iUtmRRBX3TJZ0WMqmtH5s
         xaU/DUsvtRZgrOB5TkBcAvAw7tjGKlm0KJzWAr2V5332dbt2exnMZGIcMlCAQDIyjRMj
         KUhVRVkDDqR8wgr5ktQC4gtTqF7ScCmSo7Nt6skFd64rxcCUoGmenyaeGtpPbHmkbA5o
         0iWjeHnhUKPIn1TGl3GhxKLtiogI8b7jJnM86oJ21XenNUmfVsfYZrvSUVY7sp4MNmp0
         +r91w1ZhDJL9e/333BnGOejLP+f7wSXE2T8lMaR10idhBuhVUJmy/dHBXySWdU2pWNBM
         4SfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973448; x=1715578248;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Dgs20dNjgAl9Yl4ETI/O5/Y7n5eoiN1wzowsGzoois=;
        b=fsjsxYXtd8lKCrVWfedO4i0A9qia/x0T58ugA0yx+xSxJVJqE+ptTuw18U4kOXiXCR
         SeDIjO4hg3IAsasBTV41i14OwLsmAZ8hhCgA3UOOMU75fG8oX4VZj1CW+1bmdiOOdPY6
         08Rj16n8ktftIlTqk2/QI8ONZzMPVnenubbdowHgNvlYgRvsqgidLxQmIsS7Dr6mVAV2
         gtUDWeUOv1b3sjxxNvMcIDfeV5eCquEUV226L6/Aw31eFJk6f8OSfS3tkVeRKAXIQFJ2
         6rbSPh2+u0MRZFaP4kL7F4dqbya05ESj3Wz2L9Bph+iORm5sf1FLmghfKz/Nk0qijvVS
         ZzDw==
X-Forwarded-Encrypted: i=1; AJvYcCUBtHrbXciBTrtIrmZSr+IrawFoYf/oNDoqF09eb7vdbEdJb94kengNWtni12Wwu3++1OswgGUyRqaY8b+xW6ok1XZG6BYN+KvQjSh1Mp06gw==
X-Gm-Message-State: AOJu0Yxd/fayxtZNv6yChlaadi+dIGxtqa7Ll4vTo5JBXsn1ZGrI1/h/
	/Vu4d2yJOD+VCdCBguXaj662Ku+U6r0h3BkYNOLbcj/+dQWIO38a/cm58JxTuyUwMXnyoQAyd0j
	qCEY1wg==
X-Google-Smtp-Source: AGHT+IEddBveDzLs8KjlI+n90U+GWRV3jtIkb+j1aP+Aml/IbiLi1j81dg8g4Ubmb4YPqwtk2l6FE9b0Wsxm
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a05:6a02:68f:b0:5dc:2d1c:43c6 with SMTP id
 ca15-20020a056a02068f00b005dc2d1c43c6mr27121pgb.9.1714973447431; Sun, 05 May
 2024 22:30:47 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon,  6 May 2024 05:29:36 +0000
In-Reply-To: <20240506053020.3911940-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506053020.3911940-12-mizhang@google.com>
Subject: [PATCH v2 11/54] KVM: x86/pmu: Register guest pmi handler for
 emulated PMU
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kan Liang <kan.liang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Manali Shukla <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>
Cc: Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>, 
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mingwei Zhang <mizhang@google.com>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, maobibo <maobibo@loongson.cn>, 
	Like Xu <like.xu.linux@gmail.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Xiong Zhang <xiong.y.zhang@linux.intel.com>

Add function to register/unregister PMI handler at KVM module
initialization and destroy. This allows the host PMU with passthough
capability enabled switch PMI handler at PMU context switch.

Signed-off-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
---
 arch/x86/kvm/x86.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ebcc12d1e1de..51b5a88222ef 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13887,6 +13887,16 @@ int kvm_sev_es_string_io(struct kvm_vcpu *vcpu, unsigned int size,
 }
 EXPORT_SYMBOL_GPL(kvm_sev_es_string_io);
 
+static void kvm_handle_guest_pmi(void)
+{
+	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
+
+	if (WARN_ON_ONCE(!vcpu))
+		return;
+
+	kvm_make_request(KVM_REQ_PMI, vcpu);
+}
+
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_entry);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_exit);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_fast_mmio);
@@ -13921,12 +13931,14 @@ static int __init kvm_x86_init(void)
 {
 	kvm_mmu_x86_module_init();
 	mitigate_smt_rsb &= boot_cpu_has_bug(X86_BUG_SMT_RSB) && cpu_smt_possible();
+	x86_set_kvm_irq_handler(KVM_GUEST_PMI_VECTOR, kvm_handle_guest_pmi);
 	return 0;
 }
 module_init(kvm_x86_init);
 
 static void __exit kvm_x86_exit(void)
 {
+	x86_set_kvm_irq_handler(KVM_GUEST_PMI_VECTOR, NULL);
 	WARN_ON_ONCE(static_branch_unlikely(&kvm_has_noapic_vcpu));
 }
 module_exit(kvm_x86_exit);
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

