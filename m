Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACBB2609FD;
	Fri, 19 Sep 2025 02:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248327; cv=none; b=gxjfnXpSXpKEpMrumnK9rjmiiNY2/LWgCX/Vby/qUwSkEcO8upGOwg0A1PAA1PNs8yd/AlXVS5PBVeAj4AkEe1La2hgzGre9qpwk3SKbnXfOh+62jdVGLVZER/lZI4NtuuLDFTyEOXe2KZFUgV6oRb3gJxLPxBK/PBzPdJiD4X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248327; c=relaxed/simple;
	bh=7sV5XXyfT80UuU5FmYPw9Nla94sjvOftHHNsNDMlRp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VmOaBmW4liLuCWv2bZ1sZbB6U/xB507+W9oSbx1BaAz0FehRw0x2gis/w1LWbrOih4iaCvCb3QzENHqWST1SGx9NpPbwU/RGxa1PRyzE4qbPeTVTYefJRPbz/fnLENdrGas0RzPVEcH2FX2V0QAqq1XLiYtI9ZkZMBjDZclbqMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aGcrvTxr; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aGcrvTxr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758248326; x=1789784326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7sV5XXyfT80UuU5FmYPw9Nla94sjvOftHHNsNDMlRp4=;
  b=aGcrvTxrZt7ZmX5S3+F7ZWc5SNKkpCE7m4Z/NixACWHTDapR9ItW4al9
   WT9VKmZ5NrmugAeMMyKjATIkLRTuhVgPpUS3XBtrqxfDhYd0KlrtRYaZB
   DjAR9cwZSxyo9yHib8Ia/jw4+THao2l/5d3vIfapSVayxN+pcu0XXD8sH
   ufs2hx94QtOfQmRPrvszQIURYXVZT/WGHouIwWwrOjR4P/1+6VFRMUWMt
   bqkeb5vejAwH23sc7zCQjKr7lCTDf3DQMT872+ngP1L5xR13PenAz8KBm
   wWtj/6iR0wSm5ACiEdXreeQ7WYjSE6+SCb25TVLUfGo0ky+MMo93/j0Pq
   g==;
X-CSE-ConnectionGUID: kVDZyx5AR/q1LTtBYZuppQ==
X-CSE-MsgGUID: mnB1qvmTQ3689V9OSh5JVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="64229135"
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="64229135"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 19:18:46 -0700
X-CSE-ConnectionGUID: rpwfj2WJT2KRq4hiS2k6xA==
X-CSE-MsgGUID: goVEWOQaQVSZArptzNHeUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="175535610"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa007.jf.intel.com with ESMTP; 18 Sep 2025 19:18:43 -0700
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v3 3/6] perf tools kvm: Fix the potential out of range memory access issue
Date: Fri, 19 Sep 2025 10:16:56 +0800
Message-Id: <20250919021659.1263351-4-dapeng1.mi@linux.intel.com>
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

kvm_add_default_arch_event() helper may add 2 extra options but it
directly modifies the original argv[] array. This may cause out of range
memory access. Fix this issue.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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

