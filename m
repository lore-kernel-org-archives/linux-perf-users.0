Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DB61DE2A7;
	Fri,  7 Nov 2025 08:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762503604; cv=none; b=lfN+45leDpoFa1LqMXAJKkKN8v0x9x/uJX/PFjquzyzmQDXMCLZMODYvBPXa9kvyoch9lwRvWdvhgS3KCyrMMc/yqPpSueM9za4XN0slgpZVPY2eoAiz3Y1jk/qiOUQQuMzUXPs+Hz2+poUanURiFp977LsfQ6G3AgwxUtnzLVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762503604; c=relaxed/simple;
	bh=aEycOIF2ZSmcUdFpqybpeQeqAfCkAG7gAWXiLphtca0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bUwqu8+4wYyQ7FK9fvtfDbXmyxPt2ccNMPIep2YMRefkutvgXq3ifqM7peEGOKWY+fUdmqZt6EE41vDqy3+GRu42uFEx4NnlPdAmDCAcnnWMTUJSkIRPrgv8VlpGA8Kfx5JVHl2pVjsRBOsVcdHOIYApUkLSfKooDEkFZuhrp6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B6xhxBHB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B6xhxBHB"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A777Y4h009498;
	Fri, 7 Nov 2025 08:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vff1q1
	KCp9uUWDpwSTLhSHpZ+E+PK9aMaBkQQhC9MYs=; b=B6xhxBHBy/bLgkyfQ57i5H
	8vaGb3eLPrYHlfZE4eYc0ORTU82baloR9bKANb12cSjUu2PZgEZzSDh1WJ6DHsTB
	TDg3KpF5A77yaW6ywkRGRi8sOj8K1eFZukqDvG6vzC+BPVzGGcAi6y+i++eRXG+f
	vliPkgRIyuUcPkioUQONR4ZcJ1hwfGUoE+pX4s+PDiLilwOvaf0d6WVmFkOUDvdn
	jma48FK6QJjUS9lwQZWG6wmHGi1AFNZuZlx5BTLRf8ij7MveyIg4P1IE3ybWPCCH
	XKkzxyxSM44pa9fS4Uq0cLa277v0cW8q6JiF6Scf9/OushXZmcuuIvUnvjOhfO0Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a57mrjgg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Nov 2025 08:19:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A77gNHe018671;
	Fri, 7 Nov 2025 08:19:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5whnspwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Nov 2025 08:19:52 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A78Jm3R15925722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Nov 2025 08:19:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 248552004D;
	Fri,  7 Nov 2025 08:19:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF67F20043;
	Fri,  7 Nov 2025 08:19:47 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.111.27.154])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Nov 2025 08:19:47 +0000 (GMT)
Message-ID: <b02b6c7a1fcea87248a60ee9c94aaa6e078316d0.camel@linux.ibm.com>
Subject: Re: [PATCH 1/5] perf jitdump: Fix PID namespace detection
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Heiko
 Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander
 Gordeev <agordeev@linux.ibm.com>
Date: Fri, 07 Nov 2025 09:19:47 +0100
In-Reply-To: <aQ1WiC3Id82pTHAI@google.com>
References: <20251105191626.34998-1-iii@linux.ibm.com>
	 <20251105191626.34998-2-iii@linux.ibm.com> <aQ1WiC3Id82pTHAI@google.com>
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
X-Proofpoint-GUID: h6neX-eEZvu3WToUBcktW7VTcpqLbu1a
X-Authority-Analysis: v=2.4 cv=MKhtWcZl c=1 sm=1 tr=0 ts=690daba8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=YulnV17wfj68jahRgRsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: h6neX-eEZvu3WToUBcktW7VTcpqLbu1a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAwMSBTYWx0ZWRfX0rMMi2oaQ6Tg
 J3UpyGsnljVUfzV6FkXFKBMi8PtLneNo9Ck7TQcMm0DOXEfsWbDLt77ex7sRFW1tgVAenXVsYVU
 3n9HL0QNcJb93tFx1G5DrYxaW1ok0yZyI+Djo840XWQp0R7Ga3yjaGcyoO8Xgw1TML2qD4ahBMP
 HxRpThsSpXusu8SZecBbO38WIuPi2xAxY32ZweTIS462ILZX+0gtut18Sbr0y6d17IkoZsv/I3C
 4VADiIAnr1er2zN8NkrJsfn8jDHjjbDG6gAvJdYDXSsxVQr02igK5Lr2hjzbrcLUuntdvNLjUNs
 JbSnfk0SOk0McPC6SKrOi5BkiHU1x0bUw6EJkBrZgTVCIXzQwSq9nGxkcMvNK99j27/UVFTEliA
 K4VdbFEIp7PXF0cIRUS53/fa5H3lew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010001

On Thu, 2025-11-06 at 18:16 -0800, Namhyung Kim wrote:
> On Wed, Nov 05, 2025 at 08:10:24PM +0100, Ilya Leoshkevich wrote:
> > perf inject fails to detect jitdump file produced by a process
> > running in a different PID namespace if this process has not exited
> > yet.
> >=20
> > The PID namespace heuristic in jit_detect() compares two PIDs:
> >=20
> > * pid: outermost NStgid of mmap(jitdump) caller from perf's PoV.
> > * nsinfo__nstgid(nsi): innermost NStgid of mmap(jitdump) caller
> > from
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perf's PoV.
> >=20
> > The semantics of the in_pidns variable can be seen in, e.g.,
> > nsinfo__get_nspid(): it's true if and only if perf and the profiled
> > process are in different PID namespaces.
> >=20
> > The current logic is clearly inverted: if pid and
> > nsinfo__nstgid(nsi)
> > are different, then the profiled process must be in a different PID
> > namespace. This, of course, ignores that fact that they may end up
> > being equal by accident, but that's not the point here.
> >=20
> > Fix by flipping the comparison.
> >=20
> > Changing just that, however, breaks the case when the process has
> > exited. Add explicit support for that by adding "synthesized" field
> > to
> > nsinfo, which tracks whether NStgid was obtained from a running
> > process (ignoring considerations of PID reuse or running inject on
> > a different machine). When the namespace information is
> > synthesized,
> > assume the process ran in a different PID namespace.
>=20
> I'm not sure I'm following.=C2=A0 It'd be great if anyone understand the
> topic well could review.

Perhaps some data from the testcase from [5/5] can make it more clear.
Here are the PIDs that exist in reality:

             unshare[a] perf-record unshare[b] jshell
Host PIDNS:  1000       1001        1002       1003
PIDNS[a]:       -          1           2          3
PIDNS[b]:       -          -           -          1

In jit_detect() we deal with 2 of them.

- pid is jshell@PIDNS[a].
  It is taken from the MMAP2 event, this is how perf sees jshell.

- pid2 is jshell@PIDNS[b].
  It is taken from "jit-1.dump", this is how jshell sees itself.

- nsinfo__nstgid(nsi) ideally should be jshell@PIDNS[b].
  This is jshell's innermost NStgid.
  But perf can see it differently. This is the core of the problem this
  series deals with.

Why does nsinfo__nstgid(nsi) vary? Because the kernel does not record
it, and perf has to guess it. I have a WIP patch to fix that [1], but
it needs a lot more work at this point.

How does perf guess it? It looks into /proc/$PID/status. This is quite
unreliable, but this is the best perf can do under circumstances. As a
result we have 3 possibilities:

- The original process is still around. This is the buggy case. In this
  case nsinfo__nstgid(nsi) =3D=3D jshell@PIDNS[b]. IMHO this is a very
  clear indication of namespacing, and that's why the condition should
  be flipped.

- The original process has exited and PID was not reused. I believe
  this is the use case the current code has been extensively tested
  with. In this case perf assumes there was no namespacing and
  nsinfo__nstgid(nsi) =3D=3D pid. That's why I need the "synthesized"
  field: to indicate that NStgid is just an assumption and didn't come
  from any real data source.

- The original process has exited ans PID was reused. I am not trying
  to deal with this here, because this is rare and absolutely anything
  is possible. The only concern is running perf inject on a different
  machine, but I'm also not sure whether we should care about this.

[1]
https://github.com/iii-i/linux/commit/4b519b774eed850abe0757df39be13a704d27=
48e

[...]

> > diff --git a/tools/perf/util/namespaces.h
> > b/tools/perf/util/namespaces.h
> > index e95c79b80e27c..41ba2ea8137e5 100644
> > --- a/tools/perf/util/namespaces.h
> > +++ b/tools/perf/util/namespaces.h
> > @@ -38,6 +38,7 @@ DECLARE_RC_STRUCT(nsinfo) {
> > =C2=A0	bool			in_pidns;
> > =C2=A0	char			*mntns_path;
> > =C2=A0	refcount_t		refcnt;
> > +	bool			synthesized;
>=20
> It'd be nice if you can put this along with other bool fields.

Sure, will do.

[...]
>=20
