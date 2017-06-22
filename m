From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] perf probe: Fix probe definition for inlined functions
Date: Thu, 22 Jun 2017 19:01:38 +0900
Message-ID: <20170622190138.b9fdfaada8da0af1b8cf6990@kernel.org>
References: <20170621164134.5701-1-bjorn.topel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751818AbdFVKBl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Jun 2017 06:01:41 -0400
In-Reply-To: <20170621164134.5701-1-bjorn.topel@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>, linux-perf-users <linux-perf-users@vger.kernel.org>, magnus.karlsson@intel.com

On Wed, 21 Jun 2017 18:41:34 +0200
Björn Töpel <bjorn.topel@gmail.com> wrote:

> From: Björn Töpel <bjorn.topel@intel.com>
> 
> In commit 613f050d68a8 ("perf probe: Fix to probe on gcc generated
> functions in modules"), the offset from symbol is, incorrectly, added
> to the trace point address. This leads to incorrect probe trace points
> for inlined functions and when using relative line number on symbols.
> 
> Prior this patch:
>   $ perf probe -m nf_nat -D in_range
>   p:probe/in_range nf_nat:in_range.isra.9+0
>   $ perf probe -m i40e -D i40e_clean_rx_irq
>   p:probe/i40e_clean_rx_irq i40e:i40e_napi_poll+2212
>   $ perf probe -m i40e -D i40e_clean_rx_irq:16
>   p:probe/i40e_clean_rx_irq i40e:i40e_lan_xmit_frame+626
> 
> After:
>   $ perf probe -m nf_nat -D in_range
>   p:probe/in_range nf_nat:in_range.isra.9+0
>   $ perf probe -m i40e -D i40e_clean_rx_irq
>   p:probe/i40e_clean_rx_irq i40e:i40e_napi_poll+1106
>   $ perf probe -m i40e -D i40e_clean_rx_irq:16
>   p:probe/i40e_clean_rx_irq i40e:i40e_napi_poll+2665

OK, I've confirmed it. This bug also affects -D option for
offline probes...

$ ./perf probe -k ~/kbin/linux.x86_64/vmlinux -vD vfs_read:11
probe-definition(0): vfs_read:11
[...]
Try to find probe point from debuginfo.
Matched function: vfs_read [28b211e]
Probe point found: vfs_read+90  <- here vfs_read+90
Found 1 probe_trace_events.
p:probe/vfs_read vfs_read+180   <- here vfs_read+180 = 90+90

So offset to be doubled...

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Arnaldo, this should go to urgent/stable. 

Thank you!

> 
> Fixes: 613f050d68a8 ("perf probe: Fix to probe on gcc generated functions in modules")
> Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
> ---
>  tools/perf/util/probe-event.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 84e7e698411e..a2670e9d652d 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -619,7 +619,7 @@ static int post_process_probe_trace_point(struct probe_trace_point *tp,
>  					   struct map *map, unsigned long offs)
>  {
>  	struct symbol *sym;
> -	u64 addr = tp->address + tp->offset - offs;
> +	u64 addr = tp->address - offs;
>  
>  	sym = map__find_symbol(map, addr);
>  	if (!sym)
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Masami Hiramatsu <mhiramat@kernel.org>
