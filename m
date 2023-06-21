Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06A8EB64D7
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jun 2023 11:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjFULO2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 21 Jun 2023 07:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjFULN7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Jun 2023 07:13:59 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73997186
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jun 2023 04:13:57 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35L9rHCW003360;
        Wed, 21 Jun 2023 10:04:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=bRoaHU7Y8TUZDgNDHB8mOxxotjhlKXci2UxYKeDo+Mk=;
 b=GbCG+SY5rnf6SV6i4/MWEX2p7c+fZeByGrfocmbSEzvxG2/6QheTt+01ePnbJiKA4eqx
 Jh0FwI/5Vsto8FdgUL/+wjeiU9/7k3Ay6BSwQ7qY2HkAFsdG/XrtvNKBIQC2y50uA3dS
 7vWwgYNRbpbLtQTLbxbvR5E8O1bEeEa21vW58lapfK8H2+L6uUhRmNKgTRu7rxYSwfAb
 yJnITZN8bsSAuWR1Kb4T3lyw7hKSflVOxQCn1SU8duVY8B8dPylqA4LkG/M7CIZW4+nm
 H7RgCOnmxSCSqacYk1y5erAMe3/GL/GsniuzcA59loR9L+fEyOwGT8/Ca0vqQ3T10Vj0 UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rbxyb0b7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 10:04:57 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35LA0K4V002145;
        Wed, 21 Jun 2023 10:04:51 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rbxyb0ap6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 10:04:51 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35L9YsNv013852;
        Wed, 21 Jun 2023 10:03:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3r94f52114-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 10:03:51 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35LA3mXm45679262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 10:03:48 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 611B72004F;
        Wed, 21 Jun 2023 10:03:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2C0D20040;
        Wed, 21 Jun 2023 10:03:45 +0000 (GMT)
Received: from [9.109.199.72] (unknown [9.109.199.72])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 21 Jun 2023 10:03:45 +0000 (GMT)
Message-ID: <5ab5cc25-03b0-ef7f-3dc0-be1b59a4147d@linux.ibm.com>
Date:   Wed, 21 Jun 2023 15:33:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 15/17] perf tests task_analyzer: fix bad substitution
 ${$1}
Content-Language: en-IN, en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Petar Gligoric <petar.gligoric@rohde-schwarz.com>
Cc:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>, jolsa@kernel.org,
        irogers@google.com, ravi.bangoria@amd.com, john.g.garry@oracle.com,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20230613164145.50488-1-atrajeev@linux.vnet.ibm.com>
 <20230613164145.50488-16-atrajeev@linux.vnet.ibm.com>
 <ZIjMWUk/axKfMCM4@kernel.org>
 <CAM9d7cjrpaNk0UC22ntBSP+LzQwT2YAHwQ2o3z1aayAZNQ329g@mail.gmail.com>
From:   Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <CAM9d7cjrpaNk0UC22ntBSP+LzQwT2YAHwQ2o3z1aayAZNQ329g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1M-PIDgXKA9ugTZgLekZCyU_4c4be2C6
X-Proofpoint-GUID: zOEZARp_GAq-xb5Kt5c5bgRiG4bpaQAX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_07,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 clxscore=1011 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306210085
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello Namhyung,

On 21/06/23 06:18, Namhyung Kim wrote:
> Hello,
>
> On Tue, Jun 13, 2023 at 1:06 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
>> Em Tue, Jun 13, 2023 at 10:11:43PM +0530, Athira Rajeev escreveu:
>>> This issue due to ${$1} caused all function calls to give error in
>>> `find_str_or_fail` line, and so no test runs completely. But
>>> 'perf test "perf script task-analyzer tests"' wrongly reports
>>> that tests passed with the status OK, which is wrong considering
>>> the tests didn't even run completely
>>>
>>> Fixes: e8478b84d6ba ("perf test: add new task-analyzer tests")
>>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>>> ---
> I'm seeing a different error even after this fix.
> Can you please take a look?
>
> Thanks,
> Namhyung
>
>
> $ sudo ./perf test -v task
> 114: perf script task-analyzer tests                                 :
> --- start ---
> test child forked, pid 1771042
> Please specify a valid report script(see 'perf script -l' for listing)
> FAIL: "invocation of perf command failed" Error message: ""
> FAIL: "test_basic" Error message: "Failed to find required string:'Comm'."
> Please specify a valid report script(see 'perf script -l' for listing)
> FAIL: "invocation of perf command failed" Error message: ""
> FAIL: "test_ns_rename" Error message: "Failed to find required string:'Comm'."
> ...
> test child finished with -1
> ---- end ----
> perf script task-analyzer tests: FAILED!
Can you please check if your environment has libtraceevent devel 
libraries (or did you compile with `make NO_LIBTRACEEVENT=1`) ? When 
libtraceevent support is not there, perf record fails and so perf.data 
doesn't contain the strings it's searching for and hence those errors

The error you mentioned has been mentioned and fixed in patch 17/17 of 
this series.

Thanks
- Aditya
