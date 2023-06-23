Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E76EB64DA
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jun 2023 00:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjFWAIW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Jun 2023 20:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjFWAIV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Jun 2023 20:08:21 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AB2173F
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 17:08:19 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-3ff274778feso1487231cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 17:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687478898; x=1690070898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nKfdjWTPm6jN+xmEUtkjzg7IE8QzNUiWiYx4FOQR5fw=;
        b=Qp3sXfi88dtNLAGB5rx1oxgcKeSffVrMrDp8D9EgBeOKN43QlQHlKZH8XESSChB8cv
         MLCxuy+F2WCAii1D2aE+q56/w8V+csu8KK/+xvNWUhhvPuo0Hvg8NnDvr3CKkq9fVnTD
         q2xVkQ565Py0IX9BuHcMAecaOER9uqlV1VYAtdKOgeHsenFmzot1owaPHlXgxiDpe/1l
         oFkEUXAYZ9UBjDgT1A5lIAsht+M6XIBSI7pmLz/7vZ9i3hugvLwYQhl0pYQkoaPKDsHe
         /fRO6SFYHfPkcr95OhvqEBkbFW37gk5QPFmbrzEYFlgT8QYLqruZPZKAlkB3/qs6iyoF
         pdzA==
X-Gm-Message-State: AC+VfDzV8y24LsvBs82TsBKnrbCsDM9Ep8lrV41qNUMbMj8SogGaEBXk
        WaDOYFx8PtjpIbZY8OE5G7MFdXSqLDGjDJyytog=
X-Google-Smtp-Source: ACHHUZ7gcJb9Rfaa5xpqPdI7bJrOVK0Fzm+9u8dmkTdoTiCKDCyeDtbSUnNPQDgFgo9V1Mh/J2L0bwLFcfR6HWO8Km8=
X-Received: by 2002:a05:622a:4e:b0:3f6:914f:5934 with SMTP id
 y14-20020a05622a004e00b003f6914f5934mr24752633qtw.58.1687478898198; Thu, 22
 Jun 2023 17:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <ZJOmXU/41HMzanM9@tassilo> <CAP-5=fWZAcXcE3CP-V7t=gSehO-AacHJWhjHjtA5nCd5B2-n1A@mail.gmail.com>
 <ZJQSUHLe9Cqpw21n@tassilo> <CAM9d7cgpegLH9QpUhHQy0ckMpO6CaKaYrAeHKNm4CT01R4bhGw@mail.gmail.com>
 <ZJSr2PbOrpFrSIaL@tassilo>
In-Reply-To: <ZJSr2PbOrpFrSIaL@tassilo>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 22 Jun 2023 17:08:06 -0700
Message-ID: <CAM9d7cj1XXpuaPss7qa7eSD8LJCQZ1KorviOxxnt2Hpk_J3ugQ@mail.gmail.com>
Subject: Re: Perf stat regression from d15480a3d67
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 22, 2023 at 1:15 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> On Thu, Jun 22, 2023 at 12:09:14PM -0700, Namhyung Kim wrote:
> > Hi Andi,
> >
> > Sorry about the breakage.
> >
> > On Thu, Jun 22, 2023 at 2:20 AM Andi Kleen <ak@linux.intel.com> wrote:
> > >
> > > > Can you provide an example that is breaking?
> > >
> > > I only have a very long auto generated example[1], because it's not
> > > easy to make a non scheduling event and it's also dependent on the system. The example
> > > works on a SKX.
> > >
> > > >
> > > > Wrt event order, cases like:
> > > > ```
> > > > $ sudo perf stat -e '{data_read,data_write}' -a --no-merge sleep 1
> > > >
> > > > Performance counter stats for 'system wide':
> > > >
> > > >          1,960.81 MiB  data_read [uncore_imc_free_running_1]
> > > >            438.48 MiB  data_write [uncore_imc_free_running_1]
> > > >          1,961.85 MiB  data_read [uncore_imc_free_running_0]
> > > >            438.79 MiB  data_write [uncore_imc_free_running_0]
> > > >
> > > >       1.001127356 seconds time elapsed
> > > > ```
> > > > Reorder events so that the PMUs match (ie the -e order would 2x
> > > > data_read followed by 2x data_write). This covers more cases now so
> > > > that perf metric (aka topdown) events aren't broken when coming out of
> > > > metrics:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/parse-events.c?h=perf-tools-next#n2139
> > >
> > > How is any tool supposed to handle arbitary output reordering like
> > > that? Perf is not just for humans, but also for tools.
> >
> > Is the problem of reordering the output or hiding something?
> > Do you mean both?
>
> For my tool it's both. In this particular case it's the hiding
> that broke it
>
> If the reordering only happens on broken groups etc. as Ian wrote that's ok for me
> because I can avoid generating them. But I can't tolerate hiding.

I see.  I'm not aware of the reordering.  But I agree that
hiding events can be a problem.

>
> > >
> > > >
> > > > Given the original commit message there seems little point to give the
> > > > 0 counts, but perhaps it is something that could be done on the more
> > > > tool oriented CSV and JSON output formats.
> > >
> > > It's not 0 counts, it's <not supported>. But even 0 counts can
> > > be important.
> > >
> > > We should always output when something doesn't count so that
> > > the user knows something is wrong. Hiding problems is always a bad idea
> > > and not an improvement.
> >
> > Right, I wanted to skip (or hide) events that are not reasonable
> > like with redundant or invalid setups.  It should display those
> > error results.
>
> Okay so the skipping can just be removed?

The existing use case was system-wide --per-thread mode.
It would generate too much noise without it.

>
> >
> > Didn't you say you only have problems in uncore events?
>
> For this test case I only hit it with the uncore, but I would have a general
> problem for any event if it was hidden.

stat-display.c::should_skip_zero_counter() specifically checks
uncore PMU events, so I don't think core events have problems.

Also it only skips when aggregation id doesn't match, which means
the (default) global aggregation mode should not skip any uncore
events.

Can you please help me to find a minimal repro?

Thanks,
Namhyung
