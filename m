From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v6 1/6] perf report: properly handle branch count in
 match_chain
Date: Fri, 20 Oct 2017 00:01:08 +0900
Message-ID: <20171019150108.GA24104@danjae.aot.lge.com>
References: <20171018185350.14893-1-milian.wolff@kdab.com>
 <20171018185350.14893-2-milian.wolff@kdab.com>
 <871sm0hyf3.fsf@linux.intel.com>
 <2888255.JE21v0kgr3@agathebauer>
 <20171019135519.GC5109@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:57220 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752141AbdJSPDb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 Oct 2017 11:03:31 -0400
Content-Disposition: inline
In-Reply-To: <20171019135519.GC5109@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: Milian Wolff <milian.wolff@kdab.com>, acme@kernel.org, jolsa@kernel.org, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, kernel-team@lge.com

Hi Andi,

On Thu, Oct 19, 2017 at 06:55:19AM -0700, Andi Kleen wrote:
> On Thu, Oct 19, 2017 at 12:59:14PM +0200, Milian Wolff wrote:
> > On Donnerstag, 19. Oktober 2017 00:41:04 CEST Andi Kleen wrote:
> > > Milian Wolff <milian.wolff@kdab.com> writes:
> > > > +static enum match_result match_address_dso(struct dso *left_dso, u64
> > > > left_ip, +					   struct dso *right_dso, u64 right_ip)
> > > > +{
> > > > +	if (left_dso == right_dso && left_ip == right_ip)
> > > > +		return MATCH_EQ;
> > > > +	else if (left_ip < right_ip)
> > > > +		return MATCH_LT;
> > > > +	else
> > > > +		return MATCH_GT;
> > > > +}
> > > 
> > > So why does only the first case check the dso? Does it not matter
> > > for the others?
> > > 
> > > Either should be checked by none or by all.
> > 
> > I don't see why it should be checked. It is only required to prevent two 
> > addresses to be considered equal while they are not. So only the one check is 
> > required, otherwise we return either LT or GT.
> 
> When the comparison is always in the same process (which I think
> is not the case) just checking the addresses is sufficient. If they are not then you
> always need to check the DSO and only compare inside the same DSO.

As far as I know, the node->ip is a relative address (inside a DSO).
So it should compare the dso as well even in the same process.

Thanks,
Namhyung
