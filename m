From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2 11/14] perf report: cache srclines for callchain nodes
Date: Thu, 10 Aug 2017 14:58:45 -0300
Message-ID: <20170810175845.GB3900@kernel.org>
References: <20170806212446.24925-1-milian.wolff@kdab.com>
 <20170806212446.24925-12-milian.wolff@kdab.com>
 <20170810021325.GA1797@sejong>
 <4512331.57hptoN48J@agathebauer>
 <CAM9d7chNxx8_Z10dViFtDbykpH+zXdhu44AAvpxD2=6wLz_Vkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAM9d7chNxx8_Z10dViFtDbykpH+zXdhu44AAvpxD2=6wLz_Vkg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>, Jin Yao <yao.jin@linux.intel.com>, "linux-kernel@vger.kernel.org" <Linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kernel-team@lge.com
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Aug 10, 2017 at 11:56:24PM +0900, Namhyung Kim escreveu:
> On Thu, Aug 10, 2017 at 8:51 PM, Milian Wolff <milian.wolff@kdab.com> wrote:
> > On Donnerstag, 10. August 2017 04:13:25 CEST Namhyung Kim wrote:
> >> Agreed.  Also I guess no need to unwind anymore to get a srcfile for
> >> an entry with your change.

> > Does this mean I should respin the patch series with the above changes
> > integrated? Or can we get this in first and then continue with the cleanup as
> > described above later on?
 
> Nop, it can be done later IMHO.  I will try to review the code next week.

Ok, I'm preparing a new batch to send to Ingo, will wait a bit more for
your review, ok, Millian?

- Arnaldo
