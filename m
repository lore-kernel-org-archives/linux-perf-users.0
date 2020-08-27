From: "Paul A. Clarke" <pc@us.ibm.com>
Subject: Re: [PATCH] perf stat: update POWER9 metrics to utilize other metrics
Date: Wed, 26 Aug 2020 21:06:40 -0500
Message-ID: <20200827020640.GA48404@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
References: <20200813222155.268183-1-pc@us.ibm.com>
 <CAP-5=fU4P7o1TwVz+PzcrJsBKnrHW4yrNx3R165i9d3BwgP2RQ@mail.gmail.com>
 <cfa27e83-ac2c-7495-b453-ceeaf2412311@linux.ibm.com>
 <20200814124307.GF13995@kernel.org>
 <CAP-5=fWw-W3wfy_WeirM_jbEmsbQCC8L_AGo2zsMvv2MW1x04A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAP-5=fWw-W3wfy_WeirM_jbEmsbQCC8L_AGo2zsMvv2MW1x04A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: kajoljain <kjain@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>, maddy@linux.ibm.com, Arnaldo Carvalho de Melo <acme@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Aug 26, 2020 at 09:26:40AM -0700, Ian Rogers wrote:
> On Fri, Aug 14, 2020 at 5:43 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> > Em Fri, Aug 14, 2020 at 11:20:42AM +0530, kajoljain escreveu:
> > > On 8/14/20 9:13 AM, Ian Rogers wrote:
> > > > On Thu, Aug 13, 2020 at 3:21 PM Paul A. Clarke <pc@us.ibm.com> wrote:
> > > >> These changes take advantage of the new capability added in
> > > >> merge commit 00e4db51259a5f936fec1424b884f029479d3981
> > > >> "Allow using computed metrics in calculating other metrics".
> > > >>
> > > >> The net is a simplification of the expressions for a handful
> > > >> of metrics, but no functional change.
> > > >>
> > > >> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> > >
> > >   The patch looks good to me.
> > >
> > > Reviewed-by: Kajol Jain<kjain@linux.ibm.com>
> >
> > Thanks, applied. Added Ian's Acked-by as well.
> 
> I've synced perf and testing on a remote machine (not easy for me to
> log into) I see failures in perf test "10.3: Parsing of PMU event
> table metrics" like:
> ...
> parsing metric: dfu_stall_cpi - dflong_stall_cpi
> Parse event failed metric 'dfu_other_stall_cpi' id 'dflong_stall_cpi'
> expr 'dfu_stall_cpi - dflong_stall_cpi'
> Error string 'parser error' help '(null)'
> Parse event failed metric 'dfu_other_stall_cpi' id 'dfu_stall_cpi'
> expr 'dfu_stall_cpi - dflong_stall_cpi'
> Error string 'parser error' help '(null)'
> ...
> 
> This may be that the test doesn't handle the metric in terms of metric
> addition and so I'll look for a fix. I thought I'd send a heads up in
> case you had already seen/addressed this. Is perf test on PowerPC
> clean for you at the moment?

I see these errors as well (on 5.9-rc2).  Each error seems to be for the
newer metrics that take advantage of the newer functionality, including
the metrics I changed recently, and Kajol's 24x7 and nest metrics.

Thanks for the heads up!  I confess I had not seen the errors only because
I wasn't looking.  :-/

PC
