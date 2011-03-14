From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: Building perf failed on Linux/SPARC
Date: Mon, 14 Mar 2011 16:15:26 -0300
Message-ID: <20110314191526.GA2388@ghostprotocols.net>
References: <20110314095121.GA66653@cs.nctu.edu.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49072 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502Ab1CNTPe (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 14 Mar 2011 15:15:34 -0400
Received: by ywj3 with SMTP id 3so2180118ywj.19
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Mar 2011 12:15:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110314095121.GA66653@cs.nctu.edu.tw>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: =?utf-8?B?6Zmz6Z+L5Lu7?= <chenwj@iis.sinica.edu.tw>
Cc: linux-perf-users@vger.kernel.org, chenwj@cs.nctu.edu.tw

Em Mon, Mar 14, 2011 at 05:51:21PM +0800, =E9=99=B3=E9=9F=8B=E4=BB=BB e=
screveu:
>   I have some problems while building perf on a Linux/SPARC machine.
> Here is the system information.
>=20
> $ uname -a
> Linux sparc 2.6.37-rc5-git #1 SMP Tue Dec 21 17:03:53 CST 2010 sparc6=
4 sun4v UltraSparc T2 (Niagara2) GNU/Linux
> $ gcc --version
> gcc (Gentoo 4.3.4 p1.0, pie-10.1.5) 4.3.4
>=20
>   And here is the error message,
> --------------------------------------------------------------------
> $ make
> <stdin>:1:20: error: libelf.h: No such file or directory
>                 ......
> Makefile:419: *** No libelf.h/libelf found, please install libelf-dev=
/elfutils-libelf-devel.  Stop.
> --------------------------------------------------------------------
>=20
>   I tried the code which is used to test libelf in the Makefile. But
> it seems work correctly. Do I miss something? Or I just have to updat=
e
> the kernel?

Gentoo, ok, can you make sure the package providing the libelf
implementation is elfutils?

There are other libelf implementations that could pass the simple test,
but which doesn't provide functions used in perf.

- Arnaldo
