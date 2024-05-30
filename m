Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47C346521;
	Thu, 30 May 2024 20:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717099977; cv=none; b=bD5YAQeC4XudEGrJJ5yo2C/ib06IdSPSscfNnRuqW9FA7Nxpb570MCAxwlPnzYF8fsZwTy7rsediCqtdH7YeJ5SFYmElcYIRJdZWaoO9v2bhRX8F1Sgk1dgo9kd5mvA6xeiC2upKKjXNSCBviNMUIZXbXfPS5iDKJ/XdUWlr6e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717099977; c=relaxed/simple;
	bh=1vL07RCqj3kFTFg3bYnNnRy8fhnzA3ra/UaxnGk4vyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=RmqEFtR5RLNxOeELzDY/NmptztVMgIcClAMPmqR2pRkzzAv65LCtbOa5AlJC+GwJUU5/8cO8FEJ2Rsym2SfSzb/GVPd7VUQTfUtCVCNNqUz19zimTzjMkIB0jkFOOQW6jizo82uvnpAGygH/42tmSy8JWHqjUORQuH0MraDNbso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BRoAtNLK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BRoAtNLK"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44UDu6Eb006618;
	Thu, 30 May 2024 20:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pq5XmJfJwcsuxLIpo5U6KX
	z1UY1KjzFzxBckgzVuShM=; b=BRoAtNLKzVEMEJ96rQj66NUURQccCrzvhMCP/x
	VU2OJADSDYM9zuF8smc4N0hk54/0hE87n0TD9lpfI4hc/KPTkyV9WT+nxjGeKGK7
	JF8HJms7SOmMBOo8zSAo3Y6yEI3Cu5DMgQDHiOZEnzeDlcIf7oZt+mSedT3u65UU
	KlX444YgYg191nbFUZSdERLq46K7mcnihe1YxXG77asonK9h1X4CPAgKyrrKCBS5
	DoC/A8mPQaoq92mFlgV4SE10WsAxmHIp+Rj+NU1c1qtmfl3ct4k83Av0qfU7OpdX
	ZP96fcEG+JHPfogxLAdlCIwMgEQJrKN6jjeghTeNusNopKkQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ye96bk9hr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 20:12:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44UKC5V8008633
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 20:12:05 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 30 May
 2024 13:12:04 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 30 May 2024 13:12:03 -0700
Subject: [PATCH] perf/x86/rapl: add missing MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240530-md-arch-x86-events-v1-1-e45ffa8af99f@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAJLdWGYC/x3MQQqDMBBA0avIrDuQRiO2VyldJHE0AzUtM1YC4
 t2bunyL/3dQEiaFe7OD0MbK71xxvTQQk88zIY/VYI3tjGsNLiN6iQnL0CNtlFfFW+tctF0/BDt
 BDT9CE5dz+nhWB6+EQXyO6b96cf4WXLyuJHAcP9c2A4eDAAAA
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim
	<namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        "Dave
 Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin"
	<hpa@zytor.com>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qU2X86iXi3KjpsQyUgMtIeztTM9ZL6Hm
X-Proofpoint-ORIG-GUID: qU2X86iXi3KjpsQyUgMtIeztTM9ZL6Hm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_17,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405300150

Fix the warning from 'make C=1 W=1':
WARNING: modpost: missing MODULE_DESCRIPTION() in arch/x86/events/rapl.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 arch/x86/events/rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 46e673585560..0c5e7a7c43ac 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -64,6 +64,7 @@
 #include "perf_event.h"
 #include "probe.h"
 
+MODULE_DESCRIPTION("Support Intel/AMD RAPL energy consumption counters");
 MODULE_LICENSE("GPL");
 
 /*

---
base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
change-id: 20240530-md-arch-x86-events-9355c2468b2f

