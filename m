Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87063010C;
	Wed, 16 Apr 2025 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744814093; cv=none; b=QtmCyhGAuIJarHW/hb0qCI7vImFsdmOnvlEg6OlbnkVU+cuuQG4TorkCt+KxysRRdnvdPKHAShpoSeOjlHbpq9fDqisDbF3wdyqnBx2psV05Mv7ABb1EM09s82bhYNY5x2T/tTOrbxqXma9XoDBmMuwleQD8SE2A0FHj0Es3jEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744814093; c=relaxed/simple;
	bh=QFyKaxUthKoGDf3XyJwnR3PLEKV9cyA5KZcs9yqTQLM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rkllWYNs2hp2dLhjkIxq7g/cR0L1hDL+7HJyvlFwtO1sfjqyWB82SFlVuf9hANn549Ld2BqPSgI/PEkQ0zbervav7HoLRmDkoh6YnUL6rrX+GrFd9VDAvtITKmOVRMrQQVvNToV4i1e27xMp7zB09gqXF3JBpoZuhmgUdJ8Rbn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kec0mqLu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kec0mqLu"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GBrhuB001170;
	Wed, 16 Apr 2025 14:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dcwRrf
	HqFaaFXKYxZFsLs8lD0ir7B1W/+IjR7/gDxds=; b=Kec0mqLunA3PrpIuYHy1B4
	JdQYYl8qlJSN+86PPGzGNElrgcy5LgH69e9/j+g4fenQzXnHxc1MuGdVANaB9GrC
	881XDBt3I2/Fh4VVSgrA0Xok1MSmFxKnuh6rCvyfKSPwCUpGTmlSUcm9IqT4Ikt1
	L3b5AsSE1vjvlCv8JHfhu+QHWEfofCRSUrvFTWyWDHWhKby84K4auBzK8Jq+7jf3
	FaOL17oxqTnhuwwI5g9vsMfADpqs3GvIEar/QPCSJ5I33oHL2llJi+aM6DTQByca
	MHVnpwaW9xkD/r50u8GXOe6A81ZrUlMnHgGPhKWT/45uzgOiN96ssfJfnrDmeemA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4621dxbq2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 14:34:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53GEU3NS030899;
	Wed, 16 Apr 2025 14:34:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4603gnrtp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 14:34:36 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53GEYW4N22217120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 14:34:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96F1B20040;
	Wed, 16 Apr 2025 14:34:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C026920043;
	Wed, 16 Apr 2025 14:34:28 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.249.149])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 16 Apr 2025 14:34:28 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [mainline]tools/perf build warnings
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <99a06f56-08cf-42ce-a231-f9a38c6ece9a@linux.ibm.com>
Date: Wed, 16 Apr 2025 20:04:14 +0530
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, jiang.peng9@zte.com.cn,
        shao.mingyin@zte.com.cn, Thomas Gleixner <tglx@linutronix.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <51BBBC12-9A42-4D72-BDBB-84879C940764@linux.ibm.com>
References: <2c04b7ef-dc85-4a40-b0d8-6ae73c20b65d@linux.ibm.com>
 <B34E8075-7F38-4E30-9E51-23E43DDDF06F@linux.ibm.com>
 <1ec497ed-b98c-46aa-a9c2-5fa906790298@linux.ibm.com>
 <99a06f56-08cf-42ce-a231-f9a38c6ece9a@linux.ibm.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>
X-Mailer: Apple Mail (2.3776.700.51)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TUkjA3zz54nQpOfhejuFAnfRNrKljYi_
X-Proofpoint-GUID: TUkjA3zz54nQpOfhejuFAnfRNrKljYi_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_04,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 adultscore=0 clxscore=1011 mlxscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504160119



> On 16 Apr 2025, at 7:49=E2=80=AFPM, Venkat Rao Bagalkote =
<venkat88@linux.ibm.com> wrote:
>=20
>=20
> On 16/04/25 7:33 pm, Venkat Rao Bagalkote wrote:
>>=20
>> On 16/04/25 6:41 pm, Athira Rajeev wrote:
>>>=20
>>>> On 16 Apr 2025, at 5:12=E2=80=AFPM, Venkat Rao Bagalkote =
<venkat88@linux.ibm.com> wrote:
>>>>=20
>>>> Hello,
>>>>=20
>>>>=20
>>>> I am observing a new build warning on today mainline kernel, with =
head commit: g834a4a689699
>>>>=20
>>>> =
Repo:https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>>=20
>>>>=20
>>>> Warnings:
>>>>=20
>>>> diff -u tools/include/vdso/unaligned.h include/vdso/unaligned.h
>>>>=20
>>>>=20
>>>> If you happen to fix this, please add below tag.
>>>>=20
>>>>=20
>>>> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>>> Hi Venkat
>>>=20
>>> Can you please check with =
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.g=
it/?h=3Dtmp.perf-tools-next
>>> with the tmp.perf-tools-next branch..
>>=20
>>=20
>> I verified with perf-tools-next repo on both branches namely =
tmp.perf-tools-next and perf-tools-next, and I think this warning got =
recently introduced.
>=20
> /Typo in the last mail, please refer to below update./
>=20
> I verified with perf-tools-next repo on both branches namely =
tmp.perf-tools-next and perf-tools-next, and issue is not seen there. =
And I think this warning got recently introduced.

Hi Venkat,=20

Can you please check with this change:

=46rom 9a92d361ca2c22ac774b904211eb8c4f7c80fc85 Mon Sep 17 00:00:00 2001
From: Athira Rajeev <atrajeev@linux.ibm.com>
Date: Fri, 9 May 2025 07:49:40 -0500
Subject: [PATCH] tools headers: Update the include/vdso/unaligned.h to =
sync
 headers

To pick up the changes in:
commit acea9943271b ("vdso: Address variable shadowing in macros")

Addressing this perf tools build warning:

diff -u tools/include/vdso/unaligned.h include/vdso/unaligned.h

Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 tools/include/vdso/unaligned.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/include/vdso/unaligned.h =
b/tools/include/vdso/unaligned.h
index eee3d2a4dbe4..ff0c06b6513e 100644
--- a/tools/include/vdso/unaligned.h
+++ b/tools/include/vdso/unaligned.h
@@ -2,14 +2,14 @@
 #ifndef __VDSO_UNALIGNED_H
 #define __VDSO_UNALIGNED_H
  -#define __get_unaligned_t(type, ptr) ({ \
- const struct { type x; } __packed *__pptr =3D (typeof(__pptr))(ptr); \
- __pptr->x; \
+#define __get_unaligned_t(type, ptr) ({ \
+ const struct { type x; } __packed * __get_pptr =3D =
(typeof(__get_pptr))(ptr); \
+ __get_pptr->x; \
 })
  -#define __put_unaligned_t(type, val, ptr) do { \
- struct { type x; } __packed *__pptr =3D (typeof(__pptr))(ptr); \
- __pptr->x =3D (val); \
+#define __put_unaligned_t(type, val, ptr) do { \
+ struct { type x; } __packed * __put_pptr =3D =
(typeof(__put_pptr))(ptr); \
+ __put_pptr->x =3D (val); \
 } while (0)
   #endif /* __VDSO_UNALIGNED_H */
--  2.47.1

Thanks
Athira

Hi Namhyung,

I see we have few other warnings for which fixes is planned to picked =
for next cycle: =
https://lore.kernel.org/linux-perf-users/FE96FD04-4396-4C34-A70D-2A592FD5F=
916@linux.ibm.com/T/#me2ee1b70aeaad4901fb4d995b3b3015cd32f1adc

Can we also consider picking this one include/vdso/unaligned.h .. Once =
Venkat tests , I will post this as separate patch

Thanks
Athira
>=20
>>=20
>> Git Bisect is pointing to acea9943271b62905033f2f8ca571cdd52d6ea7b as =
first bad commit.
>>=20
>>=20
>> Below is the bisect log:
>>=20
>> git bisect log
>> git bisect start
>> # status: waiting for both good and bad commits
>> # bad: [834a4a689699090a406d1662b03affa8b155d025] Merge tag =
'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma
>> git bisect bad 834a4a689699090a406d1662b03affa8b155d025
>> # status: waiting for good commit(s), bad commit known
>> # good: [0af2f6be1b4281385b618cb86ad946eded089ac8] Linux 6.15-rc1
>> git bisect good 0af2f6be1b4281385b618cb86ad946eded089ac8
>> # bad: [ef7785882672e73847fb80f6c39e76998d4db57b] Merge tag =
'bcachefs-2025-04-10' of git://evilpiepirate.org/bcachefs
>> git bisect bad ef7785882672e73847fb80f6c39e76998d4db57b
>> # good: [e4742a89cfaced383db758bef94037637899487a] Merge tag =
'block-6.15-20250410' of git://git.kernel.dk/linux
>> git bisect good e4742a89cfaced383db758bef94037637899487a
>> # good: [eaa517b77e63442260640d875f824d1111ca6569] ethtool: cmis_cdb: =
Fix incorrect read / write length extension
>> git bisect good eaa517b77e63442260640d875f824d1111ca6569
>> # good: [ac253a537da3b210fa4b65d522d5533fc68f9515] Merge tag =
'perf-urgent-2025-04-10' of =
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>> git bisect good ac253a537da3b210fa4b65d522d5533fc68f9515
>> # good: [3c9de67dd37029cca1d0f391ff565b3809b40a1f] Merge tag =
'x86-urgent-2025-04-10' of =
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>> git bisect good 3c9de67dd37029cca1d0f391ff565b3809b40a1f
>> # bad: [0c7cae12f67c4c5fd232cffb27023deb409e1e20] Merge tag =
'irq-urgent-2025-04-10' of =
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>> git bisect bad 0c7cae12f67c4c5fd232cffb27023deb409e1e20
>> # bad: [34833819d2270ef96fa98fe3c1d3d297b5dec986] Merge tag =
'timers-urgent-2025-04-10' of =
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>> git bisect bad 34833819d2270ef96fa98fe3c1d3d297b5dec986
>> # good: [92e250c624ea37fde64bfd624fd2556f0d846f18] timekeeping: Add a =
lockdep override in tick_freeze()
>> git bisect good 92e250c624ea37fde64bfd624fd2556f0d846f18
>> # bad: [acea9943271b62905033f2f8ca571cdd52d6ea7b] vdso: Address =
variable shadowing in macros
>> git bisect bad acea9943271b62905033f2f8ca571cdd52d6ea7b
>> # first bad commit: [acea9943271b62905033f2f8ca571cdd52d6ea7b] vdso: =
Address variable shadowing in macros
>>=20
>>=20
>> Regards,
>>=20
>> Venkat.
>>=20
>>>=20
>>> Also there is a patchset here:
>>> =
https://lore.kernel.org/linux-perf-users/FE96FD04-4396-4C34-A70D-2A592FD5F=
916@linux.ibm.com/T/#m3e9d6aac4c34ebf42f18f3c213b7dff8f8c70d9d=20
>>>=20
>>> Which I think you have already tested..
>>>=20
>>> Thanks
>>> Athira
>>>>=20
>>>> Regards,
>>>>=20
>>>> Venkat.


