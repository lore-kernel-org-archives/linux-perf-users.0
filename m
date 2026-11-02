Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793581613;
	b=1lOMYErNsW0RuZn9HpHMTkaPpng/qUzYWq40dkiD3UwG90eiEP9hyZdVWmlXDNNWaX2c
	 rZWpsLvtXX7Z/ni/roSPDGw7ko7A5Ya8KxqCvhu8qhwGtYL7CEXoX6RnWxWtaQj53lpqK
	 V1KTcj2uMI/DOjO93VzZUp/bumCW9u4u73viuL/RUelnajcnGgHm91iywsYcmYHIGgBVL
	 PM8dAuhegorS5EhH/UafazFnCh1zf5EwTxU7JpArXBs3Ls36UdwkWahD3J/bJJczzZFTr
	 tuZdbCisuDds4dCvgLvcNHAJb28sMOTvfjPKqu7kcEDK5RRDUjm0plhrS0w8df8oFeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793581613;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KubJ5aj43McVIznvDYHq8eXQCdGN1mk94W8zMPqCbfI=;
	b=uax32xfv5TI2XLhlvPSg3SaS2Auk7XqxDL9dRJfR38/tPtCWn6yW+l8oEwcfXIc2U14r
	 sZCn14FqnjOS8jhgdiqZA9UlT3cnCRZGFa7ZlFEn1Vd/2XBXs7p3at6qqAiizlZMTqpdg
	 q/b3850+xE10VMyzD4JEr2UXE7oGnYv/8Y2AOZr9Z7e+vLZXV13dH9fkmegsgoA/oAC2m
	 JjvgDQad71HkndZjVDsDM4KjV6ub/IpWbnw/g1ULLXSVx3+H0onESxPgGFkd1S6cxALxo
	 521lbOHW1K/5SjSQD2NyNvvqSnndcZhJipEZzjMGhaUk1WVlYAsLaL7sBkkCb6gxOkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="dH/2Q5sR";
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1595606A329;
	Mon,  2 Nov 2026 01:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1595606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dH/2Q5sR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793581612; x=1825117612;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TE/61i7PF2xu/O+4d3FZGSINSF5EQf92/elJ9IZOp+E=;
  b=dH/2Q5sRb6HyrzinJ5Rxz4guGJYfJXAXSUT9lXwyfXRb132AXKvNCix8
   XJihfZx5Ahlm65HfUKegVdOsPm+g06OjB+tKqaT+eoUpsjW//fwQ58KvM
   PMncIrTvAbpidQY0EoLm3//+UKwROBJojMgQE7Dl7z/pJaPz7dGjOS79N
   d3+EEwB32+GL4wzTIvAhrtLdwr4VIqEHOh8NhFnQNT9Egj8f8CdljSIdP
   7UiaBYX9Fv4JEtHfKZxIvCV/2EsMxPQDtLPyRa2ldLl33toowrQbyHpWG
   zjBPJxfStdSQlFZ8mXFImvzLeXrNzDn/8xmj6LWehMnZUe525UZMATXay
   g==;
X-CSE-ConnectionGUID: oV8yYqXER2G2AZQlPGotVw==
X-CSE-MsgGUID: HeUHzYESSdiA4iDl02woKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2146018"
X-IronPort-AV: E=Sophos;i="6.27,190,1787036400"; 
   d="scan'208";a="2146018"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2026 17:06:52 -0800
X-CSE-ConnectionGUID: hcXt1J35TAWaGoZe/3Mp9Q==
X-CSE-MsgGUID: J8Dh7UPaSNKZN3ws7h+w4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,190,1787036400"; 
   d="scan'208";a="6106347"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa003.fm.intel.com with ESMTP; 01 Nov 2026 17:06:47 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Hanxiang Xu <xuhx@hust.edu.cn>
Subject: [PATCH 2/2] perf/core: Cancel PMU mux hrtimer before freeing per-CPU context
Date: Mon,  2 Nov 2026 08:59:05 +0800
Message-Id: <20261102005905.2017784-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102005905.2017784-1-dapeng1.mi@linux.intel.com>
References: <20261102005905.2017784-1-dapeng1.mi@linux.intel.com>
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

perf_pmu_free() can free the PMU's per-CPU perf_cpu_pmu_context while
the multiplexing hrtimer is still armed. Once the timer expires, it
dereferences the freed cpc and can crash the kernel.

Cancel the multiplexing hrtimer before freeing the PMU context by adding
a perf_mux_cancel_hrtimer() helper and invoking it from the PMU free
path.

Reported-by: Hanxiang Xu <xuhx@hust.edu.cn>
Closes: https://lore.kernel.org/all/ca4f133.14714.1a162b8654c.Coremail.xuhx@hust.edu.cn/
Fixes: 8f4c4963d283 ("perf/core: Simplify the perf_pmu_register() error path")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 kernel/events/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e088c31534bc..54eb962ab6ff 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1316,6 +1316,12 @@ static void __perf_mux_hrtimer_init(struct perf_cpu_pmu_context *cpc, int cpu)
 		      HRTIMER_MODE_ABS_PINNED_HARD);
 }
 
+static void perf_mux_cancel_hrtimer(struct perf_cpu_pmu_context *cpc)
+{
+	cpc->hrtimer_active = 0;
+	hrtimer_cancel(&cpc->hrtimer);
+}
+
 static int perf_mux_hrtimer_restart(struct perf_cpu_pmu_context *cpc)
 {
 	struct hrtimer *timer = &cpc->hrtimer;
@@ -13024,6 +13030,7 @@ static void perf_pmu_free(struct pmu *pmu)
 			cpc = *per_cpu_ptr(pmu->cpu_pmu_context, cpu);
 			if (!cpc)
 				continue;
+			perf_mux_cancel_hrtimer(cpc);
 			if (cpc->epc.embedded) {
 				/* refcount managed */
 				put_pmu_ctx(&cpc->epc);
-- 
2.34.1

