Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0294C4332F
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Feb 2022 15:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242046AbiBWP2N (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Feb 2022 10:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242044AbiBWP2L (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Feb 2022 10:28:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E709059A56
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Feb 2022 07:27:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80F1D617FE
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Feb 2022 15:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75CDC340F1;
        Wed, 23 Feb 2022 15:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645630058;
        bh=PrxZtjXRi1BdJXu9KW+3pSSjimH1u3S3jdkecgIp53g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EPJUHi88Zm1QGIoeXnZ9xHeb/ZVeBgXt8+jYh86VIlONFfrZs9YH6YoGBntze7f4u
         n7nYDkaDlyFdl30KNVU5ALl1jPiFvaBlN4c30E+iRQCebAVMEAnKfI62Am5fbqZXZo
         J9V7r4FDfra4Lte0M9fhU8PodJhYnvCozzD+1SFpP115VaD4dXZCdMrD4kNYoQsScI
         fvNzF/90/v0QUdpFFMZYKYDLrW+74jM23EHeqwtMTBKiBgz2YN7GGEQDg/2J9VUDwM
         dJoaWQCHgblBieAyaqsAFvKrwyq44I6hjq3pP/JFFsBMWUlHHR+U0x3FwxtxlSewtN
         VAWEgNs5hlTHg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 39C91400FE; Wed, 23 Feb 2022 12:27:34 -0300 (-03)
Date:   Wed, 23 Feb 2022 12:27:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        irogers@google.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] libperf: Rename arguments of perf_thread_map APIs
Message-ID: <YhZSZioIZzwRU3WR@kernel.org>
References: <20220221102612.43879-1-tz.stoyanov@gmail.com>
 <YhPsIJBdsN9AiE0O@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhPsIJBdsN9AiE0O@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Feb 21, 2022 at 08:46:40PM +0100, Jiri Olsa escreveu:
> On Mon, Feb 21, 2022 at 12:26:12PM +0200, Tzvetomir Stoyanov (VMware) wrote:
> > The "int thread" input arguments of some perf_thead_map APIs are index
> > of the thread in the thread map. In order to avoid confusion and to
> > make the APIs consistent with perf_cpu_map APIs, those arguments are
> > renamed to "int idx".
> > 
> > Suggested-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> > Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
> > ---
> >  tools/lib/perf/Documentation/libperf.txt |  6 +++---
> >  tools/lib/perf/include/perf/threadmap.h  |  6 +++---
> >  tools/lib/perf/threadmap.c               | 12 ++++++------
> >  3 files changed, 12 insertions(+), 12 deletions(-)
> > 
> > diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
> > index 32c5051c24eb..a21f733b95b1 100644
> > --- a/tools/lib/perf/Documentation/libperf.txt
> > +++ b/tools/lib/perf/Documentation/libperf.txt
> > @@ -63,10 +63,10 @@ SYNOPSIS
> >  
> >    struct perf_thread_map *perf_thread_map__new_dummy(void);
> >  
> > -  void perf_thread_map__set_pid(struct perf_thread_map *map, int thread, pid_t pid);
> > -  char *perf_thread_map__comm(struct perf_thread_map *map, int thread);
> > +  void perf_thread_map__set_pid(struct perf_thread_map *map, int idx, pid_t pid);
> > +  char *perf_thread_map__comm(struct perf_thread_map *map, int idx);
> >    int perf_thread_map__nr(struct perf_thread_map *threads);
> > -  pid_t perf_thread_map__pid(struct perf_thread_map *map, int thread);
> > +  pid_t perf_thread_map__pid(struct perf_thread_map *map, int idx);
> >  
> >    struct perf_thread_map *perf_thread_map__get(struct perf_thread_map *map);
> >    void perf_thread_map__put(struct perf_thread_map *map);
> > diff --git a/tools/lib/perf/include/perf/threadmap.h b/tools/lib/perf/include/perf/threadmap.h
> > index a7c50de8d010..58f7fbdce446 100644
> > --- a/tools/lib/perf/include/perf/threadmap.h
> > +++ b/tools/lib/perf/include/perf/threadmap.h
> > @@ -9,10 +9,10 @@ struct perf_thread_map;
> >  
> >  LIBPERF_API struct perf_thread_map *perf_thread_map__new_dummy(void);
> >  
> > -LIBPERF_API void perf_thread_map__set_pid(struct perf_thread_map *map, int thread, pid_t pid);
> > -LIBPERF_API char *perf_thread_map__comm(struct perf_thread_map *map, int thread);
> > +LIBPERF_API void perf_thread_map__set_pid(struct perf_thread_map *map, int idx, pid_t pid);
> > +LIBPERF_API char *perf_thread_map__comm(struct perf_thread_map *map, int idx);
> >  LIBPERF_API int perf_thread_map__nr(struct perf_thread_map *threads);
> > -LIBPERF_API pid_t perf_thread_map__pid(struct perf_thread_map *map, int thread);
> > +LIBPERF_API pid_t perf_thread_map__pid(struct perf_thread_map *map, int idx);
> 
> does this argument name change break abi? do we care at this point? ;-)
> not sure if we already started to treat libperf properly in this regard

So, I don't think this changes the ABI, no semantic change, just a
clarification.

Are you ok with it?

- Arnaldo
