From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: vmlinux symtab matching kallsyms fails: dso__find_symbol_by_name
 ---- end ----
Date: Tue, 25 Jun 2013 11:07:02 +0200
Message-ID: <20130625090702.GA4865@krava.brq.redhat.com>
References: <CAJ_BOiBABAojuwTXCEp1PPF8_rJO8QXkebb5z8JgLEhFyQm+Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35085 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751219Ab3FYJHH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 25 Jun 2013 05:07:07 -0400
Content-Disposition: inline
In-Reply-To: <CAJ_BOiBABAojuwTXCEp1PPF8_rJO8QXkebb5z8JgLEhFyQm+Hw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Prabhat Kumar Ravi <prabhatravi09@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Tue, Jun 25, 2013 at 11:24:56AM +0530, Prabhat Kumar Ravi wrote:
> On 3.4-rc49, I got following failure running `perf test`:
> 
> / # perf test -v 1
>  1: vmlinux symtab matches kallsyms:
> --- start ---
> dso__find_symbol_by_name ---- end ----
> vmlinux symtab matches kallsyms: FAILED!
> 
> Perf test is failing at dsofind_symbol_by_name
> 
> where
> 
>         kallsyms_map = machine__kernel_map(&kallsyms, type);
> 
>      sym = map__find_symbol_by_name(kallsyms_map, ref_reloc_sym.name, NULL);
>      if (sym == NULL) {
>                 pr_debug("dso__find_symbol_by_name ");
>                 goto out;
>         }
> 
> Here sym is search for "_stext" which is NULL here so perf test fails
> here only.
> 
> On investigation found that _stext having same address as asm_do_IRQ
> and exception_text_start,
> 
> c00081c0 T asm_do_IRQ
> c00081c0 T _stext
> c00081c0 T __exception_text_start
> 
> so being deleted by symbolsfixup_duplicate in
> 
> if (choose_best_symbol(curr, next) == SYMBOL_A) {
> 
>                         rb_erase(&next->rb_node, symbols); --> symbole
> getting erase here.
>                         goto again;
>                 } else {
> 
> 

I recently fixed this test for another kind of error rising from
the /proc/kallsyms being not as precise as vmlinux file. This one
looks like another one.

acme's tree:
  b8bae2c perf tests: Omit end of the symbol check failure for test 1

> My doubt is, Is we really need this commit??:
> 
> commit 3f5a42722b9e78a434d5a4ee5e607dc33c69ac80
> Author: Anton Blanchard <anton@samba.org>
> Date:   Wed Aug 24 16:40:15 2011 +1000
> 
>     perf symbols: /proc/kallsyms does not sort module symbols
> 
>     kallsyms__parse assumes that /proc/kallsyms is sorted and sets the end
>     of the previous symbol to the start of the current one.
> 
>     Unfortunately module symbols are not sorted, eg:
> 
>     ffffffffa0081f30 t e1000_clean_rx_irq   [e1000e]
>     ffffffffa00817a0 t e1000_alloc_rx_buffers       [e1000e]
> 
>     Some symbols end up with a negative length and others have a length
>     larger than they should. This results in confusing perf output.
> 
>     We already have a function to fixup the end of zero length symbols so
>     use that instead.
> 
> Or we can search for other string.??

This one looks important, I think we should fix the test again.
Maybe bisable duplicates removal for test? Keep removed symbols
list? ;-)

jirka
