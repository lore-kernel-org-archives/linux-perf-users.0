Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931B5C07E95
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Jul 2021 13:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D0F4613F8
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Jul 2021 13:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239125AbhGPNQp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 16 Jul 2021 09:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbhGPNQo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 16 Jul 2021 09:16:44 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D896FC06175F;
        Fri, 16 Jul 2021 06:13:48 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso8173712wmh.4;
        Fri, 16 Jul 2021 06:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=VAMJ51F8HlGQzrW0Yo0XZ6ITZDcYdf9bAUDHhhTszoA=;
        b=QrQNm6P2zW7Ac4xHgPKL/3+hN/58J6MDvS15iqDTiCpEQd6a3o0J2T/zO3EtQQeRrT
         jgMmT0xesI3DMy1Q1kirEudmh2I+T2rUo4xQ883CU5geG6UA7EP7vFE9bZv1f9AxVRLn
         sfh9WOXEPrW3+0EAJrok7a7PHWMBkwQLKxVHwkd+POZQs3TmcesG7FpTC0qlHeTSUYoC
         SrkMr8r8J25pA3I0c9bJOxmNsY3GTVJ65Jf9cldwiJ3ND5VhHa2AL4XGVysfewQFO4kn
         Str4gyE9aem0O0ke4HnUakfJKvCzAu7XG/MANwtcqos37xtqUxBOfh3pwO+MAtMgSB0Z
         CNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=VAMJ51F8HlGQzrW0Yo0XZ6ITZDcYdf9bAUDHhhTszoA=;
        b=fJ978i1GVfCJHtZIR5zleGkgzTDB/am6+qE9zST7LPEPjWvK+JPB8kUiqbKKVln2/7
         vPT/BWRm21rgtXjdN0JKaBx6L00rXHCjVpQlrf+7XJ3MZk9j4093Xx4mwHoXKXB8nGKt
         QZf49RlsND1/zVUKuV0xBcyacT803Mi7coZPQYKGoR2NqQzvn+0E7JBa2MY7ZYriEIVG
         do8hpAEUVy7lVZCzI98v1bGS6EZxziziW44uNZ6YDRKXvBV10j0m5ULyYIMc5HmZrPMq
         RRBmvPGdZNqy0jfVJQ8DgEQfx2eCJgEGlwD4s+mW6Lj92E0zxrU4N422hLBNEJdQYQUG
         Y+kQ==
X-Gm-Message-State: AOAM531m952pCir0jI4AhY0nJGnc5NC9krg8/C494pkIkYr2Ujcym8lv
        cBmlAIhKI77xa1zVcWi3Ljo=
X-Google-Smtp-Source: ABdhPJxJb0FShbubxv23BuhBGt4gdETj8G4jqoPSy6hyuYvUAMxvHVvTEO5iC/zNh2hfxOXZM3rsIw==
X-Received: by 2002:a1c:f613:: with SMTP id w19mr17012077wmc.136.1626441227169;
        Fri, 16 Jul 2021 06:13:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6456:fd99:ced0:db1c:53e1:191e? ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.gmail.com with ESMTPSA id c12sm11308759wrr.90.2021.07.16.06.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 06:13:40 -0700 (PDT)
Message-ID: <b8ec4f29889914e49fac73af59466e8acdf1e49f.camel@gmail.com>
Subject: Re: [PATCH 02/20] perf env: fix sibling_dies memory leak
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Date:   Fri, 16 Jul 2021 15:13:37 +0200
In-Reply-To: <YPCRR8jv47kHG/xC@kernel.org>
References: <cover.1626343282.git.rickyman7@gmail.com>
         <2140d0b57656e4eb9021ca9772250c24c032924b.1626343282.git.rickyman7@gmail.com>
         <YPCRR8jv47kHG/xC@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,

thanks for reviewing this patchset and, more importantly, for manually adding
all Fixes: tags. I'm so sorry for that.

On Thu, 2021-07-15 at 16:49 -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jul 15, 2021 at 06:07:07PM +0200, Riccardo Mancini escreveu:
> > ASan reports a memory leak in perf_env while running the perf test
> > "41: Session topology", caused by sibling_dies not being freed.
> > 
> > This patch adds the required free.
>  
> > Fixes: acae8b36cded0ee6 ("perf header: Add die information in CPU topology")
> 
> So, I CC the author of the patch and its committer, using this shell
> script:
> 
>   $ cat ~/bin/fixes
>   #!/bin/bash
>   
>   cset=$1
>   if [ $# -eq 0 ] ; then
>         read cset
>   fi
>   git show --pretty=fuller $cset | grep '^\(Author\|Commit\): ' | sed -r
> 's/.*: +/Cc: /g' | grep -v "Arnaldo Carvalho de Melo" | sort -u
>   echo Fixes: `git one $cset`
>   $
>   $ grep one -B1 ~/.gitconfig
>   [alias]
>         one = show -s --pretty='format:%h (\"%s\")'
>   $
>   $ fixes acae8b36cded0ee6
>   Cc: Kan Liang <kan.liang@linux.intel.com>
>   Fixes: acae8b36cded0ee6 ("perf header: Add die information in CPU topology")
>   $
> 
> Normally I copy the cset SHA and, in vim, select it and run !fixes, i.e.
> 
> :'<,'>!fixes

Thanks! I've added this nice script to my PATH. :)

Thanks,
Riccardo

> 
> Thanks, applied.
> 
> - Arnaldo
> 
> > Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> > ---
> >  tools/perf/util/env.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> > index ebc5e9ad35db21d1..6c765946ef6f591c 100644
> > --- a/tools/perf/util/env.c
> > +++ b/tools/perf/util/env.c
> > @@ -186,6 +186,7 @@ void perf_env__exit(struct perf_env *env)
> >         zfree(&env->cpuid);
> >         zfree(&env->cmdline);
> >         zfree(&env->cmdline_argv);
> > +       zfree(&env->sibling_dies);
> >         zfree(&env->sibling_cores);
> >         zfree(&env->sibling_threads);
> >         zfree(&env->pmu_mappings);
> > -- 
> > 2.31.1
> > 
> 


