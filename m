Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F38C283C93;
	Mon, 20 Jul 2026 10:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542947; cv=none; b=KslewNRJQ9xkiivjTcNY0WXwg0vUxOvhvKgyxob0Tcp85adP6A8ZdYxWg5iD9Rj9XQlx+4YF8G5QCOMHpoQGi1aRNv3ayvonWdusK9jMffSj/uO/B6N/RHE57eFPXT2HNUcjKmc7T2ed4T8dOoxkD+3BlmMv2cO90vgMSwonv3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542947; c=relaxed/simple;
	bh=tJyLH0vdy7wpU7vymTQy34I5Fbb/ygqaCCZ2CYCikN8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CuQcBljKQWJudqRMz3JWPbmYcJ1I9tznCWefONW74GKEJh+DaWn4FUoR6US7f13+iIDfXIVrJefJUn90VjvPE06TjIt5kFCkUFthRBRIbX+qQBk27Nx00TNFKROHYKZotvw+KEXhFYCaGo7KryBpnMOoACLUwdegxBFvNFbx2EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qkFW17XE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qkFW17XE"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KABsGI1908420;
	Mon, 20 Jul 2026 10:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/7wC4e
	lmH8Uc/4WB7UizFu0PHzUKD1BcwvYyvHYJg4c=; b=qkFW17XEiAxOe3owL9yTL5
	xJLFAi9CDbKpa+v+moaP5X4h/0QNmbCMl8XaCG84+yPwnX6WEjGYviwczGgjuC2s
	zQBElfqmRKruaitki7Jx7W1LZ42+dwxfzibwgNlbjRGGaqtKAW5oR8qtiVKTleNq
	c1A7pkDbeHJ38d3w76V8qSFmAut/udtcAq1sU7/NJqi0LQNOUgXC27ul7f1hto5e
	FqGdUoBgDB0+lQrji1X48j9PYCxUBPgooPfsiII+YiCQTQoa9+zaLtWkMQxXP326
	H/XAOh7ppKd8EFqTcl1F3nz4obMqr63n+J5eFO5VlcZxusGd0egXRYBTjUebBP6w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7agxp0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:22:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KAJeG4012150;
	Mon, 20 Jul 2026 10:22:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnagw3ae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:22:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KAMLc642664300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 10:22:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8984D2004B;
	Mon, 20 Jul 2026 10:22:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D357A20063;
	Mon, 20 Jul 2026 10:22:20 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.39.16.54])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 20 Jul 2026 10:22:20 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH 6/9] perf tools powerpc: Add HTM trace data processing and
 decoding support
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260701090608.C54631F00A3A@smtp.kernel.org>
Date: Mon, 20 Jul 2026 15:52:08 +0530
Cc: linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <44F1DD3A-D37D-45C1-9B49-1DCEFC7E1138@linux.ibm.com>
References: <20260701084115.80383-1-atrajeev@linux.ibm.com>
 <20260701084115.80383-7-atrajeev@linux.ibm.com>
 <20260701090608.C54631F00A3A@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XO6_s-Aaiq-TGJfyZXOomiqRp_ciPkV9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDExNCBTYWx0ZWRfXxzdlm/Nzu/33
 rb9ipz20gpYl/mR8FHZLZQXtrle1Ak6oZirv22sp16ECcJ2AYlqtjP8z1aXvHHqA5Pv7XehFHRH
 EmLW5ZBeS8jt2Ri/q1PLA6xufZNMiNOhtMmAmUM8EEGD2t54SihlCuxjYNAFsblflvqUaQ6FcPT
 Zox+KaaIZ6CU0RTJUxVlyv4He57NQPf+slgV5xAemKQJgXqAAn+FSZRdE+HUL1zO4IHXFmrQonN
 T+gxcpl7JVYMaW4Z11WgvtPxpb4Y0D+V1J5sQVk+r1muY7p3wPxrTfcfVMY6QZ7QoVKYtpKZ0xw
 h1zVYUxfj7m0xcqyTZrqO8hRgHe9mL8vdZkk6WLQX5/4Mft/JqhbpwciO24OCcsB2jUyQCa2rzU
 AfCAbf/JTtH0ToJG9C34S6trxp/eecdJplCyn9vDx7jNugbnxTKo0IlZ2U3Irk36MzDPyIMcWcm
 iOrEAuYZBgAsjlUyZCQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDExNCBTYWx0ZWRfX5pXL6IC83Vn4
 kJNmyxNuAW18/Xwc/9KiWxvLUDdhbNeEc3Kk/0XD35iux5eqaVUxmV409fVVL393FiLZVsJg/W1
 wpMitDJVgd2en79i7LLulP/LVUQY0Gw=
X-Proofpoint-GUID: XO6_s-Aaiq-TGJfyZXOomiqRp_ciPkV9
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a5df6e0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=9IG295087Qx_nqWzFtIA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200114



> On 1 Jul 2026, at 2:36=E2=80=AFPM, sashiko-bot@kernel.org wrote:
>=20
> Thank you for your contribution! Sashiko AI review found 10 potential =
issue(s) to consider:
> - [Critical] Use-after-free and inconsistent resource cleanup on error =
paths in `powerpc_htm_process_auxtrace_info()`.
> - [Critical] Out-of-bounds read and information leak in `write_htm()` =
due to missing bounds checks against `buffer->size`.
> - [High] Missing size validation before dereferencing =
`sample->raw_data`.
> - [High] Stateless queue iteration logic causes redundant processing =
and massive trace duplication.
> - [High] Missing NULL checks for `evsel` pointer and `evsel->name`.
> - [High] Missing call to `auxtrace_buffer__get_data()` causes =
`buffer->data` to be NULL when passed to `write_htm()`.
> - [High] Deadlock in child process after fork() due to =
non-async-signal-safe functions.
> - [High] Predictable filenames are created in the current working =
directory without O_EXCL or O_NOFOLLOW flags, enabling arbitrary file =
overwrites via symlink attacks.
> - [Medium] Cross-platform analysis broken due to native endianness =
assumption on raw sample data.
> - [Low] Missing explicit inclusion of POSIX standard libc headers.

V2 will have these changes:
- use after free corrections
- Boundary checks in write_htm
- Size validations
- altered queue iteration logic
- Proper flags used in file open

Thanks
Athira
> --
>=20
> commit 699e32993a6b92ec36264eeaf2b99217af504b57
> Author: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> perf tools powerpc: Add HTM trace data processing and decoding support
>=20
> This patch adds support for processing Hardware Trace Macro (HTM) =
auxiliary
> trace data collected via perf AUX buffers. It allows post-processing =
of HTM
> traces, extracting bus traces and system memory configuration. It =
integrates
> with an external htmdecode tool for trace decoding.
>=20
>> diff --git a/tools/perf/util/powerpc-htm.c =
b/tools/perf/util/powerpc-htm.c
>> index ffddf0e59fc14..487989ca4fc7d 100644
>> --- a/tools/perf/util/powerpc-htm.c
>> +++ b/tools/perf/util/powerpc-htm.c
>> @@ -14,6 +14,12 @@
>> #include <inttypes.h>
>> #include "powerpc-htm.h"
>> #include <errno.h>
>> +#include <sys/stat.h>
>> +#include <unistd.h>
>> +#include <sys/mman.h>
>> +#include "sample.h"
>> +#include <sys/types.h>
>> +#include <sys/wait.h>
>=20
> [Severity: Low]
> Does this file compile successfully against musl libc?
>=20
> This code uses POSIX standard functions and constants like open, =
O_WRONLY,
> fopen, exit, malloc, and strerror. However, it looks like the explicit
> POSIX headers (<fcntl.h>, <stdio.h>, <stdlib.h>, <string.h>) are =
missing.
> Without these explicit inclusions, compilation under musl libc might =
fail.
>=20
> [ ... ]
>> @@ -26,8 +32,140 @@ struct powerpc_htm {
>> struct machine *machine;
>> u32 pmu_type;
>> char htmbin_file[64];
>> + char trans_file[64];
>> + int htm_mem_entries;
>> + int mem_maps;
>> };
> [ ... ]
>> +static int run_htmdecode(const char *input_file, const char =
*output_file)
>> +{
>> + pid_t pid;
>> + int status;
>> +
>> + pid =3D fork();
>> + if (pid =3D=3D -1) {
>> + pr_err("fork() failed: %s\n", strerror(errno));
>> + return -errno;
>> + }
>> +
>> + if (pid =3D=3D 0) {
>> + /* Child process */
>> + int fd =3D open(output_file, O_WRONLY | O_CREAT | O_TRUNC, 0644);
>=20
> [Severity: High]
> Could creating this output file with a predictable name make it =
vulnerable to
> a symlink attack?
>=20
> If this is executed in a world-writable directory like /tmp, and a =
user
> pre-creates a symlink matching the output filename, opening it without
> O_EXCL and O_NOFOLLOW might allow an attacker to overwrite arbitrary =
files.
>=20
>> +
>> + if (fd =3D=3D -1) {
>> + pr_err("Failed to open output file: %s\n", strerror(errno));
>> + exit(1);
>> + }
>> +
>> + /* Redirect stdout to output file */
>> + dup2(fd, STDOUT_FILENO);
>> + close(fd);
>> +
>> + /* Execute htmdecode - execlp searches PATH automatically */
>> + execlp("htmdecode", "htmdecode", "-o", "-j", "-w", "1",
>> + "-f", input_file, NULL);
>> +
>> + /* If execlp returns, it failed */
>> + pr_err("Failed to execute htmdecode: %s\n", strerror(errno));
>> + if (errno =3D=3D ENOENT)
>> + pr_err("htmdecode not found in PATH\n");
>> +
>> + exit(127);  /* Standard "command not found" exit code */
>> + }
>=20
> [Severity: High]
> Is there a risk of deadlocking the child process if perf is =
multi-threaded?
>=20
> The child process calls pr_err and exit if open or execlp fails. Since
> pr_err uses fprintf and exit flushes streams, these are not
> async-signal-safe functions.
>=20
> If another thread held a libc lock, like the stderr lock or malloc =
heap
> lock, when fork was called, the child process could deadlock trying to
> acquire it. Would it be safer to use write to file descriptor 2 and
> _exit here?
>=20
> [ ... ]
>> +static int write_htm(void *data, size_t size, struct powerpc_htm =
*htm)
>> +{
>> + FILE *fp;
>> + u64 *num_entries;
>> + size_t entries;
>> + size_t written;
>> + int ret =3D -1;
>> +
>> + if (htm->mem_maps) {
>> + fp =3D fopen(htm->trans_file, "ab");
>> + if (!fp) {
>> + pr_err("Failed to open %s: %s\n", htm->trans_file, =
strerror(errno));
>> + return ret;
>> + }
>> + num_entries =3D data + 0x10;
>> + entries =3D be64_to_cpu(*num_entries);
>> + entries++;
>> + written =3D fwrite(data, 32, entries, fp);
>=20
> [Severity: Critical]
> Can this result in an out-of-bounds memory read?
>=20
> The code calculates the number of entries dynamically from data + 0x10 =
and
> then calls fwrite with entries as the count multiplier.
>=20
> If the trace data is malformed and contains an artificially large =
entry
> count, it seems we could write gigabytes of out-of-bounds heap or =
mapped
> memory to the file without verifying that the requested write length =
is
> bounded by the size parameter.
>=20
>> + if (written !=3D entries) {
>> + pr_err("Failed to write data: expected %zu, wrote %zu\n", entries, =
written);
>> + fclose(fp);
>> + return ret;
>> + }
>> + fclose(fp);
>> + htm->htm_mem_entries +=3D entries;
>> + return 0;
>> + }
> [ ... ]
>> static int powerpc_htm_process_event(struct perf_session *session =
__maybe_unused,
>> union perf_event *event,
>> struct perf_sample *sample __maybe_unused,
>> const struct perf_tool *tool __maybe_unused)
>> {
>> + struct powerpc_htm *htm =3D container_of(session->auxtrace, struct =
powerpc_htm,
>> + auxtrace);
>> +
>> + if ((event->header.type =3D=3D PERF_RECORD_SAMPLE) && =
sample->raw_data) {
>> + int *content =3D (int *)sample->raw_data;
>=20
> [Severity: High]
> Could casting sample->raw_data to an integer pointer cause an =
out-of-bounds
> read if the raw data is smaller than sizeof(int)?
>=20
> Should we verify that sample->raw_size is at least 4 bytes before
> dereferencing it?
>=20
>> + struct evsel *evsel =3D evlist__event2evsel(session->evlist, =
event);
>> + int config =3D (evsel->core.attr.config) & 0xF;
>=20
> [Severity: High]
> Is it possible for evlist__event2evsel to return NULL here?
>=20
> If it fails to find a matching event for the sample, dereferencing =
evsel
> immediately in the config assignment would cause a crash.
>=20
>> + struct auxtrace_buffer *buffer =3D NULL;
>> + struct auxtrace_queues *queues =3D &htm->queues;
>> + unsigned int i =3D 0;
>> + int j =3D 0;
>> +
>> + if (strstr(evsel->name, "htm") =3D=3D NULL)
>> + return 0;
>=20
> [Severity: High]
> Is it guaranteed that evsel->name is non-NULL?
>=20
> If the event is unnamed, passing evsel->name directly to strstr might
> trigger a NULL pointer dereference.
>=20
>> +
>> + for (i =3D 0; i < queues->nr_queues; i++) {
>> + buffer =3D auxtrace_buffer__next(&queues->queue_array[i], buffer);
>> + for (; buffer;) {
>> + if (j >=3D *content)
>=20
> [Severity: Medium]
> Does this code handle cross-endian analysis correctly?
>=20
> The trace data is read directly into content as a native integer. If a
> trace recorded on a big-endian system is analyzed on a little-endian
> host, it seems the value will have the wrong byte order and the
> comparison here will evaluate incorrectly.
>=20
>> + htm->mem_maps =3D 1;
>> + if (write_htm(buffer->data, buffer->size, htm))
>=20
> [Severity: High]
> Is it possible for buffer->data to be NULL here?
>=20
> Because the auxtrace subsystem lazily maps file payloads, passing
> buffer->data directly to write_htm without calling
> auxtrace_buffer__get_data first might pass a NULL pointer, leading to =
a
> crash when it is dereferenced inside write_htm.
>=20
> [Severity: High]
> Does this loop iteration lead to massive data duplication?
>=20
> The code iterates over all auxtrace_buffer elements starting from the
> queue head for every PERF_RECORD_SAMPLE event. Because buffers aren't
> marked as processed or dequeued, subsequent events will cause the same
> buffers to be appended to the output files multiple times.
>=20
>> + return -1;
>> + j++;
>> + buffer =3D auxtrace_buffer__next(&queues->queue_array[i], buffer);
>> + }
>> + }
>> + /* Only for power bus traces, we decode traces */
>> + if (config =3D=3D 1)
>> + create_mem_maps(htm);
>> + }
>> +
>> return 0;
>> }
> [ ... ]
>> @@ -205,6 +420,14 @@ int powerpc_htm_process_auxtrace_info(union =
perf_event *event,
>> }
>> fclose(fp);
>>=20
>> + snprintf(htm->trans_file, sizeof(htm->trans_file), =
"translation.n%d.p%d.c%d", nodeindex, nodalchipindex, coreindexonchip);
>> + fp =3D fopen(htm->trans_file, "w");
>=20
> [Severity: High]
> Are we vulnerable to symlink attacks here by using predictable =
filenames?
>=20
> Creating files with predictable names like translation.n%d.p%d.c%d =
using
> fopen with the w flag without O_EXCL could allow arbitrary file
> overwrites if run in a shared directory.
>=20
>> + if (!fp) {
>> + pr_err("Failed to create %s: %s\n", htm->trans_file, =
strerror(errno));
>> + return -errno;
>=20
> [Severity: Critical]
> Does returning directly here leak the htm struct allocated earlier in =
the
> function?
>=20
> Additionally, if the function jumps to the err_free label on other =
error
> paths, such as when powerpc_htm_synth_events fails, does it bypass the
> session->auxtrace =3D NULL assignment?
>=20
> If session->auxtrace was set to &htm->auxtrace, leaving a dangling
> pointer could cause a use-after-free when the session is later deleted
> via perf_session__delete.
>=20
>> + }
>> + fclose(fp);
>> +
>> powerpc_htm_print_info(&auxtrace_info->priv[0]);
>>=20
>> err =3D auxtrace_queues__process_index(&htm->queues, session);
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/20260701084115.80383-1-atrajeev@linux.ibm.c=
om?part=3D6

