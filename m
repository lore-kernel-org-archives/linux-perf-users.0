Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D96828E5F3
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Sep 2025 05:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758000385; cv=none; b=U7bNndPS/Q4rQhrTsGoKQqgDaRvzdPjywfE0XjqkRB3tiAEwEm+Hnvr+UIINlN/hZDWKGJvQ0ZUnA8J2AZoyPR0d2E2Z2HP2kq2acHu/dXzIYGafczGZ6juVsvPPOG8OKOFEP/yOYDs21wOR0Hl9nCw4+TJ28TDYz4Hv0aLa6pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758000385; c=relaxed/simple;
	bh=wqndXbp3SUHrBzpKE4WmX+rr8aXrJnK46Im5JwNsmWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qxeByyYJQbJBrzN7sMwzyvrTF77HrXl5797XHHk2Oi0Kxb7MT5NKiAqJZxbsBXFRsKEJwU+Sk5rm2pxmnAyfIDWchP73s4zVcS3Qsd+hqJoK8TBESz+0DXf2q0P2q/SOXQd6neVbGo3nvqjZqwiDOTOF3vU2bI7mjfaBjM9t17s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O87uVNN1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O87uVNN1"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G3cZwZ018083;
	Tue, 16 Sep 2025 05:26:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zyl7tRe+s991A4Pnt
	ukE2dxTP3R/C1FldoMCxxM63NE=; b=O87uVNN15n0mm9RyG187rptr+G0UKS7BH
	upejcJlYzaJKBZVl3nx3jxPzkFqfVr0xVnc4MnaklWUcTij2RBa7qta1Zz6euDxP
	KprkKcgk7ICOF/d2QglSVkvZW7k0VzAP8W6Si7opvoDxKaEpXHfm2EybsUsasO8z
	QGeDFpQpVC/AP91+5TGZ74gDRa13nPMs1V0zMVCekfmdmhXbSIjjYoQihbvKckkm
	CC1fzBTHfHX5/+gut0zXgA05jLCo62Ck//wQI2+bg5FL3UFpzfj8R61qFjVoLBki
	6ZRATlubghuyqYa+bXyxGhHYq6erjI7yrQTvucbr1uPorExEP6qwQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496g5355nn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 05:26:16 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58G5MIBV010633;
	Tue, 16 Sep 2025 05:26:15 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496g5355nj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 05:26:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58G2NsrO022300;
	Tue, 16 Sep 2025 05:26:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kxpj831-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 05:26:14 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58G5QBr130998790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 05:26:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E73D220040;
	Tue, 16 Sep 2025 05:26:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 722CF20043;
	Tue, 16 Sep 2025 05:26:03 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.245.152])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Sep 2025 05:26:03 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, aboorvad@linux.ibm.com,
        sshegde@linux.ibm.com, atrajeev@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, Aditya.Bodkhe1@ibm.com,
        venkat88@linux.ibm.com, Tejas.Manhas1@ibm.com
Subject: [PATCH V3 3/6] tools/perf: Add event name as vpa-dtl of PERF_TYPE_SYNTH type to present DTL samples
Date: Tue, 16 Sep 2025 10:55:33 +0530
Message-Id: <20250916052536.93911-4-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250916052536.93911-1-atrajeev@linux.ibm.com>
References: <20250916052536.93911-1-atrajeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gERVpMp0vLUCu1U6ILm9sb6AyNDY5Xxx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NiBTYWx0ZWRfX1qscCwdlkY5D
 hWHrVg+Tg0oRfzsv8DrAgta6BChqB4hlOh8C3XqmqBQ7qTNyZNSY/2YI7kzY2/2hHkMYfUDbO6b
 UAjm7pHp9S7+1ZYpixGuGgco1yCxcmFLXdyfFPNjsVs6xXBcOzDQeNeW/hxGGJDOuzfMtk7pcBC
 wIJaw4rbuSWOBnr7etJ3n0uL+az3m99Oaro5VLygKWmVZdgb49J9vZHWgpzknOaZt02BSFL1oJ4
 G5P5OdfmywFVpII5saiwSzdcVGEGkStuTYuR9j/6biMURFszuRUd4/QFzu7lOdyop6FX6woxrIt
 w60n4bmMfuUIOXa8iFxVtmwWv2GscxVAfgQFjyg7ApKG81c0MwnR4dfBk9wCNWiysUOd97ts/MM
 St1IwB7S
X-Proofpoint-ORIG-GUID: Dr6qLdpjP_eTOahmIYyGlvHr_9j1V7_9
X-Authority-Analysis: v=2.4 cv=UJ7dHDfy c=1 sm=1 tr=0 ts=68c8f4f8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=dYXwU9sF1M9M5Z0H0q0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_01,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150086

Dispatch Trace Log details are captured as-is in PERF_RECORD_AUXTRACE
records. To present dtl entries as samples, create an event with name as
"vpa-dtl" and type PERF_TYPE_SYNTH. Add perf_synth_id,
"PERF_SYNTH_POWERPC_VPA_DTL" as config value for the event. Create a
sample id to be a fixed offset from evsel id.
To present the relevant fields from the "struct dtl_entry",
prepare the entries as events of type PERF_TYPE_SYNTH. By
defining as PERF_TYPE_SYNTH type, samples can be printed as part of
perf_sample__fprintf_synth in builtin-script.c

From powerpc_vpadtl_process_auxtrace_info(), invoke
auxtrace_queues__process_index() function which will queue the
auxtrace buffers by invoke auxtrace_queues__add_event().

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changelog
v3:
Added Tested-by from Venkat

 tools/perf/util/event.h          |  1 +
 tools/perf/util/powerpc-vpadtl.c | 76 ++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 7ba208ae86fd..7e0e58979e9c 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -117,6 +117,7 @@ enum perf_synth_id {
 	PERF_SYNTH_INTEL_PSB,
 	PERF_SYNTH_INTEL_EVT,
 	PERF_SYNTH_INTEL_IFLAG_CHG,
+	PERF_SYNTH_POWERPC_VPA_DTL,
 };
 
 /*
diff --git a/tools/perf/util/powerpc-vpadtl.c b/tools/perf/util/powerpc-vpadtl.c
index 9aff05470b13..c92a400f669f 100644
--- a/tools/perf/util/powerpc-vpadtl.c
+++ b/tools/perf/util/powerpc-vpadtl.c
@@ -3,6 +3,7 @@
  * VPA DTL PMU support
  */
 
+#include <linux/string.h>
 #include <inttypes.h>
 #include "color.h"
 #include "evlist.h"
@@ -24,6 +25,7 @@ struct powerpc_vpadtl {
 	struct perf_session		*session;
 	struct machine			*machine;
 	u32				pmu_type;
+	u64				sample_id;
 };
 
 struct boottb_freq {
@@ -215,6 +217,65 @@ static void powerpc_vpadtl_print_info(__u64 *arr)
 	fprintf(stdout, powerpc_vpadtl_info_fmts[POWERPC_VPADTL_TYPE], arr[POWERPC_VPADTL_TYPE]);
 }
 
+static void set_event_name(struct evlist *evlist, u64 id,
+		const char *name)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->core.id && evsel->core.id[0] == id) {
+			if (evsel->name)
+				zfree(&evsel->name);
+			evsel->name = strdup(name);
+			break;
+		}
+	}
+}
+
+static int
+powerpc_vpadtl_synth_events(struct powerpc_vpadtl *vpa, struct perf_session *session)
+{
+	struct evlist *evlist = session->evlist;
+	struct evsel *evsel;
+	struct perf_event_attr attr;
+	bool found = false;
+	u64 id;
+	int err;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (strstarts(evsel->name, "vpa_dtl")) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		pr_debug("No selected events with VPA trace data\n");
+		return 0;
+	}
+
+	memset(&attr, 0, sizeof(struct perf_event_attr));
+	attr.size = sizeof(struct perf_event_attr);
+	attr.sample_type = evsel->core.attr.sample_type;
+	attr.sample_id_all = evsel->core.attr.sample_id_all;
+	attr.type = PERF_TYPE_SYNTH;
+	attr.config = PERF_SYNTH_POWERPC_VPA_DTL;
+
+	/* create new id val to be a fixed offset from evsel id */
+	id = evsel->core.id[0] + 1000000000;
+	if (!id)
+		id = 1;
+
+	err = perf_session__deliver_synth_attr_event(session, &attr, id);
+	if (err)
+		return err;
+
+	vpa->sample_id = id;
+	set_event_name(evlist, id, "vpa-dtl");
+
+	return 0;
+}
+
 /*
  * Process the PERF_RECORD_AUXTRACE_INFO records and setup
  * the infrastructure to process auxtrace events. PERF_RECORD_AUXTRACE_INFO
@@ -256,8 +317,23 @@ int powerpc_vpadtl_process_auxtrace_info(union perf_event *event,
 
 	powerpc_vpadtl_print_info(&auxtrace_info->priv[0]);
 
+	if (dump_trace)
+		return 0;
+
+	err = powerpc_vpadtl_synth_events(vpa, session);
+	if (err)
+		goto err_free_queues;
+
+	err = auxtrace_queues__process_index(&vpa->queues, session);
+	if (err)
+		goto err_free_queues;
+
 	return 0;
 
+err_free_queues:
+	auxtrace_queues__free(&vpa->queues);
+	session->auxtrace = NULL;
+
 err_free:
 	free(vpa);
 	return err;
-- 
2.47.1

