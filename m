Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB84E4685
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Aug 2024 03:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723001438; cv=none; b=BL3HMpWlw/vv+CxY83HSGLD/Or6J/fJKRo5DsA1w0aEz/A5mlMhMvN9v5SW14WRfjFDH/+AWUhjp/0kxFQ2l2P3eu6ITVSsuo8TeaPSMk4bHULZzWfW/N8sTuCtzWbowwsdZmShUJn0Wla+dsENkXxdW/og1As0/YOOar6t7g/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723001438; c=relaxed/simple;
	bh=hKrMjiMDyVckp3/gwqpKozSAo10IiJaj+ac5df79/cA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lezNgoGNw1HTX7qnbgqj6yCamecjk2IvN6x6GA+gpEe0iBgJs3HBIRvXcXAuVhQHmttGHUFcfMDA9kb8HD+PkZMb7ueTHsMhUnJqCf8Juc9fvMiDJub3ka2cvmflIwVd+BJxPBC6ik0YiinOlMF8SfRszZFor5hf6AjqCNCOZoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jx/sqTZz; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jx/sqTZz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723001436; x=1754537436;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hKrMjiMDyVckp3/gwqpKozSAo10IiJaj+ac5df79/cA=;
  b=Jx/sqTZzQ0cEzhhVsdE7ABM8CZn9BYM/v8jN6XNT2gXw4RcC+SmWvI8a
   9zIE65t7g8NXwz8iCjJDHj27U3TJ4SvzeBEMMk+1us2KCgxioYXlqY7p4
   5RpA67s/BIc+sMvXQlizVCGNvs3gh1fARfrjG5cP2JA++yFa3PX2LSlgU
   WhngRza5wgqFK/zq99lWOyWJc2GFbDckH4AkXrUjLQrcLSoSLIlocEltz
   6ICuql0k4bylLNMXIGisa3Iw8qM999+Ogi+4dK2/wFaxTYBBjeyr8YvlY
   xX3jMAVJohkwRP8EY+pBCVnUinvVs2wjOQt9lL3YkQPLBmvPImYI3dRpj
   Q==;
X-CSE-ConnectionGUID: cy3O3/LwQ2++grQlneIM9g==
X-CSE-MsgGUID: PW5qN1kZT0C/I2h7s9vS7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="32200036"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="32200036"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 20:30:33 -0700
X-CSE-ConnectionGUID: LPyedYw0RBi7ySmUfePOfQ==
X-CSE-MsgGUID: S7kQXuXqSpSbdYh/oi447A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="57399492"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 20:30:33 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v8 4/4] Add a test case for perf script -F +metric
Date: Tue,  6 Aug 2024 20:30:25 -0700
Message-ID: <20240807033025.894167-4-ak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807033025.894167-1-ak@linux.intel.com>
References: <20240807033025.894167-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sample a noploop workload with cycles and instructions and check if
there is at least one metric being output by perf script.

The output is

% perf test -v 98
98: perf script tests
...
script metric test
[ perf record: Woken up 2 times to write data ]
[ perf record: Captured and wrote 0.429 MB /tmp/perf-test-script.nkvvuzMOla/perf.data (8174 samples) ]
       perf-exec  853636 3967843.162782:        metric:    0.15  insn per cycle
            perf  853636 3967843.163210:        metric:    0.87  insn per cycle
            perf  853636 3967843.163226:        metric:    0.84  insn per cycle
            perf  853636 3967843.163240:        metric:    0.88  insn per cycle
            perf  853636 3967843.163276:        metric:    1.06  insn per cycle
            perf  853636 3967843.163387:        metric:    1.09  insn per cycle
            perf  853636 3967843.163578:        metric:    1.17  insn per cycle
            perf  853636 3967843.164412:        metric:    4.53  insn per cycle
            perf  853636 3967843.164623:        metric:    1.18  insn per cycle
            perf  853636 3967843.164817:        metric:    1.25  insn per cycle
script metric test [Success]
...
%

Signed-off-by: Andi Kleen <ak@linux.intel.com>

----

v2: Avoid bashisms. Use noploop
v3: Avoid false positive in shellcheck
v4: Use :S in the test (Ian, Namhyung)
v5: Update commit message.
---
 tools/perf/tests/shell/script.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/tests/shell/script.sh b/tools/perf/tests/shell/script.sh
index c1a603653662..e69c3548583a 100755
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
+	perf record -e '{cycles,instructions}:S' -o "${perfdatafile}" perf test -w noploop
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

