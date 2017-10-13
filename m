From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v5 16/16] perf util: use correct IP mapping to find
 srcline for hist entry
Date: Fri, 13 Oct 2017 13:03:20 +0200
Message-ID: <20171013110320.GA28151@krava>
References: <20171009203310.17362-1-milian.wolff@kdab.com>
 <20171009203310.17362-17-milian.wolff@kdab.com>
 <20171010044954.GA1870@sejong>
 <2545513.2b6KD6sLaQ@agathebauer>
 <20171012185218.GA20959@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751480AbdJMLDZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 Oct 2017 07:03:25 -0400
Content-Disposition: inline
In-Reply-To: <20171012185218.GA20959@krava>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>, acme@kernel.org, jolsa@kernel.org, Jin Yao <yao.jin@linux.intel.com>, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, kernel-team@lge.com

On Thu, Oct 12, 2017 at 08:52:18PM +0200, Jiri Olsa wrote:
> On Thu, Oct 12, 2017 at 08:22:58PM +0200, Milian Wolff wrote:
> 
> SNIP
> 
> > > >  		return SRCLINE_UNKNOWN;
> > > > 
> > > > -	return get_srcline(map->dso, map__rip_2objdump(map, he->ip),
> > > > +	return get_srcline(map->dso, map__objdump_2mem(map, he->ip),
> > > > 
> > > >  			   he->ms.sym, true, true);
> > > 
> > > I'm not sure this is right.  IIRC hist_entry->ip is a relative IP so
> > > it needs to be changed for objdump use.  Maybe there's some bug on
> > > translating the address but it seems that the original code is
> > > correct.  And this change breaks srcline for my test program (which is
> > > a PIE).
> > 
> > Odd, I'll have to look at that. But this is imo unrelated to the rest of the 
> > patch series. So maybe we skip this one and apply the others. Assuming those 
> > other patches are OK by now?
> > 
> > Jiri, you also reviewed it before, is there anything else missing?
> 
> I plan to check on it this week.. sry for delay

I think Namhyung is right with his comment, the rest look ok,
so for patches 1 - 15:

Reviewed-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka
