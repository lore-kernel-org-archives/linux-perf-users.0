Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8619C1E32A2
	for <linux-perf-users@vger.kernel.org>; Sat,  2 May 2026 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777732385; cv=none; b=LLYd4vbWMfN2EtkvxYts95tQxPKS4i6sb46MEEzIK7pw/u0dO6rgVy7NTs0gB1UTOlUD+z+8SMuZHGUH38LSv58HsJPMOz9F+CZOgfZSE6T6ea4wKZprZh7t8jJsD8xSZa2xOA8x/HpNuuPbEnuvnwp/lLdDlcqjQqGssdZS6A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777732385; c=relaxed/simple;
	bh=zz4Wu5pQAj9lL64OFiCplFgEmUwkP4x0PiiwmOvVXbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zxs3gqa3v5hyusTsaR74Rd47hjkvcs7LRxSe/EAQm5VgaoB43tSFLYmooYQp2IQLru8IBNOU5Ds1vpGDN0vjIiRMNZZHvrwBMna4e/EVGBYpoP2SyRkCWuStX+9EZWOqB0uD8tu3VvkkKnZI/Za0uuVeZ2FRwOCIxBUVeG1fbDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sj0RxkX5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sj0RxkX5"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64247b4U1939539;
	Sat, 2 May 2026 14:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eqJA8MRmkd2Q9TvN4
	XIxdpFWNzKxVhQNWHzHl9wQxxM=; b=sj0RxkX5lP/vMYclN0Q3AFzRR3hX09nSe
	tHniGXyZC0FhwL9MvsQ45IH/ZSGFB86h4XfJR+OTdLpdpkPj/vAPKCebwHeyYRiK
	UsETPCm5rX05glhchIQlZXiDDU2gWecU2RS7jAyrvYjeMA2dcSIZ36DAcmWMnTPV
	1IRz48AqZE72lGh+znA8wRaAakvtB69leWV204D/RP8QSBbjGpu2TCQhrkbLXYgP
	C4W73eoSpjZUbvOqyw0diomXPUmE1hp1JuzgaaxXLizReYV+HfD2F0H+fMe9aRZZ
	Kh9sTbZeh31qn3W22w7ml7JfGPgsbSs06oLqxSaaD1RYcTtEjSnwQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y116us-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 May 2026 14:32:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 642EOm0V015317;
	Sat, 2 May 2026 14:32:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dw9jdhd7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 May 2026 14:32:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 642EWo7q29033004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 2 May 2026 14:32:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB1BF20043;
	Sat,  2 May 2026 14:32:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A490420040;
	Sat,  2 May 2026 14:32:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.223.37])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  2 May 2026 14:32:45 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, shivani@linux.ibm.com
Subject: [PATCH V4 2/2] tools/perf: Add kernel-doc comment to auxtrace_record__init() function
Date: Sat,  2 May 2026 20:02:37 +0530
Message-Id: <20260502143237.23456-2-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260502143237.23456-1-atrajeev@linux.ibm.com>
References: <20260502143237.23456-1-atrajeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: MxW92nbsoroDrGprQccOKyKqxuzsGpV7
X-Proofpoint-GUID: KBfdaCVg5GSQbs2a1WcrKt-jkNjBG0TQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAyMDE0MSBTYWx0ZWRfXz8gZmUta0j1i
 IyrIw+Vr4UVii8l2rL3jtre9HuQilEgIx+kTRL5WS9ayxXX3/7VkQLQ/W6znry3ZVfQWcjHrjug
 GsvB3qg46TNRrEA7nASU/+5hlwcF1+uk3guVDbzD+Xjcqc31qM/jIXNTfUh5FH3c6UEktPpGXLE
 G3Gz1vTyqxMBgRqg9Vid2XAKVfNiRlupz3uSf0DeXVhLhJYCOxNl6w32wi10Q9YBlfNJ+97tv1X
 dLWBzoyQPmFlojw8Fuq82rKMnHQPsAPlz3x/y7FMGuiA0I6/fRye1lBugJ6UdSJzxcgWPLBG+fS
 szz0PyCiZj39Sw838wA7CCBJHdhy/Y/8emr0NkxLv3eElRRNTvVyOO/hQ9r/gjwR1NxJUkRw0BC
 HolHuntdD9ljxp72hkR0W2onN85iXSy3Ge+IuToRL3X3ZUxF8uxTImnS+rzdb/8GPkRZMvBn6yo
 0eAprYvn2qHajDfRLiw==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69f60b18 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=V_ROcSP5cVqbivJN_SYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-02_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605020141

Add documentation comment describing the parameters
and return code for auxtrace_record__init() in util/auxtrace.c

Using "struct evlist *evlist __maybe_unused", gives below
warning with "scripts/kernel-doc".

 # ./scripts/kernel-doc -none tools/perf/util/auxtrace.c
 Warning: tools/perf/util/auxtrace.c:912 function parameter '__maybe_unused' not described in 'auxtrace_record__init'
 Warning: tools/perf/util/auxtrace.c:912 function parameter '__maybe_unused' not described in 'auxtrace_record__init'

Updated  parameter as "struct evlist __maybe_unused *evlist"
With the change, there is no erros/warnings with kernel-doc

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changelog:
v3 -> v4:
Addressed review comment from Sashiko:
Update return value expectation for fail as
non zero return err code.

v2 -> v3:
Addressed review comment from Sashiko:
Update return value expectation for success and fail
correctly.

 tools/perf/util/auxtrace.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index a224687ffbc1..9e11cf4299b8 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -896,8 +896,23 @@ int auxtrace_parse_aux_action(struct evlist *evlist)
 	return 0;
 }
 
+/**
+ * auxtrace_record__init - Initialize an AUX area tracing record.
+ * @evlist: The list of events to check for AUX area tracing event.
+ * @err: Pointer to an integer to store return code.
+ *
+ * This function looks through the @evlist to determine which AUX area
+ * tracing hardware is being used and initializes the auxtrace_record
+ * structure.
+ *
+ * Return:
+ * a) A pointer to the struct auxtrace_record on success.
+ * b) NULL with @err = 0 if no AUX area tracing event is found/supported
+ *    (not considered an error).
+ * c) NULL with non-zero @err on actual auxtrace_record__init failure.
+ */
 struct auxtrace_record *__weak
-auxtrace_record__init(struct evlist *evlist __maybe_unused, int *err)
+auxtrace_record__init(struct evlist __maybe_unused *evlist, int *err)
 {
 	*err = 0;
 	return NULL;
-- 
2.47.3

