Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6A8EB64D7
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jun 2023 18:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjF3SFa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Jun 2023 14:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjF3SFY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jun 2023 14:05:24 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931383A99
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 11:05:19 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-401f4408955so29191cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 11:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688148319; x=1690740319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQ4gsD4rdwDr1A7gGhTaZLJd5JcR8+ufDcHkEAaH+aI=;
        b=1ZE7hgtiEgjlDoeW6HUZsmb8pHNnQlGFw7TZ1i0uPrPvgU9CC1wDgKKbDS2Q4mBjmX
         mDA2d+tyiItMB8jvUIQjHeRMG9ApI/+tVpQdZd9+ZdKYrhiqZ0uj3hV4IDI4t//mbRlo
         3d7LEyyVA70BhOvSPCQW/APnieCBn2kVxrsCaCKkkVlz242DmyTvIsl8XxEcctinddXd
         2wzNC7SGg7u7R3ADYlqP169TKzmReuce6+k08BDk2shySD8VeWjrjx7a8VvrKe+/6YNO
         S8b+bJ6qnKaoDPauiC9o38V7La0F0SP9Yez1pbIr3opxZj0ySqFBU8Nhl0tGl/R1LHmu
         wwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688148319; x=1690740319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQ4gsD4rdwDr1A7gGhTaZLJd5JcR8+ufDcHkEAaH+aI=;
        b=h2MGoxPk/1mCwUnhXGFtmv/7NyjkzNn2DpcjBHNaGVN3D+/an/CDM/meaBTh4kV0Xy
         G8gprdFudPUYaYhjMexXeAGJ/3mZQW67F2AncLpXTgyuf01NpAY0hyhjZiZLq+RSe/ZA
         fw12pfS2LHO2hgJwnpgy8BWK06Yb23vZY2lVCFG/CuvglSWAbqhKruMMvw0rV3UUR0TB
         2Pk78PJ0iNUT2v+6f1qTkmAICEA5Uf0rw2RLYA2cOKqmo3USMoqMUJz4JJX/S+k6JtxZ
         XKpv4543viHIBDvnCDxB78G77TTilkMhnIyte/oC1BqWed6SW+4wohmGnpIaxNAOU3n3
         FLQQ==
X-Gm-Message-State: ABy/qLZ5owb5+b9JOuwZcVumqQAEEyHZxzodC2wtjdPInjPN6NRr30Zh
        3YLbCkZ57hKR3lecW9zm5IE/A5fJ3rAUYjXBzGks6/0BypGHDJwVnl+aXg==
X-Google-Smtp-Source: APBJJlFBVz1kI+p5pJzmHdNMLO9ZN9vVI/wrZ03xA0F44tFU7ilVI9KouRjr3eyIVvMMvg7cuPExG7fJ2bUHGksBdQo=
X-Received: by 2002:ac8:580c:0:b0:3f4:f841:df89 with SMTP id
 g12-20020ac8580c000000b003f4f841df89mr988qtg.1.1688148318671; Fri, 30 Jun
 2023 11:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230627181030.95608-14-irogers@google.com> <ea39aaf0-0314-1780-c1cd-7c3661fa3e7c@web.de>
 <CAP-5=fX+kdRujgNAq8SVkkNwgnB383r38+AEmvon1k01R4X=kg@mail.gmail.com> <a3517306-7804-f5cf-6182-ef63b6054647@web.de>
In-Reply-To: <a3517306-7804-f5cf-6182-ef63b6054647@web.de>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 30 Jun 2023 11:05:07 -0700
Message-ID: <CAP-5=fUEa150DYWte2u6M8sejxXXqec_L8GEhVbppJHHq8N5PA@mail.gmail.com>
Subject: Re: [v2 13/13] perf parse-events: Remove ABORT_ON
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 30, 2023 at 10:40=E2=80=AFAM Markus Elfring <Markus.Elfring@web=
.de> wrote:
>
> >>> Prefer informative messages rather than none with ABORT_ON. Document
> >>> one failure mode and add an error message for another.
> >>
> >> Does such a wording really fit to the known requirement =E2=80=9CSolve=
 only one problem per patch.=E2=80=9D?
> >>
> >> See also:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.4#n81
> >
> > Sorry your explanation isn't clear.
>
> Do you really find the application of the linked development documentatio=
n unclear
> in this case?
>
>
> > Sorry your explanation isn't clear. Please can you elaborate.
>
> Will it become helpful to split the proposed patch into smaller update st=
eps?

This is kind of why the series is 13 patches long, I'm not seeing why
you think the following stats qualify as "long":
14 insertions(+), 8 deletions(-)

Thanks,
Ian

> Regards,
> Markus
