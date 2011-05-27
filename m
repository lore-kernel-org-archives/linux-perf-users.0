From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
Subject: Re: A shortcut to select generalized hw events
Date: Fri, 27 May 2011 14:46:19 +0100
Message-ID: <4DDFAB2B.90107@draigBrady.com>
References: <BANLkTinxXczFsG8hd8fQULiCch8-FnMbBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail1.slb.deg.dub.stisp.net ([84.203.253.98]:3862 "HELO
	mail1.slb.deg.dub.stisp.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753818Ab1E0Nsg (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 27 May 2011 09:48:36 -0400
In-Reply-To: <BANLkTinxXczFsG8hd8fQULiCch8-FnMbBA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Francis Moreau <francis.moro@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On 27/05/11 13:01, Francis Moreau wrote:
> Hello,
>=20
> Is there a mean to select all counters of a certain type ?
>=20
> For example I'd like to select all generalized hw counter with
> perf-stat, is this possible ?

I was looking for that too.
I didn't look too hard, but there was nothing obvious.
It would be very useful for example, to print all hardware counters
that are supported by the current system as you say.
To do that, I'm using this perf-hw script:

#!/bin/sh
hw_events=3D$(
 for i in $(perf list | sed -n 's/\[Hardware.*event\]//; T; s/ OR .*//;=
 p'); do
    perf stat -e $i true >/dev/null 2>&1 &&
     printf -- "-e %s \n" $i
 done | tr -d '\n'
)
perf stat $hw_events $*

cheers,
P=E1draig.
