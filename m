Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C46298CAB;
	Sun, 26 Jul 2026 08:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785054041; cv=none; b=CRc+OjPGySlviUlN8DF53Kvl5H4Qw4SpiF9RH0TdWIiJpwDP+8bKIWHWOReiLB313PD6di3sVNMwke/gLDnCq1FU8w9RazWtReZZdpuWc5ZTPttgrUxNlu5awBVcie+oCYmKuiPp2XbfbUk9a2VgP6M7jbGM/HZytEtRsdh2mS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785054041; c=relaxed/simple;
	bh=724/eNGuHhRCLHlHj6oIXjEspKoT7FNKPn0Ip2YYedk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TVKduGSZR5FHnJkTO8lFKNAraNwtdwPD+meCTWoTIiLoHik+e/JqotC9ETjWDvZgICWsUfYQCZHNldcxq8xrUuhMfWz+ngCDKKKOCvzpZmPkSvAmu1ZeqCCNLzMaa4HXORICYChDQKN86pNuVb4f4Sc3JqbbYbnGkYCM1zsB/2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qvEfLk/Z; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qvEfLk/Z"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66Q8IrNF3014760;
	Sun, 26 Jul 2026 08:20:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=d4+wKw
	N/AmKLj/FOyoOm48QzQqzeVtBedUZzr7G9gFU=; b=qvEfLk/ZYmkRalzeMVmqB3
	gXGADrakjiT+ilVFJcVhnCDSfvz/SXD46k5Hp3KJAK0cDnFlt2wPmWHpEKIkGLlJ
	UB1Rrb2Pjzf4AczMytPfaS22EPftR7ejIoT2bqnkC6S/sON/EL/lMgvXHZJOGKDJ
	cPBO6QcR/8SRMTkgaCh2tGqzYOlfxVv5CV4IU8LbFzrAjSaJksbiBYa8qz6guilr
	xKcqiKDyMhdiQhpaJadRQL8xL2BS/29zITS50ZYQ9J9DERO2lCqgwnnSlUWDO8R5
	45Y4P5isEoQZ60BZWn5nC3n2FHfZ1Vsm93jscJswd9l7makJgPcVuJKAS5Hg0KMg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcjueq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 08:20:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66Q8BJGT028557;
	Sun, 26 Jul 2026 08:20:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xrp2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 08:20:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66Q8KZHI49873208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jul 2026 08:20:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50CB520098;
	Sun, 26 Jul 2026 08:20:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A89FA20097;
	Sun, 26 Jul 2026 08:20:34 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.223.95])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 26 Jul 2026 08:20:34 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH V3 6/6] tools/perf: Add perf tool support for processing
 powerpc HTM AUXTRACE records
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260725072226.70E471F000E9@smtp.kernel.org>
Date: Sun, 26 Jul 2026 13:50:22 +0530
Cc: linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <ECBED305-908E-4036-9B10-23847ED62999@linux.ibm.com>
References: <20260725070747.81435-1-atrajeev@linux.ibm.com>
 <20260725070747.81435-7-atrajeev@linux.ibm.com>
 <20260725072226.70E471F000E9@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 59CMYSUd8X_cMdhhJn19neuz9FOt_tWm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDA4MSBTYWx0ZWRfXwhIgOYrvFIEZ
 +TFM+AkoMrA5qlIq4BmEy+v0tcuMo9JMoGabwpx75ERHluIksAto9MhGcZbwMvvmeADJsjORwdF
 MPO9ereTIzbZwsjnp6L6A1cCYJ4K0yo=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a65c355 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=LBZ2wTadPQuSBPb3bYIA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDA4MSBTYWx0ZWRfX9zogoBqVh25A
 h98PZCcM+nU/sJ0KOtLWLLMrSE2j3FYbcaZUNCVU9r48Cd5UKaP838zvANsYkf5baYrdeDjd4Rf
 FclO2J+npxKX2LTxU8+n5osNoRIjh90qd7EYEADRvos/hRyInM6vI1NDwtCbFe9vx5+WwtuuiWl
 artE+iUyRHEQzqUyLqKhsMwM2ZZWPseXqnh0YGYCZ+P9IDLNyB2eqAPdGxdssNflwOmrW0L29xQ
 CqbJzCUyBkX+Sp+tl58KlHAgMVGOmpL0qsVxuNzXMcfFIZAHljmACL1WVkwPJ2x/2Tm8dB0HSoO
 70q+/IhAtSaWrAl7Xb4iiVl/JctqYCge9xqaYjXw7ghvjN7uuQqVvSX/mEqbQ0OUItTXRTY7Bnx
 wU9neo59dBZQ6sc2IRCDnjCkpJt51Iubx07cA5EejzgWlbgzax4WcuOi1ijRVYqN/oJaoaeZF2v
 BZCXCWlwIeqnVIcWgkg==
X-Proofpoint-GUID: 59CMYSUd8X_cMdhhJn19neuz9FOt_tWm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260081



> On 25 Jul 2026, at 12:52=E2=80=AFPM, sashiko-bot@kernel.org wrote:
>=20
> Thank you for your contribution! Sashiko AI review found 4 potential =
issue(s) to consider:
> - [Medium] The implementation is missing the HTM_MAX_SAFE_TARGETS =
(1024) cap for num_events that was explicitly promised in the commit =
message.
> - [Medium] htm_config_for_cpu conflates a lookup failure with a valid =
0 PMU configuration, causing valid auxtrace events to be dropped.
> - [Low] Assigning write() return value to a size_t variable masks the =
actual error code and produces misleading log messages.
> - [Low] Missing explicit inclusion of POSIX standard headers required =
for musl libc compatibility.
> --
>=20
> --- Patch [6]: [PATCH V3 6/6] tools/perf: Add perf tool support for =
processing powerpc HTM AUXTRACE records ---
> commit b319ae58a675d493de8d8d9853fc6d781771f6b8
> Author: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> tools/perf: Add perf tool support for processing powerpc HTM AUXTRACE =
records
>=20
> powerpc_htm_process_auxtrace_info() reads the (cpu, attr.config) pairs
> stored by htm_info_fill() at record time and builds a cpu_configs[]
> table.  This lets process_auxtrace_event() map each AUX buffer, which
> carries event->auxtrace.cpu, to the correct (node, chip, core) target
> and write the raw trace data to htm.bin.nX.pX.cX immediately.
>=20
> [ ... ]
>> - Cap num_events at HTM_MAX_SAFE_TARGETS (1024) to prevent size_t
>> truncation on 32-bit platforms when passed to calloc().
>=20
> [Severity: Medium]
> This isn't a bug, but the commit message mentions capping num_events =
at 1024
> (HTM_MAX_SAFE_TARGETS).
>=20
> Looking at powerpc_htm_process_auxtrace_info(), the arrays are =
allocated
> using num_events directly:
>=20
> tools/perf/util/powerpc-htm.c:powerpc_htm_process_auxtrace_info() {
>    ...
>    htm->nr_targets   =3D (int)num_events;
>    htm->cpu_configs  =3D calloc((size_t)num_events, =
sizeof(*htm->cpu_configs));
>    ...
> }
>=20
> Has the 1024 maximum cap and truncation prevention logic been omitted =
here?
Thanks for all the comments

I will update commit message
>=20
>> diff --git a/tools/perf/util/powerpc-htm.c =
b/tools/perf/util/powerpc-htm.c
>> index 952ed32997d9a..1d1b4302e2e4a 100644
>> --- a/tools/perf/util/powerpc-htm.c
>> +++ b/tools/perf/util/powerpc-htm.c
>> @@ -12,9 +12,14 @@
>> #include "util/session.h"
>> #include "color.h"
>> #include "powerpc-htm.h"
>> +#include <errno.h>
>> #include "debug.h"
>> #include "sample.h"
>>=20
>> +#include <linux/unaligned.h>
>> +
>> +struct perf_session;
>=20
> [Severity: Low]
> Are the standard POSIX headers missing here?
>=20
> The code uses functions like open(), write(), lseek(), snprintf(), =
strerror(),
> calloc(), and free().
>=20
> Without explicitly including fcntl.h, unistd.h, stdio.h, string.h, and
> stdlib.h, could this fail to compile on systems using musl libc due to
> relying on implicit header inclusions?
These are added patch 5 already
>=20
> [ ... ]
>> +/*
>> + * Look up attr.config by the CPU number carried in =
event->auxtrace.cpu.
>> + * Returns 0 if not found.
>> + */
>> +static u64 htm_config_for_cpu(struct powerpc_htm *htm, int cpu)
>> +{
>> + int i;
>> +
>> + for (i =3D 0; i < htm->nr_cpu_configs; i++) {
>> + if (htm->cpu_configs[i].cpu =3D=3D cpu)
>> + return htm->cpu_configs[i].config;
>> + }
>> + return 0;
>> +}
>=20
> [Severity: Medium]
> Can a valid configuration evaluate to 0?
>=20
> If the HTM PMU is configured with node=3D0, chip=3D0, core=3D0 and no =
other flags,
> attr.config could legitimately be 0.
>=20
> If it returns 0, the caller powerpc_htm_process_auxtrace_event() =
checks:
>=20
> tools/perf/util/powerpc-htm.c:powerpc_htm_process_auxtrace_event() {
>    ...
>    ev_config =3D htm_config_for_cpu(htm, (int)event->auxtrace.cpu);
>    if (!ev_config) {
>        ...
>        return 0;
>    }
>    ...
> }
>=20
> Would this cause valid auxtrace events to be dropped by conflating a =
lookup
> failure with a valid 0 PMU configuration?
Will fix this logic in V4

Thanks
Athira
>=20
> [ ... ]
>> +static int write_htm(struct powerpc_htm *htm, void *data, size_t =
size,
>> +     u32 node, u32 chip, u32 core, int mem_maps)
>> +{
>> + u32 target_key =3D htm_pack_target(node, chip, core);
>> + char target_file[128];
>> + size_t written;
>> + int flags;
>> + int fd;
> [ ... ]
>> + written =3D write(fd, data, payload);
>> + close(fd);
>> +
>> + if (written !=3D payload) {
>> + pr_err("Failed to write memory config: expected %zu bytes, wrote =
%zu\n",
>> +       payload, written);
>> + return -EIO;
>> + }
>> +
>> + return 0;
>> + }
>> +
>> + /* AUX bus-trace path */
>> + snprintf(target_file, sizeof(target_file),
>> + "htm.bin.n%d.p%d.c%d", node, chip, core);
>> + flags |=3D htm_target_seen(htm->htm_bin_targets,
>> + &htm->nr_htm_bin_targets,
>> + htm->nr_targets,
>> + target_key) ? O_APPEND : O_TRUNC;
>> + fd =3D open(target_file, flags, 0644);
>> + if (fd =3D=3D -1) {
>> + pr_err("Failed to open %s: %s\n", target_file, strerror(errno));
>> + return -errno;
>> + }
>> +
>> + written =3D write(fd, data, size);
>> + close(fd);
>> +
>> + if (written !=3D size) {
>> + pr_err("Failed to write htm trace data: expected %zu bytes, wrote =
%zu\n",
>> +       size, written);
>> + return -EIO;
>> + }
>> +
>> + return 0;
>> +}
>=20
> [Severity: Low]
> Does this code assign the signed return value of write() to a size_t =
variable?
>=20
> If write() fails and returns -1, it will be assigned to size_t =
written,
> wrapping it to SIZE_MAX.
>=20
> While the error is still caught by the written !=3D payload and =
written !=3D size
> checks, will this result in logging an impossibly large value for =
bytes written
> and mask the actual error code?
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/20260725070747.81435-1-atrajeev@linux.ibm.c=
om?part=3D6

