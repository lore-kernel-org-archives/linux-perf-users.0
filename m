Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579C3C4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 08:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A60060F6B
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 08:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbhG3IaJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Jul 2021 04:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbhG3IaJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jul 2021 04:30:09 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E50C061765;
        Fri, 30 Jul 2021 01:30:03 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id g15so10259288wrd.3;
        Fri, 30 Jul 2021 01:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=n+JT42UW3IX9wla9IjzVJHPpAx8LymWRP5IJmE/8TXw=;
        b=TBuannp55Fo6X9qwBaBst5wqKodJRSvCB7kPMWugQpuHcP9OPhi9oam5JoZ2T2JOED
         WgvlbFXIc7UacXzKaNGoBu7y4yfvyu+mCQtt7b3f1D7ffoDl14iUBGcPQ2KYH0Olq9mP
         gLRF8hm/hNqOXIZgXFqjKOLbT5gy4NMpXS5sMKOOJuh+vJHcBp+7aZ9mqvoJdRvuUtsI
         A5cDdIRlsIFN+53cK5zNGQk1p1dxo05fZYqpovxgMO6Qo7IE+LriWPX72jPg+34vpH+e
         8bS3uKSG4A3XQGAeDq7jNpftjcoERyobuP1yWLKOOfIUMw2gBAcsLJeqTno9NWNsH69l
         23Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=n+JT42UW3IX9wla9IjzVJHPpAx8LymWRP5IJmE/8TXw=;
        b=s43ObTzCY0ZzC15QXGY0fhFMMLVxlNVRI3lpTMP647dY7tjtlYpf9TU7lyg9K9mfaq
         +Ff8Uqb0/Y03MaSuPcnbMNtdv3NhK6E6lGkm/rJfk0euMEREVMtJ9UcxoZqUo3ROqCTR
         VYB/nd9BuiSYisFz0+mSR1aHdOxj8Ill+GxF6JZdDrVXq51idT+MhZA3rzgsH7N/wS9R
         fm2ZdMty61p3XyGaX2lbtfZ4ERbyRRliLr8/5PGynm9EYuYx4pAt9O5Mx/uzGLg+/n8T
         64JfC/j0xxq3RmbBn7dRQnBbYZpbEcmvR4fFbwVq9EV9n6xvZkengXqqahJvBaJgCE0m
         itSQ==
X-Gm-Message-State: AOAM531+HQrVsDZe3POSpIYcDdDjLdZlXhaIwPyZshScT7q8uGok7BGN
        IBiFZJRO4qa8hDkcrpp2cgI1yhjBZmymFsO16H8=
X-Google-Smtp-Source: ABdhPJzg5X/gQWMkIcI6BElZvWcGuhFc6ckR3N2jFxooaYHCkeFlz20H6F/OsGLrX+urA/cfHC0YoA==
X-Received: by 2002:a5d:6146:: with SMTP id y6mr1674453wrt.278.1627633802106;
        Fri, 30 Jul 2021 01:30:02 -0700 (PDT)
Received: from [192.168.1.121] (93-40-209-49.ip40.fastwebnet.it. [93.40.209.49])
        by smtp.gmail.com with ESMTPSA id l2sm891233wmq.0.2021.07.30.01.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 01:30:01 -0700 (PDT)
Message-ID: <071252c1bcf72a3fddd5664ca82b05b6589957cc.camel@gmail.com>
Subject: Re: [PATCH v3 1/2] perf pmu: Add PMU alias support
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com
Date:   Fri, 30 Jul 2021 10:28:30 +0200
In-Reply-To: <20210730070717.30997-2-yao.jin@linux.intel.com>
References: <20210730070717.30997-1-yao.jin@linux.intel.com>
         <20210730070717.30997-2-yao.jin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

thanks for your quick revision. 

There is still one small memory issue with a variable not being freed, which I
noticed when running this patchset together with John's patchset.

On Fri, 2021-07-30 at 15:07 +0800, Jin Yao wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> A perf uncore PMU may have two PMU names, a real name and an alias. The
> alias is exported at /sys/bus/event_source/devices/uncore_*/alias.
> The perf tool should support the alias as well.
> 
> Add alias_name in the struct perf_pmu to store the alias. For the PMU
> which doesn't have an alias. It's NULL.
> 
> Introduce two X86 specific functions to retrieve the real name and the
> alias separately.
> 
> Only go through the sysfs to retrieve the mapping between the real name
> and the alias once. The result is cached in a list, uncore_pmu_list.
> 
> Nothing changed for the other ARCHs.
> 
> With the patch, the perf tool can monitor the PMU with either the real
> name or the alias.
> 
> Use the real name,
>  $ perf stat -e uncore_cha_2/event=1/ -x,
>    4044879584,,uncore_cha_2/event=1/,2528059205,100.00,,
> 
> Use the alias,
>  $ perf stat -e uncore_type_0_2/event=1/ -x,
>    3659675336,,uncore_type_0_2/event=1/,2287306455,100.00,,
> 
> Co-developed-by: Jin Yao <yao.jin@linux.intel.com>
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
> v3:
>  - Use fgets to read alias string from sysfs.
>  - Resource cleanup.
> 
> v2:
>  - No change.
> 
>  tools/perf/arch/x86/util/pmu.c | 129 ++++++++++++++++++++++++++++++++-
>  tools/perf/util/parse-events.y |   3 +-
>  tools/perf/util/pmu.c          |  26 ++++++-
>  tools/perf/util/pmu.h          |   5 ++
>  4 files changed, 158 insertions(+), 5 deletions(-)
> 
<SNIP>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 44b90d638ad5..cc9af7942e7b 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -944,13 +944,28 @@ static int pmu_max_precise(const char *name)
>         return max_precise;
>  }
>  
> -static struct perf_pmu *pmu_lookup(const char *name)
> +char * __weak
> +pmu_find_real_name(const char *name)
> +{
> +       return strdup(name);
> +}
> +
> +char * __weak
> +pmu_find_alias_name(const char *name __maybe_unused)
> +{
> +       return NULL;
> +}
> +
> +static struct perf_pmu *pmu_lookup(const char *lookup_name)
>  {
>         struct perf_pmu *pmu;
> +       char *name;
>         LIST_HEAD(format);
>         LIST_HEAD(aliases);
>         __u32 type;
>  
> +       name = pmu_find_real_name(lookup_name);

name is not freed if one of the following checks fails.

	/*
	 * The pmu data we store & need consists of the pmu
	 * type value and format definitions. Load both right
	 * now.
	 */
	if (pmu_format(name, &format))
		return NULL;

	/*
	 * Check the type first to avoid unnecessary work.
	 */
	if (pmu_type(name, &type))
		return NULL;

	if (pmu_aliases(name, &aliases))
		return NULL;

Thanks,
Riccardo


> @@ -973,7 +988,8 @@ static struct perf_pmu *pmu_lookup(const char *name)
>                 return NULL;
>  
>         pmu->cpus = pmu_cpumask(name);
> -       pmu->name = strdup(name);
> +       pmu->name = name;
> +       pmu->alias_name = pmu_find_alias_name(name);
>         pmu->type = type;
>         pmu->is_uncore = pmu_is_uncore(name);
>         if (pmu->is_uncore)
> @@ -1003,7 +1019,8 @@ static struct perf_pmu *pmu_find(const char *name)
>         struct perf_pmu *pmu;
>  
>         list_for_each_entry(pmu, &pmus, list)
> -               if (!strcmp(pmu->name, name))
> +               if (!strcmp(pmu->name, name) ||
> +                   (pmu->alias_name && !strcmp(pmu->alias_name, name)))
>                         return pmu;
>  
>         return NULL;
> @@ -1898,6 +1915,9 @@ bool perf_pmu__has_hybrid(void)
>  
>  int perf_pmu__match(char *pattern, char *name, char *tok)
>  {
> +       if (!name)
> +               return -1;
> +
>         if (fnmatch(pattern, name, 0))
>                 return -1;
>  
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 926da483a141..f6ca9f6a06ef 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -21,6 +21,7 @@ enum {
>  #define PERF_PMU_FORMAT_BITS 64
>  #define EVENT_SOURCE_DEVICE_PATH "/bus/event_source/devices/"
>  #define CPUS_TEMPLATE_CPU      "%s/bus/event_source/devices/%s/cpus"
> +#define MAX_PMU_NAME_LEN 128
>  
>  struct perf_event_attr;
>  
> @@ -32,6 +33,7 @@ struct perf_pmu_caps {
>  
>  struct perf_pmu {
>         char *name;
> +       char *alias_name;       /* PMU alias name */
>         char *id;
>         __u32 type;
>         bool selectable;
> @@ -135,4 +137,7 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu,
> __u64 config,
>  bool perf_pmu__has_hybrid(void);
>  int perf_pmu__match(char *pattern, char *name, char *tok);
>  
> +char *pmu_find_real_name(const char *name);
> +char *pmu_find_alias_name(const char *name);
> +
>  #endif /* __PMU_H */


