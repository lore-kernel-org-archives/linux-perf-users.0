From: Arun Sharma <asharma@fb.com>
Subject: Re: PEBS availability
Date: Tue, 24 May 2011 13:37:51 -0700
Message-ID: <20110524203751.GA31843@dev1756.snc6.facebook.com>
References: <4DDBD387.2070906@draigBrady.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from outmail021.snc4.facebook.com ([66.220.144.153]:37122 "EHLO
	mx-out.facebook.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752528Ab1EXUhw (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 24 May 2011 16:37:52 -0400
Content-Disposition: inline
In-Reply-To: <4DDBD387.2070906@draigBrady.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: linux-perf-users@vger.kernel.org

On Tue, May 24, 2011 at 04:49:27PM +0100, P=E1draig Brady wrote:
>=20
> So am I out of look with my new i3 sandy bridge CPU?
> Are PEBS restricted to i7 versions only?
> Is this documented anywhere?

i3 and i7 are marketing terms that don't mean much.
Engineers care more about the output of:

#!/usr/bin/env python

import struct

def cpuid(eax):
    f =3D open("/dev/cpu/0/cpuid", "rb")
    f.seek(eax)
    data =3D f.read(16)
    f.close()
    return struct.unpack('IIII', data)

print "%x" % cpuid(1)[0]

>=20
> Maybe I need some kernel support as hinted at by:
> http://lwn.net/Articles/430100/
> My kernel is 2.6.38.6-27.fc15.x86_64

Your kernel probably has support for most of PEBS. What's missing is
support in user space for all the events in manuals.

http://thread.gmane.org/gmane.comp.linux.perfmon2.devel/2912

Kernel is still missing:

* Ability to dump all of x86 architectural state to perf.data on an
  event
* Uncore events
* Exposing offcore events to userspace

http://lwn.net/Articles/441209/ has a summary of recent discussions on
this topic.

 -Arun
