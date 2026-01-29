Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBF837649E
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Jan 2026 23:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769729345; cv=none; b=XhzIpn34SK+Edk0BbdCe8zaootj2zCS7g0hPsmYNLN6jE5fr8gFde/BQm4Pi2E+h+lD1RbH5DEVht1EFpFbRdvVjU6a1gyXWNJYAeWuW45WKI5j1fzRQjE2RliGoPMX4WHaIP/6g1whRZY1AZXuGVq3WTqGtYe3FcH0UB2HfVAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769729345; c=relaxed/simple;
	bh=rxUIt+q7usKdyM83oKGeQOrRZ8jjXQg7Zut/P6eD5vQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pr2zBRcUgaW5pJnqk+N3qpOZEKhBXce1/tALBw9XKQfqtkllO8YULxsJOYmWixtO/0nUy1KoL2RO3pbSpJuMdn2aXjjp/hNkEFsMiioctHBmQg54cTCCVqluMNWuaznfKiglzTM+0L+scvwyj4nN+ZoClHWj72idmUjE51QkxzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iYXjNALK; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iYXjNALK"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-353c9d644b0so1091197a91.2
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Jan 2026 15:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769729343; x=1770334143; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kJF3W6JKHBnrv8F/Fuh9dIOMXuUt3tlkhxE5lP4gDnc=;
        b=iYXjNALKQ8O1HQZYHDQ0LHCC0KceNhjV2qSJkGPmIvgbrCPwCtV51TaB61q07UztNz
         +5lkzS3/VULs1EuR3EMS1Xcc9MuM+21OwyTXNr05gbMxNncjiAfZqi3pYuDw9v2WvLJu
         zQOjaXiD2c5UvXiyzzLJ3YiANbOgOnFMboo9ZyH23f0LX3U4UOiVdYWWMGpaVSzZv2jB
         vftLHxN6kqRrCbwEB7Uo39senSQPnfVc74luO/HkAKYy8nUzTuEEGAYmjUq1QNrT8yr0
         LRZlkM40PWVvnES7MXFkhBwq1LpLTB2t+ajELA9jvSvV1TQRG/Pe9XKJyogkxhCrsqbB
         XpNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769729343; x=1770334143;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kJF3W6JKHBnrv8F/Fuh9dIOMXuUt3tlkhxE5lP4gDnc=;
        b=JY0sG1vghbJWAeZ4dDnjYzepuJzXU6tvFN+dK+XXF4WTdPmBnwB+prfHkLkA6GSMxL
         PpdGbntxg5evh+9fANWNsZvNzvGVlqvE5Cs79lf1nqnBYrewTSMZ9qBSR2+rirdDCgR4
         Q+qMn3qGErlGuyuC+je2P8ZqVzc003KLwvPvuwKogKM0j4NMaZMQj19cux7Jy1gFx81O
         /CT05YcXStKstm+4K4+1RStw6BUO71MrQI+zBxno5uWzyIM+DfGP3aWrzqogbUBj7X37
         /vrms2mrXJbPu82xKGX2ZkJQEkUQJldkBqW90UVZKsFOLBvbgOIC2BDueA1utEpdSc9k
         C4dw==
X-Forwarded-Encrypted: i=1; AJvYcCXQVNzwNW12HuptcU9SlqXUAbdBJJQhz8795SB56WAgL1ztDKmnIEOqu5iABjdW3TwbiFPT2FBd5YP1QwcYJ9lt@vger.kernel.org
X-Gm-Message-State: AOJu0YzPuFA3gWN5F/Ebg7RyrzH3+MEgChmmDylbL6vKMOkq3xkX9v/R
	/UYAZUlQn/jculOE6buHc4XlXFx6yGRz79HKBidB1gigJ/Yvol7HBgo48yGs0EMg/zgLdmvw4Qb
	TjGv8wzZGER92Pg==
X-Received: from pjvf5.prod.google.com ([2002:a17:90a:da85:b0:352:d19a:6739])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:518e:b0:34f:62e7:4cec with SMTP id 98e67ed59e1d1-3543b2e00c9mr820536a91.5.1769729343203;
 Thu, 29 Jan 2026 15:29:03 -0800 (PST)
Date: Thu, 29 Jan 2026 15:28:07 -0800
In-Reply-To: <20260129232835.3710773-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260129232835.3710773-1-jmattson@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260129232835.3710773-3-jmattson@google.com>
Subject: [PATCH v2 2/5] KVM: x86/pmu: Disable Host-Only/Guest-Only events as
 appropriate for vCPU state
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

Update amd_pmu_set_eventsel_hw() to clear the event selector's hardware
enable bit when the PMC should not count based on the guest's Host-Only and
Guest-Only event selector bits and the current vCPU state.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/include/asm/perf_event.h |  2 ++
 arch/x86/kvm/svm/pmu.c            | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 0d9af4135e0a..4dfe12053c09 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -58,6 +58,8 @@
 #define AMD64_EVENTSEL_INT_CORE_ENABLE			(1ULL << 36)
 #define AMD64_EVENTSEL_GUESTONLY			(1ULL << 40)
 #define AMD64_EVENTSEL_HOSTONLY				(1ULL << 41)
+#define AMD64_EVENTSEL_HOST_GUEST_MASK			\
+	(AMD64_EVENTSEL_HOSTONLY | AMD64_EVENTSEL_GUESTONLY)
 
 #define AMD64_EVENTSEL_INT_CORE_SEL_SHIFT		37
 #define AMD64_EVENTSEL_INT_CORE_SEL_MASK		\
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index d9ca633f9f49..8d451110a94d 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -149,8 +149,26 @@ static int amd_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 static void amd_pmu_set_eventsel_hw(struct kvm_pmc *pmc)
 {
+	struct kvm_vcpu *vcpu = pmc->vcpu;
+	u64 host_guest_bits;
+
 	pmc->eventsel_hw = (pmc->eventsel & ~AMD64_EVENTSEL_HOSTONLY) |
 			   AMD64_EVENTSEL_GUESTONLY;
+
+	if (!(pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE))
+		return;
+
+	if (!(vcpu->arch.efer & EFER_SVME))
+		return;
+
+	host_guest_bits = pmc->eventsel & AMD64_EVENTSEL_HOST_GUEST_MASK;
+	if (!host_guest_bits || host_guest_bits == AMD64_EVENTSEL_HOST_GUEST_MASK)
+		return;
+
+	if (!!(host_guest_bits & AMD64_EVENTSEL_GUESTONLY) == is_guest_mode(vcpu))
+		return;
+
+	pmc->eventsel_hw &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
 }
 
 static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
-- 
2.53.0.rc1.225.gd81095ad13-goog

