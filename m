Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80904C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Feb 2022 09:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbiBWJJI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Feb 2022 04:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiBWJJH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Feb 2022 04:09:07 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67587EDA2
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Feb 2022 01:08:40 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id iq13-20020a17090afb4d00b001bc4437df2cso2109444pjb.2
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Feb 2022 01:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pf0D+oLAVO2Ra+UFhGWf1t+ARZ/6RoovWWgaBQapcOs=;
        b=FADrBvb4zjfZ0tGqyKmxLz014eKlGXhx8Off6AbSfzliKZuRtMi5zcLu/dJo5BpPDn
         n+8hYv2MHEnmMZeU2B0nTACMNtZzClRepu3X2zjrACPHOkwSDZuraWkciWqFja8EmOQg
         tZ2P5rw1BoJi5x1AAlCBo9hdmuvk3WBT37WvvXERlODh0wVGZU25kgeSWVCP4BWBR1qY
         TKRSBSBMc66OsYziMfT0yPqBZuprAuuzo+aM9E41rRqRgo7UrlDZh0cf/hR22b8wYs78
         1hvvrvhUTILIHnvZLg/v7QMNcDAFoUNkw3xVHEOFZqK41F++MJbTdi/9LqHN+w13Hxhn
         El6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pf0D+oLAVO2Ra+UFhGWf1t+ARZ/6RoovWWgaBQapcOs=;
        b=FpHEeZJr5t1J+aRRIxCGLYb5lrap1EFyfDNCG/BJU6FaAmp/fgRC8vmy4S0pw67uKv
         oWBW8+OSI8ELgOiIlxKpd/pnE4MCFZZkXMG8rvITdBbVhCKM50zhewu7kzX7virG6o3g
         hep7iRCRNkuD8jVb9amSfsEkNcNHL830ceD3CYFXwcGeqDro5Qv+75G1jz94ZMYsdsD0
         BI+veWPZXtXoS+/nJGag3fSIadu1QN8oVsxzjOOyyLIjiSn6OOg+QNWqwV3lwRbFQfz7
         ZCugxxvOjI/0j0mbtPGga1RdCBLkCLbXWNnKE1Y5NCfWQsq36sq1wkpqjaXVhoSnwKoh
         38aQ==
X-Gm-Message-State: AOAM531TQbPz4W4n2AQmXzZIQO7sH4UKwS3zUtqzmWW/sp0AzDwvKoz4
        8OvhV+uOR+E+hLmf2L061B0hIbqZK8X3O/j+R1U=
X-Google-Smtp-Source: ABdhPJzfsWUfruZ4fm8x9+hWccyoZ3Vg/8Xa4q12llBW5yeBIwaHaI87fl/d6W6wZmAxJ2s7mAwpGwePAhVcKAYgYHo=
X-Received: by 2002:a17:902:ccc1:b0:14f:b686:e6ff with SMTP id
 z1-20020a170902ccc100b0014fb686e6ffmr12847326ple.45.1645607320308; Wed, 23
 Feb 2022 01:08:40 -0800 (PST)
MIME-Version: 1.0
References: <20220221102628.43904-1-tz.stoyanov@gmail.com> <YhPsKeK0UdjiDN1R@krava>
 <C62503E3-B72B-4441-8900-1439CB7CAB04@gmail.com> <CAPpZLN7Qmgsm6ptthvsjgcqgMQd1tnuX=ohHBcPAQ4zu4VVkrw@mail.gmail.com>
 <YhV+BOp0A+aqavlc@kernel.org>
In-Reply-To: <YhV+BOp0A+aqavlc@kernel.org>
From:   Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Date:   Wed, 23 Feb 2022 11:08:24 +0200
Message-ID: <CAPpZLN7rPxjT2zUNe7jFJh_3vY64hYFEkOP7-Kp0POrRSUQhWw@mail.gmail.com>
Subject: Re: [PATCH v2] libperf: Add API for allocating new thread map
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Feb 23, 2022 at 2:21 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Tue, Feb 22, 2022 at 04:32:05AM +0200, Tzvetomir Stoyanov escreveu:
> > On Mon, Feb 21, 2022 at 10:21 PM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > > On February 21, 2022 4:46:49 PM GMT-03:00, Jiri Olsa <olsajiri@gmail.com> wrote:
> > > >On Mon, Feb 21, 2022 at 12:26:28PM +0200, Tzvetomir Stoyanov (VMware) wrote:
> > > >looks good, would you also find useful in your use case the comm support
> > > >in thread_map? the thread_map__read_comms function? we could move it from
> > > >perf to libperf
>
> > > IOW: we're happy that you're working on libperf, so feel encouraged
> > > to move things from tools/perf/util/ to tools/lib/perf/ if you find
> > > a supporting use case, brownie points if you also add an entry to
> > > tools/perf/tests/, AKA 'perf test'.
>
> > Thanks, I see that there is a lot of functionality that could be moved
> > from perf to libperf and which will be useful for the library users.
> > We are going to use libperf in trace-cruncher,
> > https://github.com/vmware/trace-cruncher, as an interface to perf.
>
> Cool, so as you go on adding functionality to trace cruncher and notice
> that something that is in tools/perf/util/ that is usable, please submit
> patches to move things to tools/lib/perf/, adding tests to 'perf test'
> as you go.
>
> Thanks a lot!
>
> - Arnaldo

Sure, I'll do it. I have one more question - do you plan to release
the next version of libperf soon, so we can use this new functionality
in trace-cruncher ?

-- 
Tzvetomir (Ceco) Stoyanov
VMware Open Source Technology Center
