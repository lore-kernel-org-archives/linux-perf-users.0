Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D46BC433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 21:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CA7F61361
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 21:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238583AbhKHVYq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 16:24:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52415 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237872AbhKHVYp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 16:24:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636406520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gOovTBeaYlQVrpAOG92IPTrQV9sqxL6kacbXsInerMs=;
        b=arZe1IG0H/EgJeRmX83+3Jtdq6MOe8FY940s51VtA9/FDH8TeCZRC0aTcvB5dNDbjZxxK8
        sLt4u8CfIs/iIn3pmIQY7Vf6UEoU/KOx3cSdxKBdXv9jfl1MpHhLfjmtaujpztU8f84302
        3/XePGTcEejY0LJ9ebjjifi26GycBZc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-mY3y5AXyNlWFYtHLnHpOoQ-1; Mon, 08 Nov 2021 16:21:59 -0500
X-MC-Unique: mY3y5AXyNlWFYtHLnHpOoQ-1
Received: by mail-ed1-f71.google.com with SMTP id s6-20020a056402520600b003e2dea4f9b4so12995638edd.12
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 13:21:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gOovTBeaYlQVrpAOG92IPTrQV9sqxL6kacbXsInerMs=;
        b=ngjCOuiOAFaIr85IzUuAoZM1yFo5J9+bEQB/4W6BLh44j6LLklMxMWT5eER6pMDmRi
         uL2ePvQ9QrymdKVBpgTwiG2Og/6gUbhBSUYxqYlIrLU2cybR1by3ey633tow9h3ZonEJ
         Z643GSynuMMAInFtypBt1HTpyx0iV32c2ar5db2gB7Z260WGSw92sKzaGGJ+sIHZ7RG6
         JT5y3hhBVpPYibbrxcfHrtXEN7H9Re57sNpTBldp3y+6NeT29b5vNa9+Cpg3AAevDJW/
         fneWnhJ8wNWkEXKTdJk3GwP1PMo/gV6KmF+VJL7L2W2cpPl6qGDL25oyMc8A88CE7gAn
         NKBg==
X-Gm-Message-State: AOAM533XC6Gqy9Kkn0qavqmU5bPk5DzHIyK/lYyGhe4wuaFy6e7+Szoa
        M61idRF6Er4iorxvFUDDKSKjLd3f9BAu+az8Zh+qSUBQDksue1E28LUZ+OGWcWsg1hisM0v7vpV
        b6ccJKYKwz1g944ds2mY4dr9AphDLGw==
X-Received: by 2002:a17:906:2d51:: with SMTP id e17mr2809779eji.132.1636406518006;
        Mon, 08 Nov 2021 13:21:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2LLSfHABOfVmsL2VIW8OSwbF4qUNx8Kh57y3WUUHxMeUxWNnhkUOj9pFmIA2TTN1A5C8TRg==
X-Received: by 2002:a17:906:2d51:: with SMTP id e17mr2809744eji.132.1636406517831;
        Mon, 08 Nov 2021 13:21:57 -0800 (PST)
Received: from krava ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id i13sm9969902edc.62.2021.11.08.13.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 13:21:57 -0800 (PST)
Date:   Mon, 8 Nov 2021 22:21:55 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 19/59] perf tools: Fix parse_events_term__num call
Message-ID: <YYmU81una4rOHWX1@krava>
References: <20211108133710.1352822-1-jolsa@kernel.org>
 <20211108133710.1352822-20-jolsa@kernel.org>
 <CAP-5=fV39pCqjvZeBW4LHXq02nzhPO4zAcR6R3cjMRAthstcuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fV39pCqjvZeBW4LHXq02nzhPO4zAcR6R3cjMRAthstcuA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Nov 08, 2021 at 10:15:45AM -0800, Ian Rogers wrote:
> On Mon, Nov 8, 2021 at 5:39 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > We are wrongly passing &config to parse_events_term__num
> > as loc_term_ argument.
> >
> > Fixes: fb0811535e92 ("perf parse-events: Allow config on kernel PMU events")
> 
> I think this shows up on the fix as this change moved the code around,
> but it didn't originate the issue. This pattern is common in
> parse-events.y, are they also problematic?
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/parse-events.y?h=perf/core#n783

they all seem to pass proper loc_term pointer.. I spot this one
by accident and made quick patch, I'll double check the others

thanks,
jirka

> 
> Thanks,
> Ian
> 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/parse-events.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > index 05a96b0f7b41..2bacbab86b09 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -1697,8 +1697,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
> >
> >         if (parse_events_term__num(&term,
> >                                    PARSE_EVENTS__TERM_TYPE_USER,
> > -                                  config, 1, false, &config,
> > -                                       NULL) < 0) {
> > +                                  config, 1, false, NULL, NULL) < 0) {
> >                 free(config);
> >                 goto out_err;
> >         }
> > --
> > 2.31.1
> >
> 

