Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1028D182D9;
	Tue, 25 Feb 2025 06:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740464274; cv=none; b=G8egv6isbBV1X3UbP2Sq74/zvx9AlaayOQjJDfl+yaJ2dcuVg/UsiywGHFGCQ11bV1o/e46DwObBuHrWruU4iVT3DTF4+Hmapx2ZNe+7egcZxavIKc6ErNxAHUwseLedFw5Sx/bfSBa+Q9ewMPC9MlNAHWlNQyQdiXEosC1Z5nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740464274; c=relaxed/simple;
	bh=BX++zZ7wpWeIo8YSpr+54NZRUpXQKNaqas7+DSsXj0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uUL2engGwr0nU3+MSoohQlcaG+2vw0jY/n/LgY0v1qCPWynR9E0cmcBHgu8z4KwmTpPQL1UonpNMYeysR4p3A/MZgNN5mM4xalQByc8uCEhw1DRlBAjbUusi446hY9KzNglNB/i3/CGNAVXHTeYjt2YVQ/TodcqQODe/eK6STG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rju6issL; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rju6issL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740464273; x=1772000273;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BX++zZ7wpWeIo8YSpr+54NZRUpXQKNaqas7+DSsXj0s=;
  b=Rju6issLdLVCISVXgwPhAymvMspLVmmvWr3J0xsBT3npLSlhtp1yJQNW
   LH1HHO+sSjU1O2pqZYnHAZAMXMXX4i7IVDbMgIrpkiCYRMJ1C2mRdtEXm
   2VhoMycCclJCBq62NKyZ3Q9X7NzRN3yVAy58V+UoiC+gNxzw/+V9SbuBm
   N9d6a3jLqPTcX7PHnsatZpwxt0lD5M9SqMe9Zl+0okTT5GOG/VyI3oCH0
   3dQ+/EjUf/pJ37Ob7l2lt0FgNFQ05ER/psULTIR0OSqBeiExH3+G8UxVC
   pQuOpbg2BdjoR9fpIEOB4ZfXxkdreg40ptw93kN5IIemF+5YXF5JYaKgG
   A==;
X-CSE-ConnectionGUID: nYG4T1vjTkq8C15m1pgQSg==
X-CSE-MsgGUID: aN7Cx/EKQAy9RZaoNI216Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="66624180"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="66624180"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 22:17:52 -0800
X-CSE-ConnectionGUID: +zrk8AMCRzelKXGCqa8j7A==
X-CSE-MsgGUID: jFoHQj07TDiTMiflPPSkIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="116920481"
Received: from yujie-x299.sh.intel.com ([10.239.159.77])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 22:17:48 -0800
From: Yujie Liu <yujie.liu@intel.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Martin Liska <martin.liska@hey.com>
Subject: [PATCH] perf script: Update brstack syntax documentation
Date: Tue, 25 Feb 2025 14:17:36 +0800
Message-Id: <20250225061736.1698175-1-yujie.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following commits appended new fields to the end of the branch info
list, such as branch type and branch speculation info.

commit 1f48989cdc7d ("perf script: Output branch sample type")
commit 6ade6c646035 ("perf script: Show branch speculation info")

Update brstack syntax documentation to be consistent with the latest
branch info list. Improve the descriptions to help users interpret the
fields accurately.

Signed-off-by: Yujie Liu <yujie.liu@intel.com>
---
 tools/perf/Documentation/perf-script.txt | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index b72866ef270b..8bd105084280 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -239,13 +239,15 @@ OPTIONS
 	i.e., -F "" is not allowed.
 
 	The brstack output includes branch related information with raw addresses using the
-	/v/v/v/v/cycles syntax in the following order:
-	FROM: branch source instruction
-	TO  : branch target instruction
-        M/P/-: M=branch target mispredicted or branch direction was mispredicted, P=target predicted or direction predicted, -=not supported
-	X/- : X=branch inside a transactional region, -=not in transaction region or not supported
-	A/- : A=TSX abort entry, -=not aborted region or not supported
-	cycles
+	FROM/TO/PRED/INTX/ABORT/CYCLES/TYPE/SPEC syntax in the following order:
+	FROM  : branch source instruction
+	TO    : branch target instruction
+	PRED  : M=branch target mispredicted or branch direction was mispredicted, P=target predicted or direction predicted, -=not supported
+	INTX  : X=branch inside a transactional region, -=not in transaction region or not supported
+	ABORT : A=TSX abort entry, -=not aborted region or not supported
+	CYCLES: the number of cycles that have elapsed since the last branch was recorded
+	TYPE  : branch type
+	SPEC  : branch speculation info
 
 	The brstacksym is identical to brstack, except that the FROM and TO addresses are printed in a symbolic form if possible.
 
-- 
2.34.1

