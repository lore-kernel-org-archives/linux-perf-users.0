Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8EB17A303;
	Sun, 26 Jul 2026 07:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785050746; cv=none; b=jkXViSLIBFWg6J5W9SK0/z70NzsPjLbCslqi8mpbaJjPA2IY41DF3eVigwxC7C5xKi21/mh9zLY8dea683L1pSJgFqoaV6N+AjAnWMB61UdDGkwwnW6SLoEXhlujbjk5MyPQW6AQy7MEvQXoLZOcCyytBSq+S9FUe9FcIs/h+fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785050746; c=relaxed/simple;
	bh=KRifGaOWbrC6rY3nnuPJNkIdHg+CKtHxK3u1Tdzqse0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eo7J6EBRK3vk1kZ9cWLPeRcsYKKED6gdYu1fMFOptx638GuerpGihwaBQrS3Cm0mTkEsmzrk2hs6T/EFoCNKBIN/bDAox+V9xIHGCqVAJw3rHqjnA5Wapl3yDKBxWZCWkxb2Tia8zcw5vwyXA4z02lqJrpi0St5ox+dogZ2Rodg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OBEiFZkl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OBEiFZkl"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66Q5n4TF2698940;
	Sun, 26 Jul 2026 07:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vYqKiD
	uEGLqwx3jB+Clmrwkdq4CU0aDF2aEB6hH9Xus=; b=OBEiFZkldbhfNIfV/NNZXM
	1JOmhAS2nK8CFLNWYe9eqLZZIkSdshX/JsLVLk9uZM/gPHjz9FVIGaXNUzqrCba9
	mwXNm/j5cgonOBAUVvcm0AlnwAmdP9NyOeNxvI2gpqXICxxF7rw2SKzDgNjLqOsg
	Yul+CQUbokKX1qR8865kX8MN2sNy/WVIq2/5W+/tff+gr5dGDpw4QwDNYvjSm8np
	COjW8TnMtNxBwIuCEM7RF1XW/zJKPrh1EWqCpPN3WBNTmURK9J3V02QBydS9q0Ny
	GP5FglBAWP20xt6X023UZX7QpaaS0DDhI3/V6ZVV2EdsSId04wlN9HAAs9ktviJQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xauh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 07:25:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66Q7BFU0020468;
	Sun, 26 Jul 2026 07:25:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjru21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 07:25:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66Q7Pdik51708262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jul 2026 07:25:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81C45200CB;
	Sun, 26 Jul 2026 07:25:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7323200D1;
	Sun, 26 Jul 2026 07:25:25 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.223.95])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 26 Jul 2026 07:25:25 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH V3 3/6] powerpc/perf: Add AUX buffer management to capture
 HTM trace data
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260725074507.5C7301F000E9@smtp.kernel.org>
Date: Sun, 26 Jul 2026 12:55:12 +0530
Cc: linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0C49038F-E937-4166-88EF-8570C3689175@linux.ibm.com>
References: <20260725065942.78839-1-atrajeev@linux.ibm.com>
 <20260725065942.78839-4-atrajeev@linux.ibm.com>
 <20260725074507.5C7301F000E9@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _-NOtE1ZFybTQceAmx9OSIlXsv626yGP
X-Proofpoint-ORIG-GUID: _-NOtE1ZFybTQceAmx9OSIlXsv626yGP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDA3MCBTYWx0ZWRfX7N7vv6l/3B3/
 v/Tk5yJv3JSQESw3eZ+RPrMT44DXM/iS1IePzqOYP8s5ZjpowmBP/U5Muvw7sjk6+KBmp/4hnkV
 Z/IoYmCKQyYeME5I6IIEWlGXRayRifU=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a65b676 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=1AWEjFu6Ppu-ffmwGKwA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDA3MCBTYWx0ZWRfX/ioqBnLn5IK7
 gr+sR6oEwBbZ8tc8Y0lN6heqibilRI6dkxlUyX7w+tOV30Qm6OAAYDUiDChjUKfkIEqNOgngKCE
 0zo/LGKLmiLLrSzeMyk5COmv+7nXfvP4gFH9xDYTy5puhi3h56f6vMhou3bTpP6wkyWJJ8fZ7uV
 eWvC90HNBNJMlP0ToAtjPk5P8XlsexGfiu0C/mzDTCg7773R5B2D9Nvc4JwibxvCu1vDv17Z4Tw
 29EfC4VILZlvwTTb79B4UwXf/PUdbqmoUrMdM9qrGJ0ojAaD0UOgMUM4mxpL5/9AwQf3IlsWiqR
 VOQY4D2QIvGI/ejMBhVtUbkOSGH2sU3Qg+71NYoFbPW4tK+jzWnAnUmDWt/uxn1KzXYrBZtzH5h
 VqcLBBRXB09g8NlXzSJE06o+eNZ63OE0wtSD/oaWAzDu+yrLRFoSHjxPuF8zXqyneLLVutN77va
 Pb6vRhRi/fYDjGmRUXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260070



> On 25 Jul 2026, at 1:15=E2=80=AFPM, sashiko-bot@kernel.org wrote:
>=20
> Thank you for your contribution! Sashiko AI review found 3 potential =
issue(s) to consider:
> - [Critical] Using a shared per-CPU `perf_output_handle` causes a NULL =
pointer dereference on reentrancy between process and NMI contexts.
> - [High] Stale AUX buffer state (`collect_htm_trace`) permanently =
prevents dumping trace data for subsequent tracing sessions.
> - [Medium] The PMU driver fails to reject snapshot (overwrite) mode, =
leading to an infinite `-ENOSPC` drain loop in userspace.
> --
>=20
> --- Patch [3]: [PATCH V3 3/6] powerpc/perf: Add AUX buffer management =
to capture HTM trace data ---
> commit 35468a18c6f5ab02b21271ca4f3e9ece1b6d7df7
> Author: Athira Rajeev <atrajeev@linux.ibm.com>
> powerpc/perf: Add AUX buffer management to capture HTM trace data
>=20
> This commit implements support for auxiliary (AUX) ring buffers in the =
HTM PMU
> driver. It enables high-volume trace data to be streamed directly into =
a perf
> AUX buffer for deferred post-processing.
>=20
>> diff --git a/arch/powerpc/perf/htm-perf.c =
b/arch/powerpc/perf/htm-perf.c
>> index 84a5601ee7f73..f880a5fc88330 100644
>> --- a/arch/powerpc/perf/htm-perf.c
>> +++ b/arch/powerpc/perf/htm-perf.c
> [ ... ]
>> @@ -415,8 +431,237 @@ static void htm_event_del(struct perf_event =
*event, int flags)
>> /* pmu_private freed by event->destroy =3D reset_htm_active */
>> }
>>=20
>> +static ssize_t htm_dump_sample_data(struct perf_event *event)
>> +{
>> + struct htm_pmu_ctx *htm_ctx =3D this_cpu_ptr(&htm_pmu_ctx);
>> + struct htm_target_id *target =3D event->pmu_private;
>> + struct htm_pmu_buf *aux_buf;
>> + struct htm_config cfg =3D target->cfg;
>> + u64 chunk_size, dump_offset, page_index, page_offset;
>> + u64 max_contiguous_bytes, expected_phys, scan_index, actual_phys;
>> + u64 hypervisor_target_phys;
>> + void *target_page_virt;
>> + ssize_t ret =3D 0;
>> + int retries =3D 0;
>> + long rc;
>> +
>> + /* Start AUX transaction session framework */
>> + aux_buf =3D perf_aux_output_begin(&htm_ctx->handle, event);
>=20
> [Severity: Critical]
> Does using a shared per-CPU perf_output_handle here risk a NULL =
pointer
> dereference on reentrancy?
>=20
> If a process context read is interrupted by an NMI on the same CPU, =
and that
> NMI also calls perf_pmu_read() on the HTM event, =
perf_aux_output_begin() will
> detect the nesting, clear handle->event to NULL, and exit.
>=20
> When the NMI returns to the process context, could the outer
> perf_aux_output_end() call subsequently dereference the NULL =
handle->event?

No, because, The reentrancy concern is handled by =
perf_aux_output_begin() itself=20

 nest =3D READ_ONCE(rb->aux_nest);
        /*
         * Nesting is not supported for AUX area, make sure nested
         * writers are caught early
         */
        if (WARN_ON_ONCE(nest))
                goto err_put;


rb->aux_nest is a per-ring-buffer nesting counter maintained by the perf =
core. Before writing anything to the per-CPU handle, =
perf_aux_output_begin() checks this counter. If a nested caller (NMI, =
BPF, or any interrupt) attempts to begin an AUX transaction on the same =
ring buffer while one is already in progress, it hits the WARN_ON_ONCE =
and returns NULL.=20

>> + if (!aux_buf)
>> + return 0;
>> +
>> + if (!aux_buf->collect_htm_trace) {
>=20
> [Severity: High]
> Can stale AUX buffer state prevent dumping trace data for subsequent =
sessions?
>=20
> If a trace is stopped and drained, aux_buf->collect_htm_trace is set =
to 0.=20
> If the event is restarted, htm_event_start() doesn't appear to reset =
this=20
> flag.
>=20
> Would this early bailout then cause trace data for all subsequent =
sessions to
> be permanently dropped?
Sure, good catch, will address this in V4
>=20
>> + perf_aux_output_end(&htm_ctx->handle, 0);
>> + return 0;
>> + }
> [ ... ]
>> +/*
>> + * Set up pmu-private data structures for an AUX area
>> + * **pages contains the aux buffer allocated for this event
>> + * for the corresponding cpu. rb_alloc_aux uses "alloc_pages_node"
>> + * and returns pointer to each page address.
>> + * PMU capabilities: PERF_PMU_CAP_AUX_NO_SG | =
PERF_PMU_CAP_AUX_PREFER_LARGE
>> + * to try get closest possible physically contiguous page blocks.
>> + *
>> + * The aux private data structure ie, "struct htm_pmu_buf" mainly
>> + * saves
>> + * - buf->base: aux buffer base address
>> + * - buf->head: offset from base address where data will be written =
to.
>> + * - buf->size: Size of allocated memory
>> + */
>> +static void *htm_setup_aux(struct perf_event *event, void **pages,
>> + int nr_pages, bool snapshot)
>> +{
>> + int cpu =3D event->cpu;
>> + struct htm_pmu_buf *buf;
>> +
>> + if (!nr_pages)
>> + return NULL;
>> +
>> + if (cpu =3D=3D -1)
>> + cpu =3D raw_smp_processor_id();
>> +
>> + buf =3D kzalloc_node(sizeof(*buf), GFP_KERNEL, cpu_to_node(cpu));
>> + if (!buf)
>> + return NULL;
>> +
>> + buf->nr_pages =3D nr_pages;
>> + buf->snapshot =3D snapshot;
>=20
> [Severity: Medium]
> Does the driver need to validate and reject snapshot (overwrite) mode?
>=20
> When in snapshot mode, perf_aux_output_begin() leaves handle.size =3D =
0.
> This would cause htm_dump_sample_data() to interpret chunk_size as 0, =
fallback
> to returning -ENOSPC, and cause htm_event_read() to set event->count =3D=
 1.
>=20
> Could this result in the userspace perf tool spinning in an infinite =
retry
> loop waiting for space that will never become available?
Sure
I will have this change in V4

Thanks
Athira
>=20
>> + buf->size =3D (u64)nr_pages << PAGE_SHIFT;
>> + buf->pages =3D pages;
>> +
>> + buf->base =3D pages[0];
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/20260725065942.78839-1-atrajeev@linux.ibm.c=
om?part=3D3

