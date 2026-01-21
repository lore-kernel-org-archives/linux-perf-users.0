Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BFB36AB7E
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 22:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769036109; cv=none; b=VIBBvV33WPE7+laDlq0Jzu5AobdgDJp0D2KXMbwIjJNfTy6/VE7SQDevkBysXjQTADRWgHL7yoa4fY6ugNYgYdcMQl60gEkUpb2ks0xTQc6XXletjtzsRZlb36XwLl8Qv1428KrwbAX5+YSgR369uRmdzzv1xCDFDgUjCJpLwY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769036109; c=relaxed/simple;
	bh=4dK1i0Y+ClhECekgpZBpaR5BRwtTPOuDhSyrvTfYzBQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bCBa6tyZBHdVCC9Z5AbSCZI4i5qtQnS33rhL67kSKFrcsDDkEWJVFvDouaEhnryUKetMB0GmoBfnuutZxIabMD2aKhWPxRncBf7hFhd7EcRCLFUt2oVh7k7mfUsnIHMpGCMLSeJ9GSowlWjpeezEx3mqQv1EobTKkIO8uGHc/vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pLOO+ndm; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pLOO+ndm"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a75ed2f89dso2548465ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 14:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769036103; x=1769640903; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IwnAqV7nleR6mcHb2XFaN1DmqlrQfEeG7PA5eyhEQis=;
        b=pLOO+ndmpMe77IKhNkoxXLSYytpNK+ONqGNntmOPk9DsZ1E6ATI9VSrdeN8zTlQz9S
         vx+doZm3ah8lIIADFCUOHXXuUaK9PwJZksD9hakbsMGgRrKG2nkRSM7GliCVYMEqasm+
         jF0/WiUdzY0hFRjGym+DNlzgVPypyhvnsFr76ovu0QIAJNVohkxuiE4WGNnxDO+N8zKB
         rFHfRdk4xtq3GwsEUwIpO2jGMylhG3fGShyvdFtFiZc6Pc2rDkrS8nwTBvEdwrCO8WbT
         4n0w0geiKlAG4ZrqfK6vaoRYBgSfr+76Pg2VK58sTy1Rpw66n+Qr60R6475bqDwbfu+6
         p7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769036103; x=1769640903;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IwnAqV7nleR6mcHb2XFaN1DmqlrQfEeG7PA5eyhEQis=;
        b=ihi3mpEkjP3jm0P+mFPjkY4eSqnhKs/0VKnqQF/DDJSZP12uATJGxMgl3X4KhFCjdU
         W/eGwgqgjUW6cyYFcyofwzlVF58K69dX35uQAafLsm/IOJjJYKpUBd+bPA7dcD1oTJSn
         ur0NRWOzO9gxyeWDUzs1NgZNeJvKYyLuT5ahetU5YvniYR589LQHDbiGctt1PEcj2GUf
         jXyJ+5TYI39ivHiBC2tIibdtJLOK/19MHJhfvyRyuo+QY4YkSyYfE9jd2fdmSNU2qehJ
         5EPoytaS3L3S/YVGGBEOlhggkeytFTROugSjaXGN1x5doLjZEwmTz8PUImusIh9DBwo+
         sr9g==
X-Forwarded-Encrypted: i=1; AJvYcCUWjWvMt1izusUTjKdwYZqmvcrJFyK6/AhQffv8iYJ7P+GrYSF5FtkflbjPNQE0W4fRo8vibG4wkaogVP1bihIU@vger.kernel.org
X-Gm-Message-State: AOJu0YwiSIjfMdIk4Cuwo1U4RAkhoQEstABpe32aixbvgeeEUQmHsTIG
	dSQcOHIiMaP/CpWkgqIrjIyO5bRwW9WE5lcxORXm5iVqhxneCxIAQh1bbfxlUlnt+2wkGebJkRs
	DmJe0xL544YO2NA==
X-Received: from plbkf12.prod.google.com ([2002:a17:903:5cc:b0:2a1:36d4:7f2f])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ef4f:b0:2a7:8bf3:4656 with SMTP id d9443c01a7336-2a78bf351camr42414165ad.8.1769036103212;
 Wed, 21 Jan 2026 14:55:03 -0800 (PST)
Date: Wed, 21 Jan 2026 14:53:58 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260121225438.3908422-1-jmattson@google.com>
Subject: [PATCH 0/6] KVM: x86/pmu: Add support for AMD HG_ONLY bits
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

This series adds support for AMD's Host-Only (bit 41) and Guest-Only (bit
40) performance counter eventsel bits in KVM's mediated PMU passthrough
implementation.

These bits allow an nSVM-enabled guest to configure performance counters
that count only during L1 execution (Host-Only) or only during L2 execution
(Guest-Only).

KVM tracks which PMCs have Host-Only xor Guest-Only bits set, and updates
the hardware event selector ENABLE bit at the following state transitions:

  - EFER.SVME changes: Enable/disable Guest-Only counters
  - VMRUN: Disable Host-Only, enable Guest-Only counters
  - VMEXIT: Enable Host-Only, disable Guest-Only counters

Jim Mattson (6):
  KVM: x86/pmu: Introduce amd_pmu_set_eventsel_hw()
  KVM: x86/pmu: Disable HG_ONLY events as appropriate for current vCPU
    state
  KVM: x86/pmu: Track enabled AMD PMCs with Host-Only xor Guest-Only
    bits set
  KVM: x86/pmu: [De]activate HG_ONLY PMCs at SVME changes and nested
    transitions
  KVM: x86/pmu: Allow HG_ONLY bits with nSVM and mediated PMU
  KVM: selftests: x86: Add svm_pmu_hg_test for HG_ONLY bits

 arch/x86/include/asm/kvm-x86-pmu-ops.h        |   1 +
 arch/x86/include/asm/kvm_host.h               |   4 +
 arch/x86/include/asm/perf_event.h             |   2 +
 arch/x86/kvm/pmu.c                            |   9 +
 arch/x86/kvm/pmu.h                            |   4 +
 arch/x86/kvm/svm/nested.c                     |  10 +
 arch/x86/kvm/svm/pmu.c                        |  84 ++++-
 arch/x86/kvm/svm/svm.c                        |   3 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/svm_pmu_hg_test.c       | 297 ++++++++++++++++++
 10 files changed, 412 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_pmu_hg_test.c

-- 
2.52.0.457.g6b5491de43-goog

