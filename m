From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v6 6/6] perf util: use correct IP mapping to find srcline
 for hist entry
Date: Wed, 25 Oct 2017 10:46:00 +0900
Message-ID: <20171025014600.GA12785@sejong>
References: <20171018185350.14893-1-milian.wolff@kdab.com>
 <3026429.kO1GvhRXjL@agathebauer>
 <20171020051533.GA2746@sejong>
 <8383335.eDmCaHkkAL@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8383335.eDmCaHkkAL@agathebauer>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: acme@kernel.org, jolsa@kernel.org, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Yao Jin <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, kernel-team@lge.com
List-Id: linux-perf-users.vger.kernel.org

Hi Milian,

On Tue, Oct 24, 2017 at 10:51:43AM +0200, Milian Wolff wrote:
> On Freitag, 20. Oktober 2017 07:15:33 CEST Namhyung Kim wrote:
> > I looked into it and found a bug handling cumulative (children)
> > entries.  For chilren entries that has no self period, the al->addr
> > (so he->ip) ends up having an doubly-mapped address.
> > 
> > It seems to be there from the beginning but only affects entries that
> > have no srclines - finding srcline itself is done using a different
> > address but it will show the invalid address if no srcline was found.
> > I think we should fix the commit c7405d85d7a3 ("perf tools: Update
> > cpumode for each cumulative entry").
> > 
> > Could you please test the following patch works for you?
> 
> Sorry for the delay, nearly forgot about this mail. The patch below does help 
> in my situation, thanks! Can you commit it please?

Sure, I'll add your Tested-by then.

Thanks,
Namhyung
