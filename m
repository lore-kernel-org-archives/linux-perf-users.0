Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2424287257
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Feb 2026 01:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770427440; cv=none; b=fx2W8q740ZZFZ+UdHIuDi8xcu0JOsKfcgzoJ1WNREJLKPzaI6gt5r1sUAeYoaF7ntP4Y/HxcxSkB8v60q6vWIX9wisKcwVGkDZlhrfrULW/ghHkmBzL4NSGzZCZfhDJZ3/Z4VfdS/TMUjTb/KGTv5tmoLFpb3i6/KiSBb+hGRgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770427440; c=relaxed/simple;
	bh=VX6DCgwNWjB+/bxyXx2Y/ERrnxSlvMrxT8BUrW+i6nk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n5z9Mkg4dUUE4zjpi9xrNP+fEUedVXAGW0gffzVn3+Z9HUuXuQtue/32VV5EpAmFqhdjS68JlfGpWgX6SguvqeTYLs7w0MHCgHFodmtNKLvWi4bqtXjjKFjn/VLJVAogZA0bjQ8BPS2ur/sDIDlDVKJcfZ4Sn1T+V15ug04Ntyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IjOQ+/4R; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IjOQ+/4R"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-354c0234c1fso590909a91.2
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Feb 2026 17:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770427439; x=1771032239; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2fG+Y9KC4ijGwyN19NJSb/KoIzzrPjnkRSfXL2ajm3I=;
        b=IjOQ+/4RuSquwHXKoAa9vFe/yfc+SUwVw3ngAcB1u7guSkjCeZsNMJNJ4WD13gqXVz
         pRpSGajBjF4DIay+yyPeu8G5dPjn6gDCUiRdlkD5w7SXC7OMPulzV0FV6yqD86x7v4zl
         yMo4hbBLVzhTZF8AJwFz21LcE2DHOeSwH3UOU2uvEW8/juW9/pPJIrtj5SUmmQ+0CyKq
         4AioybtSBxjAM/hwTFgntglIw37/ibNhVh5Wq6UUtuyn8l0+wO0F0b77e7vuAz9xKyXK
         hq/NmHrph5WRnxJ02tc8KtI1/zmwP9omdNU8A4taYcj7rH23ffEy1lBZRckU8yoQRnwZ
         fsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770427439; x=1771032239;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2fG+Y9KC4ijGwyN19NJSb/KoIzzrPjnkRSfXL2ajm3I=;
        b=H/h+zcJCxqUAYsuqbSzAX6p7Com2f94b2pSRsfHi2YcbX7e/EVq6jcYZgX63EqRMa7
         IY3VdAO/bgAT5GiXlq54sm/DdKc5zo6QJLPxEQA/zrZpTSKhkAC7H7Lx9r8hO+m5kMtE
         AWH6/ifS/yJHNXT5lN3WMjBc1SaBt12f5TabzhWh20NfAoaLsILvz5cYvTYLdR1pUxrx
         c5BFnN5gs3DRim02+2WMNMHvG5a+lCJRNcn3q6ClKugmhm/WJQX0zg4CF3HXFSOiQ9uz
         BIV/chObGeXTCqNHj6yX2SVhswL5PXxVMZhozP7AeSeayirUZ4lnac7hBGx5+ZrYV/3b
         usEA==
X-Forwarded-Encrypted: i=1; AJvYcCV3KM4PH9OKNUnJ+XhHIsaGY+J2cGlwZjsDsiwp7GovRMR2YHwvSpy/6NC4b9uqpG0I3weD2azEeVF7hm2iNVyR@vger.kernel.org
X-Gm-Message-State: AOJu0YxiTMFj939Ix8Wu4hDQHLwo1OJ/VpRTYHtrvtxgVw0koAE+rczo
	xOw9APVvH11yHF4X/LcOWNslZKIeh/nJyfholX2vfKajLm9xpWBzdN85ykv7iR0EegaJvquiufY
	MwmKg0Im9CjjydA==
X-Received: from pgum10.prod.google.com ([2002:a65:6a0a:0:b0:b49:d798:eefa])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:a127:b0:366:14b0:4b0b with SMTP id adf61e73a8af0-393ad3ddbf4mr4788833637.71.1770427439372;
 Fri, 06 Feb 2026 17:23:59 -0800 (PST)
Date: Fri,  6 Feb 2026 17:23:30 -0800
In-Reply-To: <20260207012339.2646196-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260207012339.2646196-1-jmattson@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260207012339.2646196-5-jmattson@google.com>
Subject: [PATCH v3 4/5] KVM: x86/pmu: Allow Host-Only/Guest-Only bits with
 nSVM and mediated PMU
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Mingwei Zhang <mizhang@google.com>, Sandipan Das <sandipan.das@amd.com>
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

If the vCPU advertises SVM and uses the mediated PMU, allow the guest to
set the Host-Only and Guest-Only bits in the event selector MSRs.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/pmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index e2a849fc7daa..7de7d8d00427 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -243,6 +243,9 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
 
 	pmu->counter_bitmask[KVM_PMC_GP] = BIT_ULL(48) - 1;
 	pmu->reserved_bits = 0xfffffff000280000ull;
+	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SVM) &&
+	    kvm_vcpu_has_mediated_pmu(vcpu))
+		pmu->reserved_bits &= ~AMD64_EVENTSEL_HOST_GUEST_MASK;
 	pmu->raw_event_mask = AMD64_RAW_EVENT_MASK;
 	/* not applicable to AMD; but clean them to prevent any fall out */
 	pmu->counter_bitmask[KVM_PMC_FIXED] = 0;
-- 
2.53.0.rc2.204.g2597b5adb4-goog

