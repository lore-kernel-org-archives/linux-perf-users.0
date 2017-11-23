From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v4 1/1] perf/bench/numa: Fixup discontiguous/sparse numa
 nodes
Date: Thu, 23 Nov 2017 12:23:11 -0300
Message-ID: <20171123152311.GH8789@kernel.org>
References: <1511336642-15389-1-git-send-email-sathnaga@linux.vnet.ibm.com>
 <1511366847.k4y13an79p.naveen@linux.ibm.com>
 <1511369293.11553.2.camel@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1511369293.11553.2.camel@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, mingo@kernel.org, bala24@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Nov 22, 2017 at 10:18:13PM +0530, Satheesh Rajendran escreveu:
> On Wed, 2017-11-22 at 21:39 +0530, Naveen N. Rao wrote:
> > >               sum += nr;
> > >       }
> > >       BUG_ON(nr_min > nr_max);
> > > -
> > >       BUG_ON(sum > g->p.nr_tasks);
> > 
> > Looks like that change to remove a blank line did slip in, but that's
> > a 
> > small nit. Apart from that, the patch looks good to me.
> > Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > 
> Hi Naveen,
> 
> Thanks, have sent v5 with that addressed :-)

Thanks, applied.

- Arnaldo
