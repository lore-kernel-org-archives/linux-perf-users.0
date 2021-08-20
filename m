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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09F8C4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 19:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6F616115A
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 19:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238808AbhHTT7D (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Aug 2021 15:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237272AbhHTT7C (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Aug 2021 15:59:02 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842BFC06175F;
        Fri, 20 Aug 2021 12:58:24 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id h9so22383473ejs.4;
        Fri, 20 Aug 2021 12:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:mime-version
         :date:user-agent:content-transfer-encoding;
        bh=LrJQ81OQnCEJDCTRI1bdIMkvIXdbOY4niFVqWVBoYbo=;
        b=MUMI6qyeGYIeEf+vPjCyTXp/VW/6UynfEIOdt0MnMQjpJTqVaYMEBnZ3YPks5RX6mY
         8OcI4mHibQojokiyTPpc8TTy/ER+r7jo/g49ZI5F9fbQjkYKC72jiaSHCSKj0kAx5Giz
         +J+wbv2eP/H+CFXmXTu3sHDRrk5VM9A9Jrfk4UNQUPZlaVYVVMpfm9Zjvti449+BrWqf
         HYmgK7juju2FnIJns8hOk2JsZyzc2yssbetWpB9iY1EvTOrDssqWyOQNO0ryLe3rSCEW
         CbeQ1cpZ/O+L+XF505yHtD997Hs2Bt6vwSChUSM5nlp7Xv0ZFtrj0QTv9ysuyPV5VvXG
         RTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:mime-version:date:user-agent:content-transfer-encoding;
        bh=LrJQ81OQnCEJDCTRI1bdIMkvIXdbOY4niFVqWVBoYbo=;
        b=meTpc1Z8cn1bNeYUyVewhdIV7rdAzULghzuh8Qp/P2Poz+qP6HptO9S+NIrPabAmNJ
         a0OOLALbfBQIq3PL8kIMdKvh5Nzhg9A9RiEK2Dz0KVLlNaMtaWyDoXwwjpqGLqf1Xnv6
         WlbxYX2wWWkhA5DxKnrz3Ufg+pAsz3hkbVwHoJ5v0213nTkt0ppdlQL9npefKNFuAAHJ
         clsTMuA/P+G8gSjxNRQDjcfFZuayz7I3fttyHoAAPtY1+W409BlNfD2ks8EkvLyPPBOK
         3VqYuqcRP9eRlIXpsj6U1Rlh806Fn3sDFWq9FWjBoiKbggv9UESMk8LDOeSydARBz/KM
         Ou2g==
X-Gm-Message-State: AOAM532m7/3QpxOjhNpCwmPUuCQvyen1lo8sSOh3DMH8j/hkZEKDPfjX
        cwI2amlM9NplaVHsbPstmHk=
X-Google-Smtp-Source: ABdhPJw1owli350HiksCUygZP8v2xz2QcSmk36TSfjOqQNr+eqLyamZO86q1DK57Y/U/Z0QvjbFNiQ==
X-Received: by 2002:a17:906:3adb:: with SMTP id z27mr6774111ejd.291.1629489502870;
        Fri, 20 Aug 2021 12:58:22 -0700 (PDT)
Received: from [192.168.43.131] (mob-176-243-162-112.net.vodafone.it. [176.243.162.112])
        by smtp.gmail.com with ESMTPSA id o3sm3257847eju.123.2021.08.20.12.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 12:58:22 -0700 (PDT)
Message-ID: <a647993d9eff9fab20196661ba2a153c7258e569.camel@gmail.com>
Subject: Re: [PATCH] perf config: fix caching and memory leak in
 perf_home_perfconfig
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>, Song Liu <song@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <YR+4kOwuIoPsz2Rw@kernel.org>
References: <20210820130817.740536-1-rickyman7@gmail.com>
         <YR+4kOwuIoPsz2Rw@kernel.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Fri, 20 Aug 2021 21:58:16 +0200
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Fri, 2021-08-20 at 11:13 -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Aug 20, 2021 at 03:08:17PM +0200, Riccardo Mancini escreveu:
> > Acaict, perf_home_perfconfig is supposed to cache the result of
> > home_perfconfig, which returns the default location of perfconfig for
> > the user, given the HOME environment variable.
> > However, the current implementation calls home_perfconfig every time
> > perf_home_perfconfig is called (so no caching is actually performed),
> > replacing the previous pointer, thus also causing a memory leak.
> > 
> > This patch adds a check of whether either config or failed is set and,
> > in that case, directly returns config without calling home_perfconfig at
> > each invocation.
> > 
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Fixes: f5f03e19ce14fc31 ("perf config: Add perf_home_perfconfig function")
> > Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> > ---
> >  tools/perf/util/config.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> > index 63d472b336de21d4..6ab670cdf512507e 100644
> > --- a/tools/perf/util/config.c
> > +++ b/tools/perf/util/config.c
> > @@ -581,6 +581,9 @@ const char *perf_home_perfconfig(void)
> >         static const char *config;
> >         static bool failed;
> >  
> > +       if (config || failed)
> > +               return config;
> > +
> >         config = failed ? NULL : home_perfconfig();
> 
> humm, why keep the above failed test then?

Sorry, I forgot about that, it should be removed.

> 
> >         if (!config)
> >                 failed = true;
> 
> I.e. please check this:
> 
> 
> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> index 63d472b336de21d4..4fb5e90d7a57ae48 100644
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c
> @@ -581,7 +581,10 @@ const char *perf_home_perfconfig(void)
>         static const char *config;
>         static bool failed;
>  
> -       config = failed ? NULL : home_perfconfig();
> +       if (failed || config)
> +               return config;
> +
> +       config = home_perfconfig();
>         if (!config)
>                 failed = true;
>  

Looks good to me.
Shall I resend it fixed?

Thanks,
Riccardo

