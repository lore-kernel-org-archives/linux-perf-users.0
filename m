Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479802;
	b=sY0LQLHNgEUmuJ8llUgYgJmElzAVQKLN/uYFL0cXq86O0nsC9kVfowo1t5qKGBRcAxLC
	 Oed93Op/bQttUCYAi/V2H16R2MZSwQcdU58tHhWRAtGN8pTgzy3q1fuIajJO+LKFNnjpI
	 V1JktGsPI8KPn+UFE548tNXmOx6079sTuxvSujGQRd+X5iSRo1hSgpNt3AQ4gbpKiyQ8E
	 /hhPwFvYfZLRoGPAQTNGHdIf6vRu09pDz/ueiy2RO1Xsf7gz/OF09wcZXF4FGjZrYGWZ7
	 3UN8iNMELAmFLbS8plqLdHcPLXpnHZzlwp+isy8WN2HiXHDobHO4h9KYXjoseZE7uxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479802;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qtib51ffHxqRQT/emHOSN0KnkH+oE4jKOtAC4nasmyo=;
	b=CuhowIqEfRPAj54ChmSatCxXQpYJa32aO7XNNnO2QNkpN2ijxoYPZ3BM8bVhIsUrceiI
	 YG5x5IxbXC/MSUhvPic33UXSePE9wlzTyKC2e8pzSiy/AEkJ4dYk+fpiuxACFJD6bGymV
	 LmNJgoFGcoHUKK1aIC0BCCz3c2i569J7HGEc0riCqYJXXQUQvXNI2n1zOWNQF+06zMM71
	 n5oLUIfE1iW2zUdaQObgLU7s274P75eOWlRJyVqWqayHuZc+RE3HUqfhCxmrBXxov8DTZ
	 wxCTJic/x69QkOT1FIF99PRs1v3KYuZVnR8ELVQjph+xkzOZq9OIMs0vCuT2LcXzWOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="H/ywA3VI";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF3760A381D;
	Tue, 24 Nov 2026 00:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H/ywA3VI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB711F000C0;
	Tue, 24 Nov 2026 00:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479801;
	bh=qtib51ffHxqRQT/emHOSN0KnkH+oE4jKOtAC4nasmyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H/ywA3VIWXboWCAZ0+iXfwcCUtrzEMI4VWBeSCsBlENCxoAv60SuDF3wkNVU+ofQA
	 W+vJaSC+yRnLtunpi+vLtQXv8mTtvp7dexkJYfdRoRRWF67UGUXlFe+pfLeiKHXIG9
	 KJDLHr1vWxeBLIKeXiNziCiK6wCT2V0ZjXnO/kKnL+9M2Gz/xkiASQJXFBcFUs3YGD
	 vRrrxkxG2DrLMvvJME5zdZVJmbPP8ul8tqoNY0jLjjocCV1zL7xjhFVJ5CbPlpvpcO
	 2sHtpSSd+B+P+YkubX4p6W4M85DxZf82/soul9e41gmhSlizC1DFbArTIp7VBYSRZJ
	 NzAdhivfVdZgA==
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
Subject: [RFC PATCH 09/26] perf/x86: Reclaim the mediated PMU before clearing dirty counters
Date: Tue, 24 Nov 2026 00:22:46 +0000
Message-ID: <20261124002303.1785363-10-yosry@kernel.org>
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

perf_clear_dirty_counters() zeroes PMCs that aren't assigned to host
events before enabling RDPMC for a task, so that it can't read stale
values. It doesn't go through remote_function(), so it doesn't reclaim
the PMU, and if a guest's mediated PMU context is loaded, the "dirty"
counters hold guest state that clearing would clobber.

In preparation for KVM leaving the guest context loaded with IRQs
enabled, reclaim the PMU before clearing dirty counters. Do so before
filtering out the counters assigned to host events, as host events are
scheduled out while the guest context is loaded, and putting the guest
context schedules them back in, assigning counters to them.

No functional change intended, as the guest context is currently only
loaded with IRQs disabled, where perf_clear_dirty_counters() never runs

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/events/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 4e344fb1ae3ed..95ebdec4d5f5d 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -3026,6 +3026,14 @@ void perf_clear_dirty_counters(void)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	int i;
 
+	/*
+	 * Reclaim the mediated vPMU from any loaded guest context before
+	 * accessing counters to avoid clobbering guest state.  Do so before
+	 * filtering out assigned counters, as putting the guest context can
+	 * schedule in host events.
+	 */
+	perf_reclaim_mediated_pmu();
+
 	 /* Don't need to clear the assigned counter. */
 	for (i = 0; i < cpuc->n_events; i++)
 		__clear_bit(cpuc->assign[i], cpuc->dirty);
-- 
2.56.1.809.ga0b61035b5-goog

