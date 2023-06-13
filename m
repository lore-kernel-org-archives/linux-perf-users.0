Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485DAEB64D0
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jun 2023 17:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbjFMRIo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jun 2023 13:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjFMRIn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jun 2023 13:08:43 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE351709
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 10:08:42 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DGkIl1005379;
        Tue, 13 Jun 2023 17:08:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=KQBibb5/m/WzC2CTUb6pXe8vTeDz6Ee5gw/Z08qObbA=;
 b=l3nHUT0BFjUrxkMhOZeFalPlZLtpq2DqXyrX3i9j8APb/B+0p5gJPKiRBF9J+Eb4gcVs
 JSMSlz6oNhlk5IEjDJAlTztTMjBlvXM4PngxDClBcOOS1UFUiY5F4y/jkGvJXAkJUtZq
 j3OaSmVo8wexEeeHg/z3xjNS5IFrppijdtSspvOXHyvnl9vw1OakyNYAQB9SAnGuLE5F
 rLp/oqJ9k6o2vHPnVU+MOcf9PYf43qmQHV8FaPojNNQaodTxjaG0t1KyWhJl5sGhVvBI
 QAImDlIvgK4MoGsgAQxcCv4dpkvO648heQ+54WfHzzmC6YDWysyFOwoq20FNO1Ya704o Tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r6v0hs1r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 17:08:33 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35DH8D9T003281;
        Tue, 13 Jun 2023 17:08:32 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r6v0hs11d-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 17:08:32 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35D3NfhR015648;
        Tue, 13 Jun 2023 16:42:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3r4gt529sp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 16:42:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35DGgHhl20382248
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 16:42:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE4B920043;
        Tue, 13 Jun 2023 16:42:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEF9F20040;
        Tue, 13 Jun 2023 16:42:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.111.115])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 13 Jun 2023 16:42:14 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        namhyung@kernel.org, ravi.bangoria@amd.com, john.g.garry@oracle.com
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
        Spoorthy S <spoorts2@in.ibm.com>
Subject: [PATCH 03/17] shellcheck : fixing signal names and adding double quotes for expression in test_arm_callgraph_fp
Date:   Tue, 13 Jun 2023 22:11:31 +0530
Message-Id: <20230613164145.50488-4-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230613164145.50488-1-atrajeev@linux.vnet.ibm.com>
References: <20230613164145.50488-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nPD-czKpY93c3jeTfA2LVmovNqVgdXAw
X-Proofpoint-ORIG-GUID: Iy4maDUobNUUpUa4RETcpK48q0Jgsd5i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_19,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130151
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Spoorthy S <spoorts2@in.ibm.com>

Running shellcheck -S on test_arm_calligraph_fp throws warnings SC2086 and SC3049,

      $shellcheck -S warning tests/shell/test_arm_callgraph_fp.sh
         rm -f $PERF_DATA
            : Double quote to prevent globbing and word splitting.
         trap cleanup_files exit term int
                     : In POSIX sh, using lower/mixed case for signal names is undefined.

After fixing the warnings,

      $shellcheck tests/shell/test_arm_callgraph_fp.sh
      $ echo $?
      0

To address the POSIX shell warnings added changes to convert Lowercase
signal names to uppercase in the script and double quoted the
command substitutions($fix to "$fix") to solve Globbing warnings.

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Signed-off-by: Spoorthy S<spoorts2@in.ibm.com>
---
 tools/perf/tests/shell/test_arm_callgraph_fp.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/test_arm_callgraph_fp.sh b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
index e61d8deaa0c4..1380e0d12dce 100755
--- a/tools/perf/tests/shell/test_arm_callgraph_fp.sh
+++ b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
@@ -9,13 +9,13 @@ TEST_PROGRAM="perf test -w leafloop"
 
 cleanup_files()
 {
-	rm -f $PERF_DATA
+	rm -f "$PERF_DATA"
 }
 
-trap cleanup_files exit term int
+trap cleanup_files EXIT TERM INT
 
 # Add a 1 second delay to skip samples that are not in the leaf() function
-perf record -o $PERF_DATA --call-graph fp -e cycles//u -D 1000 --user-callchains -- $TEST_PROGRAM 2> /dev/null &
+perf record -o "$PERF_DATA" --call-graph fp -e cycles//u -D 1000 --user-callchains -- "$TEST_PROGRAM" 2> /dev/null &
 PID=$!
 
 echo " + Recording (PID=$PID)..."
-- 
2.39.1

