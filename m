From: Chulmin Kim <cmkim@core.kaist.ac.kr>
Subject: Re: Question about LLC-load-misses event
Date: Wed, 24 Oct 2012 21:56:04 +0900
Message-ID: <5087E564.4070908@core.kaist.ac.kr>
References: <507C0A9F.8060405@core.kaist.ac.kr> <507C1036.7020707@core.kaist.ac.kr> <87a9vd7nmd.fsf@sejong.aot.lge.com> <508630D2.60006@core.kaist.ac.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from core.kaist.ac.kr ([143.248.147.118]:53733 "EHLO
	core.kaist.ac.kr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778Ab2JXM4W (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 24 Oct 2012 08:56:22 -0400
In-Reply-To: <508630D2.60006@core.kaist.ac.kr>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org

2012-10-23 =EC=98=A4=ED=9B=84 2:53, Chulmin Kim =EC=93=B4 =EA=B8=80:
> 2012-10-23 =EC=98=A4=ED=9B=84 2:39, Namhyung Kim =EC=93=B4 =EA=B8=80:
>> Hi Chulmin,
>>
>> On Mon, 15 Oct 2012 22:31:34 +0900, Chulmin Kim wrote:
>>> 2012-10-15 =EC=98=A4=ED=9B=84 10:07, Chulmin Kim =EC=93=B4 =EA=B8=80=
:
>>>> (perf command : perf stat -a -A -e LLC-loads -e LLC-load-misses -e
>>>> instructions sleep 3)
>>>>
>>>> The problem is,, the bandwidth from STREAM benchmark does not matc=
h=20
>>>> with
>>>> the monitored value.
>>>>
>>>> e.g.
>>>> I got 9395MB/s from Stream.
>>>>
>>>> "perf" shows 134,642,063 LLC-load-misses for 3 seconds.
>>>> -> BW =3D ((# of events)/(3 seconds)) * 64 bytes / (1024*1024) =3D=
=20
>>>> 2739MB/s
>>>> In this equation, the term (64bytes) is for cache line size, and t=
he
>>>> term(1024*1024) is for (MB/s).
>>>>
>>>> Why does this mismatch occur?
>>> In case of Oprofile, the value for a certain event represents the=20
>>> number
>>> of the overflows which occur when the number of the event exceeds t=
he
>>> predefined value.
>>> Is it a similar case with that?
>> I guess not.  And what's the result of the LLC-loads?  AFAIK it coun=
ts
>> all cache accesses including hits and misses.
>
> Sorry for the lack of information.
>
> I used STREAM benchmark which generates 100% cache miss.
> Of course, the value of LLC-loads shows bit larger number than that o=
f=20
> LLC-load-misses (but, they are almost same).
>
>
>>    Did you calculate the
>> bandwidth using the result of LLC-loads?
>
> Bandwidth results:
> 9395MB/s from Stream
> 2739MB/s from LLC-load (including both hit and miss)
> I also want to add the BW from the mem write (about 3000MB/s from=20
> LLC-store (including both hit and miss) )
>
> I'm wondering why this difference happens?  (9395MB/s vs about 5739MB=
/s)
>
>
>
>> I suspect the h/w *might*
>> prefetches a couple of lines when cache-miss occurred, but I'm not
>> sure. :)
>
> I also suspected PREFETCH.
>
> After i uploaded this question, i checked prefetch events using "perf=
".
> I got 100% prefetch miss also. (but i don't know the meaning of this=20
> result thoroughly.)
>
> Do you know what this means?
> Are Prefetch events and LLC-load (or store) events exclusive? or=20
> correlated?
>
> Perf tool is too hard for me.. No remarkable document or site to help=
=20
> the user.  (If you know, recommend it please! :) )
>
>
> Thanks for your attention!
>
>

In the end, I changed BIOS setting of my own machine to turn off=20
prefetch features.
(Hardware Prefetch & Adjacent Cache Line Prefetch)

=46inally, the bandwidth results of STREAM and PMU events are consisten=
t!

I guess it was an issue related with the prefetching though I couldn't=20
anlalyze it thouroughly.



Thanks!

>
>
>> Thanks,
>> Namhyung
>>
> --=20
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
