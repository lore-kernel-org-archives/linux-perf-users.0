Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C12C4361B
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Dec 2020 17:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAD5C23AC8
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Dec 2020 17:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbgLHRDf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Dec 2020 12:03:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45796 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730612AbgLHRDe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Dec 2020 12:03:34 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B8H2bDj018837;
        Tue, 8 Dec 2020 12:02:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : subject : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DRRHGhI+esERVSQ1XUhnZZCx90myVMtMfQXs2YGWjyo=;
 b=rD7l4H1tGHGFIVfY61bIC5evjkMhkyDcfrTI4PclRN9qOymYMe6KayyCeRbO9Bmdt4mM
 hq2g5xcKTsvAmz6O6p1vrh401JgF1iVpWact3oejffgXSDN2fFmV4dZg7HGjkSBQUcgD
 zB0NXGwEWtcdyDKQNLj1dSmMyS+3sgL+tVH1Pj+BCjK87/unxZUb2a+mKGhb80r3T20/
 CXQsMi+ySrKhCzyu0xfjmpRY91q7lYyCzSFjdllb1zpPJRw6CBC/Vzv+1UohqA5bg5R4
 cun3Q8UYcQmQqekc/o2lbF4j72n2kDRXiHJKLPBBsmrEaRySA0HNft8/USGJXkHJ9Dky Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35a6277971-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 12:02:50 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B8H2niQ020044;
        Tue, 8 Dec 2020 12:02:49 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35a627795y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 12:02:49 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B8GvZtu030336;
        Tue, 8 Dec 2020 17:02:46 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 3581u8nj7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 17:02:46 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B8H2hMp47317482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Dec 2020 17:02:43 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9364F11C069;
        Tue,  8 Dec 2020 17:02:42 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDE3411C04C;
        Tue,  8 Dec 2020 17:02:39 +0000 (GMT)
Received: from [9.199.44.35] (unknown [9.199.44.35])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Dec 2020 17:02:39 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH] perf test: Skip test 68 for Powerpc
To:     Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Kajol Jain <kjain@linux.ibm.com>, jolsa@redhat.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, irogers@google.com,
        rbernon@codeweavers.com, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20201104082954.57338-1-tmricht@linux.ibm.com>
 <20201119135022.36340-1-kjain@linux.ibm.com>
 <4a2908ca-6b75-c688-ec3b-7f37783f08cc@linux.ibm.com>
 <20201207163524.GF125383@kernel.org>
 <763d4593-d581-0971-338c-b811925be45b@linux.ibm.com>
Message-ID: <29a77348-2ab7-1235-3fcf-c505dab1f1a1@linux.ibm.com>
Date:   Tue, 8 Dec 2020 22:32:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <763d4593-d581-0971-338c-b811925be45b@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-08_11:2020-12-08,2020-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080101
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 12/8/20 8:13 PM, Thomas Richter wrote:
> On 12/7/20 5:35 PM, Arnaldo Carvalho de Melo wrote:
>> Em Tue, Nov 24, 2020 at 03:04:53PM +0530, Ravi Bangoria escreveu:
>>>
>>>
>>> On 11/19/20 7:20 PM, Kajol Jain wrote:
>>>> Commit ed21d6d7c48e6e ("perf tests: Add test for PE binary format support")
>>>> adds a WINDOWS EXE file named tests/pe-file.exe, which is
>>>> examined by the test case 'PE file support'. As powerpc doesn't support
>>>> it, we are skipping this test.
>>>>
>>>> Result in power9 platform before this patach:
>>>> [command]# ./perf test -F 68
>>>> 68: PE file support                               : Failed!
>>>>
>>>> Result in power9 platform after this patch:
>>>> [command]# ./perf test -F 68
>>>> 68: PE file support                               : Skip
>>>>
>>>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>>>
>>> Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>>
>> But why is it failing? I.e. what is that
>>
>>   perf test -v -F 68
>>
>> outputs?
>>
>> Using 'perf report' on a perf.data file containing samples in such
>> binaries, collected on x86 should work on whatever workstation a
>> developer uses.
>>
>> Say, on a MacBook aarch64 one can look at a perf.data file collected on
>> a x86_64 system where Wine running a PE binary was present.
>>
>> - Arnaldo
>>
> 
> Hi
> 
> What is the distro you are using?
> I observed the same issue on s390 but this was fixed for fedora33 somehow.
> The error just went away after a dnf update....
> 
> [root@m35lp76 perf]# cat /etc/fedora-release
> Fedora release 33 (Thirty Three)
> [root@m35lp76 perf]# ./perf test -F 68
> 68: PE file support                                                 : Ok
> [root@m35lp76 perf]#
> 
> 
> However on my fedora32 machine it still fails:
> [root@t35lp46 perf]# cat /etc/fedora-release
> Fedora release 32 (Thirty Two)
> [root@t35lp46 perf]# ./perf test -F 68
> 68: PE file support                                                 : FAILED!
> [root@t35lp46 perf]#
> 
> Note that I am running the same kernel on both machines: linux 5.10.0rc7 downloaded
> this morning.
> 

Ok that's interesting. I don't see that on powerpc.

Fedora 32 with 5.10.0-rc2+ kernel:

   $ ./perf test -vv -F 68
   68: PE file support                                                 :
   --- start ---
   filename__read_build_id: cannot read ./tests/pe-file.exe bfd file.
   FAILED tests/pe-file-parsing.c:40 Failed to read build_id
   ---- end ----
   PE file support: FAILED!

Fedora 33 with 5.10.0-rc3 kernel:

   $ ./perf test -vv -F 68
   68: PE file support                                                 :
   --- start ---
   filename__read_build_id: cannot read ./tests/pe-file.exe bfd file.
   FAILED tests/pe-file-parsing.c:40 Failed to read build_id
   ---- end ----
   PE file support: FAILED!

Ubuntu 18.04.5 with 4.15.0-126-generic kernel:

   $ ./perf test -vv -F 68
   68: PE file support                                                 :
   --- start ---
   filename__read_build_id: cannot read ./tests/pe-file.exe bfd file.
   FAILED tests/pe-file-parsing.c:41 Failed to read build_id
   ---- end ----
   PE file support: FAILED!


I assumed bfd is not capable to parse PE files on powerpc. Though,
I didn't check it in more detail. I'll look into it tomorrow.

Ravi
