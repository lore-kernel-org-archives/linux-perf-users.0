From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: bogus values of variables in userspace probes
Date: Tue, 24 Nov 2015 11:54:25 -0300
Message-ID: <20151124145424.GC18140@kernel.org>
References: <1448363902.24573.18.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40159 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753071AbbKXOya (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 24 Nov 2015 09:54:30 -0500
Content-Disposition: inline
In-Reply-To: <1448363902.24573.18.camel@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Wang Nan <wangnan0@huawei.com>, Michael Petlan <mpetlan@redhat.com>, linux-perf-users@vger.kernel.org

Em Tue, Nov 24, 2015 at 12:18:22PM +0100, Michael Petlan escreveu:
> Hi *,
> 
> I have been playing with perf-probe tool and I found out that some bogus
> values of a function argument are obtained by perf-record.
> 
> How to reproduce:
> 
> gcc -O0 -g -o dummy dummy.c
> perf probe -x ./dummy --add 'isprime a'
> perf record -e probe_dummy:isprime ./dummy
> perf script

Checking this here, but as non root I get:

[acme@zoo ~]$ gcc -O0 -g -o isprime isprime.c
[acme@zoo ~]$ perf probe -x ./isprime --add 'isprime a'
Mapping for the register number 4113 missing on this architecture.
Sorry, we don't support this variable location yet.
  Error: Failed to add events.
[acme@zoo ~]$ 

Masami, can you take a look at this?

More info:

[acme@zoo ~]$ cat /etc/fedora-release 
Fedora release 21 (Twenty One)
[acme@zoo ~]$ uname -a
Linux zoo 4.3.0+ #1 SMP Thu Nov 12 11:29:01 BRT 2015 x86_64 x86_64 x86_64 GNU/Linux

From readelf -wi, the isprime.c is the same as the one in Michael's original report.

Contents of the .debug_info section:

  Compilation Unit @ offset 0x0:
   Length:        0x12a (32-bit)
   Version:       4
   Abbrev Offset: 0x0
   Pointer Size:  8
 <0><b>: Abbrev Number: 1 (DW_TAG_compile_unit)
    <c>   DW_AT_producer    : (indirect string, offset: 0x7a): GNU C 4.9.2 20150212 (Red Hat 4.9.2-6) -mtune=generic -march=x86-64 -g -O0       
    <10>   DW_AT_language    : 1        (ANSI C)
<SNIP>
 <1><87>: Abbrev Number: 5 (DW_TAG_subprogram)
    <88>   DW_AT_external    : 1        
    <88>   DW_AT_name        : (indirect string, offset: 0xe): isprime  
    <8c>   DW_AT_decl_file   : 1        
    <8d>   DW_AT_decl_line   : 4        
    <8e>   DW_AT_prototyped  : 1        
    <8e>   DW_AT_type        : <0x34>   
    <92>   DW_AT_low_pc      : 0x400536 
    <9a>   DW_AT_high_pc     : 0x4d     
    <a2>   DW_AT_frame_base  : 1 byte block: 9c         (DW_OP_call_frame_cfa)
    <a4>   DW_AT_GNU_all_call_sites: 1  
    <a4>   DW_AT_sibling     : <0xc1>   
 <2><a8>: Abbrev Number: 6 (DW_TAG_formal_parameter)
    <a9>   DW_AT_name        : a        
    <ab>   DW_AT_decl_file   : 1        
    <ac>   DW_AT_decl_line   : 4        
    <ad>   DW_AT_type        : <0x34>   
    <b1>   DW_AT_location    : 2 byte block: 91 5c      (DW_OP_fbreg: -36)
<SNIP>
