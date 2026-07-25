Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4B92BE65F
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Jul 2026 18:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785005442; cv=none; b=KDSueeW6tXC3b4l/q2VMLYm9Koja7ZhJgQVxAC/jCCvo9d93qcIYgceRgp4z3P2fo634BQtdlWc0DSwf89ovnq2WIbC9kqRl5zSsQiayOoU4HStczfpaMhBySCZqBbh6eX/KLWZ+Y7QQoEXwmxCYkt6qm/9zjHjkLV6nj8jSfds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785005442; c=relaxed/simple;
	bh=QmbxOxFc8KLqhoMrGj2ZrnxwBACayOv0mpZ1BkaE1nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0NcUd0a0Le1zDXIxfZ77j1GsLVz5gPJuAz6x+LfH0GmK8wIkbtb7NKzcowJ89tJCwzYcBkbdK9BmiCvWYbFph/FYWBwX/yzIYmydadKV32xzp6x2yAMyM9Tonp5nGYPJJquTDxHAEPO0lMDXkcSV39WZ92DttcLLbT0cGHcWGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FAkclV7g; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FAkclV7g"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PHHVhX1204146;
	Sat, 25 Jul 2026 18:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Wyivw71RBvdt3wWSN
	EbL5r9BRvw25jb3VfkrqOGJ9tA=; b=FAkclV7gufBFG2Vl5Bbsa9uz/vAi/3ISA
	NT9E35G75r68SOvs0eLJfb5/yWRYh2tFqXkNrYxxrZ8aHJM+DzN5qboLD6tG7mG/
	D2hibzkHedx6G6kn8M/Dutku04as7Dwqy5H7E0CyxHkG1MpzZuhmJ8HzkzwCGBIP
	T/3D2CDgotE7FyDkkInYM+UHxM70d6dNIXteT/ViSrjpx/KCf9iWAHES4kSkGDPI
	63KbccJo8iMzI545eBOqsibrJf3ZWICIOmvjM9TBuudeAWuYTdW8wD0MjWroD8Nv
	Z9JMzLhX8CsTj038ETDEpy4YwMGog1We2jppxodxZvF+ts1LBmfvQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw714yb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 18:50:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66PIfJfb031773;
	Sat, 25 Jul 2026 18:50:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fmn2c27q3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 18:50:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66PIoSZX52429196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 18:50:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 368732008F;
	Sat, 25 Jul 2026 18:50:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 499002008B;
	Sat, 25 Jul 2026 18:50:19 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.ibm.com.com (unknown [9.39.22.45])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 Jul 2026 18:50:19 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Tanushree Shah <tshah@linux.ibm.com>
Subject: [PATCH v4 3/5] perf trace-event: Avoid double free and leak in trace_event__cleanup()/trace_event__init()
Date: Sun, 26 Jul 2026 00:19:51 +0530
Message-ID: <20260725184953.234759-4-tshah@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260725184953.234759-1-tshah@linux.ibm.com>
References: <20260725184953.234759-1-tshah@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: v17ngWj4F4026gCFP468-3knmfSsS5SH
X-Proofpoint-ORIG-GUID: 9GpF2lR2ID9wOu46YmKANRynYlRrKwdR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDE3OCBTYWx0ZWRfX2LlUblEbZUtw
 dFRXCxiCXH0jALcZuvGfz1NKnBFXX/tRIqN6Xm8oSRr4XydHVmQ4vDUubhTfksmF0lWV3KaQWCU
 VG8610XdB4ey7h/n+XhuJ5GwCR9M5JendMCJLVpQGQqoXk+n/UkGPVDILqyVTQZbOixQxSdM0le
 KDo0zPmkCRN/9yDWcyRTJgLx8ayJUlvAce+w5DZqckeeM2KZXUVmEGY6eEDitxApT75Wwrylti+
 /jUEY7Zy504+a+nissrNghM4QJJEj4VTHCL9OTM6z/MEsQxwyZ3Lpm3bkBANUAWodxImqezSWlB
 JBlyKAhjsWabhg6+KGJ32MTl9DkxbIon/oV/p7DcNNHZX0FEMjQS0F2jKhwZaaP6o8p3dDFsna0
 yzrvaJFwjeUKEus9B8BO3QeYXjadTwwwM2OQC0sZGgqGKS81kUWsLmo0aCAtBenUnzCWWbY4/QI
 E3nEgtq71cWT2JWhKyA==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a650579 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=yB9zBidaGe_VFMsS3VsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDE3OCBTYWx0ZWRfX/arUMyGGj16L
 JwL7c5Yf/IjdIwSXiiPb8cy89+72nOTgcthShosAYSRwIi4xa6+wWfXv66N5P5YSCEiKL0z6NkV
 JnPlFZ97fHuWLt1y2HES6f10tkaRjwA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607250178

trace_event__cleanup() frees t->pevent but never clears the
pointer. It can be called twice on the same trace_event: once
from trace_report()'s error path, and again from
perf_session__delete() during session teardown, resulting in a
double free / use-after-free.

Separately, trace_event__init() overwrites t->pevent/t->plugin_list
without releasing any existing handle, leaking memory if it's
called more than once on the same struct. eg. via a perf.data
file with multiple PERF_RECORD_HEADER_TRACING_DATA headers.

Guard against re-entry by returning early if t->pevent is already
NULL, and clear it after cleanup so a repeat call is a safe no-op.
Call trace_event__cleanup() at the start of trace_event__init(),
so a repeated init releases any existing handle before allocating
a new one.

Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
---
 tools/perf/util/trace-event.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/trace-event.c b/tools/perf/util/trace-event.c
index 6a8c66c64b70..000c1e1d68c1 100644
--- a/tools/perf/util/trace-event.c
+++ b/tools/perf/util/trace-event.c
@@ -26,7 +26,11 @@ static bool tevent_initialized;
 
 int trace_event__init(struct trace_event *t)
 {
-	struct tep_handle *pevent = tep_alloc();
+	struct tep_handle *pevent;
+
+	trace_event__cleanup(t);
+
+	pevent = tep_alloc();
 
 	if (pevent) {
 		t->plugin_list = tep_load_plugins(pevent);
@@ -63,8 +67,13 @@ int trace_event__register_resolver(struct machine *machine,
 
 void trace_event__cleanup(struct trace_event *t)
 {
+	if (!t->pevent)
+		return;
+
 	tep_unload_plugins(t->plugin_list, t->pevent);
 	tep_free(t->pevent);
+	t->pevent = NULL;
+	t->plugin_list = NULL;
 }
 
 /*
-- 
2.47.3

