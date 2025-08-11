Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE24327F198;
	Mon, 11 Aug 2025 05:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754891822; cv=none; b=Ej1+z209X7bwT5016tw6g6Wa3bw9s1AYLnyDv/boxVZEL7018vaNrXryWLvY59LtgmByUJMLBRlGNxh3R+ubVAqooQ0EefNuveA323s+TZZSGPyrGdRPtQ6QaWgnQUX9YbRZ2QRE8EffAR5TEzQl4bLV26GDcH0b6YAsDrQoarc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754891822; c=relaxed/simple;
	bh=6x8+xmDoFCyGeGPvfKj2sYz5vmSZ2U3waR79YqsXTug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LrcMz+FyN49MfYyD8KhByaGQxiweiN/LFeXDcaH+FIa6+Z0wmxs2tlRDyRsmHPZ++74Crt8bpMZF3Xogqkz0Xv8SVoVtxtdjz6+uuRfiGhjc1o8mjHYbmzhvokBehXjfWOyV4t2MR/4n9TdCZU3BxaReVMmlettwCCSoXlUOH24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GSAXSzyb; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GSAXSzyb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754891820; x=1786427820;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6x8+xmDoFCyGeGPvfKj2sYz5vmSZ2U3waR79YqsXTug=;
  b=GSAXSzybz6GpQbRln64g5mqvqZJhZHjBKdGwZYiUmeEhsIO2SenpcX2O
   5WtDkMNBdCqBnQaAO8Q/h9eELMvLAasWf+0hxo24aIxNGjOC5W1ORgsux
   byrfLpxi0mrDpcIMVJTXiMQ+udKHzYmUQZ5e2aplQuuiLxOKtPodvN2bH
   oyLQervU6OuZjM8Iy1+2Dh0puteSc/9kyIpNYiiIiOx2vNIN4V5q1/kPI
   LCHIQ6ufSfxoXBIWUYSJfjoq65F25hBXmmMuWrodpmrnrSEdii0Sl3rXr
   3vz8uXGCj/3EZOSKhYvDVdKb0blmyS0ilzhOlH56qI3TJr9WR2OhSgMuX
   A==;
X-CSE-ConnectionGUID: uukL/QuaQouKQ39YmyGhgg==
X-CSE-MsgGUID: pM6txODISm2nxHVwu8YtQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57043615"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57043615"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2025 22:57:00 -0700
X-CSE-ConnectionGUID: gIKeX1amTGWVRoXQ8oS6nQ==
X-CSE-MsgGUID: dMMoP2hSRDiSepa/g9Q6gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="171183724"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa005.jf.intel.com with ESMTP; 10 Aug 2025 22:56:58 -0700
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
Subject: [Patch v2 3/6] perf tools kvm: Fix the potential out of range memory access issue
Date: Mon, 11 Aug 2025 13:55:43 +0800
Message-Id: <20250811055546.296678-4-dapeng1.mi@linux.intel.com>
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

kvm_add_default_arch_event() helper may add 2 extra options but it
directly modifies the original argv[] array. This may cause out of range
memory access. Fix this issue.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/builtin-kvm.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 9813f1eb56f9..d297a7b2c088 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -2008,11 +2008,12 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
 	int rec_argc, i = 0, j, ret;
 	const char **rec_argv;
 
-	ret = kvm_add_default_arch_event(&argc, argv);
-	if (ret)
-		return -EINVAL;
-
-	rec_argc = argc + 2;
+	/*
+	 * Besides the 2 more options "-o" and "filename",
+	 * kvm_add_default_arch_event() may add 2 extra options,
+	 * so allocate 4 more items.
+	 */
+	rec_argc = argc + 2 + 2;
 	rec_argv = calloc(rec_argc + 1, sizeof(char *));
 	if (!rec_argv)
 		return -ENOMEM;
@@ -2025,6 +2026,10 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
 
 	BUG_ON(i != rec_argc);
 
+	ret = kvm_add_default_arch_event(&i, rec_argv);
+	if (ret)
+		goto EXIT;
+
 	ret = cmd_record(i, rec_argv);
 
 EXIT:
-- 
2.34.1

