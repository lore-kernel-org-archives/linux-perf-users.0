From: Chulmin Kim <cmkim@core.kaist.ac.kr>
Subject: Re: Question about LLC-load-misses event
Date: Tue, 23 Oct 2012 14:53:22 +0900
Message-ID: <508630D2.60006@core.kaist.ac.kr>
References: <507C0A9F.8060405@core.kaist.ac.kr> <507C1036.7020707@core.kaist.ac.kr> <87a9vd7nmd.fsf@sejong.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from core.kaist.ac.kr ([143.248.147.118]:46176 "EHLO
	core.kaist.ac.kr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452Ab2JWF4b (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 23 Oct 2012 01:56:31 -0400
In-Reply-To: <87a9vd7nmd.fsf@sejong.aot.lge.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org

2012-10-23 =EC=98=A4=ED=9B=84 2:39, Namhyung Kim =EC=93=B4 =EA=B8=80:
> Hi Chulmin,
>
> On Mon, 15 Oct 2012 22:31:34 +0900, Chulmin Kim wrote:
>> 2012-10-15 =EC=98=A4=ED=9B=84 10:07, Chulmin Kim =EC=93=B4 =EA=B8=80=
:
>>> (perf command : perf stat -a -A -e LLC-loads -e LLC-load-misses -e
>>> instructions sleep 3)
>>>
>>> The problem is,, the bandwidth from STREAM benchmark does not match=
 with
>>> the monitored value.
>>>
>>> e.g.
>>> I got 9395MB/s from Stream.
>>>
>>> "perf" shows 134,642,063 LLC-load-misses for 3 seconds.
>>> -> BW =3D ((# of events)/(3 seconds)) * 64 bytes / (1024*1024) =3D =
2739MB/s
>>> In this equation, the term (64bytes) is for cache line size, and th=
e
>>> term(1024*1024) is for (MB/s).
>>>
>>> Why does this mismatch occur?
>> In case of Oprofile, the value for a certain event represents the nu=
mber
>> of the overflows which occur when the number of the event exceeds th=
e
>> predefined value.
>> Is it a similar case with that?
> I guess not.  And what's the result of the LLC-loads?  AFAIK it count=
s
> all cache accesses including hits and misses.

Sorry for the lack of information.

I used STREAM benchmark which generates 100% cache miss.
Of course, the value of LLC-loads shows bit larger number than that of=20
LLC-load-misses (but, they are almost same).


>    Did you calculate the
> bandwidth using the result of LLC-loads?

Bandwidth results:
9395MB/s from Stream
2739MB/s from LLC-load (including both hit and miss)
I also want to add the BW from the mem write (about 3000MB/s from=20
LLC-store (including both hit and miss) )

I'm wondering why this difference happens?  (9395MB/s vs about 5739MB/s=
)



> I suspect the h/w *might*
> prefetches a couple of lines when cache-miss occurred, but I'm not
> sure. :)

I also suspected PREFETCH.

After i uploaded this question, i checked prefetch events using "perf".
I got 100% prefetch miss also. (but i don't know the meaning of this=20
result thoroughly.)

Do you know what this means?
Are Prefetch events and LLC-load (or store) events exclusive? or=20
correlated?

Perf tool is too hard for me.. No remarkable document or site to help=20
the user.  (If you know, recommend it please! :) )


Thanks for your attention!




> Thanks,
> Namhyung
>
