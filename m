Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEB7C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Jul 2022 20:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiGFU01 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Jul 2022 16:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiGFU01 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Jul 2022 16:26:27 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE451705C
        for <linux-perf-users@vger.kernel.org>; Wed,  6 Jul 2022 13:26:25 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b26so23599726wrc.2
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Jul 2022 13:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pd/cz1ZdOZDG0dGUCc56UGlwZRbZux/IHLKbAzN98Js=;
        b=LO0ddP6IpeapDsidsXkOEyQ+saT7ncixARK9nt1HA3oZyERRJd0FQIIojqRBKqfaFz
         +XAcZ/GkXc3ZoXDRmqbwdZr1aEGsNnJtxJDN6nCxM3+mS5+gJPJY3WiIHUVlHcEmCo6h
         bGqElsZBwf6tPPCxLXYqPk0Ck2d1yig7FYAo2XTcWBNBcT2YYh/w9HGa3R2LMILBmZl5
         HdANoc64OsBGuwzVhgklcWy1Q9fF9ay/YNUaTVkTTswIPjotbWfiRKD/knMEqTkodlVa
         3Hraa3O9LLAv2Y76IEP8SWpKXcTJ3WIX9jaAe1FCAiRiOHP8Uxm0VNG0Udp0FIflMYFi
         sHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pd/cz1ZdOZDG0dGUCc56UGlwZRbZux/IHLKbAzN98Js=;
        b=LMmNpV5rrfbm8qdKVmeSb3Zvd5h+QPubgSJfMQMiQTqDefug6aydZyRH1OIZFt7kgh
         ebWS4ULsiIPa0RxRjVOb+LiA6mjRxNOt6FpVK2V9skTRyHF51s96wK5g8dx2erGegtl9
         trs8HNfhHfHFrs0jQuGZ82MkaMKDHwSd0JaBcPjQPTELyuqr5vdWh1GRh3Gv6gQsTIGg
         9rMmxylsBzQlTpa5rAj2pl+S4k6KrGw65gDet/EUayKB4td+qvWva8RbBvJy42C/l6/V
         jRjHH9LpxUEoB+zcA3JaKnCYdkBUAKHnje8C0ce7e8M9zY3ADYYCIQbyAq60SDy6nEGn
         UnXw==
X-Gm-Message-State: AJIora/aN4rSO0GBHg6ckeqsJrTkqdCu6EgizFSf6eNFMivoxDsE7l1m
        JrzB77g7XB1kk92mH3PK/LjNNL00LnCXqotCcB7vsw==
X-Google-Smtp-Source: AGRyM1sNVUzqOT1mNnsuofu3XsFHxkgXs0ehkhiv3SeOIcmUkR73MU7bT2mshl83m+mxZRZwlMqFJSMZpSlgzKEnHTM=
X-Received: by 2002:a05:6000:8e:b0:21d:7e97:67ed with SMTP id
 m14-20020a056000008e00b0021d7e9767edmr4443868wrx.343.1657139183331; Wed, 06
 Jul 2022 13:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <d1ff3c27-e248-56ff-89b8-7b75c0f817ba@gmail.com>
In-Reply-To: <d1ff3c27-e248-56ff-89b8-7b75c0f817ba@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 6 Jul 2022 13:26:10 -0700
Message-ID: <CAP-5=fW+g85Mh19DdBPGKMzs+VMzEjhVvUX4R-5D+SZ2zpLuow@mail.gmail.com>
Subject: Re: [GIT PULL] tools/perf/pmu-events: Fix some typo (2022-07-05
 05:10:43 +0900)
To:     hayashizaki.masayuki@gmail.com, perfmon-discuss@lists.01.org
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jul 5, 2022 at 1:09 AM Hayashizaki Masayuki
<hayashizaki.masayuki@gmail.com> wrote:
>
> Hello:
>
> I sent a pull request. Please review and merge.
>
> Reason:
> Fix some typo.
>
> Git repository URL:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>
> Branch name:
> pmu-events-fixes-5.19-5
>
> Pull request log:
> git request-pull origin/master pmu-events-fixes-5.19-5
> fatal: 'pmu-events-fixes-5.19-5' does not appear to be a git repository
> fatal: Could not read from remote repository.
>
> Please make sure you have the correct access rights
> and the repository exists.
> warn: No match for commit 2a3f9ec126ba4bb036b638ede6794c3ce313c6c4 found
> at pmu-events-fixes-5.19-5
> warn: Are you sure you pushed 'HEAD' there?
> The following changes since commit c1084b6c5620a743f86947caca66d90f24060f56:
>
>    Merge tag 'soc-fixes-5.19-2' of
> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc (2022-07-04
> 10:41:59 -0700)
>
> are available in the Git repository at:
>
>    pmu-events-fixes-5.19-5
>
> for you to fetch changes up to 2a3f9ec126ba4bb036b638ede6794c3ce313c6c4:
>
>    tools/perf/pmu-events: Fix some typo (2022-07-05 05:10:43 +0900)
>
> ----------------------------------------------------------------
> Hayashizaki Masayuki (1):
>        tools/perf/pmu-events: Fix some typo
>
>   tools/perf/pmu-events/arch/x86/broadwell/pipeline.json   | 10 +++++-----
>   tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json | 10 +++++-----
>   tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json  | 10 +++++-----
>   tools/perf/pmu-events/arch/x86/haswell/pipeline.json     | 10 +++++-----
>   tools/perf/pmu-events/arch/x86/haswellx/pipeline.json    | 10 +++++-----
>   5 files changed, 25 insertions(+), 25 deletions(-)

These files are generated from json files here:
https://download.01.org/perfmon/
Using scripts here:
https://github.com/intel/event-converter-for-linux-perf
Fixing the spelling in the Linux tree will mean future updates will
need to manually also fix the spelling, it is better we fix the
spelling in the files on 01.org. I've added
perfmon-discuss@lists.01.org in the to-s of this e-mail, so hopefully
the files will be revised in the next 01.org update.

Thanks,
Ian

> Diff:
> diff --git a/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
> b/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
> index 18d21b94a4b9..23e0c3fadc53 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
> @@ -1133,7 +1133,7 @@
>       },
>       {
>           "AnyThread": "1",
> -        "BriefDescription": "Cycles per core when uops are exectuted in
> port 0.",
> +        "BriefDescription": "Cycles per core when uops are executed in
> port 0.",
>           "Counter": "0,1,2,3",
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
> @@ -1153,7 +1153,7 @@
>       },
>       {
>           "AnyThread": "1",
> -        "BriefDescription": "Cycles per core when uops are exectuted in
> port 1.",
> +        "BriefDescription": "Cycles per core when uops are executed in
> port 1.",
>           "Counter": "0,1,2,3",
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
> @@ -1213,7 +1213,7 @@
>       },
>       {
>           "AnyThread": "1",
> -        "BriefDescription": "Cycles per core when uops are exectuted in
> port 4.",
> +        "BriefDescription": "Cycles per core when uops are executed in
> port 4.",
>           "Counter": "0,1,2,3",
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
> @@ -1233,7 +1233,7 @@
>       },
>       {
>           "AnyThread": "1",
> -        "BriefDescription": "Cycles per core when uops are exectuted in
> port 5.",
> +        "BriefDescription": "Cycles per core when uops are executed in
> port 5.",
>           "Counter": "0,1,2,3",
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
> @@ -1253,7 +1253,7 @@
>       },
>       {
>           "AnyThread": "1",
> -        "BriefDescription": "Cycles per core when uops are exectuted in
> port 6.",
> +        "BriefDescription": "Cycles per core when uops are executed in
> port 6.",
>           "Counter": "0,1,2,3",
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
> b/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
> index 7580b8af0d13..b67eba679844 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
> @@ -1133,7 +1133,7 @@
>       },
>       {
>           "AnyThread": "1",
> -        "BriefDescription": "Cycles per core when uops are exectuted in
> port 0.",
> +        "BriefDescription": "Cycles per core when uops are executed in
> port 0.",
>           "Counter": "0,1,2,3",
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
> @@ -1153,7 +1153,7 @@
>       },
>       {
>           "AnyThread": "1",
> -        "BriefDescription": "Cycles per core when uops are exectuted in
> port 1.",
> +        "BriefDescription": "Cycles per core when uops are executed in
> port 1.",
>           "Counter": "0,1,2,3",
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
> @@ -1213,7 +1213,7 @@
>       },
>       {
>           "AnyThread": "1",
> -        "BriefDescription": "Cycles per core when uops are exectuted in
> port 4.",
> +        "BriefDescription": "Cycles per core when uops are executed in
> port 4.",
>           "Counter": "0,1,2,3",
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
> @@ -1233,7 +1233,7 @@
>       },
>       {
>           "AnyThread": "1",
> -        "BriefDescription": "Cycles per core when uops are exectuted in
> port 5.",
> +        "BriefDescription": "Cycles per core when uops are executed in
> port 5.",
>           "Counter": "0,1,2,3",
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
> @@ -1253,7 +1253,7 @@
>       },
>       {
>           "AnyThread": "1",
> -        "BriefDescription": "Cycles per core when uops are exectuted in
> port 6.",
> +        "BriefDescription": "Cycles per core when uops are executed in
> port 6.",
>           "Counter": "0,1,2,3",
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
> b/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
> index 18d21b94a4b9..23e0c3fadc53 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
> @@ -1133,7 +1133,7 @@
>       },
>       {
>           "AnyThread": "1",
> -        "BriefDescription": "Cycles per core when uops are exectuted in
> port 0.",
> +        "BriefDescription": "Cycles per core when uops are executed in
> port 0.",
>           "Counter": "0,1,2,3",
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
> @@ -1153,7 +1153,7 @@
>       },
>       {
>           "AnyThread": "1",
> -        "BriefDescription": "Cycles per core when uops are exectuted in
> port 1.",
> +        "BriefDescription": "Cycles per core when uops are executed in
> port 1.",
>           "Counter": "0,1,2,3",
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
> @@ -1213,7 +1213,7 @@
>       },
>       {
>           "AnyThread": "1",
> -        "BriefDescription": "Cycles per core when uops are exectuted in
> port 4.",
> +        "BriefDescription": "Cycles per core when uops are executed in
> port 4.",
>           "Counter": "0,1,2,3",
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
> @@ -1233,7 +1233,7 @@
>       },
>       {
>           "AnyThread": "1",
> -        "BriefDescription": "Cycles per core when uops are exectuted in
> port 5.",
> +        "BriefDescription": "Cycles per core when uops are executed in
> port 5.",
>           "Counter": "0,1,2,3",
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
> @@ -1253,7 +1253,7 @@
>       },
>       {
>           "AnyThread": "1",
> -        "BriefDescription": "Cycles per core when uops are exectuted in
> port 6.",
> +        "BriefDescription": "Cycles per core when uops are executed in
> port 6.",
>           "Counter": "0,1,2,3",
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
> diff --git a/tools/perf/pmu-events/arch/x86/haswell/pipeline.json
> b/tools/perf/pmu-events/arch/x86/haswell/pipeline.json
> index a53f28ec9270..06fbe7d34a8c 100644
> --- a/tools/perf/pmu-events/arch/x86/haswell/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/haswell/pipeline.json
> @@ -1035,7 +1035,7 @@
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
>           "EventName": "UOPS_EXECUTED_PORT.PORT_0_CORE",
> -        "PublicDescription": "Cycles per core when uops are exectuted
> in port 0.",
> +        "PublicDescription": "Cycles per core when uops are executed in
> port 0.",
>           "SampleAfterValue": "2000003",
>           "UMask": "0x1"
>       },
> @@ -1056,7 +1056,7 @@
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
>           "EventName": "UOPS_EXECUTED_PORT.PORT_1_CORE",
> -        "PublicDescription": "Cycles per core when uops are exectuted
> in port 1.",
> +        "PublicDescription": "Cycles per core when uops are executed in
> port 1.",
>           "SampleAfterValue": "2000003",
>           "UMask": "0x2"
>       },
> @@ -1117,7 +1117,7 @@
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
>           "EventName": "UOPS_EXECUTED_PORT.PORT_4_CORE",
> -        "PublicDescription": "Cycles per core when uops are exectuted
> in port 4.",
> +        "PublicDescription": "Cycles per core when uops are executed in
> port 4.",
>           "SampleAfterValue": "2000003",
>           "UMask": "0x10"
>       },
> @@ -1138,7 +1138,7 @@
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
>           "EventName": "UOPS_EXECUTED_PORT.PORT_5_CORE",
> -        "PublicDescription": "Cycles per core when uops are exectuted
> in port 5.",
> +        "PublicDescription": "Cycles per core when uops are executed in
> port 5.",
>           "SampleAfterValue": "2000003",
>           "UMask": "0x20"
>       },
> @@ -1159,7 +1159,7 @@
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
>           "EventName": "UOPS_EXECUTED_PORT.PORT_6_CORE",
> -        "PublicDescription": "Cycles per core when uops are exectuted
> in port 6.",
> +        "PublicDescription": "Cycles per core when uops are executed in
> port 6.",
>           "SampleAfterValue": "2000003",
>           "UMask": "0x40"
>       },
> diff --git a/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json
> b/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json
> index a53f28ec9270..06fbe7d34a8c 100644
> --- a/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json
> @@ -1035,7 +1035,7 @@
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
>           "EventName": "UOPS_EXECUTED_PORT.PORT_0_CORE",
> -        "PublicDescription": "Cycles per core when uops are exectuted
> in port 0.",
> +        "PublicDescription": "Cycles per core when uops are executed in
> port 0.",
>           "SampleAfterValue": "2000003",
>           "UMask": "0x1"
>       },
> @@ -1056,7 +1056,7 @@
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
>           "EventName": "UOPS_EXECUTED_PORT.PORT_1_CORE",
> -        "PublicDescription": "Cycles per core when uops are exectuted
> in port 1.",
> +        "PublicDescription": "Cycles per core when uops are executed in
> port 1.",
>           "SampleAfterValue": "2000003",
>           "UMask": "0x2"
>       },
> @@ -1117,7 +1117,7 @@
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
>           "EventName": "UOPS_EXECUTED_PORT.PORT_4_CORE",
> -        "PublicDescription": "Cycles per core when uops are exectuted
> in port 4.",
> +        "PublicDescription": "Cycles per core when uops are executed in
> port 4.",
>           "SampleAfterValue": "2000003",
>           "UMask": "0x10"
>       },
> @@ -1138,7 +1138,7 @@
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
>           "EventName": "UOPS_EXECUTED_PORT.PORT_5_CORE",
> -        "PublicDescription": "Cycles per core when uops are exectuted
> in port 5.",
> +        "PublicDescription": "Cycles per core when uops are executed in
> port 5.",
>           "SampleAfterValue": "2000003",
>           "UMask": "0x20"
>       },
> @@ -1159,7 +1159,7 @@
>           "CounterHTOff": "0,1,2,3,4,5,6,7",
>           "EventCode": "0xA1",
>           "EventName": "UOPS_EXECUTED_PORT.PORT_6_CORE",
> -        "PublicDescription": "Cycles per core when uops are exectuted
> in port 6.",
> +        "PublicDescription": "Cycles per core when uops are executed in
> port 6.",
>           "SampleAfterValue": "2000003",
>           "UMask": "0x40"
>       },
> --
> Hayashizaki Masayuki
> hayashizaki.masayuki@gmail.com
> AkariSpetification / Developer
> https://akari.mn
