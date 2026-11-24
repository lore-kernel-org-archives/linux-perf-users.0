Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795516630;
	b=GtUmVP54CrMfMIxhZ6Hm6uw3oBF9Bj8W6SnTBR3AEW7eBj5Q89LKaHku6f8gpZIZ+qAC
	 pSwUU2qB3tUNjKPVlFho7EI4ViAmu2BGdvj6jE2XnCKy0WUNm86OWDlhRhjklB76M4aoy
	 TtYpKtFhz1dos4aCjhHSSjnwsKsZaWSPSTpie4/RXMtj/KEVbIpNxjHUJlGKY1zzJGLCv
	 F7lREXqUtqwRJATWjjwXVLdSmCkwNuzQnmynf5cey4XLUQ6/UsqrLJz00VkfCpdyX3V2U
	 Kqr3po/Q9ca8LRRJnZ9kDvzv+cbE7rEWnAl8GyqQjTN0I+/p06IhfulMWfJ+t1UqHBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795516630;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Content-Type:Mime-Version:Subject:
	 From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=PJzRt0OTpbouwoPXydBA/ffZV91Hp1Y2LkN44LQaldg=;
	b=hni2KXRdjJfQJxUAvcxYVrC7ReKXH6QlHDXFT4s4ZTZHdeJf/Zl+tsYRcELLiPkRi4QR
	 1f+8RadgJXYRsmxuiGQaMtffW+6V1lPPuu69rjcGqEo7mn8dgTP1i7ZeuNakkvz3HOkDU
	 qda4SwoumaKL42hnY7ZsJaa4a8CAMSSIxOp5j9/ZWp9i20FgZyXmrFD7YorVVK+9mzvaV
	 pSdbqat85hI9ymWk6m0B2B/wrIcig2Amgv+IbfjUkqFqYRFtHnJvPkseSN4jpSs43Msod
	 4dv62oQQx2XDnqOHrx70NhvmBcvA2+95xxT9fg9yg2II2re/ZYwLCVVnwWnmZl3b3vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WsEK67X5;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B559606A31E;
	Tue, 24 Nov 2026 10:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B559606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WsEK67X5
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO350Qo1412736;
	Tue, 24 Nov 2026 10:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PJzRt0
	OTpbouwoPXydBA/ffZV91Hp1Y2LkN44LQaldg=; b=WsEK67X5bEBKpneq5obNnV
	CEuQmJ2JCBSNaIgQxEAoUies85yyVWy2oIfekTXXx+DU4I2RtegJBfWUc2qmZA2Q
	mDX+vp+ExudowkAlwlpW2cpTGDJNGpV8IyKr6OE2+cQgom5qJCPA9ehprxgopjIJ
	OGl/dd4unHJrz4gxaPM+qn+eY2mgnbDsf/y/1agYC920wlb54Y51fKeuKtEiGLzQ
	ElNPWS1TC0szuaHFLXXP7E+d8n+rZb+kfJBa03G0IXYJtnfOJGuALsXSvlVs17vp
	5sMowNKnxVxY5mTGEANu7J5Fm6bTnMSwbMLPGFYGUkhtNQCsKjmMUVNu8qvYj8Kw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fa798y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 10:36:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO8rKxj2086937;
	Tue, 24 Nov 2026 10:36:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3p0vjcc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 10:36:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AOAa2Hh46006748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 10:36:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FF112004B;
	Tue, 24 Nov 2026 10:36:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 447BE20040;
	Tue, 24 Nov 2026 10:35:57 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.123.12.120])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 24 Nov 2026 10:35:57 +0000 (GMT)
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
In-Reply-To: <20261116074414.3174737-4-irogers@google.com>
Date: Tue, 24 Nov 2026 16:05:45 +0530
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
Message-Id: <6F41ABBE-16A3-4B1F-96C0-D6369D5A5A55@linux.ibm.com>
References: <20261116074414.3174737-1-irogers@google.com>
 <20261116074414.3174737-4-irogers@google.com>
To: Ian Rogers <irogers@google.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0MSBTYWx0ZWRfX+MWE0Sk2hv/e
 2dLLxXRK73zr25oqECzsbC1ep0HS2vby7WAa4mS+YqGc2csB1g3C7iKnDwSoVDs/6ZItosD7NkZ
 3OoFFQTw9H9cYWW/cL4oxLzQQqNdNA3xmiDNevFCAiRYkoiham44w2jxXh+9tqLWhuhK0etuyzY
 uAxn0quLTCOqEv5wpoFAAsCJ5Obd8OcfTZ+MNEe5tQfXTM4pi3M6aQS5CEndjEHbDAAW8ziydXr
 QdxqYz2j2TBxlLQhjIdhuxF6CWyqHK0t6+E7X6MNKYcsPh4nTRmJytsESURYvl2gp1v/BqR09d/
 TGQwvwtsXrFIgrxFXGlFfnJJVE6VXhTCwaW2web7sONd4+IZwBZm6JNLi+kRejt7APKJCysBtt4
 p7EhywEDBTBHPXVbJ63vLXbw8N9s6yGIYQbFqcg5RZOzjKoPY4tyy/WgYKat7bfrdigClLKj3Wd
 n4v7O9+BktL5X71PkrQ==
X-Proofpoint-ORIG-GUID: f6ampGcU0crrZM8mAKgcUtk2aBgMQL2N
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b056896 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=-zkOnVWJseZWImJ0AtMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lGwW8VbaAWvV7-qsuF1OSoL3-aZOd0fw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0MSBTYWx0ZWRfX6AwC5SnyHJNM
 6GRrzezvL1gRQUThU8FXhXJ6DpUukPA1h1/jrOQzHh4e1cMglrc901nAR0FCMhXDtyk8hjMd27h
 CL1JwtL/yu3dXouOi2pYbCB00uDecWg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1011 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240041



> On 16 Nov 2026, at 1:13=E2=80=AFPM, Ian Rogers <irogers@google.com> =
wrote:
>=20
> Introduce PERF_SAMPLE_BUILD_ID_OFFSET and
> PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET in enum =
perf_event_sample_format.
>=20
> For PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET (and
> PERF_RECORD_CALLCHAIN_DEFERRED when PERF_RECORD_MISC_MMAP_BUILD_ID is
> set), encode a deduplicated table of variable-length build IDs
> (u32 nr_build_ids, u32 nr_offsets, followed by packed { u8 size;
> u8 data[size]; } entries padded to 8-byte alignment) and an array of
> 64-bit offsets whose top 8 bits encode the 1-based build ID index (or
> 0x00 for unresolved user addresses and 0xff for kernel/context =
entries).
> In common cases where multiple callchain frames belong to the same
> binary, each unique build ID is encoded only once.
>=20
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> include/uapi/linux/perf_event.h | 59 ++++++++++++++++++++++++++++++---
> 1 file changed, 54 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/uapi/linux/perf_event.h =
b/include/uapi/linux/perf_event.h
> index deb7c42d109b..775420ed9aee 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -165,8 +165,10 @@ enum perf_event_sample_format {
> PERF_SAMPLE_DATA_PAGE_SIZE =3D 1U << 22,
> PERF_SAMPLE_CODE_PAGE_SIZE =3D 1U << 23,
> PERF_SAMPLE_WEIGHT_STRUCT =3D 1U << 24,
> + PERF_SAMPLE_BUILD_ID_OFFSET =3D 1U << 25,
> + PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET =3D 1U << 26,
>=20
> - PERF_SAMPLE_MAX =3D 1U << 25, /* non-ABI */
> + PERF_SAMPLE_MAX =3D 1U << 27, /* non-ABI */
> };
>=20
> #define PERF_SAMPLE_WEIGHT_TYPE (PERF_SAMPLE_WEIGHT | =
PERF_SAMPLE_WEIGHT_STRUCT)
> @@ -840,7 +842,8 @@ struct perf_event_mmap_page {
>  *
>  *   PERF_RECORD_MISC_EXACT_IP           - PERF_RECORD_SAMPLE of =
precise events
>  *   PERF_RECORD_MISC_SWITCH_OUT_PREEMPT - PERF_RECORD_SWITCH* events
> - *   PERF_RECORD_MISC_MMAP_BUILD_ID      - PERF_RECORD_MMAP2 event
> + *   PERF_RECORD_MISC_MMAP_BUILD_ID      - PERF_RECORD_MMAP2 and
> + *                                         =
PERF_RECORD_CALLCHAIN_DEFERRED events
>  *
>  *
>  * PERF_RECORD_MISC_EXACT_IP:
> @@ -852,7 +855,7 @@ struct perf_event_mmap_page {
>  *   Indicates that thread was preempted in TASK_RUNNING state.
>  *
>  * PERF_RECORD_MISC_MMAP_BUILD_ID:
> - *   Indicates that mmap2 event carries build ID data.
> + *   Indicates that mmap2 or deferred callchain event carries build =
ID data.
>  */
> #define PERF_RECORD_MISC_EXACT_IP (1 << 14)
> #define PERF_RECORD_MISC_SWITCH_OUT_PREEMPT (1 << 14)
> @@ -1095,6 +1098,38 @@ enum perf_event_type {
> * { u64 code_page_size;} && PERF_SAMPLE_CODE_PAGE_SIZE
> * { u64 size;
> *  char data[size]; } && PERF_SAMPLE_AUX
> + * { union {
> + * struct {
> + * struct perf_build_id bid;
> + * u64 offset;
> + * };
> + * struct {
> + * u64 zero;
> + * u64 context;
> + * u64 cookie;
> + * u64 ip;
> + * }; && attr.defer_callchain
> + *  }; } && PERF_SAMPLE_BUILD_ID_OFFSET
> + * { u32 nr_build_ids;
> + *  u32 nr_offsets;
> + *  struct {
> + * u8 size;
> + * u8 data[size];
> + *  }[nr_build_ids];
> + *  u8 pad[];
> + *  u64 offsets[nr_offsets];
> + *  #
> + *  # Entries in offsets[] include PERF_CONTEXT_* markers (which
> + *  # have top 8 bits 0xff). Kernel/hypervisor entries (after
> + *  # PERF_CONTEXT_KERNEL, PERF_CONTEXT_HV, PERF_CONTEXT_GUEST,
> + *  # or PERF_CONTEXT_GUEST_KERNEL) and the cookie word following
> + *  # PERF_CONTEXT_USER_DEFERRED are raw 64-bit values. User
> + *  # entries (after PERF_CONTEXT_USER or PERF_CONTEXT_GUEST_USER,
> + *  # or in PERF_RECORD_CALLCHAIN_DEFERRED) use the top 8 bits to
> + *  # encode a 1-based index (1..254) into the build_ids table and
> + *  # the lower 56 bits for the DSO file offset, or 0x00 for an
> + *  # unresolved user virtual address.

Hi Ian,

On PERF_SAMPLE_BUILD_ID_OFFSET, the layout comment doesn't say what is
written in the non-resolved cases. For =
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET
it is clear: kernel entries are raw 64-bit values, unresolved user =
entries
have 0x00 in the top byte, and resolved user entries carry the table =
index
and the 56-bit file offset.

For the PERF_SAMPLE_BUILD_ID_OFFSET form, could the comment state:

 - What is written for a kernel IP? (e.g. bid.size =3D=3D 0 and offset =
=3D=3D raw IP?)
 - What is written for an unresolved user IP? If bid.size =3D=3D 0, does
   =E2=80=9Coffset=E2=80=9D hold the raw virtual address?

Thanks,
Athira

=20
> + * } && PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET
> * };
> */
> PERF_RECORD_SAMPLE =3D 9,
> @@ -1306,8 +1341,22 @@ enum perf_event_type {
> * struct {
> * struct perf_event_header header;
> * u64 cookie;
> - * u64 nr;
> - * u64 ips[nr];
> + * union {
> + * struct {
> + * u64 nr;
> + * u64 ips[nr];
> + * };
> + * struct {
> + * u32 nr_build_ids;
> + * u32 nr_offsets;
> + * struct {
> + * u8 size;
> + * u8 data[size];
> + * }[nr_build_ids];
> + * u8 pad[];
> + * u64 offsets[nr_offsets];
> + * }; && (header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)
> + * };
> * struct sample_id sample_id;
> * };
> */
> --=20
> 2.56.1.703.gf848ed807c-goog
>=20
>=20

