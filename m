From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 0/8] perf/urgent fixes
Date: Tue, 9 Jul 2019 13:23:14 +0200
Message-ID: <20190709112314.GA110831@gmail.com>
References: <20190708154207.11403-1-acme@kernel.org>
 <20190708215057.GA7455@kernel.org>
 <20190708215420.GB7455@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190708215420.GB7455@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Carrillo Cisneros <davidca@fb.com>, Konstantin Kharlamov <Hi-Angel@yandex.ru>, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>, Song Liu <songliubraving@fb.com>, Wei Li <liwei391@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Mon, Jul 08, 2019 at 06:50:58PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Jul 08, 2019 at 12:41:59PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Hi Ingo,
> > > 
> > > 	Please consider pulling, I did a git merge with torvalds/master
> > > late last week to fixup some kernel headers ABI sync warnings, but I had
> > > to cherry pick some csets from my perf/core branch to get the container
> > > builds to all work, so ended up slipping past v5.2, oh well, but here it
> > > is, all containers building ok, I'll now test perf/core to then push
> > > that too.
> > 
> > Hi Ingo,
> > 
> > 	As requested I merged tip/perf/core with this branch and now its
> > available as the perf-urgent-for-mingo-5.3-20190708-2 signed tag, that
> > has only one extra cset:
> > 
> >   commit 686cbe9e5d88ad639bbe26d963e7d5dafa1c1c28 (HEAD -> perf/urgent, tag: perf-urgent-for-mingo-5.3-20190708-2, acme/perf/urgent, acme.korg/perf/urgent)
> >   Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> >   Date:   Mon Jul 8 13:47:14 2019 -0300
> >   
> >       tools arch x86: Sync asm/cpufeatures.h with the with the kernel
> 
> BTW, I ran all the tests as before, same results.

Pulled, thanks a lot Arnaldo!

	Ingo
