Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794199261;
	b=z0TeAetnt6+Z/ha+dXWCF7icLLl01gjDxhxhu2mnyavqi1uAzv1irmxDeNUUb7/CLqQd
	 AkxJKGtclFdJlWk1HZ/fCeQdBAqj2zrfXKtlDvZKMqWJ3B4mLAvFY/D6XziAVpdA0/+ch
	 +3pdw/NCBr0V7caFiFBBrD0qE6cWORu01Ec0xzXe04evmrdB5KKpaVgzU+SZ9ueRphO9e
	 6sGSENAhwQibx30B/JXk9JBVxWY5HuqQHhqECCBeot/lyzvK+iIE2R6xK+ojh4nh85cm2
	 kZgIjRFCf6TX+0bMoXSateZBhyS27UeHabrqkckeKlc0lrU5VGzOR2ghnOfFT/zbKyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794199261;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=gJ74CSnVzPrkgTLXYkjcVhaLGZAUHvhtJS3ScUpXCvc=;
	b=xZUClqUpWaUF/1KFotPdYwPtfB5NFHIUs4dk2CgCwdnoa+2Uob4Rzj+lPi6wXSglEC/f
	 mqUQ+i2gdMLj6uKGWMhwHc0zVmAjkPBbQViJWDXqiJ6qjNMXO9rTVqP86qI/u4iVjETe2
	 v+dPkdJ1bGziYs7Xxu8NhiG4jVETZkc89q/nFmZODLEnnTFpL3rxKH/ncRkXQWvcC1/Ic
	 hhuyxa84YFluMQl1iXdm/GVh25bX7TgNrpciG1XFSj/HCMBjgUphfEBGm4qLN9pe6wilZ
	 UwIAIZVDhzFqtEKs8RjstrhLrE45Ph24EKVKLRK4z31GAqD2myzBxklwsRXWt/l6jmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aN5bLCzk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7642E606A321;
	Mon,  9 Nov 2026 04:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aN5bLCzk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FAB1F0089F;
	Mon,  9 Nov 2026 04:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794199261;
	bh=gJ74CSnVzPrkgTLXYkjcVhaLGZAUHvhtJS3ScUpXCvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aN5bLCzkkmHIJ+IHGhJWKRiJJ129JYWlLANhDgCGSZbbBUrlZwblQUxs4DOPAr9z1
	 v7Dm7LBQ818BSLR5cZWA1b4rsfH8RReWkZLjFtXkGkp3OT0lqLZ6JMLxoYMTJypJbt
	 EVTrfsvECNkrNjC2yEPEbukP++OGOvrKgiNO0Tz13mc4r06CClXkfVL/tc2rFQLYg0
	 NxRwMix+6s10xSU2Vsxa3cdXpccH1yZ6lnoQiW65j4NovyooLfphgiZ53fMGxycpL8
	 hYNQl5JC105e3OjDhMll4/miatP2tGprb2EhP4VDYpdNWnOiZolCX1NIIdflBzWT6V
	 iVExQCPyn6POg==
Date: Sun, 8 Nov 2026 20:40:58 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 0/2] perf unwind: Don't load symbols when the caller
 doesn't need them
Message-ID: <avFO2pqMGEkhaK_4@z2>
References: <20261030193237.1440673-1-thepacketgeek@gmail.com>
 <au18AJ94dUsE5PaQ@google.com>
 <CADvopvYeG74khivCbBR=LsFNAuqDzn94Wg+LA4PwscsQue510A@mail.gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvopvYeG74khivCbBR=LsFNAuqDzn94Wg+LA4PwscsQue510A@mail.gmail.com>

On Fri, Nov 06, 2026 at 04:26:54PM -0800, Matthew Wood wrote:
> On Thu, Nov 5, 2026 at 11:04 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > On Fri, Oct 30, 2026 at 12:32:32PM -0700, Matthew Wood wrote:
> > > When perf only needs to know which DSOs a callchain passes through (as
> > > build-id marking does at the end of 'perf record' and in 'perf inject
> > > -b') it resolves the callchain without symbols. The DWARF unwinders
> > > ignore that and look up the symbol of every frame anyway, which loads
> > > and demangles the whole symbol table of each DSO they visit.
> > >
> > > On arm64 every frame pointer sample also gets a short DWARF
> > > unwind to find the leaf function's caller; since v6.17 (commit
> > > 29be60c93d2d, "perf build-id: Mark DSO in sample callchains") the end of
> > > 'perf record -a --call-graph fp' loads the symbols of every user binary
> > > it sampled. On a 128-CPU arm64 host,
> > >
> > >   perf record -a -e cycles:u --call-graph fp -- sleep 2
> > >
> > > never finishes writing perf.data, with over 1GB of heap growth in 5
> > > seconds.
> > >
> > > Skipping the symbol lookup isn't enough because loading the
> > > symbols also finds two things the unwinders depend on: the DSO's
> > > build-id, which libdw needs to fall back to the build-id cache, and any
> > > separate debuginfo file, through dso__symsrc_filename(), which is how
> > > both unwinders find a .debug_frame there.
> > >
> > >   1: add dso__load_symsrc(), which does the same search for debuginfo
> > >      and the build-id as symbol loading, but doesn't read any symbols
> > >   2: pass the symbols flag down to the unwinders and honour it, using
> > >      dso__load_symsrc() when symbols aren't wanted, which also makes
> > >      the arm64 leaf frame caller unwind skip symbols
> >
> > Please don't.  I've added dso__dbginfo_type() to handle debug files and
> > that's the correct way to get the file.  Probably dso__debuginfo() would
> > work for you.
> >
> > I was working on cleaning up this area, but sidetracked by other things.
> > I hope to find time for it soon but you can go with the above helpers.
> >
> > Thanks,
> > Namhyung
> >
> 
> Hi Namhyung, thanks for the feedback. I'll look into those helpers and see about
> using them instead.

Great.

> 
> Can you confirm if the premise of the issue I'm reporting and trying
> to fix seems
> valid? Would saving this unnecessary work of symbol lookup when they're
> unused be part of your cleanup?

Basically there are 3 main use cases for DSO.

 1. symbol table - most analysis need symbol names
 2. binary contents - for perf annotate or instruction analysis
 3. debug information - srcline, inlined symbols, stack unwinding, ...

Due to split files, those information can be found in different files.
So we now have 3 types of binary type info to handle the cases
independently.  New helpers will give you a write path name for your use
case already.

Thanks,
Namhyung

