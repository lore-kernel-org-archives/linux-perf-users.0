Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69182C2D0E4
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Nov 2020 13:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1238246CA
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Nov 2020 13:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fg34m7w8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgKSNz1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 19 Nov 2020 08:55:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44554 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727059AbgKSNz1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 Nov 2020 08:55:27 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJDYmFJ077900;
        Thu, 19 Nov 2020 08:55:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/nniWQ9gxk6j4moDBZb7uwbmsTjEjPijA19ANSHPheY=;
 b=Fg34m7w8r7RPSo65njyOS8jbe/xa0WI6JlK7WvVTxJdDl/iB1xNvizAOGoygmfu3AWqj
 uXOmkK5JMq5kxwP7HOUI0VHNovR5l7JLAa6KeFXNuKE3DH1XXrHwjdKP8TKqHOO+j88w
 QwIPPJ3SlbJkVJ62yEL7FXX5cZhxN9y7rE40OW++AaaBnKZmprKyTeCv7h6tyeYdBzYP
 /7uxp7NTqcJhVuMwBrALejFGEH2ruHQZAW52VLA5eI3uDFaoz5W+rCYFyszZX2P4NK/i
 W1l/IW8mczbm8M9rOpgmzYygtJhmm7JGO5rUclaZUbmg6zt/m8ba/4SijwfJOld6TPki CA== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34wg669jmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 08:55:24 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AJDkqwO022880;
        Thu, 19 Nov 2020 13:55:23 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02dal.us.ibm.com with ESMTP id 34vgjmu21t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 13:55:23 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AJDtJPQ11797070
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Nov 2020 13:55:19 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0DF67805F;
        Thu, 19 Nov 2020 13:55:19 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 760737805E;
        Thu, 19 Nov 2020 13:55:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.99.210])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 19 Nov 2020 13:55:15 +0000 (GMT)
Subject: Re: [PATCH] perf test: Omit test 68 for s390.
To:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com
References: <20201104082954.57338-1-tmricht@linux.ibm.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <c2c7cd99-0e89-8d20-a8e9-42df49656c68@linux.ibm.com>
Date:   Thu, 19 Nov 2020 19:25:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201104082954.57338-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_09:2020-11-19,2020-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011190102
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 11/4/20 1:59 PM, Thomas Richter wrote:
> Commit ed21d6d7c48e6e ("perf tests: Add test for PE binary format support")
> adds a WINDOWS EXE file named tests/pe-file.exe, which is
> examined by the test case 'PE file support'.
> 
> This test reads the buildid from the file tests/pe-file.exe,
> which is a Portable Executable (PE) binary file used by the
> Windows operating system.
> 
> Since s390 does not support PE files, omit this test.
> 
> Output before:
> [root@t35lp46 perf]# ./perf test -F 68
> 68: PE file support                               : Failed!
> [root@t35lp46 perf]#
> 
> Output after:
> [root@t35lp46 perf]# ./perf test -F 68
> 68: PE file support                               : Skip
> [root@t35lp46 perf]#
> 
> 

Patch looks good to me. Thanks for correcting it. Since in powerpc also we are having similar issue,
I send patch on top of this change. 

Reviewed-By: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain

> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/tests/pe-file-parsing.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-file-parsing.c
> index 58b90c42eb38..4e45178c50f6 100644
> --- a/tools/perf/tests/pe-file-parsing.c
> +++ b/tools/perf/tests/pe-file-parsing.c
> @@ -18,7 +18,7 @@
>  
>  #include "tests.h"
>  
> -#ifdef HAVE_LIBBFD_SUPPORT
> +#if defined(HAVE_LIBBFD_SUPPORT) && !defined(__s390x__)
>  
>  static int run_dir(const char *d)
>  {
> 
