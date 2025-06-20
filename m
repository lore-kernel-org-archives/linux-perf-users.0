Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB9B221DAC;
	Fri, 20 Jun 2025 22:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750457526; cv=none; b=u3DH0l1A66G4zJk6gT0jyR9my5XtRMM1x8KB54Rd5a+fkRWUj2ujmKe+wLWFCf95ZxlS/V5AaSnyHMEUyo9kqLcq+kKjE2CJN3YAv5A5POXq2K8akyYmKD1QT0FH0euZFTEniVJ3K72fTQrU0UO0OA/cokmOoMfireXL5t1nzqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750457526; c=relaxed/simple;
	bh=wTDpmuMLI1jmsJXs5SO5HcqWlMfheX5Tl55J4mYQJRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvgUW4wXZSt+WGGOop1el3llgEAs2nyu8Q6Rm3xMZr5QAaHwBoQ3Q/HUVRVPF0eGV7OO4r8lEgpGYq1FeqFwXsIaqNoLn57t9KIsV82lXgf9b8sJTJ7nkew06b5hOCgpqOmVtj5kSG4uvSdMmge8Q7Zdf/uqqh9L4gaepbb5Jdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LojU7jDA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LojU7jDA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69F6C4CEE3;
	Fri, 20 Jun 2025 22:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750457526;
	bh=wTDpmuMLI1jmsJXs5SO5HcqWlMfheX5Tl55J4mYQJRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LojU7jDABaRMMIPyJ1x620YVNRDj3CBPbmanfnRiqAVo1tsK9zYH5OCl4kfRBPQUM
	 IVvI86KRUFedOD0RCqXjoaGve4iZyNJ4TeLvF6L4ET8dRPFWMn6qFErAJx44XX6xi+
	 Pk2uadCXq1VfRvf0/N0uLFHErkb8i4YhNiLih/Vz4O99SERJI8qI1t1twkWAlrJkPj
	 3I3gnvUyZOCbLO3qdbI8lVukAXoxM8OpGI2+78pdgDaqxXxj86g+N0cAztCLxiPPVu
	 kbuMOZAWRbegqTG/avGqFka1ZM8nQgIV09ZY+KXzDq+L/eM/3FTLpXEo1OO4KhwzFm
	 bbe2yPdI/XPPA==
Date: Fri, 20 Jun 2025 15:12:04 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1] perf stat: Fix uncore aggregation number
Message-ID: <aFXctF683XlLmiRy@google.com>
References: <20250611233239.3098064-1-ctshao@google.com>
 <CAP-5=fXyB3H-msiSUGH_XqOntJNv-A2X7DtjvZO=nLzJgdTY+A@mail.gmail.com>
 <CAJpZYjVxs3yAS1-Uj_aQjkHGo+hRkHnwCbWxNsS4pT50-rvRPg@mail.gmail.com>
 <CAP-5=fWvnALUJiHrb_xzHXjseD88HF7LExs4N_Okg+UguuXsXg@mail.gmail.com>
 <CAJpZYjWUUbnNyBYXNSu_mmUrYLhNHHmdro8r08Xe0tN7nAanxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJpZYjWUUbnNyBYXNSu_mmUrYLhNHHmdro8r08Xe0tN7nAanxg@mail.gmail.com>

Hi CT,

On Thu, Jun 12, 2025 at 03:55:59PM -0700, Chun-Tse Shao wrote:
> Hi Ian, I actually renamed it to `aggr_nr` in v2 patch so it should be
> better aligned to json mode, which is using `aggregate-nunber`. But
> anyway I think any name other than `cpus` is better.
> v2 patch: lore.kernel.org/20250612225324.3315450-1-ctshao@google.com

I think "aggregation-count" is a better name, maybe abbreviated to
"ag_cnt".  Can we rename the JSON as well?  I'm not sure if it's
documented somewhere.

Thanks,
Namhyung

> 
> 
> On Wed, Jun 11, 2025 at 10:12 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Wed, Jun 11, 2025 at 8:18 PM Chun-Tse Shao <ctshao@google.com> wrote:
> > >
> > > Thanks for your test, Ian!
> > >
> > > I wonder if `nr_pmus` makes sense, since the column would be shared
> > > with multiple different pmus. WDYT?
> >
> > So each PMU in sysfs has a cpumask that specifies which CPUs perf
> > should pass to perf_event_open. For example, on a two socket machine
> > the cpumask will typically have the first CPU of each socket. If the
> > cpumask (or cpus) file isn't present then the cpumask is implicitly
> > all online CPUs. Given that the aggregation number is the number of
> > CPUs in the cpumask multiplied by the number of PMUs, I think the most
> > neutral name is probably "counters" possibly shortened down to "ctrs".
> > I suspect others have better suggestions :-)
> >
> > Thanks,
> > Ian
> >
> > > -CT
> > >
> > > On Wed, Jun 11, 2025 at 5:16 PM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > On Wed, Jun 11, 2025 at 4:36 PM Chun-Tse Shao <ctshao@google.com> wrote:
> > > > >
> > > > > Follow up:
> > > > > lore.kernel.org/CAP-5=fVDF4-qYL1Lm7efgiHk7X=_nw_nEFMBZFMcsnOOJgX4Kg@mail.gmail.com/
> > > > >
> > > > > The patch adds unit aggregation during evsel merge the aggregated uncore
> > > > > counters.
> > > > >
> > > > > Tested on a 2-socket machine with SNC3, uncore_imc_[0-11] and
> > > > > cpumask="0,120"
> > > > > Before:
> > > > >   perf stat -e clockticks -I 1000 --per-socket
> > > > >   #           time socket cpus             counts unit events
> > > > >        1.001085024 S0        1         9615386315      clockticks
> > > > >        1.001085024 S1        1         9614287448      clockticks
> > > > >   perf stat -e clockticks -I 1000 --per-node
> > > > >   #           time node   cpus             counts unit events
> > > > >        1.001029867 N0        1         3205726984      clockticks
> > > > >        1.001029867 N1        1         3205444421      clockticks
> > > > >        1.001029867 N2        1         3205234018      clockticks
> > > > >        1.001029867 N3        1         3205224660      clockticks
> > > > >        1.001029867 N4        1         3205207213      clockticks
> > > > >        1.001029867 N5        1         3205528246      clockticks
> > > > > After:
> > > > >   perf stat -e clockticks -I 1000 --per-socket
> > > > >   #           time socket cpus             counts unit events
> > > >
> > > > I wonder if there is a better column heading than "cpus" given that
> > > > these are imc PMUs.
> > > >
> > > > >        1.001022937 S0       12         9621463177      clockticks
> > > > >        1.001022937 S1       12         9619804949      clockticks
> > > > >   perf stat -e clockticks -I 1000 --per-node
> > > > >   #           time node   cpus             counts unit events
> > > > >        1.001029867 N0        4         3206782080      clockticks
> > > > >        1.001029867 N1        4         3207025354      clockticks
> > > > >        1.001029867 N2        4         3207067946      clockticks
> > > > >        1.001029867 N3        4         3206871733      clockticks
> > > > >        1.001029867 N4        4         3206199005      clockticks
> > > > >        1.001029867 N5        4         3205525058      clockticks
> > > > >
> > > > > Suggested-by: Ian Rogers <irogers@google.com>
> > > > > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > >
> > > Added Namhyung's ack from the previous email.
> > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > >
> > > >
> > > > Tested-by: Ian Rogers <irogers@google.com>
> > > >
> > > > Thanks,
> > > > Ian
> > > >
> > > > > ---
> > > > >  tools/perf/util/stat.c | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> > > > > index 355a7d5c8ab8..52266d773353 100644
> > > > > --- a/tools/perf/util/stat.c
> > > > > +++ b/tools/perf/util/stat.c
> > > > > @@ -527,6 +527,7 @@ static int evsel__merge_aggr_counters(struct evsel *evsel, struct evsel *alias)
> > > > >                 struct perf_counts_values *aggr_counts_b = &ps_b->aggr[i].counts;
> > > > >
> > > > >                 /* NB: don't increase aggr.nr for aliases */
> > > > > +               ps_a->aggr[i].nr += ps_b->aggr[i].nr;
> > > > >
> > > > >                 aggr_counts_a->val += aggr_counts_b->val;
> > > > >                 aggr_counts_a->ena += aggr_counts_b->ena;
> > > > > --
> > > > > 2.50.0.rc1.591.g9c95f17f64-goog
> > > > >
