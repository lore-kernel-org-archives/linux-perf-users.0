Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0953403E3;
	Fri, 31 Jul 2026 23:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785539675; cv=none; b=t6F4clfYGOrAVDQ5Bup172jfSsyCStp3xOd3SP0gmgOn0H636gQ2Wx77hloG0KmHryTEbuGw+NDQHQ2Ia09TM0cyjnpR4bbhqfl8LJ5E+rNMw4t4PXVGpqQ9hnh03AmGicWjxoxRzQVhc0q0wS7jY9+QZthXVE5Uy4N9Vo79R5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785539675; c=relaxed/simple;
	bh=frmXFHISx3J9POOKNWtj3GT1Gi4FdNVxJRxhhu9uFF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTKNFJPp+fi7ZvD4LKYPuB2pM073gvQNQ4+Nng56dYKq1EKGrodr82Xwny8+wbYQuldAjgBLELYrW7gZ2FvGBaAATaYzbmhNFoZcaCyTvTtEUk9s3SQZzvL0qo6FQ7W8QlELZqgeC2Ry3qpLnTcA+nlfRjDPV2NVdyogzuZIRDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHJsapy+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHJsapy+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41041F00AC4;
	Fri, 31 Jul 2026 23:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785539673;
	bh=YdgbdPr6O8WLJ54bYu+p4qh73i0xz79qK3lKFm5rsPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GHJsapy+Nzcpu1zM2TzM2fzJ4O8fvcOltxlkT/o1VWpbMCfvOncftQkt2aFcT4NIP
	 E/ULI/SYGP9wXmC5ai1ZOP/fpffQ7ZLFDUjopTqi5zWrI+rPtaDJJGS5sDwMk2Uo2L
	 hEl7WCpSMG1A4KyV4+H8zKLDXOCawX/P98Lyd+/R+IdoOlL0p8U4k6Y+bhgGzWt+fj
	 C31XFTO4FSa9Mh7kHSJTJHkiXqY7wXLqQZB8RBJVYoD9wXz4VVF4TArVGr5ivLl1O7
	 5J7SZfvCb44uHAA+XCcDD/R+E6JSCspFqSrJu6V/gPA2Xz6fQfuVLtHGTWf8vzn9+B
	 /FF702OeigjWw==
Date: Fri, 31 Jul 2026 16:14:32 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Chun-Tse Shao <ctshao@google.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3] perf stat: Include PMU name and split uncore events
 per PMU in metric-only JSON output
Message-ID: <am0sWLrB5tNyTJQK@google.com>
References: <20260729170416.41904-1-ctshao@google.com>
 <20260729171742.24ABB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260729171742.24ABB1F000E9@smtp.kernel.org>

On Wed, Jul 29, 2026 at 05:17:41PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Flawed line-split transition logic causes spurious empty JSON objects and incorrect PMU attribution for tool events.
> --
> 
> --- Patch [1]: [PATCH v3] perf stat: Include PMU name and split uncore events per PMU in metric-only JSON output ---
> commit 20e3cd08fd5e415b458343262ee76bc1f5f6ce85
> Author: Chun-Tse Shao <ctshao@google.com>
> 
> perf stat: Include PMU name and split uncore events per PMU in metric-only JSON output
> 
> This commit modifies perf stat JSON output in --metric-only and -A mode to
> group metrics by PMU. It achieves this by adding a "pmu" key to the JSON
> output and starting a new JSON line when the underlying PMU instance changes.
> 
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > index b337cc23f4131..6785e2c442bd7 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> 
> [ ... ]
> 
> > @@ -1146,13 +1149,34 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
> >  				if (config->aggr_map->map[aggr_idx].cpu.cpu == cpu.cpu)
> >  					break;
> >  			}
> > +			if (aggr_idx >= config->aggr_map->nr)
> > +				continue;
> >  
> >  			os->evsel = counter;
> >  			os->id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
> > -			if (first) {
> > -				print_metric_begin(config, evlist, os, aggr_idx);
> > -				first = false;
> > +
> > +			if (config->metric_only) {
> > +				struct perf_pmu *pmu = counter->pmu;
> > +
> > +				if (!evsel__is_tool(counter)) {
> > +					if (config->json_output && line_open &&
> > +					    (!last_pmu || pmu != last_pmu)) {
> 
> [Severity: Medium]
> Does this line-split transition logic handle tool events correctly depending
> on their order in the event list?
> 
> If a tool event is processed first, line_open becomes true, but last_pmu
> remains NULL. When the next event (a PMU event) is processed, the condition
> (!last_pmu || pmu != last_pmu) evaluates to true. This prematurely closes
> the line and creates a spurious empty JSON object for the tool event.

Something like this?

  $ sudo ./perf stat -aA -e user_time -M insn_per_cycle -j --metric-only true
  {"cpu" : "0", "pmu" : "tool"}
  {"cpu" : "0", "pmu" : "cpu_core", "instructions  insn_per_cycle" : "0.8"}
  {"cpu" : "1", "pmu" : "tool"}
  {"cpu" : "1", "pmu" : "cpu_core", "instructions  insn_per_cycle" : "0.1"}
  {"cpu" : "2", "pmu" : "tool"}
  {"cpu" : "2", "pmu" : "cpu_core", "instructions  insn_per_cycle" : "0.5"}
  {"cpu" : "3", "pmu" : "tool"}
  {"cpu" : "3", "pmu" : "cpu_core", "instructions  insn_per_cycle" : "0.3"}
  ...

Thanks,
Namhyung

> 
> Conversely, if a tool event comes after a PMU event, the else-if block below
> is taken because !evsel__is_tool(counter) evaluates to false. This bypasses
> the line-splitting check entirely, causing the tool event to silently merge
> into the preceding PMU's JSON object and incorrectly inherit its PMU
> attribution.
> 
> > +						print_metric_end(config, os);
> > +						line_open = false;
> > +					}
> > +					if (!line_open) {
> > +						print_metric_begin(config, evlist, os,
> > +								   aggr_idx, counter);
> > +						line_open = true;
> > +					}
> > +					last_pmu = pmu;
> > +				} else if (!line_open) {
> > +					print_metric_begin(config, evlist, os,
> > +							   aggr_idx, counter);
> > +					line_open = true;
> > +				}
> >  			}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260729170416.41904-1-ctshao@google.com?part=1
