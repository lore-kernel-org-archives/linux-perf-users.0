Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705942765DF
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Feb 2026 01:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770427434; cv=none; b=SGJJ+EYAjfZRe91FT3iqLechFZZoCS3KBlyFAST5IPHZousvs5nT82y93n8Xav/XxqXpFpr0MiqTKQ93eNHzqc6tLPj0Z6wDzHtf3YDPEmL1oGmMQtE3Ir4h9yV/Qb/x5QAYy2kXL4CHzIUmXpocbRriNS9p3ntWsw1YubaqvoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770427434; c=relaxed/simple;
	bh=dbXNLQnXNLyXQ9CT/B6ZGUFhbJ3b6yLRqpkwxAjNO5g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CJ3+clnqpYlM486KnTTKwsN9rVVSEVL35bmqJcz3+xdY/XKtejkkyag/GBD9WP91U7k2wWNchceUigg6qpvG3eUuGcRTjICYqvKcM/55byEBNPhyCXzM2lTikMPD8WT6+viSOXrwV2VnCx/HnqcYLQOGowJsgJMy1Cytb/UFNts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SLGclmpL; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SLGclmpL"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c5291b89733so1560372a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Feb 2026 17:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770427434; x=1771032234; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zx9cflBOvMN2Fre5G6WHM7bbDYv06YwaCyO7rWPF26U=;
        b=SLGclmpLSC5f+b2lHOUddrZVZntDo3NmvP7g8ZpcA99lvnk2/5gz252p8Cui8qb0RV
         GfEYuAgo0K8EwxLGbYja5FywWyGgA04Ghim2Nb66RhtkxQqmIib57ppl5GWglEzd3BSd
         GIQc7Lg5fnzfaJRd3uVjCiICz8UJjbXfnRGocVWrqfb/DYV+lYF0bcsqW9pg2zeeGUn1
         +iqNnpMbeO5kRWPr9fBb3yJF0grnkksUgBaU4DsLPWlkmGaU4znahdlMhxYB/nu8QYkv
         DHiwGnaOr/6YApP1yBoI5+5F9++SBnGbC71YwgSPM4qeBe4eNZUJup863BWlb9vNp0z1
         StQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770427434; x=1771032234;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zx9cflBOvMN2Fre5G6WHM7bbDYv06YwaCyO7rWPF26U=;
        b=mnJ7xVc91NxsfQwkdcjEKzjk7KOuVCMmvjM25SuJosXVVuqE6YevXDqhjuG+0nmsu+
         EI7rOllMK8C4+s4UO9Lfn03Tw6+5QnnCBR6bHysPZgtsTGmsYWIfeySoqjI6ZRvsGDwQ
         ZzkjhqQ9xRD8GBa7zPby9mpofwqvwyDQNO+aqkUXj/DuJdLw6jphfuSIkXYSMz2Kskva
         rV2DlmwwVUgKQF/oC2B3qIDi8MN9I8WuBQ2tynzZasKEnUGe7sq5JoPXtUfiRR0aAE8V
         dOhEAx6bfz3xKWsJt6YZrPNJlbP/6Z5Riv73QaLBqSEdLbNvkplJBwBVl3wG3oxmt9v2
         s2pg==
X-Forwarded-Encrypted: i=1; AJvYcCXlfJ+leDneKxf2OgQzmL81I1BzdFyVVFWB0wdz0Av/9OohF1QqsIIkKk3rfbCYNIJ8tjLJA/yPuHEDL3HCSI1I@vger.kernel.org
X-Gm-Message-State: AOJu0YxhdlYuFCPgVLQTSghzkw6U3lZrAlTVOsmBVGpgXliy5Hqxwr8P
	rAp5F/DJHlcStK/b2A/gn1tKG23+JobHdocgQdHMEWwIH0R7kEI79V8QgNgmsKUwRPz8nFgtVPq
	okGzW2m7amnv6cA==
X-Received: from pgbdo14.prod.google.com ([2002:a05:6a02:e8e:b0:c62:b045:9c6])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:681:b0:38e:c1c3:b1ed with SMTP id adf61e73a8af0-393ad33ab08mr4698774637.44.1770427433658;
 Fri, 06 Feb 2026 17:23:53 -0800 (PST)
Date: Fri,  6 Feb 2026 17:23:26 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260207012339.2646196-1-jmattson@google.com>
Subject: [PATCH v3 0/5] KVM: x86/pmu: Add support for AMD Host-Only/Guest-Only bits
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

v2: https://lore.kernel.org/kvm/20260129232835.3710773-1-jmattson@google.com/

v2 -> v3:
     * Dropped the svm_enter_guest_mode() and svm_leave_guest_mode()
       wrappers introduced in v2 [Yosry]
     * Introduced a generic nested_transition callback in kvm_x86_ops to
       avoid confusing SVM-specific wrappers and unnecessary code replication
     * Fixed a latent bug with L2 stack alignment, which was triggered by
       a movdqa instruction in l2_guest_code() that referenced the L2 stack.
       Note that l2_guest_code() expects the stack to be 16-byte misaligned
       at function entry. It was not.

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

 arch/x86/include/asm/kvm-x86-ops.h            |   1 +
 arch/x86/include/asm/kvm_host.h               |   2 +
 arch/x86/include/asm/perf_event.h             |   2 +
 arch/x86/kvm/kvm_cache_regs.h                 |   2 +
 arch/x86/kvm/svm/pmu.c                        |  42 +++-
 arch/x86/kvm/svm/svm.c                        |   3 +
 arch/x86/kvm/svm/svm.h                        |   5 +
 arch/x86/kvm/x86.c                            |   1 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 tools/testing/selftests/kvm/include/x86/pmu.h |   6 +
 .../selftests/kvm/include/x86/processor.h     |   2 +
 .../kvm/x86/svm_pmu_host_guest_test.c         | 199 ++++++++++++++++++
 12 files changed, 264 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_pmu_host_guest_test.c

-- 
2.53.0.rc2.204.g2597b5adb4-goog

