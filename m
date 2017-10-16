From: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v5 11/16] perf report: properly handle branch count in
 match_chain
Date: Mon, 16 Oct 2017 12:19:43 -0200
Message-ID: <20171016141943.GC2567@redhat.com>
References: <20171009203310.17362-1-milian.wolff@kdab.com>
 <20171009203310.17362-12-milian.wolff@kdab.com>
 <20171013133903.GN3503@kernel.org>
 <20171013140834.GO3503@kernel.org>
 <5f4372e7-8e75-bf34-3947-4b38036241a4@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5f4372e7-8e75-bf34-3947-4b38036241a4@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ravi <ravi.bangoria@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Milian Wolff <milian.wolff@kdab.com>, Jiri Olsa <jolsa@kernel.org>, Jin Yao <yao.jin@linux.intel.com>, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Oct 16, 2017 at 09:48:17AM +0530, ravi escreveu:
> 
> On Friday 13 October 2017 07:38 PM, Arnaldo Carvalho de Melo wrote:
> >Em Fri, Oct 13, 2017 at 10:39:03AM -0300, Arnaldo Carvalho de Melo escreveu:
> >>Em Mon, Oct 09, 2017 at 10:33:05PM +0200, Milian Wolff escreveu:
> >>>Some of the code paths I introduced before returned too early
> >>>without running the code to handle a node's branch count.
> >>>By refactoring match_chain to only have one exit point, this
> >>>can be remedied.
> >>Fixing up this one now.
> >Millian, this is all fresher in your mind, can you please take a look at
> >my perf/core branch and check if the change i made to ]PATCH v5 09/16]
> >"perf report: compare symbol name for inlined frames when matching" is
> >ok wrt Ravi's fix and then, please, rebase v5 on top of what is there?
> >
> >Ravi, please take a look at this as well, to see if with these changes
> >your fix remains valid, ok?
> 
> Yes Arnaldo, my changes are still valid.

I knot they are valid, probably my wording was unclear, I was asking if,
with Milian changes, and my fixing up to cope with your patch, that was
just in perf/urgent, while Milian work was done on perf/core, everything
worked for your use case.

- Arnaldo
 
> Milian, Can you please change this patch such that it incorporates dso
> comparison for CCKEY_FUNCTION.
> 
> ( Also, will that be good to change macro to CCKEY_FUNCTION_DOS ?)
> 
> Thanks,
> Ravi
