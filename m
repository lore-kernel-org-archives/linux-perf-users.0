Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90433C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Feb 2022 00:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbiBWAV5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Feb 2022 19:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiBWAV4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Feb 2022 19:21:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E374D637
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Feb 2022 16:21:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25A80B81D8D
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Feb 2022 00:21:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5C2C340E8;
        Wed, 23 Feb 2022 00:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645575686;
        bh=lYQv6ByWFDKzFRGzXEouLS4OxAkHn697AkI0PNv1pxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kkOK0DTWab+736rBk4CvrGmQBCWSquKXUGVuokNqEVO8XHVagq7KeXhqXbf1QxAS9
         yniw+njUV4A3FsERxsYAdeucnuSF/+eWUdA4ky+S2Xigi+C1Rek8tGgcvHCujC5CDA
         3y0XdFIUo/QKSJ64jx7nVMXi0DrKfkz+V0Cb+9kQkqBKxbv1zlsEBHCYb3EbYOI1Az
         AuVVKQ90U69wLPht2jrMbF0FTWEWVDUBcZ5PawKTgSzld3OBwmZ7OvR46A5UXe4aL+
         ZR/x3EujRh/OMFr3KzAoizrzMJCQPt+nTz7x+e2aYoErp3EYh8bkt5Fz8AoE+1lKaI
         o015kJAoFbFnQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 59B32400FE; Tue, 22 Feb 2022 21:21:24 -0300 (-03)
Date:   Tue, 22 Feb 2022 21:21:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] libperf: Add API for allocating new thread map
Message-ID: <YhV+BOp0A+aqavlc@kernel.org>
References: <20220221102628.43904-1-tz.stoyanov@gmail.com>
 <YhPsKeK0UdjiDN1R@krava>
 <C62503E3-B72B-4441-8900-1439CB7CAB04@gmail.com>
 <CAPpZLN7Qmgsm6ptthvsjgcqgMQd1tnuX=ohHBcPAQ4zu4VVkrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPpZLN7Qmgsm6ptthvsjgcqgMQd1tnuX=ohHBcPAQ4zu4VVkrw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Feb 22, 2022 at 04:32:05AM +0200, Tzvetomir Stoyanov escreveu:
> On Mon, Feb 21, 2022 at 10:21 PM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > On February 21, 2022 4:46:49 PM GMT-03:00, Jiri Olsa <olsajiri@gmail.com> wrote:
> > >On Mon, Feb 21, 2022 at 12:26:28PM +0200, Tzvetomir Stoyanov (VMware) wrote:
> > >looks good, would you also find useful in your use case the comm support
> > >in thread_map? the thread_map__read_comms function? we could move it from
> > >perf to libperf

> > IOW: we're happy that you're working on libperf, so feel encouraged
> > to move things from tools/perf/util/ to tools/lib/perf/ if you find
> > a supporting use case, brownie points if you also add an entry to
> > tools/perf/tests/, AKA 'perf test'.

> Thanks, I see that there is a lot of functionality that could be moved
> from perf to libperf and which will be useful for the library users.
> We are going to use libperf in trace-cruncher,
> https://github.com/vmware/trace-cruncher, as an interface to perf.

Cool, so as you go on adding functionality to trace cruncher and notice
that something that is in tools/perf/util/ that is usable, please submit
patches to move things to tools/lib/perf/, adding tests to 'perf test'
as you go.

Thanks a lot!

- Arnaldo
