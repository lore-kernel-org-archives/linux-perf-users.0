From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: [PATCH] perf report: distinguish between inliners in the same function
Date: Tue, 02 May 2017 11:19:16 +0200
Message-ID: <1762527.9gve7JI6US@milian-kdab2>
References: <20170427215950.6649-1-milian.wolff@kdab.com> <ec980cd2-f595-3ed5-5276-4d687480e621@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ec980cd2-f595-3ed5-5276-4d687480e621@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Jin, Yao" <yao.jin@linux.intel.com>
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-perf-users.vger.kernel.org

On Tuesday, May 2, 2017 4:11:14 AM CEST Jin, Yao wrote:
> SNIP
> 
> > ~~~~~
> > $ perf report --stdio --inline --no-children
> > Failed to open [ext4], continuing without symbols
> > # To display the perf.data header info, please use --header/--header-only
> > options.
> > #
> > #
> > # Total Lost Samples: 0
> > #
> > # Samples: 499  of event 'cycles'
> > # Event count (approx.): 329354953
> > #
> > # Overhead  Command    Shared Object      Symbol
> > # ........  .........  .................  ................................
> > #
> > 
> >      96.70%  ex_random  ex_random          [.] main
> >      
> >              ---main
> >              
> >                 __libc_start_main
> >                 _start
> > 
> > ...
> > ~~~~~
> > 
> > Note how no inlined frames are actually shown, because the first
> > sample in main points to an IP that does not correspond to any
> > inlined frames.
> 
> perf report -g address --inline --stdio
> 
> Did you try with "-g address" option? It's sorted by address.

Yes, that would work just like `-g srcline`. But that is besides the point. If 
I want to aggregate by function, I still want to split different inline 
frames, otherwise the results will be misleading.

> But anyway, I like this patch. It works well in my test.

I fear that the patch is not ready for acceptance though. It fails when the 
sort-order is inverted, i.e. the snippet I included in my patch uses `--no-
children` which works well. But for top-down call-graphs I will need to 
compare the full inlined call stack, otherwise we just get this:

    99.35%     0.00%  a.out    libc-2.25.so       [.] __libc_start_main
            |
            ---__libc_start_main
               |          
               |--72.56%--main
               |          main (inline)
               |          
std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned 
long, 16807ul, 0ul, 2147483647ul> > (inline)
               |          
std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned 
long, 16807ul, 0ul, 2147483647ul> > (inline)
               |          
std::__detail::_Adaptor<std::linear_congruential_engine<unsigned long, 
16807ul, 0ul, 2147483647ul>, double>::operator() (inline)
               |          
                --26.80%--main

The problem here is that all samples in main start with the same inlined 
frame, the "main (inline)" one. Even if that wouldn't be there, we'd still get 
wrong results if we inline a function A which in turns has two other functions 
B and C inlined. we need to split the graph for that situation too, but we 
don't so far...

I'll try t find the time to improve this situation, thanks for the early 
review already Jin!

Cheers


-- 
Milian Wolff | milian.wolff@kdab.com | Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
