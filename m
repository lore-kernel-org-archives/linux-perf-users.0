From: Brian Downing <bdowning@lavos.net>
Subject: perf adjusting symbols incorrectly with split debuginfo?
Date: Tue, 23 Nov 2010 06:50:30 +0000
Message-ID: <20101123065029.GG18897@glaurung.lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from glaurung.lavos.net ([69.162.133.92]:59407 "EHLO
	glaurung.lavos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929Ab0KWHBG (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 23 Nov 2010 02:01:06 -0500
Content-Disposition: inline
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

I am trying to run perf on a system with split debuginfo.  I'm creating the
debuginfo by:

objcopy --only-keep-debug file /usr/lib/debug/path/to/file
strip file
objcopy --add-gnu-debuglink=/usr/lib/debug/path/to/file file

The problem is that perf seems to want to use the section header's load
address and file offset fields to figure out what to adjust the symbol
by, in this code:

		if (curr_dso->adjust_symbols) {
			pr_debug4("%s: adjusting symbol: st_value: %#Lx "
				  "sh_addr: %#Lx sh_offset: %#Lx\n", __func__,
				  (u64)sym.st_value, (u64)shdr.sh_addr,
				  (u64)shdr.sh_offset);
			sym.st_value -= shdr.sh_addr - shdr.sh_offset;
		}

If it were reading the real binary this would work fine:

$ powerpc-unknown-linux-gnu-readelf --sections ./ppc5lua
There are 29 section headers, starting at offset 0x2712c:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] .interp           PROGBITS        10000174 000174 00000d 00   A  0   0  1
  [ 2] .note.ABI-tag     NOTE            10000184 000184 000020 00   A  0   0  4
...
  [12] .text             PROGBITS        10003410 003410 0207c0 00  AX  0   0  4

10003410 - 3410 = 10000000, which is correct.

Unfortunately it instead finds and reads the debuginfo, where this is:

$ powerpc-unknown-linux-gnu-readelf --sections ./ppc5luadebug
There are 31 section headers, starting at offset 0x2ec:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] .interp           NOBITS          10000174 000174 00000d 00   A  0   0  1
  [ 2] .note.ABI-tag     NOTE            10000184 000177 000020 00   A  0   0  4
...
  [12] .text             NOBITS          10003410 000197 0207c0 00  AX  0   0  4

Needless to say it's not okay if adjusted with that offset.

Fixing this seems like it would be rather hard, since it currently only
reads one ELF file, namely, the one with the symbols.  Is there another
way I can do split debuginfo that will make perf work, yet not duplicate
the actual code in two places?

Thanks,
-bcd
