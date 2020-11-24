Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B83FC56202
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Nov 2020 09:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1350E2076B
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Nov 2020 09:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rjMCEQAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731107AbgKXJfI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 24 Nov 2020 04:35:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14064 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731004AbgKXJfH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 24 Nov 2020 04:35:07 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AO9XR7P120656;
        Tue, 24 Nov 2020 04:35:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=NoNyQzr1jquBdTjKz6J3ZBvOvZAC+40G7+eT7V7mZ4Q=;
 b=rjMCEQAMHyGVjpr3oXhEVT4wq/9FZ6LGAFFiLtfLejwT7gOr9mRSUzdgFtQiYOpScigU
 k6XdHPhfIGgVL0B2qG676QYWlrPT2YF9Ug7Ln0ov9Ic3WSXG8INPFcB9OftodtPTUGqK
 89Or6khfjkpTBQcwrDgM/S4WWdQAo9S7SPPX92+dSff8oTXWK3fR1g2+g/eMhHk2ngO7
 KWvKSye/NYkV9PnRuJMMU5I3IYy6dEhAC2Hn7WgQguin68v5yJazz06We/1iIof6FR3Q
 jAVyjb52UReMKLVIWkSiin8Ic3Lz7WbLRQ20GghP8UJp+gAN3xcybuRLdKd9SzdEpGZl 3Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 350n10a3nd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 04:35:02 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AO9YSIU127745;
        Tue, 24 Nov 2020 04:35:02 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 350n10a3m6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 04:35:02 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AO9WB8M025222;
        Tue, 24 Nov 2020 09:35:00 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 34xt5hbend-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 09:34:59 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AO9YvHh6292200
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Nov 2020 09:34:57 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1497D4C04A;
        Tue, 24 Nov 2020 09:34:57 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58CEB4C058;
        Tue, 24 Nov 2020 09:34:54 +0000 (GMT)
Received: from [9.199.32.189] (unknown [9.199.32.189])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 24 Nov 2020 09:34:54 +0000 (GMT)
Subject: Re: [PATCH] perf test: Skip test 68 for Powerpc
To:     Kajol Jain <kjain@linux.ibm.com>, acme@kernel.org
Cc:     jolsa@redhat.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        irogers@google.com, tmricht@linux.ibm.com, rbernon@codeweavers.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20201104082954.57338-1-tmricht@linux.ibm.com>
 <20201119135022.36340-1-kjain@linux.ibm.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Message-ID: <4a2908ca-6b75-c688-ec3b-7f37783f08cc@linux.ibm.com>
Date:   Tue, 24 Nov 2020 15:04:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201119135022.36340-1-kjain@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_04:2020-11-24,2020-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 clxscore=1011 phishscore=0 bulkscore=0
 mlxscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011240058
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 11/19/20 7:20 PM, Kajol Jain wrote:
> Commit ed21d6d7c48e6e ("perf tests: Add test for PE binary format support")
> adds a WINDOWS EXE file named tests/pe-file.exe, which is
> examined by the test case 'PE file support'. As powerpc doesn't support
> it, we are skipping this test.
> 
> Result in power9 platform before this patach:
> [command]# ./perf test -F 68
> 68: PE file support                               : Failed!
> 
> Result in power9 platform after this patch:
> [command]# ./perf test -F 68
> 68: PE file support                               : Skip
> 
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>

Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
