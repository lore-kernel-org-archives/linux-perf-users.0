Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E822C4087C
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 21:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722547820; cv=none; b=kHSERMj6LL+ZD9WIdaNopEwBUboeL6ukQxBwx1/rhY1A6ffhLVTMwP0PJqnL2gwpR51qQELlsi4yb3v7B805rhDtkXc55iSWg5CPUnqwetVdi61OuccVQZEkbTE+F1QhP5bYR0NroAAzHo4+30vUaU9aN0nkZb2p8BXiLmRdaBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722547820; c=relaxed/simple;
	bh=aK0yMbvbykXt+JGJ0V5KA4czpj0OHDQ/fBm5ZxfDANY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQD4OdU/kxfzHogDj4Ymvz9lMifmb01XTThjY9npixtFhAq0vrSJN2CCEfsfcXNv9AM8fX1odKtFTNAQz0//g+ze/aYSSQoPprD+BzbEWd2GFz1YSp7mAE+FrWqwZ40MADyZ/JqY0jXjHNus0T0rVCs3DD5W1MMlhfeGaZGyaIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WwP/7nWe; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WwP/7nWe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722547818; x=1754083818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aK0yMbvbykXt+JGJ0V5KA4czpj0OHDQ/fBm5ZxfDANY=;
  b=WwP/7nWe2FHnbrC10Y3bOsPkxKjlsApl+y4msyG7aQYV7XE5QfnfoJrj
   Dbz6c07mn4s4QV3xLTAXys80Msa83FVdpZu0MZ1bYKXkSRdpfTdLpY2DS
   eyZGApGukZo9NvB1gHf1jrWou/IV/HGpaIAZaQBvfsyWvByeDDUb5eNaa
   o2oGS2GkhtjTdYWDs063tEwTPIU2McCQVJA1IhFAFyUAXLpcYlU183/Ec
   mAY7lCPd08e8YLAEDgfDnn3U0q/Sn4Mmdts8F7cOhW/1Mnv1/TelVKzfO
   gVKdZfKKJBeNUG1xRIfGszZ2kijOJPdU8FZBbVYCdI4TOlhyhoYjTVEk/
   A==;
X-CSE-ConnectionGUID: xk3ZbtnqS3Gn74+tEAc3Tg==
X-CSE-MsgGUID: EartlgPATuOHa9qD0Sm/Ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="24309528"
X-IronPort-AV: E=Sophos;i="6.09,255,1716274800"; 
   d="scan'208";a="24309528"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 14:28:55 -0700
X-CSE-ConnectionGUID: 7UkS14MqQdSyluqXY5qtAA==
X-CSE-MsgGUID: Xqm2KgxCSBiyy2xLyPekXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,255,1716274800"; 
   d="scan'208";a="55414350"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 14:28:55 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: namhyung@kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v8 4/4] Add a test case for perf script -F +metric
Date: Thu,  1 Aug 2024 14:28:44 -0700
Message-ID: <20240801212844.677895-4-ak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240801212844.677895-1-ak@linux.intel.com>
References: <20240801212844.677895-1-ak@linux.intel.com>
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
v4: Use :S in the test (Ian, Namhyung)
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

