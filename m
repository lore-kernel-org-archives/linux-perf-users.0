Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OsY3XU/0"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943911A1
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Dec 2023 01:40:20 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B49XJaT017111;
	Mon, 4 Dec 2023 09:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=FHqwRJWaD4UZnuhO5u+ab/WtRYEwI4aq9ZPgtcoFP1U=;
 b=OsY3XU/0BS4T8WT6P5MLjrNZuIpHiVxv+omMB3Py74gDqHYFGGaK6yvPT1cEdTo8MR0m
 +aVrmcnYkPPqgjuelnxvb/PTcxrrvUdExvQovujk9aqTQ7KWbmW9wrjezf0Ee1U66FMu
 4q5pUali2ot8zpX6gX4DRHJI9saF9t7w1HaBlkrij+Vtv9PK6oBEp3oOqNbh7UV9yfhq
 +oPnLcxjQqJk6OGq4DXrS9AgSmVxz5v8hxQHBUyGxxcK7ZJOcnGIV7QAT69N6FAzk0CU
 uV6k8DJkFjudnc/XzcxiQbvaJZQ7dTogw/gGyG+9HzYEtPpO4FEosC18lSGyND92LE69 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3usc8188r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 09:40:17 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B49eGK6011207;
	Mon, 4 Dec 2023 09:40:16 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3usc8188qs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 09:40:16 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B474ZGH008638;
	Mon, 4 Dec 2023 09:40:16 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3urh4k6wqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 09:40:15 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B49eDOb26608328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Dec 2023 09:40:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EAC02004D;
	Mon,  4 Dec 2023 09:40:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0847F20043;
	Mon,  4 Dec 2023 09:40:11 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown [9.171.12.32])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Dec 2023 09:40:10 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH v8 4/4] tools/perf/tests: Update probe_vfs_getname.sh script to use perf check --feature
Date: Mon,  4 Dec 2023 15:09:54 +0530
Message-ID: <20231204093954.304030-5-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204093954.304030-1-adityag@linux.ibm.com>
References: <20231204093954.304030-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SnWVIWhz-R5tftwSjtsBkzb5SvQUsTDE
X-Proofpoint-ORIG-GUID: f95kWnJyg-msKI4TjWUZUeDYqjooboJt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_06,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040072

From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

In probe_vfs_getname.sh, current we use "perf record --dry-run"
to check for libtraceevent and skip the test if perf is not
build with libtraceevent. Change the check to use "perf check --feature"
option

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 tools/perf/tests/shell/lib/probe_vfs_getname.sh           | 4 ++--
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh     | 5 ++++-
 tools/perf/tests/shell/record+script_probe_vfs_getname.sh | 5 ++++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index bf4c1fb71c4b..368a55c02134 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -27,7 +27,7 @@ skip_if_no_debuginfo() {
 # check if perf is compiled with libtraceevent support
 skip_no_probe_record_support() {
 	if [ $had_vfs_getname -eq 1 ] ; then
-		perf record --dry-run -e $1 2>&1 | grep "libtraceevent is necessary for tracepoint support" && return 2
-		return 1
+		perf check -q --feature libtraceevent && return 1
+		return 2
 	fi
 }
diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index eebeea6bdc76..758da2a23e26 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -60,7 +60,10 @@ trace_libc_inet_pton_backtrace() {
 
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
2.42.0

