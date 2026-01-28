Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58D62BEC2E;
	Wed, 28 Jan 2026 18:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623990; cv=none; b=CerBNcsLL+k6iYdIXYXPQ3AdzqPeUPKYVD6GW49n1yK/1bpAjJUKzdgVjEl7gNRlOhcVhw5k8Ji8SLuv9JRuapUbAplMDMmEjiW+YiX71Sz61UbKkyGfPUtrpMmCeJ2JIa6FxJisnLklsxELKrmiYOZZMCK94/I8Sph9Ih1sNRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623990; c=relaxed/simple;
	bh=hoFbcdX6evDvF6hpNkWwofSlIg5xVobSR7oL1SWXtTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeSiuqwpcNJ8SbnUVsXDF6cEFoLCprm0doWUq7WIOIhw8+OLt/nVVtce6EJ/Zaele8JZLFvpgdJz1FVg28uOUYhhIka12/D42JUMkmstFwQKBGB3upG8tPuzHAVrs0f54jNJJS+D0hvZOSa1LiHtOR/hEjuoaHVctLdnz1ilhuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuNxuFq6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuNxuFq6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97E4C4CEF1;
	Wed, 28 Jan 2026 18:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769623990;
	bh=hoFbcdX6evDvF6hpNkWwofSlIg5xVobSR7oL1SWXtTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EuNxuFq6XeggsV+/eF+Fn95EYuTztyxsSQvGXXonXXUdzUgOZMiSqqLbf4elRYuN7
	 WpEuHmRmTlecVCKWhvzAt5ZWM0IXNWbvRhQRkEGCGMpqLJV+XYm3ECxvCsKmFk4Kjj
	 ssRhH5ZmEVfSPh61aT076nnFHiuCXfTeGlk0N/N6sO3sRvqTwLPRiCncXMJ96RZrBU
	 AhhMmfWlte5fOE8W+qL+/EMwjN84KznfI6TZ/ZNgybgcP/PNC4LdGQHdPSds7MfyPp
	 7bmscET3tsiRHw7Ks0VQGKa/x3r7vHy3/58qr/YN6K/iTLBgOS2ukzPEpr8pFyAO0x
	 M4atu3sXveTAA==
Date: Wed, 28 Jan 2026 15:13:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, thomas.falcon@intel.com,
	ashelat@redhat.com, yu.c.chen@intel.com, gautham.shenoy@amd.com,
	ravi.bangoria@amd.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, peterz@infradead.org,
	mingo@redhat.com, namhyung@kernel.org, irogers@google.com,
	james.clark@arm.com
Subject: Re: [PATCH v1 1/6] perf header: Replace hardcoded max cpus by
 MAX_NR_CPUS
Message-ID: <aXpRsyEURQkh9nme@x1>
References: <20260127185000.431884-1-swapnil.sapkal@amd.com>
 <20260127185000.431884-2-swapnil.sapkal@amd.com>
 <0117fe41-0016-49d7-bc73-1ec682ca8783@linux.ibm.com>
 <50e3ac65-fc5d-47d0-bdc4-5c8c1fc8eac1@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50e3ac65-fc5d-47d0-bdc4-5c8c1fc8eac1@amd.com>

On Wed, Jan 28, 2026 at 09:55:05PM +0530, Swapnil Sapkal wrote:
> Hi Srikanth, Arnaldo,
> 
> Thank you for reviewing the patches.
> 
> On 28-01-2026 13:09, Shrikanth Hegde wrote:
> > 
> > 
> > On 1/28/26 12:19 AM, Swapnil Sapkal wrote:
> > > cpumask and cpulist from cpu-domain header have hardcoded max_cpus value
> > > of 1024. Current systems have more cpus than this value. Replace it with
> > > MAX_NR_CPUS. Also define a macro to represent domain name length.
> > > 
> > > Fixes: d40c68a49f69 ("perf header: Support CPU DOMAIN relation info")
> > > Reported-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> > > Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
> > > ---
> > >   tools/perf/util/header.c | 5 +++--
> > >   1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > > index eefd1cd73b6a..31c3bab1b10a 100644
> > > --- a/tools/perf/util/header.c
> > > +++ b/tools/perf/util/header.c
> > > @@ -76,6 +76,7 @@ static const u64 __perf_magic2    =
> > > 0x32454c4946524550ULL;
> > >   static const u64 __perf_magic2_sw = 0x50455246494c4532ULL;
> > >   #define PERF_MAGIC    __perf_magic2
> > > +#define DNAME_LEN    16
> > >   const char perf_version_string[] = PERF_VERSION;
> > > @@ -1616,10 +1617,10 @@ static int write_pmu_caps(struct feat_fd *ff,
> > >   struct cpu_domain_map **build_cpu_domain_map(u32
> > > *schedstat_version, u32 *max_sched_domains, u32 nr)
> > >   {
> > > +    char dname[DNAME_LEN], cpumask[MAX_NR_CPUS];
> > >       struct domain_info *domain_info;
> > >       struct cpu_domain_map **cd_map;
> > > -    char dname[16], cpumask[256];
> > > -    char cpulist[1024];
> > > +    char cpulist[MAX_NR_CPUS];
> > >       char *line = NULL;
> > >       u32 cpu, domain;
> > >       u32 dcount = 0;
> > 
> > Looking at
> > https://lore.kernel.org/all/20260119175833.340369-3-swapnil.sapkal@amd.com/
> > 
> > There was one more "char cpus[1024]"  in tools/perf/util/util.c.
> > You may need to fix that too. It is unlikely but, if one has created
> > exclusive
> > cpusets comprising of only one cpu from a core, maybe you will run out
> > the length.
> > So better use the MAX_NR_CPUS there as well.
> 
> Yes, I missed this.
> 
> Arnaldo, can you please consider the below diff? Let me know if you'd like
> me to respin the patch.

Sure, will add it.

- Arnaldo
 
> --
> Thanks and Regards,
> Swapnil
> 
> diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> index c83e59e8c787..3795d5182ce8 100644
> --- a/tools/perf/util/util.c
> +++ b/tools/perf/util/util.c
> @@ -262,7 +262,7 @@ void cpumask_to_cpulist(char *cpumask, char *cpulist)
>         int i, j, bm_size, nbits;
>         int len = strlen(cpumask);
>         unsigned long *bm;
> -       char cpus[1024];
> +       char cpus[MAX_NR_CPUS];
> 
>         for (i = 0; i < len; i++) {
>                 if (cpumask[i] == ',') {
> diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
> index 394dbfa944ac..c43f17137efd 100644
> --- a/tools/perf/util/util.h
> +++ b/tools/perf/util/util.h
> @@ -6,6 +6,7 @@
>  /* glibc 2.20 deprecates _BSD_SOURCE in favour of _DEFAULT_SOURCE */
>  #define _DEFAULT_SOURCE 1
> 
> +#include "perf.h"
>  #include <dirent.h>
>  #include <fcntl.h>
>  #include <stdbool.h>
