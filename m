Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F71815F3EF
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jul 2024 19:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721847711; cv=none; b=qDxKgjamocnTGhjRSmayP3pimV64FzPhZLjcUQADnoWm4xVTcmCCInjv06lzQZDyb6Zzjctwb2qkYAvnp4EzGOX0XB8mmUInpF/s/IPXd6Y1ZAZJRNnT4NTe0HI7i63SyExPdO1P4MfAxZzehHMVt/1QjHQqA03bUbhuWLK7/uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721847711; c=relaxed/simple;
	bh=/tcKJ1C1eResv+EgzDrPPOUOPvdU1vznAyaWlg6YFiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enHD9ARr++iXMlun3yplC5J3YC6+F8DbecmS2q3ehtZu81LavQIiA63trh9IRfddN+F0nkl4SQGkRgzAZbXh66Qs+v0HNpuA5yZXWrzXPc5A4cKOq2lwoHVUcDEwNPWVKMv23owDEYbJVU3+gAtbEJZBghAdbRxsINAhuXl0s0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c6Mm7i2N; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c6Mm7i2N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721847710; x=1753383710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/tcKJ1C1eResv+EgzDrPPOUOPvdU1vznAyaWlg6YFiU=;
  b=c6Mm7i2Ngot+VJMwLfPHRPV6pGnyO37c/VecNNYODlj7JUsak8YmNJDq
   z9lVJvy5oceeQA7V40hbIkoExt7uZikrETTbfKAUtpzm8SW47P7EcipdO
   OKT5/teB1yuLDUHBQE35bGPxO9Xn6/stD9YxZJF0Wux3IAyZzZN91rz/U
   IwPS9PmDeFd8C6nPBRifIOs5JJRtK5r47CsquINIMft+uAsSirZ69XMU8
   NGGuy+P0WQ77tihrko+SdhtHv1ywlX4uW16icSjwRnQzri7DF+SLNGp1M
   zKx+XqdoCAjjbJpTPoWfkWkCowYTqaDZcdOJyIrs7wg8dxavBQJPCnVN4
   g==;
X-CSE-ConnectionGUID: hyFlaI0uRky7THdR+4u9Ow==
X-CSE-MsgGUID: BtN4HA2wQJye7dGIc1k64A==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="19685238"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="19685238"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 12:01:45 -0700
X-CSE-ConnectionGUID: dPO5LKEqR5ma0wUHsQPf4A==
X-CSE-MsgGUID: leHyXFXUSIKnJ/xVLM/mrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="52907013"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 12:01:45 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v7 4/4] Add a test case for perf script -F +metric
Date: Wed, 24 Jul 2024 12:01:37 -0700
Message-ID: <20240724190137.3810429-4-ak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240724190137.3810429-1-ak@linux.intel.com>
References: <20240724190137.3810429-1-ak@linux.intel.com>
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

