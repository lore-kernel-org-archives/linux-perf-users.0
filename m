Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923E62153C8;
	Wed, 16 Apr 2025 17:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744823780; cv=none; b=VfprLxGAZGm7zAEcU8pff9R0ObcTBb/NsmfZZJpK1aGcwUzRxYNjIf7KCubJJGJxWeoNLykpqJzzp+6lMSxcp8b24kzXdyV6qbzQBXRyy04dNWceL3TbhompT8EyzY/wSC17IjFVQAB3gujsva1Rlbpxw6z5VqI1zAnIPsij0sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744823780; c=relaxed/simple;
	bh=Ce5s6Z1CFV9qTUVus8GvzRNAMmORomOEL0qJSkFGRiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hHWGFeflvAndKiTiz+7jOdECbfxKhUthZbIpLrL+I03ZXmg0MTnqC7bFP8zAl0icojV34xQiMQ2unqhz9djQ4Qe8Vv5mFNEoTsLPXxRm+F5SMWsnHQlOyCt2gpBEdvN52e/YUthMBFXViNb3b8Zyj0gT8H3aONw1zLZIywbSpA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZUejlzbj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZUejlzbj"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GAerFV020699;
	Wed, 16 Apr 2025 17:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3JEXEK
	VtqBbKqxPYthqGMyYI10oaZ9cG2KfWeyoFoPs=; b=ZUejlzbjMR5Jp6lI2XDEyI
	9axyU76abEi0pMHNoNR39q6K9R6eRIrX/OtVwI54ik5ibIXS6diKzTi2H5NVwEpy
	ryjrV1weoJWmH+qucqYrl/sszY4CtcXvYJXa97eWQqnHNf2fFVyKDotXy2bGLUvE
	8l+EiSyKKZkRV+P5gjdLiEsREIJ2qWO5z/uONFHyCtrXMCD/AOXQxeV4DtFo51tG
	fdk7JXer/olvMtem6QxS51DiG0kSzLGurZgZXGIQDzXPVxfff+G4yQKYkzs4IMql
	FC/CFljnQxmtTGZNOdMbQvxpOxJX0pTbao0RZwECa7/cF9wpNnR1/r/6sbqIVNTg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462b0q22uh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 17:16:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53GE5MK4000937;
	Wed, 16 Apr 2025 17:16:07 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4602w01m0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 17:16:07 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53GHG6sX30081548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 17:16:06 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F11D358043;
	Wed, 16 Apr 2025 17:16:05 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4ABA75805F;
	Wed, 16 Apr 2025 17:16:03 +0000 (GMT)
Received: from [9.61.241.145] (unknown [9.61.241.145])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Apr 2025 17:16:03 +0000 (GMT)
Message-ID: <40981d32-72f4-4935-a62c-444ad78ce336@linux.ibm.com>
Date: Wed, 16 Apr 2025 22:46:02 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [mainline]tools/perf build warnings
Content-Language: en-GB
To: Athira Rajeev <atrajeev@linux.ibm.com>,
        Namhyung Kim
 <namhyung@kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Ingo Molnar
 <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, jiang.peng9@zte.com.cn,
        shao.mingyin@zte.com.cn, Thomas Gleixner <tglx@linutronix.de>
References: <2c04b7ef-dc85-4a40-b0d8-6ae73c20b65d@linux.ibm.com>
 <B34E8075-7F38-4E30-9E51-23E43DDDF06F@linux.ibm.com>
 <1ec497ed-b98c-46aa-a9c2-5fa906790298@linux.ibm.com>
 <99a06f56-08cf-42ce-a231-f9a38c6ece9a@linux.ibm.com>
 <51BBBC12-9A42-4D72-BDBB-84879C940764@linux.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <51BBBC12-9A42-4D72-BDBB-84879C940764@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JRQ73GbY8oRCS7nWmmcSSVbwr81oZVWv
X-Proofpoint-GUID: JRQ73GbY8oRCS7nWmmcSSVbwr81oZVWv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_06,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 mlxscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504160139


On 16/04/25 8:04 pm, Athira Rajeev wrote:
>
>> On 16 Apr 2025, at 7:49 PM, Venkat Rao Bagalkote <venkat88@linux.ibm.com> wrote:
>>
>>
>> On 16/04/25 7:33 pm, Venkat Rao Bagalkote wrote:
>>> On 16/04/25 6:41 pm, Athira Rajeev wrote:
>>>>> On 16 Apr 2025, at 5:12 PM, Venkat Rao Bagalkote <venkat88@linux.ibm.com> wrote:
>>>>>
>>>>> Hello,
>>>>>
>>>>>
>>>>> I am observing a new build warning on today mainline kernel, with head commit: g834a4a689699
>>>>>
>>>>> Repo:https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>>>
>>>>>
>>>>> Warnings:
>>>>>
>>>>> diff -u tools/include/vdso/unaligned.h include/vdso/unaligned.h
>>>>>
>>>>>
>>>>> If you happen to fix this, please add below tag.
>>>>>
>>>>>
>>>>> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>>>> Hi Venkat
>>>>
>>>> Can you please check with https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/?h=tmp.perf-tools-next
>>>> with the tmp.perf-tools-next branch..
>>>
>>> I verified with perf-tools-next repo on both branches namely tmp.perf-tools-next and perf-tools-next, and I think this warning got recently introduced.
>> /Typo in the last mail, please refer to below update./
>>
>> I verified with perf-tools-next repo on both branches namely tmp.perf-tools-next and perf-tools-next, and issue is not seen there. And I think this warning got recently introduced.
> Hi Venkat,
>
> Can you please check with this change:
>
>  From 9a92d361ca2c22ac774b904211eb8c4f7c80fc85 Mon Sep 17 00:00:00 2001
> From: Athira Rajeev <atrajeev@linux.ibm.com>
> Date: Fri, 9 May 2025 07:49:40 -0500
> Subject: [PATCH] tools headers: Update the include/vdso/unaligned.h to sync
>   headers
>
> To pick up the changes in:
> commit acea9943271b ("vdso: Address variable shadowing in macros")
>
> Addressing this perf tools build warning:
>
> diff -u tools/include/vdso/unaligned.h include/vdso/unaligned.h
>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>


Tested this patch and it fixes the reported warnings. Hence,

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Logs:


make -C perf/
make: Entering directory '/root/linux/tools/perf'
   BUILD:   Doing 'make -j32' parallel build
Warning: Kernel ABI header differences:
   diff -u tools/include/uapi/linux/bits.h include/uapi/linux/bits.h
   diff -u tools/include/linux/bits.h include/linux/bits.h
   diff -u tools/arch/arm64/include/asm/cputype.h 
arch/arm64/include/asm/cputype.h
Makefile.config:1093: No libcapstone found, disables disasm engine 
support for 'perf script', please install libcapstone-dev/capstone-devel
Makefile.config:1155: libpfm4 not found, disables libpfm4 support. 
Please install libpfm4-dev

Auto-detecting system features:
...                                   libdw: [ on  ]
...                                   glibc: [ on  ]
...                                  libbfd: [ on  ]
...                          libbfd-buildid: [ on  ]
...                                  libelf: [ on  ]
...                                 libnuma: [ on  ]
...                  numa_num_possible_cpus: [ on  ]
...                                 libperl: [ on  ]
...                               libpython: [ on  ]
...                               libcrypto: [ on  ]
...                               libunwind: [ OFF ]
...                             libcapstone: [ OFF ]
...                               llvm-perf: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                               get_cpuid: [ OFF ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]

   GEN     common-cmds.h
   GEN /root/linux/tools/perf/arch/arm64/include/generated/asm/sysreg-defs.h
   PERF_VERSION = 6.15.rc2.g834a4a689699
   GEN     perf-archive
   GEN     perf-iostat
   CC      jvmti/libjvmti.o


Regards,

Venkat.

> ---
>   tools/include/vdso/unaligned.h | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tools/include/vdso/unaligned.h b/tools/include/vdso/unaligned.h
> index eee3d2a4dbe4..ff0c06b6513e 100644
> --- a/tools/include/vdso/unaligned.h
> +++ b/tools/include/vdso/unaligned.h
> @@ -2,14 +2,14 @@
>   #ifndef __VDSO_UNALIGNED_H
>   #define __VDSO_UNALIGNED_H
>    -#define __get_unaligned_t(type, ptr) ({ \
> - const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr); \
> - __pptr->x; \
> +#define __get_unaligned_t(type, ptr) ({ \
> + const struct { type x; } __packed * __get_pptr = (typeof(__get_pptr))(ptr); \
> + __get_pptr->x; \
>   })
>    -#define __put_unaligned_t(type, val, ptr) do { \
> - struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr); \
> - __pptr->x = (val); \
> +#define __put_unaligned_t(type, val, ptr) do { \
> + struct { type x; } __packed * __put_pptr = (typeof(__put_pptr))(ptr); \
> + __put_pptr->x = (val); \
>   } while (0)
>     #endif /* __VDSO_UNALIGNED_H */
> --  2.47.1
>
> Thanks
> Athira
>
> Hi Namhyung,
>
> I see we have few other warnings for which fixes is planned to picked for next cycle: https://lore.kernel.org/linux-perf-users/FE96FD04-4396-4C34-A70D-2A592FD5F916@linux.ibm.com/T/#me2ee1b70aeaad4901fb4d995b3b3015cd32f1adc
>
> Can we also consider picking this one include/vdso/unaligned.h .. Once Venkat tests , I will post this as separate patch
>
> Thanks
> Athira
>>> Git Bisect is pointing to acea9943271b62905033f2f8ca571cdd52d6ea7b as first bad commit.
>>>
>>>
>>> Below is the bisect log:
>>>
>>> git bisect log
>>> git bisect start
>>> # status: waiting for both good and bad commits
>>> # bad: [834a4a689699090a406d1662b03affa8b155d025] Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma
>>> git bisect bad 834a4a689699090a406d1662b03affa8b155d025
>>> # status: waiting for good commit(s), bad commit known
>>> # good: [0af2f6be1b4281385b618cb86ad946eded089ac8] Linux 6.15-rc1
>>> git bisect good 0af2f6be1b4281385b618cb86ad946eded089ac8
>>> # bad: [ef7785882672e73847fb80f6c39e76998d4db57b] Merge tag 'bcachefs-2025-04-10' of git://evilpiepirate.org/bcachefs
>>> git bisect bad ef7785882672e73847fb80f6c39e76998d4db57b
>>> # good: [e4742a89cfaced383db758bef94037637899487a] Merge tag 'block-6.15-20250410' of git://git.kernel.dk/linux
>>> git bisect good e4742a89cfaced383db758bef94037637899487a
>>> # good: [eaa517b77e63442260640d875f824d1111ca6569] ethtool: cmis_cdb: Fix incorrect read / write length extension
>>> git bisect good eaa517b77e63442260640d875f824d1111ca6569
>>> # good: [ac253a537da3b210fa4b65d522d5533fc68f9515] Merge tag 'perf-urgent-2025-04-10' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>> git bisect good ac253a537da3b210fa4b65d522d5533fc68f9515
>>> # good: [3c9de67dd37029cca1d0f391ff565b3809b40a1f] Merge tag 'x86-urgent-2025-04-10' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>> git bisect good 3c9de67dd37029cca1d0f391ff565b3809b40a1f
>>> # bad: [0c7cae12f67c4c5fd232cffb27023deb409e1e20] Merge tag 'irq-urgent-2025-04-10' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>> git bisect bad 0c7cae12f67c4c5fd232cffb27023deb409e1e20
>>> # bad: [34833819d2270ef96fa98fe3c1d3d297b5dec986] Merge tag 'timers-urgent-2025-04-10' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>> git bisect bad 34833819d2270ef96fa98fe3c1d3d297b5dec986
>>> # good: [92e250c624ea37fde64bfd624fd2556f0d846f18] timekeeping: Add a lockdep override in tick_freeze()
>>> git bisect good 92e250c624ea37fde64bfd624fd2556f0d846f18
>>> # bad: [acea9943271b62905033f2f8ca571cdd52d6ea7b] vdso: Address variable shadowing in macros
>>> git bisect bad acea9943271b62905033f2f8ca571cdd52d6ea7b
>>> # first bad commit: [acea9943271b62905033f2f8ca571cdd52d6ea7b] vdso: Address variable shadowing in macros
>>>
>>>
>>> Regards,
>>>
>>> Venkat.
>>>
>>>> Also there is a patchset here:
>>>> https://lore.kernel.org/linux-perf-users/FE96FD04-4396-4C34-A70D-2A592FD5F916@linux.ibm.com/T/#m3e9d6aac4c34ebf42f18f3c213b7dff8f8c70d9d
>>>>
>>>> Which I think you have already tested..
>>>>
>>>> Thanks
>>>> Athira
>>>>> Regards,
>>>>>
>>>>> Venkat.
>
