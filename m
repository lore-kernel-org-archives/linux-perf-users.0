Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792993733;
	b=weLdAwJyQ4jxZBaPo54vmQ+XWKzYQP13SYqWzuVvdbxry/OGeNt0yCxR0pShlpHdz6zs
	 ZMXkunHaefKriPm2U1j8c1d8dWVDIq0JZgZ2syNWkDJjmTDwG8s7r6iA6lG3byNQJEq2q
	 VKt6pF4Bg/SEUCLNb8mlJr7JEclKXz3kzgMX65jS7SVczCNrm0oU5IBKVS5rSH4NolXP1
	 FEtrLf84yrpOiTT8Rvhx0KnImLTbn0OvR/KsQ9FejXPWZavYQ1vErWF/Xm7JJ826sqDcZ
	 pbuLLg+XpLnAWSPEJuoIsrYQUY4qs1kaRo5bOydXBqvBm6hjtamHnzYkiPt/F+UPnRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792993733;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version;
	bh=A9bl18hVVgrv7Ih87a3z0Wf/fVitBdQUFLUywp64nL8=;
	b=aVUgokTcCM3MWf7/89GZAiIt8syON3dN4w42gUw64YcgWVSYTWqNQXXRUXQ/VuZT5d2N
	 G1PJGbW1eQCZKj4rSzmVot8gmM329ywWWqdQpqCCmrz6VRrT4hiegrMctjweyjBA24gmt
	 0hP1DyXcY0DhABqekwIkxhQ7I7DhFPVtzRCDOZQK7jZ8ooGscXr+0yaiSlFhqwR6Sd+XJ
	 L/cot00KFrPyBgsJbO4N6rL1i6b81xzLKLdoymgFrPmPIeOACVc0eROzHaDwFJ20tkkfc
	 6tcgCA9w6wYDYJ6xoK7lr/+Y4e5LTqy32dPov0fnFWjQEQs31RTzIx8Q8GYsSDM42HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fb.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=f5vTNBuD;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DA560A2608;
	Mon, 26 Oct 2026 05:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41DA560A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=f5vTNBuD
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q38wAL2861008;
	Sun, 25 Oct 2026 22:48:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=A9bl18hVVgrv7Ih87a3z0Wf/fVitBdQUFLUyw
	p64nL8=; b=f5vTNBuD0MxMQjl00dAgjBxKRjB0ahl/o41lNuiuxOhvrMUv5GReQ
	KYjiHWMHOSm5kJSaOLI7fvSXprxuclHkG6ZgW2AuFhNZrZRdNEKbJ8gjFXw1e6H4
	vp8pv0N2tHg5krV8N1JILztRIQgcR5FPNfp0BsgZ2ekBfXbSnTXMvJL/7QPCDrt9
	dhG9f3v8TMZ+oJklJrV7H7PLBu+5bcgY4oSewHXy2cuTwFcijW4baxUMX4VbTH+/
	Lt/CK2qr3+45Tos52LPp/+tKxd3n/WFJtnVreQJzQtzqpA82W8ZlTF3e5WhKHOWR
	JNcxxiLfoulysv4TdCVICDrl66j0VRcfg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hgtg6exqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 25 Oct 2026 22:48:34 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1c::11) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Mon, 26 Oct
 2026 05:48:33 +0000
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
Subject: [PATCH v4 4/7] coresight: syscfg: Remove unused CS_CFG_MATCH_INST_ANY
Date: Sun, 25 Oct 2026 22:48:24 -0700
Message-ID: <52b3c337cbf4a8460e399b084c6f854eb3beee89.1792989860.git.aaupov@fb.com>
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
X-Proofpoint-GUID: i8xt5jn8lp9NkcowSxGYUivne0NqIKOl
X-Proofpoint-ORIG-GUID: i8xt5jn8lp9NkcowSxGYUivne0NqIKOl
X-Authority-Analysis: v=2.4 cv=OJqyTiaB c=1 sm=1 tr=0 ts=6adee9b2 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=wpfVPzegXHpEFt3DAXn9:22 a=7CQSdrXTAAAA:8 a=FOH2dFAWAAAA:8
 a=izEjV56Hqa_c8yfQj7cA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyMiBTYWx0ZWRfX+6yW8JK4MQTW
 s8/TWcxLAyJHpRDMHviN9BpSkY6uApI4fPTM4wSkTU2cHmo+VDmIk3uxooUm6BRlkbgQAYnnSDM
 bf3qJe43nsdnDDfRAMMzHtBxcZvaccMSFOBPar9Qb6liiWX+39u6XquRsLJwwSWFHvMSD4OBYi4
 rsFhyL2QvNKU3wljsPmh6RRS9WwofiE3KW0Vki8X2vOodRe+KuxLZgbHmzp2NKLVTyZyyJCYqTT
 drG+7YTmilI6oNzflQJkj4fFdO6JLOFiaciwDOPMt4A5HHNU8uSqqlmdvwaEECjRJcVHQXreIDy
 7QLGUl0JFVl0PIECr8mj7ZatWWQA4d7N1cbsjvf+ovFayImI/zmn5rXF/4bBXP5m/uoh7bJPZLA
 zYB73uURN6z2jXLfsEUL7XKSsZl13uwwYTHnFq3nQoLnbzQ8EbFzPNt+G8bL44MCCXX9MYHiTQl
 kE97ZtaHAi4ARGJVQEA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyMiBTYWx0ZWRfX4gbY4byeAoIK
 0h0aqKQNhfc8zzyklj+ggArzFFDh41PwA2BfUYss2rlpk6/jRIlKqjRnNTsv9v22dZ94vu0H+qU
 KaS1tjl1ufP09DTG8VG2Hmneon6B+H8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01

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

