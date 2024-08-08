Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD6F18C910;
	Thu,  8 Aug 2024 12:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723120816; cv=none; b=Ibi6hkOiCISQUcA8Mxzk5ICkZGvvoVxt5iKpfLmHkKghJTGtTtf9h1HsOwTM+J8eLHieiOgpm+R/0+KhJS/56lD+9vxwpb+aO7naUuDdLF6NvSfE6Sgmk7GTdzxE9iptpwaxwSE+Ndb0+gHJh1TpKoZfQ6/Iy1AsdQH33bpmcYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723120816; c=relaxed/simple;
	bh=GyX//lK787LZvjPjS3bRSLEAfNMrRavA9dkEwuHWV6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtqotdBpiRNFxDRs8Qc47jfmGScg44/a8Hcd7g4DJUqRPaZp2QNqpvSFD2kDGvt4NL+MkrYnD0JaSQ6ODhamGPI0f2ZhmWvG1MLXsPe9crALn5qP2kqsp8ooPso0sLntx5wgrBke463qe7+lT5jvR0FBnoCqviHy+ZQ0NMWK7jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7NW62FT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7NW62FT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498C8C32782;
	Thu,  8 Aug 2024 12:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723120815;
	bh=GyX//lK787LZvjPjS3bRSLEAfNMrRavA9dkEwuHWV6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a7NW62FTxOEsHjJ/rt5daim2TUVOYA3H7UzmXpuq/EKnUJYqSuafmn/92R1tUkf2p
	 hABuz14RAppkvcKR3VCdXBhV5bj22p/Fv8eoEeHCEx8cXEGrcWCNujJIBkqpSxKyCT
	 u5bbr8mMG5Tc6o6rxLrqZu6tKCfUaBfSb9KZmRpqW8eZaii/oVjlLggzwgpC6D2BVQ
	 lLy/ZsYYvfWYipeersowcNWWjzNqDjKw/lCScYgHmdGwvVcUAET3F/EBKbkovGlg2v
	 Hit0Zw28Q9mBjkMMxoVTd0UgJ5M1y8SyobjHwQhJjnciZBhlJoyXb6yUJOxBD4UlFR
	 80vsYwKdEH9bw==
Date: Thu, 8 Aug 2024 09:40:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] perf annotate: Cache debuginfo for data type profiling
Message-ID: <ZrS8q2J93G6xdFrx@x1>
References: <20240805234648.1453689-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805234648.1453689-1-namhyung@kernel.org>

On Mon, Aug 05, 2024 at 04:46:48PM -0700, Namhyung Kim wrote:
> In find_data_type(), it creates and deletes a debug info whenver it
> tries to find data type for a sample.  This is inefficient and it most
> likely accesses the same binary again and again.
> 
> Let's add a single entry cache the debug info structure for the last DSO.
> Depending on sample data, it usually gives me 2~3x (and sometimes more)
> speed ups.
> 
> Note that this will introduce a little difference in the output due to
> the order of checking stack operations.  It used to check the stack ops
> before checking the availability of debug info but I moved it after the
> symbol check.  So it'll report stack operations in DSOs without debug
> info as unknown.  But I think it's ok and better to have the checking
> near the caching logic.

Thanks, tested and applied.

- Arnaldo
 
> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> v2) add an assertion for the single-threaded case.
> v3) update the comment according to Ian.
> 
>  tools/perf/util/annotate-data.c | 15 ++-----------
>  tools/perf/util/annotate-data.h |  2 +-
>  tools/perf/util/annotate.c      | 37 +++++++++++++++++++++++++++++++++
>  tools/perf/util/annotate.h      |  2 ++
>  tools/perf/util/session.c       |  2 ++
>  5 files changed, 44 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index 734acdd8c4b7..f125ac5f0bda 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -1345,16 +1345,9 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
>   */
>  struct annotated_data_type *find_data_type(struct data_loc_info *dloc)
>  {
> -	struct annotated_data_type *result = NULL;
>  	struct dso *dso = map__dso(dloc->ms->map);
>  	Dwarf_Die type_die;
>  
> -	dloc->di = debuginfo__new(dso__long_name(dso));
> -	if (dloc->di == NULL) {
> -		pr_debug_dtp("cannot get the debug info\n");
> -		return NULL;
> -	}
> -
>  	/*
>  	 * The type offset is the same as instruction offset by default.
>  	 * But when finding a global variable, the offset won't be valid.
> @@ -1364,13 +1357,9 @@ struct annotated_data_type *find_data_type(struct data_loc_info *dloc)
>  	dloc->fbreg = -1;
>  
>  	if (find_data_type_die(dloc, &type_die) < 0)
> -		goto out;
> -
> -	result = dso__findnew_data_type(dso, &type_die);
> +		return NULL;
>  
> -out:
> -	debuginfo__delete(dloc->di);
> -	return result;
> +	return dso__findnew_data_type(dso, &type_die);
>  }
>  
>  static int alloc_data_type_histograms(struct annotated_data_type *adt, int nr_entries)
> diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
> index 992b7ce4bd11..37a1a3b68e0b 100644
> --- a/tools/perf/util/annotate-data.h
> +++ b/tools/perf/util/annotate-data.h
> @@ -123,9 +123,9 @@ struct data_loc_info {
>  	u64 var_addr;
>  	u8 cpumode;
>  	struct annotated_op_loc *op;
> +	struct debuginfo *di;
>  
>  	/* These are used internally */
> -	struct debuginfo *di;
>  	int fbreg;
>  	bool fb_cfa;
>  
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index a2ee4074f768..a28d8a4b8a14 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -25,6 +25,7 @@
>  #include "srcline.h"
>  #include "units.h"
>  #include "debug.h"
> +#include "debuginfo.h"
>  #include "annotate.h"
>  #include "annotate-data.h"
>  #include "evsel.h"
> @@ -2326,6 +2327,20 @@ u64 annotate_calc_pcrel(struct map_symbol *ms, u64 ip, int offset,
>  	return map__rip_2objdump(ms->map, addr);
>  }
>  
> +static struct debuginfo_cache {
> +	struct dso *dso;
> +	struct debuginfo *dbg;
> +} di_cache;
> +
> +void debuginfo_cache__delete(void)
> +{
> +	dso__put(di_cache.dso);
> +	di_cache.dso = NULL;
> +
> +	debuginfo__delete(di_cache.dbg);
> +	di_cache.dbg = NULL;
> +}
> +
>  /**
>   * hist_entry__get_data_type - find data type for given hist entry
>   * @he: hist entry
> @@ -2360,6 +2375,27 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
>  		return NULL;
>  	}
>  
> +	/*
> +	 * di_cache holds a pair of values, but code below assumes
> +	 * di_cache.dso can be compared/updated and di_cache.dbg can be
> +	 * read/updated independently from each other. That assumption only
> +	 * holds in single threaded code.
> +	 */
> +	assert(perf_singlethreaded);
> +
> +	if (map__dso(ms->map) != di_cache.dso) {
> +		dso__put(di_cache.dso);
> +		di_cache.dso = dso__get(map__dso(ms->map));
> +
> +		debuginfo__delete(di_cache.dbg);
> +		di_cache.dbg = debuginfo__new(dso__long_name(di_cache.dso));
> +	}
> +
> +	if (di_cache.dbg == NULL) {
> +		ann_data_stat.no_dbginfo++;
> +		return NULL;
> +	}
> +
>  	/* Make sure it has the disasm of the function */
>  	if (symbol__annotate(ms, evsel, &arch) < 0) {
>  		ann_data_stat.no_insn++;
> @@ -2404,6 +2440,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
>  			.ip = ms->sym->start + dl->al.offset,
>  			.cpumode = he->cpumode,
>  			.op = op_loc,
> +			.di = di_cache.dbg,
>  		};
>  
>  		if (!op_loc->mem_ref && op_loc->segment == INSN_SEG_NONE)
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index 9ba772f46270..27d9540604ef 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -543,4 +543,6 @@ struct annotated_basic_block {
>  int annotate_get_basic_blocks(struct symbol *sym, s64 src, s64 dst,
>  			      struct list_head *head);
>  
> +void debuginfo_cache__delete(void);
> +
>  #endif	/* __PERF_ANNOTATE_H */
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 5596bed1b8c8..f9072e003367 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -36,6 +36,7 @@
>  #include "util.h"
>  #include "arch/common.h"
>  #include "units.h"
> +#include "annotate.h"
>  #include <internal/lib.h>
>  
>  #ifdef HAVE_ZSTD_SUPPORT
> @@ -304,6 +305,7 @@ void perf_session__delete(struct perf_session *session)
>  		return;
>  	auxtrace__free(session);
>  	auxtrace_index__free(&session->auxtrace_index);
> +	debuginfo_cache__delete();
>  	perf_session__destroy_kernel_maps(session);
>  	perf_decomp__release_events(session->decomp_data.decomp);
>  	perf_env__exit(&session->header.env);
> -- 
> 2.46.0.rc2.264.g509ed76dc8-goog
