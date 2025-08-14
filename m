Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9811F582A
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Aug 2025 12:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755174207; cv=none; b=IOv8Cp8UZ/zdhhQUbGUJNEZJ48/EA1iPKm0sKIL/Mn+OhivFP8PTJs3dR/ITMi4EA8EBNDFoB4VU1WlFPjJvFimyV/tHU+o7vglUYH1OcZFjFZRohIAlAuIUvNJfVpwmpjF55cXIXre8idA3O93tdIXke8RaJrFnp78hP8FKm5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755174207; c=relaxed/simple;
	bh=RKffo7dzeT9QRUpDQbKuZQNUc9ioQI1gekRRZ5sa8/0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gTyUneGcL31O6S29rY/QXkFwB0sDhQhGerMu70bKVXnEVp/9WVov71lGZAPeDkhRrN7IS55RBXGEtChjgUR/usfK67mGPTJGn0NkhSLhIhutfBXIiUb99Ufpo/8foLyGYpZKfBvP79oYPQ8uU7BH1GnNj3iSjCC/2Icdjf9Ezoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NSPisDP9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NSPisDP9"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57EAKVDT009662;
	Thu, 14 Aug 2025 12:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=N5NWn/
	CNwCt4/OrbpexlhoHQlDU1qdiC7tyVPlZ68kU=; b=NSPisDP99193xfwl/cvsBM
	ACunaslw2XD4ii4QFehZxkyvq4E7gbEGin3KRUZ8L1hE7SwrJ6QvkSDevJoiZ9uP
	YncHG0OsGPKr0LvUpX2FYV9Bc9QT2Junhs5LzCoCeudruuCC040QBZEGQnD4pmr6
	AzWBcgIVVxhUFUllGYcU8k8XODNBZRp7rycAK+eK1NsgszA9QbKf5ga78FwdsN+m
	BvYgZreJOYuG+jUVC0tKQ5ncqPOf1nYbyqDJIYQRR4LqJcAwGxqbBQ/ZZRvNL7AD
	CnECFB8DccygTNxstn2B2OgGsmf+chPCpkSiPDoHGXk6IcqVDqzT1ViNofvluCCg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48duruhyah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 12:23:21 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57EC9bLE031457;
	Thu, 14 Aug 2025 12:23:20 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48duruhyad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 12:23:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57EAhLsa025667;
	Thu, 14 Aug 2025 12:23:19 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ejvmkw1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 12:23:19 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57ECNGtR21234336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Aug 2025 12:23:17 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B36958061;
	Thu, 14 Aug 2025 12:23:16 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D222F58059;
	Thu, 14 Aug 2025 12:23:12 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.204.204.248])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 14 Aug 2025 12:23:12 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] tools/perf/tests: Update perf record testcase to fix
 usage of affinity for machines with #CPUs > 1K
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <20250814114908.45648-1-atrajeev@linux.ibm.com>
Date: Thu, 14 Aug 2025 17:53:00 +0530
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        kjain@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Aditya.Bodkhe1@ibm.com, Tejas Manhas <tejas05@linux.ibm.com>,
        venkat88@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <01D9955C-4C6F-4744-A90E-88A3D99AAE86@linux.ibm.com>
References: <20250814114908.45648-1-atrajeev@linux.ibm.com>
To: Athira Rajeev <atrajeev@linux.ibm.com>
X-Mailer: Apple Mail (2.3774.600.62)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WbBcoMu7O93mnHdQLpfQmRhwdMsuIrhU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX54VF5URJ5zGt
 efAZsa03Z4rFZCM3I8i61Esz+2UrnTyTzPC60KOLeTP7gTJCTjFK5ti4wP94bO1iEXGCMzfjRZG
 Qe7fRcTEKkeLnzEf3bd5YWZZ/FLZJuynPhQaA2d8mzw3cFtxGi3nCSz+pxA8fye10HzwJtc2nF7
 lZDr900fQkLVZVtIgdwmOi3ELI6Tq9iN1F/KQ1hY08r1H3n2GFmbyBqFdKbQ72mvSUvzIIkqttQ
 Wnrcz3WxEtl/5Vo3Cq+t9Yfg3gHrl7fj7J9hkkK6axvjANwMGBRiab1Qe3nT29K2SIHmSM8xdqy
 yYerMO1Z/rMz6UFSN4C2wcyj/VRW/jcte6g3Szil2DJtC+hEo6EtAdl7mAgrTJ8Bp5azcdwbt3u
 tyGuaPvw
X-Authority-Analysis: v=2.4 cv=QtNe3Uyd c=1 sm=1 tr=0 ts=689dd539 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=wxhsVTqnJxziKTFi-4oA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: UINV2CgBB2_ECp_oVx4u7fblY63I8cY8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1011 malwarescore=0
 spamscore=0 suspectscore=0 impostorscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120224



> On 14 Aug 2025, at 5:19=E2=80=AFPM, Athira Rajeev =
<atrajeev@linux.ibm.com> wrote:
>=20
> The perf record testcase fails on systems with more than 1K CPUs.
>=20
> Testcase: perf test -vv "PERF_RECORD_* events & perf_sample fields"
>=20
>  PERF_RECORD_* events & perf_sample fields                       :
>  --- start ---
>  test child forked, pid 272482
>  sched_getaffinity: Invalid argument
>  sched__get_first_possible_cpu: Invalid argument
>  test child finished with -1
>  ---- end ----
>  PERF_RECORD_* events & perf_sample fields: FAILED!
>=20
> sched__get_first_possible_cpu uses "sched_getaffinity" to get the
> cpumask and this call is returning EINVAL (Invalid argument).
> This happens because the default mask size in glibc is 1024.  To
> overcome this 1024 CPUs mask size limitation of cpu_set_t, change the
> mask size using the CPU_*_S macros ie, use CPU_ALLOC to allocate
> cpumask, CPU_ALLOC_SIZE for size. Same fix needed for mask which is
> used to setaffinity so that mask size is large enough to represent
> number of possible CPU's in the system.
>=20
> Reported-by: Tejas Manhas <tejas05@linux.ibm.com>
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> ---
> tools/perf/tests/perf-record.c | 36 ++++++++++++++++++++++++----------
> 1 file changed, 26 insertions(+), 10 deletions(-)


Tested this patch by applying on top of mainline kernel and it fixes the =
reported issue. Hence,

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Before this patch:

  7: PERF_RECORD_* events & perf_sample fields:
--- start ---
test child forked, pid 78426
Using CPUID 0x00820200
sched_getaffinity: Invalid argument
sched__get_first_possible_cpu: Invalid argument
---- end(-1) ----
Leak of file descriptor 6 that opened: 'pipe:[476656]'

---- unexpected signal (6) ----
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
Failed to read build ID for //anon
    #0 0x101871fc in child_test_sig_handler builtin-test.c:0
Failed to open [vdso], continuing without symbols
    #1 0x7fffae7f04d8 [vdso][4d8]
    #2 0x7fffade396f8 in raise libc-2.28.so[496f8]
    #3 0x7fffade13ff4 in abort libc-2.28.so[23ff4]
    #4 0x101879c4 in check_leaks builtin-test.c:0
    #5 0x10187c20 in run_test_child builtin-test.c:0
    #6 0x100fe7dc in start_command run-command.c:128
    #7 0x10188574 in __cmd_test builtin-test.c:0
    #8 0x10188c4c in cmd_test ??:0
    #9 0x100ea3ac in run_builtin perf.c:0
    #10 0x100eaa34 in handle_internal_command perf.c:0
    #11 0x10036aa8 in main ??:0
    #12 0x7fffade19f5c in generic_start_main.isra.0 libc-2.28.so[29f5c]
    #13 0x7fffade1a0f4 in __libc_start_main libc-2.28.so[2a0f4]
  7: PERF_RECORD_* events & perf_sample fields                       : =
FAILED!



After this patch:



0x7fffad7bf168: mmap mask[0]:  0x7fffad7bf258: mmap mask[0]:  =
0x7fffad7bf348: mmap mask[0]:  0x7fffad7bf438: mmap mask[0]:  =
0x7fffad7bf528: mmap mask[0]:  0x7fffad7bf618: mmap mask[0]:  =
0x7fffad7bf708: mmap mask[0]:  0x7fffad7bf7f8: mmap mask[0]:  =
0x7fffad7bf8e8: mmap mask[0]:  0x7fffad7bf9d8: mmap mask[0]:  =
151627927388184 0 PERF_RECORD_COMM exec: sleep:130633/130633
151627927461320 0 PERF_RECORD_MMAP2 130633/130633: [0x124a50000(0x30000) =
@ 0 fd:00 251660138 919860811]: r-xp /usr/bin/sleep
151627927510848 0 PERF_RECORD_MMAP2 130633/130633: =
[0x7fff9c430000(0x60000) @ 0 fd:00 134289888 563052989]: r-xp =
/usr/lib64/ld-2.28.so
151627927559440 0 PERF_RECORD_MMAP2 130633/130633: =
[0x7fff9c410000(0x20000) @ 0 00:00 0 0]: r-xp [vdso]
151627927751224 0 PERF_RECORD_MMAP2 130633/130633: =
[0x7fff9c1f0000(0x210000) @ 0 fd:00 100663849 3568210255]: r-xp =
/usr/lib64/glibc-hwcaps/power9/libc-2.28.so
151628928449218 0 PERF_RECORD_EXIT(130633:130633):(130632:130632)
---- end(0) ----
  7: PERF_RECORD_* events & perf_sample fields                       : =
Ok


Regards,
Venkat.
>=20
> diff --git a/tools/perf/tests/perf-record.c =
b/tools/perf/tests/perf-record.c
> index 0b3c37e66871..d895df037707 100644
> --- a/tools/perf/tests/perf-record.c
> +++ b/tools/perf/tests/perf-record.c
> @@ -13,15 +13,19 @@
> #include "tests.h"
> #include "util/mmap.h"
> #include "util/sample.h"
> +#include "util/cpumap.h"
>=20
> static int sched__get_first_possible_cpu(pid_t pid, cpu_set_t *maskp)
> {
> - int i, cpu =3D -1, nrcpus =3D 1024;
> + int i, cpu =3D -1;
> + int nrcpus =3D cpu__max_cpu().cpu;
> + size_t size =3D CPU_ALLOC_SIZE(nrcpus);
> +
> realloc:
> - CPU_ZERO(maskp);
> + CPU_ZERO_S(size, maskp);
>=20
> - if (sched_getaffinity(pid, sizeof(*maskp), maskp) =3D=3D -1) {
> - if (errno =3D=3D EINVAL && nrcpus < (1024 << 8)) {
> + if (sched_getaffinity(pid, size, maskp) =3D=3D -1) {
> + if (errno =3D=3D EINVAL && nrcpus < (cpu__max_cpu().cpu << 8)) {
> nrcpus =3D nrcpus << 2;
> goto realloc;
> }
> @@ -30,11 +34,11 @@ static int sched__get_first_possible_cpu(pid_t =
pid, cpu_set_t *maskp)
> }
>=20
> for (i =3D 0; i < nrcpus; i++) {
> - if (CPU_ISSET(i, maskp)) {
> + if (CPU_ISSET_S(i, size, maskp)) {
> if (cpu =3D=3D -1)
> cpu =3D i;
> else
> - CPU_CLR(i, maskp);
> + CPU_CLR_S(i, size, maskp);
> }
> }
>=20
> @@ -50,8 +54,9 @@ static int test__PERF_RECORD(struct test_suite *test =
__maybe_unused, int subtest
> .no_buffering =3D true,
> .mmap_pages   =3D 256,
> };
> - cpu_set_t cpu_mask;
> - size_t cpu_mask_size =3D sizeof(cpu_mask);
> + int nrcpus =3D cpu__max_cpu().cpu;
> + cpu_set_t *cpu_mask;
> + size_t cpu_mask_size;
> struct evlist *evlist =3D evlist__new_dummy();
> struct evsel *evsel;
> struct perf_sample sample;
> @@ -69,12 +74,22 @@ static int test__PERF_RECORD(struct test_suite =
*test __maybe_unused, int subtest
> int total_events =3D 0, nr_events[PERF_RECORD_MAX] =3D { 0, };
> char sbuf[STRERR_BUFSIZE];
>=20
> + cpu_mask =3D CPU_ALLOC(nrcpus);
> + if (!cpu_mask) {
> + pr_debug("failed to create cpumask\n");
> + goto out;
> + }
> +
> + cpu_mask_size =3D CPU_ALLOC_SIZE(nrcpus);
> + CPU_ZERO_S(cpu_mask_size, cpu_mask);
> +
> perf_sample__init(&sample, /*all=3D*/false);
> if (evlist =3D=3D NULL) /* Fallback for kernels lacking =
PERF_COUNT_SW_DUMMY */
> evlist =3D evlist__new_default();
>=20
> if (evlist =3D=3D NULL) {
> pr_debug("Not enough memory to create evlist\n");
> + CPU_FREE(cpu_mask);
> goto out;
> }
>=20
> @@ -111,7 +126,7 @@ static int test__PERF_RECORD(struct test_suite =
*test __maybe_unused, int subtest
> evsel__set_sample_bit(evsel, TIME);
> evlist__config(evlist, &opts, NULL);
>=20
> - err =3D sched__get_first_possible_cpu(evlist->workload.pid, =
&cpu_mask);
> + err =3D sched__get_first_possible_cpu(evlist->workload.pid, =
cpu_mask);
> if (err < 0) {
> pr_debug("sched__get_first_possible_cpu: %s\n",
> str_error_r(errno, sbuf, sizeof(sbuf)));
> @@ -123,7 +138,7 @@ static int test__PERF_RECORD(struct test_suite =
*test __maybe_unused, int subtest
> /*
> * So that we can check perf_sample.cpu on all the samples.
> */
> - if (sched_setaffinity(evlist->workload.pid, cpu_mask_size, =
&cpu_mask) < 0) {
> + if (sched_setaffinity(evlist->workload.pid, cpu_mask_size, cpu_mask) =
< 0) {
> pr_debug("sched_setaffinity: %s\n",
> str_error_r(errno, sbuf, sizeof(sbuf)));
> goto out_delete_evlist;
> @@ -328,6 +343,7 @@ static int test__PERF_RECORD(struct test_suite =
*test __maybe_unused, int subtest
> ++errs;
> }
> out_delete_evlist:
> + CPU_FREE(cpu_mask);
> evlist__delete(evlist);
> out:
> perf_sample__exit(&sample);
> --=20
> 2.43.7
>=20
>=20

