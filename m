From: Chulmin Kim <cmkim@core.kaist.ac.kr>
Subject: Re: Does Perf support AMD cpu perfectly?
Date: Tue, 27 Nov 2012 15:42:31 +0900
Message-ID: <50B460D7.4080804@core.kaist.ac.kr>
References: <50B3517A.7090505@core.kaist.ac.kr> <50B35D78.9090805@core.kaist.ac.kr> <50B3726C.8070706@core.kaist.ac.kr> <50B3743C.5020508@core.kaist.ac.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from core.kaist.ac.kr ([143.248.147.118]:54732 "EHLO
	core.kaist.ac.kr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755643Ab2K0GnH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 27 Nov 2012 01:43:07 -0500
Received: from [143.248.165.115] (az.kaist.ac.kr [143.248.165.115])
	by core.kaist.ac.kr (8.14.4/8.14.4) with ESMTP id qAR6kUKV005222
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Nov 2012 15:46:31 +0900
In-Reply-To: <50B3743C.5020508@core.kaist.ac.kr>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Update for this issue.

The patchset works correctly.

Now the problem is the number of the events to be monitored.

I will start a new thread for this issue.

Thanks.



2012-11-26 =BF=C0=C8=C4 10:53, Chulmin Kim =BE=B4 =B1=DB:
> Sorry for the posting with no patience.
>=20
> I've found the patch. (https://patchwork.kernel.org/patch/1722691/)
>=20
> It's pretty new. (released on 10,nov,2012)
>=20
> If you have something to mention about this issue,
>=20
> don't hesitate to contact me.
>=20
> Thanks.
>=20
> 2012-11-26 =BF=C0=C8=C4 10:45, Chulmin Kim =BE=B4 =B1=DB:
>> Update for this issue.
>>
>> I'm investigating the kernel source.
>>
>> I found that Perf for AMD seems imperfect in linux 3.0 (my machine's
>> linux version).
>>
>> For AMD family 15h, there is a commented line as follow.
>>    - /* nortbridge counters not yet implemented: */  (line 541,
>> perf_event_amd.c )
>>
>>
>> According to my further exploration, linux 3.2 does not support it e=
ither.
>>
>> Does any of you know or have the patch for it?
>>
>>
>> 2012-11-26 =BF=C0=C8=C4 9:15, Chulmin Kim =BE=B4 =B1=DB:
>>> Update for this issue.
>>>
>>> - rc0 and instruction events show the similar result.
>>> - still, the count of L3 cache miss event is 1/10 of what i expecte=
d.
>>> (LLC-load-misses)
>>>
>>>
>>>
>>> 2012-11-26 =BF=C0=C8=C4 8:24, Chulmin Kim =BE=B4 =B1=DB:
>>>> Hi all.
>>>>
>>>> I'm on the way of monitoring AMD machine.
>>>>
>>>> I wonder Perf is supporting AMD PMU Events perfectly or not.
>>>>
>>>> It seems not working correctly despite the same command works in i=
ntel
>>>> machines perfectly.
>>>>
>>>> command : (perf stat -e rc0 -e instructions ./blah)
>>>> result : the value for "rc0" almost equals to that of "instruction=
" in
>>>> Intel machine, while it does not in AMD machine
>>>>
>>>>
>>>> Other events such as cache events seem weird also.
>>>>
>>>> Is there any material mentioning this issue?
>>>>
>>>>
>>>>
>>>> Thanks!
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-pe=
rf-users" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-per=
f-users" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
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
