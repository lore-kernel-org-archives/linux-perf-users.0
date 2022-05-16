Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE15C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 16 May 2022 07:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240931AbiEPHZH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 16 May 2022 03:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239628AbiEPHZG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 16 May 2022 03:25:06 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511C51ADAB
        for <linux-perf-users@vger.kernel.org>; Mon, 16 May 2022 00:25:05 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24G5ON43005578;
        Mon, 16 May 2022 07:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : from : subject : content-type :
 content-transfer-encoding; s=pp1;
 bh=oWjJLAQ2VaLSv5fqLbH7OkeoEbeesmKVxBJGAJ5l87A=;
 b=KLnSrXQq5yO7C6mJFglNl71+AvnFW04E9pqdhgYS2/bHSYXAZetkmZM6fuNYiEpacC1K
 hT4MF9dY7GcB37tszvOaxfxCxALqWvB0rU6NSbuOlybGy5dFrVpZcDUPcKr7nG+gH25E
 Y4DGTwRkQli90INEXrQlVt3QhFtylnzqWZB3UBzxoMEUYRhTNyEdFKt0Ggbf/4Yxluz+
 3BwJRVBgL4UHZtI1eiDrjaXW3w/kwD23S7Aj+bO0E5+543SiZH98MX1+NR3FNnBrfukt
 Q2TD349GWnfTBuySNxy8hcZvWXX9HFEzDo6TfLQ2VcaSEJZ1sK5nMvdQvU6IfPt4CEtZ jg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g3ge8j19c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 07:24:58 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24G7NQfv008769;
        Mon, 16 May 2022 07:24:55 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3g2429a7d8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 07:24:55 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24G7ONBA14877154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 07:24:23 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D1044C04A;
        Mon, 16 May 2022 07:24:53 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BEC64C044;
        Mon, 16 May 2022 07:24:53 +0000 (GMT)
Received: from [9.152.212.236] (unknown [9.152.212.236])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 16 May 2022 07:24:52 +0000 (GMT)
Message-ID: <00a443b1-92e0-8992-18ae-10e0e8489658@linux.ibm.com>
Date:   Mon, 16 May 2022 09:24:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        arnaldo Carvalho de Melo <acme@kernel.org>
From:   Thomas Richter <tmricht@linux.ibm.com>
Subject: File bench/numa.c compiler error on s390
Organization: IBM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CMYMQfVdcm_4JZA8JNqVX7xzH0jAeG1t
X-Proofpoint-ORIG-GUID: CMYMQfVdcm_4JZA8JNqVX7xzH0jAeG1t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-16_03,2022-05-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205160037
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi all,

I just upgraded to Fedora 36 and gcc version 12.0.1 20220308 (Red Hat 12.0.1-0) (GCC) 
and run into this compiler error:
CC      bench/numa.o
bench/numa.c: In function ‘__bench_numa’:
bench/numa.c:1749:81: error: ‘%d’ directive output may be truncated writing between 1 and 11
 bytes into a region of size between 10 and 20 [-Werror=format-truncation=]
 1749 |           snprintf(tname, sizeof(tname), "process%d:thread%d", p, t);
      |                                                           ^~
bench/numa.c:1749:64: note: directive argument in the range [-2147483647, 2147483646]
 1749 |           snprintf(tname, sizeof(tname), "process%d:thread%d", p, t);
      |                                                   ^~~~~~~~~~~~~~~~~~~~
bench/numa.c:1749:33: note: ‘snprintf’ output between 17 and 37 bytes into a destination of size 35
 1749 |           snprintf(tname, sizeof(tname), "process%d:thread%d", p, t);
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[3]: *** [/root/linux/tools/build/Makefile.build:97: bench/numa.o] Error 1

Does this also show up on other plattforms?

Looks like commit 3aff8ba0a4c9 ("perf bench numa: Avoid possible truncation when using snprintf()")
has fixed this issue before and now it reappeared.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
