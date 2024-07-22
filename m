Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CD83F9C5;
	Mon, 22 Jul 2024 21:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721682427; cv=none; b=TMFyzXGhq/rVr/VFCEO7S6TIZg/RepGY+ejVIwHQEfMoWMULyymOMyjFGHJ75MxJYVWJHEV9Oj4vblLvRg3pzQ57O+ptIUzKBf7EHcSW83iOHLirX3S9u42sdxJYnp3E4TZPpusabKk/eKdUefYL/HtzZbCplf6BI985KSzPz84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721682427; c=relaxed/simple;
	bh=Vh8XVtwwL74Cr5WG/3P9Ea2rW9L1UOvjDhRm/Vay+hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e25wX9NZ1EOVfqkP8ClKuqnVXgXXmBWdRETJjFlSlDhRT8zMWEhsGscJOYxzNjIfGwnTS6IA1GDu+X6+MYI/7Lq6OnKkKkcJY6e+Cfwp4/x9rUSUsEaVVPfGTXuc1kYOfbQKSQ2pow0Rd0U0UegDQehRiMutDb8F5sdWk8eIjX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aTmOsEc7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTmOsEc7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721682425; x=1753218425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vh8XVtwwL74Cr5WG/3P9Ea2rW9L1UOvjDhRm/Vay+hg=;
  b=aTmOsEc7vwqJ88xiZ71RJBnpvK6NySDErnCPXlo6BVMTJl7ZAiTAD75l
   Dt36WAoiD4IGhMtQ7pW9U8vRn+yPtkKELmJj7KLlOxK7pyyjB0CO1wUn9
   kl2m2DmFH/fLDXfFVMc8h35M8Vxi+0thrp9jjbhHYPgvAAuDctti0TGed
   wsB4cg3zLjz38k0HEy2AV555aEwaF+/pTxW6bAEXtj5MvAPnPtMPaj7hU
   fib97IrAwSIqqSXSa9t0r3/xsD7fVDV9/ePnejWHpkldeQP+/7Wb1V7Jx
   +qBZ9TroSQdaJJjNiIhqRGVoH1QTsHtzoMuSxb1xnsWJOWcTb3semZZBL
   w==;
X-CSE-ConnectionGUID: qTJUgliXTPC0CNmAOS1o1g==
X-CSE-MsgGUID: 7Yk6hgCATl2EhvcqNGuS8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="30428320"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="30428320"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 14:07:03 -0700
X-CSE-ConnectionGUID: /I89/5+VSpmbbL3HpvLYMQ==
X-CSE-MsgGUID: CZmWqJlhTa+pzStj3jB2Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="51653307"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 14:07:02 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: intel-gfx@lists.freedesktop.org,
	linux-perf-users@vger.kernel.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6/7] drm/i915/pmu: Lazy unregister
Date: Mon, 22 Jul 2024 14:06:47 -0700
Message-ID: <20240722210648.80892-7-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240722210648.80892-1-lucas.demarchi@intel.com>
References: <20240722210648.80892-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of calling perf_pmu_unregister() when unbinding, defer that to
the destruction of i915 object. Since perf itself holds a reference in
the event, this only happens when all events are gone, which guarantees
i915 is not unregistering the pmu with live events.

Previously, running the following sequence would crash the system after
~2 tries:

	1) bind device to i915
	2) wait events to show up on sysfs
	3) start perf  stat -I 1000 -e i915/rcs0-busy/
	4) unbind driver
	5) kill perf

Most of the time this crashes in perf_pmu_disable() while accessing the
percpu pmu_disable_count. This happens because perf_pmu_unregister()
destroys it with free_percpu(pmu->pmu_disable_count).

With a lazy unbind, the pmu is only unregistered after (5) as opposed to
after (4). The downside is that if a new bind operation is attempted for
the same device/driver without killing the perf process, i915 will fail
to register the pmu (but still load successfully). This seems better
than completely crashing the system.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/i915/i915_pmu.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index 8708f905f4f4..df53a8fe53ec 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -1158,18 +1158,21 @@ static void free_pmu(struct drm_device *dev, void *res)
 	struct i915_pmu *pmu = res;
 	struct drm_i915_private *i915 = pmu_to_i915(pmu);
 
+	perf_pmu_unregister(&pmu->base);
 	free_event_attributes(pmu);
 	kfree(pmu->base.attr_groups);
 	if (IS_DGFX(i915))
 		kfree(pmu->name);
+
+	/*
+	 * Make sure all currently running (but shortcut on pmu->closed) are
+	 * gone before proceeding with free'ing the pmu object embedded in i915.
+	 */
+	synchronize_rcu();
 }
 
 static int i915_pmu_cpu_online(unsigned int cpu, struct hlist_node *node)
 {
-	struct i915_pmu *pmu = hlist_entry_safe(node, typeof(*pmu), cpuhp.node);
-
-	GEM_BUG_ON(!pmu->base.event_init);
-
 	/* Select the first online CPU as a designated reader. */
 	if (cpumask_empty(&i915_pmu_cpumask))
 		cpumask_set_cpu(cpu, &i915_pmu_cpumask);
@@ -1182,8 +1185,6 @@ static int i915_pmu_cpu_offline(unsigned int cpu, struct hlist_node *node)
 	struct i915_pmu *pmu = hlist_entry_safe(node, typeof(*pmu), cpuhp.node);
 	unsigned int target = i915_pmu_target_cpu;
 
-	GEM_BUG_ON(!pmu->base.event_init);
-
 	/*
 	 * Unregistering an instance generates a CPU offline event which we must
 	 * ignore to avoid incorrectly modifying the shared i915_pmu_cpumask.
@@ -1337,21 +1338,14 @@ void i915_pmu_unregister(struct drm_i915_private *i915)
 {
 	struct i915_pmu *pmu = &i915->pmu;
 
-	if (!pmu->base.event_init)
-		return;
-
 	/*
-	 * "Disconnect" the PMU callbacks - since all are atomic synchronize_rcu
-	 * ensures all currently executing ones will have exited before we
-	 * proceed with unregistration.
+	 * "Disconnect" the PMU callbacks - unregistering the pmu will be done
+	 * later when all currently open events are gone
 	 */
 	pmu->closed = true;
-	synchronize_rcu();
 
 	hrtimer_cancel(&pmu->timer);
-
 	i915_pmu_unregister_cpuhp_state(pmu);
-	perf_pmu_unregister(&pmu->base);
 
 	pmu->base.event_init = NULL;
 }
-- 
2.43.0

