From: Chulmin Kim <cmkim@core.kaist.ac.kr>
Subject: Re: perf top -z not working?
Date: Wed, 17 Oct 2012 22:49:42 +0900
Message-ID: <507EB776.9030304@core.kaist.ac.kr>
References: <507EA40D.60206@cs.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from core.kaist.ac.kr ([143.248.147.118]:35150 "EHLO
	core.kaist.ac.kr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757061Ab2JQNuR (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 17 Oct 2012 09:50:17 -0400
In-Reply-To: <507EA40D.60206@cs.utoronto.ca>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: Ryan Johnson <ryan.johnson@cs.utoronto.ca>

2012-10-17 =EC=98=A4=ED=9B=84 9:26, Ryan Johnson =EC=93=B4 =EA=B8=80:
> Hi,
>
> (Please CC me in replies, not a list member)
>
> It seems that `perf top -z' does not behave as advertized, at least=20
> not on the 3.2.0-25 kernel (Ubuntu) that I'm running. The man page=20
> states that it should "zero history across display updates" but the=20
> counts still seem to accumulate (the total samples reported rises=20
> monotonically) and processes still show up in the display long after=20
> they have exited. Pressing `z' or `Z' seems to have no effect, either=
=2E

My kernel version is 3.0.0 (ubuntu 11.10).
Mine seems to work well. The result was not the accumulated one,=20
definitely.

In my opinion, it is a buf in the perf tool in that kernel version.

>
> Have I misunderstood this feature, or is this a bug that has perhaps=20
> been fixed in later kernel versions? I haven't been successful=20
> searching for information about it, beyond the man pages and what the=
=20
> perf wiki says.
>
> Thanks,
> Ryan
>
> --=20
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
