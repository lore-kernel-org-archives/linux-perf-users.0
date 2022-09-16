Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0C9ECAAD8
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Sep 2022 11:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiIPK76 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 16 Sep 2022 06:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbiIPK7P (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 16 Sep 2022 06:59:15 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8028665675
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Sep 2022 03:49:25 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28GAKLeb026737;
        Fri, 16 Sep 2022 10:49:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=JUTVnl4mffl+C2+FYFiMX9wT346L2On9+JQsXLzqudM=;
 b=m1xe9LQMoTEFP1CFQ/eR4fOyqQ9y0bAn1ghTTUVKouuT/v4U7iqpjsKzs32SuNp4zFbA
 RrCI8XUXQBLl43x1X86K22LyvPB5lgjV3OhiLGmWQNzYZqrcs7dfNiD8f4OjPXAMYbRR
 wjFf/RaI533gZpGXEHs4YEP40Ti9/Gxpbv2cGJQLf5XBpRnUNtgUuX/ih/zfnTG1ZKnG
 pczmo135kMwteYuQZ0nb2Qf07j4ZeoNeyUCOsAAOfEuDEYEjgaB7wc0tVnvHevKl/z4H
 pO+ZNSSTAlQdf2Go5uKJq4IobsVTja377vd2X4Bop1nvohuvmJPl/rIuWZF3X8C/1IaD Pw== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jmq9xgu45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 10:49:16 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28GAa5p8017385;
        Fri, 16 Sep 2022 10:49:13 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 3jm9198mwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 10:49:13 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28GAn9ga36635060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 10:49:09 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D06705204E;
        Fri, 16 Sep 2022 10:49:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.62.13])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9787552050;
        Fri, 16 Sep 2022 10:49:07 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, mpe@ellerman.id.au
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: [PATCH V2] tools/perf/tests: Fix perf probe error log check in  skip_if_no_debuginfo
Date:   Fri, 16 Sep 2022 16:19:04 +0530
Message-Id: <20220916104904.99798-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cB6LJb50pwuG3rZJzNb9P29cjtnAnh0o
X-Proofpoint-GUID: cB6LJb50pwuG3rZJzNb9P29cjtnAnh0o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209160074
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The perf probe related tests like probe_vfs_getname.sh which
is in "tools/perf/tests/shell" directory have dependency on
debuginfo information in the kernel. Currently debuginfo
check is handled by skip_if_no_debuginfo function in the
file "lib/probe_vfs_getname.sh". skip_if_no_debuginfo function
looks for this specific error log from perf probe to skip
the testcase:

<<>>
Failed to find the path for the kernel|Debuginfo-analysis is
not supported
<>>

But in some case, like this one in powerpc, while running this
test, observed error logs is:

<<>>
The /lib/modules/<version>/build/vmlinux file has no debug information.
Rebuild with CONFIG_DEBUG_INFO=y, or install an appropriate debuginfo
package.
  Error: Failed to add events.
<<>>

Update the skip_if_no_debuginfo function to include the above
error, to skip the test in these scenarios too.

Reported-by: Disha Goel <disgoel@linux.vnet.ibm.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
changelog:
 v1 -> v2:
 Corrected formatting of spaces in error log.
 With spaces in v1 of the patch, the egrep search was
 considering spaces also.

 tools/perf/tests/shell/lib/probe_vfs_getname.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index 5b17d916c555..b616d42bd19d 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -19,6 +19,6 @@ add_probe_vfs_getname() {
 }
 
 skip_if_no_debuginfo() {
-	add_probe_vfs_getname -v 2>&1 | egrep -q "^(Failed to find the path for the kernel|Debuginfo-analysis is not supported)" && return 2
+	add_probe_vfs_getname -v 2>&1 | egrep -q "^(Failed to find the path for the kernel|Debuginfo-analysis is not supported)|(file has no debug information)" && return 2
 	return 1
 }
-- 
2.31.1

