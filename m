Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D37EEB64D8
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jun 2023 08:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjFUIaz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 21 Jun 2023 04:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjFUIay (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Jun 2023 04:30:54 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D5610DA
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jun 2023 01:30:53 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35L88o5h022141;
        Wed, 21 Jun 2023 08:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=S0RcyZPhTCSXm7kAdIj+U3089rhPHnI3SkpI51fKezQ=;
 b=C4XtHwtVYeVozrCUBKONKIuDfHd44Qg9eNNxx49BV9myqVDLlaR6nHuob100FYmg8tpS
 Hs6Rv7E6oRZI+aDW+Wx9bWnN7DhldYFpYZV1HwMzX4HUaall7fJ4OqjN4uLSzRBobbsi
 Nc5ZNj+OWOjRKgcQKzG8XCpIDUfJH46gGD4ufPHT6IlTRU+VqXwx+xf7sZa1Dfpq516R
 hzgHAnKAF2UqykAaumiZK9bpQIHICC93ITZhnf88cJfB1UKc2/+JUHSaXIp0lDB/GQYq
 K1Lt6BNLUL8gDNYPFVwjLmJ/2Xx40rea2MemQ5y5tFGRNxfjuZOdh+/4DgEeofnRU/xO zA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rbvpbsnvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 08:30:43 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35L896Cp024962;
        Wed, 21 Jun 2023 08:30:42 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rbvpbsnuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 08:30:42 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35L4qls7018799;
        Wed, 21 Jun 2023 08:30:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3r94f52mh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 08:30:40 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35L8Ubra40174094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 08:30:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 022F320043;
        Wed, 21 Jun 2023 08:30:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 866F720040;
        Wed, 21 Jun 2023 08:30:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.109.215.188])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 21 Jun 2023 08:30:33 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        namhyung@kernel.org, ravi.bangoria@amd.com, john.g.garry@oracle.com
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: [PATCH 02/22] tools/perf/tests: Fix shellcheck warning for probe_vfs_getname.sh testcase
Date:   Wed, 21 Jun 2023 14:00:01 +0530
Message-Id: <20230621083021.71203-3-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230621083021.71203-1-atrajeev@linux.vnet.ibm.com>
References: <20230621083021.71203-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ORsfUBV4djMrqLPxAAi9Tn8-toHIK_sc
X-Proofpoint-GUID: FRZ2i-mOZsBYkz9pD0yTEmM0t0mPHFVw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_05,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=993 mlxscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306210067
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Kajol Jain <kjain@linux.ibm.com>

Running shellcheck on probe_vfs_getname.sh throws below warning:

In tests/shell/probe_vfs_getname.sh line 7:
. $(dirname $0)/lib/probe.sh
  ^-----------^ SC2046 (warning): Quote this to prevent word splitting.

In tests/shell/probe_vfs_getname.sh line 11:
. $(dirname $0)/lib/probe_vfs_getname.sh
  ^-----------^ SC2046 (warning): Quote this to prevent word splitting.

Fixed the warning by adding quotes to avoid word splitting.

ShellCheck result with patch:
    # shellcheck -S warning probe_vfs_getname.sh
    #

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 tools/perf/tests/shell/probe_vfs_getname.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/probe_vfs_getname.sh b/tools/perf/tests/shell/probe_vfs_getname.sh
index 5d1b63d3f3e1..871243d6d03a 100755
--- a/tools/perf/tests/shell/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/probe_vfs_getname.sh
@@ -4,11 +4,11 @@
 # SPDX-License-Identifier: GPL-2.0
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
 
-. $(dirname $0)/lib/probe.sh
+. "$(dirname $0)"/lib/probe.sh
 
 skip_if_no_perf_probe || exit 2
 
-. $(dirname $0)/lib/probe_vfs_getname.sh
+. "$(dirname $0)"/lib/probe_vfs_getname.sh
 
 add_probe_vfs_getname || skip_if_no_debuginfo
 err=$?
-- 
2.39.1

