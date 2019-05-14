From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH 2/3] perf parse-regs: Add generic support for non-gprs
Date: Tue, 14 May 2019 15:19:02 -0300
Message-ID: <20190514181902.GB1756@kernel.org>
References: <1557844753-58223-1-git-send-email-kan.liang@linux.intel.com>
 <1557844753-58223-2-git-send-email-kan.liang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1557844753-58223-2-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kan.liang@linux.intel.com
Cc: Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

Em Tue, May 14, 2019 at 07:39:12AM -0700, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Some non general purpose registers, e.g. XMM, can be collected on some
> platforms, e.g. X86 Icelake.
> 
> Add a weak function has_non_gprs_support() to check if the
> kernel/hardware support non-gprs collection.
> Add a weak function non_gprs_mask() to return non-gprs mask.
> 
> By default, the non-gprs collection is not support. Specific platforms
> should implement their own non-gprs functions if they can collect
> non-gprs.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/util/parse-regs-options.c | 10 +++++++++-
>  tools/perf/util/perf_regs.c          | 10 ++++++++++
>  tools/perf/util/perf_regs.h          |  2 ++
>  3 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
> index b21617f..2f90f31 100644
> --- a/tools/perf/util/parse-regs-options.c
> +++ b/tools/perf/util/parse-regs-options.c
> @@ -12,6 +12,7 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>  	const struct sample_reg *r;
>  	char *s, *os = NULL, *p;
>  	int ret = -1;
> +	bool has_non_gprs = has_non_gprs_support(intr);

This is generic code, what does "non gprs" means for !Intel? Can we come
up with a better, not architecture specific jargon? Or you mean "general
purpose registers"?

Perhaps we can ask for a register mask for use with intr? I.e.:

For the -I/--intr-regs

        uint64_t mask = arch__intr_reg_mask();

And for --user-regs

        uint64_t mask = arch__user_reg_mask();

And then on that loop do:

  	for (r = sample_reg_masks; r->name; r++) {
		if (r->mask & mask))
  			fprintf(stderr, "%s ", r->name);
  	}

?
  
>  	if (unset)
>  		return 0;
> @@ -37,6 +38,8 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>  			if (!strcmp(s, "?")) {
>  				fprintf(stderr, "available registers: ");
>  				for (r = sample_reg_masks; r->name; r++) {
> +					if (!has_non_gprs && (r->mask & ~PERF_REGS_MASK))
> +						break;
>  					fprintf(stderr, "%s ", r->name);
>  				}
>  				fputc('\n', stderr);
> @@ -44,6 +47,8 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>  				return -1;
>  			}
>  			for (r = sample_reg_masks; r->name; r++) {
> +				if (!has_non_gprs && (r->mask & ~PERF_REGS_MASK))
> +					continue;
>  				if (!strcasecmp(s, r->name))
>  					break;
>  			}
> @@ -64,8 +69,11 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>  	ret = 0;
>  
>  	/* default to all possible regs */
> -	if (*mode == 0)
> +	if (*mode == 0) {
>  		*mode = PERF_REGS_MASK;
> +		if (has_non_gprs)
> +			*mode |= non_gprs_mask(intr);
> +	}
>  error:
>  	free(os);
>  	return ret;
> diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
> index 2acfcc5..0d278b6 100644
> --- a/tools/perf/util/perf_regs.c
> +++ b/tools/perf/util/perf_regs.c
> @@ -13,6 +13,16 @@ int __weak arch_sdt_arg_parse_op(char *old_op __maybe_unused,
>  	return SDT_ARG_SKIP;
>  }
>  
> +bool __weak has_non_gprs_support(bool intr __maybe_unused)
> +{
> +	return false;
> +}
> +
> +u64 __weak non_gprs_mask(bool intr __maybe_unused)
> +{
> +	return 0;
> +}
> +
>  #ifdef HAVE_PERF_REGS_SUPPORT
>  int perf_reg_value(u64 *valp, struct regs_dump *regs, int id)
>  {
> diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
> index 1a15a4b..983b4e6 100644
> --- a/tools/perf/util/perf_regs.h
> +++ b/tools/perf/util/perf_regs.h
> @@ -23,6 +23,8 @@ enum {
>  };
>  
>  int arch_sdt_arg_parse_op(char *old_op, char **new_op);
> +bool has_non_gprs_support(bool intr);
> +u64 non_gprs_mask(bool intr);
>  
>  #ifdef HAVE_PERF_REGS_SUPPORT
>  #include <perf_regs.h>
> -- 
> 2.7.4

-- 

- Arnaldo
