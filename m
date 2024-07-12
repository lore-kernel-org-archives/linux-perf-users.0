Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFE0DF49;
	Fri, 12 Jul 2024 19:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720812931; cv=none; b=TUMs7VGvcrOz2MwmD78U5C3nG6yQulGdoEVs8UIBu87vRqh++7A7ezdrfD1d3iHp5LjrFW2FOAe9ZcKWmsRhNtHR7UU3u1tlTgmOJ+YafTdXf09JolHyTMC9v33uwjHlNm+kSZSIPsI/jTeKQkIgIg77lHD5+misosThGs66V4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720812931; c=relaxed/simple;
	bh=ph+XHcXLNuWCPF/ambgzBDtj0uCcrdSQ6Nyqt70Sp0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8cD8pkfe7AnqKi9fWNbXid095KuZNOBTshUcGHam2GKwh3Z6v66EtC5Jz2A6KpWGWaTNOEDFZy51+2toTVu8pjh26f/qMLYiQ79aVXupXaq1xqMtcV7djIs8P6gRkKwRdv0nBKag1vs0Mo/GKgsERAXjR5qeBg9M8VCu5S6SgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSmeegAG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSmeegAG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAD1C4AF09;
	Fri, 12 Jul 2024 19:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720812930;
	bh=ph+XHcXLNuWCPF/ambgzBDtj0uCcrdSQ6Nyqt70Sp0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NSmeegAGTJnqVeGZpgxL0B79yWg6SOmoog4/2EhdVO8cmsnkZJblV8kD2SEAXEKTr
	 ya6CP7Md+x8UFORES2wlsI2vv0tQR8SV8KtZ6v+DZK/KoCT+VlXoBorzhVbWlZqIbs
	 gaUaQFymapK9NIuUC10sgKQLx/dYqE/2FQkWLeO4LsD3qeYhxHWns0LHM8PCaBL1Mw
	 1Y7mJMvXSAve/ERy/zjikMGz1DCZ07cP/oI7/MhQepOw+xqrinxQfGmiABBxihDTHD
	 EWplRHYV/KRzzo7HWmgZqwCXJb/ibEKJKu3mMU+XBiuc9lRGqzrFaEuOaiHexYUNPM
	 Wz3yyX922h35w==
Date: Fri, 12 Jul 2024 14:35:26 -0500
From: Namhyung Kim <namhyung@kernel.org>
To: Casey Chen <cachen@purestorage.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	yzhong@purestorage.com
Subject: Re: [PATCH 1/1] perf tool: fix handling NULL al->maps returned from
 thread__find_map
Message-ID: <ZpGFfjebaW9LGNBo@google.com>
References: <20240708232302.15267-1-cachen@purestorage.com>
 <20240708232302.15267-2-cachen@purestorage.com>
 <CAM9d7cisBvfLTzNp8=0SG6g3CA9zJFNayjopSEDX0fxRyG05UA@mail.gmail.com>
 <CALCePG0_PpwKK_=YrpCGr-j51dG8xtDP-yzBYGeLwphscFobRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCePG0_PpwKK_=YrpCGr-j51dG8xtDP-yzBYGeLwphscFobRg@mail.gmail.com>

Hello,

On Wed, Jul 10, 2024 at 03:29:27PM -0700, Casey Chen wrote:
> On Mon, Jul 8, 2024 at 10:01 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > On Mon, Jul 8, 2024 at 4:23 PM Casey Chen <cachen@purestorage.com> wrote:
> > >
> > > With 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions"),
> > > thread__find_map() would return with al->maps or al->map being NULL
> > > when cpumode is 3 (macro PERF_RECORD_MISC_HYPERVISOR),
> > > later deferencing on it would crash.
> > >
> > > Fix callers of thread__find_map() or thread__find_symbol() to handle
> > > this.
> >
> > It looks like you drop the callchain if it doesn't find a map/symbol.
> > Can we keep the entries with raw hex numbers instead?
> >
> In add_callchain_ip(), my change let it return if either al.maps is
> NULL or al.map is NULL after thread__find_symbol(), I'm not sure what
> else can add_callchain_ip() could do to keep raw hex numbers. If it
> proceeds, al.sym is NULL, the code inside 'if (al.sym != NULL)' would
> skip. callchain_srcline() would return NULL. chain_cursor_append()
> would append a node whose ms.maps/ ms.map are NULL. Later
> dereferencing them would cause trouble. But we could add other
> information to the node, like ip, branch, nr_loop_iter, iter_cycles,
> branch_from, are these information good to have ? but how to avoid
> dereferencing NULL maps/map later.

By checking if it's NULL?  I think it's normal to have NULL map or sym
due to missing events, stripped binaries and so on.  The callchain code
used to print raw ip address when it doesn't have symbols.  And srcline
can/should do the same.

Thanks,
Namhyung

> >
> > > ---
> > >  tools/perf/arch/powerpc/util/skip-callchain-idx.c | 10 ++++++----
> > >  tools/perf/util/machine.c                         |  5 +++++
> > >  tools/perf/util/unwind-libdw.c                    |  6 ++++--
> > >  3 files changed, 15 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
> > > index 5f3edb3004d8..25b0804df4c4 100644
> > > --- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
> > > +++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
> > > @@ -255,13 +255,14 @@ int arch_skip_callchain_idx(struct thread *thread, struct ip_callchain *chain)
> > >
> > >         thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
> > >
> > > -       if (al.map)
> > > -               dso = map__dso(al.map);
> > > +       if (!al.map)
> > > +               goto out;
> > > +
> > > +       dso = map__dso(al.map);
> > >
> > >         if (!dso) {
> > >                 pr_debug("%" PRIx64 " dso is NULL\n", ip);
> > > -               addr_location__exit(&al);
> > > -               return skip_slot;
> > > +               goto out;
> > >         }
> > >
> > >         rc = check_return_addr(dso, map__start(al.map), ip);
> > > @@ -282,6 +283,7 @@ int arch_skip_callchain_idx(struct thread *thread, struct ip_callchain *chain)
> > >                 skip_slot = 3;
> > >         }
> > >
> > > +out:
> > >         addr_location__exit(&al);
> > >         return skip_slot;
> > >  }
> > > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > > index 8477edefc299..fa4037d7f3d4 100644
> > > --- a/tools/perf/util/machine.c
> > > +++ b/tools/perf/util/machine.c
> > > @@ -2098,7 +2098,12 @@ static int add_callchain_ip(struct thread *thread,
> > >                         }
> > >                         goto out;
> > >                 }
> > > +
> > >                 thread__find_symbol(thread, *cpumode, ip, &al);
> > > +               if (!al.maps || !al.map) {
> > > +                       err = 1;
> > > +                       goto out;
> > > +               }
> > >         }
> > >
> > >         if (al.sym != NULL) {
> > > diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
> > > index b38d322734b4..fb038ef55be2 100644
> > > --- a/tools/perf/util/unwind-libdw.c
> > > +++ b/tools/perf/util/unwind-libdw.c
> > > @@ -53,8 +53,10 @@ static int __report_module(struct addr_location *al, u64 ip,
> > >          */
> > >         thread__find_symbol(ui->thread, PERF_RECORD_MISC_USER, ip, al);
> > >
> > > -       if (al->map)
> > > -               dso = map__dso(al->map);
> > > +       if (!al->map)
> > > +               return -1;
> > > +
> > > +       dso = map__dso(al->map);
> > >
> > >         if (!dso)
> > >                 return 0;
> > > --
> > > 2.45.2
> > >
> > >
