Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD6BC761A6
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Mar 2023 16:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjC0QwH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 27 Mar 2023 12:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjC0QwF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 27 Mar 2023 12:52:05 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DA72D50
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Mar 2023 09:51:46 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3e392e10cc4so762841cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Mar 2023 09:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679935903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G96YuHfNOixQOenDOjw+vw59nqvCVp4eZ2HJnETyrKc=;
        b=cVGHWdwqfEkneKgtudrjbNGsEzADfbEvXHWqAAx79dx2qKsfAP/IyzzqWgWtGn2gBV
         ILG7Eg+8PthAMvYprdbPqpKFTFEQBCu5B17F2PQ5cSnqrV6xUe+76UjbI3FbhfNKqosW
         98dX0lM+nZ/7AXDnsjEkzSBp4MHMNhoaQ/a6Vt98XjcwYCC6EIwGxbszYQR61Hopo1wI
         AAXXTBLhz3UndEl3VL6KZyZW06hAAx4U7B2lAcgJ25ZOY6CrVYRkv1Q5hthMyKqUHrRx
         fSpy+YfwVicXOh6cGSZQjFdX9myoQ8GThtyHCaChkORSE+6WSJf7oRms6my6+6shLzM1
         L34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679935903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G96YuHfNOixQOenDOjw+vw59nqvCVp4eZ2HJnETyrKc=;
        b=SXeHIHZQPu7F5/7OI5hmtWV3pUNLU4rTRkcyKVAQ0YI8OOVZAmQlFBi88tHki/8CSL
         3o7ZR8nsmDghD4qe3hwrfwkaIKX75i67yfQ/tYhLsoX5YfNOTqSO2ZUSJerqSakq9MUY
         aSwyvt4T3MyJndhtlXywHiU88VgIyHUb+huEXh2tNw2lL4V9sPvYWQeHkGQyyKDnDvSq
         mjPXa1MoA35OMKpbY6yEBWspH3op4YpzPHK49bUhVPV6q0A45he/oM86Inmf7ZDX5DJk
         C4Yt1xZ7QN+UZKX9I2k/JPK883NA9C8pFscwc9XgCoTGOiXjurlbFXy1fIyUFRxVKLn9
         c8Fg==
X-Gm-Message-State: AAQBX9ctYzIvv/PEeaxmBIzA9Y9ABwzCOvD4uNxw+Qe780lV3k9Ha7Nq
        MBl1JjypTrIwS5x5equaixmbl83sGuuJmSGTTGiHlg==
X-Google-Smtp-Source: AKy350YFx7+Gb2GSAOSS4DCpVaJhpKird5zpu0naUCTffltRu3HaqJtagKWVFth5kFZsFyzmtvzoQnvwdnpqHv8ys+k=
X-Received: by 2002:a05:622a:1820:b0:3d3:fd80:b06a with SMTP id
 t32-20020a05622a182000b003d3fd80b06amr518172qtc.13.1679935902975; Mon, 27 Mar
 2023 09:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <1679885172-95021-1-git-send-email-renyu.zj@linux.alibaba.com>
In-Reply-To: <1679885172-95021-1-git-send-email-renyu.zj@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 27 Mar 2023 09:51:31 -0700
Message-ID: <CAP-5=fVitwxZwjkv0F98gHiYV9GBvmPq6LgcLTccQbogKmMhPA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/4] Add JSON metrics for arm CMN and Yitian710 DDR
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Mar 26, 2023 at 7:46=E2=80=AFPM Jing Zhang <renyu.zj@linux.alibaba.=
com> wrote:
>
> Hi all,
>
> I add an identifier sysfs file for the yitian710 SoC DDR and arm CMN to
> allow userspace to identify the specific implementation of the device,
> so that the perf tool can match the corresponding uncore events and
> metrics through the identifier. Then added several general CMN700 metrics
> and yitian710 soc DDR metrics.

Thanks!

> Since the eventid of cmn700 events is different from other events, it
> can't be specified by "EventCode" or "ConfigCode", so in the cmn.json
> file of cmn700, no "EventCode" and "ConfigCode" are added for these
> events. For example, the eventid of "arm_cmn_0/hnf_sf_hit is/":
> cat /sys/bus/event_source/devices/arm_cmn_0/events/hnf_sf_hit
> type=3D0x5,eventid=3D0x6

This is done to add descriptions to the events? We can add encodings
to jevents.py and the event parsing to handle the names eventid and
type.

> In addition, both cmn700 and ddr PMU can count the information in a die,
> but the same SoC can also be configured with different numbers of dies,
> so it is dificult to design a general expression to obtain metrics in
> different dies. The current yitian710 ddr bandwidth metric describes the
> sum of all dies bandwidth. I would like to ask you, is there any general
> expression can obtain metrics for die? Add an option to specify die?

So hopefully the logic for this is getting clearer in the
perf-tools-next branch. When perf stat runs it will aggregate in a
number of different ways, if you pass -A it will remove the
aggregation, but you can also use --per-socket, per-die, .. The
metrics take the individual counter values, say instructions and
cycles and produce a metric like IPC. By default all the instruction
counts are aggregated together, the cycles are aggregated together and
then the metric produced on the two aggregated values. When -A or
--per-die are passed, the appropriate amount of aggregation should be
done then the metric computed multiple times.

Are you asking for a way in a metric to take counts from one die and
use them in the other's metric? For example, reads on one die are
writes on the other? This is possible as we have all the counts in the
tool. I've thought about this in the context of some metrics we have
for AMD, but there is no support for this in the tool currently.

Thanks,
Ian

> Thanks,
> Jing
>
> Jing Zhang (4):
>   driver/perf: Add identifier sysfs file for CMN
>   perf vendor events: Add JSON metrics for cmn700
>   driver/perf: Add identifier sysfs file for Yitian 710 DDR
>   perf vendor events: Add JSON metrics for Yitian 710 DDR
>
>  drivers/perf/alibaba_uncore_drw_pmu.c              |  27 ++
>  drivers/perf/arm-cmn.c                             |  43 +++
>  .../pmu-events/arch/arm64/arm/cmn700/sys/cmn.json  | 188 +++++++++++
>  .../arch/arm64/arm/cmn700/sys/metrics.json         |  74 ++++
>  .../arm64/freescale/yitian710/sys/ali_drw.json     | 373 +++++++++++++++=
++++++
>  .../arm64/freescale/yitian710/sys/metrics.json     |  20 ++
>  tools/perf/pmu-events/jevents.py                   |   2 +
>  7 files changed, 727 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn700/sys/cmn.j=
son
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn700/sys/metri=
cs.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/yitian710/=
sys/ali_drw.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/yitian710/=
sys/metrics.json
>
> --
> 1.8.3.1
>
