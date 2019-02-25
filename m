From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH 11/15] perf script python: add Python3 support to
 stackcollapse.py
Date: Mon, 25 Feb 2019 11:46:25 -0300
Message-ID: <20190225144625.GK31136@kernel.org>
References: <20190222230619.17887-1-tonyj@suse.de>
 <20190222230619.17887-12-tonyj@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190222230619.17887-12-tonyj@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Jones <tonyj@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Feb 22, 2019 at 03:06:15PM -0800, Tony Jones escreveu:
> Support both Python2 and Python3 in the stackcollapse.py script
> 
> There may be differences in the ordering of output lines due to
> differences in dictionary ordering etc.  However the format within lines
> should be unchanged.

Applied
 
> The use of 'from __future__' implies the minimum supported Python2 version
> is now v2.6
> 
> Signed-off-by: Tony Jones <tonyj@suse.de>
> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tools/perf/scripts/python/stackcollapse.py | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/stackcollapse.py b/tools/perf/scripts/python/stackcollapse.py
> index 1697b5e18c96..5e703efaddcc 100755
> --- a/tools/perf/scripts/python/stackcollapse.py
> +++ b/tools/perf/scripts/python/stackcollapse.py
> @@ -19,6 +19,8 @@
>  # Written by Paolo Bonzini <pbonzini@redhat.com>
>  # Based on Brendan Gregg's stackcollapse-perf.pl script.
>  
> +from __future__ import print_function
> +
>  import os
>  import sys
>  from collections import defaultdict
> @@ -120,7 +122,6 @@ def process_event(param_dict):
>      lines[stack_string] = lines[stack_string] + 1
>  
>  def trace_end():
> -    list = lines.keys()
> -    list.sort()
> +    list = sorted(lines)
>      for stack in list:
> -        print "%s %d" % (stack, lines[stack])
> +        print("%s %d" % (stack, lines[stack]))
> -- 
> 2.20.1

-- 

- Arnaldo
