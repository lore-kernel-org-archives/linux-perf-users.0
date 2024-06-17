Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD022869A
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Jun 2024 06:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607060; cv=none; b=SGS9x2aFDTYObJLFMhPqvKJK3ycDOPOCSP8Vj2NLWr8d7xJBIENY62EYCEDyAURtf4deIO18PtJo2s57GHbjE2WthQ/ZDb5sQ942CZ/UVogOuXSO5lgtCHymnwqr1mk8KW5vBWTZxC96G2p9mQNoNs61smPaixHvdNDGIGd1pAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607060; c=relaxed/simple;
	bh=5wuR2WRnWyIjcgQ3nsLAl/III7i1/5mFjrYU7UpA+/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2jsjzMlVDBwiWqj7vjjP9r+aexNK3/nPHVe7s72DwBUEuDEQE41zSVGlOJcuzmQnLUj4Ib8Kf1HDqoEivmFfDPB6BRB4s8oGeQkZ798eYebvvBFdBfRaMww2N3ZBKLsSEnzG+np1lkelIckaW0Vsm2YzhtUrhOuPDVKeZhS+Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xus9BZIN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xus9BZIN"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45H5unJo010012;
	Mon, 17 Jun 2024 06:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=yQIKRKQDdAvJC
	7/m9m8u6qSklaOK7vbOtmHwR/NT8i4=; b=Xus9BZINxuV+VZvYgIXy+dWfv54EJ
	b5QY0vUqcrTp/+OJtAgwQ5nVyEQSWahfcshnxgqdEoHQmqepTXzr/GpUXW52Rh+k
	XbvRZ6kmZnoQPVZAyhJcCb/hTypvgTr48Uj0+qYWcBtAGC8HSkGUUMUQFuC0fDTl
	wZv1MZX9TGC+UGLjH6tnDYRUlUe1jf7s6KZCD5MKC1HGz4BOm1bZYCmirnFjE2/F
	eEp0XLzdAfVA5fs/JDerrPqk+9kkiPT03t3ZpU550giB7WLG59IDwg7DJnevDlEv
	rFYkRQD6jji4RZohRm4G0IU7lQIXzZFlzcdoFtOxEo1LWaR3vJBgiwACQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytf1805g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 06:50:55 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45H6otQx029148;
	Mon, 17 Jun 2024 06:50:55 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytf1805g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 06:50:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45H4OiaB019545;
	Mon, 17 Jun 2024 06:50:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ysnp0qt7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 06:50:53 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45H6ollY15860196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 06:50:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 343E320040;
	Mon, 17 Jun 2024 06:50:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1048D20043;
	Mon, 17 Jun 2024 06:50:45 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown [9.109.199.72])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Jun 2024 06:50:44 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH v9 3/4] perf tests task_analyzer: use perf check for libtraceevent support
Date: Mon, 17 Jun 2024 12:20:35 +0530
Message-ID: <20240617065036.1194041-4-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240617065036.1194041-1-adityag@linux.ibm.com>
References: <20240617065036.1194041-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0_B1YiHbqHMxWqM-v0wdiDUAczeF5SZ9
X-Proofpoint-ORIG-GUID: dhGtkaFyXBebJbYUxvY_M0XhAKggK562
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_05,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 bulkscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170047

Currently we use output of 'perf version --build-options', to check
whether perf was built with libtraceevent support.

Instead, use 'perf check feature libtraceevent' to check for
libtraceevent support.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 tools/perf/tests/shell/test_task_analyzer.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/test_task_analyzer.sh b/tools/perf/tests/shell/test_task_analyzer.sh
index 92d15154ba79..456665ba465e 100755
--- a/tools/perf/tests/shell/test_task_analyzer.sh
+++ b/tools/perf/tests/shell/test_task_analyzer.sh
@@ -52,8 +52,8 @@ find_str_or_fail() {
 
 # check if perf is compiled with libtraceevent support
 skip_no_probe_record_support() {
-	perf version --build-options | grep -q " OFF .* HAVE_LIBTRACEEVENT" && return 2
-	return 0
+	perf check feature -q libtraceevent && return 0
+	return 2
 }
 
 prepare_perf_data() {
-- 
2.45.2

