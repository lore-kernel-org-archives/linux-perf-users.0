Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC68C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 May 2022 14:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243055AbiEYOKT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 25 May 2022 10:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244822AbiEYOKS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 May 2022 10:10:18 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3126A30A3
        for <linux-perf-users@vger.kernel.org>; Wed, 25 May 2022 07:10:16 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24PE8Me4023903;
        Wed, 25 May 2022 14:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=GrzgC0Fvfm9f/GZEcIsYxeeRBXV5TL5+WW+cV8eS4go=;
 b=tFSek+EsCq50kXaCF/+3Q+hLLUCHw492O1sRqC0UMOj6+bd8RclxOWt6LBYI1FccopLY
 1O5rpt0Hlj5eXhd5D4QQphnMXxDelE9aNy9/Gb78iH9lZwITnfPCbzSWI5FL7onoC/tz
 RXq+YDP70iS7aiIm8oMU/xqCEu1emW8zGCwF0pVZUKWCr3fnL1q0ckN6XER6iEXzBY/W
 8quuFx+PxyDhOJ++cDgUVRHXE9OWSmzv0pDq7jrojXc/Gb+dY+E6RnqJ3EwnBRSjtlG6
 O0NloIRAt61rQZn5erYyqjwEMy09o3dd/JaE6kZQC7NqG+2dnUSwu0y6HkypzgFhSRxn oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g9gxy6hnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 May 2022 14:10:12 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24PCsqQx002618;
        Wed, 25 May 2022 14:10:12 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g9gxy6hmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 May 2022 14:10:12 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24PE8tCN004519;
        Wed, 25 May 2022 14:10:10 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 3g93v6hbjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 May 2022 14:10:10 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24PEA6Bi44499208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 May 2022 14:10:06 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2AE84C04E;
        Wed, 25 May 2022 14:10:06 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E5A24C044;
        Wed, 25 May 2022 14:10:06 +0000 (GMT)
Received: from [9.145.149.136] (unknown [9.145.149.136])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 25 May 2022 14:10:06 +0000 (GMT)
Message-ID: <469b1475-7858-32e0-304b-4cccd25519f6@linux.ibm.com>
Date:   Wed, 25 May 2022 16:10:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: perf test case 40 LLVM search and compile runs endless (eBPF
 linkage issue)
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <olsajiri@gmail.com>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        vasily Gorbik <gor@linux.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
References: <bac4efca-c61e-5f62-daa1-f508b64d6a7f@linux.ibm.com>
 <YotrewGfs8c2sXfV@krava> <YozLKby7ITEtchC9@krava>
 <Yozsvxx0JsTbVgW1@kernel.org>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <Yozsvxx0JsTbVgW1@kernel.org>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ecr3KoKVcmfd2gmD5OVR6GOJMdlILzHq
X-Proofpoint-ORIG-GUID: qUqDvXrIbwj8udoUAIPpwvSzP7M23pki
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-25_04,2022-05-25_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205250072
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 5/24/22 16:33, Arnaldo Carvalho de Melo wrote:
> Em Tue, May 24, 2022 at 02:10:17PM +0200, Jiri Olsa escreveu:
>> On Mon, May 23, 2022 at 01:09:51PM +0200, Jiri Olsa wrote:
>>> On Mon, May 23, 2022 at 12:52:06PM +0200, Thomas Richter wrote:
>>>> On s390 the test case 40 'LLVM search and compile' runs for ever:
>>>>
>>>>   # date; timeout 30s perf test -F 40; date
>>>>   Mon May 23 12:35:48 PM CEST 2022
>>>>    40: LLVM search and compile   :
>>>>    40.1: Basic BPF llvm compile  :
>>>>   Mon May 23 12:36:18 PM CEST 2022
>>>>   #
>>>>
>>>> Investigation by Ilya Leoshkevich revealed:
>>>> On s390 we hit an endless loop where bpf_object__next_program and bpf_program__next 
>>>> infinitely call each other. We tracked this down to ld.so preferring the perf's 
>>>> bpf_object__next_program weak copy over the libbpf's strong one.
>>>>
>>>> This is introduced with commit 2a4898fc264a ("perf tools: Add more weak libbpf functions")
>>>>
>>>> Also see discussion in 
>>>> https://lore.kernel.org/lkml/YY%2FAR2Dcaws0BAE9@kernel.org/
>>>>
>>>> How can this be fixed asap? Thanks a lot.
>>>
>>> I was just suggesting to remove that:
>>>   https://lore.kernel.org/bpf/Yos8hq3NmBwemoJw@krava/T/#mda8abccbf475b99d25abe5498a5df1af2da82ee8
>>>
>>> it's no longer needed and can cause problem apparently
>>
>> after discussing with Arnaldo we decided to go for another fix,
>> could you please try this branch:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>>   perf/weak
> 
> I'm adding comments, testing and applying that series in my local tree,
> so far so good, will push to tmp.perf/core later.
> 
> Please let us know if you guys looked at the patches in Jiri's perf/weak
> branch and if you are ok with it so that I can add
> Tested-by/acked-by/reviewed-by, which are always more than welcome.
> 
> Thanks,
> 
> - Arnaldo

I have taken the repo and branch perf/weak and run it through our build process.
It worked fine and you have my Tested-by:

Thanks

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
