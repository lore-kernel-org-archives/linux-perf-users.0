Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314E3143872
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 04:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488389; cv=none; b=bwCwbnFhteAXh4G3b5/4uC6YB1hDnemr5vXRk2iMHCgeYo1AWa51+dSYDTGUeL9jWHg0L4j3vQsCAhlSQBMsqooDh7UB3QIAhf8v6vU6zPvbyfEQ6GHPqhOEqYedkN+G+D1dlZU9bkoqi748wch1KTlGGOL8mcnNE4UTOVFqkg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488389; c=relaxed/simple;
	bh=DmaqoFrNzmr8Co3BtZYZ3sN8u8+AQaBmtrlmA+BnoV4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bGrAfkRub+NnpFrKZOWUs+5YTwmtgXTRSEhKkqEVloSNaKanwxG6VmXB8Bw362jpHbjAD0cc10MWZrdzLJ2n1ZMytUAD3+qvxiF8JcUi/pwXh42cbKOtASamtqzpRojgvORAxPp/X6iK1Zd3HOMHzDDkxtDF97KKFBtvinPE4UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HXY1uDEX; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HXY1uDEX"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-70ac9630e3aso5551675a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 21:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722488387; x=1723093187; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=BZY24OME/y+6YnDgfJl2/HTI8j4mWVFxPD5yIL3mP5U=;
        b=HXY1uDEXfW8WvuOcEBUcHU2YHyxorpNeNL5dFbKmHv4sUG/zlIIGg21jA7GqCpdPtl
         4HXkej02s1lW7TpHyilMoD7gt/xYfC7tstmimYgKjpxYKGltj2WD46HNTDE6nvArGa/j
         Hh9jJdbadJ2Rj6N4aziYbJ4+MmT8Upd7086bJiwr868Aud4/4o7Tsc0HUKPf5grlE/yA
         B7g8hFd1BkjeGO0VcRocH5qWKY+QXxl3T7WWAlHukgLkXdBoFc4qFY57nYrfxb6JQbAO
         /vGyFN+MJa2mYfTMXBHDLbYCBicOqlQfkBtt0OxmnjJ3KVSQhCneprecTxkyVimSQA3w
         lTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488387; x=1723093187;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZY24OME/y+6YnDgfJl2/HTI8j4mWVFxPD5yIL3mP5U=;
        b=cNpXx87NbB8SYP1M+jYv9SPgSjzW6SRoTgH6DzPSSCn7XHVf4ahrzP71ISuzZgeOIP
         3Xot6+Ond39bESkLUH18UBNysC3h3Uuij7vJtOXgpNDQVdUoJvfJgARFmZWH4VlWAJS2
         Lpn5yDqAh5Px2gd93k9yXhIdWm8vJh2jWA2rztBO3HEcYpT2L0cxJMBA9KjKT04Ei34h
         IbzmNAFpddfoN6lpdwVnlyCP64CI1vuwlNDqaDTpKy25DBLf67TfopPKcvC5yirIT4xF
         8b1oXsDnkuYsr7OTvA7w0UzGf8aMgQWUXaAMGf27x06ANQj16+pCQhdSvPHj1G0vCqQ3
         myvA==
X-Forwarded-Encrypted: i=1; AJvYcCX4xv9TYSiz3uAgVKK3M5/HqU39SJ3uddrXyHSRywJPHcIE08XlvSR2D+v6IWDB7gag0cZyNhhno5BaxQ2ZwItjjQ6ZtNB8JUF6K7cEY7hTUQ==
X-Gm-Message-State: AOJu0YwmcxLfyaXH8g0l4iqjjkl1Ph8MoKL5HgfXLnXUJ3gEtZ/SFJ/G
	fcXwj3yc60JO2v+eFVGBWRAiNcC6MQKzkklOYXmV4y7hi+IRubdK1gCqrONQ/RjAeWVNQKlqCiJ
	oNgxcoA==
X-Google-Smtp-Source: AGHT+IHFPMD1Fq57svUf/REJRzdZUqR1Ipzwj18MNvxMBjrLkVe7FTwvAMyTJry2Sy3HQp9p1YdM6vMus0Bj
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a65:6904:0:b0:75a:6218:3d10 with SMTP id
 41be03b00d2f7-7b634b5422bmr2921a12.5.1722488387315; Wed, 31 Jul 2024 21:59:47
 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu,  1 Aug 2024 04:58:29 +0000
In-Reply-To: <20240801045907.4010984-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801045907.4010984-21-mizhang@google.com>
Subject: [RFC PATCH v3 20/58] KVM: x86/pmu: Always set global enable bits in
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
	Yanfei Xu <yanfei.xu@intel.com>, Like Xu <like.xu.linux@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, 
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
Signed-off-by: Mingwei Zhang <mizhang@google.com>
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
2.46.0.rc1.232.g9752f9e123-goog

