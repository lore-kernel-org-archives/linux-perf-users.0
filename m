From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: perf-probe: issue with latest fedora kernel
Date: Wed, 15 Dec 2010 17:57:11 +0900
Message-ID: <4D0882E7.8090805@hitachi.com>
References: <m2pqtb9ekn.fsf@gmail.com> <20101209153548.GA11820@ghostprotocols.net> <m2wrnernw3.fsf@gmail.com> <20101213125837.GB5407@ghostprotocols.net> <m2sjy1stuf.fsf@gmail.com> <20101213142159.GF5407@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail4.hitachi.co.jp ([133.145.228.5]:39068 "EHLO
	mail4.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384Ab0LOI5Q (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 15 Dec 2010 03:57:16 -0500
In-Reply-To: <20101213142159.GF5407@ghostprotocols.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: Francis Moreau <francis.moro@gmail.com>, linux-perf-users@vger.kernel.org, 2nddept-manager@sdl.hitachi.co.jp

(2010/12/13 23:21), Arnaldo Carvalho de Melo wrote:

> There are two problems here:
> 
> on the 'report' header, as we didn't collect "cycles", but
> "probe:icmp_rcv" events, that is another fix that needs to be backported to
> fedora, but a minor one.
> 
> Also 'perf probe -L' should look use
> /usr/src/debug/kernel-2.6.35.fc14/linux-2.6.35.x86_64 as a prefix to look for
> sources.
> 
> That can be found using:
> 
> [root@felicio linux-2.6.35.x86_64]# readelf -wi /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64/vmlinux | grep DW_AT_comp_dir | head -5
>     <2e>   DW_AT_comp_dir    : /usr/src/debug////////kernel-2.6.35.fc14/linux-2.6.35.x86_64	
>     <95>   DW_AT_comp_dir    : (indirect string, offset: 0x24d0): /usr/src/debug/kernel-2.6.35.fc14/linux-2.6.35.x86_64	
>     <75e8>   DW_AT_comp_dir    : (indirect string, offset: 0x24d0): /usr/src/debug/kernel-2.6.35.fc14/linux-2.6.35.x86_64	
>     <900e>   DW_AT_comp_dir    : (indirect string, offset: 0x24d0): /usr/src/debug/kernel-2.6.35.fc14/linux-2.6.35.x86_64	
>     <16670>   DW_AT_comp_dir    : (indirect string, offset: 0x24d0): /usr/src/debug/kernel-2.6.35.fc14/linux-2.6.35.x86_64	
> [root@felicio linux-2.6.35.x86_64]# 
> 
>  <0><8b>: Abbrev Number: 1 (DW_TAG_compile_unit)
>     <8c>   DW_AT_producer    : (indirect string, offset: 0x22f4): GNU C 4.5.1 20100924 (Red Hat 4.5.1-4)        
>     <90>   DW_AT_language    : 1        (ANSI C)
>     <91>   DW_AT_name        : (indirect string, offset: 0x37a): arch/x86/kernel/head64.c       
>     <95>   DW_AT_comp_dir    : (indirect string, offset: 0x24d0): /usr/src/debug/kernel-2.6.35.fc14/linux-2.6.35.x86_64 
>     <99>   DW_AT_low_pc      : 0x0      
>     <a1>   DW_AT_entry_pc    : 0x0      
>     <a9>   DW_AT_ranges      : 0x340    
>     <ad>   DW_AT_stmt_list   : 0x114
> 
> I.e. using the DW_AT_comp_dir attribute in the DW_TAG_compile_unit DWARF tags,
> Masami?

It already supports DW_AT_comp_dir on upstream kernel,
see find_line_range() in utils/probe-finder.c ;-)

Thank you,


-- 
Masami HIRAMATSU
2nd Dept. Linux Technology Center
Hitachi, Ltd., Systems Development Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com
