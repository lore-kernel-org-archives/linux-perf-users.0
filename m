From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: [PATCH v4 14/15] perf report: use srcline from callchain for hist entries
Date: Mon, 09 Oct 2017 22:21:30 +0200
Message-ID: <25129135.mgkeNORqek@agathebauer>
References: <20171001143100.19988-1-milian.wolff@kdab.com> <20171001143100.19988-15-milian.wolff@kdab.com> <20171005040829.GA1584@danjae.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171005040829.GA1584@danjae.aot.lge.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, jolsa@kernel.org, Jin Yao <yao.jin@linux.intel.com>, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kernel-team@lge.com
List-Id: linux-perf-users.vger.kernel.org

On Donnerstag, 5. Oktober 2017 06:08:29 CEST Namhyung Kim wrote:
> On Sun, Oct 01, 2017 at 04:30:59PM +0200, Milian Wolff wrote:
> > This also removes the symbol name from the srcline column,
> > more on this below.
> > 
> > This ensures we use the correct srcline, which could originate
> > from a potentially inlined function. The hist entries used to
> > query for the srcline based purely on the IP, which leads to
> > wrong results for inlined entries.
> 
> Yep, AFAICS current srcline returns the first entry in a inline-chain
> and the srcfile (sort key) returns the last.  I think we need to make
> it consistent.  It seems this patch fix it when --inline option is
> used, but I guess the --no-inline case still has the problem.

I'm not sure I've understood you correctly. There is indeed an issue still 
when passing --no-inline, which seems to arise from the use of 
map__rip_2objdump instead of map__objdump_2mem. I've changed that now and will 
include that patch in v5 of this patch series.

Cheers

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
