Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206CEC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 00:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE305610CB
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 00:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhJTAhd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Oct 2021 20:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhJTAhd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Oct 2021 20:37:33 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0921C06161C;
        Tue, 19 Oct 2021 17:35:19 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id h4so3533710uaw.1;
        Tue, 19 Oct 2021 17:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=DBHktv6tWnHaAPhvn/ATHNr/sBbAryr3v0f/Ync7WK0=;
        b=a3rUdqTZqUyD0z9UFNRkvnwBUK3seVDZfsy5S9vUFigOsHNLRQJliep0ocNoGq0O7S
         1gxnUtcVrC6foGEr107JoDmJf9gmtaaEMxWY+8ppIfzuY4aEw7Jzva2TX173tyQIQS6r
         2b5xA9/OLAkGEzMuFmvf8ADZA9XOPCKkIkxpeaBGdabYhjRZO2PNOV9wJeIQAYSylLrF
         qxGxOvmfmknh2STXs1mTsi9F8hU7RQen2TQLM6m7KNvXFHh6AjGfWKDEubQt4vSM/YxA
         F06B7qaQ1+9R61F9AmEMIK6KljwCjETvqNGA64p/FOD6H6EQql8jhVH/8m+AF2IwT8X9
         AG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=DBHktv6tWnHaAPhvn/ATHNr/sBbAryr3v0f/Ync7WK0=;
        b=D8Tarsl8rik/HO6naH8QNHQSUSFResxsaSszGZs+JWABmzFK9MYc7SZjiAjuj6l5Yx
         5gYihlsG+vUV9llnMaDsg64vmd/VQi7BzywfqtLfDurGFDIBf0hJFXHgW/4j3WnCz2rH
         U798ITnJJ0y5d+wpCyI5yDLxxhP0yx51i4ddFudFdS45g3cSayyYTWy2DE/uVAEUvpwB
         u6amIqxxUxtaE0ThfKI4UIoY+o3e/+T6GE9MoNxTbd7HnVr0JTxTPSI6HLFaMnyqKG+F
         Zy0D0AeqP/fHG74UrAHkUGpxRrn/gxEFCEQc6HlvZpspsgVNNSOK0yhC2PPDy2yYCHbH
         7oAA==
X-Gm-Message-State: AOAM533D3ok/Us/PabG/YnTYn08FiSBwLdPY5vUx4Qs4wzsYiVVuYcaX
        p+xoyBzQu8uEUxh0nyctph8=
X-Google-Smtp-Source: ABdhPJxLODS6k7EC06EcKK6jcvxgoUCnQC4eAkckdg3hP9PCABAJjJ9ODygIo5ainHAwKYgKSvJE7w==
X-Received: by 2002:a67:e0c2:: with SMTP id m2mr39976209vsl.2.1634690118818;
        Tue, 19 Oct 2021 17:35:18 -0700 (PDT)
Received: from [127.0.0.1] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id w128sm420145vka.27.2021.10.19.17.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 17:35:18 -0700 (PDT)
Date:   Tue, 19 Oct 2021 21:35:13 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        ToastC <mrtoastcheng@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Felix Fietkau <nbd@nbd.name>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Song Liu <songliubraving@fb.com>, Fabian Hemmer <copy@copy.sh>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Nicholas Fraser <nfraser@codeweavers.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Denys Zagorui <dzagorui@cisco.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 21/21] perf metric: Allow modifiers on metrics.
User-Agent: K-9 Mail for Android
In-Reply-To: <CAP-5=fV85eOA5_vpaNSx5M8thSVvoiF+tzDmYe83TPF7Hk+0vA@mail.gmail.com>
References: <20211015172132.1162559-1-irogers@google.com> <20211015172132.1162559-22-irogers@google.com> <YW7e6OvE/juYY8it@kernel.org> <YW7gsEDXBw1jk65o@kernel.org> <YW7hdvJ8eHS/jlgx@kernel.org> <YW7htMxwcNjZOtJH@kernel.org> <CAP-5=fV85eOA5_vpaNSx5M8thSVvoiF+tzDmYe83TPF7Hk+0vA@mail.gmail.com>
Message-ID: <C9460490-184C-4BFD-BD89-063C77F17344@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On October 19, 2021 5:00:23 PM GMT-03:00, Ian Rogers <irogers@google=2Ecom=
> wrote:
>On Tue, Oct 19, 2021 at 8:18 AM Arnaldo Carvalho de Melo
><acme@kernel=2Eorg> wrote:
>>
>> Em Tue, Oct 19, 2021 at 12:17:10PM -0300, Arnaldo Carvalho de Melo escr=
eveu:
>> > Em Tue, Oct 19, 2021 at 12:13:52PM -0300, Arnaldo Carvalho de Melo es=
creveu:
>> > > Em Tue, Oct 19, 2021 at 12:06:17PM -0300, Arnaldo Carvalho de Melo =
escreveu:
>> > > > Em Fri, Oct 15, 2021 at 10:21:32AM -0700, Ian Rogers escreveu:
>> > > > > By allowing modifiers on metrics we can, for example, gather th=
e
>> > > > > same metric for kernel and user mode=2E On a SkylakeX with
>> > > > > TopDownL1 this gives:
>> > > > >
>> > > > > $ perf stat -M TopDownL1:u,TopDownL1:k -a sleep 2
>> > > > >
>> > > > >  Performance counter stats for 'system wide':
>> > > >
>> > > > Hi Ian, can you please take a look on this? this is on my perf/co=
re
>> > > > branch=2E
>> > >
>> > > I processed the first version of this series, reviewed by Andi, can=
 you
>> > > please submit the diff from one to the other?
>> >
>> > The interdiff from the 21st patch on the first batch versus on the v2
>> > batch is below, but it doesn't apply to my current perf/core branch,
>> > lemme push it to tmp=2Eperf/core=2E=2E=2E
>>
>> It was there already, what I have locally is what is in tmp=2Eperf/core=
=2E
>
>Hi Arnaldo,
>
>The last change I see in tmp=2Eperf/core is:
>https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/acme/linux=2Egit/comm=
it/?h=3Dtmp=2Eperf/core&id=3D5f43061b84d815c0f6477c1a8836bf0c6fec15a2
>
>The difference between v2 and v1 which fixes this bug is:
>
>+@@ -1500,7 +1568,10 @@ int metricgroup__copy_metric_events(struct
>evlist *evlist, struct cgroup *cgrp,
>+                               return -ENOMEM;
>+
>+                       new_expr->metric_expr =3D old_expr->metric_expr;
>+-                      new_expr->metric_name =3D old_expr->metric_name;
>++                      new_expr->metric_name =3D strdup(old_expr->metric=
_name);
>++                      if (!new_expr->metric_name)
>++                              return -ENOMEM;
>++
>+                       new_expr->metric_unit =3D old_expr->metric_unit;
>+                       new_expr->runtime =3D old_expr->runtime;
>+
>
>I also cleaned up some checkpatch line length warnings in v2, which I
>think is the reason for the other changes=2E Ideally I'd prefer the v2
>patch set over the v1, but they are largely identical=2E Both were based
>on acme/perf/core=2E Let me know how I can help=2E
>

I'm trying not to rewrite the perf/core branch after it's made public, so =
the best at this point is to add a new patch fixing the problem, if you can=
 please send it, that would help=2E

If it was just on tmp=2Eperf/core, then it would be ok to fix it=2E

- Arnaldo
