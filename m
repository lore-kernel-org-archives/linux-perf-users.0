Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AC9C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 18:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3D1161359
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 18:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236453AbhI1SGI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Sep 2021 14:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241719AbhI1SGH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Sep 2021 14:06:07 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6A8C06161C
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Sep 2021 11:04:27 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id s20so28534925ioa.4
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Sep 2021 11:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bDVYOLB7ex1Q9vkrSPm262dNZJoCknbaodkzbjGXegw=;
        b=Cb6mSB0S4he9qRLlc0Lvdl3gJQCWvUTjqMFSk/AIHILMmJAMLUJGmnHrAr3goy9gKm
         GgMGzMhq3N+RRR0UMSb07dfE4AZmvIs7OETSKRAe+/aeu6G6rmah+xK+r0aQ1l7rsiwI
         cpHYyiPrpPdodYiFJeiFVPLkcXDvx0sPGwsTc1QbB/ER3NN+dbxvpVmMuww+roDFJR3C
         VoUiKK3UmFt6iITCdDut2+e1VWqQNiQ//MlxxbIHIMsaWZSNpGVH57UBFDvZUGnHjitQ
         LtjyZDblOJAKJs5nybJcZfEUk+uGLrpaRfhd38xGBJV53ZNvlA5O7Cg0cs1Dl9yFt00w
         24mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bDVYOLB7ex1Q9vkrSPm262dNZJoCknbaodkzbjGXegw=;
        b=XLgSoFb8g0lUgcu2hlKfvccxDbClxO20eRD6ppVuJHkGJSsSXLu699+YcAmx4w27s7
         j9sKps391q//yt5XcppKopFLLZhyF6HnJqXAQALFTGjH/lEIIOACdarHTfnudwB0k9bS
         EKYME8qA4pLiEr/kUXmNEiIknHOXyhbWhCwnfgpgq6qME+6KBITzi4RDTpxsOzeqQSrL
         MV7v+/2OIGk94/9uB2mJv1NqI7VYkTyN7A625lXR5NN1SS+GFsYvsIllw8rDYYBndkDQ
         2LrQ7V/Eh4O6khdBtLxV6gdtwGo9bjPfXt61nTKSvYGgIVTWyBgi/07tH+6LniJkXw/l
         E28A==
X-Gm-Message-State: AOAM533n31SrLKIJAJxtNht6W1EGzU7GFwwE0+GHzIczDlnN+nFB8xhY
        trZOuxy1OjdVgwBYMX+v4Gz9UND2txfODmb8sRN3YQ==
X-Google-Smtp-Source: ABdhPJwOOjCVDszVS05Ucr+Nrat3t+eXy89miaekDdENbKYLkKTvV+bbF/pByUMwRcR0yEbSWMJP2H16vbKbY/p6Vpk=
X-Received: by 2002:a5e:de08:: with SMTP id e8mr5114015iok.151.1632852267031;
 Tue, 28 Sep 2021 11:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <1631795665-240946-1-git-send-email-john.garry@huawei.com> <1631795665-240946-6-git-send-email-john.garry@huawei.com>
In-Reply-To: <1631795665-240946-6-git-send-email-john.garry@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 28 Sep 2021 11:04:11 -0700
Message-ID: <CAP-5=fV1fkxRNHy7OGP8GxXeX81ZQmtr7CqbBUpNkjVY_zSvQQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] perf vendor events arm64: Revise hip08 uncore events
To:     John Garry <john.garry@huawei.com>
Cc:     will@kernel.org, mathieu.poirier@linaro.org, leo.yan@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangshaokun@hisilicon.com,
        liuqi115@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Sep 16, 2021 at 5:39 AM John Garry <john.garry@huawei.com> wrote:
>
> To improve alias matching, remove the PMU name prefix from the EventName.
> This will mean that the pmu code will merge aliases, such that we no
> longer get a huge list of per-PMU events - see perf_pmu_merge_alias().
>
> Also make the following associated changes:
> - Use "ConfigCode" rather than "EventCode", so the pmu code is not so
>   disagreeable about inconsistent event codes
> - Add undocumented HHA event codes to allow alias merging (for those
>   events)
>
> Signed-off-by: John Garry <john.garry@huawei.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  .../arm64/hisilicon/hip08/uncore-ddrc.json    |  32 ++---
>  .../arm64/hisilicon/hip08/uncore-hha.json     | 120 +++++++++++++++---
>  .../arm64/hisilicon/hip08/uncore-l3c.json     |  52 ++++----
>  3 files changed, 142 insertions(+), 62 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json
> index 61514d38601b..2b3cb55df288 100644
> --- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json
> +++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json
> @@ -1,56 +1,56 @@
>  [
>     {
> -           "EventCode": "0x00",
> -           "EventName": "uncore_hisi_ddrc.flux_wr",
> +           "ConfigCode": "0x00",
> +           "EventName": "flux_wr",
>             "BriefDescription": "DDRC total write operations",
>             "PublicDescription": "DDRC total write operations",
>             "Unit": "hisi_sccl,ddrc"
>     },
>     {
> -           "EventCode": "0x01",
> -           "EventName": "uncore_hisi_ddrc.flux_rd",
> +           "ConfigCode": "0x01",
> +           "EventName": "flux_rd",
>             "BriefDescription": "DDRC total read operations",
>             "PublicDescription": "DDRC total read operations",
>             "Unit": "hisi_sccl,ddrc"
>     },
>     {
> -           "EventCode": "0x02",
> -           "EventName": "uncore_hisi_ddrc.flux_wcmd",
> +           "ConfigCode": "0x02",
> +           "EventName": "flux_wcmd",
>             "BriefDescription": "DDRC write commands",
>             "PublicDescription": "DDRC write commands",
>             "Unit": "hisi_sccl,ddrc"
>     },
>     {
> -           "EventCode": "0x03",
> -           "EventName": "uncore_hisi_ddrc.flux_rcmd",
> +           "ConfigCode": "0x03",
> +           "EventName": "flux_rcmd",
>             "BriefDescription": "DDRC read commands",
>             "PublicDescription": "DDRC read commands",
>             "Unit": "hisi_sccl,ddrc"
>     },
>     {
> -           "EventCode": "0x04",
> -           "EventName": "uncore_hisi_ddrc.pre_cmd",
> +           "ConfigCode": "0x04",
> +           "EventName": "pre_cmd",
>             "BriefDescription": "DDRC precharge commands",
>             "PublicDescription": "DDRC precharge commands",
>             "Unit": "hisi_sccl,ddrc"
>     },
>     {
> -           "EventCode": "0x05",
> -           "EventName": "uncore_hisi_ddrc.act_cmd",
> +           "ConfigCode": "0x05",
> +           "EventName": "act_cmd",
>             "BriefDescription": "DDRC active commands",
>             "PublicDescription": "DDRC active commands",
>             "Unit": "hisi_sccl,ddrc"
>     },
>     {
> -           "EventCode": "0x06",
> -           "EventName": "uncore_hisi_ddrc.rnk_chg",
> +           "ConfigCode": "0x06",
> +           "EventName": "rnk_chg",
>             "BriefDescription": "DDRC rank commands",
>             "PublicDescription": "DDRC rank commands",
>             "Unit": "hisi_sccl,ddrc"
>     },
>     {
> -           "EventCode": "0x07",
> -           "EventName": "uncore_hisi_ddrc.rw_chg",
> +           "ConfigCode": "0x07",
> +           "EventName": "rw_chg",
>             "BriefDescription": "DDRC read and write changes",
>             "PublicDescription": "DDRC read and write changes",
>             "Unit": "hisi_sccl,ddrc"
> diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
> index ada86782933f..9a7ec7af2060 100644
> --- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
> +++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
> @@ -1,72 +1,152 @@
>  [
>     {
> -           "EventCode": "0x00",
> -           "EventName": "uncore_hisi_hha.rx_ops_num",
> +           "ConfigCode": "0x00",
> +           "EventName": "rx_ops_num",
>             "BriefDescription": "The number of all operations received by the HHA",
>             "PublicDescription": "The number of all operations received by the HHA",
>             "Unit": "hisi_sccl,hha"
>     },
>     {
> -           "EventCode": "0x01",
> -           "EventName": "uncore_hisi_hha.rx_outer",
> +           "ConfigCode": "0x01",
> +           "EventName": "rx_outer",
>             "BriefDescription": "The number of all operations received by the HHA from another socket",
>             "PublicDescription": "The number of all operations received by the HHA from another socket",
>             "Unit": "hisi_sccl,hha"
>     },
>     {
> -           "EventCode": "0x02",
> -           "EventName": "uncore_hisi_hha.rx_sccl",
> +           "ConfigCode": "0x02",
> +           "EventName": "rx_sccl",
>             "BriefDescription": "The number of all operations received by the HHA from another SCCL in this socket",
>             "PublicDescription": "The number of all operations received by the HHA from another SCCL in this socket",
>             "Unit": "hisi_sccl,hha"
>     },
>     {
> -           "EventCode": "0x03",
> -           "EventName": "uncore_hisi_hha.rx_ccix",
> +           "ConfigCode": "0x03",
> +           "EventName": "rx_ccix",
>             "BriefDescription": "Count of the number of operations that HHA has received from CCIX",
>             "PublicDescription": "Count of the number of operations that HHA has received from CCIX",
>             "Unit": "hisi_sccl,hha"
>     },
>     {
> -           "EventCode": "0x1c",
> -           "EventName": "uncore_hisi_hha.rd_ddr_64b",
> +           "ConfigCode": "0x4",
> +           "EventName": "rx_wbi",
> +           "Unit": "hisi_sccl,hha"
> +   },
> +   {
> +           "ConfigCode": "0x5",
> +           "EventName": "rx_wbip",
> +           "Unit": "hisi_sccl,hha"
> +   },
> +   {
> +           "ConfigCode": "0x11",
> +           "EventName": "rx_wtistash",
> +           "Unit": "hisi_sccl,hha"
> +   },
> +   {
> +           "ConfigCode": "0x1c",
> +           "EventName": "rd_ddr_64b",
>             "BriefDescription": "The number of read operations sent by HHA to DDRC which size is 64 bytes",
>             "PublicDescription": "The number of read operations sent by HHA to DDRC which size is 64bytes",
>             "Unit": "hisi_sccl,hha"
>     },
>     {
> -           "EventCode": "0x1d",
> -           "EventName": "uncore_hisi_hha.wr_ddr_64b",
> +           "ConfigCode": "0x1d",
> +           "EventName": "wr_ddr_64b",
>             "BriefDescription": "The number of write operations sent by HHA to DDRC which size is 64 bytes",
>             "PublicDescription": "The number of write operations sent by HHA to DDRC which size is 64 bytes",
>             "Unit": "hisi_sccl,hha"
>     },
>     {
> -           "EventCode": "0x1e",
> -           "EventName": "uncore_hisi_hha.rd_ddr_128b",
> +           "ConfigCode": "0x1e",
> +           "EventName": "rd_ddr_128b",
>             "BriefDescription": "The number of read operations sent by HHA to DDRC which size is 128 bytes",
>             "PublicDescription": "The number of read operations sent by HHA to DDRC which size is 128 bytes",
>             "Unit": "hisi_sccl,hha"
>     },
>     {
> -           "EventCode": "0x1f",
> -           "EventName": "uncore_hisi_hha.wr_ddr_128b",
> +           "ConfigCode": "0x1f",
> +           "EventName": "wr_ddr_128b",
>             "BriefDescription": "The number of write operations sent by HHA to DDRC which size is 128 bytes",
>             "PublicDescription": "The number of write operations sent by HHA to DDRC which size is 128 bytes",
>             "Unit": "hisi_sccl,hha"
>     },
>     {
> -           "EventCode": "0x20",
> -           "EventName": "uncore_hisi_hha.spill_num",
> +           "ConfigCode": "0x20",
> +           "EventName": "spill_num",
>             "BriefDescription": "Count of the number of spill operations that the HHA has sent",
>             "PublicDescription": "Count of the number of spill operations that the HHA has sent",
>             "Unit": "hisi_sccl,hha"
>     },
>     {
> -           "EventCode": "0x21",
> -           "EventName": "uncore_hisi_hha.spill_success",
> +           "ConfigCode": "0x21",
> +           "EventName": "spill_success",
>             "BriefDescription": "Count of the number of successful spill operations that the HHA has sent",
>             "PublicDescription": "Count of the number of successful spill operations that the HHA has sent",
>             "Unit": "hisi_sccl,hha"
> +   },
> +   {
> +           "ConfigCode": "0x23",
> +           "EventName": "bi_num",
> +           "Unit": "hisi_sccl,hha"
> +   },
> +   {
> +           "ConfigCode": "0x32",
> +           "EventName": "mediated_num",
> +           "Unit": "hisi_sccl,hha"
> +   },
> +   {
> +           "ConfigCode": "0x33",
> +           "EventName": "tx_snp_num",
> +           "Unit": "hisi_sccl,hha"
> +   },
> +   {
> +           "ConfigCode": "0x34",
> +           "EventName": "tx_snp_outer",
> +           "Unit": "hisi_sccl,hha"
> +   },
> +   {
> +           "ConfigCode": "0x35",
> +           "EventName": "tx_snp_ccix",
> +           "Unit": "hisi_sccl,hha"
> +   },
> +   {
> +           "ConfigCode": "0x38",
> +           "EventName": "rx_snprspdata",
> +           "Unit": "hisi_sccl,hha"
> +   },
> +   {
> +           "ConfigCode": "0x3c",
> +           "EventName": "rx_snprsp_outer",
> +           "Unit": "hisi_sccl,hha"
> +   },
> +   {
> +           "ConfigCode": "0x40",
> +           "EventName": "sdir-lookup",
> +           "Unit": "hisi_sccl,hha"
> +   },
> +   {
> +           "ConfigCode": "0x41",
> +           "EventName": "edir-lookup",
> +           "Unit": "hisi_sccl,hha"
> +   },
> +   {
> +           "ConfigCode": "0x42",
> +           "EventName": "sdir-hit",
> +           "Unit": "hisi_sccl,hha"
> +   },
> +   {
> +           "ConfigCode": "0x43",
> +           "EventName": "edir-hit",
> +           "Unit": "hisi_sccl,hha"
> +   },
> +   {
> +           "ConfigCode": "0x4c",
> +           "EventName": "sdir-home-migrate",
> +           "Unit": "hisi_sccl,hha"
> +   },
> +   {
> +           "ConfigCode": "0x4d",
> +           "EventName": "edir-home-migrate",
> +           "Unit": "hisi_sccl,hha"
>     }
>  ]
> diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json
> index 67ab19e8cf3a..e3479b65be9a 100644
> --- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json
> +++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json
> @@ -1,91 +1,91 @@
>  [
>     {
> -           "EventCode": "0x00",
> -           "EventName": "uncore_hisi_l3c.rd_cpipe",
> +           "ConfigCode": "0x00",
> +           "EventName": "rd_cpipe",
>             "BriefDescription": "Total read accesses",
>             "PublicDescription": "Total read accesses",
>             "Unit": "hisi_sccl,l3c"
>     },
>     {
> -           "EventCode": "0x01",
> -           "EventName": "uncore_hisi_l3c.wr_cpipe",
> +           "ConfigCode": "0x01",
> +           "EventName": "wr_cpipe",
>             "BriefDescription": "Total write accesses",
>             "PublicDescription": "Total write accesses",
>             "Unit": "hisi_sccl,l3c"
>     },
>     {
> -           "EventCode": "0x02",
> -           "EventName": "uncore_hisi_l3c.rd_hit_cpipe",
> +           "ConfigCode": "0x02",
> +           "EventName": "rd_hit_cpipe",
>             "BriefDescription": "Total read hits",
>             "PublicDescription": "Total read hits",
>             "Unit": "hisi_sccl,l3c"
>     },
>     {
> -           "EventCode": "0x03",
> -           "EventName": "uncore_hisi_l3c.wr_hit_cpipe",
> +           "ConfigCode": "0x03",
> +           "EventName": "wr_hit_cpipe",
>             "BriefDescription": "Total write hits",
>             "PublicDescription": "Total write hits",
>             "Unit": "hisi_sccl,l3c"
>     },
>     {
> -           "EventCode": "0x04",
> -           "EventName": "uncore_hisi_l3c.victim_num",
> +           "ConfigCode": "0x04",
> +           "EventName": "victim_num",
>             "BriefDescription": "l3c precharge commands",
>             "PublicDescription": "l3c precharge commands",
>             "Unit": "hisi_sccl,l3c"
>     },
>     {
> -           "EventCode": "0x20",
> -           "EventName": "uncore_hisi_l3c.rd_spipe",
> +           "ConfigCode": "0x20",
> +           "EventName": "rd_spipe",
>             "BriefDescription": "Count of the number of read lines that come from this cluster of CPU core in spipe",
>             "PublicDescription": "Count of the number of read lines that come from this cluster of CPU core in spipe",
>             "Unit": "hisi_sccl,l3c"
>     },
>     {
> -           "EventCode": "0x21",
> -           "EventName": "uncore_hisi_l3c.wr_spipe",
> +           "ConfigCode": "0x21",
> +           "EventName": "wr_spipe",
>             "BriefDescription": "Count of the number of write lines that come from this cluster of CPU core in spipe",
>             "PublicDescription": "Count of the number of write lines that come from this cluster of CPU core in spipe",
>             "Unit": "hisi_sccl,l3c"
>     },
>     {
> -           "EventCode": "0x22",
> -           "EventName": "uncore_hisi_l3c.rd_hit_spipe",
> +           "ConfigCode": "0x22",
> +           "EventName": "rd_hit_spipe",
>             "BriefDescription": "Count of the number of read lines that hits in spipe of this L3C",
>             "PublicDescription": "Count of the number of read lines that hits in spipe of this L3C",
>             "Unit": "hisi_sccl,l3c"
>     },
>     {
> -           "EventCode": "0x23",
> -           "EventName": "uncore_hisi_l3c.wr_hit_spipe",
> +           "ConfigCode": "0x23",
> +           "EventName": "wr_hit_spipe",
>             "BriefDescription": "Count of the number of write lines that hits in spipe of this L3C",
>             "PublicDescription": "Count of the number of write lines that hits in spipe of this L3C",
>             "Unit": "hisi_sccl,l3c"
>     },
>     {
> -           "EventCode": "0x29",
> -           "EventName": "uncore_hisi_l3c.back_invalid",
> +           "ConfigCode": "0x29",
> +           "EventName": "back_invalid",
>             "BriefDescription": "Count of the number of L3C back invalid operations",
>             "PublicDescription": "Count of the number of L3C back invalid operations",
>             "Unit": "hisi_sccl,l3c"
>     },
>     {
> -           "EventCode": "0x40",
> -           "EventName": "uncore_hisi_l3c.retry_cpu",
> +           "ConfigCode": "0x40",
> +           "EventName": "retry_cpu",
>             "BriefDescription": "Count of the number of retry that L3C suppresses the CPU operations",
>             "PublicDescription": "Count of the number of retry that L3C suppresses the CPU operations",
>             "Unit": "hisi_sccl,l3c"
>     },
>     {
> -           "EventCode": "0x41",
> -           "EventName": "uncore_hisi_l3c.retry_ring",
> +           "ConfigCode": "0x41",
> +           "EventName": "retry_ring",
>             "BriefDescription": "Count of the number of retry that L3C suppresses the ring operations",
>             "PublicDescription": "Count of the number of retry that L3C suppresses the ring operations",
>             "Unit": "hisi_sccl,l3c"
>     },
>     {
> -           "EventCode": "0x42",
> -           "EventName": "uncore_hisi_l3c.prefetch_drop",
> +           "ConfigCode": "0x42",
> +           "EventName": "prefetch_drop",
>             "BriefDescription": "Count of the number of prefetch drops from this L3C",
>             "PublicDescription": "Count of the number of prefetch drops from this L3C",
>             "Unit": "hisi_sccl,l3c"
> --
> 2.26.2
>
