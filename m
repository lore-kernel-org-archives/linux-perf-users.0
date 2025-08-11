Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73B32BF010;
	Mon, 11 Aug 2025 05:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754891832; cv=none; b=msIoAy+jVVd135IMes2vQK9L7aOfSH9Buk5AGZF+VTscph223RtY1Aln4gqUPMQJ/4mCkUwa9m/ahJgEmjEcbPkFcjSlqQhxh4CQtpC0Q6e61CJ/L86W10kChOFxar8gypkdMYQz4EGICva4Z9edcHGl6ehVC354o6NatCjPFns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754891832; c=relaxed/simple;
	bh=6MldIzulSaPRY9KzTb4GmAUEjZN5pjxqmqYwU4caWBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jxSHYXhY+yxI308znlKJos0ffJFt1lxLJKy2H8kWcRm3Dktf89xGUsqf+UDDPSXrMc9wwO4h9Jet01yj/cAqrvMEJowqL/dJrwxaeTHPLJb5n6MP9whUGwrDJoL/UTdmwBK7nhnnmPx7tEDdn61RVbLJObSEkAuxG9vHhXZCRu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lvJl+dx2; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lvJl+dx2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754891830; x=1786427830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6MldIzulSaPRY9KzTb4GmAUEjZN5pjxqmqYwU4caWBI=;
  b=lvJl+dx2xKcG+V1etuKGeyJucA2EEU2F8a3VexMmotT4bzTVl7TViG5u
   tso60QCAPY7fsRv82q7DQz7fPtH9tXQ6jK36YkMZS3YIp28uKW/2a0A2J
   ndJ0isptDpch0AQOqNrln0EPVyn7U3OnBn/XCkMXDC3vgy3fjtSgH5opX
   qISwh3GP36IVNgMXlZSZJudeB2Pj3ILZ4xfRL6Og8ZEMorf9VUoTnnUE6
   nwza9J/9skgsnANySn2ZLGgqN5InkKWeG7f447i+sbrwJ/hRwy+VZ7F1q
   XHoeJYtF9Xo5KU1pNRYQb+ZrByI36XMbsqUJFXDAscinVtnrl/ZUVUDgH
   Q==;
X-CSE-ConnectionGUID: qCNfIq69TqmMn5YIs0baMg==
X-CSE-MsgGUID: KMYTk3uXS+S2FJTATJKE9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57043634"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57043634"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2025 22:57:10 -0700
X-CSE-ConnectionGUID: VGQYvMjETtaMCd3OBscLgA==
X-CSE-MsgGUID: WuLENUXrRKibdQWcJTAcgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="171183774"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa005.jf.intel.com with ESMTP; 10 Aug 2025 22:57:08 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v2 6/6] perf tools kvm: Use "cycles" to sample guest for "kvm top" on Intel
Date: Mon, 11 Aug 2025 13:55:46 +0800
Message-Id: <20250811055546.296678-7-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811055546.296678-1-dapeng1.mi@linux.intel.com>
References: <20250811055546.296678-1-dapeng1.mi@linux.intel.com>
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
Fixes: 634d36f82517 ("perf record: Just use "cycles:P" as the default event")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
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

