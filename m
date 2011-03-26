From: zhao bao <baozhao@gmail.com>
Subject: Fwd: perf trace cannot work with software events ?
Date: Sat, 26 Mar 2011 20:31:59 +0800
Message-ID: <AANLkTi=A5hkUE0xna5zmuXGt=LvMS_C41whzwM0-nUNs@mail.gmail.com>
References: <AANLkTi=pRKpdupEcXS0FmOA-PiAiXHWPYwWxN4F27fFC@mail.gmail.com>
	<AANLkTikXKDiyf7Q=mY_ez2P3OSw23VaRMdKcF_M-KCc0@mail.gmail.com>
	<AANLkTi=VrazJpV+dpzX2hWJ8dYDgbdo_5FAOMRYRo0GD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64548 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab1CZMcB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 26 Mar 2011 08:32:01 -0400
Received: by gwaa18 with SMTP id a18so760208gwa.19
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Mar 2011 05:32:00 -0700 (PDT)
In-Reply-To: <AANLkTi=VrazJpV+dpzX2hWJ8dYDgbdo_5FAOMRYRo0GD@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

---------- Forwarded message ----------
=46rom: zhao bao <baozhao@gmail.com>
Date: 2011/3/26
Subject: Re: perf trace cannot work with software events ?
To: Lin Ming <minggr@gmail.com>


>
> It's used to trace kernel space page faults, not for userspace code.
>
> Lin Ming
>

=46rom the ouput of "perf report" command, I think =C2=A0perf can recor=
d the
page faults from userspace code.

[root@localhost lab]# perf record -R -c 1 =C2=A0-d =C2=A0-e =C2=A0fault=
s ./hello
hello,world
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.010 MB perf.data (~420 samples) ]
[root@localhost lab]# perf report
# Events: 92 =C2=A0cycles
#
# Overhead =C2=A0Command =C2=A0 =C2=A0 =C2=A0Shared Object =C2=A0Symbol
# ........ =C2=A0....... =C2=A0................. =C2=A0......
#
=C2=A0 =C2=A010.87% =C2=A0 =C2=A0hello =C2=A0ld-2.12.90.so =C2=A0 =C2=A0=
 =C2=A0[.] .L198
=C2=A0 =C2=A0 6.52% =C2=A0 =C2=A0hello =C2=A0ld-2.12.90.so =C2=A0 =C2=A0=
 =C2=A0[.] _dl_load_cache_lookup
=C2=A0 =C2=A0 6.52% =C2=A0 =C2=A0hello =C2=A0ld-2.12.90.so =C2=A0 =C2=A0=
 =C2=A0[.] _dl_lookup_symbol_x
=C2=A0 =C2=A0 4.35% =C2=A0 =C2=A0hello =C2=A0ld-2.12.90.so =C2=A0 =C2=A0=
 =C2=A0[.] dl_main
=C2=A0 =C2=A0 3.26% =C2=A0 =C2=A0hello =C2=A0ld-2.12.90.so =C2=A0 =C2=A0=
 =C2=A0[.] _dl_start
=C2=A0 =C2=A0 3.26% =C2=A0 =C2=A0hello =C2=A0ld-2.12.90.so =C2=A0 =C2=A0=
 =C2=A0[.] _dl_cache_libcmp
=C2=A0 =C2=A0 3.26% =C2=A0 =C2=A0hello =C2=A0ld-2.12.90.so =C2=A0 =C2=A0=
 =C2=A0[.] do_lookup_x
=C2=A0 =C2=A0 2.17% =C2=A0 =C2=A0hello =C2=A0libc-2.12.90.so =C2=A0 =C2=
=A0[.] _init
=C2=A0 =C2=A0 2.17% =C2=A0 =C2=A0hello =C2=A0libc-2.12.90.so =C2=A0 =C2=
=A0[.] _IO_file_overflow_internal
