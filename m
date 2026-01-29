Received: from mail-vs1-f73.google.com (mail-vs1-f73.google.com [209.85.217.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7A6337BB5
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Jan 2026 23:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769729851; cv=none; b=UdfPLifOw+DxDhuDXp3ZgIT3L3mDZBP2Sc/hjTNG+vC2BeMGQcK2AYi7H2KiuZn56Rd2HFv0l0CEWJSDo1uUIX9QkzsRySrWqg+OijivTXy7p8DS+VbXdz95u0AZjaiyByj/rJMA4hPTBGXA+pkAL3m/04/cT63Jo+t92ulpQEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769729851; c=relaxed/simple;
	bh=62qGoba01/4xKWg0SglqZtm4/p5doWh/TYXL8RIiyWM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XqvszXIZsc39LlMk8KxA4KyXIHQ3bcXU39eBhQdeWMYaLb0LOxny3J6MEBWTRDWBdDzTaL/95jjASoxlXW6WhvR1S/Wc5ez+LFko/74Me1xGRd6eXS7MgdQ2ShltZVWAo0e2rQSUXTlRHkxSRYaBGIY6jraa+6RQIXz4C+cMvkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G3iQZIhn; arc=none smtp.client-ip=209.85.217.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G3iQZIhn"
Received: by mail-vs1-f73.google.com with SMTP id ada2fe7eead31-5f8e0011662so1415592137.2
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Jan 2026 15:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769729849; x=1770334649; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HJBNjw3RNtSCw9MLJW2nzX+EmjmcAxr1O5/9KOr8e5k=;
        b=G3iQZIhnJ0exA8Cp8Ozixv5hoq596uJI/UaG7GntX/8msFr6+ok6WF+8b7jQaG1Uu5
         oTldMeBTxQq2874Q+n7BHzNcv6KyyJ4JoiMSnwWeGrHZYjXjyOBWo7+v+VxP+aBtBkzM
         C1O/fHZ15kxenFBgzfp3I8iVT+R3lHESxjKGYMcL720BT8C0vBNxC/xlNuXTMykrodMl
         5fCQv1F49b37++mn3CTYSeSapfaY0DNj/FmU8DG+MdKJ/+VlKuBbvkdZRbUBWY1+8TJo
         Ym4C1fxP6phxXjJbDkTB+fPMzpB8EBwCQqS+OX6Cks/pjun10FGxshp4ySpG6NuBJ8Z6
         sgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769729849; x=1770334649;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HJBNjw3RNtSCw9MLJW2nzX+EmjmcAxr1O5/9KOr8e5k=;
        b=YEMYOmijM/w33ErO6vzxQnfyNDNGvyL8L7LWUJyUVrTz7jP5xIP6PK0pasuWUtm1Ic
         A3TVLgX+ydE2U9Y7TWEJCXeDd6l8wMbnx3jSRFj9pUCcvn154vcbGo+XKXSnFPkU5mQp
         c5vptVAW1tqSocY9UY6hnSJf6CRI8EeQQM1z8fAhyXJUrqYVSvP0+0DNNgqU/4sInNaU
         0OZSIryF5dZWdxG5eFSAStKikx/xU6O6jh7oHK6WLZkFOU3qDuJzZeZ644yWmA33aRN1
         x/JfwOsoUSj47RKc7kbxESftWaCn7Z0R95NqIVm7rW4VVjQePivPqoJXMSIwGpN44oeW
         Xraw==
X-Forwarded-Encrypted: i=1; AJvYcCUhtjb9WMuAUt7bN8JH9LCKRo5WHYju6LoiWv2Hjbi5pc6/kh6XmzMyVP82ni8BqgK2rHQ3JaXARKzAHUOAzxnr@vger.kernel.org
X-Gm-Message-State: AOJu0YwfDUxghQfm6sSjm74644Bmgor+TnNXJ4wmu339ppPbIKf52QXf
	SiUULLykF1QLM/Wvw+hoHfEK3TMQCbTmGEvv70TcLaKnjiU+yIETN8G7N7S9Vt/iFUlBSmcgeM9
	zAiP1m2RZDE11oQ==
X-Received: from ploc15.prod.google.com ([2002:a17:902:848f:b0:2a0:86eb:ac5f])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:cf01:b0:2a0:d629:903c with SMTP id d9443c01a7336-2a8d992f074mr7921925ad.30.1769729340083;
 Thu, 29 Jan 2026 15:29:00 -0800 (PST)
Date: Thu, 29 Jan 2026 15:28:05 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260129232835.3710773-1-jmattson@google.com>
Subject: [PATCH v2 0/5] KVM: x86/pmu: Add support for AMD Host-Only/Guest-Only bits
From: Jim Mattson <jmattson@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: mizhang@google.com, yosryahmed@google.com, sandipan.das@amd.com, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

This series adds support for AMD's Host-Only and Guest-Only performance
counter eventsel bits in KVM's mediated PMU passthrough implementation.

These bits allow an nSVM-enabled guest to configure performance counters
that count only during L1 execution (Host-Only) or only during L2 execution
(Guest-Only).

KVM updates the hardware event selector ENABLE bit at the following state
transitions to ensure counters only count in the appropriate mode:

  - EFER.SVME changes: Enable/disable Guest-Only counters
  - Nested VMRUN: Disable Host-Only, enable Guest-Only counters
  - Nested VMEXIT: Enable Host-Only, disable Guest-Only counters

v1: https://lore.kernel.org/kvm/20260121225438.3908422-1-jmattson@google.com/

v1 -> v2:
  - Fixed various style issues, including indentation, comment
    placement, and comparison to 0 [Sean]
  - Replaced "hg_only" with "host_guest" [Sean]
  - Reversed the polarity of the dormant/active logic [Sean]
  - Removed the pmc_hostonly and pmc_guestonly bitmaps [Sean]
  - Added a refresh helper that iterates over PMCs during transitions [Sean]
  - Introduced svm_enter_guest_mode() and svm_leave_guest_mode() [Sean]
  - Moved transition logic from VMRUN/VMEXIT emulation to the above [Sean]
  - Moved architectural definitions in the selftest to pmu.h [Sean]
  - Added a test for neither Host-Only nor Guest-Only [Sean]
  - Refactored the selftest to program all 4 bit combinations
    simultaneously, reducing code replication [Sean]


Jim Mattson (5):
  KVM: x86/pmu: Introduce amd_pmu_set_eventsel_hw()
  KVM: x86/pmu: Disable Host-Only/Guest-Only events as appropriate for
    vCPU state
  KVM: x86/pmu: Refresh Host-Only/Guest-Only eventsel at nested
    transitions
  KVM: x86/pmu: Allow Host-Only/Guest-Only bits with nSVM and mediated
    PMU
  KVM: selftests: x86: Add svm_pmu_host_guest_test for
    Host-Only/Guest-Only bits

 arch/x86/include/asm/perf_event.h             |   2 +
 arch/x86/kvm/svm/nested.c                     |   6 +-
 arch/x86/kvm/svm/pmu.c                        |  42 +++-
 arch/x86/kvm/svm/svm.c                        |   2 +
 arch/x86/kvm/svm/svm.h                        |  17 ++
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 tools/testing/selftests/kvm/include/x86/pmu.h |   6 +
 .../kvm/x86/svm_pmu_host_guest_test.c         | 199 ++++++++++++++++++
 8 files changed, 270 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_pmu_host_guest_test.c


base-commit: 1a424e9e0616db91010f08e5985bcc6edc504205
-- 
2.53.0.rc1.225.gd81095ad13-goog

