Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F306C13AA4E
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 21:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723585022; cv=none; b=p8G/0043WDH6son96FgtiPKF6StE/u6LTO0r/p1lsL05xNFcwtL2YY1C4hCGuV0rD94XlibRdUIBjy9nqMcLQ4BhUr7Bo76LwETXVfdEP/1ejgtPCc8kBRVohXhDkoMaP6qbtUBhwwRFNjriB5NCES8hYMBMHXk77kPPLt9C9EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723585022; c=relaxed/simple;
	bh=hKrMjiMDyVckp3/gwqpKozSAo10IiJaj+ac5df79/cA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZlyMEAEknx/TwayvnJrfAS1XhbbWLDb8YRXlRq/VnY8NsQ+QMSgQJwijc/r3iyah2bj+tZiqinF1EkyiJdyvmJz1coQIKLtHH855yRgmVHBTHMlvYSnxeYuFomHc/uHqMsUSw4b/VWv2ICRJoxF3PAmhn1b6HKEwtF4Z32uhWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WofppnzX; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WofppnzX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723585021; x=1755121021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hKrMjiMDyVckp3/gwqpKozSAo10IiJaj+ac5df79/cA=;
  b=WofppnzXPh/Z3hFi1R4ieo8/1zVsElPTVek7gLtXQ6QeF4m8+GBCz8fv
   HQrEC3zo5878w5hE/97C5QNaYXMhxhMoos57EGg41M5ekLdjCx1VTYPUK
   KjFYeeGzoXIRhwYM3WxzdcUgQPqnp7a5EelYd3krfAzu3xhGzwmYgUoG8
   pvUxkR7o2OThZzi/b9/2BP5E8BzLNfYLehQaxgaQzt4sb1PAjxlt7Lo7x
   Fzo0ImXbIKIuZN5HG/PLylsk50l0wcLg3tfb+5IZCnfSY71HYVQjnH8RQ
   rA3UWboSTtaPWojHK1uarCKh/Ot3vGhTMKOWVXcVNHOrVmFiUqIqvRYhp
   g==;
X-CSE-ConnectionGUID: BQ5LIVabQ0G5G31lTNF+iQ==
X-CSE-MsgGUID: tnFHKPTKQdSJ6Oj2DbDzvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21746627"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="21746627"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 14:36:58 -0700
X-CSE-ConnectionGUID: noKylPguQUGzlLdKkaAjOw==
X-CSE-MsgGUID: jqB+qEvyT5agNWCBgaRefA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="63734357"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 14:36:58 -0700
From: Andi Kleen <ak@linux.intel.com>
To: acme@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v10 4/4] Add a test case for perf script -F +metric
Date: Tue, 13 Aug 2024 14:36:51 -0700
Message-ID: <20240813213651.1057362-4-ak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240813213651.1057362-1-ak@linux.intel.com>
References: <20240813213651.1057362-1-ak@linux.intel.com>
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

