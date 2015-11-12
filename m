From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: timing information with perf
Date: Thu, 12 Nov 2015 20:34:29 -0300
Message-ID: <20151112233429.GG7160@kernel.org>
References: <94D0C06D-C3A7-4BD1-9898-124EE0AA923D@netapp.com>
 <20151112215728.GD7160@kernel.org>
 <21ECAC65-E51A-4430-A499-FFE216BF856B@netapp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56970 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932559AbbKLXee (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 12 Nov 2015 18:34:34 -0500
Content-Disposition: inline
In-Reply-To: <21ECAC65-E51A-4430-A499-FFE216BF856B@netapp.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Em Thu, Nov 12, 2015 at 11:09:48PM +0000, Kornievskaia, Olga escreveu:
> Just to elaborate further, what I=E2=80=99m interested in timings of =
NFS
> operations, so I=E2=80=99m not using any new tracepoints, but just th=
e ones
> that are present in the code. However since NFS doesn=E2=80=99t vario=
us things
> outside of the process calling into NFS then will =E2=80=9Cperf trace=
=E2=80=9D still
> work?=20
=20
> I=E2=80=99m using =E2=80=9Cperf record -e =E2=80=98nfs4:*=E2=80=99,=E2=
=80=99nfs:*=E2=80=99 -ag=E2=80=9D command to generate
> tracing info. That captures tracepoints executed by the application a=
s
> well as the kernel threads that do asynchronous IO.=20

So, you can replace 'perf record' with 'perf trace' and what will be
captured will be the same, its just that 'perf trace' still doesn't
support callchains (-g), but as David Ahern asked, do you want those?

Also, using -a you're not copying just the apps, but the whole system,
perhaps you want something like:

[root@felicio /]# perf trace --no-syscalls --event nfs4:*=E2=80=99,=E2=80=
=99nfs:*=E2=80=99 cp /etc/passwd /wb
     0.877 nfs:nfs_getattr_enter:fileid=3D00:26:2359297 fhandle=3D0x675=
bf9ee version=3D6216388797857602399 )
     0.891 nfs:nfs_revalidate_inode_enter:fileid=3D00:26:2359297 fhandl=
e=3D0x675bf9ee version=3D6216388797857602399 )
     1.440 nfs4:nfs4_map_name_to_uid:error=3D0 id=3D0 name=3D0)
     1.445 nfs4:nfs4_map_group_to_gid:error=3D0 id=3D0 name=3D0)
     1.455 nfs4:nfs4_getattr:error=3D0 (ACCESS) fileid=3D00:26:2359297 =
fhandle=3D0x675bf9ee valid=3DTYPE|MODE|NLINK|OWNER|GROUP|RDEV|SIZE|FSID=
|FILEID|ATIME|MTIME|CTIME|CHANGE)
     1.460 nfs:nfs_refresh_inode_enter:fileid=3D00:26:2359297 fhandle=3D=
0x675bf9ee version=3D6216388797857602399 )
     1.466 nfs:nfs_refresh_inode_exit:error=3D0 fileid=3D00:26:2359297 =
fhandle=3D0x675bf9ee type=3D4 (DIR) version=3D6216388797857602399 size=3D=
16384 cache_validity=3D0 () nfs_flags=3D4 ())
     1.471 nfs:nfs_revalidate_inode_exit:error=3D0 fileid=3D00:26:23592=
97 fhandle=3D0x675bf9ee type=3D4 (DIR) version=3D6216388797857602399 si=
ze=3D16384 cache_validity=3D0 () nfs_flags=3D4 ())
     1.476 nfs:nfs_getattr_exit:error=3D0 fileid=3D00:26:2359297 fhandl=
e=3D0x675bf9ee type=3D4 (DIR) version=3D6216388797857602399 size=3D1638=
4 cache_validity=3D0 () nfs_flags=3D4 ())
     1.493 nfs:nfs_access_enter:fileid=3D00:26:2359297 fhandle=3D0x675b=
f9ee version=3D6216388797857602399 )
     1.498 nfs:nfs_access_exit:error=3D0 fileid=3D00:26:2359297 fhandle=
=3D0x675bf9ee type=3D4 (DIR) version=3D6216388797857602399 size=3D16384=
 cache_validity=3D0 () nfs_flags=3D4 ())
     1.504 nfs:nfs_lookup_enter:flags=3D1 () name=3D00:26:2359297/passw=
d)
     1.940 nfs4:nfs4_lookup:error=3D-2 () name=3D00:26:2359297/passwd)
     1.948 nfs:nfs_lookup_exit:error=3D-2 flags=3D1 () name=3D00:26:235=
9297/passwd)
     1.966 nfs:nfs_access_enter:fileid=3D00:26:2359297 fhandle=3D0x675b=
f9ee version=3D6216388797857602399 )
     1.971 nfs:nfs_access_exit:error=3D0 fileid=3D00:26:2359297 fhandle=
=3D0x675bf9ee type=3D4 (DIR) version=3D6216388797857602399 size=3D16384=
 cache_validity=3D0 () nfs_flags=3D4 ())
     2.124 nfs:nfs_atomic_open_enter:flags=3D32961 (O_CREAT|O_EXCL) fmo=
de=3DWRITE name=3D00:26:2359297/passwd)
     8.402 nfs4:nfs4_map_name_to_uid:error=3D0 id=3D0 name=3D0)
     8.421 nfs4:nfs4_map_group_to_gid:error=3D0 id=3D0 name=3D0)
    13.156 nfs4:nfs4_map_name_to_uid:error=3D0 id=3D0 name=3D0)
    13.175 nfs4:nfs4_map_group_to_gid:error=3D0 id=3D0 name=3D0)
    13.187 nfs4:nfs4_setattr:error=3D0 (ACCESS) fileid=3D00:26:2360376 =
fhandle=3D0xfd52be06)
    13.199 nfs4:nfs4_open_file:error=3D0 (ACCESS) flags=3D32961 (O_CREA=
T|O_EXCL) fmode=3DWRITE fileid=3D00:26:2360376 fhandle=3D0xfd52be06 nam=
e=3D00:26:2359297/passwd)
    13.212 nfs:nfs_atomic_open_exit:error=3D0 flags=3D32961 (O_CREAT|O_=
EXCL) fmode=3DWRITE name=3D00:26:2359297/passwd)
    13.223 nfs:nfs_getattr_enter:fileid=3D00:26:2360376 fhandle=3D0xfd5=
2be06 version=3D6216410651367497762 )
    13.229 nfs:nfs_writeback_inode_enter:fileid=3D00:26:2360376 fhandle=
=3D0xfd52be06 version=3D6216410651367497762 )
    13.235 nfs:nfs_writeback_inode_exit:error=3D0 fileid=3D00:26:236037=
6 fhandle=3D0xfd52be06 type=3D8 (REG) version=3D6216410651367497762 siz=
e=3D0 cache_validity=3D24 (INVALID_ACCESS|INVALID_ACL) nfs_flags=3D0 ()=
)
    13.239 nfs:nfs_getattr_exit:error=3D0 fileid=3D00:26:2360376 fhandl=
e=3D0xfd52be06 type=3D8 (REG) version=3D6216410651367497762 size=3D0 ca=
che_validity=3D24 (INVALID_ACCESS|INVALID_ACL) nfs_flags=3D0 ())
    13.275 nfs:nfs_fsync_enter:fileid=3D00:26:2360376 fhandle=3D0xfd52b=
e06 version=3D6216410651367497762 )
    18.359 nfs:nfs_fsync_exit:error=3D0 fileid=3D00:26:2360376 fhandle=3D=
0xfd52be06 type=3D8 (REG) version=3D6216410651372497681 size=3D1576 cac=
he_validity=3D25 (INVALID_ATTR|INVALID_ACCESS|INVALID_ACL) nfs_flags=3D=
0 ())
[root@felicio /]#=20

If you remove the --no-syscalls, it gets even nicer, here is a slice:

    10.909 ( 7.182 ms): cp/14149  ... [continued]: open()) =3D 4
    10.922 ( 0.005 ms): cp/14149 fstat(fd: 4, statbuf: 0x7ffe38a34be0  =
                                ) ...
    10.922 (         ): nfs:nfs_getattr_enter:fileid=3D00:26:2360376 fh=
andle=3D0xfd52be06 version=3D6216410999163535246 )
    10.927 (         ): nfs:nfs_writeback_inode_enter:fileid=3D00:26:23=
60376 fhandle=3D0xfd52be06 version=3D6216410999163535246 )
    10.931 (         ): nfs:nfs_writeback_inode_exit:error=3D0 fileid=3D=
00:26:2360376 fhandle=3D0xfd52be06 type=3D8 (REG) version=3D62164109991=
63535246 size=3D0 cache_validity=3D24 (INVALID_ACCESS|INVALID_ACL) nfs_=
flags=3D4 ())
    10.936 (         ): nfs:nfs_getattr_exit:error=3D0 fileid=3D00:26:2=
360376 fhandle=3D0xfd52be06 type=3D8 (REG) version=3D621641099916353524=
6 size=3D0 cache_validity=3D24 (INVALID_ACCESS|INVALID_ACL) nfs_flags=3D=
4 ())
    10.948 ( 0.031 ms): cp/14149  ... [continued]: fstat()) =3D 0
    10.959 ( 0.005 ms): cp/14149 fadvise64(fd: 3</etc/passwd>, advice: =
2                               ) =3D 0
    10.978 ( 0.013 ms): cp/14149 mmap(len: 1056768, prot: READ|WRITE, f=
lags: PRIVATE|ANONYMOUS, fd: -1 ) =3D 0x7f4de0fd3000
    10.994 ( 0.008 ms): cp/14149 read(fd: 3</etc/passwd>, buf: 0x7f4de0=
fd4000, count: 1048576          ) =3D 1576
    11.012 ( 0.013 ms): cp/14149 write(fd: 4, buf: 0x7f4de0fd4000, coun=
t: 1576                         ) =3D 1576
    11.022 ( 0.005 ms): cp/14149 read(fd: 3</etc/passwd>, buf: 0x7f4de0=
fd4000, count: 1048576          ) =3D 0
    11.033 ( 0.005 ms): cp/14149 close(fd: 4                           =
                                ) ...
    11.033 (         ): nfs:nfs_fsync_enter:fileid=3D00:26:2360376 fhan=
dle=3D0xfd52be06 version=3D6216410999163535246 )
    15.535 (         ): nfs:nfs_fsync_exit:error=3D0 fileid=3D00:26:236=
0376 fhandle=3D0xfd52be06 type=3D8 (REG) version=3D6216410999169535149 =
size=3D1576 cache_validity=3D25 (INVALID_ATTR|INVALID_ACCESS|INVALID_AC=
L) nfs_flags=3D4 ())
    15.544 ( 4.517 ms): cp/14149  ... [continued]: close()) =3D 0
    16.058 ( 0.011 ms): cp/14149 close(fd: 3</etc/passwd>              =
                                ) =3D 0

Humm, so you want to pair things like:

    10.927 (         ): nfs:nfs_writeback_inode_enter:fileid=3D00:26:23=
60376 fhandle=3D0xfd52be06 version=3D6216410999163535246 )
    10.931 (         ): nfs:nfs_writeback_inode_exit:error=3D0 fileid=3D=
00:26:2360376 fhandle=3D0xfd52be06 type=3D8 (REG) version=3D62164109991=
63535246 size=3D0 cache_validity=3D24 (INVALID_ACCESS|INVALID_ACL) nfs_=
flags=3D4 ())

Using fileid as the key i addition to the common_pid, etc? That would b=
e a nice
feature to have in 'perf trace'... :-)

There is also:

    11.033 (         ): nfs:nfs_fsync_enter:fileid=3D00:26:2360376 fhan=
dle=3D0xfd52be06 version=3D6216410999163535246 )
    15.535 (         ): nfs:nfs_fsync_exit:error=3D0 fileid=3D00:26:236=
0376 fhandle=3D0xfd52be06 type=3D8 (REG) version=3D6216410999169535149 =
size=3D1576 cache_validity=3D25 (INVALID_ATTR|INVALID_ACCESS|INVALID_AC=
L) nfs_flags=3D4 ())

Well, you also can just get these and do some scripting, no, in this ca=
se:

   15.535 - 11.033 =3D 4.502ms

for that nfs_fsync :-)

- Arnaldo
