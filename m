Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BB9332EAD;
	Tue, 28 Jul 2026 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260026; cv=none; b=BwP6GEJ9qjGalJaQTkksKgnDT3X4aUQLyozSklnRnIwDJQPCbWJzzTAHEdX8vf3VOQnnJxD18D5LodASrjbZ+LZW0evhxqjtqnsikxJwRiWoLnNOpWeD7QJJC+hj808VxpNXcD2BitNeKt4tYoaQVH99b9pHtXNSXzC5wdLLSpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260026; c=relaxed/simple;
	bh=CI1jgDHc8teC4O6IND0o+5Tme2bVMCkf2ifitM6hqQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odqAVemv2h6YX87a/tJX2R6CkXuhg/PdvIrgweiC3xJrBhWbb369hcJ5bXhGdEWLfTtnjWZtXX1k25SRDXPU1U28VSUtLihT7RBY9mUafsMurDi7qsqkXHFtSATHuvgHPIhrTMqAbBIDWxgw4JeEiuZKytRmOhEbiAbb5yEPjWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2+mDssi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2+mDssi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BB41F000E9;
	Tue, 28 Jul 2026 17:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785260025;
	bh=VZNuGuVJtu+flSf0cnNexZlWkidEutcNKLh1oE9p6L0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i2+mDssiGpzTi/cwOwPmWIb9QO2hm34mCi0kRDR1ZUciH7mVnlfV1wAm7QkCbPpsM
	 qKGlmXSm/Q7a8bgAYU5dahojtn2FdL9X9TQHwTKtPPDXRyF7rWhFZtrz4los66E4kO
	 s84WKW24NzxuiWJNwZTmiaWRA/6UIp0hJuT4zzOd796/5oEEAPopkCDftjmNSo3r0k
	 0xwPoqIVOeftVJ/9NTCgs6uUGVuOsUocP0QLDtQ0x7+V+/H0lq3nphq8gIkwHbQc8t
	 8U/S/7A7X+C7IklIfxLOfdEYPD86YWESAzbcC90PMpABtHDM5EEQ/rg8xcLa+gbXZ3
	 ZlUpmvl0zx1NA==
Date: Tue, 28 Jul 2026 10:33:43 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v2 5/6] perf header: Support memory ranges
Message-ID: <amjn98atBKIZDC3c@google.com>
References: <20260714004359.179451-1-thomas.falcon@intel.com>
 <20260714004359.179451-6-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260714004359.179451-6-thomas.falcon@intel.com>

On Mon, Jul 13, 2026 at 07:43:58PM -0500, Thomas Falcon wrote:
> Memory ranges were created to track different types of memory,
> such as persistent, high bandwidth, or CXL-attached, that may
> be present on a system for performance monitoring and resource
> control purposes.
> 
> Memory range data are parsed from the ACPI MRRM table and exposed
> to userspace tools via sysfs [1]. Memory range data is read from:
> 
> 	/sys/firmware/acpi/memory_ranges/rangeX
> 
> With the following attributes:
> 
> 	u64 base;
> 	u64 length;
> 	int node;
> 	u8  local_region_id;
> 	u8  remote_region_id;
> 
> Read memory range data from sysfs if present and save it in
> the header of the perf data file under a new feature bit,
> HEADER_MEMORY_RANGES (35). Memory range data can be viewed with the
> --header or --header-only options of perf-report and perf-script.

Can you please add an example output here?

> 
> [1]: https://lore.kernel.org/lkml/20250505173819.419271-1-tony.luck@intel.com/
> 
> Assisted-by: Sashiko:gemini-3.1-pro-preview
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> ---
> Changes in v2: 
> -- Added check for NULL return of sysfs__mountpoint() when parsing
>    memory ranges in sysfs
> -- increased MAX_MEMORY_RANGES sanity check from 64 to 256 based on 
>    ACPI MRRM table implementation in Linux kernel
> -- added comment for MAX_MEMORY_RANGES to clarify that it is a sanity check
>    for malformed perf.data files
> -- removed a line of code was removed from util/env.h but was added back in
>    v1 due to bad rebase
> ---
[SNIP]
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index e90e541f546b..0669898362d6 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -92,6 +92,7 @@
>  #define MAX_PMU_CAPS		512
>  #define MAX_PMU_MAPPINGS	4096
>  #define MAX_SCHED_DOMAINS	64
> +#define MAX_MEMORY_RANGES	256
>  
>  /*
>   * magic2 = "PERFILE2"
> @@ -1891,6 +1892,130 @@ static int write_cpu_domain_info(struct feat_fd *ff,
>  	return ret;
>  }
>  
> +static int memory_range__read(struct memory_range *range, int idx)
> +{
> +	char path[PATH_MAX], file[PATH_MAX];

I hope we can reduce the number of buffers for the pathnames as it
already has another in the caller.  Ideally it'd be great if it can use
openat() with an FD for the directory.


> +	struct stat st;
> +	int tmp;
> +
> +	scnprintf(path, PATH_MAX, "firmware/acpi/memory_ranges/range%d", idx);
> +	scnprintf(file, PATH_MAX, "%s/%s", sysfs__mountpoint(), path);
> +	if (stat(file, &st))
> +		return -1;

It seems this check is redundant.

> +
> +	scnprintf(file, PATH_MAX, "%s/base", path);
> +	if (sysfs__read_xll(file, (unsigned long long *) &range->base))
> +		return -1;
> +
> +	scnprintf(file, PATH_MAX, "%s/length", path);
> +	if (sysfs__read_xll(file, (unsigned long long *) &range->length))
> +		return -1;
> +
> +	scnprintf(file, PATH_MAX, "%s/node", path);
> +	if (sysfs__read_int(file, (int *) &range->node))
> +		return -1;
> +
> +	scnprintf(file, PATH_MAX, "%s/local_region_id", path);
> +	if (sysfs__read_int(file, &tmp))
> +		return -1;
> +
> +	if (tmp < 0 || tmp > 255)

Probably better to compare with MAX_MEMORY_REGIONS.


> +		return -1;
> +	range->local_region_id = tmp;
> +
> +	scnprintf(file, PATH_MAX, "%s/remote_region_id", path);
> +	if (sysfs__read_int(file, &tmp))
> +		return -1;
> +
> +	if (tmp < 0 || tmp > 255)

Ditto.


> +		return -1;
> +	range->remote_region_id = tmp;
> +
> +	return 0;
> +}
> +
> +static int memory_range__parse(struct memory_range **ranges)
> +{
> +	const char *sysfs = sysfs__mountpoint();
> +	int i, err, nr_memory_ranges = 0;
> +	char path[PATH_MAX];
> +	struct stat st;
> +
> +	if (!sysfs)
> +		return 0;
> +
> +	scnprintf(path, PATH_MAX, "%s/firmware/acpi/memory_ranges", sysfs);
> +	if (stat(path, &st))
> +		return 0;
> +
> +	while (1) {
> +		scnprintf(path, PATH_MAX, "%s/firmware/acpi/memory_ranges/range%d", sysfs, nr_memory_ranges);

This line looks too long.


> +		if (stat(path, &st))
> +			break;
> +
> +		nr_memory_ranges++;
> +	}
> +
> +	if (nr_memory_ranges == 0)
> +		return 0;
> +
> +	*ranges = zalloc(nr_memory_ranges * sizeof(struct memory_range));

I think calloc() is preferred when you multiply the size and the count.


> +	if (!(*ranges))
> +		return -ENOMEM;
> +
> +	for (i = 0; i < nr_memory_ranges; i++) {
> +		struct memory_range range;
> +
> +		err = memory_range__read(&range, i);
> +		if (err < 0)
> +			goto out_error;
> +
> +		(*ranges)[i] = range;
> +	}
> +
> +	return nr_memory_ranges;
> +
> +out_error:
> +	zfree(ranges);
> +	return -1;
> +}
> +
[SNIP] 
> +static int process_memory_ranges(struct feat_fd *ff, void *data __maybe_unused)
> +{
> +	struct perf_env *env = &ff->ph->env;
> +	struct memory_range *ranges, *r;
> +	u32 nr_memory_ranges, i;
> +
> +	if (do_read_u32(ff, &nr_memory_ranges))
> +		return -1;
> +
> +	if (!nr_memory_ranges) {
> +		pr_debug("memory ranges not available\n");
> +		return 0;
> +	}
> +
> +	/* According to version 1.1 of the ACPI MRRM table, the maximum
> +	 * number of memory regions can be at most 255. Do a sanity check
> +	 * here to guard against a malformed perf.data file.
> +	 */
> +	if (nr_memory_ranges >= MAX_MEMORY_RANGES) {
> +		pr_err("Invalid memory_ranges: nr_memory_ranges (%u) > %u\n",
> +		       nr_memory_ranges, MAX_MEMORY_RANGES);
> +		return -1;
> +	}
> +
> +	ranges = zalloc(nr_memory_ranges * sizeof(*ranges));

Please use calloc().

Thanks,
Namhyung


> +	if (!ranges)
> +		return -1;
> +
> +	for (i = 0; i < nr_memory_ranges; i++) {
> +		r = &ranges[i];
> +
> +		if (do_read_u64(ff, &r->base))
> +			goto error;
> +		if (do_read_u64(ff, &r->length))
> +			goto error;
> +		if (do_read_u32(ff, (u32 *) &r->node))
> +			goto error;
> +		if (__do_read(ff, &r->local_region_id, sizeof(u8)))
> +			goto error;
> +		if (__do_read(ff, &r->remote_region_id, sizeof(u8)))
> +			goto error;
> +	}
> +
> +	env->memory_ranges = ranges;
> +	env->nr_memory_ranges = nr_memory_ranges;
> +
> +	return 0;
> +error:
> +	zfree(&ranges);
> +	return -1;
> +}
> +
>  #define FEAT_OPR(n, func, __full_only) \
>  	[HEADER_##n] = {					\
>  		.name	    = __stringify(n),			\
> @@ -4265,6 +4459,7 @@ const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE] = {
>  	FEAT_OPR(CPU_DOMAIN_INFO,	cpu_domain_info,	true),
>  	FEAT_OPR(E_MACHINE,	e_machine,	false),
>  	FEAT_OPR(CLN_SIZE,	cln_size,	false),
> +	FEAT_OPR(MEMORY_RANGES,	memory_ranges,	false),
>  };
>  
>  struct header_print_data {
> diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
> index 5e03f884b7cc..765037762758 100644
> --- a/tools/perf/util/header.h
> +++ b/tools/perf/util/header.h
> @@ -56,6 +56,7 @@ enum {
>  	HEADER_CPU_DOMAIN_INFO,
>  	HEADER_E_MACHINE,
>  	HEADER_CLN_SIZE,
> +	HEADER_MEMORY_RANGES,
>  	HEADER_LAST_FEATURE,
>  	HEADER_FEAT_BITS	= 256,
>  };
> -- 
> 2.43.0
> 
