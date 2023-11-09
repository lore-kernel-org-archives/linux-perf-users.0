Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD6936B11
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Nov 2023 19:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOvtThX+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8351FC433C8;
	Thu,  9 Nov 2023 19:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699559777;
	bh=QXPODse8o2394/LKml7r+8fnAQlcRnH/e6QYByqs4xI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gOvtThX+NyUsrhn+dehgSs2/lePI/Ebxt3HPRRXtzcerau75AiILWUJM81V7mswbk
	 sD6JSj3qO1T2dgSHuQ8k0Pi+KBdGOTXfW8eVXVIL5BQqaXszzAhW5sbVR88aPR+GfT
	 HigHc3L5hyW+EcMuH0vdz8jaXZIM3U7qM4bk3KSHGcnoxDwpwA9en2aSOZPz4PIDnl
	 WWyYjBJtMytvMH2nP6M5sR9WtkDbsbBEljakalAdaVdK8ox8HZCMQCmb8mNeF8+9vt
	 6hMOuZ7Tr512NRB7y1F8lMYfv8/UuCjhtfF720oTmnT+STI/7HGgITr5DyN0wuRSZN
	 T7/bRYGzsgCmQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 1CA3340094; Thu,  9 Nov 2023 16:56:15 -0300 (-03)
Date: Thu, 9 Nov 2023 16:56:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: namhyung@kernel.org, kim.phillips@amd.com, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, changbin.du@huawei.com,
	yangjihong1@huawei.com, zwisler@chromium.org,
	wangming01@loongson.cn, chenhuacai@kernel.org,
	kprateek.nayak@amd.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, sandipan.das@amd.com,
	ananth.narayan@amd.com, santosh.shukla@amd.com
Subject: Re: [PATCH 2/2] perf header: Additional note on AMD IBS for
 max_precise pmu cap
Message-ID: <ZU05X1SLwk1NTW59@kernel.org>
References: <20231107083331.901-1-ravi.bangoria@amd.com>
 <20231107083331.901-2-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107083331.901-2-ravi.bangoria@amd.com>
X-Url: http://acmel.wordpress.com

Em Tue, Nov 07, 2023 at 02:03:31PM +0530, Ravi Bangoria escreveu:
> From: Arnaldo Carvalho de Melo <acme@kernel.org>

Applied this one, waiting for some more time to address Ian comments,

- Arnaldo
 
> x86 core pmu exposes supported maximum precision level via max_precise
> pmu capability. Although, AMD core pmu does not support precise mode,
> certain core pmu events with precise_ip > 0 are allowed and forwarded
> to IBS OP pmu. Display a note about this in perf report header and
> document the details in the perf-list man page.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  tools/perf/Documentation/perf-list.txt | 12 +++++++-----
>  tools/perf/util/env.c                  | 18 ++++++++++++++++++
>  tools/perf/util/env.h                  |  2 ++
>  tools/perf/util/header.c               |  8 ++++++++
>  4 files changed, 35 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
> index d5f78e125efe..1b90575ee3c8 100644
> --- a/tools/perf/Documentation/perf-list.txt
> +++ b/tools/perf/Documentation/perf-list.txt
> @@ -81,11 +81,13 @@ For Intel systems precise event sampling is implemented with PEBS
>  which supports up to precise-level 2, and precise level 3 for
>  some special cases
>  
> -On AMD systems it is implemented using IBS (up to precise-level 2).
> -The precise modifier works with event types 0x76 (cpu-cycles, CPU
> -clocks not halted) and 0xC1 (micro-ops retired). Both events map to
> -IBS execution sampling (IBS op) with the IBS Op Counter Control bit
> -(IbsOpCntCtl) set respectively (see the
> +On AMD systems it is implemented using IBS OP (up to precise-level 2).
> +Unlike Intel PEBS which provides levels of precision, AMD core pmu is
> +inherently non-precise and IBS is inherently precise. (i.e. ibs_op//,
> +ibs_op//p, ibs_op//pp and ibs_op//ppp are all same). The precise modifier
> +works with event types 0x76 (cpu-cycles, CPU clocks not halted) and 0xC1
> +(micro-ops retired). Both events map to IBS execution sampling (IBS op)
> +with the IBS Op Counter Control bit (IbsOpCntCtl) set respectively (see the
>  Core Complex (CCX) -> Processor x86 Core -> Instruction Based Sampling (IBS)
>  section of the [AMD Processor Programming Reference (PPR)] relevant to the
>  family, model and stepping of the processor being used).
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index 44140b7f596a..cbc18b22ace5 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -531,6 +531,24 @@ int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu)
>  	return cpu.cpu >= 0 && cpu.cpu < env->nr_numa_map ? env->numa_map[cpu.cpu] : -1;
>  }
>  
> +bool perf_env__has_pmu_mapping(struct perf_env *env, const char *pmu_name)
> +{
> +	char *pmu_mapping = env->pmu_mappings, *colon;
> +
> +	for (int i = 0; i < env->nr_pmu_mappings; ++i) {
> +		if (strtoul(pmu_mapping, &colon, 0) == ULONG_MAX || *colon != ':')
> +			goto out_error;
> +
> +		pmu_mapping = colon + 1;
> +		if (strcmp(pmu_mapping, pmu_name) == 0)
> +			return true;
> +
> +		pmu_mapping += strlen(pmu_mapping) + 1;
> +	}
> +out_error:
> +	return false;
> +}
> +
>  char *perf_env__find_pmu_cap(struct perf_env *env, const char *pmu_name,
>  			     const char *cap)
>  {
> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index 4566c51f2fd9..56aea562c61b 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -174,4 +174,6 @@ struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id);
>  int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu);
>  char *perf_env__find_pmu_cap(struct perf_env *env, const char *pmu_name,
>  			     const char *cap);
> +
> +bool perf_env__has_pmu_mapping(struct perf_env *env, const char *pmu_name);
>  #endif /* __PERF_ENV_H */
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index e86b9439ffee..3cc288d14002 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -2145,6 +2145,14 @@ static void print_pmu_caps(struct feat_fd *ff, FILE *fp)
>  		__print_pmu_caps(fp, pmu_caps->nr_caps, pmu_caps->caps,
>  				 pmu_caps->pmu_name);
>  	}
> +
> +	if (strcmp(perf_env__arch(&ff->ph->env), "x86") == 0 &&
> +	    perf_env__has_pmu_mapping(&ff->ph->env, "ibs_op")) {
> +		char *max_precise = perf_env__find_pmu_cap(&ff->ph->env, "cpu", "max_precise");
> +
> +		if (max_precise != NULL && atoi(max_precise) == 0)
> +			fprintf(fp, "# AMD systems uses ibs_op// PMU for some precise events, e.g.: cycles:p, see the 'perf list' man page for further details.\n");
> +	}
>  }
>  
>  static void print_pmu_mappings(struct feat_fd *ff, FILE *fp)
> -- 
> 2.41.0
> 

-- 

- Arnaldo
