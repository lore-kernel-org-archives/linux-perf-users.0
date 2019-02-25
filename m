From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH 15/15] perf script python: add Python3 support to sql
 scripts
Date: Mon, 25 Feb 2019 11:54:39 -0300
Message-ID: <20190225145439.GP31136@kernel.org>
References: <20190222230619.17887-1-tonyj@suse.de>
 <20190222230619.17887-16-tonyj@suse.de>
 <20190225145119.GO31136@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190225145119.GO31136@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Jones <tonyj@suse.de>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Feb 25, 2019 at 11:51:19AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Feb 22, 2019 at 03:06:19PM -0800, Tony Jones escreveu:
> > Support both Python2 and Python3 in the exported-sql-viewer.py,
> > export-to-postgresql.py and export-to-sqlite.py scripts
<SNIP>
> > @@ -234,12 +236,17 @@ perf_db_export_mode = True
> >  perf_db_export_calls = False
> >  perf_db_export_callchains = False
> >  
> > +def printerr(*args, **kw_args):
> > +    print(*args, file=sys.stderr, **kw_args)
> > +
> > +def printdate(*args, **kw_args):
> > +        print(datetime.datetime.today(), *args, sep=' ', **kw_args)
> 
> So this one introduces inconsistencies in indentation, i.e. the above
> two routines don't use tabs and one uses 4 spaces while the other uses 8
> spaces :-\
> 
> I'm converting them to use tabs, like the rest of this script, ok?

But it is not applying, Adrian did work recently here, can you please
address this and resubmit?

I'm pushing what I have already merged, please update your
acme/perf/core branch and continue from there.

Thanks!

- Arnaldo
