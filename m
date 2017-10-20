From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: [PATCH v6 1/6] perf report: properly handle branch count in match_chain
Date: Fri, 20 Oct 2017 13:38:23 +0200
Message-ID: <1542636.JzONsm6D9Z@agathebauer>
References: <20171018185350.14893-1-milian.wolff@kdab.com> <20171019150108.GA24104@danjae.aot.lge.com> <4075632.NPQJP4Tzi9@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4075632.NPQJP4Tzi9@agathebauer>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, acme@kernel.org, jolsa@kernel.org, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, kernel-team@lge.com
List-Id: linux-perf-users.vger.kernel.org

On Freitag, 20. Oktober 2017 12:21:35 CEST Milian Wolff wrote:
> On Donnerstag, 19. Oktober 2017 17:01:08 CEST Namhyung Kim wrote:
> > Hi Andi,
> > 
> > On Thu, Oct 19, 2017 at 06:55:19AM -0700, Andi Kleen wrote:
> > > On Thu, Oct 19, 2017 at 12:59:14PM +0200, Milian Wolff wrote:
> > > > On Donnerstag, 19. Oktober 2017 00:41:04 CEST Andi Kleen wrote:
> > > > > Milian Wolff <milian.wolff@kdab.com> writes:
> > > > > > +static enum match_result match_address_dso(struct dso *left_dso,
> > > > > > u64
> > > > > > left_ip, +					   struct dso *right_dso, u64 right_ip)
> > > > > > +{
> > > > > > +	if (left_dso == right_dso && left_ip == right_ip)
> > > > > > +		return MATCH_EQ;
> > > > > > +	else if (left_ip < right_ip)
> > > > > > +		return MATCH_LT;
> > > > > > +	else
> > > > > > +		return MATCH_GT;
> > > > > > +}
> > > > > 
> > > > > So why does only the first case check the dso? Does it not matter
> > > > > for the others?
> > > > > 
> > > > > Either should be checked by none or by all.
> > > > 
> > > > I don't see why it should be checked. It is only required to prevent
> > > > two
> > > > addresses to be considered equal while they are not. So only the one
> > > > check is required, otherwise we return either LT or GT.
> > > 
> > > When the comparison is always in the same process (which I think
> > > is not the case) just checking the addresses is sufficient. If they are
> > > not then you always need to check the DSO and only compare inside the
> > > same DSO.
> > 
> > As far as I know, the node->ip is a relative address (inside a DSO).
> > So it should compare the dso as well even in the same process.
> 
> Sorry guys, I seem to be slow at understanding your review comments.
> 
> match_address_dso should impose a sort order on two relative addresses. The
> order should ensure that relative addresses in a different DSO are not
> considered equal. But if the DSOs are different, it doesn't matter whether
> we return LT or GT - or?
> 
> Put differently, how would you write this function to take care of the DSO
> in the other two branches? I.e. what to return if the DSOs are different -
> a MATCH_ERROR?

Thinking a bit more about this. Are you guys maybe hinting at my 
implementation breaking the strict ordering rules (is that the right word?). 
I.e. a < b && b > a iff a == b ? Potentially my implementation would break 
this assumption when the relative IPs are the same, but the DSO is different.

So is this what you want:

+static enum match_result match_address_dso(struct dso *left_dso, u64
 left_ip, +                                         struct dso *right_dso, u64 
right_ip)
 +{
 +       if (left_dso == right_dso && left_ip == right_ip)
 +               return MATCH_EQ;
 +       else if (left_dso < right_dso || left_ip < right_ip)
 +               return MATCH_LT;
 +       else
 +               return MATCH_GT;
 +}

Thanks

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
