Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890151B393C;
	Mon, 23 Jun 2025 23:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750721503; cv=none; b=VO+0ItPApNfxsfenfyNufj7M7APiD+Vi07/0LP2n/3srmchrj7FleLGmYXhZjWTi1U8CAaP6cTKsHW0DYXDeB0WMiE0cU2wyX8PH/1kPygqIGcbFNPPcwo9aWXoh2KQJlBb03botz5ug4fLjF8ygxor6eFz/WBFIfyMD/6oHLiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750721503; c=relaxed/simple;
	bh=Zuh/gcIk+FkXHDdGTg0VBN2dgCXLH7vihqYFVQI5HoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+xlnYrpX5T+88Um4cKkJHTe3AWdErSsVqvYgqs4VgxJTNF9S9aws5sj/nxv/gEng+Sw+uhaGxfdP+Asu3aflwQJqoaMinO/bXqrUEHg1tKphcuDGJLRx6Ka76EFmbYSu1osHSWaCdAevtCWTRVgZ5wIwnWRqn0V0Z3+5jyi8zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbFlZyoS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbFlZyoS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29BCC4CEEA;
	Mon, 23 Jun 2025 23:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750721501;
	bh=Zuh/gcIk+FkXHDdGTg0VBN2dgCXLH7vihqYFVQI5HoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hbFlZyoSJXRwYwrGw5rfEldiW1a5/SwDOSKBL67cAV2SJioimtZBmMUXJGpUcvWvL
	 ZD5xDQlGK1Lv945xTJOpYqvL+kbqTCPkmbmyczfukQi1RJbEH2xBu745qQjuAbyNtG
	 t5ypkEdt8avjs/AxNk9LNAB7NOMju7mBQdkk4C2R1TX/ONiAAvX4TQ7XxCnMuku9WW
	 guPfSEQMSsfmOnYZZLJjWMEI619veCbPvMdfjC4KLf2uMVkBMqqqdAPzrIJkAVZyh+
	 BU8MQHFniD6Lmm5b/ib9oSWfmNVU93duZxAT/LnN6t8Ch3eH1DREFWUTawHAVsncnY
	 bJKj2TtCHYj/A==
Date: Mon, 23 Jun 2025 16:31:39 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org,
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1] perf stat: Fix uncore aggregation number
Message-ID: <aFnj29spuj3mKZLc@google.com>
References: <20250611233239.3098064-1-ctshao@google.com>
 <CAP-5=fXyB3H-msiSUGH_XqOntJNv-A2X7DtjvZO=nLzJgdTY+A@mail.gmail.com>
 <CAJpZYjVxs3yAS1-Uj_aQjkHGo+hRkHnwCbWxNsS4pT50-rvRPg@mail.gmail.com>
 <CAP-5=fWvnALUJiHrb_xzHXjseD88HF7LExs4N_Okg+UguuXsXg@mail.gmail.com>
 <CAJpZYjWUUbnNyBYXNSu_mmUrYLhNHHmdro8r08Xe0tN7nAanxg@mail.gmail.com>
 <aFXctF683XlLmiRy@google.com>
 <CAP-5=fW39O4=fu4CkcZSJWMA-5gkPaixGhWZecqMnrQt_vYsCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW39O4=fu4CkcZSJWMA-5gkPaixGhWZecqMnrQt_vYsCg@mail.gmail.com>

On Mon, Jun 23, 2025 at 11:17:20AM -0700, Ian Rogers wrote:
> On Fri, Jun 20, 2025 at 3:12 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi CT,
> >
> > On Thu, Jun 12, 2025 at 03:55:59PM -0700, Chun-Tse Shao wrote:
> > > Hi Ian, I actually renamed it to `aggr_nr` in v2 patch so it should be
> > > better aligned to json mode, which is using `aggregate-nunber`. But
> > > anyway I think any name other than `cpus` is better.
> > > v2 patch: lore.kernel.org/20250612225324.3315450-1-ctshao@google.com
> >
> > I think "aggregation-count" is a better name, maybe abbreviated to
> > "ag_cnt".  Can we rename the JSON as well?  I'm not sure if it's
> > documented somewhere.
> 
> Fwiw, I still think "counters" is a clearer, more intention revealing
> definition than "aggregation count" or "aggregation number". The term
> counter appears in the perf-stat and perf_event_open man page. In the
> perf-stat man page we have a pattern of:
> 
>        --per-XXX
>            Aggregate counts per XXX for system-wide mode measurements. This is a
>            useful mode to .... To enable this mode, use --per-XXX
>            in addition to -a. (system-wide). The output includes the ...
>           This is useful to gauge the amount of aggregation.
> 
> It seems that the aggregated value of the counters could be confused
> for being an "aggregation count" or "aggregation number" given the man
> page definition. I think "counters" to some extent avoids this, we
> giving the number of counters aggregated. The perf-stat man page could
> certainly be clearer :-)

I'm fine with "counters" (and "ctrs").

Thanks,
Namhyung

> > >
> > > On Wed, Jun 11, 2025 at 10:12 PM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > On Wed, Jun 11, 2025 at 8:18 PM Chun-Tse Shao <ctshao@google.com> wrote:
> > > > >
> > > > > Thanks for your test, Ian!
> > > > >
> > > > > I wonder if `nr_pmus` makes sense, since the column would be shared
> > > > > with multiple different pmus. WDYT?
> > > >
> > > > So each PMU in sysfs has a cpumask that specifies which CPUs perf
> > > > should pass to perf_event_open. For example, on a two socket machine
> > > > the cpumask will typically have the first CPU of each socket. If the
> > > > cpumask (or cpus) file isn't present then the cpumask is implicitly
> > > > all online CPUs. Given that the aggregation number is the number of
> > > > CPUs in the cpumask multiplied by the number of PMUs, I think the most
> > > > neutral name is probably "counters" possibly shortened down to "ctrs".
> > > > I suspect others have better suggestions :-)
> > > >
> > > > Thanks,
> > > > Ian
> > > >
> > > > > -CT
> > > > >
> > > > > On Wed, Jun 11, 2025 at 5:16 PM Ian Rogers <irogers@google.com> wrote:
> > > > > >
> > > > > > On Wed, Jun 11, 2025 at 4:36 PM Chun-Tse Shao <ctshao@google.com> wrote:
> > > > > > >
> > > > > > > Follow up:
> > > > > > > lore.kernel.org/CAP-5=fVDF4-qYL1Lm7efgiHk7X=_nw_nEFMBZFMcsnOOJgX4Kg@mail.gmail.com/
> > > > > > >
> > > > > > > The patch adds unit aggregation during evsel merge the aggregated uncore
> > > > > > > counters.
> > > > > > >
> > > > > > > Tested on a 2-socket machine with SNC3, uncore_imc_[0-11] and
> > > > > > > cpumask="0,120"
> > > > > > > Before:
> > > > > > >   perf stat -e clockticks -I 1000 --per-socket
> > > > > > >   #           time socket cpus             counts unit events
> > > > > > >        1.001085024 S0        1         9615386315      clockticks
> > > > > > >        1.001085024 S1        1         9614287448      clockticks
> > > > > > >   perf stat -e clockticks -I 1000 --per-node
> > > > > > >   #           time node   cpus             counts unit events
> > > > > > >        1.001029867 N0        1         3205726984      clockticks
> > > > > > >        1.001029867 N1        1         3205444421      clockticks
> > > > > > >        1.001029867 N2        1         3205234018      clockticks
> > > > > > >        1.001029867 N3        1         3205224660      clockticks
> > > > > > >        1.001029867 N4        1         3205207213      clockticks
> > > > > > >        1.001029867 N5        1         3205528246      clockticks
> > > > > > > After:
> > > > > > >   perf stat -e clockticks -I 1000 --per-socket
> > > > > > >   #           time socket cpus             counts unit events
> > > > > >
> > > > > > I wonder if there is a better column heading than "cpus" given that
> > > > > > these are imc PMUs.
> > > > > >
> > > > > > >        1.001022937 S0       12         9621463177      clockticks
> > > > > > >        1.001022937 S1       12         9619804949      clockticks
> > > > > > >   perf stat -e clockticks -I 1000 --per-node
> > > > > > >   #           time node   cpus             counts unit events
> > > > > > >        1.001029867 N0        4         3206782080      clockticks
> > > > > > >        1.001029867 N1        4         3207025354      clockticks
> > > > > > >        1.001029867 N2        4         3207067946      clockticks
> > > > > > >        1.001029867 N3        4         3206871733      clockticks
> > > > > > >        1.001029867 N4        4         3206199005      clockticks
> > > > > > >        1.001029867 N5        4         3205525058      clockticks
> > > > > > >
> > > > > > > Suggested-by: Ian Rogers <irogers@google.com>
> > > > > > > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > > > >
> > > > > Added Namhyung's ack from the previous email.
> > > > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > > > >
> > > > > >
> > > > > > Tested-by: Ian Rogers <irogers@google.com>
> > > > > >
> > > > > > Thanks,
> > > > > > Ian
> > > > > >
> > > > > > > ---
> > > > > > >  tools/perf/util/stat.c | 1 +
> > > > > > >  1 file changed, 1 insertion(+)
> > > > > > >
> > > > > > > diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> > > > > > > index 355a7d5c8ab8..52266d773353 100644
> > > > > > > --- a/tools/perf/util/stat.c
> > > > > > > +++ b/tools/perf/util/stat.c
> > > > > > > @@ -527,6 +527,7 @@ static int evsel__merge_aggr_counters(struct evsel *evsel, struct evsel *alias)
> > > > > > >                 struct perf_counts_values *aggr_counts_b = &ps_b->aggr[i].counts;
> > > > > > >
> > > > > > >                 /* NB: don't increase aggr.nr for aliases */
> > > > > > > +               ps_a->aggr[i].nr += ps_b->aggr[i].nr;
> > > > > > >
> > > > > > >                 aggr_counts_a->val += aggr_counts_b->val;
> > > > > > >                 aggr_counts_a->ena += aggr_counts_b->ena;
> > > > > > > --
> > > > > > > 2.50.0.rc1.591.g9c95f17f64-goog
> > > > > > >
