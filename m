Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF48184113
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407823; cv=none; b=HinEUGnAUXCsx/timAmjs63gmI2Y9nqHutAd06n2sQHP80Uw1fBYPdMD33M5CSDQhN5bAJvC+WA6cTElvVBhKRhgo0c7rKtLNoPfUSFt91Pv1m01i9VCBXSFdKKWtRcjZmZ3Jbd4CXs7PTrhUxHmfEL/KVZ/UiKzANw9aVEysNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407823; c=relaxed/simple;
	bh=adfbl8UDAikwOE+p5TStLvnA4plUJY6Gs+yvh2SnLPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBVV6UeEVrxi+IGPtOcyTnS5Diix7qUp5POh6klU75+ZcMGC0eZucBVqkWrezcMDR1g1sWMxS5LoPg91psgHGQ+W0c0NuumjU3Rs7I+9LW3gBdEtmKU5xtLgXdTZg5wUCckyZOCWmFGiFIoYvJG0A+4prkhEY5M5BfQ0yV31L4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nGY2K94+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nGY2K94+"
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QCvwal026413;
	Wed, 26 Jun 2024 13:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=YElWjDc6z9SNV
	QREOqQypTj9lluYGfauFWVNFI4eRM8=; b=nGY2K94+8V/4P7hdhzyQrHGtWiUZ0
	iXRQR47oHvhEXXYmeNALFp8MWL2iGZ8F4a93irOyVXyKN9eZdeBYlyyXBgT53z2d
	4jvrq/bZVOj8x6cqXlQKSPB/kTuk30a/8oIvzZ6eTZA4fnIpUjBOpCjAWw7Lh/8w
	zeGFF58KoNgMdtSS3UpVQnyivj6hL/felF9zL1a3dwfO43371hX+TOkZjybudov/
	6WsB4gdKWQclyiILBG6ft+Doax4owhWqEZM6nfzNtK/Ny7oTAEbcJqObhl3V0/jq
	u9Pd+7hTY0wiAQk1sAvEk6sqRUtZ1T9ueJnVD8mAwkUTs/kUVAkQmbBaQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400jkeg5k7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 13:16:58 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45QDCZO6016377;
	Wed, 26 Jun 2024 13:16:57 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400jkeg5k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 13:16:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45QAU6Nn000388;
	Wed, 26 Jun 2024 13:16:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yxbn3c509-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 13:16:56 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45QDGpWg16908554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 13:16:53 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87EA620043;
	Wed, 26 Jun 2024 13:16:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D87D20040;
	Wed, 26 Jun 2024 13:16:49 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown [9.124.217.114])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Jun 2024 13:16:49 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH v10 4/4] tools/perf/tests: Update probe_vfs_getname.sh script to use perf check feature
Date: Wed, 26 Jun 2024 18:46:38 +0530
Message-ID: <20240626131638.597544-5-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626131638.597544-1-adityag@linux.ibm.com>
References: <20240626131638.597544-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NMvJxGesKYrmzor_qIwnWnpwWxsbZxQU
X-Proofpoint-GUID: TYjBUX-NYpF3BbiWi1OaVmLFxbil3MTM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_07,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406260096

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

