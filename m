From: Chulmin Kim <cmkim@core.kaist.ac.kr>
Subject: Re: Queries on using PERF tool
Date: Wed, 28 Nov 2012 15:02:43 +0900
Message-ID: <50B5A903.5080003@core.kaist.ac.kr>
References: <loom.20121128T064019-497@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from core.kaist.ac.kr ([143.248.147.118]:57795 "EHLO
	core.kaist.ac.kr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926Ab2K1GDW (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 28 Nov 2012 01:03:22 -0500
In-Reply-To: <loom.20121128T064019-497@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Shahina Rabbani <shahinarabbani.shaik@gmail.com>
Cc: linux-perf-users@vger.kernel.org



2012-11-28 =EC=98=A4=ED=9B=84 2:47, Shahina Rabbani =EC=93=B4 =EA=B8=80=
:
> Hi,
>
> I am a new user of PERF tool. I have few questions to ask about the P=
ERF tool.
> Please help me with the answers.
>
> Q1. Is it possible to use PERF tool on a piece of code? Say i have a =
process P1
> and the process has several functions F1, F2, F3. Is it possible to p=
erform
> profilng only on F1 Function ??
>

As other profiling tools do, PERF also supports monitoring per function=
=20
(per SYMBOL).

You can select the result related with the function you are interested =
in.

> Q2. Say i am using the PERF tool to counts some events depending on t=
he clock
> value. If i change the clock value in between, then PERF tool can be =
able to
> understand the situation and generate the event counts according to t=
he old and
> new clock values??

As far as I know, there is no such thing to change the event type=20
dynamically. Why don't you just monitor both of them simultaneously?

If you really want this job to be done in only this way,
you can make your own script which can change the event for Perf based=20
on the clock value (also monitored by Perf).



>
>
> Please Help.
>
> Thanks,
> Shahina Rabbani
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-=
users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
