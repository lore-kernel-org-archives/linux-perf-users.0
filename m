Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A73269CE7;
	Tue, 26 May 2026 00:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779755914; cv=none; b=GaUwdxr3SDwFVjpZqqRlviJZzeWrJhkQbJ98zLsKcbFobag+t5qa4ja692+XgzkwORJ24whVg2ZGKEdcJwwRtHFzBfx+4h1CSxMtpH1qnQGpxh5LYdnPTaqEewUEaJHQH9V0bc4S+z4EpEgvCywpXilHzXZEY/xYRsDxBAHkgUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779755914; c=relaxed/simple;
	bh=H/5GODmyDBgk1tQIc8wvDX2DoC+LUj0xBMMxYC3c7K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dz70JmuaJ1Uj+kk91DvmjwMv70yqckgh+MRMvygJLemTLIYdPb2F/HQb4E4LSzfkaVL0Z1CoQbvgFJ6j2XVzlk5XMFRVwguJoLSSmwNHiF4blYN4xQIpAuC9V8vb1PLKtrgoBGrFQvVKy5Q2BBrhNIc+hbe7Jb7KpQojNDAbsJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDMv2isJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDMv2isJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88B41F000E9;
	Tue, 26 May 2026 00:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779755913;
	bh=+8bg39MIcg+2fCN2CcreG9UKxic/kHUFI16hwnrIPTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BDMv2isJG+a49bLqmydipTEXev0lODsV4+5mDUq3oczED3dZEF0iShW5RHdqk2O82
	 NFHC7OoCxoP8jXQeIKoyooWPI/+4fT2pOgT+STKnuHdzCExMt7DsrHg8efowqs11tZ
	 9rzy5QLcF8NrBJ/EJuL+tMx2Mb5FIRTQceHDmq1wcsFIQd0rqAF6Cm6asJFNzFcidL
	 HstRwuWkMFw/WZAApuU39gGNbrGFrgI4nO5mio4qQQ1h5bIm589dIUH7I30/NAsSgW
	 tq+j4jvQv4GCLwokY87SlHCWy8wZ3cbAN4EBpgaTBhVr6c2Z1lO2bzQszausBU44mE
	 XDfp60DN+jYIQ==
Date: Mon, 25 May 2026 19:38:29 -0500
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, alice.mei.rogers@gmail.com,
	dapeng1.mi@linux.intel.com, james.clark@linaro.org,
	leo.yan@linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Subject: Re: [PATCH v9 07/23] perf evsel/evlist: Avoid unnecessary #includes
Message-ID: <ahTrhaHGEtHLEAIM@google.com>
References: <20260428071903.1886173-1-irogers@google.com>
 <20260522220435.2378363-1-irogers@google.com>
 <20260522220435.2378363-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260522220435.2378363-8-irogers@google.com>

On Fri, May 22, 2026 at 03:04:18PM -0700, Ian Rogers wrote:
> Use forward declarations and remove unnecessary #includes in
> evsel.h. Sort the forward declarations in evsel.h and evlist.h.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/evlist.h | 15 +++++++++------
>  tools/perf/util/evsel.h  | 20 +++++++++++---------
>  2 files changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index e507f5f20ef6..e54761c670b6 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -2,29 +2,32 @@
>  #ifndef __PERF_EVLIST_H
>  #define __PERF_EVLIST_H 1
>  
> +#include <signal.h>
> +
>  #include <linux/compiler.h>
>  #include <linux/kernel.h>
> -#include <linux/refcount.h>
>  #include <linux/list.h>
> +#include <linux/refcount.h>
> +#include <pthread.h>
> +#include <unistd.h>
> +
>  #include <api/fd/array.h>
>  #include <internal/evlist.h>
>  #include <internal/evsel.h>
>  #include <perf/evlist.h>
> +
>  #include "affinity.h"
>  #include "events_stats.h"
>  #include "evsel.h"
>  #include "rblist.h"
> -#include <pthread.h>
> -#include <signal.h>
> -#include <unistd.h>
>  
> -struct pollfd;
> -struct thread_map;
>  struct perf_cpu_map;
>  struct perf_stat_config;
> +struct pollfd;
>  struct record_opts;
>  struct strbuf;
>  struct target;
> +struct thread_map;
>  
>  /*
>   * State machine of bkw_mmap_state:
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 927e5b4756cc..2221694bb819 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -2,28 +2,30 @@
>  #ifndef __PERF_EVSEL_H
>  #define __PERF_EVSEL_H 1
>  
> -#include <linux/list.h>
>  #include <stdbool.h>
> -#include <sys/types.h>
> +
> +#include <linux/list.h>
>  #include <linux/perf_event.h>
>  #include <linux/types.h>
> +#include <sys/types.h>
> +
>  #include <internal/evsel.h>
>  #include <perf/evsel.h>
> +
>  #include "symbol_conf.h"
> -#include "pmus.h"
> -#include "pmu.h"
>  
> +struct bperf_follower_bpf;
> +struct bperf_leader_bpf;
> +struct bpf_counter_ops;
>  struct bpf_object;
>  struct cgroup;
> +struct hashmap;
>  struct perf_counts;
> +struct perf_pmu;
>  struct perf_stat_config;
>  struct perf_stat_evsel;
> -union perf_event;
> -struct bpf_counter_ops;
>  struct target;
> -struct hashmap;
> -struct bperf_leader_bpf;
> -struct bperf_follower_bpf;
> +union perf_event;
>  
>  typedef int (evsel__sb_cb_t)(union perf_event *event, void *data);
>  
> -- 
> 2.54.0.794.g4f17f83d09-goog
> 
