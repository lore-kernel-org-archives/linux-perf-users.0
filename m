Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D94A1ABEB8
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Aug 2024 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722633338; cv=none; b=kMSdHY1SRVJdjTGVX/zlueposc4GYNv5VAtAvMPKXSOauPiI3rO1yiz77ZdHf3u5OOvzrapqJO9pa8JPG8X0CST9gsGbRk2E+8ItcgPm9Ca+t0CkqnSQqqaF+tiNRRoqgvWeJgI5FgFYRztPKPFoLmrvFfp1Wn9cyo3nsNW3Zhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722633338; c=relaxed/simple;
	bh=74NBRkkZ9jNOsLpY43Wn2HmJNg7nLu7J87kDdo7aYGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lWBpPOWcocCJwMTz5AmmuuAV84RZd9FixVpy6Nmb4dGNo9rDkvIm6q4gVOFelHFg2xrLIudwQIp0jYDS7qF5nhE3s5NRdZDdAiFDTUPP1PKC+qpr8Lf3IP5hp2Oy5GFt+WZuY/wyqQnl8krRKalN/50eoV6ltaYjFfsHZfbevr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LvtrGFp8; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LvtrGFp8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722633337; x=1754169337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=74NBRkkZ9jNOsLpY43Wn2HmJNg7nLu7J87kDdo7aYGY=;
  b=LvtrGFp8lB7uYFn/G39VL96qczWZ1XHQaKsUIxDYV3L/tYiJJmg10lhi
   2SUoUN4O9nGiPZpDzdyaQludSxDjT25hq/+eBKjPXbBeYNvI2vwVwLizQ
   585uQFvBK5XZ7rekwKUcFeWxc2imsnjB7AEV9ygM9YZv03ShL1jbxST3k
   qCEZq5PPbz6D4nVcPJF27MtrtLVDx7FkXni0qwfWxsWN4MgHQXieX189M
   15snhv+zQ8r6kjNRK9yKIxOF9Gd78d85DEG51ifCM++AuJcsRTzsizlbD
   kx2VIw8n57R8M0eJ6y6DwVHFxoRr83sq3kLEB2ZceSdk5Zw7iPYXkqrxB
   A==;
X-CSE-ConnectionGUID: Kn35zdV3TQmWDjXmvbOHOA==
X-CSE-MsgGUID: SXJ2ByMNQFWXIC6lIiSXag==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="31246282"
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="31246282"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 14:15:36 -0700
X-CSE-ConnectionGUID: Omnf3aKDQry5ADE39cwjNA==
X-CSE-MsgGUID: B7J4PgYvRDuBoljednRvVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="56282265"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 14:15:35 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 2/2] perf report: Handle non capstone case for calling perf script
Date: Fri,  2 Aug 2024 14:14:18 -0700
Message-ID: <20240802211530.776055-3-ak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802211530.776055-1-ak@linux.intel.com>
References: <20240802211530.776055-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When perf is built without capstone trying to displaying assembler
sample context would error out. Use the older --xed variant in this
case.

Fixes: 659663f0bccc ("perf: script: prefer capstone to XED")
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/ui/browsers/scripts.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index e437d7889de6..b130a92053db 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -107,8 +107,13 @@ static int list_scripts(char *script_name, bool *custom,
 	if (evsel)
 		attr_to_script(scriptc.extra_format, &evsel->core.attr);
 	add_script_option("Show individual samples", "", &scriptc);
+#ifdef NO_CAPSTONE
+	add_script_option("Show individual samples with assembler", "-F +insn --xed",
+			  &scriptc);
+#else
 	add_script_option("Show individual samples with assembler", "-F +disasm",
 			  &scriptc);
+#endif
 	add_script_option("Show individual samples with source", "-F +srcline,+srccode",
 			  &scriptc);
 	perf_config(scripts_config, &scriptc);
-- 
2.45.2

