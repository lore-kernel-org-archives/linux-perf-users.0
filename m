From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [Suggestion/Problems] perf annoate: Some problems related to the
 source code view and Improvement of it with line numbers
Date: Wed, 15 Feb 2017 10:24:11 -0300
Message-ID: <20170215132411.GF4020@kernel.org>
References: <5c703d64-3ef4-3d43-bf99-f14c5fc4cdac@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750806AbdBONYS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 15 Feb 2017 08:24:18 -0500
Content-Disposition: inline
In-Reply-To: <5c703d64-3ef4-3d43-bf99-f14c5fc4cdac@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Taeung Song <treeze.taeung@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, perf group <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>

Em Wed, Feb 15, 2017 at 09:34:51PM +0900, Taeung Song escreveu:
> Hi all :)
> 
> I found some problems about showing line numbers of perf-annotate.
> and I have a suggestion about perf-annotate.
> 
> Sure, I have a plan to send the patchset about that.
> But I'd like to know other opinions about that before sending the patchset.
> :)

Humm, TLDR, please try to find one problem, describe it precisely, show
before and after results (in the changeset message), and send it, rinse,
repeat.

For instance, if the line numbers are different in --stdio and --tui,
that is a problem, state that, show the output (as you did below), put
it in a patch, send it.

Thanks,

- Arnaldo
 
> If the user do perf-annotate,
> 
>     # perf record ./a.out
>     [ perf record: Woken up 1 times to write data ]
>     [ perf record: Captured and wrote 0.043 MB perf.data (799 samples) ]
> 
>     # perf annotate
> 
> (In TUI, if using a 'k' option to see line numbers)
> 
>        │3   Disassembly of section .text:
>        │
>        │5   0000000000400966 <get_cond_maxprice>:
>        │6   get_cond_maxprice():
>        │7   };
>        │
>        │9   unsigned int limited_wgt;
>        │
>        │11  unsigned int get_cond_maxprice(int wgt, struct jewelry *jewelry)
>        │12  {
> 
> But I think it has some problems and seems a bit deficient..
> There are several reasons as below.
> 
>     1) I think we don't need the line numbers except for source codes
> 
>        │3   Disassembly of section .text:
>        │
>        │5   0000000000400966 <get_cond_maxprice>:
>        │6   get_cond_maxprice():
> 
> I think that '3', '5' and '6' seems like needless.
> 
>     2) The line numbers aren't correct
> (But they are correct if perf-annotate work with --stdio)
> 
> If we check the actual source file as below,
> we can find many wrong line numbers on perf-annotate.
> 
> (e.g. A actual line number of get_cond_amxprice() is 25,
> but the line number of the function on perf-annotate is 11.)
> 
> ...
>  18 struct jewelry {
>  19         unsigned int wgt;
>  20         unsigned int price;
>  21 };
>  22
>  23 unsigned int limited_wgt;
>  24
>  25 unsigned int get_cond_maxprice(int wgt, struct jewelry *jewelry)
>  26 {
>  27         /* Get maximum price based on a specific weight
> 
>  28          * following a specific jewelry.
> 
>  29          */
>  30         int i;
>  31         unsigned int nr_cases = wgt/jewelry->wgt;
>  32         unsigned int maxprice = 0;
> ...
> 
> Sure, the correct line numbers partially exist as well
> but there are more wrong line numbers than them.
> 
>     3) It is hard to read source code + assembly code of perf-annoate.
>        If the user want to see source code on perf-annotate,
>        In TUI the user can use 'k' option but the output is mixed with
>        both source code and assembly code so it's so confusing.. :-\
>        and the readability is not good.. :(
>        And the line numbers aren't even wrong..
> 
>        So, I suggest first showing source code before assembly code
>        only when the target program has debug info.
>        If we do, perf-annotate provide good readable source code view per
> function
>        and correct line numbers. :)
> 
> For example,
> If there is 'get_cond_maxprice()' on a source file as below,
> 
> ... (with line numbers) ...
>  25 unsigned int get_cond_maxprice(int wgt, struct jewelry *jewelry)
>  26 {
>  27         /* Get maximum price based on a specific weight
> 
>  28          * following a specific jewelry.
> 
>  29          */
>  30         int i;
>  31         unsigned int nr_cases = wgt/jewelry->wgt;
>  32         unsigned int maxprice = 0;
>  33
>  34         for (i = 1; i <= nr_cases; i++) {
>  35                 unsigned int price, rest_wgt;
>  36
>  37                 rest_wgt = wgt - (i * jewelry->wgt);
>  38                 price = (i * jewelry->price) +
> knapsack_list[rest_wgt].maxprice;
>  39                 if (maxprice < price)
>  40                         maxprice = price;
>  41         }
>  42
>  43         return maxprice;
>  44 }
> ...
> 
> And if the target program(e.g. a.out) compiled with the source file has
> debug info,
> we can first show source code before assembly code for good readability as
> below.
> (If we do, the user don't be confusing due to mixed parts of code any more)
> 
>     # perf record ./a.out
>     [ perf record: Woken up 1 times to write data ]
>     [ perf record: Captured and wrote 0.043 MB perf.data (799 samples) ]
> 
>     # perf annoate (using 'k' option in TUI)
> ...
>        │25 unsigned int get_cond_maxprice(int wgt, struct jewelry *jewelry)
>   2.21 │26 {
>        │27         /* Get maximum price based on a specific weight
> 
>        │28          * following a specific jewelry.
> 
>        │29          */
>        │30         int i;
>   4.43 │31         unsigned int nr_cases = wgt/jewelry->wgt;
>        │32         unsigned int maxprice = 0;
>        │33
>   7.49 │34         for (i = 1; i <= nr_cases; i++) {
>        │35                 unsigned int price, rest_wgt;
>        │36
>  29.12 │37                 rest_wgt = wgt - (i * jewelry->wgt);
>  15.83 │38                 price = (i * jewelry->price) +
> knapsack_list[rest_wgt].maxprice;
>  17.38 │39                 if (maxprice < price)
>   0.34 │40                         maxprice = price;
>        │41         }
>        │42
>   1.19 │43         return maxprice;
>   1.19 │44 }
> 
> 
> And if the user want to see not only source code but also assembly code,
> we can show as below.
> (This output is similar to current annotate view
> but it sequentially show full code of the function, not confusing mixed
> parts of code
> And this output show correct line numbers unlike current annotate view)
> 
>        │25 unsigned int get_cond_maxprice(int wgt, struct jewelry *jewelry)
>        │26 {
>   0.17 │      push   %rbp
>        │      mov    %rsp,%rbp
>        │      sub    $0x30,%rsp
>   0.51 │    → callq  mcount@plt
>        │      mov    %edi,-0x24(%rbp)
>   1.53 │      mov    %rsi,-0x30(%rbp)
>        │27         /* Get maximum price based on a specific weight
> 
>        │28          * following a specific jewelry.
> 
>        │29          */
>        │30         int i;
>        │31         unsigned int nr_cases = wgt/jewelry->wgt;
>        │      mov    -0x24(%rbp),%eax
>        │      mov    -0x30(%rbp),%rdx
>   0.34 │      mov    (%rdx),%esi
>   1.36 │      mov    $0x0,%edx
>   2.73 │      div    %esi
>        │      mov    %eax,-0xc(%rbp)
>        │32         unsigned int maxprice = 0;
>        │      movl   $0x0,-0x10(%rbp)
>        │33
>        │34         for (i = 1; i <= nr_cases; i++) {
>        │      movl   $0x1,-0x14(%rbp)
>        │    ↓ jmp    <get_cond_maxprice+0x84>
>        │35                 unsigned int price, rest_wgt;
>        │36
>        │37                 rest_wgt = wgt - (i * jewelry->wgt);
>   1.53 │      mov    -0x24(%rbp),%edx
>        │      mov    -0x30(%rbp),%rax
>   0.51 │      mov    (%rax),%ecx
>  10.56 │      mov    -0x14(%rbp),%eax
>   1.70 │      imul   %ecx,%eax
>   0.34 │      sub    %eax,%edx
>   1.36 │      mov    %edx,%eax
>  13.12 │      mov    %eax,-0x8(%rbp)
>        │38                 price = (i * jewelry->price) +
> knapsack_list[rest_wgt].maxprice;
>   1.87 │      mov    -0x30(%rbp),%rax
>   0.34 │      mov    0x4(%rax),%edx
>   0.85 │      mov    -0x14(%rbp),%eax
>  10.90 │      imul   %eax,%edx
>   1.87 │      mov    knapsack_list,%rax
>        │      mov    -0x8(%rbp),%ecx
>   0.68 │      shl    $0x2,%rcx
>  11.24 │      add    %rcx,%rax
>   3.58 │      mov    (%rax),%eax
>   2.39 │      add    %edx,%eax
>   2.90 │      mov    %eax,-0x4(%rbp)
>        │39                 if (maxprice < price)
>   7.67 │      mov    -0x10(%rbp),%eax
>        │      cmp    -0x4(%rbp),%eax
>   9.71 │    ↓ jae    <get_cond_maxprice+0x80>
>        │40                         maxprice = price;
>        │      mov    -0x4(%rbp),%eax
>   0.34 │      mov    %eax,-0x10(%rbp)
>        │
>   3.58 │      addl   $0x1,-0x14(%rbp)
>   1.36 │      mov    -0x14(%rbp),%eax
>   0.34 │      cmp    -0xc(%rbp),%eax
>   2.21 │    ↑ jbe    <get_cond_maxprice+0x37>
>        │41         }
>        │42
>        │43         return maxprice;
>   1.19 │      mov    -0x10(%rbp),%eax
>        │44 }
>   0.68 │      leaveq
>   0.51 │    ← retq
> 
> 
> Sure, we can show only assembly code as below (this is current feature)
> (Of course, the target program hasn't debug info, perf-annotate show
> assembly code as below)
> 
>     # perf annotate
> 
>   0.17 │      push   %rbp
>        │      mov    %rsp,%rbp
>        │      sub    $0x30,%rsp
>   0.51 │    → callq  mcount@plt
>        │      mov    %edi,-0x24(%rbp)
>   1.53 │      mov    %rsi,-0x30(%rbp)
>        │      mov    -0x24(%rbp),%eax
>        │      mov    -0x30(%rbp),%rdx
>   0.34 │      mov    (%rdx),%esi
>   1.36 │      mov    $0x0,%edx
>   2.73 │      div    %esi
>        │      mov    %eax,-0xc(%rbp)
>        │      movl   $0x0,-0x10(%rbp)
>        │      movl   $0x1,-0x14(%rbp)
>        │    ↓ jmp    84
>   1.53 │37:   mov    -0x24(%rbp),%edx
>        │      mov    -0x30(%rbp),%rax
>   0.51 │      mov    (%rax),%ecx
>  10.56 │      mov    -0x14(%rbp),%eax
>   1.70 │      imul   %ecx,%eax
>   0.34 │      sub    %eax,%edx
>   1.36 │      mov    %edx,%eax
>  13.12 │      mov    %eax,-0x8(%rbp)
>   1.87 │      mov    -0x30(%rbp),%rax
>   0.34 │      mov    0x4(%rax),%edx
>   0.85 │      mov    -0x14(%rbp),%eax
>  10.90 │      imul   %eax,%edx
>   1.87 │      mov    knapsack_list,%rax
>        │      mov    -0x8(%rbp),%ecx
>   0.68 │      shl    $0x2,%rcx
>  11.24 │      add    %rcx,%rax
>   3.58 │      mov    (%rax),%eax
>   2.39 │      add    %edx,%eax
>   2.90 │      mov    %eax,-0x4(%rbp)
>   7.67 │      mov    -0x10(%rbp),%eax
>        │      cmp    -0x4(%rbp),%eax
>   9.71 │    ↓ jae    80
>        │      mov    -0x4(%rbp),%eax
>   0.34 │      mov    %eax,-0x10(%rbp)
>   3.58 │80:   addl   $0x1,-0x14(%rbp)
>   1.36 │84:   mov    -0x14(%rbp),%eax
>   0.34 │      cmp    -0xc(%rbp),%eax
>   2.21 │    ↑ jbe    37
>   1.19 │      mov    -0x10(%rbp),%eax
>   0.68 │      leaveq
>   0.51 │    ← retq
> 
> 
> What do you think about the suggestion and some problems ?
> Just send patchset for this problems and the my suggestion ?
> 
> I think the lack comes from the output of objdump command.
> perf internally handle source codes and line numbers
> by output of objdump with 'd' and 'S' as below.
> 
>     # cat util/annotate.c
> ...
> 1436                  "%s %s%s --start-address=0x%016" PRIx64
> 1437                  " --stop-address=0x%016" PRIx64
> 1438                  " -l -d %s %s -C %s 2>/dev/null|grep -v %s|expand",
> 1439                  objdump_path ? objdump_path : "objdump",
> 1440                  disassembler_style ? "-M " : "",
> 1441                  disassembler_style ? disassembler_style : "",
> 1442                  map__rip_2objdump(map, sym->start),
> 1443                  map__rip_2objdump(map, sym->end),
> 1444                  symbol_conf.annotate_asm_raw ? "" : "--no-show-raw",
> 1445                  symbol_conf.annotate_src ? "-S" : "",
> 1446                  symfs_filename, symfs_filename);
> ...
> 
> So if we don't rely on a feature '-S' of objdump and
> if we read the actual source file,
> I think perf-annotate can provide more readable source code view per
> function
> and more precise line numbers.
> 
> Thanks,
> Taeung
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
