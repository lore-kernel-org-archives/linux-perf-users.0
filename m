Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795682291;
	b=US7t4r+ddRCTkNm+kjzt5c2V25/sx6XrBpv8UgZIGqhIOjcnc1+9x7o9R3DgvJyET3bq
	 u8mkQ00tWQBYxreKb2kxPVbvBJfkw22SpYdL19tOvGWs54e6yd9Uc8UvHnNZGNoMLqvik
	 dNnCVJHY03zBeYNYBk0a7YH6BuS630joOmqrxEs3JP0eAlnMW2Wyf9PbJTNzUfmwR4ruA
	 lvy+zNhW9Q5qJTlmUUdVvN+U0YSNwtTC1jE65zMijrfQecTMjTyTfdEw0CZRFCLdOCw5Y
	 7qs9tRfMaZUIrxc5b0RVm38dkYRoU+6/P6rgWcSDLppJgPvH6kFtC+Egw/bjJAlwwYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795682291;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Content-Type:Mime-Version:Subject:
	 From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=jhVvGmsB5ldw1X4MyRZWVsBvYtxsGi1fdITAl22qC20=;
	b=THbLXJ5GlV/FHlaaI4YgjkUXjR9v+/3mY77iB7XW+oeZqAQVYN8ImwwjfdKxg2VL6ZRF
	 0h6NJqVymiPC2OpSB+8KzONngzEMrtiHFYwxlOOSYiqZKbc58zNZGVoZbLrVa5bcQTnat
	 pzunCGQbVtkvoPBVSdsg4C/szDkYVUI7QH/SNghg6yzv0Wi5QoBojrQTLpF/JLXfYkJ5C
	 ZcaOYL8VSQp8IfSPl4TV1H+G62vL0MOJh4TjIk1bGxDTg/lwcJIICUJtYmce9mhZSMHyk
	 lgo0FPDyUhcEPNE/lwM/9DmwozrU15ecuVJPk/33vS+mofSuj7dlPvdtSRY8+WL50Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Nv4toPIE;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E161606A31E;
	Thu, 26 Nov 2026 08:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E161606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Nv4toPIE
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7YbdR3848599;
	Thu, 26 Nov 2026 08:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jhVvGm
	sB5ldw1X4MyRZWVsBvYtxsGi1fdITAl22qC20=; b=Nv4toPIEoBvFCxDMdBv/AP
	dIvoYeT1HCPrGpczD1af7wlYkWy3+COEI5mmDlnnJGUAnmxBTnglnmfCoG0+IeZm
	X3QpuueCeICq70aHE2hRcFNvY2HjknQLhj2+XA5Qmguhnwkqp+X9/WzjfYEdmD8p
	evSAUcZRlZ4a6ERFfabDX8IPSDwRTEiEAeJF9l2S7W9lQhoSYaTacYfRL3BPagIc
	1Hq6JEU1XFOOHg3AU1qUaSwnXgQsjwfSSvloRJZtjCEKPDLgA7SkkbcvczF/XTvR
	4mKKW1J2MWafC809Y0zk/Q83njASAIK0bzkDVcbC2vhtdHL4rOzaibOJ1b6H2DSQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fagged-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 08:37:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7JE0Y2009555;
	Thu, 26 Nov 2026 08:37:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5dcuxqse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 08:37:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AQ8bK9g53412264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Nov 2026 08:37:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 674A12004E;
	Thu, 26 Nov 2026 08:37:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8868C20040;
	Thu, 26 Nov 2026 08:37:11 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.39.28.169])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 26 Nov 2026 08:37:11 +0000 (GMT)
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
In-Reply-To: <awdaOldoL7p1Y_Sz@google.com>
Date: Thu, 26 Nov 2026 14:06:57 +0530
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Message-Id: <B9100586-CCA8-4A7B-B72C-40566CD32DB5@linux.ibm.com>
References: <20261116074414.3174737-1-irogers@google.com>
 <20261116074414.3174737-4-irogers@google.com>
 <6F41ABBE-16A3-4B1F-96C0-D6369D5A5A55@linux.ibm.com>
 <CAP-5=fU-tWJM7brF=YJGfX0fbdivH-oFDo0s=PCt-UcQcqEEfA@mail.gmail.com>
 <awdaOldoL7p1Y_Sz@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAzMyBTYWx0ZWRfXykgYbT9MYqOB
 4GUIgvcKFk9DYuDusoy6uNzAzNHNQnMtWhli4/gwEMhQ064JjC+tolDokqIjIxCDtTO9kal/Y+n
 TqC7gsdxzlVGIEb6vmpg640zmh2mg3O+c0R5dUfscXBmMD7c+Q6kVAEitrDszohPnIonEBoSH4V
 Sqa5VwVrTr/NPSFSEjNS8hZiehVyBeb4NzyW+OszEDyftXG9Kuld2UUMaPd2wNlHT85etqsDj3Q
 0AHOk0XEKglahAt049uBu9xiK8EbKdAPJBeje2XbibdjLpKVcTpXYqrGxxFZElcT1OTQbGY13Ka
 aRiqC8HVrxqkv7hhMDw879NW1kWIGr63N1p6vc2g9YtrdPsgTSjwdQ/harPh6EScMRAII2kJTpc
 cUfmN1MVYBt7tO80DfJ+8/Zw6dxjbBmRRNx5P3C8enE6VnWjmfrispplScjfhLKtUauMbHpgm2Q
 8IBUszwyqVixbDFv3gA==
X-Proofpoint-ORIG-GUID: r0Z5T7ifCTs0zlJEBBeAkhlPtI4e8zZF
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b07efc3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8 a=1ORlWx33G36LVKiDn8EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 7XgRSSZ63HcnvHcf0B52QT9yhBYZ28Yy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAzMyBTYWx0ZWRfX+7SZqvJa7tz0
 uMF0Si/jS6tGzcPs/GODsH3lbHgbHJm/SQFoEimhsIZWCudIMP7IrbiYd4KZTdx02W/LKW61FKD
 80ErrNSTJ4eNq8PC8INDdKErbEKxeYY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611260033



> On 26 Nov 2026, at 3:29=E2=80=AFAM, Namhyung Kim <namhyung@kernel.org> =
wrote:
>=20
> On Tue, Nov 24, 2026 at 01:00:06PM -0800, Ian Rogers wrote:
>> On Tue, Nov 24, 2026 at 2:36=E2=80=AFAM Athira Rajeev =
<atrajeev@linux.ibm.com> wrote:
>>>=20
>>>=20
>>>=20
>>>> On 16 Nov 2026, at 1:13=E2=80=AFPM, Ian Rogers <irogers@google.com> =
wrote:
>>>>=20
>>>> Introduce PERF_SAMPLE_BUILD_ID_OFFSET and
>>>> PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET in enum =
perf_event_sample_format.
>>>>=20
>>>> For PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET (and
>>>> PERF_RECORD_CALLCHAIN_DEFERRED when PERF_RECORD_MISC_MMAP_BUILD_ID =
is
>>>> set), encode a deduplicated table of variable-length build IDs
>>>> (u32 nr_build_ids, u32 nr_offsets, followed by packed { u8 size;
>>>> u8 data[size]; } entries padded to 8-byte alignment) and an array =
of
>>>> 64-bit offsets whose top 8 bits encode the 1-based build ID index =
(or
>>>> 0x00 for unresolved user addresses and 0xff for kernel/context =
entries).
>>>> In common cases where multiple callchain frames belong to the same
>>>> binary, each unique build ID is encoded only once.
>>>>=20
>>>> Suggested-by: Namhyung Kim <namhyung@kernel.org>
>>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>>> ---
>>>> include/uapi/linux/perf_event.h | 59 =
++++++++++++++++++++++++++++++---
>>>> 1 file changed, 54 insertions(+), 5 deletions(-)
>>>>=20
>>>> diff --git a/include/uapi/linux/perf_event.h =
b/include/uapi/linux/perf_event.h
>>>> index deb7c42d109b..775420ed9aee 100644
>>>> --- a/include/uapi/linux/perf_event.h
>>>> +++ b/include/uapi/linux/perf_event.h
>>>> @@ -165,8 +165,10 @@ enum perf_event_sample_format {
>>>> PERF_SAMPLE_DATA_PAGE_SIZE =3D 1U << 22,
>>>> PERF_SAMPLE_CODE_PAGE_SIZE =3D 1U << 23,
>>>> PERF_SAMPLE_WEIGHT_STRUCT =3D 1U << 24,
>>>> + PERF_SAMPLE_BUILD_ID_OFFSET =3D 1U << 25,
>>>> + PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET =3D 1U << 26,
>>>>=20
>>>> - PERF_SAMPLE_MAX =3D 1U << 25, /* non-ABI */
>>>> + PERF_SAMPLE_MAX =3D 1U << 27, /* non-ABI */
>>>> };
>>>>=20
>>>> #define PERF_SAMPLE_WEIGHT_TYPE (PERF_SAMPLE_WEIGHT | =
PERF_SAMPLE_WEIGHT_STRUCT)
>>>> @@ -840,7 +842,8 @@ struct perf_event_mmap_page {
>>>> *
>>>> *   PERF_RECORD_MISC_EXACT_IP           - PERF_RECORD_SAMPLE of =
precise events
>>>> *   PERF_RECORD_MISC_SWITCH_OUT_PREEMPT - PERF_RECORD_SWITCH* =
events
>>>> - *   PERF_RECORD_MISC_MMAP_BUILD_ID      - PERF_RECORD_MMAP2 event
>>>> + *   PERF_RECORD_MISC_MMAP_BUILD_ID      - PERF_RECORD_MMAP2 and
>>>> + *                                         =
PERF_RECORD_CALLCHAIN_DEFERRED events
>>>> *
>>>> *
>>>> * PERF_RECORD_MISC_EXACT_IP:
>>>> @@ -852,7 +855,7 @@ struct perf_event_mmap_page {
>>>> *   Indicates that thread was preempted in TASK_RUNNING state.
>>>> *
>>>> * PERF_RECORD_MISC_MMAP_BUILD_ID:
>>>> - *   Indicates that mmap2 event carries build ID data.
>>>> + *   Indicates that mmap2 or deferred callchain event carries =
build ID data.
>>>> */
>>>> #define PERF_RECORD_MISC_EXACT_IP (1 << 14)
>>>> #define PERF_RECORD_MISC_SWITCH_OUT_PREEMPT (1 << 14)
>>>> @@ -1095,6 +1098,38 @@ enum perf_event_type {
>>>> * { u64 code_page_size;} && PERF_SAMPLE_CODE_PAGE_SIZE
>>>> * { u64 size;
>>>> *  char data[size]; } && PERF_SAMPLE_AUX
>>>> + * { union {
>>>> + * struct {
>>>> + * struct perf_build_id bid;
>>>> + * u64 offset;
>>>> + * };
>>>> + * struct {
>>>> + * u64 zero;
>>>> + * u64 context;
>>>> + * u64 cookie;
>>>> + * u64 ip;
>>>> + * }; && attr.defer_callchain
>>>> + *  }; } && PERF_SAMPLE_BUILD_ID_OFFSET
>>>> + * { u32 nr_build_ids;
>>>> + *  u32 nr_offsets;
>>>> + *  struct {
>>>> + * u8 size;
>>>> + * u8 data[size];
>>>> + *  }[nr_build_ids];
>>>> + *  u8 pad[];
>>>> + *  u64 offsets[nr_offsets];
>>>> + *  #
>>>> + *  # Entries in offsets[] include PERF_CONTEXT_* markers (which
>>>> + *  # have top 8 bits 0xff). Kernel/hypervisor entries (after
>>>> + *  # PERF_CONTEXT_KERNEL, PERF_CONTEXT_HV, PERF_CONTEXT_GUEST,
>>>> + *  # or PERF_CONTEXT_GUEST_KERNEL) and the cookie word following
>>>> + *  # PERF_CONTEXT_USER_DEFERRED are raw 64-bit values. User
>>>> + *  # entries (after PERF_CONTEXT_USER or PERF_CONTEXT_GUEST_USER,
>>>> + *  # or in PERF_RECORD_CALLCHAIN_DEFERRED) use the top 8 bits to
>>>> + *  # encode a 1-based index (1..254) into the build_ids table and
>>>> + *  # the lower 56 bits for the DSO file offset, or 0x00 for an
>>>> + *  # unresolved user virtual address.
>>>=20
>>> Hi Ian,
>>>=20
>>> On PERF_SAMPLE_BUILD_ID_OFFSET, the layout comment doesn't say what =
is
>>> written in the non-resolved cases. For =
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET
>>> it is clear: kernel entries are raw 64-bit values, unresolved user =
entries
>>> have 0x00 in the top byte, and resolved user entries carry the table =
index
>>> and the 56-bit file offset.
>>>=20
>>> For the PERF_SAMPLE_BUILD_ID_OFFSET form, could the comment state:
>>>=20
>>> - What is written for a kernel IP? (e.g. bid.size =3D=3D 0 and =
offset =3D=3D raw IP?)
>>> - What is written for an unresolved user IP? If bid.size =3D=3D 0, =
does
>>>   =E2=80=9Coffset=E2=80=9D hold the raw virtual address?
>>=20
>> Yes, in both non-user (e.g. kernel/hypervisor) and unresolved user IP
>> cases, bid is zeroed (bid.size =3D=3D 0) and offset holds the raw
>> instruction pointer / virtual address. When attr.defer_callchain
>> defers a user IP, the union carries zero =3D=3D 0 (so bid.size =3D=3D =
0),
>> context =3D=3D PERF_CONTEXT_USER_DEFERRED, the stitching cookie, and =
the
>> raw user IP.
>=20
> Theoretically kernel IPs can have a build-ID as in /sys/kernel/notes.
> But I don't know if we have a way to lookup module address ranges and
> build-IDs easily.  Once that's available, it'd cover kernel IPs.
>=20
> Thanks,
> Namhyung

Thanks Ian, Namhyung, that clears up the non-resolved cases. One =
follow-up on the callchain form:

Where does the build-ID table live: per sample, or per event?

    =E2=80=A2 If it is per sample, the same binary appearing in many =
samples gets a table entry in each one.=20
Is that duplication acceptable, and is it how the format is meant to =
work?

    =E2=80=A2 If it is per event, so that common addresses and binaries =
across samples share one table,
how does a reader find the table for a given sample? Does the 8-bit =
index mean at most 255 distinct build-IDs per event?  What happens when =
the table exceeds 255 entries, or when a file offset needs more than 56 =
bits?
Do those entries fall back to the unresolved form (raw IP, 0x00 top =
byte), or does the event fail?

Thanks
Athira


