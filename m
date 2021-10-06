Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A593C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 21:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F78461090
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 21:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbhJFVb6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Oct 2021 17:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbhJFVb6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Oct 2021 17:31:58 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCEAC061746
        for <linux-perf-users@vger.kernel.org>; Wed,  6 Oct 2021 14:30:05 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id p80so4399196iod.10
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Oct 2021 14:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0zBPXRSSAGzqJdml9Nzm99t+jOLfP1j9fPgZAL4uLqo=;
        b=BoslKHcklYfLaUPb5NjSkZGHX4/3SlW68omz7OZfKWAjaqslhq2H0lTOhE5Q83Kq+x
         MmXltvMtQqXrV7rS+ppA4X/Ep9UeR2BumHpSWtI+AdAzZFPqZeoftic92SM7SU64zrF/
         iisf2T0IvLD/sLh7j+MkWfdWgTw61kpwwAmVU6K5Q19219h3MGAcUw+RNcFxXpyqNbMj
         oFh6R30WlGTDwbP+pARUJRtA1FMqY0GkwDryjV5/cXY0obGpCS2n4OPXONyvPWi6o4lo
         iMwUcPFKRTIy8fWJHUdQ3lNAWbto/xoVLaXEJ0rc8fdQVNzd7pt8hXsf+Uhdy+Xm2UfF
         bbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0zBPXRSSAGzqJdml9Nzm99t+jOLfP1j9fPgZAL4uLqo=;
        b=jTPIxq4+oTXQNrVcc/88YHzo4TcVc1sIXtexX4yCcZzYpLIT/3/PkClQ+g3xAAZt5h
         EexqOrlUEQATKVjSLWwDfDEq6Kz8YBvnaTBt5vI3j4jfLYBnde7HV+3dRO52/mnUqqDx
         9FLAFylBvDXn54eB0lNcTHpo5Jdp/XnFO6bwdW1L7stoyOHciG/V/IvPg+Ibd/SAnERa
         gxbFonX7tVfqBqLswKkjl2QBBDPKwqIMeUUH6ShBpKBdWGbsGPvBq1e4dtCl5nA73IGC
         APC7tmF4tly55e/vvweVz/IrM2y2jBR8Qc2G7X1RzFn+F6OTxtcufQXVYCOQsgjimFtm
         prWQ==
X-Gm-Message-State: AOAM533/H/b4HU7R53bzrPsoszC+W+tV/Ta0KA9Ug5ySKaDE9Aorxbu0
        hWDOcX3ddENh0RKHowCs8v3Mt9Rn+LZUx7Jd2Ko=
X-Google-Smtp-Source: ABdhPJwRE+u2MIRdSFarxNyGHM+EOX7iA+7D0q90InlBNnCuINcJWaMQPJHFQXp8r8AKP4vky53iWiNixwRTI3UJbqI=
X-Received: by 2002:a05:6602:345:: with SMTP id w5mr495506iou.49.1633555805154;
 Wed, 06 Oct 2021 14:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAPNhM=aGeiKAVFDHWuP=GcAbgUz=JgWwtKfoRgmuxoG0gNfciQ@mail.gmail.com>
 <DA2A1D0F-1877-41D1-BC87-C0AE70D3E18C@gmail.com> <YVv4B4syx36Co/0+@krava>
In-Reply-To: <YVv4B4syx36Co/0+@krava>
From:   Renjith Ponnappan <renjithponnapps@gmail.com>
Date:   Wed, 6 Oct 2021 14:29:54 -0700
Message-ID: <CAPNhM=Ym=RL7QCcaA7GLPreMuO-f7as_77yy_N8eSgD2YLophA@mail.gmail.com>
Subject: Re: Perf: Question about continuous background data collection
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        jolsa@kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello Arnaldo & Jiri,

Thank you for your response.

The perf daemon is the closest implementation for what I was looking
for. Here we run perf in the back-ground, keep overwriting the samples
being collected and use the SIGUSR2 to signal to the perf daemon to
collect the perf data to a file. This fulfills the following
requirements:

1. Run perf in the background to collect data
2. A method to signal perf to collect the samples for the current cycle.

The last part of the requirement which  was:

1. The data-collection in step 2 above, rather than writing the data
to file store it in in-memory datastructure via pointer manipulation.
We can have a list of such samples stored in memory until the next
step. This helps free up the CPU cycles used by perf for writing to
file for applications.
2. A method to signal perf to dump all the collected samples into
separate files. This way the user can collect the stored samples when
the CPU is relatively free.

Let me know whether we have support for storing samples as in-memory samples.

Thanks in advance for your help!

cheers,
Renjith
cheers,
Renjith

On Tue, Oct 5, 2021 at 12:00 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Thu, Sep 30, 2021 at 10:39:21PM -0300, Arnaldo Carvalho de Melo wrote:
> >
> >
> > On September 30, 2021 10:28:28 PM GMT-03:00, Renjith Ponnappan <renjithponnapps@gmail.com> wrote:
> > >Hello Peter/Ingo/Arnaldo,
> > >
> > >First of all, apologies if I bombarded you with an irrelevant question in
> > >your busy day and ignore this if the question is irrelevant.
> > >
> > >I had a question about continuous background data-collection with perf and
> > >hope you are the right person to answer this. If not, it would be great if
> > >you can redirect me to the right person.
> > >
> > >I am trying to build a CPU profiling system (on an embedded ARM Platform
> > >with CPU/memory constraints) which has CPU Samples already collected when
> > >an application CPU starvation scenario occurs based on perf. The
> > >implementation I am trying to use is:
> > >
> > >   1. Run perf in the background collecting samples for the entire system
> >
> >
> > This is already in perf:
> >
> > https://www.spinics.net/lists/linux-perf-users/msg11455.html
> >
> >
> > Reply adding linux-perf-users@vger.kernel.org.
> >
> > - Arnaldo
> >
> >
> > >   with a sleep period of 60 seconds
> > >   2. When an application CPU starvation scenario occurs (detected and
> > >   raised by applications) notify the collection process to store the last
> > >   perf collection as data to be analyzed offline.
> > >
> > >Have you come across such a scenario and any recommendations on this?
> > >
> > >The following are the two implementations I have on the above:
> > >
> > >   1. An external process which instructs perf to record the 60 seconds by
> > >   providing unique filenames each time. This approach was taking around 40%
> > >   CPU of a CPU core, everytime the perf record was getting written (once for
> > >   each 60 seconds cycle). This isn't okay as it could cause aggravation of
> > >   the CPU starvation situation.
> > >   2. I tinkered with Perf Code to add the logic of looping and writing the
> > >   file incase of an event only. This did reduce the CPU to only the case when
> > >   an event was detected.
>
> hi,
> and there's also perf daemon to run perf sessions on background:
> https://lore.kernel.org/lkml/20210130234856.271282-19-jolsa@kernel.org/
>
> jirka
>
> > >
> > >Would like to hear your opinion on whether approach 2 is the right way here
> > >and any suggestion/guidance you may have.
> > >
> > >Thanks in advance for this help!
> > >
> > >*cheers,*
> > >*Renjith*
> >
>
