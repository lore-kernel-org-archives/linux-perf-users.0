From: David Ahern <dsahern@gmail.com>
Subject: Re: Getting started with perf; a couple of questions
Date: Fri, 07 Jun 2013 18:08:53 -0600
Message-ID: <51B27615.3090504@gmail.com>
References: <CAJLXCZTs4i0P3wA78u25aCt-rfcsBNQ8t0QSsbWazQyoV-XdLA@mail.gmail.com> <51A83824.1090907@gmail.com> <CAJLXCZTzRdLYmcRVTO_AeRawmZ55AtdABcKpu5T5A-Z89iHnbA@mail.gmail.com> <CAJLXCZTN1xLXk79kh5i8WbJBB+4sh0Qs1v+PndhLKSrPPvZ2wQ@mail.gmail.com> <51B09633.2040204@gmail.com> <CAJLXCZSE=LWW8PxTAs4yPAQsmwQjVF=ehGCTKbUWF3rCDF-+7w@mail.gmail.com> <51B1F6C5.3060302@gmail.com> <CAJLXCZTayKKetZPx5mgsFm4wbnHnT__Hosqj-mBGnTXoTaiVjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:37530 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181Ab3FHAI5 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 7 Jun 2013 20:08:57 -0400
Received: by mail-pb0-f51.google.com with SMTP id um15so5268493pbc.10
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Jun 2013 17:08:56 -0700 (PDT)
In-Reply-To: <CAJLXCZTayKKetZPx5mgsFm4wbnHnT__Hosqj-mBGnTXoTaiVjw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andrew Davidoff <davidoff@qedmf.net>
Cc: linux-perf-users@vger.kernel.org

On 6/7/13 5:49 PM, Andrew Davidoff wrote:

> You are correct that the Ubuntu 10.04 host that doesn't seem to be
> recording properly is running a 2.6.32 kernel (2.6.32-47-server from
> Ubuntu). The invocation of perf record is the same as described for
> the CentOS VM (i.e. I am not using -p, and would like to not use -a,
> though -a is the only way I'm getting samples recorded for
> <command-to-trace>).

CentOS 6 has newer perf code than its kernel version suggests -- 
compliments of the RHEL backporting Jiri does.

>
> I had moved to building a newer version of perf than the one that came
> from the Ubuntu 10.04 repo (linux-tools-common) because that one
> appeared ancient based on the output it was generating, and reports
> version as 0.0.2.PERF (though the binary is installed as
> /usr/bin/perf_2.6.32-47). perf record does record data with that
> version, but it looks like (via perf report) that it's data only for
> one event even when multiple are passed, and that event isn't labeled
> in the report, so at a glance I am not sure which it is.

If the original perf command works but newer versions do not then the 
compatibility wheels have fallen off somewhere along the line.

Most likely CentOS 6 works b/c of the backports.

David

>
> Anyway, for now I'm not worrying about getting this working on this
> particular version of Ubuntu, but I appreciate all your help. If I
> decide to dig further I'll start iterating through the versions you
> suggested and see where things get extra broken.
>
> Andy
>
