From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v6 1/6] perf report: properly handle branch count in
 match_chain
Date: Thu, 19 Oct 2017 06:55:19 -0700
Message-ID: <20171019135519.GC5109@tassilo.jf.intel.com>
References: <20171018185350.14893-1-milian.wolff@kdab.com>
 <20171018185350.14893-2-milian.wolff@kdab.com>
 <871sm0hyf3.fsf@linux.intel.com>
 <2888255.JE21v0kgr3@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2888255.JE21v0kgr3@agathebauer>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: acme@kernel.org, jolsa@kernel.org, namhyung@kernel.org, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

On Thu, Oct 19, 2017 at 12:59:14PM +0200, Milian Wolff wrote:
> On Donnerstag, 19. Oktober 2017 00:41:04 CEST Andi Kleen wrote:
> > Milian Wolff <milian.wolff@kdab.com> writes:
> > > +static enum match_result match_address_dso(struct dso *left_dso, u64
> > > left_ip, +					   struct dso *right_dso, u64 right_ip)
> > > +{
> > > +	if (left_dso == right_dso && left_ip == right_ip)
> > > +		return MATCH_EQ;
> > > +	else if (left_ip < right_ip)
> > > +		return MATCH_LT;
> > > +	else
> > > +		return MATCH_GT;
> > > +}
> > 
> > So why does only the first case check the dso? Does it not matter
> > for the others?
> > 
> > Either should be checked by none or by all.
> 
> I don't see why it should be checked. It is only required to prevent two 
> addresses to be considered equal while they are not. So only the one check is 
> required, otherwise we return either LT or GT.

When the comparison is always in the same process (which I think
is not the case) just checking the addresses is sufficient. If they are not then you
always need to check the DSO and only compare inside the same DSO.

-Andi
