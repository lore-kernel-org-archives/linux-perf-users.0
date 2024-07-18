Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BEF80024
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 09:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721293229; cv=none; b=f09++Rt26mpQJc5J2b10RL62MhWPVih0nE5NzNNJsuj1UN9hD8Jbc9NMO0o1uLtkWqvl1WJqRmySJ6iSAQqCvmXRFbrmVyi4Us/tkSrHADIM6o5pJ6SC7uMlGu/GpoLtiaCnU4wy3AIO4BazoGktSu1B6A02joH9PsWaw8FWGUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721293229; c=relaxed/simple;
	bh=GDrPNsz0EbvAiipg5DYMKQIXsR/T+OCJff6i5HsOBeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G10RcdeXFr+obZIcYG7qlgMQXLylBsPvI5LXsOceesVw0CK+9sQeULuyTAo8NjphF9WQbnOEe615uILd6KmBEuCMuusy8Nj6VSkxkuhcDjClH4LZBBlikGWawvlzq7Xnp6+vIH7hZFJLlgqB6usD0esnvjxoeaKv79aRCrEpIWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sp9AoGiK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sp9AoGiK"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46I8vDPV031522;
	Thu, 18 Jul 2024 09:00:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=oAmTBn7uPSg3C
	MrdLs/CVEo2vJSjx1h91kWcp3qqBkI=; b=Sp9AoGiK+kLN2BOUegQACHKGz6ROM
	w1QwXnBEl+DeWt2rvefm8xKTzoin2iQWKzOiI9psKJh/BXVbVb/OQicD7445maD2
	2G9iAP9DZUP7/KHrvkH9LHBw/k53pjbKiBIq3dRocAU41FSh+IX4SEO5gEoM8t2t
	pdr5lneYtuUpuFb7e0qcPqFATmnHau3vlHktAyBxAwtVaabu+o0hGpAG3TcOcW/3
	eQGZpRmRQnRF2pVacjEg+fJrYyD5PD05pb/LBLyuuls52d6gtv2M9kK09djf3LoY
	EisWEO5mes88ru9hM6MOBwpYJF49nib7nHo4JJcyK7kJYB/CWGx5BN04Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40expu0616-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 09:00:24 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46I90NKB003674;
	Thu, 18 Jul 2024 09:00:23 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40expu0611-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 09:00:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46I567Q8000502;
	Thu, 18 Jul 2024 09:00:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40dwkk8sf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 09:00:20 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46I90ECs50528706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jul 2024 09:00:16 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00E7520071;
	Thu, 18 Jul 2024 09:00:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7CF32004D;
	Thu, 18 Jul 2024 09:00:11 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown [9.109.199.72])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jul 2024 09:00:11 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH v13 5/7] tools/perf/tests: Update probe_vfs_getname.sh script to use perf check feature
Date: Thu, 18 Jul 2024 14:29:55 +0530
Message-ID: <20240718085957.550858-6-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718085957.550858-1-adityag@linux.ibm.com>
References: <20240718085957.550858-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1deqPThgF-4E9FVn6iWvquejr0iel453
X-Proofpoint-ORIG-GUID: AansfgSXNiXUGpdM2s5miZCLRXDCdpPU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_05,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407180056

From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

In probe_vfs_getname.sh, current we use "perf record --dry-run"
to check for libtraceevent and skip the test if perf is not
build with libtraceevent. Change the check to use "perf check feature"
option

Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Disha Goel <disgoel@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
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

