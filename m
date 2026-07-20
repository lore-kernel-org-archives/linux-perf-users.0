Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F783B7750;
	Mon, 20 Jul 2026 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537594; cv=none; b=af6+GxAEEGKyiBlGIeWwcHP3vUAd+LFUxHb3I+y05HkKxtPLLMxnfWTFYVxI5aBCy8XnPChlSwM/o2ZcqHrGmb/ZiEFvwk0efmDyYPGn+TXTwPaK0scDuDKnkW0PJ66JrYWhPTsUcjQJkMKiq7dbR4Kc0zZr+9QIGdK7DeGu9bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537594; c=relaxed/simple;
	bh=pwpSmfIszZVG1QbqAmZm2FDblzgDUxBTWMqVh3ruwIw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=J8TFC0/8zJOD4enC/1E8cJDi2EDFsrnMnnIYaUXohrI0NthVMPLofyIOHHmMDI80D6AfrZbxg4sitBSD21RnLwqILgRQe4zevqeYzaiEdXNJGy9YX3qFkGQBVXA0LbZXTV46mtLzw3XX3JE92R0YKRi0mQz37nJpteiC2BcxoTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d5mX4OFh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d5mX4OFh"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6gJEp1471783;
	Mon, 20 Jul 2026 08:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iWWu7m
	QsR3tM83MWCID5TAEDXQhLoZsiLCZaC0NolSI=; b=d5mX4OFhRlqD9AwE8Dobjn
	Sx8Wza4t4w2YBhHJVESyvA/SiNCBxhS9b0L2dSRTTHYaG3Kv02UbOeCTcZNwGdNx
	jVDqAEnXx5DkGx2B7mKivw3Zrd/DB1SHsZPe9kjfAgbJ020meLkmkqPZxElPWsaz
	XnrdOKyWODbNsAXN2j2QajZUQ0aaqpIyEIQ9TPKSy4k3uyGRgtpGsInVOB388HRq
	lfSAYkhMJKCNt/fnybNJBCD3jExPcBl+C3xdKc4mjAVMHUT0EEzV9rQWWtz+8K8J
	7fiexGmfo+b87a3YWWWElx17xB6EMSD4eBmlf3hcM2WdhiHpcXI4ngo7H8MzwNtQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg790pkh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 08:53:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66K8nb9l013143;
	Mon, 20 Jul 2026 08:53:10 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnagvrsg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 08:53:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66K8r8RO53477828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 08:53:08 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 763A72004B;
	Mon, 20 Jul 2026 08:53:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5EC020043;
	Mon, 20 Jul 2026 08:53:07 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.39.16.54])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 20 Jul 2026 08:53:07 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH 3/9] tools/perf: Add arch_record__collect_final_data to
 collect additional data before closing the event
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260701085454.8ECCB1F000E9@smtp.kernel.org>
Date: Mon, 20 Jul 2026 14:22:55 +0530
Cc: linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5C291435-7940-49C7-92AC-47219665011D@linux.ibm.com>
References: <20260701084115.80383-1-atrajeev@linux.ibm.com>
 <20260701084115.80383-4-atrajeev@linux.ibm.com>
 <20260701085454.8ECCB1F000E9@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rzVpeluJlBYS4tqBsDkfm24sxihHiFks
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a5de1f7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sb3nUQvwxnNj9nUj:21 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=c92rfblmAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=EvvSA9XnrJP2oyhSO5EA:9
 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfX5AkUUiC5bo/g
 9M+fgtkVLvYkc8MyfJNvLzoNPbnhpVpDmhK3kACYiJyhZoRWTuZV0hIvXspFNc2oMF+Fwef5yjJ
 B7T9Kh0eeL1dqMb9ZEKxOvjb+giChk0=
X-Proofpoint-GUID: rzVpeluJlBYS4tqBsDkfm24sxihHiFks
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfX1PA2xXbiP0+2
 sw+987SVhZBqn7wgRr8CyWa0odVQSL58xshSFuaIuK3tlwzFdGX9pzR/o9XSYhLb1M7P8iAw3AZ
 0W1goIQVFtcFBYfQq1JWHRmHk70Cg75ce7LBGSX2PIIltwYqq6locWSNz0ejtg6ex7tPQl9BbMG
 5Ii3ABnm0NTUm7IN5pmdzpIncInpPlbYJ9kXJwC47YhTIIB2kH5H/hg2MyAs86fUEpbcGxAh635
 YYcZD3wNgFPBY9ahRUKIW0U/Ggm+MnA+uyPPn2/TvEdAzgiNQEuvna8PY/m61rjbHQOrQIdOcJc
 VJE/tLCTYSVdQyCGKIHDP+zR/WHQx7pAagyEF8JJgM+RdlI2VL+fdClzRb5gLuOSXg6J8IkmtfO
 Xd+RpDO+FR+RZ+YfzWaLz0OODd2wAuntnS7SCSugYUh2Q/mZ+g+9wEbKjPci7DxkTXpxL3H/AsG
 e0Mm2/KJPPftlB5f/Pw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200096



> On 1 Jul 2026, at 2:24=E2=80=AFPM, sashiko-bot@kernel.org wrote:
>=20
> Thank you for your contribution! Sashiko AI review found 6 potential =
issue(s) to consider:
> - [High] `record__final_data` implements a defective busy-wait loop =
that causes CPU pegging and infinite loops.
> - [High] Redundant and potentially harmful calls to `evlist__enable` =
during the shutdown phase.
> - [High] Collection of final architecture-specific data is randomly =
skipped due to an early loop break race condition.
> - [High] Final data collection is completely omitted when tracing =
child workloads.
> - [Low] Unnecessary full header inclusions in `record.h` violate =
subsystem guidelines.
> - [Low] The function name mentioned in the commit message does not =
match the actual code implementation.

Thanks for the valuable feedback
I will send a V2 with changes:
- Avoid evlist__enable() calls
- Handle proper check to prevent busy wait loop
- Handle full header inclusions in record.h
- Correct commit message

Thanks
Athira
> --
>=20
> commit 4b101c454c9b203ae14e9902eb253bcd6be33523
> Author: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> tools/perf: Add arch_record__collect_final_data to collect additional =
data before closing the event
>=20
> While collecting samples using "perf record", function
> "__cmd_record" checks if monitoring is done. Once recording
> is done, event list will be disabled using "evlist__disable".
> After this, event fd won't be read and event will be removed.
>=20
> Before removing the event, if any additional data needs
> to be captured/written to perf.data, currently its not
> possible. Introduce arch_record__collect_final_data to
> collect additional data before closing the event
>=20
>> Introduce arch_record__collect_final_data to
>> collect additional data before closing the event
>=20
> [Severity: Low]
> This isn't a bug, but the commit message mentions introducing
> arch_record__collect_final_data, but the function added is actually =
named
> arch_perf_record__need_read.
>=20
>> diff --git a/tools/perf/builtin-record.c =
b/tools/perf/builtin-record.c
>> index e915390556752..a60bc039401a2 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -2425,6 +2425,34 @@ static unsigned long record__waking(struct =
record *rec)
>> return waking;
>> }
>>=20
>> +/*
>> + * Weak symbol - architecture can override to indicate if more
>> + * data needs to be collected before finishing output.
>> + *
>> + * Returns: 1 if more data exists, 0 if collection is complete
>> + */
>> +__weak int arch_perf_record__need_read(struct evlist *evlist =
__maybe_unused)
>> +{
>> + return 0;  /* Default: no arch-specific data to collect */
>> +}
>> +
>> +static void record__final_data(struct record *rec)
>> +{
>> + /*
>> + * Collect any remaining architecture-specific data.
>> + * The arch code checks if more data exists, and we do the actual
>> + * reading here since we have access to record__mmap_read_all().
>> + */
>> + while (arch_perf_record__need_read(rec->evlist)) {
>> + if (record__mmap_read_all(rec, false) < 0)
>> + break;
>=20
> [Severity: High]
> Does this create a busy-wait loop that pegs the CPU? This loop =
repeatedly calls
> record__mmap_read_all() without yielding or polling.
>=20
> Additionally, record__mmap_read_all() flushes mmap buffers based on =
the
> thread-local variable, so when running on the main thread it only =
flushes
> thread_data[0]. If the data to be consumed resides in a worker =
thread's buffer,
> could this starve the worker thread and cause an infinite loop?
>=20
>> + /* Re-enable events for next batch */
>> + evlist__enable(rec->evlist);
>=20
> [Severity: High]
> Is it intentional to re-enable the events here during the shutdown =
phase?
>=20
> Since this is called when done is true to drain the final buffers, =
calling
> evlist__enable() instructs the kernel to resume generating normal =
profiling
> samples. Could this continuously feed new samples into the buffers and =
trap
> the tool in an infinite loop while generating massive amounts of =
ioctls?
>=20
>> + }
>> +
>> + return;
>> +}
>> +
>=20
> [ ... ]
>=20
>> @@ -2852,6 +2880,7 @@ static int __cmd_record(struct record *rec, int =
argc, const char **argv)
>> */
>> if (done && !disabled && !target__none(&opts->target)) {
>> trigger_off(&auxtrace_snapshot_trigger);
>> + record__final_data(rec);
>=20
> [Severity: High]
> Could the early break condition earlier in the event loop cause this =
final data
> collection to be silently bypassed?
>=20
> If the main thread's mmap buffers contain no new normal events during =
the
> iteration when the done flag is observed:
>=20
> __cmd_record() {
>    ...
>    if (hits =3D=3D thread->samples) {
>        if (done || draining)
>            break;
>    ...
> }
>=20
> It breaks out of the loop and skips over this block, randomly missing =
the
> final architecture-specific data.
>=20
> [Severity: High]
> Will this fail to collect final data when tracing child workloads?
>=20
> The condition !target__none(&opts->target) evaluates to false when a =
child
> workload is specified (e.g., perf record ./my_app). Because =
record__final_data()
> is placed inside this pre-existing guard, won't it silently omit the =
data
> collection for normal child workloads?
>=20
>> evlist__disable(rec->evlist);
>> disabled =3D true;
>> }
>> diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
>> index 93627c9a73387..21f51efd36fc7 100644
>> --- a/tools/perf/util/record.h
>> +++ b/tools/perf/util/record.h
>> @@ -8,6 +8,8 @@
>> #include <linux/stddef.h>
>> #include <linux/perf_event.h>
>> #include "util/target.h"
>> +#include "util/evlist.h"
>> +#include "util/util.h"
>=20
> [Severity: Low]
> Is it possible to use a forward declaration here instead of full =
header
> inclusions?
>=20
> Since arch_perf_record__need_read() only references struct evlist by =
pointer, a
> forward declaration like "struct evlist;" would avoid including these =
heavy
> headers, aligning with the perf subsystem guidelines.
>=20
>>=20
>> struct option;
>>=20
>> @@ -95,4 +97,6 @@ static inline bool =
record_opts__no_switch_events(const struct record_opts *opts)
>> return opts->record_switch_events_set && !opts->record_switch_events;
>> }
>>=20
>> +int arch_perf_record__need_read(struct evlist *evlist);
>> +
>> #endif // _PERF_RECORD_H
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/20260701084115.80383-1-atrajeev@linux.ibm.c=
om?part=3D3

