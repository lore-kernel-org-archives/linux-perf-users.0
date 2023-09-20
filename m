Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD100C04FF1
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Sep 2023 19:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjITT3c (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Sep 2023 15:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjITT3T (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Sep 2023 15:29:19 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBC6CC8
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Sep 2023 12:29:00 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KJGmfU015235;
        Wed, 20 Sep 2023 19:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=Ln1O9xCXJfSgbdvWPQ6PmKZ6H1Jl9jEWSq/Kxv55ao8=;
 b=QOwsi8zYzHhRXbaT7okBbiC1xueb12Vqb1KcJ4FwlxdvF/uTHN9MBQFX/Mcn7fNbVKsa
 ciUuA2Drp/k9ZhbhybiIxScpLJj2u99zGKbcaEBSnAU0LUVcEATLP2GyPy2795qJHgD2
 JR4zudviN4RAHhstvXeYeB6rU2OJa6AzRRgbLOzxo+xju1wibNvY43YrrmmJ48fsluxF
 kMzWgDtzjnvpqm9bxhSx1qarSjPidq1VjqgeiijjfWgm7UOYFpsjxG8tIE2UsMO0ohos
 eolqJZU5AN7togxp7VZdLC1dXgR2gzOK+XMut/XUBcJ4Gn88BjdchqzpKRrNR5A0Bcon XA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t84pxc1ph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 19:28:56 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38KJHHnE018616;
        Wed, 20 Sep 2023 19:28:55 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t84pxc1p5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 19:28:55 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38KHKwGj010122;
        Wed, 20 Sep 2023 19:28:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t5rwkge8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 19:28:54 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38KJSpef27722412
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 19:28:51 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1A9E20043;
        Wed, 20 Sep 2023 19:28:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACAD820040;
        Wed, 20 Sep 2023 19:28:49 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown [9.171.61.45])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 20 Sep 2023 19:28:49 +0000 (GMT)
From:   Aditya Gupta <adityag@linux.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH v2 0/4] Introduce perf check subcommand
Date:   Thu, 21 Sep 2023 00:58:43 +0530
Message-ID: <20230920192847.975897-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EUY6XAjOoIbj78hTXQoyHgIgmIIpANfm
X-Proofpoint-GUID: 0GFk_Ygo33uHjxNSkc1KMo0Rk98buUMY
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_09,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1011 adultscore=0 malwarescore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200158
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The Problem
===========

Currently the presence of a feature is checked with a combination of
perf version --build-options and greps, such as:

    perf version --build-options | grep " on .* HAVE_FEATURE"

Proposed solution
=================

As suggested by contributors in:
https://lore.kernel.org/linux-perf-users/ZMPWk5K63tadmDlU@kernel.org/

Introduce a subcommand "perf check --feature", with which
scripts can test for presence of a feature, such as:

    perf check --feature HAVE_LIBTRACEEVENT

    or

    perf check --feature libtraceevent

The usage of "perf version --build-options | grep" has been replaced in two
tests, with "perf check --feature" command

Also, to not duplicate the same feature list at multiple places, a new global
'supported_features' array has been introduced in builtin.h, so both commands
'perf check --feature' and 'perf version --build-options' use the same array

'supported_features' feature is an array of 'struct feature_support', which
also has the name of the feature, macro used to test it's presence, and a
is_builtin member, which will be 0 if feature not built-in, and 1 if built-in

Architectures Tested
====================
* x86_64
* ppc64le

Git tree
========

Git tree with this patch series applied for testing:
https://github.com/adi-g15-ibm/linux/tree/perf-check-feature-v2

Changelog
=========
V2
+ improved the patch series with suggestions from Namhyung
+ fix incorrect return value, added -q option, and moved array definition to
  perf-check.c
V1
+ changed subcommand name to 'perf check --feature'
+ added documentation for perf check
+ support both macro (eg. HAVE_LIBTRACEEVENT), and name (eg. libtraceevent) as
  input to 'perf check --feature'
+ change subject and descriptions of all patch mentioning perf check instead of
  perf build

V0: Previous patch series: https://lore.kernel.org/linux-perf-users/20230825061125.24312-1-adityag@linux.ibm.com/

Aditya Gupta (3):
  perf check: introduce check subcommand
  perf version: update --build-options to use 'supported_features' array
  perf tests task_analyzer: use perf check for libtraceevent support

Athira Rajeev (1):
  tools/perf/tests: Update probe_vfs_getname.sh script to use perf check
    --feature

 tools/perf/Build                              |   1 +
 tools/perf/Documentation/perf-check.txt       |  56 ++++++++
 tools/perf/builtin-check.c                    | 128 ++++++++++++++++++
 tools/perf/builtin-version.c                  |  39 ++----
 tools/perf/builtin.h                          |  18 +++
 tools/perf/perf.c                             |   1 +
 .../perf/tests/shell/lib/probe_vfs_getname.sh |   4 +-
 .../shell/record+probe_libc_inet_pton.sh      |   5 +-
 .../shell/record+script_probe_vfs_getname.sh  |   5 +-
 tools/perf/tests/shell/test_task_analyzer.sh  |   4 +-
 10 files changed, 224 insertions(+), 37 deletions(-)
 create mode 100644 tools/perf/Documentation/perf-check.txt
 create mode 100644 tools/perf/builtin-check.c

-- 
2.41.0

