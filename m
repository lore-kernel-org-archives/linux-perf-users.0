Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8142AC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Sep 2021 19:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BD1760F12
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Sep 2021 19:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347316AbhIBTXS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Sep 2021 15:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347303AbhIBTXR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Sep 2021 15:23:17 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181BBC061757
        for <linux-perf-users@vger.kernel.org>; Thu,  2 Sep 2021 12:22:19 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bt14so6885406ejb.3
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Sep 2021 12:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=atmKvuuz39eqdtx3hnaatuBxW4M1LZbdGA/OozBPq3w=;
        b=qnIvzRhSKDoO/CPKQ7+HpbiIn6s5+zv05tcgHieqjmqchj3pt1ihaheHIik/Sk8n/V
         zUzMNk/KNIFG1qzEAP+CgrEpENaFREo//umSvemDXoV5OwQ0zmPVjhQOkdTuj8G5nFLY
         CsuW9/CeUOA8WtlCYLhIOH62dVIxpGtll4B4UR0nbGVA46qF3JwOZpr2sH0L39fGJ6js
         Z8+nf1g51wT1mMrchAHsiFW6K4dKolGnn+w3A6LYufv4fvB/khmcUQELlCL2/Hy13/ok
         LJOoSLlTb49uxo08n3E9qYhQ5bdawmQw/IZRBwI6UuT5eXrYp19f+kowZZ7oCTG3BxGz
         UAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=atmKvuuz39eqdtx3hnaatuBxW4M1LZbdGA/OozBPq3w=;
        b=R1tO2ZLc7O1ZGU5FlJVGLlYJO9MGkpgE9krCHSafC3nOmPlHq+6HU0BmxqWhpTN09a
         2IXQMvXtux4b1cbTB5/k+V0JM86JDiv3rVqDWPCI3M2M3pZv2LGe5nh9XthkzTYImeC9
         MzKYTzzpYlPD48Nzs2GHnSFM7ot5TQuotADqAKZuBTVMW31zvwMgfp7oYqSdb/oSnHaD
         YBXz15wNfpiXvLrJmQAoBDCR70NEwwDhTG8DI3ATDe68rRwqqvsaRib8YjhAYmb1w2pr
         /bx2Hxj0o7R0phM00Sxb8jJF+nsuHuQJmcMFuQ36jv40Xd1iVg7HQfB4kWeMRu5yBo+X
         Q9qg==
X-Gm-Message-State: AOAM531/XpWwITaCZsmt8DZtzeReAuLwFOTb8wq0xOmOpGGj8QRHrIHt
        oOQA7ObT2SP25yVZfFUuBzzSBk+hfUZrmhLopMXvN6Xv6PU=
X-Google-Smtp-Source: ABdhPJwfvoiSLCL/ISgimbRjfXxgmuXHKGV4QD6nJYZW+26llSJV6QSPf75HnqYijrrgkfburoPsfPYZ5zkJnbdxfaI=
X-Received: by 2002:a17:906:56cc:: with SMTP id an12mr5495379ejc.456.1630610537647;
 Thu, 02 Sep 2021 12:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210806134109.1182235-1-james.clark@arm.com> <20210806134109.1182235-10-james.clark@arm.com>
 <20210824083615.GF204566@leoy-ThinkPad-X240s> <YS+iOrcPTzQfmbqU@kernel.org>
 <20210902174851.GB1078000@p14s> <YTEVwVCWoS8cgqql@kernel.org>
In-Reply-To: <YTEVwVCWoS8cgqql@kernel.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 2 Sep 2021 13:22:06 -0600
Message-ID: <CANLsYkxhj1RkJ+BYLGBZ=c=VHT6ayfHvP_T68xGxcnsKQXEVxA@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] perf cs-etm: Show a warning for an unknown magic number
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>, James Clark <james.clark@arm.com>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-perf-users@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, 2 Sept 2021 at 12:19, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Thu, Sep 02, 2021 at 11:48:51AM -0600, Mathieu Poirier escreveu:
> > Hi Arnaldo,
> >
> > On Wed, Sep 01, 2021 at 12:54:34PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Tue, Aug 24, 2021 at 04:36:15PM +0800, Leo Yan escreveu:
> > > > On Fri, Aug 06, 2021 at 02:41:09PM +0100, James Clark wrote:
> > > > > Currently perf reports "Cannot allocate memory" which isn't very helpful
> > > > > for a potentially user facing issue. If we add a new magic number in
> > > > > the future, perf will be able to report unrecognised magic numbers.
> > > > >
> > > > > Signed-off-by: James Clark <james.clark@arm.com>
> > > >
> > > > Reviewed-by: Leo Yan <leo.yan@linaro.org>
> > >
> > > Applies cleanly to my tree, test building it now, holler if there is
> > > something that prevents it from being merged.
> >
> > Have you already merged this?
> >
> > If so than let it be.  Otherwise please hold off as I'd like to take a look,
> > something I intend on doing next week.
>
> Ok, I can remove them from my local branch, but this may make this miss
> the v5.15 merge window, please advise.
>

Nah, leave it in your branch and proceed for this merge window.

> - Arnaldo
