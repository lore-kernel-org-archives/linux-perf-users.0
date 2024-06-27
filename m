Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A0013C801
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Jun 2024 10:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719482830; cv=none; b=UUEsQGXnBZ6mEtHQHe8wG7eX54340BlVzDORcaVxcvRHtzevuP5tIAobyNR+N/zvBvK3KF13frag2bGNGtVVvse8MhuTagrTqlgqNt8x4Z6fQuvckGPco2De9VbtlA07TxnOfgH1vhyYLHfJbNKb8eB/MowRPPU0updhNk4DuvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719482830; c=relaxed/simple;
	bh=adfbl8UDAikwOE+p5TStLvnA4plUJY6Gs+yvh2SnLPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8Kxh7qKW6AvN7ZwFgPSZixFseRLTiOAclhlbv3+8Avh53KDUKvAEcOX70JhAP50hLhzvwUegU2PVdnzSXiM04gME5SI7xQxLNYS8gaMOdnxwf3a0jxUbpy62opiVgsQh2H6zlvXpuYBbN2sWuSSbT61r9JWMOo5hhO3qNFaTLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rV1V/FdL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rV1V/FdL"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R9QSfq014696;
	Thu, 27 Jun 2024 10:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=YElWjDc6z9SNV
	QREOqQypTj9lluYGfauFWVNFI4eRM8=; b=rV1V/FdL8TD2cXzD+cpzwl/f/D7Pj
	b/6rUW1E9kLR0jovNbrhTVr3CneGKcP3dQkFS0GRWU+s7/Y9oBl7JrLDGduHwHCL
	Uh5be0EsIfrJt7BSgh/KYAeSWyoIIHpxhKsRubWTmwzwAOh/yYndO1d3BR7zDQOm
	FlzlfPerEpJLtfSeuwPgzq4b0YdJ9xSDl0j7kFSVc8tWzQ+wn7UlGnCrppmD4GKw
	u+zV2rKpx5Fjn/4dSD/UG5Tz/hDZZilcwb5TqLE17mgM8mu0Iwd2WpuQaDUgbXKB
	feidYfScwlGWqBf9EGU5+xUjtDGXGFL8gzqoCMMdb5yJOB2+I0HhHuwAw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4013qg8cde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 10:07:06 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45RA76i5026318;
	Thu, 27 Jun 2024 10:07:06 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4013qg8cdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 10:07:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45R7B9Cu008184;
	Thu, 27 Jun 2024 10:07:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yx9b12a8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 10:07:04 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45RA6wmI21824068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 10:07:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E07D72006E;
	Thu, 27 Jun 2024 10:06:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 890202006C;
	Thu, 27 Jun 2024 10:06:56 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown [9.109.199.72])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Jun 2024 10:06:56 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH v11 4/4] tools/perf/tests: Update probe_vfs_getname.sh script to use perf check feature
Date: Thu, 27 Jun 2024 15:36:44 +0530
Message-ID: <20240627100644.772219-5-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627100644.772219-1-adityag@linux.ibm.com>
References: <20240627100644.772219-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SHmtwKbtwk3Lf70ScRGXK1xHHFhxnWIt
X-Proofpoint-ORIG-GUID: DZrmahIyi__Ts-gxQ7p4BpY10TU0vfcQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_06,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270074

From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

In probe_vfs_getname.sh, current we use "perf record --dry-run"
to check for libtraceevent and skip the test if perf is not
build with libtraceevent. Change the check to use "perf check feature"
option

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/tests/shell/lib/probe_vfs_getname.sh           | 4 ++--
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh     | 5 ++++-
 tools/perf/tests/shell/record+script_probe_vfs_getname.sh | 5 ++++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index bf4c1fb71c4b..24cca0fbfe31 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -27,7 +27,7 @@ skip_if_no_debuginfo() {
 # check if perf is compiled with libtraceevent support
 skip_no_probe_record_support() {
 	if [ $had_vfs_getname -eq 1 ] ; then
-		perf record --dry-run -e $1 2>&1 | grep "libtraceevent is necessary for tracepoint support" && return 2
-		return 1
+		perf check feature -q libtraceevent && return 1
+		return 2
 	fi
 }
diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 72c65570db37..f38c8ead0b03 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -63,7 +63,10 @@ trace_libc_inet_pton_backtrace() {
 
 	# Check presence of libtraceevent support to run perf record
 	skip_no_probe_record_support "$event_name/$eventattr/"
-	[ $? -eq 2 ] && return 2
+	if [ $? -eq 2 ]; then
+		echo "WARN: Skipping test trace_libc_inet_pton_backtrace. No libtraceevent support."
+		return 2
+	fi
 
 	perf record -e $event_name/$eventattr/ -o $perf_data ping -6 -c 1 ::1 > /dev/null 2>&1
 	# check if perf data file got created in above step.
diff --git a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
index 5eedbe29bba1..9a61928e3c9a 100755
--- a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
@@ -21,7 +21,10 @@ record_open_file() {
 	echo "Recording open file:"
 	# Check presence of libtraceevent support to run perf record
 	skip_no_probe_record_support "probe:vfs_getname*"
-	[ $? -eq 2 ] && return 2
+	if [ $? -eq 2 ]; then
+		echo "WARN: Skipping test record_open_file. No libtraceevent support"
+		return 2
+	fi
 	perf record -o ${perfdata} -e probe:vfs_getname\* touch $file
 }
 
-- 
2.45.2

