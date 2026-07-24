Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDF63A8732;
	Fri, 24 Jul 2026 07:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784878125; cv=none; b=N8bdSycGGzVwbXMPkBElc5t+j4frIBchtGnte5nHtgzc+UUEgYQvsorDfXBH7pigtdsZ6cRUwn/LpQ4Ap5jo3Ag2W/VsL14aO0qp8Itkk4KkwirwF3bX7trS1VECGpt0MqKb3iVOW7C7EDcwPDGbKRTpqVpWYKfflA00wQ6GenI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784878125; c=relaxed/simple;
	bh=av/KYhFYVpXyoEb9wH6Dlb6szNRCwxdpci4r+aq24rU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lAxf/W2TCxxapVAI9PPhLGGlFsX+ikesXLSRLKADV2HRqBCEM2G3dJktlGk35BbRUy3IPFBzzfzPpJvADrmn9m22+Yp+A9/EH+wsKCIAtjO+WrVIXifcEicOkWlgF5YVr9trCDsbvgExWVRoBBvFvVHr3K4bDSTPjVxcoYA0uKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U2ESk0mG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U2ESk0mG"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O5Bet73220091;
	Fri, 24 Jul 2026 07:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=j/Yw90
	MH+LcShjfR7wPxnbm0c+fDbs0ruEtbjm5VE7M=; b=U2ESk0mGeczQJt27KhKroG
	RLHWDhP30LRu7qSkjBHSIyOSLDpUboQavKc61RQ1pkTxvEZKxbwreny6xaJCmii0
	GztqB8CCzoTFqBHA/Ve+h9OD25yMnBSOnLx4q0Ba3Re/ZWvmTDnJX9kTZpf4km2l
	f5JLe7tFM4O0JfJ/31JvKYLIzOaIxnjc9i5q3q9k/quv8tSOfif0nlBQP6y9FEaj
	mqNWKnEn56jxjcXWDA9HUDyF7wp+zIzRaUFBXE3oiOgex53Ant+/ZHO1mxKZUtgz
	aWZmwi6qvyI/p3Gx/afcnmbjwTm2uKfDsax5+uYEW4aexCVgAC09doiE+mnuYmeQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77auj7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 07:28:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O74ltw017639;
	Fri, 24 Jul 2026 07:28:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gqqap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 07:28:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66O7SchT47579440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 07:28:38 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBABB201B4;
	Fri, 24 Jul 2026 07:02:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 478CA201AE;
	Fri, 24 Jul 2026 07:02:21 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.222.110])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 Jul 2026 07:02:21 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH V2 4/6] powerpc/perf: Capture the HTM memory configuration
 as part of perf data
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260720110957.C5D761F00A3D@smtp.kernel.org>
Date: Fri, 24 Jul 2026 12:32:09 +0530
Cc: linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D483892A-EB2B-46FD-8110-BBD849AFDEAE@linux.ibm.com>
References: <20260720104447.11843-1-atrajeev@linux.ibm.com>
 <20260720104447.11843-5-atrajeev@linux.ibm.com>
 <20260720110957.C5D761F00A3D@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wTWmUgXZcm3n_Pg9KStAD-NX0vf3JPP7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA2NCBTYWx0ZWRfX8M25HfkL/doR
 sPJS1V4XLmSKww/0nITZGfshtmDkA/LByOZOpLitSEAqdAz6zQCyGJ88Jk3sIyAOT+vFLUQslns
 NFT+uRaGcJ5Vwyk+67+XDVZaufd4aeg=
X-Proofpoint-GUID: wTWmUgXZcm3n_Pg9KStAD-NX0vf3JPP7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA2NCBTYWx0ZWRfX6TKoBUQD/YHv
 Lc4k0/9i9k/P0YWthd2sDEGRf/pFYifyJqOiBdORVfLzM5SR768wAmt3OZBg1JaB8MHIGWAlDVq
 kAOQ82Fz1KgvPALhjRlXmMR4MFkW/zVvUUW4p2YGbc7MgHgpr6XhMOZ3OIfQzjkgDEUDL/5PSvi
 7H5/Q/V/Iz3/Q7A81vakgLPr+hbJ/3Om1qiQZeO3Knk/P2pWMcdt1L0hX3yPT+5c2thcc6+s3jZ
 Vy2yz3kwmU3PHPwgHF8tDHA6Ej3PuxmHtugduAxvhIvt4fltZSPnw7tWnacPbvaQ6nGkSGSFKvP
 7/e0xdGytofq1WugsUjRXmIfyygruTbFxJ4qd8ZpMjQQvhhIGACRoaiIdgEH0ak9cz/WT5uZtY6
 KbM702VmMdbV6zuV3VExg59gKk2TPfbgYYEfdAkU9ZklFe4ccoD2GG8JfjveqtFfTsmavn1kUaN
 VeuiW6Fo43EHpSzcjkw==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a631429 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=XbSfs4UG2olPpgAHPvAA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240064



> On 20 Jul 2026, at 4:39=E2=80=AFPM, sashiko-bot@kernel.org wrote:
>=20
> Thank you for your contribution! Sashiko AI review found 3 potential =
issue(s) to consider:
> - [Critical] The staging buffer `htm_mem_buf` is allocated as =
`PAGE_SIZE` but the hypervisor is instructed to write up to =
`HTM_MEM_BUF_SIZE` (64448 bytes) into it, causing a physical memory =
overflow on 4K page configurations.
> - [High] Uninitialized `struct pt_regs regs` allocated on the stack is =
passed directly to `perf_event_overflow()`, leading to a kernel stack =
memory leak.
> - [Medium] The memory configuration iterator `mem_start` is not =
advanced when `perf_event_overflow` returns a non-zero (throttled) =
value, causing data duplication.
> --
>=20
> --- Patch [4]: [PATCH V2 4/6] powerpc/perf: Capture the HTM memory =
configuration as part of perf data ---
> commit 5929e601ef9335650c92ad97d9999f8482e8f648
> Author: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> powerpc/perf: Capture the HTM memory configuration as part of perf =
data
>=20
> This commit captures HTM system memory configuration during tracing by
> retrieving it via a hypercall. The records are emitted as raw perf =
sample
> data after the AUX trace dump completes.
>=20
>> diff --git a/arch/powerpc/perf/htm-perf.c =
b/arch/powerpc/perf/htm-perf.c
>> index b4020a6e8f30b..0fda0f552b4e1 100644
>> --- a/arch/powerpc/perf/htm-perf.c
>> +++ b/arch/powerpc/perf/htm-perf.c
> [ ... ]
>> @@ -173,6 +177,99 @@ static ssize_t htm_return_check(int rc)
>> #define HTM_TRACING_ACTIVE 1
>> #define HTM_TRACING_INACTIVE 0
>>=20
>> +#define HTM_MEM_MAX_ENTRIES 2013U
>> +#define HTM_MEM_BUF_SIZE (32 + HTM_MEM_MAX_ENTRIES * 32)
>> +
>> +static int htm_collect_memory_config(struct perf_event *event,
>> +      struct htm_pmu_buf *aux_buf)
>> +{
>> + struct perf_sample_data data;
>> + struct perf_raw_record raw;
>> + struct pt_regs regs;
>        ^^^^^^^^^^^^^^^^^^^^
>=20
> [Severity: High]
> Does this leak kernel stack memory to userspace?
>=20
> The regs struct is allocated on the stack but never zeroed or =
initialized.
> If userspace configures the perf event with PERF_SAMPLE_REGS_INTR or
> PERF_SAMPLE_CALLCHAIN, the core perf framework will read these
> uninitialized bytes in perf_event_overflow() and write them to the =
ring
> buffer.
>=20
> Should regs be initialized, for example via =
perf_fetch_caller_regs(&regs)
> or memset(&regs, 0, sizeof(regs))?

Thanks for catching this. Will send a V3 addressing this

>=20
>> + u8 *htm_mem_buf =3D aux_buf->htm_mem_buf;
>> + __be64 *num_entries;
>> + u64 next_start;
>> + u64 to_copy;
> [ ... ]
>> + memcpy(emit_buf, aux_buf->htm_mem_buf, to_copy);
>> +
>> + perf_sample_data_init(&data, 0, event->hw.last_period);
>> + memset(&raw, 0, sizeof(raw));
>> + raw.frag.data =3D emit_buf;
>> + raw.frag.size =3D to_copy;
>> + perf_sample_save_raw_data(&data, event, &raw);
>> +
>> + if (perf_event_overflow(event, &data, &regs)) {
>> + ret =3D 0;
>> + break;
>> + }
>                ^^^^^
>=20
> [Severity: Medium]
> If perf_event_overflow() throttles the event and returns a non-zero =
value,
> we break out of the loop before advancing the iterator.
>=20
> When tracing resumes and htm_collect_memory_config() is called again,
> it will start with the stale aux_buf->mem_start value and repeatedly =
ask
> the hypervisor for the same configuration block. Will this emit =
duplicate
> records into the perf stream?

Clarified the perf_event_overflow() throttle path: when the event is
  throttled, mem_start is intentionally not advanced (the same block =
will
  be retried on the next drain pass once unthrottled).  Added a comment =
in V3
  making this explicit and distinguishing it from the error/EOF paths
  that clear collect_htm_mem.


>=20
>> +
>> + /* Record written: advance next read iterator */
>> + aux_buf->mem_start =3D next_start;
>> + emitted =3D 1;
>> +
>> + if (!next_start) {
>> + aux_buf->collect_htm_mem =3D 0;
>> + break;
>> + }
>> + }
> [ ... ]
>> @@ -568,7 +672,23 @@ static void *htm_setup_aux(struct perf_event =
*event, void **pages,
>> return NULL;
>> }
>>=20
>> + buf->htm_mem_buf =3D kmalloc_node(PAGE_SIZE, GFP_KERNEL, =
cpu_to_node(cpu));
>        =
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>=20
> [Severity: Critical]
> Can this corrupt physical memory on systems with 4K pages?
>=20
> buf->htm_mem_buf is allocated using PAGE_SIZE, which is 4096 bytes if
> CONFIG_PPC_4K_PAGES is enabled.
>=20
> However, in htm_collect_memory_config(), the hypervisor is instructed =
that
> the buffer length is HTM_MEM_BUF_SIZE:
>=20
> arch/powerpc/perf/htm-perf.c:htm_collect_memory_config() {
> ...
> rc =3D htm_hcall_wrapper(htmflags, 0, 0, 0,
>       0, H_HTM_OP_DUMP_SYSMEM_CONF,
>       virt_to_phys(aux_buf->htm_mem_buf),
>       HTM_MEM_BUF_SIZE, aux_buf->mem_start);
> ...
> }
>=20
> Since HTM_MEM_BUF_SIZE is defined as 32 + 2013 * 32 =3D 64448, the =
hypervisor
> will assume it can write 64448 bytes, silently overwriting up to ~60KB =
of
> contiguous physical kernel memory past the 4KB allocation.
>=20
> Should this allocate HTM_MEM_BUF_SIZE bytes instead of PAGE_SIZE?

Sure, will fix this using HTM_MEM_BUF_SIZE in V3
>=20
>=20
>> + if (!buf->htm_mem_buf) {
>> + kfree(buf);
>> + return NULL;
>> + }
>> +
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/20260720104447.11843-1-atrajeev@linux.ibm.c=
om?part=3D4

