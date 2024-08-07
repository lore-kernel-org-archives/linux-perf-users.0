Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C5A155725
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Aug 2024 23:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723072719; cv=none; b=SCHU9RHM1Bo4CF05UJ8H+NTyrurYJJsX1LteYv2MnbybyRi5iCU3FXx5VpPsY3IB/Z5730VGFgDAqGs29LgdWSkIenErh6ug3VBmkv9TsNG+NR2UEHeBntyQQXqH3SYp8kyKsty5cpiID41gyTbxwcpzYbaB5w5NLgD3zWuo2cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723072719; c=relaxed/simple;
	bh=hKrMjiMDyVckp3/gwqpKozSAo10IiJaj+ac5df79/cA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFE8quzLaimQ3m7KGRMIS7BvMkQg6NuXWfZafhC9suEeQIkm9EqVqU+A+M5GdKCLPyQkKSAdkCveH7u0LeYif428+xgIaINlRpWCV9vJazM9zFfk3GISi0xX49qaDktFFQDrD8vgxrPI11j18vy2Lyss0sxd9Q8E8fu0zcR589g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FwDjQxfd; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FwDjQxfd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723072717; x=1754608717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hKrMjiMDyVckp3/gwqpKozSAo10IiJaj+ac5df79/cA=;
  b=FwDjQxfdZCxyy/8SEyRUmKO6nG1cgf6WUx7VjW408dhCcEPNpF4UsQnL
   mDECheQStUP5GRaVKgvLPDPF7YuE0oZaCt85ZHdUtIMUsoZ5W8+4WI/Xn
   V4OGWfB9ZoA/yRGrKBXr0/Mxk+t/h7QrNs/IVBXM6hXI0UHD+MFqkSKI5
   VIITCAz7dA8dkuRBRiqJ5FtkfEWbJ9iFOuI8WwDyoxW0ZvgnlXup2ruY2
   taHG0f5ixEEzZmyLMN1x0RJ8fzT4d+ihqm6FxUXvDcA8WyRTEsBV+lGoY
   ZZ2Iy7uFX5DI4N5PjMX9uYS8cZosQoU3ZL4AHKtMn1/OF7ygQLyLMVVqk
   A==;
X-CSE-ConnectionGUID: 7qleGjQKQz2GZX33SSpSxQ==
X-CSE-MsgGUID: /5ysV57/RO+hZ9Qv5ANuwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="32577984"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="32577984"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 16:18:33 -0700
X-CSE-ConnectionGUID: ICAuQcTRRuyFPaInyhpiZQ==
X-CSE-MsgGUID: NezQcnqtSRqjdv+r+y/h4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="87935094"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 16:18:33 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v9 4/4] Add a test case for perf script -F +metric
Date: Wed,  7 Aug 2024 16:18:23 -0700
Message-ID: <20240807231823.898979-4-ak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807231823.898979-1-ak@linux.intel.com>
References: <20240807231823.898979-1-ak@linux.intel.com>
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

