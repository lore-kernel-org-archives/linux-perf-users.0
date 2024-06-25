Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07156C2FD
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 00:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719276164; cv=none; b=FKgxxI17R8W0Y1nBvD2oMEdaM0C5n6xSLdT1JhtB6KH5fE3+Uyqbt79neoPtrgyOPK7F3x8TegFFH9oXzum54QB4WQMybVYsdPEyKxgeLQC3bEewtvJwZxmh3p3cFHCWbbikMjmWT/16FmHypJpxNeJPX/kqfaQ0vRP3EJuY+64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719276164; c=relaxed/simple;
	bh=rVsys7A/1FPDDFfjxcDEk1mcYhBj27VmpR3xVq6Ha/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WsKsv01B8A3qQmDOCBdQCCpvpRc+hKypLV+wocnriTCIFAQcKbQXCKWMz9U3DygiAvMiLLr0u+lYg/KefUxPYkZfVzWggyIO3aQgVAEyUaRYAqCmUi1czEFVj5Geti8YbVrlR3Hy8Z2Q9VCVt4muOZqTwdd/R4fAQtlT9/txMlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PgbxTurM; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PgbxTurM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719276163; x=1750812163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rVsys7A/1FPDDFfjxcDEk1mcYhBj27VmpR3xVq6Ha/4=;
  b=PgbxTurMdM+CHT4CG8gIsPFwHPnWz70bZOtcwneb15s7DaRjTSEVTzBb
   IzQTSU8o91tpHApiIst3QG/NptP+ZorJCW+YO+dwVr+QSf4BKg9MDYlTB
   zvkofFQbk8IP+Vo0i+R3jEM8QEsLkdYrbSsDDDqzEddzITMTRs1CPpk/O
   Ny+kC+ApMX7fXaAPwTD4SLuvt6gcOHlVbnAZPZ8EynKWijU6iGaJbVILu
   adxOJAHwwA6GtgXiPjUfnEW2G5qum7v3bxrsiMZKXlsMUuwjCfrRT2dhc
   e4Z7wDo7QmXeOqkWmxd5CgEZI6Rc/wz9kWluzqZpQJ01Mz66XrmG58i/a
   Q==;
X-CSE-ConnectionGUID: iB/08WhwSlKJfHEhd5tUoQ==
X-CSE-MsgGUID: MnNDlsiKQl6LhAZS4vBmhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="27680386"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="27680386"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 17:42:40 -0700
X-CSE-ConnectionGUID: n1X8dOctTsWLdcc6jcE6yg==
X-CSE-MsgGUID: DC/B/vsPS6ex9doW31vKSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="43451506"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 17:42:40 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 2/2] Add a test case for perf script -F +metric
Date: Mon, 24 Jun 2024 17:42:32 -0700
Message-ID: <20240625004232.1852705-2-ak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625004232.1852705-1-ak@linux.intel.com>
References: <20240625004232.1852705-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just a simple test

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/tests/shell/script.sh | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/script.sh b/tools/perf/tests/shell/script.sh
index c1a603653662..cd9d41734021 100755
--- a/tools/perf/tests/shell/script.sh
+++ b/tools/perf/tests/shell/script.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # perf script tests
 # SPDX-License-Identifier: GPL-2.0
 
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
+	perf record -e '{cycles,instructions}' -o "${perfdatafile}" bash -c 'for i in `seq 1000` ; do true ; done'
+	perf script -i "${perfdatafile}" -F +metric  > $scriptoutput
+	test $(grep -c metric $scriptoutput) -gt 5
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

