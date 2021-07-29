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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD92C4338F
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 13:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37E0560F23
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 13:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbhG2NPN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 29 Jul 2021 09:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237236AbhG2NPN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Jul 2021 09:15:13 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E212CC061765;
        Thu, 29 Jul 2021 06:15:08 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l4-20020a05600c1d04b02902506f89ad2dso5743990wms.1;
        Thu, 29 Jul 2021 06:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=c6fOSGDlfAqD4Y6kzbswq3LBsFrmI0PMsJL9GSOn4CY=;
        b=aINT36AfwuAJxBj8GqZ9Mklv2DKxqQjj45RME0uEZUYrU/eG0g6zfBn9bGbJjzBJwE
         P8L5YAoi6PbjVGtj71T6bgceSFVbLb8epWkiRtLjHGVrvwfYGXS7p8JVOiEfwKF9/0IC
         rjpI7Tv3wvQcymknbQLJussbD0c0/qmGRUmaubU29pwBdTC7KJZhJteM8rTFV01Vq9hf
         9fuaK81kMterqf9teAJ+fsH8ZOXUa+KAgqxls3GwR41b5zh9jemOfR2hOiE2+bK4+bdi
         /7A+uf79no3QbxoaDeui4nSiPSei70KtJzjyp2Vlx2dpVyzlu4sxz2zq3BTpS2Ed2eZx
         2uAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=c6fOSGDlfAqD4Y6kzbswq3LBsFrmI0PMsJL9GSOn4CY=;
        b=LEXWMDX0fI4K4jpxFPMUV9jYCXZ0xJ7+kU9HPxt1aHV4abhLYhbr3rRvLiRjKWod+U
         oaNpjW5aEJ4SbWwkasSab00UzbxY6eQLxonk2APGx3kwHD5XC3KOE7kwLZkNH27hAXmc
         f7TM7DTxfwR5B2THu9EZIGz6355IoXXFmVkl9ckpUMQlIoERxG2H6H6k8K+oM5pjKQAd
         JR1NyBnRdI9HtxYBoUljuyjPW3FzzzDN0A8+GCxVOKHDJn67v6NdHD6ZqjFTpAN32jQB
         i2EukKsFR4ewvcMgtAo6QeKqjcTBgNgGQi6y8w0QKk7b8hazGPBBEdkMaoUse8YZcfIB
         BtFA==
X-Gm-Message-State: AOAM532fnKJG4QDlfYL1sJYkMB803+dTse7G6O/TT6abA4M3tT7fEirB
        HP30H6j6k5vQzPyVoVz4CEM=
X-Google-Smtp-Source: ABdhPJxLUaGXr25u4fM35JJn+UNCHICSG/pFo1jaGXyhFv51OiGjcKdhdxbWFcwZAwJnycEmEUylhA==
X-Received: by 2002:a1c:cc1a:: with SMTP id h26mr4673696wmb.47.1627564507388;
        Thu, 29 Jul 2021 06:15:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6456:fd99:ced0:db1c:53e1:191e? ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.gmail.com with ESMTPSA id j14sm3575148wru.58.2021.07.29.06.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 06:15:07 -0700 (PDT)
Message-ID: <f5f6f40b58c3d2151a4e899a109bd58764152758.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] perf tests: Test for PMU alias
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com
Date:   Thu, 29 Jul 2021 15:15:06 +0200
In-Reply-To: <20210729070619.20726-3-yao.jin@linux.intel.com>
References: <20210729070619.20726-1-yao.jin@linux.intel.com>
         <20210729070619.20726-3-yao.jin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Thu, 2021-07-29 at 15:06 +0800, Jin Yao wrote:
> A perf uncore PMU may have two PMU names, a real name and an alias
> name. Add one test case to verify the real name and alias name having
> the same effect.
> 
> Iterate the sysfs to get one event which has an alias and create
> evlist by adding two evsels. Evsel1 is created by event and evsel2
> is created by alias.
> 
> Test asserts:
> evsel1->core.attr.type == evsel2->core.attr.type
> evsel1->core.attr.config == evsel2->core.attr.config
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
> v2:
>  - New in v2.
> 
>  tools/perf/tests/parse-events.c | 79 +++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index 56a7b6a14195..b416851e4074 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -6,6 +6,7 @@
>  #include "tests.h"
>  #include "debug.h"
>  #include "pmu.h"
> +#include "fncache.h"
>  #include <dirent.h>
>  #include <errno.h>
>  #include <sys/types.h>
> @@ -2190,9 +2191,79 @@ static int test_pmu_events(void)
>         return ret;
>  }
>  
> +static bool test_alias(char **event, char **alias)
> +{
> +       char path[PATH_MAX];
> +       DIR *dir;
> +       struct dirent *dent;
> +       const char *sysfs = sysfs__mountpoint();
> +       char buf[128];
> +       FILE *file;
> +
> +       if (!sysfs)
> +               return false;
> +
> +       snprintf(path, PATH_MAX, "%s/bus/event_source/devices/", sysfs);
> +       dir = opendir(path);
> +       if (!dir)
> +               return false;
> +
> +       while ((dent = readdir(dir))) {
> +               if (!strcmp(dent->d_name, ".") ||
> +                   !strcmp(dent->d_name, ".."))
> +                       continue;
> +
> +               snprintf(path, PATH_MAX,
> "%s/bus/event_source/devices/%s/alias",
> +                        sysfs, dent->d_name);
> +
> +               if (!file_available(path))
> +                       continue;
> +
> +               file = fopen(path, "r");
> +               if (!file)
> +                       continue;
> +
> +               if (fscanf(file, "%s", buf) != 1) {
> +                       fclose(file);
> +                       continue;
> +               }

ditto as in the first patch.

> +
> +               fclose(file);
> +               *event = strdup(dent->d_name);
> +               *alias = strdup(buf);
> +               return true;
> +       }

dir is never closed.

Thanks,
Riccardo

> +
> +       return false;
> +}
> +
> +static int test__checkevent_pmu_events_alias(struct evlist *evlist)
> +{
> +       struct evsel *evsel1 = evlist__first(evlist);
> +       struct evsel *evsel2 = evlist__last(evlist);
> +
> +       TEST_ASSERT_VAL("wrong type", evsel1->core.attr.type == evsel2-
> >core.attr.type);
> +       TEST_ASSERT_VAL("wrong config", evsel1->core.attr.config == evsel2-
> >core.attr.config);
> +       return 0;
> +}
> +
> +static int test_pmu_events_alias(char *event, char *alias)
> +{
> +       struct evlist_test e = { .id = 0, };
> +       char name[2 * NAME_MAX + 20];
> +
> +       snprintf(name, sizeof(name), "%s/event=1/,%s/event=1/",
> +                event, alias);
> +
> +       e.name  = name;
> +       e.check = test__checkevent_pmu_events_alias;
> +       return test_event(&e);
> +}
> +
>  int test__parse_events(struct test *test __maybe_unused, int subtest
> __maybe_unused)
>  {
>         int ret1, ret2 = 0;
> +       char *event, *alias;
>  
>  #define TEST_EVENTS(tests)                             \
>  do {                                                   \
> @@ -2217,6 +2288,14 @@ do
> {                                                     \
>                         return ret;
>         }
>  
> +       if (test_alias(&event, &alias)) {
> +               int ret = test_pmu_events_alias(event, alias);
> +               free(event);
> +               free(alias);
> +               if (ret)
> +                       return ret;
> +       }
> +
>         ret1 = test_terms(test__terms, ARRAY_SIZE(test__terms));
>         if (!ret2)
>                 ret2 = ret1;


