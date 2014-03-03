From: Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: Re: Profile the waiting time for lock or lock stats for one
 application
Date: Mon, 3 Mar 2014 16:23:54 +0000
Message-ID: <20140303162354.GA30567@sdfg.com.ar>
References: <1393351991.27573.YahooMailNeo@web124901.mail.ne1.yahoo.com>
 <20140228184343.GD10080@sdfg.com.ar>
 <5311FD27.7000903@gmail.com>
 <20140301160338.GE10080@sdfg.com.ar>
 <1393863072.34363.YahooMailNeo@web124906.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from alerce.vps.bitfolk.com ([85.119.82.134]:49978 "EHLO
	alerce.vps.bitfolk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753758AbaCCQZD (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 3 Mar 2014 11:25:03 -0500
Content-Disposition: inline
In-Reply-To: <1393863072.34363.YahooMailNeo@web124906.mail.ne1.yahoo.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Junjie Qian <junjie.qian@yahoo.com>
Cc: David Ahern <dsahern@gmail.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Mon, Mar 03, 2014 at 08:11:12AM -0800, Junjie Qian wrote:
> Hi,
>=20
> Really appreciate your help on this issue!
> 1. using root solve my problem with "perf lock", thank you very much!
> 2. about the discussion on locks in user-space. I discussed this with=
 my advisor, and found that lock contention does not mean waiting time =
or idle cpu-cycles sometime, for example, spin-lock in user-space that =
all threads/cores are still running but useless work and this cannot be=
 detected as either system lock or idle-cpu-cycles.=C2=A0

Yeah, with mutexes usually there is some spinning before waiting for th=
e lock.

> The way, I am trying to do this, now is insert the counter into the a=
pplication layer once the lock happens start the counting and I prepare=
 to monitor the threads in queue to detect the lock.

clock_gettime() with some clocks is implemented as a VDSO, so it should=
 be
pretty light to get that info if you need it.
And thread local variables can be very useful too probably :)

> I will let you know if I have any updates on this.

Great :)




Thanks a lot,
Rodrigo
