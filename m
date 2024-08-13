Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342821A76D5
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 21:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723585023; cv=none; b=Y/YBB9Ei6YoKu2TQ107moKOQTk+TvuizSYiw5PhsOoSYd4JotAxZYu28TyP4CdstFbN7whU4UUZqGoBhDSIT21Thr5MOuuftcQMHjxqhvus9EKAVSaJ2sYnR3HkjpIuAx4y9cT0aeBm3DyfKYb/I6jWlhL6IBIusD56KGRcZwUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723585023; c=relaxed/simple;
	bh=TOMqMiWNXgbqstyXwhZJ4rz/CqU5PeSl2+BJnXwzdCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IbrorKvifqkTSAUYNlE538F8IYD/zYFVRM9lXEBAjoCTERJ56avtMcDAx54HMgs8KCK9GQGFuouwB8DmLBvWYra5gAI+KtSi0NqIwuA3xKz9369f4hVIwFnsHig+UTayDDT5VZ0gloPIxyVIBm0g8bX3uqcvv6E0xywDM0yH0bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IG2A+fQ5; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IG2A+fQ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723585022; x=1755121022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TOMqMiWNXgbqstyXwhZJ4rz/CqU5PeSl2+BJnXwzdCw=;
  b=IG2A+fQ5SG21EsfvH1uU2N10gu2w/rBW3NjlLCA4Gtfr9pmnehoMtfzy
   XS1qzad5H+AIJ9cw4TsUhdt32htzoDiUYGBT7JU11149vDWZQ0v1K/ELW
   TcnpCblDMp577rD97QA81Zl/SDTSDTsLX+fnSskdYvgg2WWNJGTqgdYh+
   Tc4xoJeuEFq36uUjCcE4CbqgDVF+cAODBu26lol4BzhvCQo28kIdaLZMw
   X446ZYgKp+Su2x+G3SQ7QBY0mEr6qyOFLIgk7auYYNPou1rhJ//35N49l
   2dtZKwYGUEppDjdehdPFi+DSvRpQ0z6hvPtznO9wFe291qhCK1aiyfH98
   Q==;
X-CSE-ConnectionGUID: IiWWrBA4SO2J4S8gyc+hcw==
X-CSE-MsgGUID: mtWJyyvPTtWnXbN7ZHuz/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21746623"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="21746623"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 14:36:58 -0700
X-CSE-ConnectionGUID: N4P2XoQLTe29PZkQxN1Ohw==
X-CSE-MsgGUID: HhRzkXTgTYS/x6E0UUGqAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="63734355"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 14:36:58 -0700
From: Andi Kleen <ak@linux.intel.com>
To: acme@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v10 2/4] perf test: Support external tests for separate objdir
Date: Tue, 13 Aug 2024 14:36:49 -0700
Message-ID: <20240813213651.1057362-2-ak@linux.intel.com>
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

Extend the searching for the test files so that it works
when running perf from a separate objdir, and also when
the perf executable is symlinked.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>

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

