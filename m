Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B72C71133
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Aug 2023 04:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237389AbjHYEOW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Aug 2023 00:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241047AbjHYEON (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Aug 2023 00:14:13 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FA41FEA
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Aug 2023 21:14:11 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-40a47e8e38dso98301cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Aug 2023 21:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692936850; x=1693541650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKfe9hj3CSEjPgT+xs+Xkj5Dyaeh49hojcs26VEawjg=;
        b=gH7vRW4dFyzhoVPyRya43rZBxxCwpPn8Iat8xoj2VFbHeOSypyM9N5OYJV83OrG28M
         TjFtsKTERG6CyHpGa0ygjDQNsMdbABDnhBr30dT2zNW6eZtKn6GYa8K/iAPCuB755zSg
         IjnODLEy6wccewRHS/TTiw4CiAvslzHJSKM44BTH6EDFde5CsWaLg6C4ogDj2OdyDUzo
         N8NqIu1XqnObYim9JuGyztXHXPDpTa3+bDO73rwcsYV2gMATH8SDv3GnvKtrXwuJACrZ
         1JHy1AvQrYS3AxoNuy44xXcM448aNa1FcfuRMm1w2Q2KoCVLKDo6Xaxfk19M3NKhH+go
         otLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692936850; x=1693541650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKfe9hj3CSEjPgT+xs+Xkj5Dyaeh49hojcs26VEawjg=;
        b=EIXEVnPc+Pea4iYqm+5scWqOGtcdZFLZYb1seqzs5fQcE2S20SVTp8U3L69s1acKhy
         CnsjF+w7kDa+gJUHdBNvbXzdankS/gG2Ffi23V5zYhMjZyPiAiljV4cF2RzBUvT+YPwW
         Bz0A5VDIK3zQwT5rmSMfB5lyO/8iS9rALpBldKs6VjZUoO1v1yoYPmkBYMFqVhU/Nbyu
         Wh2Tt8B65ZeRAnO9O4vxQ8ZtM+xVo4IplqpPqM2CEbg2h2wpRwjPc1WBtDt+OYuZV+CC
         0TECdQiXOs54iYCfKUF8e3i88S4ykvOvzGAvHw52eM8+gKyO9IBDfFcEfgRspALz0q0Y
         2xTQ==
X-Gm-Message-State: AOJu0YzMy9YLxqqGkEs57sOKcENLG0tv4yvGKyaJaDlR2pN++EBL02Zt
        ZbN/mo3+C/mxBgYwCDnFMnSlxBvGG6fWLF0UL4xiyg==
X-Google-Smtp-Source: AGHT+IHqa8ysBCGVGYZ/HNb8fmiyrV4qlgLt5JjJ0Wd1AyaVpqKq/oOWW8ppOiBft+z80j/uU9XdLgZaqxeOyHweoDk=
X-Received: by 2002:a05:622a:1a99:b0:403:ac9c:ac2f with SMTP id
 s25-20020a05622a1a9900b00403ac9cac2fmr96191qtc.17.1692936850440; Thu, 24 Aug
 2023 21:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <1692606977-92009-1-git-send-email-renyu.zj@linux.alibaba.com> <1692606977-92009-9-git-send-email-renyu.zj@linux.alibaba.com>
In-Reply-To: <1692606977-92009-9-git-send-email-renyu.zj@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 24 Aug 2023 21:13:58 -0700
Message-ID: <CAP-5=fU3-iuHd6Yd6SGtffZr92eMN3nb0NRM40KmqKPxKZobHA@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] perf vendor events: Add JSON metrics for Arm CMN
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Aug 21, 2023 at 1:36=E2=80=AFAM Jing Zhang <renyu.zj@linux.alibaba.=
com> wrote:
>
> Add JSON metrics for Arm CMN. Currently just add part of CMN PMU
> metrics which are general and compatible for any SoC with CMN-ANY.
>
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> ---
>  .../pmu-events/arch/arm64/arm/cmn/sys/metric.json  | 74 ++++++++++++++++=
++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metric.j=
son
>
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metric.json b/t=
ools/perf/pmu-events/arch/arm64/arm/cmn/sys/metric.json
> new file mode 100644
> index 0000000..64db534
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metric.json
> @@ -0,0 +1,74 @@
> +[
> +       {
> +               "MetricName": "slc_miss_rate",
> +               "BriefDescription": "The system level cache miss rate.",
> +               "MetricGroup": "cmn",
> +               "MetricExpr": "hnf_cache_miss / hnf_slc_sf_cache_access",
> +               "ScaleUnit": "100%",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"

Here a ';' is used as a separator, but for "Unit" ',' is used as a
separator. Is there a reason for the inconsistency?

Thanks,
Ian

> +       },
> +       {
> +               "MetricName": "hnf_message_retry_rate",
> +               "BriefDescription": "HN-F message retry rate indicates wh=
ether a lack of credits is causing the bottlenecks.",
> +               "MetricGroup": "cmn",
> +               "MetricExpr": "hnf_pocq_retry / hnf_pocq_reqs_recvd",
> +               "ScaleUnit": "100%",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "MetricName": "sf_hit_rate",
> +               "BriefDescription": "Snoop filter hit rate can be used to=
 measure the snoop filter efficiency.",
> +               "MetricGroup": "cmn",
> +               "MetricExpr": "hnf_sf_hit / hnf_slc_sf_cache_access",
> +               "ScaleUnit": "100%",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "MetricName": "mc_message_retry_rate",
> +               "BriefDescription": "The memory controller request retrie=
s rate indicates whether the memory controller is the bottleneck.",
> +               "MetricGroup": "cmn",
> +               "MetricExpr": "hnf_mc_retries / hnf_mc_reqs",
> +               "ScaleUnit": "100%",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "MetricName": "rni_actual_read_bandwidth.all",
> +               "BriefDescription": "This event measure the actual bandwi=
dth that RN-I bridge sends to the interconnect.",
> +               "MetricGroup": "cmn",
> +               "MetricExpr": "rnid_rxdat_flits * 32 / 1e6 / duration_tim=
e",
> +               "ScaleUnit": "1MB/s",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "MetricName": "rni_actual_write_bandwidth.all",
> +               "BriefDescription": "This event measures the actual write=
 bandwidth at RN-I bridges.",
> +               "MetricGroup": "cmn",
> +               "MetricExpr": "rnid_txdat_flits * 32 / 1e6 / duration_tim=
e",
> +               "ScaleUnit": "1MB/s",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "MetricName": "rni_retry_rate",
> +               "BriefDescription": "RN-I bridge retry rate indicates whe=
ther the memory controller is the bottleneck.",
> +               "MetricGroup": "cmn",
> +               "MetricExpr": "rnid_txreq_flits_retried / rnid_txreq_flit=
s_total",
> +               "ScaleUnit": "100%",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "MetricName": "sbsx_actual_write_bandwidth.all",
> +               "BriefDescription": "sbsx actual write bandwidth.",
> +               "MetricGroup": "cmn",
> +               "MetricExpr": "sbsx_txdat_flitv * 32 / 1e6 / duration_tim=
e",
> +               "ScaleUnit": "1MB/s",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       }
> +]
> --
> 1.8.3.1
>
