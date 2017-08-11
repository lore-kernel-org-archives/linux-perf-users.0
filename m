From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: [PATCH v2 11/14] perf report: cache srclines for callchain nodes
Date: Fri, 11 Aug 2017 13:28:27 +0200
Message-ID: <2484111.SVxAiXXlh2@agathebauer>
References: <20170806212446.24925-1-milian.wolff@kdab.com> <CAM9d7chNxx8_Z10dViFtDbykpH+zXdhu44AAvpxD2=6wLz_Vkg@mail.gmail.com> <20170810175845.GB3900@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170810175845.GB3900@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Jin Yao <yao.jin@linux.intel.com>, "linux-kernel@vger.kernel.org" <Linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kernel-team@lge.com
List-Id: linux-perf-users.vger.kernel.org

On Donnerstag, 10. August 2017 19:58:45 CEST Arnaldo Carvalho de Melo wrote:
> Em Thu, Aug 10, 2017 at 11:56:24PM +0900, Namhyung Kim escreveu:
> > On Thu, Aug 10, 2017 at 8:51 PM, Milian Wolff <milian.wolff@kdab.com> 
wrote:
> > > On Donnerstag, 10. August 2017 04:13:25 CEST Namhyung Kim wrote:
> > >> Agreed.  Also I guess no need to unwind anymore to get a srcfile for
> > >> an entry with your change.
> > > 
> > > Does this mean I should respin the patch series with the above changes
> > > integrated? Or can we get this in first and then continue with the
> > > cleanup as described above later on?
> > 
> > Nop, it can be done later IMHO.  I will try to review the code next week.
> 
> Ok, I'm preparing a new batch to send to Ingo, will wait a bit more for
> your review, ok, Millian?

Considering that this is a big and somewhat invasive patch series, I'm all for 
being conservative on it. I.e. please take your time on reviewing it. I'm 
pretty sure there are some things that need to be improved on, e.g. my usage 
of the rbtree code. I'm a C++ dev, this C-style copy'n'paste programming for 
containers is foreign to me.

Cheers

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
