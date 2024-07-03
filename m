Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACA0804
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jul 2024 01:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719969668; cv=none; b=BdbPRynpY43L4Q3zaMUo7b+CYlf+DimGtC4fxlfXbe2CDiW+B2LGjljv1gZ2UP1Q3gb1X3TrW8/tkj4K/8oJYxOJcV+IfB0AHVi5LDKzRB/wLOoOtsocPy0X6XSCHsw4M7RmKk65SHqUx9iRXbaKIKMjvPjdzQqDlIzvJZgulMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719969668; c=relaxed/simple;
	bh=/tcKJ1C1eResv+EgzDrPPOUOPvdU1vznAyaWlg6YFiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EACRnYmioxhvKDwURdbt+JN6UOim/tPRBety669aQC7yy+5gCDcsPO5WMiMv0CFu/qXlSLHXYiX07oujFHx+zy8+Y31ukahCCEbLocI9e451alw8+/OLX1qXewdw0DkpVwMa87Jm7NE98VFhWG3way01ZwE2dACt/FUOiR7aCmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S50GpgPL; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S50GpgPL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719969667; x=1751505667;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/tcKJ1C1eResv+EgzDrPPOUOPvdU1vznAyaWlg6YFiU=;
  b=S50GpgPLDZveSsi+FeQup2i48odpE0ggGSLxiVwe9pIJIFW7X691f8le
   6+1zd79SDAwDWJ3CinGrr4FTQNt6S1V6dUIeRkxq+sTYUBNjwMj55tHBO
   XAOBuhRSOr3YdRDVMsX0igIKlAS4EluuAfu1QwSkIJU65YPjYmXFbxEp9
   gX4SSq19WUJxWFuGc9vTUzWMQ8H8E279NFMF0SixFji5Fl5+85uujK0Zl
   ITLjXVkDd/pRyUIj3DPZclQejNcBQJHtQGM2P6BuI4Yeptul/TZoillid
   k+S4yE6TAZgOjhxZ0sUUC8Lw2pEbZXxnSVs+oitz8be5WBZGp50+tPiRr
   w==;
X-CSE-ConnectionGUID: d6B3skAKRCiZcZRGEInShw==
X-CSE-MsgGUID: ROXWggx9Se6qn7qe8CcQ/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="20942436"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="20942436"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 18:21:01 -0700
X-CSE-ConnectionGUID: clDhYYDARze9zx+c03wxxA==
X-CSE-MsgGUID: uZoPhwjAS/S/N+N2zfLcSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="46065679"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 18:21:01 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v3 2/2] Add a test case for perf script -F +metric
Date: Tue,  2 Jul 2024 18:20:47 -0700
Message-ID: <20240703012047.178561-2-ak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703012047.178561-1-ak@linux.intel.com>
References: <20240703012047.178561-1-ak@linux.intel.com>
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

