Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2292459E5;
	Tue, 10 Jun 2025 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749586864; cv=none; b=qnc/L8SssbPyFtuSUp/fNN47oNaBvsPoo0DBSz7iAkDlTLw4E8SQGt2hlvPUQSR1BAJRoF9XJzUbUmfPX1yc4835AWO2MpElYGtwjhOfY+/CxiLe/UNV/xJoXiRnMInQ4690dxZ3AXVNpeSBw2oE/AF5a8feBsXS6KuybK5D81A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749586864; c=relaxed/simple;
	bh=LEifNSrBrcNzpAJHHLhm0Tgx0opLdvBmGm0BoqrjRzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBzL+yTyTAPR4Q3gLIFjlv0qG8fLRW8uljCLka5RW27jfcKrFu4B4DscfKj/n50+N5g4YslkLCIxDbFALVgMjP9KKh7yS3TQJx3oC2MNoQbmuKwoA+3GBjLduO2VrXaksBp9UqpJGoRXJgpSXEY7fUw4oigRhY2fNzErWrPo5HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9VXL7hr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9VXL7hr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B910C4CEED;
	Tue, 10 Jun 2025 20:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749586863;
	bh=LEifNSrBrcNzpAJHHLhm0Tgx0opLdvBmGm0BoqrjRzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C9VXL7hrkL7cfMDvL/Y+ijQs+Qkbh5yasySGr1CgWd4CvVVtzBHdPHTuH3yi/fZRl
	 cvZcu+qYYLKcLcO0OIkDL9nYJXvOl166yLo1Li250aNgBpyVCDB9nAOCwtHN8Hsh9u
	 fj2brdvkRBju3ut2sXB/+ApUMcMr5t/47xQVVNDFdmgACFK31HZbUcEYaj99Rnewu+
	 z/kDslY3ngAcOjTxInyRICdndrbZNLlKcW6rVMSn9hLxPcn6yVbruV2eMLm4UXUPX4
	 RHlE5kx4AKAr0RI19bP7sCK0WXVFxTzaFIErdWe06rEND9GZNSp119r72mp0rIEUzb
	 fdDuk2HxJE8oA==
Date: Tue, 10 Jun 2025 13:21:01 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "Falcon, Thomas" <thomas.falcon@intel.com>,
	Ian Rogers <irogers@google.com>
Cc: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"acme@kernel.org" <acme@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 2/2 v3] perf top: populate PMU capabilities data in
 perf_env
Message-ID: <aEiTrRNyeqFsYwR6@google.com>
References: <20250513231813.13846-1-thomas.falcon@intel.com>
 <20250513231813.13846-2-thomas.falcon@intel.com>
 <a327dc2e5837a743a08403b5ad58dbe5e8c4f926.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a327dc2e5837a743a08403b5ad58dbe5e8c4f926.camel@intel.com>

Hello,

On Mon, Jun 09, 2025 at 04:21:39PM +0000, Falcon, Thomas wrote:
> Ping?

Sorry for the delay, I'll process the series as it's reviewed by Ian.
Ian, it may clash with your perf_env cleanup though.

Also note that please don't mix patch versions.  The 1/2 is v1 and 2/2
v3 - it makes b4 confused.

Thanks,
Namhyung

> 
> On Tue, 2025-05-13 at 18:18 -0500, Thomas Falcon wrote:
> > Calling perf top with branch filters enabled on Intel CPU's
> > with branch counters logging (A.K.A LBR event logging [1]) support
> > results in a segfault.
> > 
> > Thread 27 "perf" received signal SIGSEGV, Segmentation fault.
> > [Switching to Thread 0x7fffafff76c0 (LWP 949003)]
> > perf_env__find_br_cntr_info (env=0xf66dc0 <perf_env>, nr=0x0, width=0x7fffafff62c0) at util/env.c:653
> > 653			*width = env->cpu_pmu_caps ? env->br_cntr_width :
> > (gdb) bt
> >  #0  perf_env__find_br_cntr_info (env=0xf66dc0 <perf_env>, nr=0x0, width=0x7fffafff62c0) at util/env.c:653
> >  #1  0x00000000005b1599 in symbol__account_br_cntr (branch=0x7fffcc3db580, evsel=0xfea2d0, offset=12, br_cntr=8) at util/annotate.c:345
> >  #2  0x00000000005b17fb in symbol__account_cycles (addr=5658172, start=5658160, sym=0x7fffcc0ee420, cycles=539, evsel=0xfea2d0, br_cntr=8) at util/annotate.c:389
> >  #3  0x00000000005b1976 in addr_map_symbol__account_cycles (ams=0x7fffcd7b01d0, start=0x7fffcd7b02b0, cycles=539, evsel=0xfea2d0, br_cntr=8) at util/annotate.c:422
> >  #4  0x000000000068d57f in hist__account_cycles (bs=0x110d288, al=0x7fffafff6540, sample=0x7fffafff6760, nonany_branch_mode=false, total_cycles=0x0, evsel=0xfea2d0) at util/hist.c:2850
> >  #5  0x0000000000446216 in hist_iter__top_callback (iter=0x7fffafff6590, al=0x7fffafff6540, single=true, arg=0x7fffffff9e00) at builtin-top.c:737
> >  #6  0x0000000000689787 in hist_entry_iter__add (iter=0x7fffafff6590, al=0x7fffafff6540, max_stack_depth=127, arg=0x7fffffff9e00) at util/hist.c:1359
> >  #7  0x0000000000446710 in perf_event__process_sample (tool=0x7fffffff9e00, event=0x110d250, evsel=0xfea2d0, sample=0x7fffafff6760, machine=0x108c968) at builtin-top.c:845
> >  #8  0x0000000000447735 in deliver_event (qe=0x7fffffffa120, qevent=0x10fc200) at builtin-top.c:1211
> >  #9  0x000000000064ccae in do_flush (oe=0x7fffffffa120, show_progress=false) at util/ordered-events.c:245
> >  #10 0x000000000064d005 in __ordered_events__flush (oe=0x7fffffffa120, how=OE_FLUSH__TOP, timestamp=0) at util/ordered-events.c:324
> >  #11 0x000000000064d0ef in ordered_events__flush (oe=0x7fffffffa120, how=OE_FLUSH__TOP) at util/ordered-events.c:342
> >  #12 0x00000000004472a9 in process_thread (arg=0x7fffffff9e00) at builtin-top.c:1120
> >  #13 0x00007ffff6e7dba8 in start_thread (arg=<optimized out>) at pthread_create.c:448
> >  #14 0x00007ffff6f01b8c in __GI___clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:78
> > 
> > The cause is that perf_env__find_br_cntr_info tries to access a
> > null pointer pmu_caps in the perf_env struct. A similar issue exists
> > for homogeneous core systems which use the cpu_pmu_caps structure.
> > 
> > Fix this by populating cpu_pmu_caps and pmu_caps structures with
> > values from sysfs when calling perf top with branch stack sampling
> > enabled.
> > 
> > [1], LBR event logging introduced here:
> > https://lore.kernel.org/all/20231025201626.3000228-5-kan.liang@linux.intel.com/
> > 
> > Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> > ---
> > v3: constify struct perf_pmu *pmu in __perf_env__read_core_pmu_caps()
> >     use perf_pmus__find_core_pmu() instead of perf_pmus__scan_core(NULL)
> > 
> > v2: update commit message with more meaningful stack trace from
> >     gdb and indicate that affected systems are limited to CPU's
> >     with LBR event logging support and that both hybrid and
> >     non-hybrid core systems are affected.
> > ---
> >  tools/perf/builtin-top.c |   8 +++
> >  tools/perf/util/env.c    | 114 +++++++++++++++++++++++++++++++++++++++
> >  tools/perf/util/env.h    |   1 +
> >  3 files changed, 123 insertions(+)
> > 
> > diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> > index f9f31391bddb..c9d679410591 100644
> > --- a/tools/perf/builtin-top.c
> > +++ b/tools/perf/builtin-top.c
> > @@ -1729,6 +1729,14 @@ int cmd_top(int argc, const char **argv)
> >  	if (opts->branch_stack && callchain_param.enabled)
> >  		symbol_conf.show_branchflag_count = true;
> >  
> > +	if (opts->branch_stack) {
> > +		status = perf_env__read_core_pmu_caps(&perf_env);
> > +		if (status) {
> > +			pr_err("PMU capability data is not available\n");
> > +			goto out_delete_evlist;
> > +		}
> > +	}
> > +
> >  	sort__mode = SORT_MODE__TOP;
> >  	/* display thread wants entries to be collapsed in a different tree */
> >  	perf_hpp_list.need_collapse = 1;
> > diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> > index 36411749e007..6735786a1d22 100644
> > --- a/tools/perf/util/env.c
> > +++ b/tools/perf/util/env.c
> > @@ -416,6 +416,120 @@ static int perf_env__read_nr_cpus_avail(struct perf_env *env)
> >  	return env->nr_cpus_avail ? 0 : -ENOENT;
> >  }
> >  
> > +static int __perf_env__read_core_pmu_caps(const struct perf_pmu *pmu,
> > +					  int *nr_caps, char ***caps,
> > +					  unsigned int *max_branches,
> > +					  unsigned int *br_cntr_nr,
> > +					  unsigned int *br_cntr_width)
> > +{
> > +	struct perf_pmu_caps *pcaps = NULL;
> > +	char *ptr, **tmp;
> > +	int ret = 0;
> > +
> > +	*nr_caps = 0;
> > +	*caps = NULL;
> > +
> > +	if (!pmu->nr_caps)
> > +		return 0;
> > +
> > +	*caps = zalloc(sizeof(char *) * pmu->nr_caps);
> > +	if (!*caps)
> > +		return -ENOMEM;
> > +
> > +	tmp = *caps;
> > +	list_for_each_entry(pcaps, &pmu->caps, list) {
> > +
> > +		if (asprintf(&ptr, "%s=%s", pcaps->name, pcaps->value) < 0) {
> > +			ret = -ENOMEM;
> > +			goto error;
> > +		}
> > +
> > +		*tmp++ = ptr;
> > +
> > +		if (!strcmp(pcaps->name, "branches"))
> > +			*max_branches = atoi(pcaps->value);
> > +
> > +		if (!strcmp(pcaps->name, "branch_counter_nr"))
> > +			*br_cntr_nr = atoi(pcaps->value);
> > +
> > +		if (!strcmp(pcaps->name, "branch_counter_width"))
> > +			*br_cntr_width = atoi(pcaps->value);
> > +	}
> > +	*nr_caps = pmu->nr_caps;
> > +	return 0;
> > +error:
> > +	while (tmp-- != *caps)
> > +		free(*tmp);
> > +	free(*caps);
> > +	*caps = NULL;
> > +	*nr_caps = 0;
> > +	return ret;
> > +}
> > +
> > +int perf_env__read_core_pmu_caps(struct perf_env *env)
> > +{
> > +	struct perf_pmu *pmu = NULL;
> > +	struct pmu_caps *pmu_caps;
> > +	int nr_pmu = 0, i = 0, j;
> > +	int ret;
> > +
> > +	nr_pmu = perf_pmus__num_core_pmus();
> > +
> > +	if (!nr_pmu)
> > +		return -ENODEV;
> > +
> > +	if (nr_pmu == 1) {
> > +		pmu = perf_pmus__find_core_pmu();
> > +		if (!pmu)
> > +			return -ENODEV;
> > +		ret = perf_pmu__caps_parse(pmu);
> > +		if (ret < 0)
> > +			return ret;
> > +		return __perf_env__read_core_pmu_caps(pmu, &env->nr_cpu_pmu_caps,
> > +						      &env->cpu_pmu_caps,
> > +						      &env->max_branches,
> > +						      &env->br_cntr_nr,
> > +						      &env->br_cntr_width);
> > +	}
> > +
> > +	pmu_caps = zalloc(sizeof(*pmu_caps) * nr_pmu);
> > +	if (!pmu_caps)
> > +		return -ENOMEM;
> > +
> > +	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
> > +		if (perf_pmu__caps_parse(pmu) <= 0)
> > +			continue;
> > +		ret = __perf_env__read_core_pmu_caps(pmu, &pmu_caps[i].nr_caps,
> > +						     &pmu_caps[i].caps,
> > +						     &pmu_caps[i].max_branches,
> > +						     &pmu_caps[i].br_cntr_nr,
> > +						     &pmu_caps[i].br_cntr_width);
> > +		if (ret)
> > +			goto error;
> > +
> > +		pmu_caps[i].pmu_name = strdup(pmu->name);
> > +		if (!pmu_caps[i].pmu_name) {
> > +			ret = -ENOMEM;
> > +			goto error;
> > +		}
> > +		i++;
> > +	}
> > +
> > +	env->nr_pmus_with_caps = nr_pmu;
> > +	env->pmu_caps = pmu_caps;
> > +
> > +	return 0;
> > +error:
> > +	for (i = 0; i < nr_pmu; i++) {
> > +		for (j = 0; j < pmu_caps[i].nr_caps; j++)
> > +			free(pmu_caps[i].caps[j]);
> > +		free(pmu_caps[i].caps);
> > +		free(pmu_caps[i].pmu_name);
> > +	}
> > +	free(pmu_caps);
> > +	return ret;
> > +}
> > +
> >  const char *perf_env__raw_arch(struct perf_env *env)
> >  {
> >  	return env && !perf_env__read_arch(env) ? env->arch : "unknown";
> > diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> > index d90e343cf1fa..135a1f714905 100644
> > --- a/tools/perf/util/env.h
> > +++ b/tools/perf/util/env.h
> > @@ -152,6 +152,7 @@ struct btf_node;
> >  
> >  extern struct perf_env perf_env;
> >  
> > +int perf_env__read_core_pmu_caps(struct perf_env *env);
> >  void perf_env__exit(struct perf_env *env);
> >  
> >  int perf_env__kernel_is_64_bit(struct perf_env *env);
> 
