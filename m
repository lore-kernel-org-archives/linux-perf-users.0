Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE6FEB64D0
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jun 2023 17:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjFMRIb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jun 2023 13:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbjFMRI3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jun 2023 13:08:29 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C8D1718
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 10:08:28 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DGv3Ut007231;
        Tue, 13 Jun 2023 17:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=JafNy6u3FxEyeMg2WQ67R6a+5xAjyb4bgh8VNDKfMno=;
 b=X7qEGwSTw6AKGKggw2Sp4UQIJrgHHbHJEnodOa38X0n7KZDZNAqZBC/IlQ/5mwPxJwnz
 5OW9e3b853x4/udYemXk9Z4q/RTKEeJ0QfvxFsbvJZys/IhBjweu0KxAHCKPy0xqeSnj
 qPK6tsCsmSp23gdwEd9+Eej/T6m8+E4CIFZBTvGuz7ylzwsYOv2+I9zYdd0mi6SbeYC0
 Z0UyhtZWTNw/GdC1jnqRoyxhh6qzTHwn5T80nq/dYWpUAq5/8XV65jzERwo/aAqERv4U
 QJHlgF4mQDFH37GZGc/R0GjtiuSXX/bHa5Z3bXwSSAQKvVxQiwl+X+xt1ZygLWFz+fhU HQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r6v0hs1c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 17:08:14 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35DH8D9P003281;
        Tue, 13 Jun 2023 17:08:13 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r6v0hs11d-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 17:08:12 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35CNoI8u009955;
        Tue, 13 Jun 2023 16:42:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3r4gt529t5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 16:42:32 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35DGgTmW54526428
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 16:42:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67C2920040;
        Tue, 13 Jun 2023 16:42:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4D7C20043;
        Tue, 13 Jun 2023 16:42:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.111.115])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 13 Jun 2023 16:42:25 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        namhyung@kernel.org, ravi.bangoria@amd.com, john.g.garry@oracle.com
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
        Akanksha J N <akanksha@linux.ibm.com>,
        Abhishek Singh Tomar <abhishek@linux.ibm.com>,
        Saket <skb99@linux.vnet.ibm.com>,
        Avnish Chouhan <avnish@linux.vnet.ibm.com>
Subject: [PATCH 06/17] tools/perf/tests: Fix shellcheck warnings for trace+probe_vfs_getname.sh
Date:   Tue, 13 Jun 2023 22:11:34 +0530
Message-Id: <20230613164145.50488-7-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230613164145.50488-1-atrajeev@linux.vnet.ibm.com>
References: <20230613164145.50488-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kEHybml5JyVmpmx8vx9WXGI-r6mMuPGX
X-Proofpoint-ORIG-GUID: Mgxm9Mmw1QOibESs-9YtmFHEK1j0hZFA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_19,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=988 phishscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130151
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Akanksha J N <akanksha@linux.ibm.com>

Fix the shellcheck warnings on powerpc and x86 for testcase
trace+probe_vfs_getname.sh. Add quotes to prevent word splitting
which are caused by unquoted command expansions.

Before fix:

$ shellcheck -S warning trace+probe_vfs_getname.sh

	In trace+probe_vfs_getname.sh line 13:
	. $(dirname $0)/lib/probe.sh
	  ^-----------^ SC2046 (warning): Quote this to prevent word splitting.

	In trace+probe_vfs_getname.sh line 18:
	. $(dirname $0)/lib/probe_vfs_getname.sh
	  ^-----------^ SC2046 (warning): Quote this to prevent word splitting.

	In trace+probe_vfs_getname.sh line 21:
		evts=$(echo $(perf list syscalls:sys_enter_open* 2>/dev/null | grep -E 'open(at)? ' | sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/') | sed 's/ /,/')
		            ^-- SC2046 (warning): Quote this to prevent word splitting.

	100: Check open filename arg using perf trace + vfs_getname          : Ok

After the fix:

$ shellcheck -S warning trace+probe_vfs_getname.sh

	100: Check open filename arg using perf trace + vfs_getname          : Ok

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Signed-off-by: Akanksha J N <akanksha@linux.ibm.com>
Signed-off-by: Abhishek Singh Tomar <abhishek@linux.ibm.com>
Signed-off-by: Saket <skb99@linux.vnet.ibm.com>
Signed-off-by: Avnish Chouhan <avnish@linux.vnet.ibm.com>
---
 tools/perf/tests/shell/trace+probe_vfs_getname.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 0a4bac3dd77e..935eac7efa47 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -10,15 +10,15 @@
 # SPDX-License-Identifier: GPL-2.0
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
 
-. $(dirname $0)/lib/probe.sh
+. "$(dirname $0)"/lib/probe.sh
 
 skip_if_no_perf_probe || exit 2
 skip_if_no_perf_trace || exit 2
 
-. $(dirname $0)/lib/probe_vfs_getname.sh
+. "$(dirname $0)"/lib/probe_vfs_getname.sh
 
 trace_open_vfs_getname() {
-	evts=$(echo $(perf list syscalls:sys_enter_open* 2>/dev/null | grep -E 'open(at)? ' | sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/') | sed 's/ /,/')
+	evts=$(echo "$(perf list syscalls:sys_enter_open* 2>/dev/null | grep -E 'open(at)? ' | sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/')" | sed 's/ /,/')
 	perf trace -e $evts touch $file 2>&1 | \
 	grep -E " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch\/[0-9]+ open(at)?\((dfd: +CWD, +)?filename: +${file}, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
 }
-- 
2.39.1

