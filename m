Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201107;
	b=slmFq4Xmk2GjOmYLhpynA4bFiu43kERFat9kFFEggHRA6vH9JxFqEMekyUhjqEkFoGK3
	 j+CklNFGZMAX2VuQVVXJTuFv0IsoJe17s4jdMBkEZfGxgs98LY5xD2eQpecvn6sn5atc1
	 r8b3HyGVP9HIf/TDhYUxv/3AF4xwxIvn5/WzuRzX0GoBMbnwA15fmbmtJnXyTqK58VPE6
	 4qjti9BvuNiDPzE41cwiF0w3QvzE2+941kaXTjcsJuF5RpWYDXxoFqlT2RMK2+5W9EpEy
	 SK274zNVx2frtZtBME1Ff9U1aiaW8qplWYIQPfAwfGCe6sFTuQkXGflNyyLOYhe37XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201107;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version;
	bh=BPNxmrkplXzbpgFWfOfRdiC3totnmzknYXs9H5qx0Jw=;
	b=Z9Hd+OU90MAbJmLeUXtTJUpVm1ISZBgrwUOVUPi8OSBpyS0k5tOrDOcF/LB4Ck2qTqpC
	 KUKpk6820lnryZGeYGQsBWBY2m5Z3PGPZd6vsPG+ewyxrfDe8GSc6EAZFtd9a/8Tafbqm
	 PJ6cFV7xGDw+9Yu3R5Y4lycg7p2JEa5yc8MdP/SFfrnIoo6/xlLaMEDljIAVzO2FHMoIJ
	 TpcqgRX8o4Tuyj58IkiydMXOeBUJaaLcGPDZLO4IvrhywHdAlKNUbfzXcdMX90T6PdYI/
	 YpQpb3NHzoc9h9u7j1ZcoNS0mnbA9b0aRCDgUwQ27wQE1mjfmP+VPOl4wS6skiTyR0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fb.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=TmWNmQ3M;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E5D60A2604;
	Fri, 20 Nov 2026 18:58:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06E5D60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=TmWNmQ3M
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKH7kJi2299190;
	Fri, 20 Nov 2026 10:57:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=BPNxmrkplXzbpgFWfOfRdiC3totnmzknYXs9H
	5qx0Jw=; b=TmWNmQ3MX9UI5j7Q1deEaQlh+7H4mmD92BriR8emCKZREYkzYxbd/
	agJkxuevMDvsv5V7qYglW+fLi7jxsq/L/s7r4VC+aSQKiTEhu2P458Xvfj0t9PzV
	MHSpnw4YVHlWlBNeRLb9oBcoT/fsk+FJrEu6GkjqTDFXDcgOckVUw1uigoeFovQI
	X/p0rCRfRZI1tu0weJB7MicAw2DYjzPQmxG3Og0XPJdTLYj659UdcmKVkKtWVgbe
	FlbMBq7L7h8SPMvh0uVVsXLW9CLPWpvDbXPEiq6ASb674EROhcVa6+E5Hmf3NzGj
	tlJM1GTChhyHAGfXqeSp436YCm4MWZ0QQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j2tb70x1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 20 Nov 2026 10:57:45 -0800 (PST)
Received: from localhost (2620:10d:c0a8:1b::30) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 20 Nov
 2026 18:57:44 +0000
From: Amir Ayupov <aaupov@fb.com>
To: James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>,
        Suzuki K
 Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@arm.com>,
        Alexander
 Shishkin <alexander.shishkin@linux.intel.com>
CC: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Randy Dunlap
	<rdunlap@infradead.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel
 Pereira <danielmaraboo@gmail.com>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 3/4] coresight: perf: Filter sources lacking the selected configuration
Date: Fri, 20 Nov 2026 10:54:33 -0800
Message-ID: <7ba910406fc81e09d31e9c6f3909012b9b85bf22.1795196854.git.aaupov@fb.com>
X-Mailer: git-send-email 2.52.1
In-Reply-To: <cover.1795196854.git.aaupov@fb.com>
References: <cover.1795196854.git.aaupov@fb.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NSBTYWx0ZWRfX7Kh7hLDMwBQn
 Rq57nI/AjxEWtLZ0jLURljKr7inIq4maZuYlFiDgG5P0CTTYmg3XBORFuU+NSf8bFN/8SfAP5iR
 wzvg1gl/NXovX+94DoKeH7oX9lA9v00=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NSBTYWx0ZWRfX9ZfWRukf9359
 CTaFh6Ck7io4LWFTCo4AgGJq8rm9Hcrhj/5Q87o/uw9BxWvMGkS+t1X/tVkcpO52kVTPdLJCetc
 /4NdQb9C8306Y8M5k6WBMVA0lp9tIap5CMsz8eMpoNcjU+B8E219K9w25SZb4WZPTZodnexj/Ak
 sXbh1IJVleV1tWoSNPy6DSZi8USFNnl6L0LXhXtAPgvG0LOdH446d+3Sy4v93xwZ/rOsY9GfDiz
 9I2GMATA7IWX4bLzsngPf2vA+SFeokYSGZvDG1HBNduXKYaAD3FPpg1uL0/HdJCVvZFXGYfC/3O
 HtNzwFp1ty9KFM7sRYw2NaGfnthNoGmnhCAAmKMWB3ABYR5EwAsl2Lq+O7VSeWhI0mninsMoZA7
 OHFHjqkzgUs/TAlTxdzU7yO44nVcUalSRNjL8keAvCNFjWJ9K4aaN/BOouGTHzlNVzg7ENsiUgX
 mSis25v8EqC6N4B9tIQ==
X-Proofpoint-ORIG-GUID: K36d5MkWNj1hTJn4kHBfjgaPjgYVRe9t
X-Authority-Analysis: v=2.4 cv=A/v5rKWG c=1 sm=1 tr=0 ts=6b009829 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=03ozwUkBphtHgyqjj1sw:22 a=7CQSdrXTAAAA:8 a=FOH2dFAWAAAA:8
 a=oS2Au8Yglpw7hEfJNBoA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: K36d5MkWNj1hTJn4kHBfjgaPjgYVRe9t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01

A system configuration may deliberately omit some CoreSight devices.
Keep generic configuration enablement as a successful no-op for
nonparticipants, but exclude ETM sources without the selected
configuration before allocating an AUX session.

Add a setup-only query while the configuration is globally activated,
checking device registration and per-device availability under the
manager mutex. Use the existing path-building failure handling to remove
unsupported CPUs and fail setup if no usable source remains.

Suggested-by: Mike Leach <mike.leach@arm.com>
Assisted-by: Devmate:GPT-6.1-Sol
Signed-off-by: Amir Ayupov <aaupov@fb.com>
---
 .../hwtracing/coresight/coresight-etm-perf.c  |  4 +++
 .../hwtracing/coresight/coresight-syscfg.c    | 32 +++++++++++++++++++
 .../hwtracing/coresight/coresight-syscfg.h    |  2 ++
 3 files changed, 38 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 09b21a711a8764..2d64c3314c0bad 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -350,6 +350,7 @@ etm_event_build_path(struct perf_event *event, int cpu,
 {
 	struct coresight_path *path = NULL;
 	struct coresight_device *source, *sink;
+	u32 cfg_hash = ATTR_CFG_GET_FLD(&event->attr, configid);
 	int ret;
 
 	source = coresight_get_percpu_source_ref(cpu);
@@ -361,6 +362,9 @@ etm_event_build_path(struct perf_event *event, int cpu,
 	if (!source)
 		return NULL;
 
+	if (cfg_hash && !cscfg_csdev_can_activate_config(source, cfg_hash))
+		goto out;
+
 	/*
 	 * If AUX pause feature is enabled but the ETM driver does not
 	 * support the operations, skip for this source.
diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
index 11946e5718fc5e..f4e122f66e98c8 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg.c
@@ -1050,6 +1050,38 @@ void cscfg_deactivate_config(unsigned long cfg_hash)
 }
 EXPORT_SYMBOL_GPL(cscfg_deactivate_config);
 
+/**
+ * cscfg_csdev_can_activate_config - Check whether a configuration is loaded on a device.
+ * @csdev: CoreSight device to check.
+ * @cfg_hash: Selector for the configuration.
+ *
+ * Does not activate or program the configuration. May sleep. The caller must
+ * keep the configuration activated while using the result to prevent unloading.
+ */
+bool cscfg_csdev_can_activate_config(struct coresight_device *csdev,
+				     unsigned long cfg_hash)
+{
+	struct cscfg_registered_csdev *csdev_item;
+	struct cscfg_config_csdev *config_csdev;
+
+	guard(mutex)(&cscfg_mutex);
+	if (!cscfg_mgr)
+		return false;
+
+	/* Unregistered devices do not have initialized configuration lists. */
+	list_for_each_entry(csdev_item, &cscfg_mgr->csdev_desc_list, item) {
+		if (csdev_item->csdev != csdev)
+			continue;
+		list_for_each_entry(config_csdev, &csdev->config_csdev_list, node) {
+			if ((unsigned long)config_csdev->config_desc->event_ea->var == cfg_hash)
+				return config_csdev->config_desc->available;
+		}
+		break;
+	}
+	return false;
+}
+EXPORT_SYMBOL_GPL(cscfg_csdev_can_activate_config);
+
 /**
  * cscfg_csdev_enable_active_config - Enable matching active configuration for device.
  *
diff --git a/drivers/hwtracing/coresight/coresight-syscfg.h b/drivers/hwtracing/coresight/coresight-syscfg.h
index 658e93c3705f1c..05289060a277e5 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.h
+++ b/drivers/hwtracing/coresight/coresight-syscfg.h
@@ -120,6 +120,8 @@ int cscfg_register_csdev(struct coresight_device *csdev, u32 match_flags,
 void cscfg_unregister_csdev(struct coresight_device *csdev);
 int cscfg_activate_config(unsigned long cfg_hash);
 void cscfg_deactivate_config(unsigned long cfg_hash);
+bool cscfg_csdev_can_activate_config(struct coresight_device *csdev,
+				     unsigned long cfg_hash);
 void cscfg_csdev_reset_feats(struct coresight_device *csdev);
 int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
 				     unsigned long cfg_hash, int preset);
-- 
2.52.1

