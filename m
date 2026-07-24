Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDA53B5850
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Jul 2026 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784903543; cv=none; b=n5+K6l2xDhZYNSOe8RM3dwbmlv98SY4bbuSCrToBgtVFsPc7iZi1JHDJPa/Rz24uC9iuzPH71oNk0cNC3ZmpXTm5VHAo0tZiM3ayOZb79oan5Oz+gpE4454XC0IYnavSrCUfjHBwftczJhEgu4iFHjxAd6Ylq2DNqgP1Ql1cV4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784903543; c=relaxed/simple;
	bh=MG84hHu/cySzdvij2CEwQN2dxK3lNQFhUyp8LgRGqsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+o64Y3I91fEwVYWt9rvmboh7uq7wnrzwKZeR67ThYTSMBSsGDvIZ+Wi7ANSaz2tGA9HJFjCUluT7CQ/zFd2G8jYtxPz6k2M+cg4hk2hs9PIWJurv3EquIePHO+MQvkpGZ9utP6TVC9coeFrI9pl+qjyTJ22ST0M5a5EXsvTeaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m8O/v5sR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m8O/v5sR"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODfoog1994013;
	Fri, 24 Jul 2026 14:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dM4KAWeojklXtIOci
	8Klfs7w0f9HMoTCiOR9xEZ49So=; b=m8O/v5sR37bN8dlSojOqxSYvlTk4ddr5n
	M4V59HUlBjlE42ablz4YWse+hoIY0tlHX+yNEYarFaxtkvfBbpmw76nDQa6Tbd8v
	i2GhBLElT9nw2o8Rcacny+p7KrjJK/wa4ydHkfhLNvZ506qY74K0wjst/TkkLNDH
	2y3AZ7Nf9dqt7oOihXFNjamCcV9P0kUOx8Zh9s3XD9IWb1TWpJpIh9MAPByxJX3q
	4kekb+QuP7yFtuTYhqRqKhLYg6Y2xEVu60jF7ZDxLgq+BQuMFTdStLCaz38kFF15
	iHr2fKBj9QxKMPdUNdPXa5q6gPleKLPrz+Jaq6B2c5pP2fVFn9VoA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahmfxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:32:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OEJfhK015044;
	Fri, 24 Jul 2026 14:32:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gs3qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:32:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OEW7Pb50069954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 14:32:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E67820223;
	Fri, 24 Jul 2026 14:13:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E81DF2021D;
	Fri, 24 Jul 2026 14:13:46 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.ibm.com.com (unknown [9.39.22.34])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 14:13:46 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com,
        Tanushree Shah <tshah@linux.ibm.com>
Subject: [PATCH v3 3/5] perf trace-event: Avoid double free in trace_event__cleanup()
Date: Fri, 24 Jul 2026 19:43:14 +0530
Message-ID: <20260724141316.99507-4-tshah@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724141316.99507-1-tshah@linux.ibm.com>
References: <20260724141316.99507-1-tshah@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 1cJUsNqWMfIMpJ6uzESRQvQdyZ0OFyK0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEyOCBTYWx0ZWRfX2iFXgUTKDQq/
 JE0MZP8tK9r6zRMCz21vhhSUwYwAhnJsFuvcvpl6BiLpOnYDom2bMEmzA0Vk9wcntQY9S/l0wkC
 gAF11gNR1C9jFk5xzmQ8FmtzbZ5znIcdeEQJLawW6oOBJuTHZwzg9Npa+aTk/wAq99dA4OQD//Q
 9JU4TDZaR0BbFAu4HjjQcNEmVAI480qsEcP0LbZehf3eYpSn/8XDq8NA6EyU7n/FZvFwcLD7PNE
 tnt1FjJT2avleG4vKuGQ7KkRxGJ5Aa3WhzFpDBHPNSxteYC9aDUcNe9KpqlzgaiIda58wzn/VW0
 Lx2SgXX/eRtMZVQCEQjhd+qykuJarrtmll9of0JBQ9mlS2vN40IW2q6QNBAm3L8/XHKtefhQ4zm
 XFXXznyO1zyj3SD/yiRXTRzSD/+GWINaTheyb7WvXisAmF0cR9EFHFOshfSdc13P66mlOCcZJ9Y
 /g5yWwU1+54j9sKy4Og==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEyOCBTYWx0ZWRfX9otpsENnDePR
 6ho4aTQOF+VsGtad/9OL87TlAskc4Kg6UtcLRa4F2lv9dNCMWejX6frcFJQtg+GRSDUO0KAfMbV
 pH1CfoyV7pixNShS36aTapuKXs2zxvc=
X-Proofpoint-GUID: l3rSfFulRATBXEnDmrFZ1Z1hw1mXAGYi
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a63776c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=5lvcxs32lEib5ufrtJkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240128

trace_event__cleanup() frees t->pevent but never clears the
pointer. It can be called twice on the same trace_event: once
from trace_report()'s error path, and again from
perf_session__delete() during session teardown, resulting in a
double free / use-after-free.

Guard against re-entry by returning early if t->pevent is already
NULL, and clear it after cleanup so a repeat call is a safe no-op.

Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
---
 tools/perf/util/trace-event.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/trace-event.c b/tools/perf/util/trace-event.c
index 6a8c66c64b70..cf40e98d1617 100644
--- a/tools/perf/util/trace-event.c
+++ b/tools/perf/util/trace-event.c
@@ -63,8 +63,12 @@ int trace_event__register_resolver(struct machine *machine,
 
 void trace_event__cleanup(struct trace_event *t)
 {
+	if (!t->pevent)
+		return;
+
 	tep_unload_plugins(t->plugin_list, t->pevent);
 	tep_free(t->pevent);
+	t->pevent = NULL;
 }
 
 /*
-- 
2.47.3

