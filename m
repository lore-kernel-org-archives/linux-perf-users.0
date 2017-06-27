From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: kallsyms in buildid - broken mapping?
Date: Wed, 28 Jun 2017 00:00:10 +0200
Message-ID: <2160227.6G76yXCJW2@agathebauer>
References: <6006405.Fli7mH7B85@milian-kdab2> <20170627092537.cf884ffc179e4d758d456269@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:38118 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753827AbdF0WAN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 27 Jun 2017 18:00:13 -0400
In-Reply-To: <20170627092537.cf884ffc179e4d758d456269@arm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Kim Phillips <kim.phillips@arm.com>
Cc: linux-perf-users@vger.kernel.org, namhyung@kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>

On Dienstag, 27. Juni 2017 16:25:37 CEST Kim Phillips wrote:
> On Tue, 27 Jun 2017 16:16:47 +0200
> 
> Milian Wolff <milian.wolff@kdab.com> wrote:
> > a colleague of mine just sent me a `perf archive` tarball and the
> > accompanying perf.data file. The tarball contains a kallsyms entry with
> > build-id for `[kernel.kallsyms]`. But the file seems to be bogus, it only
> > contains "null" mappings, i.e.:
> > 
> > $ head kallsyms
> > 0000000000000000 A irq_stack_union
> > 0000000000000000 A __per_cpu_start
> > 0000000000000000 A exception_stacks
> > 0000000000000000 A gdt_page
> > 0000000000000000 A espfix_waddr
> > 0000000000000000 A espfix_stack
> > 0000000000000000 A cpu_info
> > 0000000000000000 A cpu_llc_shared_map
> > 0000000000000000 A cpu_core_map
> > 0000000000000000 A cpu_sibling_map
> > $ cut -f1 -d' ' < kallsyms | uniq -c
> > 
> >  144971 0000000000000000
> > 
> > He now also sent me a copy of `/proc/kallsyms` which actually seems to
> > contain a useful mapping. Any idea what lead to the broken original
> > mapping?
> permissions?
> 
> $ cat /proc/kallsyms | cut -f1 -d' ' | uniq -c | wc -l
> 1
> $ sudo cat /proc/kallsyms | cut -f1 -d' ' | uniq -c | wc -l
> 124969

Ah, thanks. I can reproduce it now locally:

~~~~~
tmp$ cat /proc/sys/kernel/kptr_restrict
1
tmp$ head /proc/kallsyms
0000000000000000 A irq_stack_union
0000000000000000 A __per_cpu_start
0000000000000000 T startup_64
0000000000000000 T _stext
0000000000000000 T _text
0000000000000000 T secondary_startup_64
0000000000000000 T start_cpu
0000000000000000 t verify_cpu
0000000000000000 T start_cpu0
0000000000000000 t bad_address
tmp$ echo 0 | sudo tee /proc/sys/kernel/kptr_restrict
0
tmp$ head /proc/kallsyms 
0000000000000000 A irq_stack_union
0000000000000000 A __per_cpu_start
ffffffff81000000 T startup_64
ffffffff81000000 T _stext
ffffffff81000000 T _text
ffffffff81000120 T secondary_startup_64
ffffffff810001b0 T start_cpu
ffffffff810001c4 t verify_cpu
ffffffff810002c0 T start_cpu0
ffffffff810002cc t bad_address
~~~~~

But when I try to record with a restricted kptr, perf shows this error:

~~~~~
WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,
check /proc/sys/kernel/kptr_restrict.

Samples in kernel functions may not be resolved if a suitable vmlinux
file is not found in the buildid cache or in the vmlinux path.

Samples in kernel modules won't be resolved at all.

If some relocation was applied (e.g. kexec) symbols may be misresolved
even with a suitable vmlinux or kallsyms file.
~~~~~

So how could I possibly end up with such a broken kallsyms file in my build-id 
cache?

Thanks
-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
