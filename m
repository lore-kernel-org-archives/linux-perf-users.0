From: Prabhat Kumar Ravi <prabhatravi09@gmail.com>
Subject: vmlinux symtab matching kallsyms fails: dso__find_symbol_by_name ----
 end ----
Date: Tue, 25 Jun 2013 11:24:56 +0530
Message-ID: <CAJ_BOiBABAojuwTXCEp1PPF8_rJO8QXkebb5z8JgLEhFyQm+Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-vb0-f50.google.com ([209.85.212.50]:52760 "EHLO
	mail-vb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741Ab3FYFy5 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 25 Jun 2013 01:54:57 -0400
Received: by mail-vb0-f50.google.com with SMTP id w16so8987337vbb.23
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Jun 2013 22:54:56 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

On 3.4-rc49, I got following failure running `perf test`:

/ # perf test -v 1
 1: vmlinux symtab matches kallsyms:
--- start ---
dso__find_symbol_by_name ---- end ----
vmlinux symtab matches kallsyms: FAILED!

Perf test is failing at dsofind_symbol_by_name

where

        kallsyms_map = machine__kernel_map(&kallsyms, type);

     sym = map__find_symbol_by_name(kallsyms_map, ref_reloc_sym.name, NULL);
     if (sym == NULL) {
                pr_debug("dso__find_symbol_by_name ");
                goto out;
        }

Here sym is search for "_stext" which is NULL here so perf test fails
here only.

On investigation found that _stext having same address as asm_do_IRQ
and exception_text_start,

c00081c0 T asm_do_IRQ
c00081c0 T _stext
c00081c0 T __exception_text_start

so being deleted by symbolsfixup_duplicate in

if (choose_best_symbol(curr, next) == SYMBOL_A) {

                        rb_erase(&next->rb_node, symbols); --> symbole
getting erase here.
                        goto again;
                } else {


My doubt is, Is we really need this commit??:

commit 3f5a42722b9e78a434d5a4ee5e607dc33c69ac80
Author: Anton Blanchard <anton@samba.org>
Date:   Wed Aug 24 16:40:15 2011 +1000

    perf symbols: /proc/kallsyms does not sort module symbols

    kallsyms__parse assumes that /proc/kallsyms is sorted and sets the end
    of the previous symbol to the start of the current one.

    Unfortunately module symbols are not sorted, eg:

    ffffffffa0081f30 t e1000_clean_rx_irq   [e1000e]
    ffffffffa00817a0 t e1000_alloc_rx_buffers       [e1000e]

    Some symbols end up with a negative length and others have a length
    larger than they should. This results in confusing perf output.

    We already have a function to fixup the end of zero length symbols so
    use that instead.

Or we can search for other string.??
