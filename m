Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4007202965
	for <linux-perf-users@vger.kernel.org>; Fri, 15 Aug 2025 08:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755246981; cv=none; b=HPIGvOfa1rG8BaZDJ293gjrRzYJopi0noZK2xhove7fw8jkvfPNaezSgoFcswECS6lmjieIRB19sAEJ9U9qZxU3rKhFsVZYwVVpV5LjQTREZqvXpwt+027T4QMhPAMz8j8I6WESoI2s8vrpsKzQgt8j3cgTyTcYSQ0CdoJ+QnlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755246981; c=relaxed/simple;
	bh=3iZpTqooxxmMyfCNEMJvXze/HvY7ejFEcsP7iFNFDvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q515TzgpUWI2MTF0X9VP/QZF75uYIyh7LC3l26OqmahenpitobG03P2T+W68fXk97CxzUiVPMFy96acV0YerV4G23Vf3W3T217glMBljYTyVi5kabzs+EvJy1Z/DDqm8Ft7nuk/+wqXO1gWMcCiXC12v21iNmavQ1QDjTlN7V+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mLCB3WRO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mLCB3WRO"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57F3oeio024264;
	Fri, 15 Aug 2025 08:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OoTEb0ZjFu1UgAtbI
	qU11Qqk0Qqvq2jV46tnKTWL4g8=; b=mLCB3WROIq7jqDQ7tmiarhK3EYnyYh5Fh
	YTXLUTqJppJ35rRfP26tcHBFEun9Jm5pQql7Pmf3Uy5/iVOwjzZFpuZWZ3YIpR8g
	FmRXO5ACk8FVRpr3VadzWWfA8EjO2xKN3UcQFCjPb9wU48EVP3OXsUErkFAKmS9s
	l33iuaGpAx6ZXZ1oZetclFYLKjL0rwJAFu0UoldjWsGU0+jUrC5cwUrhtRg9Oygk
	xZg9n5HbS0/10Q/L5cWZyfqzmgiMaVLkbqxhKV0ricexZsimZceXC+dzRzcAzvEj
	C8tLmen1og8u7XL30ob2Oxuvi21BGQ7Q9irqOPHF329BMT3hZi4vQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx14xgxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 08:36:15 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57F8aE1s002854;
	Fri, 15 Aug 2025 08:36:14 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx14xgxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 08:36:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57F7lM0p025628;
	Fri, 15 Aug 2025 08:36:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ejvmqx5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 08:36:13 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57F8a93k54264114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 08:36:10 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E315920043;
	Fri, 15 Aug 2025 08:36:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1120D20040;
	Fri, 15 Aug 2025 08:36:03 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.240.145])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Aug 2025 08:36:02 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        aboorvad@linux.ibm.com, sshegde@linux.ibm.com, atrajeev@linux.ibm.com,
        kjain@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Aditya.Bodkhe1@ibm.com, venkat88@linux.ibm.com
Subject: [PATCH 12/14] tools/perf: Add support for printing synth event details via default callback
Date: Fri, 15 Aug 2025 14:04:05 +0530
Message-Id: <20250815083407.27953-13-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250815083407.27953-1-atrajeev@linux.ibm.com>
References: <20250815083407.27953-1-atrajeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: t9tvttlxsf2QTiRG8L0Z7bTilG7jhEOj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX2ijnu/0Mn6VF
 Wkxo+BAAEDurQr3MJ8Rp9P1YE9RxA1poycGCMyX1LS4RBT14PbQEIpN+Oy350WxFlVeU7LRxMHL
 s89muBVwh6IB4NPPQf15U2Zaf8eXOpwrk0s50iXeZYkOD8eVOqCnzvNP+wRuhUhjrFRo0fu7u4H
 JODdOd5G5lrVTK9vT1leTBkK7xL4eQ7XHf+rnMlRQqkE+yPP/8wyoKvcP7qzFoGHQ/MftQHapyV
 pi2iItNtcxocutPy5LLccJdJDGe2ZI/AYq9GRxvt+n4CddR1ztFtbvP6IvOFxUPHm7Z+1IZOu+s
 7ZFRFHQ2lVio65x9JcSJQbfNLcDjnmncLuekvPBd0BVUm/vWQ0CSNJIKv6a6l/f1haqSwXA9wHY
 1+9j0i7z
X-Proofpoint-GUID: JtbQnFFsy4w_UFMb0YE2UTaMzs-Pya1X
X-Authority-Analysis: v=2.4 cv=fLg53Yae c=1 sm=1 tr=0 ts=689ef17f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=AvaB4oQTsM4m0fk9bDsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 spamscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120224

Introduce arch_perf_sample__fprintf_synth_evt to add support for
printing arch specific synth event details. The process_event()
function in "builtin-script.c" invokes perf_sample__fprintf_synth() for
displaying PERF_TYPE_SYNTH type events.

   if (attr->type == PERF_TYPE_SYNTH && PRINT_FIELD(SYNTH))
   	perf_sample__fprintf_synth(sample, evsel, fp);

perf_sample__fprintf_synth() process the sample depending on the value
in evsel->core.attr.config . Currently all the arch specific callbacks
perf_sample__fprintf_synth* are part of "builtin-script.c" itself.
Example: perf_sample__fprintf_synth_ptwrite,
perf_sample__fprintf_synth_mwait etc. This will need adding arch
specific details in builtin-script.c for any new perf_synth_id events.

Introduce arch_perf_sample__fprintf_synth_evt() and invoke this as
default callback for perf_sample__fprintf_synth(). This way, arch
specific code can handle processing the details.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 tools/perf/builtin-script.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index d9fbdcf72f25..eff584735980 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2003,6 +2003,12 @@ static int perf_sample__fprintf_synth_iflag_chg(struct perf_sample *sample, FILE
 	return len + perf_sample__fprintf_pt_spacing(len, fp);
 }
 
+static void arch_perf_sample__fprintf_synth_evt(struct perf_sample *data __maybe_unused,
+		 FILE *fp __maybe_unused, u64 config __maybe_unused)
+{
+	return;
+}
+
 static int perf_sample__fprintf_synth(struct perf_sample *sample,
 				      struct evsel *evsel, FILE *fp)
 {
@@ -2026,6 +2032,7 @@ static int perf_sample__fprintf_synth(struct perf_sample *sample,
 	case PERF_SYNTH_INTEL_IFLAG_CHG:
 		return perf_sample__fprintf_synth_iflag_chg(sample, fp);
 	default:
+		arch_perf_sample__fprintf_synth_evt(sample, fp, evsel->core.attr.config);
 		break;
 	}
 
-- 
2.47.1

