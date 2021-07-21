Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B777DC07E9B
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 10:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96647611CE
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 10:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbhGUJaA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 21 Jul 2021 05:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238000AbhGUJIg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Jul 2021 05:08:36 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD675C0613DE
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jul 2021 02:48:37 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m2so1497986wrq.2
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jul 2021 02:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c+CueOPSFipiw/XJiAIFpj+yTNZ5ToaTqkjqSIuNMpE=;
        b=MVc3/mriI9k583ToR9PCvBMUQPpyNlUEs9LUVL/+cCvXIQcabkNxAZe2i7LeK4op/Y
         P9Ibv8HNJZoIle+3ZvrhU1FG2Xi2WggMmBak+D2dbI2VGPHRxkhYNG4F1lw8+jnBo/+Y
         4E6O79g8hNQaESitJ/FUtfkFKubKYvNHR7IowqIkiU8qFAKotamBu2FN/MWmRyyZ6YMS
         5tazJYLcK4oJUuaMILvRXNQdmxnsGWZ9kKVfNXTQv55KFzrJihH45T112xqG5dJCXxB3
         vXM3PlnhuGELB0JQd69Vzdk9TGwiwbhwhpOrPeP5Xqb7jf+wL/cM1I6Z4J8iS1jpDZhL
         uZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c+CueOPSFipiw/XJiAIFpj+yTNZ5ToaTqkjqSIuNMpE=;
        b=Ih8PuW627gjS+O0JceeEmZvqGPPk0gf1OMAVsqTwAKV7ZLqJvOpzHeqEoQwBggeixN
         FkXy1fJZ+qa3mI88x7uwcr2mziIyxkTWw72m5H/TayxleOoTnu1/cxkwQ372ZxawWxC2
         LT4ZNUT76gUAa4q9hS7Z5bIbmt/AnLFzsJloCMIZEIQymF0v8ciD/Vv/c89GxDR0Sqy/
         j4qsVuPgxsxjKwZeSF4Vfqb0Pj1YmDRiFCSLOWR176EYd9ZUNh0UYhvGd6gM7iuSf+SP
         j6LPrxM5eDF22iemsjdoc+ABPZe8+smSbbuESpPy8nPgnp0gtj+2H3BPV9boHesm1W5S
         QgIQ==
X-Gm-Message-State: AOAM532hJs5o7pUd0o+/BiWTaCpID3PhnLPJP7vhE1W2XVWoJ2so67bt
        mt0QIwI5A6fgkpkzXaySv/UUPXZE+O3hMXy9D+GEFg==
X-Google-Smtp-Source: ABdhPJzwkpznRK0IRjduzCynNactBKoBSXW5Eamm9KWhj2PKS0Vwwb58NSrjyuOm8LV/oyF9XOiEfJ1tmcmACqDIYoc=
X-Received: by 2002:a5d:4b44:: with SMTP id w4mr40151015wrs.275.1626860916345;
 Wed, 21 Jul 2021 02:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210721090706.21523-1-james.clark@arm.com> <20210721090706.21523-4-james.clark@arm.com>
In-Reply-To: <20210721090706.21523-4-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 21 Jul 2021 10:48:25 +0100
Message-ID: <CAJ9a7Vjz_CMugYrLcAqr_aFsK6jYcqR3xLwJUi9KTXB3aPjnEQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] perf cs-etm: Save TRCDEVARCH register
To:     James Clark <james.clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Al Grant <al.grant@arm.com>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

HI James,

On Wed, 21 Jul 2021 at 10:07, James Clark <james.clark@arm.com> wrote:
>
> Now that the metadata has a length field we can add extra registers
> without breaking any previous versions of perf.
>
> Save the TRCDEVARCH register so that it can be used to configure the ETE
> decoder in the next commit. If the sysfs file doesn't exist then 0 will
> be saved which is an impossible register value and can also be used to
> signify that the file couldn't be read.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/arch/arm/util/cs-etm.c | 13 ++++++++++++-
>  tools/perf/util/cs-etm.c          |  1 +
>  tools/perf/util/cs-etm.h          |  5 +++--
>  3 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index 85168d87b2d7..65a863bdf5cc 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -53,6 +53,7 @@ static const char *metadata_etmv4_ro[CS_ETMV4_PRIV_MAX] = {
>         [CS_ETMV4_TRCIDR2]              = "trcidr/trcidr2",
>         [CS_ETMV4_TRCIDR8]              = "trcidr/trcidr8",
>         [CS_ETMV4_TRCAUTHSTATUS]        = "mgmt/trcauthstatus",
> +       [CS_ETE_TRCDEVARCH]             = "mgmt/trcdevarch"
>  };
>
>  static bool cs_etm_is_etmv4(struct auxtrace_record *itr, int cpu);
> @@ -73,7 +74,7 @@ static int cs_etm_set_context_id(struct auxtrace_record *itr,
>         if (!cs_etm_is_etmv4(itr, cpu))
>                 goto out;
>
> -       /* Get a handle on TRCIRD2 */
> +       /* Get a handle on TRCIDR2 */
>         snprintf(path, PATH_MAX, "cpu%d/%s",
>                  cpu, metadata_etmv4_ro[CS_ETMV4_TRCIDR2]);
>         err = perf_pmu__scan_file(cs_etm_pmu, path, "%x", &val);
> @@ -643,6 +644,16 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
>                         cs_etm_get_ro(cs_etm_pmu, cpu,
>                                       metadata_etmv4_ro
>                                       [CS_ETMV4_TRCAUTHSTATUS]);
> +               /*
> +                * ETE uses the same registers as ETMv4 plus TRCDEVARCH. It's also backwards
> +                * compatible, so don't change the magic number otherwise that will reduce the
> +                * number of versions of perf that can open it. Just append TRCDEVARCH to the end of
> +                * the register block and allow newer versions of perf to make use. cs_etm_get_ro()
> +                * returns 0 if it couldn't be read.
> +                */

ETE is a superset of ETMv4, but an old perf that only knows ETMv4
cannot be guaranteed to decode all ETE due to new packet types.
Therefore do we want to allow old perfs to decode only some ETE,
possibly with errors?

I think it would be better to add in a new magic number for the new
decoder rather than have some grey overlap area were an "older" perf
might work intermittently dependent on the packets generated in a
particular trace run.

Regards

Mike

> +               info->priv[*offset + CS_ETE_TRCDEVARCH] =
> +                       cs_etm_get_ro(cs_etm_pmu, cpu,
> +                                     metadata_etmv4_ro[CS_ETE_TRCDEVARCH]);
>
>                 /* How much space was used */
>                 increment = CS_ETMV4_PRIV_MAX;
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 62769a84a53f..68978f6707a8 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -2508,6 +2508,7 @@ static const char * const cs_etmv4_priv_fmts[] = {
>         [CS_ETMV4_TRCIDR2]      = "     TRCIDR2                        %llx\n",
>         [CS_ETMV4_TRCIDR8]      = "     TRCIDR8                        %llx\n",
>         [CS_ETMV4_TRCAUTHSTATUS] = "    TRCAUTHSTATUS                  %llx\n",
> +       [CS_ETE_TRCDEVARCH]     = "     TRCDEVARCH                     %llx\n"
>  };
>
>  static const char * const param_unk_fmt =
> diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> index d65c7b19407d..52d82dce9d59 100644
> --- a/tools/perf/util/cs-etm.h
> +++ b/tools/perf/util/cs-etm.h
> @@ -59,7 +59,7 @@ enum {
>  /* define fixed version 0 length - allow new format reader to read old files. */
>  #define CS_ETM_NR_TRC_PARAMS_V0 (CS_ETM_ETMIDR - CS_ETM_ETMCR + 1)
>
> -/* ETMv4 metadata */
> +/* ETMv4 + ETE metadata */
>  enum {
>         /* Dynamic, configurable parameters */
>         CS_ETMV4_TRCCONFIGR = CS_ETM_COMMON_BLK_MAX_V1,
> @@ -70,7 +70,8 @@ enum {
>         CS_ETMV4_TRCIDR2,
>         CS_ETMV4_TRCIDR8,
>         CS_ETMV4_TRCAUTHSTATUS,
> -       CS_ETMV4_PRIV_MAX,
> +       CS_ETE_TRCDEVARCH,
> +       CS_ETMV4_PRIV_MAX
>  };
>
>  /* define fixed version 0 length - allow new format reader to read old files. */
> --
> 2.28.0
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
