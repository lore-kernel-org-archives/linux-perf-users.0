Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D66514373D
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jul 2024 20:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721767732; cv=none; b=K6d6CSe3NAxvqDS+4hp75qwhlq+IzRVwmwWn76Mx3IgrKQfaaIaHo+g+sBiAieAJrM/B03xlxzsnqnBgw7KQ67TMtQO5aoHCPEkQOgEcJHV0FuOnaykQem2qNtlmenivZlcz9yDR+3EUH/6bIK/Y0jZXhNmB4jJ0JVGbeME9N8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721767732; c=relaxed/simple;
	bh=/tcKJ1C1eResv+EgzDrPPOUOPvdU1vznAyaWlg6YFiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZEMEOIWvl+MmYQsVnhMT+QvghbQBD4PA9jmADk/PrtpA++aIu/iBuRRwAH9jQzcoZ2ZL8pEChD2naRhWqaQtu+UmCFwChqaH7hjmqzY0K+7RPIlfAIOYbBNlS29ncV25LoaSisX6Nt0INMAMFaeeHYuhgEEoFijRF3nkDOlOy3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DunjXZy1; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DunjXZy1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721767731; x=1753303731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/tcKJ1C1eResv+EgzDrPPOUOPvdU1vznAyaWlg6YFiU=;
  b=DunjXZy1X/pza8f0APqxVO4Nm9KK+cEuhhfSUh9G4/VpfbUKPM/4xf3H
   5c2GRS7QD3C91Na7o14H9h6t3ZL/4ILFCnWaK1I9D28jFVEhQiv3Mivt+
   tVZ5EBYTgC5shZWjL8xh3Ik58HTKSyMw4IDWYfd1c9N5UxDv16bnQfgGf
   x5MdYWjwg4+VhEDRbp0ojWT2JtSQcxWn0DtaXMVI9U3w6fUiMIQGywPss
   msW8QliMEFL090XyISVQ8iWnLQW0ETPlCK7N3RB9mEPFcJqx1lMY3/O6O
   qht7Ck4mTlMZPyN332YCU5WnUKD83cVK17BDum2SKI409p+wBCCmDvYIO
   g==;
X-CSE-ConnectionGUID: Zh2A7yGkS9C2SOmJe9gq2g==
X-CSE-MsgGUID: GFA03E38TtiSm5RnFrR3cA==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19564603"
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="19564603"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 13:48:47 -0700
X-CSE-ConnectionGUID: 48Lsofs/SUelVTuN1JwNtg==
X-CSE-MsgGUID: NyRm4SeFSje6VBwnOFBLZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="56654798"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 13:48:46 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v6 4/4] Add a test case for perf script -F +metric
Date: Tue, 23 Jul 2024 13:48:34 -0700
Message-ID: <20240723204834.3617647-4-ak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723204834.3617647-1-ak@linux.intel.com>
References: <20240723204834.3617647-1-ak@linux.intel.com>
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

