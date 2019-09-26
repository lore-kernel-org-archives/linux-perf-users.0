From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH 57/66] perf evsel: Introduce evsel_fprintf.h
Date: Thu, 26 Sep 2019 12:06:09 -0300
Message-ID: <20190926150609.GA10129@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
 <20190926003244.13962-58-acme@kernel.org>
 <20190926111518.GC24257@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190926111518.GC24257@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Sep 26, 2019 at 01:15:18PM +0200, Jiri Olsa escreveu:
> On Wed, Sep 25, 2019 at 09:32:35PM -0300, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > We already had evsel_fprintf.c, add its counterpart, so that we can
> > reduce evsel.h a bit more.
> > 
> > We needed a new perf_event_attr_fprintf.c file so as to have a separate
> > object to link with the python binding in tools/perf/util/python-ext-sources
> > and not drag symbol_conf, etc into the python binding.
> > 
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Link: https://lkml.kernel.org/n/tip-06bdmt1062d9unzgqmxwlv88@git.kernel.org
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/builtin-evlist.c               |   1 +
> >  tools/perf/builtin-sched.c                |   1 +
> >  tools/perf/builtin-script.c               |   1 +
> >  tools/perf/builtin-trace.c                |   2 +
> >  tools/perf/util/Build                     |   1 +
> >  tools/perf/util/evsel.c                   | 153 +---------------------
> >  tools/perf/util/evsel.h                   |  51 +-------
> >  tools/perf/util/evsel_fprintf.c           |   1 +
> >  tools/perf/util/evsel_fprintf.h           |  50 +++++++
> >  tools/perf/util/header.c                  |   1 +
> >  tools/perf/util/perf_event_attr_fprintf.c | 148 +++++++++++++++++++++
> >  tools/perf/util/python-ext-sources        |   1 +
> >  12 files changed, 218 insertions(+), 193 deletions(-)
> >  create mode 100644 tools/perf/util/evsel_fprintf.h
> >  create mode 100644 tools/perf/util/perf_event_attr_fprintf.c
> 
> hum, I see this file in this patch, but not when I checkout yours perf/core

I made a mistake and had to force push it, it went on the signed tag to
Ingo, so what made upstream is sane, now what is in my perf/core branch
should be as well:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/evsel_fprintf.h?h=perf/core
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/perf_event_attr_fprintf.c?h=perf/core

- Arnaldo
