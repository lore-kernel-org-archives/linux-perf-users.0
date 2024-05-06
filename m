Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A3F14388B
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 05:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973503; cv=none; b=GtFpZWSBxWp8T4YqvvJVha6YdF9fiwrljuDRqin9FaDdN7PdF2ZRC8fgJdTgrWprz64fF4iOul7vj5gHcR3O/3UQcgkvMgLckvpVR76xmfru+xDKGwKJHUzluHsX1SJBBiPsRt15sqFmpnLe8PRuFEXCn6XaL4/kNGYUv0lbcaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973503; c=relaxed/simple;
	bh=5xoXXx7Xpex8DhqlHakrum/FpLO4xvulcSP3o1VPIH8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KLTvgc8PCWvgFDE886sxpPQFOjpvtvtk+qHFS7eU0vi+o+LthezT955w1CKEs5Lptxvxb8cQ+InWCiu3msxpo2qQX+Is+UarNaYlqudWc9K3Xpv85D3aKS+icJt11/Q8hxw54dbLunfcZdQE9igWUxxVbV20qwI8vRVLHlWtuFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2unHDLWB; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2unHDLWB"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61bd64c9eadso31259747b3.3
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 22:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714973501; x=1715578301; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=THi3gOlxQxAMXXgHRvCkfR5mjxmtrVYlP6M6JVvxmTs=;
        b=2unHDLWBxWqHDEKcNRYjWOoPDSQxnXJbmomZAkXRMZtyZjNu61oykReTlvVb30jsnF
         p78OK3JIJ6uK1Dpfnf9VbubzusAKBACnI87miCYCRGaolSz9pG+qCFQfjcvbV+1xlsED
         L1FWYyAYnce73lmxoBZ0W3OfoGDxGgqUrG+WbPHqzoC3SkMlmOGCiY8rnQXx/cChur3W
         WXKZlvNmNnCGvQujpAwinGXx9JcASqezEvG8Gdzc8+gkqFk/KEt1AJmcmu5WNpkK9q3K
         tGaGVMYgEM6sEezuDwkK2qmZ0CuhOJeYgqj0NjSUK+v7TnljZ5MjJNcKHUgLTv0XNxz2
         rohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973501; x=1715578301;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=THi3gOlxQxAMXXgHRvCkfR5mjxmtrVYlP6M6JVvxmTs=;
        b=QzKS/Bgis7I7PMFrKX0GnF0+hi503ThrzDw++L7ib6G3OlunRWbUCYWpTy9+iemDzF
         v64bb7tjPiT7bA9Wxm2HRJjixkAlZi7/zcsbjIVEUaIKjR8D41J1FiFEqy2xdiBjk0sZ
         3wQ2GLe7pyZV3VPkjU1zlPRgqL6NB6JnLXm2OEMDbOIojBZRTsj11OzKNl4F7PTUCaSg
         hyzplX0pi10AF3XEuVbGnChpbWHKJ0htQ0/tvYjvST2zVclgQSRem7mxu0ttIv3Q8Uwr
         Ny9TtGW/SIz91qxLCA2mn7wb9yaeUGwl9h9LnM66kTZUQT3rVusYpV2rSklfKkvblE+G
         mrtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKYmnKPMAFzmkFvkOIJj62VzOsoAwsyoPQSYu/aRPgbu2VfCdM3CHQOzKfHRoLV0oNlrOF5gg6c043kORGXXvoMZ0kWvss8sLyaB0lMEKYPg==
X-Gm-Message-State: AOJu0Yz+dkwI7UzL3uk8+pFE5vgdy2zVkFcV6FausFA2FVSolYEO1SEV
	geY0GQ402EUeDlnzMTtA/+eLcgo4kcEZ3f0QTT/F7+87h3dofD2vjPiIhTHadzZDJyHFkuUn+NQ
	/YPFR/Q==
X-Google-Smtp-Source: AGHT+IEYmggk2WwGell0TqnQ71miaUl2FhUZNaqsKuGzLTVYlU1EPwAFWGhsBJlBxcx0LtxoC1KIwD4hy2yP
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a81:52ca:0:b0:61b:e8a2:6f4b with SMTP id
 g193-20020a8152ca000000b0061be8a26f4bmr2546109ywb.1.1714973501433; Sun, 05
 May 2024 22:31:41 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon,  6 May 2024 05:30:04 +0000
In-Reply-To: <20240506053020.3911940-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506053020.3911940-40-mizhang@google.com>
Subject: [PATCH v2 39/54] KVM: x86/pmu: Add support for PMU context switch at VM-exit/enter
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

Add correct PMU context switch at VM_entry/exit boundary.

Signed-off-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/kvm/x86.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3152587eca5b..733c1acdc8c1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11009,6 +11009,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		set_debugreg(0, 7);
 	}
 
+	if (is_passthrough_pmu_enabled(vcpu))
+		kvm_pmu_restore_pmu_context(vcpu);
+
 	guest_timing_enter_irqoff();
 
 	for (;;) {
@@ -11037,6 +11040,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		++vcpu->stat.exits;
 	}
 
+	if (is_passthrough_pmu_enabled(vcpu))
+		kvm_pmu_save_pmu_context(vcpu);
+
 	/*
 	 * Do this here before restoring debug registers on the host.  And
 	 * since we do this before handling the vmexit, a DR access vmexit
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

