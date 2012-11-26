From: Chulmin Kim <cmkim@core.kaist.ac.kr>
Subject: Re: Does Perf support AMD cpu perfectly?
Date: Mon, 26 Nov 2012 21:15:52 +0900
Message-ID: <50B35D78.9090805@core.kaist.ac.kr>
References: <50B3517A.7090505@core.kaist.ac.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from core.kaist.ac.kr ([143.248.147.118]:34787 "EHLO
	core.kaist.ac.kr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754872Ab2KZMQZ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 26 Nov 2012 07:16:25 -0500
Received: from [143.248.165.115] (az.kaist.ac.kr [143.248.165.115])
	by core.kaist.ac.kr (8.14.4/8.14.4) with ESMTP id qAQCJg5w023357
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Nov 2012 21:19:43 +0900
In-Reply-To: <50B3517A.7090505@core.kaist.ac.kr>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Update for this issue.

- rc0 and instruction events show the similar result.
- still, the count of L3 cache miss event is 1/10 of what i expected.
(LLC-load-misses)



2012-11-26 =BF=C0=C8=C4 8:24, Chulmin Kim =BE=B4 =B1=DB:
> Hi all.
>=20
> I'm on the way of monitoring AMD machine.
>=20
> I wonder Perf is supporting AMD PMU Events perfectly or not.
>=20
> It seems not working correctly despite the same command works in inte=
l
> machines perfectly.
>=20
> command : (perf stat -e rc0 -e instructions ./blah)
> result : the value for "rc0" almost equals to that of "instruction" i=
n
> Intel machine, while it does not in AMD machine
>=20
>=20
> Other events such as cache events seem weird also.
>=20
> Is there any material mentioning this issue?
>=20
>=20
>=20
> Thanks!
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-=
users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
