Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF002C432BE
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Sep 2021 13:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FA1D610F7
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Sep 2021 13:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344882AbhIBNBI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344837AbhIBNBI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Sep 2021 09:01:08 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539F5C061575;
        Thu,  2 Sep 2021 06:00:10 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id g11so1397444qtk.5;
        Thu, 02 Sep 2021 06:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=x+AdKYfLS9gT5WYJ+/3I2JYeGx2UYT4j4GN/VwqgiDA=;
        b=o8414Dn50uOcxjeLrFnHQAKeFhImw3kIzv22tJEnODvDa4fPJD3olcX5TDLeLnLAhg
         PQ1Ins/gsDK1SPGH9FqkuZ1JgDsmEvhF3k00pXitjTZFBFRWznaCWuGgeiNe9jFq+7wz
         fBMQ1e4lVu7kWN5ONmYXJwKroZQQhuhX46yN6cGmJCWQ23k1r7UACscXIXspUnrD3hTi
         GuRpAPksxUtCy1ba43dpphMiuKe21O2Ak5xceFmDfNnXLCrCV+IINpIrYqjek7nSDRtA
         Np/ZZgnzmE8I5i1wHEU+5eD3bVFg5VsdJLyfg9G8NHPzMSaIFiRcZ2O0gI9VtOEKPUih
         x4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=x+AdKYfLS9gT5WYJ+/3I2JYeGx2UYT4j4GN/VwqgiDA=;
        b=VL81kyCL7+trCKZRQteNK30NSqUIrcKukDo/tn2wKt3ikekoYuJO3igexFwyxTiVn0
         TznhwoW/6+Q+J8ffgdd/EVVdcq+MLTUdQp8e4MI554vtvYxEAGDzxlpEL3lwvEch0Zv1
         w37YHNAy80K3t+yEYCpidonnB/g+dPUp9iRxuBHRw+u+MMZhhENaONI0043ZohjqfYYt
         En1CAM7FjcAWhKicFDEDAVBY22ieDhjkUYIa6SIxqhrtFyCMtM7B3wb1wEbYhctOglEg
         TJ+FVAlM/PhA2OQen1fouziuQXKKVDAC8MaDA7OUk7V3WxAZi3GpINICXgHlRlR0ZHBK
         UpUQ==
X-Gm-Message-State: AOAM530bGUC5MRqR5R6W0vCFS04ZdHxAnKjxDKncQWqABrLELUEQiW6K
        7MUX4tR/bOB6v1enZxfNFow=
X-Google-Smtp-Source: ABdhPJykUoUEFCgvE/svMKUSpLP7SjXCDNgcB2TOqzY49Ef641MRjV+dLI3R/t8ZvyYvWwiIFO99OQ==
X-Received: by 2002:ac8:7ca3:: with SMTP id z3mr2799229qtv.109.1630587609377;
        Thu, 02 Sep 2021 06:00:09 -0700 (PDT)
Received: from [127.0.0.1] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id t8sm977226qtn.37.2021.09.02.06.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 06:00:08 -0700 (PDT)
Date:   Thu, 02 Sep 2021 10:00:03 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     James Clark <james.clark@arm.com>, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
        mike.leach@linaro.org, suzuki.poulose@arm.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_perf_build=3A_Report_fa?= =?US-ASCII?Q?ilure_for_testing_feature_libopencsd?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20210902124529.GH303522@leoy-ThinkPad-X240s>
References: <20210902081800.550016-1-leo.yan@linaro.org> <YTDB/VuANx5c+5sk@kernel.org> <20210902124529.GH303522@leoy-ThinkPad-X240s>
Message-ID: <BBAFF70C-3E2B-4AFC-8229-857ED5BA15CC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On September 2, 2021 9:45:29 AM GMT-03:00, Leo Yan <leo=2Eyan@linaro=2Eorg=
> wrote:
>On Thu, Sep 02, 2021 at 09:22:21AM -0300, Arnaldo Carvalho de Melo wrote:
>> Em Thu, Sep 02, 2021 at 04:18:00PM +0800, Leo Yan escreveu:
>> > When build perf tool with passing option 'CORESIGHT=3D1' explicitly, =
if
>> > the feature test fails for library libopencsd, the build doesn't
>> > complain the feature failure and continue to build the tool with
>> > disabling the CoreSight feature insteadly=2E
>> >=20
>> > This patch changes the building behaviour, when build perf tool with =
the
>> > option 'CORESIGHT=3D1' and detect the failure for testing feature
>> > libopencsd, the build process will be aborted and it shows the compla=
int
>> > info=2E
>>=20
>> Thanks, added some committer notes to show that it now works:
>>=20
>> commit 8fb36b1f54873870262810d3db10526559e1d6c2
>> Author: Leo Yan <leo=2Eyan@linaro=2Eorg>
>> Date:   Thu Sep 2 16:18:00 2021 +0800
>>=20
>>     perf build: Report failure for testing feature libopencsd
>>    =20
>>     When build perf tool with passing option 'CORESIGHT=3D1' explicitly=
, if
>>     the feature test fails for library libopencsd, the build doesn't
>>     complain the feature failure and continue to build the tool with
>>     disabling the CoreSight feature insteadly=2E
>>    =20
>>     This patch changes the building behaviour, when build perf tool wit=
h the
>>     option 'CORESIGHT=3D1' and detect the failure for testing feature
>>     libopencsd, the build process will be aborted and it shows the comp=
laint
>>     info=2E
>>    =20
>>     Committer testing:
>>    =20
>>     First make sure there is no opencsd library installed:
>>    =20
>>       $ rpm -qa | grep -i csd
>>       $ sudo rm -rf `find /usr/local -name "*csd*"`
>>       $ find /usr/local -name "*csd*"
>>       $
>>    =20
>>     Then cleanup the perf build output directory:
>>    =20
>>       $ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf ;
>>       $
>>    =20
>>     And try to build explicitely asking for coresight:
>>    =20
>>       $ make O=3D/tmp/build/perf CORESIGHT=3D1 O=3D/tmp/build/perf -C t=
ools/perf install-bin
>
>The build command contains duplicate 'O=3D/tmp/build/perf'=2E

Oops, I'll fix it, thanks=2E

- Arnaldo

