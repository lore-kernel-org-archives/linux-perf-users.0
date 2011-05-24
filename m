From: David Ahern <dsahern@gmail.com>
Subject: Re: PEBS availability
Date: Tue, 24 May 2011 11:26:09 -0600
Message-ID: <4DDBEA31.9070409@gmail.com>
References: <4DDBD387.2070906@draigBrady.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51132 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754881Ab1EXR0M (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 24 May 2011 13:26:12 -0400
Received: by pwi15 with SMTP id 15so3105464pwi.19
        for <linux-perf-users@vger.kernel.org>; Tue, 24 May 2011 10:26:11 -0700 (PDT)
In-Reply-To: <4DDBD387.2070906@draigBrady.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
Cc: linux-perf-users@vger.kernel.org



On 05/24/11 09:49, P=C3=A1draig Brady wrote:
> Hi,
>=20
> I've just got a shiny new i3-2310M and am a
> bit surprised that `perf` isn't listing
> detailed stats like L1 cache misses etc.

'perf list | grep Hardware' will show you counters recognized by perf
(perhaps with F15, "perf list hw"  works). You can add more counters
using the -e option.

You might also want to try 2.6.39 kernel and upstream version of perf.
Ingo added a number of default counters to perf stat.

David

>=20
> $ perf stat true
>=20
>  Performance counter stats for 'true':
>=20
>              1,239 cache-misses             #      1.555 M/sec
>              9,314 cache-references         #     11.693 M/sec
>              3,940 branch-misses            #      4.871 %
>             80,885 branches                 #    101.546 M/sec
>            403,808 instructions             #      0.000 IPC
>      <not counted> cycles
>                 81 page-faults              #      0.102 M/sec
>                  0 CPU-migrations           #      0.000 M/sec
>                  1 context-switches         #      0.001 M/sec
>           0.796537 task-clock-msecs         #      0.032 CPUs
>=20
>         0.024654938  seconds time elapsed
>=20
> I searched for a while but found it _very_ difficult
> to find info on what was available on particular intel CPUs.
>=20
> I did see in the "Nehalem Core PMU programming guide":
> http://software.intel.com/file/30320
> that the above stats are core features and that the other
> counters I mentioned are PEBS (Precise Event Based Sampling)
> and are not available on all systems.
>=20
> So am I out of look with my new i3 sandy bridge CPU?
> Are PEBS restricted to i7 versions only?
> Is this documented anywhere?
>=20
> Maybe I need some kernel support as hinted at by:
> http://lwn.net/Articles/430100/
> My kernel is 2.6.38.6-27.fc15.x86_64
>=20
> cheers.
> P=C3=A1draig.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-=
users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
