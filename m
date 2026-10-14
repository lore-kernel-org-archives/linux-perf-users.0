Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353DA5616D2;
	Wed, 14 Oct 2026 18:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792001649; cv=none; b=WOYX1siU2KONuY1tGz7B7NyKvj3YfJKGz3/5ZoSKhDjGOec8AI/Lg8Wg+1rxxjzOst0/l/m0ZkKTydkB1uyMg9SqP0aZWUHHC44E6eldGb41q+trjbBTHk6lD5BuKRPk1+vaEUGk+2Kx4Chts/yO9FChAiSx15zwyAgbIWYYc8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792001649; c=relaxed/simple;
	bh=uPFfz3Nn2UoRr2Zhiw23OyGLwsJMWFGmFh+F+Eu4ZzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3mKQd0HtdkCu3LG1BgWkhEw1ZZ2g1fR6dxvOufdB3U/DXFCfgROAUIR1H1FsEBClm8wB2RsLAzBQbgOO9ztAA1uFbsWJs11TqHQFJe5CTay7Vwg2srW8iY9RtFJtvzOQetipmubTH0kgfl0uddvuvTSHDJFlUJdQVDWVAq2hGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOkNvMo+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOkNvMo+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C522E1F000C4;
	Wed, 14 Oct 2026 18:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792001648;
	bh=Sq092hTJqBoiRgYhY31UK7e1HOPV7BJpO25SHpl5CQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dOkNvMo+umxwnFGD9/1pBeKGil0P984p8ZAfmQ+A1D2eoxAjvBe0ookaXzndPQmZ3
	 soEv2XbEdceyy2Rk/WNsjf41V/p9b6D8ikitqXcbiYDiKHfc05bduUFtVMLmPSfUfJ
	 QJry5/px8RgTkuZ38S2AqZ34x9UJReu7LZaW5liy6t617GgjNwwSluuE9IrqajKb75
	 imGEmG3r3amFvRtVzjx8eJhTkcCSQb94VAjrIZQO9u3hrEVehgYM1OzKtw6todiz9f
	 U3pdSPEyG+kaTrOx6iXXGKR1btZLZPLH5n5VDH+gu1dJ9z/u7+1GT/TttZNx6hVU60
	 7XfTGiSxQDEBA==
Date: Wed, 14 Oct 2026 11:14:06 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf stat: Fix aggregation of cgroup events
Message-ID: <as_GbmeRJ3MtwaVD@google.com>
References: <20261002054832.64980-1-namhyung@kernel.org>
 <CAJpZYjXK2qhkCn_ixge_1vEKjXzn_4tzPT=i9NqYg6HbYdWG6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJpZYjXK2qhkCn_ixge_1vEKjXzn_4tzPT=i9NqYg6HbYdWG6Q@mail.gmail.com>

On Fri, Oct 02, 2026 at 10:13:29AM -0700, Chun-Tse Shao wrote:
> On Thu, Oct 1, 2026 at 10:48 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > I got a report that perf stat with BPF and cgroup is broken with
> > aggregation like per-socket or node.  On my machine, running the
> > following command shows the problem.
> >
> >   $ sudo perf stat -a --bpf-counters --per-socket -e cycles \
> >     --for-each-cgroup /user.slice,/system.slice  sleep 1
> >
> >    Performance counter stats for 'system wide':
> >
> >   S0       12      <not counted>      cpu_atom/cycles/                 user.slice
> >   S0       16      <not counted>      cpu_core/cycles/                 user.slice
> >   S0       12      <not counted>      cpu_atom/cycles/                 system.slice
> >   S0       16      <not counted>      cpu_core/cycles/                 system.slice
> >
> >          1.002798147 seconds time elapsed
> >
> > That's because there's a logic to make the whole event failed if result
> > from any CPU looks bad when aggregation is enabled.  Normally it
> > considers bad when an event has no enabled and running time.  But it's
> > possible for a cgroup event to have no chance to run on some CPU during
> > the window and then it will have 0 enabled and running time.  Let's not
> > treat them as errors.
> >
> > After the fix, the same command produces:
> >
> >    Performance counter stats for 'system wide':
> >
> >   S0       12          5,094,112      cpu_atom/cycles/                 user.slice
> >   S0       16         28,075,944      cpu_core/cycles/                 user.slice
> >   S0       12          1,516,568      cpu_atom/cycles/                 system.slice
> >   S0       16          5,569,575      cpu_core/cycles/                 system.slice
> >
> >          1.003231856 seconds time elapsed
> >
> > Reported-by: Chun-Tse Shao <ctshao@google.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Tested-by: Chun-Tse Shao <ctshao@google.com>

Thanks for the test!

Arnaldo, can you please take this?

Thanks,
Namhyung

