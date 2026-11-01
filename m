Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793501331;
	b=BnaL2/WwDM3JKEy2egS/6clKuyNvnbvK0lslnzwTEn0YjO6NQ8zOprWmNJ534X/siQDF
	 ngyhrpX/jQgCwEen2IuLv7cxmQEDnqYbSUVBAA1s62gaDfFIpWmrWwUriMFKBRgkO11/5
	 4tfMRwhdaLLOFByfd9xei3zNBx3d/+tqmOouju7+JC0tJE/F3Fn9y55vDzpkZ8vzzArZ+
	 YEdPQMIcvMgB+vfhVqY7WHbt6GxyAW+C20b0oPHyfGTdMPIZCbUNRA8WXT1NqAyDKmjF9
	 XPB6CfsXqkC/IpfnjBO1I95tPW0L3PiU+badYmRIxzDlbhzDqTgUfA2rHEKF2H2KYaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793501331;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8vEjfLsV41/7ERxLHnPJ+uT0ZnGzebgW0tEKv1h3+B8=;
	b=uL/oaHrYWBzG45R/Am6Ol4qBfs+YOocu4BG3MJCGqoA5miqfNO2xg8VvI3mg9eU3jxDq
	 RQmtcquj3l6K3RfO5i0mStMXOInUak9IfS/h7YSMX8PUEGhyB3aYqjfSutGXXjYW5woWw
	 mdoPNAUCsGnlnryemd6eu+aOnGJXX4c+pDyQLDxR3O48ziHpyMDQfieIz04TRn1wAH7bb
	 /Xye9fIDqpgh6Ddn4LiNHL3d7vI+NLMYhqEhgEWVHfnrSK/JCzLRzJp6DuYKmljPQJJiU
	 9mOAcAaz8V4WJMOIDcDuUNokxFprK6Gkgp8m9IimzsuxUu2zlYvt61bh3J61WOqdxfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Td1XBBwd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1BF606A324;
	Sun,  1 Nov 2026 02:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Td1XBBwd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E501F000C1;
	Sun,  1 Nov 2026 02:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793501331;
	bh=8vEjfLsV41/7ERxLHnPJ+uT0ZnGzebgW0tEKv1h3+B8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Td1XBBwdGJcl7MYEzgQ404HqguO1Tp8MOXQ4pwznE9u1hdAWbXJMCdrMXV0ZQqXyL
	 19lt7pZKHY614kBXJ6w2iLPLgdN3QEx2Eirtf70eCR7Ykbyjd2Oxm5KHuRT7mxsWLv
	 Iyqej6zfYSXCnKmPUS+H2q/u1Y4B3jKIyAaeQpto9Hi5iFATUJYCapUzPwZmHthw79
	 csB93cxE54qi+vguXFtn3M8B8ZXgM8nroJ3OvaroJNNkWLw0bApCTQ6WUAgWHrW02S
	 SP0IJv7cvWBIoxoHozvdES58JAjOIDZqosiSZ1Rp9SXPKs5RzysEFuKrfbl3iN6r31
	 2Wabsjfv9aZsQ==
Date: Sat, 31 Oct 2026 19:48:49 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, haghdoost@uber.com,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v2 01/18] perf bench internals: Add symbols and maps
 benchmarks
Message-ID: <auaokSIk3deCgp-D@z2>
References: <20260928075237.3055101-1-irogers@google.com>
 <20261027231513.816148-1-irogers@google.com>
 <20261027231513.816148-2-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261027231513.816148-2-irogers@google.com>

On Tue, Oct 27, 2026 at 04:14:55PM -0700, Ian Rogers wrote:
> Add two new 'perf bench internals' subcommands to measure symbol and map
> operations directly:
> 
> - 'perf bench internals symbols':
>   1. Loads symbols from an ELF binary (defaulting to the running perf
>      executable, or specified via -b/--binary) and sorts them by name,
>      reporting both average runtime and heap memory consumption.
>   2. Inserts synthetic symbols in two ascending runs (simulating .symtab
>      and .dynsym), fixes up symbol ends and duplicates, and queries each
>      symbol by address.
>   3. Incrementally appends symbols at interior addresses and immediately
>      queries each appended symbol by address.
> 
> - 'perf bench internals maps':
>   1. Inserts non-overlapping maps in ascending address order (simulating
>      /proc/<pid>/maps synthesis) and queries each map by address.
>   2. Incrementally appends maps at interior addresses (simulating runtime
>      PERF_RECORD_MMAP2 / JIT events) and immediately queries each map by
>      address and by name.

Can you please add an example output?

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
[SNIP]
> diff --git a/tools/perf/bench/symbols.c b/tools/perf/bench/symbols.c
> new file mode 100644
> index 000000000000..5ab71d440e67
> --- /dev/null
> +++ b/tools/perf/bench/symbols.c
> @@ -0,0 +1,236 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Benchmark symbol loading, sorting, and address/name lookup.
> + */
> +#include <elf.h>
> +#include <errno.h>
> +#include <inttypes.h>
> +#include <limits.h>
> +#include <malloc.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/time.h>
> +#include <linux/compiler.h>
> +#include <linux/kernel.h>
> +#include <linux/time64.h>
> +#include <subcmd/parse-options.h>
> +#include "bench.h"
> +#include "../util/debug.h"
> +#include "../util/dso.h"
> +#include "../util/map.h"
> +#include "../util/stat.h"
> +#include "../util/symbol.h"
> +#include "../util/util.h"
> +
> +static unsigned int iterations = 20;
> +static unsigned int nr_symbols = 10000;
> +static unsigned int nr_appends = 200;
> +static const char *binary_path;
> +static bool no_demangle;
> +
> +static const struct option options[] = {
> +	OPT_UINTEGER('i', "iterations", &iterations,
> +		     "Number of iterations used to compute average (default: 20)"),
> +	OPT_STRING('b', "binary", &binary_path, "path",
> +		   "Binary path for ELF symbol load benchmark (default: perf binary)"),
> +	OPT_UINTEGER('n', "nr-symbols", &nr_symbols,
> +		     "Number of synthetic symbols for bulk benchmark (default: 10000)"),
> +	OPT_UINTEGER('a', "nr-appends", &nr_appends,
> +		     "Number of incremental symbol appends per iteration (default: 200)"),
> +	OPT_BOOLEAN(0, "no-demangle", &no_demangle,
> +		    "Disable symbol demangling during ELF load"),
> +	OPT_END()
> +};
> +
> +static const char *const bench_usage[] = {
> +	"perf bench internals symbols <options>",
> +	NULL
> +};
> +
> +static int do_dso_load_bench(const char *path)
> +{
> +	struct stats time_stats;
> +#if defined(__GLIBC__) && __GLIBC_PREREQ(2, 33)
> +	struct stats mem_stats;
> +#endif
> +	double time_average, time_stddev;
> +	unsigned int i;
> +
> +	init_stats(&time_stats);
> +#if defined(__GLIBC__) && __GLIBC_PREREQ(2, 33)
> +	init_stats(&mem_stats);
> +#endif
> +
> +	for (i = 0; i < iterations; i++) {
> +		struct timeval start, end, diff;
> +		struct map *map;
> +		struct dso *dso;
> +		u64 runtime_us;
> +#if defined(__GLIBC__) && __GLIBC_PREREQ(2, 33)
> +		size_t mem_before = mallinfo2().uordblks;
> +		size_t mem_after;
> +#endif

Can we just use maxrss from getrusage()?  It doesn't need to be average,
probably we just want to know the maximum memory usage.

> +
> +		gettimeofday(&start, NULL);
> +		map = dso__new_map(path);
> +		if (!map) {
> +			pr_err("Failed to create map for %s\n", path);
> +			return -ENOMEM;
> +		}
> +		if (map__load(map) < 0) {
> +			pr_err("Failed to load symbols from %s\n", path);
> +			map__put(map);
> +			return -EINVAL;
> +		}
> +		dso = map__dso(map);
> +		dso__sort_by_name(dso);

Probably better to have a separate test not to use symbol names.  As we
expect to have lazy symbol loading soon.

Thanks,
Namhyung


> +		gettimeofday(&end, NULL);
> +
> +#if defined(__GLIBC__) && __GLIBC_PREREQ(2, 33)
> +		mem_after = mallinfo2().uordblks;
> +		if (mem_after > mem_before)
> +			update_stats(&mem_stats, (mem_after - mem_before) / 1024);
> +#endif
> +		map__put(map);
> +
> +		timersub(&end, &start, &diff);
> +		runtime_us = diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
> +		update_stats(&time_stats, runtime_us);
> +	}
> +
> +	time_average = avg_stats(&time_stats) / USEC_PER_MSEC;
> +	time_stddev = stddev_stats(&time_stats) / USEC_PER_MSEC;
> +	printf("  Average DSO load + sort: %.3f msec (+- %.3f msec)\n",
> +	       time_average, time_stddev);
> +
> +#if defined(__GLIBC__) && __GLIBC_PREREQ(2, 33)
> +	printf("  Average DSO memory usage: %.0f KB (+- %.0f KB)\n",
> +	       avg_stats(&mem_stats), stddev_stats(&mem_stats));
> +#endif
> +	return 0;
> +}
> +
> +static int do_synthetic_symbols_bench(void)
> +{
> +	struct stats bulk_stats, append_stats;
> +	unsigned int i, j, half = nr_symbols / 2;
> +
> +	if (half == 0)
> +		return 0;
> +
> +	init_stats(&bulk_stats);
> +	init_stats(&append_stats);
> +
> +	for (i = 0; i < iterations; i++) {
> +		struct timeval start, end, diff;
> +		struct dso *dso = dso__new("[bench_symbols]");
> +		u64 runtime_us;
> +		char name[32];
> +
> +		if (!dso)
> +			return -ENOMEM;
> +
> +		/*
> +		 * Phase 1: Insert symbols in two ascending runs (simulating
> +		 * .symtab + .dynsym), fixup ends and duplicates, and look up
> +		 * all symbols by address.
> +		 */
> +		gettimeofday(&start, NULL);
> +		for (j = 0; j < nr_symbols; j++) {
> +			u64 addr = (j < half) ?
> +				(0x100000ULL + (u64)j * 0x40ULL) :
> +				(0x100020ULL + (u64)(j - half) * 0x40ULL);
> +			struct symbol *sym;
> +
> +			scnprintf(name, sizeof(name), "bench_sym_%06u", j);
> +			sym = symbol__new(addr, 0x18, STB_GLOBAL, STT_FUNC, name);
> +			if (!sym) {
> +				dso__put(dso);
> +				return -ENOMEM;
> +			}
> +			symbols__insert(dso__symbols(dso), sym);
> +		}
> +		symbols__fixup_end(dso__symbols(dso), false);
> +		symbols__fixup_duplicate(dso__symbols(dso));
> +
> +		for (j = 0; j < nr_symbols; j++) {
> +			u64 addr = (j < half) ?
> +				(0x100000ULL + (u64)j * 0x40ULL + 4) :
> +				(0x100020ULL + (u64)(j - half) * 0x40ULL + 4);
> +
> +			(void)dso__find_symbol_nocache(dso, addr);
> +		}
> +		gettimeofday(&end, NULL);
> +		timersub(&end, &start, &diff);
> +		runtime_us = diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
> +		update_stats(&bulk_stats, runtime_us);
> +
> +		/*
> +		 * Phase 2: Incrementally append one symbol at a time at an
> +		 * interior address and immediately query by address.
> +		 */
> +		gettimeofday(&start, NULL);
> +		for (j = 0; j < nr_appends; j++) {
> +			u64 addr = 0x100010ULL + ((u64)(j * 197 % half)) * 0x40ULL;
> +			struct symbol *sym;
> +
> +			scnprintf(name, sizeof(name), "jit_sym_%06u", j);
> +			sym = symbol__new(addr, 0x08, STB_GLOBAL, STT_FUNC, name);
> +			if (!sym) {
> +				dso__put(dso);
> +				return -ENOMEM;
> +			}
> +			dso__insert_symbol(dso, sym);
> +			(void)dso__find_symbol_nocache(dso, addr + 2);
> +		}
> +		gettimeofday(&end, NULL);
> +		timersub(&end, &start, &diff);
> +		runtime_us = diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
> +		update_stats(&append_stats, runtime_us);
> +
> +		dso__put(dso);
> +	}
> +
> +	printf("  Average bulk insert + lookup: %.3f usec (+- %.3f usec)\n",
> +	       avg_stats(&bulk_stats), stddev_stats(&bulk_stats));
> +	printf("  Average append + lookup: %.3f usec (+- %.3f usec)\n",
> +	       avg_stats(&append_stats), stddev_stats(&append_stats));
> +	return 0;
> +}
> +
> +int bench_symbols(int argc, const char **argv)
> +{
> +	char exe_buf[PATH_MAX];
> +	const char *path;
> +	bool orig_demangle;
> +	int err;
> +
> +	argc = parse_options(argc, argv, options, bench_usage, 0);
> +	if (argc) {
> +		usage_with_options(bench_usage, options);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	if (symbol__init(NULL) < 0)
> +		return -1;
> +
> +	orig_demangle = symbol_conf.demangle;
> +	if (no_demangle)
> +		symbol_conf.demangle = false;
> +
> +	if (binary_path) {
> +		path = binary_path;
> +	} else {
> +		perf_exe(exe_buf, sizeof(exe_buf));
> +		path = exe_buf;
> +	}
> +
> +	err = do_dso_load_bench(path);
> +	if (!err)
> +		err = do_synthetic_symbols_bench();
> +
> +	symbol_conf.demangle = orig_demangle;
> +	return err;
> +}
> diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
> index 62bebdedd3b8..57a4199a058c 100644
> --- a/tools/perf/builtin-bench.c
> +++ b/tools/perf/builtin-bench.c
> @@ -97,6 +97,8 @@ static const struct bench internals_benchmarks[] = {
>  	{ "inject-build-id", "Benchmark build-id injection",	bench_inject_build_id	},
>  	{ "evlist-open-close", "Benchmark evlist open and close",	bench_evlist_open_close	},
>  	{ "pmu-scan", "Benchmark sysfs PMU info scanning",	bench_pmu_scan		},
> +	{ "symbols", "Benchmark symbol loading, sorting and lookup",	bench_symbols	},
> +	{ "maps", "Benchmark maps insertion, sorting and lookup",	bench_maps	},
>  	{ NULL,		NULL,					NULL			}
>  };
>  
> -- 
> 2.56.0.313.g2479322e68-goog
> 
