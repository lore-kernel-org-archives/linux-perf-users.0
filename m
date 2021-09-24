Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61EAC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Sep 2021 19:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA91961250
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Sep 2021 19:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346323AbhIXTIX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 24 Sep 2021 15:08:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346272AbhIXTIX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 24 Sep 2021 15:08:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA4F1610FD;
        Fri, 24 Sep 2021 19:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632510409;
        bh=LvsTbVneJYaTCR+Ilv4DwkAJIZ7Ldm6fuKKu6q0I2CY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=psw+nBuX2BHGqJa5zZkFa3SBHDKBijqzOk17skzM0TDRupe+2YuX++BTjCid1jfeI
         PQyt5LZ7jbgFy/T5Z9Gni65CZDktKXufPUfsuTTDpqBXfIj031wUB2jlrZbTQnDOXr
         lo3m9sTF1n2QTk1cX2DAjYYAFoSs5Ld5eq7l4TCLNB+N+nJsiqyz7TWq1aPgJjF/Ym
         1IqtU13s/N/DFIvbT04uC33oJt6P3BkzfbHYgtNBnFMHuHAARIVVEIWkHoBe1nSYdc
         FLVzNFGTcitCXiXa3Og/GZ3UPTt/q+QfDrktJn3pAnUFhQgdRJvYDpetHUGM4kbZEU
         GjdIZVHwX4EPQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AB27C410A1; Fri, 24 Sep 2021 16:06:47 -0300 (-03)
Date:   Fri, 24 Sep 2021 16:06:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Like Xu <like.xu.linux@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf config: Refine error message to eliminate confusion
Message-ID: <YU4hx4jRhYLYnPiM@kernel.org>
References: <20210924115817.58689-1-likexu@tencent.com>
 <CAP-5=fW+Wn+_OcQWR8-UHQ42CsG6koZVw-UWBptQY8oYLsW=Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fW+Wn+_OcQWR8-UHQ42CsG6koZVw-UWBptQY8oYLsW=Vg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Sep 24, 2021 at 08:08:07AM -0700, Ian Rogers escreveu:
> On Fri, Sep 24, 2021 at 4:58 AM Like Xu <like.xu.linux@gmail.com> wrote:
> >
> > From: Like Xu <likexu@tencent.com>
> >
> > If there is no configuration file at first, the user can
> > write any pair of "key.subkey=value" to the newly created
> > configuration file, while value validation against a valid
> > configurable key is *deferred* until the next execution or
> > the implied execution of "perf config ... ".
> >
> > For example:
> >
> >  $ rm ~/.perfconfig
> >  $ perf config call-graph.dump-size=65529
> >  $ cat ~/.perfconfig
> >  # this file is auto-generated.
> >  [call-graph]
> >         dump-size = 65529
> >  $ perf config call-graph.dump-size=2048
> >  callchain: Incorrect stack dump size (max 65528): 65529
> >  Error: wrong config key-value pair call-graph.dump-size=65529
> >
> > The user might expect that the second value 2048 is valid
> > and can be updated to the configuration file, but the error
> > message is very confusing because the first value 65529 is
> > not reported as an error during the last configuration.
> >
> > It is recommended not to change the current behavior of
> > delayed validation (as more effort is needed), but to refine
> > the original error message to *clearly indicate* that the
> > cause of the error is the configuration file.
> >
> > Signed-off-by: Like Xu <likexu@tencent.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/util/config.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> > index 4fb5e90d7a57..60ce5908c664 100644
> > --- a/tools/perf/util/config.c
> > +++ b/tools/perf/util/config.c
> > @@ -801,7 +801,7 @@ int perf_config_set(struct perf_config_set *set,
> >                                   section->name, item->name);
> >                         ret = fn(key, value, data);
> >                         if (ret < 0) {
> > -                               pr_err("Error: wrong config key-value pair %s=%s\n",
> > +                               pr_err("Error in the given config file: wrong config key-value pair %s=%s\n",
> >                                        key, value);
> >                                 /*
> >                                  * Can't be just a 'break', as perf_config_set__for_each_entry()
> > --
> > 2.32.0
> >

-- 

- Arnaldo
