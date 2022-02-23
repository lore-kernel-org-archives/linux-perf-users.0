Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D6BC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Feb 2022 18:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243519AbiBWSHQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237596AbiBWSHP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Feb 2022 13:07:15 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944502C10C
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Feb 2022 10:06:45 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id w3so45535046edu.8
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Feb 2022 10:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sRXd9GHht5lpBuguBFVY8yj8cQIYJQklSacyvToWWwg=;
        b=lqZ41KUbzbbaXF7Yk8DR1lGTYeSDIIvTyCFjw1W9pI1ER4LPozzteHqrOcAFb45YM2
         VqCW5lll7xLsiFwtfA4IuG03H5yuZG2KpLzRXYmDCSSMyYHeLa2Zih9LGC34QdolGZUZ
         eGzRpZ92Z39LKh5hZcb4KIYwaEidERiCRaCVNb0RCT3TAE5fO5nFOLMA9hsedFNe5583
         gk7dz0+o85NNRIllpqdC7P2cdcZbzOrYKKPb9LiQVSX9840/3pW45rwRPcMwr996CTWa
         l0aajc8Xqjv6BFVVHuCrkI9g2642zL7yn3CtGfkAcs9dFK4R+cZZk/50r8uC5XDI3y7S
         Znzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sRXd9GHht5lpBuguBFVY8yj8cQIYJQklSacyvToWWwg=;
        b=yFcSlQLzFNOW8Mqp7piJ6zIREt4KzFalC472qHPZIr4T+zYyj59uKRtlMKRI881FTp
         0s336ZQ1D30k+zHtj/SqN5lbdGOG1iiHE1DEGtBXa4x9ZpobHP3SWTvneDFoD9wO9UVV
         zMgAt2K7iyLeAtnbvpAPqoEAihb26F2AxFlCw9l/U7hgkBVTtMgZHIQCjEFkhRdVlGNK
         Mb05L9aXMaayKfs7l4m/qOAmug5q7y2vSdYuoWX8vClU7YbgvUA6esZIhlDP7pq90Zv2
         ygt5lKZQYff6MT1t1Kw0trgCSL14K9dBpXIF3Wz9QU9U6bKpr9JOJ6fTuVBrOxCBpo/+
         RXXg==
X-Gm-Message-State: AOAM532G4BLbqIoogpbwV7KTx87ne5s1XZHDNW95pFRDbEMkuC30MyG2
        c+3RtqE1CHPS4gziWhgLAtk=
X-Google-Smtp-Source: ABdhPJzSCht70uPHN2gIn03atM8lEXotq0GVAMhN9HH3lcvQUcEWFZOQI1t1hpkajcMRAp1GG6ND/g==
X-Received: by 2002:a05:6402:90b:b0:412:a7cc:f5f9 with SMTP id g11-20020a056402090b00b00412a7ccf5f9mr639731edz.136.1645639604081;
        Wed, 23 Feb 2022 10:06:44 -0800 (PST)
Received: from krava (ip-89-102-25-98.net.upcbroadband.cz. [89.102.25.98])
        by smtp.gmail.com with ESMTPSA id j3sm160841ejj.9.2022.02.23.10.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:06:43 -0800 (PST)
Date:   Wed, 23 Feb 2022 19:06:41 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] libperf: Add API for allocating new thread map
Message-ID: <YhZ3sTLuToW3sV4/@krava>
References: <20220221102628.43904-1-tz.stoyanov@gmail.com>
 <YhPsKeK0UdjiDN1R@krava>
 <C62503E3-B72B-4441-8900-1439CB7CAB04@gmail.com>
 <CAPpZLN7Qmgsm6ptthvsjgcqgMQd1tnuX=ohHBcPAQ4zu4VVkrw@mail.gmail.com>
 <YhV+BOp0A+aqavlc@kernel.org>
 <CAPpZLN7rPxjT2zUNe7jFJh_3vY64hYFEkOP7-Kp0POrRSUQhWw@mail.gmail.com>
 <YhYwgJogf9gFjn6w@krava>
 <CAPpZLN7YRE2Ap9zKFzj0CdrFZ5yC8+h89u61uwaLP=rFjjW+ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPpZLN7YRE2Ap9zKFzj0CdrFZ5yC8+h89u61uwaLP=rFjjW+ow@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Feb 23, 2022 at 05:47:09PM +0200, Tzvetomir Stoyanov wrote:
> On Wed, Feb 23, 2022 at 3:03 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Wed, Feb 23, 2022 at 11:08:24AM +0200, Tzvetomir Stoyanov wrote:
> > > On Wed, Feb 23, 2022 at 2:21 AM Arnaldo Carvalho de Melo
> > > <arnaldo.melo@gmail.com> wrote:
> > > >
> > > > Em Tue, Feb 22, 2022 at 04:32:05AM +0200, Tzvetomir Stoyanov escreveu:
> > > > > On Mon, Feb 21, 2022 at 10:21 PM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > > > > > On February 21, 2022 4:46:49 PM GMT-03:00, Jiri Olsa <olsajiri@gmail.com> wrote:
> > > > > > >On Mon, Feb 21, 2022 at 12:26:28PM +0200, Tzvetomir Stoyanov (VMware) wrote:
> > > > > > >looks good, would you also find useful in your use case the comm support
> > > > > > >in thread_map? the thread_map__read_comms function? we could move it from
> > > > > > >perf to libperf
> > > >
> > > > > > IOW: we're happy that you're working on libperf, so feel encouraged
> > > > > > to move things from tools/perf/util/ to tools/lib/perf/ if you find
> > > > > > a supporting use case, brownie points if you also add an entry to
> > > > > > tools/perf/tests/, AKA 'perf test'.
> > > >
> > > > > Thanks, I see that there is a lot of functionality that could be moved
> > > > > from perf to libperf and which will be useful for the library users.
> > > > > We are going to use libperf in trace-cruncher,
> > > > > https://github.com/vmware/trace-cruncher, as an interface to perf.
> > > >
> > > > Cool, so as you go on adding functionality to trace cruncher and notice
> > > > that something that is in tools/perf/util/ that is usable, please submit
> > > > patches to move things to tools/lib/perf/, adding tests to 'perf test'
> > > > as you go.
> > > >
> > > > Thanks a lot!
> > > >
> > > > - Arnaldo
> > >
> > > Sure, I'll do it. I have one more question - do you plan to release
> > > the next version of libperf soon, so we can use this new functionality
> > > in trace-cruncher ?
> >
> > we can discuss that, can be fast ;-)
> >
> > btw I took a look on that and already put some change together,
> > please take a look and feel free to use it
> >
> > I just moved thread_map__read_comms, but I wonder we want it
> > to change to return status if it's in libperf
> >
> > jirka
> >
> 
> Thanks Jiri, I played a little with the patch but it does not fit my
> use case. It resolves only PID to command, but in my case I put
> threads in the map. How do you handle that case in perf ? I use perf
> to collect samplings from a given PID, and put all threads of this
> process in the map, all entries from /proc/PID/task/ folder. In my
> logic, as I know the PID, the commands are resolved using
> /proc/PID/task/TID/comm files.
> The other problem that I see is - there should be a way to dynamically
> resize and add new entries in the thread map. There are cases when new
> threads are spawned during the trace - these should be added in the
> thread map. In my code, I handle the PERF_RECORD_COMM event - resize
> my array and add the new entry. That can be implemented in libperf
> also, I think it will be very useful.

there's perf_thread_map__realloc, but it's not exported

> Anyway, the patch is useful for PID to command resolving, if there are
> only PIDs in the map. It could be extended with additional APIs for
> TID to command resolving. Maybe we can have these APIs:
>    void perf_thread_map__read_pid_comms(struct perf_thread_map *threads);
>    void perf_thread_map__read_tid_comms(pid_t pid, struct
> perf_thread_map *threads);

so thread_map__read_comms just resolves everything that's in the map,
so if you have thread ids in there, they should get resolved

if you expected some other functionality, like unwind pid to threads,
the thread_map__new_by_pid_str function does that

jirka
