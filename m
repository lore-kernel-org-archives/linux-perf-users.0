Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F836FC1D;
	Fri, 13 Dec 2024 00:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734050174; cv=none; b=pVpiS3CY5CPIURlhzkEcnc7zj1Nn6X/p5kQr+TPrTsQgnVSl+jOyCzjrmdsVthgSfLYtYydXgd4Np/5tUq/ckpNwfoczOR6KVRQTGXP3F3lZVI1qs9b4varPCeQxACTgTahM665oVAnFl/gDJ0VHvqQ5Yh42TMSvN4beEGPEIZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734050174; c=relaxed/simple;
	bh=5jtoeXYE8iOo8H5z/2CeoRx90LDH7JMKxHtrvXtgkvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M5W4ypDyEttbtS9dO1X9L57WWF95iH/XTdJc0sj/JcJ8HD6C1lS1HI+08goytE5y7+1yr1BhKfYWD533bJhLjlP8E3x8TXgVjmXpKswx7JlvXfqhWYWChyonS8BKjoS9U8nNaQnKOY6fcsEtY1vIzEdSqIUJH/SR+R2axql5elY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9GxwWHA; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9GxwWHA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734050172; x=1765586172;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5jtoeXYE8iOo8H5z/2CeoRx90LDH7JMKxHtrvXtgkvY=;
  b=h9GxwWHApQreDa0p61A0eCVt6ynQR9cDkX/M+DxbvDfU6p6ZEZpNU+jO
   z6J2V+MlcCCaHuvaWlBGJoE+bXnm7oMWU0h1Ec0/zKnKN/bOpDrYQrZIR
   10eU00mlQZn5yRkOHib8k9AINS38RpQfm400MOcPh8DpOeOkEZ7lkWYPK
   Rml9CP4wxC8gHNscWhcFxUsHOnKnlgQrRGtJ71j3qqj4qah75+0H0QmaH
   WM/6kRwKUpJ7G1qHuPXiJbyKrzjN7Kyd1UuhK+jvMcCi13pmCwy4lqp42
   nHr+lykfZpfpManKS1lW4WK+FXuFI3rbFGti5eMzAEEUhatGFK+4rmYPP
   A==;
X-CSE-ConnectionGUID: nGLvrdcbRbewxgbwZHjtyw==
X-CSE-MsgGUID: +yqIDkueRKSIXG0ic8VldA==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34221235"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="34221235"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 16:36:11 -0800
X-CSE-ConnectionGUID: GXWxZcG8Rf+diOK5nhsmxQ==
X-CSE-MsgGUID: decDPaF7RYi+uA/SJanjfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="100550393"
Received: from tfalcon-desk.amr.corp.intel.com (HELO tfalcon-desk.intel.com) ([10.124.223.9])
  by fmviesa003.fm.intel.com with ESMTP; 12 Dec 2024 16:36:10 -0800
From: Thomas Falcon <thomas.falcon@intel.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Falcon <thomas.falcon@intel.com>
Subject: [PATCH] perf script: Fix output type for dynamically allocated core PMU's
Date: Thu, 12 Dec 2024 18:36:09 -0600
Message-ID: <20241213003609.564709-1-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf script output may show different fields on different core PMU's
that exist on heterogeneous platforms. For example,

perf record -e "{cpu_core/mem-loads-aux/,cpu_core/event=0xcd,\
umask=0x01,ldlat=3,name=MEM_UOPS_RETIRED.LOAD_LATENCY/}:upp"\
-c10000 -W -d -a -- sleep 1

perf script:

chromium-browse   46572 [002] 544966.882384:      10000 	cpu_core/MEM_UOPS_RETIRED.LOAD_LATENCY/: 7ffdf1391b0c     10268100142 \
 |OP LOAD|LVL L1 hit|SNP None|TLB L1 or L2 hit|LCK No|BLK    N/A    5   7    0   7fad7c47425d [unknown] (/usr/lib64/libglib-2.0.so.0.8000.3)

perf record -e cpu_atom/event=0xd0,umask=0x05,ldlat=3,\
name=MEM_UOPS_RETIRED.LOAD_LATENCY/upp -c10000 -W -d -a -- sleep 1

perf script:

gnome-control-c  534224 [023] 544951.816227:      10000 cpu_atom/MEM_UOPS_RETIRED.LOAD_LATENCY/:   7f0aaaa0aae0  [unknown] (/usr/lib64/libglib-2.0.so.0.8000.3)

Some fields, such as data_src, are not included by default.

The cause is that while one PMU may be assigned a type such as
PERF_TYPE_RAW, other core PMU's are dynamically allocated at boot time.
If this value does not match an existing PERF_TYPE_X value,
output_type(perf_event_attr.type) will return OUTPUT_TYPE_OTHER.

Instead search for a core PMU with a matching perf_event_attr type
and, if one is found, return PERF_TYPE_RAW to match output of other
core PMU's.

Suggested-by: Kan Liang <kan.liang@intel.com>
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/builtin-script.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 9e47905f75a6..e091fa1be052 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -386,6 +386,8 @@ static int evsel_script__fprintf(struct evsel_script *es, FILE *fp)
 
 static inline int output_type(unsigned int type)
 {
+	struct perf_pmu *pmu;
+
 	switch (type) {
 	case PERF_TYPE_SYNTH:
 		return OUTPUT_TYPE_SYNTH;
@@ -394,6 +396,10 @@ static inline int output_type(unsigned int type)
 			return type;
 	}
 
+	pmu = perf_pmus__find_by_type(type);
+	if (pmu && pmu->is_core)
+		return PERF_TYPE_RAW;
+
 	return OUTPUT_TYPE_OTHER;
 }
 
-- 
2.47.1

