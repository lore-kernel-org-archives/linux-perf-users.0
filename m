Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E01D35CBAF;
	Fri, 14 Nov 2025 12:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763124284; cv=none; b=M/Fk9QfpNxe8JH9r/2ww3Kr/BqxP6BRc2HLcyTsrvkhUK6P85f6WG2StOikHKKMc1k29eWojTnKwilywahLUvEsOH3GUiDMk8aeBOtmdvtT1F3KAoSgWteD1528/+FldKLY3o2nFvZe/PArS2W49D3ZcXZF15Ylv4ds49e3NUoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763124284; c=relaxed/simple;
	bh=uIdvD80c2ogJDmoM3Dju5s3rxzdVktY2prITQJy0iHM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cwh44XGKf+lWtQB9Hzaofy3Li0CAy12UiSBW2dP7QI0x9+ymwSQYrlTZ+zRvsKumHUt1CkulprbBALW/LpfePJSPeWxwD8h4yoiKZxtvZt2cpPmakyq1pI8WsWxsHPtZ5gfD4kAlvMm7RoAoOiu1kPwLDqI6UyYbISO/u6aa69o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lht2D7Yf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lht2D7Yf"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADMlQ32032432;
	Fri, 14 Nov 2025 12:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=A8Jx31
	pMSc2/hl7MQBlLPgZT689RF6h4RusnFVtnA/Q=; b=lht2D7YfCz44VRNyhO+SdA
	NPqw1kFchVruDaXJZe9YViwqQkWUOcI7IQlBdvoqtPIiYOSquNsgV9wFzzoLtWm5
	IxELHtELauuUOGtLIMLu4rY106TFIurKkVdyMTd3bvnE+93kunxSBYn/Gbf5bmxX
	+q40OnEvF1c+gIbK4O9921+PHhSaIrNF3jEC25yVHGBNxnRVJS8TQL0IpnZXFSbX
	6GX1r9HQfzSGyFjtuaJ+IQ1nSnibvB0qrj/6rCuiVZgoqga8WMufiYscC8z26eL5
	odhUiqrxvpCGil/J9Fr4c26m2PG7WMW3WSRtnQgrfvBGHv3XkVy5Zj4xuzQnnXgQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4adreejehn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 12:44:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AECAbfh028893;
	Fri, 14 Nov 2025 12:44:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aag6sucvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 12:44:35 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AECiV1358327330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 12:44:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47FE520043;
	Fri, 14 Nov 2025 12:44:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C6C220040;
	Fri, 14 Nov 2025 12:44:30 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.87.137.218])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Nov 2025 12:44:30 +0000 (GMT)
Message-ID: <a7b8518583b7c19756c2e27f4bfc1afc696d87fe.camel@linux.ibm.com>
Subject: Re: [PATCH 1/5] perf jitdump: Fix PID namespace detection
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Heiko
 Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander
 Gordeev <agordeev@linux.ibm.com>
Date: Fri, 14 Nov 2025 13:44:30 +0100
In-Reply-To: <aRbjVG3q2kCOl8BJ@google.com>
References: <20251105191626.34998-1-iii@linux.ibm.com>
	 <20251105191626.34998-2-iii@linux.ibm.com> <aQ1WiC3Id82pTHAI@google.com>
	 <b02b6c7a1fcea87248a60ee9c94aaa6e078316d0.camel@linux.ibm.com>
	 <aRbjVG3q2kCOl8BJ@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE3OSBTYWx0ZWRfX8hCBPMB9rxui
 h2J4QSnCSH51l7Y1NEZP97JErXycQUBFBZU1Qd+j2z/lofBCV3rs3UiIkBqXNE3+VDmf/CHzA0Q
 2GLPzKQZjw0FWFRL4RSmIV/6J1YzvALuHT3zooglxyEkiplYaIAPNeRc9CQuT/HFxptCzm7lfsm
 EUlPYbkaKNZcDXFs7/SC8cFHOPme+uxLpi8VYt8tE4aB4rxa0vZxcKMbkFc+l5Ed4wakSa8ixYn
 0sXcJoumt4+EJfd5egmAybgXXWiQfhQHPSmyf/drYg0K7VdhhQn6lcN3b2cMUBb18igS6eQ8no4
 /0DI/V3RcRXoEyXslX97BwXsevwho8w5CrTmnJVy6Y6p3xXpDI0fLcnAC9Uf1goCyWThb5pvVYE
 0nItdnKztngu+nDeY2eLwzLF3Kk3ZA==
X-Proofpoint-ORIG-GUID: sgD5O6JKpJ4U_MvHtTR-KKFSKK5ySdWB
X-Authority-Analysis: v=2.4 cv=HIrO14tv c=1 sm=1 tr=0 ts=69172434 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jIsE1vcUAB7ibL3TajgA:9 a=QEXdDO2ut3YA:10 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-GUID: sgD5O6JKpJ4U_MvHtTR-KKFSKK5ySdWB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511130179

On Fri, 2025-11-14 at 00:07 -0800, Namhyung Kim wrote:
> Hello,
>=20
> Sorry for the delay.
>=20
> On Fri, Nov 07, 2025 at 09:19:47AM +0100, Ilya Leoshkevich wrote:
> > On Thu, 2025-11-06 at 18:16 -0800, Namhyung Kim wrote:
> > > On Wed, Nov 05, 2025 at 08:10:24PM +0100, Ilya Leoshkevich wrote:
> > > > perf inject fails to detect jitdump file produced by a process
> > > > running in a different PID namespace if this process has not
> > > > exited
> > > > yet.
> > > >=20
> > > > The PID namespace heuristic in jit_detect() compares two PIDs:
> > > >=20
> > > > * pid: outermost NStgid of mmap(jitdump) caller from perf's
> > > > PoV.
> > > > * nsinfo__nstgid(nsi): innermost NStgid of mmap(jitdump) caller
> > > > from
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perf's P=
oV.
> > > >=20
> > > > The semantics of the in_pidns variable can be seen in, e.g.,
> > > > nsinfo__get_nspid(): it's true if and only if perf and the
> > > > profiled
> > > > process are in different PID namespaces.
> > > >=20
> > > > The current logic is clearly inverted: if pid and
> > > > nsinfo__nstgid(nsi)
> > > > are different, then the profiled process must be in a different
> > > > PID
> > > > namespace. This, of course, ignores that fact that they may end
> > > > up
> > > > being equal by accident, but that's not the point here.
> > > >=20
> > > > Fix by flipping the comparison.
> > > >=20
> > > > Changing just that, however, breaks the case when the process
> > > > has
> > > > exited. Add explicit support for that by adding "synthesized"
> > > > field
> > > > to
> > > > nsinfo, which tracks whether NStgid was obtained from a running
> > > > process (ignoring considerations of PID reuse or running inject
> > > > on
> > > > a different machine). When the namespace information is
> > > > synthesized,
> > > > assume the process ran in a different PID namespace.
> > >=20
> > > I'm not sure I'm following.=C2=A0 It'd be great if anyone understand
> > > the
> > > topic well could review.
> >=20
> > Perhaps some data from the testcase from [5/5] can make it more
> > clear.
> > Here are the PIDs that exist in reality:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 unshare[a] perf-record unshare[b] jshell
> > Host PIDNS:=C2=A0 1000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1001=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1002=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 1003
> > PIDNS[a]:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
3
> > PIDNS[b]:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
1
> >=20
> > In jit_detect() we deal with 2 of them.
> >=20
> > - pid is jshell@PIDNS[a].
> > =C2=A0 It is taken from the MMAP2 event, this is how perf sees jshell.
> >=20
> > - pid2 is jshell@PIDNS[b].
> > =C2=A0 It is taken from "jit-1.dump", this is how jshell sees itself.
> >=20
> > - nsinfo__nstgid(nsi) ideally should be jshell@PIDNS[b].
> > =C2=A0 This is jshell's innermost NStgid.
> > =C2=A0 But perf can see it differently. This is the core of the problem
> > this
> > =C2=A0 series deals with.
>=20
> Thanks a lot for the example and explanation!=C2=A0 I'm trying to
> understand.
> :)

Thank you for the patience!

> > Why does nsinfo__nstgid(nsi) vary? Because the kernel does not
> > record
> > it, and perf has to guess it. I have a WIP patch to fix that [1],
> > but
> > it needs a lot more work at this point.
> >=20
> > How does perf guess it? It looks into /proc/$PID/status. This is
> > quite
> > unreliable, but this is the best perf can do under circumstances.
> > As a
> > result we have 3 possibilities:
> >=20
> > - The original process is still around. This is the buggy case. In
> > this
> > =C2=A0 case nsinfo__nstgid(nsi) =3D=3D jshell@PIDNS[b]. IMHO this is a =
very
> > =C2=A0 clear indication of namespacing, and that's why the condition
> > should
> > =C2=A0 be flipped.
>=20
> So perf would look at /proc/3/status and the file would have the
> below
>=20
> =C2=A0 NStgid:=C2=A0 1003=C2=A0 3=C2=A0 1
>=20
> and *in_pidns should be true, right?

It should be

    NStgid: 3  1

because perf itself is namespaced too - in this testcase nobody sees
the root PID namespace. I wrote it this way to make sure there are
no=C2=A0accidental leaks from the root PID namespace, but it's not very
important and perhaps obscures things somewhat unnecessarily.

But regardless, I believe that in this case setting *in_pidns to true
is the right thing.

> > - The original process has exited and PID was not reused. I believe
> > =C2=A0 this is the use case the current code has been extensively teste=
d
> > =C2=A0 with. In this case perf assumes there was no namespacing and
> > =C2=A0 nsinfo__nstgid(nsi) =3D=3D pid. That's why I need the "synthesiz=
ed"
> > =C2=A0 field: to indicate that NStgid is just an assumption and didn't
> > come
> > =C2=A0 from any real data source.
>=20
> Ok, can you please put short comments on each boolean field so that
> we
> can see the meaning of them clearly?

Sure, I can add this in v2.

[...]
