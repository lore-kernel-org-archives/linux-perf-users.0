Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6859B269D1B
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837618; cv=none; b=HzHr8Ah5yU8IyK+Mbaf4sA6uG5u3dMIk0gh/IH08pd6B/nl0pC8B9EXNuLukGeMapo+vs1iOWk16xBx2m2QrMhIjqWwLpPXlOB41AqH1EglnIR1Hy/yABzGbaC2eAqSw5odNXmr6D4hJVRTcmkx6pkC40mJ+lTvH6PyGbRnNOck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837618; c=relaxed/simple;
	bh=HK3sVTz5/StFQ9UqVyNVhdMzjLv+XOymilAVSqlp0yI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rymlL6UUIbbdTlmvCsm5pe0IAJCaQaY9Yeb/bQIRh46kkPtoAJJbPo6RowGAbDT5YqGFG601BwGbPoW/Ryb8P7k+yQHtwWa68jk7Jhrshw42HDS+huCtSWEARgT4e/VVzdFfoYwZBM9fIp1wnL72MFD+1NhYEOsID88C/Na0G2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r2ltvTN5; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r2ltvTN5"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2240c997059so104607855ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 10:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837615; x=1743442415; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=BBjwYLkShPCK2VrztwK2kT4zbSZ0SiX7EhvMfBHkH9E=;
        b=r2ltvTN5aTvtWebOo9YjXBnFya/ngtp8YlLkOqyjMtT9VJvDglxpACMARKlSE8dpmb
         aefs+WNZLM+V5qXV12rybUzAvW/ZPr30CSC0AseO0wxvunlorX8Z223wNZtht1x0WGof
         CDsUs3N8Dmy2PnOlrmdh8pzYhocu7U508LjHyHxKqFwRzbPcozGZE+q0FgGNqpyCFesV
         k2sQIdD5B/JGNLLE/ciKRzO8m13NOmQL1x99xSXZi4rYexlGS0jkoV9rjkZk5fj8oYgp
         2A/dI8TDSk8Y8jeCR55ykGUhezJJitWFSHYryvWXwJvDNJ3ZqMdOz8oh8ZlahG+KYmJR
         xFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837615; x=1743442415;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BBjwYLkShPCK2VrztwK2kT4zbSZ0SiX7EhvMfBHkH9E=;
        b=q4j6RfFqetCpOLbGQ1Jp1SmCEDfou+4acgeFSSZoOnXYmfOny0+sdvbG9pSVlm/Qrl
         r6gH88pDCV4kevL+akaQHFLzQUUtrA8q7b0Zs+Dg/WMFqq55P1o2BFZGcSpIfZf7f/lO
         itLFN34AfriN5/vJ0RDXwdFh9av6aTBZ2ElQ08wk58+k18uKAjEkXhzsg0NAIorQtndk
         BA0ORi4vel8qTTPNxiSBSJ3fDwuqH5EWKR3TQWDmkKK6uabfUPUiL6Nzk0rAVdf6eV6k
         JOz5Tq8BdBLUFZ2TzG1J7Isf97+4ZN39YVDL2je0lHOGMcQ5CCCNR/1MRjsKpyiifjAy
         SrWw==
X-Forwarded-Encrypted: i=1; AJvYcCVwbo5g6b1ynQu18J2MngZMx3TS9vj9Dgj+SGf29eF3pvsT9YcwCAQQAIQOXsey/jg7xBUs7EhA4EUwThc9skF/@vger.kernel.org
X-Gm-Message-State: AOJu0YySQC7fFxipRoxalXQnVSxAsBSZwpOKayEDyDxB9AzBFpZ0evJX
	3OY4LC5vg13Sn2maFmSWsi0wVnA9VYzl5Mv9VBX8VDX9FSOEP2TD1IUBADd7OjrG6CCnXsoayxD
	aeGKefA==
X-Google-Smtp-Source: AGHT+IGpE1JBswCmZdI+P62zf261bTaAPnI3B5oXWGwwXXhYsEBSpl4lzhlzzW8eJz0nRuiROYZYDYhxsR5/
X-Received: from plog5.prod.google.com ([2002:a17:902:8685:b0:223:fbb0:59ae])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f608:b0:210:f706:dc4b
 with SMTP id d9443c01a7336-22780c7606emr192403565ad.13.1742837615660; Mon, 24
 Mar 2025 10:33:35 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:31:07 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-28-mizhang@google.com>
Subject: [PATCH v4 27/38] KVM: x86/pmu: Handle PMU MSRs interception and event filtering
From: Mingwei Zhang <mizhang@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Yongwei Ma <yongwei.ma@intel.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Jim Mattson <jmattson@google.com>, Sandipan Das <sandipan.das@amd.com>, 
	Zide Chen <zide.chen@intel.com>, Eranian Stephane <eranian@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Mediated vPMU needs to intercept EVENTSELx and FIXED_CNTR_CTRL MSRs to
filter out guest malicious perf events. Either writing these MSRs or
updating event filters would call reprogram_counter() eventually. Thus
check if the guest event should be filtered out in reprogram_counter().
If so, clear corresponding EVENTSELx MSR or FIXED_CNTR_CTRL field to
ensure the guest event won't be really enabled at vm-entry.

Besides, mediated vPMU intercepts the MSRs of these guest not owned
counters and it just needs simply to read/write from/to pmc->counter.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Co-developed-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/pmu.c | 27 +++++++++++++++++++++++++++
 arch/x86/kvm/pmu.h |  3 +++
 2 files changed, 30 insertions(+)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 63143eeb5c44..e9100dc49fdc 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -305,6 +305,11 @@ static void pmc_update_sample_period(struct kvm_pmc *pmc)
 
 void pmc_write_counter(struct kvm_pmc *pmc, u64 val)
 {
+	if (kvm_mediated_pmu_enabled(pmc->vcpu)) {
+		pmc->counter = val & pmc_bitmask(pmc);
+		return;
+	}
+
 	/*
 	 * Drop any unconsumed accumulated counts, the WRMSR is a write, not a
 	 * read-modify-write.  Adjust the counter value so that its value is
@@ -455,6 +460,28 @@ static int reprogram_counter(struct kvm_pmc *pmc)
 	bool emulate_overflow;
 	u8 fixed_ctr_ctrl;
 
+	if (kvm_mediated_pmu_enabled(pmu_to_vcpu(pmu))) {
+		bool allowed = check_pmu_event_filter(pmc);
+
+		if (pmc_is_gp(pmc)) {
+			if (allowed)
+				pmc->eventsel_hw |= pmc->eventsel &
+						    ARCH_PERFMON_EVENTSEL_ENABLE;
+			else
+				pmc->eventsel_hw &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
+		} else {
+			int idx = pmc->idx - KVM_FIXED_PMC_BASE_IDX;
+
+			if (allowed)
+				pmu->fixed_ctr_ctrl_hw = pmu->fixed_ctr_ctrl;
+			else
+				pmu->fixed_ctr_ctrl_hw &=
+					~intel_fixed_bits_by_idx(idx, 0xf);
+		}
+
+		return 0;
+	}
+
 	emulate_overflow = pmc_pause_counter(pmc);
 
 	if (!pmc_event_is_allowed(pmc))
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 509c995b7871..6289f523d893 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -113,6 +113,9 @@ static inline u64 pmc_read_counter(struct kvm_pmc *pmc)
 {
 	u64 counter, enabled, running;
 
+	if (kvm_mediated_pmu_enabled(pmc->vcpu))
+		return pmc->counter & pmc_bitmask(pmc);
+
 	counter = pmc->counter + pmc->emulated_counter;
 
 	if (pmc->perf_event && !pmc->is_paused)
-- 
2.49.0.395.g12beb8f557-goog

