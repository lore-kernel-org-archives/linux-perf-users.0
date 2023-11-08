Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055673716F
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Nov 2023 20:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gq27cz8F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F27C433C8;
	Wed,  8 Nov 2023 20:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699475296;
	bh=t2wkPp2Vs78dHpqWNnQ62crdG070EJq2PdUHA/sZq5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gq27cz8FBuKkRvY63gCVj14x21GHyZhCUFsB7G7LpqJZU6kjDjcNdN6505BjGwB83
	 y/WB2+tC7HzBN8qjBe72+EHD+lP//ronri4AjDqXRD1m8TASKW29p2EmxXrgjN/H2N
	 mWHysfYAChqlrcuAebNJ6S4/jiNC7zNwbEd1xJpu8qohUAYmYaWNzG2n7XbkzhT3ol
	 tsNxbUajr+JKBvYa2fswHvRpeD34YrrZWLEEN0ZbYQKtlzajZqpo+Pp5wRf6kizXio
	 Hp+6H1BDQOTIyj4uiXb1n5bt5GPAlbsbC3DH7HFGs+Bafl9UIYsxkwy20iEq55Ipdc
	 KchJ10W0ZHlnA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 627124035D; Wed,  8 Nov 2023 17:28:14 -0300 (-03)
Date: Wed, 8 Nov 2023 17:28:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Nick Forrington <nick.forrington@arm.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 2/2] perf lock info: Enforce exactly one of --map and
 --thread
Message-ID: <ZUvvXhkY+NcSxaJU@kernel.org>
References: <20231031120526.11502-1-nick.forrington@arm.com>
 <20231031120526.11502-3-nick.forrington@arm.com>
 <ZUEfXU34ZijKe8aA@kernel.org>
 <3ae2cf90-b0a1-5f54-56aa-ed4a04dca8b0@arm.com>
 <CAM9d7cjQs0BrFAMa4=PGxxPBoGOAVzermH=0HrA1rhegmAA8zg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cjQs0BrFAMa4=PGxxPBoGOAVzermH=0HrA1rhegmAA8zg@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Wed, Nov 01, 2023 at 11:00:42PM -0700, Namhyung Kim escreveu:
> On Wed, Nov 1, 2023 at 7:35 AM Nick Forrington <nick.forrington@arm.com> wrote:
> >
> >
> > On 31/10/2023 15:38, Arnaldo Carvalho de Melo wrote:
> > > Em Tue, Oct 31, 2023 at 12:05:25PM +0000, Nick Forrington escreveu:
> > >> Improve error reporting for command line arguments.
> > >>
> > >> Display error/usage if neither --map or --thread are specified (rather
> > >> than a non user-friendly error "Unknown type of information").
> > >>
> > >> Display error/usage if both --map and --thread are specified (rather
> > >> than ignoring "--map" and displaying only thread information).
> > > Shouldn't one of them be the default so that we type less for the most
> > > common usage?
> > >
> > > - Arnaldo
> > >
> >
> > There isn't an obvious choice (to me) for which would be the default.
> >
> > Both options display completely different data/outputs, so I think it
> > makes sense to be explicit about which data is requested.
> 
> Maybe we can default to display both. :)

Yeah, that would be a better approach, I think.

- Arnaldo
 
> Thanks,
> Namhyung
> 
> >
> >
> > An alternative could be to use sub-commands e.g. "perf lock info
> > threads" or just "perf lock threads", although changing the existing
> > options would be more disruptive.
> >
> >
> > Cheers,
> > Nick
> >
> > >> Signed-off-by: Nick Forrington <nick.forrington@arm.com>
> > >> ---
> > >>   tools/perf/builtin-lock.c | 25 +++++++++++++++++++++++++
> > >>   1 file changed, 25 insertions(+)
> > >>
> > >> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> > >> index 3aa8ba5ad928..cf29f648d291 100644
> > >> --- a/tools/perf/builtin-lock.c
> > >> +++ b/tools/perf/builtin-lock.c
> > >> @@ -2021,6 +2021,27 @@ static int check_lock_report_options(const struct option *options,
> > >>      return 0;
> > >>   }
> > >>
> > >> +static int check_lock_info_options(const struct option *options,
> > >> +                               const char * const *usage)
> > >> +{
> > >> +    if (!info_map && !info_threads) {
> > >> +            pr_err("Requires one of --map or --threads\n");
> > >> +            parse_options_usage(usage, options, "map", 0);
> > >> +            parse_options_usage(NULL, options, "threads", 0);
> > >> +            return -1;
> > >> +
> > >> +    }
> > >> +
> > >> +    if (info_map && info_threads) {
> > >> +            pr_err("Cannot show map and threads together\n");
> > >> +            parse_options_usage(usage, options, "map", 0);
> > >> +            parse_options_usage(NULL, options, "threads", 0);
> > >> +            return -1;
> > >> +    }
> > >> +
> > >> +    return 0;
> > >> +}
> > >> +
> > >>   static int check_lock_contention_options(const struct option *options,
> > >>                                       const char * const *usage)
> > >>
> > >> @@ -2709,6 +2730,10 @@ int cmd_lock(int argc, const char **argv)
> > >>                      if (argc)
> > >>                              usage_with_options(info_usage, info_options);
> > >>              }
> > >> +
> > >> +            if (check_lock_info_options(info_options, info_usage) < 0)
> > >> +                    return -1;
> > >> +
> > >>              /* recycling report_lock_ops */
> > >>              trace_handler = &report_lock_ops;
> > >>              rc = __cmd_report(true);
> > >> --
> > >> 2.42.0
> > >>
> > >>

-- 

- Arnaldo
