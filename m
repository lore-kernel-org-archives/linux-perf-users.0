Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9A0C38142
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Jan 2023 11:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjASLbj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 19 Jan 2023 06:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjASLbW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 Jan 2023 06:31:22 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C5A71F14
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Jan 2023 03:31:21 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30J98TbA008453;
        Thu, 19 Jan 2023 11:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=Da/94z1EIIgc1ICoWUQrExxokPkFGwF0S1kT0Edlip8=;
 b=GjXbyr0l6OeT92YEcur3MPcxBWmTJHjHYuB4xMcndVmtikWAw0GmwNlYPquMsXGX8bBG
 1zShvTMzW3uzIuMzyw1CM/SmCtf8+V2IZT4EJRtCC3sepLkxNdd2Ydd8hWd8mh/gbwmx
 blldf8ed71/muY3OgOchysPNQC93GR9/noC8tbVm8AWKnxeQ/uBQkP0fS4L5hMBywVDg
 HF1xKoX7e75TjHEue+6jDIgJA67A6j/YnHIrVKn2+nIAaXyRq7N4GbbiWKbEGINP/aVu
 fOzwoHWKjOiZ36BjXLBV1LbGtN4r0+L6KugpYqopCh/mHyu2xcHG1ZiWq6Qq9r+vRGH7 yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n6jc01ww5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 11:31:04 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30JBHUpx023169;
        Thu, 19 Jan 2023 11:31:03 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n6jc01wvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 11:31:03 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30J1BZLt017966;
        Thu, 19 Jan 2023 11:31:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3n3m16mt7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 11:31:01 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30JBUwMP22479320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 11:30:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECFE82004B;
        Thu, 19 Jan 2023 11:30:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6223420040;
        Thu, 19 Jan 2023 11:30:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.12.84])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 19 Jan 2023 11:30:55 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org
Cc:     ak@linux.intel.com, namhyung@kernel.org, irogers@google.com,
        james.clark@arm.com, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, rnsastry@linux.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.ibm.com
Subject: [PATCH V2] tools/perf/tests: Fix string substitutions in build id test
Date:   Thu, 19 Jan 2023 17:00:54 +0530
Message-Id: <20230119113054.31742-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: I5TBwOIIn1Zp-lARdvBBRs7AvyxFz6yf
X-Proofpoint-GUID: f9yN66mW9o1UxOspbNH7lwbw4eEIKvlJ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_09,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190087
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The perf test named “build id cache operations” skips with below
error on some distros:

<<>>
 78: build id cache operations                                       :
test child forked, pid 111101
WARNING: wine not found. PE binaries will not be run.
test binaries: /tmp/perf.ex.SHA1.PKz /tmp/perf.ex.MD5.Gt3 ./tests/shell/../pe-file.exe
DEBUGINFOD_URLS=
Adding 4abd406f041feb4f10ecde3fc30fd0639e1a91cb /tmp/perf.ex.SHA1.PKz: Ok
build id: 4abd406f041feb4f10ecde3fc30fd0639e1a91cb
./tests/shell/buildid.sh: 69: ./tests/shell/buildid.sh: Bad substitution
test child finished with -2
build id cache operations: Skip
<<>>

The test script "tests/shell/buildid.sh" uses some of the
string substitution ways which are supported in bash, but not in
"sh" or other shells. Above error on line number 69 that reports
"Bad substitution" is:

<<>>
link=${build_id_dir}/.build-id/${id:0:2}/${id:2}
<<>>

Here the way of getting first two characters from id ie,
${id:0:2} and similarly expressions like ${id:2} is not
recognised in "sh". So the line errors and instead of
hitting failure, the test gets skipped as shown in logs.
So the syntax issue causes test not to be executed in
such cases. Similarly usage : "${@: -1}" [ to pick last
argument passed to a function] in “test_record” doesn’t
work in all distros.

Fix this by using alternative way with "cut" command
to pick "n" characters from the string. Also fix the usage
of “${@: -1}” to work in all cases.

Another usage in “test_record” is:
<<>>
${perf} record --buildid-all -o ${data} $@ &> ${log}
<<>>

This causes the perf record to start in background and
Results in the data file not being created by the time
"check" function is invoked. Below log shows perf record
result getting displayed after the call to "check" function.

<<>>
running: perf record /tmp/perf.ex.SHA1.EAU
build id: 4abd406f041feb4f10ecde3fc30fd0639e1a91cb
link: /tmp/perf.debug.mLT/.build-id/4a/bd406f041feb4f10ecde3fc30fd0639e1a91cb
failed: link /tmp/perf.debug.mLT/.build-id/4a/bd406f041feb4f10ecde3fc30fd0639e1a91cb does not exist
test child finished with -1
build id cache operations: FAILED!
root@machine:~/athira/linux/tools/perf# Couldn't synthesize bpf events.
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.010 MB /tmp/perf.data.bFF ]
<<>>

Fix this by redirecting output instead of using “&” which
starts the command in background.

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Acked-by: Ian Rogers <irogers@google.com>
---
Changelog:
- Added Acked-by from Ian.
- Rebased to tmp.perf/urgent of:
  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git

 tools/perf/tests/shell/buildid.sh | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/shell/buildid.sh b/tools/perf/tests/shell/buildid.sh
index aaf851108ca3..43e43e131be7 100755
--- a/tools/perf/tests/shell/buildid.sh
+++ b/tools/perf/tests/shell/buildid.sh
@@ -66,7 +66,7 @@ check()
 	esac
 	echo "build id: ${id}"
 
-	link=${build_id_dir}/.build-id/${id:0:2}/${id:2}
+	link=${build_id_dir}/.build-id/$(echo ${id}|cut -c 1-2)/$(echo ${id}|cut -c 3-)
 	echo "link: ${link}"
 
 	if [ ! -h $link ]; then
@@ -74,7 +74,7 @@ check()
 		exit 1
 	fi
 
-	file=${build_id_dir}/.build-id/${id:0:2}/`readlink ${link}`/elf
+	file=${build_id_dir}/.build-id/$(echo ${id}|cut -c 1-2)/`readlink ${link}`/elf
 	echo "file: ${file}"
 
 	# Check for file permission of original file
@@ -130,20 +130,22 @@ test_record()
 {
 	data=$(mktemp /tmp/perf.data.XXX)
 	build_id_dir=$(mktemp -d /tmp/perf.debug.XXX)
-	log=$(mktemp /tmp/perf.log.XXX)
+	log_out=$(mktemp /tmp/perf.log.out.XXX)
+	log_err=$(mktemp /tmp/perf.log.err.XXX)
 	perf="perf --buildid-dir ${build_id_dir}"
+	eval last=\${$#}
 
 	echo "running: perf record $@"
-	${perf} record --buildid-all -o ${data} $@ &> ${log}
+	${perf} record --buildid-all -o ${data} $@ 1>${log_out} 2>${log_err}
 	if [ $? -ne 0 ]; then
 		echo "failed: record $@"
-		echo "see log: ${log}"
+		echo "see log: ${log_err}"
 		exit 1
 	fi
 
-	check ${@: -1}
+	check $last
 
-	rm -f ${log}
+	rm -f ${log_out} ${log_err}
 	rm -rf ${build_id_dir}
 	rm -rf ${data}
 }
-- 
2.31.1

