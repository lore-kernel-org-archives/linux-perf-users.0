Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792993733;
	b=PysjYonu2iJIVzyt9qnxHKwV8etak6hy4BYvOFDcLbSWze3Mi3YOA+bKxrw3apDAa6NU
	 mO9JdYHjf719R+nFAqqeU+QJIXUbNwORQxDcEVtfnJjn6QoHwDqXZSxxs7oam4H+hRN7b
	 S+/4UQ5EavG+2t2LdmmLdlaT9gINwlQqlfBD3ieNg62rzBhTeY1PwODAgeCGg0UxnT11v
	 exjMpFXnTNLQDiSotwGfLmsDt1fLN7+jNRT1WtUT4WbeMiHn8Gzo54c/Hoi3myyHuwOs/
	 AuWWtR+ONSEbSBnolmuls2nDMEjv648V2LsLEHegyAdS0VtBXfgO32+aytKoKQpLJ+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792993733;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version;
	bh=h5CPtsW845wIg8XT+7IjY3h0UyBjrJLt9Tps+aPI7oM=;
	b=kSIbji+nvD3qHIJ/3jmSdvJ7a1zPOI7B6cWa8fhnP29o23H9ZfgDSyMvxo2pw4XitSJE
	 HX2xrTTQupMZxh3O0AQM8Pp0vX457anBCceuSCkx7AtMey20XRGPgNsd4CxBzF0MbKDGK
	 2Jhwuk3JsD0BPoTQk9Ye/xH+PSsahtvAB7Wk5DckFS5tdUQMTzC738C/VBPEwXkEZmenX
	 dD1hyOZwHxJnFsjc0KLReWWwilDFwCXxgVWMA8jPe9er3BaPUn+oDe1UeVKt17puEhX+O
	 kihVogjyo6La2jmGCKuSLH5IExsxBrtopjNwbcqO8IyQx2aP4wsgmkKIKDZ0XLrW5pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fb.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=aFBJWMos;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F15C606A32C;
	Mon, 26 Oct 2026 05:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F15C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=aFBJWMos
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q39JjW1063621;
	Sun, 25 Oct 2026 22:48:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=h5CPtsW845wIg8XT+7IjY3h0UyBjrJLt9Tps+
	aPI7oM=; b=aFBJWMosNrA6X1Fv10uYkYPt8nn62qFrf5mCus4TmQenFDM/8MlTD
	2U7vMsuEeJMYvpFpqaw3dT/AXAQ+2WozIGuhC9jrFECL1ndQH21V7NX7S8J3+Luw
	QpjvYyaLaBA1Dc9+kF73HgWduW1/+4r57hhS/jOIbFGNynxJGj75PPdpLLhsen3J
	aFd5Dh7BqrDL6tjVAgRh1BsVahYEVVU++5+V6NZaejtH5KH5UGIybxhjim4Jk5Db
	EnNyJ+rcY10LONNINs4zts/MOuquh4uvPZfwmR3Gm44TCuKT1ZsLLahHwCcamvZN
	2+Gm9xX4LcCsedLA23xROh38SLXjuvoLA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hgtc0y640-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 25 Oct 2026 22:48:33 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1b::30) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Mon, 26 Oct
 2026 05:48:32 +0000
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
Subject: [PATCH v4 2/7] coresight: syscfg: Fail to enable a configuration not loaded on the device
Date: Sun, 25 Oct 2026 22:48:22 -0700
Message-ID: <cc6b083f1ece4625e5bed0aa13b1eac7e4d1e274.1792989860.git.aaupov@fb.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792989860.git.aaupov@fb.com>
References: <cover.1792907332.git.aaupov@fb.com> <cover.1792989860.git.aaupov@fb.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyMiBTYWx0ZWRfX5L69hV7Xtd87
 8H6cf5+ZWHCEGdUHSdsdQ4y099yJdXLVx+isw5g0wJk3OCX43ukSOtgvpX9BupT21CEN05CyJyu
 w2YVGEsLCclF9KSXNBMH+fGPAjxRvA/GhxKH7UVywuQ6GsII2nWxMcELxnZDhvahEl8U4t6tANB
 K8AaHX02V/HSXp8+EFrtPFZhWApTUqxows4JKaYNvXZzG2tZsoqVhmI7b74UY0fZJoWcJpZt1Zr
 YaKD2GL7A+MQLGaU6JYVHufDZSNKn4uSrG0EkmSwOWIrZFCmW5mh+4YJHSpwfuKyNbKx4iVH2kB
 rem9CKgTFtp0WkO03+iHP3uKwT8BVeFzThv++kkysSBZbV/T5AsMmf7eN0S0YlicvPd3lEZ60l6
 tKMlaeruAf4bJ2XbrAVhM/zF2sdIyURe0Bkn9bC84R/dyFRhO2vu+ieKC7D4VnTsCl5Lo14S79c
 XenssXxBaAI4Tn6mWuw==
X-Proofpoint-GUID: g1Aifh65k7-KI_eGbyqKsF3Ofe2YmTIr
X-Proofpoint-ORIG-GUID: g1Aifh65k7-KI_eGbyqKsF3Ofe2YmTIr
X-Authority-Analysis: v=2.4 cv=eIGGH3p1 c=1 sm=1 tr=0 ts=6adee9b1 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=PAz_-FQ8hEVmOPYdF0yf:22 a=FOH2dFAWAAAA:8 a=7CQSdrXTAAAA:8
 a=HF-2DHWplcuDzBJEMXoA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyMiBTYWx0ZWRfX0pjfGOs2QLky
 UZkKQengl2V/vIdMa0q/GOp5ngq0mztwp52peIA7QYnRhJ86sHg7PrCnjWj6bs5+GEQyJs7G6OU
 OcPIZTWpdGwsoq4B4KlJGatxANUI4No=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01

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
Signed-off-by: Amir Ayupov <aaupov@fb.com>
Reviewed-by: Leo Yan <leo.yan@arm.com>
---
 .../hwtracing/coresight/coresight-syscfg.c    | 53 ++++++++++---------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
index 2bfdd7b45e49c..a816c22c87bc8 100644
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
2.52.0

