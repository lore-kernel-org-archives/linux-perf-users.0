Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B68C2AEFE;
	Fri, 16 May 2025 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747422998; cv=none; b=HeJ7Bolit2OJK5WvjAUQyHyUDvKG4xhb5y/l/Kg/5UJEPpzdlnWNvAo1rpGTSaKdtBvk/Ji9nl1tBYNfsCHbTb5u4UVlboNkt3ixnZENDfQuIDE2ZAzhiyUVm/Po78t5gJsLSJM+61Mq05pR6RP5h5XSEgFzdAPmLDM9g73OZs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747422998; c=relaxed/simple;
	bh=vsq76j3iWf8u5+jrxprtL/SbkQb7ySNpc4vIhbllWU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R33kOtI+5yjtNTjZzCnVi3pzLCJLhVjfEbh0LaXsd8TQjhI1WpCBjn+cz6PSZaET4dxD79fdg5I/yF/S8cmZtDotLYqPWtJyrY0/LiriyTq3l0dAZNZDdbAe0do9BlBgflblgoSHt1Ar/G1vUktCJUjHW/GT/C4Xst1+okVZ6TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/7aSAIi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/7aSAIi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25333C4CEE4;
	Fri, 16 May 2025 19:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747422997;
	bh=vsq76j3iWf8u5+jrxprtL/SbkQb7ySNpc4vIhbllWU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n/7aSAIibFXsS263wD+UTRxSXrsoDrbL3wXqS8WA41bF8a4exPCCdGBL3Wch6WqYZ
	 3dFxDfMtrYWTvvj0niRBe/hv+Nmv+FLM2qqTplxD0MntH4BsTXyzpm0XAp70nhcD7x
	 sE68Q1gp1mqUCIQa+e5X662FMfNnZdqu2+tCPcBNX8aT/u5/nAk9vlYk8Jp86PQ8TJ
	 QgVeFcVtUj2IXvhYkM1/Sc6AnWv+88oI/5UuwNP7xehEV4eLJ+3evvYc3WmcQEhpac
	 e8LoEz+wdWkDGg/VKFziBaOrraOLgrclBCBLBhvmDTC4nvToB/Un4w7KdudGH0e5vE
	 Zz0deKuUT8Fog==
Date: Fri, 16 May 2025 16:16:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
	peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, terrelln@fb.com, leo.yan@arm.com,
	james.clark@linaro.org, christophe.leroy@csgroup.eu,
	ben.gainey@arm.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf record: Add 8-byte aligned event type
 PERF_RECORD_COMPRESSED2
Message-ID: <aCePEgXqcfQ9BCQy@x1>
References: <20250303183646.327510-1-ctshao@google.com>
 <Z9TXabugl374M3bA@google.com>
 <Z9hFJtEKfsGGUDMg@x1>
 <Z9hLKsZOfouM3K7H@x1>
 <Z9hR8M-SQ5TD2qMX@google.com>
 <Z9iHiTv_ud6GEhJh@x1>
 <CAJpZYjXwUz7x1XUF7AzgYR6PZo_igrwK9BkxGx_3N0pCs1YRvw@mail.gmail.com>
 <Z9iY7HFebiSaWZJQ@x1>
 <Z9kBAhEKKphn8JL6@google.com>
 <CAJpZYjVeMrjN09kaVCBs97q8_hnsgwwo7s0C0ctL5Kt0_FknBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJpZYjVeMrjN09kaVCBs97q8_hnsgwwo7s0C0ctL5Kt0_FknBQ@mail.gmail.com>

On Fri, May 16, 2025 at 10:10:27AM -0700, Chun-Tse Shao wrote:
> Ping.
> 
> For suggestions from Namhyung and Arnaldo, it was merged in:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/?h=perf-tools-next&id=b1b26ce8bb0eab1d058353ab6fa1a2b652a9a020

Testing it now, fixed up this:

+It is deprecated and new files should use PERF_RECORD_COMPRESSED2 to gurantee
                                                                      guarantee
+8-byte alignment.

- Arnaldo
 
> Thanks,
> CT
> 
> On Mon, Mar 17, 2025 at 10:13 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > On Mon, Mar 17, 2025 at 06:49:32PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Mon, Mar 17, 2025 at 02:45:39PM -0700, Chun-Tse Shao wrote:
> > > > On Mon, Mar 17, 2025 at 1:35 PM Arnaldo Carvalho de Melo
> > > > <acme@kernel.org> wrote:
> > > > >
> > > > > On Mon, Mar 17, 2025 at 09:46:40AM -0700, Namhyung Kim wrote:
> > > > > > On Mon, Mar 17, 2025 at 01:17:46PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > > > On Mon, Mar 17, 2025 at 12:52:09PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > > > > Checking the discussion and the patch.
> > > > > > >
> > > > > > > My first impression yesterday when I saw this on the smartphone was: how
> > > > > > > will an old perf binary handle the new PERF_RECORD_COMPRESSED2? Will it
> > > > > > > ignore it while emitting a warning, since it can be skipped and then
> > > > > > > what we will get a partial view?
> > > > > > >
> > > > > > > Having some session output showing how an older perf binary handles
> > > > > > > PERF_RECORD_COMPRESS2 would be informative.
> > > > > >
> > > > > > I think it'll show the below warning:
> > > > > >
> > > > > >   <offset> [<size>]: failed to process type: 83
> > > > >
> > > > > Right that is what I got:
> > > > >
> > > > > ⬢ [acme@toolbox perf-tools-next]$ perf.old script -i /tmp/perf.data.ck8
> > > > > 0xbf0 [0x250]: failed to process type: 83 [Invalid argument]
> > > > > ⬢ [acme@toolbox perf-tools-next]$
> > > > >
> > > > > I think we should change that to something more informative, like:
> > > > >
> > > > > 0xbf0 [0x250]: failed to process unknown type 83, please update perf.
> >
> > That would be nice, but there are cases it can fail even without new
> > record formats.  So it should also check if the type number is greater
> > than or equal to the max.
> >
> > > > >
> > > > > And then does it stop at that record it doesn't grok?
> > > > >
> > > > >         if ((skip = perf_session__process_event(session, event, head, "pipe")) < 0) {
> > > > >                 pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
> > > > >                        head, event->header.size, event->header.type);
> > > > >                 err = -EINVAL;
> > > > >                 goto out_err;
> > > > >         }
> > > > >
> > > > >         head += size;
> > > > >
> > > > > So we're stopping there.
> > > > >
> > > > > Maybe we can just warn and skip?
> > > >
> > > > Thank you Arnaldo, it is a good suggestion and I will work on this later.
> > >
> > > Thank you for considering that, really appreciated!
> >
> > It would be hard to process misaligned data though.  Probably we also
> > want to add a check to make sure it's properly aligned.
> >
> > Thanks,
> > Namhyung
> >
> > >
> > > perf deals with so much stuff and code flux that all the help that we
> > > can get is what is needed for it to continue to be relevant and useful.
> > >
> > > After all what is the point of a tool that produces bad results? :-)
> > >
> > > - Arnaldo
> > >
> > > > -CT
> > > >
> > > > >
> > > > > Anyway, the series as is seems ok.
> > > > >
> > > > > I'll test a bit more and send my Tested-by
> > > > >
> > > > > - Arnaldo
