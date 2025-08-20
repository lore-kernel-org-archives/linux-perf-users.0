Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B4D277C8F
	for <linux-perf-users@vger.kernel.org>; Wed, 20 Aug 2025 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755710595; cv=none; b=sYu8OjY080qAO4MiMzIXh0R/2UwYBrrHF7litBeZYekvxaHVbfiKQkxC2XZtydcRY5WP+hyw40zvZn1LNP2zV7H8Xyp2gusfISfNA/I5ChNVdwyGfUvMNau2pQZwwBTg7fQriKLAJp9g8IrPlRDwFObs3AOrMIkHwd5msCwMRjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755710595; c=relaxed/simple;
	bh=VQluRGFhuZfubQglvLOA9zawiMPO/VSpNFQ98bGlggg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZaAwsaLicphoZ/hu8am4ekhvCp5+X13BGgXZ2mRk1EyOVfoBGISaFyofGx2SpZKhDEfuEF1Xib1nf97oUHS/9gODfdQJ+M9+kbdP+nGzSR25sOmNf4GE5z2F+FKTjxkWQABjZLmtvnNr4K2HoG+HziBN6uU9VfDzGIr9Q25HOLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PWCyh4f9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PWCyh4f9"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KC1dWx012755;
	Wed, 20 Aug 2025 17:23:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=upkPb8
	hJCivqAZeSpDxR9zy/9BZIjY+DawhB3rRtw1A=; b=PWCyh4f9cIgKluLtrnDBhY
	G0B2nMz9vkKt+uj8LU/iqBYj3UeQgvYT91i58cf5/zsje/v32WBdT1LOelBa/8bQ
	puOQ1MHF54ih4sHjRkCS21aDbc92RIak5QpSyibk7kHI70oYERS7mDdJlc+DiR85
	jMOYIhxZnjmt0Ynwh3dBeSSlYaiDJxmT5/s5R32qgVrBALCjAeP/fiL8jX7jXDCR
	T9yVmhoEeF6DzIFt+BcAy0YNgSZtjO35Up8NTgrhyHh9p5m/SZVufuOr6a2q5gBF
	3PwECOFuFQNYnQprG/P6G90qlt+P0TjwRVrYf+n+2Y/C5A+c7Olon5wnIZZKiCXA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vm7pu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 17:23:09 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57KHKAeb027380;
	Wed, 20 Aug 2025 17:23:09 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vm7pq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 17:23:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57KDZZn9025220;
	Wed, 20 Aug 2025 17:23:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48my5vvb65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 17:23:08 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57KHN42g33227316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 17:23:04 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AB3120043;
	Wed, 20 Aug 2025 17:23:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 711B520040;
	Wed, 20 Aug 2025 17:22:59 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.240.54])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 20 Aug 2025 17:22:59 +0000 (GMT)
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
In-Reply-To: <eeaaf0e1-00ea-459f-b4e7-7167e88b8b1e@linux.ibm.com>
Date: Wed, 20 Aug 2025 22:52:45 +0530
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>, hbathini@linux.vnet.ibm.com,
        Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <201A5293-4008-471D-8C1F-A01F9467FB3C@linux.ibm.com>
References: <20250814114908.45648-1-atrajeev@linux.ibm.com>
 <eeaaf0e1-00ea-459f-b4e7-7167e88b8b1e@linux.ibm.com>
To: tejas05 <tejas05@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
X-Mailer: Apple Mail (2.3776.700.51)
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX3aryi6kELDI7
 OYIKOagvcMPhEt5IGboiFoKQm24XV7xr6qwP11pAfIJp0WBOoy05kxMj1NclJ8lEUFz03iKb3j1
 WKfLQt9rq0whBGT/fq6hctIfz+rUiXvg53AHyaQ8PotymjwSKWJG3VM7J4huLZAuNsyWtcWkzys
 YvbcvYUrO786V/rWK+jLV4aZxODTt/t1qq7KCi+38CfP9AF+kOm4uc74vDIphMs83KE6z2Pv4ro
 z8/wN2cFQp5pCMRFjH0OsCqRwP/ut4bd/OD23yqJp8z36g5ijTYxE9mr1iKblDAGn0LjLpPgK58
 +2gBU2S/mT8+76B8ra5Rdy8i8y51LUwe9+2AQItpIJVSueQYyGAkRtW0ZHLBhcFce8WWWxS3QRb
 RPRlyoV9i9ynxjKSLDtBcIVAi6prSw==
X-Proofpoint-ORIG-GUID: 0GEL8yOOyn7GcgMyoIQSsoZ8n_ZLc-WI
X-Authority-Analysis: v=2.4 cv=T9nVj/KQ c=1 sm=1 tr=0 ts=68a6047d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=fUCL0REaYEoyNgQrovoA:9
 a=QEXdDO2ut3YA:10 a=HhbK4dLum7pmb74im6QT:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-GUID: xCJdHMDk76VQCXzE-69GrJ4hde8qA5x1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190222



> On 19 Aug 2025, at 5:26=E2=80=AFPM, tejas05 <tejas05@linux.ibm.com> =
wrote:
>=20
> On 8/14/25 17:19, Athira Rajeev wrote:
>=20
>> The perf record testcase fails on systems with more than 1K CPUs.
>>=20
>> Testcase: perf test -vv "PERF_RECORD_* events & perf_sample fields"
>>=20
>>   PERF_RECORD_* events & perf_sample fields                       :
>>   --- start ---
>>   test child forked, pid 272482
>>   sched_getaffinity: Invalid argument
>>   sched__get_first_possible_cpu: Invalid argument
>>   test child finished with -1
>>   ---- end ----
>>   PERF_RECORD_* events & perf_sample fields: FAILED!
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
>> ---
>>  tools/perf/tests/perf-record.c | 36 =
++++++++++++++++++++++++----------
>>  1 file changed, 26 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/tools/perf/tests/perf-record.c =
b/tools/perf/tests/perf-record.c
>> index 0b3c37e66871..d895df037707 100644
>> --- a/tools/perf/tests/perf-record.c
>> +++ b/tools/perf/tests/perf-record.c
>> @@ -13,15 +13,19 @@
>>  #include "tests.h"
>>  #include "util/mmap.h"
>>  #include "util/sample.h"
>> +#include "util/cpumap.h"
>>    static int sched__get_first_possible_cpu(pid_t pid, cpu_set_t =
*maskp)
>>  {
>> - int i, cpu =3D -1, nrcpus =3D 1024;
>> + int i, cpu =3D -1;
>> + int nrcpus =3D cpu__max_cpu().cpu;
>> + size_t size =3D CPU_ALLOC_SIZE(nrcpus);
>> +
>>  realloc:
>> - CPU_ZERO(maskp);
>> + CPU_ZERO_S(size, maskp);
>>  - if (sched_getaffinity(pid, sizeof(*maskp), maskp) =3D=3D -1) {
>> - if (errno =3D=3D EINVAL && nrcpus < (1024 << 8)) {
>> + if (sched_getaffinity(pid, size, maskp) =3D=3D -1) {
>> + if (errno =3D=3D EINVAL && nrcpus < (cpu__max_cpu().cpu << 8)) {
>>   nrcpus =3D nrcpus << 2;
>>   goto realloc;
>>   }
>> @@ -30,11 +34,11 @@ static int sched__get_first_possible_cpu(pid_t =
pid, cpu_set_t *maskp)
>>   }
>>     for (i =3D 0; i < nrcpus; i++) {
>> - if (CPU_ISSET(i, maskp)) {
>> + if (CPU_ISSET_S(i, size, maskp)) {
>>   if (cpu =3D=3D -1)
>>   cpu =3D i;
>>   else
>> - CPU_CLR(i, maskp);
>> + CPU_CLR_S(i, size, maskp);
>>   }
>>   }
>>  @@ -50,8 +54,9 @@ static int test__PERF_RECORD(struct test_suite =
*test __maybe_unused, int subtest
>>   .no_buffering =3D true,
>>   .mmap_pages   =3D 256,
>>   };
>> - cpu_set_t cpu_mask;
>> - size_t cpu_mask_size =3D sizeof(cpu_mask);
>> + int nrcpus =3D cpu__max_cpu().cpu;
>> + cpu_set_t *cpu_mask;
>> + size_t cpu_mask_size;
>>   struct evlist *evlist =3D evlist__new_dummy();
>>   struct evsel *evsel;
>>   struct perf_sample sample;
>> @@ -69,12 +74,22 @@ static int test__PERF_RECORD(struct test_suite =
*test __maybe_unused, int subtest
>>   int total_events =3D 0, nr_events[PERF_RECORD_MAX] =3D { 0, };
>>   char sbuf[STRERR_BUFSIZE];
>>  + cpu_mask =3D CPU_ALLOC(nrcpus);
>> + if (!cpu_mask) {
>> + pr_debug("failed to create cpumask\n");
>> + goto out;
>> + }
>> +
>> + cpu_mask_size =3D CPU_ALLOC_SIZE(nrcpus);
>> + CPU_ZERO_S(cpu_mask_size, cpu_mask);
>> +
>>   perf_sample__init(&sample, /*all=3D*/false);
>>   if (evlist =3D=3D NULL) /* Fallback for kernels lacking =
PERF_COUNT_SW_DUMMY */
>>   evlist =3D evlist__new_default();
>>     if (evlist =3D=3D NULL) {
>>   pr_debug("Not enough memory to create evlist\n");
>> + CPU_FREE(cpu_mask);
>>   goto out;
>>   }
>>  @@ -111,7 +126,7 @@ static int test__PERF_RECORD(struct test_suite =
*test __maybe_unused, int subtest
>>   evsel__set_sample_bit(evsel, TIME);
>>   evlist__config(evlist, &opts, NULL);
>>  - err =3D sched__get_first_possible_cpu(evlist->workload.pid, =
&cpu_mask);
>> + err =3D sched__get_first_possible_cpu(evlist->workload.pid, =
cpu_mask);
>>   if (err < 0) {
>>   pr_debug("sched__get_first_possible_cpu: %s\n",
>>    str_error_r(errno, sbuf, sizeof(sbuf)));
>> @@ -123,7 +138,7 @@ static int test__PERF_RECORD(struct test_suite =
*test __maybe_unused, int subtest
>>   /*
>>    * So that we can check perf_sample.cpu on all the samples.
>>    */
>> - if (sched_setaffinity(evlist->workload.pid, cpu_mask_size, =
&cpu_mask) < 0) {
>> + if (sched_setaffinity(evlist->workload.pid, cpu_mask_size, =
cpu_mask) < 0) {
>>   pr_debug("sched_setaffinity: %s\n",
>>    str_error_r(errno, sbuf, sizeof(sbuf)));
>>   goto out_delete_evlist;
>> @@ -328,6 +343,7 @@ static int test__PERF_RECORD(struct test_suite =
*test __maybe_unused, int subtest
>>   ++errs;
>>   }
>>  out_delete_evlist:
>> + CPU_FREE(cpu_mask);
>>   evlist__delete(evlist);
>>  out:
>>   perf_sample__exit(&sample);
>=20
>=20
> Hi,
>=20
> I have tested the patch on the setup where the issue was seen, the =
patch fixes the issue. Please add the tested-by tag as below.
> Tested-by: Tejas Manhas<tejas05@linux.ibm.com>
>=20
> Thanks & Regards
> Tejas

Hi Tejas, Venkat

Thanks for testing the patch

Athira.=
