Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C34C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 12:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2351B6135E
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 12:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhJTMWl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Oct 2021 08:22:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48510 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229864AbhJTMWk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Oct 2021 08:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634732426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7p6x4ndhUF9o+vT5JDjX3kZy/boxNOuzWqDxZizdvqQ=;
        b=BtOJO2PTsl6L7xVctmzw3xOxxKqbfuHKNzjmF+ic/AYrmOOH4XIIie8mBb6wy3VBj1+t3h
        hRbjQANoIUUXjZdyMduwdZLAVYSoD961p/2BwU8d/Se561WWqPkadJueEm4k6lrGnj7gk2
        v7mpTfTrqZ0vzeepcnsDShLtpNfmB74=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-iaAd-jhuNta2dKvVS-q5Sg-1; Wed, 20 Oct 2021 08:20:25 -0400
X-MC-Unique: iaAd-jhuNta2dKvVS-q5Sg-1
Received: by mail-ed1-f69.google.com with SMTP id c25-20020a056402143900b003dc19782ea8so17342545edx.3
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Oct 2021 05:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7p6x4ndhUF9o+vT5JDjX3kZy/boxNOuzWqDxZizdvqQ=;
        b=uziiqshYq4jN9XY2qvC8pi3hAKY95S85EOdTv2rJizbCQliLgcPFAIma44kBu45NSh
         0qtbGJTEuuriJStfaLHjA7+4cmqqngRIAWIhQ4EjmShwZoRPSYRdqOyAbHrNFTklD+Q0
         VcsXLdhcCNDQQyTCbidiRlAFXbt3Er+L3IJK/DuQX/WSCZuMJPMP+i8t+CPRrrABuQb3
         qIR/4haM+pBu4IAuvVKh7vBF9LQDHOfLOdRBHRwv/BHRxdddrRWyzhDbqkmobXtMKDxB
         ecI+M4bPT6dweBPAzgKEj0HLs7jD+AjQim8N5k7l5rO/7a3Z8fKIhqPfEYzng4s1bl/c
         UYkw==
X-Gm-Message-State: AOAM530KkZiQ64+JcjlJ7kIuAkrFmcFr08MCg3aqxGcxyuPEJCLI14+l
        DZWKoAp+6zH+snE77A0Qk4JckoD0UMrvvGnM2lgpKVZsCTUjcMPHDmfjlqDkokbt4Mvx2C/3yLY
        TcajpK2atK8ZNNi6xFwLNl7VHAvAb8Q==
X-Received: by 2002:a17:906:354a:: with SMTP id s10mr48288542eja.475.1634732423843;
        Wed, 20 Oct 2021 05:20:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlAbGB3D1m0sTdbPjRJxUCMmCXB5d+7UNoiPcwqC+By0xn4WMvRb1lfmC3kZiHnFK/bWrYeQ==
X-Received: by 2002:a17:906:354a:: with SMTP id s10mr48288519eja.475.1634732423699;
        Wed, 20 Oct 2021 05:20:23 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id l23sm987340ejn.15.2021.10.20.05.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 05:20:23 -0700 (PDT)
Date:   Wed, 20 Oct 2021 14:20:21 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: libperf: lack of interface
Message-ID: <YXAJhTC9aqOS/GWy@krava>
References: <OSBPR01MB460016842A4310264B1CC5A0F7CD9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <YS+B6PVHtiTmqZS+@kernel.org>
 <YTCOVGyffe+VwL6G@krava>
 <OSBPR01MB4600E7C8C79D64125270D034F7A19@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <OSBPR01MB4600A616AD3341EAF6AA3DE8F7BC9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OSBPR01MB4600A616AD3341EAF6AA3DE8F7BC9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Oct 18, 2021 at 08:57:20AM +0000, nakamura.shun@fujitsu.com wrote:
> Hi
> 
> > > On Wed, Sep 01, 2021 at 10:36:40AM -0300, Arnaldo Carvalho de Melo wrote:
> > > > Em Wed, Sep 01, 2021 at 09:45:10AM +0000, nakamura.shun@fujitsu.com escreveu:
> > > > > Hello.
> > > > >
> > > > > I'm trying to change rdpmc test in perf_event_tests[1] to use libperf, but libperf doesn't have enough interfaces.
> > > > > Does anyone plan to implement any of these libperf features?
> > > > >
> > > > > - Interfaces that can run ioctl (PERF_EVENT_IOC_RESET) from userland
> > > > > - Interfaces that can run fcntl (SIGIO) from userland
> > >
> > > hi,
> > > we could add perf_evsel__fd like below, would it help your usecase?
> > >
> > > if you described your usecases in more details we could
> > > see if we could add/move something to libperf for that
> > >
> > > as Arnaldo said below it could be already in tools/perf/util/*.c
> > > somewhere ;-)
> > 
> > As Peter says, I understood that for rdpmc, no reset is needed.
> > 
> > However, PAPI resets it explicitly, for example, at PAPI_reset.
> > In other, PAPI also has the ability to call PERF_EVENT_IOC_REFLESH on overflow to call a user-registered handler, using SIGIO.
> > 
> > I think it is desirable to be able to achieve similar functionality.
> 
> Does anyone have any comments?

I'll try to add that functionality soon,
I'll cc you on patch

jirka

