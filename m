Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022E214BF89
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 05:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488408; cv=none; b=IvQqHvuVMDAmpr/32U9EzXdY/ID/cAF0KjbSnVRpR7AzA1s6QBkE2sHdJDQBhJGspvvFV0X3narGZKxag80kZZX8PGE6yVvBCx8qV3STMe6zunolrGVXgiZx3bIKSWc8yzb+7U05AO0Cv3IFILSpfPdsReVq0YIn89AIPL5htTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488408; c=relaxed/simple;
	bh=FO96eiT7Yj29ohpoHoetrK4qKd1titJ576Y2eGrKkvY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XGKR6LPKAY0ZydTcmMvMM6WGG+rSTEE7QCmtEA5Nby8BMEJ4X9MXsu3hNkdEaoo12cM8w3vWygksFsvf39oMWvnHh+BbqfAlJfYcHkPX5QO0wCQ06Rwp7b/dp7ayAV5b6NLZOaw+hHpFDysZPGMnA6lvMOMOG8NoNVTKRsESbeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rdgr82F7; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rdgr82F7"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70e923f6632so6085222b3a.3
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 22:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722488406; x=1723093206; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hFzd5YCdF5XDzcX1ZBxRBaFj5i7eloMdVPJCkRexheo=;
        b=Rdgr82F71eW6no+KuvCEYaCWPQ6Ylb+MPXBeA0LxuYvab49RMARyT3NawGd+ohPOXd
         yTlT9HyM1EtPYcVuX8N81dD60z2OnnzKifrtJJuSn1TnbhaQ4HyCnMzkKlEMyUegZuhe
         L/uA16uEz5wWybJuy6MfLpdORMhHTgRUqKah7n6lm3wDQ9MxeY9aqfGEy+WROqZM6nYP
         KeYHvuJuwzFPQpAO+vSZlh5p77ZiShYOJEn/npU+3nrrGfZHvsptNfshxdoy+T+7Uy/P
         PpkMp7h0Ig6tJqoSbyA248jcrpt5sam7dgK/vQ3WGgiRf+/74t7uMRpmdhDsTlUMhxEO
         PlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488406; x=1723093206;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hFzd5YCdF5XDzcX1ZBxRBaFj5i7eloMdVPJCkRexheo=;
        b=iEYPnZszr+l98b4ijbqN8a3j7QUg5dSp27Awj0jLhITKQrLgCSIlJ8LCBQNDIsOzmZ
         F5lPr6qgJXYVvrXGlKNkoZoqyNJTTx+ZPcD603DERusLORE+nUZ680LGVvw4dR7WYO3o
         2jUvx27hgIETh5Wx8JgGIqs3OSXde55zGNM7Lem0XCdDS/X9cNwSNWBi3woBLIjM12cA
         2vmsnC2gNMX84/cvFxR8AoGBT+BzW57B4UxShzGBRJMJlpl2xKH3ljX2f0jcaWG2OH4c
         SmcrC5aNVgrW9X9zNeixtZehlcxr9mkaVqxSzMC2YDI2GR4owe1L5M5G2aT4FFhSxvqt
         F2Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWjbWyXQy544X7zduG+vD/WChLsd7duKxDqvPOLWdM8z0pDuzOZNj0CgGo4GrT33JXFKhPUJwSxHoqU5dX64SnrPQGL+qSwM1Ie+ZXz6weNyw==
X-Gm-Message-State: AOJu0YxDwxQjVedZxp3a4nx+LqzKq1AvTaSSNq+JLkv3zM0mMHuNL6Z9
	s2+HntoAfBLSybQ8btSIcxJhMTwB9tJDvQ5CmZieWOdFj6DnjkMViDs+UON+O68SQatZ8VFlvJ0
	CREEXKg==
X-Google-Smtp-Source: AGHT+IGPMFisB/nCQ2SpyxPF79PtrHunowCmHj93kJuiBDB6BwR2q9YvSxx59YdpinxgM55/oSsQQokOOaXz
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a05:6a00:858d:b0:70e:9e1b:b76c with SMTP id
 d2e1a72fcca58-7105d6d1e06mr20445b3a.2.1722488406318; Wed, 31 Jul 2024
 22:00:06 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu,  1 Aug 2024 04:58:39 +0000
In-Reply-To: <20240801045907.4010984-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801045907.4010984-31-mizhang@google.com>
Subject: [RFC PATCH v3 30/58] KVM: x86/pmu: Exclude PMU MSRs in vmx_get_passthrough_msr_slot()
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kan Liang <kan.liang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Manali Shukla <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>
Cc: Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>, 
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mingwei Zhang <mizhang@google.com>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, Like Xu <like.xu.linux@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reject PMU MSRs interception explicitly in
vmx_get_passthrough_msr_slot() since interception of PMU MSRs are
specially handled in intel_passthrough_pmu_msrs().

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 34a420fa98c5..41102658ed21 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -166,7 +166,7 @@ module_param(enable_passthrough_pmu, bool, 0444);
 
 /*
  * List of MSRs that can be directly passed to the guest.
- * In addition to these x2apic, PT and LBR MSRs are handled specially.
+ * In addition to these x2apic, PMU, PT and LBR MSRs are handled specially.
  */
 static u32 vmx_possible_passthrough_msrs[MAX_POSSIBLE_PASSTHROUGH_MSRS] = {
 	MSR_IA32_SPEC_CTRL,
@@ -695,6 +695,13 @@ static int vmx_get_passthrough_msr_slot(u32 msr)
 	case MSR_LBR_CORE_FROM ... MSR_LBR_CORE_FROM + 8:
 	case MSR_LBR_CORE_TO ... MSR_LBR_CORE_TO + 8:
 		/* LBR MSRs. These are handled in vmx_update_intercept_for_lbr_msrs() */
+	case MSR_IA32_PMC0 ... MSR_IA32_PMC0 + 7:
+	case MSR_IA32_PERFCTR0 ... MSR_IA32_PERFCTR0 + 7:
+	case MSR_CORE_PERF_FIXED_CTR0 ... MSR_CORE_PERF_FIXED_CTR0 + 2:
+	case MSR_CORE_PERF_GLOBAL_STATUS:
+	case MSR_CORE_PERF_GLOBAL_CTRL:
+	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
+		/* PMU MSRs. These are handled in intel_passthrough_pmu_msrs() */
 		return -ENOENT;
 	}
 
-- 
2.46.0.rc1.232.g9752f9e123-goog

