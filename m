Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA08C6379F
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Jan 2023 14:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjASO2t (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 19 Jan 2023 09:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjASO2E (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 Jan 2023 09:28:04 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B154181015
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Jan 2023 06:27:45 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JDqNgW009577;
        Thu, 19 Jan 2023 14:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=Dh7UHncm/WttpDpLbRcpzTOfYvM6d/XeR5Eb//MeRuc=;
 b=OgHbAoev1RnDa7boiYE6p+dWPnCw5YySJgLv9WBWD2+5WVD6H8slL3bXW236e5/Tdm59
 jlpoBVOc+dIgHCm/wSjACT3lPS/Ja32jOX0jT8Dp7w7/VdBotozv1ObdmWlgbXZiXshU
 UGhGPKSZgbXAqkJSGcQBrjHGyMa6+r70ukzGMTbbGX0ejVmS+rjyHlSrOyoqBXFDQs25
 kml0VLjQ1Yd+JApbLMyG+D9LoUdbjbhmxzQkA+/cNfQAzKi7PbmvDZ3q7Sa2MYxl2nNL
 8bS5Q6Rn9NI8YTn0k3x8D+3wcaxN6dUEdIBFbjPJis0UUI6xZIjtlUrn3DSXwtqVklOu lQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n7746145p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 14:27:30 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30JEN5Ap002250;
        Thu, 19 Jan 2023 14:27:29 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n7746144s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 14:27:29 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30J63EPp004700;
        Thu, 19 Jan 2023 14:27:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3n3m16psjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 14:27:26 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30JERNhK23658906
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 14:27:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02E2C20040;
        Thu, 19 Jan 2023 14:27:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 850A620043;
        Thu, 19 Jan 2023 14:27:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.12.84])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 19 Jan 2023 14:27:20 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org
Cc:     David.Laight@ACULAB.COM, ak@linux.intel.com, namhyung@kernel.org,
        irogers@google.com, james.clark@arm.com, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, rnsastry@linux.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.ibm.com
Subject: [PATCH V3] tools/perf/tests: Fix string substitutions in build id test
Date:   Thu, 19 Jan 2023 19:57:19 +0530
Message-Id: <20230119142719.32628-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NbiYcL4nhKVOdXibDdGOe_DXe9pZfXd3
X-Proofpoint-ORIG-GUID: -OZa58uxKjTfHBRlFdUz00_m493Kd3fL
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_09,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190113
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

Fix this by using alternative way with shell substitution
to pick required characters from the string. Also fix the
usage of “${@: -1}” to work in all cases.

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
From v2 -> v3
- Addressed review comments from David Laight
  for using shell substitutions.

From v1 -> v2
- Added Acked-by from Ian.
- Rebased to tmp.perf/urgent of:
 git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git

 tools/perf/tests/shell/buildid.sh | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/shell/buildid.sh b/tools/perf/tests/shell/buildid.sh
index aaf851108ca3..0ce22ea0a7f1 100755
--- a/tools/perf/tests/shell/buildid.sh
+++ b/tools/perf/tests/shell/buildid.sh
@@ -66,7 +66,9 @@ check()
 	esac
 	echo "build id: ${id}"
 
-	link=${build_id_dir}/.build-id/${id:0:2}/${id:2}
+	id_file=${id#??}
+	id_dir=${id%$id_file}
+	link=$build_id_dir/.build-id/$id_dir/$id_file
 	echo "link: ${link}"
 
 	if [ ! -h $link ]; then
@@ -74,7 +76,7 @@ check()
 		exit 1
 	fi
 
-	file=${build_id_dir}/.build-id/${id:0:2}/`readlink ${link}`/elf
+	file=${build_id_dir}/.build-id/$id_dir/`readlink ${link}`/elf
 	echo "file: ${file}"
 
 	# Check for file permission of original file
@@ -130,20 +132,22 @@ test_record()
 {
 	data=$(mktemp /tmp/perf.data.XXX)
 	build_id_dir=$(mktemp -d /tmp/perf.debug.XXX)
-	log=$(mktemp /tmp/perf.log.XXX)
+	log_out=$(mktemp /tmp/perf.log.out.XXX)
+	log_err=$(mktemp /tmp/perf.log.err.XXX)
 	perf="perf --buildid-dir ${build_id_dir}"
 
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
+	args="$*"
+	check ${args##* }
 
-	rm -f ${log}
+	rm -f ${log_out} ${log_err}
 	rm -rf ${build_id_dir}
 	rm -rf ${data}
 }
-- 
2.39.0

