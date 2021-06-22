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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEE9C2B9F4
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 07:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2DBC61289
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 07:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhFVIBG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Jun 2021 04:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhFVIBG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Jun 2021 04:01:06 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A350BC061574;
        Tue, 22 Jun 2021 00:58:50 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j2so11928877wrs.12;
        Tue, 22 Jun 2021 00:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=GacSld8tsexvk12R+n0D8RTnLhPT/YnKqSV23XiwGIE=;
        b=XdYei3ecblHrR5naLfTZPKtJc3SaM4HJ1U6yh7Yg9+JjfJIUV4td2xe6m7IdKhCKya
         rgP37Q33xUNWzMvFPC2T6RkL6EGwuycfq80zM1eM/YkG+p8br9DxU5iVyAWkPx9qWnqY
         SsSWb51GdjLN7STZK6qHvD4PPq/MetUwVs9f7scGbNP9LyxB8yqqodrlY/2GJAkWOoop
         jdlCog/eTu1+nz8hLzhDPBZyIJ0Lz3++Lxwpvz/rlFFv+AIzdSVAt+MxEZiscV9iwrl/
         rCqQpSvBMq0ugVDWh8twpWaSvhHeCtCb9xt4vHSyqNq0bUgR1M9c4nwEUbKQ3QRGxBdF
         Bryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=GacSld8tsexvk12R+n0D8RTnLhPT/YnKqSV23XiwGIE=;
        b=lxeqLAIAbJESSPrm+eGDG1LDzjd6VdJrrYYZuQ1zEhyiN6yU4ZOQ1gQEHiR76wQp8f
         ICOn/Q4Zq8ckeHpNLwxuzuMjuBOP7v7OszYeCnLyexbqbtgHXwa1QCqCsXWNcr8QbckD
         8qfSch/NwuKGm7ZVmAeEwJJCVz4vQY/qorOLb9RDhnpXbubdoNUHQef9/OtLZgCDaQ2w
         hVz0VXoqdvAVclnEUSD2izhFrld3ZoY+/oz/oGEDIMkyt5xnCfTvLquoILBM2BkB0FEy
         8HYVuOccmEnj6fZojuFVrNjGvfb32cHxCpEB0Moj9C8D2a7bn2NRIEcnNP2Aic5VZWmo
         xxPA==
X-Gm-Message-State: AOAM532lV/8uUg/a87mJzODJGMfTfNKOk0inH8ozG1cRUlZ0n64gF3+9
        FX/KlyWAR8vH+VRlTfCBOWk=
X-Google-Smtp-Source: ABdhPJxWWHz+F4HtsM8B5/4j3VDA59biPyaGZViPgW2X1d2vdePaecZDJYD/Z8D8KYFBOhedmPw46Q==
X-Received: by 2002:a5d:6acc:: with SMTP id u12mr3052514wrw.414.1624348729257;
        Tue, 22 Jun 2021 00:58:49 -0700 (PDT)
Received: from [192.168.1.15] ([151.29.45.200])
        by smtp.gmail.com with ESMTPSA id p11sm10588972wre.57.2021.06.22.00.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 00:58:48 -0700 (PDT)
Message-ID: <6b07d15b7bd02a63eef8282b1844be57ba9cb044.camel@gmail.com>
Subject: Re: [PATCH] perf annotate: allow 's' on source code lines
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Martin Liska <mliska@suse.cz>,
        Jason Yan <yanaijie@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 22 Jun 2021 09:58:47 +0200
In-Reply-To: <CAP-5=fVNCcLyAZx2nqOn2t=BTW1FB9sU=-gmSNWukKcTb8HE+Q@mail.gmail.com>
References: <20210621230047.211430-1-rickyman7@gmail.com>
         <CAP-5=fVNCcLyAZx2nqOn2t=BTW1FB9sU=-gmSNWukKcTb8HE+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

thank you for your comment.

On Mon, 2021-06-21 at 22:07 -0700, Ian Rogers wrote:
> On Mon, Jun 21, 2021 at 4:02 PM Riccardo Mancini <rickyman7@gmail.com> wrote:
> > 
> > In perf annotate, when 's' is pressed on a line containing
> > source code, it shows the message "Only available for assembly
> > lines".
> > This patch gets rid of the error, moving the cursr to the next
> > available asm line (or the closest previous one if no asm line
> > is found moving forwards), before hiding source code lines.
> > 
> > Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> > ---
> >  tools/perf/ui/browsers/annotate.c | 28 +++++++++++++++++++++++++---
> >  1 file changed, 25 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/ui/browsers/annotate.c
> > b/tools/perf/ui/browsers/annotate.c
> > index ad0a70f0edaf..eb94d20d0d13 100644
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
> > +       return al;
> 
> Does this error case need handling in the caller?

Agreed.
I believe this should never happen, but in case it happens it will cause
problems.
I'll change it to return NULL and handle it in the caller.

Thanks,
Riccardo

> 
> Thanks,
> Ian
> 
> > +}
> > +
> >  static bool annotate_browser__toggle_source(struct annotate_browser
> > *browser)
> >  {
> >         struct annotation *notes = browser__annotation(&browser->b);
> > @@ -363,9 +386,8 @@ static bool annotate_browser__toggle_source(struct
> > annotate_browser *browser)
> >                 browser->b.index = al->idx;
> >         } else {
> >                 if (al->idx_asm < 0) {
> > -                       ui_helpline__puts("Only available for assembly
> > lines.");
> > -                       browser->b.seek(&browser->b, -offset, SEEK_CUR);
> > -                       return false;
> > +                       /* move cursor to next asm line */
> > +                       al = annotate_browser__find_next_asm_line(browser,
> > al);
> >                 }
> > 
> >                 if (al->idx_asm < offset)
> > --
> > 2.31.1
> > 


