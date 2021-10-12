Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D93C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Oct 2021 20:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7082A60E09
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Oct 2021 20:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbhJLUTT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 12 Oct 2021 16:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbhJLUTT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Oct 2021 16:19:19 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17800C061570;
        Tue, 12 Oct 2021 13:17:17 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id g14so449434qvb.0;
        Tue, 12 Oct 2021 13:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=AsXbmarxWkJpKdLA7U66Uwg/RAUVX+W6cx4F/gDRsoQ=;
        b=qCJPV5MC+j5OV3TNK5iScaVkSgPBxl70WGAU6+mkFLHOerCF5EelZ/GZJR2qzBoK6w
         k314Kv1Up4sA5uObdP1YiR2VqECBzlm2dVxvqBoTDZNAyNV30Jm7+cQBdf2BwpQu8RIF
         wbhokj4dcBLOQKd3rmbOR/v/lzOl4GARX5NgwStQd5h54XemLMiqVDiSrogK8QBTfjpj
         skZRgsT+/MfMF/GKl0ODLk1YTtH4Hbd6W0900vr7AiiWrAbwVvPgaYSyIojejCTwkjo5
         o0Ao+aYbJ7cRwzh0I3nF7DEEynqCKwGbmWwTGoJvB8qvLrNpHKgk/xGbowkmIpairGUD
         C7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=AsXbmarxWkJpKdLA7U66Uwg/RAUVX+W6cx4F/gDRsoQ=;
        b=lmB5gymlolqS0XFyKoDH9GtvZv903eJbXxqfprMBRruF6vkHqdehVnl8kB9tqHBhc7
         6SOtf90T5Tvv+ZOSpC4nA2r55rZoLM1qsTtyiXg/H05YOZNjybJKIy581eCqaz/C7uPd
         Y3ONRe6u2gXZ0XPPXu/tePqYaaaDNiYjmWsDx/t3awWXPU2dT519gb+gooB65pEDwlAz
         iKR0cWbskEhnGsoCALZwQBYsZLjX2cwDlamnD9JTNWunI0zY6djW+b7TeAEmykg8fopm
         KPoNvRfuZXrvRqAGpPuIDKdSAA5BoNaJnOPzFX5fJX0/ICKOVXmNjwrNC7hA3WdGGzj7
         mqcA==
X-Gm-Message-State: AOAM532262RXnvh7kTsHcwwq6y9x07NWKNBiBvGKPJhCzA+2ncMnMI8v
        cO+TQrbqN1jF+5OWF7zzKv3ROqyVzgU=
X-Google-Smtp-Source: ABdhPJwosUDIDFfx35/I5EOPY8RSsLnjuBfSkHAmaUxoQNU21uI3iau4Ej4G0BoBSmtN7Ai775V3fA==
X-Received: by 2002:a0c:90c4:: with SMTP id p62mr32895820qvp.50.1634069836165;
        Tue, 12 Oct 2021 13:17:16 -0700 (PDT)
Received: from [127.0.0.1] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id m66sm4536315qkb.87.2021.10.12.13.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 13:17:15 -0700 (PDT)
Date:   Tue, 12 Oct 2021 17:15:02 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        kajoljain <kjain@linux.ibm.com>
CC:     john.garry@huawei.com, ak@linux.intel.com,
        linux-perf-users@vger.kernel.org, Nick.Forrington@arm.com,
        Andrew.Kilroy@arm.com, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] perf tools: Enable strict JSON parsing
User-Agent: K-9 Mail for Android
In-Reply-To: <0d73d04f-925c-4c97-9a07-18cc64a9c68b@arm.com>
References: <20211007110543.564963-1-james.clark@arm.com> <c15fd2bf-104e-6ab0-6496-7e5cf77a218f@linux.ibm.com> <e8752b2d-65a7-1ed8-3c68-30d9006261ba@arm.com> <5947c093-cff9-f70e-af20-75bc053edf5f@linux.ibm.com> <YWCVTnOUM2P4FRPi@kernel.org> <0d73d04f-925c-4c97-9a07-18cc64a9c68b@arm.com>
Message-ID: <5DAE78A9-A1A8-48B9-B5A6-35172C3A2BC8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On October 12, 2021 10:30:51 AM GMT-03:00, James Clark <james=2Eclark@arm=
=2Ecom> wrote:
>
>
>On 08/10/2021 20:00, Arnaldo Carvalho de Melo wrote:
>> Em Fri, Oct 08, 2021 at 04:56:55PM +0530, kajoljain escreveu:
>>>
>>>
>>> On 10/8/21 3:32 PM, James Clark wrote:
>>>>
>>>>
>>>> On 08/10/2021 08:43, kajoljain wrote:
>>>>>
>>>>>
>>>>> On 10/7/21 4:35 PM, James Clark wrote:
>>>>>> After a discussion on "[PATCH 1/4] perf vendor events: Syntax corre=
ctions in Neoverse N1 json",
>>>>>> John Garry suggested that we can just modify the parser to make it =
more strict=2E Hopefully this will
>>>>>> remove the need to apply any future JSON comma fixup commits=2E
>>>>>>
>>>>>> Applies on top of "[PATCH v2 1/3] perf vendor events: Syntax correc=
tions in Neoverse N1 json" on
>>>>>> perf/core=2E
>>>>>>
>>>>>> Also available at:
>>>>>>   git clone --branch james-json-parse-fix git@git=2Egitlab=2Earm=2E=
com:linux-arm/linux-jc=2Egit
>>>>>
>>>>> Hi James,
>>>>>    Do we have any dependency patches on top of this patch series=2E =
I am
>>>>> reviewing and testing it, but in both powerpc and x86 system I am
>>>>> getting build issue=2E Not sure if I am missing something>=20
>>>>> I am trying your changes on top of upstream perf=2E
>>>>>
>>>>> pmu-events/arch/test/test_soc/sys/uncore=2Ejson: json error Invalid
>>>>> character inside JSON string
>>>>
>>>> Hi Kajol,
>>>>
>>>> A trailing comma was fixed in this file 3 weeks ago at b8b350a=2E Can=
 you
>>>> confirm if you have updated to get this commit on perf core?
>>>>
>>>> Alternately you could pull from my branch above which is up to date e=
nough
>>>> to include it=2E
>>>
>>> Hi James,
>>>    Thanks for pointing it=2E Not getting build issue now=2E
>>>>
>>>> The file is in pmu-events/arch/test/ so I would expect it to fail on =
all platforms=2E
>>>>
>>>>> make[3]: *** [pmu-events/Build:18: pmu-events/pmu-events=2Ec] Error =
1
>>>>> make[3]: *** Deleting file 'pmu-events/pmu-events=2Ec'
>>>>> make[2]: *** [Makefile=2Eperf:667: pmu-events/pmu-events-in=2Eo] Err=
or 2
>>>>> make[2]: *** Waiting for unfinished jobs=2E=2E=2E=2E
>>>>> make[1]: *** [Makefile=2Eperf:238: sub-make] Error 2
>>>>> make: *** [Makefile:70: all] Error 2
>>>>>
>>>>> Also, Is it possible to add line number along with file name while
>>>>> showing this error `json error Invalid character inside JSON string`=
=2E
>>>>> It might make it easy to fix=2E
>>>>
>>>> I can add a character number with the following fix if you think that=
 would
>>>> be good enough? A line number might be a bigger change and involve ke=
eping
>>>> track of newline characters=2E
>>>
>>> Sure=2E I think then we can skip this change=2E Not sure if character
>>> number will be helpful=2E
>>>
>>> Patch-set looks good to me=2E
>>>
>>> Reviewed-by Kajol Jain<kjain@linux=2Eibm=2Ecom>
>>=20
>> Applied ok as-is to my perf/core branch, applied and added your
>> Reviewed-by, thanks=2E
>>=20
>
>Thanks Arnaldo=2E This does mean that the arm64 build will fail until
>"[PATCH v2 1/3] perf vendor events: Syntax corrections in Neoverse N1 jso=
n" is
>applied=2E I think there is also an arm64 build issue with "[PATCH 02/21]=
 perf
>pmu: Add const to pmu_events_map=2E" which Andrew Kilroy has replied to=
=2E
>

Ok, this will hopefully change tomorrow after today's Brazilian holiday wh=
en I get to process that series,

Thanks,

- Arnaldo
