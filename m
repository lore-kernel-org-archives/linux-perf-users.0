Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793353197;
	b=Kc9nT73WeueoHGHsMqCtEIGafCwgefXAUobLhVo3Lns7P9qVMC6y/wwR1ubLkC1Ay1rZ
	 mV1A8PPUyJAjylBDOJA+uW6MsiVMSckfMCqjQl7RGhrdUf106Dlm4V1pVFcrBkZD69PNv
	 EQl1QBvKQAVD24dNyVnoNi+nqPc7GSixsaANYe0zr88YEjBKL418FoW/pTsnRgozwUED1
	 /jOQVOjv113JXHHMG1rMlygdi94G0No7+Dn4BU/gJRv2zgGdH4z1kIouFDv/Tcu5mris9
	 QvLgzVFi1XQULmMoCSKkaEs/6GLwjW9eocYqkLmRgmH2g5fjZmP1i3TTMASnj7j9SJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793353197;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=tPNvnOFWbZg4adT62qnCH63S50YUPovaQONoc9l3558=;
	b=wxy7NvNYFKsZnXOou5G7jq3x1VM4s2RciRqmtnAAljnaX3YxFzoXqJ/mhH8aiNaS7+8y
	 nO+HkzfM6YlzMLLJin7RISa/ExqDVxAXBoR2iPc3Abcfv32meSt/bUV+Cl70HgW0AlrqQ
	 e45DW9rT7JBnb66RogccHncOqSr/VfaANmQm/SWoWE8dOICHVxI6VIbXFGloGWe8JApHZ
	 mBZqOJg8verpFdj8G4pxDHCxpfy266oAeNEFq24pm+iseAUjS5heRRI3T4+goww85HS9X
	 3NDWzKImx2hLU6sTri9+3uARdx43svCgxaHbNv+gTxsnFMJH0om99prWVXv0B9rp+KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=UlcnXyOh;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC92606A31E;
	Fri, 30 Oct 2026 09:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FC92606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=UlcnXyOh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=tPNvnOFWbZg4adT62qnCH63S50YUPovaQONoc9l3558=; b=UlcnXyOhb8vMMu7SJFoA+h3+Kv
	rETEph2rrkw1yEe+u3qNItK43aC6/4pQLjQHYnPF4KhxpadkFyOxImJRdlgb2UcygTB/BBjwg+Qgl
	/DQdo+uQLg+c41LS2tNd5td/vqMj97NWcq3qyZpstr6AAcfb1vTtfNBCn7hBSazmpThim+9fEfJAn
	nix4lkqMuDfbVRapYe3qo6vyIL/L9A3dLb8Ur3KS8hif1HF4OlSPnWbaxba5yGhI09e+Th52MPDQm
	Aw2Tqrucpt4uM+d9KKdD7s1KicIac3tnzY8NYREs1LV6xtV2uQF4UORmqBQxFB0y8VbgyCIqTwMk7
	fQj/DdJA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMj5T-00000000BYM-197f;
	Fri, 30 Oct 2026 09:39:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 621D9300578; Fri, 30 Oct 2026 10:39:50 +0100 (CET)
Date: Fri, 30 Oct 2026 10:39:50 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Magnus Lindholm <linmag7@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/5] alpha/perf: add ProfileMe sampling
Message-ID: <20261030093950.GI2668200@noisy.programming.kicks-ass.net>
References: <20261028-alpha-profileme-v1-0-d44b52bf2500@gmail.com>
 <20261029091141.GG1779021@noisy.programming.kicks-ass.net>
 <CAEdQ38GiZLmnjYxzN6C92uz4-MOX7KoYvTuRrZ5Zike8ssDCqQ@mail.gmail.com>
 <CAEdQ38F1+iCoxseW_M_16m9wXW0xe-4eKtr2OnehP=3XppF4MQ@mail.gmail.com>
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
In-Reply-To: <CAEdQ38F1+iCoxseW_M_16m9wXW0xe-4eKtr2OnehP=3XppF4MQ@mail.gmail.com>

On Fri, Oct 30, 2026 at 12:00:41AM -0400, Matt Turner wrote:
> On Thu, Oct 29, 2026 at 11:34 AM Matt Turner <mattst88@gmail.com> wrote:
> >
> > On Thu, Oct 29, 2026 at 5:11 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, Oct 28, 2026 at 02:09:29PM -0400, Matt Turner wrote:
> > > > The 21264 from EV67 on, and the 21364, have a second performance counter
> > > > mode, ProfileMe, alongside the Aggregate mode that the driver uses today.
> > > > An Aggregate mode sample reports the PC where the overflow interrupt was
> > > > taken. On an EV7 that is anywhere from 15 instructions before to 12
> > > > after the one that overflowed the counter, which makes perf annotate
> > > > output close to useless. In ProfileMe mode the CPU picks one fetched
> > > > instruction, follows it down the pipeline, and reports its PC along with
> > > > what happened to it: whether it retired, whether it trapped and why,
> > > > whether it was a mispredicted branch, stalled before map, or was killed
> > > > on a wrong path, and what PCTR1 counted while it was in flight.
> > >
> > > Isn't this the thing that ended up as AMD's IBS?
> >
> > I have no idea, but it wouldn't surprise me too much :)
> 
> Looking a bit further, it does seem so. ProfileMe was published by Dean
> et al. at MICRO-30 in 1997, and IBS works the same way: tag one
> instruction, follow it down the pipeline, and report what happened to
> it.

Right, I thought I remembered something like that. 

Anyway, I was thinking that perhaps there was something to share with
the existing IBS work, but the AI overlords abused me of that idea quite
quickly. While they are very similar in spirit, they are very distinct
in practice.

Carry on the legacy compute :-)
