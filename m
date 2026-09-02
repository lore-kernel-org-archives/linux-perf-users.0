Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D185240800D;
	Wed,  2 Sep 2026 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788339732; cv=none; b=AxMiMHf4nzCXQXPf+guif/F5rvtfhsfQpqUGyax3Trr4yD0uP8ddhY28rv+4+6vBzOVzLVlU1vBtTQu6iuKCzq2NNIVYLvrhopp9i+0TcA9wnkdKk7m1g7S3UnYAY0KivVWUF+p/hlh/t+jigg+EV/5xbnvYn8SwfO0tc19vDlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788339732; c=relaxed/simple;
	bh=F7BZ1gjC4mh1rjgXGXgMRFeDDSFg9LYA6sw6/4Zrrko=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ewv+0DMoraBJjCW3Dh1tZ36AIPWlIdy0u95bNr3w1REZZcW/1hI8SDKH5cdOnxOWHbqVEUb+3fPMnl1+OKnYcYhX8l+x8AZz6Jca5w0stTuwXj2oB3s1FQ6RBxa/qbJ0V/joluDxIontN0aFxgghlq31gpsO6AkfM0AYBNMf/hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hZcDF06ymz207nS;
	Wed,  2 Sep 2026 17:01:49 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hZcDD3HTWz207nS;
	Wed,  2 Sep 2026 17:01:48 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id B56C17889;
	Wed,  2 Sep 2026 17:01:42 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 2 Sep 2026 17:01:46 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>
CC: <zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>, <yingzhiwei@hygon.cn>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<james.clark@linaro.org>, <tglx@kernel.org>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuqi@hygon.cn>, <lijing@hygon.cn>, <wangfengyu@hygon.cn>,
	<wujiangyong@hygon.cn>, <shijie8@gmail.com>, Huang Shijie <huangsj@hygon.cn>
Subject: [PATCH] perf/amd/ibs: add phy_addr_only software filter for ibs_op
Date: Wed, 2 Sep 2026 16:52:51 +0800
Message-ID: <20260902085251.4046240-1-huangsj@hygon.cn>
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

We use the following command to track a process's memory footprint:
  #perf record -e ibs_fetch// -e ibs_op// -p xxx --phys-addr -- sleep 10

In the mysql tests, I catched over 1,804,973 records for ibs_op event.
I found that over 53% records(970,554) are like this:
        ibs_op//:  ffffffffb6017739               0

The physical address is 0 for these records. These records are not needed
by us, and they wasted the CPU cycles.

This patch adds an ibs_op/phy_addr_only term that discards samples
without a valid physical address (dc_phy_addr_valid == 0) in the interrupt
handler. And it avoids the phys_addr=0 noise when used with --phys-data.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 arch/x86/events/amd/ibs.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index e5376ad5b2ec..f258375c09bc 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -32,6 +32,7 @@ static u32 ibs_caps;
 
 /* attr.config2 */
 #define IBS_SW_FILTER_MASK	1
+#define IBS_PHY_ADDR_ONLY_MASK	2
 
 /* attr.config1 */
 #define IBS_OP_CONFIG1_LDLAT_MASK		(0xFFFULL <<  0)
@@ -303,6 +304,13 @@ static bool perf_ibs_strmst_event(struct perf_ibs *perf_ibs,
 	       (event->attr.config1 & IBS_OP_CONFIG1_STRMST_MASK);
 }
 
+static bool perf_ibs_phy_addr_only_event(struct perf_ibs *perf_ibs,
+				      struct perf_event *event)
+{
+	return perf_ibs == &perf_ibs_op &&
+	       (event->attr.config2 & IBS_PHY_ADDR_ONLY_MASK);
+}
+
 static int perf_ibs_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
@@ -721,6 +729,7 @@ static struct attribute_group empty_caps_group = {
 PMU_FORMAT_ATTR(rand_en,	"config:57");
 PMU_FORMAT_ATTR(cnt_ctl,	"config:19");
 PMU_FORMAT_ATTR(swfilt,		"config2:0");
+PMU_FORMAT_ATTR(phy_addr_only,	"config2:1");
 PMU_EVENT_ATTR_STRING(l3missonly, fetch_l3missonly, "config:59");
 PMU_EVENT_ATTR_STRING(l3missonly, op_l3missonly, "config:16");
 PMU_EVENT_ATTR_STRING(ldlat, ibs_op_ldlat_format, "config1:0-11");
@@ -890,6 +899,7 @@ cnt_ctl_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 
 static struct attribute *op_attrs[] = {
 	&format_attr_swfilt.attr,
+	&format_attr_phy_addr_only.attr,
 	NULL,
 };
 
@@ -1357,7 +1367,8 @@ static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs,
 	if (event->attr.sample_type & PERF_SAMPLE_RAW ||
 	    perf_ibs_is_mem_sample_type(perf_ibs, event) ||
 	    perf_ibs_ldlat_event(perf_ibs, event) ||
-	    perf_ibs_fetch_lat_event(perf_ibs, event))
+	    perf_ibs_fetch_lat_event(perf_ibs, event) ||
+	    perf_ibs_phy_addr_only_event(perf_ibs, event))
 		return perf_ibs->offset_max;
 	else if (check_rip)
 		return 3;
@@ -1499,6 +1510,16 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		}
 	}
 
+	if (perf_ibs_phy_addr_only_event(perf_ibs, event)) {
+		union ibs_op_data3 op_data3;
+
+		op_data3.val = ibs_data.regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)];
+		if (!op_data3.dc_phy_addr_valid) {
+			throttle = perf_event_account_interrupt(event);
+			goto out;
+		}
+	}
+
 	if (perf_ibs_fetch_lat_event(perf_ibs, event)) {
 		union ibs_fetch_ctl fetch_ctl;
 
-- 
2.53.0


