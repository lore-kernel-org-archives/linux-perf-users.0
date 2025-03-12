Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD4522DF8D;
	Wed, 12 Mar 2025 07:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741766205; cv=none; b=Ap95RYemFUmS89iHlr3YfC+2F9TNUt6o5WhJcG/xoiBQK7NgfivnDSEEW+gEDP47PztFyH55DA4pozn0ztJQ8uZohzJ73cjniJwd1mk1NTZ1miJi17ohLBMGSK2+a2qJ6R73kfFIsewn3UsKoY7vtOjUO2Tk1AWeiLUcwjweNDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741766205; c=relaxed/simple;
	bh=9j32Q9ko3nzPeg45xM2NtQmpmXTW//lBQJ+uN6+5dN8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EM0jfowc6/Opr5tSgtk4sLCMN2h5trVnt6afW9wnbHyIaxMPkRD23SXITESfso1ZqsmraP5L7E6dlgsYctH+9mQhIys0RUvytd5TGrmROWC2+1f2fPHpmMNMgrg5IaEumKEo9d78VWEIvD+8ifSElUTkSBm8gmBVzz/qmoFWj7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W60plOnT; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W60plOnT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741766204; x=1773302204;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9j32Q9ko3nzPeg45xM2NtQmpmXTW//lBQJ+uN6+5dN8=;
  b=W60plOnTcAat8iw+KFa6KluOl9qsIXcFZgKi1Zj8LDngmunh/sSYpMXG
   FegwrQ6866OLaDxUpJwDnh6bYARWSmFnS6mDVtmPdFcJjGYfiRqd0PLfp
   nRFfPRorse0OjhrvRc3D+SoDzwgRviNqXerWXzZkbsdR/gFZ2xC7uKsmN
   6kF7R3Pn94cJccr34TMV/BeE+SU8K0diz1BGkwRCC0henkwkVN0pw5w1H
   aL8hu+NGNGxhQ1oODVN65ow+xTThNlQO4BjEUbF4/R5Ecxl5YZov6NukH
   A4ToMsmHAiTstlKd0PV95AcbIYRad/G5AdioFv/pa4RK738fz6dvUCImp
   w==;
X-CSE-ConnectionGUID: DV6sN3MuQICEO+0gpNkOcA==
X-CSE-MsgGUID: 07aMHwYbRXyunWr9yOhtJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42869911"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="42869911"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 00:56:43 -0700
X-CSE-ConnectionGUID: je2W3usmSyC6bdqstz/sZw==
X-CSE-MsgGUID: nhpioELPS3+NzVxrnVtM3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="125462623"
Received: from yujie-x299.sh.intel.com ([10.239.159.77])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 00:56:39 -0700
From: Yujie Liu <yujie.liu@intel.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Graham Woodward <graham.woodward@arm.com>,
	Paschalis.Mpeis@arm.com
Subject: [PATCH] perf script: Fix typo in branch event mask
Date: Wed, 12 Mar 2025 15:56:36 +0800
Message-Id: <20250312075636.429127-1-yujie.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BRACH -> BRANCH

Fixes: 88b1473135e4 ("perf script: Separate events from branch types")
Signed-off-by: Yujie Liu <yujie.liu@intel.com>
---
 tools/perf/util/event.h                 | 2 +-
 tools/perf/util/trace-event-scripting.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index c7f4b4b841ca..664bf39567ce 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -91,7 +91,7 @@ enum {
 	PERF_IP_FLAG_VMENTRY		|\
 	PERF_IP_FLAG_VMEXIT)
 
-#define PERF_IP_FLAG_BRACH_EVENT_MASK	\
+#define PERF_IP_FLAG_BRANCH_EVENT_MASK	\
 	(PERF_IP_FLAG_BRANCH_MISS |	\
 	 PERF_IP_FLAG_NOT_TAKEN)
 
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index 29cc467be14a..72abb28b7b5a 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -347,7 +347,7 @@ static int sample_flags_to_name(u32 flags, char *str, size_t size)
 
 	flags &= ~(PERF_IP_FLAG_TRACE_BEGIN | PERF_IP_FLAG_TRACE_END);
 
-	types = flags & ~PERF_IP_FLAG_BRACH_EVENT_MASK;
+	types = flags & ~PERF_IP_FLAG_BRANCH_EVENT_MASK;
 	for (i = 0; sample_flags[i].name; i++) {
 		if (sample_flags[i].flags != types)
 			continue;
@@ -359,7 +359,7 @@ static int sample_flags_to_name(u32 flags, char *str, size_t size)
 		break;
 	}
 
-	events = flags & PERF_IP_FLAG_BRACH_EVENT_MASK;
+	events = flags & PERF_IP_FLAG_BRANCH_EVENT_MASK;
 	for (i = 0; branch_events[i].name; i++) {
 		if (!(branch_events[i].flags & events))
 			continue;

base-commit: b10f74308e1305275e69ddde711ec817cc69e306
-- 
2.34.1

