From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: RWX stack in perf
Date: Thu, 16 Feb 2012 17:35:24 +0100
Message-ID: <1329410124.10004.5.camel@edumazet-HP-Compaq-6005-Pro-SFF-PC>
References: <CAEmqk_zpVjv3HxT2xUbbUx8QwfESMQhCrsWHWOvQ91R0um3fhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45116 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836Ab2BPQf2 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 16 Feb 2012 11:35:28 -0500
Received: by bkcjm19 with SMTP id jm19so2134761bkc.19
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Feb 2012 08:35:27 -0800 (PST)
In-Reply-To: <CAEmqk_zpVjv3HxT2xUbbUx8QwfESMQhCrsWHWOvQ91R0um3fhw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Kant <fnord.hammer@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Le jeudi 16 f=C3=A9vrier 2012 =C3=A0 17:30 +0100, Kant a =C3=A9crit :
> Building perf 3.2.6 ends up with RWX stack, preventing me from using =
perf top.
>=20
> Using -Wa,--noexecstack seems to fix the problem.
>=20
> mmap(NULL, 8392704, PROT_READ|PROT_WRITE|PROT_EXEC,
> MAP_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0) =3D -1 EPERM (Operation n=
ot
> permitted)
> --

Known problem, fixed, and submitted to stable.

Search "Fix perf stack to non executable on x86_64" in archives.
