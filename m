From: Milian Wolff <mail@milianw.de>
Subject: perf script: how to print user-space backtrace?
Date: Wed, 22 Jul 2015 20:48:40 +0200
Message-ID: <2045576.NEBzYG4lu7@agathebauer>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5728092.b4QgWExZSg"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:39199 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbbGVSsn (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 22 Jul 2015 14:48:43 -0400
Received: from agathebauer.localnet (ip5b406d2a.dynamic.kabel-deutschland.de [91.64.109.42])
	by dd17628.kasserver.com (Postfix) with ESMTPSA id 3E39D628103B
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2015 20:48:41 +0200 (CEST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Perf Users <linux-perf-users@vger.kernel.org>

--nextPart5728092.b4QgWExZSg
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hey all,

I recorded a perf data file using

perf record --call-graph dwarf kwrite <some large file>

when I report it I see backtraces pointing to the user space code:

perf report --stdio -g graph --no-children
    16.36%  kwrite           libKF5TextEditor.so.5.13.0     [.]=20
QArrayData::data                                                           =
                                   =20
                     |
                     ---QArrayData::data
                        |         =20
                        |--15.46%-- QTypedArrayData<unsigned short>::data

but when I run perf script, I do not see _any_ backtraces into user space.=
=20

perf script -F comm,tid,time,event,ip,sym,trace,period
:4898  4898 17486.943365:          1 cycles:=20
                  25f83a native_write_msr_safe
                  234f8a __intel_pmu_enable_all
                  235010 intel_pmu_enable_all
                  22e1ec x86_pmu_enable
                  356fb7 perf_pmu_enable.part.53
                  35824d perf_event_context_sched_in.isra.64
                  358e0b perf_event_exec
                  3e8c93 setup_new_exec
                  439a9f load_elf_binary
                  3e7f48 search_binary_handler
                  3e89cf do_execveat_common.isra.15
                  3e8e4a sys_execve
                  78b895 return_from_execve

kwrite  4898 17486.943893:          1 cycles:=20
kwrite  4898 17486.944211:          1 cycles:=20
=2E..
kwrite  4898 17486.953664:     461703 cycles:=20
kwrite  4898 17486.953838:     490150 cycles:=20
                  78d4c0 page_fault
kwrite  4898 17486.954009:     516694 cycles:=20
=2E..
kwrite  4898 17510.765568:     766937 cycles:=20
                  78979b down_write
                  39bd82 unlink_file_vma
                  3944d0 free_pgtables
                  39eef6 exit_mmap
                  275d45 mmput
                  27b514 do_exit
                  27bdfb do_group_exit
                  27be84 [unknown]
                  78b56e system_call

So it looks to me as if only kernel-space call stacks are unwound in perf=20
script. Is there a magic switch that I'm missing to get user-space stacks=20
unwound? Note I'm using perf 4.1.0 on a Linux 4.1.2 system.

Thanks

=2D-=20
Milian Wolff
mail@milianw.de
http://milianw.de
--nextPart5728092.b4QgWExZSg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlWv5YgACgkQDA6yEs0dE5N3agCeK0dK5MK8IL5la67c5COb3GBG
GjkAoLvkQI1eX98bAacfJY54EqAOoJGR
=i2PS
-----END PGP SIGNATURE-----

--nextPart5728092.b4QgWExZSg--
