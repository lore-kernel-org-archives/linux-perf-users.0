From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 35/63] perf trace: Allow specifying a set of events to
 add in perfconfig
Date: Wed, 19 Dec 2018 09:50:00 -0300
Message-ID: <20181219125000.GA16225@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
 <20181218220733.15839-36-acme@kernel.org>
 <20181219084024.GA18068@danjae.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181219084024.GA18068@danjae.aot.lge.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Luis =?iso-8859-1?Q?Cl=E1udio_Gon=E7alves?= <lclaudio@redhat.com>, Wang Nan <wangnan0@huawei.com>, kernel-team@lge.com
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Dec 19, 2018 at 05:40:24PM +0900, Namhyung Kim escreveu:
> On Tue, Dec 18, 2018 at 07:07:05PM -0300, Arnaldo Carvalho de Melo wrote:
> > +	if (!strcmp(var, "trace.add_events")) {
> > +		struct trace *trace = arg;
> > +		struct option o = OPT_CALLBACK('e', "event", &trace->evlist, "event",
> > +					       "event selector. use 'perf list' to list available events",
> > +					       parse_events_option);
> > +		err = parse_events_option(&o, value, 0);
 
> It's a bit strange to use parse_events_option() here IMHO.  Why not
> using parse_events() instead?

I just reused what was done a in another place in 'perf trace', will
check and use parse_events() directly, thanks for the suggestion!

- Arnaldo
