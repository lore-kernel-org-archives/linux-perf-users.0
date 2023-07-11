Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26299EB64DD
	for <linux-perf-users@archiver.kernel.org>; Tue, 11 Jul 2023 10:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjGKKW1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 11 Jul 2023 06:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjGKKWW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 11 Jul 2023 06:22:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939381A2
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Jul 2023 03:22:20 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BALb2r020497
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Jul 2023 10:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : from : subject : content-type :
 content-transfer-encoding; s=pp1;
 bh=xBBWe2rxD/RJ+hf7P5+8eY6Xz4VKIM9dv/CmVViq66U=;
 b=ITfYJmOpxeTlF9UeU/6DpQA3Cx+7rsexL8EehziPodvLa8cw7Zw1l00wx+XO8mLJeKkh
 uUmWGZ7y36wQwnanRjvoHN5VY+Q9JgaYsMt6fZFP7PXmaq2wDpcT/u25ZAGzrQbV+9Gt
 5J5o+pOoozLdWP9FKBelJbByuduV6duC4c1A11xMxNRuePB4RitE//FFjr+4X1NnKjgy
 /TW6mvAR7r6kBrNgQg9+o1ohyj0dr1Z6I7USJDjS974o9C13/k+2qs195IWDQ8mIDHe+
 nmskdbBYtu7TDNgSKB+TZmOvpDRz+3PXqJq170rBKxDCkSYWKMU/XQamos/FDhENdF5X yA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rs54c8a6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Jul 2023 10:22:19 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36B4ulZD027332
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Jul 2023 10:22:17 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3rpye599kw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Jul 2023 10:22:17 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36BAMFIs1704696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Jul 2023 10:22:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 592CD2004F
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Jul 2023 10:22:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45D6620065
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Jul 2023 10:22:15 +0000 (GMT)
Received: from [9.152.212.165] (unknown [9.152.212.165])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Jul 2023 10:22:15 +0000 (GMT)
Message-ID: <648ac57d-0578-30cb-2cd8-577e1016442e@linux.ibm.com>
Date:   Tue, 11 Jul 2023 12:22:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     "linux-perf-use." <linux-perf-users@vger.kernel.org>
From:   Thomas Richter <tmricht@linux.ibm.com>
Subject: Perf tool build with clang/llvm support broken
Organization: IBM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: f4DnILxm6fHBHEzeCo-CMGXEvp2uJVO2
X-Proofpoint-GUID: f4DnILxm6fHBHEzeCo-CMGXEvp2uJVO2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_04,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110089
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

I would like to build the perf tool with LLVM/CLANG support and did

# make LIBCLANGLLVM=1 
  BUILD:   Doing 'make -j2' parallel build
  Warning: Kernel ABI header at 'tools/include/uapi/linux/perf_event.h' differs...
  ... some more similar lines removed.

  Makefile.config:1120: No suitable libLLVM found, disabling builtin clang and LLVM support. 
  Please install llvm-dev(el) (>= 3.9.0)

However when I check llvm packages, I do have them installed on that machine:

 # rpm -qa | grep llvm
 llvm-libs-16.0.3-1.fc38.x86_64
 llvm-16.0.3-1.fc38.x86_64
 llvm-test-16.0.3-1.fc38.x86_64
 llvm-static-16.0.3-1.fc38.x86_64
 llvm-devel-16.0.3-1.fc38.x86_64

 # rpm -qa | grep clang
 clang-resource-filesystem-16.0.3-1.fc38.x86_64
 clang-libs-16.0.3-1.fc38.x86_64
 clang-tools-extra-16.0.3-1.fc38.x86_64
 clang-16.0.3-1.fc38.x86_64
 clang-devel-16.0.3-1.fc38.x86_64
 git-clang-format-16.0.3-1.fc38.x86_64
[root@f38 ~]#

This shows up on s390x and x86_64 (my virtual machine).
Any ideas have to fix this? Am I missing a package?

Thanks.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
