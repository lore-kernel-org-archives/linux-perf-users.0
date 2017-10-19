From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: [PATCH v6 1/6] perf report: properly handle branch count in match_chain
Date: Thu, 19 Oct 2017 12:59:14 +0200
Message-ID: <2888255.JE21v0kgr3@agathebauer>
References: <20171018185350.14893-1-milian.wolff@kdab.com> <20171018185350.14893-2-milian.wolff@kdab.com> <871sm0hyf3.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <871sm0hyf3.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, namhyung@kernel.org, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

On Donnerstag, 19. Oktober 2017 00:41:04 CEST Andi Kleen wrote:
> Milian Wolff <milian.wolff@kdab.com> writes:
> > +static enum match_result match_address_dso(struct dso *left_dso, u64
> > left_ip, +					   struct dso *right_dso, u64 right_ip)
> > +{
> > +	if (left_dso == right_dso && left_ip == right_ip)
> > +		return MATCH_EQ;
> > +	else if (left_ip < right_ip)
> > +		return MATCH_LT;
> > +	else
> > +		return MATCH_GT;
> > +}
> 
> So why does only the first case check the dso? Does it not matter
> for the others?
> 
> Either should be checked by none or by all.

I don't see why it should be checked. It is only required to prevent two 
addresses to be considered equal while they are not. So only the one check is 
required, otherwise we return either LT or GT.

Am I missing something?

> > +	case CCKEY_FUNCTION:
> > +		if (node->sym && cnode->ms.sym) {
> > +			/*
> > +			 * Compare inlined frames based on their symbol name
> > +			 * because different inlined frames will have the same
> > +			 * symbol start. Otherwise do a faster comparison based
> > +			 * on the symbol start address.
> > +			 */
> > +			if (cnode->ms.sym->inlined || node->sym->inlined)
> > +				match = match_chain_strings(cnode->ms.sym->name,
> 
> node->sym->name);
> 
> So what happens when there are multiple symbols with the same name?
> 
> (e.g. local for a DSO or local in a file)
> 
> > +					  node->ip);
> > +		} else {
> > +			/*
> > +			 * It's "from" of a branch
> > +			 */
> > +			cnode->brtype_stat.branch_to = false;
> > +			cnode->cycles_count += node->branch_flags.cycles;
> > +			cnode->iter_count += node->nr_loop_iter;
> > +			cnode->iter_cycles += node->iter_cycles;
> 
> I assume you tested the cycle accounting still works?

Back then I did it, but it is a long time ago when I originally wrote this 
patch. I just tested it again, and indeed something crashes now. I will fix it 
and resend v7.

Sorry for that.

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
