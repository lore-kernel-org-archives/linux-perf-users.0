From: christophe leroy <christophe.leroy@c-s.fr>
Subject: Strange reports of perf events on powerpc 83xx
Date: Sat, 29 Aug 2015 16:34:36 +0200
Message-ID: <55E1C2FC.4060506@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from 2.236.17.93.rev.sfr.net ([93.17.236.2]:19297 "EHLO
	mailhub1.si.c-s.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752528AbbH2PCQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 29 Aug 2015 11:02:16 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
	by localhost (Postfix) with ESMTP id CCE141C8D6B
	for <linux-perf-users@vger.kernel.org>; Sat, 29 Aug 2015 16:34:45 +0200 (CEST)
Received: from mailhub1.si.c-s.fr ([192.168.12.234])
	by localhost (mailhub1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qhcTG7QJ7tLZ for <linux-perf-users@vger.kernel.org>;
	Sat, 29 Aug 2015 16:34:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id AF5A51C8C46
	for <linux-perf-users@vger.kernel.org>; Sat, 29 Aug 2015 16:34:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 94D21C73C5
	for <linux-perf-users@vger.kernel.org>; Sat, 29 Aug 2015 16:34:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id LvofcV7Mov0A for <linux-perf-users@vger.kernel.org>;
	Sat, 29 Aug 2015 16:34:45 +0200 (CEST)
Received: from [127.0.0.1] (unknown [192.168.232.15])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4D839C73C4
	for <linux-perf-users@vger.kernel.org>; Sat, 29 Aug 2015 16:34:45 +0200 (CEST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

Has anybody already used 'perf' tool on powerpc MPC83xx ?

I have been succesfully using perf on MPC8xx, but on MPC83xx I get=20
something strange.

perf record/report reports addresses on user stack, as if it was mixing=
=20
up D accesses and I accesses.

Any idea of what the problem can be ?

# Samples: 8K of event 'cpu-clock'
# Event count (approx.): 2196000000
#
# Overhead  Command       Shared Object       Symbol
# ........  ............  ..................=20
=2E...........................................
#
       2.62%  perf_reseau4  libpthread-2.18.so  [.] __libc_send
       2.56%  perf_reseau4  [kernel.kallsyms]   [k] __ip_make_skb
       1.62%  perf_reseau4  [kernel.kallsyms]   [k] __ip_append_data.is=
ra.39
       1.55%  perf_reseau4  [kernel.kallsyms]   [k] ip_finish_output
       1.33%  perf_reseau4  [unknown]           [k] 0x7ffffd94
       1.33%  perf_reseau4  [unknown]           [k] 0x7ffffd95
       1.28%  perf_reseau4  [unknown]           [k] 0x7ffffd97
       1.26%  perf_reseau4  [unknown]           [k] 0x7ffffda3
       1.24%  perf_reseau4  [unknown]           [k] 0x7ffffd98
       1.22%  perf_reseau4  [unknown]           [k] 0x7ffffd92
       1.22%  perf_reseau4  [unknown]           [k] 0x7ffffd9b
       1.22%  perf_reseau4  [unknown]           [k] 0x7ffffdaa
       1.21%  perf_reseau4  [unknown]           [k] 0x7ffffd96
       1.18%  perf_reseau4  [unknown]           [k] 0x7ffffda7
       1.17%  perf_reseau4  [unknown]           [k] 0x7ffffd8d
       1.17%  perf_reseau4  [unknown]           [k] 0x7ffffd99
       1.13%  perf_reseau4  [unknown]           [k] 0x7ffffd90
       1.13%  perf_reseau4  [unknown]           [k] 0x7ffffda2
       1.12%  perf_reseau4  [kernel.kallsyms]   [k] __local_bh_enable_i=
p
       1.12%  perf_reseau4  [unknown]           [k] 0x7ffffd9c
       1.12%  perf_reseau4  [unknown]           [k] 0x7ffffd9e
       1.10%  perf_reseau4  [unknown]           [k] 0x7ffffda0
       1.08%  perf_reseau4  [unknown]           [k] 0x7ffffd9f
       1.08%  perf_reseau4  [unknown]           [k] 0x7ffffda6
       1.05%  perf_reseau4  [unknown]           [k] 0x7ffffda8
       1.02%  perf_reseau4  [unknown]           [k] 0x7ffffd9a
       1.01%  perf_reseau4  [unknown]           [k] 0x7ffffdb0
       1.00%  perf_reseau4  [unknown]           [k] 0x7ffffd89
       1.00%  perf_reseau4  [unknown]           [k] 0x7ffffd8b
       1.00%  perf_reseau4  [unknown]           [k] 0x7ffffdac


Christophe


---
L'absence de virus dans ce courrier =C3=A9lectronique a =C3=A9t=C3=A9 v=
=C3=A9rifi=C3=A9e par le logiciel antivirus Avast.
https://www.avast.com/antivirus
