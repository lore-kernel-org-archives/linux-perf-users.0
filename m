Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF5550A63;
	Fri,  4 Oct 2024 05:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728019146; cv=none; b=B0sEXVj1G66ycyOxS4Hs9R1jAI7xCM/kFoTCKcM0QVErcHg+IbsNZbFT1jyM1Lm6kVjO574KIf8VesddOGGNG9do9f66O79jgnLi60P3sNSwOENRUoYoOQJgMx7rFOB9JSQpEX/bIlKuZp4ef5evNfLv/J7uzjFWrhBh9rVhIIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728019146; c=relaxed/simple;
	bh=Db1HjIH8D2fmPRkW2Gh5vDc82cuF0lN4dWb5pN02xDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/3YznPJ2BBxVbn+b4SsOPeN+cpi6XBEdmQxtR2dlenU9SHNEw1/l5VxxUIXt/pcOTlEyFz637gf+P5OJ9Afu6/kVW+8UoLvdoXV72CwoFKdKHGIcnphEuOO4JKKJaRIUXEqRVrrgO9ivq4JV32Qhz11Z0IA4ublDc1MNL84C7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFwrcEkw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFwrcEkw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AA0C4CEC6;
	Fri,  4 Oct 2024 05:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728019146;
	bh=Db1HjIH8D2fmPRkW2Gh5vDc82cuF0lN4dWb5pN02xDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GFwrcEkwKy9ydjMrtp7L9+0StTnvutEWjNh1v7GTOM8ViPad2nlync9sLKs510k0P
	 aeZ/yhVJAkUqOC7kCs3poMKl3I2sccDy1iaQ7IDqo2JvrIiuWM4XclYsR8ue3dV9xy
	 O/zgBW0IJ8cOpuGDJv7fNV9KFz+wNmnsm7bJPGANrGRawfVcUicteiuXFwIMqrXeSa
	 UMJdECJQnKTIIJQ49AlJn95+udCFX2VEpEf6hry1AAdIJR8QwyP9jfZPOvkvgJlyXO
	 JFJIH6BlYkqahaZIOorO657um727heonJfJfPFyPp3c2g4VIpXf2/OirSMvsbNzuNi
	 DRyDxoXvLVt/w==
Date: Thu, 3 Oct 2024 22:19:04 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yongwei Ma <yongwei.ma@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [Patch v5 0/6] Bug fixes on topdown events reordering
Message-ID: <Zv96yMTdLa6tst26@google.com>
References: <Zv3ek7aBkQo0Z9To@google.com>
 <CAP-5=fUjLhGw4SmMTH_H2=1OwRDrY04RL6+C=DdQ=VSgXk8JZg@mail.gmail.com>
 <b0695ef6-8a59-4550-8a33-9afb25c93f48@linux.intel.com>
 <CAP-5=fXutWptEKZKNvLXvXXpuDoMje6PiOxMuF872xoMjtumGQ@mail.gmail.com>
 <Zv7KHGQx0y3rAGWx@google.com>
 <690ddcd6-276a-4b7b-bd21-fb4ef2349990@linux.intel.com>
 <CAP-5=fU7_RqcG+YO4C=FP_cy__eSd=ieJ_pOe4J-s2zh=sybsw@mail.gmail.com>
 <Zv8XIZAwfoTtzOl4@google.com>
 <8df24fe8-4d90-4105-acf0-e4f2667c42c9@linux.intel.com>
 <CAP-5=fUVNa_JKz7WweWsQjobhFCoknbPuPGzPGFGcaDJ8wxLQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUVNa_JKz7WweWsQjobhFCoknbPuPGzPGFGcaDJ8wxLQw@mail.gmail.com>

On Thu, Oct 03, 2024 at 04:36:25PM -0700, Ian Rogers wrote:
> On Thu, Oct 3, 2024 at 4:29 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
> >
> >
> >
> > On 2024-10-03 6:13 p.m., Namhyung Kim wrote:
> > >> Dapeng's comment should cover replace the comment /* Followed by
> > >> topdown events. */ but there are other things amiss. I'm thinking of
> > >> something like: "slots,cycles,{instructions,topdown-be-bound}" the
> > >> topdown-be-bound should get sorted and grouped with slots, but cycles
> > >> and instructions have no reason to be reordered, so do we end up with
> > >> slots, instructions and topdown-be-bound being grouped with cycles
> > >> sitting ungrouped in the middle of the evlist? I believe there are
> > >> assumptions that grouped evsels are adjacent in the evlist, not least
> > >> in:
> > >> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/parse-events.c?h=perf-tools-next#n2106
> > >> Does cycles instructions end up being broken out of a group in this
> > >> case? Which feels like the case the code was trying to avoid.
> > > I got this:
> > >
> > >   $ sudo ./perf record -a -e "slots,cycles,{instructions,topdown-be-bound}" true
> > >   Error:
> > >   The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (topdown-be-bound).
> > >   "dmesg | grep -i perf" may provide additional information.
> >
> > To be honest, I think the "slots,cycles,{instructions,topdown-be-bound}"
> > is a meaningless case. Why a user wants to group instructions and
> > topdown events, but leave the slots out of the group?
> > There could be hundreds of different combinations caused by the perf
> > metrics mess. I don't think the re-ordering code should/can fix all of them.
> 
> I'm happy with better code and things don't need to be perfect. Can we
> fix the comments though? It'd be nice to also include that some things
> are going to be broken. I can imagine groups with topdown events but

Can you please propose something?

Thanks,
Namhyung


> without slots, for example we group events in metrics and in
> tma_retiring we add "0 * tma_info_thread_slots" to the metric so that
> we get a slots event. If the multiply were optimized away as redundant
> then we'd have a topdown group without slots, we could pick up slots
> and other events from other metrics.
