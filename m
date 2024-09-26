Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02DF1509BF;
	Thu, 26 Sep 2024 18:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727374626; cv=none; b=E/q58FQNXH1Bx0q/BEQv4cAE3fmECyOd194O4Zzs6ZrDkpADYyBgGOGLFusNHSiQ//OILzR0um+zZmpG5LzEI4Fl4CNkmm4fD27mnhgIN3ZaStMwcvumhqEr9fnp9GJZKkMpM1IuZbK9hi99T3M+fHVRjKTlqwpnIhWzi0CLzKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727374626; c=relaxed/simple;
	bh=NU2+rK707/kcqgD+KdA3BaXIaor/rn6ouUQxk9HYMA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCCBBcPPybjT9yw2uvyGwkuXsSCbS5ht1u6HNnV+eHKlSfBooSPM6iBDduBR02gODjuLr/nQFZjXl9Sks2LoJu1h+LL4R1moAIYAl3Zswn6FbuvxY9B6ar6bBpL7SjOPfcBxCJR3Yc26jig28whRCoYJ9kPlduyURrhIwwMboaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHc3JvzJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHc3JvzJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0407C4CEC5;
	Thu, 26 Sep 2024 18:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727374626;
	bh=NU2+rK707/kcqgD+KdA3BaXIaor/rn6ouUQxk9HYMA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tHc3JvzJ7aw9FFF0Y0k/UXPoOhvXzrKLV124wnZ4Bo9MmrWFCb/vHIFmbJ5Ml+KiO
	 3I9ilEEQm8evfDq9i9ASjWI87Yj8TdZTB6cE0KbhsM1xkA81GOcPQkf8ywS29agLvf
	 A2B37aOrSSKOFim3tn4PI9LLweAEghwWEkPfbfaYQscpZ5bdd7hF1quwTMxAyMxv90
	 MfYEndweJbzuw+dw8jPd03iwolsEQQnODUMhLovozV3qWrIPdXA5eyV0MuIFZx8v7w
	 bQoCpF1c46KCznmi6NxSFBuwtxfQVskYSoSk4sTpuFwk2FziG/VLw/K60WKthboSB+
	 wT3Yl1d0jKdyA==
Date: Thu, 26 Sep 2024 11:17:04 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf test: Ignore security failures in all PMU test
Message-ID: <ZvWlICnVELB0WEto@google.com>
References: <20240925173013.12789-1-irogers@google.com>
 <ZvTojjciV9pFbGJi@google.com>
 <CAP-5=fXJ-Nd-8EUPD+JXy=chZX_7nFYMxRR5L_ovn83+Tt1f_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXJ-Nd-8EUPD+JXy=chZX_7nFYMxRR5L_ovn83+Tt1f_g@mail.gmail.com>

On Thu, Sep 26, 2024 at 08:24:30AM -0700, Ian Rogers wrote:
> On Wed, Sep 25, 2024 at 9:52 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, Sep 25, 2024 at 10:30:13AM -0700, Ian Rogers wrote:
> > > Refactor code to have some more error diagnosis on traps, etc. and to
> > > do less work on each line. Add an ignore situation for security failures.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/tests/shell/stat_all_pmu.sh | 52 ++++++++++++++++++++------
> > >  1 file changed, 40 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
> > > index d2a3506e0d19..42456d89c5da 100755
> > > --- a/tools/perf/tests/shell/stat_all_pmu.sh
> > > +++ b/tools/perf/tests/shell/stat_all_pmu.sh
> > > @@ -1,23 +1,51 @@
> > > -#!/bin/sh
> > > +#!/bin/bash
> > >  # perf all PMU test
> > >  # SPDX-License-Identifier: GPL-2.0
> > >
> > >  set -e
> > > +err=0
> > > +result=""
> > > +
> > > +trap_cleanup() {
> > > +  echo "Unexpected signal in ${FUNCNAME[1]}"
> > > +  echo "$result"
> > > +  exit 1
> > > +}
> > > +trap trap_cleanup EXIT TERM INT
> > >
> > >  # Test all PMU events; however exclude parameterized ones (name contains '?')
> > > -for p in $(perf list --raw-dump pmu | sed 's/[[:graph:]]\+?[[:graph:]]\+[[:space:]]//g'); do
> > > +for p in $(perf list --raw-dump pmu | sed 's/[[:graph:]]\+?[[:graph:]]\+[[:space:]]//g')
> > > +do
> > >    echo "Testing $p"
> > >    result=$(perf stat -e "$p" true 2>&1)
> > > -  if ! echo "$result" | grep -q "$p" && ! echo "$result" | grep -q "<not supported>" ; then
> > > -    # We failed to see the event and it is supported. Possibly the workload was
> > > -    # too small so retry with something longer.
> > > -    result=$(perf stat -e "$p" perf bench internals synthesize 2>&1)
> > > -    if ! echo "$result" | grep -q "$p" ; then
> > > -      echo "Event '$p' not printed in:"
> > > -      echo "$result"
> > > -      exit 1
> > > -    fi
> > > +  if echo "$result" | grep -q "$p"
> > > +  then
> > > +    # Event seen in output.
> > > +    continue
> > > +  fi
> > > +  if echo "$result" | grep -q "<not supported>"
> > > +  then
> > > +    # Event not supported, so ignore.
> > > +    continue
> >
> > I'm curious about this case.  It'll show up even if it's not supported
> > right?  Then the first condition would match and it doesn't reach here.
> >
> >   $ perf stat -e LLC-loads true
> >
> >    Performance counter stats for 'true':
> >
> >      <not supported>      LLC-loads
> >
> >          0.001213558 seconds time elapsed
> >
> >          0.001373000 seconds user
> >          0.000000000 seconds sys
> 
> We carry this change at Google for an issue on older series kernels. I
> was resending the patch as a courtesy in the migration of development
> work to:
> https://github.com/googleprodkernel/linux-perf
> I'm okay with this being a Google only change.

I'm not sure if it's a kernel issue.  IIUC you want to run perf stat
again if some events are not counted, right?

I understand your patch just converted the existing logic and added the
check for security related failures.  So I'll pick it up for now but we
may want to revisit this later.

Thanks,
Namhyung

