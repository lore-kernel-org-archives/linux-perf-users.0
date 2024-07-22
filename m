Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C53224FD;
	Mon, 22 Jul 2024 21:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721682425; cv=none; b=fx1uee7KiXrRUa0kS8/a9PCKuBBpmarfPTX/whfwQ/dXdzT1yfGOrDpMKiNbutHd/jC191GQZMvuKzWcFp3jSzsgc9QVsI+p0kvl0q5m714b77jrfMEY2LzjyzIoLCpXqiTdktXcnkz+tDyIxzMnF7xFCDwuYnwZ4gwrqA/3mjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721682425; c=relaxed/simple;
	bh=jzjRmAv0FQC+DoGcPDLeFGLEdXtORRGXZvIMK7w3hGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=te5HH3/PfqUV/9YgxyG3NF9VyKFEVBf3MeAd4KflCME5tZmobS0EMkgR7klyZ4i2P98aCZD6phn8Y+UBlz7cJ6ualKGLT6m7KrkGm1OqPxxl9Merdqmih/Khl9gVZMqzyTz4APTyGnCmyDFMpmaRTXpdEMBdHSnAhqjnje8dK+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fuJ38xeS; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fuJ38xeS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721682422; x=1753218422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jzjRmAv0FQC+DoGcPDLeFGLEdXtORRGXZvIMK7w3hGY=;
  b=fuJ38xeSP1zif86VFSe3q9/uebPEfr5ywTi6v7I6yXl8aCylGlYjLd7x
   q8mppA4B0wp/s4ARJzGSoVDxWx6em2xAgB+9CHhsgEhqRlg5jREOP+rze
   q6hdEl5MH4abc3GooIFskogE39tA6CqI5ux9Qevm/Q2c+++xzQfcWUJkB
   JDGbFAKMVP3v1QxpDulQnxV8Dtqb/9IiHl6p20sL6e1WKlVA/dQf0pDVr
   ytHO8u1sDQprYJvJH/3Cz2y1yKNEv8tASYqoTnY48VfFVhRdPLAfll0Oa
   1oImnmYdCkAAtvpIxOxusCScCiNisy5t93y5W+VvrnCh6qjZQC1S4CO60
   A==;
X-CSE-ConnectionGUID: srxX5Ud4Rg2W0oAm1/GS8A==
X-CSE-MsgGUID: mKAL4dQLQbqM+A9kDgkegQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="30428294"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="30428294"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 14:07:00 -0700
X-CSE-ConnectionGUID: +sqI0r3xT7aWlDU75JtWiQ==
X-CSE-MsgGUID: 3F7AwXZ2T6eMmuT0vcHHCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="51653273"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 14:07:00 -0700
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
Subject: [PATCH 1/7] perf/core: Add pmu get/put
Date: Mon, 22 Jul 2024 14:06:42 -0700
Message-ID: <20240722210648.80892-2-lucas.demarchi@intel.com>
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

If a pmu is unregistered while there's an active event, perf will still
access the pmu via event->pmu, even after the event is destroyed. This
makes it difficult for drivers like i915 that take a reference on the
device when the event is created and put it when it's destroyed.
Currently the following use-after-free happens just after destroying the
event:

	BUG: KASAN: use-after-free in exclusive_event_destroy+0xd8/0xf0
	Read of size 4 at addr ffff88816e2bb63c by task perf/7748

Whenever and event is created, get a pmu reference to use in event->pmu
and just before calling module_put(), drop the reference..

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 include/linux/perf_event.h |  3 +++
 kernel/events/core.c       | 32 ++++++++++++++++++++++++++++----
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index a5304ae8c654..7048a505e93c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -540,6 +540,9 @@ struct pmu {
 	 * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
 	 */
 	int (*check_period)		(struct perf_event *event, u64 value); /* optional */
+
+	struct pmu *(*get)		(struct pmu *pmu); /* optional: get a reference */
+	void (*put)			(struct pmu *pmu); /* optional: put a reference */
 };
 
 enum perf_addr_filter_action_t {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1b6f5dc7ed32..cc7541b644b0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5208,6 +5208,8 @@ static void perf_addr_filters_splice(struct perf_event *event,
 
 static void _free_event(struct perf_event *event)
 {
+	struct module *module;
+
 	irq_work_sync(&event->pending_irq);
 
 	unaccount_event(event);
@@ -5259,7 +5261,13 @@ static void _free_event(struct perf_event *event)
 		put_ctx(event->ctx);
 
 	exclusive_event_destroy(event);
-	module_put(event->pmu->module);
+
+	module = event->pmu->module;
+	event->pmu->put(event->pmu);
+	/* can't touch pmu anymore */
+	event->pmu = NULL;
+
+	module_put(module);
 
 	call_rcu(&event->rcu_head, free_event_rcu);
 }
@@ -11331,6 +11339,11 @@ static int perf_pmu_nop_int(struct pmu *pmu)
 	return 0;
 }
 
+static struct pmu *perf_pmu_nop_pmu(struct pmu *pmu)
+{
+	return pmu;
+}
+
 static int perf_event_nop_int(struct perf_event *event, u64 value)
 {
 	return 0;
@@ -11617,6 +11630,12 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 	if (!pmu->event_idx)
 		pmu->event_idx = perf_event_idx_default;
 
+	if (!pmu->get)
+		pmu->get = perf_pmu_nop_pmu;
+
+	if (!pmu->put)
+		pmu->put = perf_pmu_nop_void;
+
 	list_add_rcu(&pmu->entry, &pmus);
 	atomic_set(&pmu->exclusive_cnt, 0);
 	ret = 0;
@@ -11695,7 +11714,8 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 		BUG_ON(!ctx);
 	}
 
-	event->pmu = pmu;
+	event->pmu = pmu->get(pmu);
+
 	ret = pmu->event_init(event);
 
 	if (ctx)
@@ -11714,8 +11734,12 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 			event->destroy(event);
 	}
 
-	if (ret)
-		module_put(pmu->module);
+	if (ret) {
+		struct module *module = pmu->module;
+
+		pmu->put(pmu);
+		module_put(module);
+	}
 
 	return ret;
 }
-- 
2.43.0

