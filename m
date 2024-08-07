Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F090915B999
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Aug 2024 03:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723001439; cv=none; b=J05bc+DP658xCxu3dU7GL3NgSkeIhIW7VOVHQmH0WmyRy0bffn/QdKtRUOIkii30u3RaocmqQGpx1sOGJQ6aycKIzJBwneSP8FB9x+jKpHsN+f2kTuxuPhCXYxsivZxGGkfVOjrvWl/tVk8IY0+KyaOVyDzVcJqPe7Tu7x7GqWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723001439; c=relaxed/simple;
	bh=iZ+huTC2VeZXV+z82FTRA9rE5V5UkSLP1+4gd9Mepds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ir5OPUvJKwyERR3ECuPA3Wq8rpfhCN5vkmnecmSM5KjXYYmxXRwGwl5QB0JzzPS8sydNpgUgb12aR5hD1apOmpaH6OocYgBIIrTPEqA8gAmKjqAFO+mL5g4ma05uIEaFUkj05orP28a8olZPsodlOdG/0XVe3863hHuQuPSeD2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jtbxwbCM; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jtbxwbCM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723001438; x=1754537438;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iZ+huTC2VeZXV+z82FTRA9rE5V5UkSLP1+4gd9Mepds=;
  b=jtbxwbCMefQlr8n704NGUJ7jD2xmPN/gYPG4gmOxvGHoKdIWVlz0jYmE
   1wfU0afP8G2ZKFkaNYKNDVJ8bG+zKEkXLgUWITje+eCrT9BbBo78qMho7
   yiTZmEObGd2S0h/lTRHf58TXOegRnnGJmJQdNPuJIozcqvez0cIWrXkTI
   PTxS3j4hJnOnCMdmkRbNA7/J4PP+XYJGqdIo1V+1XrHIPfhWq31aQWVs2
   XdCPoBJGOsRdFg0t6mKS9FRcm7rqt6BIwCzfTrzL15rRHnUM6WEjUzB5z
   KIuv6KU6/qyP6LYi4sE+W2JZes9jxJMsEOnxkfWKjBL535rqhiVJmU28B
   g==;
X-CSE-ConnectionGUID: aTq7UcPRQ/asdJ0IN3DrIQ==
X-CSE-MsgGUID: LUk+3+lkTeyF4x6d+IK2Ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="32200034"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="32200034"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 20:30:33 -0700
X-CSE-ConnectionGUID: NUnu/T1pTHaO/GqWK+9atQ==
X-CSE-MsgGUID: CT3uTPEhRbGm3VjDiIMV0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="57399490"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 20:30:33 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v8 2/4] perf test: Support external tests for separate objdir
Date: Tue,  6 Aug 2024 20:30:23 -0700
Message-ID: <20240807033025.894167-2-ak@linux.intel.com>
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

Extend the searching for the test files so that it works
when running perf from a separate objdir, and also when
the perf executable is symlinked.

Signed-off-by: Andi Kleen <ak@linux.intel.com>

----

v2: Fix string test (Namhyung)
Handle both in source and out of source builds.
v3: Remove duplicated string check (Namhyung)
---
 tools/perf/tests/tests-scripts.c | 35 +++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index e2042b368269..8dc1e398288c 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -29,16 +29,45 @@
 
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

