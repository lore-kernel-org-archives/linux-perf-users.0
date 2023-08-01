Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798E9C001DF
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Aug 2023 17:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjHARkH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Aug 2023 13:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjHARkG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Aug 2023 13:40:06 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4955BE65
        for <linux-perf-users@vger.kernel.org>; Tue,  1 Aug 2023 10:40:05 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-407db3e9669so19861cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Aug 2023 10:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690911604; x=1691516404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4ttxZ9lvM9BRgPqD8KcTUo/Tqk/chLcWEpF3hi3Jtw=;
        b=FcBMFuGzuHcmmy5rF69xdO99znqfnKnhx4Pr8GCZJbOTX9sSKgo1XkVCbe/TOOWWTy
         kG7PvFMOMaS5dnQFt4etYAxJ2KWFFS70hQ8xEhLjFylSvgZZrBi2/8jkQ+jP4a0qhwjs
         8Lgzi6hjaxmAEQx0H5hdNmgrTLluTlTJBpLng9/JseoebWPc12qD8CSqKJjKRXN0G21C
         AbPBLSzAsMS7XQuUYgbE6cKoP/9bvOLRkpnwSusLgqpYEwAjCgEb/JpwO2i54s97f5hr
         2w9hjTpC54HsNMUTrtieL2BeC0MoMKjBsbmNIihLSBI3nmnM94aY9/fg00zUTb7vN6V/
         TuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690911604; x=1691516404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4ttxZ9lvM9BRgPqD8KcTUo/Tqk/chLcWEpF3hi3Jtw=;
        b=FI1w2Cr77wadoNdhux9OI3Y6O2SKhPSdWvO+kz1IIHxjmkclC2A5PXOER1M28TQH+l
         906tPEhNiLBJuJ3pvJx6kCGEVx+LUQry5AdTb6XfZWEYv0NX759lrc0uMU5FGXoRlfNI
         i4iSPiijYy1DWbwAEZYRqdCDk4PzKFuc+9hZQ8lhLKVsq1rWulkk+An/JdBxTAetVVb4
         MTQoIyO+w1rmSvUd5RbujmZZV00yBD2zJk5hNaurjWb88KVevnzs0enF0QUoxStmH0uQ
         6OiQumzjpumNl+GVCBClx5GUWqSVwpmFezDU9pQQCQEUzCZS8v8yKbMDORO1Uk33tRc0
         H9ww==
X-Gm-Message-State: ABy/qLY29tVmZW/KeVrWgW2n6NAnKp8vJG9BpmnG9/eWBiqGtJF5uxCm
        AxI3Nr0oa1URD2wRrvJ6XIIDPaJoXI+rbd2nzkNZIg==
X-Google-Smtp-Source: APBJJlGETBVMZMR1LPwpj6fIcpITK782kqS9VcG1LyI3VYRdrDhyvcbDs1fvheip5H6UVpkmAYE4OckMze6BFPmQB+M=
X-Received: by 2002:a05:622a:115:b0:40d:eb06:d3cc with SMTP id
 u21-20020a05622a011500b0040deb06d3ccmr681996qtw.7.1690911604254; Tue, 01 Aug
 2023 10:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230711055859.1242497-1-irogers@google.com> <182675ca-0905-0ed2-de94-0f7d4a256082@oracle.com>
 <CAP-5=fXrOvkwrbEB0GGv6Xr5JOdrW7dzjOL=MkDdxX2McfnzYA@mail.gmail.com> <cd5814af-8ab0-6ab9-9b3c-b5081e54f199@oracle.com>
In-Reply-To: <cd5814af-8ab0-6ab9-9b3c-b5081e54f199@oracle.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 1 Aug 2023 10:39:53 -0700
Message-ID: <CAP-5=fU4c+kU0OYbPp0andZW33tHiewyoxkvXbrU36EyLKKZ2A@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] perf list: Remove duplicate PMUs
To:     John Garry <john.g.garry@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jul 11, 2023 at 8:24=E2=80=AFAM John Garry <john.g.garry@oracle.com=
> wrote:
>
>
> >>> ```
> >>> $ perf list
> >>> ...
> >>>     uncore_imc_free_running_0/data_read/               [Kernel PMU ev=
ent]
> >>>     uncore_imc_free_running_0/data_total/              [Kernel PMU ev=
ent]
> >>>     uncore_imc_free_running_0/data_write/              [Kernel PMU ev=
ent]
> >>>     uncore_imc_free_running_1/data_read/               [Kernel PMU ev=
ent]
> >>>     uncore_imc_free_running_1/data_total/              [Kernel PMU ev=
ent]
> >>>     uncore_imc_free_running_1/data_write/              [Kernel PMU ev=
ent]
> >>> ```
> >>>
> >>> After:
> >>> ```
> >>> $ perf list
> >>> ...
> >>>     uncore_imc_free_running/data_read/                 [Kernel PMU ev=
ent]
> >>>     uncore_imc_free_running/data_total/                [Kernel PMU ev=
ent]
> >>>     uncore_imc_free_running/data_write/                [Kernel PMU ev=
ent]
> >> So with this change can we run something like:
> >>
> >> perf stat -e uncore_imc_free_running/data_read/
> >>
> >> ?
> > It is a long standing behavior of the event parser that we match the
> > numeric suffixes, so:
>
> I guess that I missed this as I assume that it would not handle more
> complex names, like hisi_sccl1_ddr3, which I was then interested in.
>
> >
> > ```
> > $ sudo perf stat -e uncore_imc_free_running/data_read/ -a sleep 1
> >
> > Performance counter stats for 'system wide':
> >
> >           6,969.93 MiB  uncore_imc_free_running/data_read/
> >
> >        1.001163027 seconds time elapsed
> > ```
> >
> > The "uncore_" at the beginning is also optional, I kind of wish the
> > "free_running" was too. The code doing this is:
> > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel=
/git/perf/perf-tools-next.git/tree/tools/perf/util/parse-events.y?h=3Dperf-=
tools-next*n316__;Iw!!ACWV5N9M2RV99hQ!JduVayRc--qLXHsoXWTlMUsO4NBUoBnKQHqP2=
sx7VuwZiZzfVXaQZNBZuzO2Ie-twWQ1xu7nycBNFJ13LGk$
> > adding a * after the PMU name in:
> > asprintf(&pattern, "%s*", $1)
> > Then using fnmatch here:
> > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel=
/git/perf/perf-tools-next.git/tree/tools/perf/util/pmu.c?h=3Dperf-tools-nex=
t*n1707__;Iw!!ACWV5N9M2RV99hQ!JduVayRc--qLXHsoXWTlMUsO4NBUoBnKQHqP2sx7VuwZi=
ZzfVXaQZNBZuzO2Ie-twWQ1xu7nycBNa2_VzYE$
> >
> >> If so, does that match all PMUs whose name beings with
> >> "uncore_imc_free_running" (and give aggregate result for those PMUs)?
> > Yep. As we're matching with a filename '*' glob then it will actually
> > potentially grab a bunch more. I think this should likely be made a
> > lot more precise.
> >
> > The merging of the counters happens throughout the code, but it is set =
up here:
> > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel=
/git/perf/perf-tools-next.git/tree/tools/perf/util/stat.c?h=3Dperf-tools-ne=
xt*n559__;Iw!!ACWV5N9M2RV99hQ!JduVayRc--qLXHsoXWTlMUsO4NBUoBnKQHqP2sx7VuwZi=
ZzfVXaQZNBZuzO2Ie-twWQ1xu7nycBNiVEZvEE$
> >
> > I didn't write this behavior, it has pre-existed my contributions. I'm
> > hoping to change the perf list behavior as we're seeing large server
> > systems with getting on toward 100 PMUs, the events are replicated for
> > each one and the perf list and testing behaviors are somewhat
> > exploding in size.
>
> Sure, that is why I was advised PMU kernel drivers event names to be
> unique per PMU, so that we can add an event alias in a JSON and then
> kernel events are matched and removed from perf list.
>
> I suppose that your changes are an alternative to the problem of
> mushrooming kernel event list.

Thanks John, yep this is going after that problem. Could I get a
reviewed/acked/tested-by for these changes?

Thanks,
Ian

> Thanks,
> John
