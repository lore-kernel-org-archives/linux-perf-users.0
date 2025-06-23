Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3978229B16;
	Mon, 23 Jun 2025 23:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750720493; cv=none; b=Ershm5Gcu7xCMasEEgi5NNVSoxtfCqC0Y9eCb+CvCtnLcnXE8zbAIISeV9z47NnSBywifNWHNqaMERh5+ufGVNM08Zc5HWgOvydJE5SL81rdhc1G7lWRVOw4PbCEb6sFlYI/HA9D4EpVcVppJNBtG71ctjiLB5lxQGRfXobVILU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750720493; c=relaxed/simple;
	bh=Kt2V+qTuGXKKjBuq+DdUZkjI2zHCDhZcpWDC4ujWhRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tz9zCf7YNKwB3QaIWMNLon43agFunINgK2H3gwvKLQXBqpie4m613kLtOiQQL4F0TFEUZeEzn1Ty+Gqzn0pL2UxpXS44jeXxiXwQ6+izfyOIhF1uvZLFUsx3ozHeTfwtVJofEZtB7eCVsvhrZ+/Vtte3oUIkIl5srTXDUoIF/I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BK9+eemP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BK9+eemP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBFCC4CEEA;
	Mon, 23 Jun 2025 23:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750720493;
	bh=Kt2V+qTuGXKKjBuq+DdUZkjI2zHCDhZcpWDC4ujWhRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BK9+eemPQp5Fg83e0UXtHwXHJ3UD8k3U2TcDB0EKCjXNqRyc7GrpOfXvk8JPii1WG
	 8c1yNmo3LBJaBLCzjeAMs3SrQtM4zlIEcWMZVeESBUJyArOxtqNO06MEx535S5L7/i
	 SqFhsNayXyHXElCNEiTyMm3biyn0zaopvmKbhJ4r56V0Gm8wl5P7jp4lLTbAmIgQnZ
	 kcMOJ9EKpBkM1cCw3Q2ZS7aFrv81Move1siHh+S1AVLrRKf+ZISIiEU/MYlKw5R3Dl
	 cozdIaL/8mb5HQHGNIBQNPrJCzaRbUajIyOstiNkkkc/1ayyKXLQmX+L+oVvKT6Usa
	 XZ2/f8cnsNRkA==
Date: Mon, 23 Jun 2025 16:14:51 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf test workload noploop: Name the noploop
 process
Message-ID: <aFnf69Q4V95K3rpS@google.com>
References: <20250619002034.97007-1-irogers@google.com>
 <aFW4VJtk96JD865U@google.com>
 <CAP-5=fUpnW1DE68pMW0q3vMT+n6d5SeNkwXd45XLaf01-eP47A@mail.gmail.com>
 <aFmSuSyZ1ZNT94Tq@x1>
 <CAP-5=fXms87LVH-Y5V3OpVbwUjY=hWAe0NTX4uKQf1q3Ax-WSA@mail.gmail.com>
 <aFmZl-SUT85Im8BJ@google.com>
 <aFmooVYz-6p1DTSv@x1>
 <CAP-5=fVGPKOVc7WA=VygSE3BKN90tSpLPhkaupX_fUboBcyHPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVGPKOVc7WA=VygSE3BKN90tSpLPhkaupX_fUboBcyHPg@mail.gmail.com>

On Mon, Jun 23, 2025 at 12:41:09PM -0700, Ian Rogers wrote:
> On Mon, Jun 23, 2025 at 12:19 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Mon, Jun 23, 2025 at 11:14:47AM -0700, Namhyung Kim wrote:
> > > On Mon, Jun 23, 2025 at 11:05:41AM -0700, Ian Rogers wrote:
> > > > On Mon, Jun 23, 2025 at 10:45 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > > On Mon, Jun 23, 2025 at 08:12:47AM -0700, Ian Rogers wrote:
> > > > > > On Fri, Jun 20, 2025 at 12:36 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > > I'm afraid it'd introduce a build failure on musl.  Please see
> >
> > > > > > > https://lore.kernel.org/linux-perf-users/20250611092542.F4ooE2FL@linutronix.de/
> >
> > > > > > > I think <sys/prctl.h> would be enough.
> >
> > > > > > we could do that but in the glibc man page it says:
> > > > > > https://man7.org/linux/man-pages/man2/prctl.2.html
> > > > > > ```
> > > > > > #include <linux/prctl.h>  /* Definition of PR_* constants */
> > > > > > #include <sys/prctl.h>
> > > > > > ```
> >
> > > > > > It'd be nice to think musl was slowly getting fixed. I notice we're
> >
> > > > > Sebastian reported on the musl libc, its maintainer replied:
> >
> > > > > https://www.openwall.com/lists/musl/2025/06/12/11
> >
> > > > Ugh. I'm not sure how we're expected to resolve this and have glibc
> > > > and musl be happy without basically not trusting libc.
> >
> > > Maybe pthread_setname_np()?  It seems musl also implemented it.
> >
> > ⬢ [acme@toolbx perf-tools-next]$ git diff
> > diff --git a/tools/perf/tests/workloads/noploop.c b/tools/perf/tests/workloads/noploop.c
> > index 8b954d4660833a2f..656e472e618822a3 100644
> > --- a/tools/perf/tests/workloads/noploop.c
> > +++ b/tools/perf/tests/workloads/noploop.c
> > @@ -1,9 +1,8 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> > +#include <pthread.h>
> >  #include <stdlib.h>
> >  #include <signal.h>
> >  #include <unistd.h>
> > -#include <linux/prctl.h>
> > -#include <sys/prctl.h>
> >  #include <linux/compiler.h>
> >  #include "../tests.h"
> >
> > @@ -18,7 +17,7 @@ static int noploop(int argc, const char **argv)
> >  {
> >         int sec = 1;
> >
> > -       prctl(PR_SET_NAME, "perf-noploop");
> > +       pthread_setname_np(pthread_self(), "perf-noploop");
> >         if (argc > 0)
> >                 sec = atoi(argv[0]);
> >
> > ⬢ [acme@toolbx perf-tools-next]$
> >
> > ⬢ [acme@toolbx perf-tools-next]$ perf test -w noploop &
> > [1] 1179763
> > ⬢ [acme@toolbx perf-tools-next]$ ps
> >     PID TTY          TIME CMD
> >    3935 pts/1    00:00:00 bash
> >    4053 pts/1    00:00:00 toolbox
> >    4222 pts/1    00:00:28 podman
> >  971900 pts/1    00:00:00 bash
> > 1100453 pts/1    00:00:00 tail
> > 1160346 pts/1    00:00:00 bash
> > 1179763 pts/1    00:00:00 perf-noploop
> > 1179765 pts/1    00:00:00 ps
> > ⬢ [acme@toolbx perf-tools-next]$
> >
> > And then on one of the Alpine Linux containers:
> >
> > make: Leaving directory '/tmp/perf-6.16.0-rc3/tools/perf'
> > /tmp/perf-6.16.0-rc3 $ cat /etc/os-release
> > NAME="Alpine Linux"
> > ID=alpine
> > VERSION_ID=3.18.12
> > PRETTY_NAME="Alpine Linux v3.18"
> > HOME_URL="https://alpinelinux.org/"
> > BUG_REPORT_URL="https://gitlab.alpinelinux.org/alpine/aports/-/issues"
> > /tmp/perf-6.16.0-rc3 $ tools/perf/perf test -w noploop &
> > /tmp/perf-6.16.0-rc3 $ ps
> > PID   USER     TIME  COMMAND
> >     1 toolsbui  0:00 /bin/sh
> >  5693 toolsbui  0:00 {perf-noploop} tools/perf/perf test -w noploop
> >  5694 toolsbui  0:00 ps
> > /tmp/perf-6.16.0-rc3 $
> > [1]+  Done                       tools/perf/perf test -w noploop
> > /tmp/perf-6.16.0-rc3
> >
> > There are more direct use of prctl() to set the name in tools/perf/,
> > using pthread_setname_np() seems cleaner :-)
> 
> Yeah, I wanted to set the program name rather than a thread name for
> the sake of seeing the process name in ps - hence reaching for prctl.
> PR_SET_NAME is documented as setting the thread name and so no
> difference to pthread_setname_np. It's still frustrating to get bogged
> down in working around musl when typing the literal code from the
> prctl man page. Do you need me to re-send the patch?

Yes please.  And address comments in the patch 2 as well.

Thanks,
Namhyung

