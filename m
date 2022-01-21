Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1986C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 21 Jan 2022 12:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350487AbiAUMpB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 21 Jan 2022 07:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380495AbiAUMov (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 21 Jan 2022 07:44:51 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1F5C061746
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Jan 2022 04:44:50 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id r132-20020a1c448a000000b0034e043aaac7so4817898wma.5
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Jan 2022 04:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DPQjdtK4pXoEDJ51K+ZcxZTPO84Dqge8Jmq/wEYY82I=;
        b=YOn+JJpaTq4eYiycePZ7qnAtcezSFmqZfjSUg+PQ8EExDCxkuoxpNrt+J6+bmx6RFr
         hhPSiNtKvghUg8lFwRVuSTrdy4o4Zh5Pbu3otC6JszaRZKLGMAJOJCmWFyzAij7kKSMP
         jn1GJtBgwbAExJ0ehEJ1qfdvaZ8vT/0BrcSvWkI0S6fntkcIj6e9P2zYM4WkatFO8XIZ
         bq2fPYT7g4guGDiSEUglon4PA8gHiz1bAhUJw8SjPOFox0jmpEvF3UUjLXFByeDKcFiZ
         VxwHeY1WRa1r4pMX6mIFORD8eXi+2dzqe+MwuNrzY9ucgeXicF5v2rcPPxw8VlvYuJu/
         NsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DPQjdtK4pXoEDJ51K+ZcxZTPO84Dqge8Jmq/wEYY82I=;
        b=mOTbH+FtUHc+ZbGFpL+pLnTw9t5rI5GNcxn+ZlO7vu12vFYHmJL+/fHyoXPhXvlGgw
         5FrrwkRDonQmAxZNCqldW997fwivaISZH4wlJdtuFkz/6V2dagTAHbV5KPQPsyYQANkg
         xONq/tHDc51W4oh58hYQ9HPhKxhTMmyzuH+q4KDMuzbozCQIV15WICTUjuGAgape3vT7
         VsiJbtH42WgpQO2aiGKFzCx1ndrHSog5i5qeaPRh8NlNzOCoXWpCCGpFUJoit1MLe128
         HRbSYH+tR8CZoqd2+MPQu1REx15wgLflw3nrHotEgmLuF/lVR5EAM0dv94UXsVKXujRY
         d1HA==
X-Gm-Message-State: AOAM531IPO04aCxmsXuI6qP4i8O2LZZDwOiwJ/cDj6feC11vdCK2rWnZ
        799DfsEd8OIuREaVrTLjtGla/8LEj7n0zF3s3cybrQ==
X-Google-Smtp-Source: ABdhPJz4QOjqVkZxNGF7KOwGwgPMHWlelSBELk2kW26iBm4WwgkvOXimF67qWWx4a11KNN8oUewr3BjwQ9LjfmEwKEg=
X-Received: by 2002:adf:df84:: with SMTP id z4mr3699794wrl.519.1642769088620;
 Fri, 21 Jan 2022 04:44:48 -0800 (PST)
MIME-Version: 1.0
References: <20220113091056.1297982-1-james.clark@arm.com> <20220113091056.1297982-4-james.clark@arm.com>
In-Reply-To: <20220113091056.1297982-4-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 21 Jan 2022 12:44:37 +0000
Message-ID: <CAJ9a7ViKA_vHd8WOfoxnHrjS4Cx7R9-G28VHMK7e03c+8vZ8Yw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] perf cs-etm: Update deduction of TRCCONFIGR
 register for branch broadcast
To:     James Clark <James.Clark@arm.com>
Cc:     suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, leo.yan@linaro.com,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, 13 Jan 2022 at 09:11, James Clark <james.clark@arm.com> wrote:
>
> Now that a config flag for branch broadcast has been added, take it into
> account when trying to deduce what the driver would have programmed the
> TRCCONFIGR register to.
>
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/include/linux/coresight-pmu.h | 2 ++
>  tools/perf/arch/arm/util/cs-etm.c   | 3 +++
>  2 files changed, 5 insertions(+)
>
> diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
> index 4ac5c081af93..6c2fd6cc5a98 100644
> --- a/tools/include/linux/coresight-pmu.h
> +++ b/tools/include/linux/coresight-pmu.h
> @@ -18,6 +18,7 @@
>   * ETMv3.5/PTM doesn't define ETMCR config bits with prefix "ETM3_" and
>   * directly use below macros as config bits.
>   */
> +#define ETM_OPT_BRANCH_BROADCAST 8
>  #define ETM_OPT_CYCACC         12
>  #define ETM_OPT_CTXTID         14
>  #define ETM_OPT_CTXTID2                15
> @@ -25,6 +26,7 @@
>  #define ETM_OPT_RETSTK         29
>
>  /* ETMv4 CONFIGR programming bits for the ETM OPTs */
> +#define ETM4_CFG_BIT_BB         3
>  #define ETM4_CFG_BIT_CYCACC    4
>  #define ETM4_CFG_BIT_CTXTID    6
>  #define ETM4_CFG_BIT_VMID      7
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index 293a23bf8be3..c7ef4e9b4a3a 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -527,6 +527,9 @@ static u64 cs_etmv4_get_config(struct auxtrace_record *itr)
>         if (config_opts & BIT(ETM_OPT_CTXTID2))
>                 config |= BIT(ETM4_CFG_BIT_VMID) |
>                           BIT(ETM4_CFG_BIT_VMID_OPT);
> +       if (config_opts & BIT(ETM_OPT_BRANCH_BROADCAST))
> +               config |= BIT(ETM4_CFG_BIT_BB);
> +
>         return config;
>  }
>
> --
> 2.28.0
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
