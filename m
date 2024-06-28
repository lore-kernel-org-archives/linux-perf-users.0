Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EB8A38
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 00:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719533109; cv=none; b=ggddQPzBpZFUCnvkSI4+VghL/8Ra+lXAPUF+IqIjRecdpg0U4eor5ENQ5GI9vD3OK9Ydch9VIw4XWKPKXT3V40JZgLAKXcebMWrd9N1k79fJyyX+8M8h6CQ9LzXUmqrtcH/4uOCCT746BfsQQfUUxjdlw8sBxWpZNu6NStPHfd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719533109; c=relaxed/simple;
	bh=+UtkRZ8VL3LaMXtO60I+h9bDYJf01QfXntICgEOJHxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVnqIvY34FSJtgr85K0CGdQ7xNgzUzifYSouqVpdzjxkN61Hf1NrGBSBAZPfHu6BhE/f+UORo5Fkid+bEpVXoBTL1iJTM5D6VEWzqRbmSEZn6gVHJl4zTbrTukDb/Z3wlDGbv9CJ0D41mZo64agBgALtHiWIfVL/GxUclCtUdk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J3atN2DC; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J3atN2DC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719533106; x=1751069106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+UtkRZ8VL3LaMXtO60I+h9bDYJf01QfXntICgEOJHxU=;
  b=J3atN2DCCWFsLKnbdhIX9Xb4B1+FcGq8jZpQi+3q8r700QECknTYfxrt
   AeC2Z6rYND0y4UsRORsgGyo6yFZVuJigCubNI5rpAkt80uVE8T5go9BmU
   sm+8+zqthLaKm3XD7jsLdueuWV7tA9DVhKdWJgakqVDB3/GnjOPesmMtT
   JMDcnJYOA/IUw+A6sNj6JdGPSoYR9dRGoz+QOV2BZBgl51DvN3+45rxhZ
   nVamG4YvNcNp5LR879Eod0X552+penLm3LYiZWsnZVpnayfdpKp2+3R+H
   qCHnCDCGyu96LXegnlmN9iy/DpojiFmW2j5i5WYYB6ayKp7L4uwvssIU9
   g==;
X-CSE-ConnectionGUID: 2ffCUCokSwGlddlMgmzveg==
X-CSE-MsgGUID: 6XdgsaqPTiaocy19nhLXaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16535365"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="16535365"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 17:05:04 -0700
X-CSE-ConnectionGUID: 5qHc5y5HRPCy79PID0gIkQ==
X-CSE-MsgGUID: jogx1HZDRw2I5BqRvw/zCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="49148549"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 17:05:03 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2 2/2] Add a test case for perf script -F +metric
Date: Thu, 27 Jun 2024 17:04:55 -0700
Message-ID: <20240628000455.1890269-2-ak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628000455.1890269-1-ak@linux.intel.com>
References: <20240628000455.1890269-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just a simple test

Signed-off-by: Andi Kleen <ak@linux.intel.com>

--

v2: Avoid bashisms. Use noploop
---
 tools/perf/tests/shell/script.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/tests/shell/script.sh b/tools/perf/tests/shell/script.sh
index c1a603653662..de4b1dce55ad 100755
--- a/tools/perf/tests/shell/script.sh
+++ b/tools/perf/tests/shell/script.sh
@@ -7,6 +7,7 @@ set -e
 temp_dir=$(mktemp -d /tmp/perf-test-script.XXXXXXXXXX)
 
 perfdatafile="${temp_dir}/perf.data"
+scriptoutput="${temp_dir}/script"
 db_test="${temp_dir}/db_test.py"
 
 err=0
@@ -88,8 +89,21 @@ test_parallel_perf()
 	echo "parallel-perf test [Success]"
 }
 
+test_metric()
+{
+	echo "script metric test"
+	if ! perf list | grep -q cycles ; then return ; fi
+	if ! perf list | grep -q instructions ; then return ; fi
+	perf record -e '{cycles,instructions}' -o "${perfdatafile}" perf test -w noploop
+	perf script -i "${perfdatafile}" -F +metric  > $scriptoutput
+	test `grep -c metric $scriptoutput` -gt 5
+	grep metric $scriptoutput | head
+	echo "script metric test [Success]"
+}
+
 test_db
 test_parallel_perf
+test_metric
 
 cleanup
 
-- 
2.45.2

