From: Chulmin Kim <cmkim@core.kaist.ac.kr>
Subject: Re: Does Perf support AMD cpu perfectly?
Date: Tue, 27 Nov 2012 00:43:24 +0900
Message-ID: <50B38E1C.3090401@core.kaist.ac.kr>
References: <50B3517A.7090505@core.kaist.ac.kr> <50B35D78.9090805@core.kaist.ac.kr> <50B3726C.8070706@core.kaist.ac.kr> <20121126140558.GD1210@krava.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from core.kaist.ac.kr ([143.248.147.118]:50597 "EHLO
	core.kaist.ac.kr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754304Ab2KZPoA (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 26 Nov 2012 10:44:00 -0500
In-Reply-To: <20121126140558.GD1210@krava.brq.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: linux-perf-users@vger.kernel.org



2012-11-26 =EC=98=A4=ED=9B=84 11:05, Jiri Olsa =EC=93=B4 =EA=B8=80:
> On Mon, Nov 26, 2012 at 10:45:16PM +0900, Chulmin Kim wrote:
>> Update for this issue.
>>
>> I'm investigating the kernel source.
>>
>> I found that Perf for AMD seems imperfect in linux 3.0 (my machine's
>> linux version).
>>
>> For AMD family 15h, there is a commented line as follow.
>>   - /* nortbridge counters not yet implemented: */  (line 541,
>> perf_event_amd.c )
>
> there were some updates for 15h models recently,
> you probably need to try latest sources
>

Thanks for your advice.

I installed v3.6.7 which is the latest stable kernel version.

However, the result of Perf shows that the northbridge event is not yet=
=20
supported as shown below.
root@ubuntu:~# /bin/perf stat -a -x ' ' -C 0 -e rc0 -e r4008307e1 sleep=
 1
3956883 raw 0xc0
<not supported> raw 0x4008307e1:HG

The recent patches for this issue might not have been included yet.

I should add the patchset I mentioned in this thread.
Will report it soon. :)


> jirka
>
