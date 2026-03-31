Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5686538A709;
	Tue, 31 Mar 2026 20:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774989757; cv=none; b=nF/b5FTa//YBPgGZ0tpxDrW0IA7Skb8A66L72xmOy/iu5HRO3NQ42tJOd0wIBbyTkra6/KJExB5A3lANdgjOo01vOaj68lcB0AaFCA6S+51ahxDZa5iSOZPlK1IEaGRUvAYPkFA/mHgBRxq0/N8nG/6c3x1fhzc2BWJuKdXZ/8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774989757; c=relaxed/simple;
	bh=lzItpDMUFe9IIz3v9bFnYpmMsgPI8d54FF5k3tmR9SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daMQqPCFrw8Ori7rd4IljQISLCaY1P9MODQAcZAk04GOZa7evImhVPim7/rMufzGc2Cx+xWL71WgrJrnR+JPEUzg8AADasfnhKw+8v38FnD3FEP/Z1IsN/RmQES58TLdR+RW099kQgVicBcyk4JzhthTJ+mkIbdMiaWVK7I4+lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaU4OE10; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaU4OE10"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDFBC19423;
	Tue, 31 Mar 2026 20:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774989757;
	bh=lzItpDMUFe9IIz3v9bFnYpmMsgPI8d54FF5k3tmR9SU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QaU4OE10H056EqgLekISQyTNMKqmyYtiHbhYw/Mj0n67L4i/yoT+My5/qCjmIbN3y
	 o6yu+46tw9DoMzXZyUXh5brNEE13qqrrr83zFHVZithqigjgUnjpVYgNJ48fCyGSIv
	 pzSymJnWUvnRkUrftay1tRwghIyT1bcoekEnMpU1UUsWU5p5w+cHDCa66G8vJYRIrT
	 if0NpVydS2POlOW1DMA8RndiVKGuvJh2jJ2qu/Wh+5Iq6X2zWn0gw5pgD5n+uoqurK
	 M0drrE9Y5JiQ68bO9qEGI1FDLaRDlZsFcdjcORbwv/91cUj8DrBWAPH1Sx+F3eVHSj
	 7eQ9fYNHmocZQ==
Date: Tue, 31 Mar 2026 17:42:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr,
	alexander.shishkin@linux.intel.com, andrew.jones@oss.qualcomm.com,
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com,
	blakejones@google.com, ctshao@google.com,
	dapeng1.mi@linux.intel.com, howardchu95@gmail.com,
	james.clark@linaro.org, john.g.garry@oracle.com, jolsa@kernel.org,
	leo.yan@linux.dev, libunwind-devel@nongnu.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
	mingo@redhat.com, namhyung@kernel.org, palmer@dabbelt.com,
	peterz@infradead.org, pjw@kernel.org, shimin.guo@skydio.com,
	tglozar@redhat.com, tmricht@linux.ibm.com, will@kernel.org,
	yuzhuo@google.com
Subject: Re: [PATCH v2 1/8] perf unwind: Refactor get_entries to allow
 dynamic libdw/libunwind selection
Message-ID: <acwxuPAo8g6C867R@x1>
References: <CAP-5=fWVU3ktkGAnZQrjQJf+Z5AtQo73BVUhj-nr3H95GdcEJQ@mail.gmail.com>
 <20260305221927.3237145-1-irogers@google.com>
 <20260305221927.3237145-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305221927.3237145-2-irogers@google.com>

On Thu, Mar 05, 2026 at 02:19:20PM -0800, Ian Rogers wrote:
> Currently, both libdw and libunwind define 'unwind__get_entries'. This
> causes a duplicate symbol build failure when both are compiled into
> perf.
> 
> This commit refactors the DWARF unwind post-processing to be
> configurable at runtime via the .perfconfig file option
> 'unwind.style', or using the argument '--unwind-style' in the commands
> 'perf report', 'perf script' and 'perf inject', in a similar manner to
> the addr2line or the disassembler style.
> 
> The file 'tools/perf/util/unwind.c' adds the top-level dispatch
> function 'unwind__get_entries'. The backend implementations are
> renamed to 'libdw__get_entries' and 'libunwind__get_entries'. Both are
> attempted as fallbacks if not configured, or if the primary backend
> fails.
> 
> Fixes: 2e9191573a69 ("perf build: Remove NO_LIBDW_DWARF_UNWIND option")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-inject.c        |   4 ++
>  tools/perf/builtin-report.c        |   4 ++
>  tools/perf/builtin-script.c        |   4 ++
>  tools/perf/util/Build              |   1 +
>  tools/perf/util/symbol_conf.h      |  15 +++++
>  tools/perf/util/unwind-libdw.c     |   2 +-
>  tools/perf/util/unwind-libunwind.c |   2 +-
>  tools/perf/util/unwind.c           | 102 +++++++++++++++++++++++++++++
>  tools/perf/util/unwind.h           |  40 +++++------
>  9 files changed, 149 insertions(+), 25 deletions(-)
>  create mode 100644 tools/perf/util/unwind.c
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 5b29f4296861..9ad681b3c0dc 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -26,6 +26,7 @@
>  #include "util/synthetic-events.h"
>  #include "util/thread.h"
>  #include "util/namespaces.h"
> +#include "util/unwind.h"
>  #include "util/util.h"
>  #include "util/tsc.h"
>  
> @@ -2539,6 +2540,9 @@ int cmd_inject(int argc, const char **argv)
>  		OPT_STRING(0, "guestmount", &symbol_conf.guestmount, "directory",
>  			   "guest mount directory under which every guest os"
>  			   " instance has a subdir"),
> +		OPT_CALLBACK(0, "unwind-style", NULL, "unwind style",
> +			     "unwind styles (libdw,libunwind)",
> +			     unwind__option),
>  		OPT_BOOLEAN(0, "convert-callchain", &inject.convert_callchain,
>  			    "Generate callchains using DWARF and drop register/stack data"),
>  		OPT_END()
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 3b81f4b3dc49..ae20c0679990 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -48,6 +48,7 @@
>  #include "util/time-utils.h"
>  #include "util/auxtrace.h"
>  #include "util/units.h"
> +#include "util/unwind.h"
>  #include "util/util.h" // perf_tip()
>  #include "ui/ui.h"
>  #include "ui/progress.h"
> @@ -1455,6 +1456,9 @@ int cmd_report(int argc, const char **argv)
>  	OPT_CALLBACK(0, "addr2line-style", NULL, "addr2line style",
>  		     "addr2line styles (libdw,llvm,libbfd,addr2line)",
>  		     report_parse_addr2line_config),
> +	OPT_CALLBACK(0, "unwind-style", NULL, "unwind style",
> +		     "unwind styles (libdw,libunwind)",
> +		     unwind__option),
>  	OPT_BOOLEAN(0, "demangle", &symbol_conf.demangle,
>  		    "Symbol demangling. Enabled by default, use --no-demangle to disable."),
>  	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 9f8b0fd27a0a..b6c7c164d02d 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -63,6 +63,7 @@
>  #include <linux/err.h>
>  #include "util/dlfilter.h"
>  #include "util/record.h"
> +#include "util/unwind.h"
>  #include "util/util.h"
>  #include "util/cgroup.h"
>  #include "util/annotate.h"
> @@ -4164,6 +4165,9 @@ int cmd_script(int argc, const char **argv)
>  			"Enable symbol demangling"),
>  	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
>  			"Enable kernel symbol demangling"),
> +	OPT_CALLBACK(0, "unwind-style", NULL, "unwind style",
> +		     "unwind styles (libdw,libunwind)",
> +		     unwind__option),
>  	OPT_STRING(0, "addr2line", &symbol_conf.addr2line_path, "path",
>  			"addr2line binary to use for line numbers"),
>  	OPT_STRING(0, "time", &script.time_str, "str",
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index bcccad7487a9..6190a8f5b0fa 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -218,6 +218,7 @@ ifndef CONFIG_SETNS
>  perf-util-y += setns.o
>  endif
>  
> +perf-util-y += unwind.o
>  perf-util-$(CONFIG_LIBDW) += probe-finder.o
>  perf-util-$(CONFIG_LIBDW) += dwarf-aux.o
>  perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
> diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
> index 71bb17372a6c..25d92bbbfee7 100644
> --- a/tools/perf/util/symbol_conf.h
> +++ b/tools/perf/util/symbol_conf.h
> @@ -9,6 +9,19 @@
>  struct strlist;
>  struct intlist;
>  
> +enum unwind_style {
> +
> +	UNWIND_STYLE_UNKNOWN = 0,
> +
> +	UNWIND_STYLE_LIBDW,
> +
> +	UNWIND_STYLE_LIBUNWIND,
> +
> +};
> +
> +#define MAX_UNWIND_STYLE (UNWIND_STYLE_LIBUNWIND + 1)
> +
> +
>  enum a2l_style {
>  	A2L_STYLE_UNKNOWN = 0,
>  	A2L_STYLE_LIBDW,
> @@ -80,6 +93,7 @@ struct symbol_conf {
>  			*bt_stop_list_str;
>  	const char		*addr2line_path;
>  	enum a2l_style	addr2line_style[MAX_A2L_STYLE];
> +	enum unwind_style unwind_style[MAX_UNWIND_STYLE];
>  	unsigned long	time_quantum;
>         struct strlist	*dso_list,
>  			*comm_list,
> @@ -103,3 +117,4 @@ struct symbol_conf {
>  extern struct symbol_conf symbol_conf;
>  
>  #endif // __PERF_SYMBOL_CONF
> +
> diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
> index 05e8e68bd49c..d8a5b7d54192 100644
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c
> @@ -339,7 +339,7 @@ frame_callback(Dwfl_Frame *state, void *arg)
>  	       DWARF_CB_ABORT : DWARF_CB_OK;
>  }
>  
> -int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
> +int libdw__get_entries(unwind_entry_cb_t cb, void *arg,
>  			struct thread *thread,
>  			struct perf_sample *data,
>  			int max_stack,
> diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
> index cb8be6acfb6f..a0016b897dae 100644
> --- a/tools/perf/util/unwind-libunwind.c
> +++ b/tools/perf/util/unwind-libunwind.c
> @@ -79,7 +79,7 @@ void unwind__finish_access(struct maps *maps)
>  		ops->finish_access(maps);
>  }
>  
> -int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
> +int libunwind__get_entries(unwind_entry_cb_t cb, void *arg,
>  			 struct thread *thread,
>  			 struct perf_sample *data, int max_stack,
>  			 bool best_effort)
> diff --git a/tools/perf/util/unwind.c b/tools/perf/util/unwind.c
> new file mode 100644
> index 000000000000..9ae7d5ad246d
> --- /dev/null
> +++ b/tools/perf/util/unwind.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "debug.h"
> +#include "symbol_conf.h"
> +#include "unwind.h"
> +#include <linux/string.h>
> +#include <string.h>
> +#include <stdlib.h>
> +
> +int unwind__get_entries(unwind_entry_cb_t cb __maybe_unused, void *arg __maybe_unused,
> +			struct thread *thread __maybe_unused,
> +			struct perf_sample *data __maybe_unused,
> +			int max_stack __maybe_unused,
> +			bool best_effort __maybe_unused)
> +{
> +	int ret = 0;
> +
> +#if defined(HAVE_LIBDW_SUPPORT) || defined(HAVE_LIBUNWIND_SUPPORT)
> +	if (symbol_conf.unwind_style[0] == UNWIND_STYLE_UNKNOWN) {
> +		int i = 0;
> +#ifdef HAVE_LIBDW_SUPPORT
> +		symbol_conf.unwind_style[i++] = UNWIND_STYLE_LIBDW;
> +#endif
> +#ifdef HAVE_LIBUNWIND_SUPPORT
> +		symbol_conf.unwind_style[i++] = UNWIND_STYLE_LIBUNWIND;
> +#endif
> +	}
> +#endif //defined(HAVE_LIBDW_SUPPORT) || defined(HAVE_LIBUNWIND_SUPPORT)
> +
> +	for (size_t i = 0; i < ARRAY_SIZE(symbol_conf.unwind_style); i++) {
> +		switch (symbol_conf.unwind_style[i]) {
> +		case UNWIND_STYLE_LIBDW:
> +#ifdef HAVE_LIBDW_SUPPORT
> +			ret = libdw__get_entries(cb, arg, thread, data, max_stack, best_effort);
> +#endif
> +			break;
> +		case UNWIND_STYLE_LIBUNWIND:
> +#ifdef HAVE_LIBUNWIND_SUPPORT
> +			ret = libunwind__get_entries(cb, arg, thread, data, max_stack, best_effort);
> +#endif
> +			break;


What if the user asks for one of the unwinders, symbol_conf.unwind_style
will be populated with the user's choices, but then here in
unwind__get_entries() we end up returning 0 because the user choice is
not built-in?

Also no warning will be emitted that what was asked for is not
available?

Maybe remove the ifdefs here and have a dummy libdw__get_entries() when
HAVE_LIBDW_SUPPORT ins't defined that emits the warning and returns -1?
Ditto for UNWIND_STYLE_LIBUNWIND?

- Arnaldo

> +		case UNWIND_STYLE_UNKNOWN:
> +		default:
> +#if !defined(HAVE_LIBDW_SUPPORT) && !defined(HAVE_LIBUNWIND_SUPPORT)
> +			pr_warning_once(
> +				"Error: dwarf unwinding not supported, build perf with libdw or libunwind.\n");
> +#endif
> +			ret = -1;
> +			break;
> +		}
> +		if (ret == 0)
> +			break;
> +	}
> +	return ret;
> +}
> +
> +int unwind__configure(const char *var, const char *value, void *cb __maybe_unused)
> +{
> +	static const char * const unwind_style_names[] = {
> +		[UNWIND_STYLE_LIBDW] = "libdw",
> +		[UNWIND_STYLE_LIBUNWIND] = "libunwind",
> +		NULL
> +	};
> +	char *s, *p, *saveptr;
> +	size_t i = 0;
> +
> +	if (strcmp(var, "unwind.style"))
> +		return 0;
> +
> +	if (!value)
> +		return -1;
> +
> +	s = strdup(value);
> +	if (!s)
> +		return -1;
> +
> +	p = strtok_r(s, ",", &saveptr);
> +	while (p && i < ARRAY_SIZE(symbol_conf.unwind_style)) {
> +		bool found = false;
> +		char *q = strim(p);
> +
> +		for (size_t j = UNWIND_STYLE_LIBDW; j < MAX_UNWIND_STYLE; j++) {
> +			if (!strcasecmp(q, unwind_style_names[j])) {
> +				symbol_conf.unwind_style[i++] = j;
> +				found = true;
> +				break;
> +			}
> +		}
> +		if (!found)
> +			pr_warning("Unknown unwind style: %s\n", q);
> +		p = strtok_r(NULL, ",", &saveptr);
> +	}
> +
> +	free(s);
> +	return 0;
> +}
> +
> +int unwind__option(const struct option *opt __maybe_unused,
> +		   const char *arg,
> +		   int unset __maybe_unused)
> +{
> +	return unwind__configure("unwind.style", arg, NULL);
> +}
> diff --git a/tools/perf/util/unwind.h b/tools/perf/util/unwind.h
> index 9f7164c6d9aa..581d042e170a 100644
> --- a/tools/perf/util/unwind.h
> +++ b/tools/perf/util/unwind.h
> @@ -7,6 +7,7 @@
>  #include "util/map_symbol.h"
>  
>  struct maps;
> +struct option;
>  struct perf_sample;
>  struct thread;
>  
> @@ -26,7 +27,9 @@ struct unwind_libunwind_ops {
>  			   struct perf_sample *data, int max_stack, bool best_effort);
>  };
>  
> -#ifdef HAVE_DWARF_UNWIND_SUPPORT
> +int unwind__configure(const char *var, const char *value, void *cb);
> +int unwind__option(const struct option *opt, const char *arg, int unset);
> +
>  /*
>   * When best_effort is set, don't report errors and fail silently. This could
>   * be expanded in the future to be more permissive about things other than
> @@ -36,8 +39,20 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
>  			struct thread *thread,
>  			struct perf_sample *data, int max_stack,
>  			bool best_effort);
> -/* libunwind specific */
> +
> +#ifdef HAVE_LIBDW_SUPPORT
> +int libdw__get_entries(unwind_entry_cb_t cb, void *arg,
> +		       struct thread *thread,
> +		       struct perf_sample *data, int max_stack,
> +		       bool best_effort);
> +#endif
> +
>  #ifdef HAVE_LIBUNWIND_SUPPORT
> +/* libunwind specific */
> +int libunwind__get_entries(unwind_entry_cb_t cb, void *arg,
> +			   struct thread *thread,
> +			   struct perf_sample *data, int max_stack,
> +			   bool best_effort);
>  #ifndef LIBUNWIND__ARCH_REG_ID
>  #define LIBUNWIND__ARCH_REG_ID(regnum) libunwind__arch_reg_id(regnum)
>  #endif
> @@ -57,26 +72,5 @@ static inline int unwind__prepare_access(struct maps *maps __maybe_unused,
>  static inline void unwind__flush_access(struct maps *maps __maybe_unused) {}
>  static inline void unwind__finish_access(struct maps *maps __maybe_unused) {}
>  #endif
> -#else
> -static inline int
> -unwind__get_entries(unwind_entry_cb_t cb __maybe_unused,
> -		    void *arg __maybe_unused,
> -		    struct thread *thread __maybe_unused,
> -		    struct perf_sample *data __maybe_unused,
> -		    int max_stack __maybe_unused,
> -		    bool best_effort __maybe_unused)
> -{
> -	return 0;
> -}
> -
> -static inline int unwind__prepare_access(struct maps *maps __maybe_unused,
> -					 struct map *map __maybe_unused,
> -					 bool *initialized __maybe_unused)
> -{
> -	return 0;
> -}
>  
> -static inline void unwind__flush_access(struct maps *maps __maybe_unused) {}
> -static inline void unwind__finish_access(struct maps *maps __maybe_unused) {}
> -#endif /* HAVE_DWARF_UNWIND_SUPPORT */
>  #endif /* __UNWIND_H */
> -- 
> 2.53.0.473.g4a7958ca14-goog
