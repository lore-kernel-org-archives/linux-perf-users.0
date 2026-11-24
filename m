Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479825;
	b=XyTwn19QhJ0jHUTWJ5RaihIGtpnNMrDNwVrO/C7D54/3fS7ybKCbiWx7NDO77U/AIwFG
	 fErbS6C7a8sV/fwWgLvylZNeG/HfXHpU30AABCmAHW17w4rwEZ+s3pVdgvEmOWfa3xR5K
	 44MTA2Chp4sHEPDR9q466zMUP2sQDQAUweeYxQ42KsBAhiCBKYuT/J5l3TcblW/a4rz+G
	 dLYtMPmItGN8ACcNZ2tzlKz7aKUlj/jHz4i9yntuI7UhyAZdkGCEwsRGkAgcBXEET7DtR
	 XIxurvcspGQi2d+XmYpYOSniZSZqLRUFSqBi3qCEYgta4OZuO5I2KPvu4aSqjjPiSFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479825;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Dqo+VaVAcBDqFbUtkZs3V8zd3QE8nq/u9qbTdMexD50=;
	b=PC6yedIFmLjXpwKPTQDlLfFk70NkC+AsSaO1LrMsz0hWaVOdF/Bu94jM3saGqbo71X6k
	 x1luI8yPsS5x0pV+s40tXP7Sz+8MOmPWRwUKxanywecv0fNi3eko5PX7nxvuVqh5TriC6
	 vi9CbLwwxpi4myyfYjgnzSmyLuM7IbSU3v32nvS45c3l6D7KixjW/FQmo555tXbJQgpFV
	 XUmAHPqkLSL5BIXqV1a5osvFaWEWq5gxBeaT7Zta6RIILg/tV6R6jpRGfHibOWfiNPYqw
	 o9Vh1hd7Xqdjd8VcgBpFeEFUGnl9wioZ1cm4CjfbRR4FCCjXYr0W2hNUKQp2Zj/LLVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FWkVkpn1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E3160A2639;
	Tue, 24 Nov 2026 00:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FWkVkpn1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0B51F000D2;
	Tue, 24 Nov 2026 00:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479825;
	bh=Dqo+VaVAcBDqFbUtkZs3V8zd3QE8nq/u9qbTdMexD50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FWkVkpn13FbDI9b+PvKsAff03sPBNgOdmvPYXPs6Yw795w98D/Fapl8aRa7EiYcax
	 dgowp+nETDfFYlftHdJZXyaxnowx4UtQuNZUMZWHdTJdLtOaFZGDx5r7amtgrHiGwM
	 Z6DS8CZgd859dKCbUVU72W93WepGqNngOr60Moit2xQtNFS9h4grzqHxmqM5RM/b77
	 QZzZx0EkjAm77Mo2HLlzdIZKS5jq55HxAlqj+mIYEq7qJUioOWSFFINscbJMw44F1+
	 tfjEWbjHGDk7J2KE+bEjOO+n3jP9B0fumaM5GqJb7QTQDA5uh5LmiaFIETsgHY7kOm
	 Tb1AyziphzoBg==
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
Subject: [RFC PATCH 25/26] KVM: x86/pmu: WARN if a mediated PMI arrives outside of guest IRQ handling
Date: Tue, 24 Nov 2026 00:23:02 +0000
Message-ID: <20261124002303.1785363-26-yosry@kernel.org>
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

Guest PMIs are delivered to KVM's mediated PMI handler while KVM handles
IRQs that are pending after a VM-Exit, either because the PMI caused the
VM-Exit, or because it was raised right before it.  Guest counters don't
count while host code runs (GLOBAL_CTRL is cleared on VM-Exit on Intel,
and events are guest-only on AMD), so guest PMIs shouldn't arrive at any
other time.

Now that the guest context can stay loaded while host code runs with
IRQs enabled, a PMI arriving outside of guest IRQ handling would most
likely be raised by a host PMU that perf failed to account for as
conflicting with the mediated PMU, and misrouted to the guest.  WARN in
that case to catch such bugs.

In theory, the WARN could fire for a guest PMI that is delivered late,
e.g. after KVM is done handling IRQs following a VM-Exit.  Checking the
guest's GLOBAL_STATUS for an overflow to rule this out doesn't work as
the guest can clear it, making the WARN guest-triggerable.  Such late
guest PMIs haven't been observed when stress testing on 8 different
platforms (Skylake, Cascade, Icelake, Sapphirerapids, Emeraldrapids,
Graniterapids, Genoa, or Turin).

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/pmu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 80229f3d477fb..b1f949b9e05b5 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -220,6 +220,14 @@ void kvm_handle_guest_mediated_pmi(void)
 	if (WARN_ON_ONCE(!vcpu || !kvm_vcpu_has_mediated_pmu(vcpu)))
 		return;
 
+	/*
+	 * Guest PMIs are delivered while KVM handles IRQs that are pending after
+	 * a VM-Exit, as guest counters don't count while host code runs.  A PMI
+	 * arriving at any other time was raised by a host PMU that perf failed
+	 * to account for, and was misrouted to the guest.
+	 */
+	WARN_ON_ONCE(vcpu->arch.handling_intr_from_guest != KVM_HANDLING_IRQ);
+
 	kvm_make_request(KVM_REQ_PMI, vcpu);
 }
 
-- 
2.56.1.809.ga0b61035b5-goog

