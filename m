Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8575FC77B73
	for <linux-perf-users@archiver.kernel.org>; Mon,  1 May 2023 20:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjEAUv2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 1 May 2023 16:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbjEAUv1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 1 May 2023 16:51:27 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5082721
        for <linux-perf-users@vger.kernel.org>; Mon,  1 May 2023 13:51:23 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-32f4e0f42a7so3125ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 01 May 2023 13:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682974283; x=1685566283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ECRePsMeAbJBmX0er6XW8rZYgtfy+mdy7x4uZovHsQ=;
        b=ovGqqT+/jgloID11ihUlTGIg1XTt182hFuBtu+CKubV9IT1rcKfRb03vjfFUNaRS1q
         7xvTdeOH5doTg+qldiqNtOFnHXlMEpXW2ZZoGnQjjLpCSikjrBvKWs5XVRfC33zS2PQG
         Br6ax+lTQhGbWFvgbbvcAm50srSILkCl/WkdA57gMjHT6eChcsFVTRaTwP+bxH89Bf1B
         0J5zWFuPcjth1usISwwrIQqlx6G1zNDDy7X576mkCCM/UrYLJ2JdnxvNuAnYcC7vbUFt
         MF34hdGVazuPxZnq+IBG5s4Qr2oUdeTQh5Y706ghGIJg3mMRlVUPMp00QjpLDaWWXdQg
         NDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682974283; x=1685566283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ECRePsMeAbJBmX0er6XW8rZYgtfy+mdy7x4uZovHsQ=;
        b=aVRY29kbo3IHZPyCCwtj6GQFm48CuH7Q0BSDOyX4iZdThpvlKZ9UKTKGupPY5DpT0K
         UL2xvD2vm0iHlkOjJdgYsYmzGHdk/48NTjjlva9TpbjRioB4keO43nyz0jSapq03WZJ0
         5jG27uO6Ce6R+VY+3C9VnsHnV2qW7w7oXkDsQwyB0Zux1VCL3xtLtMhFq40ZSJpeG+w2
         lykTsawQUwCEE1KK+VstHm4oxg6hj7nVPuX2YdJir4J0CyA+h/A6YOpoTGPChSXolRGq
         N4wSCYI1DxKZpPomWXmLdtnYAjCfRQX+4JJwqicSvqiY0cHO/AcJhzQfaEhUDO/sTjDY
         Ho8w==
X-Gm-Message-State: AC+VfDz04KChw1nfzziBgjzrCcTA2BnccUqDV5lHHpVFVSIJ2hwoRBvY
        33V9C8qIAaVwi1kvzqve0aNpjwyxCH48D0P09/kMLQ==
X-Google-Smtp-Source: ACHHUZ4JsTJhH4ZvcIqIO54Sg3esy1TPwgXVjYG4hlWJwnHqaUwAp09yJFw9ATHBIqX4b3TdZlhuJZKEYlPNdjiPVMA=
X-Received: by 2002:a05:6e02:1526:b0:326:3219:85df with SMTP id
 i6-20020a056e02152600b00326321985dfmr73339ilu.14.1682974282663; Mon, 01 May
 2023 13:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230429053506.1962559-1-irogers@google.com> <1859d2ae-0f9c-1b59-210f-44e9adace4ed@linux.intel.com>
In-Reply-To: <1859d2ae-0f9c-1b59-210f-44e9adace4ed@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 1 May 2023 13:51:11 -0700
Message-ID: <CAP-5=fX=W-Ck21QuC=Onywtn-dfThBPzvGhbj8oLK8VxLwWoiw@mail.gmail.com>
Subject: Re: [PATCH v3 00/46] Fix perf on Intel hybrid CPUs
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
        Ravi Bangoria <ravi.bangoria@amd.com>,
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

On Mon, May 1, 2023 at 1:35=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2023-04-29 1:34 a.m., Ian Rogers wrote:
> > Sample output is contained in the v1 patch set:
> > https://lore.kernel.org/lkml/bff481ba-e60a-763f-0aa0-3ee53302c480@linux=
.intel.com/
> >
> > Tested on Tigerlake, Skylake and Alderlake CPUs.
>
> The metrics and metricgroups tests are failed on a hybrid machine.
> Seems we need the no group trick for more metrics?
>
> ./perf test "perf all metricgroups test"
> 102: perf all metricgroups test                                      :
> FAILED!
>
>
> Testing DataSharing
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument)
> for event (cpu_core/topdown-fe-bound/).
> /bin/dmesg | grep -i perf may provide additional information.
>
> test child finished with -1
> ---- end ----
> perf all metricgroups test: FAILED!
>
>
>
>
> ./perf test "perf all metrics test"
> 103: perf all metrics test                                           :
> FAILED!
>
> Testing tma_info_branctest child finished with -1
> ---- end ----
> perf all metrics test: FAILED!
>
> Testing tma_contested_accesses
> Metric 'tma_contested_accesses' not printed in:
> Error:
> Invalid event (cpu_core/topdown-fe-bound/) in per-thread mode, enable
> system wide with '-a'.
>
> Metric 'tma_dram_bound' not printed in:
> Error:
> Invalid event (cpu_core/topdown-mem-bound/) in per-thread mode, enable
> system wide with '-a'.
>
>
> Metric 'tma_data_sharing' not printed in:
> Error:
> Invalid event (cpu_core/topdown-fe-bound/) in per-thread mode, enable
> system wide with '-a'.
>
>
> Thanks,
> Kan

This is expected. Metrics test fails on Icelake, metricgroups doesn't
validate output but I can expect metricgroups like "transaction" to
have issues. We want to have better tests and this comes under what
we're hoping to achieve with the Valkyrie project.

Thanks,
Ian
