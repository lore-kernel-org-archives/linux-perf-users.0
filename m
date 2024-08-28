Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5330C1AE040;
	Wed, 28 Aug 2024 20:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724878487; cv=none; b=DFcWLHgzb49driz1TCP5DZ9epSNxTN3OqSaYJAT9fAtumVop3+CDukp2q7d/5T/rNVuVePU50A2C9wIYcMblkgw5DKfM4aq0bUGEBzMHnZOAFX8mpAX69FrkEvWKn/Gmrsusl1c/acDs4i3PsJTUOzM3rgy+yir20Q2VVvcD5vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724878487; c=relaxed/simple;
	bh=SnlJ2b10GpeB/eeD0bQeMJKYa+5VGMkiM/OyO0qSSv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EotSu6VdoaVQevUqkVPV3/zJPKTXtxtgLOSVcS/KN2B9pVz7d7wmT9MkPF2ZNGJ+9r79RgRMXuY64mV9+WEggvH9+7gablwZE3vJkC4jwsvoBxTxiktnecPnrc6VWMro+GY8Ft02D1IXsJE/HCL+zJ0hVNngTsso10w+Y0+5NKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMpVJ1m1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMpVJ1m1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE28CC4CEC0;
	Wed, 28 Aug 2024 20:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724878487;
	bh=SnlJ2b10GpeB/eeD0bQeMJKYa+5VGMkiM/OyO0qSSv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pMpVJ1m1B1D1s/JjTA+nJSk93kCWrD5UISQvcX+6IgL4pB8MwfXMvY+ghZPj/yyPI
	 5acAgLfeJxn0RPNL2vmYhFr1KtV8MCUuJ767926DzNWaRtJjbyKTnasJ1TVnCMsZqe
	 T9XmM/Sw/nvn/25O0z1sQ7Vvbp2RpPDdaDfTwU8B3K83hK9/fNQwtEVDedSy2g8d8Z
	 T2fCXbEiPKhBi/cZTfRnLzFfQEgYoSBu95IQXGIogeSiPh747Kc7y0HSkWLoVGrAh/
	 80uJP4Nz3NpE5v2o2AjZf+JMpdWrKbsr6D0amCN/yLryNLtwUOWh7w7Glzg61R597e
	 rtbmCiM68M1CA==
Date: Wed, 28 Aug 2024 17:53:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf report: Name events in stats for pipe mode
Message-ID: <Zs-OMNr74getypNN@x1>
References: <20240827212757.1469340-1-irogers@google.com>
 <CAM9d7cgoRUzRkwf37BisHV8vKWFD2AY+GJKH+eOqH4HmGBY2Wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cgoRUzRkwf37BisHV8vKWFD2AY+GJKH+eOqH4HmGBY2Wg@mail.gmail.com>

On Wed, Aug 28, 2024 at 10:06:37AM -0700, Namhyung Kim wrote:
> Hi Ian,
> 
> On Tue, Aug 27, 2024 at 2:37 PM Ian Rogers <irogers@google.com> wrote:
> >
> > In stats mode PERF_RECORD_EVENT_UPDATE isn't being handled meaning the
> > evsels aren't named when handling pipe mode output.
> >
> > Before:
> > ```
> > $ perf record -e inst_retired.any -a -o - sleep 0.1|perf report --stats -i -
> > ...
> > Aggregated stats:
> >            TOTAL events:      23358
> >             COMM events:       2608  (11.2%)
> >             EXIT events:          1  ( 0.0%)
> >             FORK events:       2607  (11.2%)
> >           SAMPLE events:        174  ( 0.7%)
> >            MMAP2 events:      17936  (76.8%)
> >             ATTR events:          2  ( 0.0%)
> >   FINISHED_ROUND events:          2  ( 0.0%)
> >         ID_INDEX events:          1  ( 0.0%)
> >       THREAD_MAP events:          1  ( 0.0%)
> >          CPU_MAP events:          1  ( 0.0%)
> >     EVENT_UPDATE events:          3  ( 0.0%)
> >        TIME_CONV events:          1  ( 0.0%)
> >          FEATURE events:         20  ( 0.1%)
> >    FINISHED_INIT events:          1  ( 0.0%)
> > raw 0xc0 stats:
> >           SAMPLE events:        174
> > ```
> >
> > After:
> > ```
> > $ perf record -e inst_retired.any -a -o - sleep 0.1|perf report --stats -i -
> > ...
> > Aggregated stats:
> >            TOTAL events:      23742
> >             COMM events:       2620  (11.0%)
> >             EXIT events:          2  ( 0.0%)
> >             FORK events:       2619  (11.0%)
> >           SAMPLE events:        165  ( 0.7%)
> >            MMAP2 events:      18304  (77.1%)
> >             ATTR events:          2  ( 0.0%)
> >   FINISHED_ROUND events:          2  ( 0.0%)
> >         ID_INDEX events:          1  ( 0.0%)
> >       THREAD_MAP events:          1  ( 0.0%)
> >          CPU_MAP events:          1  ( 0.0%)
> >     EVENT_UPDATE events:          3  ( 0.0%)
> >        TIME_CONV events:          1  ( 0.0%)
> >          FEATURE events:         20  ( 0.1%)
> >    FINISHED_INIT events:          1  ( 0.0%)
> > inst_retired.any stats:
> >           SAMPLE events:        165
> > ```
> >
> > This makes the pipe output match the regular output.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next,

- Arnaldo
