Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD63E217723;
	Thu,  3 Sep 2026 05:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788414351; cv=none; b=ovugZLBIdKGduokTxJpauC5xGZOZ/8GQV+jOuYyBv2RFx89mSbTsW/24n0DeLwA9g8ci/Pjxt/RVFtnz7oDjfOa1iWQLtcKcGPAUsOf3KyhrMddL18qPCOiUQrerjTHpx7Xh/2JlZIOliJ90FHrfEteZmwb++ql6KXPWSLsz5+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788414351; c=relaxed/simple;
	bh=IsAtmiTYiAaY4Tm3KtUGTtOS8lPmxBuQq4lGUbeYjK0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gsiw6h8RRq0PzuYhbwgHLR98PwB72QXp/risHDjOTMY6PAGp8GGyfa+T9kwHBCoO4E807Z3YHEBJo+dIKqOqgKy+wWYfyz7K6K5xLOZXxP8clw9LH/viVnDjsCsCzJB8jZ0Wy7zXz8jdBPkV0/C+sDSEZV0CaAXpqlBtcXzov04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hb7qF1L0Bz1Mxjh;
	Thu,  3 Sep 2026 13:45:29 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hb7qB41JCz1Mxjk;
	Thu,  3 Sep 2026 13:45:26 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id 5254231D0309;
	Thu,  3 Sep 2026 13:41:31 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 3 Sep 2026 13:45:24 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>
CC: <zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>, <yingzhiwei@hygon.cn>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<james.clark@linaro.org>, <tglx@kernel.org>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuqi@hygon.cn>, <lijing@hygon.cn>, <wujianyong@hygon.cn>,
	<wangfengyu@hygon.cn>, Huang Shijie <huangsj@hygon.cn>, Ravi Bangoria
	<ravi.bangoria@amd.com>
Subject: [PATCH] perf/amd/ibs: Report physical address for IBS fetch samples
Date: Thu, 3 Sep 2026 13:44:22 +0800
Message-ID: <20260903054422.148739-1-huangsj@hygon.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex05.Hygon.cn (172.23.18.115) To cncheex04.Hygon.cn
 (172.23.18.114)

The IBS Fetch sampling does not report the physical address of the
fetched instruction even when PERF_SAMPLE_PHYS_ADDR is requested,
while IBS Op sampling does.

This patch reports physical address for IBS fetch samples which can be
used for profiling the running program.

Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 arch/x86/events/amd/ibs.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 3531f9c23b8c..e5376ad5b2ec 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1318,11 +1318,31 @@ static void perf_ibs_parse_ld_st_data(__u64 sample_type,
 	}
 }
 
+static void perf_ibs_parse_fetch_data(__u64 sample_type,
+				      struct perf_ibs_data *ibs_data,
+				      struct perf_sample_data *data)
+{
+	union ibs_fetch_ctl fetch_ctl;
+
+	if (!(sample_type & PERF_SAMPLE_PHYS_ADDR))
+		return;
+
+	fetch_ctl.val = ibs_data->regs[ibs_fetch_msr_idx(MSR_AMD64_IBSFETCHCTL)];
+	if (!fetch_ctl.phy_addr_valid)
+		return;
+
+	data->phys_addr = ibs_data->regs[ibs_fetch_msr_idx(MSR_AMD64_IBSFETCHPHYSAD)];
+	data->sample_flags |= PERF_SAMPLE_PHYS_ADDR;
+}
+
 static bool perf_ibs_is_mem_sample_type(struct perf_ibs *perf_ibs,
 					struct perf_event *event)
 {
 	u64 sample_type = event->attr.sample_type;
 
+	if (perf_ibs == &perf_ibs_fetch)
+		return sample_type & PERF_SAMPLE_PHYS_ADDR;
+
 	return perf_ibs == &perf_ibs_op &&
 	       sample_type & (PERF_SAMPLE_DATA_SRC |
 			      PERF_SAMPLE_WEIGHT_TYPE |
@@ -1555,6 +1575,8 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 
 	if (perf_ibs == &perf_ibs_op)
 		perf_ibs_parse_ld_st_data(event->attr.sample_type, &ibs_data, &data);
+	else
+		perf_ibs_parse_fetch_data(event->attr.sample_type, &ibs_data, &data);
 
 	/*
 	 * rip recorded by IbsOpRip will not be consistent with rsp and rbp
-- 
2.53.0


