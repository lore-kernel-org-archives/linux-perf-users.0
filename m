Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6782FC2B9F4
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Jun 2021 15:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3876C61952
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Jun 2021 15:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhFYP4A (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Jun 2021 11:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhFYPz7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Jun 2021 11:55:59 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA70AC061574;
        Fri, 25 Jun 2021 08:53:38 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso8764422wmh.4;
        Fri, 25 Jun 2021 08:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=op7/BKaoe3ba3IUt03EQ5cjTqeRTBFIYUGw/dUxAGL4=;
        b=q0uUfUxC0KdzZbWw/l1Pcca3vOQ53lpCkqNkgcEQ6IP0Go2uEiAjho9E3h+BWZVpQ9
         q7TW6ZTIQI0StuCgSYE09CtSXmy7T3JY+p+k9tw8+qggpBXD+dc+XQbvUIPq1hhu/8/a
         p0ctSkcdadFrp6UqmMJNEGOogr5Cjo0Gw/MfnSkPlOVLKuUENsJLyrWMU7K6fQxk5cKJ
         Fux1fu5KLsQu+9ysXUW8J0kkmzs3R0kwcrHxwvx2T9fzETAHopl64EeoT3j4WPHd6jvd
         Xo4uZ7tofjgH1XhASa14enA1xjTK0Jvsg7co7I0MQE1r68sloG/UyNycAHz2WeLSE/84
         p/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=op7/BKaoe3ba3IUt03EQ5cjTqeRTBFIYUGw/dUxAGL4=;
        b=XzUrFqwpDAHbNsiz9DSG0PQNNwQli2TlwoEUhTVKMKQw17lY9X4d5mYE1gsjyxaVwp
         St4/jP/OKo2OGE5cwwJQC/nWYu9tDM7+uEyvKHjlzMsY/ZlCJo7vVTued1WvWzjBiTVH
         M4EWwnvnAVcHjydUKiqdaLXeCcv9gUPA8/tSZvJcXGwD8yKKzruOMNlGODBpU2tB33OJ
         Vwdgra3ebC2pW02GXdtvtriy/vCAln7LVQIEMLD3DwmeapiK79a7vGtodWPWEvX2ZBAh
         OPIBm/dnhh44/IlKbXJ1hQ81gfIyYhm0KRGTftvsbmMWEHFDQcNczqytonazDfczzpfc
         uqsg==
X-Gm-Message-State: AOAM532DnxUGZy53pmGU2u8ayUSslPRQn8i7FToLdchnEvD65ecHctRs
        qfqS4qx9iUva2S1pu5xFz70=
X-Google-Smtp-Source: ABdhPJzAaw8NfKvCZwdairN0hP8iTy4QtFHY6JzeVoW4ioCNPL3wL3kSLacIiyhbgpuD1lIhQIK8Mg==
X-Received: by 2002:a1c:2142:: with SMTP id h63mr11764885wmh.84.1624636417356;
        Fri, 25 Jun 2021 08:53:37 -0700 (PDT)
Received: from [192.168.1.15] ([151.29.44.148])
        by smtp.gmail.com with ESMTPSA id 4sm5786229wmf.34.2021.06.25.08.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 08:53:36 -0700 (PDT)
Message-ID: <f3bf33bfe2365241fc872ca781109f1b69374840.camel@gmail.com>
Subject: Re: [PATCH v2] perf annotate: allow 's' on source code lines
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Martin Liska <mliska@suse.cz>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 25 Jun 2021 17:53:35 +0200
In-Reply-To: <CAP-5=fXWFvcvNOA+wJMSCp2Qz7EVruufvFBLWEXfdezeEJGUTA@mail.gmail.com>
References: <20210624223423.189550-1-rickyman7@gmail.com>
         <CAP-5=fXWFvcvNOA+wJMSCp2Qz7EVruufvFBLWEXfdezeEJGUTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Ian,
 
On Thu, 2021-06-24 at 22:37 -0700, Ian Rogers wrote:
> On Thu, Jun 24, 2021 at 3:37 PM Riccardo Mancini <rickyman7@gmail.com> wrote:
> > 
> > In perf annotate, when 's' is pressed on a line containing
> > source code, it shows the message "Only available for assembly
> > lines".
> > This patch gets rid of the error, moving the cursr to the next
> > available asm line (or the closest previous one if no asm line
> > is found moving forwards), before hiding source code lines.
> > 
> > Changes in v2:
> >  - handle case of no asm line found in
> >    annotate_browser__find_next_asm_line by returning NULL and
> >    handling error in caller.
> > 
> > Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>
> 
> > ---
> >  tools/perf/ui/browsers/annotate.c | 32 ++++++++++++++++++++++++++++---
> >  1 file changed, 29 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/ui/browsers/annotate.c
> > b/tools/perf/ui/browsers/annotate.c
> > index ad0a70f0edaf..f5509a958e38 100644
> > --- a/tools/perf/ui/browsers/annotate.c
> > +++ b/tools/perf/ui/browsers/annotate.c
> > @@ -343,6 +343,29 @@ static void annotate_browser__calc_percent(struct
> > annotate_browser *browser,
> >         browser->curr_hot = rb_last(&browser->entries);
> >  }
> > 
> > +static struct annotation_line *annotate_browser__find_next_asm_line(
> > +                                       struct annotate_browser *browser,
> > +                                       struct annotation_line *al)
> > +{
> > +       struct annotation_line *it = al;
> > +
> > +       /* find next asm line */
> > +       list_for_each_entry_continue(it, browser->b.top, node) {
> > +               if (it->idx_asm >= 0)
> > +                       return it;
> > +       }
> > +
> > +       /* no asm line found forwards, try backwards */
> > +       it = al;
> > +       list_for_each_entry_continue_reverse(it, browser->b.top, node) {
> > +               if (it->idx_asm >= 0)
> > +                       return it;
> > +       }
> > +
> > +       /* There are no asm lines */
> > +       return NULL;
> > +}
> > +
> >  static bool annotate_browser__toggle_source(struct annotate_browser
> > *browser)
> >  {
> >         struct annotation *notes = browser__annotation(&browser->b);
> > @@ -363,9 +386,12 @@ static bool annotate_browser__toggle_source(struct
> > annotate_browser *browser)
> >                 browser->b.index = al->idx;
> >         } else {
> >                 if (al->idx_asm < 0) {
> > -                       ui_helpline__puts("Only available for assembly
> > lines.");
> > -                       browser->b.seek(&browser->b, -offset, SEEK_CUR);
> > -                       return false;
> > +                       /* move cursor to next asm line */
> 
> comment nit, perhaps prefer "closest" rather than "next" due to
> searching backward.

The backward search is just a fallback in case the forward one finds no asm
line, which I believe is unlikely. Maybe it's also impossible, but I don't
really know how those lines are generated, so I put a fallback in place.
Furthermore, "closest" would imply that a previous asm line could be chosen over
a subsequent one if closer, even if the latter is present.

Thanks,
Riccardo 

> 
> Thanks,
> Ian
> 
> > +                       al = annotate_browser__find_next_asm_line(browser,
> > al);
> > +                       if (!al) {
> > +                               browser->b.seek(&browser->b, -offset,
> > SEEK_CUR);
> > +                               return false;
> > +                       }
> >                 }
> > 
> >                 if (al->idx_asm < offset)
> > --
> > 2.31.1
> > 


