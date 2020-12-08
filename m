Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF6AC4361B
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Dec 2020 14:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D32723A5B
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Dec 2020 14:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgLHOoJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Dec 2020 09:44:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56356 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727716AbgLHOoJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Dec 2020 09:44:09 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B8EYEbW107606;
        Tue, 8 Dec 2020 09:43:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=YqlUT3QtrcaCnwPB13xNS3AW6f4j/xqpDHcXITx4d04=;
 b=AQT3gEz3N3Q27A8i38nsSrYKk0hdyc3D8g68rtQBnKjEuLbuzzGU1zd+rL317vOi1eqx
 xhp/ZiXFF1OmQbnLn87K/Wm273tQ0Bca8nNY+lGJeLQZgxp88hAwn48cGkTb6qBCk1B3
 8mlCRzpKge/ssWbBgyeB4WV+2wvzX+EdlL7A3ckMI2PTD4lh3JI+x0HXIC83F4RT9+/F
 5ot4yEtUdPpYB+2fNfRKXwgYLwQZD2gPBKQmWh7rjjhxmbLbkgFSuaqcBXwOcXPIDQQi
 SNsWwMOOz7g63TgkZtscgFHZjQIz2uFg69Z91OJ0XMsnXkjCnZcI73weroX7AT36PtnE Hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 359s0rxhwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 09:43:23 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B8EZVV8121065;
        Tue, 8 Dec 2020 09:43:23 -0500
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 359s0rxhvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 09:43:23 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B8EhKD4027332;
        Tue, 8 Dec 2020 14:43:21 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 35958q0y5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 14:43:21 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B8EhIr259834754
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Dec 2020 14:43:18 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B2C24204C;
        Tue,  8 Dec 2020 14:43:18 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0817542041;
        Tue,  8 Dec 2020 14:43:18 +0000 (GMT)
Received: from li-e35baacc-2106-11b2-a85c-8f97eb669a6e.ibm.com (unknown [9.145.53.240])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Dec 2020 14:43:17 +0000 (GMT)
Subject: Re: [PATCH] perf test: Skip test 68 for Powerpc
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Kajol Jain <kjain@linux.ibm.com>, jolsa@redhat.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, irogers@google.com,
        rbernon@codeweavers.com, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com
References: <20201104082954.57338-1-tmricht@linux.ibm.com>
 <20201119135022.36340-1-kjain@linux.ibm.com>
 <4a2908ca-6b75-c688-ec3b-7f37783f08cc@linux.ibm.com>
 <20201207163524.GF125383@kernel.org>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
Message-ID: <763d4593-d581-0971-338c-b811925be45b@linux.ibm.com>
Date:   Tue, 8 Dec 2020 15:43:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201207163524.GF125383@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-08_09:2020-12-08,2020-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1011 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012080086
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 12/7/20 5:35 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Nov 24, 2020 at 03:04:53PM +0530, Ravi Bangoria escreveu:
>>
>>
>> On 11/19/20 7:20 PM, Kajol Jain wrote:
>>> Commit ed21d6d7c48e6e ("perf tests: Add test for PE binary format support")
>>> adds a WINDOWS EXE file named tests/pe-file.exe, which is
>>> examined by the test case 'PE file support'. As powerpc doesn't support
>>> it, we are skipping this test.
>>>
>>> Result in power9 platform before this patach:
>>> [command]# ./perf test -F 68
>>> 68: PE file support                               : Failed!
>>>
>>> Result in power9 platform after this patch:
>>> [command]# ./perf test -F 68
>>> 68: PE file support                               : Skip
>>>
>>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>>
>> Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> 
> But why is it failing? I.e. what is that
> 
>  perf test -v -F 68
> 
> outputs?
> 
> Using 'perf report' on a perf.data file containing samples in such
> binaries, collected on x86 should work on whatever workstation a
> developer uses.
> 
> Say, on a MacBook aarch64 one can look at a perf.data file collected on
> a x86_64 system where Wine running a PE binary was present.
> 
> - Arnaldo
> 

Hi 

What is the distro you are using?
I observed the same issue on s390 but this was fixed for fedora33 somehow.
The error just went away after a dnf update....

[root@m35lp76 perf]# cat /etc/fedora-release 
Fedora release 33 (Thirty Three)
[root@m35lp76 perf]# ./perf test -F 68
68: PE file support                                                 : Ok
[root@m35lp76 perf]# 


However on my fedora32 machine it still fails:
[root@t35lp46 perf]# cat /etc/fedora-release 
Fedora release 32 (Thirty Two)
[root@t35lp46 perf]# ./perf test -F 68
68: PE file support                                                 : FAILED!
[root@t35lp46 perf]# 

Note that I am running the same kernel on both machines: linux 5.10.0rc7 downloaded
this morning.


-- 
Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
