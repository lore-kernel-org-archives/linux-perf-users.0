Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE8C1DE2DE;
	Wed, 23 Jul 2025 19:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753297736; cv=none; b=WRpTf1TNoy1Nb+5wcrCSoR4bGNJ75lmDYoTnsE0HMPOobEKI95Ypsoa8wU3SlaBsOxr+UEkhwlbn5w8Ui3NIxN4p7RWZ3VnFbj9e/QdltIpTQWMiT+CUdv/S0XxXe5n+QnCgx7SVp7x8lDj/sh5Dgn/hOFBnT8J7k/5xhyrYZzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753297736; c=relaxed/simple;
	bh=UNlzAOR7cODPZuTeqSmrMKOwWWVj14CXn+8jYD4OLsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBgphV4m6BNYjMU2cCJGwsWCvc5AN0QPuubf2SVwRjSBiuUFAzl4JLu70//OxU1a27lE3Y/Mar6wj6d5dXYjwOsgyNiNDv6bdC40TJ+2i13xXXbTYvenImrhk9uEfwqGaYJ5OIFE/OOWORm9wFCifhqtCf9UBLmYTyWDC32Fvew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPbjb4fO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPbjb4fO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDCEC4CEE7;
	Wed, 23 Jul 2025 19:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753297735;
	bh=UNlzAOR7cODPZuTeqSmrMKOwWWVj14CXn+8jYD4OLsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XPbjb4fOItVYtJw+lyr4SW3fghlW7Il7qIGMKBoHZVKrDbueqqbS5N8sRF18DhpfB
	 O4h5VI+ikJrJYMNlfyeeROBQjQzHdfaZdc/NQyNab7afyrbQzGK+gx9h3iZZu8xt4W
	 /DO4VvUwTcKyOwMhFmHNswLnR7Qa6r7xAD/q8QVf0ZyeA78MI6Pybr4jijEm1Frf2t
	 +g9Pn9c/gH14alUgS58L4IuR/vCBZUnkPYobIDTbOEjb18W8JkSUtclKDD1mnMu+uf
	 hMcqcwYvjMKYX3xdiy5r4gIiZ2bQodRHIcRhNFvTiRWSoj4HyFAiF+X1mLwxTM3+Rg
	 hHS3N+KtC2OSg==
Date: Wed, 23 Jul 2025 16:08:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Gautam Menghani <gautam@linux.ibm.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v7 00/16] New perf ilist app
Message-ID: <aIEzRNLTCTA5Gqhm@x1>
References: <20250714164405.111477-1-irogers@google.com>
 <CAP-5=fW=AG8ztbzS-KXpo9fH_Hp_fkZ3CVDuG9pN7P32Qm0oyg@mail.gmail.com>
 <aIEjMroa3bW-T7d-@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aIEjMroa3bW-T7d-@google.com>

On Wed, Jul 23, 2025 at 11:00:18AM -0700, Namhyung Kim wrote:
> Hi Ian,
> 
> On Wed, Jul 23, 2025 at 08:32:33AM -0700, Ian Rogers wrote:
> > On Mon, Jul 14, 2025 at 9:44 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > This patch series builds up to the addition of a new ilist app written
> > > in python using textual [1] for the UI. The app presents perf PMUs and
> > > events, displays the event information as in `perf list` while at the
> > > bottom of the console showing recent activity of the event in total
> > > and across all CPUs. It also displays metrics, placed in a tree
> > > through their metric group, again with counts being displayed in the
> > > bottom panel.
> > >
> > > The first ground work patches of fixes, cleanup and refactoring were
> > > separated into their own series here:
> > > https://lore.kernel.org/lkml/20250709214029.1769089-1-irogers@google.com/
> > >
> > > The second part of the patches adds event json for the software PMU
> > > and makes the tracepoint PMU support iteration of events and the
> > > like. Without these improvements the tracepoint and software PMUs will
> > > appear to have no events in the ilist app. As the software PMU moves
> > > parsing to json, the legacy hard coded parsing is removed. This has
> > > proven controversial for hardware events and so that cleanup isn't
> > > done here.
> > >
> > > The final patches expand the perf python APIs and add the ilist
> > > command. To run it you need the updated perf.cpython.so in your
> > > PYTHONPATH and then execute the script. Expanding PMUs and then
> > > selecting events will cause event informatin to be displayed in the
> > > top-right and the counters values to be displayed as sparklines and
> > > counts in the bottom half of the screen.
> > >
> > > [1] https://textual.textualize.io/
> > >
> > > v7: Better handle errors in the python code and ignore errors when
> > >     scanning PMU/events in ilist.py, improving the behavior when not
> > >     root. Add a tp_pmu/python clean up. Minor kernel coding style
> > >     clean up. Fix behavior of ilist if a search result isn't found but
> > >     then next is chosen.
> > >
> > > v6: For metrics on hybrid systems don't purely match by name, also
> > >     match the CPU and thread so that if the same metric exists for
> > >     different PMUs the appropriate one is selected and counters may be
> > >     read. Likewise use evsel maps and not the evlists.
> > >
> > > v5: Split the series in two. Add metric support. Various clean ups and
> > >     tweaks to the app in particular around the handling of searches.
> > >
> > > v4: No conflict rebase. Picks up perf-tools-next DRM PMU which
> > >     displays as expected.
> > >
> > > v3: Add a search dialog to the ilist app with 'n'ext and 'p'revious
> > >     keys. No changes in the ground work first 14 patches.
> > >
> > > v2: In the jevents event description duplication, some minor changes
> > >     accidentally missed from v1 meaning that in v1 the descriptions
> > >     were still duplicated. Expand the cover letter with some thoughts
> > >     on the series.
> > >
> > > Ian Rogers (16):
> > >   perf python: Add more exceptions on error paths
> > >   perf jevents: Add common software event json
> > >   perf parse-events: Remove non-json software events
> > >   perf tp_pmu: Factor existing tracepoint logic to new file
> > >   perf tp_pmu: Add event APIs
> > >   perf list: Remove tracepoint printing code
> > >   perf list: Skip ABI PMUs when printing pmu values
> > >   perf python: Improve the tracepoint function if no libtraceevent
> > >   perf python: Add basic PMU abstraction and pmus sequence
> > >   perf python: Add function returning dictionary of all events on a PMU
> > >   perf ilist: Add new python ilist command
> > >   perf python: Add parse_metrics function
> > >   perf python: Add evlist metrics function
> > >   perf python: Add evlist compute_metric
> > >   perf python: Add metrics function
> > >   perf ilist: Add support for metrics
> > 
> > Hi,
> > 
> > Is there any more I can do to get this series landed? I appreciate having:
> > 
> > Tested-by: Gautam Menghani <gautam@linux.ibm.com>
> > 
> > I think there is some follow up for "make install" for scripts like
> > these, but I'm keen for the python API to move forward.
>  
> I'll review the series today so that we can get some part of it, at
> least.  Basically I think we need a wrapper script like perf-ilist to
> run this easily (maybe with documentation).

I just tried, with the series applied:

root@number:~# perf ilist
perf: 'ilist' is not a perf-command. See 'perf --help'.

Did you mean this?
	list
root@number:~#

Now trying to figure out why it is not running.

- Arnaldo
