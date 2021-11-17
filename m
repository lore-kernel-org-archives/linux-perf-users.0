Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472DEC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 08:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26B4461BF9
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Nov 2021 08:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbhKQId7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 17 Nov 2021 03:33:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20404 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229944AbhKQId6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 Nov 2021 03:33:58 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AH7fjKq030962;
        Wed, 17 Nov 2021 08:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=kusmXue06olX1JHg97gQVm+Ok4KQWnLZnMN/DLRzidY=;
 b=sxU3WfSuckquGN02q2C00+jOQNq6mLiPnknoCJ2v3Um6VFGYn0Oky1nztpuq749dnhCB
 1z1RSiuMbzwCv7E1qIF6tV5FhRo/lWG2CuhqGpLeOsamDAuMsHBHG0zhPKw3Nhh9NPFn
 sM74yqC/wscboAtpG7Bkg3lEK5+pvMO6j1t1CczKkQfv8mZZf6ST1y9fypR9v0OCjQih
 1+AFJLcJDhQERWddoFJsRXGDa3EfAgOwh5Foa+pCidM4Tzx0wQI0X8KuPSDF2KWyWJBC
 qZSk7huEljeroqmo7oC0c36plVUIn516Tjk0nDRG3c3XykvI/BdGd35skbn5BRQ+35np gQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ccwjngwcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 08:30:59 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AH7m2Ts032313;
        Wed, 17 Nov 2021 08:30:59 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ccwjngwbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 08:30:59 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AH8PS5d019252;
        Wed, 17 Nov 2021 08:30:56 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3ca50b7eyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 08:30:56 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AH8UqVk54460826
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 08:30:52 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D9E411C052;
        Wed, 17 Nov 2021 08:30:52 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E78C11C05C;
        Wed, 17 Nov 2021 08:30:49 +0000 (GMT)
Received: from [9.43.21.152] (unknown [9.43.21.152])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 17 Nov 2021 08:30:49 +0000 (GMT)
Message-ID: <d8943b3f-b2d5-8b5c-cbf9-14360a6df2b4@linux.ibm.com>
Date:   Wed, 17 Nov 2021 14:00:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] perf/test: Test case 27 broken on s390 in linux-next
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        sumanthk@linux.ibm.com, jolsa@redhat.com, svens@linux.ibm.com,
        gor@linux.ibm.com, hca@linux.ibm.com
References: <20211103155215.2941895-1-tmricht@linux.ibm.com>
 <YYbYXT5O2KTxLAKC@kernel.org>
From:   Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <YYbYXT5O2KTxLAKC@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: b6KpiF-_tJUYUpTpy51Rh5b0Qi_Z2wQ8
X-Proofpoint-ORIG-GUID: G87xhebFZwIxJx5a3KEHrx9MYy-0cPdn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_03,2021-11-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111170041
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On 11/7/21 01:02, Arnaldo Carvalho de Melo wrote:
> Em Wed, Nov 03, 2021 at 04:52:15PM +0100, Thomas Richter escreveu:
>> Commit 10269a2ca2b08c ("perf test sample-parsing: Add endian test for struct branch_flags")
>> broke the test case 27 (Sample parsing) on s390 on linux-next tree:
> Maddy,
>
> 	Can you please ack this one?

Sorry i missed this completely. My bad. Will check it and will reply.

Maddy


>
> - Arnaldo
>   
>>    # ./perf test -Fv 27
>>    27: Sample parsing
>>    --- start ---
>>    parsing failed for sample_type 0x800
>>    ---- end ----
>>    Sample parsing: FAILED!
>>    #
>>
>> The cause of the failure is a wrong #define BS_EXPECTED_BE statement
>> in above commit.  Correct this define and the test case runs fine.
>>
>> Output After:
>>    # ./perf test -Fv 27
>>    27: Sample parsing                                                  :
>>    --- start ---
>>    ---- end ----
>>    Sample parsing: Ok
>>    #
>>
>> Fixes: 10269a2ca2b08c ("perf test sample-parsing: Add endian test for struct branch_flags")
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> ---
>>   tools/perf/tests/sample-parsing.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
>> index c83a11514129..9c7af55b74db 100644
>> --- a/tools/perf/tests/sample-parsing.c
>> +++ b/tools/perf/tests/sample-parsing.c
>> @@ -36,7 +36,7 @@
>>    * These are based on the input value (213) specified
>>    * in branch_stack variable.
>>    */
>> -#define BS_EXPECTED_BE	0xa00d000000000000
>> +#define BS_EXPECTED_BE	0xa000d00000000000
>>   #define BS_EXPECTED_LE	0xd5000000
>>   #define FLAG(s)	s->branch_stack->entries[i].flags
>>   
>> -- 
>> 2.25.1
