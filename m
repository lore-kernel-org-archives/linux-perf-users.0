Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792910377;
	b=Dm3z79xMC7APVVXg/1ypsxtt60jXHk/bAqaWbZZAU2TUVxrL9d+DEwvExrCvmiEi/zK7
	 Q3a4zoWWGQ0ko6Dizcb+SH+70VEH0Y7lbCOozRymSOweQdsKRWNbEMIksOLiQz376GO0+
	 wP5n9vPt+cG4iHQE7qRYOjwYY1N9eFwLnYUgqG0MRmoFQwWyWVCCHUyR+hcjLzvDnQQct
	 2R2v2sVafoIe60t0VyjlezF8vXsX1cNAZ42y9jaI4TzaeV/OkxVfIK5zcapDziTyyWdbT
	 1MT9y5Ybp71pTVRjB5XFVbiKoqLK8LYcAV7yCQdCnKHFR4rv3sIU6ivFdYvUzFez9ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792910377;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version;
	bh=A9bl18hVVgrv7Ih87a3z0Wf/fVitBdQUFLUywp64nL8=;
	b=l691wfst58ZpS+89bLLzvlGA9MZvqt8Lwq3kaZIpU/IzsNe0L1je0cPni3Iwx/J1Pi4m
	 bhrj7N9UzTRRfEHdAdbbweT2WAjcdPTmKQlYd2086EvaziBfLEhTXOzz5dylSLvOm/GVC
	 LwPtpENomnD+jwldKpLImBVA9j96IQX9zHSzZuKebIW7RgxgWq+GpBePvEWU6v4sIZpNo
	 TeptXX45sT/NQHiWf3xZPvUDbqYluQ5wbq8OQcfRSY7W63nPp6WSPrl4GHuhrlGhBed5g
	 /iahKKgXnOzOsxxIxw8Pc1B85rGFFZpSAPmxCmXmZ29p7mNHebeOZPB36ypqFabP/DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fb.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=A0lsAGtp;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B373B606A332;
	Sun, 25 Oct 2026 06:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B373B606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=A0lsAGtp
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69P4sXJ33859554;
	Sat, 24 Oct 2026 23:39:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=A9bl18hVVgrv7Ih87a3z0Wf/fVitBdQUFLUyw
	p64nL8=; b=A0lsAGtpStmQ1294rM06fJ+MxdROxNzf/Mo+bMXu64inGXv+6Ffm7
	57kzSfGSUJ4uUQZEur3KSkn/DZBlmuDZb+IF+RohCP3SJDywSKRdijyIfDiUOLtE
	Cs6pr1SCvVzouhZ7tQfJZnoo+hnqc8TjL96EQG6edGZ5TgIVDguPFzzjkzp244Bu
	PG4i2pwdwHFVmK2uvcU+PoNhNapYsvpCgG0njiqKAleMEAHvlL646QxjYbo2c2s1
	zPdIVeW2zRpqArxmXmBxnHM0k7OfH59mLlyFkvMM2E4/nIaVDapSAZU1RoJb4DJT
	QGiet8SfuK0h0TbE+4Ck1LcGbg1iYJJ2g==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hh7ucrreq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 24 Oct 2026 23:39:17 -0700 (PDT)
Received: from localhost (2620:10d:c085:108::150d) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Sun, 25 Oct
 2026 06:39:16 +0000
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
Subject: [PATCH v3 4/7] coresight: syscfg: Remove unused CS_CFG_MATCH_INST_ANY
Date: Sat, 24 Oct 2026 23:39:04 -0700
Message-ID: <52b3c337cbf4a8460e399b084c6f854eb3beee89.1792907333.git.aaupov@fb.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792907332.git.aaupov@fb.com>
References: <20261012230527.750567-1-aaupov@fb.com> <cover.1792907332.git.aaupov@fb.com>
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
X-Proofpoint-GUID: g_WBa0SmE3mzO0U886MCEDuPOY2yTsXa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI1MDAyNiBTYWx0ZWRfXwQs66oe6ZWXq
 smMs4APL3u0kQC9IiDPyBrrPlhnz8UlJUZWTvaE9Rw7EpaeWnxtMAOexkQbelpQF+N6soVbtv14
 d89xy9N7AAf0z7Y0WywG2eFuFwj2Hu1TUWnh67xibC70UKfLZ/4s2DZUkxY+9i4Y9A734RXTr6+
 9O235KYJpUu5IJx44lJVHVnE765NPT0DGGxqbPTSO8LR7d46yi0xdGlZ8HKU+/C61ZJJ5BLc9yk
 puYKS+gSORFhEpdSwxuZ9RqA19v8QJeQfWBsQEf14D8FuGQe3UK8GGwy63J+gZyy2S2AmmCKrzi
 zpmVn5MYjU1FRQZnaKRuw/JlEGEXNCD0Zj50MpSEFZmHfOugvoT4nzijkzZ6PHm9XaNuvRqYece
 ARh4+NrBKLuXnNrdPv/uQzAoX7d8zChjqqOA6+E2WgJN2THZ+Zn4yLTLWXirVvXINDJifu0jHdB
 J4v5BW6+V/ACihABQ5g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI1MDAyNiBTYWx0ZWRfX/4NY1D4MmO64
 aN458k/vJX8OGffSUERlI2brIgQl53efnreTDYsw6QJjRIukBUFqngep2aFqQ+ka4bnGInCFoRF
 Gi27a1G4PTsLOshp9LSo/65jIpuJTQw=
X-Proofpoint-ORIG-GUID: g_WBa0SmE3mzO0U886MCEDuPOY2yTsXa
X-Authority-Analysis: v=2.4 cv=SN3Xx+vH c=1 sm=1 tr=0 ts=6adda415 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=jCddH8ec0KUNCymVuxII:22 a=7CQSdrXTAAAA:8 a=FOH2dFAWAAAA:8
 a=izEjV56Hqa_c8yfQj7cA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-25_02,2026-10-21_02,2025-10-01_01

CS_CFG_MATCH_INST_ANY has been defined since the system configuration was
introduced but is not used by any configuration, feature or device.
Remove it.

Suggested-by: Leo Yan <leo.yan@arm.com>
Assisted-by: Devmate:Opus-5.5
Signed-off-by: Amir Ayupov <aaupov@fb.com>
---
 drivers/hwtracing/coresight/coresight-config.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
index f04e73b91d9a6..220bc54f8e5e1 100644
--- a/drivers/hwtracing/coresight/coresight-config.h
+++ b/drivers/hwtracing/coresight/coresight-config.h
@@ -39,9 +39,6 @@
  */
 #define CS_CFG_MATCH_CAP_MASK		GENMASK_U32(15, 8)
 
-/* flags defining device instance matching - used in config match desc data. */
-#define CS_CFG_MATCH_INST_ANY		0x80000000 /* any instance of a class */
-
 /*
  * Limit number of presets in a configuration
  * This is related to the number of bits (4) we use to select the preset on
-- 
2.52.0

