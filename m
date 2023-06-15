Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F081EB64DC
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jun 2023 09:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjFOJlJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jun 2023 05:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343772AbjFOJkO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jun 2023 05:40:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9356430E1
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Jun 2023 02:39:33 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F9GdRK009331;
        Thu, 15 Jun 2023 09:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XjItn+i67K5sH8zLpYMQiMZng4XtRD2ebBcXd/uDs84=;
 b=QHLLTbMCOBNtJeb3O9z2Rq+lGICKWKbmUNs8Phj3HfoqQBBGQ4XFwP6WWYjdQuRfQ8S6
 PkKm+NBUtC+kyboJJjo4mYCWqV3VuEFchFERc9hHP/+mWuS314EvUa8AFr+f/kMYMf2P
 yt70XqA4TSK+AlXpETTzJZqxBj7JSpXXw+Zn5xpfsQsi8XjQlqjLM9kw/Cbhh/W1mZvj
 ccxnV/NDzpMYj9ZsoMcVNkM2SyQPVulznBURsLqTIJDdUKbAt8y7wZ9dE+1y9xoqgljQ
 CtQO1YPdGAZEwkbZjf3SJ8SL+9J+Jp24IQkSbT8D3/3pGIJ7RyAOdl/7YyOCwAQDjMkQ KA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r7yv90n06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 09:39:22 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35F9HwRR015584;
        Thu, 15 Jun 2023 09:39:21 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r7yv90my3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 09:39:21 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35F2cbX7026849;
        Thu, 15 Jun 2023 09:39:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3r4gt53gh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 09:39:19 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35F9dHBc21365292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 09:39:17 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11C302004B;
        Thu, 15 Jun 2023 09:39:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8F6F20040;
        Thu, 15 Jun 2023 09:39:16 +0000 (GMT)
Received: from [9.152.212.165] (unknown [9.152.212.165])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 15 Jun 2023 09:39:16 +0000 (GMT)
Message-ID: <a19a30b0-8f16-5871-6856-503eadf56e3c@linux.ibm.com>
Date:   Thu, 15 Jun 2023 11:39:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: perf test failures in linux-next on s390
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
References: <d5319870-7569-c353-1777-31ee090f8da8@linux.ibm.com>
 <CAP-5=fU+0VXckQiq3E8yqaySNZ+-DDZahEd1OY0uKPWnfFsafg@mail.gmail.com>
 <e7f0930a-a9fc-d768-a472-bd9af6fafdf5@linux.ibm.com>
 <CAP-5=fWjqJH0h607cVb1T7pRxDeq4cZBz5TECMajpnkvVNWHEQ@mail.gmail.com>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <CAP-5=fWjqJH0h607cVb1T7pRxDeq4cZBz5TECMajpnkvVNWHEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: O93sQos12gykdFXuqZ4hr1kyjm9NUMaS
X-Proofpoint-GUID: UjSj3dgjih-PEtek5H41uJoayei32J9u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_06,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306150081
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 6/14/23 16:57, Ian Rogers wrote:
> On Wed, Jun 14, 2023 at 1:32 AM Thomas Richter <tmricht@linux.ibm.com> wrote:

....

> 
> Smaller list is okay. Could you send me a zip of the sysfs
> (/sys/devices) ? At least one issue is that the code didn't find a
> core PMU. On non-hybrid x86 this would be /sys/devices/cpu, I think we
> spoke about this before for s390 and there are >1. The issue here is
> that the test found 0, and we're trying to use PMUs in the code now as
> a way to sort events. There's code/comment in util/pmu.c:
> 
> '''
> /**
>  * is_sysfs_pmu_core() - PMU CORE devices have different name other than cpu in
>  *         sysfs on some platforms like ARM or Intel hybrid. Looking for
>  *         possible the cpus file in sysfs files to identify whether this is a
>  *         core device.
>  * @name: The PMU name such as "cpu_atom".
>  */
> static int is_sysfs_pmu_core(const char *name)
> {
> char path[PATH_MAX];
> 
> if (!perf_pmu__pathname_scnprintf(path, sizeof(path), name, "cpus"))
> return 0;
> return file_available(path);
> }
> ...
> bool is_pmu_core(const char *name)
> {
> return !strcmp(name, "cpu") || is_sysfs_pmu_core(name);
> }
> '''
> 
> Thanks,
> Ian
> 

Maybe we should scan the directory

[linux-next]# ll /sys/bus/event_source/devices
total 0
lrwxrwxrwx 1 root root 0 Jun  2 15:11 cpum_cf -> ../../../devices/cpum_cf
lrwxrwxrwx 1 root root 0 Jun  2 15:11 cpum_cf_diag -> ../../../devices/cpum_cf_diag
lrwxrwxrwx 1 root root 0 Jun  2 15:11 cpum_sf -> ../../../devices/cpum_sf
lrwxrwxrwx 1 root root 0 Jun  2 15:11 kprobe -> ../../../devices/kprobe
lrwxrwxrwx 1 root root 0 Jun  2 15:11 software -> ../../../devices/software
lrwxrwxrwx 1 root root 0 Jun  2 15:11 tracepoint -> ../../../devices/tracepoint
lrwxrwxrwx 1 root root 0 Jun  2 15:11 uprobe -> ../../../devices/uprobe
[linux-next]#

This directory lists the PMUs available on s390, maybe this is true for
other platform...

Just me 2 cents
>> --
>> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
>> --
>> Vorsitzender des Aufsichtsrats: Gregor Pillen
>> Geschäftsführung: David Faller
>> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
>>

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

