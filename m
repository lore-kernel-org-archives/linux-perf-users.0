Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78681C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 11:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60C7B61038
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 11:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240266AbhJHL3S (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 8 Oct 2021 07:29:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31126 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240181AbhJHL3R (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Oct 2021 07:29:17 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 198Aujvc004440;
        Fri, 8 Oct 2021 07:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Z6iNOBuN2FiL+wPDKSDlFrt+6ZdK+ASaynt4w5R0G5Y=;
 b=XqAhLniD0RFUrcb9AWMzeuun0yzD0V3wnvMwkf1qSuudC7xN6ZuQ19A0f8GcgqcKIBiO
 ExwgpaPIIwc1Se6GDOMSi+RRK4mDSy+mH2xGZ5xrTTH7U63R3ZQdsoKItUkX3dQQK2Mf
 0L2zp3NFVGDZ+OmwU/sjloxH0iuR9N03qrlSLIwBtizwCRzs/o2k92xsMM4fOLm00YGv
 oLleqZTy3hkDRM3qIjkTf8HTtmGbEmwKRyMqZ3XPFgJVDDEhHAHIxjl3kTljkEJH2W5V
 w1w95KTrOXcp296mNAzqeCCmYJ4ySrynbzc2g8SHSzAuaHiO8HXv1gqShmds3zNj/ed/ Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bja72ek72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 07:27:08 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 198BJ3hu025751;
        Fri, 8 Oct 2021 07:27:08 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bja72ek6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 07:27:07 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 198BIExR005006;
        Fri, 8 Oct 2021 11:27:05 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3bhepdate7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 11:27:05 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 198BLaKJ50987410
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Oct 2021 11:21:36 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7710211C06F;
        Fri,  8 Oct 2021 11:27:02 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CFD811C052;
        Fri,  8 Oct 2021 11:26:57 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com (unknown [9.43.64.167])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Oct 2021 11:26:56 +0000 (GMT)
Subject: Re: [PATCH 0/3] perf tools: Enable strict JSON parsing
To:     James Clark <james.clark@arm.com>, acme@kernel.org,
        john.garry@huawei.com, ak@linux.intel.com,
        linux-perf-users@vger.kernel.org
Cc:     Nick.Forrington@arm.com, Andrew.Kilroy@arm.com,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211007110543.564963-1-james.clark@arm.com>
 <c15fd2bf-104e-6ab0-6496-7e5cf77a218f@linux.ibm.com>
 <e8752b2d-65a7-1ed8-3c68-30d9006261ba@arm.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <5947c093-cff9-f70e-af20-75bc053edf5f@linux.ibm.com>
Date:   Fri, 8 Oct 2021 16:56:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <e8752b2d-65a7-1ed8-3c68-30d9006261ba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lOyymgxK9TpeCR6DU1tsiTS3sJOTLMp1
X-Proofpoint-ORIG-GUID: 8XX2XOnAHR5CiyG80ROVwRoe4lak9Nb6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-08_03,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110080065
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 10/8/21 3:32 PM, James Clark wrote:
> 
> 
> On 08/10/2021 08:43, kajoljain wrote:
>>
>>
>> On 10/7/21 4:35 PM, James Clark wrote:
>>> After a discussion on "[PATCH 1/4] perf vendor events: Syntax corrections in Neoverse N1 json",
>>> John Garry suggested that we can just modify the parser to make it more strict. Hopefully this will
>>> remove the need to apply any future JSON comma fixup commits.
>>>
>>> Applies on top of "[PATCH v2 1/3] perf vendor events: Syntax corrections in Neoverse N1 json" on
>>> perf/core.
>>>
>>> Also available at:
>>>   git clone --branch james-json-parse-fix git@git.gitlab.arm.com:linux-arm/linux-jc.git
>>
>> Hi James,
>>    Do we have any dependency patches on top of this patch series. I am
>> reviewing and testing it, but in both powerpc and x86 system I am
>> getting build issue. Not sure if I am missing something> 
>> I am trying your changes on top of upstream perf.
>>
>> pmu-events/arch/test/test_soc/sys/uncore.json: json error Invalid
>> character inside JSON string
> 
> Hi Kajol,
> 
> A trailing comma was fixed in this file 3 weeks ago at b8b350a. Can you
> confirm if you have updated to get this commit on perf core?
> 
> Alternately you could pull from my branch above which is up to date enough
> to include it.

Hi James,
   Thanks for pointing it. Not getting build issue now.
> 
> The file is in pmu-events/arch/test/ so I would expect it to fail on all platforms.
> 
>> make[3]: *** [pmu-events/Build:18: pmu-events/pmu-events.c] Error 1
>> make[3]: *** Deleting file 'pmu-events/pmu-events.c'
>> make[2]: *** [Makefile.perf:667: pmu-events/pmu-events-in.o] Error 2
>> make[2]: *** Waiting for unfinished jobs....
>> make[1]: *** [Makefile.perf:238: sub-make] Error 2
>> make: *** [Makefile:70: all] Error 2
>>
>> Also, Is it possible to add line number along with file name while
>> showing this error `json error Invalid character inside JSON string`.
>> It might make it easy to fix.
> 
> I can add a character number with the following fix if you think that would
> be good enough? A line number might be a bigger change and involve keeping
> track of newline characters.

Sure. I think then we can skip this change. Not sure if character
number will be helpful.

Patch-set looks good to me.

Reviewed-by Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain

> 
> diff --git a/tools/perf/pmu-events/json.c b/tools/perf/pmu-events/json.c
> index 0544398d6e2d..41a14e1543bf 100644
> --- a/tools/perf/pmu-events/json.c
> +++ b/tools/perf/pmu-events/json.c
> @@ -99,7 +99,7 @@ jsmntok_t *parse_json(const char *fn, char **map, size_t *size, int *len)
>         res = jsmn_parse(&parser, *map, *size, tokens,
>                          sz / sizeof(jsmntok_t));
>         if (res != JSMN_SUCCESS) {
> -               pr_err("%s: json error %s\n", fn, jsmn_strerror(res));
> +               pr_err("%s: json error at character %u '%s'\n", fn, parser.pos, jsmn_strerror(res));
>                 goto error_free;
>         }
>         if (len)
> 
> 
> It prints this for the same error you have above>
> pmu-events/arch/test/test_soc/sys/uncore.json: json error at character 213 'Invalid character inside JSON string'
> 
> Although funnily enough after re-introducing that extra comma it doesn't fail the build for me,
> it just prints the error message. But I may have noticed some dependency tracking issues around
> the json files.
> 
> James
> 
