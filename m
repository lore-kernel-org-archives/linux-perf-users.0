From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: Question about LLC-load-misses event
Date: Tue, 23 Oct 2012 14:39:54 +0900
Message-ID: <87a9vd7nmd.fsf@sejong.aot.lge.com>
References: <507C0A9F.8060405@core.kaist.ac.kr>
	<507C1036.7020707@core.kaist.ac.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from [156.147.1.121] ([156.147.1.121]:42655 "EHLO
	LGEMRELSE6Q.lge.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752711Ab2JWFkQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 23 Oct 2012 01:40:16 -0400
In-Reply-To: <507C1036.7020707@core.kaist.ac.kr> (Chulmin Kim's message of
	"Mon, 15 Oct 2012 22:31:34 +0900")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Chulmin Kim <cmkim@core.kaist.ac.kr>
Cc: linux-perf-users@vger.kernel.org

Hi Chulmin,

On Mon, 15 Oct 2012 22:31:34 +0900, Chulmin Kim wrote:
> 2012-10-15 =EC=98=A4=ED=9B=84 10:07, Chulmin Kim =EC=93=B4 =EA=B8=80:
>> (perf command : perf stat -a -A -e LLC-loads -e LLC-load-misses -e
>> instructions sleep 3)
>>
>> The problem is,, the bandwidth from STREAM benchmark does not match =
with
>> the monitored value.
>>
>> e.g.
>> I got 9395MB/s from Stream.
>>
>> "perf" shows 134,642,063 LLC-load-misses for 3 seconds.
>> -> BW =3D ((# of events)/(3 seconds)) * 64 bytes / (1024*1024) =3D 2=
739MB/s
>> In this equation, the term (64bytes) is for cache line size, and the
>> term(1024*1024) is for (MB/s).
>>
>> Why does this mismatch occur?
> In case of Oprofile, the value for a certain event represents the num=
ber
> of the overflows which occur when the number of the event exceeds the
> predefined value.
> Is it a similar case with that?

I guess not.  And what's the result of the LLC-loads?  AFAIK it counts
all cache accesses including hits and misses.  Did you calculate the
bandwidth using the result of LLC-loads?  I suspect the h/w *might*
prefetches a couple of lines when cache-miss occurred, but I'm not
sure. :)

Thanks,
Namhyung
