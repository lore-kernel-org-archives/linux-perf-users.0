Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D470C4908AF;
	Sun, 26 Jul 2026 08:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785053908; cv=none; b=uOCSZe11JqfxjbUawn5Cce9PZbIVo/5Bt56zUa5bV257uBbSOjou6LeqW0tcH1UycumIO7yKSQqVXmtT8Bu/uFbiTer9gQKU7y4NzFBGF1UpJjF9iNyWQG+b3WgKIbSw+xTgyAyt0TI0h7v+ZeY7CsFBGGubNTyVZkLSAH0/574=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785053908; c=relaxed/simple;
	bh=P2KM75fmdaA6Icz22JtONlMd9F1LTHWDJGHBWXNNUd8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=sEUqYQkYP/GvDA1JrK+YFKMifBcSDVuQZnnIpptXybDvVBu166uecA01j44c960g0KZJuVE7FgjiNHwje5VcpzDqiH13vcpoPupe+RFUbS5h+jiKwbLs3DSSwIr2+RXxsFxhMuet6HwXz0e9QnBDWVmeZbw4Qgovk0xd2Yjyq1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gc2wP/8Y; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gc2wP/8Y"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66Q8I1Sh2885414;
	Sun, 26 Jul 2026 08:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=c11+Ij
	sV8VvVltD9hU+HC7pLQ8w47DPYvQ51kTd5oTk=; b=Gc2wP/8YtBCuA12sPZA+wy
	ki2a39zvNenkvuex4m9yfTJSrW99DYYXE+1BVcs1YCFcfJ2Yq9dIJeA9xZ+GLzeS
	9iUdwnWegCL31S0uC+jW4ztP5oislVegSyL/TCIv935P9b85nYOPFtf4fmbYUgQS
	y3YaRyQfXnKwpCl1ZcHAo4f3VHjUKlx4yUUwULaSpaAIqbl3wV4OXsqpK6OVywxE
	Uu1UQ28kojf+or/bu4ECE4BSrPiMRLprP/0RzujpyRTGTyU+DYDymWNv8mvfWfjg
	PzxNEK0aJv3SlaRleg7VanSMNNpeANuu1yeQY9aPkODOxZXE5facFqLwcgv7Q4kQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0natf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 08:18:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66Q8BH8Y030770;
	Sun, 26 Jul 2026 08:18:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yh0vm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 08:18:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66Q8IMsb44237286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jul 2026 08:18:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8AA32009A;
	Sun, 26 Jul 2026 08:18:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7AAD20099;
	Sun, 26 Jul 2026 08:18:21 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.223.95])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 26 Jul 2026 08:18:21 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH V3 4/6] powerpc/perf: Capture the HTM memory configuration
 as part of perf data
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260725074300.D145E1F000E9@smtp.kernel.org>
Date: Sun, 26 Jul 2026 13:48:09 +0530
Cc: linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DA364026-B783-4EDA-BF6B-A3C965FCD803@linux.ibm.com>
References: <20260725065942.78839-1-atrajeev@linux.ibm.com>
 <20260725065942.78839-5-atrajeev@linux.ibm.com>
 <20260725074300.D145E1F000E9@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDA4MSBTYWx0ZWRfXx2iqDO9YYUH/
 QBpPYVJ4YvmJfGd7lgFkSp8/hDOaOq0qUtFo6JMQuuevUvC0LYFk5uJh0RTnuB1t8edYZkshsPv
 LRREl/tGphwbTlqtOhhTlRYJFHK0MJI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDA4MSBTYWx0ZWRfX8KOcnZNhf5jM
 nPdGcvfCRhd+QPrYyhjlC59iYW1048SKSii8xW2/dx35Jf7gJG93rlYWOWcz71BTfPqRaOre/7h
 rGZrNgROr7vSgETeH3tPVH6rJuoWWzTdTqS4j/DfW19dB+sg9c7md58CqxOdYj7npuOvogcQIg8
 wvs2RYlTE6VuDgtQx0oq7Gbb5bG6OxlHlCfimUq8LOyy+ck4hgacDb54GktocCAHNeA9T76yDrP
 YSaOz5i7/HoXaCGGXVJ6lFEFSnf0gD8p2tnIl09JdII8Dv0eR+WLLFD8YkG4M75JrBpcQI9z3Kv
 82ulexNb6p/k4D9V9THRjqYe175WI85nhElP2FBdCmrANQTFwMdVOMJhNJFsih1M5EOI0OvSny3
 4mah8KR+E0JbWpCq70tbZrAP7x8tKZGvm3pgFUvP13Hkj742UcSEnhrYBZojx2AmHDdt2V6L5sQ
 tezprUP741REUbsFkNA==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a65c2d1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=r-DKvi7gUoOK4YmwqHgA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: yprJuinx0Jr-vr6s1ol9kzGh0Schi58P
X-Proofpoint-ORIG-GUID: yprJuinx0Jr-vr6s1ol9kzGh0Schi58P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260081



> On 25 Jul 2026, at 1:13=E2=80=AFPM, sashiko-bot@kernel.org wrote:
>=20
> Thank you for your contribution! Sashiko AI review found 5 potential =
issue(s) to consider:
> - [High] HTM_MEM_BUF_SIZE (65440 bytes) leaves insufficient headroom =
for dynamic perf sample fields, causing perf_event_header.size to =
overflow its u16 limit and corrupt the ring buffer.
> - [High] Uninitialized kernel stack memory in struct pt_regs is leaked =
to userspace when the event is configured with PERF_SAMPLE_REGS_INTR.
> - [High] Misinterpretation of perf_event_overflow() return value =
causes silent data loss when the ring buffer is full, and data =
duplication when the event is throttled.
> - [High] htm_mem_buf is allocated with kmalloc_node instead of =
kzalloc_node, potentially leaking uninitialized kernel heap memory to =
userspace.
> - [Medium] htm_collect_memory_config fails to accumulate the emitted =
entry counts across its loop iterations, resulting in metric =
under-reporting.
> --
>=20
> --- Patch [4]: [PATCH V3 4/6] powerpc/perf: Capture the HTM memory =
configuration as part of perf data ---
> commit ace2c86ce33c6759f7015fdf1bd6da0f6b6ecba3
> Author: Athira Rajeev <atrajeev@linux.ibm.com>
> Subject: powerpc/perf: Capture the HTM memory configuration as part of =
perf data
>=20
> This commit captures HTM system memory configuration records by =
dumping them
> into the AUX buffer and emitting them as raw perf samples. It =
introduces
> buffers for the hypervisor dump, handles layout sizing, and iterates =
through
> memory config batches using H_HTM_OP_DUMP_SYSMEM_CONF.
>=20
>> diff --git a/arch/powerpc/perf/htm-perf.c =
b/arch/powerpc/perf/htm-perf.c
>> index f880a5fc88330..af9a8412ff20f 100644
>> --- a/arch/powerpc/perf/htm-perf.c
>> +++ b/arch/powerpc/perf/htm-perf.c
>=20
> [ ... ]
>=20
>> +/*
>> + * HTM_MEM_BUF_SIZE is the allocation size for the hcall staging =
buffer.
> [ ... ]
>> + * 65440 =3D 32 + 2043 * 32 is the largest multiple of 32 satisfying =
all
>> + * three constraints:
>> + *   - covers 64480 with 960 bytes headroom
>> + *   - total record: 65440 + 92 =3D 65532 < 65535 (3-byte u16 =
margin)
>> + *
>> + * HTM_MEM_MAX_ENTRIES is derived from HTM_MEM_BUF_SIZE =E2=80=94 =
not the other
>> + * way around =E2=80=94 so the hcall is always given the true buffer =
size and
>> + * the WARN_ON_ONCE(to_copy > HTM_MEM_BUF_SIZE) guard is a genuine
>> + * impossibility check rather than a post-overflow assertion.
>> + */
>> +#define HTM_MEM_BUF_SIZE 65440U
>=20
> [Severity: High]
> Could the buffer size calculation cause an overflow if dynamic sample
> attributes are used?
>=20
> The commit message states the fixed overhead is 92 bytes, which leaves
> (65535 - 92 =3D 65443) bytes for the payload. However, if the event is
> configured with PERF_SAMPLE_REGS_INTR, the size of struct pt_regs =
(which is
> over 300 bytes on PowerPC) is added to the sample size.
>=20
> Does this cause perf_sample_data_size() to return a value greater than =
65535,
> which would wrap around when assigned to the __u16 header.size in
> perf_prepare_header(), potentially leading to ring buffer corruption?

HTM doesn=E2=80=99t support PERF_SAMPLE_REGS_INTR
I will add a check in even_init to handle this and hence we will be good =
here
>=20
>> +#define HTM_MEM_MAX_ENTRIES ((HTM_MEM_BUF_SIZE - 32) / 32) /* 2043 =
*/
>=20
> [ ... ]
>=20
>> +static ssize_t htm_collect_memory_config(struct perf_event *event,
>> + struct htm_pmu_buf *aux_buf)
>> +{
>> + struct perf_sample_data data;
>> + struct perf_raw_record raw;
>> + struct pt_regs regs;
>=20
> [Severity: High]
> Is it possible for this uninitialized stack variable to leak kernel =
memory?
>=20
> The regs structure is partially initialized by =
perf_fetch_caller_regs(),
> which on PowerPC only sets nip, gpr[1], result, and msr:
>=20
> perf_arch_fetch_caller_regs(regs, CALLER_ADDR0) {
>    ...
> }
>=20
> If the event uses PERF_SAMPLE_REGS_INTR, will perf_output_sample() =
write the
> uninitialized portions of this pt_regs structure into the perf ring =
buffer,
> exposing stale kernel stack contents to userspace? Should this be =
initialized
> with an empty initialization?

HTM doesn=E2=80=99t support PERF_SAMPLE_REGS_INTR
I will add a check in even_init to handle this and hence we are good =
with perf_arch_fetch_caller_regs
>=20
>=20
>> + u8 *htm_mem_buf =3D aux_buf->htm_mem_buf;
>> + __be64 *num_entries;
>=20
> [ ... ]
>=20
>> + perf_sample_data_init(&data, 0, event->hw.last_period);
>> + memset(&raw, 0, sizeof(raw));
>> + raw.frag.data =3D emit_buf;
>> + raw.frag.size =3D to_copy;
>> + perf_sample_save_raw_data(&data, event, &raw);
>> +
>> + if (perf_event_overflow(event, &data, &regs)) {
>=20
> [Severity: High]
> Does this logic misinterpret the return value of =
perf_event_overflow()?
>=20
> Looking at __perf_event_overflow(), it returns non-zero (1) only when =
an
> event is throttled. If it returns 1, the current sample was already
> successfully written before the throttle triggered. However, the =
driver
> assumes failure here, skips advancing mem_start, and emits the exact =
same
> block again on the next pass.
>=20
> Conversely, if the ring buffer fills up, the core drops the sample but
> __perf_event_overflow() still returns 0. When it returns 0, the driver
> assumes success, advances mem_start, and silently loses configuration =
data.
>=20
> Is this behavior intended, or should it be adjusted to avoid silent =
data
> loss and duplication?
Will change this approach in V4.
 =20
>=20
>> + /*
>> + * Event throttled: the record was not written to the
>> + * ring buffer.  Do NOT advance mem_start =E2=80=94 the same
>> + * block will be retried on the next htm_event_read()
>> + * call once the event is unthrottled.  Leave
>> + * collect_htm_mem set so the retry path is entered.
>> + * Return -ENOSPC so htm_event_read() sets event->count=3D1,
>> + * keeping the drain loop alive until the ring buffer
>> + * consumer catches up.
>> + */
>> + ret =3D -ENOSPC;
>> + break;
>> + }
>> +
>> + /* Record written successfully: advance the iterator */
>> + aux_buf->mem_start =3D next_start;
>> +
>> + /*
>> + * Return the number of 32-byte memory configuration entries
>> + * in this batch (to_copy / 32).  Dividing here keeps
>> + * htm_event_read() free of format knowledge, consistent with
>> + * the AUX trace path returning chunk_size / 128.
>> + */
>> + ret =3D (ssize_t)(to_copy / 32);
>=20
> [Severity: Medium]
> Does this assignment under-report the emitted entry counts?
>=20
> Since this is inside a while (true) loop, multiple chunks of memory
> configuration data might be processed. By directly overwriting ret =
instead
> of accumulating it (e.g., ret +=3D to_copy / 32), the function seems =
to return
> only the count from the last chunk processed.
>=20
> Will this permanently drop the counts of all records emitted in prior =
loop
> iterations during the same session?
Sure, will fix this in V4
>=20
>> +
>> + if (!next_start) {
>> + aux_buf->collect_htm_mem =3D 0;
>> + break;
>> + }
>> + }
>> +
>> + return ret;
>> +}
>=20
> [ ... ]
>=20
>> +static void *htm_setup_aux(struct perf_event *event, void **pages,
>> + int nr_pages, bool snapshot)
>> +{
>=20
> [ ... ]
>=20
>> + /*
>> + * htm_mem_buf is the staging area passed directly to the
>> + * H_HTM_OP_DUMP_SYSMEM_CONF hcall.  The hypervisor is told the
>> + * buffer length is HTM_MEM_BUF_SIZE (65440 bytes); allocate exactly
>> + * that amount.  See the HTM_MEM_BUF_SIZE comment for the =
derivation.
>> + */
>> + buf->htm_mem_buf =3D kmalloc_node(HTM_MEM_BUF_SIZE, GFP_KERNEL, =
cpu_to_node(cpu));
>=20
> [Severity: High]
> Could allocating this buffer with kmalloc_node() lead to an =
information leak?
>=20
> This buffer is passed to the hypervisor and subsequently copied to =
userspace
> via the perf ring buffer:
>=20
> htm_collect_memory_config() {
>    ...
>    memcpy(emit_buf, aux_buf->htm_mem_buf, to_copy);
>    ...
> }
>=20
> If the hypervisor successfully returns but writes fewer entries than =
it
> claims, leaves reserved fields untouched, or inserts padding bytes, =
will the
> uninitialized kernel heap memory be exposed to userspace? Should this =
use
> kzalloc_node() instead to defensively zero-initialize the memory?
Will fix this in V4 to use kzalloc_node

Thanks
Athira
>=20
>> + if (!buf->htm_mem_buf) {
>> + kfree(buf);
>> + return NULL;
>> + }
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/20260725065942.78839-1-atrajeev@linux.ibm.c=
om?part=3D4

