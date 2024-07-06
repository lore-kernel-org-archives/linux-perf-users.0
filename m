Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FFA4689
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Jul 2024 19:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720293548; cv=none; b=CRt9DFf3QMtXyNqOz/RpHceo3Q7ujPoQy3EAWkd8SwrybU5rdKKXUy7p/JuAWhqANKk6r6CbBmTiv8YU0Psf88egIFL9OHZoi2RBrMSZN/Qfu+Kmftg6U9UUgRihKgjCzdL8yrQ5F0uHaG2AHCx3cKlBeBDAbx6cA652GHkRXNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720293548; c=relaxed/simple;
	bh=/tcKJ1C1eResv+EgzDrPPOUOPvdU1vznAyaWlg6YFiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VrNCgYeYkykKie01oDZq9m5vMzOuJwNheaehDTpKUBLaN2iCmC3VfOnSOoWxuIqXbk8Fa/44dPBAoygYk/euNgp/1GDEX7d6QeJYkdR/dvtwcodqwZMu4z8TtnEolVyi8kZM8R+3j3uZoKEA8QG0994NuSIH+YLPoc26rLinawQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cs4tERfu; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cs4tERfu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720293545; x=1751829545;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/tcKJ1C1eResv+EgzDrPPOUOPvdU1vznAyaWlg6YFiU=;
  b=Cs4tERfu2Tmly5nf43pTd+nabGC/bGYuux7ikvyusAlw7K6TqHj8pZky
   KwgQqQzvnYDWz9RTfdrObhm4BX5bXJCb4s9t/Io/XNbtCBqxIXAoj0wQy
   7dV9IOgvhxO5Fgewa3f0gSQmLbjQY++886VrRN6jyyXH3QqY9CIaxr5bY
   dJuTcIF4BJDPjhKWa1W4mFvuJVH0hcUwxpxK3m+XneCAx7XtFx8zanefB
   U78qZZ41ytJ5K31tLvaOdpxIcMwboDVSMkSzQicZA7Aev1wnKNX3TgrZN
   f30LgmsQHzU/Mti5M6TvR8N32LkLol5OxLffysuXJVYAtbvUkIsXnw83E
   A==;
X-CSE-ConnectionGUID: dmCVBiylTGCjlM9WQkTRtA==
X-CSE-MsgGUID: LhvzOikaRZ+XyHsKbhlHzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11125"; a="28696922"
X-IronPort-AV: E=Sophos;i="6.09,188,1716274800"; 
   d="scan'208";a="28696922"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 12:19:04 -0700
X-CSE-ConnectionGUID: 0FNrXBLUSLqKBka4sn0D4g==
X-CSE-MsgGUID: ZwHS+cW3Se+yWZU5I30EEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,188,1716274800"; 
   d="scan'208";a="47785675"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 12:19:04 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v4 2/2] Add a test case for perf script -F +metric
Date: Sat,  6 Jul 2024 12:18:57 -0700
Message-ID: <20240706191857.302450-2-ak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240706191857.302450-1-ak@linux.intel.com>
References: <20240706191857.302450-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just a simple test

Signed-off-by: Andi Kleen <ak@linux.intel.com>

----

v2: Avoid bashisms. Use noploop
v3: Avoid false positive in shellcheck
---
 tools/perf/tests/shell/script.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/tests/shell/script.sh b/tools/perf/tests/shell/script.sh
index c1a603653662..5e080e40b390 100755
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
+	test "`grep -c metric $scriptoutput`" -gt 5
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

