Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E4B14D710
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 05:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488416; cv=none; b=fyFM4iXuHtxhryaNDuG20BuYa+9So9DfpJKEmXmDx2O9e3sKTOwq0+9J2WN2DMPdQxQKfEpDZ9slC2g7PlOdIIFEwFhQh12hUImCzwav6ESunr8u/nZt0gcH53nqgtkWrwYZJBqsfGALRI8pOorP5xUIMimiVkclsJGWreBu2kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488416; c=relaxed/simple;
	bh=Bk+0nvKop0JHRtbRPrVchmKBbVyM3rgvuVxfqjS5P8E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F4sBy7klORJnQf9JSlGq679ptZdoDy483afmIj31yB+wi1jsXbLccRcdBRGCI7dI3yeeMve1tPvsJjzfuePOT6cGjN5h5SSC2p9OCkYNbOPm37VmImIeS2zNMzo8qUR1GOKh1XiUTV31JcOiV9O0Yyvl5ALbw4ItHUkKFVCw2GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j7V3IFFd; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j7V3IFFd"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02b5792baaso10490730276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 22:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722488414; x=1723093214; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ofi3REk1BGr1x1WS6xJKcE1TSnEgsigC0M33dE9Lcio=;
        b=j7V3IFFdgM51eIUiEQpAA8hGjjuTD6kA72vZCTzO+rLENeMQpj2w/AzVBjufIc+VAA
         wzcNOfGscqL23M+UFUrtQac3/AlbOPmWhuCdgZWkWvQe5TyXPWQ8dwnnhBU1DDxiLmif
         oS9HY7whWHmx17eKnjE9v+sWpFnlqk78sjw7RPzhIY8hzkNgD3oTg8PFCM53H6kvAqoz
         aJGASCeFXgP8QS7/OJCZqiqzygOozwMSWaa+Wq++eYfcj82rztc3D8quAg8+CpGaQas6
         FWqgMGFrMKRuqjrrXQoaDOtDk16ZgNLeYgVB0pZn+VYS5ZeF6KE85vNXsE0FLYTqCSJW
         P46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488414; x=1723093214;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ofi3REk1BGr1x1WS6xJKcE1TSnEgsigC0M33dE9Lcio=;
        b=jXTbEteBo+s9t+HrZBMrLgWLUVaxgcJBYIyi68S23j/1KFU7qMfoT6MyCKDHjPD3ob
         X2wnnJRj7SZAdipQHxxfuleYEECXp6LZdC7a27QDtfsFB/IJDR0otSWJTZ94hqC9YZgH
         xbxfrogrMie1kmGqLivhVMWKFFI02Ko28cf2jazTAUfIuJ7QSS1Sw7d/YGzHXdilGLU7
         0IkY119RcyW8BrkzTckYtEUgcAQ19MHmgueA3Lfs/SV12TBTDi18PZ6jt3rfCuuISOLl
         ZCbHHcbC2j7LqVx+M3ZWxz3cFCBddawRRqre5qRHr2t5mEVEYKrvvh4PjS/FhobRNke5
         AIYA==
X-Forwarded-Encrypted: i=1; AJvYcCWv9XUCylL6tUyVHbSqIsio2eIO2+LXkLFmD2p89idtVj50G3dQCNUQCh68+NFViEO+mTMlII4XiHjpu6ES708EIPx6GLaDB17I3otEybRirw==
X-Gm-Message-State: AOJu0YxW731jmmRbdqDc3homrqrEjD2NvX+zgrjQtV7sSRoimOR3UtKd
	2q4ZCnyckjBgh5ILrKSgi/g5mY45zqM/KYaeRmuzEvtHyuu6MRRpUnSJ3+8mHGHmmnekCn6EN3f
	JAgfy5A==
X-Google-Smtp-Source: AGHT+IHatkdmPJu4KhGRiDjpGk6tcK6tPjwWCykTdQmn9N24iyfBIP7+GxGFvF7Jp7lm3F8hV0gNzxADhkbU
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a05:6902:e10:b0:e08:6c33:7334 with SMTP id
 3f1490d57ef6-e0bcd377446mr3384276.8.1722488413693; Wed, 31 Jul 2024 22:00:13
 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu,  1 Aug 2024 04:58:43 +0000
In-Reply-To: <20240801045907.4010984-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801045907.4010984-35-mizhang@google.com>
Subject: [RFC PATCH v3 34/58] KVM: x86/pmu: Make check_pmu_event_filter() an
 exported function
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

Make check_pmu_event_filter() exported to usable by vendor modules like
kvm_intel. This is because passthrough PMU intercept the guest writes to
event selectors and directly do the event filter checking inside the vendor
specific set_msr() instead of deferring to the KVM_REQ_PMU handler.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
---
 arch/x86/kvm/pmu.c | 3 ++-
 arch/x86/kvm/pmu.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 9bb733384069..9aa08472b7df 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -443,7 +443,7 @@ static bool is_fixed_event_allowed(struct kvm_x86_pmu_event_filter *filter,
 	return true;
 }
 
-static bool check_pmu_event_filter(struct kvm_pmc *pmc)
+bool check_pmu_event_filter(struct kvm_pmc *pmc)
 {
 	struct kvm_x86_pmu_event_filter *filter;
 	struct kvm *kvm = pmc->vcpu->kvm;
@@ -457,6 +457,7 @@ static bool check_pmu_event_filter(struct kvm_pmc *pmc)
 
 	return is_fixed_event_allowed(filter, pmc->idx);
 }
+EXPORT_SYMBOL_GPL(check_pmu_event_filter);
 
 static bool pmc_event_is_allowed(struct kvm_pmc *pmc)
 {
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 8bd4b79e363f..9cde62f3988e 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -298,6 +298,7 @@ bool kvm_pmu_check_rdpmc_passthrough(struct kvm_vcpu *vcpu);
 void kvm_pmu_passthrough_pmu_msrs(struct kvm_vcpu *vcpu);
 void kvm_pmu_save_pmu_context(struct kvm_vcpu *vcpu);
 void kvm_pmu_restore_pmu_context(struct kvm_vcpu *vcpu);
+bool check_pmu_event_filter(struct kvm_pmc *pmc);
 
 bool is_vmware_backdoor_pmc(u32 pmc_idx);
 
-- 
2.46.0.rc1.232.g9752f9e123-goog

