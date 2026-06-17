Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D631E47F2F3;
	Wed, 17 Jun 2026 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781712499; cv=none; b=Fe7Qd8BEHs65/axfxqGcbOGPJPcT7gCs6xGa4GltzpkriOAEBqq26Yt7f3kLsM1ig8if1go1e2mZGAFmPdu+Tl1YKmO1SkJ5pyoOHfUsjfr9wO5PDjFgcrdbrz9jNmCWrKOhxDPQCIne+UawGrU/ULIEQrjs5JtX09bdswa+52c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781712499; c=relaxed/simple;
	bh=M7PyqSd5OSBX6l4vfQuWKyxUapc+vQfZYC0hwjTf/xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgYAibRmAEvQrP1WHVr0R20h41TqDmRkKSqPWpXYBUTpIMDi4hXMQlIPFjxnfd6epmylkjuXuM6PDlfPxhsI0Fd+3DblI6C2Ik5GZz9liz7CrmVG2E9HMEtAw4mla4Xg9LBnC11Tt1xXGVwLRRQDO2EO6t7OLzXyem1dYYAmsRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xl2H9waz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xl2H9waz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0091F00A3A;
	Wed, 17 Jun 2026 16:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781712488;
	bh=AhymPJVfwpPIhwqEvOUkvv+c5VhvoR1DOnDzDfUO4xs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xl2H9waznepevkZm6dhmn9+HjqdYpAI7zFOR2C7vXTUGMwTxvf8eONN8v6eXmvws5
	 Z01MDC2g6S+xUFV7B2wR9YrwEkONVLBf5u8st/4zg/cWkgi9r4OA9YHbvvlhnkKDUx
	 UapvRyUQsBU7N+fBQuvdplL+pGLzxyfbXx2heBPDPKN0Uq62HhypGx86M+0A3ytwzU
	 FLU8VR+0ItE70R+HFsl0m4fS+D0rJxWCV/PRcV3K3WeeCEoH9kBJ3SccJKFMDxGZ0P
	 wtyXdspxCt14vL7J8ZWHDl+D4E+iH+VfqliG0u6rNJ0gaXT9WrnEzgkzVDMXGpnNoo
	 DSnhIrQmEfuWQ==
Date: Wed, 17 Jun 2026 13:08:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, adrian.hunter@intel.com,
	alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com,
	james.clark@linaro.org, leo.yan@linux.dev,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Subject: Re: [PATCH v21 03/21] perf evsel/evlist: Avoid unnecessary #includes
Message-ID: <ajLGZBOPNraF3Fj3@x1>
References: <20260615223011.3873955-1-irogers@google.com>
 <20260616011543.4037138-1-irogers@google.com>
 <20260616011543.4037138-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260616011543.4037138-4-irogers@google.com>

On Mon, Jun 15, 2026 at 06:15:25PM -0700, Ian Rogers wrote:
> Use forward declarations and remove unnecessary #includes in
> evsel.h. Sort the forward declarations in evsel.h and evlist.h. Move
> some PMU code into evsel.c.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

⬢ [acme@toolbx perf-tools-next2]$ git log --oneline -5
ce69f4f6d7467ef4 (HEAD) perf evsel/evlist: Avoid unnecessary #includes
23dce143f5ed0557 perf python: Add missed explicit dependencies
ca74d08280ad690f perf util: Sort includes and add missed explicit dependencies
776bd9ac834556ab (x1/perf-tools-next, perf-tools-next.korg/tmp.perf-tools-next, perf-tools-next.korg/perf-tools-next, origin/perf-tools-next) perf bpf: Fix up build failure due to change of btf_vlen() return type
522ae978ac720a91 (origin/perf/hardening-9) perf dso: Set standard errno on decompression failure
⬢ [acme@toolbx perf-tools-next2]$

  LD      /tmp/build/perf-tools-next2/util/scripting-engines/perf-util-in.o
make[3]: *** [/home/acme/git/perf-tools-next2/tools/build/Makefile.build:158: util] Error 2
make[2]: *** [Makefile.perf:573: /tmp/build/perf-tools-next2/perf-util-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....
  LD      /tmp/build/perf-tools-next2/tests/perf-test-in.o
  LD      /tmp/build/perf-tools-next2/perf-test-in.o
  LD      /tmp/build/perf-tools-next2/perf-in.o
make[1]: *** [Makefile.perf:288: sub-make] Error 2
make: *** [Makefile:122: install-bin] Error 2
make: Leaving directory '/home/acme/git/perf-tools-next2/tools/perf'
⬢ [acme@toolbx perf-tools-next2]$

I added this to fix the build:

⬢ [acme@toolbx perf-tools-next2]$ git diff
diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
index 6a7542e7db827d1b..027695d967798487 100644
--- a/tools/perf/util/aslr.c
+++ b/tools/perf/util/aslr.c
@@ -13,6 +13,7 @@
 #include "session.h"
 #include "data.h"
 #include "dso.h"
+#include "pmu.h"
 #include "pmus.h"

 #include <internal/lib.h>  /* page_size */
⬢ [acme@toolbx perf-tools-next2]$

Applied the series, now testing.

- Arnaldo

> ---
>  tools/perf/util/evlist.h | 15 +++++++++------
>  tools/perf/util/evsel.c  |  5 +++++
>  tools/perf/util/evsel.h  | 25 ++++++++++++-------------
>  3 files changed, 26 insertions(+), 19 deletions(-)
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
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 34c03f47a913..19e48b9260e9 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -370,6 +370,11 @@ void evsel__set_sample_id(struct evsel *evsel,
>  	evsel->core.attr.read_format |= PERF_FORMAT_ID;
>  }
>  
> +bool evsel__is_non_perf_event_open_pmu(const struct evsel *evsel)
> +{
> +	return evsel->pmu && evsel->pmu->type > PERF_PMU_TYPE_PE_END;
> +}
> +
>  /**
>   * evsel__is_function_event - Return whether given evsel is a function
>   * trace event
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 8178858d168a..6b28cd754a18 100644
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
> @@ -356,10 +358,6 @@ void arch_evsel__apply_ratio_to_prev(struct evsel *evsel, struct perf_event_attr
>  int evsel__set_filter(struct evsel *evsel, const char *filter);
>  int evsel__append_tp_filter(struct evsel *evsel, const char *filter);
>  int evsel__append_addr_filter(struct evsel *evsel, const char *filter);
> -static inline bool evsel__is_non_perf_event_open_pmu(const struct evsel *evsel)
> -{
> -	return evsel->pmu && evsel->pmu->type > PERF_PMU_TYPE_PE_END;
> -}
>  
>  int evsel__enable_cpu(struct evsel *evsel, int cpu_map_idx);
>  int evsel__enable(struct evsel *evsel);
> @@ -478,6 +476,7 @@ static inline bool evsel__is_group_event(struct evsel *evsel)
>  	return evsel__is_group_leader(evsel) && evsel->core.nr_members > 1;
>  }
>  
> +bool evsel__is_non_perf_event_open_pmu(const struct evsel *evsel);
>  bool evsel__is_function_event(struct evsel *evsel);
>  
>  static inline bool evsel__is_bpf_output(struct evsel *evsel)
> -- 
> 2.54.0.1136.gdb2ca164c4-goog
