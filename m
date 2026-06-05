Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF1013D539;
	Fri,  5 Jun 2026 23:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780702294; cv=none; b=moFLP3vbbTciEAFCd0+c/KXVI3qUaQ4g45KWWkicOu5BsAikC0auHB8KM31VkBvj7rz4VKOFnPHJxgKiCeNDh+qYmtKZR0P5mOGEg48aghEbI0k6XfF2Cj87VAd3zzhNyJ5dqdLx2vkojetGcn9vRaVtEgtx+BMP6WGTc2QFNZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780702294; c=relaxed/simple;
	bh=c8rNDvtpEOf3IBsIuC/QN9I1rZebXZWZ3qWW4EFXiTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1agLbjeJKSWp1A4k63lCBNuiiUMUjxbAUzcTLBhG3IbQe3Oxopsy2ZzlW7jofi8IDrcsdfEVP5TsTt/WPyltbxSxFxcwkeEtSc4fxbVLTu9h/LQ87x8Bquvyy0/oaXYki8o/AnArvFTfrBdnfIp97KFtV4S9W/M9x/ca+oSvY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vn3uWF5/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vn3uWF5/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6174A1F00893;
	Fri,  5 Jun 2026 23:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780702293;
	bh=+T4la7Cwb5ve4W+rYcoElaBW74XoqRVN+QoYeqFEe50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vn3uWF5/VUCcwRwKukDHHQels9fZlXvZUPbwzcjXk2A7RSAcuKrQI9WRJCgKO+jOI
	 mErO7RYKwLI3sPUl5n5iyqSuCOJz1RzkVOxBb/3zeR/rIqFSukVk0pd5Yo2TEzKO3z
	 e0M/2/BtVKOoOBJo93M87vHl49hLDjtZniMNpn2KxA80JgBgDQeD6Vj2Bx1RlbN164
	 nohvWCq6sj8oyBX94Ip8MZ/S31hbhkvtO+ydh5sn+qqIyJ4Sjh++k+dOkn/Q5qgMTq
	 DHDWGTIi7pqogbeaFux4NhnZWQODIBOCpI3ujBPDdNKOsCXC61Zc6lzzF+PHvEWE5s
	 sKjGRtv1yNFYA==
Date: Fri, 5 Jun 2026 16:31:32 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/4] perf timechart: Release event samples at the end
Message-ID: <aiNcVPMpx-WJYukY@google.com>
References: <20260605231155.2415760-1-namhyung@kernel.org>
 <20260605231155.2415760-2-namhyung@kernel.org>
 <aiNaDclowc8qm2Qs@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aiNaDclowc8qm2Qs@x1>

On Fri, Jun 05, 2026 at 08:21:49PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Jun 05, 2026 at 04:11:52PM -0700, Namhyung Kim wrote:
> > Add timechart__release() to free all data structures added during the
> > sample processing.
> > 
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/builtin-timechart.c | 54 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> > 
> > diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
> > index 04dbb944a42720b4..7c4ace51302e260c 100644
> > --- a/tools/perf/builtin-timechart.c
> > +++ b/tools/perf/builtin-timechart.c
> > @@ -1548,6 +1548,59 @@ static void write_svg_file(struct timechart *tchart, const char *filename)
> >  	svg_close();
> >  }
> >  
> > +static void timechart__release(struct timechart *tchart)
> > +{
> > +	struct per_pid *p = tchart->all_data;
> > +	struct power_event *pwr = tchart->power_events;
> > +	struct wake_event *we = tchart->wake_events;
> > +
> > +	while (p) {
> > +		struct per_pid *next_pid = p->next;
> > +		struct per_pidcomm *c = p->all;
> > +
> > +		while (c) {
> > +			struct per_pidcomm *next_comm = c->next;
> > +			struct cpu_sample *cs = c->samples;
> > +			struct io_sample *ios = c->io_samples;
> > +
> > +			while (cs) {
> > +				struct cpu_sample *next = cs->next;
> > +
> > +				free((char *)cs->backtrace);
> 
> 				zfree()? This way if somebody has a
> 				pointer to cs and tries to use
> 				cs->backtrace after this free, it will
> 				segfault instead of using garbage or
> 				worse, setting some other unrelated
> 				struct to some cpu_sample field supposed
> 				value.

Ok, will do here and others below.

Thanks,
Namhyung

> 
> > +				free(cs);
> > +				cs = next;
> > +			}
> > +
> > +			while (ios) {
> > +				struct io_sample *next = ios->next;
> > +
> > +				free(ios);
> 
> 				io->next = NULL;
> 
> > +				ios = next;
> > +			}
> > +
> > +			free(c->comm);
> 
> 			zfree
> 
> > +			free(c);
> > +			c = next_comm;
> > +		}
> > +		p = next_pid;
> > +	}
> > +
> > +	while (pwr) {
> > +		struct power_event *next = pwr->next;
> > +
> > +		free(pwr);
> 		pwr->next = NULL;
> > +		pwr = next;
> > +	}
> > +
> > +	while (we) {
> > +		struct wake_event *next = we->next;
> > +
> > +		free((char *)we->backtrace);
> 		zfree
> > +		free(we);
> > +		we = next;
> > +	}
> > +}
> > +
> >  static int process_header(struct perf_file_section *section __maybe_unused,
> >  			  struct perf_header *ph,
> >  			  int feat,
> > @@ -2079,6 +2132,7 @@ int cmd_timechart(int argc, const char **argv)
> >  
> >  	ret = __cmd_timechart(&tchart, output_name);
> >  out:
> > +	timechart__release(&tchart);
> >  	zfree(&cpus_cstate_start_times);
> >  	zfree(&cpus_cstate_state);
> >  	zfree(&cpus_pstate_start_times);
> > -- 
> > 2.54.0.1032.g2f8565e1d1-goog
