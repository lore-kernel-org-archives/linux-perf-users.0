Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBB13FB31;
	Mon, 20 Oct 2025 01:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760922646; cv=none; b=J4Xbzx42MCqpXChn9lrbdwZu/Z/it8qNZ46itDRLgSOrV0EoNtbmaZzrExGgSiAk2b0JnBdrUH6D2wLzg5GxWlKq7q9Gx3u87VoVQKmcWqBBC6ImeOoRZ+CbNnlL8V761Z+6Eo8mAbOXVIjF47newm+BnmOmrV+Vuc3eZvQ0UO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760922646; c=relaxed/simple;
	bh=z3DQg5yGsx569RoNzKgXt3TPgaOGodG1SLg0XXnCCec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEj6aI0xMbi+Pyqb0R7abRrxptqhWJ694FaFc2/2eNWmPxJboQFkqdnoBDLuz8UKf38ouk5xr/8UI4KlYLlR8ygk8L2ezpa7q3Z35+SeJHw93L3LVQbYn1Ic5poXsG6h6GjfKVb/LZ07NgF3VyHZSQ2AzSz/HL1VkAtVm/J7nT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmuF8n5N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmuF8n5N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DB3C4CEE7;
	Mon, 20 Oct 2025 01:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760922645;
	bh=z3DQg5yGsx569RoNzKgXt3TPgaOGodG1SLg0XXnCCec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WmuF8n5NRvWirLFjzE/LUIG5vYU8tDajYDJJcEMiQJRdHXH/2RfOcssphMe78Qf4A
	 NM0o+LqcaHqdiLY+bIm1WwjHq0PgI6yhd2HgYwZh9OUVNLMkOwP4VzFSmK+okKBKUU
	 3aYJKK4B8/7JrfPAhanjOlxnfx0NTlNKpLUvk7GhcJY94rWyq9jaDn6D3ZyPuFYcou
	 mHunz/EPRJpY7kY3l5sYeLeDg8jGkUTFG/nmukkKpmFcVODv5ZZZw3o/kgxTXNJjLW
	 CkwhkMKQ4CsbcLPreV+Z2ML87I0PZZFeDJ+oQFk235mZgyjPqoMNcDM0cgjj6IkXs4
	 wpIsD6N6m0pHA==
Date: Mon, 20 Oct 2025 10:10:37 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Howard Chu <howardchu95@gmail.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Gautam Menghani <gautam@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] perf ilist: Don't display deprecated events
Message-ID: <aPWMDVWFUBAjasOl@google.com>
References: <20251016222228.2926870-1-irogers@google.com>
 <aPRTQLcOBtHiTGms@google.com>
 <CAH0uvohtoVR=iXNwJWYXXgnt4LLWCMheSt66Hnx5hq=QB0KU3w@mail.gmail.com>
 <CAP-5=fWDqE8SYfOLZkg_0=4Ayx6E7O+h7uUp4NDeCFkiN4b7-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWDqE8SYfOLZkg_0=4Ayx6E7O+h7uUp4NDeCFkiN4b7-w@mail.gmail.com>

On Sun, Oct 19, 2025 at 04:04:17PM -0700, Ian Rogers wrote:
> On Sat, Oct 18, 2025 at 11:50 PM Howard Chu <howardchu95@gmail.com> wrote:
> >
> > Hi Namhyung,
> >
> > On Sat, Oct 18, 2025 at 7:56 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Hi Ian,
> > >
> > > On Thu, Oct 16, 2025 at 03:22:26PM -0700, Ian Rogers wrote:
> > > > Unsupported legacy events are flagged as deprecated. Don't display
> > > > these events in ilist as they won't open and there are over 1,000
> > > > legacy cache events.
> > >
> > > Off-topic, any chance to integrate this into a perf command?
> > > It'd be convenient if we can call this like `perf list --interactive`
> > > or some other way.
> >
> > You have my vote, user-friendliness is important.
> > I think Ian mentioned that the major drawback is the difficulty of
> > forwarding arguments passed to the ilist.py program. A random thought:
> > perf is known for binding everything under a single command, but to
> > make scripting more flexible, perhaps some Bash scripts added to
> > .bashrc could be considered. After all, perf is fundamentally a
> > command-line tool.
> 
> Thanks Howard and Namhyung,
> 
> I think Arnaldo also raised this in the past.  My thought on how to do
> this is to build in to `perf script`:
> 
> 1) `perf script` currently uses libpython and then exposes a
> trace_start, trace_end and process_event method. When building the
> flamegraph work the only place that textual can run is in trace_end as
> it needs to run on the main python thread. This means we can't do
> incremental loading of data files while textual is showing the data as
> perf wants to be the main thread. So step 1 is to create a python
> version of the trace_start, trace_end and process_event callbacks. To
> do this something like the session API needs wrapping or writing in
> python. I'm not sure I'd keep the API the same as the C one. It'd be
> interesting to think of async file processing. It'd be nice to make
> the generation of strings.. in the event lazier. We could start with
> the existing API though, and then migrate to something more complex
> later.

Sounds like a long term plan.  I'm ok with the change but not sure how
soon it would happen.  I was suggesting a short term workaround if you
don't plan to work on this.  I thought we can exec ilist.py with proper
settings from `perf list`.  But it's up to you. :)

Thanks,
Namhyung

> 
> 2) Once we have a session like API in python we can convert the
> existing `perf script` commands to be standalone tools similar to
> ilist. So we can convert all the existing tools to be standalone.
> 
> 3) Once we have standalone versions of the `perf script` scripts then
> we can have `perf script` just exec the commands. The install step can
> install the scripts like it currently does and we can move ilist into
> the scripts location.
> 
> 4) Once we run python things as tools in their own right we can
> deprecate the libpython stuff, probably make it a build opt-in thing,
> etc. It seems hard to delete unused features, like libbfd, from the
> codebase. We did merge a patch deprecating libperl as a step in this
> direction.
> 
> Thanks,
> Ian
