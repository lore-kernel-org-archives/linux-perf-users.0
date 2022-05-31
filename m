Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA76C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 May 2022 22:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237834AbiEaW0J (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 May 2022 18:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbiEaW0J (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 May 2022 18:26:09 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8E29CF13;
        Tue, 31 May 2022 15:26:08 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id l10-20020a9d7a8a000000b0060b151de434so9129otn.2;
        Tue, 31 May 2022 15:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U/HhHjk87DNmOtvk2ThjSVTCRMcfpWWBfbOJFJqNM5w=;
        b=KIAkcCvxfNsD1xUIEFDe7ZzgX3nJOKq4Oe5ZaWgCfgEtzO9fp5WsfvS0AL5OD0iZLv
         lawiLlvxw++5kwV4oTPn0XnaPCdUfmIqo/g7rmW0Ao/GcsN5MKn32ZlIz8hrbNMp1Ysy
         MBfFWF4gXMZD83OcSW+B44VrrYK+e8UqTx8erMBU2G759AhgT67q/sIyUE7E751DM+jV
         UI6nVhuvtRNUln9vG2AJPh/+V1KAqy9RPGhnKhF3Lm+4BA+CqByy5Q1WDUfr9sUGY8ev
         xYzszi9uKc1rFdblxfj0qTai4ou5ILqThgu8xYeE0I7Kwzwciq5ktqpPO67T7KDAc8xC
         8LyQ==
X-Gm-Message-State: AOAM531UIQaX2mzzQGpcVvWkfENfHLRRaxWXMgGSsc75fKpZGNY+rBfe
        ExEg4RFXUQP2zpBkM1Ps9rOOp4gY/mxUZV1Kd/o=
X-Google-Smtp-Source: ABdhPJyjP86slnOiOlbM5K8gcqb0FH8w7fwtfGR/9pabENJX+H5SFQXQ+rntDTds0bS3dZAjx5ImNeGgcnZjRCRr57k=
X-Received: by 2002:a05:6830:1e83:b0:60b:1ad3:6296 with SMTP id
 n3-20020a0568301e8300b0060b1ad36296mr16440075otr.124.1654035967742; Tue, 31
 May 2022 15:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220530083645.253432-1-leo.yan@linaro.org>
In-Reply-To: <20220530083645.253432-1-leo.yan@linaro.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 31 May 2022 15:25:56 -0700
Message-ID: <CAM9d7cjKAEk1cOcuv+Ncu8pEhTEMLBJrR48RCn4rEAFQnNpwGw@mail.gmail.com>
Subject: Re: [PATCH] perf mem: Trace physical address for Arm SPE events
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        German Gomez <german.gomez@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Leo,

On Mon, May 30, 2022 at 1:37 AM Leo Yan <leo.yan@linaro.org> wrote:
>
> Currently, Arm SPE events don't trace physical address, therefore, the
> field 'phys_addr' is always zero in synthesized memory samples.  This
> leads to perf c2c tool cannot locate the memory node for samples.
>
> This patch enables configuration 'pa_enable' for Arm SPE events, so the
> physical address packet can be traced, finally this can allow perf c2c
> tool to locate properly for memory node.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Acked-by: Namhyung Kim <namhyung@kernel.org>


> ---
>  tools/perf/arch/arm64/util/mem-events.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/arch/arm64/util/mem-events.c b/tools/perf/arch/arm64/util/mem-events.c
> index be41721b9aa1..df817d1f9f3e 100644
> --- a/tools/perf/arch/arm64/util/mem-events.c
> +++ b/tools/perf/arch/arm64/util/mem-events.c
> @@ -5,9 +5,9 @@
>  #define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
>
>  static struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
> -       E("spe-load",   "arm_spe_0/ts_enable=1,load_filter=1,store_filter=0,min_latency=%u/",   "arm_spe_0"),
> -       E("spe-store",  "arm_spe_0/ts_enable=1,load_filter=0,store_filter=1/",                  "arm_spe_0"),
> -       E("spe-ldst",   "arm_spe_0/ts_enable=1,load_filter=1,store_filter=1,min_latency=%u/",   "arm_spe_0"),
> +       E("spe-load",   "arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=0,min_latency=%u/",       "arm_spe_0"),
> +       E("spe-store",  "arm_spe_0/ts_enable=1,pa_enable=1,load_filter=0,store_filter=1/",                      "arm_spe_0"),
> +       E("spe-ldst",   "arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=1,min_latency=%u/",       "arm_spe_0"),

Unrelated, but is there "arm_spe_1" or others?

Thanks,
Namhyung


>  };
>
>  static char mem_ev_name[100];
> --
> 2.25.1
>
