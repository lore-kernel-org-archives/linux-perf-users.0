Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C9B28643A;
	Thu, 23 Oct 2025 22:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761259462; cv=none; b=imenkivzOaxw4dGrEGb05I2NbOWaUgea7Ds/Pe6dJFQwYznth1eCpwcW9K3slMypY7/NVb3SY/S8Gwj9ZbA0ucDOkavDPegbFVXAUIV9QF5VqzAxQ7TNmZB/sC8lrF40xZGuLZ5XF7tpGcCu0D7eyJB47zwX6QYL4HHXEWBcPrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761259462; c=relaxed/simple;
	bh=HC/nzp1Ek6Q8BDJXNR8G5iC+Mmgh09qewklI7Y2Hj3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aw6DghtYJA34iaYvqyQefP8xztM3JHnlipkwI1j2/90sixv2FZbeiViy3f2KsWaFcMQKyxhjOyenKAdYSEZE/HkAIrIf6UB8pxIFQ31zm2nJzQlm/C9zwkxokCvOdLdvad7sJxK/JG8nUE/D/yC3AZ9lo3RzKMlGmuVR5QTWYTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HRCgsUGq; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HRCgsUGq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761259461; x=1792795461;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HC/nzp1Ek6Q8BDJXNR8G5iC+Mmgh09qewklI7Y2Hj3I=;
  b=HRCgsUGq418IthgeuKnT/giEDu9Ov9xqZPey3D27byM2bFmfjA7o8e/A
   6jY7uX2CjEz7zcBAZ06wHh1BQuCxvQFWHGJiXzeuhatv3lmWnsQd7cqg8
   PYma2w5IfAZTPQoK1DOAM6w7LcxO8uPSfjx9g0j7sUMM38GYrNK3EG+Da
   Rhidw0KRgITBkcHOp+GB5FowXR3/3HIFKiCSJ5/BlWnPnJQqkrmyRNz8V
   /PB1JOkDDIvpyiYYIKc2cOh6c4/Q4CCBy/hgzZa63zU9BBuO31ZRo5Y2r
   FZg21dFzB3TyfpwVF5pOKKpmRar3ssjfZ+TaQv5PXPxJUreWJB8f5Ajdv
   A==;
X-CSE-ConnectionGUID: Z6MIhl7+RlqYYamZ0UFPDg==
X-CSE-MsgGUID: QaeUGEqkSKitWPBOxwM4ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63333509"
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="63333509"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 15:44:19 -0700
X-CSE-ConnectionGUID: vkDiDS3oQvacRAlhoVZ5Jw==
X-CSE-MsgGUID: kfXYMNguQMKAaLxtWdVWlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="183885484"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 15:44:19 -0700
From: Zide Chen <zide.chen@intel.com>
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH RESEND 2/3] perf/x86/intel/cstate: Remove PC3 support from LunarLake
Date: Thu, 23 Oct 2025 15:37:52 -0700
Message-ID: <20251023223754.1743928-3-zide.chen@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251023223754.1743928-1-zide.chen@intel.com>
References: <20251023223754.1743928-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Rui <rui.zhang@intel.com>

LunarLake doesn't support Package C3. Remove the PC3 residency counter
support from LunarLake.

Fixes: 26579860fbd5 ("perf/x86/intel/cstate: Add Lunarlake support")
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/events/intel/cstate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index a5f2e0be2337..2bfd011f99da 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -70,7 +70,7 @@
  *			       perf code: 0x01
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,KNL,
  *						GLM,CNL,KBL,CML,ICL,TGL,TNT,RKL,
- *						ADL,RPL,MTL,ARL,LNL
+ *						ADL,RPL,MTL,ARL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C6_RESIDENCY:  Package C6 Residency Counter.
  *			       perf code: 0x02
@@ -522,7 +522,6 @@ static const struct cstate_model lnl_cstates __initconst = {
 				  BIT(PERF_CSTATE_CORE_C7_RES),
 
 	.pkg_events		= BIT(PERF_CSTATE_PKG_C2_RES) |
-				  BIT(PERF_CSTATE_PKG_C3_RES) |
 				  BIT(PERF_CSTATE_PKG_C6_RES) |
 				  BIT(PERF_CSTATE_PKG_C10_RES),
 };
-- 
2.51.1

