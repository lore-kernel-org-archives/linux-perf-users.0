Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795188331;
	b=Xh8KWr0rZA0tEhrQhhLYOJ6/fbEsH5D4KgY/d7Wn+zWbt5snX0GIHM32kvFYYkqGaUl5
	 uwWG3khHm6aah0f1/P3qITLG0PqAgiCQ2s91AS01IB6SYqPDAykTHkjk9NI7VdUciz7hl
	 KrhEJ+s5vPbwFKfhMeX1lYLGAFQT48C8WjdQqCdTGvXtvTO09e6vFk0YCLqaef/ervhnH
	 NBuMJH0xZcQqschPbZ8iUZZJLEX4U6rXXHENuo4Wk3OZMyb7PQHUa4HKzIY8r0OcjMYvL
	 aUPv7Ha4Naf86NExw6iOMQdTcoGi8fscCNO6Kqfi3o0R+vi+5uFV+jZB7ZydVFxoXSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795188331;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version;
	bh=OU8R4ZH17lexJayT8JWrp7WLV9v5qC394pKe2jsS+8s=;
	b=HaT2rSBpNk9ZvH1FsmfzQe5jxY/VzppLxwiIAVkG0t3uAfMBkAlwpEPITKtMqvOXF9Vc
	 IfRljyDZfg0It2iZejulW6ImnUaw+MGKx/jOM8M7Q1dF0CGMbXoWA4nhxEgSlLGqdQ5yl
	 JbeiMZa5cM++kMEd8J4/UCba7TaY8wDpee6br89sY0FlZQ6tpD5uLgfNuxmq20k9+dmYI
	 UUsy73nZdp0CZELEkI978zK1CaGn4GhP4iHE+1tYb8a9K4RWFMmLjyeSH0sGUAb4AHeuu
	 fIOdWxnOqzN7s9fFeq7qCULjMHc4jN/dO6nVsm/K5HR7WR/qGg+KzHG6+43nkKK22hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fb.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=I+tO3W2v;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E84E60A2604;
	Fri, 20 Nov 2026 15:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E84E60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=I+tO3W2v
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKEfgPf1726622;
	Fri, 20 Nov 2026 07:25:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=OU8R4ZH17lexJayT8JWrp7WLV9v5qC394pKe2
	jsS+8s=; b=I+tO3W2v3EU7tItqNJbmyiH+f61vtWmGbBT2BiGHle8QtcuM0p7xD
	YW4lzfguLLZ7FPYxaaYqDyt2qJvc/8Z5CU8TFcXpQNv//pE6gmWi5NNEM7sC0FWs
	4MvuiTvR/XhOPrYoCzqN1jTgC06Hc96mtUDJ43EsRuWVLfohHkPE4hgZnxzW3auZ
	xhiRBtP35qNjYpmTRdYuzvmoy20rwbmQrNLtqLMItyvHZwLfE9wW4GFwaJEOj2c/
	fkrNzDKyG1AaYSHPlbjnCifjTaKdNKE9w/xfkNPlY5WYSOqu/qXb4KgWx7M/7Pou
	6IknLFd22R9wxAepsIBC5pUV1X89fKCuw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j20fy26m7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 20 Nov 2026 07:25:05 -0800 (PST)
Received: from localhost (2620:10d:c0a8:1b::8e35) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 20 Nov
 2026 15:25:04 +0000
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
Subject: [PATCH v5 4/7] coresight: syscfg: Remove unused CS_CFG_MATCH_INST_ANY
Date: Fri, 20 Nov 2026 07:21:17 -0800
Message-ID: <067f9ccea51c9ad604d960125396d93440fe221e.1795182850.git.aaupov@fb.com>
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
X-Authority-Analysis: v=2.4 cv=NOdAaE6g c=1 sm=1 tr=0 ts=6b006651 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=xtH7KyWI9dI7BmFOsl-x:22 a=7CQSdrXTAAAA:8 a=KKAkSRfTAAAA:8 a=FOH2dFAWAAAA:8
 a=u8cZCkVQoIr18-6TTHIA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: GOivNdsdRe4P1Izh6lRav-U6hpGPqZIg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA2MSBTYWx0ZWRfXxf+OAZxmDZaO
 JjOqqg9sxB21xybg9wWNhPtx2pwTLqqQPtiVdEGTuGUnmBOX1/4AUv5z7YIhpxg709LEMhYN4jN
 YoxG3O5wrGQNL8DYLVViNSjAiXe2iaEpo7656H3CeJjSipZl9Q7qQNMOwOEjWS40sAxH+Fe+ltB
 6dyJePQk2Izb+U6mFG/grXYFh7Htf4f5RpyjqV2+IZp1hYkQbp2ZMUdxOt59fiAMGtMORLsU1Zs
 pQRx+Vbn7BOs07jFEAeh+mdzdzZUmFDDMlcX+oiFOjpccdxFLHV/IIhXgZDpGB2EMyQAXzq+2gF
 MivfoJjtvPDsHFxFaeMIzwCKLSO8Cqd7u8r5zldJl6iCpPc3rtkWJlXhJ4bJk6SNw/MAtgoVcEK
 m7okSAkCQULn+OKO3CWBXzVCJCo1Y2VRidxYsSUCL2W4axUoLHFH1FbiJQMzvXX8u8iy4TO3OYs
 Hl7WlQm723mbrzGkgqA==
X-Proofpoint-ORIG-GUID: GOivNdsdRe4P1Izh6lRav-U6hpGPqZIg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA2MSBTYWx0ZWRfX8E6G+6ROt+lc
 drqC5iSenrKdojYCIETQkPGmnuR04daTlklxwFxcMW3HAZLTbUSgR3YtwUxfCJJVUBvlnDyBBG5
 gpx4AV974u6Z76NvzvIgN3ymCBozXgc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01

CS_CFG_MATCH_INST_ANY has been defined since the system configuration was
introduced but is not used by any configuration, feature or device.
Remove it.

Suggested-by: Leo Yan <leo.yan@arm.com>
Assisted-by: Devmate:Opus-5.5
Reviewed-by: James Clark <james.clark@linaro.org>
Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Amir Ayupov <aaupov@fb.com>
---
 drivers/hwtracing/coresight/coresight-config.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
index f04e73b91d9a63..220bc54f8e5e1b 100644
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
2.52.1

