Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1BD139566;
	Tue, 22 Oct 2024 05:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729575681; cv=none; b=N8nxcdlzbDBRHlXPUlwe4MyaTdDxrbgZfi8hJuLR0RR/apeHylWqsshPtFnXijB7ijV2Hmg9cxLvzPcN2PUKkm0KMrKgBEhUDNUlI7lLjBA9PL/pPvwY/BEGUBOk8TBbPf+m1EP7fqOCEBILcZMrBjDVKavRWTshRDjKErVgPDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729575681; c=relaxed/simple;
	bh=CElZF6oRP9IlY0RwgVPhOFqNpURPY/hGMZANUgAw6DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdrcsNwxsHCufqe35DQa1OFy4i6M9lIUJAgkAY4m07uXy+gFT6XcTmRar85wLoeUAls97OhMUU611jC+UW220dT9rIXEMoUYs6EAzfUQF8ggfj7C68vZkR/3gpTmG3Lvl9F1I8/c0JsDJxfNl8inathGNc/vCA6JFH6Hjuxo/3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHjsGY0M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHjsGY0M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3B2C4CEE8;
	Tue, 22 Oct 2024 05:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729575680;
	bh=CElZF6oRP9IlY0RwgVPhOFqNpURPY/hGMZANUgAw6DM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bHjsGY0MgVHqzlwdXQL9IqStYsWNzCgMfOFlvyCrbvYDJUrcEkbQ5OCFnELDccBlP
	 gqeMgrg8j9htSKHm5P7D4SRk2hMg+AWlR6PG5VXLh6X+vRzbPLrGCnbPxQ/OhM2wEk
	 KXeEa1xYZGwnoNCVKUemnd/ajQjzY5ET/K0CQEphTirSTiuWUBVSZgd7tweUX4Qlp7
	 iAfaLd/UVjFAAQXx+xkEKgtRz0/2/1aIqZ5P4sMzoCYP/zhmoOIl9Cdg6/y3wXqd/K
	 Q1KQ1k9RHRJERfjtVO5b2rGeQB7RFJY1SzQesWiqVVmmb10d/V7rEiPbXHgtgX+7T2
	 7eKK+glETqHjw==
Date: Mon, 21 Oct 2024 22:41:18 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf check: Add sanitizer feature and use to avoid
 test failure
Message-ID: <Zxc6_jZdDcWgtEom@google.com>
References: <20241018055627.1005723-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241018055627.1005723-1-irogers@google.com>

On Thu, Oct 17, 2024 at 10:56:27PM -0700, Ian Rogers wrote:
> Sanitizer builds can break expectations for test disassembly,
> particularly in the annotate test. Add features for the different
> sanitizer options seen in the source tree. Use the added sanitizer
> feature to skip the annotate test when sanitizers are in use.

Can you please split the perf check changes from the test change?
It's good to add an example output (of perf version --build-options)
with new sanitizer features.

Also it might be helpful if you share how the test fails.  I don't
think the disasm format is changed.  Then it probably missed to find
the target symbol in the first 250 lines for some reason.

Thanks,
Namhyung

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v2 build fix.
> ---
>  tools/perf/builtin-check.c         | 49 ++++++++++++++++++++++++++++++
>  tools/perf/tests/shell/annotate.sh |  6 ++++
>  2 files changed, 55 insertions(+)
> 
> diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
> index 0b76b6e42b78..c44444008d64 100644
> --- a/tools/perf/builtin-check.c
> +++ b/tools/perf/builtin-check.c
> @@ -9,6 +9,49 @@
>  #include <string.h>
>  #include <subcmd/parse-options.h>
>  
> +#if defined(__has_feature)
> +#define HAS_COMPILER_FEATURE(feature) __has_feature(feature)
> +#else
> +#define HAS_COMPILER_FEATURE(feature) 0
> +#endif
> +
> +#if defined(__SANITIZE_ADDRESS__) || defined(ADDRESS_SANITIZER) || \
> +	HAS_COMPILER_FEATURE(address_sanitizer)
> +#define HAVE_SANITIZER_ADDRESS 1
> +#define HAVE_SANITIZER_LEAK 1
> +#elif defined(LEAK_SANITIZER) || HAS_COMPILER_FEATURE(leak_sanitizer)
> +#define HAVE_SANITIZER_ADDRESS 0
> +#define HAVE_SANITIZER_LEAK 1
> +#else
> +#define HAVE_SANITIZER_ADDRESS 0
> +#define HAVE_SANITIZER_LEAK 0
> +#endif
> +
> +#if defined(MEMORY_SANITIZER) || HAS_COMPILER_FEATURE(memory_sanitizer)
> +#define HAVE_SANITIZER_MEMORY 1
> +#else
> +#define HAVE_SANITIZER_MEMORY 0
> +#endif
> +
> +#if defined(THREAD_SANITIZER) || HAS_COMPILER_FEATURE(thread_sanitizer)
> +#define HAVE_SANITIZER_THREAD 1
> +#else
> +#define HAVE_SANITIZER_THREAD 0
> +#endif
> +
> +#if defined(UNDEFINED_SANITIZER) || HAS_COMPILER_FEATURE(undefined_sanitizer)
> +#define HAVE_SANITIZER_UNDEFINED 1
> +#else
> +#define HAVE_SANITIZER_UNDEFINED 0
> +#endif
> +
> +#if HAVE_SANITIZER_ADDRESS || HAVE_SANITIZER_LEAK || HAVE_SANITIZER_MEMORY || \
> +	HAVE_SANITIZER_THREAD || HAVE_SANITIZER_UNDEFINED
> +#define HAVE_SANITIZER 1
> +#else
> +#define HAVE_SANITIZER 0
> +#endif
> +
>  static const char * const check_subcommands[] = { "feature", NULL };
>  static struct option check_options[] = {
>  	OPT_BOOLEAN('q', "quiet", &quiet, "do not show any warnings or messages"),
> @@ -47,6 +90,12 @@ struct feature_status supported_features[] = {
>  	FEATURE_STATUS("libunwind", HAVE_LIBUNWIND_SUPPORT),
>  	FEATURE_STATUS("lzma", HAVE_LZMA_SUPPORT),
>  	FEATURE_STATUS("numa_num_possible_cpus", HAVE_LIBNUMA_SUPPORT),
> +	FEATURE_STATUS("sanitizer", HAVE_SANITIZER),
> +	FEATURE_STATUS("sanitizer_address", HAVE_SANITIZER_ADDRESS),
> +	FEATURE_STATUS("sanitizer_leak", HAVE_SANITIZER_LEAK),
> +	FEATURE_STATUS("sanitizer_memory", HAVE_SANITIZER_MEMORY),
> +	FEATURE_STATUS("sanitizer_thread", HAVE_SANITIZER_THREAD),
> +	FEATURE_STATUS("sanitizer_undefined", HAVE_SANITIZER_UNDEFINED),
>  	FEATURE_STATUS("syscall_table", HAVE_SYSCALL_TABLE_SUPPORT),
>  	FEATURE_STATUS("zlib", HAVE_ZLIB_SUPPORT),
>  	FEATURE_STATUS("zstd", HAVE_ZSTD_SUPPORT),
> diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/annotate.sh
> index 1590a37363de..199f547e656d 100755
> --- a/tools/perf/tests/shell/annotate.sh
> +++ b/tools/perf/tests/shell/annotate.sh
> @@ -4,6 +4,12 @@
>  
>  set -e
>  
> +if perf check feature -q sanitizer
> +then
> +  echo "Skip test with sanitizers due to differing assembly code"
> +  exit 2
> +fi
> +
>  shelldir=$(dirname "$0")
>  
>  # shellcheck source=lib/perf_has_symbol.sh
> -- 
> 2.47.0.105.g07ac214952-goog
> 
