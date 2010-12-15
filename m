From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: perf-probe: issue with latest fedora kernel
Date: Wed, 15 Dec 2010 16:53:58 -0200
Message-ID: <20101215185358.GA15822@ghostprotocols.net>
References: <m2pqtb9ekn.fsf@gmail.com>
 <20101209153548.GA11820@ghostprotocols.net>
 <m2wrnernw3.fsf@gmail.com>
 <20101213125837.GB5407@ghostprotocols.net>
 <m2sjy1stuf.fsf@gmail.com>
 <20101213142159.GF5407@ghostprotocols.net>
 <4D0882E7.8090805@hitachi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59469 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459Ab0LOSyG (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 15 Dec 2010 13:54:06 -0500
Received: by gyb11 with SMTP id 11so1232742gyb.19
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Dec 2010 10:54:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D0882E7.8090805@hitachi.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Francis Moreau <francis.moro@gmail.com>, linux-perf-users@vger.kernel.org, 2nddept-manager@sdl.hitachi.co.jp

Em Wed, Dec 15, 2010 at 05:57:11PM +0900, Masami Hiramatsu escreveu:
> (2010/12/13 23:21), Arnaldo Carvalho de Melo wrote:
> > Also 'perf probe -L' should look use
> > /usr/src/debug/kernel-2.6.35.fc14/linux-2.6.35.x86_64 as a prefix to look for
> > sources.

> > That can be found using:

> >  <0><8b>: Abbrev Number: 1 (DW_TAG_compile_unit)
> >     <8c>   DW_AT_producer    : (indirect string, offset: 0x22f4): GNU C 4.5.1 20100924 (Red Hat 4.5.1-4)        
> >     <90>   DW_AT_language    : 1        (ANSI C)
> >     <91>   DW_AT_name        : (indirect string, offset: 0x37a): arch/x86/kernel/head64.c       
> >     <95>   DW_AT_comp_dir    : (indirect string, offset: 0x24d0): /usr/src/debug/kernel-2.6.35.fc14/linux-2.6.35.x86_64 

> > I.e. using the DW_AT_comp_dir attribute in the DW_TAG_compile_unit DWARF tags,
> > Masami?

> It already supports DW_AT_comp_dir on upstream kernel,
> see find_line_range() in utils/probe-finder.c ;-)

I happily stand corrected, was using the f14 one :-)

Great work!

- Arnaldo
