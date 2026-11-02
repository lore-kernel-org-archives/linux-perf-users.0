Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621654;
	b=hOab6/MGXa2f8zESFsKCtHv93TkFirSRZG3t1CwGmM9VQLOjxZujig2rP9c4WXQgVxIm
	 fDwvJfdGjVK6KpPE0olXLrG7zgGFMU2vBD2R6jw3L91Ky25GvDbx4cqdW5XKQl4BWsn27
	 993iYIULrOEtctUk/b0TMkjVRw/6BnqCengp110yNx6Yq1UY5B5ujb9QgIBFV3WZ6Etpi
	 CUMyrKlBff76we5Aw7RmvstA6acMaOAq/0dXwKHtLrANjZpJOvSCzvz2Aed7p7mVh0wb3
	 pFyEbIdkN4zyLv/F/mqLV9Nfr8uTu9zSemDwoQkF4HXppkvxBPlCGwoajQ8jznnV86A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621654;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=ZHnD2BhfQS4goxoEINStSTyGKKje9Pvfaj0elViDg4Q=;
	b=28aFNAvE4PvjgrKyDiNlQFOi9InZIVNu1mhsYzQ48vkqFmjwaHdjdXvT0taCdiY99j6d
	 ga8VHAheZ0KHzrLSyN7AYwEJc5RpO5WM6jRsWelBxv7n1z79TilXc6xIWly21zl+k7iu+
	 UuxdDMt0mnDILdgv3pid6OCRr/HDVYljTJXfQ4SK9Zk1GiBo67RoLrpozIYCOxDFK+rsn
	 4SF14USTkYJwj58RvsUkBk8hXY6pJxFcVgkQAymo7MxYum0lGdV9g5MqAXTyY4xyFJA4y
	 tjNANHQIXOXFDhPnzFRBtw2a5OLLp+Tb+d5HlUVae6f4TtOYSefvvTCv2p0M99NOmAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DA9606A327;
	Mon,  2 Nov 2026 12:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98DA9606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jJ9bd4xYVz16TS1;
	Mon,  2 Nov 2026 20:13:49 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jJ9bZ5ssyz2fTg;
	Mon,  2 Nov 2026 20:13:46 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id CC38AB357;
	Mon,  2 Nov 2026 20:13:42 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 2 Nov 2026 20:13:44 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <ravi.bangoria@amd.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <james.clark@linaro.org>,
	<tglx@kernel.org>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>, <yingzhiwei@hygon.cn>,
	<shijie8@gmail.com>, Huang Shijie <huangsj@hygon.cn>
Subject: [PATCH v2] perf/amd/ibs: add phy_addr_only software filter for ibs_op
Date: Mon, 2 Nov 2026 20:13:24 +0800
Message-ID: <20261102121324.371157-1-huangsj@hygon.cn>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex05.Hygon.cn (172.23.18.115) To cncheex04.Hygon.cn
 (172.23.18.114)

We use the following command to track a process's memory footprint:
  #perf record -e ibs_fetch// -e ibs_op// -p xxx --phys-data -- sleep 10

In the mysql tests, I caught over 1,804,973 records for ibs_op event.
I found that over 53% records(970,554) are like this:
        ibs_op//:  ffffffffb6017739               0

The physical address is 0 for these records. These records are not needed
by us, and they wasted the CPU cycles.

This patch adds an ibs_op/phy_addr_only term that discards samples
without a valid physical address (dc_phy_addr_valid == 0) in the interrupt
handler. And it avoids the phys_addr=0 noise when used with --phys-data.
The term is only meaningful together with PERF_SAMPLE_PHYS_ADDR.

Test result:
   On 384-CPU Hygon machine running MySQL 8 + sysbench oltp_read_only with
400 threads. Use perf-record in a 3s window after 15s of warmup.

Compared with BPF filter:
  "perf record --phys-data --filter 'phys_addr != 0'"

    "-c = 50000":
                   samples
    filter        captured
    ----------------------
    phy_addr_only 25158085
    bpf           24628937

    "-c = 40000":
                   samples
    filter        captured
    ----------------------
    phy_addr_only 28215473
    bpf             FAILED

At -c 40000 the BPF rounds stop working.
The phy_addr_only rounds keep capturing at that density,
and every one of them still reports zero phys_addr==0 samples.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
v1 -->v2:
   1.) filter the zero-address
   2.) returen invalid if PERF_SAMPLE_PHYS_ADDR is not set.

  v1:  
   https://lore.kernel.org/all/20260902085251.4046240-1-huangsj@hygon.cn/#t
---
 arch/x86/events/amd/ibs.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index e5376ad5b2ec..f9949853e991 100644
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
+					 struct perf_event *event)
+{
+	return perf_ibs == &perf_ibs_op &&
+	       (event->attr.config2 & IBS_PHY_ADDR_ONLY_MASK);
+}
+
 static int perf_ibs_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
@@ -439,6 +447,10 @@ static int perf_ibs_init(struct perf_event *event)
 		hwc->extra_reg.config |= strmst << IBS_OP_2_STRM_ST_FILTER_SHIFT;
 	}
 
+	if (perf_ibs_phy_addr_only_event(perf_ibs, event) &&
+	    !(event->attr.sample_type & PERF_SAMPLE_PHYS_ADDR))
+		return -EINVAL;
+
 	/*
 	 * If we modify hwc->sample_period, we also need to update
 	 * hwc->last_period and hwc->period_left.
@@ -721,6 +733,7 @@ static struct attribute_group empty_caps_group = {
 PMU_FORMAT_ATTR(rand_en,	"config:57");
 PMU_FORMAT_ATTR(cnt_ctl,	"config:19");
 PMU_FORMAT_ATTR(swfilt,		"config2:0");
+PMU_FORMAT_ATTR(phy_addr_only,	"config2:1");
 PMU_EVENT_ATTR_STRING(l3missonly, fetch_l3missonly, "config:59");
 PMU_EVENT_ATTR_STRING(l3missonly, op_l3missonly, "config:16");
 PMU_EVENT_ATTR_STRING(ldlat, ibs_op_ldlat_format, "config1:0-11");
@@ -890,6 +903,7 @@ cnt_ctl_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 
 static struct attribute *op_attrs[] = {
 	&format_attr_swfilt.attr,
+	&format_attr_phy_addr_only.attr,
 	NULL,
 };
 
@@ -1357,7 +1371,8 @@ static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs,
 	if (event->attr.sample_type & PERF_SAMPLE_RAW ||
 	    perf_ibs_is_mem_sample_type(perf_ibs, event) ||
 	    perf_ibs_ldlat_event(perf_ibs, event) ||
-	    perf_ibs_fetch_lat_event(perf_ibs, event))
+	    perf_ibs_fetch_lat_event(perf_ibs, event) ||
+	    perf_ibs_phy_addr_only_event(perf_ibs, event))
 		return perf_ibs->offset_max;
 	else if (check_rip)
 		return 3;
@@ -1499,6 +1514,23 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		}
 	}
 
+	if (perf_ibs_phy_addr_only_event(perf_ibs, event)) {
+		union ibs_op_data3 op_data3;
+		u64 phys_addr;
+
+		op_data3.val = ibs_data.regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)];
+		if (!op_data3.dc_phy_addr_valid) {
+			throttle = perf_event_account_interrupt(event);
+			goto out;
+		}
+		/* Also skip the case: zero address in MSR_AMD64_IBSDCPHYSAD */
+		phys_addr = ibs_data.regs[ibs_op_msr_idx(MSR_AMD64_IBSDCPHYSAD)];
+		if (!phys_addr) {
+			throttle = perf_event_account_interrupt(event);
+			goto out;
+		}
+	}
+
 	if (perf_ibs_fetch_lat_event(perf_ibs, event)) {
 		union ibs_fetch_ctl fetch_ctl;
 
-- 
2.53.0


