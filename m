Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479799;
	b=im6TxHBoUT1z9z14Re1gU92SvpHx1FktjqR1fMnQ/eqzm6bjUdbPjZWq/DUhwuSGzMGZ
	 C0k2Es3Y66vUrOs8f/PMx9BJVANUZGh8n6nogK3O8tXLmTxhIxPyRG1+skhsbX9wzbroe
	 avNi6DtacBb184+28SIsgc/n1E4NRzEjz6V+j4fK+Glw+vVaWCHrOB1wdGn8LFDSpzCBn
	 RXoIzV+Imaduuos9nBpvvAoQbfeTBDaeCFAmd5brodnLueTDxpEjnZ6+SIsmmithZnXlw
	 AEx2mYEE5hN/IW+n5u+8m9gJ3X1d7IkeXBpq2hU6Myv4MttiIa8UQMCY3VGSByK8i2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479799;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tjyY6GwVdj2VKGCecW19Na2zt6pBinSEXuE2OIL7FYo=;
	b=DstbykoQEqEHJV68NNOyCR3VPIuQBYFoMjesg6e605pgvNxoeG18CoWo3D1n3XTTz61H
	 qOYoA6X2IMf2Fy/JE+j8+okc2Rd8z9/zRE0jeq1RXqLTO8XiAs518NINCHAL24yYjlR9n
	 QXmggcMCYx3QnjaCkoG2Q9+TSoe0SIIhqIOW2QStwyUafHxgPojH6QyWzhRrtzPUFUy52
	 Qdh3hVrOih8JCsbZZmGVM7b8wZ4vpG5IbL1vUk30UiaJS8ibTzPU2xWvwmtpY8rHWTBui
	 X7oufgGs3L/1OM995EMAVK43zVXX7qpc3BxhRQ06AjLfjvMZ7AtQNF17oytRbc38Qaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N52ThKN0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EAF606A6A8;
	Tue, 24 Nov 2026 00:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N52ThKN0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D85A1F000C6;
	Tue, 24 Nov 2026 00:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479799;
	bh=tjyY6GwVdj2VKGCecW19Na2zt6pBinSEXuE2OIL7FYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N52ThKN0qWd+NiJ8JEKzFa6aD8NJenaPYF6vVJ/Sz9S+GQisTbDvbuW+85448PR1e
	 AybVtm1iSZ2JiSvIEv07LS0ul767Wls79qadp60fvHo5+So4aJTQIEdqChnOZXJpoe
	 VlpSEQsVGUDxzDTPLyAkPglyx/x+Zw4BhVOABunYEU6Aq2FWMsl5OzToNFT8FYyDVD
	 r1UJa65wFfFFFO3cSU4lDke53GqONf+SvN/d3EF73gr0m4A/BG5hnKI7+dXHujFRey
	 6OYDFepvI5YX0t3vh5UGXD9AjP0oNVLcyKlfDqva/3rGJLl2YaN4nZCrlGLPSc+HYu
	 1ogPC53mKudWg==
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
Subject: [RFC PATCH 07/26] perf: Add a guest callback to reclaim the mediated PMU
Date: Tue, 24 Nov 2026 00:22:44 +0000
Message-ID: <20261124002303.1785363-8-yosry@kernel.org>
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

Add a reclaim_mediated_pmu() callback to perf_guest_info_callbacks, for
perf to ask KVM to hand the PMU back to the host on the current CPU.
This will be needed once KVM keeps the guest PMU context loaded beyond
its inner run loop, i.e. with IRQs enabled, where perf can end up
touching the PMU (e.g. installing new events) while the guest context is
loaded.

No functional change intended, as KVM doesn't provide the callback yet.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 include/linux/perf_event.h | 7 +++++++
 kernel/events/core.c       | 6 ++++++
 virt/kvm/kvm_main.c        | 1 +
 3 files changed, 14 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 5ecd477bd6969..a83b9f2785301 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1685,6 +1685,7 @@ struct perf_guest_info_callbacks {
 	unsigned int			(*handle_intel_pt_intr)(void);
 
 	void				(*handle_mediated_pmi)(void);
+	void				(*reclaim_mediated_pmu)(void);
 };
 
 #ifdef CONFIG_GUEST_PERF_EVENTS
@@ -1695,6 +1696,7 @@ DECLARE_STATIC_CALL(__perf_guest_state, *perf_guest_cbs->state);
 DECLARE_STATIC_CALL(__perf_guest_get_ip, *perf_guest_cbs->get_ip);
 DECLARE_STATIC_CALL(__perf_guest_handle_intel_pt_intr, *perf_guest_cbs->handle_intel_pt_intr);
 DECLARE_STATIC_CALL(__perf_guest_handle_mediated_pmi, *perf_guest_cbs->handle_mediated_pmi);
+DECLARE_STATIC_CALL(__perf_guest_reclaim_mediated_pmu, *perf_guest_cbs->reclaim_mediated_pmu);
 
 static inline unsigned int perf_guest_state(void)
 {
@@ -1716,6 +1718,11 @@ static inline void perf_guest_handle_mediated_pmi(void)
 	static_call(__perf_guest_handle_mediated_pmi)();
 }
 
+static inline void perf_guest_reclaim_mediated_pmu(void)
+{
+	static_call(__perf_guest_reclaim_mediated_pmu)();
+}
+
 extern void perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs);
 extern void perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs);
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 78441df572487..2f301ef0bd26a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7801,6 +7801,7 @@ DEFINE_STATIC_CALL_RET0(__perf_guest_state, *perf_guest_cbs->state);
 DEFINE_STATIC_CALL_RET0(__perf_guest_get_ip, *perf_guest_cbs->get_ip);
 DEFINE_STATIC_CALL_RET0(__perf_guest_handle_intel_pt_intr, *perf_guest_cbs->handle_intel_pt_intr);
 DEFINE_STATIC_CALL_RET0(__perf_guest_handle_mediated_pmi, *perf_guest_cbs->handle_mediated_pmi);
+DEFINE_STATIC_CALL_RET0(__perf_guest_reclaim_mediated_pmu, *perf_guest_cbs->reclaim_mediated_pmu);
 
 void perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
 {
@@ -7819,6 +7820,10 @@ void perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
 	if (cbs->handle_mediated_pmi)
 		static_call_update(__perf_guest_handle_mediated_pmi,
 				   cbs->handle_mediated_pmi);
+
+	if (cbs->reclaim_mediated_pmu)
+		static_call_update(__perf_guest_reclaim_mediated_pmu,
+				   cbs->reclaim_mediated_pmu);
 }
 EXPORT_SYMBOL_GPL(perf_register_guest_info_callbacks);
 
@@ -7832,6 +7837,7 @@ void perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
 	static_call_update(__perf_guest_get_ip, (void *)&__static_call_return0);
 	static_call_update(__perf_guest_handle_intel_pt_intr, (void *)&__static_call_return0);
 	static_call_update(__perf_guest_handle_mediated_pmi, (void *)&__static_call_return0);
+	static_call_update(__perf_guest_reclaim_mediated_pmu, (void *)&__static_call_return0);
 	synchronize_rcu();
 }
 EXPORT_SYMBOL_GPL(perf_unregister_guest_info_callbacks);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 3746682b1a721..2b9a46bfd3696 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -6599,6 +6599,7 @@ static struct perf_guest_info_callbacks kvm_guest_cbs = {
 	.get_ip			= kvm_guest_get_ip,
 	.handle_intel_pt_intr	= NULL,
 	.handle_mediated_pmi	= NULL,
+	.reclaim_mediated_pmu	= NULL,
 };
 
 void __kvm_register_perf_callbacks(unsigned int (*pt_intr_handler)(void),
-- 
2.56.1.809.ga0b61035b5-goog

