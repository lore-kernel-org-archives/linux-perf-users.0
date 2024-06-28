Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7D574C1B
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 06:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719556991; cv=none; b=QBwqQQYYFsx+jvb55gDDvhpCc3NE4p6u20iVBYurDMQ0WYpYr4veiEmwl4YnEvKhvMrbrnuJi3rEWwnEd7mkOJ/yFutXXKbabcpBbCt6t305LI7nDiyrY7pWpL92u9GveOmEwnIpn7r9RgfVQb7Ya0i8QvVkfH4bowExpfyF448=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719556991; c=relaxed/simple;
	bh=5wuR2WRnWyIjcgQ3nsLAl/III7i1/5mFjrYU7UpA+/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOUPTE5dfeggdmJU+LwKFACnxZ+5NHZp9/ur7ZCh/xgm29ZT6/i5oC5fCEOKCFnFZG/XzgVJpBSFs9DceKJ5Vb3uMOE6claB8Lu7FQd1USxwzbnGJmZATqB6X+OQHBA0o9xUNH1Xs2hOTbJYX21wXuPjiYehtN90D/FX1jEUmPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rrobVIlS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rrobVIlS"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S6Rhqr000821;
	Fri, 28 Jun 2024 06:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=yQIKRKQDdAvJC
	7/m9m8u6qSklaOK7vbOtmHwR/NT8i4=; b=rrobVIlS87ye4lEE78uF6cgRWU+5E
	8hJGm/E/I4Pj81o5lTVBGJQztAVnqUs8ZRlbt3EtGAMjtxRZapLiRHTMXixumLBq
	QjLzRxp2vYdxGd9xIRez0Cmt/ZE6HsINSS/rRVG1wr4QR8gsGHxV+jaC/kvzGyyP
	LTvgERqNCYbpphmTlHe6E5NvvkWn/G+n+ubN+VuaNr8ZWyaMTJSgync0UXmUCV5m
	T07Mm+DzFWzFzFpi7SZRqd8CDxOfsgNYbZffaA7tlAOkH6k3fIInxyoVmPqplCVs
	xvLFkEVAIlRpkRUGK4TK/3XKr/hxHTApv2/fcpNUwCK7GvD8QlozR4zBg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 401qga02xe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 06:43:07 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45S6h7V4025938;
	Fri, 28 Jun 2024 06:43:07 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 401qga02xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 06:43:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45S5ihmW008162;
	Fri, 28 Jun 2024 06:43:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yx9b176n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 06:43:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45S6h0Nj53805394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jun 2024 06:43:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DF8B2004B;
	Fri, 28 Jun 2024 06:43:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7247D20043;
	Fri, 28 Jun 2024 06:42:55 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown [9.195.36.144])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Jun 2024 06:42:55 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH v12 3/4] perf tests task_analyzer: use perf check for libtraceevent support
Date: Fri, 28 Jun 2024 12:12:35 +0530
Message-ID: <20240628064236.1123851-4-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628064236.1123851-1-adityag@linux.ibm.com>
References: <20240628064236.1123851-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6nNzztxxKgjJXHZcmLITW6R8phCC_Llh
X-Proofpoint-GUID: gHJyOfGCINxALuh_hq8nVuKOm4AdVcjG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_02,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406280045

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

