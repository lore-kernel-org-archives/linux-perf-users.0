Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4E33B636C;
	Mon, 20 Jul 2026 07:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784533068; cv=none; b=jMuZ38bwvnpl4B2iwZYbMmxsupHdosbVYNMXmzjWE7FBpPs6e6Xl/+g2s5d3+svxfuDYVJckMCTkXlnzuM9i+F6tPz1p23JYCODtoVV2bQjHN1YoVMhf+kffRmyAY8MAhn1OwOe7paJ4BIoDv9142t8cJJszSclsLoKEDD0aw3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784533068; c=relaxed/simple;
	bh=14j9fZlvMHB8gLhLaxwDD9SE76EdL3qrb2j5n2P0KPc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=T8wgRrt7oqSnE2I3gi9KoeDBNigbYbcDM/4lBWkoSkAotbB1PjbTqYR+z7EVBJUlm3Keeoap6MR56tTubbzi7ByvtvSl+BRubnQphxsSbeSoUhQAwKK7mBSOdgGIQKXcNxS+hSTMz0k/DSJ1lSIDRXe3VF8s1E+WWiomFl8ddfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XczAKop0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XczAKop0"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6g9Ex1368721;
	Mon, 20 Jul 2026 07:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=14j9fZ
	lvMHB8gLhLaxwDD9SE76EdL3qrb2j5n2P0KPc=; b=XczAKop0SxNaC/t+wuASgf
	8vFQEh7GloLhGDvyzT+RdPPZUlUYzonR2P2QEkuBH7qk01a8/0P8D/8YDGaP8UP3
	RnR1P0lYtv/2GoUidiUSSRiWjfUx/4PW0Dbj0r5WRPK3BV3K4lD7WdpNAmoXuwB3
	jO1jZZta6p0m7AAwzZDQ0hBdHDD488a4k4ViIFt7EbvCpNZ/OvTnS2DovvijTbSl
	jt1lnLmDbaYy4QVyJ/ywenviNVrrcH+O6SxR7HykCH3Jei7JMo+1csHWPmmoWq4d
	jVPYr7o/1of+J+0iMmUqGlnHhgh6HR2kZGJqvEsvDmjgBvBt1YmopQka+GIIeA6A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78fx34k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 07:37:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66K7YctG000514;
	Mon, 20 Jul 2026 07:37:41 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnagvhcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 07:37:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66K7bdnF29557218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 07:37:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A71FD2005A;
	Mon, 20 Jul 2026 07:37:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEC662004E;
	Mon, 20 Jul 2026 07:37:38 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.39.16.54])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 20 Jul 2026 07:37:38 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH 3/5] powerpc/perf: Capture the HTM memory configuration as
 part of perf data
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260701090231.184B91F000E9@smtp.kernel.org>
Date: Mon, 20 Jul 2026 13:07:28 +0530
Cc: linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CA9E89D4-5A89-4706-B336-2E6AA499C9A7@linux.ibm.com>
References: <20260701083806.79358-1-atrajeev@linux.ibm.com>
 <20260701083806.79358-4-atrajeev@linux.ibm.com>
 <20260701090231.184B91F000E9@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA3OCBTYWx0ZWRfX6PU6LZiMfVb2
 FgL+fnyBNWlrjXEGrvupfkLbNNp7i+OlMEXLRkpqHvy3ipaxMivV7z2UnHslcxM6nAk7xh20AvM
 cAm8DUwqtdM5C23rrC8JWsff/CnzsdGzuJzETPSY7p2NmUq1/GfP9ui/uALbYAjO3+AqorfWZUK
 BA8F8Gazb/fUE6p5Dw1nTSFGuVQqoFe4qHOoVGecwV2vNngr7ReBp8H40tHstMEddqYN3E6I+DM
 +xaQ5n302BVp0IuaB5T6wtll3jR0r5oXqIXJtB4PPa+1Zq86YhIdTunxjbcdMki49RDGXr3CLbI
 Egi5QoaFSo+om2Vg4r1fR3cBbUQXk5KVoY84pd+0I0Y/paP1hpG/oIpPswCpXFgr/SUzkxEThAi
 akeZWmQFJlVJ67qTIHLmlsLAg9s62F+k3mbFz6qDFXjw95PT87plhEn0ULShmQsrtitwMKn6396
 Vwd2YNhBWuhnakUspgw==
X-Proofpoint-GUID: x5znLRYjOsfD6-1NnKdheBn2addqWtdM
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a5dd046 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=L4pxkKnJ2LytCwyg9NIA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA3OCBTYWx0ZWRfX29pTbt26dQcN
 rOxE0U8WBKbWNKd0K+RMqdrkt2NI+zd7bUNGJZArhzzrlJp2mshC9sXC0FK3ZvGaDWT3wiJyTPE
 b14N+Or7D03yrlD5qRs5bAqUlq4CEek=
X-Proofpoint-ORIG-GUID: x5znLRYjOsfD6-1NnKdheBn2addqWtdM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200078



> On 1 Jul 2026, at 2:32=E2=80=AFPM, sashiko-bot@kernel.org wrote:
>=20
> Thank you for your contribution! Sashiko AI review found 6 potential =
issue(s) to consider:
>=20
> New issues:
> - [High] Missing bounds check on the hypervisor-provided `num_entries` =
allows `to_copy` to exceed `PAGE_SIZE`, leading to an out-of-bounds read =
from `htm_mem_buf`.
> - [High] The PMU driver assumes the AUX buffer pages are virtually =
contiguous and uses `memcpy` to write sequentially into them, causing an =
out-of-bounds write that corrupts kernel memory.
> - [High] Chunks of memory configuration data are permanently lost if =
there is insufficient space in the buffer (`to_copy > space_to_end`).
> - [Medium] The implementation fails to write the starting =
`PERF_SAMPLE_RAW` record and exports incorrect size data in the ending =
record, violating the documented API contract.
> - [Medium] When wrapping the memory map trace data at the 50% =
threshold, the remaining padding space in the buffer is left =
uninitialized but committed to userspace.
>=20
> Pre-existing issues:
> - [Critical] Pre-existing logic in `htm_dump_sample_data()` passes a =
non-contiguous physical address base to the hypervisor, causing massive =
physical memory corruption during the trace dump.

Thanks for the valuable feedback

All these will be addressed in V2

Thanks
Athira
> --
>=20
> commit 651e2e981cb409f60d68fe643ec0cd48a6edd6e7
> Author: Athira Rajeev <atrajeev@linux.ibm.com>
> Subject: powerpc/perf: Capture the HTM memory configuration as part of =
perf data
>=20
> This commit modifies the HTM PMU driver to capture system memory =
configuration
> data in the perf AUX buffer. It uses the H_HTM_OP_DUMP_SYSMEM_CONF =
hypervisor
> call to retrieve the data and demarcates it using PERF_SAMPLE_RAW =
records.
>=20
>> When monitoring the HTM pmu, auxiliary buffer captures
>> the "trace" data and SystemMemory Configuration. This
>> will be post processed later using perf. The size of memory
>> mapping data captured depends on how large is the system
>> and how much memory is allocated. To help with relating
>> and identifying the start of memory mapping data in the
>> auxiliary buffer, insert two PERF_SAMPLE_RAW records in the
>> ring buffer. First PERF_SAMPLE_RAW record will mark the
>> beginning of system memory mapping data in aux buffer. And second
>> PERF_SAMPLE_RAW record will be written at the end to make the
>> end of the data in aux buffer and also contains the total size
>> of the memory map data. These sample raw records
>> will be used during post processing in perf report.
>=20
> [Severity: Medium]
> Is the start PERF_SAMPLE_RAW record missing entirely from the code, =
contrary
> to this commit message?
>=20
>> diff --git a/arch/powerpc/perf/htm-perf.c =
b/arch/powerpc/perf/htm-perf.c
>> index ae7f469b6840d..fe458bc3ec05d 100644
>> --- a/arch/powerpc/perf/htm-perf.c
>> +++ b/arch/powerpc/perf/htm-perf.c
> [ ... ]
>> @@ -143,6 +147,86 @@ static ssize_t htm_return_check(int rc)
>> return -EINVAL;
>> }
>>=20
>> +static int htm_collect_memory_config(struct perf_event *event,
>> + struct htm_pmu_buf *aux_buf)
>> +{
>> + struct perf_sample_data data;
>> + struct perf_raw_record raw;
>> + struct pt_regs regs;
>> + u64 *num_entries;
>> + u64 to_copy =3D 0;
>> + int htm_val;
>> + long rc;
>> + int ret;
>> + int retries =3D 0;
>> + size_t size;
>> + size_t space_to_end =3D aux_buf->size - aux_buf->mem_head;
>> +
>> + /* Capture HTM system memory configuration in aux buffer */
>> + do {
>> + rc =3D htm_hcall_wrapper(htmflags, 0, 0, 0,
>> + 0, H_HTM_OP_DUMP_SYSMEM_CONF, virt_to_phys(aux_buf->htm_mem_buf),
>> + PAGE_SIZE, aux_buf->mem_start);
>> + ret =3D htm_return_check(rc);
>> + } while (ret =3D=3D -EBUSY && ++retries < 100);
>> +
>> + /* Return once there is no more data in HTM buffer */
>> + if (ret <=3D 0) {
>> + perf_sample_data_init(&data, 0, event->hw.last_period);
>> + memset(&raw, 0, sizeof(raw));
>> + memset(&regs, 0, sizeof(regs));
>> +
>> + htm_val =3D (aux_buf->head/((aux_buf->nr_pages * PAGE_SIZE)));
>> + raw.frag.data =3D &htm_val;
>> + raw.frag.size =3D sizeof(htm_val);
>=20
> [Severity: Medium]
> Does this export the buffer wrap count instead of the total size of =
the
> memory map data in the end record?
>=20
>> +
>> + aux_buf->collect_htm_mem =3D 0;
>> + perf_sample_save_raw_data(&data, event, &raw);
>> + perf_event_overflow(event, &data, &regs);
>> + return 0;
>> + }
>> +
>> + /*
>> + * Find how much data to copy to aux buffer
>> + * If hcall returned H_PARTIAL, set mem_start to
>> + * indicate next offset of memory to read from
>> + */
>> + num_entries =3D aux_buf->htm_mem_buf + 0x10;
>> + aux_buf->mem_start =3D be64_to_cpu(*(u64 *)(aux_buf->htm_mem_buf + =
0x8));
>=20
> [Severity: High]
> Are chunks of memory configuration data permanently lost here?
>=20
> aux_buf->mem_start is unconditionally advanced before checking if =
to_copy
> fits in space_to_end.
>=20
> If the else branch is taken at the end of this function, does the next =
PMU
> interrupt fetch data from the already-advanced offset, dropping the =
current
> chunk?
>=20
>> +
>> + to_copy =3D 32 + (be64_to_cpu(*num_entries) * 32);
>> +
>> + if (to_copy <=3D space_to_end) {
>=20
> [Severity: High]
> Does this code allow an out-of-bounds read of aux_buf->htm_mem_buf?
>=20
> Since to_copy is calculated from the hypervisor-provided num_entries, =
if the
> hypervisor returns a large value, could to_copy exceed the PAGE_SIZE
> allocation of aux_buf->htm_mem_buf when it is passed to memcpy() =
later?
>=20
>> + if ((to_copy + aux_buf->mem_head) >=3D ((aux_buf->nr_pages * =
PAGE_SIZE)/2)) {
>> + /*
>> + * Crossing 50% threshold - flush and wrap.
>> + * Write current chunk, then pad to end of buffer.
>> + * This ensures next write starts at beginning with
>> + * perf head also at beginning (synchronized).
>> + */
>> + memcpy(aux_buf->base + aux_buf->mem_head, aux_buf->htm_mem_buf, =
to_copy);
>> + aux_buf->mem_head =3D 0;
>> +
>> + /*
>> + * Return space_to_end to include padding.
>> + * Perf will advance head to end (wrapping to 0),
>> + * matching our mem_head position.
>> + */
>> + size =3D space_to_end;
>=20
> [Severity: Medium]
> Does this leak uninitialized padding to userspace?
>=20
> When returning space_to_end, perf will advance the ring buffer head to =
the
> end, but the gap of space_to_end - to_copy bytes is not zeroed out =
before
> being committed.
>=20
>> + } else {
>> + /* Normal case - chunk fits without crossing threshold */
>> + memcpy(aux_buf->base + aux_buf->mem_head, aux_buf->htm_mem_buf, =
to_copy);
>=20
> [Severity: High]
> Does this memcpy() write out of bounds?
>=20
> Since aux_buf->base is only initialized to the first page in =
htm_setup_aux(),
> the AUX buffer pages may not be contiguous in virtual memory.
>=20
> Could this write past the end of the first page?
>=20
>> + aux_buf->mem_head +=3D to_copy;
>> + size =3D to_copy;
>> + }
>> + } else {
>> + return 0;
>> + }
>> +
>> + /* Return non-zero to indicate that one record is written to aux =
buffer */
>> + return size;
>> +}
> [ ... ]
>> @@ -202,12 +286,17 @@ static int htm_dump_sample_data(struct =
perf_event *event)
>=20
> [Severity: Critical]
> This is a pre-existing issue, but does the htm_hcall_wrapper() call =
just
> above this corrupt physical memory?
>=20
> Because aux_buf->base is just pages[0] from rb_alloc_aux(), the memory =
is
> only physically contiguous for the length of that single allocation =
chunk.
> Passing virt_to_phys(aux_buf->base) with the full
> aux_buf->nr_pages * PAGE_SIZE size could cause the hypervisor to write =
past
> the allocated chunk into adjacent physical frames.
>=20
>> if (ret > 0) {
>> aux_buf->head +=3D (aux_buf->nr_pages * PAGE_SIZE);
>> perf_aux_output_end(&htm_ctx->handle, (aux_buf->nr_pages * =
PAGE_SIZE));
>> + return ret;
>> } else {
>> aux_buf->collect_htm_trace =3D 0;
>> - perf_aux_output_end(&htm_ctx->handle, 0);
>> }
>> }
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/20260701083806.79358-1-atrajeev@linux.ibm.c=
om?part=3D3

