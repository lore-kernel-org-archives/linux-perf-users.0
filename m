From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH 23/43] tools lib: Adopt skip_spaces() from the kernel
 sources
Date: Tue, 2 Jul 2019 11:02:55 -0300
Message-ID: <20190702140255.GC15462@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
 <20190702022616.1259-24-acme@kernel.org>
 <20190702121240.GB12694@krava>
 <20190702134603.GA15462@kernel.org>
 <20190702134815.GB15462@kernel.org>
 <20190702135432.GC12694@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190702135432.GC12694@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, =?iso-8859-1?Q?Andr=E9?= Goddard Rosa <andre.goddard@gmail.com>
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Jul 02, 2019 at 03:54:32PM +0200, Jiri Olsa escreveu:
> On Tue, Jul 02, 2019 at 10:48:15AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Jul 02, 2019 at 10:46:03AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Tue, Jul 02, 2019 at 02:12:40PM +0200, Jiri Olsa escreveu:
> > > > this breaks objtool build, because it adds _ctype dependency via isspace call
> > > > patch below fixes it for me

> > > Thanks for  spotting this, I'll have it in my next pull request.

> > I'm adding a Signed-off-by: you, ok?

> sure, I did not post full patch, because I thought you might thought
> of some other solution

I think this is it for now, at some point we need to make a
tools/lib/liblinux.{a,so} to group what we're getting from the linux
lib/ directory to adapt and use in tools/ living code and then, as a
a starter, tools/objtool/ and tools/perf/ should link with it.

- Arnaldo
