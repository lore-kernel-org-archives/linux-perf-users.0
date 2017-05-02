From: "Jin, Yao" <yao.jin@linux.intel.com>
Subject: Re: [PATCH] perf report: distinguish between inliners in the same
 function
Date: Tue, 2 May 2017 10:11:14 +0800
Message-ID: <ec980cd2-f595-3ed5-5276-4d687480e621@linux.intel.com>
References: <20170427215950.6649-1-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:57525 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750729AbdEBCLR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 1 May 2017 22:11:17 -0400
In-Reply-To: <20170427215950.6649-1-milian.wolff@kdab.com>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>, Linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>


SNIP

> ~~~~~
> $ perf report --stdio --inline --no-children
> Failed to open [ext4], continuing without symbols
> # To display the perf.data header info, please use --header/--header-only
> options.
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 499  of event 'cycles'
> # Event count (approx.): 329354953
> #
> # Overhead  Command    Shared Object      Symbol
> # ........  .........  .................  ................................
> #
>      96.70%  ex_random  ex_random          [.] main
> |
>              ---main
>                 __libc_start_main
>                 _start
> ...
> ~~~~~
>
> Note how no inlined frames are actually shown, because the first
> sample in main points to an IP that does not correspond to any
> inlined frames.

perf report -g address --inline --stdio

Did you try with "-g address" option? It's sorted by address.

But anyway, I like this patch. It works well in my test.

Thanks
Jin Yao
