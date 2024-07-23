Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9792142624
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jul 2024 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721767730; cv=none; b=AhUHtnHTwD/EvuOHfWlyvqcHP0dz99fso6m2fj+BWvEJBCyQghvgBeh660Qqwf6liW+1cQkJ8LgpguEruXVRaxf4tW1Z1k9acCyWz7a3ztGFkEZCnjFxp7FCvPDcqtzEMpZl1Dl0m7Rm6w86vdN2vtdd/Yxw/iKqVdxPPvfP/6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721767730; c=relaxed/simple;
	bh=8ASWtkbfDM6Rdt9+A+iOWrGsodZwZdvTVwXWmJzCRZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dabgQSMgWEDzVzzJuPoyFl01yuSyQklAZD6t3vL+2G68FvM1B864660cgIdHv7bYKrZ7jHvSMDfqOj8VDs98GYhxql1wNWINxr/md3QJqSqQ49IRYx0yFTxepSoBwnmCX7j8X7Pet/N2keZhbirQbRbOmS+/XG2HKXhZvKlRVv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BqbU25b1; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BqbU25b1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721767729; x=1753303729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8ASWtkbfDM6Rdt9+A+iOWrGsodZwZdvTVwXWmJzCRZQ=;
  b=BqbU25b114p9ED3oNhyJf+81PET49Jyp7XvG0odqpMTWVZ00cUzAdWOI
   t927RJTeP9MQZZbAryu/PBYB4p+qJ3MjBOHVXn41uXuYDC8Y+ectZqlDE
   GEXrRRUm0x/fBYnNAuCvCaov1mnceS+uCCoL4AXGkDyvf0bfLaUTvCKBc
   AGQiPBHJoNdXHZsdG7sOoBSdI8zsL7nHY6YOG8ZN7DPF/asLM/+QOOVGD
   SdG54o22qpln55LgvN5PtYavgqWc0l1yo/fuxjMN4JWMkwx4Jn9ekmYfu
   pcw0ZezqXLBZB3C3ACX4sS8R3cB3fhT25B2Vz2MO6tHcR2exjfhy0umRV
   w==;
X-CSE-ConnectionGUID: CYLLg6a+THeEHlLz4k8VFg==
X-CSE-MsgGUID: jAm95OjeRqiOPFC8m9X2Fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19564601"
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="19564601"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 13:48:47 -0700
X-CSE-ConnectionGUID: M8MWgp1bQ7OVt6AYZFZS0w==
X-CSE-MsgGUID: lF8JzNWnTaK7J0+fTOqVVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="56654795"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 13:48:46 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v6 2/4] perf test: Support external tests for separate objdir
Date: Tue, 23 Jul 2024 13:48:32 -0700
Message-ID: <20240723204834.3617647-2-ak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723204834.3617647-1-ak@linux.intel.com>
References: <20240723204834.3617647-1-ak@linux.intel.com>
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

