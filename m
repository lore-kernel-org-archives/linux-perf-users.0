Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC3E443E3F;
	Thu, 17 Sep 2026 06:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628034; cv=none; b=ArxL3RiZKtL9nWjoVdZ5DOTQ6VPbHYBhVGPgwuz0eewW7RAI5dTGTAUuyQb6/0mdewa6PsUndCUkBGVaOs9e/ixxMyS/4mwxeD1BtXOPAQAwlj0qIg3ONZd2ceAUgQRTGuSppTLDUta+4gHef6T8ehX0v8G622VZESIK4nxtPtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628034; c=relaxed/simple;
	bh=JmqAWEPVjwgE/1bx2WvsdE2D+QvEYWO3E6EPtYfOOnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqwYkZWm1va0x2sY9WP9fFCIzXOZPlDP6dPmZj45MbD/z2b9D7eZ6LLO3rymbVx4+G/05T53TtxoLtUvSqbj4h+4km43Bga7u+XOwrHHjDclZFyn2FGGOjEV1M7BIupwNFRr2ydfipjm8rietl1DIHTYUx7AmORWLaIOmQNIN8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCxmC7Us; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCxmC7Us"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A220E1F000FF;
	Thu, 17 Sep 2026 06:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789628032;
	bh=utH4PF6qbWgnDQlfP0MYl4dC4Pf37QpCdRdthBuPF0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NCxmC7Ustl0TX6FsrdwjcjsCW7+0eA+qRmMnlIPTNjGRKXu4hQIkq5FWla7nqYftD
	 W5RmjlC1EdwuXF+Fgwdf9EI3XB366BAQlpSUvQSGrJUsbUuei7iSFTgKYQc1Pku6Oe
	 HS3DsswD5UzFKEBK5Mtj3w5ZvlIBbG7v9z1j/+XP/5I80k3icKGppESwl3wyRO34Vj
	 0UuObKjnL4bBBadYOKtkDroeUYRvg7bV1HB1H+j3TP7XKEiVRmA4qlmwnu/t32keEy
	 8s6zQIrGTZ3YWGjnkB0sDRil9bzKlgZYMEr69mORM09GsgOJrjVcKYkGuOlY+/iLfa
	 jRH3aaa3JjCHw==
Date: Wed, 16 Sep 2026 23:53:49 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: haghdoost@uber.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Andrii Nakryiko <andriin@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] perf script: Add --max-symbol-bytes to bound ELF
 symbol memory
Message-ID: <aquOfdBVYlr1QE8Z@z2>
References: <20260915-perf-symbol-memory-send-v1-0-1d3360e21f07@uber.com>
 <20260915-perf-symbol-memory-send-v1-2-1d3360e21f07@uber.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260915-perf-symbol-memory-send-v1-2-1d3360e21f07@uber.com>

On Tue, Sep 15, 2026 at 11:42:44AM -0700, Alireza Haghdoost via B4 Relay wrote:
> From: Alireza Haghdoost <haghdoost@uber.com>
> 
> perf script eagerly materializes every ELF symbol into an rb-tree kept
> until process exit. Large profiles can therefore consume substantial
> anonymous memory, causing perf script to be OOM-killed or forcing the
> kernel to reclaim memory from co-located workloads.

It's not only for perf script.  Other commands like perf report and perf
annotate would have the same issue.

> 
> This patch adds --max-symbol-bytes to bound struct symbol allocations.
> Once the budget is reached, the ELF loader stops loading symbols, warns
> once, and lets unresolved addresses appear as [unknown].
> This allows users to bound the memory footprint upfront and explicitly
> choose between complete symbolization and avoiding unbounded host memory
> pressure. perf record already provides a similar --max-size option to
> bound disk usage.

Please add documentation when you add a new command line option.

> 
> The counter includes every symbol__new() allocation, but this patch
> enforces the limit only in the ELF loader, which is the source of the
> unbounded memory growth addressed here. In this path, reaching the limit
> can safely produce [unknown] symbols. Other loaders currently treat a
> failed symbol allocation as an error. Capping those paths would therefore
> require separate changes whose complexity may outweigh the potential
> memory savings.

What's the other loaders you meant?

I don't see it produces [unknown] symbols.  Do you mean it just stops
loading symbols when it hits the limit?

> 
> Sizes require a B/K/M/G suffix. Zero, the default, means unlimited.
> 
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>
> Assisted-by: Kimi:K3
> ---
>  tools/perf/builtin-script.c   | 31 +++++++++++++++++++++++++++++++
>  tools/perf/util/symbol-elf.c  |  7 +++++++
>  tools/perf/util/symbol.c      | 29 +++++++++++++++++++++++++++--
>  tools/perf/util/symbol.h      |  3 +++
>  tools/perf/util/symbol_conf.h |  1 +
>  5 files changed, 69 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index ad8ca08ceb5f..50fa6ca6455a 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -68,6 +68,7 @@
>  #include "util/thread.h"
>  #include "util/thread_map.h"
>  #include "util/time-utils.h"
> +#include "util/units.h"
>  #include "util/tool.h"
>  #include "util/trace-event.h"
>  #include "util/unwind.h"
> @@ -4035,6 +4036,33 @@ static int parse_callret_trace(const struct option *opt __maybe_unused,
>  	return 0;
>  }
>  
> +static int parse_max_symbol_bytes(const struct option *opt,
> +				  const char *str, int unset)
> +{
> +	unsigned long *max_bytes = (unsigned long *)opt->value;
> +	static struct parse_tag size_tags[] = {
> +		{ .tag  = 'B', .mult = 1       },
> +		{ .tag  = 'K', .mult = 1 << 10 },
> +		{ .tag  = 'M', .mult = 1 << 20 },
> +		{ .tag  = 'G', .mult = 1 << 30 },
> +		{ .tag  = 0 },
> +	};
> +	unsigned long bytes;
> +
> +	if (unset) {
> +		*max_bytes = 0;
> +		return 0;
> +	}
> +
> +	bytes = parse_tag_value(str, size_tags);
> +	if (bytes != (unsigned long)-1) {
> +		*max_bytes = bytes;
> +		return 0;
> +	}
> +
> +	return -1;
> +}
> +
>  int cmd_script(int argc, const char **argv)
>  {
>  	bool show_full_info = false;
> @@ -4135,6 +4163,9 @@ int cmd_script(int argc, const char **argv)
>  		     "Set the maximum stack depth when parsing the callchain, "
>  		     "anything beyond the specified depth will be ignored. "
>  		     "Default: kernel.perf_event_max_stack or " __stringify(PERF_MAX_STACK_DEPTH)),
> +	OPT_CALLBACK(0, "max-symbol-bytes", &symbol_conf.max_symbol_bytes,
> +		     "size", "Limit bytes for ELF struct symbol (e.g. 128M; 0=unlimited)",
> +		     parse_max_symbol_bytes),
>  	OPT_BOOLEAN(0, "reltime", &reltime, "Show time stamps relative to start"),
>  	OPT_BOOLEAN(0, "deltatime", &deltatime, "Show time stamps relative to previous event"),
>  	OPT_BOOLEAN('I', "show-info", &show_full_info,
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index e955c3feddcd..914e42d21f70 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1634,6 +1634,13 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>  		int is_label = elf_sym__is_label(&sym);
>  		const char *section_name;
>  		bool used_opd = false;

Please keep a blank line after declaration.


> +		if (symbol_conf.max_symbol_bytes &&
> +		    symbol__bytes_used() >= symbol_conf.max_symbol_bytes) {
> +			pr_warning_once("perf: symbol memory budget exceeded (%lu bytes), "
> +					"remaining symbols will be [unknown]\n",
> +					symbol_conf.max_symbol_bytes);
> +			break;
> +		}
>  
>  		if (!is_label && !elf_sym__filter(&sym))
>  			continue;
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 3587ad243159..62a4f91c2f5d 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -310,14 +310,35 @@ void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms)
>  		curr->end = roundup(curr->start, 4096) + 4096;
>  }
>  
> +static size_t symbol_bytes_used;
> +
> +size_t symbol__bytes_used(void)
> +{
> +	return symbol_bytes_used;
> +}
> +
> +void symbol__account_bytes(size_t bytes)
> +{
> +	symbol_bytes_used += bytes;
> +}
> +
> +void symbol__unaccount_bytes(size_t bytes)
> +{
> +	symbol_bytes_used -= bytes;
> +}
> +
>  struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, const char *name)
>  {
>  	size_t namelen = strlen(name) + 1;
> -	struct symbol *sym = calloc(1, (symbol_conf.priv_size +
> -					sizeof(*sym) + namelen));
> +	size_t alloc_size = symbol_conf.priv_size + sizeof(struct symbol) + namelen;

The convention is 'sizeof(*sym)' rather than 'sizeof(struct symbol)'.
So that it can easily handle type changes in the future.


> +	struct symbol *sym;
> +
> +	sym = calloc(1, alloc_size);
>  	if (sym == NULL)
>  		return NULL;
>  
> +	symbol__account_bytes(alloc_size);
> +
>  	if (symbol_conf.priv_size) {
>  		if (symbol_conf.init_annotation) {
>  			struct annotation *notes = (void *)sym;
> @@ -341,6 +362,9 @@ struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, const char *
>  
>  void symbol__delete(struct symbol *sym)
>  {
> +	size_t alloc_size = symbol_conf.priv_size + sizeof(struct symbol) +
> +			    sym->namelen + 1;

Ditto.

Thanks,
Namhyung

> +
>  	if (symbol_conf.priv_size) {
>  		if (symbol_conf.init_annotation) {
>  			struct annotation *notes = symbol__annotation(sym);
> @@ -348,6 +372,7 @@ void symbol__delete(struct symbol *sym)
>  			annotation__exit(notes);
>  		}
>  	}
> +	symbol__unaccount_bytes(alloc_size);
>  	free(((void *)sym) - symbol_conf.priv_size);
>  }
>  
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index e5cef16b240d..0d5d3792aac1 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -228,6 +228,9 @@ void symbol__elf_init(void);
>  int symbol__annotation_init(void);
>  
>  struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, const char *name);
> +size_t symbol__bytes_used(void);
> +void symbol__account_bytes(size_t bytes);
> +void symbol__unaccount_bytes(size_t bytes);
>  size_t __symbol__fprintf_symname_offs(const struct symbol *sym,
>  				      const struct addr_location *al,
>  				      bool unknown_as_addr,
> diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
> index 71f60081a85b..6a16c5badd5e 100644
> --- a/tools/perf/util/symbol_conf.h
> +++ b/tools/perf/util/symbol_conf.h
> @@ -120,6 +120,7 @@ struct symbol_conf {
>  	int		pad_output_len_dso;
>  	int		group_sort_idx;
>  	int		addr_range;
> +	unsigned long	max_symbol_bytes;
>  	DECLARE_BITMAP(parallelism_filter, MAX_NR_CPUS + 1);
>  };
>  
> 
> -- 
> Git-155)
> 
> 
