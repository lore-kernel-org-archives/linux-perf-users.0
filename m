Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C805BC4338F
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 15:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB17C601FF
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 15:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhG2PYw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 29 Jul 2021 11:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237992AbhG2PXI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Jul 2021 11:23:08 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914B2C06179B;
        Thu, 29 Jul 2021 08:23:03 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l18so7430140wrv.5;
        Thu, 29 Jul 2021 08:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=HVzmFDNhzfq905H6mXiGj+VHUUvGzVITmOnZczVHyos=;
        b=qJC44blBBaOFixDixRTmSVdnhAlhH5loSEW5F06/CyOKXf+D6WrZOphJNgiOulKB8o
         6OeFMqz9jFQHpf75Qg7LuX3oLLGIZUKRGHI0HBxVKKSWkS6y6DzZ2iOuYw6K9+lxBVg1
         yOALm6c4mv2T9XT+ibK31j5A6W1L3Rdvqx3E8foxg5k8EMoWYnUr1W7G/+mULItFpl+V
         oEWpnuv4ErCnR55LcpjCA159bc7jb7dEedGWrBcM4YY2roBrJHWz/30Vaq6UmYWAwQBG
         /wpdC7/sleCw1GV85WxNPTxgbsdPLKSupMaKUGPPDR3rElHCqMWsVEQWmPSkxq5Kf3sF
         10Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=HVzmFDNhzfq905H6mXiGj+VHUUvGzVITmOnZczVHyos=;
        b=JYirvpR65NdJOM2KP0aFuKFCd5v5npFbaO6dxdVTOPELy9uJmIMfwS7ePe+dGrY75a
         2QvLxf16VL2M9OOZGCwX8QKs2gyRMOuZO+uCNDM5W2RAEtSu5sR4FZ0dJkMc+kHYP1Uz
         2kb/1mE3hY3SwzVEarqPzj97HgvzCHItY75zRo7xmAKXiazJL3OsRN0lhW9nM8ox6s6F
         0EEErEF43WyoODxc29fBh93PHMWC3ZTJ6H3GVWvrgm8eJIVt8EfWLp/4Lba7J5rxfxIF
         imfr3pAu+iKNok0SpkolaEk1neEgom7/9wuhBBREcccBjvsMH5ppEKA0n3j7hHDDrJcD
         05fQ==
X-Gm-Message-State: AOAM533BotY5pampfPjRDadtXvXuzRwCcwrB0WM3ScM/vKt2KL4Wdkip
        Ci7UlfIOlde79KAdFroDDrY=
X-Google-Smtp-Source: ABdhPJxczdHM/KoAq01OFFEzrultj4zdtJIpUHFwdlmr0vf21gAymjQ9s6gH0wRh2E9uhZA3TQdClQ==
X-Received: by 2002:a5d:6608:: with SMTP id n8mr5309881wru.427.1627572182028;
        Thu, 29 Jul 2021 08:23:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6456:fd99:ced0:db1c:53e1:191e? ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.gmail.com with ESMTPSA id r17sm8951545wmq.13.2021.07.29.08.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 08:23:01 -0700 (PDT)
Message-ID: <eb6b8c7c5e04f8069ac06971af74ac9ef32dd4c4.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] perf pmu: Add PMU alias support
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, john.garry@huawei.com
Date:   Thu, 29 Jul 2021 17:23:00 +0200
In-Reply-To: <20210729070619.20726-2-yao.jin@linux.intel.com>
References: <20210729070619.20726-1-yao.jin@linux.intel.com>
         <20210729070619.20726-2-yao.jin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

sorry for sending a separate email, but I found another problem while testing
John's patchset with ASan:
$ make DEBUG=1 EXTRA_CFLAGS='-O0 -g -fno-omit-frame-pointer -fsanitize=address'

On Thu, 2021-07-29 at 15:06 +0800, Jin Yao wrote:
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
> v2:
>  - No change.
> 
>  tools/perf/arch/x86/util/pmu.c | 109 ++++++++++++++++++++++++++++++++-
>  tools/perf/util/parse-events.y |   3 +-
>  tools/perf/util/pmu.c          |  26 +++++++-
>  tools/perf/util/pmu.h          |   5 ++
>  4 files changed, 138 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
> index d48d608517fd..bb79b1d19b96 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c
> @@ -1,12 +1,28 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <string.h>
> -
> +#include <stdio.h>
> +#include <sys/types.h>
> +#include <dirent.h>
> +#include <fcntl.h>
>  #include <linux/stddef.h>
>  #include <linux/perf_event.h>
> +#include <linux/zalloc.h>
> +#include <api/fs/fs.h>
>  
>  #include "../../../util/intel-pt.h"
>  #include "../../../util/intel-bts.h"
>  #include "../../../util/pmu.h"
> +#include "../../../util/fncache.h"
> +
> +#define TEMPLATE_ALIAS "%s/bus/event_source/devices/%s/alias"
> +
> +struct perf_pmu_alias_name {
> +       char *name;
> +       char *alias;
> +       struct list_head list;
> +};
> +
> +static LIST_HEAD(pmu_alias_name_list);
>  
>  struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu
> __maybe_unused)
>  {
> @@ -18,3 +34,94 @@ struct perf_event_attr *perf_pmu__get_default_config(struct
> perf_pmu *pmu __mayb
>  #endif
>         return NULL;
>  }
> +
> +static void setup_pmu_alias_list(void)
> +{
> +       char path[PATH_MAX];
> +       DIR *dir;
> +       struct dirent *dent;
> +       const char *sysfs = sysfs__mountpoint();
> +       struct perf_pmu_alias_name *pmu;
> +       char buf[MAX_PMU_NAME_LEN];
> +       FILE *file;
> +
> +       if (!sysfs)
> +               return;
> +
> +       snprintf(path, PATH_MAX,
> +                "%s" EVENT_SOURCE_DEVICE_PATH, sysfs);
> +
> +       dir = opendir(path);
> +       if (!dir)
> +               return;
> +
> +       while ((dent = readdir(dir))) {
> +               if (!strcmp(dent->d_name, ".") ||
> +                   !strcmp(dent->d_name, ".."))
> +                       continue;
> +
> +               snprintf(path, PATH_MAX,
> +                        TEMPLATE_ALIAS, sysfs, dent->d_name);
> +
> +               if (!file_available(path))
> +                       continue;
> +
> +               file = fopen(path, "r");
> +               if (!file)
> +                       continue;
> +
> +               if (fscanf(file, "%s", buf) != 1)
> +                       continue;
> +
> +               pmu = zalloc(sizeof(*pmu));
> +               if (!pmu)
> +                       continue;
> +
> +               pmu->alias = strdup(buf);
> +               if (!pmu->alias) {
> +                       free(pmu);
> +                       continue;
> +               }
> +               pmu->name = strdup(dent->d_name);
> +               list_add_tail(&pmu->list, &pmu_alias_name_list);
> +               fclose(file);
> +       }
> +
> +       closedir(dir);
> +}
> +
> +static char *__pmu_find_real_name(const char *name)
> +{
> +       struct perf_pmu_alias_name *pmu;
> +
> +       list_for_each_entry(pmu, &pmu_alias_name_list, list) {
> +               if (!strcmp(name, pmu->alias))
> +                       return strdup(pmu->name);
> +       }
> +
> +       return strdup(name);
> +}
> +
> +char *pmu_find_real_name(const char *name)
> +{
> +       static bool cached_list;
> +
> +       if (cached_list)
> +               return __pmu_find_real_name(name);
> +
> +       setup_pmu_alias_list();
> +       cached_list = true;
> +
> +       return __pmu_find_real_name(name);
> +}
> +
> +char *pmu_find_alias_name(const char *name)
> +{
> +       struct perf_pmu_alias_name *pmu;
> +
> +       list_for_each_entry(pmu, &pmu_alias_name_list, list) {
> +               if (!strcmp(name, pmu->name))
> +                       return strdup(pmu->alias);
> +       }
> +       return NULL;
> +}
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index 9321bd0e2f76..d94e48e1ff9b 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -316,7 +316,8 @@ event_pmu_name opt_pmu_config
>                         if (!strncmp(name, "uncore_", 7) &&
>                             strncmp($1, "uncore_", 7))
>                                 name += 7;
> -                       if (!perf_pmu__match(pattern, name, $1)) {
> +                       if (!perf_pmu__match(pattern, name, $1) ||
> +                           !perf_pmu__match(pattern, pmu->alias_name, $1)) {
>                                 if (parse_events_copy_term_list(orig_terms,
> &terms))
>                                         CLEANUP_YYABORT;
>                                 if (!parse_events_add_pmu(_parse_state, list,
> pmu->name, terms, true, false))
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
> +

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

> 
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


