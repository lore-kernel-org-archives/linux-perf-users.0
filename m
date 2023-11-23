Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3706C179A4
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Nov 2023 21:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPvW/UXm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844DCC433C7;
	Thu, 23 Nov 2023 21:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700776192;
	bh=ChruaeO872rftytl509GOtmQz0j11PGUCH8A/6iytsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NPvW/UXmQAkbjpaCxOG4Pi2qMzTjyn9qSa5VYZ1sNPcssByNblU9o9LLcvT1yIt8g
	 xqAdKGHTdo40MqRWSj0y2cOrU3Sk80EkPVIZMXOSBezR7cKDb6bIqK8giI+E3VFnQo
	 Ju+DyMGeSXYEN2KMQMXQyH7cgyduWHsv83UHTv19RsChb8iQVkFFZzGKSS1eIiV/kg
	 c3aYogpMsqqcHg/+Fj6yZ08wCKdgp/fExbpAIVp4yrPZT0K3j5BnSPt1sZnIXD1Oa4
	 C3xBPcov+lyzaM2uHhr4TInpO8dFmkPwi/icoWZw9/G3YbGqb0uLxMnuDyHOMjdeEU
	 jvp28jEodMVsA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id AED2840094; Thu, 23 Nov 2023 18:49:49 -0300 (-03)
Date: Thu, 23 Nov 2023 18:49:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>, Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>, Hector Martin <marcan@marcan.st>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH v1] perf parse-events: Make legacy events lower
 priority than sysfs/json
Message-ID: <ZV/I/Trfz7StsLsf@kernel.org>
References: <20231123042922.834425-1-irogers@google.com>
 <ZV9jq1C0TUh8MbeU@FVFF77S0Q05N.cambridge.arm.com>
 <CAP-5=fV3_UamHcGusUVyo23OW6tRnmSc_tohuDf1KTf4F_os1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV3_UamHcGusUVyo23OW6tRnmSc_tohuDf1KTf4F_os1g@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Thu, Nov 23, 2023 at 07:18:57AM -0800, Ian Rogers escreveu:
> On Thu, Nov 23, 2023 at 6:37 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > On Wed, Nov 22, 2023 at 08:29:22PM -0800, Ian Rogers wrote:
> > > This is a large behavioral change:
> > > 1) the scope of the change means it should bake on linux-next and I
> > > don't believe should be a 6.7-rc fix.

> > I'm happy for this to bake, but I do think it needs to be backported for the
> > sake of users, especially given that it *restores* the old behaviour.

> It is going to change the behavior for a far larger set of users. I'm
> also concerned that:

> ```
> $ perf list
> ...
>   cpu-cycles OR cpu/cpu-cycles/                      [Kernel PMU event]
> ...
> ```

> implies that cpu/cpu-cycles/ is a synonym for cpu-cycles, which is no
> longer true (or pick another event from sysfs whose name is the same
> as a legacy event). I'm not sure what a fix in perf list for this
> would look like.

It is a mess, indeed, cpu-cycles should be equivalent to
cpu/cpu-cycles/, map to the same HW PMU counter.

But by now I think we need to just reword the output of perf list to not
equate those events, and instead provide a more informative output, if
that is at all possible.

Something like:

Legacy events:

cpu-cycles: some nice explanation about the intent for this one (Ingo's
probably).

And then:

PMU events: (and this is even less clear :-()

cpu/cpu-cycles/: other nice explanation about the intent for this one,
if different, on this arch, for the "legacy" cpu-cycles one.

The original intent, that I called "Ingo's" was to try to somehow
generalize some concepts (CPU cycles, for instante) so that we could get
a rough idea that would allow us to somehow compare results using the
tools over different architectures (and micro-arches, etc).

I think that with these generic names we're now in damage control mode:
what matters is to keep what people got used to to continue to hold. And
that is what I think is the main argument here.

And I really think we should just head people like Hector (perf power
users) and provide a way to aggregate "cycles" over all cores, probably
not in the default output, but in a really simple way, as he seems to
want that and I would'n t be surprised that that may be something useful
after all 8-).

So back to checking why this patch isn't working in some of the
container arches I test this whole shebang, sigh.

- Arnaldo
