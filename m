Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27751335BA1
	for <linux-perf-users@vger.kernel.org>; Wed, 20 Aug 2025 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755710445; cv=none; b=QicTxkp5yID9jtOoiAeKd432d4fowlSkhzWNxlasdeePinYzvjar1uAHrWgSyfeKQ1v7PB3NLUvStUqfVJTdSZKIsrnjPtaFhsP6eNbXW3vSEHJ8KRvypv5dD1mOr34j+1q6NzWaXDLVkMaTN/dayvocw+hztWL0XgawHSdzWIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755710445; c=relaxed/simple;
	bh=3VqY1hY9Ysqt+Zc9zmCO2C2Js8odmbZTrlkU9MMfQSw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KQzoog7c++BzYdIzkmQ94VcXXxgpW6iLLvbzv6u+bMXABvgJrebuNt3CSteOQ7qcOgNFY/4KD0zUPECIUuuc6piHRjoUsgKHu88Y9Wm2fJZrKobBs6K9PhgrhUQOaKI2LJ9JQm+JX8KzIHVDexa2WlhWGYC3+D7apQpcF7QKvow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cZCDUeG8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cZCDUeG8"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KD1qo7002774;
	Wed, 20 Aug 2025 17:20:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iD7gnv
	Ifa6Q0XHTjBTJkDxEQhEgasNKQ5ANkuVz34aE=; b=cZCDUeG8dTmc71wuG/w3OZ
	+TQm3PjshHq7X2MixIA+rLb8f+WXPlXJW/HTIgTaU4ZGMUIWtXxIIKp8PLmryBM2
	CSW6zA+AX79KKsxiqH/mSVNdzOu0vG4C0vvE0AQONKZF1VUVEmbo7ixao+zaL7VR
	HVRuACtN45sOGVBAim+UW90Uob+FF1VkHHJ2y1cF/bnjYA98lGkJhnRNX53nQWoa
	xoTurf/Hcxu9+FJSTv6nH9i82kmZci9aOT6thTTCoGF5ePiJvnqVHENeyboNjc/M
	64x1ac0VpPWga+toyKBO/t3YsjbDqSNCul7FF74MPz47SoRuT3r+B4PkUbG14Jyw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38w46pu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 17:20:35 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57KHC9Ie029615;
	Wed, 20 Aug 2025 17:20:35 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38w46pp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 17:20:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57KDiNbe016030;
	Wed, 20 Aug 2025 17:20:34 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my424bhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 17:20:34 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57KHKU0u19267848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 17:20:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A0B320043;
	Wed, 20 Aug 2025 17:20:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2BED20040;
	Wed, 20 Aug 2025 17:20:25 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.240.54])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 20 Aug 2025 17:20:25 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] tools/perf/tests: Update perf record testcase to fix
 usage of affinity for machines with #CPUs > 1K
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <aJ5FvBa4LPhMO0u-@google.com>
Date: Wed, 20 Aug 2025 22:50:11 +0530
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        adrian.hunter@intel.com, Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        kjain@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Aditya.Bodkhe1@ibm.com, Tejas Manhas <tejas05@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4772D6D1-D61B-4269-B20F-17A387CAAAD9@linux.ibm.com>
References: <20250814114908.45648-1-atrajeev@linux.ibm.com>
 <aJ5FvBa4LPhMO0u-@google.com>
To: Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3776.700.51)
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX021HHO5DXnm4
 1cV84rMsWSMcmVdhZrJsg7iKXP9zUnZS3aYG0Za77mUigNUSZVu0tZvVrJ7TmCps1zkn2F1W61n
 MAs1yxIqPksYzOAhkVQPxl+0QQ7rp5C0sUGCnTNw5asolWIPhAwMUP5yad1EAwuFPpKKcbaTD4L
 /ZGtUhs7KLYLAPNufLvV1IBUrOYppJP/HkBfRYlKJrRFyCjynkJJA0LOwscaOq6zVKkqSJQP31i
 1vcauuVM2ZsrJg7gSNCehK2r4scRAvXEIVSrlPQdoxhmVR/uVto7Tvp88CYLXazsPNa5xpzk0zp
 08EEKm+r05qpXn1yLWSklEmd7RtPxDyoP92/oAvBHL3jybAin3Vp/8Srtcb/0WiFSLvQu4cA4R6
 WsCJzpMVXM4L6BATzw/54YM9Ys3mkw==
X-Authority-Analysis: v=2.4 cv=H62CA+Yi c=1 sm=1 tr=0 ts=68a603e3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=iaynoGNSbbExOy49SX8A:9 a=QEXdDO2ut3YA:10 a=HhbK4dLum7pmb74im6QT:22
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-ORIG-GUID: HS5vUiAWcCORmLKtAQgMEdpeCwXYYX4k
X-Proofpoint-GUID: c7d66zjLXk8VLDnPaL8Dy2KnfFOMWenu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190222



> On 15 Aug 2025, at 1:53=E2=80=AFAM, Namhyung Kim <namhyung@kernel.org> =
wrote:
>=20
> Hello,
>=20
> On Thu, Aug 14, 2025 at 05:19:08PM +0530, Athira Rajeev wrote:
>> The perf record testcase fails on systems with more than 1K CPUs.
>>=20
>> Testcase: perf test -vv "PERF_RECORD_* events & perf_sample fields"
>>=20
>>  PERF_RECORD_* events & perf_sample fields                       :
>>  --- start ---
>>  test child forked, pid 272482
>>  sched_getaffinity: Invalid argument
>>  sched__get_first_possible_cpu: Invalid argument
>>  test child finished with -1
>>  ---- end ----
>>  PERF_RECORD_* events & perf_sample fields: FAILED!
>>=20
>> sched__get_first_possible_cpu uses "sched_getaffinity" to get the
>> cpumask and this call is returning EINVAL (Invalid argument).
>> This happens because the default mask size in glibc is 1024.  To
>> overcome this 1024 CPUs mask size limitation of cpu_set_t, change the
>> mask size using the CPU_*_S macros ie, use CPU_ALLOC to allocate
>> cpumask, CPU_ALLOC_SIZE for size. Same fix needed for mask which is
>> used to setaffinity so that mask size is large enough to represent
>> number of possible CPU's in the system.
>>=20
>> Reported-by: Tejas Manhas <tejas05@linux.ibm.com>
>> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
>=20
> Acked-by: Namhyung Kim <namhyung@kernel.org>
>=20
> Thanks,
> Namhyung

Thanks Namhyung for the Ack

Athira.
>=20
>> ---
>> tools/perf/tests/perf-record.c | 36 =
++++++++++++++++++++++++----------
>> 1 file changed, 26 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/tools/perf/tests/perf-record.c =
b/tools/perf/tests/perf-record.c
>> index 0b3c37e66871..d895df037707 100644
>> --- a/tools/perf/tests/perf-record.c
>> +++ b/tools/perf/tests/perf-record.c
>> @@ -13,15 +13,19 @@
>> #include "tests.h"
>> #include "util/mmap.h"
>> #include "util/sample.h"
>> +#include "util/cpumap.h"
>>=20
>> static int sched__get_first_possible_cpu(pid_t pid, cpu_set_t *maskp)
>> {
>> - int i, cpu =3D -1, nrcpus =3D 1024;
>> + int i, cpu =3D -1;
>> + int nrcpus =3D cpu__max_cpu().cpu;
>> + size_t size =3D CPU_ALLOC_SIZE(nrcpus);
>> +
>> realloc:
>> - CPU_ZERO(maskp);
>> + CPU_ZERO_S(size, maskp);
>>=20
>> - if (sched_getaffinity(pid, sizeof(*maskp), maskp) =3D=3D -1) {
>> - if (errno =3D=3D EINVAL && nrcpus < (1024 << 8)) {
>> + if (sched_getaffinity(pid, size, maskp) =3D=3D -1) {
>> + if (errno =3D=3D EINVAL && nrcpus < (cpu__max_cpu().cpu << 8)) {
>> nrcpus =3D nrcpus << 2;
>> goto realloc;
>> }
>> @@ -30,11 +34,11 @@ static int sched__get_first_possible_cpu(pid_t =
pid, cpu_set_t *maskp)
>> }
>>=20
>> for (i =3D 0; i < nrcpus; i++) {
>> - if (CPU_ISSET(i, maskp)) {
>> + if (CPU_ISSET_S(i, size, maskp)) {
>> if (cpu =3D=3D -1)
>> cpu =3D i;
>> else
>> - CPU_CLR(i, maskp);
>> + CPU_CLR_S(i, size, maskp);
>> }
>> }
>>=20
>> @@ -50,8 +54,9 @@ static int test__PERF_RECORD(struct test_suite =
*test __maybe_unused, int subtest
>> .no_buffering =3D true,
>> .mmap_pages   =3D 256,
>> };
>> - cpu_set_t cpu_mask;
>> - size_t cpu_mask_size =3D sizeof(cpu_mask);
>> + int nrcpus =3D cpu__max_cpu().cpu;
>> + cpu_set_t *cpu_mask;
>> + size_t cpu_mask_size;
>> struct evlist *evlist =3D evlist__new_dummy();
>> struct evsel *evsel;
>> struct perf_sample sample;
>> @@ -69,12 +74,22 @@ static int test__PERF_RECORD(struct test_suite =
*test __maybe_unused, int subtest
>> int total_events =3D 0, nr_events[PERF_RECORD_MAX] =3D { 0, };
>> char sbuf[STRERR_BUFSIZE];
>>=20
>> + cpu_mask =3D CPU_ALLOC(nrcpus);
>> + if (!cpu_mask) {
>> + pr_debug("failed to create cpumask\n");
>> + goto out;
>> + }
>> +
>> + cpu_mask_size =3D CPU_ALLOC_SIZE(nrcpus);
>> + CPU_ZERO_S(cpu_mask_size, cpu_mask);
>> +
>> perf_sample__init(&sample, /*all=3D*/false);
>> if (evlist =3D=3D NULL) /* Fallback for kernels lacking =
PERF_COUNT_SW_DUMMY */
>> evlist =3D evlist__new_default();
>>=20
>> if (evlist =3D=3D NULL) {
>> pr_debug("Not enough memory to create evlist\n");
>> + CPU_FREE(cpu_mask);
>> goto out;
>> }
>>=20
>> @@ -111,7 +126,7 @@ static int test__PERF_RECORD(struct test_suite =
*test __maybe_unused, int subtest
>> evsel__set_sample_bit(evsel, TIME);
>> evlist__config(evlist, &opts, NULL);
>>=20
>> - err =3D sched__get_first_possible_cpu(evlist->workload.pid, =
&cpu_mask);
>> + err =3D sched__get_first_possible_cpu(evlist->workload.pid, =
cpu_mask);
>> if (err < 0) {
>> pr_debug("sched__get_first_possible_cpu: %s\n",
>>  str_error_r(errno, sbuf, sizeof(sbuf)));
>> @@ -123,7 +138,7 @@ static int test__PERF_RECORD(struct test_suite =
*test __maybe_unused, int subtest
>> /*
>>  * So that we can check perf_sample.cpu on all the samples.
>>  */
>> - if (sched_setaffinity(evlist->workload.pid, cpu_mask_size, =
&cpu_mask) < 0) {
>> + if (sched_setaffinity(evlist->workload.pid, cpu_mask_size, =
cpu_mask) < 0) {
>> pr_debug("sched_setaffinity: %s\n",
>>  str_error_r(errno, sbuf, sizeof(sbuf)));
>> goto out_delete_evlist;
>> @@ -328,6 +343,7 @@ static int test__PERF_RECORD(struct test_suite =
*test __maybe_unused, int subtest
>> ++errs;
>> }
>> out_delete_evlist:
>> + CPU_FREE(cpu_mask);
>> evlist__delete(evlist);
>> out:
>> perf_sample__exit(&sample);
>> --=20
>> 2.43.7


