Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9451B14431C
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 05:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973519; cv=none; b=JYm4qDbbIY+PdWbw6FyPQ2MARYLVdosjTSBO+mcnmNTm/VfmsPbayrY4JY1EuMCRP9vmXd3U/NZYqftHx/GAyBYsu1oUpGR6o55YICmRueVG4LvgqI2ZzUNjgpV7B4XVd0yXlisb0y1aYTbtmH5wg6uTf4p+d74c7p29WqWbn/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973519; c=relaxed/simple;
	bh=u8UNKgsAMVA3G0emeM9UShJfp8LEpOAWl/TGmBa/fow=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nv1Zv1BO+nyOcptZazmlH5noq1BJAau9Fp0lfz3U2XIiHgGdP2tfGB54JCJgczdeWAVAzMLl/C9u2pyrfxWQddTTlPeJFKFBEgrHS0Fkju6rOD9n7YIzZEaSAt448PiQZIQiIQSRjMe0aYzFnpcYQz+SmY9AHRD0n/8rA0guvt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q2JId6xq; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q2JId6xq"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be25000a4so35362847b3.2
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 22:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714973516; x=1715578316; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=XH0pM0BIJqnCQsB9pz0DrMm6xibHkg+QmD8ju5qJDLQ=;
        b=Q2JId6xqVt7wihBlzZFazE0voMcscc7S2zfDLXP3NDTzw2zLedVXN3VZ7ZPYdDk3uO
         ma/YQK6zRUScbepX/cyzjHTloa7IZO1cMkEG+II0WRmZXL+t9Gh752TjG/VtENpahvvF
         9vkoBkNkqxtj2JuXDgX/eIscKf0sWkZNeBIbp14R7xrsNMurBI//JvKLcf/AHGY6vEak
         NzHtBxBwqNEmoRivQLcpYEs/R+BJlYgWQX8woFV9yRQuqDrmOp4ctltjVS3PY+N9Nxxn
         CBJHIfLKjMFm5Bw+ur8nLasJh7uUbPFXIfq2P59OfyyFHkviNqxfnMyZE6kq5B7uVlZt
         xz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973516; x=1715578316;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XH0pM0BIJqnCQsB9pz0DrMm6xibHkg+QmD8ju5qJDLQ=;
        b=p7pcKnTbO8Lv94HTf4EwsgUvzR9PZakFtr9kqyLnQTQHkp8Sc6uEiztNJsW5amvdXl
         5Z7rEmBAp0GtrCRoEM8xcPGOV9xLdKVYDwrus5Gt9gEW0rfyXla9Sk5qU8tMLm+YMe6n
         ll7rt3Q5u3P5oxm0iASvJzbQNCExqS/t6T1DaWBEKTLY6oui11HElMohb+qoafRNjG04
         OAgiKmUd9OBI/avGTzg4WGEPeOONXlhqEBTkFMYUd3SbvfuipNHPMVggmCoPtpkk27uF
         rQIVO9CMLNFeA1uQdfwwpaOM9XjamF8Nuu0HU0EhVbCQH8jQuNxwb+68BoLTv4HSimoR
         uqLw==
X-Forwarded-Encrypted: i=1; AJvYcCV05AqMmFnGD7ohsdPOtsrQZ2N7H55ap2kOHzO+357QSoHoIx/EYiBV4RKae7Osq9vp13UEfJyQyvkNBWuTjAEqmH3B11yIxyv0q5TwndWtDw==
X-Gm-Message-State: AOJu0YxIjHMnsdsS+Vr4aOlB4k0NlnimXMtCj5jnOk6KvaaeYsjbDxID
	mtXvslu9ME2vjos4ClA2xSC6J2w2fz/6VFykKm0yo55QaNRUzf8MUF9mpHY7U++fSyrgc9E/DIQ
	fjD3sKA==
X-Google-Smtp-Source: AGHT+IEyYC00BtOAv9l6Lo3nfm2HRh3Y5pes3JM0WfFjFXPl8xbFNX0q+wLMbOixIL2P8fWX+N/5lhvRdEOM
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a05:6902:110d:b0:de4:845b:8f08 with SMTP id
 o13-20020a056902110d00b00de4845b8f08mr2993637ybu.2.1714973515792; Sun, 05 May
 2024 22:31:55 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon,  6 May 2024 05:30:12 +0000
In-Reply-To: <20240506053020.3911940-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506053020.3911940-48-mizhang@google.com>
Subject: [PATCH v2 47/54] KVM: x86/pmu/svm: Set passthrough capability for vcpus
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

Pass on the passthrough PMU setting from kvm->arch into kvm_pmu for each
vcpu. As long as the host supports PerfMonV2, the guest PMU version does
not matter.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/kvm/svm/pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 447657513729..385478103f65 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -211,6 +211,7 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
 	pmu->counter_bitmask[KVM_PMC_FIXED] = 0;
 	pmu->nr_arch_fixed_counters = 0;
 	bitmap_set(pmu->all_valid_pmc_idx, 0, pmu->nr_arch_gp_counters);
+	pmu->passthrough = vcpu->kvm->arch.enable_passthrough_pmu;
 
 	if (guest_cpuid_has(vcpu, X86_FEATURE_PERFCTR_CORE)) {
 		for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

