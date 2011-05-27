From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
Subject: Re: PEBS availability
Date: Fri, 27 May 2011 11:13:25 +0100
Message-ID: <4DDF7945.5@draigBrady.com>
References: <4DDBD387.2070906@draigBrady.com> <20110524203751.GA31843@dev1756.snc6.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail1.slb.deg.dub.stisp.net ([84.203.253.98]:5205 "HELO
	mail1.slb.deg.dub.stisp.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751401Ab1E0KPm (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 27 May 2011 06:15:42 -0400
In-Reply-To: <20110524203751.GA31843@dev1756.snc6.facebook.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

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
>=20
>>
>> Maybe I need some kernel support as hinted at by:
>> http://lwn.net/Articles/430100/
>> My kernel is 2.6.38.6-27.fc15.x86_64
>=20
> Your kernel probably has support for most of PEBS. What's missing is
> support in user space for all the events in manuals.
>=20
> http://thread.gmane.org/gmane.comp.linux.perfmon2.devel/2912

Well that was easy.
My Fedora 15 kernel was missing support for sandy bridge PEBS,
and creating a new bzImage with the patch I referenced makes
the counters available:

old-kern:$ perf stat -e L1-dcache-loads true
  Error: L1-dcache-loads event is not supported.
  Fatal: Not all events could be opened.

new-kern:$ perf stat -e L1-dcache-loads true
  98,331 L1-dcache-loads

cheers,
P=E1draig.
