From: Yunqi Zhang <yqzhang@ucsd.edu>
Subject: Re: question about stalls in perf
Date: Thu, 14 Feb 2013 05:45:58 +0000 (UTC)
Message-ID: <loom.20130214T064235-647@post.gmane.org>
References: <loom.20130214T005706-973@post.gmane.org> <511C4163.9050008@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:45325 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751831Ab3BNFqQ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 14 Feb 2013 00:46:16 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1U5reR-0008De-Id
	for linux-perf-users@vger.kernel.org; Thu, 14 Feb 2013 06:46:32 +0100
Received: from cpe-66-27-101-115.san.res.rr.com ([66.27.101.115])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Feb 2013 06:46:31 +0100
Received: from yqzhang by cpe-66-27-101-115.san.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Feb 2013 06:46:31 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

William Cohen <wcohen <at> redhat.com> writes:
>=20
> Hi Yunqi,
>=20
> It is probably best to find out which specific code are being used to=
 set up=20
counters for those events.  This
> can be found around the following line of code in the kernel for sand=
ybridge:
>=20
> http://lxr.linux.no/#linux+v3.7.7/arch/x86/kernel/cpu/perf_event_inte=
l.c#L2069
>=20
> 2068                /* UOPS_ISSUED.ANY,c=3D1,i=3D1 to count stall cyc=
les */
> 2069               =20
intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =3D
> 2070                        X86_CONFIG(.event=3D0x0e, .umask=3D0x01, =
=2Einv=3D1,=20
=2Ecmask=3D1);
> 2071                /* UOPS_DISPATCHED.THREAD,c=3D1,i=3D1 to count st=
all cycles*/
> 2072               =20
intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] =3D
> 2073                        X86_CONFIG(.event=3D0xb1, .umask=3D0x01, =
=2Einv=3D1,=20
=2Ecmask=3D1);
>=20
> The first event counts the number of cycles no ops are issued to the =
queue. =20
The=20
>=20
> The events are described in the Intel=C2=AE 64 and IA-32 Architecture=
s Software=20
Developer's Manual
> Combined Volumes 3A, 3B, and 3C: System Programming Guide, Parts 1 an=
d 2=20
available and the Architecture
> Optimization Reference Manual from:
>=20
> http://www.intel.com/content/www/us/en/processors/architectures-softw=
are-
developer-manuals.html
>=20
> Table 19-6 of volume 3 (Non-Architectural Performance Events In the P=
rocessor=20
Core Common to 2nd
> Generation Intel=C2=AE CoreTM i7-2xxx, Intel=C2=AE CoreTM i5-2xxx, In=
tel=C2=AE CoreTM i3-2xxx=20
Processor Series
> and Intel=C2=AE Xeon=C2=AE Processors E5 Family) describes the event =
for 0x0e and 0xb1.
>=20
> Chapter 2.1.1 of the Architecture optimizaiton manual describes the=20
sandybridge pipeline.  And B.3.2
> "Hierarchical Top-Down Performance Characterization Methodology and L=
ocating=20
Performance
> Bottlenecks" in the optimization manual describes front end and back =
end=20
stalls.
>=20
> -Will
>=20

Thanks a lot Will! Happy Valentine's Day!
