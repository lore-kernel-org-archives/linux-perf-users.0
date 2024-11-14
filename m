Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0851AB6F1;
	Thu, 14 Nov 2024 21:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731618218; cv=none; b=M+9dLX7FZPAGAkrRT63fpGWeCoC3nqOJnS7VtuoCWkgdu036EkYxdj98ve6ICmlv8nAgC0pb/ij/t4eqZG60wk0x1PAoCIkrUm6nclsYX/YuckZdfsLJqf/tCTr754XjWC/SCmGhpYtPHGx3vKWbUnWB56NT/m2j3mcfHPbfYEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731618218; c=relaxed/simple;
	bh=h6Ab78gAB0LmRRiWpEtwGJHwFKOOZ3XIieV5FxUsQIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDyyMOyyB3GPnRPk8iEGEKsak7tsRqVWCHjOjXYGHj05DJNH9Q49QEWom1gLjPZIeDJ4JfSzhj3p/W0aFEUHh/4MsH6/yTLmgih04pEgnPCHHO/xL5eObsSkT5ex+OUa1PH2rkmpfamOBfrMdFoAmDsbMJ5TrpgbOO05v96RFBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVLV72CZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVLV72CZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79295C4CECD;
	Thu, 14 Nov 2024 21:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731618217;
	bh=h6Ab78gAB0LmRRiWpEtwGJHwFKOOZ3XIieV5FxUsQIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nVLV72CZYwZL5SSZBYfmQyD786QqOXvqALMVWo4kAljMWo4bGP9L9mt1qWlnVayYu
	 XFyZmASnhW/XdZOdmomDuDvhjHuenPI6S6byKLiEvA7vAErR/B6fakZec17c7gSMjm
	 94PZkIwMwmSnOO0QVLMtC1RLzZwgYBfviei9qtlCF9N6EbB/K7nIXRDTNF5sKcT3OV
	 OQKOMzIQ/fU06XHqMVY20O8nR5FANrGe3p7VJigvd0Rl6eXrwF/9yMXrtWyUIHR5U/
	 SHaUJQLOM4S81PEdHfIIt1/gDIP4jFNPVqlMzCYlxHB/lW6A8uI8Plz2Y4m0E1J3Oe
	 Gmbe36EA7gvew==
Date: Thu, 14 Nov 2024 18:03:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Benjamin Peterson <benjamin@engflow.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 2/2] perf tests: add test for trace output loss
Message-ID: <ZzZlpwTy_nXKE8LF@x1>
References: <20241106234518.115234-1-benjamin@engflow.com>
 <20241106234518.115234-2-benjamin@engflow.com>
 <ZzY1bPtoyRH-nRIV@x1>
 <ZzY20vZluj44w1Gt@x1>
 <CAEmfU+v8KR3Bd8w7kOX6ScGig106zh5gW9P5fwAw-BF3tmAp7A@mail.gmail.com>
 <ZzZY7U0AFk3245vy@x1>
 <CAH0uvojcZMVzDyNkWCSHMdwn59T2fgn6iGoqrh9NhaaQ5H2DOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvojcZMVzDyNkWCSHMdwn59T2fgn6iGoqrh9NhaaQ5H2DOw@mail.gmail.com>

On Thu, Nov 14, 2024 at 12:16:46PM -0800, Howard Chu wrote:
> Hello,
> 
> On Thu, Nov 14, 2024 at 12:09 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Thu, Nov 14, 2024 at 09:44:56AM -0800, Benjamin Peterson wrote:
> > > > On Thu, Nov 14, 2024 at 02:37:52PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > diff --git a/tools/perf/tests/shell/trace_exit_race.sh b/tools/perf/tests/shell/trace_exit_race.sh
> > > > index 8b70324bc5b4fb4c..c37ed6bb9f7e8fab 100755
> > > > --- a/tools/perf/tests/shell/trace_exit_race.sh
> > > > +++ b/tools/perf/tests/shell/trace_exit_race.sh
> > > > @@ -12,10 +12,10 @@
> > > >  skip_if_no_perf_trace || exit 2
> >
> > > >  trace_shutdown_race() {
> > > > -       for i in $(seq 100); do
> > > > +       for _ in $(seq 100); do
> > > >                 perf trace -e syscalls:sys_enter_exit_group true 2>>$file
> > > >         done
> > > > -       [ $(grep -c -E " +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\)$" $file) = "100" ]
> > > > +       [ "$(grep -c -E ' +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\)$' $file)" = "100" ]
> > > >  }
> >
> > > This all looks okay.
> >
> > The test is failing for me as there is garbage in the output of perf
> > trace even with Namhyung having already applied your previous patch:
> >
> > ⬢ [acme@toolbox perf-tools-next]$ git log --oneline --author benjamin@engflow.com
> > 12bd434f68ea45c7 (HEAD -> perf-tools-next) perf tests: Add test for 'perf trace' output loss
> > efbcd2cd7eac10a9 perf trace: Do not lose last events in a race
> > 5fb8e56542a3cf46 (perf-tools-next/tmp.perf-tools-next) perf trace: avoid garbage when not printing a trace event's arguments
> > ⬢ [acme@toolbox perf-tools-next]$
> >
> > root@number:~# perf trace -e syscalls:sys_enter_exit_group true
> >      0.000 true/1982428 syscalls:sys_enter_exit_group( k?m)
> > root@number:~# perf trace -e syscalls:sys_enter_exit_group true
> >      0.000 true/1982430 syscalls:sys_enter_exit_group()
> > root@number:~# perf trace -e syscalls:sys_enter_exit_group true
> >      0.000 true/1982432 syscalls:sys_enter_exit_group()
> > root@number:~# perf trace -e syscalls:sys_enter_exit_group true
> >      0.000 true/1982434 syscalls:sys_enter_exit_group()
> > root@number:~# perf trace -e syscalls:sys_enter_exit_group true
> >      0.000 true/1982437 syscalls:sys_enter_exit_group( k�)
> > root@number:~# perf trace -e syscalls:sys_enter_exit_group true
> >      0.000 true/1982439 syscalls:sys_enter_exit_group(, loads 8��1)
> > root@number:~#
> >
> > So we don't _miss_ the events, which I was noticing and brought me to
> > test your latest 2 patches, which I applied and added a Tested-by, now
> > tryint to figure out this garbage...
> 
> Benjamin has already sent v2 to fix this:
> https://lore.kernel.org/linux-perf-users/20241107232128.108981-2-benjamin@engflow.com/

Interesting, I wonder why b4 didn't pick the v2 :-\

I'll try it, but see my other message, maybe the way I fixed is simpler?
Its a two liner that could be turned into a one liner by right at the
start of the function setting bf[0] = '\0', that way we wouldn't need
even to check if printed == 0 at the end.

Anyway, will test the newer version.

- Arnaldo
