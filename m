Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792698696;
	b=Bu9v7huXbrOR0F3t4DS0B1QdZeLRzAWtRkWQakMs8fP7cgu7++1BgHUqPvJwabm5RB/y
	 GtdL9mC/1t+NXgHot40vWJBCjDQ1QUcEbjsKZOMUfQRVjQ+8a3pPWKFFC75CyuEESP3UX
	 cE+ktUYhovS1JhTKF5A11fqaNP0iataL29XA89kK922mGwZc4ss2YFxj4S4AGyUFQgJ89
	 12NpXf/EcZq/xAvzqSYSRiQ8mwD7nIstlNBEv2sj5MlyClB+SfeiUETGbWqMovg5Jc3dW
	 gfZ4kNjVpEl/e36MjSxD6t1P3HlSSjIffeaKLyd98iVjYxHofzPd6dJ/k9ZkMwnz+LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792698696;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=IH0Ra0nr8PaH4LOAX8h5ymZ7Q+uvoWAsFcMW2TU0Dos=;
	b=U/zvTq8sk1HxmXPr65Bsx+FSm3o/87G1fUqg9ZdIdWdXAUOlqM/il2TEOWVmJf8m3TRA
	 Gr4AbILkhCNu/T96uLMD42U+L7gxl1gaRIz5ASQOSnUh+5Di+oAF5Rzoys6aUGH+mfLuU
	 nNtBaWQUjd3QyiaIJGzeqxBap2C1lm8+8wuyCoh+6s8W6nV96ujub4bpJhs0kksy6oUO7
	 a+jbFv7GSRF1T8hIzFQspLXmc0ADxQS40qim6B4LG/NxV3I7iX212fY1uHx/Ae15kKchv
	 pFmChiOkATNEjVNe9lIcF1vdeBsHGGOAPZPPzIWXzMmbmzM5Jk7JgKKHBpJjsc+FPEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KNjxQvRr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C92D606A319;
	Thu, 22 Oct 2026 19:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KNjxQvRr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E4C1F01825;
	Thu, 22 Oct 2026 19:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792698695;
	bh=IH0Ra0nr8PaH4LOAX8h5ymZ7Q+uvoWAsFcMW2TU0Dos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KNjxQvRrZjQXjq7oiaVr7km17P6Db8QZ+Y2j7DY00HmG0ziWTQy8riDUBdnXW2EUb
	 q5/b8o2UoVJOQsxJnozUFW3vQD2s2/Pk635XiQJcJFBdiO2nNsqFxci+X3pXUdGx3l
	 lOXV9TMSpfAvxF97b06fjiPEb6tI8OTXmMG29tZWz+XLRzz0gIPBOrOCtYLMP7yyhu
	 NYO6p92tytWaQQ925A7ZrmWu6IQQq/ruXM2if/xR0QSdXX6F04tHs/zMvWPR9xdWQo
	 w7BMB6CO/FiNY2BbFA5MoNAvYD7/Sd8Hd5z7fSYxqeCy+hvjANSwkBvqIel/HXI3Ic
	 e7mDa8sQ3sQIA==
Date: Thu, 22 Oct 2026 12:51:34 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v9 2/6] perf ftrace: Support filtering
 return address comments
Message-ID: <atppRvpvPrm12_Z6@google.com>
References: <20261021023337.809936-1-atomlin@atomlin.com>
 <20261021023337.809936-3-atomlin@atomlin.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261021023337.809936-3-atomlin@atomlin.com>

Hello,

On Tue, Oct 20, 2026 at 10:33:33PM -0400, Aaron Tomlin wrote:
> When tracing with the Linux kernel's function graph tracer, enabling
> funcgraph-retaddr records the return address of each function entry as
> a comment in the trace stream (e.g. /* <-load_elf_phdrs+0x6c/0xb0 */).
> While valuable for tracing execution origins, these trailing comments
> can add considerable visual clutter to the call graph, particularly
> when examining deeply nested call trees or when synthesising higher-level
> abstractions.
> 
> Introduce support for filtering out return address comments from
> function graph trace output. Provide a standalone --filter-retaddr
> flag.

I think we agreed not to have this option in the previous discussion,
no?  The retaddr will appear only if user passed an option, so you can
unconditionally filter out the comment if it's not given, right?

Thanks,
Namhyung

> 
> Key aspects of this implementation:
> 
>     1.  Return address parsing and filtering
> 
>         Implement ftrace_filter_retaddr() in tools/perf/util/ftrace.c
>         to locate return address comments and strip them in-place with
>         memmove(3).
> 
>         Additionally, introduce ftrace_parse_retaddr() to parse caller
>         symbol names and offsets across diverse output styles (standard
>         format, return values, and bracketed addresses), establishing
>         the parsing foundation for subsequent inlined callchain
>         resolution.
> 
>     2.  Command-line interface
> 
>         Expose --filter-retaddr in tools/perf/builtin-ftrace.c, updating
>         the documentation in tools/perf/Documentation/perf-ftrace.txt
>         accordingly.
> 
>     3.  Automated verification
> 
>         Add a dedicated unit test suite ("Ftrace return address
>         processing") in tools/perf/tests/ftrace.c to validate comment
>         parsing and string filtering across all supported formats.
> 
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  tools/perf/Documentation/perf-ftrace.txt |  4 +
>  tools/perf/builtin-ftrace.c              |  8 ++
>  tools/perf/tests/Build                   |  1 +
>  tools/perf/tests/builtin-test.c          |  1 +
>  tools/perf/tests/ftrace.c                | 81 +++++++++++++++++++++
>  tools/perf/tests/tests.h                 |  1 +
>  tools/perf/util/Build                    |  1 +
>  tools/perf/util/ftrace.c                 | 93 ++++++++++++++++++++++++
>  tools/perf/util/ftrace.h                 |  5 ++
>  9 files changed, 195 insertions(+)
>  create mode 100644 tools/perf/tests/ftrace.c
>  create mode 100644 tools/perf/util/ftrace.c
> 
> diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> index 3f3808e513fe..e8105083e67c 100644
> --- a/tools/perf/Documentation/perf-ftrace.txt
> +++ b/tools/perf/Documentation/perf-ftrace.txt
> @@ -134,6 +134,10 @@ OPTIONS for 'perf ftrace trace'
>  	  - depth=<n>    - Set max depth for function graph tracer to follow.
>  	  - tail         - Print function name at the end.
>  
> +--filter-retaddr::
> +	Filter out function return address comments (`/* <-caller+offset */`)
> +	from function_graph output.
> +
>  
>  OPTIONS for 'perf ftrace latency'
>  ---------------------------------
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 65983259b07e..c715cbebaabe 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -837,6 +837,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>  				break;
>  			for (int i = 0; i < n; i++) {
>  				if (buf[i] == '\n') {
> +					if (ftrace->filter_retaddr)
> +						ftrace_filter_retaddr(linebuf.buf);
>  					if (fprintf(stdout, "%s\n", linebuf.buf) < 0)
>  						break;
>  					strbuf_setlen(&linebuf, 0);
> @@ -874,6 +876,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>  			break;
>  		for (int i = 0; i < n; i++) {
>  			if (buf[i] == '\n') {
> +				if (ftrace->filter_retaddr)
> +					ftrace_filter_retaddr(linebuf.buf);
>  				if (fprintf(stdout, "%s\n", linebuf.buf) < 0)
>  					break;
>  				strbuf_setlen(&linebuf, 0);
> @@ -885,6 +889,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>  	}
>  
>  	if (!ferror(stdout) && linebuf.len > 0) {
> +		if (ftrace->filter_retaddr)
> +			ftrace_filter_retaddr(linebuf.buf);
>  		fprintf(stdout, "%s\n", linebuf.buf);
>  		strbuf_setlen(&linebuf, 0);
>  	}
> @@ -1850,6 +1856,8 @@ int cmd_ftrace(int argc, const char **argv)
>  		     "Size of per cpu buffer, needs to use a B, K, M or G suffix.", parse_buffer_size),
>  	OPT_BOOLEAN(0, "inherit", &ftrace.inherit,
>  		    "Trace children processes"),
> +	OPT_BOOLEAN_SET(0, "filter-retaddr", &ftrace.filter_retaddr, &ftrace.filter_retaddr_set,
> +			"Filter out funcgraph return address comments"),
>  	OPT_INTEGER('D', "delay", &ftrace.target.initial_delay,
>  		    "Number of milliseconds to wait before starting tracing after program start"),
>  	OPT_PARENT(common_options),
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 395f2866094a..136138932fcb 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -72,6 +72,7 @@ perf-test-y += hwmon_pmu.o
>  perf-test-y += tool_pmu.o
>  perf-test-y += subcmd-help.o
>  perf-test-y += kallsyms-split.o
> +perf-test-y += ftrace.o
>  
>  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc riscv))
>  perf-test-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 880eece0bc12..640d6d327215 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -156,6 +156,7 @@ static struct test_suite *generic_tests[] = {
>  	&suite__perf_hooks,
>  	&suite__unit_number__scnprint,
>  	&suite__mem2node,
> +	&suite__ftrace,
>  	&suite__time_utils,
>  	&suite__jit_write_elf,
>  	&suite__pfm,
> diff --git a/tools/perf/tests/ftrace.c b/tools/perf/tests/ftrace.c
> new file mode 100644
> index 000000000000..42604811a2fb
> --- /dev/null
> +++ b/tools/perf/tests/ftrace.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/compiler.h>
> +#include <linux/kernel.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include "tests.h"
> +#include "debug.h"
> +#include "util/ftrace.h"
> +
> +static int test_parse_retaddr(void)
> +{
> +	char sym[128];
> +	u64 offset = 0;
> +
> +	/* Standard format */
> +	TEST_ASSERT_VAL("parse standard retaddr",
> +			ftrace_parse_retaddr("kernel_read() { /* <-load_elf_phdrs+0x6c/0xb0 */",
> +					     sym, sizeof(sym), &offset));
> +	TEST_ASSERT_EQUAL("sym name", strcmp(sym, "load_elf_phdrs"), 0);
> +	TEST_ASSERT_VAL("offset", offset == 0x6c);
> +
> +	/* With return value */
> +	TEST_ASSERT_VAL("parse retaddr with ret",
> +			ftrace_parse_retaddr(
> +				"__cond_resched(); /* <-load_elf_phdrs+0x6c/0xb0 ret=0x0 */",
> +				sym, sizeof(sym), &offset));
> +	TEST_ASSERT_EQUAL("sym name", strcmp(sym, "load_elf_phdrs"), 0);
> +	TEST_ASSERT_VAL("offset", offset == 0x6c);
> +
> +	/* Bracketed address */
> +	TEST_ASSERT_VAL("parse bracketed retaddr",
> +			ftrace_parse_retaddr("foo() { /* <-[0xffffffff818534c8] bar+0x20/0x40 */",
> +					     sym, sizeof(sym), &offset));
> +	TEST_ASSERT_EQUAL("sym name", strcmp(sym, "bar"), 0);
> +	TEST_ASSERT_VAL("offset", offset == 0x20);
> +
> +	/* No return address */
> +	TEST_ASSERT_VAL("no retaddr",
> +			!ftrace_parse_retaddr("do_filp_open();", sym, sizeof(sym), &offset));
> +
> +	return TEST_OK;
> +}
> +
> +static int test_filter_retaddr(void)
> +{
> +	char line1[] = "kernel_read() { /* <-load_elf_phdrs+0x6c/0xb0 */";
> +	char line2[] = "__cond_resched(); /* <-load_elf_phdrs+0x6c/0xb0 ret=0x0 */";
> +	char line3[] = "do_filp_open();";
> +
> +	ftrace_filter_retaddr(line1);
> +	TEST_ASSERT_EQUAL("filter standard retaddr", strcmp(line1, "kernel_read() {"), 0);
> +
> +	ftrace_filter_retaddr(line2);
> +	TEST_ASSERT_EQUAL("filter retaddr with ret",
> +			  strcmp(line2, "__cond_resched(); /* ret=0x0 */"), 0);
> +
> +	ftrace_filter_retaddr(line3);
> +	TEST_ASSERT_EQUAL("filter line without retaddr unchanged",
> +			  strcmp(line3, "do_filp_open();"), 0);
> +
> +	return TEST_OK;
> +}
> +
> +static int test__ftrace(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
> +{
> +	int ret;
> +
> +	ret = test_parse_retaddr();
> +	if (ret != TEST_OK)
> +		return ret;
> +
> +	ret = test_filter_retaddr();
> +	if (ret != TEST_OK)
> +		return ret;
> +
> +	return TEST_OK;
> +}
> +
> +DEFINE_SUITE("Ftrace return address processing", ftrace);
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index 5982c4e62cd3..cd12ae85ccfa 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -180,6 +180,7 @@ DECLARE_SUITE(perf_hooks);
>  DECLARE_SUITE(unit_number__scnprint);
>  DECLARE_SUITE(mem2node);
>  DECLARE_SUITE(maps);
> +DECLARE_SUITE(ftrace);
>  DECLARE_SUITE(time_utils);
>  DECLARE_SUITE(jit_write_elf);
>  DECLARE_SUITE(api_io);
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 2c1f880c4c47..5b082d09006d 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -169,6 +169,7 @@ perf-util-y += list_sort.o
>  perf-util-y += mutex.o
>  perf-util-y += sharded_mutex.o
>  perf-util-y += intel-tpebs.o
> +perf-util-y += ftrace.o
>  
>  perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_counter.o
>  perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_counter_cgroup.o
> diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
> new file mode 100644
> index 000000000000..452231c01568
> --- /dev/null
> +++ b/tools/perf/util/ftrace.c
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/compiler.h>
> +#include <linux/kernel.h>
> +#include <linux/string.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <ctype.h>
> +#include "util/ftrace.h"
> +
> +/**
> + * ftrace_parse_retaddr - Parse return address comment from trace line
> + * @str: The trace line containing the comment
> + * @sym_name: Buffer to store the parsed symbol name
> + * @sym_len: Length of the @sym_name buffer
> + * @offset: Pointer to store the parsed offset
> + *
> + * Extract the function name and offset from a funcgraph-retaddr comment
> + * (e.g. "<-load_elf_phdrs+0x6c/0xb0").
> + *
> + * Return: true if successfully parsed, false otherwise.
> + */
> +bool ftrace_parse_retaddr(const char *str, char *sym_name, size_t sym_len, u64 *offset)
> +{
> +	const char *p = strstr(str, "<-");
> +	const char *plus;
> +	const char *bracket;
> +	size_t name_len;
> +
> +	if (!p)
> +		return false;
> +
> +	p += 2;
> +	while (*p == ' ')
> +		p++;
> +
> +	if (*p == '[') {
> +		bracket = strchr(p, ']');
> +		if (bracket)
> +			p = bracket + 1;
> +		while (*p == ' ')
> +			p++;
> +	}
> +
> +	plus = strchr(p, '+');
> +	if (!plus)
> +		return false;
> +
> +	name_len = plus - p;
> +	if (name_len == 0 || name_len >= sym_len)
> +		return false;
> +
> +	memcpy(sym_name, p, name_len);
> +	sym_name[name_len] = '\0';
> +
> +	*offset = strtoull(plus + 1, NULL, 16);
> +	return true;
> +}
> +
> +/**
> + * ftrace_filter_retaddr - Remove return address comment from trace line
> + * @str: The trace line to modify
> + *
> + * Find and strip the funcgraph-retaddr comment from the trace line
> + * in-place, removing trailing spaces where applicable.
> + */
> +void ftrace_filter_retaddr(char *str)
> +{
> +	char *start = strstr(str, "/* <-");
> +	char *end;
> +	char *ret_ptr;
> +
> +	if (!start)
> +		return;
> +
> +	end = strstr(start, "*/");
> +	if (!end)
> +		return;
> +
> +	ret_ptr = strstr(start, " ret=");
> +	if (ret_ptr && ret_ptr < end) {
> +		memmove(start + 3, ret_ptr + 1, strlen(ret_ptr + 1) + 1);
> +		return;
> +	}
> +
> +	end += 2; /* skip end-of-comment delimiter */
> +
> +	/* Also backtrack any spaces before comment */
> +	while (start > str && *(start - 1) == ' ')
> +		start--;
> +
> +	memmove(start, end, strlen(end) + 1);
> +}
> diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
> index 950f2efafad2..50216d3fef64 100644
> --- a/tools/perf/util/ftrace.h
> +++ b/tools/perf/util/ftrace.h
> @@ -39,6 +39,8 @@ struct perf_ftrace {
>  	int			graph_verbose;
>  	int			graph_thresh;
>  	int			graph_tail;
> +	bool			filter_retaddr;
> +	bool			filter_retaddr_set;
>  };
>  
>  struct filter_entry {
> @@ -93,4 +95,7 @@ perf_ftrace__latency_cleanup_bpf(struct perf_ftrace *ftrace __maybe_unused)
>  
>  #endif  /* HAVE_BPF_SKEL */
>  
> +bool ftrace_parse_retaddr(const char *str, char *sym_name, size_t sym_len, u64 *offset);
> +void ftrace_filter_retaddr(char *str);
> +
>  #endif  /* __PERF_FTRACE_H__ */
> -- 
> 2.55.0
> 
