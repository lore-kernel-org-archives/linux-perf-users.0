Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EE02F44;
	Wed, 12 Mar 2025 07:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741764224; cv=none; b=QrGl1YC6C0WHiBs670Jeigig5kiXs5FBLBVytjDU1X359148WamHO7GVCNCEFVb2gmwumlHUxGRAryxKGN+Xn2NWAYglUF3MLTygLSaHk8gLau2dcZdYCbir7h/bRk136I5WwcDPHOQkwI9nd5ngqJSA1Zw0RcIJ3rZq2hvJdHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741764224; c=relaxed/simple;
	bh=V6UDUiMHT+CbaIDyrgCI71BKmZNpKmVv67K0d3756nU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E51mMh0yarFPULW/8L0uh/JXEXT2+TciSFmdABN2fdDw+sKWwxyTr2Q3D3fQVx8FiQU8Il7H5m+umg1n0zoNOz3qz8331gC+OgWucp45QD34XTX3LR6DgXAmnEdYTNFegUSONV4RXTdXQdoYzzeXyc2fXlk9qedAL1wnnZ5OJa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nRQg1ZPl; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nRQg1ZPl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741764222; x=1773300222;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V6UDUiMHT+CbaIDyrgCI71BKmZNpKmVv67K0d3756nU=;
  b=nRQg1ZPlljYLc8M9ButlQCncPFyPiXJMPDGgOFvP18dLtHB9um8Z716d
   Iudgwr6Sl5sMu7GbXY9WPUkVdSXTX4b3DgpqyLJrV4AcYWvM4M0oBL/EM
   0N+AvDwxvts1jcHpVRB2/xu2Gm2NXhxlOPe2KNHi7PRjiCnnNdF611ieM
   VUAMXCb0Ldhq1nmD9uNjpVNPyZc+hew1PgLl7wXUoT47UtPlICzHALlNs
   Mi8pPxNJRXmNOTSvByIp0MHZRFJzeOwspOiq/P61l8vNFjbQDdwwQt5HP
   jSon1xjs3KhLo/+ANCadFlEFTBRSzJ0bzXPhl/iB1Y0gdcfqALY+wQlqD
   A==;
X-CSE-ConnectionGUID: JU4oKm3bS3GzwuaNrIi9zg==
X-CSE-MsgGUID: eij6kRTaTdCSl9WcFMXdKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42086111"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="42086111"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 00:23:41 -0700
X-CSE-ConnectionGUID: dz3+V7+QTC+VuZLSXOwXZA==
X-CSE-MsgGUID: WLwyEhlaRqC/lZhuCPw1NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="124722313"
Received: from yujie-x299.sh.intel.com ([10.239.159.77])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 00:23:38 -0700
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
	Martin Liska <martin.liska@hey.com>,
	James Clark <james.clark@linaro.org>,
	Leo Yan <leo.yan@arm.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH v2] perf script: Update brstack syntax documentation
Date: Wed, 12 Mar 2025 15:23:29 +0800
Message-Id: <20250312072329.419020-1-yujie.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following commits added new fields/flags to the branch stack field
list:

commit 1f48989cdc7d ("perf script: Output branch sample type")
commit 6ade6c646035 ("perf script: Show branch speculation info")
commit 1e66dcff7b9b ("perf script: Add not taken event for branch stack")

Update brstack syntax documentation to be consistent with the latest
branch stack field list. Improve the descriptions to help users
interpret the fields accurately.

Signed-off-by: Yujie Liu <yujie.liu@intel.com>
---
Changes in v2:
- Add not taken event (Namhyung, Leo)
- Change field name from PRED to EVENT for generic use and furture
  extension (Leo)

v1: https://lore.kernel.org/all/20250225061736.1698175-1-yujie.liu@intel.com/
---
 tools/perf/Documentation/perf-script.txt | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index b72866ef270b..28bec7e78bc8 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -239,13 +239,22 @@ OPTIONS
 	i.e., -F "" is not allowed.
 
 	The brstack output includes branch related information with raw addresses using the
-	/v/v/v/v/cycles syntax in the following order:
-	FROM: branch source instruction
-	TO  : branch target instruction
-        M/P/-: M=branch target mispredicted or branch direction was mispredicted, P=target predicted or direction predicted, -=not supported
-	X/- : X=branch inside a transactional region, -=not in transaction region or not supported
-	A/- : A=TSX abort entry, -=not aborted region or not supported
-	cycles
+	FROM/TO/EVENT/INTX/ABORT/CYCLES/TYPE/SPEC syntax in the following order:
+	FROM  : branch source instruction
+	TO    : branch target instruction
+	EVENT : M=branch target or direction was mispredicted
+	        P=branch target or direction was predicted
+	        N=branch not-taken
+	        -=no event or not supported
+	INTX  : X=branch inside a transactional region
+	        -=branch not in transaction region or not supported
+	ABORT : A=TSX abort entry
+	        -=not aborted region or not supported
+	CYCLES: the number of cycles that have elapsed since the last branch was recorded
+	TYPE  : branch type: COND/UNCOND/IND/CALL/IND_CALL/RET etc.
+	        -=not supported
+	SPEC  : branch speculation info: SPEC_WRONG_PATH/NON_SPEC_CORRECT_PATH/SPEC_CORRECT_PATH
+	        -=not supported
 
 	The brstacksym is identical to brstack, except that the FROM and TO addresses are printed in a symbolic form if possible.
 

base-commit: b10f74308e1305275e69ddde711ec817cc69e306
-- 
2.34.1

