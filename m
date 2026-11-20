Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795188324;
	b=wuLBXAhq7HN8yX87lJnOebRlo9hVbklsRA5YbB7Vr/WZz8PrNJIcO3FyZW0xOVPn6VEl
	 cfJfZY3dss//yWB+SNr7eMWdn0ME9RnRUt9R4zrfM7E9vn8v45/pfEqTU/LKZMkPvLD+C
	 2Ky6mXMbyEvaGXNNsGkIRETCEMpJvf/KEGgQBljQcRT4MFDfZOapvYIGhBdAMwTgG/6p/
	 T5vlVtFargb8rh9uMJxoPGVAg8lkwLnEPkQ9uAO51IBk5uJsvGMOGVIVnH0Pren/l6sZa
	 avRDcv5RrW1KF0wzP+2dihNswEbnUrDSdy05queOaPszLnocXBBbc/Kr3t8rGCoAQeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795188324;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version;
	bh=aYcXr29ZY8+NqUOdQLPvNghpVC/hBxmFhnakvhMIR/w=;
	b=W8CQ3Uss+cvTGPVlryS4/3lfIZsz94p/92vvh7yodkebe+MzdUwuIEXiMfPnLXzb70vk
	 b9NUq/vsdvpCuHwCo8tcLDJEGUpao3Te9rehi9w72BWcpWtOnvQMl0rLnNyaJMP+FgmhT
	 +pOxI7NlhQt97L1rmW+ZLg0WPCyzAawQboq0B4NylcczznTiYFskumFtMtq3PRT0VNzIM
	 LYDOoeaU2e8Yp4CXb1dmhLgikVG6kDPwVdWI2trUwS4DMccdtje9ExqmBEXZsBHXwSKrc
	 baukRCAfOfPpZQ4u24mWuZNeZjSc5yGGH/EsUy+eXNXVS8isy6o5WWpOrzOqC283JRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fb.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=pBjzt0ci;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1262606A331;
	Fri, 20 Nov 2026 15:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1262606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=pBjzt0ci
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKEfS0p1873902;
	Fri, 20 Nov 2026 07:24:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=aYcXr29ZY8+NqUOdQLPvNghpVC/hBxmFhnakv
	hMIR/w=; b=pBjzt0cia/3xeaNZgZ/YyNI+HecdEZ7sQm/m41c5xo5l0TgGE0Z0Z
	q+cbESnvpzZqJxJ2h360QqjJjFv5LykldupI8uKOIkR0F44Jhk2sYTvv3iu3M+JL
	ZRnaaQtSVif1JZRqCGGcAp8JDnmewtw05+4UcEqr11g1XmisTfAWoggVbtc5Buzi
	pKi4jtYxCJJD+rsv9ZGDTJLMfTKz6o1JM4uxK6UuBTm+X4ihQ9qlNAfVSIVFuPCT
	BFm42X6w7OuDxVQYcB2Yr4MdG6PPnAjAgQ5YMh6tZ3EWUnZorgpu7ei7fCJAR5bY
	GqFDJKHgxLi5TutyoyAmiGPNklqh5p20g==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j1yjp2hw0-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 20 Nov 2026 07:24:58 -0800 (PST)
Received: from localhost (2620:10d:c085:108::150d) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 20 Nov
 2026 15:24:56 +0000
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
Subject: [PATCH v5 2/7] coresight: syscfg: Fail to enable a configuration not loaded on the device
Date: Fri, 20 Nov 2026 07:21:15 -0800
Message-ID: <699bb518b0f92c57227d4c73e21c58d8aadcc5a2.1795182850.git.aaupov@fb.com>
X-Mailer: git-send-email 2.52.1
In-Reply-To: <cover.1795182850.git.aaupov@fb.com>
References: <cover.1795182850.git.aaupov@fb.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA2MSBTYWx0ZWRfX+f1pqSfc15Yj
 5FbV62ndl+ZKG73W8OMkFpIZvSM2z/bKZvhF82WWSDQUNhwJX9cRFQD/XUJn94JWazTKVqkacJ1
 lMK70bay08XTfo5MzZLVpGTzvP/uFYW/Nwu3FhFSOrJzOeIQ7gEYG1wi3sPSl8tOOQGEtlsUB65
 ow+YoNoXZ3CVrQxNITU1zbLAvYHrZUF3F+YuiqeGQ3ktwEhHk5MTqzMvEMMELhh27/AxR9/3CaJ
 YLAgB0xLUoAjZ9bms1QO2OP4hyt6BBb0bqcjoB4VxhbiPKEF1vGZDdKMloGzS00FAA+mvZYyFwu
 0lWOicSdyMxq32OktDwf48bHOU4p0oWK0UKEmqCT4UVPYm7d2qLObrsrcCdBKrSvFq18iK8bOYX
 6b65ETs2kpFq/a+kTP8PG5Xl3Vc/2PXvLsQVKNVFrN+cOJQsxKJxwT5COE4m4Yf1Wfo49Nh/d+K
 itpBBEvDeuTYQi0HhcQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA2MSBTYWx0ZWRfXx5f4nw8DdEr7
 fci9nOJO/rdfzkuy9BOdaM7CDb8/aDymv2PpUJxWle1/T/BU5FMm/aGYXD8kQoEUrONrJ0OHTUk
 YhvnNP5xXk+MZUFIKEuJ1hCVtA/b6Ck=
X-Proofpoint-GUID: S8PRQsjlb_TnuaQsvmjkWViFZ_3Sksa6
X-Authority-Analysis: v=2.4 cv=aPtlOr9m c=1 sm=1 tr=0 ts=6b00664a cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=GbPsI2Ihf5RTnMjR_gZv:22 a=7CQSdrXTAAAA:8 a=FOH2dFAWAAAA:8
 a=HF-2DHWplcuDzBJEMXoA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: S8PRQsjlb_TnuaQsvmjkWViFZ_3Sksa6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01

cscfg_csdev_enable_active_config() looks up the selected configuration in
the device's loaded configurations, and returns success when it is not
there. A configuration is only loaded on devices that match at least one
of its features, so a perf session or sysfs enable that selects it on any
other device runs without the configuration, with no error.

Return -EINVAL instead, so enabling the source fails on that device. The
function is only called with a non-zero configuration hash, so sources
enabled without a configuration are unaffected.

Fixes: f8cce2ff3c04 ("coresight: syscfg: Add API to activate and enable configurations")
Assisted-by: Devmate:Opus-5.5
Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Amir Ayupov <aaupov@fb.com>
---
 .../hwtracing/coresight/coresight-syscfg.c    | 53 ++++++++++---------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
index 2bfdd7b45e49c8..a816c22c87bc87 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg.c
@@ -1088,36 +1088,39 @@ int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
 	raw_spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
 
 	/*
-	 * If found, attempt to enable
+	 * The configuration is active but not loaded on this device, because
+	 * none of its features match the device. Fail rather than trace
+	 * without it.
 	 */
-	if (config_csdev_active) {
+	if (!config_csdev_active)
+		return -EINVAL;
+
+	/*
+	 * Call the generic routine that will program up the internal
+	 * driver structures prior to programming up the hardware.
+	 * This routine takes the driver spinlock saved in the configs.
+	 */
+	err = cscfg_csdev_enable_config(config_csdev_active, preset);
+	if (!err) {
 		/*
-		 * Call the generic routine that will program up the internal
-		 * driver structures prior to programming up the hardware.
-		 * This routine takes the driver spinlock saved in the configs.
+		 * Successful programming. Check the active_cscfg_ctxt
+		 * pointer to ensure no pre-emption disabled it via
+		 * cscfg_csdev_disable_active_config() before
+		 * we could start.
+		 *
+		 * Set enabled if OK, err if not.
 		 */
-		err = cscfg_csdev_enable_config(config_csdev_active, preset);
-		if (!err) {
-			/*
-			 * Successful programming. Check the active_cscfg_ctxt
-			 * pointer to ensure no pre-emption disabled it via
-			 * cscfg_csdev_disable_active_config() before
-			 * we could start.
-			 *
-			 * Set enabled if OK, err if not.
-			 */
-			raw_spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
-			if (csdev->active_cscfg_ctxt)
-				config_csdev_active->enabled = true;
-			else
-				err = -EBUSY;
-			raw_spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
-		}
-
-		if (err)
-			cscfg_config_desc_put(config_desc);
+		raw_spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
+		if (csdev->active_cscfg_ctxt)
+			config_csdev_active->enabled = true;
+		else
+			err = -EBUSY;
+		raw_spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
 	}
 
+	if (err)
+		cscfg_config_desc_put(config_desc);
+
 	return err;
 }
 EXPORT_SYMBOL_GPL(cscfg_csdev_enable_active_config);
-- 
2.52.1

