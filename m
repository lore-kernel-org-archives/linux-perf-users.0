From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: Queries on using PERF tool
Date: Thu, 29 Nov 2012 23:47:06 +0900
Message-ID: <1354200426.1630.30.camel@leonhard>
References: <loom.20121128T064019-497@post.gmane.org>
	 <50B5A903.5080003@core.kaist.ac.kr> <87lidkq4gg.fsf@sejong.aot.lge.com>
	 <CA+wByoXeohgy4bhi3WN3was0-7RboXzWcTU1Kv0DrZ=b7ewR4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45508 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277Ab2K2OrM (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 29 Nov 2012 09:47:12 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so10600829pbc.19
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Nov 2012 06:47:11 -0800 (PST)
In-Reply-To: <CA+wByoXeohgy4bhi3WN3was0-7RboXzWcTU1Kv0DrZ=b7ewR4Q@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Shahina Rabbani <shahinarabbani.shaik@gmail.com>
Cc: Chulmin Kim <cmkim@core.kaist.ac.kr>, linux-perf-users@vger.kernel.org

Hi Shahina,

2012-11-29 (=EB=AA=A9), 13:45 +0530, Shahina Rabbani:
> Hi Namhyung Kim ,
>=20
>=20
> First of all Thanks for your mail.
> I have some more doubts. Please help me.
>=20
>=20
> Q1: when we are working with more than one CPU, there will be a share=
d
> L2 cache for all the CPUs and each CPU will have its own L1-cache
>        If i want to monitor a event and i am using L1-cahce and
> L2-caches from CPU1 and the same time if CPU2 is also trying to
> monotora particular event and using L2- =20
>        cache. Then how the perf tool handles this situation.

On a recent kernel and Intel cpus, it supports offcore and/or uncore
events for that purpose AFAIK.  Please check your cpu manuals.

>=20
>=20
> Q2.  Can you please list what are the architechtures it is supporting
> at present.
>=20
>=20
> Q3.  Consider the case of Distributed systems, where the processors
> are connected through the network and say i am trying to transmit dat=
a
> over the TCP/IP stack. Is it=20
>         possible to monitor the data send at our end and data receive=
d
> from the other end using the perf tool??

The perf tools work with pipe so that we might use nc/netcat for this.
Only tested on a local machine:

<on terminal 1>
$ nc -l localhost 8282 | perf report -i -

<on terminal 2>
$ perf record -o - sleep 1 | nc localhost 8282


>=20
>=20
> Q4. when using perf record. Say i have got the data in perf.data file=
=2E
> Say i am using this file to get some information and assume that
> system crashes and the perf.data file is=20
>       in inconsistent state. when u reboot the system after the crash=
,
> is it posssible to get the perf.data file safely.???

I doubt you can use the file safely.  There's no guarantee when system
crashed.

Thanks,
Namhyung

>=20
>=20
> Q5. Say i am counting some samples depending on the clock. and assume
> that i change the clock in between., Then the perf tool will be able
> to understand the situation and count the samples depending on the ol=
d
> and ne changed clocks or do we need to provide this information to
> perf tool.?? how to handle this situation??
