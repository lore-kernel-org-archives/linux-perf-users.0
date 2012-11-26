From: Chulmin Kim <cmkim@core.kaist.ac.kr>
Subject: Re: Does Perf support AMD cpu perfectly?
Date: Mon, 26 Nov 2012 22:45:16 +0900
Message-ID: <50B3726C.8070706@core.kaist.ac.kr>
References: <50B3517A.7090505@core.kaist.ac.kr> <50B35D78.9090805@core.kaist.ac.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from core.kaist.ac.kr ([143.248.147.118]:41219 "EHLO
	core.kaist.ac.kr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753018Ab2KZNpu (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 26 Nov 2012 08:45:50 -0500
Received: from [143.248.165.115] (az.kaist.ac.kr [143.248.165.115])
	by core.kaist.ac.kr (8.14.4/8.14.4) with ESMTP id qAQDn7mL024881
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Nov 2012 22:49:08 +0900
In-Reply-To: <50B35D78.9090805@core.kaist.ac.kr>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Update for this issue.

I'm investigating the kernel source.

I found that Perf for AMD seems imperfect in linux 3.0 (my machine's
linux version).

=46or AMD family 15h, there is a commented line as follow.
 - /* nortbridge counters not yet implemented: */  (line 541,
perf_event_amd.c )


According to my further exploration, linux 3.2 does not support it eith=
er.

Does any of you know or have the patch for it?


2012-11-26 =BF=C0=C8=C4 9:15, Chulmin Kim =BE=B4 =B1=DB:
> Update for this issue.
>=20
> - rc0 and instruction events show the similar result.
> - still, the count of L3 cache miss event is 1/10 of what i expected.
> (LLC-load-misses)
>=20
>=20
>=20
> 2012-11-26 =BF=C0=C8=C4 8:24, Chulmin Kim =BE=B4 =B1=DB:
>> Hi all.
>>
>> I'm on the way of monitoring AMD machine.
>>
>> I wonder Perf is supporting AMD PMU Events perfectly or not.
>>
>> It seems not working correctly despite the same command works in int=
el
>> machines perfectly.
>>
>> command : (perf stat -e rc0 -e instructions ./blah)
>> result : the value for "rc0" almost equals to that of "instruction" =
in
>> Intel machine, while it does not in AMD machine
>>
>>
>> Other events such as cache events seem weird also.
>>
>> Is there any material mentioning this issue?
>>
>>
>>
>> Thanks!
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-perf=
-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-=
users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
