Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074F21D5CE0;
	Tue,  5 Aug 2025 00:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754354867; cv=none; b=kPYMdYsRvbvR6x1ROO9eQstHKjcFeHgNj7gWepjEbyNlYPNtEOdyCeBdKqIuIMxQP3GoniR4krWPet1qEM8RSuBRcbti/nozyuYgHTskZFLAoBGZwm7eyCMb8rcVG9HAfTtC1NOEx4/AvD+S9kMDQwFwx21SqdfUEqRbjrYoLK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754354867; c=relaxed/simple;
	bh=vb+WjZ8ROih9VWNeO7ua4iX4AEM72JhLQRXT0CLNnVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ulmqzXUd5FHDrha/kBjuXO3mRNCaSOtBnmRij2xNuLnazqdxTtSy4BadqJDzae/KOthe7f27V3Jil3KCo2GnCHIfB8lWaxNyNq9Y95v6/cmjTIEGQU1gwldS9kYMbJj42QYlIYkqIWuQKBSiAU6o9ayN0jzGL1TM3h/xZLclJw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=biXRyU09; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="biXRyU09"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754354867; x=1785890867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vb+WjZ8ROih9VWNeO7ua4iX4AEM72JhLQRXT0CLNnVA=;
  b=biXRyU0905gr5BvU/SMpaJr46EIXp8lJCq+SJP91Yl/Z6qnj5v7W1Pai
   p2cvjtAdRdK9TlDrs7C7lDki50JA9palEYJ8eMk+f9Xt3bRVHAMSOf8oq
   lOTVqpzGP8Q16bOmDHyjEfHenjd+fR/KrqZpwgLEtSD5foJB3frthInXG
   zJV65XjiUqA8jhHyYA+oKnIZanETHS9rrVFpCw2h7hcFldB3OADJXZ6S7
   mxfimzKStPuptPIgnqn1E40PcOIuLp8a5byU3nV23UFneVR0zSkX9OLFz
   Hg+XlXw5SX7WyCIS6yXJqME81ylQPDm/lMvlVwnKpTkbWm4nyBYf/vLti
   g==;
X-CSE-ConnectionGUID: l9PsaLUcRNal393PA9Y39Q==
X-CSE-MsgGUID: YYuF1p5kSN6KRnJwSbCtaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="56523859"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="56523859"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 17:47:46 -0700
X-CSE-ConnectionGUID: drsN2BjkThK9T3mWREb0yg==
X-CSE-MsgGUID: Ny5WNCWHTcu9S+EpzorcAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="169605490"
Received: from spr.sh.intel.com ([10.112.230.239])
  by fmviesa004.fm.intel.com with ESMTP; 04 Aug 2025 17:47:43 -0700
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
	Kevin Tian <kevin.tian@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 5/5] perf tools kvm: Use "cycles" to sample guest for "kvm top" on Intel
Date: Tue,  5 Aug 2025 08:46:33 +0800
Message-Id: <20250805004633.135904-6-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805004633.135904-1-dapeng1.mi@linux.intel.com>
References: <20250805004633.135904-1-dapeng1.mi@linux.intel.com>
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
 tools/perf/builtin-kvm.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 7e48d2437710..d72b40f3df12 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -2075,6 +2075,34 @@ __cmd_buildid_list(const char *file_name, int argc, const char **argv)
 	return ret;
 }
 
+static int __cmd_top(int argc, const char **argv)
+{
+	int i = 0, ret;
+	const char **rec_argv;
+
+	/*
+	 * kvm_add_default_arch_event() may add 2 extra options, so
+	 * allocate 2 more pointers in adavance.
+	 */
+	rec_argv = calloc(argc + 2 + 1, sizeof(char *));
+	if (!rec_argv)
+		return -ENOMEM;
+
+	for (i = 0; i < argc; i++)
+		rec_argv[i] = argv[i];
+
+	BUG_ON(i != argc);
+
+	ret = kvm_add_default_arch_event(&i, rec_argv);
+	if (ret)
+		return -EINVAL;
+
+	ret = cmd_top(i, rec_argv);
+	free(rec_argv);
+
+	return ret;
+}
+
 int cmd_kvm(int argc, const char **argv)
 {
 	const char *file_name = NULL;
@@ -2135,7 +2163,7 @@ int cmd_kvm(int argc, const char **argv)
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

