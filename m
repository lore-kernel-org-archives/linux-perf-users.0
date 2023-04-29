Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E33BC77B7C
	for <linux-perf-users@archiver.kernel.org>; Sat, 29 Apr 2023 21:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjD2VCL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 29 Apr 2023 17:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjD2VCK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 29 Apr 2023 17:02:10 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296D8199A
        for <linux-perf-users@vger.kernel.org>; Sat, 29 Apr 2023 14:02:06 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-32f4e0f42a7so295075ab.1
        for <linux-perf-users@vger.kernel.org>; Sat, 29 Apr 2023 14:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682802125; x=1685394125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpzsyG65Q6wbW3VKw2zdL/sAWMWDjU/AwwPSbLiyPYw=;
        b=gr2sv8uFyYuMOKVwad4npbupff+oa4Xobk3nrQWpMBqulnGRrllbD1k3bOtbXNOHOk
         819SCSgaLcbKcnnr0356lMMFT+xo8fR8H97qgi1kKo2T+Mb2BGKeDdHBZd+1wy3uL6zD
         G1DrSuVVU4gbSngUaWrENnSWIzaYQRx4HmSjAGs0faq3drdEmilhUEh1xpoZVVCJ5Moa
         YMR0ucuwdG9kcOBFJU6E0zjgIjFUDNtZyqTOw9rYt2vaiT6DFSe3g2Uxh8CWJXkgDyMN
         8fBjN8Bnor6qyI7QxfVCPKftWV60wtd1AIhrb+emyxSX531lStNScCoKvL2vKr61X38A
         aIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682802125; x=1685394125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpzsyG65Q6wbW3VKw2zdL/sAWMWDjU/AwwPSbLiyPYw=;
        b=O+QldmJJxkao1DIS1bBgyvKpjpSE2hz/DjWwOST+3VeT7shmk9B5HTDJwy6m7YfOcd
         OEA4/awHjJ0xiSjqQ2Tj5R19ngaDxEMXgKezpqhVKq+2O4s4ZS+iHWwV3v9BdKNjpnEn
         rs1ylWQwggce8klYiP1RHvrczWH84eES9Ub66kO9S73B4XFYMjUIo0Iwf3joTvd8uvdz
         yHYidZEtpR+HSaI9RjPSPDA97WmrluVSrsH+ZPlZKE/enmt/45ZXRm04QZ6KEo0GbPvt
         DKSSwwEa2hDF+WIXKlAZ+JP5kjo7IfC3wq7JXSOkiW1G/y/gb2tY2/RqJCHW9n5lFU9t
         BiXA==
X-Gm-Message-State: AC+VfDwpYidGD1te1yrjb7CRJXiTD8AZMUND2aL6vKSsltYysVP/UE1j
        OgIhS6On6CZ8bwCTdOHiZ2kZmOVL8dyIPbcHlqsRPg==
X-Google-Smtp-Source: ACHHUZ6/QErfgNLoYp0FQiQuiCfqJnBan2fToPNDl9aCZG3QeLYwipqJ1dP6etYKjx3rhGQB34DTY+n2a+kimFb8bvw=
X-Received: by 2002:a05:6e02:1a2e:b0:32b:1de1:17de with SMTP id
 g14-20020a056e021a2e00b0032b1de117demr208219ile.2.1682802125210; Sat, 29 Apr
 2023 14:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <1682329456-19418-1-git-send-email-renyu.zj@linux.alibaba.com>
In-Reply-To: <1682329456-19418-1-git-send-email-renyu.zj@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 29 Apr 2023 14:01:52 -0700
Message-ID: <CAP-5=fX1E_qZwmch-gKcarLGkWwmxZj9dM2XuQKrBLeDRfqg7Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Add JSON metrics for arm CMN and Yitian710 DDR
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Apr 24, 2023 at 2:44=E2=80=AFAM Jing Zhang <renyu.zj@linux.alibaba.=
com> wrote:
>
> Changes since RFC:
> - Refact arm-cmn PMU identifier.
> - Not add arm-cmn PMU aliasing currently because it's Eventcode is
>   difficult to define.
> - Rename ali_drw PMU identifier and Unit name.
> - Divide ali_drw PMU metric and aliasing into two patches.
>
> Add an identifier sysfs file for the yitian710 SoC DDR and arm CMN to
> allow userspace to identify the specific implementation of the device,
> so that the perf tool can match the corresponding uncore events and
> metrics through the identifier. Then added several general CMN700 metrics
> and yitian710 soc DDR metrics.
>
> $perf list:
> ...
> ali_drw:
>   hif_rmw
>        [A Read-Modify-Write Op at HIF interface. 64B. Unit: ali_drw]
>   hif_hi_pri_rd
>        [A high priority Read at HIF interface. 64B. Unit: ali_drw]
>   hif_rd
>        [A Read Op at HIF interface. 64B. Unit: ali_drw]
>   hif_rd_or_wr
>        [A Write or Read Op at HIF interface. 64B. Unit: ali_drw]
>   hif_wr
>        [A Write Op at HIF interface. 64B. Unit: ali_drw]
> ...
>
> $perf stat -M ddr_read_bandwidth.all ./test
>
> Performance counter stats for 'system wide':
>
>             38,150      hif_rd        #  2.4 MB/s  ddr_read_bandwidth.all
>      1,000,957,941 ns   duration_time
>
>        1.000957941 seconds time elapsed
>
> Jing Zhang (5):
>   driver/perf: Add identifier sysfs file for CMN
>   perf vendor events: Add JSON metrics for CMN-700
>   driver/perf: Add identifier sysfs file for Yitian 710 DDR
>   perf jevents: Add support for Yitian 710 DDR PMU aliasing
>   perf vendor events: Add JSON metrics for Yitian 710 DDR

The perf tool changes all make sense. John Garry is more of an expert
on the ARM part of this than me though.
Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  drivers/perf/alibaba_uncore_drw_pmu.c              |  27 ++
>  drivers/perf/arm-cmn.c                             |  49 +++
>  .../arch/arm64/arm/cmn700/sys/metrics.json         |  74 ++++
>  .../arm64/freescale/yitian710/sys/ali_drw.json     | 373 +++++++++++++++=
++++++
>  .../arm64/freescale/yitian710/sys/metrics.json     |  20 ++
>  tools/perf/pmu-events/jevents.py                   |   2 +
>  6 files changed, 545 insertions(+)
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
