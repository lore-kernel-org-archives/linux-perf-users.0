Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479808;
	b=2DLtdar9oYHwvXTZrykwabDLGIFYk1GL34OJFf6B2zyRjn9/PHHMHeCbpnot5XOMVe/I
	 8PtImrQxL6vZt9fhtUkZhh3Br1/jwNhGBewWw68Bf3hTslSKBYgQAF9DP5aBkTV3aL/eg
	 7xAXBtOa4OKHXCH97osntDFyYqPBPvFjI3ZPXLdKQKKWCMP39/ZHBckwT0IWRJZNke2fJ
	 HKeqp7mfFYRRJmcSEFbWsMDK5XfupU/H9XK4BswLr8s39hZuzMfc1y1gKhN0kborf/NZx
	 RBTYkZKfvUlYKoEQw3YaBFoLnMJQqPn/jBBXU28MZKA8OnsYM7yVk04FsHGDOZP57og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479808;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EYXC1i6VjI5xGadjPaWJoS80C15C6dTLqBMJAfut4rM=;
	b=csAxBaazAJ57NYwo/FG6Sk5P2wC7Y7kXPVjC5L6nyLDIOprWvSNy0XUtIQ0yg+JQIbdl
	 AtVdolki6aJZ43VOVV5r9Y2dS/gEDG7fjK4+9kJIX6SJAUhu9wqPs69k9sbWRmEsEBDyR
	 gfLhA8l3Kmi+zmI3qJ2saIB5KDJVgpStPLp5eQppUk1h/UQhzb58IEaKqsldsZ+YZOGjJ
	 kzE+ce9R+Mq+BetQBDtSkdFvPdGXSPejBEMZ+OXCMVKJMzeA4XXWkGtdQmL2Kigab0+aU
	 hN7Zg1Zj2VKv/fY/mdq85I69maXeCdfp4XvlHO5r/p+xjrHmPG5Dlfx9+4kBX7ihKEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m2u7qplt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982AC606A696;
	Tue, 24 Nov 2026 00:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m2u7qplt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DCDF1F01579;
	Tue, 24 Nov 2026 00:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479808;
	bh=EYXC1i6VjI5xGadjPaWJoS80C15C6dTLqBMJAfut4rM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m2u7qpltQiLyJbIT4oNBVKDjqDL4FKAfVzaghXcnRms3MtH59gYky/9K1hqeOwiP7
	 Lezn/1B+cY+htaEyk9OioJJ5wFFXrLmpukilgoSLrAepK8jrzU5ZFw1hAdXTW2rrRC
	 XJ1b2OKEOp5ijWhdYmFJDc8/Ewo/Ea7lbUscurAN9/5GmiUHGQNagMFnSEoD0rRs/g
	 fFCpHF0tEbqcRewuOejuEzVEVn9tzShcte/zAAddptcqh7S7m9pM5qNNoei8jKXffC
	 5CxSdtib5dyUWZ/tCARFmK6J2YpVQS/N5ufItNMSNBl+AK7E+62tDkUfocQvASbb2z
	 68SP4wEvU8XgA==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mingwei Zhang <mizhang@google.com>,
	Jim Mattson <jmattson@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [RFC PATCH 14/26] KVM: x86/pmu: Zero eventsel_hw for counters that can't count
Date: Tue, 24 Nov 2026 00:22:51 +0000
Message-ID: <20261124002303.1785363-15-yosry@kernel.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
In-Reply-To: <20261124002303.1785363-1-yosry@kernel.org>
References: <20261124002303.1785363-1-yosry@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When reprogramming a counter that can't count, zero eventsel_hw instead
of only clearing the enable bit, so that putting the guest context
doesn't need to clear its event selector in hardware. The guest's view
is unaffected, as reads return eventsel, and the counter doesn't count
either way.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/pmu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 0a5299532c086..44d947b854b9c 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -576,7 +576,11 @@ static void kvm_mediated_pmu_reprogram_counter(struct kvm_pmc *pmc)
 	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
 
 	if (pmc_is_gp(pmc)) {
-		pmc->eventsel_hw &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
+		/*
+		 * Leave eventsel_hw zero for counters that can't count, so that
+		 * they don't need to be cleared when putting the guest context.
+		 */
+		pmc->eventsel_hw = 0;
 		if (allowed)
 			pmc->eventsel_hw = (pmc->eventsel | kvm_pmu_ops.EVENTSEL_HW_SET) &
 					   ~kvm_pmu_ops.EVENTSEL_HW_CLR;
-- 
2.56.1.809.ga0b61035b5-goog

