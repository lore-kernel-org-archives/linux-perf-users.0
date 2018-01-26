From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2 2/2] perf stat: Add support to print counts after a
 period of time
Date: Fri, 26 Jan 2018 08:51:04 +0100
Message-ID: <20180126075104.GA4754@krava>
References: <1516871404-31920-1-git-send-email-ufo19890607@gmail.com>
 <1516871404-31920-3-git-send-email-ufo19890607@gmail.com>
 <20180125122712.GA9096@krava>
 <CAHCio2hg-C55Ue=bUzu-6sYyGXaCw916AAZ7CzJFW-x1dyWmyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752065AbeAZHvM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Jan 2018 02:51:12 -0500
Content-Disposition: inline
In-Reply-To: <CAHCio2hg-C55Ue=bUzu-6sYyGXaCw916AAZ7CzJFW-x1dyWmyw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: =?utf-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Wind Yu <yuzhoujian@didichuxing.com>, Adrian Hunter <adrian.hunter@intel.com>, Wang Nan <wangnan0@huawei.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com

On Fri, Jan 26, 2018 at 09:59:02AM +0800, 禹舟键 wrote:
> 2018-01-25 20:27 GMT+08:00 Jiri Olsa <jolsa@redhat.com>:
> 
> > On Thu, Jan 25, 2018 at 10:10:04AM +0100, ufo19890607 wrote:
> >
> > SNIP
> >
> > >  --metric-only::
> > >  Only print computed metrics. Print them in a single line.
> > > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > > index 406f546ad74c..427f06dc35cc 100644
> > > --- a/tools/perf/builtin-stat.c
> > > +++ b/tools/perf/builtin-stat.c
> > > @@ -573,6 +573,7 @@ static int __run_perf_stat(int argc, const char
> > **argv)
> > >  {
> > >       int interval = stat_config.interval;
> > >       int times = stat_config.times;
> > > +     int time = stat_config.time;
> > >       char msg[BUFSIZ];
> > >       unsigned long long t0, t1;
> > >       struct perf_evsel *counter;
> > > @@ -586,6 +587,9 @@ static int __run_perf_stat(int argc, const char
> > **argv)
> > >       if (interval) {
> > >               ts.tv_sec  = interval / USEC_PER_MSEC;
> > >               ts.tv_nsec = (interval % USEC_PER_MSEC) * NSEC_PER_MSEC;
> > > +     } else if (time) {
> > > +             ts.tv_sec  = time / USEC_PER_MSEC;
> > > +             ts.tv_nsec = (time % USEC_PER_MSEC) * NSEC_PER_MSEC;
> >
> > I like the idea.. it won't work with -I option, but let's
> > keep it like that until someone needs it ;-)
> >
> >
> Hi Jirka
> 
> What do you mean by this sentence？？？

that I'm ok with the patch with small fixes I mentioned

jirka
