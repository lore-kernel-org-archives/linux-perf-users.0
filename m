Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056A0C636D4
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Feb 2023 14:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjBOOR6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 15 Feb 2023 09:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjBOOR5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 15 Feb 2023 09:17:57 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BE672AF;
        Wed, 15 Feb 2023 06:17:54 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31FDrocF035155;
        Wed, 15 Feb 2023 14:17:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=voEzpcvPoD3i75m+WFihPdr7eLwJQAO64ETUDtcwZoQ=;
 b=KywEH7cxTfLUSLZRVz6e8z5s8Ag0UiU6RTeAplpLHh03/bOt0TAF8dv7FVczmx3bbgh0
 BqqbCtIFr/Nm7FE7p3QngK3R2cNH8fwBHaVTlhK02yXysw5pFL0ToeB12Ztoryaj7OoJ
 a/Tk7Vp97539vGWAPvzyAF8I4XIzeeulzQ4aRWAiLy6RTtgJkyCyB8joqjo9/H/g18yK
 KJRKn5g2exHUsBKIsPk6ZF6W3MZbZsYCW+4xOEfmJog+NpXTHAtRigOPHtMJgnsGyvkI
 dHWi1WOcMDfHDwwyrBYi7tv57fQ3my3Rvg/Rn8LaWrvRn1zxVOilJRCS2miGQE2USIU0 Ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ns0paguqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 14:17:50 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31FDs5h7038496;
        Wed, 15 Feb 2023 14:17:50 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ns0pagupp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 14:17:50 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31FCIsjv010856;
        Wed, 15 Feb 2023 14:17:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3np2n6wfat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 14:17:48 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31FEHjTf46203264
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 14:17:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0883A2004B;
        Wed, 15 Feb 2023 14:17:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D47F72004E;
        Wed, 15 Feb 2023 14:17:44 +0000 (GMT)
Received: from [9.152.212.251] (unknown [9.152.212.251])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 15 Feb 2023 14:17:44 +0000 (GMT)
Message-ID: <283ace48-0e69-08a4-cfd2-7bee5779c45c@linux.ibm.com>
Date:   Wed, 15 Feb 2023 15:17:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: PING Re: [PATCH] tools/perf: Fix perf tool build error in util/pfm.c
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     linux-kernel-next@vger.kernel.org,
        linux-perf-users@vger.kernel.org, hca@linux.ibm.com,
        egorenar@linux.ibm.com, gor@linux.ibm.com, svens@linux.ibm.com,
        sumanthk@linux.ibm.com
References: <20230207140447.1827741-1-tmricht@linux.ibm.com>
 <Y+JoGRdML/Ckkwvb@kernel.org>
 <CAP-5=fU6vHFp1YeY9RyAUE_rS5PMECcUWdnMhR-QsMnAN0wy7g@mail.gmail.com>
 <Y+OmaXOdMEM4II57@kernel.org> <Y+OnKl9wYcbFvHLY@kernel.org>
 <Y+Osp+SY+1WTHvwR@kernel.org>
Content-Language: en-US
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <Y+Osp+SY+1WTHvwR@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SexdZ0FXRQu3F4Ndnh7mcr6XF5TchCo0
X-Proofpoint-ORIG-GUID: iZenyeTkGhkdJPPsO-FVITHftRrM0YOV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_06,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150126
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 2/8/23 15:07, Arnaldo Carvalho de Melo wrote:
> Em Wed, Feb 08, 2023 at 10:44:10AM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Wed, Feb 08, 2023 at 10:40:57AM -0300, Arnaldo Carvalho de Melo escreveu:
>>> Em Tue, Feb 07, 2023 at 09:58:48PM -0800, Ian Rogers escreveu:
>>>> On Tue, Feb 7, 2023 at 7:02 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>>>>
>>>>> Em Tue, Feb 07, 2023 at 03:04:47PM +0100, Thomas Richter escreveu:
>>>>>> I have downloaded linux-next and build the perf tool using
>>>>>>
>>>>>>  # make LIBPFM4=1
>>>>>>
>>>>>> to have libpfm4 support built into perf. The build fails:
>>>>>>
>>>>>>  # make LIBPFM4=1
>>>>>
>>>>> Ian,
>>>>>
>>>>>         Can you please take a look? Should we go this way or have some
>>>>> feature test to check how that function signature should look?
>>>>>
>>>>> - Arnaldo
>>>>
>>>> Tested-by: Ian Rogers <irogers@google.com>
>>>>
>>>> Wrt tests, there is make_with_libpfm4 in tools/perf/tests/make.
> 
> I realized I hadn't libbpf-devel installed on the machine I run 'make -C
> tools/perf build-test' :-\ Fixed.
> 
> - Arnaldo
> 
>>> I meant if we should support older versions or state that to build with
>>> libbpf we need to have the version with this new signature.
>>
>> I see, the signature change wasn't in libpfm, nevermind, testing now.
>>
>> - Arnaldo
>>  
>>> I'll apply and test build it here.
>>>
>>> - Arnaldo
>>>  
>>>> Thanks,
>>>> Ian
>>>>
>>>>>> ....
>>>>>> INSTALL libbpf_headers
>>>>>>   CC      util/pfm.o
>>>>>> util/pfm.c: In function ‘print_libpfm_event’:
>>>>>> util/pfm.c:189:9: error: too many arguments to function ‘print_cb->print_event’
>>>>>>   189 |         print_cb->print_event(print_state,
>>>>>>       |         ^~~~~~~~
>>>>>> util/pfm.c:220:25: error: too many arguments to function ‘print_cb->print_event’
>>>>>>   220 |                         print_cb->print_event(print_state,
>>>>>>
>>>>>> The build error is caused by
>>>>>> commit d9dc8874d6ce ("perf pmu-events: Remove now unused event and metric variables")
>>>>>> which changes the function prototype of
>>>>>>   struct print_callbacks {
>>>>>>       ...
>>>>>>       void (*print_event)(...);  --> last two parameters removed.
>>>>>>   };
>>>>>>
>>>>>> but does not adjust the usage of this function prototype in util/pfm.c.
>>>>>> In file util/pfm.c function print_event() is still invoked with 13 parameters
>>>>>> instead of 11. The compile fails.
>>>>>>
>>>>>> When I adjust the file util/pfm.c as in this patch, the build works file.
>>>>>> Please check this patch for correctness, I have just fixed the compile
>>>>>> issue.
>>>>>>
>>>>>> Fixes d9dc8874d6ce ("perf pmu-events: Remove now unused event and metric variables")
>>>>>> Cc: irogers@google.com
>>>>>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>>>>>> ---
>>>>>>  tools/perf/util/pfm.c | 6 ++----
>>>>>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
>>>>>> index ac3227ba769c..b59ba825ddc9 100644
>>>>>> --- a/tools/perf/util/pfm.c
>>>>>> +++ b/tools/perf/util/pfm.c
>>>>>> @@ -193,8 +193,7 @@ print_libpfm_event(const struct print_callbacks *print_cb, void *print_state,
>>>>>>                       /*scale_unit=*/NULL,
>>>>>>                       /*deprecated=*/NULL, "PFM event",
>>>>>>                       info->desc, /*long_desc=*/NULL,
>>>>>> -                     /*encoding_desc=*/buf->buf,
>>>>>> -                     /*metric_name=*/NULL, /*metric_expr=*/NULL);
>>>>>> +                     /*encoding_desc=*/buf->buf);
>>>>>>
>>>>>>       pfm_for_each_event_attr(j, info) {
>>>>>>               pfm_event_attr_info_t ainfo;
>>>>>> @@ -224,8 +223,7 @@ print_libpfm_event(const struct print_callbacks *print_cb, void *print_state,
>>>>>>                                       /*scale_unit=*/NULL,
>>>>>>                                       /*deprecated=*/NULL, "PFM event",
>>>>>>                                       ainfo.desc, /*long_desc=*/NULL,
>>>>>> -                                     /*encoding_desc=*/buf->buf,
>>>>>> -                                     /*metric_name=*/NULL, /*metric_expr=*/NULL);
>>>>>> +                                     /*encoding_desc=*/buf->buf);
>>>>>>               }
>>>>>>       }
>>>>>>  }
>>>>>> --
>>>>>> 2.39.1
>>>>>>
>>>>>
>>>>> --
>>>>>
>>>>> - Arnaldo
>>>
>>> -- 
>>>
>>> - Arnaldo
>>
>> -- 
>>
>> - Arnaldo
> 

Friendly ping, is this already in linux-next?

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

