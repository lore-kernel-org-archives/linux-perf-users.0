From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [perfmon2] updating perf tool
Date: Mon, 14 Feb 2011 17:44:28 -0200
Message-ID: <20110214194428.GE21384@ghostprotocols.net>
References: <AANLkTim5QGwisxLEHHHECrE1nLSYFxzXEMu7hvTRy09=@mail.gmail.com>
 <AANLkTi=h6Qb7aCB0wER-FEGMwkD6xp1sBgnQudTZ=e+x@mail.gmail.com>
 <AANLkTimqRjUTzv+AO7zHCfXvA1RZFDTjyb-r0s_MVNTW@mail.gmail.com>
 <AANLkTinYM-Sg2uQFkXFy25mSZZZEtTSAUNrA==CxJP0=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35125 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280Ab1BNTod (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 14 Feb 2011 14:44:33 -0500
Received: by yxt3 with SMTP id 3so2222055yxt.19
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Feb 2011 11:44:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTinYM-Sg2uQFkXFy25mSZZZEtTSAUNrA==CxJP0=@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <arun@sharma-home.net>
Cc: Can Hankendi <hankendi@gmail.com>, linux-perf-users@vger.kernel.org

Em Fri, Feb 11, 2011 at 12:31:11PM -0800, Arun Sharma escreveu:
> On Fri, Feb 11, 2011 at 12:21 PM, Can Hankendi <hankendi@gmail.com> w=
rote:
> > Thanks for the reply.=A0 I've tried perf record -C 0 -e cycles slee=
p 1 but i
> > received an error: Couldn't record kernel reference relocation symb=
ol. Is it
> > possible to create per core report by using perf stat -C 0,1 so tha=
t I can
> > have individual stats for each core?
>=20
> # ./perf stat -e cycles -A -a -- sleep 1
>=20
>  Performance counter stats for 'sleep 1':
>=20
> CPU0         2,145,862,116 cycles
> CPU1         2,146,131,064 cycles
> CPU2         2,146,021,047 cycles
> [...]
>=20
> and you can grep out only the CPUs you're looking for.
>=20
> If you're looking to do something more complicated that really
> requires hacking up a script, I wrapped the perf_event_open syscall i=
n
> python via swig.
>=20
> sys.py --cpulist
>=20
> may be interesting.
>=20
> http://perfmon2.git.sourceforge.net/git/gitweb.cgi?p=3Dperfmon2/libpf=
m4;a=3Dblob;f=3Dpython/sys.py;h=3De3a44f24174b979694e2588592f759010b776=
21e;hb=3Df70e032b5b69cf5aa6f7e0da746b1817c64341e9

Interesting, have you seen the python binding in tip/perf/core?

- Arnaldo
