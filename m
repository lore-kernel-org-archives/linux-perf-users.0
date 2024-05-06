Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005D74CB4B
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 05:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973460; cv=none; b=UIS7lH3IXd+D5k3Wdn/78FRo9lKjj6G7gi9yMt4s4HvDkKQNAXolZMz1SMMqa0VxDdOc384a8+G5Z2JmOvc4IF2DqSkz8/utt8of6CDyfqhWDf3NkJvLOl8PYJRtPBwHuWyu/n92T+ZEWskelJbhToraWJ178n9i+nzDtjfHc2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973460; c=relaxed/simple;
	bh=ApsrmXZNBEO4veL0e+0rJzKaDijO8Z4ujLHmIktfgic=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jhcpjTqkXweUzK21St7nbZqVihTXac7SlA8JlpYzcjF8AkexxBN0v5fw3zxgA99phA2Om/K3s5FpMMi3xkjKSfJq8tlsr/WVpcM1HARPkTYGcTP4ON+XiR5HltNEY9ZEEPx8+mh7FqTzPADmDg3X4x9DE/FEVUuxSV7Nj5U04+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=01fLBFYf; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="01fLBFYf"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be621bd84so25788377b3.1
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 22:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714973458; x=1715578258; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=75cr41MUIwBE2PICBrqONGJhbLxKbCsiMACBGhSNWNs=;
        b=01fLBFYfIkTO0/QdsZIn1iDASi2IqJ4mkxV+FrDgyAXvOmessIqycqXcy9NQ5qydJH
         rA3i0fOhDxEdsABX1V2eXJ7mt/Yow415pBzl266OWohr0+iSzt7+mfkLWuiI2xed6BFJ
         OOpF3LxSonTy0OnfeW6PQ5eqg16XXBCppLOHsM7Dl+lFASwOudNVF3FjSQH89kf6FWwj
         da69zqzPSY3IwTOBNSBDh533SVZUXySQzyDIeGC4LCCK8llAhaHV1RvdQfB7WQHVOITu
         0Ow9u1exZe9wd0b6lACCJNhBq6JMi78mTipk+Kijmz5N7b0qiFYqdMATfKaRGOtrADnF
         Wttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973458; x=1715578258;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=75cr41MUIwBE2PICBrqONGJhbLxKbCsiMACBGhSNWNs=;
        b=aSwGyXQoLmlm6QNttISvhO5VYYpoOgkLDASf793jQs2bRjcdr2IGqkcvEAYNKg92kK
         WkIF+1/+NasXHczBZI7YldZ12XGgPdk3o010Fk9ldHBh4LQVkHYEcSMncpkeFWbO24hZ
         /l1qYoY0nCPLVCpBvbOXoSmr7XJhmL6uduo2JoMsgvTSyZGYMYKIS5IBhm2Y3R7ZmpQL
         gUG77aCKNPH+7GLByREUlVLKYjgaqUvRdGoSpEU6lAqw/aQ9QUh0uRSF25eQSKG7Trwn
         fcs08brciGz/Qh8tE+gOBzC7qu7eH/c5a2CUQEo3oPGcBBzZ7bPGZhzwshuZlhuh9fzH
         u0qQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4KxG7hktOTfow+IpYm2hlgWRa+L+hNyw5gpzoxaCCMZB9w+eijyixVgDYmDHr/Iifmje8XA2yE/FhmcYB313Y1IJi66rkbywRPjvtPBWwQA==
X-Gm-Message-State: AOJu0YzsbE3cvEE/+fKoQxGfA1KTIE9YECltGKo/+lL4P63CPcD2uZ1k
	eSPtF/tYl6i11ohbh9OHuKNBSvs73pgsn/Lq8EbRpsiRzYanXyWXf4jaCr7Yqnrbaq704vRUbOD
	kDQ8FBw==
X-Google-Smtp-Source: AGHT+IH/aio6aXzh0G0m07C5bH+IQw4PQz3caZp9wzBjKH6yC8WEliTQJXEqK9SnOaJKMY888p+zuWu6ZYu+
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a0d:ea44:0:b0:618:4a14:54b8 with SMTP id
 t65-20020a0dea44000000b006184a1454b8mr2124323ywe.1.1714973458211; Sun, 05 May
 2024 22:30:58 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon,  6 May 2024 05:29:42 +0000
In-Reply-To: <20240506053020.3911940-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506053020.3911940-18-mizhang@google.com>
Subject: [PATCH v2 17/54] KVM: x86/pmu: Always set global enable bits in
 passthrough mode
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

From: Sandipan Das <sandipan.das@amd.com>

Currently, the global control bits for a vcpu are restored to the reset
state only if the guest PMU version is less than 2. This works for
emulated PMU as the MSRs are intercepted and backing events are created
for and managed by the host PMU [1].

If such a guest in run with passthrough PMU, the counters no longer work
because the global enable bits are cleared. Hence, set the global enable
bits to their reset state if passthrough PMU is used.

A passthrough-capable host may not necessarily support PMU version 2 and
it can choose to restore or save the global control state from struct
kvm_pmu in the PMU context save and restore helpers depending on the
availability of the global control register.

[1] 7b46b733bdb4 ("KVM: x86/pmu: Set enable bits for GP counters in PERF_GLOBAL_CTRL at "RESET"");
Reported-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
[removed the fixes tag]
---
 arch/x86/kvm/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 5768ea2935e9..e656f72fdace 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -787,7 +787,7 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
 	 * in the global controls).  Emulate that behavior when refreshing the
 	 * PMU so that userspace doesn't need to manually set PERF_GLOBAL_CTRL.
 	 */
-	if (kvm_pmu_has_perf_global_ctrl(pmu) && pmu->nr_arch_gp_counters)
+	if ((pmu->passthrough || kvm_pmu_has_perf_global_ctrl(pmu)) && pmu->nr_arch_gp_counters)
 		pmu->global_ctrl = GENMASK_ULL(pmu->nr_arch_gp_counters - 1, 0);
 }
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

