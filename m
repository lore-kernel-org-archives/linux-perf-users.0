Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A96E36D;
	Thu,  7 Aug 2025 00:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754525320; cv=none; b=RIV98aAnp0m6wN4VJLcOVxcxIXspL/m91l5QNDxoi56ZL03qQWU/Hgid39GqW241DdQ4wpy5K82TlirR8I3neeEoKZ0mmg474BOzbOc9F+OFAD6hVIo4JeF7LLK7I7hQz4LdFzaKXGwglRVYB2cC2pLNKO7uHpTNNvYDb1Stl/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754525320; c=relaxed/simple;
	bh=VyZExco2dKDu7jHN+QS2bBXqITlKj8MshUpQWgIF4PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvtnNPUyIzICuiq7fGxY/x99Sxn1qcFHXf+BexfWbtvoiBOCxDDjfHcQWDrFLlT8Fy3vq2u2ObszEu2gg2us6Bourxc/S91pWTOaOURDJ+4MSN6AvhFxUdxmnLZ4z+1eHRoYJOXHCeIPWHSCdymg8fAUdar+0Iw2PbMskucquUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qxptms4r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qxptms4r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7C8C4CEE7;
	Thu,  7 Aug 2025 00:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754525320;
	bh=VyZExco2dKDu7jHN+QS2bBXqITlKj8MshUpQWgIF4PU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qxptms4rdNkS0gG39JU1NUcuI5qcWFffXIQ8hqqTe+CwU0ZoTU4TBJ5inww+NBoQQ
	 jC51XwVA4U4yMASUHxY8nUldnH6/ewUUpQJmBTATFJLGlERyvxZSIjScayLd6gGH8O
	 9kg4GpKmBYrkG1SSeIhyYd4XiXvcExNCFf1YciIt+B2eHZJ/P+vcXs+4RcEOtEC83V
	 5Jc9Gaqrej9Pir2vnFFCPyloxKRa3X8AhYi/TbxsQ8PkuzScXmB8ZqFYK6HYswWCXw
	 LIbE++wstdpMwXISsKDVq4ecUEO5m2kWMeSmXjKb23ODkmHdoR2pFSHkKYQoR2nCym
	 C5O74wq/PLX4Q==
Date: Wed, 6 Aug 2025 17:08:38 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kevin Tian <kevin.tian@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [PATCH 4/5] perf tools kvm: Use "cycles" to sample guest for
 "kvm record" on Intel
Message-ID: <aJPuhpFK_ZjLk-ct@google.com>
References: <20250805004633.135904-1-dapeng1.mi@linux.intel.com>
 <20250805004633.135904-5-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250805004633.135904-5-dapeng1.mi@linux.intel.com>

On Tue, Aug 05, 2025 at 08:46:32AM +0800, Dapeng Mi wrote:
> After KVM supports PEBS for guest on Intel platforms
> (https://lore.kernel.org/all/20220411101946.20262-1-likexu@tencent.com/),
> host loses the capability to sample guest with PEBS since all PEBS related
> MSRs are switched to guest value after vm-entry, like IA32_DS_AREA MSR is
> switched to guest GVA at vm-entry. This would lead to "perf kvm record"
> fails to sample guest on Intel platforms since "cycles:P" event is used to
> sample guest by default as below case shows.

Do you mean we cannot use "cycles:PG" for perf kvm record?

> 
> sudo perf kvm record -a
> ^C[ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.787 MB perf.data.guest ]
> 
> So to ensure guest record can be sampled successfully, use "cycles"
> instead of "cycles:P" to sample guest record by default on Intel
> platforms. With this patch, the guest record can be sampled
> successfully.
> 
> sudo perf kvm record -a
> ^C[ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.783 MB perf.data.guest (23 samples) ]

What if user already gave some events in the command line?  I think you
need to check if "-e" or "--event" (and "--pfm-events" too) is in the
argv[] before adding these.

Thanks,
Namhyung

> 
> Reported-by: Kevin Tian <kevin.tian@intel.com>
> Fixes: 634d36f82517 ("perf record: Just use "cycles:P" as the default event")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  tools/perf/arch/x86/util/kvm-stat.c | 46 +++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
> index 424716518b75..cdb5f3e1b5be 100644
> --- a/tools/perf/arch/x86/util/kvm-stat.c
> +++ b/tools/perf/arch/x86/util/kvm-stat.c
> @@ -3,9 +3,11 @@
>  #include <string.h>
>  #include "../../../util/kvm-stat.h"
>  #include "../../../util/evsel.h"
> +#include "../../../util/env.h"
>  #include <asm/svm.h>
>  #include <asm/vmx.h>
>  #include <asm/kvm.h>
> +#include <subcmd/parse-options.h>
>  
>  define_exit_reasons_table(vmx_exit_reasons, VMX_EXIT_REASONS);
>  define_exit_reasons_table(svm_exit_reasons, SVM_EXIT_REASONS);
> @@ -211,3 +213,47 @@ int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid)
>  
>  	return 0;
>  }
> +
> +/*
> + * After KVM supports PEBS for guest on Intel platforms
> + * (https://lore.kernel.org/all/20220411101946.20262-1-likexu@tencent.com/),
> + * host loses the capability to sample guest with PEBS since all PEBS related
> + * MSRs are switched to guest value after vm-entry, like IA32_DS_AREA MSR is
> + * switched to guest GVA at vm-entry. This would lead to "perf kvm record"
> + * fails to sample guest on Intel platforms since "cycles:P" event is used to
> + * sample guest by default.
> + *
> + * So, to avoid this issue explicitly use "cycles" instead of "cycles:P" event
> + * by default to sample guest on Intel platforms.
> + */
> +int kvm_add_default_arch_event(int *argc, const char **argv)
> +{
> +	const char **tmp;
> +	bool event = false;
> +	int i, j = *argc;
> +
> +	const struct option event_options[] = {
> +		OPT_BOOLEAN('e', "event", &event, NULL),
> +		OPT_END()
> +	};
> +
> +	if (!x86__is_intel_cpu())
> +		return 0;
> +
> +	tmp = calloc(j + 1, sizeof(char *));
> +	if (!tmp)
> +		return -EINVAL;
> +
> +	for (i = 0; i < j; i++)
> +		tmp[i] = argv[i];
> +
> +	parse_options(j, tmp, event_options, NULL, PARSE_OPT_KEEP_UNKNOWN);
> +	if (!event) {
> +		argv[j++] = strdup("-e");
> +		argv[j++] = strdup("cycles");
> +		*argc += 2;
> +	}
> +
> +	free(tmp);
> +	return 0;
> +}
> -- 
> 2.34.1
> 
