Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541641;
	b=ufrjd4GSQ9aROfGxNlX4XpfkZobNYdkZ5iva1wBLa0BGBSUq2TlvL/VR9DV0f2H2q9hd
	 J07mimpSvra4t3ElxIxD8Spko0vn/m674MhfDQXB0QX63O06D/T2J8PWjM9t4moZY82Jj
	 On0KzRukwsjIzKOsKHSZBXg6Zd4451PTRXSOLmsEiPSXVY8CkYMsPix8fkvD/tDisyHZD
	 r6SX0NSEXkMx+aI+hHthJf3jpedKpzlVdnFqouPREvHkPDHdsiSeCHhhwj8JBgtGXKZKk
	 KYpS2PjcInuZjljN5qOdNeE7cVbP9AQQw2YIFLARipsepnlxuuWyppOfUfoG3bP245Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541641;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Content-Type:Mime-Version:Subject:
	 From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=gVS83Cw0cmetADLmBHgNRpbME1TXvngOg6Hbzufdfdg=;
	b=nG28LGjCy3nAgfzUGWEvPftkJfScZGtbwEdIeXzVlr+xntc66P2uKXhiOGY0IcsVxWMs
	 AKLtIHoRgR6J9GCuSHfFM0ZMy4hqJ7WivfnHq5WVZhurw04YxpOWc35RH9nNCLtx0ckQC
	 8NuTVYJKLWduDR2bwNXtLeJlV+n5+7PBXXcsZs4Cfj1OO4FQIrD+ZZMGQJTEBix3yaj84
	 RKZJt0Iabdha9gY2LFqj63zbct/uMyvlLyas0bP9qUXm5DggaqW4p5OoWNfqyOcwYOh+S
	 XXZNPLQhubtYX8FTNhdsFc0gBl6FGRY4L3YKwwjKcPH8vMrNUsrnCzhXJiaUKEv1T5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QhcQN5js;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1554606A32D;
	Tue, 24 Nov 2026 17:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1554606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QhcQN5js
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOFYcHI2857985;
	Tue, 24 Nov 2026 17:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gVS83C
	w0cmetADLmBHgNRpbME1TXvngOg6Hbzufdfdg=; b=QhcQN5jsZGQQ4gHS83G6G6
	OLRU8Uvz+S1ffQPBHEC1YuXZvtOEkrWHqBDt+EbkFZAp7KB6Gl0FpzLR7QSEUcUY
	906p7HlUXhItVfUWjth7D6+iMfyrNwjQIBHKBsptLmA8fY4M60ojsVlePmwBGjGk
	4nZSO/+xKaPirJOp6Zm9PrC9eWL3u6rF3zWnS3S9FG51cONk+FiZEby5CVA08fbw
	70CN2A/UGKgAdBnCRCTdL08rC+exlw4F/7e4rYzNiTSLSe4RF7AiIGO1yK1PWMPV
	uvHZnbwMQ2tEAj1j/nZan188boNk1XV/mMVLIAk4hhRH1ebfLEVCwJgGG3j3Eihg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g18g50-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 17:33:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOFJIG82883453;
	Tue, 24 Nov 2026 17:32:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3p0vkkr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 17:32:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AOHWvrK50528516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 17:32:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D78020043;
	Tue, 24 Nov 2026 17:32:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1C7720040;
	Tue, 24 Nov 2026 17:32:48 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.208.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 24 Nov 2026 17:32:48 +0000 (GMT)
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
In-Reply-To: <20261116074414.3174737-6-irogers@google.com>
Date: Tue, 24 Nov 2026 23:02:35 +0530
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
Message-Id: <27B92301-D708-4527-9988-3B39973558AE@linux.ibm.com>
References: <20261116074414.3174737-1-irogers@google.com>
 <20261116074414.3174737-6-irogers@google.com>
To: Ian Rogers <irogers@google.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: KwDpNPKNuPwJJSgpIQC-rWBT2wtgFLy1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2NyBTYWx0ZWRfX5sU5iiVY9n17
 T7zNPNToF5pC8kc/PPpSa3r/sh/mmg5TqMF7U1ZFtKlipKK8lpXIWbauy7TUNxq+hRit+eXd1XF
 lsz4NfKA1+qindXf1DrvHnW4w+APVfY=
X-Proofpoint-GUID: zRgn2zQc_pjr7jom4jZ-YbdWI5poAPGh
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6b05ca4c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=-H3WsS6S_bzoD50MHKAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2NyBTYWx0ZWRfXwv9fGfmcIDWw
 BmlcJXu9jP116DJJn8MeInsGagEvG3kUZMCS7NULr69jp7Ejgbjs+4baveiJnXeZXqj+hlbxzWC
 e4GF2HapKiS2PMmpEQwDE25czytBgseNvc6NDxEpCQLdl3WGHUWNe9b4ldHNVHBUR0CCRIx1mhb
 uWq7g1H7JbMssVA5+nFAEIxZtMCa3KTyI9IPvrO/qIjYY8DoprpO+1upvGTY8iy5NUt9aIyshBF
 NsC4QStROQ8G1DgZmQ1dmOGmxIhgQzbuFOubHVnIUweUCOzrGaXuGtXESpY7s5nlNuO+PRkJUVa
 JI1rSgsn+WSjMbEw+D/URlNsGvub+2k3sWsfLUDwM5IMGo1UgkGgjRHga3lJecM4tV+jWeuGhwG
 F9S+Y1vqdzplN/kQM6fFyPHnSNXoP9wvsdA9CtH6WDMpCSTA0go2s8HQ13a6PkLuR53MLISxZWK
 j8adBiIC4eBtO/Mw1lQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240067



> On 16 Nov 2026, at 1:14=E2=80=AFPM, Ian Rogers <irogers@google.com> =
wrote:
>=20
> Implement synchronous PERF_SAMPLE_BUILD_ID_OFFSET and
> PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET payload writing in the perf =
event
> core using stack_map_get_build_id_offset(..., may_fault=3Dfalse).
>=20
> For callchains, extend the per-CPU callchain buffers in
> kernel/events/callchain.c to provide scratch space to deduplicate =
build
> IDs and encode the compressed build ID table and tagged 64-bit offsets
> (with the top 8 bits storing the 1-based build ID index).
>=20
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Ian Rogers <irogers@google.com>

Hi Ian

I have few queries and adding them below

> ---
> arch/powerpc/perf/core-book3s.c |  10 +-
> arch/s390/kernel/perf_cpum_sf.c |   7 +-
> include/linux/perf_event.h      |  43 ++++++-
> kernel/bpf/stackmap.c           |   6 +-
> kernel/events/callchain.c       | 206 +++++++++++++++++++++++++++++++-
> kernel/events/core.c            | 132 ++++++++++++++++++--
> 6 files changed, 385 insertions(+), 19 deletions(-)
>=20
> diff --git a/arch/powerpc/perf/core-book3s.c =
b/arch/powerpc/perf/core-book3s.c
> index 10ded865583c..bc51ab537851 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -2271,10 +2271,11 @@ static void record_and_restart(struct =
perf_event *event, unsigned long val,
>=20
> /*
> * If address is not requested in the sample via
> - * PERF_SAMPLE_IP, just record that sample irrespective
> - * of SIAR valid check.
> + * PERF_SAMPLE_IP or PERF_SAMPLE_BUILD_ID_OFFSET, just
> + * record that sample irrespective of SIAR valid check.
> */
> - if (event->attr.sample_type & PERF_SAMPLE_IP)
> + if (event->attr.sample_type &
> +    (PERF_SAMPLE_IP | PERF_SAMPLE_BUILD_ID_OFFSET))
> record =3D siar_valid(regs);
> else
> record =3D 1;
> @@ -2297,7 +2298,8 @@ static void record_and_restart(struct perf_event =
*event, unsigned long val,
> * these cases.
> */
> if (event->attr.exclude_kernel &&
> -    (event->attr.sample_type & PERF_SAMPLE_IP) &&
> +    (event->attr.sample_type &
> +     (PERF_SAMPLE_IP | PERF_SAMPLE_BUILD_ID_OFFSET)) &&
>    is_kernel_addr(mfspr(SPRN_SIAR)))
> record =3D 0;
>=20
> diff --git a/arch/s390/kernel/perf_cpum_sf.c =
b/arch/s390/kernel/perf_cpum_sf.c
> index 7bfeb5208177..30b0b6ba5b41 100644
> --- a/arch/s390/kernel/perf_cpum_sf.c
> +++ b/arch/s390/kernel/perf_cpum_sf.c
> @@ -840,8 +840,11 @@ static bool is_callchain_event(struct perf_event =
*event)
> {
> u64 sample_type =3D event->attr.sample_type;
>=20
> - return sample_type & (PERF_SAMPLE_CALLCHAIN | PERF_SAMPLE_REGS_USER =
|
> -      PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_STACK_USER);
> + return sample_type & (PERF_SAMPLE_CALLCHAIN |
> +      PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET |
> +      PERF_SAMPLE_BUILD_ID_OFFSET |
> +      PERF_SAMPLE_REGS_USER | PERF_SAMPLE_REGS_INTR |
> +      PERF_SAMPLE_STACK_USER);
> }
>=20
> static int cpumsf_pmu_event_init(struct perf_event *event)
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index e1e11500df09..9b5d9613a6f3 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -61,6 +61,31 @@ struct perf_callchain_entry {
> u64 ip[]; /* /proc/sys/kernel/perf_event_max_stack */
> };
>=20
> +#define PERF_CALLCHAIN_BUILD_ID_MAX_NRS 254
> +#define PERF_CALLCHAIN_BUILD_ID_MAX_SIZE 20
> +#define PERF_CALLCHAIN_BUILD_ID_TABLE_MAX_SIZE \
> + ALIGN(PERF_CALLCHAIN_BUILD_ID_MAX_NRS * (1 + =
PERF_CALLCHAIN_BUILD_ID_MAX_SIZE), sizeof(u64))
> +
> +struct perf_sample_build_id_offset {
> + u8 size;
> + u8 res1;
> + u16 res2;
> + u8 build_id[PERF_CALLCHAIN_BUILD_ID_MAX_SIZE];
> + u64 offset;
> +};
> +
> +struct perf_callchain_build_id_entry {
> + u32 build_ids_len;
> + bool has_ip_bid;
> + struct perf_sample_build_id_offset ip_bid;
> + struct {
> + u32 nr_build_ids;
> + u32 nr_offsets;
> + u8 build_ids[PERF_CALLCHAIN_BUILD_ID_TABLE_MAX_SIZE];
> + };
> + u64 offsets[]; /* /proc/sys/kernel/perf_event_max_stack */
> +};
> +
> struct perf_callchain_entry_ctx {
> struct perf_callchain_entry *entry;
> u32 max_stack;
> @@ -1347,6 +1372,7 @@ struct perf_sample_data {
> u64 data_page_size;
> u64 code_page_size;
> u64 aux_size;
> + struct perf_callchain_build_id_entry *callchain_build_id;
> } ____cacheline_aligned;
>=20
> /* default value for data source */
> @@ -1377,7 +1403,8 @@ static inline void =
perf_sample_save_callchain(struct perf_sample_data *data,
> {
> int size =3D 1;
>=20
> - if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
> + if (!(event->attr.sample_type &
> +      (PERF_SAMPLE_CALLCHAIN | =
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET)))
> return;
> if (WARN_ON_ONCE(data->sample_flags & PERF_SAMPLE_CALLCHAIN))
> return;
> @@ -1385,7 +1412,8 @@ static inline void =
perf_sample_save_callchain(struct perf_sample_data *data,
> data->callchain =3D perf_callchain(event, regs);
> size +=3D data->callchain->nr;
>=20
> - data->dyn_size +=3D size * sizeof(u64);
> + if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
> + data->dyn_size +=3D size * sizeof(u64);
> data->sample_flags |=3D PERF_SAMPLE_CALLCHAIN;
> }
>=20
> @@ -1747,6 +1775,17 @@ extern int get_callchain_buffers(int =
max_stack);
> extern void put_callchain_buffers(void);
> extern struct perf_callchain_entry *get_callchain_entry(int *rctx);
> extern void put_callchain_entry(int rctx);
> +struct bpf_stack_build_id;
> +extern struct perf_callchain_build_id_entry *
> +get_callchain_build_id_entry(int *rctx, struct bpf_stack_build_id =
**bpf_bids);
> +extern void perf_callchain_encode_build_ids(struct =
perf_callchain_build_id_entry *entry,
> +    const u64 *ips, u32 nr, u32 user_start,
> +    const struct bpf_stack_build_id *bpf_bids,
> +    u32 nr_bpf_bids, u32 max_size);
> +extern struct perf_callchain_build_id_entry *
> +perf_callchain_build_id(struct perf_event *event,
> + struct perf_callchain_entry *callchain,
> + u64 ip, bool resolve_ip, u32 max_size);
>=20
> extern int sysctl_perf_event_max_stack;
> extern int sysctl_perf_event_max_contexts_per_stack;
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 11f6349b2b8d..1f4a0c425af6 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -691,7 +691,8 @@ BPF_CALL_3(bpf_get_stackid_pe, struct =
bpf_perf_event_data_kern *, ctx,
> int ret;
>=20
> /* perf_sample_data doesn't have callchain, use bpf_get_stackid */
> - if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
> + if (!(event->attr.sample_type &
> +      (PERF_SAMPLE_CALLCHAIN | =
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET)))

We are using "(PERF_SAMPLE_CALLCHAIN | =
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET)=E2=80=9D at many places,

Could we add a shared definition, e.g. a PERF_SAMPLE_ANY_CALLCHAIN mask
(or an event_has_callchain() helper), so a new user can't miss one
of the two bits? The places that really mean only PERF_SAMPLE_CALLCHAIN
(raw ips output, dyn_size accounting) would stay as they are.

> return bpf_get_stackid((unsigned long)(ctx->regs),
>       (unsigned long) map, flags, 0, 0);
>=20
> @@ -982,7 +983,8 @@ BPF_CALL_4(bpf_get_stack_pe, struct =
bpf_perf_event_data_kern *, ctx,
> int err =3D -EINVAL;
> __u64 nr_kernel;
>=20
> - if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
> + if (!(event->attr.sample_type &
> +      (PERF_SAMPLE_CALLCHAIN | =
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET)))
> return __bpf_get_stack(regs, NULL, buf, size, flags, false /* =
!may_fault */);
>=20
> if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> index 9d24b6e0c91f..935b34d2dd33 100644
> --- a/kernel/events/callchain.c
> +++ b/kernel/events/callchain.c
> @@ -9,6 +9,7 @@
>  */
>=20
> #include <linux/perf_event.h>
> +#include <linux/bpf.h>
> #include <linux/slab.h>
> #include <linux/sched/task_stack.h>
> #include <linux/uprobes.h>
> @@ -31,6 +32,26 @@ static inline size_t =
perf_callchain_entry__sizeof(void)
> sysctl_perf_event_max_contexts_per_stack));
> }
>=20
> +static inline size_t perf_callchain_build_id_entry__sizeof(void)
> +{
> + return (sizeof(struct perf_callchain_build_id_entry) +
> + sizeof(__u64) * (sysctl_perf_event_max_stack +
> + sysctl_perf_event_max_contexts_per_stack));
> +}
> +
> +static inline size_t perf_callchain_bpf_build_id__sizeof(void)
> +{
> + return sizeof(struct bpf_stack_build_id) *
> +       (sysctl_perf_event_max_stack + 1);
> +}
> +
> +static inline size_t perf_callchain_context__sizeof(void)
> +{
> + return perf_callchain_entry__sizeof() +
> +       perf_callchain_build_id_entry__sizeof() +
> +       perf_callchain_bpf_build_id__sizeof();
> +}
> +
> static DEFINE_PER_CPU(u8, callchain_recursion[PERF_NR_CONTEXTS]);
> static atomic_t nr_callchain_events;
> static DEFINE_MUTEX(callchain_mutex);
> @@ -86,7 +107,7 @@ static int alloc_callchain_buffers(void)
> if (!entries)
> return -ENOMEM;
>=20
> - size =3D perf_callchain_entry__sizeof() * PERF_NR_CONTEXTS;
> + size =3D perf_callchain_context__sizeof() * PERF_NR_CONTEXTS;


 in alloc_callchain_buffers(), we are changing size unconditionally to :

size =3D perf_callchain_context__sizeof() * PERF_NR_CONTEXTS;

Even if PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET is not set,=20
still the size grows for every case.

This grows each per-CPU, per-context slot by the build ID table and the
bpf_stack_build_id scratch area, and it is not conditional on the new
sample types. get_callchain_buffers() is called for plain
PERF_SAMPLE_CALLCHAIN too, so as I read it, a plain "perf record -g"
(or any BPF tool using callchains) would also pay the extra memory on
every possible CPU, without --buildid-offset.

Is that the intent? If not, could the extra scratch space be allocated
only when an event with PERF_SAMPLE_BUILD_ID_OFFSET or
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET exists? It would also be good to
state the per-CPU memory cost in the commit message.


>=20
> for_each_possible_cpu(cpu) {
> entries->cpu_entries[cpu] =3D kmalloc_node(size, GFP_KERNEL,
> @@ -169,7 +190,22 @@ struct perf_callchain_entry =
*get_callchain_entry(int *rctx)
> cpu =3D smp_processor_id();
>=20
> return (((void *)entries->cpu_entries[cpu]) +
> - (*rctx * perf_callchain_entry__sizeof()));
> + (*rctx * perf_callchain_context__sizeof()));
> +}
> +
> +struct perf_callchain_build_id_entry *
> +get_callchain_build_id_entry(int *rctx, struct bpf_stack_build_id =
**bpf_bids)
> +{
> + void *base =3D get_callchain_entry(rctx);
> +
> + if (!base)
> + return NULL;
> +
> + base +=3D perf_callchain_entry__sizeof();
> + if (bpf_bids)
> + *bpf_bids =3D base + perf_callchain_build_id_entry__sizeof();
> +
> + return base;
> }
>=20
> void
> @@ -178,6 +214,172 @@ put_callchain_entry(int rctx)
> put_recursion_context(this_cpu_ptr(callchain_recursion), rctx);
> }
>=20
> +void perf_callchain_encode_build_ids(struct =
perf_callchain_build_id_entry *entry,
> +     const u64 *ips, u32 nr, u32 user_start,
> +     const struct bpf_stack_build_id *bpf_bids,
> +     u32 nr_bpf_bids, u32 max_size)
> +{
> + u32 nr_build_ids =3D 0, nr_offsets =3D 0;
> + u32 raw_bids_len =3D 0, aligned_bids_len =3D 0;
> +
> + static_assert(BUILD_ID_SIZE_MAX =3D=3D =
PERF_CALLCHAIN_BUILD_ID_MAX_SIZE);
> +
> + for (u32 i =3D 0; i < nr; i++) {
> + u64 ip =3D ips[i];
> + u64 encoded_offset;
> + const struct bpf_stack_build_id *bpf_bid =3D NULL;
> +
> + if (i >=3D user_start && i - user_start < nr_bpf_bids)
> + bpf_bid =3D &bpf_bids[i - user_start];
> +
> + if (bpf_bid && bpf_bid->status =3D=3D BPF_STACK_BUILD_ID_VALID) {
> + u32 pos =3D 0, found_idx =3D 0;
> +
> + for (u32 b =3D 0; b < nr_build_ids; b++) {
> + u8 sz =3D entry->build_ids[pos];
> +
> + if (sz =3D=3D BUILD_ID_SIZE_MAX &&
> +    !memcmp(&entry->build_ids[pos + 1],
> +    bpf_bid->build_id,
> +    BUILD_ID_SIZE_MAX)) {
> + found_idx =3D b + 1;
> + break;
> + }
> + pos +=3D 1 + sz;
> + }
> +
> + if (!found_idx &&
> +    nr_build_ids < PERF_CALLCHAIN_BUILD_ID_MAX_NRS) {
> + u32 next_raw_len =3D raw_bids_len + 1 + BUILD_ID_SIZE_MAX;
> + u32 next_aligned_len =3D ALIGN(next_raw_len, sizeof(u64));
> +
> + if (next_aligned_len + (i + 1) * sizeof(u64) > max_size)
> + break;
> + entry->build_ids[raw_bids_len] =3D BUILD_ID_SIZE_MAX;
> + memcpy(&entry->build_ids[raw_bids_len + 1],
> +       bpf_bid->build_id, BUILD_ID_SIZE_MAX);
> + nr_build_ids++;
> + raw_bids_len =3D next_raw_len;
> + aligned_bids_len =3D next_aligned_len;
> + found_idx =3D nr_build_ids;
> + }
> +
> + if (aligned_bids_len + (i + 1) * sizeof(u64) > max_size)
> + break;
> +
> + if (found_idx) {
> + encoded_offset =3D ((u64)found_idx << 56) |
> + (bpf_bid->offset & GENMASK_ULL(55, 0));
> + } else {
> + encoded_offset =3D ip & GENMASK_ULL(55, 0);
> + }
> + } else {
> + if (aligned_bids_len + (i + 1) * sizeof(u64) > max_size)
> + break;
> + if (i >=3D user_start && ip < PERF_CONTEXT_MAX)
> + encoded_offset =3D ip & GENMASK_ULL(55, 0);
> + else
> + encoded_offset =3D ip;
> + }
> +
> + entry->offsets[i] =3D encoded_offset;
> + nr_offsets =3D i + 1;
> + }
> +
> + if (nr_offsets > 0 && nr_offsets <=3D user_start &&
> +    entry->offsets[nr_offsets - 1] =3D=3D PERF_CONTEXT_USER_DEFERRED =
&&
> +    (nr_offsets < 2 ||
> +     entry->offsets[nr_offsets - 2] !=3D PERF_CONTEXT_USER_DEFERRED))
> + nr_offsets--;
> +
> + if (aligned_bids_len > raw_bids_len) {
> + memset(&entry->build_ids[raw_bids_len], 0,
> +       aligned_bids_len - raw_bids_len);
> + }
> + entry->nr_build_ids =3D nr_build_ids;
> + entry->nr_offsets =3D nr_offsets;
> + entry->build_ids_len =3D aligned_bids_len;
> +}
> +
> +static struct perf_callchain_build_id_entry =
__empty_callchain_build_id =3D {};
> +
> +struct perf_callchain_build_id_entry *
> +perf_callchain_build_id(struct perf_event *event,
> + struct perf_callchain_entry *callchain,
> + u64 ip, bool resolve_ip, u32 max_size)
> +{
> + bool crosstask =3D event->ctx->task && event->ctx->task !=3D =
current;
> + bool has_user_ctx =3D is_user_task(current) && current->mm && =
!crosstask;
> + struct perf_callchain_build_id_entry *entry;
> + struct bpf_stack_build_id *bpf_bids;
> + u32 nr, user_start, nr_bpf_bids =3D 0, ip_slot =3D 0;
> + int rctx;
> +
> + if (!callchain || !callchain->nr || max_size < sizeof(u64))
> + return &__empty_callchain_build_id;
> +
> + entry =3D get_callchain_build_id_entry(&rctx, &bpf_bids);
> + if (!entry)
> + return &__empty_callchain_build_id;
> +
> + entry->has_ip_bid =3D false;
> + nr =3D min_t(u64, callchain->nr,
> +   sysctl_perf_event_max_stack +
> +   sysctl_perf_event_max_contexts_per_stack);
> + user_start =3D nr;
> + if (has_user_ctx) {
> + for (u32 i =3D 0; i < nr; i++) {
> + if (callchain->ip[i] =3D=3D PERF_CONTEXT_USER) {
> + user_start =3D i + 1;
> + break;
> + }
> + }
> + if (user_start < nr) {
> + nr_bpf_bids =3D min_t(u32, nr - user_start,
> +    sysctl_perf_event_max_stack);
> + nr_bpf_bids =3D min_t(u32, nr_bpf_bids,
> +    max_size / sizeof(u64));
> + }
> + if (nr_bpf_bids > 0) {
> + if (resolve_ip) {
> + bpf_bids[0].ip =3D ip;
> + ip_slot =3D 1;
> + }
> + for (u32 i =3D 0; i < nr_bpf_bids; i++) {
> + bpf_bids[ip_slot + i].ip =3D
> + callchain->ip[user_start + i];
> + }
> + stack_map_get_build_id_offset(bpf_bids,
> +      ip_slot + nr_bpf_bids,
> +      true, false);
> + if (resolve_ip) {
> + memset(&entry->ip_bid, 0,
> +       sizeof(entry->ip_bid));
> + if (bpf_bids[0].status =3D=3D
> +    BPF_STACK_BUILD_ID_VALID) {
> + entry->ip_bid.size =3D
> + BUILD_ID_SIZE_MAX;
> + memcpy(entry->ip_bid.build_id,
> +       bpf_bids[0].build_id,
> +       BUILD_ID_SIZE_MAX);
> + entry->ip_bid.offset =3D
> + bpf_bids[0].offset;
> + } else {
> + entry->ip_bid.offset =3D ip;
> + }
> + entry->has_ip_bid =3D true;
> + }
> + }
> + }
> +
> + perf_callchain_encode_build_ids(entry, callchain->ip, nr, =
user_start,
> + bpf_bids + ip_slot, nr_bpf_bids,
> + max_size);
> + put_callchain_entry(rctx);
> +
> + return entry;
> +}
> +
> static void fixup_uretprobe_trampoline_entries(struct =
perf_callchain_entry *entry,
>       int start_entry_idx)
> {
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index fd9f654de269..d38ffe52c301 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2096,6 +2096,9 @@ static void __perf_event_header_size(struct =
perf_event *event, u64 sample_type)
> if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
> size +=3D sizeof(data->code_page_size);
>=20
> + if (sample_type & PERF_SAMPLE_BUILD_ID_OFFSET)
> + size +=3D sizeof(struct perf_sample_build_id_offset);
> +
> event->header_size =3D size;
> }
>=20
> @@ -8396,6 +8399,78 @@ static void perf_output_read(struct =
perf_output_handle *handle,
> perf_output_read_one(handle, event, enabled, running);
> }
>=20
> +static void perf_bpf_to_sample_bid_offset(struct bpf_stack_build_id =
*bpf_bid)
> +{
> + struct perf_sample_build_id_offset *bid =3D (void *)bpf_bid;
> + u8 size =3D 0;
> +
> + static_assert(sizeof(*bid) =3D=3D sizeof(*bpf_bid));
> + static_assert(offsetof(struct perf_sample_build_id_offset, build_id) =
=3D=3D
> +      offsetof(struct bpf_stack_build_id, build_id));
> + static_assert(offsetof(struct perf_sample_build_id_offset, offset) =
=3D=3D
> +      offsetof(struct bpf_stack_build_id, offset));
> +
> + if (bpf_bid->status =3D=3D BPF_STACK_BUILD_ID_VALID)
> + size =3D BUILD_ID_SIZE_MAX;

perf_bpf_to_sample_bid_offset() and perf_callchain_encode_build_ids() =
only ever=20
write size =3D BUILD_ID_SIZE_MAX for a resolved build ID, and size =3D 0 =
for the unresolved case.
As far as I can see the table in PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET,
therefore always contains BUILD_ID_SIZE_MAX-byte entries, although patch =
03 documents it
as variable-length {u8 size; u8 data[size]}.

Is there a case where size can be anything other than 0 or 20? If not,
could the UAPI comment in patch 03 say so?

Thanks
Athira

> + else
> + memset(bid->build_id, 0, sizeof(bid->build_id));
> +
> + bid->size =3D size;
> + bid->res1 =3D 0;
> + bid->res2 =3D 0;
> +}
> +
> +static void perf_output_sample_build_id(struct perf_output_handle =
*handle,
> + struct perf_event_header *header,
> + struct perf_sample_data *data,
> + struct perf_event *event)
> +{
> + u64 sample_type =3D data->type;
> + bool sample_bid =3D sample_type & PERF_SAMPLE_BUILD_ID_OFFSET;
> + bool callchain_bid =3D sample_type & =
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET;
> + bool crosstask =3D event->ctx->task && event->ctx->task !=3D =
current;
> + bool has_user_ctx =3D is_user_task(current) && current->mm && =
!crosstask;
> + bool is_user =3D (header->misc & PERF_RECORD_MISC_CPUMODE_MASK) =3D=3D=

> +       PERF_RECORD_MISC_USER;
> +
> + if (sample_bid) {
> + if (is_user && has_user_ctx) {
> + if (callchain_bid && data->callchain_build_id &&
> +    data->callchain_build_id->has_ip_bid) {
> + perf_output_put(handle,
> + data->callchain_build_id->ip_bid);
> + } else {
> + struct bpf_stack_build_id bpf_bid =3D {
> + .ip =3D data->ip,
> + };
> +
> + stack_map_get_build_id_offset(&bpf_bid, 1, true,
> +      false);
> + perf_bpf_to_sample_bid_offset(&bpf_bid);
> + perf_output_put(handle, bpf_bid);
> + }
> + } else {
> + struct perf_sample_build_id_offset bid_offset =3D {
> + .offset =3D data->ip,
> + };
> +
> + perf_output_put(handle, bid_offset);
> + }
> + }
> +
> + if (callchain_bid) {
> + struct perf_callchain_build_id_entry *entry =3D
> + data->callchain_build_id;
> +
> + __output_copy(handle, &entry->nr_build_ids,
> +      sizeof(u64) + entry->build_ids_len);
> + if (entry->nr_offsets) {
> + __output_copy(handle, entry->offsets,
> +      entry->nr_offsets * sizeof(u64));
> + }
> + }
> +}
> +
> void perf_output_sample(struct perf_output_handle *handle,
> struct perf_event_header *header,
> struct perf_sample_data *data,
> @@ -8589,6 +8664,10 @@ void perf_output_sample(struct =
perf_output_handle *handle,
> perf_aux_sample_output(event, handle, data);
> }
>=20
> + if (sample_type &
> +    (PERF_SAMPLE_BUILD_ID_OFFSET | =
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET))
> + perf_output_sample_build_id(handle, header, data, event);
> +
> if (!event->attr.watermark) {
> int wakeup_events =3D event->attr.wakeup_events;
>=20
> @@ -8804,7 +8883,9 @@ void perf_prepare_sample(struct perf_sample_data =
*data,
> * sample flags that have already been done by the PMU driver.
> */
> filtered_sample_type =3D sample_type;
> - filtered_sample_type |=3D __cond_set(sample_type, =
PERF_SAMPLE_CODE_PAGE_SIZE,
> + filtered_sample_type |=3D __cond_set(sample_type,
> +   PERF_SAMPLE_CODE_PAGE_SIZE |
> +   PERF_SAMPLE_BUILD_ID_OFFSET,
>   PERF_SAMPLE_IP);
> filtered_sample_type |=3D __cond_set(sample_type, =
PERF_SAMPLE_DATA_PAGE_SIZE |
>   PERF_SAMPLE_PHYS_ADDR, PERF_SAMPLE_ADDR);
> @@ -8825,8 +8906,14 @@ void perf_prepare_sample(struct =
perf_sample_data *data,
> data->sample_flags |=3D PERF_SAMPLE_IP;
> }
>=20
> - if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN)
> - perf_sample_save_callchain(data, event, regs);
> + if (filtered_sample_type &
> +    (PERF_SAMPLE_CALLCHAIN | PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET)) =
{
> + if (!(data->sample_flags & PERF_SAMPLE_CALLCHAIN))
> + perf_sample_save_callchain(data, event, regs);
> + if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET)
> + data->dyn_size +=3D sizeof(u64);
> + }
> +
>=20
> if (filtered_sample_type & PERF_SAMPLE_RAW) {
> data->raw =3D NULL;
> @@ -8986,6 +9073,24 @@ void perf_prepare_sample(struct =
perf_sample_data *data,
> data->dyn_size +=3D size + sizeof(u64); /* size above */
> data->sample_flags |=3D PERF_SAMPLE_AUX;
> }
> +
> + if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET) {
> + u32 header_size =3D perf_sample_data_size(data, event);
> + u32 max_size =3D 0;
> + struct perf_callchain_build_id_entry *entry;
> +
> + if (header_size < U16_MAX)
> + max_size =3D round_down(U16_MAX - header_size, sizeof(u64));
> +
> + entry =3D perf_callchain_build_id(event, data->callchain,
> + data->ip,
> + !!(sample_type & PERF_SAMPLE_BUILD_ID_OFFSET),
> + max_size);
> + data->callchain_build_id =3D entry;
> + data->dyn_size +=3D entry->build_ids_len +
> +  entry->nr_offsets * sizeof(u64);
> + data->sample_flags |=3D PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET;
> + }
> }
>=20
> void perf_prepare_header(struct perf_event_header *header,
> @@ -10822,7 +10927,8 @@ static int bpf_overflow_handler(struct =
perf_event *event,
> int callchain_rctx;
>=20
> perf_prepare_sample(data, event, regs);
> - if (data->sample_flags & PERF_SAMPLE_CALLCHAIN)
> + if (data->sample_flags &
> +    (PERF_SAMPLE_CALLCHAIN | PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET))
> callchain =3D get_callchain_entry(&callchain_rctx);
> ret =3D bpf_prog_run(prog, &ctx);
> if (callchain)
> @@ -10851,7 +10957,8 @@ static inline int =
perf_event_set_bpf_handler(struct perf_event *event,
>=20
> if (event->attr.precise_ip &&
>    prog->call_get_stack &&
> -    (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) ||
> +    (!(event->attr.sample_type &
> +       (PERF_SAMPLE_CALLCHAIN | =
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET)) ||
>     event->attr.exclude_callchain_kernel ||
>     event->attr.exclude_callchain_user)) {
> /*
> @@ -13713,7 +13820,8 @@ perf_event_alloc(struct perf_event_attr *attr, =
int cpu,
> }
>=20
> if (!event->parent) {
> - if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) {
> + if (event->attr.sample_type &
> +    (PERF_SAMPLE_CALLCHAIN | PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET)) =
{
> err =3D get_callchain_buffers(attr->sample_max_stack);
> if (err)
> return ERR_PTR(err);
> @@ -13868,6 +13976,15 @@ static int perf_copy_attr(struct =
perf_event_attr __user *uattr,
> if (attr->sample_type & PERF_SAMPLE_CGROUP)
> return -EINVAL;
> #endif
> +#ifndef CONFIG_BPF_SYSCALL
> + if (attr->sample_type &
> +    (PERF_SAMPLE_BUILD_ID_OFFSET | =
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET))
> + return -EINVAL;
> +#endif
> + if (attr->defer_callchain &&
> +    (attr->sample_type & PERF_SAMPLE_CALLCHAIN) &&
> +    (attr->sample_type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET))
> + return -EINVAL;
> if ((attr->sample_type & PERF_SAMPLE_WEIGHT) &&
>    (attr->sample_type & PERF_SAMPLE_WEIGHT_STRUCT))
> return -EINVAL;
> @@ -14096,7 +14213,8 @@ SYSCALL_DEFINE5(perf_event_open,
> return err;
>=20
> if (!attr.exclude_kernel || attr.text_poke ||
> -    ((attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
> +    ((attr.sample_type &
> +      (PERF_SAMPLE_CALLCHAIN | =
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET)) &&
>     !attr.exclude_callchain_kernel)) {
> err =3D perf_allow_kernel();
> if (err)
> --=20
> 2.56.1.703.gf848ed807c-goog
>=20
>=20

