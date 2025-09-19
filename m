Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB8D27511E;
	Fri, 19 Sep 2025 19:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758309710; cv=none; b=m7h4XrciqE8rFGSKobS9/NpiwP1mfjfcUUP0P5siNIKbXnwWKc9GDf5vOGwzGh2rtaoZARZm/GdLpRvslG1I5lj7buKmscbOzFlQuJNyTGSiAVNOojo/1zk9Jp/pxyvuT+O/LqykShdCk99CpOwNXMASj8ErpyLqqTBDCtcPBBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758309710; c=relaxed/simple;
	bh=tvrdwVbBASlH/KuZoVbAmvS3Odq/Ure2qLJP6zfXhQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQVikd9o46QhsQEMrgUt5BxEQg16hELCzJsfZYy7nPPcSbuu0z+/ZEcnkOd+ZFgFUfJrGQhg8F2Is86bOqJsvyRbUeQxOJdORQa3dkJPb7T57j6B9BgQ3nJBrRJjpxNc6bbFAQNZvgdMZX6taEkH3OvtNekhK7Yh6v/NE2TNfRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmBx1L3f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmBx1L3f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68671C4CEF0;
	Fri, 19 Sep 2025 19:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758309710;
	bh=tvrdwVbBASlH/KuZoVbAmvS3Odq/Ure2qLJP6zfXhQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EmBx1L3fMIMaV+eE/PiDD5MrEa/K0WO8lQZtQYTN8fOFtDgX9B2L+pf5ttNXOE/Dm
	 wzVMWoCWRu1cZ/mOPDXSnHT2k9mJ9dFK6cZPxonpjx/FwVZ6VLQhXGbc5P6FfLdrIh
	 6y1p0XwXZ2kSdw6RfrwBFkpmkFny5dhxc7/sDXxsEPcvf2wCO7Dq8nLJ5U9kD5WefR
	 tgIpDYNJjhv+UNA/pW8UNXobYYIPLbmFkYI4RWMCoUNUd9yto6Joj5tzmiyDBB6PhY
	 0WCKs5bon0UyD3HONbJNpp56T1l86OF17Ckp0GexgoRs65QS8XY3pWDBvHDGYUSfuJ
	 DpkypqvgL/S/A==
Date: Fri, 19 Sep 2025 16:21:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>, Kevin Tian <kevin.tian@intel.com>
Subject: Re: [Patch v3 5/6] perf tools kvm: Use "cycles" to sample guest for
 "kvm record" on Intel
Message-ID: <aM2tSh6RGo2hB-XM@x1>
References: <20250919021659.1263351-1-dapeng1.mi@linux.intel.com>
 <20250919021659.1263351-6-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919021659.1263351-6-dapeng1.mi@linux.intel.com>

On Fri, Sep 19, 2025 at 10:16:58AM +0800, Dapeng Mi wrote:
> After KVM supports PEBS for guest on Intel platforms
> (https://lore.kernel.org/all/20220411101946.20262-1-likexu@tencent.com/),

So this isn't something selectable, i.e. with the patch above there is
no way to disable precise samples on the guest and instead allow the
host to use perf kvm with cycles:P to have a more precise view of guest
samples?

I.e. wouldn't it be better to make cycles:P be accepted and since it
fails, it drops precise_ip to zero as its the "most precise" it can use
on the host when the guest is "hoarding"/using PEBS?

> host loses the capability to sample guest with PEBS since all PEBS related
> MSRs are switched to guest value after vm-entry, like IA32_DS_AREA MSR is
> switched to guest GVA at vm-entry. This would lead to "perf kvm record"
> fails to sample guest on Intel platforms since "cycles:P" event is used to
> sample guest by default as below case shows.

Or it is even worse than I thought, the host _can_ ask for cycles:P, get
it but then _when the guest_ vm-entries and while it is running, the
host doesn't have access to it?

Isn't there any programmatic way for the host to know if the guest is
with PEBS and thus make cycles:P turn into plain "cycles"?

- Arnaldo

> sudo perf kvm record -a
> ^C[ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.787 MB perf.data.guest ]
> 
> So to ensure guest record can be sampled successfully, use "cycles"
> instead of "cycles:P" to sample guest record by default on Intel
> platforms. With this patch, the guest record can be sampled
> successfully.

but unconditionally not having access to PEBS :-\

- Arnaldo
 
> sudo perf kvm record -a
> ^C[ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.783 MB perf.data.guest (23 samples) ]
> 
> Reported-by: Kevin Tian <kevin.tian@intel.com>
> Fixes: cf8e55fe50df ("KVM: x86/pmu: Expose CPUIDs feature bits PDCM, DS, DTES64")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/arch/x86/util/kvm-stat.c | 51 +++++++++++++++++++++++++++++
>  tools/perf/builtin-kvm.c            | 10 ------
>  tools/perf/util/kvm-stat.h          | 10 ++++++
>  3 files changed, 61 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
> index 424716518b75..bff36f9345ea 100644
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
> @@ -211,3 +213,52 @@ int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid)
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
> +	int ret = 0, i, j = *argc;
> +
> +	const struct option event_options[] = {
> +		OPT_BOOLEAN('e', "event", &event, NULL),
> +		OPT_BOOLEAN(0, "pfm-events", &event, NULL),
> +		OPT_END()
> +	};
> +
> +	if (!x86__is_intel_cpu())
> +		return 0;
> +
> +	tmp = calloc(j + 1, sizeof(char *));
> +	if (!tmp)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < j; i++)
> +		tmp[i] = argv[i];
> +
> +	parse_options(j, tmp, event_options, NULL, PARSE_OPT_KEEP_UNKNOWN);
> +	if (!event) {
> +		argv[j++] = STRDUP_FAIL_EXIT("-e");
> +		argv[j++] = STRDUP_FAIL_EXIT("cycles");
> +		*argc += 2;
> +	}
> +
> +	free(tmp);
> +	return 0;
> +
> +EXIT:
> +	free(tmp);
> +	return ret;
> +}
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index d297a7b2c088..c0d62add4996 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -1636,16 +1636,6 @@ static int kvm_events_report_vcpu(struct perf_kvm_stat *kvm)
>  	return ret;
>  }
>  
> -#define STRDUP_FAIL_EXIT(s)		\
> -	({	char *_p;		\
> -		_p = strdup(s);		\
> -		if (!_p) {		\
> -			ret = -ENOMEM;	\
> -			goto EXIT;	\
> -		}			\
> -		_p;			\
> -	})
> -
>  int __weak setup_kvm_events_tp(struct perf_kvm_stat *kvm __maybe_unused)
>  {
>  	return 0;
> diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
> index 4249542544bb..53db3d56108b 100644
> --- a/tools/perf/util/kvm-stat.h
> +++ b/tools/perf/util/kvm-stat.h
> @@ -190,5 +190,15 @@ static inline struct kvm_info *kvm_info__new(void)
>  #define kvm_info__zput(ki) do { } while (0)
>  #endif /* HAVE_KVM_STAT_SUPPORT */
>  
> +#define STRDUP_FAIL_EXIT(s)		\
> +	({	char *_p;		\
> +		_p = strdup(s);		\
> +		if (!_p) {		\
> +			ret = -ENOMEM;	\
> +			goto EXIT;	\
> +		}			\
> +		_p;			\
> +	})
> +
>  extern int kvm_add_default_arch_event(int *argc, const char **argv);
>  #endif /* __PERF_KVM_STAT_H */
> -- 
> 2.34.1
