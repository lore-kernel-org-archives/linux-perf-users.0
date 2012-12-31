From: Andi Kleen <andi@firstfloor.org>
Subject: Re: perf-<pid>.map I generated for jit codes lose effect when hugepage used
Date: Mon, 31 Dec 2012 11:40:57 -0800
Message-ID: <m2bodac8mu.fsf@firstfloor.org>
References: <C9CE69BB2598EB41AAEEDA105E742F4884B55FF1@G9W0727.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:4670 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751679Ab2LaTk7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 31 Dec 2012 14:40:59 -0500
In-Reply-To: <C9CE69BB2598EB41AAEEDA105E742F4884B55FF1@G9W0727.americas.hpqcorp.net>
	(Wen-Jie Zhu's message of "Mon, 31 Dec 2012 06:02:27 +0000")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Zhu, Wen-Jie (Joshua)" <zhu.wen-jie@hp.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

"Zhu, Wen-Jie (Joshua)" <zhu.wen-jie@hp.com> writes:
>
> Therefore in order to avoid this problem, I temporarily change the co=
des of is_anon_memory() into following:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn (strcmp(filename, "//anon") && strcmp(filename, "/anon_hugepage (d=
eleted)")) =3D=3D 0;
>
> I already verify this problem in =C2=A0kernel 3.5.0-21-generic and RH=
EL kernel 2.6.32-279.el6.
>
> Do you have any better solution replacement?


Your fix looks good to me, probably you just need to send it as a more
formal patch.

-Andi
--=20
ak@linux.intel.com -- Speaking for myself only
