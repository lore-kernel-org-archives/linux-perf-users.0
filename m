Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6771A2547;
	Mon, 30 Sep 2024 20:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727187; cv=none; b=R4iiiXdvnz76nBQHmmN6eWYjrJrBBhKxcnqrNdAI2ci/b724XPoBJTm6dbYpXHZy9LOlHREuQcyzaOQPU1DAuwK9QT5aQBnCTcmOnFjMbpp56BuldytfocqgB6k+8flMHbyGH6KbrheGSspQF7wHjAojwgLEin68sIlnuzSYmEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727187; c=relaxed/simple;
	bh=JCF93E5FpNjDRjMTjqxLE22Kd9lWvfg4sMj0alvns8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHh4T1WHkoi3eqxbHP2EewRhIZXqiJGgESU4MjguSaGIA1EIYt6IkFP6o7YQfjfFTPYl3iuKuqop3R7jEiGxcfzIIRnJP1tNTbbQ+njkpfd+0B2KOPeWQcCIauymE/bHczbjLCVJYMrqeZ3vl+xoitxEJOiCFBzQYu2SDL9taQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/bpC/wi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/bpC/wi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73FAFC4CEC7;
	Mon, 30 Sep 2024 20:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727727187;
	bh=JCF93E5FpNjDRjMTjqxLE22Kd9lWvfg4sMj0alvns8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E/bpC/wiVQdJiQnI9wKuU8cgsyg+9zEy50Oe9pPtorob0/Wk2riPskJoJq5a5Y1p1
	 JgZqr1i2HzfQwt+ajm6O8YZGVJB7kjqnxS/5Nsbrgb86IOu2y1ukWGM8HKPZrsqRyr
	 fTqc/HYwrstngDt99c2zl2uFdIsQY+nxPCMKaV1wqskAnLaqGqW71K0/Q+FI5yQ/5l
	 7OrmEOjOEhIQIUFZYqzNI0KrzV8xG5/u4pjv5IqdeqOnzreuuKoPl6OXwVC8R3yJKE
	 6Lee2Gh34RxjmV1XPEFDkIZm6JGE/s6FW2NWTPGE70oopekiYZoJaOrPwvTAqmbbNd
	 m0dX47trzjGkA==
Date: Mon, 30 Sep 2024 13:13:05 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>
Subject: Re: [PATCH 04/10] perf stat: Add --exclude-guest option
Message-ID: <ZvsGUbo19pQ4Vtf9@google.com>
References: <20240905202426.2690105-1-namhyung@kernel.org>
 <20240905202426.2690105-5-namhyung@kernel.org>
 <b1002dc7-78bf-40ed-83af-12a50622fb76@linux.intel.com>
 <c26e646d-5ebf-473e-91e2-db28fc01e35d@linaro.org>
 <ZvMfVe1VXwhCIOB9@google.com>
 <f436dc23-bcaf-493b-93a9-699b63a18d46@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f436dc23-bcaf-493b-93a9-699b63a18d46@linaro.org>

On Wed, Sep 25, 2024 at 09:36:15AM +0100, James Clark wrote:
> 
> 
> On 24/09/2024 9:21 pm, Namhyung Kim wrote:
> > Hello,
> > 
> > On Mon, Sep 23, 2024 at 09:47:17AM +0100, James Clark wrote:
> > > For Coresight tracing and SPE we would want to keep exclude_guest, otherwise
> > > you generate a load of extra trace that you can't make use of. Say you were
> > > doing PGO on your host you wouldn't be recompiling anything the guests were
> > > running.
> > 
> > For the specific use case, I think we can guide users to add "H"
> > modifier (I guess it's not the default event for perf record).
> > Maybe we can consider per-PMU default attributes.
> > 
> 
> Yeah I was thinking about adding it as a default when the Coresight and SPE
> events are configured, but I think it's too much to expect for people to
> know all the edge cases about what the per PMU defaults will be. Having one
> default for all PMUs makes more sense to me.
> 
> I suppose asking Coresight users to add :H when they need it might be a less
> bad thing than this change to clean up the fragmentation in the defaults.
> 
> I expect most of the time if :H is not added things continue to work, just
> that more data will be recorded. One real concern is that in some
> configurations there is a limited buffer size and once it's filled you don't
> get any more data. If that buffer is filled by guest trace then maybe some
> Auto FDO flow could break. But it's kind of an edge case of an edge case and
> adding :H isn't really the end of the world.

Ok, let's go with simple then.

> 
> > > 
> > > If we do change the defaults isn't ':H' already enough to go back to the old
> > > behavior? I'm wondering why we need an argument when all the other exclude
> > > rules are done with the letter modifiers?
> > 
> > I'm not sure I follow this.  But maybe we don't need this option at all.
> > We can add ":H" for every event but I'm too lazy to add them to all the
> > default events in perf data. :)
> > 
> > Thanks,
> > Namhyung
> 
> Oh I see yes, the argument is a shortcut to adding H on all events and/or
> the default ones. I wasn't sure if was added because it couldn't be done
> with :H, but I see it's an alternative instead. So adding it makes sense.
 
Yeah, but the current behavior is somewhat misleading so I'll drop it
now.  If it turns out that we need something like this, I think we can
add more explicit options like --all-host and --all-guest later.

Thanks,
Namhyung

