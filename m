From: "Zhu, Wen-Jie (Joshua)" <zhu.wen-jie@hp.com>
Subject: perf-<pid>.map I generated for jit codes lose effect when hugepage
 used
Date: Mon, 31 Dec 2012 06:02:27 +0000
Message-ID: <C9CE69BB2598EB41AAEEDA105E742F4884B55FF1@G9W0727.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:38442 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973Ab2LaGD2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 31 Dec 2012 01:03:28 -0500
Received: from G9W0364.americas.hpqcorp.net (g9w0364.houston.hp.com [16.216.193.45])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by g4t0016.houston.hp.com (Postfix) with ESMTPS id 454861412F
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Dec 2012 06:03:28 +0000 (UTC)
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hello,

I use perf and the perf-<pid>.map I generated for Java jit codes to hel=
p profiling java application.
And recently I found jit symbols cannot be listed any more in perf repo=
rt.
By "sysctl vm.nr_hugepages=3D0" to disable hugepage temporarily, it wor=
ks.

Without hugepage, by judging anonymous memory's vm_area_struct, perf_mm=
ap_event's filename will be set to "//anon" indicating this vma is belo=
ng to anonymous memory.
Once hugepage is used, vma's filename point to hugetlbfs. In this way, =
this vma will not be regarded as anonymous memory by is_anon_memory() i=
n perf user space utility.

Therefore in order to avoid this problem, I temporarily change the code=
s of is_anon_memory() into following:
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return (strcmp(filename, "//anon") &&=
 strcmp(filename, "/anon_hugepage (deleted)")) =3D=3D 0;

I already verify this problem in =A0kernel 3.5.0-21-generic and RHEL ke=
rnel 2.6.32-279.el6.

Do you have any better solution replacement?

Thank you!
Joshua
