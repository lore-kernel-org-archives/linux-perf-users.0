From: Kim Phillips <kim.phillips@arm.com>
Subject: Re: kallsyms in buildid - broken mapping?
Date: Tue, 27 Jun 2017 09:25:37 -0500
Message-ID: <20170627092537.cf884ffc179e4d758d456269@arm.com>
References: <6006405.Fli7mH7B85@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752825AbdF0OZk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 27 Jun 2017 10:25:40 -0400
In-Reply-To: <6006405.Fli7mH7B85@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org, namhyung@kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>

On Tue, 27 Jun 2017 16:16:47 +0200
Milian Wolff <milian.wolff@kdab.com> wrote:

> a colleague of mine just sent me a `perf archive` tarball and the accompanying 
> perf.data file. The tarball contains a kallsyms entry with build-id for 
> `[kernel.kallsyms]`. But the file seems to be bogus, it only contains "null" 
> mappings, i.e.:
> 
> $ head kallsyms 
> 0000000000000000 A irq_stack_union
> 0000000000000000 A __per_cpu_start
> 0000000000000000 A exception_stacks
> 0000000000000000 A gdt_page
> 0000000000000000 A espfix_waddr
> 0000000000000000 A espfix_stack
> 0000000000000000 A cpu_info
> 0000000000000000 A cpu_llc_shared_map
> 0000000000000000 A cpu_core_map
> 0000000000000000 A cpu_sibling_map
> $ cut -f1 -d' ' < kallsyms | uniq -c
>  144971 0000000000000000
> 
> He now also sent me a copy of `/proc/kallsyms` which actually seems to contain 
> a useful mapping. Any idea what lead to the broken original mapping?

permissions?

$ cat /proc/kallsyms | cut -f1 -d' ' | uniq -c | wc -l
1
$ sudo cat /proc/kallsyms | cut -f1 -d' ' | uniq -c | wc -l
124969

Kim
