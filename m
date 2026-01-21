Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAA3332EBC;
	Wed, 21 Jan 2026 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769015989; cv=none; b=OsGwbBHoahroNCeSJ4CBjPexJC9ojoSkZmgFW0uz0iuU3SQA5kGePW4zNhlbaBYU8cfXodpSt6Cow1S8uveXYhn/kUWgjMZoXiU1Wu2Qs7ma2wfdyus0Y6AdVWWSL7f4Qd0F24SSA+b5CETOSxWvXTybl9r1EUFtk03aeA8KG+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769015989; c=relaxed/simple;
	bh=hXlx9I7e95C5Zqlwl3iQ9lej3buJAJp2kL+r0J0KchQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLfHZ0Qgm2UeztxjFMoj9BWyQv9gj1IHqRxmJmJ9VefdKqLkYVaMy6HeHnkEk8tV1aP+Ht94ywwlN98TUd11b2A9Z9AWBTo1fKN8Ghc8ZmrTKTfxxu+OuWNbavP5B3g2qQeitgUy26jaifGXPhnTs4It/tx1yL1A9RJOSNLZXvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tep6pc8W; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tep6pc8W"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60LA4cuQ028628;
	Wed, 21 Jan 2026 17:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RPpN1m
	Ft88tbz6sH4TFPMvYxRTR6n3tggYFfJISCYPw=; b=tep6pc8WZJpSNVlGcOid6w
	oJSOUs8fKSA3ssR9XD4egDdUHgn8iliI7Asn3PN3GOxTxXbuZaxfHvXj5J73Z3+j
	sSLRz5sB/pI+jMrnKqBxYjz/4Lqu5MRy08xYtvV/Y4kmRtnoKX+5lihMU/s+sFnZ
	zA4u3OaS8Lvegq2FRO9kaJLJpzVOH9jX8TzN3jRemSQyUn1uumjBW7Lula8Nv29O
	yJdW3VvHL+fWQX1ShUkuByUlVZ0810GQjj5T8ywdK5ZsBaYcQlM2EEWVsFKOMaCe
	Ux4xuXIzSETE2po4dGk4az0NYcpZVQyOgYgiGp7KlI5ZuvCwjTvU3tXUKuHOfR/A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt60es111-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 17:18:35 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60LHFVej015773;
	Wed, 21 Jan 2026 17:18:34 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt60es10s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 17:18:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60LG3Xt3016668;
	Wed, 21 Jan 2026 17:18:32 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brn4y5gm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 17:18:32 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60LHIUId39780648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Jan 2026 17:18:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8060C20043;
	Wed, 21 Jan 2026 17:18:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8E8020040;
	Wed, 21 Jan 2026 17:18:22 +0000 (GMT)
Received: from [9.39.23.228] (unknown [9.39.23.228])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Jan 2026 17:18:22 +0000 (GMT)
Message-ID: <ae0de6b0-82d8-4016-8011-0439ae2851e2@linux.ibm.com>
Date: Wed, 21 Jan 2026 22:48:22 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/10] perf header: Support CPU DOMAIN relation info
To: Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc: ravi.bangoria@amd.com, yu.c.chen@intel.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        rostedt@goodmis.org, vincent.guittot@linaro.org,
        adrian.hunter@intel.com, kan.liang@linux.intel.com,
        gautham.shenoy@amd.com, kprateek.nayak@amd.com, juri.lelli@redhat.com,
        yangjihong@bytedance.com, void@manifault.com, tj@kernel.org,
        ctshao@google.com, quic_zhonhan@quicinc.com, thomas.falcon@intel.com,
        blakejones@google.com, ashelat@redhat.com, leo.yan@arm.com,
        dvyukov@google.com, ak@linux.intel.com, yujie.liu@intel.com,
        graham.woodward@arm.com, ben.gainey@arm.com, vineethr@linux.ibm.com,
        tim.c.chen@linux.intel.com, linux@treblig.org, santosh.shukla@amd.com,
        sandipan.das@amd.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com, james.clark@arm.com
References: <20260119175833.340369-1-swapnil.sapkal@amd.com>
 <20260119175833.340369-3-swapnil.sapkal@amd.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260119175833.340369-3-swapnil.sapkal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=WMdyn3sR c=1 sm=1 tr=0 ts=69710a6b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zd2uoN0lAAAA:8 a=TPSc4mbg-hYvgBB5kCYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: sKrYhhekVo-ilSi19Hl1rqWygLdaDMGt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDE0MiBTYWx0ZWRfX0Q2FwWPbGW69
 CjRoW9LnU5dCfCD4co+h3XDw//DU9qScIn35Q1b3yZwc1AuuxmeblRHfjkQ0hO6KZ9SdxsKB9F+
 tVzym7guie1JYSe1CA4Z2o2wxeq8M7CDh1vbA89aFfCIdzTJe+aLAqAm5oKsR9mMyi0hPiFvVG/
 +WMsnR+fjRNcYF7/v/P54lKQToS0QuecIfvfXesqQnIg0LCLRK4TmwOTNVTS2pNZR877DUD7Lav
 O6TbRsRv+l/RUIs2I47Y838+HQKKY+1Zy+asLnXVg8j4eHgX17O/yWAki+kM87/vw1XlsT5kv1i
 e57vinZkPtaamyUuoKDQLKTUt0fYfTLOMt3uHaN9KtwwrvJhg3O3RYz1DC44ClYMip2T+WBkLt+
 NdY96XRsu1SQ0BfyDJud1Qa8GPjv3pT+3D2qRH7xkBR9RSGn45L6pfNx+qf/GpYwxuLZeViXsop
 aMjJWIgh34OPmGMdRgw==
X-Proofpoint-ORIG-GUID: m5ZdSYtC0b6cPAJF7A0QL30nRnvzjgLu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_02,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601210142

Hi Swapnil.


On 1/19/26 11:28 PM, Swapnil Sapkal wrote:
> '/proc/schedstat' gives the info about load balancing statistics within
> a given domain. It also contains the cpu_mask giving information about
> the sibling cpus and domain names after schedstat version 17. Storing
> this information in perf header will help tools like `perf sched stats`
> for better analysis.
> 
> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
> ---
>   .../Documentation/perf.data-file-format.txt   |  17 ++
>   tools/perf/builtin-inject.c                   |   1 +
>   tools/perf/util/env.c                         |  29 ++
>   tools/perf/util/env.h                         |  17 ++
>   tools/perf/util/header.c                      | 286 ++++++++++++++++++
>   tools/perf/util/header.h                      |   1 +
>   tools/perf/util/util.c                        |  42 +++
>   tools/perf/util/util.h                        |   3 +
>   8 files changed, 396 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
> index c9d4dec65344..0e4d0ecc9e12 100644
> --- a/tools/perf/Documentation/perf.data-file-format.txt
> +++ b/tools/perf/Documentation/perf.data-file-format.txt
> @@ -447,6 +447,23 @@ struct {
>   	} [nr_pmu];
>   };
>   
> +	HEADER_CPU_DOMAIN_INFO = 32,
> +
> +List of cpu-domain relation info. The format of the data is as below.
> +
> +struct domain_info {
> +	int domain;
> +	char dname[];
> +	char cpumask[];
> +	char cpulist[];
> +};
> +
> +struct cpu_domain_info {
> +	int cpu;
> +	int nr_domains;
> +	struct domain_info domains[];
> +};
> +
>   	other bits are reserved and should ignored for now
>   	HEADER_FEAT_BITS	= 256,
>   
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 6080afec537d..587c180035b2 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -2047,6 +2047,7 @@ static bool keep_feat(struct perf_inject *inject, int feat)
>   	case HEADER_CLOCK_DATA:
>   	case HEADER_HYBRID_TOPOLOGY:
>   	case HEADER_PMU_CAPS:
> +	case HEADER_CPU_DOMAIN_INFO:
>   		return true;
>   	/* Information that can be updated */
>   	case HEADER_BUILD_ID:
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index f1626d2032cd..93d475a80f14 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -216,6 +216,34 @@ static void perf_env__purge_bpf(struct perf_env *env __maybe_unused)
>   }
>   #endif // HAVE_LIBBPF_SUPPORT
>   
> +void free_cpu_domain_info(struct cpu_domain_map **cd_map, u32 schedstat_version, u32 nr)
> +{
> +	if (!cd_map)
> +		return;
> +
> +	for (u32 i = 0; i < nr; i++) {
> +		if (!cd_map[i])
> +			continue;
> +
> +		for (u32 j = 0; j < cd_map[i]->nr_domains; j++) {
> +			struct domain_info *d_info = cd_map[i]->domains[j];
> +
> +			if (!d_info)
> +				continue;
> +
> +			if (schedstat_version >= 17)
> +				zfree(&d_info->dname);
> +
> +			zfree(&d_info->cpumask);
> +			zfree(&d_info->cpulist);
> +			zfree(&d_info);
> +		}
> +		zfree(&cd_map[i]->domains);
> +		zfree(&cd_map[i]);
> +	}
> +	zfree(&cd_map);
> +}
> +
>   void perf_env__exit(struct perf_env *env)
>   {
>   	int i, j;
> @@ -265,6 +293,7 @@ void perf_env__exit(struct perf_env *env)
>   		zfree(&env->pmu_caps[i].pmu_name);
>   	}
>   	zfree(&env->pmu_caps);
> +	free_cpu_domain_info(env->cpu_domain, env->schedstat_version, env->nr_cpus_avail);
>   }
>   
>   void perf_env__init(struct perf_env *env)
> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index 9977b85523a8..76ba1a36e9ff 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -54,6 +54,19 @@ struct pmu_caps {
>   	char            *pmu_name;
>   };
>   
> +struct domain_info {
> +	u32	domain;
> +	char	*dname;
> +	char	*cpumask;
> +	char	*cpulist;
> +};
> +
> +struct cpu_domain_map {
> +	u32			cpu;
> +	u32			nr_domains;
> +	struct domain_info	**domains;
> +};
> +
>   typedef const char *(arch_syscalls__strerrno_t)(int err);
>   
>   struct perf_env {
> @@ -70,6 +83,8 @@ struct perf_env {
>   	unsigned int		max_branches;
>   	unsigned int		br_cntr_nr;
>   	unsigned int		br_cntr_width;
> +	unsigned int		schedstat_version;
> +	unsigned int		max_sched_domains;
>   	int			kernel_is_64_bit;
>   
>   	int			nr_cmdline;
> @@ -92,6 +107,7 @@ struct perf_env {
>   	char			**cpu_pmu_caps;
>   	struct cpu_topology_map	*cpu;
>   	struct cpu_cache_level	*caches;
> +	struct cpu_domain_map	**cpu_domain;
>   	int			 caches_cnt;
>   	u32			comp_ratio;
>   	u32			comp_ver;
> @@ -151,6 +167,7 @@ struct bpf_prog_info_node;
>   struct btf_node;
>   
>   int perf_env__read_core_pmu_caps(struct perf_env *env);
> +void free_cpu_domain_info(struct cpu_domain_map **cd_map, u32 schedstat_version, u32 nr);
>   void perf_env__exit(struct perf_env *env);
>   
>   int perf_env__kernel_is_64_bit(struct perf_env *env);
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index f5cad377c99e..673d53bb2a2c 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1614,6 +1614,162 @@ static int write_pmu_caps(struct feat_fd *ff,
>   	return 0;
>   }
>   
> +static struct cpu_domain_map **build_cpu_domain_map(u32 *schedstat_version, u32 *max_sched_domains,
> +						    u32 nr)
> +{
> +	struct domain_info *domain_info;
> +	struct cpu_domain_map **cd_map;
> +	char dname[16], cpumask[256];

You should likely make cpumask and cpulist as NR_CPUS to be
safe.

256 will work till 1024 CPUs no? These days there are systems with
more CPUs than that.

Making it NR_CPUS will likely cover all crazy cases/configurations.

> +	char cpulist[1024];
> +	char *line = NULL;
> +	u32 cpu, domain;
> +	u32 dcount = 0;
> +	size_t len;
> +	FILE *fp;
> +
> +	fp = fopen("/proc/schedstat", "r");
> +	if (!fp) {
> +		pr_err("Failed to open /proc/schedstat\n");
> +		return NULL;
> +	}
> +
> +	cd_map = zalloc(sizeof(*cd_map) * nr);
> +	if (!cd_map)
> +		goto out;
> +
> +	while (getline(&line, &len, fp) > 0) {
> +		int retval;
> +
> +		if (strncmp(line, "version", 7) == 0) {
> +			retval = sscanf(line, "version %d\n", schedstat_version);
> +			if (retval != 1)
> +				continue;
> +
> +		} else if (strncmp(line, "cpu", 3) == 0) {
> +			retval = sscanf(line, "cpu%u %*s", &cpu);
> +			if (retval == 1) {
> +				cd_map[cpu] = zalloc(sizeof(*cd_map[cpu]));
> +				if (!cd_map[cpu])
> +					goto out_free_line;
> +				cd_map[cpu]->cpu = cpu;
> +			} else
> +				continue;
> +
> +			dcount = 0;
> +		} else if (strncmp(line, "domain", 6) == 0) {
> +			struct domain_info **temp_domains;
> +
> +			dcount++;
> +			temp_domains = realloc(cd_map[cpu]->domains, dcount * sizeof(domain_info));
> +			if (!temp_domains)
> +				goto out_free_line;
> +			else
> +				cd_map[cpu]->domains = temp_domains;
> +
> +			domain_info = zalloc(sizeof(*domain_info));
> +			if (!domain_info)
> +				goto out_free_line;
> +
> +			cd_map[cpu]->domains[dcount - 1] = domain_info;
> +
> +			if (*schedstat_version >= 17) {
> +				retval = sscanf(line, "domain%u %s %s %*s", &domain, dname,
> +						cpumask);
> +				if (retval != 3)
> +					continue;
> +
> +				domain_info->dname = strdup(dname);
> +				if (!domain_info->dname)
> +					goto out_free_line;
> +			} else {
> +				retval = sscanf(line, "domain%u %s %*s", &domain, cpumask);
> +				if (retval != 2)
> +					continue;
> +			}
> +
> +			domain_info->domain = domain;
> +			if (domain > *max_sched_domains)
> +				*max_sched_domains = domain;
> +
> +			domain_info->cpumask = strdup(cpumask);
> +			if (!domain_info->cpumask)
> +				goto out_free_line;
> +
> +			cpumask_to_cpulist(cpumask, cpulist);
> +			domain_info->cpulist = strdup(cpulist);
> +			if (!domain_info->cpulist)
> +				goto out_free_line;
> +
> +			cd_map[cpu]->nr_domains = dcount;
> +		}
> +	}
> +
> +out_free_line:
> +	free(line);
> +out:
> +	fclose(fp);
> +	return cd_map;
> +}
> +
> +static int write_cpu_domain_info(struct feat_fd *ff,
> +				 struct evlist *evlist __maybe_unused)
> +{
> +	u32 max_sched_domains = 0, schedstat_version = 0;
> +	struct cpu_domain_map **cd_map;
> +	u32 i, j, nr, ret;
> +
> +	nr = cpu__max_present_cpu().cpu;
> +
> +	cd_map = build_cpu_domain_map(&schedstat_version, &max_sched_domains, nr);
> +	if (!cd_map)
> +		return -1;
> +
> +	ret = do_write(ff, &schedstat_version, sizeof(u32));
> +	if (ret < 0)
> +		goto out;
> +
> +	max_sched_domains += 1;
> +	ret = do_write(ff, &max_sched_domains, sizeof(u32));
> +	if (ret < 0)
> +		goto out;
> +
> +	for (i = 0; i < nr; i++) {
> +		if (!cd_map[i])
> +			continue;
> +
> +		ret = do_write(ff, &cd_map[i]->cpu, sizeof(u32));
> +		if (ret < 0)
> +			goto out;
> +
> +		ret = do_write(ff, &cd_map[i]->nr_domains, sizeof(u32));
> +		if (ret < 0)
> +			goto out;
> +
> +		for (j = 0; j < cd_map[i]->nr_domains; j++) {
> +			ret = do_write(ff, &cd_map[i]->domains[j]->domain, sizeof(u32));
> +			if (ret < 0)
> +				goto out;
> +			if (schedstat_version >= 17) {
> +				ret = do_write_string(ff, cd_map[i]->domains[j]->dname);
> +				if (ret < 0)
> +					goto out;
> +			}
> +
> +			ret = do_write_string(ff, cd_map[i]->domains[j]->cpumask);
> +			if (ret < 0)
> +				goto out;
> +
> +			ret = do_write_string(ff, cd_map[i]->domains[j]->cpulist);
> +			if (ret < 0)
> +				goto out;
> +		}
> +	}
> +
> +out:
> +	free_cpu_domain_info(cd_map, schedstat_version, nr);
> +	return ret;
> +}
> +
>   static void print_hostname(struct feat_fd *ff, FILE *fp)
>   {
>   	fprintf(fp, "# hostname : %s\n", ff->ph->env.hostname);
> @@ -2247,6 +2403,39 @@ static void print_mem_topology(struct feat_fd *ff, FILE *fp)
>   	}
>   }
>   
> +static void print_cpu_domain_info(struct feat_fd *ff, FILE *fp)
> +{
> +	struct cpu_domain_map **cd_map = ff->ph->env.cpu_domain;
> +	u32 nr = ff->ph->env.nr_cpus_avail;
> +	struct domain_info *d_info;
> +	u32 i, j;
> +
> +	fprintf(fp, "# schedstat version	: %u\n", ff->ph->env.schedstat_version);
> +	fprintf(fp, "# Maximum sched domains	: %u\n", ff->ph->env.max_sched_domains);
> +
> +	for (i = 0; i < nr; i++) {
> +		if (!cd_map[i])
> +			continue;
> +
> +		fprintf(fp, "# cpu		: %u\n", cd_map[i]->cpu);
> +		fprintf(fp, "# nr_domains	: %u\n", cd_map[i]->nr_domains);
> +
> +		for (j = 0; j < cd_map[i]->nr_domains; j++) {
> +			d_info = cd_map[i]->domains[j];
> +			if (!d_info)
> +				continue;
> +
> +			fprintf(fp, "# Domain		: %u\n", d_info->domain);
> +
> +			if (ff->ph->env.schedstat_version >= 17)
> +				fprintf(fp, "# Domain name      : %s\n", d_info->dname);
> +
> +			fprintf(fp, "# Domain cpu map   : %s\n", d_info->cpumask);
> +			fprintf(fp, "# Domain cpu list  : %s\n", d_info->cpulist);
> +		}
> +	}
> +}
> +
>   static int __event_process_build_id(struct perf_record_header_build_id *bev,
>   				    char *filename,
>   				    struct perf_session *session)
> @@ -3388,6 +3577,102 @@ static int process_pmu_caps(struct feat_fd *ff, void *data __maybe_unused)
>   	return ret;
>   }
>   
> +static int process_cpu_domain_info(struct feat_fd *ff, void *data __maybe_unused)
> +{
> +	u32 schedstat_version, max_sched_domains, cpu, domain, nr_domains;
> +	struct perf_env *env = &ff->ph->env;
> +	char *dname, *cpumask, *cpulist;
> +	struct cpu_domain_map **cd_map;
> +	struct domain_info *d_info;
> +	u32 nra, nr, i, j;
> +	int ret;
> +
> +	nra = env->nr_cpus_avail;
> +	nr = env->nr_cpus_online;
> +
> +	cd_map = zalloc(sizeof(*cd_map) * nra);
> +	if (!cd_map)
> +		return -1;
> +
> +	env->cpu_domain = cd_map;
> +
> +	ret = do_read_u32(ff, &schedstat_version);
> +	if (ret)
> +		return ret;
> +
> +	env->schedstat_version = schedstat_version;
> +
> +	ret = do_read_u32(ff, &max_sched_domains);
> +	if (ret)
> +		return ret;
> +
> +	env->max_sched_domains = max_sched_domains;
> +
> +	for (i = 0; i < nr; i++) {
> +		if (do_read_u32(ff, &cpu))
> +			return -1;
> +
> +		cd_map[cpu] = zalloc(sizeof(*cd_map[cpu]));
> +		if (!cd_map[cpu])
> +			return -1;
> +
> +		cd_map[cpu]->cpu = cpu;
> +
> +		if (do_read_u32(ff, &nr_domains))
> +			return -1;
> +
> +		cd_map[cpu]->nr_domains = nr_domains;
> +
> +		cd_map[cpu]->domains = zalloc(sizeof(*d_info) * max_sched_domains);
> +		if (!cd_map[cpu]->domains)
> +			return -1;
> +
> +		for (j = 0; j < nr_domains; j++) {
> +			if (do_read_u32(ff, &domain))
> +				return -1;
> +
> +			d_info = zalloc(sizeof(*d_info));
> +			if (!d_info)
> +				return -1;
> +
> +			cd_map[cpu]->domains[domain] = d_info;
> +			d_info->domain = domain;
> +
> +			if (schedstat_version >= 17) {
> +				dname = do_read_string(ff);
> +				if (!dname)
> +					return -1;
> +
> +				d_info->dname = zalloc(strlen(dname) + 1);
> +				if (!d_info->dname)
> +					return -1;
> +
> +				d_info->dname = strdup(dname);
> +			}
> +
> +			cpumask = do_read_string(ff);
> +			if (!cpumask)
> +				return -1;
> +
> +			d_info->cpumask = zalloc(strlen(cpumask) + 1);
> +			if (!d_info->cpumask)
> +				return -1;
> +			d_info->cpumask = strdup(cpumask);
> +
> +			cpulist = do_read_string(ff);
> +			if (!cpulist)
> +				return -1;
> +
> +			d_info->cpulist = zalloc(strlen(cpulist) + 1);
> +			if (!d_info->cpulist)
> +				return -1;
> +			d_info->cpulist = strdup(cpulist);
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>   #define FEAT_OPR(n, func, __full_only) \
>   	[HEADER_##n] = {					\
>   		.name	    = __stringify(n),			\
> @@ -3453,6 +3738,7 @@ const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE] = {
>   	FEAT_OPR(CLOCK_DATA,	clock_data,	false),
>   	FEAT_OPN(HYBRID_TOPOLOGY,	hybrid_topology,	true),
>   	FEAT_OPR(PMU_CAPS,	pmu_caps,	false),
> +	FEAT_OPR(CPU_DOMAIN_INFO,	cpu_domain_info,	true),
>   };
>   
>   struct header_print_data {
> diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
> index c058021c3150..c62f3275a80f 100644
> --- a/tools/perf/util/header.h
> +++ b/tools/perf/util/header.h
> @@ -53,6 +53,7 @@ enum {
>   	HEADER_CLOCK_DATA,
>   	HEADER_HYBRID_TOPOLOGY,
>   	HEADER_PMU_CAPS,
> +	HEADER_CPU_DOMAIN_INFO,
>   	HEADER_LAST_FEATURE,
>   	HEADER_FEAT_BITS	= 256,
>   };
> diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> index 0f031eb80b4c..b87ff96a9f45 100644
> --- a/tools/perf/util/util.c
> +++ b/tools/perf/util/util.c
> @@ -257,6 +257,48 @@ static int rm_rf_kcore_dir(const char *path)
>   	return 0;
>   }
>   
> +void cpumask_to_cpulist(char *cpumask, char *cpulist)
> +{
> +	int i, j, bm_size, nbits;
> +	int len = strlen(cpumask);
> +	unsigned long *bm;
> +	char cpus[1024];
> +
> +	for (i = 0; i < len; i++) {
> +		if (cpumask[i] == ',') {
> +			for (j = i; j < len; j++)
> +				cpumask[j] = cpumask[j + 1];
> +		}
> +	}
> +
> +	len = strlen(cpumask);
> +	bm_size = (len + 15) / 16;
> +	nbits = bm_size * 64;
> +	if (nbits <= 0)
> +		return;
> +
> +	bm = calloc(bm_size, sizeof(unsigned long));
> +	if (!cpumask)
> +		goto free_bm;
> +
> +	for (i = 0; i < bm_size; i++) {
> +		char blk[17];
> +		int blklen = len > 16 ? 16 : len;
> +
> +		strncpy(blk, cpumask + len - blklen, blklen);
> +		blk[blklen] = '\0';
> +		bm[i] = strtoul(blk, NULL, 16);
> +		cpumask[len - blklen] = '\0';
> +		len = strlen(cpumask);
> +	}
> +
> +	bitmap_scnprintf(bm, nbits, cpus, sizeof(cpus));
> +	strcpy(cpulist, cpus);
> +
> +free_bm:
> +	free(bm);
> +}
> +
>   int rm_rf_perf_data(const char *path)
>   {
>   	const char *pat[] = {
> diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
> index 3423778e39a5..1572c8cf04e5 100644
> --- a/tools/perf/util/util.h
> +++ b/tools/perf/util/util.h
> @@ -11,6 +11,7 @@
>   #include <stdbool.h>
>   #include <stddef.h>
>   #include <linux/compiler.h>
> +#include <linux/bitmap.h>
>   #include <sys/types.h>
>   #ifndef __cplusplus
>   #include <internal/cpumap.h>
> @@ -48,6 +49,8 @@ bool sysctl__nmi_watchdog_enabled(void);
>   
>   int perf_tip(char **strp, const char *dirpath);
>   
> +void cpumask_to_cpulist(char *cpumask, char *cpulist);
> +
>   #ifndef HAVE_SCHED_GETCPU_SUPPORT
>   int sched_getcpu(void);
>   #endif

