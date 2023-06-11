Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F95EC77B7A
	for <linux-perf-users@archiver.kernel.org>; Sun, 11 Jun 2023 03:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjFKDz3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 10 Jun 2023 23:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjFKDz1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 10 Jun 2023 23:55:27 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D05270F
        for <linux-perf-users@vger.kernel.org>; Sat, 10 Jun 2023 20:55:26 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-33fa4707d03so102635ab.1
        for <linux-perf-users@vger.kernel.org>; Sat, 10 Jun 2023 20:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686455725; x=1689047725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0o5NMjwT+OUwuPIGYIt6xI5n/QFf6LTPRj+LBlJn7E=;
        b=5Jud40XpHet9qmPoS5prkOfT5XlsEvt8TVGu8U30FALEMTgxm5xOK69t3IiFgNMZNo
         kRqs9y9cuE9ZF3AnTThlAJpT/8Uxo9sEoU08h8GRv2ajZeaK7N8JJg39KX92v2PvNlq0
         rfjOo7EOgjd24bI0ga0+NFMveJ6jX+E25yL4okIXaA+UoKplw4uVLc1vHomRrMSQZSU1
         2H3yTcStomiYtl06EIhGqXO5plamJk9e5yzStQDBnDXKUGfQN6HjeTDB13srY/cUqE2a
         eFCGNko7Fz6M1OguvdWhIKR50Vv0D/aKGrE3ZDeVZVtMp4xilR7EjxTQPx0yjbx7XYN8
         Rk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686455725; x=1689047725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0o5NMjwT+OUwuPIGYIt6xI5n/QFf6LTPRj+LBlJn7E=;
        b=Yzytv1vSRRCFEy7N/WLc6TAHzdll/gcr3FPKY0DFT39uBk9pshtWZppLjiBtDf2Rkt
         nXPqBavZwOFtWpG4FxAT0FzWSHp33B/OlZXwemzUiCwsZtz4TMUW24zxfDId4HZYPIbK
         oPwf7V0lwPXBv5sQqKEmegSfco61LkvZVche76rJxYPt6hWiioRXAfiqPpNb0gosNrXE
         bxRZzYChggdBzBChod3GOdu94w58npRZJAZe0dHv7c1h8j7/HON6Iygko7xoT0ZWilVI
         RGEup5NppsRqviw4fF+9puf9esceaswQsA0J9p4LuOUsvKoXUHoCoTFzTWF8UzMkT1mN
         Ua6w==
X-Gm-Message-State: AC+VfDyTVBLG4HSlJS/PBrEvPp52nr/QaGqepxPCZk6zzgfFf3bQTmSm
        Ts48h0PzG7i55keRWGmUcYx0MbxsLvI2kshpsW+WiQ==
X-Google-Smtp-Source: ACHHUZ6M0GY8y2dIi72Ij4kV/YPLHsOXMZ/0NOK5tK70+10lseHNLgNpolYO9VmJyS6iFVofnZOVTxKxVsJUmGz4UC0=
X-Received: by 2002:a05:6e02:1c4c:b0:33d:8444:c071 with SMTP id
 d12-20020a056e021c4c00b0033d8444c071mr131336ilg.5.1686455725541; Sat, 10 Jun
 2023 20:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com> <20230527072210.2900565-29-irogers@google.com>
 <b8efdc75-253c-ad88-f82f-90c626a26592@amd.com> <CAP-5=fXg-4NWOhOoTCfNm3aWp_rd6PWcq5NyZ7xwinbuDPUtZg@mail.gmail.com>
 <7c7d9279-25b0-328e-af41-66c2096febaa@amd.com> <CAP-5=fUPYjG2J-bxcBf8h1JW34FGQwEbSo4uDbbi+GTGmvGMtg@mail.gmail.com>
 <ZILbubiZPNg2M/JY@FVFF77S0Q05N>
In-Reply-To: <ZILbubiZPNg2M/JY@FVFF77S0Q05N>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 10 Jun 2023 20:55:13 -0700
Message-ID: <CAP-5=fU+F_yQHi5jYTXW7F8d3k0PqspPFrfF7FRdBgki+X9hBw@mail.gmail.com>
Subject: Re: [PATCH v5 28/34] perf pmus: Split pmus list into core and other
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 9, 2023 at 12:59=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Thu, Jun 08, 2023 at 10:35:02PM -0700, Ian Rogers wrote:
> > On Thu, Jun 8, 2023 at 10:30=E2=80=AFPM Ravi Bangoria <ravi.bangoria@am=
d.com> wrote:
> > >
> > > On 09-Jun-23 10:10 AM, Ian Rogers wrote:
> > > > On Thu, Jun 8, 2023 at 9:01=E2=80=AFPM Ravi Bangoria <ravi.bangoria=
@amd.com> wrote:
> > > >>
> > > >> Hi Ian,
> > > >
> > > > Hi Ravi,
> > > >
> > > >> On 27-May-23 12:52 PM, Ian Rogers wrote:
> > > >>> Split the pmus list into core and other. This will later allow fo=
r
> > > >>> the core and other pmus to be populated separately.
> > > >>>
> > > >>> Signed-off-by: Ian Rogers <irogers@google.com>
> > > >>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> > > >>> ---
> > > >>>  tools/perf/util/pmus.c | 52 ++++++++++++++++++++++++++++++------=
------
> > > >>>  1 file changed, 38 insertions(+), 14 deletions(-)
> > > >>>
> > > >>> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> > > >>> index 58ff7937e9b7..4ef4fecd335f 100644
> > > >>> --- a/tools/perf/util/pmus.c
> > > >>> +++ b/tools/perf/util/pmus.c
> > > >>> @@ -12,13 +12,19 @@
> > > >>>  #include "pmu.h"
> > > >>>  #include "print-events.h"
> > > >>>
> > > >>> -static LIST_HEAD(pmus);
> > > >>> +static LIST_HEAD(core_pmus);
> > > >>> +static LIST_HEAD(other_pmus);
> > > >>
> > > >> AMD ibs_fetch// and ibs_op// PMUs are per SMT-thread and are indep=
endent of
> > > >> core hw pmu. I wonder where does IBS fit. Currently it's part of o=
ther_pmus.
> > > >> So, is it safe to assume that other_pmus are not just uncore pmus?=
 In that
> > > >> case shall we add a comment here?
> > > >
> > > > I'm a fan of comments. The code has landed in perf-tools-next:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree=
/tools/perf/util/pmus.c?h=3Dperf-tools-next
> > > > Do you have any suggestions on wording? I've had limited success
> > > > adding glossary terms, for example, offcore vs uncore:
> > > > https://perf.wiki.kernel.org/index.php/Glossary#Offcore
> > > > I think offcore is a more interconnect related term, but I'd prefer
> > > > not to be inventing the definitions. I'd like it if we could be les=
s
> > > > ambiguous in the code and provide useful information on the wiki, s=
o
> > > > help appreciated :-)
> > >
> > > Does this look good?
> > >
> > > /*
> > >  * core_pmus:  A PMU belongs to core_pmus if it's name is "cpu" or it=
's sysfs
> > >  *             directory contains "cpus" file. All PMUs belonging to =
core_pmus
> > >  *             must have pmu->is_core=3D1. If there are more than one=
 PMUs in
> > >  *             this list, perf interprets it as a heterogeneous platf=
orm.
> >
> >
> > Looks good but a nit here. It is heterogeneous from point-of-view of
> > PMUs, there are ARM systems where they are heterogenous with big and
> > little cores but they have a single homogeneous PMU driver. The perf
> > tool will treat them as homogeneous.
>
> For the sake of the comment: there's a little more nuance here.
>
> The intent is that each distinct micro-architecture has its own PMU insta=
nce,
> but some people write their device trees incorrectly with a single pmu no=
de
> rather than separate pmu nodes per micro-architecture.
>
> That should be viewed as a FW bug, even if we have to deal with it here.

Thanks for the clarification Mark. For heterogeneous ARM I was
primarily looking at a Pixel 4 phone, which has a homogeneous PMU. The
normal way to make sure Android configurations are sensible is to have
a CTS test. Would that be appropriate here?

Given Intel contributed the original heterogeneous PMU support to the
perf tool, and hard coded the PMU names to 'cpu_core' and 'cpu_atom',
are there any correctness tests that exist for ARM heterogeneous PMUs?
Could we make this part of the 'perf test' command? Tests acting both
as a correctness feature and documentation.

Thanks,
Ian

> Thanks,
> Mark.
