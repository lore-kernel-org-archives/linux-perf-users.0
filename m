Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D082925634;
	Thu, 30 May 2024 20:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717101798; cv=none; b=WlEsPRWMUKNgLlga7qbBTuhwQYIzLb0ryBqq4CxO/fyFtgHnqTKf2bpMWgi6JABWqZMOLIo5tDUuXsY47kHr2OL6bjZnYm/b88U68KsaGhj0CaIHiTOrvAJiFLpAa6PRb49aUG7s9mMyYpHPksxTVX3P/8c+li3CEna7UNnvhb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717101798; c=relaxed/simple;
	bh=b6+9QcaqPR6eKd7vhRCL3IX8thga/VHY8xqdaoMG6a8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=IauSOvwdVNCYoaSt/B8fG+pbuWZx7gt8m2c77d0jm6PxR3/mvsxr/g0mdXYecI54dXGAwZfo+APgUNYKL7oMV/HCGAa3+nDuJCajHeln8VFumACUqUjN77BetRiKmDqc+kj8WrYgFT6KUB28xC7ymqsoSVMoVbuSvD6Ypy47eU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JkHVRxM8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JkHVRxM8"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44UJPcrp015856;
	Thu, 30 May 2024 20:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jA5uTw0t5SGe/0e2eS5aqq
	8ToPbks7henFGLd7/wDGE=; b=JkHVRxM8fyYtzNCZUKgw1g4gDCicSOAbzodrRF
	XYG5GNPsuywp8Q6gn64Ma4EBGfSQueKpStmLKMDFcnRUBKPdvLWz1e7N5RNqVjZn
	gaX2XDc9WP+MX2KtVIYObtWcnFHTb7dN6osBbhyBDWqHALT7Hr8DoxSs9v4sqrKq
	R6D/Qleo8h2h6PnhNaT9eTiYMolqRUFIyXYZS93YpO1QkLieKv286mtO3P3Vo0yr
	Y6n171px//wsQV8UQbZwSDxMeN1Sl0k2WfOQ7c76cG8De/CFCZuQBG8Ke5hY5TA5
	dMTjn6IJnZPwYyWze9QEDLQ8IvnulYnp6UG8u90lhKuGsgZA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2pw6dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 20:42:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44UKgrvH012330
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 20:42:53 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 30 May
 2024 13:42:51 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 30 May 2024 13:42:51 -0700
Subject: [PATCH] perf/x86/intel: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240530-md-arch-x86-events-intel-v1-1-8252194ed20a@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAMrkWGYC/x3MQQqDMBBA0avIrDuQxFZCr1K6iHFsBjQtM1EC4
 t2bdvkW/x+gJEwK9+4AoZ2V37nBXjqIKeQXIU/N4Iy7mltvcJ0wSExY/YC0Uy6KnAstOA/eRW9
 N76yFln+EZq7/9ePZPAYlHCXkmH7DhfNWcQ1aSOA8v5d7FQKJAAAA
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
X-Proofpoint-GUID: PoUOubvu90PmO8mGUpyGGHTz7Prt8fhJ
X-Proofpoint-ORIG-GUID: PoUOubvu90PmO8mGUpyGGHTz7Prt8fhJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_17,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405300154

Fix the 'make W=1 C=1' warnings:

WARNING: modpost: missing MODULE_DESCRIPTION() in arch/x86/events/intel/intel-uncore.o
WARNING: modpost: missing MODULE_DESCRIPTION() in arch/x86/events/intel/intel-cstate.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 arch/x86/events/intel/cstate.c | 1 +
 arch/x86/events/intel/uncore.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index e64eaa8dda5a..9d6e8f13d13a 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -114,6 +114,7 @@
 #include "../perf_event.h"
 #include "../probe.h"
 
+MODULE_DESCRIPTION("Support for Intel cstate performance events");
 MODULE_LICENSE("GPL");
 
 #define DEFINE_CSTATE_FORMAT_ATTR(_var, _name, _format)		\
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 419c517b8594..c68f5b39952b 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -34,6 +34,7 @@ static struct event_constraint uncore_constraint_fixed =
 struct event_constraint uncore_constraint_empty =
 	EVENT_CONSTRAINT(0, 0, 0);
 
+MODULE_DESCRIPTION("Support for Intel uncore performance events");
 MODULE_LICENSE("GPL");
 
 int uncore_pcibus_to_dieid(struct pci_bus *bus)

---
base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
change-id: 20240530-md-arch-x86-events-intel-f682c8103211

