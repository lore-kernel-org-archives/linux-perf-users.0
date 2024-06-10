Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8998F824BC;
	Mon, 10 Jun 2024 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718029561; cv=none; b=sNBL3C3NAYWmfDks54Nyj37EcQzV2wbzlwxNGXvg6qhLwFy/b2IwZyyFP5VtGlTifKklMUp2caWJaXKiPvGne1ZG9Gr3K6wv+8fmQp7I6ID5JjJQ5pKDAMqN00+uBJmAiyDUjQuiBchpiY0yre/nPG9fqjAG6t0GQbeSV4zvbQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718029561; c=relaxed/simple;
	bh=1MALhVTCXvaaSPsLKS6EA4XQxIwuQjsSEcf83lfWSVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CvTDuDoCYVtH2QMA6zVorB+sOaHvf5VcKG02Xy3Ew59vF6zkoniMBnWBzvuRbjeXCm9vSRGslXDNe/EEG11OAg6YCsSAAuRkJhTcv5wWvLrsvwU+eN9/4Z7//Xfx+IhoCasN4r0BEXo8x3ae1P0a7Q61cqPiDXM6YY1SMWJJHGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D0QsAhn6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D0QsAhn6"
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ADvAEo029547;
	Mon, 10 Jun 2024 14:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=9
	A1fnRaAIAcs+I/+xS5/n4SQRErLpAGc0NlZwmylIis=; b=D0QsAhn6REYN+fay+
	+OO1bpl4LVfs9ntfPkLSHqjU+w2hfUnm2vJPx3jONjvfFNjSfrhjmRlkNtvEkcHA
	AewNK55brvhVho5rNbutXJBuSanRwYC2fGU7XAkrWVQDHKEnmVXZ6xIWkHTFukj9
	xT2Fcv6waLclTcpqelOUbgE6f0xAzmZeYQyaegje4rz09gos/duySwqOScOKehC1
	b8UxbekNaoXOf8vdaX5B/L+vxTj71qp0gMpkXfLD3fVtNx11XmrRAfqZCavQwiRg
	dnirHulAoLU0ok0hvqMKd2O8SydktJLt1QuSXs/mYelPo8CqttPrO7wiY+/WkYcv
	KAzzg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yp2ddr50e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 14:25:51 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45AEPoNb009931;
	Mon, 10 Jun 2024 14:25:50 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yp2ddr4wq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 14:25:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45ABxWOj023597;
	Mon, 10 Jun 2024 14:22:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yn3um7pw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 14:22:45 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45AEMenM31195834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Jun 2024 14:22:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2085120043;
	Mon, 10 Jun 2024 14:22:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC0AB20040;
	Mon, 10 Jun 2024 14:22:36 +0000 (GMT)
Received: from [9.43.26.142] (unknown [9.43.26.142])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Jun 2024 14:22:36 +0000 (GMT)
Message-ID: <92752ed4-0091-4a98-8af7-dd58bc5432bc@linux.ibm.com>
Date: Mon, 10 Jun 2024 19:52:35 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tools/perf: Fix the nrcpus in perf bench futex to
 enable the run when all CPU's are not online
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, acme@kernel.org,
        jolsa@kernel.org, adrian.hunter@intel.com, irogers@google.com,
        namhyung@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
References: <20240607044354.82225-1-atrajeev@linux.vnet.ibm.com>
Content-Language: en-GB
From: Disha Goel <disgoel@linux.ibm.com>
In-Reply-To: <20240607044354.82225-1-atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: V2sqOEVqikLkB1I9rixbBRJHFTgczB4i
X-Proofpoint-ORIG-GUID: pLw8LKytb_MEOT5m2C01hvqqU2knd3E_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1011 suspectscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406100109

On 07/06/24 10:13 am, Athira Rajeev wrote:

> Perf bench futex fails as below when attempted to run on
> on a powerpc system:
>
>   ./perf bench futex all
>   Running futex/hash benchmark...
> Run summary [PID 626307]: 80 threads, each operating on 1024 [private] futexes for 10 secs.
>
> perf: pthread_create: No such file or directory
>
> In the setup where this perf bench was ran, difference was that
> partition had 640 CPU's, but not all CPUs were online. 80 CPUs
> were online. While blocking the threads with futex_wait, code
> sets the affinity using cpumask. The cpumask size used is 80
> which is picked from "nrcpus = perf_cpu_map__nr(cpu)". Here the
> benchmark reports fail while setting affinity for cpu number which
> is greater than 80 or higher, because it attempts to set a bit
> position which is not allocated on the cpumask. Fix this by changing
> the size of cpumask to number of possible cpus and not the number
> of online cpus.
>
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Thanks for the fix patches, Athira.
I have tested all three patches on a power machine (both small and max config),
and the perf bench futex and epoll tests run fine.

For the series:
Tested-by: Disha Goel <disgoel@linux.ibm.com>

> ---
>   tools/perf/bench/futex-hash.c          | 2 +-
>   tools/perf/bench/futex-lock-pi.c       | 2 +-
>   tools/perf/bench/futex-requeue.c       | 2 +-
>   tools/perf/bench/futex-wake-parallel.c | 2 +-
>   tools/perf/bench/futex-wake.c          | 2 +-
>   5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
> index 0c69d20efa32..b472eded521b 100644
> --- a/tools/perf/bench/futex-hash.c
> +++ b/tools/perf/bench/futex-hash.c
> @@ -174,7 +174,7 @@ int bench_futex_hash(int argc, const char **argv)
>   	pthread_attr_init(&thread_attr);
>   	gettimeofday(&bench__start, NULL);
>   
> -	nrcpus = perf_cpu_map__nr(cpu);
> +	nrcpus = cpu__max_cpu().cpu;
>   	cpuset = CPU_ALLOC(nrcpus);
>   	BUG_ON(!cpuset);
>   	size = CPU_ALLOC_SIZE(nrcpus);
> diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
> index 7a4973346180..0416120c091b 100644
> --- a/tools/perf/bench/futex-lock-pi.c
> +++ b/tools/perf/bench/futex-lock-pi.c
> @@ -122,7 +122,7 @@ static void create_threads(struct worker *w, struct perf_cpu_map *cpu)
>   {
>   	cpu_set_t *cpuset;
>   	unsigned int i;
> -	int nrcpus =  perf_cpu_map__nr(cpu);
> +	int nrcpus =  cpu__max_cpu().cpu;
>   	size_t size;
>   
>   	threads_starting = params.nthreads;
> diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
> index d9ad736c1a3e..aad5bfc4fe18 100644
> --- a/tools/perf/bench/futex-requeue.c
> +++ b/tools/perf/bench/futex-requeue.c
> @@ -125,7 +125,7 @@ static void block_threads(pthread_t *w, struct perf_cpu_map *cpu)
>   {
>   	cpu_set_t *cpuset;
>   	unsigned int i;
> -	int nrcpus = perf_cpu_map__nr(cpu);
> +	int nrcpus = cpu__max_cpu().cpu;
>   	size_t size;
>   
>   	threads_starting = params.nthreads;
> diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
> index b66df553e561..90a5b91bf139 100644
> --- a/tools/perf/bench/futex-wake-parallel.c
> +++ b/tools/perf/bench/futex-wake-parallel.c
> @@ -149,7 +149,7 @@ static void block_threads(pthread_t *w, struct perf_cpu_map *cpu)
>   {
>   	cpu_set_t *cpuset;
>   	unsigned int i;
> -	int nrcpus = perf_cpu_map__nr(cpu);
> +	int nrcpus = cpu__max_cpu().cpu;
>   	size_t size;
>   
>   	threads_starting = params.nthreads;
> diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
> index 690fd6d3da13..49b3c89b0b35 100644
> --- a/tools/perf/bench/futex-wake.c
> +++ b/tools/perf/bench/futex-wake.c
> @@ -100,7 +100,7 @@ static void block_threads(pthread_t *w, struct perf_cpu_map *cpu)
>   	cpu_set_t *cpuset;
>   	unsigned int i;
>   	size_t size;
> -	int nrcpus = perf_cpu_map__nr(cpu);
> +	int nrcpus = cpu__max_cpu().cpu;
>   	threads_starting = params.nthreads;
>   
>   	cpuset = CPU_ALLOC(nrcpus);
