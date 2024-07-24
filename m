Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DC34655F
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jul 2024 19:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721847707; cv=none; b=nslV73+ZKFRoduyGZHzhL69r0Vl54AhkZsDZpBpt85O4tGxYM/IS33VCi4ffIatfEE9quRl4ZMup3X3bMtWgTQ9FpR66z/PSC4ERZileix+57XWruQnM752KlG3Qi1BR3bcgCI31hBBhDs5qIyjyMHKjRel14fyDGdzqQm4iLB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721847707; c=relaxed/simple;
	bh=8ASWtkbfDM6Rdt9+A+iOWrGsodZwZdvTVwXWmJzCRZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oImckMW71UyjCEDols1zKe59Kvgo+I/kiu5kY7pBdDaPNyyBEqE1YFFcm5q+ziUEZAwUdrnT+qlHctQQGZWzv5L0KkGQJmiON2Djc/hfRbVhi4BuOc6FCFHZEW4GzIjmkDKHLVR1s5i14cXpiA0JaNAnBhBlU2blIjO36oyTSj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VAoHYbpi; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VAoHYbpi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721847706; x=1753383706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8ASWtkbfDM6Rdt9+A+iOWrGsodZwZdvTVwXWmJzCRZQ=;
  b=VAoHYbpi0fpVs4WFpHJA//ahvojckY0PLcqF/vu1BBMwaSsyBz3B1fYc
   zbnBs2whiA2LQkW1HQ/e7iJR3Nv6ejPFs2oeLeOZTsiYcQSw0qnCQFAzV
   M/FnUdWQxkclTORaTgrzFw2nKQaNfBEbiIoRB6W8/FhdHiDndZF78iwAf
   WjxHK6LTFFfof6TwrQxDyjHCdw3O/kH+tqhjRkPk1d4i+r8yyIVoa5MTW
   B3KyYlJ0Pvug0nInQgOrbt/XAN6/QEmwCp8wDIdnOKHGt8eARFWbf4PNk
   ZADre77XrjWBZm6VeGZPrMIk6xoB3axixDotLsqseJTztpvCEtXzZnj2N
   w==;
X-CSE-ConnectionGUID: Bmm0Oh0UR4eqbajE6E7ePw==
X-CSE-MsgGUID: UXhQv+1tRdGSzEJA4/qjzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="19685236"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="19685236"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 12:01:45 -0700
X-CSE-ConnectionGUID: MCLjAL2yR3y5KT4SNgjXoQ==
X-CSE-MsgGUID: It3hVo9YQnuBdQCamIXO+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="52907011"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 12:01:44 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v7 2/4] perf test: Support external tests for separate objdir
Date: Wed, 24 Jul 2024 12:01:35 -0700
Message-ID: <20240724190137.3810429-2-ak@linux.intel.com>
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

Extend the searching for the test files so that it works
when running perf from a separate objdir, and also when
the perf executable is symlinked.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/tests/tests-scripts.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index e2042b368269..63be17289ac3 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -29,16 +29,41 @@
 
 static int shell_tests__dir_fd(void)
 {
-	char path[PATH_MAX], *exec_path;
-	static const char * const devel_dirs[] = { "./tools/perf/tests/shell", "./tests/shell", };
+	struct stat st;
+	char path[PATH_MAX], path2[PATH_MAX], *exec_path;
+	static const char * const devel_dirs[] = {
+		"./tools/perf/tests/shell",
+		"./tests/shell",
+		"./source/tests/shell"
+	};
+	int fd;
+	char *p;
 
 	for (size_t i = 0; i < ARRAY_SIZE(devel_dirs); ++i) {
-		int fd = open(devel_dirs[i], O_PATH);
+		fd = open(devel_dirs[i], O_PATH);
 
 		if (fd >= 0)
 			return fd;
 	}
 
+	/* Use directory of executable */
+	if (readlink("/proc/self/exe", path2, sizeof path2) < 0)
+		return -1;
+	/* Follow another level of symlink if there */
+	if (lstat(path2, &st) == 0 && (st.st_mode & S_IFMT) == S_IFLNK) {
+		scnprintf(path, sizeof(path), path2);
+		if (readlink(path, path2, sizeof path2) < 0)
+			return -1;
+	}
+	/* Get directory */
+	p = strrchr(path2, '/');
+	if (*p)
+		p[1] = 0;
+	scnprintf(path, sizeof(path), "%s/tests/shell", path2);
+	fd = open(path, O_PATH);
+	if (fd >= 0)
+		return fd;
+
 	/* Then installed path. */
 	exec_path = get_argv_exec_path();
 	scnprintf(path, sizeof(path), "%s/tests/shell", exec_path);
-- 
2.45.2

