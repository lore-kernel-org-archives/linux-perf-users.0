Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F51381EAA;
	Fri, 24 Jul 2026 07:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784876733; cv=none; b=Dk9xYI7nri2urDkqWZS8NyiEpTjtR6CEG9sqmsMl44b56VTECMzncmYkHyZ/vhxAmHIl+c4dF+T6jvC77GCzPluBEJr9p48QdeANEJZpe+O4ovSqzwoYaryYkYg9F6mOWz52mCqyWW2qD47JIprviQp3I3fZxrOOT60VdkZd1NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784876733; c=relaxed/simple;
	bh=XUbpMgWjS3eQLbh/6Yw5kIA0fDtK0Q7uc2UOWlyhSmY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VJaUGi6S9WcXEPu2dN17yMnpsUH+wO7trPhp4EaiD9cV3qz7DsWNTRa3ys9HBkFEi/+iOQL6zMiNkLo6uy51ZE2l/24PCnsEeDNJZAw27DW4sLoI7x0zFHRlYFpWWBKs5Om/w3q27M5m4Y4rYd0M4ulz026+gCZyPxeRkk4m5QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sKeiLy9J; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sKeiLy9J"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O5Bfsj919608;
	Fri, 24 Jul 2026 07:05:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7+xbnt
	d17Pbk6uJqqWEuI34yEVSgXnY3Vt1REyAKm7k=; b=sKeiLy9J05R64JKH6sfu31
	UO7dfLEdjSAYRYq7tMKccpvrGVfeZnGFqQYxOjHXFEOiiBFmgx0YFlJUvYpxs9fj
	OE1a+X9mpuLP+uYN67Cc157m8KbOAQ0deF89QnlVDBPFjkDOn0EaREFoPQ48wh+Q
	PlEqiQL6TZvgRi7QH6GM6cFan9dsB/UtSlWv4Cvd93s48qjd77jiRnxrJVmDejQS
	R3S3U91ahVdEfANKKpFIBtPL6QfiJIcjXG7lgUSGeTvpv5Qaljvi/krG7ZW4jd9n
	cVbpKBKmuST+UnJJPXaDvKm1A5MwpR/BI6W5U1Tnfo1S6zODYdaNpEvkitxv6rVQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg791bfyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 07:05:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O74fws007018;
	Fri, 24 Jul 2026 07:05:29 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6wfx85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 07:05:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66O75R0x49021424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 07:05:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16259201D8;
	Fri, 24 Jul 2026 07:05:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B8E2201D6;
	Fri, 24 Jul 2026 07:05:26 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.222.110])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 Jul 2026 07:05:26 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH V2 6/6] powerpc/perf/htm: Add documentation for Hardware
 Trace Macro PMU
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260720111748.95D4A1F00A3D@smtp.kernel.org>
Date: Fri, 24 Jul 2026 12:35:14 +0530
Cc: linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EA5FEAF7-4C4B-4FD7-B668-8B8EBFC1F8E3@linux.ibm.com>
References: <20260720104447.11843-1-atrajeev@linux.ibm.com>
 <20260720104447.11843-7-atrajeev@linux.ibm.com>
 <20260720111748.95D4A1F00A3D@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: egfWcuK7mRpvqw-nG_y1kkXLLk1j4qBC
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a630eba cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=x9h1URMS6bne3Vs6GEoA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA1OSBTYWx0ZWRfXzlop3L1wceIq
 FO5A/Tfw5YJ6EAaLbN563bSQa8SMFrIdKmFptpYZoSimB/ZVfQ844scEUW2l/tk3X1F+mtp79fH
 WePt6T8N47uBYZXAmzMUaqyPoLqs+Pc=
X-Proofpoint-GUID: egfWcuK7mRpvqw-nG_y1kkXLLk1j4qBC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA1OSBTYWx0ZWRfX4ZAO7gQIr7LJ
 iqkaEeYh6zYn1WL1Xw4L99VrejXoPRtVga96aGgcz4RGt6p38TOHZHBEKZP54rUEukwBFPT3Syt
 3gFT9N499DTWIObSGTwGBir947GdPRYVxztUKzhNBdyKh6uzfQwqCprSXg21ypRpnuW3fFMARHF
 xlT6UmzZl8tdJPsX74CEw8LUGKZsTEoJnFWLY9CMm8ITsAgowJ+AWc9uuPjtnMzd6j7Y/7jmGCP
 44wSFknS9zIQ1NtAiB+YZs2RX/Lw6/8u2SNcrz0W9iaxOBNZgsoasuyf8EXE/aWYGWFM3WDHqTN
 946tjlJ3/7RpXJqI50Wf3J1DP0Wt7uV3P5VGxp4DrofBUgSzsmWfWQX/82NZfQCneOdPHlWHriB
 SL2IPGvUQfFGgXDr5hmUuRtXe2kVeXFJNV29vsFZN9YYoJQSvOX4dnLzkHhu5IDVf80keSzO9kY
 H0BMZrFGJ5rtxp275lQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240059



> On 20 Jul 2026, at 4:47=E2=80=AFPM, sashiko-bot@kernel.org wrote:
>=20
> Thank you for your contribution! Sashiko AI review found 3 potential =
issue(s) to consider:
> - [Medium] The documentation states that `perf record` or `perf report =
-D` generates specific binary output files (`htm.bin.*` and =
`translation.*`), but this functionality does not exist in the upstream =
`tools/perf` codebase.
> - [Medium] The commit message claims to document `htmdecode` usage and =
notes on PMU restrictions, but these sections are entirely missing from =
the documentation text.
> - [Low] There are several grammatical errors, typos, and =
inconsistencies in the newly added documentation text.
> --
>=20
> --- Patch [6]: [PATCH V2 6/6] powerpc/perf/htm: Add documentation for =
Hardware Trace Macro PMU ---
> commit 630c94afa3c07b9d61db47792f5a5e0b40edd107
> Author: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> powerpc/perf/htm: Add documentation for Hardware Trace Macro PMU
>=20
> This commit extends the HTM documentation with a new section covering =
the
> perf PMU interface. It describes event configuration, syntax, basic =
usage
> examples, and expected output files.
>=20
>>    The added documentation covers:
>>=20
>>      - How to open HTM events using perf record, including the event
>>        syntax (nodalchipindex, nodeindex, htm_type, cpu=3DN) and the
>>        required AUX buffer size (-m,256).
>>=20
>>      - The two output files produced by perf report:
>>          htm.bin.nX.pX.cX     raw bus-trace AUX data
>>          translation.nX.pX.cX memory-configuration records
>>=20
>>      - How to pass the output files to htmdecode for trace decoding.
>>=20
>>      - Notes on system-wide collection (-a) vs CPU-pinned collection
>>        (-C N) and the one-event-per-target PMU restriction.
>=20
> [Severity: Medium]
> The commit message claims to document htmdecode usage, as well as =
notes on
> system-wide vs CPU-pinned collection and PMU restrictions, but these =
sections
> appear to be missing entirely from the added documentation text. Did =
these get
> dropped during patch iteration?
>=20
>> diff --git a/Documentation/arch/powerpc/htm.rst =
b/Documentation/arch/powerpc/htm.rst
>> index fcb4eb6306b16..d574fd2225ea5 100644
>> --- a/Documentation/arch/powerpc/htm.rst
>> +++ b/Documentation/arch/powerpc/htm.rst
> [ ... ]
>> @@ -94,7 +95,137 @@ This trace file will contain the relevant =
instruction traces
>> collected during the workload execution. And can be used as
>> input file for trace decoders to understand data.
>>=20
>> -Benefits of using HTM debugfs interface
>> +HTM perf interface usage
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=

> [ ... ]
>> +- event: "config:0-27"
>> +- htm_type: "config:0-3"
>> +- nodeindex: "config:4-11"
>> +- nodalchipindex: "config:12-19"
>> +- coreindexonchip: "config:20-27"
>> +
>> +1) nodeindex, nodalchipindex, coreindexonchip: this specifies
>> +   which partition to configure the HTM for.
>> +2) htmtype: specifies the type of HTM.
>=20
> [Severity: Low]
> This isn't a bug, but should this say htm_type instead of htmtype to =
match
> the parameter list above?
>=20
>> +
>> +Event Syntax
>> +------------
>> +
>> +The event configuration uses named parameters::
>> +
>> +   htm/nodeindex=3DN,nodalchipindex=3DC,coreindexonchip=3DR,htm_type=3D=
T/
>> +
>> +To open the event on a specific cpu can be specified using::
>=20
> [Severity: Low]
> This isn't a bug, but there is a grammatical error here. Could this be =
updated
> to something like "Opening the event on a specific CPU can be =
specified
> using::"?
>=20
>> +
>> +   =
htm/nodeindex=3DN,nodalchipindex=3DC,coreindexonchip=3DR,htm_type=3DT,cpu=3D=
x/
>> +
>> +Where:
>> +
>> +- N =3D node index
>> +- C =3D chip index within the node
>> +- R =3D core index on the chip
>> +- T =3D HTM type
>> +- x =3D CPU number
>> +
>> +Basic Usage Example
>> +-------------------
>> +
>> +To collect HTM trace data for a specific chip:
>> +
>> +.. code-block:: sh
>> +
>> +   # perf record -C 1 -e =
htm/nodalchipindex=3D2,nodeindex=3D0,htm_type=3D1/ <workload>
>> +
>> +In this example:
>> +
>> +- ``-C 1``: Collect on CPU 1
>> +- ``nodeindex=3D0``: Target node 0
>> +- ``nodalchipindex=3D2``: Target chip 2 within node 0
>> +- ``htm_type=3D1``: HTM trace type 1
>> +
>> +.. code-block:: sh
>> +
>> +   # perf record -m,256 -e =
htm/coreindexonchip=3D6,nodalchipindex=3D0,nodeindex=3D0,htm_type=3D2,cpu=3D=
16/ -a sleep 1
>> +
>> +In this example:
>> +
>> +- ``cpu=3D16``: Collect on CPU 16
>> +- ``nodeindex=3D0``: Target node 0
>> +- ``nodalchipindex=3D0``: Target chip 0 within node 0
>> +- ``coreindexonchip=3D6``: Target code 6
>=20
> [Severity: Low]
> This isn't a bug, but there's a typo here. Should "Target code" be
> "Target core"?
>=20
>> +- ``htm_type=3D2``: HTM trace type 2
>> +- ``-m,256``: specifies number of mmap pages
>> +
>> +Running trace collection for multiple targets:
>> +
>> +.. code-block:: sh
>> +
>> +   # perf record -m,256 -e =
htm/nodalchipindex=3D2,nodeindex=3D0,htm_type=3D1,cpu=3D8/ -e =
htm/nodalchipindex=3D1,nodeindex=3D0,htm_type=3D1,cpu=3D9/ -a sleep 1
>> +
>> +
>> +In this example, trace is collected for two events on different =
target chips
>> +
>> +Output Files
>> +------------
>> +
>> +After running ``perf record``, the following files are generated:
>> +
>> +.. code-block:: sh
>> +
>> +   # ls htm.bin.*
>> +   htm.bin.n0.p2.c0 htm.bin.n1.p3.c0  # Binary trace files
>> +
>> +   # ls translation.*
>> +   translation.n0.p2.c0  translation.n1.p3.c0  # Memory =
configuration files
>> +
>> +These files contain:
>> +
>> +- **htm.bin.*** - Raw HTM trace data in binary format
>> +- **translation.*** - Memory address translation information for =
decoding
>> +
>> +Complete Workflow Example
>> +--------------------------
>> +
>> +Here's a complete example of collecting and analyzing HTM traces:
>> +
>> +.. code-block:: sh
>> +
>> +   # Step 1: Collect trace data
>> +   perf record -C 1 -e htm/nodalchipindex=3D2,nodeindex=3D0,htm_type=3D=
1/ sleep 5
>> +
>> +   # Step 2: Verify output files
>> +   perf report -D
>> +
>> +   ls htm.bin.*        # Binary trace files
>> +   ls translation.*    # Memory configuration files
>=20
> [Severity: Medium]
> Does perf report -D natively generate these specific binary output =
files
> (htm.bin.* and translation.*) in the upstream tools/perf codebase?
>=20
> This documentation seems to describe a non-existent feature in =
upstream
> tools/perf and might rely on out-of-tree tooling that was not included =
in
> this patch series. Should this be updated to reflect only supported =
features?

Thanks for all the comments

I will address the wording/mistakes in V3.=20

The documentation is part of arch/powerpc and is generally picked via =
powerpc tree. Since tools side patches are posted
separately ( to be picked by tools side tree ) the patches adding the =
perf report changes are not in kernel series.

Thanks
Athira
>=20
>> +   ls perf.data        # Perf data file
>> +
>> +Benefits of using HTM interface
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/20260720104447.11843-1-atrajeev@linux.ibm.c=
om?part=3D6

