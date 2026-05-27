Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014ED37CD50;
	Wed, 27 May 2026 18:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779904967; cv=none; b=fnFlJ8eJ/SdWu4BAf5YrqSCHh1lSxmXXmAgjDwQu84GTpkDjA/CNAvicmNCpXbZ8a/6/Vy6rf77i6mIlFqCHbIr7FUhygss9HgBPRSZ3NIcGVxirg1hN2CkEkf1bh5DLS4SVJf3aaJxPQcpsN9W+rQvJX0gysbnazAvBgp1BmWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779904967; c=relaxed/simple;
	bh=98Pw/5u6ZbgkepYxlFi/qWRy3v74+mCS/3SL6fDtBXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLWv7nUKqIIPZHadqrCvvjz0/IfAbREUXK8SRtxuhRbMKHtQXspV4aZzuO0NEhd2fTveLz8yb9hEpfRO7T6Tw9rKllLawkHkub1BFETjpQDRCe9haz537nKvI4/tNLChNSpfZ+rc7hcF3AqUiYDEJ8aZDYNy/5WoirJHP7LbWzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pIS4pgHw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pIS4pgHw"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RCBNlJ3851596;
	Wed, 27 May 2026 18:02:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/YXJ2W
	vCKe2QKakQFQN4K3c0i/TmxW114l4mK6md3T8=; b=pIS4pgHwnMaY+03hWelXLf
	EQcWlEgcOhX3tj+fmSsLcVwrhf175srdMSl6HuYcttaF8/Orc7C8yw4dQi93ooKO
	4WqsqaRIG/eGzhtO6X7D7jsNUxSvjztISQWbtgBERVB1BGFHQ33AqiKXxqfpcwLO
	fwlNtxzbJ2ne6Rg9pxAJAcqwKmnid98DqIKZpiDOUpBzKxGhUYHD7YW9LTbnsis/
	uhow7OR4i11eLsutiOy5KhFVf1H6y0UFDHBH/fxIyoihmSQsG6gqloiwCGEljjMU
	MmlaYrwrptkMZ2qNEeBYbIr7Im/JfWqJzeGYxLpAdqjHBmwWqh2LaSotU/+e/yyg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4pdhhbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 18:02:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64RHs6O4012622;
	Wed, 27 May 2026 18:02:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbm9yw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 18:02:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64RI2cKc34210084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 18:02:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EF2920040;
	Wed, 27 May 2026 18:02:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C514720043;
	Wed, 27 May 2026 18:02:37 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown [9.111.1.41])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 27 May 2026 18:02:37 +0000 (GMT)
Date: Wed, 27 May 2026 20:02:36 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jens Remus <jremus@linux.ibm.com>, sashiko-reviews@lists.linux.dev,
        linux-perf-users@vger.kernel.org, Heiko Carens <hca@linux.ibm.com>
Subject: Re: [PATCH 1/1] perf build: Fix Python extension build with GCC 16
 hardening
Message-ID: <ahcxvFmVrTUArV40@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260520125637.105681-1-japo@linux.ibm.com>
 <20260520130905.9C85D1F000E9@smtp.kernel.org>
 <ahJnMnOr4i9urrRk@x1>
 <ahV2XGx_6h7upuc3@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <CAP-5=fXGG5PR8neTkozvOUOH83m8_EyZXZ_A7Zyrsock5EqAiQ@mail.gmail.com>
 <ahXITNt0Z-n4NCaj@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <CAP-5=fXcpoXMsezy1FNBX7mhKmRgw+97QmKTg5Fr6G-cY+wGpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXcpoXMsezy1FNBX7mhKmRgw+97QmKTg5Fr6G-cY+wGpg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=OdqoyBTY c=1 sm=1 tr=0 ts=6a1731c3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=y9RuvpZcgqoqoFVp2LMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: q2PLkj4NMDilKPWz6wKotmczUU7kaVmP
X-Proofpoint-ORIG-GUID: Ku5qAJPtYpVOFFlhHJlwh1qub-gXJeVi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE3NiBTYWx0ZWRfX08NYR7QZnAV8
 sPzk0eALyTOpuKrgwyb4Q9cn6al5k3m01yQrZE8lK2ELd0mhSHYdG50jVFSZ2u1dxtqQ10QLqS3
 UvIjAz3W5MbvFjjet6zVBjCh8MzaE+ikn7LIlvnTlZesbjfluCiNth65V6tnhTHNIYYdduxYw1E
 poVeoCXIy7F930DcuJfGPhNVSB1E2hvxMQvvhltOGnUe4VrlHgWAmGPEA43dXI8WjMavl8dVTqA
 SbUXlL+HDXnMt2gMDng+lL0jPRmYLTMDiSqIC/y+vW7UWf1KS3kT4ddkJyyySqKEqYo1heYz4sl
 bTCuFbhlkE78ydmv4SW8MgJu0+sToFF97kFu9WDGloyYp2Mfg3VbyKjHma1DFK5+RB0Jt25ShlX
 eZ7QDyV+4hIoQ5leF6+wvivEc/POfYBEyDv7NA+KuwEMq3mxmmylgV3rLxn7iefAIFyg64thBMx
 TxIh/d+tv2dxswVGz2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270176

On Tue, May 26, 2026 at 09:59:41AM -0700, Ian Rogers wrote:
> On Tue, May 26, 2026 at 9:20 AM Jan Polensky <japo@linux.ibm.com> wrote:
> >
> > On Tue, May 26, 2026 at 08:23:28AM -0700, Ian Rogers wrote:
> > > On Tue, May 26, 2026 at 3:35 AM Jan Polensky <japo@linux.ibm.com> wrote:
> > > >
> > > > On Sat, May 23, 2026 at 11:49:22PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > On Wed, May 20, 2026 at 01:09:05PM +0000, sashiko-bot@kernel.org wrote:
> > > > > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
[snip]
>
> So it appears that part of the problem is declaring arrays and structs
> to be const. Making things non-const I think is also not an option.
> Would  EXTRA_CFLAGS="-fvisibility=hidden" help?
>
> It would we interesting to build with -Wl,-z,notext and then look for
> the symbol the linker is fighting with:
>   eu-findtextrel perf.cpython....so
> or
>   readelf -d perf.so | grep TEXTREL
>   readelf -r perf.so
>
> Thanks,
> Ian
>

Hi,

building the Python perf extension on s390x shows GCC version-dependent behavior.

Build command:
make NO_LIBTRACEEVENT=1 python-perf

Verified build results:

GCC 15.2.0 (Ubuntu 15.2.0-4ubuntu4)
GNU ld (GNU Binutils for Ubuntu) 2.45
Build succeeds and creates python/perf.cpython-313-s390x-linux-gnu.so
Verification:
readelf -d python/perf.cpython-313-s390x-linux-gnu.so | grep TEXTREL
Output:
0x0000000000000016 (TEXTREL)            0x0

GCC 16.1.0 (cross-compiler)
GNU ld (GNU Binutils) 2.46
Build succeeds and creates python/perf.cpython-313-s390x-linux-gnu.so
Verification:
readelf -d python/perf.cpython-313-s390x-linux-gnu.so | grep TEXTREL
No output

GCC 16.1.1 20260515 (Red Hat 16.1.1-2)
GNU ld version 2.46-3.fc44
Build fails with:
 /usr/bin/ld.bfd: error: read-only segment has dynamic relocations

Analysis:

Base libraries libapi, libperf, libsubcmd, and libsymbol compiled with -g/-ggdb3 create DWARF debug sections with absolute relocations (R_390_64). When statically linked into the Python shared library, these become TEXTREL entries.

Observed behavior:

GCC 15.2.0 generates TEXTREL.
GCC 16.1.0 does not generate TEXTREL.
GCC 16.1.1 generates TEXTREL.

Binutils 2.45 accepts shared libraries with TEXTREL.
Binutils 2.46 rejects them.

Question to clarify:

What changed between GCC 16.1.0 and 16.1.1 on s390x that reintroduced TEXTREL generation here?

Best regards,
Jan

