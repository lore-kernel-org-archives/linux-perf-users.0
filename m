Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C3EC4361B
	for <linux-perf-users@archiver.kernel.org>; Thu, 10 Dec 2020 05:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38ED4235F7
	for <linux-perf-users@archiver.kernel.org>; Thu, 10 Dec 2020 05:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732819AbgLJFxt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 10 Dec 2020 00:53:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6452 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727004AbgLJFxq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 10 Dec 2020 00:53:46 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BA5Vfg5066137;
        Thu, 10 Dec 2020 00:52:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : subject : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=iVTRcYlvhCxbqRg6/Fse2DZBWcHtsG3wDqUaymJg61k=;
 b=V35LcyYXjFMXZA/BbPOmdWWLTkYIX6FgyrVUXvH2pkcc+12JrtUOjrB49mvGLDBw0MSO
 JWtKEAymRPE8PaMMP3z+fz9V5a5nlGJvltV7mXvPRau8d5B9KicKvi7+UFKzbb09KX0D
 N6wWdO61Zlzkje5nKNvLVYuDf6L/qNICx9sAmMdFvLHxEyJBvpu7bs3a2a5dcJAvsu4a
 d8eRhVgMM8mrE4chihekxE7OdNZySljYFlmSwDczMaDopXtZSKHO57Tp55BTMRk+at3V
 GznwCD2HhZFdFWBQFVNhW/543GOq7X/+WhTXawFJSfG1QxM6XCMxDUv6JcEOBVRiTuIQ Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35b84s7jxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Dec 2020 00:52:58 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BA5XA7b069528;
        Thu, 10 Dec 2020 00:52:58 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35b84s7jx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Dec 2020 00:52:57 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BA5pUAE017214;
        Thu, 10 Dec 2020 05:52:56 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3581u85dq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Dec 2020 05:52:56 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BA5qrFV61800944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Dec 2020 05:52:53 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 439D24C040;
        Thu, 10 Dec 2020 05:52:53 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDBBA4C04A;
        Thu, 10 Dec 2020 05:52:50 +0000 (GMT)
Received: from [9.199.41.64] (unknown [9.199.41.64])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 10 Dec 2020 05:52:50 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH] perf test: Skip test 68 for Powerpc
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>, jolsa@redhat.com,
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
 <29a77348-2ab7-1235-3fcf-c505dab1f1a1@linux.ibm.com>
 <20201209174910.GC185686@kernel.org>
Message-ID: <c6757366-5d3a-e7b5-7f76-bae7e6ad41a4@linux.ibm.com>
Date:   Thu, 10 Dec 2020 11:22:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201209174910.GC185686@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-10_01:2020-12-09,2020-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012100033
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 12/9/20 11:19 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Dec 08, 2020 at 10:32:33PM +0530, Ravi Bangoria escreveu:
>> On 12/8/20 8:13 PM, Thomas Richter wrote:
>>> On 12/7/20 5:35 PM, Arnaldo Carvalho de Melo wrote:
>>>> Em Tue, Nov 24, 2020 at 03:04:53PM +0530, Ravi Bangoria escreveu:
>>>>> On 11/19/20 7:20 PM, Kajol Jain wrote:
>>>>>> Commit ed21d6d7c48e6e ("perf tests: Add test for PE binary format support")
>>>>>> adds a WINDOWS EXE file named tests/pe-file.exe, which is
>>>>>> examined by the test case 'PE file support'. As powerpc doesn't support
>>>>>> it, we are skipping this test.
> 
>>>>>> Result in power9 platform before this patach:
>>>>>> [command]# ./perf test -F 68
>>>>>> 68: PE file support                               : Failed!
> 
>>>>>> Result in power9 platform after this patch:
>>>>>> [command]# ./perf test -F 68
>>>>>> 68: PE file support                               : Skip
> 
>>>>>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> 
>>>>> Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> 
>>>> But why is it failing? I.e. what is that
> 
>>>>    perf test -v -F 68
> 
>>>> outputs?
> 
>>>> Using 'perf report' on a perf.data file containing samples in such
>>>> binaries, collected on x86 should work on whatever workstation a
>>>> developer uses.
> 
>>>> Say, on a MacBook aarch64 one can look at a perf.data file collected on
>>>> a x86_64 system where Wine running a PE binary was present.
> 
>>> What is the distro you are using?
>>> I observed the same issue on s390 but this was fixed for fedora33 somehow.
>>> The error just went away after a dnf update....
> 
>>> [root@m35lp76 perf]# cat /etc/fedora-release
>>> Fedora release 33 (Thirty Three)
>>> [root@m35lp76 perf]# ./perf test -F 68
>>> 68: PE file support                                                 : Ok
>>> [root@m35lp76 perf]#
> 
>>> However on my fedora32 machine it still fails:
>>> [root@t35lp46 perf]# cat /etc/fedora-release
>>> Fedora release 32 (Thirty Two)
>>> [root@t35lp46 perf]# ./perf test -F 68
>>> 68: PE file support                                                 : FAILED!
>>> [root@t35lp46 perf]#
>>>
>>> Note that I am running the same kernel on both machines: linux 5.10.0rc7 downloaded
>>> this morning.
>>>
>>
>> Ok that's interesting. I don't see that on powerpc.
>>
>> Fedora 32 with 5.10.0-rc2+ kernel:
>>
>>    $ ./perf test -vv -F 68
>>    68: PE file support                                                 :
>>    --- start ---
>>    filename__read_build_id: cannot read ./tests/pe-file.exe bfd file.
>>    FAILED tests/pe-file-parsing.c:40 Failed to read build_id
>>    ---- end ----
>>    PE file support: FAILED!
>>
>> Fedora 33 with 5.10.0-rc3 kernel:
>>
>>    $ ./perf test -vv -F 68
>>    68: PE file support                                                 :
>>    --- start ---
>>    filename__read_build_id: cannot read ./tests/pe-file.exe bfd file.
>>    FAILED tests/pe-file-parsing.c:40 Failed to read build_id
>>    ---- end ----
>>    PE file support: FAILED!
>>
>> Ubuntu 18.04.5 with 4.15.0-126-generic kernel:
>>
>>    $ ./perf test -vv -F 68
>>    68: PE file support                                                 :
>>    --- start ---
>>    filename__read_build_id: cannot read ./tests/pe-file.exe bfd file.
>>    FAILED tests/pe-file-parsing.c:41 Failed to read build_id
>>    ---- end ----
>>    PE file support: FAILED!
>>
>>
>> I assumed bfd is not capable to parse PE files on powerpc. Though,
>> I didn't check it in more detail. I'll look into it tomorrow.
> 
> Humm, so this is something related to installation? I.e. that
> pe-file.exe isn't being found...
> 
> It first assumes that the developers are in the tools/perf/ directory,
> can you please add the patch below and see if it helps?

I'm using upstream perf from tools/perf/

I checked bfd code and it's bfd_check_format() who is returning error
"bfd_error_file_not_recognized".

I cross verified with objdump as well:

On x86:

   $ objdump -d ./tests/pe-file.exe
   ./tests/pe-file.exe:     file format pei-x86-64
     
   Disassembly of section .text:
   
   0000000000401000 <__mingw_invalidParameterHandler>:
     401000:       c3                      retq
     401001:       66 66 2e 0f 1f 84 00    data16 nopw %cs:0x0(%rax,%rax,1)
     401008:       00 00 00 00
     40100c:       0f 1f 40 00             nopl   0x0(%rax)

On powerpc:

   $ objdump -d ./tests/pe-file.exe
   objdump: ./tests/pe-file.exe: file format not recognized

Objdump is also returning *same* error.

I dig more into bfd logs and found that Powerpc PE support was removed
recently (Jul 2020) with this commit:
https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=fe49679d5193f6ff7cfd333e30883d293112a3d1

Ravi
