Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8CB197A91;
	Mon, 12 Aug 2024 20:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723496070; cv=none; b=uhGiiVI267fY8wbbciFfaqEVauSZeCmObzwLtYddn3Pa5G1eRCUQQ8QpwUj1FtMOTAtkOTzqKr3vdKAydvI9TWnBKmQJpbDVdbsrcLNFm1O4SgMcyukaKjGgO/gi4OkBRuBE0Rp5s+IdSnf76Qe4ySJNzFPZiFzummYY3F+KelE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723496070; c=relaxed/simple;
	bh=Qy4VIkLa9sGuuTjFoaEQ/+gYyGwCBG/jEJbdPLJMEQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMdVymnoFyWMHpGgujFAUrdn0zCjLK/nZacyg4vWvzmHQlYwODUgITdqcAXUZge7zg0rMRutBopPaYyJUPW12LLSiZBP2FJtecuU3NE+gSDR7Mcuy0q8iznBWHWUYHvaSsCrIAoGXrJj1IYj17wuN0TZk3y99j/1K8aigCtdRXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X50bm0I5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X50bm0I5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC0EC4AF0C;
	Mon, 12 Aug 2024 20:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723496069;
	bh=Qy4VIkLa9sGuuTjFoaEQ/+gYyGwCBG/jEJbdPLJMEQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X50bm0I5fop78yGav1dkYg1oqqYHBmW9F6E4pNwW4z0ND7Djj+TOpHVdD7JsGra21
	 cnHMRpTEULbQGEeh2MPegJ5nDs2l+6CnMnwMqtKwCzPqqLEv6/IDjiVHgy4m7DT7Mg
	 0aG08LZFjddV2EetokUum8R1hg+N+ogHA3Rn2ZoTmB6unRPBC3xhaxYyo0nD1rBAuH
	 fZ8DJS8+dZy3pnz3OfvenJA1AXIUuNKfdcvZDgLJ1kuQO399sS/LU9HkKXQS4BRbh4
	 CbkpQ6BFPzPiNXNXllwam21Xn0UNA2Qi4M9j80sFdNQ0yBfqJwc3/YySg1zLLvS8Ei
	 McEWuVspY0fKQ==
Date: Mon, 12 Aug 2024 17:54:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Casey Chen <cachen@purestorage.com>,
	Tom Zanussi <tzanussi@gmail.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf inject: Inject build ids for entire call chain
Message-ID: <Zrp2gdY87ZFlmMaW@x1>
References: <20240801031249.176913-1-irogers@google.com>
 <Zq0kL-lyCqkM3P4G@google.com>
 <CAP-5=fUy6sx5ZMs6L1we2tpaq1iyUz4GW_ps7c7xE1zqjVzvgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUy6sx5ZMs6L1we2tpaq1iyUz4GW_ps7c7xE1zqjVzvgg@mail.gmail.com>

On Mon, Aug 12, 2024 at 01:43:59PM -0700, Ian Rogers wrote:
> On Fri, Aug 2, 2024 at 11:23 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Wed, Jul 31, 2024 at 08:12:49PM -0700, Ian Rogers wrote:
> > > The DSO build id is injected when the dso is first encountered but the
> > > checking for first encountered only looks at the sample->ip not the
> > > entire callchain. Use the callchain logic to ensure all build ids are
> > > inserted.
> > >
> > > Add a for_each callback style API to callchain with
> > > sample__for_each_callchain_node. Possibly in the future such an API
> > > can avoid the overhead of constructing the call chain list.
> > >
> > > Fixes: 454c407ec17a ("perf: add perf-inject builtin")
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> Ping.

This one isn't applying, maybe a clash with the previous patch or the
constify series?

Please take a look at wat is now in tmp.perf-tools-next

- Arnaldo
