Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA64C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Feb 2022 17:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243323AbiBWRPN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Feb 2022 12:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243321AbiBWRPM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Feb 2022 12:15:12 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87251005
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Feb 2022 09:14:43 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id lw4so53904017ejb.12
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Feb 2022 09:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OCDXsv7YMRYGxLUpBNFLtyqm+4fyri+Rn/EJ/tWMxBk=;
        b=bYIumWnMlOVJLe4qgFytq6OsPsTvG6Elg+Ir20CburlzGSBu2FQEKeuwBO5OxonWh8
         2GqcNwuCYVpksaMmApvKh2vH6EwpntbJGri0JNpKoOmLxb7w9qfrdvPy1Je1NhAOWkGV
         aLNZiIe0S4kl9x5NCXHUXW8PuMsPMDVWaUAf0mIdCMucdDeDJ9EMVGj6Z6LXZWg3B0CK
         7A+k68EV0us6AVGeeVqrZNaJ3AjZeMQf34F6XGQh9FqkeHh2e6fZWvr5GR+n+XOQ94lO
         bEvwI+VhWBb0XhZM/uvm6MEKxeQT+HE6v5c3isH0qfDVrRmIdUxbckk4U73tgpbFCnUk
         NNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OCDXsv7YMRYGxLUpBNFLtyqm+4fyri+Rn/EJ/tWMxBk=;
        b=DaJyfOY6c0oQkKFUi4Vvnp3K0XFitAh5cSvC3+Hc01ZV9fN/tcOcY9m/TS8FGxGOLL
         RgjhqK+oMaPOlqilOWs4Ns7opxL9yps9xwr5wP2v4FkGk0h7991xa0e/NAvBLfFOGuS8
         ezJfU1vWM69BRZliGihxy85Glwm/uuK57Rq8yfhM9LiSwetB4sXC9pIt2Haw1kCFqlRS
         5VPBwSPjxr14HvALEMySN/1/wBFF35/Dq2coTZS8Ok40cscSppRoXq1wStnvL5ANx7J0
         Mr+X36moYGrBB120x+1aw0DUpalcs2EsRTszTSveygyGMNRR+50JgAf+5zfHPVpu6MXX
         DoWA==
X-Gm-Message-State: AOAM5317xlQu89tQ3VptG09UfwIZtOkvwHY2C7qwuo2w81rKOt6sNiwQ
        8RSRUYrLSz+go31Re2rlXik=
X-Google-Smtp-Source: ABdhPJyW83ePL4LhNPvvgasG2SaOORZ96MB6xZLOLGgHhVK28ozLs7ycRDIzHlwltBtNMWG7WFNCXw==
X-Received: by 2002:a17:907:6e01:b0:6d0:562c:e389 with SMTP id sd1-20020a1709076e0100b006d0562ce389mr528177ejc.497.1645636482309;
        Wed, 23 Feb 2022 09:14:42 -0800 (PST)
Received: from krava (ip-89-102-25-98.net.upcbroadband.cz. [89.102.25.98])
        by smtp.gmail.com with ESMTPSA id y22sm92393ejm.225.2022.02.23.09.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 09:14:41 -0800 (PST)
Date:   Wed, 23 Feb 2022 18:14:39 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        irogers@google.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] libperf: Rename arguments of perf_thread_map APIs
Message-ID: <YhZrf7m12eaKtvU7@krava>
References: <20220221102612.43879-1-tz.stoyanov@gmail.com>
 <YhPsIJBdsN9AiE0O@krava>
 <YhZSZioIZzwRU3WR@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhZSZioIZzwRU3WR@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Feb 23, 2022 at 12:27:34PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Feb 21, 2022 at 08:46:40PM +0100, Jiri Olsa escreveu:
> > On Mon, Feb 21, 2022 at 12:26:12PM +0200, Tzvetomir Stoyanov (VMware) wrote:
> > > The "int thread" input arguments of some perf_thead_map APIs are index
> > > of the thread in the thread map. In order to avoid confusion and to
> > > make the APIs consistent with perf_cpu_map APIs, those arguments are
> > > renamed to "int idx".
> > > 
> > > Suggested-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> > > Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
> > > ---
> > >  tools/lib/perf/Documentation/libperf.txt |  6 +++---
> > >  tools/lib/perf/include/perf/threadmap.h  |  6 +++---
> > >  tools/lib/perf/threadmap.c               | 12 ++++++------
> > >  3 files changed, 12 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
> > > index 32c5051c24eb..a21f733b95b1 100644
> > > --- a/tools/lib/perf/Documentation/libperf.txt
> > > +++ b/tools/lib/perf/Documentation/libperf.txt
> > > @@ -63,10 +63,10 @@ SYNOPSIS
> > >  
> > >    struct perf_thread_map *perf_thread_map__new_dummy(void);
> > >  
> > > -  void perf_thread_map__set_pid(struct perf_thread_map *map, int thread, pid_t pid);
> > > -  char *perf_thread_map__comm(struct perf_thread_map *map, int thread);
> > > +  void perf_thread_map__set_pid(struct perf_thread_map *map, int idx, pid_t pid);
> > > +  char *perf_thread_map__comm(struct perf_thread_map *map, int idx);
> > >    int perf_thread_map__nr(struct perf_thread_map *threads);
> > > -  pid_t perf_thread_map__pid(struct perf_thread_map *map, int thread);
> > > +  pid_t perf_thread_map__pid(struct perf_thread_map *map, int idx);
> > >  
> > >    struct perf_thread_map *perf_thread_map__get(struct perf_thread_map *map);
> > >    void perf_thread_map__put(struct perf_thread_map *map);
> > > diff --git a/tools/lib/perf/include/perf/threadmap.h b/tools/lib/perf/include/perf/threadmap.h
> > > index a7c50de8d010..58f7fbdce446 100644
> > > --- a/tools/lib/perf/include/perf/threadmap.h
> > > +++ b/tools/lib/perf/include/perf/threadmap.h
> > > @@ -9,10 +9,10 @@ struct perf_thread_map;
> > >  
> > >  LIBPERF_API struct perf_thread_map *perf_thread_map__new_dummy(void);
> > >  
> > > -LIBPERF_API void perf_thread_map__set_pid(struct perf_thread_map *map, int thread, pid_t pid);
> > > -LIBPERF_API char *perf_thread_map__comm(struct perf_thread_map *map, int thread);
> > > +LIBPERF_API void perf_thread_map__set_pid(struct perf_thread_map *map, int idx, pid_t pid);
> > > +LIBPERF_API char *perf_thread_map__comm(struct perf_thread_map *map, int idx);
> > >  LIBPERF_API int perf_thread_map__nr(struct perf_thread_map *threads);
> > > -LIBPERF_API pid_t perf_thread_map__pid(struct perf_thread_map *map, int thread);
> > > +LIBPERF_API pid_t perf_thread_map__pid(struct perf_thread_map *map, int idx);
> > 
> > does this argument name change break abi? do we care at this point? ;-)
> > not sure if we already started to treat libperf properly in this regard
> 
> So, I don't think this changes the ABI, no semantic change, just a
> clarification.
> 
> Are you ok with it?

yes, I think it's ok

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
