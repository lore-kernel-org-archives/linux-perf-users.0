Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDC1846F;
	Fri, 13 Dec 2024 02:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734055699; cv=none; b=eGV0zl9pu9MNoIlEyRRZWreEtj6KmLfWZ0LEmV1pNXGeQblG0w2acZrmQVz9pV1Y3g1VeTUL2fCcDGvILM3hApLenckn6Yic+Yfth4Pf5Bju90KYPONrixXowY3j7pfESK5EISso5MeuZFs8oc1sc5g+qMEIVl7UuTBPruDKh0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734055699; c=relaxed/simple;
	bh=tm5RF1spERBhNh027vl264Wk2gO7rUaUP/g9RZDDAXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGPTBNJu/uHKSiQRnZt+2qKzsbBRmG+HYMZiawaXVaTVdUyEenTSpb5V2fKx7STk0icO0lrqrVVxQzhtPocg9QmC1X2HlmkDZ7JWunbBmdJrsofagw5oPxjoka3xC67wUXPFYRaFZLIC9aUZAQAvP64ACbGYSyJdE2OcAbLvUnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iT0brg8b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iT0brg8b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BF4C4CECE;
	Fri, 13 Dec 2024 02:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734055696;
	bh=tm5RF1spERBhNh027vl264Wk2gO7rUaUP/g9RZDDAXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iT0brg8b062XiSgLTzCnkQXbfUXFsFggloyJ1Dsqn+tPzzdEBSLP3blO9on5hm5vd
	 Qu3OsoFFVPk1MACpeQ49v6/Im3AShTZm7Jf3M8HsX91d4CUgWxWx/U43JFsYZibRgs
	 Mvts1wBEIoLE0wRZay/W9qvDCr5xllIETIV5YDL1Zs93iVUiBikPHhNfk7kpfvX0by
	 hDis6rc3KOof54Adc6KdptBKo40EIlMcCI7MSC0IDFymVLi5W+VABCBm2qbOlNsX8r
	 ySIOoVtiOurSrZduxgAC/VOALPnGrNffGAKuAjgxXGRYQf0dn3+TrD2XzrtMNlCygG
	 ujBbJN9Se1PpQ==
Date: Thu, 12 Dec 2024 18:08:15 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Howard Chu <howardchu95@gmail.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [RFC/PATCH] perf trace: Add --syscall-period option
Message-ID: <Z1uXDxdIE4g6BaZB@google.com>
References: <20241211222110.2430610-1-namhyung@kernel.org>
 <Z1oXs1xjCG1Ee27p@x1>
 <CAP-5=fXYke_n7TDe+mB-webNH7vCvea7ZVPqfqygw7bTNd8G3g@mail.gmail.com>
 <CAH0uvogs8EAzLemVQXq238KGFXJhD2TBhpXHQUnRYaQtcn_HPQ@mail.gmail.com>
 <CAP-5=fXTSZtcrc3hgYHQAHyZVsJ6eLQ_RMzQgVrKFhjvdcwSqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXTSZtcrc3hgYHQAHyZVsJ6eLQ_RMzQgVrKFhjvdcwSqw@mail.gmail.com>

On Wed, Dec 11, 2024 at 08:28:33PM -0800, Ian Rogers wrote:
> On Wed, Dec 11, 2024 at 5:47 PM Howard Chu <howardchu95@gmail.com> wrote:
> >
> > Hello Ian,
> >
> > On Wed, Dec 11, 2024 at 5:34 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Wed, Dec 11, 2024 at 2:52 PM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > On Wed, Dec 11, 2024 at 02:21:10PM -0800, Namhyung Kim wrote:
> > > > > This option is to implement the event sampling for system calls.
> > > > > The period is given in msec as it shows the time in msec.
> > > > >
> > > > >   # perf trace -C 0 --syscall-period 100 sleep 1
> > > > >            ? (         ): fleetspeakd/1828559  ... [continued]: futex())                                            = -1 ETIMEDOUT (Connection timed out)
> > > > >        0.050 (100.247 ms): gnome-shell/572531 recvmsg(fd: 10<socket:[3355761]>, msg: 0x7ffef8b39d20)                = 40
> > > > >      100.357 (100.149 ms): pipewire-pulse/572245 read(fd: 5<anon_inode:[eventfd]>, buf: 0x7ffc0b9dc8f0, count: 8)      = 8
> > > > >      200.553 (100.268 ms): NetworkManager/3424 epoll_wait(epfd: 19<anon_inode:[eventpoll]>, events: 0x5607b85bb880, maxevents: 6) = 0
> > > > >      300.876 (         ): mon/4932 poll(ufds: 0x7fa392784df0, nfds: 1, timeout_msecs: 100)            ...
> > > > >      400.901 ( 0.025 ms): TaskCon~ller #/620145 futex(uaddr: 0x7f3fc596fa00, op: WAKE|PRIVATE_FLAG, val: 1)           = 0
> > > > >      300.876 (100.123 ms): mon/4932  ... [continued]: poll())                                             = 0 (Timeout)
> > > > >      500.901 ( 0.012 ms): evdefer/2/2335122 futex(uaddr: 0x5640baac5198, op: WAKE|PRIVATE_FLAG, val: 1)           = 0
> > > > >      602.701 ( 0.017 ms): Compositor/1992200 futex(uaddr: 0x7f1a51dfdd40, op: WAKE|PRIVATE_FLAG, val: 1)           = 0
> > > > >      705.589 ( 0.017 ms): JS Watchdog/947933 futex(uaddr: 0x7f4cac1d4240, op: WAKE|PRIVATE_FLAG, val: 1)           = 0
> > > > >      812.667 ( 0.027 ms): fix/1985151 futex(uaddr: 0xc0008f7148, op: WAKE|PRIVATE_FLAG, val: 1)             = 1
> > > > >      912.807 ( 0.017 ms): Xorg/572315 setitimer(value: 0x7ffc375d6ba0)                                      = 0
> > > > >
> > > > > The timestamp is kept in a per-cpu array and the allowed task is saved
> > > > > in a hash map.
> > > >
> > > > Interesting concept, and one that is done just on the BPF part, so I
> > > > think we should at least warn a user that is running this on a build
> > > > without BPF skels.
> > > >
> > > > Will try it tomorrow,
> > > >
> > > > - Arnaldo
> > > >
> > > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > > ---
> > > > >  tools/perf/Documentation/perf-trace.txt       |  6 ++
> > > > >  tools/perf/builtin-trace.c                    |  5 ++
> > > > >  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 67 ++++++++++++++++++-
> > > > >  3 files changed, 76 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
> > > > > index 6e0cc50bbc13fc7f..9f338a8c5357a67e 100644
> > > > > --- a/tools/perf/Documentation/perf-trace.txt
> > > > > +++ b/tools/perf/Documentation/perf-trace.txt
> > > > > @@ -241,6 +241,12 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
> > > > >       printing using the existing 'perf trace' syscall arg beautifiers to map integer
> > > > >       arguments to strings (pid to comm, syscall id to syscall name, etc).
> > > > >
> > > > > +--syscall-period::
> > > > > +     Trace a system call in the given period (in msec).  This implements
> > > > > +     sampling for syscalls in order to reduce the monitoring overhead.
> > > > > +     For example, setting the sysall period to 100 (msec) means it will
> > > > > +     sample a syscall and next one after 100 msec.
> > >
> > > Is this similar to the -D/--delay option to perf-record? Perhaps share the name?
> >
> > I think this is more like a throttling for the perf trace output,
> > instead of a one-time delay or a range of enabled time like -D, as the
> > prev_ts here is continuously updated. This restricts the maximum
> > sampling frequency to 1 / syscall-period, meaning every syscall is
> > sampled just after the syscall-period has passed.
> 
> Thanks Howard, so it is some kind of "throttle" or "max-per" value.
> I'd suggest rephrasing the text.

How about this?

--syscall-sample=<period>::
	Enable sampling of system calls with a given period in msec.
	The sampling frequency would be 1 / period, in other words,
	it will trace a system call only after the given period of
	time is passed.  The sampling period is tracked per CPU.

Thanks,
Namhyung

