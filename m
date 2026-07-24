Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C1A3A2E25;
	Fri, 24 Jul 2026 07:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784876456; cv=none; b=uJmhKZah3xLCwgq6t2RZ/pB1CYHfSJNzlqqDboQyYr3kIcUcbvZQF/JIqo3VS09Gv+KhYLnSO5k8iJLg4ObQiHoBFoDCWbk1ZnN8J9Xe+AiUDsRL9x3C6bygFQN9D/itrsmPHSLSpBD49PRIFDmEtE01EsWBAkwy5oXF5E77CVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784876456; c=relaxed/simple;
	bh=OHe3Zs34Fs7f857r5TiIrn2hnA6smAcBxAkDVyPudf0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=B20kkOq0ilNIvlS37Z/TihKmMN0kjdgV/K4yqqKSn6NZSsJclw9icnG1N8YjkPHQIT8vX7D1cYaRKuPcbDj0xK31GCwYRsbQ6lA60DzW2vq+RBaHdVv9XVmX8kPVbn5l8RzYkGtry/5nhw58cDvRrw7DKE6tgurVG5Xt2UOJQAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LHVIsstU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LHVIsstU"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O5Bc933220060;
	Fri, 24 Jul 2026 07:00:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QK8tOG
	MytvCJpk46i0dZoWlYD3BjeoFUBmReF8vc1yE=; b=LHVIsstU5Iw/F3n7IGyWdW
	ao5uyEN5FB/x0CNAgGI75rRez0TsHrc6/Bwk3eRTJus6ZMHJ2Bd3+gX3lYniVjpO
	4FU/swBiuitJNPaQJFz2lPscS5HI56MyOeqe/9veeko79Ir04w06UfbSi7LW1Dh3
	w7S+UBfQ5pY+ghgpGqAK7rNfkhwdR26YM87pmvE1IN/fnq22+tJrlpSjjDa4EuX/
	hiDJUQzQFZupyTh9qBr7xJzPgxmHNKp/Mh1SwYHzigUGQYxGEPSz4+hhIMjiGQGP
	3P90NZhz4RSCSg5MVWr4oTEWhMuHhf4G8FXlOdAK3ERE/jcgQp4SvRJTerauglNw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77aueyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 07:00:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O6ndDR019918;
	Fri, 24 Jul 2026 07:00:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyqj5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 07:00:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66O70px148365894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 07:00:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F129520150;
	Fri, 24 Jul 2026 07:00:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 520582014E;
	Fri, 24 Jul 2026 07:00:50 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.222.110])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 Jul 2026 07:00:50 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH V2 3/6] powerpc/perf: Add AUX buffer management to capture
 HTM trace data
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260720111003.6D80D1F00A3A@smtp.kernel.org>
Date: Fri, 24 Jul 2026 12:30:38 +0530
Cc: linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <26CDABC1-1D77-41D9-AE1A-FAABDD7FD27C@linux.ibm.com>
References: <20260720104447.11843-1-atrajeev@linux.ibm.com>
 <20260720104447.11843-4-atrajeev@linux.ibm.com>
 <20260720111003.6D80D1F00A3A@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KvjKxs803wiz0cSGEBU4qROrssvv_XIX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA1OSBTYWx0ZWRfX4Dvbv4fBwR9X
 PFqpOiW45fYapX7TT8vCRsy14RL2UymXh/C3GY6CBELrmHWvQTeDFo0GeZfTmv6omR0k1ejbXtT
 RB5bRuM6KqApeygY5CME4GqDdEEzzWQ=
X-Proofpoint-GUID: KvjKxs803wiz0cSGEBU4qROrssvv_XIX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA1OSBTYWx0ZWRfX68WLItR2IcmI
 NogYNgeTAEsiSZ38NOeB1nqegn4o54Y+Ph01v0OVwkWhGBL37Ud3VqnWqEqFdjyM7uRbJe5lxsy
 wdiOcICEjLyVqiLf9kkvRDuWlG4XUPXk3x4ToHT5bmDRftGCojSPxzcCr6DdAIf8X7TH3OM44TW
 2oGCSuZyEM8asO5QKob6M0AwpuE0AdEXTHHcMNgYn1e3ECO/cJsIwVOEr615IXGlqpC6nFxx1Mi
 lgl2DCRZEJNFxlrYizF4wBCx9ypfl9utaXIUhcRcbeqv5vF8YEfPfe/+G1kzDd90UWB+MyW45D2
 SJvOb55o8JY810sgUvIL+YkCaoWAVx1tSILqvF/z5Im88pZvXVV6wQhen2XhdvwujTTZZUtkTXP
 f4qtSXJbwdZSYFL/XI6xC9g0Qi7yj1DH/pG5udm+WA7LjmmSu0eysmEvLj0jqlebuEArYRoJJ8a
 5a1+w239cm9glko3rJA==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a630da5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=cLtKFc2OmvHjvkrIsPwA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240059



> On 20 Jul 2026, at 4:40=E2=80=AFPM, sashiko-bot@kernel.org wrote:
>=20
> Thank you for your contribution! Sashiko AI review found 2 potential =
issue(s) to consider:
> - [High] Reentrancy corruption of the per-CPU perf_output_handle leads =
to Use-After-Free.
> - [High] Transient conditions permanently disable trace collection and =
falsely signal EOF.
> --
>=20
> --- Patch [3]: [PATCH V2 3/6] powerpc/perf: Add AUX buffer management =
to capture HTM trace data ---
> commit edd04ff363591ec700b1e3d07e1003b1787ccb4a
> Author: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> powerpc/perf: Add AUX buffer management to capture HTM trace data
>=20
> This commit adds support for auxiliary (AUX) ring buffers in the HTM =
PMU
> driver. It implements the core lifecycle hooks and dynamically checks =
for
> physical continuity before dumping data to prevent memory corruption.
>=20
>> diff --git a/arch/powerpc/perf/htm-perf.c =
b/arch/powerpc/perf/htm-perf.c
>> index a188a40287044..b4020a6e8f30b 100644
>> --- a/arch/powerpc/perf/htm-perf.c
>> +++ b/arch/powerpc/perf/htm-perf.c
> [ ... ]
>> +struct htm_pmu_ctx {
>> + struct perf_output_handle handle;
>> +};
>> +
>> +static DEFINE_PER_CPU(struct htm_pmu_ctx, htm_pmu_ctx);
>> +
> [ ... ]
>> +static int htm_dump_sample_data(struct perf_event *event)
>> +{
>> + struct htm_pmu_ctx *htm_ctx =3D this_cpu_ptr(&htm_pmu_ctx);
> [ ... ]
>> + /* Start AUX transaction session framework */
>> + aux_buf =3D perf_aux_output_begin(&htm_ctx->handle, event);
>=20
> [Severity: High]
> What happens to the perf_output_handle if this is re-entered from an =
NMI
> context?
>=20
> htm_event_read() initiates a synchronous AUX output transaction using =
a
> per-CPU struct perf_output_handle. Since this can be called from =
process
> context (for instance, userspace reading the perf event fd), an NMI
> interrupting this could trigger a BPF program that calls
> bpf_perf_event_read() on the same CPU.
>=20
> Would this overwrite the per-CPU handle, causing the interrupted outer
> call to use a corrupted handle when it resumes, leading to =
underflowing
> reference counts and a use-after-free of the AUX pages? Could the
> handle be allocated on the stack instead to prevent this?

Thanks for the feedback Sashiko

The reentrancy concern is handled by perf_aux_output_begin() itself in =
kernel/events/ring_buffer.c:

nest =3D READ_ONCE(rb->aux_nest);
/*
 * Nesting is not supported for AUX area, make sure nested
 * writers are caught early
 */
if (WARN_ON_ONCE(nest))
    goto err_put;   /* returns NULL */


rb->aux_nest is a per-ring-buffer nesting counter maintained by the perf =
core. Before writing anything to the per-CPU handle, =
perf_aux_output_begin() checks this counter. If a nested caller (NMI, =
BPF, or any interrupt) attempts to begin an AUX transaction on the same =
ring buffer while one is already in progress, it hits the WARN_ON_ONCE =
and returns NULL.

Thanks
Athira

>=20


>> + if (!aux_buf)
>> + return 0;
> [ ... ]
>> + /*
>> + * Assess constraints regarding space remaining across the mapping
>> + * context boundary
>> + */
>> + chunk_size =3D htm_ctx->handle.size;
>> + chunk_size &=3D PAGE_MASK;
>> +
>> + if (chunk_size > (aux_buf->size - dump_offset))
>> + chunk_size =3D aux_buf->size - dump_offset;
> [ ... ]
>> + /* Bound transfer length tightly within the validated contiguous =
window */
>> + if (chunk_size > max_contiguous_bytes)
>> + chunk_size =3D max_contiguous_bytes;
>> +
>> + if (!chunk_size) {
>> + aux_buf->collect_htm_trace =3D 0;
>=20
> [Severity: High]
> Does this permanently disable trace collection during a transient =
buffer full
> condition?
>=20
> If the remaining space in the user-space perf ring buffer is =
temporarily
> less than PAGE_SIZE, chunk_size will evaluate to 0. This sets
> collect_htm_trace to 0, which prevents any future trace collection for =
the
> lifetime of the buffer.

This is good point. I will fix this in V3
>=20
>> + perf_aux_output_end(&htm_ctx->handle, 0);
>> + return 0;
>> + }
>> +
> [ ... ]
>> + do {
>> + /*
>> + * Invoke H_HTM call with:
>> + * - operation as htm dump (H_HTM_OP_DUMP_DATA)
>> + * - last three values are address, size and offset
>> + */
>> + rc =3D htm_hcall_wrapper(htmflags, cfg.nodeindex, =
cfg.nodalchipindex,
>> + cfg.coreindexonchip, cfg.htmtype, H_HTM_OP_DUMP_DATA,
>> + hypervisor_target_phys, chunk_size, aux_buf->head);
>> + ret =3D htm_return_check(rc);
>> + } while (ret =3D=3D -EBUSY && ++retries < MAX_RETRIES);
>> +
>> + if (ret > 0) {
>> + aux_buf->head +=3D chunk_size;
>> + aux_buf->trace_records++;
>> + perf_aux_output_end(&htm_ctx->handle, chunk_size);
>> + return ret;
>> + }
>> +
>> + aux_buf->collect_htm_trace =3D 0;
>=20
> [Severity: High]
> If the hypervisor returns a transient long-busy status (like
> H_LONG_BUSY_ORDER_1_MSEC), htm_return_check() returns -EAGAIN.
>=20
> Will the loop exit and fall through to this block, permanently =
disabling
> tracing for this buffer session?
>=20
>> + perf_aux_output_end(&htm_ctx->handle, 0);
>> + return ret;
>> +}
>> +
>> +static void htm_event_read(struct perf_event *event)
>> +{
>> + int ret;
>> +
>> + /*
>> + * Update event->count as a binary indicator:
>> + * 1 if data was dumped into the
>> + * AUX buffer, 0 otherwise. Actual trace record
>> + * decoding is left to userspace.
>> + */
>> + ret =3D htm_dump_sample_data(event);
>> + if (ret <=3D 0)
>> + local64_set(&event->count, 0);
>=20
> [Severity: High]
> Since the transient buffer full condition or hypervisor busy state =
causes
> htm_dump_sample_data() to return 0 or -EAGAIN, does this falsely =
signal
> an EOF to userspace by setting event->count to 0?
>=20
>> + else
>> + local64_set(&event->count, 1);
>> +}
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/20260720104447.11843-1-atrajeev@linux.ibm.c=
om?part=3D3

