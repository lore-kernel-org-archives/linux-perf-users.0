Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4870BC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Feb 2022 18:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242289AbiBWSUz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241030AbiBWSUz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Feb 2022 13:20:55 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5ED49FB8
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Feb 2022 10:20:27 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id g20so3701848edw.6
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Feb 2022 10:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SF/2jNVMnUzKLRFa8MFzQjb0SDdtr53IUPg9a0JdGqM=;
        b=HCHjYLzzFtVC8etIW9DiyRhvXlNXAzjD1wZtrHeoaYThi884QX4NESSBy79rjPBR8H
         2hb7bJdjkMR3+tkL755lZHpS6I+qQ47WbOP6YVWfKJSPilbJWxnqrTOUlQSw8mBrJbb9
         Fb6oYnnMrqMLkFCqJy9CxADU8nqDrnHnjrH12FH2T+K2+t+iMpQS7TreAs8mv2bguCgd
         5d8qrU/vU9HePDdt0dBxDb/jphCe8ICveM3i04u+EIdZFwnh5nXOWvKf4aIbfi8Gg4+2
         7TWdncdaNf1O3c8nbHlINP2uutQAACmrMhBWkUHZbQv7qxrrL7pOnHGDeNqlRjiCn18J
         ijDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SF/2jNVMnUzKLRFa8MFzQjb0SDdtr53IUPg9a0JdGqM=;
        b=tY+at+YhyRxfNevoQ41/pPI7I7n02qXXoFWmttL6IAesf9cemngUuJSyjYx67yK5RH
         fkDoj5awMHPwCQihGWDiHcA+vWvjVmecdhnhihMjypTO5HGSwlpBnQ6onb9Tw1gnHfGV
         QNe+8JbiRBmgIZwn24HjIbeJeYzVRQ1FJ13qZnJxVnCNxyywRF4GLuF3sQO47Mu7m2Fe
         j8dtkW35739BuHNx38HXJNvPRTAGKO7QXQ24DRDodcAjtdkYQaneBEfN1tttCKTrnBJi
         tSGYeTAqenagWu+FcAl3JfZvd+wYDUeBiibYUhzloK2EcOADhw00LyYRjePd5Qc4T4zN
         bIfg==
X-Gm-Message-State: AOAM532A9Z3r2AgAVu+4eVtzr2mjB+OAX8FVMqEVEJPWXNL2QgU5P1tm
        RNqqRSxo5xn8jhEuoCQfNow=
X-Google-Smtp-Source: ABdhPJxbrzti+lq21lhWKSXSC2iHGsLZ/oHTQ/bCKVN90OeQBBv0hLPh26hsBzq6JRJTCepK7bzMwg==
X-Received: by 2002:a05:6402:2801:b0:40f:f179:c3ca with SMTP id h1-20020a056402280100b0040ff179c3camr703278ede.226.1645640425733;
        Wed, 23 Feb 2022 10:20:25 -0800 (PST)
Received: from krava (ip-89-102-25-98.net.upcbroadband.cz. [89.102.25.98])
        by smtp.gmail.com with ESMTPSA id oz23sm158780ejb.174.2022.02.23.10.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:20:25 -0800 (PST)
Date:   Wed, 23 Feb 2022 19:20:23 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        irogers@google.com, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] libperf: Fix read_size calculations
Message-ID: <YhZ651X4Fs9KJMa6@krava>
References: <20220223131349.134897-1-tz.stoyanov@gmail.com>
 <YhY9p9wsYgXtdYnt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhY9p9wsYgXtdYnt@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Feb 23, 2022 at 10:59:03AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Feb 23, 2022 at 03:13:49PM +0200, Tzvetomir Stoyanov (VMware) escreveu:
> > Reading the counters from perf descriptor fails because of size
> > mismatch when PERF_FORMAT_GROUP is set. The group count must include the
> > parent and the count of siblings.
> 
> Yeah, it should match the calculation done in the kernel, in
> __perf_event_read_size(), that has...
> 
> static void __perf_event_read_size(struct perf_event *event, int nr_siblings)
> {
>         int entry = sizeof(u64); /* value */
>         int size = 0;
>         int nr = 1;
> 
>         if (event->attr.read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
>                 size += sizeof(u64);
> 
>         if (event->attr.read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
>                 size += sizeof(u64);
> 
>         if (event->attr.read_format & PERF_FORMAT_ID)
>                 entry += sizeof(u64);
> 
>         if (event->attr.read_format & PERF_FORMAT_GROUP) {
>                 nr += nr_siblings;
>                 size += sizeof(u64);
>         }
> 
>         size += entry * nr;
>         event->read_size = size;
> }
> 
> So this bug has been with us since forever (well, 2017), so we need:
> 
> Fixes: 5c30af92f2b1e9d8 ("libperf: Adopt perf_evsel__read() function from tools/perf")
> 
> To fix it in libperf and probably:
> 
> Fixes: de63403bfd14ae8d ("perf tools: Add perf_evsel__read_size function")
> 
> To get this to stable kernels versions predating the move of this
> function to libperf.
> 
> Jiri?
> 
> - Arnaldo
>  
> > Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
> > ---
> >  tools/lib/perf/evsel.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> > index 210ea7c06ce8..4597a53c0152 100644
> > --- a/tools/lib/perf/evsel.c
> > +++ b/tools/lib/perf/evsel.c
> > @@ -299,7 +299,7 @@ int perf_evsel__read_size(struct perf_evsel *evsel)
> >  		entry += sizeof(u64);
> >  
> >  	if (read_format & PERF_FORMAT_GROUP) {
> > -		nr = evsel->nr_members;
> > +		nr += evsel->nr_members;

hum, I'll double check but AFAICS from tests/parse-events.c,
nr_members already includes both parent (leader) and members,
which is different from nr_siblings in kernel

can you please provide more details?

thanks,
jirka

> >  		size += sizeof(u64);
> >  	}
> >  
> > -- 
> > 2.34.1
> 
> -- 
> 
> - Arnaldo
