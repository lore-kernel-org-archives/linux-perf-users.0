Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717CC74C14;
	Thu, 11 Jun 2026 01:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781139878; cv=none; b=gwlARMbRTRmVKjBA3IIzSGSM3Nc0th9mUPuTbiyD9pN+hp7uvKcsjue+j6+/nFsUOP8cH6jPGMjoctSMplr9NFMlehz1qGR7u+CEWPvjy78sb6H+TTE6faNRkmboNlL8i1UnKGn3nTs21Ke0KuF5/G8BmQ2sioH53m4sLYfaVk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781139878; c=relaxed/simple;
	bh=5GA6673Zo3Q2c+Ea+thVn0sk93GNTvwzDiW+aDTu66E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bS28BOxAU4rJK6+5veIgmpP1YC72Q3OVGaKgWTKFHe2B16aKFvsYAuKW7WayNBrEVQJDNtSN2EIC94b07sKmKT9I2E7xZPMnBHkq3tyGUh/CuOGC/v9z97fnqibIEBdvZV0F1Zrmx8q+SWqDBj9rUHYYoP6HzSRwoP4J2jJW8Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=QKDbbfXh; arc=none smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="QKDbbfXh"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 427BB162D15;
	Thu, 11 Jun 2026 01:04:31 +0000 (UTC)
Received: from pdx1-sub0-mail-a203.dreamhost.com (trex-green-8.trex.outbound.svc.cluster.local [100.116.180.233])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 0BCDB162D19;
	Thu, 11 Jun 2026 01:04:30 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Hysterical-Unite: 5cbbaa79106da90c_1781139871143_3545901326
X-MC-Loop-Signature: 1781139871143:3452257260
X-MC-Ingress-Time: 1781139871143
Received: from pdx1-sub0-mail-a203.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.116.180.233 (trex/7.1.5);
	Thu, 11 Jun 2026 01:04:31 +0000
Received: from localhost.localdomain (186-79-212-212.fo.baf.movistar.cl [186.79.212.212])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a203.dreamhost.com (Postfix) with ESMTPSA id 4gbPYl1pKDz3S;
	Wed, 10 Jun 2026 18:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1781139869;
	bh=HIe+w7vP0+fFTE4+Sgn97+Odidhqr/jF+cy66l1f9Tg=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=QKDbbfXhveS0nPOvh3hKgXlt2/l3vupBbei+DBAZkgnQV6t5rqNlPq2l+XVqDHQiO
	 ZQqkcuOL9OVpD8Y5rhSsvjIdQl1NJGQsFkVISs4wzwKcyePfy1H656VNEMPjWsvS6U
	 1Q4L1yWum2injteHhipFwko7Zmr/DlQuiwfmsVn8OEGnSN0ZwbUTI4CWjGmjK/CuEI
	 ISt8ZYS77ZURT/j83HV9XyII74uLHs64R8AVPUZ+8Fm1yfWQHQHGnSYumjUjTswiFU
	 ezFW+BFsicylrGEo3wMcOgZfPGGKt7FKY04IhLwEbULBWW217Dj+O6Q9fyp9EJuPVe
	 R/wRnXXufbE1w==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com
Cc: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Harshal Thakkar <harshal.t@samsung.com>,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH] perf/cxlpmu: Support Channel/Rank/Bank filter
Date: Wed, 10 Jun 2026 18:04:09 -0700
Message-Id: <20260611010409.2776635-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Harshal Thakkar <harshal.t@samsung.com>

Implement CRB filtering per CXL 4.0 8.2.7.2.2, and extend the
current filtering support beyond HDM. These filters are only for
DDR Interface events.

Placing the 32-bit CRB value at config2:32-63 leaves the
exisitng HDM value at config2:0-15 untouched and avoids needing
a new config3.

Signed-off-by: Harshal Thakkar <harshal.t@samsung.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/perf/cxl_pmu.c | 45 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 68a54d97d2a8..b709b2e6c0d9 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -106,6 +106,7 @@ struct cxl_pmu_info {
 	int on_cpu;
 	struct hlist_node node;
 	bool filter_hdm;
+	bool filter_chan_rank_bank;
 	int irq;
 };
 
@@ -142,6 +143,8 @@ static int cxl_pmu_parse_caps(struct device *dev, struct cxl_pmu_info *info)
 	info->num_event_capabilities = FIELD_GET(CXL_PMU_CAP_NUM_EVN_CAP_REG_SUP_MSK, val) + 1;
 
 	info->filter_hdm = FIELD_GET(CXL_PMU_CAP_FILTERS_SUP_MSK, val) & CXL_PMU_FILTER_HDM;
+	info->filter_chan_rank_bank = FIELD_GET(CXL_PMU_CAP_FILTERS_SUP_MSK, val) &
+		CXL_PMU_FILTER_CHAN_RANK_BANK;
 	if (FIELD_GET(CXL_PMU_CAP_INT, val))
 		info->irq = FIELD_GET(CXL_PMU_CAP_MSI_N_MSK, val);
 	else
@@ -225,6 +228,8 @@ enum {
 	cxl_pmu_edge_attr,
 	cxl_pmu_hdm_filter_en_attr,
 	cxl_pmu_hdm_attr,
+	cxl_pmu_crb_filter_en_attr,
+	cxl_pmu_crb_attr,
 };
 
 static struct attribute *cxl_pmu_format_attr[] = {
@@ -236,6 +241,8 @@ static struct attribute *cxl_pmu_format_attr[] = {
 	[cxl_pmu_edge_attr] = CXL_PMU_FORMAT_ATTR(edge, "config1:17"),
 	[cxl_pmu_hdm_filter_en_attr] = CXL_PMU_FORMAT_ATTR(hdm_filter_en, "config1:18"),
 	[cxl_pmu_hdm_attr] = CXL_PMU_FORMAT_ATTR(hdm, "config2:0-15"),
+	[cxl_pmu_crb_filter_en_attr] = CXL_PMU_FORMAT_ATTR(crb_filter_en, "config1:19"),
+	[cxl_pmu_crb_attr] = CXL_PMU_FORMAT_ATTR(crb, "config2:32-63"),
 	NULL
 };
 
@@ -246,7 +253,9 @@ static struct attribute *cxl_pmu_format_attr[] = {
 #define CXL_PMU_ATTR_CONFIG1_INVERT_MSK		BIT(16)
 #define CXL_PMU_ATTR_CONFIG1_EDGE_MSK		BIT(17)
 #define CXL_PMU_ATTR_CONFIG1_FILTER_EN_MSK	BIT(18)
+#define CXL_PMU_ATTR_CONFIG1_CRB_FILTER_EN_MSK	BIT(19)
 #define CXL_PMU_ATTR_CONFIG2_HDM_MSK		GENMASK(15, 0)
+#define CXL_PMU_ATTR_CONFIG2_CRB_MSK		GENMASK(63, 32)
 
 static umode_t cxl_pmu_format_is_visible(struct kobject *kobj,
 					 struct attribute *attr, int a)
@@ -263,6 +272,11 @@ static umode_t cxl_pmu_format_is_visible(struct kobject *kobj,
 	     attr == cxl_pmu_format_attr[cxl_pmu_hdm_attr]))
 		return 0;
 
+	if (!info->filter_chan_rank_bank &&
+	    (attr == cxl_pmu_format_attr[cxl_pmu_crb_filter_en_attr] ||
+	     attr == cxl_pmu_format_attr[cxl_pmu_crb_attr]))
+		return 0;
+
 	return attr->mode;
 }
 
@@ -319,6 +333,17 @@ static u16 cxl_pmu_config2_get_hdm_decoder(struct perf_event *event)
 	return FIELD_GET(CXL_PMU_ATTR_CONFIG2_HDM_MSK, event->attr.config2);
 }
 
+static u16 cxl_pmu_config1_crb_filter_en(struct perf_event *event)
+{
+	return FIELD_GET(CXL_PMU_ATTR_CONFIG1_CRB_FILTER_EN_MSK,
+			 event->attr.config1);
+}
+
+static u16 cxl_pmu_config2_get_crb(struct perf_event *event)
+{
+	return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
+}
+
 static ssize_t cxl_pmu_event_sysfs_show(struct device *dev,
 					struct device_attribute *attr, char *buf)
 {
@@ -571,6 +596,14 @@ static int cxl_pmu_event_init(struct perf_event *event)
 		return -EOPNOTSUPP;
 	/* TODO: Validation of any filter */
 
+	if (cxl_pmu_config1_crb_filter_en(event)) {
+		if (!info->filter_chan_rank_bank)
+			return -EINVAL;
+		/* only valid for DDR Interface events */
+		if (cxl_pmu_config_get_gid(event) != CXL_PMU_GID_DDR)
+			return -EINVAL;
+	}
+
 	/*
 	 * Verify that it is possible to count what was requested. Either must
 	 * be a fixed counter that is a precise match or a configurable counter
@@ -627,8 +660,8 @@ static void cxl_pmu_event_start(struct perf_event *event, int flags)
 	hwc->state = 0;
 
 	/*
-	 * Currently only hdm filter control is implemented, this code will
-	 * want generalizing when more filters are added.
+	 * Filter ID=0: HDM decoder filter
+	 * Filter ID=1: Channel/Rank/Bank (CRB) filter
 	 */
 	if (info->filter_hdm) {
 		if (cxl_pmu_config1_hdm_filter_en(event))
@@ -638,6 +671,14 @@ static void cxl_pmu_event_start(struct perf_event *event, int flags)
 		writeq(cfg, base + CXL_PMU_FILTER_CFG_REG(hwc->idx, 0));
 	}
 
+	if (info->filter_chan_rank_bank) {
+		if (cxl_pmu_config1_crb_filter_en(event))
+			cfg = cxl_pmu_config2_get_crb(event);
+		else
+			cfg = GENMASK(31, 0); /* no filtering if 0xFFFF_FFFF */
+		writeq(cfg, base + CXL_PMU_FILTER_CFG_REG(hwc->idx, 1));
+	}
+
 	cfg = readq(base + CXL_PMU_COUNTER_CFG_REG(hwc->idx));
 	cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_INT_ON_OVRFLW, 1);
 	cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_FREEZE_ON_OVRFLW, 1);
-- 
2.39.5

