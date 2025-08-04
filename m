Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7555E22D7B6;
	Mon,  4 Aug 2025 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754305587; cv=none; b=vEqrDYgM0y4zON+220kedcITkW8fbSqEzw7AJDYBExt37DUfMIJzVGLsrwnO/rzPrWdu0VrxMJhXF60opfRgnA2Fej8NPUt8SGEUcZ1QpR7rox41UYXTcVdQAPa5SDreSxU8M8/SMB9l3zrFWfl5BCLoojyUKqqvs9BsyxzdBZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754305587; c=relaxed/simple;
	bh=Pz8xR+N5ldGCYRGIH4tTQXkNn2Jm3+petht1bXnD+5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SjBHLJ0SXnbG9cipZjQN+aGnoQj4qxvVSSVDop3VD9jgv2S3khl2mu65F2TvGEi6cfY5xsebEhVcyi44HQV+L1Km+TATH3rFFIrU9oESNEspjHfrtuXnoGYj2x8oi8gRzdmi0xFE7p3bPPnxK6agzlpQmzItigwNQRyNEhSsJdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JpZJwxcd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JpZJwxcd"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574ADBZM001867;
	Mon, 4 Aug 2025 11:06:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=6yN5wtYh9CT6X/+gT0rgrN6ed/A2Ur45glLbTmga6
	+M=; b=JpZJwxcdX1ovWCU9RCSoLqPQGIef3yiW8dcMzbdeH/qb6lnGHlR2EMJPO
	AugTEi+/tu7bfv8TeWR7tGKnuviBlQsbCcAr/cINoL9mJvu55v/sYJHyvA/j519i
	m397H/OWeC+46H1AyEIdc00yKHJLq23Ju0l2GrZM5ddoITl6tVa60l02RZqGMz5R
	1Zwodx5QYFRiDEK+DbruLVo8551N8U3goLXIj0zGytER4w6On8GtSztD28QwuynH
	f6rd9p/httCGfP7CpQ9Bfe687RP0kWtMxXFQbzwik9hBYevNVKtb3G4tfqkp2Wxn
	X8ILc4IVYhDBez94r24ymGx+DcxWQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48993p8nuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 11:06:12 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 574B6CMX013973;
	Mon, 4 Aug 2025 11:06:12 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48993p8nuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 11:06:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 574Ab09x001973;
	Mon, 4 Aug 2025 11:06:11 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 489y7knauj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 11:06:11 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 574B69BK40174072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Aug 2025 11:06:09 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AEF862004B;
	Mon,  4 Aug 2025 11:06:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AD0720043;
	Mon,  4 Aug 2025 11:06:07 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.in.ibm.com (unknown [9.204.207.58])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Aug 2025 11:06:07 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf auxtrace: Avoid redundant NULL check in auxtrace_mmap_params__set_idx()
Date: Mon,  4 Aug 2025 16:36:01 +0530
Message-ID: <20250804110602.23422-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BpsArRSNdP2bg3iG7a35nNOohft_SuGc
X-Authority-Analysis: v=2.4 cv=LOFmQIW9 c=1 sm=1 tr=0 ts=68909424 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=iAiL9whnm18U7maMRcMA:9
X-Proofpoint-GUID: yehqQ7GiD_8sHEwoBMN-B2MxSrOYRS5U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA1OSBTYWx0ZWRfXwy2lpHPRcJyx
 E+fKDdWiYwlk+L7eI7KwwXXeHK50U5TdrqChvdvTnBKFARxNz8Y8oGHST6HKXvOOvjPh4elBABR
 70SqJZK6rD+5R9ULpC0gJFYhsdREEHwzOpK9JRvG23BRnA5paoNOTMEZmAVrQEQcmRdEuReLgob
 89Bz+r6bXreFWRUy4WmDw+QfjlbWDnabDMObqflwbdr4sXFs0HximaDm13HcgS84C7+IhOSdTSA
 39J093FGXSWw4gKSYbv1HcU2RiBZmkbFa9YZPVqZhTWsJnzW/i1Hfm73KfjhOjkLYLgf4ed8oHu
 s8WCsvC4oVT2yR9IQ/bD9uPRMoSe3l6AlxeRMzsIYrpo1E4GnRI9hQNCcd5am1x9H3JEOzuGwy1
 KFQqHVXSKh3F916IJ9GhrGdeNoelNAII4NtgPZEE1NJGfIGmwhnA6Y2SAnhzML12XyozYgIJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040059

Since commit eead8a011477 ("libperf threadmap: Don't segv for index 0 for the
NULL 'struct perf_thread_map' pointer"), perf_thread_map__pid() can
check for a NULL map and return -1 if idx is 0. Cleanup
auxtrace_mmap_params__set_idx() and remove the redundant NULL check.

No functional change intended.

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 tools/perf/util/auxtrace.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index ebd32f1b8f12..5e437133c753 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -185,10 +185,7 @@ void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
 
 	if (per_cpu) {
 		mp->cpu = perf_cpu_map__cpu(evlist->core.all_cpus, idx);
-		if (evlist->core.threads)
-			mp->tid = perf_thread_map__pid(evlist->core.threads, 0);
-		else
-			mp->tid = -1;
+		mp->tid = perf_thread_map__pid(evlist->core.threads, 0);
 	} else {
 		mp->cpu.cpu = -1;
 		mp->tid = perf_thread_map__pid(evlist->core.threads, idx);
-- 
2.49.0

