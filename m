From: Chulmin Kim <cmkim@core.kaist.ac.kr>
Subject: Re: Question about LLC-load-misses event
Date: Mon, 15 Oct 2012 22:31:34 +0900
Message-ID: <507C1036.7020707@core.kaist.ac.kr>
References: <507C0A9F.8060405@core.kaist.ac.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from core.kaist.ac.kr ([143.248.147.118]:40177 "EHLO
	core.kaist.ac.kr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197Ab2JONbu (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 15 Oct 2012 09:31:50 -0400
Received: from [143.248.165.115] (az.kaist.ac.kr [143.248.165.115])
	by core.kaist.ac.kr (8.14.4/8.14.4) with ESMTP id q9FDek0r020347
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Oct 2012 22:40:46 +0900
In-Reply-To: <507C0A9F.8060405@core.kaist.ac.kr>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

2012-10-15 =BF=C0=C8=C4 10:07, Chulmin Kim =BE=B4 =B1=DB:
> Hi, all.
>
> I'm currently evaluating memory performance of my own machine (intel
> x5650 cpu).
> My machine can have NUMA configuration, but it is under control. (onl=
y
> local mem access allowed)
>
> As i run STREAM benchmark, i monitor LLC cache misses using "perf"
> simultaneously.
To be specific, I used STREAM Copy benchmark (which just copies memory
space by "a[i]=3Db[i]" repeatedly using for loop.)
> (perf command : perf stat -a -A -e LLC-loads -e LLC-load-misses -e
> instructions sleep 3)
>
> The problem is,, the bandwidth from STREAM benchmark does not match w=
ith
> the monitored value.
>
> e.g.
> I got 9395MB/s from Stream.
>
> "perf" shows 134,642,063 LLC-load-misses for 3 seconds.
> -> BW =3D ((# of events)/(3 seconds)) * 64 bytes / (1024*1024) =3D 27=
39MB/s
> In this equation, the term (64bytes) is for cache line size, and the
> term(1024*1024) is for (MB/s).
>
> Why does this mismatch occur?
In case of Oprofile, the value for a certain event represents the numbe=
r
of the overflows which occur when the number of the event exceeds the
predefined value.
Is it a similar case with that?

>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-=
users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
