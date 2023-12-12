Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E9E7D8AD
	for <linux-perf-users@vger.kernel.org>; Tue, 12 Dec 2023 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oW+oYDoE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DBEC433C8;
	Tue, 12 Dec 2023 18:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702404288;
	bh=nk//IozMK5UtGAQ/gn7b/tWhhxOCqLkulLRTpbFg1zQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oW+oYDoEzayjqebiyy/C7FhsvKbOlDvGllnGrDnx6jqmjPnx63vvu9RHSIaPJ5qYs
	 pG8djXTEAmorTUJFzOi4mft4v07TwgfHvHEpLX5VDbT/p8QkeFe9EBxWlfzparAUz/
	 OofwMCMIbZgd88mr/MmmADAaV5bPBadPQGqmPNIRj3D/q7kZVIFPE4BISJUHGOE/Rc
	 LX5MFFEklOfJipYZI70Xyp3s4C5eGMog4vH+VatH1C/g59YmJ+9WZJzKUudmijFU9A
	 ca3Lee5jIqjBhhDuP7mQcUw5LqfPep6MLc1kLL+W/qlOw2pjishkzUQiCODmHQjOLT
	 yNmos7nQPwCwQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id C5850403EF; Tue, 12 Dec 2023 15:04:43 -0300 (-03)
Date: Tue, 12 Dec 2023 15:04:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1] perf stat: Fix help message for --metric-no-threshold
 option
Message-ID: <ZXigu8c0ee0u4uI/@kernel.org>
References: <20231129223540.2247030-1-irogers@google.com>
 <CAP-5=fXeZpOg7cHDZmTLvQh=FTamvpdw+=q9vcqrUBd9v7ifLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXeZpOg7cHDZmTLvQh=FTamvpdw+=q9vcqrUBd9v7ifLQ@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Mon, Dec 11, 2023 at 11:39:02AM -0800, Ian Rogers escreveu:
> On Wed, Nov 29, 2023 at 2:36 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Copy-paste error led to help message for metric-no-threshold repeating
> > that of metric-no-merge.
> >
> > Reported-by: Stephane Eranian <eranian@google.com>
> > Fixes: 1fd09e299bdd ("perf metric: Add --metric-no-threshold option")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Ping. Thanks,
> Ian

This is in perf-tools-next now.

- Arnaldo
 
> > ---
> >  tools/perf/builtin-stat.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index a3af805a1d57..c77a3308d3fb 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -1255,7 +1255,7 @@ static struct option stat_options[] = {
> >         OPT_BOOLEAN(0, "metric-no-merge", &stat_config.metric_no_merge,
> >                        "don't try to share events between metrics in a group"),
> >         OPT_BOOLEAN(0, "metric-no-threshold", &stat_config.metric_no_threshold,
> > -                      "don't try to share events between metrics in a group  "),
> > +                      "disable adding events for the metric threshold calculation"),
> >         OPT_BOOLEAN(0, "topdown", &topdown_run,
> >                         "measure top-down statistics"),
> >         OPT_UINTEGER(0, "td-level", &stat_config.topdown_level,
> > --
> > 2.43.0.rc1.413.gea7ed67945-goog
> >

-- 

- Arnaldo
