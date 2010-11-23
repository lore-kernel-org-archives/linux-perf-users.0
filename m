From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: perf adjusting symbols incorrectly with split debuginfo?
Date: Tue, 23 Nov 2010 10:53:37 -0200
Message-ID: <20101123125337.GB11101@ghostprotocols.net>
References: <20101123065029.GG18897@glaurung.lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36655 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237Ab0KWMxn (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 23 Nov 2010 07:53:43 -0500
Received: by ywl5 with SMTP id 5so317401ywl.19
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Nov 2010 04:53:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101123065029.GG18897@glaurung.lavos.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Brian Downing <bdowning@lavos.net>
Cc: linux-perf-users@vger.kernel.org

Em Tue, Nov 23, 2010 at 06:50:30AM +0000, Brian Downing escreveu:
> I am trying to run perf on a system with split debuginfo.  I'm creating the
> debuginfo by:
> 
> objcopy --only-keep-debug file /usr/lib/debug/path/to/file
> strip file
> objcopy --add-gnu-debuglink=/usr/lib/debug/path/to/file file
> 
> The problem is that perf seems to want to use the section header's load
> address and file offset fields to figure out what to adjust the symbol
> by, in this code:

There is a patch that deals with split debuginfo:

"perf symbols: fix symbol offset breakage with separated debug"
https://patchwork.kernel.org/patch/347491/

Can you please try it and report your results?

- Arnaldo
 
> 		if (curr_dso->adjust_symbols) {
> 			pr_debug4("%s: adjusting symbol: st_value: %#Lx "
> 				  "sh_addr: %#Lx sh_offset: %#Lx\n", __func__,
> 				  (u64)sym.st_value, (u64)shdr.sh_addr,
> 				  (u64)shdr.sh_offset);
> 			sym.st_value -= shdr.sh_addr - shdr.sh_offset;
> 		}
> 
> If it were reading the real binary this would work fine:
> 
> $ powerpc-unknown-linux-gnu-readelf --sections ./ppc5lua
> There are 29 section headers, starting at offset 0x2712c:
> 
> Section Headers:
>   [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
>   [ 0]                   NULL            00000000 000000 000000 00      0   0  0
>   [ 1] .interp           PROGBITS        10000174 000174 00000d 00   A  0   0  1
>   [ 2] .note.ABI-tag     NOTE            10000184 000184 000020 00   A  0   0  4
> ...
>   [12] .text             PROGBITS        10003410 003410 0207c0 00  AX  0   0  4
> 
> 10003410 - 3410 = 10000000, which is correct.
> 
> Unfortunately it instead finds and reads the debuginfo, where this is:
> 
> $ powerpc-unknown-linux-gnu-readelf --sections ./ppc5luadebug
> There are 31 section headers, starting at offset 0x2ec:
> 
> Section Headers:
>   [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
>   [ 0]                   NULL            00000000 000000 000000 00      0   0  0
>   [ 1] .interp           NOBITS          10000174 000174 00000d 00   A  0   0  1
>   [ 2] .note.ABI-tag     NOTE            10000184 000177 000020 00   A  0   0  4
> ...
>   [12] .text             NOBITS          10003410 000197 0207c0 00  AX  0   0  4
> 
> Needless to say it's not okay if adjusted with that offset.
> 
> Fixing this seems like it would be rather hard, since it currently only
> reads one ELF file, namely, the one with the symbols.  Is there another
> way I can do split debuginfo that will make perf work, yet not duplicate
> the actual code in two places?
> 
> Thanks,
> -bcd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
