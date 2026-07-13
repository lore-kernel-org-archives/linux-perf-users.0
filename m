Received: from silver.cherry.relay.mailchannels.net (silver.cherry.relay.mailchannels.net [23.83.223.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FF337C10C;
	Mon, 13 Jul 2026 06:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783924660; cv=none; b=QdJXZaQgasLDLjXO2+olTq5JMOfyvyJL/OSXAtbFp3FDYrcZ2pwhnmp4v8UQ1m++jUmK4WiMv6ePFQniF4CWS4nVVkRrTesCcCsZ5Eo5SfSvpK5Z5sPXSXqNXnOaUomOLq7NAD2hQcvHiCXh9TyMSu9g32C2a6h+XnqP4oBJ658=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783924660; c=relaxed/simple;
	bh=X+MxHNWgG+jCdBn4XICUZo/b10URm+NRLG1sfrGa+w4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eGoIAx2C4SZHbdM0tmyOmpWYinlAw2Ad5FSPvTreNdxM9th5M28kLDi7R1pw8Y8Ytc5npKWrR8wTydpezidoAdzsb+A+0N7qGerPM+j4a9c80wLxeFOWUeqB3IUyxQI5O0MSgRYmyi1fe8xvuZ8yuMfdS5Rt80Km9i/DSLNw0KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=lxu+sN96; arc=none smtp.client-ip=23.83.223.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="lxu+sN96"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 888067A261A;
	Mon, 13 Jul 2026 06:11:20 +0000 (UTC)
Received: from pdx1-sub0-mail-a229.dreamhost.com (100-99-12-219.trex-nlb.outbound.svc.cluster.local [100.99.12.219])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 330F57A066D;
	Mon, 13 Jul 2026 06:11:20 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Lonely-Whimsical: 2fc3d3f04a48515d_1783923080471_1164131750
X-MC-Loop-Signature: 1783923080471:3517101457
X-MC-Ingress-Time: 1783923080471
Received: from pdx1-sub0-mail-a229.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.12.219 (trex/8.0.2);
	Mon, 13 Jul 2026 06:11:20 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a229.dreamhost.com (Postfix) with ESMTPSA id 4gzBs34S2NzTR;
	Sun, 12 Jul 2026 23:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1783923080;
	bh=pTJcDAQgnCO299gLmvH6Cu9xDIp5TOVM+7pacwEs3JQ=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=lxu+sN96axRR8STDg4Py/sE8JQccKKoYtWCwrqAggN87jI11gStAyZXCKDO2WlsXG
	 C6meOt8whNIsYFKHc9LUBtXDNR6EPoZiDIYwrVjKd/Xmjtdt9A+r0IXIpCx9pwJHCK
	 tXukGRCccIfyswn0UjdYhZIZft/BDNq3FeuTjIO7gY9uI45wy2+rNGrHcEbiDm2XLF
	 SdpkLIbstGuIxOTlAThfAzbV7S7x37ZHwsWcSnsHX5eqAWDy18I/OlvIW1hoSQwOjt
	 1isOnYpVEQkEfTjt1I3V8ooCwOvInQ+3SpgyuU2awWSSZm94+NPAfTlMSrQfpuCnG1
	 UNIRenNp3AH4A==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com
Cc: harshal.t@samsung.com,
	icheng@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v3 3/3] perf/cxlpmu: Support Channel/Rank/Bank filter
Date: Sun, 12 Jul 2026 23:11:12 -0700
Message-Id: <20260713061112.105419-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260713061112.105419-1-dave@stgolabs.net>
References: <20260713061112.105419-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Harshal Thakkar <harshal.t@samsung.com>

Implement CRB filtering per CXL 4.0 8.2.7.2.2, and extend the
current filtering support beyond HDM. CRB filtering is only
permitted for the DDR Interface, Queue Occupancy, Queue Residency
and Retry event groups (CXL 4.0 Table 13-5), and only when counting
a single event (a single mask bit). For example, to count DDR
activates on channel 2 only:

  perf stat -a -e cxl_pmu_mem0.0/ddr_act,crb_filter_en=1,crb=0x02FFFFFF/

Placing the 32-bit CRB value at config2:32-63 leaves the
existing HDM value at config2:0-15 untouched and avoids needing
a new config3.

Signed-off-by: Harshal Thakkar <harshal.t@samsung.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/perf/cxl_pmu.c | 63 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 1fc83858f653..ca3361eb832d 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -110,6 +110,7 @@ struct cxl_pmu_info {
 	int on_cpu;
 	struct hlist_node node;
 	bool filter_hdm;
+	bool filter_crb;
 	int irq;
 };
 
@@ -146,6 +147,8 @@ static int cxl_pmu_parse_caps(struct device *dev, struct cxl_pmu_info *info)
 	info->num_event_capabilities = FIELD_GET(CXL_PMU_CAP_NUM_EVN_CAP_REG_SUP_MSK, val) + 1;
 
 	info->filter_hdm = FIELD_GET(CXL_PMU_CAP_FILTERS_SUP_MSK, val) & CXL_PMU_FILTER_HDM;
+	info->filter_crb = FIELD_GET(CXL_PMU_CAP_FILTERS_SUP_MSK, val) &
+		CXL_PMU_FILTER_CHAN_RANK_BANK;
 	if (FIELD_GET(CXL_PMU_CAP_INT, val))
 		info->irq = FIELD_GET(CXL_PMU_CAP_MSI_N_MSK, val);
 	else
@@ -229,6 +232,8 @@ enum {
 	cxl_pmu_edge_attr,
 	cxl_pmu_hdm_filter_en_attr,
 	cxl_pmu_hdm_attr,
+	cxl_pmu_crb_filter_en_attr,
+	cxl_pmu_crb_attr,
 };
 
 static struct attribute *cxl_pmu_format_attr[] = {
@@ -240,6 +245,8 @@ static struct attribute *cxl_pmu_format_attr[] = {
 	[cxl_pmu_edge_attr] = CXL_PMU_FORMAT_ATTR(edge, "config1:17"),
 	[cxl_pmu_hdm_filter_en_attr] = CXL_PMU_FORMAT_ATTR(hdm_filter_en, "config1:18"),
 	[cxl_pmu_hdm_attr] = CXL_PMU_FORMAT_ATTR(hdm, "config2:0-15"),
+	[cxl_pmu_crb_filter_en_attr] = CXL_PMU_FORMAT_ATTR(crb_filter_en, "config1:19"),
+	[cxl_pmu_crb_attr] = CXL_PMU_FORMAT_ATTR(crb, "config2:32-63"),
 	NULL
 };
 
@@ -250,7 +257,9 @@ static struct attribute *cxl_pmu_format_attr[] = {
 #define CXL_PMU_ATTR_CONFIG1_INVERT_MSK		BIT(16)
 #define CXL_PMU_ATTR_CONFIG1_EDGE_MSK		BIT(17)
 #define CXL_PMU_ATTR_CONFIG1_FILTER_EN_MSK	BIT(18)
+#define CXL_PMU_ATTR_CONFIG1_CRB_FILTER_EN_MSK	BIT(19)
 #define CXL_PMU_ATTR_CONFIG2_HDM_MSK		GENMASK(15, 0)
+#define CXL_PMU_ATTR_CONFIG2_CRB_MSK		GENMASK_ULL(63, 32)
 
 static umode_t cxl_pmu_format_is_visible(struct kobject *kobj,
 					 struct attribute *attr, int a)
@@ -267,6 +276,11 @@ static umode_t cxl_pmu_format_is_visible(struct kobject *kobj,
 	     attr == cxl_pmu_format_attr[cxl_pmu_hdm_attr]))
 		return 0;
 
+	if (!info->filter_crb &&
+	    (attr == cxl_pmu_format_attr[cxl_pmu_crb_filter_en_attr] ||
+	     attr == cxl_pmu_format_attr[cxl_pmu_crb_attr]))
+		return 0;
+
 	return attr->mode;
 }
 
@@ -323,6 +337,17 @@ static u16 cxl_pmu_config2_get_hdm_decoder(struct perf_event *event)
 	return FIELD_GET(CXL_PMU_ATTR_CONFIG2_HDM_MSK, event->attr.config2);
 }
 
+static u16 cxl_pmu_config1_crb_filter_en(struct perf_event *event)
+{
+	return FIELD_GET(CXL_PMU_ATTR_CONFIG1_CRB_FILTER_EN_MSK,
+			 event->attr.config1);
+}
+
+static u32 cxl_pmu_config2_get_crb(struct perf_event *event)
+{
+	return FIELD_GET(CXL_PMU_ATTR_CONFIG2_CRB_MSK, event->attr.config2);
+}
+
 static ssize_t cxl_pmu_event_sysfs_show(struct device *dev,
 					struct device_attribute *attr, char *buf)
 {
@@ -621,6 +646,32 @@ static int cxl_pmu_event_init(struct perf_event *event)
 		return -EOPNOTSUPP;
 	/* TODO: Validation of any filter */
 
+	if (cxl_pmu_config1_crb_filter_en(event)) {
+		if (!info->filter_crb)
+			return -EINVAL;
+		/*
+		 * CRB filtering (Filter ID 1) is only valid for the DDR
+		 * Interface, Queue Occupancy, Queue Residency and Retry
+		 * event groups (CXL 4.0 Table 13-5).
+		 */
+		switch (cxl_pmu_config_get_gid(event)) {
+		case CXL_PMU_GID_DDR:
+		case CXL_PMU_GID_QUEUE_OCC:
+		case CXL_PMU_GID_QUEUE_RESID:
+		case CXL_PMU_GID_RETRY_EVENTS:
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		/*
+		 * Filtering while counting multiple events is
+		 * undefined behavior.
+		 */
+		if (hweight32(cxl_pmu_config_get_mask(event)) > 1)
+			return -EINVAL;
+	}
+
 	/*
 	 * Verify that it is possible to count what was requested. Either must
 	 * be a fixed counter that is a precise match or a configurable counter
@@ -677,8 +728,8 @@ static void cxl_pmu_event_start(struct perf_event *event, int flags)
 	hwc->state = 0;
 
 	/*
-	 * Currently only hdm filter control is implemented, this code will
-	 * want generalizing when more filters are added.
+	 * Filter ID=0: HDM decoder filter
+	 * Filter ID=1: Channel/Rank/Bank (CRB) filter
 	 */
 	if (info->filter_hdm) {
 		if (cxl_pmu_config1_hdm_filter_en(event))
@@ -688,6 +739,14 @@ static void cxl_pmu_event_start(struct perf_event *event, int flags)
 		writel(cfg, base + CXL_PMU_FILTER_CFG_REG(hwc->idx, 0));
 	}
 
+	if (info->filter_crb) {
+		if (cxl_pmu_config1_crb_filter_en(event))
+			cfg = cxl_pmu_config2_get_crb(event);
+		else
+			cfg = GENMASK(31, 0); /* no filtering if 0xFFFF_FFFF */
+		writel(cfg, base + CXL_PMU_FILTER_CFG_REG(hwc->idx, 1));
+	}
+
 	cfg = readq(base + CXL_PMU_COUNTER_CFG_REG(hwc->idx));
 	cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_INT_ON_OVRFLW, 1);
 	cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_FREEZE_ON_OVRFLW, 1);
-- 
2.39.5

