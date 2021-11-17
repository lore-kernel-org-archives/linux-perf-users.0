Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE063C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 09:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A69461BF8
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 09:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbhKQJIj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 17 Nov 2021 04:08:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32978 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230064AbhKQJIj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 Nov 2021 04:08:39 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AH8faTB019812;
        Wed, 17 Nov 2021 09:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=81GUYYvzXXKxUGSxUOqwUPJtu2mV6MVicPPY3X90eco=;
 b=c9Nr612leVA8iVlsK+F5XXJ4KyrR2AcrVv7zlCGlEGGkaSyGTksjl2bhZi7s9N2Lgu/M
 4FhFjsqA6Tzf4qGbGQh2QFredn57ewoaERtxbVdSbMZkPMRle87GBRHFhXnIGZW8ES5z
 QrzwGI9tVYLdRz5FvzCqWPQQZhaN8rdW6BSA9p3JagIkF+2wqGbbCP0iOYIJdhJQ4DGR
 1bGHzl8bk4iWTMb2AfxQFa+ZJlxLBblbkU1Voomo6nHho9EjMnzpIW5TsfGjFehGD8j7
 /2TbJP44K7qT3D7QysRHbY6SNUMp0akVSXgTwWM69PdTUJoBrx/ZS4zgCU0ilp4/mTEF 8g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ccxesgeee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 09:05:40 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AH90nMs001433;
        Wed, 17 Nov 2021 09:05:39 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ccxesgeds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 09:05:39 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AH938CY031836;
        Wed, 17 Nov 2021 09:05:37 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3ca4mjyu6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 09:05:37 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AH95YuG983672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 09:05:34 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0631D11C052;
        Wed, 17 Nov 2021 09:05:34 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8C6911C05B;
        Wed, 17 Nov 2021 09:05:30 +0000 (GMT)
Received: from [9.43.21.152] (unknown [9.43.21.152])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 17 Nov 2021 09:05:30 +0000 (GMT)
Message-ID: <beeecf6d-3cd9-2072-ee7c-13712a77807d@linux.ibm.com>
Date:   Wed, 17 Nov 2021 14:35:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] perf/test: Test case 27 broken on s390 in linux-next
Content-Language: en-US
To:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, sumanthk@linux.ibm.com, jolsa@redhat.com
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com
References: <20211103155215.2941895-1-tmricht@linux.ibm.com>
From:   Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <20211103155215.2941895-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vVi8BCFFLC3Xch8WTAznHMEyCU2JnPxF
X-Proofpoint-ORIG-GUID: _p6K4rlaX0PWiy_Q1xtuejZarqfhJPqL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_03,2021-11-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111170045
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On 11/3/21 21:22, Thomas Richter wrote:
> Commit 10269a2ca2b08c ("perf test sample-parsing: Add endian test for struct branch_flags")
> broke the test case 27 (Sample parsing) on s390 on linux-next tree:
>
>    # ./perf test -Fv 27
>    27: Sample parsing
>    --- start ---
>    parsing failed for sample_type 0x800
>    ---- end ----
>    Sample parsing: FAILED!
>    #
>
> The cause of the failure is a wrong #define BS_EXPECTED_BE statement
> in above commit.  Correct this define and the test case runs fine.
>
> Output After:
>    # ./perf test -Fv 27
>    27: Sample parsing                                                  :
>    --- start ---
>    ---- end ----
>    Sample parsing: Ok
>    #


Hi Thomas,
Thanks for the fix. Not sure, I guess I messed up my big endian setup or 
test run I had before sending
the patch. My bad. It fails for me too, but with your patch the issue 
fixed.

Acked-and-Tested-by: Madhavan Srinivasan <maddy@linux.ibm.com>


>
> Fixes: 10269a2ca2b08c ("perf test sample-parsing: Add endian test for struct branch_flags")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>   tools/perf/tests/sample-parsing.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
> index c83a11514129..9c7af55b74db 100644
> --- a/tools/perf/tests/sample-parsing.c
> +++ b/tools/perf/tests/sample-parsing.c
> @@ -36,7 +36,7 @@
>    * These are based on the input value (213) specified
>    * in branch_stack variable.
>    */
> -#define BS_EXPECTED_BE	0xa00d000000000000
> +#define BS_EXPECTED_BE	0xa000d00000000000
>   #define BS_EXPECTED_LE	0xd5000000
>   #define FLAG(s)	s->branch_stack->entries[i].flags
>   
