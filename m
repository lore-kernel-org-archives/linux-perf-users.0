From: Andrew Davidoff <davidoff@qedmf.net>
Subject: Re: Getting started with perf; a couple of questions
Date: Fri, 7 Jun 2013 17:49:48 -0600
Message-ID: <CAJLXCZTayKKetZPx5mgsFm4wbnHnT__Hosqj-mBGnTXoTaiVjw@mail.gmail.com>
References: <CAJLXCZTs4i0P3wA78u25aCt-rfcsBNQ8t0QSsbWazQyoV-XdLA@mail.gmail.com>
	<51A83824.1090907@gmail.com>
	<CAJLXCZTzRdLYmcRVTO_AeRawmZ55AtdABcKpu5T5A-Z89iHnbA@mail.gmail.com>
	<CAJLXCZTN1xLXk79kh5i8WbJBB+4sh0Qs1v+PndhLKSrPPvZ2wQ@mail.gmail.com>
	<51B09633.2040204@gmail.com>
	<CAJLXCZSE=LWW8PxTAs4yPAQsmwQjVF=ehGCTKbUWF3rCDF-+7w@mail.gmail.com>
	<51B1F6C5.3060302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:65224 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757213Ab3FGXts (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 7 Jun 2013 19:49:48 -0400
Received: by mail-ie0-f181.google.com with SMTP id x14so11671451ief.26
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Jun 2013 16:49:48 -0700 (PDT)
In-Reply-To: <51B1F6C5.3060302@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Fri, Jun 7, 2013 at 9:05 AM, David Ahern <dsahern@gmail.com> wrote:
>
> So perf record -v does not show the fallback? The default event has been
> 'cycles' from the beginning I believe. Only if cycles is not supported does
> it fallback to cpu-clock. You should not have to add '-e cycles'. Well, at
> least that is the way it is for the code in Linus' tree.

The perf record invocation I am using in the CentOS 6.4 VM is in the
form of `perf record -v -e event0,...eventN <command-to-trace>`, and
perf is built from 3.9.4 sources from kernel.org, and the running
kernel is built from the same sources. In this environment If I pass
events to -e without including cycles, I do not get the message about
falling back to cpu-clock. If I do include cycles in the event list,
or do not provide an event list at all, I do get the message about
falling back to cpu-clock.

Thank you for the clarification regarding -c and -F / sampling rate/period.

> What command lines are you running? I seem to recall this is a 2.6.32 kernel
> and basic perf record commands should work fine -- perf record -a or perf
> record -p <pid>. Perhaps something snuck in recently that broke compat with
> 2.6.32. You can determine that by running the perf command that comes with
> that version of Ubuntu and then newer ones -- 3.0, 3.4, 3.8 would be a good
> distribution of versions to start with if you want to get to the bottom of
> it.

You are correct that the Ubuntu 10.04 host that doesn't seem to be
recording properly is running a 2.6.32 kernel (2.6.32-47-server from
Ubuntu). The invocation of perf record is the same as described for
the CentOS VM (i.e. I am not using -p, and would like to not use -a,
though -a is the only way I'm getting samples recorded for
<command-to-trace>).

I had moved to building a newer version of perf than the one that came
from the Ubuntu 10.04 repo (linux-tools-common) because that one
appeared ancient based on the output it was generating, and reports
version as 0.0.2.PERF (though the binary is installed as
/usr/bin/perf_2.6.32-47). perf record does record data with that
version, but it looks like (via perf report) that it's data only for
one event even when multiple are passed, and that event isn't labeled
in the report, so at a glance I am not sure which it is.

Anyway, for now I'm not worrying about getting this working on this
particular version of Ubuntu, but I appreciate all your help. If I
decide to dig further I'll start iterating through the versions you
suggested and see where things get extra broken.

Andy
