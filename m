Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A8FC77B73
	for <linux-perf-users@archiver.kernel.org>; Tue,  2 May 2023 17:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbjEBRkw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 2 May 2023 13:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbjEBRkv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 2 May 2023 13:40:51 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B36C3
        for <linux-perf-users@vger.kernel.org>; Tue,  2 May 2023 10:40:50 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-330ec047d3bso129605ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 May 2023 10:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683049249; x=1685641249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7zwT9U3Q7DJabdbJ+tKTAKmuAVSsUfjeiCdQzr1Lqw=;
        b=1yiTfOHI79peXlm0E6+h9E32HLEcYSlJE0Zm5YBx91HiUeUI4d/2Q6RZmLIatKJo88
         YiYQd4BusAd52HweaBckBQNxZxb6buqjk8CwJa9kpAaiuXUAJd5lpG0RddJy4JjcI19c
         ZOQi4bHLWA3apCdB2ufkpzbb3sMRRsGxVK1eJ6r8+plBsVmcxBa2L2hy4OObU/+kHIWS
         TCQ6rez/lyWj/6mocKuRKasaREiu6tJX4F2pPQUphIkvqey9Qnt6VEFecFq2bZaIQG/l
         Ewz0eZBycDz0j/hkfxai3V0eO3i0vkJiknkqXrhRkj/0sH60aJCg5tgmvJ4QHd/tZeZv
         lvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683049249; x=1685641249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7zwT9U3Q7DJabdbJ+tKTAKmuAVSsUfjeiCdQzr1Lqw=;
        b=OvCgV6ID1lJOwbPMHcB7zP2j0c+tA23jnIDrFxGKCvkJCeqLTc2kcszTphgYgH9h4a
         huDpmXVkDuKZ8FVHXXNf8ci9O5RBIY9mqLHT80TiWIm4iZhr4t43Y0hcTV88j3ovAjbs
         mgHQMPP9xgZvhSJlsOAqhCRDajV0h0ALz3Av9PR1052s/ClhSlJIjdVPp8AnKy4AIErd
         igAiVNX5dV5BCex+Dt173nbkx6qkBJJMwHWCqsm4H5yfvRE0unJNlYX2fg5oyXqhfOJm
         Q4Q+Jy2OMwK9Go/zAbTTOnWL5+nTta0UBRp4Qw5WzJOcqSUok5wUIJYi6a7XssOsMKOX
         n5xA==
X-Gm-Message-State: AC+VfDwi7BLvgIZi+axkPkzbep9PKiN7sZBhCZ0niW/QUCcW5Ucmd0mv
        Rr5qybrN/TCl0n5SRX1CYwHRHZ6KWFL23BYxxO+UbQ==
X-Google-Smtp-Source: ACHHUZ6YzhZt+Ehy6aXWrwYKYsdOrWKZI2pGYiARfOmu63ybIgxhSCZ7A7G8L/YlD+NGWuW7FqIY818IC4vYxU0KQpA=
X-Received: by 2002:a05:6e02:194a:b0:331:399c:57c5 with SMTP id
 x10-20020a056e02194a00b00331399c57c5mr192255ilu.3.1683049249296; Tue, 02 May
 2023 10:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230429053506.1962559-1-irogers@google.com> <20230429053506.1962559-28-irogers@google.com>
 <56dd818d-3f2a-59ba-3c56-af45f488ad8d@amd.com>
In-Reply-To: <56dd818d-3f2a-59ba-3c56-af45f488ad8d@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 2 May 2023 10:40:37 -0700
Message-ID: <CAP-5=fWzD0+jPEZ1gZp7Zj+gzb8NB-BDZvtstcx-dPNQr0n8Tw@mail.gmail.com>
Subject: Re: [PATCH v3 27/46] perf print-events: Print legacy cache events for
 each PMU
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, May 2, 2023 at 3:48=E2=80=AFAM Ravi Bangoria <ravi.bangoria@amd.com=
> wrote:
>
> On 29-Apr-23 11:04 AM, Ian Rogers wrote:
> > Mirroring parse_events_add_cache, list the legacy name alongside its
> > alias with the PMU. Remove the now unnecessary hybrid logic.
>
> Before patch:
>
> ```
> $ sudo ./perf list
>   ...
>   duration_time                                      [Tool event]
>   user_time                                          [Tool event]
>   system_time                                        [Tool event]
>   L1-dcache-loads                                    [Hardware cache even=
t]
>   L1-dcache-load-misses                              [Hardware cache even=
t]
>   L1-dcache-prefetches                               [Hardware cache even=
t]
>   L1-icache-loads                                    [Hardware cache even=
t]
>   L1-icache-load-misses                              [Hardware cache even=
t]
>   dTLB-loads                                         [Hardware cache even=
t]
>   dTLB-load-misses                                   [Hardware cache even=
t]
>   iTLB-loads                                         [Hardware cache even=
t]
>   iTLB-load-misses                                   [Hardware cache even=
t]
>   branch-loads                                       [Hardware cache even=
t]
>   branch-load-misses                                 [Hardware cache even=
t]
>   branch-brs OR cpu/branch-brs/                      [Kernel PMU event]
>   branch-instructions OR cpu/branch-instructions/    [Kernel PMU event]
>   branch-misses OR cpu/branch-misses/                [Kernel PMU event]
>   ...
> ```
>
> After patch:
>
> ```
> $ sudo ./perf list
>   ...
>   duration_time                                      [Tool event]
>   user_time                                          [Tool event]
>   system_time                                        [Tool event]
>
> cpu:
>   L1-dcache-loads OR cpu/L1-dcache-loads/
>   L1-dcache-load-misses OR cpu/L1-dcache-load-misses/
>   L1-dcache-prefetches OR cpu/L1-dcache-prefetches/
>   L1-icache-loads OR cpu/L1-icache-loads/
>   L1-icache-load-misses OR cpu/L1-icache-load-misses/
>   dTLB-loads OR cpu/dTLB-loads/
>   dTLB-load-misses OR cpu/dTLB-load-misses/
>   iTLB-loads OR cpu/iTLB-loads/
>   iTLB-load-misses OR cpu/iTLB-load-misses/
>   branch-loads OR cpu/branch-loads/
>   branch-load-misses OR cpu/branch-load-misses/
>   branch-brs OR cpu/branch-brs/                      [Kernel PMU event]
>   branch-instructions OR cpu/branch-instructions/    [Kernel PMU event]
>   branch-misses OR cpu/branch-misses/                [Kernel PMU event]
>   ...
> ```
>\
> Is this intentional change?

Yep, but I think the commit message should call it out, so I'll change
it in v4. When we have an alias the event type descriptor isn't shown,
this is pre-existing perf list behavior but I think we may want to
tweak it as I like the event type descriptor.

> > -     for (int type =3D 0; type < PERF_COUNT_HW_CACHE_MAX; type++) {
> > -             for (int op =3D 0; op < PERF_COUNT_HW_CACHE_OP_MAX; op++)=
 {
> > -                     /* skip invalid cache type */
> > -                     if (!evsel__is_cache_op_valid(type, op))
> > -                             continue;
> > +     while ((pmu =3D perf_pmu__scan(pmu)) !=3D NULL) {
> > +             /*
> > +              * Skip uncore PMUs for performance. Software PMUs can op=
en
> > +              * PERF_TYPE_HW_CACHE, so skip.
>
> This statement is bit confusing. Can you please explain how SW pmus can
> open cache events.

If the type is PERF_TYPE_HW_CACHE (3) and the extended type is
PERF_TYPE_SOFTWARE (1) then this yields the encoding '3:0x100000000'
which will succeed perf_event_open:
```
$ perf stat -vv -e '3:0x100000000' true
Using CPUID GenuineIntel-6-8D-1
intel_pt default config: tsc,mtc,mtc_period=3D3,psb_period=3D3,pt,branch
Control descriptor is not initialized
------------------------------------------------------------
perf_event_attr:
 type                             3
 size                             128
 config                           0x100000000
 sample_type                      IDENTIFIER
 read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
 disabled                         1
 inherit                          1
 enable_on_exec                   1
 exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 2128955  cpu -1  group_fd -1  flags 0x8 =3D 3
3:0x100000000: -1: 265630 261923 261923
3:0x100000000: 265630 261923 261923

Performance counter stats for 'true':

          265,630      3:0x100000000

      0.000844251 seconds time elapsed

      0.000911000 seconds user
      0.000000000 seconds sys
```
I agree this isn't expected, but if I don't exclude the PMU type the
print events will list it as an alias. I'll try to improve the comment
in v4.

Thanks,
Ian
