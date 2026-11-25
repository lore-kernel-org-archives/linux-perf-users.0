Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795581315;
	b=tB5AXnl2VDMGfSpqyrh8Bdz4uH7KufYJndeiB6onTMrQv6k+zdOrSWwehR7wqVbZYQKc
	 lN3o5WuFt1Bo0zJs6SvWEYYyD7BhTuuY+eTA/et75JL29eZ+5K+WY7HpY41Qp5reE+gda
	 7PnePISn9Fm4w6KL42pyoJIyi1MhXcBCGdeDIzOtz7sNeVh2T6q11GoeVZ0UtMaQT6pIn
	 U7Gptu8gkCE1WOmhZPgLmyA3a/1L5M6UO5Drc4AJeRwFx8tnGK9uDthWjzToGu5gyO3bJ
	 pFMOppt51VjjMj4vR5jBdA26LTMdaRoI6C1ZNkSj0D4PWrh1PMdoXaYN+9S4Y7iTnTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795581315;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Content-Type:Mime-Version:Subject:
	 From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Pun4vZnx401kKUP9E3hF28lvlD2KtzmRvYfuVIwamnw=;
	b=pNWN+9DrX2OSgCHa3oI4PRnW9lx8aL3gPxPJxMTY92PzLy27Dd/EWi/8zDmaPLV7TMIL
	 6tU86T0VJ2yYCsxCMZ2UTxaQ/5AXZsQviO90WQNKy+xY9tb14oeDkr39bkqGqPVSVVii9
	 alyovDXOrMEvnRj71uOEb8Urw9dgObVLlT2Ff/dG3lfb3/iI4WO4x/Zr9hrHfG6iwLMa6
	 lwoDvWCe5LyXsRN3iiftq7i3v1dOSqSpDRpgjJWcy2MfOOJaPSYoxncIpyUw2E6NiHSSa
	 9/FIgvWLMY9NDyZqOIuwUAuHGJAZCmthTw7vtqnqfu4xn7MWKYroEaaaa14Iu5wFZug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fBeqi8WU;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E85F606A31E;
	Wed, 25 Nov 2026 04:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E85F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fBeqi8WU
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP2ZCGx144866;
	Wed, 25 Nov 2026 04:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Pun4vZ
	nx401kKUP9E3hF28lvlD2KtzmRvYfuVIwamnw=; b=fBeqi8WUDDFDRCxSbhb2Ib
	fdRWjPSus3eKxoIge4ZUCRgXKBwXs5gScbjVAh11+gTgfAIi7sj/JMWFmitk2rW+
	KGWh8OWDzEqw/Rb5l7finmD1Q7P08wSNrNGHaz5DSWPxdwGXULYPUukLuyY2dpFJ
	vmIU2h7EeiX5mPNrxXtcnmaP9w8LldHqfpOMyKsnCmo5mbo0EZB7bxEzMU/PM1cX
	yOdLwcycoTyoTLUWONpQL2vSUXzbMd3ehVow5Sd+t4L9AzNt7p4XTH8gswy977Ol
	AgDjrHIaey9AkOrdagLVI/BM7WSUEbONHr9Yw25Y8gokKTjMKHFXc1IrESxyEyDw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34faav97-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 04:34:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP2JWjc1526269;
	Wed, 25 Nov 2026 04:34:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5a412syg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 04:34:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AP4YPYs38863130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 04:34:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BAE720043;
	Wed, 25 Nov 2026 04:34:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 448C320040;
	Wed, 25 Nov 2026 04:34:19 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.39.27.234])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 25 Nov 2026 04:34:19 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v3 03/19] perf/uapi: Add BUILD_ID_OFFSET sample types to
 UAPI
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <CAP-5=fU-tWJM7brF=YJGfX0fbdivH-oFDo0s=PCt-UcQcqEEfA@mail.gmail.com>
Date: Wed, 25 Nov 2026 10:04:08 +0530
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@linaro.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        Ihor Solodrai <ihor.solodrai@linux.dev>, Leo Yan <leo.yan@linux.dev>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Steinar H . Gunderson" <sesse@google.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Thomas Falcon <thomas.falcon@intel.com>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2CFB481C-CFCD-4828-A3C2-34E27649CAAC@linux.ibm.com>
References: <20261116074414.3174737-1-irogers@google.com>
 <20261116074414.3174737-4-irogers@google.com>
 <6F41ABBE-16A3-4B1F-96C0-D6369D5A5A55@linux.ibm.com>
 <CAP-5=fU-tWJM7brF=YJGfX0fbdivH-oFDo0s=PCt-UcQcqEEfA@mail.gmail.com>
To: Ian Rogers <irogers@google.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAxOCBTYWx0ZWRfX3BPFhA8TBiST
 IirIOu1vcuI3kN4tzXsqsq0lcLCjPSQJ9Qzapo/G+HhNkKIEe8vrqDL6/C/b4uciDb4D1AL6F0/
 ts/jH9w69XDtre1e2k+VWoaW29app1kCwjNt51i+ObbqbXQrsbCWuC9yZm06WwLwiKdBdYT4QXG
 gkEqfDK1WH4WTwlZCmA4TovIzlEdIkzqTN4t2xbpbOcnFOMpCB75Y/cZwNY7tlphrkNN02bML0f
 C25QPgsiGYepJtlIUHuMtaY3t118jr6SfRyoHgrLX1F4iBJEVIznLBpiLm82CetGbjBfoZ8Q2y2
 ZCkuliTSV+lJkVqcJRiCD4k/NXToMIc085XEHguFAEgN+RiTC0hnnL/31B/Sm9h+EQgkT0VMrN6
 3wOUbVwhvo0rw9GFIsItYDXF4E1EC38bpDOisR39HHwMuPE2hjtM8KAedPV0x4k0N7EkVOoUCBB
 k6FWe/vQbupPWUfW5Kg==
X-Proofpoint-ORIG-GUID: anoizqBN2M67_adt4LV7QbWWclWrE387
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b066555 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=t-w_3hl-lgbHpx5WNXoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: voo5dPGjiV-oj2_lBEWa22xinqD8yDAR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAxOCBTYWx0ZWRfX83Pxjbx5sNTo
 Y8POL7GDAi97ZF6/AkBfmeG9MvA967VOzdwGf3CSASK9EBZn3NwsFKCFIbQqXywR3G/uIpFWhSl
 Ta/gZpWL0DZTjfONxIkdcha7Dwy9T3c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250018



> On 25 Nov 2026, at 2:30=E2=80=AFAM, Ian Rogers <irogers@google.com> =
wrote:
>=20
> On Tue, Nov 24, 2026 at 2:36=E2=80=AFAM Athira Rajeev =
<atrajeev@linux.ibm.com> wrote:
>>=20
>>=20
>>=20
>>> On 16 Nov 2026, at 1:13=E2=80=AFPM, Ian Rogers <irogers@google.com> =
wrote:
>>>=20
>>> Introduce PERF_SAMPLE_BUILD_ID_OFFSET and
>>> PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET in enum =
perf_event_sample_format.
>>>=20
>>> For PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET (and
>>> PERF_RECORD_CALLCHAIN_DEFERRED when PERF_RECORD_MISC_MMAP_BUILD_ID =
is
>>> set), encode a deduplicated table of variable-length build IDs
>>> (u32 nr_build_ids, u32 nr_offsets, followed by packed { u8 size;
>>> u8 data[size]; } entries padded to 8-byte alignment) and an array of
>>> 64-bit offsets whose top 8 bits encode the 1-based build ID index =
(or
>>> 0x00 for unresolved user addresses and 0xff for kernel/context =
entries).
>>> In common cases where multiple callchain frames belong to the same
>>> binary, each unique build ID is encoded only once.
>>>=20
>>> Suggested-by: Namhyung Kim <namhyung@kernel.org>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>> include/uapi/linux/perf_event.h | 59 =
++++++++++++++++++++++++++++++---
>>> 1 file changed, 54 insertions(+), 5 deletions(-)
>>>=20
>>> diff --git a/include/uapi/linux/perf_event.h =
b/include/uapi/linux/perf_event.h
>>> index deb7c42d109b..775420ed9aee 100644
>>> --- a/include/uapi/linux/perf_event.h
>>> +++ b/include/uapi/linux/perf_event.h
>>> @@ -165,8 +165,10 @@ enum perf_event_sample_format {
>>> PERF_SAMPLE_DATA_PAGE_SIZE =3D 1U << 22,
>>> PERF_SAMPLE_CODE_PAGE_SIZE =3D 1U << 23,
>>> PERF_SAMPLE_WEIGHT_STRUCT =3D 1U << 24,
>>> + PERF_SAMPLE_BUILD_ID_OFFSET =3D 1U << 25,
>>> + PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET =3D 1U << 26,
>>>=20
>>> - PERF_SAMPLE_MAX =3D 1U << 25, /* non-ABI */
>>> + PERF_SAMPLE_MAX =3D 1U << 27, /* non-ABI */
>>> };
>>>=20
>>> #define PERF_SAMPLE_WEIGHT_TYPE (PERF_SAMPLE_WEIGHT | =
PERF_SAMPLE_WEIGHT_STRUCT)
>>> @@ -840,7 +842,8 @@ struct perf_event_mmap_page {
>>> *
>>> *   PERF_RECORD_MISC_EXACT_IP           - PERF_RECORD_SAMPLE of =
precise events
>>> *   PERF_RECORD_MISC_SWITCH_OUT_PREEMPT - PERF_RECORD_SWITCH* events
>>> - *   PERF_RECORD_MISC_MMAP_BUILD_ID      - PERF_RECORD_MMAP2 event
>>> + *   PERF_RECORD_MISC_MMAP_BUILD_ID      - PERF_RECORD_MMAP2 and
>>> + *                                         =
PERF_RECORD_CALLCHAIN_DEFERRED events
>>> *
>>> *
>>> * PERF_RECORD_MISC_EXACT_IP:
>>> @@ -852,7 +855,7 @@ struct perf_event_mmap_page {
>>> *   Indicates that thread was preempted in TASK_RUNNING state.
>>> *
>>> * PERF_RECORD_MISC_MMAP_BUILD_ID:
>>> - *   Indicates that mmap2 event carries build ID data.
>>> + *   Indicates that mmap2 or deferred callchain event carries build =
ID data.
>>> */
>>> #define PERF_RECORD_MISC_EXACT_IP (1 << 14)
>>> #define PERF_RECORD_MISC_SWITCH_OUT_PREEMPT (1 << 14)
>>> @@ -1095,6 +1098,38 @@ enum perf_event_type {
>>> * { u64 code_page_size;} && PERF_SAMPLE_CODE_PAGE_SIZE
>>> * { u64 size;
>>> *  char data[size]; } && PERF_SAMPLE_AUX
>>> + * { union {
>>> + * struct {
>>> + * struct perf_build_id bid;
>>> + * u64 offset;
>>> + * };
>>> + * struct {
>>> + * u64 zero;
>>> + * u64 context;
>>> + * u64 cookie;
>>> + * u64 ip;
>>> + * }; && attr.defer_callchain
>>> + *  }; } && PERF_SAMPLE_BUILD_ID_OFFSET
>>> + * { u32 nr_build_ids;
>>> + *  u32 nr_offsets;
>>> + *  struct {
>>> + * u8 size;
>>> + * u8 data[size];
>>> + *  }[nr_build_ids];
>>> + *  u8 pad[];
>>> + *  u64 offsets[nr_offsets];
>>> + *  #
>>> + *  # Entries in offsets[] include PERF_CONTEXT_* markers (which
>>> + *  # have top 8 bits 0xff). Kernel/hypervisor entries (after
>>> + *  # PERF_CONTEXT_KERNEL, PERF_CONTEXT_HV, PERF_CONTEXT_GUEST,
>>> + *  # or PERF_CONTEXT_GUEST_KERNEL) and the cookie word following
>>> + *  # PERF_CONTEXT_USER_DEFERRED are raw 64-bit values. User
>>> + *  # entries (after PERF_CONTEXT_USER or PERF_CONTEXT_GUEST_USER,
>>> + *  # or in PERF_RECORD_CALLCHAIN_DEFERRED) use the top 8 bits to
>>> + *  # encode a 1-based index (1..254) into the build_ids table and
>>> + *  # the lower 56 bits for the DSO file offset, or 0x00 for an
>>> + *  # unresolved user virtual address.
>>=20
>> Hi Ian,
>>=20
>> On PERF_SAMPLE_BUILD_ID_OFFSET, the layout comment doesn't say what =
is
>> written in the non-resolved cases. For =
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET
>> it is clear: kernel entries are raw 64-bit values, unresolved user =
entries
>> have 0x00 in the top byte, and resolved user entries carry the table =
index
>> and the 56-bit file offset.
>>=20
>> For the PERF_SAMPLE_BUILD_ID_OFFSET form, could the comment state:
>>=20
>> - What is written for a kernel IP? (e.g. bid.size =3D=3D 0 and offset =
=3D=3D raw IP?)
>> - What is written for an unresolved user IP? If bid.size =3D=3D 0, =
does
>>   =E2=80=9Coffset=E2=80=9D hold the raw virtual address?
>=20
> Yes, in both non-user (e.g. kernel/hypervisor) and unresolved user IP
> cases, bid is zeroed (bid.size =3D=3D 0) and offset holds the raw
> instruction pointer / virtual address. When attr.defer_callchain
> defers a user IP, the union carries zero =3D=3D 0 (so bid.size =3D=3D =
0),
> context =3D=3D PERF_CONTEXT_USER_DEFERRED, the stitching cookie, and =
the
> raw user IP.
>=20
> I've expanded the PERF_SAMPLE_BUILD_ID_OFFSET comment in Patch 03 for
> v4 to explicitly document all of these cases.

Thanks Ian for incorporating the feedback
I will check the updates patch in V4

Athira
> Thanks,
> Ian
>=20
>> Thanks,
>> Athira
>>=20
>>=20
>>> + * } && PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET
>>> * };
>>> */
>>> PERF_RECORD_SAMPLE =3D 9,
>>> @@ -1306,8 +1341,22 @@ enum perf_event_type {
>>> * struct {
>>> * struct perf_event_header header;
>>> * u64 cookie;
>>> - * u64 nr;
>>> - * u64 ips[nr];
>>> + * union {
>>> + * struct {
>>> + * u64 nr;
>>> + * u64 ips[nr];
>>> + * };
>>> + * struct {
>>> + * u32 nr_build_ids;
>>> + * u32 nr_offsets;
>>> + * struct {
>>> + * u8 size;
>>> + * u8 data[size];
>>> + * }[nr_build_ids];
>>> + * u8 pad[];
>>> + * u64 offsets[nr_offsets];
>>> + * }; && (header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)
>>> + * };
>>> * struct sample_id sample_id;
>>> * };
>>> */
>>> --
>>> 2.56.1.703.gf848ed807c-goog


