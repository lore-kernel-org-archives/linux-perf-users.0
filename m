Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC2E25784A;
	Fri, 19 Sep 2025 02:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248337; cv=none; b=cNPHKCNThH1nT26yVgfR81E/KWthLjEzV3BRxVsvEV3eOZnXqsHDo4/suqg6C3pymunUfkza4chV7EeHxXz1I4XznqE3ucmPFpJ2bD3gJN58zfJQmmtpowg6UBm67HUPpC2IKIShwql+sHBlfTcUaOOrzFVpOA74zS4nZny1E+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248337; c=relaxed/simple;
	bh=k8TZ0MrGjVQ8MHNSQRVAWklPMEf4TggTJTigNzpkZi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PzN0lvYPvcklScdrklj/ozDJ4fYPEmGvq+b82dx7zn5S+UrRtiqms+sjwqRFdIwRnRqcLPDjf/I70EVfVRLsiwEkj+5DUeyv1kNRS2XZaqZw//cI49Ze/J9M4/8dhy83sNZITdWkp5HHO1/K1LFEMJ53rWV/Ea4sSpjHME7tedY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dqTUSDke; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dqTUSDke"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758248337; x=1789784337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k8TZ0MrGjVQ8MHNSQRVAWklPMEf4TggTJTigNzpkZi0=;
  b=dqTUSDke8ZmtTQPStSvXRtaSxHx/H28dxCIlJOMCHv69FVH6bu/i2NWI
   pCBn0fH1OGI7uAk1cGZqZu+hkouIXncCS7SwMGEdSBdNpRl4kXfE+wpl9
   dAlb3DQ9L2Fs7tpha53vbKAqAQMkyDRVwA2cz3uGZUFPrRUd4++xF7U4f
   gOAcM4Y8NCIhJlJ+tn78Ql+12pleCYWTSe6Kwe5/vnMEwfgfI5ZSimzai
   PaL5HWnse7I23R4Ldea/hRUpr4kky2jPWuNcnthF+mkJ4Eoyj84y1JWpE
   3O75vttV0JZ6u6vVDaH781Uj2VNaUSG2H9G394OF7l+ORRxVXMPaqIQwT
   w==;
X-CSE-ConnectionGUID: D+rLXfoTR4ajkieTEqYx2w==
X-CSE-MsgGUID: gNj/qIjwTFOLDpD5rLQA7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="64229168"
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="64229168"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 19:18:56 -0700
X-CSE-ConnectionGUID: JA9H6aN1SpWt3R2jBTne7w==
X-CSE-MsgGUID: Yqg3UeuyQDq7sSBwPZJAfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="175535638"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa007.jf.intel.com with ESMTP; 18 Sep 2025 19:18:53 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Subject: [Patch v3 6/6] perf tools kvm: Use "cycles" to sample guest for "kvm top" on Intel
Date: Fri, 19 Sep 2025 10:16:59 +0800
Message-Id: <20250919021659.1263351-7-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250919021659.1263351-1-dapeng1.mi@linux.intel.com>
References: <20250919021659.1263351-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As same reason with previous patch, use "cyles" instead of "cycles:P"
event by default to sample guest for "perf kvm top" command on Intel
platforms.

Reported-by: Kevin Tian <kevin.tian@intel.com>
Fixes: cf8e55fe50df ("KVM: x86/pmu: Expose CPUIDs feature bits PDCM, DS, DTES64")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-kvm.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index c0d62add4996..f0f285763f19 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -2084,6 +2084,38 @@ __cmd_buildid_list(const char *file_name, int argc, const char **argv)
 	return ret;
 }
 
+static int __cmd_top(int argc, const char **argv)
+{
+	int rec_argc, i = 0, ret;
+	const char **rec_argv;
+
+	/*
+	 * kvm_add_default_arch_event() may add 2 extra options, so
+	 * allocate 2 more pointers in adavance.
+	 */
+	rec_argc = argc + 2;
+	rec_argv = calloc(rec_argc + 1, sizeof(char *));
+	if (!rec_argv)
+		return -ENOMEM;
+
+	for (i = 0; i < argc; i++)
+		rec_argv[i] = STRDUP_FAIL_EXIT(argv[i]);
+
+	BUG_ON(i != argc);
+
+	ret = kvm_add_default_arch_event(&i, rec_argv);
+	if (ret)
+		goto EXIT;
+
+	ret = cmd_top(i, rec_argv);
+
+EXIT:
+	for (i = 0; i < rec_argc; i++)
+		free((void *)rec_argv[i]);
+	free(rec_argv);
+	return ret;
+}
+
 int cmd_kvm(int argc, const char **argv)
 {
 	const char *file_name = NULL;
@@ -2144,7 +2176,7 @@ int cmd_kvm(int argc, const char **argv)
 	else if (strlen(argv[0]) > 2 && strstarts("diff", argv[0]))
 		return cmd_diff(argc, argv);
 	else if (!strcmp(argv[0], "top"))
-		return cmd_top(argc, argv);
+		return __cmd_top(argc, argv);
 	else if (strlen(argv[0]) > 2 && strstarts("buildid-list", argv[0]))
 		return __cmd_buildid_list(file_name, argc, argv);
 #if defined(HAVE_KVM_STAT_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
-- 
2.34.1

