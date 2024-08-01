Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5087149005
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 05:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488448; cv=none; b=loGutOICL6MRTmNaKox9qj/0yFwWBLZaDB1nd5GoTv7Qp7XnOdMs1AQcSRa0KlCy6FxnwsX9UnRXZ917XUsu/n3EpjOyQUq39vmEtNthBxmbUJPSKXMq+VhZ555Q3+DcNoxE5L29uKslUm0f7TYzazenoQgUfBybLzQahDGpUcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488448; c=relaxed/simple;
	bh=qqJCUZdQ2OMvCBwxsyPO9mS+RTuW+7jJ1oS93OxTWpU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ok4Bc5DgkWrBFXxYpsO6fQTdTxIFOHNK+55zecgMvgIJ+BhgCL6cBw+YlP84yQJx8m6uEyTQIVaFzafGG8ChUCzIr0TH8EJ0HpyO3x+SS/nczFzFvswh+IwgppRhmhD1Stnc2GEQDZQyXgsD3zdD0y0B0d9E3iWZS2HblZihGX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tpmkeodu; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tpmkeodu"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-76522d1dca5so6593602a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 22:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722488446; x=1723093246; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=1ftBoMx0u0YKTugTE5W425aVzmDhuqmdSWnt6KFLZIM=;
        b=tpmkeoduhQGCmwNbtvDQfV+Q8PXvF2sFSpMvU4hWgRGloCgV9TrirdpphrKckY923u
         VepU4GzeW1VURN3Yb5YA272Xpzxb7/WONL8b/7rNQSLCldcDlndhlx3lVeYUzm19bX8X
         zLih7om6zUklgiRUl9RkFCZHSQ9f3s6JMlriY3SpZL1AiJU782MZmdx5M/z7bLvaz3AF
         h8KaYYBGLEMurwbq9zEd/+H9eDP52SeylgVMI2uylA4PFT71YH3n2yuwrXPguOUtkjaT
         m8eSwFsMjd+jMQp+0jmsANrtyDLDrKVQv4tRHWlJ3PlBY2zehaOyOxgiSOgP3XNEnFTf
         OCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488446; x=1723093246;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ftBoMx0u0YKTugTE5W425aVzmDhuqmdSWnt6KFLZIM=;
        b=AuZiL+Gd0ROfzz3gdUbOWF8PRgkqJsrJWGbha6taEWUJ1woitctoFMxeKvtF1w/6iF
         8dMfpqwJamnD3GeNZA+UKHMzD3/OR3aFfhZzFhVF0sg/+OHhh4xQT0jUsb1gJmdJvJTk
         wZITdInIzOkPsusarTBZ3u5AuOC6OBipfcZlelaxnuBgSxCTRqaezOjgEC9o6sCz0zsl
         aEaCChP8BP/NdbfoDs43PMhZipi1F71A1fn5rIEolQ++QfJk+RbGXlS7GLmyBzAHRnkG
         wUPwgveDWx0X21a3urGFcVuVoCwd4YvUIQJvVlkQ7ZP7zS+Z3iqrsJgvEHnrO8RyWN7Z
         1/4A==
X-Forwarded-Encrypted: i=1; AJvYcCXL60fRWZlU+RQWTjt0OsLdfXAR7cKeLXuso/d9EW5I5O7ZdbWLbOxZHAW43bO11W8S6qqrFXQdSMaaZRFIgUBvdbJrkZMGxnDvbfnQa1xKMA==
X-Gm-Message-State: AOJu0YxuR7uIr3dfoPik+CdvsRn4+QFYfsZ+qUrtPA/PobzKbpF17AqV
	SLtbPkLC0y8wGSzM9lgfJCETNpD8Jq0VJoYLN4jesneLo8UMrTlxEP+gLjL0KRdwwoFhttV8a/c
	3JCDuhQ==
X-Google-Smtp-Source: AGHT+IHbs8qaJDfvFGAXP/rpBAwEhmqT0IS9EaOILk19416ojQXGwDiYFKRgx0TkGPVP948qxfLhKBzuwVNb
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a05:6a00:9444:b0:70d:2a24:245d with SMTP id
 d2e1a72fcca58-7105d7d6f05mr6682b3a.3.1722488446062; Wed, 31 Jul 2024 22:00:46
 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu,  1 Aug 2024 04:59:00 +0000
In-Reply-To: <20240801045907.4010984-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801045907.4010984-52-mizhang@google.com>
Subject: [RFC PATCH v3 51/58] KVM: x86/pmu/svm: Allow RDPMC pass through when
 all counters exposed to guest
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

From: Sandipan Das <sandipan.das@amd.com>

If passthrough PMU is enabled and all counters exposed to guest, clear the
RDPMC interception bit in the VMCB Control Area (byte offset 0xc bit 15) to
let RDPMC instructions proceed without VM-Exits. This improves the guest
PMU performance in passthrough mode. If either condition is not satisfied,
then intercept RDPMC and prevent guest accessing unexposed counters.

Note that On AMD platforms, passing through RDPMC will only allow guests to
read the general-purpose counters. Details about the RDPMC interception bit
can be found in Appendix B the "Layout of VMCB" from the AMD64 Architecture
Programmer's Manual Volume 2.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/svm/svm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 12868b7e6f51..fc78f34832ca 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1229,6 +1229,11 @@ static inline void init_vmcb_after_set_cpuid(struct kvm_vcpu *vcpu)
 		/* No need to intercept these MSRs */
 		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_SYSENTER_EIP, 1, 1);
 		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_SYSENTER_ESP, 1, 1);
+
+		if (kvm_pmu_check_rdpmc_passthrough(vcpu))
+			svm_clr_intercept(svm, INTERCEPT_RDPMC);
+		else
+			svm_set_intercept(svm, INTERCEPT_RDPMC);
 	}
 }
 
-- 
2.46.0.rc1.232.g9752f9e123-goog

