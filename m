From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 6/7] perf report: mark inlined frames in output by "
 (inlined)" suffix
Date: Tue, 6 Jun 2017 16:52:28 -0300
Message-ID: <20170606195228.GB30074@kernel.org>
References: <20170518193411.22380-1-milian.wolff@kdab.com>
 <2569406.pAYQppI5ax@agathebauer>
 <CAM9d7ch9xeuWqEQA7GNTJ=uBTvU_PkFu11D-qzsa26dyS1yuuw@mail.gmail.com>
 <3456459.puB1FN52Ey@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3456459.puB1FN52Ey@milian-kdab2>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>, "linux-kernel@vger.kernel.org" <Linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, kernel-team@lge.com
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Jun 06, 2017 at 09:26:47AM +0200, Milian Wolff escreveu:
> On Tuesday, June 6, 2017 3:33:49 AM CEST Namhyung Kim wrote:
> > On Sat, Jun 3, 2017 at 10:51 PM, Milian Wolff <milian.wolff@kdab.com> wrote:
> > > The current API seems to pass the data around mostly using the
> > > addr_location struct, which is usually constructed on the stack and not
> > > always memset to zero. As such, my initial plan of adding a srcline
> > > member there would require me to go through all the code to ensure that
> > > we memset the struct to zero...

> > > Alternatively, I'd have to change the API of hist_iter_ops, to let the
> > > callback take another `const char **srcline` out parameter. This is also
> > > going to be quite a large invasive change.

> > > Do you have any suggestions on how to make this work?

> > I think passing srcline via addr_location might not be very invasive
> > since it calls machine__resolve() in most cases.  Missing places that
> > set al->sym should set al->srcline as well IMHO.

I haven't looked if it would be invasive or not, good that it isn't, but
then I think addr_location is the right place for this to be stored.
 
> OK, perfect - I'll implement that then.

Thanks,

- Arnaldo
