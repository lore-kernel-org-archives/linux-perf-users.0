Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B1C4087C
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 21:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722547822; cv=none; b=QYRSh+JBGoODkxNngiOIilizyJzStZOzaVoaEmcsuhjMtDlS0nOEiKexsMYJPLJevLop2xNT4X4tpnV4dsotcEVVbxGvd/k5wFujrurSHvBsCCikZsyV422JUGW6PnwCZp6t92Xn1Q/rkfvy1pQmRvzLW3NB1WsNCB/gWYNcGYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722547822; c=relaxed/simple;
	bh=F0t7iFfNVTajPbtmBi+NDj/HoID5+yOCfGDTFoQkM2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L0kiwDZBcyYfOWQW8fLTclgiymyyY7a66MIxnSygKptauH00ZZqgTdq+yQ9hxrBkYyeO/ZhN9HGBTzMW5+jh0tX5fFTHGxMhkRCyyivLrgSLOBerrrA4sr6xUYO4cdy0BccRQGGqig3cjdM4nQW2yZGSebxiirzxmWxVuNhlseU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fH/cPDir; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fH/cPDir"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722547821; x=1754083821;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F0t7iFfNVTajPbtmBi+NDj/HoID5+yOCfGDTFoQkM2g=;
  b=fH/cPDirT1iSN8tU+M0Uz0Dt9Xo3yJlRxX9OdQWub294KR2McNamGFHA
   2qoAMlTE5iKO6TEwZE2x6Odc1w31SrpMQhrxfiXvZE/BFMD++KIN/GcOO
   PYEW0xjwRFZuiKGQ8bgG1XAxMfySuL2Ja7On34T+THbANw++P33p2dtv2
   yilzr0Kms6vGN5d1z4JSb0uoMIJ2FbEYdS8+gAX88i95MyWIj4BSiQhFb
   U7FZWICmJyoX02JFiwF4zK7Zc4N79bj74crd07KLtXJnFwJLEVJz3FXXn
   79UXeXJlD62hU1+CGgV9A8rHPi7oXrOdlCVuPFrQEGQH2qCB7ihkxxIwf
   w==;
X-CSE-ConnectionGUID: q+91WyFMSti9aL7H5MbHdQ==
X-CSE-MsgGUID: 9+d2+vMhQ/+F41GLtAn36A==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="24309526"
X-IronPort-AV: E=Sophos;i="6.09,255,1716274800"; 
   d="scan'208";a="24309526"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 14:28:55 -0700
X-CSE-ConnectionGUID: dAYsDFydRY2mg6b7azrWYA==
X-CSE-MsgGUID: OLVVy2mBQcOuWmziR8sK1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,255,1716274800"; 
   d="scan'208";a="55414348"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 14:28:55 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: namhyung@kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v8 2/4] perf test: Support external tests for separate objdir
Date: Thu,  1 Aug 2024 14:28:42 -0700
Message-ID: <20240801212844.677895-2-ak@linux.intel.com>
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

Extend the searching for the test files so that it works
when running perf from a separate objdir, and also when
the perf executable is symlinked.

Signed-off-by: Andi Kleen <ak@linux.intel.com>

----

v2: Fix string test (Namhyung)
Handle both in source and out of source builds.
---
 tools/perf/tests/tests-scripts.c | 37 +++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index e2042b368269..9f71ffed702c 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -29,16 +29,47 @@
 
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
+	if (p)
+		*p = 0;
+	scnprintf(path, sizeof(path), "%s/tests/shell", path2);
+	fd = open(path, O_PATH);
+	if (fd >= 0)
+		return fd;
+	if (p)
+		*p = 0;
+	scnprintf(path, sizeof(path), "%s/source/tests/shell", path2);
+	fd = open(path, O_PATH);
+	if (fd >= 0)
+		return fd;
+
 	/* Then installed path. */
 	exec_path = get_argv_exec_path();
 	scnprintf(path, sizeof(path), "%s/tests/shell", exec_path);
-- 
2.45.2

