Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F421534EC
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Aug 2024 23:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723072716; cv=none; b=SGDCciagnZVcUz89dWzhpA6Fduw9fxY9Je23/pffasFETNb6V6oXAX0QTyt69mdiBt3ah5ocWOluhmoboZ8iGyfGU8Qa9T1Wuh932YVKP/C3HdAhixSJtjqvdsftlQomSSIeuliYorRGYs9zqSkrbOKQY6T1Cp50/pWrtsv251g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723072716; c=relaxed/simple;
	bh=iZ+huTC2VeZXV+z82FTRA9rE5V5UkSLP1+4gd9Mepds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZH/Gew2BdpA7u3wGbiRifoCCnMcHi7ysa1YNaETqRjYCQziuDVhBikVkclqP+Sb+nY7ZQM+MpLvDmAHPxBK/DgdqaueOqy4uHa20D9xeG5oNvHIi7a+RCP0K7zZeOGtUDN4C2mFcoENOp+h83NUkVJf6FgjOZ+Ui9Wdu08pSkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dScZBJdV; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dScZBJdV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723072715; x=1754608715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iZ+huTC2VeZXV+z82FTRA9rE5V5UkSLP1+4gd9Mepds=;
  b=dScZBJdVYrPHH6FJ0yQKo2epCp9cheJsqA+Vs/OQgI7qE1lNtdHqZoMy
   +8GXAkXMx40XVh9nRm6dXJAVqLwulf0xPEkiSqVC5Nb8kfTRWa8MAFIZw
   ziHB5jqwS7B4FvHlLK7v8bufqceGX6Af/vBB/A0bPBxMx9s7i0u9Y8y5t
   kdk3yEn6eIeXUPc+DPrs0pBOxlpiWV3T2l+5k73RF1zAsvahNFZmeH8eC
   YScY/uq+gzcBVFxESVVw/Xjr6dPRPw0JC819wgpCQDnGquB3xDq1RRtaD
   XX/44RZ0oF8rfK+K+QJZRvKnGBM0n6nY0rvyo1dQaA8LmjxuH5XJ9V82K
   A==;
X-CSE-ConnectionGUID: +G59OeXASPenuL1/GXDLGg==
X-CSE-MsgGUID: Olgyuj2mTJ+uzw65WWs4Qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="32577980"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="32577980"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 16:18:33 -0700
X-CSE-ConnectionGUID: G0r8dGwSTf+QZUpTXcsm2A==
X-CSE-MsgGUID: 8S7qFeCESAmSwPaCzgnAOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="87935092"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 16:18:33 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v9 2/4] perf test: Support external tests for separate objdir
Date: Wed,  7 Aug 2024 16:18:21 -0700
Message-ID: <20240807231823.898979-2-ak@linux.intel.com>
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

