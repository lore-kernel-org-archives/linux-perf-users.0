Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8789C16D32C
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Jul 2024 06:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721890003; cv=none; b=Ejbfl1M8og29SoCGwGPi9BbvAKXcfWFPX+hB9TyfWtRqTcPCRz//2N8sd+SNckhyM03efUJUTFLHxm09lV6EFSbD8I90n6BcRmTnwHRdfNzu93y5+XGe43s+zcpLsRRAuvkykcMwYQH0aHZWHQc5UIJu00qMas5+HnRWrOHDThw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721890003; c=relaxed/simple;
	bh=s1ZPpF94AaAjWj+rf3eoCSG1AXHRnkKPuC7UO9svrDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g6Zd3kDggJ4UQQvuePrkxxE16eeMAJZkdU1/eh0ikvG19fOq8aB/KoPnaNu+82WEqHEcl+mMWCaCAdJhI6cibhWnJErLPWqlVnPCLkwu5TL+LnlxQAnwaBm1wiZPR/0nC4GAk+AbDzFbz/O21dI8n+ngRSeZUQDwzKLL54S033A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 793B51007;
	Wed, 24 Jul 2024 23:47:06 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 61F3D3F73F;
	Wed, 24 Jul 2024 23:46:39 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 2/4] perf auxtrace: Remove unused 'pmu' pointer from struct auxtrace_record
Date: Thu, 25 Jul 2024 07:46:18 +0100
Message-Id: <20240725064620.1651819-3-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240725064620.1651819-1-leo.yan@arm.com>
References: <20240725064620.1651819-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'pmu' pointer in the auxtrace_record structure is not used after
support multiple AUX events, remove it.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/arch/arm/util/cs-etm.c     | 1 -
 tools/perf/arch/arm64/util/arm-spe.c  | 1 -
 tools/perf/arch/arm64/util/hisi-ptt.c | 1 -
 tools/perf/arch/x86/util/intel-bts.c  | 1 -
 tools/perf/arch/x86/util/intel-pt.c   | 1 -
 tools/perf/util/auxtrace.h            | 1 -
 6 files changed, 6 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index da6231367993..96aeb7cdbee1 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -888,7 +888,6 @@ struct auxtrace_record *cs_etm_record_init(int *err)
 	}
 
 	ptr->cs_etm_pmu			= cs_etm_pmu;
-	ptr->itr.pmu			= cs_etm_pmu;
 	ptr->itr.parse_snapshot_options	= cs_etm_parse_snapshot_options;
 	ptr->itr.recording_options	= cs_etm_recording_options;
 	ptr->itr.info_priv_size		= cs_etm_info_priv_size;
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 0b52e67edb3b..622fd47573ec 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -497,7 +497,6 @@ struct auxtrace_record *arm_spe_recording_init(int *err,
 	}
 
 	sper->arm_spe_pmu = arm_spe_pmu;
-	sper->itr.pmu = arm_spe_pmu;
 	sper->itr.snapshot_start = arm_spe_snapshot_start;
 	sper->itr.snapshot_finish = arm_spe_snapshot_finish;
 	sper->itr.find_snapshot = arm_spe_find_snapshot;
diff --git a/tools/perf/arch/arm64/util/hisi-ptt.c b/tools/perf/arch/arm64/util/hisi-ptt.c
index ba97c8a562a0..eac9739c87e6 100644
--- a/tools/perf/arch/arm64/util/hisi-ptt.c
+++ b/tools/perf/arch/arm64/util/hisi-ptt.c
@@ -174,7 +174,6 @@ struct auxtrace_record *hisi_ptt_recording_init(int *err,
 	}
 
 	pttr->hisi_ptt_pmu = hisi_ptt_pmu;
-	pttr->itr.pmu = hisi_ptt_pmu;
 	pttr->itr.recording_options = hisi_ptt_recording_options;
 	pttr->itr.info_priv_size = hisi_ptt_info_priv_size;
 	pttr->itr.info_fill = hisi_ptt_info_fill;
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index 34696f3d3d5d..85c8186300c8 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -434,7 +434,6 @@ struct auxtrace_record *intel_bts_recording_init(int *err)
 	}
 
 	btsr->intel_bts_pmu = intel_bts_pmu;
-	btsr->itr.pmu = intel_bts_pmu;
 	btsr->itr.recording_options = intel_bts_recording_options;
 	btsr->itr.info_priv_size = intel_bts_info_priv_size;
 	btsr->itr.info_fill = intel_bts_info_fill;
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 4b710e875953..ea510a7486b1 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -1197,7 +1197,6 @@ struct auxtrace_record *intel_pt_recording_init(int *err)
 	}
 
 	ptr->intel_pt_pmu = intel_pt_pmu;
-	ptr->itr.pmu = intel_pt_pmu;
 	ptr->itr.recording_options = intel_pt_recording_options;
 	ptr->itr.info_priv_size = intel_pt_info_priv_size;
 	ptr->itr.info_fill = intel_pt_info_fill;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index f99e53426528..a54f7b99ba5a 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -411,7 +411,6 @@ struct auxtrace_record {
 	int (*read_finish)(struct auxtrace_record *itr, int idx);
 	unsigned int alignment;
 	unsigned int default_aux_sample_size;
-	struct perf_pmu *pmu;
 	struct evlist *evlist;
 };
 
-- 
2.34.1

