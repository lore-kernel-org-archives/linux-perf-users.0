Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB17C11F65
	for <linux-perf-users@archiver.kernel.org>; Wed, 30 Jun 2021 16:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2E806147D
	for <linux-perf-users@archiver.kernel.org>; Wed, 30 Jun 2021 16:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235892AbhF3QEj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 30 Jun 2021 12:04:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235822AbhF3QEj (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 30 Jun 2021 12:04:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7C4261405;
        Wed, 30 Jun 2021 16:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625068930;
        bh=dAVMpwZD3vQwm3KNBeiCc5/n8HGW7y6qHY/zqcgQlDU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mXk9RZOgCDGqjAtNzDS2G9eargkBylRy+f+UxVaLJepr9Bf2wqQWOhJ2Lpl5frqaz
         PeC+mdzHtescjCLsdQAHCaIIW8lOomRtzml76qIkK+Oy4xTz7BBRoVVdt302ZAFlti
         eCJTE+0RFeqyz8pCk7iUbJTcgkid1pW/tyUP3CTOMXbr9zSjeBMf4my/O5bOTd5uos
         WlAe3dDbYslHcBYT8sd0TT5+iepFm1k+XDocinfJEoTUT5EMo8Bt/5et/y8ROPVE7z
         x7I4vhrcBsTM78RLcQX/a5Rx9ZswZQlAhax0Q/d3RXQsXrgQCtSqPLl019VXPi/ErU
         WsXmQoJ7x1UxA==
Date:   Thu, 1 Jul 2021 01:02:08 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Stefan Liebler <stli@linux.ibm.com>
Subject: Re: Part 2: perf test case probe libc fails with latest Fedora34
 glibc update
Message-Id: <20210701010208.6c5129241ab490bc6a6b3197@kernel.org>
In-Reply-To: <a3b3487d-7eb7-cbdb-0bfb-d94cc621da83@linux.ibm.com>
References: <cae863a4-bf83-f87b-6e71-b6a544678cae@linux.ibm.com>
        <f6752514-eaf9-371e-f81b-0d9e41ebae0c@linux.ibm.com>
        <20210629140242.c16d9bf368865025e0ead480@kernel.org>
        <a3b3487d-7eb7-cbdb-0bfb-d94cc621da83@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Thomas,

OK, I finally found 2 root causes for this issue.

1. debuginfo__new() forgot to call dso__load(). Thus, the dso is
just initialized, but doesn't load the build-id. Then the build-id
based debuginfo file is not searched. It must use map instead of dso.

2. Not sure why, but /usr/lib64/libc-2.33.so is shown as "not stripped"
binary. Then the elfutils is fooled by the information and open it
as a debuginfo file. I think probe-finder.c also need to check the
given file has DIE tree (debuginfo) or not by itself.

Thank you,


On Tue, 29 Jun 2021 08:42:15 +0200
Thomas Richter <tmricht@linux.ibm.com> wrote:

> On 6/29/21 7:02 AM, Masami Hiramatsu wrote:
> > On Fri, 25 Jun 2021 12:43:29 +0200
> > Thomas Richter <tmricht@linux.ibm.com> wrote:
> > 
> >> I think I found one issue:
> >>
> >> Fedora 33 named the debug files for glibc 'libc-2.33.so.debug'
> >> [root@s8360047 ~]# rpm -ql glibc-debuginfo-2.33-5.fc34.s390x|fgrep libc-2.33.so
> >> /usr/lib/debug/lib64/libc-2.33.so.debug
> >> [root@s8360047 ~]#
> >>
> >> The file was located in
> >>    /usr/lib/debug/lib64/libc-2.33.so.debug
> >> and hard linked to (or vice versa)
> >>    /usr/lib/debug/usr/lib64/libc-2.33.so.debug
> >>
> >> With Fedora 34 the glibc debug file name changed to:
> >> /usr/lib/debug/lib64/libc-2.33.so-2.33-18.fc34.s390x.debug
> >> and
> >> /usr/lib/debug/usr/lib64/libc-2.33.so-2.33-18.fc34.x86_64.debug
> > 
> > Oh, the naming scheme has been changed.
> > 
> >>
> >> This is important. The call chain is
> >>
> >>  ...
> >>  try_to_find_probe_trace_events()
> >>  +-> open_debuginfo()
> >>      +-> debuginfo__new(/usr/lib64/libc-2.33.so)
> >>          +-> dso__read_binary_type_filename()
> >>
> >> Function dso__read_binary_type_filename() now tries to find the debug file
> >> for /usr/lib64/libc-2.33.so for various distros starting with
> >> FEDORA_DEBUGINFO. Tt builds the file name by prepending
> >> '/usr/lib/debug' and appending '.debug'. This was ok until the Fedora 34
> >> name change. Now the debug file is not found anymore and various other
> >> distro name schemes are tried. None is found and the /usr/lib64/libc-2.33.so
> >> file itself is used.
> > 
> > Hmm, we might need a generic way to get such debuginfo path among
> > linux distros... are there any good command?
> 
> IMHO The only option that makes sense is to use the buildid:
> The s390 compiler team recommended this to me.
> 
> [root@t35lp46 perf]# file /usr/lib64/libc-2.33.so
> /usr/lib64/libc-2.33.so: ELF 64-bit MSB shared object, IBM S/390, version 1 (GNU/Linux), dynamically linked, interpreter /lib/ld64.so.1, BuildID[sha1]=15da6d15f3b4d5042dab1246222479e577fe9190, for GNU/Linux 3.2.0, not stripped
> [root@t35lp46 perf]# ll /root/.debug/.build-id/15/da6d15f3b4d5042dab1246222479e577fe9190/
> total 7912
> -rw-r--r-- 2 root root 6372968 Jun 21 09:01 debug
> -rwxr-xr-x 2 root root 1719672 Jun 21 09:01 elf
> -rw-r--r-- 1 root root    4754 Jun 23 10:23 probes
> [root@t35lp46 perf]# readelf -s /root/.debug/.build-id/15/da6d15f3b4d5042dab1246222479e577fe9190/debug | fgrep ' inet_pton'
>  21092: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS inet_pton.c
>  21105: 0000000000123150   250 FUNC    LOCAL  DEFAULT   13 inet_pton4
>  21108: 0000000000123250   524 FUNC    LOCAL  DEFAULT   13 inet_pton6
>  27909: 00000000001234c0   106 FUNC    WEAK   DEFAULT   13 inet_pton
> [root@t35lp46 perf]# 
> 
> The bad thing is that only the file part xx/yy/debug seems to be agreed upon
> between distros. There are multiple/different locations containing .build-id directories.
> 
> On the other hand, perf is connected to the kernel, so we could 'convince'
> the distro's to use their distro specific locations when they build perf.
> 
> [....] 
> 
> >>
> >> Second issue:
> >> The symbol 'inet_pton' is defined as WEAK. Even when the correct
> >> debuginfo file is loaded for libc in function dso__read_binary_type_filename(),
> >> the perf probe command fails.
> >> However it works for GLOBAL and LOCAL symbols, so it would be definitly an 
> >> improvement.
> >>
> >> I have no clue on dwarf so I put Masami on the addressee list.
> >> This second issue is somehow related to dwarf_getfuncs() and
> >> the probe_point_search_cb() call back function invoked by dwarf_getfuncs()
> >> in the probe_finder.c file. Too far away from my horizon :-)...
> >>
> >> On 6/23/21 4:21 PM, Thomas Richter wrote:
> >>> I just updated Fedora34 to the latest level and discovered that perf test 78 fails:
> >>> [root@m46lp22 perf]# ./perf test 78
> >>> 78: probe libc's inet_pton & backtrace it with ping                 : FAILED!
> >>> [root@m46lp22 perf]#
> >>>
> >>> It boils down to this command and happens after glibc is update to level 2.33-18.
> >>>
> >>> [root@f34 ~]# perf probe -f -x /usr/lib64/libc-2.33.so -a inet_pton
> >>> Probe point 'inet_pton' not found.
> >>>   Error: Failed to add events.
> > 
> > Hmm, what does "nm" say? Also, Does perf correctly open the debuginfo file or only
> > open the library without debuginfo?
> 
> # nm -D /usr/lib64/libc-2.33.so | fgrep inet_pton
> 00000000001234c0 W inet_pton@@GLIBC_2.2
> 0000000000123460 T __inet_pton_length@@GLIBC_PRIVATE
> # readelf -s /usr/lib64/libc-2.33.so | fgrep inet_pton
>    673: 00000000001234c0   106 FUNC    WEAK   DEFAULT   13 inet_pton@@GLIBC_2.2
> # nm -D /root/.debug/usr/lib64/libc-2.33.so/15da6d15f3b4d5042dab1246222479e577fe9190/debug | fgrep inet_pton
> nm: /root/.debug/usr/lib64/libc-2.33.so/15da6d15f3b4d5042dab1246222479e577fe9190/debug: no symbols
> # readelf -s /root/.debug/usr/lib64/libc-2.33.so/15da6d15f3b4d5042dab1246222479e577fe9190/debug | fgrep inet_pton
>  21092: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS inet_pton.c
>  21105: 0000000000123150   250 FUNC    LOCAL  DEFAULT   13 inet_pton4
>  21108: 0000000000123250   524 FUNC    LOCAL  DEFAULT   13 inet_pton6
>  24179: 0000000000123460    90 FUNC    LOCAL  DEFAULT   13 __GI___inet_pton[...]
>  24463: 00000000001234c0   106 FUNC    LOCAL  DEFAULT   13 __inet_pton
>  25102: 00000000001234c0   106 FUNC    LOCAL  DEFAULT   13 __GI___inet_pton
>  26439: 00000000001234c0   106 FUNC    LOCAL  DEFAULT   13 __GI_inet_pton
>  27023: 0000000000123460    90 FUNC    GLOBAL DEFAULT   13 __inet_pton_length
>  27909: 00000000001234c0   106 FUNC    WEAK   DEFAULT   13 inet_pton
> # readelf -s /root/.debug/usr/lib64/libc-2.33.so/15da6d15f3b4d5042dab1246222479e577fe9190/elf | fgrep inet_pton
>    673: 00000000001234c0   106 FUNC    WEAK   DEFAULT   13 inet_pton@@GLIBC_2.2
> #
> 
> > 
> >>> [root@f34 ~]# rpm -qa | fgrep glibc
> >>> glibc-all-langpacks-2.33-18.fc34.x86_64
> >>> glibc-common-2.33-18.fc34.x86_64
> >>> glibc-langpack-en-2.33-18.fc34.x86_64
> >>> glibc-2.33-18.fc34.x86_64
> >>> glibc-doc-2.33-18.fc34.noarch
> >>> glibc-headers-x86-2.33-18.fc34.noarch
> >>> glibc-devel-2.33-18.fc34.x86_64
> >>> glibc-debugsource-2.33-18.fc34.x86_64
> >>> glibc-debuginfo-2.33-18.fc34.x86_64
> >>> [root@f34 ~]# 
> >>>
> >>> The symbol inet_pton is now in the .dynsym section of glibc:
> >>> [root@f34 ~]# readelf -sW /usr/lib64/libc-2.33.so | egrep '(dynsym|symtab|inet_pton)'
> >>> Symbol table '.dynsym' contains 2419 entries:
> >>>    628: 000000000011ea00   108 FUNC    WEAK   DEFAULT   15 inet_pton@@GLIBC_2.2.5
> >>>   2251: 000000000011e9b0    76 FUNC    GLOBAL DEFAULT   15 __inet_pton_length@@GLIBC_PRIVATE
> >>> Symbol table '.symtab' contains 104 entries:
> >>> [root@f34 ~]#
> >>>
> >>> The .symtab section does not contain symbol inet_pton. It contains very few symbols
> >>> compared to previous versions.
> > 
> > Hmm, if perf probe can not find the debuginfo, it failback to symbol map,
> > can you add -vvv option to run the perf probe again?
> > 
> 
> # ./perf probe -vvv -f -x /usr/lib64/libc-2.33.so -a inet_pton 
> probe-definition(0): inet_pton
> symbol:inet_pton file:(null) line:0 offset:0 return:0 lazy:(null)
> 0 arguments
> symbol:__v1setjmp file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:longjmp file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:longjmp_target file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:lll_lock_wait_private file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:cond_destroy file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:cond_init file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:memory_mallopt_arena_max file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:memory_mallopt_arena_test file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:memory_tunable_tcache_max_bytes file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:memory_tunable_tcache_count file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:memory_tunable_tcache_unsorted_limit file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:memory_mallopt_trim_threshold file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:memory_mallopt_top_pad file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:memory_mallopt_mmap_threshold file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:memory_mallopt_mmap_max file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:memory_mallopt_perturb file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:memory_mallopt_mxfast file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:memory_heap_new file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:memory_sbrk_less file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:memory_heap_free file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:memory_tcache_double_free file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:memory_heap_less file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:memory_heap_more file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:memory_sbrk_more file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:memory_arena_reuse_free_list file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:memory_arena_reuse file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:memory_arena_reuse_wait file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:memory_arena_new file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:memory_arena_retry file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:memory_malloc_retry file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:memory_memalign_retry file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:memory_mallopt_free_dyn_thresholds file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:memory_realloc_retry file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:memory_calloc_retry file:(null) line:0 offset:0 return:0 lazy:(null)
> symbol:memory_mallopt file:(null) line:0 offset:0 return:0 lazy:(null)
> Open Debuginfo file: /usr/lib64/libc-2.33.so
> Try to find probe point from debuginfo.
> try_to_find_probe_trace_events ntevs 0
> try_to_find_probe_trace_events ret -2
> try_to_find_probe_trace_events ntevs2 0
> Probe point 'inet_pton' not found.
>   Error: Failed to add events. Reason: No such file or directory (Code: -2)
> # 
> [....]
> > 
> > Thank you,
> > 
> 
> 
> -- 
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
> --
> Vorsitzender des Aufsichtsrats: Gregor Pillen
> Geschäftsführung: Dirk Wittkopp
> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294


-- 
Masami Hiramatsu <mhiramat@kernel.org>
