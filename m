From: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH] perf: support running perf binaries with a dash in their
 name
Date: Mon, 11 Sep 2017 11:33:12 -0300
Message-ID: <20170911143312.GD5054@redhat.com>
References: <20170911111422.31903-1-milian.wolff@kdab.com>
 <b7c2b440-f781-19ae-ebc7-7fba93bb4618@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b7c2b440-f781-19ae-ebc7-7fba93bb4618@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Ahern <dsahern@gmail.com>
Cc: Milian Wolff <milian.wolff@kdab.com>, acme@kernel.org, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Sep 11, 2017 at 07:08:18AM -0700, David Ahern escreveu:
> On 9/11/17 4:14 AM, Milian Wolff wrote:
> > Previously the part behind "perf-" was interpreted as an internal
> > perf command. If the suffix could not be handled, the execution
<SNIP>
> > --- a/tools/perf/perf.c
> > -		fprintf(stderr, "cannot handle %s internally", cmd);
> > -		goto out;
> > +		// if the command is handled, the above function does not return
> > +		// undo changes and fall through in such a case
 
> Those should be /* */ not //
> 
> > +		cmd -= 5;
> > +		argv[0] = cmd;
> >  	}
> >  	if (strstarts(cmd, "trace")) {
> >  #ifdef HAVE_LIBAUDIT_SUPPORT
 
> other than that LGTM and long over due.
 
> Acked-by: David Ahern <dsahern@gmail.com>

We got those from git, agreed it should go, thanks for the Acked-by,
always welcome!

- Arnaldo
