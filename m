Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2231428ED
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 05:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973478; cv=none; b=gwz4Z+p8YOeJQh+eDVYpvWMO20wJlhDOg4TMM8Je0YmQXAaxFiYAQMfuSMu3Irmz7Sa8aiqSbymZFXufZfOHrxRvM3REHdXysa2bKC2fjDb0PLJFoVN266cU+1Cm/uXDyZyZwHVSL8Mqe0N3zYdm6hW1nWktMVRgtsvLTageEPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973478; c=relaxed/simple;
	bh=TgkbQRP44YQHwST1GxWXx4WWxmgE0CMy9vQ3qMVMKv4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eoxJ+bmhjw2G1ulxYB9i/VP/2cx8ksw1XYIYp8kZUQQ/QDeIa0F01orTYGDRzlMv84+RgiITs41iLuCtG15PN7DoUAKavp2alzQhsItGZ1jY5Cm/GKkYHEUOzH11XbpunbPZEr2/8mWL1WYt8elWOj36LuL49rIEuTBtWjU8Cm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b3WJtCc0; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b3WJtCc0"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ecf2ca6069so19404335ad.2
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 22:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714973477; x=1715578277; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=iGfssPA7Ybu0SMT2b8P3qWxSEo+uR0AVKzZ6N6t8Kn4=;
        b=b3WJtCc0BMnATGmX/wVh8rHVinIBYsC/9NEjfoFEvL+QjPFUifXKSLYGNqRG0+N0f4
         bypX/vyULLPH/Gc5z6GNhIfmmUeN91yZOl1ISJEb9fNHvgCWV/0IPysbxCxoqaCF+2Cb
         4ZLyazmksebvJE3504qcs8vXUndQ21yYjmClNL9VBK9ZPmDoZXXRFejoz56QcMnap4TP
         RFA+UW5yqck6BaQNxP2YJfOY+VNBcSW9CcIbswNZfR8F//m3MQsgBJfUZb+Hy5RkZ3SW
         ZSqU9Lp/QWgq/Icki5T7z0B3u7TtoFLU+JgXBVqNJHz0SsHT5OH5dw9auGyaq0DbbaPW
         RQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973477; x=1715578277;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iGfssPA7Ybu0SMT2b8P3qWxSEo+uR0AVKzZ6N6t8Kn4=;
        b=dR0iebsTCFmQVxd0S3fVK5vO2taxB5k7paWJsFSK5IDCJ13r7L/ipwBvTEdSnrS7Vd
         Qk5sGleYXs3OqK3/QTxYctkBdgovUN/S28SrjSezmSasRHCLwJH7G/6ojZPcBLHY03Zl
         op5YhHB3q+M+Qt3IYFxMM9tygRxNjHSFsMCUcwEKeVLcKuaZLuDwrvKLEzcK81plURoj
         Rungmct6r3KfW9fJS3FSgguOvcakQOjZdLm0zUv4zBtCi92ttce0lk4jHNmcoBt0gurS
         S7HGemwtZzKodmsWQVzjKyE3mN/HLNxraNVsllDr/EROHPWM6jGMNJ2uKBM/ztHUCu5X
         93ag==
X-Forwarded-Encrypted: i=1; AJvYcCWoguLqbfe2SnzzW3KYwGg3Ba7K8HzwWXBtwIhO+JU/ASfjBSu+3FCgZsGRLs9D51QwqzSPakc7cyETleEnnYP6loVEGrgP+fB/Z54KfTrkyw==
X-Gm-Message-State: AOJu0YwtZ2WBZlcM4AXz56lWybG1tTk+LPhIUjEmJTzurfl+ziTbHll7
	6iKivpOl9uM0MKoARIZSPSb3xq1JDgaQgA/5L65p4RRKTFncaCLD4t2gEn48LIA0x97xRD2QpnD
	ydiMk8g==
X-Google-Smtp-Source: AGHT+IHFoWsTLrUb+RdIRagbboMw7d2AmrZUAfzmNMQ1T7fejvoraFcCnslpflfk88bfbc6nVQsiB6ZOWgpc
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a17:903:2312:b0:1eb:4c47:3457 with SMTP id
 d18-20020a170903231200b001eb4c473457mr493831plh.1.1714973476697; Sun, 05 May
 2024 22:31:16 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon,  6 May 2024 05:29:51 +0000
In-Reply-To: <20240506053020.3911940-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506053020.3911940-27-mizhang@google.com>
Subject: [PATCH v2 26/54] KVM: x86/pmu: Avoid legacy vPMU code when accessing
 global_ctrl in passthrough vPMU
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

Avoid calling into legacy/emulated vPMU logic such as reprogram_counters()
when passthrough vPMU is enabled. Note that even when passthrough vPMU is
enabled, global_ctrl may still be intercepted if guest VM only sees a
subset of the counters.

Suggested-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/pmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index bd94f2d67f5c..e9047051489e 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -713,7 +713,8 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (pmu->global_ctrl != data) {
 			diff = pmu->global_ctrl ^ data;
 			pmu->global_ctrl = data;
-			reprogram_counters(pmu, diff);
+			if (!is_passthrough_pmu_enabled(vcpu))
+				reprogram_counters(pmu, diff);
 		}
 		break;
 	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

