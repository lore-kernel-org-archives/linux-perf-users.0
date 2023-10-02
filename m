Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296CE1E50B
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Oct 2023 17:33:15 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71F8B4
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Oct 2023 10:33:13 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 392HK1Vu019686;
	Mon, 2 Oct 2023 17:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=YRCygDs2IUHEaFnKwno3tMzXT5DPA//+v3CLd3Y9P9Q=;
 b=XYkXLurpMPKCwFmSiuSiobL8/0s5+del5fmXjOZlQ2B7Mm5fsq0QHDum70sw6fG/obmE
 C3wIAYS96WX+4wDx6giTaydHI6Grfif5S5Ck66uNwqqUNP4j8NEoMSVRpREUWemvW4c0
 UclaJucJ/oEpyJMv1NYtlwL1ubt0qnulLkPHI+Q4oHXjz2PKcFS1smUK0TtX0PopU3Qs
 WrLpIt7wntNCORplGDNNmL2FQHbrL0k0virfvt47tLVUWrLY1rUUePKnUYf/XegQ9ByQ
 hLLmI4b2IytzILtYcKnOX8p0dhSWMNwJj36dFEUlEVp0MvoD+ySef/J4oRADxz3qBfOH Ww== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tg25nraak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Oct 2023 17:33:11 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 392HWfv0024349;
	Mon, 2 Oct 2023 17:33:11 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tg25nraaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Oct 2023 17:33:11 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 392Gtu7m005869;
	Mon, 2 Oct 2023 17:33:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tex0sbjyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Oct 2023 17:33:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 392HX72Z22217386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Oct 2023 17:33:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AD4320043;
	Mon,  2 Oct 2023 17:33:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EF5720040;
	Mon,  2 Oct 2023 17:33:05 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown [9.171.16.145])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Oct 2023 17:33:05 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH v4 4/4] tools/perf/tests: Update probe_vfs_getname.sh script to use perf check --feature
Date: Mon,  2 Oct 2023 23:02:53 +0530
Message-ID: <20231002173253.70891-5-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002173253.70891-1-adityag@linux.ibm.com>
References: <20231002173253.70891-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _8uHf0zkUG-rju84EcDvGbcoFf7HTBkO
X-Proofpoint-GUID: 1OMtxtpq03m29UAe5uj80ANF9CmHpPbu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_12,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310020136
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

In probe_vfs_getname.sh, current we use "perf record --dry-run"
to check for libtraceevent and skip the test if perf is not
build with libtraceevent. Change the check to use "perf check --feature"
option

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
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
index 89214a6d9951..0c00e94b83ff 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -58,7 +58,10 @@ trace_libc_inet_pton_backtrace() {
 
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
index 7f664f1889d9..c7416d21fc92 100755
--- a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
@@ -19,7 +19,10 @@ record_open_file() {
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
2.41.0

