Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2457E575;
	Thu, 19 Dec 2024 05:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734586331; cv=none; b=gbacHoLeJNuYhZdvp5ScQ08O9LNHFUpYeaLsDVuwuaJeiRng1kRP7aVyyysSS/eXmpV6vs0HlE10DA8TbvpLuiDrvpVlJP4/UZrBcq5aC4WyunfWv8pcMSzvP8O5aCInmmCAN+tCFK7+X9VMPHlKneuo5rJSgi0pxXxTtnV8sp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734586331; c=relaxed/simple;
	bh=4//x7ZLluRSezOKmjTt3AlIXBt2kvnyq90QvcGnF9Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXpLeNqnVE5WEH5fKRkoQej6A1v+MIQ1sQtYDkevFAIlTIojSmumh+ck2LIJgbQ3Zgh3lw7MaCLb2xEWSeXEJMsOohRKi3ASwGzakQ6Y1RvgY8PHeFZssogoK8nVFscGzxtGtRPUC+EXMZh8URtrETEQWhm5wayMdJMUmXHt4Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEFCpb/H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEFCpb/H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D33C4CECE;
	Thu, 19 Dec 2024 05:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734586331;
	bh=4//x7ZLluRSezOKmjTt3AlIXBt2kvnyq90QvcGnF9Z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YEFCpb/HYSsJBPuY89gmrWbpZFnasHU1UfhaHHkydkAQdv3nTKZ69O1JspqBanMZy
	 IjOgUOWtmQEqi9SNsEPyQtmj81vpPMZM2NXRWU2A04WCcJmAdVDHIcPzESixoU98VY
	 WtCAyyMsOOAClpnUSPKrdCPjWobLblnvH8nEbcQtjSFzaNH8LinF7DEAKuK2CWEfu3
	 jwXDfhs28KV6f8jZWK0HTx+RWJv5mewvwduvF61BSiQ9sXecdS3r2a2cxm5pO13oif
	 oZJPGriV0vGRWRZAW8i8CJHF6StuzdBL+9GFF5wD6njUTK1ZC+GD1D8HZizKvhPn3r
	 0UHlthsg5cr7g==
Date: Wed, 18 Dec 2024 21:32:08 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Yanteng Si <siyanteng@loongson.cn>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] perf cpumap: If the die_id is missing use
 socket/physical_package_id
Message-ID: <Z2Ov2Gy99KOtctPT@google.com>
References: <20241216232459.427642-1-irogers@google.com>
 <20241216232459.427642-2-irogers@google.com>
 <855f50a5-f397-4a08-8298-78bd040e5328@linaro.org>
 <CAP-5=fVeW+XARtWtdR=XX47w-ZznKiGdhxDBy=Le_QTS=R6SQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVeW+XARtWtdR=XX47w-ZznKiGdhxDBy=Le_QTS=R6SQA@mail.gmail.com>

On Wed, Dec 18, 2024 at 09:42:27AM -0800, Ian Rogers wrote:
> On Wed, Dec 18, 2024 at 4:04 AM James Clark <james.clark@linaro.org> wrote:
> >
> >
> >
> > On 16/12/2024 11:24 pm, Ian Rogers wrote:
> > > An error value for a missing die_id may be written into things like
> > > the cpu_topology_map. As the topology needs to be fully written out,
> > > including the die_id, to allow perf.data file features to be aligned
> > > we can't allow error values to be written out. Instead base the
> > > missing die_id value off of the socket/physical_package_id assuming
> > > they correlate 1:1.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >   tools/perf/util/cpumap.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> > > index 27094211edd8..d362272f8466 100644
> > > --- a/tools/perf/util/cpumap.c
> > > +++ b/tools/perf/util/cpumap.c
> > > @@ -283,7 +283,8 @@ int cpu__get_die_id(struct perf_cpu cpu)
> > >   {
> > >       int value, ret = cpu__get_topology_int(cpu.cpu, "die_id", &value);
> > >
> > > -     return ret ?: value;
> > > +        /* If die_id is missing fallback on using the socket/physical_package_id. */
> > > +     return ret || value < 0 ? cpu__get_socket_id(cpu) : value;
> > >   }
> > >
> > >   struct aggr_cpu_id aggr_cpu_id__die(struct perf_cpu cpu, void *data)
> >
> > Hi Ian,
> >
> > I sent a fix for the same or a similar problem here [1]. For this one
> > I'm not sure why we'd want to use the socket ID for die when it's always
> > been 0 for not present. I wonder if this change is mingling two things:
> > fixing the negative error value appearing and replacing die with socket ID.
> >
> > Personally I would prefer to keep the 0 to fix the error value, that way
> > nobody gets surprised by the change.
> >
> > Also it looks like cpu__get_cluster_id() can suffer from the same issue,
> > and if we do it this way we should drop these as they aren't valid anymore:
> >
> >         /* There is no die_id on legacy system. */
> >         if (die < 0)
> >                 die = 0;
> 
> I think this breaks the assumption here:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/expr.c?h=perf-tools-next#n244

Hmm.. I'm not sure how it worked before.  The code is already there and
it just changed the condition from == -1 to < 0, right?

Thanks,
Namhyung


> hence using the number of packages. I think we need to make sure there
> is order otherwise we'll end up with "if no dies value present" or "if
> dies value is 0 ignore" everywhere. What is strange to me is that ARM
> may have the die_id present but have it contain the value -1.
> 
> > And last minor comment this could do with a fixes: 05be17eed774
> 
> Thanks,
> Ian
> 
> > [1]:
> > https://lore.kernel.org/linux-perf-users/20241218115552.912517-1-james.clark@linaro.org/T/#u
> >
