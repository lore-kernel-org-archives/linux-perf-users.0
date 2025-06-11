Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4FEA59;
	Wed, 11 Jun 2025 21:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749677608; cv=none; b=dlHkEZJ0BItvBQs0am0iNtBr78QA+uF0hA+/uNWlnMWnai31g3XEutqFASSgUACAcEkoK6drVg1R+VxyE0tguyrSsZYxPwZ7bERig7ziNLUgJ1PXZIf2muBh3vpSYoOKq1/gtfay+QVh0PrLbAmwtoCjaKNgVWsqZ9Ksta8MJ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749677608; c=relaxed/simple;
	bh=WspaWX6ltyvacFoa8VcS7DEX6oFplc+kX3bMWPCvjH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svbjnDH9eJ7BEqC66fxVdssxXBixZWnSwvFNa6soTaM10PxhgYw+lwCEEPVk8almDuY/sAeLwMSDCfHApUlG+Nci31G+rr637nFv4F71JPbXtHkygbhZqequdFnW8K82/IXbE9PR1GXd74aoXipFRGgrQp3qET7XAnyIJ0T1fa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dgjocorr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dgjocorr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9301CC4CEE3;
	Wed, 11 Jun 2025 21:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749677607;
	bh=WspaWX6ltyvacFoa8VcS7DEX6oFplc+kX3bMWPCvjH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DgjocorrzyV6LlvqYeg47ovX2DinXNDpF12+GXVscQTnE68zu9B17SOx8+2GS3lKE
	 GfwiQFWta0ITGkvZVPzcBph27PxWAqX6iIMB4P/IWj4z3TCnshCpERY8/HDuKFMlhz
	 NL2ngBo5Ldpv3o8ZkZz0A/r44C0gPwfojlyOmsL7z3rQfclup1+mI4POxg9igIKFl1
	 jGHmQOdrO7BlSMgDdePW1L42LHcUA8EU+HMWz5nx7/I8XIih0qqf5/VIueuYcZodiU
	 qSdTJlkLVKwxcZcSsNd3BhIdbgFSmJxPA7Ez66yumFKoQXczh5H+G4EWiUF9Iv+jNt
	 0sJqE528PodTQ==
Date: Wed, 11 Jun 2025 18:33:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: "Falcon, Thomas" <thomas.falcon@intel.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"irogers@google.com" <irogers@google.com>
Subject: Re: [PATCH 2/2 v3] perf top: populate PMU capabilities data in
 perf_env
Message-ID: <aEn2JVfsx8aVIe3t@x1>
References: <20250513231813.13846-1-thomas.falcon@intel.com>
 <20250513231813.13846-2-thomas.falcon@intel.com>
 <a327dc2e5837a743a08403b5ad58dbe5e8c4f926.camel@intel.com>
 <aEiUqtB9Zg9ZBQO6@x1>
 <6445eecf1767aa7e4a64af2feed48075ac101a1c.camel@intel.com>
 <aEnpFxn9DUz_usV0@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEnpFxn9DUz_usV0@google.com>

On Wed, Jun 11, 2025 at 01:37:43PM -0700, Namhyung Kim wrote:
> On Wed, Jun 11, 2025 at 07:00:04PM +0000, Falcon, Thomas wrote:
> > On Tue, 2025-06-10 at 17:25 -0300, Arnaldo Carvalho de Melo wrote:
> > > On Mon, Jun 09, 2025 at 04:21:39PM +0000, Falcon, Thomas wrote:
> > > > Ping?
> > > > 
> > > > Thanks,
> > > > Tom
> > > > 
> > > > On Tue, 2025-05-13 at 18:18 -0500, Thomas Falcon wrote:
> > > > > Calling perf top with branch filters enabled on Intel CPU's
> > > > > with branch counters logging (A.K.A LBR event logging [1]) support
> > > > > results in a segfault.
> > > > > 
> > > > > Thread 27 "perf" received signal SIGSEGV, Segmentation fault.
> > > > > [Switching to Thread 0x7fffafff76c0 (LWP 949003)]
> > > > > perf_env__find_br_cntr_info (env=0xf66dc0 <perf_env>, nr=0x0, width=0x7fffafff62c0) at util/env.c:653
> > > > > 653			*width = env->cpu_pmu_caps ? env->br_cntr_width :
> > > > > (gdb) bt
> > > > >  #0  perf_env__find_br_cntr_info (env=0xf66dc0 <perf_env>, nr=0x0, width=0x7fffafff62c0) at util/env.c:653
> > > > >  #1  0x00000000005b1599 in symbol__account_br_cntr (branch=0x7fffcc3db580, evsel=0xfea2d0, offset=12, br_cntr=8) at util/annotate.c:345
> > > > >  #2  0x00000000005b17fb in symbol__account_cycles (addr=5658172, start=5658160, sym=0x7fffcc0ee420, cycles=539, evsel=0xfea2d0, br_cntr=8) at util/annotate.c:389
> > > > >  #3  0x00000000005b1976 in addr_map_symbol__account_cycles (ams=0x7fffcd7b01d0, start=0x7fffcd7b02b0, cycles=539, evsel=0xfea2d0, br_cntr=8) at util/annotate.c:422
> > > > >  #4  0x000000000068d57f in hist__account_cycles (bs=0x110d288, al=0x7fffafff6540, sample=0x7fffafff6760, nonany_branch_mode=false, total_cycles=0x0, evsel=0xfea2d0) at util/hist.c:2850
> > > > >  #5  0x0000000000446216 in hist_iter__top_callback (iter=0x7fffafff6590, al=0x7fffafff6540, single=true, arg=0x7fffffff9e00) at builtin-top.c:737
> > > > >  #6  0x0000000000689787 in hist_entry_iter__add (iter=0x7fffafff6590, al=0x7fffafff6540, max_stack_depth=127, arg=0x7fffffff9e00) at util/hist.c:1359
> > > > >  #7  0x0000000000446710 in perf_event__process_sample (tool=0x7fffffff9e00, event=0x110d250, evsel=0xfea2d0, sample=0x7fffafff6760, machine=0x108c968) at builtin-top.c:845
> > > > >  #8  0x0000000000447735 in deliver_event (qe=0x7fffffffa120, qevent=0x10fc200) at builtin-top.c:1211
> > > > >  #9  0x000000000064ccae in do_flush (oe=0x7fffffffa120, show_progress=false) at util/ordered-events.c:245
> > > > >  #10 0x000000000064d005 in __ordered_events__flush (oe=0x7fffffffa120, how=OE_FLUSH__TOP, timestamp=0) at util/ordered-events.c:324
> > > > >  #11 0x000000000064d0ef in ordered_events__flush (oe=0x7fffffffa120, how=OE_FLUSH__TOP) at util/ordered-events.c:342
> > > > >  #12 0x00000000004472a9 in process_thread (arg=0x7fffffff9e00) at builtin-top.c:1120
> > > > >  #13 0x00007ffff6e7dba8 in start_thread (arg=<optimized out>) at pthread_create.c:448
> > > > >  #14 0x00007ffff6f01b8c in __GI___clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:78
> > > > > 
> > > > > The cause is that perf_env__find_br_cntr_info tries to access a
> > > > > null pointer pmu_caps in the perf_env struct. A similar issue exists
> > > > > for homogeneous core systems which use the cpu_pmu_caps structure.
> > > > > 
> > > > > Fix this by populating cpu_pmu_caps and pmu_caps structures with
> > > > > values from sysfs when calling perf top with branch stack sampling
> > > > > enabled.
> > > > > 
> > > > > [1], LBR event logging introduced here:
> > > > > https://lore.kernel.org/all/20231025201626.3000228-5-kan.liang@linux.intel.com/
> > > > > 
> > > > > Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> > > > > ---
> > > > > v3: constify struct perf_pmu *pmu in __perf_env__read_core_pmu_caps()
> > > > >     use perf_pmus__find_core_pmu() instead of perf_pmus__scan_core(NULL)
> > > > > 
> > > > > v2: update commit message with more meaningful stack trace from
> > > > >     gdb and indicate that affected systems are limited to CPU's
> > > > >     with LBR event logging support and that both hybrid and
> > > > >     non-hybrid core systems are affected.
> > > > > ---
> > > > >  tools/perf/builtin-top.c |   8 +++
> > > > >  tools/perf/util/env.c    | 114 +++++++++++++++++++++++++++++++++++++++
> > > > >  tools/perf/util/env.h    |   1 +
> > > > >  3 files changed, 123 insertions(+)
> > > > > 
> > > > > diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> > > > > index f9f31391bddb..c9d679410591 100644
> > > > > --- a/tools/perf/builtin-top.c
> > > > > +++ b/tools/perf/builtin-top.c
> > > > > @@ -1729,6 +1729,14 @@ int cmd_top(int argc, const char **argv)
> > > > >  	if (opts->branch_stack && callchain_param.enabled)
> > > > >  		symbol_conf.show_branchflag_count = true;
> > > > >  
> > > > > +	if (opts->branch_stack) {
> > > > > +		status = perf_env__read_core_pmu_caps(&perf_env);
> > > > > +		if (status) {
> > > > > +			pr_err("PMU capability data is not available\n");
> > > > > +			goto out_delete_evlist;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > >  	sort__mode = SORT_MODE__TOP;
> > > > >  	/* display thread wants entries to be collapsed in a different tree */
> > > > >  	perf_hpp_list.need_collapse = 1;
> > > > > diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> > > > > index 36411749e007..6735786a1d22 100644
> > > > > --- a/tools/perf/util/env.c
> > > > > +++ b/tools/perf/util/env.c
> > > > > @@ -416,6 +416,120 @@ static int perf_env__read_nr_cpus_avail(struct perf_env *env)
> > > > >  	return env->nr_cpus_avail ? 0 : -ENOENT;
> > > > >  }
> > > > >  
> > > > > +static int __perf_env__read_core_pmu_caps(const struct perf_pmu *pmu,
> > > > > +					  int *nr_caps, char ***caps,
> > > > > +					  unsigned int *max_branches,
> > > > > +					  unsigned int *br_cntr_nr,
> > > > > +					  unsigned int *br_cntr_width)
> > > > > +{
> > > > > +	struct perf_pmu_caps *pcaps = NULL;
> > > > > +	char *ptr, **tmp;
> > > > > +	int ret = 0;
> > > > > +
> > > > > +	*nr_caps = 0;
> > > > > +	*caps = NULL;
> > > > > +
> > > > > +	if (!pmu->nr_caps)
> > > > > +		return 0;
> > > > > +
> > > > > +	*caps = zalloc(sizeof(char *) * pmu->nr_caps);

> > > calloc?

> > Thanks for reviewing. Is there a reason not to use zalloc here or is this related to using free
> > instead of zfree later?
 
> Conceptually, zmalloc() = malloc() + memset() for a single entry.
> calloc() would be more appropriate if you allocate multiple.

Yes, the definition of calloc() is to alloc multiple entries and zero
them, so no need for that explicit multiplication there.

zalloc is just a malloc version that does the zeroing after allocation,
like calloc does.

zfree() is about removing references to areas of memory that are freed,
so if someone uses that pointer that was freed(), it will deref NULL,
not something that may be in use for something else.

So its not pairing zmalloc() with zfree(), albeit that is common.
 
- Arnaldo
