From: Arun Sharma <arun@sharma-home.net>
Subject: Re: [perfmon2] updating perf tool
Date: Fri, 11 Feb 2011 12:31:11 -0800
Message-ID: <AANLkTinYM-Sg2uQFkXFy25mSZZZEtTSAUNrA==CxJP0=@mail.gmail.com>
References: <AANLkTim5QGwisxLEHHHECrE1nLSYFxzXEMu7hvTRy09=@mail.gmail.com>
	<AANLkTi=h6Qb7aCB0wER-FEGMwkD6xp1sBgnQudTZ=e+x@mail.gmail.com>
	<AANLkTimqRjUTzv+AO7zHCfXvA1RZFDTjyb-r0s_MVNTW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64407 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757749Ab1BKUbN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 11 Feb 2011 15:31:13 -0500
Received: by iwn9 with SMTP id 9so2794860iwn.19
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Feb 2011 12:31:12 -0800 (PST)
In-Reply-To: <AANLkTimqRjUTzv+AO7zHCfXvA1RZFDTjyb-r0s_MVNTW@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Can Hankendi <hankendi@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Fri, Feb 11, 2011 at 12:21 PM, Can Hankendi <hankendi@gmail.com> wro=
te:
> Thanks for the reply.=C2=A0 I've tried perf record -C 0 -e cycles sle=
ep 1 but i
> received an error: Couldn't record kernel reference relocation symbol=
=2E Is it
> possible to create per core report by using perf stat -C 0,1 so that =
I can
> have individual stats for each core?

# ./perf stat -e cycles -A -a -- sleep 1

 Performance counter stats for 'sleep 1':

CPU0         2,145,862,116 cycles
CPU1         2,146,131,064 cycles
CPU2         2,146,021,047 cycles
[...]

and you can grep out only the CPUs you're looking for.

If you're looking to do something more complicated that really
requires hacking up a script, I wrapped the perf_event_open syscall in
python via swig.

sys.py --cpulist

may be interesting.

http://perfmon2.git.sourceforge.net/git/gitweb.cgi?p=3Dperfmon2/libpfm4=
;a=3Dblob;f=3Dpython/sys.py;h=3De3a44f24174b979694e2588592f759010b77621=
e;hb=3Df70e032b5b69cf5aa6f7e0da746b1817c64341e9

 -Arun
