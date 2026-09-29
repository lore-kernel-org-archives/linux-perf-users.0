Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F6D3D79EF;
	Tue, 29 Sep 2026 17:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790704546; cv=none; b=by+pbyxfn30TuvokMe9QFgUsqbmlGQoxvzVsLAXgfZiZ5w9RG6uS1tUGY/YTvinHGdyIqtS/8tNUfzvIFACmQhWOTRIboUTBiVOAdSQmEI69c6zigMxxnTnzyOTst3/Un4HMQi8gOCimNUmroahOV8HXFyaNzlGZIKNGO241Fko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790704546; c=relaxed/simple;
	bh=+5/gGRV7+bGWeSytasPJm7958J+AlMlcFBbxYc3p9tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/xp0fB7JNhE3aM6UBa9KVLKqHP4QYQZOO2cFLnCcSi1IllQ7NsfUnz22aURm0ZuI6gFuDKWN9IkYXSoIrHKLS3pIuRoXIvuL59NnrV4BMFLg+dnyvR/tYdhrWxzn4x0q6lm0hxQc4kRRheavpCHuRdAlezZVGmOkp+pgQ/RN2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+5NUFCE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+5NUFCE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A9D1F000FF;
	Tue, 29 Sep 2026 17:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790704544;
	bh=esfF9Qz0gETSR4upswG9db8Y42cHzlo/5RJP4FmP8yI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U+5NUFCEu8DrAr9wwZHB/QpcsYdQJFbhESZMaqc1hOroY49YA7AkNF3hYpBHh4v+y
	 /QjOk6nOZP7dW42cWr9H3S2zmq8QFwDBugwrjfqXncX9WcL80YqQFY4nRzG4PFERXr
	 W6OoGZQVglXnVgVkgiz3Mg785FH9S1DjxiFkScC82RelYmaPdTGMFSBeu7XA1FY5Qm
	 dMW3JNf3yMSI70n8JrMhcql8kZYlDjYwTB3wvxLnUUYQ+aoeQfYUKpWi21H50SFDKB
	 fmE54YCY0cglzHo2NQxZh5nDxG45I+iKUL9GcDTMz5XKxMHtPURuXZfwARVERb6LsC
	 MuZlga2nNwKpQ==
Date: Tue, 29 Sep 2026 10:55:40 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: haghdoost@uber.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf symbols: Don't let a module's last symbol overlap
 the next module
Message-ID: <arv7nGmcDGjt7p7K@google.com>
References: <20260928-haghdoost-perf-symbols-fixup-module-end-v1-1-0a70d1edd401@uber.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260928-haghdoost-perf-symbols-fixup-module-end-v1-1-0a70d1edd401@uber.com>

On Mon, Sep 28, 2026 at 04:32:27PM -0700, Alireza Haghdoost via B4 Relay wrote:
> From: Alireza Haghdoost <haghdoost@uber.com>
> 
> symbols__fixup_end() extends a zero-size symbol that is the last one in
> the kernel or in a module to the end of the next page. On x86 the next
> module can start in that page, so the stretched symbol overlaps it, and
> a lookup can return the wrong symbol. For example:
> 
>   ffffffffc0c4aa50 t dca_sysfs_exit    [dca]
>   ffffffffc0c4b000 t __nft_trace_packet [nf_tables]
>   ffffffffc0c4b0b0 t nft_do_chain      [nf_tables]
> 
> dca_sysfs_exit gets end 0xffffffffc0c4c000, and samples in nft_do_chain
> are reported as dca_sysfs_exit.
> 
> This patch clamps the end to the next symbol's start. The ARM case this
> code was added for, where the next module is far away, is unchanged.
> 
> Add a "Kallsyms symbol ends" test case to the Symbols suite that covers
> the kernel/module boundary, adjacent modules and a distant module.
> 
> Fixes: 8799ebce84d6 ("perf symbol: Update symbols__fixup_end()")
> Fixes: bacefe0c7b77 ("perf tools: Fixup module symbol end address properly")
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/symbol.c   |  4 ++
>  tools/perf/tests/symbols.c | 96 +++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 99 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 163652f071c6f..f0a7f5a30e696 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -302,6 +302,10 @@ void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms)
>  			else
>  				prev->end = curr->start;
>  
> +			/* The next module can start within that page */
> +			if (prev->end > curr->start)
> +				prev->end = curr->start;
> +
>  			pr_debug4("%s sym:%s end:%#" PRIx64 "\n",
>  				  __func__, prev->name, prev->end);
>  		}
> diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
> index c09e04f36035a..b644d95c6be9a 100644
> --- a/tools/perf/tests/symbols.c
> +++ b/tools/perf/tests/symbols.c
> @@ -2,6 +2,7 @@
>  #include <linux/compiler.h>
>  #include <linux/string.h>
>  #include <sys/mman.h>
> +#include <inttypes.h>
>  #include <limits.h>
>  #include "debug.h"
>  #include "dso.h"
> @@ -223,4 +224,97 @@ static int test__symbols(struct test_suite *test __maybe_unused, int subtest __m
>  	return ret;
>  }
>  
> -DEFINE_SUITE("Symbols", symbols);
> +struct kallsyms_sym {
> +	u64 start;
> +	const char *name;
> +};
> +
> +/*
> + * kallsyms from an x86 host where nf_tables was loaded in the page right
> + * after the last symbol of dca, plus a kernel symbol followed closely by a
> + * module and a module far away from the others.
> + */
> +static const struct kallsyms_sym kallsyms_syms[] = {
> +	{ 0xffffffff81000000, "_stext" },
> +	{ 0xffffffff81000ff0, "last_kernel_symbol" },
> +	{ 0xffffffff81001000, "near_module_symbol\t[near]" },
> +	{ 0xffffffffc0c4aa40, "dca_exit\t[dca]" },
> +	{ 0xffffffffc0c4aa50, "dca_sysfs_exit\t[dca]" },
> +	{ 0xffffffffc0c4b000, "__nft_trace_packet\t[nf_tables]" },
> +	{ 0xffffffffc0c4b0b0, "nft_do_chain\t[nf_tables]" },
> +	{ 0xffffffffc0c4b4e0, "nf_tables_core_module_exit\t[nf_tables]" },
> +	{ 0xffffffffc2000000, "far_module_symbol\t[far]" },
> +};
> +
> +static int check_symbol(struct dso *dso, u64 addr, const char *name, u64 end)
> +{
> +	struct symbol *sym = dso__find_symbol_nocache(dso, addr);
> +
> +	if (!sym || strcmp(sym->name, name)) {
> +		pr_debug("%#" PRIx64 ": expected %s, got %s\n", addr, name,
> +			 sym ? sym->name : "no symbol");
> +		return TEST_FAIL;
> +	}
> +	if (sym->end != end) {
> +		pr_debug("%s: expected end %#" PRIx64 ", got %#" PRIx64 "\n",
> +			 name, end, sym->end);
> +		return TEST_FAIL;
> +	}
> +	return TEST_OK;
> +}
> +
> +static int test__kallsyms_fixup_end(struct test_suite *test __maybe_unused,
> +				    int subtest __maybe_unused)
> +{
> +	struct dso *dso = dso__new("[kernel.kallsyms]");
> +	int ret = TEST_FAIL;
> +
> +	if (!dso)
> +		return TEST_FAIL;
> +
> +	for (unsigned int i = 0; i < ARRAY_SIZE(kallsyms_syms); i++) {
> +		struct symbol *sym = symbol__new(kallsyms_syms[i].start, 0, 0, 0,
> +						 kallsyms_syms[i].name);
> +
> +		if (!sym)
> +			goto out;
> +		symbols__insert(dso__symbols(dso), sym);
> +	}
> +
> +	symbols__fixup_end(dso__symbols(dso), true);
> +
> +	ret = TEST_OK;
> +	/* The next symbol is too close for the end of the page. */
> +	if (check_symbol(dso, 0xffffffff81000ff8, "last_kernel_symbol",
> +			 0xffffffff81001000))
> +		ret = TEST_FAIL;
> +	if (check_symbol(dso, 0xffffffffc0c4aa58, "dca_sysfs_exit\t[dca]",
> +			 0xffffffffc0c4b000))
> +		ret = TEST_FAIL;
> +	if (check_symbol(dso, 0xffffffffc0c4b280, "nft_do_chain\t[nf_tables]",
> +			 0xffffffffc0c4b4e0))
> +		ret = TEST_FAIL;
> +
> +	/* Far from the next module, the end of the page is still used. */
> +	if (check_symbol(dso, 0xffffffffc0c4b4f0,
> +			 "nf_tables_core_module_exit\t[nf_tables]",
> +			 0xffffffffc0c4d000))
> +		ret = TEST_FAIL;
> +	if (check_symbol(dso, 0xffffffff81001008, "near_module_symbol\t[near]",
> +			 0xffffffff81002000))
> +		ret = TEST_FAIL;
> +out:
> +	dso__put(dso);
> +	return ret;
> +}
> +
> +static struct test_case tests__symbols[] = {
> +	TEST_CASE("Symbols", symbols),
> +	TEST_CASE("Kallsyms symbol ends", kallsyms_fixup_end),
> +	{ .name = NULL, }
> +};
> +
> +struct test_suite suite__symbols = {
> +	.desc = "Symbols",
> +	.test_cases = tests__symbols,
> +};
> 
> ---
> base-commit: 0ae6fc78c5ce0dfd18d8712a50f0fd4602eff103
> change-id: 20260928-haghdoost-perf-symbols-fixup-module-end-11ce6858f0c4
> 
> Best regards,
> --  
> Alireza Haghdoost <haghdoost@uber.com>
> 
> 
