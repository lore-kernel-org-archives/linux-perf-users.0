Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E34175A7D;
	Fri, 24 Jul 2026 09:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784886415; cv=none; b=WxeR7dxUFbw2wt+13x2DAgC/fRq5ToSLQ2YxkR6I/b1ydvw+xegX/f5TRbVrl59B+Gst0hRp35H/6B5e8WiVdi9Rw9T6/cEv10i55Ig0MhlddxtquMtggCKEtkGLpa0vorPPJESFd2FXx9m+bSzlUtd87emPTCcOUg1EdwAS5/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784886415; c=relaxed/simple;
	bh=eDUGNUcFZofwxCAR51TR0y9vzXA7d/GtW7FVAHo7ec8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iMxQhAiwOqtGuGD2tOcazpWZk8aN3mZQV4SMFIGl9kuGpWV7+uvkLnI6EsenJ9QxnU9iuG8q5X7/mdtFYhRrHbq9rfJEDK5BgEFivnC5ZtHbYfvsTzx8AsHmvpzSZtShtqYSJKwxsKKGhp8C6Fi4uoumwphCBRbvQnE53/nQa9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rVdgyygI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rVdgyygI"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O5BlO8913979;
	Fri, 24 Jul 2026 09:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=laIjlm
	re828z89Mqb6vKrOokTQax9FALSarE/leJvkQ=; b=rVdgyygI5JyP2LOGWNxeUM
	NRJOBxwJsPPXr51lI6l+08fxgjBf0qvsBd+mUm0W1Jzvld6EmKNcBmJbQ/x4dCA6
	h9vloCxYUO7K8Gq6jMLw4mzOmMNa8RMYOLrbYlkrEKU4/m03VIfn4RT/3n0q2Jnj
	zAxHw3k1R6Pe+rZBJk2EvcLKc0ksmLExUyJqLZ6whzEg8lHI6TrhavjDjxjwp3sE
	ZeHIR8g9VyGf0T8fOFCwCyU7IXrKozjENs78q0TsQ0DvaK32eX7WgM0CNNl7xTLq
	YpbBrvPqgFt+JmigWW+iD/m68EbmGXMRfsI2RXlnUsro7BH3P6N7dBWwlB1Q6CGg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahkcrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 09:46:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O9Yk4M021950;
	Fri, 24 Jul 2026 09:46:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktqggn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 09:46:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66O9knN730998970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 09:46:50 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02B2120126;
	Fri, 24 Jul 2026 08:53:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2562620124;
	Fri, 24 Jul 2026 08:53:16 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.222.110])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 Jul 2026 08:53:15 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH V2 6/6] tools/perf: Add perf tool support for processing
 powerpc HTM AUXTRACE records
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260720112522.8773F1F00A3A@smtp.kernel.org>
Date: Fri, 24 Jul 2026 14:23:04 +0530
Cc: linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FCD79555-2F49-48B3-A2F1-69013C3FE53B@linux.ibm.com>
References: <20260720105218.14277-1-atrajeev@linux.ibm.com>
 <20260720105218.14277-7-atrajeev@linux.ibm.com>
 <20260720112522.8773F1F00A3A@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: op6_BR2RdxW8WSPIOSBB1xnSSzr9mHbD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA4OCBTYWx0ZWRfX1QahDWSCoVle
 lfy6pRp3CLBR4L4APItabNn5FqpCr5WM5b4A1npl9+yLNx/tMakFVjDD+JVj92tDz2+EoiD9mnN
 c7sJrhHLWL2VEF8JVuWuWBjf4wHqGnN9+cd0Ql/LnsKUbYkKK3Pnux87GuRnGl+6Ei5kEAMI2BL
 pj9UJrh3Yr+pA3824t/HddGiODEvui+4YVdzRq+ngcGI8w8p8/xucudraDRht8Zo8IkiN6RqWDy
 fwkg3KuG9ihQWp+izsFN4WB1QTBCh+RLKL+tB+8puHk95B92ckvZ5bGMfTo57Gyyvpk+KHI5o5Z
 7NQmdLoytMT3NFT6mSPHr+1oMp3LL5AQHNth0SZQHrj+ZqF8QGdCDSTmD1t9cvGUNBjakJ9mo9V
 GbPah6EGCYSK+DLEHUykl9FBDVmcIj6gzs0U6vNw2NgkgTVy6C/3fryLuvedL19vamD739unjlv
 XDMov6ANXSE0Q+OzQ6w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA4OCBTYWx0ZWRfXz8lKWGLWwCgK
 t+2VRCxFaJCu2Kik23fLhU8ankZVZMDP8wG7fEhvZ0aaDDmNrDw+/t4IB03WnT1lP0A8QRiUNqb
 3F+m4V3iS9CRQaF3ZGh8fJoG3TlFVTY=
X-Proofpoint-GUID: op6_BR2RdxW8WSPIOSBB1xnSSzr9mHbD
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a63348c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=VYsm0-0aGKd7-Twe8VMA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240088



> On 20 Jul 2026, at 4:55=E2=80=AFPM, sashiko-bot@kernel.org wrote:
>=20
> Thank you for your contribution! Sashiko AI review found 7 potential =
issue(s) to consider:
> - [High] Incorrect return value in `htm_target_seen()` causes trace =
file truncation instead of appending when target capacity is exceeded.
> - [High] Missing bounds check on dynamic array portion of =
`auxtrace_info` leads to out-of-bounds read.
> - [High] Integer underflow when processing `sample->raw_size` leads to =
bypassed length checks and out-of-bounds read.
> - [High] Direct dereferencing of a 64-bit pointer causes unaligned =
memory access.
> - [High] Integer truncation on 32-bit platforms leads to a severe heap =
buffer overflow.
> - [Medium] Processing multiple AUXTRACE_INFO events overwrites =
`session->auxtrace`, leaking memory.
> - [Low] Missing explicit POSIX libc header inclusions causes musl libc =
build failures.
> --
>=20
> --- Patch [6]: [PATCH V2 6/6] tools/perf: Add perf tool support for =
processing powerpc HTM AUXTRACE records ---
> commit 30554a3a06e5c4703030155cf5ee8abbdc6f50e6
> Author: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> tools/perf: Add perf tool support for processing powerpc HTM AUXTRACE =
records
>=20
> This commit adds perf tool support for processing powerpc HTM AUXTRACE =
records.
> It introduces logic to map CPU configurations to trace targets and =
writes HTM
> data directly to files. Memory configuration records are also =
extracted from
> raw sample data and processed.
>=20
>> diff --git a/tools/perf/util/powerpc-htm.c =
b/tools/perf/util/powerpc-htm.c
>> index 8d28d02031d6e..28166f7f7463b 100644
>> --- a/tools/perf/util/powerpc-htm.c
>> +++ b/tools/perf/util/powerpc-htm.c
>> @@ -11,9 +11,12 @@
>> #include "util/session.h"
>> #include "color.h"
>> #include "powerpc-htm.h"
>> +#include <errno.h>
>> #include "debug.h"
>> #include "sample.h"
>>=20
>> +struct perf_session;
>> +
>=20
> [Severity: Low]
> Will this fail to compile on musl libc? The code uses POSIX standard =
functions
> like open, write, close, calloc, and snprintf, but standard headers =
like
> <fcntl.h>, <unistd.h>, <stdlib.h>, <stdio.h>, and <string.h> are not =
included.
Thanks for the feedback

I will be sending a V3 with these changes
>=20
> [ ... ]
>=20
>> +static bool htm_target_seen(u32 *targets, int *nr, int capacity, u32 =
key)
>> +{
>> + int i;
>> +
>> + for (i =3D 0; i < *nr; i++) {
>> + if (targets[i] =3D=3D key)
>> + return true;
>> + }
>> +
>> + if (*nr < capacity)
>> + targets[(*nr)++] =3D key;
>> + else
>> + pr_warning("htm: too many targets (max %d), appending to existing =
file\n",
>> +   capacity);
>> +
>> + return false;
>> +}
>=20
> [Severity: High]
> If we exceed the target capacity, does this return false and =
inadvertently
> truncate the file? The warning message states it is appending, but a =
false
> return causes write_htm() to select O_TRUNC instead of O_APPEND.
>=20
Sure will fix this
> [ ... ]
>=20
>> +static int write_htm(struct powerpc_htm *htm, void *data, size_t =
size,
>> +     u32 node, u32 chip, u32 core, int mem_maps)
>> +{
>> + u32 target_key =3D htm_pack_target(node, chip, core);
>> + char target_file[128];
>> + size_t written;
>> + int flags;
>> + int fd;
>> +
>> + if (!data || !size)
>> + return -EINVAL;
>> +
>> + flags =3D O_CREAT | O_WRONLY | O_NOFOLLOW | O_CLOEXEC;
>> +
>> + if (mem_maps) {
>> + uint8_t *byte_ptr =3D (uint8_t *)data;
>> + __be64 *num_entries_ptr;
>> + size_t entries;
>> + size_t payload;
>> +
>> + if (size < HTM_MEM_ENTRY_SIZE) {
>> + pr_err("Malformed memory mapping entry trace segment\n");
>> + return -EINVAL;
>> + }
>> +
>> + /* Entry count is at offset 0x10; add 1 for the 32-byte header */
>> + num_entries_ptr =3D (__be64 *)(byte_ptr + 0x10);
>> + entries =3D be64_to_cpu(*num_entries_ptr) + 1;
>=20
> [Severity: High]
> Can this dereference cause a SIGBUS on architectures with strict =
alignment
> requirements? Since byte_ptr comes from sample->raw_data, it might =
only be
> 4-byte aligned due to the preceding u32 raw_size in the header. Should =
this
> use get_unaligned_be64() instead?

Ok, will fix to use get_unaligned_be64()
>=20
> [ ... ]
>=20
>> +static int powerpc_htm_process_event(struct perf_session *session,
>> +     union perf_event *event,
>> +     struct perf_sample *sample,
>>     const struct perf_tool *tool __maybe_unused)
>> {
>> + struct powerpc_htm *htm;
>> + struct evsel *evsel;
>> + u32 node, chip, core;
>> + u64 ev_config;
>> +
>> + if (!session || !session->auxtrace || !event || !sample)
>> + return 0;
>> +
>> + if (event->header.type !=3D PERF_RECORD_SAMPLE || =
!sample->raw_data)
>> + return 0;
>> +
>> + htm =3D container_of(session->auxtrace, struct powerpc_htm, =
auxtrace);
>> + evsel =3D evlist__event2evsel(session->evlist, event);
>> +
>> + if (!evsel || strcmp(evsel__pmu_name(evsel), "htm") !=3D 0)
>> + return 0;
>> +
>> + ev_config =3D evsel->core.attr.config;
>> + node =3D (ev_config >> 4)  & 0xff;
>> + chip =3D (ev_config >> 12) & 0xff;
>> + core =3D (ev_config >> 20) & 0xff;
>> +
>> + /*
>> + * raw_size includes 4 bytes of u64 alignment padding added by the
>> + * kernel.  Subtract sizeof(u32) to recover the true payload byte =
count.
>> + */
>> + if (write_htm(htm, sample->raw_data,
>> +      sample->raw_size - sizeof(uint32_t),
>> +      node, chip, core, 1) < 0) {
>=20
> [Severity: High]
> If sample->raw_size is smaller than 4 (e.g., 0), does this unchecked
> subtraction underflow to a massive positive size_t value? If so, this =
massive
> size will bypass the boundary check in write_htm(), leading to =
out-of-bounds
> reads when evaluating the entry count.
Right point, will fix this
>=20
> [ ... ]
>=20
>> int powerpc_htm_process_auxtrace_info(union perf_event *event,
>>      struct perf_session *session)
>> {
>> struct perf_record_auxtrace_info *auxtrace_info =3D =
&event->auxtrace_info;
>> struct powerpc_htm *htm;
>> + u64 num_events;
>> + u64 i;
>> int err;
>>=20
>> if (auxtrace_info->header.size < sizeof(struct =
perf_record_auxtrace_info) +
>> HTM_AUXTRACE_PRIV_FIXED)
>> return -EINVAL;
>=20
> [Severity: High]
> Does this size check fail to validate the variable-length dynamic =
array of
> num_events pairs? If the payload provides a small header.size but a =
large
> num_events value, the subsequent initialization loop might read =
completely out
> of bounds of the memory mapped event buffer.
>=20
>>=20
>> + htm =3D zalloc(sizeof(struct powerpc_htm));
>> + if (!htm)
>> + return -ENOMEM;
>=20
> [Severity: Medium]
> If a perf.data file contains multiple POWERPC_HTM auxtrace info =
events, does
> this blindly allocate a new powerpc_htm structure and overwrite
> session->auxtrace later? This would lead to a memory leak of the =
previous
> context during session teardown.

V3 will have a check for session->auxtrace
>=20
>>=20
>> err =3D auxtrace_queues__init(&htm->queues);
>> if (err) {
>> free(htm);
>> return err;
>> }
>>=20
>> + htm->auxtrace_type =3D auxtrace_info->priv[POWERPC_HTM_PMU_TYPE];
>> + num_events =3D auxtrace_info->priv[POWERPC_HTM_NUM_EVENTS];
>> +
>> + /*
>> + * All three arrays are sized to num_events, the exact count of HTM
>> + * targets written by htm_info_fill() at record time.  This replaces =
the
>> + * old compile-time HTM_MAX_TARGETS constant so the limit is always
>> + * consistent with what was actually recorded.
>> + */
>> + htm->nr_targets   =3D (int)num_events;
>> + htm->cpu_configs  =3D calloc(num_events, =
sizeof(*htm->cpu_configs));
>> + htm->htm_bin_targets    =3D calloc(num_events, =
sizeof(*htm->htm_bin_targets));
>> + htm->translation_targets =3D calloc(num_events, =
sizeof(*htm->translation_targets));
>=20
> [Severity: High]
> On 32-bit platforms, does the 64-bit num_events value get implicitly
> truncated by the 32-bit size_t argument in calloc()? If truncated, the
> subsequent loop using the full 64-bit num_events limit could cause a =
severe
> heap buffer overflow.
Will address this in next version

Thanks
Athira
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/20260720105218.14277-1-atrajeev@linux.ibm.c=
om?part=3D6

