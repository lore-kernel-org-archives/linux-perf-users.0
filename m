From: Daniel Chumak <daniel.chumak@student.HTW-Berlin.de>
Subject: How to get syscalls:sys_enter_open file name as a string?
Date: Mon, 09 Jun 2014 21:46:48 +0200
Message-ID: <53960F28.3050504@student.HTW-Berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail1.rz.htw-berlin.de ([141.45.10.101]:31938 "EHLO
	mail1.rz.htw-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbaFITq7 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 9 Jun 2014 15:46:59 -0400
Received: from dslb-088-074-028-122.pools.arcor-ip.net ([88.74.28.122] helo=[192.168.178.38])
	by mail1.rz.htw-berlin.de with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.82 (FreeBSD))
	(envelope-from <daniel.chumak@student.HTW-Berlin.de>)
	id 1Wu6SK-0000b6-9Q
	for linux-perf-users@vger.kernel.org; Mon, 09 Jun 2014 22:46:12 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I am currently trying to monitor file system events with perf. While 
recording some syscals including syscalls:sys_enter_open I noticed that 
when I look at the generated data of enter_open I either get a filename 
0x7fa8124e43c7 with plain perf script or filename=140359838352327 when I 
use the generated pyhon script.
Being obviously not happy with the useless numbers I get thrown at me I 
tried to add a probe to fopen of libc. The command

perf probe -x /usr/lib/libc-2.19.so -F | grep open | less

reveals that there is the symbol "fopen@@GLIBC_2.2.5", unfortunately 
though I seem not to be able to add a probe via

sudo perf probe -x /usr/lib/libc-2.19.so --add=fopen%return
(no symbols found in /usr/lib/libc-2.19.so, maybe install a debug 
package? Failed to load map.)

or via

sudo perf probe -x /usr/lib/libc-2.19.so --add=fopen@@GLIBC_2.2.5%return
(Semantic error :SRC@SRC is not allowed.)

What am I doing wrong here ?

Also what is the status on https://lkml.org/lkml/2014/2/18/57 or 
https://lkml.org/lkml/2014/4/8/22 ? If it does what I think it does 
(getting the call tree via a python script / .so) it would really help 
me a LOT.

Regards,

Daniel
