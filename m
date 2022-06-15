Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB13CCA47A
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Jun 2022 00:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiFOAK1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 14 Jun 2022 20:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235780AbiFOAKZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Jun 2022 20:10:25 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE132CDD5
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jun 2022 17:10:22 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id y29so11471225ljd.7
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jun 2022 17:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ZT+Efo6l+fWT1GirYyYwbz0NJsp81iiUhfjEirzp/k=;
        b=LJsnOP4CoKnvqaCcnqWlC4bwcEXcXTiyFVB96RpleJz6aoN2TOWXDruPGAL1t4uyav
         fRwNhAGBhBCG9FfgAJ3paUHXoFOmWAnAYo1suprtZZ5mS25tQZhwbQv5FyI4sSd70YS5
         4iXFdClQRAb4nXx27awSKYV5VKjXYyh/yvDxkXzfADWYsMrv9kWXj6lqX392Jp0L5Q+M
         RDCj8GS+HyFvJrKemFToSdK9WwmAtasMd38Kf+NkdI70HOZ8A3ykXi6gR0SaKrJY9Ils
         E0AXh2805qHeURJmVGo7/Yvc/7e+kFMmIUCTpAoz7cqgZ/Ep3kXXQ2MoSBlIpIlTi9El
         knfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ZT+Efo6l+fWT1GirYyYwbz0NJsp81iiUhfjEirzp/k=;
        b=w7NEQsHQFGy0QoZowj0vSssxa/BnI6drUKz6DJewGGpLE7kL4A5xUEL3Ya9LDka4mr
         dRCpiYjsO6KCj5za3+1ZtyFIDxsSjZS+MZjEO5h/suzWtd+Nb09xprI2IOSL1nbz2XmV
         7Z2ANS5ku0Q6+nMv4aLbGuwNgHavPAnSReqGkilrcHGC8r81W+wT110AmR3FsqT3AF+n
         e4eM9Ar6SwtSx/8Alo30lVyoAJsTCZEybl83fQQbm2eL7mMvshUhWVstTuPaFiblTccL
         6Wm9ONjJaQrI0WecVlwwBgFrG4spXGYMoGQgAnleBWWqKxQ5RMp8M6FhyigyxAYkh9X8
         8TPw==
X-Gm-Message-State: AJIora8EYQ8G87tzrUimOz2o/4xbvTV52/ND9DoSGsrRYsN+fqHwxg0I
        bTO8F3XiSfUa4kH4maj5xRcrSIsOBKW5cdKHIyl5Fg==
X-Google-Smtp-Source: AGRyM1tc8Y8MD8cs3DZZWCSYKv3VbS7+QZXAjenyYqIarR/gDOwbvsPN4LNGaN/+GpwS+/adL0KUFlgsnQ6JCoCkOaE=
X-Received: by 2002:a05:651c:44f:b0:255:889c:d100 with SMTP id
 g15-20020a05651c044f00b00255889cd100mr3827072ljg.352.1655251820395; Tue, 14
 Jun 2022 17:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220607191550.4141024-1-blakejones@google.com>
 <YqZmSRS8UPQJzWFE@krava> <CAP_z_CgkJ8RgWevJnDiq-+JjB=ni0OzJ3npwW+S9RZ66i0Y3Kg@mail.gmail.com>
 <Yqh/EkVy99Bej46S@krava>
In-Reply-To: <Yqh/EkVy99Bej46S@krava>
From:   Blake Jones <blakejones@google.com>
Date:   Tue, 14 Jun 2022 17:10:09 -0700
Message-ID: <CAP_z_Ci+Zm5v33hc-WaaLKj9ruJtBY-FMVhrcR7ZX1uJdquLvA@mail.gmail.com>
Subject: Re: [PATCH RESEND] Add a "-m" option to "perf buildid-list".
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jun 14, 2022 at 5:29 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> still there's kernel map included, so it's strange to me call it modules
>
>   --m/--kernel-maps ?

Sure, I'll go with that.

> > > also please state that it's from running kernel
> >
> > Happy to make this change.
> >
> > > any reason why not use the dso fields directly?
> >
> > I was just following my general software engineering instincts to
> > encapsulate implementation details, so that e.g. the caller doesn't need to
> > know about details such as the "has_build_id" boolean. I haven't made
> > changes to perf before, so if that's not the preferred style, I can do it
> > a different way.
>
> we have some helpers for dso fields, but AFAICS long_name and has_build_id
> are used directly all over the place

Okay, I've switched the code over to use those fields directly.

New patch coming shortly.

Blake
