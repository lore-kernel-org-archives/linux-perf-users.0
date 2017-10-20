From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v6 6/6] perf util: use correct IP mapping to find srcline
 for hist entry
Date: Fri, 20 Oct 2017 14:15:33 +0900
Message-ID: <20171020051533.GA2746@sejong>
References: <20171018185350.14893-1-milian.wolff@kdab.com>
 <20171018185350.14893-7-milian.wolff@kdab.com>
 <3026429.kO1GvhRXjL@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:36476 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbdJTFPg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Oct 2017 01:15:36 -0400
Content-Disposition: inline
In-Reply-To: <3026429.kO1GvhRXjL@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: acme@kernel.org, jolsa@kernel.org, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Yao Jin <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, kernel-team@lge.com

Hi Milian,

On Thu, Oct 19, 2017 at 12:54:18PM +0200, Milian Wolff wrote:
> On Mittwoch, 18. Oktober 2017 20:53:50 CEST Milian Wolff wrote:
> > When inline frame resolution is disabled, a bogus srcline is obtained
> > for hist entries:
> > 
> > ~~~~~
> > $ perf report -s sym,srcline --no-inline --stdio -g none
> >     95.21%     0.00%  [.] __libc_start_main                                 
> >                                                                 
> > __libc_start_main+18446603358170398953 95.21%     0.00%  [.] _start        
> >                                                                            
> >                          _start+18446650082411225129 46.67%     0.00%  [.]
> > main                                                                       
> >                                         main+18446650082411225208 38.75%   
> >  0.00%  [.] hypot                                                          
> >                                                    
> > hypot+18446603358164312084 23.75%     0.00%  [.] main                      
> >                                                                            
> >              main+18446650082411225151 20.83%    20.83%  [.]
> > std::generate_canonical<double, 53ul,
> > std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>
> > >  random.h:143 18.12%     0.00%  [.] main                                 
> >                                                                            
> >   main+18446650082411225165 13.12%    13.12%  [.]
> > std::generate_canonical<double, 53ul,
> > std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>
> > >  random.tcc:3330 4.17%     4.17%  [.] __hypot_finite                     
> >                                                                            
> >     __hypot_finite+163 4.17%     4.17%  [.] std::generate_canonical<double,
> > 53ul, std::linear_congruential_engine<unsigned long, 16807ul, 0ul,
> > 2147483647ul> >  random.tcc:3333 4.17%     0.00%  [.] __hypot_finite       
> >                                                                            
> >                   __hypot_finite+18446603358164312227 4.17%     0.00%  [.]
> > std::generate_canonical<double, 53ul,
> > std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>
> > >  std::generate_canonical<double, 53ul, std::line 2.92%     0.00%  [.]
> > std::generate_canonical<double, 53ul,
> > std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>
> > >  std::generate_canonical<double, 53ul, std::line 2.50%     2.50%  [.]
> > __hypot_finite                                                             
> >                                         __hypot_finite+11 2.50%     2.50% 
> > [.] __hypot_finite                                                         
> >                                             __hypot_finite+24 2.50%    
> > 0.00%  [.] __hypot_finite                                                  
> >                                                   
> > __hypot_finite+18446603358164312075 2.50%     0.00%  [.] __hypot_finite    
> >                                                                            
> >                      __hypot_finite+18446603358164312088 ~~~~~
> > 
> > Note how we get very large offsets to main and cannot see any srcline
> > from one of the complex or random headers, even though the instruction
> > pointers actually lie in code inlined from there.
> > 
> > This patch fixes the mapping to use map__objdump_2mem instead of
> > map__objdump_2mem in hist_entry__get_srcline. This fixes the srcline
> > values for me when inline resolution is disabled:
> > 
> > ~~~~~
> > $ perf report -s sym,srcline --no-inline --stdio -g none
> >     95.21%     0.00%  [.] __libc_start_main                                 
> >                                                                 
> > __libc_start_main+233 95.21%     0.00%  [.] _start                         
> >                                                                            
> >         _start+41 46.88%     0.00%  [.] main                               
> >                                                                            
> >     complex:589 43.96%     0.00%  [.] main                                 
> >                                                                            
> >   random.h:185 38.75%     0.00%  [.] hypot                                 
> >                                                                            
> >  hypot+20 20.83%     0.00%  [.] std::generate_canonical<double, 53ul,
> > std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>
> > >  random.h:143 13.12%     0.00%  [.] std::generate_canonical<double, 53ul,
> > std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>
> > >  random.tcc:3330 4.17%     4.17%  [.] __hypot_finite                     
> >                                                                            
> >     __hypot_finite+140715545239715 4.17%     4.17%  [.]
> > std::generate_canonical<double, 53ul,
> > std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>
> > >  std::generate_canonical<double, 53ul, std::line 4.17%     0.00%  [.]
> > __hypot_finite                                                             
> >                                         __hypot_finite+163 4.17%     0.00% 
> > [.] std::generate_canonical<double, 53ul,
> > std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>
> > >  random.tcc:3333 2.92%     2.92%  [.] std::generate_canonical<double,
> > 53ul, std::linear_congruential_engine<unsigned long, 16807ul, 0ul,
> > 2147483647ul> >  std::generate_canonical<double, 53ul, std::line 2.50%    
> > 2.50%  [.] __hypot_finite                                                  
> >                                                   
> > __hypot_finite+140715545239563 2.50%     2.50%  [.] __hypot_finite         
> >                                                                            
> >                 __hypot_finite+140715545239576 2.50%     2.50%  [.]
> > std::generate_canonical<double, 53ul,
> > std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>
> > >  std::generate_canonical<double, 53ul, std::line 2.50%     2.50%  [.]
> > std::generate_canonical<double, 53ul,
> > std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>
> > >  std::generate_canonical<double, 53ul, std::line 2.50%     0.00%  [.]
> > __hypot_finite                                                             
> >                                         __hypot_finite+11 ~~~~~
> > 
> > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Yao Jin <yao.jin@linux.intel.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> > 
> > Note how most of the large offset values are now gone. Most notably,
> > we get proper srcline resolution for the random.h and complex headers.
> > ---
> >  tools/perf/util/sort.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> > index 006d10a0dc96..6f3d109078a3 100644
> > --- a/tools/perf/util/sort.c
> > +++ b/tools/perf/util/sort.c
> > @@ -334,7 +334,7 @@ char *hist_entry__get_srcline(struct hist_entry *he)
> >  	if (!map)
> >  		return SRCLINE_UNKNOWN;
> > 
> > -	return get_srcline(map->dso, map__rip_2objdump(map, he->ip),
> > +	return get_srcline(map->dso, map__objdump_2mem(map, he->ip),
> >  			   he->ms.sym, true, true);
> >  }
> 
> Sorry, this patch was declined by Nahmyung before, please discard it - I 
> forgot to do that before resending v6.

I looked into it and found a bug handling cumulative (children)
entries.  For chilren entries that has no self period, the al->addr
(so he->ip) ends up having an doubly-mapped address.

It seems to be there from the beginning but only affects entries that
have no srclines - finding srcline itself is done using a different
address but it will show the invalid address if no srcline was found.
I think we should fix the commit c7405d85d7a3 ("perf tools: Update
cpumode for each cumulative entry").

Could you please test the following patch works for you?


diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 35a920f09503..d18cdcc8d132 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1074,10 +1074,7 @@ int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *
 {
        al->map = node->map;
        al->sym = node->sym;
-       if (node->map)
-               al->addr = node->map->map_ip(node->map, node->ip);
-       else
-               al->addr = node->ip;
+       al->addr = node->ip;
 
        if (al->sym == NULL) {
                if (hide_unresolved)
