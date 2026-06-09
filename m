Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35434183DB
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781012637; cv=none; b=Qr881lx01n+3aBBDSCCirPcSupbDZnW8WAbb8mE6Xd3zVIkgvgzNlu5qMRgPk7JmyTZ2743ceU0i4i01ubTHM5zA/C9YaMlfxcvd54Ag7P67l3M9WoptTUgn97lgpcV5aAA86imlV90TUFqVsf+gLY79T/E2pmi/KGqhY8ZmzC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781012637; c=relaxed/simple;
	bh=HboCNlyE5x6cGHoCrP0gW07niEyyISjnZD3c95NnpGE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uK0w/7Y6bCkwBfECRt1tCc9gIGsg6Nsy4DD48EnsdzDcWG+fVwPaRVmv8kp5vPBqeGJNQjGLRhwDcaQtVhMAXFFenLyPaGbSELeNUME4a6QztFBBfcNsLZOSGfvdvOQ8ia9aKSo4qPzC2ZSd9TA/hVBN05+oltejKs+QrL6+3sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j1ExnZNo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j1ExnZNo"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659CwZMJ3385579;
	Tue, 9 Jun 2026 13:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=JoDPZ4Y7kekn6bguqz7fviyfqFg+6URkHhFrBjT7V
	so=; b=j1ExnZNoP37phPnBaJ8aLgdZ5FzzHWh2Grsq6MWmoqlZSn/Y7lKBy96bz
	4JRyFV1uMKhJz8H6zXknWBlUZ36tJUccebhd4G11/dOCz7xZj+CFsOscTkbVz1i9
	QHFvKexe3FMuBt9L2M99XHnI3C0Y8Kxl79VPObb54YWJjcVx6sC9YomxxZuH56q2
	B7fUfXv+C93sPutkPkotT5NrgN0Ota1Kt/JF7/L9T0sRIDj64jVQzjCd6xBbKtNK
	ksuE0LCSKDRr3KPNjBS7t8co0ExUg+18AJByB2QnlZ+/qhtJAKib735Z26HyZk42
	EP2/RIozSzlkJzTJ+zmRIsQnHTZOw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ye48da-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 13:43:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659DYa8R015017;
	Tue, 9 Jun 2026 13:43:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03g213n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 13:43:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659DhfMK50266546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 13:43:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC11D2004B;
	Tue,  9 Jun 2026 13:43:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EF0520043;
	Tue,  9 Jun 2026 13:43:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.212.142])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 13:43:37 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, shivani@linux.ibm.com,
        venkat88@linux.ibm.com
Subject: [PATCH V5 1/2] tools/perf: Fix the check for parameterized field in event term
Date: Tue,  9 Jun 2026 19:13:31 +0530
Message-Id: <20260609134332.97954-1-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEyOSBTYWx0ZWRfX97NNlW7nEpiR
 IrRDlV96Lp77aV0UPrJJd84Wzq1E6wV1HYTMEaVUVmR82tufxExBCaaenTCd+n5Z1n0aszRbL4h
 SQAtESdb5sfaRDUKGSt/1M+OesWm2rBZ9D3vT6AjBhjefSyrkuHKImizV/KWTsCW2DVfGva2VQP
 pVPT7MA8XI/E96M2b1PVfURXzmprl1JnbYkY9BDug62Cwvs4xpyIpZuUKqnSA5HFeqD/mi0PLmw
 LIC13yK7SjCvELiWNsR9Kj4Y+qf9SDXyZcV97jiALZdmsRmNxGx4xkADe0v/nb9CcSANqLt7sew
 ZU/DLJxwFpbS0us8E9miIxW6mwIewM3VSeUjslV04Wtbx6g7/RcqlCUmjNj+gBXjS6jGqtj/W32
 7o4kygsf7paoQY7Viy11XpTqVfiHyEdFla2ef19CbCeIJhst+A6UDmsYDMHcSCFOyAn/CTYAk3q
 rv47e6leNm4z5bOZ+xA==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a281892 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=KlCRr-_lrQmZq1rU:21 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=RsB2ROvZ0tSuVhxhQz0A:9
X-Proofpoint-GUID: VZfC5ANZ0sHsZrSeI2foHmT9i19byOb9
X-Proofpoint-ORIG-GUID: pFsPyWJoh4rexrUi1tHm0RV7fZiYvz3K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090129

The format_alias() function in util/pmu.c has a check to
detect whether the event has parameterized field ( =? ).
The string alias->terms contains the event and if the event
has user configurable parameter, there will be presence of
sub string "=?" in the alias->terms.

Snippet of code:

 /* Paramemterized events have the parameters shown. */
       if (strstr(alias->terms, "=?")) {
               /* No parameters. */
               snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, alias->name);

if "strstr" contains the substring, it returns a pointer
and hence enters the above check which is not the expected
check. And hence "perf list" doesn't have the parameterized
fields in the result.

Fix this check to use:

if (!strstr(alias->terms, "=?")) {

With this change, perf list shows the events correctly with
the strings showing parameters.

Before the fix:

 # ./perf list|grep -w PM_PAU_CYC
  hv_24x7/PM_PAU_CYC/                                [Kernel PMU event]

With this fix:

 # ./perf list|grep -w PM_PAU_CYC
  hv_24x7/PM_PAU_CYC,chip=?/                         [Kernel PMU event]

Reviewed-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changelog:
v4 -> v5:
Added Reviewed-by from Ian and Namhyung.
Added Tested-by from Venkat

v3 -> v4:
Updated commit message to show real example
addressing review comment from Namhyung.

v2 -> v3:
Split the strstr correction in a single patch

 tools/perf/util/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 9994709ef12b..e765a7ffb0d6 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2134,7 +2134,7 @@ static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
 						   skip_duplicate_pmus);
 
 	/* Paramemterized events have the parameters shown. */
-	if (strstr(alias->terms, "=?")) {
+	if (!strstr(alias->terms, "=?")) {
 		/* No parameters. */
 		snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, alias->name);
 		return buf;
-- 
2.52.0

