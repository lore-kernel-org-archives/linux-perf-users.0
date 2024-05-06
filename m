Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2370F1DFF3;
	Mon,  6 May 2024 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715020518; cv=none; b=tAPe083QD5qvX+udonFoNWDb0jIcDuQ+OeaneXGnTvdpeQbZCqhHMnWtqyTOzcIoMBlkooqDXr8EVhMRl/MiduUZPlAEMLmztgUGmUYDkuXYIVn7WYZx2tyUBg+oatZtvqdXEbzaYQKXiTDj4AvlNTjSAwDfsg5IrX8qTZz9DN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715020518; c=relaxed/simple;
	bh=EJCEu4USxW35SOv0xkyQJk5zUcKRkgxxAOS7xwgdXZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B85nmq/TAy75qOhI4oKBI+GyXoNUWNzAAk+pUcJyL1xyKuhqa8t71h9DXoFrlmrjI0JkQkC644MgJitbw1K473g8aMBiDm+sIXOOB5LkMcDc65jWEfdOjamf7XE5PKUgPUx/1CzlW1CoCKY9PcqcCQO7cTrdECILpS2eAGQK4T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GS+ueUOR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GS+ueUOR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8426C116B1;
	Mon,  6 May 2024 18:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715020517;
	bh=EJCEu4USxW35SOv0xkyQJk5zUcKRkgxxAOS7xwgdXZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GS+ueUORs5m7YW+dTwpnmvxdpAIQQ5nUssdQlK4mzpOaGtdRPjrZOI2mklpXdHdWa
	 HyNVT17rGI/5aikIvknUaOhC2onyCnVm9Hq5b5m3tYe3h40reCCWQKKnQuagXJO44C
	 bIrxou/fvqiPdFUDx5YD6PwgdDxbaesw0wCd7VS2IYp4KVGq+hHSGWltj4pY/jn+lQ
	 /EuYR8uJXDHU9CGcDRVtqH5BEmr2t76pOH+a/IU8x+Xu1z4wROLA5WDt42S3Sd7kVg
	 Ed3v4okJqVlJ4FlBZK8IpEln5RQ5RriaKve3CJzy38L7b2ZGYUJto3103hwGzMSMmc
	 xxZf6g9q/K5YQ==
Date: Mon, 6 May 2024 15:35:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	nabijaczleweli@nabijaczleweli.xyz, Leo Yan <leo.yan@linux.dev>,
	Song Liu <song@kernel.org>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Ben Gainey <ben.gainey@arm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Changbin Du <changbin.du@huawei.com>,
	Andi Kleen <ak@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dima Kogan <dima@secretsauce.net>,
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>,
	Paran Lee <p4ranlee@gmail.com>, Li Dong <lidong@vivo.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Chengen Du <chengen.du@canonical.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/7] perf dso: Reference counting related fixes
Message-ID: <Zjki4arHA6DifQ1n@x1>
References: <20240504213803.218974-1-irogers@google.com>
 <20240504213803.218974-7-irogers@google.com>
 <Zjjsvah8TU_Yubdn@x1>
 <CAP-5=fVi-qDAP1D+ZOgLD19Cp0K1yn13cgq65g3MuOFNoefc3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVi-qDAP1D+ZOgLD19Cp0K1yn13cgq65g3MuOFNoefc3Q@mail.gmail.com>

On Mon, May 06, 2024 at 08:26:02AM -0700, Ian Rogers wrote:
> On Mon, May 6, 2024 at 7:44 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > On Sat, May 04, 2024 at 02:38:02PM -0700, Ian Rogers wrote:
> > > Ensure gets and puts are better aligned fixing reference couting
> > > checking problems.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/machine.c    |  4 +--
> > >  tools/perf/util/map.c        |  1 +
> > >  tools/perf/util/symbol-elf.c | 51 ++++++++++++++++++------------------
> > >  3 files changed, 28 insertions(+), 28 deletions(-)
> > >
> > > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > > index 0b8fb14f5ff6..4a4541a2e887 100644
> > > --- a/tools/perf/util/machine.c
> > > +++ b/tools/perf/util/machine.c
> > > @@ -683,7 +683,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
> > >                                            struct perf_sample *sample __maybe_unused)
> > >  {
> > >       struct symbol *sym;
> > > -     struct dso *dso;
> > > +     struct dso *dso = NULL;
> > >       struct map *map = maps__find(machine__kernel_maps(machine), event->ksymbol.addr);
> > >       int err = 0;
> > >
> > > @@ -696,7 +696,6 @@ static int machine__process_ksymbol_register(struct machine *machine,
> > >               }
> > >               dso__set_kernel(dso, DSO_SPACE__KERNEL);
> > >               map = map__new2(0, dso);
> > > -             dso__put(dso);
> > >               if (!map) {
> > >                       err = -ENOMEM;
> > >                       goto out;
> > > @@ -735,6 +734,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
> > >       dso__insert_symbol(dso, sym);
> > >  out:
> > >       map__put(map);
> > > +     dso__put(dso);
> > >       return err;
> > >  }
> >
> > This seems to match the patch description, good, just aligning the puts
> >
> > > diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> > > index 117c4bb78b35..e1d14936a60d 100644
> > > --- a/tools/perf/util/map.c
> > > +++ b/tools/perf/util/map.c
> > > @@ -200,6 +200,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
> > >                               dso__set_build_id(dso, dso__bid(header_bid_dso));
> > >                               dso__set_header_build_id(dso, 1);
> > >                       }
> > > +                     dso__put(header_bid_dso);
> > >               }
> > >               dso__put(dso);
> > >       }
> >
> > But this is a missing one, so not aligning, but fixing a separate issue,
> > i.e. a missing put? Should go on a different patch, probably with a
> > Fixes.
> 
> The Fixes would be for a patch in the series - albeit that we've spent

Well, if it fixes something that got merged before, it should have the
Fixes, please then have it in the patch fixing it:

Fixes: f649ed80f3cabbf1 ("perf dsos: Tidy reference counting and locking")

> over half a year landing this and a month since that change landed:
> https://lore.kernel.org/all/20240410064214.2755936-3-irogers@google.com/
> The issue is that previously a find wouldn't do a get, so per the old
> code no put is necessary. Gets were added to finds to cover the race
> between a dso being returned from dsos and the item potentially being
> removed from dsos.

The last patch applied:

⬢[acme@toolbox perf-tools-next]$ git log --oneline -1
ee756ef7491eafd7 (HEAD -> perf-tools-next, perf-tools-next.korg/tmp.perf-tools-next) perf dso: Add reference count checking and accessor functions
⬢[acme@toolbox perf-tools-next]$

Needed this, which I applied and pushed to tmp.perf-tools-next:

  util/symbol.c: In function ‘dso__load_bfd_symbols’:
  util/symbol.c:1683:9: error: too few arguments to function ‘dso__set_adjust_symbols’
   1683 |         dso__set_adjust_symbols(dso);
        |         ^~~~~~~~~~~~~~~~~~~~~~~
  In file included from util/symbol.c:21:
  util/dso.h:268:20: note: declared here
    268 | static inline void dso__set_adjust_symbols(struct dso *dso, bool val)
        |                    ^~~~~~~~~~~~~~~~~~~~~~~
  make[6]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:106: /tmp/tmp.ZWHbQftdN6/util/symbol.o] Error 1
    MKDIR   /tmp/tmp.ZWHbQftdN6/tests/workloads/
  make[6]: *** Waiting for unfinished jobs....

This was updated:

  -       symbols__fixup_end(&dso->symbols, false);
  -       symbols__fixup_duplicate(&dso->symbols);
  -       dso->adjust_symbols = 1;
  +       symbols__fixup_end(dso__symbols(dso), false);
  +       symbols__fixup_duplicate(dso__symbols(dso));
  +       dso__set_adjust_symbols(dso);

But not build tested with BUILD_NONDISTRO and libbfd devel files installed
(binutils-devel on fedora), I noticed it using 'make -C tools/perf build-test'.

Add the missing argument:

   	symbols__fixup_end(dso__symbols(dso), false);
   	symbols__fixup_duplicate(dso__symbols(dso));
  -	dso__set_adjust_symbols(dso);
  +	dso__set_adjust_symbols(dso, true);
