Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90452C77B73
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Jun 2023 17:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbjFERTE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 5 Jun 2023 13:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbjFERTE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 5 Jun 2023 13:19:04 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BC49E
        for <linux-perf-users@vger.kernel.org>; Mon,  5 Jun 2023 10:19:03 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-33d928a268eso11415ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Jun 2023 10:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685985542; x=1688577542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxEXC71EvIBIyrKJkGLhD82I8t0W90h4l0Ayz0o/Zuk=;
        b=E4z+OtE2bX/yCcT11XrY69kLEAdDfz8lyFnka1MGrcDLwOe8Zc/Nb0mpY4WBcxg85n
         scSbvoLxQn9L72GYXgySm/QNrAqXk2QF++Hzl8IMDcMsi9h4DrltRmmdRv+ia8hvyhKR
         F/hxReUxd60B94T1dYjNmaJONz8f5UuJJM9++Nwoyh5NuRJYSnOxs8Xmsjif6ticCaLa
         VuZ7ZvT6VVhJrVEUV12OdRiVx3R89skZso8eBtU7BQNOmRx30UzNbx61LCMDS11zg36G
         CWhgIKdMtWHe7jHfWhMxyi7KMzqs6SDQkeAlQK2Xsq4uVgh13dLRzLhRuUS27sdWn8ep
         oaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685985542; x=1688577542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxEXC71EvIBIyrKJkGLhD82I8t0W90h4l0Ayz0o/Zuk=;
        b=OSMOHE3W2gxIH1i+pU4pTwzMS/tBsJcBOUhM6wYu0VnvmYlDiAh2R2dEFpO4SMSu5h
         Sh8W4s6KpISNipfNHD81QpUwdHRKngr6t9fS5hY3qop7s8sqrzfjbTNo6zXaBaV4vTeP
         zENfnZ4KTYAkrd8X5x8nfolUznIeAGXvJlV09O3MTxpCfJsc/pFhX1nnQV/saTFpO6qV
         2ks7UxE5PryIsNHwJCa60fKcUdLyQ3RVYDIRztUGFe2HoVKKdc13KVulFlvPo6MgemNS
         rmU2HKoZnJf3u8fU4F4quSDKS1EN1ku+U67RDpHebFEvMSwIt1oQV1QmG9ZCS8K9+sRf
         Lt3Q==
X-Gm-Message-State: AC+VfDwLgZnP/SrvFp0FMX6URsFh1jDHU+UeErr48WXGj/rve0SRX9iu
        2pj4FSWM4mJTvzLeso3TIWRqxO4OerWRPxPgAarcsg==
X-Google-Smtp-Source: ACHHUZ5yCtTMWiv5JDmds12pvo/vlZ5+DYKz0ecdht2+KB6rBnQ5vhTqoa7+N3iMfOBk8KooPf3yokzgPcfpb92Abos=
X-Received: by 2002:a05:6e02:1e07:b0:33d:c057:f811 with SMTP id
 g7-20020a056e021e0700b0033dc057f811mr10502ila.1.1685985542393; Mon, 05 Jun
 2023 10:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230522204047.800543-1-irogers@google.com> <CAEf4BzZ28xz=bUuFoaWRzKjxOEpv2SRJ08rOycDiX0OchGSQEA@mail.gmail.com>
In-Reply-To: <CAEf4BzZ28xz=bUuFoaWRzKjxOEpv2SRJ08rOycDiX0OchGSQEA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 5 Jun 2023 10:18:51 -0700
Message-ID: <CAP-5=fUj9eTGLDxEpc=Xp082O-mQ_4ALp=2VPFHCvAVq8gO-JQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Bring back vmlinux.h generation
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, May 22, 2023 at 4:35=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, May 22, 2023 at 1:41=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Commit 760ebc45746b ("perf lock contention: Add empty 'struct rq' to
> > satisfy libbpf 'runqueue' type verification") inadvertently created a
> > declaration of 'struct rq' that conflicted with a generated
> > vmlinux.h's:
> >
> > ```
> > util/bpf_skel/lock_contention.bpf.c:419:8: error: redefinition of 'rq'
> > struct rq {};
> >        ^
> > /tmp/perf/util/bpf_skel/.tmp/../vmlinux.h:45630:8: note: previous defin=
ition is here
> > struct rq {
> >        ^
> > 1 error generated.
> > ```
> >
> > Fix the issue by moving the declaration to vmlinux.h. So this can't
> > happen again, bring back build support for generating vmlinux.h then
> > add build tests.
> >
> > Ian Rogers (3):
> >   perf build: Add ability to build with a generated vmlinux.h
> >   perf bpf: Move the declaration of struct rq
> >   perf test: Add build tests for BUILD_BPF_SKEL
> >
> >  tools/perf/Makefile.config                       |  4 ++++
> >  tools/perf/Makefile.perf                         | 16 +++++++++++++++-
> >  tools/perf/tests/make                            |  4 ++++
> >  tools/perf/util/bpf_skel/.gitignore              |  1 +
> >  tools/perf/util/bpf_skel/lock_contention.bpf.c   |  2 --
> >  tools/perf/util/bpf_skel/{ =3D> vmlinux}/vmlinux.h | 10 ++++++++++
> >  6 files changed, 34 insertions(+), 3 deletions(-)
> >  rename tools/perf/util/bpf_skel/{ =3D> vmlinux}/vmlinux.h (90%)
> >
> > --
> > 2.40.1.698.g37aff9b760-goog
> >
> >
>
> LGTM, for the series:
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Arnaldo, could we take this set?

Thanks,
Ian
