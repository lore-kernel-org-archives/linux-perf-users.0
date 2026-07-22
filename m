Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E0439768C
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 11:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784720442; cv=none; b=q7EtOvGVUw6ZgPSA9sn5LCD9gJ6fwHXjlGIJsQlAZNKC/SRPKtO2mr//dbfPz5GtUztGCkmascd1XtUYxOamJqqyCHt/nm7BZT0V6EjswUD0xLEaJj7pHbCSuEA9Vvd1SSJ/eP64ScdbA6vogl8kb1arcjwS+A+vv1+0FLmaTHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784720442; c=relaxed/simple;
	bh=ylM/6ye6xypg9DLWF3GDHXcW0l5CSp5KaDRbp5xdWkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e+7DzWyLpdSDPWKsOOwAUzredoDdazetdNCDIPt45sLwy5dNtp5Pspx8sWb1WVbk9issKY9GkoMxI6xKUR4qcfzPhZhWUS3UVUKAEXtdOUoL0UgC2Rl/K2SKqQqn8sTUXHQ/ERxOHddO/RQroxdwN39cuXIHSz6ElQE3VJpwgJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DX4QAEx+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DX4QAEx+"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M9Bt0k3671763;
	Wed, 22 Jul 2026 11:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=w7d7iOIr4JYo5xD1xds79ix5oGBdZQ9fFETxdf9cs
	PQ=; b=DX4QAEx+CWVySPpwTb3BJNV1hTrxK9X0Qhyw4ANeKn64Uqms9XFalM/8D
	8jRf7SGZnOBT3RU3qNvgJKMnNTALLPR5WDWFPy6DmsBWM6YMCVt3SIcTce/+IOqc
	HxE0WPKldUAOyehUnFQ0dJOxSzBtwbZHfNsscBEJjJ0asLov0NGjkJQG+wUbbdCh
	ZHJ18M6Cm9esI0zSoS+YWcN1HX6Xo6AadXY4754mqZSM41bCwasFdhGQ6+s2Fivg
	BWffYBR6ck2YAutMB4WQxwk1EMCZglu9HjPM8sQocF3RY52bR7kHwpLtX6qv8PDv
	c2ecE7fFaDMZO4WExr23PkcdiknFQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ah9ds6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 11:40:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MBYdt0001355;
	Wed, 22 Jul 2026 11:40:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gevdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 11:40:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66MBeMrD32506170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 11:40:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6CB62004B;
	Wed, 22 Jul 2026 11:40:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A837C20040;
	Wed, 22 Jul 2026 11:40:07 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.ibm.com.com (unknown [9.39.17.145])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jul 2026 11:40:07 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com,
        Tanushree Shah <tshah@linux.ibm.com>
Subject: [PATCH] perf trace-event: Fix buffer overflow in read_string()
Date: Wed, 22 Jul 2026 17:05:54 +0530
Message-ID: <20260722113552.191143-3-tshah@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: IH3K8sC4xbwUZdRWUfkS5Z0-Jx0su8TV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEwOSBTYWx0ZWRfX4gSFAA3ui2d0
 rjpy8C5s+b9ypx7epq7Wmig/LJLlCdc6JPyjE6U70FZWVGAT33+JWJI22H/F7KEVRfBYEd58oMl
 HrFcAbKYi4HNLFDAI7YURk9jnyDC+i1ntDEQ9v5ySHZvdQ7JNghhAbbV2W7IdAn0ZGlwtalRQW4
 au/JQ8YMpMXr+h0ix+dSXVpL+uYD8k0nPL8ZivN33RwNBqntjXTTx2VqSYdvM/whzHnppEszqKE
 oY+Wu+9Peywh/QlI+L3DYaoYxUowCalFtywHrqILB5WqkRxMCsj4ugTTrgFaTWZWKZsUobPi2ul
 C/szwV8Kfa6amjC/tNSV+1j0OxZce38QdXxPL0ZhSiadPkta9vAfqwZlhVPUsOs5fUM8aXxHqLM
 KDkkViN2YHgJT90kISDn5BfKTFbF8W1Ppcw8rsDi+A9gOfuejpUbdZoz8eE41k2XhLu3nQHdUtI
 q5Yfkmh2soDibzAxGSg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEwOSBTYWx0ZWRfXygLOrSfbec70
 ZcLSlSrRoW21WB1hqnpwRE2RSVW+53drel6vd5W0s6cXbRugDimoXxmZEw2iqQ1nxn8XevIlUXu
 otNv+xW2g5ZYmdGasGvGRxNoYxtKfpM=
X-Proofpoint-GUID: 3KK8R3ZqYVz4hUkQvnfmDDtcy9DTfAnm
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a60ac2b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=dRiuFSZL0wyzTp01T68A:9
 a=zgiPjhLxNE0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220109

read_string() writes into buf[BUFSIZ] one byte at a time without
checking 'size' against the buffer bound before each write. A
string longer than BUFSIZ in the input overflows the stack buffer.

Add a bounds check before each write to prevent overflow. On
overflow the function returns NULL, matching its other error paths.

Fixes: 9215545e99d8 ("perf: Convert perf tracing data into a tracing_data event")
Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
---
 tools/perf/util/trace-event-read.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index ecbbb93f0185..afd458cf1387 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -127,6 +127,11 @@ static char *read_string(void)
 			}
 		}
 
+		if (size >= (int)sizeof(buf) - 1) {
+			pr_debug("string too long (max %zu bytes)", sizeof(buf) - 1);
+			goto out;
+		}
+
 		buf[size++] = c;
 
 		if (!c)
-- 
2.47.3

