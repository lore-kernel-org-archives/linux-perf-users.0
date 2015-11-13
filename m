From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: timing information with perf
Date: Fri, 13 Nov 2015 16:47:26 -0300
Message-ID: <20151113194726.GN7160@kernel.org>
References: <94D0C06D-C3A7-4BD1-9898-124EE0AA923D@netapp.com>
 <20151112215728.GD7160@kernel.org>
 <21ECAC65-E51A-4430-A499-FFE216BF856B@netapp.com>
 <20151112233429.GG7160@kernel.org>
 <5B1B04DE-98CC-44CC-BC75-896C2F029799@netapp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38548 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754225AbbKMTrb (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 13 Nov 2015 14:47:31 -0500
Content-Disposition: inline
In-Reply-To: <5B1B04DE-98CC-44CC-BC75-896C2F029799@netapp.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Em Fri, Nov 13, 2015 at 05:01:57PM +0000, Kornievskaia, Olga escreveu:
> > On Nov 12, 2015, at 6:34 PM, Arnaldo Carvalho de Melo <acme@kernel.=
org> wrote:
> > There is also:
> >=20
> >    11.033 (         ): nfs:nfs_fsync_enter:fileid=3D00:26:2360376 f=
handle=3D0xfd52be06 version=3D6216410999163535246 )
> >    15.535 (         ): nfs:nfs_fsync_exit:error=3D0 fileid=3D00:26:=
2360376 fhandle=3D0xfd52be06 type=3D8 (REG) version=3D62164109991695351=
49 size=3D1576 cache_validity=3D25 (INVALID_ATTR|INVALID_ACCESS|INVALID=
_ACL) nfs_flags=3D4 ())
> >=20
> > Well, you also can just get these and do some scripting, no, in thi=
s case:
> >=20
> >   15.535 - 11.033 =3D 4.502ms
> >=20
> > for that nfs_fsync :-)

> David and Arnaldo thank you your replies. I can see that to acquire
> the timings for non-syscall events requires scripting. Would I be
> missing something by not using =E2=80=9Cperf=E2=80=9D and instead doi=
ng scripting on
> the output that I get from the trace_pipe? I guess instead of the

Both will present you with the timestamp and parameters for the enabled
tracepoints, so I think that at this state, yes, you will not get
anything better from perf than what you'll get from ftrace via debugfs.

But this comes from time to time, the logic used for
raw_syscalls:sys_enter -> raw_syscalls:sys_exit, using some set of keys
to match one to the other should be extended to be used with non-syscal=
l
events, such as the ones you mention here.

i.e. whereas raw_syscalls:sys_exit has a "ret" variable to tell the
result of the sys_enter+sys_exit operation, nfs_fsync_exit has "error",
I guess, for the same purpose :)

- Arnaldo
