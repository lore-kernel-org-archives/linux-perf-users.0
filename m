From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: Support sample context in perf report
Date: Wed, 27 Feb 2019 14:41:20 -0300
Message-ID: <20190227174120.GF13100@kernel.org>
References: <20190226030412.23485-1-andi@firstfloor.org>
 <20190227111801.GA18893@krava>
 <20190227160135.lqcckfqcrrq3aedb@two.firstfloor.org>
 <20190227161658.GA2890@krava>
 <20190227172954.kithpbfndc5jjg33@two.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190227172954.kithpbfndc5jjg33@two.firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Jiri Olsa <jolsa@redhat.com>, jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Feb 27, 2019 at 09:29:54AM -0800, Andi Kleen escreveu:
> On Wed, Feb 27, 2019 at 05:16:59PM +0100, Jiri Olsa wrote:
> > On Wed, Feb 27, 2019 at 08:01:35AM -0800, Andi Kleen wrote:
> > > > > Also available in
> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc.git perf/streams-2
> > > > 
> > > > your post is missing this patch, it's only in the branch:
> > > >   perf tools: Add utility function to fetch executable
> > > 
> > > Because Arnaldo already merged it. But the branch is still based
> > 
> > can't see it on his perf/core branch,
> > please paste me commit id
> 
> I don't know the commit id, but there was an email from him earlier
> that said "applied". Maybe he hasn't pushed yet.

Perhaps you're referring to this one:

commit 94816add0005595ea33fc8456519be582330401e
Author: Andi Kleen <ak@linux.intel.com>
Date:   Sun Feb 24 07:37:19 2019 -0800

    perf tools: Add perf_exe() helper to find perf binary

    Also convert one existing user.

    Signed-off-by: Andi Kleen <ak@linux.intel.com>
    Acked-by: Jiri Olsa <jolsa@kernel.org>


?

- Arnaldo
