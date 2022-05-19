Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC14C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 May 2022 04:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbiESErv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 19 May 2022 00:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbiESErt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 May 2022 00:47:49 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E279556437
        for <linux-perf-users@vger.kernel.org>; Wed, 18 May 2022 21:47:48 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id a14-20020a7bc1ce000000b00393fb52a386so4308494wmj.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 May 2022 21:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bDQ/G9si/q6pRTY57bn5CgRuv91q+1D0ytzIM8aSkDs=;
        b=oFKE2nPdHnGrvcWjxHD2eCwSLCOSsA83NfLxEqD1p8o6kI0wWHqsV3lIywRoQtAVry
         0OFZN8srxVDvo8k9KaVSfxjJBPqSvIpOeQTRx4J+yxhCzb17cNEieKVgO7CegkQnCdrk
         JHV2575zQvgaqPrRdAD9uJB6v/6z+OvVNHWtZjr2yYJn2IPpB6eod/3vrA7OTY6AletY
         ous3BDm4Upw7E+2X0FHyiMYXGFI1uDfMjAHr50L1B8379EpWizDErANAO1uH4jTKAMeP
         fgajW7jgBiSeAJ9BzDb9P4e4FT/UpeG2Nd+M2bubOdVzETm1Ur99zWtuIyNesvvk9RL4
         XeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bDQ/G9si/q6pRTY57bn5CgRuv91q+1D0ytzIM8aSkDs=;
        b=e/f9MUjF3NC233VvZjCB8TiUOHXJqJdWnKIWJceeFYhPnQodgh5pVSebOyTdaUts8S
         61d1rApzipg4oJLAbOuE0J+4myKAYiRMOwKnVf5IQS1htcsbncjfSSmtOj3MdN7R4SDA
         fPtkg5FoaWMboJgPvrDW3IRExIuqcd+zH9vidkTeritIpF3okk6Qkyuial4t71xCgZkp
         QsgI3pUqXCEmv4dOiOvmV/MwYJ4xZZRqYfZP90iJR3iEuPkEjizvcBV33+u7SqT9t5Ra
         6PWUZ2EtgKq83OgxhztlBtErosMUokmpXOK029kHJf0Zz1t3dzeUb6DAF5i/ikCYNwPt
         gjWQ==
X-Gm-Message-State: AOAM53353YHd0y9UqklvGB6kEkHHekkq4c2+s9tSm8kts5dUjCb9LR/B
        FLH+D1RgXcp15EBWvLo2NyitDnHnT7sme9NzJ+fxxA==
X-Google-Smtp-Source: ABdhPJwAjL2vm0z/tecnByHz7WpBGfucjFhqdlps0840g+H/jdv3q1dWo9FdsNLcwkJ8EMq3AOlExs2O4+fpbeECxZ8=
X-Received: by 2002:a1c:a301:0:b0:392:9bc5:203c with SMTP id
 m1-20020a1ca301000000b003929bc5203cmr1995463wme.67.1652935667259; Wed, 18 May
 2022 21:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220503213704.2524229-1-blakejones@google.com>
 <YnqW68rLssWA8uba@kernel.org> <CAP_z_CjM=xdogE7YMhwPj25rG7cvK6=TS_0O_bJ22+SgW6pxhQ@mail.gmail.com>
In-Reply-To: <CAP_z_CjM=xdogE7YMhwPj25rG7cvK6=TS_0O_bJ22+SgW6pxhQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 18 May 2022 21:47:35 -0700
Message-ID: <CAP-5=fXdC_opBmFRY_F5xXwVybnx3aagg3nv54ykfmpwYBknMg@mail.gmail.com>
Subject: Re: [PATCH] Add an "-m" option to "perf buildid-list".
To:     Blake Jones <blakejones@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, May 10, 2022 at 11:13 AM Blake Jones <blakejones@google.com> wrote:
>
> Thanks for taking a look at this!
>
> On Tue, May 10, 2022 at 9:46 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> > Em Tue, May 03, 2022 at 02:37:04PM -0700, Blake Jones escreveu:
> > > +-m::
> > > +--modules::
> > > +     Show buildid, start/end text address, and path of kernel and modules.
> >
> > Hi,
> >
> >         Wouldn't it be better to have -m show just modules, name +
> > buildid, then have -v show more verbose info, i.e. the start, end and
> > switch from just the module name to its full path?
> >
> >         Then to get what your patch produces now one would use:
> >
> >         $ perf buildid-list -kmv
> >
> >         That would be more flexible, wdyt?
>
> I'm open to using "-v" like this if you think it would be useful; is
> there a use case you have in mind for the non-verbose mode? For doing
> external symbolization of stack traces, the BuildID isn't useful without
> also knowing the starting and ending addresses.
>
> If "-m" only showed information about modules and not about the kernel,
> then "perf buildid-list -km" (without "-v") would have different output
> formats for the kernel and for the modules. So I'm inclined to have "-m"
> include information about the kernel as well as the modules.
>
> How does that sound?
>
> Blake

Using "-m" sounds okay to me, Arnaldo?

Thanks,
Ian
