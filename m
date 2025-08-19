Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB6C3314AF
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Aug 2025 11:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604602; cv=none; b=GAD0bkE3l6B3h3SEH6QMtRLzwzR8BIiK8QwWxBgLDELzXRGoGfqQr4CHmC4HA8RO5ln5434ZqI9ZF25Hkyos3DTvvm54m0XPmYGLgm7AWrXR4O5U0VgCGSB/7YGrTStaUoCxHLuK4fLNcDHcLXhkpCBSGMmuvlLGIcqLP4t5TGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604602; c=relaxed/simple;
	bh=rb1SGl8FNOi+DNy3nHjlYUIv3bHD11uyZ+xyxyhrrRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TRStTxwVm+40K8Zp75E17bgY1O4jmT5hws4Rdv2JolmD70s0uTQMwfdJsG43V/yAmBY1WuZwehjesw33JNo0jQeYFjCjaqJxEQnHVe3K1FmhNR9mULNDT1vqlvgDjEvcoPaHVhEhnpvUf5CgF8cNPUi9sG/7KHsAFniCKpD28ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MtMu2W0l; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MtMu2W0l"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JA9sWd010863;
	Tue, 19 Aug 2025 11:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DmVgUE
	BeGJMJbKnwbtyE6NXok77mFjGDpIQb0FwbZF8=; b=MtMu2W0lPMo+WGl9vkHdkb
	EL90JsOP45U7qR12KFEsxWa1t6AJvMzgQul6UgfdFMe+NtZfWeurnqMm/aBDfFLd
	3A/C5dcD+x/E4JkrqSyG/brZ5/ZKW2Uh7pYARpL2Z5FUTVtUKL0VyYLO5EIaQcnZ
	bUWVbuUoDnUe4t1+ateovRsxgx6V31bC+doLJtGSSD5KwGOCsIAEqRTKqHn7MSCw
	+n/yebeiF+yiOQ/7eT7Ee8mzYCbPwoTjinJ1EfuiN/uklpRwOqHcwypWYamqUjVQ
	vBaVqhKD5TFzU8cXadXMrciLpB5oXC5ISIDkszGxHWJDNdmUN610P1M+O1GjpXzA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jhny6m68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 11:56:37 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57JBtJRN001304;
	Tue, 19 Aug 2025 11:56:37 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jhny6m67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 11:56:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57JAGAb1014720;
	Tue, 19 Aug 2025 11:56:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48k5tmt033-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 11:56:36 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57JBuW5a46531058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 11:56:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AA2220040;
	Tue, 19 Aug 2025 11:56:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5285A20043;
	Tue, 19 Aug 2025 11:56:30 +0000 (GMT)
Received: from [9.79.202.156] (unknown [9.79.202.156])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Aug 2025 11:56:30 +0000 (GMT)
Message-ID: <eeaaf0e1-00ea-459f-b4e7-7167e88b8b1e@linux.ibm.com>
Date: Tue, 19 Aug 2025 17:26:29 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/perf/tests: Update perf record testcase to fix
 usage of affinity for machines with #CPUs > 1K
To: Athira Rajeev <atrajeev@linux.ibm.com>, acme@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com, kjain@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, Aditya.Bodkhe1@ibm.com
References: <20250814114908.45648-1-atrajeev@linux.ibm.com>
Content-Language: en-US
From: tejas05 <tejas05@linux.ibm.com>
In-Reply-To: <20250814114908.45648-1-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XbqJzJ55 c=1 sm=1 tr=0 ts=68a46676 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=STefjNa7gtbzDs6x5UoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: rs84PFXSOKg0MA3LEeb7O-789jNjb4b0
X-Proofpoint-GUID: peFYuAwNKiI3Lyg6ByzGiQ4AfOniygiS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyNyBTYWx0ZWRfX5glu4YIQNppm
 8460LKicgS+gyUxt4UdCqz1nFjUqcyPe+HctZy0vQxx1YP8YVQFuj/hdxrnP2C4YQGg861P0mIx
 zdvq8XPIhutVxNufcklPknF/3s+Q9UVnxibRANnn3tr/we+mPe7htiFaN9dkxVG0v8Llz+8nGhb
 Ep2ljwLZZxt+iRSuCR6GymLSGpYEvS9Vllx3XHy6hxjbHhUyYbQ5MjgzQVLI2bMurf/7hu/eZzV
 tW3FKSLtmBWGk9t9VuWBesb4uD6m3o9GSSuVSHIgbJ52OSpR9mot1hgDrjhbQi3KxyPwDs39NXX
 K9e1IIFlHJS1j7wCU1n/rK4+B2x16xd0Gf+VlJg+0lu4zEzSwE+FbsHxXUZPgCVN1lnQ2wlfkcE
 06+0Z3+m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160027

On 8/14/25 17:19, Athira Rajeev wrote:

> The perf record testcase fails on systems with more than 1K CPUs.
>
> Testcase: perf test -vv "PERF_RECORD_* events & perf_sample fields"
>
>    PERF_RECORD_* events & perf_sample fields                       :
>    --- start ---
>    test child forked, pid 272482
>    sched_getaffinity: Invalid argument
>    sched__get_first_possible_cpu: Invalid argument
>    test child finished with -1
>    ---- end ----
>    PERF_RECORD_* events & perf_sample fields: FAILED!
>
> sched__get_first_possible_cpu uses "sched_getaffinity" to get the
> cpumask and this call is returning EINVAL (Invalid argument).
> This happens because the default mask size in glibc is 1024.  To
> overcome this 1024 CPUs mask size limitation of cpu_set_t, change the
> mask size using the CPU_*_S macros ie, use CPU_ALLOC to allocate
> cpumask, CPU_ALLOC_SIZE for size. Same fix needed for mask which is
> used to setaffinity so that mask size is large enough to represent
> number of possible CPU's in the system.
>
> Reported-by: Tejas Manhas <tejas05@linux.ibm.com>
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> ---
>   tools/perf/tests/perf-record.c | 36 ++++++++++++++++++++++++----------
>   1 file changed, 26 insertions(+), 10 deletions(-)
>
> diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
> index 0b3c37e66871..d895df037707 100644
> --- a/tools/perf/tests/perf-record.c
> +++ b/tools/perf/tests/perf-record.c
> @@ -13,15 +13,19 @@
>   #include "tests.h"
>   #include "util/mmap.h"
>   #include "util/sample.h"
> +#include "util/cpumap.h"
>   
>   static int sched__get_first_possible_cpu(pid_t pid, cpu_set_t *maskp)
>   {
> -	int i, cpu = -1, nrcpus = 1024;
> +	int i, cpu = -1;
> +	int nrcpus = cpu__max_cpu().cpu;
> +	size_t size = CPU_ALLOC_SIZE(nrcpus);
> +
>   realloc:
> -	CPU_ZERO(maskp);
> +	CPU_ZERO_S(size, maskp);
>   
> -	if (sched_getaffinity(pid, sizeof(*maskp), maskp) == -1) {
> -		if (errno == EINVAL && nrcpus < (1024 << 8)) {
> +	if (sched_getaffinity(pid, size, maskp) == -1) {
> +		if (errno == EINVAL && nrcpus < (cpu__max_cpu().cpu << 8)) {
>   			nrcpus = nrcpus << 2;
>   			goto realloc;
>   		}
> @@ -30,11 +34,11 @@ static int sched__get_first_possible_cpu(pid_t pid, cpu_set_t *maskp)
>   	}
>   
>   	for (i = 0; i < nrcpus; i++) {
> -		if (CPU_ISSET(i, maskp)) {
> +		if (CPU_ISSET_S(i, size, maskp)) {
>   			if (cpu == -1)
>   				cpu = i;
>   			else
> -				CPU_CLR(i, maskp);
> +				CPU_CLR_S(i, size, maskp);
>   		}
>   	}
>   
> @@ -50,8 +54,9 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
>   		.no_buffering = true,
>   		.mmap_pages   = 256,
>   	};
> -	cpu_set_t cpu_mask;
> -	size_t cpu_mask_size = sizeof(cpu_mask);
> +	int nrcpus = cpu__max_cpu().cpu;
> +	cpu_set_t *cpu_mask;
> +	size_t cpu_mask_size;
>   	struct evlist *evlist = evlist__new_dummy();
>   	struct evsel *evsel;
>   	struct perf_sample sample;
> @@ -69,12 +74,22 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
>   	int total_events = 0, nr_events[PERF_RECORD_MAX] = { 0, };
>   	char sbuf[STRERR_BUFSIZE];
>   
> +	cpu_mask = CPU_ALLOC(nrcpus);
> +	if (!cpu_mask) {
> +		pr_debug("failed to create cpumask\n");
> +		goto out;
> +	}
> +
> +	cpu_mask_size = CPU_ALLOC_SIZE(nrcpus);
> +	CPU_ZERO_S(cpu_mask_size, cpu_mask);
> +
>   	perf_sample__init(&sample, /*all=*/false);
>   	if (evlist == NULL) /* Fallback for kernels lacking PERF_COUNT_SW_DUMMY */
>   		evlist = evlist__new_default();
>   
>   	if (evlist == NULL) {
>   		pr_debug("Not enough memory to create evlist\n");
> +		CPU_FREE(cpu_mask);
>   		goto out;
>   	}
>   
> @@ -111,7 +126,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
>   	evsel__set_sample_bit(evsel, TIME);
>   	evlist__config(evlist, &opts, NULL);
>   
> -	err = sched__get_first_possible_cpu(evlist->workload.pid, &cpu_mask);
> +	err = sched__get_first_possible_cpu(evlist->workload.pid, cpu_mask);
>   	if (err < 0) {
>   		pr_debug("sched__get_first_possible_cpu: %s\n",
>   			 str_error_r(errno, sbuf, sizeof(sbuf)));
> @@ -123,7 +138,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
>   	/*
>   	 * So that we can check perf_sample.cpu on all the samples.
>   	 */
> -	if (sched_setaffinity(evlist->workload.pid, cpu_mask_size, &cpu_mask) < 0) {
> +	if (sched_setaffinity(evlist->workload.pid, cpu_mask_size, cpu_mask) < 0) {
>   		pr_debug("sched_setaffinity: %s\n",
>   			 str_error_r(errno, sbuf, sizeof(sbuf)));
>   		goto out_delete_evlist;
> @@ -328,6 +343,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
>   		++errs;
>   	}
>   out_delete_evlist:
> +	CPU_FREE(cpu_mask);
>   	evlist__delete(evlist);
>   out:
>   	perf_sample__exit(&sample);


Hi,

I have tested the patch on the setup where the issue was seen, the patch fixes the issue. Please add the tested-by tag as below.
Tested-by: Tejas Manhas<tejas05@linux.ibm.com>

Thanks & Regards
Tejas


