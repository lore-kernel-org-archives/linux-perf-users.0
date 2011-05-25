From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
Subject: Re: PEBS availability
Date: Wed, 25 May 2011 09:33:51 +0100
Message-ID: <4DDCBEEF.4000607@draigBrady.com>
References: <4DDBD387.2070906@draigBrady.com> <20110524203751.GA31843@dev1756.snc6.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail1.slb.deg.dub.stisp.net ([84.203.253.98]:15290 "HELO
	mail1.slb.deg.dub.stisp.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932782Ab1EYIf6 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 25 May 2011 04:35:58 -0400
In-Reply-To: <20110524203751.GA31843@dev1756.snc6.facebook.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <asharma@fb.com>
Cc: linux-perf-users@vger.kernel.org

On 24/05/11 21:37, Arun Sharma wrote:
> On Tue, May 24, 2011 at 04:49:27PM +0100, P=E1draig Brady wrote:
>>
>> So am I out of look with my new i3 sandy bridge CPU?
>> Are PEBS restricted to i7 versions only?
>> Is this documented anywhere?
>=20
> i3 and i7 are marketing terms that don't mean much.
> Engineers care more about the output of:
>=20
> #!/usr/bin/env python
>=20
> import struct
>=20
> def cpuid(eax):
>     f =3D open("/dev/cpu/0/cpuid", "rb")
>     f.seek(eax)
>     data =3D f.read(16)
>     f.close()
>     return struct.unpack('IIII', data)
>=20
> print "%x" % cpuid(1)[0]

206a7

>> Maybe I need some kernel support as hinted at by:
>> http://lwn.net/Articles/430100/
>> My kernel is 2.6.38.6-27.fc15.x86_64
>=20
> Your kernel probably has support for most of PEBS. What's missing is
> support in user space for all the events in manuals.
>=20
> http://thread.gmane.org/gmane.comp.linux.perfmon2.devel/2912
>=20
> Kernel is still missing:
>=20
> * Ability to dump all of x86 architectural state to perf.data on an
>   event
> * Uncore events
> * Exposing offcore events to userspace
>=20
> http://lwn.net/Articles/441209/ has a summary of recent discussions o=
n
> this topic.

Excellent. I'll start digging from there.

cheers,
P=E1draig.
