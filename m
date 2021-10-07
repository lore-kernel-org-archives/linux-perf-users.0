Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435CCC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 16:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B6C061039
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 16:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbhJGQym (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Oct 2021 12:54:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25637 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229810AbhJGQyl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Oct 2021 12:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633625567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gFHuovLl8Tzxhi32KOQprUG2r46OBjnzj3xCQ3gFUUQ=;
        b=QCxP/pQEvSl+uzhveHfnflgvCdVpf2e3kE/TCglHqMij30zvZPc1jJV3gU04EYWMnhAmTT
        WjvZNZutRIsFQGvlG85FxwgDHPmzJlxFarvDWQvByfrzpOXxZxNRowoL1ft84wn8G1AGmh
        sDTMza4rROxZ18O0PZylAviongnsyAk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-DYYJuPrKOGaZYnnDNEkwlQ-1; Thu, 07 Oct 2021 12:52:43 -0400
X-MC-Unique: DYYJuPrKOGaZYnnDNEkwlQ-1
Received: by mail-wr1-f70.google.com with SMTP id l9-20020adfc789000000b00160111fd4e8so5214236wrg.17
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Oct 2021 09:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gFHuovLl8Tzxhi32KOQprUG2r46OBjnzj3xCQ3gFUUQ=;
        b=X9Ecc7K826H6PjUTaMzL+OromE9IXKrmkBidWs2Lxn+wMbQrqMCrVtZfwO1mIXmbD4
         eHoEaLqABLPQ9kiaNn3CcCLYWQqnJtys6cspixotCPIHIndzihqkFgR7ASj9IKsKwoWs
         g7tJKgqGSHNFXW8fomm2dl10BLJ7UrtlNvb3ayMd/Caoi9dsP1xIdr+QfNHhus6Z3/AN
         1jgPUNH3wJEbn0P7mdNNW0dM2b67RtrFBoIcjh0YCOgmMPfdOXaj1a6XIEs1G09rci6w
         roBf+EmUTiTrB645cz1dhRjZgyzNv/06FoCePmpmsw4gSX2TYHhAd0fnHcfAfgRm7mQt
         gzmQ==
X-Gm-Message-State: AOAM5319MA3nifhJJATuQMGpyQXlPUiadioORHZgYSKpvbRMYe4FiKbh
        aXv6ecNzxaXF5o8QgU3Qferpxea1rEioATc8evQErjRWlWviuExiGWC566AVxyZJbnaxcTy+f9X
        D8Q6QrlQNSW8MIz3C9VfKkYbXVEka4w==
X-Received: by 2002:adf:f584:: with SMTP id f4mr7042802wro.60.1633625562529;
        Thu, 07 Oct 2021 09:52:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8vmpRS55NW0L1a+yaDF4MgFIbWLb2tiH2ig6I6ZTpuB+lbBI4uNk/hZ5/48+7T882fm1T9Q==
X-Received: by 2002:adf:f584:: with SMTP id f4mr7042777wro.60.1633625562361;
        Thu, 07 Oct 2021 09:52:42 -0700 (PDT)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id e8sm366351wrg.48.2021.10.07.09.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 09:52:42 -0700 (PDT)
Date:   Thu, 7 Oct 2021 18:52:40 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Renjith Ponnappan <renjithponnapps@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        jolsa@kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: Perf: Question about continuous background data collection
Message-ID: <YV8l2Ofr3dlUJjIB@krava>
References: <CAPNhM=aGeiKAVFDHWuP=GcAbgUz=JgWwtKfoRgmuxoG0gNfciQ@mail.gmail.com>
 <DA2A1D0F-1877-41D1-BC87-C0AE70D3E18C@gmail.com>
 <YVv4B4syx36Co/0+@krava>
 <CAPNhM=YRUMw2VuHg3e5RH33UTCDG0guiqvCrfwb_kW_PkLvipw@mail.gmail.com>
 <383B1714-E2A5-4678-8348-5B2AA5BE0833@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <383B1714-E2A5-4678-8348-5B2AA5BE0833@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Oct 07, 2021 at 06:17:29AM -0300, Arnaldo Carvalho de Melo wrote:
> 
> 
> On October 6, 2021 6:25:57 PM GMT-03:00, Renjith Ponnappan <renjithponnapps@gmail.com> wrote:
> >Hello Arnaldo & Jiri,
> >
> >Thank you for your response.
> >
> >The perf daemon is the closest implementation for what I was looking for.
> >Here we run perf in the back-ground, keep overwriting the samples being
> >collected and use the SIGUSR2 to signal to the perf daemon to collect the
> >perf data to a file. This fulfills the following requirements:
> >
> >   1. Run perf in the background to collect data
> >   2. A method to signal perf to collect the samples for the current cycle.
> >
> >The last part of the requirement which  was:
> >
> >   1. The data-collection in step 2 above, rather than writing the data to
> >   file store it in in-memory datastructure via pointer manipulation. We can
> >   have a list of such samples stored in memory until the next step. This
> >   helps free up the CPU cycles used by perf for writing to file for
> >   applications.
> >   2. A method to signal perf to dump all the collected samples into
> >   separate files. This way the user can collect the stored samples when the
> >   CPU is relatively free.
> >
> >Let me know whether we have support for storing samples as in-memory
> >samples.
> 
> Have you looked at the URL I pointed to you?
> 
> https://www.spinics.net/lists/linux-perf-users/msg11455.html
> 
> More specifically, read about 'perf record --overwrite"

also there's example with flight recorder in perf-daemon man page:
https://man7.org/linux/man-pages/man1/perf-daemon.1.html

jirka

> 
> - Arnaldo
> >
> >Thanks in advance for your help!
> >
> >*cheers,*
> >*Renjith*
> >
> >
> >On Tue, Oct 5, 2021 at 12:00 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> >> On Thu, Sep 30, 2021 at 10:39:21PM -0300, Arnaldo Carvalho de Melo wrote:
> >> >
> >> >
> >> > On September 30, 2021 10:28:28 PM GMT-03:00, Renjith Ponnappan <
> >> renjithponnapps@gmail.com> wrote:
> >> > >Hello Peter/Ingo/Arnaldo,
> >> > >
> >> > >First of all, apologies if I bombarded you with an irrelevant question
> >> in
> >> > >your busy day and ignore this if the question is irrelevant.
> >> > >
> >> > >I had a question about continuous background data-collection with perf
> >> and
> >> > >hope you are the right person to answer this. If not, it would be great
> >> if
> >> > >you can redirect me to the right person.
> >> > >
> >> > >I am trying to build a CPU profiling system (on an embedded ARM Platform
> >> > >with CPU/memory constraints) which has CPU Samples already collected
> >> when
> >> > >an application CPU starvation scenario occurs based on perf. The
> >> > >implementation I am trying to use is:
> >> > >
> >> > >   1. Run perf in the background collecting samples for the entire
> >> system
> >> >
> >> >
> >> > This is already in perf:
> >> >
> >> > https://www.spinics.net/lists/linux-perf-users/msg11455.html
> >> >
> >> >
> >> > Reply adding linux-perf-users@vger.kernel.org.
> >> >
> >> > - Arnaldo
> >> >
> >> >
> >> > >   with a sleep period of 60 seconds
> >> > >   2. When an application CPU starvation scenario occurs (detected and
> >> > >   raised by applications) notify the collection process to store the
> >> last
> >> > >   perf collection as data to be analyzed offline.
> >> > >
> >> > >Have you come across such a scenario and any recommendations on this?
> >> > >
> >> > >The following are the two implementations I have on the above:
> >> > >
> >> > >   1. An external process which instructs perf to record the 60 seconds
> >> by
> >> > >   providing unique filenames each time. This approach was taking
> >> around 40%
> >> > >   CPU of a CPU core, everytime the perf record was getting written
> >> (once for
> >> > >   each 60 seconds cycle). This isn't okay as it could cause
> >> aggravation of
> >> > >   the CPU starvation situation.
> >> > >   2. I tinkered with Perf Code to add the logic of looping and writing
> >> the
> >> > >   file incase of an event only. This did reduce the CPU to only the
> >> case when
> >> > >   an event was detected.
> >>
> >> hi,
> >> and there's also perf daemon to run perf sessions on background:
> >> https://lore.kernel.org/lkml/20210130234856.271282-19-jolsa@kernel.org/
> >>
> >> jirka
> >>
> >> > >
> >> > >Would like to hear your opinion on whether approach 2 is the right way
> >> here
> >> > >and any suggestion/guidance you may have.
> >> > >
> >> > >Thanks in advance for this help!
> >> > >
> >> > >*cheers,*
> >> > >*Renjith*
> >> >
> >>
> >>
> 

