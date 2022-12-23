Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A41C4332F
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Dec 2022 09:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbiLWJzR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Dec 2022 04:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbiLWJyc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Dec 2022 04:54:32 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8EBDF15
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Dec 2022 01:54:31 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id x3so4531108pjv.4
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Dec 2022 01:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KTme1RC2DwAv2XimvOMl4fSX9I4qxsVKRwQQ2YNUVto=;
        b=RgKktLn/TQT/wQ5bd8DUVSJCfcvr5HTHA1b57i9sLLu7jMidAUbwYq6/+GpApOdnMW
         bm+3dQ/hak6YKrwyqoQjJelfhhYdfNvZRRUIWUX5KadwYUnN5lw/Ydak5J2KJQwPmpmV
         56I/p5jLttghMr72+mLCekUEwK7p3VilGUxBN2u120G+s4JywswENzP6YcdV0l6/PQ63
         VN4uBUm6Kh0yAHQ2j97XNXI+qtx+xa9AsvYRAe2HL5aeHFfglSikH0sEyFVOzXfv19IT
         5nak68W1XJeKOhZKkXpF+/m0EusC2kTwqdWr+MdfV4o1NnecgOa30AxxLjDHfEYrVxxi
         bbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KTme1RC2DwAv2XimvOMl4fSX9I4qxsVKRwQQ2YNUVto=;
        b=7Cb/FzEQYpyqSgmVxchKgWEDUyUNJ334cCwC4E2Po+dsgHwesKKgLNub3RfVuj9C/p
         MTDk+uW73s9O9dGa3rxT0WcqKl16zRlOw0KGDqQHb28YgPm9IWCMfkzpJt5UaVLFcj3d
         rMYTXFb+HS8kQ63+ImDLmRIQ3yI1kUvL8yTmJO9Ol0PePDGxj8PqsuWdq1Dn/s/QQjKH
         vd5QTyaJSniKnI5O/pMpYTGy4rSUva1kVm2qoZ15k0ka8svbxDAKPIYyc/XZ4OlMZhqh
         r8arTqgLvCEObLtALmVGH9ldTFaovvyS6xF3X8QGoyUxnTUHp1pkNEpigo+4WecRWT/D
         D05Q==
X-Gm-Message-State: AFqh2kqLBPLUobfE0l/vSr1mkpWIoEDJhmht5Ff4R0Cgy9r7QEZm3qdB
        5HvtZwSjX+V1gthP0tc1HQ17vrh//slCfrdwUU7TPQ==
X-Google-Smtp-Source: AMrXdXtVeazWf9gw9QzkduDrmThu+8/7C9asFQVbHLZ5tkYBWMCQrylxXgk188IvYiZQVcEbCsrglvmJ9iDX9YHzmOQ=
X-Received: by 2002:a17:90b:485:b0:219:720c:29cb with SMTP id
 bh5-20020a17090b048500b00219720c29cbmr935268pjb.76.1671789271110; Fri, 23 Dec
 2022 01:54:31 -0800 (PST)
MIME-Version: 1.0
References: <20221222160328.3639989-1-james.clark@arm.com> <20221222160328.3639989-6-james.clark@arm.com>
In-Reply-To: <20221222160328.3639989-6-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 23 Dec 2022 09:54:19 +0000
Message-ID: <CAJ9a7VjXKJk==Pt1rjMo12ROQJ4d4HD_TR+q+sC7N+HULiUCnQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] perf cs_etm: Keep separate symbols for ETMv4 and
 ETE parameters
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, tanmay@marvell.com,
        sgoutham@marvell.com, gcherian@marvell.com, lcherian@marvell.com,
        bbhushan2@marvell.com, German Gomez <german.gomez@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, 22 Dec 2022 at 16:07, James Clark <james.clark@arm.com> wrote:
>
> From: German Gomez <german.gomez@arm.com>
>
> Previously, adding a new parameter at the end of ETMv4 meant adding it
> somewhere in the middle of ETE, which is not supported by the current
> header version.
>
> Signed-off-by: German Gomez <german.gomez@arm.com>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/arch/arm/util/cs-etm.c | 43 ++++++++++++++++++++++++++-----
>  tools/perf/util/cs-etm-base.c     | 32 +++++++++++++++++------
>  tools/perf/util/cs-etm.c          | 12 ++++-----
>  tools/perf/util/cs-etm.h          | 11 +++++++-
>  4 files changed, 76 insertions(+), 22 deletions(-)
>
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index a346d5f3dafa..b526ffe550a5 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -53,7 +53,15 @@ static const char * const metadata_etmv4_ro[] = {
>         [CS_ETMV4_TRCIDR2]              = "trcidr/trcidr2",
>         [CS_ETMV4_TRCIDR8]              = "trcidr/trcidr8",
>         [CS_ETMV4_TRCAUTHSTATUS]        = "mgmt/trcauthstatus",
> -       [CS_ETE_TRCDEVARCH]             = "mgmt/trcdevarch"
> +};
> +
> +static const char * const metadata_ete_ro[] = {
> +       [CS_ETE_TRCIDR0]                = "trcidr/trcidr0",
> +       [CS_ETE_TRCIDR1]                = "trcidr/trcidr1",
> +       [CS_ETE_TRCIDR2]                = "trcidr/trcidr2",
> +       [CS_ETE_TRCIDR8]                = "trcidr/trcidr8",
> +       [CS_ETE_TRCAUTHSTATUS]          = "mgmt/trcauthstatus",
> +       [CS_ETE_TRCDEVARCH]             = "mgmt/trcdevarch",
>  };
>
>  static bool cs_etm_is_etmv4(struct auxtrace_record *itr, int cpu);
> @@ -617,7 +625,7 @@ static bool cs_etm_is_ete(struct auxtrace_record *itr, int cpu)
>  {
>         struct cs_etm_recording *ptr = container_of(itr, struct cs_etm_recording, itr);
>         struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
> -       int trcdevarch = cs_etm_get_ro(cs_etm_pmu, cpu, metadata_etmv4_ro[CS_ETE_TRCDEVARCH]);
> +       int trcdevarch = cs_etm_get_ro(cs_etm_pmu, cpu, metadata_ete_ro[CS_ETE_TRCDEVARCH]);
>
>         /*
>          * ETE if ARCHVER is 5 (ARCHVER is 4 for ETM) and ARCHPART is 0xA13.
> @@ -648,6 +656,31 @@ static void cs_etm_save_etmv4_header(__u64 data[], struct auxtrace_record *itr,
>                                                      metadata_etmv4_ro[CS_ETMV4_TRCAUTHSTATUS]);
>  }
>
> +static void cs_etm_save_ete_header(__u64 data[], struct auxtrace_record *itr, int cpu)
> +{
> +       struct cs_etm_recording *ptr = container_of(itr, struct cs_etm_recording, itr);
> +       struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
> +
> +       /* Get trace configuration register */
> +       data[CS_ETE_TRCCONFIGR] = cs_etmv4_get_config(itr);
> +       /* Get traceID from the framework */
> +       data[CS_ETE_TRCTRACEIDR] = coresight_get_trace_id(cpu);
> +       /* Get read-only information from sysFS */
> +       data[CS_ETE_TRCIDR0] = cs_etm_get_ro(cs_etm_pmu, cpu,
> +                                            metadata_ete_ro[CS_ETE_TRCIDR0]);
> +       data[CS_ETE_TRCIDR1] = cs_etm_get_ro(cs_etm_pmu, cpu,
> +                                            metadata_ete_ro[CS_ETE_TRCIDR1]);
> +       data[CS_ETE_TRCIDR2] = cs_etm_get_ro(cs_etm_pmu, cpu,
> +                                            metadata_ete_ro[CS_ETE_TRCIDR2]);
> +       data[CS_ETE_TRCIDR8] = cs_etm_get_ro(cs_etm_pmu, cpu,
> +                                            metadata_ete_ro[CS_ETE_TRCIDR8]);
> +       data[CS_ETE_TRCAUTHSTATUS] = cs_etm_get_ro(cs_etm_pmu, cpu,
> +                                                  metadata_ete_ro[CS_ETE_TRCAUTHSTATUS]);
> +       /* ETE uses the same registers as ETMv4 plus TRCDEVARCH */
> +       data[CS_ETE_TRCDEVARCH] = cs_etm_get_ro(cs_etm_pmu, cpu,
> +                                               metadata_ete_ro[CS_ETE_TRCDEVARCH]);
> +}
> +
>  static void cs_etm_get_metadata(int cpu, u32 *offset,
>                                 struct auxtrace_record *itr,
>                                 struct perf_record_auxtrace_info *info)
> @@ -661,11 +694,7 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
>         /* first see what kind of tracer this cpu is affined to */
>         if (cs_etm_is_ete(itr, cpu)) {
>                 magic = __perf_cs_ete_magic;
> -               /* ETE uses the same registers as ETMv4 plus TRCDEVARCH */
> -               cs_etm_save_etmv4_header(&info->priv[*offset], itr, cpu);
> -               info->priv[*offset + CS_ETE_TRCDEVARCH] =
> -                       cs_etm_get_ro(cs_etm_pmu, cpu,
> -                                     metadata_etmv4_ro[CS_ETE_TRCDEVARCH]);
> +               cs_etm_save_ete_header(&info->priv[*offset], itr, cpu);
>
>                 /* How much space was used */
>                 increment = CS_ETE_PRIV_MAX;
> diff --git a/tools/perf/util/cs-etm-base.c b/tools/perf/util/cs-etm-base.c
> index 597542410854..282042c6e944 100644
> --- a/tools/perf/util/cs-etm-base.c
> +++ b/tools/perf/util/cs-etm-base.c
> @@ -36,7 +36,20 @@ static const char * const cs_etmv4_priv_fmts[] = {
>         [CS_ETMV4_TRCIDR2]      = "     TRCIDR2                        %llx\n",
>         [CS_ETMV4_TRCIDR8]      = "     TRCIDR8                        %llx\n",
>         [CS_ETMV4_TRCAUTHSTATUS] = "    TRCAUTHSTATUS                  %llx\n",
> -       [CS_ETE_TRCDEVARCH]     = "     TRCDEVARCH                     %llx\n"
> +};
> +
> +static const char * const cs_ete_priv_fmts[] = {
> +       [CS_ETM_MAGIC]          = "     Magic number                   %llx\n",
> +       [CS_ETM_CPU]            = "     CPU                            %lld\n",
> +       [CS_ETM_NR_TRC_PARAMS]  = "     NR_TRC_PARAMS                  %llx\n",
> +       [CS_ETE_TRCCONFIGR]     = "     TRCCONFIGR                     %llx\n",
> +       [CS_ETE_TRCTRACEIDR]    = "     TRCTRACEIDR                    %llx\n",
> +       [CS_ETE_TRCIDR0]        = "     TRCIDR0                        %llx\n",
> +       [CS_ETE_TRCIDR1]        = "     TRCIDR1                        %llx\n",
> +       [CS_ETE_TRCIDR2]        = "     TRCIDR2                        %llx\n",
> +       [CS_ETE_TRCIDR8]        = "     TRCIDR8                        %llx\n",
> +       [CS_ETE_TRCAUTHSTATUS]  = "     TRCAUTHSTATUS                  %llx\n",
> +       [CS_ETE_TRCDEVARCH]     = "     TRCDEVARCH                     %llx\n",
>  };
>
>  static const char * const param_unk_fmt =
> @@ -96,19 +109,22 @@ static int cs_etm__print_cpu_metadata_v1(u64 *val, int *offset)
>                         else
>                                 fprintf(stdout, cs_etm_priv_fmts[j], val[i]);
>                 }
> -       } else if (magic == __perf_cs_etmv4_magic || magic == __perf_cs_ete_magic) {
> -               /*
> -                * ETE and ETMv4 can be printed in the same block because the number of parameters
> -                * is saved and they share the list of parameter names. ETE is also only supported
> -                * in V1 files.
> -                */
> +       } else if (magic == __perf_cs_etmv4_magic) {
>                 for (j = 0; j < total_params; j++, i++) {
>                         /* if newer record - could be excess params */
> -                       if (j >= CS_ETE_PRIV_MAX)
> +                       if (j >= CS_ETMV4_PRIV_MAX)
>                                 fprintf(stdout, param_unk_fmt, j, val[i]);
>                         else
>                                 fprintf(stdout, cs_etmv4_priv_fmts[j], val[i]);
>                 }
> +       } else if (magic == __perf_cs_ete_magic) {
> +               for (j = 0; j < total_params; j++, i++) {
> +                       /* if newer record - could be excess params */
> +                       if (j >= CS_ETE_PRIV_MAX)
> +                               fprintf(stdout, param_unk_fmt, j, val[i]);
> +                       else
> +                               fprintf(stdout, cs_ete_priv_fmts[j], val[i]);
> +               }
>         } else {
>                 /* failure - note bad magic value and error out */
>                 fprintf(stdout, magic_unk_fmt, magic);
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 33303d03c2fa..879576d5f899 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -464,12 +464,12 @@ static void cs_etm__set_trace_param_ete(struct cs_etm_trace_params *t_params,
>         u64 **metadata = etm->metadata;
>
>         t_params[idx].protocol = CS_ETM_PROTO_ETE;
> -       t_params[idx].ete.reg_idr0 = metadata[idx][CS_ETMV4_TRCIDR0];
> -       t_params[idx].ete.reg_idr1 = metadata[idx][CS_ETMV4_TRCIDR1];
> -       t_params[idx].ete.reg_idr2 = metadata[idx][CS_ETMV4_TRCIDR2];
> -       t_params[idx].ete.reg_idr8 = metadata[idx][CS_ETMV4_TRCIDR8];
> -       t_params[idx].ete.reg_configr = metadata[idx][CS_ETMV4_TRCCONFIGR];
> -       t_params[idx].ete.reg_traceidr = metadata[idx][CS_ETMV4_TRCTRACEIDR];
> +       t_params[idx].ete.reg_idr0 = metadata[idx][CS_ETE_TRCIDR0];
> +       t_params[idx].ete.reg_idr1 = metadata[idx][CS_ETE_TRCIDR1];
> +       t_params[idx].ete.reg_idr2 = metadata[idx][CS_ETE_TRCIDR2];
> +       t_params[idx].ete.reg_idr8 = metadata[idx][CS_ETE_TRCIDR8];
> +       t_params[idx].ete.reg_configr = metadata[idx][CS_ETE_TRCCONFIGR];
> +       t_params[idx].ete.reg_traceidr = metadata[idx][CS_ETE_TRCTRACEIDR];
>         t_params[idx].ete.reg_devarch = metadata[idx][CS_ETE_TRCDEVARCH];
>  }
>
> diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> index 5da50d5dae6b..c5925428afa9 100644
> --- a/tools/perf/util/cs-etm.h
> +++ b/tools/perf/util/cs-etm.h
> @@ -82,7 +82,16 @@ enum {
>   * added in header V1
>   */
>  enum {
> -       CS_ETE_TRCDEVARCH = CS_ETMV4_PRIV_MAX,
> +       /* Dynamic, configurable parameters */
> +       CS_ETE_TRCCONFIGR = CS_ETM_COMMON_BLK_MAX_V1,
> +       CS_ETE_TRCTRACEIDR,
> +       /* RO, taken from sysFS */
> +       CS_ETE_TRCIDR0,
> +       CS_ETE_TRCIDR1,
> +       CS_ETE_TRCIDR2,
> +       CS_ETE_TRCIDR8,
> +       CS_ETE_TRCAUTHSTATUS,
> +       CS_ETE_TRCDEVARCH,
>         CS_ETE_PRIV_MAX
>  };
>
> --
> 2.25.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
