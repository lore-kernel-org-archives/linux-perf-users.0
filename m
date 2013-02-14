From: William Cohen <wcohen@redhat.com>
Subject: Re: question about stalls in perf
Date: Wed, 13 Feb 2013 20:44:03 -0500
Message-ID: <511C4163.9050008@redhat.com>
References: <loom.20130214T005706-973@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37414 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753828Ab3BNBoG (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 13 Feb 2013 20:44:06 -0500
In-Reply-To: <loom.20130214T005706-973@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Yunqi Zhang <yqzhang@ucsd.edu>
Cc: linux-perf-users@vger.kernel.org

On 02/13/2013 07:08 PM, Yunqi Zhang wrote:
> Hi all,
>=20
> Recently, I'm using perf to do some profiling work on SandyBridge.
>=20
> And I found two events stalled-cycles-frontend and stalled-cycles-bac=
kend
> very interesting, while I'm not sure what are their accurate definiti=
ons.
> So my question is which hardware counters on SandyBridge are used to
> calculate these two events and how (an equation would be perfect).
> Furthermore, I was wondering if it is possible for someone to tell
> me in which file this calculation processes in the source code of per=
f.
>=20
> Thanks a lot!
>=20
> Regards,
> Yunqi

Hi Yunqi,

It is probably best to find out which specific code are being used to s=
et up counters for those events.  This can be found around the followin=
g line of code in the kernel for sandybridge:

http://lxr.linux.no/#linux+v3.7.7/arch/x86/kernel/cpu/perf_event_intel.=
c#L2069


2068                /* UOPS_ISSUED.ANY,c=3D1,i=3D1 to count stall cycle=
s */
2069                intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLE=
S_FRONTEND] =3D
2070                        X86_CONFIG(.event=3D0x0e, .umask=3D0x01, .i=
nv=3D1, .cmask=3D1);
2071                /* UOPS_DISPATCHED.THREAD,c=3D1,i=3D1 to count stal=
l cycles*/
2072                intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLE=
S_BACKEND] =3D
2073                        X86_CONFIG(.event=3D0xb1, .umask=3D0x01, .i=
nv=3D1, .cmask=3D1);

The first event counts the number of cycles no ops are issued to the qu=
eue.  The=20

The events are described in the Intel=AE 64 and IA-32 Architectures Sof=
tware Developer's Manual
Combined Volumes 3A, 3B, and 3C: System Programming Guide, Parts 1 and =
2 available and the Architecture Optimization Reference Manual from:

http://www.intel.com/content/www/us/en/processors/architectures-softwar=
e-developer-manuals.html

Table 19-6 of volume 3 (Non-Architectural Performance Events In the Pro=
cessor Core Common to 2nd Generation Intel=AE CoreTM i7-2xxx, Intel=AE =
CoreTM i5-2xxx, Intel=AE CoreTM i3-2xxx Processor Series and Intel=AE X=
eon=AE Processors E5 Family) describes the event for 0x0e and 0xb1.

Chapter 2.1.1 of the Architecture optimizaiton manual describes the san=
dybridge pipeline.  And B.3.2 "Hierarchical Top-Down Performance Charac=
terization Methodology and Locating Performance Bottlenecks" in the opt=
imization manual describes front end and back end stalls.

-Will
