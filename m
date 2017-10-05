From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v4 03/15] perf util: refactor inline_list to operate on
 symbols
Date: Thu, 5 Oct 2017 10:56:13 +0900
Message-ID: <20171005015613.GA19141@danjae.aot.lge.com>
References: <20171001143100.19988-1-milian.wolff@kdab.com>
 <20171001143100.19988-4-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:52460 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbdJEB6Y (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 4 Oct 2017 21:58:24 -0400
Content-Disposition: inline
In-Reply-To: <20171001143100.19988-4-milian.wolff@kdab.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: acme@kernel.org, jolsa@kernel.org, Jin Yao <yao.jin@linux.intel.com>, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kernel-team@lge.com

Hi Milian,

On Sun, Oct 01, 2017 at 04:30:48PM +0200, Milian Wolff wrote:
> This is a requirement to create real callchain entries for inlined
> frames.
> 
> Since the list of inlines usually contains the target symbol too,
> i.e. the location where the frames get inlined to, we alias that
> symbol and reuse it as-is is. This ensures that other dependent
> functionality keeps working, most notably annotation of the
> target frames.
> 
> For all other entries in the inline_list, a fake symbol is created.
> These are marked by new 'inlined' member which is set to true. Only
> those symbols are managed by the inline_list and get freed when
> the inline_list is deleted from within inline_node__delete.
> 
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Yao Jin <yao.jin@linux.intel.com>
> Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> ---

[SNIP]

> +static struct symbol *new_inline_sym(struct dso *dso,
> +				     struct symbol *base_sym,
> +				     const char *funcname)
> +{
> +	struct symbol *inline_sym;
> +	char *demangled = NULL;
> +
> +	if (dso) {
> +		demangled = dso__demangle_sym(dso, 0, funcname);
> +		if (demangled)
> +			funcname = demangled;
> +	}
> +
> +	if (strcmp(funcname, base_sym->name) == 0) {

It seems you need to check availability of base_sym first as 'else'
statement below checks it.  Or if it's guaranteed not NULL (I think
you make it so later), remove the check (and add an assert?) instead.

Thanks,
Namhyung


> +		/* reuse the real, existing symbol */
> +		inline_sym = base_sym;
> +		/* ensure that we don't alias an inlined symbol, which could
> +		 * lead to double frees in inline_node__delete
> +		 */
> +		assert(!base_sym->inlined);
> +	} else {
> +		/* create a fake symbol for the inline frame */
> +		inline_sym = symbol__new(base_sym ? base_sym->start : 0,
> +					 base_sym ? base_sym->end : 0,
> +					 base_sym ? base_sym->binding : 0,
> +					 funcname);
> +		if (inline_sym)
> +			inline_sym->inlined = 1;
> +	}
> +
> +	free(demangled);
> +
> +	return inline_sym;
> +}
