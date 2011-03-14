From: =?utf-8?B?6Zmz6Z+L5Lu7?= <chenwj@iis.sinica.edu.tw>
Subject: Building perf failed on Linux/SPARC
Date: Mon, 14 Mar 2011 17:51:21 +0800
Message-ID: <20110314095121.GA66653@cs.nctu.edu.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from csmailer.cs.nctu.edu.tw ([140.113.235.130]:24545 "EHLO
	csmailer.cs.nctu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981Ab1CNJ65 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 14 Mar 2011 05:58:57 -0400
Content-Disposition: inline
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: chenwj@cs.nctu.edu.tw

Hi, folks

  I have some problems while building perf on a Linux/SPARC machine.
Here is the system information.

$ uname -a
Linux sparc 2.6.37-rc5-git #1 SMP Tue Dec 21 17:03:53 CST 2010 sparc64 =
sun4v UltraSparc T2 (Niagara2) GNU/Linux
$ gcc --version
gcc (Gentoo 4.3.4 p1.0, pie-10.1.5) 4.3.4

  And here is the error message,
--------------------------------------------------------------------
$ make
<stdin>:1:20: error: libelf.h: No such file or directory
                ......
Makefile:419: *** No libelf.h/libelf found, please install libelf-dev/e=
lfutils-libelf-devel.  Stop.
--------------------------------------------------------------------

  I tried the code which is used to test libelf in the Makefile. But
it seems work correctly. Do I miss something? Or I just have to update
the kernel?

  Thanks!

Regards,
chenwj

--=20
Wei-Ren Chen (=E9=99=B3=E9=9F=8B=E4=BB=BB)
Parallel Processing Lab, Institute of Information Science,
Academia Sinica, Taiwan (R.O.C.)
Tel:886-2-2788-3799 #1667
