Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795581273;
	b=hX5vEr6IBZzSUm+eGsnDHmPX/PaCJwkluzsKBQHyw8zdpBq+ID1f0+OW44ySLssx0CQx
	 y7uYZGIEUtkgMEWKhOei6zJoqGF01wGzWFfHISdHIkuFs5F5+yPT6Fjo3ouQG6FLDjdXp
	 wnVpUTdWjRs+13MOJ/MapoYjnnPShhbFI1szEYSOBEjSr1Eq5hSvrAtE9KqNdMLKGXjtE
	 LOgDNe7puWTQwO6Q83xZ+2cUPDJYVEHDPtDbEujwdJLy6v/tHCYipt+0UTEGUqW381HlA
	 ZecGBRiokP1OgvAvVAX1W8HZOD75BKWFUkOgYurcTUt/Ey7UgFG90Fu1eh/wU3lA9Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795581273;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Content-Type:Mime-Version:Subject:
	 From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=nMHA4Wl7g1rAupMrR81aSIPl3+ZIUVoxVvBa4vbhtIw=;
	b=ZAXBjhceBqN/w5BXSKlrOwzvUVlA2pEPSQ9APOMVD2MBNaMP0gM1zMv2Jnguzh8aIDyh
	 2jb2fLbat7KD7WyCyw0zNnp5Mvu1RYucioGaYnl0bXnnSwlAguTksOuuoH/1Dbdyb2qpr
	 Guf6QvykcHbMfs6FbnqEc8BrEIojHcL6dFrYGFTxysGcFC7IACb0OP+ogVFlLivmBzsV4
	 WC6dVmuCE01KAv/VUQ/rXeHShrw9/f5taFm4/LRyNJWjUQ71SESHXeRBRNzUxBteJv96V
	 YHwTbXvH73mx57GzWL6hbLWPR+5InjITFVOlVyuFHrvQVqv3J9XHfoWEuLvz7Z2E32w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ej8Z9afm;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63BA606A31E;
	Wed, 25 Nov 2026 04:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B63BA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ej8Z9afm
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP2YsUM2924396;
	Wed, 25 Nov 2026 04:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nMHA4W
	l7g1rAupMrR81aSIPl3+ZIUVoxVvBa4vbhtIw=; b=Ej8Z9afmL9J7i8P/giTtJg
	LOiFqf3iGyBLns+Phiv97cACCzqdiEt/EC5j1uOSyErf6XcxDBy92RRrlIWm8Ma5
	je//YgHqqFEevn4tQEAqEMJqWZEsEBl4X3jl4grXuIWxJW3cJTU8bCsh3jwro/2O
	J0M8YHTatz5boLGnEv2TKF7hfcXpBdILLr0Hl/XQyxZw/E6nQNIBCP5vicjnrW2I
	hJRDZ61dAJlN8wbNuCErOFVv7f1YlqqoYa5eTFa7CNBYaXcaGxffagcDcz8l/J/O
	M4TiW7tWMVM+qIZ5F+pCMZu/xb19Dec4diu2hqcsia+d7VmzCLK2uO0eKOeTvV1w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4j7ha-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 04:33:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP2JG1U050584;
	Wed, 25 Nov 2026 04:33:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5axktn88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 04:33:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AP4Xiu831785504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 04:33:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76B3620043;
	Wed, 25 Nov 2026 04:33:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 288E42004B;
	Wed, 25 Nov 2026 04:33:38 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.39.27.234])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 25 Nov 2026 04:33:37 +0000 (GMT)
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
Subject: Re: [PATCH v3 05/19] perf/core: Implement BUILD_ID_OFFSET and
 CALLCHAIN_BUILD_ID_OFFSET sample types
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <CAP-5=fXzbPSJpTnuiBtMbs06-4Yq63f6e2U4G=Pn6Q2WmEGOPw@mail.gmail.com>
Date: Wed, 25 Nov 2026 10:03:25 +0530
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
Message-Id: <6B8C2484-D134-4B53-BF06-1AF6EB4E5E90@linux.ibm.com>
References: <20261116074414.3174737-1-irogers@google.com>
 <20261116074414.3174737-6-irogers@google.com>
 <27B92301-D708-4527-9988-3B39973558AE@linux.ibm.com>
 <CAP-5=fXzbPSJpTnuiBtMbs06-4Yq63f6e2U4G=Pn6Q2WmEGOPw@mail.gmail.com>
To: Ian Rogers <irogers@google.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAxNiBTYWx0ZWRfX215ZlKDYZOTu
 UhprbBFY6RyAYK49B27JLYL1MBcf1BagXxrPZwSWI7krg/NZqvqqU0GGE1S5RDF7bHYa/JNfQq3
 03RcrjkOp+Bzd5J6FcF/5KKvlCwF4aI=
X-Proofpoint-GUID: NtXTu6vTPOw30-R_xET9MEBHMZyJf5Hs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAxNiBTYWx0ZWRfX9IC6vsIfR1W0
 HqWR92nUyQW9EwYYLwvWQDCAv8yfNfBxeSXbipPwpLOG9H/gGwxhDdVc+lhMm1ATJL4C6j1Aq0J
 BxMvUKwH9tspueprz44DKCSY3VcshcULilitU7PHu+q2+LX7yTZdekIVgxc3ovXtybsajGz0DWn
 GWrCnphHjIeRkTLVbsqGtPLMXdXQ7+eA5FhbQUMJbWeaMYqEXogJFF6dEX4hnYxHG5N3+r8rVTv
 lapAGvW9EVU6E3R6HPS6HoHfyTPFH0v4DBRO7WKgRomc5J3vLbx9YGbl17hFnCS+haxBnQ3nCAW
 AYDYGKa6UH2BQHF7neKfeVqXM6uTWfkJ53GyaG/YNwUDV9TvV5KB5SGvNxuT+Cmx5JgOxqlZo+a
 vb4guG+Ut0npkzjk2SEPnkcTEQOV711WA9Qq8jR/Iitndl4TvdUKG4HditjomQrlNJkLjO3sPCg
 WK1pA8cx4WllV+gGNFw==
X-Proofpoint-ORIG-GUID: Lr7zbMKXiBRbWHiB9CTjjDCTykoQeBg1
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b06652b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=My7GPmCN7a5uxHF4voIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250016



> On 25 Nov 2026, at 2:59=E2=80=AFAM, Ian Rogers <irogers@google.com> =
wrote:
>=20
> On Tue, Nov 24, 2026 at 9:33=E2=80=AFAM Athira Rajeev =
<atrajeev@linux.ibm.com> wrote:
>>=20
>>> On 16 Nov 2026, at 1:14=E2=80=AFPM, Ian Rogers <irogers@google.com> =
wrote:
>>>=20
>>> Implement synchronous PERF_SAMPLE_BUILD_ID_OFFSET and
>>> PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET payload writing in the perf =
event
>>> core using stack_map_get_build_id_offset(..., may_fault=3Dfalse).
>>>=20
>>> For callchains, extend the per-CPU callchain buffers in
>>> kernel/events/callchain.c to provide scratch space to deduplicate =
build
>>> IDs and encode the compressed build ID table and tagged 64-bit =
offsets
>>> (with the top 8 bits storing the 1-based build ID index).
>>>=20
>>> Suggested-by: Namhyung Kim <namhyung@kernel.org>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>=20
>> Hi Ian
>>=20
>> I have few queries and adding them below
>=20
> [snip]
>=20
>>> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
>>> index 9d24b6e0c91f..935b34d2dd33 100644
>>> --- a/kernel/events/callchain.c
>>> +++ b/kernel/events/callchain.c
>>> @@ -9,6 +9,7 @@
>>> */
>>>=20
>>> #include <linux/perf_event.h>
>>> +#include <linux/bpf.h>
>>> #include <linux/slab.h>
>>> #include <linux/sched/task_stack.h>
>>> #include <linux/uprobes.h>
>>> @@ -31,6 +32,26 @@ static inline size_t =
perf_callchain_entry__sizeof(void)
>>> sysctl_perf_event_max_contexts_per_stack));
>>> }
>>>=20
>>> +static inline size_t perf_callchain_build_id_entry__sizeof(void)
>>> +{
>>> + return (sizeof(struct perf_callchain_build_id_entry) +
>>> + sizeof(__u64) * (sysctl_perf_event_max_stack +
>>> + sysctl_perf_event_max_contexts_per_stack));
>>> +}
>>> +
>>> +static inline size_t perf_callchain_bpf_build_id__sizeof(void)
>>> +{
>>> + return sizeof(struct bpf_stack_build_id) *
>>> +       (sysctl_perf_event_max_stack + 1);
>>> +}
>>> +
>>> +static inline size_t perf_callchain_context__sizeof(void)
>>> +{
>>> + return perf_callchain_entry__sizeof() +
>>> +       perf_callchain_build_id_entry__sizeof() +
>>> +       perf_callchain_bpf_build_id__sizeof();
>>> +}
>>> +
>>> static DEFINE_PER_CPU(u8, callchain_recursion[PERF_NR_CONTEXTS]);
>>> static atomic_t nr_callchain_events;
>>> static DEFINE_MUTEX(callchain_mutex);
>>> @@ -86,7 +107,7 @@ static int alloc_callchain_buffers(void)
>>> if (!entries)
>>> return -ENOMEM;
>>>=20
>>> - size =3D perf_callchain_entry__sizeof() * PERF_NR_CONTEXTS;
>>> + size =3D perf_callchain_context__sizeof() * PERF_NR_CONTEXTS;
>>=20
>>=20
>> in alloc_callchain_buffers(), we are changing size unconditionally to =
:
>>=20
>> size =3D perf_callchain_context__sizeof() * PERF_NR_CONTEXTS;
>>=20
>> Even if PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET is not set,
>> still the size grows for every case.
>>=20
>> This grows each per-CPU, per-context slot by the build ID table and =
the
>> bpf_stack_build_id scratch area, and it is not conditional on the new
>> sample types. get_callchain_buffers() is called for plain
>> PERF_SAMPLE_CALLCHAIN too, so as I read it, a plain "perf record -g"
>> (or any BPF tool using callchains) would also pay the extra memory on
>> every possible CPU, without --buildid-offset.
>>=20
>> Is that the intent? If not, could the extra scratch space be =
allocated
>> only when an event with PERF_SAMPLE_BUILD_ID_OFFSET or
>> PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET exists? It would also be good =
to
>> state the per-CPU memory cost in the commit message.
>=20
> Agreed, plain PERF_SAMPLE_CALLCHAIN shouldn't pay that extra per-CPU
> memory cost. Note that single-IP PERF_SAMPLE_BUILD_ID_OFFSET resolves
> on the stack when not combined with
> PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET, so only
> PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET needs the per-CPU scratch
> buffers.
>=20
> In v4 I've split the build-ID callchain scratch buffers into a
> separate refcounted allocation (get_callchain_build_id_buffers() /
> put_callchain_build_id_buffers(), tracked via
> PERF_ATTACH_CALLCHAIN_BUILD_ID) that is only allocated while at least
> one PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET event is active. Plain
> PERF_SAMPLE_CALLCHAIN events now incur zero extra memory overhead.
> I've also documented the exact per-CPU memory cost in the commit
> message (10,560 bytes per recursion slot, or 42,240 bytes / 41.25 KiB
> per possible CPU across PERF_NR_CONTEXTS=3D4 at the default
> perf_event_max_stack=3D127).

Hi Ian

Sure, Thanks for addressing the suggestion in V4
I will check the latest changes in V4

>=20
>>>=20
>>> for_each_possible_cpu(cpu) {
>>> entries->cpu_entries[cpu] =3D kmalloc_node(size, GFP_KERNEL,
>>> @@ -169,7 +190,22 @@ struct perf_callchain_entry =
*get_callchain_entry(int *rctx)
>>> cpu =3D smp_processor_id();
>>>=20
>>> return (((void *)entries->cpu_entries[cpu]) +
>>> - (*rctx * perf_callchain_entry__sizeof()));
>>> + (*rctx * perf_callchain_context__sizeof()));
>>> +}
>>> +
>>> +struct perf_callchain_build_id_entry *
>>> +get_callchain_build_id_entry(int *rctx, struct bpf_stack_build_id =
**bpf_bids)
>>> +{
>>> + void *base =3D get_callchain_entry(rctx);
>>> +
>>> + if (!base)
>>> + return NULL;
>>> +
>>> + base +=3D perf_callchain_entry__sizeof();
>>> + if (bpf_bids)
>>> + *bpf_bids =3D base + perf_callchain_build_id_entry__sizeof();
>>> +
>>> + return base;
>>> }
>>>=20
>>> void
>>> @@ -178,6 +214,172 @@ put_callchain_entry(int rctx)
>>> put_recursion_context(this_cpu_ptr(callchain_recursion), rctx);
>>> }
>>>=20
>>> +void perf_callchain_encode_build_ids(struct =
perf_callchain_build_id_entry *entry,
>>> +     const u64 *ips, u32 nr, u32 user_start,
>>> +     const struct bpf_stack_build_id *bpf_bids,
>>> +     u32 nr_bpf_bids, u32 max_size)
>>> +{
>>> + u32 nr_build_ids =3D 0, nr_offsets =3D 0;
>>> + u32 raw_bids_len =3D 0, aligned_bids_len =3D 0;
>>> +
>>> + static_assert(BUILD_ID_SIZE_MAX =3D=3D =
PERF_CALLCHAIN_BUILD_ID_MAX_SIZE);
>>> +
>>> + for (u32 i =3D 0; i < nr; i++) {
>>> + u64 ip =3D ips[i];
>>> + u64 encoded_offset;
>>> + const struct bpf_stack_build_id *bpf_bid =3D NULL;
>>> +
>>> + if (i >=3D user_start && i - user_start < nr_bpf_bids)
>>> + bpf_bid =3D &bpf_bids[i - user_start];
>>> +
>>> + if (bpf_bid && bpf_bid->status =3D=3D BPF_STACK_BUILD_ID_VALID) {
>>> + u32 pos =3D 0, found_idx =3D 0;
>>> +
>>> + for (u32 b =3D 0; b < nr_build_ids; b++) {
>>> + u8 sz =3D entry->build_ids[pos];
>>> +
>>> + if (sz =3D=3D BUILD_ID_SIZE_MAX &&
>>> +    !memcmp(&entry->build_ids[pos + 1],
>>> +    bpf_bid->build_id,
>>> +    BUILD_ID_SIZE_MAX)) {
>>> + found_idx =3D b + 1;
>>> + break;
>>> + }
>>> + pos +=3D 1 + sz;
>>> + }
>>> +
>>> + if (!found_idx &&
>>> +    nr_build_ids < PERF_CALLCHAIN_BUILD_ID_MAX_NRS) {
>>> + u32 next_raw_len =3D raw_bids_len + 1 + BUILD_ID_SIZE_MAX;
>>> + u32 next_aligned_len =3D ALIGN(next_raw_len, sizeof(u64));
>>> +
>>> + if (next_aligned_len + (i + 1) * sizeof(u64) > max_size)
>>> + break;
>>> + entry->build_ids[raw_bids_len] =3D BUILD_ID_SIZE_MAX;
>>> + memcpy(&entry->build_ids[raw_bids_len + 1],
>>> +       bpf_bid->build_id, BUILD_ID_SIZE_MAX);
>>> + nr_build_ids++;
>>> + raw_bids_len =3D next_raw_len;
>>> + aligned_bids_len =3D next_aligned_len;
>>> + found_idx =3D nr_build_ids;
>>> + }
>>> +
>>> + if (aligned_bids_len + (i + 1) * sizeof(u64) > max_size)
>>> + break;
>>> +
>>> + if (found_idx) {
>>> + encoded_offset =3D ((u64)found_idx << 56) |
>>> + (bpf_bid->offset & GENMASK_ULL(55, 0));
>>> + } else {
>>> + encoded_offset =3D ip & GENMASK_ULL(55, 0);
>>> + }
>>> + } else {
>>> + if (aligned_bids_len + (i + 1) * sizeof(u64) > max_size)
>>> + break;
>>> + if (i >=3D user_start && ip < PERF_CONTEXT_MAX)
>>> + encoded_offset =3D ip & GENMASK_ULL(55, 0);
>>> + else
>>> + encoded_offset =3D ip;
>>> + }
>>> +
>>> + entry->offsets[i] =3D encoded_offset;
>>> + nr_offsets =3D i + 1;
>>> + }
>>> +
>>> + if (nr_offsets > 0 && nr_offsets <=3D user_start &&
>>> +    entry->offsets[nr_offsets - 1] =3D=3D =
PERF_CONTEXT_USER_DEFERRED &&
>>> +    (nr_offsets < 2 ||
>>> +     entry->offsets[nr_offsets - 2] !=3D =
PERF_CONTEXT_USER_DEFERRED))
>>> + nr_offsets--;
>>> +
>>> + if (aligned_bids_len > raw_bids_len) {
>>> + memset(&entry->build_ids[raw_bids_len], 0,
>>> +       aligned_bids_len - raw_bids_len);
>>> + }
>>> + entry->nr_build_ids =3D nr_build_ids;
>>> + entry->nr_offsets =3D nr_offsets;
>>> + entry->build_ids_len =3D aligned_bids_len;
>>> +}
>>> +
>>> +static struct perf_callchain_build_id_entry =
__empty_callchain_build_id =3D {};
>>> +
>>> +struct perf_callchain_build_id_entry *
>>> +perf_callchain_build_id(struct perf_event *event,
>>> + struct perf_callchain_entry *callchain,
>>> + u64 ip, bool resolve_ip, u32 max_size)
>>> +{
>>> + bool crosstask =3D event->ctx->task && event->ctx->task !=3D =
current;
>>> + bool has_user_ctx =3D is_user_task(current) && current->mm && =
!crosstask;
>>> + struct perf_callchain_build_id_entry *entry;
>>> + struct bpf_stack_build_id *bpf_bids;
>>> + u32 nr, user_start, nr_bpf_bids =3D 0, ip_slot =3D 0;
>>> + int rctx;
>>> +
>>> + if (!callchain || !callchain->nr || max_size < sizeof(u64))
>>> + return &__empty_callchain_build_id;
>>> +
>>> + entry =3D get_callchain_build_id_entry(&rctx, &bpf_bids);
>>> + if (!entry)
>>> + return &__empty_callchain_build_id;
>>> +
>>> + entry->has_ip_bid =3D false;
>>> + nr =3D min_t(u64, callchain->nr,
>>> +   sysctl_perf_event_max_stack +
>>> +   sysctl_perf_event_max_contexts_per_stack);
>>> + user_start =3D nr;
>>> + if (has_user_ctx) {
>>> + for (u32 i =3D 0; i < nr; i++) {
>>> + if (callchain->ip[i] =3D=3D PERF_CONTEXT_USER) {
>>> + user_start =3D i + 1;
>>> + break;
>>> + }
>>> + }
>>> + if (user_start < nr) {
>>> + nr_bpf_bids =3D min_t(u32, nr - user_start,
>>> +    sysctl_perf_event_max_stack);
>>> + nr_bpf_bids =3D min_t(u32, nr_bpf_bids,
>>> +    max_size / sizeof(u64));
>>> + }
>>> + if (nr_bpf_bids > 0) {
>>> + if (resolve_ip) {
>>> + bpf_bids[0].ip =3D ip;
>>> + ip_slot =3D 1;
>>> + }
>>> + for (u32 i =3D 0; i < nr_bpf_bids; i++) {
>>> + bpf_bids[ip_slot + i].ip =3D
>>> + callchain->ip[user_start + i];
>>> + }
>>> + stack_map_get_build_id_offset(bpf_bids,
>>> +      ip_slot + nr_bpf_bids,
>>> +      true, false);
>>> + if (resolve_ip) {
>>> + memset(&entry->ip_bid, 0,
>>> +       sizeof(entry->ip_bid));
>>> + if (bpf_bids[0].status =3D=3D
>>> +    BPF_STACK_BUILD_ID_VALID) {
>>> + entry->ip_bid.size =3D
>>> + BUILD_ID_SIZE_MAX;
>>> + memcpy(entry->ip_bid.build_id,
>>> +       bpf_bids[0].build_id,
>>> +       BUILD_ID_SIZE_MAX);
>>> + entry->ip_bid.offset =3D
>>> + bpf_bids[0].offset;
>>> + } else {
>>> + entry->ip_bid.offset =3D ip;
>>> + }
>>> + entry->has_ip_bid =3D true;
>>> + }
>>> + }
>>> + }
>>> +
>>> + perf_callchain_encode_build_ids(entry, callchain->ip, nr, =
user_start,
>>> + bpf_bids + ip_slot, nr_bpf_bids,
>>> + max_size);
>>> + put_callchain_entry(rctx);
>>> +
>>> + return entry;
>>> +}
>>> +
>>> static void fixup_uretprobe_trampoline_entries(struct =
perf_callchain_entry *entry,
>>>      int start_entry_idx)
>>> {
>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>> index fd9f654de269..d38ffe52c301 100644
>>> --- a/kernel/events/core.c
>>> +++ b/kernel/events/core.c
>>> @@ -2096,6 +2096,9 @@ static void __perf_event_header_size(struct =
perf_event *event, u64 sample_type)
>>> if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
>>> size +=3D sizeof(data->code_page_size);
>>>=20
>>> + if (sample_type & PERF_SAMPLE_BUILD_ID_OFFSET)
>>> + size +=3D sizeof(struct perf_sample_build_id_offset);
>>> +
>>> event->header_size =3D size;
>>> }
>>>=20
>>> @@ -8396,6 +8399,78 @@ static void perf_output_read(struct =
perf_output_handle *handle,
>>> perf_output_read_one(handle, event, enabled, running);
>>> }
>>>=20
>>> +static void perf_bpf_to_sample_bid_offset(struct bpf_stack_build_id =
*bpf_bid)
>>> +{
>>> + struct perf_sample_build_id_offset *bid =3D (void *)bpf_bid;
>>> + u8 size =3D 0;
>>> +
>>> + static_assert(sizeof(*bid) =3D=3D sizeof(*bpf_bid));
>>> + static_assert(offsetof(struct perf_sample_build_id_offset, =
build_id) =3D=3D
>>> +      offsetof(struct bpf_stack_build_id, build_id));
>>> + static_assert(offsetof(struct perf_sample_build_id_offset, offset) =
=3D=3D
>>> +      offsetof(struct bpf_stack_build_id, offset));
>>> +
>>> + if (bpf_bid->status =3D=3D BPF_STACK_BUILD_ID_VALID)
>>> + size =3D BUILD_ID_SIZE_MAX;
>>=20
>> perf_bpf_to_sample_bid_offset() and perf_callchain_encode_build_ids() =
only ever
>> write size =3D BUILD_ID_SIZE_MAX for a resolved build ID, and size =3D =
0 for the unresolved case.
>> As far as I can see the table in =
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET,
>> therefore always contains BUILD_ID_SIZE_MAX-byte entries, although =
patch 03 documents it
>> as variable-length {u8 size; u8 data[size]}.
>>=20
>> Is there a case where size can be anything other than 0 or 20? If =
not,
>> could the UAPI comment in patch 03 say so?
>=20
> ELF build IDs can have lengths other than 20 bytes (e.g. 8-byte xxhash
> / --build-id=3D0x... or 16-byte MD5/UUID, alongside 20-byte SHA-1),
> matching struct perf_build_id::size (1..20) in PERF_RECORD_MMAP2.
Ok.
>=20
> In the kernel, stack_map_get_build_id_offset() currently uses struct
> bpf_stack_build_id which doesn't carry the parsed note length and
> zero-pads shorter build IDs to BUILD_ID_SIZE_MAX (20), so
> kernel-emitted table entries currently have size =3D=3D 20. However,
> user-space tools such as "perf inject --sample-buildids" write the
> exact DSO build ID length (1 <=3D size <=3D 20), and keeping size in =
the
> UAPI format also allows the kernel to emit unpadded lengths in the
> future without an ABI break. Note that table entries in
> PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET never have size =3D=3D 0 =
(unresolved
> frames are encoded via index 0x00 in offsets[] without adding a table
> entry).

Got it.
>=20
> I've updated the UAPI comment in Patch 03 for v4 to explain this
> explicitly (1 <=3D size <=3D 20, with the kernel currently =
zero-padding to
> 20 bytes via bpf_stack_build_id while user-space tools may emit the
> exact unpadded length).
Sure that helps

Thanks
Athira
>=20
> Thanks!
> Ian
>=20
>> Thanks
>> Athira


