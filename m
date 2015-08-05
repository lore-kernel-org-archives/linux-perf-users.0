From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf: remount of tracefs required
Date: Wed, 5 Aug 2015 11:35:40 -0300
Message-ID: <20150805143540.GA32553@kernel.org>
References: <5297956.5blcApkzlY@milian-kdab2>
 <20150804152746.GA3126@kernel.org>
 <3948762.FVKqmXobpH@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52138 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751226AbbHEOfn (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 5 Aug 2015 10:35:43 -0400
Content-Disposition: inline
In-Reply-To: <3948762.FVKqmXobpH@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <mail@milianw.de>
Cc: linux-perf-users@vger.kernel.org

Em Wed, Aug 05, 2015 at 04:17:42PM +0200, Milian Wolff escreveu:
> On Tuesday 04 August 2015 12:27:46 Arnaldo Carvalho de Melo wrote:
> >   [acme@zoo linux]$ trace usleep 1
> >   Error:	No permissions to read
> >   /sys/kernel/debug/tracing/events/raw_syscalls/sys_(enter|exit)
> >   Hint:	Try 'sudo mount -o remount,mode=3D755 /sys/kernel/debug/tra=
cing'
=20
> This message I do not get, not even with my perf compiled from the v4=
=2E2-rc5=20
> tag. And it is exactly what I was asking for.
=20
> <snip>
=20
> > I guess what fixes what you report is this cset:

> >   commit ab85785aa13c36440a91a8e9f7616357de411a1f

> >     tools lib api debugfs: Check for tracefs when reporting errors

> > [acme@zoo linux]$ git describe ab85785aa13c36440a91a8e9f7616357de41=
1a1f
> > v4.2-rc1-17-gab85785aa13c

> > So, can you try running the perf tools, built from the latest 4.2-r=
c
> > codebase to see if it behaves as you expect?
=20
> This is not included in 4.2-rc5 as far as I can see:
=20
> $ git describe
> v4.2-rc5-2-ga64d3e5
> $ git show ab85785aa13c36440a91a8e9f7616357de411a1f
> fatal: bad object ab85785aa13c36440a91a8e9f7616357de411a1f
> $ git log --grep debugfs --oneline --author=3DArnaldo
> f816b3c tools lib fs debugfs: Check if debugfs is mounted when handli=
ng ENOENT
> ...

Oops, it is just in tip/perf/core, i.e. scheduled for 4.3 :-\ Wonder ho=
w
difficult would be to cherry-pick that into perf/urgent.

I.e. can you try doing something like:

  git cherry-pick ab85785aa13c36440a91a8e9f7616357de411a1f

With a checked out v4.2-rc5, or better, torvalds/master, i.e. the top o=
f
Linus's git tree? It is possible that one or more patches just before
this one, also in perf/core, may be needed.

If it is easy, perhaps we can push it for 4.2 final.

Ah, you may want to take a look at:

https://git.kernel.org/cgit/linux/kernel/git/acme/linux.git/log/?h=3Dpe=
rf/core

To get from this:

  [root@zoo ~]# trace -e newfstatat,unlinkat rm /tmp/foo
     0.489 ( 0.011 ms): rm/8428 newfstatat(dfd: CWD, filename: 0x9153f8=
, statbuf: 0x915368, flag: 256 ) =3D 0
     0.508 ( 0.010 ms): rm/8428 unlinkat(dfd: CWD, pathname: 0x9140c0) =
=3D 0
  [root@zoo ~]#

After doing this:

  [root@zoo ~]# perf probe 'vfs_getname=3Dgetname_flags:72 pathname=3Df=
ilename:string'
  Added new event:
    probe:vfs_getname    (on getname_flags:72 with pathname=3Dfilename:=
string)

  You can now use it in all perf tools, such as:

	perf record -e probe:vfs_getname -aR sleep 1

To this:

  [root@zoo ~]# trace -e newfstatat,unlinkat rm /tmp/foo
  rm: cannot remove =E2=80=98/tmp/foo=E2=80=99: No such file or directo=
ry
     0.503 ( 0.007 ms): rm/8480 newfstatat(dfd: CWD, filename: /tmp/foo=
, statbuf: 0x2370368, flag: 256) =3D -1 ENOENT No such file or director=
y
     0.514 ( 0.004 ms): rm/8480 unlinkat(dfd: CWD, pathname: /tmp/foo) =
=3D -1 ENOENT No such file or directory
  [root@zoo ~]#

Auto inserting that probe remains to be done, but for now can be done j=
ust once
per boot.

- Arnaldo
