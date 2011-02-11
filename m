From: Arun Sharma <arun@sharma-home.net>
Subject: Re: [perfmon2] updating perf tool
Date: Fri, 11 Feb 2011 11:44:54 -0800
Message-ID: <AANLkTi=h6Qb7aCB0wER-FEGMwkD6xp1sBgnQudTZ=e+x@mail.gmail.com>
References: <AANLkTim5QGwisxLEHHHECrE1nLSYFxzXEMu7hvTRy09=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53677 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757365Ab1BKToz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 11 Feb 2011 14:44:55 -0500
Received: by iwn9 with SMTP id 9so2753637iwn.19
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Feb 2011 11:44:54 -0800 (PST)
In-Reply-To: <AANLkTim5QGwisxLEHHHECrE1nLSYFxzXEMu7hvTRy09=@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Can Hankendi <hankendi@gmail.com>
Cc: linux-perf-users@vger.kernel.org

[ bcc: perfmon2-devel, +linux-perf-users ]

On Fri, Feb 11, 2011 at 11:16 AM, Can Hankendi <hankendi@gmail.com> wro=
te:
> Hi,
>
> I'm using 2.6.38 kernel and trying to run performance tests for indiv=
idual
> cores on my system. But it seems like current kernel doesn't include =
the
> patches for perf events. I tried to collect data per core with -A=C2=A0=
 and also
> -G parameters but I got "Error: unknown switch". Where can I find the=
 latest
> patch for perf tool? How can I update the perf tools so that i can us=
e the
> new capabilities of perf tool?
>

Per CPU collection is:

perf record -C <cpulist> -e <events>

 -Arun
