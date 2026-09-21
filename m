Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8A251614C
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018071; cv=none; b=edM5TgoblUVlgU0LahokJX3RIbS1HiC0m64VasuxsnMdhgo3vCVjmRcZb9GJb6zr5VmW+S5mYtr35yprGGp+45SzRxTrmoPsfVBhejXoTYZe2pHx7QI8bBq6r9VO5s6gXy3Fi5/7KZyvja+ueKxg23OJg8Sx6ZWhuNU+3ZU0EEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018071; c=relaxed/simple;
	bh=VCDhMVMQYurefRNErLkUn/I6Kx9qbfhpA6PbNEO7NMs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lTybx/e+7ufh4f1ZHOSPL8FLL2XQaBLkv3zDbEO1tPsGU+67pgELexPjei9I8sj+zDeylHkozv0uMZQ7YykxrnIV7EWkp2JOZdMqT6kL5hUvKAv5TLn3H3K47Le5GvVMABvbKuvyaKiP8o5l6E+EvxPYo9dKs+RgYGl8p2boh3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=imvI13nJ; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="imvI13nJ"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8627258ef12so7275495b3a.2
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 12:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790018069; x=1790622869; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Kexp849iBom5QwUGTOu0hBPnyy7JYZUPl7yuJIwcYg0=;
        b=imvI13nJQ0ZAsKjMnVtEwvC8wqWVcLJ9zRnDjZsbfEIiQtD3Lm3oNGYkTeE1omPmH2
         p66ceftILZhTMhvm8BQKda8Tg68nSFiH12hPyEsXuUh0tmTfmoxYQRSiZnu5/Ceo3Zxd
         0B0wncWY7lB4o2+dgzJVWz2gTGhAVilkSNTUzLI9CuDTMEHl5QEJRGORfYIzC38gx9/z
         oOF4JA0C2lUDLGjtn6KZIStE08OY/TptwiJRA7cKNNDEGldbDHnd84sCRmNRffowqgx0
         ExuaCEgCnpv1xZQYMgsZIUigQGIrLFuHMOSof1b+6H8rkdbVNQNvgIHoscYzQZFP0tVL
         67jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790018069; x=1790622869;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kexp849iBom5QwUGTOu0hBPnyy7JYZUPl7yuJIwcYg0=;
        b=NkfeN9/QHPNEfyXLpyn7oADvmtcu7KGANJVdhL9lQTFUEyQXb2jDnJvx9jYQzZr8kv
         JNhjzMdadjM4CCQFwjffIbIKoxrr+dcmvkx+zSZ5ZM/X/BQvTguOJm5ZD6K8QCLeOq5p
         iH+Gc+6EvHRk/n8RS+kk585yBaGgUAjrBsaklNEistZUQVG20yifYo68zqlvxo0KEJBu
         gRzvnlNW5MMhBYN0dv2RbD2L1kpwkn9Pq5/kbxcVz9PY6BYKB/d6FrwKFwEqvyIQ7RKQ
         bIVCYerUGPP4dEK/ubxTXZrdMGzxhTFaEphHzBj6JZ0VT8hCXRiJq+3BSJV7zG9hejKn
         icCw==
X-Forwarded-Encrypted: i=1; AKwUvBxqzCHCdOkO/NvcMZ8EXyHXx/esFVnXxEcnT0SXqVAqRy0WbPRjgVQwuUZG8Wy3IorSjnrOEQh1h3V6k65VDZBG@vger.kernel.org
X-Gm-Message-State: AFuF++mjbmuJheRUoMvLwI2syBfp692g/cU9aHKc+xZw6+qOimlBUaa3
	JlJmVRJ/bOYq0UBabFV58K5EMiif14HoypU0dYLiPhO1QM1wj86h7lfiD0d5HH4lybFfPdIDhGK
	TxAwSbQ==
X-Received: from pfbdl4.prod.google.com ([2002:a05:6a00:4904:b0:879:54ac:7ac0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:44cc:b0:874:708d:b63d
 with SMTP id d2e1a72fcca58-874defffedemr18366624b3a.30.1790018068609; Mon, 21
 Sep 2026 12:14:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 12:14:15 -0700
In-Reply-To: <20260921191418.950933-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921191418.950933-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921191418.950933-8-seanjc@google.com>
Subject: [PATCH v4 07/10] perf/x86/intel: KVM: Handle cross-mapped PEBS PMCs
 entirely within KVM
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Jim Mattson <jmattson@google.com>, 
	Mingwei Zhang <mizhang@google.com>, Stephane Eranian <eranian@google.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Now that perf operates on a KVM-provided snapshot of PMU state, handled
cross-mapped PEBS counters entirely in KVM by clearing unusable counters
from the to-be-enabled mask instead of foisting the work on perf.

No functional change intended.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/intel/core.c      |  8 --------
 arch/x86/include/asm/perf_event.h |  1 -
 arch/x86/kvm/vmx/vmx.c            | 10 ++++++++--
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 66cacfeb47d3..d9315bb2f221 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5379,14 +5379,6 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr,
 			  ~cpuc->intel_ctrl_exclude_guest_mask &
 			  cpuc->intel_ctrl_exclude_host_mask;
 
-	/*
-	 * Disable counters where the guest PMC is different than the host PMC
-	 * being used on behalf of the guest, as the PEBS record includes
-	 * PERF_GLOBAL_STATUS, i.e. the guest will see overflow status for the
-	 * wrong counter(s).
-	 */
-	guest_pebs_mask &= ~guest_pebs->cross_mapped_mask;
-
 	/*
 	 * FIXME: Allow guest and host usage of PEBS events to co-exist instead
 	 *        of disabling guest PEBS entirely if the host is using PEBS.
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 27f9c5bee7b0..5c92d43bbef8 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -823,7 +823,6 @@ struct x86_guest_pebs {
 	u64	enable;
 	u64	ds_area;
 	u64	data_cfg;
-	u64	cross_mapped_mask;
 };
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
 extern struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b097db296792..8f7d0620f44c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7369,8 +7369,14 @@ static void atomic_switch_perf_msrs(struct vcpu_vmx *vmx)
 		.data_cfg = pmu->pebs_data_cfg,
 	};
 
-	if (pmu->pebs_enable & pmu->global_ctrl)
-		guest_pebs.cross_mapped_mask = intel_pmu_get_cross_mapped_mask(pmu);
+	/*
+	 * Disable counters where the guest PMC is different than the host PMC
+	 * being used on behalf of the guest, as the PEBS record includes
+	 * PERF_GLOBAL_STATUS, i.e. the guest will see overflow status for the
+	 * wrong counter(s).
+	 */
+	if (guest_pebs.enable & pmu->global_ctrl)
+		guest_pebs.enable &= ~intel_pmu_get_cross_mapped_mask(pmu);
 
 	/* Note, nr_msrs may be garbage if perf_guest_get_msrs() returns NULL. */
 	msrs = perf_guest_get_msrs(&nr_msrs, &guest_pebs);
-- 
2.55.0.1082.g2b9226bbc0-goog

